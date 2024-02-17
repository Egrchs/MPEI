transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/brigada_7/src {F:/brigada_7/src/Lab1_beh.v}

vlog -vlog01compat -work work +incdir+F:/brigada_7/src {F:/brigada_7/src/tb_lab1.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_lab1

add wave *
view structure
view signals
run -all
