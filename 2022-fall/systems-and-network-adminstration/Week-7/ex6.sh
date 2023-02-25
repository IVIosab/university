#!/bin/bash
while true
do
  echo "date: $(date)" >> /var/log/system_utilization.log
  echo "$(cat /proc/stat |grep cpu |tail -1|awk '{print ($5*100)/($2+$3+$4+$5+$6+$7+$8+$9+$10) }'|awk '{print "CPU Usage: " 100-$1 "%"}')" >> /var/log/system_utilization.log
  echo "$(free | grep "Mem" | awk '{print "Memory usage: " ($3/$2)*100 "%"}')" >> /var/log/system_utilization.log
  echo "Disk usage: $(df / | awk '{print $5}'| tail -n 1)" >> /var/log/system_utilization.log
  echo "------------15 Seconds Interval------------" >> /var/log/system_utilization.log
  sleep 15
done
