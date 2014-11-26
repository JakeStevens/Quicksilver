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
  reg tb_CE1_o, tb_CE0_o, tb_LB_o, tb_R_W_o, tb_UB_o, tb_ZZ_o, tb_SEM_o, tb_OE_o;
  reg [3*(`CHANNEL_BITS) - 1:0] tb_rgbdataout_o;
  reg [`WIDTH_BITS + `HEIGHT_BITS:0] tb_adddataout_o;
  reg tb_buff_sel;
  integer File1, File2;
  
  
  gpu DUT(.clk(tb_clk), .n_rst(tb_n_rst), .pAddr_i(tb_pAddr), .pDataWrite_i(tb_pDataWrite),
              .pSel_i(tb_pSel), .pEnable_i(tb_pEnable), .pWrite_i(tb_pWrite),
              .CE1_o(tb_CE1_o), .CE0_o(tb_CE0_o), .LB_o(tb_LB_o), .R_W_o(tb_R_W_o),
              .UB_o(tb_UB_o), .ZZ_o(tb_ZZ_o), .SEM_o(tb_SEM_o), .OE_o(tb_OE_o),
              .rgbdataout_o(tb_rgbdataout_o), .adddataout_o(tb_adddataout_o),
	      .buffer_select_o(tb_buff_sel));
              
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
      if(tb_R_W_o == 1'b0)
        begin
          if (File1 && File2)
            begin
              if (tb_buff_sel == 1'b0)
	        $fdisplay(File1, "%d,%d", tb_adddataout_o, tb_rgbdataout_o);
              else
		$fdisplay(File2, "%d,%d", tb_adddataout_o, tb_rgbdataout_o);
	      $display("%d,%d", tb_adddataout_o, tb_rgbdataout_o);
            end
          end
    end
    
    initial
    begin
      File1 = $fopen("tb_output1.txt");
      File2 = $fopen("tb_output2.txt");
        if (!File1 || !File2)
          $display("A file did not open");
        else
          $display("Both files opened");
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
      $fclose(File1);
      $fclose(File2);
      $display("File closed");
    end
  
  
endmodule
