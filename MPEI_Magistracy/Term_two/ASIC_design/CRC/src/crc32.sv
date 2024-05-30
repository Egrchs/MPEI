module crc32 #(
   parameter WIDTH = 32
  )
	(
    input  logic                  clk,
    input  logic                  rst,
    input  logic [WIDTH-1:0]      data,
    input  logic                  rd,
    input  logic [WIDTH  :0]      polynom_i,
    output logic [WIDTH-1:0]      CRC,
    output logic                  out_ready_CRC
  );

  logic [WIDTH-1      :0]  data_CRC;
  logic [2*WIDTH-1    :0]  ext_data;   //что ты такое?
  logic [WIDTH        :0]  polynomial; //generation polynom 
  logic [$clog2(WIDTH):0]  cnt;        //counter
  logic                    ready_CRC;
  logic [WIDTH        :0]  shifter;    //сдвиг результата "вычитания" полиномов, если он был
  logic [WIDTH        :0]  reg_xor;    //результат "вычитания" полиномов
  
  always_comb begin
    CRC [WIDTH-1:0] = data_CRC [WIDTH-1:0];
    out_ready_CRC = ready_CRC;
  end


  always_ff @(posedge clk or negedge rst) begin
  	if (!rst) begin
      data_CRC   [WIDTH-1      :0]   <= {WIDTH{1'b0}};
  		ext_data   [2*WIDTH-1    :0]   <= {2*WIDTH{1'b0}};
  		shifter    [WIDTH        :0]   <= {(WIDTH+1){1'b0}};
  		polynomial [WIDTH        :0]   <= polynom_i;
  		cnt        [$clog2(WIDTH):0]   <= {($clog2(WIDTH)+1){1'b0}};
  		ready_CRC                      <= 1'b0;
		  reg_xor                        <= '0;
  	end
  	else begin
      if ( (!rd) && (cnt == WIDTH) ) begin
        if ( shifter[WIDTH] ) begin
          shifter           <= shifter ^ polynomial;
        end
  			ready_CRC            <= 1'b1;
        data_CRC [WIDTH-1:0] <= shifter[WIDTH-1:0];
  		end
      else if ( (!rd) && (cnt < WIDTH) ) begin
        if ( shifter [WIDTH] == 1'b1) begin
          reg_xor  = shifter ^ polynomial;
			    shifter  = {reg_xor[WIDTH-1:0], ext_data[WIDTH-1]};
        end 
        else begin
			    shifter <= {shifter[WIDTH-1:0], ext_data[WIDTH-1]};
		    end
  			cnt                    <= cnt + 1'b1;
  			ext_data               <= {ext_data[2*WIDTH-2:0], 1'b0};
  		end
  		else if (rd) begin
  			shifter  [WIDTH:0]     <= {data[WIDTH-1:0],1'b0};
  			ext_data [2*WIDTH-1:0] <= {data[WIDTH-1:0],{WIDTH{1'b0}}};
  		end
  	end
  end
endmodule