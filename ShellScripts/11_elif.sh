#!/bin/sh
#

read -p "Enter your Marks: " marks

if [[ $marks -ge 80 ]]

then
        echo "1st Devision"

elif [[ $marks -ge 60 ]]

then
        echo "2nd Division"

elif [[ $marks -ge 40 ]]

then
        echo "3rd Division"

else
        echo "oops...  Your are fail"

fi
