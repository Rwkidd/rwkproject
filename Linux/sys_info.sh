#!/bin/bash

output=$HOME/research/system_info.txt

ip=$(ip addr | grep inet | inet -2 | head -1)
find=$(find /home -type f -perm 777)

echo -e "IP INFO: $ip" >> $output
echo -e "777 files\n" >> $output
echo -e "$find" >> $output

echo "A Quick System Audit Script" >> $output
 date >> $output
 echo "" >> $output
 echo "Machine Type Info:" >> $output
 echo -e "$MACHTYPE \n" >> $output
 echo -e "Uname info: $(uname -a) \n" >> $output
 echo -e "IP Info:" >> $output

if [ ! -d ~/research ]
then
 echo "Creating research directory!!" >> $output
 mkdir ~/research
fi

if [ -f ~/research/sys_info.txt ]
then
 rm ~/research/sys_info.txt 
fi

