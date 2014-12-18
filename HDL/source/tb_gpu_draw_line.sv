// $Id: $
// File name:   tb_Bresenham.sv
// Created:     10/9/2014
// Author:      Manik Singhal
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: test bench for bresenham algo
`timescale 1 ns / 10 ps
`include "source/gpu_definitions.vh"

module tb_gpu_draw_line ();
  
  reg tb_clk, tb_nrst, tb_start, tb_done, tb_busy;
  reg [`WIDTH_BITS - 1:0] tb_x0, tb_x1, tb_X;
  reg [`HEIGHT_BITS - 1:0] tb_y0, tb_y1, tb_Y;
  
  bresenham DUT (.clk(tb_clk),.n_rst(tb_nrst),.x0(tb_x0),.y0(tb_y0),.x1(tb_x1),.y1(tb_y1),.X(tb_X),.Y(tb_Y),.start(tb_start),.done(tb_done),.busy(tb_busy));
  
  always 
  begin
    tb_clk = 1'b0;
    #(5);
    tb_clk = 1'b1;
    #5;
  end
  
  
  initial
  begin
    tb_nrst = 1'b0;
    #10;
    tb_nrst = 1'b1;
    tb_x0 = 0;
    tb_y0 = 0;
    tb_x1 = `WIDTH_BITS'd9;
    tb_y1 = `HEIGHT_BITS'd9;
    #10;
    tb_start = 1'b1;
    #7.5
    tb_start = 1'b0;
    #200;
    tb_nrst = 1'b0;
    #10;
    tb_nrst = 1'b1;
    tb_x0 = `WIDTH_BITS'd8;
    tb_y0 = `HEIGHT_BITS'd8;
    tb_x1 = `WIDTH_BITS'd0;
    tb_y1 = `HEIGHT_BITS'd0;
    
    @(posedge tb_clk);
    tb_start = 1'b1;
    @(posedge tb_clk);
    #7.5
    tb_start = 1'b0;
    #1000;
  end
  
endmodule
  
