`timescale 1 ns / 100 ps
`include "source/gpu_definitions.vh"

module tb_gpu_output_decoder();

//DUT port signals
reg [`WIDTH_BITS-1:0] tb_x_line;
reg [`WIDTH_BITS-1:0] tb_x_fill;
reg [`WIDTH_BITS-1:0] tb_x_arc;
reg [`WIDTH_BITS-1:0] tb_x_circle;

reg [`HEIGHT_BITS-1:0] tb_y_line;
reg [`HEIGHT_BITS-1:0] tb_y_fill;
reg [`HEIGHT_BITS-1:0] tb_y_arc;
reg [`HEIGHT_BITS-1:0] tb_y_circle;

reg [`WIDTH_BITS-1:0] tb_x_o;
reg [`HEIGHT_BITS-1:0] tb_y_o;
reg tb_line_active;
reg tb_fill_active;
reg tb_circle_active;
reg tb_arc_active;

gpu_output_decoder DUT(.x_line_i(tb_x_line),
                        .y_line_i(tb_y_line), 
                        .x_fill_i(tb_x_fill),
                        .y_fill_i(tb_y_fill),
                        .x_arc_i(tb_x_arc),
                        .y_arc_i(tb_y_arc),
                        .x_circle_i(tb_x_circle),
                        .y_circle_i(tb_y_circle),

                        .line_active(tb_line_active),
                        .fill_active(tb_fill_active),
                        .arc_active(tb_arc_active),
                        .circle_active(tb_circle_active),
                        .x_o(tb_x_o),
                        .y_o(tb_y_o),
                        .data_ready_o(tb_data_ready));
                        
initial
begin
  tb_line_active = 0;
  tb_fill_active = 0;
  tb_arc_active = 0;
  tb_circle_active = 0;
  tb_x_line = `WIDTH_BITS'd1;
  tb_y_line = `HEIGHT_BITS'd2;
  tb_x_fill = `WIDTH_BITS'd3;
  tb_y_fill = `HEIGHT_BITS'd4;
  tb_x_arc = `WIDTH_BITS'd5;
  tb_y_arc = `HEIGHT_BITS'd6;
  tb_x_circle = `WIDTH_BITS'd7;
  tb_y_circle = `HEIGHT_BITS'd8;

  #(20);
  tb_line_active = 1;
  #(20);
  if (tb_x_o == 1 && tb_y_o == 2)
    $display("Passed");
  tb_line_active = 0;
  tb_fill_active = 1;
  #(20);
  if (tb_x_o == 3 && tb_y_o == 4)
    $display("Passed");
  tb_fill_active = 0;
  tb_arc_active = 1;
  #(20);
  if (tb_x_o == 5 && tb_y_o == 6)
    $display("Passed");
  tb_arc_active = 0;
  tb_circle_active = 1;
  #(20);
  if (tb_x_o == 7 && tb_y_o == 8)
    $display("Passed");
end

endmodule
