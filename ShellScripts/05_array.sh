#!/bin/bash

#Arrays in Scripts
#

myArray=( 1 20 30.5 hello "hi students..!" )

echo "Value in 3rd place ${myArray[3]}"
echo ${myArray[4]}

echo "all the values in array are ${myArray[*]}"
echo "all the values in array are ${#myArray[*]}"
