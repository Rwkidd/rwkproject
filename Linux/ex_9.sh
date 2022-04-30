#!/bin/bash

files=('/etc/passwd' 'etc/shadow')

for file in ${files[@]}
do
 ls -l $file 
done


# check the sudo privileges of each user that has a home folder
users=$(ls /home)

for user in ${users[@]}
do
 sudo -lU $user
done


commands=('date' 'uname -a' 'hostname -s')

for x in  {0..2} 
do
  results=$(${commands[$x]})
  echo "Results of the \"${commands[$x]}\" command:"
  echo $results
  echo ""

done
