#!/usr/bin/env python

# Open Pixel Control client: Every other light to solid white, others dark.

import opc, time, props

pixelCount = props.PIXELS
client = opc.Client(props.OPC_SERVER)

brightness = props.BRIGHTNESS;

stepSize = brightness/8


pattern = [(0, 0, 0)] *  pixelCount;

while True:

	for phase in range(0,brightness):	

		for pixel in range(0,pixelCount) :
			color = (pixel+phase) % brightness
			pattern[pixel] = (color,color,color);
			if (0 == (pixel%24) ):
				pattern[pixel] = (0,0,color);
			if (pixel < 24):
				pattern[pixel] = (color,0,color);

			
		# Fade to white
		client.put_pixels(pattern)
		time.sleep(0.001)



