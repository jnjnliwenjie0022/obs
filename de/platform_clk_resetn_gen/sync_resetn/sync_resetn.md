# concept (TODO)

- 結論:
	- 如果是 reset 的屬性是 sync, 即使電路設計使用 async, 也會進行 STA 分析, 安全!
		- reset 完全跟 clock 同步, 視爲 normal data path
	- 如果是 reset 的屬性是 async, 要實現 async assert and sync deassert
		- async assert 不做 STA 分析, 

- ref: https://vocus.cc/article/66aa2b66fd897800016831f0
- ref: https://www.cnblogs.com/rednodel/p/13960199.html
- ref: https://zhuanlan.zhihu.com/p/167305718

# design
- ![[resetn_design.svg|1000]]
- sync_resetn特性
	- async assert:
		- 確保進入reset的時候, 在所有clock domain下都是同時且瞬間
		- PLL可能還沒有開始,這個方法可以避免需要clock的問題,clock與assert resetn無關
	- sync deassert: 確保脫離reset的時候, 是基於clk, 並使用syncer處理亞穩態
	- 單看進入resetn: 只要其中一個信號進入resetn, 則輸出就要進入resetn
	- 單看脫離resetn: 兩個信號都要脫離resetn, 同時clk爲posedge, 則脫離resetn
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