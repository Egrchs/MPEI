module timer #(parameter bit = 5) //чтобы быстро менять входную частоту 
				(clk_50MHz, res,clk_1Hz);

input   clk_50MHz, res;

output  reg clk_1Hz; //делим частоту 

reg [bit:0] cnt; 

always @(posedge clk_50MHz, negedge res) //Блок для получения 1 секунды
if (!res) 
begin
		cnt <= 0;
		clk_1Hz <= 0;
end

else if (cnt == 25)
begin
		cnt <= 0;
		clk_1Hz <= ~clk_1Hz;
end

else 
		cnt = cnt + 1'b1; 

endmodule 