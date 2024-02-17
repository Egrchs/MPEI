module ALU (clk, res, A, B, out, select);

input      clk, res;                        // Системный такт и сброс
input    [1:0]  A;     
input    [1:0]  B;                        // Входные операнды
input    [3:0] select;                        // Выбор операции

output reg [3:0] out;                       // Результат

initial out = 0;                            // Убираем неопределенность на выходе

always @(posedge clk, negedge res)  
if (!res)   
    out = 0;    
else    
    case (select)   
        1:  out <= A + B;                   // Сложение
        2:  out <= A - B;                   // Вычитание А - В
        3:  out <= B - A;                   // Вычитание В - А
        4:  out <= A * B;                   // Умножение
        5:  out <= A & B;                   // Побитовое И
        6:  out <= A | B;                   // Побитовое ИЛИ
        7:  out <= A ^ B;                   // Исключающее ИЛИ
        8:  out <= A >> 1;                  // Логический сдвиг вправо A
        9:  out <= A << 1;                  // Логический сдвиг влево  A
        10: out <= B >> 1;                  // Логический сдвиг вправо B
        11: out <= B << 1;                  // Логический сдвиг влево  B
        12: out <= {1'b0, A[1:1]};          // Арифметичекий сдвиг вправо A
        13: out <= {1'b0, B[1:1]};          // Арифметичекий сдвиг вправо В      
        14: out <= (A == B) ? 1 : 0;        // Если А = В, то out = 1
        15: out <= (A > B) ? 1 : 0;         // Если А больше В, то out = 1
        default: out = A + B;
    endcase

endmodule



