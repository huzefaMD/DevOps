#!/bin/bash
#
#AND Operator
#
read -p "what is your age?" age
read -p "your country:" country

if [[ $age -ge 18 ]] || [[ $country == "India" ]]

then
        echo "You can vote"

else
        echo "you can't vote"

fi
