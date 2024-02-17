`include "dff.v" 
module JK (J, K, clk, Q, nQ, res);

input J, K, clk, res;

output  Q;
output nQ;

wire D;

dff DUT1 (.clk(clk),.Q(Q),.nQ(nQ),.D(D),.res(res));

assign D = (nQ & J) | (Q & ~K);

endmodule 