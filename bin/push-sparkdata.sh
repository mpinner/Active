#!/bin/bash

. /boot/uboot/

RECENT_UPTIME=`uptime`
DISK_SPACE=`df|grep disk|awk '{print $7}'`

wget --append-output=$SPARKFUN_LOG "http://data.sparkfun.com/input/wppV3QYqbOs0qzoaYoRq?private_key=wzzXAwMWNniaGBlXNl0G&=3.21&diskspace=$DISK_SPACE&uptime=$RECENT_UPTIME"
