- RTL simulation generate: 
	- TCF
	- Mapping File
- TCF 透過 Mapping File 轉換成 Netlist 的 Naming
- Power report for RTL-level power need: 
	- TCF with netlist naming
	- Netlist
	- Techlib: 6T, SVT, TT, Normal Volt, 25c
	- SDF



3. power:
	1. File requirement for RTL-Level power
		1. .vg: generate from synthesis
		2. verilog.tcf: generate from rtl-level simulation
		3. techlib
		4. .sdf: (can ignore, useful in backend)
	2. File requirement for Gate-Level power
		1. .vg: generate from synthesis
		2. verilog.tcf: generate from gate-level simulation
		3. techlib
		4. .sdf: (can ignore, useful in backend)