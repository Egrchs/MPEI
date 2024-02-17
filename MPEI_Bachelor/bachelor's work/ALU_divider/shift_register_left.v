module cnt256 (L, clk, res, x, input_reg);

input [7:0]x;
input L, clk, res;

//output reg [7:0] output_reg;

output reg [7:0] input_reg;

always @(posedge clk, negedge res)

if(!res)
	input_reg <=0;
else begin
	if(L)
		input_reg <= x;
	else
		input_reg <= input_reg + 1'b1;
	end
endmodule



 