`include "JKpov.v"
`include "JK.v" 
`timescale 1 ns/ 1 ps

module tb_JK();

reg   clk, res, J, K;
                                          
wire   Q, nQ, Q1, nQ1;
                  
JKpov DUT1 (.K(K),.J(J),.clk(clk),.Q(Q),.nQ(nQ),.res(res));
JK DUT2 (.K(K),.J(J),.clk(clk),.Q(Q1),.nQ(nQ1),.res(res));

initial begin
  $display("Running testbench");                                                  
  clk = 0;
  forever #5 clk = ~clk;
end     

initial begin
  res = 1;
  repeat (2) #1 res = ~res;
end       
      
initial begin
	J = 0; K = 0;
	#10
	J = 1; K = 0;
	#20 J = 0; K = 1;
	#30 J = 1; K = 1;
	#40 J = 0; K = 0;
end      
	 
initial begin
	#500 $display("Testbench is OK!");
	#500 $finish;
end
	 
initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars;
end

endmodule