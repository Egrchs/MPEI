`include "dff.v"

`timescale 1 ps/ 1 ps

module tb_dff();

reg   D,clk, res;
                                          
wire   Q, nQ;
                  
dff DUT1 (.clk(clk),.Q(Q),.res(res),.nQ(nQ),.D(D));

initial begin                                                  
  clk = 0;
  D = 0;
  $display("Running testbench");
end         
      
initial begin
res = 1;
repeat (15) #2 res = ~res;
end	  

//задаем clk   
always 
begin
  #5 D = !D;
  #3	  clk =  ! clk;      
end  

//время тестирования
initial begin
	#30 $display("Testbench is OK!");
	#30 $finish;
end
	 
initial begin            
    $dumpfile("qqq.vcd");     // Имя сгенерированного файла vcd
    $dumpvars;    // имя модуля tb
end

endmodule