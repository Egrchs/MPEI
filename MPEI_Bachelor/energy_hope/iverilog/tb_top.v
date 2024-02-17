`include "top_module.v"
`timescale 1ns / 1ps  

module tb_top;
 reg CLK, res_btn; 
 reg [1:0] KEY_A, KEY_B; 
 reg [3:0] select;
 wire SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, DIG1, DIG2, DIG3, DIG4, LED1, LED2, LED3, LED4;


integer i;

 top_module  top_module(.CLK(CLK), .res_btn(res_btn), .KEY_A(KEY_A), .KEY_B(KEY_B), .select(select),
 .SEG0(SEG0), .SEG1(SEG1), .SEG2(SEG2), .SEG3(SEG3), .SEG4(SEG4), .SEG5(SEG5), .SEG6(SEG6), .DIG1(DIG1), .DIG2(DIG2), .DIG3(DIG3), .DIG4(DIG4), .LED1(LED1), .LED2(LED2), .LED3(LED3), .LED4(LED4));

initial                           // Задаем начальные значения такта и сброса
begin                                                    
  CLK = 0; 
  res_btn = 1; 
  $display("Running testbench"); 
end          
 
always                            // Задаем вечный такт каждые 5нс
  #5	   
  CLK = !CLK;   
 
//initial begin                   // Блок бля сброса выходного регистра                                            
//  #150 
//  res_btn = 0;  
//  #100 
//  res_btn = 1;    
//end   
 
initial  
begin  
   KEY_A = 2'b10;                      // Задаем начальные значения входных операндов
   KEY_B = 2'b01; 
   select = 0;                     // Начальное значение выбора операции
 
  for (i = 0; i <= 14; i = i + 1) // Цикл для последовательного перебора выбора операции (для удобной проверки)
    begin 
      select = select + 1;
      #20000;                        // Каждые 20 нс операция меняется
    end;  
end

initial                           // Блок для изменения входных операндов и кол-ва сдвигаемых разрядов
begin
      #20000
      KEY_A = 2'b11;
      KEY_B = 2'b11;
      #10000
      KEY_A = 2'b01;
      KEY_B = 2'b10;  
  end

initial                           // Блок для изменения значения выбора операции
begin                             // После последовательного прогона всех операций можем выбрать любую из них
      #20000                 
      select = 12;
      #20000
      select = 13;       
  end

initial begin                     // Блок, где можно задать время тестирования  
	//$monitor ("At time %t 'A'=%b and 'B'=%b and 'select'=%d and 'out'=%b",$time,A,B,select,out);
#400000 $display("Testbench is OK!");
     $finish;         
end

initial begin                     // Блок для симуляции в Iverilog                 
     $dumpfile("qqq.vcd");
     $dumpvars;
end

endmodule


