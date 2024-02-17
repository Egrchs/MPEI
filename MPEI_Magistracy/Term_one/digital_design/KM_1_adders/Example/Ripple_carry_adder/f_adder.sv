module f_adder (A,B,P,S,C);
    input  logic   A;
    input  logic   B;
    input  logic   P;
    output logic   S;
    output logic   C;
    
    assign {C, S}= A+B+P;
endmodule 

