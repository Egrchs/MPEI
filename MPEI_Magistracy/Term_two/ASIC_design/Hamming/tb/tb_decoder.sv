`include "decoder.sv"
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
logic  [n:0] d_i ;
logic  [K-1:0] q_o;
logic  [m-1:0] syndrome_o;
logic  sb_err_o ;
logic  db_err_o ;
logic  sb_fix_o ;

//Module instantiation (just connect the declared signals)
decoder #(K) U_decoder
(
    .d_i (d_i),
    .q_o (q_o),
    .syndrome_o (syndrome_o),
    .sb_err_o(sb_err_o),
    .db_err_o(db_err_o),
    .sb_fix_o(sb_fix_o)
    );

// assign value to input data
initial begin
    // d_i = 13'b0110_0010_1101_0; // две ошибки 
    d_i = 13'b0000_0110_1101_0; // одна ошибка 
    // d_i =    13'b0000_0010_1101_0; // без ошибок
    #1 $display("d_i = %b", d_i);
    #1 $display("q_o = %b",q_o);
    #1 $display("syndrom = %b",syndrome_o);
    #1 $display("sb_err = %b",sb_err_o);
    #1 $display("db_err = %b",db_err_o);
    #1 $display("sb_fix = %b",sb_fix_o);
    end


 initial begin
   $dumpfile("decoder.vcd");
   $dumpvars;
   #100
   $finish();
 end

endmodule