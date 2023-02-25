#!/bin/bash

if [[ $# -le 0 ]]
then
  echo "You did not pass any files as arguments to the script."
  echo "Usage:" "$0" "my-file"
  exit
fi

IFS=:
file=$1

if [ ! -f "$file" ]
then
  echo "File does not exist!"
fi

for word in $(cat "${file}")
do
  echo "$word"
done
