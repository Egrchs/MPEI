`include "register.v"
`timescale 1ns / 1ns
module tb_register  ();

reg clk, res;
reg [15:0] D;
reg [3:0] M;
reg [2:0] set;
reg enable;

wire [15:0] Q;

register DUT (.clk(clk), .res(res), .M(M), .D(D), .set(set), .outstate(Q));

initial begin
  clk = 0;
  forever #5 clk = ~clk;
end

initial begin
  res = 1;
  repeat(2) #1 res = ~res;
end

initial begin
M = 3; // Количество сдвигаемых разрядов
D  =  16'b0010_0110_1001; // Входное число

end

// Задаем состояние автомата
initial begin
        set = 0;
    #30 set = 1;
    #30 set = 2;
    #30 set = 3;
    #30 set = 4;
end

initial begin
	#200  $display("Testbench is OK!");
          $finish;
end

//Для симуляция в Iverilog		 
initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars;
end
endmodule