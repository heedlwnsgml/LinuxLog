#!/bin/bash

while true
do
    # here 문서를 이용한 메뉴 화면 출력
    cat << EOF
====================
   SYSTEM MENU
====================
1. 현재 날짜와 시간 확인
2. 디스크 사용량 확인
3. 프로그램 종료
====================
EOF

    read -p "선택하세요 [1-3]: " choice

    # case 구문을 이용한 조건 분기
    case "$choice" in
        1)
            echo "[실행] 현재 시간:"
            date
            ;;
        2)
            echo "[실행] 디스크 사용량:"
            df -h
            ;;
        3)
            echo "프로그램을 종료한다."
            exit 0
            ;;
        *)
            echo "[오류] 1에서 3 사이의 숫자를 입력해야 한다."
            ;;
    esac
    echo ""
done
