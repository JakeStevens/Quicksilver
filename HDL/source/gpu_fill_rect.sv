module gpu_fill_rect
  (
  input wire clk,
  input wire n_rst,
  input wire [9:0] x1_i,
  input wire [8:0] y1_i,
  input wire [9:0] x2_i,
  input wire [8:0] y2_i,
  input wire [7:0] r_i,
  input wire [7:0] g_i,
  input wire [7:0] b_i,
  input wire start_i,
  output reg [9:0] x_o,
  output reg [8:0] y_o,
  output wire [7:0] r_o,
  output wire [7:0] g_o,
  output wire [7:0] b_o,
  output reg done_o,
  output reg busy_o
  );
  
  assign r_o = r_i;
  assign g_o = g_i;
  assign b_o = b_i;
  
  wire start_edge;
  
  rise_edge_detect rise(.clk(clk), .n_rst(n_rst), .data_i(start_i),
                        .rising_edge_found(start_edge));
  
  always @ (posedge clk, negedge n_rst)
  begin
    if (n_rst == 1'b0)
      begin
        done_o = 0;
        busy_o = 0;
      end
    else if (start_edge == 1'b1)
      begin
        x_o = x1_i;
        y_o = y1_i;
        busy_o = 1;
      end
    else if (start_i == 1'b1 && start_edge == 1'b0)
      if (x_o == x2_i && y_o == y2_i)
        begin
          done_o = 1;
          busy_o = 0;
        end
      else if (x_o == x2_i)
        begin
          x_o = x1_i;
          y_o = y_o + 1;
        end
      else
        x_o = x_o + 1;
    else
      done_o = 0;
      busy_o = 0;
  end
  
endmodule