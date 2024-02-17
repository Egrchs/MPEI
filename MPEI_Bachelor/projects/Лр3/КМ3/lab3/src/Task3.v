module Task3(D,Y);

input [2:0] D;
output reg [1:0] Y;

always @(*)
	if (D[2] == 1'b1)
		Y = 2;
	else if (D[1] == 1'b1)
		Y = 1;
	else
		Y = 0;
		
endmodule 