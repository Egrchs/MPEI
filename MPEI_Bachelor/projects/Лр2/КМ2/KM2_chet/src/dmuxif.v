module dmuxif(din, sel, dout0, dout1, dout2, dout3);

input [31:0]din;
input [1:0] sel;
output reg [31:0]dout0;
output reg [31:0]dout1;
output reg [31:0]dout2;
output reg [31:0]dout3;

always @(*) begin

	if (sel==2'b00) begin

				dout0 = din;
				dout1 = 0;
				dout2 = 0;
				dout3 = 0;
   end
	
	else if (sel == 2'b01) begin
 
				dout0 = 0;
				dout1 = din;
				dout2 = 0;
				dout3 = 0;
	end
				
	else if (sel == 2'b10) begin

				dout0 = 0;
				dout1 = 0;
				dout2 = din;
				dout3 = 0;
	end

	else if (sel == 2'b11) begin 

				dout0 = 0;
				dout1 = 0;
				dout2 = 0;
				dout3 = din;
	end
			
		
	else	begin
			
				dout0 = 0;
				dout1 = 0;
				dout2 = 0;
				dout3 = 0;
	end
				
	end
	
endmodule 