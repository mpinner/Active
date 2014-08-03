#!/bin/bash

. /boot/uboot/env.sh

echo cape-bone-iio > /sys/devices/bone_capemgr.*/slots

cd $ACTIVE_HOME;

while true; do

    until $ACTIVE_SLINGER_BIN; do
        echo "Active Slinger crashed with exit code $?.  Respawning.." >&2
        sleep 1
    done
done