`include "reverscnt.v"
`timescale 1 ps/ 1 ps

module tb_reverscnt #(parameter WIDTH = 5)();

reg   n, clk, res;
reg [WIDTH-1:0] x;
                         
wire   [WIDTH-1:0] Q;
                  
reverscnt DUT1 (.clk(clk),.Q(Q),.res(res),.n(n), .x(x));


initial begin
    $display("Running testbench");                                                  
	clk = 0;
  forever #5 clk = ~clk;
end 

initial begin
	res = 1;
	#130 res = 0;
	#10 res = 1;
end	  

initial begin
	x = 10;
	n = 1;
	#15 n = 0;
	#50 n = 1; 	
end

initial begin
	#300 $display("Testbench is OK!");
	#300 $finish;
end
	 
initial begin            
    $dumpfile("qqq.vcd");     
    $dumpvars;
end

endmodule