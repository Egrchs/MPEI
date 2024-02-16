`include "ROM_8x8.sv"
`timescale 1 ns / 1 ns

module ROM_8x8_tb
#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8 
);

    logic                        CLK_I; 
    logic                        RE_I;

    logic [ ADDR_WIDTH - 1 : 0 ] ADDR_I;
    logic [ DATA_WIDTH - 1 : 0 ] DATA_O;
    logic [ ADDR_WIDTH - 1 : 0 ] ADDR_O;

    ROM_8x8
    #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) 
    DUT 
    (
        .ADDR_I ( ADDR_I ),
        .CLK_I  ( CLK_I  ),
        .RE_I   ( RE_I   ),
        .ADDR_O ( ADDR_O ),
        .DATA_O ( DATA_O )
    );

    initial begin
        $display("Running testbench");
        CLK_I = 0;
        RE_I  = 0;
    end

    always #10  CLK_I =  !CLK_I; 

    initial begin
        RE_I = 0;
        #50
        RE_I = 1;
        #150
        RE_I = 0;
        #100
        RE_I = 1;
    end  

    initial begin
        for (int i = 0; i <= (ADDR_WIDTH * DATA_WIDTH); i++) begin
            ADDR_I = $urandom_range(0, 2**DATA_WIDTH - 1);
            #30;                     
        end
    end

    initial begin
        #500 $display("Testbench is OK!");
        $finish;
    end

    initial begin
        $dumpfile("ROM_8x8.vcd");
        $dumpvars;
    end

endmodule