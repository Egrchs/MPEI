`timescale 1ns/1ns
`define WAVES_FILE "dump/wave.vcd"
module tb

    #(
        parameter	CLK_FRE      = 27,    	//Mhz
        parameter	UART_FRE     = 9600,   //Mhz
        parameter   PAYLOAD_BITS = 8
    );

    logic	         CLK_I;
    logic	         RST_N_I;
    logic [19 : 0]	 CORNER_I;
    logic [31 : 0]   SPEED_I;
    logic            START_I;
    logic            STARTD_I;
    logic [7 : 0]    DATA_O;

    top
    #(
        .CLK_FRE      ( CLK_FRE      ),
        .UART_FRE     ( UART_FRE     ),
        .PAYLOAD_BITS ( PAYLOAD_BITS )
    ) 
    UUT 
    (
        .CLK_I   ( CLK_I    ),
        .RST_N_I ( RST_N_I  ),
        .CORNER_I( CORNER_I ),
        .SPEED_I ( SPEED_I  ),
        .START_I ( START_I  ),
        .STARTD_I( STARTD_I ),
        .DATA_O  ( DATA_O   )
    );
    always #5 CLK_I = ~CLK_I;
    initial begin
        CLK_I       = 1;
        RST_N_I     = 1;
        START_I     = 1;
        STARTD_I    = 1;
        SPEED_I     = 32'b000000_1111_1111_0000_0000_0000_0000_00; 
        CORNER_I    = 20'b0010_0001_0111_1000_1101; //30 град в радианах
        #10 RST_N_I = 0;
        #10 RST_N_I = 1;
        #10 STARTD_I = 0;
    end
    
    initial begin
        $dumpfile(`WAVES_FILE);
        $dumpvars;
        #1000
        $finish();
     end   

endmodule