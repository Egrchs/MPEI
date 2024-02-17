`include "summator.v"
`include "div_fraction.v"
`include "shift_register_left.v"
`include "shift_register_right.v"
`include "comparator.v"
module ALU_top (clk, res, A, B, out, tvalid, tready);

input                   clk, res;
input                   tvalid;  //вход валидности данных
input                   A, B;

output                  tready;  //выход, сообщающий о готовности устройства передавать данные
output                  out;

wire        [15:0]      parall_A;
wire        [15:0]      parall_B;

wire        [15:0]      divider;
wire        [15:0]      divisible;

wire        [9:0]       fraction;
wire        [4:0]       exponent;
wire                    sign;

wire                    load_done;
wire                    load;
wire                    load1;

wire                    ready;
wire                    ready_stop;
wire                    ready_stop1;

assign w_load   = load1 & load &(~load_done);
assign w_ready  = ready & (~ready_stop); 
assign w_ready1 = ready & (~ready_stop1); 


shift_register_left        dut_A            (.clk(clk), .res(res), .tvalid(tvalid), .din(A), .out(parall_A));
shift_register_left        dut_B            (.clk(clk), .res(res), .tvalid(tvalid), .din(B), .out(parall_B));

comparator                 dut_comparator   (.clk(clk), .res(res), .A(parall_A), .B(parall_B), .divisible(divisible), .divider(divider), .ready(ready));

summator                   dut_summator     (.clk(clk), .res(res), .divisible(divisible), .divider(divider), .load(load), .exponent(exponent), .sign(sign), .ready(w_ready), .ready_stop(ready_stop)); 

div_fraction               dut_div_fraction (.clk(clk), .res(res), .divisible(divisible), .divider(divider), .fraction(fraction), .load(load1), .ready(w_ready1), .ready_stop(ready_stop1));

shift_register_right       dut_out          (.clk(clk), .res(res), .tready(tready), .sign(sign), .exponent(exponent), .fraction(fraction), .load(w_load), .out(out), .load_done(load_done));

endmodule