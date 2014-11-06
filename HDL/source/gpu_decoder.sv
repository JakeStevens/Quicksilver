`include "/home/ecegrid/a/mg115/ece337/Quicksilver/HDL/source/gpu_definitions.vh"

module gpu_decoder
  (
  input wire clk,
  input wire n_rst,
  input wire [3:0] opcode_i,
  input wire [24:0] parameters_i,
  input wire finished_i,
  input wire command_i,
  output wire [`WIDTH_BITS-1:0] x1_o,
  output wire [`HEIGHT_BITS-1:0] y1_o,
  output wire [`WIDTH_BITS-1:0] x2_o,
  output wire [`HEIGHT_BITS-1:0] y2_o,
  output wire [`WIDTH_BITS-1:0] rad_o,
  output wire [`CHANNEL_BITS-1:0] r_o,
  output wire [`CHANNEL_BITS-1:0] g_o,
  output wire [`CHANNEL_BITS-1:0] b_o,
  output reg draw_line_o
  );
  
  reg [`WIDTH_BITS-1:0] x1_r, x2_r, rad_r, x1_n, x2_n, rad_n;
  reg [`HEIGHT_BITS-1:0] y1_r, y2_r, y1_n, y2_n;
  reg [`CHANNEL_BITS-1:0] r_r, g_r, b_r, r_n, g_n, b_n;
  reg draw_line_r, draw_line_n;
  
  assign x1_o = x1_r;
  assign x2_o = x2_r;
  assign y1_o = y1_r;
  assign y2_o = y2_r;
  assign rad_o = rad_r;
  assign r_o = r_r;
  assign g_o = g_r;
  assign b_o = b_r;
  assign draw_line_o = draw_line_r;
  
  typedef enum bit[1:0] {RESTART, PARAMS, CMD} stateType;
  stateType state, nextstate;

  always @ (posedge clk, negedge n_rst)
  begin: nextState
    if (n_rst == 1'b0)
    begin
      state <= RESTART;
      x1_r <= 0;
      y1_r <= 0;
      x2_r <= 0;
      y2_r <= 0;
      rad_r <= 0;
      r_r <= 0;
      g_r <= 0;
      b_r <= 0;
      draw_line_r <= 0;
    end
    else
    begin
      x1_r <= x1_n;
      y1_r <= y1_n;
      x2_r <= x2_n;
      y2_r <= y2_n;
      rad_r <= rad_n;
      r_r <= r_n;
      g_r <= g_n;
      b_r <= b_n;
      draw_line_r <= draw_line_n;
      state <= nextstate;
    end
  end
  
  always_comb
  begin: nextStateLogic
    nextstate <= state;
    if (state == RESTART)
      nextstate <= PARAMS;
    if (state == PARAMS)
      if (finished_i == 1'b1)// || opcode == 4'b0101 || opcode == 4'b0110 || opcode == 4'b0111)
        nextstate <= RESTART;
    //if (state == CMD)
      //if (finished_i == 1'b1)
        //nextstate <= PARAMS;
  end
  
  always_comb
  begin: outputLogic
    x1_n = x1_r;
    x2_n = x2_r;
    y1_n = y1_r;
    y2_n = y2_r;
    rad_n = rad_r;
    r_n = r_r;
    g_n = g_r;
    b_n = b_r;
    draw_line_n = draw_line_r;

    case(state)
    /*
      IDLE:
        begin
          case(opcode):
            4'b0001:
              begin
                //set_xy1
              end
            4'b0010:
              begin
                //set_xy2
              end
            4'b0011:
              begin
                //set_radius
              end
          endcase
        end
    */
      PARAMS:
        begin
          if (command_i == 1'b1)
            begin
              case(opcode_i)
                4'b0000:
                  begin
                    x1_n = 0;
                    x2_n = 0;
                    y1_n = 0;
                    y2_n = 0;
                    rad_n = 0;
                    r_n = 0;
                    g_n = 0;
                    b_n = 0;  
                  end
                4'b0001:
                  begin
                    //set_xy1
                    x1_n = parameters_i[`WIDTH_BITS-1:0];
                    y1_n = parameters_i[`WIDTH_BITS+`HEIGHT_BITS-1:`WIDTH_BITS];
                  end
                4'b0010:
                  begin
                    //set_xy2
                    x2_n = parameters_i[`WIDTH_BITS-1:0];
                    y2_n = parameters_i[`WIDTH_BITS+`HEIGHT_BITS-1:`WIDTH_BITS];
                  end
                4'b0011:
                  begin
                    //set_radius
                    rad_n = parameters_i[`WIDTH_BITS:0];
                  end
                4'b0100:
                  begin
                    //draw_line
                    b_n = parameters_i[`CHANNEL_BITS-1:0];
                    g_n = parameters_i[2*`CHANNEL_BITS:`CHANNEL_BITS];
                    r_n = parameters_i[3*`CHANNEL_BITS-1:2*`CHANNEL_BITS];
                    draw_line_n = 1;
                  end
                  /*
            4'b0101:
              begin
                //draw_rect
              end
            4'b0110:
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
      RESTART:
        begin
          x1_n = 0;
          x2_n = 0;
          y1_n = 0;
          y2_n = 0;
          rad_n = 0;
          r_n = 0;
          g_n = 0;
          b_n = 0;
          draw_line_n = 0;
        end
    endcase
  end
endmodule