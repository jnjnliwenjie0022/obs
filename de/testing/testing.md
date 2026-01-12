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
	- IEEE 1149.1-2013 - Standard Test Access Port and Boundary-Scan Architecture
		- #TODO ref: https://blog.csdn.net/kinjon/article/details/155233782?spm=1001.2101.3001.6650.2&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EYuanLiJiHua%7ECtr-2-155233782-blog-121147801.235%5Ev43%5Epc_blog_bottom_relevance_base7&utm_relevant_index=5
		- #TODO ref: https://blog.csdn.net/xuhe0206/article/details/125867462?spm=1001.2101.3001.6661.1&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7EPaidSort-1-125867462-blog-121945432.235%5Ev43%5Epc_blog_bottom_relevance_base7&utm_relevant_index=1
		- P.S: JTAG 是實現 IEEE 1149.1-2013 的介面
		- P.S: 通常將 IEEE 1149.1-2013 視爲 **transport module**
- IEEE 1149.1-2013 and IEEE 1687
	- #TODO ref: https://blog.csdn.net/Python_0011/article/details/154824998?spm=1001.2101.3001.4242.1&utm_relevant_index=2
	- IEEE 1149.1-2013 通常用來處理 external scan，但可處理 internal scan
	- IEEE 1687 通常用來處理 internal scan，但可處理 external scan
	- IEEE 1687 完全相容 IEEE 1149.1-2013
		- IEEE 1687 通常掛在 1149.1-2013 的 TAP 之下, IEEE 1687 作為其中一個 Test Data Registor (TDR) 來運作, 1149.1-2013 作為其中一個 JTAG-style Test Access Port (TAP)
		- IEEE 1687 技術核心是 SiB
		- pin 一樣：TDI/TDO/TMS/TCK/TRST
		- fsm 一樣：16

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
- ref: https://www.cnblogs.com/yilia-er/p/14200583.html
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

## ieee1149.1-1990

- TAP (Test Access Port)
	- TDI
	- TDO
	- TCK
	- TMS
	- TRST
- TAP controller
	- interface
		- clock: TCK
		- input: TMS
		- reset: TRST
	- 16 FSM
- JTAG instruction example
	- EXTEST=0000...
		- ![[jtap_extest.svg]]
	- BYPASS=1111...
		- ![[jtap_bypass.svg]]
	- SAMPLE / PRELOAD (instruction code decided by designer)
		- ![[jtap_sample_preload.svg]]
	- INTEST (instruction code decided by designer)
		- 
	- RUNBIST (instruction code decided by designer)
		- select BIST (build-in self-test)
	- IDCODE (instruction code decided by designer)
		- select ID register
	- User-Defined Instruction (instruction code decided by designer)
## boundary_scan_cell

- 通常 EDA 實作 scan chain, BSDL 描述 pin 與 BSC 的關係, Techlib 會提供 BSC
- ref: https://blog.csdn.net/zhuangdk/article/details/121147801
- ref: https://vlsitutorials.com/jtag-data-registers
- ref: [JTAG边界扫描BSDL文件介绍 - 知乎](https://zhuanlan.zhihu.com/p/1950897307231981616)
- ref: [Overview :: JTAG Test Access Port (TAP) :: OpenCores](https://opencores.org/projects/jtag)
	- account: jnjn0022
	- password: XXXX
- 以下是描述 sync bsc, async bsc 也差不多, 注意 clock 問題即可
	- ![[bsc.svg]]
## arch
- ref: https://vlsitutorials.com/jtag-architecture-overview/
- ref: https://www.youtube.com/watch?v=TDfrsI8GxSk&list=PLOuqbFqg3u02XNb3FZiQwKrx-MMU8OfPU&index=5
- ref: https://www.cnblogs.com/jihexiansheng/p/17645113.html
- ref: https://blog.csdn.net/qq_40178082/article/details/135156695
- ref: https://blog.csdn.net/Python_0011/article/details/154824998?spm=1001.2101.3001.4242.1&utm_relevant_index=3
- ref: https://blog.csdn.net/zhuangdk/article/details/121147801

# ieee1687
- ref: https://www.cnblogs.com/jihexiansheng/p/17645113.html