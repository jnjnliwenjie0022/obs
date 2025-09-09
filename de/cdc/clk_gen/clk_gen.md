# ASIC

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

- 需要instance特殊的cell
```verilog
	BUFGCE	TL_UL_CLK_MUX_INST (
		.I	(clk_temp		),
		.CE	(1'b1			),
		.O	(clk_out		)
	);
```