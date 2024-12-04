module ROM_8x8 
    #(
        parameter  DATA_WIDTH = 8,
        parameter  ADDR_WIDTH = 8	           
    ) 
    (
        input   logic                                       RE_I,
        input   logic                                       CLK_I,
        input   logic [ ADDR_WIDTH - 1 : 0 ]                ADDR_I,
        output  logic [ DATA_WIDTH - 1 : 0 ]                DATA_O,
        output  logic [ ADDR_WIDTH - 1 : 0 ]                ADDR_O   	 
    );
        
        logic [ DATA_WIDTH - 1 : 0 ] ROM [ 0 : 2**ADDR_WIDTH - 1];
    
        logic [ ADDR_WIDTH - 1 : 0 ] addr_reg; 
        
        initial begin
            $readmemb("ROM_8x8.txt", ROM);
        end
     
        always_ff @(posedge CLK_I) begin
            if (RE_I) begin
                addr_reg <= ADDR_I;
            end
            DATA_O <= ROM[addr_reg];
            ADDR_O <= addr_reg;
        end
         
endmodule