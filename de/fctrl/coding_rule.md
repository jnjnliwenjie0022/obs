# mandatory
1. \_set
2. \_clr
3. \_en

# setclr_uarch
不論
```verilog
// high prioirty set
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
// high prioirty clr
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

