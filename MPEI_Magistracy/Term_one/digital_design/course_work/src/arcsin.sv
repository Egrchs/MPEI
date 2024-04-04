module arcsin  (
    input  logic [ 63 : 0 ]  DATA_I,
    input  logic             CLK_I,
    input  logic             RST_N_I,
    output logic [  7 : 0 ]  DATA_O
);
   
    logic [ 4 : 0 ]   ADR;

    always_ff @(posedge CLK_I, negedge RST_N_I) begin
        if (!RST_N_I) begin
            ADR <= '0;
        end 
        else  begin
            ADR <= DATA_I[ 19 : 15 ];
        end
    end
 
    always_comb begin
        case (ADR)
            5'd0  : DATA_O = 8'b0000_0000 ;
            5'd1  : DATA_O = 8'b0000_0100 ;
            5'd2  : DATA_O = 8'b0000_1000 ;
            5'd3  : DATA_O = 8'b0000_1100 ;
            5'd4  : DATA_O = 8'b0001_0000 ;
            5'd5  : DATA_O = 8'b0001_0100 ;
            5'd6  : DATA_O = 8'b0001_1001 ;
            5'd7  : DATA_O = 8'b0001_1101 ;
            5'd8  : DATA_O = 8'b0010_0010 ;
            5'd9  : DATA_O = 8'b0010_0110 ;
            5'd10 : DATA_O = 8'b0010_1011 ;
            5'd11 : DATA_O = 8'b0011_0001 ;
            5'd12 : DATA_O = 8'b0011_0110 ;
            5'd13 : DATA_O = 8'b0011_1101 ;
            5'd14 : DATA_O = 8'b0100_0100 ;
            5'd15 : DATA_O = 8'b0100_1110 ;
            5'd16 : DATA_O = 8'b0110_0101 ;
            default DATA_O = 8'b0000_0000 ;
        endcase
    end
endmodule
