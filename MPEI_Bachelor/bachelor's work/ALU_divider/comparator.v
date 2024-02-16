module comparator(clk, res, A, B, divisible, divider, ready);

input clk, res;
input [15:0] A, B;

output reg [15:0] divisible, divider;
output reg                     ready;

always @(posedge clk, negedge res)

if(!res) begin
    divisible <= 0;
    divider   <= 0; 
    ready     <= 0; end
else begin
    if (A > B) begin
        divisible <= A[15:0];
        divider   <= B[15:0]; 
        ready     <= 1; end
    else if (A < B) begin
        divisible <= B[15:0];
        divider   <= A[15:0]; 
        ready     <= 1;end
    else begin
        divisible <= 0;
        divider   <= 0;	
        ready     <= 0; end end
endmodule