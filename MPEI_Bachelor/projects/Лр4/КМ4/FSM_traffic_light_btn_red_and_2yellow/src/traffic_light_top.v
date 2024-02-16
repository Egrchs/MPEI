`include "traffic_light.v"
module traffic_light_top(clk,led0, led1, led2, btn_res, btn);

input clk, btn_res, btn;

output led0, led1, led2;
	 
localparam RED = 0, YELLOW1 = 1, GREEN = 2, YELLOW2 = 3;

wire [1:0] state;

traffic_light DUT1(.clk(clk), .out_state(state), .res(btn_res), .btn(btn));

// Логика для светодиодов
assign led0 = state == RED ? 1 : 0;

assign led1 = (state == YELLOW1) | (state == YELLOW2) ? 1 : 0;

assign led2 = state == GREEN ? 1 : 0;

endmodule