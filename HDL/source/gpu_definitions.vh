// File name:   gpu_definitions.vh
// Created:     12/15/2014
// Author:      Manik Singhal Jake Stevens Erik Swan
// Lab Section: 337-04
// Version:     1.0  ECE337 Final Project Version
// Description: Definitions used in Verilog for GPU

//Define the WIDTH of the resolution targeted
`ifndef WIDTH
  `define WIDTH 320
`endif

//Define the HEIGHT of the resolution targeted
`ifndef HEIGHT
  `define HEIGHT 240
`endif

//Define the number of bits used for the X coord (log2 of WIDTH)
`ifndef WIDTH_BITS
  `define WIDTH_BITS 9
`endif

//Define the number of bits used for the Y coord (log2 of HEIGHT)
`ifndef HEIGHT_BITS
  `define HEIGHT_BITS 8
`endif 

//Define the number of bits used for a single color channel
`ifndef CHANNEL_BITS
  `define CHANNEL_BITS 8
`endif

//Define the number of bits used for the X+Y coord (log2 of HEIGHT*Width)
`ifndef SUM_BITS
  `define SUM_BITS 17 //(HEIGHT_BITS + WIDTH_BITS)
`endif

//Define the number of bits used for the X*Y offset (log2 of HEIGHT*Width)
`ifndef OFFSETMEM
  `define OFFSETMEM 76800 //(HEIGHT*WIDTH)
`endif

