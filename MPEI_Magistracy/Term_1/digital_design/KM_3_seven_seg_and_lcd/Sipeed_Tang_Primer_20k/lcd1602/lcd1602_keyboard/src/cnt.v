module cnt(
    input             CLK_I,
    input             RST_N_I,
    output [ 31 : 0 ] CNT_O
);

logic [ 31 : 0 ] cnt_reg;

always_ff @(posedge CLK_I, negedge RST_N_I) begin
    if(!RST_N_I)
        cnt_reg <= 0;
    else
        cnt_reg <= cnt_reg + 1'b1;
end

assign CNT_O = cnt_reg;
    
endmodule