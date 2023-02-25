#!/bin/bash

file=$1

if [[ "$file" == "" || (! -f "$file") ]]
then
  echo Using standard input!
  file="/dev/stdin"
fi

while read -r line
do
  echo "$line"
done < "${file}"
