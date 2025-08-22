- SDF (Standard Delay Format): has delay information for every instance, wire and register 
- TCF (Toggle Count Format): has switching information for input, output and wire
	- ref: [[How to analyze annotation report of the report_sdb_annotation command in Genus_Joules.pdf]]
- RTL-level power Report
	- RTL simulation generate
		- TCF
	- Synthesis tool with power report for RTL-level power need: 
		- TCF with netlist naming (TCF 透過 Mapping File 轉換成 Netlist 的 Naming)
			- P.S: Synthesis mapping file 不會自動產生，這個流程需要額外的處理，如果沒有這個流程，Annotation Ratio會很低（失敗）
		- Netlist
		- Techlib: 6T, SVT, **TT, Normal Volt, 25c**
		- 不需要SDF
			- ref: https://www.youtube.com/watch?v=Iz1pTSgo8HY
			- SDF也有會有mapping的問題，通常SDF是在Post-Pre Layout才會extract
- Gate-level power Report
	- Gate simulation generate: 
		- TCF
	- Synthesis tool with power report for Gate-level power need: 
		- TCF from Gate-level simulation
		- Netlist
		- Techlib: 6T, SVT, **TT, Normal Volt, 25c**
		- 不需要SDF
			- ref: https://www.youtube.com/watch?v=Iz1pTSgo8HY
			- SDF也有會有mapping的問題，通常SDF是在Post-Pre Layout才會extract

# annotation_report

