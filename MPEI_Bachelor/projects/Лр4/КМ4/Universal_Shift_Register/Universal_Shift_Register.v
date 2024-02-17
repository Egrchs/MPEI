module Universal_Shift_Register #(parameter WIDTH = 5) // параметр позволяет быстро менять разрядность входного числа
                                (clk, res, D, out_state, Load, M, enable);

localparam parall_out = 1, logic_shft_left = 2, logic_shft_right = 3, ring_shft_left = 4, ring_shft_right = 5, serial_out  = 6;

input [WIDTH:0] D; //Входное число
input     [2:0] Load; //Выбор действия
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
    		begin
    		    if(Load == 1)
                    begin
						Q = D; //Параллельный вывод
                        next_state = logic_shft_left;
    				end
				else next_state = parall_out;
    		end
        logic_shft_left:
    		begin
    		    if(Load == 2)
                    begin
                        Q = D << M; //Логический сдвиг влево на М разрадов
                        next_state = logic_shft_right;
    				end
				else next_state = logic_shft_left;
    		end
    	logic_shft_right:
    		begin
    		    if(Load == 3)
    				begin
    	                Q = D >> M; //Логический сдвиг вправо на М разрадов
                        next_state = ring_shft_left;
    			    end
				else next_state = logic_shft_right;
    		end 
        ring_shft_left:
    		begin
    		    if(Load == 4)
                    begin
                        Q = {D[WIDTH-2:0], D[WIDTH-1]}; // Кольцевой сдвиг влево 
                        next_state = ring_shft_right;
    				end
				else next_state = ring_shft_left;
    		end
    	ring_shft_right:
    		begin
    		    if(Load == 5)
    				begin
    	                Q = {D[0], D[WIDTH-1:1]}; // Кольцевой сдвиг вправо 
                        next_state = serial_out;
    			    end
				else next_state = ring_shft_right;
    		end    
		serial_out:
    		begin
    		    if(Load == 6) // Последовательный вывод
    				begin
						next_state = serial_out;
						Q = qQ[0];
    			    end
				else next_state = parall_out;
    		end
		default : next_state = parall_out;
	endcase

reg [WIDTH:0]qQ;

// Логика для последовательного вывода
always @ (posedge clk, negedge res) // По приходу тактового импульса, в выходную переменную будет записываться [0] разряд входного числа
	if (!res)
    	qQ <= 0;
    else if ((Load == serial_out) && (enable == 1)) 	// enable служит для разрешения записи входного числа в промежуточную REG переменную qQ
		qQ <= D;  
	else if ((Load == serial_out) && (enable == 0)) 
		begin
			qQ <= {qQ[0], qQ[WIDTH:1]}; // Сдвигаем входное число вправо для передачи следующего разряда
		end


// Логика для реализации передачи результата
assign out_state = Q;

endmodule