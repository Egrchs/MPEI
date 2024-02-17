`include "RAM_32x8.sv"
`timescale 1 ns / 1 ns
module RAM_32x_8_tb
#(
    parameter WIDTH = 32,
    parameter DEPTH = 8 
);

    logic clk, We;

    logic [(DEPTH)-1:0] Addr;
    logic [WIDTH-1:0] Datain;
    logic [WIDTH-1:0] Dataout;
    
    RAM_32x8 
    #(
        .WIDTH(32),
        .DEPTH(8)
    ) 
    DUT 
    (
        .Addr(Addr),
        .clk(clk),
        .We(We),
        .Datain(Datain),
        .Dataout(Dataout)
    );
    
    initial begin
        $display("Running testbench");
        clk = 0;
        We   = 0;
    end

    always #10  clk =  !clk; 

    initial begin
        We = 0;
        #500;
        We = 1;
        #500;
        We = 0;
        #500;
    end  

    initial begin
        for (int i = 0; i <= 15; i++) begin
          Datain = $urandom_range(0, 2**WIDTH-1);
          #100;                     
        end
    end

    initial begin
        Addr = 34;
        #100;
        Addr = 105;
        #100;
        Addr = 20;
        #100;
        Addr = 227;
        #100;
        Addr = 79;
        #100;
         Addr = 34;
        #100;
        Addr = 105;
        #100;
        Addr = 20;
        #100;
        Addr = 227;
        #100;
        Addr = 79;
        #100;
         Addr = 34;
        #100;
        Addr = 105;
        #100;
        Addr = 20;
        #100;
        Addr = 227;
        #100;
        Addr = 79;
        #100;
    end  

    initial begin
        #1520 $display("Testbench is OK!");
        $finish;
    end

    initial begin
        $dumpfile("RAM_32x8.vcd");
        $dumpvars;
    end

endmodule