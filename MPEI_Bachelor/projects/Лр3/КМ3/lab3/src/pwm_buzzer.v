module pwm_buzzer(clk_50,btn_sub, btn_add, pwm);

input btn_add;
input btn_sub;
input clk_50;

localparam period = 2;
localparam clk50 = 50_000_000;

output reg pwm;

reg [3:0] duty_cycle = 5;
reg [3:0] cnt_pwm = 5;


always @(posedge clk_50)
	if (cnt_pwm == period * clk50)
		cnt_pwm <= 0;
	else
		cnt_pwm <= cnt_pwm + 1;	 

always @(posedge clk_50)
	if (cnt_pwm < period * clk50 * duty_cycle / 10)
		pwm <= 1'b1;
	else
		pwm <= 1'b0;

always @(*)
	if (btn_sub && duty_cycle > 1)
		duty_cycle = duty_cycle - 1;
	else if (btn_add && duty_cycle < 9)
		duty_cycle = duty_cycle + 1;	

endmodule

