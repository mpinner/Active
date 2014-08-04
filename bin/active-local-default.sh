#!/bin/bash

. /home/debian/git/Active/bin/env.sh

. /boot/uboot/env.sh

cd $ACTIVE_HOME/streamers/

## loop through streamers
cat ./active-streamers.txt | while read script
do
  echo "running '$script'..." >> $STREAMER_LOG  2>&1
  timeout 30s ./$script  >> $STREAMER_LOG  2>&1
  echo "done '$script'"  >> $STREAMER_LOG  2>&1
done
