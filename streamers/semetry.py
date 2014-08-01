#!/usr/bin/env python

# Open Pixel Control client: Every other light to solid white, others dark.

import opc, time, props

numPairs = props.PIXELS
client = opc.Client(props.OPC_SERVER)

brightness = props.BRIGHTNESS;

stepSize = brightness/8


pattern = [(0, 0, 0)] *  numPairs;


def mirrorX(i, color):
	pattern[i] = color;
	(int)i/props.COLUMNS

	pattern[]

def mirrorY(i, color):
def mirrorZ(i, color):


for phase in range(1,numPairs/4):	

	for i in range(0,numPairs) :
		if (0 == i%phase):
			pattern[i] = (brightness,brightness,brightness);
		else:
			current = pattern[i]
			step = current[0]-stepSize
			step = 0 if step < 0 else step
			pattern[i]= (step,step,step);

	# Fade to white
	client.put_pixels(pattern)
	time.sleep(0.3)


