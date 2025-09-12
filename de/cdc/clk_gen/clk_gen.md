# notice

- 注意事項:
	- Duty Cycle 需要 50%
	- Glitch Free
# ASIC

- 推薦使用Johnson Counter
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

# FPGA
## BUFGCE

- 需要instance特殊的cell，全局時鐘緩衝
	- CE=0，Q=0，否則Q=I
```verilog
	BUFGCE	TL_UL_CLK_MUX_INST (
		.I	(clk_temp		),
		.CE	(1'b1			),
		.O	(clk_out		)
	);
```

## MMCM

- ref: https://digilent.com/blog/vcos-mmcms-plls-and-cmts-clocking-resources-on-fpga-boards/