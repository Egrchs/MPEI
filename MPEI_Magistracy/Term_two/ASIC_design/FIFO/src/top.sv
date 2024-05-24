module top 
#(
    parameter   DATASIZE = 8,    // Ширина слова
                ADDRSIZE = 4,    // Количество бит адреса
                ASIZE    = 4
) 
(
    input  logic [DATASIZE - 1 : 0] WDATA_I,   
    input  logic                    WFULL_IO,   
    input  logic                    WINC_I,      
    input  logic                    WCLK_I,         
    input  logic                    WRST_N_I,          
    input  logic                    RINC_I,           
    input  logic                    RCLK_I,             
    input  logic                    RRST_N_I,         
    output logic [DATASIZE - 1 : 0] RDATA_O,       
    output logic                    REMPTY_O,         
    output logic                    AREMPTY_O 
);

    logic [ADDRSIZE - 1 : 0 ]       waddr_w;
    logic [ADDRSIZE     : 0 ]       wq2_rptr_w;
    logic [ADDRSIZE     : 0 ]       rq2_wptr_w;
    logic [ADDRSIZE     : 0 ]       wptr_w;
    logic [ADDRSIZE - 1 : 0 ]       raddr_w;
    logic [ADDRSIZE     : 0 ]       rptr_w;
    logic                           wfull_w;
    logic                           wclken_w;
    logic                           rclken_w;

    always_comb begin
        wclken_w = !wfull_w  & WINC_I;
        rclken_w = !REMPTY_O & RINC_I;
    end 
    
    fifo_mem
    #(
        .DATASIZE(DATASIZE),
        .ADDRSIZE(ADDRSIZE)
    )
    fifo_mem_inst
    (
        .wclk     ( WCLK_I     ),
        .wclken   ( wclken_w   ),
        .waddr    ( waddr_w    ),
        .wdata    ( WDATA_I    ),
        .wfull    ( wfull_w    ),
        .rclk     ( RCLK_I     ),
        .rclken   ( rclken_w   ),
        .raddr    ( raddr_w    ),
        .rdata    ( RDATA_O    )
    );

    wptr_full
    #(
        .ADDRSIZE ( ADDRSIZE   )
    )
    wptr_full_inst
    (
        .wclk     ( WCLK_I     ),     
        .wrst_n   ( WRST_N_I   ),       
        .winc     ( WINC_I     ),     
        .wq2_rptr ( wq2_rptr_w ),         
        .wfull    ( wfull_w    ),      
        .awfull   (            ),       
        .waddr    ( waddr_w    ),      
        .wptr     ( wptr_w     )       
    );

    sync_r2w
    #(
        .ADDRSIZE(ADDRSIZE)
    )
    sync_r2w_inst
    (
        .wclk     ( WCLK_I     ),
        .wrst_n   ( WRST_N_I   ),
        .rptr     ( rptr_w     ),
        .wq2_rptr ( wq2_rptr_w ) 
    );

    sync_w2r
    #(
        .ADDRSIZE(ADDRSIZE)
    )
    sync_w2r_inst
    (
        .rclk     ( WCLK_I     ),
        .rrst_n   ( WRST_N_I   ),
        .rq2_wptr ( rq2_wptr_w ),
        .wptr     ( wptr_w     ) 
    );

    rptr_empty
    #(
        .ADDRSIZE(ADDRSIZE)
    )
    rptr_empty_inst
    (
        .rclk     ( RCLK_I     ),     
        .rrst_n   ( RRST_N_I   ),   
        .rinc     ( RINC_I     ),     
        .rq2_wptr ( rq2_wptr_w ), 
        .rempty   ( REMPTY_O   ),   
        .arempty  ( AREMPTY_O  ),  
        .raddr    ( raddr_w    ),    
        .rptr     ( rptr_w     )      
    );
endmodule