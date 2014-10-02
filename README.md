Active
===

[![pulsing led sculpture - evan miller + mpinner - test 01 ](https://raw.githubusercontent.com/mpinner/Active/master/docs/Active_SmokeMonster_tb.gif)](http://www.youtube.com/watch?v=6qRlZ3MchNk)


Lightning 10 gross LEDs begins in the one of a kind video art experience for visitors to The Source.

Giant expansive space high above the patrons is sparsely populated for creative expression. bring a local flavor of of collaborative expression to a focal point below. 

Reacting to your motion as you enter the space; Sensors, video, images, and the live data from the internet are all merged to creating a living space above The Source, an urban marketplace in the Rino Arts District.


[![opening event](https://raw.githubusercontent.com/mpinner/Active/master/docs/Active_flyer_dm.jpg)]



SRC
===
applications for rendering content to [Open Pixel Control](http://openpixelcontrol.org/) network stream.

depends on [FadeCandy C Libs](https://github.com/scanlime/fadecandy/tree/master/examples/cpp) for opc client and effects framework. we've added some custom effect mixing and image loading for realtime brightness control.

[optionally] depends on [BlackLib](http://blacklib.yigityuce.com/) for live analog brightness control sensors.

 

STREAMERS
===
opc content generation for testing troubleshoot and user contributions in mostly Python from opc/fadecandy examples


PROCESSING
===
Toolkit for developing image manipulation code, layouts, and renderings for concept art in [Processing](https://www.processing.org/)

**processing simulation**

[![pulsing led sculpture - evan miller + mpinner - test 01 ](https://raw.githubusercontent.com/mpinner/Active/master/docs/Active_TieFighter_tb.gif)](http://www.youtube.com/watch?v=eXs2kY__nDY)



BIN
===
tool kit for running and configuring [beaglebone black](http://beagleboard.org/)


Installation
===

**Materials**

 * 2x the latest BBB or [upgrade any version to debian](http://elinux.org/BeagleBoardDebian)
 * tlc [spi style](http://guy.carpenter.id.au/gaugette/2014/01/28/controlling-an-adafruit-spi-oled-with-a-beaglebone-black/) led drivers ([tlc5947](https://www.adafruit.com/products/1429), http://www.ti.com/product/TLC5955, [tlc5940](https://www.sparkfun.com/products/10616) [tlc59711](https://www.adafruit.com/product/815) )
 * [analog input](http://beaglebone.cameon.net/home/reading-the-analog-inputs-adc) on AIN1
 
**Steps**

Pulling the latest and Building
	
	mkdir git; cd git
	git clone https://github.com/mpinner/Active.git
	cd Active/bin/
	chmod +x *.sh
	. ./env.sh
	./setupEnv.sh
	
	
my openpixelcontrol fork with SPI / TLC support
	
	git clone https://github.com/mpinner/openpixelcontrol.git 
	cd openpixelcontrol
	make

	
change hostname

	sudo emacs  /etc/hostname
	sudo emacs /etc/hosts
	
Setup root crontab for script autorun
	
	sudo crontab -e 

Add in the [following](https://github.com/mpinner/Active/blob/master/bin/crontab)

	# push-sparkdata.sh
	00 11,23 * * * /home/debian/git/Active/bin/push-sparkdata.sh >> /var/log/active-push-sparkfun.log   2>&1
	
	# starts spi overlay gpio pins
	# creates /dev/spidev* files
	@reboot /usr/bin/python -c "from Adafruit_BBIO.SPI import SPI; SPI(0,0)" >> /var/log/active-gpio.log 2>&1
	
	#pre-process videos 
	#(with some large videos bbb cannot transcode in realtime)
	*/1 * * * * /home/debian/git/Active/bin/process-videos.sh >> /var/log/active-process-videos.log   2>&1
	
	# on boot start whatever this bone id configured for
	@reboot /home/debian/git/Active/bin/run.sh >> /var/log/active-monitor.log 2>&1
	



	
Edit /etc/fstab to make for less disk

	UUID=8037fd09-ea0d-4c28-a348-1fbdf9fb0b92 / ext3 
	relatime,noatime,errors=remount-ro 0 1 
	
	tmpfs /tmp tmpfs defaults,noatime 0 0 
	tmpfs /var/run tmpfs defaults,noatime 0 0 
	tmpfs /var/log tmpfs defaults,noatime 0 0 
	tmpfs /var/lock tmpfs defaults,noatime 0 0 
	tmpfs /var/tmp tmpfs defaults,noatime 0 0 
	tmpfs /var/lib/dhcp3 tmpfs defaults,noatime 0 0 
	
Double check /boot/uboot/env.sh for IP addresses and the configurations you might want.

 
INSPIRATION
====
 
[Light Emitting Ball (LEB)](https://hackaday.io/project/138-Light-Emitting-Ball-(LEB))

[Nsl Blinky Ball](http://charliex2.wordpress.com/2012/02/11/the-blinky-ball-nullspacelabs/)

[jim campbell](http://www.jimcampbell.tv/)

[disorient pyramid](http://blog.crashspace.org/2013/09/disorient-pyramid-at-burning-man-2013/)

[fadecandy ecstatic-epiphany](http://www.misc.name/ecstatic-epiphany/) 
 