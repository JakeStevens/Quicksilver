`timescale 1ns / 10 ps
`include "source/gpu_definitions.vh"

module tb_filledcircle();
  
  localparam CLK_PERIOD = 10;
  reg tb_clk, tb_n_rst, tb_start_i, tb_done_o, tb_busy_o;
  reg [`WIDTH_BITS-1:0] tb_xC_i, tb_X_o;
  reg [`HEIGHT_BITS-1:0] tb_yC_i, tb_Y_o;
  reg [`WIDTH_BITS-1:0] tb_rad_i; 
  reg [`CHANNEL_BITS-1:0] tb_r, tb_r_o;
  reg [`CHANNEL_BITS-1:0] tb_g, tb_g_o;
  reg [`CHANNEL_BITS-1:0] tb_b, tb_b_o;
  integer File; 
  
  filledcircle circle(.clk(tb_clk), .n_rst(tb_n_rst),.xC(tb_xC_i),.yC(tb_yC_i),
                      .rad(tb_rad_i), .r_i(tb_r), .g_i(tb_g), .b_i(tb_b), 
                      .start(tb_start_i), .done(tb_done_o), .busy(tb_busy_o),
                      .X(tb_X_o), .Y(tb_Y_o), .r_o(tb_r_o), .g_o(tb_g_o), .b_o(tb_b_o));
                      
  
  
  
  
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
            $fdisplay(File, "%d,%d,%d,%d,%d", tb_X_o, tb_Y_o, tb_r_o, tb_g_o, tb_b_o);
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
    tb_r = `CHANNEL_BITS'd255;
    tb_g = `CHANNEL_BITS'd255;
    tb_b = `CHANNEL_BITS'd255;
    tb_start_i = 0;
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    
    tb_xC_i = `WIDTH_BITS'd320;
    tb_yC_i = `HEIGHT_BITS'd240;
    tb_rad_i = `WIDTH_BITS'd200;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
    
    #(CLK_PERIOD*100000);
    
    
    $fclose(File);
    $display("File closed");
    
  end
  
  
endmodule

    


