module delitel(clk_50MHZ, res,clk_1Hz,flag);

input  clk_50MHZ, res;

output 	 reg  clk_1Hz;
output 	 reg  flag;

reg [5:0] cnt;


always @(posedge clk_50MHZ, negedge res)
if (!res) 
begin
		cnt <= 0;
		clk_1Hz <= 0;
end

else if (cnt == 5'd25)

begin
		cnt <= 0;
		clk_1Hz <= ~clk_1Hz;
end

else begin
		cnt <=cnt + 1'b1; 
end

always @(*)
if (!res)  
		flag <= 0; 
else if (cnt == 0 && clk_1Hz==1)
		flag <=1'b1;
else 
		flag <=1'b0;
	
endmodule 