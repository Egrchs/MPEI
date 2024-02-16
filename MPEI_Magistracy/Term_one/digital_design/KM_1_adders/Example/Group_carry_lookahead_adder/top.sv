`include "Group_carry_lookahead_adder.sv"
module top 
    #(
        parameter WIDTH = 8
    ) 
    ( 
        input  logic [ WIDTH-1 : 0 ] A_i,
        input  logic [ WIDTH-1 : 0 ] B_i,
        input  logic                 P_i,
        input  logic                 RST_N_I,
        input  logic                 CLK_i,
        output logic [ WIDTH-1 : 0 ] S_o,
        output logic                 C_o,
        output logic [ WIDTH   : 0 ] full_add
    );

    logic [ WIDTH-1 : 0 ] A_ff;
    logic [ WIDTH-1 : 0 ] B_ff;
    logic                 P_ff;
    logic [ WIDTH-1 : 0 ] S_ff;
    logic                 C_ff;

    logic [ WIDTH-1 : 0 ] A_ff_w;
    logic [ WIDTH-1 : 0 ] B_ff_w;
    logic [ WIDTH-1 : 0 ] S_ff_w;
    logic                 C_ff_w;

    assign A_ff_w    = A_ff;
    assign B_ff_w    = B_ff;
    assign P_ff_w    = P_ff;
    
    assign C_o       = C_ff;
    assign S_o       = S_ff;

    always_ff @(posedge CLK_i or negedge RST_N_I) begin
        if(!RST_N_I) begin
            A_ff <= 0;
            B_ff <= 0;
            P_ff <= 0;
            S_ff <= 0;
            C_ff <= 0;
        end
        else begin
            A_ff <= A_i;
            B_ff <= B_i;
            P_ff <= P_i;
            S_ff <= S_ff_w;
            C_ff <= C_ff_w;
        end
    end

    Group_carry_lookahead_adder
    #(
        .WIDTH(WIDTH)
    ) 
    add 
    (
        .A_i(A_ff_w),
        .B_i(B_ff_w),
        .P_i(P_ff_w),
        .S_o(S_ff_w),
        .C_o(C_ff_w)
    );

    assign full_add = {C_o, S_o};

endmodule