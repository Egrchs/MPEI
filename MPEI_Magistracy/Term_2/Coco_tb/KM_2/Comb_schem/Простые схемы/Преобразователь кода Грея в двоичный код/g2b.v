`timescale 1ns / 1ps
module g2b(
    input [3:0] in,
    output [3:0] out
    );
    wire a,b,c;
    assign out[3] = in[3];
    xor m1(a,in[3],in[2]);
    xor m2(b,a,in[1]);
    xor m3(c,b,in[0]);
    assign out[2] = a;
    assign out[1] = b;
    assign out[0] = c;
endmodule
