`timescale 1ns / 10 ps
module tb_gpu_apb_interface();
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
  reg [3:0] tb_opcode;
  reg [24:0] tb_parameters;
  
  gpu_apb_interface DUT(.clk(tb_clk), .n_rst(tb_n_rst), .pAddr_i(tb_pAddr), .pDataWrite_i(tb_pDataWrite),
              .pSel_i(tb_pSel), .pEnable_i(tb_pEnable), .pWrite_i(tb_pWrite),
              .opcode_o(tb_opcode), .parameters_o(tb_parameters));
              
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
      #(CLK_PERIOD);
      tb_n_rst = 1'b1;
      
      tb_pAddr = 1'b0;
      tb_pDataWrite = 1'b0;
      tb_pSel = 1'b0;
      tb_pEnable = 1'b0;
      tb_pWrite = 1'b0;
      
      
      //Write random value to the gpu
      @(posedge tb_clk);
      #(2);
      tb_pDataWrite = 32'b10010001110001110001111111001111;
      tb_pSel = 1'b1;
      tb_pWrite = 1'b1;
      #(CLK_PERIOD);
      tb_pEnable = 1'b1;
      #(CLK_PERIOD);
      
      tb_pDataWrite = 32'b0;
      tb_pSel = 1'b0;
      tb_pEnable = 1'b0;
      tb_pWrite = 1'b0;
      
      #(CLK_PERIOD);
      
      //Write all ones to the gpu
      @(posedge tb_clk);
      #(2);
      tb_pDataWrite = 32'b11111111111111111111111111111111;
      tb_pSel = 1'b1;
      tb_pWrite = 1'b1;
      #(CLK_PERIOD);
      tb_pEnable = 1'b1;
      #(CLK_PERIOD);
      
      tb_pDataWrite = 1'b0;
      tb_pSel = 1'b0;
      tb_pEnable = 1'b0;
      tb_pWrite = 1'b0;
      
      #(CLK_PERIOD);
      
      //Write all zeroes to the gpu
      @(posedge tb_clk);
      #(2);
      tb_pDataWrite = 32'b00000000000000000000000000000000;
      tb_pSel = 1'b1;
      tb_pWrite = 1'b1;
      #(CLK_PERIOD);
      tb_pEnable = 1'b1;
      #(CLK_PERIOD);
      
      tb_pDataWrite = 32'b0;
      tb_pSel = 1'b0;
      tb_pEnable = 1'b0;
      tb_pWrite = 1'b0;
      
      #(CLK_PERIOD);
      
      //Be writing, but not to the gpu
      @(posedge tb_clk);
      #(2);
      tb_pDataWrite = 32'b11111111111111111111111111111111;
      tb_pSel = 1'b0;
      tb_pWrite = 1'b1;
      #(CLK_PERIOD);
      tb_pEnable = 1'b1;
      #(CLK_PERIOD);
      
      
      //Write data to the gpu
      tb_pDataWrite = 32'b10101010101010101010101010101010;
      tb_pSel = 1'b1;
      tb_pEnable = 1'b0;
      tb_pWrite = 1'b1;
      
      #(CLK_PERIOD);
      tb_pEnable = 1'b1;
      #(CLK_PERIOD);
      tb_pEnable = 1'b0;
      
      //Write again without clearing Select, mimicking back to back writes
      
      tb_pDataWrite = 32'b00011100011100011100010101010101;
      #(CLK_PERIOD);
      tb_pEnable = 1'b1;
      #(CLK_PERIOD);
      tb_pEnable = 0'b1;
      
      tb_pSel = 0;
      tb_pEnable = 0;
      tb_pWrite = 0;
    end
  
  
endmodule
