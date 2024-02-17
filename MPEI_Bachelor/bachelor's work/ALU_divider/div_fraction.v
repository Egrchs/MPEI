module div_fraction(clk, res, divisible, divider, fraction, load, ready, ready_stop);

input                           clk, res;
input               [15:0]      divisible, divider;
input                           ready;

output   reg        [9:0]       fraction;
output   reg                    load;
output   reg                    ready_stop;

reg                 [9:0]       reg_quotient;
reg                 [9:0]       remains;
reg                 [9:0]       reg_divider;
reg                 [3:0]       cnt;

always@(posedge clk, negedge res) begin
    if(!res) begin
        fraction      <= 0;
        load          <= 0;
        reg_quotient  <= 0;  
        reg_divider   <= 0;
        remains       <= 0; 
        cnt           <= 0; 
        ready_stop    <= 0; end   
    else if(ready) begin
            cnt           <= 4'd0;
            reg_divider   <= divider[9:0];
            remains       <= {divisible[8:0], 1'b0}; 
            reg_quotient  <= 10'd0;
            ready_stop    <= 1'b1;
            load          <= 1'b0; end
    else if(cnt < 4'd10 && ready_stop ) begin
            cnt  <= cnt + 1'b1;
            load <= 1'b0;
            if(!remains[9]) begin
                remains       <= remains - reg_divider;
                remains       <= remains[8:0] << 1;
                reg_quotient  <= {reg_quotient[8:0], 1'b1}; end
            else begin
                remains       <= remains + reg_divider;
                remains       <= remains[8:0] << 1;
                reg_quotient  <= {reg_quotient[8:0], 1'b0}; end end
    else if(cnt == 4'd10)begin
        fraction      <= reg_quotient;
        load          <= 1'b1; 
        ready_stop    <= 1'b0;end
    end

endmodule