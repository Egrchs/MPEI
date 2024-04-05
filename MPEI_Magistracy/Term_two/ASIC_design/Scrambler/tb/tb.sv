`timescale 1ns/1ps //Simulation time unit 1ns, simulation time precision 1ps

`define WAVES_FILE "dump/wave.vcd"

module tb();

// signal declaration
logic clk;
logic rst;
logic bit_in;
logic bit_out;

//Module instantiation (just connect the declared signals)
top U(
    .clk (clk),
    .rst (rst),
    .bit_in (bit_in),
    .bit_out (bit_out)
    );

always #5 clk = ~clk; //generate clock signal

// assign value to input data
initial begin
    clk = 1;
    rst = 1;
    #10 rst = 0;
    #5 rst = 1;
end

localparam [0 : 10] a        = 11'b1010_0000_101;

initial
  begin
    @ (negedge rst);

    for (int i = 0; i < 11; i ++)
    begin
      @ (posedge clk);
      bit_in <= a [i];
   end
  end

initial begin
    $dumpfile(`WAVES_FILE);
    $dumpvars;
    #1000 $finish();
end

endmodule