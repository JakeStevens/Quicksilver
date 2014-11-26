`include "source/gpu_definitions.vh"


module gpu_memcontroller
(
  input wire clk,
  input wire n_rst,
  input wire data_ready_i,
  input wire [`CHANNEL_BITS -1:0] rdata,
  input wire [`CHANNEL_BITS -1:0] gdata,
  input wire [`CHANNEL_BITS- 1:0] bdata,
  input wire [`WIDTH_BITS - 1:0] adddatax,
  input wire [`HEIGHT_BITS - 1:0] adddatay,
  input wire flush,
  //input wire [10:0] offsetx,
  //input wire [10:0] offsety,
  output wire CE1_o, CE0_o, LB_o, R_W_o, UB_o, ZZ_o, SEM_o, OE_o,
  output wire [3*(`CHANNEL_BITS) - 1:0] rgbdataout_o,
  output wire [`WIDTH_BITS + `HEIGHT_BITS:0] adddataout_o,
  output wire buffer_select_o
  );
  
  reg buffselect;
  reg [`HEIGHT_BITS + `WIDTH_BITS:0] packaddress, changedaddressy, offset;
  //reg [`HEIGHT_BITS + `WIDTH_BITS:0] addaddress;
  reg [3*(`CHANNEL_BITS) - 1:0] rgbpackdata;
  reg regCE1, regCE0, regLB, regR_W, regUB, regSEM, regZZ, regOE;
  
  typedef enum bit[1:0] {NULL, IDLE, OUTPUT} stateType;
  stateType state,nextstate;
  
  gpu_packlut2 packlut(.addressy(adddatay), .rtpaddy(changedaddressy));
  //assign addadress = changedaddressy + adddatax;
  assign adddataout_o = packaddress; 
  assign rgbdataout_o = rgbpackdata;
  assign CE1_o = regCE1;
  assign CE0_o = regCE0;
  assign LB_o = regLB;
  assign R_W_o = regR_W;
  assign UB_o = regUB;
  assign ZZ_o = regZZ;
  assign SEM_o = regSEM;
  assign OE_o = regOE;
  assign buffer_select_o = buffselect;

  always @ (posedge clk, negedge n_rst)
  begin: mainreg
    if (!n_rst)
    begin
      state <= NULL; //power down SRAM chip
      regCE0 <= 1'b1;
      regSEM <= 1'b1;
      regCE1 <= 1'b0;
      regZZ <= 1'b0;
    end
    else if (!data_ready_i)
      begin
        state <= IDLE;//HIGH Z on inputs
        regZZ <= 1'b1;
      end
    else if (data_ready_i)
      begin
        state <= OUTPUT;// output to frame buffer
        regZZ <= 1'b0;
        regR_W <= 1'b0;
        regLB <= 1'b0;
        regUB <= 1'b0;
        regCE1 <= 1'b1;
        regCE0 <= 1'b0;
        regSEM <= 1'b1;
        regOE <= 1'b0;
        packaddress <= changedaddressy + adddatax + offset;
        rgbpackdata <= {rdata,gdata,bdata};
      end
  end
  
  //determine buffselect
  always @(posedge clk, negedge n_rst)
  begin
    if (!n_rst)
      buffselect <= 1'b0;
    else if (flush)
      buffselect <= !buffselect;
    else
      buffselect <= buffselect;
  end
  
  //determine adder offset
  always_comb
  begin
    if (!buffselect)
      offset <= 0;
    else
      offset <= `SUM_BITS'd`OFFSETMEM;
  end
  
  
endmodule
        
        
      
       
  

