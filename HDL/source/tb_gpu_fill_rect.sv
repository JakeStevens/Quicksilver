`timescale 1ns / 10 ps
module tb_gpu_fill_rect();
  
  //define local parameters
  localparam CLK_PERIOD = 10;
  
  //Define DUT ports
  reg tb_clk;
  reg tb_n_rst;
  reg [9:0] tb_x1_i;
  reg [8:0] tb_y1_i;
  reg [9:0] tb_x2_i;
  reg [8:0] tb_y2_i;
  reg tb_start_i;
  reg [9:0] tb_x_o;
  reg [8:0] tb_y_o;
  reg tb_done;
  reg tb_busy;
  
  gpu_fill_rect fill(.clk(tb_clk), .n_rst(tb_n_rst), .x1_i(tb_x1_i), .y1_i(tb_y1_i),
                      .x2_i(tb_x2_i), .y2_i(tb_y2_i), .start_i(tb_start_i),
                      .x_o(tb_x_o), .y_o(tb_y_o), .done_o(tb_done),
                      .busy_o(tb_busy));
         
         
  always
  begin
      tb_clk = 1'b0;
      #(CLK_PERIOD/2.0);
      tb_clk = 1'b1;
      #(CLK_PERIOD/2.0);
  end
  
  initial
  begin
    tb_n_rst = 1'b1;
    tb_n_rst = 1'b0;
    tb_start_i = 0;
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    
    tb_x1_i = 0;
    tb_y1_i = 0;
    tb_x2_i = 10'd5;
    tb_y2_i = 9'd5;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
  end
                        
endmodule