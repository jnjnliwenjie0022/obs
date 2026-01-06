
- ATPG: Automatic Test Pattern Generation (ATPG)
- ATPG sees only comb. ckt. model
	- turns seq. ckt. to comb. ckt.
	- Sequential circuit 無法使用 ATPG pattern，需要將 Sequential circuit 轉成 combination circuit 才能使用 ATPG pattern
# DFT

- ref: https://www.youtube.com/watch?v=FMhw3n7NqVM&list=PLvd8d-SyI7hjk_Ci0zpTqImAtpEjdK5JF&index=55
- DFT Rules
	- Rule1: self-initialization or initialize from tester
	- Rule2: disable internal clocks during test
		- disable on-chip PLL in test mode
		- enable external clock from tester
- Internal Scan
	- Scan chain insertion (aka. DFT insertion or DFT synthesis) in early 1970's \[Williams 73\]\[Eichelberger 77\]
- External Scan
	- JTAG (IEEE 1149.1)

# internal_scan

- method
	- LSSD
		- pros:
			- no clock skew
			- popular for latch-based design
	- Muxed D-scan
		- cons:
			- speed degradation
		- pros:
			- popular for FF-based design
	- Clock scan
		- cons:
			- need extra clock routing for SCK
		- pros:
			- no speed degradation
			- for advanced design
# muxed_d_scan

- ref: [Let’s talk about On-Chip Clock Controller! 2 | by Raghu Aratlakota | Medium](https://medium.com/@raghuel/lets-talk-about-occ-d9bcc39260cd)
- function
	- normal mode
	- test mode
		- shift phase: SE = 1
		- capture phase: SE = 0
- SFF main pin (SO DO can be shared)
	- SI(Scan Input)
	- SO(Scan Output)
	- DI(Data Input)
	- DO(Data Output)
- SFF pros
	- easy ATPG
- SFF cons
	- performance overhead for setup/hold time
	- power overhead
	- area overhead 5%~10%
	- pin overhead
	- design overhead
- test mode operation
	- stuck-at fault testing: SA (stuck@0 or stuck@1)
	- delay fault testing: STR (slow to rise), STF (slow to fall), path delay, IDDQ
		- launch-on-shift (LOS)
			- pros:
				- turns seq. ckt. to comb. ckt. ATPG pattern 數量少
			- cons: 
				- bad FC (fault coverage) untestable due to structural dependency
		- launch-on-capture (LOC)
			- pros:
				- good FC 
			- cons:
				- turns seq. ckt. to comb. ckt. ATPG pattern 數量大
		- Mix LOS and LOC: 先用 LOS 加速驗證，再用 LOC 收斂 FC
		- ![[transition_fault.svg|1000]]
# occ
- ref: https://blog.csdn.net/Tranquil_ovo/article/details/151120747?spm=1001.2101.3001.6650.4&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EYuanLiJiHua%7EPosition-4-151120747-blog-144903477.235%5Ev43%5Epc_blog_bottom_relevance_base3&utm_relevant_index=8

# scan_flow

- ![[scan_flow.svg]]
- DRC Rule
	- 要注意 tri-state bus
		- solution: SE = 1, disable bus
	- 要注意 bi-directional I/O ports
		- solution: SE = 1, always input pin
	- 要注意 ICG
		- solution: SE = 1, clock always on, 需要多一個 OR Gate
	- 要注意 reset
		- solution: SE = 1, reset always 1, 需要多一個 OR Gate
- scan chain cross clock domain
	- 