
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
	- assert async behavior:
		- 無法做 STA 分析, 因為 async behavior 本來就無法分析
		- 有 RDC 問題, 因為 async behavior, 導致無法做 STA 分析, 導致 RDC 問題
	- deassert sync behavior:
		- 會做 STA 分析, 針對 recovery time and removal time
		- 無 RDC 問題, 因為 sync behavior 可以 STA 分析, 不會出現 RDC 問題
		- Notice: 雖然不會有 metastable state 的問題, 但 reset release 的時間不一致, 導致邏輯錯誤
			- 原因1: deassert reset 即使同時接受到 deassert reset, 在不同頻率下, 導致脫離 reset 的時間有差異, 譬如 afifo
			- 原因2: deassert reset 因爲 delay 的關係, 接收到 deassert reset 時間有差異, 導致脫離 reset 的時間有差異
	- assert sync behavior:
		- 非主要情景:
			- ref: [[Techniques to identify reset metastability issues due to soft resets.pdf]]
			- 可以做 STA 分析, 可以分析 reset -> Q, 如果做 STA 分析, 則無 RDC 問題
		- 主要情景: 
			- ref: https://bbs.eetop.cn/thread-887603-2-1.html
			- ref: https://blog.csdn.net/dongdongnihao_/article/details/133487705
			- 大多數情況下不分析 STA, 因為一定有 assert async behavior, 至少 power-on reset 就是一種, assert sync behavior (soft reset) 只是其中一種 reset 情景而已, 所以有 RDC 問題
- RDC 特性說明
	- ref: https://besttechviews.com/reset-domain-crossing-asynchronous-resets-rdc/
	- 只要 reset domain 就會發生, 不論是 sync clock 或是 async clock 都有機會
	- RDC 需要 global 分析, CDC 只需要 local 分析
	- RDC 的 MTBF (T / failure_times) 比 CDC 高
- reset metastable state 發生情景
	- RDC (因爲 async assert reset 導致的 setup / hold time violation)
	- reset glitch (async 電路的 glitch 限制)
	- recovery and removal time violation (Tool 會處理, 針對 sync deassert reset)

# reset_assert

- ref: https://zhuanlan.zhihu.com/p/688124932?share_code=184pakQ1DLvVB&utm_psn=1963302042274607187
- ref: https://blog.csdn.net/cy413026/article/details/134078287
- 主要問題: RDC (async assert reset 導致的 setup / hold time violation)
- 方法1: 後級一起 reset assert 
- 方法2: 後級停止頻率
- 方法3: clamp register 使 RDC 路徑目標的數值在 assert reset 的一段時間都不改變, 不改變也意味着不存在 metastable state 

# reset_deassert

- ref: https://zhuanlan.zhihu.com/p/668905496?share_code=XdnvLO2sWikt&utm_psn=1963768132570183217
- 主要問題:  reset release 的時間不一致
- 方法1: 降頻後 reset
- 方法2: 停止頻率後 reset
- 方法3: clamp register 使 RDC 路徑目標的數值在 deassert reset 確定前都不改變, 不改變也意味着不存在 metastable state 

# soft_reset

- ref: https://zhuanlan.zhihu.com/p/668905496?share_code=XdnvLO2sWikt&utm_psn=1963768132570183217