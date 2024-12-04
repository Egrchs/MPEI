module mult2 
	(
	 	input	logic		[  31:0]	mul1,
	 	input	logic		[  31:0]	mul2,
	 	output	logic		[  63:0]	result
	 );
	 
	
	always_comb	begin						
		 result      = mul1 * mul2;	 
    end
endmodule