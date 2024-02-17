`include "traffic_light_top.v"
`timescale 1ns / 1ns

module tb_traffic_light_top;

reg clk, res, btn;

wire led0, led1, led2;

traffic_light_top DUT (.clk(clk), .btn_res(res), .btn(btn), .led0(led0), .led1(led1), .led2(led2));

initial begin                                                  
  clk = 0;
  $display("Running testbench");
end         
      
initial begin
res = 1;
btn = 0;
repeat (2) #1 res = ~res;
end	  

initial  begin #3000 btn = 1;
               #3010 btn = 0; end
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
