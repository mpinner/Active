#!/bin/bash

LOG=/var/log/active-streamers.log 

export OPC_SERVER= '192.168.2.7:7890'


ls -ctr /home/debian/git/Active/streamers/*.py | while read script
do
  echo "running '$script'..." >> $LOG  2>&1
  $script  >> $LOG  2>&1
  echo "done '$script'"  >> $LOG  2>&1
done