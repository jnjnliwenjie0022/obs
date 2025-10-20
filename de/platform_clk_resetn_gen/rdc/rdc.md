
- 以下是 resetn 在 RTL 上的描述, 必然是一個 aync 的電路設計, 雖然電路設計是 async, 但不代表 signal behavior 是 async
```verilog
always @ (posedge clk or negedge resetn)
```
- resetn 的屬性有以下幾種
	- hard reset
		- hardware reset
			- assert: async behavior
			- deassert: sync behavior
		- power-on reset
			- assert: async behavior
			- deassert: sync behavior
	- soft reset
		- assert: sync behavior
		- deassert: sync behavior
		- source: CPU
	- delay reset
		- assert: sync behavior
		- deassert: sync behavior
		- source: HW
- 分析方式
	- assert async:
		- 無法做 STA 分析, 因為 async behavior 本來就無法分析
		- 有 RDC 問題, 因為 async behavior, 導致無法做 STA 分析, 導致 RDC 問題
	- deassert sync:
		- 會做 STA 分析, 針對 recovery time and removal time
		- 無 RDC 問題, 因為 sync behavior 可以 STA 分析, 不會出現 RDC 問題
	- assert sync:
		- 可以做 STA 分析, 可以分析 reset -> Q, 如果做 STA 分析, 則無 RDC 問題
			- ref: [[Techniques to identify reset metastability issues due to soft resets.pdf]]
		- 大多數情況下不分析 STA, 所以有 RDC 問題



此時一地方耳機歷史社會這是一個複雜問