#!/bin/bash
#1) 로그 1 (임시파일) 생성
#---------------------------
#2) 30초 후 로그2(임시파일) 생성
#3) 비교(로그1<-->로그2)
#   +---- 동일하다면 : 다시 점검 => continue
#   +---- 동일하지 않다면 : 관리자에게 메일 발송 후 로그1 초기화
#---------------------------- 

# 필수 패키지
dnf -y -q install postfix s-nail > /dev/null 2>&1\
    && echo "[   OK   ] 선수 패키지 "\
    || echo "[   FAIL  ] 선수 패키지 "

systemctl enable --now postfix

TMP1=/tmp/tmp1 #나중에는 TMP1=$(mktemp)
TMP2=/tmp/tmp2
TMP3=/tmp/tmp3
LOG=/var/log/messages
TIME=10
EMAIL='gokew49133@fanzher.com'
grep -E -i 'warn|fail|error|crit|alert|emerg' $LOG > $TMP1

while true
do

    sleep "$TIME"
    grep -E -i 'warn|fail|error|crit|alert|emerg' $LOG > $TMP2
    diff $TMP1 $TMP2 > $TMP3 && continue
    mailx -s "[WARN] Check Log" "$EMAIL" < $TMP3
    grep -E -i 'warn|fail|error|crit|alert|emerg' $LOG > $TMP1

done
