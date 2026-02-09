#!/bin/bash

#Arrays in Scripts
#

myArray=( 1 20 30.5 hello "hi students..!" )

echo "Value in 3rd place ${myArray[3]}"
echo ${myArray[4]}

echo "all the values in array are ${myArray[*]}"
echo "all the values in array are ${#myArray[*]}"

root@ip-172-31-73-30:~# cat 06_keyvalue.sh
#!/bin/bash
#
#how to store the keyvalue pairs
#
declare -A myArray

myArray=( [name]=Huzefa [age]=30 [city]=Chennai )


echo "My name is ${myArray[name]}"
echo "Age is ${myArray[age]}"
echo "living in ${myArray[city]}"
