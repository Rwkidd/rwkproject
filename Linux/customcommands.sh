#!/bin/bash

mkdir ~/research

echo -e "\n777 files:" >> ~/research/sys_info.txt find / -type f -perm 777 >> ~/research/system_info.txt
#find / -type f -perm 777 >> ~research/Sys_info.txt

echo -e "\ntop Ten Processes" >> ~/research/sys_info.txt ps auz -m | ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> ~/research/sys_info.txt

