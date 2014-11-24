`timescale 1 ns / 100 ps
`include "source/gpu_definitions.vh"

module tb_gpu_output_decoder();

//DUT port signals
reg [`WIDTH_BITS-1:0] tb_x_line;
reg [`WIDTH_BITS-1:0] tb_x_fill;
reg [`HEIGHT_BITS-1:0] tb_y_line;
reg [`HEIGHT_BITS-1:0] tb_y_fill;
reg [`CHANNEL_BITS-1:0] tb_r_line;
reg [`CHANNEL_BITS-1:0] tb_g_line;
reg [`CHANNEL_BITS-1:0] tb_b_line;
reg [`CHANNEL_BITS-1:0] tb_r_fill;
reg [`CHANNEL_BITS-1:0] tb_g_fill;
reg [`CHANNEL_BITS-1:0] tb_b_fill;
reg [`CHANNEL_BITS-1:0] tb_r_o;
reg [`CHANNEL_BITS-1:0] tb_g_o;
reg [`CHANNEL_BITS-1:0] tb_b_o;
reg [`WIDTH_BITS-1:0] tb_x_o;
reg [`HEIGHT_BITS-1:0] tb_y_o;
reg tb_line_active;
reg tb_fill_active;

gpu_output_decoder DUT(.x_line_i(tb_x_line), .y_line_i(tb_y_line), .r_line_i(tb_r_line),
                        .g_line_i(tb_g_line), .b_line_i(tb_b_line), .x_fill_i(tb_x_fill),
                        .y_fill_i(tb_y_fill), .r_fill_i(tb_r_fill), .g_fill_i(tb_g_fill),
                        .b_fill_i(tb_b_fill), .line_active(tb_line_active), .fill_active(tb_fill_active),
                        .x_o(tb_x_o), .y_o(tb_y_o), .r_o(tb_r_o), .g_o(tb_g_o), .b_o(tb_b_o));
                        
initial
begin
  tb_line_active = 0;
  tb_fill_active = 0;
  tb_x_line = `WIDTH_BITS'd15;
  tb_x_fill = `WIDTH_BITS'd190;
  tb_y_line = `HEIGHT_BITS'd300;
  tb_y_fill = `HEIGHT_BITS'd410;
  tb_r_line = `CHANNEL_BITS'd5;
  tb_g_line = `CHANNEL_BITS'd6;
  tb_b_line = `CHANNEL_BITS'd7;
  tb_r_fill = `CHANNEL_BITS'd8;
  tb_g_fill = `CHANNEL_BITS'd9;
  tb_b_fill = `CHANNEL_BITS'd10;
  #(20);
  tb_line_active = 1;
  #(20);
  tb_line_active = 0;
  tb_fill_active = 1;
  #(20);
  tb_fill_active = 0;
  #(20);
end

endmodule
