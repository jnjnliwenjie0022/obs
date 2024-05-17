`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

// VPERL_BEGIN
// &MODULE("atcbmc300_ds_axi");
// &PARAM("ADDR_WIDTH = 32");
// &PARAM("DATA_WIDTH = 64");
// &PARAM("ID_WIDTH = 4");
//
// &LOCALPARAM("ADDR_MSB = ADDR_WIDTH - 1");
// &LOCALPARAM("DATA_MSB = DATA_WIDTH - 1");
// &LOCALPARAM("ID_MSB = ID_WIDTH - 1");
//
// &PARAM("SLAVE_FIFO_DEPTH = 4");
// &INSTANCE("atcbmc300_ds_addr_ctrl.v","ds_aw_addr",{
//		ADDR_WIDTH => "ADDR_WIDTH",
//		DATA_WIDTH => "DATA_WIDTH",
//		  ID_WIDTH => "ID_WIDTH",
//	});
//	&CONNECT("ds_aw_addr", {
//		addr  => "ds_awaddr",
//		len   => "ds_awlen",
//		size  => "ds_awsize",
//		burst => "ds_awburst",
//		lock  => "ds_awlock",
//		cache => "ds_awcache",
//		prot  => "ds_awprot",
//		aready=> "ds_awready",
//		aid   => "ds_awid",
//		avalid=> "ds_awvalid",
//		slv_aready => "slv_awready",
//		arb_mid    => "slv_aw_mid",
//		addr_outstanding_en => "aw_addr_outstanding_en",
//		outstanding_ready => "aw_outstanding_ready",
//	});
// &FORCE("output","slv_aw_mid");
//
// &INSTANCE("atcbmc300_ds_wdata_bresp_ctrl.v","ds_wdata_bresp",{
//		DATA_WIDTH => "DATA_WIDTH",
//		  ID_WIDTH => "ID_WIDTH",
//       OUTSTANDING_DEPTH => "SLAVE_FIFO_DEPTH",
//	});
//	&CONNECT("ds_wdata_bresp", {
//		slv_aid             => "slv_aw_mid",
//		addr_outstanding_en => "aw_addr_outstanding_en",
//		outstanding_ready   => "aw_outstanding_ready",
//	});
// &INSTANCE("atcbmc300_ds_addr_ctrl.v","ds_ar_addr",{
//		ADDR_WIDTH => "ADDR_WIDTH",
//		DATA_WIDTH => "DATA_WIDTH",
//		  ID_WIDTH => "ID_WIDTH",
//	});
//	&CONNECT("ds_ar_addr", {
//		addr  => "ds_araddr",
//		len   => "ds_arlen",
//		size  => "ds_arsize",
//		burst => "ds_arburst",
//		lock  => "ds_arlock",
//		cache => "ds_arcache",
//		prot  => "ds_arprot",
//		aready=> "ds_arready",
//		aid   => "ds_arid",
//		avalid=> "ds_arvalid",
//		slv_aready => "slv_arready",
//		arb_mid    => "slv_ar_mid",
//		addr_outstanding_en => "ar_addr_outstanding_en",
//		outstanding_ready => "ar_outstanding_ready",
//	});
// &INSTANCE("atcbmc300_ds_rdata_ctrl.v","ds_rd_data",{
//		DATA_WIDTH => "DATA_WIDTH",
//		  ID_WIDTH => "ID_WIDTH",
//     OUTSTANDING_DEPTH => SLAVE_FIFO_DEPTH,
//	});
//	&CONNECT("ds_rd_data", {
//		addr_outstanding_en => "ar_addr_outstanding_en",
//		outstanding_ready => "ar_outstanding_ready",
//	});
//	for($i=0;$i<16;$i++) {
//		&CONNECT("ds_aw_addr.mst${i}_addr",  "mst${i}_awaddr");
//		&CONNECT("ds_aw_addr.mst${i}_len",   "mst${i}_awlen");
//		&CONNECT("ds_aw_addr.mst${i}_size",  "mst${i}_awsize");
//		&CONNECT("ds_aw_addr.mst${i}_burst", "mst${i}_awburst");
//		&CONNECT("ds_aw_addr.mst${i}_lock",  "mst${i}_awlock");
//		&CONNECT("ds_aw_addr.mst${i}_cache", "mst${i}_awcache");
//		&CONNECT("ds_aw_addr.mst${i}_prot",  "mst${i}_awprot");
//		&CONNECT("ds_aw_addr.mst${i}_avalid","mst${i}_awvalid");
//		&CONNECT("ds_aw_addr.mst${i}_aid",   "mst${i}_awid");
//		&CONNECT("ds_ar_addr.mst${i}_addr",  "mst${i}_araddr");
//		&CONNECT("ds_ar_addr.mst${i}_len",   "mst${i}_arlen");
//		&CONNECT("ds_ar_addr.mst${i}_size",  "mst${i}_arsize");
//		&CONNECT("ds_ar_addr.mst${i}_burst", "mst${i}_arburst");
//		&CONNECT("ds_ar_addr.mst${i}_lock",  "mst${i}_arlock");
//		&CONNECT("ds_ar_addr.mst${i}_cache", "mst${i}_arcache");
//		&CONNECT("ds_ar_addr.mst${i}_prot",  "mst${i}_arprot");
//		&CONNECT("ds_ar_addr.mst${i}_avalid","mst${i}_arvalid");
//		&CONNECT("ds_ar_addr.mst${i}_aid",   "mst${i}_arid");
//	}
// &ENDMODULE();
// VPERL_END

// VPERL_GENERATED_BEGIN
module atcbmc300_ds_axi (
`ifdef ATCBMC300_MST0_SUPPORT
	  mst0_araddr,            // (ds_ar_addr) <= ()
	  mst0_arburst,           // (ds_ar_addr) <= ()
	  mst0_arcache,           // (ds_ar_addr) <= ()
	  mst0_arid,              // (ds_ar_addr) <= ()
	  mst0_arlen,             // (ds_ar_addr) <= ()
	  mst0_arlock,            // (ds_ar_addr) <= ()
	  mst0_arprot,            // (ds_ar_addr) <= ()
	  mst0_arsize,            // (ds_ar_addr) <= ()
	  mst0_arvalid,           // (ds_ar_addr) <= ()
	  mst0_connect,           // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst0_awaddr,            // (ds_aw_addr) <= ()
	  mst0_awburst,           // (ds_aw_addr) <= ()
	  mst0_awcache,           // (ds_aw_addr) <= ()
	  mst0_awid,              // (ds_aw_addr) <= ()
	  mst0_awlen,             // (ds_aw_addr) <= ()
	  mst0_awlock,            // (ds_aw_addr) <= ()
	  mst0_awprot,            // (ds_aw_addr) <= ()
	  mst0_awsize,            // (ds_aw_addr) <= ()
	  mst0_awvalid,           // (ds_aw_addr) <= ()
	  mst0_rready,            // (ds_rd_data) <= ()
	  mst0_rsid,              // (ds_rd_data) <= ()
	  mst0_bready,            // (ds_wdata_bresp) <= ()
	  mst0_bsid,              // (ds_wdata_bresp) <= ()
	  mst0_wdata,             // (ds_wdata_bresp) <= ()
	  mst0_wlast,             // (ds_wdata_bresp) <= ()
	  mst0_wsid,              // (ds_wdata_bresp) <= ()
	  mst0_wstrb,             // (ds_wdata_bresp) <= ()
	  mst0_wvalid,            // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST0_SUPPORT
`ifdef ATCBMC300_MST1_SUPPORT
	  mst1_araddr,            // (ds_ar_addr) <= ()
	  mst1_arburst,           // (ds_ar_addr) <= ()
	  mst1_arcache,           // (ds_ar_addr) <= ()
	  mst1_arid,              // (ds_ar_addr) <= ()
	  mst1_arlen,             // (ds_ar_addr) <= ()
	  mst1_arlock,            // (ds_ar_addr) <= ()
	  mst1_arprot,            // (ds_ar_addr) <= ()
	  mst1_arsize,            // (ds_ar_addr) <= ()
	  mst1_arvalid,           // (ds_ar_addr) <= ()
	  mst1_connect,           // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst1_awaddr,            // (ds_aw_addr) <= ()
	  mst1_awburst,           // (ds_aw_addr) <= ()
	  mst1_awcache,           // (ds_aw_addr) <= ()
	  mst1_awid,              // (ds_aw_addr) <= ()
	  mst1_awlen,             // (ds_aw_addr) <= ()
	  mst1_awlock,            // (ds_aw_addr) <= ()
	  mst1_awprot,            // (ds_aw_addr) <= ()
	  mst1_awsize,            // (ds_aw_addr) <= ()
	  mst1_awvalid,           // (ds_aw_addr) <= ()
	  mst1_rready,            // (ds_rd_data) <= ()
	  mst1_rsid,              // (ds_rd_data) <= ()
	  mst1_bready,            // (ds_wdata_bresp) <= ()
	  mst1_bsid,              // (ds_wdata_bresp) <= ()
	  mst1_wdata,             // (ds_wdata_bresp) <= ()
	  mst1_wlast,             // (ds_wdata_bresp) <= ()
	  mst1_wsid,              // (ds_wdata_bresp) <= ()
	  mst1_wstrb,             // (ds_wdata_bresp) <= ()
	  mst1_wvalid,            // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST1_SUPPORT
`ifdef ATCBMC300_MST2_SUPPORT
	  mst2_araddr,            // (ds_ar_addr) <= ()
	  mst2_arburst,           // (ds_ar_addr) <= ()
	  mst2_arcache,           // (ds_ar_addr) <= ()
	  mst2_arid,              // (ds_ar_addr) <= ()
	  mst2_arlen,             // (ds_ar_addr) <= ()
	  mst2_arlock,            // (ds_ar_addr) <= ()
	  mst2_arprot,            // (ds_ar_addr) <= ()
	  mst2_arsize,            // (ds_ar_addr) <= ()
	  mst2_arvalid,           // (ds_ar_addr) <= ()
	  mst2_connect,           // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst2_awaddr,            // (ds_aw_addr) <= ()
	  mst2_awburst,           // (ds_aw_addr) <= ()
	  mst2_awcache,           // (ds_aw_addr) <= ()
	  mst2_awid,              // (ds_aw_addr) <= ()
	  mst2_awlen,             // (ds_aw_addr) <= ()
	  mst2_awlock,            // (ds_aw_addr) <= ()
	  mst2_awprot,            // (ds_aw_addr) <= ()
	  mst2_awsize,            // (ds_aw_addr) <= ()
	  mst2_awvalid,           // (ds_aw_addr) <= ()
	  mst2_rready,            // (ds_rd_data) <= ()
	  mst2_rsid,              // (ds_rd_data) <= ()
	  mst2_bready,            // (ds_wdata_bresp) <= ()
	  mst2_bsid,              // (ds_wdata_bresp) <= ()
	  mst2_wdata,             // (ds_wdata_bresp) <= ()
	  mst2_wlast,             // (ds_wdata_bresp) <= ()
	  mst2_wsid,              // (ds_wdata_bresp) <= ()
	  mst2_wstrb,             // (ds_wdata_bresp) <= ()
	  mst2_wvalid,            // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST2_SUPPORT
`ifdef ATCBMC300_MST3_SUPPORT
	  mst3_araddr,            // (ds_ar_addr) <= ()
	  mst3_arburst,           // (ds_ar_addr) <= ()
	  mst3_arcache,           // (ds_ar_addr) <= ()
	  mst3_arid,              // (ds_ar_addr) <= ()
	  mst3_arlen,             // (ds_ar_addr) <= ()
	  mst3_arlock,            // (ds_ar_addr) <= ()
	  mst3_arprot,            // (ds_ar_addr) <= ()
	  mst3_arsize,            // (ds_ar_addr) <= ()
	  mst3_arvalid,           // (ds_ar_addr) <= ()
	  mst3_connect,           // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst3_awaddr,            // (ds_aw_addr) <= ()
	  mst3_awburst,           // (ds_aw_addr) <= ()
	  mst3_awcache,           // (ds_aw_addr) <= ()
	  mst3_awid,              // (ds_aw_addr) <= ()
	  mst3_awlen,             // (ds_aw_addr) <= ()
	  mst3_awlock,            // (ds_aw_addr) <= ()
	  mst3_awprot,            // (ds_aw_addr) <= ()
	  mst3_awsize,            // (ds_aw_addr) <= ()
	  mst3_awvalid,           // (ds_aw_addr) <= ()
	  mst3_rready,            // (ds_rd_data) <= ()
	  mst3_rsid,              // (ds_rd_data) <= ()
	  mst3_bready,            // (ds_wdata_bresp) <= ()
	  mst3_bsid,              // (ds_wdata_bresp) <= ()
	  mst3_wdata,             // (ds_wdata_bresp) <= ()
	  mst3_wlast,             // (ds_wdata_bresp) <= ()
	  mst3_wsid,              // (ds_wdata_bresp) <= ()
	  mst3_wstrb,             // (ds_wdata_bresp) <= ()
	  mst3_wvalid,            // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST3_SUPPORT
`ifdef ATCBMC300_MST4_SUPPORT
	  mst4_araddr,            // (ds_ar_addr) <= ()
	  mst4_arburst,           // (ds_ar_addr) <= ()
	  mst4_arcache,           // (ds_ar_addr) <= ()
	  mst4_arid,              // (ds_ar_addr) <= ()
	  mst4_arlen,             // (ds_ar_addr) <= ()
	  mst4_arlock,            // (ds_ar_addr) <= ()
	  mst4_arprot,            // (ds_ar_addr) <= ()
	  mst4_arsize,            // (ds_ar_addr) <= ()
	  mst4_arvalid,           // (ds_ar_addr) <= ()
	  mst4_connect,           // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst4_awaddr,            // (ds_aw_addr) <= ()
	  mst4_awburst,           // (ds_aw_addr) <= ()
	  mst4_awcache,           // (ds_aw_addr) <= ()
	  mst4_awid,              // (ds_aw_addr) <= ()
	  mst4_awlen,             // (ds_aw_addr) <= ()
	  mst4_awlock,            // (ds_aw_addr) <= ()
	  mst4_awprot,            // (ds_aw_addr) <= ()
	  mst4_awsize,            // (ds_aw_addr) <= ()
	  mst4_awvalid,           // (ds_aw_addr) <= ()
	  mst4_rready,            // (ds_rd_data) <= ()
	  mst4_rsid,              // (ds_rd_data) <= ()
	  mst4_bready,            // (ds_wdata_bresp) <= ()
	  mst4_bsid,              // (ds_wdata_bresp) <= ()
	  mst4_wdata,             // (ds_wdata_bresp) <= ()
	  mst4_wlast,             // (ds_wdata_bresp) <= ()
	  mst4_wsid,              // (ds_wdata_bresp) <= ()
	  mst4_wstrb,             // (ds_wdata_bresp) <= ()
	  mst4_wvalid,            // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST4_SUPPORT
`ifdef ATCBMC300_MST5_SUPPORT
	  mst5_araddr,            // (ds_ar_addr) <= ()
	  mst5_arburst,           // (ds_ar_addr) <= ()
	  mst5_arcache,           // (ds_ar_addr) <= ()
	  mst5_arid,              // (ds_ar_addr) <= ()
	  mst5_arlen,             // (ds_ar_addr) <= ()
	  mst5_arlock,            // (ds_ar_addr) <= ()
	  mst5_arprot,            // (ds_ar_addr) <= ()
	  mst5_arsize,            // (ds_ar_addr) <= ()
	  mst5_arvalid,           // (ds_ar_addr) <= ()
	  mst5_connect,           // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst5_awaddr,            // (ds_aw_addr) <= ()
	  mst5_awburst,           // (ds_aw_addr) <= ()
	  mst5_awcache,           // (ds_aw_addr) <= ()
	  mst5_awid,              // (ds_aw_addr) <= ()
	  mst5_awlen,             // (ds_aw_addr) <= ()
	  mst5_awlock,            // (ds_aw_addr) <= ()
	  mst5_awprot,            // (ds_aw_addr) <= ()
	  mst5_awsize,            // (ds_aw_addr) <= ()
	  mst5_awvalid,           // (ds_aw_addr) <= ()
	  mst5_rready,            // (ds_rd_data) <= ()
	  mst5_rsid,              // (ds_rd_data) <= ()
	  mst5_bready,            // (ds_wdata_bresp) <= ()
	  mst5_bsid,              // (ds_wdata_bresp) <= ()
	  mst5_wdata,             // (ds_wdata_bresp) <= ()
	  mst5_wlast,             // (ds_wdata_bresp) <= ()
	  mst5_wsid,              // (ds_wdata_bresp) <= ()
	  mst5_wstrb,             // (ds_wdata_bresp) <= ()
	  mst5_wvalid,            // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST5_SUPPORT
`ifdef ATCBMC300_MST6_SUPPORT
	  mst6_araddr,            // (ds_ar_addr) <= ()
	  mst6_arburst,           // (ds_ar_addr) <= ()
	  mst6_arcache,           // (ds_ar_addr) <= ()
	  mst6_arid,              // (ds_ar_addr) <= ()
	  mst6_arlen,             // (ds_ar_addr) <= ()
	  mst6_arlock,            // (ds_ar_addr) <= ()
	  mst6_arprot,            // (ds_ar_addr) <= ()
	  mst6_arsize,            // (ds_ar_addr) <= ()
	  mst6_arvalid,           // (ds_ar_addr) <= ()
	  mst6_connect,           // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst6_awaddr,            // (ds_aw_addr) <= ()
	  mst6_awburst,           // (ds_aw_addr) <= ()
	  mst6_awcache,           // (ds_aw_addr) <= ()
	  mst6_awid,              // (ds_aw_addr) <= ()
	  mst6_awlen,             // (ds_aw_addr) <= ()
	  mst6_awlock,            // (ds_aw_addr) <= ()
	  mst6_awprot,            // (ds_aw_addr) <= ()
	  mst6_awsize,            // (ds_aw_addr) <= ()
	  mst6_awvalid,           // (ds_aw_addr) <= ()
	  mst6_rready,            // (ds_rd_data) <= ()
	  mst6_rsid,              // (ds_rd_data) <= ()
	  mst6_bready,            // (ds_wdata_bresp) <= ()
	  mst6_bsid,              // (ds_wdata_bresp) <= ()
	  mst6_wdata,             // (ds_wdata_bresp) <= ()
	  mst6_wlast,             // (ds_wdata_bresp) <= ()
	  mst6_wsid,              // (ds_wdata_bresp) <= ()
	  mst6_wstrb,             // (ds_wdata_bresp) <= ()
	  mst6_wvalid,            // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST6_SUPPORT
`ifdef ATCBMC300_MST7_SUPPORT
	  mst7_araddr,            // (ds_ar_addr) <= ()
	  mst7_arburst,           // (ds_ar_addr) <= ()
	  mst7_arcache,           // (ds_ar_addr) <= ()
	  mst7_arid,              // (ds_ar_addr) <= ()
	  mst7_arlen,             // (ds_ar_addr) <= ()
	  mst7_arlock,            // (ds_ar_addr) <= ()
	  mst7_arprot,            // (ds_ar_addr) <= ()
	  mst7_arsize,            // (ds_ar_addr) <= ()
	  mst7_arvalid,           // (ds_ar_addr) <= ()
	  mst7_connect,           // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst7_awaddr,            // (ds_aw_addr) <= ()
	  mst7_awburst,           // (ds_aw_addr) <= ()
	  mst7_awcache,           // (ds_aw_addr) <= ()
	  mst7_awid,              // (ds_aw_addr) <= ()
	  mst7_awlen,             // (ds_aw_addr) <= ()
	  mst7_awlock,            // (ds_aw_addr) <= ()
	  mst7_awprot,            // (ds_aw_addr) <= ()
	  mst7_awsize,            // (ds_aw_addr) <= ()
	  mst7_awvalid,           // (ds_aw_addr) <= ()
	  mst7_rready,            // (ds_rd_data) <= ()
	  mst7_rsid,              // (ds_rd_data) <= ()
	  mst7_bready,            // (ds_wdata_bresp) <= ()
	  mst7_bsid,              // (ds_wdata_bresp) <= ()
	  mst7_wdata,             // (ds_wdata_bresp) <= ()
	  mst7_wlast,             // (ds_wdata_bresp) <= ()
	  mst7_wsid,              // (ds_wdata_bresp) <= ()
	  mst7_wstrb,             // (ds_wdata_bresp) <= ()
	  mst7_wvalid,            // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST7_SUPPORT
`ifdef ATCBMC300_MST8_SUPPORT
	  mst8_araddr,            // (ds_ar_addr) <= ()
	  mst8_arburst,           // (ds_ar_addr) <= ()
	  mst8_arcache,           // (ds_ar_addr) <= ()
	  mst8_arid,              // (ds_ar_addr) <= ()
	  mst8_arlen,             // (ds_ar_addr) <= ()
	  mst8_arlock,            // (ds_ar_addr) <= ()
	  mst8_arprot,            // (ds_ar_addr) <= ()
	  mst8_arsize,            // (ds_ar_addr) <= ()
	  mst8_arvalid,           // (ds_ar_addr) <= ()
	  mst8_connect,           // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst8_awaddr,            // (ds_aw_addr) <= ()
	  mst8_awburst,           // (ds_aw_addr) <= ()
	  mst8_awcache,           // (ds_aw_addr) <= ()
	  mst8_awid,              // (ds_aw_addr) <= ()
	  mst8_awlen,             // (ds_aw_addr) <= ()
	  mst8_awlock,            // (ds_aw_addr) <= ()
	  mst8_awprot,            // (ds_aw_addr) <= ()
	  mst8_awsize,            // (ds_aw_addr) <= ()
	  mst8_awvalid,           // (ds_aw_addr) <= ()
	  mst8_rready,            // (ds_rd_data) <= ()
	  mst8_rsid,              // (ds_rd_data) <= ()
	  mst8_bready,            // (ds_wdata_bresp) <= ()
	  mst8_bsid,              // (ds_wdata_bresp) <= ()
	  mst8_wdata,             // (ds_wdata_bresp) <= ()
	  mst8_wlast,             // (ds_wdata_bresp) <= ()
	  mst8_wsid,              // (ds_wdata_bresp) <= ()
	  mst8_wstrb,             // (ds_wdata_bresp) <= ()
	  mst8_wvalid,            // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST8_SUPPORT
`ifdef ATCBMC300_MST9_SUPPORT
	  mst9_araddr,            // (ds_ar_addr) <= ()
	  mst9_arburst,           // (ds_ar_addr) <= ()
	  mst9_arcache,           // (ds_ar_addr) <= ()
	  mst9_arid,              // (ds_ar_addr) <= ()
	  mst9_arlen,             // (ds_ar_addr) <= ()
	  mst9_arlock,            // (ds_ar_addr) <= ()
	  mst9_arprot,            // (ds_ar_addr) <= ()
	  mst9_arsize,            // (ds_ar_addr) <= ()
	  mst9_arvalid,           // (ds_ar_addr) <= ()
	  mst9_connect,           // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst9_awaddr,            // (ds_aw_addr) <= ()
	  mst9_awburst,           // (ds_aw_addr) <= ()
	  mst9_awcache,           // (ds_aw_addr) <= ()
	  mst9_awid,              // (ds_aw_addr) <= ()
	  mst9_awlen,             // (ds_aw_addr) <= ()
	  mst9_awlock,            // (ds_aw_addr) <= ()
	  mst9_awprot,            // (ds_aw_addr) <= ()
	  mst9_awsize,            // (ds_aw_addr) <= ()
	  mst9_awvalid,           // (ds_aw_addr) <= ()
	  mst9_rready,            // (ds_rd_data) <= ()
	  mst9_rsid,              // (ds_rd_data) <= ()
	  mst9_bready,            // (ds_wdata_bresp) <= ()
	  mst9_bsid,              // (ds_wdata_bresp) <= ()
	  mst9_wdata,             // (ds_wdata_bresp) <= ()
	  mst9_wlast,             // (ds_wdata_bresp) <= ()
	  mst9_wsid,              // (ds_wdata_bresp) <= ()
	  mst9_wstrb,             // (ds_wdata_bresp) <= ()
	  mst9_wvalid,            // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST9_SUPPORT
`ifdef ATCBMC300_MST10_SUPPORT
	  mst10_araddr,           // (ds_ar_addr) <= ()
	  mst10_arburst,          // (ds_ar_addr) <= ()
	  mst10_arcache,          // (ds_ar_addr) <= ()
	  mst10_arid,             // (ds_ar_addr) <= ()
	  mst10_arlen,            // (ds_ar_addr) <= ()
	  mst10_arlock,           // (ds_ar_addr) <= ()
	  mst10_arprot,           // (ds_ar_addr) <= ()
	  mst10_arsize,           // (ds_ar_addr) <= ()
	  mst10_arvalid,          // (ds_ar_addr) <= ()
	  mst10_connect,          // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst10_awaddr,           // (ds_aw_addr) <= ()
	  mst10_awburst,          // (ds_aw_addr) <= ()
	  mst10_awcache,          // (ds_aw_addr) <= ()
	  mst10_awid,             // (ds_aw_addr) <= ()
	  mst10_awlen,            // (ds_aw_addr) <= ()
	  mst10_awlock,           // (ds_aw_addr) <= ()
	  mst10_awprot,           // (ds_aw_addr) <= ()
	  mst10_awsize,           // (ds_aw_addr) <= ()
	  mst10_awvalid,          // (ds_aw_addr) <= ()
	  mst10_rready,           // (ds_rd_data) <= ()
	  mst10_rsid,             // (ds_rd_data) <= ()
	  mst10_bready,           // (ds_wdata_bresp) <= ()
	  mst10_bsid,             // (ds_wdata_bresp) <= ()
	  mst10_wdata,            // (ds_wdata_bresp) <= ()
	  mst10_wlast,            // (ds_wdata_bresp) <= ()
	  mst10_wsid,             // (ds_wdata_bresp) <= ()
	  mst10_wstrb,            // (ds_wdata_bresp) <= ()
	  mst10_wvalid,           // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST10_SUPPORT
`ifdef ATCBMC300_MST11_SUPPORT
	  mst11_araddr,           // (ds_ar_addr) <= ()
	  mst11_arburst,          // (ds_ar_addr) <= ()
	  mst11_arcache,          // (ds_ar_addr) <= ()
	  mst11_arid,             // (ds_ar_addr) <= ()
	  mst11_arlen,            // (ds_ar_addr) <= ()
	  mst11_arlock,           // (ds_ar_addr) <= ()
	  mst11_arprot,           // (ds_ar_addr) <= ()
	  mst11_arsize,           // (ds_ar_addr) <= ()
	  mst11_arvalid,          // (ds_ar_addr) <= ()
	  mst11_connect,          // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst11_awaddr,           // (ds_aw_addr) <= ()
	  mst11_awburst,          // (ds_aw_addr) <= ()
	  mst11_awcache,          // (ds_aw_addr) <= ()
	  mst11_awid,             // (ds_aw_addr) <= ()
	  mst11_awlen,            // (ds_aw_addr) <= ()
	  mst11_awlock,           // (ds_aw_addr) <= ()
	  mst11_awprot,           // (ds_aw_addr) <= ()
	  mst11_awsize,           // (ds_aw_addr) <= ()
	  mst11_awvalid,          // (ds_aw_addr) <= ()
	  mst11_rready,           // (ds_rd_data) <= ()
	  mst11_rsid,             // (ds_rd_data) <= ()
	  mst11_bready,           // (ds_wdata_bresp) <= ()
	  mst11_bsid,             // (ds_wdata_bresp) <= ()
	  mst11_wdata,            // (ds_wdata_bresp) <= ()
	  mst11_wlast,            // (ds_wdata_bresp) <= ()
	  mst11_wsid,             // (ds_wdata_bresp) <= ()
	  mst11_wstrb,            // (ds_wdata_bresp) <= ()
	  mst11_wvalid,           // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST11_SUPPORT
`ifdef ATCBMC300_MST12_SUPPORT
	  mst12_araddr,           // (ds_ar_addr) <= ()
	  mst12_arburst,          // (ds_ar_addr) <= ()
	  mst12_arcache,          // (ds_ar_addr) <= ()
	  mst12_arid,             // (ds_ar_addr) <= ()
	  mst12_arlen,            // (ds_ar_addr) <= ()
	  mst12_arlock,           // (ds_ar_addr) <= ()
	  mst12_arprot,           // (ds_ar_addr) <= ()
	  mst12_arsize,           // (ds_ar_addr) <= ()
	  mst12_arvalid,          // (ds_ar_addr) <= ()
	  mst12_connect,          // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst12_awaddr,           // (ds_aw_addr) <= ()
	  mst12_awburst,          // (ds_aw_addr) <= ()
	  mst12_awcache,          // (ds_aw_addr) <= ()
	  mst12_awid,             // (ds_aw_addr) <= ()
	  mst12_awlen,            // (ds_aw_addr) <= ()
	  mst12_awlock,           // (ds_aw_addr) <= ()
	  mst12_awprot,           // (ds_aw_addr) <= ()
	  mst12_awsize,           // (ds_aw_addr) <= ()
	  mst12_awvalid,          // (ds_aw_addr) <= ()
	  mst12_rready,           // (ds_rd_data) <= ()
	  mst12_rsid,             // (ds_rd_data) <= ()
	  mst12_bready,           // (ds_wdata_bresp) <= ()
	  mst12_bsid,             // (ds_wdata_bresp) <= ()
	  mst12_wdata,            // (ds_wdata_bresp) <= ()
	  mst12_wlast,            // (ds_wdata_bresp) <= ()
	  mst12_wsid,             // (ds_wdata_bresp) <= ()
	  mst12_wstrb,            // (ds_wdata_bresp) <= ()
	  mst12_wvalid,           // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST12_SUPPORT
`ifdef ATCBMC300_MST13_SUPPORT
	  mst13_araddr,           // (ds_ar_addr) <= ()
	  mst13_arburst,          // (ds_ar_addr) <= ()
	  mst13_arcache,          // (ds_ar_addr) <= ()
	  mst13_arid,             // (ds_ar_addr) <= ()
	  mst13_arlen,            // (ds_ar_addr) <= ()
	  mst13_arlock,           // (ds_ar_addr) <= ()
	  mst13_arprot,           // (ds_ar_addr) <= ()
	  mst13_arsize,           // (ds_ar_addr) <= ()
	  mst13_arvalid,          // (ds_ar_addr) <= ()
	  mst13_connect,          // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst13_awaddr,           // (ds_aw_addr) <= ()
	  mst13_awburst,          // (ds_aw_addr) <= ()
	  mst13_awcache,          // (ds_aw_addr) <= ()
	  mst13_awid,             // (ds_aw_addr) <= ()
	  mst13_awlen,            // (ds_aw_addr) <= ()
	  mst13_awlock,           // (ds_aw_addr) <= ()
	  mst13_awprot,           // (ds_aw_addr) <= ()
	  mst13_awsize,           // (ds_aw_addr) <= ()
	  mst13_awvalid,          // (ds_aw_addr) <= ()
	  mst13_rready,           // (ds_rd_data) <= ()
	  mst13_rsid,             // (ds_rd_data) <= ()
	  mst13_bready,           // (ds_wdata_bresp) <= ()
	  mst13_bsid,             // (ds_wdata_bresp) <= ()
	  mst13_wdata,            // (ds_wdata_bresp) <= ()
	  mst13_wlast,            // (ds_wdata_bresp) <= ()
	  mst13_wsid,             // (ds_wdata_bresp) <= ()
	  mst13_wstrb,            // (ds_wdata_bresp) <= ()
	  mst13_wvalid,           // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST13_SUPPORT
`ifdef ATCBMC300_MST14_SUPPORT
	  mst14_araddr,           // (ds_ar_addr) <= ()
	  mst14_arburst,          // (ds_ar_addr) <= ()
	  mst14_arcache,          // (ds_ar_addr) <= ()
	  mst14_arid,             // (ds_ar_addr) <= ()
	  mst14_arlen,            // (ds_ar_addr) <= ()
	  mst14_arlock,           // (ds_ar_addr) <= ()
	  mst14_arprot,           // (ds_ar_addr) <= ()
	  mst14_arsize,           // (ds_ar_addr) <= ()
	  mst14_arvalid,          // (ds_ar_addr) <= ()
	  mst14_connect,          // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst14_awaddr,           // (ds_aw_addr) <= ()
	  mst14_awburst,          // (ds_aw_addr) <= ()
	  mst14_awcache,          // (ds_aw_addr) <= ()
	  mst14_awid,             // (ds_aw_addr) <= ()
	  mst14_awlen,            // (ds_aw_addr) <= ()
	  mst14_awlock,           // (ds_aw_addr) <= ()
	  mst14_awprot,           // (ds_aw_addr) <= ()
	  mst14_awsize,           // (ds_aw_addr) <= ()
	  mst14_awvalid,          // (ds_aw_addr) <= ()
	  mst14_rready,           // (ds_rd_data) <= ()
	  mst14_rsid,             // (ds_rd_data) <= ()
	  mst14_bready,           // (ds_wdata_bresp) <= ()
	  mst14_bsid,             // (ds_wdata_bresp) <= ()
	  mst14_wdata,            // (ds_wdata_bresp) <= ()
	  mst14_wlast,            // (ds_wdata_bresp) <= ()
	  mst14_wsid,             // (ds_wdata_bresp) <= ()
	  mst14_wstrb,            // (ds_wdata_bresp) <= ()
	  mst14_wvalid,           // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST14_SUPPORT
`ifdef ATCBMC300_MST15_SUPPORT
	  mst15_araddr,           // (ds_ar_addr) <= ()
	  mst15_arburst,          // (ds_ar_addr) <= ()
	  mst15_arcache,          // (ds_ar_addr) <= ()
	  mst15_arid,             // (ds_ar_addr) <= ()
	  mst15_arlen,            // (ds_ar_addr) <= ()
	  mst15_arlock,           // (ds_ar_addr) <= ()
	  mst15_arprot,           // (ds_ar_addr) <= ()
	  mst15_arsize,           // (ds_ar_addr) <= ()
	  mst15_arvalid,          // (ds_ar_addr) <= ()
	  mst15_connect,          // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  mst15_awaddr,           // (ds_aw_addr) <= ()
	  mst15_awburst,          // (ds_aw_addr) <= ()
	  mst15_awcache,          // (ds_aw_addr) <= ()
	  mst15_awid,             // (ds_aw_addr) <= ()
	  mst15_awlen,            // (ds_aw_addr) <= ()
	  mst15_awlock,           // (ds_aw_addr) <= ()
	  mst15_awprot,           // (ds_aw_addr) <= ()
	  mst15_awsize,           // (ds_aw_addr) <= ()
	  mst15_awvalid,          // (ds_aw_addr) <= ()
	  mst15_rready,           // (ds_rd_data) <= ()
	  mst15_rsid,             // (ds_rd_data) <= ()
	  mst15_bready,           // (ds_wdata_bresp) <= ()
	  mst15_bsid,             // (ds_wdata_bresp) <= ()
	  mst15_wdata,            // (ds_wdata_bresp) <= ()
	  mst15_wlast,            // (ds_wdata_bresp) <= ()
	  mst15_wsid,             // (ds_wdata_bresp) <= ()
	  mst15_wstrb,            // (ds_wdata_bresp) <= ()
	  mst15_wvalid,           // (ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST15_SUPPORT
	  ds_araddr,              // (ds_ar_addr) => ()
	  ds_arburst,             // (ds_ar_addr) => ()
	  ds_arcache,             // (ds_ar_addr) => ()
	  ds_arid,                // (ds_ar_addr) => ()
	  ds_arlen,               // (ds_ar_addr) => ()
	  ds_arlock,              // (ds_ar_addr) => ()
	  ds_arprot,              // (ds_ar_addr) => ()
	  ds_arready,             // (ds_ar_addr) <= ()
	  ds_arsize,              // (ds_ar_addr) => ()
	  ds_arvalid,             // (ds_ar_addr) => ()
	  slv_ar_mid,             // (ds_ar_addr) => ()
	  slv_arready,            // (ds_ar_addr) => ()
	  reg_mst0_high_priority, // (ds_ar_addr,ds_aw_addr) <= ()
	  reg_priority_reload,    // (ds_ar_addr,ds_aw_addr) <= ()
	  aclk,                   // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  aresetn,                // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	  ds_awaddr,              // (ds_aw_addr) => ()
	  ds_awburst,             // (ds_aw_addr) => ()
	  ds_awcache,             // (ds_aw_addr) => ()
	  ds_awid,                // (ds_aw_addr) => ()
	  ds_awlen,               // (ds_aw_addr) => ()
	  ds_awlock,              // (ds_aw_addr) => ()
	  ds_awprot,              // (ds_aw_addr) => ()
	  ds_awready,             // (ds_aw_addr) <= ()
	  ds_awsize,              // (ds_aw_addr) => ()
	  ds_awvalid,             // (ds_aw_addr) => ()
	  slv_aw_mid,             // (ds_aw_addr) => (ds_wdata_bresp)
	  slv_awready,            // (ds_aw_addr) => ()
	  ds_rdata,               // (ds_rd_data) <= ()
	  ds_rid,                 // (ds_rd_data) <= ()
	  ds_rlast,               // (ds_rd_data) <= ()
	  ds_rready,              // (ds_rd_data) => ()
	  ds_rresp,               // (ds_rd_data) <= ()
	  ds_rvalid,              // (ds_rd_data) <= ()
	  slv_read_data,          // (ds_rd_data) => ()
	  slv_rid,                // (ds_rd_data) => ()
	  slv_rvalid,             // (ds_rd_data) => ()
	  self_id,                // (ds_rd_data,ds_wdata_bresp) <= ()
	  ds_bid,                 // (ds_wdata_bresp) <= ()
	  ds_bready,              // (ds_wdata_bresp) => ()
	  ds_bresp,               // (ds_wdata_bresp) <= ()
	  ds_bvalid,              // (ds_wdata_bresp) <= ()
	  ds_wdata,               // (ds_wdata_bresp) => ()
	  ds_wlast,               // (ds_wdata_bresp) => ()
	  ds_wready,              // (ds_wdata_bresp) <= ()
	  ds_wstrb,               // (ds_wdata_bresp) => ()
	  ds_wvalid,              // (ds_wdata_bresp) => ()
	  slv_bid,                // (ds_wdata_bresp) => ()
	  slv_bresp,              // (ds_wdata_bresp) => ()
	  slv_bvalid,             // (ds_wdata_bresp) => ()
	  slv_wmid,               // (ds_wdata_bresp) => ()
	  slv_wready              // (ds_wdata_bresp) => ()
);

parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 64;
parameter ID_WIDTH = 4;
parameter SLAVE_FIFO_DEPTH = 4;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB = ID_WIDTH - 1;

`ifdef ATCBMC300_MST0_SUPPORT
input               [ADDR_MSB:0] mst0_araddr;
input                      [1:0] mst0_arburst;
input                      [3:0] mst0_arcache;
input                 [ID_MSB:0] mst0_arid;
input                      [7:0] mst0_arlen;
input                            mst0_arlock;
input                      [2:0] mst0_arprot;
input                      [2:0] mst0_arsize;
input                            mst0_arvalid;
input                            mst0_connect;
input               [ADDR_MSB:0] mst0_awaddr;
input                      [1:0] mst0_awburst;
input                      [3:0] mst0_awcache;
input                 [ID_MSB:0] mst0_awid;
input                      [7:0] mst0_awlen;
input                            mst0_awlock;
input                      [2:0] mst0_awprot;
input                      [2:0] mst0_awsize;
input                            mst0_awvalid;
input                            mst0_rready;
input                      [4:0] mst0_rsid;
input                            mst0_bready;
input                      [4:0] mst0_bsid;
input               [DATA_MSB:0] mst0_wdata;
input                            mst0_wlast;
input                      [4:0] mst0_wsid;
input       [(DATA_WIDTH/8)-1:0] mst0_wstrb;
input                            mst0_wvalid;
`endif // ATCBMC300_MST0_SUPPORT
`ifdef ATCBMC300_MST1_SUPPORT
input               [ADDR_MSB:0] mst1_araddr;
input                      [1:0] mst1_arburst;
input                      [3:0] mst1_arcache;
input                 [ID_MSB:0] mst1_arid;
input                      [7:0] mst1_arlen;
input                            mst1_arlock;
input                      [2:0] mst1_arprot;
input                      [2:0] mst1_arsize;
input                            mst1_arvalid;
input                            mst1_connect;
input               [ADDR_MSB:0] mst1_awaddr;
input                      [1:0] mst1_awburst;
input                      [3:0] mst1_awcache;
input                 [ID_MSB:0] mst1_awid;
input                      [7:0] mst1_awlen;
input                            mst1_awlock;
input                      [2:0] mst1_awprot;
input                      [2:0] mst1_awsize;
input                            mst1_awvalid;
input                            mst1_rready;
input                      [4:0] mst1_rsid;
input                            mst1_bready;
input                      [4:0] mst1_bsid;
input               [DATA_MSB:0] mst1_wdata;
input                            mst1_wlast;
input                      [4:0] mst1_wsid;
input       [(DATA_WIDTH/8)-1:0] mst1_wstrb;
input                            mst1_wvalid;
`endif // ATCBMC300_MST1_SUPPORT
`ifdef ATCBMC300_MST2_SUPPORT
input               [ADDR_MSB:0] mst2_araddr;
input                      [1:0] mst2_arburst;
input                      [3:0] mst2_arcache;
input                 [ID_MSB:0] mst2_arid;
input                      [7:0] mst2_arlen;
input                            mst2_arlock;
input                      [2:0] mst2_arprot;
input                      [2:0] mst2_arsize;
input                            mst2_arvalid;
input                            mst2_connect;
input               [ADDR_MSB:0] mst2_awaddr;
input                      [1:0] mst2_awburst;
input                      [3:0] mst2_awcache;
input                 [ID_MSB:0] mst2_awid;
input                      [7:0] mst2_awlen;
input                            mst2_awlock;
input                      [2:0] mst2_awprot;
input                      [2:0] mst2_awsize;
input                            mst2_awvalid;
input                            mst2_rready;
input                      [4:0] mst2_rsid;
input                            mst2_bready;
input                      [4:0] mst2_bsid;
input               [DATA_MSB:0] mst2_wdata;
input                            mst2_wlast;
input                      [4:0] mst2_wsid;
input       [(DATA_WIDTH/8)-1:0] mst2_wstrb;
input                            mst2_wvalid;
`endif // ATCBMC300_MST2_SUPPORT
`ifdef ATCBMC300_MST3_SUPPORT
input               [ADDR_MSB:0] mst3_araddr;
input                      [1:0] mst3_arburst;
input                      [3:0] mst3_arcache;
input                 [ID_MSB:0] mst3_arid;
input                      [7:0] mst3_arlen;
input                            mst3_arlock;
input                      [2:0] mst3_arprot;
input                      [2:0] mst3_arsize;
input                            mst3_arvalid;
input                            mst3_connect;
input               [ADDR_MSB:0] mst3_awaddr;
input                      [1:0] mst3_awburst;
input                      [3:0] mst3_awcache;
input                 [ID_MSB:0] mst3_awid;
input                      [7:0] mst3_awlen;
input                            mst3_awlock;
input                      [2:0] mst3_awprot;
input                      [2:0] mst3_awsize;
input                            mst3_awvalid;
input                            mst3_rready;
input                      [4:0] mst3_rsid;
input                            mst3_bready;
input                      [4:0] mst3_bsid;
input               [DATA_MSB:0] mst3_wdata;
input                            mst3_wlast;
input                      [4:0] mst3_wsid;
input       [(DATA_WIDTH/8)-1:0] mst3_wstrb;
input                            mst3_wvalid;
`endif // ATCBMC300_MST3_SUPPORT
`ifdef ATCBMC300_MST4_SUPPORT
input               [ADDR_MSB:0] mst4_araddr;
input                      [1:0] mst4_arburst;
input                      [3:0] mst4_arcache;
input                 [ID_MSB:0] mst4_arid;
input                      [7:0] mst4_arlen;
input                            mst4_arlock;
input                      [2:0] mst4_arprot;
input                      [2:0] mst4_arsize;
input                            mst4_arvalid;
input                            mst4_connect;
input               [ADDR_MSB:0] mst4_awaddr;
input                      [1:0] mst4_awburst;
input                      [3:0] mst4_awcache;
input                 [ID_MSB:0] mst4_awid;
input                      [7:0] mst4_awlen;
input                            mst4_awlock;
input                      [2:0] mst4_awprot;
input                      [2:0] mst4_awsize;
input                            mst4_awvalid;
input                            mst4_rready;
input                      [4:0] mst4_rsid;
input                            mst4_bready;
input                      [4:0] mst4_bsid;
input               [DATA_MSB:0] mst4_wdata;
input                            mst4_wlast;
input                      [4:0] mst4_wsid;
input       [(DATA_WIDTH/8)-1:0] mst4_wstrb;
input                            mst4_wvalid;
`endif // ATCBMC300_MST4_SUPPORT
`ifdef ATCBMC300_MST5_SUPPORT
input               [ADDR_MSB:0] mst5_araddr;
input                      [1:0] mst5_arburst;
input                      [3:0] mst5_arcache;
input                 [ID_MSB:0] mst5_arid;
input                      [7:0] mst5_arlen;
input                            mst5_arlock;
input                      [2:0] mst5_arprot;
input                      [2:0] mst5_arsize;
input                            mst5_arvalid;
input                            mst5_connect;
input               [ADDR_MSB:0] mst5_awaddr;
input                      [1:0] mst5_awburst;
input                      [3:0] mst5_awcache;
input                 [ID_MSB:0] mst5_awid;
input                      [7:0] mst5_awlen;
input                            mst5_awlock;
input                      [2:0] mst5_awprot;
input                      [2:0] mst5_awsize;
input                            mst5_awvalid;
input                            mst5_rready;
input                      [4:0] mst5_rsid;
input                            mst5_bready;
input                      [4:0] mst5_bsid;
input               [DATA_MSB:0] mst5_wdata;
input                            mst5_wlast;
input                      [4:0] mst5_wsid;
input       [(DATA_WIDTH/8)-1:0] mst5_wstrb;
input                            mst5_wvalid;
`endif // ATCBMC300_MST5_SUPPORT
`ifdef ATCBMC300_MST6_SUPPORT
input               [ADDR_MSB:0] mst6_araddr;
input                      [1:0] mst6_arburst;
input                      [3:0] mst6_arcache;
input                 [ID_MSB:0] mst6_arid;
input                      [7:0] mst6_arlen;
input                            mst6_arlock;
input                      [2:0] mst6_arprot;
input                      [2:0] mst6_arsize;
input                            mst6_arvalid;
input                            mst6_connect;
input               [ADDR_MSB:0] mst6_awaddr;
input                      [1:0] mst6_awburst;
input                      [3:0] mst6_awcache;
input                 [ID_MSB:0] mst6_awid;
input                      [7:0] mst6_awlen;
input                            mst6_awlock;
input                      [2:0] mst6_awprot;
input                      [2:0] mst6_awsize;
input                            mst6_awvalid;
input                            mst6_rready;
input                      [4:0] mst6_rsid;
input                            mst6_bready;
input                      [4:0] mst6_bsid;
input               [DATA_MSB:0] mst6_wdata;
input                            mst6_wlast;
input                      [4:0] mst6_wsid;
input       [(DATA_WIDTH/8)-1:0] mst6_wstrb;
input                            mst6_wvalid;
`endif // ATCBMC300_MST6_SUPPORT
`ifdef ATCBMC300_MST7_SUPPORT
input               [ADDR_MSB:0] mst7_araddr;
input                      [1:0] mst7_arburst;
input                      [3:0] mst7_arcache;
input                 [ID_MSB:0] mst7_arid;
input                      [7:0] mst7_arlen;
input                            mst7_arlock;
input                      [2:0] mst7_arprot;
input                      [2:0] mst7_arsize;
input                            mst7_arvalid;
input                            mst7_connect;
input               [ADDR_MSB:0] mst7_awaddr;
input                      [1:0] mst7_awburst;
input                      [3:0] mst7_awcache;
input                 [ID_MSB:0] mst7_awid;
input                      [7:0] mst7_awlen;
input                            mst7_awlock;
input                      [2:0] mst7_awprot;
input                      [2:0] mst7_awsize;
input                            mst7_awvalid;
input                            mst7_rready;
input                      [4:0] mst7_rsid;
input                            mst7_bready;
input                      [4:0] mst7_bsid;
input               [DATA_MSB:0] mst7_wdata;
input                            mst7_wlast;
input                      [4:0] mst7_wsid;
input       [(DATA_WIDTH/8)-1:0] mst7_wstrb;
input                            mst7_wvalid;
`endif // ATCBMC300_MST7_SUPPORT
`ifdef ATCBMC300_MST8_SUPPORT
input               [ADDR_MSB:0] mst8_araddr;
input                      [1:0] mst8_arburst;
input                      [3:0] mst8_arcache;
input                 [ID_MSB:0] mst8_arid;
input                      [7:0] mst8_arlen;
input                            mst8_arlock;
input                      [2:0] mst8_arprot;
input                      [2:0] mst8_arsize;
input                            mst8_arvalid;
input                            mst8_connect;
input               [ADDR_MSB:0] mst8_awaddr;
input                      [1:0] mst8_awburst;
input                      [3:0] mst8_awcache;
input                 [ID_MSB:0] mst8_awid;
input                      [7:0] mst8_awlen;
input                            mst8_awlock;
input                      [2:0] mst8_awprot;
input                      [2:0] mst8_awsize;
input                            mst8_awvalid;
input                            mst8_rready;
input                      [4:0] mst8_rsid;
input                            mst8_bready;
input                      [4:0] mst8_bsid;
input               [DATA_MSB:0] mst8_wdata;
input                            mst8_wlast;
input                      [4:0] mst8_wsid;
input       [(DATA_WIDTH/8)-1:0] mst8_wstrb;
input                            mst8_wvalid;
`endif // ATCBMC300_MST8_SUPPORT
`ifdef ATCBMC300_MST9_SUPPORT
input               [ADDR_MSB:0] mst9_araddr;
input                      [1:0] mst9_arburst;
input                      [3:0] mst9_arcache;
input                 [ID_MSB:0] mst9_arid;
input                      [7:0] mst9_arlen;
input                            mst9_arlock;
input                      [2:0] mst9_arprot;
input                      [2:0] mst9_arsize;
input                            mst9_arvalid;
input                            mst9_connect;
input               [ADDR_MSB:0] mst9_awaddr;
input                      [1:0] mst9_awburst;
input                      [3:0] mst9_awcache;
input                 [ID_MSB:0] mst9_awid;
input                      [7:0] mst9_awlen;
input                            mst9_awlock;
input                      [2:0] mst9_awprot;
input                      [2:0] mst9_awsize;
input                            mst9_awvalid;
input                            mst9_rready;
input                      [4:0] mst9_rsid;
input                            mst9_bready;
input                      [4:0] mst9_bsid;
input               [DATA_MSB:0] mst9_wdata;
input                            mst9_wlast;
input                      [4:0] mst9_wsid;
input       [(DATA_WIDTH/8)-1:0] mst9_wstrb;
input                            mst9_wvalid;
`endif // ATCBMC300_MST9_SUPPORT
`ifdef ATCBMC300_MST10_SUPPORT
input               [ADDR_MSB:0] mst10_araddr;
input                      [1:0] mst10_arburst;
input                      [3:0] mst10_arcache;
input                 [ID_MSB:0] mst10_arid;
input                      [7:0] mst10_arlen;
input                            mst10_arlock;
input                      [2:0] mst10_arprot;
input                      [2:0] mst10_arsize;
input                            mst10_arvalid;
input                            mst10_connect;
input               [ADDR_MSB:0] mst10_awaddr;
input                      [1:0] mst10_awburst;
input                      [3:0] mst10_awcache;
input                 [ID_MSB:0] mst10_awid;
input                      [7:0] mst10_awlen;
input                            mst10_awlock;
input                      [2:0] mst10_awprot;
input                      [2:0] mst10_awsize;
input                            mst10_awvalid;
input                            mst10_rready;
input                      [4:0] mst10_rsid;
input                            mst10_bready;
input                      [4:0] mst10_bsid;
input               [DATA_MSB:0] mst10_wdata;
input                            mst10_wlast;
input                      [4:0] mst10_wsid;
input       [(DATA_WIDTH/8)-1:0] mst10_wstrb;
input                            mst10_wvalid;
`endif // ATCBMC300_MST10_SUPPORT
`ifdef ATCBMC300_MST11_SUPPORT
input               [ADDR_MSB:0] mst11_araddr;
input                      [1:0] mst11_arburst;
input                      [3:0] mst11_arcache;
input                 [ID_MSB:0] mst11_arid;
input                      [7:0] mst11_arlen;
input                            mst11_arlock;
input                      [2:0] mst11_arprot;
input                      [2:0] mst11_arsize;
input                            mst11_arvalid;
input                            mst11_connect;
input               [ADDR_MSB:0] mst11_awaddr;
input                      [1:0] mst11_awburst;
input                      [3:0] mst11_awcache;
input                 [ID_MSB:0] mst11_awid;
input                      [7:0] mst11_awlen;
input                            mst11_awlock;
input                      [2:0] mst11_awprot;
input                      [2:0] mst11_awsize;
input                            mst11_awvalid;
input                            mst11_rready;
input                      [4:0] mst11_rsid;
input                            mst11_bready;
input                      [4:0] mst11_bsid;
input               [DATA_MSB:0] mst11_wdata;
input                            mst11_wlast;
input                      [4:0] mst11_wsid;
input       [(DATA_WIDTH/8)-1:0] mst11_wstrb;
input                            mst11_wvalid;
`endif // ATCBMC300_MST11_SUPPORT
`ifdef ATCBMC300_MST12_SUPPORT
input               [ADDR_MSB:0] mst12_araddr;
input                      [1:0] mst12_arburst;
input                      [3:0] mst12_arcache;
input                 [ID_MSB:0] mst12_arid;
input                      [7:0] mst12_arlen;
input                            mst12_arlock;
input                      [2:0] mst12_arprot;
input                      [2:0] mst12_arsize;
input                            mst12_arvalid;
input                            mst12_connect;
input               [ADDR_MSB:0] mst12_awaddr;
input                      [1:0] mst12_awburst;
input                      [3:0] mst12_awcache;
input                 [ID_MSB:0] mst12_awid;
input                      [7:0] mst12_awlen;
input                            mst12_awlock;
input                      [2:0] mst12_awprot;
input                      [2:0] mst12_awsize;
input                            mst12_awvalid;
input                            mst12_rready;
input                      [4:0] mst12_rsid;
input                            mst12_bready;
input                      [4:0] mst12_bsid;
input               [DATA_MSB:0] mst12_wdata;
input                            mst12_wlast;
input                      [4:0] mst12_wsid;
input       [(DATA_WIDTH/8)-1:0] mst12_wstrb;
input                            mst12_wvalid;
`endif // ATCBMC300_MST12_SUPPORT
`ifdef ATCBMC300_MST13_SUPPORT
input               [ADDR_MSB:0] mst13_araddr;
input                      [1:0] mst13_arburst;
input                      [3:0] mst13_arcache;
input                 [ID_MSB:0] mst13_arid;
input                      [7:0] mst13_arlen;
input                            mst13_arlock;
input                      [2:0] mst13_arprot;
input                      [2:0] mst13_arsize;
input                            mst13_arvalid;
input                            mst13_connect;
input               [ADDR_MSB:0] mst13_awaddr;
input                      [1:0] mst13_awburst;
input                      [3:0] mst13_awcache;
input                 [ID_MSB:0] mst13_awid;
input                      [7:0] mst13_awlen;
input                            mst13_awlock;
input                      [2:0] mst13_awprot;
input                      [2:0] mst13_awsize;
input                            mst13_awvalid;
input                            mst13_rready;
input                      [4:0] mst13_rsid;
input                            mst13_bready;
input                      [4:0] mst13_bsid;
input               [DATA_MSB:0] mst13_wdata;
input                            mst13_wlast;
input                      [4:0] mst13_wsid;
input       [(DATA_WIDTH/8)-1:0] mst13_wstrb;
input                            mst13_wvalid;
`endif // ATCBMC300_MST13_SUPPORT
`ifdef ATCBMC300_MST14_SUPPORT
input               [ADDR_MSB:0] mst14_araddr;
input                      [1:0] mst14_arburst;
input                      [3:0] mst14_arcache;
input                 [ID_MSB:0] mst14_arid;
input                      [7:0] mst14_arlen;
input                            mst14_arlock;
input                      [2:0] mst14_arprot;
input                      [2:0] mst14_arsize;
input                            mst14_arvalid;
input                            mst14_connect;
input               [ADDR_MSB:0] mst14_awaddr;
input                      [1:0] mst14_awburst;
input                      [3:0] mst14_awcache;
input                 [ID_MSB:0] mst14_awid;
input                      [7:0] mst14_awlen;
input                            mst14_awlock;
input                      [2:0] mst14_awprot;
input                      [2:0] mst14_awsize;
input                            mst14_awvalid;
input                            mst14_rready;
input                      [4:0] mst14_rsid;
input                            mst14_bready;
input                      [4:0] mst14_bsid;
input               [DATA_MSB:0] mst14_wdata;
input                            mst14_wlast;
input                      [4:0] mst14_wsid;
input       [(DATA_WIDTH/8)-1:0] mst14_wstrb;
input                            mst14_wvalid;
`endif // ATCBMC300_MST14_SUPPORT
`ifdef ATCBMC300_MST15_SUPPORT
input               [ADDR_MSB:0] mst15_araddr;
input                      [1:0] mst15_arburst;
input                      [3:0] mst15_arcache;
input                 [ID_MSB:0] mst15_arid;
input                      [7:0] mst15_arlen;
input                            mst15_arlock;
input                      [2:0] mst15_arprot;
input                      [2:0] mst15_arsize;
input                            mst15_arvalid;
input                            mst15_connect;
input               [ADDR_MSB:0] mst15_awaddr;
input                      [1:0] mst15_awburst;
input                      [3:0] mst15_awcache;
input                 [ID_MSB:0] mst15_awid;
input                      [7:0] mst15_awlen;
input                            mst15_awlock;
input                      [2:0] mst15_awprot;
input                      [2:0] mst15_awsize;
input                            mst15_awvalid;
input                            mst15_rready;
input                      [4:0] mst15_rsid;
input                            mst15_bready;
input                      [4:0] mst15_bsid;
input               [DATA_MSB:0] mst15_wdata;
input                            mst15_wlast;
input                      [4:0] mst15_wsid;
input       [(DATA_WIDTH/8)-1:0] mst15_wstrb;
input                            mst15_wvalid;
`endif // ATCBMC300_MST15_SUPPORT
output              [ADDR_MSB:0] ds_araddr;
output                     [1:0] ds_arburst;
output                     [3:0] ds_arcache;
output            [(ID_MSB+4):0] ds_arid;
output                     [7:0] ds_arlen;
output                           ds_arlock;
output                     [2:0] ds_arprot;
input                            ds_arready;
output                     [2:0] ds_arsize;
output                           ds_arvalid;
output                     [3:0] slv_ar_mid;
output                           slv_arready;
input                            reg_mst0_high_priority;
input                     [15:0] reg_priority_reload;
input                            aclk;
input                            aresetn;
output              [ADDR_MSB:0] ds_awaddr;
output                     [1:0] ds_awburst;
output                     [3:0] ds_awcache;
output            [(ID_MSB+4):0] ds_awid;
output                     [7:0] ds_awlen;
output                           ds_awlock;
output                     [2:0] ds_awprot;
input                            ds_awready;
output                     [2:0] ds_awsize;
output                           ds_awvalid;
output                     [3:0] slv_aw_mid;
output                           slv_awready;
input               [DATA_MSB:0] ds_rdata;
input               [ID_MSB+4:0] ds_rid;
input                            ds_rlast;
output                           ds_rready;
input                      [1:0] ds_rresp;
input                            ds_rvalid;
output            [DATA_MSB+3:0] slv_read_data;
output              [ID_MSB+4:0] slv_rid;
output                           slv_rvalid;
input                      [4:0] self_id;
input               [ID_MSB+4:0] ds_bid;
output                           ds_bready;
input                      [1:0] ds_bresp;
input                            ds_bvalid;
output              [DATA_MSB:0] ds_wdata;
output                           ds_wlast;
input                            ds_wready;
output      [(DATA_WIDTH/8)-1:0] ds_wstrb;
output                           ds_wvalid;
output              [ID_MSB+4:0] slv_bid;
output                     [1:0] slv_bresp;
output                           slv_bvalid;
output                     [3:0] slv_wmid;
output                           slv_wready;

wire                             ar_addr_outstanding_en;
wire                             aw_addr_outstanding_en;
wire                             ar_outstanding_ready;
wire                             aw_outstanding_ready;


atcbmc300_ds_addr_ctrl #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        )
) ds_aw_addr (
`ifdef ATCBMC300_MST0_SUPPORT
	.mst0_addr             (mst0_awaddr           ), // (ds_aw_addr) <= ()
	.mst0_len              (mst0_awlen            ), // (ds_aw_addr) <= ()
	.mst0_size             (mst0_awsize           ), // (ds_aw_addr) <= ()
	.mst0_burst            (mst0_awburst          ), // (ds_aw_addr) <= ()
	.mst0_lock             (mst0_awlock           ), // (ds_aw_addr) <= ()
	.mst0_cache            (mst0_awcache          ), // (ds_aw_addr) <= ()
	.mst0_prot             (mst0_awprot           ), // (ds_aw_addr) <= ()
	.mst0_aid              (mst0_awid             ), // (ds_aw_addr) <= ()
	.mst0_avalid           (mst0_awvalid          ), // (ds_aw_addr) <= ()
	.mst0_connect          (mst0_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST0_SUPPORT
`ifdef ATCBMC300_MST1_SUPPORT
	.mst1_addr             (mst1_awaddr           ), // (ds_aw_addr) <= ()
	.mst1_len              (mst1_awlen            ), // (ds_aw_addr) <= ()
	.mst1_size             (mst1_awsize           ), // (ds_aw_addr) <= ()
	.mst1_burst            (mst1_awburst          ), // (ds_aw_addr) <= ()
	.mst1_lock             (mst1_awlock           ), // (ds_aw_addr) <= ()
	.mst1_cache            (mst1_awcache          ), // (ds_aw_addr) <= ()
	.mst1_prot             (mst1_awprot           ), // (ds_aw_addr) <= ()
	.mst1_aid              (mst1_awid             ), // (ds_aw_addr) <= ()
	.mst1_avalid           (mst1_awvalid          ), // (ds_aw_addr) <= ()
	.mst1_connect          (mst1_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST1_SUPPORT
`ifdef ATCBMC300_MST2_SUPPORT
	.mst2_addr             (mst2_awaddr           ), // (ds_aw_addr) <= ()
	.mst2_len              (mst2_awlen            ), // (ds_aw_addr) <= ()
	.mst2_size             (mst2_awsize           ), // (ds_aw_addr) <= ()
	.mst2_burst            (mst2_awburst          ), // (ds_aw_addr) <= ()
	.mst2_lock             (mst2_awlock           ), // (ds_aw_addr) <= ()
	.mst2_cache            (mst2_awcache          ), // (ds_aw_addr) <= ()
	.mst2_prot             (mst2_awprot           ), // (ds_aw_addr) <= ()
	.mst2_aid              (mst2_awid             ), // (ds_aw_addr) <= ()
	.mst2_avalid           (mst2_awvalid          ), // (ds_aw_addr) <= ()
	.mst2_connect          (mst2_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST2_SUPPORT
`ifdef ATCBMC300_MST3_SUPPORT
	.mst3_addr             (mst3_awaddr           ), // (ds_aw_addr) <= ()
	.mst3_len              (mst3_awlen            ), // (ds_aw_addr) <= ()
	.mst3_size             (mst3_awsize           ), // (ds_aw_addr) <= ()
	.mst3_burst            (mst3_awburst          ), // (ds_aw_addr) <= ()
	.mst3_lock             (mst3_awlock           ), // (ds_aw_addr) <= ()
	.mst3_cache            (mst3_awcache          ), // (ds_aw_addr) <= ()
	.mst3_prot             (mst3_awprot           ), // (ds_aw_addr) <= ()
	.mst3_aid              (mst3_awid             ), // (ds_aw_addr) <= ()
	.mst3_avalid           (mst3_awvalid          ), // (ds_aw_addr) <= ()
	.mst3_connect          (mst3_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST3_SUPPORT
`ifdef ATCBMC300_MST4_SUPPORT
	.mst4_addr             (mst4_awaddr           ), // (ds_aw_addr) <= ()
	.mst4_len              (mst4_awlen            ), // (ds_aw_addr) <= ()
	.mst4_size             (mst4_awsize           ), // (ds_aw_addr) <= ()
	.mst4_burst            (mst4_awburst          ), // (ds_aw_addr) <= ()
	.mst4_lock             (mst4_awlock           ), // (ds_aw_addr) <= ()
	.mst4_cache            (mst4_awcache          ), // (ds_aw_addr) <= ()
	.mst4_prot             (mst4_awprot           ), // (ds_aw_addr) <= ()
	.mst4_aid              (mst4_awid             ), // (ds_aw_addr) <= ()
	.mst4_avalid           (mst4_awvalid          ), // (ds_aw_addr) <= ()
	.mst4_connect          (mst4_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST4_SUPPORT
`ifdef ATCBMC300_MST5_SUPPORT
	.mst5_addr             (mst5_awaddr           ), // (ds_aw_addr) <= ()
	.mst5_len              (mst5_awlen            ), // (ds_aw_addr) <= ()
	.mst5_size             (mst5_awsize           ), // (ds_aw_addr) <= ()
	.mst5_burst            (mst5_awburst          ), // (ds_aw_addr) <= ()
	.mst5_lock             (mst5_awlock           ), // (ds_aw_addr) <= ()
	.mst5_cache            (mst5_awcache          ), // (ds_aw_addr) <= ()
	.mst5_prot             (mst5_awprot           ), // (ds_aw_addr) <= ()
	.mst5_aid              (mst5_awid             ), // (ds_aw_addr) <= ()
	.mst5_avalid           (mst5_awvalid          ), // (ds_aw_addr) <= ()
	.mst5_connect          (mst5_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST5_SUPPORT
`ifdef ATCBMC300_MST6_SUPPORT
	.mst6_addr             (mst6_awaddr           ), // (ds_aw_addr) <= ()
	.mst6_len              (mst6_awlen            ), // (ds_aw_addr) <= ()
	.mst6_size             (mst6_awsize           ), // (ds_aw_addr) <= ()
	.mst6_burst            (mst6_awburst          ), // (ds_aw_addr) <= ()
	.mst6_lock             (mst6_awlock           ), // (ds_aw_addr) <= ()
	.mst6_cache            (mst6_awcache          ), // (ds_aw_addr) <= ()
	.mst6_prot             (mst6_awprot           ), // (ds_aw_addr) <= ()
	.mst6_aid              (mst6_awid             ), // (ds_aw_addr) <= ()
	.mst6_avalid           (mst6_awvalid          ), // (ds_aw_addr) <= ()
	.mst6_connect          (mst6_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST6_SUPPORT
`ifdef ATCBMC300_MST7_SUPPORT
	.mst7_addr             (mst7_awaddr           ), // (ds_aw_addr) <= ()
	.mst7_len              (mst7_awlen            ), // (ds_aw_addr) <= ()
	.mst7_size             (mst7_awsize           ), // (ds_aw_addr) <= ()
	.mst7_burst            (mst7_awburst          ), // (ds_aw_addr) <= ()
	.mst7_lock             (mst7_awlock           ), // (ds_aw_addr) <= ()
	.mst7_cache            (mst7_awcache          ), // (ds_aw_addr) <= ()
	.mst7_prot             (mst7_awprot           ), // (ds_aw_addr) <= ()
	.mst7_aid              (mst7_awid             ), // (ds_aw_addr) <= ()
	.mst7_avalid           (mst7_awvalid          ), // (ds_aw_addr) <= ()
	.mst7_connect          (mst7_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST7_SUPPORT
`ifdef ATCBMC300_MST8_SUPPORT
	.mst8_addr             (mst8_awaddr           ), // (ds_aw_addr) <= ()
	.mst8_len              (mst8_awlen            ), // (ds_aw_addr) <= ()
	.mst8_size             (mst8_awsize           ), // (ds_aw_addr) <= ()
	.mst8_burst            (mst8_awburst          ), // (ds_aw_addr) <= ()
	.mst8_lock             (mst8_awlock           ), // (ds_aw_addr) <= ()
	.mst8_cache            (mst8_awcache          ), // (ds_aw_addr) <= ()
	.mst8_prot             (mst8_awprot           ), // (ds_aw_addr) <= ()
	.mst8_aid              (mst8_awid             ), // (ds_aw_addr) <= ()
	.mst8_avalid           (mst8_awvalid          ), // (ds_aw_addr) <= ()
	.mst8_connect          (mst8_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST8_SUPPORT
`ifdef ATCBMC300_MST9_SUPPORT
	.mst9_addr             (mst9_awaddr           ), // (ds_aw_addr) <= ()
	.mst9_len              (mst9_awlen            ), // (ds_aw_addr) <= ()
	.mst9_size             (mst9_awsize           ), // (ds_aw_addr) <= ()
	.mst9_burst            (mst9_awburst          ), // (ds_aw_addr) <= ()
	.mst9_lock             (mst9_awlock           ), // (ds_aw_addr) <= ()
	.mst9_cache            (mst9_awcache          ), // (ds_aw_addr) <= ()
	.mst9_prot             (mst9_awprot           ), // (ds_aw_addr) <= ()
	.mst9_aid              (mst9_awid             ), // (ds_aw_addr) <= ()
	.mst9_avalid           (mst9_awvalid          ), // (ds_aw_addr) <= ()
	.mst9_connect          (mst9_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST9_SUPPORT
`ifdef ATCBMC300_MST10_SUPPORT
	.mst10_addr            (mst10_awaddr          ), // (ds_aw_addr) <= ()
	.mst10_len             (mst10_awlen           ), // (ds_aw_addr) <= ()
	.mst10_size            (mst10_awsize          ), // (ds_aw_addr) <= ()
	.mst10_burst           (mst10_awburst         ), // (ds_aw_addr) <= ()
	.mst10_lock            (mst10_awlock          ), // (ds_aw_addr) <= ()
	.mst10_cache           (mst10_awcache         ), // (ds_aw_addr) <= ()
	.mst10_prot            (mst10_awprot          ), // (ds_aw_addr) <= ()
	.mst10_aid             (mst10_awid            ), // (ds_aw_addr) <= ()
	.mst10_avalid          (mst10_awvalid         ), // (ds_aw_addr) <= ()
	.mst10_connect         (mst10_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST10_SUPPORT
`ifdef ATCBMC300_MST11_SUPPORT
	.mst11_addr            (mst11_awaddr          ), // (ds_aw_addr) <= ()
	.mst11_len             (mst11_awlen           ), // (ds_aw_addr) <= ()
	.mst11_size            (mst11_awsize          ), // (ds_aw_addr) <= ()
	.mst11_burst           (mst11_awburst         ), // (ds_aw_addr) <= ()
	.mst11_lock            (mst11_awlock          ), // (ds_aw_addr) <= ()
	.mst11_cache           (mst11_awcache         ), // (ds_aw_addr) <= ()
	.mst11_prot            (mst11_awprot          ), // (ds_aw_addr) <= ()
	.mst11_aid             (mst11_awid            ), // (ds_aw_addr) <= ()
	.mst11_avalid          (mst11_awvalid         ), // (ds_aw_addr) <= ()
	.mst11_connect         (mst11_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST11_SUPPORT
`ifdef ATCBMC300_MST12_SUPPORT
	.mst12_addr            (mst12_awaddr          ), // (ds_aw_addr) <= ()
	.mst12_len             (mst12_awlen           ), // (ds_aw_addr) <= ()
	.mst12_size            (mst12_awsize          ), // (ds_aw_addr) <= ()
	.mst12_burst           (mst12_awburst         ), // (ds_aw_addr) <= ()
	.mst12_lock            (mst12_awlock          ), // (ds_aw_addr) <= ()
	.mst12_cache           (mst12_awcache         ), // (ds_aw_addr) <= ()
	.mst12_prot            (mst12_awprot          ), // (ds_aw_addr) <= ()
	.mst12_aid             (mst12_awid            ), // (ds_aw_addr) <= ()
	.mst12_avalid          (mst12_awvalid         ), // (ds_aw_addr) <= ()
	.mst12_connect         (mst12_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST12_SUPPORT
`ifdef ATCBMC300_MST13_SUPPORT
	.mst13_addr            (mst13_awaddr          ), // (ds_aw_addr) <= ()
	.mst13_len             (mst13_awlen           ), // (ds_aw_addr) <= ()
	.mst13_size            (mst13_awsize          ), // (ds_aw_addr) <= ()
	.mst13_burst           (mst13_awburst         ), // (ds_aw_addr) <= ()
	.mst13_lock            (mst13_awlock          ), // (ds_aw_addr) <= ()
	.mst13_cache           (mst13_awcache         ), // (ds_aw_addr) <= ()
	.mst13_prot            (mst13_awprot          ), // (ds_aw_addr) <= ()
	.mst13_aid             (mst13_awid            ), // (ds_aw_addr) <= ()
	.mst13_avalid          (mst13_awvalid         ), // (ds_aw_addr) <= ()
	.mst13_connect         (mst13_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST13_SUPPORT
`ifdef ATCBMC300_MST14_SUPPORT
	.mst14_addr            (mst14_awaddr          ), // (ds_aw_addr) <= ()
	.mst14_len             (mst14_awlen           ), // (ds_aw_addr) <= ()
	.mst14_size            (mst14_awsize          ), // (ds_aw_addr) <= ()
	.mst14_burst           (mst14_awburst         ), // (ds_aw_addr) <= ()
	.mst14_lock            (mst14_awlock          ), // (ds_aw_addr) <= ()
	.mst14_cache           (mst14_awcache         ), // (ds_aw_addr) <= ()
	.mst14_prot            (mst14_awprot          ), // (ds_aw_addr) <= ()
	.mst14_aid             (mst14_awid            ), // (ds_aw_addr) <= ()
	.mst14_avalid          (mst14_awvalid         ), // (ds_aw_addr) <= ()
	.mst14_connect         (mst14_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST14_SUPPORT
`ifdef ATCBMC300_MST15_SUPPORT
	.mst15_addr            (mst15_awaddr          ), // (ds_aw_addr) <= ()
	.mst15_len             (mst15_awlen           ), // (ds_aw_addr) <= ()
	.mst15_size            (mst15_awsize          ), // (ds_aw_addr) <= ()
	.mst15_burst           (mst15_awburst         ), // (ds_aw_addr) <= ()
	.mst15_lock            (mst15_awlock          ), // (ds_aw_addr) <= ()
	.mst15_cache           (mst15_awcache         ), // (ds_aw_addr) <= ()
	.mst15_prot            (mst15_awprot          ), // (ds_aw_addr) <= ()
	.mst15_aid             (mst15_awid            ), // (ds_aw_addr) <= ()
	.mst15_avalid          (mst15_awvalid         ), // (ds_aw_addr) <= ()
	.mst15_connect         (mst15_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST15_SUPPORT
	.addr_outstanding_en   (aw_addr_outstanding_en), // (ds_aw_addr) => (ds_wdata_bresp)
	.slv_aready            (slv_awready           ), // (ds_aw_addr) => ()
	.arb_mid               (slv_aw_mid            ), // (ds_aw_addr) => (ds_wdata_bresp)
	.outstanding_ready     (aw_outstanding_ready  ), // (ds_aw_addr) <= (ds_wdata_bresp)
	.addr                  (ds_awaddr             ), // (ds_aw_addr) => ()
	.len                   (ds_awlen              ), // (ds_aw_addr) => ()
	.size                  (ds_awsize             ), // (ds_aw_addr) => ()
	.burst                 (ds_awburst            ), // (ds_aw_addr) => ()
	.lock                  (ds_awlock             ), // (ds_aw_addr) => ()
	.cache                 (ds_awcache            ), // (ds_aw_addr) => ()
	.prot                  (ds_awprot             ), // (ds_aw_addr) => ()
	.aid                   (ds_awid               ), // (ds_aw_addr) => ()
	.avalid                (ds_awvalid            ), // (ds_aw_addr) => ()
	.aready                (ds_awready            ), // (ds_aw_addr) <= ()
	.reg_mst0_high_priority(reg_mst0_high_priority), // (ds_ar_addr,ds_aw_addr) <= ()
	.reg_priority_reload   (reg_priority_reload   ), // (ds_ar_addr,ds_aw_addr) <= ()
	.aclk                  (aclk                  ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	.aresetn               (aresetn               )  // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
); // end of ds_aw_addr

atcbmc300_ds_wdata_bresp_ctrl #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(SLAVE_FIFO_DEPTH)
) ds_wdata_bresp (
	.self_id            (self_id               ), // (ds_rd_data,ds_wdata_bresp) <= ()
`ifdef ATCBMC300_MST0_SUPPORT
	.mst0_wvalid        (mst0_wvalid           ), // (ds_wdata_bresp) <= ()
	.mst0_wlast         (mst0_wlast            ), // (ds_wdata_bresp) <= ()
	.mst0_wdata         (mst0_wdata            ), // (ds_wdata_bresp) <= ()
	.mst0_wstrb         (mst0_wstrb            ), // (ds_wdata_bresp) <= ()
	.mst0_wsid          (mst0_wsid             ), // (ds_wdata_bresp) <= ()
	.mst0_bready        (mst0_bready           ), // (ds_wdata_bresp) <= ()
	.mst0_bsid          (mst0_bsid             ), // (ds_wdata_bresp) <= ()
	.mst0_connect       (mst0_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST0_SUPPORT
`ifdef ATCBMC300_MST1_SUPPORT
	.mst1_wvalid        (mst1_wvalid           ), // (ds_wdata_bresp) <= ()
	.mst1_wlast         (mst1_wlast            ), // (ds_wdata_bresp) <= ()
	.mst1_wdata         (mst1_wdata            ), // (ds_wdata_bresp) <= ()
	.mst1_wstrb         (mst1_wstrb            ), // (ds_wdata_bresp) <= ()
	.mst1_wsid          (mst1_wsid             ), // (ds_wdata_bresp) <= ()
	.mst1_bready        (mst1_bready           ), // (ds_wdata_bresp) <= ()
	.mst1_bsid          (mst1_bsid             ), // (ds_wdata_bresp) <= ()
	.mst1_connect       (mst1_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST1_SUPPORT
`ifdef ATCBMC300_MST2_SUPPORT
	.mst2_wvalid        (mst2_wvalid           ), // (ds_wdata_bresp) <= ()
	.mst2_wlast         (mst2_wlast            ), // (ds_wdata_bresp) <= ()
	.mst2_wdata         (mst2_wdata            ), // (ds_wdata_bresp) <= ()
	.mst2_wstrb         (mst2_wstrb            ), // (ds_wdata_bresp) <= ()
	.mst2_wsid          (mst2_wsid             ), // (ds_wdata_bresp) <= ()
	.mst2_bready        (mst2_bready           ), // (ds_wdata_bresp) <= ()
	.mst2_bsid          (mst2_bsid             ), // (ds_wdata_bresp) <= ()
	.mst2_connect       (mst2_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST2_SUPPORT
`ifdef ATCBMC300_MST3_SUPPORT
	.mst3_wvalid        (mst3_wvalid           ), // (ds_wdata_bresp) <= ()
	.mst3_wlast         (mst3_wlast            ), // (ds_wdata_bresp) <= ()
	.mst3_wdata         (mst3_wdata            ), // (ds_wdata_bresp) <= ()
	.mst3_wstrb         (mst3_wstrb            ), // (ds_wdata_bresp) <= ()
	.mst3_wsid          (mst3_wsid             ), // (ds_wdata_bresp) <= ()
	.mst3_bready        (mst3_bready           ), // (ds_wdata_bresp) <= ()
	.mst3_bsid          (mst3_bsid             ), // (ds_wdata_bresp) <= ()
	.mst3_connect       (mst3_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST3_SUPPORT
`ifdef ATCBMC300_MST4_SUPPORT
	.mst4_wvalid        (mst4_wvalid           ), // (ds_wdata_bresp) <= ()
	.mst4_wlast         (mst4_wlast            ), // (ds_wdata_bresp) <= ()
	.mst4_wdata         (mst4_wdata            ), // (ds_wdata_bresp) <= ()
	.mst4_wstrb         (mst4_wstrb            ), // (ds_wdata_bresp) <= ()
	.mst4_wsid          (mst4_wsid             ), // (ds_wdata_bresp) <= ()
	.mst4_bready        (mst4_bready           ), // (ds_wdata_bresp) <= ()
	.mst4_bsid          (mst4_bsid             ), // (ds_wdata_bresp) <= ()
	.mst4_connect       (mst4_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST4_SUPPORT
`ifdef ATCBMC300_MST5_SUPPORT
	.mst5_wvalid        (mst5_wvalid           ), // (ds_wdata_bresp) <= ()
	.mst5_wlast         (mst5_wlast            ), // (ds_wdata_bresp) <= ()
	.mst5_wdata         (mst5_wdata            ), // (ds_wdata_bresp) <= ()
	.mst5_wstrb         (mst5_wstrb            ), // (ds_wdata_bresp) <= ()
	.mst5_wsid          (mst5_wsid             ), // (ds_wdata_bresp) <= ()
	.mst5_bready        (mst5_bready           ), // (ds_wdata_bresp) <= ()
	.mst5_bsid          (mst5_bsid             ), // (ds_wdata_bresp) <= ()
	.mst5_connect       (mst5_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST5_SUPPORT
`ifdef ATCBMC300_MST6_SUPPORT
	.mst6_wvalid        (mst6_wvalid           ), // (ds_wdata_bresp) <= ()
	.mst6_wlast         (mst6_wlast            ), // (ds_wdata_bresp) <= ()
	.mst6_wdata         (mst6_wdata            ), // (ds_wdata_bresp) <= ()
	.mst6_wstrb         (mst6_wstrb            ), // (ds_wdata_bresp) <= ()
	.mst6_wsid          (mst6_wsid             ), // (ds_wdata_bresp) <= ()
	.mst6_bready        (mst6_bready           ), // (ds_wdata_bresp) <= ()
	.mst6_bsid          (mst6_bsid             ), // (ds_wdata_bresp) <= ()
	.mst6_connect       (mst6_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST6_SUPPORT
`ifdef ATCBMC300_MST7_SUPPORT
	.mst7_wvalid        (mst7_wvalid           ), // (ds_wdata_bresp) <= ()
	.mst7_wlast         (mst7_wlast            ), // (ds_wdata_bresp) <= ()
	.mst7_wdata         (mst7_wdata            ), // (ds_wdata_bresp) <= ()
	.mst7_wstrb         (mst7_wstrb            ), // (ds_wdata_bresp) <= ()
	.mst7_wsid          (mst7_wsid             ), // (ds_wdata_bresp) <= ()
	.mst7_bready        (mst7_bready           ), // (ds_wdata_bresp) <= ()
	.mst7_bsid          (mst7_bsid             ), // (ds_wdata_bresp) <= ()
	.mst7_connect       (mst7_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST7_SUPPORT
`ifdef ATCBMC300_MST8_SUPPORT
	.mst8_wvalid        (mst8_wvalid           ), // (ds_wdata_bresp) <= ()
	.mst8_wlast         (mst8_wlast            ), // (ds_wdata_bresp) <= ()
	.mst8_wdata         (mst8_wdata            ), // (ds_wdata_bresp) <= ()
	.mst8_wstrb         (mst8_wstrb            ), // (ds_wdata_bresp) <= ()
	.mst8_wsid          (mst8_wsid             ), // (ds_wdata_bresp) <= ()
	.mst8_bready        (mst8_bready           ), // (ds_wdata_bresp) <= ()
	.mst8_bsid          (mst8_bsid             ), // (ds_wdata_bresp) <= ()
	.mst8_connect       (mst8_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST8_SUPPORT
`ifdef ATCBMC300_MST9_SUPPORT
	.mst9_wvalid        (mst9_wvalid           ), // (ds_wdata_bresp) <= ()
	.mst9_wlast         (mst9_wlast            ), // (ds_wdata_bresp) <= ()
	.mst9_wdata         (mst9_wdata            ), // (ds_wdata_bresp) <= ()
	.mst9_wstrb         (mst9_wstrb            ), // (ds_wdata_bresp) <= ()
	.mst9_wsid          (mst9_wsid             ), // (ds_wdata_bresp) <= ()
	.mst9_bready        (mst9_bready           ), // (ds_wdata_bresp) <= ()
	.mst9_bsid          (mst9_bsid             ), // (ds_wdata_bresp) <= ()
	.mst9_connect       (mst9_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST9_SUPPORT
`ifdef ATCBMC300_MST10_SUPPORT
	.mst10_wvalid       (mst10_wvalid          ), // (ds_wdata_bresp) <= ()
	.mst10_wlast        (mst10_wlast           ), // (ds_wdata_bresp) <= ()
	.mst10_wdata        (mst10_wdata           ), // (ds_wdata_bresp) <= ()
	.mst10_wstrb        (mst10_wstrb           ), // (ds_wdata_bresp) <= ()
	.mst10_wsid         (mst10_wsid            ), // (ds_wdata_bresp) <= ()
	.mst10_bready       (mst10_bready          ), // (ds_wdata_bresp) <= ()
	.mst10_bsid         (mst10_bsid            ), // (ds_wdata_bresp) <= ()
	.mst10_connect      (mst10_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST10_SUPPORT
`ifdef ATCBMC300_MST11_SUPPORT
	.mst11_wvalid       (mst11_wvalid          ), // (ds_wdata_bresp) <= ()
	.mst11_wlast        (mst11_wlast           ), // (ds_wdata_bresp) <= ()
	.mst11_wdata        (mst11_wdata           ), // (ds_wdata_bresp) <= ()
	.mst11_wstrb        (mst11_wstrb           ), // (ds_wdata_bresp) <= ()
	.mst11_wsid         (mst11_wsid            ), // (ds_wdata_bresp) <= ()
	.mst11_bready       (mst11_bready          ), // (ds_wdata_bresp) <= ()
	.mst11_bsid         (mst11_bsid            ), // (ds_wdata_bresp) <= ()
	.mst11_connect      (mst11_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST11_SUPPORT
`ifdef ATCBMC300_MST12_SUPPORT
	.mst12_wvalid       (mst12_wvalid          ), // (ds_wdata_bresp) <= ()
	.mst12_wlast        (mst12_wlast           ), // (ds_wdata_bresp) <= ()
	.mst12_wdata        (mst12_wdata           ), // (ds_wdata_bresp) <= ()
	.mst12_wstrb        (mst12_wstrb           ), // (ds_wdata_bresp) <= ()
	.mst12_wsid         (mst12_wsid            ), // (ds_wdata_bresp) <= ()
	.mst12_bready       (mst12_bready          ), // (ds_wdata_bresp) <= ()
	.mst12_bsid         (mst12_bsid            ), // (ds_wdata_bresp) <= ()
	.mst12_connect      (mst12_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST12_SUPPORT
`ifdef ATCBMC300_MST13_SUPPORT
	.mst13_wvalid       (mst13_wvalid          ), // (ds_wdata_bresp) <= ()
	.mst13_wlast        (mst13_wlast           ), // (ds_wdata_bresp) <= ()
	.mst13_wdata        (mst13_wdata           ), // (ds_wdata_bresp) <= ()
	.mst13_wstrb        (mst13_wstrb           ), // (ds_wdata_bresp) <= ()
	.mst13_wsid         (mst13_wsid            ), // (ds_wdata_bresp) <= ()
	.mst13_bready       (mst13_bready          ), // (ds_wdata_bresp) <= ()
	.mst13_bsid         (mst13_bsid            ), // (ds_wdata_bresp) <= ()
	.mst13_connect      (mst13_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST13_SUPPORT
`ifdef ATCBMC300_MST14_SUPPORT
	.mst14_wvalid       (mst14_wvalid          ), // (ds_wdata_bresp) <= ()
	.mst14_wlast        (mst14_wlast           ), // (ds_wdata_bresp) <= ()
	.mst14_wdata        (mst14_wdata           ), // (ds_wdata_bresp) <= ()
	.mst14_wstrb        (mst14_wstrb           ), // (ds_wdata_bresp) <= ()
	.mst14_wsid         (mst14_wsid            ), // (ds_wdata_bresp) <= ()
	.mst14_bready       (mst14_bready          ), // (ds_wdata_bresp) <= ()
	.mst14_bsid         (mst14_bsid            ), // (ds_wdata_bresp) <= ()
	.mst14_connect      (mst14_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST14_SUPPORT
`ifdef ATCBMC300_MST15_SUPPORT
	.mst15_wvalid       (mst15_wvalid          ), // (ds_wdata_bresp) <= ()
	.mst15_wlast        (mst15_wlast           ), // (ds_wdata_bresp) <= ()
	.mst15_wdata        (mst15_wdata           ), // (ds_wdata_bresp) <= ()
	.mst15_wstrb        (mst15_wstrb           ), // (ds_wdata_bresp) <= ()
	.mst15_wsid         (mst15_wsid            ), // (ds_wdata_bresp) <= ()
	.mst15_bready       (mst15_bready          ), // (ds_wdata_bresp) <= ()
	.mst15_bsid         (mst15_bsid            ), // (ds_wdata_bresp) <= ()
	.mst15_connect      (mst15_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST15_SUPPORT
	.ds_wdata           (ds_wdata              ), // (ds_wdata_bresp) => ()
	.ds_wlast           (ds_wlast              ), // (ds_wdata_bresp) => ()
	.ds_wstrb           (ds_wstrb              ), // (ds_wdata_bresp) => ()
	.ds_wvalid          (ds_wvalid             ), // (ds_wdata_bresp) => ()
	.ds_wready          (ds_wready             ), // (ds_wdata_bresp) <= ()
	.slv_wmid           (slv_wmid              ), // (ds_wdata_bresp) => ()
	.slv_wready         (slv_wready            ), // (ds_wdata_bresp) => ()
	.outstanding_ready  (aw_outstanding_ready  ), // (ds_wdata_bresp) => (ds_aw_addr)
	.slv_aid            (slv_aw_mid            ), // (ds_wdata_bresp) <= (ds_aw_addr)
	.addr_outstanding_en(aw_addr_outstanding_en), // (ds_wdata_bresp) <= (ds_aw_addr)
	.ds_bresp           (ds_bresp              ), // (ds_wdata_bresp) <= ()
	.ds_bid             (ds_bid                ), // (ds_wdata_bresp) <= ()
	.ds_bvalid          (ds_bvalid             ), // (ds_wdata_bresp) <= ()
	.ds_bready          (ds_bready             ), // (ds_wdata_bresp) => ()
	.slv_bvalid         (slv_bvalid            ), // (ds_wdata_bresp) => ()
	.slv_bresp          (slv_bresp             ), // (ds_wdata_bresp) => ()
	.slv_bid            (slv_bid               ), // (ds_wdata_bresp) => ()
	.aclk               (aclk                  ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	.aresetn            (aresetn               )  // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
); // end of ds_wdata_bresp

atcbmc300_ds_addr_ctrl #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        )
) ds_ar_addr (
`ifdef ATCBMC300_MST0_SUPPORT
	.mst0_addr             (mst0_araddr           ), // (ds_ar_addr) <= ()
	.mst0_len              (mst0_arlen            ), // (ds_ar_addr) <= ()
	.mst0_size             (mst0_arsize           ), // (ds_ar_addr) <= ()
	.mst0_burst            (mst0_arburst          ), // (ds_ar_addr) <= ()
	.mst0_lock             (mst0_arlock           ), // (ds_ar_addr) <= ()
	.mst0_cache            (mst0_arcache          ), // (ds_ar_addr) <= ()
	.mst0_prot             (mst0_arprot           ), // (ds_ar_addr) <= ()
	.mst0_aid              (mst0_arid             ), // (ds_ar_addr) <= ()
	.mst0_avalid           (mst0_arvalid          ), // (ds_ar_addr) <= ()
	.mst0_connect          (mst0_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST0_SUPPORT
`ifdef ATCBMC300_MST1_SUPPORT
	.mst1_addr             (mst1_araddr           ), // (ds_ar_addr) <= ()
	.mst1_len              (mst1_arlen            ), // (ds_ar_addr) <= ()
	.mst1_size             (mst1_arsize           ), // (ds_ar_addr) <= ()
	.mst1_burst            (mst1_arburst          ), // (ds_ar_addr) <= ()
	.mst1_lock             (mst1_arlock           ), // (ds_ar_addr) <= ()
	.mst1_cache            (mst1_arcache          ), // (ds_ar_addr) <= ()
	.mst1_prot             (mst1_arprot           ), // (ds_ar_addr) <= ()
	.mst1_aid              (mst1_arid             ), // (ds_ar_addr) <= ()
	.mst1_avalid           (mst1_arvalid          ), // (ds_ar_addr) <= ()
	.mst1_connect          (mst1_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST1_SUPPORT
`ifdef ATCBMC300_MST2_SUPPORT
	.mst2_addr             (mst2_araddr           ), // (ds_ar_addr) <= ()
	.mst2_len              (mst2_arlen            ), // (ds_ar_addr) <= ()
	.mst2_size             (mst2_arsize           ), // (ds_ar_addr) <= ()
	.mst2_burst            (mst2_arburst          ), // (ds_ar_addr) <= ()
	.mst2_lock             (mst2_arlock           ), // (ds_ar_addr) <= ()
	.mst2_cache            (mst2_arcache          ), // (ds_ar_addr) <= ()
	.mst2_prot             (mst2_arprot           ), // (ds_ar_addr) <= ()
	.mst2_aid              (mst2_arid             ), // (ds_ar_addr) <= ()
	.mst2_avalid           (mst2_arvalid          ), // (ds_ar_addr) <= ()
	.mst2_connect          (mst2_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST2_SUPPORT
`ifdef ATCBMC300_MST3_SUPPORT
	.mst3_addr             (mst3_araddr           ), // (ds_ar_addr) <= ()
	.mst3_len              (mst3_arlen            ), // (ds_ar_addr) <= ()
	.mst3_size             (mst3_arsize           ), // (ds_ar_addr) <= ()
	.mst3_burst            (mst3_arburst          ), // (ds_ar_addr) <= ()
	.mst3_lock             (mst3_arlock           ), // (ds_ar_addr) <= ()
	.mst3_cache            (mst3_arcache          ), // (ds_ar_addr) <= ()
	.mst3_prot             (mst3_arprot           ), // (ds_ar_addr) <= ()
	.mst3_aid              (mst3_arid             ), // (ds_ar_addr) <= ()
	.mst3_avalid           (mst3_arvalid          ), // (ds_ar_addr) <= ()
	.mst3_connect          (mst3_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST3_SUPPORT
`ifdef ATCBMC300_MST4_SUPPORT
	.mst4_addr             (mst4_araddr           ), // (ds_ar_addr) <= ()
	.mst4_len              (mst4_arlen            ), // (ds_ar_addr) <= ()
	.mst4_size             (mst4_arsize           ), // (ds_ar_addr) <= ()
	.mst4_burst            (mst4_arburst          ), // (ds_ar_addr) <= ()
	.mst4_lock             (mst4_arlock           ), // (ds_ar_addr) <= ()
	.mst4_cache            (mst4_arcache          ), // (ds_ar_addr) <= ()
	.mst4_prot             (mst4_arprot           ), // (ds_ar_addr) <= ()
	.mst4_aid              (mst4_arid             ), // (ds_ar_addr) <= ()
	.mst4_avalid           (mst4_arvalid          ), // (ds_ar_addr) <= ()
	.mst4_connect          (mst4_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST4_SUPPORT
`ifdef ATCBMC300_MST5_SUPPORT
	.mst5_addr             (mst5_araddr           ), // (ds_ar_addr) <= ()
	.mst5_len              (mst5_arlen            ), // (ds_ar_addr) <= ()
	.mst5_size             (mst5_arsize           ), // (ds_ar_addr) <= ()
	.mst5_burst            (mst5_arburst          ), // (ds_ar_addr) <= ()
	.mst5_lock             (mst5_arlock           ), // (ds_ar_addr) <= ()
	.mst5_cache            (mst5_arcache          ), // (ds_ar_addr) <= ()
	.mst5_prot             (mst5_arprot           ), // (ds_ar_addr) <= ()
	.mst5_aid              (mst5_arid             ), // (ds_ar_addr) <= ()
	.mst5_avalid           (mst5_arvalid          ), // (ds_ar_addr) <= ()
	.mst5_connect          (mst5_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST5_SUPPORT
`ifdef ATCBMC300_MST6_SUPPORT
	.mst6_addr             (mst6_araddr           ), // (ds_ar_addr) <= ()
	.mst6_len              (mst6_arlen            ), // (ds_ar_addr) <= ()
	.mst6_size             (mst6_arsize           ), // (ds_ar_addr) <= ()
	.mst6_burst            (mst6_arburst          ), // (ds_ar_addr) <= ()
	.mst6_lock             (mst6_arlock           ), // (ds_ar_addr) <= ()
	.mst6_cache            (mst6_arcache          ), // (ds_ar_addr) <= ()
	.mst6_prot             (mst6_arprot           ), // (ds_ar_addr) <= ()
	.mst6_aid              (mst6_arid             ), // (ds_ar_addr) <= ()
	.mst6_avalid           (mst6_arvalid          ), // (ds_ar_addr) <= ()
	.mst6_connect          (mst6_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST6_SUPPORT
`ifdef ATCBMC300_MST7_SUPPORT
	.mst7_addr             (mst7_araddr           ), // (ds_ar_addr) <= ()
	.mst7_len              (mst7_arlen            ), // (ds_ar_addr) <= ()
	.mst7_size             (mst7_arsize           ), // (ds_ar_addr) <= ()
	.mst7_burst            (mst7_arburst          ), // (ds_ar_addr) <= ()
	.mst7_lock             (mst7_arlock           ), // (ds_ar_addr) <= ()
	.mst7_cache            (mst7_arcache          ), // (ds_ar_addr) <= ()
	.mst7_prot             (mst7_arprot           ), // (ds_ar_addr) <= ()
	.mst7_aid              (mst7_arid             ), // (ds_ar_addr) <= ()
	.mst7_avalid           (mst7_arvalid          ), // (ds_ar_addr) <= ()
	.mst7_connect          (mst7_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST7_SUPPORT
`ifdef ATCBMC300_MST8_SUPPORT
	.mst8_addr             (mst8_araddr           ), // (ds_ar_addr) <= ()
	.mst8_len              (mst8_arlen            ), // (ds_ar_addr) <= ()
	.mst8_size             (mst8_arsize           ), // (ds_ar_addr) <= ()
	.mst8_burst            (mst8_arburst          ), // (ds_ar_addr) <= ()
	.mst8_lock             (mst8_arlock           ), // (ds_ar_addr) <= ()
	.mst8_cache            (mst8_arcache          ), // (ds_ar_addr) <= ()
	.mst8_prot             (mst8_arprot           ), // (ds_ar_addr) <= ()
	.mst8_aid              (mst8_arid             ), // (ds_ar_addr) <= ()
	.mst8_avalid           (mst8_arvalid          ), // (ds_ar_addr) <= ()
	.mst8_connect          (mst8_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST8_SUPPORT
`ifdef ATCBMC300_MST9_SUPPORT
	.mst9_addr             (mst9_araddr           ), // (ds_ar_addr) <= ()
	.mst9_len              (mst9_arlen            ), // (ds_ar_addr) <= ()
	.mst9_size             (mst9_arsize           ), // (ds_ar_addr) <= ()
	.mst9_burst            (mst9_arburst          ), // (ds_ar_addr) <= ()
	.mst9_lock             (mst9_arlock           ), // (ds_ar_addr) <= ()
	.mst9_cache            (mst9_arcache          ), // (ds_ar_addr) <= ()
	.mst9_prot             (mst9_arprot           ), // (ds_ar_addr) <= ()
	.mst9_aid              (mst9_arid             ), // (ds_ar_addr) <= ()
	.mst9_avalid           (mst9_arvalid          ), // (ds_ar_addr) <= ()
	.mst9_connect          (mst9_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST9_SUPPORT
`ifdef ATCBMC300_MST10_SUPPORT
	.mst10_addr            (mst10_araddr          ), // (ds_ar_addr) <= ()
	.mst10_len             (mst10_arlen           ), // (ds_ar_addr) <= ()
	.mst10_size            (mst10_arsize          ), // (ds_ar_addr) <= ()
	.mst10_burst           (mst10_arburst         ), // (ds_ar_addr) <= ()
	.mst10_lock            (mst10_arlock          ), // (ds_ar_addr) <= ()
	.mst10_cache           (mst10_arcache         ), // (ds_ar_addr) <= ()
	.mst10_prot            (mst10_arprot          ), // (ds_ar_addr) <= ()
	.mst10_aid             (mst10_arid            ), // (ds_ar_addr) <= ()
	.mst10_avalid          (mst10_arvalid         ), // (ds_ar_addr) <= ()
	.mst10_connect         (mst10_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST10_SUPPORT
`ifdef ATCBMC300_MST11_SUPPORT
	.mst11_addr            (mst11_araddr          ), // (ds_ar_addr) <= ()
	.mst11_len             (mst11_arlen           ), // (ds_ar_addr) <= ()
	.mst11_size            (mst11_arsize          ), // (ds_ar_addr) <= ()
	.mst11_burst           (mst11_arburst         ), // (ds_ar_addr) <= ()
	.mst11_lock            (mst11_arlock          ), // (ds_ar_addr) <= ()
	.mst11_cache           (mst11_arcache         ), // (ds_ar_addr) <= ()
	.mst11_prot            (mst11_arprot          ), // (ds_ar_addr) <= ()
	.mst11_aid             (mst11_arid            ), // (ds_ar_addr) <= ()
	.mst11_avalid          (mst11_arvalid         ), // (ds_ar_addr) <= ()
	.mst11_connect         (mst11_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST11_SUPPORT
`ifdef ATCBMC300_MST12_SUPPORT
	.mst12_addr            (mst12_araddr          ), // (ds_ar_addr) <= ()
	.mst12_len             (mst12_arlen           ), // (ds_ar_addr) <= ()
	.mst12_size            (mst12_arsize          ), // (ds_ar_addr) <= ()
	.mst12_burst           (mst12_arburst         ), // (ds_ar_addr) <= ()
	.mst12_lock            (mst12_arlock          ), // (ds_ar_addr) <= ()
	.mst12_cache           (mst12_arcache         ), // (ds_ar_addr) <= ()
	.mst12_prot            (mst12_arprot          ), // (ds_ar_addr) <= ()
	.mst12_aid             (mst12_arid            ), // (ds_ar_addr) <= ()
	.mst12_avalid          (mst12_arvalid         ), // (ds_ar_addr) <= ()
	.mst12_connect         (mst12_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST12_SUPPORT
`ifdef ATCBMC300_MST13_SUPPORT
	.mst13_addr            (mst13_araddr          ), // (ds_ar_addr) <= ()
	.mst13_len             (mst13_arlen           ), // (ds_ar_addr) <= ()
	.mst13_size            (mst13_arsize          ), // (ds_ar_addr) <= ()
	.mst13_burst           (mst13_arburst         ), // (ds_ar_addr) <= ()
	.mst13_lock            (mst13_arlock          ), // (ds_ar_addr) <= ()
	.mst13_cache           (mst13_arcache         ), // (ds_ar_addr) <= ()
	.mst13_prot            (mst13_arprot          ), // (ds_ar_addr) <= ()
	.mst13_aid             (mst13_arid            ), // (ds_ar_addr) <= ()
	.mst13_avalid          (mst13_arvalid         ), // (ds_ar_addr) <= ()
	.mst13_connect         (mst13_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST13_SUPPORT
`ifdef ATCBMC300_MST14_SUPPORT
	.mst14_addr            (mst14_araddr          ), // (ds_ar_addr) <= ()
	.mst14_len             (mst14_arlen           ), // (ds_ar_addr) <= ()
	.mst14_size            (mst14_arsize          ), // (ds_ar_addr) <= ()
	.mst14_burst           (mst14_arburst         ), // (ds_ar_addr) <= ()
	.mst14_lock            (mst14_arlock          ), // (ds_ar_addr) <= ()
	.mst14_cache           (mst14_arcache         ), // (ds_ar_addr) <= ()
	.mst14_prot            (mst14_arprot          ), // (ds_ar_addr) <= ()
	.mst14_aid             (mst14_arid            ), // (ds_ar_addr) <= ()
	.mst14_avalid          (mst14_arvalid         ), // (ds_ar_addr) <= ()
	.mst14_connect         (mst14_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST14_SUPPORT
`ifdef ATCBMC300_MST15_SUPPORT
	.mst15_addr            (mst15_araddr          ), // (ds_ar_addr) <= ()
	.mst15_len             (mst15_arlen           ), // (ds_ar_addr) <= ()
	.mst15_size            (mst15_arsize          ), // (ds_ar_addr) <= ()
	.mst15_burst           (mst15_arburst         ), // (ds_ar_addr) <= ()
	.mst15_lock            (mst15_arlock          ), // (ds_ar_addr) <= ()
	.mst15_cache           (mst15_arcache         ), // (ds_ar_addr) <= ()
	.mst15_prot            (mst15_arprot          ), // (ds_ar_addr) <= ()
	.mst15_aid             (mst15_arid            ), // (ds_ar_addr) <= ()
	.mst15_avalid          (mst15_arvalid         ), // (ds_ar_addr) <= ()
	.mst15_connect         (mst15_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST15_SUPPORT
	.addr_outstanding_en   (ar_addr_outstanding_en), // (ds_ar_addr) => (ds_rd_data)
	.slv_aready            (slv_arready           ), // (ds_ar_addr) => ()
	.arb_mid               (slv_ar_mid            ), // (ds_ar_addr) => ()
	.outstanding_ready     (ar_outstanding_ready  ), // (ds_ar_addr) <= (ds_rd_data)
	.addr                  (ds_araddr             ), // (ds_ar_addr) => ()
	.len                   (ds_arlen              ), // (ds_ar_addr) => ()
	.size                  (ds_arsize             ), // (ds_ar_addr) => ()
	.burst                 (ds_arburst            ), // (ds_ar_addr) => ()
	.lock                  (ds_arlock             ), // (ds_ar_addr) => ()
	.cache                 (ds_arcache            ), // (ds_ar_addr) => ()
	.prot                  (ds_arprot             ), // (ds_ar_addr) => ()
	.aid                   (ds_arid               ), // (ds_ar_addr) => ()
	.avalid                (ds_arvalid            ), // (ds_ar_addr) => ()
	.aready                (ds_arready            ), // (ds_ar_addr) <= ()
	.reg_mst0_high_priority(reg_mst0_high_priority), // (ds_ar_addr,ds_aw_addr) <= ()
	.reg_priority_reload   (reg_priority_reload   ), // (ds_ar_addr,ds_aw_addr) <= ()
	.aclk                  (aclk                  ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	.aresetn               (aresetn               )  // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
); // end of ds_ar_addr

atcbmc300_ds_rdata_ctrl #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(SLAVE_FIFO_DEPTH)
) ds_rd_data (
	.self_id            (self_id               ), // (ds_rd_data,ds_wdata_bresp) <= ()
`ifdef ATCBMC300_MST0_SUPPORT
	.mst0_rready        (mst0_rready           ), // (ds_rd_data) <= ()
	.mst0_rsid          (mst0_rsid             ), // (ds_rd_data) <= ()
	.mst0_connect       (mst0_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST0_SUPPORT
`ifdef ATCBMC300_MST1_SUPPORT
	.mst1_rready        (mst1_rready           ), // (ds_rd_data) <= ()
	.mst1_rsid          (mst1_rsid             ), // (ds_rd_data) <= ()
	.mst1_connect       (mst1_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST1_SUPPORT
`ifdef ATCBMC300_MST2_SUPPORT
	.mst2_rready        (mst2_rready           ), // (ds_rd_data) <= ()
	.mst2_rsid          (mst2_rsid             ), // (ds_rd_data) <= ()
	.mst2_connect       (mst2_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST2_SUPPORT
`ifdef ATCBMC300_MST3_SUPPORT
	.mst3_rready        (mst3_rready           ), // (ds_rd_data) <= ()
	.mst3_rsid          (mst3_rsid             ), // (ds_rd_data) <= ()
	.mst3_connect       (mst3_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST3_SUPPORT
`ifdef ATCBMC300_MST4_SUPPORT
	.mst4_rready        (mst4_rready           ), // (ds_rd_data) <= ()
	.mst4_rsid          (mst4_rsid             ), // (ds_rd_data) <= ()
	.mst4_connect       (mst4_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST4_SUPPORT
`ifdef ATCBMC300_MST5_SUPPORT
	.mst5_rready        (mst5_rready           ), // (ds_rd_data) <= ()
	.mst5_rsid          (mst5_rsid             ), // (ds_rd_data) <= ()
	.mst5_connect       (mst5_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST5_SUPPORT
`ifdef ATCBMC300_MST6_SUPPORT
	.mst6_rready        (mst6_rready           ), // (ds_rd_data) <= ()
	.mst6_rsid          (mst6_rsid             ), // (ds_rd_data) <= ()
	.mst6_connect       (mst6_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST6_SUPPORT
`ifdef ATCBMC300_MST7_SUPPORT
	.mst7_rready        (mst7_rready           ), // (ds_rd_data) <= ()
	.mst7_rsid          (mst7_rsid             ), // (ds_rd_data) <= ()
	.mst7_connect       (mst7_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST7_SUPPORT
`ifdef ATCBMC300_MST8_SUPPORT
	.mst8_rready        (mst8_rready           ), // (ds_rd_data) <= ()
	.mst8_rsid          (mst8_rsid             ), // (ds_rd_data) <= ()
	.mst8_connect       (mst8_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST8_SUPPORT
`ifdef ATCBMC300_MST9_SUPPORT
	.mst9_rready        (mst9_rready           ), // (ds_rd_data) <= ()
	.mst9_rsid          (mst9_rsid             ), // (ds_rd_data) <= ()
	.mst9_connect       (mst9_connect          ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST9_SUPPORT
`ifdef ATCBMC300_MST10_SUPPORT
	.mst10_rready       (mst10_rready          ), // (ds_rd_data) <= ()
	.mst10_rsid         (mst10_rsid            ), // (ds_rd_data) <= ()
	.mst10_connect      (mst10_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST10_SUPPORT
`ifdef ATCBMC300_MST11_SUPPORT
	.mst11_rready       (mst11_rready          ), // (ds_rd_data) <= ()
	.mst11_rsid         (mst11_rsid            ), // (ds_rd_data) <= ()
	.mst11_connect      (mst11_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST11_SUPPORT
`ifdef ATCBMC300_MST12_SUPPORT
	.mst12_rready       (mst12_rready          ), // (ds_rd_data) <= ()
	.mst12_rsid         (mst12_rsid            ), // (ds_rd_data) <= ()
	.mst12_connect      (mst12_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST12_SUPPORT
`ifdef ATCBMC300_MST13_SUPPORT
	.mst13_rready       (mst13_rready          ), // (ds_rd_data) <= ()
	.mst13_rsid         (mst13_rsid            ), // (ds_rd_data) <= ()
	.mst13_connect      (mst13_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST13_SUPPORT
`ifdef ATCBMC300_MST14_SUPPORT
	.mst14_rready       (mst14_rready          ), // (ds_rd_data) <= ()
	.mst14_rsid         (mst14_rsid            ), // (ds_rd_data) <= ()
	.mst14_connect      (mst14_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST14_SUPPORT
`ifdef ATCBMC300_MST15_SUPPORT
	.mst15_rready       (mst15_rready          ), // (ds_rd_data) <= ()
	.mst15_rsid         (mst15_rsid            ), // (ds_rd_data) <= ()
	.mst15_connect      (mst15_connect         ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
`endif // ATCBMC300_MST15_SUPPORT
	.ds_rdata           (ds_rdata              ), // (ds_rd_data) <= ()
	.ds_rresp           (ds_rresp              ), // (ds_rd_data) <= ()
	.ds_rid             (ds_rid                ), // (ds_rd_data) <= ()
	.ds_rlast           (ds_rlast              ), // (ds_rd_data) <= ()
	.ds_rvalid          (ds_rvalid             ), // (ds_rd_data) <= ()
	.ds_rready          (ds_rready             ), // (ds_rd_data) => ()
	.slv_rvalid         (slv_rvalid            ), // (ds_rd_data) => ()
	.slv_read_data      (slv_read_data         ), // (ds_rd_data) => ()
	.slv_rid            (slv_rid               ), // (ds_rd_data) => ()
	.outstanding_ready  (ar_outstanding_ready  ), // (ds_rd_data) => (ds_ar_addr)
	.addr_outstanding_en(ar_addr_outstanding_en), // (ds_rd_data) <= (ds_ar_addr)
	.aclk               (aclk                  ), // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
	.aresetn            (aresetn               )  // (ds_ar_addr,ds_aw_addr,ds_rd_data,ds_wdata_bresp) <= ()
); // end of ds_rd_data

endmodule
// VPERL_GENERATED_END
