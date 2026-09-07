export PKG_TELNET="telnet-server telnet"
export SVC_TELNET="telnet.socket"
export PKG_FTP="vsftpd ftp"
export SVC_FTP="vsftpd.service"
export BASHRC="$HOME/.bashrc"
export VIMRC="$HOME/.vimrc"
export PKG_EPEL="epel-release"
export PKG_ADD="gcc cowsay"

Bar(){
    #Bar TELNET
    echo "[ INFO ] $1 설정"
}

StartMess() {
    # StartMess TELNET
    echo "[ INFO ] 1단계: 패키지 설치($1)"
}

SvcConfMess() {
    # StartMess TELNET
    echo "[ INFO ] 2단계: 서비스 설정($1) 시작"   
}

SvcMess() {
    # SvcMess telnet.socket
    echo "[ INFO ] 3단계: 서비스 기동($1)"
}

function print_good () {
    echo -e "\x1B[01;32m[  OK  ]\x1B[0m $1"
}

function print_error () {
    echo -e "\x1B[01;31m[ FAIL ]\x1B[0m $1"
}

function print_info () {
    echo -e "\x1B[01;34m[ INFO ]\x1B[0m $1"
}