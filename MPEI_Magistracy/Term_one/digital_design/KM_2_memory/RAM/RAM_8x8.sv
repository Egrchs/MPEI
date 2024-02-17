module RAM_8x8 
#(
    parameter  DATA_WIDTH = 8,
    parameter  ADDR_WIDTH = 8
) 
(
    input   logic                               CLK_I, 
    input   logic                               WE_I, 
    input   logic [ ADDR_WIDTH - 1 : 0 ]        ADDR_I,
    input   logic [ DATA_WIDTH - 1 : 0 ]        DATA_I,
    output  logic [ DATA_WIDTH - 1 : 0 ]        DATA_O,
    output  logic [ ADDR_WIDTH - 1 : 0 ]        ADDR_O   
);

    logic [ DATA_WIDTH - 1 : 0 ] RAM [ 0 : 2**ADDR_WIDTH - 1 ];

    logic [ ADDR_WIDTH - 1 : 0 ] addr_reg;
    
    initial begin
        $readmemb("RAM_8x8.txt",RAM);
    end
 
    always_ff @(posedge CLK_I ) begin
        if (WE_I) begin
            RAM[ADDR_I] <= DATA_I;
        end
        addr_reg <= ADDR_I;
    end

    always_comb begin
        DATA_O = RAM[addr_reg];
        ADDR_O = addr_reg;
    end

endmodule