module top
    #(
        parameter	CLK_FRE      = 27_000_000,    	//Mhz
        parameter	UART_FRE     = 9600,    //Mhz
        parameter   PAYLOAD_BITS = 8
    )
    (
        input 	logic	         CLK_I,
        input 	logic	         RST_N_I,

        input   logic            RX_D_I,
        input   logic            RX_EN_I,
        input   logic            RX_BREAK_O,
        // output  logic            RX_VLD_O,
        // output  logic [7  : 0]   RX_D_O,
        output  logic [7  : 0]   DATA_O
    );

        logic [ 31 : 0 ] sin_w;
        logic [ 19 : 0 ] cos_w;
        logic [ 63 : 0 ] mult_res;
        logic [ 31 : 0 ] quotinent;
        logic [  7 : 0 ] arcsin_res;
        logic            done_w;

        logic [ 7  : 0 ] reg_X0;
        logic [ 7  : 0 ] reg_X1 = 8'd200; 
        logic [ 7  : 0 ] reg_subtr; 

        logic [ 32 : 0 ] reg_speed;
        logic [ 19 : 0 ] reg_corner;

        logic [  3 : 0 ] cnt_trans;

        logic            rx_vld_w;
        logic [  7 : 0 ] rx_data_w;

        logic            reg_corner_vld;
        logic            reg_speed_vld;

        always_comb begin : subtaction 
            reg_subtr = reg_X1 - reg_X0;
        end

        assign DATA_O = arcsin_res;
        

        always_ff@(posedge CLK_I, negedge RST_N_I) begin
            if(!RST_N_I) begin
                reg_speed  <= '0;
                reg_corner <= '0;
                cnt_trans  <= '0; 
            end
            else begin
                if(rx_vld_w) begin
                    reg_speed_vld  <= '0;
                    reg_corner_vld <= '0;
                    cnt_trans      <= cnt_trans + 1'b1;
                    case (cnt_trans)
                        4'd0: reg_speed  <= {rx_data_w};  
                        4'd1: reg_speed  <= {reg_speed[7 :0], rx_data_w};
                        4'd2: reg_speed  <= {reg_speed[16:0], rx_data_w}; 
                        4'd3: begin
                            reg_speed     <= {reg_speed[25:0], rx_data_w};
                            reg_speed_vld <= 1'b1;
                        end    
                        4'd4: reg_corner <= {rx_data_w};                            
                        4'd5: reg_corner <= {reg_corner[7 :0], rx_data_w}; 
                        4'd6: reg_corner <= {reg_corner[16:0], rx_data_w};
                        4'd7: begin
                            reg_corner     <= {reg_corner[25:0], rx_data_w};
                            reg_corner_vld <= 1'b1;
                        end    
                        4'd8: reg_subtr  <= rx_data_w;
                        default: begin
                            reg_speed      <= '0;
                            reg_corner     <= '0;
                            reg_subtr      <= '0;
                            reg_speed_vld  <= '0;
                            reg_corner_vld <= '0;
                        end
                    endcase
                end
            end
        end

        uart_rx_AD
        #(
            .BIT_RATE     ( UART_FRE     ),    
            .CLK_HZ       ( CLK_FRE      ),      
            .PAYLOAD_BITS ( PAYLOAD_BITS )
        )
        uart_rx_inst
        (
            .CLK_I         ( CLK_I        ),      
            .RST_N_I       ( RST_N_I      ),    
            .RX_D_I        ( RX_D_I       ),     
            .RX_EN_I       ( RX_EN_I      ),    
            .RX_BREAK_O    ( RX_BREAK_O   ), 
            .RX_VLD_O      ( rx_vld_w     ), 	
            .RX_D_O        ( rx_data_w    )	
        );

        cordic
        #(
        
        )
        cordic_inst
        (
            .CLK_I   ( CLK_I          ),
            .RST_N_I ( RST_N_I        ),
            .Z0_I    ( reg_corner     ),
            .READY_I ( reg_corner_vld ),
            .COS_O   (                ),
            .SIN_O   ( sin_w          ),
            .DONE_O  ( done_w         )
        );

        divu 
        #(
            .WIDTH(32),
            .FBITS(18) 
        )
        divu_inst 
        (        
            .CLK_I        ( CLK_I         ),     
            .RST_N_I      ( RST_N_I       ),     
            .READY_I      ( reg_speed_vld ),     
            .DIVIDEND_I   ( reg_speed     ),     
            .DIVISOR_I    ( 32'b000000_1100_1000_0000_0000_0000_0000_00 ), // 200
            .BUSY_O       (               ),     
            .DONE_O       (               ),     
            .VLD_O        (               ),     
            .DBZ_O        (               ),     
            .OVF_O        (               ),     
            .QUOTIENT_O   ( quotinent     )      
        );

        multu
        #(
            .Q(18),
            .N(32)
        )
        multu_inst
        (
            .mul1  ( quotinent ),
            .mul2  ( sin_w     ),
            .result( mult_res  )
        );

        arcsin
        #(

        )
        arcsin_inst
        (
            .CLK_I        ( CLK_I       ),
            .RST_N_I      ( RST_N_I     ),
            .DATA_I       ( mult_res    ),
            .DATA_O       ( arcsin_res)
        );
endmodule