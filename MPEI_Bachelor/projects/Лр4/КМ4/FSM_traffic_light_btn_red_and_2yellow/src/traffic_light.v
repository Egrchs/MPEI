`include "timer.v"
module traffic_light(clk, res, out_state, btn);

input clk, res, btn;

output [1:0] out_state;

localparam RED = 0, YELLOW1 = 1, GREEN = 2, YELLOW2 = 3;

reg [1:0] state, next_state;
reg [63:0] txstate;

always @(state)
	case (state)
		RED     : txstate = "RED";
		YELLOW1 : txstate = "YELLOW";
		GREEN   : txstate = "GREEN";
		YELLOW2 : txstate = "YELLOW2";
	endcase

reg [5:0] cnt;

wire proverka = (state == RED && cnt == 40) || ((state == YELLOW1 || state == YELLOW2) && cnt == 3) || ((state == GREEN) && cnt == 21);

wire clk_1Hz;

timer one_second(.clk_50MHz(clk), .res(res), .clk_1Hz(clk_1Hz)); //Подключаем таймер 

always @(posedge clk_1Hz, negedge res)
begin
if (!res)
 	cnt <= 0;
else if (proverka)
   cnt <= 0;
else 
	cnt <= cnt + 1;
	
end

always @(*)
	case(state)
		RED     : 
				if(cnt == 40)
					next_state = YELLOW1;
				else if (cnt1 == 3)
					next_state = GREEN;
				else 
					next_state = RED;
		YELLOW1 : next_state = (cnt == 3) ? GREEN : YELLOW1;
		GREEN   : next_state = (cnt ==21) ? YELLOW2 : GREEN;
		YELLOW2 : next_state = (cnt ==3) ? RED : YELLOW2;
	endcase

//Логика переключения из красного в зеленый по нажатию кнопки
reg [1:0] cnt1;
always @(posedge btn, posedge clk_1Hz)
    if (btnD)
        cnt1 <= cnt1 + 1;
	else if (cnt == 37)
		cnt1 <= 0;
	else 
		cnt1 <= 0;

always @(posedge clk_1Hz, negedge res)
begin
if (!res)
 	state <= RED;
else
	state <= next_state;
end

assign out_state = state;

endmodule