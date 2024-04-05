module descrambler 
(
   input  logic   clk,
   input  logic   rst,
   input  logic   bit_in,
   output logic	bit_out
);

   logic [9 : 0] q;

   assign feedback = (q[8] ^ q[2] ^ q[0]);

   always_ff @(posedge clk or negedge rst) begin
	   if (!rst) begin
	      q <= 10'b00_1001_0110;
      end 
	   else begin 
	      q <= {feedback,q[9:1]};
      end
   end 

  assign bit_out = feedback ^ bit_in;

endmodule