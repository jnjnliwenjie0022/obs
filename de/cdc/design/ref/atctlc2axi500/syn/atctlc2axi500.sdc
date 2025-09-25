if {![info exists env(clock_uncertainty)]} {
	set clock_uncertainty 0.3
} else {
	set clock_uncertainty $env(clock_uncertainty)
}

if {![info exists clock_transition]} {
	set clock_transition 0.1
}

if {![info exists env(aclk_period)]} {
	set aclk_period 10.0
} else {
	set aclk_period $env(aclk_period)
}

if {![info exists env(clk_period)]} {
	set clk_period 10.0
} else {
	set clk_period $env(clk_period)
}

if {![info exists tech_lib]} {
	set tech_lib "" 
	set driving_cell "" 
	set load_val 1
	set operating_cond ""
}

if {![info exists env(maxFanout)]} {
	set max_fanout 64
} else {
	set max_fanout $env(maxFanout)
}

if {![info exists input_ratio]} {
	set input_ratio  0.6
}

if {![info exists output_ratio]} {
	set output_ratio 0.6
}

if {![info exists internal_ratio]} {
	set internal_ratio 0.2
}

if {![info exists cfg_async]} {
	set cfg_async 0
}

# -------------------------------------------------------------
# Create clock 
# -------------------------------------------------------------
create_clock -name ACLK -period $aclk_period \
	-waveform [list 0 [expr $aclk_period / 2.0]] [get_ports aclk]

create_clock -name CLK -period $clk_period \
	-waveform [list 0 [expr $clk_period / 2.0]] [get_ports clk]

# Specify Clock Skew
set_clock_uncertainty -setup [expr $aclk_period * $clock_uncertainty] [get_clocks ACLK]
set_clock_uncertainty -setup [expr $clk_period * $clock_uncertainty] [get_clocks CLK]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]

# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
set axi_input_delay  [expr $aclk_period * (1 - $clock_uncertainty) * $input_ratio]
set axi_output_delay [expr $aclk_period * (1 - $clock_uncertainty) * $output_ratio]

set tilelink_input_delay  [expr $clk_period * (1 - $clock_uncertainty) * $input_ratio]
set tilelink_output_delay [expr $clk_period * (1 - $clock_uncertainty) * $output_ratio]

set_input_delay -max $tilelink_input_delay -clock CLK  [get_ports resetn]
set_input_delay -max $axi_input_delay      -clock ACLK [get_ports aresetn]

set_input_delay -max $tilelink_input_delay -clock CLK  [get_ports aclk_en]

set_output_delay -max $axi_output_delay -clock ACLK [get_ports awid*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports awaddr*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports awlen*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports awsize*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports awburst*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports awlock]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports awcache*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports awprot*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports awuser*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports awvalid]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports awready]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports wdata*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports wstrb*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports wlast]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports wuser*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports wvalid]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports wready]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports bid*]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports bresp*]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports buser*]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports bvalid]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports bready]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports arid*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports araddr*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports arlen*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports arsize*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports arburst*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports arlock]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports arcache*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports arprot*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports aruser*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports arvalid]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports arready]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports rid*]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports rdata*]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports rresp*]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports rlast]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports ruser*]
set_input_delay  -max $axi_input_delay  -clock ACLK [get_ports rvalid]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports rready]

set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports a_opcode*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports a_param*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports a_size*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports a_source*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports a_address*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports a_mask*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports a_corrupt*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports a_data*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports a_user*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports a_valid]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports a_ready]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports b_opcode*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports b_param*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports b_size*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports b_source*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports b_address*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports b_mask*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports b_corrupt*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports b_data*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports b_user*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports b_valid]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports b_ready]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports c_opcode*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports c_param*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports c_size*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports c_source*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports c_address*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports c_corrupt*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports c_data*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports c_user*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports c_valid]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports c_ready]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports d_opcode*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports d_param*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports d_size*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports d_source*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports d_sink*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports d_denied]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports d_corrupt*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports d_data*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports d_user*]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports d_valid]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports d_ready]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports e_sink*]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports e_valid]
set_output_delay -max $tilelink_output_delay -clock CLK [get_ports e_ready]
set_input_delay  -max $tilelink_input_delay  -clock CLK [get_ports e_user*]

# -------------------------------------------------------------
# Set External Driver and Load
# -------------------------------------------------------------
set_driving_cell -library ${tech_lib} -lib_cell $driving_cell -no_design_rule [all_inputs]
set_load [expr $load_val * 16] [all_outputs]
set_max_fanout $max_fanout [current_design]

# -------------------------------------------------------------
# Specify Operating Conditions
# -------------------------------------------------------------
set_operating_conditions $operating_cond

# -------------------------------------------------------------
# Specify Wire-load Models
# -------------------------------------------------------------
# Set the Wire-load Mode
set_wire_load_mode enclosed

# -------------------------------------------------------------
# Set Timing Exceptions
# -------------------------------------------------------------
# Specify False Paths

# Specify Multi-Cycle Paths
set_multicycle_path -setup 2 -from [get_ports resetn]
set_multicycle_path -hold  1 -from [get_ports resetn]
set_multicycle_path -setup 2 -from [get_ports aresetn]
set_multicycle_path -hold  1 -from [get_ports aresetn]

if {$cfg_async == 0} {
    set clock_ratio [expr int($aclk_period/$clk_period)]
    if {$clock_ratio > 1} {
        set_multicycle_path -setup [expr $clock_ratio    ] -start -from [get_clocks CLK] -to [get_clocks ACLK]
        set_multicycle_path -hold  [expr $clock_ratio - 1] -start -from [get_clocks CLK] -to [get_clocks ACLK]
        set_multicycle_path -setup [expr $clock_ratio    ] -end   -from [get_clocks ACLK] -to [get_clocks CLK]
        set_multicycle_path -hold  [expr $clock_ratio - 1] -end   -from [get_clocks ACLK] -to [get_clocks CLK]
    }
}
# Specify Path Delays
if {$cfg_async == 1} {
    set_max_delay $clk_period -from [get_clocks CLK] -to [get_clocks ACLK]
    set_max_delay $clk_period -from [get_clocks ACLK] -to [get_clocks CLK]
    set_min_delay 0 -from [get_clocks CLK] -to [get_clocks ACLK]
    set_min_delay 0 -from [get_clocks ACLK] -to [get_clocks CLK]
}
