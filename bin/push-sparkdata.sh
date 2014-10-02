#!/bin/bash


. /boot/uboot/env.sh

RECENT_UPTIME=`uptime`
DISK_SPACE=`df|grep disk|awk '{print $4}'`
HOSTNAME=`hostname`

#impossibly weak security
wget --append-output=$SPARKFUN_LOG "$ACTIVE_SPARKFUN_URL&diskspace=$DISK_SPACE&uptime=$RECENT_UPTIME&hostname=$HOSTNAME"

