module div_new(A, B, quotient, reminder, clk, res, load, error);

input       wire                         clk;
input       wire                         res;
input       wire                        load;
input       wire    [ 4 :  0 ]             A;
input       wire    [ 4 :  0 ]             B;
output      reg     [ 4 :  0 ]      quotient;
output      reg     [ 4 :  0 ]      reminder;
output      reg                        error;

reg     signed      [ 9 :  0 ] divisible_copy;
reg     signed      [ 9 :  0 ]  divider_copy;

reg                 [ 4 :  0 ]     divisible;
reg                 [ 4 :  0 ]       divider;
reg                 [ 3 :  0 ]           cnt;

wire    signed      [ 9 :  0 ] w_diff = divisible_copy - divider_copy;
wire ready;

assign ready = cnt == 0;

always @(posedge clk, negedge res) begin
    if(!res) begin
        divisible_copy <= 0;
        divider_copy  <= 0;
        error         <= 0;
        cnt           <= 0; 
        quotient      <= 0;
        reminder      <= 0; 
        divisible     <= 0;
        divider       <= 0;end
    else begin
    if(load) begin
        if ((A !=0) && (B !=0)) begin
            if(A > B) begin
                divisible   <= A;
                divider     <= B; 
                error       <= 1'b0; end
            else if (A < B) begin
                divisible   <= B;
                divider     <= A; 
                error       <= 1'b0; end end
        else begin 
                quotient    <= 5'b0;
                reminder    <= 5'b0;
                error       <= 1'b1; end end
    else if(ready) begin
        cnt <= 4'd5;
        quotient <= {5{1'b0}};
        divisible_copy <= {{5{1'b0}}, divisible};
        divider_copy <= {1'b0, divider, {4{1'b0}}}; 
        reminder = divisible_copy[4:0];  end
    else begin
        cnt <= cnt - 1'b1;
        divider_copy <= divider_copy >> 1;
        if(!w_diff[9]) begin
            divisible_copy <= w_diff;
            quotient <= {quotient[3:0], 1'b1}; end
        else begin
            quotient <= {quotient[3:0], 1'b0};end end
    end end 
endmodule