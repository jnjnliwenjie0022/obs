- 有兩種 domain cross 的情景
	- CDC (Cross Domain Cross)
	- RDC (Reset Domain Cross)
	- ![[Pasted image 20251021022807.png]]
# metastable_state

- ref: https://blog.csdn.net/qq_36045093/article/details/119394457
- metastable state 發生在以下情景
	- RDC (因爲 async assert reset 導致的 setup / hold time violation)
	- reset glitch (async 電路的 glitch 限制)
	- CDC (setup / hold time violation)
	- clock glitch (async 電路的 glitch 限制)
	- recovery and removal time violation (Tool 會處理, 針對 sync deassert reset)
	- setup and hole time violation (Tool 會處理, 針對 data)
- 看起來會造成 metastable state, 但實際上不會
	- 在 reset 狀態下, clock 不穩定