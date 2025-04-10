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

// high prioirty set
assign p0_ready = ~p1_valid;

wire p1_valid_set = p0_valid;
wire p1_valid_clr = p1_valid;
wire p1_valid_nx = p1_valid_set | (p1_valid & ~p1_valid_clr);
always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		p1_valid <= 1'd0;
	else
		p1_valid <= p1_valid_nx;

// high prioirty clr
assign p0_ready = ~p1_valid | p1_ready

wire p1_valid_set = p0_valid;
wire p1_valid_clr = p1_ready;
wire p1_valid_nx = (p1_valid_set | p1_valid) & ~p1_valid_clr;
always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		p1_valid <= 1'd0;
	else
		p1_valid <= p1_valid_nx;

// uarch 1: self clear
wire p1_valid_clr = p1_valid;


```