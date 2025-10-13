module atcaxi2tluh500_axif (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  aclk,     
        	  aresetn,  
        	  clk,      
        	  clk_en,   
        	  resetn,   
        	  awready,  
        	  awvalid,  
        	  awid,     
        	  awaddr,   
        	  awlen,    
        	  awsize,   
        	  awburst,  
        	  awcache,  
        	  awprot,   
        	  wready,   
        	  wvalid,   
        	  wdata,    
        	  wstrb,    
        	  wlast,    
        	  bready,   
        	  bvalid,   
        	  bid,      
        	  bresp,    
        	  arready,  
        	  arvalid,  
        	  arid,     
        	  araddr,   
        	  arlen,    
        	  arsize,   
        	  arburst,  
        	  arcache,  
        	  arprot,   
        	  rready,   
        	  rvalid,   
        	  rid,      
        	  rdata,    
        	  rresp,    
        	  rlast,    
        	  awready_buf,
        	  awvalid_buf,
        	  awid_buf, 
        	  awaddr_buf,
        	  awlen_buf,
        	  awsize_buf,
        	  awburst_buf,
        	  awcache_buf,
        	  awprot_buf,
        	  wready_buf,
        	  wvalid_buf,
        	  wdata_buf,
        	  wstrb_buf,
        	  wlast_buf,
        	  bready_buf,
        	  bvalid_buf,
        	  bid_buf,  
        	  bresp_buf,
        	  arready_buf,
        	  arvalid_buf,
        	  arid_buf, 
        	  araddr_buf,
        	  arlen_buf,
        	  arsize_buf,
        	  arburst_buf,
        	  arcache_buf,
        	  arprot_buf,
        	  rready_buf,
        	  rvalid_buf,
        	  rid_buf,  
        	  rdata_buf,
        	  rresp_buf,
        	  rlast_buf 
        // VPERL_GENERATED_END
);

parameter	ADDR_WIDTH	= 64;
parameter	DATA_WIDTH	= 256;
parameter	ID_WIDTH	= 4;
parameter	ASYNC 		= 0;
parameter	SYNC_STAGE	= 3;
parameter	ASYNC_DEPTH	= 8;
parameter	AFIFO_DP_SYNC	= 0;
parameter	RAR_SUPPORT	= 0;

// Async. (ASYNC == 1)
// 	aclk, aresetn for axi domain
// 	clk, resetn for tl domain
// 	clk_en unused
// Sync. (ASYNC == 0)
// 	aclk, aresetn unused
// 	clk, resetn for tl domain
// 	clk_en for clock ratio

input	aclk;
input	aresetn;

input	clk;
input	clk_en;
input	resetn;

// == AXI write address channel
output				awready;
input				awvalid;
input	[(ID_WIDTH-1):0]	awid;
input	[(ADDR_WIDTH-1):0]	awaddr;
input	[7:0]			awlen;
input	[2:0]			awsize;
input	[1:0]			awburst;
input	[3:0]			awcache;
input	[2:0]			awprot;
// == AXI write data channel
output				wready;
input				wvalid;
input	[(DATA_WIDTH-1):0]	wdata;
input	[((DATA_WIDTH/8)-1):0]	wstrb;
input				wlast;
// == AXI write response channel
input				bready;
output				bvalid;
output	[(ID_WIDTH-1):0]	bid;
output	[1:0]			bresp;
// == AXI read address channel
output				arready;
input				arvalid;
input	[(ID_WIDTH-1):0]	arid;
input	[(ADDR_WIDTH-1):0]	araddr;
input	[7:0]			arlen;
input	[2:0]			arsize;
input	[1:0]			arburst;
input	[3:0]			arcache;
input	[2:0]			arprot;
// == AXI read data channel
input				rready;
output				rvalid;
output	[(ID_WIDTH-1):0]	rid;
output	[(DATA_WIDTH-1):0]	rdata;
output	[1:0]			rresp;
output				rlast;

// == AXI write address channel
input				awready_buf;
output				awvalid_buf;
output	[(ID_WIDTH-1):0]	awid_buf;
output	[(ADDR_WIDTH-1):0]	awaddr_buf;
output	[7:0]			awlen_buf;
output	[2:0]			awsize_buf;
output	[1:0]			awburst_buf;
output	[3:0]			awcache_buf;
output	[2:0]			awprot_buf;
// == AXI write data channel
input				wready_buf;
output				wvalid_buf;
output	[(DATA_WIDTH-1):0]	wdata_buf;
output	[((DATA_WIDTH/8)-1):0]	wstrb_buf;
output				wlast_buf;
// == AXI write response channel
output				bready_buf;
input				bvalid_buf;
input	[(ID_WIDTH-1):0]	bid_buf;
input	[1:0]			bresp_buf;
// == AXI read address channel
input				arready_buf;
output				arvalid_buf;
output	[(ID_WIDTH-1):0]	arid_buf;
output	[(ADDR_WIDTH-1):0]	araddr_buf;
output	[7:0]			arlen_buf;
output	[2:0]			arsize_buf;
output	[1:0]			arburst_buf;
output	[3:0]			arcache_buf;
output	[2:0]			arprot_buf;
// == AXI read data channel
output				rready_buf;
input				rvalid_buf;
input	[(ID_WIDTH-1):0]	rid_buf;
input	[(DATA_WIDTH-1):0]	rdata_buf;
input	[1:0]			rresp_buf;
input				rlast_buf;

wire	ax_clk, ax_clk_en, ax_resetn, tl_clk, tl_resetn;

generate
if (ASYNC == 0) begin : gen_sync
	assign ax_clk = clk;
	assign ax_clk_en = clk_en;
	assign ax_resetn = resetn;
	assign tl_clk = clk;
	assign tl_resetn = resetn;
	wire nds_unused_aclk = aclk;
	wire nds_unused_aresetn = aresetn;
	wire nds_unused_tl_clk = tl_clk;
	wire nds_unused_tl_resetn = tl_resetn;
	
// == AXI write address channel
	atcaxi2tluh500_elastic_buffer_i #(
		.DW		(ID_WIDTH+ADDR_WIDTH+8+3+2+4+3),
		.RAR_SUPPORT	(RAR_SUPPORT)
	) u_aw_buffer (
		.clk		(ax_clk),
		.clk_en		(ax_clk_en),
		.resetn		(ax_resetn),
		.i_valid	(awvalid),
		.i_ready	(awready),
		.din		({ 	awid
				,	awaddr
				,	awlen
				,	awsize
				,	awburst
				,	awcache
				,	awprot
				}),
		.o_valid	(awvalid_buf),
		.o_ready	(awready_buf),
		.dout		({ 	awid_buf
				,	awaddr_buf
				,	awlen_buf
				,	awsize_buf
				,	awburst_buf
				,	awcache_buf
				,	awprot_buf
				})
	);
// == AXI write data channel
	atcaxi2tluh500_elastic_buffer_i #(
		.DW		(DATA_WIDTH+(DATA_WIDTH/8)+1),
		.RAR_SUPPORT	(RAR_SUPPORT)
	) u_w_buffer (
		.clk		(ax_clk),
		.clk_en		(ax_clk_en),
		.resetn		(ax_resetn),
		.i_valid	(wvalid),
		.i_ready	(wready),
		.din		({ 	wdata
				,	wstrb
				,	wlast
				}),
		.o_valid	(wvalid_buf),
		.o_ready	(wready_buf),
		.dout		({ 	wdata_buf
				,	wstrb_buf
				,	wlast_buf
				})
	);
// == AXI read address channel
	atcaxi2tluh500_elastic_buffer_i #(
		.DW		(ID_WIDTH+ADDR_WIDTH+8+3+2+4+3),
		.RAR_SUPPORT	(RAR_SUPPORT)
	) u_ar_buffer (
		.clk		(ax_clk),
		.clk_en		(ax_clk_en),
		.resetn		(ax_resetn),
		.i_valid	(arvalid),
		.i_ready	(arready),
		.din		({ 	arid
				,	araddr
				,	arlen
				,	arsize
				,	arburst
				,	arcache
				,	arprot
				}),
		.o_valid	(arvalid_buf),
		.o_ready	(arready_buf),
		.dout		({ 	arid_buf
				,	araddr_buf
				,	arlen_buf
				,	arsize_buf
				,	arburst_buf
				,	arcache_buf
				,	arprot_buf
				})
	);

	atcaxi2tluh500_elastic_buffer_o #(
		.DW		(ID_WIDTH+2),
		.RAR_SUPPORT	(RAR_SUPPORT)
	) u_b_buffer (
		.clk		(ax_clk),
		.clk_en		(ax_clk_en),
		.resetn		(ax_resetn),
		.i_valid	(bvalid_buf),
		.i_ready	(bready_buf),
		.din		({ 	bid_buf
				,	bresp_buf
				}),
		.o_valid	(bvalid),
		.o_ready	(bready),
		.dout		({ 	bid
				,	bresp
				})
	);

	atcaxi2tluh500_elastic_buffer_o #(
		.DW		(ID_WIDTH+DATA_WIDTH+2+1),
		.RAR_SUPPORT	(RAR_SUPPORT)
	) u_r_buffer (
		.clk		(ax_clk),
		.clk_en		(ax_clk_en),
		.resetn		(ax_resetn),
		.i_valid	(rvalid_buf),
		.i_ready	(rready_buf),
		.din		({ 	rid_buf
				,	rdata_buf
				,	rresp_buf
				,	rlast_buf
				}),
		.o_valid	(rvalid),
		.o_ready	(rready),
		.dout		({ 	rid
				,	rdata
				,	rresp
				,	rlast
				})
	);

end
if (ASYNC == 1) begin : gen_async
	// == AXI write address channel
	wire				awready_tmp;
	wire				awvalid_tmp;
	wire	[(ID_WIDTH-1):0]	awid_tmp;
	wire	[(ADDR_WIDTH-1):0]	awaddr_tmp;
	wire	[7:0]			awlen_tmp;
	wire	[2:0]			awsize_tmp;
	wire	[1:0]			awburst_tmp;
	wire	[3:0]			awcache_tmp;
	wire	[2:0]			awprot_tmp;
	// == AXI write data channel
	wire				wready_tmp;
	wire				wvalid_tmp;
	wire	[(DATA_WIDTH-1):0]	wdata_tmp;
	wire	[((DATA_WIDTH/8)-1):0]	wstrb_tmp;
	wire				wlast_tmp;
	// == AXI read address channel
	wire				arready_tmp;
	wire				arvalid_tmp;
	wire	[(ID_WIDTH-1):0]	arid_tmp;
	wire	[(ADDR_WIDTH-1):0]	araddr_tmp;
	wire	[7:0]			arlen_tmp;
	wire	[2:0]			arsize_tmp;
	wire	[1:0]			arburst_tmp;
	wire	[3:0]			arcache_tmp;
	wire	[2:0]			arprot_tmp;

	assign ax_clk = aclk;
	assign ax_clk_en = 1'b1;
	assign ax_resetn = aresetn;
	assign tl_clk = clk;
	assign tl_resetn = resetn;
	wire nds_unused_clk_en = clk_en;

	atcaxi2tluh500_elastic_buffer_i #(
		.DW		(ID_WIDTH+ADDR_WIDTH+8+3+2+4+3),
		.RAR_SUPPORT	(RAR_SUPPORT)
	) u_aw_buffer (
		.clk		(ax_clk),
		.clk_en		(ax_clk_en),
		.resetn		(ax_resetn),
		.i_valid	(awvalid),
		.i_ready	(awready),
		.din		({ 	awid
				,	awaddr
				,	awlen
				,	awsize
				,	awburst
				,	awcache
				,	awprot
				}),
		.o_valid	(awvalid_tmp),
		.o_ready	(awready_tmp),
		.dout		({ 	awid_tmp
				,	awaddr_tmp
				,	awlen_tmp
				,	awsize_tmp
				,	awburst_tmp
				,	awcache_tmp
				,	awprot_tmp
				})
	);

	atcaxi2tluh500_async_fifo # (
		.WIDTH	(ID_WIDTH+ADDR_WIDTH+8+3+2+4+3),
		.DEPTH	(ASYNC_DEPTH),
		.SYNC_STAGE (SYNC_STAGE),
		.RDATA_DFF (AFIFO_DP_SYNC),
		.RAR_SUPPORT (RAR_SUPPORT)
	) u_aw_async_fifo (
		.wreset_n	(ax_resetn),
		.rreset_n	(tl_resetn),
		.wclk		(ax_clk),
		.rclk		(tl_clk),
		.wdata		({ 	awid_tmp
				,	awaddr_tmp
				,	awlen_tmp
				,	awsize_tmp
				,	awburst_tmp
				,	awcache_tmp
				,	awprot_tmp
				}),
		.wvalid		(awvalid_tmp),
		.wready		(awready_tmp),
		.rdata		({ 	awid_buf
				,	awaddr_buf
				,	awlen_buf
				,	awsize_buf
				,	awburst_buf
				,	awcache_buf
				,	awprot_buf
				}),
		.rvalid		(awvalid_buf),
		.rready		(awready_buf)
	);

	atcaxi2tluh500_elastic_buffer_i #(
		.DW		(DATA_WIDTH+(DATA_WIDTH/8)+1),
		.RAR_SUPPORT	(RAR_SUPPORT)
	) u_w_buffer (
		.clk		(ax_clk),
		.clk_en		(ax_clk_en),
		.resetn		(ax_resetn),
		.i_valid	(wvalid),
		.i_ready	(wready),
		.din		({ 	wdata
				,	wstrb
				,	wlast
				}),
		.o_valid	(wvalid_tmp),
		.o_ready	(wready_tmp),
		.dout		({ 	wdata_tmp
				,	wstrb_tmp
				,	wlast_tmp
				})
	);

	atcaxi2tluh500_async_fifo # (
		.WIDTH	(DATA_WIDTH+(DATA_WIDTH/8)+1),
		.DEPTH	(ASYNC_DEPTH),
		.SYNC_STAGE (SYNC_STAGE),
		.RDATA_DFF (AFIFO_DP_SYNC),
		.RAR_SUPPORT (RAR_SUPPORT)
	) u_w_async_fifo (
		.wreset_n	(ax_resetn),
		.rreset_n	(tl_resetn),
		.wclk		(ax_clk),
		.rclk		(tl_clk),
		.wdata		({ 	wdata_tmp
				,	wstrb_tmp
				,	wlast_tmp
				}),
		.wvalid		(wvalid_tmp),
		.wready		(wready_tmp),
		.rdata		({ 	wdata_buf
				,	wstrb_buf
				,	wlast_buf
				}),
		.rvalid		(wvalid_buf),
		.rready		(wready_buf)
	);

	atcaxi2tluh500_async_fifo # (
		.WIDTH	(ID_WIDTH+2),
		.DEPTH	(ASYNC_DEPTH),
		.SYNC_STAGE (SYNC_STAGE),
		.RDATA_DFF (1),
		.RAR_SUPPORT (RAR_SUPPORT)
	) u_b_async_fifo (
		.wreset_n	(tl_resetn),
		.rreset_n	(ax_resetn),
		.wclk		(tl_clk),
		.rclk		(ax_clk),
		.wdata		({ 	bid_buf
				,	bresp_buf
				}),
		.wvalid		(bvalid_buf),
		.wready		(bready_buf),
		.rdata		({ 	bid
				,	bresp
				}),
		.rvalid		(bvalid),
		.rready		(bready)
	);

	atcaxi2tluh500_elastic_buffer_i #(
		.DW		(ID_WIDTH+ADDR_WIDTH+8+3+2+4+3),
		.RAR_SUPPORT	(RAR_SUPPORT)
	) u_ar_buffer (
		.clk		(ax_clk),
		.clk_en		(ax_clk_en),
		.resetn		(ax_resetn),
		.i_valid	(arvalid),
		.i_ready	(arready),
		.din		({ 	arid
				,	araddr
				,	arlen
				,	arsize
				,	arburst
				,	arcache
				,	arprot
				}),
		.o_valid	(arvalid_tmp),
		.o_ready	(arready_tmp),
		.dout		({ 	arid_tmp
				,	araddr_tmp
				,	arlen_tmp
				,	arsize_tmp
				,	arburst_tmp
				,	arcache_tmp
				,	arprot_tmp
				})
	);

	atcaxi2tluh500_async_fifo # (
		.WIDTH	(ID_WIDTH+ADDR_WIDTH+8+3+2+4+3),
		.DEPTH	(ASYNC_DEPTH),
		.SYNC_STAGE (SYNC_STAGE),
		.RDATA_DFF (AFIFO_DP_SYNC),
		.RAR_SUPPORT (RAR_SUPPORT)
	) u_ar_async_fifo (
		.wreset_n	(ax_resetn),
		.rreset_n	(tl_resetn),
		.wclk		(ax_clk),
		.rclk		(tl_clk),
		.wdata		({ 	arid_tmp
				,	araddr_tmp
				,	arlen_tmp
				,	arsize_tmp
				,	arburst_tmp
				,	arcache_tmp
				,	arprot_tmp
				}),
		.wvalid		(arvalid_tmp),
		.wready		(arready_tmp),
		.rdata		({ 	arid_buf
				,	araddr_buf
				,	arlen_buf
				,	arsize_buf
				,	arburst_buf
				,	arcache_buf
				,	arprot_buf
				}),
		.rvalid		(arvalid_buf),
		.rready		(arready_buf)
	);

	atcaxi2tluh500_async_fifo # (
		.WIDTH	(ID_WIDTH+DATA_WIDTH+2+1),
		.DEPTH	(ASYNC_DEPTH),
		.SYNC_STAGE (SYNC_STAGE),
		.RDATA_DFF (1),
		.RAR_SUPPORT (RAR_SUPPORT)
	) u_r_async_fifo (
		.wreset_n	(tl_resetn),
		.rreset_n	(ax_resetn),
		.wclk		(tl_clk),
		.rclk		(ax_clk),
		.wdata		({ 	rid_buf
				,	rdata_buf
				,	rresp_buf
				,	rlast_buf
				}),
		.wvalid		(rvalid_buf),
		.wready		(rready_buf),
		.rdata		({ 	rid
				,	rdata
				,	rresp
				,	rlast
				}),
		.rvalid		(rvalid),
		.rready		(rready)
	);

end
endgenerate	
endmodule
