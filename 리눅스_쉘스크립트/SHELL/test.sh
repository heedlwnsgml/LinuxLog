#!/bin/bash

cat /etc/vsftpd/ftpusers | grep -E -v '^#|^$' | while read UNAME
do

    echo "[ DENY ] : $UNAME"

done 
