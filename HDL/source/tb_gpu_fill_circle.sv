`timescale 1ns / 10 ps
`include "source/gpu_definitions.vh"

module tb_gpu_fill_circle();
  
  localparam CLK_PERIOD = 10;
  reg tb_clk, tb_n_rst, tb_start_i, tb_done_o, tb_busy_o;
  reg [`WIDTH_BITS-1:0] tb_xC_i, tb_X_o;
  reg [`HEIGHT_BITS-1:0] tb_yC_i, tb_Y_o;
  reg [`WIDTH_BITS-1:0] tb_rad_i; 

  integer File; 
  
	gpu_fill_circle circle(.clk(tb_clk),
	                       .n_rst(tb_n_rst),
	                       .xC_i(tb_xC_i),
	                       .yC_i(tb_yC_i),
                        .rad_i(tb_rad_i),
                        .start_i(tb_start_i),
                        .done_o(tb_done_o),
                        .busy_o(tb_busy_o),
                        .X_o(tb_X_o),
                        .Y_o(tb_Y_o));
                      
  
  
  
  
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
    if(tb_busy_o == 1'b1)
      begin
        if (File)
          begin
            $fdisplay(File, "%d,%d,%d,%d,%d", tb_X_o, tb_Y_o, 255, 255, 255);
            $display("%d,%d,%d,%d,%d", tb_X_o, tb_Y_o, tb_r, tb_g, tb_b);
          end
      end
  end
  
  
  
  initial
  begin
    File = $fopen("source/tb_filledcircleout2.txt");
    if (!File)
      $display("file not opened");
    else
      $display("File opened");
      
    tb_n_rst = 1'b1;
    tb_n_rst = 1'b1;
    tb_n_rst = 1'b0;
    tb_start_i = 0;
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    
    tb_xC_i = `WIDTH_BITS'd320;
    tb_yC_i = `HEIGHT_BITS'd240;
    tb_rad_i = `WIDTH_BITS'd200;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
    
    #(CLK_PERIOD*1000000);
    
    
    $fclose(File);
    $display("File closed");
    
  end
  
  
endmodule

    


