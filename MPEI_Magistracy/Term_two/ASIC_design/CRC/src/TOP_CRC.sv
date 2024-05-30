module TOP_CRC#(
	parameter WIDTH = 32
   )
   (
    input  logic                   clk,
    input  logic                   rst,
    input  logic [WIDTH-1:0]       data,
	input  logic [WIDTH  :0]       polynom_i,
    input  logic                   rd,
    output logic [WIDTH-1:0]       CRC,
	output logic [WIDTH-1:0]       CRC_pro,
	output logic                   OK,
	output logic                   rd_pro,
	output logic                   out_ready_PRO,
    output logic                   out_ready_CRC
  );
	
//	logic rd_pro;
  logic [4:0]    cntp;
  logic [31:0]   data_CRC;
  logic [63:0]   ext_data; //что ты такое?
  logic [32:0] polynomial; //generation polynom 
  logic [5:0]         cnt; //counter
  logic         ready_CRC;
  logic [32:0]    shifter; //сдвиг результата "вычитания" полиномов, если он был
  logic [32:0]    reg_xor; //результат "вычитания" полиномов
  
  crc32 #(WIDTH) uut0 (
.clk(clk),
.rst(rst),
.data(data),
.polynom_i(polynom_i),
.rd(rd),
.CRC(CRC),
.out_ready_CRC(out_ready_CRC)
);

crc32_pro  uut1 (
.clk(clk),
.rst(rst),
.data(data),

.rd(rd_pro),
.CRC_IN(CRC),
.CRC(CRC_pro),
.out_ready_CRC(out_ready_PRO)
);
  
  always_ff @(posedge clk ) begin
		if(!rst) begin
			cntp   <= '0;
			rd_pro <= '1;
		end
		else begin
			if (out_ready_CRC) begin
				if (cntp < 5'd10) begin
					cntp   <= cntp + 1'b1;
					rd_pro <= 1'b1;
				end 
				else begin
						rd_pro <= 1'b0;
				end
			end
		end
  end		
  
  
  assign OK = out_ready_PRO ? ( ~|CRC_pro ? 1'b1 : 1'b0 ) : 1'bx;
endmodule
