#!/bin/bash

if [ $# -ne 1 ] ; then         	# 조건: 인자(Argument) 1개가 아니면
    echo "Usage : $0 filename"
    exit 1
fi

FILESIZE=`wc -c < $1`        	# FILESIZE=`/usr/bin/ls -l $1 | awk '{print $5}'`

if [ "$FILESIZE" -le 5120 ] ; then
    echo "This file($1) is a small file"
else
    echo "This file($1) is a big file"
fi
