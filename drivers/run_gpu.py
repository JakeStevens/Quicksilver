#! /usr/bin/env python3

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

def compile_and_run():
    subprocess.call(["rm", "../HDL/tb_output1.txt", "../HDL/tb_output2.txt"])
    subprocess.call(["rm", "tb_output1.txt.jpg", "tb_output2.txt.jpg"])
    print("Compiling./H driver code...")
    err = subprocess.call(["gcc", "gpu_test_large.c"])
    if err == 1:
        print("Compile Error. Run aborted...")
        return
    subprocess.call(["rm", "sim.out"])
    print("Generating SystemVerilog code from driver...")
    subprocess.call(["a.out"])
    print("Importing the code into preexisting testbench...")
    importsvfromfile()
    print("Running testbench...")
    subprocess.call(["make", "-C", "../HDL/", "clean", "sim_full_mapped"])
    print("Converting to an image...")
    subprocess.call(["../HDL/source/converttoimage.py", "../HDL/tb_output1.txt", "../HDL/tb_output2.txt"])
    print("Images created. Use eog to view tb_output1.txt.jpg and/org tb_output2.txt.jpg...")

if __name__ == "__main__":
    compile_and_run()    
