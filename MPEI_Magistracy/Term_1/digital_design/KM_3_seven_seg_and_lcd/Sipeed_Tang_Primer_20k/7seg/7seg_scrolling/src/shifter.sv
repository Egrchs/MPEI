module shifter
#(
  localparam FREQ_SHIFT = 3,
  localparam CLK_INNER = 27000000,
  localparam WIDTH = $clog2(CLK_INNER/FREQ_SHIFT)
)
(
  input  logic           clk,
  input  logic           nrst,
  output logic [3:0]     shift
);

  logic    [        3 : 0] shift_r;
  logic    [WIDTH - 1 : 0] cnt;

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      cnt     <= 0;
      shift_r <= 0;
    end
    else begin
        if (cnt == CLK_INNER/FREQ_SHIFT) begin
            cnt     <= 0;
            shift_r <= shift_r + 1'b1;
        end
        else 
            cnt     <= cnt + 1'b1;
    end
  end

  assign shift = shift_r;

endmodule