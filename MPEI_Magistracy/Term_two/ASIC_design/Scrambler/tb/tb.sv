`timescale 1ns/1ps //Simulation time unit 1ns, simulation time precision 1ps

`define WAVES_FILE "dump/wave.vcd"

module tb();

  // signal declaration
  logic clk_i;
  logic rst_n_i;
  logic bit_i;
  logic bit_o;

  //Module instantiation (just connect the declared signals)
  top U(
      .CLK_I     ( clk_i   ),
      .RST_N_I   ( rst_n_i ),
      .BIT_I     ( bit_i   ),
      .BIT_O     ( bit_o   )
      );

  always #5 clk_i = ~clk_i; //generate clock signal

  // assign value to input data
  initial begin
      clk_i       = 1;
      rst_n_i     = 1;
      #10 rst_n_i = 0;
      #5 rst_n_i  = 1;
  end

localparam [0 : 12] a        = 13'b1_0100_0000_1001;

  initial begin
    @(negedge rst_n_i);
    for (int i = 0; i < 11; i ++) begin
      @ (posedge clk_i);
      bit_i <= a [i];
    end
  end
  
  initial begin
      $dumpfile(`WAVES_FILE);
      $dumpvars;
      #1000 $finish();
  end

endmodule