`timescale 1ns / 10 ps
`include "source/gpu_definitions.vh"

module tb_gpu();
  //Define Local Parameters
  localparam CLK_PERIOD = 10;
  
  //Define DUT ports
  reg tb_clk;
  reg tb_n_rst;
  reg [31:0] tb_pAddr;
  reg [31:0] tb_pDataWrite;
  reg tb_pSel;
  reg tb_pEnable;
  reg tb_pWrite;
  reg [`WIDTH_BITS-1:0] tb_x;
  reg [`HEIGHT_BITS-1:0] tb_y;
  reg [`CHANNEL_BITS-1:0] tb_r, tb_g, tb_b;
  integer File;
  
  
  gpu DUT(.clk(tb_clk), .n_rst(tb_n_rst), .pAddr_i(tb_pAddr), .pDataWrite_i(tb_pDataWrite),
              .pSel_i(tb_pSel), .pEnable_i(tb_pEnable), .pWrite_i(tb_pWrite),
              .x_o(tb_x), .y_o(tb_y), .r_o(tb_r), .g_o(tb_g), .b_o(tb_b),
              .data_avail(tb_busy));
              
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
              $fdisplay(File, "%d,%d,%d,%d,%d", tb_x, tb_y, tb_r, tb_g, tb_b);
              $display("%d,%d,%d,%d,%d", tb_x, tb_y, tb_r, tb_g, tb_b);
            end
          end
    end
    
    initial
    begin
      File = $fopen("tb_output.txt");
        if (!File)
          $display("file not opened");
        else
          $display("File opened");
      tb_n_rst = 1'b1;
      tb_n_rst = 1'b0;
      #(CLK_PERIOD);
      tb_n_rst = 1'b1;
      
      tb_pAddr = 1'b0;
      tb_pDataWrite = 1'b0;
      tb_pSel = 1'b0;
      tb_pEnable = 1'b0;
      tb_pWrite = 1'b0;
      
      
      @(posedge tb_clk);
      
//{insert commands here}
      
      //Update this based on how many items are drawn
      //Basically, everything must be drawn before you close
      #(CLK_PERIOD * 10000);
      $fclose(File);
      $display("File closed");
    end
  
  
endmodule
