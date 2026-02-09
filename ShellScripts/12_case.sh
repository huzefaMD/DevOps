#!/bin/bash
#

echo "Provide an option"
echo "a for Print date"
echo "b for list of scripts"
echo "c to check the current location"

read choice

case $choice in
        a)date;;
        b)ls;;
        c)pwd;;
        *)echo "please provide a valid value"

esac
