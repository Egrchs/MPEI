`include "cnt2.v"
`timescale 1 ps/ 1 ps

module tb_cnt2();

reg   clk, res;
                                          
wire [3:0]  Q0;
wire [3:0]  Q1; 
           
cnt2 DUT1 (.clk(clk),.Q0(Q0),.Q1(Q1),.res(res));

initial begin                                                  
  clk = 0;
  res = 1;  
  $display("Running testbench");
end                                                    

//задаем clk   
always 
  #5  clk =  ! clk;                                                 

//время тестирования
initial begin
	#1000 $display("Testbench is OK!");
	#1000 $finish;
end
	 
initial begin            
    $dumpfile("qqq.vcd");     // Имя сгенерированного файла vcd
    $dumpvars(0, tb_cnt2);    // имя модуля tb
end


endmodule