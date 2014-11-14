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
  wire [`WIDTH_BITS-1:0] x1_wire, x2_wire, rad_wire;
  wire [`HEIGHT_BITS-1:0] y1_wire, y2_wire;
  wire [`CHANNEL_BITS-1:0] r_wire, g_wire, b_wire;
  wire push_wire, w_en_wire;
  
  gpu_apb_interface apb(.clk(clk), .n_rst(n_rst), .pAddr_i(pAddr_i),
                    .pDataWrite_i(pDataWrite_i), .pSel_i(pSel_i),
                    .pEnable_i(pEnable_i), .pWrite_i(pWrite_i),
                    .opcode_o(opcode_wire), .parameters_o(parameters_wire),
                    .command_o(command_wire));
                  
  gpu_instruction_decoder inst(.opcode_i(opcode_wire), .parameters_i(parameters_wire),
                              .command_i(command_wire), .x1_o(x1_wire),
                              .y1_o(y1_wire), .x2_o(x2_wire), .y2_o(y2_wire),
                              .r_o(r_wire), .g_o(g_wire), .b_o(b_wire),
                              .push_instruction_o(push_wire),
                              .write_enable_o(w_en_wire));
            
  
  
endmodule
