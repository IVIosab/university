#!/bin/bash
while true;
do echo -e "HTTP/1.1 200 OK\n\nUptime(since): $(uptime -s)\nInode Usage: $(df -i | grep '/dev/nvme0n1p6' | awk '{print $5}')\nMemory Usage: $(free | grep "Mem" | awk '{print ($3/$2)*100 "%"}')\nDisk Usage: $(df / | awk '{print $5}'| tail -n 1)\nLast 15 lines of /var/log/syslog:\n$(tail -15 /var/log/syslog)" \
  | nc -l -k -p 8080 -q 1;
done
