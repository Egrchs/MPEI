module Lab1_beh(x,y);

input [2:0] x;
output [2:0] y;

wire [2:0] w;

assign y[0] = ~x[1] | x[2]; 
assign y[1] = ~(x[0]^x[2]);
assign y[2] = ~(~x[0]^~x[1]|x[2]);

endmodule
