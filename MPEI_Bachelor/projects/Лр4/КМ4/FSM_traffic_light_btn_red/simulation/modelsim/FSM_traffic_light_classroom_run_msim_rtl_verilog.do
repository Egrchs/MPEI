transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/MPEI/Verilog/FSM_traffic_light/src {D:/MPEI/Verilog/FSM_traffic_light/src/traffic_light_top.v}
vlog -vlog01compat -work work +incdir+D:/MPEI/Verilog/FSM_traffic_light/src {D:/MPEI/Verilog/FSM_traffic_light/src/traffic_light.v}
vlog -vlog01compat -work work +incdir+D:/MPEI/Verilog/FSM_traffic_light/src {D:/MPEI/Verilog/FSM_traffic_light/src/timer.v}

vlog -vlog01compat -work work +incdir+D:/MPEI/Verilog/FSM_traffic_light/src {D:/MPEI/Verilog/FSM_traffic_light/src/tb_traffic_light_top.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_traffic_light_top

add wave *
view structure
view signals
run -all
