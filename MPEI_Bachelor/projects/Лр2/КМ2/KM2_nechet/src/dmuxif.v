module dmuxif(in, sel, out0, out1, out2);

input [15:0]in;
input [1:0] sel;
output reg [15:0]out0;
output reg [15:0]out1;
output reg [15:0]out2;

always @(*) begin

	if (sel==2'b00) begin

				out0 = in;
				out1 = 0;
				out2 = 0;
   end
	
	else if (sel == 2'b01) begin
 
				out0 = 0;
				out1 = in;
				out2 = 0;
	end
				
	else if (sel == 2'b10) begin

				out0 = 0;
				out1 = 0;
				out2 = in;
	end
		
	else	begin
			
				out0 = 0;
				out1 = 0;
				out2 = 0;
	end
				
	end
	
endmodule 


