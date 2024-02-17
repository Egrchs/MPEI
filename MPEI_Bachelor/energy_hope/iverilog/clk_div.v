module clk_div (clk_50MHz, clk2);

input clk_50MHz;
    
output clk2;

reg [11:0]cnt = 0;

assign clk2 = cnt[11];

always @(posedge clk_50MHz) begin
    cnt <= cnt + 12'b1;
end
    
endmodule