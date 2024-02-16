module summator(clk, res, divisible, divider, sign, exponent, load, ready, ready_stop);

input                   clk, res;
input       [15:0]      divisible, divider;
input                   ready;

output reg              sign;
output reg  [4:0]       exponent;
output reg        		load;
output reg        		ready_stop;

reg [15:0] reg_divider;
reg [15:0] reg_divisible;

always @(posedge clk, negedge res) begin

    if (!res) begin
        sign       <= 16'b0;
        exponent   <= 5'b0;
		load       <= 1'b0; 
        ready_stop <= 1'b0; end        
    else if (ready) begin
        reg_divider   <= divider;
        reg_divisible <= divisible;
        ready_stop    <= 1'b1; 
        load          <= 1'b0;end
    else begin
        sign       <= divisible[15] ^ divider[15];
        exponent   <= divisible [14:10] - divider[14:10] + 4'b1111;
        load       <= 1'b1; end
end

endmodule