`include "paramreg.v"
`timescale 1 ps/ 1 ps

module tb_paramreg #(parameter WIDTH = 12)();

reg   clk, L;
reg [WIDTH-1:0] D;
reg E;
                                
wire   [WIDTH-1:0] Q;
                  
paramreg DUT1 (.clk(clk),.Q(Q),.L(L),.E(E),.D(D));

//clk
initial begin
    $display("Running testbench");                                                  
	clk = 0;
  forever #5 clk = ~clk;
end 

//L
initial begin
	L = 0;
	#10 L = 1;
	#80 L = 0;
end	  

//выбор направления сдвига
initial begin
	E = 0;
	#50 E = 1;
end

//ввод числа
initial begin
	D = 12'd55;
end
initial begin
	$monitor ("At time %t 'L'=%b and 'E'=%b and 'D'=%b and 'Q'=%b",$time,L,E,D,Q);
	#100 $display("Testbench is OK!");
	#100 $finish;
end
	 
initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars;
end

endmodule