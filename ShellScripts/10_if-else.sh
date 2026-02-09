#!/bin/bash
#

read -p "Enter your Marks: " marks

if [[ $marks -gt 40 ]]

then
        echo "Hey.. you are PASS"

else
        echo "Oops.. you are FAIL"

fi
