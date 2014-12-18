`timescale 1ns / 10 ps
`include "source/gpu_definitions.vh"

module tb_gpu_instruction_decoder();
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
  reg tb_command;
  
  reg [`WIDTH_BITS-1:0] tb_x1;
  reg [`HEIGHT_BITS-1:0] tb_y1;
  reg [`WIDTH_BITS-1:0] tb_x2;
  reg [`HEIGHT_BITS-1:0] tb_y2;
  reg [`WIDTH_BITS-1:0] tb_rad;
  reg [`CHANNEL_BITS-1:0] tb_r;
  reg [`CHANNEL_BITS-1:0] tb_g;
  reg [`CHANNEL_BITS-1:0] tb_b;
  reg tb_push;
  reg tb_w_en;
  
  gpu_apb_interface apb(.clk(tb_clk), .n_rst(tb_n_rst), .pAddr_i(tb_pAddr), .pDataWrite_i(tb_pDataWrite),
              .pSel_i(tb_pSel), .pEnable_i(tb_pEnable), .pWrite_i(tb_pWrite),
              .opcode_o(tb_opcode), .parameters_o(tb_parameters), .command_o(tb_command));
              
  gpu_instruction_decoder DUT(.opcode_i(tb_opcode), .parameters_i(tb_parameters), .command_i(tb_command),
                              .x1_o(tb_x1), .y1_o(tb_y1), .x2_o(tb_x2),.y2_o(tb_y2),
                              .rad_o(tb_rad), .r_o(tb_r), .g_o(tb_g), .b_o(tb_b),
                              .push_instruction_o(tb_push), .write_enable_o(tb_w_en));                            
              
    always
    begin
      tb_clk = 1'b0;
      #(CLK_PERIOD/2.0);
      tb_clk = 1'b1;
      #(CLK_PERIOD/2.0);
    end
    
    initial
    begin
      /**** Replace the values for tb_pDataWrite in order to **********
      ***** test different APB commands		             *********/

      tb_n_rst = 1'b1;
      tb_n_rst = 1'b0;
      #(CLK_PERIOD);
      tb_n_rst = 1'b1;
      
      tb_pAddr = 1'b0;
      tb_pDataWrite = 1'b0;
      tb_pSel = 1'b0;
      tb_pEnable = 1'b0;
      tb_pWrite = 1'b0;
      
      
      //Set XY1 
      @(posedge tb_clk);
      #(2);
      tb_pDataWrite = 32'b00010000000000000000000000000000;
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
      
      //Set XY2
      @(posedge tb_clk);
      #(2);
      tb_pDataWrite = 32'b00100000000000000001100000000111;
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
      
      //Draw line
      @(posedge tb_clk);
      #(2);
      tb_pDataWrite = 32'b01000000101010101011110100111110;
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
      
      #(CLK_PERIOD*12);
      
      //Set XY2
      @(posedge tb_clk);
      #(2);
      tb_pDataWrite = 32'b00010000000000000001100000000111;
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
      
      //Set XY2 
      @(posedge tb_clk);
      #(2);
      tb_pDataWrite = 32'b00100000000000000000000000000000;
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
      
      
      //Draw line
      @(posedge tb_clk);
      #(2);
      tb_pDataWrite = 32'b01000000101010101011110100111110;
      tb_pSel = 1'b1;
      tb_pWrite = 1'b1;
      #(CLK_PERIOD);
      tb_pEnable = 1'b1;
      #(CLK_PERIOD);

    end
  
  
endmodule
