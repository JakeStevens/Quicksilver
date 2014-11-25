#! /usr/bin/env python3
from PIL import Image
import re

def getframebuffer_sv():
	pixelData = []
	with open("../HDL/tb_output.txt", "r") as readFile:
		for line in readFile:
			splitLine = line.replace(" ","")
			splitLine = line.strip().split(",")
			pixelData.append(splitLine)
	return pixelstobuffer(pixelData)

def getColorChannelSize():
	with open('../HDL/source/gpu_definitions.vh', 'r') as readFile:
		lines = readFile.read()
		expr = r'\s+?`define\sCHANNEL_BITS\s(?P<bits>\d+)'
		match = re.search(expr, lines)
		return int(match.group('bits'))
		

def pixelstobuffer(pixelData):
	frameBuffer = [(0,0,0) for y in range(480) for x in range(640)]
	for pixel in pixelData: 
		addr,rgb = pixel
		addr, rgb = int(addr), int(rgb)
		channelsize = getColorChannelSize()
		b = rgb & (2**channelsize - 1)
		g = (rgb >> channelsize) & (2**channelsize - 1)
		r = (rgb >> 2*channelsize) & (2**channelsize - 1)
		frameBuffer[addr] = (int(r),int(g),int(b))
	return frameBuffer

def convert():
	im = Image.new("RGB", (640,480))
	data = getframebuffer_sv()
	im.putdata(data)
	im.save("img.jpg") 

if __name__ == "__main__":
	convert()
