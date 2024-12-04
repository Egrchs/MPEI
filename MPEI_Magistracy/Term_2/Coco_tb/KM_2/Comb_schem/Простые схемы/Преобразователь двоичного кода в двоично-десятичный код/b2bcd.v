`timescale 1ns / 1ps

module b2bcd(
    input [3:0] inp,
    output reg [7:0] outp
    );
    always @ (*)
        case(inp)
            4'b0000 : outp = 8'b00000000;
            4'b0001 : outp = 8'b00000001;
            4'b0010 : outp = 8'b00000010;
            4'b0011 : outp = 8'b00000011;
            4'b0100 : outp = 8'b00000100;
            4'b0101 : outp = 8'b00000101;
            4'b0110 : outp = 8'b00000110;
            4'b0111 : outp = 8'b00000111;
            4'b1000 : outp = 8'b00001000;
            4'b1001 : outp = 8'b00001001;
            4'b1010 : outp = 8'b00010000;
            4'b1011 : outp = 8'b00010001;
            4'b1100 : outp = 8'b00010010;
            4'b1101 : outp = 8'b00010011;
            4'b1110 : outp = 8'b00010100;
            4'b1111 : outp = 8'b00010101;
        endcase
endmodule
