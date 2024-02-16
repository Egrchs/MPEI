module cnt1 #(parameter W = 9)
		     (clk, res, Q);
input clk, res;
output reg [3:0] Q;                                 

always @(posedge clk, negedge res)
	if (!res)
		Q<=0;
	else if (Q < W)
		Q<=Q+1'b1;
	else
		Q<=0;
 
endmodule  