module LFSR_Galois 
#(
    parameter MAX_LEN = 8
)
(   
    input  logic                         CLK_I,
    input  logic                         RST_N_I,
    input  logic                         EN_I,
    input  logic                         LOAD_I,
    input  logic    [ MAX_LEN - 1 : 0 ]  SEED_I,
    input  logic    [ MAX_LEN - 1 : 0 ]  POLY_I,
    output logic    [ MAX_LEN - 1 : 0 ]  DATA_O
);

    logic [ MAX_LEN - 1 : 0 ] data_reg;
    logic [ MAX_LEN - 1 : 0 ] poly_reg;
    logic                     feedback;

    always_ff @ (posedge CLK_I, negedge RST_N_I) begin
        if(!RST_N_I) begin
            data_reg <= 0;
            poly_reg <= 0;
        end
        else begin
            if (LOAD_I) begin
                data_reg <= SEED_I;
                poly_reg <= POLY_I;
            end
            else begin
                feedback <= data_reg[0];
                for (int i = 0; i < MAX_LEN-1; i++) begin
                    data_reg[i] <= poly_reg[i] ? (data_reg[i+1] ^ feedback) : data_reg[i+1];
                end
            end
        end
    end

    always_comb 
        DATA_O = data_reg;

endmodule