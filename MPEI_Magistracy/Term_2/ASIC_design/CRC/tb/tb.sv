`timescale 1ns/1ns 
`define WAVES_FILE "dump/wave.vcd"

module tb 
#(
	WIDTH = 16
);

logic [ WIDTH - 1 : 0 ] data;
logic [ WIDTH - 1 : 0 ] data_1;
logic [ WIDTH - 1 : 0 ] crc;
logic [ WIDTH - 1 : 0 ] crc_pro;
logic [ WIDTH     : 0 ] polynom_i;
logic                   out_ready_CRC;
logic                   clk;
logic                   rd;
logic                   ok;
logic                   rst;
logic                   rd_pro;

	top #(
		.WIDTH         ( WIDTH          )
	) UUT 
	( 
		.clk           ( clk          	),
		.rst           ( rst          	),
		.data          ( data         	),
		.data_1        ( data_1       	),
		.polynom_i     ( polynom_i    	),
		.rd            ( rd           	),
		.rd_pro        ( rd_pro       	),
		.CRC           ( crc          	),
		.CRC_pro       ( crc_pro      	),
		.OK            ( ok           	),
		.out_ready_PRO ( out_ready_PRO	),
		.out_ready_CRC ( out_ready_CRC	)
	);

	initial begin
		#0 clk = 0;
		forever #1 clk=~clk;
	end

	initial begin
		polynom_i = 17'h1_8005;
		rst       = 0;
		data      = 16'hAAFF;
		data_1    = 16'hAAFE;
		rd        = 0;
		#5 rst    = 1;
		#1 rd     = 1;
		#5 rst    = 0;
		#3 rd     = 0;
		#2 rd     = 1;
		#5 rst    = 1;
		#30 rd    = 0;
	end

	initial begin
        $dumpfile(`WAVES_FILE);
        $dumpvars;
		#600 $finish;
	end

endmodule