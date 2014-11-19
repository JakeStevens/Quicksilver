`include "/home/ecegrid/a/mg115/ece337/Quicksilver/HDL/source/gpu_definitions.vh"

module gpu
  (
  input wire clk,
  input wire n_rst,
  input wire [31:0] pAddr_i,
  input wire [31:0] pDataWrite_i,
  input wire pSel_i,
  input wire pEnable_i,
  input wire pWrite_i,
  output wire [`WIDTH_BITS-1:0] x_o,
  output wire [`HEIGHT_BITS-1:0] y_o,
  output wire [`CHANNEL_BITS-1:0] r_o,
  output wire [`CHANNEL_BITS-1:0] g_o,
  output wire [`CHANNEL_BITS-1:0] b_o
  );
  
  wire [3:0] opcode_wire;
  wire [24:0] parameters_wire;
  wire [`WIDTH_BITS-1:0] x1_wire, x2_wire, x1_o_wire, x2_o_wire;
  wire [`HEIGHT_BITS-1:0] y1_wire, y2_wire, y1_o_wire, y2_o_wire;
  wire [`WIDTH_BITS-1:0] x1_fill_in, x2_fill_in, x1_line_in, x2_line_in;
  wire [`HEIGHT_BITS-1:0] y1_fill_in, y2_fill_in, y1_line_in, y2_line_in;
  wire [`WIDTH_BITS-1:0] x_line_out, x_fill_out, x;
  wire [`HEIGHT_BITS-1:0] y_line_out, y_fill_out, y;
  wire [`CHANNEL_BITS-1:0] r_wire, g_wire, b_wire, r_o_wire, g_o_wire, b_o_wire;
  wire push_wire, w_en_wire, pop_wire, empty_wire, full_wire, r_en_wire;
  wire finished_line_wire, finished_fill_wire, run_line_wire, run_fill_wire;
  wire line_busy_wire, fill_busy_wire;
  
  gpu_apb_interface apb(.clk(clk), .n_rst(n_rst), .pAddr_i(pAddr_i),
                    .pDataWrite_i(pDataWrite_i), .pSel_i(pSel_i),
                    .pEnable_i(pEnable_i), .pWrite_i(pWrite_i),
                    .opcode_o(opcode_wire), .parameters_o(parameters_wire),
                    .command_o(command_wire));
                  
  //TODO: rad, quad                
  gpu_instruction_decoder inst(.opcode_i(opcode_wire), .parameters_i(parameters_wire),
                              .command_i(command_wire), .x1_o(x1_wire),
                              .y1_o(y1_wire), .x2_o(x2_wire), .y2_o(y2_wire),
                              .r_o(r_wire), .g_o(g_wire), .b_o(b_wire),
                              .push_instruction_o(push_wire),
                              .write_enable_o(w_en_wire));
            
  //TODO: rad, quad
  gpu_instruction_fifo fifo(.clk(clk), .n_rst(n_rst), .opcode_i(opcode_wire),
                            .x1_i(x1_wire), .y1_i(y1_wire), .x2_i(x2_wire),
                            .y2_i(y2_wire), .r_i(r_wire), .g_i(g_wire),
                            .b_i(b_wire), .push_instruction_i(push_wire),
                            .write_enable_i(w_en_wire),
                            .pop_instruction_i(pop_wire),
                            .fifo_empty_o(empty_wire), .fifo_full_o(full_wire),
                            .opcode_o(op_wire), .x1_o(x1_o_wire),
                            .y1_o(y1_o_wire), .x2_o(x2_o_wire),.y2_o(y2_o_wire),
                            .r_o(r_o_wire), .g_o(g_o_wire), .b_o(b_o_wire));
                            
  gpu_controller controller(.clk(clk), .n_rst(n_rst), .opcode_i(op_wire),
                            .x1_i(x1_o_wire), .x2_i(x2_o_wire), 
                            .y1_i(y1_o_wire), .y2_i(y2_o_wire),
                            .r_i(r_o_wire), .g_i(g_o_wire), .b_i(b_o_wire),
                            .finish_line_i(finished_line_wire),
                            .finish_fill_i(finished_fill_wire),
                            .fifo_empty_i(empty_wire), .x1_line_o(x1_line_in),
                            .x2_line_o(x2_line_in), .y1_line_o(y1_line_in),
                            .y2_line_o(y2_line_in), .run_line_o(run_line_wire),
                            .x1_fill_o(x1_fill_in), .y1_fill_o(y1_fill_in),
                            .x2_fill_o(x2_fill_in), .y2_fill_o(y2_fill_in),
                            .run_fill_o(run_fill_wire), .read_en_o(r_en_wire),
                            .pop_o(pop_wire));
                      
                        
  gpu_draw_line line(.clk(clk), .n_rst(n_rst), .x1(x1_line_in),
                      .x2(x2_line_in), .y1(y1_line_in), .y2(y2_line_in),
                      .start(run_line_wire), .done(finished_line_wire),
                      .X(x_line_out), .y(y_line_out));
                                        
  gpu_fill_rect rect(.clk(clk), .n_rst(n_rst), .x1_i(x1_fill_in),
                      .x2_i(x2_fill_in), .y1_i(y1_fill_in),
                      .y2_i(y2_fill_in), .start_i(run_fill_wire),
                      .x_o(x_fill_out), .y_o(y_fill_out), 
                      .done_o(finished_fill_wire));
                      
  gpu_output_decoder decode(.x_line_i(x_line_out), .y_line_i(y_line_out),
                            .x_fill_i(x_fill_out), .y_fill_i(y_fill_out),
                            .line_active(line_busy_wire),
                            .fill_active(fill_busy_wire),
                            .x_o(x), .y_o(y));

                        
                            
  
                            
  
  
endmodule
