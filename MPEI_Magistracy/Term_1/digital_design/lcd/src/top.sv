module top 
#(
	parameter 	BIT_RATE     = 9600,
	parameter   CLK_HZ       = 27_000_000,
	parameter   PAYLOAD_BITS = 8,
    parameter   LCD_DATA_W   = 8
) 
(
    input  logic                                CLK_I,
    input  logic                                RST_N_I,
    input  logic                                RX_D_I,
    input  logic                                RX_EN_I = '1,
    output logic                                LCD_RW_O,
    output logic                                LCD_EN_O,
    output logic                                LCD_RS_O,
    output logic        [LCD_DATA_W - 1 : 0]    LCD_DATA_O
);


    logic [ PAYLOAD_BITS - 1 : 0 ] rx_data_w;
    logic [ PAYLOAD_BITS - 1 : 0 ] bb_data_w;

    logic                          rx_valid_w;
    logic                          rx_break_w;

    lcd
    #(
        .PAYLOAD_BITS (PAYLOAD_BITS)
    )
    i_lcd
    (
        .CLK_I        ( CLK_I      ),
        .RST_N_I      ( RST_N_I    ),
        .LCD_DATA_I   ( bb_data_w  ),
        .LCD_DATA_O   ( LCD_DATA_O ),
        .LCD_RW_O     ( LCD_RW_O   ),
        .LCD_EN_O     ( LCD_EN_O   ),
        .LCD_RS_O     ( LCD_RS_O   )
    );

    black_box
    #(
        .PAYLOAD_BITS(PAYLOAD_BITS)
    ) 
    i_black_box 
    (
        .CLK_I         ( CLK_I        ),
        .RST_N_I       ( RST_N_I      ),
        .DATA_I        ( rx_data_w    ),
        .BB_READY_I    ( rx_valid_w   ),
        .DATA_O        ( bb_data_w    )
    );

    uart_rx
    #(
        .BIT_RATE      ( BIT_RATE     ),
        .CLK_HZ        ( CLK_HZ       ),
        .PAYLOAD_BITS  ( PAYLOAD_BITS )
    ) 
    i_uart_rx 
    (
        .CLK_I         ( CLK_I        ),          
        .RST_N_I       ( RST_N_I      ),       
        .RX_D_I        ( RX_D_I       ),     
        .RX_EN_I       ( RX_EN_I      ),   
        .RX_BREAK_O    ( rx_break_w   ),
        .RX_VLD_O      ( rx_valid_w   ),
        .RX_D_O        ( rx_data_w    )
    );

endmodule