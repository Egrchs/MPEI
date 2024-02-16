module clk_div
    (
        input  logic clk_27,
        input  logic rst,
        output logic slow_clk
    );

  logic [24:0] cnt;
  logic slow_clk_reg;

  always_ff @(posedge clk_27 or negedge rst) begin
    if (!rst) begin
      cnt          <= 0;
      slow_clk_reg <= 0;
    end
    else if (cnt == 27000000/1000) begin
      cnt          <= 0;
      slow_clk_reg <= ~slow_clk_reg;
    end
    else begin
      cnt          <= cnt + 1'b1;
    end
  end

assign slow_clk = slow_clk_reg;

endmodule