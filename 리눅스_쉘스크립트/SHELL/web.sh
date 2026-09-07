if [ $# -ne 1 ]; then
    echo "Usage: $0 <server>"
    exit 1
fi
SERVER="$1"

# 서버가 alive 상태 확인
ping -c 1 -W 1 "$SERVER" >/dev/null 2>&1 \
    || exit 2

ssh -T "$SERVER" bash - <<'EOF'
    hostname && date
    echo "[ 잠시대기 ] 저스트 어 모먼트, 플리즈"
    # 패키지 설치
    dnf install -y -q httpd mod_ssl
    # 서비스 기동
    systemctl enable --now httpd
EOF

# 서비스 설정
scp WEB/index.html "$SERVER":/var/www/html/index.html >/dev/null 2>&1

# 서비스 확인
echo; echo
echo "[ INFO ] WEB 서버 접속 시작:"
curl http://$SERVER/

