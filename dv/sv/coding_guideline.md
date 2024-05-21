[verilog blocking & non-blocking](https://www.chipverify.com/verilog/verilog-blocking-non-blocking-statements)
1. (in tb) clk and resetn (0)
2. (in tb) dut interface
	1. dut input (0+), 可以爲(0/0+), 但必須為(0+)使用 non_blocking (<=)
	2. dut output (0)
3. (in tb) always @ (posedge clk)内的所有變數 (0)
4. (in tb) initial begin
	1. dut input (0+)
	2. dut output (0)
	3. others (0)
5. (in tb) 不可以output <= input  
	input和ouput一定會delay一個cycle, 除非目的就是這個不然一律不建議這個寫法
# rule1
針對dut output
1. 0 
2. blocking
```verilog
@(posedge clk iff (vif.valid && vif.ready));
item.data = vif.data;
```
針對dut input
1. 0+ 
2. non-blocking

```verilog
vif.data <= item.data;
vif.valid <= 1;
@(posedge clk iff (vif.valid && vif.ready));
vif.valid <= 0;
vif.data <= 'dx
```