module traffic_light(clk, res, out_state);

input clk, res;
output [1:0] out_state;

localparam RED = 0, YELLOW1 = 1, GREEN = 2, YELLOW2 = 3;

reg [1:0] state, next_state;
reg [63:0] txstate;

always @(state)
	case (state)
		RED     : txstate = "RED";
		YELLOW1 : txstate = "YELLOW";
		GREEN   : txstate = "GREEN";
		YELLOW2 : txstate = "YELLOW2";
	endcase

wire [5:0] timer_second;
reg  timer_second_reset;

timer one_second(.clk_50MHz(clk), .res(res), .Load(timer_second_reset), .cnt2(timer_second)); //Подключаем таймер
   	
always @(*) //Логика автомата
begin
    case (state)
        RED:
    		begin
				timer_second_reset = 1;
    		    if (timer_second == 40)

                    begin
    				    timer_second_reset = 0;
    				    next_state = YELLOW1;
    				end
				 else next_state = RED;
    		end
    	YELLOW1:
    		begin
				timer_second_reset = 1;
    		    if (timer_second == 3)
    				begin
    	                timer_second_reset = 0;
    				    next_state = GREEN;
    			    end
					else next_state = YELLOW1;
    		end
    	GREEN:
    		begin
				timer_second_reset = 1;
    		    if (timer_second == 21)
    	  			begin
    			  		timer_second_reset = 0;
    				    next_state = YELLOW2;
    				end
				 else next_state = GREEN;  	 
    		end
    	YELLOW2:
    		begin
				timer_second_reset = 1;
    		    if (timer_second == 3)
    				begin
    	                timer_second_reset = 0;
    				    next_state = RED;
    			    end
				  else next_state = YELLOW2;
    		end		
		default : next_state = RED;
	endcase
end

always @(posedge clk, negedge res) 
begin
if (!res)
 	state <= RED;
else
	state <= next_state;
end

assign out_state = state;

endmodule