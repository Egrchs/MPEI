module cnt_iclk(clk, nrst, iclk);

localparam WIDTH = $clog2(CLK_INNER/`FREQ_FOR_ANODES);

input logic clk;
input logic nrst;

output logic iclk;

logic [WIDTH-1:0] cnt;

always_ff @(posedge clk or negedge nrst) begin
  if (!nrst) begin
    cnt  <= 0;
    iclk <= 0;
  end
  else if (cnt == `FREQ_FOR_ANODES) begin
    cnt  <= 0;
    iclk <= ~iclk;
  end
  else begin
    cnt  <= cnt + 1'b1;
  end
end

endmodule