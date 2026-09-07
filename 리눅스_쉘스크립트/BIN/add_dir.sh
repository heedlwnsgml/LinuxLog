#!/bin/bash
# /test dir in 1,2,3,4 dir
# 1..4 dir in 1..4dir

BASEDIR=/test1

mkdir -p $BASEDIR
rm -rf /$BASEDIR/*

for i in {1..4}
do    
    mkdir -p /$BASEDIR/$i
        for j in {1..4}
            do
                mkdir -p /$BASEDIR/$i/$j
            done
done