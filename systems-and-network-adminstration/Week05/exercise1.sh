#!/bin/bash

echo "Username: $USER"
echo "Home Directory: $HOME"
echo "Shell: $SHELL"
echo "Hostname: $HOSTNAME"
ipaddress=$(echo `ifconfig | grep "inet " | grep -v "127.0.0.1"` | awk '{print $2}')
echo "IP address: $ipaddress"
