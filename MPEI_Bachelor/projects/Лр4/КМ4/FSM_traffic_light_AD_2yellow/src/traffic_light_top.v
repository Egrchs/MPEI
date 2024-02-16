module traffic_light_top(clk,led0, led1, led2, btn);

input clk, btn;

output led0, led1, led2;

wire [2:0] led;
	 
localparam RED = 0, YELLOW1 = 1, GREEN = 2, YELLOW2 = 3;

wire [1:0] state;

traffic_light DUT1(.clk(clk), .out_state(state), .res(btn));
	 
// Логика для светодиодов
assign led[2] = (state == RED) ? 1 : 0;

assign led[1] = ((state == YELLOW1) || (state == YELLOW2)) ? 1 : 0;

assign led[0] = (state == GREEN) ? 1 : 0;

assign {led2, led1, led0} = ~led;

endmodule