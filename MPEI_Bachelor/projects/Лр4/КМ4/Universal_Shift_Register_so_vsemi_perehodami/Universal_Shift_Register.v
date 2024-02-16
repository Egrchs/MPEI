module Universal_Shift_Register #(parameter WIDTH = 15) // параметр позволяет быстро менять разрядность входного числа
                                (clk, res, D, out_state, set, M, enable);

localparam parall_out = 1, logic_shft_left = 2, logic_shft_right = 3, ring_shft_left = 4, ring_shft_right = 5, serial_out  = 6;

input [WIDTH:0] D; //Входное число
input     [2:0] set; //Выбор действия
input       res, clk;
input    [WIDTH:0] M; //Количество сдвигаемых разрядов
input enable;

reg [WIDTH:0] Q; //Результат 
reg [2:0] state, next_state;

output [WIDTH:0] out_state; 

always @(posedge clk, negedge res) 
begin
  if (!res)
    state <= parall_out;
  else
    state <= next_state;
end

always @(*) //Логика автомата
    case (state)
        parall_out:  
            if (set == 1) 
				begin
				   Q = D;
					next_state = parall_out; 
				end
            else                                // Выбор действия в начальном состоянии
                case(set)
                    2: next_state = logic_shft_left;
                    3: next_state = logic_shft_right;
                    4: next_state = ring_shft_left;
                    5: next_state = ring_shft_right;
					6: next_state = serial_out;
                    default : next_state = parall_out;
            endcase
        logic_shft_left:
            if (set == 2) 
				begin
				    Q = D << M; //Логический сдвиг влево на М разрадов
					next_state = logic_shft_left; 
				end
            else                                // Выбор действия в начальном состоянии
                case(set)
                    1: next_state = parall_out;
                    3: next_state = logic_shft_right;
                    4: next_state = ring_shft_left;
                    5: next_state = ring_shft_right;
					6: next_state = serial_out;
                    default : next_state = parall_out;
				endcase
    	logic_shft_right:
    		if(set == 3)
    			begin
    	            Q = D >> M; //Логический сдвиг вправо на М разрадов
                    next_state = ring_shft_right;
    		    end
			else
                case(set)
                    1: next_state = parall_out;
					2: next_state = logic_shft_left;
                    4: next_state = ring_shft_left;
                    5: next_state = ring_shft_right;
					6: next_state = serial_out;
                    default : next_state = parall_out;
				endcase
        ring_shft_left:
    		if(set == 4)
                begin
                    Q = {D[WIDTH-2:0], D[WIDTH-1]}; // Кольцевой сдвиг влево 
                    next_state = ring_shft_left;
    			end
			else
				case(set)
                    1: next_state = parall_out;
					2: next_state = logic_shft_left;
                    3: next_state = logic_shft_right;
                    5: next_state = ring_shft_right;
					6: next_state = serial_out;
                    default : next_state = parall_out;
				endcase
    	ring_shft_right:
    		if(set == 5)
    				begin
    	                Q = {D[0], D[WIDTH-1:1]}; // Кольцевой сдвиг вправо 
                        next_state = ring_shft_right;
    			    end
			else	
				case(set)
                    1: next_state = parall_out;
					2: next_state = logic_shft_left;
                    3: next_state = logic_shft_right;
                    4: next_state = ring_shft_left;
					6: next_state = serial_out;
                    default : next_state = parall_out;
				endcase 
		serial_out:
    		if(set == 6) // Последовательный вывод
    				begin
						next_state = serial_out;
						Q = qQ[0];
    			    end
			else 
			    case(set)
                    1: next_state = parall_out;
					2: next_state = logic_shft_left;
                    3: next_state = logic_shft_right;
                    4: next_state = ring_shft_left;
                    5: next_state = ring_shft_right;
                    default : next_state = parall_out;
				endcase
		default : next_state = parall_out;
	endcase

reg [WIDTH:0]qQ;

// Логика для последовательного вывода
always @ (posedge clk, negedge res) // По приходу тактового импульса, в выходную переменную будет записываться [0] разряд входного числа
	if (!res)
    	qQ <= 0;
    else if ((set == serial_out) && (enable == 1)) 	// enable служит для разрешения записи входного числа в промежуточную REG переменную qQ
		qQ <= D;  
	else if ((set == serial_out) && (enable == 0)) 
		begin
			qQ <= {qQ[0], qQ[WIDTH:1]}; // Сдвигаем входное число вправо для передачи следующего разряда
		end

// Логика для реализации передачи результата
assign out_state = Q;

endmodule