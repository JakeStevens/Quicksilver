module gpu_irq_generator
  (
  input wire clk,
  input wire n_rst,
  input wire signal_i,
  output wire irq_o
  );
  
  // Currently, this is just a wrapper around an edge detector for a single signal. 
  // But this could be expanded in the future to generate IRQ pulses based on more complex conditions.
  
  edge_detect edge_detect(
    .clk(clk),
    .n_rst(n_rst),
    .data_i(signal_i),
    .edge_found_o(irq_o)
  );
  
endmodule
