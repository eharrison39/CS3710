transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/super/Documents/1\ Classes/2025/03\ Fall/CS\ 3710/ALU\ Lab\ 1 {C:/Users/super/Documents/1 Classes/2025/03 Fall/CS 3710/ALU Lab 1/alu_sample_code.v}

vlog -vlog01compat -work work +incdir+C:/Users/super/Documents/1\ Classes/2025/03\ Fall/CS\ 3710/ALU\ Lab\ 1 {C:/Users/super/Documents/1 Classes/2025/03 Fall/CS 3710/ALU Lab 1/alutest_sample_code.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  alutest_sample_code

add wave *
view structure
view signals
run -all
