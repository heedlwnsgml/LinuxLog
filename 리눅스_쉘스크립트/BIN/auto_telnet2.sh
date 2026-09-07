#!/bin/bash


#!/bin/bash
# 	# cat /root/bin/server.list
#	172.16.6.249	root		soldesk1.
#	172.16.6.203	user01	user01
#	172.16.6.204	user02	user02
#	# ./telnet2.sh
#	
cat /root/bin/server.list | while read HOST U_NAME U_PASS
do
	a() {
		sleep 3 ; echo "$U_NAME"
		sleep 1 ; echo "$U_PASS"
		sleep 1 ; echo 'hostname'
		sleep 1 ; echo 'id'
		sleep 1 ; echo 'exit'
	}
	a | telnet $HOST
done
