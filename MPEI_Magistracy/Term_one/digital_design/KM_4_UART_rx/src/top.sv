module top(
    logic CLK_I,
    logic RST_N_I
);

    logic [7 : 0] data_reg;
    logic [7 : 0] data_reg_one;

    uart_rx uart(
        .clk           ( CLK_I        ),       // Системный тактовый сигнал
        .resetn        ( RST_N_I      ),       // Асинхронный глобальный сброс (активный уровень 0)
        .uart_rxd      (              ),       // Пин принимаемых UART значений
        .uart_rx_en    (              ),       // Разрешение приёма данных
        .uart_rx_break (              ),       // Было ли получено сообщение прерывании приёма?
        .uart_rx_valid (              ),       // Получены и доступны достоверные данные
        .uart_rx_data  ( data_reg     ),       // Принятые данные
    );
    
    dumpy dump(
        .data          ( data_reg_one ),
        .data_out      (              ),
    );

    lcd1602 lcd1602(
        .iclk          ( CLK_I        ),
        .irst          ( RST_N_I      ),
        .data_out      (              ),
        .data_out      (              ),
    )

endmodule