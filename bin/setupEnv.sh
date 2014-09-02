#!/bin/bash

cd /home/debian

#system libraries
sudo apt-get -y install mesa-common-dev freeglut3-dev

# if you have a new beagle bone w 4gb 
sudo apt-get -y install emacs


# if you have an old beagle bone w 2gb 
#turn off bone scripts:
sudo systemctl disable bonescript.socket
sudo systemctl disable bonescript.service
sudo systemctl disable bonescript-autorun.service
sudo systemctl stop bonescript.socket
sudo systemctl stop bonescript.service
sudo systemctl stop bonescript-autorun.service



# pull repos
mkdir git
cd git
git clone https://github.com/mpinner/Active.git
git clone https://github.com/mpinner/openpixelcontrol.git
cd /home/debian/git/openpixelcontrol
git checkout tlc5947



#setup ACTIVE 
cd /home/debian/git/Active/bin/
chmod +x *.sh
sudo cp env.sh /boot/uboot/

. /boot/uboot/env.sh

echo ". /boot/uboot/env.sh" >> .bashrc 

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
make


# sudo
sudo su -
cat /home/debian/git/Active/bin/hosts >> /etc/hosts
echo ". /boot/uboot/env.sh" >> .bashrc 
exit





cd ~/git;
git clone git://git.videolan.org/x264.git
cd x264/
./configure --enable-static --enable-shared
date ; make ; date


sudo su -
cd /home/debian/git/x264
make install
ldconfig

exit

cd ~/git;
git clone git://git.videolan.org/ffmpeg.git
cd ffmpeg
./configure --enable-shared --enable-libx264 --enable-gpl
git remote set-url origin git://source.ffmpeg.org/ffmpeg
make
sudo make install



sudo su -
cd /home/debian/git/ffmpeg
make install
ldconfig

exit





