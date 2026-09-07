#!/bin/bash
# 	# cat /root/bin/server.txt
#	172.16.6.230
#	172.16.6.235
#	172.16.6.201
#	# ./auto_ftp2.sh 
#	(localhost)/test/linux206.txt(1M) -> (linux249)/tmp/linux206.txt
#	(localhost)/test/linux206.txt(1M) -> (linux201)/tmp/linux206.txt
#	(localhost)/test/linux206.txt(1M) -> (linux202)/tmp/linux206.txt

BASEURL=/test
FILE=$BASEURL/linux206.txt 
for IP in $(cat /root/shell/server.txt)
do
	ftp -n $IP 21 <<- EOF
	user root soldesk1.
	cd /tmp
	lcd /test
	bin
	hash
	prompt
	mput $FILE
	quit
	EOF
done