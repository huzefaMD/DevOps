#!/bin/bash
#
#how to store the keyvalue pairs
#
declare -A myArray

myArray=( [name]=Huzefa [age]=30 [city]=Chennai )


echo "My name is ${myArray[name]}"
echo "Age is ${myArray[age]}"
echo "living in ${myArray[city]}"
