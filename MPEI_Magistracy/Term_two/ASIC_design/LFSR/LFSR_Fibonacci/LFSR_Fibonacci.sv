module LFSR_Fibonacci 
#(
    parameter W = 8
)
(
    input  logic CLK_I,
    input  logic RST_N_I,
    input  logic LOAD_I,
    input  logic EN_I,
    input  logic [ W - 1 : 0 ] POLY_I,
    input  logic [ W - 1 : 0 ] SEED_I,
    input  logic [ W - 1 : 0 ] SHIFT_I,
    output logic [ W - 1 : 0 ] DATA_O 
);

    logic [ W - 1 : 0 ] poly_reg;
    logic [ W - 1 : 0 ] seed_reg;
    logic [ W - 1 : 0 ] shift_reg;
    logic [ W - 1 : 0 ] data_reg;

    always_ff @(posedge CLK_I or negedge RST_N_I) begin
        if(!RST_N_I) begin
            poly_reg  <= 0;
            seed_reg  <= 0;
            data_reg  <= 0;
        end

        else if (LOAD_I)begin
            poly_reg  <= POLY_I;
            seed_reg  <= SEED_I;
            shift_reg <= SHIFT_I;
        end
    end
   
    always_comb begin
        if(EN_I) begin
            for (int i = 0; i < shift_reg; i++) begin
                seed_reg =  {(^(seed_reg[W:0] & poly_reg)), seed_reg[W-2 : 0]};
            end
        end
    end

endmodule //LFSR_Fibonacci