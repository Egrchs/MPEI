`include "pwm_buzzer.v"
`timescale 1 ps/ 1 ps

module tb_pwm_buzzer #(parameter WIDTH = 60)();

reg   clk_50;
reg button_add;
reg button_sub;
                                
wire pwm;
                  
pwm_buzzer DUT1 (.clk_50(clk_50),.button_add(button_add),.button_sub(button_sub),.pwm(pwm);

//clk
initial begin
    $display("Running testbench");                                                  
	clk = 0;
  forever #5 clk = ~clk;
end 

//L
initial begin
	L = 0;
	#10 L = 1;
	#80 L = 0;
end	  

//выбор направления сдвига
initial begin
	E = 0;
	#50 E = 1;
end

//ввод числа
initial begin
	D = 60'd1132;
end
initial begin
	$monitor ("At time %t 'L'=%b and 'E'=%b and 'D'=%b and 'Q'=%b",$time,L,E,D,Q);
	#100 $display("Testbench is OK!");
	#100 $finish;
end
	 
initial begin            
    $dumpfile("qqq.vcd");
    $dumpvars;  
end

endmodule