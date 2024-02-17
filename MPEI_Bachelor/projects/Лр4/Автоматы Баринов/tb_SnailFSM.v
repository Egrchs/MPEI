`timescale 1ns / 1ns

module tb_SnailFSM;

reg D, _rst, clk;
wire Q;

wire [63:0] state = DUT.txstate;

SnailFSM/*_Mealey*/ DUT (D, _rst, clk, Q);

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
  #200 $finish;

initial
  $dumpvars;

endmodule
