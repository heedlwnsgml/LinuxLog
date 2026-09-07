#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <directory> <src extention> <dst extention>"
    echo " ex : $0 (/test .txt .els)"
    exit 1
fi

D_WORK="$1"             	# working directory
T_FILE1=/tmp/.tmp1  	# tempory file1
SRC_EXT2="$2"
SRC_EXT1="$3"


ls -1 $D_WORK | grep "${SRC_EXT1}\$" > $T_FILE1
for FILE in `cat $T_FILE1`
do
    mv $D_WORK/$FILE `echo $D_WORK/$FILE | sed "s/${SRC_EXT1}\$/${SRC_EXT2}/g"`
done

ls /test