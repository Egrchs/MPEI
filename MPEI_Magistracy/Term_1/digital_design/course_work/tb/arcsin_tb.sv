`timescale 1ns/100ps

module arcsin_tb();

logic        CLK_I;
logic        RST_N_I;
logic [63:0] DATA_I;
logic [7 :0] DATA_O;

always #5 CLK_I = ~CLK_I;

arcsin DUT 
(
    .CLK_I   ( CLK_I   ),
    .RST_N_I ( RST_N_I ),
    .DATA_I  ( DATA_I  ),
    .DATA_O  ( DATA_O  )
);

initial begin
    CLK_I = 1;
    RST_N_I = 1;
    START_I = 1;
    DATA_I = 20'b00110110011101010011;
    #10 RST_N_I = 0;
    #10 RST_N_I = 1;    
end

initial begin
    $dumpfile("dump/wave.vcd");
    $dumpvars;
    #1000
    $finish();
 end   
endmodule
