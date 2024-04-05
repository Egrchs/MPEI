module top  
(
    input  logic  clk,
    input  logic  rst,
    input  logic  bit_in,
    output logic  bit_out
);

    logic a1;
    logic a2;

    assign bit_out = a2;

    scrambler 
    scrambler_inst
    (
        .clk     (clk   ),
        .rst     (rst   ),
        .bit_in  (bit_in),
        .bit_out (a1    )
    );

    descrambler
    descrambler_inst
    (
        .clk    (clk),
        .rst    (rst),
        .bit_in (a1 ),
        .bit_out(a2 )
    );

endmodule