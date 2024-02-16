`include "dff.v" 

module T (T,Q,nQ,res);

input T, res;

output  Q;
output  nQ;

wire D;

dff DUT1 (.clk(T),.Q(Q),.nQ(nQ),.D(D),.res(res));

assign D = nQ;

endmodule