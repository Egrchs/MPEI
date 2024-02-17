module paramreg #(parameter WIDTH = 12)
                 (clk, L, E, D, Q);

input clk;
input L;
input E;
input [WIDTH-1:0] D;
output reg [WIDTH-1:0] Q;

initial
 Q <= 0;
 
always @(posedge clk) 
  
if (!L)    // загрузка
      Q <= D;
	  
else if (E)  // Сдвиг вправо
      Q <= {Q[0], Q[WIDTH-1:1]};
	  
else if (!E)  // Сдвиг влево
      Q <= {Q[WIDTH-2:0], Q[WIDTH-1]};

endmodule