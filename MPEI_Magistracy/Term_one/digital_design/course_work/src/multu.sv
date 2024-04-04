module p2d
#(
	parameter WIDTH = 32
)
(
  	input  logic [WIDTH-1:0] x,
  	output logic [WIDTH-1:0] y
);

  always_comb 
  	y = x[WIDTH-1] ? {x[WIDTH-1], (~x[WIDTH-2:0]) + 1'b1} : x;
endmodule

module d2p
#(
  	parameter WIDTH = 32
)
(
  input  logic [WIDTH-1:0] x,
  output logic [WIDTH-1:0] y
);
  always_comb 
  	y =x[WIDTH-1]? {x[WIDTH-1],~(x[WIDTH-2:0] - 1'b1)} : x;
endmodule

module multu 
	#(
		parameter Q = 18,
		parameter N = 32
	)
	(
	 	input	logic	[    N - 1 : 0]	mul1,
	 	input	logic	[    N - 1 : 0]	mul2,
	 	output	logic	[2 * N - 1 : 0]	result
	 );
	 
	logic [2 * N - 1 : 0] r_result;											
	logic [    N - 1 : 0] RetVal;
	logic [    N - 1 : 0] a;
	logic [    N - 1 : 0] b;
	
	always_comb	begin						
		r_result      = a[N-2:0] * b[N-2:0];	 
		RetVal[N-1]   = a[N-1] ^ b[N-1];	
		RetVal[N-2:0] = r_result[N-2+Q:Q];	
   	end
	
	d2p
	#(
		.WIDTH(N)
	)
	d2p1 
	(
		.x(mul1), 
		.y(a)
	);

	d2p
	#(
		.WIDTH(N)
	)
	d2p2 
	(
		.x(mul2), 
		.y(b)
	);

	p2d
	#(
		.WIDTH(N)
	)
	p2d1 
	(
		.x(RetVal), 
		.y(result)
	);
endmodule	