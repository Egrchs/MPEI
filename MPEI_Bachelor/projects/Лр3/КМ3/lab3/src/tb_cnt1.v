`include "cnt1.v"
`timescale 1 ps/ 1 ps

module tb_cnt1();

reg   clk, res;
                                          
wire [3:0]  Q;
                  
cnt1 DUT1 (.clk(clk),.Q(Q),.res(res));

initial begin                                                  
  clk = 0;
  res = 1;  
  $display("Running testbench");
  $monitor ("At time %t 'Q'=%b", $time, Q);
  #500 $display("Testbench is OK!");
  #500 $finish; //время тестирования
end       
                                             
//задаем clk   
always 
  #5  clk =  ! clk;                                                 

/* initial begin
	$monitor ("At time %t 'Q'=%b", $time, Q);
	#500 $stop; //время тестирования
	 $display("Testbench is OK!");
end */
	 
initial begin            
    $dumpfile("qqq.vcd");        // Имя сгенерированного файла vcd
    $dumpvars(0, tb_cnt1);    // имя модуля tb
end

endmodule