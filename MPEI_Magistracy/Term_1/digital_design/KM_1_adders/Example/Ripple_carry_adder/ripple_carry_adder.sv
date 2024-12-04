`include "f_adder.sv"
module ripple_carry_adder
# (
    parameter W = 8
)
(
    input                     carry_in,
    input  logic [W - 1 : 0]  A,
    input  logic [W - 1 : 0]  B,
    input  logic              CLK_i,
    input  logic              RST_N_I,
    output logic [W - 1 : 0]  S,
    output                    carry_out,
    output logic [W     : 0]  full_add
);
    logic  [W : 0] carry;

    logic [ W-1 : 0 ] A_ff;
    logic [ W-1 : 0 ] B_ff;
    logic             P_ff;
    logic             C_ff;
    logic [ W-1 : 0 ] S_ff;
    logic [ W-1 : 0 ] A_ff_w;
    logic [ W-1 : 0 ] B_ff_w;
    logic [ W   : 0 ] P_ff_w;
    logic [ W-1 : 0 ] S_ff_w;

    always_ff @(posedge CLK_i or negedge RST_N_I) begin
            if(!RST_N_I) begin
                A_ff <= 0;
                B_ff <= 0;
                P_ff <= 0;
                S_ff <= 0;
                C_ff <= 0;
            end
            else begin
                A_ff <= A;
                B_ff <= B;
                P_ff <= carry_in;
                S_ff <= S_ff_w;
                C_ff <= carry[W];
            end
        end

    assign carry[0]  = P_ff;
    assign A_ff_w    = A_ff;
    assign B_ff_w    = B_ff;
    assign S         = S_ff;
    assign carry_out = C_ff;
    generate
    genvar i;
        for (i = 0; i <= W - 1; i = i + 1) begin : stage
            f_adder 
            FA(
                .A (A_ff_w [i] ),
                .B (B_ff_w [i] ),
                .S (S_ff_w [i] ),
                .P (carry[i] ),
                .C(carry[i + 1])
            );
        end
    endgenerate

assign full_add = {carry_out, S};
endmodule