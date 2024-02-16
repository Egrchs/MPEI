module SnailFSM_Moore_110(D, _rst, clk, Q);

localparam SAD = 0, HOPE1 = 1, HOPE2 = 2, HOORAY = 3;

input D;
input _rst, clk;

output reg Q;

reg [1:0] state, nextstate;
reg Q_nonsynch;
reg [63:0] txstate;

always @( state )
  case ( state )
	 SAD     : txstate = "SAD";
	 HOPE1   : txstate = "HOPE1";
	 HOPE2   : txstate = "HOPE2";
   HOORAY  : txstate = "HOORAY";
  endcase

always @(posedge clk, negedge _rst) begin
  if ( !_rst )
    state <= SAD;
  else
    state <= nextstate;
end

always @(*) begin
  case ( state )
    SAD          : nextstate = ((  D ) ? HOPE1   : SAD );      
    HOPE1        : nextstate = ((  D ) ? HOPE2   : SAD );
    HOPE2        : nextstate = (( !D ) ? HOORAY  : SAD );
	  HOORAY       : nextstate = ((  D ) ? HOPE1   : SAD );   
    default      : nextstate = SAD;
  endcase
end

always @(*) begin
  case ( state )
    SAD, HOPE1, HOPE2 : Q_nonsynch = 0;
    HOORAY            : Q_nonsynch = 1;
    default           : Q_nonsynch = 0;
  endcase
end

always @(posedge clk or negedge _rst)
  if (!_rst)
    Q <= 0;
  else
    Q <= Q_nonsynch;

endmodule
