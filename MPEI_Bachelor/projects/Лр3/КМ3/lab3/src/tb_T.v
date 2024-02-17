`include "Tpov.v"
`include "T.v" 
`timescale 1 ps/ 1 ps

module tb_T();

reg   clk, res;
                                          
wire   Q, nQ, Q1, nQ1;
                  
Tpov DUT1 (.T(clk),.Q(Q),.nQ(nQ),.res(res));
T DUT2 (.T(clk),.Q(Q1),.nQ(nQ1),.res(res));

initial begin                                                  
  clk = 0;
  $display("Running testbench");
end         
      
initial begin
res = 1;
repeat (2) #1 res = ~res;
end	  

always 
  #3	  clk =  ! clk;                                                 

initial begin
	#30 $display("Testbench is OK!");
	#30 $finish;
end
	 
initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars;
end

endmodule