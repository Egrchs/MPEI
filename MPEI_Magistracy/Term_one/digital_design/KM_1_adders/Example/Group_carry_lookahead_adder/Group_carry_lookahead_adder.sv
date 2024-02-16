
`include "carry_lookahead_adder_4.sv"
module Group_carry_lookahead_adder
    #(
        parameter WIDTH = 16
    ) 
    ( 
        input  logic [ WIDTH-1 : 0 ] A_i,
        input  logic [ WIDTH-1 : 0 ] B_i,
        input  logic                 P_i,
        output logic [ WIDTH-1 : 0 ] S_o,
        output logic                 C_o
        
    );

    

     logic [ (WIDTH/4)   : 0 ] Carry;
	 logic [ (WIDTH/4)-1   : 0 ] GG;
	 logic [ (WIDTH/4)-1   : 0 ] PG;

    
    generate
    genvar i;
        for (i = 0; i <= (WIDTH/4 - 1); i = i + 1) begin : stage
             
				carry_lookahead_adder_4
      
	UUT1(
        .A(A_i[(i+1)*4-1:i*4]),
        .B(B_i[(i+1)*4-1:i*4]),
        .C_i(Carry[i]),
        .S(S_o[(i+1)*4-1:i*4]),
        .group_gen(GG[i]),
        .group_prop(PG[i])
    );
        end
		  
    endgenerate

    
    
     carry_lookahead_generator 
    #(
        .WIDTH(WIDTH/4)
    )
    UUT2(
        .carry_in(P_i),
        .gen_in(GG),
        .prop_in(PG),
        .carry(Carry),
        .group_gen(),
        .group_prop()
    );
    
assign C_o = Carry[WIDTH/4];

endmodule