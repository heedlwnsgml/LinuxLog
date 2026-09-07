#!/bin/bash

set -e

source $BASEDIR/functions.sh

# 서비스 설정
# 1) 텔넷 서비스
# 2) FTP 서비스 

#################################
# 1) 텔넷 서비스
#################################
Bar TELNET

# 패키지 설치 - telnet, telnet-server
StartMess "$PKG_TELNET"
dnf install -q -y $PKG_TELNET >/dev/null 2>&1

# 서비스 설정 - X

# 서비스 기동 - systemctl enable --now telnet.socket
SvcMess "$SVC_TELNET"
systemctl enable --now $SVC_TELNET >/dev/null 2>&1

# 방화벽 등록

# SELinux 설정



#################################
# 2) FTP 서비스 
#################################
Bar FTP

# 패키지 설치 - vsftpd, ftp
StartMess "$PKG_FTP"
dnf install -y -q $PKG_FTP > /dev/null 2>&1

# 서비스 설정 - /etc/vsftpd/{vsftpd.conf, ftpuser, user_list}
SvcConfMess "$SVC_FTP"
sed -i 's/^root//' /etc/vsftpd/ftpusers
sed -i 's/^root//' /etc/vsftpd/user_list

# 서비스 기동 - systemctl enable --now vsftpd.service
SvcMess "$SVC_FTP"
systemctl enable --now $SVC_FTP >/dev/null 2>&1


# 방화벽 등록


# SELinux 설정


