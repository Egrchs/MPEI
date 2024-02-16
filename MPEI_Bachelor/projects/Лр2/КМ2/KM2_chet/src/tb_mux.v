`include  "dmuxif.v"
`include  "dmux.v"
`timescale 1ns/1ps

module tb_mux();

reg [1:0] tsel;
reg [31:0] tdin = {32{1'b1}};

wire[31:0] tdout0;
wire[31:0] tdout1;
wire[31:0] tdout2;
wire[31:0] tdout3;

wire[31:0] ttdout0;
wire[31:0] ttdout1;
wire[31:0] ttdout2;
wire[31:0] ttdout3;

dmux DUT1(.sel(tsel),.din(tdin),.dout0(tdout0),.dout1(tdout1),.dout2(tdout2),.dout3(tdout3));
dmuxif DUT2(.sel(tsel),.din(tdin),.dout0(ttdout0),.dout1(ttdout1),.dout2(ttdout2),.dout3(ttdout3));

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
	$monitor ("At time %t 'tsel'=%b and 'tdin'=%b and 'tdout0'=%b and 'tdout1'=%b and 'tdout2'=%b and 'tdout3'=%b and 'ttdout0'=%b and 'ttdout1'=%b and 'ttdout2'=%b and 'ttdout3'=%b", $time, tsel, tdin, tdout0, tdout1, tdout2, tdout3, ttdout0,ttdout1,ttdout2,ttdout3);
end
 
 endmodule
 