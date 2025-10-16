`include "config.inc"
`include "ae350_config.vh"

module sample_ae350_rstgen (
	//VPERL: &PORTLIST
	// VPERL_GENERATED_BEGIN
		  test_mode,
		  test_rstn,
		  pcs0_resetn,
		  pcs0_reset_source,
		  pcs1_resetn,
		  pcs1_reset_source,
		  pcs2_resetn,
		  pcs2_reset_source,
		  pcs3_resetn,
		  pcs3_slvp_resetn,
		  pcs3_reset_source,
		  pcs4_resetn,
		  pcs4_slvp_resetn,
		  pcs4_reset_source,
		  pcs5_resetn,
		  pcs5_slvp_resetn,
		  pcs5_reset_source,
		  pcs6_resetn,
		  pcs6_slvp_resetn,
		  pcs6_reset_source,
		  pcs7_resetn,
		  pcs7_slvp_resetn,
		  pcs7_reset_source,
		  pcs8_resetn,
		  pcs8_slvp_resetn,
		  pcs8_reset_source,
		  pcs9_resetn,
		  pcs9_slvp_resetn,
		  pcs9_reset_source,
		  pcs10_resetn,
		  pcs10_slvp_resetn,
		  pcs10_reset_source,
		  T_aopd_por_b,
		  aopd_pclk,
		  aopd_clk_32k,
		  aopd_dbg_tck,
		  aopd_prstn,                // synchronize aopd_por_b with pclk
		  aopd_rtc_rstn,             // was rtc_rstn
		  aopd_por_rstn,             // => jdtm200_tap.por_rstn
		  aopd_por_dbg_rstn,
	`ifdef PLATFORM_DEBUG_SUBSYSTEM
		  dm_clk,
		  dmi_resetn,
		  pldm_bus_resetn,
	`endif // PLATFORM_DEBUG_SUBSYSTEM
	`ifdef PLATFORM_TRACE_SUBSYSTEM
		  ts_clk,
		  ts_reset_n,
	`endif // PLATFORM_TRACE_SUBSYSTEM
		  T_por_b,
		  dbg_srst_req,
		  T_osch,
		  uart_clk,
		  spi_clk,
		  pclk,
		  hclk,
		  aclk,
		  core_clk,
		  l2_clk,
		  hvm_clk,
		  root_clk,
		  T_hw_rstn,
		  wdt_rstn,
		  init_calib_complete,
		  main_rstn,
		  main_rstn_csync,
		  uart_rstn,
		  spi_rstn,
		  presetn,
		  hresetn,
		  aresetn,
	`ifdef AE350_SSP_SUPPORT
		  sspclk,
		  ssp_rstn,
	`endif // AE350_SSP_SUPPORT
	`ifdef AE350_K7DDR3_SUPPORT
		  ui_clk,
		  ddr3_aresetn,
	`endif // AE350_K7DDR3_SUPPORT
	`ifdef AE350_VUDDR4_SUPPORT
		  ui_clk,
		  ddr4_aresetn,
	`endif // AE350_VUDDR4_SUPPORT
	`ifdef PLATFORM_DEBUG_SUBSYSTEM
	   `ifdef NDS_IO_TRACE_INSTR
		  te_reset_n,
	   `endif // NDS_IO_TRACE_INSTR
	`endif // PLATFORM_DEBUG_SUBSYSTEM
		  por_b_psync,
		  por_rstn,
		  l2_resetn,
		  hvm_reset_n,
	`ifdef NDS_FUSA_SUPPORT
	   `ifdef NDS_IO_DCLS
		  dcls_p_clk,
		  dcls_p_reset_n,
		  dcls_r_clk,
		  dcls_r_reset_n,
		  cluster_pwr_on,
	   `endif // NDS_IO_DCLS
	`endif // NDS_FUSA_SUPPORT
		  core_resetn,
		  slvp_resetn,
		  core_l2_resetn,
		  biu_resetn 
	// VPERL_GENERATED_END
);

`ifdef NDS_NHART
	localparam NHART = `NDS_NHART;
`else 
	localparam NHART = 1;
`endif

localparam SYNC_STAGE = `NDS_SYNC_STAGE;

input		test_mode;
input		test_rstn;

//===============
//PCS signals
//===============
input		pcs0_resetn;
output	[4:0]	pcs0_reset_source;
input		pcs1_resetn;
output	[4:0]	pcs1_reset_source;
input		pcs2_resetn;
output	[4:0]	pcs2_reset_source;
input		pcs3_resetn;
input		pcs3_slvp_resetn;
output	[4:0]	pcs3_reset_source;
input		pcs4_resetn;
input		pcs4_slvp_resetn;
output	[4:0]	pcs4_reset_source;
input		pcs5_resetn;
input		pcs5_slvp_resetn;
output	[4:0]	pcs5_reset_source;
input		pcs6_resetn;
input		pcs6_slvp_resetn;
output	[4:0]	pcs6_reset_source;
input		pcs7_resetn;
input		pcs7_slvp_resetn;
output	[4:0]	pcs7_reset_source;
input		pcs8_resetn;
input		pcs8_slvp_resetn;
output	[4:0]	pcs8_reset_source;
input		pcs9_resetn;
input		pcs9_slvp_resetn;
output	[4:0]	pcs9_reset_source;
input		pcs10_resetn;
input		pcs10_slvp_resetn;
output	[4:0]	pcs10_reset_source;

//===============
//PCS0: 
//===============
//from aopd_* (clkgen/pin/testgen)
input		T_aopd_por_b;
input		aopd_pclk;
input		aopd_clk_32k;
input		aopd_dbg_tck;
output		aopd_prstn;		// synchronize aopd_por_b with pclk
output		aopd_rtc_rstn;		// was rtc_rstn
output		aopd_por_rstn; 		// => jdtm200_tap.por_rstn
output		aopd_por_dbg_rstn;

//===============
//PCS1: PLDM
//===============
`ifdef PLATFORM_DEBUG_SUBSYSTEM
input		dm_clk;
input           dmi_resetn;
output		pldm_bus_resetn;
`endif // PLATFORM_DEBUG_SUBSYSTEM

`ifdef PLATFORM_TRACE_SUBSYSTEM
input           ts_clk;
output          ts_reset_n;
`endif


//===============
//PCS2: other IPs
//===============
input		T_por_b;
input		dbg_srst_req;
input		T_osch;
input		uart_clk;
input		spi_clk;
input		pclk;
input		hclk;
input		aclk;
input [(NHART-1):0] core_clk;
input           l2_clk;
input           hvm_clk;
input		root_clk;
input		T_hw_rstn;
input		wdt_rstn;
input           init_calib_complete;

output		main_rstn;
output		main_rstn_csync;
output		uart_rstn;
output		spi_rstn;
output		presetn;
output		hresetn;
output		aresetn;
`ifdef AE350_SSP_SUPPORT
input		sspclk;
output		ssp_rstn;
`endif
`ifdef AE350_K7DDR3_SUPPORT
input		ui_clk;
output		ddr3_aresetn;
`endif
`ifdef AE350_VUDDR4_SUPPORT
input		ui_clk;
output		ddr4_aresetn;
`endif
`ifdef PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
output  [(NHART-1):0]   te_reset_n;
`endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
output		por_b_psync;
output		por_rstn;

output		l2_resetn;
output          hvm_reset_n;

`ifdef NDS_FUSA_SUPPORT
   `ifdef NDS_IO_DCLS
input			dcls_p_clk;
output			dcls_p_reset_n;
input			dcls_r_clk;
output			dcls_r_reset_n;
input			cluster_pwr_on;
   `endif // NDS_IO_DCLS
`endif // NDS_FUSA_SUPPORT

//===============
//PCS3~10: COREs
//===============
output	[(NHART-1):0]	core_resetn;
output	[(NHART-1):0]	slvp_resetn;
output	[(NHART-1):0]	core_l2_resetn;
output                  biu_resetn;

wire		main_rstn_sync2;
wire		main_rstn_csync2;
wire		uart_rstn_sync2;
wire		spi_rstn_sync2;
wire		presetn_sync2;
wire		hresetn_sync2;
wire		aresetn_sync2;
wire		por_b_psync2;
reg		sw_wdt_rstn;
reg	[2:0]	sw_wdt_cnt;
wire	[2:0]	sw_wdt_cnt_sub_one = sw_wdt_cnt - 3'd1;
reg	[3:0]	clock_stable_cnt;
wire	[3:0]	clock_stable_cnt_add_one = clock_stable_cnt + 4'd1;
reg		main_rstn_delay;
wire		por_hw_rstn;
wire		mix_rstn;
wire		por_b_tmux;
wire		hw_rstn_sync2;
wire		hw_rstn_osch;
reg		hw_rstn_delay;
reg	[3:0]	hw_rstn_stable_cnt;
wire	[3:0]	hw_rstn_stable_cnt_add_one = hw_rstn_stable_cnt + 4'd1;
wire		por_rstn;
`ifdef AE350_K7DDR3_SUPPORT
wire		ddr3_aresetn_sync2;
`endif
`ifdef AE350_VUDDR4_SUPPORT
wire		ddr4_aresetn_sync2;
`endif
`ifdef AE350_SSP_SUPPORT
wire		ssp_rstn_sync2;
`endif

wire	no_rstn = 1'b1;
wire	sw_rstn = pcs0_resetn;
wire	hresetn_src;

//===============
//PCS0: 
//===============

sample_ae350_aopd_rstgen sample_ae350_aopd_rstgen (
	.clk_32k         (aopd_clk_32k ), //  <= (sample_ae350_aopd_clkgen)
	.pclk            (aopd_pclk    ), //  <= (sample_ae350_aopd_clkgen)
	.dbg_tck         (aopd_dbg_tck ), //  <= (sample_ae350_aopd_clkgen)
	.T_aopd_por_b    (T_aopd_por_b ), //  <= (ae350_aopd_pin)
	.test_mode       (test_mode    ), //  <= (ae350_aopd_testgen)
	.test_rstn       (test_rstn    ), //  <= (ae350_aopd_testgen)
	.hw_rstn_delay   (hw_rstn_delay), //  <= (hw_reset)
	.dbg_srst_req	 (dbg_srst_req ), //  <= (ae350_aopd_testgen)
	.rtc_rstn        (aopd_rtc_rstn), //  => (rtc)
	.aopd_por_b_tsync(aopd_por_rstn), //  => (ncejdtm200_tap)
	.aopd_por_b_psync(aopd_prstn   ), //  => (power on reset)
	.aopd_por_dbg_b_psync (aopd_por_dbg_rstn) // => (smu)
);


//===============
//PCS1: (PLDM/ncejdtm200)
//===============
//PLDM/ncejdtm200 dmi-reset is generated by ncejdtm200_tap from aopd_por_rstn
//PLDM bus-reset
`ifdef PLATFORM_DEBUG_SUBSYSTEM
wire		pldm_bus_rstn_sync2;
assign		pldm_bus_resetn = pldm_bus_rstn_sync2;
wire		nds_unused_pldm_bus_casc_rstn_out;
rst_sync pldm_bus_rstn_sync(.rstn_out(pldm_bus_rstn_sync2), .clk(dm_clk), .rstn_in(pcs1_resetn),
				.casc_rstn_out(nds_unused_pldm_bus_casc_rstn_out), .casc_rstn_in(hresetn_src), .test_mode(test_mode), .test_rstn(test_rstn));
`endif // PLATFORM_DEBUG_SUBSYSTEM

`ifdef PLATFORM_TRACE_SUBSYSTEM
rst_sync #(.HAS_CASC_RSTN(1)) ts_rstn_sync(.rstn_out(ts_reset_n), .clk(ts_clk), .rstn_in(pcs1_resetn),
                                .casc_rstn_out(), .casc_rstn_in(hresetn_src), .test_mode(test_mode), .test_rstn(test_rstn));
`endif // PLATFORM_TRACE_SUBSYSTEM



//===============
//PCS2: other IPs (original MPD)
//===============
assign	por_rstn = por_b_tmux;

assign	por_hw_rstn	= por_b_tmux & aopd_rtc_rstn;
assign	por_b_tmux	= test_mode ? test_rstn : T_por_b;
assign	main_rstn_csync	= main_rstn_csync2;
assign	spi_rstn	= spi_rstn_sync2;
assign	por_b_psync	= por_b_psync2;

// [The following comment is deduced by Simon and Frank Yang]
// Originally init_calib_complete was used by por_hw_rstn in AE250. This should
// be because, before the DDR3 controller finishes calibration, no access
// should be made to it. However, in AE350, init_calib_complete is moved to
// feed mix_rstn instead to reset all blocks so that no traffic can be issued
// even when the clocks are running. The originally approach can't work for
// the ASIC gate-level synthesis since main_rstn can't affect clocks. As
// a result, now AE250 and AE350 use the same new approach.
assign	mix_rstn	= main_rstn_delay & hw_rstn_delay & ~dbg_srst_req & sw_wdt_rstn & init_calib_complete;
`ifdef AE350_K7DDR3_SUPPORT
assign  ddr3_aresetn    = test_mode ? test_rstn : ddr3_aresetn_sync2;
`endif
`ifdef AE350_VUDDR4_SUPPORT
assign  ddr4_aresetn    = test_mode ? test_rstn : ddr4_aresetn_sync2;
`endif
`ifdef AE350_SSP_SUPPORT
assign  ssp_rstn        = test_mode ? test_rstn : ssp_rstn_sync2;
`endif

// To avoid HAL RSTOUT warnings, don't directly use output signals.
wire	main_rstn_src	= test_mode ? test_rstn : main_rstn_sync2;
wire	uart_rstn_src	= test_mode ? test_rstn : uart_rstn_sync2;
wire	presetn_src	= test_mode ? test_rstn : presetn_sync2;
assign	hresetn_src	= test_mode ? test_rstn : hresetn_sync2;
wire	aresetn_src	= test_mode ? test_rstn : aresetn_sync2;

assign	main_rstn = main_rstn_src;
assign	uart_rstn = uart_rstn_src;
assign	presetn = presetn_src;
assign	hresetn = hresetn_src;
assign	aresetn = aresetn_src;

//---------------------------------------------------//
// Generate main_rstn and main_rstn_csync
//---------------------------------------------------//
wire		nds_unused_main_rstn_casc_rstn_out;
rst_sync rst_main_rstn_sync(.rstn_out(main_rstn_sync2), .clk(T_osch), .rstn_in(no_rstn),
				.casc_rstn_out(nds_unused_main_rstn_casc_rstn_out), .casc_rstn_in(por_hw_rstn), .test_mode(test_mode), .test_rstn(test_rstn));

wire		nds_unused_main_rstn_casc_rstn_out2;
rst_sync rst_main_rstn_csync(.rstn_out(main_rstn_csync2), .clk(root_clk), .rstn_in(no_rstn),
				.casc_rstn_out(nds_unused_main_rstn_casc_rstn_out2), .casc_rstn_in(main_rstn_src), .test_mode(test_mode), .test_rstn(test_rstn));

always @(posedge T_osch or negedge main_rstn_src) begin
	if (!main_rstn_src) begin
		clock_stable_cnt <= 4'h0;
	end
	else if (clock_stable_cnt != 4'hf) begin
		clock_stable_cnt <= clock_stable_cnt_add_one;
	end
end

always @(posedge T_osch or negedge main_rstn_src) begin
	if (!main_rstn_src) begin
		main_rstn_delay	<= 1'b0;
	end
	else begin
		main_rstn_delay <= (clock_stable_cnt == 4'hf);
	end
end

// SRST handling
wire		nds_unused_hw_rstn_casc_rstn_out;
rst_sync rst_hw_rstn_sync(.rstn_out(hw_rstn_sync2), .clk(T_osch), .rstn_in(no_rstn),
				.casc_rstn_out(nds_unused_hw_rstn_casc_rstn_out), .casc_rstn_in(T_hw_rstn), .test_mode(1'b0), .test_rstn(test_rstn));
assign	hw_rstn_osch = hw_rstn_sync2;

always @(posedge T_osch or negedge hw_rstn_osch) begin
	if (!hw_rstn_osch) begin
		hw_rstn_stable_cnt <= 4'h0;
	end
	else if (hw_rstn_stable_cnt != 4'hf) begin
		hw_rstn_stable_cnt <= hw_rstn_stable_cnt_add_one;
	end
end

always @(posedge T_osch or negedge hw_rstn_osch) begin
	if (!hw_rstn_osch) begin
		hw_rstn_delay <= 1'b0;
	end
	else begin
		hw_rstn_delay <= (hw_rstn_stable_cnt == 4'hf);
	end
end

//---------------------------------------------------//
// Generate por_b_psync
//---------------------------------------------------//
wire		nds_unused_por_b_casc_rstn_out;
rst_sync rst_por_b_psync(.rstn_out(por_b_psync2), .clk(pclk), .rstn_in(no_rstn),
				.casc_rstn_out(nds_unused_por_b_casc_rstn_out), .casc_rstn_in(por_b_tmux), .test_mode(test_mode), .test_rstn(test_rstn));

//---------------------------------------------------//
// Generate presetn, hresetn, and core_rstn
//---------------------------------------------------//
// Assert a reset pulse by 8 PCLK cycles
always @(posedge pclk or negedge main_rstn_csync2) begin
	if (!main_rstn_csync2)
		sw_wdt_rstn	<= 1'b1;
	else if (!sw_rstn | !wdt_rstn)
		sw_wdt_rstn	<= 1'b0;
	else if (sw_wdt_cnt == 3'h0)
		sw_wdt_rstn	<= 1'b1;
end

always @(posedge pclk or negedge main_rstn_csync2) begin
	if (!main_rstn_csync2)
		sw_wdt_cnt	<= 3'h0;
	else if (!sw_rstn | !wdt_rstn)
		sw_wdt_cnt	<= 3'h7;
	else if (|sw_wdt_cnt)
		sw_wdt_cnt	<= sw_wdt_cnt_sub_one;
end

wire	casc_rstn_presetn;
wire	casc_rstn_uart_rstn;
wire	casc_rstn_hresetn;
wire	casc_rstn_aresetn;

// Sync to individual clock domains
rst_sync rst_uart_rstn_sync(.rstn_out(uart_rstn_sync2), .clk(uart_clk), .rstn_in(pcs2_resetn),
				.casc_rstn_out(casc_rstn_uart_rstn), .casc_rstn_in(mix_rstn), .test_mode(test_mode), .test_rstn(test_rstn));

wire		nds_unused_spi_rstn_casc_rstn_out;
rst_sync rst_spi_rstn_sync(.rstn_out(spi_rstn_sync2), .clk(spi_clk), .rstn_in(pcs2_resetn),
				.casc_rstn_out(nds_unused_spi_rstn_casc_rstn_out), .casc_rstn_in(mix_rstn), .test_mode(test_mode), .test_rstn(test_rstn));

// pclk and uart_clk are actually synchronous. However, in the timing
// constraints, we treat them asynchronous so double syncing is used here.
rst_sync rst_presetn_sync(.rstn_out(presetn_sync2), .clk(pclk), .rstn_in(uart_rstn_sync2),
				.casc_rstn_out(casc_rstn_presetn), .casc_rstn_in(casc_rstn_uart_rstn), .test_mode(test_mode), .test_rstn(test_rstn));

rst_sync rst_hresetn_sync(.rstn_out(hresetn_sync2), .clk(hclk), .rstn_in(presetn_sync2),
				.casc_rstn_out(casc_rstn_hresetn), .casc_rstn_in(casc_rstn_presetn), .test_mode(test_mode), .test_rstn(test_rstn));

rst_sync rst_aresetn_sync(.rstn_out(aresetn_sync2), .clk(aclk), .rstn_in(hresetn_sync2),
				.casc_rstn_out(casc_rstn_aresetn), .casc_rstn_in(casc_rstn_hresetn), .test_mode(test_mode), .test_rstn(test_rstn));

`ifdef AE350_K7DDR3_SUPPORT
wire		nds_unused_ddr3_aresetn_casc_rstn_out;
rst_sync rst_ddr3_aresetn_sync(.rstn_out(ddr3_aresetn_sync2), .clk(ui_clk), .rstn_in(no_rstn),
				.casc_rstn_out(nds_unused_ddr3_aresetn_casc_rstn_out), .casc_rstn_in(mix_rstn), .test_mode(test_mode), .test_rstn(test_rstn));
`endif
`ifdef AE350_VUDDR4_SUPPORT
wire		nds_unused_ddr4_aresetn_casc_rstn_out;
rst_sync rst_ddr4_aresetn_sync(.rstn_out(ddr4_aresetn_sync2), .clk(ui_clk), .rstn_in(no_rstn),
				.casc_rstn_out(nds_unused_ddr4_aresetn_casc_rstn_out), .casc_rstn_in(mix_rstn), .test_mode(test_mode), .test_rstn(test_rstn));
`endif

`ifdef AE350_SSP_SUPPORT
wire		nds_unused_ssp_rstn_casc_rstn_out;
rst_sync rst_ssp_rstn_sync(.rstn_out(ssp_rstn_sync2), .clk(sspclk), .rstn_in(no_rstn),
				.casc_rstn_out(nds_unused_ssp_rstn_casc_rstn_out), .casc_rstn_in(mix_rstn), .test_mode(test_mode), .test_rstn(test_rstn));
`endif

//===============
//PCS3~10: COREs
//===============
wire	[7:0] pcs_core_resetn = {pcs10_resetn,pcs9_resetn, pcs8_resetn, pcs7_resetn,
                                 pcs6_resetn, pcs5_resetn, pcs4_resetn, pcs3_resetn};
wire	[7:0] pcs_slvp_resetn = {pcs10_slvp_resetn&hresetn_sync2,pcs9_slvp_resetn&hresetn_sync2, pcs8_slvp_resetn&hresetn_sync2, pcs7_slvp_resetn&hresetn_sync2,
                                 pcs6_slvp_resetn&hresetn_sync2, pcs5_slvp_resetn&hresetn_sync2, pcs4_slvp_resetn&hresetn_sync2, pcs3_slvp_resetn&hresetn_sync2};
wire	[(NHART-1):0] core_resetn_sync2;
wire	[(NHART-1):0] slvp_resetn_sync2;
wire	[(NHART-1):0] core_l2_resetn_sync2;
genvar i_rst;
generate
for (i_rst = 0; i_rst < NHART; i_rst = i_rst + 1) begin: gen_core_reset
	wire		nds_unused_core_resetn_casc_rstn_out;
	rst_sync rst_core_resetn_sync(.rstn_out(core_resetn_sync2[i_rst]), .clk(core_clk[i_rst]), .rstn_in(pcs_core_resetn[i_rst]),
				.casc_rstn_out(nds_unused_core_resetn_casc_rstn_out), .casc_rstn_in(l2_resetn), .test_mode(test_mode), .test_rstn(test_rstn));
	assign core_resetn[i_rst] = core_resetn_sync2[i_rst];
	wire		nds_unused_slvp_resetn_casc_rstn_out;
	rst_sync rst_slvp_resetn_sync(.rstn_out(slvp_resetn_sync2[i_rst]), .clk(aclk), .rstn_in(pcs_slvp_resetn[i_rst]),
				.casc_rstn_out(nds_unused_slvp_resetn_casc_rstn_out), .casc_rstn_in(casc_rstn_hresetn), .test_mode(test_mode), .test_rstn(test_rstn));
	assign slvp_resetn[i_rst] = slvp_resetn_sync2[i_rst];
	wire		nds_unused_core_l2_resetn_casc_rstn_out;
	rst_sync rst_core_l2_resetn_sync(.rstn_out(core_l2_resetn_sync2[i_rst]), .clk(l2_clk), .rstn_in(core_resetn_sync2[i_rst]),
				.casc_rstn_out(nds_unused_core_l2_resetn_casc_rstn_out), .casc_rstn_in(1'b1), .test_mode(test_mode), .test_rstn(test_rstn));
	assign core_l2_resetn[i_rst] = core_l2_resetn_sync2[i_rst];

`ifdef PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
	wire nds_unused_rst_te_resetn_sync_casc_rstn_out;
        rst_sync #(.HAS_CASC_RSTN(1)) rst_te_resetn_sync(.rstn_out(te_reset_n[i_rst]), .clk(core_clk[i_rst]), .rstn_in(no_rstn),
	                                .casc_rstn_out(nds_unused_rst_te_resetn_sync_casc_rstn_out), .casc_rstn_in(dmi_resetn), .test_mode(test_mode), .test_rstn(test_rstn));
`endif // PLATFORM_DEBUG_SUBSYSTEM
`endif // NDS_IO_TRACE_INSTR

end
endgenerate

`ifdef NDS_FUSA_SUPPORT
   `ifdef NDS_IO_DCLS
wire	nds_unused_dcls_p_reset_n_casc_rstn_out;
wire	nds_unused_dcls_r_reset_n_casc_rstn_out;
wire	dcls_p_resetn_sync_rstn_in = aresetn_sync2 & cluster_pwr_on;
wire	dcls_r_resetn_sync_rstn_in = aresetn_sync2 & cluster_pwr_on;

rst_sync dcls_p_resetn_sync(.rstn_out(dcls_p_reset_n), .clk(dcls_p_clk), .rstn_in(dcls_p_resetn_sync_rstn_in),
	.casc_rstn_out(nds_unused_dcls_p_reset_n_casc_rstn_out), .casc_rstn_in(casc_rstn_aresetn), .test_mode(test_mode), .test_rstn(test_rstn));
rst_sync dcls_r_resetn_sync(.rstn_out(dcls_r_reset_n), .clk(dcls_r_clk), .rstn_in(dcls_r_resetn_sync_rstn_in),
	.casc_rstn_out(nds_unused_dcls_r_reset_n_casc_rstn_out), .casc_rstn_in(casc_rstn_aresetn), .test_mode(test_mode), .test_rstn(test_rstn));
   `endif // NDS_IO_DCLS
`endif // NDS_FUSA_SUPPORT

assign biu_resetn = core_resetn[0];


wire		l2_rstn = |pcs_core_resetn[(NHART-1):0];
wire		l2_rstn_sync2;
wire		nds_unused_l2_rstn_casc_rstn_out;
rst_sync rst_l2_rstn_sync(.rstn_out(l2_rstn_sync2), .clk(l2_clk), .rstn_in(l2_rstn),
				.casc_rstn_out(nds_unused_l2_rstn_casc_rstn_out), .casc_rstn_in(casc_rstn_aresetn), .test_mode(test_mode), .test_rstn(test_rstn));
assign	l2_resetn = l2_rstn_sync2;

wire		hvm_rstn = |pcs_core_resetn[(NHART-1):0];
wire		hvm_rstn_sync2;
wire		nds_unused_hvm_rstn_casc_rstn_out;
rst_sync rst_hvm_rstn_sync(.rstn_out(hvm_rstn_sync2), .clk(hvm_clk), .rstn_in(hvm_rstn),
				.casc_rstn_out(nds_unused_hvm_rstn_casc_rstn_out), .casc_rstn_in(casc_rstn_aresetn), .test_mode(test_mode), .test_rstn(test_rstn));
assign	hvm_reset_n = hvm_rstn_sync2;


wire T_hw_rstn_pclk;
wire nds_unused_hw_rstn_rpulse;
wire nds_unused_hw_rstn_fpulse;
wire nds_unused_hw_rstn_edge;

nds_sync_l2l #(
	.RESET_VALUE	(1'b1),
	.SYNC_STAGE	(SYNC_STAGE)
) T_hw_rstn_sync (
	.b_reset_n			(aopd_prstn),
	.b_clk				(aopd_pclk),
	.a_signal			(T_hw_rstn),
	.b_signal			(T_hw_rstn_pclk),
	.b_signal_rising_edge_pulse	(nds_unused_hw_rstn_rpulse),
	.b_signal_falling_edge_pulse	(nds_unused_hw_rstn_fpulse),
	.b_signal_edge_pulse		(nds_unused_hw_rstn_edge)
);

// pclk domain signal
//por		aopd_prstn
//pcs reset	
//wd		wdt_rstn			
//hw		T_hw_rstn_pclk				
//mpd por	por_b_psync	(X_por_b)
assign pcs0_reset_source = ~{por_b_psync,T_hw_rstn_pclk,wdt_rstn,pcs0_resetn            ,aopd_prstn};
assign pcs1_reset_source = ~{por_b_psync,T_hw_rstn_pclk,wdt_rstn,pcs1_resetn|pcs0_resetn,aopd_prstn};
assign pcs2_reset_source = ~{por_b_psync,T_hw_rstn_pclk,wdt_rstn,pcs2_resetn|pcs0_resetn,aopd_prstn};
assign pcs3_reset_source = ~{por_b_psync,T_hw_rstn_pclk,wdt_rstn,pcs3_resetn|pcs0_resetn,aopd_prstn};
assign pcs4_reset_source = ~{por_b_psync,T_hw_rstn_pclk,wdt_rstn,pcs4_resetn|pcs0_resetn,aopd_prstn};
assign pcs5_reset_source = ~{por_b_psync,T_hw_rstn_pclk,wdt_rstn,pcs5_resetn|pcs0_resetn,aopd_prstn};
assign pcs6_reset_source = ~{por_b_psync,T_hw_rstn_pclk,wdt_rstn,pcs6_resetn|pcs0_resetn,aopd_prstn};
assign pcs7_reset_source = ~{por_b_psync,T_hw_rstn_pclk,wdt_rstn,pcs7_resetn|pcs0_resetn,aopd_prstn};
assign pcs8_reset_source = ~{por_b_psync,T_hw_rstn_pclk,wdt_rstn,pcs8_resetn|pcs0_resetn,aopd_prstn};
assign pcs9_reset_source = ~{por_b_psync,T_hw_rstn_pclk,wdt_rstn,pcs9_resetn|pcs0_resetn,aopd_prstn};
assign pcs10_reset_source = ~{por_b_psync,T_hw_rstn_pclk,wdt_rstn,pcs10_resetn|pcs0_resetn,aopd_prstn};


endmodule
