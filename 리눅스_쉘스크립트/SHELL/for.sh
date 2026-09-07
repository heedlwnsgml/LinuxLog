#!/bin/bash

for host in main server1 server2
do
    ssh $host hostname
done
