`timescale 1ns/1ns
`define WAVES_FILE "../dump/wave.vcd"

module tb
#(
	parameter 	BIT_RATE     = 9600,
				CLK_HZ       = 27_000_000,
                PAYLOAD_BITS = 8
);
    
logic       clk        ; // Системный синхросигнал
logic       rst_n_i    ; // Глобальный сброс
logic       rx_d_i     ; // Пин принимаемых UART данных

logic       uart_rx_en   ; // Передача разрешающего сигнала

logic [7:0] data_o ; // Принятые данные

    // Скорость передачи данных UART в тесте
    // localparam BIT_RATE = 9600; // поменять на 9600, если исходный мдуль синтезируется (например в Quartus)
    localparam BIT_P    = (1_000_000_000 /BIT_RATE);

    // Задание периода и частоты системного тактового сигнала
    // localparam CLK_HZ   = 27_000_000;
    localparam CLK_P    = 1_000_000_000 / CLK_HZ;

    // Определение тактового сигнала
    always begin #(CLK_P/2)  clk    = ~clk; end

    // Отправка одиночного байта данных по UART
    task send_byte;
        input [7:0] to_send;
        int i;
        begin
            #BIT_P;  rx_d_i = 1'b0;
            for(i=0; i < 8; i++) begin
                #BIT_P;  rx_d_i = to_send[i];
            end
            #BIT_P;  rx_d_i = 1'b1;
            #1000;
        end
    endtask

    // Проверка того, что принятые UART данные соответствуют передаваемым (ожидаемым)
    int passes = 0;
    int fails  = 0;
    task check_byte;
        input [7:0] expected_value;
        begin
            if(data_o == expected_value) begin
                passes += 1;
                $display("%d/%d/%d [PASS] Expected %b and got %b", 
                         passes,fails,passes+fails,
                         expected_value, data_o);
            end else begin
                fails  += 1;
                $display("%d/%d/%d [FAIL] Expected %b and got %b", 
                         passes,fails,passes+fails,
                         expected_value, data_o);
            end
        end
    endtask

    // Запуск теста
    logic [7:0] to_send;
    initial begin
        rst_n_i  = 1'b0;
        clk     = 1'b0;
        rx_d_i = 1'b1;
        #40 rst_n_i = 1'b1;

        $dumpfile(`WAVES_FILE);
        $dumpvars(0,tb);

        uart_rx_en = 1'b1;

        #1000;

        repeat(10) begin
            to_send = $random;
            send_byte(to_send); check_byte(to_send);
        end

        $display("BIT RATE      : %db/s", BIT_RATE );
        $display("CLK PERIOD    : %dns" , CLK_P    );
        // $display("CYCLES/BIT    : %d"   , i_uart_rx.CYCLES_PER_BIT);
        // $display("SAMPLE PERIOD : %d", CLK_P *i_uart_rx.CYCLES_PER_BIT);
        $display("BIT PERIOD    : %dns" , BIT_P    );

        $display("Test Results:");
        $display("    PASSES: %d", passes);
        $display("    FAILS : %d", fails);

        $display("Finish simulation at time %d", $time);
        $finish();
    end

    // Экземпляр тестируемого устройства
    top 
    #(
        .BIT_RATE     (BIT_RATE     ),
        .CLK_HZ       (CLK_HZ       ),
        .PAYLOAD_BITS (PAYLOAD_BITS )
    ) 
    top_module
    (
        .CLK_I        ( clk        ),
        .RST_N_I      ( rst_n_i    ),
        .RX_D_I       ( rx_d_i     ),
        .RX_EN_I      ( uart_rx_en ),
        .LCD_RW_O     (            ),
        .LCD_EN_O     (            ),
        .LCD_RS_O     (            ),
        .LCD_DATA_O   ( data_o     )
    );

endmodule