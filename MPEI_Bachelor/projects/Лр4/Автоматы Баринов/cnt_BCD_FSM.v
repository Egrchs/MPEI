module cnt_BCD_FSM(input clock, reset, output [3:0] Q);

localparam INIT = 1'b0, COUNT = 1'b1;
parameter NSTOP = 4'd9;

reg state, nextstate;

reg [3:0] cnt;

//логика переключений
always @(posedge clock, negedge reset)
    if(!reset)
        state <= INIT;
    else
        state <= nextstate;

//логика перехода между состояниями
always @(*)
    case(state)
        INIT : nextstate = COUNT;
        COUNT : 
            if(cnt == NSTOP-1)
                nextstate = INIT;
            else
                nextstate = COUNT;
        default : nextstate = INIT;
    endcase

/********************************/
/*******выход с триггерами*******/
/********************************/

//формирование внутреннего счётчика
always @(posedge clock, negedge reset)
    if(state == INIT)
        cnt <= 4'd0;
    else if(state == COUNT)
        cnt <= cnt + 1'b1;

//логика формирования выхода
assign Q = cnt;

/********************************/

endmodule

