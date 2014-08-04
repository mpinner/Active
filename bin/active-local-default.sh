#!/bin/bash

. /boot/uboot/env.sh

cd $ACTIVE_HOME/src/

## loop through streamers
cat ./streamers/active-streamers.txt | while read script
while true; do
  echo "running '$script'..." >> $STREAMER_LOG  2>&1
  timeout 30s $script  >> $STREAMER_LOG  2>&1
  echo "done '$script'"  >> $STREAMER_LOG  2>&1
done
