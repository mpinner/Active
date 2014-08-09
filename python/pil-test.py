from PIL import Image
im = Image.open("bride.jpg")
im.rotate(45).show()

pilImage=Image.open(inputImage)
pilImage = pilImage.convert('1')   #this convert to black&white
pilImage.draft('L',(500,500))

pilImage.save('outfile.png')