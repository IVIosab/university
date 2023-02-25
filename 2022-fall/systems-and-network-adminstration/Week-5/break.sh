#!/bin/bash

counter=1
while [ $counter -le 10 ]
do
  if [ $counter -eq 5 ]
  then
    echo Script encountered the value $counter
    break
  fi
  echo $counter
  ((counter++))
done
echo All done
