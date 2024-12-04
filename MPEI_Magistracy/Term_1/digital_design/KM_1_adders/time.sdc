#Файл для временного анализа

#Создаем CLK
create_clock -name {clock} -period 50MHz [get_ports {CLK_i}]
#Убираем неопределенности
derive_clock_uncertainty
#указываем ложные пути (от клока на выходные триггер)

#Порт S - шина, поэтому S_o[*]
set_false_path -from [get_clocks {clock}] -to [get_ports {S_o[*]}] 
set_false_path -from [get_clocks {clock}] -to [get_ports {C_o}] 

#указываем ложные пути от входных портов на проводники к сумматору
set_false_path -from [get_clocks {clock}] -to [get_nets {A_i[*]}] 
set_false_path -from [get_clocks {clock}] -to [get_nets {B_i[*]}] 
set_false_path -from [get_clocks {clock}] -to [get_nets {P_i}] 