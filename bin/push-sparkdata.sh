#!/bin/bash

. /boot/uboot/env.sh

RECENT_UPTIME=`uptime`
DISK_SPACE=`df|grep disk|awk '{print $4}'`

wget --append-output=$SPARKFUN_LOG "http://data.sparkfun.com/input/wppV3QYqbOs0qzoaYoRq?private_key=wzzXAwMWNniaGBlXNl0G&=3.21&diskspace=$DISK_SPACE&uptime=$RECENT_UPTIME"
