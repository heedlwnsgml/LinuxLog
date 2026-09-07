#!/bin/bash

echo -n "Enter Your Filename : "      
read FILENAME

if [ -x $FILENAME ] ; then            
    . $FILENAME
fi
