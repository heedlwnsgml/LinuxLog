#!/bin/bash

# 무한 루프 시작
while true
do
    # 관리 목록 메뉴 출력
    echo "=============================="
    echo "       사용자 관리 툴         "
    echo "=============================="
    echo " 1. 사용자 추가"
    echo " 2. 사용자 확인"
    echo " 3. 사용자 삭제"
    echo " 4. 종료"
    echo "=============================="
    
    # 번호 입력 대기
    read -p "번호를 선택하세요 (1-4): " CHOICE
    echo ""

    # 선택된 번호에 따른 동작 수행
    case "$CHOICE" in
        1)
            # 사용자 추가 로직
            read -p "추가할 사용자명: " UNAME
            id "$UNAME" > /dev/null 2>&1
            if [ $? -eq 0 ]; then
                echo "[실패] 이미 존재하는 사용자입니다."
            else
                useradd "$UNAME" > /dev/null 2>&1
                echo "[성공] $UNAME 사용자가 추가되었습니다."
            fi
            ;;
        2)
            # 사용자 확인 로직
            read -p "확인할 사용자명: " UNAME
            id "$UNAME" > /dev/null 2>&1
            if [ $? -eq 0 ]; then
                echo "[결과] $UNAME 사용자가 존재합니다."
            else
                echo "[결과] $UNAME 사용자를 찾을 수 없습니다."
            fi
            ;;
        3)
            # 사용자 삭제 로직
            read -p "삭제할 사용자명: " UNAME
            id "$UNAME" > /dev/null 2>&1
            if [ $? -eq 0 ]; then
                userdel -r "$UNAME" > /dev/null 2>&1
                echo "[성공] $UNAME 사용자가 삭제되었습니다."
            else
                echo "[실패] 존재하지 않는 사용자입니다."
            fi
            ;;
        4)
            # 종료 로직
            echo "프로그램을 종료합니다."
            break
            ;;
        *)
            # 예외 처리
            echo "[오류] 1번부터 4번 사이의 숫자를 입력하세요."
            ;;
    esac
    
    echo ""
done