module divider
    (
    input       wire                       clk,
    input       wire                     start,
    input       wire    [ 4 :  0 ]    divident,
    input       wire    [ 4 :  0 ]     divider,
    output      wire    [ 4 :  0 ]    quotient,
    output      wire    [ 4 :  0 ]    reminder,
    );

reg     signed  [ 4 :  0 ] r_quotient = {5{1'b0}};
assign quotient = r_quotient;

reg     signed  [ 9 :  0 ] divident_copy = {10{1'b0}};
reg     signed  [ 9 :  0 ] divider_copy = {10{1'b0}};

wire    signed  [ 9 :  0 ] w_diff = divident_copy - divider_copy;
reg             [ 3 :  0 ] cnt = 4'b0;

assign reminder = divident_copy[4:0];
assign ready = cnt == 0;

wire                    ready

always@(posedge clk)
if(ready && start)
begin
    cnt <= 4'd5;
    r_quotient <= {5{1'b0}};
    divident_copy <= {{5{1'b0}}, divident};
    divider_copy <= {1'b0, divider, {4{1'b0}}};
end
else
begin
    cnt <= cnt - 1'b1;
    divider_copy <= divider_copy >> 1;
    if(!w_diff[9])
    begin
        divident_copy <= w_diff;
        r_quotient <= {quotient[3:0], 1'b1};
    end
    else
    begin
        r_quotient <= {quotient[3:0], 1'b0};
    end
end

endmodule