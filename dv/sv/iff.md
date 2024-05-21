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
			@(posedge clk iff test == 1); // 10
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
			@(posedge clk iff test == 1); // 10+
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

```