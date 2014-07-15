#!/usr/bin/env python

# Light each LED in sequence, and repeat.

import opc, time

numLEDs = 512
client = opc.Client('192.168.2.5:7890')

while True:
	for i in range(numLEDs):
		pixels = [ (0,0,0) ] * numLEDs
		pixels[i] = (255, 255, 255)
		client.put_pixels(pixels)
		time.sleep(0.01)
