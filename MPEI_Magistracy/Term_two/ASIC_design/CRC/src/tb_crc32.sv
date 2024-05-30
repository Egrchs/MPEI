`timescale 1ns/1ns 
`include "crc32.sv"
`include "crc32_pro.sv"
`include "TOP_CRC.sv"
module tb_crc32 #(WIDTH =16);

logic [WIDTH-1:0] data;
logic [WIDTH-1:0] data_1;
logic [WIDTH:0] polynom_i;
logic clk, rst,rd,OK;
logic [WIDTH-1:0] CRC;
logic [WIDTH-1:0] CRC_pro;
logic out_ready_CRC;
logic rd_pro;

TOP_CRC #(WIDTH) uut
(
.clk          (clk          ),
.rst          (rst          ),
.data         (data         ),
.data_1       (data_1       ),
.polynom_i    (polynom_i    ),
.rd           (rd           ),
.rd_pro       (rd_pro       ),
.CRC          (CRC          ),
.CRC_pro      (CRC_pro      ),
.OK           (OK           ),
.out_ready_PRO(out_ready_PRO),
.out_ready_CRC(out_ready_CRC)
);

initial begin
	#0 clk = 0;
	forever #1 clk=~clk;
end

initial begin
	polynom_i = 17'h1_8005;
	#0 rst = 0;
	data   = 16'hAAFF;
	data_1 = 16'hAAFF;
	#0 rd = 0;
	#5 rst = 1;
	#1 rd = 1;
	#5 rst = 0;
	#3 rd = 0;
	#2 rd =1;
	#5 rst = 1;
	#30 rd =0;
end

initial
	$dumpvars;

initial
	#600 $finish;

endmodule