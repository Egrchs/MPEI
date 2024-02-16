module cnt60 #(parameter W=9)
			  (clk,res, Q0,Q1);

input       clk, res;
output 	   [3:0]  Q0;
output 	   [3:0]  Q1;

wire z;

cnt1 #(.W(9)) cnt9 (.clk(clk),.Q(Q0),.res(res));
cnt1 #(.W(6)) cnt6 (.clk(z),.Q(Q1),.res(res));

assign z = (Q0==4'd0)?1'b1:1'b0;

endmodule

