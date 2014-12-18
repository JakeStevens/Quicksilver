`timescale 1 ns / 100 ps
`include "source/gpu_definitions.vh"

module tb_gpu_memcontroller();
  reg tb_clk, tb_n_rst, tb_data_out;
  reg [`CHANNEL_BITS - 1:0] tb_rdata, tb_gdata, tb_bdata;
  reg [`WIDTH_BITS - 1:0] tb_adddatax;
  reg [`HEIGHT_BITS - 1:0] tb_adddatay;
  reg tb_flush, tb_CE1, tb_CE0, tb_LB, tb_R_W, tb_UB, tb_ZZ, tb_SEM, tb_OE;
  reg [3*(`CHANNEL_BITS) - 1: 0] tb_rgbout;
  reg [`HEIGHT_BITS + `WIDTH_BITS:0] tb_addout;
  localparam CLK_PERIOD = 10;
  
  gpu_memcontroller DUT(
  .clk(tb_clk),
  .n_rst(tb_n_rst),
  .data_out(tb_data_out),
  .rdata(tb_rdata),
  .gdata(tb_gdata),
  .bdata(tb_bdata),
  .adddatax(tb_adddatax),
  .adddatay(tb_adddatay),
  .flush(tb_flush),
  .CE1(tb_CE1),
  .CE0(tb_CE0),
  .LB(tb_LB),
  .UB(tb_UB),
  .R_W(tb_R_W),
  .ZZ(tb_ZZ),
  .SEM(tb_SEM),
  .OE(tb_OE),
  .rgbdataout(tb_rgbout),
  .adddataout(tb_addout)
  );
  
  
  always
  begin
      tb_clk = 1'b0;
      #(CLK_PERIOD/2.0);
      tb_clk = 1'b1;
      #(CLK_PERIOD/2.0);
  end
  
  
  initial
  begin
    tb_n_rst = 1'b0;
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    tb_data_out = 1'b1;
    tb_flush = 1'b0;
    //colors;
    tb_rdata = `CHANNEL_BITS'd255;
    tb_gdata = `CHANNEL_BITS'd255;
    tb_bdata = `CHANNEL_BITS'd255;
    //pixels
    tb_adddatax = `WIDTH_BITS'd0;
    tb_adddatay = `HEIGHT_BITS'd0;
    #(CLK_PERIOD);
    tb_adddatax = `WIDTH_BITS'd100;
    tb_adddatay = `HEIGHT_BITS'd100;
    #(CLK_PERIOD);
    tb_adddatax = `WIDTH_BITS'd20;
    tb_adddatay = `HEIGHT_BITS'd30;
    #(CLK_PERIOD);
    tb_adddatax = `WIDTH_BITS'd450;
    tb_adddatay = `HEIGHT_BITS'd230;
    #(CLK_PERIOD);
    tb_adddatax = `WIDTH_BITS'd267;
    tb_adddatay = `HEIGHT_BITS'd23;
    #(CLK_PERIOD);
    tb_adddatax = `WIDTH_BITS'd324;
    tb_adddatay = `HEIGHT_BITS'd220;
    #(CLK_PERIOD);
    tb_flush = 1'b1;
    tb_adddatax = `WIDTH_BITS'd0;
    tb_adddatay = `HEIGHT_BITS'd0;
    #(CLK_PERIOD);
    tb_flush = 1'b0;
    tb_adddatax = `WIDTH_BITS'd100;
    tb_adddatay = `HEIGHT_BITS'd100;
    #(CLK_PERIOD);
    tb_adddatax = `WIDTH_BITS'd20;
    tb_adddatay = `HEIGHT_BITS'd30;
    #(CLK_PERIOD);
    tb_adddatax = `WIDTH_BITS'd450;
    tb_adddatay = `HEIGHT_BITS'd230;
    #(CLK_PERIOD);
    tb_adddatax = `WIDTH_BITS'd267;
    tb_adddatay = `HEIGHT_BITS'd23;
    #(CLK_PERIOD);
    tb_adddatax = `WIDTH_BITS'd324;
    tb_adddatay = `HEIGHT_BITS'd220;
    #(CLK_PERIOD);
  end
  
endmodule
    
    
  
