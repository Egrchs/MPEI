module encoder #(
    parameter K       = 8, //длина слова
    parameter m = calculate_m(K),
    parameter n = m + K
  )
  (
    input  logic [ K-1: 0] d_i,      //вводимое слово
    output logic [ n  : 0] q_o,      //закодированное слово 
    output logic [ m  : 1] p_o,      //биты четности
    output logic         p0_o        //общий бит четности
  );
  
  
  //---------------------------------------------------------
  // функции
  //---------------------------------------------------------
  function integer calculate_m; // вычисление количества битов четности 
  input integer k;

  integer m;
begin
  m=1;
  while (2**m < m+k+1) m++;

  calculate_m = m;
end
endfunction 
  
  function [n:1] store_dbits_in_codeword; // распоожение вводимых данных в закодированном слове 
    input [K-1:0] d;
  
    integer bit_idx, cw_idx;
  begin
      store_dbits_in_codeword = 0;
  
      bit_idx=0; 
      for (cw_idx=1; cw_idx<=n; cw_idx++)
        if (2**$clog2(cw_idx) != cw_idx)
          store_dbits_in_codeword[cw_idx] = d[bit_idx++];
  end
  endfunction 
  
  
  function [m:1] calculate_p;  // вычисление битов четности  
    input [n:1] cw;
  
    integer p_idx, cw_idx;
  begin
      
      calculate_p = 0;
  
      for (p_idx =1; p_idx <=m; p_idx++)  
      for (cw_idx=1; cw_idx<=n; cw_idx++) 
        if (|(2**(p_idx-1) & cw_idx)) calculate_p[p_idx] = calculate_p[p_idx] ^ cw[cw_idx];
  end
  endfunction 
  
  
  function [n:1] store_p_in_codeword; // расположение битов четнотси в закодированном слове 
    input [n:1] cw;
    input [m:1] p;
  
    integer i;
  begin
      store_p_in_codeword = cw;
      for (i=1; i<=m; i=i+1)
        store_p_in_codeword[2**(i-1)] = p[i];
  end
  endfunction 
  
 

  logic [n:1] cw_w_dbits; 
  logic [n:1] cw;         
    
  
  
  always_comb begin
    cw_w_dbits = store_dbits_in_codeword(d_i);
    p_o = calculate_p(cw_w_dbits);
    cw = store_p_in_codeword(cw_w_dbits, p_o);
    p0_o = ^cw;
    q_o  = {cw,p0_o};
  end  

  endmodule