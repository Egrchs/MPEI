`include "carry_lookahead_generator.sv"
module carry_lookahead_adder_4
    
    (
        input  logic           C_i,
        input  logic [3 : 0]   A,
        input  logic [3 : 0]   B,
        output logic [3 : 0]   S,
        output logic              group_gen,
        output logic              group_prop 
    );

    logic [ 4   : 0 ] carry;
    logic [ 3 : 0 ] g_wire, p_wire;

    carry_lookahead_generator 
    #(
        .WIDTH(4)
    )
    UUT(
        .carry_in(C_i),
        .gen_in(g_wire),
        .prop_in(p_wire),
        .carry(carry),
        .group_gen(group_gen),
        .group_prop(group_prop)
    );
    
    generate
        genvar i;
        for (i = 0; i <= 3; ++i) begin : generateblock
            assign g_wire[i] = A[i] & B[i];
            assign p_wire[i] = A[i] ^ B[i];
            assign S[i]      = carry[i] ^ p_wire[i]; 
        end
    endgenerate
    
    
    
endmodule