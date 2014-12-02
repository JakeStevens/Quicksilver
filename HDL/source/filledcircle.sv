`include "source/gpu_definitions.vh"
module filledcircle
(
  input wire clk,
  input wire n_rst,
  input wire [`WIDTH_BITS - 1:0] xC,
  input wire [`HEIGHT_BITS - 1:0] yC,
  input wire [`WIDTH_BITS -1:0] rad,
  input wire [`CHANNEL_BITS - 1:0] r_i,
  input wire [`CHANNEL_BITS - 1:0] g_i,
  input wire [`CHANNEL_BITS - 1:0] b_i,
  input wire start,
  output wire done,
  output wire busy,
  output wire [`WIDTH_BITS - 1:0] X,
  output wire [`HEIGHT_BITS - 1:0] Y,
  output wire [`CHANNEL_BITS-1:0] r_o,
  output wire [`CHANNEL_BITS-1:0] g_o,
  output wire [`CHANNEL_BITS-1:0] b_o
  );
  
  reg signed [`WIDTH_BITS+1:0] Fcontrol;

  wire start_edge;
  reg reg_done, reg_busy;
  reg [2:0] chordstate, nchordstate,fchange1, fchange2;
  reg setover, nsetover; 
  reg chordfinish;
  reg startreg;
  reg setpoint;
  
  reg [`WIDTH_BITS - 1:0] rX, rY, trX, trY, cX1, cX2;//as ry starts from radius
  reg [`HEIGHT_BITS - 1:0] cY;
  
  assign r_o = r_i;
  assign g_o = g_i;
  assign b_o = b_i;
  assign X = rX;
  assign Y = rY;
  assign busy = reg_busy;
  assign done = reg_done;
  
  rise_edge_detect rise(.clk(clk),.n_rst(n_rst),.data_i(start),.rising_edge_found(start_edge));

  //typedef enum bit[1:0] {NULL, START, CHORD} stateType;
  //stateType state,nextstate
  
  //reg startreg;
  
  
        
  always @ (posedge clk, negedge n_rst)
  begin: main_register
		if (!n_rst)
			begin
				reg_done <= 1'b0;
				reg_busy <= 1'b0;
			end
		else if (start_edge)
			begin
				Fcontrol <= (1 - (rad));
				reg_busy <= 1'b1;
        reg_done <= 1'b0;
        trY <= rad;
        trX <= '0;
				startreg <= 1'b1;
			end		
		else if (start == 1'b1 && start_edge == 1'b0 && reg_busy == 1'b1 && setover == 1'b1)
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
				startreg <= 1'b1;
      end
		else
			begin
				reg_done <= 1'b0;
				startreg <= 1'b0;
			end
	end


	// create the statemachine which outputs the set of points for each chord into the chorddraw

	

	always @ (posedge clk, negedge n_rst)
	begin
		if (!n_rst)
			begin
				setover <= 1'b0;
				chordstate <= 1'b0;
			end
		else
			begin
				setover <= nsetover;
				chordstate <= nchordstate;
			end
	end

	

	always @ (startreg, chordstate, setover, chordfinish)
	begin
	  //nchordstate = (startreg) ? 3'b001 : (chordfinish && (chordstate == 3'b100)) ?  '0 : (!chordfinish) ? chordstate : chordstate + 1
		nchordstate = chordstate;
		nsetover = setover;
		case (chordstate)
			3'b000:
				begin
					if (startreg)
						begin
							nchordstate = 3'b001;
							nsetover = 1'b0;
							//setpoint = 1'b1;
						end
					else 
					 begin
					   nsetover = 1'b0;
					   //setpoint = 1'b0;
					 end  
				end
			3'b001:
				begin
					if(chordfinish)
						begin
							nchordstate = 3'b010;
							nsetover = 1'b0;
							//setpoint = 1'b1;
						end
					else 
					 begin
					   nsetover = 1'b0;
					   //setpoint = 1'b0;
					 end
				end
			3'b010:
				begin
					if(chordfinish)
						begin
							nchordstate = 3'b011;
							nsetover = 1'b0;
							//setpoint = 1'b1;
						end
					else
					  begin
					   nsetover = 1'b0;
					   //setpoint = 1'b0;
					  end
				end
			3'b011:
				begin
					if(chordfinish)
						begin
							nchordstate = 3'b100;
							nsetover = 1'b0;
							//setpoint = 1'b1;
						end
					else
					  begin
					   nsetover = 1'b0;
					   //setpoint = 1'b0;
					  end
				end
			3'b100:
				begin
					if(chordfinish)
						begin
							nchordstate = 3'b000;
							nsetover = 1'b1;
							//setpoint = 1'b1;
						end
					else
					  begin
					   nsetover = 1'b0;
					   //setpoint = 1'b0;
					  end
				end
			3'b101:
				begin
					nchordstate = 3'b000;
				end
			3'b110:
				begin
					nchordstate = 3'b000;
				end
			3'b111:
				begin
					nchordstate = 3'b000;
				end
		endcase
	end


//determine the points outputted at each chordstate
 always_comb
	begin
		cX1 = `WIDTH_BITS'd`WIDTH;
		cX2 = `WIDTH_BITS'd`WIDTH;
		cY = `WIDTH_BITS'd`WIDTH;
		case (chordstate)
			3'b000:
			begin
				cX1 = `WIDTH_BITS'd`WIDTH;
				cX2 = `WIDTH_BITS'd`WIDTH;
				cY = `HEIGHT_BITS'd`WIDTH;
			end
			3'b001:
				begin
				cX1 = xC - trX;
				cX2 = xC + trX;
				cY = yC + trY;
				end
			3'b010:
				begin
				cX1 = xC - trY;
				cX2 = xC + trY;
				cY = yC + trX;
				end
			3'b011:
				begin
				cX1 = xC - trY;
				cX2 = xC + trY;
				cY = yC - trX;
				end
			3'b100:
				begin
				cX1 = xC - trX;
				cX2 = xC + trX;
				cY = yC - trY;
				end	
		endcase
	end


//
always_ff @ (posedge clk, negedge n_rst)
  begin
    if (!n_rst)
      begin
        fchange1 <= '0;
        fchange2 <= '0;
      end
    else
      begin
        fchange1 <= nchordstate;
        fchange2 <= fchange1;
      end
  end
  
  assign setpoint = (fchange2 != fchange1);





//statemachine to counte from one endpoint to the other endpoint of the chord
	always @ (posedge clk, negedge n_rst)
	begin
		if (!n_rst)
			begin
			rX <= `WIDTH_BITS'd`WIDTH;
			rY <= `HEIGHT_BITS'd`WIDTH;
			chordfinish <= 1'b0;
			end
		else if (chordstate == 3'b000 || chordstate == 3'b101 || chordstate == 3'b110 || chordstate == 3'b111)
			begin
				rX <= `WIDTH_BITS'd`WIDTH;
			  rY <= `HEIGHT_BITS'd`WIDTH;
				chordfinish <= 1'b1;
			end
		else
			begin
			//rY <= cY;
			if (setpoint)
				begin
					rX <= cX1;
					rY <= cY;
					chordfinish <= 1'b0;
				end
			else
				begin
					if (rX == cX2)
						begin
						  rX <= rX;
						  rY <= cY;
							chordfinish <= 1'b1;
						end
					else
						begin
							rX <= rX + 1;
							rY <= cY;
							chordfinish <= 1'b0;
						end
				end
			end
	end


endmodule


										



















        
        
      
      
      
      
              
              
            
        
    
    
          
                
                
        
  
  

