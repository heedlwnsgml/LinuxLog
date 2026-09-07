#!/bin/bash

#echo "Enter Your Choice? (y/n) : \c" 
printf "Enter Your Choice? (y/n) : "
read ANSWER

if [ "$ANSWER" = "yes" -o "$ANSWER" = "Yes" -o "$ANSWER" = "YES" -o "$ANSWER" = "y" ] ; then
	echo "Yes... Entered"
elif [ "$ANSWER" = "no" -o "$ANSWER" = "No" -o "$ANSWER" = "No" -o "$ANSWER" = "n" ] ; then
	echo "No.... Entered"
esle
	echo "Answer not recongnize"
	exit 1
fi
