module gpu
  (
  input wire clk,
  input wire n_rst,
  input wire [31:0] pAddr_i,
  input wire [31:0] pDataWrite_i,
  input wire pSel_i,
  input wire pEnable_i,
  input wire pWrite_i,
  output wire [10:0] x_o,
  output wire [9:0] y_o,
  output wire [7:0] r_o,
  output wire [7:0] g_o,
  output wire [7:0] b_o
  );
  
  wire [3:0] opcode_wire;
  wire [24:0] parameters_wire;
  wire finished_wire, draw_line_wire;
  wire [9:0] x1_wire, x2_wire, rad_wire;
  wire [8:0] y1_wire, y2_wire;
  wire [7:0] r_wire, g_wire, b_wire;
  wire busy_wire; //not connected as of now
  
  apbgpu apb(.clk(clk), .n_rst(n_rst), .pAddr_i(pAddr_i),
            .pDataWrite_i(pDataWrite_i), .pSel_i(pSel_i),
            .pEnable_i(pEnable_i), .pWrite_i(pWrite_i),
            .opcode_o(opcode_wire), .parameters_o(parameters_wire));
  
  gpu_decoder decode(.clk(clk), .n_rst(n_rst), .opcode_i(opcode_wire),
              .parameters_i(parameters_wire), .finished_i(finished_wire),
              .x1_o(x1_wire), .x2_o(x2_wire), .y1_o(y1_wire), .y2_o(y2_wire),
              .rad_o(rad_wire), .r_o(r_wire), .g_o(g_wire), .b_o(b_wire),
              .draw_line_o(draw_line_wire));
              
  gpu_draw_line line(.clk(clk), .n_rst(n_rst), .x1(x1_wire), .y1(y1_wire),
                    .x2(x2_wire), .y2(y2_wire), .r_i(r_wire), .g_i(g_wire),
                    .b_i(b_wire), .start(draw_line_wire), .done(finished_wire),
                    .busy(busy_wire), .X(x_o), .Y(y_o), .r_o(r_o), .g_o(g_o),
                    .b_o(b_o));
  
  
endmodule