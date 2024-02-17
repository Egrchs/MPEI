module reverscnt #(parameter WIDTH = 5)
				  (Q, n, clk, res,x);

output reg [WIDTH-1:0] Q;

input        n; // направление счета
input clk, res;
input [WIDTH-1:0] x; //начальное значение счета

wire [WIDTH-1:0] k;
reg  [WIDTH-1:0] cnt;


assign k = 8; //кф счета

always @(posedge clk, negedge res) 

if(!res) 
	cnt <= 0;
else if (cnt<k)
	cnt <=  cnt + 1;
else 
	cnt <= 0;

always @(posedge clk, negedge res) 

if (~res)
	Q <= x;

else if (n && (cnt < k)) begin
	Q <= Q + 1; end
	
else if (!n && (cnt < k)) begin
	Q <= Q - 5'b1; end
else 	Q <= x;
endmodule
 
 
 