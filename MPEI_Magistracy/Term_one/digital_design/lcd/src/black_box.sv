module black_box 
#(
    parameter PAYLOAD_BITS = 8
) 
(
    input  logic                          CLK_I,
    input  logic                          RST_N_I,
    input  logic [ PAYLOAD_BITS - 1 : 0 ] DATA_I,
    input  logic                          BB_READY_I,
    output logic [ PAYLOAD_BITS - 1 : 0 ] DATA_O
);  

always_ff @(posedge CLK_I, negedge RST_N_I)
    if(!RST_N_I) begin
        DATA_O = '0;
    end
    else begin
        if(BB_READY_I)
            DATA_O = DATA_I;
        else 
            DATA_O = '0;
    end
    
endmodule