`include "atcbusdec200_config.vh"
`include "atcbusdec200_const.vh"

`include "atcapbbrg100_config.vh"
`include "atcapbbrg100_const.vh"

`ifdef AE350_SMC_SUPPORT
`include "atfsmc020_config.vh"
`include "atfsmc020_const.vh"
`endif

`ifdef  AE350_LCDC_SUPPORT
`include "atflcdc100_config.vh"
`include "atflcdc100_const.vh"
`endif

`ifdef AE350_MAC_SUPPORT
`include "atfmac100_config.vh"
`include "atfmac100_const.vh"
`endif // AE350_MAC_SUPPORT

// VPERL_BEGIN
// &MODULE("ae350_ahb_subsystem");
// &PARAM("ADDR_MSB=`ATCBUSDEC200_ADDR_WIDTH-1")
// &PARAM("DATA_MSB=`ATCBUSDEC200_DATA_WIDTH-1")
// #------ Interface ------#
// &FORCE("output", "hbmc_hresp[1:0]");
// &FORCE("input",  "hbmc_hprot[3:0]");
// &FORCE("input",  "hbmc_hsize[2:0]");
// &FORCE("input",  "hbmc_hburst[2:0]");
// &FORCE("input",  "hbmc_hwdata[31:0]");
// &FORCE("input",  "hbmc_haddr[ADDR_MSB:0]");
// &FORCE("input",  "hbmc_hwrite");
//
// &IFDEF("AE350_SMC_SUPPORT");
// &FORCE("output", "smc_addr[24:0]");
// &ENDIF("AE350_SMC_SUPPORT");
//
// &IFDEF("AE350_LCDC_SUPPORT");
// &FORCE("output", "lcdc_hwdata[31:0]");
// &FORCE("output", "lcd_gpo[7:0]");
// &ENDIF("AE350_LCDC_SUPPORT");
//
// &IFDEF("ATCBUSDEC200_SLV1_SUPPORT")
// &FORCE("input",  "ahb2apb_hresp[1:0]");
// &FORCE("output", "ahb2apb_haddr[`ATCAPBBRG100_ADDR_MSB:0]");
// &FORCE("output", "ahb2apb_hprot[3:0]");
// &FORCE("output", "ahb2apb_hready_in");
// &FORCE("output", "ahb2apb_hsel");
// &FORCE("output", "ahb2apb_hsize[2:0]");
// &FORCE("output", "ahb2apb_htrans[1:0]");
// &FORCE("output", "ahb2apb_hwdata[`ATCBUSDEC200_DATA_WIDTH-1:0]");
// &FORCE("output", "ahb2apb_hwrite");
// &ENDIF("ATCBUSDEC200_SLV1_SUPPORT")
//
// #------ Internal signals ------#
// &DANGLER("hbmc_hresp_1bit");
// &DANGLER("smc_ini_mbw");
// &DANGLER("smc_vlio_rdy");
//
// #------ Be configurable ------#
// $AHB_SLV_APBBRG		= 1;
// $AHB_SLV_SMC_REG		= 2;
// $AHB_SLV_LCDC		= 3;
// $AHB_SLV_MAC			= 4;
//
// #------ Interrupt ------#
// &FORCE("output", "mac_int");
// &FORCE("output", "lcd_intr");
//
// :`ifdef AE350_MAC_SUPPORT
// :`else //~AE350_MAC_SUPPORT
// : assign mac_int = 1'b0;
// :`endif
//
// :`ifdef AE350_LCDC_SUPPORT
// :`else //~AE350_LCDC_SUPPORT
// : assign lcd_intr = 1'b0;
// :`endif
//
// : `ifdef AE350_SMC_SUPPORT
// :	`ifdef NDS_FPGA
// : assign smc_ini_mbw = 2'b01;  // 16-bit for FPGA ORCA board 
// :	`else
// : assign smc_ini_mbw = 2'b10;  // 32-bit for Leopard SMC ROM simulation model compatable
// :	`endif
// : assign smc_vlio_rdy = 1'b1;
// : `endif //AE350_SMC_SUPPORT
//
// :`ifdef AE350_LCDC_SUPPORT
// : assign lcdc_hwdata = 32'h0;
// :`endif
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcbusdec200/hdl/atcbusdec200.v","u_hbmc", {
//      ADDR_WIDTH      => "ADDR_MSB+1"
// });
//
// #------ Interface port ------#
//	&CONNECT("u_hbmc.us_haddr"		, "hbmc_haddr"		);
//	&CONNECT("u_hbmc.us_hsel"		, "hbmc_hsel"		);
//	&CONNECT("u_hbmc.us_htrans"		, "hbmc_htrans"		);
//	&CONNECT("u_hbmc.us_hrdata"		, "hbmc_hrdata"		);
//	&CONNECT("u_hbmc.us_hready"		, "hbmc_hready"		);
//	&CONNECT("u_hbmc.us_hreadyout"		, "hbmc_hreadyout"	);
//	&CONNECT("u_hbmc.us_hresp"		, "hbmc_hresp_1bit"	);
//	: assign hbmc_hresp = {1'b0, hbmc_hresp_1bit};
//
// #------ $AHB_SLV_APBBRG ------#
// $i = $AHB_SLV_APBBRG;
//	&CONNECT("u_hbmc.ds${i}_hsel"		, "ahb2apb_hsel"	);
//	&CONNECT("u_hbmc.ds${i}_hrdata"		, "ahb2apb_hrdata"	);
//	&CONNECT("u_hbmc.ds${i}_hreadyout"	, "ahb2apb_hready"	);
//	&CONNECT("u_hbmc.ds${i}_hresp"		, "ahb2apb_hresp[0]"	);
//	: `ifdef ATCBUSDEC200_SLV1_SUPPORT
//	: 	assign ahb2apb_haddr = hbmc_haddr[`ATCAPBBRG100_ADDR_MSB:0];
//	:	assign ahb2apb_hprot = hbmc_hprot;
//	:	assign ahb2apb_hready_in = ds_hready;
//	:	assign ahb2apb_hsize = hbmc_hsize;
//	:	assign ahb2apb_htrans = hbmc_htrans;
//	:	assign ahb2apb_hwdata = hbmc_hwdata;
//	:	assign ahb2apb_hwrite = hbmc_hwrite;
//	: `endif // ATCBUSDEC200_SLV1_SUPPORT
//
// #------ $AHB_SLV_SMC_REG ------#
// $i = $AHB_SLV_SMC_REG;
// &IFDEF("AE350_SMC_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atfsmc020/hdl/atfsmc020.v", "smcctrl");
// &ENDIF("AE350_SMC_SUPPORT");
// 	#------ AHB reg interface  ------#
//	&CONNECT("smcctrl.HCLK"			, "hclk"	);
//	&CONNECT("smcctrl.HRESETn"		, "hresetn"	);
// &IFDEF("AE350_SMC_SUPPORT");
//	&CONNECT("u_hbmc.ds${i}_hsel"		, "smcctrl.hsel_reg"		, "ds${i}_hsel"		);
//	&CONNECT("u_hbmc.ds${i}_hrdata"		, "smcctrl.hrdata_reg_r"	, "ds${i}_hrdata"	);
//	&CONNECT("u_hbmc.ds${i}_hreadyout"	, "smcctrl.hready_out_reg_r"	, "ds${i}_hreadyout"	);
//	&CONNECT("smcctrl.hresp_reg_r"		, "ds${i}_hresp[1:0]"	);
//	&CONNECT("u_hbmc.ds${i}_hresp"		, "ds${i}_hresp[0]"	);
// &ENDIF("AE350_SMC_SUPPORT");
//	&CONNECT("smcctrl.hready_reg_in"	, "ds_hready"		);
//	&CONNECT("smcctrl.htrans_reg"		, "hbmc_htrans"	);
//	&CONNECT("smcctrl.hburst_reg"		, "hbmc_hburst"	);
//	&CONNECT("smcctrl.hsize_reg"		, "hbmc_hsize"	);
//	&CONNECT("smcctrl.hwrite_reg"		, "hbmc_hwrite"	);
//	&CONNECT("smcctrl.haddr_reg"		, "hbmc_haddr[31:0]"    );
//	&CONNECT("smcctrl.hwdata_reg"		, "hbmc_hwdata"	);
// 	#------ AHB mem interface  ------#
//	&CONNECT("smcctrl.hsel_mem"		, "smc_mem_hsel"	);
//	&CONNECT("smcctrl.hready_mem_in"	, "smc_mem_hready"	);
//	&CONNECT("smcctrl.htrans_mem"		, "smc_mem_htrans"	);
//	&CONNECT("smcctrl.hburst_mem"		, "smc_mem_hburst"	);
//	&CONNECT("smcctrl.hsize_mem"		, "smc_mem_hsize"	);
//	&CONNECT("smcctrl.hwrite_mem"		, "smc_mem_hwrite"	);
//	&CONNECT("smcctrl.haddr_mem"		, "smc_mem_haddr"	);
//	&CONNECT("smcctrl.hwdata_mem"		, "smc_mem_hwdata"	);
//	&CONNECT("smcctrl.hready_out_mem_r"	, "smc_mem_hreadyout"	);
//	&CONNECT("smcctrl.hresp_mem_r"		, "smc_mem_hresp"	);
//	&CONNECT("smcctrl.hrdata_mem_r"		, "smc_mem_hrdata"	);
// 	#------ SMC  ------#
//	&CONNECT("smcctrl.smc_dqin_a"		, "T_memdata"	);
//	&CONNECT("smcctrl.smc_csb_r"		, "smc_cs_n"	);
//	&CONNECT("smcctrl.smc_web_r"		, "smc_we_n"	);
//	&CONNECT("smcctrl.smc_beb_r"		, "/* NC */"	);
//	&CONNECT("smcctrl.smc_addr_r"		, "{smc_addr_r_dummy,smc_addr[24:0]}"	);
//	&CONNECT("smcctrl.smc_oeb_r"		, "smc_oe_n"	);
//	&CONNECT("smcctrl.ini_mbw"		, "smc_ini_mbw"	);
//	&CONNECT("smcctrl.smc_vlio_rdy"		, "smc_vlio_rdy"	);
//	&CONNECT("smcctrl.smc_parity_out_r"	, "/* NC */"	);
//	&CONNECT("smcctrl.smc_dqout_r"		, "smc_dqout"	);
//	&CONNECT("smcctrl.smc_data_oe_r"		, "smc_data_oe"	);
//	&CONNECT("smcctrl.smc_parity_in_a"	, "4'h0"	);
// 	#------ Constant or unused  ------#
//	&CONNECT("smcctrl.endian"		, "1'b0"	);
//	&CONNECT("smcctrl.hready_in"		, "1'b1"	);
//	&CONNECT("smcctrl.htrans"		, "2'h0"	);
//	&CONNECT("smcctrl.hburst"		, "3'h0"	);
//	&CONNECT("smcctrl.hsize"		, "3'h0"	);
//	&CONNECT("smcctrl.hwrite"		, "1'b0"	);
//	&CONNECT("smcctrl.haddr"		, "32'h0"	);
//	&CONNECT("smcctrl.hwdata"		, "32'h0"	);
//	&CONNECT("smcctrl.ebi_gnt_a"		, "1'b1"	);
//	&CONNECT("smcctrl.ebi_req_r"		, "/* NC */"	);
//	&CONNECT("smcctrl.smc_adsc_r"		, "/* NC */"	);
//
// #------ $AHB_SLV_LCDC ------#
// $i = $AHB_SLV_LCDC;
// &IFDEF("AE350_LCDC_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atflcdc100/hdl/atflcdc100.v","u_lcdc");
// &ENDIF("AE350_LCDC_SUPPORT");
//	#------ AHB slave interface  ------#
//	&CONNECT("u_lcdc",{
//		HCLK                    => "hclk",
//		HRESETn                 => "hresetn",
//	});
// &IFDEF("AE350_LCDC_SUPPORT");
//	&CONNECT("u_hbmc.ds${i}_hsel"		, "u_lcdc.HSELS"		, "ds${i}_hsel"		);
//	&CONNECT("u_hbmc.ds${i}_hrdata"		, "u_lcdc.HRDATAS"		, "ds${i}_hrdata"	);
//	&CONNECT("u_hbmc.ds${i}_hreadyout"	, "u_lcdc.HREADYSout"		, "ds${i}_hreadyout"	);
//	&CONNECT("u_lcdc.HRESPS"		, "ds${i}_hresp[1:0]"	);
//	&CONNECT("u_hbmc.ds${i}_hresp"		, "ds${i}_hresp[0]"	);
// &ENDIF("AE350_LCDC_SUPPORT");
//	&CONNECT("u_lcdc",{
//		HADDRS                  => "hbmc_haddr[15:2]",
//		HTRANSS                 => "hbmc_htrans",
//		HWRITES                 => "hbmc_hwrite",
//		HREADYSin               => "ds_hready",
//		HWDATAS                 => "hbmc_hwdata",
//	});
//
//	#------ AHB master interface  ------#
//	&CONNECT("u_lcdc",{
//		HADDRM                  => "lcdc_haddr",
//		HTRANSM                 => "lcdc_htrans",
//		HWRITEM                 => "lcdc_hwrite",
//		HSIZEM                  => "lcdc_hsize",
//		HBURSTM                 => "lcdc_hburst",
//		HPROTM                  => "lcdc_hprot",
//		HREADYMin               => "lcdc_hreadyout",
//		HRESPM                  => "lcdc_hresp",
//		HRDATAM                 => "lcdc_hrdata",
//		HLOCKM                  => "/* NC */",
//		HBUSREQM                => "/* NC */",
//		HGRANTM                 => "1'b1",
//	});
//	#------ AHB lcd interface  ------#
//	&CONNECT("u_lcdc",{
//		LC_HS                   => "cllp",
//		LC_VS                   => "clfp",
//		LC_DE                   => "clac",
//		LC_LE                   => "clle",
//		LC_PCLK                 => "clcp",
//		LC_DATA                 => "cld",
//		LC_CLK                  => "lcd_clk",
//		LC_CLKn                 => "lcd_clkn",
//		LC_RSTn                 => "hresetn",
//		LC_MERRINTR             => "/* NC */ ",
//		LC_FURINTR              => "/* NC */",
//		LC_BAUPDINTR            => "/* NC */",
//		LC_VSTATUSINTR          => "/* NC */",
//		LC_INTR                 => "lcd_intr",
//		GPO                     => "lcd_gpo",
//		GPI                     => "lcd_gpo",
//		AP_HS                   => "/* NC */",
//		AP_VS                   => "/* NC */",
//		AP_PCLK                 => "/* NC */",
//		AP_DE                   => "/* NC */",
//		AP_DATA                 => "/* NC */",
//		lc_dbg			=> "/* NC */",
//	});
//
// #------ $AHB_SLV_MAC ------#
// $i = $AHB_SLV_MAC;
// &IFDEF("AE350_MAC_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atfmac100/hdl/atfmac100.v", "u_mac");
// &ENDIF("AE350_MAC_SUPPORT");
//	#------ AHB slave interface  ------#
// &IFDEF("AE350_MAC_SUPPORT")
//	&CONNECT("u_hbmc.ds${i}_hsel"		, "u_mac.hsel"		, "ds${i}_hsel"		);
//	&CONNECT("u_hbmc.ds${i}_hrdata"		, "u_mac.hrdata_out"		, "ds${i}_hrdata"	);
//	&CONNECT("u_hbmc.ds${i}_hreadyout"	, "u_mac.hready_out"		, "ds${i}_hreadyout"	);
//	&CONNECT("u_mac.hresp_out"		, "ds${i}_hresp[1:0]"	);
//	&CONNECT("u_hbmc.ds${i}_hresp"		, "ds${i}_hresp[0]"	);
// &ENDIF("AE350_MAC_SUPPORT")
//
//	&CONNECT("u_mac", {
//		hready_in           => "ds_hready",
//		haddr_in            => "hbmc_haddr[31:0]",
//		hwrite_in           => "hbmc_hwrite",
//		htrans_in           => "hbmc_htrans",
//		hsize_in            => "hbmc_hsize",
//		hburst_in           => "hbmc_hburst",
//		hwdata_in           => "hbmc_hwdata",
//	});
//
//	#------ AHB master interface  ------#
//	&CONNECT("u_mac", {
//		hbusreq             => "/* NC */",
//		hlock               => "/* NC */",
//		hgrant              => "1'b1",
//		hready_mst_in       => "mac_hreadyout",
//		hresp_in            => "mac_hresp",
//		htrans_out          => "mac_htrans",
//		hwrite_out          => "mac_hwrite",
//		hsize_out           => "mac_hsize",
//		hburst_out          => "mac_hburst",
//		hprot               => "mac_hprot",
//		haddr_out           => "mac_haddr",
//		hwdata_out          => "mac_hwdata",
//		hrdata_in           => "mac_hrdata",
//	});
// 
//	&CONNECT("u_mac", {
//		mac_int	     => "mac_int",
//		ahb_edn             => "1'b1",
//		CRS                 => "T_crs",
//		COL                 => "T_col",
//		TX_CK               => "T_tx_clk",
//		TXD                 => "txd",
//		TX_EN               => "tx_en",
//		RX_CK               => "T_rx_clk",
//		RXD                 => "T_rxd",
//		RX_ER               => "T_rx_er",
//		RX_DV               => "T_rx_dv",
//		MDC                 => "mdc",
//		MDIO_out_en         => "mdio_out_en",
//		MDIO_out            => "mdio_out",
//		MDIO_in             => "T_mdio",
//		WOL                 => "/* NC */",
//		phy_linksts         => "T_phy_linksts",
//		pdn_phy             => "pdn_phy",
//	});
//
// #------ Unused port ------#
// for($i=5;$i<32;$i++) {
//	&CONNECT("u_hbmc.ds${i}_hrdata"		, "{(DATA_MSB+1){1'b0}}");
//	&CONNECT("u_hbmc.ds${i}_hreadyout"	, "1'b1"	);
//	&CONNECT("u_hbmc.ds${i}_hresp"		, "1'b0"	);
//	&CONNECT("u_hbmc.ds${i}_hsel"		, "/* NC */"	);
// }
//
//
// &ENDMODULE
// VPERL_END

// VPERL_GENERATED_BEGIN
module ae350_ahb_subsystem (
`ifdef AE350_SMC_SUPPORT
	  T_memdata,         // (smcctrl) <= ()
	  smc_addr,          // (smcctrl) => ()
	  smc_cs_n,          // (smcctrl) => ()
	  smc_data_oe,       // (smcctrl) => ()
	  smc_dqout,         // (smcctrl) => ()
	  smc_mem_hrdata,    // (smcctrl) => ()
	  smc_mem_hreadyout, // (smcctrl) => ()
	  smc_mem_hresp,     // (smcctrl) => ()
	  smc_mem_hsel,      // (smcctrl) <= ()
	  smc_oe_n,          // (smcctrl) => ()
	  smc_we_n,          // (smcctrl) => ()
`endif // AE350_SMC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
	  lcdc_hwdata,       // () => ()
	  clac,              // (u_lcdc) => ()
	  clcp,              // (u_lcdc) => ()
	  cld,               // (u_lcdc) => ()
	  clfp,              // (u_lcdc) => ()
	  clle,              // (u_lcdc) => ()
	  cllp,              // (u_lcdc) => ()
	  lcd_clk,           // (u_lcdc) <= ()
	  lcd_clkn,          // (u_lcdc) <= ()
	  lcd_gpo,           // (u_lcdc) => (u_lcdc)
	  lcdc_haddr,        // (u_lcdc) => ()
	  lcdc_hburst,       // (u_lcdc) => ()
	  lcdc_hprot,        // (u_lcdc) => ()
	  lcdc_hrdata,       // (u_lcdc) <= ()
	  lcdc_hreadyout,    // (u_lcdc) <= ()
	  lcdc_hresp,        // (u_lcdc) <= ()
	  lcdc_hsize,        // (u_lcdc) => ()
	  lcdc_htrans,       // (u_lcdc) => ()
	  lcdc_hwrite,       // (u_lcdc) => ()
`endif // AE350_LCDC_SUPPORT
`ifdef ATCBUSDEC200_SLV1_SUPPORT
	  ahb2apb_haddr,     // () => ()
	  ahb2apb_hprot,     // () => ()
	  ahb2apb_hready_in, // () => ()
	  ahb2apb_hsize,     // () => ()
	  ahb2apb_htrans,    // () => ()
	  ahb2apb_hwdata,    // () => ()
	  ahb2apb_hwrite,    // () => ()
	  ahb2apb_hrdata,    // (u_hbmc) <= ()
	  ahb2apb_hready,    // (u_hbmc) <= ()
	  ahb2apb_hresp,     // (u_hbmc) <= ()
	  ahb2apb_hsel,      // (u_hbmc) => ()
`endif // ATCBUSDEC200_SLV1_SUPPORT
`ifdef AE350_MAC_SUPPORT
	  T_col,             // (u_mac) <= ()
	  T_crs,             // (u_mac) <= ()
	  T_mdio,            // (u_mac) <= ()
	  T_phy_linksts,     // (u_mac) <= ()
	  T_rx_clk,          // (u_mac) <= ()
	  T_rx_dv,           // (u_mac) <= ()
	  T_rx_er,           // (u_mac) <= ()
	  T_rxd,             // (u_mac) <= ()
	  T_tx_clk,          // (u_mac) <= ()
	  mac_haddr,         // (u_mac) => ()
	  mac_hburst,        // (u_mac) => ()
	  mac_hprot,         // (u_mac) => ()
	  mac_hrdata,        // (u_mac) <= ()
	  mac_hresp,         // (u_mac) <= ()
	  mac_hsize,         // (u_mac) => ()
	  mac_htrans,        // (u_mac) => ()
	  mac_hwdata,        // (u_mac) => ()
	  mac_hwrite,        // (u_mac) => ()
	  mdc,               // (u_mac) => ()
	  mdio_out,          // (u_mac) => ()
	  mdio_out_en,       // (u_mac) => ()
	  pdn_phy,           // (u_mac) => ()
	  tx_en,             // (u_mac) => ()
	  txd,               // (u_mac) => ()
`endif // AE350_MAC_SUPPORT
`ifdef AE350_SMC_SUPPORT
   `ifdef ATFSMC020_SEPARATE_AHB
	  smc_mem_haddr,     // (smcctrl) <= ()
	  smc_mem_hburst,    // (smcctrl) <= ()
	  smc_mem_hready,    // (smcctrl) <= ()
	  smc_mem_hsize,     // (smcctrl) <= ()
	  smc_mem_htrans,    // (smcctrl) <= ()
	  smc_mem_hwdata,    // (smcctrl) <= ()
	  smc_mem_hwrite,    // (smcctrl) <= ()
   `endif // ATFSMC020_SEPARATE_AHB
`endif // AE350_SMC_SUPPORT
`ifdef AE350_MAC_SUPPORT
   `ifdef ATFMAC100_SEPARATE_HREADY
	  mac_hreadyout,     // (u_mac) <= ()
   `endif // ATFMAC100_SEPARATE_HREADY
`endif // AE350_MAC_SUPPORT
	  hbmc_hprot,        // () <= ()
	  hbmc_hresp,        // () => ()
	  hbmc_haddr,        // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	  hbmc_htrans,       // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	  hclk,              // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	  hresetn,           // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	  hbmc_hwdata,       // (smcctrl,u_lcdc,u_mac) <= ()
	  hbmc_hwrite,       // (smcctrl,u_lcdc,u_mac) <= ()
	  hbmc_hburst,       // (smcctrl,u_mac) <= ()
	  hbmc_hsize,        // (smcctrl,u_mac) <= ()
	  hbmc_hrdata,       // (u_hbmc) => ()
	  hbmc_hready,       // (u_hbmc) <= ()
	  hbmc_hreadyout,    // (u_hbmc) => ()
	  hbmc_hsel,         // (u_hbmc) <= ()
	  lcd_intr,          // (u_lcdc) => ()
	  mac_int            // (u_mac) => ()
);

parameter ADDR_MSB=`ATCBUSDEC200_ADDR_WIDTH-1;
parameter DATA_MSB=`ATCBUSDEC200_DATA_WIDTH-1;

`ifdef AE350_SMC_SUPPORT
input         [(`ATFSMC020_EMB_WIDTH)-1:0] T_memdata;
output                              [24:0] smc_addr;
output       [(`ATFSMC020_EBNK_COUNT)-1:0] smc_cs_n;
output        [(`ATFSMC020_EMB_WIDTH)-1:0] smc_data_oe;
output        [(`ATFSMC020_EMB_WIDTH)-1:0] smc_dqout;
output                              [31:0] smc_mem_hrdata;
output                                     smc_mem_hreadyout;
output                               [1:0] smc_mem_hresp;
input                                      smc_mem_hsel;
output                                     smc_oe_n;
output                                     smc_we_n;
`endif // AE350_SMC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
output                              [31:0] lcdc_hwdata;
output                                     clac;
output                                     clcp;
output                              [23:0] cld;
output                                     clfp;
output                                     clle;
output                                     cllp;
input                                      lcd_clk;
input                                      lcd_clkn;
output                               [7:0] lcd_gpo;
output                              [31:0] lcdc_haddr;
output                               [2:0] lcdc_hburst;
output                               [3:0] lcdc_hprot;
input                               [31:0] lcdc_hrdata;
input                                      lcdc_hreadyout;
input                                [1:0] lcdc_hresp;
output                               [2:0] lcdc_hsize;
output                               [1:0] lcdc_htrans;
output                                     lcdc_hwrite;
`endif // AE350_LCDC_SUPPORT
`ifdef ATCBUSDEC200_SLV1_SUPPORT
output          [`ATCAPBBRG100_ADDR_MSB:0] ahb2apb_haddr;
output                               [3:0] ahb2apb_hprot;
output                                     ahb2apb_hready_in;
output                               [2:0] ahb2apb_hsize;
output                               [1:0] ahb2apb_htrans;
output      [`ATCBUSDEC200_DATA_WIDTH-1:0] ahb2apb_hwdata;
output                                     ahb2apb_hwrite;
input                         [DATA_MSB:0] ahb2apb_hrdata;
input                                      ahb2apb_hready;
input                                [1:0] ahb2apb_hresp;
output                                     ahb2apb_hsel;
`endif // ATCBUSDEC200_SLV1_SUPPORT
`ifdef AE350_MAC_SUPPORT
input                                      T_col;
input                                      T_crs;
input                                      T_mdio;
input                                      T_phy_linksts;      // PHY Link status
input                                      T_rx_clk;
input                                      T_rx_dv;
input                                      T_rx_er;
input                                [3:0] T_rxd;
input                                      T_tx_clk;
output                              [31:0] mac_haddr;          // AHB master address bus
output                               [2:0] mac_hburst;         // AHB master burst type
output                               [3:0] mac_hprot;          // AHB master protection control
input                               [31:0] mac_hrdata;         // AHB master write data bus
input                                [1:0] mac_hresp;          // AHB master transfer response
output                               [2:0] mac_hsize;          // AHB master transfer size
output                               [1:0] mac_htrans;         // AHB master transfer type
output                              [31:0] mac_hwdata;         // AHB master write data bus
output                                     mac_hwrite;         // AHB master write
output                                     mdc;
output                                     mdio_out;
output                                     mdio_out_en;
output                                     pdn_phy;            // Power down phy
output                                     tx_en;
output                               [3:0] txd;
`endif // AE350_MAC_SUPPORT
`ifdef AE350_SMC_SUPPORT
   `ifdef ATFSMC020_SEPARATE_AHB
input                               [31:0] smc_mem_haddr;
input                                [2:0] smc_mem_hburst;
input                                      smc_mem_hready;
input                                [2:0] smc_mem_hsize;
input                                [1:0] smc_mem_htrans;
input                               [31:0] smc_mem_hwdata;
input                                      smc_mem_hwrite;
   `endif // ATFSMC020_SEPARATE_AHB
`endif // AE350_SMC_SUPPORT
`ifdef AE350_MAC_SUPPORT
   `ifdef ATFMAC100_SEPARATE_HREADY
input                                      mac_hreadyout;      // AHB slave transfer done input
   `endif // ATFMAC100_SEPARATE_HREADY
`endif // AE350_MAC_SUPPORT
input                                [3:0] hbmc_hprot;
output                               [1:0] hbmc_hresp;
input                         [ADDR_MSB:0] hbmc_haddr;
input                                [1:0] hbmc_htrans;        // AHB slave transfer type
input                                      hclk;               // AHB bus clock
input                                      hresetn;            // AHB asynchrous reset
input                               [31:0] hbmc_hwdata;        // AHB slave write data bus
input                                      hbmc_hwrite;        // AHB slave write
input                                [2:0] hbmc_hburst;        // AHB slave burst    type
input                                [2:0] hbmc_hsize;         // AHB slave transfer size
output                        [DATA_MSB:0] hbmc_hrdata;
input                                      hbmc_hready;
output                                     hbmc_hreadyout;
input                                      hbmc_hsel;
output                                     lcd_intr;
output                                     mac_int;

`ifdef AE350_SMC_SUPPORT
wire                                 [1:0] smc_ini_mbw; // dangler: () <= ()
wire                                       smc_vlio_rdy; // dangler: () <= ()
wire                                [31:0] ds2_hrdata;
wire                                       ds2_hreadyout;
wire                                 [1:0] ds2_hresp;
wire                                       smc_addr_r_dummy;
wire                                       ds2_hsel;
`endif // AE350_SMC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
wire                                       ds3_hsel;
wire                                [31:0] ds3_hrdata;
wire                                       ds3_hreadyout;
wire                                 [1:0] ds3_hresp;
`endif // AE350_LCDC_SUPPORT
`ifdef AE350_MAC_SUPPORT
wire                                       ds4_hsel;
wire                                [31:0] ds4_hrdata;
wire                                       ds4_hreadyout;
wire                                 [1:0] ds4_hresp;
`endif // AE350_MAC_SUPPORT
wire                                       ds_hready;
wire                                       hbmc_hresp_1bit; // dangler: () => ()

`ifdef AE350_MAC_SUPPORT
`else //~AE350_MAC_SUPPORT
assign mac_int = 1'b0;
`endif
`ifdef AE350_LCDC_SUPPORT
`else //~AE350_LCDC_SUPPORT
assign lcd_intr = 1'b0;
`endif
`ifdef AE350_SMC_SUPPORT
	`ifdef NDS_FPGA
assign smc_ini_mbw = 2'b01;  // 16-bit for FPGA ORCA board
	`else
assign smc_ini_mbw = 2'b10;  // 32-bit for Leopard SMC ROM simulation model compatable
	`endif
assign smc_vlio_rdy = 1'b1;
`endif //AE350_SMC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
assign lcdc_hwdata = 32'h0;
`endif
assign hbmc_hresp = {1'b0, hbmc_hresp_1bit};
`ifdef ATCBUSDEC200_SLV1_SUPPORT
	assign ahb2apb_haddr = hbmc_haddr[`ATCAPBBRG100_ADDR_MSB:0];
	assign ahb2apb_hprot = hbmc_hprot;
	assign ahb2apb_hready_in = ds_hready;
	assign ahb2apb_hsize = hbmc_hsize;
	assign ahb2apb_htrans = hbmc_htrans;
	assign ahb2apb_hwdata = hbmc_hwdata;
	assign ahb2apb_hwrite = hbmc_hwrite;
`endif // ATCBUSDEC200_SLV1_SUPPORT

atcbusdec200 #(
	.ADDR_WIDTH      (ADDR_MSB+1      )
) u_hbmc (
`ifdef ATCBUSDEC200_SLV1_SUPPORT
	.ds1_hsel      (ahb2apb_hsel        ), // (u_hbmc) => ()
	.ds1_hrdata    (ahb2apb_hrdata      ), // (u_hbmc) <= ()
	.ds1_hreadyout (ahb2apb_hready      ), // (u_hbmc) <= ()
	.ds1_hresp     (ahb2apb_hresp[0]    ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV1_SUPPORT
`ifdef ATCBUSDEC200_SLV2_SUPPORT
	.ds2_hsel      (ds2_hsel            ), // (u_hbmc) => (smcctrl)
	.ds2_hrdata    (ds2_hrdata          ), // (u_hbmc) <= (smcctrl)
	.ds2_hreadyout (ds2_hreadyout       ), // (u_hbmc) <= (smcctrl)
	.ds2_hresp     (ds2_hresp[0]        ), // (u_hbmc) <= (smcctrl)
`endif // ATCBUSDEC200_SLV2_SUPPORT
`ifdef ATCBUSDEC200_SLV3_SUPPORT
	.ds3_hsel      (ds3_hsel            ), // (u_hbmc) => (u_lcdc)
	.ds3_hrdata    (ds3_hrdata          ), // (u_hbmc) <= (u_lcdc)
	.ds3_hreadyout (ds3_hreadyout       ), // (u_hbmc) <= (u_lcdc)
	.ds3_hresp     (ds3_hresp[0]        ), // (u_hbmc) <= (u_lcdc)
`endif // ATCBUSDEC200_SLV3_SUPPORT
`ifdef ATCBUSDEC200_SLV4_SUPPORT
	.ds4_hsel      (ds4_hsel            ), // (u_hbmc) => (u_mac)
	.ds4_hrdata    (ds4_hrdata          ), // (u_hbmc) <= (u_mac)
	.ds4_hreadyout (ds4_hreadyout       ), // (u_hbmc) <= (u_mac)
	.ds4_hresp     (ds4_hresp[0]        ), // (u_hbmc) <= (u_mac)
`endif // ATCBUSDEC200_SLV4_SUPPORT
`ifdef ATCBUSDEC200_SLV5_SUPPORT
	.ds5_hsel      (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds5_hrdata    ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds5_hreadyout (1'b1                ), // (u_hbmc) <= ()
	.ds5_hresp     (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV5_SUPPORT
`ifdef ATCBUSDEC200_SLV6_SUPPORT
	.ds6_hsel      (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds6_hrdata    ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds6_hreadyout (1'b1                ), // (u_hbmc) <= ()
	.ds6_hresp     (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV6_SUPPORT
`ifdef ATCBUSDEC200_SLV7_SUPPORT
	.ds7_hsel      (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds7_hrdata    ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds7_hreadyout (1'b1                ), // (u_hbmc) <= ()
	.ds7_hresp     (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV7_SUPPORT
`ifdef ATCBUSDEC200_SLV8_SUPPORT
	.ds8_hsel      (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds8_hrdata    ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds8_hreadyout (1'b1                ), // (u_hbmc) <= ()
	.ds8_hresp     (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV8_SUPPORT
`ifdef ATCBUSDEC200_SLV9_SUPPORT
	.ds9_hsel      (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds9_hrdata    ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds9_hreadyout (1'b1                ), // (u_hbmc) <= ()
	.ds9_hresp     (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV9_SUPPORT
`ifdef ATCBUSDEC200_SLV10_SUPPORT
	.ds10_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds10_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds10_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds10_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV10_SUPPORT
`ifdef ATCBUSDEC200_SLV11_SUPPORT
	.ds11_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds11_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds11_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds11_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV11_SUPPORT
`ifdef ATCBUSDEC200_SLV12_SUPPORT
	.ds12_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds12_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds12_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds12_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV12_SUPPORT
`ifdef ATCBUSDEC200_SLV13_SUPPORT
	.ds13_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds13_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds13_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds13_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV13_SUPPORT
`ifdef ATCBUSDEC200_SLV14_SUPPORT
	.ds14_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds14_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds14_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds14_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV14_SUPPORT
`ifdef ATCBUSDEC200_SLV15_SUPPORT
	.ds15_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds15_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds15_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds15_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV15_SUPPORT
`ifdef ATCBUSDEC200_SLV16_SUPPORT
	.ds16_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds16_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds16_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds16_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV16_SUPPORT
`ifdef ATCBUSDEC200_SLV17_SUPPORT
	.ds17_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds17_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds17_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds17_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV17_SUPPORT
`ifdef ATCBUSDEC200_SLV18_SUPPORT
	.ds18_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds18_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds18_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds18_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV18_SUPPORT
`ifdef ATCBUSDEC200_SLV19_SUPPORT
	.ds19_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds19_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds19_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds19_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV19_SUPPORT
`ifdef ATCBUSDEC200_SLV20_SUPPORT
	.ds20_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds20_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds20_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds20_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV20_SUPPORT
`ifdef ATCBUSDEC200_SLV21_SUPPORT
	.ds21_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds21_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds21_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds21_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV21_SUPPORT
`ifdef ATCBUSDEC200_SLV22_SUPPORT
	.ds22_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds22_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds22_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds22_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV22_SUPPORT
`ifdef ATCBUSDEC200_SLV23_SUPPORT
	.ds23_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds23_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds23_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds23_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV23_SUPPORT
`ifdef ATCBUSDEC200_SLV24_SUPPORT
	.ds24_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds24_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds24_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds24_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV24_SUPPORT
`ifdef ATCBUSDEC200_SLV25_SUPPORT
	.ds25_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds25_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds25_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds25_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV25_SUPPORT
`ifdef ATCBUSDEC200_SLV26_SUPPORT
	.ds26_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds26_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds26_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds26_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV26_SUPPORT
`ifdef ATCBUSDEC200_SLV27_SUPPORT
	.ds27_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds27_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds27_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds27_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV27_SUPPORT
`ifdef ATCBUSDEC200_SLV28_SUPPORT
	.ds28_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds28_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds28_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds28_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV28_SUPPORT
`ifdef ATCBUSDEC200_SLV29_SUPPORT
	.ds29_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds29_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds29_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds29_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV29_SUPPORT
`ifdef ATCBUSDEC200_SLV30_SUPPORT
	.ds30_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds30_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds30_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds30_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV30_SUPPORT
`ifdef ATCBUSDEC200_SLV31_SUPPORT
	.ds31_hsel     (/* NC */            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.ds31_hrdata   ({(DATA_MSB+1){1'b0}}), // () <= ()
	.ds31_hreadyout(1'b1                ), // (u_hbmc) <= ()
	.ds31_hresp    (1'b0                ), // (u_hbmc) <= ()
`endif // ATCBUSDEC200_SLV31_SUPPORT
	.hclk          (hclk                ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.hresetn       (hresetn             ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.us_haddr      (hbmc_haddr          ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.us_hsel       (hbmc_hsel           ), // (u_hbmc) <= ()
	.us_htrans     (hbmc_htrans         ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.us_hrdata     (hbmc_hrdata         ), // (u_hbmc) => ()
	.us_hready     (hbmc_hready         ), // (u_hbmc) <= ()
	.us_hreadyout  (hbmc_hreadyout      ), // (u_hbmc) => ()
	.us_hresp      (hbmc_hresp_1bit     ), // (u_hbmc) => ()
	.ds_hready     (ds_hready           )  // (u_hbmc) => (smcctrl,u_lcdc,u_mac)
); // end of u_hbmc

`ifdef AE350_SMC_SUPPORT
atfsmc020 smcctrl (
	.HCLK            (hclk             ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.HRESETn         (hresetn          ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.endian          (1'b0             ), // (smcctrl) <= ()
	.hsel_reg        (ds2_hsel         ), // (smcctrl) <= (u_hbmc)
	.hsel_mem        (smc_mem_hsel     ), // (smcctrl) <= ()
   `ifdef ATFSMC020_SEPARATE_AHB
	.hready_reg_in   (ds_hready        ), // (smcctrl,u_lcdc,u_mac) <= (u_hbmc)
	.htrans_reg      (hbmc_htrans      ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.hburst_reg      (hbmc_hburst      ), // (smcctrl,u_mac) <= ()
	.hsize_reg       (hbmc_hsize       ), // (smcctrl,u_mac) <= ()
	.hwrite_reg      (hbmc_hwrite      ), // (smcctrl,u_lcdc,u_mac) <= ()
	.haddr_reg       (hbmc_haddr[31:0] ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.hwdata_reg      (hbmc_hwdata      ), // (smcctrl,u_lcdc,u_mac) <= ()
	.hready_mem_in   (smc_mem_hready   ), // (smcctrl) <= ()
	.htrans_mem      (smc_mem_htrans   ), // (smcctrl) <= ()
	.hburst_mem      (smc_mem_hburst   ), // (smcctrl) <= ()
	.hsize_mem       (smc_mem_hsize    ), // (smcctrl) <= ()
	.hwrite_mem      (smc_mem_hwrite   ), // (smcctrl) <= ()
	.haddr_mem       (smc_mem_haddr    ), // (smcctrl) <= ()
	.hwdata_mem      (smc_mem_hwdata   ), // (smcctrl) <= ()
   `else
	.hready_in       (1'b1             ), // (smcctrl) <= ()
	.htrans          (2'h0             ), // (smcctrl) <= ()
	.hburst          (3'h0             ), // (smcctrl) <= ()
	.hsize           (3'h0             ), // (smcctrl) <= ()
	.hwrite          (1'b0             ), // (smcctrl) <= ()
	.haddr           (32'h0            ), // (smcctrl) <= ()
	.hwdata          (32'h0            ), // (smcctrl) <= ()
   `endif // ATFSMC020_SEPARATE_AHB
	.ini_mbw         (smc_ini_mbw      ), // (smcctrl) <= ()
	.ebi_gnt_a       (1'b1             ), // (smcctrl) <= ()
	.smc_vlio_rdy    (smc_vlio_rdy     ), // (smcctrl) <= ()
	.smc_dqin_a      (T_memdata        ), // (smcctrl) <= ()
   `ifdef ATFSMC020_PARITY_FUNCTION
	.smc_parity_in_a (4'h0             ), // (smcctrl) <= ()
   `endif // ATFSMC020_PARITY_FUNCTION
	.hready_out_reg_r(ds2_hreadyout    ), // (smcctrl) => (u_hbmc)
	.hresp_reg_r     (ds2_hresp[1:0]   ), // (smcctrl) => (u_hbmc)
	.hrdata_reg_r    (ds2_hrdata       ), // (smcctrl) => (u_hbmc)
	.hready_out_mem_r(smc_mem_hreadyout), // (smcctrl) => ()
	.hresp_mem_r     (smc_mem_hresp    ), // (smcctrl) => ()
	.hrdata_mem_r    (smc_mem_hrdata   ), // (smcctrl) => ()
	.ebi_req_r       (/* NC */         ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.smc_adsc_r      (/* NC */         ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.smc_csb_r       (smc_cs_n         ), // (smcctrl) => ()
	.smc_web_r       (smc_we_n         ), // (smcctrl) => ()
	.smc_beb_r       (/* NC */         ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.smc_addr_r      ({smc_addr_r_dummy,smc_addr[24:0]}), // () => ()
	.smc_oeb_r       (smc_oe_n         ), // (smcctrl) => ()
   `ifdef ATFSMC020_PARITY_FUNCTION
	.smc_parity_out_r(/* NC */         ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
   `endif // ATFSMC020_PARITY_FUNCTION
	.smc_dqout_r     (smc_dqout        ), // (smcctrl) => ()
	.smc_data_oe_r   (smc_data_oe      )  // (smcctrl) => ()
); // end of smcctrl

`endif // AE350_SMC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
atflcdc100 u_lcdc (
	.HCLK          (hclk            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.LC_CLK        (lcd_clk         ), // (u_lcdc) <= ()
	.HRESETn       (hresetn         ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.LC_RSTn       (hresetn         ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.HSELS         (ds3_hsel        ), // (u_lcdc) <= (u_hbmc)
	.LC_CLKn       (lcd_clkn        ), // (u_lcdc) <= ()
	.HWRITES       (hbmc_hwrite     ), // (smcctrl,u_lcdc,u_mac) <= ()
	.HREADYSin     (ds_hready       ), // (smcctrl,u_lcdc,u_mac) <= (u_hbmc)
	.HREADYMin     (lcdc_hreadyout  ), // (u_lcdc) <= ()
	.HGRANTM       (1'b1            ), // (u_lcdc) <= ()
	.HTRANSS       (hbmc_htrans     ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.HRESPM        (lcdc_hresp      ), // (u_lcdc) <= ()
	.HADDRS        (hbmc_haddr[15:2]), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.HWDATAS       (hbmc_hwdata     ), // (smcctrl,u_lcdc,u_mac) <= ()
	.HRDATAM       (lcdc_hrdata     ), // (u_lcdc) <= ()
	.GPI           (lcd_gpo         ), // (u_lcdc) <= (u_lcdc)
	.HREADYSout    (ds3_hreadyout   ), // (u_lcdc) => (u_hbmc)
	.HWRITEM       (lcdc_hwrite     ), // (u_lcdc) => ()
	.HBUSREQM      (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.HLOCKM        (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.HRESPS        (ds3_hresp[1:0]  ), // (u_lcdc) => (u_hbmc)
	.HTRANSM       (lcdc_htrans     ), // (u_lcdc) => ()
	.HSIZEM        (lcdc_hsize      ), // (u_lcdc) => ()
	.HBURSTM       (lcdc_hburst     ), // (u_lcdc) => ()
	.HPROTM        (lcdc_hprot      ), // (u_lcdc) => ()
	.HADDRM        (lcdc_haddr      ), // (u_lcdc) => ()
	.HRDATAS       (ds3_hrdata      ), // (u_lcdc) => (u_hbmc)
	.LC_MERRINTR   (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.LC_FURINTR    (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.LC_BAUPDINTR  (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.LC_VSTATUSINTR(/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.LC_INTR       (lcd_intr        ), // (u_lcdc) => ()
	.LC_HS         (cllp            ), // (u_lcdc) => ()
	.LC_PCLK       (clcp            ), // (u_lcdc) => ()
	.LC_VS         (clfp            ), // (u_lcdc) => ()
	.LC_DE         (clac            ), // (u_lcdc) => ()
	.LC_LE         (clle            ), // (u_lcdc) => ()
	.LC_DATA       (cld             ), // (u_lcdc) => ()
	.GPO           (lcd_gpo         ), // (u_lcdc) => (u_lcdc)
   `ifdef ATFLCDC100_LCDDEBUG
	.lc_dbg        (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
   `endif // ATFLCDC100_LCDDEBUG
	.AP_VS         (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.AP_HS         (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.AP_DE         (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.AP_PCLK       (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.AP_DATA       (/* NC */        )  // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
); // end of u_lcdc

`endif // AE350_LCDC_SUPPORT
`ifdef AE350_MAC_SUPPORT
atfmac100 u_mac (
	.hclk         (hclk            ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.hresetn      (hresetn         ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.hbusreq      (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.hlock        (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.hgrant       (1'b1            ), // (u_mac) <= ()
	.hready_in    (ds_hready       ), // (smcctrl,u_lcdc,u_mac) <= (u_hbmc)
   `ifdef ATFMAC100_SEPARATE_HREADY
	.hready_mst_in(mac_hreadyout   ), // (u_mac) <= ()
   `endif // ATFMAC100_SEPARATE_HREADY
	.hresp_in     (mac_hresp       ), // (u_mac) <= ()
	.hrdata_in    (mac_hrdata      ), // (u_mac) <= ()
	.htrans_out   (mac_htrans      ), // (u_mac) => ()
	.hwrite_out   (mac_hwrite      ), // (u_mac) => ()
	.hsize_out    (mac_hsize       ), // (u_mac) => ()
	.hburst_out   (mac_hburst      ), // (u_mac) => ()
	.hprot        (mac_hprot       ), // (u_mac) => ()
	.haddr_out    (mac_haddr       ), // (u_mac) => ()
	.hwdata_out   (mac_hwdata      ), // (u_mac) => ()
	.hsel         (ds4_hsel        ), // (u_mac) <= (u_hbmc)
	.haddr_in     (hbmc_haddr[31:0]), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.hwrite_in    (hbmc_hwrite     ), // (smcctrl,u_lcdc,u_mac) <= ()
	.htrans_in    (hbmc_htrans     ), // (smcctrl,u_hbmc,u_lcdc,u_mac) <= ()
	.hsize_in     (hbmc_hsize      ), // (smcctrl,u_mac) <= ()
	.hburst_in    (hbmc_hburst     ), // (smcctrl,u_mac) <= ()
	.hwdata_in    (hbmc_hwdata     ), // (smcctrl,u_lcdc,u_mac) <= ()
	.hready_out   (ds4_hreadyout   ), // (u_mac) => (u_hbmc)
	.hresp_out    (ds4_hresp[1:0]  ), // (u_mac) => (u_hbmc)
	.hrdata_out   (ds4_hrdata      ), // (u_mac) => (u_hbmc)
	.ahb_edn      (1'b1            ), // (u_mac) <= ()
	.WOL          (/* NC */        ), // (smcctrl,u_hbmc,u_lcdc,u_mac) => ()
	.pdn_phy      (pdn_phy         ), // (u_mac) => ()
	.CRS          (T_crs           ), // (u_mac) <= ()
	.COL          (T_col           ), // (u_mac) <= ()
	.TX_CK        (T_tx_clk        ), // (u_mac) <= ()
	.TXD          (txd             ), // (u_mac) => ()
	.TX_EN        (tx_en           ), // (u_mac) => ()
	.RX_CK        (T_rx_clk        ), // (u_mac) <= ()
	.RXD          (T_rxd           ), // (u_mac) <= ()
	.RX_ER        (T_rx_er         ), // (u_mac) <= ()
	.RX_DV        (T_rx_dv         ), // (u_mac) <= ()
	.MDC          (mdc             ), // (u_mac) => ()
	.MDIO_out_en  (mdio_out_en     ), // (u_mac) => ()
	.MDIO_out     (mdio_out        ), // (u_mac) => ()
	.MDIO_in      (T_mdio          ), // (u_mac) <= ()
	.phy_linksts  (T_phy_linksts   ), // (u_mac) <= ()
	.mac_int      (mac_int         )  // (u_mac) => ()
); // end of u_mac

`endif // AE350_MAC_SUPPORT
endmodule
// VPERL_GENERATED_END
