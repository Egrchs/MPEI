`include "carry_lookahead_adder.sv"
`timescale 1 ps/ 1 ps
module carry_lookahead_adder_tb
    #(
        parameter W = 16 
    );
    logic               CLK_i;
    logic               rst_n_i;

    logic [ W-1 : 0 ]   A_i;
    logic [ W-1 : 0 ]   B_i;
    logic [ W-1 : 0 ]   S_o;
    logic [ W   : 0 ]   full_add;
    logic               P_i; 
    logic               C_o; 
           
    carry_lookahead_adder 
    #( .W(W) 
    )
    UUT (.CLK_i(CLK_i), .rst_n_i(rst_n_i), 
         .A_i(A_i), .B_i(B_i), .P_i(P_i), 
         .S_o(S_o), .C_o(C_o), .full_add(full_add)
    );
        initial begin
            $display("Running testbench");
            CLK_i = 0;
            A_i   = 0;
            B_i   = 0;
            P_i   = 0;
        end
        always #5  CLK_i =  !CLK_i; 

        initial begin
            rst_n_i = 1;
            repeat (2) #1 rst_n_i = !rst_n_i;
            end      
        initial begin
            for (int i = 0; i <= 2**W; i++) begin
              A_i = $urandom_range(0, 2**W);
              B_i = $urandom_range(0, 2**W);;   
              P_i = $urandom_range(0, 1);
              #10;                     
            end
        end
        initial begin
            #50000 $display("Testbench is OK!");
                   $finish;
        end

        initial begin
            $dumpfile("qqq.vcd");
            $dumpvars;
        end
endmodule