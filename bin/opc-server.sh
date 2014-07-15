#!/bin/bash

LOG=/var/log/active-tlc5947-server.log 
LAYOUT=layouts/wall.json 

cd /home/debian/git/openpixelcontrol;

bin/tlc5947_server $LAYOUT 7890 12  >> $LOG 2>&1

