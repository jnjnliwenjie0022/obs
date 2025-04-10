# mandatory
1. [ V ] \_set 
2. [ V ] \_clr
3. [ V ] \_en
```verilog
always @ (posedge clk) begin
	if (p1_data_en)
		p1
end
```
4. [ X ] \_taken
	1. 不可以出現 \_taken，但要有這個概念，taken = valid & ready

# setclr_uarch
不論flag還是valid基本上都有3種基本結構

1. high priority set
2. high priority clr
3. self clr
```verilog
// high priority set
assign p0_ready = ~p1_valid | p1_ready

wire p1_valid_set = p0_valid;
wire p1_valid_clr = p1_ready;
wire p1_valid_nx = p1_valid_set | (p1_valid & ~p1_valid_clr);
always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		p1_valid <= 1'd0;
	else
		p1_valid <= p1_valid_nx;
```

```verilog
// high priority clr
wire p1_valid_nx = (p1_valid_set | p1_valid) & ~p1_valid_clr;
always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		p1_valid <= 1'd0;
	else
		p1_valid <= p1_valid_nx;
```

```verilog
// self clear
wire p1_valid_clr = p1_valid;
```

```
// high prioirty set
{signal: [
  {name: 'clk',          wave: 'p.........'},
  {name: 'p1_valid_set', wave: '0.1.......'},
  {name: 'p1_valid_clr', wave: '0...101...'},
  {name: 'p1_valid',     wave: '0..1.010..'},
]}
```

![[Pasted image 20250410143820.png]]

```
// high prioirty clr
{signal: [
  {name: 'clk',          wave: 'p.........'},
  {name: 'p1_valid_set', wave: '0.1.......'},
  {name: 'p1_valid_clr', wave: '0...101...'},
  {name: 'p1_valid',     wave: '0..1......'},
]}
```

![[Pasted image 20250410143759.png]]

