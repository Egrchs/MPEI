`include "ROM_32x8.sv"
`timescale 1 ns / 1 ns

module ROM_32x8_tb
#(
    parameter WIDTH = 32,
    parameter DEPTH = 8 
);

  logic clk, Re;

  logic [(DEPTH)-1:0] Addr;
  logic [WIDTH-1:0] Dataout;

  ROM_32x8 
  #(
    .WIDTH(32),
    .DEPTH(8)
  ) 
  DUT 
  (
    .Addr(Addr),
    .clk(clk),
    .Re(Re),
    .Dataout(Dataout)
  );

  initial begin
    $display("Running testbench");
    clk = 0;
    Re  = 0;
  end

  always #10  clk =  !clk; 

  initial begin
    Re = 1;
  end  

  initial begin
    for (int i = 0; i <= 5; i++) begin
      Addr = $urandom_range(0, 2**DEPTH-1);
      #100;                     
    end
  end

  initial begin
    #520 $display("Testbench is OK!");
    $finish;
  end

  initial begin
    $dumpfile("ROM_32x8.vcd");
    $dumpvars;
  end

 endmodule
