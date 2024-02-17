//Моргание светодиодом

module blink(clk, LED);
input clk; 
output LED;


reg [26:0] cnt; 

initial cnt <= 0; 

always @(posedge clk) cnt <= cnt+1; 


assign LED = cnt[26]; 