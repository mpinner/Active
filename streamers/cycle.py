#!/usr/bin/env python

# Open Pixel Control client: Every other light to solid white, others dark.

import opc, time, os

numPairs = 1440
client = opc.Client(os.getenv('OPC_SERVER'))


for phase in range(1,24):	
	pattern = [];

	for i in range(0,numPairs) :
		if (0 == i%phase):
			pattern.append((255,255,255));
		else:
			pattern.append((0,0,0));

	# Fade to white
	client.put_pixels(pattern)
	time.sleep(0.5)


