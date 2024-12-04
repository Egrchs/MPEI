`timescale 1ns / 1ps

module tb_mult
#(
  parameter PAYLOAD_BITS = 8
);

 
  logic [PAYLOAD_BITS - 1 : 0] a_i;
  logic [PAYLOAD_BITS - 1 : 0] b_i;

  logic clk_i;
  logic rst_n;
  logic load_i;

  logic  [PAYLOAD_BITS * 2 - 1 : 0] out_o;

  mult
  #(
    .PAYLOAD_BITS(PAYLOAD_BITS)
  ) 
  UUT 
  (
    .CLK_I      (clk_i  ), 
    .RST_N_I    (rst_n  ), 
    .LOAD_I     (load_i ),
    .OPER_ONE_I (a_i    ), 
    .OPER_TWO_I (b_i    ), 
    .DATA_O     (out_o  ) 
    );

initial begin
    $display("Running testbench");                                                  
    clk_i = 0;
  forever #2 clk_i = ~clk_i;
end 
initial begin
	rst_n = 1;
	repeat (2) #3 rst_n = ~rst_n;
end	  
 initial begin
  load_i = 1'b1;
  a_i = 8'b10010011;
  b_i = 8'b11101010;
  #30 load_i = 1'b0;
  
  #100
  load_i = 1'b1;
  a_i = 8'b10011111;
  b_i = 8'b10101010;
  #30 load_i = 1'b0;

  #10
  load_i = 1'b1;
  a_i = 8'b10010111;
  b_i = 8'b11101110;
  #30 load_i = 1'b0;

  #10
  load_i = 1'b1;
  a_i = 8'b11011001;
  b_i = 8'b10001110;
  #30 load_i = 1'b0;

  #10
  load_i = 1'b1;
  a_i = 8'b10011011;
  b_i = 8'b11101010;
  #30 load_i = 1'b0;

  #10
  load_i = 1'b1;
  a_i = 8'b11110011;
  b_i = 8'b11101011;
  #30 load_i = 1'b0;
 end
 
 //время тестирования
initial begin
	#1000 $display("Testbench is OK!"); $finish;
end

 initial begin            
    $dumpfile("dump/wave.vcd");
    $dumpvars;
end

endmodule