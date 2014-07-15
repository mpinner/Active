#!/usr/bin/env python

# Open Pixel Control client: Every other light to solid white, others dark.

import opc, time, os

numPairs = 720
client = opc.Client(os.getenv('OPC_SERVER'))

black = [ (0,0,0), (0,0,0) ] * numPairs
white = [ (255,255,255), (0,0,0) ] * numPairs

# Fade to white
client.put_pixels(black)
client.put_pixels(black)
time.sleep(0.5)
client.put_pixels(white)
