`include  "dmuxif.v"
`include  "dmux.v"
`timescale 1ns/1ps

module tb_mux();

reg [1:0]  tsel;
reg [15:0] tin = {16{1'b1}};

wire[15:0] tout0;
wire[15:0] tout1;
wire[15:0] tout2;

wire[15:0] ttout0;
wire[15:0] ttout1;
wire[15:0] ttout2;

dmux DUT1(.sel(tsel),.in(tin),.out0(tout0),.out1(tout1),.out2(tout2));
dmuxif DUT2(.sel(tsel),.in(tin),.out0(ttout0),.out1(ttout1),.out2(ttout2));

initial begin
	 tsel = 2'b00;
 #5 tsel = 2'b01;
 #5 tsel = 2'b10;
 #5 tsel = 2'b11;
end
 
initial begin
 #50 $stop;
end

initial 
begin
	$display ("Start test");
	$monitor ("At time %t 'tsel'=%b and 'tin'=%b and 'tout0'=%b and 'tout1'=%b and 'tout2'=%b and 'ttout0'=%b and 'ttout1'=%b and 'ttout2'=%b", $time, tsel, tin, tout0, tout1, tout2, ttout0,ttout1,ttout2);
end
 
 endmodule
 