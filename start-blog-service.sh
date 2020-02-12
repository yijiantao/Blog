#!/bin/bash
cd /root/project/Blog
nohup npx hexo server -p 9999 &
tail -f nohup.out
