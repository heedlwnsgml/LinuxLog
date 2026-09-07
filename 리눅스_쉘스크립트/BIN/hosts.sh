#!/bin/bash

/bin/cp -p /etc/hosts /root/bin/hosts

HOSTS=/etc/hosts
NET=172.16.6

grep 'Linux Servers' $HOSTS > /dev/null 2>&1 \
    || cat <<'EOF' > $HOSTS

# Loopback entries; do not change.
# For historical reasons, localhost precedes localhost.localdomain:
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
# See hosts(5) for proper format and other examples:
# 192.168.1.10 foo.example.org foo
# 192.168.1.13 bar.example.org bar
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

#
# Server List
#
192.168.10.10  main.example.com     main
192.168.10.20  server1.example.com  server1
192.168.10.30  server2.example.com  server2



#
# Linux Servers
#

EOF

START=200
END=230
NET=172.16.6
for i in $(seq $START $END)
do

    echo "$NET.$i   linux$i.example.com   linux$1" >> $HOSTS

done
