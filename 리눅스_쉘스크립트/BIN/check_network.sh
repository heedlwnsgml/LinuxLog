#!/bin/bash

source $HOME/bin/functions.sh

IP1=192.168.10.2
IP2=8.8.8.8
IP3=www.google.com


print_info "ping $IP3"

ping -c 1 -w 1 "$IP3" > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    print_good "DNS Network Connection"
else
    print_error "DNS Network Connection"
        cat << EOF
        print_error "[ FAIL ] Domain name query"
        echo "  (a) # cat /etc/resolv.conf"
        exit 3
EOF
fi

