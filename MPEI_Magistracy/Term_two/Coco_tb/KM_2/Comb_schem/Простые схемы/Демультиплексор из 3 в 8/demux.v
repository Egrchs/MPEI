`timescale 1ns / 1ps
module demux(
    input a,
    input [2:0] s,
    output reg [7:0] y
    );
    always @(*)
    begin
        y=0;
        case(s)
            3'd0: y[0]=a;
            3'd1: y[1]=a;
            3'd2: y[2]=a;
            3'd3: y[3]=a;
            3'd4: y[4]=a;
            3'd5: y[5]=a;
            3'd6: y[6]=a;
            3'd7: y[7]=a;
        endcase
    end
endmodule
