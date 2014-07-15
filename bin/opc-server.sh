#!/bin/bash


cd /home/debian/git/openpixelcontrol;

bin/tlc5947_server layouts/wall.json 7890 12  >> /var/log/tlc5947_server.log 2>&1

