`include "dc.v"

`timescale 1ns / 1ns

module tb_dc;

reg [3:0] inx;
wire [6:0] segx;

dc DUT1 (.in(inx),.seg(segx));

initial 
begin
 	  inx = 4'b0000;
  #10 inx = 4'b0001;
  #10 inx = 4'b0010;
  #10 inx = 4'b0011;
  #10 inx = 4'b0100;
  #10 inx = 4'b0101;
  #10 inx = 4'b0110;
  #10 inx = 4'b0111;
  #10 inx = 4'b1000;
  #10 inx = 4'b1001;
 end

initial 
begin
	#100 $stop;
end
	
initial 
begin
	$display ("Start test");
	$monitor ("At time %t 'inx'=%b and 'segx'=%b", $time, inx, segx);
end

endmodule

	