`timescale 1ns / 10 ps
`include "/home/ecegrid/a/mg118/ece337/Quicksilver/HDL/source/gpu_definitions.vh"

module tb_gpu_octantdraw();
  
  localparam CLK_PERIOD = 10;
  reg tb_clk, tb_n_rst, tb_start_i, tb_done_o, tb_busy_o;
  reg [2:0] tb_oct_i;
  reg [`WIDTH_BITS-1:0] tb_xC_i, tb_X_o;
  reg [`HEIGHT_BITS-1:0] tb_yC_i, tb_Y_o;
  reg [`WIDTH_BITS-1:0] tb_rad_i; 

  integer File; 
  
  gpu_octantdraw circle(.clk(tb_clk), .n_rst(tb_n_rst),.xC(tb_xC_i),.yC(tb_yC_i),
                      .rad(tb_rad_i),.oct(tb_oct_i), 
                      .start(tb_start_i), .done_o(tb_done_o), .busy_o(tb_busy_o),
                      .X(tb_X_o), .Y(tb_Y_o));
                      
  
  
  
  
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
            $fdisplay(File, "%d,%d", tb_X_o, tb_Y_o);
            $display("%d,%d", tb_X_o, tb_Y_o);
          end
      end
  end
  
  
  
  initial
  begin
    File = $fopen("source/tb_filledcircleout.txt");
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
    tb_oct_i = 3'b000;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
    
    #(CLK_PERIOD*100000);
    tb_start_i = 0;
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    
    tb_xC_i = `WIDTH_BITS'd320;
    tb_yC_i = `HEIGHT_BITS'd240;
    tb_rad_i = `WIDTH_BITS'd200;
    tb_oct_i = 3'b001;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
    
    #(CLK_PERIOD*100000);
    tb_start_i = 0;
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    
    tb_xC_i = `WIDTH_BITS'd320;
    tb_yC_i = `HEIGHT_BITS'd240;
    tb_rad_i = `WIDTH_BITS'd200;
    tb_oct_i = 3'b010;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
    
    #(CLK_PERIOD*100000);
    tb_start_i = 0;
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    
    tb_xC_i = `WIDTH_BITS'd320;
    tb_yC_i = `HEIGHT_BITS'd240;
    tb_rad_i = `WIDTH_BITS'd200;
    tb_oct_i = 3'b011;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
    
    #(CLK_PERIOD*100000);
    tb_start_i = 0;  
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    
    tb_xC_i = `WIDTH_BITS'd320;
    tb_yC_i = `HEIGHT_BITS'd240;
    tb_rad_i = `WIDTH_BITS'd200;
    tb_oct_i = 3'b100;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
    
    #(CLK_PERIOD*100000);
    tb_start_i = 0;
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    
    tb_xC_i = `WIDTH_BITS'd320;
    tb_yC_i = `HEIGHT_BITS'd240;
    tb_rad_i = `WIDTH_BITS'd200;
    tb_oct_i = 3'b101;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
    
    #(CLK_PERIOD*100000);
    tb_start_i = 0; 
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    
    tb_xC_i = `WIDTH_BITS'd320;
    tb_yC_i = `HEIGHT_BITS'd240;
    tb_rad_i = `WIDTH_BITS'd200;
    tb_oct_i = 3'b110;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
    
    #(CLK_PERIOD*100000);
    tb_start_i = 0;  
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    
    tb_xC_i = `WIDTH_BITS'd320;
    tb_yC_i = `HEIGHT_BITS'd240;
    tb_rad_i = `WIDTH_BITS'd200;
    tb_oct_i = 3'b111;
    #(CLK_PERIOD);
    
    tb_start_i = 1;
    
    #(CLK_PERIOD*100000);
    tb_start_i = 0;     
    
    
    $fclose(File);
    $display("File closed");
    
  end
  
  
endmodule
