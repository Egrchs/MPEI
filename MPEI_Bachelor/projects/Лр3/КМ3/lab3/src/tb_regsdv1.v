`include "regsdv1.v"
`timescale 1 ps/ 1 ps

module tb_regsdv1 #(parameter WIDTH = 32)();

reg   clk, L, res;
reg [WIDTH-1:0] D;
reg [WIDTH-1:0] D1;
reg [WIDTH-1:0] M;
reg [1:0] E;
                                
wire   [WIDTH-1:0] Q;
wire   [WIDTH-1:0] Q1;
                  
regsdv1 DUT1 (.clk(clk),.Q(Q),.L(L),.E(E),.D(D), .Q1(Q1), .D1(D1), .M(M), .res(res));

//clk
initial begin
    $display("Running testbench");                                                  
	clk = 0;
  forever #5 clk = ~clk;
end 

//На сколько разрядов сдвинуть
initial 
M = 4;

initial begin
	res = 1;
	// #25 
	// res = 0;
	// #5
	// res = 1;
end

//L
initial begin
	L = 1;
	#15 L = 0;
	#15 L = 1;
	#15 L = 0;
	#15 L = 1;
	#15 L = 0;
	#5 L = 1;
	//repeat (2) #1 res = ~res;
end	  

//выбор направления сдвига
initial begin
	E = 0;
	#30
	E = 1;
	#30
	E = 2;
//	#50 E = 1;
end

//ввод числа
initial begin
	D  =  32'b00001000010010001000000000000000;
	#30
	D  =  32'b00001000000000000000100000000010;
	#30
	D1 = -32'b10000011000000000000000100000001;
end

//время тестирования
initial begin
	$monitor ("At time %t 'D'=%b and 'D1'=%b and 'Q'=%b and 'Q1'=%b",$time,D,D1,Q,Q1);
	#100 $display("Testbench is OK!");
	#100 $finish;
end

initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars;
end

endmodule