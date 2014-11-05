`include "/home/ecegrid/a/mg115/ece337/Quicksilver/HDL/source/gpu_definitions.vh"

module gpu_output_decoder
  (
  input wire [`WIDTH_BITS-1:0] x_line_i,
  input wire [`HEIGHT_BITS-1:0] y_line_i,
  input wire [`CHANNEL_BITS-1:0] r_line_i,
  input wire [`CHANNEL_BITS-1:0] g_line_i,
  input wire [`CHANNEL_BITS-1:0] b_line_i,
  input wire [`WIDTH_BITS-1:0] x_fill_i,
  input wire [`HEIGHT_BITS-1:0] y_fill_i,
  input wire [`CHANNEL_BITS-1:0] r_fill_i,
  input wire [`CHANNEL_BITS-1:0] g_fill_i,
  input wire [`CHANNEL_BITS-1:0] b_fill_i,
  input wire line_active,
  input wire fill_active,
  output reg [`WIDTH_BITS-1:0] x_o,
  output reg [`HEIGHT_BITS-1:0] y_o,
  output reg [`CHANNEL_BITS-1:0] r_o,
  output reg [`CHANNEL_BITS-1:0] g_o,
  output reg [`CHANNEL_BITS-1:0] b_o
  );
  
  always_comb
  begin
    if(line_active == 1'b1)
      begin
        x_o = x_line_i;
        y_o = y_line_i;
        r_o = r_line_i;
        g_o = g_line_i;
        b_o = b_line_i;
      end
    else if (fill_active == 1'b1)
      begin
        x_o = x_fill_i;
        y_o = y_fill_i;
        r_o = r_fill_i;
        g_o = g_fill_i;
        b_o = b_fill_i;
      end
  end
  
endmodule