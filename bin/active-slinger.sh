#!/bin/bash

LOG=/var/log/active-streamers.log 

export OPC_SERVER=192.168.163.141:7890


ls -ctr ./streamers/*.py | while read script
do
  echo "running '$script'..." >> $LOG  2>&1
  timeout 10s $script  >> $LOG  2>&1
  echo "done '$script'"  >> $LOG  2>&1
done
