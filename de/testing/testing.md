- ref: https://www.youtube.com/watch?v=FMhw3n7NqVM&list=PLvd8d-SyI7hjk_Ci0zpTqImAtpEjdK5JF&index=55
- ATPG: Automatic Test Pattern Generation (ATPG)
- ATPG sees only comb. ckt. model
	- turns seq. ckt. to comb. ckt.
	- Sequential circuit 無法使用 ATPG pattern，需要將 Sequential circuit 轉成 combination circuit 才能使用 ATPG pattern
- external scan and internal scan 是用相同 EDA tool
# dft

- DFT Rules
	- Rule1: self-initialization or initialize from tester
	- Rule2: disable internal clocks during test
		- disable on-chip PLL in test mode
		- enable external clock from tester
- Internal Scan
	- Scan chain insertion (aka. DFT insertion or DFT synthesis) in early 1970's \[Williams 73\]\[Eichelberger 77\]
- External Scan
	- IEEE 1149.1 - Standard Test Access Port and Boundary-Scan Architecture
		- P.S: JTAG 是實現 IEEE 1149.1 的介面
			- JTAG 可以 access external scan，符合 IEEE 1149.1，無需其他電路設計
			- JTAG 可以 access internal scan，但只作爲 transport，需要做其他非電路設計，建議在 IEEE 1149.1 上引入 IEEE 1687，將 IEEE 1149.1 作爲external device，IEEE 1687 作爲

# internal_scan
## scan_cell

- 實際上, 所有 scan cell 都是 EDA 完成
- scan cell
	- LSSD
		- ref: https://blog.csdn.net/qq_16423857/article/details/136272862
		- cons:
			- need extra clock routing for SCK
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
## muxed_d_scan

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
			- slow clock: from ATE
			- fast clock: from PLL
				- AT-speed test (全速測試): 測試晶片在實際工作頻率下是否能正常運作，測試時脈往往是由晶片內部的PLL產生
## occ #TODO 
- ref: https://blog.csdn.net/Tranquil_ovo/article/details/151120747?spm=1001.2101.3001.6650.4&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EYuanLiJiHua%7EPosition-4-151120747-blog-144903477.235%5Ev43%5Epc_blog_bottom_relevance_base3&utm_relevant_index=8
- ref: https://medium.com/@raghuel/lets-talk-about-occ-d9bcc39260cd
- occ 可以是 hard macro by EDA tool

## scan_flow

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
	- ![[scan_chain_cross_clock_domain.svg]]
- Q1: How to save test Time?
	- ![[q1.svg]]
- Q2: How to save storage on ATE (Automatic Test Equipment)?
	- ![[q2.svg]]
- Q3: How to reduce overhead?
	- expectation: 
	- solution: partial scan
		- cons:
			- lower FC
		- pros:
			- less area overhead
			- less timing overhead
	- analysis:
		- ![[q3.svg]]
- Q4: How to test DFT
	- for FF-based scan chain
	- for LSSD scan chain
	- ![[q4.svg]]

# external_scan
## scan_flow