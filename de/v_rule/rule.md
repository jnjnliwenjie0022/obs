# mandatory
- [ V ] \_set 
- [ V ] \_clr
- [ V ] \_en
```verilog
wire p1_data_en = p1_valid & p1_ready;
always @ (posedge clk) begin
	if (p1_data_en)
		p1_data <= p1_data_nx;
end
```
- [ V ] signal flatten (avoid reentrancy)
	-  不可以出現 \_taken，但心中要有這個概念，taken = valid & ready
- [ V ] \_valid and \_ready are always independent
- [ V ] \_request and \_grant are always dependent
- [ V ] Inter-module signals:
	-  SRC\_DES\_(channel)\_(stage)\_signal...
	-  SRC\_DES\_(channel)\(\#stage)\_signal...
- [ V ] Intra-module signals: 
	-  (channel)\_(stage)\_signal...
	-  (channel)\(\#stage)\_signal...
- [ V ] without using casez
- [ V ] case needs unknown propagation on default syntax
- [ V ] without using supply0 or supply1 EX: 'd0 or 'd1
- [ V ] zero replication
    - bit extension不能是"0” EX: {0{bit_extension}}
	- generate or extend
```verilog
// genereate method
generate
if (MSHR_DEPTH == 16) begin : gen_mshr_entry_issue_done_eq_16
       assign mshr_entry_issue_done_ext = mshr_entry_issue_done;
end
else begin : gen_mshr_entry_issue_done_less_than_max
       assign mshr_entry_issue_done_ext = {{(16-MSHR_DEPTH){1'b0}},mshr_entry_issue_done};
end
endgenerate

// extend method
assign {ext1,mshr_entry_issue_done_ext} = {{(17-MSHR_DEPTH){1'b0}},mshr_entry_issue_done};
```
- [ O ] aggregate signal
```
// leverage the same control part for status and rdata. (Reduce similar and duplicated coding)
assign {m2_mem_status, m2_mem_rdata} = ({(XLEN+`LSMEM_BITS){m2_ilm &  lm_support}} & {ilm_status, ilm_rdata})
                                    | ({(XLEN+`LSMEM_BITS){m2_dlm &  lm_support}} & {dlm_status, dlm_rdata})
                                    | ({(XLEN+`LSMEM_BITS){m2_dcu | ~lm_support}} & {dcu_status, dcu_rdata})
                                    ;
```
- [ O ] bit width list
```verilog
// BITWIDTH 
parameter  ADDR_WIDTH = `original_default;
parameter  DATA_WIDTH = `original_default;
localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
input  [ADDR_MSB:0] addr;
input  [DATA_MSB:0] wdata;
output [DATA_MSB:0] rdata;
```
- [ O ] parameter list
```verilog
// CONST 
localparam CONST_1 = 64'd1;
localparam CONST_2 = 64'd2;
localparam CONST_3 = 64'd3;
// STATE 
localparam STATE_IDLE = 4'd1;
localparam STATE_EXEC = 4'd2;
localparam STATE_DONE = 4'd3;
```
- [ O ] signal list
```
_gt_: greater than
_ge_: greater than or equal to
_lt_: less than
_le_: less than or equal to
_eq_: equal to
_ne_: not equal to 
_a1: ahead 1T
_a2: ahead 2T
_d1: delay 1T
_d2: delay 2T
```
- [ O ] instance fifo
```verilog
wire d1_fifo_wr;
wire d1_fifo_rd;
wire d1_fifo_empty;
wire d1_fifo_full;
wire d1_fifo_rdata;
wire d1_fifo_wdata;
wire d1_fifo_rrdy;
wire d1_fifo_wrdy;

assign d1_fifo_rrdy = ~d1_fifo_empty;
assign d1_fifo_wrdy = ~d1_fifo_full;
assign d1_fifo_wr = d1_fifo_wrdy & ...etc;
assign d1_fifo_rd = d1_fifo_rrdy & ...etc;

acc_fifo # (
     .DATA_WIDTH (1 )
    ,.FIFO_DEPTH (2 )
) u_d1_fifo (
     .reset_n      (rstn          )
    ,.clk          (clk           )
    ,.wr           (d1_fifo_wr    )
    ,.wr_data      (d1_fifo_wdata )
    ,.rd           (d1_fifo_rd    )
    ,.rd_data      (d1_fifo_rdata )
    ,.empty        (d1_fifo_empty )
    ,.full         (d1_fifo_full  )
);

```
# highspeed

# setclr_uarch
不論flag還是valid基本上都有3種基本結構 [[nds_flag_setclr.v]]

1. high priority set
2. high priority clr
3. self clr
4. debubble
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

