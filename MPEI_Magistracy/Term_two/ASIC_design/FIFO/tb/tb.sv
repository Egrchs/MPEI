`define WAVES_FILE "dump/wave.vcd"

// import fifo_sim_pkg::*;

module tb #(
    parameter DATASIZE = 8,
              ADDRSIZE = 4,
              ASIZE    = 4
) 
(
);
    // logic [DATASIZE - 1 : 0] wdata_i;   
    // logic                    wfull_o;   
    // logic                    winc_i;      
    // logic                    wclk_i;         
    // logic                    wrst_n_i;          
    // logic                    rinc_i;           
    // logic                    rclk_i;             
    // logic                    rrst_n_i;         
    // logic [DATASIZE - 1 : 0] rdata_o;       
    // logic                    rempty_o;         
    // logic                    arempty_o; 

    // localparam int min_data_val = 0;
    // localparam int max_data_val = 2**DATASIZE - 1;

    // top 
    // #(
    //     .DATASIZE ( DATASIZE ),
    //     .ADDRSIZE ( ADDRSIZE ),
    //     .ASIZE    ( ASIZE    )   
    // )
    // UUT
    // (
    //     .WDATA_I   ( wdata_i   ), 
    //     .WFULL_IO  ( wfull_o   ),
    //     .WINC_I    ( winc_i    ),  
    //     .WCLK_I    ( wclk_i    ),  
    //     .WRST_N_I  ( wrst_n_i  ),
    //     .RINC_I    ( rinc_i    ),  
    //     .RCLK_I    ( rclk_i    ),  
    //     .RRST_N_I  ( rrst_n_i  ),
    //     .RDATA_O   ( rdata_o   ), 
    //     .REMPTY_O  ( rempty_o  ),
    //     .AREMPTY_O ( arempty_o )
    // );

    logic z;
    initial begin
        if( ! $value$plusargs("SEED=%d", z)) begin
          $error("There is NO $value$plusargs");
          $fatal;
        end 
    end
    
    // task gen_clk();
    //      #(CLK_RD_PERIOD / 2.0) rclk_i = ~rclk_i; //generate clk_rd signal
    //      #(CLK_WR_PERIOD / 2.0) wclk_i = ~wclk_i; //generate clk_wr signal
    // endtask

    // task gen_data();
    //     for (int i=0; i<10; ++i) begin
    //         @(posedge wclk_i);
    //         wdata_i = $urandom_range(min_data_val, max_data_val);
    //     end
    // endtask

    // initial begin
    //     wdata_i   = 0;   
    //     winc_i    = 0;   
    //     wclk_i    = 0;   
    //     wrst_n_i  = 0; 
    //     rinc_i    = 0;   
    //     rclk_i    = 0;   
    //     rrst_n_i  = 0; 
    // end
    
    // always gen_clk();

    initial begin
    //     $dumpfile(`WAVES_FILE);
    //     $dumpvars;
        #1000 $finish();
    end
endmodule