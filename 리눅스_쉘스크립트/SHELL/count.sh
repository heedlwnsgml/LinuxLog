#!/bin/bash

seconds=3
echo "[ INFO ] 라면 물을 올린다. 잠시 대기한다."

whlie [ $seconds -gt 0 ]; do
    echo "남은 시간: ${seconds}초"
    seconds=$((seconds - 1))
    sleep 1
done

echo "[ INFO ] 물이 끓는다. 면을 넣는다!"
