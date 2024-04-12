module top  
(
    input  logic  CLK_I,
    input  logic  RST_N_I,
    input  logic  BIT_I,
    output logic  BIT_O
);

    logic a1;
    logic a2;

    assign BIT_O = a2;

    scrambler 
    scrambler_inst
    (
        .CLK_I     (CLK_I   ),
        .RST_N_I   (RST_N_I ),
        .BIT_I     (BIT_I   ),
        .BIT_O     (a1      )
    );

    scrambler 
    descrambler_inst
    (
        .CLK_I    (CLK_I   ),
        .RST_N_I  (RST_N_I ),
        .BIT_I    (a1      ),
        .BIT_O    (a2      )
    );

endmodule