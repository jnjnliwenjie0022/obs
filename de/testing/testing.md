
- ATPG: Automatic Test Pattern Generation (ATPG)
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

- ref: [Let’s talk about On-Chip Clock Controller! 2 | by Raghu Aratlakota | Medium](https://medium.com/@raghuel/lets-talk-about-occ-d9bcc39260cd)
- function
	- normal mode
	- test mode
		- shift phase： SE = 1
			- shift in
			- shift out
			- launch (option)
		- capture phase: SE = 0
			- launch (option)
			- capture
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
		- ref: https://blog.csdn.net/Tranquil_ovo/article/details/151120747?spm=1001.2101.3001.6650.4&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EYuanLiJiHua%7EPosition-4-151120747-blog-144903477.235%5Ev43%5Epc_blog_bottom_relevance_base3&utm_relevant_index=8
		- launch-on-shift (LOS)
			- cons: 無法測試 STR 和 STF
		- launch-on-capture (LOC)
			- pros: 最常用測試
		- ![[transition_fault.svg|1000]]
	- 