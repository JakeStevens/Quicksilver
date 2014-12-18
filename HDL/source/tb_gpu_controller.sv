`include "source/gpu_definitions.vh"
`timescale 1 ns / 100 ps
module tb_gpu_controller();


//define local parameters
localparam CLK_PERIOD = 20; 
  
//controller tb connections
reg tb_clk;
reg tb_n_rst;
reg [3:0] tb_opcode;
reg [`WIDTH_BITS-1:0] tb_x1;
reg [`HEIGHT_BITS-1:0] tb_y1;
reg [`WIDTH_BITS-1:0] tb_x2;
reg [`HEIGHT_BITS-1:0] tb_y2;
reg [`WIDTH_BITS-1:0] tb_rad;
reg [`CHANNEL_BITS-1:0] tb_r_i;
reg [`CHANNEL_BITS-1:0] tb_g_i;
reg [`CHANNEL_BITS-1:0] tb_b_i;
reg [`CHANNEL_BITS-1:0] tb_r_o;
reg [`CHANNEL_BITS-1:0] tb_g_o;
reg [`CHANNEL_BITS-1:0] tb_b_o;
reg [2:0] tb_oct;

reg tb_finished_line;
reg tb_finished_fill;
reg tb_finished_arc;
reg tb_finished_circle;
reg tb_fifo_empty;

reg [`WIDTH_BITS-1:0] tb_x1_line;
reg [`HEIGHT_BITS-1:0] tb_y1_line;
reg [`WIDTH_BITS-1:0] tb_x2_line;
reg [`HEIGHT_BITS-1:0] tb_y2_line;
reg [`WIDTH_BITS-1:0] tb_rad_line;
reg tb_run_line;


reg [`WIDTH_BITS-1:0] tb_x1_fill;
reg [`HEIGHT_BITS-1:0] tb_y1_fill;
reg [`WIDTH_BITS-1:0] tb_x2_fill;
reg [`HEIGHT_BITS-1:0] tb_y2_fill;
reg tb_run_fill;

reg [`WIDTH_BITS-1:0] tb_x1_arc;
reg [`HEIGHT_BITS-1:0] tb_y1_arc;
reg [`WIDTH_BITS-1:0] tb_rad_arc;
reg [2:0] tb_oct_arc;
reg tb_run_arc;

reg [`WIDTH_BITS-1:0] tb_x1_circle;
reg [`HEIGHT_BITS-1:0] tb_y1_circle;
reg [`WIDTH_BITS-1:0] tb_rad_circle;
reg tb_run_circle;

reg tb_pop;
reg tb_flush_frame;

//Instantiate DUT
gpu_controller DUT(.clk(tb_clk),
                    .n_rst(tb_n_rst),
                    .opcode_i(tb_opcode),
                    .x1_i(tb_x1),
                    .y1_i(tb_y1),
                    .x2_i(tb_x2),
                    .y2_i(tb_y2),
                    .rad_i(tb_rad),
                    .r_i(tb_r_i),
                    .g_i(tb_g_i),
                    .b_i(tb_b_i),
                    .oct_i(tb_oct),
                    
                    .finished_line_i(tb_finished_line),
                    .finished_fill_i(tb_finished_fill),
                    .finished_arc_i(tb_finished_arc),
                    .finished_circle_i(tb_finished_circle),                    
                    .fifo_empty_i(tb_fifo_empty),
                    
                    .r_o(tb_r_o),
                    .g_o(tb_g_o),
                    .b_o(tb_b_o),
                    
                    .x1_line_o(tb_x1_line),
                    .y1_line_o(tb_y1_line),
                    .x2_line_o(tb_x2_line),
                    .y2_line_o(tb_y2_line),
                    .run_line_o(tb_run_line),
                    
                    .x1_fill_o(tb_x1_fill),
                    .y1_fill_o(tb_y1_fill),
                    .x2_fill_o(tb_x2_fill),
                    .y2_fill_o(tb_y2_fill),
                    .run_fill_o(tb_run_fill),
                    
                    .x1_arc_o(tb_x1_arc),
                    .y1_arc_o(tb_y1_arc),
                    .rad_arc_o(tb_rad_arc),
                    .oct_arc_o(tb_oct_arc),
                    .run_arc_o(tb_run_arc),
                    
                    .x1_circle_o(tb_x1_circle),
                    .y1_circle_o(tb_y1_circle),
                    .rad_circle_o(tb_rad_circle),
                    .run_circle_o(tb_run_circle),
                    
                    .pop_o(tb_pop),
                    .flush_frame_o(tb_flush_frame));
                    
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
    /* BEGIN TESTING */
    #(CLK_PERIOD);
    /**************************************
    CHANGE THE OPCODE AND tb_finished_* lines
    IN ORDER TO TEST OTHER INSTRUCTIONS
    **************************************/
    tb_opcode = 4'b0100;
    tb_x1 = `WIDTH_BITS'd15;
    tb_y1 = `HEIGHT_BITS'd150;
    tb_x2 = `WIDTH_BITS'd299;
    tb_y2 = `HEIGHT_BITS'd250;
    tb_rad = 0;
    tb_r_i = `CHANNEL_BITS'd10;
    tb_g_i = `CHANNEL_BITS'd9;
    tb_b_i = `CHANNEL_BITS'd8;
    /**************************************
    THE FOLLOWING CLOCK PERIODS CONTROLLER
    SHOULD STAY IN STATE 0 SINCE FIFO
    IS EMPTY
    **************************************/
    #(CLK_PERIOD*3);
    tb_fifo_empty = 1'b0;
    /**************************************
    THE FOLLOWING CLOCK PERIODS CONTROLLER
    SHOULD STAY IN STATE 1 UNTIL THE 
    COMMAND IS FINISHED
    **************************************/
    #(CLK_PERIOD * 10);
    tb_fifo_empty = 1'b1;
    tb_finished_fill = 1'b1;
    #(CLK_PERIOD * 1);
    tb_finished_fill = 1'b0;
    /**************************************
    CONTROLLER SHOULD END IN STATE 0
    **************************************/  
end

endmodule
