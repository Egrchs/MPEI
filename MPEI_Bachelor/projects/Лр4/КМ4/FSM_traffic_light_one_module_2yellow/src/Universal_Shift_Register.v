module Universal_Shift_Register(input clk, rst_n, output [3:0] Q);

localparam RESET  = 4'b0000,
		   COUNT1 = 4'b0001,
	       COUNT2 = 4'b0011,
	       COUNT3 = 4'b0111,
	       COUNT4 = 4'b1111,
	       COUNT5 = 4'b1110;

reg [3:0] state, nextstate;

always @(posedge clk or negedge rst_n) //факт переходов
	if(!rst_n)
		state = RESET;
	else
		state = nextstate;

always @(*) //таблица переходов
	case(state)
		RESET  :  nextstate = COUNT1;
		COUNT1 :  nextstate = COUNT2;
		COUNT2 :  nextstate = COUNT3;
		COUNT3 :  nextstate = COUNT4;
		COUNT4 :  nextstate = COUNT5;
		COUNT5 :  nextstate = RESET;
		default : nextstate = RESET;
	endcase

//выходная логика
assign Q = (state == RESET)  ? 4'b0000 :
	       (state == COUNT1) ? 4'b0001 :
	       (state == COUNT2) ? 4'b0011 :
	       (state == COUNT3) ? 4'b0111 :
	       (state == COUNT4) ? 4'b1111 :
	       (state == COUNT5) ? 4'b1110 : 0;

endmodule
