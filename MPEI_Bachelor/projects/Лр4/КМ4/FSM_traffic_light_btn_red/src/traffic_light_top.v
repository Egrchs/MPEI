`include "traffic_light.v"
module traffic_light_top(clk,led0, led1, led2, res, btn);

input clk, res, btn;

output led0, led1, led2;
	 
localparam RED = 0, GREEN = 1, YELLOW = 2;

wire [1:0] state;

traffic_light DUT1(.clk(clk), .out_state(state), .res(res), .btn(btn));

assign led0 = state == RED ? 1 : 0;
assign led1 = state == YELLOW ? 1 : 0;
assign led2 = state == GREEN ? 1 : 0;

endmodule