module SnailFSM_Mealey_110(D, _rst, clk, Q);

localparam SAD = 0, WAIT1 = 1, WAIT2 = 2;

input D;
input _rst, clk;

output reg Q;

reg [1:0] state, nextstate;

reg Q_nonsynch;

reg [63:0] txstate;

always @( state )
  case ( state )
	 SAD    : txstate = "SAD";
	 WAIT1  : txstate = "WAIT1";
   WAIT2  : txstate = "WAIT2";
  endcase

always @(posedge clk, negedge _rst) begin
  if ( !_rst )
    state <= SAD;
  else
    state <= nextstate;
end

always @(*) begin
  case ( state )
    SAD   : nextstate = ((  D ) ? WAIT1 :   SAD );
	  WAIT1 : nextstate = ((  D ) ? WAIT2 :   SAD ); 
    WAIT2 : nextstate = (( !D ) ? SAD   : WAIT1 );   
    default : nextstate = SAD;
  endcase
end


always @(*) begin
  case ( state )
    SAD       : Q_nonsynch = 0;
    WAIT1     : Q_nonsynch = 0;
    WAIT2     : Q_nonsynch = (!D) ? 1'b1 : 1'b0;
    default   : Q_nonsynch = 0;
  endcase
end

always @(posedge clk or negedge _rst)
  if (!_rst)
    Q <= 0;
  else
    Q <= Q_nonsynch;

//assign Q = (D == 1'b1 && state == WAIT1);
endmodule
