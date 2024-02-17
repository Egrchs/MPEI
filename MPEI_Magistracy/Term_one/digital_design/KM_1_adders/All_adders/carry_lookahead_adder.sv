module carry_lookahead_adder
    #(
        parameter W = 16 
    )
    (
        input   logic             CLK_i,
        input   logic             rst_n_i,
        input   logic [ W-1 : 0 ] A_i,
        input   logic [ W-1 : 0 ] B_i,
        output  logic [ W-1 : 0 ] S_o,
        input   logic             P_i,

        output  logic             C_o,
        output  logic [ W   : 0 ] full_add
    );
  

    logic [ W-1 : 0 ] A_ff;
    logic [ W-1 : 0 ] B_ff;
    logic             P_ff;
    logic             C_ff;
    logic [ W-1 : 0 ] S_ff;

    logic [ W-1 : 0 ] A_ff_w;
    logic [ W-1 : 0 ] B_ff_w;
    logic [ W-1 : 0 ] S_ff_w;
    logic [ W   : 0 ] C_ff_w;
    logic [ W-1 : 0 ] p_w;
    logic [ W-1 : 0 ] g_w;

    always_ff @(posedge CLK_i or negedge rst_n_i) begin
        if(!rst_n_i) begin
            A_ff <= 0;
            B_ff <= 0;
            P_ff <= 0;
        end
        else begin
            A_ff <= A_i;
            B_ff <= B_i;
            P_ff <= P_i;
        end
    end

    always_ff @(posedge CLK_i or negedge rst_n_i) begin
        if(!rst_n_i) begin
            S_ff <= 0;
            C_ff <= 0;
        end

        else begin
            S_ff <= S_ff_w;
            C_ff <= C_ff_w[W-1];
        end
    end

    assign A_ff_w   = A_ff;
    assign B_ff_w   = B_ff;

    assign C_ff_w[0] = P_ff;
    assign C_o       = C_ff;
    assign S_o       = S_ff;

    assign full_add  = {C_o, S_o};

    generate
        genvar i;
        for ( i = 0; i < W; i++) begin : genblock
            assign g_w[i] = A_ff_w[i] & B_ff_w[i] ;
            assign p_w[i] = A_ff_w[i] ^ B_ff_w[i] ;
            assign C_ff_w[i+1] = g_w[i] | (p_w[i] & C_ff_w[i]) ;
            assign S_ff_w[i] = A_ff_w[i] ^ B_ff_w[i] ^ C_ff_w[i];
        end 
    endgenerate

endmodule