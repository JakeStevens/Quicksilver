// $Id: $
// File name:   gpu_draw_line.sv
// Created:     10/9/2014
// Author:      Manik Singhal Jacob Stevens Erik Swan
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: basic bresenham implementation in verilog

`include "source/gpu_definitions.vh"

module gpu_draw_line
  (
  input wire clk,
  input wire n_rst,
  input wire [`WIDTH_BITS-1:0] x1,
  input wire [`HEIGHT_BITS-1:0] y1,
  input wire [`WIDTH_BITS-1:0] x2,
  input wire [`HEIGHT_BITS-1:0] y2,
  /*
  input wire [`CHANNEL_BITS-1:0] r_i,
  input wire [`CHANNEL_BITS-1:0] g_i,
  input wire [`CHANNEL_BITS-1:0] b_i,
  */
  input wire start,
  output wire done,
  output wire busy,
  output wire [`WIDTH_BITS-1:0] X,
  output wire [`HEIGHT_BITS-1:0] Y
  /*
  output wire [`CHANNEL_BITS-1:0] r_o,
  output wire [`CHANNEL_BITS-1:0] g_o,
  output wire [`CHANNEL_BITS-1:0] b_o
  */
  );
  
  reg signed [`WIDTH_BITS+1:0] dx, err, e2;
  reg signed [`HEIGHT_BITS+1:0] dy;
  reg signed [1:0] sx, sy;
  reg reg_done, reg_busy;
  reg signed [`WIDTH_BITS-1:0] rX;
  reg signed [`HEIGHT_BITS-1:0] rY;
  wire start_edge;
  
  /*
  assign r_o = r_i;
  assign g_o = g_i;
  assign b_o = b_i;
  */
  
  assign X =  rX;
  assign Y = rY;
  assign busy = reg_busy;
  assign done = reg_done;
  assign dx = (x2 >= x1) ? (x2 - x1):(x1 - x2);
  assign dy = (y2 >= y1) ? (y2 - y1):(y1 - y2);
  
  assign sx = (x1 < x2) ? 2'd1:-2'd1;
  assign sy = (y1 < y2) ? 2'd1:-2'd1;
  
  rise_edge_detect rise(.clk(clk), .n_rst(n_rst), .data_i(start),
			.rising_edge_found(start_edge));  

  always @ (posedge clk, negedge n_rst)
  begin
    if (!n_rst)
      begin
        reg_done <= 0;
        reg_busy <= 0;
        rX <= `WIDTH_BITS'd`WIDTH;
        rY <= `HEIGHT'd`HEIGHT;
        e2 <= 0;
      end    
    else
      begin
        if (start_edge)
          begin
            rX <= x1;
            rY <= y1;
            e2 <= (dx > dy) ? (dx >>> 1) : ((0-dy) >>> 1);
            reg_busy <= 1'b1;
            reg_done <= 1'b0;
          end
        else if (start == 1'b1 && start_edge == 1'b0 && reg_busy == 1'b1)
          begin
            if (rX == x2 && rY == y2)
              begin
                reg_done <= 1'b1;
                reg_busy <= 1'b0;
              end
            else
              begin
                reg_busy <= 1'b1;
                if ((e2 + dx > (0)) && (e2 < dy))
                  begin
                    e2 <= e2 - dy + dx;
                    rX <= rX + sx;
                    rY <= rY + sy;
                  end
                else if (e2 + dx > (0))
                  begin
                    e2 <= e2 - dy;
                    rX <= rX + sx;
                    rY <= rY;
                  end
                else if (e2 < dy)
                  begin
                    e2 <= e2 + dx;
                    rX <= rX;
                    rY <= rY + sy;
                  end
                else
                  begin
                    e2 <= e2;
                    rY <= rY;
                    rX <= rX;
                  end
              end
          end 
        else
          reg_done <= 1'b0;
      end
  end
  
endmodule
