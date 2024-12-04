
module decoder #(
    parameter K       = 8, 
    parameter m = calculate_m(K),
    parameter n = m + K
  )
  (
 
    input        [n  :0] d_i,        //закодированное слово
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
  
  
  function [m:1] calculate_syndrome(input [n:0] cw); // вычисление синдрома 
    integer p_idx, cw_idx;
  begin
      calculate_syndrome = 0;
  
      for (p_idx =1; p_idx <=m; p_idx++)  
      for (cw_idx=1; cw_idx<=n; cw_idx++) 
        if (|(2**(p_idx-1) & cw_idx)) calculate_syndrome[p_idx] = calculate_syndrome[p_idx] ^ cw[cw_idx];
  end
  endfunction 
  
  
  function [n:0] correct_codeword(input [n:0] cw, input [m:1] syndrome); // проверка на ошибку 

      correct_codeword = cw;
      correct_codeword[syndrome] = ~correct_codeword[syndrome];
  endfunction 
  
  
  function [K-1:0] extract_q(input [n:0] cw); // декодирование слова 
    integer bit_idx, cw_idx;
  begin

  
      bit_idx=0; 
      for (cw_idx=1; cw_idx<=n; cw_idx++) 
        if (2**$clog2(cw_idx) != cw_idx)
          extract_q[bit_idx++] = cw[cw_idx];
  end
  endfunction 
  
  
  function is_power_of_2(input int n); // проверка на степеньдвойки
      is_power_of_2 = (n & (n-1)) == 0;
  endfunction
  
  
  function information_error(input [m:1] syndrome);  //  информация об ошибке 
  begin
      information_error = |syndrome & !is_power_of_2(syndrome);
  end
  endfunction 
  
  

  logic             parity;      
  logic   [m  :1] syndrome;    
  logic   [n  :0] cw_fixed;    
    
  logic   [n  :0] d;
  logic   [K-1:0] q;
  logic           sb_err;
  logic           db_err;
  logic           sb_fix;
  
  always_comb begin
        d =  d_i ;
        parity = ^d_i;
        syndrome = calculate_syndrome(d);
        cw_fixed = correct_codeword(d, syndrome); 
        cw_fixed = correct_codeword(d, syndrome);
        q_o        = extract_q(cw_fixed);
        syndrome_o = syndrome;
        sb_err_o   = parity & |syndrome;;
        db_err_o   = ~parity & |syndrome;
        sb_fix_o   = parity & |syndrome;
        end
  
  endmodule