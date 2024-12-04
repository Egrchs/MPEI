`include "encoder.sv"
`timescale 1ns/1ps 

module tb_encoder#(
    parameter K       = 8, //Information bit vector size
    parameter m = calculate_m(K) ,
    parameter n = m + K)
    ();

  //---------------------------------------------------------
  // Functions
  //---------------------------------------------------------
    function integer calculate_m;
    input integer k;
  
    integer m;
  begin
    m=1;
    while (2**m < m+k+1) m++;
  
    calculate_m = m;
  end
  endfunction 




// signal declaration
    logic [  K-1:0] d_i;
    logic [  n  :0] q_o;
    logic [  m  :1] p_o;
    logic         p0_o;


//Module instantiation (just connect the declared signals)
encoder #(K) U_encoder
(
    .d_i (d_i),
    .q_o (q_o),
    .p_o (p_o),
    .p0_o(p0_o)
    );

// assign value to input data
initial begin
    d_i = 8'b0000_0101;
    #1 $display("d_i = %b", d_i);
    #1 $display("d_o = %b",q_o);
    #1 $display("p_o = %b",p_o);
    #1 $display("p0_o = %b",p0_o);
    end


 initial begin
   $dumpfile("encoder.vcd");
   $dumpvars;
   #100
   $finish();
 end

endmodule