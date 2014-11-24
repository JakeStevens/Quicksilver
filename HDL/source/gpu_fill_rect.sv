`include "/home/ecegrid/a/mg118/ece337/Quicksilver/HDL/source/gpu_definitions.vh"

module gpu_fill_rect
  (
  input wire clk,
  input wire n_rst,
  input wire [`WIDTH_BITS-1:0] x1_i,
  input wire [`HEIGHT_BITS-1:0] y1_i,
  input wire [`WIDTH_BITS-1:0] x2_i,
  input wire [`HEIGHT_BITS-1:0] y2_i,
  /*
  input wire [`CHANNEL_BITS-1:0] r_i,
  input wire [`CHANNEL_BITS-1:0] g_i,
  input wire [`CHANNEL_BITS-1:0] b_i,
  */
  input wire start_i,
  output reg [`WIDTH_BITS-1:0] x_o,
  output reg [`HEIGHT_BITS-1:0] y_o,
  /*
  output wire [`CHANNEL_BITS-1:0] r_o,
  output wire [`CHANNEL_BITS-1:0] g_o,
  output wire [`CHANNEL_BITS-1:0] b_o,
  */
  output reg done_o,
  output reg busy_o
  );
  
  /*
  assign r_o = r_i;
  assign g_o = g_i;
  assign b_o = b_i;
  */
  
  wire start_edge;
  
  rise_edge_detect rise(.clk(clk), .n_rst(n_rst), .data_i(start_i),
                        .rising_edge_found(start_edge));
  
  always @ (posedge clk, negedge n_rst)
  begin
    if (n_rst == 1'b0)
      begin
        done_o <= 0;
        busy_o <= 0;
      end
    else
      begin
        if (start_edge == 1'b1)
          begin
            x_o <= x1_i;
            y_o <= y1_i;
            busy_o <= 1;
          end
        else if (start_i == 1'b1 && start_edge == 1'b0)
          if ((x_o == x2_i && y_o == y2_i) ||
              (y_o == `HEIGHT_BITS'd`HEIGHT))
            begin
             done_o <= 1;
              busy_o <= 0;
            end
          else if (x_o == x2_i || x_o == `WIDTH_BITS'd`WIDTH)
           begin
             x_o <= x1_i;
             y_o <= y_o + 1;
             busy_o <= 1;
           end
         else
           begin
            x_o <= x_o + 1;
            y_o <= y_o;
            busy_o <= 1;
          end
        else
          begin
            done_o <= 0;
            busy_o <= 0;
          end
      end
  end
  
endmodule