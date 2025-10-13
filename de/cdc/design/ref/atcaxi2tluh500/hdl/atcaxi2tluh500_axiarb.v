module atcaxi2tluh500_axiarb (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  clk,      
        	  resetn,   
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
        	  rlast_buf,
        	  axvalid_arb,
        	  axready_arb,
        	  axid_arb, 
        	  axaddr_arb,
        	  axlen_arb,
        	  axsize_arb,
        	  axburst_arb,
        	  axcache_arb,
        	  axprot_arb,
        	  axfunc_arb,
        	  axaddrlast_arb,
        	  axburstlen_arb,
        	  wvalid_arb,
        	  wready_arb,
        	  wid_arb,  
        	  wdata_arb,
        	  wstrb_arb,
        	  wlast_arb,
        	  bvalid_arb,
        	  bready_arb,
        	  bid_arb,  
        	  bresp_arb,
        	  rvalid_arb,
        	  rready_arb,
        	  rid_arb,  
        	  rresp_arb,
        	  rdata_arb,
        	  rlast_arb 
        // VPERL_GENERATED_END
);

parameter	ADDR_WIDTH		= 64;
parameter	DATA_WIDTH		= 256;
parameter	ID_WIDTH 		= 4;
parameter	TL_OUTSTANDING		= 8;
parameter	TL_CHANNEL_NUM		= 4;
parameter	AX_FUNC_BITS		= 4;

parameter	DEVICE_REGION0_BASE	= 64'hffffffff_ffffffff;
parameter	DEVICE_REGION0_MASK	= 64'h00000000_00000000;
parameter	DEVICE_REGION1_BASE	= 64'hffffffff_ffffffff;
parameter	DEVICE_REGION1_MASK	= 64'h00000000_00000000;
parameter	DEVICE_REGION2_BASE	= 64'hffffffff_ffffffff;
parameter	DEVICE_REGION2_MASK	= 64'h00000000_00000000;
parameter	DEVICE_REGION3_BASE	= 64'hffffffff_ffffffff;
parameter	DEVICE_REGION3_MASK	= 64'h00000000_00000000;
parameter	DEVICE_REGION4_BASE	= 64'hffffffff_ffffffff;
parameter	DEVICE_REGION4_MASK	= 64'h00000000_00000000;
parameter	DEVICE_REGION5_BASE	= 64'hffffffff_ffffffff;
parameter	DEVICE_REGION5_MASK	= 64'h00000000_00000000;
parameter	DEVICE_REGION6_BASE	= 64'hffffffff_ffffffff;
parameter	DEVICE_REGION6_MASK	= 64'h00000000_00000000;
parameter	DEVICE_REGION7_BASE	= 64'hffffffff_ffffffff;
parameter	DEVICE_REGION7_MASK	= 64'h00000000_00000000;

parameter	RAR_SUPPORT	= 0;

localparam	OUT_IDX_WIDTH		= $clog2(TL_OUTSTANDING);
localparam	CH_IDX_WIDTH		= $clog2(TL_CHANNEL_NUM);
localparam	HR_IDX_WIDTH		= ((OUT_IDX_WIDTH + CH_IDX_WIDTH) == 0) ?  1 : (OUT_IDX_WIDTH + CH_IDX_WIDTH);
localparam	HR_NUM			= 2**(OUT_IDX_WIDTH + CH_IDX_WIDTH);

localparam	ARB_W			= 0;
localparam	ARB_R			= 1;
localparam	ARB_BITS		= 2;

localparam	AXI_BURST_FIXED		= 2'd0;
localparam	AXI_BURST_INCR		= 2'd1;
localparam	AXI_BURST_WRAP		= 2'd2;
localparam	AXI_BURST_RSVD		= 2'd3;

localparam	AXI_SIZE_BYTE	= 3'd0;
localparam	AXI_SIZE_HWORD	= 3'd1;
localparam	AXI_SIZE_WORD	= 3'd2;
localparam	AXI_SIZE_DWORD	= 3'd3;
localparam	AXI_SIZE_QWORD	= 3'd4;
localparam	AXI_SIZE_DQWORD	= 3'd5;
localparam	AXI_SIZE_QQWORD	= 3'd6;

input				clk;
input				resetn;

// == AXI write address channel
output				awready_buf;
input				awvalid_buf;

input	[(ID_WIDTH-1):0]	awid_buf;
input	[(ADDR_WIDTH-1):0]	awaddr_buf;
input	[7:0]			awlen_buf;
input	[2:0]			awsize_buf;
input	[1:0]			awburst_buf;
input	[3:0]			awcache_buf;
input	[2:0]			awprot_buf;
// == AXI write data channel
output				wready_buf;
input				wvalid_buf;
input	[(DATA_WIDTH-1):0]	wdata_buf;
input	[((DATA_WIDTH/8)-1):0]	wstrb_buf;
input				wlast_buf;
// == AXI write response channel
input				bready_buf;
output				bvalid_buf;
output	[(ID_WIDTH-1):0]	bid_buf;
output	[1:0]			bresp_buf;
// == AXI read address channel
output				arready_buf;
input				arvalid_buf;
input	[(ID_WIDTH-1):0]	arid_buf;
input	[(ADDR_WIDTH-1):0]	araddr_buf;
input	[7:0]			arlen_buf;
input	[2:0]			arsize_buf;
input	[1:0]			arburst_buf;
input	[3:0]			arcache_buf;
input	[2:0]			arprot_buf;
// == AXI read data channel
input				rready_buf;
output				rvalid_buf;
output	[(ID_WIDTH-1):0]	rid_buf;
output	[(DATA_WIDTH-1):0]	rdata_buf;
output	[1:0]			rresp_buf;
output				rlast_buf;

// AXI_CMD
output				axvalid_arb;
input				axready_arb;
output	[(HR_IDX_WIDTH-1):0]	axid_arb;
output	[(ADDR_WIDTH-1):0]	axaddr_arb;
output	[7:0]			axlen_arb;
output	[2:0]			axsize_arb;
output	[1:0]			axburst_arb;
output	[3:0]			axcache_arb;
output	[2:0]			axprot_arb;
output	[(AX_FUNC_BITS-1):0]	axfunc_arb;
output	[5:0]			axaddrlast_arb;
output	[5:0]			axburstlen_arb;
// AXI WDATA
output				wvalid_arb;
input				wready_arb;
output	[(HR_IDX_WIDTH-1):0]	wid_arb;
output	[(DATA_WIDTH-1):0]	wdata_arb;
output	[((DATA_WIDTH/8)-1):0]	wstrb_arb;
output				wlast_arb;
// AXI_RESP
input				bvalid_arb;
output	  			bready_arb;
input	[(HR_IDX_WIDTH-1):0]	bid_arb;
input	[1:0]			bresp_arb;
input				rvalid_arb;
output	  			rready_arb;
input	[(HR_IDX_WIDTH-1):0]	rid_arb;
input	[1:0]			rresp_arb;
input	[(DATA_WIDTH-1):0]	rdata_arb;
input				rlast_arb;

wire				arb_en;
wire	[(ARB_BITS-1):0]	arb_valid;
wire	[(ARB_BITS-1):0]	arb_grant;
wire	[(ARB_BITS-1):0]	axgrant_arb;

wire	[5:0]			awaddrlast;
wire	[5:0]			awburstlen;
wire	[5:0]			araddrlast;
wire	[5:0]			arburstlen;

wire				broadcast_valid;
reg	[5:0]			broadcast_cnt;
wire	[5:0]			broadcast_cnt_nx;
wire				broadcast_cnt_en;
wire				broadcast_init;
wire				broadcast_last;
wire	[(ADDR_WIDTH-1):0]	broadcast_addr;
wire	[5:0]			broadcast_init_len;
wire	[5:0]			broadcast_body_len;
wire	[5:0]			broadcast_last_len;
wire	[5:0]			broadcast_len;

wire				broadcast_w;
wire	[5:0]			broadcast_w_beats;
reg	[5:0]			broadcast_w_cnt;
wire	[5:0]			broadcast_w_cnt_nx;
wire				broadcast_w_last;
wire				broadcast_w_cnt_en;

reg	[(HR_NUM-1):0]		idq_valid;
wire	[(HR_NUM-1):0]		idq_register_hit;
wire	[(HR_NUM-1):0]		idq_valid_set;
wire	[(HR_NUM-1):0]		idq_valid_clr;
wire	[(HR_NUM-1):0]		idq_valid_en;
wire	[ID_WIDTH:0]		idq[0:(HR_NUM-1)];
wire	[ID_WIDTH:0]		idq_d[0:(HR_NUM-1)];
wire				idq_issue = axvalid_arb & axready_arb;
wire				idq_b_retire = bvalid_arb & bready_arb;
wire				idq_r_retire = rvalid_arb & rready_arb & rlast_arb;
wire	[(HR_NUM-1):0]		idq_aw_hazard;
wire	[(HR_NUM-1):0]		idq_ar_hazard;
wire	[(HR_NUM-1):0]		idq_broadcast_hazard;
wire				idq_w_hazard;

wire	[(HR_IDX_WIDTH-1):0]	broadcast_resp_ptr;

reg	[(HR_NUM-1):0]		broadcast_resp_valid;
reg	[ID_WIDTH-1:0]		broadcast_resp_idq[0:(HR_NUM-1)];
reg	[5:0]			broadcast_resp_tot[0:(HR_NUM-1)];
reg	[HR_NUM*2-1:0]		broadcast_resp_bresp;
wire	[(HR_NUM-1):0]		broadcast_resp_hit;
wire	[(HR_NUM-1):0]		broadcast_resp_last;

wire	[(HR_IDX_WIDTH-1):0]	idq_register_id;
wire				idq_register_valid = ~idq_valid[idq_register_id];

wire				w_is_device	= ((awaddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION0_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION0_BASE[ADDR_WIDTH-1:12])
						| ((awaddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION1_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION1_BASE[ADDR_WIDTH-1:12])
						| ((awaddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION2_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION2_BASE[ADDR_WIDTH-1:12])
						| ((awaddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION3_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION3_BASE[ADDR_WIDTH-1:12])
						| ((awaddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION4_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION4_BASE[ADDR_WIDTH-1:12])
						| ((awaddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION5_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION5_BASE[ADDR_WIDTH-1:12])
						| ((awaddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION6_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION6_BASE[ADDR_WIDTH-1:12])
						| ((awaddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION7_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION7_BASE[ADDR_WIDTH-1:12])
						;
wire				w_is_single	= w_is_device
						| (awcache_buf[3:1] == 3'b000)
						| (awburst_buf == AXI_BURST_FIXED)
						| (awburst_buf == AXI_BURST_WRAP)
						;

wire				r_is_device	= ((araddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION0_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION0_BASE[ADDR_WIDTH-1:12])
						| ((araddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION1_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION1_BASE[ADDR_WIDTH-1:12])
						| ((araddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION2_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION2_BASE[ADDR_WIDTH-1:12])
						| ((araddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION3_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION3_BASE[ADDR_WIDTH-1:12])
						| ((araddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION4_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION4_BASE[ADDR_WIDTH-1:12])
						| ((araddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION5_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION5_BASE[ADDR_WIDTH-1:12])
						| ((araddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION6_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION6_BASE[ADDR_WIDTH-1:12])
						| ((araddr_buf[ADDR_WIDTH-1:12] & DEVICE_REGION7_MASK[ADDR_WIDTH-1:12]) == DEVICE_REGION7_BASE[ADDR_WIDTH-1:12])
						;
wire				r_is_single	= r_is_device
						| (arcache_buf[3:1] == 3'b000)
						| (arburst_buf == AXI_BURST_FIXED)
						| (arburst_buf == AXI_BURST_WRAP)
						;

wire	[5:0]			awaddr_tmp = {(6){awsize_buf == AXI_SIZE_BYTE  }} & {awaddr_buf[5:0]      }
                                           | {(6){awsize_buf == AXI_SIZE_HWORD }} & {awaddr_buf[5:1], 1'b0}
                                           | {(6){awsize_buf == AXI_SIZE_WORD  }} & {awaddr_buf[5:2], 2'b0}
                                           | {(6){awsize_buf == AXI_SIZE_DWORD }} & {awaddr_buf[5:3], 3'b0}
                                           | {(6){awsize_buf == AXI_SIZE_QWORD }} & {awaddr_buf[5:4], 4'b0}
                                           | {(6){awsize_buf == AXI_SIZE_DQWORD}} & {awaddr_buf[5],   5'b0}
//                                           | {(6){awsize_buf == AXI_SIZE_QQWORD}} & {                 6'b0}
                                           ;
wire	[11:0]			awlen_tmp = {(12){awsize_buf == AXI_SIZE_BYTE  }} & {4'b0, awlen_buf[7:0]      }
                                          | {(12){awsize_buf == AXI_SIZE_HWORD }} & {3'b0, awlen_buf[7:0], 1'b0}
                                          | {(12){awsize_buf == AXI_SIZE_WORD  }} & {2'b0, awlen_buf[7:0], 2'b0}
                                          | {(12){awsize_buf == AXI_SIZE_DWORD }} & {1'b0, awlen_buf[7:0], 3'b0}
                                          | {(12){awsize_buf == AXI_SIZE_QWORD }} & {      awlen_buf[7:0], 4'b0}
                                          | {(12){awsize_buf == AXI_SIZE_DQWORD}} & {      awlen_buf[6:0], 5'b0}
                                          | {(12){awsize_buf == AXI_SIZE_QQWORD}} & {      awlen_buf[5:0], 6'b0}
                                          ;

wire	nds_unused_aw_carry;
assign	{nds_unused_aw_carry, awburstlen, awaddrlast} = {6'b0, awaddr_tmp} + awlen_tmp;

wire	[5:0]			araddr_tmp = {(6){arsize_buf == AXI_SIZE_BYTE  }} & {araddr_buf[5:0]      }
                                           | {(6){arsize_buf == AXI_SIZE_HWORD }} & {araddr_buf[5:1], 1'b0}
                                           | {(6){arsize_buf == AXI_SIZE_WORD  }} & {araddr_buf[5:2], 2'b0}
                                           | {(6){arsize_buf == AXI_SIZE_DWORD }} & {araddr_buf[5:3], 3'b0}
                                           | {(6){arsize_buf == AXI_SIZE_QWORD }} & {araddr_buf[5:4], 4'b0}
                                           | {(6){arsize_buf == AXI_SIZE_DQWORD}} & {araddr_buf[5],   5'b0}
//                                           | {(6){arsize_buf == AXI_SIZE_QQWORD}} & {                 6'b0}
                                           ;
wire	[11:0]			arlen_tmp = {(12){arsize_buf == AXI_SIZE_BYTE  }} & {4'b0, arlen_buf[7:0]      }
                                          | {(12){arsize_buf == AXI_SIZE_HWORD }} & {3'b0, arlen_buf[7:0], 1'b0}
                                          | {(12){arsize_buf == AXI_SIZE_WORD  }} & {2'b0, arlen_buf[7:0], 2'b0}
                                          | {(12){arsize_buf == AXI_SIZE_DWORD }} & {1'b0, arlen_buf[7:0], 3'b0}
                                          | {(12){arsize_buf == AXI_SIZE_QWORD }} & {      arlen_buf[7:0], 4'b0}
                                          | {(12){arsize_buf == AXI_SIZE_DQWORD}} & {      arlen_buf[6:0], 5'b0}
                                          | {(12){arsize_buf == AXI_SIZE_QQWORD}} & {      arlen_buf[5:0], 6'b0}
                                          ;

wire	nds_unused_ar_carry;
assign	{nds_unused_ar_carry, arburstlen, araddrlast} = {6'b0, araddr_tmp} + arlen_tmp;

generate
genvar hr_idx;
genvar ch_idx;
genvar out_idx;
for (hr_idx = 0; hr_idx < HR_NUM; hr_idx = hr_idx + 1) begin: gen_idq_entry
	assign	idq_register_hit[hr_idx] = (hr_idx[(HR_IDX_WIDTH-1):0] == idq_register_id);
	assign	idq_valid_set[hr_idx] = idq_issue & idq_register_hit[hr_idx];
	assign	idq_valid_clr[hr_idx] = idq_b_retire & (hr_idx[(HR_IDX_WIDTH-1):0] == bid_arb)
                                      | idq_r_retire & (hr_idx[(HR_IDX_WIDTH-1):0] == rid_arb)
	                              ;
	assign	idq_valid_en[hr_idx] = idq_valid_set[hr_idx] | idq_valid_clr[hr_idx];
	wire	[ID_WIDTH-1:0] idq_wdata = {ID_WIDTH{arb_grant[ARB_W]}} & awid_buf
			                 | {ID_WIDTH{arb_grant[ARB_R]}} & arid_buf
			                 ;
	always @ (posedge clk or negedge resetn)
		if (!resetn)
			idq_valid[hr_idx] <= 1'b0;
		else if (idq_valid_en[hr_idx])
			idq_valid[hr_idx] <= idq_valid_set[hr_idx];

	assign idq_d[hr_idx] = {arb_grant[ARB_R], idq_wdata};

	atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(ID_WIDTH+1)) u_idq_dff (.clk(clk), .resetn(resetn), .en(idq_valid_set[hr_idx]), .d(idq_d[hr_idx]), .q(idq[hr_idx]));

	assign idq_aw_hazard[hr_idx] = idq_valid[hr_idx] & ~idq[hr_idx][ID_WIDTH] & (idq[hr_idx][ID_WIDTH-1:0] == awid_buf);
	assign idq_ar_hazard[hr_idx] = idq_valid[hr_idx] &  idq[hr_idx][ID_WIDTH] & (idq[hr_idx][ID_WIDTH-1:0] == arid_buf);
end

if ((OUT_IDX_WIDTH + CH_IDX_WIDTH) == 0) begin : gen_single_out_ch
	assign	idq_register_id = 1'b0;
end
else if (((OUT_IDX_WIDTH == 0) | (CH_IDX_WIDTH == 0)) & (HR_IDX_WIDTH == 1)) begin : gen_two_hr
	reg	[(HR_IDX_WIDTH-1):0]	idq_register_id_r;
	wire	[(HR_IDX_WIDTH-1):0]	idq_register_id_r_nx;
	wire				nds_unused_nlz;
	wire	[(HR_NUM-1):0]		idq_valid_nx = idq_valid | idq_register_hit;
	wire				idq_register_id_r_en = awvalid_buf | arvalid_buf;
	assign	idq_register_id = idq_register_id_r;
	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			idq_register_id_r <= {HR_IDX_WIDTH{1'b0}};
		end
		else if (idq_register_id_r_en) begin
			idq_register_id_r <= idq_register_id_r_nx;
		end
	end
	atcaxi2tluh500_leading_zero #(
		.N	(HR_NUM)
	) u_idq_register_id_r_nx (
		.o	(idq_register_id_r_nx),
		.i	(idq_valid_nx),
		.nlz	(nds_unused_nlz)
	);

end
else if ((OUT_IDX_WIDTH == 0) | (CH_IDX_WIDTH == 0) & (HR_IDX_WIDTH != 1)) begin : gen_single_out_or_single_ch
	reg	[(HR_IDX_WIDTH-1):0]	idq_register_id_r;
	wire	[(HR_IDX_WIDTH-1):0]	idq_register_id_r_nx;
	wire				nds_unused_nlz;
	wire	[(HR_NUM-1):0]		idq_valid_nx = idq_valid | idq_register_hit;
	wire				idq_register_id_r_en = awvalid_buf | arvalid_buf;
	assign	idq_register_id = idq_register_id_r;	
	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			idq_register_id_r <= {HR_IDX_WIDTH{1'b0}};
		end
		else if (idq_register_id_r_en) begin
			idq_register_id_r <= idq_register_id_r_nx;
		end
	end
	atcaxi2tluh500_leading_zero #(
		.N	(HR_NUM)
	) u_idq_register_id_r_nx (
		.o	(idq_register_id_r_nx),
		.i	(idq_valid_nx),
		.nlz	(nds_unused_nlz)
	);
end
else  begin : gen_multi_out_ch
	reg	[(HR_IDX_WIDTH-1):0]	idq_register_id_r;
	wire	[(HR_IDX_WIDTH-1):0]	idq_register_id_r_nx;
	wire				nds_unused_nlz;
	wire	[(HR_NUM-1):0]		idq_valid_remap;
	wire	[(HR_NUM-1):0]		idq_valid_nx = idq_valid | idq_register_hit;
	wire				idq_register_id_r_en = awvalid_buf | arvalid_buf;
	
	assign	idq_register_id = idq_register_id_r;	
	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			idq_register_id_r <= {HR_IDX_WIDTH{1'b0}};
		end
		else if (idq_register_id_r_en) begin
			idq_register_id_r <= idq_register_id_r_nx;
		end
	end

	for (out_idx = 0; out_idx < TL_OUTSTANDING; out_idx = out_idx + 1) begin: gen_idq_valid_remap_out_idx
		for (ch_idx = 0; ch_idx < TL_CHANNEL_NUM; ch_idx = ch_idx + 1) begin: gen_idq_valid_remap_ch_idx
			assign	idq_valid_remap[out_idx*TL_CHANNEL_NUM+ch_idx] = idq_valid_nx[ch_idx*TL_OUTSTANDING+out_idx];
		end
	end
		
	atcaxi2tluh500_leading_zero #(
		.N	(HR_NUM)
	) u_idq_register_id_r_nx (
		.o	({idq_register_id_r_nx[0+:OUT_IDX_WIDTH], idq_register_id_r_nx[OUT_IDX_WIDTH+:CH_IDX_WIDTH]}),
		.i	(idq_valid_remap),
		.nlz	(nds_unused_nlz)
	);
end
endgenerate

assign	arb_valid[ARB_W] = awvalid_buf;
assign	axgrant_arb[ARB_W] = idq_register_valid 
			   & ~idq_w_hazard 
			   & ~(broadcast_init & (|{idq_aw_hazard, idq_broadcast_hazard}))
			   ;

assign	arb_valid[ARB_R] = arvalid_buf;
assign	axgrant_arb[ARB_R] = idq_register_valid & ~(|idq_ar_hazard);
assign	arb_en = 1'b1;
wire	[1:0] nds_unused_arb_ready;
atcaxi2tluh500_arb_rr #(
		.N	(2	)
) u_aw_arb (
	.clk		(clk			),
	.resetn		(resetn			),
	.en		(arb_en			),
	.valid		(arb_valid		),
	.ready		(nds_unused_arb_ready	),
	.grant		(arb_grant		)
);

assign	broadcast_valid = ~w_is_single;

assign	broadcast_cnt_en = broadcast_valid & idq_issue & arb_grant[ARB_W] & axgrant_arb[ARB_W];
always @ (posedge clk or negedge resetn) begin
	if (!resetn)
		broadcast_cnt <= 6'b0;
	else if (broadcast_cnt_en)
		broadcast_cnt <= broadcast_cnt_nx;
end

assign	broadcast_init = (broadcast_cnt == 6'b0);
assign	broadcast_last = (broadcast_cnt == awburstlen);
assign	broadcast_cnt_nx = broadcast_last ? 6'b0 : broadcast_cnt + 6'b1;

assign	broadcast_addr[(ADDR_WIDTH-1):12] = awaddr_buf[(ADDR_WIDTH-1):12];
wire	nds_unused_broadcast_addr_carry;
assign	{nds_unused_broadcast_addr_carry, broadcast_addr[11:6]} = broadcast_cnt[5:0] + awaddr_buf[11:6];
assign	broadcast_addr[5:0] = {6{broadcast_init}} & awaddr_tmp;

wire	[5:0]	broadcast_init_addr = ({(6){(awsize_buf == AXI_SIZE_BYTE  )}} & (       awaddr_buf[5:0] ))
                                    | ({(6){(awsize_buf == AXI_SIZE_HWORD )}} & ({1'b0, awaddr_buf[5:1]}))
                                    | ({(6){(awsize_buf == AXI_SIZE_WORD  )}} & ({2'b0, awaddr_buf[5:2]}))
                                    | ({(6){(awsize_buf == AXI_SIZE_DWORD )}} & ({3'b0, awaddr_buf[5:3]}))
                                    | ({(6){(awsize_buf == AXI_SIZE_QWORD )}} & ({4'b0, awaddr_buf[5:4]}))
                                    | ({(6){(awsize_buf == AXI_SIZE_DQWORD)}} & ({5'b0, awaddr_buf[5]  }))
//                                    | ({(6){(awsize_buf == AXI_SIZE_QQWORD)}} & ({6'b0                 }))
                                    ;
wire	nds_unused_broadcast_init_len_carry;
assign	{nds_unused_broadcast_init_len_carry, broadcast_init_len} = broadcast_body_len - broadcast_init_addr;

assign	broadcast_body_len  = ({(6){(awsize_buf == AXI_SIZE_BYTE  )}} & 6'h3f)
                            | ({(6){(awsize_buf == AXI_SIZE_HWORD )}} & 6'h1f)
                            | ({(6){(awsize_buf == AXI_SIZE_WORD  )}} & 6'hf)
                            | ({(6){(awsize_buf == AXI_SIZE_DWORD )}} & 6'h7)
                            | ({(6){(awsize_buf == AXI_SIZE_QWORD )}} & 6'h3)
                            | ({(6){(awsize_buf == AXI_SIZE_DQWORD)}} & 6'h1)
//                            | ({(6){(awsize_buf == AXI_SIZE_QQWORD)}} & 6'h0)
                            ;
assign	broadcast_last_len  = ({(6){(awsize_buf == AXI_SIZE_BYTE  )}} & (       awaddrlast[5:0] ))
                            | ({(6){(awsize_buf == AXI_SIZE_HWORD )}} & ({1'b0, awaddrlast[5:1]}))
                            | ({(6){(awsize_buf == AXI_SIZE_WORD  )}} & ({2'b0, awaddrlast[5:2]}))
                            | ({(6){(awsize_buf == AXI_SIZE_DWORD )}} & ({3'b0, awaddrlast[5:3]}))
                            | ({(6){(awsize_buf == AXI_SIZE_QWORD )}} & ({4'b0, awaddrlast[5:4]}))
                            | ({(6){(awsize_buf == AXI_SIZE_DQWORD)}} & ({5'b0, awaddrlast[5]  }))
//                            | ({(6){(awsize_buf == AXI_SIZE_QQWORD)}} & ({6'b0,                }))
                            ;
assign	broadcast_len = ({(6){(~broadcast_init & ~broadcast_last)}} & broadcast_body_len[5:0]) 
                      | ({(6){(~broadcast_init &  broadcast_last)}} & broadcast_last_len[5:0]) 
                      | ({(6){( broadcast_init & ~broadcast_last)}} & broadcast_init_len[5:0]) 
                      | ({(6){( broadcast_init &  broadcast_last)}} & awlen_buf[5:0]) 
                      ;
assign	axvalid_arb  = |(arb_grant & axgrant_arb);		    
assign	awready_buf  = (arb_grant[ARB_W] & axgrant_arb[ARB_W] & axready_arb &   broadcast_valid & broadcast_last)
                     | (arb_grant[ARB_W] & axgrant_arb[ARB_W] & axready_arb &  ~broadcast_valid)
		     ;
assign	arready_buf  = arb_grant[ARB_R] & axgrant_arb[ARB_R] & axready_arb;
assign	axid_arb     = idq_register_id;
assign	axaddr_arb   = {ADDR_WIDTH{arb_grant[ARB_W] & ~broadcast_valid}} & awaddr_buf
                     | {ADDR_WIDTH{arb_grant[ARB_W] &  broadcast_valid}} & broadcast_addr
                     | {ADDR_WIDTH{arb_grant[ARB_R]                 }} & araddr_buf
                     ;
assign	axlen_arb    = {8{arb_grant[ARB_W] & ~broadcast_valid}} & awlen_buf
                     | {8{arb_grant[ARB_W] &  broadcast_valid}} & {2'b0, broadcast_len}
                     | {8{arb_grant[ARB_R]                 }} & arlen_buf
                     ;
assign	axsize_arb   = {3{arb_grant[ARB_W]}} & awsize_buf
                     | {3{arb_grant[ARB_R]}} & arsize_buf
                     ;
assign	axburst_arb  = {2{arb_grant[ARB_W]}} & awburst_buf
                     | {2{arb_grant[ARB_R]}} & arburst_buf
                     ;
assign	axcache_arb  = {4{arb_grant[ARB_W]}} & awcache_buf
                     | {4{arb_grant[ARB_R]}} & arcache_buf
                     ;
assign	axprot_arb   = {3{arb_grant[ARB_W]}} & awprot_buf
                     | {3{arb_grant[ARB_R]}} & arprot_buf
                     ;
assign	axfunc_arb   = ({AX_FUNC_BITS{arb_grant[ARB_W]}} & {~w_is_device, w_is_single, arb_grant})
                     | ({AX_FUNC_BITS{arb_grant[ARB_R]}} & {~r_is_device, r_is_single, arb_grant})
		     ;
assign	axaddrlast_arb = ({6{arb_grant[ARB_W] & ~broadcast_valid                }} & {awaddrlast})
                       | ({6{arb_grant[ARB_W] &  broadcast_valid & ~broadcast_last}} & {6'b111111})
                       | ({6{arb_grant[ARB_W] &  broadcast_valid &  broadcast_last}} & {awaddrlast})
                       | ({6{arb_grant[ARB_R]}} & {araddrlast})
		       ;
assign	axburstlen_arb = ({6{arb_grant[ARB_W] & ~broadcast_valid}} & {awburstlen})
                       | ({6{arb_grant[ARB_R]}} & {arburstlen})
		       ;

generate
if ((OUT_IDX_WIDTH + CH_IDX_WIDTH) == 0) begin : gen_wid_bypass
	reg				broadcast_w_r;
	reg	[5:0]			broadcast_w_beats_r;

	wire				broadcast_w_set = idq_issue & arb_grant[ARB_W] & axgrant_arb[ARB_W];
	wire				broadcast_w_clr = wvalid_arb & wready_arb & wlast_arb;
	always @ (posedge clk or negedge resetn)
		if (!resetn)
			broadcast_w_r <= 1'b0;
		else if (broadcast_w_clr)
			broadcast_w_r <= 1'b0;
		else if (broadcast_w_set)
			broadcast_w_r <= broadcast_valid;

	always @ (posedge clk or negedge resetn)
		if (!resetn)
			broadcast_w_beats_r <= 6'b0;
		else if (broadcast_w_clr)
			broadcast_w_beats_r <= 6'b0;
		else if (broadcast_w_set)
			broadcast_w_beats_r <= {6{broadcast_valid}} & broadcast_len;

	assign	wid_arb = 1'b0;
	assign	broadcast_w = broadcast_w_r;
	assign	broadcast_w_beats = broadcast_w_beats_r;
	assign	idq_w_hazard = 1'b0;
end
else  begin : gen_wid_fifo
	wire	w_id_fifo_wvalid = idq_issue & arb_grant[ARB_W] & axgrant_arb[ARB_W];
	wire	w_id_fifo_wready;
	wire	w_id_fifo_rready = wvalid_arb & wready_arb & wlast_arb;
	wire	[(HR_IDX_WIDTH-1):0]	wid_arb_tmp;
	wire				broadcast_w_tmp;
	wire	[5:0]			broadcast_w_beats_tmp;
	wire				w_id_fifo_rvalid;
	
	atcaxi2tluh500_sync_fifo #(
		.DEPTH		(2),
		.WIDTH		(HR_IDX_WIDTH+6+1),
		.RAR_SUPPORT	(RAR_SUPPORT)
	) u_w_id_fifo (
		.clk		(clk),
		.reset_n	(resetn),
		.wdata		({idq_register_id, broadcast_len, broadcast_valid}),
		.wvalid		(w_id_fifo_wvalid),
		.wready		(w_id_fifo_wready),
		.rdata		({wid_arb_tmp, broadcast_w_beats_tmp, broadcast_w_tmp}),
		.rvalid		(w_id_fifo_rvalid),
		.rready		(w_id_fifo_rready)
	);
	assign	broadcast_w = w_id_fifo_rvalid & broadcast_w_tmp;
	assign 	wid_arb = {HR_IDX_WIDTH{w_id_fifo_rvalid}} & wid_arb_tmp;
	assign	broadcast_w_beats = {6{w_id_fifo_rvalid}} & broadcast_w_beats_tmp;
	assign	idq_w_hazard = ~w_id_fifo_wready;
end
endgenerate

assign	wvalid_arb   = wvalid_buf;
assign	wready_buf   = wready_arb;
assign	wdata_arb   = wdata_buf;
assign	wstrb_arb   = wstrb_buf;

assign	broadcast_w_cnt_en = broadcast_w & wvalid_arb & wready_arb;
always @ (posedge clk or negedge resetn) 
	if (!resetn)
		broadcast_w_cnt <= 6'b0;
	else if (broadcast_w_cnt_en)
		broadcast_w_cnt <= broadcast_w_cnt_nx;

assign	broadcast_w_last = (broadcast_w_beats == broadcast_w_cnt);
assign	broadcast_w_cnt_nx = broadcast_w_last ? 6'b0 : broadcast_w_cnt + 6'b1;
assign	wlast_arb   = wlast_buf | broadcast_w_last & broadcast_w;

generate
genvar resp_idx;
if ((OUT_IDX_WIDTH + CH_IDX_WIDTH) == 0) begin: gen_broadcast_resp_ptr_one
	assign broadcast_resp_ptr = 1'b0;
end
else if (((OUT_IDX_WIDTH == 0) | (CH_IDX_WIDTH == 0)) & (HR_IDX_WIDTH == 1)) begin : gen_broadcast_resp_ptr_two
	reg	[(HR_IDX_WIDTH-1):0]	broadcast_resp_ptr_r;
	wire	broadcast_resp_ptr_r_en = idq_issue &  arb_grant[ARB_W] & broadcast_valid & broadcast_init;
	always @ (posedge clk or negedge resetn) 
		if (!resetn)
			broadcast_resp_ptr_r <= 1'b0;
		else if (broadcast_resp_ptr_r_en)
			broadcast_resp_ptr_r <= ~broadcast_resp_ptr_r;
	assign broadcast_resp_ptr = broadcast_resp_ptr_r;
end
else begin: gen_broadcast_resp_ptr_multiple
	reg	[(HR_IDX_WIDTH-1):0]	broadcast_resp_ptr_r;
	wire	broadcast_resp_ptr_r_en = idq_issue &  arb_grant[ARB_W] & broadcast_valid & broadcast_init;
	always @ (posedge clk or negedge resetn) 
		if (!resetn)
			broadcast_resp_ptr_r <= {(HR_IDX_WIDTH){1'b0}};
		else if (broadcast_resp_ptr_r_en)
			broadcast_resp_ptr_r <= broadcast_resp_ptr_r + {{(HR_IDX_WIDTH-1){1'b0}}, 1'b1};
	assign broadcast_resp_ptr = broadcast_resp_ptr_r;
end

for (resp_idx = 0; resp_idx < HR_NUM; resp_idx = resp_idx + 1) begin: gen_broadcast_resp_idq_entry
	wire	idq_entry_issue = idq_issue &  arb_grant[ARB_W] & (resp_idx[(HR_IDX_WIDTH-1):0] == broadcast_resp_ptr) & ~(|idq_broadcast_hazard) & broadcast_valid & broadcast_init;
	assign	broadcast_resp_hit[resp_idx] = bvalid_arb & broadcast_resp_valid[resp_idx] & ~idq[bid_arb][ID_WIDTH] & (broadcast_resp_idq[resp_idx] == idq[bid_arb][ID_WIDTH-1:0]);
	assign	broadcast_resp_last[resp_idx] = broadcast_resp_hit[resp_idx] & (broadcast_resp_tot[resp_idx] == 6'b0);

	wire	[ID_WIDTH-1:0]		broadcast_resp_idq_nx = awid_buf;
	wire	[5:0]			broadcast_resp_tot_nx = broadcast_resp_tot[resp_idx] - 6'b1;
	wire	[1:0]			broadcast_resp_bresp_nx = broadcast_resp_bresp[resp_idx*2+:2] | bresp_arb;

	wire	broadcast_resp_valid_set = idq_entry_issue;
	wire	broadcast_resp_valid_clr = broadcast_resp_last[resp_idx] & bready_buf;
	wire	broadcast_resp_valid_inc = ~broadcast_resp_last[resp_idx] & broadcast_resp_hit[resp_idx];

	always @ (posedge clk or negedge resetn)
		if (!resetn)
			broadcast_resp_valid[resp_idx] <= 1'b0;
		else if (broadcast_resp_valid_set)
			broadcast_resp_valid[resp_idx] <= 1'b1;
		else if (broadcast_resp_valid_clr)
			broadcast_resp_valid[resp_idx] <= 1'b0;

	always @ (posedge clk or negedge resetn)
		if (!resetn)
			broadcast_resp_idq[resp_idx] <= {ID_WIDTH{1'b0}};
		else if (broadcast_resp_valid_set)
			broadcast_resp_idq[resp_idx] <= broadcast_resp_idq_nx;
	always @ (posedge clk or negedge resetn)
		if (!resetn) begin
			broadcast_resp_tot[resp_idx] <= 6'b0;
			broadcast_resp_bresp[resp_idx*2+:2] <= 2'b0;
		end
		else if (broadcast_resp_valid_set) begin
			broadcast_resp_tot[resp_idx] <= awburstlen;
			broadcast_resp_bresp[resp_idx*2+:2] <= 2'b0;
		end
		else if (broadcast_resp_valid_clr) begin
			broadcast_resp_tot[resp_idx] <= 6'b0;
			broadcast_resp_bresp[resp_idx*2+:2] <= 2'b0;
		end
		else if (broadcast_resp_valid_inc) begin
			broadcast_resp_tot[resp_idx] <= broadcast_resp_tot_nx;
			broadcast_resp_bresp[resp_idx*2+:2] <= broadcast_resp_bresp_nx;
		end

	assign	idq_broadcast_hazard[resp_idx] = broadcast_resp_valid[resp_idx] & ((awid_buf == broadcast_resp_idq[resp_idx]) | (resp_idx[(HR_IDX_WIDTH-1):0] == broadcast_resp_ptr));
end
endgenerate

assign	bvalid_buf	=   (|broadcast_resp_hit) ? ( |broadcast_resp_last) : bvalid_arb;
assign	bready_arb	= ( (|broadcast_resp_hit) & ( |broadcast_resp_last) & bready_buf)
			| ( (|broadcast_resp_hit) & (~|broadcast_resp_last)             ) 
		        | (~(|broadcast_resp_hit) & bready_buf)
			;

assign	bid_buf		= idq[bid_arb][ID_WIDTH-1:0];

wire	[1:0]	broadcast_bresp_buf;

atcaxi2tluh500_mux_onehot #(
    .N(HR_NUM),
    .W(2)
) u_bresp_buf (
    .out(broadcast_bresp_buf),
    .sel(broadcast_resp_hit),
    .in(broadcast_resp_bresp)
);

assign bresp_buf = broadcast_bresp_buf | bresp_arb;

assign	rvalid_buf = rvalid_arb;
assign	rready_arb = rready_buf;
assign	rid_buf    = idq[rid_arb][ID_WIDTH-1:0];
assign	rresp_buf  = rresp_arb;
assign	rdata_buf  = rdata_arb;
assign	rlast_buf  = rlast_arb;

`ifdef OVL_ASSERT_ON
// pragma coverage off
wire	u_ovl_broadcast_len_chk_test_expr = ((~broadcast_init & ~broadcast_last) == 0)
                                        && broadcast_last_len[5:0] == 6'h0
                                        && broadcast_init_len[5:0] == 6'h0
                                        && awlen_buf[5:0] == 6'h0;
ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_broadcast_len_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(1'b1					),
	.test_expr	(u_ovl_broadcast_len_chk_test_expr	),
	.fire		(					)
);

ovl_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (HR_NUM     )
) u_one_hot_idq_register_hit_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  (idq_register_hit       ),
    .fire       (                       )
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (HR_NUM     )
) u_zero_one_hot_idq_valid_set_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  (idq_valid_set          ),
    .fire       (                       )
);

ovl_bits #(
        .severity_level (`OVL_FATAL ),
        .msg    (`__FILE__),
        .width  (HR_NUM),
        .min    (0),
        .max    (2)
) u_ovl_bits_idq_valid_clr_chk (
        .clock      (clk                    ),
        .reset      (resetn                 ),
        .enable     (1'b1                   ),
        .test_expr  (idq_valid_clr          )
);

wire [HR_NUM-1:0] u_ovl_never_idq_set_clr_test_expr;
wire [HR_NUM-1:0] u_ovl_never_idq_valid_set_test_expr;
generate
for (hr_idx = 0; hr_idx < HR_NUM; hr_idx = hr_idx + 1) begin: gen_idq_entry_chk
        assign u_ovl_never_idq_set_clr_test_expr[hr_idx] = idq_valid_set[hr_idx] & idq_valid_clr[hr_idx];
        ovl_never #(
                .msg		(`__FILE__	)
        ) u_ovl_never_idq_set_clr_chk (
                .clock		(clk				        ),
                .reset		(resetn				        ),
                .enable		(1'b1					),
                .test_expr	(u_ovl_never_idq_set_clr_test_expr[hr_idx]   	),
                .fire		(					)
        );
        
        assign u_ovl_never_idq_valid_set_test_expr[hr_idx] = idq_valid_set[hr_idx] & idq_valid[hr_idx];
        ovl_never #(
                .msg		(`__FILE__	)
        ) u_ovl_never_idq_valid_set_chk (
                .clock		(clk				        ),
                .reset		(resetn				        ),
                .enable		(1'b1					),
                .test_expr	(u_ovl_never_idq_valid_set_test_expr[hr_idx]   	),
                .fire		(					)
        );
end
endgenerate

wire u_ovl_always_idq_wr_brdcst_init_enable = (|idq_valid_set) & arb_grant[ARB_W] & broadcast_init;
wire u_ovl_always_idq_wr_brdcst_init_test_expr = (|idq_aw_hazard)== 1'b0;
ovl_always #(
        .msg		(`__FILE__	)
) u_ovl_always_idq_wr_brdcst_init_chk (
        .clock		(clk				        ),
        .reset		(resetn				        ),
        .enable		(u_ovl_always_idq_wr_brdcst_init_enable	),
        .test_expr	(u_ovl_always_idq_wr_brdcst_init_test_expr	),
        .fire		(					)
);

wire u_ovl_always_idq_ar_hazard_enable = (|idq_valid_set) & arb_grant[ARB_R];
wire u_ovl_always_idq_ar_hazard_test_expr = (|idq_ar_hazard)== 1'b0;
ovl_always #(
        .msg		(`__FILE__	)
) u_ovl_always_idq_ar_hazard_chk (
        .clock		(clk				        ),
        .reset		(resetn				        ),
        .enable		(u_ovl_always_idq_ar_hazard_enable	),
        .test_expr	(u_ovl_always_idq_ar_hazard_test_expr	),
        .fire		(					)
);

wire	u_ovl_never_idq_full_set_enable = &idq_valid; //full
wire	u_ovl_never_idq_full_set_test_expr = |idq_valid_set;
ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_idq_full_set_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_never_idq_full_set_enable	),
	.test_expr	(u_ovl_never_idq_full_set_test_expr	),
	.fire		(				)
);

wire u_ovl_always_brdcst_condition_enable = broadcast_cnt_en;
wire u_ovl_always_brdcst_condition_test_expr = !w_is_device & (awburst_buf == AXI_BURST_INCR);
ovl_always #(
        .msg		(`__FILE__	)
) u_ovl_always_brdcst_condition_chk (
        .clock		(clk				        ),
        .reset		(resetn				        ),
        .enable		(u_ovl_always_brdcst_condition_enable	),
        .test_expr	(u_ovl_always_brdcst_condition_test_expr	),
        .fire		(					)
);

wire [HR_NUM-1:0] ar_id_hit;
generate
for (hr_idx = 0; hr_idx < HR_NUM; hr_idx = hr_idx + 1) begin: idq_comparator
        assign ar_id_hit[hr_idx] = (idq_valid[hr_idx] & idq[hr_idx][ID_WIDTH] & idq[hr_idx][ID_WIDTH-1:0]==arid_buf);
end
endgenerate

wire	u_ovl_never_enque_id_hit_registerd_arid_enable = (|idq_valid_set) & arb_grant[ARB_R]; 
wire	u_ovl_never_enque_id_hit_registerd_arid_test_expr = (|ar_id_hit);
ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_enque_id_hit_registerd_arid_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_never_enque_id_hit_registerd_arid_enable	),
	.test_expr	(u_ovl_never_enque_id_hit_registerd_arid_test_expr	),
	.fire		(				)
);

wire [HR_NUM-1:0] bid_entry_hit;
wire [HR_NUM-1:0] awid_hit;
reg [ID_WIDTH-1:0] awid_q [0:HR_NUM-1];
reg [HR_NUM-1:0] v_q;
wire [HR_IDX_WIDTH-1:0] free_entry;
wire [HR_IDX_WIDTH-1:0] b_hit_idx;
wire nlz;
wire aw_trans = awvalid_buf & awready_buf;
wire b_trans  = bvalid_buf & bready_buf;

generate
genvar idx;
for (idx=0; idx<HR_NUM; idx = idx+1) begin: gen_entry_comparator
        assign bid_entry_hit[idx] = v_q[idx] & (awid_q[idx] == bid_buf);
        assign awid_hit[idx] = v_q[idx] & (awid_q[idx] == awid_buf);
end
if (HR_NUM > 1) begin: gen_bid_entry_idx_hr_num_gt_1
        atcaxi2tluh500_leading_zero #(
                .N	(HR_NUM)
        ) u_v_q_free_entry (
                .o	(free_entry),
                .i	(v_q),
                .nlz	(nlz)
        );

        atcaxi2tluh500_onehot2bin #(
                .N	(HR_NUM	)
        ) u_b_hit_idx (
                .out		(b_hit_idx),
                .in		(bid_entry_hit)
        );
end else begin: gen_bid_entry_idx_hr_num_eq_1
        assign free_entry = 1'b0;
        assign nlz = v_q[0];
        assign b_hit_idx = 1'b0;
end
endgenerate


wire bid_retire = b_trans & (|bid_entry_hit);
wire aw_enque = aw_trans & ((nlz & bid_retire) | !nlz);

always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
                v_q <= {HR_NUM{1'b0}};
        end else if (aw_enque & bid_retire) begin
                awid_q[b_hit_idx] <= awid_buf;
                v_q[b_hit_idx]    <= 1'b1;
        end else if (aw_enque) begin
                awid_q[free_entry] <= awid_buf;
                v_q[free_entry]    <= 1'b1;
        end else if (bid_retire) begin
                v_q[b_hit_idx]     <= 1'b0;
        end
end

wire	u_ovl_never_awid_register_again_before_retire_enable = aw_trans; 
wire	u_ovl_never_awid_register_again_before_retire_test_expr = (|awid_hit);
ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_never_awid_register_again_before_retire_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_never_awid_register_again_before_retire_enable	),
	.test_expr	(u_ovl_never_awid_register_again_before_retire_test_expr	),
	.fire		(				)
);

wire	u_ovl_always_retired_bid_hit_enable = b_trans; 
wire	u_ovl_always_retired_bid_hit_test_expr = (|bid_entry_hit);
ovl_always #(
	.msg		(`__FILE__	)
) u_ovl_always_retired_bid_hit_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_always_retired_bid_hit_enable	),
	.test_expr	(u_ovl_always_retired_bid_hit_test_expr	),
	.fire		(				)
);

ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_never_aw_carry_chk (
	.clock		(clk						),
	.reset		(resetn						),
	.enable		(axvalid_arb & arb_grant[ARB_W]	& ~w_is_single	),
	.test_expr	(nds_unused_aw_carry				),
	.fire		(						)
);

ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_never_ar_carry_chk (
	.clock		(clk						),
	.reset		(resetn						),
	.enable		(axvalid_arb & arb_grant[ARB_R] & ~r_is_single	),
	.test_expr	(nds_unused_ar_carry				),
	.fire		(						)
);

ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_never_broadcast_addr_carry_chk (
	.clock		(clk							),
	.reset		(resetn							),
	.enable		(axvalid_arb & arb_grant[ARB_W] & broadcast_valid	),
	.test_expr	(nds_unused_broadcast_addr_carry			),
	.fire		(							)
);

ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_never_broadcast_init_len_carry_chk (
	.clock		(clk							),
	.reset		(resetn							),
	.enable		(axvalid_arb & arb_grant[ARB_W] & broadcast_valid	),
	.test_expr	(nds_unused_broadcast_init_len_carry			),
	.fire		(							)
);

// pragma coverage on
`endif // OVL_ASSERT_ON

endmodule
