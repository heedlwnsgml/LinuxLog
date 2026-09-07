#!/bin/bash

echo -n "Enter Your Filename ? : "
read FILENAME

if [ -d $FILENAME ] ; then
    echo "File is a Directory."
elif [ -f $FILENAME ] ; then
    echo "File is a regular file."
else
    echo "Not Found."
fi