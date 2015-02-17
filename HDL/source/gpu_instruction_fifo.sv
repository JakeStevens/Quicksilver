// File name:   gpu_instruction_fifo.sv
// Created:     12/15/2014
// Author:      Manik Singhal Jake Stevens Erik Swan
// Lab Section: 337-04
// Version:     1.0  ECE337 Final Project Version
// Description: Stores opcode and all associated parameters

`include "source/gpu_definitions.vh"

module gpu_instruction_fifo
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
  input wire push_instruction_i,
  input wire write_enable_i,
  input wire pop_instruction_i,
  output reg fifo_empty_o,
  output reg fifo_full_o,
  output reg [3:0] opcode_o,
  output reg [`WIDTH_BITS-1:0] x1_o,
  output reg [`HEIGHT_BITS-1:0] y1_o,
  output reg [`WIDTH_BITS-1:0] x2_o,
  output reg [`HEIGHT_BITS-1:0] y2_o,
  output reg [`WIDTH_BITS-1:0] rad_o,
  output reg [`CHANNEL_BITS-1:0] r_o,
  output reg [`CHANNEL_BITS-1:0] g_o,
  output reg [`CHANNEL_BITS-1:0] b_o,
  output reg [2:0] oct_o
  );
  
localparam FIFO_WIDTH = 79;
localparam FIFO_MAX_BIT = FIFO_WIDTH - 1;
localparam FIFO_DEPTH = 8;
localparam FIFO_POINTER_BITS = 3; //log(2, 8) 

reg [FIFO_MAX_BIT:0] input_data;
reg [FIFO_DEPTH-1:0][FIFO_MAX_BIT:0] data;
reg [FIFO_POINTER_BITS-1:0] read_ptr, write_ptr;
reg [FIFO_POINTER_BITS:0] depth_cntr;

struct packed {
  reg [3:0] opcode;
  reg [`WIDTH_BITS-1:0] x1;
  reg [`HEIGHT_BITS-1:0] y1;
  reg [`WIDTH_BITS-1:0] x2;
  reg [`HEIGHT_BITS-1:0] y2;
  reg [`WIDTH_BITS-1:0] rad;
  reg [`CHANNEL_BITS-1:0] r;
  reg [`CHANNEL_BITS-1:0] g;
  reg [`CHANNEL_BITS-1:0] b;
  reg [2:0] oct;
} output_data;

reg fifo_full;
/* The outward fifo full signal will be less than the actual full
   to account for latency between when a command is sent via APB to
   when it is received, and for handling of the interrupt */
assign fifo_full_o = (depth_cntr == 4'd7 || depth_cntr == 4'd8);

// Assign the individual inputs and outputs into larger blocks to make
// the words easier to work with
always_comb begin
  input_data = {oct_i, b_i, g_i, r_i, rad_i, y2_i, x2_i, y1_i, x1_i, opcode_i};
  // Reading from FIFO
  output_data = data[read_ptr][FIFO_MAX_BIT:0];
  opcode_o = output_data.opcode;
  x1_o = output_data.x1;
  y1_o = output_data.y1;
  x2_o = output_data.x2;
  y2_o = output_data.y2;
  rad_o = output_data.rad;
  r_o = output_data.r;
  g_o = output_data.g;
  b_o = output_data.b;
  oct_o = output_data.oct;

  // FIFO flags
  fifo_empty_o = (depth_cntr == 0);
  fifo_full = (depth_cntr == 4'd8);
end

// Writing to FIFO
always_ff @ (negedge n_rst, posedge clk) begin
  if (!n_rst) begin
    data <= 0;
  end else if(write_enable_i && !fifo_full) begin
    data[write_ptr][FIFO_MAX_BIT:0] <= input_data;
  end
end

// Read pointer
always_ff @ (negedge n_rst, posedge clk) begin
  if(!n_rst) begin
    read_ptr <= 0;
  end else if(pop_instruction_i == 1'b1 && !fifo_empty_o) begin
    read_ptr <= read_ptr + 1; // TODO: need to handle rollover manually?
  end
end

// Write pointer
always_ff @ (negedge n_rst, posedge clk) begin
  if(!n_rst) begin
    write_ptr <= 0;
  end else if(push_instruction_i == 1'b1 && !fifo_full) begin
    write_ptr <= write_ptr + 1; // TODO: need to handle rollover manually?
  end
end

// Depth counter
always_ff @ (negedge n_rst, posedge clk) begin
  if(!n_rst) begin
    depth_cntr <= 0;
  end else if (push_instruction_i == 1'b1 && pop_instruction_i == 1'b1) begin
    depth_cntr <= depth_cntr;
  end else if(push_instruction_i == 1'b1 && !fifo_full) begin // TODO: Move this logic to a simple comb wire that we can reuse
    depth_cntr <= depth_cntr + 1;
  end else if(pop_instruction_i == 1'b1 && !fifo_empty_o) begin
    depth_cntr <= depth_cntr - 1;
  end
end

endmodule
