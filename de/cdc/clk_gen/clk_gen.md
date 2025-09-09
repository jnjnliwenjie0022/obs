# ASIC

- 在simulation的時候要確保clk為“0”

```verilog
	always @(posedge clk_in or negedge resetn) begin
		if (!resetn)
			cnt = 1'b0;
		else
			cnt = ~cnt;
	end
	assign clk_temp = cnt;
	assign clk_out = clk_temp;
```

- 在simulation的時候要確保為“0”