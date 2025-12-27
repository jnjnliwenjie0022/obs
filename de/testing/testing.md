
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

- SFF main pin (SO DO can be shared)
	- SI(Scan Input)
	- SO(Scan Output)
	- DI(Data Input)
	- DO(Data Output)
- SFF function
	- shift mode
	- capture mode
- circuit function
	- normal mode
	- test mode
- SFF pros and cons
	- pros
		- 
	- cons