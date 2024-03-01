module LFSR_Galouis#(
    parameter WIDTH = 8;
)
(
    input  logic                 CLK_I,
    input  logic                 RST_N_I,
    input  logic                 LOAD_I,
    input  logic                 EN_I,
    input  logic [WIDTH - 1 : 0] SEED_I,
    input  logic [WIDTH - 1 : 0] POLY_I,
    input  logic [WIDTH - 1 : 0] SHIFT_I,
    input  logic [WIDTH - 1 : 0] LEN_I,

    output logic [WIDTH - 1 : 0] DATA_O
);

    logic [ WIDTH - 1 : 0 ] poly_reg;
    logic [ WIDTH - 1 : 0 ] shift_reg;
    logic [ WIDTH - 1 : 0 ] len_reg;

    logic [ WIDTH - 1 : 0 ] lfsr_reg;
    logic [ WIDTH     : 0 ] nodes;


    always_ff @(posedge CLK_I) begin
        if (LOAD_I) begin
            shift_reg <= SHIFT_I;
            poly_reg  <= POLY_I >> 1;
            len_reg   <= LEN_I;
        end
    end

    always_comb begin
        if(LOAD_I) begin
            shift_reg <= SHIFT_I;
            poly_reg  <= POLY_I >> 1;
            len_reg   <= LEN_I;
        end
    end

    always_comb begin
        if(LOAD_I) begin
            nodes = SEED_I;
        end
        else begin
            nodes = lfsr_reg;
        end

        if(EN_I) begin
            for (int i=0; i<shift_reg; ++i) begin
                nodes    = nodes << 1;
                nodes[0] = feedback_calk(poly_reg, nodes[WIDTH : 1], len);
            end
        end
    end
    
    function logic feedback_calk(
        logic [WIDTH - 1 : 0] polynome,
        logic [WIDTH - 1 : 0] reg_value,
        logic [WIDTH - 1 : 0] len
    );
        logic value;
        begin
            if(polynome[len] == '0) begin
                $error("Incorrect polynome");
            end
            value = reg_value[len];
            for (int i=0; i<len; i++) begin
                if(polynome[i]) begin
                    value = reg_value[i] ^ value;
                end
            end
            return value;
        end     
    endfunction

    assign DATA_O = lfsr_reg;
endmodule