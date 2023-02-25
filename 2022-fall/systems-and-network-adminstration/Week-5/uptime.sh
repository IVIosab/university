#!/bin/bash

# Loop of ten iterations to print system uptime every 2 seconds.
for ((i = 1 ; i <= 10 ; i++)); do
  
  echo -e "$i.\t"$(uptime)
  sleep 2
done
