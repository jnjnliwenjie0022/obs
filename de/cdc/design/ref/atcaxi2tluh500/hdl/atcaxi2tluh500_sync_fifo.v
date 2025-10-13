module atcaxi2tluh500_sync_fifo (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  clk,      
        	  reset_n,  
        	  wdata,    
        	  wvalid,   
        	  wready,   
        	  rdata,    
        	  rvalid,   
        	  rready    
        // VPERL_GENERATED_END
);

parameter DEPTH = 4;
parameter WIDTH = 8;
parameter RAR_SUPPORT = 0;

input                       clk;
input                       reset_n;
input           [WIDTH-1:0] wdata;
input                       wvalid;
output                      wready;
output          [WIDTH-1:0] rdata;
output                      rvalid;
input                       rready;

reg             [DEPTH-1:0] cnt;
wire            [DEPTH-1:0] cnt_nx;
wire                        cnt_en;
reg             [DEPTH-1:0] wptr;
reg             [DEPTH-1:0] rptr;
wire            [DEPTH-1:0] wptr_nx;
wire            [DEPTH-1:0] rptr_nx;
wire                        rptr_en;
wire                        wptr_en;

wire      [WIDTH*DEPTH-1:0] mem;
wire            [DEPTH-1:0] mem_en;
wire                        rfire;
wire                        wfire;

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		cnt <= {DEPTH{1'b0}};
	else if (cnt_en)
		cnt <= cnt_nx;
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		rptr <= {{(DEPTH-1){1'b0}}, 1'b1};
	else if (rptr_en)
		rptr <= rptr_nx;
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		wptr <= {{(DEPTH-1){1'b0}}, 1'b1};
	else if (wptr_en)
		wptr <= wptr_nx;
end

assign rfire = rvalid & rready;
assign wfire = wvalid & wready;

assign cnt_en  = (rfire ^ wfire);
assign cnt_nx  = rfire ? {1'b0, cnt[DEPTH-1:1]} :
		         {cnt[DEPTH-2:0], 1'b1};

assign rptr_en = rfire;
assign wptr_en = wfire;

assign rptr_nx = {rptr[DEPTH-2:0], rptr[DEPTH-1]};
assign wptr_nx = {wptr[DEPTH-2:0], wptr[DEPTH-1]};

assign wready = ~cnt[DEPTH-1];
assign rvalid =  cnt[0];

assign mem_en = wptr & {DEPTH{wfire}};

generate
genvar i;
for (i=0; i<DEPTH; i=i+1) begin : gen_mem
	atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(WIDTH)) u_mem_dff (.clk(clk), .resetn(reset_n), .en(mem_en[i]), .d(wdata), .q(mem[i*WIDTH+:WIDTH]));
end
endgenerate

atcaxi2tluh500_mux_onehot #(
    .N(DEPTH),
    .W(WIDTH)
) u_rdata_sel (
    .out(rdata),
    .sel(rptr),
    .in(mem)
);

endmodule

