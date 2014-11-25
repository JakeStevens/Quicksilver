`include "source/gpu_definitions.vh"


module gpu_octantdraw
  (
  input wire clk,
  input wire n_rst,
  input wire [`WIDTH_BITS - 1:0] xC,
  input wire [`HEIGHT_BITS - 1:0] yC,
  input wire [`WIDTH_BITS -1:0] rad,
  /*
  input wire [`CHANNEL_BITS - 1:0] r_i,
  input wire [`CHANNEL_BITS - 1:0] g_i,
  input wire [`CHANNEL_BITS - 1:0] b_i,
  */
  input wire [2:0] oct,
  input wire start,
  output wire done_o,
  output wire busy_o,
  output wire [`WIDTH_BITS - 1:0] X,
  output wire [`HEIGHT_BITS - 1:0] Y
  /*
  output wire [`CHANNEL_BITS-1:0] r_o,
  output wire [`CHANNEL_BITS-1:0] g_o,
  output wire [`CHANNEL_BITS-1:0] b_o
  */
  );
  
  reg signed [`WIDTH_BITS+1:0] Fcontrol;
  //reg signed [`WIDTH_BITS + 2:0] DY;
  wire start_edge;
  reg reg_done, reg_busy;
  
  reg [`WIDTH_BITS - 1:0] rX, rY, trX, trY;//as ry starts from radius
  
  /*
  assign r_o = r_i;
  assign g_o = g_i;
  assign b_o = b_i;
  */
  assign X = rX;
  assign Y = rY;
  assign busy_o = reg_busy;
  assign done_o = reg_done;
  
  rise_edge_detect rise(.clk(clk),.n_rst(n_rst),.data_i(start),.rising_edge_found(start_edge));
  
  always @ (posedge clk, negedge n_rst)
  begin
    if (!n_rst)
      begin
        reg_done <= 0;
        reg_busy <= 0;
      end
    else
      begin
        if (start_edge)
          begin
            Fcontrol <= (1 - (rad));
            //DX <= 0;
            //DY <= - rad - rad;
            reg_busy <= 1'b1;
            reg_done <= 1'b0;
            trY <= rad;
            trX <= '0;
          end
        else if (start == 1'b1 && start_edge == 1'b0 && reg_busy == 1'b1)
          begin
            if ((trX >= trY))
              begin
                reg_done <= 1'b1;
                reg_busy <= 1'b0;
              end
            else
              begin
                if ((Fcontrol < 0))
                  begin
                    Fcontrol <= Fcontrol + (trX << 1) + 3;
                  end
                else
                  begin
                    Fcontrol <= Fcontrol + ((trX - trY) << 1) + 5;
                    trY <= trY - 1;
                  end
                trX <= trX + 1;                 
              end
          end
        else
          begin
            reg_done <= 1'b0;
            reg_done <= 1'b0;
          end
      end
  end
  
  always @(trX, trY)
  begin
    rX <= `WIDTH_BITS'd`WIDTH;
    rY <= `HEIGHT'd`HEIGHT;
    if (oct == 3'b000) begin
      rX <= xC + trY;
      rY <= yC + trX;
      end
    else if (oct == 3'b001)
      begin
       rX <= xC + trX;
       rY <= yC + trY;
      end            
    else if (oct == 3'b010)
      begin
        rX <= xC - trX;
        rY <= yC + trY;
      end
    else if (oct == 3'b011)
      begin
         rX <= xC - trY;
         rY <= yC + trX;
      end
    else if (oct == 3'b100)
      begin
          rX <= xC - trY;
          rY <= yC - trX;
      end
    else if (oct == 3'b101)
      begin
          rX <= xC - trX;
          rY <= yC - trY;
      end
    else if (oct == 3'b110)
      begin
        rX <= xC + trX;
        rY <= yC - trY;
      end
    else if (oct == 3'b111)
      begin
        rX <= xC + trY;
        rY <= yC - trX;
      end 
  end 
    
  
endmodule
        
            
        
        
        
        
        
        
        
  
  
