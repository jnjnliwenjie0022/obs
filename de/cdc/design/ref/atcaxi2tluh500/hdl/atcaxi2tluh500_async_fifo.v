module atcaxi2tluh500_async_fifo (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  wclk,     
        	  wreset_n, 
        	  wdata,    
        	  wvalid,   
        	  wready,   
        	  rclk,     
        	  rreset_n, 
        	  rdata,    
        	  rvalid,   
        	  rready    
        // VPERL_GENERATED_END
);

parameter DEPTH = 4;
parameter WIDTH = 8;
parameter SYNC_STAGE = 2;
parameter RDATA_DFF = 0;
parameter RAR_SUPPORT = 0;

input                       wclk;
input                       wreset_n;
input           [WIDTH-1:0] wdata;
input                       wvalid;
output                      wready;
input                       rclk;
input                       rreset_n;
output          [WIDTH-1:0] rdata;
output                      rvalid;
input                       rready;

localparam CW = $unsigned($clog2(DEPTH)) + 1;
localparam CL = 2**$unsigned($clog2(DEPTH));

wire                        rvalid_int;
wire                        rready_int;
wire            [WIDTH-1:0] rdata_int;

wire                        wfire;
wire               [CL-1:0] wptr;
reg                [CW-1:0] wcnt;
wire               [CW-1:0] wcnt_inc;
reg                [CW-1:0] wcnt_gray;
wire               [CW-1:0] wcnt_gray_nx;
wire               [CW-1:0] wcnt_gray_sync;

wire                        rfire;
reg                [CL-1:0] rptr;
wire               [CL-1:0] rptr_nx;
reg                [CW-1:0] rcnt;
wire               [CW-1:0] rcnt_inc;
reg                [CW-1:0] rcnt_gray;
wire               [CW-1:0] rcnt_gray_nx;
wire               [CW-1:0] rcnt_gray_sync;

wire         [WIDTH*CL-1:0] mem;
wire               [CL-1:0] mem_en;

wire full;
wire empty;

assign wfire = wvalid & wready;
assign rfire = rvalid_int & rready_int;

assign wready = ~full;
assign rvalid_int = ~empty;

assign empty = rcnt_gray == wcnt_gray_sync;

generate
if (CW < 3) begin : gen_full_2entry
    assign full = wcnt_gray == ~rcnt_gray_sync;
end
else begin : gen_full
    assign full = wcnt_gray == ~(rcnt_gray_sync ^ {2'b0, {CW-2{1'b1}}});
end
endgenerate

assign wcnt_gray_nx = wcnt_inc ^ {1'b0, wcnt_inc[CW-1:1]};
always @(posedge wclk or negedge wreset_n)begin
    if(!wreset_n)begin
        wcnt_gray <= {CW{1'b0}};
    end
    else if(wfire)begin
        wcnt_gray <= wcnt_gray_nx;
    end
end

assign wcnt_inc = wcnt + {{CW-1{1'b0}}, 1'b1};
always @(posedge wclk or negedge wreset_n)begin
    if(!wreset_n)begin
        wcnt <= {CW{1'b0}};
    end
    else if(wfire)begin
        wcnt <= wcnt_inc;
    end
end

assign rcnt_gray_nx = rcnt_inc ^ {1'b0, rcnt_inc[CW-1:1]};
always @(posedge rclk or negedge rreset_n)begin
    if(!rreset_n)begin
        rcnt_gray <= {CW{1'b0}};
    end
    else if(rfire)begin
        rcnt_gray <= rcnt_gray_nx;
    end
end

assign rcnt_inc = rcnt + {{CW-1{1'b0}}, 1'b1};
always @(posedge rclk or negedge rreset_n)begin
    if(!rreset_n)begin
        rcnt <= {CW{1'b0}};
    end
    else if(rfire)begin
        rcnt <= rcnt_inc;
    end
end

atcaxi2tluh500_bin2onehot #(.N(CL)) u_rptr_nx (.out(rptr_nx), .in(rcnt_inc[CW-2:0]));
always @(posedge rclk or negedge rreset_n)begin
    if(!rreset_n)begin
        rptr <= {{CL-1{1'b0}}, 1'b1};
    end
    else if(rfire)begin
        rptr <= rptr_nx;
    end
end

generate
genvar l;
for(l=0; l<CW; l=l+1)begin : gen_ptr_sync
atcaxi2tluh500_sync_l2l #(
    .SYNC_STAGE(SYNC_STAGE),
    .RESET_VALUE(1'b0)
) u_wcnt_sync (
    .resetn(rreset_n),
    .clk(rclk),
    .d(wcnt_gray[l]),
    .q(wcnt_gray_sync[l])
);

atcaxi2tluh500_sync_l2l #(
    .SYNC_STAGE(SYNC_STAGE),
    .RESET_VALUE(1'b0)
) u_rcnt_sync (
    .resetn(wreset_n),
    .clk(wclk),
    .d(rcnt_gray[l]),
    .q(rcnt_gray_sync[l])
);
end
endgenerate

atcaxi2tluh500_bin2onehot #(.N(CL)) u_wptr (.out(wptr), .in(wcnt[CW-2:0]));
assign mem_en = wptr & {CL{wfire}};

generate
genvar i;
for (i=0; i<CL; i=i+1) begin : gen_mem
	atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(WIDTH)) u_mem_dff (.clk(wclk), .resetn(wreset_n), .en(mem_en[i]), .d(wdata), .q(mem[i*WIDTH+:WIDTH]));
end
endgenerate

atcaxi2tluh500_mux_onehot #(
    .N(CL),
    .W(WIDTH)
) u_rdata_sel (
    .out(rdata_int),
    .sel(rptr),
    .in(mem)
);

generate
if (RDATA_DFF) begin : gen_rdata_dff
    wire [WIDTH-1:0] data;
    reg              rdata_valid;
    wire             rdata_valid_nx;
    atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(WIDTH)) u_data_dff (.clk(rclk), .resetn(rreset_n), .en(rfire), .d(rdata_int), .q(data));
    assign rdata_valid_nx = (rdata_valid & ~rready) | rvalid_int;
    always @(posedge rclk or negedge rreset_n)begin
        if(!rreset_n)begin
            rdata_valid <= 1'b0;
        end
        else begin
            rdata_valid <= rdata_valid_nx;
        end
    end
    assign rvalid = rdata_valid;
    assign rready_int = ~rdata_valid | rready;
    assign rdata = data;
end
else begin : gen_rdata_connection
    assign rvalid = rvalid_int;
    assign rready_int = rready;
    assign rdata = rdata_int;
end
endgenerate

endmodule

