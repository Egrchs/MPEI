module pwm_led(clk, led, button1, button2);

input clk; //Кварц платы 
input button1; //Увеличиваем яркость
input button2; //Уменьшаем яркость

output led1; //Светодиод с которым работаем
output led2; //Светодиод для сравнения (горит всегда на полную)
output reg pwm;

reg [26:0] cnt1; //27 разрядов - 0.5 Гц
reg [26:0] cnt2;

initial     begin
cnt1  <= 0;
cnt2  <= 0; end

always @(posedge clk)  
cnt1 <= cnt + 1;

if
 
 
assign led1 = cnt[26]; //задаем моргание 1 раз в 2 секунды.
assign led2 = 1;

endmodule