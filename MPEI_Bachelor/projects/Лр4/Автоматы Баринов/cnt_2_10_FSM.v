module cnt_2_10_FSM(input clk, rst_n, output [3:0] Q);

localparam RESET = 4'd0,
	   COUNT1 = 4'd1,
	   COUNT2 = 4'd2,
	   COUNT3 = 4'd3,
	   COUNT4 = 4'd4,
	   COUNT5 = 4'd5,
	   COUNT6 = 4'd6,
	   COUNT7 = 4'd7,
	   COUNT8 = 4'd8,
	   COUNT9 = 4'd9;


reg [3:0] state, nextstate;

always @(posedge clk or negedge rst_n) //факт переходов
	if(!rst_n)
		state = RESET;
	else
		state = nextstate;

always @(*) //таблица переходов
	case(state)
		RESET :   nextstate = COUNT1;
		COUNT1 :  nextstate = COUNT2;
		COUNT2 :  nextstate = COUNT3;
		COUNT3 :  nextstate = COUNT4;
		COUNT4 :  nextstate = COUNT5;
		COUNT5 :  nextstate = COUNT6;
		COUNT6 :  nextstate = COUNT7;
		COUNT7 :  nextstate = COUNT8;
		COUNT8 :  nextstate = COUNT9;
		COUNT9 :  nextstate = RESET;
		default : nextstate = RESET;
	endcase

//выходная логика
assign Q = (state == RESET) ?  4'd0 :
	   (state == COUNT1) ? 4'd1 :
	   (state == COUNT2) ? 4'd2 :
	   (state == COUNT3) ? 4'd3 :
	   (state == COUNT4) ? 4'd4 :
	   (state == COUNT5) ? 4'd5 :
	   (state == COUNT6) ? 4'd6 :
	   (state == COUNT7) ? 4'd7 :
	   (state == COUNT8) ? 4'd8 :
	   (state == COUNT9) ? 4'd9 : 0;

endmodule
