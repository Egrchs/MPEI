module uart_rx
#(
	parameter CLK_FRE   = 27,      //clock frequency(Mhz)
	parameter BAUD_RATE = 115200   //serial baud rate
)
(
	input  logic      	   	clk,              //clock input
	input  logic      	   	rst_n,            //asynchronous reset input, low active 
	output logic [ 7 : 0 ]	rx_data,          //received serial data
	output logic      		rx_data_valid,    //received serial data is valid
	input  logic      		rx_data_ready,    //data receiver module ready
	input  logic      		rx_pin            //serial data input
);
	//calculates the clock cycle for baud rate 
	localparam      CYCLE = CLK_FRE * 1000000 / BAUD_RATE;

	typedef enum {  
		S_IDLE,    
		S_START,   
		S_REC_BYTE,
		S_STOP,    
		S_DATA    
	} state_t;
	
	state_t state, next_state;

	logic [ 7  : 0]	rx_bits;          //temporary storage of received data
	logic [ 15 : 0]	cycle_cnt;        //baud counter
	logic [ 2  : 0]	bit_cnt;          //bit counter
	logic          	rx_d0;            //delay 1 clock for rx_pin
	logic          	rx_d1;            //delay 1 clock for rx_d0
	logic          	rx_negedge;       //negedge of rx_pin
	
	assign rx_negedge = rx_d1 && ~rx_d0;
	
	always_ff@(posedge clk or negedge rst_n) begin
		if(rst_n == 1'b0) begin
			rx_d0 <= 1'b0;
			rx_d1 <= 1'b0;	
		end
		else begin
			rx_d0 <= rx_pin;
			rx_d1 <= rx_d0;
		end
	end
	
	
	always_ff@(posedge clk or negedge rst_n) begin
		if(rst_n == 1'b0)
			state <= S_IDLE;
		else
			state <= next_state;
	end
	
	always_comb begin
		case(state)
			S_IDLE:
				if(rx_negedge)
					next_state = S_START;
				else
					next_state = S_IDLE;
			S_START:
				if(cycle_cnt == CYCLE - 1)//one data cycle 
					next_state = S_REC_BYTE;
				else
					next_state = S_START;
			S_REC_BYTE:
				if(cycle_cnt == CYCLE - 1 && bit_cnt == 3'd7)  //receive 8bit data
					next_state = S_STOP;
				else
					next_state = S_REC_BYTE;
			S_STOP:
				if(cycle_cnt == CYCLE/2 - 1)//half bit cycle,to avoid missing the next byte receiver
					next_state = S_DATA;
				else
					next_state = S_STOP;
			S_DATA:
				if(rx_data_ready)    //data receive complete
					next_state = S_IDLE;
				else
					next_state = S_DATA;
			default:
				next_state = S_IDLE;
		endcase
	end
	
	always_ff@(posedge clk or negedge rst_n) begin
		if(rst_n == 1'b0)
			rx_data_valid <= 1'b0;
		else if(state == S_STOP && next_state != state)
			rx_data_valid <= 1'b1;
		else if(state == S_DATA && rx_data_ready)
			rx_data_valid <= 1'b0;
	end
	
	always_ff@(posedge clk or negedge rst_n) begin
		if(rst_n == 1'b0)
			rx_data <= 8'd0;
		else if(state == S_STOP && next_state != state)
			rx_data <= rx_bits;//latch received data
	end
	
	always_ff@(posedge clk or negedge rst_n) begin
		if(rst_n == 1'b0) begin
            bit_cnt <= 3'd0;
		end
		else if(state == S_REC_BYTE) begin
			if(cycle_cnt == CYCLE - 1)
				bit_cnt <= bit_cnt + 3'd1;
			else
				bit_cnt <= bit_cnt;
		end
		else
			bit_cnt <= 3'd0;
	end
	
	always_ff@(posedge clk or negedge rst_n) begin
		if(rst_n == 1'b0)
			cycle_cnt <= 16'd0;
		else if((state == S_REC_BYTE && cycle_cnt == CYCLE - 1) || next_state != state)
			cycle_cnt <= 16'd0;
		else
			cycle_cnt <= cycle_cnt + 16'd1;	
	end

	//receive serial data bit data
	always_ff@(posedge clk or negedge rst_n) begin
		if(rst_n == 1'b0)
			rx_bits <= 8'd0;
		else if(state == S_REC_BYTE && cycle_cnt == CYCLE/2 - 1)
			rx_bits[bit_cnt] <= rx_pin;
		else
			rx_bits <= rx_bits; 
	end

endmodule 