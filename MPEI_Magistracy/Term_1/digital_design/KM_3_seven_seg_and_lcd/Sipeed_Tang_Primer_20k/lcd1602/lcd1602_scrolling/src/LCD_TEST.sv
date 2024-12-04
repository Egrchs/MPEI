module LCD_TEST 
(
	input	logic			iclk,
	input	logic			irst,
	output	logic	[7:0]	LCD_DATA,
	output	logic			LCD_RW,
	output	logic			LCD_RS,
	output	logic			LCD_EN
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
                    disp_data1  <=  "CLABA POCCII!!!!";
                    disp_data2  <=  "POCCII CLABA!!!!";
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
                            LCD_DATA <= 8'b00001100;
                            state<=2;
                        end 
                        2:begin         // clear display
                            LCD_RS   <= 0;
                            LCD_DATA <= 8'b00000001;
                            state<=3;
                        end
                        3:begin
                            LCD_RS   <= 0;
                            LCD_DATA <= 8'b00010100;
                            state<=4;
                        end
                        4:begin           // Addr for 1 line
                            LCD_RS   <= 0;
                            LCD_DATA <= 8'b10000000; 
                            state<=5;
                        end
                        5:begin
                            LCD_RS<=1;
                            LCD_DATA   <= disp_data1[127:120];
                            disp_data1 <= {disp_data1[119:0],disp_data1[127:120]};
                            cnt<=cnt+1;
                            if(cnt==15)
                                begin
                                    state<=6;
                                    cnt<=0;
                                end 
                        end
				    	6:begin            // Addr for 2 line
				    		LCD_RS<=0;
				    		LCD_DATA<=8'b1100_0000;
				    		state<=7;
				    	end
				    	7:begin
				    		LCD_RS<=1;
				    		LCD_DATA   <= disp_data2[127:120];
				    		disp_data2 <= {disp_data2[119:0],disp_data2[127:120]};
				    		cnt<=cnt+1;
				    		if(cnt==15)
				    			begin
				    				state<=8;
				    				cnt<=0;
				    			end 
				    	end
                        8:begin          // Shifter
                            LCD_RS   <= 0;
                            LCD_DATA <= 8'b00011000;
//                            state<=;
                        end
                        default: state <= 0;
                        endcase
                end 
        end 

endmodule