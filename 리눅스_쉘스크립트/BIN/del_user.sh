#!/bin/bash

BASEDIR=/root/bin
FILE1=$BASEDIR/user.list

cat $FILE1 | while read UNAME UPASS
do

    userdel -r $UNAME \
        && echo "[  OK  ] $UNAME" \
        || echo "[ FAIL ] $UNAME"

done
