`include "div_new.v"
`timescale 1ns / 1ns  

module tb_div;
 reg  clk, res;
 reg  [4:0] A, B;
 reg      load;

 wire [4:0]quotient;
 wire [4:0]reminder;
 wire         error;
 

div_new DUT (.clk(clk), .res(res), .A(A), .B(B), .quotient(quotient), .reminder(reminder), .load(load), .error(error));

 initial                           
 begin                                                    
  clk = 0;
  res = 1;   
          
  $display("Running testbench"); 
 end

always                            
  #5	   
  clk = !clk;   
 
 initial begin
repeat (2) #2 res = ~res;
end
initial                           
begin       
     load = 1'b1;
     A = 5'b11101;
     B = 5'b01110;
     #50 load = ~ load;

     #50load = 1'b1;
     A = 5'b01010;
     B = 5'b11010;
     #50 load = ~ load;

     #50load = 1'b1;
     A = 5'b00000;
     B = 5'b11010;
     #50 load = ~ load;

     #50load = 1'b1;
     A = 5'b10101;
     B = 5'b00000;
     #50 load = ~ load;   

     #50load = 1'b1;
     A = 5'b10101;
     B = 5'b01101;
     #50 load = ~ load;     

     #50load = 1'b1;
     A = 5'b00000;
     B = 5'b00000;
     #50 load = ~ load;

     #50load = 1'b1;
     A = 5'b11101;
     B = 5'b00011;
     #50 load = ~ load;                             
end      

initial begin                      
	$monitor ("At time %t 'A'=%b and 'B'=%b and 'res'=%d  and 'out'=%b", $time, A, B, res, quotient);
#1000 $display("Testbench is OK!");
       $finish;         
end

initial begin                                      
     $dumpfile("qqq.vcd");
     $dumpvars;
end

endmodule