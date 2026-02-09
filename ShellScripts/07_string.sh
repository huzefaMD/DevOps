#!/bin/bash
#
myVar="Hey student, how are you?"

myVarLength=${#myVar}

echo "Length of the myVar is $myVarLength"

echo "Upper case is ------ ${myVar^^}"
echo "Lower case is ------ ${myVar,,}"


#To replace a string
#
newVar=${myVar/student/Huzefa}

echo "New var is ------ $newVar"
