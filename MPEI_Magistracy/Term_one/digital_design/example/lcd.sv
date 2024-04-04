module lcd
#(
    parameter PAYLOAD_BITS = 8
) 
(
    input  logic                             CLK_I,
    input  logic                             RST_N_I,
    input  logic [ PAYLOAD_BITS - 1 : 0 ]    LCD_DATA_I,
    output logic [ PAYLOAD_BITS - 1 : 0 ]    LCD_DATA_O,
    output logic                             LCD_RW_O,
    output logic                             LCD_EN_O,
    output logic                             LCD_RS_O
);

    logic  [ 31  : 0 ] counter;
    logic  [ 3   : 0 ] state;
    logic  [ 127 : 0 ] disp_data1;
    logic  [ 127 : 0 ] disp_data2;
    logic  [ 3   : 0 ] cnt;

    assign LCD_RW = '0;

    always_ff@(posedge CLK_I or negedge RST_N_I)
        begin
            if(!RST_N_I)
                begin
                    counter   <= 0;
                    LCD_EN_O  <= 0;
                end 
            else	
                begin
                    if(counter<6_750_000)
                        counter<=counter+1;
                    else 
                        begin
                            counter <= 0;
                            LCD_EN_O  <= ~LCD_EN_O;
                        end 
                end 
        end 

    always@(posedge LCD_EN_O or negedge RST_N_I)
        begin
            if(!RST_N_I)
                begin
                    state         <=  0;
                    LCD_RS_O      <=  0;
                    LCD_DATA_O    <=  0;
                    disp_data1    <=  "CLABA POCCII!!!!";
                    disp_data2    <=  "POCCII CLABA!!!!";
                end 
            else	
                begin
                    case(state)
                        0:begin         // config display
                            LCD_RS_O   <= 0;
                            LCD_DATA_O <= 8'b00111000;
                            state      <=1;
                        end 
                        1:begin         // on display
                            LCD_RS_O   <= 0;
                            LCD_DATA_O <= 8'b00001100;
                            state      <=2;
                        end 
                        2:begin         // clear display
                            LCD_RS_O   <= 0;
                            LCD_DATA_O <= 8'b00000001;
                            state<=3;
                        end
                        3:begin
                            LCD_RS_O   <= 0;
                            LCD_DATA_O <= 8'b00010100;
                            state      <= 4;
                        end
                        4:begin           // Addr for 1 line
                            LCD_RS_O   <= 0;
                            LCD_DATA_O <= 8'b10000000; 
                            state<=5;
                        end
                        5:begin
                            LCD_RS_O   <=1;
                            LCD_DATA_O <= disp_data1[127:120];
                            disp_data1 <= {disp_data1[119:0],disp_data1[127:120]};
                            cnt        <= cnt+1;
                            if(cnt==15)
                                begin
                                    state<=6;
                                    cnt<=0;
                                end 
                        end
                        6:begin            // Addr for 2 line
                            LCD_RS_O   <= 0;
                            LCD_DATA_O <= 8'b1100_0000;
                            state      <= 7;
                        end
                        7:begin
                            LCD_RS_O    <=1;
                            LCD_DATA_O  <= disp_data2[127:120];
                            disp_data2  <= {disp_data2[119:0],disp_data2[127:120]};
                            cnt<=cnt+1;
                            if(cnt==15)
                                begin
                                    state<=8;
                                    cnt<=0;
                                end 
                        end
                        8:begin          // Shifter
                            LCD_RS_O   <= 0;
                            LCD_DATA_O <= 8'b00011000;
    //                            state<=;
                        end
                        default: state <= 0;
                        endcase
                end 
        end 

endmodule