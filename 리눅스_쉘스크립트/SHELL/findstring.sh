#!/bin/bash

if [ $# -ne 2 ] ; then                 # 조건: 인자가 2개가 아니면
    echo "Usage : $0 pattern filename"
    exit 1
fi

if grep $1 $2 > /dev/null 2>&1 ; then  # 조건: 파일에서 특정한 패턴을 잘 찾으면
    echo "Special pattern found"
else
    echo "Special pattern not found"
fi
