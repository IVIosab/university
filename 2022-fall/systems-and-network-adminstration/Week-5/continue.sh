#!/bin/bash

counter=0
while [ $counter -lt 10 ]
do
  ((counter++))
  if [ $counter -eq 6 ]
  then
    echo Number 6 encountered, skipping to the next iteration
    continue
  fi
  echo $counter
done
echo All done
