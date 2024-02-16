module shift_register_right(sign, exponent, fraction, out, clk, res, tready, load, load_done);

input                   sign;
input       [4:0]       exponent;   
input       [9:0]       fraction;    
input                   clk, res, load;

output reg              out;
output reg              tready;
output reg              load_done;

reg         [15:0]      dout;
reg         [3:0]      cnt;

always @(posedge clk, negedge res) begin
    if (!res) begin
        out       <= 1'b0;
        dout      <= 16'h0000;
        tready    <= 1'b0; 
        load_done <= 1'b0; 
        cnt       <= 4'b0; end
    else if (load) begin
        dout        <= {sign, exponent, fraction};
        load_done   <= 1'b1; 
        cnt         <= 4'd0; 
        tready      <= 1'b0;end
    else if (cnt < 4'd15) begin
        cnt         <= cnt + 1'b1;
        out         <= dout[0];
        dout        <= {1'b0, dout[15:1]};
        tready      <= 1'b1; end
    else begin
        cnt         <= 4'd0;
        out         <= 0;
        load_done   <= 1'b0; 
        tready      <= 1'b0;end
    end

endmodule