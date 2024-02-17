//Плавное изменение яркости

module pwm(clk,led,pwm);

input clk;

output led; //светодиод для сравнения
output reg pwm; //изменяющийся светодиод

reg [4:0] Level; //порог 
reg [22:0] Q; // задержка времени сдвига порога

assign led = 1'b0; //светодиод для сравнения всегда горит

//начальные значения счетчиков
initial begin
Q = 23'b0;
Level = 5'b0; end

always @(posedge clk)
begin
	Q = Q + 1;
if (Q == 23'h7FFFFF) //если счетчик достиг максимального значения
	Level = Level + 1; 
if (Q[4:0] == Level) //младшие биты счетчика отвечают за модуляцию на линии светодиода
	pwm = 1'b1; //гасим
else if (Q[4:0] == 5'b0)
	pwm = 1'b0; //зажигаем
else
	pwm = pwm;
end

endmodule