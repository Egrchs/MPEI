`include "seven_seg.v" 
`include "ALU.v" 
module seven_seg_disp (clk, data, anodes, segments, res);
input clk;

input  [3:0]data;
input        res;

output [3:0]anodes;
output [6:0]segments;

reg [1:0] i = 0;
assign anodes = (4'b1 << i);

always @(posedge clk) begin
    if(!res)
        i = 0;
    else
        i <= i + 2'b1;   
end

wire b = data[i];

seven_seg seven_seg (.data(b), .segments(segments));
//ALU ALU (.out(data), .clk(clk), .res(res));
endmodule