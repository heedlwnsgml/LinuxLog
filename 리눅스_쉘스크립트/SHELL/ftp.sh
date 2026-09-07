#!/bin/bash

Help(){
    cat << 'EOF' 
Commands may be abbreviated.  Commands are:

!		debug		mdir		sendport	site
$		dir		mget		put		size
account		disconnect	mkdir		pwd		status
EOF
}

Error(){
    echo "[ FAIL ] Invalid command"
}

while true
do
    echo -n "ftp> "
    read -r CMD
    [ -z "$CMD" ] && continue
    case $CMD in

        'help') Help ;;
        'quit') break ;;
        *     ) Error ;;
    esac
done