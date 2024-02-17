module revers_cnt_BCD_FSM(clk, res, revers, data, Q);

input   clk, res; 
input     revers; // Выбор направления счета 0 - увеличение, 1 - уменьшение
input [3:0] data; // Ввод начального значения

output [3:0]   Q; // Результат

// LOAD - загрузка, COUNT - увеличение, COUNT1 - уменьшение
localparam LOAD = 0 , COUNT = 1, COUNT1 = 2;

parameter  NSTOP = 0; // Ограничеие при уменьшении, чтобы не уходил в отрицательные числа
parameter NSTOP1 = 9; //Ограниече при увеличинии, так как счетчик двоично - десятичный

reg [1:0] state, nextstate;

reg [3:0] cnt;

//логика переключений
always @(posedge clk, negedge res)
    if(!res)
        state <= LOAD;
    else
        state <= nextstate;

//логика работы автомата
always @(*)
    case(state)
        LOAD :                          // Выбор действия в начальном состоянии
            if (!revers)
                nextstate = COUNT;
            else if (revers)
                nextstate = COUNT1;
            else 
                nextstate = LOAD;
        COUNT :                         // Выбор действия в состоянии увеличения
            if(cnt == NSTOP1-1)
                nextstate = LOAD;       
            else if (revers)
                nextstate = COUNT1;
            else 
                nextstate = COUNT;
        COUNT1 :                        // Выбор действия в состоянии уменьшения 
            if(cnt == NSTOP+1)
                nextstate = LOAD;
            else if (!revers)
                nextstate = COUNT;
            else
                nextstate = COUNT1;
        default : nextstate = LOAD;
    endcase

//формирование внутреннего счётчика
always @(posedge clk, negedge res)
    if (!res)
        cnt <= 0;
    else if(state == LOAD) // Присваиваем счетчику входное число
        cnt <= data;
    else if(state == COUNT) // Для увеличения
        cnt <= cnt + 1'b1;
    else if(state == COUNT1) // Для уменьшения
        cnt <= cnt - 1'b1;    
    else
        cnt <= 0;

//логика формирования выхода
assign Q = cnt;

endmodule

