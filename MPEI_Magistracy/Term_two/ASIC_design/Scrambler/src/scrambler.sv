module scrambler(
	input  logic   clk,
	input  logic   rst,
	input  logic   bit_in,
	output logic   bit_out);



	logic feedback;
	logic [9:0] q;
	assign feedback =  (q[8] ^ q[2] ^ q[0]);
	assign bit_out = feedback ^ bit_in;



	always_ff @(posedge clk or negedge rst) begin
		if (!rst) 
			q <=  10'b00_1001_0110; 
		else
			q <= {feedback,q[9:1]};
	end

endmodule