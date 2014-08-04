#!/bin/bash

##
# env.sh
# author: @mpinner
# intent:
#  - holds properties for configuring beaglebone for Active
#  - this is stored in the /boot/uboot/ so it can be accessed via usb when the BBB
#    appears as a removeable drive.
#  - most changes here will require a reboot of the BBB before they take affect
##


# images can be added via thumbdrive which mounts as the following
export IMAGE_DROP=/media/3108660521

#standard installation directory for our main code base and git repo
export ACTIVE_HOME=/home/debian/git/Active/

# layout file to use for the mapping from pixel indexes to physical space
# a few options exist here to rotate the visual perspective
export LAYOUT=$ACTIVE_HOME/layout/layout-60x24.json

# ip and port of the beagle that is resident in the piece to push the pixels to the actual hardware
export OPC_SERVER=192.168.7.1:7890


# source for our fork of the OPC server code and binaries
export OPC_SERVER_HOME=/home/debian/git/openpixelcontrol/
export OPC_SERVER_BIN=$OPC_SERVER_HOME/bin/gl_server

# if the system is configured to call home here is a start
export GMAIL_ADDY=active@threadable.com
export DATA_SERVICE=http://data.sparkfun.com/

# logging is kept here and should be moved as these are configured with /etc/logrotate.d/active
export LOG_DIR=/var/log/
export OPC_LOG=$LOG_DIR/active-tlc5947-server.log
export STREAMER_LOG=$LOG_DIR/active-streamers.log
export MONITOR_LOG=$LOG_DIR/active-monitor.log
export SPARKFUN_LOG=$LOG_DIR/active-push-sparkfun.log


cd $OPC_SERVER_DIR
alias activegl="cd OPC_SERVER_DIR; $OPC_SERVER_BIN $LAYOUT "



