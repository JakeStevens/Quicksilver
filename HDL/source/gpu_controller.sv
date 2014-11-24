`include "source/gpu_definitions.vh"

module gpu_controller
  (
  input wire clk,
  input wire n_rst,
  input wire [3:0] opcode_i,
  input wire [`WIDTH_BITS-1:0] x1_i,
  input wire [`HEIGHT_BITS-1:0] y1_i,
  input wire [`WIDTH_BITS-1:0] x2_i,
  input wire [`HEIGHT_BITS-1:0] y2_i,
  input wire [`WIDTH_BITS-1:0] rad_i,
  input wire [`CHANNEL_BITS-1:0] r_i,
  input wire [`CHANNEL_BITS-1:0] g_i,
  input wire [`CHANNEL_BITS-1:0] b_i,
  input wire [2:0] oct_i,
  input wire finished_line_i,
  input wire finished_fill_i,
  input wire fifo_empty_i,
  output reg [`WIDTH_BITS-1:0] x1_line_o,
  output reg [`HEIGHT_BITS-1:0] y1_line_o,
  output reg [`WIDTH_BITS-1:0] x2_line_o,
  output reg [`HEIGHT_BITS-1:0] y2_line_o,
  output reg run_line_o,
  
  output reg [`WIDTH_BITS-1:0] x1_fill_o,
  output reg [`HEIGHT_BITS-1:0] y1_fill_o,
  output reg [`WIDTH_BITS-1:0] x2_fill_o,
  output reg [`HEIGHT_BITS-1:0] y2_fill_o,
  output reg run_fill_o,
  
  output reg [`WIDTH_BITS-1:0] x1_arc_o,
  output reg [`HEIGHT_BITS-1:0] y1_arc_o,
  output reg [`WIDTH_BITS-1:0] rad_arc_o,
  output reg [2:0] oct_arc_o,
  output reg run_arc_o,
  
  output reg pop_o
  );
  
  /*
  STATE 0: WAIT FOR COMMAND STATE
  STATE 1: PROCESS COMMAND STATE
  */
  reg state, nextstate;
  
  always @ (posedge clk, negedge n_rst)
  begin: stateRegister
    if (n_rst == 1'b0)
      state <= 0;
    else
      state <= nextstate;
  end
  
  always_comb
  begin: nextStateLogic
    nextstate = 0;
    pop_o = 0;
    case(state)
      1'b0:
        begin
	       if(fifo_empty_i == 1'b1)
	         nextstate = 0;
          else
	         nextstate = 1;
        end
      1'b1:
        begin
          if(finished_line_i == 1'b1 || finished_fill_i == 1'b1)
	           begin
	             pop_o = 1;
	             nextstate = 0;
            end
          else
            nextstate = 1;
        end
    endcase
  end

  always_comb
  begin: outputLogic
    x1_line_o = 0;
    y1_line_o = 0;
    x2_line_o = 0;
    y2_line_o = 0;

    run_line_o = 0;
    x1_fill_o = 0;
    y1_fill_o = 0;
    x2_fill_o = 0;
    y2_fill_o = 0;

    run_arc_o = 0;
    x1_arc_o = 0;
    y1_arc_o = 0;
    rad_arc_o = 0;
    oct_arc_o = 0;

    run_fill_o = 0;
    //state only changes when an instruction is being processed
    if (state == 1'b1) 
      begin
        case(opcode_i)
	       4'b0100:
	         begin
            x1_line_o = x1_i;
    	       y1_line_o = y1_i;
    	       x2_line_o = x2_i;
    	       y2_line_o = y2_i;
    	       run_line_o = 1'b1;
	         end
        4'b0101:
	       begin
	         x1_fill_o = x1_i;
	         y1_fill_o = y1_i;
	         x2_fill_o = x2_i;
	         y2_fill_o = y2_i;
	         run_fill_o = 1'b1;
	       end
	      4'b0111:
	       begin
	         x1_arc_o = x2_i;
	         y1_arc_o = y2_i;
	         rad_arc_o = rad_i;
	         oct_arc_o = oct_i;
	         run_arc_o = 1'b1;
	        end
        endcase
      end
  end
endmodule
