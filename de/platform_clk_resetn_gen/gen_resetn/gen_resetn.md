# arch

- ref: https://vocus.cc/article/66aa2b66fd897800016831f0
- ref: https://www.cnblogs.com/rednodel/p/13960199.html
- ref: https://zhuanlan.zhihu.com/p/167305718
- ref: https://www.dzsc.com/dzbbs/20050129/200765203346281152.html
- ref: https://blog.csdn.net/s1_mple/article/details/145100716
- ref: [[CummingsSNUG2003Boston_Resets_rev1_2.pdf]]
- ref: https://www.dzsc.com/dzbbs/20050129/200765203346281152.html
- resetn arch
	- ![[resetn_arch.svg]]
	- ![[CummingsSNUG2003Boston_Resets_rev1_2.pdf#page=30&rect=65,543,551,719|CummingsSNUG2003Boston_Resets_rev1_2, p.30|500]]
	- 對 frontend 實務而言
		- 對 platform 而言
			- set_false_path -from [get_ports [list i_resetn]]
		- 對 core 而言
			- set_false_path -from [get ports [list core_a_resetn]]
			- set_false_path -from [get ports [list core_b_resetn]]
			- set_false_path -from [get ports [list core_c_resetn]]
- 基本概念:
	- 如果是 reset 的屬性是 sync, 會進行 STA 分析, 安全!
		- EX: always @(posedge clk) if (~resetn)
		- reset 完全跟 clock 同步, 視爲 normal data path
	- 如果是 reset 的屬性是 async, 要實現 async assert and sync deassert
		- EX: always @(posedge clk or negedge resetn) if (~resetn)
		- backend 需要 HFNS (High Fanout Net Synthesis)
		- async assert 
			- 不做 STA 分析 (不做 STA 分析必然產生 metastable state)
			- 需要考慮到 skew, 因爲要考慮到 IR drop 當 register async assert 的時候
			- 需要考慮到 IR drop, 因爲 Fanout 非常大, 當 register async assert 產生瞬間大電流, 需要用 tree balance 處理
			- 需要考慮到 congestion
		- sync deassert
			- **要做 STA 分析: recovery time and removal time**
			- 需要考慮到 skew, 不然會出現 race condition, 保持 skew 小於 1~2 clocks
				- ref: https://www.youtube.com/watch?v=mYSEVdUPvD8&t=27s
			- 需要考慮到 IR Drop
			- 需要考慮到 congestion

# reset_clock_sequence

- ![[reset_clock_sequence.svg]]
- 以上有是那種情景
	- clk0: clk 啓動在 sync deassert reset 之後
	- clk1: clk 啓動在 async assert reset 與 sync deassert reset 之間
	- clk2: clk 啓動在 async assert reset 之前
- clk0: 保證 async deassert reset 的時候 clk 穩定就行
- clk1: 保證 async deassert reset 的時候 clk 穩定就行
- clk2: 保證 async deassert reset 的時候 clk 穩定就行
- 在 simulation 的時候用一下行爲模擬 power-on reset clock sequence 就行
	- ![[power_on_reset_clock_sequence.svg]]
# power_on_reset_clock_sequence

- power-on reset 基於 RC 完成 , deassert 是 async
	- 解決方式: 需要確保 reset release 之後, clock 才啓動, 且 clock 穩定
	- P.S: 在 reset 狀態下, clock 不穩定, 不會造成 metastable state
- power-on reset 基於 PLL 完成, deassert 是 sync
	- 解決方式: 需要確保 reset release 的時候, clock 穩定既可
- power-on reset 基於 RC 或是特殊事件, deassert 是 async, 但 clock 已經啓動, 完蛋!
	- 解決方式: 
	- P.S: 在 clock 穩定下
- 以下是 power-on-reset 基於 RC 產生
	- ![[Measurement of De-assertion Threshold of Power-on-Reset Circuits.pdf#page=1&rect=316,130,544,466|Measurement of De-assertion Threshold of Power-on-Reset Circuits, p.1|500]]
- 以下是 power-on-reset 基於 PLL 產生
	- ref: https://stevenlin08.blogspot.com/2013/08/blog-post_9813.html
	- ![[Pasted image 20251022072848.png|800]]

# reset_high_fanout

- ref: https://www.embedded.com/asynchronous-reset-synchronization-and-distribution-asics-and-fpgas/
- high fanout 會造成
	- IR Drop
	- EM (ElectroMigration)
- 方法1: pipeline
- 方法2: 
	- counter + clock enable + multi-cycle path (.sdc)
	- counter + clock enable
- ![[reset_clock_sequence 1.svg|1000]]
# sync_resetn

- ![[resetn_design.svg|1000]]
- i_resetn特性
	- 可以是 blocking 或是 non-blocking
- sync_resetn特性
	- async assert:
		- 確保進入reset的時候, 在所有clock domain下都是同時且瞬間
		- PLL可能還沒有開始,這個方法可以避免需要clock的問題,clock與assert resetn無關
	- sync deassert: 確保脫離reset的時候, 是基於clk, 並使用syncer處理亞穩態
	- 單看進入resetn: 只要其中一個信號resetn進入, 則輸出就要進入resetn
	- 單看脫離resetn: 兩個信號resetn/i_casc_resetn都要脫離resetn, 同時clk爲posedge, 則脫離resetn
	- Notice: clk必須在脫離resetn啓動
- ![[resetn_tree.svg]]
- Arch1:
	- async assert:
		- resetn->a_resetn
		- resetn->b_resetn
		- resetn->c_resetn
	- sycn deassert:
		- {resetn, a_clk} -> a_resetn
		- {a_resetn, b_clk} -> b_resetn
		- {b_resetn, c_clk} -> c_resetn
- Arch2:
	- async assert:
		- resetn, a1_resetn, b1_resetn ->c_resetn
		- resetn, a1_resetn ->b_resetn
		- resetn ->a_resetn
	- sycn deassert:
		- {resetn, a_clk} -> a_resetn
		- {a_resetn & a1_resetn, b_clk} -> b_resetn
		- {b_resetn & b1_resetn, c_clk} -> c_resetn