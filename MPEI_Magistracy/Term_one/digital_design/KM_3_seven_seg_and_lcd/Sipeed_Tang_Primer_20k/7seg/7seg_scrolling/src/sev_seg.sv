module sev_seg
# (
    parameter clk_mhz = 27,
              w_key   = 4,
              w_led   = 8,
              w_digit = 8
)
(
    input                           clk,
    input                           rst,
    input  logic [          3 : 0 ] shift,
    input  logic [w_key   - 1 : 0 ] key,

    output logic [          7 : 0 ] cathodes,
    output logic [          7 : 0 ] anodes
);


  logic    [7:0]   cathodes_r;
  logic    [7:0]   anodes_r;

  logic    [3:0]   data  [0:12];

  logic    [3:0]   addr;

  function [7:0] BCD_to_Seven;
    input  [3:0] d;
  
    begin
      case (d)
        4'd0    : BCD_to_Seven = 8'b10101000; //M
        4'd1    : BCD_to_Seven = 8'b11101110; //A
        4'd2    : BCD_to_Seven = 8'b11001100; //R
        4'd3    : BCD_to_Seven = 8'b00001100; //I
        4'd4    : BCD_to_Seven = 8'b11111101; //O
        4'd5    : BCD_to_Seven = 8'b00000000; //space
        4'd6    : BCD_to_Seven = 8'b00011110; //t
        4'd7    : BCD_to_Seven = 8'b00000100; //'
        4'd8    : BCD_to_Seven = 8'b10110110; //S
        4'd9    : BCD_to_Seven = 8'b10011110; //E
        default : BCD_to_Seven = 8'b00000000;
      endcase
    end
  endfunction

  initial begin 
    data[0]  = 4'd4;   //O
    data[1]  = 4'd3;   //I
    data[2]  = 4'd2;   //R
    data[3]  = 4'd1;   //A
    data[4]  = 4'd0;   //M
    data[5]  = 4'd5;   //space
    data[6]  = 4'd9;   //E   
    data[7]  = 4'd0;   //M
    data[8]  = 4'd5;   //space
    data[9]  = 4'd8;   //s
    data[10] = 4'd7;   //`
    data[11] = 4'd6;   //t
    data[12] = 4'd3;   //I
  end

//  logic iclk;

//  logic [24:0] cnt;

//  always_ff @(posedge clk or negedge rst) begin
//    if (!rst) begin
//      cnt  <= 0;
//      iclk <= 0;
//    end
//    else if (cnt == 27000000/4000) begin
//      cnt  <= 0;
//      iclk <= ~iclk;
//    end
//    else begin
//      cnt  <= cnt + 1'b1;
//    end
//  end

  //count address
  always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
      addr   <= 4'b0000;
    end
    else begin
      addr   <= addr + 1'b1;
      if (addr == 4'd12)
        addr <= 0;
    end
  end

  //forming cathodes
  always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
      cathodes_r <= 0;
    end
    else begin
      cathodes_r <= {BCD_to_Seven(data[addr])};
    end
  end

  //switching anodes
  always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
      anodes_r <= {8{1'b0}};
    end
    else begin
      anodes_r <= 8'b000_0001 << (addr + shift);
    end
  end

  assign cathodes = cathodes_r;
  assign anodes   = anodes_r;
	
endmodule