`include "/home/ecegrid/a/mg115/ece337/Quicksilver/HDL/source/gpu_definitions.vh"
`timescale 1 ns / 100 ps
module tb_gpu_instruction_fifo();
  
// Define local parameters
localparam CLK_PERIOD = 10; 

// Define DUT ports
reg tb_clk;
reg tb_n_rst;
reg [3:0] tb_opcode_i;
reg [`WIDTH_BITS-1:0] tb_x1_i;
reg [`HEIGHT_BITS-1:0] tb_y1_i;
reg [`WIDTH_BITS-1:0] tb_x2_i;
reg [`HEIGHT_BITS-1:0] tb_y2_i;
reg [`WIDTH_BITS-1:0] tb_rad_i;
reg [`CHANNEL_BITS-1:0] tb_r_i;
reg [`CHANNEL_BITS-1:0] tb_g_i;
reg [`CHANNEL_BITS-1:0] tb_b_i;
reg [2:0] tb_quad_i;
reg tb_push_instruction;
reg tb_write_enable;
reg tb_pop_instruction;
reg tb_fifo_empty;
reg tb_fifo_full;
reg [3:0] tb_opcode_o;
reg [`WIDTH_BITS-1:0] tb_x1_o;
reg [`HEIGHT_BITS-1:0] tb_y1_o;
reg [`WIDTH_BITS-1:0] tb_x2_o;
reg [`HEIGHT_BITS-1:0] tb_y2_o;
reg [`WIDTH_BITS-1:0] tb_rad_o;
reg [`CHANNEL_BITS-1:0] tb_r_o;
reg [`CHANNEL_BITS-1:0] tb_g_o;
reg [`CHANNEL_BITS-1:0] tb_b_o;
reg [2:0] tb_quad_o;

// Connect DUT
gpu_instruction_fifo DUT(
  .clk(tb_clk), 
  .n_rst(tb_n_rst),
  .opcode_i(tb_opcode_i),
  .x1_i(tb_x1_i),
  .y1_i(tb_y1_i),
  .x2_i(tb_x2_i),
  .y2_i(tb_y2_i),
  .rad_i(tb_rad_i),
  .r_i(tb_r_i),
  .g_i(tb_g_i),
  .b_i(tb_b_i),
  .quad_i(tb_quad_i),
  .push_instruction_i(tb_push_instruction),
  .write_enable_i(tb_write_enable),
  .pop_instruction_i(tb_pop_instruction),
  .fifo_empty_o(tb_fifo_empty),
  .fifo_full_o(tb_fifo_full),
  .opcode_o(tb_opcode_o),
  .x1_o(tb_x1_o),
  .y1_o(tb_y1_o),
  .x2_o(tb_x2_o),
  .y2_o(tb_y2_o),
  .rad_o(tb_rad_o),
  .r_o(tb_r_o),
  .g_o(tb_g_o),
  .b_o(tb_b_o),
  .quad_o(tb_quad_o)
  );
  
// Setup clock
always begin
  tb_clk = 1'b0;
  #(CLK_PERIOD/2.0);
  tb_clk = 1'b1;
  #(CLK_PERIOD/2.0);
end

initial begin
  tb_n_rst = 1'b1;
  tb_n_rst = 1'b0;
  tb_write_enable = 1'b0;
  tb_opcode_i = 4'b0000; //draw line
  tb_x1_i = `WIDTH_BITS'd0;
  tb_y1_i = `HEIGHT_BITS'd0;
  tb_x2_i = `WIDTH_BITS'd0;
  tb_y2_i = `HEIGHT_BITS'd0;
  tb_rad_i = `WIDTH_BITS'd0;
  tb_r_i = `CHANNEL_BITS'd0;
  tb_g_i = `CHANNEL_BITS'd0;
  tb_b_i = `CHANNEL_BITS'd0;
  tb_quad_i = 3'd0;
  tb_push_instruction = 1'b0;
  tb_write_enable = 1'b0;
  tb_pop_instruction = 1'b0;
  
  #(CLK_PERIOD);
  
  tb_n_rst = 1'b1;
  
  // Write a single word and then read it
  tb_write_enable = 1'b1;
  tb_opcode_i = 4'b0100; //draw line
  tb_x1_i = `WIDTH_BITS'd0;
  tb_y1_i = `HEIGHT_BITS'd0;
  tb_x2_i = `WIDTH_BITS'd10;
  tb_y2_i = `HEIGHT_BITS'd10;
  tb_rad_i = `WIDTH_BITS'd5;
  tb_r_i = `CHANNEL_BITS'd32;
  tb_g_i = `CHANNEL_BITS'd32;
  tb_b_i = `CHANNEL_BITS'd32;
  tb_quad_i = 3'd1;
  
  #(CLK_PERIOD);
  
  tb_write_enable = 1'b0;
  tb_push_instruction = 1'b1;
  
  // Write a few more (random) words
  
  for(reg [`CHANNEL_BITS-1:0] i = 0; i < 4; i++) begin
    #(CLK_PERIOD);
    tb_push_instruction = 1'b0;
    tb_write_enable = 1'b1;
    tb_write_enable = 1'b1;
    tb_opcode_i = 4'b0100; //draw line
    tb_x1_i = `WIDTH_BITS'd0;
    tb_y1_i = `HEIGHT_BITS'd0;
    tb_x2_i = `WIDTH_BITS'd10;
    tb_y2_i = `HEIGHT_BITS'd10;
    tb_rad_i = `WIDTH_BITS'd5;
    tb_r_i = `CHANNEL_BITS'd32;
    tb_g_i = `CHANNEL_BITS'd32;
    tb_b_i = `CHANNEL_BITS'd32;
    tb_quad_i = i;
    #(CLK_PERIOD);
    tb_write_enable = 1'b0;
    tb_push_instruction = 1'b1;
  end
  
  #(CLK_PERIOD);
  
  // Pop an instruction
  tb_write_enable = 1'b0;
  tb_pop_instruction = 1'b1;
  tb_push_instruction = 1'b0;
  
  #(CLK_PERIOD)
  tb_pop_instruction = 1'b0;
  
  // Push four more
  for(reg [`CHANNEL_BITS-1:0] i = 0; i < 4; i++) begin
    #(CLK_PERIOD);
    tb_push_instruction = 1'b0;
    tb_write_enable = 1'b1;
    tb_push_instruction = 1'b0;
    tb_write_enable = 1'b1;
    tb_write_enable = 1'b1;
    tb_opcode_i = 4'b0100; //draw line
    tb_x1_i = `WIDTH_BITS'd0;
    tb_y1_i = `HEIGHT_BITS'd0;
    tb_x2_i = `WIDTH_BITS'd10;
    tb_y2_i = `HEIGHT_BITS'd10;
    tb_rad_i = `WIDTH_BITS'd5;
    tb_r_i = `CHANNEL_BITS'd32;
    tb_g_i = `CHANNEL_BITS'd32;
    tb_b_i = `CHANNEL_BITS'd32;
    tb_quad_i = i;
    #(CLK_PERIOD);
    tb_write_enable = 1'b0;
    tb_push_instruction = 1'b1;
  end
  
  // FIFO should now be full
  #(CLK_PERIOD);
  tb_push_instruction = 1'b0;
  
  // Pop all 8 back off
  for(int i = 0; i < 8; i++) begin
    tb_pop_instruction = 1'b1;
    #(CLK_PERIOD);
  end
  
  tb_pop_instruction = 1'b0;
  
end

endmodule