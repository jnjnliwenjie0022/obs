`timescale 1ps/1ps

`include "config.inc"
`include "global.inc"

`include "ae350_config.vh"
`include "ae350_const.vh"

`ifdef NDS_IO_AHB
	`define AE350_AHB_SUPPORT
`else
	`define AE350_AXI_SUPPORT
`endif

// =====================
// configurable IP
// =====================
`include "atcgpio100_config.vh"
`include "atcgpio100_const.vh"
`include "atcpit100_config.vh"
`include "atcpit100_const.vh"
`include "atcwdt200_config.vh"
`include "atcwdt200_const.vh"
`include "atcrtc100_config.vh"
`include "atcrtc100_const.vh"

`ifdef AE350_AHB_MASTER_SUPPORT
	`include "atcmstmux100_config.vh"
	`include "atcmstmux100_const.vh"
`endif

`ifdef NDS_IO_L2C
	`ifdef NDS_IO_L2C_IO_COHERENCE
		`ifdef AE350_DMA_SUPPORT
			`define AE350_AXI_MASTER_SUPPORT
		`elsif AE350_AHB_MASTER_SUPPORT
			`define AE350_AXI_MASTER_SUPPORT
		`endif

		`ifdef AE350_AXI_MASTER_SUPPORT
			`include "atcmstmux300_config.vh"
			`include "atcmstmux300_const.vh"
		`endif // AE350_AXI_MASTER_SUPPORT
	`endif	// NDS_IO_L2C_IO_COHERENCE
`endif // NDS_IO_L2C

`ifdef AE350_SMC_SUPPORT
	`include "atfsmc020_config.vh"
	`include "atfsmc020_const.vh"
`endif

`ifdef  AE350_SSP_SUPPORT
	`include "atfssp020_config.vh"
	`include "atfssp020_const.vh"
`endif

`ifdef  AE350_LCDC_SUPPORT
	`include "atflcdc100_config.vh"
	`include "atflcdc100_const.vh"
`endif

`ifdef AE350_SPI1_SUPPORT
	`define _AE350_SPI_SUPPORT
`elsif AE350_SPI2_SUPPORT
	`define _AE350_SPI_SUPPORT
`elsif AE350_SPI3_SUPPORT
	`define _AE350_SPI_SUPPORT
`elsif AE350_SPI4_SUPPORT
	`define _AE350_SPI_SUPPORT
`endif

`ifdef _AE350_SPI_SUPPORT
	`include "atcspi200_config.vh"
	`include "atcspi200_const.vh"
	`undef _AE350_SPI_SUPPORT
`endif

`ifdef AE350_I2C_SUPPORT
	`define _AE350_I2C_SUPPORT
`elsif AE350_I2C2_SUPPORT
	`define _AE350_I2C_SUPPORT
`endif

`ifdef _AE350_I2C_SUPPORT
	`include "atciic100_config.vh"
	`include "atciic100_const.vh"
	`undef _AE350_I2C_SUPPORT
`endif

`ifdef AE350_UART1_SUPPORT
	`define _AE350_UART_SUPPORT
`endif
`ifdef AE350_UART2_SUPPORT
	`define _AE350_UART_SUPPORT
`endif

`ifdef _AE350_UART_SUPPORT
	`include "atcuart100_config.vh"
	`include "atcuart100_const.vh"
	`undef _AE350_UART_SUPPORT
`endif

`ifdef AE350_AXI_SUPPORT
	`include "atcbmc300_config.vh"
	`include "atcbmc300_const.vh"
`else
	`include "atcbmc200_config.vh"
	`include "atcbmc200_const.vh"
`endif

`include "atcbusdec200_config.vh"
`include "atcbusdec200_const.vh"
`include "atcapbbrg100_config.vh"
`include "atcapbbrg100_const.vh"

`ifdef AE350_SPI1_SUPPORT
	`ifdef AE350_SMC_SUPPORT
	`include "atcbusdec200_rom_config.vh"
	`include "atcbusdec200_rom_const.vh"
	`endif
`endif

`ifdef AE350_DMA_SUPPORT
	`ifdef AE350_AXI_SUPPORT
		`define AE350_DMA_AXI_SUPPORT
		`include "atcdmac300_config.vh"
		`include "atcdmac300_const.vh"
	`else
		`define AE350_DMA_AHB_SUPPORT
		`include "atcdmac110_config.vh"
		`include "atcdmac110_const.vh"
	`endif // AE350_AXI_SUPPORT
`endif

`ifdef AE350_MAC_SUPPORT
	`include "atfmac100_config.vh"
	`include "atfmac100_const.vh"
`endif // AE350_MAC_SUPPORT

`ifdef AE350_SDC_SUPPORT
	`include "atfsdc010_config.vh"
	`include "atfsdc010_const.vh"
`endif // AE350_SDC_SUPPORT

// VPERL_BEGIN
// &MODULE("ae350_chip");
//
// push(@INC, "$PVC_LOCALDIR/andes_ip/ae350/top/hdl");
// require "ae350_params.pm";
//
// &PARAM("SIMULATION = \"FALSE\" ");
// &PARAM("SIM_BYPASS_INIT_CAL = \"OFF\" ");
//
// &IFDEF("NDS_IO_L2C"); # reserve this for package preconfig
//   &IFDEF("AE350_AXI_MASTER_SUPPORT");
//     &LOCALPARAM("ATCMSTMUX300_ADDR_WIDTH = `ATCMSTMUX300_ADDR_WIDTH");
//   &ENDIF("AE350_AXI_MASTER_SUPPORT");
// &ENDIF("NDS_IO_L2C");

//&IFDEF("NDS_ASP_DATA_WIDTH");
//&LOCALPARAM("ASP_DATA_WIDTH		= `NDS_ASP_DATA_WIDTH");
//&LOCALPARAM("ASP_BWE_WIDTH  = ASP_DATA_WIDTH/8");
//&ENDIF("NDS_ASP_DATA_WIDTH");
//
// &IFDEF("ATCAPBBRG100_SLV_14");
//   &IFDEF("AE350_DTROM_SIZE_KB");
//     &LOCALPARAM("DTROM_SIZE_KB = `AE350_DTROM_SIZE_KB");
//   &ELSE("AE350_DTROM_SIZE_KB");
//     &LOCALPARAM("DTROM_SIZE_KB = 8");
//   &ENDIF("AE350_DTROM_SIZE_KB");
// &ENDIF("ATCAPBBRG100_SLV_14");
//
// &IFDEF("PLATFORM_JTAG_TWOWIRE");
//      &LOCALPARAM("DEBUG_INTERFACE        = \"serial\"");
// &ELSE("PLATFORM_JTAG_TWOWIRE");
//      &LOCALPARAM("DEBUG_INTERFACE        = \"jtag\"");
// &ENDIF("PLATFORM_JTAG_TWOWIRE");
// &IFDEF("PLATFORM_JTAG_TAP_NUM");
//      &LOCALPARAM("JTAG_TAP_NUM           = `PLATFORM_JTAG_TAP_NUM");
// &ELSE ("PLATFORM_JTAG_TAP_NUM");
//      &LOCALPARAM("JTAG_TAP_NUM           = 1");
// &ENDIF("PLATFORM_JTAG_TAP_NUM");
// &IFDEF("PLATFORM_DM_TAP_ID");
//      &LOCALPARAM("DM_TAP_ID              = `PLATFORM_DM_TAP_ID");
// &ELSE ("PLATFORM_DM_TAP_ID");
//      &LOCALPARAM("DM_TAP_ID              = 0");
// &ENDIF("PLATFORM_DM_TAP_ID");
//
// #    NDS_MULTI_JTAG_DEVICE connects a N8 core to TAP#1
// #    To enable this feature, user should
// #            - Check file lists (especially for RAMs)
// #            - Make sure PLATFORM_JTAG_TAP_NUM ls larger than 2
// #            - Make sure JTAG_DEVICE_TAP_ID != DM_TAP_ID
// #            - Only support EILM/EDLM for FPGA in n8_core_top_N8
// #            - To change JTAG_DEVICE_TAP_ID, it should also be set to ae350_tb
// &IFDEF("NDS_MULTI_JTAG_DEVICE");
//      &LOCALPARAM("JTAG_DEVICE_TAP_ID     = 1");
// &ENDIF("NDS_MULTI_JTAG_DEVICE");
//
// #-----------------------------------------------------------------------------
// # BUS matrix configuration
// #-----------------------------------------------------------------------------
// $AXI_MST_CPU0		= 0;
// $AXI_MST_CPU0_X2_I		= 1;
// $AXI_MST_CPU0_X2_D		= 2;
// $AXI_MST_DMAC0		= 3;
// $AXI_MST_DMAC1		= 4;
// $AXI_MST_MSTMUX              = 5;
// $AXI_MST_ACE			= 6;	# not be used now
// $AXI_MST_DEBUG		= 7;
//
// $AXI_SLV_AHBDEC		= 1;
// $AXI_SLV_RAM			= 2;
// $AXI_SLV_DLM_SLAVE_PORT	= 3;
// $AXI_SLV_SPI_MEM		= 4;
// $AXI_SLV_AHB_DEV		= 4;
// $AXI_SLV_L2_M4		= 6;
//
// $AHB_MST_CPU0		= 0;
// $AHB_MST_DMA			= 1;
// $AHB_MST_MAC			= 2;
// $AHB_MST_CPU1		= 3;
// $AHB_MST_CPU2		= 4;
// $AHB_MST_CPU3		= 5;
// $AHB_MST_CPU4		= 6;
// $AHB_MST_CPU5		= 7;
// $AHB_MST_CPU6		= 8;
// $AHB_MST_CPU7		= 9;
// $AHB_MST_LCDC		= 10;
// $AHB_MST_DEBUG		= 11;
// $AHB_MST_MAX			= $AHB_MST_DEBUG;

// #------ Be configurable ------#
// &FORCE("wire", "spi1_int");
// &FORCE("wire", "spi2_int");
// &FORCE("wire", "uart1_int");
// &FORCE("wire", "uart2_int");
// &FORCE("wire", "i2c_int");
// &FORCE("wire", "mac_int");
// &FORCE("wire", "lcd_intr");
// &FORCE("wire","dma_int");
//
// ###### MARK: Instance SYSTEM BUS ######
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_bus_connector.v", "ae350_bus_connector");
//
// &FORCE("wire", "dmac0_araddr_bus" );
// &FORCE("wire", "dmac0_arburst_bus");
// &FORCE("wire", "dmac0_arcache_bus");
// &FORCE("wire", "dmac0_arid_bus"   );
// &FORCE("wire", "dmac0_arlen_bus"  );
// &FORCE("wire", "dmac0_arlock_bus" );
// &FORCE("wire", "dmac0_arprot_bus" );
// &FORCE("wire", "dmac0_arready_bus");
// &FORCE("wire", "dmac0_arsize_bus" );
// &FORCE("wire", "dmac0_arvalid_bus");
//
// &FORCE("wire", "dmac0_awaddr_bus" );
// &FORCE("wire", "dmac0_awburst_bus");
// &FORCE("wire", "dmac0_awcache_bus");
// &FORCE("wire", "dmac0_awid_bus"   );
// &FORCE("wire", "dmac0_awlen_bus"  );
// &FORCE("wire", "dmac0_awlock_bus" );
// &FORCE("wire", "dmac0_awprot_bus" );
// &FORCE("wire", "dmac0_awready_bus");
// &FORCE("wire", "dmac0_awsize_bus" );
// &FORCE("wire", "dmac0_awvalid_bus");
//
// &FORCE("wire", "dmac0_bid_bus"    );
// &FORCE("wire", "dmac0_bready_bus" );
// &FORCE("wire", "dmac0_bresp_bus"  );
// &FORCE("wire", "dmac0_bvalid_bus" );
//
// &FORCE("wire", "dmac0_rdata_bus"  );
// &FORCE("wire", "dmac0_rid_bus"    );
// &FORCE("wire", "dmac0_rlast_bus"  );
// &FORCE("wire", "dmac0_rready_bus" );
// &FORCE("wire", "dmac0_rresp_bus"  );
// &FORCE("wire", "dmac0_rvalid_bus" );
//
// &FORCE("wire", "dmac0_wdata_bus"  );
// &FORCE("wire", "dmac0_wlast_bus"  );
// &FORCE("wire", "dmac0_wready_bus" );
// &FORCE("wire", "dmac0_wstrb_bus"  );
// &FORCE("wire", "dmac0_wvalid_bus" );
//
// &CONNECT("ae350_bus_connector.dmac0_araddr",         "dmac0_araddr_bus" );
// &CONNECT("ae350_bus_connector.dmac0_arburst",        "dmac0_arburst_bus");
// &CONNECT("ae350_bus_connector.dmac0_arcache",        "dmac0_arcache_bus");
// &CONNECT("ae350_bus_connector.dmac0_arid",           "dmac0_arid_bus"   );
// &CONNECT("ae350_bus_connector.dmac0_arlen",          "dmac0_arlen_bus"  );
// &CONNECT("ae350_bus_connector.dmac0_arlock",         "dmac0_arlock_bus" );
// &CONNECT("ae350_bus_connector.dmac0_arprot",         "dmac0_arprot_bus" );
// &CONNECT("ae350_bus_connector.dmac0_arready",        "dmac0_arready_bus");
// &CONNECT("ae350_bus_connector.dmac0_arsize",         "dmac0_arsize_bus" );
// &CONNECT("ae350_bus_connector.dmac0_arvalid",        "dmac0_arvalid_bus");
//
// &CONNECT("ae350_bus_connector.dmac0_awaddr",         "dmac0_awaddr_bus" );
// &CONNECT("ae350_bus_connector.dmac0_awburst",        "dmac0_awburst_bus");
// &CONNECT("ae350_bus_connector.dmac0_awcache",        "dmac0_awcache_bus");
// &CONNECT("ae350_bus_connector.dmac0_awid",           "dmac0_awid_bus"   );
// &CONNECT("ae350_bus_connector.dmac0_awlen",          "dmac0_awlen_bus"  );
// &CONNECT("ae350_bus_connector.dmac0_awlock",         "dmac0_awlock_bus" );
// &CONNECT("ae350_bus_connector.dmac0_awprot",         "dmac0_awprot_bus" );
// &CONNECT("ae350_bus_connector.dmac0_awready",        "dmac0_awready_bus");
// &CONNECT("ae350_bus_connector.dmac0_awsize",         "dmac0_awsize_bus" );
// &CONNECT("ae350_bus_connector.dmac0_awvalid",        "dmac0_awvalid_bus");
//
// &CONNECT("ae350_bus_connector.dmac0_bid",            "dmac0_bid_bus"    );
// &CONNECT("ae350_bus_connector.dmac0_bready",         "dmac0_bready_bus" );
// &CONNECT("ae350_bus_connector.dmac0_bresp",          "dmac0_bresp_bus"  );
// &CONNECT("ae350_bus_connector.dmac0_bvalid",         "dmac0_bvalid_bus" );
//
// &CONNECT("ae350_bus_connector.dmac0_rdata",          "dmac0_rdata_bus"  );
// &CONNECT("ae350_bus_connector.dmac0_rid",            "dmac0_rid_bus"    );
// &CONNECT("ae350_bus_connector.dmac0_rlast",          "dmac0_rlast_bus"  );
// &CONNECT("ae350_bus_connector.dmac0_rready",         "dmac0_rready_bus" );
// &CONNECT("ae350_bus_connector.dmac0_rresp",          "dmac0_rresp_bus"  );
// &CONNECT("ae350_bus_connector.dmac0_rvalid",         "dmac0_rvalid_bus" );
//
// &CONNECT("ae350_bus_connector.dmac0_wdata",          "dmac0_wdata_bus"  );
// &CONNECT("ae350_bus_connector.dmac0_wlast",          "dmac0_wlast_bus"  );
// &CONNECT("ae350_bus_connector.dmac0_wready",         "dmac0_wready_bus" );
// &CONNECT("ae350_bus_connector.dmac0_wstrb",          "dmac0_wstrb_bus"  );
// &CONNECT("ae350_bus_connector.dmac0_wvalid",         "dmac0_wvalid_bus" );
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_ahb_subsystem.v", "ae350_ahb_subsystem" ,{
//      ADDR_MSB                =>      "ADDR_MSB"
// });
// &CONNECT("ae350_ahb_subsystem.smc_mem_hresp"		, "smc_mem_hresp[1:0]"	);
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_apb_subsystem.v", "ae350_apb_subsystem", {
// 	BUS_MASTER_ADDR_WIDTH	=>	"ADDR_WIDTH",
// 	DMAC_DATA_WIDTH		=>	"DMAC_DATA_WIDTH_FIX",
// 	DMAC_ID_WIDTH		=>	"DMAC_ID_WIDTH",
// });
//
// &FORCE("wire", "dmac0_araddr_apb" );
// &FORCE("wire", "dmac0_arburst_apb");
// &FORCE("wire", "dmac0_arcache_apb");
// &FORCE("wire", "dmac0_arid_apb"   );
// &FORCE("wire", "dmac0_arlen_apb"  );
// &FORCE("wire", "dmac0_arlock_apb" );
// &FORCE("wire", "dmac0_arprot_apb" );
// &FORCE("wire", "dmac0_arready_apb");
// &FORCE("wire", "dmac0_arsize_apb" );
// &FORCE("wire", "dmac0_arvalid_apb");
//
// &FORCE("wire", "dmac0_awaddr_apb" );
// &FORCE("wire", "dmac0_awburst_apb");
// &FORCE("wire", "dmac0_awcache_apb");
// &FORCE("wire", "dmac0_awid_apb"   );
// &FORCE("wire", "dmac0_awlen_apb"  );
// &FORCE("wire", "dmac0_awlock_apb" );
// &FORCE("wire", "dmac0_awprot_apb" );
// &FORCE("wire", "dmac0_awready_apb");
// &FORCE("wire", "dmac0_awsize_apb" );
// &FORCE("wire", "dmac0_awvalid_apb");
//
// &FORCE("wire", "dmac0_bid_apb"    );
// &FORCE("wire", "dmac0_bready_apb" );
// &FORCE("wire", "dmac0_bresp_apb"  );
// &FORCE("wire", "dmac0_bvalid_apb" );
//
// &FORCE("wire", "dmac0_rdata_apb"  );
// &FORCE("wire", "dmac0_rid_apb"    );
// &FORCE("wire", "dmac0_rlast_apb"  );
// &FORCE("wire", "dmac0_rready_apb" );
// &FORCE("wire", "dmac0_rresp_apb"  );
// &FORCE("wire", "dmac0_rvalid_apb" );
//
// &FORCE("wire", "dmac0_wdata_apb"  );
// &FORCE("wire", "dmac0_wlast_apb"  );
// &FORCE("wire", "dmac0_wready_apb" );
// &FORCE("wire", "dmac0_wstrb_apb"  );
// &FORCE("wire", "dmac0_wvalid_apb" );
//
// &CONNECT("ae350_apb_subsystem.dmac0_araddr",         "dmac0_araddr_apb" );
// &CONNECT("ae350_apb_subsystem.dmac0_arburst",        "dmac0_arburst_apb");
// &CONNECT("ae350_apb_subsystem.dmac0_arcache",        "dmac0_arcache_apb");
// &CONNECT("ae350_apb_subsystem.dmac0_arid",           "dmac0_arid_apb"   );
// &CONNECT("ae350_apb_subsystem.dmac0_arlen",          "dmac0_arlen_apb"  );
// &CONNECT("ae350_apb_subsystem.dmac0_arlock",         "dmac0_arlock_apb" );
// &CONNECT("ae350_apb_subsystem.dmac0_arprot",         "dmac0_arprot_apb" );
// &CONNECT("ae350_apb_subsystem.dmac0_arready",        "dmac0_arready_apb");
// &CONNECT("ae350_apb_subsystem.dmac0_arsize",         "dmac0_arsize_apb" );
// &CONNECT("ae350_apb_subsystem.dmac0_arvalid",        "dmac0_arvalid_apb");
//
// &CONNECT("ae350_apb_subsystem.dmac0_awaddr",         "dmac0_awaddr_apb" );
// &CONNECT("ae350_apb_subsystem.dmac0_awburst",        "dmac0_awburst_apb");
// &CONNECT("ae350_apb_subsystem.dmac0_awcache",        "dmac0_awcache_apb");
// &CONNECT("ae350_apb_subsystem.dmac0_awid",           "dmac0_awid_apb"   );
// &CONNECT("ae350_apb_subsystem.dmac0_awlen",          "dmac0_awlen_apb"  );
// &CONNECT("ae350_apb_subsystem.dmac0_awlock",         "dmac0_awlock_apb" );
// &CONNECT("ae350_apb_subsystem.dmac0_awprot",         "dmac0_awprot_apb" );
// &CONNECT("ae350_apb_subsystem.dmac0_awready",        "dmac0_awready_apb");
// &CONNECT("ae350_apb_subsystem.dmac0_awsize",         "dmac0_awsize_apb" );
// &CONNECT("ae350_apb_subsystem.dmac0_awvalid",        "dmac0_awvalid_apb");
//
// &CONNECT("ae350_apb_subsystem.dmac0_bid",            "dmac0_bid_apb"    );
// &CONNECT("ae350_apb_subsystem.dmac0_bready",         "dmac0_bready_apb" );
// &CONNECT("ae350_apb_subsystem.dmac0_bresp",          "dmac0_bresp_apb"  );
// &CONNECT("ae350_apb_subsystem.dmac0_bvalid",         "dmac0_bvalid_apb" );
//
// &CONNECT("ae350_apb_subsystem.dmac0_rdata",          "dmac0_rdata_apb"  );
// &CONNECT("ae350_apb_subsystem.dmac0_rid",            "dmac0_rid_apb"    );
// &CONNECT("ae350_apb_subsystem.dmac0_rlast",          "dmac0_rlast_apb"  );
// &CONNECT("ae350_apb_subsystem.dmac0_rready",         "dmac0_rready_apb" );
// &CONNECT("ae350_apb_subsystem.dmac0_rresp",          "dmac0_rresp_apb"  );
// &CONNECT("ae350_apb_subsystem.dmac0_rvalid",         "dmac0_rvalid_apb" );
//
// &CONNECT("ae350_apb_subsystem.dmac0_wdata",          "dmac0_wdata_apb"  );
// &CONNECT("ae350_apb_subsystem.dmac0_wlast",          "dmac0_wlast_apb"  );
// &CONNECT("ae350_apb_subsystem.dmac0_wready",         "dmac0_wready_apb" );
// &CONNECT("ae350_apb_subsystem.dmac0_wstrb",          "dmac0_wstrb_apb"  );
// &CONNECT("ae350_apb_subsystem.dmac0_wvalid",         "dmac0_wvalid_apb" );
// 
// &LOCALPARAM("DMAC_DATA_WIDTH_FIX = (DMAC_DATA_WIDTH == 512) ? 256 : DMAC_DATA_WIDTH");
// :localparam DMA_SIZEUP_ADDR_WIDTH = $clog2(CPUSUB_BIU_DATA_WIDTH) -3;
// :localparam DMA_SIZEUP_ADDR_MSB   = DMA_SIZEUP_ADDR_WIDTH -1;
// :`ifdef AE350_AXI_SUPPORT
// :`ifdef AE350_DMA_AXI_SUPPORT
// :     generate
// :     if (CPUSUB_BIU_DATA_WIDTH == 512) begin: dma_sizeup_for_512_sup
// :            atcsizeup300#(
// :                    .ID_WIDTH       (CPUSUB_BIU_ID_WIDTH),
// :                    .US_DATA_WIDTH  (DMAC_DATA_WIDTH_FIX),
// :                    .DS_DATA_WIDTH  (CPUSUB_BIU_DATA_WIDTH)
// :            ) sizeup_dma_axibus (
// :                    .aclk           (aclk                   ),
// :                    .aresetn        (aresetn                ),
// :                    .us_arid        (dmac0_arid_apb         ),
// :                    .us_araddr      (dmac0_araddr_apb[DMA_SIZEUP_ADDR_MSB:0]),
// :                    .us_arburst     (dmac0_arburst_apb      ),
// :                    .us_arlen       (dmac0_arlen_apb        ),
// :                    .us_arsize      (dmac0_arsize_apb       ),
// :                    .us_arvalid     (dmac0_arvalid_apb      ),
// :                    .us_arready     (dmac0_arready_apb      ),
// :                    .ds_arvalid     (dmac0_arvalid_bus      ),
// :                    .ds_arready     (dmac0_arready_bus      ),
// :                    .us_awid        (dmac0_awid_apb         ),
// :                    .us_awaddr      (dmac0_awaddr_apb[DMA_SIZEUP_ADDR_MSB:0]),
// :                    .us_awburst     (dmac0_awburst_apb      ),
// :                    .us_awlen       (dmac0_awlen_apb        ),
// :                    .us_awsize      (dmac0_awsize_apb       ),
// :                    .us_awvalid     (dmac0_awvalid_apb      ),
// :                    .us_awready     (dmac0_awready_apb      ),
// :                    .ds_awvalid     (dmac0_awvalid_bus      ),
// :                    .ds_awready     (dmac0_awready_bus      ),
// :                    .us_rid         (dmac0_rid_apb          ),
// :                    .us_rdata       (dmac0_rdata_apb        ),
// :                    .us_rlast       (dmac0_rlast_apb        ),
// :                    .us_rresp       (dmac0_rresp_apb        ),
// :                    .us_rvalid      (dmac0_rvalid_apb       ),
// :                    .us_rready      (dmac0_rready_apb       ),
// :                    .ds_rlast       (dmac0_rlast_bus        ),
// :                    .ds_rdata       (dmac0_rdata_bus        ),
// :                    .ds_rresp       (dmac0_rresp_bus        ),
// :                    .ds_rvalid      (dmac0_rvalid_bus       ),
// :                    .ds_rready      (dmac0_rready_bus       ),
// :                    .us_wstrb       (dmac0_wstrb_apb        ),
// :                    .us_wlast       (dmac0_wlast_apb        ),
// :                    .us_wdata       (dmac0_wdata_apb        ),
// :                    .us_wvalid      (dmac0_wvalid_apb       ),
// :                    .us_wready      (dmac0_wready_apb       ),
// :                    .ds_wstrb       (dmac0_wstrb_bus        ),
// :                    .ds_wdata       (dmac0_wdata_bus        ),
// :                    .ds_wlast       (dmac0_wlast_bus        ),
// :                    .ds_wvalid      (dmac0_wvalid_bus       ),
// :                    .ds_wready      (dmac0_wready_bus       ),
// :                    .us_bid         (dmac0_bid_apb          ),
// :                    .us_bvalid      (dmac0_bvalid_apb       ),
// :                    .us_bready      (dmac0_bready_apb       ),
// :                    .ds_bvalid      (dmac0_bvalid_bus       ),
// :                    .ds_bready      (dmac0_bready_bus       )
// :            );
// :
// :             assign dmac0_araddr_bus  = dmac0_araddr_apb;
// :             assign dmac0_arburst_bus = dmac0_arburst_apb;
// :             assign dmac0_arcache_bus = dmac0_arcache_apb;
// :             assign dmac0_arid_bus    = dmac0_arid_apb;
// :             assign dmac0_arlen_bus   = dmac0_arlen_apb;
// :             assign dmac0_arlock_bus  = dmac0_arlock_apb;
// :             assign dmac0_arprot_bus  = dmac0_arprot_apb;
// :             assign dmac0_arsize_bus  = dmac0_arsize_apb;
// :
// :             assign dmac0_awaddr_bus  = dmac0_awaddr_apb;
// :             assign dmac0_awburst_bus = dmac0_awburst_apb;
// :             assign dmac0_awcache_bus = dmac0_awcache_apb;
// :             assign dmac0_awid_bus    = dmac0_awid_apb;
// :             assign dmac0_awlen_bus   = dmac0_awlen_apb;
// :             assign dmac0_awlock_bus  = dmac0_awlock_apb;
// :             assign dmac0_awprot_bus  = dmac0_awprot_apb;
// :             assign dmac0_awsize_bus  = dmac0_awsize_apb;
// :
// :             assign dmac0_bresp_apb   = dmac0_bresp_bus;
// :
// :     end
// :     else begin: dma_connection
// :             assign dmac0_araddr_bus  = dmac0_araddr_apb;
// :             assign dmac0_arburst_bus = dmac0_arburst_apb;
// :             assign dmac0_arcache_bus = dmac0_arcache_apb;
// :             assign dmac0_arid_bus    = dmac0_arid_apb;
// :             assign dmac0_arlen_bus   = dmac0_arlen_apb;
// :             assign dmac0_arlock_bus  = dmac0_arlock_apb;
// :             assign dmac0_arprot_bus  = dmac0_arprot_apb;
// :             assign dmac0_arsize_bus  = dmac0_arsize_apb;
// :             assign dmac0_arvalid_bus = dmac0_arvalid_apb;
// :
// :             assign dmac0_arready_apb = dmac0_arready_bus;
// :
// :             assign dmac0_awaddr_bus  = dmac0_awaddr_apb;
// :             assign dmac0_awburst_bus = dmac0_awburst_apb;
// :             assign dmac0_awcache_bus = dmac0_awcache_apb;
// :             assign dmac0_awid_bus    = dmac0_awid_apb;
// :             assign dmac0_awlen_bus   = dmac0_awlen_apb;
// :             assign dmac0_awlock_bus  = dmac0_awlock_apb;
// :             assign dmac0_awprot_bus  = dmac0_awprot_apb;
// :             assign dmac0_awsize_bus  = dmac0_awsize_apb;
// :             assign dmac0_awvalid_bus = dmac0_awvalid_apb;
// :
// :             assign dmac0_awready_apb = dmac0_awready_bus;
// :
// :             assign dmac0_bid_apb     = dmac0_bid_bus;
// :             assign dmac0_bresp_apb   = dmac0_bresp_bus;
// :             assign dmac0_bvalid_apb  = dmac0_bvalid_bus;
// :
// :             assign dmac0_bready_bus  = dmac0_bready_apb;
// :
// :             assign dmac0_rdata_apb   = dmac0_rdata_bus;
// :             assign dmac0_rid_apb     = dmac0_rid_bus;
// :             assign dmac0_rlast_apb   = dmac0_rlast_bus;
// :             assign dmac0_rresp_apb   = dmac0_rresp_bus;
// :             assign dmac0_rvalid_apb  = dmac0_rvalid_bus;
// :
// :             assign dmac0_rready_bus  = dmac0_rready_apb;
// :
// :             assign dmac0_wdata_bus   = dmac0_wdata_apb;
// :             assign dmac0_wlast_bus   = dmac0_wlast_apb;
// :             assign dmac0_wstrb_bus   = dmac0_wstrb_apb;
// :             assign dmac0_wvalid_bus  = dmac0_wvalid_apb;
// :
// :             assign dmac0_wready_apb  = dmac0_wready_bus;
// :    end
// :    endgenerate
// :
// :`endif // AE350_DMA_AXI_SUPPORT
// :`endif // AE350_AXI_SUPPORT
//
// #==================
// # AXI Masters
// #==================
// $m 	= $AXI_MST_CPU0;
// $hs 	= $AXI_SLV_DLM_SLAVE_PORT;
// $l2_m4 = $AXI_SLV_L2_M4;
// $dm  = $AXI_MST_DEBUG;
// &IFDEF("NDS_NHART");
//   &IFDEF("NDS_IO_L2C");
//     &IFDEF("NDS_IO_L2C_IO_SLV");
//       &FORCE("wire", "l2c_io_araddr[ADDR_MSB:0]");
//       &FORCE("wire", "l2c_io_awaddr[ADDR_MSB:0]");
//     &ENDIF("NDS_IO_L2C_IO_SLV");
//   &ENDIF("NDS_IO_L2C");
// &ENDIF("NDS_NHART");
// &DANGLER("l2c_io_arburst");
// &DANGLER("l2c_io_arcache");
// &DANGLER("l2c_io_arid");
// &DANGLER("l2c_io_arlen");
// &DANGLER("l2c_io_arlock");
// &DANGLER("l2c_io_arprot");
// &DANGLER("l2c_io_arready");
// &DANGLER("l2c_io_arsize");
// &DANGLER("l2c_io_arvalid");
// &DANGLER("l2c_io_awburst");
// &DANGLER("l2c_io_awcache");
// &DANGLER("l2c_io_awid");
// &DANGLER("l2c_io_awlen");
// &DANGLER("l2c_io_awlock");
// &DANGLER("l2c_io_awprot");
// &DANGLER("l2c_io_awready");
// &DANGLER("l2c_io_awsize");
// &DANGLER("l2c_io_awvalid");
// &DANGLER("l2c_io_bid");
// &DANGLER("l2c_io_bready");
// &DANGLER("l2c_io_bresp");
// &DANGLER("l2c_io_bvalid");
// &DANGLER("l2c_io_rdata");
// &DANGLER("l2c_io_rid");
// &DANGLER("l2c_io_rlast");
// &DANGLER("l2c_io_rready");
// &DANGLER("l2c_io_rresp");
// &DANGLER("l2c_io_rvalid");
// &DANGLER("l2c_io_wdata");
// &DANGLER("l2c_io_wlast");
// &DANGLER("l2c_io_wready");
// &DANGLER("l2c_io_wstrb");
// &DANGLER("l2c_io_wvalid");
//
// :`ifdef NDS_NHART
// :   `ifdef NDS_IO_L2C_IO_SLV
// :assign l2c_io_arready = 1'b0;
// :assign l2c_io_awready = 1'b0;
// :assign l2c_io_bid = {CPUSUB_BIU_ID_WIDTH{1'b0}};
// :assign l2c_io_bresp = 2'b0;
// :assign l2c_io_bvalid = 1'b0;
// :assign l2c_io_rdata = {CPUSUB_BIU_DATA_WIDTH{1'b0}};
// :assign l2c_io_rid = {CPUSUB_BIU_ID_WIDTH{1'b0}};
// :assign l2c_io_rlast = 1'b0;
// :assign l2c_io_rresp = 2'd0;
// :assign l2c_io_rvalid = 1'b0;
// :assign l2c_io_wready = 1'b0;
// :   `endif	// !NDS_IO_L2C_IO_SLV
// :`endif	// !NDS_NHART
//
// &FORCE("wire", "ahb2core_clken");
//
// &FORCE("wire", "core_reset_vectors[255:0]");
//
// &IFDEF("NDS_NHART");
// &ELSE("NDS_NHART");
// &IFDEF("NDS_IO_ACE_VPU");
// &IFDEF("NDS_CUSTOM_ACE_VPU");
// &FORCE("wire", "cp_cpu_rdata");
// &FORCE("wire", "cp_cpu_rdata_ready");
// &FORCE("wire", "cp_cpu_rdata_valid");
// &FORCE("wire", "cpu_cp_wdata");
// &FORCE("wire", "cpu_cp_wdata_bwe");
// &FORCE("wire", "cpu_cp_wdata_ready");
// &FORCE("wire", "cpu_cp_wdata_valid");
// &ENDIF("NDS_CUSTOM_ACE_VPU");
// &ENDIF("NDS_IO_ACE_VPU");
// &ENDIF("NDS_NHART");
//
// :`ifdef NDS_GATESIM
// :	`ifdef NDS_NHART
// :	`else
// :		`ifdef NDS_IO_ACE_VPU
// :			`ifdef NDS_CUSTOM_ACE_VPU
// :				assign cp_cpu_rdata = {ASP_DATA_WIDTH{1'b0}};
// :				assign cp_cpu_rdata_valid = 1'b0;
// :				assign cpu_cp_wdata_ready = 1'b0;
// :			`endif // NDS_CUSTOM_ACE_VPU
// :		`endif // NDS_IO_ACE_VPU
// :	`endif // NDS_NHART
// :`endif // NDS_GATESIM
// 
// &FORCE("wire", "core_clk[(NHART-1):0]");
// &FORCE("wire", "te_clk[(NHART-1):0]");
//
// &IFDEF("NDS_BOARD_CF1");
//   &LOCALPARAM("INT_NUM                  = 32");
// &ELSE("NDS_BOARD_CF1");
//   &LOCALPARAM("INT_NUM                  = 31");
// &ENDIF("NDS_BOARD_CF1");
// &FORCE("wire", "int_src[INT_NUM-1:0]");
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_cpu_subsystem_stub.v", "ae350_cpu_subsystem");
//
// sub IFDEF_HART {
//         my ($hart, @defines) = @_;
//         if ($hart > 0) {
//                 foreach my $def (@defines) {
//                     &IFDEF($def);
//                 }
//         }
// }
//
// sub ENDIF_HART {
//         my ($hart, @defines) = @_;
//         if ($hart > 0) {
//                 foreach my $def (reverse @defines) {
//                     &ENDIF($def);
//                 }
//         }
// }
//
// sub print_if_hart {
//         my ($hart, @defines) = @_;
//         if ($hart > 0) {
//                 foreach my $def (@defines) {
//                     print "\`ifdef $def\n";
//                 }
//         }
// }
//
// sub print_endif_hart {
//         my ($hart, @defines) = @_;
//         if ($hart > 0) {
//                 foreach my $def (reverse @defines) {
//                     print "\`endif // $def\n";
//                 }
//         }
// }
//
//
// for (my $hart = 0; $hart < 4; $hart++) {
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_gen1_trace_enabled",    "1'b0"  );
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_gen1_trace_ivalid",     "/*NC*/");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_gen1_trace_iexception", "/*NC*/");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_gen1_trace_interrupt",  "/*NC*/");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_gen1_trace_iaddr",      "/*NC*/");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_gen1_trace_instr",      "/*NC*/");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_gen1_trace_cause",      "/*NC*/");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_gen1_trace_priv",       "/*NC*/");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_gen1_trace_tval",       "/*NC*/");
//
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_trace_enabled",    "hart${hart}_trace_enabled");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_trace_itype",      "hart${hart}_trace_itype");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_trace_cause",      "hart${hart}_trace_cause");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_trace_tval",       "hart${hart}_trace_tval");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_trace_priv",       "hart${hart}_trace_priv");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_trace_iaddr",      "hart${hart}_trace_iaddr");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_trace_iretire",    "hart${hart}_trace_iretire");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_trace_ilastsize",  "hart${hart}_trace_ilastsize");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_trace_halted",     "hart${hart}_trace_halted");
//         #&CONNECT("ae350_cpu_subsystem.hart${hart}_trace_ctype",     "hart${hart}_trace_ctype");
//         #&CONNECT("ae350_cpu_subsystem.hart${hart}_trace_context",   "hart${hart}_trace_context");
//         &CONNECT("ae350_cpu_subsystem.hart${hart}_trace_reset",      "hart${hart}_trace_reset");
//
//         :`ifdef PLATFORM_DEBUG_SUBSYSTEM
//         :`ifdef NDS_IO_TRACE_INSTR
//         if ($hart > 0) {
//                 print_if_hart($hart, "NDS_NHART", "NDS_IO_HART${hart}");
//                 :        assign hart${hart}_trace_secure     = 1'b0;
//                 :        `ifdef NDS_IO_L2C
//                 :                assign hart${hart}_power_down = core${hart}_wfi_sel_iso_sync;
//                 :        `else
//                 :                assign hart${hart}_power_down = 1'b0;
//                 :        `endif // NDS_IO_L2C
//                 :        `ifndef NDS_IO_HAS_TRACE_CTYPE
//                 :                assign hart${hart}_trace_ctype      = 2'd0;
//                 :                assign hart${hart}_trace_context    = 32'd0;
//                 :        `endif // NDS_IO_HAS_TRACE_CTYPE
//                 print_endif_hart($hart, "NDS_NHART", "NDS_IO_HART${hart}");
//         } else {
//                 :assign hart${hart}_trace_secure     = 1'b0;
//                 :assign hart${hart}_power_down = 1'b0;
//                 :`ifndef NDS_IO_HAS_TRACE_CTYPE
//                 :        assign hart${hart}_trace_ctype      = 2'd0;
//                 :        assign hart${hart}_trace_context    = 32'd0;
//                 :`endif // NDS_IO_HAS_TRACE_CTYPE
//         }
//         :`endif // NDS_IO_TRACE_INSTR
//         :`else // !PLATFORM_DEBUG_SUBSYSTEM
//         :`ifdef NDS_IO_TRACE_INSTR
//         if ($hart > 0) {
//                 print_if_hart($hart, "NDS_NHART", "NDS_IO_HART${hart}");
//                 :assign hart${hart}_trace_enabled = 1'b0;
//                 print_endif_hart($hart, "NDS_NHART", "NDS_IO_HART${hart}");
//         } else {
//                 :assign hart${hart}_trace_enabled = 1'b0;
//         }
//         :`endif //NDS_IO_TRACE_INSTR
//         :`endif // PLATFORM_DEBUG_SUBSYSTEM
// }
//
// for (my $hart = 0; $hart < 4; $hart++) {
// &IFDEF_HART($hart, "NDS_NHART", "NDS_IO_HART${hart}");
//      &CONNECT("ae350_cpu_subsystem.hart${hart}_vc_valu_idle",     "/*NC*/");
//      &CONNECT("ae350_cpu_subsystem.hart${hart}_vc_vdiv_idle",     "/*NC*/");
//      &CONNECT("ae350_cpu_subsystem.hart${hart}_vc_vfdiv_idle",    "/*NC*/");
//      &CONNECT("ae350_cpu_subsystem.hart${hart}_vc_vfmac_idle",    "/*NC*/");
//      &CONNECT("ae350_cpu_subsystem.hart${hart}_vc_vfmis_idle",    "/*NC*/");
//      &CONNECT("ae350_cpu_subsystem.hart${hart}_vc_vlsu_idle",     "/*NC*/");
//      &CONNECT("ae350_cpu_subsystem.hart${hart}_vc_vmac_idle",     "/*NC*/");
//      &CONNECT("ae350_cpu_subsystem.hart${hart}_vc_vmsk_idle",     "/*NC*/");
//      &CONNECT("ae350_cpu_subsystem.hart${hart}_vc_vper_idle",     "/*NC*/");
//      &CONNECT("ae350_cpu_subsystem.hart${hart}_vc_vpu_idle",      "/*NC*/");
// &ENDIF_HART($hart, "NDS_NHART", "NDS_IO_HART${hart}");
// }
//
//
// &IFDEF("NDS_NHART");
// &IFDEF("NDS_IO_L2C");
//	 &CONNECT("ae350_cpu_subsystem", {
//		core0_wfi_sel_iso => "core0_wfi_sel_iso_sync",
//		core1_wfi_sel_iso => "core1_wfi_sel_iso_sync",
//		core2_wfi_sel_iso => "core2_wfi_sel_iso_sync",
//		core3_wfi_sel_iso => "core3_wfi_sel_iso_sync",
//	 });
// &ENDIF("NDS_IO_L2C");
// &ENDIF("NDS_NHART");
//
// &IFDEF("NDS_IO_AHB");
// &ELSE("NDS_IO_AHB");
// 	&IFDEF("NDS_IO_BIU_X2");
// 	&ELSE("NDS_IO_BIU_X2");
// &CONNECT("ae350_cpu_subsystem", {
//	araddr		=> "cpu_araddr",
//	arburst		=> "cpu_arburst",
//	arcache		=> "cpu_arcache",
//	arid		=> "cpu_arid",
//	arlen		=> "cpu_arlen",
//	arlock		=> "cpu_arlock",
//	arprot		=> "cpu_arprot",
//	arready		=> "cpu_arready",
//	arsize		=> "cpu_arsize",
//	arvalid		=> "cpu_arvalid",
//	awaddr		=> "cpu_awaddr",
//	awburst		=> "cpu_awburst",
//	awcache		=> "cpu_awcache",
//	awid		=> "cpu_awid",
//	awlen		=> "cpu_awlen",
//	awlock		=> "cpu_awlock",
//	awprot		=> "cpu_awprot",
//	awready		=> "cpu_awready",
//	awsize		=> "cpu_awsize",
//	awvalid		=> "cpu_awvalid",
//	bid		=> "cpu_bid",
//	bready		=> "cpu_bready",
//	bresp		=> "cpu_bresp",
//	bvalid		=> "cpu_bvalid",
//	rdata		=> "cpu_rdata",
//	rid		=> "cpu_rid",
//	rlast		=> "cpu_rlast",
//	rready		=> "cpu_rready",
//	rresp		=> "cpu_rresp",
//	rvalid		=> "cpu_rvalid",
//	wdata		=> "cpu_wdata",
//	wlast		=> "cpu_wlast",
//	wready		=> "cpu_wready",
//	wstrb		=> "cpu_wstrb",
//	wvalid		=> "cpu_wvalid",
// });
// 	&ENDIF("NDS_IO_BIU_X2");
// &ENDIF("NDS_IO_AHB");
//
// &IFDEF("AE350_AXI_SUPPORT");
// &CONNECT("ae350_cpu_subsystem", {
//	i_araddr	=> "cpu_i_araddr",
//	i_arburst	=> "cpu_i_arburst",
//	i_arcache	=> "cpu_i_arcache",
//	i_arid		=> "cpu_i_arid",
//	i_arlen		=> "cpu_i_arlen",
//	i_arlock	=> "cpu_i_arlock",
//	i_arprot	=> "cpu_i_arprot",
//	i_arready	=> "cpu_i_arready",
//	i_arsize	=> "cpu_i_arsize",
//	i_arvalid	=> "cpu_i_arvalid",
//	i_awaddr	=> "cpu_i_awaddr",
//	i_awburst	=> "cpu_i_awburst",
//	i_awcache	=> "cpu_i_awcache",
//	i_awid		=> "cpu_i_awid",
//	i_awlen		=> "cpu_i_awlen",
//	i_awlock	=> "cpu_i_awlock",
//	i_awprot	=> "cpu_i_awprot",
//	i_awready	=> "cpu_i_awready",
//	i_awsize	=> "cpu_i_awsize",
//	i_awvalid	=> "cpu_i_awvalid",
//	i_bid		=> "cpu_i_bid",
//	i_bready	=> "cpu_i_bready",
//	i_bresp		=> "cpu_i_bresp",
//	i_bvalid	=> "cpu_i_bvalid",
//	i_rdata		=> "cpu_i_rdata",
//	i_rid		=> "cpu_i_rid",
//	i_rlast		=> "cpu_i_rlast",
//	i_rready	=> "cpu_i_rready",
//	i_rresp		=> "cpu_i_rresp",
//	i_rvalid	=> "cpu_i_rvalid",
//	i_wdata		=> "cpu_i_wdata",
//	i_wlast		=> "cpu_i_wlast",
//	i_wready	=> "cpu_i_wready",
//	i_wstrb		=> "cpu_i_wstrb",
//	i_wvalid	=> "cpu_i_wvalid",
//
//	d_araddr	=> "cpu_d_araddr",
//	d_arburst	=> "cpu_d_arburst",
//	d_arcache	=> "cpu_d_arcache",
//	d_arid		=> "cpu_d_arid",
//	d_arlen		=> "cpu_d_arlen",
//	d_arlock	=> "cpu_d_arlock",
//	d_arprot	=> "cpu_d_arprot",
//	d_arready	=> "cpu_d_arready",
//	d_arsize	=> "cpu_d_arsize",
//	d_arvalid	=> "cpu_d_arvalid",
//	d_awaddr	=> "cpu_d_awaddr",
//	d_awburst	=> "cpu_d_awburst",
//	d_awcache	=> "cpu_d_awcache",
//	d_awid		=> "cpu_d_awid",
//	d_awlen		=> "cpu_d_awlen",
//	d_awlock	=> "cpu_d_awlock",
//	d_awprot	=> "cpu_d_awprot",
//	d_awready	=> "cpu_d_awready",
//	d_awsize	=> "cpu_d_awsize",
//	d_awvalid	=> "cpu_d_awvalid",
//	d_bid		=> "cpu_d_bid",
//	d_bready	=> "cpu_d_bready",
//	d_bresp		=> "cpu_d_bresp",
//	d_bvalid	=> "cpu_d_bvalid",
//	d_rdata		=> "cpu_d_rdata",
//	d_rid		=> "cpu_d_rid",
//	d_rlast		=> "cpu_d_rlast",
//	d_rready	=> "cpu_d_rready",
//	d_rresp		=> "cpu_d_rresp",
//	d_rvalid	=> "cpu_d_rvalid",
//	d_wdata		=> "cpu_d_wdata",
//	d_wlast		=> "cpu_d_wlast",
//	d_wready	=> "cpu_d_wready",
//	d_wstrb		=> "cpu_d_wstrb",
//	d_wvalid	=> "cpu_d_wvalid",
//
//	slv_araddr	=> "cpuslv_araddr",
//	slv_arburst	=> "cpuslv_arburst",
//	slv_arcache	=> "cpuslv_arcache",
//	slv_arid	=> "cpuslv_arid",
//	slv_arlen	=> "cpuslv_arlen",
//	slv_arlock	=> "cpuslv_arlock",
//	slv_arprot	=> "cpuslv_arprot",
//	slv_arready	=> "cpuslv_arready",
//	slv_arsize	=> "cpuslv_arsize",
//	slv_arvalid	=> "cpuslv_arvalid",
//	slv_awaddr	=> "cpuslv_awaddr",
//	slv_awburst	=> "cpuslv_awburst",
//	slv_awcache	=> "cpuslv_awcache",
//	slv_awid	=> "cpuslv_awid",
//	slv_awlen	=> "cpuslv_awlen",
//	slv_awlock	=> "cpuslv_awlock",
//	slv_awprot	=> "cpuslv_awprot",
//	slv_awready	=> "cpuslv_awready",
//	slv_awsize	=> "cpuslv_awsize",
//	slv_awvalid	=> "cpuslv_awvalid",
//	slv_bid		=> "cpuslv_bid",
//	slv_bready	=> "cpuslv_bready",
//	slv_bresp	=> "cpuslv_bresp",
//	slv_bvalid	=> "cpuslv_bvalid",
//	slv_rdata	=> "cpuslv_rdata",
//	slv_rid		=> "cpuslv_rid",
//	slv_rlast	=> "cpuslv_rlast",
//	slv_rready	=> "cpuslv_rready",
//	slv_rresp	=> "cpuslv_rresp",
//	slv_rvalid	=> "cpuslv_rvalid",
//	slv_wdata	=> "cpuslv_wdata",
//	slv_wlast	=> "cpuslv_wlast",
//	slv_wready	=> "cpuslv_wready",
//	slv_wstrb	=> "cpuslv_wstrb",
//	slv_wvalid	=> "cpuslv_wvalid",
//
//	axi_bus_clk_en			=> "axi2core_clken",
//	ahb_bus_clk_en			=> "ahb2core_clken",
//	hart0_reset_vector		=> "core_reset_vectors[(VALEN-1):0]",
//	hart0_icache_disable_init	=> "hart0_icache_disable_init",
//	hart0_dcache_disable_init	=> "hart0_dcache_disable_init",
//	hart0_core_wfi_mode		=> "hart0_core_wfi_mode",
//	hart0_nmi			=> "wdt_int",
//
//	hart1_reset_vector		=> "core_reset_vectors[(VALEN+63):64]",
//	hart1_icache_disable_init	=> "hart1_icache_disable_init",
//	hart1_dcache_disable_init	=> "hart1_dcache_disable_init",
//	hart1_core_wfi_mode		=> "hart1_core_wfi_mode",
//	hart1_nmi			=> "1'b0",
//
//	hart2_reset_vector		=> "core_reset_vectors[(VALEN+127):128]",
//	hart2_icache_disable_init	=> "hart2_icache_disable_init",
//	hart2_dcache_disable_init	=> "hart2_dcache_disable_init",
//	hart2_core_wfi_mode		=> "hart2_core_wfi_mode",
//	hart2_nmi			=> "1'b0",
//
//	hart3_reset_vector		=> "core_reset_vectors[(VALEN+191):192]",
//	hart3_icache_disable_init	=> "hart3_icache_disable_init",
//	hart3_dcache_disable_init	=> "hart3_dcache_disable_init",
//	hart3_core_wfi_mode		=> "hart3_core_wfi_mode",
//	hart3_nmi			=> "1'b0",
//
//	core_clk			=> "core_clk",
//	core_resetn			=> "core_resetn",
//	l2c_reset_n			=> "core_resetn[0]",
//	m4_clk_en			=> "axi2core_clken",
//	mtime_clk			=> "pclk",
//
//	hart0_wakeup_event		=> "hart0_wakeup_event",
//	hart1_wakeup_event		=> "hart1_wakeup_event",
//	hart2_wakeup_event		=> "hart2_wakeup_event",
//	hart3_wakeup_event		=> "hart3_wakeup_event",
//
//	pcs_core0_sleep_ok		=> "pcs_core0_sleep_ok",
//	pcs_core0_sleep_req		=> "pcs_core0_sleep_req",
//	pcs_core1_sleep_ok		=> "pcs_core1_sleep_ok",
//	pcs_core1_sleep_req		=> "pcs_core1_sleep_req",
//	pcs_core2_sleep_ok		=> "pcs_core2_sleep_ok",
//	pcs_core2_sleep_req		=> "pcs_core2_sleep_req",
//	pcs_core3_sleep_ok		=> "pcs_core3_sleep_ok",
//	pcs_core3_sleep_req		=> "pcs_core3_sleep_req",
//
//#	aopd_por_rstn			=> "aopd_por_rstn",
//#	dm_clk				=> "dm_clk",
//#	pldm_bus_resetn			=> "pldm_bus_resetn",
// });
// &FORCE("wire", "core_resetn[(NHART-1):0]");
// &IFDEF("NDS_IO_SLAVEPORT");
// &FORCE("wire", "cpuslv_rdata[SLVPORT_DATA_MSB:0]");
// &FORCE("wire", "cpuslv_wdata[SLVPORT_DATA_MSB:0]");
// &FORCE("wire", "cpuslv_wstrb [SLVPORT_WSTRB_MSB:0]");
// &ENDIF("NDS_IO_SLAVEPORT");
//
// &IFDEF("PLATFORM_DEBUG_SUBSYSTEM");
// &IFDEF("PLATFORM_PLDM_SYS_BUS_ACCESS");
// &CONNECT("ae350_cpu_subsystem", {
//	dm_sys_araddr		=>	"dm_sys_araddr",
//	dm_sys_arburst		=>	"dm_sys_arburst",
//	dm_sys_arcache		=>	"dm_sys_arcache",
//	dm_sys_arid		=>	"dm_sys_arid",
//	dm_sys_arlen		=>	"dm_sys_arlen",
//	dm_sys_arlock		=>	"dm_sys_arlock",
//	dm_sys_arprot		=>	"dm_sys_arprot",
//	dm_sys_arready		=>	"dm_sys_arready",
//	dm_sys_arsize		=>	"dm_sys_arsize",
//	dm_sys_arvalid		=>	"dm_sys_arvalid",
//	dm_sys_awaddr		=>	"dm_sys_awaddr",
//	dm_sys_awburst		=>	"dm_sys_awburst",
//	dm_sys_awcache		=>	"dm_sys_awcache",
//	dm_sys_awid		=>	"dm_sys_awid",
//	dm_sys_awlen		=>	"dm_sys_awlen",
//	dm_sys_awlock		=>	"dm_sys_awlock",
//	dm_sys_awprot		=>	"dm_sys_awprot",
//	dm_sys_awready		=>	"dm_sys_awready",
//	dm_sys_awsize		=>	"dm_sys_awsize",
//	dm_sys_awvalid		=>	"dm_sys_awvalid",
//	dm_sys_bid		=>	"dm_sys_bid",
//	dm_sys_bready		=>	"dm_sys_bready",
//	dm_sys_bresp		=>	"dm_sys_bresp",
//	dm_sys_bvalid		=>	"dm_sys_bvalid",
//	dm_sys_rdata		=>	"dm_sys_rdata",
//	dm_sys_rid		=>	"dm_sys_rid",
//	dm_sys_rlast		=>	"dm_sys_rlast",
//	dm_sys_rready		=>	"dm_sys_rready",
//	dm_sys_rresp		=>	"dm_sys_rresp",
//	dm_sys_rvalid		=>	"dm_sys_rvalid",
//	dm_sys_wdata		=>	"dm_sys_wdata",
//	dm_sys_wlast		=>	"dm_sys_wlast",
//	dm_sys_wready		=>	"dm_sys_wready",
//	dm_sys_wstrb		=>	"dm_sys_wstrb",
//	dm_sys_wvalid		=>	"dm_sys_wvalid",
// });
//
// &FORCE("wire", "dm_sys_araddr");
// &FORCE("wire", "dm_sys_arburst");
// &FORCE("wire", "dm_sys_arcache");
// &FORCE("wire", "dm_sys_arid");
// &FORCE("wire", "dm_sys_arlen");
// &FORCE("wire", "dm_sys_arlock");
// &FORCE("wire", "dm_sys_arprot");
// &FORCE("wire", "dm_sys_arsize");
// &FORCE("wire", "dm_sys_arvalid");
// &FORCE("wire", "dm_sys_arready");
// &FORCE("wire", "dm_sys_awaddr");
// &FORCE("wire", "dm_sys_awburst");
// &FORCE("wire", "dm_sys_awcache");
// &FORCE("wire", "dm_sys_awid");
// &FORCE("wire", "dm_sys_awlen");
// &FORCE("wire", "dm_sys_awlock");
// &FORCE("wire", "dm_sys_awprot");
// &FORCE("wire", "dm_sys_awsize");
// &FORCE("wire", "dm_sys_awvalid");
// &FORCE("wire", "dm_sys_awready");
// &FORCE("wire", "dm_sys_wdata[(CPUSUB_BIU_DATA_WIDTH-1):0]");
// &FORCE("wire", "dm_sys_wlast");
// &FORCE("wire", "dm_sys_wstrb[((CPUSUB_BIU_DATA_WIDTH/8)-1):0]");
// &FORCE("wire", "dm_sys_wvalid");
// &FORCE("wire", "dm_sys_wready");
// &FORCE("wire", "dm_sys_bready");
// &FORCE("wire", "dm_sys_bid");
// &FORCE("wire", "dm_sys_bresp");
// &FORCE("wire", "dm_sys_bvalid");
// &FORCE("wire", "dm_sys_rdata[(CPUSUB_BIU_DATA_WIDTH-1):0]");
// &FORCE("wire", "dm_sys_rid");
// &FORCE("wire", "dm_sys_rlast");
// &FORCE("wire", "dm_sys_rresp");
// &FORCE("wire", "dm_sys_rvalid");
// &FORCE("wire", "dm_sys_rready");
// &FORCE("wire", "dm_sys_arid");
// &FORCE("wire", "dm_sys_awid");
// &FORCE("wire", "dm_sys_rid");
// &FORCE("wire", "dm_sys_bid");
// &ENDIF("PLATFORM_PLDM_SYS_BUS_ACCESS");
// &ENDIF("PLATFORM_DEBUG_SUBSYSTEM");
// &ENDIF("AE350_AXI_SUPPORT");
//
// &IFDEF("AE350_AHB_SUPPORT");
// &CONNECT("ae350_cpu_subsystem", {
//   i_haddr			=> "cpu_i_haddr",
//   i_hburst			=> "cpu_i_hburst",
//   i_hprot			=> "cpu_i_hprot",
//   i_hsize			=> "cpu_i_hsize",
//   i_htrans			=> "cpu_i_htrans",
//   i_hwdata			=> "cpu_i_hwdata",
//   i_hwrite			=> "cpu_i_hwrite",
//   i_hrdata			=> "cpu_i_hrdata",
//   i_hready			=> "cpu_i_hready",
//   i_hresp			=> "cpu_i_hresp",

//   d_haddr			=> "cpu_d_haddr",
//   d_hburst			=> "cpu_d_hburst",
//   d_hprot			=> "cpu_d_hprot",
//   d_hsize			=> "cpu_d_hsize",
//   d_htrans			=> "cpu_d_htrans",
//   d_hwdata			=> "cpu_d_hwdata",
//   d_hwrite			=> "cpu_d_hwrite",
//   d_hrdata			=> "cpu_d_hrdata",
//   d_hready			=> "cpu_d_hready",
//   d_hresp			=> "cpu_d_hresp",

//   haddr			=> "cpu_haddr",
//   hburst			=> "cpu_hburst",
//   hprot			=> "cpu_hprot",
//   hsize			=> "cpu_hsize",
//   htrans			=> "cpu_htrans",
//   hwdata			=> "cpu_hwdata",
//   hwrite			=> "cpu_hwrite",
//   hrdata			=> "cpu_hrdata",
//   hready			=> "cpu_hready",
//   hresp			=> "cpu_hresp",
//
//   slv_hsel			=> "cpuslv_hsel",
//   slv_haddr			=> "cpuslv_haddr",
//   slv_hburst			=> "cpuslv_hburst",
//   slv_hprot			=> "cpuslv_hprot",
//   slv_hsize			=> "cpuslv_hsize",
//   slv_htrans			=> "cpuslv_htrans",
//   slv_hwdata			=> "cpuslv_hwdata",
//   slv_hwrite			=> "cpuslv_hwrite",
//   slv_hrdata			=> "cpuslv_hrdata",
//   slv_hreadyout		=> "cpuslv_hreadyout",
//   slv_hready			=> "cpuslv_hready",
//   slv_hresp			=> "cpuslv_hresp",
//
//   axi_bus_clk_en		=> "axi2core_clken",
//   ahb_bus_clk_en		=> "ahb2core_clken",
//   hart0_reset_vector		=> "core_reset_vectors[(VALEN-1):0]",
//   hart0_icache_disable_init	=> "hart0_icache_disable_init",
//   hart0_dcache_disable_init	=> "hart0_dcache_disable_init",
//	hart0_core_wfi_mode		=> "hart0_core_wfi_mode",
//   hart0_nmi			=> "wdt_int",
//
//	hart1_reset_vector		=> "core_reset_vectors[(VALEN+63):64]",
//	hart1_icache_disable_init	=> "hart1_icache_disable_init",
//	hart1_dcache_disable_init	=> "hart1_dcache_disable_init",
//	hart1_core_wfi_mode		=> "hart1_core_wfi_mode",
//   hart1_nmi			=> "1'b0",
//
//	hart2_reset_vector		=> "core_reset_vectors[(VALEN+127):128]",
//	hart2_icache_disable_init	=> "hart2_icache_disable_init",
//	hart2_dcache_disable_init	=> "hart2_dcache_disable_init",
//	hart2_core_wfi_mode		=> "hart2_core_wfi_mode",
//   hart2_nmi			=> "1'b0",
//
//	hart3_reset_vector		=> "core_reset_vectors[(VALEN+191):192]",
//	hart3_icache_disable_init	=> "hart3_icache_disable_init",
//	hart3_dcache_disable_init	=> "hart3_dcache_disable_init",
//	hart3_core_wfi_mode		=> "hart3_core_wfi_mode",
//   hart3_nmi			=> "1'b0",
//
//   core_clk			=> "core_clk",
//   core_resetn		=> "core_resetn",
//   l2c_reset_n		=> "core_resetn[0]",
//   m4_clk_en			=> "axi2core_clken",
//   mtime_clk			=> "pclk",
//
// });
//
// &IFDEF("PLATFORM_DEBUG_SUBSYSTEM");
// &IFDEF("PLATFORM_PLDM_SYS_BUS_ACCESS");
// &CONNECT("ae350_cpu_subsystem", {
//	dm_sys_haddr		=>	"dm_sys_haddr",
//	dm_sys_hburst		=>	"dm_sys_hburst",
//	dm_sys_hbusreq		=>	"/* NC */",
//	dm_sys_hgrant		=>	"1'b1",
//	dm_sys_hprot		=>	"dm_sys_hprot",
//	dm_sys_hrdata		=>	"dm_sys_hrdata",
//	dm_sys_hready		=>	"dm_sys_hready",
//	dm_sys_hresp		=>	"dm_sys_hresp",
//	dm_sys_hsize		=>	"dm_sys_hsize",
//	dm_sys_htrans		=>	"dm_sys_htrans",
//	dm_sys_hwdata		=>	"dm_sys_hwdata",
//	dm_sys_hwrite		=>	"dm_sys_hwrite",
// });
// &ENDIF("PLATFORM_PLDM_SYS_BUS_ACCESS");
// &ENDIF("PLATFORM_DEBUG_SUBSYSTEM");
//
// &IFDEF("PLATFORM_DEBUG_SUBSYSTEM");
// &CONNECT("ae350_cpu_subsystem", {
//	dmactive		=>	"/* NC */",
// });
// &ENDIF("PLATFORM_DEBUG_SUBSYSTEM");

// &ENDIF("AE350_AHB_SUPPORT");
//
// &IFDEF("AE350_LCDC_SUPPORT");
// &FORCE("inout", "X_clac");
// &FORCE("inout", "X_clcp");
// &FORCE("inout", "X_cld[23:0]");
// &FORCE("inout", "X_clfp");
// &FORCE("inout", "X_clle");
// &FORCE("inout", "X_cllp");
// &FORCE("inout", "X_clpower");
// &ENDIF("AE350_LCDC_SUPPORT");
//
// &IFDEF("AE350_MAC_SUPPORT");
// &FORCE("inout", "X_tx_clk");
// &FORCE("inout", "X_tx_en");
// &FORCE("inout", "X_txd[3:0]");
// &FORCE("inout", "X_rx_clk");
// &FORCE("inout", "X_rx_dv");
// &FORCE("inout", "X_rx_er");
// &FORCE("inout", "X_rxd[3:0]");
// &FORCE("inout", "X_crs");
// &FORCE("inout", "X_col");
// &FORCE("inout", "X_mdc");
// &FORCE("inout", "X_mdio");
// &FORCE("inout", "X_phy_linksts");
// &FORCE("inout", "X_pdn_phy");
// &ENDIF("AE350_MAC_SUPPORT");
//
// &IFDEF("NDS_FPGA");
//   &IFDEF("NDS_BOARD_ORCA");
//     &FORCE("inout", "X_flash_dir");
//   &ENDIF("NDS_BOARD_ORCA");
// &ENDIF("NDS_FPGA");
//
// #==================
// # AXI Slaves
// #==================
//
// #----------------------------------------------------------------------------
// # AE350 RAM
// #----------------------------------------------------------------------------
// $ds = $AXI_SLV_RAM;
// &DANGLER("init_calib_complete");
// :`ifdef PLATFORM_NO_RAM_SUBSYSTEM
// :assign init_calib_complete = 1'b1;
// :assign ui_clk = 1'b0;
// :	`ifdef AE350_AHB_SUPPORT
// :assign ram_hrdata = {CPUSUB_BIU_DATA_WIDTH{1'b0}};
// :assign ram_hreadyout = 1'b1;
// :assign ram_hresp = 2'b0;
// :	`endif	// AE350_AHB_SUPPORT
// :`endif
//
// # FIXME: The declaration of ddr3_latency is not correctly generated based on the macros...
// &IFDEF("PLATFORM_NO_RAM_SUBSYSTEM");
//   &IFDEF("NDS_FPGA");
//     &IFDEF("AE350_AXI_SUPPORT");
//       &IFDEF("AE350_DDR_LATENCY");
//         &FORCE("wire", "ddr3_latency[3:0]");
//         &FORCE("wire", "ddr3_bw_ctrl[1:0]");
//       &ENDIF("AE350_DDR_LATENCY");
//     &ENDIF("AE350_AXI_SUPPORT");
//   &ENDIF("NDS_FPGA");
// &ENDIF("PLATFORM_NO_RAM_SUBSYSTEM");
//
// &IFDEF("PLATFORM_NO_RAM_SUBSYSTEM");
// &ELSE("PLATFORM_NO_RAM_SUBSYSTEM");
//   &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_ram_subsystem.v", "ae350_ram_subsystem", {
//     SIMULATION		=> "SIMULATION",
//     SIM_BYPASS_INIT_CAL	=> "SIM_BYPASS_INIT_CAL",
//     ID_WIDTH			=> "CPUSUB_BIU_ID_WIDTH+4",
//     ADDR_WIDTH		=> "ADDR_WIDTH",
//     DATA_WIDTH		=> "CPUSUB_BIU_DATA_WIDTH",
//   });
// &ENDIF("PLATFORM_NO_RAM_SUBSYSTEM");
// &IFDEF("AE350_AXI_SUPPORT");
// &CONNECT("ae350_ram_subsystem", {
//	araddr		=> "ram_araddr",
//	arburst		=> "ram_arburst",
//	arcache		=> "ram_arcache",
//	arid		=> "ram_arid",
//	arlen		=> "ram_arlen",
//	arlock		=> "ram_arlock",
//	arprot		=> "ram_arprot",
//	arready		=> "ram_arready",
//	arsize		=> "ram_arsize",
//	arvalid		=> "ram_arvalid",
//	awaddr		=> "ram_awaddr",
//	awburst		=> "ram_awburst",
//	awcache		=> "ram_awcache",
//	awid		=> "ram_awid",
//	awlen		=> "ram_awlen",
//	awlock		=> "ram_awlock",
//	awprot		=> "ram_awprot",
//	awready		=> "ram_awready",
//	awsize		=> "ram_awsize",
//	awvalid		=> "ram_awvalid",
//	bid		=> "ram_bid",
//	bready		=> "ram_bready",
//	bresp		=> "ram_bresp",
//	bvalid		=> "ram_bvalid",
//	rdata		=> "ram_rdata",
//	rid		=> "ram_rid",
//	rlast		=> "ram_rlast",
//	rready		=> "ram_rready",
//	rresp		=> "ram_rresp",
//	rvalid		=> "ram_rvalid",
//	wdata		=> "ram_wdata",
//	wlast		=> "ram_wlast",
//	wready		=> "ram_wready",
//	wstrb		=> "ram_wstrb",
//	wvalid		=> "ram_wvalid",
// });
//	&FORCE("wire",	"ram_arid[CPUSUB_BIU_ID_MSB+4:0]");
//	&FORCE("wire",	"ram_awid[CPUSUB_BIU_ID_MSB+4:0]");
//	&FORCE("wire",	 "ram_rid[CPUSUB_BIU_ID_MSB+4:0]");
//	&FORCE("wire",	 "ram_bid[CPUSUB_BIU_ID_MSB+4:0]");
// &ENDIF("AE350_AXI_SUPPORT");
// &IFDEF("AE350_AHB_SUPPORT");
// &CONNECT("ae350_ram_subsystem", {
//	hsel		=> "ram_hsel",
//	htrans		=> "ram_htrans",
//	haddr		=> "ram_haddr",
//	hsize		=> "ram_hsize",
//	hburst		=> "ram_hburst",
//	hwrite		=> "ram_hwrite",
//	hwdata		=> "ram_hwdata",
//	hprot		=> "ram_hprot",
//	hreadyout	=> "ram_hreadyout",
//	hready		=> "ram_hready",
//	hrdata		=> "ram_hrdata",
//	hresp		=> "ram_hresp",
// });
// &ENDIF("AE350_AHB_SUPPORT");
// # &ENDIF("AE350_AXI_SUPPORT");
//
//
// &IFDEF("AE350_K7DDR3_SUPPORT");
//	&FORCE("inout",  "X_ddr3_dq[31:0]");
//	&FORCE("inout",  "X_ddr3_dqs_n[3:0]");
//	&FORCE("inout",  "X_ddr3_dqs_p[3:0]");
//	&FORCE("output", "X_ddr3_addr[14:0]");
//	&FORCE("output", "X_ddr3_ba[2:0]");
//	&FORCE("output", "X_ddr3_cas_n");
//	&FORCE("output", "X_ddr3_ck_n[0:0]");
//	&FORCE("output", "X_ddr3_ck_p[0:0]");
//	&FORCE("output", "X_ddr3_cke[0:0]");
//	&FORCE("output", "X_ddr3_cs_n[0:0]");
//	&FORCE("output", "X_ddr3_dm[3:0]");
//	&FORCE("output", "X_ddr3_odt[0:0]");
//	&FORCE("output", "X_ddr3_ras_n");
//	&FORCE("output", "X_ddr3_reset_n");
//	&FORCE("input",  "X_ddr3_sys_clk_n");
//	&FORCE("input",  "X_ddr3_sys_clk_p");
//	&FORCE("output", "X_ddr3_we_n");
// &ENDIF("AE350_K7DDR3_SUPPORT");
//
// &IFDEF("AE350_VUDDR4_SUPPORT");
// &FORCE("inout", "X_ddr4_dm_dbi_n");
// &FORCE("inout", "X_ddr4_dq");
// &FORCE("inout", "X_ddr4_dqs_c");
// &FORCE("inout", "X_ddr4_dqs_t");
// &ENDIF("AE350_VUDDR4_SUPPORT");
// #------------------------------------------------------------------------------
// # Core
// #------------------------------------------------------------------------------
// $m = $AHB_MST_CPU0;
// $dm = $AHB_MST_DEBUG;
// $hs = $AHB_SLV_DLM_SLAVE_PORT;
//
// ####### MARK: ROM instance ######
// &IFDEF("AE350_SPI1_SUPPORT");
// 	&IFDEF("AE350_SMC_SUPPORT");
// 		&DANGLER("dec_hready");
// 		&FORCE("wire",  "spi_mem_hresp[1:0]");
// 		&INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcbusdec200_rom/hdl/atcbusdec200_rom.v","u_rom_ahbdec");
// 		&CONNECT("u_rom_ahbdec", {
// 		       us_hsel 	=> "1'b1",
// 		       us_haddr	=> "rom_haddr[31:0]",
// 		       us_htrans   	=> "rom_htrans",
// 		       us_hrdata   	=> "rom_hrdata",
// 		       us_hreadyout	=> "rom_hreadyout",
// 		       us_hresp    	=> "rom_hresp",
// 		       us_hready   	=> "rom_hready",
// 		       ds1_hsel     	=> "spi_mem_hsel",
// 		       ds1_hrdata   	=> "spi_mem_hrdata",
// 		       ds1_hreadyout	=> "spi_mem_hreadyout",
// 		       ds1_hresp    	=> "spi_mem_hresp[0]",
// 		       ds2_hsel     	=> "smc_mem_hsel",
// 		       ds2_hrdata   	=> "smc_mem_hrdata",
// 		       ds2_hreadyout	=> "smc_mem_hreadyout",
// 		       ds2_hresp    	=> "smc_mem_hresp[0]",
// 		       ds_hready	=> "dec_hready",
// 		});
// 		&FORCE("wire", "rom_hburst");
// 		&FORCE("wire", "rom_hsize");
// 		&FORCE("wire", "rom_hwdata[31:0]");
// 		&FORCE("wire", "rom_hready");
//
// 		for (my $i = 3; $i < 32; $i++) {
// 		     &CONNECT("u_rom_ahbdec.ds${i}_hrdata"	, "{(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}"	);
// 		     &CONNECT("u_rom_ahbdec.ds${i}_hreadyout"	, "1'b1"	);
// 		     &CONNECT("u_rom_ahbdec.ds${i}_hresp"	, "1'b0"	);
// 		     &CONNECT("u_rom_ahbdec.ds${i}_hsel"	, "/* NC */"	);
// 		}
// 	&ENDIF("AE350_SMC_SUPPORT");
// 	&FORCE("wire", "rom_haddr[ADDR_MSB:0]");
// 	&FORCE("wire", "rom_hwrite");
// 	&FORCE("wire", "rom_htrans[1:0]");
//	&FORCE("wire", "rom_hprot[3:0]");
//	&FORCE("wire", "rom_hsel");
// &ENDIF("AE350_SPI1_SUPPORT");

//
// &FORCE("wire", "rom_hrdata[31:0]");
// &FORCE("wire", "rom_hresp");
// &FORCE("wire", "rom_hreadyout");
//
// :`ifdef AE350_SPI1_SUPPORT
// :        assign spi_mem_haddr	= rom_haddr[31:0];
// :        assign spi_mem_hwrite	= rom_hwrite;
// :        assign spi_mem_htrans 	= rom_htrans;
// :     `ifdef AE350_SMC_SUPPORT
// :        assign spi_mem_hready	= dec_hready;
//
// :        assign smc_mem_hready 	= dec_hready;
// :     `else //AE350_SMC_SUPPORT
// :        assign spi_mem_hsel 	= 1'b1;
// :        assign spi_mem_hready	= spi_mem_hreadyout;
// :
// :        assign rom_hrdata		= spi_mem_hrdata;
// :        assign rom_hresp 		= spi_mem_hresp[0];
// :        assign rom_hreadyout	= spi_mem_hreadyout;
// :     `endif //AE350_SMC_SUPPORT
// :`else //AE350_SPI1_SUPPORT
// :        assign smc_mem_hsel 	= 1'b1;
// :     `ifdef AE350_SMC_SUPPORT
// :        assign smc_mem_hready 	= smc_mem_hreadyout;
// :        assign rom_hreadyout	= smc_mem_hreadyout;
// :        assign rom_hresp  		= smc_mem_hresp[0];
// :        assign rom_hrdata 		= smc_mem_hrdata;
// :     `else //AE350_SMC_SUPPORT
// :        assign smc_mem_hready 	= 1'b1;
// :        assign rom_hreadyout	= 1'b0;
// :        assign rom_hresp  		= 1'b0;
// :        assign rom_hrdata 		= 32'd0;
// :     `endif //AE350_SMC_SUPPORT
// :`endif //AE350_SPI1_SUPPORT
//
// #==================
// # APB Slaves
// #==================
// #----------------------------------------------------------------------------
// # SDC
// #----------------------------------------------------------------------------
// &FORCE("wire", "sdc_int");
//
// &IFDEF("AE350_SDC_SUPPORT");
//	&FORCE("inout", "X_sd_cmd_rsp");
//	&FORCE("inout", "X_sd_dat0");
//	&FORCE("inout", "X_sd_dat1");
//	&FORCE("inout", "X_sd_dat2");
//	&FORCE("inout", "X_sd_dat3");
//	&FORCE("inout", "X_sd_cd");
//	&FORCE("inout", "X_sd_wp");
//	&FORCE("inout", "X_sd_clk");
//	&FORCE("inout", "X_sd_power_on");
// &ENDIF("AE350_SDC_SUPPORT");
//
// #-----------------------------------------------------------------------------
// # SSP
// #-----------------------------------------------------------------------------
// &FORCE("wire", "ssp_intr");
// &IFDEF("AE350_SSP_SUPPORT");
// &FORCE("inout","X_ssp_sclk");
// &FORCE("inout","X_ssp_fs");
// &FORCE("inout","X_ssp_ac97_resetn");
// &FORCE("inout","X_ssp_rxd");
// &FORCE("inout","X_ssp_txd");
// &ENDIF("AE350_SSP_SUPPORT");
//
// #-----------------------------------------------------------------------------
// # SMC
// #-----------------------------------------------------------------------------
// $hs= $AHB_SLV_SMC_REG;
// $hs1= $AHB_SLV_SMC_MEM;
// &IFDEF("AE350_SMC_SUPPORT");
//   &FORCE("inout", "X_memaddr[24:0]");
//   # ORCA and BigORCA only have 16-bit NOR flash chips.
//   &IFDEF("NDS_FPGA");
//     &FORCE("inout", "X_memdata[15:0]");
//   &ELSE("NDS_FPGA");
//     &FORCE("inout", "X_memdata[31:0]");
//   &ENDIF("NDS_FPGA");
//   &FORCE("inout", "X_smc_cs_b");
//   &FORCE("inout", "X_smc_oe_b");
//   &FORCE("inout", "X_smc_we_b");
//
//   &DANGLER("smc_mem_hready");
//   &DANGLER("smc_mem_htrans");
//   &FORCE("wire", "smc_mem_haddr[31:0]");
//   &FORCE("wire", "smc_mem_hburst[2:0]");
//   &FORCE("wire", "smc_mem_hsize[2:0]");
//   &FORCE("wire", "smc_mem_hwrite");
//   &FORCE("wire", "smc_mem_hwdata[31:0]");
//   &FORCE("wire", "smc_mem_hsel");
//   &FORCE("wire", "smc_mem_hreadyout");
//   &FORCE("wire", "smc_mem_hrdata[31:0]");
// &ENDIF("AE350_SMC_SUPPORT");
//
// : `ifdef AE350_SMC_SUPPORT
// :    assign smc_mem_hwrite 	= rom_hwrite;
// :    assign smc_mem_hwdata 	= rom_hwdata;
// :    assign smc_mem_htrans 	= rom_htrans;
// :    assign smc_mem_haddr  	= {5'd0, rom_haddr[26:0]};
// :    assign smc_mem_hsize  	= rom_hsize;
// :    assign smc_mem_hburst 	= rom_hburst;
// : `endif //AE350_SMC_SUPPORT
//
// #==================
// # AOPD
// #==================
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_aopd.v", "ae350_aopd", {
//      SYNC_STAGE => "SYNC_STAGE",
// });
// &FORCE("wire", "pcs0_iso");
// &FORCE("wire", "pcs1_iso");
// &FORCE("wire", "pcs2_iso");
// &FORCE("wire", "pcs3_iso");
// &FORCE("wire", "pcs4_iso");
// &FORCE("wire", "pcs5_iso");
// &FORCE("wire", "pcs6_iso");
// &FORCE("wire", "pd0_vol_on");
// &FORCE("wire", "pd1_vol_on");
// &FORCE("wire", "pd2_vol_on");
// &FORCE("wire", "pd3_vol_on");
// &FORCE("wire", "pd4_vol_on");
// &FORCE("wire", "pd5_vol_on");
// &FORCE("wire", "pd6_vol_on");
//
// :wire	unused_wire;
// : assign unused_wire = pcs0_iso | pcs1_iso | pcs2_iso | pcs3_iso | pcs4_iso | pcs5_iso | pcs6_iso
// :			| pd0_vol_on | pd1_vol_on| pd2_vol_on | pd3_vol_on | pd4_vol_on | pd5_vol_on | pd6_vol_on;
//
// #-----------------------------------------------------------------------------
// # APB Slave: SPI 1, 2
// #-----------------------------------------------------------------------------
// &IFDEF("AE350_SPI1_SUPPORT");
// &DANGLER("spi_mem_hsel");
// &DANGLER("spi_mem_hrdata");
// &DANGLER("spi_mem_hresp");
// &DANGLER("spi_mem_hwrite");
// &DANGLER("spi_mem_haddr");
// &DANGLER("spi_mem_htrans");
// &DANGLER("spi_mem_hready");
// &ENDIF("AE350_SPI1_SUPPORT");
//
// &FORCE("wire", "uart1_int");
// &FORCE("wire", "gpio_intr");
// &FORCE("wire", "pit_intr");
// &DANGLER("lcd_gpo");
// &DANGLER("clpower");
// &DANGLER("smc_cs_n_0");
// &DANGLER("smc_cs_n");
//
// :`ifdef AE350_LCDC_SUPPORT
// : assign clpower = lcd_gpo[1];
// :`endif
//
// : `ifdef AE350_SMC_SUPPORT
// :	assign smc_cs_n_0 = smc_cs_n[0];
// : `endif
//
// #==================
// # Debug signals
// #==================
//# -----------------------
//# Unconnected JTAG ports
//# -----------------------
//&DANGLER("secure_mode");
//&DANGLER("T_secure_mode");
//&DANGLER("secure_code");
//:`ifdef PLATFORM_DEBUG_SUBSYSTEM
//:	`ifdef PLATFORM_JDTM_SECURE_SUPPORT
//:		assign secure_mode = T_secure_mode;
//:		// ASCII: RISC-V\@AndesTech
//:		assign secure_code = 128'h52495343_2d564041_6e646573_54656368;
//:	`endif // PLATFORM_JDTM_SECURE_SUPPORT
//:`endif //PLATFORM_DEBUG_SUBSYSTEM
//:`ifdef PLATFORM_DEBUG_PORT
//:     `ifdef PLATFORM_JTAG_TWOWIRE
//:             assign pin_tdi_in  = 1'b0;
//:             assign pin_trst_in = 1'b0;
//:     `endif // PLATFORM_JTAG_TWOWIRE
//:`endif //PLATFORM_DEBUG_PORT
//
//
// #==================
// # Pin module
// #==================
// &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_pin.v",	"ae350_pin");
// &CONNECT("ae350_pin", {
//       smc_cs_n_0          => "smc_cs_n_0",
//       pin_tdi_out         => "1'b0",
//       pin_tdi_out_en      => "1'b0",
//       pin_tdo_in          => "/* NC */",
//       pin_trst_out        => "1'b0",
//       pin_trst_out_en     => "1'b0",
// });
//# -----------------------
//# INOUT ports
//# -----------------------
// &IFDEF("NDS_FPGA");
// &ELSE("NDS_FPGA");
// &FORCE("inout", "X_om");
// &ENDIF("NDS_FPGA");
// &IFDEF("AE350_GPIO_SUPPORT");
//   &IFDEF("NDS_BOARD_CF1");
//     &FORCE("inout", "X_gpio[31:1]");
//   &ELSE("NDS_BOARD_CF1");
//     &FORCE("inout", "X_gpio[31:0]");
//   &ENDIF("NDS_BOARD_CF1");
// &ENDIF("AE350_GPIO_SUPPORT");
// &IFDEF("AE350_PIT_SUPPORT");
//   &IFDEF("NDS_BOARD_CF1");
//   &ELSE("NDS_BOARD_CF1");
//     &FORCE("inout", "X_pwm_ch0");
//     &IFDEF("ATCPIT100_CH1_SUPPORT");
//       &FORCE("inout", "X_pwm_ch1");
//     &ENDIF("ATCPIT100_CH1_SUPPORT");
//     &IFDEF("ATCPIT100_CH2_SUPPORT");
//       &FORCE("inout", "X_pwm_ch2");
//     &ENDIF("ATCPIT100_CH2_SUPPORT");
//     &IFDEF("ATCPIT100_CH3_SUPPORT");
//       &FORCE("inout", "X_pwm_ch3");
//     &ENDIF("ATCPIT100_CH3_SUPPORT");
//   &ENDIF("NDS_BOARD_CF1");
// &ENDIF("AE350_PIT_SUPPORT");
// &FORCE("inout", "X_hw_rstn");
// &IFDEF("AE350_I2C_SUPPORT");
//   &IFDEF("NDS_BOARD_CF1");
//   &ELSE("NDS_BOARD_CF1");
//     &FORCE("inout", "X_i2c_scl");
//     &FORCE("inout", "X_i2c_sda");
//   &ENDIF("NDS_BOARD_CF1");
// &ENDIF("AE350_I2C_SUPPORT");
// &IFDEF("NDS_FPGA");
// &ELSE("NDS_FPGA");
//   &FORCE("inout", "X_oschio");
//   &FORCE("inout", "X_osclio");
// &ENDIF("NDS_FPGA");
// &FORCE("inout", "X_por_b");
// &IFDEF("NDS_FPGA");
// &ELSE("NDS_FPGA");
//   &FORCE("inout", "X_aopd_por_b");
// &ENDIF("NDS_FPGA");
//
// &IFDEF("AE350_SPI1_SUPPORT");
//   &FORCE("inout", "X_spi1_clk");
//   &FORCE("inout", "X_spi1_csn");
//   &FORCE("inout", "X_spi1_miso");
//   &FORCE("inout", "X_spi1_mosi");
//   &IFDEF("ATCSPI200_QUADSPI_SUPPORT");
//     &FORCE("inout", "X_spi1_holdn");
//     &FORCE("inout", "X_spi1_wpn");
//   &ENDIF("ATCSPI200_QUADSPI_SUPPORT");
// &ENDIF("AE350_SPI1_SUPPORT");
// &IFDEF("AE350_SPI2_SUPPORT");
//   &IFDEF("NDS_BOARD_CF1");
//   &ELSE("NDS_BOARD_CF1");
//     &FORCE("inout", "X_spi2_clk");
//     &FORCE("inout", "X_spi2_csn");
//     &FORCE("inout", "X_spi2_miso");
//     &FORCE("inout", "X_spi2_mosi");
//   &ENDIF("NDS_BOARD_CF1");
//
//   &IFDEF("ATCSPI200_QUADSPI_SUPPORT");
//     &FORCE("inout", "X_spi2_holdn");
//     &FORCE("inout", "X_spi2_wpn");
//   &ENDIF("ATCSPI200_QUADSPI_SUPPORT");
// &ENDIF("AE350_SPI2_SUPPORT");
// &IFDEF("AE350_SPI3_SUPPORT");
//   &FORCE("inout", "X_spi3_clk");
//   &FORCE("inout", "X_spi3_csn");
//   &FORCE("inout", "X_spi3_miso");
//   &FORCE("inout", "X_spi3_mosi");
//   &IFDEF("ATCSPI200_QUADSPI_SUPPORT");
//     &FORCE("inout", "X_spi3_holdn");
//     &FORCE("inout", "X_spi3_wpn");
//   &ENDIF("ATCSPI200_QUADSPI_SUPPORT");
// &ENDIF("AE350_SPI3_SUPPORT");
// &IFDEF("AE350_SPI4_SUPPORT");
//   &FORCE("inout", "X_spi4_clk");
//   &FORCE("inout", "X_spi4_csn");
//   &FORCE("inout", "X_spi4_miso");
//   &FORCE("inout", "X_spi4_mosi");
//   &IFDEF("ATCSPI200_QUADSPI_SUPPORT");
//     &FORCE("inout", "X_spi4_holdn");
//     &FORCE("inout", "X_spi4_wpn");
//   &ENDIF("ATCSPI200_QUADSPI_SUPPORT");
// &ENDIF("AE350_SPI4_SUPPORT");
//
// &IFDEF("PLATFORM_DEBUG_PORT");
// &FORCE("inout", "X_tck");
// &FORCE("inout", "X_tms");
// &IFDEF("PLATFORM_JTAG_TWOWIRE");
// &ELSE("PLATFORM_JTAG_TWOWIRE");
// &FORCE("inout", "X_tdi");
// &FORCE("inout", "X_tdo");
// &FORCE("inout", "X_trst");
// &ENDIF("PLATFORM_JTAG_TWOWIRE");
// &IFDEF("PLATFORM_JDTM_SECURE_SUPPORT");
// &FORCE("inout", "X_secure_mode[1:0]");
// &ENDIF("PLATFORM_JDTM_SECURE_SUPPORT");
// &ENDIF("PLATFORM_DEBUG_PORT");
//
// &IFDEF("AE350_UART1_SUPPORT");
//   &IFDEF("NDS_BOARD_CF1");
//   &ELSE("NDS_BOARD_CF1");
//     &FORCE("inout", "X_uart1_rxd");
//     &FORCE("inout", "X_uart1_txd");
//   &ENDIF("NDS_BOARD_CF1");
//
//   &IFDEF("NDS_FPGA");
//   &ELSE("NDS_FPGA");
//     &FORCE("inout", "X_uart1_dcdn");
//     &FORCE("inout", "X_uart1_dsrn");
//     &FORCE("inout", "X_uart1_rin");
//     &FORCE("inout", "X_uart1_dtrn");
//     &FORCE("inout", "X_uart1_out1n");
//     &FORCE("inout", "X_uart1_out2n");
//   &ENDIF("NDS_FPGA");
//
//   &IFDEF("AE350_UART2_SUPPORT");
//     &IFDEF("NDS_FPGA");
//     &ELSE("NDS_FPGA");
//       &FORCE("inout", "X_uart1_ctsn");
//       &FORCE("inout", "X_uart1_rtsn");
//     &ENDIF("NDS_FPGA");
//   &ELSE("AE350_UART2_SUPPORT");
//     &FORCE("inout", "X_uart1_ctsn");
//     &FORCE("inout", "X_uart1_rtsn");
//   &ENDIF("AE350_UART2_SUPPORT");
// &ENDIF("AE350_UART1_SUPPORT");
//
// &IFDEF("AE350_UART2_SUPPORT");
//   &IFDEF("NDS_FPGA");
//   &ELSE("NDS_FPGA");
//     &FORCE("inout", "X_uart2_ctsn");
//     &FORCE("inout", "X_uart2_rtsn");
//     &FORCE("inout", "X_uart2_dcdn");
//     &FORCE("inout", "X_uart2_dsrn");
//     &FORCE("inout", "X_uart2_rin");
//     &FORCE("inout", "X_uart2_dtrn");
//     &FORCE("inout", "X_uart2_out1n");
//     &FORCE("inout", "X_uart2_out2n");
//   &ENDIF("NDS_FPGA");
//
//   &IFDEF("NDS_BOARD_CF1");
//   &ELSE("NDS_BOARD_CF1");
//     &FORCE("inout", "X_uart2_rxd");
//     &FORCE("inout", "X_uart2_txd");
//   &ENDIF("NDS_BOARD_CF1");
// &ENDIF("AE350_UART2_SUPPORT");
//
// &IFDEF("AE350_RTC_SUPPORT");
//   &IFDEF("NDS_FPGA");
//   &ELSE("NDS_FPGA");
//     &FORCE("inout", "X_rtc_wakeup");
//   &ENDIF("NDS_FPGA");
// &ENDIF("AE350_RTC_SUPPORT");
// &FORCE("inout", "X_wakeup_in");
// &IFDEF("NDS_FPGA");
// &ELSE("NDS_FPGA");
//   &FORCE("inout", "X_mpd_pwr_off");
// &ENDIF("NDS_FPGA");
//
// &IFDEF("PLATFORM_DEBUG_SUBSYSTEM");
//         &CONNECT("ae350_cpu_subsystem.dmi_haddr",     "pldm_dmi_haddr");
//         &CONNECT("ae350_cpu_subsystem.dmi_hburst",    "pldm_dmi_hburst");
//         &CONNECT("ae350_cpu_subsystem.dmi_hprot",     "pldm_dmi_hprot");
//         &CONNECT("ae350_cpu_subsystem.dmi_hrdata",    "pldm_dmi_hrdata");
//         &CONNECT("ae350_cpu_subsystem.dmi_hready",    "pldm_dmi_hready");
//         &CONNECT("ae350_cpu_subsystem.dmi_hreadyout", "pldm_dmi_hreadyout");
//         &CONNECT("ae350_cpu_subsystem.dmi_hresp",     "pldm_dmi_hresp");
//         &CONNECT("ae350_cpu_subsystem.dmi_hsel",      "pldm_dmi_hsel");
//         &CONNECT("ae350_cpu_subsystem.dmi_hsize",     "pldm_dmi_hsize");
//         &CONNECT("ae350_cpu_subsystem.dmi_htrans",    "pldm_dmi_htrans");
//         &CONNECT("ae350_cpu_subsystem.dmi_hwdata",    "pldm_dmi_hwdata");
//         &CONNECT("ae350_cpu_subsystem.dmi_hwrite",    "pldm_dmi_hwrite");
//         &CONNECT("ae350_cpu_subsystem.dmi_resetn",    "pldm_dmi_resetn");
// &ENDIF("PLATFORM_DEBUG_SUBSYSTEM");
//
// &IFDEF("NDS_IO_TRACE_INSTR");
//         # used by trace_itype ilastsize trace_iaddr, and their presence is indepdent of PLATFORM_DEBUG_SUBSYSTEM.
//         # these parameters are also used by instantiation of ncetrace200, which uses them indepdent of NDS_NHART.
//         &LOCALPARAM("NUM_INST_BLK = 1");
//         &LOCALPARAM("TRACE_TRIGGER_WIDTH = 3");
//         &LOCALPARAM("TRACE_PRIV_WIDTH = 2");
//         for (my $i = 0; $i < 8; ++$i) {
//                &LOCALPARAM("HART${i}_VALEN = VALEN");
//                &LOCALPARAM("HART${i}_NUM_INST_BLK = NUM_INST_BLK");
//                &LOCALPARAM("HART${i}_TRACE_TRIGGER_WIDTH = TRACE_TRIGGER_WIDTH");
//                &LOCALPARAM("HART${i}_TRACE_PRIV_WIDTH = TRACE_PRIV_WIDTH");
//         }
// &ENDIF("NDS_IO_TRACE_INSTR");
//
// &IFDEF("PLATFORM_DEBUG_SUBSYSTEM");
// &IFDEF("NDS_IO_TRACE_INSTR");
//
//         &PARAM("TRACE_USFIFO_SIZE = 8");
//         &PARAM("TRACE_USFIFO_STALL_THRESHOLD = 3");
//         &PARAM("TB_RAM_SIZE  = 4");
//         &PARAM("TB_RAM_CTRL_IN_WIDTH  = 1");
//         &PARAM("TB_RAM_CTRL_OUT_WIDTH = 1");
//         &PARAM("NCETRACE200_HARTID0 = 0");
//         &IFDEF("PLATFORM_TRACE_TO_SMEM");
//                 &PARAM("TBUF_SMEM_SUPPORT = 1");
//         &ELSE("PLATFORM_TRACE_TO_SMEM");
//                 &PARAM("TBUF_SMEM_SUPPORT = 0");
//         &ENDIF("PLATFORM_TRACE_TO_SMEM");
//         &PARAM("TBUF_SMEM_NWRITE = 8");
//         &INSTANCE("$PVC_LOCALDIR/andes_ip/ncetrace200/hdl/ncetrace200_ahb_top.v", "ncetrace200", {
//                 NSOURCE                => NHART,
//                 HART0_VALEN            => HART0_VALEN,
//                 HART1_VALEN            => HART1_VALEN,
//                 HART2_VALEN            => HART2_VALEN,
//                 HART3_VALEN            => HART3_VALEN,
//                 HART4_VALEN            => HART4_VALEN,
//                 HART5_VALEN            => HART5_VALEN,
//                 HART6_VALEN            => HART6_VALEN,
//                 HART7_VALEN            => HART7_VALEN,
//                 HART0_NUM_INST_BLK     => HART0_NUM_INST_BLK,
//                 HART1_NUM_INST_BLK     => HART1_NUM_INST_BLK,
//                 HART2_NUM_INST_BLK     => HART2_NUM_INST_BLK,
//                 HART3_NUM_INST_BLK     => HART3_NUM_INST_BLK,
//                 HART4_NUM_INST_BLK     => HART4_NUM_INST_BLK,
//                 HART5_NUM_INST_BLK     => HART5_NUM_INST_BLK,
//                 HART6_NUM_INST_BLK     => HART6_NUM_INST_BLK,
//                 HART7_NUM_INST_BLK     => HART7_NUM_INST_BLK,
//                 HART0_TRACE_TRIGGER_WIDTH  => HART0_TRACE_TRIGGER_WIDTH,
//                 HART1_TRACE_TRIGGER_WIDTH  => HART1_TRACE_TRIGGER_WIDTH,
//                 HART2_TRACE_TRIGGER_WIDTH  => HART2_TRACE_TRIGGER_WIDTH,
//                 HART3_TRACE_TRIGGER_WIDTH  => HART3_TRACE_TRIGGER_WIDTH,
//                 HART4_TRACE_TRIGGER_WIDTH  => HART4_TRACE_TRIGGER_WIDTH,
//                 HART5_TRACE_TRIGGER_WIDTH  => HART5_TRACE_TRIGGER_WIDTH,
//                 HART6_TRACE_TRIGGER_WIDTH  => HART6_TRACE_TRIGGER_WIDTH,
//                 HART7_TRACE_TRIGGER_WIDTH  => HART7_TRACE_TRIGGER_WIDTH,
//                 HART0_TRACE_PRIV_WIDTH     => HART0_TRACE_PRIV_WIDTH,
//                 HART1_TRACE_PRIV_WIDTH     => HART1_TRACE_PRIV_WIDTH,
//                 HART2_TRACE_PRIV_WIDTH     => HART2_TRACE_PRIV_WIDTH,
//                 HART3_TRACE_PRIV_WIDTH     => HART3_TRACE_PRIV_WIDTH,
//                 HART4_TRACE_PRIV_WIDTH     => HART4_TRACE_PRIV_WIDTH,
//                 HART5_TRACE_PRIV_WIDTH     => HART5_TRACE_PRIV_WIDTH,
//                 HART6_TRACE_PRIV_WIDTH     => HART6_TRACE_PRIV_WIDTH,
//                 HART7_TRACE_PRIV_WIDTH     => HART7_TRACE_PRIV_WIDTH,
//                 USFIFO_SIZE            => TRACE_USFIFO_SIZE,
//                 USFIFO_STALL_THRESHOLD => TRACE_USFIFO_STALL_THRESHOLD,
//                 HARTID0                => NCETRACE200_HARTID0,
//                 TB_RAM_SIZE            => TB_RAM_SIZE,
//                 TB_RAM_CTRL_IN_WIDTH   => TB_RAM_CTRL_IN_WIDTH,
//                 TB_RAM_CTRL_OUT_WIDTH  => TB_RAM_CTRL_OUT_WIDTH,
//                 SYNC_STAGE             => SYNC_STAGE,
//                 TBUF_SMEM_SUPPORT       => TBUF_SMEM_SUPPORT, 
//                 TBUF_SMEM_NWRITE       => TBUF_SMEM_NWRITE,
//                 TBUF_SMEM_ADDR_WIDTH    => BIU_ADDR_WIDTH, 
//                 TBUF_SMEM_DATA_WIDTH    => CPUSUB_BIU_DATA_WIDTH,
//                 TBUF_SMEM_ID_WIDTH      => CPUSUB_BIU_ID_WIDTH,
//         });
//         &FORCE("wire", "dmi_clk");
//         &FORCE("wire", "atclk");
//         &FORCE("wire", "tbuf_sys_aclk");
//         &FORCE("wire", "tb_ram_ctrl_in[0:0]");
//         &FORCE("wire", "unused_tb_ram_ctrl_out[0:0]");
//         &FORCE("wire",     "tbuf_sys_arready");
//         &FORCE("wire",     "tbuf_sys_awready");
//         &FORCE("wire",     "tbuf_sys_bid[(CPUSUB_BIU_ID_WIDTH-1):0]");
//         &FORCE("wire",     "tbuf_sys_bresp[1:0]");
//         &FORCE("wire",     "tbuf_sys_bvalid");
//         &FORCE("wire",     "tbuf_sys_rdata[(CPUSUB_BIU_DATA_WIDTH-1):0]");
//         &FORCE("wire",     "tbuf_sys_rid[(CPUSUB_BIU_ID_WIDTH-1):0]");
//         &FORCE("wire",     "tbuf_sys_rlast");
//         &FORCE("wire",     "tbuf_sys_rresp[1:0]");
//         &FORCE("wire",     "tbuf_sys_rvalid");
//         &FORCE("wire",     "tbuf_sys_wready");
//         &FORCE("wire",     "tbuf_sys_araddr[(BIU_ADDR_WIDTH-1):0]");
//         &FORCE("wire",     "tbuf_sys_arburst[1:0]");
//         &FORCE("wire",     "tbuf_sys_arcache[3:0]");
//         &FORCE("wire",     "tbuf_sys_arid[(CPUSUB_BIU_ID_WIDTH-1):0]");
//         &FORCE("wire",     "tbuf_sys_arlen[7:0]");
//         &FORCE("wire",     "tbuf_sys_arlock");
//         &FORCE("wire",     "tbuf_sys_arprot[2:0]");
//         &FORCE("wire",     "tbuf_sys_arsize[2:0]");
//         &FORCE("wire",     "tbuf_sys_arvalid");
//         &FORCE("wire",     "tbuf_sys_awaddr[(BIU_ADDR_WIDTH-1):0]");
//         &FORCE("wire",     "tbuf_sys_awburst[1:0]");
//         &FORCE("wire",     "tbuf_sys_awcache[3:0]");
//         &FORCE("wire",     "tbuf_sys_awid[(CPUSUB_BIU_ID_WIDTH-1):0]");
//         &FORCE("wire",     "tbuf_sys_awlen[7:0]");
//         &FORCE("wire",     "tbuf_sys_awlock");
//         &FORCE("wire",     "tbuf_sys_awprot[2:0]");
//         &FORCE("wire",     "tbuf_sys_awsize[2:0]");
//         &FORCE("wire",     "tbuf_sys_awvalid");
//         &FORCE("wire",     "tbuf_sys_bready");
//         &FORCE("wire",     "tbuf_sys_rready");
//         &FORCE("wire",     "tbuf_sys_wdata[(CPUSUB_BIU_DATA_WIDTH-1):0]");
//         &FORCE("wire",     "tbuf_sys_wlast");
//         &FORCE("wire",     "tbuf_sys_wstrb[((CPUSUB_BIU_DATA_WIDTH/8)-1):0]");
//         &FORCE("wire",     "tbuf_sys_wvalid");
//         &CONNECT("ncetrace200.tb_ram_ctrl_out", "unused_tb_ram_ctrl_out");
//
//         &CONNECT("ncetrace200.sys_arready" , "tbuf_sys_arready" );
//         &CONNECT("ncetrace200.sys_awready" , "tbuf_sys_awready" );
//         &CONNECT("ncetrace200.sys_bid"     , "tbuf_sys_bid"     );
//         &CONNECT("ncetrace200.sys_bresp"   , "tbuf_sys_bresp"   );
//         &CONNECT("ncetrace200.sys_bvalid"  , "tbuf_sys_bvalid"  );
//         &CONNECT("ncetrace200.sys_rdata"   , "tbuf_sys_rdata"   );
//         &CONNECT("ncetrace200.sys_rid"     , "tbuf_sys_rid"     );
//         &CONNECT("ncetrace200.sys_rlast"   , "tbuf_sys_rlast"   );
//         &CONNECT("ncetrace200.sys_rresp"   , "tbuf_sys_rresp"   );
//         &CONNECT("ncetrace200.sys_rvalid"  , "tbuf_sys_rvalid"  );
//         &CONNECT("ncetrace200.sys_wready"  , "tbuf_sys_wready"  );
//         &CONNECT("ncetrace200.sys_araddr"  , "tbuf_sys_araddr"  );
//         &CONNECT("ncetrace200.sys_arburst" , "tbuf_sys_arburst" );
//         &CONNECT("ncetrace200.sys_arcache" , "tbuf_sys_arcache" );
//         &CONNECT("ncetrace200.sys_arid"    , "tbuf_sys_arid"    );
//         &CONNECT("ncetrace200.sys_arlen"   , "tbuf_sys_arlen"   );
//         &CONNECT("ncetrace200.sys_arlock"  , "tbuf_sys_arlock"  );
//         &CONNECT("ncetrace200.sys_arprot"  , "tbuf_sys_arprot"  );
//         &CONNECT("ncetrace200.sys_arsize"  , "tbuf_sys_arsize"  );
//         &CONNECT("ncetrace200.sys_arvalid" , "tbuf_sys_arvalid" );
//         &CONNECT("ncetrace200.sys_awaddr"  , "tbuf_sys_awaddr"  );
//         &CONNECT("ncetrace200.sys_awburst" , "tbuf_sys_awburst" );
//         &CONNECT("ncetrace200.sys_awcache" , "tbuf_sys_awcache" );
//         &CONNECT("ncetrace200.sys_awid"    , "tbuf_sys_awid"    );
//         &CONNECT("ncetrace200.sys_awlen"   , "tbuf_sys_awlen"   );
//         &CONNECT("ncetrace200.sys_awlock" ,  "tbuf_sys_awlock");
//         &CONNECT("ncetrace200.sys_awprot" ,  "tbuf_sys_awprot");
//         &CONNECT("ncetrace200.sys_awsize" ,  "tbuf_sys_awsize");
//         &CONNECT("ncetrace200.sys_awvalid",  "tbuf_sys_awvalid");
//         &CONNECT("ncetrace200.sys_bready" ,  "tbuf_sys_bready");
//         &CONNECT("ncetrace200.sys_rready" ,  "tbuf_sys_rready");
//         &CONNECT("ncetrace200.sys_wdata"  ,  "tbuf_sys_wdata" );
//         &CONNECT("ncetrace200.sys_wlast"  ,  "tbuf_sys_wlast" );
//         &CONNECT("ncetrace200.sys_wstrb"  ,  "tbuf_sys_wstrb" );
//         &CONNECT("ncetrace200.sys_wvalid" ,  "tbuf_sys_wvalid");
// &ENDIF("NDS_IO_TRACE_INSTR");
// &ELSE("PLATFORM_DEBUG_SUBSYSTEM");
//         &PARAM("TB_RAM_SIZE  = 0");
// &ENDIF("PLATFORM_DEBUG_SUBSYSTEM");
//
//
//         :`ifdef PLATFORM_DEBUG_SUBSYSTEM
//         :	`ifdef NDS_IO_TRACE_INSTR
//         :		`ifdef NDS_NHART
//         :		            assign dmi_clk = aclk;
//         :		            assign atclk   = aclk;
//         :		            assign tbuf_sys_aclk = aclk;
//         :		`else
//         :		    `ifdef NDS_IO_AHB
//         :		            assign dmi_clk = hclk;
//         :		            assign atclk   = hclk;
//         :		            assign tbuf_sys_aclk = 1'b0;
//         :		    `else
//         :		            assign dmi_clk = aclk;
//         :		            assign atclk   = aclk;
//         :		            assign tbuf_sys_aclk = aclk;
//         :		    `endif
//         :		`endif // NDS_NHART
//         :            assign tb_ram_ctrl_in = 1'b0;
//         :	`endif // NDS_IO_TRACE_INSTR
//         :`endif // PLATFORM_DEBUG_SUBSYSTEM

// &CONNECT("ncetrace200.auth_dbgen",       "1'b1");
// &CONNECT("ncetrace200.auth_niden",       "1'b1");
// &CONNECT("ncetrace200.auth_spiden",      "1'b1");
// &CONNECT("ncetrace200.auth_spniden",     "1'b1");
// &CONNECT("ncetrace200.auth_hiden",       "1'b1");
// &CONNECT("ncetrace200.auth_hniden",      "1'b1");
// &CONNECT("ncetrace200.sys_aclk",         "tbuf_sys_aclk");
// &CONNECT("ncetrace200.dmi_clk",          "dmi_clk");
// &CONNECT("ncetrace200.dmi_resetn",       "dmi_resetn");
// &CONNECT("ncetrace200.atresetn",         "dmi_resetn");
// &CONNECT("ncetrace200.sys_aresetn",      "aresetn");
// &CONNECT("ncetrace200.dmi_hmastlock",    "1'b0");	# unused
//
// &CONNECT("ncetrace200.pldm_dmi_clk",    "dmi_clk");
// &CONNECT("ncetrace200.test_mode",       "test_mode");
// &CONNECT("ncetrace200.test_resetn",     "test_rstn");
//
// &IFDEF("PLATFORM_DEBUG_SUBSYSTEM");
// &IFDEF("NDS_IO_TRACE_INSTR");
//         &FORCE("wire", "te_reset_n[(NHART-1):0]");
//         for (my $hart = 0; $hart < 4; $hart++) {
//                 &IFDEF_HART($hart, "NDS_NHART", "NDS_IO_HART$hart");
//                         &FORCE("wire", "hart${hart}_trace_stall");
//                         &FORCE("wire", "hart${hart}_trace_secure");
//                         &FORCE("wire", "hart${hart}_trace_ctype");
//                         &FORCE("wire", "hart${hart}_trace_context");
//                         &FORCE("wire", "hart${hart}_power_down");
//
//                         &FORCE("wire", "hart${hart}_trace_iaddr[(VALEN*HART${hart}_NUM_INST_BLK-1):0]");
//                         &FORCE("wire", "hart${hart}_trace_ilastsize[(HART${hart}_NUM_INST_BLK-1):0]");
//                         &FORCE("wire", "hart${hart}_trace_iretire[(2*HART${hart}_NUM_INST_BLK-1):0]");
//                         &FORCE("wire", "hart${hart}_trace_itype[(4*HART${hart}_NUM_INST_BLK-1):0]");
//                         &FORCE("wire", "hart${hart}_trace_trigger[(HART${hart}_TRACE_TRIGGER_WIDTH-1):0]");
//                         &FORCE("wire", "hart${hart}_trace_priv[(HART${hart}_TRACE_PRIV_WIDTH-1):0]");
//
//                         &CONNECT("ncetrace200.hart${hart}_te_clk",         "te_clk[$hart]");
//                         &CONNECT("ncetrace200.hart${hart}_te_reset_n",     "te_reset_n[$hart]");
//                         &CONNECT("ncetrace200.hart${hart}_trace_enabled",    "hart${hart}_trace_enabled");
//                         &CONNECT("ncetrace200.hart${hart}_trace_itype",      "hart${hart}_trace_itype");
//                         &CONNECT("ncetrace200.hart${hart}_trace_halted",     "hart${hart}_trace_halted");
//                         &CONNECT("ncetrace200.hart${hart}_trace_priv",       "hart${hart}_trace_priv");
//                         &CONNECT("ncetrace200.hart${hart}_trace_iaddr",      "hart${hart}_trace_iaddr");
//                         &CONNECT("ncetrace200.hart${hart}_trace_iretire",    "hart${hart}_trace_iretire");
//                         &CONNECT("ncetrace200.hart${hart}_trace_ilastsize",  "hart${hart}_trace_ilastsize");
//                         &CONNECT("ncetrace200.hart${hart}_trace_cause",      "hart${hart}_trace_cause");
//                         &CONNECT("ncetrace200.hart${hart}_trace_tval",       "hart${hart}_trace_tval");
//                         &CONNECT("ncetrace200.hart${hart}_trace_secure",     "hart${hart}_trace_secure");
//                         &CONNECT("ncetrace200.hart${hart}_trace_stall",      "hart${hart}_trace_stall");
//                         &CONNECT("ncetrace200.hart${hart}_trace_trigger",    "hart${hart}_trace_trigger");
//                         &CONNECT("ncetrace200.hart${hart}_trace_ctype",      "hart${hart}_trace_ctype");
//                         &CONNECT("ncetrace200.hart${hart}_trace_context",    "hart${hart}_trace_context");
//                         &CONNECT("ncetrace200.hart${hart}_trace_reset",      "hart${hart}_trace_reset");
//                         &CONNECT("ncetrace200.hart${hart}_power_down",       "hart${hart}_power_down");
//                 &ENDIF_HART($hart, "NDS_NHART", "NDS_IO_HART$hart");
//         }
//         for (my $hart = 4; $hart < 8; $hart++) {
//                 &CONNECT("ncetrace200.hart${hart}_te_clk",           "1'b0");
//                 &CONNECT("ncetrace200.hart${hart}_te_reset_n",       "1'b0");
//                 &CONNECT("ncetrace200.hart${hart}_trace_enabled",    "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_itype",      "4'd0");
//                 &CONNECT("ncetrace200.hart${hart}_trace_halted",     "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_priv",       "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_iaddr",      "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_iretire",    "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_ilastsize",  "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_cause",      "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_tval",       "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_secure",     "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_stall",      "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_trigger",    "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_ctype",      "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_context",    "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_trace_reset",      "/*NC*/");
//                 &CONNECT("ncetrace200.hart${hart}_power_down",       "/*NC*/");
//         }
// &ENDIF("NDS_IO_TRACE_INSTR");
// &ENDIF("PLATFORM_DEBUG_SUBSYSTEM");
//
// :`ifdef PLATFORM_DEBUG_SUBSYSTEM
// :        `ifndef NDS_IO_TRACE_INSTR
// :                assign pldm_dmi_haddr      = dmi_haddr[8:0];
// :                assign pldm_dmi_hburst     = dmi_hburst;
// :                assign pldm_dmi_hprot      = dmi_hprot;
// :                assign pldm_dmi_hready     = pldm_dmi_hreadyout;
// :                assign pldm_dmi_hsel       = dmi_hsel;
// :                assign pldm_dmi_hsize      = dmi_hsize;
// :                assign pldm_dmi_htrans     = dmi_htrans;
// :                assign pldm_dmi_hwdata     = dmi_hwdata;
// :                assign pldm_dmi_hwrite     = dmi_hwrite;
// :                assign pldm_dmi_resetn     = dmi_resetn;
// :
// :                assign dmi_hrdata          = pldm_dmi_hrdata;
// :                assign dmi_hready          = pldm_dmi_hreadyout;
// :                assign dmi_hresp           = pldm_dmi_hresp;
// :        `endif // NDS_IO_TRACE_INSTR
// :`endif // PLATFORM_DEBUG_SUBSYSTEM
//
// :`ifndef AE350_AXI_SUPPORT 
// : 	`ifdef PLATFORM_DEBUG_SUBSYSTEM
// : 	`ifdef NDS_IO_TRACE_INSTR
// :	    assign tbuf_sys_arready	=  1'b0; 
// :	    assign tbuf_sys_awready	=  1'b0; 
// :	    assign tbuf_sys_bid		=  {CPUSUB_BIU_ID_WIDTH{1'b0}};
// :	    assign tbuf_sys_bresp	=  2'd0; 
// :	    assign tbuf_sys_bvalid	=  1'b0; 
// :	    assign tbuf_sys_rdata	=  {CPUSUB_BIU_DATA_WIDTH{1'b0}};
// :	    assign tbuf_sys_rid		=  {CPUSUB_BIU_ID_WIDTH{1'b0}};
// :	    assign tbuf_sys_rlast	=  1'b0;
// :	    assign tbuf_sys_rresp	=  2'd0;
// :	    assign tbuf_sys_rvalid	=  1'b0;
// :	    assign tbuf_sys_wready 	=  1'b0; 
// : 	`endif // NDS_IO_TRACE_INSTR
// :	`endif // PLATFORM_DEBUG_SUBSYSTEM
// :`endif // AE350_AXI_SUPPORT 
//
//
// &ENDMODULE
// VPERL_END

// VPERL_GENERATED_BEGIN
module ae350_chip (
`ifdef PLATFORM_DEBUG_PORT
	  X_tck,             // (ae350_aopd) <=> (ae350_aopd)
	  X_tms,             // (ae350_pin) <=> (ae350_pin)
`endif // PLATFORM_DEBUG_PORT
`ifdef AE350_MAC_SUPPORT
	  X_col,             // (ae350_pin) <=> (ae350_pin)
	  X_crs,             // (ae350_pin) <=> (ae350_pin)
	  X_mdc,             // (ae350_pin) <=> (ae350_pin)
	  X_mdio,            // (ae350_pin) <=> (ae350_pin)
	  X_pdn_phy,         // (ae350_pin) <=> (ae350_pin)
	  X_phy_linksts,     // (ae350_pin) <=> (ae350_pin)
	  X_rx_clk,          // (ae350_pin) <=> (ae350_pin)
	  X_rx_dv,           // (ae350_pin) <=> (ae350_pin)
	  X_rx_er,           // (ae350_pin) <=> (ae350_pin)
	  X_rxd,             // (ae350_pin) <=> (ae350_pin)
	  X_tx_clk,          // (ae350_pin) <=> (ae350_pin)
	  X_tx_en,           // (ae350_pin) <=> (ae350_pin)
	  X_txd,             // (ae350_pin) <=> (ae350_pin)
`endif // AE350_MAC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
	  X_clac,            // (ae350_pin) <=> (ae350_pin)
	  X_clcp,            // (ae350_pin) <=> (ae350_pin)
	  X_cld,             // (ae350_pin) <=> (ae350_pin)
	  X_clfp,            // (ae350_pin) <=> (ae350_pin)
	  X_clle,            // (ae350_pin) <=> (ae350_pin)
	  X_cllp,            // (ae350_pin) <=> (ae350_pin)
	  X_clpower,         // (ae350_pin) <=> (ae350_pin)
`endif // AE350_LCDC_SUPPORT
`ifdef AE350_SMC_SUPPORT
	  X_memaddr,         // (ae350_pin) <=> (ae350_pin)
	  X_smc_cs_b,        // (ae350_pin) <=> (ae350_pin)
	  X_smc_oe_b,        // (ae350_pin) <=> (ae350_pin)
	  X_smc_we_b,        // (ae350_pin) <=> (ae350_pin)
`endif // AE350_SMC_SUPPORT
`ifdef NDS_FPGA
`else
	  X_aopd_por_b,      // (ae350_aopd) <=> (ae350_aopd)
	  X_mpd_pwr_off,     // (ae350_aopd) <=> (ae350_aopd)
	  X_om,              // (ae350_aopd) <=> (ae350_aopd)
	  X_osclio,          // (ae350_aopd) <=> (ae350_aopd)
	  X_oschio,          // (ae350_pin) <=> (ae350_pin)
`endif // NDS_FPGA
`ifdef AE350_SPI1_SUPPORT
	  X_spi1_clk,        // (ae350_pin) <=> (ae350_pin)
	  X_spi1_csn,        // (ae350_pin) <=> (ae350_pin)
	  X_spi1_miso,       // (ae350_pin) <=> (ae350_pin)
	  X_spi1_mosi,       // (ae350_pin) <=> (ae350_pin)
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI3_SUPPORT
	  X_spi3_clk,        // (ae350_pin) <=> (ae350_pin)
	  X_spi3_csn,        // (ae350_pin) <=> (ae350_pin)
	  X_spi3_miso,       // (ae350_pin) <=> (ae350_pin)
	  X_spi3_mosi,       // (ae350_pin) <=> (ae350_pin)
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
	  X_spi4_clk,        // (ae350_pin) <=> (ae350_pin)
	  X_spi4_csn,        // (ae350_pin) <=> (ae350_pin)
	  X_spi4_miso,       // (ae350_pin) <=> (ae350_pin)
	  X_spi4_mosi,       // (ae350_pin) <=> (ae350_pin)
`endif // AE350_SPI4_SUPPORT
`ifdef AE350_SDC_SUPPORT
	  X_sd_cd,           // (ae350_pin) <=> (ae350_pin)
	  X_sd_clk,          // (ae350_pin) <=> (ae350_pin)
	  X_sd_cmd_rsp,      // (ae350_pin) <=> (ae350_pin)
	  X_sd_dat0,         // (ae350_pin) <=> (ae350_pin)
	  X_sd_dat1,         // (ae350_pin) <=> (ae350_pin)
	  X_sd_dat2,         // (ae350_pin) <=> (ae350_pin)
	  X_sd_dat3,         // (ae350_pin) <=> (ae350_pin)
	  X_sd_power_on,     // (ae350_pin) <=> (ae350_pin)
	  X_sd_wp,           // (ae350_pin) <=> (ae350_pin)
`endif // AE350_SDC_SUPPORT
`ifdef AE350_SSP_SUPPORT
	  X_ssp_ac97_resetn, // (ae350_pin) <=> (ae350_pin)
	  X_ssp_fs,          // (ae350_pin) <=> (ae350_pin)
	  X_ssp_rxd,         // (ae350_pin) <=> (ae350_pin)
	  X_ssp_sclk,        // (ae350_pin) <=> (ae350_pin)
	  X_ssp_txd,         // (ae350_pin) <=> (ae350_pin)
`endif // AE350_SSP_SUPPORT
`ifdef AE350_K7DDR3_SUPPORT
	  X_ddr3_addr,       // (ae350_ram_subsystem) => ()
	  X_ddr3_ba,         // (ae350_ram_subsystem) => ()
	  X_ddr3_cas_n,      // (ae350_ram_subsystem) => ()
	  X_ddr3_ck_n,       // (ae350_ram_subsystem) => ()
	  X_ddr3_ck_p,       // (ae350_ram_subsystem) => ()
	  X_ddr3_cke,        // (ae350_ram_subsystem) => ()
	  X_ddr3_cs_n,       // (ae350_ram_subsystem) => ()
	  X_ddr3_dm,         // (ae350_ram_subsystem) => ()
	  X_ddr3_dq,         // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
	  X_ddr3_dqs_n,      // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
	  X_ddr3_dqs_p,      // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
	  X_ddr3_odt,        // (ae350_ram_subsystem) => ()
	  X_ddr3_ras_n,      // (ae350_ram_subsystem) => ()
	  X_ddr3_reset_n,    // (ae350_ram_subsystem) => ()
	  X_ddr3_sys_clk_n,  // (ae350_ram_subsystem) <= ()
	  X_ddr3_sys_clk_p,  // (ae350_ram_subsystem) <= ()
	  X_ddr3_we_n,       // (ae350_ram_subsystem) => ()
`endif // AE350_K7DDR3_SUPPORT
`ifdef AE350_VUDDR4_SUPPORT
	  X_ddr4_dm_dbi_n,   // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
	  X_ddr4_dq,         // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
	  X_ddr4_dqs_c,      // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
	  X_ddr4_dqs_t,      // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
`endif // AE350_VUDDR4_SUPPORT
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
	  X_tdi,             // (ae350_pin) <=> (ae350_pin)
	  X_tdo,             // (ae350_pin) <=> (ae350_pin)
	  X_trst,            // (ae350_pin) <=> (ae350_pin)
   `endif // PLATFORM_JTAG_TWOWIRE
   `ifdef PLATFORM_JDTM_SECURE_SUPPORT
	  X_secure_mode,     // (ae350_pin) <=> (ae350_pin)
   `endif // PLATFORM_JDTM_SECURE_SUPPORT
`endif // PLATFORM_DEBUG_PORT
`ifdef AE350_SMC_SUPPORT
   `ifdef NDS_FPGA
	  X_memdata,         // (ae350_pin) <=> (ae350_pin)
   `else
	  X_memdata,         // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_FPGA
`endif // AE350_SMC_SUPPORT
`ifdef NDS_FPGA
`else
   `ifdef AE350_RTC_SUPPORT
	  X_rtc_wakeup,      // (ae350_aopd) <=> (ae350_aopd)
   `endif // AE350_RTC_SUPPORT
   `ifdef AE350_UART1_SUPPORT
	  X_uart1_dcdn,      // (ae350_pin) <=> (ae350_pin)
	  X_uart1_dsrn,      // (ae350_pin) <=> (ae350_pin)
	  X_uart1_dtrn,      // (ae350_pin) <=> (ae350_pin)
	  X_uart1_out1n,     // (ae350_pin) <=> (ae350_pin)
	  X_uart1_out2n,     // (ae350_pin) <=> (ae350_pin)
	  X_uart1_rin,       // (ae350_pin) <=> (ae350_pin)
   `endif // AE350_UART1_SUPPORT
`endif // NDS_FPGA
`ifdef AE350_UART1_SUPPORT
   `ifdef AE350_UART2_SUPPORT
   `else
	  X_uart1_ctsn,      // (ae350_pin) <=> (ae350_pin)
	  X_uart1_rtsn,      // (ae350_pin) <=> (ae350_pin)
   `endif // AE350_UART2_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
	  X_uart1_rxd,       // (ae350_pin) <=> (ae350_pin)
	  X_uart1_txd,       // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_CF1
`endif // AE350_UART1_SUPPORT
`ifdef NDS_FPGA
`else
   `ifdef AE350_UART2_SUPPORT
	  X_uart2_ctsn,      // (ae350_pin) <=> (ae350_pin)
	  X_uart2_dcdn,      // (ae350_pin) <=> (ae350_pin)
	  X_uart2_dsrn,      // (ae350_pin) <=> (ae350_pin)
	  X_uart2_dtrn,      // (ae350_pin) <=> (ae350_pin)
	  X_uart2_out1n,     // (ae350_pin) <=> (ae350_pin)
	  X_uart2_out2n,     // (ae350_pin) <=> (ae350_pin)
	  X_uart2_rin,       // (ae350_pin) <=> (ae350_pin)
	  X_uart2_rtsn,      // (ae350_pin) <=> (ae350_pin)
   `endif // AE350_UART2_SUPPORT
`endif // NDS_FPGA
`ifdef AE350_UART2_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
	  X_uart2_rxd,       // (ae350_pin) <=> (ae350_pin)
	  X_uart2_txd,       // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_CF1
`endif // AE350_UART2_SUPPORT
`ifdef AE350_PIT_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
	  X_pwm_ch0,         // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_CF1
`endif // AE350_PIT_SUPPORT
`ifdef AE350_GPIO_SUPPORT
   `ifdef NDS_BOARD_CF1
	  X_gpio,            // (ae350_pin) <=> (ae350_pin)
   `else
	  X_gpio,            // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_CF1
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_I2C_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
	  X_i2c_scl,         // (ae350_pin) <=> (ae350_pin)
	  X_i2c_sda,         // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_CF1
`endif // AE350_I2C_SUPPORT
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi1_holdn,      // (ae350_pin) <=> (ae350_pin)
	  X_spi1_wpn,        // (ae350_pin) <=> (ae350_pin)
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi2_holdn,      // (ae350_pin) <=> (ae350_pin)
	  X_spi2_wpn,        // (ae350_pin) <=> (ae350_pin)
   `endif // ATCSPI200_QUADSPI_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
	  X_spi2_clk,        // (ae350_pin) <=> (ae350_pin)
	  X_spi2_csn,        // (ae350_pin) <=> (ae350_pin)
	  X_spi2_miso,       // (ae350_pin) <=> (ae350_pin)
	  X_spi2_mosi,       // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_CF1
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi3_holdn,      // (ae350_pin) <=> (ae350_pin)
	  X_spi3_wpn,        // (ae350_pin) <=> (ae350_pin)
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi4_holdn,      // (ae350_pin) <=> (ae350_pin)
	  X_spi4_wpn,        // (ae350_pin) <=> (ae350_pin)
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI4_SUPPORT
`ifdef NDS_FPGA
   `ifdef NDS_BOARD_ORCA
	  X_flash_dir,       // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_ORCA
`else
   `ifdef AE350_UART1_SUPPORT
      `ifdef AE350_UART2_SUPPORT
	  X_uart1_ctsn,      // (ae350_pin) <=> (ae350_pin)
	  X_uart1_rtsn,      // (ae350_pin) <=> (ae350_pin)
      `endif // AE350_UART2_SUPPORT
   `endif // AE350_UART1_SUPPORT
`endif // NDS_FPGA
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
      `ifdef NDS_BOARD_CF1
      `else
	  X_pwm_ch1,         // (ae350_pin) <=> (ae350_pin)
      `endif // NDS_BOARD_CF1
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
      `ifdef NDS_BOARD_CF1
      `else
	  X_pwm_ch2,         // (ae350_pin) <=> (ae350_pin)
      `endif // NDS_BOARD_CF1
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
      `ifdef NDS_BOARD_CF1
      `else
	  X_pwm_ch3,         // (ae350_pin) <=> (ae350_pin)
      `endif // NDS_BOARD_CF1
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT_SUPPORT
`ifdef AE350_AXI_SUPPORT
   `ifdef NDS_FPGA
      `ifdef PLATFORM_NO_RAM_SUBSYSTEM
      `else
         `ifdef AE350_K7DDR3_SUPPORT
         `else
            `ifdef AE350_VUDDR4_SUPPORT
	  X_ddr4_act_n,      // (ae350_ram_subsystem) => ()
	  X_ddr4_addr,       // (ae350_ram_subsystem) => ()
	  X_ddr4_ba,         // (ae350_ram_subsystem) => ()
	  X_ddr4_bg,         // (ae350_ram_subsystem) => ()
	  X_ddr4_ck_c,       // (ae350_ram_subsystem) => ()
	  X_ddr4_ck_t,       // (ae350_ram_subsystem) => ()
	  X_ddr4_cke,        // (ae350_ram_subsystem) => ()
	  X_ddr4_cs_n,       // (ae350_ram_subsystem) => ()
	  X_ddr4_odt,        // (ae350_ram_subsystem) => ()
	  X_ddr4_reset_n,    // (ae350_ram_subsystem) => ()
	  X_ddr4_sys_clk_n,  // (ae350_ram_subsystem) <= ()
	  X_ddr4_sys_clk_p,  // (ae350_ram_subsystem) <= ()
            `endif // AE350_VUDDR4_SUPPORT
         `endif // AE350_K7DDR3_SUPPORT
      `endif // PLATFORM_NO_RAM_SUBSYSTEM
   `else
      `ifdef PLATFORM_NO_RAM_SUBSYSTEM
      `else
         `ifdef AE350_K7DDR3_SUPPORT
         `else
            `ifdef AE350_VUDDR4_SUPPORT
	  X_ddr4_act_n,      // (ae350_ram_subsystem) => ()
	  X_ddr4_addr,       // (ae350_ram_subsystem) => ()
	  X_ddr4_ba,         // (ae350_ram_subsystem) => ()
	  X_ddr4_bg,         // (ae350_ram_subsystem) => ()
	  X_ddr4_ck_c,       // (ae350_ram_subsystem) => ()
	  X_ddr4_ck_t,       // (ae350_ram_subsystem) => ()
	  X_ddr4_cke,        // (ae350_ram_subsystem) => ()
	  X_ddr4_cs_n,       // (ae350_ram_subsystem) => ()
	  X_ddr4_odt,        // (ae350_ram_subsystem) => ()
	  X_ddr4_reset_n,    // (ae350_ram_subsystem) => ()
	  X_ddr4_sys_clk_n,  // (ae350_ram_subsystem) <= ()
	  X_ddr4_sys_clk_p,  // (ae350_ram_subsystem) <= ()
            `endif // AE350_VUDDR4_SUPPORT
         `endif // AE350_K7DDR3_SUPPORT
      `endif // PLATFORM_NO_RAM_SUBSYSTEM
   `endif // NDS_FPGA
`endif // AE350_AXI_SUPPORT
	  X_osclin,          // (ae350_aopd) <= ()
	  X_wakeup_in,       // (ae350_aopd) <=> (ae350_aopd)
	  X_hw_rstn,         // (ae350_pin) <=> (ae350_pin)
	  X_oschin,          // (ae350_pin) <= ()
	  X_por_b            // (ae350_pin) <=> (ae350_pin)
);

parameter SIMULATION = "FALSE" ;
parameter SIM_BYPASS_INIT_CAL = "OFF" ;
`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef NDS_IO_TRACE_INSTR
parameter TRACE_USFIFO_SIZE = 8;
parameter TRACE_USFIFO_STALL_THRESHOLD = 3;
parameter TB_RAM_SIZE  = 4;
parameter TB_RAM_CTRL_IN_WIDTH  = 1;
parameter TB_RAM_CTRL_OUT_WIDTH = 1;
parameter NCETRACE200_HARTID0 = 0;
      `ifdef PLATFORM_TRACE_TO_SMEM
parameter TBUF_SMEM_SUPPORT = 1;
      `else
parameter TBUF_SMEM_SUPPORT = 0;
      `endif // PLATFORM_TRACE_TO_SMEM
parameter TBUF_SMEM_NWRITE = 8;
   `endif // NDS_IO_TRACE_INSTR
`else
parameter TB_RAM_SIZE  = 0;
`endif // PLATFORM_DEBUG_SUBSYSTEM

`ifdef NDS_NHART
localparam NHART                    = `NDS_NHART;
`else
localparam NHART                    = 1;
`endif // NDS_NHART
localparam PALEN			= `NDS_BIU_ADDR_WIDTH;
localparam BIU_ADDR_WIDTH		= `NDS_BIU_ADDR_WIDTH;
localparam BIU_ADDR_MSB		= BIU_ADDR_WIDTH - 1;
localparam ISA_BASE			= `NDS_ISA_BASE;
localparam XLEN			= ISA_BASE == "rv64i" ? 64 : 32;
localparam MMU_SCHEME			= `NDS_MMU_SCHEME;
localparam VALEN			= (MMU_SCHEME == "bare") ? PALEN : (MMU_SCHEME == "sv32") ? 32 : (MMU_SCHEME == "sv39") ? 39: 48;
`ifdef PLATFORM_FORCE_4GB_SPACE
localparam ADDR_WIDTH			= 32;
`else
localparam ADDR_WIDTH			= PALEN;
`endif // PLATFORM_FORCE_4GB_SPACE
localparam ADDR_MSB			= ADDR_WIDTH - 1;
localparam CPUCORE_BIU_ID_WIDTH	= `NDS_BIU_ID_WIDTH;
localparam CPUCORE_BIU_ID_MSB		= CPUCORE_BIU_ID_WIDTH - 1;
localparam CPUCORE_BIU_DATA_WIDTH	= `NDS_BIU_DATA_WIDTH;
localparam CPUCORE_BIU_DATA_MSB	= CPUCORE_BIU_DATA_WIDTH - 1;
localparam CPUCORE_BIU_WSTRB_WIDTH	= CPUCORE_BIU_DATA_WIDTH / 8;
localparam CPUCORE_BIU_WSTRB_MSB	= CPUCORE_BIU_WSTRB_WIDTH - 1;
localparam SNOOP_DISABLED		= `NDS_SNOOP_DISABLED;
`ifdef NDS_NHART
localparam CPUSUB_BIU_DATA_WIDTH	= `NDS_L2C_BIU_DATA_WIDTH;
localparam L2C_COHERENCE_PORT		= `NDS_L2C_COHERENCE_PORT;
localparam CPUSUB_BIU_ID_WIDTH	= ((L2C_COHERENCE_PORT=="no") && (NHART==1)) ? `NDS_BIU_ID_WIDTH : (`NDS_BIU_ID_WIDTH + 3);
localparam DMAC_DATA_WIDTH		= (L2C_COHERENCE_PORT=="yes") ? CPUCORE_BIU_DATA_WIDTH : CPUSUB_BIU_DATA_WIDTH;
localparam DMAC_ID_WIDTH		= (L2C_COHERENCE_PORT=="yes") ? CPUCORE_BIU_ID_WIDTH : CPUSUB_BIU_ID_WIDTH;
`else
localparam CPUSUB_BIU_DATA_WIDTH	= `NDS_BIU_DATA_WIDTH;
localparam CPUSUB_BIU_ID_WIDTH	= `NDS_BIU_ID_WIDTH;
localparam DMAC_DATA_WIDTH		= CPUSUB_BIU_DATA_WIDTH;
localparam DMAC_ID_WIDTH		= CPUSUB_BIU_ID_WIDTH;
`endif // NDS_NHART
localparam CPUSUB_BIU_ID_MSB		= CPUSUB_BIU_ID_WIDTH - 1;
localparam DMAC_WSTRB_WIDTH		= DMAC_DATA_WIDTH / 8;
localparam CPUSUB_BIU_DATA_MSB	= CPUSUB_BIU_DATA_WIDTH - 1;
localparam CPUSUB_BIU_WSTRB_WIDTH	= CPUSUB_BIU_DATA_WIDTH / 8;
localparam CPUSUB_BIU_WSTRB_MSB	= CPUSUB_BIU_WSTRB_WIDTH - 1;
localparam SLVPORT_DATA_WIDTH		= `NDS_SLAVE_PORT_DATA_WIDTH;
localparam SLVPORT_DATA_MSB		= SLVPORT_DATA_WIDTH - 1;
localparam SLVPORT_WSTRB_WIDTH	= SLVPORT_DATA_WIDTH / 8;
localparam SLVPORT_WSTRB_MSB		= SLVPORT_WSTRB_WIDTH - 1;
`ifdef AE350_AXI_SUPPORT
localparam SYSTEM_BUS_TYPE		= "axi";
`else
localparam SYSTEM_BUS_TYPE		= "ahb";
`endif // AE350_AXI_SUPPORT
`ifdef AE350_AXI_SUPPORT
localparam ROMHBMC_DATA_WIDTH		= 32;
`else
localparam ROMHBMC_DATA_WIDTH		= CPUSUB_BIU_DATA_WIDTH;
`endif // AE350_AXI_SUPPORT
localparam SYNC_STAGE                 = `NDS_SYNC_STAGE;
localparam ROMHBMC_DATA_MSB		= ROMHBMC_DATA_WIDTH - 1;
`ifdef NDS_IO_L2C
   `ifdef AE350_AXI_MASTER_SUPPORT
localparam ATCMSTMUX300_ADDR_WIDTH = `ATCMSTMUX300_ADDR_WIDTH;
   `endif // AE350_AXI_MASTER_SUPPORT
`endif // NDS_IO_L2C
`ifdef NDS_ASP_DATA_WIDTH
localparam ASP_DATA_WIDTH		= `NDS_ASP_DATA_WIDTH;
localparam ASP_BWE_WIDTH  = ASP_DATA_WIDTH/8;
`endif // NDS_ASP_DATA_WIDTH
`ifdef ATCAPBBRG100_SLV_14
   `ifdef AE350_DTROM_SIZE_KB
localparam DTROM_SIZE_KB = `AE350_DTROM_SIZE_KB;
   `else
localparam DTROM_SIZE_KB = 8;
   `endif // AE350_DTROM_SIZE_KB
`endif // ATCAPBBRG100_SLV_14
`ifdef PLATFORM_JTAG_TWOWIRE
localparam DEBUG_INTERFACE        = "serial";
`else
localparam DEBUG_INTERFACE        = "jtag";
`endif // PLATFORM_JTAG_TWOWIRE
`ifdef PLATFORM_JTAG_TAP_NUM
localparam JTAG_TAP_NUM           = `PLATFORM_JTAG_TAP_NUM;
`else
localparam JTAG_TAP_NUM           = 1;
`endif // PLATFORM_JTAG_TAP_NUM
`ifdef PLATFORM_DM_TAP_ID
localparam DM_TAP_ID              = `PLATFORM_DM_TAP_ID;
`else
localparam DM_TAP_ID              = 0;
`endif // PLATFORM_DM_TAP_ID
`ifdef NDS_MULTI_JTAG_DEVICE
localparam JTAG_DEVICE_TAP_ID     = 1;
`endif // NDS_MULTI_JTAG_DEVICE
localparam DMAC_DATA_WIDTH_FIX = (DMAC_DATA_WIDTH == 512) ? 256 : DMAC_DATA_WIDTH;
`ifdef NDS_BOARD_CF1
localparam INT_NUM                  = 32;
`else
localparam INT_NUM                  = 31;
`endif // NDS_BOARD_CF1
`ifdef NDS_IO_TRACE_INSTR
localparam NUM_INST_BLK = 1;
localparam TRACE_TRIGGER_WIDTH = 3;
localparam TRACE_PRIV_WIDTH = 2;
localparam HART0_VALEN = VALEN;
localparam HART0_NUM_INST_BLK = NUM_INST_BLK;
localparam HART0_TRACE_TRIGGER_WIDTH = TRACE_TRIGGER_WIDTH;
localparam HART0_TRACE_PRIV_WIDTH = TRACE_PRIV_WIDTH;
localparam HART1_VALEN = VALEN;
localparam HART1_NUM_INST_BLK = NUM_INST_BLK;
localparam HART1_TRACE_TRIGGER_WIDTH = TRACE_TRIGGER_WIDTH;
localparam HART1_TRACE_PRIV_WIDTH = TRACE_PRIV_WIDTH;
localparam HART2_VALEN = VALEN;
localparam HART2_NUM_INST_BLK = NUM_INST_BLK;
localparam HART2_TRACE_TRIGGER_WIDTH = TRACE_TRIGGER_WIDTH;
localparam HART2_TRACE_PRIV_WIDTH = TRACE_PRIV_WIDTH;
localparam HART3_VALEN = VALEN;
localparam HART3_NUM_INST_BLK = NUM_INST_BLK;
localparam HART3_TRACE_TRIGGER_WIDTH = TRACE_TRIGGER_WIDTH;
localparam HART3_TRACE_PRIV_WIDTH = TRACE_PRIV_WIDTH;
localparam HART4_VALEN = VALEN;
localparam HART4_NUM_INST_BLK = NUM_INST_BLK;
localparam HART4_TRACE_TRIGGER_WIDTH = TRACE_TRIGGER_WIDTH;
localparam HART4_TRACE_PRIV_WIDTH = TRACE_PRIV_WIDTH;
localparam HART5_VALEN = VALEN;
localparam HART5_NUM_INST_BLK = NUM_INST_BLK;
localparam HART5_TRACE_TRIGGER_WIDTH = TRACE_TRIGGER_WIDTH;
localparam HART5_TRACE_PRIV_WIDTH = TRACE_PRIV_WIDTH;
localparam HART6_VALEN = VALEN;
localparam HART6_NUM_INST_BLK = NUM_INST_BLK;
localparam HART6_TRACE_TRIGGER_WIDTH = TRACE_TRIGGER_WIDTH;
localparam HART6_TRACE_PRIV_WIDTH = TRACE_PRIV_WIDTH;
localparam HART7_VALEN = VALEN;
localparam HART7_NUM_INST_BLK = NUM_INST_BLK;
localparam HART7_TRACE_TRIGGER_WIDTH = TRACE_TRIGGER_WIDTH;
localparam HART7_TRACE_PRIV_WIDTH = TRACE_PRIV_WIDTH;
`endif // NDS_IO_TRACE_INSTR

`ifdef PLATFORM_DEBUG_PORT
inout              X_tck;
inout              X_tms;
`endif // PLATFORM_DEBUG_PORT
`ifdef AE350_MAC_SUPPORT
inout              X_col;              // (I),   MII collision detected
inout              X_crs;              // (I),   MII carrier sense
inout              X_mdc;              // (O),   MII management data clock
inout              X_mdio;             // (IO),  MII management data input/output
inout              X_pdn_phy;          // (O),   This pin is used to power down PHY
inout              X_phy_linksts;      // (I),   PHY link status
inout              X_rx_clk;           // (I),   MII receive clock
inout              X_rx_dv;            // (I),   MII receive data valid
inout              X_rx_er;            // (I),   MII receive error
inout        [3:0] X_rxd;              // (I),   MII receive data
inout              X_tx_clk;           // (I),   MII transmit clock
inout              X_tx_en;            // (O),   MII transmit enable
inout        [3:0] X_txd;              // (O),   MII transmit data
`endif // AE350_MAC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
inout              X_clac;             // (O),   STN AC bias driver or TFT data enable output
inout              X_clcp;             // (O),   LCD panel clock
inout       [23:0] X_cld;              // (O),   LCD panel data
inout              X_clfp;             // (O),   Frame pulse(STN)/vertical syn. pulse(TFT)
inout              X_clle;             // (O),   Line end signal
inout              X_cllp;             // (O),   Line syn. pulse(STN)/horizontal syn. pulse(TFT)
inout              X_clpower;          // (O),   LCD panel power enable
`endif // AE350_LCDC_SUPPORT
`ifdef AE350_SMC_SUPPORT
inout       [24:0] X_memaddr;          // (IO),  Memory address bus
inout              X_smc_cs_b;         // (O),   Chip select
inout              X_smc_oe_b;         // (O),   Output enable
inout              X_smc_we_b;
`endif // AE350_SMC_SUPPORT
`ifdef NDS_FPGA
`else
inout              X_aopd_por_b;
inout              X_mpd_pwr_off;
inout              X_om;
inout              X_osclio;
inout              X_oschio;
`endif // NDS_FPGA
`ifdef AE350_SPI1_SUPPORT
inout              X_spi1_clk;
inout              X_spi1_csn;
inout              X_spi1_miso;
inout              X_spi1_mosi;
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI3_SUPPORT
inout              X_spi3_clk;
inout              X_spi3_csn;
inout              X_spi3_miso;
inout              X_spi3_mosi;
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
inout              X_spi4_clk;
inout              X_spi4_csn;
inout              X_spi4_miso;
inout              X_spi4_mosi;
`endif // AE350_SPI4_SUPPORT
`ifdef AE350_SDC_SUPPORT
inout              X_sd_cd;            // (I),   Card detect
inout              X_sd_clk;           // (O),   Clock
inout              X_sd_cmd_rsp;       // (IO),  Commands and responses
inout              X_sd_dat0;          // (IO),  Data line bit[0]
inout              X_sd_dat1;          // (IO),  Data line bit[1]
inout              X_sd_dat2;          // (IO),  Data line bit[2]
inout              X_sd_dat3;          // (IO),  Data line bit[3]
inout              X_sd_power_on;
inout              X_sd_wp;            // (I),   Card write protect
`endif // AE350_SDC_SUPPORT
`ifdef AE350_SSP_SUPPORT
inout              X_ssp_ac97_resetn;  // (O),   AC97 reset
inout              X_ssp_fs;           // (IO),  Frame/Sync
inout              X_ssp_rxd;          // (I),   Receive data
inout              X_ssp_sclk;         // (IO),  Serial clock
inout              X_ssp_txd;          // (O),   Transmit Data
`endif // AE350_SSP_SUPPORT
`ifdef AE350_K7DDR3_SUPPORT
output      [14:0] X_ddr3_addr;
output       [2:0] X_ddr3_ba;
output             X_ddr3_cas_n;
output       [0:0] X_ddr3_ck_n;
output       [0:0] X_ddr3_ck_p;
output       [0:0] X_ddr3_cke;
output       [0:0] X_ddr3_cs_n;
output       [3:0] X_ddr3_dm;
inout       [31:0] X_ddr3_dq;
inout        [3:0] X_ddr3_dqs_n;
inout        [3:0] X_ddr3_dqs_p;
output       [0:0] X_ddr3_odt;
output             X_ddr3_ras_n;
output             X_ddr3_reset_n;
input              X_ddr3_sys_clk_n;
input              X_ddr3_sys_clk_p;
output             X_ddr3_we_n;
`endif // AE350_K7DDR3_SUPPORT
`ifdef AE350_VUDDR4_SUPPORT
inout        [7:0] X_ddr4_dm_dbi_n;
inout       [63:0] X_ddr4_dq;
inout        [7:0] X_ddr4_dqs_c;
inout        [7:0] X_ddr4_dqs_t;
`endif // AE350_VUDDR4_SUPPORT
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
inout              X_tdi;
inout              X_tdo;
inout              X_trst;
   `endif // PLATFORM_JTAG_TWOWIRE
   `ifdef PLATFORM_JDTM_SECURE_SUPPORT
inout        [1:0] X_secure_mode;
   `endif // PLATFORM_JDTM_SECURE_SUPPORT
`endif // PLATFORM_DEBUG_PORT
`ifdef AE350_SMC_SUPPORT
   `ifdef NDS_FPGA
inout       [15:0] X_memdata;          // (IO),  Memory data bus
   `else
inout       [31:0] X_memdata;          // (IO),  Memory data bus
   `endif // NDS_FPGA
`endif // AE350_SMC_SUPPORT
`ifdef NDS_FPGA
`else
   `ifdef AE350_RTC_SUPPORT
inout              X_rtc_wakeup;
   `endif // AE350_RTC_SUPPORT
   `ifdef AE350_UART1_SUPPORT
inout              X_uart1_dcdn;
inout              X_uart1_dsrn;
inout              X_uart1_dtrn;
inout              X_uart1_out1n;
inout              X_uart1_out2n;
inout              X_uart1_rin;
   `endif // AE350_UART1_SUPPORT
`endif // NDS_FPGA
`ifdef AE350_UART1_SUPPORT
   `ifdef AE350_UART2_SUPPORT
   `else
inout              X_uart1_ctsn;
inout              X_uart1_rtsn;
   `endif // AE350_UART2_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
inout              X_uart1_rxd;
inout              X_uart1_txd;
   `endif // NDS_BOARD_CF1
`endif // AE350_UART1_SUPPORT
`ifdef NDS_FPGA
`else
   `ifdef AE350_UART2_SUPPORT
inout              X_uart2_ctsn;
inout              X_uart2_dcdn;
inout              X_uart2_dsrn;
inout              X_uart2_dtrn;
inout              X_uart2_out1n;
inout              X_uart2_out2n;
inout              X_uart2_rin;
inout              X_uart2_rtsn;
   `endif // AE350_UART2_SUPPORT
`endif // NDS_FPGA
`ifdef AE350_UART2_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
inout              X_uart2_rxd;
inout              X_uart2_txd;
   `endif // NDS_BOARD_CF1
`endif // AE350_UART2_SUPPORT
`ifdef AE350_PIT_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
inout              X_pwm_ch0;
   `endif // NDS_BOARD_CF1
`endif // AE350_PIT_SUPPORT
`ifdef AE350_GPIO_SUPPORT
   `ifdef NDS_BOARD_CF1
inout       [31:1] X_gpio;
   `else
inout       [31:0] X_gpio;
   `endif // NDS_BOARD_CF1
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_I2C_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
inout              X_i2c_scl;
inout              X_i2c_sda;
   `endif // NDS_BOARD_CF1
`endif // AE350_I2C_SUPPORT
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
inout              X_spi1_holdn;
inout              X_spi1_wpn;
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
inout              X_spi2_holdn;
inout              X_spi2_wpn;
   `endif // ATCSPI200_QUADSPI_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
inout              X_spi2_clk;
inout              X_spi2_csn;
inout              X_spi2_miso;
inout              X_spi2_mosi;
   `endif // NDS_BOARD_CF1
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
inout              X_spi3_holdn;
inout              X_spi3_wpn;
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
inout              X_spi4_holdn;
inout              X_spi4_wpn;
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI4_SUPPORT
`ifdef NDS_FPGA
   `ifdef NDS_BOARD_ORCA
inout              X_flash_dir;
   `endif // NDS_BOARD_ORCA
`else
   `ifdef AE350_UART1_SUPPORT
      `ifdef AE350_UART2_SUPPORT
inout              X_uart1_ctsn;
inout              X_uart1_rtsn;
      `endif // AE350_UART2_SUPPORT
   `endif // AE350_UART1_SUPPORT
`endif // NDS_FPGA
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
      `ifdef NDS_BOARD_CF1
      `else
inout              X_pwm_ch1;
      `endif // NDS_BOARD_CF1
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
      `ifdef NDS_BOARD_CF1
      `else
inout              X_pwm_ch2;
      `endif // NDS_BOARD_CF1
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
      `ifdef NDS_BOARD_CF1
      `else
inout              X_pwm_ch3;
      `endif // NDS_BOARD_CF1
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT_SUPPORT
`ifdef AE350_AXI_SUPPORT
   `ifdef NDS_FPGA
      `ifdef PLATFORM_NO_RAM_SUBSYSTEM
      `else
         `ifdef AE350_K7DDR3_SUPPORT
         `else
            `ifdef AE350_VUDDR4_SUPPORT
output             X_ddr4_act_n;
output      [16:0] X_ddr4_addr;
output       [1:0] X_ddr4_ba;
output       [0:0] X_ddr4_bg;
output       [0:0] X_ddr4_ck_c;
output       [0:0] X_ddr4_ck_t;
output       [0:0] X_ddr4_cke;
output       [0:0] X_ddr4_cs_n;
output       [0:0] X_ddr4_odt;
output             X_ddr4_reset_n;
input              X_ddr4_sys_clk_n;
input              X_ddr4_sys_clk_p;
            `endif // AE350_VUDDR4_SUPPORT
         `endif // AE350_K7DDR3_SUPPORT
      `endif // PLATFORM_NO_RAM_SUBSYSTEM
   `else
      `ifdef PLATFORM_NO_RAM_SUBSYSTEM
      `else
         `ifdef AE350_K7DDR3_SUPPORT
         `else
            `ifdef AE350_VUDDR4_SUPPORT
output             X_ddr4_act_n;
output      [16:0] X_ddr4_addr;
output       [1:0] X_ddr4_ba;
output       [0:0] X_ddr4_bg;
output       [0:0] X_ddr4_ck_c;
output       [0:0] X_ddr4_ck_t;
output       [0:0] X_ddr4_cke;
output       [0:0] X_ddr4_cs_n;
output       [0:0] X_ddr4_odt;
output             X_ddr4_reset_n;
input              X_ddr4_sys_clk_n;
input              X_ddr4_sys_clk_p;
            `endif // AE350_VUDDR4_SUPPORT
         `endif // AE350_K7DDR3_SUPPORT
      `endif // PLATFORM_NO_RAM_SUBSYSTEM
   `endif // NDS_FPGA
`endif // AE350_AXI_SUPPORT
input              X_osclin;
inout              X_wakeup_in;
inout              X_hw_rstn;
input              X_oschin;
inout              X_por_b;

`ifdef AE350_AXI_SUPPORT
wire                              [ADDR_MSB:0] ram_araddr;
wire                                     [1:0] ram_arburst;
wire                                     [3:0] ram_arcache;
wire                   [CPUSUB_BIU_ID_MSB+4:0] ram_arid;
wire                                     [7:0] ram_arlen;
wire                                           ram_arlock;
wire                                     [2:0] ram_arprot;
wire                                     [2:0] ram_arsize;
wire                                           ram_arvalid;
wire                              [ADDR_MSB:0] ram_awaddr;
wire                                     [1:0] ram_awburst;
wire                                     [3:0] ram_awcache;
wire                   [CPUSUB_BIU_ID_MSB+4:0] ram_awid;
wire                                     [7:0] ram_awlen;
wire                                           ram_awlock;
wire                                     [2:0] ram_awprot;
wire                                     [2:0] ram_awsize;
wire                                           ram_awvalid;
wire                                           ram_bready;
wire                                           ram_rready;
wire                   [CPUSUB_BIU_DATA_MSB:0] ram_wdata;
wire                                           ram_wlast;
wire                  [CPUSUB_BIU_WSTRB_MSB:0] ram_wstrb;
wire                                           ram_wvalid;
wire                                           ram_arready;
wire                                           ram_awready;
wire                   [CPUSUB_BIU_ID_MSB+4:0] ram_bid;
wire                                     [1:0] ram_bresp;
wire                                           ram_bvalid;
wire                   [CPUSUB_BIU_DATA_MSB:0] ram_rdata;
wire                   [CPUSUB_BIU_ID_MSB+4:0] ram_rid;
wire                                           ram_rlast;
wire                                     [1:0] ram_rresp;
wire                                           ram_rvalid;
wire                                           ram_wready;
`endif // AE350_AXI_SUPPORT
`ifdef PLATFORM_DEBUG_PORT
wire                                           pin_tdo_out;
wire                                           pin_tdo_out_en;
wire                                           pin_tms_out;
wire                                           pin_tms_out_en;
wire                                           pin_tdi_in;
wire                                           pin_tms_in;
wire                                           pin_trst_in;
`endif // PLATFORM_DEBUG_PORT
`ifdef AE350_AHB_SUPPORT
wire                                           bmc_intr;
wire                              [ADDR_MSB:0] ram_haddr;
wire                                     [2:0] ram_hburst;
wire                                     [3:0] ram_hprot;
wire                                           ram_hready;
wire                                           ram_hsel;
wire                                     [2:0] ram_hsize;
wire                                     [1:0] ram_htrans;
wire                   [CPUSUB_BIU_DATA_MSB:0] ram_hwdata;
wire                                           ram_hwrite;
wire                   [CPUSUB_BIU_DATA_MSB:0] ram_hrdata;
wire                                           ram_hreadyout;
wire                                     [1:0] ram_hresp;
`endif // AE350_AHB_SUPPORT
`ifdef AE350_DMA_AHB_SUPPORT
wire                                    [31:0] dmac_haddr;
wire                                     [2:0] dmac_hburst;
wire                                     [3:0] dmac_hprot;
wire                                     [2:0] dmac_hsize;
wire                                     [1:0] dmac_htrans;
wire        [((`ATCDMAC110_DATA_WIDTH) - 1):0] dmac_hwdata;
wire                                           dmac_hwrite;
wire        [((`ATCDMAC110_DATA_WIDTH) - 1):0] dmac_hrdata;
wire                                           dmac_hready;
wire                                     [1:0] dmac_hresp;
`endif // AE350_DMA_AHB_SUPPORT
`ifdef AE350_MAC_SUPPORT
wire                                    [31:0] mac_haddr;
wire                                     [2:0] mac_hburst;
wire                                     [3:0] mac_hprot;
wire                                     [2:0] mac_hsize;
wire                                     [1:0] mac_htrans;
wire                                    [31:0] mac_hwdata;
wire                                           mac_hwrite;
wire                                           mdc;
wire                                           mdio_out;
wire                                           mdio_out_en;
wire                                           pdn_phy;
wire                                           tx_en;
wire                                     [3:0] txd;
wire                                    [31:0] mac_hrdata;
wire                                           mac_hreadyout;
wire                                     [1:0] mac_hresp;
wire                                           T_col;
wire                                           T_crs;
wire                                           T_mdio;
wire                                           T_phy_linksts;
wire                                           T_rx_clk;
wire                                           T_rx_dv;
wire                                           T_rx_er;
wire                                     [3:0] T_rxd;
wire                                           T_tx_clk;
`endif // AE350_MAC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
wire                                           clpower; // dangler: () <= ()
wire                                           clac;
wire                                           clcp;
wire                                    [23:0] cld;
wire                                           clfp;
wire                                           clle;
wire                                           cllp;
wire                                     [7:0] lcd_gpo; // dangler: () => ()
wire                                    [31:0] lcdc_haddr;
wire                                     [2:0] lcdc_hburst;
wire                                     [3:0] lcdc_hprot;
wire                                     [2:0] lcdc_hsize;
wire                                     [1:0] lcdc_htrans;
wire                                    [31:0] lcdc_hwdata;
wire                                           lcdc_hwrite;
wire                                           lcd_clk;
wire                                           lcd_clkn;
wire                                    [31:0] lcdc_hrdata;
wire                                           lcdc_hreadyout;
wire                                     [1:0] lcdc_hresp;
`endif // AE350_LCDC_SUPPORT
`ifdef PLATFORM_DEBUG_SUBSYSTEM
wire                                    [31:0] dmi_haddr;
wire                                     [2:0] dmi_hburst;
wire                                     [3:0] dmi_hprot;
wire                                           dmi_hsel;
wire                                     [2:0] dmi_hsize;
wire                                     [1:0] dmi_htrans;
wire                                    [31:0] dmi_hwdata;
wire                                           dmi_hwrite;
wire                                           dmi_resetn;
wire                                    [31:0] pldm_dmi_hrdata;
wire                                           pldm_dmi_hreadyout;
wire                                     [1:0] pldm_dmi_hresp;
wire                                    [31:0] dmi_hrdata;
wire                                           dmi_hready;
wire                                     [1:0] dmi_hresp;
wire                                     [8:0] pldm_dmi_haddr;
wire                                     [2:0] pldm_dmi_hburst;
wire                                     [3:0] pldm_dmi_hprot;
wire                                           pldm_dmi_hready;
wire                                           pldm_dmi_hsel;
wire                                     [2:0] pldm_dmi_hsize;
wire                                     [1:0] pldm_dmi_htrans;
wire                                    [31:0] pldm_dmi_hwdata;
wire                                           pldm_dmi_hwrite;
wire                                           pldm_dmi_resetn;
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
wire                                     [9:0] hart0_trace_cause;
wire                                           hart0_trace_halted;
wire          [(VALEN*HART0_NUM_INST_BLK-1):0] hart0_trace_iaddr;
wire                [(HART0_NUM_INST_BLK-1):0] hart0_trace_ilastsize;
wire              [(2*HART0_NUM_INST_BLK-1):0] hart0_trace_iretire;
wire              [(4*HART0_NUM_INST_BLK-1):0] hart0_trace_itype;
wire            [(HART0_TRACE_PRIV_WIDTH-1):0] hart0_trace_priv;
wire                                           hart0_trace_reset;
wire         [(HART0_TRACE_TRIGGER_WIDTH-1):0] hart0_trace_trigger;
wire                         [(`NDS_XLEN-1):0] hart0_trace_tval;
wire                                           hart0_trace_enabled;
`endif // NDS_IO_TRACE_INSTR
`ifdef AE350_SMC_SUPPORT
wire                                           smc_cs_n_0; // dangler: () <= ()
wire                                    [31:0] smc_mem_haddr;
wire                                     [2:0] smc_mem_hburst;
wire                                     [2:0] smc_mem_hsize;
wire                                    [31:0] smc_mem_hwdata;
wire                                           smc_mem_hwrite;
wire                                    [24:0] smc_addr;
wire             [(`ATFSMC020_EBNK_COUNT)-1:0] smc_cs_n; // dangler: () => ()
wire                                    [31:0] smc_data_oe;
wire                                    [31:0] smc_dqout;
wire                                    [31:0] smc_mem_hrdata;
wire                                           smc_mem_hreadyout;
wire                                     [1:0] smc_mem_hresp;
wire                                           smc_oe_n;
wire                                           smc_we_n;
wire                                    [31:0] T_memdata;
wire                                           smc_mem_hsel;
`endif // AE350_SMC_SUPPORT
`ifdef AE350_RTC_SUPPORT
wire                                    [31:0] rtc_prdata;
wire                                           rtc_pready;
wire                                           rtc_pslverr;
wire                                           rtc_psel;
`endif // AE350_RTC_SUPPORT
`ifdef AE350_UART1_SUPPORT
wire                                           uart1_dtrn;
wire                                           uart1_out1n;
wire                                           uart1_out2n;
wire                                           uart1_rtsn;
wire                                           uart1_txd;
wire                                           uart1_ctsn;
wire                                           uart1_dcdn;
wire                                           uart1_dsrn;
wire                                           uart1_rin;
wire                                           uart1_rxd;
`endif // AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
wire                                           uart2_dtrn;
wire                                           uart2_out1n;
wire                                           uart2_out2n;
wire                                           uart2_rtsn;
wire                                           uart2_txd;
wire                                           uart2_ctsn;
wire                                           uart2_dcdn;
wire                                           uart2_dsrn;
wire                                           uart2_rin;
wire                                           uart2_rxd;
`endif // AE350_UART2_SUPPORT
`ifdef AE350_PIT_SUPPORT
wire                                           ch0_pwm;
wire                                           ch0_pwmoe;
`endif // AE350_PIT_SUPPORT
`ifdef AE350_PIT2_SUPPORT
wire                                           pit2_ch0_pwm;
wire                                           pit2_ch0_pwmoe;
`endif // AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
wire                                           pit3_ch0_pwm;
wire                                           pit3_ch0_pwmoe;
`endif // AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
wire                                           pit4_ch0_pwm;
wire                                           pit4_ch0_pwmoe;
`endif // AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
wire                                           pit5_ch0_pwm;
wire                                           pit5_ch0_pwmoe;
`endif // AE350_PIT5_SUPPORT
`ifdef AE350_GPIO_SUPPORT
wire                                    [31:0] gpio_oe;
wire                                    [31:0] gpio_out;
wire                                    [31:0] gpio_in;
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_I2C_SUPPORT
wire                                           i2c_scl;
wire                                           i2c_sda;
wire                                           i2c_scl_in;
wire                                           i2c_sda_in;
`endif // AE350_I2C_SUPPORT
`ifdef AE350_I2C2_SUPPORT
wire                                           i2c2_scl;
wire                                           i2c2_sda;
wire                                           i2c2_scl_in;
wire                                           i2c2_sda_in;
`endif // AE350_I2C2_SUPPORT
`ifdef AE350_SPI1_SUPPORT
wire                                           spi1_clk_oe;
wire                                           spi1_clk_out;
wire                                           spi1_csn_oe;
wire                                           spi1_csn_out;
wire                                           spi1_miso_oe;
wire                                           spi1_miso_out;
wire                                           spi1_mosi_oe;
wire                                           spi1_mosi_out;
wire                                    [31:0] spi_mem_hrdata;
wire                                           spi_mem_hreadyout;
wire                                     [1:0] spi_mem_hresp;
wire                                           spi1_clk_in;
wire                                           spi1_csn_in;
wire                                           spi1_miso_in;
wire                                           spi1_mosi_in;
wire                                           spi_mem_hsel;
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
wire                                           spi2_clk_oe;
wire                                           spi2_clk_out;
wire                                           spi2_csn_oe;
wire                                           spi2_csn_out;
wire                                           spi2_miso_oe;
wire                                           spi2_miso_out;
wire                                           spi2_mosi_oe;
wire                                           spi2_mosi_out;
wire                                           spi2_clk_in;
wire                                           spi2_csn_in;
wire                                           spi2_miso_in;
wire                                           spi2_mosi_in;
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
wire                                           spi3_clk_oe;
wire                                           spi3_clk_out;
wire                                           spi3_csn_oe;
wire                                           spi3_csn_out;
wire                                           spi3_miso_oe;
wire                                           spi3_miso_out;
wire                                           spi3_mosi_oe;
wire                                           spi3_mosi_out;
wire                                           spi3_clk_in;
wire                                           spi3_csn_in;
wire                                           spi3_miso_in;
wire                                           spi3_mosi_in;
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
wire                                           spi4_clk_oe;
wire                                           spi4_clk_out;
wire                                           spi4_csn_oe;
wire                                           spi4_csn_out;
wire                                           spi4_miso_oe;
wire                                           spi4_miso_out;
wire                                           spi4_mosi_oe;
wire                                           spi4_mosi_out;
wire                                           spi4_clk_in;
wire                                           spi4_csn_in;
wire                                           spi4_miso_in;
wire                                           spi4_mosi_in;
`endif // AE350_SPI4_SUPPORT
`ifdef AE350_SDC_SUPPORT
wire                                           sd_clk;
wire                                           sd_cmd;
wire                                           sd_cmd_oe;
wire                                           sd_dat0_oe;
wire                                           sd_dat0_out;
wire                                           sd_dat1_oe;
wire                                           sd_dat1_out;
wire                                           sd_dat2_oe;
wire                                           sd_dat2_out;
wire                                           sd_dat3_oe;
wire                                           sd_dat3_out;
wire                                     [4:0] sd_power;
wire                                           T_sd_cd;
wire                                           T_sd_dat0_in;
wire                                           T_sd_dat1_in;
wire                                           T_sd_dat2_in;
wire                                           T_sd_dat3_in;
wire                                           T_sd_rsp;
wire                                           T_sd_wp;
`endif // AE350_SDC_SUPPORT
`ifdef AE350_SSP_SUPPORT
wire                                           ssp_rstn;
wire                                           sspclk;
wire                                           ssp_ac97_resetn;
wire                                           ssp_fs_oe;
wire                                           ssp_fs_out;
wire                                           ssp_sclk_oe;
wire                                           ssp_sclk_out;
wire                                           ssp_txd;
wire                                           ssp_txd_oe;
wire                                           T_ssp_fs_in;
wire                                           T_ssp_rxd;
wire                                           T_ssp_sclk_in;
`endif // AE350_SSP_SUPPORT
`ifdef NDS_BOARD_CF1
wire                                    [31:0] cf1_pinmux_ctrl0;
wire                                    [31:0] cf1_pinmux_ctrl1;
`endif // NDS_BOARD_CF1
`ifdef AE350_K7DDR3_SUPPORT
wire                                           ddr3_aresetn;
`endif // AE350_K7DDR3_SUPPORT
`ifdef AE350_AXI_SUPPORT
   `ifdef NDS_IO_BIU_X2
wire                                           cpu_d_arready;
wire                                           cpu_d_awready;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_d_bid;
wire                                     [1:0] cpu_d_bresp;
wire                                           cpu_d_bvalid;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_d_rdata;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_d_rid;
wire                                           cpu_d_rlast;
wire                                     [1:0] cpu_d_rresp;
wire                                           cpu_d_rvalid;
wire                                           cpu_d_wready;
wire                                           cpu_i_arready;
wire                                           cpu_i_awready;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_i_bid;
wire                                     [1:0] cpu_i_bresp;
wire                                           cpu_i_bvalid;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_i_rdata;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_i_rid;
wire                                           cpu_i_rlast;
wire                                     [1:0] cpu_i_rresp;
wire                                           cpu_i_rvalid;
wire                                           cpu_i_wready;
wire                              [ADDR_MSB:0] cpu_d_araddr;
wire                                     [1:0] cpu_d_arburst;
wire                                     [3:0] cpu_d_arcache;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_d_arid;
wire                                     [7:0] cpu_d_arlen;
wire                                           cpu_d_arlock;
wire                                     [2:0] cpu_d_arprot;
wire                                     [2:0] cpu_d_arsize;
wire                                           cpu_d_arvalid;
wire                              [ADDR_MSB:0] cpu_d_awaddr;
wire                                     [1:0] cpu_d_awburst;
wire                                     [3:0] cpu_d_awcache;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_d_awid;
wire                                     [7:0] cpu_d_awlen;
wire                                           cpu_d_awlock;
wire                                     [2:0] cpu_d_awprot;
wire                                     [2:0] cpu_d_awsize;
wire                                           cpu_d_awvalid;
wire                                           cpu_d_bready;
wire                                           cpu_d_rready;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_d_wdata;
wire                                           cpu_d_wlast;
wire                  [CPUSUB_BIU_WSTRB_MSB:0] cpu_d_wstrb;
wire                                           cpu_d_wvalid;
wire                              [ADDR_MSB:0] cpu_i_araddr;
wire                                     [1:0] cpu_i_arburst;
wire                                     [3:0] cpu_i_arcache;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_i_arid;
wire                                     [7:0] cpu_i_arlen;
wire                                           cpu_i_arlock;
wire                                     [2:0] cpu_i_arprot;
wire                                     [2:0] cpu_i_arsize;
wire                                           cpu_i_arvalid;
wire                              [ADDR_MSB:0] cpu_i_awaddr;
wire                                     [1:0] cpu_i_awburst;
wire                                     [3:0] cpu_i_awcache;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_i_awid;
wire                                     [7:0] cpu_i_awlen;
wire                                           cpu_i_awlock;
wire                                     [2:0] cpu_i_awprot;
wire                                     [2:0] cpu_i_awsize;
wire                                           cpu_i_awvalid;
wire                                           cpu_i_bready;
wire                                           cpu_i_rready;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_i_wdata;
wire                                           cpu_i_wlast;
wire                  [CPUSUB_BIU_WSTRB_MSB:0] cpu_i_wstrb;
wire                                           cpu_i_wvalid;
   `endif // NDS_IO_BIU_X2
   `ifdef NDS_IO_SLAVEPORT
wire                              [ADDR_MSB:0] cpuslv_araddr;
wire                                     [1:0] cpuslv_arburst;
wire                                     [3:0] cpuslv_arcache;
wire                   [CPUSUB_BIU_ID_MSB+4:0] cpuslv_arid;
wire                                     [7:0] cpuslv_arlen;
wire                                           cpuslv_arlock;
wire                                     [2:0] cpuslv_arprot;
wire                                     [2:0] cpuslv_arsize;
wire                                           cpuslv_arvalid;
wire                              [ADDR_MSB:0] cpuslv_awaddr;
wire                                     [1:0] cpuslv_awburst;
wire                                     [3:0] cpuslv_awcache;
wire                   [CPUSUB_BIU_ID_MSB+4:0] cpuslv_awid;
wire                                     [7:0] cpuslv_awlen;
wire                                           cpuslv_awlock;
wire                                     [2:0] cpuslv_awprot;
wire                                     [2:0] cpuslv_awsize;
wire                                           cpuslv_awvalid;
wire                                           cpuslv_bready;
wire                                           cpuslv_rready;
wire                      [SLVPORT_DATA_MSB:0] cpuslv_wdata;
wire                                           cpuslv_wlast;
wire                     [SLVPORT_WSTRB_MSB:0] cpuslv_wstrb;
wire                                           cpuslv_wvalid;
wire                                           cpuslv_arready;
wire                                           cpuslv_awready;
wire                   [CPUSUB_BIU_ID_MSB+4:0] cpuslv_bid;
wire                                     [1:0] cpuslv_bresp;
wire                                           cpuslv_bvalid;
wire                      [SLVPORT_DATA_MSB:0] cpuslv_rdata;
wire                   [CPUSUB_BIU_ID_MSB+4:0] cpuslv_rid;
wire                                           cpuslv_rlast;
wire                                     [1:0] cpuslv_rresp;
wire                                           cpuslv_rvalid;
wire                                           cpuslv_wready;
   `endif // NDS_IO_SLAVEPORT
   `ifdef NDS_FPGA
wire                                     [1:0] ddr3_bw_ctrl;
wire                                     [3:0] ddr3_latency;
   `endif // NDS_FPGA
`endif // AE350_AXI_SUPPORT
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_JDTM_SECURE_SUPPORT
wire                                     [1:0] T_secure_mode; // dangler: () => ()
   `endif // PLATFORM_JDTM_SECURE_SUPPORT
`endif // PLATFORM_DEBUG_PORT
`ifdef NDS_NHART
   `ifdef NDS_IO_L2C
wire                                           core0_wfi_sel_iso_sync;
wire                                           core1_wfi_sel_iso_sync;
wire                                           core2_wfi_sel_iso_sync;
wire                                           core3_wfi_sel_iso_sync;
wire                                           pcs_core0_sleep_req;
wire                                           pcs_core1_sleep_req;
wire                                           pcs_core2_sleep_req;
wire                                           pcs_core3_sleep_req;
wire                                           l2c_err_int;
wire                                           l2c_pcs_standby_ok;
wire                                           pcs_core0_sleep_ok;
wire                                           pcs_core1_sleep_ok;
wire                                           pcs_core2_sleep_ok;
wire                                           pcs_core3_sleep_ok;
   `endif // NDS_IO_L2C
`endif // NDS_NHART
`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
wire                        [(ADDR_WIDTH-1):0] dmac1_araddr;
wire                                     [1:0] dmac1_arburst;
wire                                     [3:0] dmac1_arcache;
wire                     [(DMAC_ID_WIDTH-1):0] dmac1_arid;
wire                                     [7:0] dmac1_arlen;
wire                                           dmac1_arlock;
wire                                     [2:0] dmac1_arprot;
wire                                     [2:0] dmac1_arsize;
wire                                           dmac1_arvalid;
wire                        [(ADDR_WIDTH-1):0] dmac1_awaddr;
wire                                     [1:0] dmac1_awburst;
wire                                     [3:0] dmac1_awcache;
wire                     [(DMAC_ID_WIDTH-1):0] dmac1_awid;
wire                                     [7:0] dmac1_awlen;
wire                                           dmac1_awlock;
wire                                     [2:0] dmac1_awprot;
wire                                     [2:0] dmac1_awsize;
wire                                           dmac1_awvalid;
wire                                           dmac1_bready;
wire                                           dmac1_rready;
wire               [(DMAC_DATA_WIDTH_FIX-1):0] dmac1_wdata;
wire                                           dmac1_wlast;
wire           [((DMAC_DATA_WIDTH_FIX/8)-1):0] dmac1_wstrb;
wire                                           dmac1_wvalid;
wire                                           dmac1_arready;
wire                                           dmac1_awready;
wire                     [(DMAC_ID_WIDTH-1):0] dmac1_bid;
wire                                     [1:0] dmac1_bresp;
wire                                           dmac1_bvalid;
wire               [(DMAC_DATA_WIDTH_FIX-1):0] dmac1_rdata;
wire                     [(DMAC_ID_WIDTH-1):0] dmac1_rid;
wire                                           dmac1_rlast;
wire                                     [1:0] dmac1_rresp;
wire                                           dmac1_rvalid;
wire                                           dmac1_wready;
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_AHB_SUPPORT
   `ifdef NDS_IO_BIU_X2
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_d_hrdata;
wire                                           cpu_d_hready;
wire                                     [1:0] cpu_d_hresp;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_i_hrdata;
wire                                           cpu_i_hready;
wire                                     [1:0] cpu_i_hresp;
wire                              [ADDR_MSB:0] cpu_d_haddr;
wire                                     [2:0] cpu_d_hburst;
wire                                     [3:0] cpu_d_hprot;
wire                                     [2:0] cpu_d_hsize;
wire                                     [1:0] cpu_d_htrans;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_d_hwdata;
wire                                           cpu_d_hwrite;
wire                              [ADDR_MSB:0] cpu_i_haddr;
wire                                     [2:0] cpu_i_hburst;
wire                                     [3:0] cpu_i_hprot;
wire                                     [2:0] cpu_i_hsize;
wire                                     [1:0] cpu_i_htrans;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_i_hwdata;
wire                                           cpu_i_hwrite;
   `else
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_hrdata;
wire                                           cpu_hready;
wire                                     [1:0] cpu_hresp;
wire                              [ADDR_MSB:0] cpu_haddr;
wire                                     [2:0] cpu_hburst;
wire                                     [3:0] cpu_hprot;
wire                                     [2:0] cpu_hsize;
wire                                     [1:0] cpu_htrans;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_hwdata;
wire                                           cpu_hwrite;
   `endif // NDS_IO_BIU_X2
   `ifdef NDS_IO_SLAVEPORT
wire                              [ADDR_MSB:0] cpuslv_haddr;
wire                                     [2:0] cpuslv_hburst;
wire                                     [3:0] cpuslv_hprot;
wire                                           cpuslv_hready;
wire                                           cpuslv_hsel;
wire                                     [2:0] cpuslv_hsize;
wire                                     [1:0] cpuslv_htrans;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpuslv_hwdata;
wire                                           cpuslv_hwrite;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpuslv_hrdata;
wire                                           cpuslv_hreadyout;
wire                                     [1:0] cpuslv_hresp;
   `endif // NDS_IO_SLAVEPORT
`endif // AE350_AHB_SUPPORT
`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef PLATFORM_JDTM_SECURE_SUPPORT
wire                                   [127:0] secure_code; // dangler: () <= ()
wire                                     [1:0] secure_mode; // dangler: () <= ()
   `endif // PLATFORM_JDTM_SECURE_SUPPORT
   `ifdef NDS_IO_TRACE_INSTR
wire                                           atclk;
wire                                           dmi_clk;
wire                                           hart0_power_down;
wire                                    [31:0] hart0_trace_context;
wire                                     [1:0] hart0_trace_ctype;
wire                                           hart0_trace_secure;
wire                                     [0:0] tb_ram_ctrl_in;
wire                                           tbuf_sys_aclk;
wire                             [(NHART-1):0] te_reset_n;
wire                                           ts_clk;
wire                                           ts_reset_n;
wire                                           tbuf_sys_arready;
wire                                           tbuf_sys_awready;
wire               [(CPUSUB_BIU_ID_WIDTH-1):0] tbuf_sys_bid;
wire                                     [1:0] tbuf_sys_bresp;
wire                                           tbuf_sys_bvalid;
wire             [(CPUSUB_BIU_DATA_WIDTH-1):0] tbuf_sys_rdata;
wire               [(CPUSUB_BIU_ID_WIDTH-1):0] tbuf_sys_rid;
wire                                           tbuf_sys_rlast;
wire                                     [1:0] tbuf_sys_rresp;
wire                                           tbuf_sys_rvalid;
wire                                           tbuf_sys_wready;
wire                                           hart0_trace_stall;
wire                    [(BIU_ADDR_WIDTH-1):0] tbuf_sys_araddr;
wire                                     [1:0] tbuf_sys_arburst;
wire                                     [3:0] tbuf_sys_arcache;
wire               [(CPUSUB_BIU_ID_WIDTH-1):0] tbuf_sys_arid;
wire                                     [7:0] tbuf_sys_arlen;
wire                                           tbuf_sys_arlock;
wire                                     [2:0] tbuf_sys_arprot;
wire                                     [2:0] tbuf_sys_arsize;
wire                                           tbuf_sys_arvalid;
wire                    [(BIU_ADDR_WIDTH-1):0] tbuf_sys_awaddr;
wire                                     [1:0] tbuf_sys_awburst;
wire                                     [3:0] tbuf_sys_awcache;
wire               [(CPUSUB_BIU_ID_WIDTH-1):0] tbuf_sys_awid;
wire                                     [7:0] tbuf_sys_awlen;
wire                                           tbuf_sys_awlock;
wire                                     [2:0] tbuf_sys_awprot;
wire                                     [2:0] tbuf_sys_awsize;
wire                                           tbuf_sys_awvalid;
wire                                           tbuf_sys_bready;
wire                                           tbuf_sys_rready;
wire             [(CPUSUB_BIU_DATA_WIDTH-1):0] tbuf_sys_wdata;
wire                                           tbuf_sys_wlast;
wire         [((CPUSUB_BIU_DATA_WIDTH/8)-1):0] tbuf_sys_wstrb;
wire                                           tbuf_sys_wvalid;
wire                                     [0:0] unused_tb_ram_ctrl_out;
   `endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_BIU_X2
`else
   `ifdef NDS_IO_AHB
   `else
wire                                           cpu_arready;
wire                                           cpu_awready;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_bid;
wire                                     [1:0] cpu_bresp;
wire                                           cpu_bvalid;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_rdata;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_rid;
wire                                           cpu_rlast;
wire                                     [1:0] cpu_rresp;
wire                                           cpu_rvalid;
wire                                           cpu_wready;
wire                              [ADDR_MSB:0] cpu_araddr;
wire                                     [1:0] cpu_arburst;
wire                                     [3:0] cpu_arcache;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_arid;
wire                                     [7:0] cpu_arlen;
wire                                           cpu_arlock;
wire                                     [2:0] cpu_arprot;
wire                                     [2:0] cpu_arsize;
wire                                           cpu_arvalid;
wire                              [ADDR_MSB:0] cpu_awaddr;
wire                                     [1:0] cpu_awburst;
wire                                     [3:0] cpu_awcache;
wire                     [CPUSUB_BIU_ID_MSB:0] cpu_awid;
wire                                     [7:0] cpu_awlen;
wire                                           cpu_awlock;
wire                                     [2:0] cpu_awprot;
wire                                     [2:0] cpu_awsize;
wire                                           cpu_awvalid;
wire                                           cpu_bready;
wire                                           cpu_rready;
wire                   [CPUSUB_BIU_DATA_MSB:0] cpu_wdata;
wire                                           cpu_wlast;
wire                  [CPUSUB_BIU_WSTRB_MSB:0] cpu_wstrb;
wire                                           cpu_wvalid;
   `endif // NDS_IO_AHB
`endif // NDS_IO_BIU_X2
`ifdef AE350_SMC_SUPPORT
   `ifdef ATFSMC020_SEPARATE_AHB
wire                                           smc_mem_hready; // dangler: () <= ()
wire                                     [1:0] smc_mem_htrans; // dangler: () <= ()
   `endif // ATFSMC020_SEPARATE_AHB
   `ifdef AE350_SPI1_SUPPORT
wire                                           dec_hready; // dangler: () => ()
   `endif // AE350_SPI1_SUPPORT
`endif // AE350_SMC_SUPPORT
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
wire                                           ch1_pwm;
wire                                           ch1_pwmoe;
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
wire                                           ch2_pwm;
wire                                           ch2_pwmoe;
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
wire                                           ch3_pwm;
wire                                           ch3_pwmoe;
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT_SUPPORT
`ifdef AE350_PIT2_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
wire                                           pit2_ch1_pwm;
wire                                           pit2_ch1_pwmoe;
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
wire                                           pit2_ch2_pwm;
wire                                           pit2_ch2_pwmoe;
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
wire                                           pit2_ch3_pwm;
wire                                           pit2_ch3_pwmoe;
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
wire                                           pit3_ch1_pwm;
wire                                           pit3_ch1_pwmoe;
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
wire                                           pit3_ch2_pwm;
wire                                           pit3_ch2_pwmoe;
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
wire                                           pit3_ch3_pwm;
wire                                           pit3_ch3_pwmoe;
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
wire                                           pit4_ch1_pwm;
wire                                           pit4_ch1_pwmoe;
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
wire                                           pit4_ch2_pwm;
wire                                           pit4_ch2_pwmoe;
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
wire                                           pit4_ch3_pwm;
wire                                           pit4_ch3_pwmoe;
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
wire                                           pit5_ch1_pwm;
wire                                           pit5_ch1_pwmoe;
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
wire                                           pit5_ch2_pwm;
wire                                           pit5_ch2_pwmoe;
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
wire                                           pit5_ch3_pwm;
wire                                           pit5_ch3_pwmoe;
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT5_SUPPORT
`ifdef AE350_GPIO_SUPPORT
   `ifdef ATCGPIO100_PULL_SUPPORT
wire                                    [31:0] gpio_pulldown;
wire                                    [31:0] gpio_pullup;
   `endif // ATCGPIO100_PULL_SUPPORT
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
wire            [(`ATCSPI200_HADDR_WIDTH-1):0] spi_mem_haddr; // dangler: () <= ()
wire                                           spi_mem_hready; // dangler: () <= ()
wire                                     [1:0] spi_mem_htrans; // dangler: () <= ()
wire                                           spi_mem_hwrite; // dangler: () <= ()
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
wire                                           spi1_holdn_oe;
wire                                           spi1_holdn_out;
wire                                           spi1_wpn_oe;
wire                                           spi1_wpn_out;
wire                                           spi1_holdn_in;
wire                                           spi1_wpn_in;
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
wire                                           spi2_holdn_oe;
wire                                           spi2_holdn_out;
wire                                           spi2_wpn_oe;
wire                                           spi2_wpn_out;
wire                                           spi2_holdn_in;
wire                                           spi2_wpn_in;
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
wire                                           spi3_holdn_oe;
wire                                           spi3_holdn_out;
wire                                           spi3_wpn_oe;
wire                                           spi3_wpn_out;
wire                                           spi3_holdn_in;
wire                                           spi3_wpn_in;
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
wire                                           spi4_holdn_oe;
wire                                           spi4_holdn_out;
wire                                           spi4_wpn_oe;
wire                                           spi4_wpn_out;
wire                                           spi4_holdn_in;
wire                                           spi4_wpn_in;
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI4_SUPPORT
`ifdef NDS_NHART
   `ifdef NDS_IO_HART1
wire                                           hart1_dcache_disable_init;
wire                                           hart1_icache_disable_init;
wire                                           hart1_core_wfi_mode;
wire                                     [5:0] hart1_wakeup_event;
   `endif // NDS_IO_HART1
   `ifdef NDS_IO_HART2
wire                                           hart2_dcache_disable_init;
wire                                           hart2_icache_disable_init;
wire                                           hart2_core_wfi_mode;
wire                                     [5:0] hart2_wakeup_event;
   `endif // NDS_IO_HART2
   `ifdef NDS_IO_HART3
wire                                           hart3_dcache_disable_init;
wire                                           hart3_icache_disable_init;
wire                                           hart3_core_wfi_mode;
wire                                     [5:0] hart3_wakeup_event;
   `endif // NDS_IO_HART3
`endif // NDS_NHART
`ifdef AE350_AXI_SUPPORT
   `ifdef PLATFORM_DEBUG_SUBSYSTEM
      `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
wire                                           dm_sys_arready;
wire                                           dm_sys_awready;
wire                     [CPUSUB_BIU_ID_MSB:0] dm_sys_bid;
wire                                     [1:0] dm_sys_bresp;
wire                                           dm_sys_bvalid;
wire             [(CPUSUB_BIU_DATA_WIDTH-1):0] dm_sys_rdata;
wire                     [CPUSUB_BIU_ID_MSB:0] dm_sys_rid;
wire                                           dm_sys_rlast;
wire                                     [1:0] dm_sys_rresp;
wire                                           dm_sys_rvalid;
wire                                           dm_sys_wready;
wire                              [ADDR_MSB:0] dm_sys_araddr;
wire                                     [1:0] dm_sys_arburst;
wire                                     [3:0] dm_sys_arcache;
wire                     [CPUSUB_BIU_ID_MSB:0] dm_sys_arid;
wire                                     [7:0] dm_sys_arlen;
wire                                           dm_sys_arlock;
wire                                     [2:0] dm_sys_arprot;
wire                                     [2:0] dm_sys_arsize;
wire                                           dm_sys_arvalid;
wire                              [ADDR_MSB:0] dm_sys_awaddr;
wire                                     [1:0] dm_sys_awburst;
wire                                     [3:0] dm_sys_awcache;
wire                     [CPUSUB_BIU_ID_MSB:0] dm_sys_awid;
wire                                     [7:0] dm_sys_awlen;
wire                                           dm_sys_awlock;
wire                                     [2:0] dm_sys_awprot;
wire                                     [2:0] dm_sys_awsize;
wire                                           dm_sys_awvalid;
wire                                           dm_sys_bready;
wire                                           dm_sys_rready;
wire             [(CPUSUB_BIU_DATA_WIDTH-1):0] dm_sys_wdata;
wire                                           dm_sys_wlast;
wire         [((CPUSUB_BIU_DATA_WIDTH/8)-1):0] dm_sys_wstrb;
wire                                           dm_sys_wvalid;
      `endif // PLATFORM_PLDM_SYS_BUS_ACCESS
   `endif // PLATFORM_DEBUG_SUBSYSTEM
`endif // AE350_AXI_SUPPORT
`ifdef NDS_NHART
   `ifdef NDS_IO_L2C
      `ifdef NDS_IO_L2C_IO_COHERENCE
wire                              [ADDR_MSB:0] m4_araddr;
wire                                     [1:0] m4_arburst;
wire                                     [3:0] m4_arcache;
wire                    [CPUCORE_BIU_ID_MSB:0] m4_arid;
wire                                     [7:0] m4_arlen;
wire                                           m4_arlock;
wire                                     [2:0] m4_arprot;
wire                                     [2:0] m4_arsize;
wire                                           m4_arvalid;
wire                              [ADDR_MSB:0] m4_awaddr;
wire                                     [1:0] m4_awburst;
wire                                     [3:0] m4_awcache;
wire                    [CPUCORE_BIU_ID_MSB:0] m4_awid;
wire                                     [7:0] m4_awlen;
wire                                           m4_awlock;
wire                                     [2:0] m4_awprot;
wire                                     [2:0] m4_awsize;
wire                                           m4_awvalid;
wire                                           m4_bready;
wire                                           m4_rready;
wire             [((`NDS_BIU_DATA_WIDTH)-1):0] m4_wdata;
wire                                           m4_wlast;
wire         [(((`NDS_BIU_DATA_WIDTH)/8)-1):0] m4_wstrb;
wire                                           m4_wvalid;
wire                                           m4_arready;
wire                                           m4_awready;
wire                    [CPUCORE_BIU_ID_MSB:0] m4_bid;
wire                                     [1:0] m4_bresp;
wire                                           m4_bvalid;
wire             [((`NDS_BIU_DATA_WIDTH)-1):0] m4_rdata;
wire                    [CPUCORE_BIU_ID_MSB:0] m4_rid;
wire                                           m4_rlast;
wire                                     [1:0] m4_rresp;
wire                                           m4_rvalid;
wire                                           m4_wready;
      `endif // NDS_IO_L2C_IO_COHERENCE
      `ifdef NDS_IO_L2C_IO_SLV
wire                                           l2c_io_arready; // dangler: () <= ()
wire                                           l2c_io_awready; // dangler: () <= ()
wire                     [CPUSUB_BIU_ID_MSB:0] l2c_io_bid; // dangler: () <= ()
wire                                     [1:0] l2c_io_bresp; // dangler: () <= ()
wire                                           l2c_io_bvalid; // dangler: () <= ()
wire                   [CPUSUB_BIU_DATA_MSB:0] l2c_io_rdata; // dangler: () <= ()
wire                     [CPUSUB_BIU_ID_MSB:0] l2c_io_rid; // dangler: () <= ()
wire                                           l2c_io_rlast; // dangler: () <= ()
wire                                     [1:0] l2c_io_rresp; // dangler: () <= ()
wire                                           l2c_io_rvalid; // dangler: () <= ()
wire                                           l2c_io_wready; // dangler: () <= ()
wire                              [ADDR_MSB:0] l2c_io_araddr;
wire                                     [1:0] l2c_io_arburst; // dangler: () => ()
wire                                     [3:0] l2c_io_arcache; // dangler: () => ()
wire                     [CPUSUB_BIU_ID_MSB:0] l2c_io_arid; // dangler: () => ()
wire                                     [7:0] l2c_io_arlen; // dangler: () => ()
wire                                           l2c_io_arlock; // dangler: () => ()
wire                                     [2:0] l2c_io_arprot; // dangler: () => ()
wire                                     [2:0] l2c_io_arsize; // dangler: () => ()
wire                                           l2c_io_arvalid; // dangler: () => ()
wire                              [ADDR_MSB:0] l2c_io_awaddr;
wire                                     [1:0] l2c_io_awburst; // dangler: () => ()
wire                                     [3:0] l2c_io_awcache; // dangler: () => ()
wire                     [CPUSUB_BIU_ID_MSB:0] l2c_io_awid; // dangler: () => ()
wire                                     [7:0] l2c_io_awlen; // dangler: () => ()
wire                                           l2c_io_awlock; // dangler: () => ()
wire                                     [2:0] l2c_io_awprot; // dangler: () => ()
wire                                     [2:0] l2c_io_awsize; // dangler: () => ()
wire                                           l2c_io_awvalid; // dangler: () => ()
wire                                           l2c_io_bready; // dangler: () => ()
wire                                           l2c_io_rready; // dangler: () => ()
wire                   [CPUSUB_BIU_DATA_MSB:0] l2c_io_wdata; // dangler: () => ()
wire                                           l2c_io_wlast; // dangler: () => ()
wire                  [CPUSUB_BIU_WSTRB_MSB:0] l2c_io_wstrb; // dangler: () => ()
wire                                           l2c_io_wvalid; // dangler: () => ()
      `endif // NDS_IO_L2C_IO_SLV
   `endif // NDS_IO_L2C
`endif // NDS_NHART
`ifdef AE350_AHB_SUPPORT
   `ifdef PLATFORM_DEBUG_SUBSYSTEM
      `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
wire                   [CPUSUB_BIU_DATA_MSB:0] dm_sys_hrdata;
wire                                           dm_sys_hready;
wire                                     [1:0] dm_sys_hresp;
wire                              [ADDR_MSB:0] dm_sys_haddr;
wire                                     [2:0] dm_sys_hburst;
wire                                     [3:0] dm_sys_hprot;
wire                                     [2:0] dm_sys_hsize;
wire                                     [1:0] dm_sys_htrans;
wire                   [CPUSUB_BIU_DATA_MSB:0] dm_sys_hwdata;
wire                                           dm_sys_hwrite;
      `endif // PLATFORM_PLDM_SYS_BUS_ACCESS
   `endif // PLATFORM_DEBUG_SUBSYSTEM
`endif // AE350_AHB_SUPPORT
`ifdef NDS_NHART
`else
   `ifdef NDS_IO_ACE_VPU
      `ifdef NDS_CUSTOM_ACE_VPU
wire             [((`NDS_ASP_DATA_WIDTH)-1):0] cp_cpu_rdata;
wire                                           cp_cpu_rdata_valid;
wire                                           cpu_cp_wdata_ready;
wire                                           cp_cpu_rdata_ready;
wire             [((`NDS_ASP_DATA_WIDTH)-1):0] cpu_cp_wdata;
wire         [(((`NDS_ASP_DATA_WIDTH)/8)-1):0] cpu_cp_wdata_bwe;
wire                                           cpu_cp_wdata_valid;
      `endif // NDS_CUSTOM_ACE_VPU
   `endif // NDS_IO_ACE_VPU
`endif // NDS_NHART
`ifdef NDS_NHART
   `ifdef NDS_IO_TRACE_INSTR
      `ifdef NDS_IO_HART1
wire                                     [9:0] hart1_trace_cause;
wire                                           hart1_trace_halted;
wire          [(VALEN*HART1_NUM_INST_BLK-1):0] hart1_trace_iaddr;
wire                [(HART1_NUM_INST_BLK-1):0] hart1_trace_ilastsize;
wire              [(2*HART1_NUM_INST_BLK-1):0] hart1_trace_iretire;
wire              [(4*HART1_NUM_INST_BLK-1):0] hart1_trace_itype;
wire            [(HART1_TRACE_PRIV_WIDTH-1):0] hart1_trace_priv;
wire                                           hart1_trace_reset;
wire         [(HART1_TRACE_TRIGGER_WIDTH-1):0] hart1_trace_trigger;
wire                         [(`NDS_XLEN-1):0] hart1_trace_tval;
wire                                           hart1_trace_enabled;
      `endif // NDS_IO_HART1
      `ifdef NDS_IO_HART2
wire                                     [9:0] hart2_trace_cause;
wire                                           hart2_trace_halted;
wire          [(VALEN*HART2_NUM_INST_BLK-1):0] hart2_trace_iaddr;
wire                [(HART2_NUM_INST_BLK-1):0] hart2_trace_ilastsize;
wire              [(2*HART2_NUM_INST_BLK-1):0] hart2_trace_iretire;
wire              [(4*HART2_NUM_INST_BLK-1):0] hart2_trace_itype;
wire            [(HART2_TRACE_PRIV_WIDTH-1):0] hart2_trace_priv;
wire                                           hart2_trace_reset;
wire         [(HART2_TRACE_TRIGGER_WIDTH-1):0] hart2_trace_trigger;
wire                         [(`NDS_XLEN-1):0] hart2_trace_tval;
wire                                           hart2_trace_enabled;
      `endif // NDS_IO_HART2
      `ifdef NDS_IO_HART3
wire                                     [9:0] hart3_trace_cause;
wire                                           hart3_trace_halted;
wire          [(VALEN*HART3_NUM_INST_BLK-1):0] hart3_trace_iaddr;
wire                [(HART3_NUM_INST_BLK-1):0] hart3_trace_ilastsize;
wire              [(2*HART3_NUM_INST_BLK-1):0] hart3_trace_iretire;
wire              [(4*HART3_NUM_INST_BLK-1):0] hart3_trace_itype;
wire            [(HART3_TRACE_PRIV_WIDTH-1):0] hart3_trace_priv;
wire                                           hart3_trace_reset;
wire         [(HART3_TRACE_TRIGGER_WIDTH-1):0] hart3_trace_trigger;
wire                         [(`NDS_XLEN-1):0] hart3_trace_tval;
wire                                           hart3_trace_enabled;
      `endif // NDS_IO_HART3
   `endif // NDS_IO_TRACE_INSTR
`endif // NDS_NHART
`ifdef AE350_AXI_SUPPORT
   `ifdef PLATFORM_NO_RAM_SUBSYSTEM
   `else
      `ifdef AE350_K7DDR3_SUPPORT
      `else
         `ifdef AE350_VUDDR4_SUPPORT
wire                                           ddr4_aresetn;
         `endif // AE350_VUDDR4_SUPPORT
      `endif // AE350_K7DDR3_SUPPORT
   `endif // PLATFORM_NO_RAM_SUBSYSTEM
`endif // AE350_AXI_SUPPORT
`ifdef NDS_NHART
   `ifdef PLATFORM_DEBUG_SUBSYSTEM
      `ifdef NDS_IO_TRACE_INSTR
         `ifdef NDS_IO_HART1
wire                                           hart1_power_down;
wire                                    [31:0] hart1_trace_context;
wire                                     [1:0] hart1_trace_ctype;
wire                                           hart1_trace_secure;
wire                                           hart1_trace_stall;
         `endif // NDS_IO_HART1
         `ifdef NDS_IO_HART2
wire                                           hart2_power_down;
wire                                    [31:0] hart2_trace_context;
wire                                     [1:0] hart2_trace_ctype;
wire                                           hart2_trace_secure;
wire                                           hart2_trace_stall;
         `endif // NDS_IO_HART2
         `ifdef NDS_IO_HART3
wire                                           hart3_power_down;
wire                                    [31:0] hart3_trace_context;
wire                                     [1:0] hart3_trace_ctype;
wire                                           hart3_trace_secure;
wire                                           hart3_trace_stall;
         `endif // NDS_IO_HART3
      `endif // NDS_IO_TRACE_INSTR
   `endif // PLATFORM_DEBUG_SUBSYSTEM
`endif // NDS_NHART
wire                              [ADDR_MSB:0] dmac0_araddr_bus;
wire                                     [1:0] dmac0_arburst_bus;
wire                                     [3:0] dmac0_arcache_bus;
wire               [(CPUSUB_BIU_ID_WIDTH-1):0] dmac0_arid_bus;
wire                                     [7:0] dmac0_arlen_bus;
wire                                           dmac0_arlock_bus;
wire                                     [2:0] dmac0_arprot_bus;
wire                                           dmac0_arready_apb;
wire                                     [2:0] dmac0_arsize_bus;
wire                                           dmac0_arvalid_bus;
wire                              [ADDR_MSB:0] dmac0_awaddr_bus;
wire                                     [1:0] dmac0_awburst_bus;
wire                                     [3:0] dmac0_awcache_bus;
wire               [(CPUSUB_BIU_ID_WIDTH-1):0] dmac0_awid_bus;
wire                                     [7:0] dmac0_awlen_bus;
wire                                           dmac0_awlock_bus;
wire                                     [2:0] dmac0_awprot_bus;
wire                                           dmac0_awready_apb;
wire                                     [2:0] dmac0_awsize_bus;
wire                                           dmac0_awvalid_bus;
wire                     [(DMAC_ID_WIDTH-1):0] dmac0_bid_apb;
wire                                           dmac0_bready_bus;
wire                                     [1:0] dmac0_bresp_apb;
wire                                           dmac0_bvalid_apb;
wire               [(DMAC_DATA_WIDTH_FIX-1):0] dmac0_rdata_apb;
wire                     [(DMAC_ID_WIDTH-1):0] dmac0_rid_apb;
wire                                           dmac0_rlast_apb;
wire                                           dmac0_rready_bus;
wire                                     [1:0] dmac0_rresp_apb;
wire                                           dmac0_rvalid_apb;
wire             [(CPUSUB_BIU_DATA_WIDTH-1):0] dmac0_wdata_bus;
wire                                           dmac0_wlast_bus;
wire                                           dmac0_wready_apb;
wire                  [(DMAC_WSTRB_WIDTH-1):0] dmac0_wstrb_bus;
wire                                           dmac0_wvalid_bus;
wire                [`ATCAPBBRG100_ADDR_MSB:0] ahb2apb_haddr;
wire                                     [3:0] ahb2apb_hprot;
wire                                           ahb2apb_hready_in;
wire                                           ahb2apb_hsel;
wire                                     [2:0] ahb2apb_hsize;
wire                                     [1:0] ahb2apb_htrans;
wire                                    [31:0] ahb2apb_hwdata;
wire                                           ahb2apb_hwrite;
wire          [(`ATCBUSDEC200_DATA_WIDTH-1):0] hbmc_hrdata;
wire                                           hbmc_hreadyout;
wire                                     [1:0] hbmc_hresp;
wire                                           lcd_intr;
wire                                           mac_int;
wire                                           aclk;
wire                                           ahb2core_clken;
wire                                           apb2ahb_clken;
wire                                           apb2core_clken;
wire                                           aresetn;
wire                                           axi2core_clken;
wire                             [(NHART-1):0] core_clk;
wire                                   [255:0] core_reset_vectors;
wire                             [(NHART-1):0] core_resetn;
wire                             [(NHART-1):0] dc_clk;
wire                                           extclk;
wire                                           hart0_dcache_disable_init;
wire                                           hart0_icache_disable_init;
wire                                           hclk;
wire                                           hresetn;
wire                             [INT_NUM-1:0] int_src;
wire                             [(NHART-1):0] lm_clk;
wire                                           pclk;
wire                                           pclk_gpio;
wire                                           pclk_i2c;
wire                                           pclk_pit;
wire                                           pclk_spi1;
wire                                           pclk_spi2;
wire                                           pclk_uart1;
wire                                           pclk_uart2;
wire                                           pclk_wdt;
wire                                           pcs0_iso;
wire                                           pcs1_iso;
wire                                           pcs2_iso;
wire                                           pcs3_iso;
wire                                           pcs4_iso;
wire                                           pcs5_iso;
wire                                           pcs6_iso;
wire                                           pd0_vol_on;
wire                                           pd1_vol_on;
wire                                           pd2_vol_on;
wire                                           pd3_vol_on;
wire                                           pd4_vol_on;
wire                                           pd5_vol_on;
wire                                           pd6_vol_on;
wire                                           por_rstn;
wire                                           presetn;
wire                                           scan_enable;
wire                                           scan_test;
wire                                           sdc_clk;
wire                                    [31:0] smu_prdata;
wire                                           smu_pready;
wire                                           smu_pslverr;
wire                                           spi_clk;
wire                                           spi_rstn;
wire                             [(NHART-1):0] te_clk;
wire                                           test_mode;
wire                                           test_rstn;
wire                                           uart_clk;
wire                                           uart_rstn;
wire                                    [31:0] ahb2apb_hrdata;
wire                                           ahb2apb_hready;
wire                                     [1:0] ahb2apb_hresp;
wire                                           dma_int;
wire                        [(ADDR_WIDTH-1):0] dmac0_araddr_apb;
wire                                     [1:0] dmac0_arburst_apb;
wire                                     [3:0] dmac0_arcache_apb;
wire                     [(DMAC_ID_WIDTH-1):0] dmac0_arid_apb;
wire                                     [7:0] dmac0_arlen_apb;
wire                                           dmac0_arlock_apb;
wire                                     [2:0] dmac0_arprot_apb;
wire                                     [2:0] dmac0_arsize_apb;
wire                                           dmac0_arvalid_apb;
wire                        [(ADDR_WIDTH-1):0] dmac0_awaddr_apb;
wire                                     [1:0] dmac0_awburst_apb;
wire                                     [3:0] dmac0_awcache_apb;
wire                     [(DMAC_ID_WIDTH-1):0] dmac0_awid_apb;
wire                                     [7:0] dmac0_awlen_apb;
wire                                           dmac0_awlock_apb;
wire                                     [2:0] dmac0_awprot_apb;
wire                                     [2:0] dmac0_awsize_apb;
wire                                           dmac0_awvalid_apb;
wire                                           dmac0_bready_apb;
wire                                           dmac0_rready_apb;
wire               [(DMAC_DATA_WIDTH_FIX-1):0] dmac0_wdata_apb;
wire                                           dmac0_wlast_apb;
wire           [((DMAC_DATA_WIDTH_FIX/8)-1):0] dmac0_wstrb_apb;
wire                                           dmac0_wvalid_apb;
wire                                           gpio_intr;
wire                                           i2c2_int;
wire                                           i2c_int;
wire                [`ATCAPBBRG100_ADDR_MSB:0] paddr;
wire                                           penable;
wire                                           pit2_int;
wire                                           pit3_int;
wire                                           pit4_int;
wire                                           pit5_int;
wire                                           pit_intr;
wire                                    [31:0] pwdata;
wire                                           pwrite;
wire                                           sdc_int;
wire                                           smu_psel;
wire                                           spi1_int;
wire                                           spi2_int;
wire                                           spi3_int;
wire                                           spi4_int;
wire                                           ssp_intr;
wire                                           uart1_int;
wire                                           uart2_int;
wire                                           wdt_int;
wire                                           wdt_rst;
wire                                           dmac0_arready_bus;
wire                                           dmac0_awready_bus;
wire               [(CPUSUB_BIU_ID_WIDTH-1):0] dmac0_bid_bus;
wire                                     [1:0] dmac0_bresp_bus;
wire                                           dmac0_bvalid_bus;
wire             [(CPUSUB_BIU_DATA_WIDTH-1):0] dmac0_rdata_bus;
wire               [(CPUSUB_BIU_ID_WIDTH-1):0] dmac0_rid_bus;
wire                                           dmac0_rlast_bus;
wire                                     [1:0] dmac0_rresp_bus;
wire                                           dmac0_rvalid_bus;
wire                                           dmac0_wready_bus;
wire                              [ADDR_MSB:0] hbmc_haddr;
wire                                     [2:0] hbmc_hburst;
wire                                     [3:0] hbmc_hprot;
wire                                           hbmc_hready;
wire                                           hbmc_hsel;
wire                                     [2:0] hbmc_hsize;
wire                                     [1:0] hbmc_htrans;
wire                                    [31:0] hbmc_hwdata;
wire                                           hbmc_hwrite;
wire                              [ADDR_MSB:0] rom_haddr;
wire                                     [2:0] rom_hburst;
wire                                     [3:0] rom_hprot;
wire                                           rom_hready;
wire                                           rom_hsel;
wire                                     [2:0] rom_hsize;
wire                                     [1:0] rom_htrans;
wire                                    [31:0] rom_hwdata;
wire                                           rom_hwrite;
wire                                           dbg_srst_req;
wire                                           hart0_core_wfi_mode;
wire                                     [5:0] hart0_wakeup_event;
wire                                           T_hw_rstn;
wire                                           T_osch;
wire                                           T_por_b;
wire                                           init_calib_complete;
wire                                           ui_clk;
wire                                    [31:0] rom_hrdata;
wire                                           rom_hreadyout;
wire                                           rom_hresp;

localparam DMA_SIZEUP_ADDR_WIDTH = $clog2(CPUSUB_BIU_DATA_WIDTH) -3;
localparam DMA_SIZEUP_ADDR_MSB   = DMA_SIZEUP_ADDR_WIDTH -1;
`ifdef AE350_AXI_SUPPORT
`ifdef AE350_DMA_AXI_SUPPORT
    generate
    if (CPUSUB_BIU_DATA_WIDTH == 512) begin: dma_sizeup_for_512_sup
           atcsizeup300#(
                   .ID_WIDTH       (CPUSUB_BIU_ID_WIDTH),
                   .US_DATA_WIDTH  (DMAC_DATA_WIDTH_FIX),
                   .DS_DATA_WIDTH  (CPUSUB_BIU_DATA_WIDTH)
           ) sizeup_dma_axibus (
                   .aclk           (aclk                   ),
                   .aresetn        (aresetn                ),
                   .us_arid        (dmac0_arid_apb         ),
                   .us_araddr      (dmac0_araddr_apb[DMA_SIZEUP_ADDR_MSB:0]),
                   .us_arburst     (dmac0_arburst_apb      ),
                   .us_arlen       (dmac0_arlen_apb        ),
                   .us_arsize      (dmac0_arsize_apb       ),
                   .us_arvalid     (dmac0_arvalid_apb      ),
                   .us_arready     (dmac0_arready_apb      ),
                   .ds_arvalid     (dmac0_arvalid_bus      ),
                   .ds_arready     (dmac0_arready_bus      ),
                   .us_awid        (dmac0_awid_apb         ),
                   .us_awaddr      (dmac0_awaddr_apb[DMA_SIZEUP_ADDR_MSB:0]),
                   .us_awburst     (dmac0_awburst_apb      ),
                   .us_awlen       (dmac0_awlen_apb        ),
                   .us_awsize      (dmac0_awsize_apb       ),
                   .us_awvalid     (dmac0_awvalid_apb      ),
                   .us_awready     (dmac0_awready_apb      ),
                   .ds_awvalid     (dmac0_awvalid_bus      ),
                   .ds_awready     (dmac0_awready_bus      ),
                   .us_rid         (dmac0_rid_apb          ),
                   .us_rdata       (dmac0_rdata_apb        ),
                   .us_rlast       (dmac0_rlast_apb        ),
                   .us_rresp       (dmac0_rresp_apb        ),
                   .us_rvalid      (dmac0_rvalid_apb       ),
                   .us_rready      (dmac0_rready_apb       ),
                   .ds_rlast       (dmac0_rlast_bus        ),
                   .ds_rdata       (dmac0_rdata_bus        ),
                   .ds_rresp       (dmac0_rresp_bus        ),
                   .ds_rvalid      (dmac0_rvalid_bus       ),
                   .ds_rready      (dmac0_rready_bus       ),
                   .us_wstrb       (dmac0_wstrb_apb        ),
                   .us_wlast       (dmac0_wlast_apb        ),
                   .us_wdata       (dmac0_wdata_apb        ),
                   .us_wvalid      (dmac0_wvalid_apb       ),
                   .us_wready      (dmac0_wready_apb       ),
                   .ds_wstrb       (dmac0_wstrb_bus        ),
                   .ds_wdata       (dmac0_wdata_bus        ),
                   .ds_wlast       (dmac0_wlast_bus        ),
                   .ds_wvalid      (dmac0_wvalid_bus       ),
                   .ds_wready      (dmac0_wready_bus       ),
                   .us_bid         (dmac0_bid_apb          ),
                   .us_bvalid      (dmac0_bvalid_apb       ),
                   .us_bready      (dmac0_bready_apb       ),
                   .ds_bvalid      (dmac0_bvalid_bus       ),
                   .ds_bready      (dmac0_bready_bus       )
           );

            assign dmac0_araddr_bus  = dmac0_araddr_apb;
            assign dmac0_arburst_bus = dmac0_arburst_apb;
            assign dmac0_arcache_bus = dmac0_arcache_apb;
            assign dmac0_arid_bus    = dmac0_arid_apb;
            assign dmac0_arlen_bus   = dmac0_arlen_apb;
            assign dmac0_arlock_bus  = dmac0_arlock_apb;
            assign dmac0_arprot_bus  = dmac0_arprot_apb;
            assign dmac0_arsize_bus  = dmac0_arsize_apb;

            assign dmac0_awaddr_bus  = dmac0_awaddr_apb;
            assign dmac0_awburst_bus = dmac0_awburst_apb;
            assign dmac0_awcache_bus = dmac0_awcache_apb;
            assign dmac0_awid_bus    = dmac0_awid_apb;
            assign dmac0_awlen_bus   = dmac0_awlen_apb;
            assign dmac0_awlock_bus  = dmac0_awlock_apb;
            assign dmac0_awprot_bus  = dmac0_awprot_apb;
            assign dmac0_awsize_bus  = dmac0_awsize_apb;

            assign dmac0_bresp_apb   = dmac0_bresp_bus;

    end
    else begin: dma_connection
            assign dmac0_araddr_bus  = dmac0_araddr_apb;
            assign dmac0_arburst_bus = dmac0_arburst_apb;
            assign dmac0_arcache_bus = dmac0_arcache_apb;
            assign dmac0_arid_bus    = dmac0_arid_apb;
            assign dmac0_arlen_bus   = dmac0_arlen_apb;
            assign dmac0_arlock_bus  = dmac0_arlock_apb;
            assign dmac0_arprot_bus  = dmac0_arprot_apb;
            assign dmac0_arsize_bus  = dmac0_arsize_apb;
            assign dmac0_arvalid_bus = dmac0_arvalid_apb;

            assign dmac0_arready_apb = dmac0_arready_bus;

            assign dmac0_awaddr_bus  = dmac0_awaddr_apb;
            assign dmac0_awburst_bus = dmac0_awburst_apb;
            assign dmac0_awcache_bus = dmac0_awcache_apb;
            assign dmac0_awid_bus    = dmac0_awid_apb;
            assign dmac0_awlen_bus   = dmac0_awlen_apb;
            assign dmac0_awlock_bus  = dmac0_awlock_apb;
            assign dmac0_awprot_bus  = dmac0_awprot_apb;
            assign dmac0_awsize_bus  = dmac0_awsize_apb;
            assign dmac0_awvalid_bus = dmac0_awvalid_apb;

            assign dmac0_awready_apb = dmac0_awready_bus;

            assign dmac0_bid_apb     = dmac0_bid_bus;
            assign dmac0_bresp_apb   = dmac0_bresp_bus;
            assign dmac0_bvalid_apb  = dmac0_bvalid_bus;

            assign dmac0_bready_bus  = dmac0_bready_apb;

            assign dmac0_rdata_apb   = dmac0_rdata_bus;
            assign dmac0_rid_apb     = dmac0_rid_bus;
            assign dmac0_rlast_apb   = dmac0_rlast_bus;
            assign dmac0_rresp_apb   = dmac0_rresp_bus;
            assign dmac0_rvalid_apb  = dmac0_rvalid_bus;

            assign dmac0_rready_bus  = dmac0_rready_apb;

            assign dmac0_wdata_bus   = dmac0_wdata_apb;
            assign dmac0_wlast_bus   = dmac0_wlast_apb;
            assign dmac0_wstrb_bus   = dmac0_wstrb_apb;
            assign dmac0_wvalid_bus  = dmac0_wvalid_apb;

            assign dmac0_wready_apb  = dmac0_wready_bus;
   end
   endgenerate

`endif // AE350_DMA_AXI_SUPPORT
`endif // AE350_AXI_SUPPORT
`ifdef NDS_NHART
  `ifdef NDS_IO_L2C_IO_SLV
assign l2c_io_arready = 1'b0;
assign l2c_io_awready = 1'b0;
assign l2c_io_bid = {CPUSUB_BIU_ID_WIDTH{1'b0}};
assign l2c_io_bresp = 2'b0;
assign l2c_io_bvalid = 1'b0;
assign l2c_io_rdata = {CPUSUB_BIU_DATA_WIDTH{1'b0}};
assign l2c_io_rid = {CPUSUB_BIU_ID_WIDTH{1'b0}};
assign l2c_io_rlast = 1'b0;
assign l2c_io_rresp = 2'd0;
assign l2c_io_rvalid = 1'b0;
assign l2c_io_wready = 1'b0;
  `endif	// !NDS_IO_L2C_IO_SLV
`endif	// !NDS_NHART
`ifdef NDS_GATESIM
	`ifdef NDS_NHART
	`else
		`ifdef NDS_IO_ACE_VPU
			`ifdef NDS_CUSTOM_ACE_VPU
				assign cp_cpu_rdata = {ASP_DATA_WIDTH{1'b0}};
				assign cp_cpu_rdata_valid = 1'b0;
				assign cpu_cp_wdata_ready = 1'b0;
			`endif // NDS_CUSTOM_ACE_VPU
		`endif // NDS_IO_ACE_VPU
	`endif // NDS_NHART
`endif // NDS_GATESIM
`ifdef PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
assign hart0_trace_secure     = 1'b0;
assign hart0_power_down = 1'b0;
`ifndef NDS_IO_HAS_TRACE_CTYPE
       assign hart0_trace_ctype      = 2'd0;
       assign hart0_trace_context    = 32'd0;
`endif // NDS_IO_HAS_TRACE_CTYPE
`endif // NDS_IO_TRACE_INSTR
`else // !PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
assign hart0_trace_enabled = 1'b0;
`endif //NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
`ifdef NDS_NHART
`ifdef NDS_IO_HART1
       assign hart1_trace_secure     = 1'b0;
       `ifdef NDS_IO_L2C
               assign hart1_power_down = core1_wfi_sel_iso_sync;
       `else
               assign hart1_power_down = 1'b0;
       `endif // NDS_IO_L2C
       `ifndef NDS_IO_HAS_TRACE_CTYPE
               assign hart1_trace_ctype      = 2'd0;
               assign hart1_trace_context    = 32'd0;
       `endif // NDS_IO_HAS_TRACE_CTYPE
`endif // NDS_IO_HART1
`endif // NDS_NHART
`endif // NDS_IO_TRACE_INSTR
`else // !PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
`ifdef NDS_NHART
`ifdef NDS_IO_HART1
assign hart1_trace_enabled = 1'b0;
`endif // NDS_IO_HART1
`endif // NDS_NHART
`endif //NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
`ifdef NDS_NHART
`ifdef NDS_IO_HART2
       assign hart2_trace_secure     = 1'b0;
       `ifdef NDS_IO_L2C
               assign hart2_power_down = core2_wfi_sel_iso_sync;
       `else
               assign hart2_power_down = 1'b0;
       `endif // NDS_IO_L2C
       `ifndef NDS_IO_HAS_TRACE_CTYPE
               assign hart2_trace_ctype      = 2'd0;
               assign hart2_trace_context    = 32'd0;
       `endif // NDS_IO_HAS_TRACE_CTYPE
`endif // NDS_IO_HART2
`endif // NDS_NHART
`endif // NDS_IO_TRACE_INSTR
`else // !PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
`ifdef NDS_NHART
`ifdef NDS_IO_HART2
assign hart2_trace_enabled = 1'b0;
`endif // NDS_IO_HART2
`endif // NDS_NHART
`endif //NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
`ifdef NDS_NHART
`ifdef NDS_IO_HART3
       assign hart3_trace_secure     = 1'b0;
       `ifdef NDS_IO_L2C
               assign hart3_power_down = core3_wfi_sel_iso_sync;
       `else
               assign hart3_power_down = 1'b0;
       `endif // NDS_IO_L2C
       `ifndef NDS_IO_HAS_TRACE_CTYPE
               assign hart3_trace_ctype      = 2'd0;
               assign hart3_trace_context    = 32'd0;
       `endif // NDS_IO_HAS_TRACE_CTYPE
`endif // NDS_IO_HART3
`endif // NDS_NHART
`endif // NDS_IO_TRACE_INSTR
`else // !PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_TRACE_INSTR
`ifdef NDS_NHART
`ifdef NDS_IO_HART3
assign hart3_trace_enabled = 1'b0;
`endif // NDS_IO_HART3
`endif // NDS_NHART
`endif //NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef PLATFORM_NO_RAM_SUBSYSTEM
assign init_calib_complete = 1'b1;
assign ui_clk = 1'b0;
	`ifdef AE350_AHB_SUPPORT
assign ram_hrdata = {CPUSUB_BIU_DATA_WIDTH{1'b0}};
assign ram_hreadyout = 1'b1;
assign ram_hresp = 2'b0;
	`endif	// AE350_AHB_SUPPORT
`endif
`ifdef AE350_SPI1_SUPPORT
       assign spi_mem_haddr	= rom_haddr[31:0];
       assign spi_mem_hwrite	= rom_hwrite;
       assign spi_mem_htrans 	= rom_htrans;
    `ifdef AE350_SMC_SUPPORT
       assign spi_mem_hready	= dec_hready;
       assign smc_mem_hready 	= dec_hready;
    `else //AE350_SMC_SUPPORT
       assign spi_mem_hsel 	= 1'b1;
       assign spi_mem_hready	= spi_mem_hreadyout;

       assign rom_hrdata		= spi_mem_hrdata;
       assign rom_hresp 		= spi_mem_hresp[0];
       assign rom_hreadyout	= spi_mem_hreadyout;
    `endif //AE350_SMC_SUPPORT
`else //AE350_SPI1_SUPPORT
       assign smc_mem_hsel 	= 1'b1;
    `ifdef AE350_SMC_SUPPORT
       assign smc_mem_hready 	= smc_mem_hreadyout;
       assign rom_hreadyout	= smc_mem_hreadyout;
       assign rom_hresp  		= smc_mem_hresp[0];
       assign rom_hrdata 		= smc_mem_hrdata;
    `else //AE350_SMC_SUPPORT
       assign smc_mem_hready 	= 1'b1;
       assign rom_hreadyout	= 1'b0;
       assign rom_hresp  		= 1'b0;
       assign rom_hrdata 		= 32'd0;
    `endif //AE350_SMC_SUPPORT
`endif //AE350_SPI1_SUPPORT
`ifdef AE350_SMC_SUPPORT
   assign smc_mem_hwrite 	= rom_hwrite;
   assign smc_mem_hwdata 	= rom_hwdata;
   assign smc_mem_htrans 	= rom_htrans;
   assign smc_mem_haddr  	= {5'd0, rom_haddr[26:0]};
   assign smc_mem_hsize  	= rom_hsize;
   assign smc_mem_hburst 	= rom_hburst;
`endif //AE350_SMC_SUPPORT
wire	unused_wire;
assign unused_wire = pcs0_iso | pcs1_iso | pcs2_iso | pcs3_iso | pcs4_iso | pcs5_iso | pcs6_iso
			| pd0_vol_on | pd1_vol_on| pd2_vol_on | pd3_vol_on | pd4_vol_on | pd5_vol_on | pd6_vol_on;
`ifdef AE350_LCDC_SUPPORT
assign clpower = lcd_gpo[1];
`endif
`ifdef AE350_SMC_SUPPORT
	assign smc_cs_n_0 = smc_cs_n[0];
`endif
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	`ifdef PLATFORM_JDTM_SECURE_SUPPORT
		assign secure_mode = T_secure_mode;
		// ASCII: RISC-V@AndesTech
		assign secure_code = 128'h52495343_2d564041_6e646573_54656368;
	`endif // PLATFORM_JDTM_SECURE_SUPPORT
`endif //PLATFORM_DEBUG_SUBSYSTEM
`ifdef PLATFORM_DEBUG_PORT
    `ifdef PLATFORM_JTAG_TWOWIRE
            assign pin_tdi_in  = 1'b0;
            assign pin_trst_in = 1'b0;
    `endif // PLATFORM_JTAG_TWOWIRE
`endif //PLATFORM_DEBUG_PORT
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	`ifdef NDS_IO_TRACE_INSTR
		`ifdef NDS_NHART
		            assign dmi_clk = aclk;
		            assign atclk   = aclk;
		            assign tbuf_sys_aclk = aclk;
		`else
		    `ifdef NDS_IO_AHB
		            assign dmi_clk = hclk;
		            assign atclk   = hclk;
		            assign tbuf_sys_aclk = 1'b0;
		    `else
		            assign dmi_clk = aclk;
		            assign atclk   = aclk;
		            assign tbuf_sys_aclk = aclk;
		    `endif
		`endif // NDS_NHART
           assign tb_ram_ctrl_in = 1'b0;
	`endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef PLATFORM_DEBUG_SUBSYSTEM
       `ifndef NDS_IO_TRACE_INSTR
               assign pldm_dmi_haddr      = dmi_haddr[8:0];
               assign pldm_dmi_hburst     = dmi_hburst;
               assign pldm_dmi_hprot      = dmi_hprot;
               assign pldm_dmi_hready     = pldm_dmi_hreadyout;
               assign pldm_dmi_hsel       = dmi_hsel;
               assign pldm_dmi_hsize      = dmi_hsize;
               assign pldm_dmi_htrans     = dmi_htrans;
               assign pldm_dmi_hwdata     = dmi_hwdata;
               assign pldm_dmi_hwrite     = dmi_hwrite;
               assign pldm_dmi_resetn     = dmi_resetn;

               assign dmi_hrdata          = pldm_dmi_hrdata;
               assign dmi_hready          = pldm_dmi_hreadyout;
               assign dmi_hresp           = pldm_dmi_hresp;
       `endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifndef AE350_AXI_SUPPORT
	`ifdef PLATFORM_DEBUG_SUBSYSTEM
	`ifdef NDS_IO_TRACE_INSTR
	    assign tbuf_sys_arready	=  1'b0;
	    assign tbuf_sys_awready	=  1'b0;
	    assign tbuf_sys_bid		=  {CPUSUB_BIU_ID_WIDTH{1'b0}};
	    assign tbuf_sys_bresp	=  2'd0;
	    assign tbuf_sys_bvalid	=  1'b0;
	    assign tbuf_sys_rdata	=  {CPUSUB_BIU_DATA_WIDTH{1'b0}};
	    assign tbuf_sys_rid		=  {CPUSUB_BIU_ID_WIDTH{1'b0}};
	    assign tbuf_sys_rlast	=  1'b0;
	    assign tbuf_sys_rresp	=  2'd0;
	    assign tbuf_sys_rvalid	=  1'b0;
	    assign tbuf_sys_wready 	=  1'b0;
	`endif // NDS_IO_TRACE_INSTR
	`endif // PLATFORM_DEBUG_SUBSYSTEM
`endif // AE350_AXI_SUPPORT

ae350_bus_connector ae350_bus_connector (
`ifdef AE350_AXI_SUPPORT
	.ram_araddr      (ram_araddr       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_arburst     (ram_arburst      ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_arcache     (ram_arcache      ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_arid        (ram_arid         ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_arlen       (ram_arlen        ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_arlock      (ram_arlock       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_arprot      (ram_arprot       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_arready     (ram_arready      ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_arsize      (ram_arsize       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_arvalid     (ram_arvalid      ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_awaddr      (ram_awaddr       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_awburst     (ram_awburst      ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_awcache     (ram_awcache      ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_awid        (ram_awid         ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_awlen       (ram_awlen        ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_awlock      (ram_awlock       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_awprot      (ram_awprot       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_awready     (ram_awready      ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_awsize      (ram_awsize       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_awvalid     (ram_awvalid      ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_bid         (ram_bid          ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_bready      (ram_bready       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_bresp       (ram_bresp        ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_bvalid      (ram_bvalid       ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_rdata       (ram_rdata        ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_rid         (ram_rid          ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_rlast       (ram_rlast        ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_rready      (ram_rready       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_rresp       (ram_rresp        ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_rvalid      (ram_rvalid       ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_wdata       (ram_wdata        ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_wlast       (ram_wlast        ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_wready      (ram_wready       ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_wstrb       (ram_wstrb        ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_wvalid      (ram_wvalid       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
`endif // AE350_AXI_SUPPORT
`ifdef AE350_DMA_AXI_SUPPORT
	.dmac0_araddr    (dmac0_araddr_bus ), // (ae350_bus_connector) <= ()
	.dmac0_arburst   (dmac0_arburst_bus), // (ae350_bus_connector) <= ()
	.dmac0_arcache   (dmac0_arcache_bus), // (ae350_bus_connector) <= ()
	.dmac0_arid      (dmac0_arid_bus   ), // (ae350_bus_connector) <= ()
	.dmac0_arlen     (dmac0_arlen_bus  ), // (ae350_bus_connector) <= ()
	.dmac0_arlock    (dmac0_arlock_bus ), // (ae350_bus_connector) <= ()
	.dmac0_arprot    (dmac0_arprot_bus ), // (ae350_bus_connector) <= ()
	.dmac0_arready   (dmac0_arready_bus), // (ae350_bus_connector) => ()
	.dmac0_arsize    (dmac0_arsize_bus ), // (ae350_bus_connector) <= ()
	.dmac0_arvalid   (dmac0_arvalid_bus), // (ae350_bus_connector) <= ()
	.dmac0_awaddr    (dmac0_awaddr_bus ), // (ae350_bus_connector) <= ()
	.dmac0_awburst   (dmac0_awburst_bus), // (ae350_bus_connector) <= ()
	.dmac0_awcache   (dmac0_awcache_bus), // (ae350_bus_connector) <= ()
	.dmac0_awid      (dmac0_awid_bus   ), // (ae350_bus_connector) <= ()
	.dmac0_awlen     (dmac0_awlen_bus  ), // (ae350_bus_connector) <= ()
	.dmac0_awlock    (dmac0_awlock_bus ), // (ae350_bus_connector) <= ()
	.dmac0_awprot    (dmac0_awprot_bus ), // (ae350_bus_connector) <= ()
	.dmac0_awready   (dmac0_awready_bus), // (ae350_bus_connector) => ()
	.dmac0_awsize    (dmac0_awsize_bus ), // (ae350_bus_connector) <= ()
	.dmac0_awvalid   (dmac0_awvalid_bus), // (ae350_bus_connector) <= ()
	.dmac0_bid       (dmac0_bid_bus    ), // (ae350_bus_connector) => ()
	.dmac0_bready    (dmac0_bready_bus ), // (ae350_bus_connector) <= ()
	.dmac0_bresp     (dmac0_bresp_bus  ), // (ae350_bus_connector) => ()
	.dmac0_bvalid    (dmac0_bvalid_bus ), // (ae350_bus_connector) => ()
	.dmac0_rdata     (dmac0_rdata_bus  ), // (ae350_bus_connector) => ()
	.dmac0_rid       (dmac0_rid_bus    ), // (ae350_bus_connector) => ()
	.dmac0_rlast     (dmac0_rlast_bus  ), // (ae350_bus_connector) => ()
	.dmac0_rready    (dmac0_rready_bus ), // (ae350_bus_connector) <= ()
	.dmac0_rresp     (dmac0_rresp_bus  ), // (ae350_bus_connector) => ()
	.dmac0_rvalid    (dmac0_rvalid_bus ), // (ae350_bus_connector) => ()
	.dmac0_wdata     (dmac0_wdata_bus  ), // (ae350_bus_connector) <= ()
	.dmac0_wlast     (dmac0_wlast_bus  ), // (ae350_bus_connector) <= ()
	.dmac0_wready    (dmac0_wready_bus ), // (ae350_bus_connector) => ()
	.dmac0_wstrb     (dmac0_wstrb_bus  ), // (ae350_bus_connector) <= ()
	.dmac0_wvalid    (dmac0_wvalid_bus ), // (ae350_bus_connector) <= ()
`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_AHB_SUPPORT
	.ram_haddr       (ram_haddr        ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.bmc_intr        (bmc_intr         ), // (ae350_bus_connector) => (ae350_aopd)
	.ram_hburst      (ram_hburst       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_hprot       (ram_hprot        ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_hrdata      (ram_hrdata       ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_hready      (ram_hready       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_hreadyout   (ram_hreadyout    ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_hresp       (ram_hresp        ), // (ae350_bus_connector) <= (ae350_ram_subsystem)
	.ram_hsel        (ram_hsel         ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_hsize       (ram_hsize        ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_htrans      (ram_htrans       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_hwdata      (ram_hwdata       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
	.ram_hwrite      (ram_hwrite       ), // (ae350_bus_connector) => (ae350_ram_subsystem)
`endif // AE350_AHB_SUPPORT
`ifdef AE350_DMA_AHB_SUPPORT
	.dmac_haddr      (dmac_haddr       ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac_hburst     (dmac_hburst      ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac_hprot      (dmac_hprot       ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac_hrdata     (dmac_hrdata      ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac_hready     (dmac_hready      ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac_hresp      (dmac_hresp       ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac_hsize      (dmac_hsize       ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac_htrans     (dmac_htrans      ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac_hwdata     (dmac_hwdata      ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac_hwrite     (dmac_hwrite      ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
`endif // AE350_DMA_AHB_SUPPORT
`ifdef AE350_MAC_SUPPORT
	.mac_hburst      (mac_hburst       ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.mac_hprot       (mac_hprot        ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.mac_hreadyout   (mac_hreadyout    ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.mac_hresp       (mac_hresp        ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.mac_hsize       (mac_hsize        ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.mac_haddr       (mac_haddr        ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.mac_hrdata      (mac_hrdata       ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.mac_htrans      (mac_htrans       ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.mac_hwdata      (mac_hwdata       ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.mac_hwrite      (mac_hwrite       ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
`endif // AE350_MAC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
	.lcdc_hburst     (lcdc_hburst      ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.lcdc_hprot      (lcdc_hprot       ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.lcdc_hreadyout  (lcdc_hreadyout   ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.lcdc_hresp      (lcdc_hresp       ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.lcdc_hsize      (lcdc_hsize       ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.lcdc_haddr      (lcdc_haddr       ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.lcdc_hrdata     (lcdc_hrdata      ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.lcdc_htrans     (lcdc_htrans      ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.lcdc_hwdata     (lcdc_hwdata      ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.lcdc_hwrite     (lcdc_hwrite      ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
`endif // AE350_LCDC_SUPPORT
`ifdef AE350_AXI_SUPPORT
   `ifdef NDS_IO_BIU_X2
	.cpu_d_araddr    (cpu_d_araddr     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_arburst   (cpu_d_arburst    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_arcache   (cpu_d_arcache    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_arid      (cpu_d_arid       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_arlen     (cpu_d_arlen      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_arlock    (cpu_d_arlock     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_arprot    (cpu_d_arprot     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_arready   (cpu_d_arready    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_arsize    (cpu_d_arsize     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_arvalid   (cpu_d_arvalid    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_awaddr    (cpu_d_awaddr     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_awburst   (cpu_d_awburst    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_awcache   (cpu_d_awcache    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_awid      (cpu_d_awid       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_awlen     (cpu_d_awlen      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_awlock    (cpu_d_awlock     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_awprot    (cpu_d_awprot     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_awready   (cpu_d_awready    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_awsize    (cpu_d_awsize     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_awvalid   (cpu_d_awvalid    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_bid       (cpu_d_bid        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_bready    (cpu_d_bready     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_bresp     (cpu_d_bresp      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_bvalid    (cpu_d_bvalid     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_rdata     (cpu_d_rdata      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_rid       (cpu_d_rid        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_rlast     (cpu_d_rlast      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_rready    (cpu_d_rready     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_rresp     (cpu_d_rresp      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_rvalid    (cpu_d_rvalid     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_wdata     (cpu_d_wdata      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_wlast     (cpu_d_wlast      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_wready    (cpu_d_wready     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_wstrb     (cpu_d_wstrb      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_wvalid    (cpu_d_wvalid     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_araddr    (cpu_i_araddr     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_arburst   (cpu_i_arburst    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_arcache   (cpu_i_arcache    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_arid      (cpu_i_arid       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_arlen     (cpu_i_arlen      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_arlock    (cpu_i_arlock     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_arprot    (cpu_i_arprot     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_arready   (cpu_i_arready    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_arsize    (cpu_i_arsize     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_arvalid   (cpu_i_arvalid    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_awaddr    (cpu_i_awaddr     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_awburst   (cpu_i_awburst    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_awcache   (cpu_i_awcache    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_awid      (cpu_i_awid       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_awlen     (cpu_i_awlen      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_awlock    (cpu_i_awlock     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_awprot    (cpu_i_awprot     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_awready   (cpu_i_awready    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_awsize    (cpu_i_awsize     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_awvalid   (cpu_i_awvalid    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_bid       (cpu_i_bid        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_bready    (cpu_i_bready     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_bresp     (cpu_i_bresp      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_bvalid    (cpu_i_bvalid     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_rdata     (cpu_i_rdata      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_rid       (cpu_i_rid        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_rlast     (cpu_i_rlast      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_rready    (cpu_i_rready     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_rresp     (cpu_i_rresp      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_rvalid    (cpu_i_rvalid     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_wdata     (cpu_i_wdata      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_wlast     (cpu_i_wlast      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_wready    (cpu_i_wready     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_wstrb     (cpu_i_wstrb      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_wvalid    (cpu_i_wvalid     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
   `else
	.cpu_araddr      (cpu_araddr       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_arburst     (cpu_arburst      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_arcache     (cpu_arcache      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_arid        (cpu_arid         ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_arlen       (cpu_arlen        ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_arlock      (cpu_arlock       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_arprot      (cpu_arprot       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_arready     (cpu_arready      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_arsize      (cpu_arsize       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_arvalid     (cpu_arvalid      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_awaddr      (cpu_awaddr       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_awburst     (cpu_awburst      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_awcache     (cpu_awcache      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_awid        (cpu_awid         ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_awlen       (cpu_awlen        ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_awlock      (cpu_awlock       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_awprot      (cpu_awprot       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_awready     (cpu_awready      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_awsize      (cpu_awsize       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_awvalid     (cpu_awvalid      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_bid         (cpu_bid          ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_bready      (cpu_bready       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_bresp       (cpu_bresp        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_bvalid      (cpu_bvalid       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_rdata       (cpu_rdata        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_rid         (cpu_rid          ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_rlast       (cpu_rlast        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_rready      (cpu_rready       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_rresp       (cpu_rresp        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_rvalid      (cpu_rvalid       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_wdata       (cpu_wdata        ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_wlast       (cpu_wlast        ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_wready      (cpu_wready       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_wstrb       (cpu_wstrb        ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_wvalid      (cpu_wvalid       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
   `endif // NDS_IO_BIU_X2
   `ifdef NDS_IO_SLAVEPORT
	.cpuslv_arid     (cpuslv_arid      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_awid     (cpuslv_awid      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_bid      (cpuslv_bid       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_rid      (cpuslv_rid       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_araddr   (cpuslv_araddr    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_arburst  (cpuslv_arburst   ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_arcache  (cpuslv_arcache   ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_arlen    (cpuslv_arlen     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_arlock   (cpuslv_arlock    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_arprot   (cpuslv_arprot    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_arready  (cpuslv_arready   ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_arsize   (cpuslv_arsize    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_arvalid  (cpuslv_arvalid   ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_awaddr   (cpuslv_awaddr    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_awburst  (cpuslv_awburst   ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_awcache  (cpuslv_awcache   ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_awlen    (cpuslv_awlen     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_awlock   (cpuslv_awlock    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_awprot   (cpuslv_awprot    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_awready  (cpuslv_awready   ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_awsize   (cpuslv_awsize    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_awvalid  (cpuslv_awvalid   ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_bready   (cpuslv_bready    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_bresp    (cpuslv_bresp     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_bvalid   (cpuslv_bvalid    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_rdata    (cpuslv_rdata     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_rlast    (cpuslv_rlast     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_rready   (cpuslv_rready    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_rresp    (cpuslv_rresp     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_rvalid   (cpuslv_rvalid    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_wdata    (cpuslv_wdata     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_wlast    (cpuslv_wlast     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_wready   (cpuslv_wready    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_wstrb    (cpuslv_wstrb     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_wvalid   (cpuslv_wvalid    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
   `endif // NDS_IO_SLAVEPORT
`endif // AE350_AXI_SUPPORT
`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dmac1_araddr    (dmac1_araddr     ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_arburst   (dmac1_arburst    ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_arcache   (dmac1_arcache    ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_arid      (dmac1_arid       ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_arlen     (dmac1_arlen      ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_arlock    (dmac1_arlock     ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_arprot    (dmac1_arprot     ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_arready   (dmac1_arready    ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac1_arsize    (dmac1_arsize     ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_arvalid   (dmac1_arvalid    ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_awaddr    (dmac1_awaddr     ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_awburst   (dmac1_awburst    ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_awcache   (dmac1_awcache    ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_awid      (dmac1_awid       ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_awlen     (dmac1_awlen      ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_awlock    (dmac1_awlock     ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_awprot    (dmac1_awprot     ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_awready   (dmac1_awready    ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac1_awsize    (dmac1_awsize     ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_awvalid   (dmac1_awvalid    ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_bid       (dmac1_bid        ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac1_bready    (dmac1_bready     ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_bresp     (dmac1_bresp      ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac1_bvalid    (dmac1_bvalid     ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac1_rdata     (dmac1_rdata      ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac1_rid       (dmac1_rid        ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac1_rlast     (dmac1_rlast      ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac1_rready    (dmac1_rready     ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_rresp     (dmac1_rresp      ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac1_rvalid    (dmac1_rvalid     ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac1_wdata     (dmac1_wdata      ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_wlast     (dmac1_wlast      ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_wready    (dmac1_wready     ), // (ae350_bus_connector) => (ae350_apb_subsystem)
	.dmac1_wstrb     (dmac1_wstrb      ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
	.dmac1_wvalid    (dmac1_wvalid     ), // (ae350_bus_connector) <= (ae350_apb_subsystem)
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_AHB_SUPPORT
   `ifdef NDS_IO_BIU_X2
	.cpu_d_haddr     (cpu_d_haddr      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_hburst    (cpu_d_hburst     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_hprot     (cpu_d_hprot      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_hrdata    (cpu_d_hrdata     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_hready    (cpu_d_hready     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_hresp     (cpu_d_hresp      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_d_hsize     (cpu_d_hsize      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_htrans    (cpu_d_htrans     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_hwdata    (cpu_d_hwdata     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_d_hwrite    (cpu_d_hwrite     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_haddr     (cpu_i_haddr      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_hburst    (cpu_i_hburst     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_hprot     (cpu_i_hprot      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_hrdata    (cpu_i_hrdata     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_hready    (cpu_i_hready     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_hresp     (cpu_i_hresp      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_i_hsize     (cpu_i_hsize      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_htrans    (cpu_i_htrans     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_hwdata    (cpu_i_hwdata     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_i_hwrite    (cpu_i_hwrite     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
   `else
	.cpu_haddr       (cpu_haddr        ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_hburst      (cpu_hburst       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_hprot       (cpu_hprot        ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_hrdata      (cpu_hrdata       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_hready      (cpu_hready       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_hresp       (cpu_hresp        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpu_hsize       (cpu_hsize        ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_htrans      (cpu_htrans       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_hwdata      (cpu_hwdata       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpu_hwrite      (cpu_hwrite       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
   `endif // NDS_IO_BIU_X2
   `ifdef NDS_IO_SLAVEPORT
	.cpuslv_haddr    (cpuslv_haddr     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_hburst   (cpuslv_hburst    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_hprot    (cpuslv_hprot     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_hrdata   (cpuslv_hrdata    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_hready   (cpuslv_hready    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_hreadyout(cpuslv_hreadyout ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_hresp    (cpuslv_hresp     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.cpuslv_hsel     (cpuslv_hsel      ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_hsize    (cpuslv_hsize     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_htrans   (cpuslv_htrans    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_hwdata   (cpuslv_hwdata    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.cpuslv_hwrite   (cpuslv_hwrite    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
   `endif // NDS_IO_SLAVEPORT
`endif // AE350_AHB_SUPPORT
`ifdef AE350_AXI_SUPPORT
   `ifdef PLATFORM_DEBUG_SUBSYSTEM
      `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
	.dm_sys_araddr   (dm_sys_araddr    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_arburst  (dm_sys_arburst   ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_arcache  (dm_sys_arcache   ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_arid     (dm_sys_arid      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_arlen    (dm_sys_arlen     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_arlock   (dm_sys_arlock    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_arprot   (dm_sys_arprot    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_arready  (dm_sys_arready   ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_arsize   (dm_sys_arsize    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_arvalid  (dm_sys_arvalid   ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_awaddr   (dm_sys_awaddr    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_awburst  (dm_sys_awburst   ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_awcache  (dm_sys_awcache   ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_awid     (dm_sys_awid      ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_awlen    (dm_sys_awlen     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_awlock   (dm_sys_awlock    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_awprot   (dm_sys_awprot    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_awready  (dm_sys_awready   ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_awsize   (dm_sys_awsize    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_awvalid  (dm_sys_awvalid   ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_bid      (dm_sys_bid       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_bready   (dm_sys_bready    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_bresp    (dm_sys_bresp     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_bvalid   (dm_sys_bvalid    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_rdata    (dm_sys_rdata     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_rid      (dm_sys_rid       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_rlast    (dm_sys_rlast     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_rready   (dm_sys_rready    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_rresp    (dm_sys_rresp     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_rvalid   (dm_sys_rvalid    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_wdata    (dm_sys_wdata     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_wlast    (dm_sys_wlast     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_wready   (dm_sys_wready    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_wstrb    (dm_sys_wstrb     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_wvalid   (dm_sys_wvalid    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
      `endif // PLATFORM_PLDM_SYS_BUS_ACCESS
      `ifdef NDS_IO_TRACE_INSTR
	.tbuf_sys_araddr (tbuf_sys_araddr  ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_arburst(tbuf_sys_arburst ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_arcache(tbuf_sys_arcache ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_arid   (tbuf_sys_arid    ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_arlen  (tbuf_sys_arlen   ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_arlock (tbuf_sys_arlock  ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_arprot (tbuf_sys_arprot  ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_arready(tbuf_sys_arready ), // (ae350_bus_connector) => (ncetrace200)
	.tbuf_sys_arsize (tbuf_sys_arsize  ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_arvalid(tbuf_sys_arvalid ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_awaddr (tbuf_sys_awaddr  ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_awburst(tbuf_sys_awburst ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_awcache(tbuf_sys_awcache ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_awid   (tbuf_sys_awid    ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_awlen  (tbuf_sys_awlen   ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_awlock (tbuf_sys_awlock  ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_awprot (tbuf_sys_awprot  ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_awready(tbuf_sys_awready ), // (ae350_bus_connector) => (ncetrace200)
	.tbuf_sys_awsize (tbuf_sys_awsize  ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_awvalid(tbuf_sys_awvalid ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_bid    (tbuf_sys_bid     ), // (ae350_bus_connector) => (ncetrace200)
	.tbuf_sys_bready (tbuf_sys_bready  ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_bresp  (tbuf_sys_bresp   ), // (ae350_bus_connector) => (ncetrace200)
	.tbuf_sys_bvalid (tbuf_sys_bvalid  ), // (ae350_bus_connector) => (ncetrace200)
	.tbuf_sys_rdata  (tbuf_sys_rdata   ), // (ae350_bus_connector) => (ncetrace200)
	.tbuf_sys_rid    (tbuf_sys_rid     ), // (ae350_bus_connector) => (ncetrace200)
	.tbuf_sys_rlast  (tbuf_sys_rlast   ), // (ae350_bus_connector) => (ncetrace200)
	.tbuf_sys_rready (tbuf_sys_rready  ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_rresp  (tbuf_sys_rresp   ), // (ae350_bus_connector) => (ncetrace200)
	.tbuf_sys_rvalid (tbuf_sys_rvalid  ), // (ae350_bus_connector) => (ncetrace200)
	.tbuf_sys_wdata  (tbuf_sys_wdata   ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_wlast  (tbuf_sys_wlast   ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_wready (tbuf_sys_wready  ), // (ae350_bus_connector) => (ncetrace200)
	.tbuf_sys_wstrb  (tbuf_sys_wstrb   ), // (ae350_bus_connector) <= (ncetrace200)
	.tbuf_sys_wvalid (tbuf_sys_wvalid  ), // (ae350_bus_connector) <= (ncetrace200)
      `endif // NDS_IO_TRACE_INSTR
   `endif // PLATFORM_DEBUG_SUBSYSTEM
`endif // AE350_AXI_SUPPORT
`ifdef NDS_NHART
   `ifdef NDS_IO_L2C
      `ifdef NDS_IO_L2C_IO_COHERENCE
	.m4_araddr       (m4_araddr        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_arburst      (m4_arburst       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_arcache      (m4_arcache       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_arid         (m4_arid          ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_arlen        (m4_arlen         ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_arlock       (m4_arlock        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_arprot       (m4_arprot        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_arready      (m4_arready       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.m4_arsize       (m4_arsize        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_arvalid      (m4_arvalid       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_awaddr       (m4_awaddr        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_awburst      (m4_awburst       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_awcache      (m4_awcache       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_awid         (m4_awid          ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_awlen        (m4_awlen         ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_awlock       (m4_awlock        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_awprot       (m4_awprot        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_awready      (m4_awready       ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.m4_awsize       (m4_awsize        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_awvalid      (m4_awvalid       ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_bid          (m4_bid           ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.m4_bready       (m4_bready        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_bresp        (m4_bresp         ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.m4_bvalid       (m4_bvalid        ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.m4_rdata        (m4_rdata         ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.m4_rid          (m4_rid           ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.m4_rlast        (m4_rlast         ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.m4_rready       (m4_rready        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_rresp        (m4_rresp         ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.m4_rvalid       (m4_rvalid        ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.m4_wdata        (m4_wdata         ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_wlast        (m4_wlast         ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_wready       (m4_wready        ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.m4_wstrb        (m4_wstrb         ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.m4_wvalid       (m4_wvalid        ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
      `endif // NDS_IO_L2C_IO_COHERENCE
   `endif // NDS_IO_L2C
`endif // NDS_NHART
`ifdef AE350_AHB_SUPPORT
   `ifdef PLATFORM_DEBUG_SUBSYSTEM
      `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
	.dm_sys_haddr    (dm_sys_haddr     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_hburst   (dm_sys_hburst    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_hprot    (dm_sys_hprot     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_hrdata   (dm_sys_hrdata    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_hready   (dm_sys_hready    ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_hresp    (dm_sys_hresp     ), // (ae350_bus_connector) => (ae350_cpu_subsystem)
	.dm_sys_hsize    (dm_sys_hsize     ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_htrans   (dm_sys_htrans    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_hwdata   (dm_sys_hwdata    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
	.dm_sys_hwrite   (dm_sys_hwrite    ), // (ae350_bus_connector) <= (ae350_cpu_subsystem)
      `endif // PLATFORM_PLDM_SYS_BUS_ACCESS
   `endif // PLATFORM_DEBUG_SUBSYSTEM
`endif // AE350_AHB_SUPPORT
	.hbmc_hready     (hbmc_hready      ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.hbmc_hsel       (hbmc_hsel        ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.rom_hready      (rom_hready       ), // (ae350_bus_connector) => (u_rom_ahbdec)
	.rom_hsel        (rom_hsel         ), // (ae350_bus_connector) => ()
	.aclk            (aclk             ), // (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem) <= (ae350_aopd)
	.aresetn         (aresetn          ), // (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,ncetrace200) <= (ae350_aopd)
	.hclk            (hclk             ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
	.hresetn         (hresetn          ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
	.rom_haddr       (rom_haddr        ), // (ae350_bus_connector) => (u_rom_ahbdec)
	.rom_hburst      (rom_hburst       ), // (ae350_bus_connector) => ()
	.rom_hprot       (rom_hprot        ), // (ae350_bus_connector) => ()
	.rom_hrdata      (rom_hrdata       ), // (ae350_bus_connector) <= (u_rom_ahbdec)
	.rom_hreadyout   (rom_hreadyout    ), // (ae350_bus_connector) <= (u_rom_ahbdec)
	.rom_hresp       (rom_hresp        ), // (ae350_bus_connector) <= (u_rom_ahbdec)
	.rom_hsize       (rom_hsize        ), // (ae350_bus_connector) => ()
	.rom_htrans      (rom_htrans       ), // (ae350_bus_connector) => (u_rom_ahbdec)
	.rom_hwdata      (rom_hwdata       ), // (ae350_bus_connector) => ()
	.rom_hwrite      (rom_hwrite       ), // (ae350_bus_connector) => ()
	.hbmc_haddr      (hbmc_haddr       ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.hbmc_hburst     (hbmc_hburst      ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.hbmc_hprot      (hbmc_hprot       ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.hbmc_hrdata     (hbmc_hrdata      ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.hbmc_hreadyout  (hbmc_hreadyout   ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.hbmc_hresp      (hbmc_hresp       ), // (ae350_bus_connector) <= (ae350_ahb_subsystem)
	.hbmc_hsize      (hbmc_hsize       ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.hbmc_htrans     (hbmc_htrans      ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.hbmc_hwdata     (hbmc_hwdata      ), // (ae350_bus_connector) => (ae350_ahb_subsystem)
	.hbmc_hwrite     (hbmc_hwrite      )  // (ae350_bus_connector) => (ae350_ahb_subsystem)
); // end of ae350_bus_connector

ae350_ahb_subsystem #(
	.ADDR_MSB        (ADDR_MSB        )
) ae350_ahb_subsystem (
`ifdef AE350_SMC_SUPPORT
	.T_memdata        (T_memdata         ), // (ae350_ahb_subsystem) <= (ae350_pin)
	.smc_addr         (smc_addr          ), // (ae350_ahb_subsystem) => (ae350_pin)
	.smc_cs_n         (smc_cs_n          ), // (ae350_ahb_subsystem) => ()
	.smc_data_oe      (smc_data_oe       ), // (ae350_ahb_subsystem) => (ae350_pin)
	.smc_dqout        (smc_dqout         ), // (ae350_ahb_subsystem) => (ae350_pin)
	.smc_mem_hrdata   (smc_mem_hrdata    ), // (ae350_ahb_subsystem) => (u_rom_ahbdec)
	.smc_mem_hreadyout(smc_mem_hreadyout ), // (ae350_ahb_subsystem) => (u_rom_ahbdec)
	.smc_mem_hresp    (smc_mem_hresp[1:0]), // (ae350_ahb_subsystem) => (u_rom_ahbdec)
	.smc_mem_hsel     (smc_mem_hsel      ), // (ae350_ahb_subsystem) <= (u_rom_ahbdec)
	.smc_oe_n         (smc_oe_n          ), // (ae350_ahb_subsystem) => (ae350_pin)
	.smc_we_n         (smc_we_n          ), // (ae350_ahb_subsystem) => (ae350_pin)
`endif // AE350_SMC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
	.lcdc_hwdata      (lcdc_hwdata       ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.clac             (clac              ), // (ae350_ahb_subsystem) => (ae350_pin)
	.clcp             (clcp              ), // (ae350_ahb_subsystem) => (ae350_pin)
	.cld              (cld               ), // (ae350_ahb_subsystem) => (ae350_pin)
	.clfp             (clfp              ), // (ae350_ahb_subsystem) => (ae350_pin)
	.clle             (clle              ), // (ae350_ahb_subsystem) => (ae350_pin)
	.cllp             (cllp              ), // (ae350_ahb_subsystem) => (ae350_pin)
	.lcd_clk          (lcd_clk           ), // (ae350_ahb_subsystem) <= (ae350_aopd)
	.lcd_clkn         (lcd_clkn          ), // (ae350_ahb_subsystem) <= (ae350_aopd)
	.lcd_gpo          (lcd_gpo           ), // (ae350_ahb_subsystem) => ()
	.lcdc_haddr       (lcdc_haddr        ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.lcdc_hburst      (lcdc_hburst       ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.lcdc_hprot       (lcdc_hprot        ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.lcdc_hrdata      (lcdc_hrdata       ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.lcdc_hreadyout   (lcdc_hreadyout    ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.lcdc_hresp       (lcdc_hresp        ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.lcdc_hsize       (lcdc_hsize        ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.lcdc_htrans      (lcdc_htrans       ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.lcdc_hwrite      (lcdc_hwrite       ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
`endif // AE350_LCDC_SUPPORT
`ifdef ATCBUSDEC200_SLV1_SUPPORT
	.ahb2apb_haddr    (ahb2apb_haddr     ), // (ae350_ahb_subsystem) => (ae350_apb_subsystem)
	.ahb2apb_hprot    (ahb2apb_hprot     ), // (ae350_ahb_subsystem) => (ae350_apb_subsystem)
	.ahb2apb_hready_in(ahb2apb_hready_in ), // (ae350_ahb_subsystem) => (ae350_apb_subsystem)
	.ahb2apb_hsize    (ahb2apb_hsize     ), // (ae350_ahb_subsystem) => (ae350_apb_subsystem)
	.ahb2apb_htrans   (ahb2apb_htrans    ), // (ae350_ahb_subsystem) => (ae350_apb_subsystem)
	.ahb2apb_hwdata   (ahb2apb_hwdata    ), // (ae350_ahb_subsystem) => (ae350_apb_subsystem)
	.ahb2apb_hwrite   (ahb2apb_hwrite    ), // (ae350_ahb_subsystem) => (ae350_apb_subsystem)
	.ahb2apb_hrdata   (ahb2apb_hrdata    ), // (ae350_ahb_subsystem) <= (ae350_apb_subsystem)
	.ahb2apb_hready   (ahb2apb_hready    ), // (ae350_ahb_subsystem) <= (ae350_apb_subsystem)
	.ahb2apb_hresp    (ahb2apb_hresp     ), // (ae350_ahb_subsystem) <= (ae350_apb_subsystem)
	.ahb2apb_hsel     (ahb2apb_hsel      ), // (ae350_ahb_subsystem) => (ae350_apb_subsystem)
`endif // ATCBUSDEC200_SLV1_SUPPORT
`ifdef AE350_MAC_SUPPORT
	.T_col            (T_col             ), // (ae350_ahb_subsystem) <= (ae350_pin)
	.T_crs            (T_crs             ), // (ae350_ahb_subsystem) <= (ae350_pin)
	.T_mdio           (T_mdio            ), // (ae350_ahb_subsystem) <= (ae350_pin)
	.T_phy_linksts    (T_phy_linksts     ), // (ae350_ahb_subsystem) <= (ae350_pin)
	.T_rx_clk         (T_rx_clk          ), // (ae350_ahb_subsystem) <= (ae350_pin)
	.T_rx_dv          (T_rx_dv           ), // (ae350_ahb_subsystem) <= (ae350_pin)
	.T_rx_er          (T_rx_er           ), // (ae350_ahb_subsystem) <= (ae350_pin)
	.T_rxd            (T_rxd             ), // (ae350_ahb_subsystem) <= (ae350_pin)
	.T_tx_clk         (T_tx_clk          ), // (ae350_ahb_subsystem) <= (ae350_pin)
	.mac_haddr        (mac_haddr         ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.mac_hburst       (mac_hburst        ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.mac_hprot        (mac_hprot         ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.mac_hrdata       (mac_hrdata        ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.mac_hresp        (mac_hresp         ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.mac_hsize        (mac_hsize         ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.mac_htrans       (mac_htrans        ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.mac_hwdata       (mac_hwdata        ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.mac_hwrite       (mac_hwrite        ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.mdc              (mdc               ), // (ae350_ahb_subsystem) => (ae350_pin)
	.mdio_out         (mdio_out          ), // (ae350_ahb_subsystem) => (ae350_pin)
	.mdio_out_en      (mdio_out_en       ), // (ae350_ahb_subsystem) => (ae350_pin)
	.pdn_phy          (pdn_phy           ), // (ae350_ahb_subsystem) => (ae350_pin)
	.tx_en            (tx_en             ), // (ae350_ahb_subsystem) => (ae350_pin)
	.txd              (txd               ), // (ae350_ahb_subsystem) => (ae350_pin)
`endif // AE350_MAC_SUPPORT
`ifdef AE350_SMC_SUPPORT
   `ifdef ATFSMC020_SEPARATE_AHB
	.smc_mem_haddr    (smc_mem_haddr     ), // (ae350_ahb_subsystem) <= ()
	.smc_mem_hburst   (smc_mem_hburst    ), // (ae350_ahb_subsystem) <= ()
	.smc_mem_hready   (smc_mem_hready    ), // (ae350_ahb_subsystem) <= ()
	.smc_mem_hsize    (smc_mem_hsize     ), // (ae350_ahb_subsystem) <= ()
	.smc_mem_htrans   (smc_mem_htrans    ), // (ae350_ahb_subsystem) <= ()
	.smc_mem_hwdata   (smc_mem_hwdata    ), // (ae350_ahb_subsystem) <= ()
	.smc_mem_hwrite   (smc_mem_hwrite    ), // (ae350_ahb_subsystem) <= ()
   `endif // ATFSMC020_SEPARATE_AHB
`endif // AE350_SMC_SUPPORT
`ifdef AE350_MAC_SUPPORT
   `ifdef ATFMAC100_SEPARATE_HREADY
	.mac_hreadyout    (mac_hreadyout     ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
   `endif // ATFMAC100_SEPARATE_HREADY
`endif // AE350_MAC_SUPPORT
	.hbmc_hprot       (hbmc_hprot        ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.hbmc_hresp       (hbmc_hresp        ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.hbmc_haddr       (hbmc_haddr        ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.hbmc_htrans      (hbmc_htrans       ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.hclk             (hclk              ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
	.hresetn          (hresetn           ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
	.hbmc_hwdata      (hbmc_hwdata       ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.hbmc_hwrite      (hbmc_hwrite       ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.hbmc_hburst      (hbmc_hburst       ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.hbmc_hsize       (hbmc_hsize        ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.hbmc_hrdata      (hbmc_hrdata       ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.hbmc_hready      (hbmc_hready       ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.hbmc_hreadyout   (hbmc_hreadyout    ), // (ae350_ahb_subsystem) => (ae350_bus_connector)
	.hbmc_hsel        (hbmc_hsel         ), // (ae350_ahb_subsystem) <= (ae350_bus_connector)
	.lcd_intr         (lcd_intr          ), // (ae350_ahb_subsystem) => (ae350_aopd)
	.mac_int          (mac_int           )  // (ae350_ahb_subsystem) => (ae350_aopd)
); // end of ae350_ahb_subsystem

ae350_apb_subsystem #(
	.BUS_MASTER_ADDR_WIDTH(ADDR_WIDTH      ),
	.DMAC_DATA_WIDTH (DMAC_DATA_WIDTH_FIX),
	.DMAC_ID_WIDTH   (DMAC_ID_WIDTH   )
) ae350_apb_subsystem (
`ifdef AE350_RTC_SUPPORT
	.rtc_prdata       (rtc_prdata       ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.rtc_pready       (rtc_pready       ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.rtc_psel         (rtc_psel         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.rtc_pslverr      (rtc_pslverr      ), // (ae350_apb_subsystem) <= (ae350_aopd)
`endif // AE350_RTC_SUPPORT
`ifdef AE350_UART1_SUPPORT
	.pclk_uart1       (pclk_uart1       ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.uart1_ctsn       (uart1_ctsn       ), // (ae350_apb_subsystem) <= (ae350_pin)
	.uart1_dcdn       (uart1_dcdn       ), // (ae350_apb_subsystem) <= (ae350_pin)
	.uart1_dsrn       (uart1_dsrn       ), // (ae350_apb_subsystem) <= (ae350_pin)
	.uart1_dtrn       (uart1_dtrn       ), // (ae350_apb_subsystem) => (ae350_pin)
	.uart1_out1n      (uart1_out1n      ), // (ae350_apb_subsystem) => (ae350_pin)
	.uart1_out2n      (uart1_out2n      ), // (ae350_apb_subsystem) => (ae350_pin)
	.uart1_rin        (uart1_rin        ), // (ae350_apb_subsystem) <= (ae350_pin)
	.uart1_rtsn       (uart1_rtsn       ), // (ae350_apb_subsystem) => (ae350_pin)
	.uart1_rxd        (uart1_rxd        ), // (ae350_apb_subsystem) <= (ae350_pin)
	.uart1_txd        (uart1_txd        ), // (ae350_apb_subsystem) => (ae350_pin)
`endif // AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
	.pclk_uart2       (pclk_uart2       ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.uart2_ctsn       (uart2_ctsn       ), // (ae350_apb_subsystem) <= (ae350_pin)
	.uart2_dcdn       (uart2_dcdn       ), // (ae350_apb_subsystem) <= (ae350_pin)
	.uart2_dsrn       (uart2_dsrn       ), // (ae350_apb_subsystem) <= (ae350_pin)
	.uart2_dtrn       (uart2_dtrn       ), // (ae350_apb_subsystem) => (ae350_pin)
	.uart2_out1n      (uart2_out1n      ), // (ae350_apb_subsystem) => (ae350_pin)
	.uart2_out2n      (uart2_out2n      ), // (ae350_apb_subsystem) => (ae350_pin)
	.uart2_rin        (uart2_rin        ), // (ae350_apb_subsystem) <= (ae350_pin)
	.uart2_rtsn       (uart2_rtsn       ), // (ae350_apb_subsystem) => (ae350_pin)
	.uart2_rxd        (uart2_rxd        ), // (ae350_apb_subsystem) <= (ae350_pin)
	.uart2_txd        (uart2_txd        ), // (ae350_apb_subsystem) => (ae350_pin)
`endif // AE350_UART2_SUPPORT
`ifdef AE350_PIT_SUPPORT
	.ch0_pwm          (ch0_pwm          ), // (ae350_apb_subsystem) => (ae350_pin)
	.ch0_pwmoe        (ch0_pwmoe        ), // (ae350_apb_subsystem) => (ae350_pin)
	.pclk_pit         (pclk_pit         ), // (ae350_apb_subsystem) <= (ae350_aopd)
`endif // AE350_PIT_SUPPORT
`ifdef AE350_PIT2_SUPPORT
	.pit2_ch0_pwm     (pit2_ch0_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit2_ch0_pwmoe   (pit2_ch0_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
`endif // AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
	.pit3_ch0_pwm     (pit3_ch0_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit3_ch0_pwmoe   (pit3_ch0_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
`endif // AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
	.pit4_ch0_pwm     (pit4_ch0_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit4_ch0_pwmoe   (pit4_ch0_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
`endif // AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
	.pit5_ch0_pwm     (pit5_ch0_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit5_ch0_pwmoe   (pit5_ch0_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
`endif // AE350_PIT5_SUPPORT
`ifdef AE350_WDT_SUPPORT
	.pclk_wdt         (pclk_wdt         ), // (ae350_apb_subsystem) <= (ae350_aopd)
`endif // AE350_WDT_SUPPORT
`ifdef AE350_GPIO_SUPPORT
	.gpio_in          (gpio_in          ), // (ae350_apb_subsystem) <= (ae350_pin)
	.gpio_oe          (gpio_oe          ), // (ae350_apb_subsystem) => (ae350_pin)
	.gpio_out         (gpio_out         ), // (ae350_apb_subsystem) => (ae350_pin)
	.pclk_gpio        (pclk_gpio        ), // (ae350_apb_subsystem) <= (ae350_aopd)
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_I2C_SUPPORT
	.i2c_scl          (i2c_scl          ), // (ae350_apb_subsystem) => (ae350_pin)
	.i2c_scl_in       (i2c_scl_in       ), // (ae350_apb_subsystem) <= (ae350_pin)
	.i2c_sda          (i2c_sda          ), // (ae350_apb_subsystem) => (ae350_pin)
	.i2c_sda_in       (i2c_sda_in       ), // (ae350_apb_subsystem) <= (ae350_pin)
`endif // AE350_I2C_SUPPORT
`ifdef AE350_I2C2_SUPPORT
	.i2c2_scl         (i2c2_scl         ), // (ae350_apb_subsystem) => (ae350_pin)
	.i2c2_scl_in      (i2c2_scl_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
	.i2c2_sda         (i2c2_sda         ), // (ae350_apb_subsystem) => (ae350_pin)
	.i2c2_sda_in      (i2c2_sda_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
`endif // AE350_I2C2_SUPPORT
`ifdef AE350_SPI1_SUPPORT
	.spi1_clk_in      (spi1_clk_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi1_clk_oe      (spi1_clk_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi1_clk_out     (spi1_clk_out     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi1_csn_oe      (spi1_csn_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi1_csn_out     (spi1_csn_out     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi1_miso_in     (spi1_miso_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi1_miso_oe     (spi1_miso_oe     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi1_miso_out    (spi1_miso_out    ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi1_mosi_in     (spi1_mosi_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi1_mosi_oe     (spi1_mosi_oe     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi1_mosi_out    (spi1_mosi_out    ), // (ae350_apb_subsystem) => (ae350_pin)
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
	.spi2_clk_in      (spi2_clk_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi2_clk_oe      (spi2_clk_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi2_clk_out     (spi2_clk_out     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi2_csn_oe      (spi2_csn_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi2_csn_out     (spi2_csn_out     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi2_miso_in     (spi2_miso_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi2_miso_oe     (spi2_miso_oe     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi2_miso_out    (spi2_miso_out    ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi2_mosi_in     (spi2_mosi_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi2_mosi_oe     (spi2_mosi_oe     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi2_mosi_out    (spi2_mosi_out    ), // (ae350_apb_subsystem) => (ae350_pin)
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
	.spi3_clk_in      (spi3_clk_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi3_clk_oe      (spi3_clk_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi3_clk_out     (spi3_clk_out     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi3_csn_oe      (spi3_csn_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi3_csn_out     (spi3_csn_out     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi3_miso_in     (spi3_miso_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi3_miso_oe     (spi3_miso_oe     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi3_miso_out    (spi3_miso_out    ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi3_mosi_in     (spi3_mosi_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi3_mosi_oe     (spi3_mosi_oe     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi3_mosi_out    (spi3_mosi_out    ), // (ae350_apb_subsystem) => (ae350_pin)
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
	.spi4_clk_in      (spi4_clk_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi4_clk_oe      (spi4_clk_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi4_clk_out     (spi4_clk_out     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi4_csn_oe      (spi4_csn_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi4_csn_out     (spi4_csn_out     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi4_miso_in     (spi4_miso_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi4_miso_oe     (spi4_miso_oe     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi4_miso_out    (spi4_miso_out    ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi4_mosi_in     (spi4_mosi_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi4_mosi_oe     (spi4_mosi_oe     ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi4_mosi_out    (spi4_mosi_out    ), // (ae350_apb_subsystem) => (ae350_pin)
`endif // AE350_SPI4_SUPPORT
`ifdef AE350_SDC_SUPPORT
	.T_sd_cd          (T_sd_cd          ), // (ae350_apb_subsystem) <= (ae350_pin)
	.T_sd_dat0_in     (T_sd_dat0_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.T_sd_dat1_in     (T_sd_dat1_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.T_sd_dat2_in     (T_sd_dat2_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.T_sd_dat3_in     (T_sd_dat3_in     ), // (ae350_apb_subsystem) <= (ae350_pin)
	.T_sd_rsp         (T_sd_rsp         ), // (ae350_apb_subsystem) <= (ae350_pin)
	.T_sd_wp          (T_sd_wp          ), // (ae350_apb_subsystem) <= (ae350_pin)
	.sd_clk           (sd_clk           ), // (ae350_apb_subsystem) => (ae350_pin)
	.sd_cmd           (sd_cmd           ), // (ae350_apb_subsystem) => (ae350_pin)
	.sd_cmd_oe        (sd_cmd_oe        ), // (ae350_apb_subsystem) => (ae350_pin)
	.sd_dat0_oe       (sd_dat0_oe       ), // (ae350_apb_subsystem) => (ae350_pin)
	.sd_dat0_out      (sd_dat0_out      ), // (ae350_apb_subsystem) => (ae350_pin)
	.sd_dat1_oe       (sd_dat1_oe       ), // (ae350_apb_subsystem) => (ae350_pin)
	.sd_dat1_out      (sd_dat1_out      ), // (ae350_apb_subsystem) => (ae350_pin)
	.sd_dat2_oe       (sd_dat2_oe       ), // (ae350_apb_subsystem) => (ae350_pin)
	.sd_dat2_out      (sd_dat2_out      ), // (ae350_apb_subsystem) => (ae350_pin)
	.sd_dat3_oe       (sd_dat3_oe       ), // (ae350_apb_subsystem) => (ae350_pin)
	.sd_dat3_out      (sd_dat3_out      ), // (ae350_apb_subsystem) => (ae350_pin)
	.sd_power         (sd_power         ), // (ae350_apb_subsystem) => (ae350_pin)
	.sdc_clk          (sdc_clk          ), // (ae350_apb_subsystem) <= (ae350_aopd)
`endif // AE350_SDC_SUPPORT
`ifdef AE350_DMA_AXI_SUPPORT
	.dmac0_arid       (dmac0_arid_apb   ), // (ae350_apb_subsystem) => ()
	.dmac0_awid       (dmac0_awid_apb   ), // (ae350_apb_subsystem) => ()
	.dmac0_bid        (dmac0_bid_apb    ), // (ae350_apb_subsystem) <= ()
	.dmac0_rid        (dmac0_rid_apb    ), // (ae350_apb_subsystem) <= ()
	.aclk             (aclk             ), // (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem) <= (ae350_aopd)
	.aresetn          (aresetn          ), // (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,ncetrace200) <= (ae350_aopd)
	.dmac0_araddr     (dmac0_araddr_apb ), // (ae350_apb_subsystem) => ()
	.dmac0_arburst    (dmac0_arburst_apb), // (ae350_apb_subsystem) => ()
	.dmac0_arcache    (dmac0_arcache_apb), // (ae350_apb_subsystem) => ()
	.dmac0_arlen      (dmac0_arlen_apb  ), // (ae350_apb_subsystem) => ()
	.dmac0_arlock     (dmac0_arlock_apb ), // (ae350_apb_subsystem) => ()
	.dmac0_arprot     (dmac0_arprot_apb ), // (ae350_apb_subsystem) => ()
	.dmac0_arready    (dmac0_arready_apb), // (ae350_apb_subsystem) <= ()
	.dmac0_arsize     (dmac0_arsize_apb ), // (ae350_apb_subsystem) => ()
	.dmac0_arvalid    (dmac0_arvalid_apb), // (ae350_apb_subsystem) => ()
	.dmac0_awaddr     (dmac0_awaddr_apb ), // (ae350_apb_subsystem) => ()
	.dmac0_awburst    (dmac0_awburst_apb), // (ae350_apb_subsystem) => ()
	.dmac0_awcache    (dmac0_awcache_apb), // (ae350_apb_subsystem) => ()
	.dmac0_awlen      (dmac0_awlen_apb  ), // (ae350_apb_subsystem) => ()
	.dmac0_awlock     (dmac0_awlock_apb ), // (ae350_apb_subsystem) => ()
	.dmac0_awprot     (dmac0_awprot_apb ), // (ae350_apb_subsystem) => ()
	.dmac0_awready    (dmac0_awready_apb), // (ae350_apb_subsystem) <= ()
	.dmac0_awsize     (dmac0_awsize_apb ), // (ae350_apb_subsystem) => ()
	.dmac0_awvalid    (dmac0_awvalid_apb), // (ae350_apb_subsystem) => ()
	.dmac0_bready     (dmac0_bready_apb ), // (ae350_apb_subsystem) => ()
	.dmac0_bresp      (dmac0_bresp_apb  ), // (ae350_apb_subsystem) <= ()
	.dmac0_bvalid     (dmac0_bvalid_apb ), // (ae350_apb_subsystem) <= ()
	.dmac0_rdata      (dmac0_rdata_apb  ), // (ae350_apb_subsystem) <= ()
	.dmac0_rlast      (dmac0_rlast_apb  ), // (ae350_apb_subsystem) <= ()
	.dmac0_rready     (dmac0_rready_apb ), // (ae350_apb_subsystem) => ()
	.dmac0_rresp      (dmac0_rresp_apb  ), // (ae350_apb_subsystem) <= ()
	.dmac0_rvalid     (dmac0_rvalid_apb ), // (ae350_apb_subsystem) <= ()
	.dmac0_wdata      (dmac0_wdata_apb  ), // (ae350_apb_subsystem) => ()
	.dmac0_wlast      (dmac0_wlast_apb  ), // (ae350_apb_subsystem) => ()
	.dmac0_wready     (dmac0_wready_apb ), // (ae350_apb_subsystem) <= ()
	.dmac0_wstrb      (dmac0_wstrb_apb  ), // (ae350_apb_subsystem) => ()
	.dmac0_wvalid     (dmac0_wvalid_apb ), // (ae350_apb_subsystem) => ()
`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_DMA_AHB_SUPPORT
	.dmac_haddr       (dmac_haddr       ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac_hburst      (dmac_hburst      ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac_hprot       (dmac_hprot       ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac_hrdata      (dmac_hrdata      ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac_hready      (dmac_hready      ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac_hresp       (dmac_hresp       ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac_hsize       (dmac_hsize       ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac_htrans      (dmac_htrans      ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac_hwdata      (dmac_hwdata      ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac_hwrite      (dmac_hwrite      ), // (ae350_apb_subsystem) => (ae350_bus_connector)
`endif // AE350_DMA_AHB_SUPPORT
`ifdef AE350_SSP_SUPPORT
	.T_ssp_fs_in      (T_ssp_fs_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
	.T_ssp_rxd        (T_ssp_rxd        ), // (ae350_apb_subsystem) <= (ae350_pin)
	.T_ssp_sclk_in    (T_ssp_sclk_in    ), // (ae350_apb_subsystem) <= (ae350_pin)
	.ssp_fs_oe        (ssp_fs_oe        ), // (ae350_apb_subsystem) => (ae350_pin)
	.ssp_fs_out       (ssp_fs_out       ), // (ae350_apb_subsystem) => (ae350_pin)
	.ssp_rstn         (ssp_rstn         ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.ssp_sclk_oe      (ssp_sclk_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.ssp_sclk_out     (ssp_sclk_out     ), // (ae350_apb_subsystem) => (ae350_pin)
	.ssp_txd          (ssp_txd          ), // (ae350_apb_subsystem) => (ae350_pin)
	.ssp_txd_oe       (ssp_txd_oe       ), // (ae350_apb_subsystem) => (ae350_pin)
	.sspclk           (sspclk           ), // (ae350_apb_subsystem) <= (ae350_aopd)
`endif // AE350_SSP_SUPPORT
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm          (ch1_pwm          ), // (ae350_apb_subsystem) => (ae350_pin)
	.ch1_pwmoe        (ch1_pwmoe        ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm          (ch2_pwm          ), // (ae350_apb_subsystem) => (ae350_pin)
	.ch2_pwmoe        (ch2_pwmoe        ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm          (ch3_pwm          ), // (ae350_apb_subsystem) => (ae350_pin)
	.ch3_pwmoe        (ch3_pwmoe        ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT_SUPPORT
`ifdef AE350_PIT2_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit2_ch1_pwm     (pit2_ch1_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit2_ch1_pwmoe   (pit2_ch1_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit2_ch2_pwm     (pit2_ch2_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit2_ch2_pwmoe   (pit2_ch2_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit2_ch3_pwm     (pit2_ch3_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit2_ch3_pwmoe   (pit2_ch3_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit3_ch1_pwm     (pit3_ch1_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit3_ch1_pwmoe   (pit3_ch1_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit3_ch2_pwm     (pit3_ch2_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit3_ch2_pwmoe   (pit3_ch2_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit3_ch3_pwm     (pit3_ch3_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit3_ch3_pwmoe   (pit3_ch3_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit4_ch1_pwm     (pit4_ch1_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit4_ch1_pwmoe   (pit4_ch1_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit4_ch2_pwm     (pit4_ch2_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit4_ch2_pwmoe   (pit4_ch2_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit4_ch3_pwm     (pit4_ch3_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit4_ch3_pwmoe   (pit4_ch3_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit5_ch1_pwm     (pit5_ch1_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit5_ch1_pwmoe   (pit5_ch1_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit5_ch2_pwm     (pit5_ch2_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit5_ch2_pwmoe   (pit5_ch2_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit5_ch3_pwm     (pit5_ch3_pwm     ), // (ae350_apb_subsystem) => (ae350_pin)
	.pit5_ch3_pwmoe   (pit5_ch3_pwmoe   ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT5_SUPPORT
`ifdef AE350_GPIO_SUPPORT
   `ifdef ATCGPIO100_PULL_SUPPORT
	.gpio_pulldown    (gpio_pulldown    ), // (ae350_apb_subsystem) => (ae350_pin)
	.gpio_pullup      (gpio_pullup      ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCGPIO100_PULL_SUPPORT
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_REG_APB
	.pclk_spi1        (pclk_spi1        ), // (ae350_apb_subsystem) <= (ae350_aopd)
   `endif // ATCSPI200_REG_APB
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.spi_mem_haddr    (spi_mem_haddr    ), // (ae350_apb_subsystem) <= ()
	.spi_mem_hrdata   (spi_mem_hrdata   ), // (ae350_apb_subsystem) => (u_rom_ahbdec)
	.spi_mem_hready   (spi_mem_hready   ), // (ae350_apb_subsystem) <= ()
	.spi_mem_hreadyout(spi_mem_hreadyout), // (ae350_apb_subsystem) => (u_rom_ahbdec)
	.spi_mem_hresp    (spi_mem_hresp    ), // (ae350_apb_subsystem) => (u_rom_ahbdec)
	.spi_mem_hsel     (spi_mem_hsel     ), // (ae350_apb_subsystem) <= (u_rom_ahbdec)
	.spi_mem_htrans   (spi_mem_htrans   ), // (ae350_apb_subsystem) <= ()
	.spi_mem_hwrite   (spi_mem_hwrite   ), // (ae350_apb_subsystem) <= ()
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi1_csn_in      (spi1_csn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi1_holdn_in    (spi1_holdn_in    ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi1_holdn_oe    (spi1_holdn_oe    ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi1_holdn_out   (spi1_holdn_out   ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi1_wpn_in      (spi1_wpn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi1_wpn_oe      (spi1_wpn_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi1_wpn_out     (spi1_wpn_out     ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_REG_APB
	.pclk_spi2        (pclk_spi2        ), // (ae350_apb_subsystem) <= (ae350_aopd)
   `endif // ATCSPI200_REG_APB
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi2_csn_in      (spi2_csn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi2_holdn_in    (spi2_holdn_in    ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi2_holdn_oe    (spi2_holdn_oe    ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi2_holdn_out   (spi2_holdn_out   ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi2_wpn_in      (spi2_wpn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi2_wpn_oe      (spi2_wpn_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi2_wpn_out     (spi2_wpn_out     ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi3_csn_in      (spi3_csn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi3_holdn_in    (spi3_holdn_in    ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi3_holdn_oe    (spi3_holdn_oe    ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi3_holdn_out   (spi3_holdn_out   ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi3_wpn_in      (spi3_wpn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi3_wpn_oe      (spi3_wpn_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi3_wpn_out     (spi3_wpn_out     ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi4_csn_in      (spi4_csn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi4_holdn_in    (spi4_holdn_in    ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi4_holdn_oe    (spi4_holdn_oe    ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi4_holdn_out   (spi4_holdn_out   ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi4_wpn_in      (spi4_wpn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
	.spi4_wpn_oe      (spi4_wpn_oe      ), // (ae350_apb_subsystem) => (ae350_pin)
	.spi4_wpn_out     (spi4_wpn_out     ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI4_SUPPORT
`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dmac1_arid       (dmac1_arid       ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_awid       (dmac1_awid       ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_bid        (dmac1_bid        ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac1_rid        (dmac1_rid        ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac1_araddr     (dmac1_araddr     ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_arburst    (dmac1_arburst    ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_arcache    (dmac1_arcache    ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_arlen      (dmac1_arlen      ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_arlock     (dmac1_arlock     ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_arprot     (dmac1_arprot     ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_arready    (dmac1_arready    ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac1_arsize     (dmac1_arsize     ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_arvalid    (dmac1_arvalid    ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_awaddr     (dmac1_awaddr     ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_awburst    (dmac1_awburst    ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_awcache    (dmac1_awcache    ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_awlen      (dmac1_awlen      ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_awlock     (dmac1_awlock     ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_awprot     (dmac1_awprot     ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_awready    (dmac1_awready    ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac1_awsize     (dmac1_awsize     ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_awvalid    (dmac1_awvalid    ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_bready     (dmac1_bready     ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_bresp      (dmac1_bresp      ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac1_bvalid     (dmac1_bvalid     ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac1_rdata      (dmac1_rdata      ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac1_rlast      (dmac1_rlast      ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac1_rready     (dmac1_rready     ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_rresp      (dmac1_rresp      ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac1_rvalid     (dmac1_rvalid     ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac1_wdata      (dmac1_wdata      ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_wlast      (dmac1_wlast      ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_wready     (dmac1_wready     ), // (ae350_apb_subsystem) <= (ae350_bus_connector)
	.dmac1_wstrb      (dmac1_wstrb      ), // (ae350_apb_subsystem) => (ae350_bus_connector)
	.dmac1_wvalid     (dmac1_wvalid     ), // (ae350_apb_subsystem) => (ae350_bus_connector)
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_SSP_SUPPORT
   `ifdef ATFSSP020_AC97_FUNCTION
	.ssp_ac97_resetn  (ssp_ac97_resetn  ), // (ae350_apb_subsystem) => (ae350_pin)
   `endif // ATFSSP020_AC97_FUNCTION
`endif // AE350_SSP_SUPPORT
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi1_csn_in      (spi1_csn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
      `endif // ATCSPI200_DIRECT_IO_SUPPORT
   `endif // ATCSPI200_SLAVE_SUPPORT
`endif // AE350_SPI1_SUPPORT
`ifdef ATCSPI200_REG_APB
   `ifdef ATCSPI200_AHBBUS_EXIST
   `else
      `ifdef ATCSPI200_EILMBUS_EXIST
	.apb2core_clken   (apb2core_clken   ), // (ae350_apb_subsystem) <= (ae350_aopd)
      `endif // ATCSPI200_EILMBUS_EXIST
   `endif // ATCSPI200_AHBBUS_EXIST
`endif // ATCSPI200_REG_APB
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi2_csn_in      (spi2_csn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
      `endif // ATCSPI200_DIRECT_IO_SUPPORT
   `endif // ATCSPI200_SLAVE_SUPPORT
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi3_csn_in      (spi3_csn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
      `endif // ATCSPI200_DIRECT_IO_SUPPORT
   `endif // ATCSPI200_SLAVE_SUPPORT
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi4_csn_in      (spi4_csn_in      ), // (ae350_apb_subsystem) <= (ae350_pin)
      `endif // ATCSPI200_DIRECT_IO_SUPPORT
   `endif // ATCSPI200_SLAVE_SUPPORT
`endif // AE350_SPI4_SUPPORT
	.ahb2apb_haddr    (ahb2apb_haddr    ), // (ae350_apb_subsystem) <= (ae350_ahb_subsystem)
	.ahb2apb_hprot    (ahb2apb_hprot    ), // (ae350_apb_subsystem) <= (ae350_ahb_subsystem)
	.ahb2apb_hrdata   (ahb2apb_hrdata   ), // (ae350_apb_subsystem) => (ae350_ahb_subsystem)
	.ahb2apb_hready   (ahb2apb_hready   ), // (ae350_apb_subsystem) => (ae350_ahb_subsystem)
	.ahb2apb_hready_in(ahb2apb_hready_in), // (ae350_apb_subsystem) <= (ae350_ahb_subsystem)
	.ahb2apb_hresp    (ahb2apb_hresp    ), // (ae350_apb_subsystem) => (ae350_ahb_subsystem)
	.ahb2apb_hsel     (ahb2apb_hsel     ), // (ae350_apb_subsystem) <= (ae350_ahb_subsystem)
	.ahb2apb_hsize    (ahb2apb_hsize    ), // (ae350_apb_subsystem) <= (ae350_ahb_subsystem)
	.ahb2apb_htrans   (ahb2apb_htrans   ), // (ae350_apb_subsystem) <= (ae350_ahb_subsystem)
	.ahb2apb_hwdata   (ahb2apb_hwdata   ), // (ae350_apb_subsystem) <= (ae350_ahb_subsystem)
	.ahb2apb_hwrite   (ahb2apb_hwrite   ), // (ae350_apb_subsystem) <= (ae350_ahb_subsystem)
	.paddr            (paddr            ), // (ae350_apb_subsystem) => (ae350_aopd)
	.penable          (penable          ), // (ae350_apb_subsystem) => (ae350_aopd)
	.pwdata           (pwdata           ), // (ae350_apb_subsystem) => (ae350_aopd)
	.pwrite           (pwrite           ), // (ae350_apb_subsystem) => (ae350_aopd)
	.smu_prdata       (smu_prdata       ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.smu_pready       (smu_pready       ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.smu_psel         (smu_psel         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.smu_pslverr      (smu_pslverr      ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.pclk             (pclk             ), // (ae350_apb_subsystem,ae350_cpu_subsystem) <= (ae350_aopd)
	.presetn          (presetn          ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.hclk             (hclk             ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
	.hresetn          (hresetn          ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
	.apb2ahb_clken    (apb2ahb_clken    ), // (ae350_apb_subsystem,ae350_cpu_subsystem) <= (ae350_aopd)
	.dma_int          (dma_int          ), // (ae350_apb_subsystem) => (ae350_aopd)
	.gpio_intr        (gpio_intr        ), // (ae350_apb_subsystem) => (ae350_aopd)
	.extclk           (extclk           ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.i2c_int          (i2c_int          ), // (ae350_apb_subsystem) => (ae350_aopd)
	.pclk_i2c         (pclk_i2c         ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.i2c2_int         (i2c2_int         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.pit_intr         (pit_intr         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.pit2_int         (pit2_int         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.pit3_int         (pit3_int         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.pit4_int         (pit4_int         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.pit5_int         (pit5_int         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.sdc_int          (sdc_int          ), // (ae350_apb_subsystem) => (ae350_aopd)
	.spi1_int         (spi1_int         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.scan_enable      (scan_enable      ), // (ae350_apb_subsystem,ae350_cpu_subsystem,ncetrace200) <= (ae350_aopd)
	.scan_test        (scan_test        ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.spi_clk          (spi_clk          ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.spi_rstn         (spi_rstn         ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.spi2_int         (spi2_int         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.spi3_int         (spi3_int         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.spi4_int         (spi4_int         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.ssp_intr         (ssp_intr         ), // (ae350_apb_subsystem) => (ae350_aopd)
	.uart1_int        (uart1_int        ), // (ae350_apb_subsystem) => (ae350_aopd)
	.uart_clk         (uart_clk         ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.uart_rstn        (uart_rstn        ), // (ae350_apb_subsystem) <= (ae350_aopd)
	.uart2_int        (uart2_int        ), // (ae350_apb_subsystem) => (ae350_aopd)
	.wdt_int          (wdt_int          ), // (ae350_apb_subsystem) => (ae350_aopd,ae350_cpu_subsystem)
	.wdt_rst          (wdt_rst          )  // (ae350_apb_subsystem) => (ae350_aopd)
); // end of ae350_apb_subsystem

ae350_cpu_subsystem ae350_cpu_subsystem (
`ifdef NDS_NHART
	.aclk                       (aclk                               ), // (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem) <= (ae350_aopd)
	.aresetn                    (aresetn                            ), // (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,ncetrace200) <= (ae350_aopd)
	.arid                       (cpu_arid                           ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.araddr                     (cpu_araddr                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arlen                      (cpu_arlen                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arsize                     (cpu_arsize                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arburst                    (cpu_arburst                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arlock                     (cpu_arlock                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arcache                    (cpu_arcache                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arprot                     (cpu_arprot                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arvalid                    (cpu_arvalid                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arready                    (cpu_arready                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.awid                       (cpu_awid                           ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awaddr                     (cpu_awaddr                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awlen                      (cpu_awlen                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awsize                     (cpu_awsize                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awburst                    (cpu_awburst                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awlock                     (cpu_awlock                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awcache                    (cpu_awcache                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awprot                     (cpu_awprot                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awvalid                    (cpu_awvalid                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awready                    (cpu_awready                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.wdata                      (cpu_wdata                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.wstrb                      (cpu_wstrb                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.wlast                      (cpu_wlast                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.wvalid                     (cpu_wvalid                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.wready                     (cpu_wready                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.bid                        (cpu_bid                            ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.bresp                      (cpu_bresp                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.bvalid                     (cpu_bvalid                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.bready                     (cpu_bready                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.rid                        (cpu_rid                            ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.rdata                      (cpu_rdata                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.rresp                      (cpu_rresp                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.rlast                      (cpu_rlast                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.rvalid                     (cpu_rvalid                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.rready                     (cpu_rready                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
`endif // NDS_NHART
`ifdef NDS_IO_TRACE_INSTR_GEN1
	.hart0_gen1_trace_enabled   (1'b0                               ), // (ae350_cpu_subsystem) => ()
	.hart0_gen1_trace_cause     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_gen1_trace_iaddr     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_gen1_trace_iexception(/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_gen1_trace_instr     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_gen1_trace_interrupt (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_gen1_trace_ivalid    (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_gen1_trace_priv      (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_gen1_trace_tval      (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
	.hart0_trace_enabled        (hart0_trace_enabled                ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.hart0_trace_cause          (hart0_trace_cause                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart0_trace_halted         (hart0_trace_halted                 ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart0_trace_iaddr          (hart0_trace_iaddr                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart0_trace_ilastsize      (hart0_trace_ilastsize              ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart0_trace_iretire        (hart0_trace_iretire                ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart0_trace_itype          (hart0_trace_itype                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart0_trace_priv           (hart0_trace_priv                   ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart0_trace_reset          (hart0_trace_reset                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart0_trace_trigger        (hart0_trace_trigger                ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart0_trace_tval           (hart0_trace_tval                   ), // (ae350_cpu_subsystem) => (ncetrace200)
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_VPU
	.hart0_vc_valu_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_vc_vdiv_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_vc_vfdiv_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_vc_vfmac_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_vc_vfmis_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_vc_vlsu_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_vc_vmac_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_vc_vmsk_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_vc_vper_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart0_vc_vpu_idle          (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
`endif // NDS_IO_VPU
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	.dmactive                   (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.dmi_haddr                  (pldm_dmi_haddr                     ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.dmi_hburst                 (pldm_dmi_hburst                    ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.dmi_hprot                  (pldm_dmi_hprot                     ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.dmi_hrdata                 (pldm_dmi_hrdata                    ), // (ae350_cpu_subsystem) => (ncetrace200)
	.dmi_hready                 (pldm_dmi_hready                    ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.dmi_hreadyout              (pldm_dmi_hreadyout                 ), // (ae350_cpu_subsystem) => (ncetrace200)
	.dmi_hresp                  (pldm_dmi_hresp                     ), // (ae350_cpu_subsystem) => (ncetrace200)
	.dmi_hsel                   (pldm_dmi_hsel                      ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.dmi_hsize                  (pldm_dmi_hsize                     ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.dmi_htrans                 (pldm_dmi_htrans                    ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.dmi_hwdata                 (pldm_dmi_hwdata                    ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.dmi_hwrite                 (pldm_dmi_hwrite                    ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.dmi_resetn                 (pldm_dmi_resetn                    ), // (ae350_cpu_subsystem) <= (ncetrace200)
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_NHART
   `ifdef NDS_IO_HART1
	.hart1_wakeup_event         (hart1_wakeup_event                 ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.hart1_reset_vector         (core_reset_vectors[(VALEN+63):64]  ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart1_icache_disable_init  (hart1_icache_disable_init          ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart1_dcache_disable_init  (hart1_dcache_disable_init          ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart1_core_wfi_mode        (hart1_core_wfi_mode                ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.hart1_nmi                  (1'b0                               ), // (ae350_cpu_subsystem) <= ()
   `endif // NDS_IO_HART1
   `ifdef NDS_IO_HART2
	.hart2_wakeup_event         (hart2_wakeup_event                 ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.hart2_reset_vector         (core_reset_vectors[(VALEN+127):128]), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart2_icache_disable_init  (hart2_icache_disable_init          ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart2_dcache_disable_init  (hart2_dcache_disable_init          ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart2_core_wfi_mode        (hart2_core_wfi_mode                ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.hart2_nmi                  (1'b0                               ), // (ae350_cpu_subsystem) <= ()
   `endif // NDS_IO_HART2
   `ifdef NDS_IO_HART3
	.hart3_wakeup_event         (hart3_wakeup_event                 ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.hart3_reset_vector         (core_reset_vectors[(VALEN+191):192]), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart3_icache_disable_init  (hart3_icache_disable_init          ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart3_dcache_disable_init  (hart3_dcache_disable_init          ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart3_core_wfi_mode        (hart3_core_wfi_mode                ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.hart3_nmi                  (1'b0                               ), // (ae350_cpu_subsystem) <= ()
   `endif // NDS_IO_HART3
   `ifdef NDS_IO_L2C
	.axi_bus_clk_en             (axi2core_clken                     ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.l2c_err_int                (l2c_err_int                        ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.l2c_pcs_standby_ok         (l2c_pcs_standby_ok                 ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.pcs_core0_sleep_ok         (pcs_core0_sleep_ok                 ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.pcs_core0_sleep_req        (pcs_core0_sleep_req                ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.pcs_core1_sleep_ok         (pcs_core1_sleep_ok                 ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.pcs_core1_sleep_req        (pcs_core1_sleep_req                ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.pcs_core2_sleep_ok         (pcs_core2_sleep_ok                 ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.pcs_core2_sleep_req        (pcs_core2_sleep_req                ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.pcs_core3_sleep_ok         (pcs_core3_sleep_ok                 ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.pcs_core3_sleep_req        (pcs_core3_sleep_req                ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.l2c_reset_n                (core_resetn[0]                     ), // (ae350_cpu_subsystem) <= (ae350_aopd)
   `endif // NDS_IO_L2C
`else
   `ifdef NDS_IO_AHB
	.ahb_bus_clk_en             (ahb2core_clken                     ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hclk                       (hclk                               ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
	.hresetn                    (hresetn                            ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
   `endif // NDS_IO_AHB
`endif // NDS_NHART
`ifdef NDS_IO_BIU_X2
   `ifdef NDS_IO_AHB
	.d_haddr                    (cpu_d_haddr                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_hburst                   (cpu_d_hburst                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_hprot                    (cpu_d_hprot                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_hrdata                   (cpu_d_hrdata                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_hready                   (cpu_d_hready                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_hresp                    (cpu_d_hresp                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_hsize                    (cpu_d_hsize                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_htrans                   (cpu_d_htrans                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_hwdata                   (cpu_d_hwdata                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_hwrite                   (cpu_d_hwrite                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_haddr                    (cpu_i_haddr                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_hburst                   (cpu_i_hburst                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_hprot                    (cpu_i_hprot                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_hrdata                   (cpu_i_hrdata                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_hready                   (cpu_i_hready                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_hresp                    (cpu_i_hresp                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_hsize                    (cpu_i_hsize                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_htrans                   (cpu_i_htrans                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_hwdata                   (cpu_i_hwdata                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_hwrite                   (cpu_i_hwrite                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
   `endif // NDS_IO_AHB
`else
   `ifdef NDS_IO_AHB
	.haddr                      (cpu_haddr                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.hburst                     (cpu_hburst                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.hprot                      (cpu_hprot                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.hrdata                     (cpu_hrdata                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.hready                     (cpu_hready                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.hresp                      (cpu_hresp                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.hsize                      (cpu_hsize                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.htrans                     (cpu_htrans                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.hwdata                     (cpu_hwdata                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.hwrite                     (cpu_hwrite                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
   `endif // NDS_IO_AHB
`endif // NDS_IO_BIU_X2
`ifdef NDS_IO_SLAVEPORT
   `ifdef NDS_IO_AHB
	.slv_haddr                  (cpuslv_haddr                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_hburst                 (cpuslv_hburst                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_hprot                  (cpuslv_hprot                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_hrdata                 (cpuslv_hrdata                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_hready                 (cpuslv_hready                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_hreadyout              (cpuslv_hreadyout                   ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_hresp                  (cpuslv_hresp                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_hsel                   (cpuslv_hsel                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_hsize                  (cpuslv_hsize                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_htrans                 (cpuslv_htrans                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_hwdata                 (cpuslv_hwdata                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_hwrite                 (cpuslv_hwrite                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
   `endif // NDS_IO_AHB
`endif // NDS_IO_SLAVEPORT
`ifdef NDS_NHART
`else
   `ifdef NDS_IO_AHB
   `else
	.aclk                       (aclk                               ), // (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem) <= (ae350_aopd)
	.aresetn                    (aresetn                            ), // (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,ncetrace200) <= (ae350_aopd)
	.axi_bus_clk_en             (axi2core_clken                     ), // (ae350_cpu_subsystem) <= (ae350_aopd)
   `endif // NDS_IO_AHB
`endif // NDS_NHART
`ifdef NDS_IO_SLAVEPORT
   `ifdef NDS_IO_AHB
   `else
	.slv_araddr                 (cpuslv_araddr                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_arburst                (cpuslv_arburst                     ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_arcache                (cpuslv_arcache                     ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_arid                   (cpuslv_arid                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_arlen                  (cpuslv_arlen                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_arlock                 (cpuslv_arlock                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_arprot                 (cpuslv_arprot                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_arready                (cpuslv_arready                     ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_arsize                 (cpuslv_arsize                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_arvalid                (cpuslv_arvalid                     ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_awaddr                 (cpuslv_awaddr                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_awburst                (cpuslv_awburst                     ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_awcache                (cpuslv_awcache                     ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_awid                   (cpuslv_awid                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_awlen                  (cpuslv_awlen                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_awlock                 (cpuslv_awlock                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_awprot                 (cpuslv_awprot                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_awready                (cpuslv_awready                     ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_awsize                 (cpuslv_awsize                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_awvalid                (cpuslv_awvalid                     ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_bid                    (cpuslv_bid                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_bready                 (cpuslv_bready                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_bresp                  (cpuslv_bresp                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_bvalid                 (cpuslv_bvalid                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_rdata                  (cpuslv_rdata                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_rid                    (cpuslv_rid                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_rlast                  (cpuslv_rlast                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_rready                 (cpuslv_rready                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_rresp                  (cpuslv_rresp                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_rvalid                 (cpuslv_rvalid                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_wdata                  (cpuslv_wdata                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_wlast                  (cpuslv_wlast                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_wready                 (cpuslv_wready                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.slv_wstrb                  (cpuslv_wstrb                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.slv_wvalid                 (cpuslv_wvalid                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
   `endif // NDS_IO_AHB
`endif // NDS_IO_SLAVEPORT
`ifdef NDS_NHART
   `ifdef NDS_IO_TRACE_INSTR_GEN1
      `ifdef NDS_IO_HART1
	.hart1_gen1_trace_enabled   (1'b0                               ), // (ae350_cpu_subsystem) <= ()
	.hart1_gen1_trace_cause     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_gen1_trace_iaddr     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_gen1_trace_iexception(/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_gen1_trace_instr     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_gen1_trace_interrupt (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_gen1_trace_ivalid    (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_gen1_trace_priv      (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_gen1_trace_tval      (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
      `endif // NDS_IO_HART1
   `endif // NDS_IO_TRACE_INSTR_GEN1
   `ifdef NDS_IO_TRACE_INSTR
      `ifdef NDS_IO_HART1
	.hart1_trace_enabled        (hart1_trace_enabled                ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.hart1_trace_cause          (hart1_trace_cause                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart1_trace_halted         (hart1_trace_halted                 ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart1_trace_iaddr          (hart1_trace_iaddr                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart1_trace_ilastsize      (hart1_trace_ilastsize              ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart1_trace_iretire        (hart1_trace_iretire                ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart1_trace_itype          (hart1_trace_itype                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart1_trace_priv           (hart1_trace_priv                   ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart1_trace_reset          (hart1_trace_reset                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart1_trace_trigger        (hart1_trace_trigger                ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart1_trace_tval           (hart1_trace_tval                   ), // (ae350_cpu_subsystem) => (ncetrace200)
      `endif // NDS_IO_HART1
   `endif // NDS_IO_TRACE_INSTR
   `ifdef NDS_IO_VPU
      `ifdef NDS_IO_HART1
	.hart1_vc_valu_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_vc_vdiv_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_vc_vfdiv_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_vc_vfmac_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_vc_vfmis_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_vc_vlsu_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_vc_vmac_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_vc_vmsk_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_vc_vper_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart1_vc_vpu_idle          (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
      `endif // NDS_IO_HART1
   `endif // NDS_IO_VPU
   `ifdef NDS_IO_TRACE_INSTR_GEN1
      `ifdef NDS_IO_HART2
	.hart2_gen1_trace_enabled   (1'b0                               ), // (ae350_cpu_subsystem) <= ()
	.hart2_gen1_trace_cause     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_gen1_trace_iaddr     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_gen1_trace_iexception(/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_gen1_trace_instr     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_gen1_trace_interrupt (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_gen1_trace_ivalid    (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_gen1_trace_priv      (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_gen1_trace_tval      (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
      `endif // NDS_IO_HART2
   `endif // NDS_IO_TRACE_INSTR_GEN1
   `ifdef NDS_IO_TRACE_INSTR
      `ifdef NDS_IO_HART2
	.hart2_trace_enabled        (hart2_trace_enabled                ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.hart2_trace_cause          (hart2_trace_cause                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart2_trace_halted         (hart2_trace_halted                 ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart2_trace_iaddr          (hart2_trace_iaddr                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart2_trace_ilastsize      (hart2_trace_ilastsize              ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart2_trace_iretire        (hart2_trace_iretire                ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart2_trace_itype          (hart2_trace_itype                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart2_trace_priv           (hart2_trace_priv                   ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart2_trace_reset          (hart2_trace_reset                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart2_trace_trigger        (hart2_trace_trigger                ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart2_trace_tval           (hart2_trace_tval                   ), // (ae350_cpu_subsystem) => (ncetrace200)
      `endif // NDS_IO_HART2
   `endif // NDS_IO_TRACE_INSTR
   `ifdef NDS_IO_VPU
      `ifdef NDS_IO_HART2
	.hart2_vc_valu_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_vc_vdiv_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_vc_vfdiv_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_vc_vfmac_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_vc_vfmis_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_vc_vlsu_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_vc_vmac_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_vc_vmsk_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_vc_vper_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart2_vc_vpu_idle          (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
      `endif // NDS_IO_HART2
   `endif // NDS_IO_VPU
   `ifdef NDS_IO_TRACE_INSTR_GEN1
      `ifdef NDS_IO_HART3
	.hart3_gen1_trace_enabled   (1'b0                               ), // (ae350_cpu_subsystem) <= ()
	.hart3_gen1_trace_cause     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_gen1_trace_iaddr     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_gen1_trace_iexception(/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_gen1_trace_instr     (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_gen1_trace_interrupt (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_gen1_trace_ivalid    (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_gen1_trace_priv      (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_gen1_trace_tval      (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
      `endif // NDS_IO_HART3
   `endif // NDS_IO_TRACE_INSTR_GEN1
   `ifdef NDS_IO_TRACE_INSTR
      `ifdef NDS_IO_HART3
	.hart3_trace_enabled        (hart3_trace_enabled                ), // (ae350_cpu_subsystem) <= (ncetrace200)
	.hart3_trace_cause          (hart3_trace_cause                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart3_trace_halted         (hart3_trace_halted                 ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart3_trace_iaddr          (hart3_trace_iaddr                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart3_trace_ilastsize      (hart3_trace_ilastsize              ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart3_trace_iretire        (hart3_trace_iretire                ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart3_trace_itype          (hart3_trace_itype                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart3_trace_priv           (hart3_trace_priv                   ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart3_trace_reset          (hart3_trace_reset                  ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart3_trace_trigger        (hart3_trace_trigger                ), // (ae350_cpu_subsystem) => (ncetrace200)
	.hart3_trace_tval           (hart3_trace_tval                   ), // (ae350_cpu_subsystem) => (ncetrace200)
      `endif // NDS_IO_HART3
   `endif // NDS_IO_TRACE_INSTR
   `ifdef NDS_IO_VPU
      `ifdef NDS_IO_HART3
	.hart3_vc_valu_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_vc_vdiv_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_vc_vfdiv_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_vc_vfmac_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_vc_vfmis_idle        (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_vc_vlsu_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_vc_vmac_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_vc_vmsk_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_vc_vper_idle         (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart3_vc_vpu_idle          (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
      `endif // NDS_IO_HART3
   `endif // NDS_IO_VPU
   `ifdef NDS_IO_L2C
      `ifdef NDS_IO_L2C_IO_COHERENCE
	.m4_araddr                  (m4_araddr                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_awaddr                  (m4_awaddr                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_arburst                 (m4_arburst                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_arcache                 (m4_arcache                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_arid                    (m4_arid                            ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_arlen                   (m4_arlen                           ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_arlock                  (m4_arlock                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_arprot                  (m4_arprot                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_arready                 (m4_arready                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.m4_arsize                  (m4_arsize                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_arvalid                 (m4_arvalid                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_awburst                 (m4_awburst                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_awcache                 (m4_awcache                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_awid                    (m4_awid                            ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_awlen                   (m4_awlen                           ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_awlock                  (m4_awlock                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_awprot                  (m4_awprot                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_awready                 (m4_awready                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.m4_awsize                  (m4_awsize                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_awvalid                 (m4_awvalid                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_bid                     (m4_bid                             ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.m4_bready                  (m4_bready                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_bresp                   (m4_bresp                           ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.m4_bvalid                  (m4_bvalid                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.m4_clk_en                  (axi2core_clken                     ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.m4_rdata                   (m4_rdata                           ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.m4_rid                     (m4_rid                             ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.m4_rlast                   (m4_rlast                           ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.m4_rready                  (m4_rready                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_rresp                   (m4_rresp                           ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.m4_rvalid                  (m4_rvalid                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.m4_wdata                   (m4_wdata                           ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_wlast                   (m4_wlast                           ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_wready                  (m4_wready                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.m4_wstrb                   (m4_wstrb                           ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.m4_wvalid                  (m4_wvalid                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
      `endif // NDS_IO_L2C_IO_COHERENCE
      `ifdef NDS_IO_L2C_IO_SLV
	.l2c_io_araddr              (l2c_io_araddr                      ), // (ae350_cpu_subsystem) => ()
	.l2c_io_arburst             (l2c_io_arburst                     ), // (ae350_cpu_subsystem) => ()
	.l2c_io_arcache             (l2c_io_arcache                     ), // (ae350_cpu_subsystem) => ()
	.l2c_io_arid                (l2c_io_arid                        ), // (ae350_cpu_subsystem) => ()
	.l2c_io_arlen               (l2c_io_arlen                       ), // (ae350_cpu_subsystem) => ()
	.l2c_io_arlock              (l2c_io_arlock                      ), // (ae350_cpu_subsystem) => ()
	.l2c_io_arprot              (l2c_io_arprot                      ), // (ae350_cpu_subsystem) => ()
	.l2c_io_arready             (l2c_io_arready                     ), // (ae350_cpu_subsystem) <= ()
	.l2c_io_arsize              (l2c_io_arsize                      ), // (ae350_cpu_subsystem) => ()
	.l2c_io_arvalid             (l2c_io_arvalid                     ), // (ae350_cpu_subsystem) => ()
	.l2c_io_awaddr              (l2c_io_awaddr                      ), // (ae350_cpu_subsystem) => ()
	.l2c_io_awburst             (l2c_io_awburst                     ), // (ae350_cpu_subsystem) => ()
	.l2c_io_awcache             (l2c_io_awcache                     ), // (ae350_cpu_subsystem) => ()
	.l2c_io_awid                (l2c_io_awid                        ), // (ae350_cpu_subsystem) => ()
	.l2c_io_awlen               (l2c_io_awlen                       ), // (ae350_cpu_subsystem) => ()
	.l2c_io_awlock              (l2c_io_awlock                      ), // (ae350_cpu_subsystem) => ()
	.l2c_io_awprot              (l2c_io_awprot                      ), // (ae350_cpu_subsystem) => ()
	.l2c_io_awready             (l2c_io_awready                     ), // (ae350_cpu_subsystem) <= ()
	.l2c_io_awsize              (l2c_io_awsize                      ), // (ae350_cpu_subsystem) => ()
	.l2c_io_awvalid             (l2c_io_awvalid                     ), // (ae350_cpu_subsystem) => ()
	.l2c_io_bid                 (l2c_io_bid                         ), // (ae350_cpu_subsystem) <= ()
	.l2c_io_bready              (l2c_io_bready                      ), // (ae350_cpu_subsystem) => ()
	.l2c_io_bresp               (l2c_io_bresp                       ), // (ae350_cpu_subsystem) <= ()
	.l2c_io_bvalid              (l2c_io_bvalid                      ), // (ae350_cpu_subsystem) <= ()
	.l2c_io_rdata               (l2c_io_rdata                       ), // (ae350_cpu_subsystem) <= ()
	.l2c_io_rid                 (l2c_io_rid                         ), // (ae350_cpu_subsystem) <= ()
	.l2c_io_rlast               (l2c_io_rlast                       ), // (ae350_cpu_subsystem) <= ()
	.l2c_io_rready              (l2c_io_rready                      ), // (ae350_cpu_subsystem) => ()
	.l2c_io_rresp               (l2c_io_rresp                       ), // (ae350_cpu_subsystem) <= ()
	.l2c_io_rvalid              (l2c_io_rvalid                      ), // (ae350_cpu_subsystem) <= ()
	.l2c_io_wdata               (l2c_io_wdata                       ), // (ae350_cpu_subsystem) => ()
	.l2c_io_wlast               (l2c_io_wlast                       ), // (ae350_cpu_subsystem) => ()
	.l2c_io_wready              (l2c_io_wready                      ), // (ae350_cpu_subsystem) <= ()
	.l2c_io_wstrb               (l2c_io_wstrb                       ), // (ae350_cpu_subsystem) => ()
	.l2c_io_wvalid              (l2c_io_wvalid                      ), // (ae350_cpu_subsystem) => ()
      `endif // NDS_IO_L2C_IO_SLV
   `endif // NDS_IO_L2C
`endif // NDS_NHART
`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
      `ifdef NDS_IO_AHB
	.dm_sys_haddr               (dm_sys_haddr                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_hburst              (dm_sys_hburst                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_hbusreq             (/* NC */                           ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.dm_sys_hgrant              (1'b1                               ), // (ae350_cpu_subsystem) <= ()
	.dm_sys_hprot               (dm_sys_hprot                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_hrdata              (dm_sys_hrdata                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_hready              (dm_sys_hready                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_hresp               (dm_sys_hresp                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_hsize               (dm_sys_hsize                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_htrans              (dm_sys_htrans                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_hwdata              (dm_sys_hwdata                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_hwrite              (dm_sys_hwrite                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
      `endif // NDS_IO_AHB
   `endif // PLATFORM_PLDM_SYS_BUS_ACCESS
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_NHART
`else
   `ifdef NDS_IO_BIU_X2
      `ifdef NDS_IO_AHB
      `else
	.i_arid                     (cpu_i_arid                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_araddr                   (cpu_i_araddr                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_arlen                    (cpu_i_arlen                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_arsize                   (cpu_i_arsize                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_arburst                  (cpu_i_arburst                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_arlock                   (cpu_i_arlock                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_arcache                  (cpu_i_arcache                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_arprot                   (cpu_i_arprot                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_arvalid                  (cpu_i_arvalid                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_arready                  (cpu_i_arready                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_awid                     (cpu_i_awid                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_awaddr                   (cpu_i_awaddr                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_awlen                    (cpu_i_awlen                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_awsize                   (cpu_i_awsize                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_awburst                  (cpu_i_awburst                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_awlock                   (cpu_i_awlock                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_awcache                  (cpu_i_awcache                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_awprot                   (cpu_i_awprot                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_awvalid                  (cpu_i_awvalid                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_awready                  (cpu_i_awready                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_wdata                    (cpu_i_wdata                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_wstrb                    (cpu_i_wstrb                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_wlast                    (cpu_i_wlast                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_wvalid                   (cpu_i_wvalid                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_wready                   (cpu_i_wready                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_bid                      (cpu_i_bid                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_bresp                    (cpu_i_bresp                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_bvalid                   (cpu_i_bvalid                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_bready                   (cpu_i_bready                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.i_rid                      (cpu_i_rid                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_rdata                    (cpu_i_rdata                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_rresp                    (cpu_i_rresp                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_rlast                    (cpu_i_rlast                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_rvalid                   (cpu_i_rvalid                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.i_rready                   (cpu_i_rready                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_arid                     (cpu_d_arid                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_araddr                   (cpu_d_araddr                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_arlen                    (cpu_d_arlen                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_arsize                   (cpu_d_arsize                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_arburst                  (cpu_d_arburst                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_arlock                   (cpu_d_arlock                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_arcache                  (cpu_d_arcache                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_arprot                   (cpu_d_arprot                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_arvalid                  (cpu_d_arvalid                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_arready                  (cpu_d_arready                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_awid                     (cpu_d_awid                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_awaddr                   (cpu_d_awaddr                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_awlen                    (cpu_d_awlen                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_awsize                   (cpu_d_awsize                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_awburst                  (cpu_d_awburst                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_awlock                   (cpu_d_awlock                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_awcache                  (cpu_d_awcache                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_awprot                   (cpu_d_awprot                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_awvalid                  (cpu_d_awvalid                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_awready                  (cpu_d_awready                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_wdata                    (cpu_d_wdata                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_wstrb                    (cpu_d_wstrb                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_wlast                    (cpu_d_wlast                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_wvalid                   (cpu_d_wvalid                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_wready                   (cpu_d_wready                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_bid                      (cpu_d_bid                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_bresp                    (cpu_d_bresp                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_bvalid                   (cpu_d_bvalid                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_bready                   (cpu_d_bready                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.d_rid                      (cpu_d_rid                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_rdata                    (cpu_d_rdata                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_rresp                    (cpu_d_rresp                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_rlast                    (cpu_d_rlast                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_rvalid                   (cpu_d_rvalid                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.d_rready                   (cpu_d_rready                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
      `endif // NDS_IO_AHB
   `else
      `ifdef NDS_IO_AHB
      `else
	.arid                       (cpu_arid                           ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.araddr                     (cpu_araddr                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arlen                      (cpu_arlen                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arsize                     (cpu_arsize                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arburst                    (cpu_arburst                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arlock                     (cpu_arlock                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arcache                    (cpu_arcache                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arprot                     (cpu_arprot                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arvalid                    (cpu_arvalid                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.arready                    (cpu_arready                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.awid                       (cpu_awid                           ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awaddr                     (cpu_awaddr                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awlen                      (cpu_awlen                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awsize                     (cpu_awsize                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awburst                    (cpu_awburst                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awlock                     (cpu_awlock                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awcache                    (cpu_awcache                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awprot                     (cpu_awprot                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awvalid                    (cpu_awvalid                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.awready                    (cpu_awready                        ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.wdata                      (cpu_wdata                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.wstrb                      (cpu_wstrb                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.wlast                      (cpu_wlast                          ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.wvalid                     (cpu_wvalid                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.wready                     (cpu_wready                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.bid                        (cpu_bid                            ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.bresp                      (cpu_bresp                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.bvalid                     (cpu_bvalid                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.bready                     (cpu_bready                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.rid                        (cpu_rid                            ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.rdata                      (cpu_rdata                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.rresp                      (cpu_rresp                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.rlast                      (cpu_rlast                          ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.rvalid                     (cpu_rvalid                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.rready                     (cpu_rready                         ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
      `endif // NDS_IO_AHB
   `endif // NDS_IO_BIU_X2
`endif // NDS_NHART
`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
      `ifdef NDS_IO_AHB
      `else
	.dm_sys_araddr              (dm_sys_araddr                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_arburst             (dm_sys_arburst                     ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_arcache             (dm_sys_arcache                     ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_arid                (dm_sys_arid                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_arlen               (dm_sys_arlen                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_arlock              (dm_sys_arlock                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_arprot              (dm_sys_arprot                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_arready             (dm_sys_arready                     ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_arsize              (dm_sys_arsize                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_arvalid             (dm_sys_arvalid                     ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_awaddr              (dm_sys_awaddr                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_awburst             (dm_sys_awburst                     ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_awcache             (dm_sys_awcache                     ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_awid                (dm_sys_awid                        ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_awlen               (dm_sys_awlen                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_awlock              (dm_sys_awlock                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_awprot              (dm_sys_awprot                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_awready             (dm_sys_awready                     ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_awsize              (dm_sys_awsize                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_awvalid             (dm_sys_awvalid                     ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_bid                 (dm_sys_bid                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_bready              (dm_sys_bready                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_bresp               (dm_sys_bresp                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_bvalid              (dm_sys_bvalid                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_rdata               (dm_sys_rdata                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_rid                 (dm_sys_rid                         ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_rlast               (dm_sys_rlast                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_rready              (dm_sys_rready                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_rresp               (dm_sys_rresp                       ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_rvalid              (dm_sys_rvalid                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_wdata               (dm_sys_wdata                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_wlast               (dm_sys_wlast                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_wready              (dm_sys_wready                      ), // (ae350_cpu_subsystem) <= (ae350_bus_connector)
	.dm_sys_wstrb               (dm_sys_wstrb                       ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
	.dm_sys_wvalid              (dm_sys_wvalid                      ), // (ae350_cpu_subsystem) => (ae350_bus_connector)
      `endif // NDS_IO_AHB
   `endif // PLATFORM_PLDM_SYS_BUS_ACCESS
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_NHART
`else
   `ifdef NDS_IO_DLM_AHBLITE
      `ifdef PLATFORM_DLM_AHBLITE_USE_SYNCDN
	.pclk                       (pclk                               ), // (ae350_apb_subsystem,ae350_cpu_subsystem) <= (ae350_aopd)
	.apb2ahb_clken              (apb2ahb_clken                      ), // (ae350_apb_subsystem,ae350_cpu_subsystem) <= (ae350_aopd)
      `endif // PLATFORM_DLM_AHBLITE_USE_SYNCDN
   `endif // NDS_IO_DLM_AHBLITE
   `ifdef NDS_IO_ACE_VPU
      `ifdef NDS_CUSTOM_ACE_VPU
	.cp_cpu_rdata               (cp_cpu_rdata                       ), // (ae350_cpu_subsystem) <= ()
	.cp_cpu_rdata_ready         (cp_cpu_rdata_ready                 ), // (ae350_cpu_subsystem) => ()
	.cp_cpu_rdata_valid         (cp_cpu_rdata_valid                 ), // (ae350_cpu_subsystem) <= ()
	.cpu_cp_wdata               (cpu_cp_wdata                       ), // (ae350_cpu_subsystem) => ()
	.cpu_cp_wdata_bwe           (cpu_cp_wdata_bwe                   ), // (ae350_cpu_subsystem) => ()
	.cpu_cp_wdata_ready         (cpu_cp_wdata_ready                 ), // (ae350_cpu_subsystem) <= ()
	.cpu_cp_wdata_valid         (cpu_cp_wdata_valid                 ), // (ae350_cpu_subsystem) => ()
      `endif // NDS_CUSTOM_ACE_VPU
   `endif // NDS_IO_ACE_VPU
`endif // NDS_NHART
`ifdef NDS_NHART
   `ifdef NDS_IO_L2C
	.core0_wfi_sel_iso          (core0_wfi_sel_iso_sync             ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.core1_wfi_sel_iso          (core1_wfi_sel_iso_sync             ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.core2_wfi_sel_iso          (core2_wfi_sel_iso_sync             ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.core3_wfi_sel_iso          (core3_wfi_sel_iso_sync             ), // (ae350_cpu_subsystem) <= (ae350_aopd)
   `endif // NDS_IO_L2C
`endif // NDS_NHART
	.core_clk                   (core_clk                           ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.core_resetn                (core_resetn                        ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.dbg_srst_req               (dbg_srst_req                       ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.dc_clk                     (dc_clk                             ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart0_wakeup_event         (hart0_wakeup_event                 ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.lm_clk                     (lm_clk                             ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.int_src                    (int_src                            ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.mtime_clk                  (pclk                               ), // (ae350_apb_subsystem,ae350_cpu_subsystem) <= (ae350_aopd)
	.por_rstn                   (por_rstn                           ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.scan_enable                (scan_enable                        ), // (ae350_apb_subsystem,ae350_cpu_subsystem,ncetrace200) <= (ae350_aopd)
	.test_mode                  (test_mode                          ), // (ae350_cpu_subsystem,ncetrace200) <= (ae350_aopd)
	.test_rstn                  (test_rstn                          ), // (ae350_cpu_subsystem,ncetrace200) <= (ae350_aopd)
	.hart0_reset_vector         (core_reset_vectors[(VALEN-1):0]    ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart0_icache_disable_init  (hart0_icache_disable_init          ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart0_dcache_disable_init  (hart0_dcache_disable_init          ), // (ae350_cpu_subsystem) <= (ae350_aopd)
	.hart0_core_wfi_mode        (hart0_core_wfi_mode                ), // (ae350_cpu_subsystem) => (ae350_aopd)
	.hart0_nmi                  (wdt_int                            )  // (ae350_aopd,ae350_cpu_subsystem) <= (ae350_apb_subsystem)
); // end of ae350_cpu_subsystem

`ifdef PLATFORM_NO_RAM_SUBSYSTEM
`else
ae350_ram_subsystem #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (CPUSUB_BIU_DATA_WIDTH),
	.ID_WIDTH        (CPUSUB_BIU_ID_WIDTH+4),
	.SIMULATION      (SIMULATION      ),
	.SIM_BYPASS_INIT_CAL(SIM_BYPASS_INIT_CAL)
) ae350_ram_subsystem (
   `ifdef AE350_AXI_SUPPORT
	.arcache            (ram_arcache        ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.arprot             (ram_arprot         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.awcache            (ram_awcache        ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.awprot             (ram_awprot         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.wlast              (ram_wlast          ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.aclk               (aclk               ), // (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem) <= (ae350_aopd)
	.aresetn            (aresetn            ), // (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,ncetrace200) <= (ae350_aopd)
	.araddr             (ram_araddr         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.arburst            (ram_arburst        ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.arid               (ram_arid           ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.arlen              (ram_arlen          ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.arlock             (ram_arlock         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.arready            (ram_arready        ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.arsize             (ram_arsize         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.arvalid            (ram_arvalid        ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.awaddr             (ram_awaddr         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.awburst            (ram_awburst        ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.awid               (ram_awid           ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.awlen              (ram_awlen          ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.awlock             (ram_awlock         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.awready            (ram_awready        ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.awsize             (ram_awsize         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.awvalid            (ram_awvalid        ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.bid                (ram_bid            ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.bready             (ram_bready         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.bresp              (ram_bresp          ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.bvalid             (ram_bvalid         ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.rdata              (ram_rdata          ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.rid                (ram_rid            ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.rlast              (ram_rlast          ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.rready             (ram_rready         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.rresp              (ram_rresp          ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.rvalid             (ram_rvalid         ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.wdata              (ram_wdata          ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.wready             (ram_wready         ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.wstrb              (ram_wstrb          ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.wvalid             (ram_wvalid         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
   `else
	.hsel               (ram_hsel           ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.hresetn            (hresetn            ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
	.hclk               (hclk               ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
	.haddr              (ram_haddr          ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.hburst             (ram_hburst         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.hprot              (ram_hprot          ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.hready             (ram_hready         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.hreadyout          (ram_hreadyout      ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.hsize              (ram_hsize          ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.htrans             (ram_htrans         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.hwrite             (ram_hwrite         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
	.hresp              (ram_hresp          ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.hrdata             (ram_hrdata         ), // (ae350_ram_subsystem) => (ae350_bus_connector)
	.hwdata             (ram_hwdata         ), // (ae350_ram_subsystem) <= (ae350_bus_connector)
   `endif // AE350_AXI_SUPPORT
   `ifdef AE350_K7DDR3_SUPPORT
	.X_ddr3_dq          (X_ddr3_dq          ), // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
	.X_ddr3_dqs_n       (X_ddr3_dqs_n       ), // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
	.X_ddr3_dqs_p       (X_ddr3_dqs_p       ), // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
      `ifdef AE350_AXI_SUPPORT
	.X_ddr3_addr        (X_ddr3_addr        ), // (ae350_ram_subsystem) => ()
	.X_ddr3_ba          (X_ddr3_ba          ), // (ae350_ram_subsystem) => ()
	.X_ddr3_cas_n       (X_ddr3_cas_n       ), // (ae350_ram_subsystem) => ()
	.X_ddr3_ck_n        (X_ddr3_ck_n        ), // (ae350_ram_subsystem) => ()
	.X_ddr3_ck_p        (X_ddr3_ck_p        ), // (ae350_ram_subsystem) => ()
	.X_ddr3_cke         (X_ddr3_cke         ), // (ae350_ram_subsystem) => ()
	.X_ddr3_cs_n        (X_ddr3_cs_n        ), // (ae350_ram_subsystem) => ()
	.X_ddr3_dm          (X_ddr3_dm          ), // (ae350_ram_subsystem) => ()
	.X_ddr3_odt         (X_ddr3_odt         ), // (ae350_ram_subsystem) => ()
	.X_ddr3_ras_n       (X_ddr3_ras_n       ), // (ae350_ram_subsystem) => ()
	.X_ddr3_reset_n     (X_ddr3_reset_n     ), // (ae350_ram_subsystem) => ()
	.X_ddr3_sys_clk_n   (X_ddr3_sys_clk_n   ), // (ae350_ram_subsystem) <= ()
	.X_ddr3_sys_clk_p   (X_ddr3_sys_clk_p   ), // (ae350_ram_subsystem) <= ()
	.X_ddr3_we_n        (X_ddr3_we_n        ), // (ae350_ram_subsystem) => ()
	.ddr3_aresetn       (ddr3_aresetn       ), // (ae350_ram_subsystem) <= (ae350_aopd)
      `else
	.X_ddr3_addr        (X_ddr3_addr        ), // (ae350_ram_subsystem) => ()
	.X_ddr3_ba          (X_ddr3_ba          ), // (ae350_ram_subsystem) => ()
	.X_ddr3_cas_n       (X_ddr3_cas_n       ), // (ae350_ram_subsystem) => ()
	.X_ddr3_ck_n        (X_ddr3_ck_n        ), // (ae350_ram_subsystem) => ()
	.X_ddr3_ck_p        (X_ddr3_ck_p        ), // (ae350_ram_subsystem) => ()
	.X_ddr3_cke         (X_ddr3_cke         ), // (ae350_ram_subsystem) => ()
	.X_ddr3_cs_n        (X_ddr3_cs_n        ), // (ae350_ram_subsystem) => ()
	.X_ddr3_dm          (X_ddr3_dm          ), // (ae350_ram_subsystem) => ()
	.X_ddr3_odt         (X_ddr3_odt         ), // (ae350_ram_subsystem) => ()
	.X_ddr3_ras_n       (X_ddr3_ras_n       ), // (ae350_ram_subsystem) => ()
	.X_ddr3_reset_n     (X_ddr3_reset_n     ), // (ae350_ram_subsystem) => ()
	.X_ddr3_sys_clk_n   (X_ddr3_sys_clk_n   ), // (ae350_ram_subsystem) <= ()
	.X_ddr3_sys_clk_p   (X_ddr3_sys_clk_p   ), // (ae350_ram_subsystem) <= ()
	.X_ddr3_we_n        (X_ddr3_we_n        ), // (ae350_ram_subsystem) => ()
      `endif // AE350_AXI_SUPPORT
      `ifdef AE350_AXI_SUPPORT
         `ifdef NDS_FPGA
	.ddr3_bw_ctrl       (ddr3_bw_ctrl       ), // (ae350_ram_subsystem) <= (ae350_aopd)
	.ddr3_latency       (ddr3_latency       ), // (ae350_ram_subsystem) <= (ae350_aopd)
         `endif // NDS_FPGA
      `endif // AE350_AXI_SUPPORT
   `else
      `ifdef AE350_AXI_SUPPORT
         `ifdef AE350_VUDDR4_SUPPORT
	.X_ddr4_dm_dbi_n    (X_ddr4_dm_dbi_n    ), // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
	.X_ddr4_dq          (X_ddr4_dq          ), // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
	.X_ddr4_dqs_c       (X_ddr4_dqs_c       ), // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
	.X_ddr4_dqs_t       (X_ddr4_dqs_t       ), // (ae350_ram_subsystem) <=> (ae350_ram_subsystem)
            `ifdef NDS_FPGA
	.X_ddr4_act_n       (X_ddr4_act_n       ), // (ae350_ram_subsystem) => ()
	.X_ddr4_addr        (X_ddr4_addr        ), // (ae350_ram_subsystem) => ()
	.X_ddr4_ba          (X_ddr4_ba          ), // (ae350_ram_subsystem) => ()
	.X_ddr4_bg          (X_ddr4_bg          ), // (ae350_ram_subsystem) => ()
	.X_ddr4_ck_c        (X_ddr4_ck_c        ), // (ae350_ram_subsystem) => ()
	.X_ddr4_ck_t        (X_ddr4_ck_t        ), // (ae350_ram_subsystem) => ()
	.X_ddr4_cke         (X_ddr4_cke         ), // (ae350_ram_subsystem) => ()
	.X_ddr4_cs_n        (X_ddr4_cs_n        ), // (ae350_ram_subsystem) => ()
	.X_ddr4_odt         (X_ddr4_odt         ), // (ae350_ram_subsystem) => ()
	.X_ddr4_reset_n     (X_ddr4_reset_n     ), // (ae350_ram_subsystem) => ()
	.X_ddr4_sys_clk_n   (X_ddr4_sys_clk_n   ), // (ae350_ram_subsystem) <= ()
	.X_ddr4_sys_clk_p   (X_ddr4_sys_clk_p   ), // (ae350_ram_subsystem) <= ()
	.ddr3_latency       (ddr3_latency       ), // (ae350_ram_subsystem) <= (ae350_aopd)
	.ddr4_aresetn       (ddr4_aresetn       ), // (ae350_ram_subsystem) <= (ae350_aopd)
            `else
	.X_ddr4_act_n       (X_ddr4_act_n       ), // (ae350_ram_subsystem) => ()
	.X_ddr4_addr        (X_ddr4_addr        ), // (ae350_ram_subsystem) => ()
	.X_ddr4_ba          (X_ddr4_ba          ), // (ae350_ram_subsystem) => ()
	.X_ddr4_bg          (X_ddr4_bg          ), // (ae350_ram_subsystem) => ()
	.X_ddr4_ck_c        (X_ddr4_ck_c        ), // (ae350_ram_subsystem) => ()
	.X_ddr4_ck_t        (X_ddr4_ck_t        ), // (ae350_ram_subsystem) => ()
	.X_ddr4_cke         (X_ddr4_cke         ), // (ae350_ram_subsystem) => ()
	.X_ddr4_cs_n        (X_ddr4_cs_n        ), // (ae350_ram_subsystem) => ()
	.X_ddr4_odt         (X_ddr4_odt         ), // (ae350_ram_subsystem) => ()
	.X_ddr4_reset_n     (X_ddr4_reset_n     ), // (ae350_ram_subsystem) => ()
	.X_ddr4_sys_clk_n   (X_ddr4_sys_clk_n   ), // (ae350_ram_subsystem) <= ()
	.X_ddr4_sys_clk_p   (X_ddr4_sys_clk_p   ), // (ae350_ram_subsystem) <= ()
	.ddr4_aresetn       (ddr4_aresetn       ), // (ae350_ram_subsystem) <= (ae350_aopd)
            `endif // NDS_FPGA
         `endif // AE350_VUDDR4_SUPPORT
      `endif // AE350_AXI_SUPPORT
   `endif // AE350_K7DDR3_SUPPORT
	.T_por_b            (T_por_b            ), // (ae350_aopd,ae350_ram_subsystem) <= (ae350_pin)
	.init_calib_complete(init_calib_complete), // (ae350_ram_subsystem) => (ae350_aopd)
	.ui_clk             (ui_clk             )  // (ae350_ram_subsystem) => (ae350_aopd)
); // end of ae350_ram_subsystem

`endif // PLATFORM_NO_RAM_SUBSYSTEM
`ifdef AE350_SMC_SUPPORT
   `ifdef AE350_SPI1_SUPPORT
atcbusdec200_rom u_rom_ahbdec (
      `ifdef ATCBUSDEC200_ROM_SLV1_SUPPORT
	.ds1_hsel      (spi_mem_hsel                          ), // (u_rom_ahbdec) => (ae350_apb_subsystem)
	.ds1_hrdata    (spi_mem_hrdata                        ), // (u_rom_ahbdec) <= (ae350_apb_subsystem)
	.ds1_hreadyout (spi_mem_hreadyout                     ), // (u_rom_ahbdec) <= (ae350_apb_subsystem)
	.ds1_hresp     (spi_mem_hresp[0]                      ), // (u_rom_ahbdec) <= (ae350_apb_subsystem)
      `endif // ATCBUSDEC200_ROM_SLV1_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV2_SUPPORT
	.ds2_hsel      (smc_mem_hsel                          ), // (u_rom_ahbdec) => (ae350_ahb_subsystem)
	.ds2_hrdata    (smc_mem_hrdata                        ), // (u_rom_ahbdec) <= (ae350_ahb_subsystem)
	.ds2_hreadyout (smc_mem_hreadyout                     ), // (u_rom_ahbdec) <= (ae350_ahb_subsystem)
	.ds2_hresp     (smc_mem_hresp[0]                      ), // (u_rom_ahbdec) <= (ae350_ahb_subsystem)
      `endif // ATCBUSDEC200_ROM_SLV2_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV3_SUPPORT
	.ds3_hsel      (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds3_hrdata    ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds3_hreadyout (1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds3_hresp     (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV3_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV4_SUPPORT
	.ds4_hsel      (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds4_hrdata    ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds4_hreadyout (1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds4_hresp     (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV4_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV5_SUPPORT
	.ds5_hsel      (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds5_hrdata    ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds5_hreadyout (1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds5_hresp     (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV5_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV6_SUPPORT
	.ds6_hsel      (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds6_hrdata    ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds6_hreadyout (1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds6_hresp     (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV6_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV7_SUPPORT
	.ds7_hsel      (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds7_hrdata    ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds7_hreadyout (1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds7_hresp     (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV7_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV8_SUPPORT
	.ds8_hsel      (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds8_hrdata    ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds8_hreadyout (1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds8_hresp     (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV8_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV9_SUPPORT
	.ds9_hsel      (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds9_hrdata    ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds9_hreadyout (1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds9_hresp     (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV9_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV10_SUPPORT
	.ds10_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds10_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds10_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds10_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV10_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV11_SUPPORT
	.ds11_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds11_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds11_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds11_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV11_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV12_SUPPORT
	.ds12_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds12_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds12_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds12_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV12_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV13_SUPPORT
	.ds13_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds13_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds13_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds13_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV13_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV14_SUPPORT
	.ds14_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds14_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds14_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds14_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV14_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV15_SUPPORT
	.ds15_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds15_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds15_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds15_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV15_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV16_SUPPORT
	.ds16_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds16_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds16_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds16_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV16_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV17_SUPPORT
	.ds17_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds17_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds17_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds17_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV17_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV18_SUPPORT
	.ds18_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds18_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds18_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds18_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV18_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV19_SUPPORT
	.ds19_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds19_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds19_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds19_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV19_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV20_SUPPORT
	.ds20_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds20_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds20_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds20_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV20_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV21_SUPPORT
	.ds21_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds21_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds21_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds21_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV21_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV22_SUPPORT
	.ds22_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds22_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds22_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds22_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV22_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV23_SUPPORT
	.ds23_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds23_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds23_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds23_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV23_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV24_SUPPORT
	.ds24_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds24_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds24_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds24_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV24_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV25_SUPPORT
	.ds25_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds25_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds25_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds25_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV25_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV26_SUPPORT
	.ds26_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds26_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds26_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds26_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV26_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV27_SUPPORT
	.ds27_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds27_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds27_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds27_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV27_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV28_SUPPORT
	.ds28_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds28_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds28_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds28_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV28_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV29_SUPPORT
	.ds29_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds29_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds29_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds29_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV29_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV30_SUPPORT
	.ds30_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds30_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds30_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds30_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV30_SUPPORT
      `ifdef ATCBUSDEC200_ROM_SLV31_SUPPORT
	.ds31_hsel     (/* NC */                              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.ds31_hrdata   ({(`ATCBUSDEC200_ROM_DATA_MSB+1){1'b0}}), // () <= ()
	.ds31_hreadyout(1'b1                                  ), // (u_rom_ahbdec) <= ()
	.ds31_hresp    (1'b0                                  ), // (u_rom_ahbdec) <= ()
      `endif // ATCBUSDEC200_ROM_SLV31_SUPPORT
	.hclk          (hclk                                  ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
	.hresetn       (hresetn                               ), // (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec) <= (ae350_aopd)
	.us_haddr      (rom_haddr[31:0]                       ), // (u_rom_ahbdec) <= (ae350_bus_connector)
	.us_hsel       (1'b1                                  ), // (u_rom_ahbdec) <= ()
	.us_htrans     (rom_htrans                            ), // (u_rom_ahbdec) <= (ae350_bus_connector)
	.us_hrdata     (rom_hrdata                            ), // (u_rom_ahbdec) => (ae350_bus_connector)
	.us_hready     (rom_hready                            ), // (u_rom_ahbdec) <= (ae350_bus_connector)
	.us_hreadyout  (rom_hreadyout                         ), // (u_rom_ahbdec) => (ae350_bus_connector)
	.us_hresp      (rom_hresp                             ), // (u_rom_ahbdec) => (ae350_bus_connector)
	.ds_hready     (dec_hready                            )  // (u_rom_ahbdec) => ()
); // end of u_rom_ahbdec

   `endif // AE350_SPI1_SUPPORT
`endif // AE350_SMC_SUPPORT
ae350_aopd #(
	.SYNC_STAGE      (SYNC_STAGE      )
) ae350_aopd (
`ifdef AE350_RTC_SUPPORT
	.rtc_pready               (rtc_pready               ), // (ae350_aopd) => (ae350_apb_subsystem)
	.rtc_pslverr              (rtc_pslverr              ), // (ae350_aopd) => (ae350_apb_subsystem)
	.rtc_prdata               (rtc_prdata               ), // (ae350_aopd) => (ae350_apb_subsystem)
	.rtc_psel                 (rtc_psel                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
`endif // AE350_RTC_SUPPORT
`ifdef NDS_BOARD_CF1
	.int_src                  (int_src                  ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.cf1_pinmux_ctrl0         (cf1_pinmux_ctrl0         ), // (ae350_aopd) => (ae350_pin)
	.cf1_pinmux_ctrl1         (cf1_pinmux_ctrl1         ), // (ae350_aopd) => (ae350_pin)
`else
	.int_src                  (int_src                  ), // (ae350_aopd) => (ae350_cpu_subsystem)
`endif // NDS_BOARD_CF1
`ifdef NDS_FPGA
	.sdc_clk                  (sdc_clk                  ), // (ae350_aopd) => (ae350_apb_subsystem)
`else
	.X_aopd_por_b             (X_aopd_por_b             ), // (ae350_aopd) <=> (ae350_aopd)
	.X_mpd_pwr_off            (X_mpd_pwr_off            ), // (ae350_aopd) <=> (ae350_aopd)
	.X_om                     (X_om                     ), // (ae350_aopd) <=> (ae350_aopd)
	.X_osclio                 (X_osclio                 ), // (ae350_aopd) <=> (ae350_aopd)
	.sdc_clk                  (sdc_clk                  ), // (ae350_aopd) => (ae350_apb_subsystem)
`endif // NDS_FPGA
`ifdef AE350_AHB_SUPPORT
	.bmc_intr                 (bmc_intr                 ), // (ae350_aopd) <= (ae350_bus_connector)
`endif // AE350_AHB_SUPPORT
`ifdef PLATFORM_DEBUG_PORT
	.X_tck                    (X_tck                    ), // (ae350_aopd) <=> (ae350_aopd)
	.pin_tdi_in               (pin_tdi_in               ), // (ae350_aopd) <= (ae350_pin)
	.pin_tdo_out              (pin_tdo_out              ), // (ae350_aopd) => (ae350_pin)
	.pin_tdo_out_en           (pin_tdo_out_en           ), // (ae350_aopd) => (ae350_pin)
	.pin_tms_in               (pin_tms_in               ), // (ae350_aopd) <= (ae350_pin)
	.pin_tms_out              (pin_tms_out              ), // (ae350_aopd) => (ae350_pin)
	.pin_tms_out_en           (pin_tms_out_en           ), // (ae350_aopd) => (ae350_pin)
	.pin_trst_in              (pin_trst_in              ), // (ae350_aopd) <= (ae350_pin)
`endif // PLATFORM_DEBUG_PORT
`ifdef AE350_SSP_SUPPORT
	.sspclk                   (sspclk                   ), // (ae350_aopd) => (ae350_apb_subsystem)
	.ssp_rstn                 (ssp_rstn                 ), // (ae350_aopd) => (ae350_apb_subsystem)
`endif // AE350_SSP_SUPPORT
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	.dmi_haddr                (dmi_haddr                ), // (ae350_aopd) => (ncetrace200)
	.dmi_hburst               (dmi_hburst               ), // (ae350_aopd) => (ncetrace200)
	.dmi_hprot                (dmi_hprot                ), // (ae350_aopd) => (ncetrace200)
	.dmi_hrdata               (dmi_hrdata               ), // (ae350_aopd) <= (ncetrace200)
	.dmi_hready               (dmi_hready               ), // (ae350_aopd) <= (ncetrace200)
	.dmi_hresp                (dmi_hresp                ), // (ae350_aopd) <= (ncetrace200)
	.dmi_hsel                 (dmi_hsel                 ), // (ae350_aopd) => (ncetrace200)
	.dmi_hsize                (dmi_hsize                ), // (ae350_aopd) => (ncetrace200)
	.dmi_htrans               (dmi_htrans               ), // (ae350_aopd) => (ncetrace200)
	.dmi_hwdata               (dmi_hwdata               ), // (ae350_aopd) => (ncetrace200)
	.dmi_hwrite               (dmi_hwrite               ), // (ae350_aopd) => (ncetrace200)
	.dmi_resetn               (dmi_resetn               ), // (ae350_aopd) => (ncetrace200)
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef AE350_LCDC_SUPPORT
	.lcd_clk                  (lcd_clk                  ), // (ae350_aopd) => (ae350_ahb_subsystem)
	.lcd_clkn                 (lcd_clkn                 ), // (ae350_aopd) => (ae350_ahb_subsystem)
`endif // AE350_LCDC_SUPPORT
`ifdef AE350_K7DDR3_SUPPORT
	.ddr3_aresetn             (ddr3_aresetn             ), // (ae350_aopd) => (ae350_ram_subsystem)
`endif // AE350_K7DDR3_SUPPORT
`ifdef AE350_VUDDR4_SUPPORT
	.ddr4_aresetn             (ddr4_aresetn             ), // (ae350_aopd) => (ae350_ram_subsystem)
`endif // AE350_VUDDR4_SUPPORT
`ifdef NDS_NHART
   `ifdef NDS_IO_L2C
	.l2c_err_int              (l2c_err_int              ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.l2c_pcs_standby_ok       (l2c_pcs_standby_ok       ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.pcs_core0_sleep_ok       (pcs_core0_sleep_ok       ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.pcs_core0_sleep_req      (pcs_core0_sleep_req      ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.pcs_core1_sleep_ok       (pcs_core1_sleep_ok       ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.pcs_core1_sleep_req      (pcs_core1_sleep_req      ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.pcs_core2_sleep_ok       (pcs_core2_sleep_ok       ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.pcs_core2_sleep_req      (pcs_core2_sleep_req      ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.pcs_core3_sleep_ok       (pcs_core3_sleep_ok       ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.pcs_core3_sleep_req      (pcs_core3_sleep_req      ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.core0_wfi_sel_iso_sync   (core0_wfi_sel_iso_sync   ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.core1_wfi_sel_iso_sync   (core1_wfi_sel_iso_sync   ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.core2_wfi_sel_iso_sync   (core2_wfi_sel_iso_sync   ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.core3_wfi_sel_iso_sync   (core3_wfi_sel_iso_sync   ), // (ae350_aopd) => (ae350_cpu_subsystem)
   `endif // NDS_IO_L2C
`endif // NDS_NHART
`ifdef NDS_FPGA
`else
   `ifdef AE350_RTC_SUPPORT
	.X_rtc_wakeup             (X_rtc_wakeup             ), // (ae350_aopd) <=> (ae350_aopd)
   `endif // AE350_RTC_SUPPORT
`endif // NDS_FPGA
`ifdef NDS_FPGA
   `ifdef AE350_DDR_LATENCY
	.ddr3_bw_ctrl             (ddr3_bw_ctrl             ), // (ae350_aopd) => (ae350_ram_subsystem)
	.ddr3_latency             (ddr3_latency             ), // (ae350_aopd) => (ae350_ram_subsystem)
   `endif // AE350_DDR_LATENCY
`endif // NDS_FPGA
`ifdef NDS_NHART
   `ifdef NDS_IO_HART1
	.hart1_core_wfi_mode      (hart1_core_wfi_mode      ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.hart1_dcache_disable_init(hart1_dcache_disable_init), // (ae350_aopd) => (ae350_cpu_subsystem)
	.hart1_icache_disable_init(hart1_icache_disable_init), // (ae350_aopd) => (ae350_cpu_subsystem)
	.hart1_wakeup_event       (hart1_wakeup_event       ), // (ae350_aopd) <= (ae350_cpu_subsystem)
   `endif // NDS_IO_HART1
   `ifdef NDS_IO_HART2
	.hart2_core_wfi_mode      (hart2_core_wfi_mode      ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.hart2_dcache_disable_init(hart2_dcache_disable_init), // (ae350_aopd) => (ae350_cpu_subsystem)
	.hart2_icache_disable_init(hart2_icache_disable_init), // (ae350_aopd) => (ae350_cpu_subsystem)
	.hart2_wakeup_event       (hart2_wakeup_event       ), // (ae350_aopd) <= (ae350_cpu_subsystem)
   `endif // NDS_IO_HART2
   `ifdef NDS_IO_HART3
	.hart3_core_wfi_mode      (hart3_core_wfi_mode      ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.hart3_dcache_disable_init(hart3_dcache_disable_init), // (ae350_aopd) => (ae350_cpu_subsystem)
	.hart3_icache_disable_init(hart3_icache_disable_init), // (ae350_aopd) => (ae350_cpu_subsystem)
	.hart3_wakeup_event       (hart3_wakeup_event       ), // (ae350_aopd) <= (ae350_cpu_subsystem)
   `endif // NDS_IO_HART3
`endif // NDS_NHART
`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef PLATFORM_JDTM_SECURE_SUPPORT
	.secure_code              (secure_code              ), // (ae350_aopd) <= ()
	.secure_mode              (secure_mode              ), // (ae350_aopd) <= ()
   `endif // PLATFORM_JDTM_SECURE_SUPPORT
   `ifdef NDS_IO_TRACE_INSTR
	.ts_clk                   (ts_clk                   ), // (ae350_aopd) => (ncetrace200)
	.te_reset_n               (te_reset_n               ), // (ae350_aopd) => (ncetrace200)
	.ts_reset_n               (ts_reset_n               ), // (ae350_aopd) => (ncetrace200)
   `endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
	.dma_int                  (dma_int                  ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.extclk                   (extclk                   ), // (ae350_aopd) => (ae350_apb_subsystem)
	.gpio_intr                (gpio_intr                ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.hart0_core_wfi_mode      (hart0_core_wfi_mode      ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.hart0_dcache_disable_init(hart0_dcache_disable_init), // (ae350_aopd) => (ae350_cpu_subsystem)
	.hart0_icache_disable_init(hart0_icache_disable_init), // (ae350_aopd) => (ae350_cpu_subsystem)
	.hart0_wakeup_event       (hart0_wakeup_event       ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.i2c2_int                 (i2c2_int                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.i2c_int                  (i2c_int                  ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.lcd_intr                 (lcd_intr                 ), // (ae350_aopd) <= (ae350_ahb_subsystem)
	.mac_int                  (mac_int                  ), // (ae350_aopd) <= (ae350_ahb_subsystem)
	.pit2_int                 (pit2_int                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.pit3_int                 (pit3_int                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.pit4_int                 (pit4_int                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.pit5_int                 (pit5_int                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.pit_intr                 (pit_intr                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.sdc_int                  (sdc_int                  ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.spi1_int                 (spi1_int                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.spi2_int                 (spi2_int                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.spi3_int                 (spi3_int                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.spi4_int                 (spi4_int                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.ssp_intr                 (ssp_intr                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.uart1_int                (uart1_int                ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.uart2_int                (uart2_int                ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.wdt_int                  (wdt_int                  ), // (ae350_aopd,ae350_cpu_subsystem) <= (ae350_apb_subsystem)
	.X_osclin                 (X_osclin                 ), // (ae350_aopd) <= ()
	.X_wakeup_in              (X_wakeup_in              ), // (ae350_aopd) <=> (ae350_aopd)
	.T_por_b                  (T_por_b                  ), // (ae350_aopd,ae350_ram_subsystem) <= (ae350_pin)
	.scan_enable              (scan_enable              ), // (ae350_aopd) => (ae350_apb_subsystem,ae350_cpu_subsystem,ncetrace200)
	.scan_test                (scan_test                ), // (ae350_aopd) => (ae350_apb_subsystem)
	.test_mode                (test_mode                ), // (ae350_aopd) => (ae350_cpu_subsystem,ncetrace200)
	.test_rstn                (test_rstn                ), // (ae350_aopd) => (ae350_cpu_subsystem,ncetrace200)
	.T_osch                   (T_osch                   ), // (ae350_aopd) <= (ae350_pin)
	.aclk                     (aclk                     ), // (ae350_aopd) => (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem)
	.ahb2core_clken           (ahb2core_clken           ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.apb2ahb_clken            (apb2ahb_clken            ), // (ae350_aopd) => (ae350_apb_subsystem,ae350_cpu_subsystem)
	.apb2core_clken           (apb2core_clken           ), // (ae350_aopd) => (ae350_apb_subsystem)
	.axi2core_clken           (axi2core_clken           ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.core_clk                 (core_clk                 ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.dc_clk                   (dc_clk                   ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.hclk                     (hclk                     ), // (ae350_aopd) => (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec)
	.lm_clk                   (lm_clk                   ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.pclk                     (pclk                     ), // (ae350_aopd) => (ae350_apb_subsystem,ae350_cpu_subsystem)
	.pclk_gpio                (pclk_gpio                ), // (ae350_aopd) => (ae350_apb_subsystem)
	.pclk_i2c                 (pclk_i2c                 ), // (ae350_aopd) => (ae350_apb_subsystem)
	.pclk_pit                 (pclk_pit                 ), // (ae350_aopd) => (ae350_apb_subsystem)
	.pclk_spi1                (pclk_spi1                ), // (ae350_aopd) => (ae350_apb_subsystem)
	.pclk_spi2                (pclk_spi2                ), // (ae350_aopd) => (ae350_apb_subsystem)
	.pclk_uart1               (pclk_uart1               ), // (ae350_aopd) => (ae350_apb_subsystem)
	.pclk_uart2               (pclk_uart2               ), // (ae350_aopd) => (ae350_apb_subsystem)
	.pclk_wdt                 (pclk_wdt                 ), // (ae350_aopd) => (ae350_apb_subsystem)
	.spi_clk                  (spi_clk                  ), // (ae350_aopd) => (ae350_apb_subsystem)
	.te_clk                   (te_clk                   ), // (ae350_aopd) => (ncetrace200)
	.uart_clk                 (uart_clk                 ), // (ae350_aopd) => (ae350_apb_subsystem)
	.T_hw_rstn                (T_hw_rstn                ), // (ae350_aopd) <= (ae350_pin)
	.aresetn                  (aresetn                  ), // (ae350_aopd) => (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,ncetrace200)
	.core_resetn              (core_resetn              ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.dbg_srst_req             (dbg_srst_req             ), // (ae350_aopd) <= (ae350_cpu_subsystem)
	.hresetn                  (hresetn                  ), // (ae350_aopd) => (ae350_ahb_subsystem,ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,u_rom_ahbdec)
	.init_calib_complete      (init_calib_complete      ), // (ae350_aopd) <= (ae350_ram_subsystem)
	.por_rstn                 (por_rstn                 ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.presetn                  (presetn                  ), // (ae350_aopd) => (ae350_apb_subsystem)
	.spi_rstn                 (spi_rstn                 ), // (ae350_aopd) => (ae350_apb_subsystem)
	.uart_rstn                (uart_rstn                ), // (ae350_aopd) => (ae350_apb_subsystem)
	.ui_clk                   (ui_clk                   ), // (ae350_aopd) <= (ae350_ram_subsystem)
	.wdt_rst                  (wdt_rst                  ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.core_reset_vectors       (core_reset_vectors       ), // (ae350_aopd) => (ae350_cpu_subsystem)
	.pcs0_iso                 (pcs0_iso                 ), // (ae350_aopd) => ()
	.pcs1_iso                 (pcs1_iso                 ), // (ae350_aopd) => ()
	.pcs2_iso                 (pcs2_iso                 ), // (ae350_aopd) => ()
	.pcs3_iso                 (pcs3_iso                 ), // (ae350_aopd) => ()
	.pcs4_iso                 (pcs4_iso                 ), // (ae350_aopd) => ()
	.pcs5_iso                 (pcs5_iso                 ), // (ae350_aopd) => ()
	.pcs6_iso                 (pcs6_iso                 ), // (ae350_aopd) => ()
	.smu_prdata               (smu_prdata               ), // (ae350_aopd) => (ae350_apb_subsystem)
	.smu_pready               (smu_pready               ), // (ae350_aopd) => (ae350_apb_subsystem)
	.smu_psel                 (smu_psel                 ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.smu_pslverr              (smu_pslverr              ), // (ae350_aopd) => (ae350_apb_subsystem)
	.paddr                    (paddr                    ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.penable                  (penable                  ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.pwdata                   (pwdata                   ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.pwrite                   (pwrite                   ), // (ae350_aopd) <= (ae350_apb_subsystem)
	.pd0_vol_on               (pd0_vol_on               ), // (ae350_aopd) => ()
	.pd1_vol_on               (pd1_vol_on               ), // (ae350_aopd) => ()
	.pd2_vol_on               (pd2_vol_on               ), // (ae350_aopd) => ()
	.pd3_vol_on               (pd3_vol_on               ), // (ae350_aopd) => ()
	.pd4_vol_on               (pd4_vol_on               ), // (ae350_aopd) => ()
	.pd5_vol_on               (pd5_vol_on               ), // (ae350_aopd) => ()
	.pd6_vol_on               (pd6_vol_on               )  // (ae350_aopd) => ()
); // end of ae350_aopd

ae350_pin ae350_pin (
	.X_hw_rstn        (X_hw_rstn        ), // (ae350_pin) <=> (ae350_pin)
	.T_hw_rstn        (T_hw_rstn        ), // (ae350_pin) => (ae350_aopd)
	.X_por_b          (X_por_b          ), // (ae350_pin) <=> (ae350_pin)
	.T_por_b          (T_por_b          ), // (ae350_pin) => (ae350_aopd,ae350_ram_subsystem)
`ifdef PLATFORM_DEBUG_PORT
	.X_tms            (X_tms            ), // (ae350_pin) <=> (ae350_pin)
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
	.X_trst           (X_trst           ), // (ae350_pin) <=> (ae350_pin)
	.X_tdi            (X_tdi            ), // (ae350_pin) <=> (ae350_pin)
	.X_tdo            (X_tdo            ), // (ae350_pin) <=> (ae350_pin)
   `endif // PLATFORM_JTAG_TWOWIRE
	.pin_tms_in       (pin_tms_in       ), // (ae350_pin) => (ae350_aopd)
	.pin_tms_out      (pin_tms_out      ), // (ae350_pin) <= (ae350_aopd)
	.pin_tms_out_en   (pin_tms_out_en   ), // (ae350_pin) <= (ae350_aopd)
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
	.pin_trst_in      (pin_trst_in      ), // (ae350_pin) => (ae350_aopd)
	.pin_trst_out     (1'b0             ), // (ae350_pin) <= ()
	.pin_trst_out_en  (1'b0             ), // (ae350_pin) <= ()
	.pin_tdi_in       (pin_tdi_in       ), // (ae350_pin) => (ae350_aopd)
	.pin_tdi_out      (1'b0             ), // (ae350_pin) <= ()
	.pin_tdi_out_en   (1'b0             ), // (ae350_pin) <= ()
	.pin_tdo_in       (/* NC */         ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.pin_tdo_out      (pin_tdo_out      ), // (ae350_pin) <= (ae350_aopd)
	.pin_tdo_out_en   (pin_tdo_out_en   ), // (ae350_pin) <= (ae350_aopd)
   `endif // PLATFORM_JTAG_TWOWIRE
   `ifdef PLATFORM_JDTM_SECURE_SUPPORT
	.X_secure_mode    (X_secure_mode    ), // (ae350_pin) <=> (ae350_pin)
	.T_secure_mode    (T_secure_mode    ), // (ae350_pin) => ()
   `endif // PLATFORM_JDTM_SECURE_SUPPORT
`endif // PLATFORM_DEBUG_PORT
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi1_holdn     (X_spi1_holdn     ), // (ae350_pin) <=> (ae350_pin)
	.X_spi1_wpn       (X_spi1_wpn       ), // (ae350_pin) <=> (ae350_pin)
	.spi1_holdn_in    (spi1_holdn_in    ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi1_wpn_in      (spi1_wpn_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi1_holdn_out   (spi1_holdn_out   ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi1_holdn_oe    (spi1_holdn_oe    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi1_wpn_out     (spi1_wpn_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi1_wpn_oe      (spi1_wpn_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCSPI200_QUADSPI_SUPPORT
	.X_spi1_clk       (X_spi1_clk       ), // (ae350_pin) <=> (ae350_pin)
	.X_spi1_csn       (X_spi1_csn       ), // (ae350_pin) <=> (ae350_pin)
	.X_spi1_miso      (X_spi1_miso      ), // (ae350_pin) <=> (ae350_pin)
	.X_spi1_mosi      (X_spi1_mosi      ), // (ae350_pin) <=> (ae350_pin)
	.spi1_clk_in      (spi1_clk_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi1_csn_in      (spi1_csn_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi1_miso_in     (spi1_miso_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi1_mosi_in     (spi1_mosi_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi1_clk_out     (spi1_clk_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi1_clk_oe      (spi1_clk_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi1_csn_out     (spi1_csn_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi1_csn_oe      (spi1_csn_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi1_miso_out    (spi1_miso_out    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi1_miso_oe     (spi1_miso_oe     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi1_mosi_out    (spi1_mosi_out    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi1_mosi_oe     (spi1_mosi_oe     ), // (ae350_pin) <= (ae350_apb_subsystem)
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
	.X_spi2_clk       (X_spi2_clk       ), // (ae350_pin) <=> (ae350_pin)
	.X_spi2_csn       (X_spi2_csn       ), // (ae350_pin) <=> (ae350_pin)
	.X_spi2_miso      (X_spi2_miso      ), // (ae350_pin) <=> (ae350_pin)
	.X_spi2_mosi      (X_spi2_mosi      ), // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_CF1
	.spi2_clk_in      (spi2_clk_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi2_csn_in      (spi2_csn_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi2_miso_in     (spi2_miso_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi2_mosi_in     (spi2_mosi_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi2_clk_out     (spi2_clk_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi2_clk_oe      (spi2_clk_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi2_csn_out     (spi2_csn_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi2_csn_oe      (spi2_csn_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi2_miso_out    (spi2_miso_out    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi2_miso_oe     (spi2_miso_oe     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi2_mosi_out    (spi2_mosi_out    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi2_mosi_oe     (spi2_mosi_oe     ), // (ae350_pin) <= (ae350_apb_subsystem)
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi2_holdn     (X_spi2_holdn     ), // (ae350_pin) <=> (ae350_pin)
	.X_spi2_wpn       (X_spi2_wpn       ), // (ae350_pin) <=> (ae350_pin)
	.spi2_holdn_in    (spi2_holdn_in    ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi2_wpn_in      (spi2_wpn_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi2_holdn_out   (spi2_holdn_out   ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi2_holdn_oe    (spi2_holdn_oe    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi2_wpn_out     (spi2_wpn_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi2_wpn_oe      (spi2_wpn_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
	.X_spi3_clk       (X_spi3_clk       ), // (ae350_pin) <=> (ae350_pin)
	.X_spi3_csn       (X_spi3_csn       ), // (ae350_pin) <=> (ae350_pin)
	.X_spi3_miso      (X_spi3_miso      ), // (ae350_pin) <=> (ae350_pin)
	.X_spi3_mosi      (X_spi3_mosi      ), // (ae350_pin) <=> (ae350_pin)
	.spi3_clk_in      (spi3_clk_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi3_csn_in      (spi3_csn_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi3_miso_in     (spi3_miso_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi3_mosi_in     (spi3_mosi_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi3_clk_out     (spi3_clk_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi3_clk_oe      (spi3_clk_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi3_csn_out     (spi3_csn_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi3_csn_oe      (spi3_csn_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi3_miso_out    (spi3_miso_out    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi3_miso_oe     (spi3_miso_oe     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi3_mosi_out    (spi3_mosi_out    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi3_mosi_oe     (spi3_mosi_oe     ), // (ae350_pin) <= (ae350_apb_subsystem)
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi3_holdn     (X_spi3_holdn     ), // (ae350_pin) <=> (ae350_pin)
	.X_spi3_wpn       (X_spi3_wpn       ), // (ae350_pin) <=> (ae350_pin)
	.spi3_holdn_in    (spi3_holdn_in    ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi3_wpn_in      (spi3_wpn_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi3_holdn_out   (spi3_holdn_out   ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi3_holdn_oe    (spi3_holdn_oe    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi3_wpn_out     (spi3_wpn_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi3_wpn_oe      (spi3_wpn_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
	.X_spi4_clk       (X_spi4_clk       ), // (ae350_pin) <=> (ae350_pin)
	.X_spi4_csn       (X_spi4_csn       ), // (ae350_pin) <=> (ae350_pin)
	.X_spi4_miso      (X_spi4_miso      ), // (ae350_pin) <=> (ae350_pin)
	.X_spi4_mosi      (X_spi4_mosi      ), // (ae350_pin) <=> (ae350_pin)
	.spi4_clk_in      (spi4_clk_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi4_csn_in      (spi4_csn_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi4_miso_in     (spi4_miso_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi4_mosi_in     (spi4_mosi_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi4_clk_out     (spi4_clk_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi4_clk_oe      (spi4_clk_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi4_csn_out     (spi4_csn_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi4_csn_oe      (spi4_csn_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi4_miso_out    (spi4_miso_out    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi4_miso_oe     (spi4_miso_oe     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi4_mosi_out    (spi4_mosi_out    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi4_mosi_oe     (spi4_mosi_oe     ), // (ae350_pin) <= (ae350_apb_subsystem)
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi4_holdn     (X_spi4_holdn     ), // (ae350_pin) <=> (ae350_pin)
	.X_spi4_wpn       (X_spi4_wpn       ), // (ae350_pin) <=> (ae350_pin)
	.spi4_holdn_in    (spi4_holdn_in    ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi4_wpn_in      (spi4_wpn_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.spi4_holdn_out   (spi4_holdn_out   ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi4_holdn_oe    (spi4_holdn_oe    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi4_wpn_out     (spi4_wpn_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.spi4_wpn_oe      (spi4_wpn_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI4_SUPPORT
`ifdef AE350_I2C_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
	.X_i2c_scl        (X_i2c_scl        ), // (ae350_pin) <=> (ae350_pin)
	.X_i2c_sda        (X_i2c_sda        ), // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_CF1
	.i2c_scl_in       (i2c_scl_in       ), // (ae350_pin) => (ae350_apb_subsystem)
	.i2c_sda_in       (i2c_sda_in       ), // (ae350_pin) => (ae350_apb_subsystem)
	.i2c_scl          (i2c_scl          ), // (ae350_pin) <= (ae350_apb_subsystem)
	.i2c_sda          (i2c_sda          ), // (ae350_pin) <= (ae350_apb_subsystem)
`endif // AE350_I2C_SUPPORT
`ifdef AE350_I2C2_SUPPORT
	.i2c2_scl_in      (i2c2_scl_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.i2c2_sda_in      (i2c2_sda_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.i2c2_scl         (i2c2_scl         ), // (ae350_pin) <= (ae350_apb_subsystem)
	.i2c2_sda         (i2c2_sda         ), // (ae350_pin) <= (ae350_apb_subsystem)
`endif // AE350_I2C2_SUPPORT
`ifdef AE350_SSP_SUPPORT
	.X_ssp_rxd        (X_ssp_rxd        ), // (ae350_pin) <=> (ae350_pin)
	.X_ssp_txd        (X_ssp_txd        ), // (ae350_pin) <=> (ae350_pin)
	.X_ssp_sclk       (X_ssp_sclk       ), // (ae350_pin) <=> (ae350_pin)
	.X_ssp_fs         (X_ssp_fs         ), // (ae350_pin) <=> (ae350_pin)
	.X_ssp_ac97_resetn(X_ssp_ac97_resetn), // (ae350_pin) <=> (ae350_pin)
	.T_ssp_rxd        (T_ssp_rxd        ), // (ae350_pin) => (ae350_apb_subsystem)
	.ssp_txd          (ssp_txd          ), // (ae350_pin) <= (ae350_apb_subsystem)
	.T_ssp_sclk_in    (T_ssp_sclk_in    ), // (ae350_pin) => (ae350_apb_subsystem)
	.T_ssp_fs_in      (T_ssp_fs_in      ), // (ae350_pin) => (ae350_apb_subsystem)
	.ssp_ac97_resetn  (ssp_ac97_resetn  ), // (ae350_pin) <= (ae350_apb_subsystem)
	.ssp_sclk_out     (ssp_sclk_out     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.ssp_fs_out       (ssp_fs_out       ), // (ae350_pin) <= (ae350_apb_subsystem)
	.ssp_txd_oe       (ssp_txd_oe       ), // (ae350_pin) <= (ae350_apb_subsystem)
	.ssp_sclk_oe      (ssp_sclk_oe      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.ssp_fs_oe        (ssp_fs_oe        ), // (ae350_pin) <= (ae350_apb_subsystem)
`endif // AE350_SSP_SUPPORT
`ifdef AE350_UART1_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
	.X_uart1_txd      (X_uart1_txd      ), // (ae350_pin) <=> (ae350_pin)
	.X_uart1_rxd      (X_uart1_rxd      ), // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_CF1
   `ifdef NDS_FPGA
   `else
	.X_uart1_dsrn     (X_uart1_dsrn     ), // (ae350_pin) <=> (ae350_pin)
	.X_uart1_dcdn     (X_uart1_dcdn     ), // (ae350_pin) <=> (ae350_pin)
	.X_uart1_rin      (X_uart1_rin      ), // (ae350_pin) <=> (ae350_pin)
	.X_uart1_dtrn     (X_uart1_dtrn     ), // (ae350_pin) <=> (ae350_pin)
	.X_uart1_out1n    (X_uart1_out1n    ), // (ae350_pin) <=> (ae350_pin)
	.X_uart1_out2n    (X_uart1_out2n    ), // (ae350_pin) <=> (ae350_pin)
      `ifdef AE350_UART2_SUPPORT
	.X_uart1_ctsn     (X_uart1_ctsn     ), // (ae350_pin) <=> (ae350_pin)
	.X_uart1_rtsn     (X_uart1_rtsn     ), // (ae350_pin) <=> (ae350_pin)
      `endif // AE350_UART2_SUPPORT
   `endif // NDS_FPGA
   `ifdef AE350_UART2_SUPPORT
   `else
	.X_uart1_ctsn     (X_uart1_ctsn     ), // (ae350_pin) <=> (ae350_pin)
	.X_uart1_rtsn     (X_uart1_rtsn     ), // (ae350_pin) <=> (ae350_pin)
   `endif // AE350_UART2_SUPPORT
`endif // AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
	.X_uart2_txd      (X_uart2_txd      ), // (ae350_pin) <=> (ae350_pin)
	.X_uart2_rxd      (X_uart2_rxd      ), // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_CF1
   `ifdef NDS_FPGA
   `else
	.X_uart2_ctsn     (X_uart2_ctsn     ), // (ae350_pin) <=> (ae350_pin)
	.X_uart2_rtsn     (X_uart2_rtsn     ), // (ae350_pin) <=> (ae350_pin)
	.X_uart2_dcdn     (X_uart2_dcdn     ), // (ae350_pin) <=> (ae350_pin)
	.X_uart2_dsrn     (X_uart2_dsrn     ), // (ae350_pin) <=> (ae350_pin)
	.X_uart2_rin      (X_uart2_rin      ), // (ae350_pin) <=> (ae350_pin)
	.X_uart2_dtrn     (X_uart2_dtrn     ), // (ae350_pin) <=> (ae350_pin)
	.X_uart2_out1n    (X_uart2_out1n    ), // (ae350_pin) <=> (ae350_pin)
	.X_uart2_out2n    (X_uart2_out2n    ), // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_FPGA
`endif // AE350_UART2_SUPPORT
`ifdef AE350_UART1_SUPPORT
	.uart1_txd        (uart1_txd        ), // (ae350_pin) <= (ae350_apb_subsystem)
	.uart1_rtsn       (uart1_rtsn       ), // (ae350_pin) <= (ae350_apb_subsystem)
	.uart1_rxd        (uart1_rxd        ), // (ae350_pin) => (ae350_apb_subsystem)
	.uart1_ctsn       (uart1_ctsn       ), // (ae350_pin) => (ae350_apb_subsystem)
	.uart1_dsrn       (uart1_dsrn       ), // (ae350_pin) => (ae350_apb_subsystem)
	.uart1_dcdn       (uart1_dcdn       ), // (ae350_pin) => (ae350_apb_subsystem)
	.uart1_rin        (uart1_rin        ), // (ae350_pin) => (ae350_apb_subsystem)
	.uart1_dtrn       (uart1_dtrn       ), // (ae350_pin) <= (ae350_apb_subsystem)
	.uart1_out1n      (uart1_out1n      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.uart1_out2n      (uart1_out2n      ), // (ae350_pin) <= (ae350_apb_subsystem)
`endif // AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
	.uart2_txd        (uart2_txd        ), // (ae350_pin) <= (ae350_apb_subsystem)
	.uart2_rtsn       (uart2_rtsn       ), // (ae350_pin) <= (ae350_apb_subsystem)
	.uart2_rxd        (uart2_rxd        ), // (ae350_pin) => (ae350_apb_subsystem)
	.uart2_ctsn       (uart2_ctsn       ), // (ae350_pin) => (ae350_apb_subsystem)
	.uart2_dcdn       (uart2_dcdn       ), // (ae350_pin) => (ae350_apb_subsystem)
	.uart2_dsrn       (uart2_dsrn       ), // (ae350_pin) => (ae350_apb_subsystem)
	.uart2_rin        (uart2_rin        ), // (ae350_pin) => (ae350_apb_subsystem)
	.uart2_dtrn       (uart2_dtrn       ), // (ae350_pin) <= (ae350_apb_subsystem)
	.uart2_out1n      (uart2_out1n      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.uart2_out2n      (uart2_out2n      ), // (ae350_pin) <= (ae350_apb_subsystem)
`endif // AE350_UART2_SUPPORT
`ifdef AE350_PIT_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
	.X_pwm_ch0        (X_pwm_ch0        ), // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_CF1
	.ch0_pwm          (ch0_pwm          ), // (ae350_pin) <= (ae350_apb_subsystem)
	.ch0_pwmoe        (ch0_pwmoe        ), // (ae350_pin) <= (ae350_apb_subsystem)
   `ifdef ATCPIT100_CH1_SUPPORT
      `ifdef NDS_BOARD_CF1
      `else
	.X_pwm_ch1        (X_pwm_ch1        ), // (ae350_pin) <=> (ae350_pin)
      `endif // NDS_BOARD_CF1
	.ch1_pwm          (ch1_pwm          ), // (ae350_pin) <= (ae350_apb_subsystem)
	.ch1_pwmoe        (ch1_pwmoe        ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
      `ifdef NDS_BOARD_CF1
      `else
	.X_pwm_ch2        (X_pwm_ch2        ), // (ae350_pin) <=> (ae350_pin)
      `endif // NDS_BOARD_CF1
	.ch2_pwm          (ch2_pwm          ), // (ae350_pin) <= (ae350_apb_subsystem)
	.ch2_pwmoe        (ch2_pwmoe        ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
      `ifdef NDS_BOARD_CF1
      `else
	.X_pwm_ch3        (X_pwm_ch3        ), // (ae350_pin) <=> (ae350_pin)
      `endif // NDS_BOARD_CF1
	.ch3_pwm          (ch3_pwm          ), // (ae350_pin) <= (ae350_apb_subsystem)
	.ch3_pwmoe        (ch3_pwmoe        ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT_SUPPORT
`ifdef AE350_PIT2_SUPPORT
	.pit2_ch0_pwm     (pit2_ch0_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit2_ch0_pwmoe   (pit2_ch0_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit2_ch1_pwm     (pit2_ch1_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit2_ch1_pwmoe   (pit2_ch1_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit2_ch2_pwm     (pit2_ch2_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit2_ch2_pwmoe   (pit2_ch2_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit2_ch3_pwm     (pit2_ch3_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit2_ch3_pwmoe   (pit2_ch3_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
	.pit3_ch0_pwm     (pit3_ch0_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit3_ch0_pwmoe   (pit3_ch0_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit3_ch1_pwm     (pit3_ch1_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit3_ch1_pwmoe   (pit3_ch1_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit3_ch2_pwm     (pit3_ch2_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit3_ch2_pwmoe   (pit3_ch2_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit3_ch3_pwm     (pit3_ch3_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit3_ch3_pwmoe   (pit3_ch3_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
	.pit4_ch0_pwm     (pit4_ch0_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit4_ch0_pwmoe   (pit4_ch0_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit4_ch1_pwm     (pit4_ch1_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit4_ch1_pwmoe   (pit4_ch1_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit4_ch2_pwm     (pit4_ch2_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit4_ch2_pwmoe   (pit4_ch2_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit4_ch3_pwm     (pit4_ch3_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit4_ch3_pwmoe   (pit4_ch3_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
	.pit5_ch0_pwm     (pit5_ch0_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit5_ch0_pwmoe   (pit5_ch0_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit5_ch1_pwm     (pit5_ch1_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit5_ch1_pwmoe   (pit5_ch1_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit5_ch2_pwm     (pit5_ch2_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit5_ch2_pwmoe   (pit5_ch2_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit5_ch3_pwm     (pit5_ch3_pwm     ), // (ae350_pin) <= (ae350_apb_subsystem)
	.pit5_ch3_pwmoe   (pit5_ch3_pwmoe   ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT5_SUPPORT
`ifdef NDS_FPGA
   `ifdef NDS_BOARD_ORCA
	.X_flash_dir      (X_flash_dir      ), // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_BOARD_ORCA
`endif // NDS_FPGA
`ifdef AE350_SDC_SUPPORT
	.X_sd_cd          (X_sd_cd          ), // (ae350_pin) <=> (ae350_pin)
	.X_sd_wp          (X_sd_wp          ), // (ae350_pin) <=> (ae350_pin)
	.X_sd_clk         (X_sd_clk         ), // (ae350_pin) <=> (ae350_pin)
	.X_sd_cmd_rsp     (X_sd_cmd_rsp     ), // (ae350_pin) <=> (ae350_pin)
	.X_sd_dat0        (X_sd_dat0        ), // (ae350_pin) <=> (ae350_pin)
	.X_sd_dat1        (X_sd_dat1        ), // (ae350_pin) <=> (ae350_pin)
	.X_sd_dat2        (X_sd_dat2        ), // (ae350_pin) <=> (ae350_pin)
	.X_sd_dat3        (X_sd_dat3        ), // (ae350_pin) <=> (ae350_pin)
	.X_sd_power_on    (X_sd_power_on    ), // (ae350_pin) <=> (ae350_pin)
	.T_sd_cd          (T_sd_cd          ), // (ae350_pin) => (ae350_apb_subsystem)
	.T_sd_wp          (T_sd_wp          ), // (ae350_pin) => (ae350_apb_subsystem)
	.sd_clk           (sd_clk           ), // (ae350_pin) <= (ae350_apb_subsystem)
	.T_sd_rsp         (T_sd_rsp         ), // (ae350_pin) => (ae350_apb_subsystem)
	.sd_cmd           (sd_cmd           ), // (ae350_pin) <= (ae350_apb_subsystem)
	.sd_cmd_oe        (sd_cmd_oe        ), // (ae350_pin) <= (ae350_apb_subsystem)
	.T_sd_dat3_in     (T_sd_dat3_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.T_sd_dat2_in     (T_sd_dat2_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.T_sd_dat1_in     (T_sd_dat1_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.T_sd_dat0_in     (T_sd_dat0_in     ), // (ae350_pin) => (ae350_apb_subsystem)
	.sd_dat3_out      (sd_dat3_out      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.sd_dat2_out      (sd_dat2_out      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.sd_dat1_out      (sd_dat1_out      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.sd_dat0_out      (sd_dat0_out      ), // (ae350_pin) <= (ae350_apb_subsystem)
	.sd_dat3_oe       (sd_dat3_oe       ), // (ae350_pin) <= (ae350_apb_subsystem)
	.sd_dat2_oe       (sd_dat2_oe       ), // (ae350_pin) <= (ae350_apb_subsystem)
	.sd_dat1_oe       (sd_dat1_oe       ), // (ae350_pin) <= (ae350_apb_subsystem)
	.sd_dat0_oe       (sd_dat0_oe       ), // (ae350_pin) <= (ae350_apb_subsystem)
	.sd_power         (sd_power         ), // (ae350_pin) <= (ae350_apb_subsystem)
`endif // AE350_SDC_SUPPORT
`ifdef AE350_SMC_SUPPORT
   `ifdef NDS_FPGA
	.X_memdata        (X_memdata        ), // (ae350_pin) <=> (ae350_pin)
   `else
	.X_memdata        (X_memdata        ), // (ae350_pin) <=> (ae350_pin)
   `endif // NDS_FPGA
	.X_memaddr        (X_memaddr        ), // (ae350_pin) <=> (ae350_pin)
	.X_smc_we_b       (X_smc_we_b       ), // (ae350_pin) <=> (ae350_pin)
	.X_smc_cs_b       (X_smc_cs_b       ), // (ae350_pin) <=> (ae350_pin)
	.X_smc_oe_b       (X_smc_oe_b       ), // (ae350_pin) <=> (ae350_pin)
	.smc_we_n         (smc_we_n         ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.smc_cs_n_0       (smc_cs_n_0       ), // (ae350_pin) <= ()
	.smc_oe_n         (smc_oe_n         ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.T_memdata        (T_memdata        ), // (ae350_pin) => (ae350_ahb_subsystem)
	.smc_dqout        (smc_dqout        ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.smc_data_oe      (smc_data_oe      ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.smc_addr         (smc_addr         ), // (ae350_pin) <= (ae350_ahb_subsystem)
`endif // AE350_SMC_SUPPORT
`ifdef AE350_MAC_SUPPORT
	.X_tx_clk         (X_tx_clk         ), // (ae350_pin) <=> (ae350_pin)
	.X_tx_en          (X_tx_en          ), // (ae350_pin) <=> (ae350_pin)
	.X_txd            (X_txd            ), // (ae350_pin) <=> (ae350_pin)
	.X_rx_clk         (X_rx_clk         ), // (ae350_pin) <=> (ae350_pin)
	.X_rx_dv          (X_rx_dv          ), // (ae350_pin) <=> (ae350_pin)
	.X_rx_er          (X_rx_er          ), // (ae350_pin) <=> (ae350_pin)
	.X_rxd            (X_rxd            ), // (ae350_pin) <=> (ae350_pin)
	.X_crs            (X_crs            ), // (ae350_pin) <=> (ae350_pin)
	.X_col            (X_col            ), // (ae350_pin) <=> (ae350_pin)
	.X_mdc            (X_mdc            ), // (ae350_pin) <=> (ae350_pin)
	.X_mdio           (X_mdio           ), // (ae350_pin) <=> (ae350_pin)
	.X_phy_linksts    (X_phy_linksts    ), // (ae350_pin) <=> (ae350_pin)
	.X_pdn_phy        (X_pdn_phy        ), // (ae350_pin) <=> (ae350_pin)
	.T_tx_clk         (T_tx_clk         ), // (ae350_pin) => (ae350_ahb_subsystem)
	.tx_en            (tx_en            ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.txd              (txd              ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.T_rx_clk         (T_rx_clk         ), // (ae350_pin) => (ae350_ahb_subsystem)
	.T_rx_dv          (T_rx_dv          ), // (ae350_pin) => (ae350_ahb_subsystem)
	.T_rx_er          (T_rx_er          ), // (ae350_pin) => (ae350_ahb_subsystem)
	.T_rxd            (T_rxd            ), // (ae350_pin) => (ae350_ahb_subsystem)
	.T_crs            (T_crs            ), // (ae350_pin) => (ae350_ahb_subsystem)
	.T_col            (T_col            ), // (ae350_pin) => (ae350_ahb_subsystem)
	.mdc              (mdc              ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.T_mdio           (T_mdio           ), // (ae350_pin) => (ae350_ahb_subsystem)
	.mdio_out         (mdio_out         ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.mdio_out_en      (mdio_out_en      ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.T_phy_linksts    (T_phy_linksts    ), // (ae350_pin) => (ae350_ahb_subsystem)
	.pdn_phy          (pdn_phy          ), // (ae350_pin) <= (ae350_ahb_subsystem)
`endif // AE350_MAC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
	.X_clpower        (X_clpower        ), // (ae350_pin) <=> (ae350_pin)
	.X_cllp           (X_cllp           ), // (ae350_pin) <=> (ae350_pin)
	.X_clcp           (X_clcp           ), // (ae350_pin) <=> (ae350_pin)
	.X_clfp           (X_clfp           ), // (ae350_pin) <=> (ae350_pin)
	.X_clac           (X_clac           ), // (ae350_pin) <=> (ae350_pin)
	.X_cld            (X_cld            ), // (ae350_pin) <=> (ae350_pin)
	.X_clle           (X_clle           ), // (ae350_pin) <=> (ae350_pin)
	.clpower          (clpower          ), // (ae350_pin) <= ()
	.cllp             (cllp             ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.clcp             (clcp             ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.clfp             (clfp             ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.clac             (clac             ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.cld              (cld              ), // (ae350_pin) <= (ae350_ahb_subsystem)
	.clle             (clle             ), // (ae350_pin) <= (ae350_ahb_subsystem)
`endif // AE350_LCDC_SUPPORT
`ifdef NDS_BOARD_CF1
	.cf1_pinmux_ctrl0 (cf1_pinmux_ctrl0 ), // (ae350_pin) <= (ae350_aopd)
	.cf1_pinmux_ctrl1 (cf1_pinmux_ctrl1 ), // (ae350_pin) <= (ae350_aopd)
   `ifdef AE350_GPIO_SUPPORT
	.X_gpio           (X_gpio           ), // (ae350_pin) <=> (ae350_pin)
   `endif // AE350_GPIO_SUPPORT
`else
   `ifdef AE350_GPIO_SUPPORT
	.X_gpio           (X_gpio           ), // (ae350_pin) <=> (ae350_pin)
   `endif // AE350_GPIO_SUPPORT
`endif // NDS_BOARD_CF1
`ifdef AE350_GPIO_SUPPORT
	.gpio_in          (gpio_in          ), // (ae350_pin) => (ae350_apb_subsystem)
	.gpio_oe          (gpio_oe          ), // (ae350_pin) <= (ae350_apb_subsystem)
	.gpio_out         (gpio_out         ), // (ae350_pin) <= (ae350_apb_subsystem)
   `ifdef ATCGPIO100_PULL_SUPPORT
	.gpio_pulldown    (gpio_pulldown    ), // (ae350_pin) <= (ae350_apb_subsystem)
	.gpio_pullup      (gpio_pullup      ), // (ae350_pin) <= (ae350_apb_subsystem)
   `endif // ATCGPIO100_PULL_SUPPORT
`endif // AE350_GPIO_SUPPORT
`ifdef NDS_FPGA
`else
	.X_oschio         (X_oschio         ), // (ae350_pin) <=> (ae350_pin)
`endif // NDS_FPGA
	.X_oschin         (X_oschin         ), // (ae350_pin) <= ()
	.T_osch           (T_osch           )  // (ae350_pin) => (ae350_aopd)
); // end of ae350_pin

`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef NDS_IO_TRACE_INSTR
ncetrace200_ahb_top #(
	.HART0_NUM_INST_BLK(HART0_NUM_INST_BLK),
	.HART0_TRACE_PRIV_WIDTH(HART0_TRACE_PRIV_WIDTH),
	.HART0_TRACE_TRIGGER_WIDTH(HART0_TRACE_TRIGGER_WIDTH),
	.HART0_VALEN     (HART0_VALEN     ),
	.HART1_NUM_INST_BLK(HART1_NUM_INST_BLK),
	.HART1_TRACE_PRIV_WIDTH(HART1_TRACE_PRIV_WIDTH),
	.HART1_TRACE_TRIGGER_WIDTH(HART1_TRACE_TRIGGER_WIDTH),
	.HART1_VALEN     (HART1_VALEN     ),
	.HART2_NUM_INST_BLK(HART2_NUM_INST_BLK),
	.HART2_TRACE_PRIV_WIDTH(HART2_TRACE_PRIV_WIDTH),
	.HART2_TRACE_TRIGGER_WIDTH(HART2_TRACE_TRIGGER_WIDTH),
	.HART2_VALEN     (HART2_VALEN     ),
	.HART3_NUM_INST_BLK(HART3_NUM_INST_BLK),
	.HART3_TRACE_PRIV_WIDTH(HART3_TRACE_PRIV_WIDTH),
	.HART3_TRACE_TRIGGER_WIDTH(HART3_TRACE_TRIGGER_WIDTH),
	.HART3_VALEN     (HART3_VALEN     ),
	.HART4_NUM_INST_BLK(HART4_NUM_INST_BLK),
	.HART4_TRACE_PRIV_WIDTH(HART4_TRACE_PRIV_WIDTH),
	.HART4_TRACE_TRIGGER_WIDTH(HART4_TRACE_TRIGGER_WIDTH),
	.HART4_VALEN     (HART4_VALEN     ),
	.HART5_NUM_INST_BLK(HART5_NUM_INST_BLK),
	.HART5_TRACE_PRIV_WIDTH(HART5_TRACE_PRIV_WIDTH),
	.HART5_TRACE_TRIGGER_WIDTH(HART5_TRACE_TRIGGER_WIDTH),
	.HART5_VALEN     (HART5_VALEN     ),
	.HART6_NUM_INST_BLK(HART6_NUM_INST_BLK),
	.HART6_TRACE_PRIV_WIDTH(HART6_TRACE_PRIV_WIDTH),
	.HART6_TRACE_TRIGGER_WIDTH(HART6_TRACE_TRIGGER_WIDTH),
	.HART6_VALEN     (HART6_VALEN     ),
	.HART7_NUM_INST_BLK(HART7_NUM_INST_BLK),
	.HART7_TRACE_PRIV_WIDTH(HART7_TRACE_PRIV_WIDTH),
	.HART7_TRACE_TRIGGER_WIDTH(HART7_TRACE_TRIGGER_WIDTH),
	.HART7_VALEN     (HART7_VALEN     ),
	.HARTID0         (NCETRACE200_HARTID0),
	.NSOURCE         (NHART           ),
	.SYNC_STAGE      (SYNC_STAGE      ),
	.TBUF_SMEM_ADDR_WIDTH(BIU_ADDR_WIDTH  ),
	.TBUF_SMEM_DATA_WIDTH(CPUSUB_BIU_DATA_WIDTH),
	.TBUF_SMEM_ID_WIDTH(CPUSUB_BIU_ID_WIDTH),
	.TBUF_SMEM_NWRITE(TBUF_SMEM_NWRITE),
	.TBUF_SMEM_SUPPORT(TBUF_SMEM_SUPPORT),
	.TB_RAM_CTRL_IN_WIDTH(TB_RAM_CTRL_IN_WIDTH),
	.TB_RAM_CTRL_OUT_WIDTH(TB_RAM_CTRL_OUT_WIDTH),
	.TB_RAM_SIZE     (TB_RAM_SIZE     ),
	.USFIFO_SIZE     (TRACE_USFIFO_SIZE),
	.USFIFO_STALL_THRESHOLD(TRACE_USFIFO_STALL_THRESHOLD)
) ncetrace200 (
      `ifdef NDS_NHART
         `ifdef NDS_IO_HART1
	.hart1_power_down     (hart1_power_down      ), // (ncetrace200) <= ()
	.hart1_te_clk         (te_clk[1]             ), // (ncetrace200) <= (ae350_aopd)
	.hart1_te_reset_n     (te_reset_n[1]         ), // (ncetrace200) <= (ae350_aopd)
	.hart1_trace_cause    (hart1_trace_cause     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart1_trace_context  (hart1_trace_context   ), // (ncetrace200) <= ()
	.hart1_trace_ctype    (hart1_trace_ctype     ), // (ncetrace200) <= ()
	.hart1_trace_enabled  (hart1_trace_enabled   ), // (ncetrace200) => (ae350_cpu_subsystem)
	.hart1_trace_halted   (hart1_trace_halted    ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart1_trace_iaddr    (hart1_trace_iaddr     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart1_trace_ilastsize(hart1_trace_ilastsize ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart1_trace_iretire  (hart1_trace_iretire   ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart1_trace_itype    (hart1_trace_itype     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart1_trace_priv     (hart1_trace_priv      ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart1_trace_reset    (hart1_trace_reset     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart1_trace_secure   (hart1_trace_secure    ), // (ncetrace200) <= ()
	.hart1_trace_stall    (hart1_trace_stall     ), // (ncetrace200) => ()
	.hart1_trace_trigger  (hart1_trace_trigger   ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart1_trace_tval     (hart1_trace_tval      ), // (ncetrace200) <= (ae350_cpu_subsystem)
         `endif // NDS_IO_HART1
         `ifdef NDS_IO_HART2
	.hart2_power_down     (hart2_power_down      ), // (ncetrace200) <= ()
	.hart2_te_clk         (te_clk[2]             ), // (ncetrace200) <= (ae350_aopd)
	.hart2_te_reset_n     (te_reset_n[2]         ), // (ncetrace200) <= (ae350_aopd)
	.hart2_trace_cause    (hart2_trace_cause     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart2_trace_context  (hart2_trace_context   ), // (ncetrace200) <= ()
	.hart2_trace_ctype    (hart2_trace_ctype     ), // (ncetrace200) <= ()
	.hart2_trace_enabled  (hart2_trace_enabled   ), // (ncetrace200) => (ae350_cpu_subsystem)
	.hart2_trace_halted   (hart2_trace_halted    ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart2_trace_iaddr    (hart2_trace_iaddr     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart2_trace_ilastsize(hart2_trace_ilastsize ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart2_trace_iretire  (hart2_trace_iretire   ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart2_trace_itype    (hart2_trace_itype     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart2_trace_priv     (hart2_trace_priv      ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart2_trace_reset    (hart2_trace_reset     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart2_trace_secure   (hart2_trace_secure    ), // (ncetrace200) <= ()
	.hart2_trace_stall    (hart2_trace_stall     ), // (ncetrace200) => ()
	.hart2_trace_trigger  (hart2_trace_trigger   ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart2_trace_tval     (hart2_trace_tval      ), // (ncetrace200) <= (ae350_cpu_subsystem)
         `endif // NDS_IO_HART2
         `ifdef NDS_IO_HART3
	.hart3_power_down     (hart3_power_down      ), // (ncetrace200) <= ()
	.hart3_te_clk         (te_clk[3]             ), // (ncetrace200) <= (ae350_aopd)
	.hart3_te_reset_n     (te_reset_n[3]         ), // (ncetrace200) <= (ae350_aopd)
	.hart3_trace_cause    (hart3_trace_cause     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart3_trace_context  (hart3_trace_context   ), // (ncetrace200) <= ()
	.hart3_trace_ctype    (hart3_trace_ctype     ), // (ncetrace200) <= ()
	.hart3_trace_enabled  (hart3_trace_enabled   ), // (ncetrace200) => (ae350_cpu_subsystem)
	.hart3_trace_halted   (hart3_trace_halted    ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart3_trace_iaddr    (hart3_trace_iaddr     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart3_trace_ilastsize(hart3_trace_ilastsize ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart3_trace_iretire  (hart3_trace_iretire   ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart3_trace_itype    (hart3_trace_itype     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart3_trace_priv     (hart3_trace_priv      ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart3_trace_reset    (hart3_trace_reset     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart3_trace_secure   (hart3_trace_secure    ), // (ncetrace200) <= ()
	.hart3_trace_stall    (hart3_trace_stall     ), // (ncetrace200) => ()
	.hart3_trace_trigger  (hart3_trace_trigger   ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart3_trace_tval     (hart3_trace_tval      ), // (ncetrace200) <= (ae350_cpu_subsystem)
         `endif // NDS_IO_HART3
         `ifdef NDS_IO_HART4
	.hart4_power_down     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_te_clk         (1'b0                  ), // (ncetrace200) <= ()
	.hart4_te_reset_n     (1'b0                  ), // (ncetrace200) <= ()
	.hart4_trace_cause    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_trace_context  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_trace_ctype    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_trace_enabled  (/* NC */              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart4_trace_halted   (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_trace_iaddr    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_trace_ilastsize(/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_trace_iretire  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_trace_itype    (4'd0                  ), // (ncetrace200) <= ()
	.hart4_trace_priv     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_trace_reset    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_trace_secure   (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_trace_stall    (/* NC */              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart4_trace_trigger  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart4_trace_tval     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
         `endif // NDS_IO_HART4
         `ifdef NDS_IO_HART5
	.hart5_power_down     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_te_clk         (1'b0                  ), // (ncetrace200) <= ()
	.hart5_te_reset_n     (1'b0                  ), // (ncetrace200) <= ()
	.hart5_trace_cause    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_trace_context  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_trace_ctype    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_trace_enabled  (/* NC */              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart5_trace_halted   (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_trace_iaddr    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_trace_ilastsize(/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_trace_iretire  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_trace_itype    (4'd0                  ), // (ncetrace200) <= ()
	.hart5_trace_priv     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_trace_reset    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_trace_secure   (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_trace_stall    (/* NC */              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart5_trace_trigger  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart5_trace_tval     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
         `endif // NDS_IO_HART5
         `ifdef NDS_IO_HART6
	.hart6_power_down     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_te_clk         (1'b0                  ), // (ncetrace200) <= ()
	.hart6_te_reset_n     (1'b0                  ), // (ncetrace200) <= ()
	.hart6_trace_cause    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_trace_context  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_trace_ctype    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_trace_enabled  (/* NC */              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart6_trace_halted   (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_trace_iaddr    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_trace_ilastsize(/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_trace_iretire  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_trace_itype    (4'd0                  ), // (ncetrace200) <= ()
	.hart6_trace_priv     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_trace_reset    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_trace_secure   (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_trace_stall    (/* NC */              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart6_trace_trigger  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart6_trace_tval     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
         `endif // NDS_IO_HART6
         `ifdef NDS_IO_HART7
	.hart7_power_down     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_te_clk         (1'b0                  ), // (ncetrace200) <= ()
	.hart7_te_reset_n     (1'b0                  ), // (ncetrace200) <= ()
	.hart7_trace_cause    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_trace_context  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_trace_ctype    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_trace_enabled  (/* NC */              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart7_trace_halted   (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_trace_iaddr    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_trace_ilastsize(/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_trace_iretire  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_trace_itype    (4'd0                  ), // (ncetrace200) <= ()
	.hart7_trace_priv     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_trace_reset    (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_trace_secure   (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_trace_stall    (/* NC */              ), // (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec) => (ncetrace200)
	.hart7_trace_trigger  (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
	.hart7_trace_tval     (/* NC */              ), // (ncetrace200) <= (ae350_cpu_subsystem,ae350_pin,ncetrace200,u_rom_ahbdec)
         `endif // NDS_IO_HART7
      `endif // NDS_NHART
	.atresetn             (dmi_resetn            ), // (ncetrace200) <= (ae350_aopd)
	.auth_dbgen           (1'b1                  ), // (ncetrace200) <= ()
	.auth_hiden           (1'b1                  ), // (ncetrace200) <= ()
	.auth_hniden          (1'b1                  ), // (ncetrace200) <= ()
	.auth_niden           (1'b1                  ), // (ncetrace200) <= ()
	.auth_spiden          (1'b1                  ), // (ncetrace200) <= ()
	.auth_spniden         (1'b1                  ), // (ncetrace200) <= ()
	.dmi_clk              (dmi_clk               ), // (ncetrace200) <= ()
	.dmi_haddr            (dmi_haddr             ), // (ncetrace200) <= (ae350_aopd)
	.dmi_hburst           (dmi_hburst            ), // (ncetrace200) <= (ae350_aopd)
	.dmi_hmastlock        (1'b0                  ), // (ncetrace200) <= ()
	.dmi_hprot            (dmi_hprot             ), // (ncetrace200) <= (ae350_aopd)
	.dmi_hrdata           (dmi_hrdata            ), // (ncetrace200) => (ae350_aopd)
	.dmi_hready           (dmi_hready            ), // (ncetrace200) => (ae350_aopd)
	.dmi_hresp            (dmi_hresp             ), // (ncetrace200) => (ae350_aopd)
	.dmi_hsel             (dmi_hsel              ), // (ncetrace200) <= (ae350_aopd)
	.dmi_hsize            (dmi_hsize             ), // (ncetrace200) <= (ae350_aopd)
	.dmi_htrans           (dmi_htrans            ), // (ncetrace200) <= (ae350_aopd)
	.dmi_hwdata           (dmi_hwdata            ), // (ncetrace200) <= (ae350_aopd)
	.dmi_hwrite           (dmi_hwrite            ), // (ncetrace200) <= (ae350_aopd)
	.dmi_resetn           (dmi_resetn            ), // (ncetrace200) <= (ae350_aopd)
	.hart0_power_down     (hart0_power_down      ), // (ncetrace200) <= ()
	.hart0_te_clk         (te_clk[0]             ), // (ncetrace200) <= (ae350_aopd)
	.hart0_te_reset_n     (te_reset_n[0]         ), // (ncetrace200) <= (ae350_aopd)
	.hart0_trace_cause    (hart0_trace_cause     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart0_trace_context  (hart0_trace_context   ), // (ncetrace200) <= ()
	.hart0_trace_ctype    (hart0_trace_ctype     ), // (ncetrace200) <= ()
	.hart0_trace_enabled  (hart0_trace_enabled   ), // (ncetrace200) => (ae350_cpu_subsystem)
	.hart0_trace_halted   (hart0_trace_halted    ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart0_trace_iaddr    (hart0_trace_iaddr     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart0_trace_ilastsize(hart0_trace_ilastsize ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart0_trace_iretire  (hart0_trace_iretire   ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart0_trace_itype    (hart0_trace_itype     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart0_trace_priv     (hart0_trace_priv      ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart0_trace_reset    (hart0_trace_reset     ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart0_trace_secure   (hart0_trace_secure    ), // (ncetrace200) <= ()
	.hart0_trace_stall    (hart0_trace_stall     ), // (ncetrace200) => ()
	.hart0_trace_trigger  (hart0_trace_trigger   ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.hart0_trace_tval     (hart0_trace_tval      ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.pldm_dmi_clk         (dmi_clk               ), // (ncetrace200) <= ()
	.pldm_dmi_haddr       (pldm_dmi_haddr        ), // (ncetrace200) => (ae350_cpu_subsystem)
	.pldm_dmi_hburst      (pldm_dmi_hburst       ), // (ncetrace200) => (ae350_cpu_subsystem)
	.pldm_dmi_hprot       (pldm_dmi_hprot        ), // (ncetrace200) => (ae350_cpu_subsystem)
	.pldm_dmi_hrdata      (pldm_dmi_hrdata       ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.pldm_dmi_hready      (pldm_dmi_hready       ), // (ncetrace200) => (ae350_cpu_subsystem)
	.pldm_dmi_hreadyout   (pldm_dmi_hreadyout    ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.pldm_dmi_hresp       (pldm_dmi_hresp        ), // (ncetrace200) <= (ae350_cpu_subsystem)
	.pldm_dmi_hsel        (pldm_dmi_hsel         ), // (ncetrace200) => (ae350_cpu_subsystem)
	.pldm_dmi_hsize       (pldm_dmi_hsize        ), // (ncetrace200) => (ae350_cpu_subsystem)
	.pldm_dmi_htrans      (pldm_dmi_htrans       ), // (ncetrace200) => (ae350_cpu_subsystem)
	.pldm_dmi_hwdata      (pldm_dmi_hwdata       ), // (ncetrace200) => (ae350_cpu_subsystem)
	.pldm_dmi_hwrite      (pldm_dmi_hwrite       ), // (ncetrace200) => (ae350_cpu_subsystem)
	.pldm_dmi_resetn      (pldm_dmi_resetn       ), // (ncetrace200) => (ae350_cpu_subsystem)
	.scan_enable          (scan_enable           ), // (ae350_apb_subsystem,ae350_cpu_subsystem,ncetrace200) <= (ae350_aopd)
	.sys_aclk             (tbuf_sys_aclk         ), // (ncetrace200) <= ()
	.sys_araddr           (tbuf_sys_araddr       ), // (ncetrace200) => (ae350_bus_connector)
	.sys_arburst          (tbuf_sys_arburst      ), // (ncetrace200) => (ae350_bus_connector)
	.sys_arcache          (tbuf_sys_arcache      ), // (ncetrace200) => (ae350_bus_connector)
	.sys_aresetn          (aresetn               ), // (ae350_apb_subsystem,ae350_bus_connector,ae350_cpu_subsystem,ae350_ram_subsystem,ncetrace200) <= (ae350_aopd)
	.sys_arid             (tbuf_sys_arid         ), // (ncetrace200) => (ae350_bus_connector)
	.sys_arlen            (tbuf_sys_arlen        ), // (ncetrace200) => (ae350_bus_connector)
	.sys_arlock           (tbuf_sys_arlock       ), // (ncetrace200) => (ae350_bus_connector)
	.sys_arprot           (tbuf_sys_arprot       ), // (ncetrace200) => (ae350_bus_connector)
	.sys_arready          (tbuf_sys_arready      ), // (ncetrace200) <= (ae350_bus_connector)
	.sys_arsize           (tbuf_sys_arsize       ), // (ncetrace200) => (ae350_bus_connector)
	.sys_arvalid          (tbuf_sys_arvalid      ), // (ncetrace200) => (ae350_bus_connector)
	.sys_awaddr           (tbuf_sys_awaddr       ), // (ncetrace200) => (ae350_bus_connector)
	.sys_awburst          (tbuf_sys_awburst      ), // (ncetrace200) => (ae350_bus_connector)
	.sys_awcache          (tbuf_sys_awcache      ), // (ncetrace200) => (ae350_bus_connector)
	.sys_awid             (tbuf_sys_awid         ), // (ncetrace200) => (ae350_bus_connector)
	.sys_awlen            (tbuf_sys_awlen        ), // (ncetrace200) => (ae350_bus_connector)
	.sys_awlock           (tbuf_sys_awlock       ), // (ncetrace200) => (ae350_bus_connector)
	.sys_awprot           (tbuf_sys_awprot       ), // (ncetrace200) => (ae350_bus_connector)
	.sys_awready          (tbuf_sys_awready      ), // (ncetrace200) <= (ae350_bus_connector)
	.sys_awsize           (tbuf_sys_awsize       ), // (ncetrace200) => (ae350_bus_connector)
	.sys_awvalid          (tbuf_sys_awvalid      ), // (ncetrace200) => (ae350_bus_connector)
	.sys_bid              (tbuf_sys_bid          ), // (ncetrace200) <= (ae350_bus_connector)
	.sys_bready           (tbuf_sys_bready       ), // (ncetrace200) => (ae350_bus_connector)
	.sys_bresp            (tbuf_sys_bresp        ), // (ncetrace200) <= (ae350_bus_connector)
	.sys_bvalid           (tbuf_sys_bvalid       ), // (ncetrace200) <= (ae350_bus_connector)
	.sys_rdata            (tbuf_sys_rdata        ), // (ncetrace200) <= (ae350_bus_connector)
	.sys_rid              (tbuf_sys_rid          ), // (ncetrace200) <= (ae350_bus_connector)
	.sys_rlast            (tbuf_sys_rlast        ), // (ncetrace200) <= (ae350_bus_connector)
	.sys_rready           (tbuf_sys_rready       ), // (ncetrace200) => (ae350_bus_connector)
	.sys_rresp            (tbuf_sys_rresp        ), // (ncetrace200) <= (ae350_bus_connector)
	.sys_rvalid           (tbuf_sys_rvalid       ), // (ncetrace200) <= (ae350_bus_connector)
	.sys_wdata            (tbuf_sys_wdata        ), // (ncetrace200) => (ae350_bus_connector)
	.sys_wlast            (tbuf_sys_wlast        ), // (ncetrace200) => (ae350_bus_connector)
	.sys_wready           (tbuf_sys_wready       ), // (ncetrace200) <= (ae350_bus_connector)
	.sys_wstrb            (tbuf_sys_wstrb        ), // (ncetrace200) => (ae350_bus_connector)
	.sys_wvalid           (tbuf_sys_wvalid       ), // (ncetrace200) => (ae350_bus_connector)
	.test_mode            (test_mode             ), // (ae350_cpu_subsystem,ncetrace200) <= (ae350_aopd)
	.test_resetn          (test_rstn             ), // (ae350_cpu_subsystem,ncetrace200) <= (ae350_aopd)
	.ts_clk               (ts_clk                ), // (ncetrace200) <= (ae350_aopd)
	.ts_reset_n           (ts_reset_n            ), // (ncetrace200) <= (ae350_aopd)
	.atclk                (atclk                 ), // (ncetrace200) <= ()
	.tb_ram_ctrl_in       (tb_ram_ctrl_in        ), // (ncetrace200) <= ()
	.tb_ram_ctrl_out      (unused_tb_ram_ctrl_out)  // (ncetrace200) => ()
); // end of ncetrace200

   `endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
endmodule
// VPERL_GENERATED_END
