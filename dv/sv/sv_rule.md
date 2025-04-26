[verilog blocking & non-blocking](https://www.chipverify.com/verilog/verilog-blocking-non-blocking-statements)
- (in tb) clk and resetn (0)

```verilog
initial begin
	clk = 0;
	forever begin
		#10;
		clk = ~clk;
	end
end
```

- (in tb) dut interface
	- dut input (0+)，必須使用non-blocking (<=)
		- 因爲input為保證為 (0+)，所以dut output必爲 (0+)，不論dut signal是否為non-blocking/blocking
	- dut output (0+)
- (in tb) always @ (posedge clk)
	- clk為 (0)
	- 内部single為 (0+)
- (in tb) initial begin
	- dut input (0+)
	- dut output (0+)
	- others (0)
- (in tb) 不可以output <= input
	- input和ouput一定會delay一個cycle, 除非目的就是這個不然一律不建議這個寫法
- coding style 1

```verilog
@(posedge clk iff (vif.valid && vif.ready));
item.data = vif.data;
```
- coding style 2

```verilog
vif.data <= item.data;
vif.valid <= 1;
@(posedge clk iff (vif.valid && vif.ready));
vif.valid <= 0;
vif.data <= 'dx
```
# case1
```verilog
initial begin
    fork
        forever begin
            #10;
            test = 1;    // 10
            clk  = ~clk; // 10
            $display("%t, test = %d %d",$time, test, clk); // 10
        end
        forever begin
            @(posedge clk); // 10
            $display("here %t, test = %d %d",$time, test, clk); // 10
        end
    join
end
initial begin
	test = 0;
	{clk,rst_n} <= 0;
	#105 rst_n <= 1;
end
```
```verilog
10, test = 1 1
here                   10, test = 1 1
20, test = 1 0
30, test = 1 1
here                   30, test = 1 1
40, test = 1 0
50, test = 1 1
here                   50, test = 1 1
60, test = 1 0
70, test = 1 1
here                   70, test = 1 1
80, test = 1 0
90, test = 1 1
here                   90, test = 1 1
100, test = 1 0
110, test = 1 1
here                  110, test = 1 1
120, test = 1 0
130, test = 1 1
here                  130, test = 1 1
```
```verilog
initial begin
	fork
		forever begin
			#10;
			test = 1;    // 10
			clk  <= ~clk; // 10+
			$display("%t, test = %d %d",$time, test, clk); // 10
		end
		forever begin
			@(posedge clk); // 10+
			$display("here %t, test = %d %d",$time, test, clk); // 10+
		end
	join
end
initial begin
	test = 0;
	{clk,rst_n} <= 0;
	#105 rst_n <= 1;
end
```
```verilog
10, test = 1 0
here                   10, test = 1 1
20, test = 1 1
30, test = 1 0
here                   30, test = 1 1
40, test = 1 1
50, test = 1 0
here                   50, test = 1 1
60, test = 1 1
70, test = 1 0
here                   70, test = 1 1
80, test = 1 1
90, test = 1 0
here                   90, test = 1 1
100, test = 1 1
110, test = 1 0
here                  110, test = 1 1
120, test = 1 1
130, test = 1 0
here                  130, test = 1 1
```
```verilog
initial begin
	fork
		forever begin
			#10;
			test <= 1;    // 10+
			clk  = ~clk; // 10
			$display("%t, test = %d %d",$time, test, clk); // 10
		end
		forever begin
			@(posedge clk); // 10
			$display("here %t, test = %d %d",$time, test, clk); // 10
		end
	join
end
initial begin
	test = 0;
	{clk,rst_n} <= 0;
	#105 rst_n <= 1;
end
```
```verilog
10, test = 0 1
here                   10, test = 0 1
20, test = 1 0
30, test = 1 1
here                   30, test = 1 1
40, test = 1 0
50, test = 1 1
here                   50, test = 1 1
60, test = 1 0
70, test = 1 1
here                   70, test = 1 1
80, test = 1 0
90, test = 1 1
here                   90, test = 1 1
100, test = 1 0
110, test = 1 1
here                  110, test = 1 1
120, test = 1 0
130, test = 1 1
here                  130, test = 1 1
```
```verilog
initial begin
	fork
		forever begin
			#10;
			test <= 1;    // 10+
			clk  <= ~clk; // 10+
			$display("%t, test = %d %d",$time, test, clk); // 10
		end
		forever begin
			@(posedge clk); // 10+
			$display("here %t, test = %d %d",$time, test, clk); // 10+
		end
	join
end
initial begin
	test = 0;
	{clk,rst_n} <= 0;
	#105 rst_n <= 1;
end
```
```verilog
10, test = 0 0
here                   10, test = 1 1
20, test = 1 1
30, test = 1 0
here                   30, test = 1 1
40, test = 1 1
50, test = 1 0
here                   50, test = 1 1
60, test = 1 1
70, test = 1 0
here                   70, test = 1 1
80, test = 1 1
90, test = 1 0
here                   90, test = 1 1
100, test = 1 1
110, test = 1 0
here                  110, test = 1 1
120, test = 1 1
130, test = 1 0
here                  130, test = 1 1
```