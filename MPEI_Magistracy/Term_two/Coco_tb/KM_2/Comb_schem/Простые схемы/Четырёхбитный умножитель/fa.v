`timescale 1ns / 1ps

module fa(
    input a,
    input b,
    input c,
    output sum,
    output ca
    );
    
    assign sum = a^b^c;
    assign ca = a&b | a&c | b&c ;
    
endmodule
