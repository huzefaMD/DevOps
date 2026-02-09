#!/bin/bash

#This script shows how to use variables

a=10
name="Student"
age=30

echo "My name is $name and age is $age"

name="Mahesh"
echo "My name is $name"

#This variable to store the output of a command

HOSTNAME=$(hostname)

echo "Name of this machine is $HOSTNAME"

TEDI=$(date)

echo "Inniki tedi $TEDI"
root@ip-172-31-73-30:~# cat 04_constvar.sh
#!/bin/bash
#
#Constant Variable
#

readonly COLLEGE="Jr.College"

echo "My college name is $COLLEGE"

COLLEGE="Sr.College"

echo "My students college is $COLLEGE"
