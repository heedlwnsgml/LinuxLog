#!/bin/bash

# 임시 파일 정의
TEMP_FILE="/tmp/tui_menu.$$"
FORM_FILE="/tmp/tui_form.$$"

# 종료 시 임시 파일 삭제 및 터미널 속성 초기화
trap "rm -f $TEMP_FILE $FORM_FILE; tput sgr0" EXIT

while true; do
    # 1. UI를 띄우기 전 대체 화면으로 전환 (현재 화면 저장)
    tput smcup
    
    dialog --title "System Configuration TUI" \
           --menu "원하는 작업을 선택하세요:" 15 50 4 \
           "1" "Web Server 설정 (web.sh)" \
           "2" "FTP Server 설정 (ftp.sh)" \
           "3" "DNS Server 설정 (dns.sh)" \
           "4" "종료" 2> $TEMP_FILE
           
    # 2. 메뉴 선택 후 원래 화면으로 복귀 (UI 사라짐)
    tput rmcup
    
    # 취소 선택 시 루프 종료
    if [ $? -ne 0 ]; then
        break
    fi
    
    CHOICE=$(cat $TEMP_FILE)
    
    case $CHOICE in
        1)
            tput smcup
            dialog --title "Web Server Configuration" \
                   --inputbox "대상 서버를 입력하세요:" 8 40 "server1" 2> $TEMP_FILE
            RET=$?
            tput rmcup
            
            if [ $RET -eq 0 ]; then
                SERVER=$(cat $TEMP_FILE)
                tput sgr0
                web.sh "$SERVER"
                echo
                read -p "엔터를 누르면 메뉴로 돌아갑니다..."
            fi
            ;;
        2)
            tput smcup
            dialog --title "FTP Server Configuration" \
                   --inputbox "대상 서버를 입력하세요:" 8 40 "server1" 2> $TEMP_FILE
            RET=$?
            tput rmcup
            
            if [ $RET -eq 0 ]; then
                SERVER=$(cat $TEMP_FILE)
                tput sgr0
                ftp.sh "$SERVER"
                echo
                read -p "엔터를 누르면 메뉴로 돌아갑니다..."
            fi
            ;;
        3)
            tput smcup
            dialog --title "DNS Server Configuration" \
                   --form "DNS 서버 설정을 확인 및 수정하세요:" 15 50 0 \
                   "Server Name:" 1 1 "server1"       1 15 20 0 \
                   "Server IP:"   2 1 "192.168.10.20" 2 15 20 0 \
                   "Domain:"      3 1 "example.com"   3 15 20 0 \
                   "ARPA Domain:" 4 1 "10.168.192"    4 15 20 0 \
                   2> $FORM_FILE
            RET=$?
            tput rmcup

            if [ $RET -eq 0 ]; then
                SERVER=$(sed -n '1p' $FORM_FILE)
                IP=$(sed -n '2p' $FORM_FILE)
                DOMAIN=$(sed -n '3p' $FORM_FILE)
                ARPA=$(sed -n '4p' $FORM_FILE)
                
                tput sgr0
                dns.sh "$SERVER" "$IP" "$DOMAIN" "$ARPA"
                echo
                read -p "엔터를 누르면 메뉴로 돌아갑니다..."
            fi
            ;;
        4)
            break
            ;;
    esac
done
