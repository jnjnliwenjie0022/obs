`include "config.inc"
`include "ae350_config.vh"

module ae350_rstgen (
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
		  pcs3_reset_source,
		  pcs4_resetn,
		  pcs4_reset_source,
		  pcs5_resetn,
		  pcs5_reset_source,
		  pcs6_resetn,
		  pcs6_reset_source,
		  T_aopd_por_b,
		  aopd_pclk,
		  aopd_clk_32k,
		  aopd_dbg_tck,
		  aopd_prstn,            // synchronize aopd_por_b with pclk
		  aopd_rtc_rstn,         // was rtc_rstn
		  aopd_por_rstn,         // => jdtm200_tap.por_rstn
		  aopd_por_dbg_rstn,
	`ifdef PLATFORM_DEBUG_SUBSYSTEM
		  dm_clk,
		  dmi_resetn,
		  pldm_bus_resetn,
	   `ifdef NDS_IO_TRACE_INSTR
		  ts_clk,
		  ts_reset_n,
	   `endif // NDS_IO_TRACE_INSTR
	`endif // PLATFORM_DEBUG_SUBSYSTEM
		  T_por_b,
		  dbg_srst_req,
		  T_osch,
		  uart_clk,
		  spi_clk,
		  pclk,
		  hclk,
		  aclk,
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
		  por_b_psync,
		  por_rstn,
	`ifdef PLATFORM_DEBUG_SUBSYSTEM
	   `ifdef NDS_IO_TRACE_INSTR
		  te_reset_n,
	   `endif // NDS_IO_TRACE_INSTR
	`endif // PLATFORM_DEBUG_SUBSYSTEM
		  core_clk,
		  core_resetn 
	// VPERL_GENERATED_END
);

`ifdef NDS_NHART
	localparam NHART = `NDS_NHART;
`else 
	localparam NHART = 1;
`endif

parameter SYNC_STAGE = 2;

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
output	[4:0]	pcs3_reset_source;
input		pcs4_resetn;
output	[4:0]	pcs4_reset_source;
input		pcs5_resetn;
output	[4:0]	pcs5_reset_source;
input		pcs6_resetn;
output	[4:0]	pcs6_reset_source;

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
`ifdef NDS_IO_TRACE_INSTR
input		ts_clk;
output		ts_reset_n;
`endif
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
output		por_b_psync;
output		por_rstn;

//===============
//PCS3~6: COREs
//===============
//`ifdef NDS_IO_HART1
//input		core1_clk;
//output		core1_resetn;
//`endif // NDS_IO_HART1
//`ifdef NDS_IO_HART2
//input		core2_clk;
//output		core2_resetn;
//`endif // NDS_IO_HART2
//`ifdef NDS_IO_HART3
//input		core3_clk;
//output		core3_resetn;
//`endif // NDS_IO_HART3
`ifdef PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
output  [(NHART-1):0]   te_reset_n;
`endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
input   [(NHART-1):0]   core_clk;
output	[(NHART-1):0]	core_resetn;


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

ae350_aopd_rstgen ae350_aopd_rstgen (
	.clk_32k         (aopd_clk_32k ), //  <= (ae350_aopd_clkgen)
	.pclk            (aopd_pclk    ), //  <= (ae350_aopd_clkgen)
	.dbg_tck         (aopd_dbg_tck ), //  <= (ae350_aopd_clkgen)
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
rst_sync #(.HAS_CASC_RSTN(1)) pldm_bus_rstn_sync(.rstn_out(pldm_bus_rstn_sync2), .clk(dm_clk), .rstn_in(pcs1_resetn),
				.casc_rstn_out(), .casc_rstn_in(hresetn_src), .test_mode(test_mode), .test_rstn(test_rstn));

`ifdef NDS_IO_TRACE_INSTR
rst_sync #(.HAS_CASC_RSTN(1)) ts_rstn_sync(.rstn_out(ts_reset_n), .clk(ts_clk), .rstn_in(pcs1_resetn),
				.casc_rstn_out(), .casc_rstn_in(hresetn_src), .test_mode(test_mode), .test_rstn(test_rstn));
`endif
`endif // PLATFORM_DEBUG_SUBSYSTEM

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
rst_sync #(.HAS_CASC_RSTN(1)) rst_main_rstn_sync(.rstn_out(main_rstn_sync2), .clk(T_osch), .rstn_in(no_rstn),
				.casc_rstn_out(), .casc_rstn_in(por_hw_rstn), .test_mode(test_mode), .test_rstn(test_rstn));

rst_sync #(.HAS_CASC_RSTN(1)) rst_main_rstn_csync(.rstn_out(main_rstn_csync2), .clk(root_clk), .rstn_in(no_rstn),
				.casc_rstn_out(), .casc_rstn_in(main_rstn_src), .test_mode(test_mode), .test_rstn(test_rstn));

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
rst_sync #(.HAS_CASC_RSTN(1)) rst_hw_rstn_sync(.rstn_out(hw_rstn_sync2), .clk(T_osch), .rstn_in(por_rstn),
				.casc_rstn_out(), .casc_rstn_in(T_hw_rstn), .test_mode(1'b0), .test_rstn(test_rstn));
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
rst_sync #(.HAS_CASC_RSTN(1)) rst_por_b_psync(.rstn_out(por_b_psync2), .clk(pclk), .rstn_in(no_rstn),
				.casc_rstn_out(), .casc_rstn_in(por_b_tmux), .test_mode(test_mode), .test_rstn(test_rstn));

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
rst_sync #(.HAS_CASC_RSTN(1)) rst_uart_rstn_sync(.rstn_out(uart_rstn_sync2), .clk(uart_clk), .rstn_in(pcs2_resetn),
				.casc_rstn_out(casc_rstn_uart_rstn), .casc_rstn_in(mix_rstn), .test_mode(test_mode), .test_rstn(test_rstn));

rst_sync #(.HAS_CASC_RSTN(1)) rst_spi_rstn_sync(.rstn_out(spi_rstn_sync2), .clk(spi_clk), .rstn_in(pcs2_resetn),
				.casc_rstn_out(), .casc_rstn_in(mix_rstn), .test_mode(test_mode), .test_rstn(test_rstn));

// pclk and uart_clk are actually synchronous. However, in the timing
// constraints, we treat them asynchronous so double syncing is used here.
rst_sync #(.HAS_CASC_RSTN(1)) rst_presetn_sync(.rstn_out(presetn_sync2), .clk(pclk), .rstn_in(uart_rstn_sync2),
				.casc_rstn_out(casc_rstn_presetn), .casc_rstn_in(casc_rstn_uart_rstn), .test_mode(test_mode), .test_rstn(test_rstn));

rst_sync #(.HAS_CASC_RSTN(1)) rst_hresetn_sync(.rstn_out(hresetn_sync2), .clk(hclk), .rstn_in(presetn_sync2),
				.casc_rstn_out(casc_rstn_hresetn), .casc_rstn_in(casc_rstn_presetn), .test_mode(test_mode), .test_rstn(test_rstn));

rst_sync #(.HAS_CASC_RSTN(1)) rst_aresetn_sync(.rstn_out(aresetn_sync2), .clk(aclk), .rstn_in(hresetn_sync2),
				.casc_rstn_out(casc_rstn_aresetn), .casc_rstn_in(casc_rstn_hresetn), .test_mode(test_mode), .test_rstn(test_rstn));

`ifdef AE350_K7DDR3_SUPPORT
rst_sync #(.HAS_CASC_RSTN(1)) rst_ddr3_aresetn_sync(.rstn_out(ddr3_aresetn_sync2), .clk(ui_clk), .rstn_in(no_rstn),
				.casc_rstn_out(), .casc_rstn_in(mix_rstn), .test_mode(test_mode), .test_rstn(test_rstn));
`endif
`ifdef AE350_VUDDR4_SUPPORT
rst_sync #(.HAS_CASC_RSTN(1)) rst_ddr4_aresetn_sync(.rstn_out(ddr4_aresetn_sync2), .clk(ui_clk), .rstn_in(no_rstn),
				.casc_rstn_out(), .casc_rstn_in(mix_rstn), .test_mode(test_mode), .test_rstn(test_rstn));
`endif

`ifdef AE350_SSP_SUPPORT
rst_sync #(.HAS_CASC_RSTN(1)) rst_ssp_rstn_sync(.rstn_out(ssp_rstn_sync2), .clk(sspclk), .rstn_in(no_rstn),
				.casc_rstn_out(), .casc_rstn_in(mix_rstn), .test_mode(test_mode), .test_rstn(test_rstn));
`endif

//===============
//PCS3~6: COREs
//===============
wire	[3:0] pcs_core_resetn = {pcs6_resetn, pcs5_resetn, pcs4_resetn, pcs3_resetn};
wire	[(NHART-1):0] core_resetn_sync2;
generate
genvar i_rst;
for (i_rst = 0; i_rst < NHART; i_rst = i_rst + 1) begin: gen_core_reset
	rst_sync #(.HAS_CASC_RSTN(1)) rst_core_resetn_sync(.rstn_out(core_resetn_sync2[i_rst]), .clk(core_clk[i_rst]), .rstn_in(pcs_core_resetn[i_rst]),
				.casc_rstn_out(), .casc_rstn_in(casc_rstn_aresetn), .test_mode(test_mode), .test_rstn(test_rstn));
	assign core_resetn[i_rst] = core_resetn_sync2[i_rst];

`ifdef PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
        rst_sync #(.HAS_CASC_RSTN(1)) rst_te_resetn_sync(.rstn_out(te_reset_n[i_rst]), .clk(core_clk[i_rst]), .rstn_in(no_rstn),
                                .casc_rstn_out(), .casc_rstn_in(dmi_resetn), .test_mode(test_mode), .test_rstn(test_rstn));
`endif // PLATFORM_DEBUG_SUBSYSTEM
`endif // NDS_IO_TRACE_INSTR
end
endgenerate

wire T_hw_rstn_pclk;
nds_sync_l2l #(
	.RESET_VALUE	(1'b1),
	.SYNC_STAGE	(SYNC_STAGE)
) T_hw_rstn_sync (
	.b_reset_n			(aopd_prstn),
	.b_clk				(aopd_pclk),
	.a_signal			(T_hw_rstn),
	.b_signal			(T_hw_rstn_pclk),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
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


endmodule
