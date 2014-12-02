#! /usr/bin/env python3
from PIL import Image
import re
import argparse

def getframebuffer_sv(filename):
	pixelData = []
	with open(filename, "r") as readFile:
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
	
		if args.unpacked:
			x,y,r,g,b = [int(z) for z in pixel]
			addr = y*640 + x
		else:
			addr,rgb = [int(z) for z in pixel]
			channelsize = getColorChannelSize()
			b = rgb & (2**channelsize - 1)
			g = (rgb >> channelsize) & (2**channelsize - 1)
			r = (rgb >> 2*channelsize) & (2**channelsize - 1)

		if addr >= 480*640:
			addr = addr - 640*480
			
		frameBuffer[addr] = (int(r),int(g),int(b))
	return frameBuffer

def convert(filenamein, filenameout):
	im = Image.new("RGB", (640,480))
	data = getframebuffer_sv(filenamein)
	im.putdata(data)
	im.save(filenameout) 

if __name__ == "__main__":

	parser = argparse.ArgumentParser(description='Convert testbench output into a JPEG image')
	parser.add_argument('file', help='The file to convert')
	parser.add_argument('--unpacked', help='Whether the address data in the input file is in unpacked format', action='store_true')
	args = parser.parse_args()
  
	convert(args.file, 'img.jpg')
