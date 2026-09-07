#!/bin/bash

set -e
source $BASEDIR/functions.sh

# 패키지 설치
# * epel-release
# * gcc, cowsay

###########################
# * epel-release
# * gcc, cowsay
###########################
Bar "패키지 설정"


# * epel-release
StartMess "$PKG_EPEL"
dnf install -y -q $PKG_EPEL > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "$PKG_EPEL 설치 성공"
else 
    echo "$PKG_EPEL 설치 실패"
fi

# * gcc, cowsay
StartMess "$PKG_ADD"
dnf install -y -q $PKG_ADD > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "$PKG_ADD 설치 성공"
else 
    echo "$PKG_ADD 설치 실패"
fi
