module uart_test
#(
	parameter	CLK_FRE  = 27,    	//Mhz
	parameter	UART_FRE = 9600   //Mhz
)
(
	input 	logic	      CLK_I,
	input 	logic	      RST_N_I,
	input 	logic	      uart_rx,
	output	logic	      uart_tx,
    output  logic         led,
    output  logic [7 : 0] LCD_DATA_O,
    output  logic   	  LCD_RW_O,
    output  logic   	  LCD_EN_O,
    output  logic   	  LCD_RS_O
);
	localparam                       IDLE =  0;
	localparam                       SEND =  1;   //send 
	localparam                       WAIT =  2;   //wait 1 second and send uart received data

	logic [ 31: 0 ]                  wait_cnt;
	logic [ 3 : 0 ]                  state;
	
	logic [ 7 : 0 ]                  tx_str;
	logic [ 7 : 0 ]                  tx_cnt;
	logic [ 7 : 0 ]                  tx_data;
	logic                            tx_data_valid;
	logic                            tx_data_ready;
	
	logic [ 7 : 0 ]                  rx_data;
	logic [ 7 : 0 ]                  bb_data;
	logic                            rx_data_valid;
	logic                            rx_data_ready;
    logic                            bb_valid;

	assign rx_data_ready = 1'b1;

	always_ff @(posedge CLK_I or negedge RST_N_I) begin
		if(RST_N_I == 1'b0) begin
			wait_cnt      <= 32'd0;
			tx_data       <= 8'd0;
			state         <= IDLE;
			tx_cnt        <= 8'd0;
			tx_data_valid <= 1'b0;
		end
		else begin
			case(state)
				IDLE:
					state <= SEND;
				SEND: begin
					wait_cnt <= 32'd0;
					tx_data  <= tx_str;

					if(tx_data_valid == 1'b1 && tx_data_ready == 1'b1 && tx_cnt < DATA_NUM - 1) begin //Send 12 bytes data
						tx_cnt <= tx_cnt + 8'd1; //Send data counter
					end
					else if(tx_data_valid && tx_data_ready)begin //last byte sent is complete 
						tx_cnt        <= 8'd0;
						tx_data_valid <= 1'b0;
						state         <= WAIT;
					end
					else if(~tx_data_valid) begin
						tx_data_valid <= 1'b1;
					end
				end
				WAIT: begin
					wait_cnt <= wait_cnt + 32'd1;

					if(rx_data_valid == 1'b1) begin
						tx_data_valid <= 1'b1;
						tx_data       <= rx_data;   // send uart received data
					end
					else if(tx_data_valid && tx_data_ready) begin
						tx_data_valid <= 1'b0;
					end
					else if(wait_cnt >= CLK_FRE * 1000_000) // wait for 1 second
						state <= SEND;
				end
				default:
					state <= IDLE;
			endcase
		end
	end

	//combinational logic
	parameter 	ENG_NUM  = 9;//非中文字符数
	parameter 	CHE_NUM  = 6;//  中文字符数
	parameter 	DATA_NUM = CHE_NUM; //中文字符使用UTF8，占用3个字节

	logic [DATA_NUM * 8 - 1 : 0] send_data = {"Egor", 16'h0d0a};

	always_comb begin
		tx_str = send_data[(DATA_NUM - 1 - tx_cnt) * 8 +: 8];
	end

	uart_rx
	#(
		.CLK_FRE(CLK_FRE),
		.BAUD_RATE(UART_FRE)
	) 
	uart_rx_inst
	(
		.clk                        (CLK_I                      ),
		.rst_n                      (RST_N_I                    ),
		.rx_data                    (rx_data                  ),
		.rx_data_valid              (rx_data_valid            ),
		.rx_data_ready              (rx_data_ready            ),
		.rx_pin                     (uart_rx                  )
	);

	uart_tx
	#(
		.CLK_FRE(CLK_FRE),
		.BAUD_RATE(UART_FRE)
	) 
	uart_tx_inst
	(
		.clk                        ( CLK_I         ),
		.rst_n                      ( RST_N_I       ),
		.tx_data                    ( tx_data       ),
		.tx_data_valid              ( tx_data_valid ),
		.tx_data_ready              ( tx_data_ready ),
		.tx_pin                     ( uart_tx       )
	);

    lcd
    #(
        .PAYLOAD_BITS(8)
    )
    lcd_inst
    (
    .CLK_I       ( CLK_I        ),
    .RST_N_I     ( RST_N_I      ),
    .LCD_DATA_I  ( bb_data      ),
    .LCD_DATA_O  ( LCD_DATA_O   ),
    .LCD_RW_O    ( LCD_RW_O     ),
    .LCD_EN_O    ( LCD_EN_O     ),
    .LCD_RS_O    ( LCD_RS_O     ),
    .LCD_READY_I ( bb_valid     )
    );

	blackbox
	#(
        .PAYLOAD_BITS(8)
    )
    bb_inst
    (
    .CLK_I       ( CLK_I         ),
    .RST_N_I     ( RST_N_I       ),
    .BB_DATA_I   ( rx_data       ),
    .BB_DATA_O   ( bb_data       ),
    .BB_READY_I  ( rx_data_valid ),
    .BB_VALID_O  ( bb_valid      )
    );

endmodule