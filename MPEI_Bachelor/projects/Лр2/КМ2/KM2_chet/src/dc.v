module dc(in,led);
input [3:0] in;
output reg [6:0] led;
 always @ (in) begin
//   case (in)
//      0: led = 7'b1000000;
//      1: led = 7'b1111001;
//      2: led = 7'b0100100;
//      3: led = 7'b0110000;
//      4: led = 7'b0011001;
//      5: led = 7'b0010010;
//      6: led = 7'b0000010;
//      7: led = 7'b1111000;
//      8: led = 7'b0000000;
//      9: led = 7'b0010000;
//	default: led = 7'b1111000;	
//	endcase
	
	case (in)
      0: led = 7'b0111111;
      1: led = 7'b0000110;
      2: led = 7'b1011011;
      3: led = 7'b1001111;
      4: led = 7'b1100110;
      5: led = 7'b1101101;
      6: led = 7'b1111101;
      7: led = 7'b0000111;
      8: led = 7'b1111111;
      9: led = 7'b1101111;
	default: led = 7'b0000111;	
	endcase
 end
 endmodule 