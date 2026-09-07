#!/bin/bash


BASEURL=/root/bin/
FILENAME=reboot.txt
START=20
END=30
NET=192.168.10

echo "서버 목록 초기화"

> $BASEURL$FILENAME

for i in $(seq $START $END)
do

    ping -c 1 -W 1 $NET.$i > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[ OK ]  $NET.$i"
        echo "$NET.$i  root   soldesk1. " >> $BASEURL$FILENAME
    else
        echo "[ FAIL ] $NET.$i"
    fi
done

echo " 서버 목록 생성 완료 "
cat $BASEURL$FILENAME

echo " 리붓 시작 "

cat $BASEURL$FILENAME | while read HOST U_NAME U_PASS
do
	a() {
        sleep 3 ; echo "$U_NAME"
        sleep 1 ; echo "$U_PASS"
        sleep 1 ; echo 'hostname'
        sleep 1 ; echo 'id'
        sleep 1 ; echo 'reboot'
    }
    echo "=============================="
    echo "접속 시도: $HOST"
    a | telnet $HOST
done
        
