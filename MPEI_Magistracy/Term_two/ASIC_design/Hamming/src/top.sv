module top #(
    parameter K       = 8, //длина слова
    parameter m = calculate_m(K),
    parameter n = m + K
  )
  (
    input  logic [ K-1: 0] d_i,      //вводимое слово
    output logic [K-1:0] q_o,        //декодированное слово
    output logic [m-1:0] syndrome_o, //синдром
    output logic         sb_err_o,   //одиночная ошибка
    output logic         db_err_o,   //двойная ошибка 
    output logic         sb_fix_o    //исправленная ошибка 
  );

  //---------------------------------------------------------
  // функции
  //---------------------------------------------------------
  function integer calculate_m(input integer k); // вычисление количества битов четности 
    integer m;
  begin
    m=1;
    while (2**m < m+k+1) m++;
  
    calculate_m = m;
  end
  endfunction 

// signal declaration
  logic [  n  :0] q;
  logic [  m  :1] p;
  logic         p0;


//Module instantiation (just connect the declared signals)
  encoder #(K) U_encoder
  (
   .d_i (d_i),
   .q_o (q),
   .p_o (p),
   .p0_o(p0)
   );

  decoder #(K) U_decoder
  (
    .d_i (q),
    .q_o (q_o),
    .syndrome_o (syndrome_o),
    .sb_err_o(sb_err_o),
    .db_err_o(db_err_o),
    .sb_fix_o(sb_fix_o)
    );

endmodule