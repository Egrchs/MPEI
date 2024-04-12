module scrambler
(
	input  logic   CLK_I,
	input  logic   RST_N_I,
	input  logic   BIT_I,
	output logic   BIT_O
);
	logic        feedback;
	logic [11:0] q;

	assign feedback =  (q[10] ^ q[3] ^ q[0]);
	assign BIT_O    = feedback ^ BIT_I;

	always_ff @(posedge CLK_I, negedge RST_N_I) begin
		if (!RST_N_I) begin
			q <=  12'b0001_0100_1101;
		end 
		else begin
			q <= {feedback, q[11:1]};
		end
	end

endmodule