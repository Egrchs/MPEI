module register(clk, res, set, D, outstate, M);

input     clk, res; 
input [2:0]    set;
input [15:0]     D; // Ввод начального значения
input [3:0]      M;

reg [15:0]   Q; // Результат
output  [15:0] outstate;

localparam LOAD = 0, LOG_RIGHT = 1, LOG_LEFT = 2, ARIF_RIGHT = 3, ARIF_LEFT = 4;

reg [2:0] state, nextstate;

//логика переключений
always @(posedge clk, negedge res)
    if(!res)
        state <= LOAD;
    else
        state <= nextstate;

//логика работы автомата
always @(*)
    case(state)
        LOAD:  
            if (set == 0) begin
				   Q = D;
					nextstate = LOAD; end
            else                                // Выбор действия в начальном состоянии
                case(set)
                    1: nextstate = LOG_RIGHT;
                    2: nextstate = LOG_LEFT;
                    3: nextstate = ARIF_RIGHT;
                    4: nextstate = ARIF_LEFT;
                    default : nextstate = LOAD;
            endcase
        LOG_RIGHT: 
            if (set == 1) begin
                Q = D >> M;
					 nextstate = LOG_RIGHT; end
            else 
                case(set)
                    0: nextstate = LOAD;
                    2: nextstate = LOG_LEFT;
                    3: nextstate = ARIF_RIGHT;
                    4: nextstate = ARIF_LEFT;
                    default : nextstate = LOG_RIGHT;
                endcase            
        LOG_LEFT:  
            if (set == 2) begin
                Q = D << M;
					 nextstate = LOG_LEFT; end
            else 
                case(set)
                    0: nextstate = LOAD;
                    1: nextstate = LOG_RIGHT;
                    3: nextstate = ARIF_RIGHT;
                    4: nextstate = ARIF_LEFT;
                    default : nextstate = LOG_LEFT;
                endcase            
        ARIF_RIGHT:
            if (set == 3) begin
                Q = D >>> M;
					 nextstate = ARIF_RIGHT; end
            else 
                case(set)
                    0: nextstate = LOAD;
                    1: nextstate = LOG_RIGHT;
                    2: nextstate = LOG_LEFT;
                    4: nextstate = ARIF_LEFT;
                    default : nextstate = ARIF_RIGHT;
                endcase      
        ARIF_LEFT:
            if (set == 4) begin
                Q = D <<< M;
					 					 nextstate = ARIF_LEFT; end
            else 
                case(set)
                    0: nextstate = LOAD;
                    1: nextstate = LOG_RIGHT;
                    2: nextstate = LOG_LEFT;
                    3: nextstate = ARIF_RIGHT;
                    default : nextstate = ARIF_LEFT;
                endcase                           
        default : nextstate = LOAD;
    endcase

//логика формирования выхода
assign outstate = Q;

endmodule

