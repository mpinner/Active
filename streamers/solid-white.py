#!/usr/bin/env python

# Open Pixel Control client: All lights to solid white

import opc, time, os

numLEDs = 1440
client = opc.Client(os.getenv('OPC_SERVER'))

black = [ (0,0,0) ] * numLEDs
white = [ (255,255,255) ] * numLEDs

# Fade to white
client.put_pixels(black)
client.put_pixels(black)
time.sleep(0.5)
client.put_pixels(white)
