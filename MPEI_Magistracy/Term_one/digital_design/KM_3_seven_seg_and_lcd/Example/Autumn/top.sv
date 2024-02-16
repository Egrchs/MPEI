`include "global_settings.svh"
`include "cnt_iclk.sv"
`include "autumn.sv"
`include "shifter.sv"

module top(clk, nrst, cathodes, anodes);

input logic clk;
input logic nrst;

output logic [7:0] cathodes;
output logic [7:0] anodes;

logic iclk;

`ifdef SHIFTER
logic [1:0] shift;
`elsif BARREL_SHIFTER
logic [2:0] shift;
`endif

autumn   U1( .clk      ( iclk     ),
             .shift    ( shift    ),
             .nrst     ( nrst     ),
             .cathodes ( cathodes ),
             .anodes   ( anodes   ),
           );
				
cnt_iclk U2( .clk      ( clk      ),
             .nrst     ( nrst     ),
             .iclk     ( iclk     ),
		   );
			  
shifter  U3( .clk      ( clk      ),
             .nrst     ( nrst     ),
             .shift    ( shift    ),
           );

endmodule
