module traffic_light(clk, res, out_state);

input clk, res;

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

wire change_state = (state == RED && cnt == 40)
				 || ((state == YELLOW1 || state == YELLOW2) && cnt == 3)
				 || ((state == GREEN) && cnt == 21);

wire clk_1Hz;

timer one_second(.clk_50MHz(clk), .res(res), .clk_1Hz(clk_1Hz)); //Подключаем таймер //Здесь нужно передать 1Гц

always @(posedge clk_1Hz, negedge res) //Здесь нужно тактирование по 1Гц
begin
	if (!res)
		cnt <= 0;
	else if (change_state)
		cnt <= 0;
	else 
		cnt <= cnt + 1;
	
end

always @(*)
	case(state)
		RED     : next_state = (cnt == 40) ? YELLOW1 : RED;
		YELLOW1 : next_state = (cnt == 3)  ? GREEN   : YELLOW1;
		GREEN   : next_state = (cnt == 21) ? YELLOW2 : GREEN;
		YELLOW2 : next_state = (cnt == 3)  ? RED     : YELLOW2;
		default : next_state = RED;
	endcase
		
always @(posedge clk_1Hz, negedge res) //Здесь нужно тактирование по 1Гц
begin
if (!res)
 	state <= RED;
else
	state <= next_state;
end

assign out_state = state;

endmodule