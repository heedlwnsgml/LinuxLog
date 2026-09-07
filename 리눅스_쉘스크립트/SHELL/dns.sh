#!/bin/bash

# 인자값 개수 확인
if [ $# -ne 4 ]; then
    echo "Usage: $0 <server> <serverip> <domain> <arpa domain>"
    echo "       (EX) $0 server1 192.168.10.20 example.com 10.168.192"
    exit 1
fi

SERVER=$1
SERVERIP=$2
DOMAIN=$3
ARPANET=$4
LASTIP=$(echo "$SERVERIP" | awk -F. '{print $4}')

# DNS 파일 생성 디렉토리 준비
BASEDIR=$HOME/bin/DNS
mkdir -p "$BASEDIR"

# /etc/named.conf 파일 생성
cat <<'EOF' > "$BASEDIR/named.conf"
options {
        listen-on port 53 { any; };
        directory       "/var/named";
        dump-file       "/var/named/data/cache_dump.db";
        statistics-file "/var/named/data/named_stats.txt";
        memstatistics-file "/var/named/data/named_mem_stats.txt";
        secroots-file   "/var/named/data/named.secroots";
        recursing-file  "/var/named/data/named.recursing";
        allow-query     { any; };
        recursion yes;
        dnssec-validation no;
        managed-keys-directory "/var/named/dynamic";
        geoip-directory "/usr/share/GeoIP";
        pid-file "/run/named/named.pid";
        session-keyfile "/run/named/session.key";
        include "/etc/crypto-policies/back-ends/bind.config";
            forwarders { 8.8.8.8; };
            forward only;
};
logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";
EOF

chown root:named "$BASEDIR/named.conf"
chmod 640 "$BASEDIR/named.conf"

# /etc/named.rfc1912.zones 파일 복사 및 추가
/bin/cp -f /etc/named.rfc1912.zones "$BASEDIR/named.rfc1912.zones"
cat <<'EOF' >> "$BASEDIR/named.rfc1912.zones"

zone "DOMAIN" IN {
     type master;
     file "DOMAIN.zone";
};

zone "ARPANET.in-addr.arpa"  IN {
     type master;
     file "DOMAIN.rev";
};
EOF

chown root:named "$BASEDIR/named.rfc1912.zones"
chmod 640 "$BASEDIR/named.rfc1912.zones"

# 정방향 영역(DOMAIN.zone) 파일 생성
cat <<'EOF' > "$BASEDIR/$DOMAIN.zone"
$TTL 4
@       IN SOA  DOMAIN. root.DOMAIN. (
                                        10      ; serial
                                        1D      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum

;; DNS Server
                     IN  NS      ns1
ns1                  IN  A       SERVERIP
EOF

chown root:named "$BASEDIR/$DOMAIN.zone"
chmod 640 "$BASEDIR/$DOMAIN.zone"

# 역방향 영역(DOMAIN.rev) 파일 생성
cat <<'EOF' > "$BASEDIR/$DOMAIN.rev"
$TTL 4
@       IN SOA  ns1.DOMAIN. root.DOMAIN. (
                                        10      ; serial
                                        1D      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum

;; DNS Server
                IN  NS          ns1.DOMAIN.
LASTIP          IN  PTR         ns1.DOMAIN.
EOF

chown root:named "$BASEDIR/$DOMAIN.rev"
chmod 640 "$BASEDIR/$DOMAIN.rev"

# 원격 서버 패키지 설치
ssh -T "$SERVER" dnf install -y -q bind bind-utils

# 설정 파일 전송
scp -p "$BASEDIR/named.conf" "$SERVER:/etc/named.conf"
scp -p "$BASEDIR/named.rfc1912.zones" "$SERVER:/etc/named.rfc1912.zones"
scp -p "$BASEDIR/$DOMAIN.zone" "$SERVER:/var/named/$DOMAIN.zone"
scp -p "$BASEDIR/$DOMAIN.rev" "$SERVER:/var/named/$DOMAIN.rev"

# 원격 서버 내부 설정 파일 치환 및 데몬 재시작
ssh -T "$SERVER" <<EOF
sed -i 's/DOMAIN/$DOMAIN/g' /etc/named.rfc1912.zones
sed -i 's/ARPANET/$ARPANET/g' /etc/named.rfc1912.zones

sed -i 's/DOMAIN/$DOMAIN/g' /var/named/$DOMAIN.zone
sed -i 's/SERVERIP/$SERVERIP/g' /var/named/$DOMAIN.zone
chown root:named /var/named/$DOMAIN.zone

sed -i 's/DOMAIN/$DOMAIN/g' /var/named/$DOMAIN.rev
sed -i 's/LASTIP/$LASTIP/g' /var/named/$DOMAIN.rev
chown root:named /var/named/$DOMAIN.rev

systemctl restart named
EOF

# 로컬 클라이언트 DNS 설정 및 확인
nmcli con modify eth0 ipv4.dns "$SERVERIP" +ipv4.dns 8.8.8.8
nmcli con up eth0

sleep 3

echo
echo "[ INFO ] DNS 서버에 DNS 쿼리 요청:"
nslookup ns1."$DOMAIN"
