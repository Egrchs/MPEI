module Tpov(T, res, Q, nQ);

input T, res ;

output reg Q, nQ;

initial 
begin
Q = 0; 
nQ = 0;
end

always @ (posedge T, negedge res)
if (!res) begin
	Q <= 0;
	nQ <= 1; end
else begin
	Q <= !Q;
	nQ <= Q; end

endmodule