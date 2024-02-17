module LCD_TEST_4 
#( 
    parameter w_key
)
(
	input	logic			      iclk,
	input	logic		 	      irst,
    input   logic [ w_key - 1:0 ] key,
	output	logic [         7:0 ] LCD_DATA,
	output	logic			      LCD_RW,
	// output	logic			LCD_EN,
	output	logic			      LCD_RS,
	output	logic			      LCD_EN
);
    logic  [ 31  : 0 ] counter;
    logic  [ 3   : 0 ] state;
    logic  [ 127 : 0 ] disp_data1;
    logic  [ 127 : 0 ] disp_data2;
    logic  [ 3   : 0 ] cnt;

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
	    			if(counter<6_750_000)
	    				counter<=counter+1;
	    			else 
	    				begin
	    					counter <= 0;
	    					LCD_EN  <= ~LCD_EN;
	    				end 
	    		end 
	    end 
    
    always@(posedge LCD_EN or negedge irst)
        begin
            if(!irst)
                begin
                    state       <=  0;
                    LCD_RS      <=  0;
                    LCD_DATA    <=  0;
                end 
            else	
                begin
                    case(state)
                        0:begin         // config display
                            LCD_RS   <= 0;
                            LCD_DATA <= 8'b00111000;
                            state<=1;
                        end 
                        1:begin         // on display
                            LCD_RS   <= 0;
                            LCD_DATA <= 8'b00001111;
                            state<=2;
                        end 
                        2:begin         // clear display
                            LCD_RS   <= 0;
                            LCD_DATA <= 8'b00000001;
                            state<=3;
                        end
                        3:begin         // clear display
                            LCD_RS   <= 0;
                            if(key[0]) begin
                                LCD_DATA <= 8'b00010100;
                            end
                            else if(key[1])
                                LCD_DATA <= 8'b00010000;
//                            state<=3;
                        end
                        default: state <= 0;
                        endcase
                end 
        end 

endmodule