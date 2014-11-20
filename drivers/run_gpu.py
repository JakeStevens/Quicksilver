#! /usr/bin/env python3.4

import subprocess
import re

def importsvfromfile():
    expr = r"//{insert commands here}"
    commandFile = open("sim.out", "r")
    #load the commands from sim.out
    commands = commandFile.read()
    commandFile.close()
    #load the test bench
    tbFile = open("../HDL/source/tb_gpu_template.sv", "r")
    tb_lines = tbFile.read()
    tbFile.close()

    #insert the commands into the existing text
    tb_lines = re.sub(expr, commands, tb_lines)

    #save the new tb lines
    outFile = open("../HDL/source/tb_gpu.sv", "w")
    outFile.write(tb_lines)
    outFile.close()

print("Compiling driver code...")
subprocess.call(["gcc", "gpu_test_main.c"])
subprocess.call(["rm", "sim.out"])
print("Generating SystemVerilog code from driver...")
subprocess.call(["a.out"])
print("Importing the code into preexisting testbench...")
importsvfromfile()
print("Running testbench...")
subprocess.call(["make", "-C", "../HDL/", "clean", "sim_full_mapped"])
print("Converting to an image...")
subprocess.call(["../HDL/source/converttoimage.py"])
print("Displaying image...")
subprocess.call(["eog", "img.jpg"])
