`include "traffic_light_top.v"
`timescale 1ns / 1ns

module tb_traffic_light_top;

reg clk, res, btn;

wire led0, led1, led2;

traffic_light_top DUT (.clk(clk), .res(res), .btn(btn), .led0(led0), .led1(led1), .led2(led2));
initial 
  begin
    res = 1;
    repeat (2) #1 res = ~res;
  end	 

initial 
  begin                                                  
    clk = 0;
    btn = 0;
    $display("Running testbench");
  end         
      
//Нажимаем кнопку для перехода из красного в зеленый
initial  
  begin 
    #4000  btn = 1;
    #4010  btn = 0; 
    #15000 btn = 1;
    #5000  btn = 0;
  end

always 
  #3 clk =  ! clk;                                                 

initial begin
	#50000 $display("Testbench is OK!");
         $finish;
end

initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars;
end

endmodule
