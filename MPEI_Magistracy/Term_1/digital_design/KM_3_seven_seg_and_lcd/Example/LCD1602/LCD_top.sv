module LCD_top
( 	
	input	logic		clk_50,		// тактовый сигнал 50 МГц
	output	logic		LCD_RW,		// выбор режима чтения / записи: 0 - чтение, 1 - запись
	output	logic		LCD_EN,		// LCD включён
	output	logic		LCD_RS,		// выбор режима команды / данные: 0 - команды, 1 - данные
	output	logic [7:0]	LCD_DATA    // шина данных 8-битная
);	

	logic			dly_rst;

	//модуль задержки перезагрузки
	ResetDelay r0 (.iclk(clk_50), .orst(dly_rst));

	LCD_TEST u0 
	(
		//со стороны ПЛИС
		.iclk    ( clk_50   ),
		.irst    ( dly_rst  ),
		//со стороны LCD
		.LCD_DATA( LCD_DATA ),
		.LCD_RW  ( LCD_RW   ),
		.LCD_EN  ( LCD_EN   ),
		.LCD_RS  ( LCD_RS   )
	);

endmodule