module top 
#( 
    parameter   clk_mhz     = 27,
                w_tm_key    = 8,  // The last key is used for a reset
                w_tm_led    = 8,
                w_tm_digit  = 8,
                CNT_WIDTH   = 16
)
( 	
 	input	logic		clk_27,		// тактовый сигнал 27 МГц
    input   logic [4:0] key_on_board,
    input   logic [3:0] sw_on_board,
	output	logic		LCD_RW,		// выбор режима чтения / записи: 0 - чтение, 1 - запись
	output	logic		LCD_EN,		// LCD включён
	output	logic		LCD_RS,		// выбор режима команды / данные: 0 - команды, 1 - данные
	output	logic [7:0]	LCD_DATA    // шина данных 8-битная
);	

    wire  [ w_tm_led     - 1:0 ] tm_led;
    wire  [ w_tm_digit   - 1:0 ] tm_digit;
    wire  [                4:0 ] key_on_board_1;

    wire                         sw_state;
    wire                         sw_down;
    wire                         sw_up;

    assign key_on_board_1 = ~key_on_board;
    assign rst            = key_on_board[4];

	LCD_TEST_4 
    #(
        .w_key   ( 5        )  // The last key is used for a reset
    )
    u1
	(
		.iclk       ( clk_27         ),
		.irst       ( rst            ),
		.LCD_DATA   ( LCD_DATA       ),
		.LCD_RW     ( LCD_RW         ),
		.LCD_EN     ( LCD_EN         ),
		.LCD_RS     ( LCD_RS         ),
        .key        ( key_on_board_1 ),
		.sw_state   (                ),
		.sw_down    (                ),
		.sw_up      (  sw_up         )
	);

    button_debouncer
    #(
        .CNT_WIDTH(CNT_WIDTH)
    )
    u2
    (
		.clk_i       ( clk_27          ),
		.rst_i       ( rst             ),
		.sw_i        ( key_on_board[3] ),
		.sw_state_o  ( sw_state        ),
		.sw_down_o   ( sw_down         ),
		.sw_up_o     ( sw_up           )
	);

endmodule