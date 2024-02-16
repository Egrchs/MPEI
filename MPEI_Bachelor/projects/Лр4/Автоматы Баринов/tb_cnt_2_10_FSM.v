`include "cnt_2_10_FSM.v"

`timescale 1ns / 1ns

module tb_cnt_2_10_FSM();

reg iclk, irstn;
wire [3:0] oQ;

cnt_2_10_FSM DUT(.clk(iclk), .rst_n(irstn), .Q(oQ));

initial
begin
	iclk = 1'b0;
	irstn = 1'b1;
end

always #100 iclk = ~iclk;

initial
begin
	irstn = #20 ~irstn;
	irstn = #20 ~irstn;
end

initial
begin
	$dumpvars;
	#3000 $finish;
end

endmodule
