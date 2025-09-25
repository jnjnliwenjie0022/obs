# notice

- 不需要高精度且是同相位的部分通常會在 subsystem 上處理
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
				- 不用處理CDC
				- 不用處理STA
			- 方法2: original_clk -> counter -> clk -> register
				- 可行但不推薦
				- 不用處理CDC
				- 要處理STA
					- ref: https://www.youtube.com/watch?v=wmyelwAOSIE
	- 針對FPGA
		- 需要高精度
			- 先經過PLL/MMCM/DCM
				- ref: https://digilent.com/blog/vcos-mmcms-plls-and-cmts-clocking-resources-on-fpga-boards/
			- 再經過BUF
		- 不需要高精度且是同相位: 
			- 方法1: original_clk -> counter -> BUF -> 
			- 方法2:
			- 先經過counter
			- counter的結果再經過BUF(**不要**用 LUT/FF 去當做“全片時鐘”的路徑：在 FPGA 中，如果你用一般邏輯產生新時鐘，路徑不會走 global clock network，會導致 skew/jitter/無法 timing closure)
			- 可以產生: clk 和 en
				- 建議使用en，可以避免CDC和第二時鐘問題，減少麻煩
				- ICG的部分Tool會自行處理

# sync_clk_gen
## asic

- 推薦使用Johnson Counter
	- ref: https://www.chipverify.com/verilog/verilog-johnson-counter
- 在simulation的時候要確保clk為“0”

```verilog
	output			clk_out;
	always @(posedge clk_in or negedge resetn) begin
		if (!resetn)
			cnt = 1'b0;
		else
			cnt = ~cnt;
	end
	assign clk_temp = cnt;
	assign clk_out = clk_temp;
```

- 在simulation的時候要確保除了clk和reset為“0+”

```verilog
	output			clk_en;
	always @(posedge clk_in or negedge resetn) begin
		if (!resetn)
			clk_en_r <= 1'b1;
		else
			clk_en_r <= ~clk_en_r;
	end
	assign clk_en   = clk_en_r;
```

## fpga
## bufgce

- 需要instance特殊的cell，全局時鐘緩衝
	- CE=0，Q=0，否則Q=I
```verilog
	BUFGCE	TL_UL_CLK_MUX_INST (
		.I	(clk_temp		),
		.CE	(1'b1			),
		.O	(clk_out		)
	);
```
