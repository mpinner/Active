#!/bin/bash



export LAYOUT=/home/debian/git/Active/layout/layout-60-24.json
export OPC_SERVER=green:7890
export GMAIL_ADDY=active@threadable.com
export DATA_SERVICE=http://data.sparkfun.com/
export LOG_DIR=/var/log/
export IMAGE_DROP=/media/3108660521
export OPC_SERVER_HOME=/home/debian/git/openpixelcontrol/
export OPC_SERVER_BIN=$OPC_SERVER_HOME/bin/gl_server

export LOG_DIR=/var/log
export OPC_LOG=$LOG_DIR/active-tlc5947-server.log
export STREAMER_LOG=$LOG_DIR/active-streamers.log
export MONITOR_LOG=$LOG_DIR/active-monitor.log
export SPARKFUN_LOG=$LOG_DIR/active-push-sparkfun.log 

export 


cd $OPC_SERVER_DIR
alias activegl="cd OPC_SERVER_DIR; $OPC_SERVER_BIN $LAYOUT "



