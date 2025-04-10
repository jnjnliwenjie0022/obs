# mandatory
1. [ V ] \_set 
2. [ V ] \_clr
3. [ V ] \_en
```verilog
wire p1_data_en = p1_valid & p1_ready;
always @ (posedge clk) begin
	if (p1_data_en)
		p1_data <= p1_data_nx;
end
```
4. [ X ] \_taken
	1. 不可以出現 \_taken，但心中要有這個概念，taken = valid & ready
5. [ V ] \_valid and \_ready are always independent
6. [ V ] \_ack and \_grant are always dependent
```verilog
// PORT
module CORE_H1_H2_DES (
	SRC_DES_signal_1
	SRC_DES_signal_2
	DES_SRC_signal_3
	DES_SRC_signal_4
	DES_sign
)
// CONST VALUE
localparam CONST_1 = 64'd1;
localparam CONST_2 = 64'd2;
localparam CONST_3 = 64'd3;
// STATE VALUE
localparam STATE_IDLE = 4'd1;
localparam STATE_EXEC = 4'd2;
localparam STATE_DONE = 4'd3;
```

# setclr_uarch
不論flag還是valid基本上都有3種基本結構 [[nds_flag_setclr.v]]

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

