module RAM_32x8 
#(
    parameter  WIDTH = 32,
    parameter  DEPTH = 8
) 
(
    input   logic [ DEPTH - 1 : 0 ]          Addr,
    input   logic [ WIDTH - 1 : 0 ]          Datain,
    input   logic                            We, 
    input   logic                            clk, 
    output  logic [ WIDTH - 1 : 0 ]          Dataout   
);

    logic [WIDTH-1:0] RAM [2**DEPTH];
    
    initial begin
     $readmemb("RAM_32x8.txt",RAM);
     end
 
    always_ff @(posedge clk ) begin
        if (!We)
            Dataout <= RAM[Addr];
        else 
            RAM[Addr] <= Datain;
    end

endmodule