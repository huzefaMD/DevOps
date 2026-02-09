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
