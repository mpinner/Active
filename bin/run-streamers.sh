#!/bin/bash

LOG=/var/log/active-streamers.log 


ls -ctr ./streamers/*.py | while read script
do
  echo "running '$script'..." >> $LOG  2>&1
  $script  >> $LOG  2>&1
  echo "done '$script'"  >> $LOG  2>&1
done