#!/bin/bash

BASEDIR=/root/bin
FILE1=$BASEDIR/user.list

>$FILE1

for i in {100..130}
do

    echo "user$i user$i" >> $FILE1
    
done