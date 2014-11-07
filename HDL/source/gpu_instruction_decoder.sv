`include "/home/ecegrid/a/mg115/ece337/Quicksilver/HDL/source/gpu_definitions.vh"

module gpu_instruction_decoder
  (
  input wire [3:0] opcode_i,
  input wire [24:0] parameters_i,
  input wire command_i,
  output reg [`WIDTH_BITS-1:0] x1_o,
  output reg [`HEIGHT_BITS-1:0] y1_o,
  output reg [`WIDTH_BITS-1:0] x2_o,
  output reg [`HEIGHT_BITS-1:0] y2_o,
  output reg [`WIDTH_BITS-1:0] rad_o,
  output reg [`CHANNEL_BITS-1:0] r_o,
  output reg [`CHANNEL_BITS-1:0] g_o,
  output reg [`CHANNEL_BITS-1:0] b_o,
  output reg push_instruction_o,
  output reg write_enable_o
  );
  
  always_comb
  begin: outputLogic
    x1_o = 0;
    x2_o = 0;
    y1_o = 0;
    y2_o = 0;
    rad_o = 0;
    r_o = 0;
    g_o = 0;
    b_o = 0;
    push_instruction_o = 0;
    write_enable_o = 0;
    if (command_i == 1'b1)
      begin
        case(opcode_i)
          4'b0000:
            begin
              //Output reset signal
            end
          4'b0001:
            begin
              //set_xy1
              x1_o = parameters_i[`WIDTH_BITS-1:0];
              y1_o = parameters_i[`WIDTH_BITS+`HEIGHT_BITS-1:`WIDTH_BITS];
              write_enable_o = 1'b1;
            end
          4'b0010:
            begin
              //set_xy2
              x2_o = parameters_i[`WIDTH_BITS-1:0];
              y2_o = parameters_i[`WIDTH_BITS+`HEIGHT_BITS-1:`WIDTH_BITS];
              write_enable_o = 1'b1;
            end
          4'b0011:
            begin
              //set_radius
              rad_o = parameters_i[`WIDTH_BITS:0];
              write_enable_o = 1'b1;
            end
          4'b0100:
            begin
              //draw_line
              b_o = parameters_i[`CHANNEL_BITS-1:0];
              g_o = parameters_i[2*`CHANNEL_BITS:`CHANNEL_BITS];
              r_o = parameters_i[3*`CHANNEL_BITS-1:2*`CHANNEL_BITS];
              write_enable_o = 1'b1;
              push_instruction_o = 1'b1;
            end
          4'b0101:
            begin
              //draw_rect
              b_o = parameters_i[`CHANNEL_BITS-1:0];
              g_o = parameters_i[2*`CHANNEL_BITS:`CHANNEL_BITS];
              r_o = parameters_i[3*`CHANNEL_BITS-1:2*`CHANNEL_BITS];
              write_enable_o = 1'b1;
              push_instruction_o = 1'b1;
            end
          /*  4'b0110:
              begin
                //draw_circle
              end
            4'b0111:
              begin
                //draw_arc
              end
              */
        endcase
      end
  end
endmodule