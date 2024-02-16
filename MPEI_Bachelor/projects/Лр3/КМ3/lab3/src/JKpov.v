module JKpov(J, K, clk, Q, nQ, res);

input J, K, clk, res;
output Q,nQ;

reg Q;

initial Q = 0;

always @(posedge clk, negedge res)
    if (!res)
		Q<=0;
	else if(J == 0 && K == 0)
		Q <= Q;
    else if(J == 0 && K == 1)
		Q <= 0;
    else if(J == 1 && K == 0)
		Q <= 1;
	else 
		Q <= ~Q; 
		
assign nQ = !Q;


endmodule 

