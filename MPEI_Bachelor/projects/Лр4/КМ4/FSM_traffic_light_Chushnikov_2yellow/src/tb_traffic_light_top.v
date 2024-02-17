`include "traffic_light_top.v"
`timescale 1ns / 1ns

module tb_traffic_light_top;

reg clk, res;

wire led0, led1, led2;

traffic_light_top DUT (.clk(clk), .res(res), .led0(led0), .led1(led1), .led2(led2));

initial begin                                                  
  clk = 0;
  $display("Running testbench");
end         
      
initial begin
res = 1;
repeat (2) #1 res = ~res;
end	  

always 
  #1	  clk =  ! clk;                                                 

initial begin
	#30000 $display("Testbench is OK!");
         $finish;
end

//Для симуляция в Iverilog		 
initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars;
end

endmodule
