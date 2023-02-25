#!/bin/bash

echo -n "Enter the number: "
read number
if [ $number -gt 100 ]
then
  echo That\'s a large number.
elif [ $number -gt 50 ]
then
  echo Not so much.
else
  echo The number is way too small.
fi
