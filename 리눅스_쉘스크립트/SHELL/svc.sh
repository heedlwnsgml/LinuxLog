#!/bin/bash
# 인자가 2개 미만이거나 올바르지 않은 경우 사용법 출력 후 종료
if [ $# -lt 2 ]; then
    echo "Usage: $0 {start|stop|restart} <service_name>"
    exit 1
fi
ACTION=$1
SERVICE=$2

case "$ACTION" in
    start)
        echo "[  OK  ] : Starting $SERVICE"
        systemctl start "$SERVICE" \
          && systemctl enable "$SERVICE" >/dev/null 2>&1 \
          || echo "[ FAIL ] : Failed $SERVICE"
        ;;
    stop)
        echo "[  OK  ] : Stopping $SERVICE"
        systemctl stop "$SERVICE" \
          && systemctl disable "$SERVICE" >/dev/null 2>&1 \
          || echo "[ FAIL ] : Failed $SERVICE"
        ;;
    restart)
        echo "[  OK  ] : Restart $SERVICE"	
        systemctl stop "$SERVICE" >/dev/null 2>&1 \
          && systemctl disable "$SERVICE" >/dev/null 2>&1 \
	  && systemctl start "$SERVICE" >/dev/null 2>&1 \
          && systemctl disable "$SERVICE" >/dev/null 2>&1 \
	|| echo "[ FAIL ] : Failed $SERVICE"
        ;;
    *)
        echo "Usage: $0 {start|stop|restart} <service_name>"
        exit 1
        ;;
esac
