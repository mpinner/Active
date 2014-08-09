#!/usr/bin/python
from PIL import Image, ImageStat


import sys, getopt



def is_color_image(file, thumb_size=40, MSE_cutoff=22, adjust_color_bias=True):
    pil_img = Image.open(file)
    bands = pil_img.getbands()
    if bands == ('R','G','B') or bands== ('R','G','B','A'):
        thumb = pil_img.resize((thumb_size,thumb_size))
        SSE, bias = 0, [0,0,0]
        if adjust_color_bias:
            bias = ImageStat.Stat(thumb).mean[:3]
            bias = [b - sum(bias)/3 for b in bias ]
        for pixel in thumb.getdata():
            mu = sum(pixel)/3
            SSE += sum((pixel[i] - mu - bias[i])*(pixel[i] - mu - bias[i]) for i in [0,1,2])
        MSE = float(SSE)/(thumb_size*thumb_size)
        if MSE <= MSE_cutoff:
            print "grayscale\t",
            return False
        else:
            print "Color\t\t\t",
        print "( MSE=",MSE,")"
    elif len(bands)==1:
        print "Black and white", bands
        return False
    else:
        print "Don't know...", bands

    return True


def main(argv):
	print 'HI List:', argv


	inputfile = argv[1]


	im = Image.open(inputfile)
	
	# this is clearly a terrible idea
	#im = im.rotate(45)

	# this does 
	#im = im.convert('1')   #this converts to 1-bit B&Ws

	if is_color_image(inputfile):
		im = im.convert('LA')   #this converts to grey scale

	im = im.resize((60,24))

	im.save('outfile.png')	

	#if (env.)


    
	im.show()



if __name__ == "__main__":

	print 'Number of arguments:', len(sys.argv), 'arguments.'
	print 'Argument List:', str(sys.argv)
   	main(sys.argv)

