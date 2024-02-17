`include "Universal_Shift_Register.v"
`timescale 1ns / 1ns
module tb_universal_shift_register #(parameter WIDTH = 5)
                                                       ();
localparam parall_out = 0, serial_out = 1, logic_shft_left = 2, logic_shft_right = 3, ring_shft_left = 4, ring_shft_right = 5;

reg clk, res;
reg [WIDTH:0] Data, M;
reg [2:0] Load;
reg enable;

wire [WIDTH:0] Q;

Universal_Shift_Register DUT (.clk(clk), .res(res), .M(M), .D(Data), .Load(Load), .out_state(Q), .enable(enable));

initial begin
  clk = 0;
  forever #5 clk = ~clk;
end

initial begin
  res = 1;
  repeat(2) #1 res = ~res;
end

initial begin
  M = 3; // Количество сдвигаемых разрядов при логическом сдвиге
	Data  =  6'b100011; // Входное число
end

// Задаем состояние автомата
initial begin
        Load = 0;
    #10 Load = 1;
    #10 Load = 2;
    #10 Load = 3;
    #10 Load = 4;
    #10 Load = 5;
	  #10 Load = 6;
end

//Разрешение загрузки для последовательного вывода входного числа
initial  
    begin  
      enable = 1'b0;  
      #60 enable = 1'b1;  
      #15 enable = 1'b0;  
    end  

initial begin
	#300  $display("Testbench is OK!");
        $finish;
end

//Для симуляция в Iverilog		 
initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars;
end
endmodule