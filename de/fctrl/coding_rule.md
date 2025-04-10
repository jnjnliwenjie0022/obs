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
assign p0_ready = ~p1_valid | p1_ready

wire p1_valid_set = p0_valid;
wire p1_valid_clr = p1_valid;
wire p1_valid_nx = p1_valid_set | (p1_valid & ~p1_valid_clr);
always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		p1_valid <= 1'd0;
	else
		p1_valid <= p1_valid_nx;



// uarch 1: self clear
wire p1_valid_clr = p1_valid;

// uarch 2: clr > set (only flag control)
always @ (posedge aclk or negedge aresetn) begin
	if (aresetn) begin
		p1_flag <= 'd0;
	end else begin
		p1_flag <= p1_flag_nx;
	end
end

wire p1_flag_set = ...
wire p1_flag_clr = ...
wire p1_flag_nx = ~p1_flag_clr & (p1_flag_set | p1_flag);
```
```