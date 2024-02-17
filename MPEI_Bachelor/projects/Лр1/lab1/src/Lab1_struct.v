module Lab1_struct(x, y);

input [2:0] x;

output [2:0] y;

wire [2:0] w;

not (w[0], x[0]);
not (w[1], x[1]);
xor (w[2], w[0], w[1]);
xnor (y[1], x[0], x[2]);
or (y[0], w[1], x[2]);
nor(y[2], w[2],x[2]);

endmodule


