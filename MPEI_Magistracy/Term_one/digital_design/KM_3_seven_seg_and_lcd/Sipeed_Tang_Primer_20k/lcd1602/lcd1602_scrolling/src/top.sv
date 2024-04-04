module top 
#( 
    parameter   clk_mhz    = 27,
                w_tm_key   = 8,  // The last key is used for a reset
                w_tm_led   = 8,
                w_tm_digit = 8
)
( 	
    inout   logic [7:0] GPIO_0,
 	input	logic		clk_27,		// тактовый сигнал 27 МГц
	output	logic		LCD_RW,		// выбор режима чтения / записи: 0 - чтение, 1 - запись
	output	logic		LCD_EN,		// LCD включён
	output	logic		LCD_RS,		// выбор режима команды / данные: 0 - команды, 1 - данные
	output	logic [7:0]	LCD_DATA    // шина данных 8-битная
);	

    wire  [w_tm_key    - 1:0] tm_key;
    wire  [w_tm_key    - 1:0] tm_key_w;
    wire  [w_tm_led    - 1:0] tm_led;
    wire  [w_tm_digit  - 1:0] tm_digit;

    wire                      rst;
    wire                      nrst1;
    wire  [              7:0] abcdefgh;

    logic iclk;
    wire [1:0] shift;
    assign rst      = tm_key [w_tm_key - 1];

    assign tm_key_w = tm_key;

    assign rst_n = ~rst;

	LCD_TEST u0 
	(
		.iclk    ( clk_27   ),
		.irst    ( rst_n    ),
		.LCD_DATA( LCD_DATA ),
		.LCD_RW  ( LCD_RW   ),
		.LCD_EN  ( LCD_EN   ),
		.LCD_RS  ( LCD_RS   )
	);

//	LCD_TEST_4 
//    #(
//        .w_key   ( w_tm_key)  // The last key is used for a reset
//    )
//    u1
//	(
//		.iclk    ( clk_27   ),
//		.irst    ( rst_n    ),
//		.LCD_DATA( LCD_DATA ),
//		.LCD_RW  ( LCD_RW   ),
//		.LCD_EN  ( LCD_EN   ),
//		.LCD_RS  ( LCD_RS   ),
//        .key     ( tm_key_w )
//	);

    //------------------------------------------------------------------------

    wire [$left (abcdefgh):0] hgfedcba;

    generate
        genvar i;

        for (i = 0; i < $bits (abcdefgh); i ++)
        begin : abc
            assign hgfedcba [i] = abcdefgh [$left (abcdefgh) - i];
        end
    endgenerate

    //------------------------------------------------------------------------

    tm1638_board_controller
    #(
        .w_digit    ( w_tm_digit    )
    )
    i_tm1638
    (
        .clk        ( clk_27        ),
        .rst        ( rst           ),
        .hgfedcba   ( hgfedcba      ),
        .digit      ( tm_digit      ),
        .ledr       ( tm_led        ),
        .keys       ( tm_key        ),
        .sio_clk    ( GPIO_0[2]     ),
        .sio_stb    ( GPIO_0[3]     ),
        .sio_data   ( GPIO_0[1]     )
    );

endmodule