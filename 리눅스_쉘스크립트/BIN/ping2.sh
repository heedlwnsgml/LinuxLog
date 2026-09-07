#!/bin/bash

NET=172.16.6
START=200
END=230

for i in $(seq $START $END)
do

    ping -c 1 -w 1 $NET.$i > /dev/null 2>&1
    if [ $? -eq 0 ] ; then

        echo "$NET.$i : alive"

    else 

        echo "$NET.$i : dead"

    fi

done

# do

#     ping -c 1 -w 1 $NET.$i > /dev/null 2>&1
#     [ $? -eq 0 ] \
#         && echo "[ OK ] $NET.$i" \
#         || echo "[ FIAL ] $NET.$i"

# done