module top_module  (
    input CLK, res_btn, 
    input [1:0] KEY_A, KEY_B,                                  //переключатели для ввода числа
    input [3:0] select,                                        //кнопки для выбора исполняемой команды

    output LED1, LED2, LED3, LED4,                             //индикация входных чисел
    output DIG1, DIG2, DIG3, DIG4,                             //выбор анода семисегментного индикатора
    output SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6            //сегменты индикатора
);

//Логика для светодиодов
wire [3:0] led;

assign led[3] = (KEY_A [0] == 1'b1) ? 1 : 0;

assign led[2] = (KEY_A [1] == 1'b1) ? 1 : 0;

assign led[1] = (KEY_B [0] == 1'b1) ? 1 : 0;

assign led[0] = (KEY_B [1] == 1'b1) ? 1 : 0;

assign {LED4, LED3, LED2, LED1} = ~led;

//Выбор команды
assign {S1, S2, S3, S4} = ~select;


//Входное число
wire [3:0] Z;

wire [3:0] anodes;
assign {DIG1, DIG2, DIG3, DIG4} = ~anodes;

wire [6:0] segments;
assign {SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6} = segments;

clk_div               clk_div (.clk_50MHz(CLK), .clk2(clk2));

seven_seg_disp seven_seg_disp (.clk(clk2), .anodes(anodes), .segments(segments), .res(res_btn), .data(Z));

ALU                     ALU   (.out(Z),.clk(CLK), .res(res_btn), .A(KEY_A), .B(KEY_B), .select(select));    
endmodule