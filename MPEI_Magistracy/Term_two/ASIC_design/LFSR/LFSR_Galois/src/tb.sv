`include "LFSR_Galois.sv"
module tb ();

    `define MAX_LEN     8

    logic                               clk     = 0;
    logic                               load    = 0;
    logic                               rst_n   = 0;
    logic [`MAX_LEN - 1 : 0]            seed    = 8'b11100111;
    logic [`MAX_LEN - 1 : 0]            poly    = 8'b10011001;
    logic [`MAX_LEN - 1 : 0]            data;

    logic [`MAX_LEN - 1 : 0]            calc_seq;
    logic                               new_bit;

    initial forever #5 clk <= ~clk;

    initial begin
        rst_n = 0;
        #10 
        rst_n = 1;
        #100;
        for (int j = 0; j < 20; j++) begin
            @(posedge clk);
            load <= 1;
            @(posedge clk);
            load <= 0;

            for (int i = 0; i < 80; i++) begin
                @(posedge clk);
                $display("SEED = %0b", seed);
                $display("POLY = %0b", poly);
                $display("DATA = %0b", data);
            end
        end
        #10us $finish;
    end

    LFSR_Galois #(
        .MAX_LEN( `MAX_LEN  )
    ) UUT (
        .CLK_I   ( clk       ),
        .RST_N_I ( rst_n     ),
        .EN_I    ( enable    ),
        .LOAD_I  ( load      ),
        .SEED_I  ( seed      ),
        .POLY_I  ( poly      ),
        .DATA_O  ( data      )
    );

    initial begin
        $dumpfile("../dump/wave.vcd");
        $dumpvars();
    end

endmodule