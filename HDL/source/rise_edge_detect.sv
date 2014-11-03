// $Id: $
// File name:   rise_edge_detect.sv
// Created:     11/2/2014
// Author:      Jacob Stevens
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Detects a rising edge

module rise_edge_detect
  (
  input wire clk,
  input wire n_rst,
  input wire data_i,
  output reg rising_edge_found
  );

  reg flip1;
  reg flip2;

  always_ff @ (posedge clk, negedge n_rst)
  begin
    if (1'b0 == n_rst)
      begin
        flip1 <= 1;
        flip2 <= 1;
      end
    else
      begin
        flip1 <= data_i;
        flip2 <= flip1;
      end
  end

  assign rising_edge_found = ~flip2 & flip1;

endmodule
