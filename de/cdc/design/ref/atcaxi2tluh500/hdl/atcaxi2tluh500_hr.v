module atcaxi2tluh500_hr (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  clk,      
        	  resetn,   
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
        	  rlast_arb,
        	  a_valid,  
        	  a_ready,  
        	  a_opcode, 
        	  a_size,   
        	  a_source, 
        	  a_address,
        	  a_mask,   
        	  a_data,   
        	  a_user,   
        	  a_corrupt,
        	  a_param,  
        	  d_valid,  
        	  d_ready,  
        	  d_opcode, 
        	  d_source, 
        	  d_denied, 
        	  d_corrupt,
        	  d_data,   
        	  d_user    
        // VPERL_GENERATED_END
);

parameter	ADDR_WIDTH	= 64;
parameter	DATA_WIDTH	= 256;
parameter	TL_SIZE_WIDTH	= 4;
parameter	TL_SOURCE_WIDTH	= 3;
parameter	TL_A_USER_WIDTH	= 8;
parameter	TL_D_USER_WIDTH	= 8;
parameter	TL_OUTSTANDING	= 8;
parameter	TL_CHANNEL_NUM	= 4;
parameter	AX_FUNC_BITS	= 4;
parameter	RAR_SUPPORT	= 0;

localparam	OUT_IDX_WIDTH	= $clog2(TL_OUTSTANDING);
localparam	CH_IDX_WIDTH	= $clog2(TL_CHANNEL_NUM);
localparam	HR_IDX_WIDTH	= ((OUT_IDX_WIDTH + CH_IDX_WIDTH) == 0) ?  1 : (OUT_IDX_WIDTH + CH_IDX_WIDTH);
localparam	HR_NUM		= 2**(OUT_IDX_WIDTH + CH_IDX_WIDTH);

input        						clk;
input        						resetn;

// AXI_CMD
input							axvalid_arb;
output							axready_arb;
input	[(HR_IDX_WIDTH-1):0]				axid_arb;
input	[(ADDR_WIDTH-1):0]				axaddr_arb;
input	[7:0]						axlen_arb;
input	[2:0]						axsize_arb;
input	[1:0]						axburst_arb;
input	[3:0]						axcache_arb;
input	[2:0]						axprot_arb;
input	[(AX_FUNC_BITS-1):0]				axfunc_arb;
input	[5:0]						axaddrlast_arb;
input	[5:0]						axburstlen_arb;
// AXI WDATA
input							wvalid_arb;
output							wready_arb;
input	[(HR_IDX_WIDTH-1):0]				wid_arb;
input	[(DATA_WIDTH-1):0]				wdata_arb;
input	[((DATA_WIDTH/8)-1):0]				wstrb_arb;
input							wlast_arb;
// AXI_RESP
output							bvalid_arb;
input							bready_arb;
output	[(HR_IDX_WIDTH-1):0]				bid_arb;
output	[1:0]						bresp_arb;
output							rvalid_arb;
input							rready_arb;
output	[(HR_IDX_WIDTH-1):0]				rid_arb;
output	[1:0]						rresp_arb;
output	[(DATA_WIDTH-1):0]				rdata_arb;
output							rlast_arb;
// TL-A
output	[(TL_CHANNEL_NUM-1):0]				a_valid;	
input	[(TL_CHANNEL_NUM-1):0]				a_ready;
output	[((TL_CHANNEL_NUM*3)-1):0]			a_opcode;
output	[((TL_CHANNEL_NUM*3)-1):0]			a_size;
output	[((TL_CHANNEL_NUM*TL_SOURCE_WIDTH)-1):0]	a_source;
output	[((TL_CHANNEL_NUM*ADDR_WIDTH)-1):0]		a_address;
output	[((TL_CHANNEL_NUM*(DATA_WIDTH/8))-1):0]		a_mask;
output	[((TL_CHANNEL_NUM*DATA_WIDTH)-1):0]		a_data;
output	[((TL_CHANNEL_NUM*7)-1):0]			a_user;
output	[(TL_CHANNEL_NUM-1):0]				a_corrupt;	
output	[((TL_CHANNEL_NUM*3)-1):0]			a_param;

//TL-D
input	[(TL_CHANNEL_NUM-1):0]				d_valid;
output  [(TL_CHANNEL_NUM-1):0]				d_ready;
input	[((TL_CHANNEL_NUM*3)-1):0]			d_opcode;
input	[((TL_CHANNEL_NUM*TL_SOURCE_WIDTH)-1):0]	d_source;
input	[(TL_CHANNEL_NUM-1):0]				d_denied;
input	[(TL_CHANNEL_NUM-1):0]				d_corrupt;
input	[((TL_CHANNEL_NUM*DATA_WIDTH)-1):0]		d_data;
input	[((TL_CHANNEL_NUM*2)-1):0]			d_user;

wire							bready_tmp;
wire							rready_tmp;

wire	[(HR_NUM-1):0]					hr_axvalid;
wire	[(HR_NUM-1):0]					hr_axready;
wire	[(HR_NUM-1):0]					hr_wvalid;
wire	[(HR_NUM-1):0]					hr_wready;
wire	[(HR_NUM-1):0]					hr_bvalid;
wire	[(HR_NUM-1):0]					hr_bready;
wire	[2*HR_NUM-1:0]					hr_bresp;
wire	[(HR_NUM-1):0]					hr_rvalid;
wire	[(HR_NUM-1):0]					hr_rready;
wire	[2*HR_NUM-1:0]					hr_rresp;
wire	[(DATA_WIDTH*HR_NUM-1):0]			hr_rdata;
wire	[(HR_NUM-1):0]					hr_rlast;

wire	[(HR_NUM-1):0]					hr_b_arb_grant;
wire	[(HR_NUM-1):0]					hr_r_arb_grant;

wire	[(HR_NUM-1):0]					hr_a_valid;	
wire	[(HR_NUM-1):0]					hr_a_ready;
wire	[HR_NUM*3-1:0]					hr_a_opcode;
wire	[HR_NUM*3-1:0]					hr_a_size;
wire	[(HR_NUM*ADDR_WIDTH-1):0]			hr_a_address;
wire	[(HR_NUM*(DATA_WIDTH/8)-1):0]			hr_a_mask;
wire	[(HR_NUM*DATA_WIDTH-1):0]			hr_a_data;
wire	[HR_NUM*7-1:0]					hr_a_user;
wire	[(HR_NUM-1):0]					hr_a_last;

wire	[(HR_NUM-1):0]					hr_d_valid;
wire	[(HR_NUM-1):0]					hr_d_ready;
wire	[HR_NUM*3-1:0]					hr_d_opcode;
wire	[(HR_NUM-1):0]					hr_d_denied;
wire	[(HR_NUM-1):0]					hr_d_corrupt;
wire	[(HR_NUM*DATA_WIDTH-1):0]			hr_d_data;
wire	[HR_NUM*2-1:0]					hr_d_user;

generate
genvar hr_idx;
genvar ch_idx;
genvar out_idx;

if (HR_NUM == HR_IDX_WIDTH) begin: gen_single_hr
	assign axready_arb      = hr_axready;
	assign wready_arb	= hr_wready;	
	assign hr_b_arb_grant   = 1'b1;
	assign bvalid_arb	= hr_bvalid;
	assign bid_arb		= 1'b0;
	assign bresp_arb	= hr_bresp[1:0];
	assign bready_tmp	= bready_arb;
	assign hr_r_arb_grant   = 1'b1;
	assign rvalid_arb	= hr_rvalid;
	assign rid_arb		= 1'b0;
	assign rresp_arb	= hr_rresp[1:0];
	assign rdata_arb	= hr_rdata[(DATA_WIDTH-1):0];
	assign rlast_arb	= hr_rlast;
	assign rready_tmp	= rready_arb;
end
else begin : gen_multiple_hr
	wire	[(HR_IDX_WIDTH-1):0]				hr_r_sel;
	wire	[(HR_IDX_WIDTH-1):0]				hr_b_sel;

	wire							bvalid_arb_sel;
	wire	[1:0]						bresp_arb_sel;

	wire							rvalid_arb_sel;
	wire	[1:0]						rresp_arb_sel;
	wire	[(DATA_WIDTH-1):0]				rdata_arb_sel;
	wire							rlast_arb_sel;

	assign	axready_arb = hr_axready[axid_arb];
	assign	wready_arb = hr_wready[wid_arb];

	if ((TL_CHANNEL_NUM == 1) | (TL_OUTSTANDING == 1)) begin: gen_b_single_ch_out_arb
		wire [HR_NUM-1:0] nds_unused_hr_b_arb_ready;
		atcaxi2tluh500_arb_rr #(
			.N	(HR_NUM	)
		) u_axi_b_arb (
			.clk		(clk				),
			.resetn		(resetn				),
			.en		(1'b1				),
			.valid		(hr_bvalid			),
			.ready		(nds_unused_hr_b_arb_ready	),
			.grant		(hr_b_arb_grant			)
		);
	end
	else begin: gen_b_multiple_ch_out_arb
		wire	[TL_CHANNEL_NUM-1:0]	hr_b_ch_arb_valid;
		wire	[TL_CHANNEL_NUM-1:0]	hr_b_ch_arb_grant;
		wire	[TL_CHANNEL_NUM-1:0]	nds_unused_hr_b_ch_arb_ready;
		for (ch_idx = 0; ch_idx < TL_CHANNEL_NUM; ch_idx = ch_idx + 1) begin: gen_hr_b_out_arb_valid
			wire	[TL_OUTSTANDING-1:0]	hr_b_out_arb_valid = hr_bvalid[ch_idx*TL_OUTSTANDING+:TL_OUTSTANDING];
			wire	[TL_OUTSTANDING-1:0]	hr_b_out_arb_grant;
			wire	[TL_OUTSTANDING-1:0]	nds_unused_hr_b_out_arb_ready;
			atcaxi2tluh500_arb_rr #(
				.N	(TL_OUTSTANDING	)
			) u_axi_b_out_arb (
				.clk		(clk				),
				.resetn		(resetn				),
				.en		(1'b1				),
				.valid		(hr_b_out_arb_valid		),
				.ready		(nds_unused_hr_b_out_arb_ready	),
				.grant		(hr_b_out_arb_grant		)
			);
			assign	hr_b_ch_arb_valid[ch_idx] = |hr_b_out_arb_valid;
			assign	hr_b_arb_grant[ch_idx*TL_OUTSTANDING+:TL_OUTSTANDING] = hr_b_out_arb_grant & {TL_OUTSTANDING{hr_b_ch_arb_grant[ch_idx]}};
		end
		atcaxi2tluh500_arb_rr #(
			.N	(TL_CHANNEL_NUM	)
		) u_axi_b_ch_arb (
			.clk		(clk				),
			.resetn		(resetn				),
			.en		(1'b1				),
			.valid		(hr_b_ch_arb_valid		),
			.ready		(nds_unused_hr_b_ch_arb_ready	),
			.grant		(hr_b_ch_arb_grant		)
		);
	end
	
	atcaxi2tluh500_onehot2bin #(
		.N	(HR_NUM	)
	) u_axi_b_sel (
		.out		(hr_b_sel),
		.in		(hr_b_arb_grant)
		
	);

	atcaxi2tluh500_mux_onehot #(
	    .N(HR_NUM),
	    .W(1)
	) u_bvalid_arb_sel_sel (
	    .out(bvalid_arb_sel),
	    .sel(hr_b_arb_grant),
	    .in(hr_bvalid)
	);

	atcaxi2tluh500_mux_onehot #(
	    .N(HR_NUM),
	    .W(2)
	) u_bresp_arb_sel (
	    .out(bresp_arb_sel),
	    .sel(hr_b_arb_grant),
	    .in(hr_bresp)
	);

	// Add buffer to cut timing path
	atcaxi2tluh500_elastic_buffer_o #(
		.DW		(HR_IDX_WIDTH+2),
		.RAR_SUPPORT	(RAR_SUPPORT)
	) u_b_buffer (
		.clk		(clk),
		.clk_en		(1'b1),
		.resetn		(resetn),
		.i_valid	(bvalid_arb_sel),
		.i_ready	(bready_tmp),
		.din		({ 	hr_b_sel
				,	bresp_arb_sel
				}),
		.o_valid	(bvalid_arb),
		.o_ready	(bready_arb),
		.dout		({ 	bid_arb
				,	bresp_arb
				})
	);

	if ((TL_CHANNEL_NUM == 1) | (TL_OUTSTANDING == 1)) begin: gen_r_single_ch_out_arb
		wire [HR_NUM-1:0] nds_unused_hr_r_arb_ready;
		atcaxi2tluh500_arb_rr #(
			.N	(HR_NUM	)
		) u_axi_r_arb (
			.clk		(clk				),
			.resetn		(resetn				),
			.en		(1'b1				),
			.valid		(hr_rvalid			),
			.ready		(nds_unused_hr_r_arb_ready	),
			.grant		(hr_r_arb_grant			)
		);
	end
	else begin: gen_r_multiple_ch_out_arb
		wire	[TL_CHANNEL_NUM-1:0]	hr_r_ch_arb_valid;
		wire	[TL_CHANNEL_NUM-1:0]	hr_r_ch_arb_grant;
		wire	[TL_CHANNEL_NUM-1:0]	nds_unused_hr_r_ch_arb_ready;
		for (ch_idx = 0; ch_idx < TL_CHANNEL_NUM; ch_idx = ch_idx + 1) begin: gen_hr_r_out_arb_valid
			wire	[TL_OUTSTANDING-1:0]	hr_r_out_arb_valid = hr_rvalid[ch_idx*TL_OUTSTANDING+:TL_OUTSTANDING];
			wire	[TL_OUTSTANDING-1:0]	hr_r_out_arb_grant;
			wire	[TL_OUTSTANDING-1:0]	nds_unused_hr_r_out_arb_ready;
			atcaxi2tluh500_arb_rr #(
				.N	(TL_OUTSTANDING	)
			) u_axi_r_out_arb (
				.clk		(clk				),
				.resetn		(resetn				),
				.en		(1'b1				),
				.valid		(hr_r_out_arb_valid		),
				.ready		(nds_unused_hr_r_out_arb_ready	),
				.grant		(hr_r_out_arb_grant		)
			);
			assign	hr_r_ch_arb_valid[ch_idx] = |hr_r_out_arb_valid;
			assign	hr_r_arb_grant[ch_idx*TL_OUTSTANDING+:TL_OUTSTANDING] = hr_r_out_arb_grant & {TL_OUTSTANDING{hr_r_ch_arb_grant[ch_idx]}};
		end
		atcaxi2tluh500_arb_rr #(
			.N	(TL_CHANNEL_NUM	)
		) u_axi_r_ch_arb (
			.clk		(clk				),
			.resetn		(resetn				),
			.en		(1'b1				),
			.valid		(hr_r_ch_arb_valid		),
			.ready		(nds_unused_hr_r_ch_arb_ready	),
			.grant		(hr_r_ch_arb_grant		)
		);
	end

	atcaxi2tluh500_onehot2bin #(
		.N	(HR_NUM	)
	) u_axi_r_sel (
		.out		(hr_r_sel),
		.in		(hr_r_arb_grant)
		
	);

	atcaxi2tluh500_mux_onehot #(
	    .N(HR_NUM),
	    .W(1)
	) u_rvalid_arb_sel (
	    .out(rvalid_arb_sel),
	    .sel(hr_r_arb_grant),
	    .in(hr_rvalid)
	);

	atcaxi2tluh500_mux_onehot #(
	    .N(HR_NUM),
	    .W(2)
	) u_rresp_arb_sel (
	    .out(rresp_arb_sel),
	    .sel(hr_r_arb_grant),
	    .in(hr_rresp)
	);

	atcaxi2tluh500_mux_onehot #(
	    .N(HR_NUM),
	    .W(DATA_WIDTH)
	) u_rdata_arb_sel (
	    .out(rdata_arb_sel),
	    .sel(hr_r_arb_grant),
	    .in(hr_rdata)
	);

	atcaxi2tluh500_mux_onehot #(
	    .N(HR_NUM),
	    .W(1)
	) u_rlast_arb_sel (
	    .out(rlast_arb_sel),
	    .sel(hr_r_arb_grant),
	    .in(hr_rlast)
	);

	// Add buffer to cut timing path
	atcaxi2tluh500_elastic_buffer_o #(
		.DW		(DATA_WIDTH+HR_IDX_WIDTH+2+1),
		.RAR_SUPPORT	(RAR_SUPPORT)
	) u_r_buffer (
		.clk		(clk),
		.clk_en		(1'b1),
		.resetn		(resetn),
		.i_valid	(rvalid_arb_sel),
		.i_ready	(rready_tmp),
		.din		({ 	hr_r_sel
				,	rresp_arb_sel
				,	rdata_arb_sel
				,	rlast_arb_sel
				}),
		.o_valid	(rvalid_arb),
		.o_ready	(rready_arb),
		.dout		({ 	rid_arb
				,	rresp_arb
				,	rdata_arb
				,	rlast_arb
				})
	);

end

for (hr_idx = 0; hr_idx < HR_NUM; hr_idx = hr_idx + 1) begin: gen_hr_ent

	assign hr_axvalid[hr_idx] = (axid_arb == hr_idx[(HR_IDX_WIDTH-1):0]) & axvalid_arb;
	assign hr_wvalid[hr_idx] = (wid_arb == hr_idx[(HR_IDX_WIDTH-1):0])& wvalid_arb;

	atcaxi2tluh500_hr_ent #(
		.ADDR_WIDTH		(ADDR_WIDTH			),
		.DATA_WIDTH		(DATA_WIDTH			),
		.TL_A_USER_WIDTH	(TL_A_USER_WIDTH		),
		.TL_D_USER_WIDTH	(TL_D_USER_WIDTH		),
		.TL_SIZE_WIDTH		(TL_SIZE_WIDTH			),
		.AX_FUNC_BITS		(AX_FUNC_BITS			),
		.RAR_SUPPORT		(RAR_SUPPORT			)
	) u_hr_ent (
		.clk		(clk							),
		.resetn	(resetn								),
		.axvalid	(hr_axvalid[hr_idx]					),
		.axready	(hr_axready[hr_idx]					),
		.axaddr		(axaddr_arb						),
		.axlen		(axlen_arb						),
		.axsize		(axsize_arb						),
		.axburst	(axburst_arb						),
		.axcache	(axcache_arb						),
		.axprot		(axprot_arb						),
		.axfunc		(axfunc_arb						),
		.axaddrlast	(axaddrlast_arb						),
		.axburstlen	(axburstlen_arb						),
		.wvalid		(hr_wvalid[hr_idx]					),
		.wready		(hr_wready[hr_idx]					),
		.wdata		(wdata_arb						),
		.wstrb		(wstrb_arb						),
		.wlast		(wlast_arb						),
		.bvalid		(hr_bvalid[hr_idx]					),
		.bready		(hr_bready[hr_idx]					),
		.bresp		(hr_bresp[hr_idx*2+:2]					),
		.rvalid		(hr_rvalid[hr_idx]					),
		.rready		(hr_rready[hr_idx]					),
		.rresp		(hr_rresp[hr_idx*2+:2]					),
		.rdata		(hr_rdata[hr_idx*DATA_WIDTH+:DATA_WIDTH]		),
		.rlast		(hr_rlast[hr_idx]					),
		.a_valid	(hr_a_valid[hr_idx]					),
		.a_ready	(hr_a_ready[hr_idx]					),
		.a_opcode	(hr_a_opcode[hr_idx*3+:3]				),
		.a_size		(hr_a_size[hr_idx*3+:3]					),
		.a_address	(hr_a_address[hr_idx*ADDR_WIDTH+:ADDR_WIDTH]		),
		.a_mask		(hr_a_mask[hr_idx*(DATA_WIDTH/8)+:(DATA_WIDTH/8)]	),
		.a_data		(hr_a_data[hr_idx*DATA_WIDTH+:DATA_WIDTH]		),
		.a_user		(hr_a_user[hr_idx*7+:7]					),
		.a_last		(hr_a_last[hr_idx]					),
		.d_valid	(hr_d_valid[hr_idx]					),
		.d_ready	(hr_d_ready[hr_idx]					),
		.d_opcode	(hr_d_opcode[hr_idx*3+:3]				),
		.d_denied	(hr_d_denied[hr_idx]					),
		.d_corrupt	(hr_d_corrupt[hr_idx]					),
		.d_data		(hr_d_data[hr_idx*DATA_WIDTH+:DATA_WIDTH]		),
		.d_user		(hr_d_user[hr_idx*2+:2]					)
	);
	assign	hr_bready[hr_idx] = hr_b_arb_grant[hr_idx] & bready_tmp;
	assign	hr_rready[hr_idx] = hr_r_arb_grant[hr_idx] & rready_tmp;

end

for (ch_idx = 0; ch_idx < TL_CHANNEL_NUM; ch_idx = ch_idx + 1) begin: gen_ch_arb
	if (TL_OUTSTANDING == 1) begin: gen_tl_no_outstanding
		assign	a_valid[ch_idx]                                   = hr_a_valid[ch_idx];
		assign	hr_a_ready[ch_idx]                                = a_ready[ch_idx];
		assign	a_opcode[ch_idx*3+:3]                             = hr_a_opcode[ch_idx*3+:3];
		assign	a_size[ch_idx*3+:3]      		          = hr_a_size[ch_idx*3+:3];
		assign	a_source[ch_idx*TL_SOURCE_WIDTH+:TL_SOURCE_WIDTH] = {TL_SOURCE_WIDTH{1'b0}};	
		assign	a_address[ch_idx*ADDR_WIDTH+:ADDR_WIDTH]          = hr_a_address[ch_idx*ADDR_WIDTH+:ADDR_WIDTH];
		assign	a_mask[ch_idx*(DATA_WIDTH/8)+:(DATA_WIDTH/8)]     = hr_a_mask[ch_idx*(DATA_WIDTH/8)+:(DATA_WIDTH/8)];
		assign	a_data[ch_idx*DATA_WIDTH+:DATA_WIDTH]             = hr_a_data[ch_idx*DATA_WIDTH+:DATA_WIDTH];
		assign	a_user[ch_idx*7+:7]   				  = hr_a_user[ch_idx*7+:7];
		assign	a_corrupt[ch_idx]                                 = 1'b0;
		assign	a_param[ch_idx*3+:3]                              = 3'b0;
		assign	hr_d_valid[ch_idx]                                = d_valid[ch_idx];
		assign	hr_d_opcode[ch_idx*3+:3]                          = d_opcode[ch_idx*3+:3];
		assign	hr_d_denied[ch_idx]                               = d_denied[ch_idx];
		assign	hr_d_corrupt[ch_idx]                              = d_corrupt[ch_idx];
		assign	hr_d_data[ch_idx*DATA_WIDTH+:DATA_WIDTH]          = d_data[ch_idx*DATA_WIDTH+:DATA_WIDTH];
		assign	hr_d_user[ch_idx*2+:2]                            = d_user[ch_idx*2+:2];
		assign	d_ready[ch_idx]                                   = hr_d_ready[ch_idx];
		wire	[(HR_NUM-1):0] nds_unused_hr_a_last				  = hr_a_last;
	end
	else begin: gen_tl_outstanding
		reg	[(TL_OUTSTANDING-1):0]	hr_a_arb_en;
		wire	[(TL_OUTSTANDING-1):0]	hr_a_arb_en_nx;
		wire	[(TL_OUTSTANDING-1):0]	hr_a_arb_valid = hr_a_valid[ch_idx*TL_OUTSTANDING+:TL_OUTSTANDING] & hr_a_arb_en;	
		wire	[(TL_OUTSTANDING-1):0]	hr_a_arb_grant;
		wire	[(OUT_IDX_WIDTH-1):0]	hr_a_sel;
		wire				a_last;

		wire				hr_a_arb_en_set	= a_valid[ch_idx] & a_ready[ch_idx];
		always @ (posedge clk or negedge resetn) begin
			if (!resetn) begin
				hr_a_arb_en <= {TL_OUTSTANDING{1'b1}};
			end
			else if (hr_a_arb_en_set) begin
				hr_a_arb_en <= hr_a_arb_en_nx;
			end
		end

		assign	hr_a_arb_en_nx = ({TL_OUTSTANDING{a_last}} | ({TL_OUTSTANDING{~a_last}} & hr_a_arb_grant));

		wire [TL_OUTSTANDING-1:0] nds_unused_hr_a_arb_ready;
		atcaxi2tluh500_arb_rr #(
			.N	(TL_OUTSTANDING	)
		) u_tl_a_arb (
			.clk		(clk				),
			.resetn		(resetn				),
			.en		(1'b1				),
			.valid		(hr_a_arb_valid			),
			.ready		(nds_unused_hr_a_arb_ready	),
			.grant		(hr_a_arb_grant			)
		);
	
		atcaxi2tluh500_onehot2bin #(
			.N	(TL_OUTSTANDING	)
		) u_tl_a_sel (
			.out		(hr_a_sel),
			.in		(hr_a_arb_grant)
			
		);

		atcaxi2tluh500_mux_onehot #(
			.N(TL_OUTSTANDING),
			.W(1)
		) u_a_valid_sel (
			.out(a_valid[ch_idx]),
			.sel(hr_a_arb_grant),
			.in(hr_a_valid[ch_idx*TL_OUTSTANDING+:TL_OUTSTANDING])
		);
		
	
		for (out_idx = 0; out_idx < TL_OUTSTANDING; out_idx = out_idx + 1) begin: gen_hr_a_ready
			assign hr_a_ready[(ch_idx * TL_OUTSTANDING) + out_idx] = hr_a_arb_grant[out_idx] & a_ready[ch_idx];
		end
	
		atcaxi2tluh500_mux_onehot #(
			.N(TL_OUTSTANDING),
			.W(3)
		) u_a_opcode_sel (
			.out(a_opcode[ch_idx*3+:3]),
			.sel(hr_a_arb_grant),
			.in(hr_a_opcode[ch_idx*3*TL_OUTSTANDING+:TL_OUTSTANDING*3])
		);

		atcaxi2tluh500_mux_onehot #(
			.N(TL_OUTSTANDING),
			.W(3)
		) u_a_size_sel (
			.out(a_size[ch_idx*3+:3]),
			.sel(hr_a_arb_grant),
			.in(hr_a_size[ch_idx*3*TL_OUTSTANDING+:TL_OUTSTANDING*3])
		);
	
		atcaxi2tluh500_zero_ext #(
			.OW	(TL_SOURCE_WIDTH	),
			.IW	(OUT_IDX_WIDTH		)
		) u_tl_a_source_zext (
			.out		(a_source[ch_idx*TL_SOURCE_WIDTH+:TL_SOURCE_WIDTH]	),
			.in		(hr_a_sel						)
		);

		atcaxi2tluh500_mux_onehot #(
			.N(TL_OUTSTANDING),
			.W(ADDR_WIDTH)
		) u_a_address_sel (
			.out(a_address[ch_idx*ADDR_WIDTH+:ADDR_WIDTH]),
			.sel(hr_a_arb_grant),
			.in(hr_a_address[ch_idx*ADDR_WIDTH*TL_OUTSTANDING+:TL_OUTSTANDING*ADDR_WIDTH])
		);

		atcaxi2tluh500_mux_onehot #(
			.N(TL_OUTSTANDING),
			.W(DATA_WIDTH/8)
		) u_a_mask_sel (
			.out(a_mask[ch_idx*(DATA_WIDTH/8)+:(DATA_WIDTH/8)]),
			.sel(hr_a_arb_grant),
			.in(hr_a_mask[ch_idx*(DATA_WIDTH/8)*TL_OUTSTANDING+:TL_OUTSTANDING*(DATA_WIDTH/8)])
		);

		atcaxi2tluh500_mux_onehot #(
			.N(TL_OUTSTANDING),
			.W(DATA_WIDTH)
		) u_a_data_sel (
			.out(a_data[ch_idx*DATA_WIDTH+:DATA_WIDTH]),
			.sel(hr_a_arb_grant),
			.in(hr_a_data[ch_idx*DATA_WIDTH*TL_OUTSTANDING+:TL_OUTSTANDING*DATA_WIDTH])
		);

		atcaxi2tluh500_mux_onehot #(
			.N(TL_OUTSTANDING),
			.W(7)
		) u_a_user_sel (
			.out(a_user[ch_idx*7+:7]),
			.sel(hr_a_arb_grant),
			.in(hr_a_user[ch_idx*7*TL_OUTSTANDING+:TL_OUTSTANDING*7])
		);

		atcaxi2tluh500_mux_onehot #(
			.N(TL_OUTSTANDING),
			.W(1)
		) u_a_last_sel (
			.out(a_last),
			.sel(hr_a_arb_grant),
			.in(hr_a_last[ch_idx*TL_OUTSTANDING+:TL_OUTSTANDING])
		);

		assign	a_corrupt[ch_idx] = 1'b0;
		assign	a_param[ch_idx*3+:3] = 3'b0;
	
		for (out_idx = 0; out_idx < TL_OUTSTANDING; out_idx = out_idx + 1) begin: gen_hr_d
			assign	hr_d_valid[(ch_idx * TL_OUTSTANDING) + out_idx]                                    = (d_source[ch_idx*TL_SOURCE_WIDTH+:OUT_IDX_WIDTH] == out_idx[(OUT_IDX_WIDTH-1):0]) & d_valid[ch_idx];
			assign	hr_d_opcode[(ch_idx * 3 * TL_OUTSTANDING) + out_idx*3+:3]                          = d_opcode[ch_idx*3+:3];
			assign	hr_d_denied[(ch_idx * TL_OUTSTANDING) + out_idx]                                   = d_denied[ch_idx];
			assign	hr_d_corrupt[(ch_idx * TL_OUTSTANDING) + out_idx]                                  = d_corrupt[ch_idx];
			assign	hr_d_data[(ch_idx * DATA_WIDTH * TL_OUTSTANDING) + out_idx*DATA_WIDTH+:DATA_WIDTH] = d_data[ch_idx*DATA_WIDTH+:DATA_WIDTH];
			assign	hr_d_user[(ch_idx * 2 * TL_OUTSTANDING) + out_idx*2+:2]                            = d_user[ch_idx*2+:2];
		end

		wire	[TL_OUTSTANDING-1:0] hr_d_arb_grant;

		atcaxi2tluh500_bin2onehot #(
			.N(TL_OUTSTANDING)
		) u_hr_d_arb_grant (
			.out(hr_d_arb_grant),
			.in(d_source[ch_idx*TL_SOURCE_WIDTH+:OUT_IDX_WIDTH])
		);

		atcaxi2tluh500_mux_onehot #(
			.N(TL_OUTSTANDING),
			.W(1)
		) u_d_ready_sel (
			.out(d_ready[ch_idx]),
			.sel(hr_d_arb_grant),
			.in(hr_d_ready[ch_idx*TL_OUTSTANDING+:TL_OUTSTANDING])
		);
	end
end
endgenerate


`ifdef OVL_ASSERT_ON
// pragma coverage off
ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (HR_NUM     )
) u_zero_one_hot_hr_b_arb_grant_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  (hr_b_arb_grant         ),
    .fire       (                       )
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (HR_NUM     )
) u_zero_one_hot_hr_r_arb_grant_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  (hr_r_arb_grant         ),
    .fire       (                       )
);

generate
genvar idx;
for (idx = 0; idx < TL_CHANNEL_NUM; idx = idx + 1) begin: gen_ovl_ch_arb
	if (TL_OUTSTANDING == 1) begin: gen_ovl_tl_no_outstanding
        end else begin
                ovl_zero_one_hot #(
                    .severity_level (`OVL_FATAL ),
                    .msg            (`__FILE__  ),
                    .width          (TL_OUTSTANDING )
                ) u_zero_one_hot_hr_a_arb_grant_chk (
                    .clock      (clk                    ),
                    .reset      (resetn                 ),
                    .enable     (1'b1                   ),
                    .test_expr  (gen_ch_arb[idx].gen_tl_outstanding.hr_a_arb_grant         ),
                    .fire       (                       )
                );
        end
end
endgenerate

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (HR_NUM     )
) u_zero_one_hot_hr_axvalid_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  (hr_axvalid             ),
    .fire       (                       )
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (HR_NUM     )
) u_zero_one_hot_hr_wvalid_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  (hr_wvalid              ),
    .fire       (                       )
);
// pragma coverage on
`endif // OVL_ASSERT_ON

endmodule
