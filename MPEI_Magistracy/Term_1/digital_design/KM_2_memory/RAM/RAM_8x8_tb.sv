`include "RAM_8x8.sv"
`timescale 1 ns / 1 ns
module RAM_32x_8_tb
#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8 
);

    logic                        CLK_I;
    logic                        WE_I;
    logic [ ADDR_WIDTH - 1 : 0 ] ADDR_I;
    logic [ DATA_WIDTH - 1 : 0 ] DATA_I;
    logic [ DATA_WIDTH - 1 : 0 ] DATA_O;
    logic [ ADDR_WIDTH - 1 : 0 ] ADDR_O;
    
    RAM_8x8 
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) 
    DUT 
    (
        .ADDR_I  (  ADDR_I ),
        .CLK_I   (  CLK_I  ),
        .WE_I    (  WE_I   ),
        .DATA_I  (  DATA_I ),
        .DATA_O  (  DATA_O )
    );
    
    initial begin
        $display("Running testbench");
        CLK_I  = 0;
        WE_I   = 0;
    end

    always #10  CLK_I =  !CLK_I; 

    initial begin
        WE_I = 0;
        #500;
        WE_I = 1;
        #500;
        WE_I = 0;
        #500;
    end  

    initial begin
        for (int i = 0; i <= DATA_WIDTH; i++) begin
          DATA_I = $urandom_range(0, 2**DATA_WIDTH - 1);
          #100;                     
        end
    end

    initial begin
        ADDR_I = 34;
        #100;
        ADDR_I = 105;
        #100;
        ADDR_I = 20;
        #100;
        ADDR_I = 227;
        #100;
        ADDR_I = 79;
        #100;
         ADDR_I = 34;
        #100;
        ADDR_I = 105;
        #100;
        ADDR_I = 20;
        #100;
        ADDR_I = 227;
        #100;
        ADDR_I = 79;
        #100;
         ADDR_I = 34;
        #100;
        ADDR_I = 105;
        #100;
        ADDR_I = 20;
        #100;
        ADDR_I = 227;
        #100;
        ADDR_I = 79;
        #100;
    end  

    initial begin
        #1520 $display("Testbench is OK!");
        $finish;
    end

    initial begin
        $dumpfile("RAM_8x8.vcd");
        $dumpvars;
    end

endmodule