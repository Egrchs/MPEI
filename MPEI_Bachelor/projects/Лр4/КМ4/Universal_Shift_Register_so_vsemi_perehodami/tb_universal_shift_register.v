`include "Universal_Shift_Register.v"
`timescale 1ns / 1ns
module tb_universal_shift_register #(parameter WIDTH = 15)
                                                       ();
reg clk, res;
reg [WIDTH:0] Data, M;
reg [2:0] set;
reg enable;

wire [WIDTH:0] Q;

Universal_Shift_Register DUT (.clk(clk), .res(res), .M(M), .D(Data), .set(set), .out_state(Q), .enable(enable));

initial begin
  clk = 0;
  forever #5 clk = ~clk;
end

initial begin
  res = 1;
  repeat(2) #1 res = ~res;
end

initial begin
  M = 2; // Количество сдвигаемых разрядов при логическом сдвиге
	Data  =  16'b101001011110; // Входное число
end

// Задаем состояние автомата
initial begin
        set = 1;
    #20 set = 2;
    #20 set = 3;
    #20 set = 4;
    #20 set = 5;
    #20 set = 6;
    #50 set = 3;
    #20 set = 4;

end

//Разрешение загрузки для последовательного вывода входного числа
initial  
    begin  
      enable = 1'b0;  
      #100 enable = 1'b1;  
      #10 enable = 1'b0;  
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