# shift

- On FPGA
	- ![[Pasted image 20260120163549.png|1000]]
		- 修改前: 使用 barrel shift 合成 FPGA bitmap
			- 調用 LUT
		- 修改後: 使用 shift 合成 FPGA bitmap
			- 調用 SRL
			- ![[Pasted image 20260120163717.png|500]]
- On ASIC
	- Technology Library: tcbn28hpcplusbwp30p140ssg0p81vm40c
	- Memory Library    : temn28hpcphssrammacros

|      | barrel shift | normal shift |
| ---- | ------------ | ------------ |
| Freq | 793.651 MHz  | 799.361 MHz  |
| Area | 36128        | 36451        |

# sync_fifo

- 以下是合法寫法
```verilog
always @(posedge clk) begin
	if (wr)
		mem[wr_index] <= wr_data;
end
```
-  
```verilog
always @(posedge clk) begin
	if (wr)
		mem[wr_index] <= wr_data;
	else
		mem[wr_index] <= wr_data;
end
```