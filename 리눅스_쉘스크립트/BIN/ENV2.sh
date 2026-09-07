#!/bin/bash

# 1) ~/.bashrc
# 2) ~/.vimrc

set -e

source $BASEDIR/functions.sh

###################################
# 1) ~/.bashrc
###################################
Bar "$BASHRC"
# 1) ~/.bashrc
# * alias grep='grep -i'
# * alias tree='env LANG=C tree -C -F'
# * alias vi='/usr/bin/vim'
# * alias c='clear'
if ! grep -qw tree $BASHRC ; then
    cat <<'EOF' >> $BASHRC 

alias grep='grep -i'
alias tree='env LANG=C tree -C -F'
alias vi='/usr/bin/vim'
alias c='clear'

EOF
fi

###################################
# 1) ~/.vimrc
###################################
Bar "$VIMRC"

# syntax on
if [ ! -f "$VIMRC" ] ; then
    cat <<'EOF' >> $VIMRC > /dev/null 2>&1
syntax on
set ai nu t=4 sw=4
EOF
fi
