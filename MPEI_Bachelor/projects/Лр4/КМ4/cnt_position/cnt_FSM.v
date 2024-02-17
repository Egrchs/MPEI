module cnt_FSM(input clk, rst_n, output [7:0] Q);

localparam RESET  = 0,
		   COUNT0 = 8'b00000001,
		   COUNT1 = 8'b00000010,
	       COUNT2 = 8'b00000100,
	       COUNT3 = 8'b00001000,
	       COUNT4 = 8'b00010000,
	       COUNT5 = 8'b00100000,
	       COUNT6 = 8'b01000000,
	       COUNT7 = 8'b10000000;

reg [7:0] state, nextstate;

always @(posedge clk or negedge rst_n) //факт переходов
	if(!rst_n)
		state = RESET;
	else
		state = nextstate;

always @(*) //таблица переходов
	case(state)
		RESET  :  nextstate = COUNT0;
		COUNT0 :  nextstate = COUNT1;
		COUNT1 :  nextstate = COUNT2;
		COUNT2 :  nextstate = COUNT3;
		COUNT3 :  nextstate = COUNT4;
		COUNT4 :  nextstate = COUNT5;
		COUNT5 :  nextstate = COUNT6;
		COUNT6 :  nextstate = COUNT7;
		COUNT7 :  nextstate = COUNT0;
		default : nextstate = RESET;
	endcase

//выходная логика
assign Q = (state == RESET)  ? 0           :
		   (state == COUNT0) ? 8'b00000001 :
	       (state == COUNT1) ? 8'b00000010 :
	       (state == COUNT2) ? 8'b00000100 :
	       (state == COUNT3) ? 8'b00001000 :
	       (state == COUNT4) ? 8'b00010000 :
	       (state == COUNT5) ? 8'b00100000 :
	       (state == COUNT6) ? 8'b01000000 :
	       (state == COUNT7) ? 8'b10000000 : 0;

endmodule
