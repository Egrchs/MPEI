module timer #(parameter bit = 5) //чтобы быстро менять входную частоту 
				(clk_50MHz, res,clk_1Hz,cnt2, Load);

input  clk_50MHz, res, Load;

output 	 reg  clk_1Hz; //делим частоту 
output 	 reg  [bit:0]cnt2; //для подсчета количества прошедших секунд

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
		cnt <=cnt + 1'b1; 

always @(posedge clk_50MHz, negedge res) //Блок для счетчика секунд
if (!res)  
		cnt2 <= 0; 
else if (!Load)
		cnt2 <= 0;
else if (cnt == 0 && clk_1Hz)
		cnt2 <= cnt2 + 1;
else 
		cnt2 <= cnt2;
	
endmodule 
