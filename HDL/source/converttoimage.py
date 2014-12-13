#! /usr/bin/env python3
from PIL import Image
from intelhex import IntelHex
import re
import argparse
import os

def getframebuffer_sv(filename):
	pixelData = []
	
	if args.hex:
	  ih = IntelHex(filename)
	  channelsize = getColorChannelSize()
	  for i in range(len(ih)):
	    if ih[i]:
	      print(i)
	    pixelData.append((i, (2**24-1 if ih[i] else 0)))
	else:
	  with open(filename, "r") as readFile:
		  for line in readFile:
			  splitLine = line.replace(" ","")
			  splitLine = line.strip().split(",")
			  pixelData.append(splitLine)
	return pixelstobuffer(pixelData)

def getColorChannelSize():
	with open(os.path.join(os.path.dirname(__file__), 'gpu_definitions.vh'), 'r') as readFile:
		lines = readFile.read()
		expr = r'\s+?`define\sCHANNEL_BITS\s(?P<bits>\d+)'
		match = re.search(expr, lines)
		return int(match.group('bits'))
		
def pixelstobuffer(pixelData):
	frameBuffer = [(0,0,0) for y in range(240) for x in range(320)]
	for pixel in pixelData:
	
		if args.unpacked:# or args.hex:
			x,y,r,g,b = [int(z) for z in pixel]
			addr = y*320 + x
		else:
			addr,rgb = [int(z) for z in pixel]
			channelsize = getColorChannelSize()
			b = rgb & (2**channelsize - 1)
			g = (rgb >> channelsize) & (2**channelsize - 1)
			r = (rgb >> 2*channelsize) & (2**channelsize - 1)

		if addr >= 240*320:
			addr = addr - 240*320
			
		frameBuffer[addr] = (int(r),int(g),int(b))
	return frameBuffer

def convert(filenamein, filenameout):
	im = Image.new("RGB", (320,240))
	data = getframebuffer_sv(filenamein)
	im.putdata(data)
	im.save(filenameout) 

if __name__ == "__main__":

	parser = argparse.ArgumentParser(description='Convert testbench output into a JPEG image')
	parser.add_argument('files', help='The files to convert', nargs='+')
	parser.add_argument('-u', '--unpacked', help='Whether the address data in the input file is in unpacked format', action='store_true')
	parser.add_argument('-x', '--hex', help='If set, the input files will be interpreted as Intel HEX format', action='store_true')
	args = parser.parse_args()
  
	for f in args.files:
		convert(f, f + '.png')
