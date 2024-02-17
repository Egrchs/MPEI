`include "Lab1_beh.v"
`include "Lab1_struct.v"

`timescale 1ns/1ps

module tb_lab1;

reg [2:0] xt;
wire[2:0] yt_struct, yt_beh;

Lab1_struct DUT1 ( .x(xt), .y(yt_struct));
Lab1_beh DUT2 ( .x(xt), .y(yt_beh));

initial begin
    xt=3'b000; 
#10 xt=3'b001;
#10 xt=3'h7;
#10 xt=3'h4;
end

initial
	#50 $stop;

initial begin
	$display ("Start test");
	$monitor ("At time %t 'xt'=%b and 'yt_struct'=%b and 'yt_beh'=%b",$time,xt,yt_struct, yt_beh);
	end
always @ (xt)
	if (yt_struct == yt_beh)
		#1	$display ("is OK");
	else 
		#1	$display ("is Failed");
endmodule
