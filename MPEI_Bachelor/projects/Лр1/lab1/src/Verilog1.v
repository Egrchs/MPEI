module lab_1_struct(x, y);

input [2:0] x;

output [2:0] y;

wire [2:0] w;

xor (w[2], w[0], w[1]);
xnor (y[2], x[0], x[2]);
or (y[1], w[1], x[2]);
nor(y[3], w[2],w[1]);

endmodule


