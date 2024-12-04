module LCD_TEST_4 
#( 
    parameter w_key
)
(
	input	logic			       iclk,
	input	logic		 	       irst,
    input   logic [        4 : 0 ] key,
    input   logic                  sw_state,
    input   logic                  sw_down,
    input   logic                  sw_up, 
	output	logic [        7 : 0 ] LCD_DATA,
	output	logic			       LCD_RW,
	output	logic			       LCD_RS,
	output	logic			       LCD_EN
);
    logic  [ 31  : 0 ] counter;
    logic  [ 3   : 0 ] state;
    logic  [ 3   : 0 ] cnt;
    logic  [ 7   : 0 ] data;
    logic  [ 7   : 0 ] symbol;
    logic  [ 3   : 0 ] state_reg;
    logic              rs_reg;

    assign LCD_RW = '0;

   always_ff@(posedge iclk or negedge irst)
	    begin
	    	if(!irst)
	    		begin
	    			counter <= 0;
	    			LCD_EN  <= 0;
	    		end 
	    	else	
	    		begin
	    			if(counter<3_750_000)
	    				counter<=counter+1;
	    			else 
	    				begin
	    					counter <= 0;
	    					LCD_EN  <= ~LCD_EN;
	    				end 
	    		end 
	    end 
    
    always_ff @(posedge LCD_EN or negedge irst)
        begin
            if(!irst)
                begin
                    state <=  '0;
                end 
            else	
                begin
                    case(state)
                        0:begin         // config display
                            state<=1;
                        end 
                        1:begin         // on display
                            state<=2;
                        end 
                        2:begin         // clear display
                            state<=4;
                        end
                        3:begin         // cursor
                            if(key[3])
                                state <= 4;
                            else
                                state <= 3;
                        end
                        4:begin         // cursor
                            if(key[1] || key[2])
                                state <= 3;
                            else
                                state <= 4;
                        end
                        default: state <= '0;
                        endcase
                end 
        end

    always_comb begin

        case (state)
            0 : begin 
                    LCD_RS   = '0;
                    LCD_DATA = 8'b00111100;
            end
            1 : begin
                    LCD_RS   = '0;
                    LCD_DATA = 8'b00001111;
            end
            2 : begin
                    LCD_RS   = '0;
                    LCD_DATA = 8'b00000001;
            end
            3 : begin
                    LCD_RS   = '0;
                    if(key[2]) begin
                        LCD_DATA   = 8'b00010100;
                    end
                    else if(key[1]) begin
                        LCD_DATA   = 8'b00010000;
                    end
                    else begin
                        LCD_DATA   = 8'b00000000;
                    end
            end
            4 : begin
                    if(key[3]) begin
                        LCD_RS   = '1;
                        LCD_DATA = symbol;
                    end
                    else begin
                        LCD_RS   = '0;
                        LCD_DATA = 8'b0;
                    end
            end

            default:  begin
                        LCD_RS   = '0;
                        LCD_DATA = 8'b00000000;
            end
        endcase
    end

    always_ff@(posedge LCD_EN or negedge irst) begin
        if(!irst) begin
            cnt <= '0;
        end
        else begin
            if(cnt == 9)
                cnt <= '0;
            else if (key[3])
                cnt <= cnt + 1'b1;
            else
                cnt <= cnt;
        end
    end

    always_comb begin
        case (cnt)
                 1 : symbol = "E";
                 2 : symbol = "G";
                 3 : symbol = "O";
                 4 : symbol = "R";
                 5 : symbol = "A";
                 6 : symbol = "N";
                 7 : symbol = "D";
                 8 : symbol = "R";
                 9 : symbol = "Y";
            default: symbol = " ";
        endcase
    end

endmodule