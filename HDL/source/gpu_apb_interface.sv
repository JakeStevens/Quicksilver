module gpu_apb_interface
  (
    input wire clk,
    input wire n_rst,
    input wire [31:0] pAddr_i,
    input wire [31:0] pDataWrite_i,
    input wire pSel_i,
    input wire pEnable_i,
    input wire pWrite_i,
    output reg command_o,
    output reg [3:0] opcode_o,
    output reg [27:0] parameters_o
  );
  
  typedef enum bit {SETUP, ACCESS} stateType;
  
  stateType state, nextstate;
  
  always @ (posedge clk, negedge n_rst)
  begin: stateReg
    if (n_rst == 0)
      state <= SETUP;
    else
      state <= nextstate;
  end
  
  always_comb
  begin: nextStateLogic
    nextstate = SETUP;
    
    case(state)
      SETUP:
        begin
          if (pSel_i == 1 && pEnable_i == 0 && pWrite_i == 1)
            nextstate = ACCESS;
        end
      ACCESS:
        nextstate = SETUP;
    endcase
  end
  
            
  always_comb
  begin: outputLogic
    opcode_o = 0;
    parameters_o = 0;
    command_o = 0;
    
    case(state)
      ACCESS:
        begin
          if (pSel_i == 1 && pEnable_i == 1 && pWrite_i == 1)
            begin
              command_o = 1'b1;
              opcode_o = pDataWrite_i[31:28];
              parameters_o = pDataWrite_i[27:0];
            end
        end
    endcase
  end
  
  
endmodule
