#!/bin/bash

states=('Nebraska' 'Hawaii' 'California' 'New York' 'Tennessee')

for state in ${states[@]}
do
if [ $state == 'Hawaii' ];
then
        echo "Hawaii is the best!"
else
        echo "I am not fond of Hawaii"
fi
done
