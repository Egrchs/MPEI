module dff(D, clk, res, Q, nQ);

input D;
input clk;
input res;

output Q, nQ;

reg Q;

initial Q = 0;

always @(posedge clk, negedge res) 

if (!res) 
	Q <= 0;
else
	Q <= D;

assign nQ = ~Q;
	
endmodule