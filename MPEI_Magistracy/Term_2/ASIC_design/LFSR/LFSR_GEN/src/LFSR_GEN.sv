`include "LFSR_Fibonacci.sv"

module LFSR_Gen 
#(
    parameter MAX_LEN = 8
) 
(
    input   logic                             CLK_I,
    input   logic                             RST_N_I,
    input   logic                             LOAD_I,
    input   logic                             EN_I,
    input   logic [MAX_LEN         - 1 : 0]   SEED_ONE_I,
    input   logic [MAX_LEN         - 1 : 0]   SEED_TWO_I,
    input   logic [$clog2(MAX_LEN) - 1 : 0]   SHIFT_I,
    input   logic [MAX_LEN             : 0]   POLY_ONE_I,
    input   logic [MAX_LEN             : 0]   POLY_TWO_I,
    input   logic [$clog2(MAX_LEN) - 1 : 0]   LEN_I,

    output  logic [MAX_LEN         - 1 : 0]   DATA_O
);
    logic [MAX_LEN - 1 : 0]                   lfsr_one_w;
    logic [MAX_LEN - 1 : 0]                   lfsr_two_w;
    logic [MAX_LEN - 1 : 0]                   lfsr_three_w;

    LFSR_Fibonacci
    #(
        .MAX_LEN(MAX_LEN) 
    ) 
    LFSR_Fibonacci_one 
    (
        .CLK_I   ( CLK_I      ),
        .EN_I    ( EN_I       ),
        .LOAD_I  ( LOAD_I     ),
        .SEED_I  ( SEED_ONE_I ),
        .SHIFT_I ( SHIFT_I    ),
        .POLY_I  ( POLY_ONE_I ),
        .LEN_I   ( LEN_I      ),   
        .DATA_O  ( lfsr_one_w )
    );

    LFSR_Fibonacci
    #(
        .MAX_LEN(MAX_LEN) 
    ) 
    LFSR_Fibonacci_two 
    (
        .CLK_I   ( CLK_I      ),
        .EN_I    ( EN_I       ),
        .LOAD_I  ( LOAD_I     ),
        .SEED_I  ( SEED_TWO_I ),
        .SHIFT_I ( SHIFT_I    ),
        .POLY_I  ( POLY_TWO_I ),
        .LEN_I   ( LEN_I      ),   
        .DATA_O  ( lfsr_two_w )
    );

    LFSR_Fibonacci
    #(
        .MAX_LEN(MAX_LEN) 
    ) 
    LFSR_Fibonacci_tree 
    (
        .CLK_I   ( CLK_I        ),
        .EN_I    ( EN_I         ),
        .LOAD_I  ( LOAD_I       ),
        .SEED_I  ( SEED_TWO_I   ),
        .SHIFT_I ( SHIFT_I      ),
        .POLY_I  ( POLY_ONE_I   ),
        .LEN_I   ( LEN_I        ),   
        .DATA_O  ( lfsr_three_w )
    );

    always_ff @(posedge CLK_I, negedge RST_N_I) begin
        if(!RST_N_I) begin
            DATA_O <= '0;
        end
        else begin
            case (lfsr_three_w[0])
                1'b0 : begin
                    DATA_O <= lfsr_one_w;
                end
                1'b1 : begin
                    DATA_O <= lfsr_two_w;
                end
                default: begin
                    DATA_O <= '0;
                end
            endcase
        end
    end
    
endmodule