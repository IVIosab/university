transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {alu.vo}

vlog -vlog01compat -work work +incdir+C:/Users/mosab/Desktop/CA\ LABS/Week\ 12/ex2 {C:/Users/mosab/Desktop/CA LABS/Week 12/ex2/sub.v}
vlog -vlog01compat -work work +incdir+C:/Users/mosab/Desktop/CA\ LABS/Week\ 12/ex2 {C:/Users/mosab/Desktop/CA LABS/Week 12/ex2/testbench.v}
vlog -vlog01compat -work work +incdir+C:/Users/mosab/Desktop/CA\ LABS/Week\ 12/ex2 {C:/Users/mosab/Desktop/CA LABS/Week 12/ex2/add.v}
vlog -vlog01compat -work work +incdir+C:/Users/mosab/Desktop/CA\ LABS/Week\ 12/ex2 {C:/Users/mosab/Desktop/CA LABS/Week 12/ex2/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/mosab/Desktop/CA\ LABS/Week\ 12/ex2 {C:/Users/mosab/Desktop/CA LABS/Week 12/ex2/glob.v}
vlog -vlog01compat -work work +incdir+C:/Users/mosab/Desktop/CA\ LABS/Week\ 12/ex2 {C:/Users/mosab/Desktop/CA LABS/Week 12/ex2/mux.v}
vlog -vlog01compat -work work +incdir+C:/Users/mosab/Desktop/CA\ LABS/Week\ 12/ex2 {C:/Users/mosab/Desktop/CA LABS/Week 12/ex2/srl.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L gate_work -L work -voptargs="+acc"  testbench

do C:/Users/mosab/Desktop/CA LABS/Week 12/ex2/Tcl_script1.tcl
