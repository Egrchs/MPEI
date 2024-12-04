`timescale 1ns / 1ps
module four_bit_adder
(
  input [3:0] A,
  input [3:0] B,
  output [4:0] SUM
);

  // Первый разряд переноса - ноль
  wire CARRY0;
  assign CARRY0 = 1'b0;

  // Четыре полных сумматора объединены в один сумматор с последовательным переносом
  full_adder op1 (A[0], B[0], CARRY0, SUM[0], CARRY1);
  full_adder op2 (A[1], B[1], CARRY1, SUM[1], CARRY2);
  full_adder op3 (A[2], B[2], CARRY2, SUM[2], CARRY3);
  full_adder op4 (A[3], B[3], CARRY3, SUM[3], SUM[4]);
endmodule


// Полный сумматор
module full_adder
(
  input A,
  input B,
  input CARRY_IN,
  output SUM,
  output CARRY_OUT
);

  assign SUM = (A ^ B) ^ CARRY_IN;
  assign CARRY_OUT = (A & ~B & CARRY_IN) | (~A & B & CARRY_IN) | (A & B);
endmodule
