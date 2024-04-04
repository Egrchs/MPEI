`include "LFSR_GEN.sv"
module tb ();

    `define MAX_LEN     16

    logic                               clk      = 0;
    logic                               en       = 0;
    logic                               load     = 0;
    logic [`MAX_LEN - 1 : 0]            seed_one = 13;
    logic [`MAX_LEN - 1 : 0]            seed_two = 25;
    logic [$clog2(`MAX_LEN) - 1 : 0]    shift    = 0;
    logic [`MAX_LEN : 0]                poly_one = 15'h7005;
    logic [`MAX_LEN : 0]                poly_two = 15'h7135;
    logic [$clog2(`MAX_LEN) - 1 : 0]    len      = 13;
    logic [`MAX_LEN - 1 : 0]            data;

    logic [`MAX_LEN - 1 : 0]            calc_seq;
    logic                               new_bit;

    initial forever #5 clk <= ~clk;

    initial begin
        #100;
        for (int j = 0; j < 20; j++) begin
            @(posedge clk);
            load <= 1;
            @(posedge clk);
            load <= 0;
            @(posedge clk);
            load <= 1;
            en <= 1;
            @(posedge clk);
            load <= 0;

            for (int i = 0; i < 80; i++) begin
                @(posedge clk);
            end
            en <= 0;
            #1;
            shift++;

        end
        #10us;
        $display(">>>>> SUCCESS");
        $finish;
    end

    LFSR_Gen #(
        .MAX_LEN( `MAX_LEN  )
    ) UUT (
        .CLK_I      ( clk       ),
        .EN_I       ( en        ),
        .LOAD_I     ( load      ),
        .SEED_ONE_I ( seed_one  ),
        .SEED_TWO_I ( seed_two  ),
        .SHIFT_I    ( shift     ),
        .POLY_ONE_I ( poly_one  ),
        .POLY_TWO_I ( poly_two  ),
        .LEN_I      ( len       ),
        .DATA_O     ( data      )
    );

    initial begin
        $dumpfile("../dump/wave.vcd");
        $dumpvars();
    end

endmodule