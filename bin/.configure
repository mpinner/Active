#!/bin/bash

cd /home/debian
mkdir git
cd git
git clone https://github.com/mpinner/Active.git


#setuo ACTIVE 
cd ~debian/git/Active/bin/
chmod +x *.sh
cp env.sh /boot/uboot/

. /boot/uboot/env.sh


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


# setup OPC
git clone https://github.com/mpinner/openpixelcontrol.git
cd openpixelcontrol
git checkout tlc5947
sudo apt-get -y install mesa-common-dev freeglut3-dev 
make




