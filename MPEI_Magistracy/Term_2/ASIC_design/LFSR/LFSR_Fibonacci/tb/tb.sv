`include "LFSR_Fibonacci.sv"
module tb ();

    `define MAX_LEN     16

    logic                               clk     = 0;
    logic                               en      = 0;
    logic                               load    = 0;
    logic [`MAX_LEN - 1 : 0]            seed    = 1;
    logic [$clog2(`MAX_LEN) - 1 : 0]    shift   = 0;
    logic [`MAX_LEN : 0]                poly    = 15'h7005;
    logic [$clog2(`MAX_LEN) - 1 : 0]    len     = 13;
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

    initial begin
        forever begin
            @(posedge clk);
            if (load) begin
                calc_seq = seed;
            end
            if (en && ~ load) begin
                for (int j = 0; j <= shift; j++) begin
                    new_bit = calc_seq[len];
                    for (int i = 1; i < len + 1; i++) begin
                        if (poly[i]) begin
                            new_bit = new_bit ^ calc_seq[i - 1];
                        end
                    end
                    calc_seq = {calc_seq[`MAX_LEN - 2 : 0], new_bit};
                end
                if (calc_seq != data) begin
                    $display("Error %h != %h", calc_seq, data);
                    $display(">>>>> FAIL");
                    $finish;
                end
            end
        end
    end

    LFSR_Fibonacci #(
        .MAX_LEN( `MAX_LEN  )
    ) UUT (
        .CLK_I  ( clk       ),
        .EN_I   ( en        ),
        .LOAD_I ( load      ),
        .SEED_I ( seed      ),
        .SHIFT_I( shift     ),
        .POLY_I ( poly      ),
        .LEN_I  ( len       ),
        .DATA_O ( data      )
    );

    initial begin
        $dumpfile("../dump/wave.vcd");
        $dumpvars();
    end

endmodule