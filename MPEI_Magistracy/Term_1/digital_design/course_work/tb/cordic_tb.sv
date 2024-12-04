`timescale 1ns/100ps

module cordic_tb();


logic signed [19:0] cos_z0;
logic signed [19:0] sin_z0;
logic done;
logic signed [19:0] z0;
logic start;
logic CLK_I;
logic RST_N_I;

always #5 CLK_I = ~CLK_I;

cordic 
#(
    
)
DUT 
(
    .CLK_I   ( CLK_I   ),
    .RST_N_I ( RST_N_I ),
    .READY_I ( start   ),
    .DONE_O  ( done    ),
    .COS_O   ( cos_z0  ),
    .SIN_O   ( sin_z0  ),
    .Z0_I    ( z0      )
);

initial begin
    CLK_I = 1;
    RST_N_I = 1;
    start = 1;
    z0 = 20'b0010_0001_0111_1000_1101; //30 град в радианах
    // z0 = 20'b01000011000000100001; //60 град в радианах
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
