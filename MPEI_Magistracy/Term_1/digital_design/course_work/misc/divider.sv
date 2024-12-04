module divider
    #(
        parameter PAYLOAD_BITS = 8
    )
    (
        input  logic                          CLK_I,
        input  logic                          RST_N_I,
        input  logic                          READY_I,
        input  logic [ PAYLOAD_BITS - 1 : 0 ] DIVIDENT_I,
        input  logic [ PAYLOAD_BITS - 1 : 0 ] DIVISOR_I,
        output logic [ PAYLOAD_BITS - 1 : 0 ] QUOTIENT_O,
        output logic [ PAYLOAD_BITS - 1 : 0 ] REMINDER_O,
        output logic                          busy
    );

    logic  [ $clog2(PAYLOAD_BITS)- 1  : 0 ]   count;
    logic  [ PAYLOAD_BITS        - 1  : 0 ]   reg_q;
    logic  [ PAYLOAD_BITS        - 1  : 0 ]   reg_r;
    logic  [ PAYLOAD_BITS        - 1  : 0 ]   reg_b;
    logic  [ PAYLOAD_BITS        - 1  : 0 ]   reg_r2;
    logic  [ PAYLOAD_BITS        - 1  : 0 ]   r;
    logic  [ PAYLOAD_BITS        - 1  : 0 ]   q;
    logic                                     r_sign;
    logic                                     sign;

    wire [PAYLOAD_BITS : 0] sub_add = r_sign ? ({reg_r, reg_q[PAYLOAD_BITS - 1]} + {1'b0, reg_b}) :
                                        ({reg_r, reg_q[PAYLOAD_BITS - 1]} - {1'b0, reg_b});

    always_comb reg_r2 = r_sign ? reg_r + reg_b : reg_r;

    always_comb r  = DIVIDENT_I[PAYLOAD_BITS - 1] ? (~reg_r2 + 1) : reg_r2;

    always_comb q  = (DIVISOR_I[PAYLOAD_BITS - 1] ^ DIVIDENT_I[PAYLOAD_BITS - 1]) ? (~reg_q + 1) : reg_q;
    
    always @(posedge CLK_I or negedge RST_N_I)begin
        if(!RST_N_I)begin
            count     <= 0;
            busy      <= 0;
        end
        else begin
            if(READY_I)begin
                reg_r      <= '0;
                r_sign     <= '0;
                count      <= '0;
                busy       <= '1;
                REMINDER_O <= '0;
                QUOTIENT_O <= '0;

                if(DIVIDENT_I[PAYLOAD_BITS - 1] == 1) begin
                    reg_q <= ~DIVIDENT_I + 1;
                end
                else 
                    reg_q <= DIVIDENT_I;

                if(DIVISOR_I[PAYLOAD_BITS - 1] == 1)begin
                    reg_b <= ~DIVISOR_I+1;
                end
                else 
                    reg_b <= DIVISOR_I;
            end
            else if(busy)begin
                reg_r    <= sub_add[PAYLOAD_BITS - 1:0];
                r_sign   <= sub_add[PAYLOAD_BITS];
                reg_q    <= {reg_q[PAYLOAD_BITS - 2:0], ~sub_add[PAYLOAD_BITS]};
                count    <= count + 1;
                if(count == PAYLOAD_BITS - 1) begin
                    busy <= 0;
                end
            end
            else if(busy == 0) begin
                REMINDER_O <= r;
                QUOTIENT_O <= q;
            end
        end
    end    
endmodule