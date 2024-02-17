//Просто тусклый светодиод

module pwm(clk,led,pwm);

input clk;

output led; //светодиод для сравнения
output reg pwm; //изменяющийся светодиод

reg [5:0] Q;

assign led = 1'b0; //светодиод для сравнения постоянно горит

initial
Q = 6'b0;

always @(posedge clk) begin
	Q = Q + 1;
if (Q == 6'd1)
	pwm = 1'b1; //выключаем светодиод
else if	(Q == 6'd0)
	pwm = 1'b0; //включаем светодиод
else 
	pwm = pwm;	
end

endmodule