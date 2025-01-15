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
針對clk and rst_n
```verilog
initial begin
	clk = 0;
	forever #10 clk = ~clk;
end
```

```verilog
initial begin
	rst_n = 1;
	@(posedge clk);
	rst_n = 0;
	rst_n = 1;
end
```

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