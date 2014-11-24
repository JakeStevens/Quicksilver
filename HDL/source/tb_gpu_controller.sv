`include "source/gpu_definitions.vh"
`timescale 1 ns / 100 ps
module tb_gpu_controller();


//define local parameters
localparam CLK_PERIOD = 10; 
  
//controller tb connections
reg tb_clk;
reg tb_n_rst;
reg [3:0] tb_opcode;
reg [`WIDTH_BITS-1:0] tb_x1;
reg [`HEIGHT_BITS-1:0] tb_y1;
reg [`WIDTH_BITS-1:0] tb_x2;
reg [`HEIGHT_BITS-1:0] tb_y2;
reg [`WIDTH_BITS-1:0] tb_rad;
reg [`CHANNEL_BITS-1:0] tb_r;
reg [`CHANNEL_BITS-1:0] tb_g;
reg [`CHANNEL_BITS-1:0] tb_b;
reg tb_finished_line;
reg tb_finished_fill;
reg tb_fifo_empty;
reg [`WIDTH_BITS-1:0] tb_x1_line;
reg [`HEIGHT_BITS-1:0] tb_y1_line;
reg [`WIDTH_BITS-1:0] tb_x2_line;
reg [`HEIGHT_BITS-1:0] tb_y2_line;
reg [`WIDTH_BITS-1:0] tb_rad_line;
reg [`CHANNEL_BITS-1:0] tb_r_line;
reg [`CHANNEL_BITS-1:0] tb_g_line;
reg [`CHANNEL_BITS-1:0] tb_b_line;
reg tb_run_line;
reg [`WIDTH_BITS-1:0] tb_x1_fill;
reg [`HEIGHT_BITS-1:0] tb_y1_fill;
reg [`WIDTH_BITS-1:0] tb_x2_fill;
reg [`HEIGHT_BITS-1:0] tb_y2_fill;
reg [`WIDTH_BITS-1:0] tb_rad_fill;
reg [`CHANNEL_BITS-1:0] tb_r_fill;
reg [`CHANNEL_BITS-1:0] tb_g_fill;
reg [`CHANNEL_BITS-1:0] tb_b_fill;
reg tb_run_fill;
reg tb_read_en;
reg tb_pop;

//Instantiate DUT
gpu_controller DUT(.clk(tb_clk), .n_rst(tb_n_rst), .opcode_i(tb_opcode),
                    .x1_i(tb_x1), .y1_i(tb_y1), .x2_i(tb_x2), .y2_i(tb_y2),
                    .rad_i(tb_rad), .r_i(tb_r), .g_i(tb_g), .b_i(tb_b),
                    .finished_line_i(tb_finished_line),.finished_fill_i(tb_finished_fill),
                    .fifo_empty_i(tb_fifo_empty),.x1_line_o(tb_x1_line),
                    .y1_line_o(tb_y1_line), .x2_line_o(tb_x2_line), .y2_line_o(tb_y2_line),
                    .rad_line_o(tb_rad_line), .r_line_o(tb_r_line), .g_line_o(tb_g_line),
                    .b_line_o(tb_b_line), .run_line_o(tb_run_line),
                    .x1_fill_o(tb_x1_fill), .y1_fill_o(tb_y1_fill), .x2_fill_o(tb_x2_fill),
                    .y2_fill_o(tb_y2_fill), .rad_fill_o(tb_rad_fill), .r_fill_o(tb_r_fill),
                    .g_fill_o(tb_g_fill), .b_fill_o(tb_b_fill), .run_fill_o(tb_run_fill),
                    .read_en_o(tb_read_en),.pop_o(tb_pop));
                    
always
begin: CLKGEN
  tb_clk = 1'b0;
  #(CLK_PERIOD/2.0);
  tb_clk = 1'b1;
  #(CLK_PERIOD/2.0);
end

initial
begin
    tb_n_rst = 1'b1;
    tb_n_rst = 1'b0;
    tb_fifo_empty = 1'b1;
    tb_finished_fill = 1'b0;
    tb_finished_line = 1'b0;
    #(CLK_PERIOD);
    tb_n_rst = 1'b1;
    #(CLK_PERIOD);
    tb_opcode = 4'b0100;
    tb_x1 = `WIDTH_BITS'd15;
    tb_y1 = `HEIGHT_BITS'd150;
    tb_x2 = `WIDTH_BITS'd299;
    tb_y2 = `HEIGHT_BITS'd250;
    tb_rad = 0;
    tb_r = `CHANNEL_BITS'd10;
    tb_g = `CHANNEL_BITS'd9;
    tb_b = `CHANNEL_BITS'd8;
    #(CLK_PERIOD);
    tb_fifo_empty = 1'b0;
    #(CLK_PERIOD * 10);
    tb_fifo_empty = 1'b1;
    tb_finished_fill = 1'b1;
    #(CLK_PERIOD * 1);
    tb_finished_fill = 1'b0;
    
    
      
end

endmodule
