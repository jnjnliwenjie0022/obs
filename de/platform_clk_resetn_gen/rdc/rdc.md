
- 以下是 resetn 在 RTL 上的描述, 必然是一個 aync 的電路設計, 雖然電路設計是 async, 但不代表信號行為是 async 的
```verilog
always @ (posedge clk or negedge resetn)
```
- resetn 的屬性有以下幾種
	- software reset
	- hardware resetn