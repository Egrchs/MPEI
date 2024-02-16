module SnailFSM(D, _rst, clk, Q);

localparam SAD = 0, HOPE = 1, HOORAY = 2;

input D;
input _rst, clk;

output reg Q;

reg [1:0] state, nextstate;

reg Q_nonsynch;

reg [63:0] txstate;

always @( state )
  case ( state )
	 SAD    : txstate = "SAD";
	 HOPE   : txstate = "HOPE";
	 HOORAY : txstate = "HOORAY";
  endcase

always @(posedge clk, negedge _rst) begin
  if ( !_rst )
    state <= SAD;
  else
    state <= nextstate;
end

always @(*) begin
  case ( state )
    SAD          : nextstate = (( D ) ? HOPE   : SAD ); //если D = 1, то nextstate = HOPE,   иначе nextstate = SAD
    HOPE, HOORAY : nextstate = (( D ) ? HOORAY : SAD ); //если D = 1, то nextstate = HOORAY, иначе nextstate = SAD
    default      : nextstate = SAD;
  endcase
end


always @(*) begin
  case ( state )
    SAD, HOPE : Q_nonsynch = 0;
    HOORAY    : Q_nonsynch = 1;
    default   : Q_nonsynch = 0;
  endcase
end

always @(posedge clk or negedge _rst)
  if (!_rst)
    Q <= 0;
  else
    Q <= Q_nonsynch;

endmodule
