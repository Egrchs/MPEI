module divu 
    #(
        parameter WIDTH=32,  // width of numbers in bits (integer and fractional)
        parameter FBITS=18   // fractional bits within WIDTH
    ) 
    (
        input   logic                   CLK_I,          // clock
        input   logic                   RST_N_I,        // reset
        input   logic                   READY_I,        // start calculation
        input   logic [ WIDTH - 1 : 0]  DIVIDEND_I,     // dividend (numerator)
        input   logic [ WIDTH - 1 : 0]  DIVISOR_I,      // divisor (denominator)

        output  logic                   BUSY_O,         // calculation in progress
        output  logic                   DONE_O,         // calculation is complete (high for one tick)
        output  logic                   VLD_O,          // result is VLD_O
        output  logic                   DBZ_O,          // divide by zero
        output  logic                   OVF_O,          // overflow
        output  logic  [WIDTH - 1 : 0]  QUOTIENT_O      // result value: quotient
    );

    localparam FBITSW = (FBITS == 0) ? 1 : FBITS;  // avoid negative vector width when FBITS=0
    localparam ITER = WIDTH + FBITS;               // iteration count: unsigned input width + fractional bits

    logic [WIDTH -1 : 0] divisor_reg;              // copy of divisor
    logic [WIDTH -1 : 0] quo, quo_next;            // intermediate quotient
    logic [WIDTH    : 0] acc, acc_next;            // accumulator (1 bit wider)

    logic [$clog2(ITER)-1:0] i;                    // iteration counter

    // division algorithm iteration
    always_comb begin
        if (acc >= {1'b0, divisor_reg}) begin
            acc_next = acc - divisor_reg;
            {acc_next, quo_next} = {acc_next[WIDTH-1:0], quo, 1'b1};
        end 
        else begin
            {acc_next, quo_next} = {acc, quo} << 1;
        end
    end

    // calculation control
    always_ff @(posedge CLK_I) begin
        DONE_O <= 0;
        if (!RST_N_I) begin
            BUSY_O     <= 0;
            DONE_O     <= 0;
            VLD_O      <= 0;
            DBZ_O      <= 0;
            OVF_O      <= 0;
            QUOTIENT_O <= 0;
        end
        else begin
            if (READY_I) begin
                VLD_O <= 0;
                OVF_O <= 0;
                i     <= 0;
                if (DIVISOR_I == 0) begin  // catch divide by zero
                    BUSY_O <= 0;
                    DONE_O <= 1;
                    DBZ_O  <= 1;
                end 
                else begin
                    BUSY_O      <= 1;
                    DBZ_O       <= 0;
                    divisor_reg <= DIVISOR_I;
                    {acc, quo}  <= {{WIDTH{1'b0}}, DIVIDEND_I, 1'b0};  // initialize calculation
                end
            end 
            else if (BUSY_O) begin
                if (i == ITER-1) begin  // DONE_O
                    BUSY_O     <= 0;
                    DONE_O     <= 1;
                    VLD_O      <= 1;
                    QUOTIENT_O <= quo_next;
                end 
                else if (i == WIDTH-1 && quo_next[WIDTH-1:WIDTH-FBITSW] != 0) begin  // overflow?
                    BUSY_O     <= 0;
                    DONE_O     <= 1;
                    OVF_O      <= 1;
                    QUOTIENT_O <= 0;
                end 
                else begin  // next iteration
                    i   <= i + 1;
                    acc <= acc_next;
                    quo <= quo_next;
                end
            end
        end
    end
endmodule