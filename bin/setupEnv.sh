#!/bin/bash

cd /home/debian

#system libraries
sudo apt-get -y install mesa-common-dev freeglut3-dev 


#turn off bone scripts:
systemctl disable bonescript.socket
systemctl disable bonescript.service
systemctl disable bonescript-autorun.service
systemctl stop bonescript.socket
systemctl stop bonescript.service
systemctl stop bonescript-autorun.service



# pull repos
mkdir git
cd git
git clone https://github.com/mpinner/Active.git
git clone https://github.com/mpinner/openpixelcontrol.git
cd /home/debian/git/openpixelcontrol
git checkout tlc5947



#setuo ACTIVE 
cd /home/debian/git/Active/bin/
chmod +x *.sh
sudo cp env.sh /boot/uboot/

. /boot/uboot/env.sh

cd /home/debian/git/Active/streamers/
chmod +x *.py

sudo touch $OPC_LOG
sudo touch $STREAMER_LOG
sudo touch $MONITOR_LOG
sudo touch $SPARKFUN_LOG 

sudo chown debian $OPC_LOG   
sudo chown debian $STREAMER_LOG
sudo chown debian $MONITOR_LOG
sudo chown debian $SPARKFUN_LOG  


#setup log rotate
sudo touch /etc/logrotate.d/active
sudo chown debian /etc/logrotate.d/active 


# make OPC
cd /home/debian/git/openpixelcontrol
make

# make cpp streamer
cd /home/debian/git/Active/src



