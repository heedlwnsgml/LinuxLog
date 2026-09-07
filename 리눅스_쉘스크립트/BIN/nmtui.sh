#!/bin/bash

# 임시 파일 설정
TEMP_FILE="/tmp/net_config.$$"

# 종료 시 임시 파일 삭제 및 화면 초기화
trap "rm -f $TEMP_FILE; clear" EXIT

# 폼 위젯 출력
dialog --title "Network Configuration" \
       --form "네트워크 설정을 입력하세요:" 15 50 0 \
       "IP Address (CIDR):" 1 1 "" 1 20 20 0 \
       "Gateway:"           2 1 "" 2 20 20 0 \
       "DNS Server:"        3 1 "" 3 20 20 0 \
       2> $TEMP_FILE

# 정상 입력(OK) 시 처리
if [ $? -eq 0 ]; then
    # 변수에 입력값 할당
    IP=$(sed -n '1p' $TEMP_FILE)
    GW=$(sed -n '2p' $TEMP_FILE)
    DNS=$(sed -n '3p' $TEMP_FILE)
    
    # 결과 메시지 출력
    dialog --title "Configuration Result" \
           --msgbox "다음 설정이 저장되었습니다.\n\nIP: $IP\nGW: $GW\nDNS: $DNS" 10 40
else
    # 취소(Cancel) 시 처리
    dialog --title "Canceled" --msgbox "설정이 취소되었습니다." 5 30
fi