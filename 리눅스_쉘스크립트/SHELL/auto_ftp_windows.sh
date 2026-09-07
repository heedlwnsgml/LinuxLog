#!/bin/bash

IP1=192.168.10.1
PORT1=2121

ftp -n $IP1 $PORT1 << EOF
user user01 user01
lcd /test
cd test
bin
hash
prompt
mput linux*.txt
quit
EOF