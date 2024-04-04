`timescale 1ns / 1ps

module mux_if_else(
    input a,
    input b,
    input c,
    input d,
    input [1:0] sel,
    output reg out
    );
    always@(*)
    begin
        if      (sel == 2'b00)    out = a;
        else if (sel == 2'b01)    out = b;
        else if (sel == 2'b10)    out = c;
        else if (sel == 2'b11)    out = d;
         
    end
endmodule
