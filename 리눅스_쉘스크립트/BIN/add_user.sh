#!/bin/bash

BASEDIR=/root/bin
FILE1=$BASEDIR/user.list

cat $FILE1 | while read UNAME UPASS
do

    #echo "$UNAME:$UPASS"
    useradd $UNAME \
        && echo "$UNAME:$UPASS" | chpasswd \
        && echo "[  OK  ] $UNAME" \
        || echo "[ FAIL ] $UNAME"


done
