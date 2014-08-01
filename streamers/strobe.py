#!/usr/bin/env python

# Open Pixel Control client: All lights to solid white

import opc, time, os

numLEDs = 1440
client = opc.Client(os.getenv('OPC_SERVER'))

black = [ (0,0,0) ] * numLEDs
white = [ (255,255,255) ] * numLEDs

tempo = opc.Client(os.getenv('OPC_SERVER'));


for tempo in range(500, 2000):
	bpm = tempo/1000.0
#    client.put_pixels(white)
#    time.sleep(bpm)  
    #bet match here!!??!?!

 #   client.put_pixels(black)
    time.sleep(bpm)
