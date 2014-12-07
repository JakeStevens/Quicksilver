`include "source/gpu_definitions.vh"

module gpu
  (
  input wire clk,
  input wire n_rst,
  input wire [31:0] pAddr_i,
  input wire [31:0] pDataWrite_i,
  input wire pSel_i,
  input wire pEnable_i,
  input wire pWrite_i,
  output wire CE1_o, CE0_o, LB_o, R_W_o, UB_o, ZZ_o, SEM_o, OE_o,
  output wire [3*(`CHANNEL_BITS) - 1:0] rgbdataout_o,
  output wire [`WIDTH_BITS + `HEIGHT_BITS:0] adddataout_o,
  output wire buffer_select_o,
  output wire full_change_irq_o
  );
  
  /* FIFO SIGNALS */
  wire push_wire, w_en_wire, pop_wire, empty_wire;
  
  wire [3:0] opcode_wire, op_wire;
  
  wire [`WIDTH_BITS-1:0] x1_wire, x2_wire, x1_o_wire, x2_o_wire;
  wire [`HEIGHT_BITS-1:0] y1_wire, y2_wire, y1_o_wire, y2_o_wire;
  
  wire [`CHANNEL_BITS-1:0] r_wire, g_wire, b_wire, r_o_wire, g_o_wire, b_o_wire;
  wire [2:0] oct_wire, oct_o_wire;
  wire [`WIDTH_BITS-1:0] rad_wire, rad_o_wire;
  
  
  wire [3:0] opcode_wire_o;
  wire [27:0] parameters_wire;
  
  /* Fill and Line Signals From Controller to Functions */
  wire [`WIDTH_BITS-1:0] x1_fill_in, x2_fill_in, x1_line_in, x2_line_in;
  wire [`HEIGHT_BITS-1:0] y1_fill_in, y2_fill_in, y1_line_in, y2_line_in;
  
  /* Arc and Circle Signals From Controller to Functions */
  wire [`WIDTH_BITS-1:0] x1_arc_in, rad_arc_in, x1_circle_in, rad_circle_in;
  wire [`HEIGHT_BITS-1:0] y1_arc_in, y1_circle_in;
  wire [2:0] oct_arc_in;
  
  
  /* X and Y output from Functions to Output Decoder */
  wire [`WIDTH_BITS-1:0] x_line_out, x_fill_out;
  wire [`HEIGHT_BITS-1:0] y_line_out, y_fill_out;
  
  wire [`WIDTH_BITS-1:0] x_arc_out, x_circle_out;
  wire [`HEIGHT_BITS-1:0] y_arc_out, y_circle_out;
  
  /* X and Y Output from Output Decoder to Memory Controller */
  wire [`WIDTH_BITS-1:0] x;
  wire [`HEIGHT_BITS-1:0] y;
  
  wire [`CHANNEL_BITS-1:0] r_hold_wire, g_hold_wire, b_hold_wire;
  
  /* Finished wires */
  wire finished_line_wire, finished_fill_wire, finished_arc_wire, finished_circle_wure; 
  /* Run wires */
  wire run_line_wire, run_fill_wire, run_arc_wire, run_circle_wire;
  /* Busy wires */
  wire line_busy_wire, fill_busy_wire, arc_busy_wire, circle_busy_wire;
 
  wire data_ready;
  wire flush_frame_wire;
  
  wire fifo_full;
  
  //TODO: assign x y r g b out through memory controller
  assign x_o = x;
  assign y_o = y;
  assign r_o = r_o_wire;
  assign g_o = g_o_wire;
  assign b_o = b_o_wire;
  
  gpu_apb_interface apb(.clk(clk),
                        .n_rst(n_rst),
                        .pAddr_i(pAddr_i),
                        .pDataWrite_i(pDataWrite_i),
                        .pSel_i(pSel_i),
                        .pEnable_i(pEnable_i),
                        .pWrite_i(pWrite_i),
                        .opcode_o(opcode_wire),
                        .parameters_o(parameters_wire),
                        .command_o(command_wire));
                                 
  gpu_instruction_decoder inst(.clk(clk),
                              .n_rst(n_rst),
                              .opcode_i(opcode_wire),
                              .parameters_i(parameters_wire),
                              .command_i(command_wire),
                              .x1_o(x1_wire),
                              .y1_o(y1_wire),
                              .x2_o(x2_wire),
                              .y2_o(y2_wire),
                              .r_o(r_wire),
                              .g_o(g_wire),
                              .b_o(b_wire),
                              .rad_o(rad_wire),
                              .oct_o(oct_wire),
                              .opcode_o(opcode_wire_o),
                              .push_instruction_o(push_wire),
                              .write_enable_o(w_en_wire));

  gpu_instruction_fifo fifo(.clk(clk),
                            .n_rst(n_rst),
                            .opcode_i(opcode_wire_o),
                            .x1_i(x1_wire),
                            .y1_i(y1_wire),
                            .x2_i(x2_wire),
                            .y2_i(y2_wire),
                            .rad_i(rad_wire),
                            .r_i(r_wire),
                            .g_i(g_wire),
                            .b_i(b_wire),
                            .oct_i(oct_wire),
                            .push_instruction_i(push_wire),
                            .write_enable_i(w_en_wire),
                            .pop_instruction_i(pop_wire),
                            .fifo_empty_o(empty_wire),
                            .fifo_full_o(fifo_full_o),
                            .opcode_o(op_wire),
                            .x1_o(x1_o_wire),
                            .y1_o(y1_o_wire),
                            .x2_o(x2_o_wire),
                            .y2_o(y2_o_wire),
                            .rad_o(rad_o_wire),
                            .r_o(r_o_wire),
                            .g_o(g_o_wire),
                            .b_o(b_o_wire),
                            .oct_o(oct_o_wire));
                            
                            
  gpu_controller controller(.clk(clk),
                            .n_rst(n_rst),
                            .opcode_i(op_wire),
                            .x1_i(x1_o_wire),
                            .x2_i(x2_o_wire), 
                            .y1_i(y1_o_wire),
                            .y2_i(y2_o_wire),
                            .r_i(r_o_wire),
                            .g_i(g_o_wire),
                            .b_i(b_o_wire),
                            .rad_i(rad_o_wire),
                            .oct_i(oct_o_wire),
                            
                            .finished_line_i(finished_line_wire),
                            .finished_fill_i(finished_fill_wire),
                            .finished_arc_i(finished_arc_wire),
                            .finished_circle_i(finished_circle_wire),
                            
                            .fifo_empty_i(empty_wire), 
                            .r_o(r_hold_wire),
                            .g_o(g_hold_wire),
                            .b_o(b_hold_wire),
                            
                            .x1_line_o(x1_line_in),
                            .x2_line_o(x2_line_in),
                            .y1_line_o(y1_line_in),
                            .y2_line_o(y2_line_in),
                            .run_line_o(run_line_wire),
                            
                            .x1_fill_o(x1_fill_in),
                            .y1_fill_o(y1_fill_in),
                            .x2_fill_o(x2_fill_in),
                            .y2_fill_o(y2_fill_in),
                            .run_fill_o(run_fill_wire),
                            
                            .x1_arc_o(x1_arc_in),
                            .y1_arc_o(y1_arc_in),
                            .rad_arc_o(rad_arc_in),
                            .oct_arc_o(oct_arc_in),
                            .run_arc_o(run_arc_wire),
                            
                            .x1_circle_o(x1_circle_in),
                            .y1_circle_o(y1_circle_in),
                            .rad_circle_o(rad_circle_in),
                            .run_circle_o(run_circle_wire),
                            
                            .pop_o(pop_wire),
                            .flush_frame_o(flush_frame_wire));
                      
                        
  gpu_draw_line line(.clk(clk),
                      .n_rst(n_rst),
                      .x1(x1_line_in),
                      .x2(x2_line_in),
                      .y1(y1_line_in),
                      .y2(y2_line_in),
                      .start(run_line_wire),
                      .done(finished_line_wire),
                      .busy(line_busy_wire),
                      .X(x_line_out),
                      .Y(y_line_out));
                                        
  gpu_fill_rect rect(.clk(clk),
                      .n_rst(n_rst),
                      .x1_i(x1_fill_in),
                      .x2_i(x2_fill_in),
                      .y1_i(y1_fill_in),
                      .y2_i(y2_fill_in),
                      .start_i(run_fill_wire),
                      .x_o(x_fill_out),
                      .y_o(y_fill_out), 
                      .busy_o(fill_busy_wire),
                      .done_o(finished_fill_wire));
                      
  gpu_octantdraw octdraw(.clk(clk),
                         .n_rst(n_rst),
                         .xC(x1_arc_in),
                         .yC(y1_arc_in),
                         .rad(rad_arc_in),
                         .oct(oct_arc_in),
                         .X(x_arc_out),
                         .Y(y_arc_out),
                         .busy_o(arc_busy_wire),
                         .start(run_arc_wire),
                         .done_o(finished_arc_wire));
                         
  gpu_fill_circle circle(.clk(clk),
                          .n_rst(n_rst),
                          .xC_i(x1_circle_in),
                          .yC_i(y1_circle_in),
                          .rad_i(rad_circle_in),
                          .start_i(run_circle_wire),
                          .done_o(finished_circle_wire),
                          .busy_o(circle_busy_wire),
                          .X_o(x_circle_out),
                          .Y_o(y_circle_out));
                      
  gpu_output_decoder decode(.x_line_i(x_line_out),
                            .y_line_i(y_line_out),
                            .x_fill_i(x_fill_out),
                            .y_fill_i(y_fill_out),
                            .x_arc_i(x_arc_out),
                            .y_arc_i(y_arc_out),
                            .x_circle_i(x_circle_out),
                            .y_circle_i(y_circle_out),
                            .line_active(line_busy_wire),
                            .fill_active(fill_busy_wire),
                            .arc_active(arc_busy_wire),
                            .circle_active(circle_busy_wire),
                            .x_o(x),
                            .y_o(y),
                            .data_ready_o(data_ready));
                            

  gpu_memcontroller memcontroller(.clk(clk),
                                  .n_rst(n_rst),
                                  .data_ready_i(data_ready),
                                  .rdata(r_hold_wire),
                                  .gdata(g_hold_wire),
                                  .bdata(b_hold_wire),
                                  .adddatax(x),
                                  .adddatay(y),
                                  .flush(flush_frame_wire), 
                                  .CE1_o(CE1_o),
                                  .CE0_o(CE0_o),
                                  .LB_o(LB_o),
                                  .R_W_o(R_W_o),
                                  .UB_o(UB_o),
                                  .ZZ_o(ZZ_o),
                                  .SEM_o(SEM_o),
                                  .OE_o(OE_o),
                                  .rgbdataout_o(rgbdataout_o),
				                          .adddataout_o(adddataout_o),
				                          .buffer_select_o(buffer_select_o));
				                          
  gpu_irq_generator irq_generator(.clk(clk),
                                  .n_rst(n_rst),
                                  .signal_i(fifo_full),
                                  .irq_o(full_change_irq_o));

endmodule
