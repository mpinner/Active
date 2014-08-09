#!/usr/bin/env python

# Open Pixel Control client: Every other light to solid white, others dark.

import opc, time, props

pixelCount = 1440
client = opc.Client(props.OPC_SERVER)

brightness = props.BRIGHTNESS;

stepSize = brightness/8


pattern = [(0, 0, 0)] *  pixelCount;

#while True:

	#for phase in range(0,pixelCount):	

for pixel in range(0,pixelCount) :

	color = 0;	

	#if (pixel  == phase):
	color = 35;	
			
	pattern[pixel] = (color,color,color);
	
	
# Fade to white
client.put_pixels(pattern)
time.sleep(0.01)



