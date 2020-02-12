#!/bin/bash
pid=$(ps -ef|grep hexo|grep -v grep|awk '{print $2}')
if [ -n "$pid" ]
then
    echo "kill -9 pid:" $pid
    kill -9 $pid
fi
