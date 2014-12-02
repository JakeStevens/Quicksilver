`include "source/gpu_definitions.vh"

module gpu_output_decoder
  (
  input wire [`WIDTH_BITS-1:0] x_line_i,
  input wire [`HEIGHT_BITS-1:0] y_line_i,

  input wire [`WIDTH_BITS-1:0] x_fill_i,
  input wire [`HEIGHT_BITS-1:0] y_fill_i,
  
  input wire [`WIDTH_BITS-1:0] x_arc_i,
  input wire [`HEIGHT_BITS-1:0] y_arc_i,
  
  input wire [`WIDTH_BITS-1:0] x_circle_i,
  input wire [`HEIGHT_BITS-1:0] y_circle_i,

  input wire line_active,
  input wire fill_active,
  input wire arc_active,
  input wire circle_active,
  
  output reg [`WIDTH_BITS-1:0] x_o,
  output reg [`HEIGHT_BITS-1:0] y_o,
  output wire data_ready_o
  );
  
  assign data_ready_o = line_active | fill_active | arc_active || circle_active;
  
  always_comb
  begin
    x_o = 0;
    y_o = 0;
    if(line_active == 1'b1)
      begin
        x_o = x_line_i;
        y_o = y_line_i;
      end
    else if (fill_active == 1'b1)
      begin
        x_o = x_fill_i;
        y_o = y_fill_i;
      end
    else if (arc_active == 1'b1)
      begin
        x_o = x_arc_i;
        y_o = y_arc_i;
      end
    else if (circle_active == 1'b1)
      begin
        x_o = x_circle_i;
        y_o = y_circle_i;
      end
  end
  
endmodule
