//`include "SnailFSM_unique_11.v"
`include "SnailFSM_Mealey_unique_11.v"
`timescale 1ns / 1ns

module tb_SnailFSM_unique_11;

reg D, _rst, clk;
wire Q;

wire [63:0] state = DUT.txstate;

//SnailFSM_unique_11 DUT (D, _rst, clk, Q);
SnailFSM_Mealey_unique_11 DUT (D, _rst, clk, Q);

initial begin
  clk = 0;
  forever #5 clk = ~clk;
end

initial begin
  _rst = 1;
  repeat(2) #1 _rst = ~_rst;
end

initial begin
  D = 0;
end

always @(posedge clk) #3 D = $random;

initial
  #300 $finish;

initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars;
end

endmodule
