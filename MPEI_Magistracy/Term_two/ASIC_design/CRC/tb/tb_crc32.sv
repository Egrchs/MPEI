`timescale 1ns/1ns 
`include "crc32.sv"
`include "crc32_pro.sv"
`include "TOP_CRC.sv"
module tb_crc32 #(WIDTH =32);

logic [31:0] data;
logic [32:0] polynom_i;
logic clk, rst,rd,OK;
logic [31:0] CRC;
logic [31:0] CRC_pro;
logic out_ready_CRC;
logic rd_pro;

TOP_CRC #(WIDTH) uut(
.clk(clk),
.rst(rst),
.data(data),
.polynom_i(polynom_i),
.rd(rd),
.rd_pro(rd_pro),
.CRC(CRC),
.CRC_pro(CRC_pro),
.OK(OK),
.out_ready_PRO(out_ready_PRO),
.out_ready_CRC(out_ready_CRC)
);

initial begin
	#0 clk = 0;
	forever #1 clk=~clk;
end

initial begin
	#0 rst = 0;
	//#0 data = 32'hAAAA5555;
	data = 32'b01010110011011111000101101000100;
	polynom_i = 33'h1_04C11DB7;
	//data = 32'hFFAA0F9D;
	//data = 32'b1111_1111_1010_1010_0000_1111_1001_1101;
	#0 rd = 0;
	//#0 rd_pro =1;
	#5 rst = 1;
	#1 rd = 1;
	#5 rst = 0;
	#3 rd = 0;
	#2 rd =1;
	#5 rst = 1;
	#30 rd =0;

	//#100 rd_pro = 1;
	//#10 rd_pro =0;
end

initial
	$dumpvars;

initial
	#600 $finish;

endmodule