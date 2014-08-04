Active
===

[![pulsing led sculpture - evan miller + mpinner - test 01 ](http://img.youtube.com/vi/6qRlZ3MchNk/0.jpg)](http://www.youtube.com/watch?v=6qRlZ3MchNk)


Lightning 10 gross LEDs begins in the one of a kind video art experience for visitors to The Source.

Giant expansive space high above the patrons is sparsely populated for creative expression. bring a local flavor of of collaborative expression to a focal point below. 

Reacting to your motion as you enter the space; Sensors, video, images, and the live data from the internet are all merged to creating a living space above The Source, an urban marketplace in the Rino Arts District.



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
[![pulsing led sculpture - evan miller + mpinner - test 01 ](http://img.youtube.com/vi/eXs2kY__nDY/0.jpg)](http://www.youtube.com/watch?v=eXs2kY__nDY)



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
	
	git clone https://github.com/mpinner/Active.git

	chmod +x Active/bin/env.sh
	. Active/bin/env.sh
	./Active/bin/setupEnv.sh
	cd Active/src
	make
	
my openpixelcontrol fork with SPI / TLC support
	
	git clone https://github.com/mpinner/openpixelcontrol.git 
	cd openpixelcontrol
	make
	
setting up root crontabs to aurostart
	
	sudo crontab -e 

paste in the [following](https://github.com/mpinner/Active/blob/master/bin/crontab)

	# push-sparkdata.sh
	00 11,23 * * *OB /home/debian/git/Active/bin/push-sparkdata.sh >> /var/log/active-push-sparkfun.log   2>&1
	
	# configure spi overlay gpio pins
	# creates /dev/spidev* files
	@reboot /usr/bin/python -c "from Adafruit_BBIO.SPI import SPI; SPI(0,0)" >> /var/log/active-gpio.log 2>&1
	
	# this never worked. halp?
	#@reboot echo cape-bone-iio > /sys/devices/bone_capemgr.*/slots 2>&1

	#start up our OPC SERVER
	@reboot /home/debian/git/Active/bin/monitor-opc.sh >> /var/log/active-monitor.log 2>&1
	
	#start our pixel slinger (generates content)
	
	@reboot /home/debian/git/Active/bin/monitor-slinger.sh >> /var/log/active-monitor.log 2>&1 


	
	
	

 
INSPIRATION
====
 
[Light Emitting Ball (LEB)](https://hackaday.io/project/138-Light-Emitting-Ball-(LEB))

[Nsl Blinky Ball](http://charliex2.wordpress.com/2012/02/11/the-blinky-ball-nullspacelabs/)

[jim campbell](http://www.jimcampbell.tv/)

[disorient pyramid](http://blog.crashspace.org/2013/09/disorient-pyramid-at-burning-man-2013/)

[fadecandy ecstatic-epiphany](http://www.misc.name/ecstatic-epiphany/) 
 