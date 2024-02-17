module top 
#( 
    parameter   clk_mhz    = 27,
                w_tm_key   = 8,  // The last key is used for a reset
                w_tm_led   = 8,
                w_tm_digit = 8
)
( 	
    inout   logic [7:0] GPIO_0,
 	input	logic		clk_27		// тактовый сигнал 27 МГц
);	

    wire  [ w_tm_key    - 1:0 ] tm_key;
    wire  [ w_tm_key    - 1:0 ] tm_key_w;
    wire  [ w_tm_led    - 1:0 ] tm_led;
    wire  [ w_tm_digit  - 1:0 ] tm_digit;
    wire  [               7:0 ] abcdefgh;
    wire  [               3:0 ] shift;
    wire                        rst;
    wire                        iclk;
    wire                        slow_clk;

    assign rst      = tm_key [w_tm_key - 1];
    assign tm_key_w = tm_key;
    assign rst_n    = ~rst;

    clk_div
    clk_div_U
    (
        .clk_27   ( clk_27     ),
        .rst      ( rst_n      ),
        .slow_clk ( slow_clk   )
    );
		  
    shifter  
    shifter_U
    ( 
        .clk      ( clk_27     ),
        .nrst     ( rst_n      ),
        .shift    ( shift      )
    );

    sev_seg
    #(
        .clk_mhz  ( clk_mhz    ),
        .w_key    ( w_tm_key   ),  // The last key is used for a reset
        .w_led    ( w_tm_led   ),
        .w_digit  ( w_tm_digit )
    )
    sev_seg_U
    (
        .clk      ( slow_clk   ),
        .shift    ( shift      ),
        .rst      ( rst_n      ),

        .key      ( tm_key     ),

        .cathodes ( abcdefgh   ),
        .anodes   ( tm_digit   )
    );
    
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