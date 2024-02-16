`include "dc.v"

`timescale 1ns / 1ns

module tb_dc;

reg [3:0] tin;
wire [6:0] tled;

dc DUT1 (.in(tin),.led(tled));

initial 
begin
 	   tin = 4'b0000;
  #10 tin = 4'b0001;
  #10 tin = 4'b0010;
  #10 tin = 4'b0011;
  #10 tin = 4'b0100;
  #10 tin = 4'b0101;
  #10 tin = 4'b0110;
  #10 tin = 4'b0111;
  #10 tin = 4'b1000;
  #10 tin = 4'b1001;
 end

initial 
begin
	#150 $stop;
end
	
initial 
begin
	$display ("Start test");
	$monitor ("At time %t 'tin'=%b and 'tled'=%b", $time, tin, tled);
end

endmodule

	