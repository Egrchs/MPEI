`include "ALU.v"
`timescale 1ns / 1ps  

module tb_alu;
 reg clk, res;
 reg[3:0] A, B;
 reg[4:0] select;

 wire[7:0] out;

 integer i;
 ALU DUT(.A(A), .B(B), .select(select), .out(out), .clk(clk), .res(res));

initial                           // Задаем начальные значения такта и сброса
begin                                                    
  clk = 0; 
  res = 1; 
  $display("Running testbench"); 
end          
 
always                            // Задаем вечный такт каждые 5нс
  #5	   
  clk = !clk;   
 
//initial begin                     // Блок бля сброса выходного регистра                                            
//  #150 
//  res = 0;  
//  #100 
//  res = 1;    
//end   
 
initial  
begin  
  A = 4'b0100;                    // Задаем начальные значения входных операндов
  B = 4'b1001; 
  select = 0;                     // Начальное значение выбора операции
 
  for (i = 0; i <= 14; i = i + 1) // Цикл для последовательного перебора выбора операции (для удобной проверки)
    begin 
      select = select + 1;
      #20;                        // Каждые 20 нс операция меняется
    end;  
end

initial                           // Блок для изменения входных операндов и кол-ва сдвигаемых разрядов
begin
      #160
      A = 4'b1101;
      B = 4'b1111;
      #100
      A = 4'b1001;
      B = 4'b0110;  
  end

initial                           // Блок для изменения значения выбора операции
begin                             // После последовательного прогона всех операций можем выбрать любую из них
      #340                  
      select = 12;
      #20
      select = 13;       
  end

initial begin                     // Блок, где можно задать время тестирования  
	$monitor ("At time %t 'A'=%b and 'B'=%b and 'select'=%d and 'out'=%b",$time,A,B,select,out);
#400 $display("Testbench is OK!");
     $finish;         
end

initial begin                     // Блок для симуляции в Iverilog                 
     $dumpfile("qqq.vcd");
     $dumpvars;
end

endmodule


