module mult_tb;
	logic [15:0] a;
	logic [15:0] b;
	logic [15:0] res;
	multu m1(.mul1(a), .mul2(b), .result(res));

initial begin
	a = 16'b0000010100000000; //2,5
	b = 16'b0000110010000000; //6,25 
	#10;
	a = 16'b0000010100000000; //2,5
	b = 16'b1111111000000000; //-0,999 
	#10;
end
initial begin            
    $dumpfile("dump/wave.vcd");
    $dumpvars;
end
endmodule