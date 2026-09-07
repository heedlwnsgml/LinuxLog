#!/bin/bash

echo "===================================================="
echo "  (1). who      (2). date     (3). pwd              "
echo "===================================================="

echo -n "Enter Your Choice(1-3)? : "      # 선택할 수 있는 번호를 입력 
read NUMBER

case $NUMBER in
   1) who ;;
   2) date ;;
   3) pwd ;;
   *) echo "Error... Try Again"
	exit 1 ;;
esac

# if [ "$NUMBER" -eq 1 ]; then
#     who
# elif [ "$NUMBER" -eq 2 ]; then
#     date
# elif [ "$NUMBER" -eq 3 ]; then
#     pwd
# else
#     echo "Error... Try Again"
#     exit 1
# fi