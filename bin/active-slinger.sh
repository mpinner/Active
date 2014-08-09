#!/bin/bash

. /home/debian/git/Active/bin/env.sh

. /boot/uboot/env.sh

cd $ACTIVE_HOME/src/
echo "running against ./images -layout $LAYOUT -server $OPC_SERVER" >> $STREAMER_LOG  2>&1
./images -layout $LAYOUT -server $OPC_SERVER >> $STREAMER_LOG  2>&1

## loop through streamers
#ls -ctr ./streamers/*.py ./streamers/active-streams/*.py | while read script
#do
#  echo "running '$script'..." >> $STREAMER_LOG  2>&1
#  timeout 10s $script  >> $STREAMER_LOG  2>&1
#  echo "done '$script'"  >> $STREAMER_LOG  2>&1
#done
