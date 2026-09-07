#!/bin/bash

IP=172.16.6.206
if [ "X${IP}" != "X" ] ; then
    ping -s ${IP}    
fi
