#!/bin/bash
backup_name=$1
dir_path=$2

cd /

#now we're in the root dir
if [ -d "/backups" ]
then
  echo "Directory exist"
else
  `sudo mkdir backups`
  echo "Directory created"
fi

#now we made the backups dir if it didn't exist
cd backups

#now we're in the backups dir
LC_TIME=en_US.utf-8
sudo tar cpzf ${backup_name}-`date +"%b-%d-%Y-%H-%M-%S"`.tar.gz $dir_path
