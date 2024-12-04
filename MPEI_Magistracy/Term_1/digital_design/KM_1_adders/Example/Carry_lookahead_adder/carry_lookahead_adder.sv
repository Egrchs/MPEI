`include "carry_lookahead_generator.sv"
module carry_lookahead_adder
    #(
        parameter WIDTH = 8
    )
    (
        input  logic                 C_i,
        input  logic [WIDTH-1 : 0]   A,
        input  logic [WIDTH-1 : 0]   B,
        output logic [WIDTH-1 : 0]   S,
        output logic                 C_o
    );

    logic [ WIDTH   : 0 ] carry;
    logic [ WIDTH-1 : 0 ] g_wire, p_wire;

    carry_lookahead_generator 
    #(
        .WIDTH(WIDTH)
    )
    UUT(
        .carry_in(C_i),
        .gen_in(g_wire),
        .prop_in(p_wire),
        .carry(carry),
        .group_gen(),
        .group_prop()
    );
    
    generate
        genvar i;
        for (i = 0; i <= WIDTH-1; ++i) begin : generateblock
            assign g_wire[i] = A[i] & B[i];
            assign p_wire[i] = A[i] ^ B[i];
            assign S[i]      = carry[i] ^ p_wire[i]; 
        end
    endgenerate
    
    assign C_o = carry[WIDTH];
    
endmodule