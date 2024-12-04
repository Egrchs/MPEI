module button_debouncer
//! Параметры
#(
    parameter		CNT_WIDTH = 16
)
//! Порты
(
    input  logic clk_i,
	input  logic rst_i,
    input  logic sw_i,  
 
    output logic sw_state_o,  
    output logic sw_down_o,  
    output logic sw_up_o   
);
 
//! Синхронизируем вход с текущим тактовым доменом.
logic	 [1:0] sw_r;
always_ff @ (posedge rst_i or posedge clk_i)
if (rst_i)
		sw_r   	<= 2'b00;
else
		sw_r    <= {sw_r[0], ~sw_i};
 
logic [CNT_WIDTH-1:0] sw_count;
 
 
logic sw_change_f = (sw_state_o != sw_r[1]);
//wire sw_cnt_max = (sw_count == {CNT_WIDTH{1'b1}}) ;	
logic sw_cnt_max = &sw_count;	
 
always_ff @(posedge rst_i or posedge clk_i)
if (rst_i)
begin
	sw_count <= 0;
	sw_state_o <= 0;
end 
else if(sw_change_f)	
   	begin
		sw_count <= sw_count + 'd1;  
		if(sw_cnt_max) sw_state_o <= ~sw_state_o;  
	end
	else  sw_count <= 0;  
 
always_ff @(posedge clk_i)
begin
	sw_down_o <= sw_change_f & sw_cnt_max & ~sw_state_o;
	sw_up_o <= sw_change_f & sw_cnt_max &  sw_state_o;
end
 
endmodule