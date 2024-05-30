`define WAVES_FILE "dump/wave.vcd"

import fifo_sim_pkg::*;

localparam DEPT_FIFO = 1 << ADDRSIZE;

module tb #(
    parameter DATASIZE = 8,
              ADDRSIZE = 4
) 
(
);
    logic [DATASIZE - 1 : 0] wdata_i;   
    logic                    wfull_o;   
    logic                    winc_i;      
    logic                    wclk_i;         
    logic                    wrst_n_i;          
    logic [DATASIZE - 1 : 0] rdata_o;       
    logic                    rinc_i;           
    logic                    rclk_i;             
    logic                    rrst_n_i;         
    logic                    rempty_o;         
    logic                    arempty_o; 

    int MIN_RST_TIME = 100;
    int MAX_RST_TIME = 150;

    int wrst_time;
    int rrst_time;
    int cnt_data_send;

    // PLUSARGS
    int TGL_WRST_N = 1;
    int TGL_RRST_N = 1;
    int QTY_DATA   = 5;
    int TEST       = 0; 

    logic [DATASIZE - 1 : 0] wr_data_q [$];
    logic [DATASIZE - 1 : 0] rd_data_q [$];

    top 
    #(
        .DATASIZE  ( DATASIZE  ),
        .ADDRSIZE  ( ADDRSIZE  )
    )
    UUT
    (
        .WDATA_I   ( wdata_i   ), 
        .WFULL_O   ( wfull_o   ),
        .WINC_I    ( winc_i    ),  
        .WCLK_I    ( wclk_i    ),  
        .WRST_N_I  ( wrst_n_i  ),
        .RINC_I    ( rinc_i    ),  
        .RCLK_I    ( rclk_i    ),  
        .RRST_N_I  ( rrst_n_i  ),
        .RDATA_O   ( rdata_o   ), 
        .REMPTY_O  ( rempty_o  ),
        .AREMPTY_O ( arempty_o )
    );
    
    initial begin
        wdata_i   = 0;   
        winc_i    = 0;   
        wclk_i    = 0;   
        rinc_i    = 0;   
        rclk_i    = 0;   
        winc_i    = 0;
        rinc_i    = 0;
    end

    task gen_clk_rd();
        forever begin
            #(CLK_RD_PERIOD / 2.0) rclk_i = ~rclk_i; //generate clk_rd signal
        end
    endtask

    task gen_clk_wr();
        forever begin
            #(CLK_WR_PERIOD / 2.0) wclk_i = ~wclk_i; //generate clk_wr signal
        end
    endtask

    task gen_wrst_n();
        wrst_n_i  = 0; 
        #10
        wrst_n_i  = 1; 
        #10
        wrst_n_i  = 0;
        #10

        case (TGL_WRST_N)
            0 : begin
                wrst_n_i = 0;
            end
            1 : begin
                wrst_n_i = 1;
            end
            2 : forever begin
                wrst_time = $urandom_range(MIN_RST_TIME, MAX_RST_TIME);
                wrst_n_i = 0;
                #wrst_time;
                wrst_n_i = 1;
                #wrst_time;
            end 
            default: begin
            end
        endcase
    endtask

    task gen_rrst_n();
        rrst_n_i  = 0;
        #10 
        rrst_n_i  = 1;
        #10
        rrst_n_i  = 0;
        #10

        case (TGL_RRST_N)
            0 : begin
                rrst_n_i = 0;
            end
            1 : begin
                rrst_n_i = 1;
            end
            2 : forever begin
                rrst_time = $urandom_range(MIN_RST_TIME, MAX_RST_TIME);
                rrst_n_i = 0;
                #rrst_time;
                rrst_n_i = 1;
                #rrst_time;
            end 
            default: begin
            end
        endcase
    endtask

    task rd_data();
        forever @(posedge rclk_i) begin
            rd_data_q.push_back(rdata_o);
            $display("rd_data = %0d ", rd_data_q.pop_front());
        end
    endtask
    
    task gen_data();
        forever @(posedge wclk_i) begin
            wdata_i = $urandom_range(fifo_sim_pkg::min_data_val, fifo_sim_pkg::max_data_val);
            // wr_data_q.push_back(wdata_i);
            $display("wr_data == %0d", wdata_i);
            cnt_data_send++;
        end
    endtask

    initial begin
        fork
            gen_clk_wr();
            gen_clk_rd();
            gen_wrst_n();
            gen_rrst_n();
            gen_data();
            rd_data();
            en_test();
            // check_data();
        join_none
    end

    task en_test();
        forever @(posedge wclk_i) begin
            case (TEST)
                0 : begin
                    winc_i = 1;
                    if(cnt_data_send == 5) begin
                        winc_i = 0;
                        rinc_i = 1;
                        #500;
                        rinc_i = 0;
                    end
                end 
                default: begin
                $fatal;
                end
            endcase
        end
    endtask

    initial begin
        $dumpfile(`WAVES_FILE);
        $dumpvars;
        #1000 $finish();
    end
endmodule