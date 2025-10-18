# concept

- 基本觀念: 
	- 合法的 clk 需要滿足一下

# gen_clk

- 合法的 clk 需要考慮到 frontend 和 backend
	- 核心需求: glitch free 以及 clock propagation
- case1: 如果是 tool 自動合成 ICG 則:
	- CELL 的使用: 使用有 CLK 訊息的 CELL, 能將 clock propagation
		- CKLNQOPTMAD4BWP30P140 RC_CGIC_INST(.E (enable), .CP (ck_in), .TE(test), .Q (ck_out));
	- SDC 的定義: 不需要定義, 因為 clock propagation 成功
	- Glitch的問題: Lib 自行解決
	- RTL-Simulation: 不需額外處理
	- Gate-level Simulation: 一定需要SDF
- case2: 如果是 RTL-simulation gck 則:
	- CELL 的使用: 使用無 CLK 訊息的 CELL, 將 clock propagation
	- SDC 的定義: 需要定義, 因為 clock propagation 失敗
	- Glitch的問題: Lib 自行解決
	- RTL-Simulation: 不需額外處理
	- Gate-level Simulation: 一定需要SDF
# sdc

- ref: https://www.cnblogs.com/sasasatori/p/18644635