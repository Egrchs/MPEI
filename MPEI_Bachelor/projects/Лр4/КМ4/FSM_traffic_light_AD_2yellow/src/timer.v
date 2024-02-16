module timer  (clk_50MHz, res,clk_1Hz);

input   clk_50MHz, res;

output  reg clk_1Hz; //делим частоту 

localparam COUNTS = 25_000_000;
reg [$clog2(COUNTS)-1:0] cnt;

always @(posedge clk_50MHz, negedge res) //Блок для получения 1 секунды
	if (!res) begin
			cnt <= 0;
			clk_1Hz <= 0;
	end
	else if (cnt == COUNTS)	begin
			cnt <= 0;
			clk_1Hz <= ~clk_1Hz;
	end
	else 
			cnt = cnt + 1'b1; 

endmodule 