module edge_detect
  (
  input wire clk,
  input wire n_rst,
  input wire data_i,
  output reg edge_found_o
  );

  reg flip1;
  reg flip2;

  always_ff @ (posedge clk, negedge n_rst)
  begin
    if (1'b0 == n_rst)
      begin
        flip1 <= 1;
        flip2 <= 1;
      end
    else
      begin
        flip1 <= data_i;
        flip2 <= flip1;
      end
  end

  assign edge_found_o = flip2 ^ flip1;

endmodule
