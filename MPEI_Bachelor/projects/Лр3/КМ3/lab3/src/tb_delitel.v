`include "delitel.v"
`timescale 1 ps/ 1 ps

module tb_delitel();

reg   clk_50MHZ, res;
                           
wire  clk_1Hz, flag; 
           
delitel DUT1 (.clk_50MHZ(clk_50MHZ),.clk_1Hz(clk_1Hz),.res(res),.flag(flag));

initial begin                                                  
  clk_50MHZ = 0;
  $display("Running testbench");
end         
      
initial begin
res = 1;
repeat (2) #1 res = ~res;
end	  

always 
  #3	  clk_50MHZ =  ! clk_50MHZ;                                                 

initial begin
	#3000 $display("Testbench is OK!");
	#3000 $finish;
end
	 
initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars;
end

endmodule