###############################################################################
# Created by write_sdc
# Wed Oct  6 21:55:22 2021
###############################################################################
current_design test_macro
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk[0]  -period 100.0000 [get_ports {clk}]

set_input_delay 20.0000 -clock [get_clocks clk] -add_delay [get_ports {y}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {y}]


set_input_delay 20.0000 -clock [get_clocks clk] -add_delay [get_ports {p_end}]

for {set i 0} {$i < 10} {incr i} {
    set j_max 31
    if {$i == 0 || $i == 10} {
        set j_max 32
    }

    for {set j 0} {$j < $j_max} {incr j} {
        set x_name "x$i[$j]"
        set_input_delay 20.0000 -clock [get_clocks clk] -add_delay [get_ports $x_name]
    }
}

###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports p_end]

set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports clk]

for {set i 0} {$i < 10} {incr i} {
    set j_max 31
    if {$i == 0 || $i == 10} {
        set j_max 32
    }
    for {set j 0} {$j < $j_max} {incr j} {
        set x_name "x$i[$j]"
        set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports $x_name]
    }
}

###############################################################################
# Design Rules
###############################################################################
set_max_fanout 130.0000 [current_design]
