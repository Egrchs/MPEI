module ROM_32x8 
#(
    parameter  WIDTH = 32,
    parameter  DEPTH = 8	           
) 
(
    input   logic [DEPTH-1:0]                Addr,
    input   logic                            Re,
    input   logic                            clk,
    output  logic [WIDTH-1:0]                Dataout   
);
    
    logic [WIDTH - 1 : 0] ROM [2**DEPTH];
    
    initial begin
     $readmemb("ROM_32x8.txt",ROM);
     end
 
    always_ff @(posedge clk ) begin
        if (Re) 
            Dataout <= ROM[Addr];
    end

endmodule