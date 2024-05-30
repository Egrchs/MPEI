package fifo_sim_pkg;
    parameter DATASIZE = 8;
    parameter ADDRSIZE = 8;

    localparam real CLK_RD_PERIOD = 5;
    localparam real CLK_WR_PERIOD = 5;

    localparam int min_data_val = 0;
    localparam int max_data_val = 2**DATASIZE - 1;

endpackage