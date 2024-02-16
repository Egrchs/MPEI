module dc(in,seg);

input [3:0] in;
output reg [6:0] seg;

 always @ (in) begin

 case (in)
      0: seg = 7'b0111111;
      1: seg = 7'b0000110;
      2: seg = 7'b1011011;
      3: seg = 7'b1001111;
      4: seg = 7'b1100110;
      5: seg = 7'b1101101;
      6: seg = 7'b1111101;
      7: seg = 7'b0000111;
      8: seg = 7'b1111111;
      9: seg = 7'b1101111;
	default: seg = 7'b0000111;	
	endcase
 end
 endmodule 
 
 
 
 
 