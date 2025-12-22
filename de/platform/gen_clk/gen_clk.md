# concept

- 通常會在 subsystem 和 platform 上處理
- 注意事項:
	- Duty Cycle 需要 50%
	- Glitch Free
- 常見實作方法
	- 針對ASIC
		- 需要高精度
			- 先經過PLL
		- 不需要高精度且是同相位: 
			- 方法1: original_clk -> counter -> en -> register
				- 可行且**推薦**
				- 不用處理ICG, ICG 處理是 Tool 自動處理
				- 不用處理CDC
				- 不用處理STA
			- 方法2: original_clk -> counter -> clk -> register
				- 可能要處理ICG
				- 可能要處理CDC
				- 要處理STA
					- create_generated_clock
					- ref: https://www.youtube.com/watch?v=wmyelwAOSIE
	- 針對FPGA
		- 需要高精度
			- 先經過MMCM/DCM
				- ref: https://digilent.com/blog/vcos-mmcms-plls-and-cmts-clocking-resources-on-fpga-boards/
			- 再經過BUF, 因爲 FPGA 需要經過 BUF 來進入 GRM (General Route Matrix)
		- 不需要高精度且是同相位: 
			- 方法1: original_clk -> counter -> en -> register
			- 方法2: original_clk -> counter -> clk -> BUF (manual) -> register
				- counter的clk結果需要經過BUF(**不要**用 LUT/FF 去當做“全片時鐘”的路徑：在 FPGA 中，如果你用一般邏輯產生新時鐘，路徑不走 GRM，會導致 skew/jitter/無法 timing closure)

## glitch

- Glitch 對於 1 和 0 都有要求, 小於 cell 規範允許的最小寬度, 就是非法
- 對於 Clock 而言, Glitch 是絕對致命的
	- set_min_pulse_width -high 0.4 [get_clocks CLK]
	- set_min_pulse_width -low 0.4 [get_clocks CLK]
	- 在 RTL-level 實務設計上, Clock Glitch 的定義就是最快頻率的最小週期
- 對於 Data 而言, Glitch 不是什麼大問題, 因為 Data 的 Glitch 問題可以被 setup time / hold time detect 到

## skew

# gen_asic_clk

- 合法的 clk 需要考慮到 frontend 和 backend
	- 核心需求: glitch free 以及 clock propagation
- case1: 如果是 tool 自動合成 ICG 則:
	- CELL 的使用: 使用有 CLK 訊息的 CELL, 能 clock propagation
		- CKLNQOPTMAD4BWP30P140 RC_CGIC_INST(.E (enable), .CP (ck_in), .TE(test), .Q (ck_out));
	- SDC 的定義: 不需要定義, 因為 clock propagation 成功
	- Glitch的問題: Lib 自行解決
	- RTL-Simulation: 不需額外處理
	- Gate-level Simulation: 一定需要SDF
	- 結論: 可以
- case2: 如果是 RTL-simulation gck 則:
	- CELL 的使用: 使用無 CLK 訊息的 CELL, 無法 clock propagation
	- SDC 的定義: 需要定義, 因為 clock propagation 失敗
	- Glitch的問題: RTL 處理, 本身邏輯是 glitch free
	- RTL-Simulation: 不需額外處理
	- Gate-level Simulation: GCK 被 replacement 之後, 一定需要吃SDF
	- 結論: 可以
- case3: 如果是 RTL 同相除頻器則:
	- CELL 的使用: 使用無 CLK 訊息的 CELL, 無法 clock propagation
	- SDC 的定義:
		- 需要定義, 因為 clock propagation 失敗
		- 描述到 CELL 的 Q 上而不是 pin 上, 不然相位會失效
			- ref: https://www.cnblogs.com/sasasatori/p/18644635
			- create_generated_clock -name CLK_DIV2 -source [get_ports clk] -divide_by 2 [get_pins u_gen_clk/u_cnt_reg[0]/Q]
			- create_generated_clock -name CLK_DIV4 -source [get_ports clk] -divide_by 4 [get_pins u_gen_clk/u_cnt_reg[1]/Q]
			- create_generated_clock -name CLK_DIV8 -source [get_ports clk] -divide_by 8 [get_pins u_gen_clk/u_cnt_reg[2]/Q]
				- clk 在 module 內以及整合上都不會長 BUFF, 所以可以點在 CELL 上
				- reg 在 module 內可能會有 BUFF, 所以必須點在 CELL 上
	- Glitch的問題: RTL 處理, register out 沒 glitch 問題
	- RTL-Simulation: 
		- RTL描述: always @ (posedge clk) cnt = cnt + 1;
	- Gate-level Simulation: 不需額外處理
		- PS: 建議都吃SDF
	- 結論: 可以
- case4: 如果是 RTL AND gate 做 gck 則:
	- CELL 的使用: 使用無 CLK 訊息的 CELL, 無法 clock propagation
		- ![[clock_propagation.svg]]
	- SDC 的定義: 需要定義, 因為 clock propagation 失敗
	- Glitch的問題: 沒處理
	- RTL-Simulation: 不需額外處理
	- Gate-level Simulation: 不需額外處理
	- 結論: 不行
- case6: 如果是 RTL mux 做 clk switching 則: 
	- CELL 的使用: 使用無 CLK 訊息的 CELL, 無法 clock propagation
	- SDC 的定義: 需要定義, 因為 clock propagation 失敗
	- Glitch的問題: 沒處理
	- RTL-Simulation: 不需額外處理
	- Gate-level Simulation: 不需額外處理
	- 結論: 不行
- case7: 如果是 RTL glitch free clock switching (ex: aclkmux) 則:
	- CELL 的使用: 使用無 CLK 訊息的 CELL, 無法 clock propagation
	- SDC 的定義: 需要定義, 因為 clock propagation 失敗
	- Glitch的問題: RTL 處理
	- RTL-Simulation: 不需額外處理
	- Gate-level Simulation: GCK 和 CLKOR CELL 被 replacement 之後, 一定需要吃SDF
	- 結論:  可以
- Johnson Counter
	- ref: https://www.chipverify.com/verilog/verilog-johnson-counter
- sample clock generator
	- ref: [[sample_kv_clk_gen.v]]

# gen_fpga_clk

- ref: [[基于 BUFGMUX 与 DCM 的 FPGA 时钟电路设计.pdf]]
- wire delay > cell delay
- clock 有專門的 place and route 所形成的 clock network
- clock network 已經經過 balance, 可以保證 clock 進入 Configurable Logic Block (CLB) 的 skew 在一個範圍內
- clock 需要透過專門的 cell 進入專門的 clock network
	- CELL: BUFG 開頭的 CELL (ex: BUFGCTRL/BUFGMUX/BUFGCE)
	- 具有 high driving 和 low latency 的特性
	- 不論是哪一種 CELL, 都是基於 BUFGCTRL
- clock 用 BUFGCTRL 實作 cascade
	- ref: https://docs.amd.com/r/en-US/ug949-vivado-design-methodology/Cascaded-Clock-Buffers
	- ![[Pasted image 20251121144903.png]]
- clock with balanced clock mux 最多 4:1, 如果超過就用 BUFGCTRL-based clock multiplexers 結構
	- ref: https://docs.amd.com/r/en-US/ug949-vivado-design-methodology/Clock-Multiplexing
	- balanced clock mux 可適用於 sync clock (same phase)
	- BUFGCTRL-based clock multiplexers 只適用於 async clock
	- ![[Pasted image 20251121151455.png]]
	- ![[Pasted image 20251121151504.png]]
- 以下是 AndesTech 在 FPGA 上遵守的 rules (很嚴格, 雖然最後也沒有遵守 哈!!)
	- ![[Pasted image 20251121151803.png]]
- BUFGCTRL 是保留所有 PIN 的 BUFG
```verilog
BUFGCTRL DEBUG_CLK_MUX_INST (
	.I0      (fast_clk            ),
	.I1      (slow_clk            ),
	.CE0     (gen_debug_clkmux_en ),
	.CE1     (gen_debug_clkmux_en ),
	.S0      (~smu_core_clk_sel   ),
	.S1      ( smu_core_clk_sel   ),
	.IGNORE0 (1'b0                ),
	.IGNORE1 (1'b0                ),
	.O       (dm_clk              )
);
```
- CE=0，Q=0，否則Q=I
```verilog
BUFGCE	TL_UL_CLK_MUX_INST (
	.I	(clk_temp		),
	.CE	(1'b1			),
	.O	(clk_out		)
);
```
- MMCM/DCM 分別用來倍頻和分頻
	- 具有 high driving 和 low latency 的特性
	- 可以設定 phase alignment 使 phase 完全一致
		- ref: https://blog.csdn.net/u011565038/article/details/138144289?spm=1001.2101.3001.4242.1&utm_relevant_index=3
```verilog
mmcm1 ae350_fpga_clkgen (
	.resetn		(main_rstn		),
	.clk_in1	(T_osch			),
	.clkfb_in	(clkfb_in		),
	.clkfb_out	(clkfb_in		),
	.clk_out1	(clk_60m		),	// 60M
	.clk_out2	(clk_30m		),	// 30M
	.clk_out3	(clk_40m		),	// 40M
	.clk_out4	(clk_20m_0		),	// 20M
	.clk_out5	(clk_20m_1		),	// 20M
	.clk_out6	(clk_66m		),	// 66M
	.clk_out7	(clk_100m		)	// 100M
);
```

# clkmux

## concept

- ![[Pasted image 20251020003416.png|500]]

- 從圖中我們可以發現用 SR-NOR 的電路沒有{1,1}的輸出
- ![[aclkmux_sr.svg]]
## design

- ref: https://aijishu.com/a/1060000000203564
- ref: https://www.youtube.com/watch?v=KBeumQxSyZA
 - 目標:
	- 找到 glitch 的 mux 電路 (主要)
	- 處理 syncer
	- 處理 gck
	- 處理 tr tf
	- 處理 50% duty cycle
- 以下是 only mux waveform (錯誤)
	- ref: https://www.eetimes.com/techniques-to-make-clock-switching-glitch-free/
	- ![[Pasted image 20251020155456.png]]
	- 結論: 只有 mux 一定有 glitch
- 以下是 only gck waveform (錯誤)
	- ![[Pasted image 20251020155026.png]]
	- 結論: 只有 gck 也還是有glitch
- 以下是 sync clock mux 架構圖
	- ![[clkmux.svg]]
	- 以下是 sync clk mux waveform (正確)
		- ![[Pasted image 20251020155629.png]]
	- SDC
		- ref: https://zhuanlan.zhihu.com/p/25638298398
		- ref: https://docs.amd.com/r/en-US/ug903-vivado-using-constraints/Multicycle-Paths
		- SDC 很不好處理, 就SDC而言, 不是很推薦這個設計方式
- 以下是 async clock mux 架構圖 (不論 sync 或是 async 都可以使用)
	- ![[aclkmux.svg]]
	- 以下是 async clk mux waveform (正確)
		- ![[Pasted image 20251020155734.png]]
	- SDC
		- ref: https://blog.csdn.net/tbzj_2000/article/details/78775995
		- ref: https://bbs.eetop.cn/thread-920953-1-1.html
		- ref: https://cloud.tencent.com/developer/article/1819634
		- 對於 Async 而言
			- 不對 clkmux 約束, 因為是 async
			- 不對頻率重新約束, 因為是 async
			- set_clock_groups -asynchronous -name async_clk_group -group {get_clock clk0} -group {get_clock ck1}
		- 對於 Sync 而言
			- 對 clkmux 約束
				- 對 clkmuxMethod 1:
					- set_false_path -from [get_cells dff0 to [get_cells dff1]]
					- set_false_path -from [get_cells dff1 to [get_cells dff2]]
				- 對 clkmux Method 2:
					- foreach_in_collection a [get_cells -hier * -filter "ref_name =~*mux_clk_gfree*"]
					- set name [get_object_name $a]
					- set_false_path -from [get_cells ${name}/diff0] -to [get_cell ${name}/diff1]
					- set_false_path -from [get_cells ${name}/diff1] -to [get_cell ${name}/diff0]
			- 對頻率重新約束, 因為 clock propagation 消失的緣故
				- ref: https://www.sohu.com/a/359504187_99955608
				- #REVIEW 
