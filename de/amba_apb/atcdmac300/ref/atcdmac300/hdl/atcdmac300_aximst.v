`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_aximst( //VPERL: &PORTLIST;
                          // VPERL_GENERATED_BEGIN
                          	  aclk,     
                          	  aresetn,  
                          	  awid,     
                          	  awaddr,   
                          	  awlen,    
                          	  awsize,   
                          	  awburst,  
                          	  awlock,   
                          	  awcache,  
                          	  awprot,   
                          	  awvalid,  
                          	  awready,  
                          	  wstrb,    
                          	  wlast,    
                          	  wdata,    
                          	  wvalid,   
                          	  wready,   
                          	  bid,      
                          	  bresp,    
                          	  bvalid,   
                          	  bready,   
                          	  arid,     
                          	  araddr,   
                          	  arlen,    
                          	  arsize,   
                          	  arburst,  
                          	  arlock,   
                          	  arcache,  
                          	  arprot,   
                          	  arvalid,  
                          	  arready,  
                          	  rid,      
                          	  rresp,    
                          	  rlast,    
                          	  rdata,    
                          	  rvalid,   
                          	  rready,   
                          `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                          	  dma1_mst_wr_mask,
                          	  dma1_mst_req,
                          	  dma1_mst_addr,
                          	  dma1_mst_write,
                          	  dma1_mst_size,
                          	  dma1_mst_fix,
                          	  dma1_mst_len,
                          	  dma1_mst_wdata,
                          	  dma1_current_channel,
                          	  mst_dma1_grant,
                          	  mst_dma1_rd_ack,
                          	  mst_dma1_wr_ack,
                          	  mst_dma1_rdata,
                          	  mst_dma1_rlast,
                          	  mst_dma1_error,
                          	  mst_dma1_bvalid,
                          `endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                          	  dma0_mst_wr_mask,
                          	  dma0_mst_req,
                          	  dma0_mst_addr,
                          	  dma0_mst_write,
                          	  dma0_mst_size,
                          	  dma0_mst_fix,
                          	  dma0_mst_len,
                          	  dma0_mst_wdata,
                          	  dma0_current_channel,
                          	  mst_dma0_grant,
                          	  mst_dma0_rd_ack,
                          	  mst_dma0_wr_ack,
                          	  mst_dma0_rdata,
                          	  mst_dma0_rlast,
                          	  mst_dma0_error,
                          	  mst_dma0_bvalid 
                          // VPERL_GENERATED_END
);
localparam	BURST_FIX	=  2'b00;
localparam	BURST_INCR	=  2'b01;
localparam	SLVERR		=  2'b10;
localparam	DECERR		=  2'b11;

input          					aclk;
input          					aresetn;
// AXI master interface
// write address channel signals
output	[2:0]					awid;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]		awaddr;
output	[7:0]					awlen;
output	[2:0]					awsize;
output	[1:0]					awburst;
output						awlock;
output	[3:0]					awcache;
output	[2:0]					awprot;
output						awvalid;
input						awready;
// write data channel signals
output	[(`DMA_WSTRB_WIDTH-1):0]		wstrb;
output						wlast;
output	[(`DMA_DATA_WIDTH-1):0]			wdata;
output						wvalid;
input						wready;
// write response channel signals
input	[2:0]					bid;
input	[1:0]					bresp;
input						bvalid;
output						bready;
// read address channel signals
output	[2:0] 					arid;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]		araddr;
output	[7:0]					arlen;
output	[2:0]					arsize;
output	[1:0]					arburst;
output						arlock;
output	[3:0]					arcache;
output	[2:0]					arprot;
output						arvalid;
input						arready;
// read data channel signals
input	[2:0]					rid;
input	[1:0]					rresp;
input						rlast;
input	[(`DMA_DATA_WIDTH-1):0]			rdata;
input						rvalid;
output						rready;

// Internal DMA interface
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
input						dma1_mst_wr_mask;
input						dma1_mst_req;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]		dma1_mst_addr;
input						dma1_mst_write;
input	[2:0]					dma1_mst_size;
input						dma1_mst_fix;
input	[7:0]					dma1_mst_len;
input	[(`DMA_DATA_WIDTH-1):0]			dma1_mst_wdata;
input	[2:0]					dma1_current_channel;
output						mst_dma1_grant;
output						mst_dma1_rd_ack;
output						mst_dma1_wr_ack;
output	[(`DMA_DATA_WIDTH-1):0]			mst_dma1_rdata;
output						mst_dma1_rlast;
output						mst_dma1_error;
output						mst_dma1_bvalid;
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT

input						dma0_mst_wr_mask;
input						dma0_mst_req;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]		dma0_mst_addr;
input						dma0_mst_write;
input	[2:0]					dma0_mst_size;
input						dma0_mst_fix;
input	[7:0]					dma0_mst_len;
input	[(`DMA_DATA_WIDTH-1):0]			dma0_mst_wdata;
input	[2:0]					dma0_current_channel;
output						mst_dma0_grant;
output						mst_dma0_rd_ack;
output						mst_dma0_wr_ack;
output	[(`DMA_DATA_WIDTH-1):0]			mst_dma0_rdata;
output                  			mst_dma0_rlast;
output						mst_dma0_error;
output						mst_dma0_bvalid;

reg	[8:0]					wr_cnt;
reg						wlast;
reg						rd_cmd_running;
reg						wr_cmd_running;
reg						bresp_waiting;
reg						mst_dma_rd_ack_d1;
reg	[(`DMA_DATA_WIDTH-1):0]			mst_dma_rdata_d1;
reg						mst_dma_rd_error_d1;

wire	[1:0]					dma0_mst_burst;
wire						dma_mst_rd_req;
wire	[2:0]					dma_mst_arid;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0]		dma_mst_rd_addr;
wire	[1:0]					dma_mst_rd_burst;
wire	[2:0]					dma_mst_rd_size;
wire	[7:0]					dma_mst_rd_len;
wire						mst_dma_rd_grant;
wire						mst_dma_rd_ack;
wire	[(`DMA_DATA_WIDTH-1):0]			mst_dma_rdata;
wire						mst_dma_bvalid;
wire						dma_mst_wr_req;
wire	[2:0]					dma_mst_awid;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0]		dma_mst_wr_addr;
wire	[1:0]					dma_mst_wr_burst;
wire	[2:0]					dma_mst_wr_size;
wire	[7:0]					dma_mst_wr_len;
wire						dma_mst_wr_mask;
wire						dma_mst_write;
wire	[(`DMA_DATA_WIDTH-1):0]			dma_mst_wdata;
reg						mst_dma_wr_grant_d1;
wire						mst_dma_wr_grant;
wire						mst_dma_wr_ack;
wire						mst_dma_rd_error;
wire						mst_dma_wr_error;
reg	[(`DMA_DATA_WIDTH-1):0]			wdata;
wire	[`DMA_WSTRB_WIDTH:0]			wstrb_bits;
reg	[(`DMA_WSTRB_WIDTH-1):0]		wstrb;
wire	[(`DMA_WSTRB_WIDTH-1):0]		wstrb_nx;
wire						rd_cmd_running_nx;
wire						wr_cmd_running_nx;
wire						bresp_waiting_nx;
reg						rlast_received_d1;
wire						rlast_received;
wire						wlast_received;
wire						bresp_received;
wire						wlast_nx;
wire	[8:0]					wr_cnt_nx;
wire						issue_wr_ap;
reg	[`ATCDMAC300_BYTE_OFFSET_WIDTH-1:0]	wstrb_byte_offset;
reg						mst_dma_rd_err_keep;
wire						mst_dma_rd_err_keep_nx;

`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
reg						grant_dma0_rd;
reg						grant_dma0_wr;
reg						grant_dma1_rd;
reg						grant_dma1_wr;
wire						grant_dma0_rd_nx;
wire						grant_dma0_wr_nx;
wire						grant_dma1_rd_nx;
wire						grant_dma1_wr_nx;
wire						dma0_mst_rd_req;
wire						dma0_mst_wr_req;
wire						dma1_mst_rd_req;
wire						dma1_mst_wr_req;
wire	[1:0]					dma1_mst_burst;

assign	dma0_mst_rd_req		= !dma0_mst_write  && dma0_mst_req;
assign	dma0_mst_wr_req		=  dma0_mst_write  && dma0_mst_req;
assign	dma1_mst_rd_req		= !dma1_mst_write  && dma1_mst_req;
assign	dma1_mst_wr_req		=  dma1_mst_write  && dma1_mst_req;
assign	dma1_mst_burst		=  dma1_mst_fix     ? BURST_FIX : BURST_INCR;

assign	grant_dma0_rd_nx	= (grant_dma0_rd  && dma0_mst_rd_req) || ((!grant_dma1_rd) && dma0_mst_rd_req);
assign	grant_dma0_wr_nx	= (grant_dma0_wr  && dma0_mst_wr_req) || ((!grant_dma1_wr) && dma0_mst_wr_req);
assign	grant_dma1_rd_nx	= (grant_dma1_rd  && dma1_mst_rd_req) || ((!grant_dma0_rd) && dma1_mst_rd_req && (!dma0_mst_rd_req));
assign	grant_dma1_wr_nx	= (grant_dma1_wr  && dma1_mst_wr_req) || ((!grant_dma0_wr) && dma1_mst_wr_req && (!dma0_mst_wr_req));

assign	dma_mst_rd_req		= (dma0_mst_rd_req  && grant_dma0_rd) || (dma1_mst_rd_req  && grant_dma1_rd);
assign	dma_mst_wr_req		= (dma0_mst_wr_req  && grant_dma0_wr) || (dma1_mst_wr_req  && grant_dma1_wr);
assign	dma_mst_arid		=  grant_dma0_rd ? dma0_current_channel : dma1_current_channel;
assign	dma_mst_awid		=  grant_dma0_wr ? dma0_current_channel : dma1_current_channel;
assign	dma_mst_wr_mask		=  grant_dma0_wr ? dma0_mst_wr_mask : dma1_mst_wr_mask;
assign	dma_mst_write		=  grant_dma0_wr ? dma0_mst_write   : dma1_mst_write;
assign	dma_mst_wdata		=  grant_dma0_wr ? dma0_mst_wdata   : dma1_mst_wdata;

assign	dma_mst_rd_addr		=  grant_dma0_rd ? dma0_mst_addr  : dma1_mst_addr;
assign	dma_mst_rd_burst	=  grant_dma0_rd ? dma0_mst_burst : dma1_mst_burst;
assign	dma_mst_rd_size		=  grant_dma0_rd ? dma0_mst_size  : dma1_mst_size;
assign	dma_mst_rd_len		=  grant_dma0_rd ? dma0_mst_len   : dma1_mst_len;

assign	dma_mst_wr_addr		=  grant_dma0_wr ? dma0_mst_addr  : dma1_mst_addr;
assign	dma_mst_wr_burst	=  grant_dma0_wr ? dma0_mst_burst : dma1_mst_burst;
assign	dma_mst_wr_size		=  grant_dma0_wr ? dma0_mst_size  : dma1_mst_size;
assign	dma_mst_wr_len		=  grant_dma0_wr ? dma0_mst_len   : dma1_mst_len;

assign	mst_dma0_grant		= (grant_dma0_rd && mst_dma_rd_grant)    || (grant_dma0_wr && mst_dma_wr_grant);
assign	mst_dma0_error		= (grant_dma0_rd && mst_dma_rd_error_d1) || (grant_dma0_wr && mst_dma_wr_error);
assign	mst_dma0_rd_ack		= (grant_dma0_rd && mst_dma_rd_ack_d1  );
assign	mst_dma0_wr_ack		= (grant_dma0_wr && mst_dma_wr_ack);
assign	mst_dma0_rlast		=  grant_dma0_rd && rlast_received_d1;
assign	mst_dma0_bvalid		=  grant_dma0_wr && mst_dma_bvalid; 
assign	mst_dma0_rdata		=  mst_dma_rdata_d1;

assign	mst_dma1_grant		= (grant_dma1_rd && mst_dma_rd_grant)    || (grant_dma1_wr && mst_dma_wr_grant);
assign	mst_dma1_error		= (grant_dma1_rd && mst_dma_rd_error_d1) || (grant_dma1_wr && mst_dma_wr_error);
assign	mst_dma1_rd_ack		= (grant_dma1_rd && mst_dma_rd_ack_d1  );
assign	mst_dma1_wr_ack		= (grant_dma1_wr && mst_dma_wr_ack);
assign	mst_dma1_rlast		=  grant_dma1_rd && rlast_received_d1;
assign	mst_dma1_bvalid		=  grant_dma1_wr && mst_dma_bvalid; 
assign	mst_dma1_rdata		=  mst_dma_rdata_d1;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		grant_dma0_rd		<= 1'b0;
		grant_dma0_wr		<= 1'b0;
		grant_dma1_rd		<= 1'b0;
		grant_dma1_wr		<= 1'b0;
	end
	else begin
		grant_dma0_rd		<= grant_dma0_rd_nx;
		grant_dma0_wr		<= grant_dma0_wr_nx;
		grant_dma1_rd		<= grant_dma1_rd_nx;
		grant_dma1_wr		<= grant_dma1_wr_nx;
	end
end

`else // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
assign	dma_mst_arid		=   dma0_current_channel;
assign	dma_mst_awid		=   dma0_current_channel;
assign	dma_mst_rd_req		= (!dma0_mst_write) && dma0_mst_req;
assign	dma_mst_wr_req		=   dma0_mst_write && dma0_mst_req;
assign	dma_mst_wr_mask		=   dma0_mst_wr_mask;
assign	dma_mst_rd_addr		=   dma0_mst_addr;
assign	dma_mst_wr_addr		=   dma0_mst_addr;
assign	dma_mst_rd_size		=   dma0_mst_size;
assign	dma_mst_wr_size		=   dma0_mst_size;
assign	dma_mst_rd_len		=   dma0_mst_len;
assign	dma_mst_wr_len		=   dma0_mst_len;
assign	dma_mst_rd_burst	=   dma0_mst_burst;
assign	dma_mst_wr_burst	=   dma0_mst_burst;
assign	dma_mst_write		=   dma0_mst_write;
assign	dma_mst_wdata		=   dma0_mst_wdata;
assign	mst_dma0_grant		=   mst_dma_rd_grant    || mst_dma_wr_grant;
assign	mst_dma0_error		=   mst_dma_rd_error_d1 || mst_dma_wr_error;
assign	mst_dma0_rd_ack		=   mst_dma_rd_ack_d1;
assign	mst_dma0_wr_ack		=   mst_dma_wr_ack;
assign	mst_dma0_rdata		=   mst_dma_rdata_d1;
assign	mst_dma0_rlast		=   rlast_received_d1;
assign	mst_dma0_bvalid		=   mst_dma_bvalid; 
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT

assign	dma0_mst_burst		=   dma0_mst_fix ? BURST_FIX : BURST_INCR;
assign	rlast_received		=   rvalid && rready   &&  rlast;
assign	wlast_received		=   wvalid && wready   &&  wlast;
assign	bresp_received		=   bvalid && bready;
assign	rd_cmd_running_nx	= (arvalid && arready) || (rd_cmd_running && (!rlast_received_d1));
assign	wr_cmd_running_nx	= (awvalid && awready) || (wr_cmd_running && (!wlast_received));
assign	bresp_waiting_nx	= (awvalid && awready) || (bresp_waiting  && (!bresp_received));
assign	mst_dma_bvalid		=  bresp_received;
assign	arvalid			=  dma_mst_rd_req && (!rd_cmd_running);
assign	awvalid			=  dma_mst_wr_req && (!dma_mst_wr_mask);
assign	bready			=  bresp_waiting;
assign	rready			=  rd_cmd_running;

assign	arid			=  dma_mst_arid;
assign	araddr			=  dma_mst_rd_addr;
assign	arlen			=  dma_mst_rd_len;
assign	arsize			=  dma_mst_rd_size;
assign	arburst			=  dma_mst_rd_burst;
assign	arcache			=  4'h0;
assign	arlock			=  1'b0;
assign	arprot			=  3'h0;

assign	awid			=  dma_mst_awid;
assign	awaddr			=  dma_mst_wr_addr;
assign	awlen			=  dma_mst_wr_len;
assign	awsize			=  dma_mst_wr_size;
assign	awburst			=  dma_mst_wr_burst;
assign	awcache			=  4'h0;
assign	awlock			=  1'b0;
assign	awprot			=  3'h0;
assign	wvalid			=  dma_mst_write && wr_cmd_running && (!mst_dma_wr_grant_d1);
assign	wstrb_nx		=  wstrb_bits[(`DMA_WSTRB_WIDTH-1):0] << wstrb_byte_offset;

assign	mst_dma_rdata		=   rdata;
assign	mst_dma_rd_grant	=  arvalid && arready;
assign	mst_dma_rd_ack		=   rvalid &&  rready;
assign	mst_dma_rd_error	=   rvalid &&  rready && ((rresp == SLVERR) || (rresp == DECERR));
assign	mst_dma_rd_err_keep_nx	= (mst_dma_rd_error || mst_dma_rd_err_keep) && (!rlast_received); 
assign	mst_dma_wr_grant	=  awvalid && awready;
assign	mst_dma_wr_ack		=  (wvalid &&  wready && (!wlast)) || mst_dma_wr_grant_d1;
assign	mst_dma_wr_error	=   bvalid &&  bready && ((bresp == SLVERR) || (bresp == DECERR));

assign	issue_wr_ap		=  awready && awvalid;
assign	wlast_nx		= (wr_cnt_nx == 9'h1);
assign	wr_cnt_nx		=  issue_wr_ap ? {1'b0, awlen} + 9'h1 : (wvalid && wready) ? wr_cnt - 9'h1 : wr_cnt;
assign	wstrb_bits		= 
				  (dma_mst_wr_size == 3'h1) ? {{`DMA_WSTRB_WIDTH-1{1'b0}}, { 2{1'b1}}} :
				  (dma_mst_wr_size == 3'h2) ? {{`DMA_WSTRB_WIDTH-3{1'b0}}, { 4{1'b1}}} :
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				  (dma_mst_wr_size == 3'h3) ? {{`DMA_WSTRB_WIDTH-7{1'b0}}, { 8{1'b1}}} :
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				  (dma_mst_wr_size == 3'h4) ? {{`DMA_WSTRB_WIDTH-15{1'b0}},{16{1'b1}}} :
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				  (dma_mst_wr_size == 3'h5) ? {{`DMA_WSTRB_WIDTH-31{1'b0}},{32{1'b1}}} :
`endif
`endif
`endif
							      {{`DMA_WSTRB_WIDTH{1'b0}}, { 1{1'b1}}} ;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		rd_cmd_running		<= 1'b0;
		wr_cmd_running		<= 1'b0;
		bresp_waiting		<= 1'b0;
		wlast			<= 1'b0;
		wr_cnt			<= 9'b0;
		mst_dma_wr_grant_d1	<= 1'b0;
		mst_dma_rd_ack_d1	<= 1'b0;
		mst_dma_rdata_d1	<= {`DMA_DATA_WIDTH{1'b0}};
		rlast_received_d1	<= 1'b0;
		mst_dma_rd_error_d1	<= 1'b0;
		mst_dma_rd_err_keep	<= 1'b0;
	end
	else begin
		rd_cmd_running		<= rd_cmd_running_nx;
		wr_cmd_running		<= wr_cmd_running_nx;
		bresp_waiting		<= bresp_waiting_nx;
		wlast			<= wlast_nx;
		wr_cnt			<= wr_cnt_nx;
		mst_dma_wr_grant_d1	<= mst_dma_wr_grant;
		mst_dma_rd_ack_d1	<= mst_dma_rd_ack;
		mst_dma_rdata_d1	<= mst_dma_rdata;
		rlast_received_d1	<= rlast_received;
		mst_dma_rd_error_d1	<= (mst_dma_rd_err_keep || mst_dma_rd_error) && rlast_received;
		mst_dma_rd_err_keep	<= mst_dma_rd_err_keep_nx;
	end
end
always @(posedge aclk or negedge aresetn)
	if (!aresetn) begin
		wdata			<= {`DMA_DATA_WIDTH{1'b0}};
		wstrb			<= {`DMA_WSTRB_WIDTH{1'b0}};
	end
	else if (mst_dma_wr_grant_d1 || (wvalid && wready)) begin
		wdata			<= dma_mst_wdata;
		wstrb			<= wstrb_nx;
	end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		wstrb_byte_offset 	<= {`ATCDMAC300_BYTE_OFFSET_WIDTH{1'b0}};
	else if (awvalid && awready)
		wstrb_byte_offset 	<= awaddr[(`ATCDMAC300_BYTE_OFFSET_WIDTH-1):0];
	else if ((mst_dma_wr_grant_d1 || (wvalid &&  wready)) && (dma_mst_wr_burst == BURST_INCR))
		wstrb_byte_offset 	<= wstrb_byte_offset + ({{`ATCDMAC300_BYTE_OFFSET_WIDTH-1{1'b0}}, 1'b1} << dma_mst_wr_size);
end
endmodule
