`timescale 1ns / 1ps
module comp(
    input [3:0] in_1,
    input [3:0] in_2,
    output reg equal,
    output reg less,
    output reg great
    );
    always@(*)
    begin
        equal = 0;
        great = 0;
        less = 0;
        if(in_1 == in_2)
            equal = 1;
        else if(in_1 > in_2)
            great = 1;
        else
            less = 1;
    end
endmodule
