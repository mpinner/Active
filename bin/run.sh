#!/bin/bash

. /boot/uboot/env.sh

if [ ! -f "$THUMB_DRIVE" ]; then
    echo "Thumbdrive not found!"
else
	if [ ! -f "$THUMB_DRIVE/copy-lock" ]; then
    	echo "copy-lock not found.."
    	#$ACTIVE_HOME/bin/pull-from-thumbdrive.sh >> $MONITOR_LOG 2>&1 
    	#touch $THUMB_DRIVE/copy-lock
    	#echo "done copying. added lock."

	fi

	if [ -f "$THUMB_DRIVE/opc-server" ]; then
    	echo "opc-server starting...."
		/usr/bin/python -c "from Adafruit_BBIO.SPI import SPI; SPI(0,0)" >> $MONITOR_LOG 2>&1
		$ACTIVE_HOME/bin/monitor-opc.sh >> $MONITOR_LOG 2>&1 &
    	echo "opc-server started."
	fi

	if [ -f "$THUMB_DRIVE/active-slinger" ]; then
    	echo "active-slinger found...."
		#echo cape-bone-iio > /sys/devices/bone_capemgr.*/slots 2>&1
		#$ACTIVE_HOME/bin/monitor-slinger.sh >> $MONITOR_LOG 2>&1 &
    	#echo "active-slinger started."

	fi

fi


echo "active-slinger starting...."
echo cape-bone-iio > /sys/devices/bone_capemgr.*/slots 2>&1
$ACTIVE_HOME/bin/monitor-slinger.sh >> $MONITOR_LOG 2>&1 &
echo "active-slinger started."


