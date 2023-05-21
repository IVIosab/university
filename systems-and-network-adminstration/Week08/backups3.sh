#!/bin/bash

cd /

#now we're in the root dir
if [ -d "/backups3" ]
then
  echo "Directory exist"
else
  `sudo mkdir backups3`
  echo "Directory created"
fi

sudo rm -rf backups3/*

#now we made the backups dir if it didn't exist
cd backups3

#now we're in the backups dir
LC_TIME=en_US.utf-8
sudo tar cpzf nginx_backup-`date +"%b-%d-%Y-%H-%M-%S"`.tar.gz /var/www/html
