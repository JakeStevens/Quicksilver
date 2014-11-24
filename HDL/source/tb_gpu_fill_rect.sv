`timescale 1ns / 10 ps
`include "/home/ecegrid/a/mg115/ece337/Quicksilver/HDL/source/gpu_definitions.vh"

module tb_gpu_fill_rect();
  
  //define local parameters
  localparam CLK_PERIOD = 10;
  
  //Define DUT ports
  reg tb_clk;
  reg tb_n_rst;
  reg [`WIDTH_BITS-1:0] tb_x1_i;
  reg [`HEIGHT_BITS-1:0] tb_y1_i;
  reg [`WIDTH_BITS-1:0] tb_x2_i;
  reg [`HEIGHT_BITS-1:0] tb_y2_i;
  reg tb_start_i;
  reg [`WIDTH_BITS-1:0] tb_x_o;
  reg [`HEIGHT_BITS-1:0] tb_y_o;
  reg tb_done;
  reg tb_busy;
  integer File; 
  
  gpu_fill_rect fill(.clk(tb_clk), .n_rst(tb_n_rst), .x1_i(tb_x1_i), .y1_i(tb_y1_i),
                      .x2_i(tb_x2_i), .y2_i(tb_y2_i), .start_i(tb_start_i),
                      .x_o(tb_x_o), .y_o(tb_y_o),
                      .done_o(tb_done),
                      .busy_o(tb_busy));
         
         
  always
  begin
      tb_clk = 1'b0;
      #(CLK_PERIOD/2.0);
      tb_clk = 1'b1;
      #(CLK_PERIOD/2.0);
  end
  
  always
  begin
    @ (posedge tb_clk);
    if(tb_busy == 1'b1)
      begin
        if (File)
          begin
            $fdisplay(File, "%d,%d", tb_x_o, tb_y_o,);
            $display("%d,%d", tb_x_o, tb_y_o);
          end
      end
  end
  
  initial
  begin
    File = $fopen("/home/ecegrid/a/mg115/ece337/Quicksilver/HDL/source/tb_fill_output.txt");
    if (!File)
      $display("file not opened");
    else
      $display("File opened");
    tb_n_rst = 1'b1;
    tb_n_rst = 1'b0;
    tb_start_i = 0;
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    
    tb_x1_i = 0;
    tb_y1_i = 0;
    tb_x2_i = `WIDTH_BITS'd5;
    tb_y2_i = `HEIGHT_BITS'd6;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
    
    #(CLK_PERIOD * 50);
    
    $fclose(File);
    $display("File closed");
  end
  
                        
endmodule
