module carry_lookahead_generator 
    #(
        parameter WIDTH = 8
    ) 
    (
        input  logic              carry_in,
        input  logic [WIDTH-1:0]  gen_in, prop_in,
        output logic [WIDTH:0  ]  carry,
        output logic              group_gen,
        output logic              group_prop   
    );
    
    logic [WIDTH-1:0]  g_temp;
    logic [WIDTH-2:0]  p_temp;

    assign carry[0] = carry_in;

    generate
        genvar i;
        for ( i=0; i <= WIDTH-1; i++) begin
            assign carry[i+1] = gen_in[i] | prop_in[i] & carry[i];
            case (i)
                WIDTH-1 :
                 assign g_temp[i] = gen_in[i];
            default: begin
                 assign p_temp[i] = & prop_in[WIDTH-1 : i+1];
                 assign g_temp[i] = p_temp[i]& gen_in[i]; 
                end
            endcase   
        end
    endgenerate

    assign group_gen = | g_temp;
    assign group_prop = & prop_in;

endmodule