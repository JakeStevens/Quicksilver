`include "source/gpu_definitions.vh"

module gpu_instruction_decoder
  (
  input wire clk,
  input wire n_rst,
  input wire [3:0] opcode_i,
  input wire [27:0] parameters_i,
  input wire command_i,
  output reg [3:0] opcode_o,
  output reg [`WIDTH_BITS-1:0] x1_o,
  output reg [`HEIGHT_BITS-1:0] y1_o,
  output reg [`WIDTH_BITS-1:0] x2_o,
  output reg [`HEIGHT_BITS-1:0] y2_o,
  output reg [`WIDTH_BITS-1:0] rad_o,
  output reg [2:0] oct_o,
  output reg [`CHANNEL_BITS-1:0] r_o,
  output reg [`CHANNEL_BITS-1:0] g_o,
  output reg [`CHANNEL_BITS-1:0] b_o,
  output reg push_instruction_o,
  output reg write_enable_o
  );
  
  reg [3:0] opcode_o_n;
  reg [`WIDTH_BITS-1:0] x1_o_n;
  reg [`HEIGHT_BITS-1:0] y1_o_n;
  reg [`WIDTH_BITS-1:0] x2_o_n;
  reg [`HEIGHT_BITS-1:0] y2_o_n;
  reg [`WIDTH_BITS-1:0] rad_o_n;
  reg [2:0] oct_o_n;
  reg [`CHANNEL_BITS-1:0] r_o_n;
  reg [`CHANNEL_BITS-1:0] g_o_n;
  reg [`CHANNEL_BITS-1:0] b_o_n;
  reg push_instruction_o_n;
  reg write_enable_o_n;
  
  always @ (posedge clk, negedge n_rst)
  begin
    if (n_rst == 1'b0)
      begin
        opcode_o <= 0;
        x1_o <= 0;
        y1_o <= 0;
        x2_o <= 0;
        y2_o <= 0;
        rad_o <= 0;
        oct_o <= 0;
        r_o <= 0;
        g_o <= 0;
        b_o <= 0;
        push_instruction_o <= 0;
        write_enable_o <= 0;
      end
    else
      begin
        opcode_o <= opcode_o_n;
        x1_o <= x1_o_n;
        y1_o <= y1_o_n;
        x2_o <= x2_o_n;
        y2_o <= y2_o_n;
        rad_o <= rad_o_n;
        oct_o <= oct_o_n;
        r_o <= r_o_n;
        g_o <= g_o_n;
        b_o <= b_o_n;
        push_instruction_o <= push_instruction_o_n;
        write_enable_o <= write_enable_o_n;
      end
      
  end
  
  always
  begin: outputLogic
    opcode_o_n = opcode_o;
    x1_o_n = x1_o;
    y1_o_n = y1_o;
    x2_o_n = x2_o;
    y2_o_n = y2_o;
    rad_o_n = rad_o;
    oct_o_n = oct_o;
    r_o_n = r_o;
    g_o_n = g_o;
    b_o_n = b_o;
    push_instruction_o_n = 0;
    write_enable_o_n = 0;
    if (command_i == 1'b1)
      begin
        case(opcode_i)
          //4'b0000:
           // begin
              //Output reset s
           // end
          4'b0001:
            begin
              //set_xy1
              x1_o_n = parameters_i[`WIDTH_BITS-1:0];
              y1_o_n = parameters_i[`WIDTH_BITS+`HEIGHT_BITS-1:`WIDTH_BITS];
              write_enable_o_n = 1'b1;
              push_instruction_o_n = 0;
            end
          4'b0010:
            begin
              //set_xy2
              x2_o_n = parameters_i[`WIDTH_BITS-1:0];
              y2_o_n = parameters_i[`WIDTH_BITS+`HEIGHT_BITS-1:`WIDTH_BITS];
              write_enable_o_n = 1'b1;
              push_instruction_o_n = 0;
            end
          4'b0011:
            begin
              //set_radius
              rad_o_n = parameters_i[`WIDTH_BITS-1:0];
              write_enable_o_n = 1'b1;
              push_instruction_o_n = 0;
            end
          4'b0100:
            begin
              //draw_line
              b_o_n = parameters_i[`CHANNEL_BITS-1:0];
              g_o_n = parameters_i[2*`CHANNEL_BITS:`CHANNEL_BITS];
              r_o_n = parameters_i[3*`CHANNEL_BITS-1:2*`CHANNEL_BITS];
              opcode_o_n = opcode_i;
              write_enable_o_n = 1'b1;
              push_instruction_o_n = 1'b1;
            end
          4'b0101:
            begin
              //draw_rect
              b_o_n = parameters_i[`CHANNEL_BITS-1:0];
              g_o_n = parameters_i[2*`CHANNEL_BITS:`CHANNEL_BITS];
              r_o_n = parameters_i[3*`CHANNEL_BITS-1:2*`CHANNEL_BITS];
              opcode_o_n = opcode_i;
              write_enable_o_n = 1'b1;
              push_instruction_o_n = 1'b1;
            end
          4'b0110:
            begin
              //draw circle
              b_o_n = parameters_i[`CHANNEL_BITS-1:0];
              g_o_n = parameters_i[2*`CHANNEL_BITS:`CHANNEL_BITS];
              r_o_n = parameters_i[3*`CHANNEL_BITS-1:2*`CHANNEL_BITS];
              opcode_o_n = opcode_i;
              write_enable_o_n = 1'b1;
              push_instruction_o_n = 1'b1;
            end
          4'b0111:
            begin
              //draw arc
              b_o_n = parameters_i[`CHANNEL_BITS-1:0];
              g_o_n = parameters_i[2*`CHANNEL_BITS:`CHANNEL_BITS];
              r_o_n = parameters_i[3*`CHANNEL_BITS-1:2*`CHANNEL_BITS];
              opcode_o_n = opcode_i;
              oct_o_n = parameters_i[27:25];
              write_enable_o_n = 1'b1;
              push_instruction_o_n = 1'b1; 
            end
          4'b1000:
            begin
              opcode_o_n = opcode_i;
              write_enable_o_n = 1'b1;
              push_instruction_o_n = 1'b1;
            end
              
        endcase
      end
  end
endmodule