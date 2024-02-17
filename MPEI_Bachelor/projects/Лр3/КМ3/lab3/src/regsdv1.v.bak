module regsdv1 #(parameter WIDTH = 32)
                 (clk, L, E, D, D1, Q, Q1,M,res);

input clk, res;
input L;
input [1:0] E;
input [WIDTH-1:0] D;
input signed [WIDTH-1:0] D1; //для передачи отрицательного числа
input [WIDTH-1:0] M;

output reg [WIDTH-1:0] Q;
output reg signed  [WIDTH-1:0] Q1; //знакозависимый порт выхода

initial begin
Q <= 0;
Q1 <= 0; end
 
always @(posedge clk, negedge res)
if (!res) begin 
      Q <= 0;
	  Q1 <= 0; end
else if (L) begin       // загрузка 
      Q <= D;
	  Q1 <= D1; end
else if (E==0)          // Сдвиг вправо
      Q <= Q >> M;
else if (E==1)          // Сдвиг влево
      Q <= Q << M;
else if (E==2)
        Q1 <= Q1 >>> M; //операторы

	//Q1 <={{22{Q1[WIDTH-1]}},Q1[WIDTH-1:22]}; //послед. логика	
endmodule



	 