#!/bin/bash

##
# env.sh
# author: @mpinner
# intent:
#  - holds properties for configuring beaglebone for Active
#  - hold commands for administering the services
#  - this is stored in the /boot/uboot/ so it can be accessed via usb when the BBB
#    appears as a removeable drive.
#  - most changes here will require a reboot of the BBB before they take affect
##


# images can be added via thumbdrive which mounts as the following
export IMAGE_DROP=/media/ACTIVE

#standard installation directory for our main code base and git repo
export ACTIVE_HOME=/home/debian/git/Active/

# send to yourself
#export ACTIVE_SLINGER_BIN=$ACTIVE_HOME/bin/active-local-default.sh
export ACTIVE_SLINGER_BIN=$ACTIVE_HOME/bin/active-slinger.sh


# layout file to use for the mapping from pixel indexes to physical space
# a few options exist here to rotate the visual perspective
export LAYOUT=$ACTIVE_HOME/layout/layout-60x24.json

# sequences will restart after a duration to allow bin level cycling of active-streamers
# small timeouts help for the OPC_SERVER host bc it allows other sources to connect
export TIMEOUT=30s # seconds

# ip and port of the beagle that is resident in the piece to push the pixels to the actual hardware
#local tests
export OPC_SERVER=127.0.0.1:7890

#Active: white
#export OPC_SERVER=192.168.163.141:7890

#usb connection
#export OPC_SERVER=192.168.7.1:7890


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
#export ACTIVE_SPARKFUN_URL=http://data.sparkfun.com/input/wppV3QYqbOs0qzoaYoRq?private_key=wzzXAwMWNniaGBlXNl0G&=3.21


cd $OPC_SERVER_DIR
alias activegl="cd OPC_SERVER_DIR; $OPC_SERVER_BIN $LAYOUT "
alias restart-opc-server="sudo killall -r tlc"
alias kill-opc-server="sudo killall -r opc tlc"
alias logs="tail -f /var/log/active-*"
alias restart-slinger-server="sudo killall -r tlc"
alias kill-slinger="sudo killall -r slinger mixer"
alias restart-slinger="sudo killall -r mixer"
alias restart-slinger="sudo killall -r mixer"
alias restart-bbb="sudo reboot -n"
alias pull-latest="$ACTIVE_HOME/"




