`include "cnt60.v"
`timescale 1 ps/ 1 ps

module tb_cnt60();

reg   clk, res;
                           
wire [3:0]  Q0;
wire [3:0]  Q1; 
           
cnt60 DUT1 (.clk(clk),.Q0(Q0),.Q1(Q1),.res(res));

initial begin                                                  
  clk = 0;
  res = 1;
  $display("Running testbench");
end         

always 
  #5  clk =  ! clk;                                                 

initial begin
    #1000 $display("Testbench is OK!");
	#1000 $finish;
end
	 
initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars(0, tb_cnt60);
end

endmodule