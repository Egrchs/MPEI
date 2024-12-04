`include "ripple_carry_adder.sv"
`timescale 1 ps/ 1 ps

module ripple_carry_adder_tb
    #(
        parameter W = 8 
    );

    logic               CLK_i;
    logic               RST_N_I;

    logic [ W-1 : 0 ]   A_i;
    logic [ W-1 : 0 ]   B_i;
    logic [ W-1 : 0 ]   S_o;
    logic [ W   : 0 ]   full_add;
    logic               P_i; 
    logic               C_o; 
           
    ripple_carry_adder
    #( .W(W) 
    )
    UUT (.CLK_i(CLK_i), .RST_N_I(RST_N_I), 
         .A(A_i), .B(B_i), .carry_in(P_i), 
         .S(S_o), .carry_out(C_o), .full_add(full_add)
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
            RST_N_I = 1;
            repeat (2) #1 RST_N_I = !RST_N_I;
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