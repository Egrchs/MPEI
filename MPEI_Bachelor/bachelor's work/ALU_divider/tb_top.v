`include "ALU_top.v"
`timescale 1ns / 1ns  

module tb_alu;
 reg  clk, res;
 reg  A, B;
 reg  tvalid;

 wire out;
 wire tready;

ALU_top dut_ALU (.clk(clk), .res(res), .A(A), .B(B), .out(out),  .tvalid(tvalid), .tready(tready));

 initial                           
 begin                                                    
  clk = 0;
  res = 1;               
  tvalid = 1; 
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
A = 0;
B = 0;
#10;
A = 1;
B = 0;
#10;
A = 0;
B = 0;
#10;
A = 1;
B = 0;
#10;
A = 1;
B = 0;
#10;
A = 1;
B = 0;
#10;
A = 0;
B = 0;
#10;
A = 1;
B = 0;
#10;
A = 1;
B = 0;
#10;
A = 0;
B = 0;
#10;
A = 0;
B = 0;
#10;
A = 1;
B = 0;
#10;
A = 0;
B = 0;
#10;
A = 0;
B = 0;
#10;
A = 0;
B = 0;
#10;
A = 1;
B = 0;
#10;
tvalid = 0;

// A = 0;
// B = 0;
// #10;
// A = 1;
// B = 1;
// #10;
// A = 0;
// B = 0;
// #10;
// A = 1;
// B = 1;
// #10;
// A = 1;
// B = 1;
// #10;
// A = 1;
// B = 0;
// #10;
// A = 0;
// B = 0;
// #10;
// A = 1;
// B = 1;
// #10;
// A = 1;
// B = 0;
// #10;
// A = 0;
// B = 1;
// #10;
// A = 0;
// B = 1;
// #10;
// A = 1;
// B = 0;
// #10;
// A = 0;
// B = 0;
// #10;
// A = 0;
// B = 0;
// #10;
// A = 0;
// B = 0;
// #10;
// A = 1;
// B = 1;
// #10;
// tvalid = 0;

end      

initial begin                      
	$monitor ("At time %t 'A'=%b and 'B'=%b and 'res'=%d and 'tvalid'=%d and 'out'=%b", $time, A, B, res, tvalid, out);
#3000 $display("Testbench is OK!");
       $finish;         
end

initial begin                                      
     $dumpfile("qqq.vcd");
     $dumpvars;
end

endmodule