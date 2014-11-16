#! /usr/bin/env python3.4
from PIL import Image

def getframebuffer_sv():
	pixelData = []
	with open("tb_output.txt", "r") as readFile:
		for line in readFile:
			splitLine = line.replace(" ","")
			splitLine = line.strip().split(",")
			pixelData.append(splitLine)
	return pixelstobuffer(pixelData)

def pixelstobuffer(pixelData):
	frameBuffer = [(0,0,0) for y in range(240) for x in range(320)]
	for pixel in pixelData: 
		x,y,r,g,b = pixel
		frameBuffer[int(x) + int(y)*320] = (int(r),int(g),int(b))
	return frameBuffer

def convert():
	im = Image.new("RGB", (320,240))
	data = getframebuffer_sv()
	im.putdata(data)
	im.save("img.jpg") 

if __name__ == "__main__":
	convert()
