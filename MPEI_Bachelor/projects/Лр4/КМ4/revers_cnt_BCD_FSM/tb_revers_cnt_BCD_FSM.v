`include "revers_cnt_BCD_FSM.v"

`timescale 1ns / 1ns

module tb_cnt_BCD_FSM();

reg clk, res, revers;
reg [3:0] data;

wire [3:0] Q;

revers_cnt_BCD_FSM DUT(.clk(clk), .res(res), .Q(Q), .revers(revers), .data(data));

initial begin
  data = 5;
  #130 data = 7;
  #200 data = 4;
end

initial begin
	revers = 1;
  #100 revers = 0;
  #200 revers = 1;
  #400 revers = 0;
end

initial begin
    $display("Running testbench");                                                  
	clk = 0;
  forever #10 clk = ~clk;
end 

initial begin
res = 1;
repeat (2) #1 res = ~res;
#300 res = 0;
#50 res = 1;
end	 

initial begin
	#1000 $display("Testbench is OK!");
	     $finish;
end

initial begin            
    $dumpfile("qqq.vcd");     
    $dumpvars;
end

endmodule
