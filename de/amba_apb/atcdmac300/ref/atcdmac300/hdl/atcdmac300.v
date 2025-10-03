`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

//VPERL_BEGIN
// &MODULE("atcdmac300");
// &LOCALPARAM("ADDR_MSB	= `ATCDMAC300_ADDR_WIDTH - 1");
// &LOCALPARAM("ADDR_WEN_MSB	= ADDR_MSB > 31 ? 1 : 0");
//		&FORCE("input","m0_rdata[(`DMA_DATA_WIDTH-1):0]");
//		&FORCE("output","m0_wdata[(`DMA_DATA_WIDTH-1):0]");
//		&FORCE("output","m0_wstrb[(`DMA_WSTRB_WIDTH-1):0]");
//
// &IFDEF("ATCDMAC300_DUAL_MASTER_IF_SUPPORT");
//	 	&FORCE("input","m1_rdata[(`DMA_DATA_WIDTH-1):0]");
// 		&FORCE("output","m1_wdata[(`DMA_DATA_WIDTH-1):0]");
// 		&FORCE("output","m1_wstrb[(`DMA_WSTRB_WIDTH-1):0]");
// &ENDIF("ATCDMAC300_DUAL_MASTER_IF_SUPPORT");
//
// &INSTANCE("atcdmac300_apbslv.v", "atcdmac300_apbslv");
// &INSTANCE("atcdmac300_arbiter.v", "atcdmac300_arbiter");
// &INSTANCE("atcdmac300_register.v", "atcdmac300_register");
// &INSTANCE("atcdmac300_chmux.v", "atcdmac300_chmux");
// &INSTANCE("atcdmac300_aximst.v", "atcdmac300_aximst_0");
// &CONNECT("atcdmac300_aximst_0", {
//# axi bus interface
//	awid			=> "m0_awid",
//	awaddr			=> "m0_awaddr",
//	awlen			=> "m0_awlen",
//	awsize			=> "m0_awsize",
//	awburst			=> "m0_awburst",
//	awlock			=> "m0_awlock",
//	awcache			=> "m0_awcache",
//	awprot			=> "m0_awprot",
//	awvalid			=> "m0_awvalid",
//	awready			=> "m0_awready",
//	wstrb			=> "m0_wstrb",
//	wlast			=> "m0_wlast",
//	wdata			=> "m0_wdata",
//	wvalid			=> "m0_wvalid",
//	wready			=> "m0_wready",
//	bid			=> "m0_bid",
//	bresp			=> "m0_bresp",
//	bvalid			=> "m0_bvalid",
//	bready			=> "m0_bready",
//	arid			=> "m0_arid",
//	araddr			=> "m0_araddr",
//	arlen			=> "m0_arlen",
//	arsize			=> "m0_arsize",
//	arburst			=> "m0_arburst",
//	arlock			=> "m0_arlock",
//	arcache			=> "m0_arcache",
//	arprot			=> "m0_arprot",
//	arvalid			=> "m0_arvalid",
//	arready			=> "m0_arready",
//	rid			=> "m0_rid",
//	rresp			=> "m0_rresp",
//	rlast			=> "m0_rlast",
//	rdata			=> "m0_rdata",
//	rvalid			=> "m0_rvalid",
//	rready			=> "m0_rready",
//# dma engine interface 
//	dma0_mst_req		=> "dma0_mst0_req",
//	dma0_mst_addr		=> "dma0_mst0_addr",
//	dma0_mst_write		=> "dma0_mst0_write",
//	dma0_mst_size		=> "dma0_mst0_size",
//	dma0_mst_fix		=> "dma0_mst0_fix",
//	dma0_mst_wdata		=> "dma0_mst0_wdata",
//	dma0_mst_len		=> "dma0_mst0_len",
//	mst_dma0_grant		=> "mst0_dma0_grant",
//	mst_dma0_rd_ack		=> "mst0_dma0_rd_ack",
//	mst_dma0_wr_ack		=> "mst0_dma0_wr_ack",
//	mst_dma0_rdata		=> "mst0_dma0_rdata",
//	mst_dma0_rlast		=> "mst0_dma0_rlast",
//	mst_dma0_bvalid		=> "mst0_dma0_bvalid",
//	mst_dma0_error		=> "mst0_dma0_error",
//	dma1_mst_req		=> "dma1_mst0_req",
//	dma1_mst_addr		=> "dma1_mst0_addr",
//	dma1_mst_write		=> "dma1_mst0_write",
//	dma1_mst_size		=> "dma1_mst0_size",
//	dma1_mst_fix		=> "dma1_mst0_fix",
//	dma1_mst_wdata		=> "dma1_mst0_wdata",
//	dma1_mst_len		=> "dma1_mst0_len",
//	mst_dma1_grant		=> "mst0_dma1_grant",
//	mst_dma1_rd_ack		=> "mst0_dma1_rd_ack",
//	mst_dma1_wr_ack		=> "mst0_dma1_wr_ack",
//	mst_dma1_rdata		=> "mst0_dma1_rdata",
//	mst_dma1_rlast		=> "mst0_dma1_rlast",
//	mst_dma1_bvalid		=> "mst0_dma1_bvalid",
//	mst_dma1_error		=> "mst0_dma1_error",
// });
//
// &IFDEF("ATCDMAC300_DUAL_MASTER_IF_SUPPORT");
// 	&INSTANCE("atcdmac300_aximst.v", "atcdmac300_aximst_1");
// 	&CONNECT("atcdmac300_aximst_1", {
//# axi bus interface
//		awid			=> "m1_awid",
//		awaddr			=> "m1_awaddr",
//		awlen			=> "m1_awlen",
//		awsize			=> "m1_awsize",
//		awburst			=> "m1_awburst",
//		awlock			=> "m1_awlock",
//		awcache			=> "m1_awcache",
//		awprot			=> "m1_awprot",
//		awvalid			=> "m1_awvalid",
//		awready			=> "m1_awready",
//		wstrb			=> "m1_wstrb",
//		wlast			=> "m1_wlast",
//		wdata			=> "m1_wdata",
//		wvalid			=> "m1_wvalid",
//		wready			=> "m1_wready",
//		bid			=> "m1_bid",
//		bresp			=> "m1_bresp",
//		bvalid			=> "m1_bvalid",
//		bready			=> "m1_bready",
//		arid			=> "m1_arid",
//		araddr			=> "m1_araddr",
//		arlen			=> "m1_arlen",
//		arsize			=> "m1_arsize",
//		arburst			=> "m1_arburst",
//		arlock			=> "m1_arlock",
//		arcache			=> "m1_arcache",
//		arprot			=> "m1_arprot",
//		arvalid			=> "m1_arvalid",
//		arready			=> "m1_arready",
//		rid			=> "m1_rid",
//		rresp			=> "m1_rresp",
//		rlast			=> "m1_rlast",
//		rdata			=> "m1_rdata",
//		rvalid			=> "m1_rvalid",
//		rready			=> "m1_rready",
//# dma engine interface 
//		dma0_mst_req		=> "dma0_mst1_req",
//		dma0_mst_addr		=> "dma0_mst1_addr",
//		dma0_mst_write		=> "dma0_mst1_write",
//		dma0_mst_size		=> "dma0_mst1_size",
//		dma0_mst_fix		=> "dma0_mst1_fix",
//		dma0_mst_wdata		=> "dma0_mst1_wdata",
//		dma0_mst_len		=> "dma0_mst1_len",
//		mst_dma0_grant		=> "mst1_dma0_grant",
//		mst_dma0_rd_ack		=> "mst1_dma0_rd_ack",
//		mst_dma0_wr_ack		=> "mst1_dma0_wr_ack",
//		mst_dma0_rdata		=> "mst1_dma0_rdata",
//		mst_dma0_rlast		=> "mst1_dma0_rlast",
//		mst_dma0_bvalid		=> "mst1_dma0_bvalid",
//		mst_dma0_error		=> "mst1_dma0_error",
//		dma1_mst_req		=> "dma1_mst1_req",
//		dma1_mst_addr		=> "dma1_mst1_addr",
//		dma1_mst_write		=> "dma1_mst1_write",
//		dma1_mst_size		=> "dma1_mst1_size",
//		dma1_mst_fix		=> "dma1_mst1_fix",
//		dma1_mst_wdata		=> "dma1_mst1_wdata",
//		dma1_mst_len		=> "dma1_mst1_len",
//		mst_dma1_grant		=> "mst1_dma1_grant",
//		mst_dma1_rd_ack		=> "mst1_dma1_rd_ack",
//		mst_dma1_wr_ack		=> "mst1_dma1_wr_ack",
//		mst_dma1_rdata		=> "mst1_dma1_rdata",
//		mst_dma1_rlast		=> "mst1_dma1_rlast",
//		mst_dma1_bvalid		=> "mst1_dma1_bvalid",
//		mst_dma1_error		=> "mst1_dma1_error",
// 	});
// &ENDIF("ATCDMAC300_DUAL_MASTER_IF_SUPPORT");
//
// &INSTANCE("atcdmac300_engine.v", "atcdmac300_engine_0");
// &CONNECT("atcdmac300_engine_0", {
// 	idle_state		=> "dma0_idle_state",
//	dma_ch_ctl_wen		=> "dma0_ch_ctl_wen",
//	dma_ch_en_wen		=> "dma0_ch_en_wen",
//	dma_ch_src_addr_wen	=> "dma0_ch_src_addr_wen",
//	dma_ch_dst_addr_wen	=> "dma0_ch_dst_addr_wen",
//	dma_ch_llp_wen		=> "dma0_ch_llp_wen",
//	dma_ch_tts_wen		=> "dma0_ch_tts_wen",
//	dma_ch_tc_wen		=> "dma0_ch_tc_wen",
//	dma_ch_err_wen		=> "dma0_ch_err_wen",
//	dma_ch_int_wen		=> "dma0_ch_int_wen",
//	dma_ch_src_ack		=> "dma0_ch_src_ack",
//	dma_ch_dst_ack		=> "dma0_ch_dst_ack",
//	arb_end			=> "dma0_arb_end",
//	ch_src_addr_ctl		=> "dma0_ch_src_addr_ctl",
//	ch_dst_addr_ctl		=> "dma0_ch_dst_addr_ctl",
//	ch_src_width		=> "dma0_ch_src_width",
//	ch_dst_width		=> "dma0_ch_dst_width",
//	ch_src_burst_size	=> "dma0_ch_src_burst_size",
//	ch_src_mode		=> "dma0_ch_src_mode",
//	ch_src_request		=> "dma0_ch_src_request",
//	ch_dst_mode		=> "dma0_ch_dst_mode",
//	ch_dst_request		=> "dma0_ch_dst_request",
//	ch_tts			=> "dma0_ch_tts",
//	ch_src_addr		=> "dma0_ch_src_addr",
//	ch_dst_addr		=> "dma0_ch_dst_addr",
//	ch_src_bus_inf_idx	=> "dma0_ch_src_bus_inf_idx",
//	ch_dst_bus_inf_idx	=> "dma0_ch_dst_bus_inf_idx",
//	ch_lld_bus_inf_idx	=> "dma0_ch_lld_bus_inf_idx",
//	ch_llp			=> "dma0_ch_llp",
//	ch_abt			=> "dma0_ch_abt",
//	ch_int_tc_mask		=> "dma0_ch_int_tc_mask",
//	ch_int_err_mask		=> "dma0_ch_int_err_mask",
//	ch_int_abt_mask		=> "dma0_ch_int_abt_mask",
//# register file interface
//	dma_ch_llp_wdata	=> "dma0_ch_llp_wdata",
//	dma_ch_llp_wdata_idx	=> "dma0_ch_llp_wdata_idx",
//	dma_ch_ctl_wdata	=> "dma0_ch_ctl_wdata",
//	dma_ch_ctl_wdata_pri	=> "dma0_ch_ctl_wdata_pri",
//	dma_ch_ctl_wdata_idx	=> "dma0_ch_ctl_wdata_idx",
//	dma_ch_tts_wdata	=> "dma0_ch_tts_wdata",
//	dma_ch_src_addr_wdata	=> "dma0_ch_src_addr_wdata",
//	dma_ch_dst_addr_wdata	=> "dma0_ch_dst_addr_wdata",
//# aximst interface
//	dma_mst_wr_mask		=> "dma0_mst_wr_mask",
//	dma_mst0_req		=> "dma0_mst0_req",
//	dma_mst0_addr		=> "dma0_mst0_addr",
//	dma_mst0_write		=> "dma0_mst0_write",
//	dma_mst0_size		=> "dma0_mst0_size",
//	dma_mst0_fix		=> "dma0_mst0_fix",
//	dma_mst0_wdata		=> "dma0_mst0_wdata",
//	dma_mst0_len		=> "dma0_mst0_len",
//	mst0_dma_grant		=> "mst0_dma0_grant",
//	mst0_dma_rd_ack		=> "mst0_dma0_rd_ack",
//	mst0_dma_wr_ack		=> "mst0_dma0_wr_ack",
//	mst0_dma_rdata		=> "mst0_dma0_rdata",
//	mst0_dma_rlast		=> "mst0_dma0_rlast",
//	mst0_dma_bvalid		=> "mst0_dma0_bvalid",
//	mst0_dma_error		=> "mst0_dma0_error",
//	dma_mst1_req		=> "dma0_mst1_req",
//	dma_mst1_addr		=> "dma0_mst1_addr",
//	dma_mst1_write		=> "dma0_mst1_write",
//	dma_mst1_size		=> "dma0_mst1_size",
//	dma_mst1_fix		=> "dma0_mst1_fix",
//	dma_mst1_wdata		=> "dma0_mst1_wdata",
//	dma_mst1_len		=> "dma0_mst1_len",
//	mst1_dma_grant		=> "mst1_dma0_grant",
//	mst1_dma_rd_ack		=> "mst1_dma0_rd_ack",
//	mst1_dma_wr_ack		=> "mst1_dma0_wr_ack",
//	mst1_dma_rdata		=> "mst1_dma0_rdata",
//	mst1_dma_rlast		=> "mst1_dma0_rlast",
//	mst1_dma_bvalid		=> "mst1_dma0_bvalid",
//	mst1_dma_error		=> "mst1_dma0_error",
// });
// &IFDEF("ATCDMAC300_DUAL_DMA_CORE_SUPPORT");
// 	&INSTANCE("atcdmac300_engine.v", "atcdmac300_engine_1");
// 	&CONNECT("atcdmac300_engine_1", {
// 		idle_state		=> "dma1_idle_state",
//		dma_ch_ctl_wen		=> "dma1_ch_ctl_wen",
//		dma_ch_en_wen		=> "dma1_ch_en_wen",
//		dma_ch_src_addr_wen	=> "dma1_ch_src_addr_wen",
//		dma_ch_dst_addr_wen	=> "dma1_ch_dst_addr_wen",
//		dma_ch_llp_wen		=> "dma1_ch_llp_wen",
//		dma_ch_tts_wen		=> "dma1_ch_tts_wen",
//		dma_ch_tc_wen		=> "dma1_ch_tc_wen",
//		dma_ch_err_wen		=> "dma1_ch_err_wen",
//		dma_ch_int_wen		=> "dma1_ch_int_wen",
//		dma_ch_src_ack		=> "dma1_ch_src_ack",
//		dma_ch_dst_ack		=> "dma1_ch_dst_ack",
//		arb_end			=> "dma1_arb_end",
//		ch_src_addr_ctl		=> "dma1_ch_src_addr_ctl",
//		ch_dst_addr_ctl		=> "dma1_ch_dst_addr_ctl",
//		ch_src_width		=> "dma1_ch_src_width",
//		ch_dst_width		=> "dma1_ch_dst_width",
//		ch_src_burst_size	=> "dma1_ch_src_burst_size",
//		ch_src_mode		=> "dma1_ch_src_mode",
//		ch_src_request		=> "dma1_ch_src_request",
//		ch_dst_mode		=> "dma1_ch_dst_mode",
//		ch_dst_request		=> "dma1_ch_dst_request",
//		ch_tts			=> "dma1_ch_tts",
//		ch_src_addr		=> "dma1_ch_src_addr",
//		ch_dst_addr		=> "dma1_ch_dst_addr",
//		ch_src_bus_inf_idx	=> "dma1_ch_src_bus_inf_idx",
//		ch_dst_bus_inf_idx	=> "dma1_ch_dst_bus_inf_idx",
//		ch_lld_bus_inf_idx	=> "dma1_ch_lld_bus_inf_idx",
//		ch_llp			=> "dma1_ch_llp",
//		ch_abt			=> "dma1_ch_abt",
//		ch_int_tc_mask		=> "dma1_ch_int_tc_mask",
//		ch_int_err_mask		=> "dma1_ch_int_err_mask",
//		ch_int_abt_mask		=> "dma1_ch_int_abt_mask",
//# 	register file interface
//		dma_ch_llp_wdata	=> "dma1_ch_llp_wdata",
//		dma_ch_llp_wdata_idx	=> "dma1_ch_llp_wdata_idx",
//		dma_ch_ctl_wdata	=> "dma1_ch_ctl_wdata",
//		dma_ch_ctl_wdata_pri	=> "dma1_ch_ctl_wdata_pri",
//		dma_ch_ctl_wdata_idx	=> "dma1_ch_ctl_wdata_idx",
//		dma_ch_tts_wdata	=> "dma1_ch_tts_wdata",
//		dma_ch_src_addr_wdata	=> "dma1_ch_src_addr_wdata",
//		dma_ch_dst_addr_wdata	=> "dma1_ch_dst_addr_wdata",
//# 	aximst interface
//		dma_mst_wr_mask		=> "dma1_mst_wr_mask",
//		dma_mst0_req		=> "dma1_mst0_req",
//		dma_mst0_addr		=> "dma1_mst0_addr",
//		dma_mst0_write		=> "dma1_mst0_write",
//		dma_mst0_size		=> "dma1_mst0_size",
//		dma_mst0_fix		=> "dma1_mst0_fix",
//		dma_mst0_wdata		=> "dma1_mst0_wdata",
//		dma_mst0_len		=> "dma1_mst0_len",
//		mst0_dma_grant		=> "mst0_dma1_grant",
//		mst0_dma_rd_ack		=> "mst0_dma1_rd_ack",
//		mst0_dma_wr_ack		=> "mst0_dma1_wr_ack",
//		mst0_dma_rdata		=> "mst0_dma1_rdata",
//		mst0_dma_rlast		=> "mst0_dma1_rlast",
//		mst0_dma_bvalid		=> "mst0_dma1_bvalid",
//		mst0_dma_error		=> "mst0_dma1_error",
//		dma_mst1_req		=> "dma1_mst1_req",
//		dma_mst1_addr		=> "dma1_mst1_addr",
//		dma_mst1_write		=> "dma1_mst1_write",
//		dma_mst1_size		=> "dma1_mst1_size",
//		dma_mst1_fix		=> "dma1_mst1_fix",
//		dma_mst1_wdata		=> "dma1_mst1_wdata",
//		dma_mst1_len		=> "dma1_mst1_len",
//		mst1_dma_grant		=> "mst1_dma1_grant",
//		mst1_dma_rd_ack		=> "mst1_dma1_rd_ack",
//		mst1_dma_wr_ack		=> "mst1_dma1_wr_ack",
//		mst1_dma_rdata		=> "mst1_dma1_rdata",
//		mst1_dma_rlast		=> "mst1_dma1_rlast",
//		mst1_dma_bvalid		=> "mst1_dma1_bvalid",
//		mst1_dma_error		=> "mst1_dma1_error",
//	 });
// &ENDIF("ATCDMAC300_DUAL_DMA_CORE_SUPPORT");
// &ENDMODULE
//VPERL_END

// VPERL_GENERATED_BEGIN
module atcdmac300 (
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	  m1_araddr,  // (atcdmac300_aximst_1) => ()
	  m1_arburst, // (atcdmac300_aximst_1) => ()
	  m1_arcache, // (atcdmac300_aximst_1) => ()
	  m1_arid,    // (atcdmac300_aximst_1) => ()
	  m1_arlen,   // (atcdmac300_aximst_1) => ()
	  m1_arlock,  // (atcdmac300_aximst_1) => ()
	  m1_arprot,  // (atcdmac300_aximst_1) => ()
	  m1_arready, // (atcdmac300_aximst_1) <= ()
	  m1_arsize,  // (atcdmac300_aximst_1) => ()
	  m1_arvalid, // (atcdmac300_aximst_1) => ()
	  m1_awaddr,  // (atcdmac300_aximst_1) => ()
	  m1_awburst, // (atcdmac300_aximst_1) => ()
	  m1_awcache, // (atcdmac300_aximst_1) => ()
	  m1_awid,    // (atcdmac300_aximst_1) => ()
	  m1_awlen,   // (atcdmac300_aximst_1) => ()
	  m1_awlock,  // (atcdmac300_aximst_1) => ()
	  m1_awprot,  // (atcdmac300_aximst_1) => ()
	  m1_awready, // (atcdmac300_aximst_1) <= ()
	  m1_awsize,  // (atcdmac300_aximst_1) => ()
	  m1_awvalid, // (atcdmac300_aximst_1) => ()
	  m1_bid,     // (atcdmac300_aximst_1) <= ()
	  m1_bready,  // (atcdmac300_aximst_1) => ()
	  m1_bresp,   // (atcdmac300_aximst_1) <= ()
	  m1_bvalid,  // (atcdmac300_aximst_1) <= ()
	  m1_rdata,   // (atcdmac300_aximst_1) <= ()
	  m1_rid,     // (atcdmac300_aximst_1) <= ()
	  m1_rlast,   // (atcdmac300_aximst_1) <= ()
	  m1_rready,  // (atcdmac300_aximst_1) => ()
	  m1_rresp,   // (atcdmac300_aximst_1) <= ()
	  m1_rvalid,  // (atcdmac300_aximst_1) <= ()
	  m1_wdata,   // (atcdmac300_aximst_1) => ()
	  m1_wlast,   // (atcdmac300_aximst_1) => ()
	  m1_wready,  // (atcdmac300_aximst_1) <= ()
	  m1_wstrb,   // (atcdmac300_aximst_1) => ()
	  m1_wvalid,  // (atcdmac300_aximst_1) => ()
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	  paddr,      // (atcdmac300_apbslv) <= ()
	  penable,    // (atcdmac300_apbslv) <= ()
	  prdata,     // (atcdmac300_apbslv) => ()
	  pready,     // (atcdmac300_apbslv) => ()
	  psel,       // (atcdmac300_apbslv) <= ()
	  pslverr,    // (atcdmac300_apbslv) => ()
	  pwdata,     // (atcdmac300_apbslv) <= ()
	  pwrite,     // (atcdmac300_apbslv) <= ()
	  pclk,       // (atcdmac300_apbslv,atcdmac300_register) <= ()
	  presetn,    // (atcdmac300_apbslv,atcdmac300_register) <= ()
	  m0_araddr,  // (atcdmac300_aximst_0) => ()
	  m0_arburst, // (atcdmac300_aximst_0) => ()
	  m0_arcache, // (atcdmac300_aximst_0) => ()
	  m0_arid,    // (atcdmac300_aximst_0) => ()
	  m0_arlen,   // (atcdmac300_aximst_0) => ()
	  m0_arlock,  // (atcdmac300_aximst_0) => ()
	  m0_arprot,  // (atcdmac300_aximst_0) => ()
	  m0_arready, // (atcdmac300_aximst_0) <= ()
	  m0_arsize,  // (atcdmac300_aximst_0) => ()
	  m0_arvalid, // (atcdmac300_aximst_0) => ()
	  m0_awaddr,  // (atcdmac300_aximst_0) => ()
	  m0_awburst, // (atcdmac300_aximst_0) => ()
	  m0_awcache, // (atcdmac300_aximst_0) => ()
	  m0_awid,    // (atcdmac300_aximst_0) => ()
	  m0_awlen,   // (atcdmac300_aximst_0) => ()
	  m0_awlock,  // (atcdmac300_aximst_0) => ()
	  m0_awprot,  // (atcdmac300_aximst_0) => ()
	  m0_awready, // (atcdmac300_aximst_0) <= ()
	  m0_awsize,  // (atcdmac300_aximst_0) => ()
	  m0_awvalid, // (atcdmac300_aximst_0) => ()
	  m0_bid,     // (atcdmac300_aximst_0) <= ()
	  m0_bready,  // (atcdmac300_aximst_0) => ()
	  m0_bresp,   // (atcdmac300_aximst_0) <= ()
	  m0_bvalid,  // (atcdmac300_aximst_0) <= ()
	  m0_rdata,   // (atcdmac300_aximst_0) <= ()
	  m0_rid,     // (atcdmac300_aximst_0) <= ()
	  m0_rlast,   // (atcdmac300_aximst_0) <= ()
	  m0_rready,  // (atcdmac300_aximst_0) => ()
	  m0_rresp,   // (atcdmac300_aximst_0) <= ()
	  m0_rvalid,  // (atcdmac300_aximst_0) <= ()
	  m0_wdata,   // (atcdmac300_aximst_0) => ()
	  m0_wlast,   // (atcdmac300_aximst_0) => ()
	  m0_wready,  // (atcdmac300_aximst_0) <= ()
	  m0_wstrb,   // (atcdmac300_aximst_0) => ()
	  m0_wvalid,  // (atcdmac300_aximst_0) => ()
	  aclk,       // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	  aresetn,    // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	  dma_ack,    // (atcdmac300_chmux) => ()
	  dma_req,    // (atcdmac300_chmux) <= ()
	  dma_int     // (atcdmac300_register) => ()
);

localparam ADDR_MSB	= `ATCDMAC300_ADDR_WIDTH - 1;
localparam ADDR_WEN_MSB	= ADDR_MSB > 31 ? 1 : 0;

`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output       [(`ATCDMAC300_ADDR_WIDTH-1):0] m1_araddr;
output                                [1:0] m1_arburst;
output                                [3:0] m1_arcache;
output                                [2:0] m1_arid;
output                                [7:0] m1_arlen;
output                                      m1_arlock;
output                                [2:0] m1_arprot;
input                                       m1_arready;
output                                [2:0] m1_arsize;
output                                      m1_arvalid;
output       [(`ATCDMAC300_ADDR_WIDTH-1):0] m1_awaddr;
output                                [1:0] m1_awburst;
output                                [3:0] m1_awcache;
output                                [2:0] m1_awid;
output                                [7:0] m1_awlen;
output                                      m1_awlock;
output                                [2:0] m1_awprot;
input                                       m1_awready;
output                                [2:0] m1_awsize;
output                                      m1_awvalid;
input                                 [2:0] m1_bid;
output                                      m1_bready;
input                                 [1:0] m1_bresp;
input                                       m1_bvalid;
input               [(`DMA_DATA_WIDTH-1):0] m1_rdata;
input                                 [2:0] m1_rid;
input                                       m1_rlast;
output                                      m1_rready;
input                                 [1:0] m1_rresp;
input                                       m1_rvalid;
output              [(`DMA_DATA_WIDTH-1):0] m1_wdata;
output                                      m1_wlast;
input                                       m1_wready;
output             [(`DMA_WSTRB_WIDTH-1):0] m1_wstrb;
output                                      m1_wvalid;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input                                [31:0] paddr;
input                                       penable;
output                               [31:0] prdata;
output                                      pready;
input                                       psel;
output                                      pslverr;
input                                [31:0] pwdata;
input                                       pwrite;
input                                       pclk;
input                                       presetn;
output       [(`ATCDMAC300_ADDR_WIDTH-1):0] m0_araddr;
output                                [1:0] m0_arburst;
output                                [3:0] m0_arcache;
output                                [2:0] m0_arid;
output                                [7:0] m0_arlen;
output                                      m0_arlock;
output                                [2:0] m0_arprot;
input                                       m0_arready;
output                                [2:0] m0_arsize;
output                                      m0_arvalid;
output       [(`ATCDMAC300_ADDR_WIDTH-1):0] m0_awaddr;
output                                [1:0] m0_awburst;
output                                [3:0] m0_awcache;
output                                [2:0] m0_awid;
output                                [7:0] m0_awlen;
output                                      m0_awlock;
output                                [2:0] m0_awprot;
input                                       m0_awready;
output                                [2:0] m0_awsize;
output                                      m0_awvalid;
input                                 [2:0] m0_bid;
output                                      m0_bready;
input                                 [1:0] m0_bresp;
input                                       m0_bvalid;
input               [(`DMA_DATA_WIDTH-1):0] m0_rdata;
input                                 [2:0] m0_rid;
input                                       m0_rlast;
output                                      m0_rready;
input                                 [1:0] m0_rresp;
input                                       m0_rvalid;
output              [(`DMA_DATA_WIDTH-1):0] m0_wdata;
output                                      m0_wlast;
input                                       m0_wready;
output             [(`DMA_WSTRB_WIDTH-1):0] m0_wstrb;
output                                      m0_wvalid;
input                                       aclk;
input                                       aresetn;
output      [(`ATCDMAC300_REQ_ACK_NUM-1):0] dma_ack;
input       [(`ATCDMAC300_REQ_ACK_NUM-1):0] dma_req;
output                                      dma_int;

`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
wire                                        mst1_dma0_bvalid;
wire                                        mst1_dma0_error;
wire                                        mst1_dma0_grant;
wire                                        mst1_dma0_rd_ack;
wire                [(`DMA_DATA_WIDTH-1):0] mst1_dma0_rdata;
wire                                        mst1_dma0_rlast;
wire                                        mst1_dma0_wr_ack;
wire                                        dma0_ch_dst_bus_inf_idx;
wire                                        dma0_ch_src_bus_inf_idx;
wire                                  [1:0] dma0_ch_ctl_wdata_idx;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma0_mst1_addr;
wire                                        dma0_mst1_fix;
wire                                  [7:0] dma0_mst1_len;
wire                                        dma0_mst1_req;
wire                                  [2:0] dma0_mst1_size;
wire                [(`DMA_DATA_WIDTH-1):0] dma0_mst1_wdata;
wire                                        dma0_mst1_write;
wire                                        ch_0_dst_bus_inf_idx;
wire                                        ch_0_src_bus_inf_idx;
wire                                        ch_1_dst_bus_inf_idx;
wire                                        ch_1_src_bus_inf_idx;
wire                                        ch_2_dst_bus_inf_idx;
wire                                        ch_2_src_bus_inf_idx;
wire                                        ch_3_dst_bus_inf_idx;
wire                                        ch_3_src_bus_inf_idx;
wire                                        ch_4_dst_bus_inf_idx;
wire                                        ch_4_src_bus_inf_idx;
wire                                        ch_5_dst_bus_inf_idx;
wire                                        ch_5_src_bus_inf_idx;
wire                                        ch_6_dst_bus_inf_idx;
wire                                        ch_6_src_bus_inf_idx;
wire                                        ch_7_dst_bus_inf_idx;
wire                                        ch_7_src_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] dma0_ch_llp;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] dma0_ch_llp_wdata;
wire                       [ADDR_WEN_MSB:0] dma0_ch_llp_wen;
`ifdef DMAC_CONFIG_CH0
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_0_llp_reg;
`endif // DMAC_CONFIG_CH0

`ifdef DMAC_CONFIG_CH1
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_1_llp_reg;
`endif // DMAC_CONFIG_CH1

`ifdef DMAC_CONFIG_CH2
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_2_llp_reg;
`endif // DMAC_CONFIG_CH2

`ifdef DMAC_CONFIG_CH3
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_3_llp_reg;
`endif // DMAC_CONFIG_CH3

`ifdef DMAC_CONFIG_CH4
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_4_llp_reg;
`endif // DMAC_CONFIG_CH4

`ifdef DMAC_CONFIG_CH5
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_5_llp_reg;
`endif // DMAC_CONFIG_CH5

`ifdef DMAC_CONFIG_CH6
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_6_llp_reg;
`endif // DMAC_CONFIG_CH6

`ifdef DMAC_CONFIG_CH7
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_7_llp_reg;
`endif // DMAC_CONFIG_CH7


`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
wire                                        mst0_dma1_bvalid;
wire                                        mst0_dma1_error;
wire                                        mst0_dma1_grant;
wire                                        mst0_dma1_rd_ack;
wire                [(`DMA_DATA_WIDTH-1):0] mst0_dma1_rdata;
wire                                        mst0_dma1_rlast;
wire                                        mst0_dma1_wr_ack;
wire                                        dma1_arb_end;
wire                                        dma1_ch_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma1_ch_dst_addr;
wire                                  [1:0] dma1_ch_dst_addr_ctl;
wire                                        dma1_ch_dst_mode;
wire                                        dma1_ch_dst_request;
wire                                  [2:0] dma1_ch_dst_width;
wire                                        dma1_ch_int_abt_mask;
wire                                        dma1_ch_int_err_mask;
wire                                        dma1_ch_int_tc_mask;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma1_ch_src_addr;
wire                                  [1:0] dma1_ch_src_addr_ctl;
wire                                  [3:0] dma1_ch_src_burst_size;
wire                                        dma1_ch_src_mode;
wire                                        dma1_ch_src_request;
wire                                  [2:0] dma1_ch_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] dma1_ch_tts;
wire                                  [2:0] dma1_current_channel;
wire                                 [27:1] dma1_ch_ctl_wdata;
wire                                        dma1_ch_ctl_wdata_pri;
wire                                        dma1_ch_ctl_wen;
wire                                        dma1_ch_dst_ack;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma1_ch_dst_addr_wdata;
wire                       [ADDR_WEN_MSB:0] dma1_ch_dst_addr_wen;
wire                                        dma1_ch_en_wen;
wire                                        dma1_ch_err_wen;
wire                                        dma1_ch_int_wen;
wire                                        dma1_ch_src_ack;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma1_ch_src_addr_wdata;
wire                       [ADDR_WEN_MSB:0] dma1_ch_src_addr_wen;
wire                                        dma1_ch_tc_wen;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] dma1_ch_tts_wdata;
wire                                        dma1_ch_tts_wen;
wire                                        dma1_idle_state;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma1_mst0_addr;
wire                                        dma1_mst0_fix;
wire                                  [7:0] dma1_mst0_len;
wire                                        dma1_mst0_req;
wire                                  [2:0] dma1_mst0_size;
wire                [(`DMA_DATA_WIDTH-1):0] dma1_mst0_wdata;
wire                                        dma1_mst0_write;
wire                                        dma1_mst_wr_mask;
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
`ifdef DMAC_CONFIG_CH0
wire                                        dma0_ch_0_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_0_dst_addr_wen;
wire                                        dma0_ch_0_en_wen;
wire                                        dma0_ch_0_err_wen;
wire                                        dma0_ch_0_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_0_src_addr_wen;
wire                                        dma0_ch_0_tc_wen;
wire                                        dma0_ch_0_tts_wen;
`endif // DMAC_CONFIG_CH0
`ifdef DMAC_CONFIG_CH1
wire                                        dma0_ch_1_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_1_dst_addr_wen;
wire                                        dma0_ch_1_en_wen;
wire                                        dma0_ch_1_err_wen;
wire                                        dma0_ch_1_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_1_src_addr_wen;
wire                                        dma0_ch_1_tc_wen;
wire                                        dma0_ch_1_tts_wen;
`endif // DMAC_CONFIG_CH1
`ifdef DMAC_CONFIG_CH2
wire                                        dma0_ch_2_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_2_dst_addr_wen;
wire                                        dma0_ch_2_en_wen;
wire                                        dma0_ch_2_err_wen;
wire                                        dma0_ch_2_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_2_src_addr_wen;
wire                                        dma0_ch_2_tc_wen;
wire                                        dma0_ch_2_tts_wen;
`endif // DMAC_CONFIG_CH2
`ifdef DMAC_CONFIG_CH3
wire                                        dma0_ch_3_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_3_dst_addr_wen;
wire                                        dma0_ch_3_en_wen;
wire                                        dma0_ch_3_err_wen;
wire                                        dma0_ch_3_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_3_src_addr_wen;
wire                                        dma0_ch_3_tc_wen;
wire                                        dma0_ch_3_tts_wen;
`endif // DMAC_CONFIG_CH3
`ifdef DMAC_CONFIG_CH4
wire                                        dma0_ch_4_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_4_dst_addr_wen;
wire                                        dma0_ch_4_en_wen;
wire                                        dma0_ch_4_err_wen;
wire                                        dma0_ch_4_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_4_src_addr_wen;
wire                                        dma0_ch_4_tc_wen;
wire                                        dma0_ch_4_tts_wen;
`endif // DMAC_CONFIG_CH4
`ifdef DMAC_CONFIG_CH5
wire                                        dma0_ch_5_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_5_dst_addr_wen;
wire                                        dma0_ch_5_en_wen;
wire                                        dma0_ch_5_err_wen;
wire                                        dma0_ch_5_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_5_src_addr_wen;
wire                                        dma0_ch_5_tc_wen;
wire                                        dma0_ch_5_tts_wen;
`endif // DMAC_CONFIG_CH5
`ifdef DMAC_CONFIG_CH6
wire                                        dma0_ch_6_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_6_dst_addr_wen;
wire                                        dma0_ch_6_en_wen;
wire                                        dma0_ch_6_err_wen;
wire                                        dma0_ch_6_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_6_src_addr_wen;
wire                                        dma0_ch_6_tc_wen;
wire                                        dma0_ch_6_tts_wen;
`endif // DMAC_CONFIG_CH6
`ifdef DMAC_CONFIG_CH7
wire                                        dma0_ch_7_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_7_dst_addr_wen;
wire                                        dma0_ch_7_en_wen;
wire                                        dma0_ch_7_err_wen;
wire                                        dma0_ch_7_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_7_src_addr_wen;
wire                                        dma0_ch_7_tc_wen;
wire                                        dma0_ch_7_tts_wen;
`endif // DMAC_CONFIG_CH7
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire                                        dma0_ch_lld_bus_inf_idx;
wire                                        dma0_ch_llp_wdata_idx;
wire                                        ch_0_lld_bus_inf_idx;
wire                                        ch_1_lld_bus_inf_idx;
wire                                        ch_2_lld_bus_inf_idx;
wire                                        ch_3_lld_bus_inf_idx;
wire                                        ch_4_lld_bus_inf_idx;
wire                                        ch_5_lld_bus_inf_idx;
wire                                        ch_6_lld_bus_inf_idx;
wire                                        ch_7_lld_bus_inf_idx;
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
   `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] dma1_ch_llp;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] dma1_ch_llp_wdata;
wire                       [ADDR_WEN_MSB:0] dma1_ch_llp_wen;
   `endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
   `ifdef DMAC_CONFIG_CH0
wire                       [ADDR_WEN_MSB:0] dma0_ch_0_llp_wen;
   `endif // DMAC_CONFIG_CH0
   `ifdef DMAC_CONFIG_CH1
wire                       [ADDR_WEN_MSB:0] dma0_ch_1_llp_wen;
   `endif // DMAC_CONFIG_CH1
   `ifdef DMAC_CONFIG_CH2
wire                       [ADDR_WEN_MSB:0] dma0_ch_2_llp_wen;
   `endif // DMAC_CONFIG_CH2
   `ifdef DMAC_CONFIG_CH3
wire                       [ADDR_WEN_MSB:0] dma0_ch_3_llp_wen;
   `endif // DMAC_CONFIG_CH3
   `ifdef DMAC_CONFIG_CH4
wire                       [ADDR_WEN_MSB:0] dma0_ch_4_llp_wen;
   `endif // DMAC_CONFIG_CH4
   `ifdef DMAC_CONFIG_CH5
wire                       [ADDR_WEN_MSB:0] dma0_ch_5_llp_wen;
   `endif // DMAC_CONFIG_CH5
   `ifdef DMAC_CONFIG_CH6
wire                       [ADDR_WEN_MSB:0] dma0_ch_6_llp_wen;
   `endif // DMAC_CONFIG_CH6
   `ifdef DMAC_CONFIG_CH7
wire                       [ADDR_WEN_MSB:0] dma0_ch_7_llp_wen;
   `endif // DMAC_CONFIG_CH7
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
   `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
wire                                        mst1_dma1_bvalid;
wire                                        mst1_dma1_error;
wire                                        mst1_dma1_grant;
wire                                        mst1_dma1_rd_ack;
wire                [(`DMA_DATA_WIDTH-1):0] mst1_dma1_rdata;
wire                                        mst1_dma1_rlast;
wire                                        mst1_dma1_wr_ack;
wire                                        dma1_ch_dst_bus_inf_idx;
wire                                        dma1_ch_src_bus_inf_idx;
wire                                  [1:0] dma1_ch_ctl_wdata_idx;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma1_mst1_addr;
wire                                        dma1_mst1_fix;
wire                                  [7:0] dma1_mst1_len;
wire                                        dma1_mst1_req;
wire                                  [2:0] dma1_mst1_size;
wire                [(`DMA_DATA_WIDTH-1):0] dma1_mst1_wdata;
wire                                        dma1_mst1_write;
   `endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
   `ifdef DMAC_CONFIG_CH0
wire                                        dma1_ch_0_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_0_dst_addr_wen;
wire                                        dma1_ch_0_en_wen;
wire                                        dma1_ch_0_err_wen;
wire                                        dma1_ch_0_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_0_src_addr_wen;
wire                                        dma1_ch_0_tc_wen;
wire                                        dma1_ch_0_tts_wen;
   `endif // DMAC_CONFIG_CH0
   `ifdef DMAC_CONFIG_CH1
wire                                        dma1_ch_1_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_1_dst_addr_wen;
wire                                        dma1_ch_1_en_wen;
wire                                        dma1_ch_1_err_wen;
wire                                        dma1_ch_1_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_1_src_addr_wen;
wire                                        dma1_ch_1_tc_wen;
wire                                        dma1_ch_1_tts_wen;
   `endif // DMAC_CONFIG_CH1
   `ifdef DMAC_CONFIG_CH2
wire                                        dma1_ch_2_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_2_dst_addr_wen;
wire                                        dma1_ch_2_en_wen;
wire                                        dma1_ch_2_err_wen;
wire                                        dma1_ch_2_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_2_src_addr_wen;
wire                                        dma1_ch_2_tc_wen;
wire                                        dma1_ch_2_tts_wen;
   `endif // DMAC_CONFIG_CH2
   `ifdef DMAC_CONFIG_CH3
wire                                        dma1_ch_3_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_3_dst_addr_wen;
wire                                        dma1_ch_3_en_wen;
wire                                        dma1_ch_3_err_wen;
wire                                        dma1_ch_3_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_3_src_addr_wen;
wire                                        dma1_ch_3_tc_wen;
wire                                        dma1_ch_3_tts_wen;
   `endif // DMAC_CONFIG_CH3
   `ifdef DMAC_CONFIG_CH4
wire                                        dma1_ch_4_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_4_dst_addr_wen;
wire                                        dma1_ch_4_en_wen;
wire                                        dma1_ch_4_err_wen;
wire                                        dma1_ch_4_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_4_src_addr_wen;
wire                                        dma1_ch_4_tc_wen;
wire                                        dma1_ch_4_tts_wen;
   `endif // DMAC_CONFIG_CH4
   `ifdef DMAC_CONFIG_CH5
wire                                        dma1_ch_5_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_5_dst_addr_wen;
wire                                        dma1_ch_5_en_wen;
wire                                        dma1_ch_5_err_wen;
wire                                        dma1_ch_5_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_5_src_addr_wen;
wire                                        dma1_ch_5_tc_wen;
wire                                        dma1_ch_5_tts_wen;
   `endif // DMAC_CONFIG_CH5
   `ifdef DMAC_CONFIG_CH6
wire                                        dma1_ch_6_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_6_dst_addr_wen;
wire                                        dma1_ch_6_en_wen;
wire                                        dma1_ch_6_err_wen;
wire                                        dma1_ch_6_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_6_src_addr_wen;
wire                                        dma1_ch_6_tc_wen;
wire                                        dma1_ch_6_tts_wen;
   `endif // DMAC_CONFIG_CH6
   `ifdef DMAC_CONFIG_CH7
wire                                        dma1_ch_7_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_7_dst_addr_wen;
wire                                        dma1_ch_7_en_wen;
wire                                        dma1_ch_7_err_wen;
wire                                        dma1_ch_7_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_7_src_addr_wen;
wire                                        dma1_ch_7_tc_wen;
wire                                        dma1_ch_7_tts_wen;
   `endif // DMAC_CONFIG_CH7
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire                                        dma1_ch_lld_bus_inf_idx;
wire                                        dma1_ch_llp_wdata_idx;
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
      `ifdef DMAC_CONFIG_CH0
wire                       [ADDR_WEN_MSB:0] dma1_ch_0_llp_wen;
      `endif // DMAC_CONFIG_CH0
      `ifdef DMAC_CONFIG_CH1
wire                       [ADDR_WEN_MSB:0] dma1_ch_1_llp_wen;
      `endif // DMAC_CONFIG_CH1
      `ifdef DMAC_CONFIG_CH2
wire                       [ADDR_WEN_MSB:0] dma1_ch_2_llp_wen;
      `endif // DMAC_CONFIG_CH2
      `ifdef DMAC_CONFIG_CH3
wire                       [ADDR_WEN_MSB:0] dma1_ch_3_llp_wen;
      `endif // DMAC_CONFIG_CH3
      `ifdef DMAC_CONFIG_CH4
wire                       [ADDR_WEN_MSB:0] dma1_ch_4_llp_wen;
      `endif // DMAC_CONFIG_CH4
      `ifdef DMAC_CONFIG_CH5
wire                       [ADDR_WEN_MSB:0] dma1_ch_5_llp_wen;
      `endif // DMAC_CONFIG_CH5
      `ifdef DMAC_CONFIG_CH6
wire                       [ADDR_WEN_MSB:0] dma1_ch_6_llp_wen;
      `endif // DMAC_CONFIG_CH6
      `ifdef DMAC_CONFIG_CH7
wire                       [ADDR_WEN_MSB:0] dma1_ch_7_llp_wen;
      `endif // DMAC_CONFIG_CH7
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
wire                                 [39:0] cmd_buff_wdata;
wire                                        cmd_buff_wr;
wire                                        rdata_buff_rd;
wire                                  [2:0] granted_channel;
wire                                        mst0_dma0_bvalid;
wire                                        mst0_dma0_error;
wire                                        mst0_dma0_grant;
wire                                        mst0_dma0_rd_ack;
wire                [(`DMA_DATA_WIDTH-1):0] mst0_dma0_rdata;
wire                                        mst0_dma0_rlast;
wire                                        mst0_dma0_wr_ack;
wire                                  [7:0] ch_level;
wire                                  [7:0] ch_request;
wire                                  [2:0] current_channel;
wire                                        dma0_arb_end;
wire                                        dma0_ch_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma0_ch_dst_addr;
wire                                  [1:0] dma0_ch_dst_addr_ctl;
wire                                        dma0_ch_dst_mode;
wire                                        dma0_ch_dst_request;
wire                                  [2:0] dma0_ch_dst_width;
wire                                        dma0_ch_int_abt_mask;
wire                                        dma0_ch_int_err_mask;
wire                                        dma0_ch_int_tc_mask;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma0_ch_src_addr;
wire                                  [1:0] dma0_ch_src_addr_ctl;
wire                                  [3:0] dma0_ch_src_burst_size;
wire                                        dma0_ch_src_mode;
wire                                        dma0_ch_src_request;
wire                                  [2:0] dma0_ch_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] dma0_ch_tts;
wire                                  [2:0] dma0_current_channel;
wire                                 [27:1] dma0_ch_ctl_wdata;
wire                                        dma0_ch_ctl_wdata_pri;
wire                                        dma0_ch_ctl_wen;
wire                                        dma0_ch_dst_ack;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma0_ch_dst_addr_wdata;
wire                       [ADDR_WEN_MSB:0] dma0_ch_dst_addr_wen;
wire                                        dma0_ch_en_wen;
wire                                        dma0_ch_err_wen;
wire                                        dma0_ch_int_wen;
wire                                        dma0_ch_src_ack;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma0_ch_src_addr_wdata;
wire                       [ADDR_WEN_MSB:0] dma0_ch_src_addr_wen;
wire                                        dma0_ch_tc_wen;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] dma0_ch_tts_wdata;
wire                                        dma0_ch_tts_wen;
wire                                        dma0_idle_state;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma0_mst0_addr;
wire                                        dma0_mst0_fix;
wire                                  [7:0] dma0_mst0_len;
wire                                        dma0_mst0_req;
wire                                  [2:0] dma0_mst0_size;
wire                [(`DMA_DATA_WIDTH-1):0] dma0_mst0_wdata;
wire                                        dma0_mst0_write;
wire                                        dma0_mst_wr_mask;
wire                                        ch_0_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_0_dst_addr;
wire                                  [1:0] ch_0_dst_addr_ctl;
wire                                        ch_0_dst_mode;
wire                                  [3:0] ch_0_dst_req_sel;
wire                                  [2:0] ch_0_dst_width;
wire                                        ch_0_en;
wire                                        ch_0_int_abt_mask;
wire                                        ch_0_int_err_mask;
wire                                        ch_0_int_tc_mask;
wire                                        ch_0_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_0_src_addr;
wire                                  [1:0] ch_0_src_addr_ctl;
wire                                  [3:0] ch_0_src_burst_size;
wire                                        ch_0_src_mode;
wire                                  [3:0] ch_0_src_req_sel;
wire                                  [2:0] ch_0_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_0_tts;
wire                                        ch_1_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_1_dst_addr;
wire                                  [1:0] ch_1_dst_addr_ctl;
wire                                        ch_1_dst_mode;
wire                                  [3:0] ch_1_dst_req_sel;
wire                                  [2:0] ch_1_dst_width;
wire                                        ch_1_en;
wire                                        ch_1_int_abt_mask;
wire                                        ch_1_int_err_mask;
wire                                        ch_1_int_tc_mask;
wire                                        ch_1_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_1_src_addr;
wire                                  [1:0] ch_1_src_addr_ctl;
wire                                  [3:0] ch_1_src_burst_size;
wire                                        ch_1_src_mode;
wire                                  [3:0] ch_1_src_req_sel;
wire                                  [2:0] ch_1_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_1_tts;
wire                                        ch_2_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_2_dst_addr;
wire                                  [1:0] ch_2_dst_addr_ctl;
wire                                        ch_2_dst_mode;
wire                                  [3:0] ch_2_dst_req_sel;
wire                                  [2:0] ch_2_dst_width;
wire                                        ch_2_en;
wire                                        ch_2_int_abt_mask;
wire                                        ch_2_int_err_mask;
wire                                        ch_2_int_tc_mask;
wire                                        ch_2_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_2_src_addr;
wire                                  [1:0] ch_2_src_addr_ctl;
wire                                  [3:0] ch_2_src_burst_size;
wire                                        ch_2_src_mode;
wire                                  [3:0] ch_2_src_req_sel;
wire                                  [2:0] ch_2_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_2_tts;
wire                                        ch_3_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_3_dst_addr;
wire                                  [1:0] ch_3_dst_addr_ctl;
wire                                        ch_3_dst_mode;
wire                                  [3:0] ch_3_dst_req_sel;
wire                                  [2:0] ch_3_dst_width;
wire                                        ch_3_en;
wire                                        ch_3_int_abt_mask;
wire                                        ch_3_int_err_mask;
wire                                        ch_3_int_tc_mask;
wire                                        ch_3_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_3_src_addr;
wire                                  [1:0] ch_3_src_addr_ctl;
wire                                  [3:0] ch_3_src_burst_size;
wire                                        ch_3_src_mode;
wire                                  [3:0] ch_3_src_req_sel;
wire                                  [2:0] ch_3_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_3_tts;
wire                                        ch_4_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_4_dst_addr;
wire                                  [1:0] ch_4_dst_addr_ctl;
wire                                        ch_4_dst_mode;
wire                                  [3:0] ch_4_dst_req_sel;
wire                                  [2:0] ch_4_dst_width;
wire                                        ch_4_en;
wire                                        ch_4_int_abt_mask;
wire                                        ch_4_int_err_mask;
wire                                        ch_4_int_tc_mask;
wire                                        ch_4_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_4_src_addr;
wire                                  [1:0] ch_4_src_addr_ctl;
wire                                  [3:0] ch_4_src_burst_size;
wire                                        ch_4_src_mode;
wire                                  [3:0] ch_4_src_req_sel;
wire                                  [2:0] ch_4_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_4_tts;
wire                                        ch_5_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_5_dst_addr;
wire                                  [1:0] ch_5_dst_addr_ctl;
wire                                        ch_5_dst_mode;
wire                                  [3:0] ch_5_dst_req_sel;
wire                                  [2:0] ch_5_dst_width;
wire                                        ch_5_en;
wire                                        ch_5_int_abt_mask;
wire                                        ch_5_int_err_mask;
wire                                        ch_5_int_tc_mask;
wire                                        ch_5_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_5_src_addr;
wire                                  [1:0] ch_5_src_addr_ctl;
wire                                  [3:0] ch_5_src_burst_size;
wire                                        ch_5_src_mode;
wire                                  [3:0] ch_5_src_req_sel;
wire                                  [2:0] ch_5_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_5_tts;
wire                                        ch_6_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_6_dst_addr;
wire                                  [1:0] ch_6_dst_addr_ctl;
wire                                        ch_6_dst_mode;
wire                                  [3:0] ch_6_dst_req_sel;
wire                                  [2:0] ch_6_dst_width;
wire                                        ch_6_en;
wire                                        ch_6_int_abt_mask;
wire                                        ch_6_int_err_mask;
wire                                        ch_6_int_tc_mask;
wire                                        ch_6_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_6_src_addr;
wire                                  [1:0] ch_6_src_addr_ctl;
wire                                  [3:0] ch_6_src_burst_size;
wire                                        ch_6_src_mode;
wire                                  [3:0] ch_6_src_req_sel;
wire                                  [2:0] ch_6_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_6_tts;
wire                                        ch_7_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_7_dst_addr;
wire                                  [1:0] ch_7_dst_addr_ctl;
wire                                        ch_7_dst_mode;
wire                                  [3:0] ch_7_dst_req_sel;
wire                                  [2:0] ch_7_dst_width;
wire                                        ch_7_en;
wire                                        ch_7_int_abt_mask;
wire                                        ch_7_int_err_mask;
wire                                        ch_7_int_tc_mask;
wire                                        ch_7_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_7_src_addr;
wire                                  [1:0] ch_7_src_addr_ctl;
wire                                  [3:0] ch_7_src_burst_size;
wire                                        ch_7_src_mode;
wire                                  [3:0] ch_7_src_req_sel;
wire                                  [2:0] ch_7_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_7_tts;
wire                                        cmd_buff_full;
wire                                        dma_soft_reset;
wire                                        rdata_buff_empty;
wire                                 [31:0] rdata_buff_rdata;


atcdmac300_apbslv atcdmac300_apbslv (
	.pclk            (pclk            ), // (atcdmac300_apbslv,atcdmac300_register) <= ()
	.presetn         (presetn         ), // (atcdmac300_apbslv,atcdmac300_register) <= ()
	.paddr           (paddr           ), // (atcdmac300_apbslv) <= ()
	.psel            (psel            ), // (atcdmac300_apbslv) <= ()
	.penable         (penable         ), // (atcdmac300_apbslv) <= ()
	.pwrite          (pwrite          ), // (atcdmac300_apbslv) <= ()
	.pwdata          (pwdata          ), // (atcdmac300_apbslv) <= ()
	.pready          (pready          ), // (atcdmac300_apbslv) => ()
	.prdata          (prdata          ), // (atcdmac300_apbslv) => ()
	.pslverr         (pslverr         ), // (atcdmac300_apbslv) => ()
	.cmd_buff_wr     (cmd_buff_wr     ), // (atcdmac300_apbslv) => (atcdmac300_register)
	.cmd_buff_wdata  (cmd_buff_wdata  ), // (atcdmac300_apbslv) => (atcdmac300_register)
	.cmd_buff_full   (cmd_buff_full   ), // (atcdmac300_apbslv) <= (atcdmac300_register)
	.rdata_buff_rd   (rdata_buff_rd   ), // (atcdmac300_apbslv) => (atcdmac300_register)
	.rdata_buff_rdata(rdata_buff_rdata), // (atcdmac300_apbslv) <= (atcdmac300_register)
	.rdata_buff_empty(rdata_buff_empty)  // (atcdmac300_apbslv) <= (atcdmac300_register)
); // end of atcdmac300_apbslv

atcdmac300_arbiter atcdmac300_arbiter (
	.ch_request     (ch_request     ), // (atcdmac300_arbiter) <= (atcdmac300_chmux)
	.ch_level       (ch_level       ), // (atcdmac300_arbiter) <= (atcdmac300_chmux)
	.current_channel(current_channel), // (atcdmac300_arbiter) <= (atcdmac300_chmux)
	.granted_channel(granted_channel)  // (atcdmac300_arbiter) => (atcdmac300_chmux)
); // end of atcdmac300_arbiter

atcdmac300_register atcdmac300_register (
	.aclk                  (aclk                  ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.aresetn               (aresetn               ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.pclk                  (pclk                  ), // (atcdmac300_apbslv,atcdmac300_register) <= ()
	.presetn               (presetn               ), // (atcdmac300_apbslv,atcdmac300_register) <= ()
	.cmd_buff_wr           (cmd_buff_wr           ), // (atcdmac300_register) <= (atcdmac300_apbslv)
	.cmd_buff_wdata        (cmd_buff_wdata        ), // (atcdmac300_register) <= (atcdmac300_apbslv)
	.cmd_buff_full         (cmd_buff_full         ), // (atcdmac300_register) => (atcdmac300_apbslv)
	.rdata_buff_rd         (rdata_buff_rd         ), // (atcdmac300_register) <= (atcdmac300_apbslv)
	.rdata_buff_rdata      (rdata_buff_rdata      ), // (atcdmac300_register) => (atcdmac300_apbslv)
	.rdata_buff_empty      (rdata_buff_empty      ), // (atcdmac300_register) => (atcdmac300_apbslv)
	.dma_int               (dma_int               ), // (atcdmac300_register) => ()
	.dma_soft_reset        (dma_soft_reset        ), // (atcdmac300_register) => (atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1)
	.ch_0_en               (ch_0_en               ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_int_tc_mask      (ch_0_int_tc_mask      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_int_err_mask     (ch_0_int_err_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_int_abt_mask     (ch_0_int_abt_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_src_req_sel      (ch_0_src_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_dst_req_sel      (ch_0_dst_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_src_addr_ctl     (ch_0_src_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_dst_addr_ctl     (ch_0_dst_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_src_mode         (ch_0_src_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_dst_mode         (ch_0_dst_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_src_width        (ch_0_src_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_dst_width        (ch_0_dst_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_src_burst_size   (ch_0_src_burst_size   ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_priority         (ch_0_priority         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_src_addr         (ch_0_src_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_dst_addr         (ch_0_dst_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_0_src_bus_inf_idx  (ch_0_src_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_dst_bus_inf_idx  (ch_0_dst_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH0
	.ch_0_llp_reg          (ch_0_llp_reg          ), // (atcdmac300_register) => (atcdmac300_chmux)
	`endif // DMAC_CONFIG_CH0
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
       `ifdef DMAC_CONFIG_CH0
	.ch_0_lld_bus_inf_idx  (ch_0_lld_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	`endif //DMAC_CONFIG_CH0
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_0_tts              (ch_0_tts              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_0_abt              (ch_0_abt              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_en               (ch_1_en               ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_int_tc_mask      (ch_1_int_tc_mask      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_int_err_mask     (ch_1_int_err_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_int_abt_mask     (ch_1_int_abt_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_src_req_sel      (ch_1_src_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_dst_req_sel      (ch_1_dst_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_src_addr_ctl     (ch_1_src_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_dst_addr_ctl     (ch_1_dst_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_src_mode         (ch_1_src_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_dst_mode         (ch_1_dst_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_src_width        (ch_1_src_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_dst_width        (ch_1_dst_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_src_burst_size   (ch_1_src_burst_size   ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_priority         (ch_1_priority         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_src_addr         (ch_1_src_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_dst_addr         (ch_1_dst_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_1_src_bus_inf_idx  (ch_1_src_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_dst_bus_inf_idx  (ch_1_dst_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH1
	.ch_1_llp_reg          (ch_1_llp_reg          ), // (atcdmac300_register) => (atcdmac300_chmux)
	`endif // DMAC_CONFIG_CH1
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH1
	.ch_1_lld_bus_inf_idx  (ch_1_lld_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	   `endif // DMAC_CONFIG_CH1
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_1_tts              (ch_1_tts              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_1_abt              (ch_1_abt              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_en               (ch_2_en               ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_int_tc_mask      (ch_2_int_tc_mask      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_int_err_mask     (ch_2_int_err_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_int_abt_mask     (ch_2_int_abt_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_src_req_sel      (ch_2_src_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_dst_req_sel      (ch_2_dst_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_src_addr_ctl     (ch_2_src_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_dst_addr_ctl     (ch_2_dst_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_src_mode         (ch_2_src_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_dst_mode         (ch_2_dst_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_src_width        (ch_2_src_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_dst_width        (ch_2_dst_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_src_burst_size   (ch_2_src_burst_size   ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_priority         (ch_2_priority         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_src_addr         (ch_2_src_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_dst_addr         (ch_2_dst_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_2_src_bus_inf_idx  (ch_2_src_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_dst_bus_inf_idx  (ch_2_dst_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH2
	.ch_2_llp_reg          (ch_2_llp_reg          ), // (atcdmac300_register) => (atcdmac300_chmux)
        `endif // DMAC_CONFIG_CH2
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH2
	.ch_2_lld_bus_inf_idx  (ch_2_lld_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	`endif// DMAC_CONFIG_CH2
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_2_tts              (ch_2_tts              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_2_abt              (ch_2_abt              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_en               (ch_3_en               ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_int_tc_mask      (ch_3_int_tc_mask      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_int_err_mask     (ch_3_int_err_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_int_abt_mask     (ch_3_int_abt_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_src_req_sel      (ch_3_src_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_dst_req_sel      (ch_3_dst_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_src_addr_ctl     (ch_3_src_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_dst_addr_ctl     (ch_3_dst_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_src_mode         (ch_3_src_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_dst_mode         (ch_3_dst_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_src_width        (ch_3_src_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_dst_width        (ch_3_dst_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_src_burst_size   (ch_3_src_burst_size   ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_priority         (ch_3_priority         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_src_addr         (ch_3_src_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_dst_addr         (ch_3_dst_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_3_src_bus_inf_idx  (ch_3_src_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_dst_bus_inf_idx  (ch_3_dst_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH3
	.ch_3_llp_reg          (ch_3_llp_reg          ), // (atcdmac300_register) => (atcdmac300_chmux)
	 `endif // DMAC_CONFIG_CH3
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH3
	.ch_3_lld_bus_inf_idx  (ch_3_lld_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	   `endif// DMAC_CONFIG_CH3
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_3_tts              (ch_3_tts              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_3_abt              (ch_3_abt              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_en               (ch_4_en               ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_int_tc_mask      (ch_4_int_tc_mask      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_int_err_mask     (ch_4_int_err_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_int_abt_mask     (ch_4_int_abt_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_src_req_sel      (ch_4_src_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_dst_req_sel      (ch_4_dst_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_src_addr_ctl     (ch_4_src_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_dst_addr_ctl     (ch_4_dst_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_src_mode         (ch_4_src_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_dst_mode         (ch_4_dst_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_src_width        (ch_4_src_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_dst_width        (ch_4_dst_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_src_burst_size   (ch_4_src_burst_size   ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_priority         (ch_4_priority         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_src_addr         (ch_4_src_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_dst_addr         (ch_4_dst_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_4_src_bus_inf_idx  (ch_4_src_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_dst_bus_inf_idx  (ch_4_dst_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
        `ifdef DMAC_CONFIG_CH4
	.ch_4_llp_reg          (ch_4_llp_reg          ), // (atcdmac300_register) => (atcdmac300_chmux)
	`endif // DMAC_CONFIG_CH4
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH4
	.ch_4_lld_bus_inf_idx  (ch_4_lld_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	    `endif // DMAC_CONFIG_CH4
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_4_tts              (ch_4_tts              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_4_abt              (ch_4_abt              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_en               (ch_5_en               ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_int_tc_mask      (ch_5_int_tc_mask      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_int_err_mask     (ch_5_int_err_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_int_abt_mask     (ch_5_int_abt_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_src_req_sel      (ch_5_src_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_dst_req_sel      (ch_5_dst_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_src_addr_ctl     (ch_5_src_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_dst_addr_ctl     (ch_5_dst_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_src_mode         (ch_5_src_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_dst_mode         (ch_5_dst_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_src_width        (ch_5_src_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_dst_width        (ch_5_dst_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_src_burst_size   (ch_5_src_burst_size   ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_priority         (ch_5_priority         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_src_addr         (ch_5_src_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_dst_addr         (ch_5_dst_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_5_src_bus_inf_idx  (ch_5_src_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_dst_bus_inf_idx  (ch_5_dst_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH5
	.ch_5_llp_reg          (ch_5_llp_reg          ), // (atcdmac300_register) => (atcdmac300_chmux)
	`endif // DMAC_CONFIG_CH4
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH5
	.ch_5_lld_bus_inf_idx  (ch_5_lld_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	   `endif // DMAC_CONFIG_CH5
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_5_tts              (ch_5_tts              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_5_abt              (ch_5_abt              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_en               (ch_6_en               ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_int_tc_mask      (ch_6_int_tc_mask      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_int_err_mask     (ch_6_int_err_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_int_abt_mask     (ch_6_int_abt_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_src_req_sel      (ch_6_src_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_dst_req_sel      (ch_6_dst_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_src_addr_ctl     (ch_6_src_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_dst_addr_ctl     (ch_6_dst_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_src_mode         (ch_6_src_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_dst_mode         (ch_6_dst_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_src_width        (ch_6_src_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_dst_width        (ch_6_dst_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_src_burst_size   (ch_6_src_burst_size   ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_priority         (ch_6_priority         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_src_addr         (ch_6_src_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_dst_addr         (ch_6_dst_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_6_src_bus_inf_idx  (ch_6_src_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_dst_bus_inf_idx  (ch_6_dst_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH6
	.ch_6_llp_reg          (ch_6_llp_reg          ), // (atcdmac300_register) => (atcdmac300_chmux)
	 `endif // DMAC_CONFIG_CH6
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH6
	.ch_6_lld_bus_inf_idx  (ch_6_lld_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	    `endif // DMAC_CONFIG_CH6
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_6_tts              (ch_6_tts              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_6_abt              (ch_6_abt              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_en               (ch_7_en               ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_int_tc_mask      (ch_7_int_tc_mask      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_int_err_mask     (ch_7_int_err_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_int_abt_mask     (ch_7_int_abt_mask     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_src_req_sel      (ch_7_src_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_dst_req_sel      (ch_7_dst_req_sel      ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_src_addr_ctl     (ch_7_src_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_dst_addr_ctl     (ch_7_dst_addr_ctl     ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_src_mode         (ch_7_src_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_dst_mode         (ch_7_dst_mode         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_src_width        (ch_7_src_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_dst_width        (ch_7_dst_width        ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_src_burst_size   (ch_7_src_burst_size   ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_priority         (ch_7_priority         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_src_addr         (ch_7_src_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_dst_addr         (ch_7_dst_addr         ), // (atcdmac300_register) => (atcdmac300_chmux)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_7_src_bus_inf_idx  (ch_7_src_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_dst_bus_inf_idx  (ch_7_dst_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH7
	.ch_7_llp_reg          (ch_7_llp_reg          ), // (atcdmac300_register) => (atcdmac300_chmux)
	 `endif // DMAC_CONFIG_CH7
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH7
	.ch_7_lld_bus_inf_idx  (ch_7_lld_bus_inf_idx  ), // (atcdmac300_register) => (atcdmac300_chmux)
	    `endif // DMAC_CONFIG_CH7
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_7_tts              (ch_7_tts              ), // (atcdmac300_register) => (atcdmac300_chmux)
	.ch_7_abt              (ch_7_abt              ), // (atcdmac300_register) => (atcdmac300_chmux)
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
   `ifdef DMAC_CONFIG_CH0
	.dma1_ch_0_ctl_wen     (dma1_ch_0_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_0_en_wen      (dma1_ch_0_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_0_src_addr_wen(dma1_ch_0_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_0_dst_addr_wen(dma1_ch_0_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_0_llp_wen     (dma1_ch_0_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_0_tts_wen     (dma1_ch_0_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_0_tc_wen      (dma1_ch_0_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_0_err_wen     (dma1_ch_0_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_0_int_wen     (dma1_ch_0_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // DMAC_CONFIG_CH0
   `ifdef DMAC_CONFIG_CH1
	.dma1_ch_1_ctl_wen     (dma1_ch_1_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_1_en_wen      (dma1_ch_1_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_1_src_addr_wen(dma1_ch_1_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_1_dst_addr_wen(dma1_ch_1_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_1_llp_wen     (dma1_ch_1_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_1_tts_wen     (dma1_ch_1_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_1_tc_wen      (dma1_ch_1_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_1_err_wen     (dma1_ch_1_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_1_int_wen     (dma1_ch_1_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // DMAC_CONFIG_CH1
   `ifdef DMAC_CONFIG_CH2
	.dma1_ch_2_ctl_wen     (dma1_ch_2_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_2_en_wen      (dma1_ch_2_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_2_src_addr_wen(dma1_ch_2_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_2_dst_addr_wen(dma1_ch_2_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_2_llp_wen     (dma1_ch_2_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_2_tts_wen     (dma1_ch_2_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_2_tc_wen      (dma1_ch_2_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_2_err_wen     (dma1_ch_2_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_2_int_wen     (dma1_ch_2_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // DMAC_CONFIG_CH2
   `ifdef DMAC_CONFIG_CH3
	.dma1_ch_3_ctl_wen     (dma1_ch_3_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_3_en_wen      (dma1_ch_3_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_3_src_addr_wen(dma1_ch_3_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_3_dst_addr_wen(dma1_ch_3_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_3_llp_wen     (dma1_ch_3_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_3_tts_wen     (dma1_ch_3_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_3_tc_wen      (dma1_ch_3_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_3_err_wen     (dma1_ch_3_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_3_int_wen     (dma1_ch_3_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // DMAC_CONFIG_CH3
   `ifdef DMAC_CONFIG_CH4
	.dma1_ch_4_ctl_wen     (dma1_ch_4_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_4_en_wen      (dma1_ch_4_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_4_src_addr_wen(dma1_ch_4_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_4_dst_addr_wen(dma1_ch_4_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_4_llp_wen     (dma1_ch_4_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_4_tts_wen     (dma1_ch_4_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_4_tc_wen      (dma1_ch_4_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_4_err_wen     (dma1_ch_4_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_4_int_wen     (dma1_ch_4_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // DMAC_CONFIG_CH4
   `ifdef DMAC_CONFIG_CH5
	.dma1_ch_5_ctl_wen     (dma1_ch_5_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_5_en_wen      (dma1_ch_5_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_5_src_addr_wen(dma1_ch_5_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_5_dst_addr_wen(dma1_ch_5_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_5_llp_wen     (dma1_ch_5_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_5_tts_wen     (dma1_ch_5_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_5_tc_wen      (dma1_ch_5_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_5_err_wen     (dma1_ch_5_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_5_int_wen     (dma1_ch_5_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // DMAC_CONFIG_CH5
   `ifdef DMAC_CONFIG_CH6
	.dma1_ch_6_ctl_wen     (dma1_ch_6_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_6_en_wen      (dma1_ch_6_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_6_src_addr_wen(dma1_ch_6_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_6_dst_addr_wen(dma1_ch_6_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_6_llp_wen     (dma1_ch_6_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_6_tts_wen     (dma1_ch_6_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_6_tc_wen      (dma1_ch_6_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_6_err_wen     (dma1_ch_6_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_6_int_wen     (dma1_ch_6_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // DMAC_CONFIG_CH6
   `ifdef DMAC_CONFIG_CH7
	.dma1_ch_7_ctl_wen     (dma1_ch_7_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_7_en_wen      (dma1_ch_7_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_7_src_addr_wen(dma1_ch_7_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_7_dst_addr_wen(dma1_ch_7_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_7_llp_wen     (dma1_ch_7_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_7_tts_wen     (dma1_ch_7_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_7_tc_wen      (dma1_ch_7_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_7_err_wen     (dma1_ch_7_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma1_ch_7_int_wen     (dma1_ch_7_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // DMAC_CONFIG_CH7
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_llp_wdata     (dma1_ch_llp_wdata     ), // (atcdmac300_register) <= (atcdmac300_engine_1)
      `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma1_ch_llp_wdata_idx (dma1_ch_llp_wdata_idx ), // (atcdmac300_register) <= (atcdmac300_engine_1)
      `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_ctl_wdata     (dma1_ch_ctl_wdata     ), // (atcdmac300_register) <= (atcdmac300_engine_1)
	.dma1_ch_ctl_wdata_pri (dma1_ch_ctl_wdata_pri ), // (atcdmac300_register) <= (atcdmac300_engine_1)
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma1_ch_ctl_wdata_idx (dma1_ch_ctl_wdata_idx ), // (atcdmac300_register) <= (atcdmac300_engine_1)
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma1_ch_tts_wdata     (dma1_ch_tts_wdata     ), // (atcdmac300_register) <= (atcdmac300_engine_1)
	.dma1_ch_src_addr_wdata(dma1_ch_src_addr_wdata), // (atcdmac300_register) <= (atcdmac300_engine_1)
	.dma1_ch_dst_addr_wdata(dma1_ch_dst_addr_wdata), // (atcdmac300_register) <= (atcdmac300_engine_1)
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
`ifdef DMAC_CONFIG_CH0
	.dma0_ch_0_ctl_wen     (dma0_ch_0_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_0_en_wen      (dma0_ch_0_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_0_src_addr_wen(dma0_ch_0_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_0_dst_addr_wen(dma0_ch_0_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_0_llp_wen     (dma0_ch_0_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_0_tts_wen     (dma0_ch_0_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_0_tc_wen      (dma0_ch_0_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_0_err_wen     (dma0_ch_0_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_0_int_wen     (dma0_ch_0_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
`endif // DMAC_CONFIG_CH0
`ifdef DMAC_CONFIG_CH1
	.dma0_ch_1_ctl_wen     (dma0_ch_1_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_1_en_wen      (dma0_ch_1_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_1_src_addr_wen(dma0_ch_1_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_1_dst_addr_wen(dma0_ch_1_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_1_llp_wen     (dma0_ch_1_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_1_tts_wen     (dma0_ch_1_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_1_tc_wen      (dma0_ch_1_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_1_err_wen     (dma0_ch_1_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_1_int_wen     (dma0_ch_1_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
`endif // DMAC_CONFIG_CH1
`ifdef DMAC_CONFIG_CH2
	.dma0_ch_2_ctl_wen     (dma0_ch_2_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_2_en_wen      (dma0_ch_2_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_2_src_addr_wen(dma0_ch_2_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_2_dst_addr_wen(dma0_ch_2_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_2_llp_wen     (dma0_ch_2_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_2_tts_wen     (dma0_ch_2_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_2_tc_wen      (dma0_ch_2_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_2_err_wen     (dma0_ch_2_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_2_int_wen     (dma0_ch_2_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
`endif // DMAC_CONFIG_CH2
`ifdef DMAC_CONFIG_CH3
	.dma0_ch_3_ctl_wen     (dma0_ch_3_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_3_en_wen      (dma0_ch_3_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_3_src_addr_wen(dma0_ch_3_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_3_dst_addr_wen(dma0_ch_3_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_3_llp_wen     (dma0_ch_3_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_3_tts_wen     (dma0_ch_3_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_3_tc_wen      (dma0_ch_3_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_3_err_wen     (dma0_ch_3_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_3_int_wen     (dma0_ch_3_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
`endif // DMAC_CONFIG_CH3
`ifdef DMAC_CONFIG_CH4
	.dma0_ch_4_ctl_wen     (dma0_ch_4_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_4_en_wen      (dma0_ch_4_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_4_src_addr_wen(dma0_ch_4_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_4_dst_addr_wen(dma0_ch_4_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_4_llp_wen     (dma0_ch_4_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_4_tts_wen     (dma0_ch_4_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_4_tc_wen      (dma0_ch_4_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_4_err_wen     (dma0_ch_4_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_4_int_wen     (dma0_ch_4_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
`endif // DMAC_CONFIG_CH4
`ifdef DMAC_CONFIG_CH5
	.dma0_ch_5_ctl_wen     (dma0_ch_5_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_5_en_wen      (dma0_ch_5_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_5_src_addr_wen(dma0_ch_5_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_5_dst_addr_wen(dma0_ch_5_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_5_llp_wen     (dma0_ch_5_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_5_tts_wen     (dma0_ch_5_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_5_tc_wen      (dma0_ch_5_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_5_err_wen     (dma0_ch_5_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_5_int_wen     (dma0_ch_5_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
`endif // DMAC_CONFIG_CH5
`ifdef DMAC_CONFIG_CH6
	.dma0_ch_6_ctl_wen     (dma0_ch_6_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_6_en_wen      (dma0_ch_6_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_6_src_addr_wen(dma0_ch_6_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_6_dst_addr_wen(dma0_ch_6_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_6_llp_wen     (dma0_ch_6_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_6_tts_wen     (dma0_ch_6_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_6_tc_wen      (dma0_ch_6_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_6_err_wen     (dma0_ch_6_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_6_int_wen     (dma0_ch_6_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
`endif // DMAC_CONFIG_CH6
`ifdef DMAC_CONFIG_CH7
	.dma0_ch_7_ctl_wen     (dma0_ch_7_ctl_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_7_en_wen      (dma0_ch_7_en_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_7_src_addr_wen(dma0_ch_7_src_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_7_dst_addr_wen(dma0_ch_7_dst_addr_wen), // (atcdmac300_register) <= (atcdmac300_chmux)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_7_llp_wen     (dma0_ch_7_llp_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_7_tts_wen     (dma0_ch_7_tts_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_7_tc_wen      (dma0_ch_7_tc_wen      ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_7_err_wen     (dma0_ch_7_err_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
	.dma0_ch_7_int_wen     (dma0_ch_7_int_wen     ), // (atcdmac300_register) <= (atcdmac300_chmux)
`endif // DMAC_CONFIG_CH7
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_llp_wdata     (dma0_ch_llp_wdata     ), // (atcdmac300_register) <= (atcdmac300_engine_0)
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma0_ch_llp_wdata_idx (dma0_ch_llp_wdata_idx ), // (atcdmac300_register) <= (atcdmac300_engine_0)
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_ctl_wdata     (dma0_ch_ctl_wdata     ), // (atcdmac300_register) <= (atcdmac300_engine_0)
	.dma0_ch_ctl_wdata_pri (dma0_ch_ctl_wdata_pri ), // (atcdmac300_register) <= (atcdmac300_engine_0)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma0_ch_ctl_wdata_idx (dma0_ch_ctl_wdata_idx ), // (atcdmac300_register) <= (atcdmac300_engine_0)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma0_ch_tts_wdata     (dma0_ch_tts_wdata     ), // (atcdmac300_register) <= (atcdmac300_engine_0)
	.dma0_ch_src_addr_wdata(dma0_ch_src_addr_wdata), // (atcdmac300_register) <= (atcdmac300_engine_0)
	.dma0_ch_dst_addr_wdata(dma0_ch_dst_addr_wdata)  // (atcdmac300_register) <= (atcdmac300_engine_0)
); // end of atcdmac300_register

atcdmac300_chmux atcdmac300_chmux (
	.aclk                   (aclk                   ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.aresetn                (aresetn                ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.dma_req                (dma_req                ), // (atcdmac300_chmux) <= ()
	.dma_ack                (dma_ack                ), // (atcdmac300_chmux) => ()
	.dma_soft_reset         (dma_soft_reset         ), // (atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1) <= (atcdmac300_register)
	.ch_0_en                (ch_0_en                ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_int_tc_mask       (ch_0_int_tc_mask       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_int_err_mask      (ch_0_int_err_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_int_abt_mask      (ch_0_int_abt_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_src_req_sel       (ch_0_src_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_dst_req_sel       (ch_0_dst_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_src_addr_ctl      (ch_0_src_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_dst_addr_ctl      (ch_0_dst_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_src_mode          (ch_0_src_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_dst_mode          (ch_0_dst_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_src_width         (ch_0_src_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_dst_width         (ch_0_dst_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_src_burst_size    (ch_0_src_burst_size    ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_priority          (ch_0_priority          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_src_addr          (ch_0_src_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_dst_addr          (ch_0_dst_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_0_src_bus_inf_idx   (ch_0_src_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_dst_bus_inf_idx   (ch_0_dst_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH0
	.ch_0_llp_reg           (ch_0_llp_reg           ), // (atcdmac300_chmux) <= (atcdmac300_register)
	`endif // DMAC_CONFIG_CH7
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH0
	.ch_0_lld_bus_inf_idx   (ch_0_lld_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	   `endif // DMAC_CONFIG_CH0
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_0_tts               (ch_0_tts               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_0_abt               (ch_0_abt               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_en                (ch_1_en                ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_int_tc_mask       (ch_1_int_tc_mask       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_int_err_mask      (ch_1_int_err_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_int_abt_mask      (ch_1_int_abt_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_src_req_sel       (ch_1_src_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_dst_req_sel       (ch_1_dst_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_src_addr_ctl      (ch_1_src_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_dst_addr_ctl      (ch_1_dst_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_src_mode          (ch_1_src_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_dst_mode          (ch_1_dst_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_src_width         (ch_1_src_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_dst_width         (ch_1_dst_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_src_burst_size    (ch_1_src_burst_size    ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_priority          (ch_1_priority          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_src_addr          (ch_1_src_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_dst_addr          (ch_1_dst_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_1_src_bus_inf_idx   (ch_1_src_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_dst_bus_inf_idx   (ch_1_dst_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH1
	.ch_1_llp_reg           (ch_1_llp_reg           ), // (atcdmac300_chmux) <= (atcdmac300_register)
	`endif // DMAC_CONFIG_CH1
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH1
	.ch_1_lld_bus_inf_idx   (ch_1_lld_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	   `endif // DMAC_CONFIG_CH1
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_1_tts               (ch_1_tts               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_1_abt               (ch_1_abt               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_en                (ch_2_en                ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_int_tc_mask       (ch_2_int_tc_mask       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_int_err_mask      (ch_2_int_err_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_int_abt_mask      (ch_2_int_abt_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_src_req_sel       (ch_2_src_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_dst_req_sel       (ch_2_dst_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_src_addr_ctl      (ch_2_src_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_dst_addr_ctl      (ch_2_dst_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_src_mode          (ch_2_src_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_dst_mode          (ch_2_dst_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_src_width         (ch_2_src_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_dst_width         (ch_2_dst_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_src_burst_size    (ch_2_src_burst_size    ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_priority          (ch_2_priority          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_src_addr          (ch_2_src_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_dst_addr          (ch_2_dst_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_2_src_bus_inf_idx   (ch_2_src_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_dst_bus_inf_idx   (ch_2_dst_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH2
	.ch_2_llp_reg           (ch_2_llp_reg           ), // (atcdmac300_chmux) <= (atcdmac300_register)
	`endif // DMAC_CONFIG_CH2
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH2
	.ch_2_lld_bus_inf_idx   (ch_2_lld_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	   `endif // DMAC_CONFIG_CH2
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_2_tts               (ch_2_tts               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_2_abt               (ch_2_abt               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_en                (ch_3_en                ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_int_tc_mask       (ch_3_int_tc_mask       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_int_err_mask      (ch_3_int_err_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_int_abt_mask      (ch_3_int_abt_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_src_req_sel       (ch_3_src_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_dst_req_sel       (ch_3_dst_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_src_addr_ctl      (ch_3_src_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_dst_addr_ctl      (ch_3_dst_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_src_mode          (ch_3_src_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_dst_mode          (ch_3_dst_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_src_width         (ch_3_src_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_dst_width         (ch_3_dst_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_src_burst_size    (ch_3_src_burst_size    ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_priority          (ch_3_priority          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_src_addr          (ch_3_src_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_dst_addr          (ch_3_dst_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_3_src_bus_inf_idx   (ch_3_src_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_dst_bus_inf_idx   (ch_3_dst_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH3
	.ch_3_llp_reg           (ch_3_llp_reg           ), // (atcdmac300_chmux) <= (atcdmac300_register)
	`endif // DMAC_CONFIG_CH3
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	 `ifdef DMAC_CONFIG_CH3
	.ch_3_lld_bus_inf_idx   (ch_3_lld_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	  `endif // DMAC_CONFIG_CH3
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_3_tts               (ch_3_tts               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_3_abt               (ch_3_abt               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_en                (ch_4_en                ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_int_tc_mask       (ch_4_int_tc_mask       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_int_err_mask      (ch_4_int_err_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_int_abt_mask      (ch_4_int_abt_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_src_req_sel       (ch_4_src_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_dst_req_sel       (ch_4_dst_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_src_addr_ctl      (ch_4_src_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_dst_addr_ctl      (ch_4_dst_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_src_mode          (ch_4_src_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_dst_mode          (ch_4_dst_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_src_width         (ch_4_src_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_dst_width         (ch_4_dst_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_src_burst_size    (ch_4_src_burst_size    ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_priority          (ch_4_priority          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_src_addr          (ch_4_src_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_dst_addr          (ch_4_dst_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_4_src_bus_inf_idx   (ch_4_src_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_dst_bus_inf_idx   (ch_4_dst_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
        `ifdef DMAC_CONFIG_CH4
	.ch_4_llp_reg           (ch_4_llp_reg           ), // (atcdmac300_chmux) <= (atcdmac300_register)
	`endif // DMAC_CONFIG_CH4
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	 `ifdef DMAC_CONFIG_CH4
	.ch_4_lld_bus_inf_idx   (ch_4_lld_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	 `endif // DMAC_CONFIG_CH4
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_4_tts               (ch_4_tts               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_4_abt               (ch_4_abt               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_en                (ch_5_en                ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_int_tc_mask       (ch_5_int_tc_mask       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_int_err_mask      (ch_5_int_err_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_int_abt_mask      (ch_5_int_abt_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_src_req_sel       (ch_5_src_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_dst_req_sel       (ch_5_dst_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_src_addr_ctl      (ch_5_src_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_dst_addr_ctl      (ch_5_dst_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_src_mode          (ch_5_src_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_dst_mode          (ch_5_dst_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_src_width         (ch_5_src_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_dst_width         (ch_5_dst_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_src_burst_size    (ch_5_src_burst_size    ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_priority          (ch_5_priority          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_src_addr          (ch_5_src_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_dst_addr          (ch_5_dst_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_5_src_bus_inf_idx   (ch_5_src_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_dst_bus_inf_idx   (ch_5_dst_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH5
	.ch_5_llp_reg           (ch_5_llp_reg           ), // (atcdmac300_chmux) <= (atcdmac300_register)
	`endif // DMAC_CONFIG_CH5
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH5
	.ch_5_lld_bus_inf_idx   (ch_5_lld_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	   `endif // DMAC_CONFIG_CH5
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_5_tts               (ch_5_tts               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_5_abt               (ch_5_abt               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_en                (ch_6_en                ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_int_tc_mask       (ch_6_int_tc_mask       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_int_err_mask      (ch_6_int_err_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_int_abt_mask      (ch_6_int_abt_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_src_req_sel       (ch_6_src_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_dst_req_sel       (ch_6_dst_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_src_addr_ctl      (ch_6_src_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_dst_addr_ctl      (ch_6_dst_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_src_mode          (ch_6_src_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_dst_mode          (ch_6_dst_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_src_width         (ch_6_src_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_dst_width         (ch_6_dst_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_src_burst_size    (ch_6_src_burst_size    ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_priority          (ch_6_priority          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_src_addr          (ch_6_src_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_dst_addr          (ch_6_dst_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_6_src_bus_inf_idx   (ch_6_src_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_dst_bus_inf_idx   (ch_6_dst_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH6
	.ch_6_llp_reg           (ch_6_llp_reg           ), // (atcdmac300_chmux) <= (atcdmac300_register)
	`endif // DMAC_CONFIG_CH6
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH6
	.ch_6_lld_bus_inf_idx   (ch_6_lld_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	   `endif // DMAC_CONFIG_CH6
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_6_tts               (ch_6_tts               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_6_abt               (ch_6_abt               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_en                (ch_7_en                ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_int_tc_mask       (ch_7_int_tc_mask       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_int_err_mask      (ch_7_int_err_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_int_abt_mask      (ch_7_int_abt_mask      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_src_req_sel       (ch_7_src_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_dst_req_sel       (ch_7_dst_req_sel       ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_src_addr_ctl      (ch_7_src_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_dst_addr_ctl      (ch_7_dst_addr_ctl      ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_src_mode          (ch_7_src_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_dst_mode          (ch_7_dst_mode          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_src_width         (ch_7_src_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_dst_width         (ch_7_dst_width         ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_src_burst_size    (ch_7_src_burst_size    ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_priority          (ch_7_priority          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_src_addr          (ch_7_src_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_dst_addr          (ch_7_dst_addr          ), // (atcdmac300_chmux) <= (atcdmac300_register)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_7_src_bus_inf_idx   (ch_7_src_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_dst_bus_inf_idx   (ch_7_dst_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH7
	.ch_7_llp_reg           (ch_7_llp_reg           ), // (atcdmac300_chmux) <= (atcdmac300_register)
	`endif // DMAC_CONFIG_CH7
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	   `ifdef DMAC_CONFIG_CH7
	.ch_7_lld_bus_inf_idx   (ch_7_lld_bus_inf_idx   ), // (atcdmac300_chmux) <= (atcdmac300_register)
	   `endif // DMAC_CONFIG_CH7
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_7_tts               (ch_7_tts               ), // (atcdmac300_chmux) <= (atcdmac300_register)
	.ch_7_abt               (ch_7_abt               ), // (atcdmac300_chmux) <= (atcdmac300_register)
`ifdef DMAC_CONFIG_CH0
	.dma0_ch_0_ctl_wen      (dma0_ch_0_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_0_en_wen       (dma0_ch_0_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_0_src_addr_wen (dma0_ch_0_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_0_dst_addr_wen (dma0_ch_0_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_0_llp_wen      (dma0_ch_0_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_0_tts_wen      (dma0_ch_0_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_0_tc_wen       (dma0_ch_0_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_0_err_wen      (dma0_ch_0_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_0_int_wen      (dma0_ch_0_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
`endif // DMAC_CONFIG_CH0
`ifdef DMAC_CONFIG_CH1
	.dma0_ch_1_ctl_wen      (dma0_ch_1_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_1_en_wen       (dma0_ch_1_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_1_src_addr_wen (dma0_ch_1_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_1_dst_addr_wen (dma0_ch_1_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_1_llp_wen      (dma0_ch_1_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_1_tts_wen      (dma0_ch_1_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_1_tc_wen       (dma0_ch_1_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_1_err_wen      (dma0_ch_1_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_1_int_wen      (dma0_ch_1_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
`endif // DMAC_CONFIG_CH1
`ifdef DMAC_CONFIG_CH2
	.dma0_ch_2_ctl_wen      (dma0_ch_2_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_2_en_wen       (dma0_ch_2_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_2_src_addr_wen (dma0_ch_2_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_2_dst_addr_wen (dma0_ch_2_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_2_llp_wen      (dma0_ch_2_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_2_tts_wen      (dma0_ch_2_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_2_tc_wen       (dma0_ch_2_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_2_err_wen      (dma0_ch_2_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_2_int_wen      (dma0_ch_2_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
`endif // DMAC_CONFIG_CH2
`ifdef DMAC_CONFIG_CH3
	.dma0_ch_3_ctl_wen      (dma0_ch_3_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_3_en_wen       (dma0_ch_3_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_3_src_addr_wen (dma0_ch_3_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_3_dst_addr_wen (dma0_ch_3_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_3_llp_wen      (dma0_ch_3_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_3_tts_wen      (dma0_ch_3_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_3_tc_wen       (dma0_ch_3_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_3_err_wen      (dma0_ch_3_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_3_int_wen      (dma0_ch_3_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
`endif // DMAC_CONFIG_CH3
`ifdef DMAC_CONFIG_CH4
	.dma0_ch_4_ctl_wen      (dma0_ch_4_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_4_en_wen       (dma0_ch_4_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_4_src_addr_wen (dma0_ch_4_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_4_dst_addr_wen (dma0_ch_4_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_4_llp_wen      (dma0_ch_4_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_4_tts_wen      (dma0_ch_4_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_4_tc_wen       (dma0_ch_4_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_4_err_wen      (dma0_ch_4_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_4_int_wen      (dma0_ch_4_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
`endif // DMAC_CONFIG_CH4
`ifdef DMAC_CONFIG_CH5
	.dma0_ch_5_ctl_wen      (dma0_ch_5_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_5_en_wen       (dma0_ch_5_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_5_src_addr_wen (dma0_ch_5_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_5_dst_addr_wen (dma0_ch_5_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_5_llp_wen      (dma0_ch_5_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_5_tts_wen      (dma0_ch_5_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_5_tc_wen       (dma0_ch_5_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_5_err_wen      (dma0_ch_5_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_5_int_wen      (dma0_ch_5_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
`endif // DMAC_CONFIG_CH5
`ifdef DMAC_CONFIG_CH6
	.dma0_ch_6_ctl_wen      (dma0_ch_6_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_6_en_wen       (dma0_ch_6_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_6_src_addr_wen (dma0_ch_6_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_6_dst_addr_wen (dma0_ch_6_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_6_llp_wen      (dma0_ch_6_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_6_tts_wen      (dma0_ch_6_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_6_tc_wen       (dma0_ch_6_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_6_err_wen      (dma0_ch_6_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_6_int_wen      (dma0_ch_6_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
`endif // DMAC_CONFIG_CH6
`ifdef DMAC_CONFIG_CH7
	.dma0_ch_7_ctl_wen      (dma0_ch_7_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_7_en_wen       (dma0_ch_7_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_7_src_addr_wen (dma0_ch_7_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_7_dst_addr_wen (dma0_ch_7_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_7_llp_wen      (dma0_ch_7_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_7_tts_wen      (dma0_ch_7_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_7_tc_wen       (dma0_ch_7_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_7_err_wen      (dma0_ch_7_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma0_ch_7_int_wen      (dma0_ch_7_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
`endif // DMAC_CONFIG_CH7
	.granted_channel        (granted_channel        ), // (atcdmac300_chmux) <= (atcdmac300_arbiter)
	.ch_request             (ch_request             ), // (atcdmac300_chmux) => (atcdmac300_arbiter)
	.ch_level               (ch_level               ), // (atcdmac300_chmux) => (atcdmac300_arbiter)
	.current_channel        (current_channel        ), // (atcdmac300_chmux) => (atcdmac300_arbiter)
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	.dma1_idle_state        (dma1_idle_state        ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
	.dma1_ch_ctl_wen        (dma1_ch_ctl_wen        ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
	.dma1_ch_en_wen         (dma1_ch_en_wen         ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
	.dma1_ch_src_addr_wen   (dma1_ch_src_addr_wen   ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
	.dma1_ch_dst_addr_wen   (dma1_ch_dst_addr_wen   ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_llp_wen        (dma1_ch_llp_wen        ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_tts_wen        (dma1_ch_tts_wen        ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
	.dma1_ch_tc_wen         (dma1_ch_tc_wen         ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
	.dma1_ch_err_wen        (dma1_ch_err_wen        ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
	.dma1_ch_int_wen        (dma1_ch_int_wen        ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
	.dma1_ch_src_ack        (dma1_ch_src_ack        ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
	.dma1_ch_dst_ack        (dma1_ch_dst_ack        ), // (atcdmac300_chmux) <= (atcdmac300_engine_1)
	.dma1_arb_end           (dma1_arb_end           ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_current_channel   (dma1_current_channel   ), // (atcdmac300_chmux) => (atcdmac300_aximst_0,atcdmac300_aximst_1)
	.dma1_ch_src_addr_ctl   (dma1_ch_src_addr_ctl   ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_dst_addr_ctl   (dma1_ch_dst_addr_ctl   ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_src_width      (dma1_ch_src_width      ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_dst_width      (dma1_ch_dst_width      ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_src_burst_size (dma1_ch_src_burst_size ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_src_mode       (dma1_ch_src_mode       ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_src_request    (dma1_ch_src_request    ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_dst_mode       (dma1_ch_dst_mode       ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_dst_request    (dma1_ch_dst_request    ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_tts            (dma1_ch_tts            ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_src_addr       (dma1_ch_src_addr       ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_dst_addr       (dma1_ch_dst_addr       ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma1_ch_src_bus_inf_idx(dma1_ch_src_bus_inf_idx), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_dst_bus_inf_idx(dma1_ch_dst_bus_inf_idx), // (atcdmac300_chmux) => (atcdmac300_engine_1)
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_llp            (dma1_ch_llp            ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
      `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma1_ch_lld_bus_inf_idx(dma1_ch_lld_bus_inf_idx), // (atcdmac300_chmux) => (atcdmac300_engine_1)
      `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_abt            (dma1_ch_abt            ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_int_tc_mask    (dma1_ch_int_tc_mask    ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_int_err_mask   (dma1_ch_int_err_mask   ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
	.dma1_ch_int_abt_mask   (dma1_ch_int_abt_mask   ), // (atcdmac300_chmux) => (atcdmac300_engine_1)
   `ifdef DMAC_CONFIG_CH0
	.dma1_ch_0_ctl_wen      (dma1_ch_0_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_0_en_wen       (dma1_ch_0_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_0_src_addr_wen (dma1_ch_0_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_0_dst_addr_wen (dma1_ch_0_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_0_llp_wen      (dma1_ch_0_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_0_tts_wen      (dma1_ch_0_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_0_tc_wen       (dma1_ch_0_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_0_err_wen      (dma1_ch_0_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_0_int_wen      (dma1_ch_0_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // DMAC_CONFIG_CH0
   `ifdef DMAC_CONFIG_CH1
	.dma1_ch_1_ctl_wen      (dma1_ch_1_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_1_en_wen       (dma1_ch_1_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_1_src_addr_wen (dma1_ch_1_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_1_dst_addr_wen (dma1_ch_1_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_1_llp_wen      (dma1_ch_1_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_1_tts_wen      (dma1_ch_1_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_1_tc_wen       (dma1_ch_1_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_1_err_wen      (dma1_ch_1_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_1_int_wen      (dma1_ch_1_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // DMAC_CONFIG_CH1
   `ifdef DMAC_CONFIG_CH2
	.dma1_ch_2_ctl_wen      (dma1_ch_2_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_2_en_wen       (dma1_ch_2_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_2_src_addr_wen (dma1_ch_2_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_2_dst_addr_wen (dma1_ch_2_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_2_llp_wen      (dma1_ch_2_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_2_tts_wen      (dma1_ch_2_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_2_tc_wen       (dma1_ch_2_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_2_err_wen      (dma1_ch_2_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_2_int_wen      (dma1_ch_2_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // DMAC_CONFIG_CH2
   `ifdef DMAC_CONFIG_CH3
	.dma1_ch_3_ctl_wen      (dma1_ch_3_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_3_en_wen       (dma1_ch_3_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_3_src_addr_wen (dma1_ch_3_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_3_dst_addr_wen (dma1_ch_3_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_3_llp_wen      (dma1_ch_3_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_3_tts_wen      (dma1_ch_3_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_3_tc_wen       (dma1_ch_3_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_3_err_wen      (dma1_ch_3_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_3_int_wen      (dma1_ch_3_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // DMAC_CONFIG_CH3
   `ifdef DMAC_CONFIG_CH4
	.dma1_ch_4_ctl_wen      (dma1_ch_4_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_4_en_wen       (dma1_ch_4_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_4_src_addr_wen (dma1_ch_4_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_4_dst_addr_wen (dma1_ch_4_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_4_llp_wen      (dma1_ch_4_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_4_tts_wen      (dma1_ch_4_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_4_tc_wen       (dma1_ch_4_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_4_err_wen      (dma1_ch_4_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_4_int_wen      (dma1_ch_4_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // DMAC_CONFIG_CH4
   `ifdef DMAC_CONFIG_CH5
	.dma1_ch_5_ctl_wen      (dma1_ch_5_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_5_en_wen       (dma1_ch_5_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_5_src_addr_wen (dma1_ch_5_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_5_dst_addr_wen (dma1_ch_5_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_5_llp_wen      (dma1_ch_5_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_5_tts_wen      (dma1_ch_5_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_5_tc_wen       (dma1_ch_5_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_5_err_wen      (dma1_ch_5_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_5_int_wen      (dma1_ch_5_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // DMAC_CONFIG_CH5
   `ifdef DMAC_CONFIG_CH6
	.dma1_ch_6_ctl_wen      (dma1_ch_6_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_6_en_wen       (dma1_ch_6_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_6_src_addr_wen (dma1_ch_6_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_6_dst_addr_wen (dma1_ch_6_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_6_llp_wen      (dma1_ch_6_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_6_tts_wen      (dma1_ch_6_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_6_tc_wen       (dma1_ch_6_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_6_err_wen      (dma1_ch_6_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_6_int_wen      (dma1_ch_6_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // DMAC_CONFIG_CH6
   `ifdef DMAC_CONFIG_CH7
	.dma1_ch_7_ctl_wen      (dma1_ch_7_ctl_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_7_en_wen       (dma1_ch_7_en_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_7_src_addr_wen (dma1_ch_7_src_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_7_dst_addr_wen (dma1_ch_7_dst_addr_wen ), // (atcdmac300_chmux) => (atcdmac300_register)
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_7_llp_wen      (dma1_ch_7_llp_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
      `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_7_tts_wen      (dma1_ch_7_tts_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_7_tc_wen       (dma1_ch_7_tc_wen       ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_7_err_wen      (dma1_ch_7_err_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
	.dma1_ch_7_int_wen      (dma1_ch_7_int_wen      ), // (atcdmac300_chmux) => (atcdmac300_register)
   `endif // DMAC_CONFIG_CH7
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	.dma0_idle_state        (dma0_idle_state        ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
	.dma0_ch_ctl_wen        (dma0_ch_ctl_wen        ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
	.dma0_ch_en_wen         (dma0_ch_en_wen         ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
	.dma0_ch_src_addr_wen   (dma0_ch_src_addr_wen   ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
	.dma0_ch_dst_addr_wen   (dma0_ch_dst_addr_wen   ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_llp_wen        (dma0_ch_llp_wen        ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_tts_wen        (dma0_ch_tts_wen        ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
	.dma0_ch_tc_wen         (dma0_ch_tc_wen         ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
	.dma0_ch_err_wen        (dma0_ch_err_wen        ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
	.dma0_ch_int_wen        (dma0_ch_int_wen        ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
	.dma0_ch_src_ack        (dma0_ch_src_ack        ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
	.dma0_ch_dst_ack        (dma0_ch_dst_ack        ), // (atcdmac300_chmux) <= (atcdmac300_engine_0)
	.dma0_arb_end           (dma0_arb_end           ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_current_channel   (dma0_current_channel   ), // (atcdmac300_chmux) => (atcdmac300_aximst_0,atcdmac300_aximst_1)
	.dma0_ch_src_addr_ctl   (dma0_ch_src_addr_ctl   ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_dst_addr_ctl   (dma0_ch_dst_addr_ctl   ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_src_width      (dma0_ch_src_width      ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_dst_width      (dma0_ch_dst_width      ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_src_burst_size (dma0_ch_src_burst_size ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_src_mode       (dma0_ch_src_mode       ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_src_request    (dma0_ch_src_request    ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_dst_mode       (dma0_ch_dst_mode       ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_dst_request    (dma0_ch_dst_request    ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_tts            (dma0_ch_tts            ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_src_addr       (dma0_ch_src_addr       ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_dst_addr       (dma0_ch_dst_addr       ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma0_ch_src_bus_inf_idx(dma0_ch_src_bus_inf_idx), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_dst_bus_inf_idx(dma0_ch_dst_bus_inf_idx), // (atcdmac300_chmux) => (atcdmac300_engine_0)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_llp            (dma0_ch_llp            ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma0_ch_lld_bus_inf_idx(dma0_ch_lld_bus_inf_idx), // (atcdmac300_chmux) => (atcdmac300_engine_0)
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_abt            (dma0_ch_abt            ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_int_tc_mask    (dma0_ch_int_tc_mask    ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_int_err_mask   (dma0_ch_int_err_mask   ), // (atcdmac300_chmux) => (atcdmac300_engine_0)
	.dma0_ch_int_abt_mask   (dma0_ch_int_abt_mask   )  // (atcdmac300_chmux) => (atcdmac300_engine_0)
); // end of atcdmac300_chmux

atcdmac300_aximst atcdmac300_aximst_0 (
	.aclk                (aclk                ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.aresetn             (aresetn             ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.awid                (m0_awid             ), // (atcdmac300_aximst_0) => ()
	.awaddr              (m0_awaddr           ), // (atcdmac300_aximst_0) => ()
	.awlen               (m0_awlen            ), // (atcdmac300_aximst_0) => ()
	.awsize              (m0_awsize           ), // (atcdmac300_aximst_0) => ()
	.awburst             (m0_awburst          ), // (atcdmac300_aximst_0) => ()
	.awlock              (m0_awlock           ), // (atcdmac300_aximst_0) => ()
	.awcache             (m0_awcache          ), // (atcdmac300_aximst_0) => ()
	.awprot              (m0_awprot           ), // (atcdmac300_aximst_0) => ()
	.awvalid             (m0_awvalid          ), // (atcdmac300_aximst_0) => ()
	.awready             (m0_awready          ), // (atcdmac300_aximst_0) <= ()
	.wstrb               (m0_wstrb            ), // (atcdmac300_aximst_0) => ()
	.wlast               (m0_wlast            ), // (atcdmac300_aximst_0) => ()
	.wdata               (m0_wdata            ), // (atcdmac300_aximst_0) => ()
	.wvalid              (m0_wvalid           ), // (atcdmac300_aximst_0) => ()
	.wready              (m0_wready           ), // (atcdmac300_aximst_0) <= ()
	.bid                 (m0_bid              ), // (atcdmac300_aximst_0) <= ()
	.bresp               (m0_bresp            ), // (atcdmac300_aximst_0) <= ()
	.bvalid              (m0_bvalid           ), // (atcdmac300_aximst_0) <= ()
	.bready              (m0_bready           ), // (atcdmac300_aximst_0) => ()
	.arid                (m0_arid             ), // (atcdmac300_aximst_0) => ()
	.araddr              (m0_araddr           ), // (atcdmac300_aximst_0) => ()
	.arlen               (m0_arlen            ), // (atcdmac300_aximst_0) => ()
	.arsize              (m0_arsize           ), // (atcdmac300_aximst_0) => ()
	.arburst             (m0_arburst          ), // (atcdmac300_aximst_0) => ()
	.arlock              (m0_arlock           ), // (atcdmac300_aximst_0) => ()
	.arcache             (m0_arcache          ), // (atcdmac300_aximst_0) => ()
	.arprot              (m0_arprot           ), // (atcdmac300_aximst_0) => ()
	.arvalid             (m0_arvalid          ), // (atcdmac300_aximst_0) => ()
	.arready             (m0_arready          ), // (atcdmac300_aximst_0) <= ()
	.rid                 (m0_rid              ), // (atcdmac300_aximst_0) <= ()
	.rresp               (m0_rresp            ), // (atcdmac300_aximst_0) <= ()
	.rlast               (m0_rlast            ), // (atcdmac300_aximst_0) <= ()
	.rdata               (m0_rdata            ), // (atcdmac300_aximst_0) <= ()
	.rvalid              (m0_rvalid           ), // (atcdmac300_aximst_0) <= ()
	.rready              (m0_rready           ), // (atcdmac300_aximst_0) => ()
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	.dma1_mst_wr_mask    (dma1_mst_wr_mask    ), // (atcdmac300_aximst_0,atcdmac300_aximst_1) <= (atcdmac300_engine_1)
	.dma1_mst_req        (dma1_mst0_req       ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_1)
	.dma1_mst_addr       (dma1_mst0_addr      ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_1)
	.dma1_mst_write      (dma1_mst0_write     ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_1)
	.dma1_mst_size       (dma1_mst0_size      ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_1)
	.dma1_mst_fix        (dma1_mst0_fix       ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_1)
	.dma1_mst_len        (dma1_mst0_len       ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_1)
	.dma1_mst_wdata      (dma1_mst0_wdata     ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_1)
	.dma1_current_channel(dma1_current_channel), // (atcdmac300_aximst_0,atcdmac300_aximst_1) <= (atcdmac300_chmux)
	.mst_dma1_grant      (mst0_dma1_grant     ), // (atcdmac300_aximst_0) => (atcdmac300_engine_1)
	.mst_dma1_rd_ack     (mst0_dma1_rd_ack    ), // (atcdmac300_aximst_0) => (atcdmac300_engine_1)
	.mst_dma1_wr_ack     (mst0_dma1_wr_ack    ), // (atcdmac300_aximst_0) => (atcdmac300_engine_1)
	.mst_dma1_rdata      (mst0_dma1_rdata     ), // (atcdmac300_aximst_0) => (atcdmac300_engine_1)
	.mst_dma1_rlast      (mst0_dma1_rlast     ), // (atcdmac300_aximst_0) => (atcdmac300_engine_1)
	.mst_dma1_error      (mst0_dma1_error     ), // (atcdmac300_aximst_0) => (atcdmac300_engine_1)
	.mst_dma1_bvalid     (mst0_dma1_bvalid    ), // (atcdmac300_aximst_0) => (atcdmac300_engine_1)
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	.dma0_mst_wr_mask    (dma0_mst_wr_mask    ), // (atcdmac300_aximst_0,atcdmac300_aximst_1) <= (atcdmac300_engine_0)
	.dma0_mst_req        (dma0_mst0_req       ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_0)
	.dma0_mst_addr       (dma0_mst0_addr      ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_0)
	.dma0_mst_write      (dma0_mst0_write     ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_0)
	.dma0_mst_size       (dma0_mst0_size      ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_0)
	.dma0_mst_fix        (dma0_mst0_fix       ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_0)
	.dma0_mst_len        (dma0_mst0_len       ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_0)
	.dma0_mst_wdata      (dma0_mst0_wdata     ), // (atcdmac300_aximst_0) <= (atcdmac300_engine_0)
	.dma0_current_channel(dma0_current_channel), // (atcdmac300_aximst_0,atcdmac300_aximst_1) <= (atcdmac300_chmux)
	.mst_dma0_grant      (mst0_dma0_grant     ), // (atcdmac300_aximst_0) => (atcdmac300_engine_0)
	.mst_dma0_rd_ack     (mst0_dma0_rd_ack    ), // (atcdmac300_aximst_0) => (atcdmac300_engine_0)
	.mst_dma0_wr_ack     (mst0_dma0_wr_ack    ), // (atcdmac300_aximst_0) => (atcdmac300_engine_0)
	.mst_dma0_rdata      (mst0_dma0_rdata     ), // (atcdmac300_aximst_0) => (atcdmac300_engine_0)
	.mst_dma0_rlast      (mst0_dma0_rlast     ), // (atcdmac300_aximst_0) => (atcdmac300_engine_0)
	.mst_dma0_error      (mst0_dma0_error     ), // (atcdmac300_aximst_0) => (atcdmac300_engine_0)
	.mst_dma0_bvalid     (mst0_dma0_bvalid    )  // (atcdmac300_aximst_0) => (atcdmac300_engine_0)
); // end of atcdmac300_aximst_0

`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
atcdmac300_aximst atcdmac300_aximst_1 (
	.aclk                (aclk                ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.aresetn             (aresetn             ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.awid                (m1_awid             ), // (atcdmac300_aximst_1) => ()
	.awaddr              (m1_awaddr           ), // (atcdmac300_aximst_1) => ()
	.awlen               (m1_awlen            ), // (atcdmac300_aximst_1) => ()
	.awsize              (m1_awsize           ), // (atcdmac300_aximst_1) => ()
	.awburst             (m1_awburst          ), // (atcdmac300_aximst_1) => ()
	.awlock              (m1_awlock           ), // (atcdmac300_aximst_1) => ()
	.awcache             (m1_awcache          ), // (atcdmac300_aximst_1) => ()
	.awprot              (m1_awprot           ), // (atcdmac300_aximst_1) => ()
	.awvalid             (m1_awvalid          ), // (atcdmac300_aximst_1) => ()
	.awready             (m1_awready          ), // (atcdmac300_aximst_1) <= ()
	.wstrb               (m1_wstrb            ), // (atcdmac300_aximst_1) => ()
	.wlast               (m1_wlast            ), // (atcdmac300_aximst_1) => ()
	.wdata               (m1_wdata            ), // (atcdmac300_aximst_1) => ()
	.wvalid              (m1_wvalid           ), // (atcdmac300_aximst_1) => ()
	.wready              (m1_wready           ), // (atcdmac300_aximst_1) <= ()
	.bid                 (m1_bid              ), // (atcdmac300_aximst_1) <= ()
	.bresp               (m1_bresp            ), // (atcdmac300_aximst_1) <= ()
	.bvalid              (m1_bvalid           ), // (atcdmac300_aximst_1) <= ()
	.bready              (m1_bready           ), // (atcdmac300_aximst_1) => ()
	.arid                (m1_arid             ), // (atcdmac300_aximst_1) => ()
	.araddr              (m1_araddr           ), // (atcdmac300_aximst_1) => ()
	.arlen               (m1_arlen            ), // (atcdmac300_aximst_1) => ()
	.arsize              (m1_arsize           ), // (atcdmac300_aximst_1) => ()
	.arburst             (m1_arburst          ), // (atcdmac300_aximst_1) => ()
	.arlock              (m1_arlock           ), // (atcdmac300_aximst_1) => ()
	.arcache             (m1_arcache          ), // (atcdmac300_aximst_1) => ()
	.arprot              (m1_arprot           ), // (atcdmac300_aximst_1) => ()
	.arvalid             (m1_arvalid          ), // (atcdmac300_aximst_1) => ()
	.arready             (m1_arready          ), // (atcdmac300_aximst_1) <= ()
	.rid                 (m1_rid              ), // (atcdmac300_aximst_1) <= ()
	.rresp               (m1_rresp            ), // (atcdmac300_aximst_1) <= ()
	.rlast               (m1_rlast            ), // (atcdmac300_aximst_1) <= ()
	.rdata               (m1_rdata            ), // (atcdmac300_aximst_1) <= ()
	.rvalid              (m1_rvalid           ), // (atcdmac300_aximst_1) <= ()
	.rready              (m1_rready           ), // (atcdmac300_aximst_1) => ()
   `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	.dma1_mst_wr_mask    (dma1_mst_wr_mask    ), // (atcdmac300_aximst_0,atcdmac300_aximst_1) <= (atcdmac300_engine_1)
	.dma1_mst_req        (dma1_mst1_req       ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_1)
	.dma1_mst_addr       (dma1_mst1_addr      ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_1)
	.dma1_mst_write      (dma1_mst1_write     ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_1)
	.dma1_mst_size       (dma1_mst1_size      ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_1)
	.dma1_mst_fix        (dma1_mst1_fix       ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_1)
	.dma1_mst_len        (dma1_mst1_len       ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_1)
	.dma1_mst_wdata      (dma1_mst1_wdata     ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_1)
	.dma1_current_channel(dma1_current_channel), // (atcdmac300_aximst_0,atcdmac300_aximst_1) <= (atcdmac300_chmux)
	.mst_dma1_grant      (mst1_dma1_grant     ), // (atcdmac300_aximst_1) => (atcdmac300_engine_1)
	.mst_dma1_rd_ack     (mst1_dma1_rd_ack    ), // (atcdmac300_aximst_1) => (atcdmac300_engine_1)
	.mst_dma1_wr_ack     (mst1_dma1_wr_ack    ), // (atcdmac300_aximst_1) => (atcdmac300_engine_1)
	.mst_dma1_rdata      (mst1_dma1_rdata     ), // (atcdmac300_aximst_1) => (atcdmac300_engine_1)
	.mst_dma1_rlast      (mst1_dma1_rlast     ), // (atcdmac300_aximst_1) => (atcdmac300_engine_1)
	.mst_dma1_error      (mst1_dma1_error     ), // (atcdmac300_aximst_1) => (atcdmac300_engine_1)
	.mst_dma1_bvalid     (mst1_dma1_bvalid    ), // (atcdmac300_aximst_1) => (atcdmac300_engine_1)
   `endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	.dma0_mst_wr_mask    (dma0_mst_wr_mask    ), // (atcdmac300_aximst_0,atcdmac300_aximst_1) <= (atcdmac300_engine_0)
	.dma0_mst_req        (dma0_mst1_req       ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_0)
	.dma0_mst_addr       (dma0_mst1_addr      ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_0)
	.dma0_mst_write      (dma0_mst1_write     ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_0)
	.dma0_mst_size       (dma0_mst1_size      ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_0)
	.dma0_mst_fix        (dma0_mst1_fix       ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_0)
	.dma0_mst_len        (dma0_mst1_len       ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_0)
	.dma0_mst_wdata      (dma0_mst1_wdata     ), // (atcdmac300_aximst_1) <= (atcdmac300_engine_0)
	.dma0_current_channel(dma0_current_channel), // (atcdmac300_aximst_0,atcdmac300_aximst_1) <= (atcdmac300_chmux)
	.mst_dma0_grant      (mst1_dma0_grant     ), // (atcdmac300_aximst_1) => (atcdmac300_engine_0)
	.mst_dma0_rd_ack     (mst1_dma0_rd_ack    ), // (atcdmac300_aximst_1) => (atcdmac300_engine_0)
	.mst_dma0_wr_ack     (mst1_dma0_wr_ack    ), // (atcdmac300_aximst_1) => (atcdmac300_engine_0)
	.mst_dma0_rdata      (mst1_dma0_rdata     ), // (atcdmac300_aximst_1) => (atcdmac300_engine_0)
	.mst_dma0_rlast      (mst1_dma0_rlast     ), // (atcdmac300_aximst_1) => (atcdmac300_engine_0)
	.mst_dma0_error      (mst1_dma0_error     ), // (atcdmac300_aximst_1) => (atcdmac300_engine_0)
	.mst_dma0_bvalid     (mst1_dma0_bvalid    )  // (atcdmac300_aximst_1) => (atcdmac300_engine_0)
); // end of atcdmac300_aximst_1

`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
atcdmac300_engine atcdmac300_engine_0 (
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_mst1_req         (dma0_mst1_req          ), // (atcdmac300_engine_0) => (atcdmac300_aximst_1)
	.dma_mst1_addr        (dma0_mst1_addr         ), // (atcdmac300_engine_0) => (atcdmac300_aximst_1)
	.dma_mst1_write       (dma0_mst1_write        ), // (atcdmac300_engine_0) => (atcdmac300_aximst_1)
	.dma_mst1_size        (dma0_mst1_size         ), // (atcdmac300_engine_0) => (atcdmac300_aximst_1)
	.dma_mst1_fix         (dma0_mst1_fix          ), // (atcdmac300_engine_0) => (atcdmac300_aximst_1)
	.dma_mst1_wdata       (dma0_mst1_wdata        ), // (atcdmac300_engine_0) => (atcdmac300_aximst_1)
	.dma_mst1_len         (dma0_mst1_len          ), // (atcdmac300_engine_0) => (atcdmac300_aximst_1)
	.mst1_dma_grant       (mst1_dma0_grant        ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_1)
	.mst1_dma_rd_ack      (mst1_dma0_rd_ack       ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_1)
	.mst1_dma_wr_ack      (mst1_dma0_wr_ack       ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_1)
	.mst1_dma_rdata       (mst1_dma0_rdata        ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_1)
	.mst1_dma_rlast       (mst1_dma0_rlast        ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_1)
	.mst1_dma_bvalid      (mst1_dma0_bvalid       ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_1)
	.mst1_dma_error       (mst1_dma0_error        ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_1)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_mst0_req         (dma0_mst0_req          ), // (atcdmac300_engine_0) => (atcdmac300_aximst_0)
	.dma_mst_wr_mask      (dma0_mst_wr_mask       ), // (atcdmac300_engine_0) => (atcdmac300_aximst_0,atcdmac300_aximst_1)
	.dma_mst0_addr        (dma0_mst0_addr         ), // (atcdmac300_engine_0) => (atcdmac300_aximst_0)
	.dma_mst0_write       (dma0_mst0_write        ), // (atcdmac300_engine_0) => (atcdmac300_aximst_0)
	.dma_mst0_size        (dma0_mst0_size         ), // (atcdmac300_engine_0) => (atcdmac300_aximst_0)
	.dma_mst0_fix         (dma0_mst0_fix          ), // (atcdmac300_engine_0) => (atcdmac300_aximst_0)
	.dma_mst0_wdata       (dma0_mst0_wdata        ), // (atcdmac300_engine_0) => (atcdmac300_aximst_0)
	.dma_mst0_len         (dma0_mst0_len          ), // (atcdmac300_engine_0) => (atcdmac300_aximst_0)
	.mst0_dma_grant       (mst0_dma0_grant        ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_0)
	.mst0_dma_rd_ack      (mst0_dma0_rd_ack       ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_0)
	.mst0_dma_wr_ack      (mst0_dma0_wr_ack       ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_0)
	.mst0_dma_rdata       (mst0_dma0_rdata        ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_0)
	.mst0_dma_rlast       (mst0_dma0_rlast        ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_0)
	.mst0_dma_bvalid      (mst0_dma0_bvalid       ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_0)
	.mst0_dma_error       (mst0_dma0_error        ), // (atcdmac300_engine_0) <= (atcdmac300_aximst_0)
	.idle_state           (dma0_idle_state        ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
	.arb_end              (dma0_arb_end           ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_src_addr_ctl      (dma0_ch_src_addr_ctl   ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_dst_addr_ctl      (dma0_ch_dst_addr_ctl   ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_src_width         (dma0_ch_src_width      ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_dst_width         (dma0_ch_dst_width      ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_src_burst_size    (dma0_ch_src_burst_size ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_src_mode          (dma0_ch_src_mode       ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_src_request       (dma0_ch_src_request    ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_dst_mode          (dma0_ch_dst_mode       ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_dst_request       (dma0_ch_dst_request    ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_tts               (dma0_ch_tts            ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_src_addr          (dma0_ch_src_addr       ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_dst_addr          (dma0_ch_dst_addr       ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_int_tc_mask       (dma0_ch_int_tc_mask    ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_int_err_mask      (dma0_ch_int_err_mask   ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_int_abt_mask      (dma0_ch_int_abt_mask   ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_src_bus_inf_idx   (dma0_ch_src_bus_inf_idx), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.ch_dst_bus_inf_idx   (dma0_ch_dst_bus_inf_idx), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_llp               (dma0_ch_llp            ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_lld_bus_inf_idx   (dma0_ch_lld_bus_inf_idx), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_abt               (dma0_ch_abt            ), // (atcdmac300_engine_0) <= (atcdmac300_chmux)
	.dma_ch_src_ack       (dma0_ch_src_ack        ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
	.dma_ch_dst_ack       (dma0_ch_dst_ack        ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
	.dma_ch_ctl_wen       (dma0_ch_ctl_wen        ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
	.dma_ch_en_wen        (dma0_ch_en_wen         ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
	.dma_ch_src_addr_wen  (dma0_ch_src_addr_wen   ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
	.dma_ch_dst_addr_wen  (dma0_ch_dst_addr_wen   ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wen       (dma0_ch_llp_wen        ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma_ch_tts_wen       (dma0_ch_tts_wen        ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
	.dma_ch_tc_wen        (dma0_ch_tc_wen         ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
	.dma_ch_err_wen       (dma0_ch_err_wen        ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
	.dma_ch_int_wen       (dma0_ch_int_wen        ), // (atcdmac300_engine_0) => (atcdmac300_chmux)
	.dma_ch_ctl_wdata     (dma0_ch_ctl_wdata      ), // (atcdmac300_engine_0) => (atcdmac300_register)
	.dma_ch_ctl_wdata_pri (dma0_ch_ctl_wdata_pri  ), // (atcdmac300_engine_0) => (atcdmac300_register)
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_ch_ctl_wdata_idx (dma0_ch_ctl_wdata_idx  ), // (atcdmac300_engine_0) => (atcdmac300_register)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_ch_tts_wdata     (dma0_ch_tts_wdata      ), // (atcdmac300_engine_0) => (atcdmac300_register)
	.dma_ch_src_addr_wdata(dma0_ch_src_addr_wdata ), // (atcdmac300_engine_0) => (atcdmac300_register)
	.dma_ch_dst_addr_wdata(dma0_ch_dst_addr_wdata ), // (atcdmac300_engine_0) => (atcdmac300_register)
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wdata     (dma0_ch_llp_wdata      ), // (atcdmac300_engine_0) => (atcdmac300_register)
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_ch_llp_wdata_idx (dma0_ch_llp_wdata_idx  ), // (atcdmac300_engine_0) => (atcdmac300_register)
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.aclk                 (aclk                   ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.aresetn              (aresetn                ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.dma_soft_reset       (dma_soft_reset         )  // (atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1) <= (atcdmac300_register)
); // end of atcdmac300_engine_0

`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
atcdmac300_engine atcdmac300_engine_1 (
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_mst1_req         (dma1_mst1_req          ), // (atcdmac300_engine_1) => (atcdmac300_aximst_1)
	.dma_mst1_addr        (dma1_mst1_addr         ), // (atcdmac300_engine_1) => (atcdmac300_aximst_1)
	.dma_mst1_write       (dma1_mst1_write        ), // (atcdmac300_engine_1) => (atcdmac300_aximst_1)
	.dma_mst1_size        (dma1_mst1_size         ), // (atcdmac300_engine_1) => (atcdmac300_aximst_1)
	.dma_mst1_fix         (dma1_mst1_fix          ), // (atcdmac300_engine_1) => (atcdmac300_aximst_1)
	.dma_mst1_wdata       (dma1_mst1_wdata        ), // (atcdmac300_engine_1) => (atcdmac300_aximst_1)
	.dma_mst1_len         (dma1_mst1_len          ), // (atcdmac300_engine_1) => (atcdmac300_aximst_1)
	.mst1_dma_grant       (mst1_dma1_grant        ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_1)
	.mst1_dma_rd_ack      (mst1_dma1_rd_ack       ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_1)
	.mst1_dma_wr_ack      (mst1_dma1_wr_ack       ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_1)
	.mst1_dma_rdata       (mst1_dma1_rdata        ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_1)
	.mst1_dma_rlast       (mst1_dma1_rlast        ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_1)
	.mst1_dma_bvalid      (mst1_dma1_bvalid       ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_1)
	.mst1_dma_error       (mst1_dma1_error        ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_1)
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_mst0_req         (dma1_mst0_req          ), // (atcdmac300_engine_1) => (atcdmac300_aximst_0)
	.dma_mst_wr_mask      (dma1_mst_wr_mask       ), // (atcdmac300_engine_1) => (atcdmac300_aximst_0,atcdmac300_aximst_1)
	.dma_mst0_addr        (dma1_mst0_addr         ), // (atcdmac300_engine_1) => (atcdmac300_aximst_0)
	.dma_mst0_write       (dma1_mst0_write        ), // (atcdmac300_engine_1) => (atcdmac300_aximst_0)
	.dma_mst0_size        (dma1_mst0_size         ), // (atcdmac300_engine_1) => (atcdmac300_aximst_0)
	.dma_mst0_fix         (dma1_mst0_fix          ), // (atcdmac300_engine_1) => (atcdmac300_aximst_0)
	.dma_mst0_wdata       (dma1_mst0_wdata        ), // (atcdmac300_engine_1) => (atcdmac300_aximst_0)
	.dma_mst0_len         (dma1_mst0_len          ), // (atcdmac300_engine_1) => (atcdmac300_aximst_0)
	.mst0_dma_grant       (mst0_dma1_grant        ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_0)
	.mst0_dma_rd_ack      (mst0_dma1_rd_ack       ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_0)
	.mst0_dma_wr_ack      (mst0_dma1_wr_ack       ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_0)
	.mst0_dma_rdata       (mst0_dma1_rdata        ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_0)
	.mst0_dma_rlast       (mst0_dma1_rlast        ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_0)
	.mst0_dma_bvalid      (mst0_dma1_bvalid       ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_0)
	.mst0_dma_error       (mst0_dma1_error        ), // (atcdmac300_engine_1) <= (atcdmac300_aximst_0)
	.idle_state           (dma1_idle_state        ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
	.arb_end              (dma1_arb_end           ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_src_addr_ctl      (dma1_ch_src_addr_ctl   ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_dst_addr_ctl      (dma1_ch_dst_addr_ctl   ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_src_width         (dma1_ch_src_width      ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_dst_width         (dma1_ch_dst_width      ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_src_burst_size    (dma1_ch_src_burst_size ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_src_mode          (dma1_ch_src_mode       ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_src_request       (dma1_ch_src_request    ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_dst_mode          (dma1_ch_dst_mode       ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_dst_request       (dma1_ch_dst_request    ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_tts               (dma1_ch_tts            ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_src_addr          (dma1_ch_src_addr       ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_dst_addr          (dma1_ch_dst_addr       ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_int_tc_mask       (dma1_ch_int_tc_mask    ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_int_err_mask      (dma1_ch_int_err_mask   ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_int_abt_mask      (dma1_ch_int_abt_mask   ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_src_bus_inf_idx   (dma1_ch_src_bus_inf_idx), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.ch_dst_bus_inf_idx   (dma1_ch_dst_bus_inf_idx), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_llp               (dma1_ch_llp            ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
      `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_lld_bus_inf_idx   (dma1_ch_lld_bus_inf_idx), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
      `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_abt               (dma1_ch_abt            ), // (atcdmac300_engine_1) <= (atcdmac300_chmux)
	.dma_ch_src_ack       (dma1_ch_src_ack        ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
	.dma_ch_dst_ack       (dma1_ch_dst_ack        ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
	.dma_ch_ctl_wen       (dma1_ch_ctl_wen        ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
	.dma_ch_en_wen        (dma1_ch_en_wen         ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
	.dma_ch_src_addr_wen  (dma1_ch_src_addr_wen   ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
	.dma_ch_dst_addr_wen  (dma1_ch_dst_addr_wen   ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wen       (dma1_ch_llp_wen        ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma_ch_tts_wen       (dma1_ch_tts_wen        ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
	.dma_ch_tc_wen        (dma1_ch_tc_wen         ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
	.dma_ch_err_wen       (dma1_ch_err_wen        ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
	.dma_ch_int_wen       (dma1_ch_int_wen        ), // (atcdmac300_engine_1) => (atcdmac300_chmux)
	.dma_ch_ctl_wdata     (dma1_ch_ctl_wdata      ), // (atcdmac300_engine_1) => (atcdmac300_register)
	.dma_ch_ctl_wdata_pri (dma1_ch_ctl_wdata_pri  ), // (atcdmac300_engine_1) => (atcdmac300_register)
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_ch_ctl_wdata_idx (dma1_ch_ctl_wdata_idx  ), // (atcdmac300_engine_1) => (atcdmac300_register)
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_ch_tts_wdata     (dma1_ch_tts_wdata      ), // (atcdmac300_engine_1) => (atcdmac300_register)
	.dma_ch_src_addr_wdata(dma1_ch_src_addr_wdata ), // (atcdmac300_engine_1) => (atcdmac300_register)
	.dma_ch_dst_addr_wdata(dma1_ch_dst_addr_wdata ), // (atcdmac300_engine_1) => (atcdmac300_register)
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wdata     (dma1_ch_llp_wdata      ), // (atcdmac300_engine_1) => (atcdmac300_register)
      `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_ch_llp_wdata_idx (dma1_ch_llp_wdata_idx  ), // (atcdmac300_engine_1) => (atcdmac300_register)
      `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
   `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.aclk                 (aclk                   ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.aresetn              (aresetn                ), // (atcdmac300_aximst_0,atcdmac300_aximst_1,atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1,atcdmac300_register) <= ()
	.dma_soft_reset       (dma_soft_reset         )  // (atcdmac300_chmux,atcdmac300_engine_0,atcdmac300_engine_1) <= (atcdmac300_register)
); // end of atcdmac300_engine_1

`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
endmodule
// VPERL_GENERATED_END
