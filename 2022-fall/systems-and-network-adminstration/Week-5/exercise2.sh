#!/bin/bash
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
sudo tar cpzf home_backup_`date +"%b"`_`date +"%d"`_`date +"%Y"`_`date +"%H"`_`date +"%M"`_`date +"%S"`.tar.gz $HOME
