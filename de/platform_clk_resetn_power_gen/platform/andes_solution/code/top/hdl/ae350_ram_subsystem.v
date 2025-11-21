`include "config.inc"
`include "global.inc"
`include "ae350_config.vh"
`include "ae350_const.vh"

`ifdef AE350_K7DDR3_SUPPORT
	`ifdef AE350_AHB_SUPPORT
`include "memc_wrapper_config.vh"
`include "memc_wrapper_const.vh"
	`endif
`endif // AE350_K7DDR3_SUPPORT


// VPERL_BEGIN
// &MODULE("ae350_ram_subsystem");
// &PARAM("SIMULATION = \"FALSE\" ");
// &PARAM("SIM_BYPASS_INIT_CAL = \"OFF\" ");
// &PARAM("ID_WIDTH = 4 ");
// &PARAM("ADDR_WIDTH = 32 ");
// &PARAM("DATA_WIDTH = 64 ");
// &LOCALPARAM("ADDR_MSB = ADDR_WIDTH-1 ");

// &LOCALPARAM("DDR3_WRAPPER_DATA_WIDTH = 64 ");
// &LOCALPARAM("DDR4_WRAPPER_DATA_WIDTH = 64 ");

// &PARAM("RAMBRG_ADDR_WIDTH       = 23");
// &LOCALPARAM("MEM_SIZE_KB     = (1 << (RAMBRG_ADDR_WIDTH - 10))");
// &LOCALPARAM("MEM_ADDR_LSB    = \$clog2(DATA_WIDTH/8)");
// &LOCALPARAM("MEM_ADDR_MSB    = \$clog2(MEM_SIZE_KB) - 1 + 10");
// &LOCALPARAM("MEM_ADDR_WIDTH  = MEM_ADDR_MSB - MEM_ADDR_LSB + 1");
//
// &FORCE("output", "ui_clk");
// &FORCE("input", "T_por_b");
//&IFDEF("AE350_AXI_SUPPORT");
// &FORCE("input",  "aclk");
// &FORCE("input",  "aresetn");
// &FORCE("input", "araddr[ADDR_WIDTH-1:0]");
// &FORCE("input", "arburst[1:0]");
// &FORCE("input", "arcache[3:0]");
// &FORCE("input", "arid[(ID_WIDTH-1):0]");
// &FORCE("input", "arlen[7:0]");
// &FORCE("input", "arlock");
// &FORCE("input", "arprot[2:0]");
// &FORCE("input", "arsize[2:0]");
// &FORCE("input", "arvalid");
// &FORCE("output",  "arready");

// &FORCE("input", "awaddr[ADDR_WIDTH-1:0]");
// &FORCE("input", "awburst[1:0]");
// &FORCE("input", "awcache[3:0]");
// &FORCE("input", "awid[(ID_WIDTH-1):0]");
// &FORCE("input", "awlen[7:0]");
// &FORCE("input", "awlock");
// &FORCE("input", "awprot[2:0]");
// &FORCE("input", "awsize[2:0]");
// &FORCE("input", "awvalid");
// &FORCE("output",  "awready");

// &FORCE("output",  "rdata[DATA_WIDTH-1:0]");
// &FORCE("output",  "rid[(ID_WIDTH-1):0]");
// &FORCE("output",  "rlast");
// &FORCE("output",  "rresp[1:0]");
// &FORCE("output",  "rvalid");
// &FORCE("input", "rready");

// &FORCE("input", "wdata[DATA_WIDTH-1:0]");
// &FORCE("input", "wlast");
// &FORCE("input", "wstrb[(DATA_WIDTH/8)-1:0]");
// &FORCE("input", "wvalid");
// &FORCE("output",  "wready");

// &FORCE("output",  "bid[(ID_WIDTH-1):0]");
// &FORCE("output",  "bresp[1:0]");
// &FORCE("output",  "bvalid");
// &FORCE("input", "bready");
//
// &ELSE("AE350_AXI_SUPPORT");
//
// &FORCE("input",  "hclk");
// &FORCE("input",  "hresetn");
// &FORCE("input",  "haddr[ADDR_WIDTH-1:0]");
// &FORCE("input",  "hburst[2:0]");
// &FORCE("input",  "hprot[3:0]");
// &FORCE("input",  "hready");
// &FORCE("input",  "hsel");
// &FORCE("input",  "hsize[2:0]");
// &FORCE("input",  "htrans[1:0]");
// &FORCE("input",  "hwdata[DATA_WIDTH-1:0]");
// &FORCE("input",  "hwrite");
// &FORCE("output", "hrdata[DATA_WIDTH-1:0]");
// &FORCE("output", "hreadyout");
// &FORCE("output", "hresp[1:0]");
// &ENDIF("AE350_AXI_SUPPORT");
// &FORCE("output", "init_calib_complete");
//

// &IFDEF("AE350_K7DDR3_SUPPORT");
// &DANGLER("ui_clk_sync_rst");
// &FORCE("inout", "X_ddr3_dq");
// &FORCE("inout", "X_ddr3_dqs_n");
// &FORCE("inout", "X_ddr3_dqs_p");
//
// &DANGLER("ddr3_init_calib_complete");
//#   	SIM_BYPASS_INIT_CAL 	=> "SIM_BYPASS_INIT_CAL",
//#	ID_WIDTH 		=> "ID_WIDTH",
//&IFDEF("AE350_AXI_SUPPORT");

//	&GENERATE_IF("(DATA_WIDTH > DDR3_WRAPPER_DATA_WIDTH)", "gen_axi_sdn");
//	#------ sizedn for gt-axibus to 32-hbmc ------
//	&INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300.v", "u_axi_sdn", {
//		ID_WIDTH	=> "ID_WIDTH",
//		ADDR_WIDTH	=> "ADDR_WIDTH",
//		US_DATA_WIDTH	=> "DATA_WIDTH",
//		DS_DATA_WIDTH	=> "DDR3_WRAPPER_DATA_WIDTH",
//	});
//	&CONNECT("u_axi_sdn.aclk",		"aclk");
//	&CONNECT("u_axi_sdn.aresetn",		"aresetn");

//	&CONNECT("u_axi_sdn.us_araddr",		"araddr");
//	&CONNECT("u_axi_sdn.us_arburst",	"arburst");
//	&CONNECT("u_axi_sdn.us_arcache",	"arcache");
//	&CONNECT("u_axi_sdn.us_arid",		"arid");
//	&CONNECT("u_axi_sdn.us_arlen",		"arlen");
//	&CONNECT("u_axi_sdn.us_arlock",		"arlock");
//	&CONNECT("u_axi_sdn.us_arprot",		"arprot");
//	&CONNECT("u_axi_sdn.us_arsize",		"arsize");
//	&CONNECT("u_axi_sdn.us_arvalid",	"arvalid");
//	&CONNECT("u_axi_sdn.us_arready",	"arready");
//	&CONNECT("u_axi_sdn.us_awaddr",		"awaddr");
//	&CONNECT("u_axi_sdn.us_awburst",	"awburst");
//	&CONNECT("u_axi_sdn.us_awcache",	"awcache");
//	&CONNECT("u_axi_sdn.us_awid",		"awid");
//	&CONNECT("u_axi_sdn.us_awlen",		"awlen");
//	&CONNECT("u_axi_sdn.us_awlock",		"awlock");
//	&CONNECT("u_axi_sdn.us_awprot",		"awprot");
//	&CONNECT("u_axi_sdn.us_awsize",		"awsize");
//	&CONNECT("u_axi_sdn.us_awvalid",	"awvalid");
//	&CONNECT("u_axi_sdn.us_awready",	"awready");
//	&CONNECT("u_axi_sdn.us_wdata",		"wdata");
//	&CONNECT("u_axi_sdn.us_wlast",		"wlast");
//	&CONNECT("u_axi_sdn.us_wstrb",		"wstrb");
//	&CONNECT("u_axi_sdn.us_wvalid",		"wvalid");
//	&CONNECT("u_axi_sdn.us_wready",		"wready");
//	&CONNECT("u_axi_sdn.us_bready",		"bready");
//	&CONNECT("u_axi_sdn.us_bid",		"bid");
//	&CONNECT("u_axi_sdn.us_bresp",		"bresp");
//	&CONNECT("u_axi_sdn.us_bvalid",		"bvalid");
//	&CONNECT("u_axi_sdn.us_rdata",		"rdata");
//	&CONNECT("u_axi_sdn.us_rid",		"rid");
//	&CONNECT("u_axi_sdn.us_rlast",		"rlast");
//	&CONNECT("u_axi_sdn.us_rresp",		"rresp");
//	&CONNECT("u_axi_sdn.us_rvalid",		"rvalid");
//	&CONNECT("u_axi_sdn.us_rready",		"rready");
//
//	&CONNECT("u_axi_sdn.ds_araddr",		"ddr3_wrapper_araddr");
//	&CONNECT("u_axi_sdn.ds_arburst",	"ddr3_wrapper_arburst");
//	&CONNECT("u_axi_sdn.ds_arcache",	"ddr3_wrapper_arcache");
//	&CONNECT("u_axi_sdn.ds_arlen",		"ddr3_wrapper_arlen");
//	&CONNECT("u_axi_sdn.ds_arlock",		"ddr3_wrapper_arlock");
//	&CONNECT("u_axi_sdn.ds_arprot",		"ddr3_wrapper_arprot");
//	&CONNECT("u_axi_sdn.ds_arsize",		"ddr3_wrapper_arsize");
//	&CONNECT("u_axi_sdn.ds_arvalid",	"ddr3_wrapper_arvalid");
//	&CONNECT("u_axi_sdn.ds_arready",	"ddr3_wrapper_arready");
//	&CONNECT("u_axi_sdn.ds_awaddr",		"ddr3_wrapper_awaddr");
//	&CONNECT("u_axi_sdn.ds_awburst",	"ddr3_wrapper_awburst");
//	&CONNECT("u_axi_sdn.ds_awcache",	"ddr3_wrapper_awcache");
//	&CONNECT("u_axi_sdn.ds_awlen",		"ddr3_wrapper_awlen");
//	&CONNECT("u_axi_sdn.ds_awlock",		"ddr3_wrapper_awlock");
//	&CONNECT("u_axi_sdn.ds_awprot",		"ddr3_wrapper_awprot");
//	&CONNECT("u_axi_sdn.ds_awsize",		"ddr3_wrapper_awsize");
//	&CONNECT("u_axi_sdn.ds_awvalid",	"ddr3_wrapper_awvalid");
//	&CONNECT("u_axi_sdn.ds_awready",	"ddr3_wrapper_awready");
//	&CONNECT("u_axi_sdn.ds_wdata",		"ddr3_wrapper_wdata");
//	&CONNECT("u_axi_sdn.ds_wlast",		"ddr3_wrapper_wlast");
//	&CONNECT("u_axi_sdn.ds_wstrb",		"ddr3_wrapper_wstrb");
//	&CONNECT("u_axi_sdn.ds_wvalid",		"ddr3_wrapper_wvalid");
//	&CONNECT("u_axi_sdn.ds_wready",		"ddr3_wrapper_wready");
//	&CONNECT("u_axi_sdn.ds_bresp",		"ddr3_wrapper_bresp");
//	&CONNECT("u_axi_sdn.ds_bvalid",		"ddr3_wrapper_bvalid");
//	&CONNECT("u_axi_sdn.ds_bready",		"ddr3_wrapper_bready");
//	&CONNECT("u_axi_sdn.ds_rdata",		"ddr3_wrapper_rdata");
//	&CONNECT("u_axi_sdn.ds_rlast",		"ddr3_wrapper_rlast");
//	&CONNECT("u_axi_sdn.ds_rresp",		"ddr3_wrapper_rresp");
//	&CONNECT("u_axi_sdn.ds_rvalid",		"ddr3_wrapper_rvalid");
//	&CONNECT("u_axi_sdn.ds_rready",		"ddr3_wrapper_rready");

//	&FORCE("wire", "ddr3_wrapper_araddr[(ADDR_WIDTH-1):0]");
//	&FORCE("wire", "ddr3_wrapper_arburst[1:0]");
//	&FORCE("wire", "ddr3_wrapper_arcache[3:0]");
//	&FORCE("wire", "ddr3_wrapper_arid[(ID_WIDTH-1):0]");
//	&FORCE("wire", "ddr3_wrapper_arlen[7:0]");
//	&FORCE("wire", "ddr3_wrapper_arlock");
//	&FORCE("wire", "ddr3_wrapper_arprot[2:0]");
//	&FORCE("wire", "ddr3_wrapper_arready");
//	&FORCE("wire", "ddr3_wrapper_arsize[2:0]");
//	&FORCE("wire", "ddr3_wrapper_arvalid");
//	&FORCE("wire", "ddr3_wrapper_awaddr[(ADDR_WIDTH-1):0]");
//	&FORCE("wire", "ddr3_wrapper_awburst[1:0]");
//	&FORCE("wire", "ddr3_wrapper_awcache[3:0]");
//	&FORCE("wire", "ddr3_wrapper_awid[(ID_WIDTH-1):0]");
//	&FORCE("wire", "ddr3_wrapper_awlen[7:0]");
//	&FORCE("wire", "ddr3_wrapper_awlock");
//	&FORCE("wire", "ddr3_wrapper_awprot[2:0]");
//	&FORCE("wire", "ddr3_wrapper_awready");
//	&FORCE("wire", "ddr3_wrapper_awsize[2:0]");
//	&FORCE("wire", "ddr3_wrapper_awvalid");
//	&FORCE("wire", "ddr3_wrapper_wdata[(DDR3_WRAPPER_DATA_WIDTH-1):0]");
//	&FORCE("wire", "ddr3_wrapper_wstrb[((DDR3_WRAPPER_DATA_WIDTH/8)-1):0]");
//	&FORCE("wire", "ddr3_wrapper_wlast");
//	&FORCE("wire", "ddr3_wrapper_wvalid");
//	&FORCE("wire", "ddr3_wrapper_wready");
//	&FORCE("wire", "ddr3_wrapper_bid[(ID_WIDTH-1):0]");
//	&FORCE("wire", "ddr3_wrapper_bresp[1:0]");
//	&FORCE("wire", "ddr3_wrapper_bvalid");
//	&FORCE("wire", "ddr3_wrapper_bready");
//	&FORCE("wire", "ddr3_wrapper_rid[(ID_WIDTH-1):0]");
//	&FORCE("wire", "ddr3_wrapper_rdata[(DDR3_WRAPPER_DATA_WIDTH-1):0]");
//	&FORCE("wire", "ddr3_wrapper_rresp[1:0]");
//	&FORCE("wire", "ddr3_wrapper_rlast");
//	&FORCE("wire", "ddr3_wrapper_rvalid");
//	&FORCE("wire", "ddr3_wrapper_rready");
//	:`ifdef AE350_AXI_SUPPORT
//	:   `ifdef AE350_K7DDR3_SUPPORT
//	:generate
//	:if (DATA_WIDTH > DDR3_WRAPPER_DATA_WIDTH) begin: gen_connect_axi_sdn
//	:	assign ddr3_wrapper_arid = {(ID_WIDTH){1'b0}};
//	:	assign ddr3_wrapper_awid = {(ID_WIDTH){1'b0}};
//	:end
//	:else begin: gen_connect_axi
//	:		assign ddr3_wrapper_araddr  = araddr;
//	:		assign ddr3_wrapper_arburst = arburst;
//	:		assign ddr3_wrapper_arcache = arcache;
//	:		assign ddr3_wrapper_arid    = arid;
//	:		assign ddr3_wrapper_arlen   = arlen;
//	:		assign ddr3_wrapper_arlock  = arlock;
//	:		assign ddr3_wrapper_arprot  = arprot;
//	:		assign ddr3_wrapper_arsize  = arsize;
//	:		assign ddr3_wrapper_arvalid = arvalid;
//	:		assign arready              = ddr3_wrapper_arready;
//	:
//	:		assign ddr3_wrapper_awaddr  = awaddr;
//	:		assign ddr3_wrapper_awburst = awburst;
//	:		assign ddr3_wrapper_awcache = awcache;
//	:		assign ddr3_wrapper_awid    = awid;
//	:		assign ddr3_wrapper_awlen   = awlen;
//	:		assign ddr3_wrapper_awlock  = awlock;
//	:		assign ddr3_wrapper_awprot  = awprot;
//	:		assign ddr3_wrapper_awsize  = awsize;
//	:		assign ddr3_wrapper_awvalid = awvalid;
//	:		assign awready              = ddr3_wrapper_awready;
//	:
//	:		assign bid                  = ddr3_wrapper_bid;
//	:		assign bresp                = ddr3_wrapper_bresp;
//	:		assign bvalid               = ddr3_wrapper_bvalid;
//	:		assign ddr3_wrapper_bready  = bready;
//	:
//	:		assign rdata                = ddr3_wrapper_rdata;
//	:		assign rid                  = ddr3_wrapper_rid;
//	:		assign rlast                = ddr3_wrapper_rlast;
//	:		assign rresp                = ddr3_wrapper_rresp;
//	:		assign rvalid               = ddr3_wrapper_rvalid;
//	:		assign ddr3_wrapper_rready  = rready;
//	:
//	:		assign ddr3_wrapper_wdata   = wdata;
//	:		assign ddr3_wrapper_wlast   = wlast;
//	:		assign ddr3_wrapper_wstrb   = wstrb;
//	:		assign ddr3_wrapper_wvalid  = wvalid;
//	:		assign wready               = ddr3_wrapper_wready;
//	:end
//	:endgenerate
//	: `endif
//	:`endif
//	&ENDGENERATE();

// &INSTANCE("$PVC_LOCALDIR/andes_ip/soc/ddr3_wrapper/hdl/ddr3_wrapper.v","u_ddr3",{
//	ADDR_WIDTH 	=> "ADDR_WIDTH",
//	DATA_WIDTH 	=> "DDR3_WRAPPER_DATA_WIDTH",
//	ID_WIDTH        => "ID_WIDTH",
// });
// &CONNECT("u_ddr3",{
//	ddr3_aresetn	=> "ddr3_aresetn",
//	ddr3_dq     	=> "X_ddr3_dq",
//	ddr3_dqs_n  	=> "X_ddr3_dqs_n",
//	ddr3_dqs_p  	=> "X_ddr3_dqs_p",
//	ddr3_addr   	=> "X_ddr3_addr",
//	ddr3_ba     	=> "X_ddr3_ba",
//	ddr3_ras_n  	=> "X_ddr3_ras_n",
//	ddr3_cas_n  	=> "X_ddr3_cas_n",
//	ddr3_we_n   	=> "X_ddr3_we_n",
//	ddr3_reset_n	=> "X_ddr3_reset_n",
//	ddr3_ck_p   	=> "X_ddr3_ck_p",
//	ddr3_ck_n   	=> "X_ddr3_ck_n",
//	ddr3_cke    	=> "X_ddr3_cke",
//	ddr3_cs_n   	=> "X_ddr3_cs_n",
//	ddr3_dm     	=> "X_ddr3_dm",
//	ddr3_odt    	=> "X_ddr3_odt",
//	sys_clk_n   	=> "X_ddr3_sys_clk_n",
//	sys_clk_p   	=> "X_ddr3_sys_clk_p",
//	sys_rst     	=> "T_por_b",
//	device_temp 	=> "/* NC */",
// });

//	&CONNECT("u_ddr3.araddr",	"ddr3_wrapper_araddr");
//	&CONNECT("u_ddr3.arburst",	"ddr3_wrapper_arburst");
//	&CONNECT("u_ddr3.arcache",	"ddr3_wrapper_arcache");
//	&CONNECT("u_ddr3.arid",		"ddr3_wrapper_arid");
//	&CONNECT("u_ddr3.arlen",	"ddr3_wrapper_arlen");
//	&CONNECT("u_ddr3.arlock",	"ddr3_wrapper_arlock");
//	&CONNECT("u_ddr3.arprot",	"ddr3_wrapper_arprot");
//	&CONNECT("u_ddr3.arsize",	"ddr3_wrapper_arsize");
//	&CONNECT("u_ddr3.arvalid",	"ddr3_wrapper_arvalid");
//	&CONNECT("u_ddr3.arready",	"ddr3_wrapper_arready");
//	&CONNECT("u_ddr3.awaddr",	"ddr3_wrapper_awaddr");
//	&CONNECT("u_ddr3.awburst",	"ddr3_wrapper_awburst");
//	&CONNECT("u_ddr3.awcache",	"ddr3_wrapper_awcache");
//	&CONNECT("u_ddr3.awid",		"ddr3_wrapper_awid");
//	&CONNECT("u_ddr3.awlen",	"ddr3_wrapper_awlen");
//	&CONNECT("u_ddr3.awlock",	"ddr3_wrapper_awlock");
//	&CONNECT("u_ddr3.awprot",	"ddr3_wrapper_awprot");
//	&CONNECT("u_ddr3.awsize",	"ddr3_wrapper_awsize");
//	&CONNECT("u_ddr3.awvalid",	"ddr3_wrapper_awvalid");
//	&CONNECT("u_ddr3.awready",	"ddr3_wrapper_awready");
//	&CONNECT("u_ddr3.wdata",	"ddr3_wrapper_wdata");
//	&CONNECT("u_ddr3.wlast",	"ddr3_wrapper_wlast");
//	&CONNECT("u_ddr3.wstrb",	"ddr3_wrapper_wstrb");
//	&CONNECT("u_ddr3.wvalid",	"ddr3_wrapper_wvalid");
//	&CONNECT("u_ddr3.wready",	"ddr3_wrapper_wready");
//	&CONNECT("u_ddr3.bready",	"ddr3_wrapper_bready");
//	&CONNECT("u_ddr3.bid",		"ddr3_wrapper_bid");
//	&CONNECT("u_ddr3.bresp",	"ddr3_wrapper_bresp");
//	&CONNECT("u_ddr3.bvalid",	"ddr3_wrapper_bvalid");
//	&CONNECT("u_ddr3.rdata",	"ddr3_wrapper_rdata");
//	&CONNECT("u_ddr3.rid",		"ddr3_wrapper_rid");
//	&CONNECT("u_ddr3.rlast",	"ddr3_wrapper_rlast");
//	&CONNECT("u_ddr3.rresp",	"ddr3_wrapper_rresp");
//	&CONNECT("u_ddr3.rvalid",	"ddr3_wrapper_rvalid");
//	&CONNECT("u_ddr3.rready",	"ddr3_wrapper_rready");


// &ELSE("AE350_AXI_SUPPORT");
// &GENERATE_IF("(DATA_WIDTH > 32)", "gen_sizedn_hbmc");
//	#------ generate sizedn for system bus upstream ------
//	&INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcsizedn100/hdl/atcsizedn100.v", "u_sizedn_memc", {
//		ADDR_WIDTH	=> "ADDR_WIDTH",
//		US_DATA_WIDTH	=> "DATA_WIDTH",
//		DS_DATA_WIDTH	=> "32",
//	});
//	&CONNECT("u_sizedn_memc.hclk",	"hclk");
//	&CONNECT("u_sizedn_memc.hresetn",	"hresetn");
//	&CONNECT("u_sizedn_memc.us_hsel",	"1'b1");
//	&CONNECT("u_sizedn_memc.us_haddr",	"haddr");
//	&CONNECT("u_sizedn_memc.us_hburst",	"hburst");
//	&CONNECT("u_sizedn_memc.us_hprot",	"hprot");
//	&CONNECT("u_sizedn_memc.us_hsize",	"hsize");
//	&CONNECT("u_sizedn_memc.us_htrans",	"htrans");
//	&CONNECT("u_sizedn_memc.us_hwdata",	"hwdata");
//	&CONNECT("u_sizedn_memc.us_hwrite",	"hwrite");
//	&CONNECT("u_sizedn_memc.us_hrdata",	"hrdata");
//	&CONNECT("u_sizedn_memc.us_hready",	"hready");
//	&CONNECT("u_sizedn_memc.us_hreadyout",	"hreadyout");
//	&CONNECT("u_sizedn_memc.us_hresp",	"hresp[0]");
//
//	&CONNECT("u_sizedn_memc.ds_haddr",	"memc_haddr");
//	&CONNECT("u_sizedn_memc.ds_hburst",	"memc_hburst");
//	&CONNECT("u_sizedn_memc.ds_hprot",	"memc_hprot");
//	&CONNECT("u_sizedn_memc.ds_hsize",	"memc_hsize");
//	&CONNECT("u_sizedn_memc.ds_htrans",	"memc_htrans");
//	&CONNECT("u_sizedn_memc.ds_hwdata",	"memc_hwdata");
//	&CONNECT("u_sizedn_memc.ds_hwrite",	"memc_hwrite");
//	&CONNECT("u_sizedn_memc.ds_hrdata",	"memc_hrdata");
//	&CONNECT("u_sizedn_memc.ds_hready",	"memc_hreadyout");
//	&CONNECT("u_sizedn_memc.ds_hresp",	"memc_hresp[0]");
//	&CONNECT("u_sizedn_memc.bufw_err",	"/* NC */");
//	&DANGLER("hbmc2sys_hresp_1bit");

// &FORCE("wire", "memc_haddr[ADDR_MSB:0]");
// &FORCE("wire", "memc_hburst[2:0]");
// &FORCE("wire", "memc_hprot[3:0]");
// &FORCE("wire", "memc_hsize[2:0]");
// &FORCE("wire", "memc_htrans[1:0]");
// &FORCE("wire", "memc_hwrite");
// &FORCE("wire", "memc_hwdata[31:0]");
// &FORCE("wire", "memc_hrdata[31:0]");
// &FORCE("wire", "memc_hready");
// &FORCE("wire", "memc_hresp[1:0]");
// &FORCE("wire", "memc_hsel");
// &FORCE("wire", "memc_hreadyout");

// &ENDGENERATE();
//:`ifdef AE350_AXI_SUPPORT
//:`else
//:	`ifdef AE350_K7DDR3_SUPPORT
//:generate
//:if (DATA_WIDTH > 32) begin: gen_connect_memc_hresp_ahb_sdn
//:	assign memc_hsel   = 1'b1;
//:	assign memc_hready = memc_hreadyout;
//:	assign hresp[1]	= 1'b0;
//:end
//:endgenerate
//:generate
//:if (DATA_WIDTH > 32) begin: gen_connect_memc_ahb_sdn
//:end
//:else begin: gen_connect_hbmc_ahb
//:	assign memc_haddr  = haddr;
//:	assign memc_hburst = hburst;
//:	assign memc_hprot  = hprot;
//:	assign memc_hsize  = hsize;
//:	assign memc_htrans = htrans;
//:	assign memc_hwrite = hwrite;
//:	assign memc_hwdata = hwdata;
//:	assign memc_hsel   = 1'b1;
//:	assign memc_hready   = hready;
//:	assign hreadyout	= memc_hreadyout;
//:	assign hresp		= memc_hresp;
//:	assign hrdata		= memc_hrdata;
//:end
//:endgenerate
//:	`endif
//:`endif

//   &FORCE("wire", "memc_addr[29:0]");
//   &INSTANCE("$PVC_LOCALDIR/andes_ip/soc/memc_wrapper/hdl/memc_wrapper.v", "memc_wrapper");
//   &CONNECT("memc_wrapper", {
//     hclk          => "hclk",
//     hs0_haddr     => "memc_haddr",
//     hs0_hburst    => "memc_hburst",
//     hs0_hready_in => "memc_hready",
//     hs0_hsel      => "memc_hsel",
//     hs0_hsize     => "memc_hsize",
//     hs0_htrans    => "memc_htrans",
//     hs0_hwdata    => "memc_hwdata",
//     hs0_hwrite    => "memc_hwrite",
//     hs0_hrdata    => "memc_hrdata",
//     hs0_hready    => "memc_hreadyout",
//     hs0_hresp     => "memc_hresp",
//     hs1_haddr     => "",
//     hs1_hburst    => "",
//     hs1_hready_in => "",
//     hs1_hsel      => "",
//     hs1_hsize     => "",
//     hs1_htrans    => "",
//     hs1_hwdata    => "",
//     hs1_hwrite    => "",
//     hs1_hrdata    => "",
//     hs1_hready    => "",
//     hs1_hresp     => "",
//     hs2_haddr     => "",
//     hs2_hburst    => "",
//     hs2_hready_in => "",
//     hs2_hsel      => "",
//     hs2_hsize     => "",
//     hs2_htrans    => "",
//     hs2_hwdata    => "",
//     hs2_hwrite    => "",
//     hs2_hrdata    => "",
//     hs2_hready    => "",
//     hs2_hresp     => "",
//     hs3_haddr     => "",
//     hs3_hburst    => "",
//     hs3_hready_in => "",
//     hs3_hsel      => "",
//     hs3_hsize     => "",
//     hs3_htrans    => "",
//     hs3_hwdata    => "",
//     hs3_hwrite    => "",
//     hs3_hrdata    => "",
//     hs3_hready    => "",
//     hs3_hresp     => "",
//     memc_clk      => "ui_clk",
//     memc_resetn   => "!ui_clk_sync_rst"
//   });
//
//
//   #------------------------------------------------------------------------------
//   # DDR3 Controller
//   #------------------------------------------------------------------------------
//   &INSTANCE("$PVC_LOCALDIR/vendor_ip/xilinx_ip/xc7k/ddr3/hdl/top/ddr3_controller_stub.v", "ddr3_controller");
//   &CONNECT("ddr3_controller", {
//     app_addr           => "memc_addr[28:0]",
//     app_cmd            => "memc_cmd",
//     app_en             => "memc_en",
//     app_wdf_data       => "memc_wr_data",
//     app_wdf_end        => "memc_wr_end",
//     app_wdf_mask       => "memc_wr_mask",
//     app_wdf_wren       => "memc_wr_en",
//     app_rd_data        => "memc_rd_data",
//     app_rd_data_end    => "memc_rd_end",
//     app_rd_data_valid  => "memc_rd_valid",
//     app_rdy            => "memc_rdy",
//     app_wdf_rdy        => "memc_wr_rdy",
//     app_sr_req         => "1'b0",
//     app_sr_active      => "",
//     app_ref_req        => "1'b0",
//     app_ref_ack        => "",
//     app_zq_req         => "1'b0",
//     app_zq_ack         => "",
//     sys_rst            => "T_por_b",
//     sys_clk_p          => "X_ddr3_sys_clk_p",
//     sys_clk_n          => "X_ddr3_sys_clk_n",
//     ddr3_dq            => "X_ddr3_dq",
//     ddr3_dqs_n         => "X_ddr3_dqs_n  ",
//     ddr3_dqs_p         => "X_ddr3_dqs_p  ",
//     ddr3_addr          => "X_ddr3_addr   ",
//     ddr3_ba            => "X_ddr3_ba     ",
//     ddr3_ras_n         => "X_ddr3_ras_n  ",
//     ddr3_cas_n         => "X_ddr3_cas_n  ",
//     ddr3_we_n          => "X_ddr3_we_n   ",
//     ddr3_reset_n       => "X_ddr3_reset_n",
//     ddr3_ck_p          => "X_ddr3_ck_p   ",
//     ddr3_ck_n          => "X_ddr3_ck_n   ",
//     ddr3_cke           => "X_ddr3_cke    ",
//     ddr3_cs_n          => "X_ddr3_cs_n   ",
//     ddr3_dm            => "X_ddr3_dm     ",
//     ddr3_odt           => "X_ddr3_odt    ",
//     device_temp        => "/* NC */",
//   });
//
// &ENDIF("AE350_AXI_SUPPORT");
// &ELSE("AE350_K7DDR3_SUPPORT");
//&IFDEF("AE350_AXI_SUPPORT");
//  &IFDEF("AE350_VUDDR4_SUPPORT");
//
//       &DANGLER("ui_clk_sync_rst");
//       &FORCE("inout", "X_ddr4_dm_dbi_n");
//       &FORCE("inout", "X_ddr4_dq");
//       &FORCE("inout", "X_ddr4_dqs_c");
//       &FORCE("inout", "X_ddr4_dqs_t");
//
//       #   	SIM_BYPASS_INIT_CAL 	=> "SIM_BYPASS_INIT_CAL",
//       #	ID_WIDTH 		=> "ID_WIDTH",
//	&GENERATE_IF("(DATA_WIDTH > DDR4_WRAPPER_DATA_WIDTH)", "gen_axi_sdn");
//	#------ sizedn for gt-axibus to 32-hbmc ------
//	&INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300.v", "u_axi_sdn", {
//		ID_WIDTH	=> "ID_WIDTH",
//		ADDR_WIDTH	=> "ADDR_WIDTH",
//		US_DATA_WIDTH	=> "DATA_WIDTH",
//		DS_DATA_WIDTH	=> "DDR4_WRAPPER_DATA_WIDTH",
//	});
//	&CONNECT("u_axi_sdn.aclk",		"aclk");
//	&CONNECT("u_axi_sdn.aresetn",		"aresetn");

//	&CONNECT("u_axi_sdn.us_araddr",		"araddr");
//	&CONNECT("u_axi_sdn.us_arburst",	"arburst");
//	&CONNECT("u_axi_sdn.us_arcache",	"arcache");
//	&CONNECT("u_axi_sdn.us_arid",		"arid");
//	&CONNECT("u_axi_sdn.us_arlen",		"arlen");
//	&CONNECT("u_axi_sdn.us_arlock",		"arlock");
//	&CONNECT("u_axi_sdn.us_arprot",		"arprot");
//	&CONNECT("u_axi_sdn.us_arsize",		"arsize");
//	&CONNECT("u_axi_sdn.us_arvalid",	"arvalid");
//	&CONNECT("u_axi_sdn.us_arready",	"arready");
//	&CONNECT("u_axi_sdn.us_awaddr",		"awaddr");
//	&CONNECT("u_axi_sdn.us_awburst",	"awburst");
//	&CONNECT("u_axi_sdn.us_awcache",	"awcache");
//	&CONNECT("u_axi_sdn.us_awid",		"awid");
//	&CONNECT("u_axi_sdn.us_awlen",		"awlen");
//	&CONNECT("u_axi_sdn.us_awlock",		"awlock");
//	&CONNECT("u_axi_sdn.us_awprot",		"awprot");
//	&CONNECT("u_axi_sdn.us_awsize",		"awsize");
//	&CONNECT("u_axi_sdn.us_awvalid",	"awvalid");
//	&CONNECT("u_axi_sdn.us_awready",	"awready");
//	&CONNECT("u_axi_sdn.us_wdata",		"wdata");
//	&CONNECT("u_axi_sdn.us_wlast",		"wlast");
//	&CONNECT("u_axi_sdn.us_wstrb",		"wstrb");
//	&CONNECT("u_axi_sdn.us_wvalid",		"wvalid");
//	&CONNECT("u_axi_sdn.us_wready",		"wready");
//	&CONNECT("u_axi_sdn.us_bready",		"bready");
//	&CONNECT("u_axi_sdn.us_bid",		"bid");
//	&CONNECT("u_axi_sdn.us_bresp",		"bresp");
//	&CONNECT("u_axi_sdn.us_bvalid",		"bvalid");
//	&CONNECT("u_axi_sdn.us_rdata",		"rdata");
//	&CONNECT("u_axi_sdn.us_rid",		"rid");
//	&CONNECT("u_axi_sdn.us_rlast",		"rlast");
//	&CONNECT("u_axi_sdn.us_rresp",		"rresp");
//	&CONNECT("u_axi_sdn.us_rvalid",		"rvalid");
//	&CONNECT("u_axi_sdn.us_rready",		"rready");
//
//	&CONNECT("u_axi_sdn.ds_araddr",		"ddr4_wrapper_araddr");
//	&CONNECT("u_axi_sdn.ds_arburst",	"ddr4_wrapper_arburst");
//	&CONNECT("u_axi_sdn.ds_arcache",	"ddr4_wrapper_arcache");
//	&CONNECT("u_axi_sdn.ds_arlen",		"ddr4_wrapper_arlen");
//	&CONNECT("u_axi_sdn.ds_arlock",		"ddr4_wrapper_arlock");
//	&CONNECT("u_axi_sdn.ds_arprot",		"ddr4_wrapper_arprot");
//	&CONNECT("u_axi_sdn.ds_arsize",		"ddr4_wrapper_arsize");
//	&CONNECT("u_axi_sdn.ds_arvalid",	"ddr4_wrapper_arvalid");
//	&CONNECT("u_axi_sdn.ds_arready",	"ddr4_wrapper_arready");
//	&CONNECT("u_axi_sdn.ds_awaddr",		"ddr4_wrapper_awaddr");
//	&CONNECT("u_axi_sdn.ds_awburst",	"ddr4_wrapper_awburst");
//	&CONNECT("u_axi_sdn.ds_awcache",	"ddr4_wrapper_awcache");
//	&CONNECT("u_axi_sdn.ds_awlen",		"ddr4_wrapper_awlen");
//	&CONNECT("u_axi_sdn.ds_awlock",		"ddr4_wrapper_awlock");
//	&CONNECT("u_axi_sdn.ds_awprot",		"ddr4_wrapper_awprot");
//	&CONNECT("u_axi_sdn.ds_awsize",		"ddr4_wrapper_awsize");
//	&CONNECT("u_axi_sdn.ds_awvalid",	"ddr4_wrapper_awvalid");
//	&CONNECT("u_axi_sdn.ds_awready",	"ddr4_wrapper_awready");
//	&CONNECT("u_axi_sdn.ds_wdata",		"ddr4_wrapper_wdata");
//	&CONNECT("u_axi_sdn.ds_wlast",		"ddr4_wrapper_wlast");
//	&CONNECT("u_axi_sdn.ds_wstrb",		"ddr4_wrapper_wstrb");
//	&CONNECT("u_axi_sdn.ds_wvalid",		"ddr4_wrapper_wvalid");
//	&CONNECT("u_axi_sdn.ds_wready",		"ddr4_wrapper_wready");
//	&CONNECT("u_axi_sdn.ds_bresp",		"ddr4_wrapper_bresp");
//	&CONNECT("u_axi_sdn.ds_bvalid",		"ddr4_wrapper_bvalid");
//	&CONNECT("u_axi_sdn.ds_bready",		"ddr4_wrapper_bready");
//	&CONNECT("u_axi_sdn.ds_rdata",		"ddr4_wrapper_rdata");
//	&CONNECT("u_axi_sdn.ds_rlast",		"ddr4_wrapper_rlast");
//	&CONNECT("u_axi_sdn.ds_rresp",		"ddr4_wrapper_rresp");
//	&CONNECT("u_axi_sdn.ds_rvalid",		"ddr4_wrapper_rvalid");
//	&CONNECT("u_axi_sdn.ds_rready",		"ddr4_wrapper_rready");

//	&FORCE("wire", "ddr4_wrapper_araddr[(ADDR_WIDTH-1):0]");
//	&FORCE("wire", "ddr4_wrapper_arburst[1:0]");
//	&FORCE("wire", "ddr4_wrapper_arcache[3:0]");
//	&FORCE("wire", "ddr4_wrapper_arid[(ID_WIDTH-1):0]");
//	&FORCE("wire", "ddr4_wrapper_arlen[7:0]");
//	&FORCE("wire", "ddr4_wrapper_arlock");
//	&FORCE("wire", "ddr4_wrapper_arprot[2:0]");
//	&FORCE("wire", "ddr4_wrapper_arready");
//	&FORCE("wire", "ddr4_wrapper_arsize[2:0]");
//	&FORCE("wire", "ddr4_wrapper_arvalid");
//	&FORCE("wire", "ddr4_wrapper_awaddr[(ADDR_WIDTH-1):0]");
//	&FORCE("wire", "ddr4_wrapper_awburst[1:0]");
//	&FORCE("wire", "ddr4_wrapper_awcache[3:0]");
//	&FORCE("wire", "ddr4_wrapper_awid[(ID_WIDTH-1):0]");
//	&FORCE("wire", "ddr4_wrapper_awlen[7:0]");
//	&FORCE("wire", "ddr4_wrapper_awlock");
//	&FORCE("wire", "ddr4_wrapper_awprot[2:0]");
//	&FORCE("wire", "ddr4_wrapper_awready");
//	&FORCE("wire", "ddr4_wrapper_awsize[2:0]");
//	&FORCE("wire", "ddr4_wrapper_awvalid");
//	&FORCE("wire", "ddr4_wrapper_wdata[(DDR4_WRAPPER_DATA_WIDTH-1):0]");
//	&FORCE("wire", "ddr4_wrapper_wstrb[((DDR4_WRAPPER_DATA_WIDTH/8)-1):0]");
//	&FORCE("wire", "ddr4_wrapper_wlast");
//	&FORCE("wire", "ddr4_wrapper_wvalid");
//	&FORCE("wire", "ddr4_wrapper_wready");
//	&FORCE("wire", "ddr4_wrapper_bid[(ID_WIDTH-1):0]");
//	&FORCE("wire", "ddr4_wrapper_bresp[1:0]");
//	&FORCE("wire", "ddr4_wrapper_bvalid");
//	&FORCE("wire", "ddr4_wrapper_bready");
//	&FORCE("wire", "ddr4_wrapper_rid[(ID_WIDTH-1):0]");
//	&FORCE("wire", "ddr4_wrapper_rdata[(DDR4_WRAPPER_DATA_WIDTH-1):0]");
//	&FORCE("wire", "ddr4_wrapper_rresp[1:0]");
//	&FORCE("wire", "ddr4_wrapper_rlast");
//	&FORCE("wire", "ddr4_wrapper_rvalid");
//	&FORCE("wire", "ddr4_wrapper_rready");
//	:`ifdef AE350_AXI_SUPPORT
//	:   `ifdef AE350_VUDDR4_SUPPORT
//	:generate
//	:if (DATA_WIDTH > DDR4_WRAPPER_DATA_WIDTH) begin: gen_connect_axi_sdn
//	:	assign ddr4_wrapper_arid = {(ID_WIDTH){1'b0}};
//	:	assign ddr4_wrapper_awid = {(ID_WIDTH){1'b0}};
//	:end
//	:else begin: gen_connect_axi
//	:		assign ddr4_wrapper_araddr  = araddr;
//	:		assign ddr4_wrapper_arburst = arburst;
//	:		assign ddr4_wrapper_arcache = arcache;
//	:		assign ddr4_wrapper_arid    = arid;
//	:		assign ddr4_wrapper_arlen   = arlen;
//	:		assign ddr4_wrapper_arlock  = arlock;
//	:		assign ddr4_wrapper_arprot  = arprot;
//	:		assign ddr4_wrapper_arsize  = arsize;
//	:		assign ddr4_wrapper_arvalid = arvalid;
//	:		assign arready              = ddr4_wrapper_arready;
//	:
//	:		assign ddr4_wrapper_awaddr  = awaddr;
//	:		assign ddr4_wrapper_awburst = awburst;
//	:		assign ddr4_wrapper_awcache = awcache;
//	:		assign ddr4_wrapper_awid    = awid;
//	:		assign ddr4_wrapper_awlen   = awlen;
//	:		assign ddr4_wrapper_awlock  = awlock;
//	:		assign ddr4_wrapper_awprot  = awprot;
//	:		assign ddr4_wrapper_awsize  = awsize;
//	:		assign ddr4_wrapper_awvalid = awvalid;
//	:		assign awready              = ddr4_wrapper_awready;
//	:
//	:		assign bid                  = ddr4_wrapper_bid;
//	:		assign bresp                = ddr4_wrapper_bresp;
//	:		assign bvalid               = ddr4_wrapper_bvalid;
//	:		assign ddr4_wrapper_bready  = bready;
//	:
//	:		assign rdata                = ddr4_wrapper_rdata;
//	:		assign rid                  = ddr4_wrapper_rid;
//	:		assign rlast                = ddr4_wrapper_rlast;
//	:		assign rresp                = ddr4_wrapper_rresp;
//	:		assign rvalid               = ddr4_wrapper_rvalid;
//	:		assign ddr4_wrapper_rready  = rready;
//	:
//	:		assign ddr4_wrapper_wdata   = wdata;
//	:		assign ddr4_wrapper_wlast   = wlast;
//	:		assign ddr4_wrapper_wstrb   = wstrb;
//	:		assign ddr4_wrapper_wvalid  = wvalid;
//	:		assign wready               = ddr4_wrapper_wready;
//	:end
//	:endgenerate
//	: `endif
//	:`endif
//	&ENDGENERATE();

// &INSTANCE("$PVC_LOCALDIR/andes_ip/soc/ddr4_wrapper/hdl/ddr4_wrapper.v","u_ddr4",{
//	ADDR_WIDTH 	=> "ADDR_WIDTH",
//	DATA_WIDTH 	=> "DDR4_WRAPPER_DATA_WIDTH",
//	ID_WIDTH        => "ID_WIDTH",
// });
// &CONNECT("u_ddr4",{
//      	c0_ddr4_ui_clk  => "ui_clk",
//      	c0_ddr4_ui_clk_sync_rst  => "ui_clk_sync_rst",
//        	c0_init_calib_complete =>"init_calib_complete",
//      	c0_ddr4_dq     	=> "X_ddr4_dq",
//      	c0_ddr4_dm_dbi_n=> "X_ddr4_dm_dbi_n",
//      	c0_ddr4_dqs_c  	=> "X_ddr4_dqs_c",
//      	c0_ddr4_dqs_t  	=> "X_ddr4_dqs_t",
//      	c0_ddr4_adr   	=> "X_ddr4_addr",
//      	c0_ddr4_ba     	=> "X_ddr4_ba",
//      	c0_ddr4_bg     	=> "X_ddr4_bg",
//      	c0_ddr4_act_n	=> "X_ddr4_act_n",
//      	c0_ddr4_reset_n	=> "X_ddr4_reset_n",
//      	c0_ddr4_ck_c   	=> "X_ddr4_ck_c",
//      	c0_ddr4_ck_t   	=> "X_ddr4_ck_t",
//      	c0_ddr4_cke    	=> "X_ddr4_cke",
//      	c0_ddr4_cs_n   	=> "X_ddr4_cs_n",
//      	c0_ddr4_odt    	=> "X_ddr4_odt",
//      	c0_sys_clk_n   	=> "X_ddr4_sys_clk_n",
//      	c0_sys_clk_p   	=> "X_ddr4_sys_clk_p",
//      	sys_rst     	=> "!T_por_b",
// });
//	&CONNECT("u_ddr4.araddr",	"ddr4_wrapper_araddr");
//	&CONNECT("u_ddr4.arburst",	"ddr4_wrapper_arburst");
//	&CONNECT("u_ddr4.arcache",	"ddr4_wrapper_arcache");
//	&CONNECT("u_ddr4.arid",		"ddr4_wrapper_arid");
//	&CONNECT("u_ddr4.arlen",	"ddr4_wrapper_arlen");
//	&CONNECT("u_ddr4.arlock",	"ddr4_wrapper_arlock");
//	&CONNECT("u_ddr4.arprot",	"ddr4_wrapper_arprot");
//	&CONNECT("u_ddr4.arsize",	"ddr4_wrapper_arsize");
//	&CONNECT("u_ddr4.arvalid",	"ddr4_wrapper_arvalid");
//	&CONNECT("u_ddr4.arready",	"ddr4_wrapper_arready");
//	&CONNECT("u_ddr4.awaddr",	"ddr4_wrapper_awaddr");
//	&CONNECT("u_ddr4.awburst",	"ddr4_wrapper_awburst");
//	&CONNECT("u_ddr4.awcache",	"ddr4_wrapper_awcache");
//	&CONNECT("u_ddr4.awid",		"ddr4_wrapper_awid");
//	&CONNECT("u_ddr4.awlen",	"ddr4_wrapper_awlen");
//	&CONNECT("u_ddr4.awlock",	"ddr4_wrapper_awlock");
//	&CONNECT("u_ddr4.awprot",	"ddr4_wrapper_awprot");
//	&CONNECT("u_ddr4.awsize",	"ddr4_wrapper_awsize");
//	&CONNECT("u_ddr4.awvalid",	"ddr4_wrapper_awvalid");
//	&CONNECT("u_ddr4.awready",	"ddr4_wrapper_awready");
//	&CONNECT("u_ddr4.wdata",	"ddr4_wrapper_wdata");
//	&CONNECT("u_ddr4.wlast",	"ddr4_wrapper_wlast");
//	&CONNECT("u_ddr4.wstrb",	"ddr4_wrapper_wstrb");
//	&CONNECT("u_ddr4.wvalid",	"ddr4_wrapper_wvalid");
//	&CONNECT("u_ddr4.wready",	"ddr4_wrapper_wready");
//	&CONNECT("u_ddr4.bready",	"ddr4_wrapper_bready");
//	&CONNECT("u_ddr4.bid",		"ddr4_wrapper_bid");
//	&CONNECT("u_ddr4.bresp",	"ddr4_wrapper_bresp");
//	&CONNECT("u_ddr4.bvalid",	"ddr4_wrapper_bvalid");
//	&CONNECT("u_ddr4.rdata",	"ddr4_wrapper_rdata");
//	&CONNECT("u_ddr4.rid",		"ddr4_wrapper_rid");
//	&CONNECT("u_ddr4.rlast",	"ddr4_wrapper_rlast");
//	&CONNECT("u_ddr4.rresp",	"ddr4_wrapper_rresp");
//	&CONNECT("u_ddr4.rvalid",	"ddr4_wrapper_rvalid");
//	&CONNECT("u_ddr4.rready",	"ddr4_wrapper_rready");
//  &ELSE("AE350_VUDDR4_SUPPORT")
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcrambrg300/hdl/atcrambrg300.v","u_sram_brg", {
//   ID_WIDTH		=> "ID_WIDTH",
//   DATA_WIDTH		=> "DATA_WIDTH",
//   ADDR_WIDTH		=> "RAMBRG_ADDR_WIDTH",
//   OOR_ERR_EN		=> 1,
// });
// &CONNECT("u_sram_brg", {
// 	araddr => "araddr[RAMBRG_ADDR_WIDTH-1:0]",
// 	awaddr => "awaddr[RAMBRG_ADDR_WIDTH-1:0]",
// });
//   &ENDIF("AE350_VUDDR4_SUPPORT");
// &ELSE("AE350_AXI_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcrambrg200/hdl/atcrambrg200.v", "atcrambrg200", {
//	DATA_WIDTH	=> DATA_WIDTH,
//	OOR_ERR_EN	=> 1,
//	ADDR_WIDTH	=> RAMBRG_ADDR_WIDTH
// });
//
// & DANGLER("hresp_1bit");
// &CONNECT("atcrambrg200", {
//      hsel		=> "hsel",
//      hready		=> "hready",
//      haddr 		=> "haddr[RAMBRG_ADDR_WIDTH-1:0]",
//      hwrite		=> "hwrite",
//      htrans		=> "htrans",
//      hsize 		=> "hsize",
//      hburst		=> "hburst",
//      hprot 		=> "hprot",
//      hreadyout	=> "hreadyout",
//      hresp		=> "hresp_1bit",
//      mem_csb     => "mem_csb",
//      mem_web     => "mem_web",
//      mem_addr    => "mem_addr",
// });
// &ENDIF("AE350_AXI_SUPPORT");

// : `ifdef AE350_AXI_SUPPORT
// : `else
// :	`ifdef AE350_K7DDR3_SUPPORT
// :	`else
// :		assign hresp = {1'b0, hresp_1bit};
// :	`endif
// : `endif
// : `ifdef AE350_AXI_SUPPORT
// :     `ifdef AE350_K7DDR3_SUPPORT
// : 	defparam u_ddr3.SIMULATION = SIMULATION;
// : 	defparam u_ddr3.SIM_BYPASS_INIT_CAL = SIM_BYPASS_INIT_CAL;
// :     `endif // AE350_K7DDR3_SUPPORT
// : `else  // !AE350_AXI_SUPPORT
// :     `ifdef AE350_K7DDR3_SUPPORT
// :         `ifndef NDS_FPGA
// : 	defparam ddr3_controller.SIMULATION = SIMULATION;
// : 	defparam ddr3_controller.SIM_BYPASS_INIT_CAL = SIM_BYPASS_INIT_CAL;
// :         `endif // NDS_FPGA
// :     `endif // AE350_K7DDR3_SUPPORT
// : `endif // AE350_AXI_SUPPORT
//
// : `ifdef AE350_K7DDR3_SUPPORT
// : `elsif AE350_VUDDR4_SUPPORT
// : `else
// :  assign ui_clk = 1'b0;
// :  assign init_calib_complete = 1'b1;
// : `endif
// #&DANGLER("srambrg_araddr");
// #&DANGLER("srambrg_awaddr");
// #:`ifdef AE350_K7DDR3_SUPPORT
// #:`else
// #:assign srambrg_araddr = araddr[21:0];
// #:assign srambrg_awaddr = awaddr[21:0];
// #:`endif
//&IFDEF("AE350_AXI_SUPPORT");
// &IFDEF("AE350_VUDDR4_SUPPORT");
// &ELSE("AE350_VUDDR4_SUPPORT")
//  &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/memory/model/ae350_rambrg_ram.v", "u_sram", {
//    ADDR_WIDTH		=> "MEM_ADDR_WIDTH",
//    DATA_WIDTH		=> "DATA_WIDTH",
//  });
//  &CONNECT("u_sram", {
//    clk  => "aclk",
//    addr => "mem_addr",
//    web  => "mem_web",
//    csb  => "mem_csb",
//    din  => "mem_din",
//    dout => "mem_dout",
//  });
// &ENDIF("AE350_VUDDR4_SUPPORT");
//&ELSE("AE350_AXI_SUPPORT");
//  &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/memory/model/ae350_rambrg_ram.v", "u_sram", {
//    ADDR_WIDTH		=> "MEM_ADDR_WIDTH",
//    DATA_WIDTH		=> "DATA_WIDTH",
//  });
//  &CONNECT("u_sram", {
//    clk  => "hclk",
//    addr => "mem_addr",
//    web  => "mem_web",
//    csb  => "mem_csb",
//    din  => "hwdata",
//    dout => "hrdata",
//  });
//&ENDIF("AE350_AXI_SUPPORT");

//&ENDIF("AE350_K7DDR3_SUPPORT");
//
// &ENDMODULE
// VPERL_END

// VPERL_GENERATED_BEGIN
module ae350_ram_subsystem (
`ifdef AE350_AXI_SUPPORT
	  arcache,             // (u_axi_sdn) <= ()
	  arprot,              // (u_axi_sdn) <= ()
	  awcache,             // (u_axi_sdn) <= ()
	  awprot,              // (u_axi_sdn) <= ()
	  wlast,               // (u_axi_sdn) <= ()
	  aclk,                // (u_axi_sdn,u_ddr3,u_ddr4,u_sram,u_sram_brg) <= ()
	  aresetn,             // (u_axi_sdn,u_ddr3,u_ddr4,u_sram_brg) <= ()
	  araddr,              // (u_axi_sdn,u_sram_brg) <= ()
	  arburst,             // (u_axi_sdn,u_sram_brg) <= ()
	  arid,                // (u_axi_sdn,u_sram_brg) <= ()
	  arlen,               // (u_axi_sdn,u_sram_brg) <= ()
	  arlock,              // (u_axi_sdn,u_sram_brg) <= ()
	  arready,             // (u_axi_sdn,u_sram_brg) => ()
	  arsize,              // (u_axi_sdn,u_sram_brg) <= ()
	  arvalid,             // (u_axi_sdn,u_sram_brg) <= ()
	  awaddr,              // (u_axi_sdn,u_sram_brg) <= ()
	  awburst,             // (u_axi_sdn,u_sram_brg) <= ()
	  awid,                // (u_axi_sdn,u_sram_brg) <= ()
	  awlen,               // (u_axi_sdn,u_sram_brg) <= ()
	  awlock,              // (u_axi_sdn,u_sram_brg) <= ()
	  awready,             // (u_axi_sdn,u_sram_brg) => ()
	  awsize,              // (u_axi_sdn,u_sram_brg) <= ()
	  awvalid,             // (u_axi_sdn,u_sram_brg) <= ()
	  bid,                 // (u_axi_sdn,u_sram_brg) => ()
	  bready,              // (u_axi_sdn,u_sram_brg) <= ()
	  bresp,               // (u_axi_sdn,u_sram_brg) => ()
	  bvalid,              // (u_axi_sdn,u_sram_brg) => ()
	  rdata,               // (u_axi_sdn,u_sram_brg) => ()
	  rid,                 // (u_axi_sdn,u_sram_brg) => ()
	  rlast,               // (u_axi_sdn,u_sram_brg) => ()
	  rready,              // (u_axi_sdn,u_sram_brg) <= ()
	  rresp,               // (u_axi_sdn,u_sram_brg) => ()
	  rvalid,              // (u_axi_sdn,u_sram_brg) => ()
	  wdata,               // (u_axi_sdn,u_sram_brg) <= ()
	  wready,              // (u_axi_sdn,u_sram_brg) => ()
	  wstrb,               // (u_axi_sdn,u_sram_brg) <= ()
	  wvalid,              // (u_axi_sdn,u_sram_brg) <= ()
`else
	  hsel,                // (atcrambrg200) <= ()
	  hresetn,             // (atcrambrg200,memc_wrapper,u_sizedn_memc) <= ()
	  hclk,                // (atcrambrg200,memc_wrapper,u_sizedn_memc,u_sram) <= ()
	  haddr,               // (atcrambrg200,u_sizedn_memc) <= ()
	  hburst,              // (atcrambrg200,u_sizedn_memc) <= ()
	  hprot,               // (atcrambrg200,u_sizedn_memc) <= ()
	  hready,              // (atcrambrg200,u_sizedn_memc) <= ()
	  hreadyout,           // (atcrambrg200,u_sizedn_memc) => ()
	  hsize,               // (atcrambrg200,u_sizedn_memc) <= ()
	  htrans,              // (atcrambrg200,u_sizedn_memc) <= ()
	  hwrite,              // (atcrambrg200,u_sizedn_memc) <= ()
	  hresp,               // (u_sizedn_memc) => ()
	  hrdata,              // (u_sizedn_memc,u_sram) => ()
	  hwdata,              // (u_sizedn_memc,u_sram) <= ()
`endif // AE350_AXI_SUPPORT
`ifdef AE350_K7DDR3_SUPPORT
	  X_ddr3_dq,           // (ddr3_controller,u_ddr3) <=> (ddr3_controller,u_ddr3)
	  X_ddr3_dqs_n,        // (ddr3_controller,u_ddr3) <=> (ddr3_controller,u_ddr3)
	  X_ddr3_dqs_p,        // (ddr3_controller,u_ddr3) <=> (ddr3_controller,u_ddr3)
   `ifdef AE350_AXI_SUPPORT
	  X_ddr3_addr,         // (u_ddr3) => ()
	  X_ddr3_ba,           // (u_ddr3) => ()
	  X_ddr3_cas_n,        // (u_ddr3) => ()
	  X_ddr3_ck_n,         // (u_ddr3) => ()
	  X_ddr3_ck_p,         // (u_ddr3) => ()
	  X_ddr3_cke,          // (u_ddr3) => ()
	  X_ddr3_cs_n,         // (u_ddr3) => ()
	  X_ddr3_dm,           // (u_ddr3) => ()
	  X_ddr3_odt,          // (u_ddr3) => ()
	  X_ddr3_ras_n,        // (u_ddr3) => ()
	  X_ddr3_reset_n,      // (u_ddr3) => ()
	  X_ddr3_sys_clk_n,    // (u_ddr3) <= ()
	  X_ddr3_sys_clk_p,    // (u_ddr3) <= ()
	  X_ddr3_we_n,         // (u_ddr3) => ()
	  ddr3_aresetn,        // (u_ddr3) <= ()
   `else
	  X_ddr3_addr,         // (ddr3_controller) => ()
	  X_ddr3_ba,           // (ddr3_controller) => ()
	  X_ddr3_cas_n,        // (ddr3_controller) => ()
	  X_ddr3_ck_n,         // (ddr3_controller) => ()
	  X_ddr3_ck_p,         // (ddr3_controller) => ()
	  X_ddr3_cke,          // (ddr3_controller) => ()
	  X_ddr3_cs_n,         // (ddr3_controller) => ()
	  X_ddr3_dm,           // (ddr3_controller) => ()
	  X_ddr3_odt,          // (ddr3_controller) => ()
	  X_ddr3_ras_n,        // (ddr3_controller) => ()
	  X_ddr3_reset_n,      // (ddr3_controller) => ()
	  X_ddr3_sys_clk_n,    // (ddr3_controller) <= ()
	  X_ddr3_sys_clk_p,    // (ddr3_controller) <= ()
	  X_ddr3_we_n,         // (ddr3_controller) => ()
   `endif // AE350_AXI_SUPPORT
   `ifdef AE350_AXI_SUPPORT
      `ifdef NDS_FPGA
	  ddr3_bw_ctrl,        // (u_ddr3) <= ()
	  ddr3_latency,        // (u_ddr3) <= ()
      `endif // NDS_FPGA
   `endif // AE350_AXI_SUPPORT
`else
   `ifdef AE350_AXI_SUPPORT
      `ifdef AE350_VUDDR4_SUPPORT
	  X_ddr4_dm_dbi_n,     // (u_ddr4) <=> (u_ddr4)
	  X_ddr4_dq,           // (u_ddr4) <=> (u_ddr4)
	  X_ddr4_dqs_c,        // (u_ddr4) <=> (u_ddr4)
	  X_ddr4_dqs_t,        // (u_ddr4) <=> (u_ddr4)
         `ifdef NDS_FPGA
	  X_ddr4_act_n,        // (u_ddr4) => ()
	  X_ddr4_addr,         // (u_ddr4) => ()
	  X_ddr4_ba,           // (u_ddr4) => ()
	  X_ddr4_bg,           // (u_ddr4) => ()
	  X_ddr4_ck_c,         // (u_ddr4) => ()
	  X_ddr4_ck_t,         // (u_ddr4) => ()
	  X_ddr4_cke,          // (u_ddr4) => ()
	  X_ddr4_cs_n,         // (u_ddr4) => ()
	  X_ddr4_odt,          // (u_ddr4) => ()
	  X_ddr4_reset_n,      // (u_ddr4) => ()
	  X_ddr4_sys_clk_n,    // (u_ddr4) <= ()
	  X_ddr4_sys_clk_p,    // (u_ddr4) <= ()
	  ddr3_latency,        // (u_ddr4) <= ()
	  ddr4_aresetn,        // (u_ddr4) <= ()
         `else
	  X_ddr4_act_n,        // (u_ddr4) => ()
	  X_ddr4_addr,         // (u_ddr4) => ()
	  X_ddr4_ba,           // (u_ddr4) => ()
	  X_ddr4_bg,           // (u_ddr4) => ()
	  X_ddr4_ck_c,         // (u_ddr4) => ()
	  X_ddr4_ck_t,         // (u_ddr4) => ()
	  X_ddr4_cke,          // (u_ddr4) => ()
	  X_ddr4_cs_n,         // (u_ddr4) => ()
	  X_ddr4_odt,          // (u_ddr4) => ()
	  X_ddr4_reset_n,      // (u_ddr4) => ()
	  X_ddr4_sys_clk_n,    // (u_ddr4) <= ()
	  X_ddr4_sys_clk_p,    // (u_ddr4) <= ()
	  ddr4_aresetn,        // (u_ddr4) <= ()
         `endif // NDS_FPGA
      `endif // AE350_VUDDR4_SUPPORT
   `endif // AE350_AXI_SUPPORT
`endif // AE350_K7DDR3_SUPPORT
	  T_por_b,             // (ddr3_controller,u_ddr3,u_ddr4) <= ()
	  init_calib_complete, // (ddr3_controller,u_ddr3,u_ddr4) => ()
	  ui_clk               // (ddr3_controller,u_ddr3,u_ddr4) => (memc_wrapper)
);

parameter SIMULATION = "FALSE" ;
parameter SIM_BYPASS_INIT_CAL = "OFF" ;
parameter ID_WIDTH = 4 ;
parameter ADDR_WIDTH = 32 ;
parameter DATA_WIDTH = 64 ;
parameter RAMBRG_ADDR_WIDTH       = 23;

localparam ADDR_MSB = ADDR_WIDTH-1 ;
localparam DDR3_WRAPPER_DATA_WIDTH = 64 ;
localparam DDR4_WRAPPER_DATA_WIDTH = 64 ;
localparam MEM_SIZE_KB     = (1 << (RAMBRG_ADDR_WIDTH - 10));
localparam MEM_ADDR_LSB    = $clog2(DATA_WIDTH/8);
localparam MEM_ADDR_MSB    = $clog2(MEM_SIZE_KB) - 1 + 10;
localparam MEM_ADDR_WIDTH  = MEM_ADDR_MSB - MEM_ADDR_LSB + 1;

`ifdef AE350_AXI_SUPPORT
input                      [3:0] arcache;
input                      [2:0] arprot;
input                      [3:0] awcache;
input                      [2:0] awprot;
input                            wlast;
input                            aclk;
input                            aresetn;
input           [ADDR_WIDTH-1:0] araddr;
input                      [1:0] arburst;
input           [(ID_WIDTH-1):0] arid;
input                      [7:0] arlen;
input                            arlock;
output                           arready;
input                      [2:0] arsize;
input                            arvalid;
input           [ADDR_WIDTH-1:0] awaddr;
input                      [1:0] awburst;
input           [(ID_WIDTH-1):0] awid;
input                      [7:0] awlen;
input                            awlock;
output                           awready;
input                      [2:0] awsize;
input                            awvalid;
output          [(ID_WIDTH-1):0] bid;
input                            bready;
output                     [1:0] bresp;
output                           bvalid;
output          [DATA_WIDTH-1:0] rdata;
output          [(ID_WIDTH-1):0] rid;
output                           rlast;
input                            rready;
output                     [1:0] rresp;
output                           rvalid;
input           [DATA_WIDTH-1:0] wdata;
output                           wready;
input       [(DATA_WIDTH/8)-1:0] wstrb;
input                            wvalid;
`else
input                            hsel;
input                            hresetn;
input                            hclk;                 // read clock
input           [ADDR_WIDTH-1:0] haddr;
input                      [2:0] hburst;
input                      [3:0] hprot;
input                            hready;
output                           hreadyout;
input                      [2:0] hsize;
input                      [1:0] htrans;
input                            hwrite;
output                     [1:0] hresp;
output          [DATA_WIDTH-1:0] hrdata;
input           [DATA_WIDTH-1:0] hwdata;
`endif // AE350_AXI_SUPPORT
`ifdef AE350_K7DDR3_SUPPORT
inout                     [31:0] X_ddr3_dq;
inout                      [3:0] X_ddr3_dqs_n;
inout                      [3:0] X_ddr3_dqs_p;
   `ifdef AE350_AXI_SUPPORT
output                    [14:0] X_ddr3_addr;
output                     [2:0] X_ddr3_ba;
output                           X_ddr3_cas_n;
output                     [0:0] X_ddr3_ck_n;
output                     [0:0] X_ddr3_ck_p;
output                     [0:0] X_ddr3_cke;
output                     [0:0] X_ddr3_cs_n;
output                     [3:0] X_ddr3_dm;
output                     [0:0] X_ddr3_odt;
output                           X_ddr3_ras_n;
output                           X_ddr3_reset_n;
input                            X_ddr3_sys_clk_n;
input                            X_ddr3_sys_clk_p;
output                           X_ddr3_we_n;
input                            ddr3_aresetn;
   `else
output                    [14:0] X_ddr3_addr;
output                     [2:0] X_ddr3_ba;
output                           X_ddr3_cas_n;
output                     [0:0] X_ddr3_ck_n;
output                     [0:0] X_ddr3_ck_p;
output                     [0:0] X_ddr3_cke;
output                     [0:0] X_ddr3_cs_n;
output                     [3:0] X_ddr3_dm;
output                     [0:0] X_ddr3_odt;
output                           X_ddr3_ras_n;
output                           X_ddr3_reset_n;
input                            X_ddr3_sys_clk_n;
input                            X_ddr3_sys_clk_p;
output                           X_ddr3_we_n;
   `endif // AE350_AXI_SUPPORT
   `ifdef AE350_AXI_SUPPORT
      `ifdef NDS_FPGA
input                      [1:0] ddr3_bw_ctrl;
input                      [3:0] ddr3_latency;
      `endif // NDS_FPGA
   `endif // AE350_AXI_SUPPORT
`else
   `ifdef AE350_AXI_SUPPORT
      `ifdef AE350_VUDDR4_SUPPORT
inout                      [7:0] X_ddr4_dm_dbi_n;
inout                     [63:0] X_ddr4_dq;
inout                      [7:0] X_ddr4_dqs_c;
inout                      [7:0] X_ddr4_dqs_t;
         `ifdef NDS_FPGA
output                           X_ddr4_act_n;
output                    [16:0] X_ddr4_addr;
output                     [1:0] X_ddr4_ba;
output                     [0:0] X_ddr4_bg;
output                     [0:0] X_ddr4_ck_c;
output                     [0:0] X_ddr4_ck_t;
output                     [0:0] X_ddr4_cke;
output                     [0:0] X_ddr4_cs_n;
output                     [0:0] X_ddr4_odt;
output                           X_ddr4_reset_n;
input                            X_ddr4_sys_clk_n;
input                            X_ddr4_sys_clk_p;
input                      [3:0] ddr3_latency;
input                            ddr4_aresetn;
         `else
output                           X_ddr4_act_n;
output                    [16:0] X_ddr4_addr;
output                     [1:0] X_ddr4_ba;
output                     [0:0] X_ddr4_bg;
output                     [0:0] X_ddr4_ck_c;
output                     [0:0] X_ddr4_ck_t;
output                     [0:0] X_ddr4_cke;
output                     [0:0] X_ddr4_cs_n;
output                     [0:0] X_ddr4_odt;
output                           X_ddr4_reset_n;
input                            X_ddr4_sys_clk_n;
input                            X_ddr4_sys_clk_p;
input                            ddr4_aresetn;
         `endif // NDS_FPGA
      `endif // AE350_VUDDR4_SUPPORT
   `endif // AE350_AXI_SUPPORT
`endif // AE350_K7DDR3_SUPPORT
input                            T_por_b;
output                           init_calib_complete;
output                           ui_clk;               // write clock

`ifdef AE350_AXI_SUPPORT
   `ifdef AE350_K7DDR3_SUPPORT
wire                           [(ID_WIDTH-1):0] ddr3_wrapper_arid;
wire                           [(ID_WIDTH-1):0] ddr3_wrapper_awid;
wire                         [(ADDR_WIDTH-1):0] ddr3_wrapper_araddr;
wire                                      [1:0] ddr3_wrapper_arburst;
wire                                      [3:0] ddr3_wrapper_arcache;
wire                                      [7:0] ddr3_wrapper_arlen;
wire                                            ddr3_wrapper_arlock;
wire                                      [2:0] ddr3_wrapper_arprot;
wire                                      [2:0] ddr3_wrapper_arsize;
wire                                            ddr3_wrapper_arvalid;
wire                         [(ADDR_WIDTH-1):0] ddr3_wrapper_awaddr;
wire                                      [1:0] ddr3_wrapper_awburst;
wire                                      [3:0] ddr3_wrapper_awcache;
wire                                      [7:0] ddr3_wrapper_awlen;
wire                                            ddr3_wrapper_awlock;
wire                                      [2:0] ddr3_wrapper_awprot;
wire                                      [2:0] ddr3_wrapper_awsize;
wire                                            ddr3_wrapper_awvalid;
wire                                            ddr3_wrapper_bready;
wire                                            ddr3_wrapper_rready;
wire            [(DDR3_WRAPPER_DATA_WIDTH-1):0] ddr3_wrapper_wdata;
wire                                            ddr3_wrapper_wlast;
wire        [((DDR3_WRAPPER_DATA_WIDTH/8)-1):0] ddr3_wrapper_wstrb;
wire                                            ddr3_wrapper_wvalid;
wire                                            ddr3_wrapper_arready;
wire                                            ddr3_wrapper_awready;
wire                           [(ID_WIDTH-1):0] ddr3_wrapper_bid;
wire                                      [1:0] ddr3_wrapper_bresp;
wire                                            ddr3_wrapper_bvalid;
wire            [(DDR3_WRAPPER_DATA_WIDTH-1):0] ddr3_wrapper_rdata;
wire                           [(ID_WIDTH-1):0] ddr3_wrapper_rid;
wire                                            ddr3_wrapper_rlast;
wire                                      [1:0] ddr3_wrapper_rresp;
wire                                            ddr3_wrapper_rvalid;
wire                                            ddr3_wrapper_wready;
wire                                            ui_clk_sync_rst; // dangler: () => ()
   `endif // AE350_K7DDR3_SUPPORT
`else
   `ifdef AE350_K7DDR3_SUPPORT
wire                                            memc_hready;
wire                                            memc_hsel;
wire             [(`MEMC_WRAPPER_DW_MSB+1)-1:0] memc_rd_data;
wire                                            memc_rd_end;
wire                                            memc_rd_valid;
wire                                            memc_rdy;
wire                                            memc_wr_rdy;
wire                                            ui_clk_sync_rst; // dangler: () => ()
wire                                     [29:0] memc_addr;
wire                                      [2:0] memc_cmd;
wire                                            memc_en;
wire                                     [31:0] memc_hrdata;
wire                                            memc_hreadyout;
wire                                      [1:0] memc_hresp;
wire                   [`MEMC_WRAPPER_DW_MSB:0] memc_wr_data;
wire                                            memc_wr_en;
wire                                            memc_wr_end;
wire                 [`MEMC_WRAPPER_MASK_MSB:0] memc_wr_mask;
wire                               [ADDR_MSB:0] memc_haddr;
wire                                      [2:0] memc_hburst;
wire                                      [3:0] memc_hprot;
wire                                      [2:0] memc_hsize;
wire                                      [1:0] memc_htrans;
wire                                     [31:0] memc_hwdata;
wire                                            memc_hwrite;
   `else
wire                                            hresp_1bit; // dangler: () => ()
wire                     [(MEM_ADDR_WIDTH-1):0] mem_addr;
wire                                            mem_csb;
wire                     [((DATA_WIDTH/8)-1):0] mem_web;
   `endif // AE350_K7DDR3_SUPPORT
`endif // AE350_AXI_SUPPORT
`ifdef AE350_AXI_SUPPORT
   `ifdef AE350_K7DDR3_SUPPORT
   `else
      `ifdef AE350_VUDDR4_SUPPORT
wire                           [(ID_WIDTH-1):0] ddr4_wrapper_arid;
wire                           [(ID_WIDTH-1):0] ddr4_wrapper_awid;
wire                         [(ADDR_WIDTH-1):0] ddr4_wrapper_araddr;
wire                                      [1:0] ddr4_wrapper_arburst;
wire                                      [3:0] ddr4_wrapper_arcache;
wire                                      [7:0] ddr4_wrapper_arlen;
wire                                            ddr4_wrapper_arlock;
wire                                      [2:0] ddr4_wrapper_arprot;
wire                                      [2:0] ddr4_wrapper_arsize;
wire                                            ddr4_wrapper_arvalid;
wire                         [(ADDR_WIDTH-1):0] ddr4_wrapper_awaddr;
wire                                      [1:0] ddr4_wrapper_awburst;
wire                                      [3:0] ddr4_wrapper_awcache;
wire                                      [7:0] ddr4_wrapper_awlen;
wire                                            ddr4_wrapper_awlock;
wire                                      [2:0] ddr4_wrapper_awprot;
wire                                      [2:0] ddr4_wrapper_awsize;
wire                                            ddr4_wrapper_awvalid;
wire                                            ddr4_wrapper_bready;
wire                                            ddr4_wrapper_rready;
wire            [(DDR4_WRAPPER_DATA_WIDTH-1):0] ddr4_wrapper_wdata;
wire                                            ddr4_wrapper_wlast;
wire        [((DDR4_WRAPPER_DATA_WIDTH/8)-1):0] ddr4_wrapper_wstrb;
wire                                            ddr4_wrapper_wvalid;
wire                                            ddr4_wrapper_arready;
wire                                            ddr4_wrapper_awready;
wire                           [(ID_WIDTH-1):0] ddr4_wrapper_bid;
wire                                      [1:0] ddr4_wrapper_bresp;
wire                                            ddr4_wrapper_bvalid;
wire            [(DDR4_WRAPPER_DATA_WIDTH-1):0] ddr4_wrapper_rdata;
wire                           [(ID_WIDTH-1):0] ddr4_wrapper_rid;
wire                                            ddr4_wrapper_rlast;
wire                                      [1:0] ddr4_wrapper_rresp;
wire                                            ddr4_wrapper_rvalid;
wire                                            ddr4_wrapper_wready;
      `else
wire                         [(DATA_WIDTH-1):0] mem_dout;
wire                     [(MEM_ADDR_WIDTH-1):0] mem_addr;
wire                                            mem_csb;
wire                         [(DATA_WIDTH-1):0] mem_din;
wire                       [(DATA_WIDTH/8)-1:0] mem_web;
      `endif // AE350_VUDDR4_SUPPORT
      `ifdef NDS_FPGA
         `ifdef AE350_VUDDR4_SUPPORT
wire                                            ui_clk_sync_rst; // dangler: () => ()
         `endif // AE350_VUDDR4_SUPPORT
      `else
         `ifdef AE350_VUDDR4_SUPPORT
wire                                            ui_clk_sync_rst; // dangler: () => ()
         `endif // AE350_VUDDR4_SUPPORT
      `endif // NDS_FPGA
   `endif // AE350_K7DDR3_SUPPORT
`endif // AE350_AXI_SUPPORT

`ifdef AE350_AXI_SUPPORT
  `ifdef AE350_K7DDR3_SUPPORT
generate
if (DATA_WIDTH > DDR3_WRAPPER_DATA_WIDTH) begin: gen_connect_axi_sdn
	assign ddr3_wrapper_arid = {(ID_WIDTH){1'b0}};
	assign ddr3_wrapper_awid = {(ID_WIDTH){1'b0}};
end
else begin: gen_connect_axi
		assign ddr3_wrapper_araddr  = araddr;
		assign ddr3_wrapper_arburst = arburst;
		assign ddr3_wrapper_arcache = arcache;
		assign ddr3_wrapper_arid    = arid;
		assign ddr3_wrapper_arlen   = arlen;
		assign ddr3_wrapper_arlock  = arlock;
		assign ddr3_wrapper_arprot  = arprot;
		assign ddr3_wrapper_arsize  = arsize;
		assign ddr3_wrapper_arvalid = arvalid;
		assign arready              = ddr3_wrapper_arready;

		assign ddr3_wrapper_awaddr  = awaddr;
		assign ddr3_wrapper_awburst = awburst;
		assign ddr3_wrapper_awcache = awcache;
		assign ddr3_wrapper_awid    = awid;
		assign ddr3_wrapper_awlen   = awlen;
		assign ddr3_wrapper_awlock  = awlock;
		assign ddr3_wrapper_awprot  = awprot;
		assign ddr3_wrapper_awsize  = awsize;
		assign ddr3_wrapper_awvalid = awvalid;
		assign awready              = ddr3_wrapper_awready;

		assign bid                  = ddr3_wrapper_bid;
		assign bresp                = ddr3_wrapper_bresp;
		assign bvalid               = ddr3_wrapper_bvalid;
		assign ddr3_wrapper_bready  = bready;

		assign rdata                = ddr3_wrapper_rdata;
		assign rid                  = ddr3_wrapper_rid;
		assign rlast                = ddr3_wrapper_rlast;
		assign rresp                = ddr3_wrapper_rresp;
		assign rvalid               = ddr3_wrapper_rvalid;
		assign ddr3_wrapper_rready  = rready;

		assign ddr3_wrapper_wdata   = wdata;
		assign ddr3_wrapper_wlast   = wlast;
		assign ddr3_wrapper_wstrb   = wstrb;
		assign ddr3_wrapper_wvalid  = wvalid;
		assign wready               = ddr3_wrapper_wready;
end
endgenerate
`endif
`endif
`ifdef AE350_AXI_SUPPORT
`else
	`ifdef AE350_K7DDR3_SUPPORT
generate
if (DATA_WIDTH > 32) begin: gen_connect_memc_hresp_ahb_sdn
	assign memc_hsel   = 1'b1;
	assign memc_hready = memc_hreadyout;
	assign hresp[1]	= 1'b0;
end
endgenerate
generate
if (DATA_WIDTH > 32) begin: gen_connect_memc_ahb_sdn
end
else begin: gen_connect_hbmc_ahb
	assign memc_haddr  = haddr;
	assign memc_hburst = hburst;
	assign memc_hprot  = hprot;
	assign memc_hsize  = hsize;
	assign memc_htrans = htrans;
	assign memc_hwrite = hwrite;
	assign memc_hwdata = hwdata;
	assign memc_hsel   = 1'b1;
	assign memc_hready   = hready;
	assign hreadyout	= memc_hreadyout;
	assign hresp		= memc_hresp;
	assign hrdata		= memc_hrdata;
end
endgenerate
	`endif
`endif
`ifdef AE350_AXI_SUPPORT
  `ifdef AE350_VUDDR4_SUPPORT
generate
if (DATA_WIDTH > DDR4_WRAPPER_DATA_WIDTH) begin: gen_connect_axi_sdn
	assign ddr4_wrapper_arid = {(ID_WIDTH){1'b0}};
	assign ddr4_wrapper_awid = {(ID_WIDTH){1'b0}};
end
else begin: gen_connect_axi
		assign ddr4_wrapper_araddr  = araddr;
		assign ddr4_wrapper_arburst = arburst;
		assign ddr4_wrapper_arcache = arcache;
		assign ddr4_wrapper_arid    = arid;
		assign ddr4_wrapper_arlen   = arlen;
		assign ddr4_wrapper_arlock  = arlock;
		assign ddr4_wrapper_arprot  = arprot;
		assign ddr4_wrapper_arsize  = arsize;
		assign ddr4_wrapper_arvalid = arvalid;
		assign arready              = ddr4_wrapper_arready;

		assign ddr4_wrapper_awaddr  = awaddr;
		assign ddr4_wrapper_awburst = awburst;
		assign ddr4_wrapper_awcache = awcache;
		assign ddr4_wrapper_awid    = awid;
		assign ddr4_wrapper_awlen   = awlen;
		assign ddr4_wrapper_awlock  = awlock;
		assign ddr4_wrapper_awprot  = awprot;
		assign ddr4_wrapper_awsize  = awsize;
		assign ddr4_wrapper_awvalid = awvalid;
		assign awready              = ddr4_wrapper_awready;

		assign bid                  = ddr4_wrapper_bid;
		assign bresp                = ddr4_wrapper_bresp;
		assign bvalid               = ddr4_wrapper_bvalid;
		assign ddr4_wrapper_bready  = bready;

		assign rdata                = ddr4_wrapper_rdata;
		assign rid                  = ddr4_wrapper_rid;
		assign rlast                = ddr4_wrapper_rlast;
		assign rresp                = ddr4_wrapper_rresp;
		assign rvalid               = ddr4_wrapper_rvalid;
		assign ddr4_wrapper_rready  = rready;

		assign ddr4_wrapper_wdata   = wdata;
		assign ddr4_wrapper_wlast   = wlast;
		assign ddr4_wrapper_wstrb   = wstrb;
		assign ddr4_wrapper_wvalid  = wvalid;
		assign wready               = ddr4_wrapper_wready;
end
endgenerate
`endif
`endif
`ifdef AE350_AXI_SUPPORT
`else
	`ifdef AE350_K7DDR3_SUPPORT
	`else
		assign hresp = {1'b0, hresp_1bit};
	`endif
`endif
`ifdef AE350_AXI_SUPPORT
    `ifdef AE350_K7DDR3_SUPPORT
	defparam u_ddr3.SIMULATION = SIMULATION;
	defparam u_ddr3.SIM_BYPASS_INIT_CAL = SIM_BYPASS_INIT_CAL;
    `endif // AE350_K7DDR3_SUPPORT
`else  // !AE350_AXI_SUPPORT
    `ifdef AE350_K7DDR3_SUPPORT
        `ifndef NDS_FPGA
	defparam ddr3_controller.SIMULATION = SIMULATION;
	defparam ddr3_controller.SIM_BYPASS_INIT_CAL = SIM_BYPASS_INIT_CAL;
        `endif // NDS_FPGA
    `endif // AE350_K7DDR3_SUPPORT
`endif // AE350_AXI_SUPPORT
`ifdef AE350_K7DDR3_SUPPORT
`elsif AE350_VUDDR4_SUPPORT
`else
 assign ui_clk = 1'b0;
 assign init_calib_complete = 1'b1;
`endif

`ifdef AE350_AXI_SUPPORT
   `ifdef AE350_K7DDR3_SUPPORT
generate
if ((DATA_WIDTH > DDR3_WRAPPER_DATA_WIDTH)) begin : gen_axi_sdn

	atcsizedn300 #(
		.ADDR_WIDTH      (ADDR_WIDTH      ),
		.DS_DATA_WIDTH   (DDR3_WRAPPER_DATA_WIDTH),
		.ID_WIDTH        (ID_WIDTH        ),
		.US_DATA_WIDTH   (DATA_WIDTH      )
	) u_axi_sdn (
		.ds_bready (ddr3_wrapper_bready ), // (u_axi_sdn) => (u_ddr3)
		.ds_bresp  (ddr3_wrapper_bresp  ), // (u_axi_sdn) <= (u_ddr3)
		.ds_bvalid (ddr3_wrapper_bvalid ), // (u_axi_sdn) <= (u_ddr3)
		.ds_rdata  (ddr3_wrapper_rdata  ), // (u_axi_sdn) <= (u_ddr3)
		.ds_rlast  (ddr3_wrapper_rlast  ), // (u_axi_sdn) <= (u_ddr3)
		.ds_rready (ddr3_wrapper_rready ), // (u_axi_sdn) => (u_ddr3)
		.ds_rresp  (ddr3_wrapper_rresp  ), // (u_axi_sdn) <= (u_ddr3)
		.ds_rvalid (ddr3_wrapper_rvalid ), // (u_axi_sdn) <= (u_ddr3)
		.ds_wdata  (ddr3_wrapper_wdata  ), // (u_axi_sdn) => (u_ddr3)
		.ds_wlast  (ddr3_wrapper_wlast  ), // (u_axi_sdn) => (u_ddr3)
		.ds_wready (ddr3_wrapper_wready ), // (u_axi_sdn) <= (u_ddr3)
		.ds_wstrb  (ddr3_wrapper_wstrb  ), // (u_axi_sdn) => (u_ddr3)
		.ds_wvalid (ddr3_wrapper_wvalid ), // (u_axi_sdn) => (u_ddr3)
		.us_bid    (bid                 ), // (u_axi_sdn,u_sram_brg) => ()
		.us_bready (bready              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_bresp  (bresp               ), // (u_axi_sdn,u_sram_brg) => ()
		.us_bvalid (bvalid              ), // (u_axi_sdn,u_sram_brg) => ()
		.us_rdata  (rdata               ), // (u_axi_sdn,u_sram_brg) => ()
		.us_rid    (rid                 ), // (u_axi_sdn,u_sram_brg) => ()
		.us_rlast  (rlast               ), // (u_axi_sdn,u_sram_brg) => ()
		.us_rready (rready              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_rresp  (rresp               ), // (u_axi_sdn,u_sram_brg) => ()
		.us_rvalid (rvalid              ), // (u_axi_sdn,u_sram_brg) => ()
		.us_wdata  (wdata               ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_wlast  (wlast               ), // (u_axi_sdn) <= ()
		.us_wready (wready              ), // (u_axi_sdn,u_sram_brg) => ()
		.us_wstrb  (wstrb               ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_wvalid (wvalid              ), // (u_axi_sdn,u_sram_brg) <= ()
		.ds_arready(ddr3_wrapper_arready), // (u_axi_sdn) <= (u_ddr3)
		.aclk      (aclk                ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram,u_sram_brg) <= ()
		.aresetn   (aresetn             ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram_brg) <= ()
		.ds_awready(ddr3_wrapper_awready), // (u_axi_sdn) <= (u_ddr3)
		.ds_araddr (ddr3_wrapper_araddr ), // (u_axi_sdn) => (u_ddr3)
		.ds_arburst(ddr3_wrapper_arburst), // (u_axi_sdn) => (u_ddr3)
		.ds_arcache(ddr3_wrapper_arcache), // (u_axi_sdn) => (u_ddr3)
		.ds_arlen  (ddr3_wrapper_arlen  ), // (u_axi_sdn) => (u_ddr3)
		.ds_arlock (ddr3_wrapper_arlock ), // (u_axi_sdn) => (u_ddr3)
		.ds_arprot (ddr3_wrapper_arprot ), // (u_axi_sdn) => (u_ddr3)
		.ds_arsize (ddr3_wrapper_arsize ), // (u_axi_sdn) => (u_ddr3)
		.ds_arvalid(ddr3_wrapper_arvalid), // (u_axi_sdn) => (u_ddr3)
		.us_araddr (araddr              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arburst(arburst             ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arcache(arcache             ), // (u_axi_sdn) <= ()
		.us_arid   (arid                ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arlen  (arlen               ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arlock (arlock              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arprot (arprot              ), // (u_axi_sdn) <= ()
		.us_arready(arready             ), // (u_axi_sdn,u_sram_brg) => ()
		.us_arsize (arsize              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arvalid(arvalid             ), // (u_axi_sdn,u_sram_brg) <= ()
		.ds_awaddr (ddr3_wrapper_awaddr ), // (u_axi_sdn) => (u_ddr3)
		.ds_awburst(ddr3_wrapper_awburst), // (u_axi_sdn) => (u_ddr3)
		.ds_awcache(ddr3_wrapper_awcache), // (u_axi_sdn) => (u_ddr3)
		.ds_awlen  (ddr3_wrapper_awlen  ), // (u_axi_sdn) => (u_ddr3)
		.ds_awlock (ddr3_wrapper_awlock ), // (u_axi_sdn) => (u_ddr3)
		.ds_awprot (ddr3_wrapper_awprot ), // (u_axi_sdn) => (u_ddr3)
		.ds_awsize (ddr3_wrapper_awsize ), // (u_axi_sdn) => (u_ddr3)
		.ds_awvalid(ddr3_wrapper_awvalid), // (u_axi_sdn) => (u_ddr3)
		.us_awaddr (awaddr              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awburst(awburst             ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awcache(awcache             ), // (u_axi_sdn) <= ()
		.us_awid   (awid                ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awlen  (awlen               ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awlock (awlock              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awprot (awprot              ), // (u_axi_sdn) <= ()
		.us_awready(awready             ), // (u_axi_sdn,u_sram_brg) => ()
		.us_awsize (awsize              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awvalid(awvalid             )  // (u_axi_sdn,u_sram_brg) <= ()
	); // end of u_axi_sdn

end // end of gen_axi_sdn
endgenerate

ddr3_wrapper #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DDR3_WRAPPER_DATA_WIDTH),
	.ID_WIDTH        (ID_WIDTH        )
) u_ddr3 (
      `ifdef NDS_FPGA
	.arready            (ddr3_wrapper_arready), // (u_ddr3) => (u_axi_sdn)
	.arvalid            (ddr3_wrapper_arvalid), // (u_ddr3) <= (u_axi_sdn)
	.awready            (ddr3_wrapper_awready), // (u_ddr3) => (u_axi_sdn)
	.awvalid            (ddr3_wrapper_awvalid), // (u_ddr3) <= (u_axi_sdn)
	.bid                (ddr3_wrapper_bid    ), // (u_ddr3) => ()
	.bresp              (ddr3_wrapper_bresp  ), // (u_ddr3) => (u_axi_sdn)
	.rid                (ddr3_wrapper_rid    ), // (u_ddr3) => ()
	.rresp              (ddr3_wrapper_rresp  ), // (u_ddr3) => (u_axi_sdn)
	.wready             (ddr3_wrapper_wready ), // (u_ddr3) => (u_axi_sdn)
	.wstrb              (ddr3_wrapper_wstrb  ), // (u_ddr3) <= (u_axi_sdn)
	.wvalid             (ddr3_wrapper_wvalid ), // (u_ddr3) <= (u_axi_sdn)
	.bready             (ddr3_wrapper_bready ), // (u_ddr3) <= (u_axi_sdn)
	.rready             (ddr3_wrapper_rready ), // (u_ddr3) <= (u_axi_sdn)
	.wlast              (ddr3_wrapper_wlast  ), // (u_ddr3) <= (u_axi_sdn)
	.aclk               (aclk                ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram,u_sram_brg) <= ()
	.aresetn            (aresetn             ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram_brg) <= ()
	.arburst            (ddr3_wrapper_arburst), // (u_ddr3) <= (u_axi_sdn)
	.arcache            (ddr3_wrapper_arcache), // (u_ddr3) <= (u_axi_sdn)
	.arid               (ddr3_wrapper_arid   ), // (u_ddr3) <= ()
	.arlen              (ddr3_wrapper_arlen  ), // (u_ddr3) <= (u_axi_sdn)
	.arlock             (ddr3_wrapper_arlock ), // (u_ddr3) <= (u_axi_sdn)
	.arprot             (ddr3_wrapper_arprot ), // (u_ddr3) <= (u_axi_sdn)
	.arsize             (ddr3_wrapper_arsize ), // (u_ddr3) <= (u_axi_sdn)
	.awburst            (ddr3_wrapper_awburst), // (u_ddr3) <= (u_axi_sdn)
	.awcache            (ddr3_wrapper_awcache), // (u_ddr3) <= (u_axi_sdn)
	.awid               (ddr3_wrapper_awid   ), // (u_ddr3) <= ()
	.awlen              (ddr3_wrapper_awlen  ), // (u_ddr3) <= (u_axi_sdn)
	.awlock             (ddr3_wrapper_awlock ), // (u_ddr3) <= (u_axi_sdn)
	.awprot             (ddr3_wrapper_awprot ), // (u_ddr3) <= (u_axi_sdn)
	.awsize             (ddr3_wrapper_awsize ), // (u_ddr3) <= (u_axi_sdn)
	.ddr3_bw_ctrl       (ddr3_bw_ctrl        ), // (u_ddr3) <= ()
	.ddr3_latency       (ddr3_latency        ), // (u_ddr3) <= ()
      `else
	.arid               (ddr3_wrapper_arid   ), // (u_ddr3) <= ()
	.arlock             (ddr3_wrapper_arlock ), // (u_ddr3) <= (u_axi_sdn)
	.arready            (ddr3_wrapper_arready), // (u_ddr3) => (u_axi_sdn)
	.arvalid            (ddr3_wrapper_arvalid), // (u_ddr3) <= (u_axi_sdn)
	.awid               (ddr3_wrapper_awid   ), // (u_ddr3) <= ()
	.awlock             (ddr3_wrapper_awlock ), // (u_ddr3) <= (u_axi_sdn)
	.awready            (ddr3_wrapper_awready), // (u_ddr3) => (u_axi_sdn)
	.awvalid            (ddr3_wrapper_awvalid), // (u_ddr3) <= (u_axi_sdn)
	.bid                (ddr3_wrapper_bid    ), // (u_ddr3) => ()
	.bresp              (ddr3_wrapper_bresp  ), // (u_ddr3) => (u_axi_sdn)
	.rid                (ddr3_wrapper_rid    ), // (u_ddr3) => ()
	.rresp              (ddr3_wrapper_rresp  ), // (u_ddr3) => (u_axi_sdn)
	.wready             (ddr3_wrapper_wready ), // (u_ddr3) => (u_axi_sdn)
	.wstrb              (ddr3_wrapper_wstrb  ), // (u_ddr3) <= (u_axi_sdn)
	.wvalid             (ddr3_wrapper_wvalid ), // (u_ddr3) <= (u_axi_sdn)
	.aclk               (aclk                ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram,u_sram_brg) <= ()
	.arburst            (ddr3_wrapper_arburst), // (u_ddr3) <= (u_axi_sdn)
	.arcache            (ddr3_wrapper_arcache), // (u_ddr3) <= (u_axi_sdn)
	.aresetn            (aresetn             ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram_brg) <= ()
	.arlen              (ddr3_wrapper_arlen  ), // (u_ddr3) <= (u_axi_sdn)
	.arprot             (ddr3_wrapper_arprot ), // (u_ddr3) <= (u_axi_sdn)
	.arsize             (ddr3_wrapper_arsize ), // (u_ddr3) <= (u_axi_sdn)
	.awburst            (ddr3_wrapper_awburst), // (u_ddr3) <= (u_axi_sdn)
	.awcache            (ddr3_wrapper_awcache), // (u_ddr3) <= (u_axi_sdn)
	.awlen              (ddr3_wrapper_awlen  ), // (u_ddr3) <= (u_axi_sdn)
	.awprot             (ddr3_wrapper_awprot ), // (u_ddr3) <= (u_axi_sdn)
	.awsize             (ddr3_wrapper_awsize ), // (u_ddr3) <= (u_axi_sdn)
	.bready             (ddr3_wrapper_bready ), // (u_ddr3) <= (u_axi_sdn)
	.rready             (ddr3_wrapper_rready ), // (u_ddr3) <= (u_axi_sdn)
	.wlast              (ddr3_wrapper_wlast  ), // (u_ddr3) <= (u_axi_sdn)
      `endif // NDS_FPGA
	.araddr             (ddr3_wrapper_araddr ), // (u_ddr3) <= (u_axi_sdn)
	.awaddr             (ddr3_wrapper_awaddr ), // (u_ddr3) <= (u_axi_sdn)
	.bvalid             (ddr3_wrapper_bvalid ), // (u_ddr3) => (u_axi_sdn)
	.rdata              (ddr3_wrapper_rdata  ), // (u_ddr3) => (u_axi_sdn)
	.rlast              (ddr3_wrapper_rlast  ), // (u_ddr3) => (u_axi_sdn)
	.rvalid             (ddr3_wrapper_rvalid ), // (u_ddr3) => (u_axi_sdn)
	.wdata              (ddr3_wrapper_wdata  ), // (u_ddr3) <= (u_axi_sdn)
	.ddr3_aresetn       (ddr3_aresetn        ), // (u_ddr3) <= ()
	.ddr3_addr          (X_ddr3_addr         ), // (u_ddr3) => ()
	.ddr3_ba            (X_ddr3_ba           ), // (u_ddr3) => ()
	.ddr3_cas_n         (X_ddr3_cas_n        ), // (u_ddr3) => ()
	.ddr3_ck_n          (X_ddr3_ck_n         ), // (u_ddr3) => ()
	.ddr3_ck_p          (X_ddr3_ck_p         ), // (u_ddr3) => ()
	.ddr3_cke           (X_ddr3_cke          ), // (u_ddr3) => ()
	.ddr3_cs_n          (X_ddr3_cs_n         ), // (u_ddr3) => ()
	.ddr3_dm            (X_ddr3_dm           ), // (u_ddr3) => ()
	.ddr3_dq            (X_ddr3_dq           ), // (ddr3_controller,u_ddr3) <=> (ddr3_controller,u_ddr3)
	.ddr3_dqs_n         (X_ddr3_dqs_n        ), // (ddr3_controller,u_ddr3) <=> (ddr3_controller,u_ddr3)
	.ddr3_dqs_p         (X_ddr3_dqs_p        ), // (ddr3_controller,u_ddr3) <=> (ddr3_controller,u_ddr3)
	.ddr3_odt           (X_ddr3_odt          ), // (u_ddr3) => ()
	.ddr3_ras_n         (X_ddr3_ras_n        ), // (u_ddr3) => ()
	.ddr3_reset_n       (X_ddr3_reset_n      ), // (u_ddr3) => ()
	.ddr3_we_n          (X_ddr3_we_n         ), // (u_ddr3) => ()
	.device_temp        (/* NC */            ), // (ddr3_controller,u_ddr3,u_sizedn_memc) => ()
	.init_calib_complete(init_calib_complete ), // (ddr3_controller,u_ddr3,u_ddr4) => ()
	.sys_clk_n          (X_ddr3_sys_clk_n    ), // (u_ddr3) <= ()
	.sys_clk_p          (X_ddr3_sys_clk_p    ), // (u_ddr3) <= ()
	.sys_rst            (T_por_b             ), // (ddr3_controller,u_ddr3,u_ddr4) <= ()
	.ui_clk             (ui_clk              ), // (ddr3_controller,u_ddr3,u_ddr4) => (memc_wrapper)
	.ui_clk_sync_rst    (ui_clk_sync_rst     )  // (u_ddr3) => ()
); // end of u_ddr3

   `endif // AE350_K7DDR3_SUPPORT
`else
   `ifdef AE350_K7DDR3_SUPPORT
generate
if ((DATA_WIDTH > 32)) begin : gen_sizedn_hbmc

	atcsizedn100 #(
		.ADDR_WIDTH      (ADDR_WIDTH      ),
		.DS_DATA_WIDTH   (32              ),
		.US_DATA_WIDTH   (DATA_WIDTH      )
	) u_sizedn_memc (
		.hclk        (hclk          ), // (atcrambrg200,memc_wrapper,u_sizedn_memc,u_sram) <= ()
		.hresetn     (hresetn       ), // (atcrambrg200,memc_wrapper,u_sizedn_memc) <= ()
		.us_haddr    (haddr         ), // (atcrambrg200,u_sizedn_memc) <= ()
		.us_hburst   (hburst        ), // (atcrambrg200,u_sizedn_memc) <= ()
		.us_hprot    (hprot         ), // (atcrambrg200,u_sizedn_memc) <= ()
		.us_hsel     (1'b1          ), // (u_sizedn_memc) <= ()
		.us_hrdata   (hrdata        ), // (u_sizedn_memc,u_sram) => ()
		.us_hready   (hready        ), // (atcrambrg200,u_sizedn_memc) <= ()
		.us_hreadyout(hreadyout     ), // (atcrambrg200,u_sizedn_memc) => ()
		.us_hresp    (hresp[0]      ), // (u_sizedn_memc) => ()
		.us_hsize    (hsize         ), // (atcrambrg200,u_sizedn_memc) <= ()
		.us_hwdata   (hwdata        ), // (u_sizedn_memc,u_sram) <= ()
		.us_hwrite   (hwrite        ), // (atcrambrg200,u_sizedn_memc) <= ()
		.us_htrans   (htrans        ), // (atcrambrg200,u_sizedn_memc) <= ()
		.ds_haddr    (memc_haddr    ), // (u_sizedn_memc) => (memc_wrapper)
		.ds_hburst   (memc_hburst   ), // (u_sizedn_memc) => (memc_wrapper)
		.ds_hprot    (memc_hprot    ), // (u_sizedn_memc) => ()
		.ds_hrdata   (memc_hrdata   ), // (u_sizedn_memc) <= (memc_wrapper)
		.ds_hready   (memc_hreadyout), // (u_sizedn_memc) <= (memc_wrapper)
		.ds_hresp    (memc_hresp[0] ), // (u_sizedn_memc) <= (memc_wrapper)
		.ds_hsize    (memc_hsize    ), // (u_sizedn_memc) => (memc_wrapper)
		.ds_hwdata   (memc_hwdata   ), // (u_sizedn_memc) => (memc_wrapper)
		.ds_hwrite   (memc_hwrite   ), // (u_sizedn_memc) => (memc_wrapper)
		.ds_htrans   (memc_htrans   ), // (u_sizedn_memc) => (memc_wrapper)
		.bufw_err    (/* NC */      )  // (ddr3_controller,u_ddr3,u_sizedn_memc) => ()
	); // end of u_sizedn_memc

end // end of gen_sizedn_hbmc
endgenerate

memc_wrapper memc_wrapper (
      `ifdef MEMC_WRAPPER_AHB0
	.hs0_hburst   (memc_hburst     ), // (memc_wrapper) <= (u_sizedn_memc)
	.hs0_hrdata   (memc_hrdata     ), // (memc_wrapper) => (u_sizedn_memc)
	.hs0_hready   (memc_hreadyout  ), // (memc_wrapper) => (u_sizedn_memc)
	.hs0_hresp    (memc_hresp      ), // (memc_wrapper) => (u_sizedn_memc)
	.hs0_hsize    (memc_hsize      ), // (memc_wrapper) <= (u_sizedn_memc)
	.hs0_hwdata   (memc_hwdata     ), // (memc_wrapper) <= (u_sizedn_memc)
	.hs0_haddr    (memc_haddr      ), // (memc_wrapper) <= (u_sizedn_memc)
	.hs0_hready_in(memc_hready     ), // (memc_wrapper) <= ()
	.hs0_hsel     (memc_hsel       ), // (memc_wrapper) <= ()
	.hs0_htrans   (memc_htrans     ), // (memc_wrapper) <= (u_sizedn_memc)
	.hs0_hwrite   (memc_hwrite     ), // (memc_wrapper) <= (u_sizedn_memc)
      `endif // MEMC_WRAPPER_AHB0
      `ifdef MEMC_WRAPPER_AHB1
	.hs1_hburst   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs1_hrdata   (                ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.hs1_hready   (                ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.hs1_hresp    (                ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.hs1_hsize    (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs1_hwdata   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs1_haddr    (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs1_hready_in(                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs1_hsel     (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs1_htrans   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs1_hwrite   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
      `endif // MEMC_WRAPPER_AHB1
      `ifdef MEMC_WRAPPER_AHB2
	.hs2_hburst   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs2_hrdata   (                ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.hs2_hready   (                ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.hs2_hresp    (                ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.hs2_hsize    (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs2_hwdata   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs2_haddr    (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs2_hready_in(                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs2_hsel     (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs2_htrans   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs2_hwrite   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
      `endif // MEMC_WRAPPER_AHB2
      `ifdef MEMC_WRAPPER_AHB3
	.hs3_hburst   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs3_hrdata   (                ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.hs3_hready   (                ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.hs3_hresp    (                ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.hs3_hsize    (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs3_hwdata   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs3_haddr    (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs3_hready_in(                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs3_hsel     (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs3_htrans   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
	.hs3_hwrite   (                ), // (memc_wrapper) <= (ddr3_controller,memc_wrapper)
      `endif // MEMC_WRAPPER_AHB3
	.hclk         (hclk            ), // (atcrambrg200,memc_wrapper,u_sizedn_memc,u_sram) <= ()
	.hresetn      (hresetn         ), // (atcrambrg200,memc_wrapper,u_sizedn_memc) <= ()
	.memc_addr    (memc_addr       ), // (memc_wrapper) => (ddr3_controller)
	.memc_cmd     (memc_cmd        ), // (memc_wrapper) => (ddr3_controller)
	.memc_en      (memc_en         ), // (memc_wrapper) => (ddr3_controller)
	.memc_rd_end  (memc_rd_end     ), // (memc_wrapper) <= (ddr3_controller)
	.memc_rdy     (memc_rdy        ), // (memc_wrapper) <= (ddr3_controller)
	.memc_wr_data (memc_wr_data    ), // (memc_wrapper) => (ddr3_controller)
	.memc_wr_en   (memc_wr_en      ), // (memc_wrapper) => (ddr3_controller)
	.memc_wr_end  (memc_wr_end     ), // (memc_wrapper) => (ddr3_controller)
	.memc_wr_mask (memc_wr_mask    ), // (memc_wrapper) => (ddr3_controller)
	.memc_wr_rdy  (memc_wr_rdy     ), // (memc_wrapper) <= (ddr3_controller)
	.memc_rd_valid(memc_rd_valid   ), // (memc_wrapper) <= (ddr3_controller)
	.memc_rd_data (memc_rd_data    ), // (memc_wrapper) <= (ddr3_controller)
	.memc_clk     (ui_clk          ), // (memc_wrapper) <= (ddr3_controller,u_ddr3,u_ddr4)
	.memc_resetn  (!ui_clk_sync_rst)  // (memc_wrapper) <= (ddr3_controller)
); // end of memc_wrapper

ddr3_controller ddr3_controller (
	.ddr3_dq            (X_ddr3_dq          ), // (ddr3_controller,u_ddr3) <=> (ddr3_controller,u_ddr3)
	.ddr3_dqs_n         (X_ddr3_dqs_n       ), // (ddr3_controller,u_ddr3) <=> (ddr3_controller,u_ddr3)
	.ddr3_dqs_p         (X_ddr3_dqs_p       ), // (ddr3_controller,u_ddr3) <=> (ddr3_controller,u_ddr3)
	.ddr3_addr          (X_ddr3_addr        ), // (ddr3_controller) => ()
	.ddr3_ba            (X_ddr3_ba          ), // (ddr3_controller) => ()
	.ddr3_ras_n         (X_ddr3_ras_n       ), // (ddr3_controller) => ()
	.ddr3_cas_n         (X_ddr3_cas_n       ), // (ddr3_controller) => ()
	.ddr3_we_n          (X_ddr3_we_n        ), // (ddr3_controller) => ()
	.ddr3_reset_n       (X_ddr3_reset_n     ), // (ddr3_controller) => ()
	.ddr3_ck_p          (X_ddr3_ck_p        ), // (ddr3_controller) => ()
	.ddr3_ck_n          (X_ddr3_ck_n        ), // (ddr3_controller) => ()
	.ddr3_cke           (X_ddr3_cke         ), // (ddr3_controller) => ()
	.ddr3_cs_n          (X_ddr3_cs_n        ), // (ddr3_controller) => ()
	.ddr3_dm            (X_ddr3_dm          ), // (ddr3_controller) => ()
	.ddr3_odt           (X_ddr3_odt         ), // (ddr3_controller) => ()
	.sys_clk_p          (X_ddr3_sys_clk_p   ), // (ddr3_controller) <= ()
	.sys_clk_n          (X_ddr3_sys_clk_n   ), // (ddr3_controller) <= ()
	.app_addr           (memc_addr[28:0]    ), // (ddr3_controller) <= (memc_wrapper)
	.app_cmd            (memc_cmd           ), // (ddr3_controller) <= (memc_wrapper)
	.app_en             (memc_en            ), // (ddr3_controller) <= (memc_wrapper)
	.app_wdf_data       (memc_wr_data       ), // (ddr3_controller) <= (memc_wrapper)
	.app_wdf_end        (memc_wr_end        ), // (ddr3_controller) <= (memc_wrapper)
	.app_wdf_mask       (memc_wr_mask       ), // (ddr3_controller) <= (memc_wrapper)
	.app_wdf_wren       (memc_wr_en         ), // (ddr3_controller) <= (memc_wrapper)
	.app_rd_data        (memc_rd_data       ), // (ddr3_controller) => (memc_wrapper)
	.app_rd_data_end    (memc_rd_end        ), // (ddr3_controller) => (memc_wrapper)
	.app_rd_data_valid  (memc_rd_valid      ), // (ddr3_controller) => (memc_wrapper)
	.app_rdy            (memc_rdy           ), // (ddr3_controller) => (memc_wrapper)
	.app_wdf_rdy        (memc_wr_rdy        ), // (ddr3_controller) => (memc_wrapper)
	.app_sr_req         (1'b0               ), // (ddr3_controller) <= ()
	.app_ref_req        (1'b0               ), // (ddr3_controller) <= ()
	.app_zq_req         (1'b0               ), // (ddr3_controller) <= ()
	.app_sr_active      (                   ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.app_ref_ack        (                   ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.app_zq_ack         (                   ), // (ddr3_controller,memc_wrapper) => (memc_wrapper)
	.ui_clk             (ui_clk             ), // (ddr3_controller,u_ddr3,u_ddr4) => (memc_wrapper)
	.ui_clk_sync_rst    (ui_clk_sync_rst    ), // (ddr3_controller) => (memc_wrapper)
	.init_calib_complete(init_calib_complete), // (ddr3_controller,u_ddr3,u_ddr4) => ()
	.device_temp        (/* NC */           ), // (ddr3_controller,u_ddr3,u_sizedn_memc) => ()
	.sys_rst            (T_por_b            )  // (ddr3_controller,u_ddr3,u_ddr4) <= ()
); // end of ddr3_controller

   `endif // AE350_K7DDR3_SUPPORT
`endif // AE350_AXI_SUPPORT
`ifdef AE350_AXI_SUPPORT
   `ifdef AE350_K7DDR3_SUPPORT
   `else
      `ifdef AE350_VUDDR4_SUPPORT
generate
if ((DATA_WIDTH > DDR4_WRAPPER_DATA_WIDTH)) begin : gen_axi_sdn

	atcsizedn300 #(
		.ADDR_WIDTH      (ADDR_WIDTH      ),
		.DS_DATA_WIDTH   (DDR4_WRAPPER_DATA_WIDTH),
		.ID_WIDTH        (ID_WIDTH        ),
		.US_DATA_WIDTH   (DATA_WIDTH      )
	) u_axi_sdn (
		.ds_bready (ddr4_wrapper_bready ), // (u_axi_sdn) => (u_ddr4)
		.ds_bresp  (ddr4_wrapper_bresp  ), // (u_axi_sdn) <= (u_ddr4)
		.ds_bvalid (ddr4_wrapper_bvalid ), // (u_axi_sdn) <= (u_ddr4)
		.ds_rdata  (ddr4_wrapper_rdata  ), // (u_axi_sdn) <= (u_ddr4)
		.ds_rlast  (ddr4_wrapper_rlast  ), // (u_axi_sdn) <= (u_ddr4)
		.ds_rready (ddr4_wrapper_rready ), // (u_axi_sdn) => (u_ddr4)
		.ds_rresp  (ddr4_wrapper_rresp  ), // (u_axi_sdn) <= (u_ddr4)
		.ds_rvalid (ddr4_wrapper_rvalid ), // (u_axi_sdn) <= (u_ddr4)
		.ds_wdata  (ddr4_wrapper_wdata  ), // (u_axi_sdn) => (u_ddr4)
		.ds_wlast  (ddr4_wrapper_wlast  ), // (u_axi_sdn) => (u_ddr4)
		.ds_wready (ddr4_wrapper_wready ), // (u_axi_sdn) <= (u_ddr4)
		.ds_wstrb  (ddr4_wrapper_wstrb  ), // (u_axi_sdn) => (u_ddr4)
		.ds_wvalid (ddr4_wrapper_wvalid ), // (u_axi_sdn) => (u_ddr4)
		.us_bid    (bid                 ), // (u_axi_sdn,u_sram_brg) => ()
		.us_bready (bready              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_bresp  (bresp               ), // (u_axi_sdn,u_sram_brg) => ()
		.us_bvalid (bvalid              ), // (u_axi_sdn,u_sram_brg) => ()
		.us_rdata  (rdata               ), // (u_axi_sdn,u_sram_brg) => ()
		.us_rid    (rid                 ), // (u_axi_sdn,u_sram_brg) => ()
		.us_rlast  (rlast               ), // (u_axi_sdn,u_sram_brg) => ()
		.us_rready (rready              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_rresp  (rresp               ), // (u_axi_sdn,u_sram_brg) => ()
		.us_rvalid (rvalid              ), // (u_axi_sdn,u_sram_brg) => ()
		.us_wdata  (wdata               ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_wlast  (wlast               ), // (u_axi_sdn) <= ()
		.us_wready (wready              ), // (u_axi_sdn,u_sram_brg) => ()
		.us_wstrb  (wstrb               ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_wvalid (wvalid              ), // (u_axi_sdn,u_sram_brg) <= ()
		.ds_arready(ddr4_wrapper_arready), // (u_axi_sdn) <= (u_ddr4)
		.aclk      (aclk                ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram,u_sram_brg) <= ()
		.aresetn   (aresetn             ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram_brg) <= ()
		.ds_awready(ddr4_wrapper_awready), // (u_axi_sdn) <= (u_ddr4)
		.ds_araddr (ddr4_wrapper_araddr ), // (u_axi_sdn) => (u_ddr4)
		.ds_arburst(ddr4_wrapper_arburst), // (u_axi_sdn) => (u_ddr4)
		.ds_arcache(ddr4_wrapper_arcache), // (u_axi_sdn) => (u_ddr4)
		.ds_arlen  (ddr4_wrapper_arlen  ), // (u_axi_sdn) => (u_ddr4)
		.ds_arlock (ddr4_wrapper_arlock ), // (u_axi_sdn) => (u_ddr4)
		.ds_arprot (ddr4_wrapper_arprot ), // (u_axi_sdn) => (u_ddr4)
		.ds_arsize (ddr4_wrapper_arsize ), // (u_axi_sdn) => (u_ddr4)
		.ds_arvalid(ddr4_wrapper_arvalid), // (u_axi_sdn) => (u_ddr4)
		.us_araddr (araddr              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arburst(arburst             ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arcache(arcache             ), // (u_axi_sdn) <= ()
		.us_arid   (arid                ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arlen  (arlen               ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arlock (arlock              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arprot (arprot              ), // (u_axi_sdn) <= ()
		.us_arready(arready             ), // (u_axi_sdn,u_sram_brg) => ()
		.us_arsize (arsize              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_arvalid(arvalid             ), // (u_axi_sdn,u_sram_brg) <= ()
		.ds_awaddr (ddr4_wrapper_awaddr ), // (u_axi_sdn) => (u_ddr4)
		.ds_awburst(ddr4_wrapper_awburst), // (u_axi_sdn) => (u_ddr4)
		.ds_awcache(ddr4_wrapper_awcache), // (u_axi_sdn) => (u_ddr4)
		.ds_awlen  (ddr4_wrapper_awlen  ), // (u_axi_sdn) => (u_ddr4)
		.ds_awlock (ddr4_wrapper_awlock ), // (u_axi_sdn) => (u_ddr4)
		.ds_awprot (ddr4_wrapper_awprot ), // (u_axi_sdn) => (u_ddr4)
		.ds_awsize (ddr4_wrapper_awsize ), // (u_axi_sdn) => (u_ddr4)
		.ds_awvalid(ddr4_wrapper_awvalid), // (u_axi_sdn) => (u_ddr4)
		.us_awaddr (awaddr              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awburst(awburst             ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awcache(awcache             ), // (u_axi_sdn) <= ()
		.us_awid   (awid                ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awlen  (awlen               ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awlock (awlock              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awprot (awprot              ), // (u_axi_sdn) <= ()
		.us_awready(awready             ), // (u_axi_sdn,u_sram_brg) => ()
		.us_awsize (awsize              ), // (u_axi_sdn,u_sram_brg) <= ()
		.us_awvalid(awvalid             )  // (u_axi_sdn,u_sram_brg) <= ()
	); // end of u_axi_sdn

end // end of gen_axi_sdn
endgenerate

ddr4_wrapper #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DDR4_WRAPPER_DATA_WIDTH),
	.ID_WIDTH        (ID_WIDTH        )
) u_ddr4 (
         `ifdef NDS_FPGA
	.arready                (ddr4_wrapper_arready), // (u_ddr4) => (u_axi_sdn)
	.arvalid                (ddr4_wrapper_arvalid), // (u_ddr4) <= (u_axi_sdn)
	.awready                (ddr4_wrapper_awready), // (u_ddr4) => (u_axi_sdn)
	.awvalid                (ddr4_wrapper_awvalid), // (u_ddr4) <= (u_axi_sdn)
	.bid                    (ddr4_wrapper_bid    ), // (u_ddr4) => ()
	.bresp                  (ddr4_wrapper_bresp  ), // (u_ddr4) => (u_axi_sdn)
	.rid                    (ddr4_wrapper_rid    ), // (u_ddr4) => ()
	.rresp                  (ddr4_wrapper_rresp  ), // (u_ddr4) => (u_axi_sdn)
	.wready                 (ddr4_wrapper_wready ), // (u_ddr4) => (u_axi_sdn)
	.wstrb                  (ddr4_wrapper_wstrb  ), // (u_ddr4) <= (u_axi_sdn)
	.wvalid                 (ddr4_wrapper_wvalid ), // (u_ddr4) <= (u_axi_sdn)
	.bready                 (ddr4_wrapper_bready ), // (u_ddr4) <= (u_axi_sdn)
	.rready                 (ddr4_wrapper_rready ), // (u_ddr4) <= (u_axi_sdn)
	.wlast                  (ddr4_wrapper_wlast  ), // (u_ddr4) <= (u_axi_sdn)
	.aclk                   (aclk                ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram,u_sram_brg) <= ()
	.aresetn                (aresetn             ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram_brg) <= ()
	.arburst                (ddr4_wrapper_arburst), // (u_ddr4) <= (u_axi_sdn)
	.arcache                (ddr4_wrapper_arcache), // (u_ddr4) <= (u_axi_sdn)
	.arid                   (ddr4_wrapper_arid   ), // (u_ddr4) <= ()
	.arlen                  (ddr4_wrapper_arlen  ), // (u_ddr4) <= (u_axi_sdn)
	.arlock                 (ddr4_wrapper_arlock ), // (u_ddr4) <= (u_axi_sdn)
	.arprot                 (ddr4_wrapper_arprot ), // (u_ddr4) <= (u_axi_sdn)
	.arsize                 (ddr4_wrapper_arsize ), // (u_ddr4) <= (u_axi_sdn)
	.awburst                (ddr4_wrapper_awburst), // (u_ddr4) <= (u_axi_sdn)
	.awcache                (ddr4_wrapper_awcache), // (u_ddr4) <= (u_axi_sdn)
	.awid                   (ddr4_wrapper_awid   ), // (u_ddr4) <= ()
	.awlen                  (ddr4_wrapper_awlen  ), // (u_ddr4) <= (u_axi_sdn)
	.awlock                 (ddr4_wrapper_awlock ), // (u_ddr4) <= (u_axi_sdn)
	.awprot                 (ddr4_wrapper_awprot ), // (u_ddr4) <= (u_axi_sdn)
	.awsize                 (ddr4_wrapper_awsize ), // (u_ddr4) <= (u_axi_sdn)
	.ddr4_aresetn           (ddr4_aresetn        ), // (u_ddr4) <= ()
	.ddr3_latency           (ddr3_latency        ), // (u_ddr4) <= ()
	.c0_ddr4_act_n          (X_ddr4_act_n        ), // (u_ddr4) => ()
	.c0_ddr4_adr            (X_ddr4_addr         ), // (u_ddr4) => ()
	.c0_ddr4_ba             (X_ddr4_ba           ), // (u_ddr4) => ()
	.c0_ddr4_bg             (X_ddr4_bg           ), // (u_ddr4) => ()
	.c0_ddr4_ck_c           (X_ddr4_ck_c         ), // (u_ddr4) => ()
	.c0_ddr4_ck_t           (X_ddr4_ck_t         ), // (u_ddr4) => ()
	.c0_ddr4_cke            (X_ddr4_cke          ), // (u_ddr4) => ()
	.c0_ddr4_cs_n           (X_ddr4_cs_n         ), // (u_ddr4) => ()
	.c0_ddr4_odt            (X_ddr4_odt          ), // (u_ddr4) => ()
	.c0_ddr4_reset_n        (X_ddr4_reset_n      ), // (u_ddr4) => ()
	.c0_ddr4_ui_clk_sync_rst(ui_clk_sync_rst     ), // (u_ddr4) => ()
	.c0_sys_clk_n           (X_ddr4_sys_clk_n    ), // (u_ddr4) <= ()
	.c0_sys_clk_p           (X_ddr4_sys_clk_p    ), // (u_ddr4) <= ()
	.sys_rst                (!T_por_b            ), // (ddr3_controller,u_ddr3,u_ddr4) <= ()
         `else
	.arid                   (ddr4_wrapper_arid   ), // (u_ddr4) <= ()
	.arlock                 (ddr4_wrapper_arlock ), // (u_ddr4) <= (u_axi_sdn)
	.arready                (ddr4_wrapper_arready), // (u_ddr4) => (u_axi_sdn)
	.arvalid                (ddr4_wrapper_arvalid), // (u_ddr4) <= (u_axi_sdn)
	.awid                   (ddr4_wrapper_awid   ), // (u_ddr4) <= ()
	.awlock                 (ddr4_wrapper_awlock ), // (u_ddr4) <= (u_axi_sdn)
	.awready                (ddr4_wrapper_awready), // (u_ddr4) => (u_axi_sdn)
	.awvalid                (ddr4_wrapper_awvalid), // (u_ddr4) <= (u_axi_sdn)
	.bid                    (ddr4_wrapper_bid    ), // (u_ddr4) => ()
	.bresp                  (ddr4_wrapper_bresp  ), // (u_ddr4) => (u_axi_sdn)
	.rid                    (ddr4_wrapper_rid    ), // (u_ddr4) => ()
	.rresp                  (ddr4_wrapper_rresp  ), // (u_ddr4) => (u_axi_sdn)
	.wready                 (ddr4_wrapper_wready ), // (u_ddr4) => (u_axi_sdn)
	.wstrb                  (ddr4_wrapper_wstrb  ), // (u_ddr4) <= (u_axi_sdn)
	.wvalid                 (ddr4_wrapper_wvalid ), // (u_ddr4) <= (u_axi_sdn)
	.aclk                   (aclk                ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram,u_sram_brg) <= ()
	.arburst                (ddr4_wrapper_arburst), // (u_ddr4) <= (u_axi_sdn)
	.arcache                (ddr4_wrapper_arcache), // (u_ddr4) <= (u_axi_sdn)
	.aresetn                (aresetn             ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram_brg) <= ()
	.arlen                  (ddr4_wrapper_arlen  ), // (u_ddr4) <= (u_axi_sdn)
	.arprot                 (ddr4_wrapper_arprot ), // (u_ddr4) <= (u_axi_sdn)
	.arsize                 (ddr4_wrapper_arsize ), // (u_ddr4) <= (u_axi_sdn)
	.awburst                (ddr4_wrapper_awburst), // (u_ddr4) <= (u_axi_sdn)
	.awcache                (ddr4_wrapper_awcache), // (u_ddr4) <= (u_axi_sdn)
	.awlen                  (ddr4_wrapper_awlen  ), // (u_ddr4) <= (u_axi_sdn)
	.awprot                 (ddr4_wrapper_awprot ), // (u_ddr4) <= (u_axi_sdn)
	.awsize                 (ddr4_wrapper_awsize ), // (u_ddr4) <= (u_axi_sdn)
	.bready                 (ddr4_wrapper_bready ), // (u_ddr4) <= (u_axi_sdn)
	.rready                 (ddr4_wrapper_rready ), // (u_ddr4) <= (u_axi_sdn)
	.wlast                  (ddr4_wrapper_wlast  ), // (u_ddr4) <= (u_axi_sdn)
	.ddr4_aresetn           (ddr4_aresetn        ), // (u_ddr4) <= ()
	.c0_ddr4_act_n          (X_ddr4_act_n        ), // (u_ddr4) => ()
	.c0_ddr4_adr            (X_ddr4_addr         ), // (u_ddr4) => ()
	.c0_ddr4_ba             (X_ddr4_ba           ), // (u_ddr4) => ()
	.c0_ddr4_bg             (X_ddr4_bg           ), // (u_ddr4) => ()
	.c0_ddr4_ck_c           (X_ddr4_ck_c         ), // (u_ddr4) => ()
	.c0_ddr4_ck_t           (X_ddr4_ck_t         ), // (u_ddr4) => ()
	.c0_ddr4_cke            (X_ddr4_cke          ), // (u_ddr4) => ()
	.c0_ddr4_cs_n           (X_ddr4_cs_n         ), // (u_ddr4) => ()
	.c0_ddr4_odt            (X_ddr4_odt          ), // (u_ddr4) => ()
	.c0_ddr4_reset_n        (X_ddr4_reset_n      ), // (u_ddr4) => ()
	.c0_ddr4_ui_clk_sync_rst(ui_clk_sync_rst     ), // (u_ddr4) => ()
	.c0_sys_clk_n           (X_ddr4_sys_clk_n    ), // (u_ddr4) <= ()
	.c0_sys_clk_p           (X_ddr4_sys_clk_p    ), // (u_ddr4) <= ()
	.sys_rst                (!T_por_b            ), // (ddr3_controller,u_ddr3,u_ddr4) <= ()
         `endif // NDS_FPGA
	.araddr                 (ddr4_wrapper_araddr ), // (u_ddr4) <= (u_axi_sdn)
	.awaddr                 (ddr4_wrapper_awaddr ), // (u_ddr4) <= (u_axi_sdn)
	.bvalid                 (ddr4_wrapper_bvalid ), // (u_ddr4) => (u_axi_sdn)
	.rdata                  (ddr4_wrapper_rdata  ), // (u_ddr4) => (u_axi_sdn)
	.rlast                  (ddr4_wrapper_rlast  ), // (u_ddr4) => (u_axi_sdn)
	.rvalid                 (ddr4_wrapper_rvalid ), // (u_ddr4) => (u_axi_sdn)
	.wdata                  (ddr4_wrapper_wdata  ), // (u_ddr4) <= (u_axi_sdn)
	.c0_ddr4_dm_dbi_n       (X_ddr4_dm_dbi_n     ), // (u_ddr4) <=> (u_ddr4)
	.c0_ddr4_dq             (X_ddr4_dq           ), // (u_ddr4) <=> (u_ddr4)
	.c0_ddr4_dqs_c          (X_ddr4_dqs_c        ), // (u_ddr4) <=> (u_ddr4)
	.c0_ddr4_dqs_t          (X_ddr4_dqs_t        ), // (u_ddr4) <=> (u_ddr4)
	.c0_ddr4_ui_clk         (ui_clk              ), // (ddr3_controller,u_ddr3,u_ddr4) => (memc_wrapper)
	.c0_init_calib_complete (init_calib_complete )  // (ddr3_controller,u_ddr3,u_ddr4) => ()
); // end of u_ddr4

      `else
atcrambrg300 #(
	.ADDR_WIDTH      (RAMBRG_ADDR_WIDTH),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OOR_ERR_EN      (1               )
) u_sram_brg (
	.awid    (awid                         ), // (u_axi_sdn,u_sram_brg) <= ()
	.awaddr  (awaddr[RAMBRG_ADDR_WIDTH-1:0]), // (u_axi_sdn,u_sram_brg) <= ()
	.awlen   (awlen                        ), // (u_axi_sdn,u_sram_brg) <= ()
	.awsize  (awsize                       ), // (u_axi_sdn,u_sram_brg) <= ()
	.awburst (awburst                      ), // (u_axi_sdn,u_sram_brg) <= ()
	.awlock  (awlock                       ), // (u_axi_sdn,u_sram_brg) <= ()
	.awvalid (awvalid                      ), // (u_axi_sdn,u_sram_brg) <= ()
	.awready (awready                      ), // (u_axi_sdn,u_sram_brg) => ()
	.wdata   (wdata                        ), // (u_axi_sdn,u_sram_brg) <= ()
	.wstrb   (wstrb                        ), // (u_axi_sdn,u_sram_brg) <= ()
	.wvalid  (wvalid                       ), // (u_axi_sdn,u_sram_brg) <= ()
	.wready  (wready                       ), // (u_axi_sdn,u_sram_brg) => ()
	.bid     (bid                          ), // (u_axi_sdn,u_sram_brg) => ()
	.bresp   (bresp                        ), // (u_axi_sdn,u_sram_brg) => ()
	.bvalid  (bvalid                       ), // (u_axi_sdn,u_sram_brg) => ()
	.bready  (bready                       ), // (u_axi_sdn,u_sram_brg) <= ()
	.arid    (arid                         ), // (u_axi_sdn,u_sram_brg) <= ()
	.araddr  (araddr[RAMBRG_ADDR_WIDTH-1:0]), // (u_axi_sdn,u_sram_brg) <= ()
	.arlen   (arlen                        ), // (u_axi_sdn,u_sram_brg) <= ()
	.arsize  (arsize                       ), // (u_axi_sdn,u_sram_brg) <= ()
	.arburst (arburst                      ), // (u_axi_sdn,u_sram_brg) <= ()
	.arlock  (arlock                       ), // (u_axi_sdn,u_sram_brg) <= ()
	.arvalid (arvalid                      ), // (u_axi_sdn,u_sram_brg) <= ()
	.arready (arready                      ), // (u_axi_sdn,u_sram_brg) => ()
	.rid     (rid                          ), // (u_axi_sdn,u_sram_brg) => ()
	.rdata   (rdata                        ), // (u_axi_sdn,u_sram_brg) => ()
	.rresp   (rresp                        ), // (u_axi_sdn,u_sram_brg) => ()
	.rlast   (rlast                        ), // (u_axi_sdn,u_sram_brg) => ()
	.rvalid  (rvalid                       ), // (u_axi_sdn,u_sram_brg) => ()
	.rready  (rready                       ), // (u_axi_sdn,u_sram_brg) <= ()
	.mem_addr(mem_addr                     ), // (u_sram_brg) => (u_sram)
	.mem_web (mem_web                      ), // (u_sram_brg) => (u_sram)
	.mem_csb (mem_csb                      ), // (u_sram_brg) => (u_sram)
	.mem_din (mem_din                      ), // (u_sram_brg) => (u_sram)
	.mem_dout(mem_dout                     ), // (u_sram_brg) <= (u_sram)
	.aclk    (aclk                         ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram,u_sram_brg) <= ()
	.aresetn (aresetn                      )  // (u_axi_sdn,u_ddr3,u_ddr4,u_sram_brg) <= ()
); // end of u_sram_brg

      `endif // AE350_VUDDR4_SUPPORT
   `endif // AE350_K7DDR3_SUPPORT
`else
   `ifdef AE350_K7DDR3_SUPPORT
   `else
atcrambrg200 #(
	.ADDR_WIDTH      (RAMBRG_ADDR_WIDTH),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.OOR_ERR_EN      (1               )
) atcrambrg200 (
	.hclk     (hclk      ), // (atcrambrg200,memc_wrapper,u_sizedn_memc,u_sram) <= ()
	.hresetn  (hresetn   ), // (atcrambrg200,memc_wrapper,u_sizedn_memc) <= ()
	.hsel     (hsel      ), // (atcrambrg200) <= ()
	.hready   (hready    ), // (atcrambrg200,u_sizedn_memc) <= ()
	.haddr    (haddr[RAMBRG_ADDR_WIDTH-1:0]), // (atcrambrg200,u_sizedn_memc) <= ()
	.hwrite   (hwrite    ), // (atcrambrg200,u_sizedn_memc) <= ()
	.htrans   (htrans    ), // (atcrambrg200,u_sizedn_memc) <= ()
	.hsize    (hsize     ), // (atcrambrg200,u_sizedn_memc) <= ()
	.hburst   (hburst    ), // (atcrambrg200,u_sizedn_memc) <= ()
	.hprot    (hprot     ), // (atcrambrg200,u_sizedn_memc) <= ()
	.hreadyout(hreadyout ), // (atcrambrg200,u_sizedn_memc) => ()
	.hresp    (hresp_1bit), // (atcrambrg200) => ()
	.mem_csb  (mem_csb   ), // (atcrambrg200) => (u_sram)
	.mem_web  (mem_web   ), // (atcrambrg200) => (u_sram)
	.mem_addr (mem_addr  )  // (atcrambrg200) => (u_sram)
); // end of atcrambrg200

   `endif // AE350_K7DDR3_SUPPORT
`endif // AE350_AXI_SUPPORT
`ifdef AE350_AXI_SUPPORT
   `ifdef AE350_K7DDR3_SUPPORT
   `else
      `ifdef AE350_VUDDR4_SUPPORT
      `else
ae350_rambrg_ram #(
	.ADDR_WIDTH      (MEM_ADDR_WIDTH  ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_sram (
	.addr(mem_addr), // (u_sram) <= (u_sram_brg)
	.clk (aclk    ), // (u_axi_sdn,u_ddr3,u_ddr4,u_sram,u_sram_brg) <= ()
	.csb (mem_csb ), // (u_sram) <= (u_sram_brg)
	.web (mem_web ), // (u_sram) <= (u_sram_brg)
	.din (mem_din ), // (u_sram) <= (u_sram_brg)
	.dout(mem_dout)  // (u_sram) => (u_sram_brg)
); // end of u_sram

      `endif // AE350_VUDDR4_SUPPORT
   `endif // AE350_K7DDR3_SUPPORT
`else
   `ifdef AE350_K7DDR3_SUPPORT
   `else
ae350_rambrg_ram #(
	.ADDR_WIDTH      (MEM_ADDR_WIDTH  ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_sram (
	.addr(mem_addr), // (u_sram) <= (atcrambrg200)
	.clk (hclk    ), // (atcrambrg200,memc_wrapper,u_sizedn_memc,u_sram) <= ()
	.csb (mem_csb ), // (u_sram) <= (atcrambrg200)
	.web (mem_web ), // (u_sram) <= (atcrambrg200)
	.din (hwdata  ), // (u_sizedn_memc,u_sram) <= ()
	.dout(hrdata  )  // (u_sizedn_memc,u_sram) => ()
); // end of u_sram

   `endif // AE350_K7DDR3_SUPPORT
`endif // AE350_AXI_SUPPORT
endmodule
// VPERL_GENERATED_END
