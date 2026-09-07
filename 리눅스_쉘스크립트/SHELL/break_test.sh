while [조건1]								3번
do
    statement1
    while [조건2]							2번
    do
        statement2
        while [조건3]						1번 
        do
            statement3
            [조건4] && break N              /* N is number (EX: 1, 2, 3) */
            statement4
        done
    done
done
