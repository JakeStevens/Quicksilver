//Define the WIDTH of the resolution targeted
`ifndef WIDTH
  `define WIDTH 640
`endif

//Define the HEIGHT of the resolution targeted
`ifndef HEIGHT
  `define HEIGHT 480
`endif

//Define the number of bits used for the X coord (log2 of WIDTH)
`ifndef WIDTH_BITS
  `define WIDTH_BITS 10
`endif

//Define the number of bits used for the Y coord (log2 of HEIGHT)
`ifndef HEIGHT_BITS
  `define HEIGHT_BITS 9
`endif 

//Define the number of bits used for a single color channel
`ifndef CHANNEL_BITS
  `define CHANNEL_BITS 8
`endif