module cordic 
	(
    	input  logic                 CLK_I,
    	input  logic                 RST_N_I,
    	input  logic signed [19 : 0] Z0_I,
    	input  logic                 READY_I,
    	output logic signed [31 : 0] COS_O,
    	output logic signed [31 : 0] SIN_O,
    	output logic signed          DONE_O
    );

    logic                   state;
    logic        [ 4  : 0 ] i;
    logic signed [ 19 : 0 ] dz;
    logic signed [ 19 : 0 ] dx;
    logic signed [ 19 : 0 ] dy;
    logic signed [ 19 : 0 ] y;
    logic signed [ 19 : 0 ] x;
    logic signed [ 19 : 0 ] z;

always_ff @(posedge CLK_I or posedge RST_N_I) begin 
    if (!RST_N_I) begin
        state <= 1'b0;
        COS_O <= 32'b0;
        SIN_O <= 32'd0;
        DONE_O <= 1'b0;
        x <= 32'd0;
        y <= 32'd0;
        z <= 32'd0;
        i <= 4'd0;
    end
    else begin
        // synthesis parallel_case full_case
        casez (state)
            1'b0: begin
                if (READY_I) begin
                    x <= 159188;
                    y <= 0;
                    z <= Z0_I;
                    i <= 0;
                    DONE_O <= 0;
                    state <= 1'b1;
                end
            end
            1'b1: begin
                dx = $signed(y >>> $signed({1'b0, i}));
                dy = $signed(x >>> $signed({1'b0, i}));
                // synthesis parallel_case full_case
                if ((z >= 0)) begin
                    x <= x - dx;
                    y <= y + dy;
                    z <= z - dz;
                end
                else begin
                    x <= x + dx;
                    y <= y - dy;
                    z <= z + dz;
                end
                if ((i == (19 - 1))) begin
                    COS_O <= x;
                    SIN_O <= y;
                    state <= 1'b0;
                    DONE_O <= 1;
                end
                else begin
                    i <= i + 1;
                end
            end
        endcase
    end
end
always_comb begin
    case (i)
    0: dz = 205887;
    1: dz = 121542;
    2: dz = 64220;
    3: dz = 32599;
    4: dz = 16363;
    5: dz = 8189;
    6: dz = 4096;
    7: dz = 2048;
    8: dz = 1024;
    9: dz = 512;
    10: dz = 256;
    11: dz = 128;
    12: dz = 64;
    13: dz = 32;
    14: dz = 16;
    15: dz = 8;
    16: dz = 4;
    17: dz = 2;
    default: dz = 1;
endcase
end


endmodule
