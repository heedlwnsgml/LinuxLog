#!/bin/bash

plus(){
    echo "$A + $B = $(expr $A + $B)"
}

Minus(){
    echo "$A - $B = $(expr $A - $B)"
}

Mul(){
    echo "$A x $B = $(expr $A \* $B)"
}

Div(){
    echo "$A / $B = $(expr $A / $B)"
}

read -p "Enter A  : " A
read -p "Enter Op : " OP
read -p "Enter B  : " B

case "$OP" in
    '+') plus  ;;
    '-') Minus ;;
    '*') Mul   ;;
    '/') Div   ;;
     * ) echo "[ FAIL ]" 
         exit 1 ;;
esac

echo "임의로 만든 것 $A $OP $B = $(expr $A "$OP" $B)"
