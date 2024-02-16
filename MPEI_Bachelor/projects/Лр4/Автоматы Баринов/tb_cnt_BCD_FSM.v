`include "cnt_BCD_FSM.v"

`timescale 1ns / 1ns

module tb_cnt_BCD_FSM();

reg iclk, irstn;
wire [3:0] oQ;

parameter PERIOD = 200;

cnt_BCD_FSM DUT(.clock(iclk),
		.reset(irstn),
		.Q(oQ));

initial
begin
	iclk = 1'b0;
	irstn = 1'b1;
end

always #(PERIOD/2) iclk = ~iclk;

initial
begin
	#20 irstn = ~irstn;
	#20 irstn = ~irstn;
end

initial
begin
	$dumpvars;
	#(PERIOD*20) $finish;
end

endmodule
