module mult
#(
   parameter PAYLOAD_BITS = 8
)
(
   input  logic                           CLK_I, 
   input  logic                           RST_N_I, 
   input  logic                           LOAD_I,
   input  logic [PAYLOAD_BITS - 1    : 0] OPER_ONE_I, 
   input  logic [PAYLOAD_BITS - 1    : 0] OPER_TWO_I, 
   output logic [PAYLOAD_BITS * 2 -1 : 0] DATA_O 
   );

//Регистры для храниеня входных операндов
logic            [PAYLOAD_BITS - 1:0]       reg_oper_ONE;
logic            [PAYLOAD_BITS - 1:0]       reg_oper_TWO;

//Регистры для хранения произведений
logic            [ PAYLOAD_BITS - 1 : 0 ]   reg_s0;
logic            [ PAYLOAD_BITS     : 0 ]   reg_s1;
logic            [ PAYLOAD_BITS + 1 : 0 ]   reg_s2;
logic            [ PAYLOAD_BITS + 2 : 0 ]   reg_s3;
logic            [ PAYLOAD_BITS + 3 : 0 ]   reg_s4;
logic            [ PAYLOAD_BITS + 4 : 0 ]   reg_s5;
logic            [ PAYLOAD_BITS + 5 : 0 ]   reg_s6;
logic            [ PAYLOAD_BITS + 6 : 0 ]   reg_s7;

always_ff @(posedge CLK_I, negedge RST_N_I) begin
   if(!RST_N_I) begin                               // Реализация сброса
      DATA_O       <= 0;
	   reg_oper_ONE <= 0;
	   reg_oper_TWO <= 0; 
      reg_s0       <= 0;
      reg_s1       <= 0;
      reg_s2       <= 0;
      reg_s3       <= 0;
      reg_s4       <= 0; 
      reg_s5       <= 0;
      reg_s6       <= 0;
      reg_s7       <= 0;
   end
   else begin
      if(LOAD_I) begin                          // Загрузка входных операндов в регистры по приходу разрешающего сигнала
        reg_oper_ONE <= OPER_ONE_I;
        reg_oper_TWO <= OPER_TWO_I; 
      end
      else begin                             // Выполнение умножения
         reg_s0 <=  reg_oper_ONE[PAYLOAD_BITS-1:0] & {PAYLOAD_BITS{reg_oper_TWO[0]}};
         reg_s1 <= {reg_oper_ONE[PAYLOAD_BITS-1:0] & {PAYLOAD_BITS{reg_oper_TWO[1]}}, 1'b0};
         reg_s2 <= {reg_oper_ONE[PAYLOAD_BITS-1:0] & {PAYLOAD_BITS{reg_oper_TWO[2]}}, 2'b0};
         reg_s3 <= {reg_oper_ONE[PAYLOAD_BITS-1:0] & {PAYLOAD_BITS{reg_oper_TWO[3]}}, 3'b0};
         reg_s4 <= {reg_oper_ONE[PAYLOAD_BITS-1:0] & {PAYLOAD_BITS{reg_oper_TWO[4]}}, 4'b0}; 
         reg_s5 <= {reg_oper_ONE[PAYLOAD_BITS-1:0] & {PAYLOAD_BITS{reg_oper_TWO[5]}}, 5'b0}; 
         reg_s6 <= {reg_oper_ONE[PAYLOAD_BITS-1:0] & {PAYLOAD_BITS{reg_oper_TWO[6]}}, 6'b0}; 
         reg_s7 <= {reg_oper_ONE[PAYLOAD_BITS-1:0] & {PAYLOAD_BITS{reg_oper_TWO[7]}}, 7'b0}; 
         
         DATA_O <= reg_s0 + reg_s1 + reg_s2 + reg_s3 + reg_s4 + reg_s5 + reg_s6 + reg_s7; end
   end
end
	endmodule 