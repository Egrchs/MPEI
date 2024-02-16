`include "timer.v"
module traffic_light(clk, res, out_state, btn);

input clk, res, btn;

output [1:0] out_state;

localparam RED = 0, GREEN = 1, YELLOW = 2;

reg [1:0] state, next_state;
reg [63:0] txstate;
reg [5:0] cnt;

wire clk_1Hz;

timer one_second(.clk_50MHz(clk), .res(res), .clk_1Hz(clk_1Hz));
//Счетчик секунд
always @(posedge clk_1Hz, negedge res)
begin
if (!res)
 	cnt <= 0;
//Условие сброса счетчика
else if ((state == RED && cnt == 40) || (state == YELLOW && cnt == 3) || ((state == GREEN) && cnt == 21))
   cnt <= 0;
else 
	cnt <= cnt + 1;
end

//Логика переключения из красного в зеленый по нажатию кнопки
reg [1:0] cnt1;
always @(posedge btn, posedge clk_1Hz)
    if (btn && state == RED)
        cnt1 <= cnt1 + 1;
	else
		cnt1 <= 0;
//Факт переходов
always @(posedge clk_1Hz, negedge res)
begin
if (!res)
 	state <= RED;
else
	state <= next_state;
end
//Логика переходов автомата
always @(*)
	case(state)
		RED     : 
				if(cnt == 40)
					next_state = GREEN;
				else if (cnt1 == 3)
					next_state = GREEN;
				else 
					next_state = RED;
		GREEN   : next_state = (cnt ==21) ? YELLOW : GREEN;
		YELLOW : next_state = (cnt ==3) ? RED : YELLOW;
	endcase
//Выходная логика
assign out_state = state;

endmodule