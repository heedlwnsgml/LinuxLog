#!/bin/bash

while true
do
    echo "=============================="
    echo " [오늘의 카페 메뉴판]"
    echo " 1. 아메리카노"
    echo " 2. 카페라테"
    echo " 3. 바닐라라테 (품절)"
    echo " 4. 주문 종료"
    echo "=============================="
    echo -n "원하는 메뉴 번호를 입력한다: "
    read menu

    # 아무것도 입력하지 않은 경우
    if [ -z "$menu" ]; then
        echo "[ FAIL ] 아무것도 입력하지 않았다. 번호를 다시 확인한다."
        echo ""
        continue
	echo "1"
    fi

    # 주문 종료 (4번)
    if [ "$menu" = "4" ]; then
        echo "[ INFO ] 주문을 종료한다. 맛있게 드세요!"
        break
	echo1
    fi

    # 품절된 메뉴 번호를 고른 경우 (3번)
    if [ "$menu" = "3" ]; then
        echo "[ FAIL ] 죄송합니다. 바닐라라테는 현재 품절이다. 다른 번호를 고른다."
        echo ""
        continue
    fi

    # 1, 2번 외의 잘못된 번호를 고른 경우
    if [ "$menu" != "1" ] && [ "$menu" != "2" ]; then
        echo "[ FAIL ] 잘못된 번호다. 1부터 4 사이의 번호만 입력한다."
        echo ""
        continue
    fi

    # 정상 주문 처리
    case "$menu" in
        1)  echo "[  OK  ] 주문 접수: 시원한 아메리카노를 준비한다."
            ;;
        2)  echo "[  OK  ] 주문 접수: 고소한 카페라테를 준비한다."
            ;;
    esac
    echo ""
done
echo "END"
