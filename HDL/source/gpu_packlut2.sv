`include "source/gpu_definitions.vh"
module gpu_packlut2
  (
  input wire [`HEIGHT_BITS - 1:0] addressy,
  output wire [`HEIGHT_BITS + `WIDTH_BITS -1:0] rtpaddy
  );
  
  reg [`HEIGHT_BITS + `WIDTH_BITS - 1:0] reg_rtpaddy;
  
  assign rtpaddy = reg_rtpaddy;
  
  always @ (addressy)
  begin
      //generate
      reg_rtpaddy = 0;
      for (int i = 0; i < `HEIGHT; i = i+ 1)
      begin
        if (addressy == i)
          begin
            reg_rtpaddy = (i*(`WIDTH)) ;
          end
      end
      //endgenerate
  end
  
endmodule

        