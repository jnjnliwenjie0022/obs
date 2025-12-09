`include "config.inc"
`include "global.inc"

`include "ae350_config.vh"
`include "ae350_const.vh"
// =====================
// configurable IP
// =====================
`include "atcgpio100_config.vh"
`include "atcgpio100_const.vh"
`include "atcpit100_config.vh"
`include "atcpit100_const.vh"
`include "atcwdt200_config.vh"
`include "atcwdt200_const.vh"
`include "atcapbbrg100_config.vh"
`include "atcapbbrg100_const.vh"

`ifdef  AE350_SSP_SUPPORT
	`include "atfssp020_config.vh"
	`include "atfssp020_const.vh"
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

`ifdef AE350_SDC_SUPPORT
	`include "atfsdc010_config.vh"
	`include "atfsdc010_const.vh"
`endif // AE350_SDC_SUPPORT

// VPERL_BEGIN
// &MODULE("ae350_apb_subsystem");
// &PARAM("BUS_MASTER_ADDR_WIDTH	= 32");
// &PARAM("DMAC_DATA_WIDTH		= 64")
// &PARAM("DMAC_ID_WIDTH		= 4");
// 
// &LOCALPARAM("BUS_MASTER_ADDR_MSB	= BUS_MASTER_ADDR_WIDTH-1")
//
// &FORCE("input", "uart_clk");
// &FORCE("input", "uart_rstn");

// &FORCE("input", "spi_clk");
// &FORCE("input", "spi_rstn");

// &DANGLER("pprot");
// &DANGLER("pstrb");

// #------ Be configurable ------#
// $APB_SLV_SMU			= 1;
// $APB_SLV_UART1		= 2;
// $APB_SLV_UART2		= 3;
// $APB_SLV_PIT			= 4;
// $APB_SLV_WDT			= 5;
// $APB_SLV_RTC			= 6;
// $APB_SLV_GPIO		= 7;
// $APB_SLV_I2C			= 8;
// $APB_SLV_SPI1		= 9;
// $APB_SLV_SPI2		= 10;
// $APB_SLV_SDC			= 11;
// $APB_SLV_DMAC		= 12;
// $APB_SLV_SSP			= 13;
// $APB_SLV_DTROM		= 14;
// # For CF1
// $APB_SLV_SPI3		= 20;
// $APB_SLV_SPI4		= 21;
// $APB_SLV_I2C2		= 22;
// $APB_SLV_PIT2		= 23;
// $APB_SLV_PIT3		= 24;
// $APB_SLV_PIT4		= 25;
// $APB_SLV_PIT5		= 26;
//
// #------ Be configurable ------#
// &FORCE("wire", "dmareq_spi1_tx");
// &FORCE("wire", "dmareq_spi1_rx");
// &FORCE("wire", "dmareq_spi2_tx");
// &FORCE("wire", "dmareq_spi2_rx");
// &FORCE("wire", "dmareqn_uart1_tx");
// &FORCE("wire", "dmareqn_uart1_rx");
// &FORCE("wire", "dmareqn_uart2_tx");
// &FORCE("wire", "dmareqn_uart2_rx");
// &FORCE("wire", "dmareq_i2c");
// &FORCE("wire", "dmareq_sdc");
// &FORCE("wire", "dmareq_ssp_tx");
// &FORCE("wire", "dmareq_ssp_rx");
// &FORCE("output", "spi1_int");
// &FORCE("output", "spi2_int");
// &FORCE("output", "uart1_int");
// &FORCE("output", "uart2_int");
// &FORCE("output", "i2c_int");
// &FORCE("output", "ssp_intr");
// &FORCE("output", "gpio_intr");
// &FORCE("output", "wdt_int");
// &FORCE("output", "wdt_rst");

// &FORCE("output", "pit_intr");
// &FORCE("output", "sdc_int");
//
// # CF1
// &FORCE("wire", "dmareq_spi3_tx");
// &FORCE("wire", "dmareq_spi3_rx");
// &FORCE("wire", "dmareq_spi4_tx");
// &FORCE("wire", "dmareq_spi4_rx");
// &FORCE("wire", "dmareq_i2c2");
// for ($i = 0; $i < 4; $i++) {
//   $j = 2 + $i;
//   &FORCE("output", "pit${j}_int");
// }
// &FORCE("output", "spi3_int");
// &FORCE("output", "spi4_int");
// &FORCE("output", "i2c2_int");
// &FORCE("output", "pit2_int");
// &FORCE("output", "pit3_int");
// &FORCE("output", "pit4_int");
// &FORCE("output", "pit5_int");
//
//
// :`ifdef AE350_SPI1_SUPPORT
// :`else //~AE350_SPI1_SUPPORT
// : assign dmareq_spi1_tx = 1'b0;
// : assign dmareq_spi1_rx = 1'b0;
// : assign spi1_int = 1'b0;
// :`endif //AE350_SPI1_SUPPORT
//
// :`ifdef AE350_SPI2_SUPPORT
// :`else //~AE350_SPI2_SUPPORT
// : assign dmareq_spi2_tx = 1'b0;
// : assign dmareq_spi2_rx = 1'b0;
// : assign spi2_int = 1'b0;
// :`endif //AE350_SPI2_SUPPORT
//
// :`ifdef AE350_GPIO_SUPPORT
// :   `ifndef ATCGPIO100_INTR_SUPPORT
// : assign gpio_intr     = 1'b0;
// :   `endif // ATCGPIO100_INTR_SUPPORT
// :`else
// : assign gpio_intr     = 1'b0;
// :`endif // AE350_GPIO_SUPPORT

// :`ifdef AE350_WDT_SUPPORT
// :`else // AE350_WDT_SUPPORT
// : assign wdt_int       = 1'b0;
// : assign wdt_rst       = 1'b0;
// :`endif // AE350_WDT_SUPPORT

// :`ifdef AE350_PIT_SUPPORT
// :`else // AE350_PIT_SUPPORT
// : assign pit_intr      = 1'b0;
// :`endif // AE350_PIT_SUPPORT

// :`ifdef AE350_DMA_SUPPORT
// :`else //AE350_DMA_SUPPORT
// : assign dma_int = 1'b0;
// :`endif //AE350_DMA_SUPPORT
//
// :`ifdef AE350_SSP_SUPPORT
// :`else //~AE350_SSP_SUPPORT
// : assign ssp_intr = 1'b0;
// : assign dmareq_ssp_tx = 1'b0;
// : assign dmareq_ssp_rx = 1'b0;
// :`endif
//
// :`ifdef AE350_SDC_SUPPORT
// :`else //~AE350_SDC_SUPPORT
// : assign sdc_int = 1'b0;
// : assign dmareq_sdc = 1'b0;
// :`endif
// 
// :`ifdef AE350_UART1_SUPPORT
// :`else //~AE350_UART1_SUPPORT
// : assign dmareqn_uart1_tx = 1'b0;
// : assign dmareqn_uart1_rx = 1'b0;
// : assign uart1_int = 1'b0;
// :`endif //AE350_UART1_SUPPORT
//
// :`ifdef AE350_UART2_SUPPORT
// :`else //~AE350_UART2_SUPPORT
// : assign dmareqn_uart2_tx = 1'b0;
// : assign dmareqn_uart2_rx = 1'b0;
// : assign uart2_int = 1'b0;
// :`endif //AE350_UART2_SUPPORT
//
// :`ifdef AE350_I2C_SUPPORT
// :`else //~AE350_I2C_SUPPORT
// : assign dmareq_i2c = 1'b0;
// : assign i2c_int = 1'b0;
// :`endif //AE350_I2C_SUPPORT
//
// # CF1
// :`ifdef AE350_SPI3_SUPPORT
// :`else	// !AE350_SPI3_SUPPORT
// :assign dmareq_spi3_tx = 1'b0;
// :assign dmareq_spi3_rx = 1'b0;
// :`endif	// !AE350_SPI3_SUPPORT
// :
// :`ifdef AE350_SPI4_SUPPORT
// :`else	// !AE350_SPI4_SUPPORT
// :assign dmareq_spi4_tx = 1'b0;
// :assign dmareq_spi4_rx = 1'b0;
// :`endif	// !AE350_SPI4_SUPPORT
// :
// :`ifdef AE350_I2C2_SUPPORT
// :`else	// !AE350_I2C2_SUPPORT
// :assign dmareq_i2c2 = 1'b0;
// :assign i2c2_int = 1'b0;
// :`endif	// !AE350_I2C2_SUPPORT
//
//
// &FORCE("output", "paddr[`ATCAPBBRG100_ADDR_MSB:0]");
// &FORCE("output", "pwdata");
// &FORCE("output", "pwrite");
// &FORCE("output", "penable");

// &IFDEF("ATCAPBBRG100_SLV_14");
//   &IFDEF("AE350_DTROM_SIZE_KB");
//     &LOCALPARAM("DTROM_SIZE_KB = `AE350_DTROM_SIZE_KB");
//   &ELSE("AE350_DTROM_SIZE_KB");
//     &LOCALPARAM("DTROM_SIZE_KB = 8");
//   &ENDIF("AE350_DTROM_SIZE_KB");
// &ENDIF("ATCAPBBRG100_SLV_14");

// &FORCE("output", "smu_psel");
// &FORCE("input",  "smu_prdata[31:0]");
// &FORCE("input",  "smu_pslverr");
// &FORCE("input",  "smu_pready");
//
// &IFDEF("AE350_RTC_SUPPORT");
// &FORCE("output", "rtc_psel");
// &FORCE("input",  "rtc_prdata[31:0]");
// &FORCE("input",  "rtc_pslverr");
// &FORCE("input",  "rtc_pready");
// &ENDIF("AE350_RTC_SUPPORT");

//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcapbbrg100/hdl/atcapbbrg100.v","u_ahb2apb");
//
// #------ Interface port ------#
// &CONNECT("u_ahb2apb.haddr"		, "ahb2apb_haddr"	);
// &CONNECT("u_ahb2apb.hprot"		, "ahb2apb_hprot"	);
// &CONNECT("u_ahb2apb.hrdata"		, "ahb2apb_hrdata"	);
// &CONNECT("u_ahb2apb.hready"		, "ahb2apb_hready"	);
// &CONNECT("u_ahb2apb.hready_in"	, "ahb2apb_hready_in"	);
// &CONNECT("u_ahb2apb.hresp"		, "ahb2apb_hresp"	);
// &CONNECT("u_ahb2apb.hsel"		, "ahb2apb_hsel"	);
// &CONNECT("u_ahb2apb.hsize"		, "ahb2apb_hsize"	);
// &CONNECT("u_ahb2apb.htrans"		, "ahb2apb_htrans"	);
// &CONNECT("u_ahb2apb.hwdata"		, "ahb2apb_hwdata"	);
// &CONNECT("u_ahb2apb.hwrite"		, "ahb2apb_hwrite"	);
// &CONNECT("u_ahb2apb.paddr"		, "paddr"		);
//
// &IFDEF("ATCAPBBRG100_SLV_1");
//	&CONNECT("u_ahb2apb.ps1_prdata", "smu_prdata");
//	&CONNECT("u_ahb2apb.ps1_pready", "smu_pready");
//	&CONNECT("u_ahb2apb.ps1_psel",   "smu_psel");
//	&CONNECT("u_ahb2apb.ps1_pslverr","smu_pslverr");
// &ENDIF("ATCAPBBRG100_SLV_1");
//
// &IFDEF("AE350_RTC_SUPPORT");
//	&CONNECT("u_ahb2apb.ps6_prdata", "rtc_prdata");
//	&CONNECT("u_ahb2apb.ps6_pready", "rtc_pready");
//	&CONNECT("u_ahb2apb.ps6_psel", "rtc_psel");
//	&CONNECT("u_ahb2apb.ps6_pslverr", "rtc_pslverr");
// &ENDIF("AE350_RTC_SUPPORT");
//
// #------ $APB_SLV_UART1 ------#
// $i = $APB_SLV_UART1;
// &IFDEF("AE350_UART1_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcuart100/hdl/atcuart100.v", "u_uart1");
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_uart1.prdata"	, "ps${i}_prdata"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "1'b1"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "u_uart1.psel"	, "ps${i}_psel"	);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "1'b0"	);
// &ENDIF("AE350_UART1_SUPPORT");
//	&CONNECT("u_uart1.pclk"			, "pclk_uart1"	);
//	&CONNECT("u_uart1.paddr"		, "paddr[5:2]"	);
//	&CONNECT("u_uart1.uclk"			, "uart_clk"	);
//	&CONNECT("u_uart1.urstn"		, "uart_rstn"	);
//	&CONNECT("u_uart1.uart_ctsn"		, "uart1_ctsn"	);
//	&CONNECT("u_uart1.uart_dcdn"		, "uart1_dcdn"	);
//	&CONNECT("u_uart1.uart_dsrn"		, "uart1_dsrn"	);
//	&CONNECT("u_uart1.uart_rin"		, "uart1_rin"	);
//	&CONNECT("u_uart1.uart_sin"		, "uart1_rxd"	);
//	&CONNECT("u_uart1.uart_dtrn"		, "uart1_dtrn"	);
//	&CONNECT("u_uart1.uart_out1n"		, "uart1_out1n"	);
//	&CONNECT("u_uart1.uart_out2n"		, "uart1_out2n"	);
//	&CONNECT("u_uart1.uart_rtsn"		, "uart1_rtsn"	);
//	&CONNECT("u_uart1.uart_sout"		, "uart1_txd"	);
//
// #------ $APB_SLV_UART2 ------#
// $i = $APB_SLV_UART2;
// &IFDEF("AE350_UART2_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcuart100/hdl/atcuart100.v", "u_uart2");
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_uart2.prdata"	, "ps${i}_prdata"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "1'b1"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "u_uart2.psel"	, "ps${i}_psel"	);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "1'b0"	);
// &ENDIF("AE350_UART2_SUPPORT");
//	&CONNECT("u_uart2.pclk"			, "pclk_uart2"	);
//	&CONNECT("u_uart2.paddr"		, "paddr[5:2]"	);
//	&CONNECT("u_uart2.uclk"			, "uart_clk"	);
//	&CONNECT("u_uart2.urstn"		, "uart_rstn"	);
//	&CONNECT("u_uart2.uart_ctsn"		, "uart2_ctsn"	);
//	&CONNECT("u_uart2.uart_dcdn"		, "uart2_dcdn"	);
//	&CONNECT("u_uart2.uart_dsrn"		, "uart2_dsrn"	);
//	&CONNECT("u_uart2.uart_rin"		, "uart2_rin"	);
//	&CONNECT("u_uart2.uart_sin"		, "uart2_rxd"	);
//	&CONNECT("u_uart2.uart_dtrn"		, "uart2_dtrn"	);
//	&CONNECT("u_uart2.uart_out1n"		, "uart2_out1n"	);
//	&CONNECT("u_uart2.uart_out2n"		, "uart2_out2n"	);
//	&CONNECT("u_uart2.uart_rtsn"		, "uart2_rtsn"	);
//	&CONNECT("u_uart2.uart_sout"		, "uart2_txd"	);
//
// #------ $APB_SLV_PIT ------#
// $i = $APB_SLV_PIT;
// &IFDEF("AE350_PIT_SUPPORT");
//   &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcpit100/hdl/atcpit100.v", "u_pit");
//   &CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_pit.prdata"	, "ps${i}_prdata"	);
//   &CONNECT("u_ahb2apb.ps${i}_pready"				, "1'b1"	);
//   &CONNECT("u_ahb2apb.ps${i}_psel"	, "u_pit.psel"		, "ps${i}_psel"	);
//   &CONNECT("u_ahb2apb.ps${i}_pslverr"			, "1'b0"	);
//   &CONNECT("u_pit.pclk"					, "pclk_pit"	);
//   &CONNECT("u_pit.paddr"					, "paddr[6:2]"	);
//   &CONNECT("u_pit.pit_pause"					, "1'b0"	);
// &ENDIF("AE350_PIT_SUPPORT");
//
// # CF1
// for ($x = 2; $x <= 5; $x++) {
//   $i = ($APB_SLV_PIT2 + $x - 2);
//
//   &IFDEF("AE350_PIT${x}_SUPPORT");
//     &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcpit100/hdl/atcpit100.v", "u_pit$x");
//     &CONNECT("u_pit$x.pclk"						, "pclk_pit$x"		);
//     &CONNECT("u_pit$x.paddr"						, "paddr[6:2]"		);
//     &CONNECT("u_pit$x.psel"		, "u_ahb2apb.ps${i}_psel"	, "ps${i}_psel"		);
//     &CONNECT("u_pit$x.prdata"	, "u_ahb2apb.ps${i}_prdata"	, "ps${i}_prdata"	);
//     &CONNECT("u_pit$x.pit_pause"					, "1'b0"		);
//     &CONNECT("u_pit$x.ch0_pwm"					, "pit${x}_ch0_pwm"	);
//     &CONNECT("u_pit$x.ch0_pwmoe"					, "pit${x}_ch0_pwmoe"	);
//     &CONNECT("u_pit$x.ch1_pwm"					, "pit${x}_ch1_pwm"	);
//     &CONNECT("u_pit$x.ch1_pwmoe"					, "pit${x}_ch1_pwmoe"	);
//     &CONNECT("u_pit$x.ch2_pwm"					, "pit${x}_ch2_pwm"	);
//     &CONNECT("u_pit$x.ch2_pwmoe"					, "pit${x}_ch2_pwmoe"	);
//     &CONNECT("u_pit$x.ch3_pwm"					, "pit${x}_ch3_pwm"	);
//     &CONNECT("u_pit$x.ch3_pwmoe"					, "pit${x}_ch3_pwmoe"	);
//     &CONNECT(			  "u_ahb2apb.ps${i}_pready"	, "1'b1"		);
//     &CONNECT(			  "u_ahb2apb.ps${i}_pslverr"	, "1'b0"		);
//   &ENDIF("AE350_PIT${x}_SUPPORT");
//
//   &DANGLER("pclk_pit$x");
//   # Assume AE350_PIT_SUPPORT must be defined when AE350_PITx_SUPPORT is defined.
//   :`ifdef AE350_PIT${x}_SUPPORT
//   :assign pclk_pit$x = pclk_pit;
//   :`endif	// AE350_PIT${x}_SUPPORT
// }
//
//
// #------ $APB_SLV_WDT ------#
// $i = $APB_SLV_WDT;
// &IFDEF("AE350_WDT_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcwdt200/hdl/atcwdt200.v", "u_wdt");
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_wdt.prdata"	, "ps${i}_prdata"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "1'b1"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "u_wdt.psel"		, "ps${i}_psel"	);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "1'b0"	);
//	&CONNECT("u_wdt.pclk"			, "pclk_wdt"	);
//	&CONNECT("u_wdt.paddr"			, "paddr[4:2]"	);
//	&CONNECT("u_wdt.wdt_pause"		, "1'b0"	);
// &ENDIF("AE350_WDT_SUPPORT");
//
// #------ $APB_SLV_GPIO ------#
// $i = $APB_SLV_GPIO;
// &IFDEF("AE350_GPIO_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcgpio100/hdl/atcgpio100.v", "u_gpio");
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_gpio.prdata"	, "ps${i}_prdata"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "1'b1"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "u_gpio.psel"		, "ps${i}_psel"	);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "1'b0"	);
//	&CONNECT("u_gpio.pclk"			, "pclk_gpio"	);
//	&CONNECT("u_gpio.paddr"			, "paddr[7:0]"	);
// &ENDIF("AE350_GPIO_SUPPORT");
//
// #------ $APB_SLV_I2C ------#
// $i = $APB_SLV_I2C;
// &IFDEF("AE350_I2C_SUPPORT");
//   &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atciic100/hdl/atciic100.v", "u_i2c");
//   &CONNECT(				  "u_ahb2apb.ps${i}_pready"	, "1'b1"		);
//   &CONNECT(				  "u_ahb2apb.ps${i}_pslverr"	, "1'b0"		);
//   &CONNECT("u_i2c.prdata"		, "u_ahb2apb.ps${i}_prdata"	, "ps${i}_prdata"	);
//   &CONNECT("u_i2c.psel"		, "u_ahb2apb.ps${i}_psel"	, "ps${i}_psel"		);
//   &CONNECT("u_i2c.pclk"						, "pclk_i2c"		);
//   &CONNECT("u_i2c.paddr"						, "paddr[5:2]"		);
//   &CONNECT("u_i2c.scl_o"						, "i2c_scl"		);
//   &CONNECT("u_i2c.sda_o"						, "i2c_sda"		);
//   &CONNECT("u_i2c.scl_i"						, "i2c_scl_in"		);
//   &CONNECT("u_i2c.sda_i"						, "i2c_sda_in"		);
// &ENDIF("AE350_I2C_SUPPORT");
//
// #------ $APB_SLV_I2C2 (for CF1) ------#
// $i = $APB_SLV_I2C2;
// &IFDEF("AE350_I2C2_SUPPORT");
//   &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atciic100/hdl/atciic100.v", "u_i2c2");
//   &CONNECT(				  "u_ahb2apb.ps${i}_pready"	, "1'b1"		);
//   &CONNECT(				  "u_ahb2apb.ps${i}_pslverr"	, "1'b0"		);
//   &CONNECT("u_i2c2.prdata"		, "u_ahb2apb.ps${i}_prdata"	, "ps${i}_prdata"	);
//   &CONNECT("u_i2c2.psel"		, "u_ahb2apb.ps${i}_psel"	, "ps${i}_psel"		);
//   &CONNECT("u_i2c2.pclk"						, "pclk_i2c"		);
//   &CONNECT("u_i2c2.paddr"						, "paddr[5:2]"		);
//   &CONNECT("u_i2c2.scl_o"						, "i2c2_scl"		);
//   &CONNECT("u_i2c2.sda_o"						, "i2c2_sda"		);
//   &CONNECT("u_i2c2.scl_i"						, "i2c2_scl_in"		);
//   &CONNECT("u_i2c2.sda_i"						, "i2c2_sda_in"		);
// &ENDIF("AE350_I2C2_SUPPORT");
//
//
// #------ $APB_SLV_SPI1 ------#
// $i = $APB_SLV_SPI1;
// &IFDEF("AE350_SPI1_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200.v", "u_spi1");
// 	#------ SPI inter connection ------#
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_spi1.prdata"	, "ps${i}_prdata"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "u_spi1.pready"	, "ps${i}_pready"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "u_spi1.psel"		, "ps${i}_psel"	);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "1'b0"		);
// &ENDIF("AE350_SPI1_SUPPORT");
//	&CONNECT("u_spi1.pclk"			, "pclk_spi1"		);
//	&CONNECT("u_spi1.apb2eilm_clken"	, "apb2core_clken"	);
//	&CONNECT("u_spi1.spi_clock"		, "spi_clk"		);
//	&CONNECT("u_spi1.spi_rstn"		, "spi_rstn"		);
// 	#------ SPI interface ------#
//	&CONNECT("u_spi1.haddr_mem"		, "spi_mem_haddr"	);
//	&CONNECT("u_spi1.hrdata_mem"		, "spi_mem_hrdata"	);
//	&CONNECT("u_spi1.hreadyin_mem"		, "spi_mem_hready"	);
//	&CONNECT("u_spi1.hreadyout_mem"		, "spi_mem_hreadyout"	);
//	&CONNECT("u_spi1.hresp_mem"		, "spi_mem_hresp"	);
//	&CONNECT("u_spi1.hsel_mem"		, "spi_mem_hsel"	);
//	&CONNECT("u_spi1.htrans_mem"		, "spi_mem_htrans"	);
//	&CONNECT("u_spi1.hwrite_mem"		, "spi_mem_hwrite"	);
// 	#------ SPI interface ------#
//	&CONNECT("u_spi1.spi_clk_in"		, "spi1_clk_in"		);
//	&CONNECT("u_spi1.spi_clk_oe"		, "spi1_clk_oe"		);
//	&CONNECT("u_spi1.spi_clk_out"		, "spi1_clk_out"	);
//	&CONNECT("u_spi1.spi_cs_n_in"		, "spi1_csn_in"		);
//	&CONNECT("u_spi1.spi_cs_n_oe"		, "spi1_csn_oe"		);
//	&CONNECT("u_spi1.spi_cs_n_out"		, "spi1_csn_out"	);
//	&CONNECT("u_spi1.spi_miso_in"		, "spi1_miso_in"	);
//	&CONNECT("u_spi1.spi_miso_oe"		, "spi1_miso_oe"	);
//	&CONNECT("u_spi1.spi_miso_out"		, "spi1_miso_out"	);
//	&CONNECT("u_spi1.spi_mosi_in"		, "spi1_mosi_in"	);
//	&CONNECT("u_spi1.spi_mosi_oe"		, "spi1_mosi_oe"	);
//	&CONNECT("u_spi1.spi_mosi_out"		, "spi1_mosi_out"	);
//	&CONNECT("u_spi1.spi_hold_n_in"		, "spi1_holdn_in"	);
//	&CONNECT("u_spi1.spi_hold_n_oe"		, "spi1_holdn_oe"	);
//	&CONNECT("u_spi1.spi_hold_n_out"	, "spi1_holdn_out"	);
//	&CONNECT("u_spi1.spi_wp_n_in"		, "spi1_wpn_in"		);
//	&CONNECT("u_spi1.spi_wp_n_oe"		, "spi1_wpn_oe"		);
//	&CONNECT("u_spi1.spi_wp_n_out"		, "spi1_wpn_out"	);
// 	#------ SPI constant ------#
//	&CONNECT("u_spi1.spi_default_as_slave"	, "1'b0"		);
//	&CONNECT("u_spi1.spi_default_mode3"	, "1'b0"		);
// 	#------ SPI inter unused ------#
//	&CONNECT("u_spi1.haddr_reg"		, "/* NC */"		);
//	&CONNECT("u_spi1.hrdata_reg"		, "/* NC */"		);
//	&CONNECT("u_spi1.hreadyin_reg"		, "/* NC */"		);
//	&CONNECT("u_spi1.hreadyout_reg"		, "/* NC */"		);
//	&CONNECT("u_spi1.hresp_reg"		, "/* NC */"		);
//	&CONNECT("u_spi1.hsel_reg"		, "/* NC */"		);
//	&CONNECT("u_spi1.htrans_reg"		, "/* NC */"		);
//	&CONNECT("u_spi1.hwdata_reg"		, "/* NC */"		);
//	&CONNECT("u_spi1.hwrite_reg"		, "/* NC */"		);
//	&CONNECT("u_spi1.ahb2eilm_clken"	, "/* NC */"		);
//	&CONNECT("u_spi1.eilm_reg_sel"		, "/* NC */"		);
//	&CONNECT("u_spi1.eilm_reg_sel"		, "/* NC */"		);
//	&CONNECT("u_spi1.eilm_addr"		, "/* NC */"		);
//	&CONNECT("u_spi1.eilm_clk"		, "/* NC */"		);
//	&CONNECT("u_spi1.eilm_rdata"		, "/* NC */"		);
//	&CONNECT("u_spi1.eilm_req"		, "/* NC */"		);
//	&CONNECT("u_spi1.eilm_resetn"		, "/* NC */"		);
//	&CONNECT("u_spi1.eilm_wait"		, "/* NC */"		);
//	&CONNECT("u_spi1.eilm_wait_cnt"		, "/* NC */"		);
//	&CONNECT("u_spi1.eilm_wdata"		, "/* NC */"		);
//	&CONNECT("u_spi1.eilm_web"		, "/* NC */"		);
//	&CONNECT("u_spi1.hmaster_mem"		, "/* NC */"		);
//	&CONNECT("u_spi1.hsplit_mem"		, "/* NC */"		);

//
// #------ $APB_SLV_SPI2 ------#
// $i = $APB_SLV_SPI2;
// &IFDEF("AE350_SPI2_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200.v", "u_spi2");
// 	#------ SPI inter connection ------#
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_spi2.prdata"	, "ps${i}_prdata"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "u_spi2.pready"	, "ps${i}_pready"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "u_spi2.psel"		, "ps${i}_psel"	);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "1'b0"	);
// &ENDIF("AE350_SPI2_SUPPORT");
//	&CONNECT("u_spi2.pclk"			, "pclk_spi2"	);
//	&CONNECT("u_spi2.apb2eilm_clken"	, "apb2core_clken"	);
//	&CONNECT("u_spi2.spi_clock"		, "spi_clk"	);
//	&CONNECT("u_spi2.spi_rstn"		, "spi_rstn"	);
// 	#------ SPI interface ------#
//	&CONNECT("u_spi2.spi_clk_in"		, "spi2_clk_in"	);
//	&CONNECT("u_spi2.spi_clk_oe"		, "spi2_clk_oe"	);
//	&CONNECT("u_spi2.spi_clk_out"		, "spi2_clk_out"	);
//	&CONNECT("u_spi2.spi_cs_n_in"		, "spi2_csn_in"	);
//	&CONNECT("u_spi2.spi_cs_n_oe"		, "spi2_csn_oe"	);
//	&CONNECT("u_spi2.spi_cs_n_out"		, "spi2_csn_out"	);
//	&CONNECT("u_spi2.spi_miso_in"		, "spi2_miso_in"	);
//	&CONNECT("u_spi2.spi_miso_oe"		, "spi2_miso_oe"	);
//	&CONNECT("u_spi2.spi_miso_out"		, "spi2_miso_out"	);
//	&CONNECT("u_spi2.spi_mosi_in"		, "spi2_mosi_in"	);
//	&CONNECT("u_spi2.spi_mosi_oe"		, "spi2_mosi_oe"	);
//	&CONNECT("u_spi2.spi_mosi_out"		, "spi2_mosi_out"	);
//	&CONNECT("u_spi2.spi_hold_n_in"		, "spi2_holdn_in"	);
//	&CONNECT("u_spi2.spi_hold_n_oe"		, "spi2_holdn_oe"	);
//	&CONNECT("u_spi2.spi_hold_n_out"	, "spi2_holdn_out"	);
//	&CONNECT("u_spi2.spi_wp_n_in"		, "spi2_wpn_in"	);
//	&CONNECT("u_spi2.spi_wp_n_oe"		, "spi2_wpn_oe"	);
//	&CONNECT("u_spi2.spi_wp_n_out"		, "spi2_wpn_out"	);
// 	#------ SPI constant ------#
//	&CONNECT("u_spi2.spi_default_as_slave"	, "1'b0"	);
//	&CONNECT("u_spi2.spi_default_mode3"	, "1'b0"	);
// 	#------ SPI inter unused ------#
//	&CONNECT("u_spi2.eilm_addr"		, "/* NC */"	);
//	&CONNECT("u_spi2.eilm_clk"		, "/* NC */"	);
//	&CONNECT("u_spi2.eilm_rdata"		, "/* NC */"	);
//	&CONNECT("u_spi2.eilm_req"		, "/* NC */"	);
//	&CONNECT("u_spi2.eilm_resetn"		, "/* NC */"	);
//	&CONNECT("u_spi2.eilm_wait"		, "/* NC */"	);
//	&CONNECT("u_spi2.eilm_wait_cnt"		, "/* NC */"	);
//	&CONNECT("u_spi2.eilm_wdata"		, "/* NC */"	);
//	&CONNECT("u_spi2.eilm_web"		, "/* NC */"	);
//	&CONNECT("u_spi2.haddr_mem"		, "{`ATCSPI200_HADDR_WIDTH{1'b0}}"	);
//	&CONNECT("u_spi2.hrdata_mem"		, "/* NC */"	);
//	&CONNECT("u_spi2.hreadyin_mem"		, "1'b1"	);
//	&CONNECT("u_spi2.hreadyout_mem"		, "/* NC */"	);
//	&CONNECT("u_spi2.hresp_mem"		, "/* NC */"	);
//	&CONNECT("u_spi2.hsel_mem"		, "1'b0"	);
//	&CONNECT("u_spi2.htrans_mem"		, "2'b0"	);
//	&CONNECT("u_spi2.hwrite_mem"		, "1'b0"	);
//	&CONNECT("u_spi2.haddr_reg"		, "/* NC */"	);
//	&CONNECT("u_spi2.hrdata_reg"		, "/* NC */"	);
//	&CONNECT("u_spi2.hreadyin_reg"		, "/* NC */"	);
//	&CONNECT("u_spi2.hreadyout_reg"		, "/* NC */"	);
//	&CONNECT("u_spi2.hresp_reg"		, "/* NC */"	);
//	&CONNECT("u_spi2.hsel_reg"		, "/* NC */"	);
//	&CONNECT("u_spi2.htrans_reg"		, "/* NC */"	);
//	&CONNECT("u_spi2.hwdata_reg"		, "/* NC */"	);
//	&CONNECT("u_spi2.hwrite_reg"		, "/* NC */"	);
//	&CONNECT("u_spi2.ahb2eilm_clken"	, "/* NC */"	);
//	&CONNECT("u_spi2.hmaster_mem"		, "/* NC */"	);
//	&CONNECT("u_spi2.hsplit_mem"		, "/* NC */"	);
//	&CONNECT("u_spi2.eilm_reg_sel"		, "/* NC */"	);
//
// #------ $APB_SLV_SPI3/4 (for CF1) ------#
// for ($x = 3; $x <= 4; $x++) {
//   $i = ($x == 3) ? $APB_SLV_SPI3 : $APB_SLV_SPI4;
//   &IFDEF("AE350_SPI${x}_SUPPORT");
//     &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200.v", "u_spi${x}");
//
//     &CONNECT("u_spi${x}.spi_clock"		, "spi_clk");
//     &CONNECT("u_spi${x}.spi_rstn"		, "spi_rstn");
//     # APB Interface
//     &CONNECT("u_spi${x}.pclk"		, "pclk_spi${x}");
//     &CONNECT("u_spi${x}.psel"		, "u_ahb2apb.ps${i}_psel",	"ps${i}_psel"	);
//     &CONNECT("u_spi${x}.pready"		, "u_ahb2apb.ps${i}_pready",	"ps${i}_pready"	);
//     &CONNECT("u_spi${x}.prdata"		, "u_ahb2apb.ps${i}_prdata",	"ps${i}_prdata"	);
//     &CONNECT("u_spi${x}.apb2eilm_clken"	, "apb2core_clken");
//     # SPI Interface
//     &CONNECT("u_spi${x}.spi_clk_in"		, "spi${x}_clk_in");
//     &CONNECT("u_spi${x}.spi_cs_n_in"		, "spi${x}_csn_in");
//     &CONNECT("u_spi${x}.spi_miso_in"		, "spi${x}_miso_in");
//     &CONNECT("u_spi${x}.spi_mosi_in"		, "spi${x}_mosi_in");
//     &CONNECT("u_spi${x}.spi_hold_n_in"	, "spi${x}_holdn_in");
//     &CONNECT("u_spi${x}.spi_wp_n_in"		, "spi${x}_wpn_in");
//     &CONNECT("u_spi${x}.spi_clk_out"		, "spi${x}_clk_out");
//     &CONNECT("u_spi${x}.spi_cs_n_out"	, "spi${x}_csn_out");
//     &CONNECT("u_spi${x}.spi_mosi_out"	, "spi${x}_mosi_out");
//     &CONNECT("u_spi${x}.spi_miso_out"	, "spi${x}_miso_out");
//     &CONNECT("u_spi${x}.spi_hold_n_out"	, "spi${x}_holdn_out");
//     &CONNECT("u_spi${x}.spi_wp_n_out"	, "spi${x}_wpn_out");
//     &CONNECT("u_spi${x}.spi_clk_oe"		, "spi${x}_clk_oe");
//     &CONNECT("u_spi${x}.spi_cs_n_oe"		, "spi${x}_csn_oe");
//     &CONNECT("u_spi${x}.spi_mosi_oe"		, "spi${x}_mosi_oe");
//     &CONNECT("u_spi${x}.spi_miso_oe"		, "spi${x}_miso_oe");
//     &CONNECT("u_spi${x}.spi_hold_n_oe"	, "spi${x}_holdn_oe");
//     &CONNECT("u_spi${x}.spi_wp_n_oe"		, "spi${x}_wpn_oe");
//     # SMU interface
//     &CONNECT("u_spi${x}.spi_default_mode3"	, "1'b0");
//     &CONNECT("u_spi${x}.spi_default_as_slave", "1'b0");
//     # DMA handshake interface
//     &CONNECT("u_spi${x}.spi_tx_dma_req"	, "dmareq_spi${x}_tx"	);
//     &CONNECT("u_spi${x}.spi_rx_dma_req",	, "dmareq_spi${x}_rx"	);
//
//     # The memory interface is not used.
//     &CONNECT("u_spi${x}.hsel_mem"		, "1'b0");
//     &CONNECT("u_spi${x}.htrans_mem"		, "2'b0");
//     &CONNECT("u_spi${x}.hwrite_mem"		, "1'b0");
//     &CONNECT("u_spi${x}.haddr_mem"		, "{`ATCSPI200_HADDR_WIDTH{1'b0}}");
//     &CONNECT("u_spi${x}.hreadyin_mem"	, "1'b0");
//     &CONNECT("u_spi${x}.hmaster_mem"		, "{`ATCSPI200_HMASTER_BIT{1'b0}}");
//
//     # The rest of I/Os are not supported.
//     # Unsupported I/Os.
//     for my $p (qw/hresp_mem hreadyout_mem hrdata_mem hsplit_mem hsplit_mem
//         hsel_reg hrdata_reg hreadyout_reg hresp_reg htrans_reg haddr_reg hwdata_reg hwrite_reg hreadyin_reg
//         eilm_resetn eilm_clk ahb2eilm_clken eilm_addr eilm_req eilm_wait_cnt eilm_wdata eilm_web eilm_rdata
//         eilm_wait eilm_reg_sel/) {
//       &CONNECT("u_spi${x}.$p", "/* NC */");
//     }
//
//     &DANGLER("dmareq_spi${x}_tx");
//     &DANGLER("dmareq_spi${x}_rx");
//   &ELSE("AE350_SPI${x}_SUPPORT");
//     &FORCE("wire", "spi${x}_int = 1'b0");
//   &ENDIF("AE350_SPI${x}_SUPPORT");
//
//   &CONNECT("u_ahb2apb.ps${i}_pslverr", "1'b0");
//
//   &DANGLER("pclk_spi$x");
//   # Assume AE350_SPI1_SUPPORT must be defined when AE350_SPI[34]_SUPPORT is defined.
//   :`ifdef AE350_SPI${x}_SUPPORT
//   :assign pclk_spi$x = pclk_spi1;
//   :`endif	// AE350_SPI${x}_SUPPORT
// }
//
//
// #------ $APB_SLV_SDC ------#
// $i = $APB_SLV_SDC;
// &IFDEF("AE350_SDC_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atfsdc010/hdl/atfsdc010.v", "u_sdc");
// 	#------ SDC inter connection ------#
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_sdc.prdata"	, "ps${i}_prdata"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "1'b1"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "u_sdc.psel"		, "ps${i}_psel"	);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "1'b0"	);
// &ENDIF("AE350_SDC_SUPPORT");
//	&CONNECT("u_sdc.paddr"			, "paddr[7:0]"	);
//	&CONNECT("u_sdc.sys_rstn"		, "presetn"	);
//	&CONNECT("u_sdc.sys_clk"		, "pclk"	);
//	&CONNECT("u_sdc.sdc_clk"		, "sdc_clk"	);
//	&CONNECT("u_sdc.sdc_rstn"		, "presetn"	);
// 	#------ SDC interface ------#
//	&CONNECT("u_sdc.io_sd_rsp"		, "T_sd_rsp"	);
//	&CONNECT("u_sdc.io_sd_cd"		, "T_sd_cd"	);
//	&CONNECT("u_sdc.io_sd_wp"		, "T_sd_wp"	);
//	&CONNECT("u_sdc.io_sd_clk"		, "sd_clk"	);
//	&CONNECT("u_sdc.io_sd_power"		, "sd_power"	);
//	&CONNECT("u_sdc.io_sd_gpo"		, "/* NC */"	);
//	&CONNECT("u_sdc.io_sd_cmd"		, "sd_cmd"	);
//	&CONNECT("u_sdc.io_sd_cmd_oe"		, "sd_cmd_oe"	);
//	&CONNECT("u_sdc.io_sd_dat0_in"		, "T_sd_dat0_in"	);
//	&CONNECT("u_sdc.io_sd_dat1_in"		, "T_sd_dat1_in"	);
//	&CONNECT("u_sdc.io_sd_dat2_in"		, "T_sd_dat2_in"	);
//	&CONNECT("u_sdc.io_sd_dat3_in"		, "T_sd_dat3_in"	);
//	&CONNECT("u_sdc.io_sd_dat4_in"		, "1'b0"	);
//	&CONNECT("u_sdc.io_sd_dat5_in"		, "1'b0"	);
//	&CONNECT("u_sdc.io_sd_dat6_in"		, "1'b0"	);
//	&CONNECT("u_sdc.io_sd_dat7_in"		, "1'b0"	);
//	&CONNECT("u_sdc.io_sd_dat0_out"		, "sd_dat0_out"	);
//	&CONNECT("u_sdc.io_sd_dat1_out"		, "sd_dat1_out"	);
//	&CONNECT("u_sdc.io_sd_dat2_out"		, "sd_dat2_out"	);
//	&CONNECT("u_sdc.io_sd_dat3_out"		, "sd_dat3_out"	);
//	&CONNECT("u_sdc.io_sd_dat4_out"		, "/* NC */"	);
//	&CONNECT("u_sdc.io_sd_dat5_out"		, "/* NC */"	);
//	&CONNECT("u_sdc.io_sd_dat6_out"		, "/* NC */"	);
//	&CONNECT("u_sdc.io_sd_dat7_out"		, "/* NC */"	);
//	&CONNECT("u_sdc.io_sd_dat0_oe"		, "sd_dat0_oe"	);
//	&CONNECT("u_sdc.io_sd_dat1_oe"		, "sd_dat1_oe"	);
//	&CONNECT("u_sdc.io_sd_dat2_oe"		, "sd_dat2_oe"	);
//	&CONNECT("u_sdc.io_sd_dat3_oe"		, "sd_dat3_oe"	);
//	&CONNECT("u_sdc.io_sd_dat4_oe"		, "/* NC */"	);
//	&CONNECT("u_sdc.io_sd_dat5_oe"		, "/* NC */"	);
//	&CONNECT("u_sdc.io_sd_dat6_oe"		, "/* NC */"	);
//	&CONNECT("u_sdc.io_sd_dat7_oe"		, "/* NC */"	);
// 	#------ SDC unused ------#
//	&CONNECT("u_sdc.hsel"			, "/* NC */"	);
//	&CONNECT("u_sdc.hreadyi"		, "/* NC */"	);
//	&CONNECT("u_sdc.haddr"			, "/* NC */"	);
//	&CONNECT("u_sdc.htrans"			, "/* NC */"	);
//	&CONNECT("u_sdc.hsize"			, "/* NC */"	);
//	&CONNECT("u_sdc.hwrite"			, "/* NC */"	);
//	&CONNECT("u_sdc.hwdata"			, "/* NC */"	);
//	&CONNECT("u_sdc.hrdata"			, "/* NC */"	);
//	&CONNECT("u_sdc.hready"			, "/* NC */"	);
//	&CONNECT("u_sdc.hresp"			, "/* NC */"	);
//
// #------ $APB_SLV_DMAC ------#
// &FORCE("wire", "dma_req[15:0]");
// $i = $APB_SLV_DMAC;
// &IFDEF("AE350_DMA_AXI_SUPPORT");
// 	&INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcdmac300/hdl/atcdmac300.v", "u_dmac_axi");
// 	&FORCE("output", "dmac0_araddr[BUS_MASTER_ADDR_MSB:0]");
// 	&FORCE("output", "dmac0_awaddr[BUS_MASTER_ADDR_MSB:0]");
// 	&FORCE("output", "dmac0_wdata[(DMAC_DATA_WIDTH-1):0]");
// 	&FORCE("output", "dmac0_wstrb[((DMAC_DATA_WIDTH/8)-1):0]");
// 	&FORCE("input",  "dmac0_rdata[(DMAC_DATA_WIDTH-1):0]");
// 	&IFDEF("ATCDMAC300_DUAL_MASTER_IF_SUPPORT");
// 		&FORCE("output", "dmac1_araddr[BUS_MASTER_ADDR_MSB:0]");
// 		&FORCE("output", "dmac1_awaddr[BUS_MASTER_ADDR_MSB:0]");
// 		&FORCE("output", "dmac1_wdata[(DMAC_DATA_WIDTH-1):0]");
// 		&FORCE("output", "dmac1_wstrb[((DMAC_DATA_WIDTH/8)-1):0]");
// 		&FORCE("input",  "dmac1_rdata[(DMAC_DATA_WIDTH-1):0]");
// 	&ENDIF("ATCDMAC300_DUAL_MASTER_IF_SUPPORT");
// &ENDIF("AE350_DMA_AXI_SUPPORT");
// &IFDEF("AE350_DMA_AHB_SUPPORT");
// 	&INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcdmac110/hdl/atcdmac110.v", "u_dmac_ahb");
// 	&FORCE("output", "dmac_haddr[31:0]");
// &ENDIF("AE350_DMA_AHB_SUPPORT");
// &IFDEF("ATCAPBBRG100_SLV_12");
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_dmac_axi.prdata"	, "ps${i}_prdata"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "u_dmac_axi.pready"	, "ps${i}_pready"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "u_dmac_axi.psel"	, "ps${i}_psel"	);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "u_dmac_axi.pslverr"	, "ps${i}_pslverr"	);
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_dmac_ahb.prdata"	, "ps${i}_prdata"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "u_dmac_ahb.pready"	, "ps${i}_pready"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "u_dmac_ahb.psel"	, "ps${i}_psel"	);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "u_dmac_ahb.pslverr"	, "ps${i}_pslverr"	);
// &ENDIF("ATCAPBBRG100_SLV_12");
// 	#------ DAMC300 AXI interface ------#
//	&CONNECT("u_dmac_axi.m0_araddr"	, "dmac0_araddr"	);
//	&CONNECT("u_dmac_axi.m0_arburst"	, "dmac0_arburst"	);
//	&CONNECT("u_dmac_axi.m0_arcache"	, "dmac0_arcache"	);
//	&CONNECT("u_dmac_axi.m0_arid"	, "dmac0_arid_3bit"	);
//	&CONNECT("u_dmac_axi.m0_arlen"	, "dmac0_arlen"	);
//	&CONNECT("u_dmac_axi.m0_arlock"	, "dmac0_arlock"	);
//	&CONNECT("u_dmac_axi.m0_arprot"	, "dmac0_arprot"	);
//	&CONNECT("u_dmac_axi.m0_arready"	, "dmac0_arready"	);
//	&CONNECT("u_dmac_axi.m0_arsize"	, "dmac0_arsize"	);
//	&CONNECT("u_dmac_axi.m0_arvalid"	, "dmac0_arvalid"	);
//	&CONNECT("u_dmac_axi.m0_awaddr"	, "dmac0_awaddr"	);
//	&CONNECT("u_dmac_axi.m0_awburst"	, "dmac0_awburst"	);
//	&CONNECT("u_dmac_axi.m0_awcache"	, "dmac0_awcache"	);
//	&CONNECT("u_dmac_axi.m0_awid"	, "dmac0_awid_3bit"	);
//	&CONNECT("u_dmac_axi.m0_awlen"	, "dmac0_awlen"	);
//	&CONNECT("u_dmac_axi.m0_awlock"	, "dmac0_awlock"	);
//	&CONNECT("u_dmac_axi.m0_awprot"	, "dmac0_awprot"	);
//	&CONNECT("u_dmac_axi.m0_awready"	, "dmac0_awready"	);
//	&CONNECT("u_dmac_axi.m0_awsize"	, "dmac0_awsize"	);
//	&CONNECT("u_dmac_axi.m0_awvalid"	, "dmac0_awvalid"	);
//	&CONNECT("u_dmac_axi.m0_bid"	, "dmac0_bid_3bit"	);
//	&CONNECT("u_dmac_axi.m0_bready"	, "dmac0_bready"	);
//	&CONNECT("u_dmac_axi.m0_bresp"	, "dmac0_bresp"	);
//	&CONNECT("u_dmac_axi.m0_bvalid"	, "dmac0_bvalid"	);
//	&CONNECT("u_dmac_axi.m0_rdata"	, "dmac0_rdata"	);
//	&CONNECT("u_dmac_axi.m0_rid"	, "dmac0_rid_3bit"	);
//	&CONNECT("u_dmac_axi.m0_rlast"	, "dmac0_rlast"	);
//	&CONNECT("u_dmac_axi.m0_rready"	, "dmac0_rready"	);
//	&CONNECT("u_dmac_axi.m0_rresp"	, "dmac0_rresp"	);
//	&CONNECT("u_dmac_axi.m0_rvalid"	, "dmac0_rvalid"	);
//	&CONNECT("u_dmac_axi.m0_wdata"	, "dmac0_wdata"	);
//	&CONNECT("u_dmac_axi.m0_wlast"	, "dmac0_wlast"	);
//	&CONNECT("u_dmac_axi.m0_wready"	, "dmac0_wready"	);
//	&CONNECT("u_dmac_axi.m0_wstrb"	, "dmac0_wstrb"	);
//	&CONNECT("u_dmac_axi.m0_wvalid"	, "dmac0_wvalid"	);
//	&CONNECT("u_dmac_axi.m1_araddr"	, "dmac1_araddr"	);
//	&CONNECT("u_dmac_axi.m1_arburst"	, "dmac1_arburst"	);
//	&CONNECT("u_dmac_axi.m1_arcache"	, "dmac1_arcache"	);
//	&CONNECT("u_dmac_axi.m1_arid"	, "dmac1_arid_3bit"	);
//	&CONNECT("u_dmac_axi.m1_arlen"	, "dmac1_arlen"	);
//	&CONNECT("u_dmac_axi.m1_arlock"	, "dmac1_arlock"	);
//	&CONNECT("u_dmac_axi.m1_arprot"	, "dmac1_arprot"	);
//	&CONNECT("u_dmac_axi.m1_arready"	, "dmac1_arready"	);
//	&CONNECT("u_dmac_axi.m1_arsize"	, "dmac1_arsize"	);
//	&CONNECT("u_dmac_axi.m1_arvalid"	, "dmac1_arvalid"	);
//	&CONNECT("u_dmac_axi.m1_awaddr"	, "dmac1_awaddr"	);
//	&CONNECT("u_dmac_axi.m1_awburst"	, "dmac1_awburst"	);
//	&CONNECT("u_dmac_axi.m1_awcache"	, "dmac1_awcache"	);
//	&CONNECT("u_dmac_axi.m1_awid"	, "dmac1_awid_3bit"	);
//	&CONNECT("u_dmac_axi.m1_awlen"	, "dmac1_awlen"	);
//	&CONNECT("u_dmac_axi.m1_awlock"	, "dmac1_awlock"	);
//	&CONNECT("u_dmac_axi.m1_awprot"	, "dmac1_awprot"	);
//	&CONNECT("u_dmac_axi.m1_awready"	, "dmac1_awready"	);
//	&CONNECT("u_dmac_axi.m1_awsize"	, "dmac1_awsize"	);
//	&CONNECT("u_dmac_axi.m1_awvalid"	, "dmac1_awvalid"	);
//	&CONNECT("u_dmac_axi.m1_bid"	, "dmac1_bid_3bit"	);
//	&CONNECT("u_dmac_axi.m1_bready"	, "dmac1_bready"	);
//	&CONNECT("u_dmac_axi.m1_bresp"	, "dmac1_bresp"	);
//	&CONNECT("u_dmac_axi.m1_bvalid"	, "dmac1_bvalid"	);
//	&CONNECT("u_dmac_axi.m1_rdata"	, "dmac1_rdata"	);
//	&CONNECT("u_dmac_axi.m1_rid"	, "dmac1_rid_3bit"	);
//	&CONNECT("u_dmac_axi.m1_rlast"	, "dmac1_rlast"	);
//	&CONNECT("u_dmac_axi.m1_rready"	, "dmac1_rready"	);
//	&CONNECT("u_dmac_axi.m1_rresp"	, "dmac1_rresp"	);
//	&CONNECT("u_dmac_axi.m1_rvalid"	, "dmac1_rvalid"	);
//	&CONNECT("u_dmac_axi.m1_wdata"	, "dmac1_wdata"	);
//	&CONNECT("u_dmac_axi.m1_wlast"	, "dmac1_wlast"	);
//	&CONNECT("u_dmac_axi.m1_wready"	, "dmac1_wready"	);
//	&CONNECT("u_dmac_axi.m1_wstrb"	, "dmac1_wstrb"	);
//	&CONNECT("u_dmac_axi.m1_wvalid"	, "dmac1_wvalid"	);
// 	#------ DAMC110 AHB interface ------#
//	&CONNECT("u_dmac_ahb.haddr_mst"	, "dmac_haddr"	);
//	&CONNECT("u_dmac_ahb.hburst_mst"	, "dmac_hburst"	);
//	&CONNECT("u_dmac_ahb.hbusreq_mst"	, "/* NC */"	);
//	&CONNECT("u_dmac_ahb.hgrant_mst"	, "1'b1"	);
//	&CONNECT("u_dmac_ahb.hlock_mst"	, "/* NC */"	);
//	&CONNECT("u_dmac_ahb.hprot_mst"	, "dmac_hprot"	);
//	&CONNECT("u_dmac_ahb.hrdata_mst"	, "dmac_hrdata"	);
//	&CONNECT("u_dmac_ahb.hready_mst"	, "dmac_hready"	);
//	&CONNECT("u_dmac_ahb.hresp_mst"	, "dmac_hresp"	);
//	&CONNECT("u_dmac_ahb.hsize_mst"	, "dmac_hsize"	);
//	&CONNECT("u_dmac_ahb.htrans_mst"	, "dmac_htrans"	);
//	&CONNECT("u_dmac_ahb.hwdata_mst"	, "dmac_hwdata"	);
//	&CONNECT("u_dmac_ahb.hwrite_mst"	, "dmac_hwrite"	);
// 	#------ DAMC300 AXI dangler signals ------#
//	&DANGLER("dmac0_arid_3bit"	);
//	&DANGLER("dmac0_awid_3bit"	);
//	&DANGLER("dmac0_bid_3bit"	);
//	&DANGLER("dmac0_rid_3bit"	);
//	&DANGLER("dmac1_arid_3bit"	);
//	&DANGLER("dmac1_awid_3bit"	);
//	&DANGLER("dmac1_bid_3bit"	);
//	&DANGLER("dmac1_rid_3bit"	);
//	&IFDEF("AE350_DMA_AXI_SUPPORT");
//	&FORCE("output", "dmac0_arid[(DMAC_ID_WIDTH-1):0]"	);
//	&FORCE("output", "dmac0_awid[(DMAC_ID_WIDTH-1):0]"	);
//	&FORCE("input",  "dmac0_bid[(DMAC_ID_WIDTH-1):0]"		);
//	&FORCE("input",  "dmac0_rid[(DMAC_ID_WIDTH-1):0]"		);
//	&IFDEF("ATCDMAC300_DUAL_MASTER_IF_SUPPORT");
//	&FORCE("output", "dmac1_arid[(DMAC_ID_WIDTH-1):0]"	);
//	&FORCE("output", "dmac1_awid[(DMAC_ID_WIDTH-1):0]"	);
//	&FORCE("input",  "dmac1_bid[(DMAC_ID_WIDTH-1):0]"		);
//	&FORCE("input",  "dmac1_rid[(DMAC_ID_WIDTH-1):0]"		);
//	&ENDIF("ATCDMAC300_DUAL_MASTER_IF_SUPPORT");
//	&ENDIF("AE350_DMA_AXI_SUPPORT");
// :	`ifdef AE350_DMA_AXI_SUPPORT
// :		assign dmac0_arid = {{(DMAC_ID_WIDTH-3){1'b0}}, dmac0_arid_3bit};
// :		assign dmac0_awid = {{(DMAC_ID_WIDTH-3){1'b0}}, dmac0_awid_3bit};
// :		assign dmac0_bid_3bit = dmac0_bid[2:0];
// :		assign dmac0_rid_3bit = dmac0_rid[2:0];
// :		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :		assign dmac1_arid = {{(DMAC_ID_WIDTH-3){1'b0}}, dmac1_arid_3bit};
// :		assign dmac1_awid = {{(DMAC_ID_WIDTH-3){1'b0}}, dmac1_awid_3bit};
// :		assign dmac1_bid_3bit = dmac1_bid[2:0];
// :		assign dmac1_rid_3bit = dmac1_rid[2:0];
// :		`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :	`endif // AE350_DMA_AXI_SUPPORT
//
// #------ $APB_SLV_SSP ------#
// $i = $APB_SLV_SSP;
// &IFDEF("AE350_SSP_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atfssp020/hdl/atfssp020.v", "u_ssp");
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_ssp.prdata_r"	, "ps${i}_prdata"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "1'b1"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "u_ssp.psel"		, "ps${i}_psel"	);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "1'b0"	);
// &ENDIF("AE350_SSP_SUPPORT");
//	&CONNECT("u_ssp.PCLK"			, "pclk"	);
//	&CONNECT("u_ssp.SSPCLK"			, "sspclk"	);
//	&CONNECT("u_ssp.PRSTn"			, "presetn"	);
//	&CONNECT("u_ssp.pbe"			, "4'hf"	);
//	&CONNECT("u_ssp.sclk_in"		, "T_ssp_sclk_in"	);
//	&CONNECT("u_ssp.fs_in"			, "T_ssp_fs_in"	);
//	&CONNECT("u_ssp.rxd"			, "T_ssp_rxd"	);
//	&CONNECT("u_ssp.sclk_out_r"		, "ssp_sclk_out"	);
//	&CONNECT("u_ssp.fs_out_r"		, "ssp_fs_out"	);
//	&CONNECT("u_ssp.ssp_rxd_oe"		, "/* NC */"	);
//	&CONNECT("u_ssp.rxd_out_r"		, "/* NC */"	);
//	&CONNECT("u_ssp.ac97_resetn_r"		, "ssp_ac97_resetn"	);
//	&CONNECT("u_ssp.txd_r"			, "ssp_txd"	);
//	&CONNECT("u_ssp.txd_oe_r"		, "ssp_txd_oe"	);
//	&CONNECT("u_ssp.ssp_ffmt"		, "/* NC */"	);
//
// #------ $APB_SLV_DTROM ------#
// $i = $APB_SLV_DTROM;
// &IFDEF("ATCAPBBRG100_SLV_14");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/sample_dtrom/hdl/sample_dtrom.v", "u_dtrom", {
//     MEM_SIZE_KB 		=> DTROM_SIZE_KB,
// });
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "u_dtrom.prdata"	, "ps${i}_prdata"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "u_dtrom.pready"	, "ps${i}_pready"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "u_dtrom.psel"	, "ps${i}_psel"		);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "u_dtrom.pslverr"	, "ps${i}_pslverr"	);
//	&CONNECT("u_dtrom.paddr"		, "paddr[19:0]"	);
// &ENDIF("ATCAPBBRG100_SLV_14");
//
// #------ Unused port ------#
// for $i (15..19, 27..31) {
//	&CONNECT("u_ahb2apb.ps${i}_prdata"	, "32'h0"	);
//	&CONNECT("u_ahb2apb.ps${i}_pready"	, "1'b1"	);
//	&CONNECT("u_ahb2apb.ps${i}_psel"	, "/* NC */"	);
//	&CONNECT("u_ahb2apb.ps${i}_pslverr"	, "1'b0"	);
// }
//
// #------ DMA connection ------#
//	&CONNECT("u_spi1.spi_tx_dma_ack",	"dma_ack[0]");
//	&CONNECT("u_spi1.spi_rx_dma_ack",	"dma_ack[1]");
//	&CONNECT("u_spi2.spi_tx_dma_ack",	"dma_ack[2]");
//	&CONNECT("u_spi2.spi_rx_dma_ack",	"dma_ack[3]");
//	&CONNECT("u_uart1.dma_tx_ack",		"dma_ack[4]");
//	&CONNECT("u_uart1.dma_rx_ack",		"dma_ack[5]");
//	&CONNECT("u_uart2.dma_tx_ack",		"dma_ack[6]");
//	&CONNECT("u_uart2.dma_rx_ack",		"dma_ack[7]");
//	&CONNECT("u_i2c.dma_ack",		"dma_ack[8]");
//	&CONNECT("u_sdc.sdc_dma_ack",		"dma_ack[9]");
//	&CONNECT("u_ssp.ssp_txdmagnt",		"dma_ack[14]");
//	&CONNECT("u_ssp.ssp_rxdmagnt",		"dma_ack[15]");
//	# CF1
//	&CONNECT("u_spi3.spi_tx_dma_ack",	"dma_ack[9]");
//	&CONNECT("u_spi3.spi_rx_dma_ack",	"dma_ack[10]");
//	&CONNECT("u_spi4.spi_tx_dma_ack",	"dma_ack[11]");
//	&CONNECT("u_spi4.spi_rx_dma_ack",	"dma_ack[12]");
//	&CONNECT("u_i2c2.dma_ack",		"dma_ack[13]");
//
//	&CONNECT("u_spi1.spi_tx_dma_req",	"dmareq_spi1_tx");
//	&CONNECT("u_spi1.spi_rx_dma_req",	"dmareq_spi1_rx");
//	&CONNECT("u_spi2.spi_tx_dma_req",	"dmareq_spi2_tx");
//	&CONNECT("u_spi2.spi_rx_dma_req",	"dmareq_spi2_rx");
//	&CONNECT("u_uart1.dma_tx_req",		"dmareqn_uart1_tx");
//	&CONNECT("u_uart1.dma_rx_req",		"dmareqn_uart1_rx");
//	&CONNECT("u_uart2.dma_tx_req",		"dmareqn_uart2_tx");
//	&CONNECT("u_uart2.dma_rx_req",		"dmareqn_uart2_rx");
//	&CONNECT("u_i2c.dma_req",		"dmareq_i2c");
//	&CONNECT("u_sdc.sdc_dma_req",		"dmareq_sdc");
//	&CONNECT("u_ssp.ssp_txdmareq_r",	"dmareq_ssp_tx");
//	&CONNECT("u_ssp.ssp_rxdmareq_r",	"dmareq_ssp_rx");
//	&CONNECT("u_i2c2.dma_req",		"dmareq_i2c2");
//
// :`ifdef AE350_DMA_SUPPORT
// :`else
// :   assign dma_ack = 16'h0;
// :`endif //AE350_DMA_SUPPORT
// :
// :`ifdef NDS_BOARD_CF1
// :assign dma_req = \{2'b0, dmareq_i2c2, dmareq_spi4_rx, dmareq_spi4_tx, dmareq_spi3_rx, dmareq_spi3_tx,
// :			dmareq_i2c, dmareqn_uart2_rx, dmareqn_uart2_tx, dmareqn_uart1_rx, dmareqn_uart1_tx, dmareq_spi2_rx, dmareq_spi2_tx, dmareq_spi1_rx, dmareq_spi1_tx\};
// :`else	// !NDS_BOARD_CF1
// :assign dma_req = \{ dmareq_ssp_rx, dmareq_ssp_tx, 4'h0, dmareq_sdc,
// :			dmareq_i2c, dmareqn_uart2_rx, dmareqn_uart2_tx, dmareqn_uart1_rx, dmareqn_uart1_tx, dmareq_spi2_rx, dmareq_spi2_tx, dmareq_spi1_rx, dmareq_spi1_tx\};
// :`endif	// !NDS_BOARD_CF1
//
// #------ Interrupt connection ------#
// &CONNECT("u_wdt.wdt_int",		"wdt_int");	# 0
// &CONNECT("u_pit.pit_intr",		"pit_intr");	# 3
// &CONNECT("u_spi1.spi_boot_intr",	"spi1_int");	# 4
// &CONNECT("u_spi2.spi_boot_intr",	"spi2_int");	# 5
// &CONNECT("u_i2c.i2c_int",		"i2c_int");	# 6
// &CONNECT("u_gpio.gpio_intr",		"gpio_intr");	# 7
// &CONNECT("u_uart1.uart_intr",	"uart1_int");	# 8
// &CONNECT("u_uart2.uart_intr",	"uart2_int");	# 9
// &CONNECT("u_dmac_axi.dma_int",	"dma_int");	# 10-1
// &CONNECT("u_dmac_ahb.dma_int",	"dma_int");	# 10-2
// &CONNECT("u_ssp.ssp_intr",		"ssp_intr");	# 17
// &CONNECT("u_sdc.sdc_intr",		"sdc_int");	# 18
//
// # CF1
// for ($i = 0; $i < 4; $i++) {
//   $j = 2 + $i;
//   :`ifdef AE350_PIT${j}_SUPPORT
//   :`else	// !AE350_PIT${j}_SUPPORT
//   :assign pit${j}_int = 1'b0;
//   :`endif	// !AE350_PIT${j}_SUPPORT
// }
// &CONNECT("u_spi3.spi_boot_intr",	"spi3_int");
// &CONNECT("u_spi4.spi_boot_intr",	"spi4_int");
// &CONNECT("u_i2c2.i2c_int",		"i2c2_int");
// &CONNECT("u_pit2.pit_intr",		"pit2_int");
// &CONNECT("u_pit3.pit_intr",		"pit3_int");
// &CONNECT("u_pit4.pit_intr",		"pit4_int");
// &CONNECT("u_pit5.pit_intr",		"pit5_int");
//
// &ENDMODULE
// VPERL_END

// VPERL_GENERATED_BEGIN
module ae350_apb_subsystem (
`ifdef AE350_RTC_SUPPORT
	  rtc_prdata,        // (u_ahb2apb) <= ()
	  rtc_pready,        // (u_ahb2apb) <= ()
	  rtc_psel,          // (u_ahb2apb) => ()
	  rtc_pslverr,       // (u_ahb2apb) <= ()
`endif // AE350_RTC_SUPPORT
`ifdef AE350_UART1_SUPPORT
	  pclk_uart1,        // (u_uart1) <= ()
	  uart1_ctsn,        // (u_uart1) <= ()
	  uart1_dcdn,        // (u_uart1) <= ()
	  uart1_dsrn,        // (u_uart1) <= ()
	  uart1_dtrn,        // (u_uart1) => ()
	  uart1_out1n,       // (u_uart1) => ()
	  uart1_out2n,       // (u_uart1) => ()
	  uart1_rin,         // (u_uart1) <= ()
	  uart1_rtsn,        // (u_uart1) => ()
	  uart1_rxd,         // (u_uart1) <= ()
	  uart1_txd,         // (u_uart1) => ()
`endif // AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
	  pclk_uart2,        // (u_uart2) <= ()
	  uart2_ctsn,        // (u_uart2) <= ()
	  uart2_dcdn,        // (u_uart2) <= ()
	  uart2_dsrn,        // (u_uart2) <= ()
	  uart2_dtrn,        // (u_uart2) => ()
	  uart2_out1n,       // (u_uart2) => ()
	  uart2_out2n,       // (u_uart2) => ()
	  uart2_rin,         // (u_uart2) <= ()
	  uart2_rtsn,        // (u_uart2) => ()
	  uart2_rxd,         // (u_uart2) <= ()
	  uart2_txd,         // (u_uart2) => ()
`endif // AE350_UART2_SUPPORT
`ifdef AE350_PIT_SUPPORT
	  ch0_pwm,           // (u_pit) => ()
	  ch0_pwmoe,         // (u_pit) => ()
	  pclk_pit,          // (u_pit) <= ()
`endif // AE350_PIT_SUPPORT
`ifdef AE350_PIT2_SUPPORT
	  pit2_ch0_pwm,      // (u_pit2) => ()
	  pit2_ch0_pwmoe,    // (u_pit2) => ()
`endif // AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
	  pit3_ch0_pwm,      // (u_pit3) => ()
	  pit3_ch0_pwmoe,    // (u_pit3) => ()
`endif // AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
	  pit4_ch0_pwm,      // (u_pit4) => ()
	  pit4_ch0_pwmoe,    // (u_pit4) => ()
`endif // AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
	  pit5_ch0_pwm,      // (u_pit5) => ()
	  pit5_ch0_pwmoe,    // (u_pit5) => ()
`endif // AE350_PIT5_SUPPORT
`ifdef AE350_WDT_SUPPORT
	  pclk_wdt,          // (u_wdt) <= ()
`endif // AE350_WDT_SUPPORT
`ifdef AE350_GPIO_SUPPORT
	  gpio_in,           // (u_gpio) <= ()
	  gpio_oe,           // (u_gpio) => ()
	  gpio_out,          // (u_gpio) => ()
	  pclk_gpio,         // (u_gpio) <= ()
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_I2C_SUPPORT
	  i2c_scl,           // (u_i2c) => ()
	  i2c_scl_in,        // (u_i2c) <= ()
	  i2c_sda,           // (u_i2c) => ()
	  i2c_sda_in,        // (u_i2c) <= ()
`endif // AE350_I2C_SUPPORT
`ifdef AE350_I2C2_SUPPORT
	  i2c2_scl,          // (u_i2c2) => ()
	  i2c2_scl_in,       // (u_i2c2) <= ()
	  i2c2_sda,          // (u_i2c2) => ()
	  i2c2_sda_in,       // (u_i2c2) <= ()
`endif // AE350_I2C2_SUPPORT
`ifdef AE350_SPI1_SUPPORT
	  spi1_clk_in,       // (u_spi1) <= ()
	  spi1_clk_oe,       // (u_spi1) => ()
	  spi1_clk_out,      // (u_spi1) => ()
	  spi1_csn_oe,       // (u_spi1) => ()
	  spi1_csn_out,      // (u_spi1) => ()
	  spi1_miso_in,      // (u_spi1) <= ()
	  spi1_miso_oe,      // (u_spi1) => ()
	  spi1_miso_out,     // (u_spi1) => ()
	  spi1_mosi_in,      // (u_spi1) <= ()
	  spi1_mosi_oe,      // (u_spi1) => ()
	  spi1_mosi_out,     // (u_spi1) => ()
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
	  spi2_clk_in,       // (u_spi2) <= ()
	  spi2_clk_oe,       // (u_spi2) => ()
	  spi2_clk_out,      // (u_spi2) => ()
	  spi2_csn_oe,       // (u_spi2) => ()
	  spi2_csn_out,      // (u_spi2) => ()
	  spi2_miso_in,      // (u_spi2) <= ()
	  spi2_miso_oe,      // (u_spi2) => ()
	  spi2_miso_out,     // (u_spi2) => ()
	  spi2_mosi_in,      // (u_spi2) <= ()
	  spi2_mosi_oe,      // (u_spi2) => ()
	  spi2_mosi_out,     // (u_spi2) => ()
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
	  spi3_clk_in,       // (u_spi3) <= ()
	  spi3_clk_oe,       // (u_spi3) => ()
	  spi3_clk_out,      // (u_spi3) => ()
	  spi3_csn_oe,       // (u_spi3) => ()
	  spi3_csn_out,      // (u_spi3) => ()
	  spi3_miso_in,      // (u_spi3) <= ()
	  spi3_miso_oe,      // (u_spi3) => ()
	  spi3_miso_out,     // (u_spi3) => ()
	  spi3_mosi_in,      // (u_spi3) <= ()
	  spi3_mosi_oe,      // (u_spi3) => ()
	  spi3_mosi_out,     // (u_spi3) => ()
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
	  spi4_clk_in,       // (u_spi4) <= ()
	  spi4_clk_oe,       // (u_spi4) => ()
	  spi4_clk_out,      // (u_spi4) => ()
	  spi4_csn_oe,       // (u_spi4) => ()
	  spi4_csn_out,      // (u_spi4) => ()
	  spi4_miso_in,      // (u_spi4) <= ()
	  spi4_miso_oe,      // (u_spi4) => ()
	  spi4_miso_out,     // (u_spi4) => ()
	  spi4_mosi_in,      // (u_spi4) <= ()
	  spi4_mosi_oe,      // (u_spi4) => ()
	  spi4_mosi_out,     // (u_spi4) => ()
`endif // AE350_SPI4_SUPPORT
`ifdef AE350_SDC_SUPPORT
	  T_sd_cd,           // (u_sdc) <= ()
	  T_sd_dat0_in,      // (u_sdc) <= ()
	  T_sd_dat1_in,      // (u_sdc) <= ()
	  T_sd_dat2_in,      // (u_sdc) <= ()
	  T_sd_dat3_in,      // (u_sdc) <= ()
	  T_sd_rsp,          // (u_sdc) <= ()
	  T_sd_wp,           // (u_sdc) <= ()
	  sd_clk,            // (u_sdc) => ()
	  sd_cmd,            // (u_sdc) => ()
	  sd_cmd_oe,         // (u_sdc) => ()
	  sd_dat0_oe,        // (u_sdc) => ()
	  sd_dat0_out,       // (u_sdc) => ()
	  sd_dat1_oe,        // (u_sdc) => ()
	  sd_dat1_out,       // (u_sdc) => ()
	  sd_dat2_oe,        // (u_sdc) => ()
	  sd_dat2_out,       // (u_sdc) => ()
	  sd_dat3_oe,        // (u_sdc) => ()
	  sd_dat3_out,       // (u_sdc) => ()
	  sd_power,          // (u_sdc) => ()
	  sdc_clk,           // (u_sdc) <= ()
`endif // AE350_SDC_SUPPORT
`ifdef AE350_DMA_AXI_SUPPORT
	  dmac0_arid,        // () => ()
	  dmac0_awid,        // () => ()
	  dmac0_bid,         // () <= ()
	  dmac0_rid,         // () <= ()
	  aclk,              // (u_dmac_axi) <= ()
	  aresetn,           // (u_dmac_axi) <= ()
	  dmac0_araddr,      // (u_dmac_axi) => ()
	  dmac0_arburst,     // (u_dmac_axi) => ()
	  dmac0_arcache,     // (u_dmac_axi) => ()
	  dmac0_arlen,       // (u_dmac_axi) => ()
	  dmac0_arlock,      // (u_dmac_axi) => ()
	  dmac0_arprot,      // (u_dmac_axi) => ()
	  dmac0_arready,     // (u_dmac_axi) <= ()
	  dmac0_arsize,      // (u_dmac_axi) => ()
	  dmac0_arvalid,     // (u_dmac_axi) => ()
	  dmac0_awaddr,      // (u_dmac_axi) => ()
	  dmac0_awburst,     // (u_dmac_axi) => ()
	  dmac0_awcache,     // (u_dmac_axi) => ()
	  dmac0_awlen,       // (u_dmac_axi) => ()
	  dmac0_awlock,      // (u_dmac_axi) => ()
	  dmac0_awprot,      // (u_dmac_axi) => ()
	  dmac0_awready,     // (u_dmac_axi) <= ()
	  dmac0_awsize,      // (u_dmac_axi) => ()
	  dmac0_awvalid,     // (u_dmac_axi) => ()
	  dmac0_bready,      // (u_dmac_axi) => ()
	  dmac0_bresp,       // (u_dmac_axi) <= ()
	  dmac0_bvalid,      // (u_dmac_axi) <= ()
	  dmac0_rdata,       // (u_dmac_axi) <= ()
	  dmac0_rlast,       // (u_dmac_axi) <= ()
	  dmac0_rready,      // (u_dmac_axi) => ()
	  dmac0_rresp,       // (u_dmac_axi) <= ()
	  dmac0_rvalid,      // (u_dmac_axi) <= ()
	  dmac0_wdata,       // (u_dmac_axi) => ()
	  dmac0_wlast,       // (u_dmac_axi) => ()
	  dmac0_wready,      // (u_dmac_axi) <= ()
	  dmac0_wstrb,       // (u_dmac_axi) => ()
	  dmac0_wvalid,      // (u_dmac_axi) => ()
`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_DMA_AHB_SUPPORT
	  dmac_haddr,        // (u_dmac_ahb) => ()
	  dmac_hburst,       // (u_dmac_ahb) => ()
	  dmac_hprot,        // (u_dmac_ahb) => ()
	  dmac_hrdata,       // (u_dmac_ahb) <= ()
	  dmac_hready,       // (u_dmac_ahb) <= ()
	  dmac_hresp,        // (u_dmac_ahb) <= ()
	  dmac_hsize,        // (u_dmac_ahb) => ()
	  dmac_htrans,       // (u_dmac_ahb) => ()
	  dmac_hwdata,       // (u_dmac_ahb) => ()
	  dmac_hwrite,       // (u_dmac_ahb) => ()
`endif // AE350_DMA_AHB_SUPPORT
`ifdef AE350_SSP_SUPPORT
	  T_ssp_fs_in,       // (u_ssp) <= ()
	  T_ssp_rxd,         // (u_ssp) <= ()
	  T_ssp_sclk_in,     // (u_ssp) <= ()
	  ssp_fs_oe,         // (u_ssp) => ()
	  ssp_fs_out,        // (u_ssp) => ()
	  ssp_rstn,          // (u_ssp) <= ()
	  ssp_sclk_oe,       // (u_ssp) => ()
	  ssp_sclk_out,      // (u_ssp) => ()
	  ssp_txd,           // (u_ssp) => ()
	  ssp_txd_oe,        // (u_ssp) => ()
	  sspclk,            // (u_ssp) <= ()
`endif // AE350_SSP_SUPPORT
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
	  ch1_pwm,           // (u_pit) => ()
	  ch1_pwmoe,         // (u_pit) => ()
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	  ch2_pwm,           // (u_pit) => ()
	  ch2_pwmoe,         // (u_pit) => ()
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	  ch3_pwm,           // (u_pit) => ()
	  ch3_pwmoe,         // (u_pit) => ()
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT_SUPPORT
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE350_PIT2_SUPPORT
	  pit2_ch1_pwm,      // (u_pit2) => ()
	  pit2_ch1_pwmoe,    // (u_pit2) => ()
   `endif // AE350_PIT2_SUPPORT
`endif // ATCPIT100_CH1_SUPPORT
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE350_PIT2_SUPPORT
	  pit2_ch2_pwm,      // (u_pit2) => ()
	  pit2_ch2_pwmoe,    // (u_pit2) => ()
   `endif // AE350_PIT2_SUPPORT
`endif // ATCPIT100_CH2_SUPPORT
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE350_PIT2_SUPPORT
	  pit2_ch3_pwm,      // (u_pit2) => ()
	  pit2_ch3_pwmoe,    // (u_pit2) => ()
   `endif // AE350_PIT2_SUPPORT
`endif // ATCPIT100_CH3_SUPPORT
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE350_PIT3_SUPPORT
	  pit3_ch1_pwm,      // (u_pit3) => ()
	  pit3_ch1_pwmoe,    // (u_pit3) => ()
   `endif // AE350_PIT3_SUPPORT
`endif // ATCPIT100_CH1_SUPPORT
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE350_PIT3_SUPPORT
	  pit3_ch2_pwm,      // (u_pit3) => ()
	  pit3_ch2_pwmoe,    // (u_pit3) => ()
   `endif // AE350_PIT3_SUPPORT
`endif // ATCPIT100_CH2_SUPPORT
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE350_PIT3_SUPPORT
	  pit3_ch3_pwm,      // (u_pit3) => ()
	  pit3_ch3_pwmoe,    // (u_pit3) => ()
   `endif // AE350_PIT3_SUPPORT
`endif // ATCPIT100_CH3_SUPPORT
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE350_PIT4_SUPPORT
	  pit4_ch1_pwm,      // (u_pit4) => ()
	  pit4_ch1_pwmoe,    // (u_pit4) => ()
   `endif // AE350_PIT4_SUPPORT
`endif // ATCPIT100_CH1_SUPPORT
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE350_PIT4_SUPPORT
	  pit4_ch2_pwm,      // (u_pit4) => ()
	  pit4_ch2_pwmoe,    // (u_pit4) => ()
   `endif // AE350_PIT4_SUPPORT
`endif // ATCPIT100_CH2_SUPPORT
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE350_PIT4_SUPPORT
	  pit4_ch3_pwm,      // (u_pit4) => ()
	  pit4_ch3_pwmoe,    // (u_pit4) => ()
   `endif // AE350_PIT4_SUPPORT
`endif // ATCPIT100_CH3_SUPPORT
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE350_PIT5_SUPPORT
	  pit5_ch1_pwm,      // (u_pit5) => ()
	  pit5_ch1_pwmoe,    // (u_pit5) => ()
   `endif // AE350_PIT5_SUPPORT
`endif // ATCPIT100_CH1_SUPPORT
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE350_PIT5_SUPPORT
	  pit5_ch2_pwm,      // (u_pit5) => ()
	  pit5_ch2_pwmoe,    // (u_pit5) => ()
   `endif // AE350_PIT5_SUPPORT
`endif // ATCPIT100_CH2_SUPPORT
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE350_PIT5_SUPPORT
	  pit5_ch3_pwm,      // (u_pit5) => ()
	  pit5_ch3_pwmoe,    // (u_pit5) => ()
   `endif // AE350_PIT5_SUPPORT
`endif // ATCPIT100_CH3_SUPPORT
`ifdef AE350_GPIO_SUPPORT
   `ifdef ATCGPIO100_PULL_SUPPORT
	  gpio_pulldown,     // (u_gpio) => ()
	  gpio_pullup,       // (u_gpio) => ()
   `endif // ATCGPIO100_PULL_SUPPORT
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_REG_APB
	  pclk_spi1,         // (u_spi1) <= ()
   `endif // ATCSPI200_REG_APB
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	  spi_mem_haddr,     // (u_spi1) <= ()
	  spi_mem_hrdata,    // (u_spi1) => ()
	  spi_mem_hready,    // (u_spi1) <= ()
	  spi_mem_hreadyout, // (u_spi1) => ()
	  spi_mem_hresp,     // (u_spi1) => ()
	  spi_mem_hsel,      // (u_spi1) <= ()
	  spi_mem_htrans,    // (u_spi1) <= ()
	  spi_mem_hwrite,    // (u_spi1) <= ()
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
	  spi1_csn_in,       // (u_spi1) <= ()
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  spi1_holdn_in,     // (u_spi1) <= ()
	  spi1_holdn_oe,     // (u_spi1) => ()
	  spi1_holdn_out,    // (u_spi1) => ()
	  spi1_wpn_in,       // (u_spi1) <= ()
	  spi1_wpn_oe,       // (u_spi1) => ()
	  spi1_wpn_out,      // (u_spi1) => ()
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI1_SUPPORT
`ifdef ATCSPI200_REG_APB
   `ifdef AE350_SPI2_SUPPORT
	  pclk_spi2,         // (u_spi2) <= ()
   `endif // AE350_SPI2_SUPPORT
`endif // ATCSPI200_REG_APB
`ifdef ATCSPI200_SLAVE_SUPPORT
   `ifdef AE350_SPI2_SUPPORT
	  spi2_csn_in,       // (u_spi2) <= ()
   `endif // AE350_SPI2_SUPPORT
`endif // ATCSPI200_SLAVE_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE350_SPI2_SUPPORT
	  spi2_holdn_in,     // (u_spi2) <= ()
	  spi2_holdn_oe,     // (u_spi2) => ()
	  spi2_holdn_out,    // (u_spi2) => ()
	  spi2_wpn_in,       // (u_spi2) <= ()
	  spi2_wpn_oe,       // (u_spi2) => ()
	  spi2_wpn_out,      // (u_spi2) => ()
   `endif // AE350_SPI2_SUPPORT
`endif // ATCSPI200_QUADSPI_SUPPORT
`ifdef ATCSPI200_SLAVE_SUPPORT
   `ifdef AE350_SPI3_SUPPORT
	  spi3_csn_in,       // (u_spi3) <= ()
   `endif // AE350_SPI3_SUPPORT
`endif // ATCSPI200_SLAVE_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE350_SPI3_SUPPORT
	  spi3_holdn_in,     // (u_spi3) <= ()
	  spi3_holdn_oe,     // (u_spi3) => ()
	  spi3_holdn_out,    // (u_spi3) => ()
	  spi3_wpn_in,       // (u_spi3) <= ()
	  spi3_wpn_oe,       // (u_spi3) => ()
	  spi3_wpn_out,      // (u_spi3) => ()
   `endif // AE350_SPI3_SUPPORT
`endif // ATCSPI200_QUADSPI_SUPPORT
`ifdef ATCSPI200_SLAVE_SUPPORT
   `ifdef AE350_SPI4_SUPPORT
	  spi4_csn_in,       // (u_spi4) <= ()
   `endif // AE350_SPI4_SUPPORT
`endif // ATCSPI200_SLAVE_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE350_SPI4_SUPPORT
	  spi4_holdn_in,     // (u_spi4) <= ()
	  spi4_holdn_oe,     // (u_spi4) => ()
	  spi4_holdn_out,    // (u_spi4) => ()
	  spi4_wpn_in,       // (u_spi4) <= ()
	  spi4_wpn_oe,       // (u_spi4) => ()
	  spi4_wpn_out,      // (u_spi4) => ()
   `endif // AE350_SPI4_SUPPORT
`endif // ATCSPI200_QUADSPI_SUPPORT
`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	  dmac1_arid,        // () => ()
	  dmac1_awid,        // () => ()
	  dmac1_bid,         // () <= ()
	  dmac1_rid,         // () <= ()
	  dmac1_araddr,      // (u_dmac_axi) => ()
	  dmac1_arburst,     // (u_dmac_axi) => ()
	  dmac1_arcache,     // (u_dmac_axi) => ()
	  dmac1_arlen,       // (u_dmac_axi) => ()
	  dmac1_arlock,      // (u_dmac_axi) => ()
	  dmac1_arprot,      // (u_dmac_axi) => ()
	  dmac1_arready,     // (u_dmac_axi) <= ()
	  dmac1_arsize,      // (u_dmac_axi) => ()
	  dmac1_arvalid,     // (u_dmac_axi) => ()
	  dmac1_awaddr,      // (u_dmac_axi) => ()
	  dmac1_awburst,     // (u_dmac_axi) => ()
	  dmac1_awcache,     // (u_dmac_axi) => ()
	  dmac1_awlen,       // (u_dmac_axi) => ()
	  dmac1_awlock,      // (u_dmac_axi) => ()
	  dmac1_awprot,      // (u_dmac_axi) => ()
	  dmac1_awready,     // (u_dmac_axi) <= ()
	  dmac1_awsize,      // (u_dmac_axi) => ()
	  dmac1_awvalid,     // (u_dmac_axi) => ()
	  dmac1_bready,      // (u_dmac_axi) => ()
	  dmac1_bresp,       // (u_dmac_axi) <= ()
	  dmac1_bvalid,      // (u_dmac_axi) <= ()
	  dmac1_rdata,       // (u_dmac_axi) <= ()
	  dmac1_rlast,       // (u_dmac_axi) <= ()
	  dmac1_rready,      // (u_dmac_axi) => ()
	  dmac1_rresp,       // (u_dmac_axi) <= ()
	  dmac1_rvalid,      // (u_dmac_axi) <= ()
	  dmac1_wdata,       // (u_dmac_axi) => ()
	  dmac1_wlast,       // (u_dmac_axi) => ()
	  dmac1_wready,      // (u_dmac_axi) <= ()
	  dmac1_wstrb,       // (u_dmac_axi) => ()
	  dmac1_wvalid,      // (u_dmac_axi) => ()
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_SSP_SUPPORT
   `ifdef ATFSSP020_AC97_FUNCTION
	  ssp_ac97_resetn,   // (u_ssp) => ()
   `endif // ATFSSP020_AC97_FUNCTION
`endif // AE350_SSP_SUPPORT
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	  spi1_csn_in,       // (u_spi1) <= ()
      `endif // ATCSPI200_DIRECT_IO_SUPPORT
   `endif // ATCSPI200_SLAVE_SUPPORT
`endif // AE350_SPI1_SUPPORT
`ifdef ATCSPI200_AHBBUS_EXIST
`else
   `ifdef ATCSPI200_EILMBUS_EXIST
      `ifdef ATCSPI200_REG_APB
	  apb2core_clken,    // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
      `endif // ATCSPI200_REG_APB
   `endif // ATCSPI200_EILMBUS_EXIST
`endif // ATCSPI200_AHBBUS_EXIST
`ifdef ATCSPI200_SLAVE_SUPPORT
`else
   `ifdef ATCSPI200_DIRECT_IO_SUPPORT
      `ifdef AE350_SPI2_SUPPORT
	  spi2_csn_in,       // (u_spi2) <= ()
      `endif // AE350_SPI2_SUPPORT
      `ifdef AE350_SPI3_SUPPORT
	  spi3_csn_in,       // (u_spi3) <= ()
      `endif // AE350_SPI3_SUPPORT
      `ifdef AE350_SPI4_SUPPORT
	  spi4_csn_in,       // (u_spi4) <= ()
      `endif // AE350_SPI4_SUPPORT
   `endif // ATCSPI200_DIRECT_IO_SUPPORT
`endif // ATCSPI200_SLAVE_SUPPORT
	  ahb2apb_haddr,     // (u_ahb2apb) <= ()
	  ahb2apb_hprot,     // (u_ahb2apb) <= ()
	  ahb2apb_hrdata,    // (u_ahb2apb) => ()
	  ahb2apb_hready,    // (u_ahb2apb) => ()
	  ahb2apb_hready_in, // (u_ahb2apb) <= ()
	  ahb2apb_hresp,     // (u_ahb2apb) => ()
	  ahb2apb_hsel,      // (u_ahb2apb) <= ()
	  ahb2apb_hsize,     // (u_ahb2apb) <= ()
	  ahb2apb_htrans,    // (u_ahb2apb) <= ()
	  ahb2apb_hwdata,    // (u_ahb2apb) <= ()
	  ahb2apb_hwrite,    // (u_ahb2apb) <= ()
	  paddr,             // (u_ahb2apb) => (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt)
	  penable,           // (u_ahb2apb) => (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt)
	  pwdata,            // (u_ahb2apb) => (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt)
	  pwrite,            // (u_ahb2apb) => (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt)
	  smu_prdata,        // (u_ahb2apb) <= ()
	  smu_pready,        // (u_ahb2apb) <= ()
	  smu_psel,          // (u_ahb2apb) => ()
	  smu_pslverr,       // (u_ahb2apb) <= ()
	  pclk,              // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_dtrom,u_sdc,u_ssp) <= ()
	  presetn,           // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	  hclk,              // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	  hresetn,           // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	  apb2ahb_clken,     // (u_ahb2apb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	  dma_int,           // (u_dmac_ahb,u_dmac_axi) => ()
	  gpio_intr,         // (u_gpio) => ()
	  extclk,            // (u_gpio,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_wdt) <= ()
	  i2c_int,           // (u_i2c) => ()
	  pclk_i2c,          // (u_i2c,u_i2c2) <= ()
	  i2c2_int,          // (u_i2c2) => ()
	  pit_intr,          // (u_pit) => ()
	  pit2_int,          // (u_pit2) => ()
	  pit3_int,          // (u_pit3) => ()
	  pit4_int,          // (u_pit4) => ()
	  pit5_int,          // (u_pit5) => ()
	  sdc_int,           // (u_sdc) => ()
	  spi1_int,          // (u_spi1) => ()
	  scan_enable,       // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	  scan_test,         // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	  spi_clk,           // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	  spi_rstn,          // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	  spi2_int,          // (u_spi2) => ()
	  spi3_int,          // (u_spi3) => ()
	  spi4_int,          // (u_spi4) => ()
	  ssp_intr,          // (u_ssp) => ()
	  uart1_int,         // (u_uart1) => ()
	  uart_clk,          // (u_uart1,u_uart2) <= ()
	  uart_rstn,         // (u_uart1,u_uart2) <= ()
	  uart2_int,         // (u_uart2) => ()
	  wdt_int,           // (u_wdt) => ()
	  wdt_rst            // (u_wdt) => ()
);

parameter BUS_MASTER_ADDR_WIDTH	= 32;
parameter DMAC_DATA_WIDTH		= 64;
parameter DMAC_ID_WIDTH		= 4;

localparam BUS_MASTER_ADDR_MSB	= BUS_MASTER_ADDR_WIDTH-1;
`ifdef ATCAPBBRG100_SLV_14
   `ifdef AE350_DTROM_SIZE_KB
localparam DTROM_SIZE_KB = `AE350_DTROM_SIZE_KB;
   `else
localparam DTROM_SIZE_KB = 8;
   `endif // AE350_DTROM_SIZE_KB
`endif // ATCAPBBRG100_SLV_14

`ifdef AE350_RTC_SUPPORT
input                                   [31:0] rtc_prdata;
input                                          rtc_pready;
output                                         rtc_psel;
input                                          rtc_pslverr;
`endif // AE350_RTC_SUPPORT
`ifdef AE350_UART1_SUPPORT
input                                          pclk_uart1;
input                                          uart1_ctsn;
input                                          uart1_dcdn;
input                                          uart1_dsrn;
output                                         uart1_dtrn;
output                                         uart1_out1n;
output                                         uart1_out2n;
input                                          uart1_rin;
output                                         uart1_rtsn;
input                                          uart1_rxd;
output                                         uart1_txd;
`endif // AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
input                                          pclk_uart2;
input                                          uart2_ctsn;
input                                          uart2_dcdn;
input                                          uart2_dsrn;
output                                         uart2_dtrn;
output                                         uart2_out1n;
output                                         uart2_out2n;
input                                          uart2_rin;
output                                         uart2_rtsn;
input                                          uart2_rxd;
output                                         uart2_txd;
`endif // AE350_UART2_SUPPORT
`ifdef AE350_PIT_SUPPORT
output                                         ch0_pwm;
output                                         ch0_pwmoe;
input                                          pclk_pit;           // clock domain b_clk
`endif // AE350_PIT_SUPPORT
`ifdef AE350_PIT2_SUPPORT
output                                         pit2_ch0_pwm;
output                                         pit2_ch0_pwmoe;
`endif // AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
output                                         pit3_ch0_pwm;
output                                         pit3_ch0_pwmoe;
`endif // AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
output                                         pit4_ch0_pwm;
output                                         pit4_ch0_pwmoe;
`endif // AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
output                                         pit5_ch0_pwm;
output                                         pit5_ch0_pwmoe;
`endif // AE350_PIT5_SUPPORT
`ifdef AE350_WDT_SUPPORT
input                                          pclk_wdt;           // APB clock
`endif // AE350_WDT_SUPPORT
`ifdef AE350_GPIO_SUPPORT
input           [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_in;
output          [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_oe;
output          [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_out;
input                                          pclk_gpio;
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_I2C_SUPPORT
output                                         i2c_scl;
input                                          i2c_scl_in;
output                                         i2c_sda;
input                                          i2c_sda_in;
`endif // AE350_I2C_SUPPORT
`ifdef AE350_I2C2_SUPPORT
output                                         i2c2_scl;
input                                          i2c2_scl_in;
output                                         i2c2_sda;
input                                          i2c2_sda_in;
`endif // AE350_I2C2_SUPPORT
`ifdef AE350_SPI1_SUPPORT
input                                          spi1_clk_in;
output                                         spi1_clk_oe;
output                                         spi1_clk_out;
output                                         spi1_csn_oe;
output                                         spi1_csn_out;
input                                          spi1_miso_in;
output                                         spi1_miso_oe;
output                                         spi1_miso_out;
input                                          spi1_mosi_in;
output                                         spi1_mosi_oe;
output                                         spi1_mosi_out;
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
input                                          spi2_clk_in;
output                                         spi2_clk_oe;
output                                         spi2_clk_out;
output                                         spi2_csn_oe;
output                                         spi2_csn_out;
input                                          spi2_miso_in;
output                                         spi2_miso_oe;
output                                         spi2_miso_out;
input                                          spi2_mosi_in;
output                                         spi2_mosi_oe;
output                                         spi2_mosi_out;
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
input                                          spi3_clk_in;
output                                         spi3_clk_oe;
output                                         spi3_clk_out;
output                                         spi3_csn_oe;
output                                         spi3_csn_out;
input                                          spi3_miso_in;
output                                         spi3_miso_oe;
output                                         spi3_miso_out;
input                                          spi3_mosi_in;
output                                         spi3_mosi_oe;
output                                         spi3_mosi_out;
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
input                                          spi4_clk_in;
output                                         spi4_clk_oe;
output                                         spi4_clk_out;
output                                         spi4_csn_oe;
output                                         spi4_csn_out;
input                                          spi4_miso_in;
output                                         spi4_miso_oe;
output                                         spi4_miso_out;
input                                          spi4_mosi_in;
output                                         spi4_mosi_oe;
output                                         spi4_mosi_out;
`endif // AE350_SPI4_SUPPORT
`ifdef AE350_SDC_SUPPORT
input                                          T_sd_cd;            // SD card detect
input                                          T_sd_dat0_in;       // SD data0 in
input                                          T_sd_dat1_in;       // SD data1 in
input                                          T_sd_dat2_in;       // SD data2 in
input                                          T_sd_dat3_in;       // SD data3 in
input                                          T_sd_rsp;           // for ASIC version it's 7 , for FPGA it's 8
input                                          T_sd_wp;            // SD card write protect
output                                         sd_clk;             // SD clock
output                                         sd_cmd;             // SD cmd output
output                                         sd_cmd_oe;          // SD cmd line output enable
output                                         sd_dat0_oe;         // SD data0 output enable
output                                         sd_dat0_out;        // SD data0 out
output                                         sd_dat1_oe;         // SD data1 output enable
output                                         sd_dat1_out;        // SD data1 out
output                                         sd_dat2_oe;         // SD data2 output enable
output                                         sd_dat2_out;        // SD data2 out
output                                         sd_dat3_oe;         // SD data3 output enable
output                                         sd_dat3_out;        // SD data3 out
output                                   [4:0] sd_power;           // SD power control
input                                          sdc_clk;
`endif // AE350_SDC_SUPPORT
`ifdef AE350_DMA_AXI_SUPPORT
output                   [(DMAC_ID_WIDTH-1):0] dmac0_arid;
output                   [(DMAC_ID_WIDTH-1):0] dmac0_awid;
input                    [(DMAC_ID_WIDTH-1):0] dmac0_bid;
input                    [(DMAC_ID_WIDTH-1):0] dmac0_rid;
input                                          aclk;
input                                          aresetn;
output                 [BUS_MASTER_ADDR_MSB:0] dmac0_araddr;
output                                   [1:0] dmac0_arburst;
output                                   [3:0] dmac0_arcache;
output                                   [7:0] dmac0_arlen;
output                                         dmac0_arlock;
output                                   [2:0] dmac0_arprot;
input                                          dmac0_arready;
output                                   [2:0] dmac0_arsize;
output                                         dmac0_arvalid;
output                 [BUS_MASTER_ADDR_MSB:0] dmac0_awaddr;
output                                   [1:0] dmac0_awburst;
output                                   [3:0] dmac0_awcache;
output                                   [7:0] dmac0_awlen;
output                                         dmac0_awlock;
output                                   [2:0] dmac0_awprot;
input                                          dmac0_awready;
output                                   [2:0] dmac0_awsize;
output                                         dmac0_awvalid;
output                                         dmac0_bready;
input                                    [1:0] dmac0_bresp;
input                                          dmac0_bvalid;
input                  [(DMAC_DATA_WIDTH-1):0] dmac0_rdata;
input                                          dmac0_rlast;
output                                         dmac0_rready;
input                                    [1:0] dmac0_rresp;
input                                          dmac0_rvalid;
output                 [(DMAC_DATA_WIDTH-1):0] dmac0_wdata;
output                                         dmac0_wlast;
input                                          dmac0_wready;
output             [((DMAC_DATA_WIDTH/8)-1):0] dmac0_wstrb;
output                                         dmac0_wvalid;
`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_DMA_AHB_SUPPORT
output                                  [31:0] dmac_haddr;
output                                   [2:0] dmac_hburst;
output                                   [3:0] dmac_hprot;
input       [((`ATCDMAC110_DATA_WIDTH) - 1):0] dmac_hrdata;
input                                          dmac_hready;
input                                    [1:0] dmac_hresp;
output                                   [2:0] dmac_hsize;
output                                   [1:0] dmac_htrans;
output      [((`ATCDMAC110_DATA_WIDTH) - 1):0] dmac_hwdata;
output                                         dmac_hwrite;
`endif // AE350_DMA_AHB_SUPPORT
`ifdef AE350_SSP_SUPPORT
input                                          T_ssp_fs_in;
input                                          T_ssp_rxd;
input                                          T_ssp_sclk_in;
output                                         ssp_fs_oe;
output                                         ssp_fs_out;
input                                          ssp_rstn;
output                                         ssp_sclk_oe;
output                                         ssp_sclk_out;
output                                         ssp_txd;
output                                         ssp_txd_oe;
input                                          sspclk;
`endif // AE350_SSP_SUPPORT
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
output                                         ch1_pwm;
output                                         ch1_pwmoe;
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
output                                         ch2_pwm;
output                                         ch2_pwmoe;
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
output                                         ch3_pwm;
output                                         ch3_pwmoe;
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT_SUPPORT
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE350_PIT2_SUPPORT
output                                         pit2_ch1_pwm;
output                                         pit2_ch1_pwmoe;
   `endif // AE350_PIT2_SUPPORT
`endif // ATCPIT100_CH1_SUPPORT
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE350_PIT2_SUPPORT
output                                         pit2_ch2_pwm;
output                                         pit2_ch2_pwmoe;
   `endif // AE350_PIT2_SUPPORT
`endif // ATCPIT100_CH2_SUPPORT
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE350_PIT2_SUPPORT
output                                         pit2_ch3_pwm;
output                                         pit2_ch3_pwmoe;
   `endif // AE350_PIT2_SUPPORT
`endif // ATCPIT100_CH3_SUPPORT
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE350_PIT3_SUPPORT
output                                         pit3_ch1_pwm;
output                                         pit3_ch1_pwmoe;
   `endif // AE350_PIT3_SUPPORT
`endif // ATCPIT100_CH1_SUPPORT
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE350_PIT3_SUPPORT
output                                         pit3_ch2_pwm;
output                                         pit3_ch2_pwmoe;
   `endif // AE350_PIT3_SUPPORT
`endif // ATCPIT100_CH2_SUPPORT
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE350_PIT3_SUPPORT
output                                         pit3_ch3_pwm;
output                                         pit3_ch3_pwmoe;
   `endif // AE350_PIT3_SUPPORT
`endif // ATCPIT100_CH3_SUPPORT
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE350_PIT4_SUPPORT
output                                         pit4_ch1_pwm;
output                                         pit4_ch1_pwmoe;
   `endif // AE350_PIT4_SUPPORT
`endif // ATCPIT100_CH1_SUPPORT
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE350_PIT4_SUPPORT
output                                         pit4_ch2_pwm;
output                                         pit4_ch2_pwmoe;
   `endif // AE350_PIT4_SUPPORT
`endif // ATCPIT100_CH2_SUPPORT
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE350_PIT4_SUPPORT
output                                         pit4_ch3_pwm;
output                                         pit4_ch3_pwmoe;
   `endif // AE350_PIT4_SUPPORT
`endif // ATCPIT100_CH3_SUPPORT
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE350_PIT5_SUPPORT
output                                         pit5_ch1_pwm;
output                                         pit5_ch1_pwmoe;
   `endif // AE350_PIT5_SUPPORT
`endif // ATCPIT100_CH1_SUPPORT
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE350_PIT5_SUPPORT
output                                         pit5_ch2_pwm;
output                                         pit5_ch2_pwmoe;
   `endif // AE350_PIT5_SUPPORT
`endif // ATCPIT100_CH2_SUPPORT
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE350_PIT5_SUPPORT
output                                         pit5_ch3_pwm;
output                                         pit5_ch3_pwmoe;
   `endif // AE350_PIT5_SUPPORT
`endif // ATCPIT100_CH3_SUPPORT
`ifdef AE350_GPIO_SUPPORT
   `ifdef ATCGPIO100_PULL_SUPPORT
output          [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_pulldown;
output          [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_pullup;
   `endif // ATCGPIO100_PULL_SUPPORT
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_REG_APB
input                                          pclk_spi1;
   `endif // ATCSPI200_REG_APB
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
input           [(`ATCSPI200_HADDR_WIDTH-1):0] spi_mem_haddr;
output                                  [31:0] spi_mem_hrdata;
input                                          spi_mem_hready;
output                                         spi_mem_hreadyout;
output                                   [1:0] spi_mem_hresp;
input                                          spi_mem_hsel;
input                                    [1:0] spi_mem_htrans;
input                                          spi_mem_hwrite;
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
input                                          spi1_csn_in;
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
input                                          spi1_holdn_in;
output                                         spi1_holdn_oe;
output                                         spi1_holdn_out;
input                                          spi1_wpn_in;
output                                         spi1_wpn_oe;
output                                         spi1_wpn_out;
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI1_SUPPORT
`ifdef ATCSPI200_REG_APB
   `ifdef AE350_SPI2_SUPPORT
input                                          pclk_spi2;
   `endif // AE350_SPI2_SUPPORT
`endif // ATCSPI200_REG_APB
`ifdef ATCSPI200_SLAVE_SUPPORT
   `ifdef AE350_SPI2_SUPPORT
input                                          spi2_csn_in;
   `endif // AE350_SPI2_SUPPORT
`endif // ATCSPI200_SLAVE_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE350_SPI2_SUPPORT
input                                          spi2_holdn_in;
output                                         spi2_holdn_oe;
output                                         spi2_holdn_out;
input                                          spi2_wpn_in;
output                                         spi2_wpn_oe;
output                                         spi2_wpn_out;
   `endif // AE350_SPI2_SUPPORT
`endif // ATCSPI200_QUADSPI_SUPPORT
`ifdef ATCSPI200_SLAVE_SUPPORT
   `ifdef AE350_SPI3_SUPPORT
input                                          spi3_csn_in;
   `endif // AE350_SPI3_SUPPORT
`endif // ATCSPI200_SLAVE_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE350_SPI3_SUPPORT
input                                          spi3_holdn_in;
output                                         spi3_holdn_oe;
output                                         spi3_holdn_out;
input                                          spi3_wpn_in;
output                                         spi3_wpn_oe;
output                                         spi3_wpn_out;
   `endif // AE350_SPI3_SUPPORT
`endif // ATCSPI200_QUADSPI_SUPPORT
`ifdef ATCSPI200_SLAVE_SUPPORT
   `ifdef AE350_SPI4_SUPPORT
input                                          spi4_csn_in;
   `endif // AE350_SPI4_SUPPORT
`endif // ATCSPI200_SLAVE_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE350_SPI4_SUPPORT
input                                          spi4_holdn_in;
output                                         spi4_holdn_oe;
output                                         spi4_holdn_out;
input                                          spi4_wpn_in;
output                                         spi4_wpn_oe;
output                                         spi4_wpn_out;
   `endif // AE350_SPI4_SUPPORT
`endif // ATCSPI200_QUADSPI_SUPPORT
`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output                   [(DMAC_ID_WIDTH-1):0] dmac1_arid;
output                   [(DMAC_ID_WIDTH-1):0] dmac1_awid;
input                    [(DMAC_ID_WIDTH-1):0] dmac1_bid;
input                    [(DMAC_ID_WIDTH-1):0] dmac1_rid;
output                 [BUS_MASTER_ADDR_MSB:0] dmac1_araddr;
output                                   [1:0] dmac1_arburst;
output                                   [3:0] dmac1_arcache;
output                                   [7:0] dmac1_arlen;
output                                         dmac1_arlock;
output                                   [2:0] dmac1_arprot;
input                                          dmac1_arready;
output                                   [2:0] dmac1_arsize;
output                                         dmac1_arvalid;
output                 [BUS_MASTER_ADDR_MSB:0] dmac1_awaddr;
output                                   [1:0] dmac1_awburst;
output                                   [3:0] dmac1_awcache;
output                                   [7:0] dmac1_awlen;
output                                         dmac1_awlock;
output                                   [2:0] dmac1_awprot;
input                                          dmac1_awready;
output                                   [2:0] dmac1_awsize;
output                                         dmac1_awvalid;
output                                         dmac1_bready;
input                                    [1:0] dmac1_bresp;
input                                          dmac1_bvalid;
input                  [(DMAC_DATA_WIDTH-1):0] dmac1_rdata;
input                                          dmac1_rlast;
output                                         dmac1_rready;
input                                    [1:0] dmac1_rresp;
input                                          dmac1_rvalid;
output                 [(DMAC_DATA_WIDTH-1):0] dmac1_wdata;
output                                         dmac1_wlast;
input                                          dmac1_wready;
output             [((DMAC_DATA_WIDTH/8)-1):0] dmac1_wstrb;
output                                         dmac1_wvalid;
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_SSP_SUPPORT
   `ifdef ATFSSP020_AC97_FUNCTION
output                                         ssp_ac97_resetn;
   `endif // ATFSSP020_AC97_FUNCTION
`endif // AE350_SSP_SUPPORT
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
input                                          spi1_csn_in;
      `endif // ATCSPI200_DIRECT_IO_SUPPORT
   `endif // ATCSPI200_SLAVE_SUPPORT
`endif // AE350_SPI1_SUPPORT
`ifdef ATCSPI200_AHBBUS_EXIST
`else
   `ifdef ATCSPI200_EILMBUS_EXIST
      `ifdef ATCSPI200_REG_APB
input                                          apb2core_clken;
      `endif // ATCSPI200_REG_APB
   `endif // ATCSPI200_EILMBUS_EXIST
`endif // ATCSPI200_AHBBUS_EXIST
`ifdef ATCSPI200_SLAVE_SUPPORT
`else
   `ifdef ATCSPI200_DIRECT_IO_SUPPORT
      `ifdef AE350_SPI2_SUPPORT
input                                          spi2_csn_in;
      `endif // AE350_SPI2_SUPPORT
      `ifdef AE350_SPI3_SUPPORT
input                                          spi3_csn_in;
      `endif // AE350_SPI3_SUPPORT
      `ifdef AE350_SPI4_SUPPORT
input                                          spi4_csn_in;
      `endif // AE350_SPI4_SUPPORT
   `endif // ATCSPI200_DIRECT_IO_SUPPORT
`endif // ATCSPI200_SLAVE_SUPPORT
input               [`ATCAPBBRG100_ADDR_MSB:0] ahb2apb_haddr;
input                                    [3:0] ahb2apb_hprot;
output                                  [31:0] ahb2apb_hrdata;
output                                         ahb2apb_hready;
input                                          ahb2apb_hready_in;
output                                   [1:0] ahb2apb_hresp;
input                                          ahb2apb_hsel;
input                                    [2:0] ahb2apb_hsize;
input                                    [1:0] ahb2apb_htrans;
input                                   [31:0] ahb2apb_hwdata;
input                                          ahb2apb_hwrite;
output              [`ATCAPBBRG100_ADDR_MSB:0] paddr;
output                                         penable;            // APB bus enable
output                                  [31:0] pwdata;             // APB write data bus
output                                         pwrite;             // APB read/write control
input                                   [31:0] smu_prdata;
input                                          smu_pready;
output                                         smu_psel;
input                                          smu_pslverr;
input                                          pclk;               // APB clk
input                                          presetn;            // reset
input                                          hclk;
input                                          hresetn;
input                                          apb2ahb_clken;
output                                         dma_int;
output                                         gpio_intr;
input                                          extclk;             // level signal in a_clk domain
output                                         i2c_int;
input                                          pclk_i2c;
output                                         i2c2_int;
output                                         pit_intr;
output                                         pit2_int;
output                                         pit3_int;
output                                         pit4_int;
output                                         pit5_int;
output                                         sdc_int;            // SD host interrupt
output                                         spi1_int;
input                                          scan_enable;
input                                          scan_test;
input                                          spi_clk;
input                                          spi_rstn;
output                                         spi2_int;
output                                         spi3_int;
output                                         spi4_int;
output                                         ssp_intr;
output                                         uart1_int;
input                                          uart_clk;           // system clock
input                                          uart_rstn;          // system reset, low active
output                                         uart2_int;
output                                         wdt_int;            // watchdog interrupt (atctive high)
output                                         wdt_rst;            // watchdog reset (active high)

`ifdef ATCAPBBRG100_SLV_14
wire                                           ps14_psel;
wire                                    [31:0] ps14_prdata;
wire                                           ps14_pready;
wire                                           ps14_pslverr;
`endif // ATCAPBBRG100_SLV_14
`ifdef ATCAPBBRG100_SLV_12
wire                                           ps12_psel;
wire                                    [31:0] ps12_prdata;
wire                                           ps12_pready;
wire                                           ps12_pslverr;
`endif // ATCAPBBRG100_SLV_12
`ifdef AE350_UART1_SUPPORT
wire                                           ps2_psel;
wire                                    [31:0] ps2_prdata;
`endif // AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
wire                                           ps3_psel;
wire                                    [31:0] ps3_prdata;
`endif // AE350_UART2_SUPPORT
`ifdef AE350_PIT_SUPPORT
wire                                           ps4_psel;
wire                                    [31:0] ps4_prdata;
`endif // AE350_PIT_SUPPORT
`ifdef AE350_PIT2_SUPPORT
wire                                           pclk_pit2; // dangler: () <= ()
wire                                           ps23_psel;
wire                                    [31:0] ps23_prdata;
`endif // AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
wire                                           pclk_pit3; // dangler: () <= ()
wire                                           ps24_psel;
wire                                    [31:0] ps24_prdata;
`endif // AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
wire                                           pclk_pit4; // dangler: () <= ()
wire                                           ps25_psel;
wire                                    [31:0] ps25_prdata;
`endif // AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
wire                                           pclk_pit5; // dangler: () <= ()
wire                                           ps26_psel;
wire                                    [31:0] ps26_prdata;
`endif // AE350_PIT5_SUPPORT
`ifdef AE350_WDT_SUPPORT
wire                                           ps5_psel;
wire                                    [31:0] ps5_prdata;
`endif // AE350_WDT_SUPPORT
`ifdef AE350_GPIO_SUPPORT
wire                                           ps7_psel;
wire                                    [31:0] ps7_prdata;
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_I2C_SUPPORT
wire                                           ps8_psel;
wire                                    [31:0] ps8_prdata;
`endif // AE350_I2C_SUPPORT
`ifdef AE350_I2C2_SUPPORT
wire                                           ps22_psel;
wire                                    [31:0] ps22_prdata;
`endif // AE350_I2C2_SUPPORT
`ifdef AE350_SPI1_SUPPORT
wire                                           ps9_psel;
wire                                    [31:0] ps9_prdata;
wire                                           ps9_pready;
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
wire                                           ps10_psel;
wire                                    [31:0] ps10_prdata;
wire                                           ps10_pready;
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
wire                                           ps20_psel;
wire                                    [31:0] ps20_prdata;
wire                                           ps20_pready;
`else
wire                                           spi3_int=1'b0;
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
wire                                           ps21_psel;
wire                                    [31:0] ps21_prdata;
wire                                           ps21_pready;
`else
wire                                           spi4_int=1'b0;
`endif // AE350_SPI4_SUPPORT
`ifdef AE350_SDC_SUPPORT
wire                                           ps11_psel;
wire                                    [31:0] ps11_prdata;
`endif // AE350_SDC_SUPPORT
`ifdef AE350_DMA_AXI_SUPPORT
wire                                     [2:0] dmac0_bid_3bit; // dangler: () <= ()
wire                                     [2:0] dmac0_rid_3bit; // dangler: () <= ()
wire                                     [2:0] dmac0_arid_3bit; // dangler: () => ()
wire                                     [2:0] dmac0_awid_3bit; // dangler: () => ()
`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_SSP_SUPPORT
wire                                           ps13_psel;
wire                                    [31:0] ps13_prdata;
`endif // AE350_SSP_SUPPORT
`ifdef ATCSPI200_REG_APB
   `ifdef AE350_SPI3_SUPPORT
wire                                           pclk_spi3; // dangler: () <= ()
   `endif // AE350_SPI3_SUPPORT
   `ifdef AE350_SPI4_SUPPORT
wire                                           pclk_spi4; // dangler: () <= ()
   `endif // AE350_SPI4_SUPPORT
`endif // ATCSPI200_REG_APB
`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
wire                                     [2:0] dmac1_bid_3bit; // dangler: () <= ()
wire                                     [2:0] dmac1_rid_3bit; // dangler: () <= ()
wire                                     [2:0] dmac1_arid_3bit; // dangler: () => ()
wire                                     [2:0] dmac1_awid_3bit; // dangler: () => ()
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif // AE350_DMA_AXI_SUPPORT
wire                                    [15:0] dma_req;
wire                                     [2:0] pprot; // dangler: () => ()
wire                                     [3:0] pstrb; // dangler: () => ()
wire                                    [15:0] dma_ack;
wire                                           dmareq_i2c;
wire                                           dmareq_i2c2;
wire                                           dmareq_sdc;
wire                                           dmareq_spi1_rx;
wire                                           dmareq_spi1_tx;
wire                                           dmareq_spi2_rx;
wire                                           dmareq_spi2_tx;
wire                                           dmareq_spi3_rx;
wire                                           dmareq_spi3_tx;
wire                                           dmareq_spi4_rx;
wire                                           dmareq_spi4_tx;
wire                                           dmareq_ssp_rx;
wire                                           dmareq_ssp_tx;
wire                                           dmareqn_uart1_rx;
wire                                           dmareqn_uart1_tx;
wire                                           dmareqn_uart2_rx;
wire                                           dmareqn_uart2_tx;

`ifdef AE350_SPI1_SUPPORT
`else //~AE350_SPI1_SUPPORT
assign dmareq_spi1_tx = 1'b0;
assign dmareq_spi1_rx = 1'b0;
assign spi1_int = 1'b0;
`endif //AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
`else //~AE350_SPI2_SUPPORT
assign dmareq_spi2_tx = 1'b0;
assign dmareq_spi2_rx = 1'b0;
assign spi2_int = 1'b0;
`endif //AE350_SPI2_SUPPORT
`ifdef AE350_GPIO_SUPPORT
  `ifndef ATCGPIO100_INTR_SUPPORT
assign gpio_intr     = 1'b0;
  `endif // ATCGPIO100_INTR_SUPPORT
`else
assign gpio_intr     = 1'b0;
`endif // AE350_GPIO_SUPPORT
`ifdef AE350_WDT_SUPPORT
`else // AE350_WDT_SUPPORT
assign wdt_int       = 1'b0;
assign wdt_rst       = 1'b0;
`endif // AE350_WDT_SUPPORT
`ifdef AE350_PIT_SUPPORT
`else // AE350_PIT_SUPPORT
assign pit_intr      = 1'b0;
`endif // AE350_PIT_SUPPORT
`ifdef AE350_DMA_SUPPORT
`else //AE350_DMA_SUPPORT
assign dma_int = 1'b0;
`endif //AE350_DMA_SUPPORT
`ifdef AE350_SSP_SUPPORT
`else //~AE350_SSP_SUPPORT
assign ssp_intr = 1'b0;
assign dmareq_ssp_tx = 1'b0;
assign dmareq_ssp_rx = 1'b0;
`endif
`ifdef AE350_SDC_SUPPORT
`else //~AE350_SDC_SUPPORT
assign sdc_int = 1'b0;
assign dmareq_sdc = 1'b0;
`endif
`ifdef AE350_UART1_SUPPORT
`else //~AE350_UART1_SUPPORT
assign dmareqn_uart1_tx = 1'b0;
assign dmareqn_uart1_rx = 1'b0;
assign uart1_int = 1'b0;
`endif //AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
`else //~AE350_UART2_SUPPORT
assign dmareqn_uart2_tx = 1'b0;
assign dmareqn_uart2_rx = 1'b0;
assign uart2_int = 1'b0;
`endif //AE350_UART2_SUPPORT
`ifdef AE350_I2C_SUPPORT
`else //~AE350_I2C_SUPPORT
assign dmareq_i2c = 1'b0;
assign i2c_int = 1'b0;
`endif //AE350_I2C_SUPPORT
`ifdef AE350_SPI3_SUPPORT
`else	// !AE350_SPI3_SUPPORT
assign dmareq_spi3_tx = 1'b0;
assign dmareq_spi3_rx = 1'b0;
`endif	// !AE350_SPI3_SUPPORT

`ifdef AE350_SPI4_SUPPORT
`else	// !AE350_SPI4_SUPPORT
assign dmareq_spi4_tx = 1'b0;
assign dmareq_spi4_rx = 1'b0;
`endif	// !AE350_SPI4_SUPPORT

`ifdef AE350_I2C2_SUPPORT
`else	// !AE350_I2C2_SUPPORT
assign dmareq_i2c2 = 1'b0;
assign i2c2_int = 1'b0;
`endif	// !AE350_I2C2_SUPPORT
`ifdef AE350_PIT2_SUPPORT
assign pclk_pit2 = pclk_pit;
`endif	// AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
assign pclk_pit3 = pclk_pit;
`endif	// AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
assign pclk_pit4 = pclk_pit;
`endif	// AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
assign pclk_pit5 = pclk_pit;
`endif	// AE350_PIT5_SUPPORT
`ifdef AE350_SPI3_SUPPORT
assign pclk_spi3 = pclk_spi1;
`endif	// AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
assign pclk_spi4 = pclk_spi1;
`endif	// AE350_SPI4_SUPPORT
	`ifdef AE350_DMA_AXI_SUPPORT
		assign dmac0_arid = {{(DMAC_ID_WIDTH-3){1'b0}}, dmac0_arid_3bit};
		assign dmac0_awid = {{(DMAC_ID_WIDTH-3){1'b0}}, dmac0_awid_3bit};
		assign dmac0_bid_3bit = dmac0_bid[2:0];
		assign dmac0_rid_3bit = dmac0_rid[2:0];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		assign dmac1_arid = {{(DMAC_ID_WIDTH-3){1'b0}}, dmac1_arid_3bit};
		assign dmac1_awid = {{(DMAC_ID_WIDTH-3){1'b0}}, dmac1_awid_3bit};
		assign dmac1_bid_3bit = dmac1_bid[2:0];
		assign dmac1_rid_3bit = dmac1_rid[2:0];
		`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_DMA_SUPPORT
`else
  assign dma_ack = 16'h0;
`endif //AE350_DMA_SUPPORT

`ifdef NDS_BOARD_CF1
assign dma_req = {2'b0, dmareq_i2c2, dmareq_spi4_rx, dmareq_spi4_tx, dmareq_spi3_rx, dmareq_spi3_tx,
			dmareq_i2c, dmareqn_uart2_rx, dmareqn_uart2_tx, dmareqn_uart1_rx, dmareqn_uart1_tx, dmareq_spi2_rx, dmareq_spi2_tx, dmareq_spi1_rx, dmareq_spi1_tx};
`else	// !NDS_BOARD_CF1
assign dma_req = { dmareq_ssp_rx, dmareq_ssp_tx, 4'h0, dmareq_sdc,
			dmareq_i2c, dmareqn_uart2_rx, dmareqn_uart2_tx, dmareqn_uart1_rx, dmareqn_uart1_tx, dmareq_spi2_rx, dmareq_spi2_tx, dmareq_spi1_rx, dmareq_spi1_tx};
`endif	// !NDS_BOARD_CF1
`ifdef AE350_PIT2_SUPPORT
`else	// !AE350_PIT2_SUPPORT
assign pit2_int = 1'b0;
`endif	// !AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
`else	// !AE350_PIT3_SUPPORT
assign pit3_int = 1'b0;
`endif	// !AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
`else	// !AE350_PIT4_SUPPORT
assign pit4_int = 1'b0;
`endif	// !AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
`else	// !AE350_PIT5_SUPPORT
assign pit5_int = 1'b0;
`endif	// !AE350_PIT5_SUPPORT

atcapbbrg100 u_ahb2apb (
`ifdef ATCAPBBRG100_SLV_1
	.ps1_psel     (smu_psel         ), // (u_ahb2apb) => ()
	.ps1_prdata   (smu_prdata       ), // (u_ahb2apb) <= ()
	.ps1_pready   (smu_pready       ), // (u_ahb2apb) <= ()
	.ps1_pslverr  (smu_pslverr      ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_1
`ifdef ATCAPBBRG100_SLV_2
	.ps2_psel     (ps2_psel         ), // (u_ahb2apb) => (u_uart1)
	.ps2_prdata   (ps2_prdata       ), // (u_ahb2apb) <= (u_uart1)
	.ps2_pready   (1'b1             ), // (u_ahb2apb) <= ()
	.ps2_pslverr  (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_2
`ifdef ATCAPBBRG100_SLV_3
	.ps3_psel     (ps3_psel         ), // (u_ahb2apb) => (u_uart2)
	.ps3_prdata   (ps3_prdata       ), // (u_ahb2apb) <= (u_uart2)
	.ps3_pready   (1'b1             ), // (u_ahb2apb) <= ()
	.ps3_pslverr  (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_3
`ifdef ATCAPBBRG100_SLV_4
	.ps4_psel     (ps4_psel         ), // (u_ahb2apb) => (u_pit)
	.ps4_prdata   (ps4_prdata       ), // (u_ahb2apb) <= (u_pit)
	.ps4_pready   (1'b1             ), // (u_ahb2apb) <= ()
	.ps4_pslverr  (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_4
`ifdef ATCAPBBRG100_SLV_5
	.ps5_psel     (ps5_psel         ), // (u_ahb2apb) => (u_wdt)
	.ps5_prdata   (ps5_prdata       ), // (u_ahb2apb) <= (u_wdt)
	.ps5_pready   (1'b1             ), // (u_ahb2apb) <= ()
	.ps5_pslverr  (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_5
`ifdef ATCAPBBRG100_SLV_6
	.ps6_psel     (rtc_psel         ), // (u_ahb2apb) => ()
	.ps6_prdata   (rtc_prdata       ), // (u_ahb2apb) <= ()
	.ps6_pready   (rtc_pready       ), // (u_ahb2apb) <= ()
	.ps6_pslverr  (rtc_pslverr      ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_6
`ifdef ATCAPBBRG100_SLV_7
	.ps7_psel     (ps7_psel         ), // (u_ahb2apb) => (u_gpio)
	.ps7_prdata   (ps7_prdata       ), // (u_ahb2apb) <= (u_gpio)
	.ps7_pready   (1'b1             ), // (u_ahb2apb) <= ()
	.ps7_pslverr  (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_7
`ifdef ATCAPBBRG100_SLV_8
	.ps8_psel     (ps8_psel         ), // (u_ahb2apb) => (u_i2c)
	.ps8_prdata   (ps8_prdata       ), // (u_ahb2apb) <= (u_i2c)
	.ps8_pready   (1'b1             ), // (u_ahb2apb) <= ()
	.ps8_pslverr  (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_8
`ifdef ATCAPBBRG100_SLV_9
	.ps9_psel     (ps9_psel         ), // (u_ahb2apb) => (u_spi1)
	.ps9_prdata   (ps9_prdata       ), // (u_ahb2apb) <= (u_spi1)
	.ps9_pready   (ps9_pready       ), // (u_ahb2apb) <= (u_spi1)
	.ps9_pslverr  (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_9
`ifdef ATCAPBBRG100_SLV_10
	.ps10_psel    (ps10_psel        ), // (u_ahb2apb) => (u_spi2)
	.ps10_prdata  (ps10_prdata      ), // (u_ahb2apb) <= (u_spi2)
	.ps10_pready  (ps10_pready      ), // (u_ahb2apb) <= (u_spi2)
	.ps10_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_10
`ifdef ATCAPBBRG100_SLV_11
	.ps11_psel    (ps11_psel        ), // (u_ahb2apb) => (u_sdc)
	.ps11_prdata  (ps11_prdata      ), // (u_ahb2apb) <= (u_sdc)
	.ps11_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps11_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_11
`ifdef ATCAPBBRG100_SLV_12
	.ps12_psel    (ps12_psel        ), // (u_ahb2apb) => (u_dmac_ahb,u_dmac_axi)
	.ps12_prdata  (ps12_prdata      ), // (u_ahb2apb) <= (u_dmac_ahb,u_dmac_axi)
	.ps12_pready  (ps12_pready      ), // (u_ahb2apb) <= (u_dmac_ahb,u_dmac_axi)
	.ps12_pslverr (ps12_pslverr     ), // (u_ahb2apb) <= (u_dmac_ahb,u_dmac_axi)
`endif // ATCAPBBRG100_SLV_12
`ifdef ATCAPBBRG100_SLV_13
	.ps13_psel    (ps13_psel        ), // (u_ahb2apb) => (u_ssp)
	.ps13_prdata  (ps13_prdata      ), // (u_ahb2apb) <= (u_ssp)
	.ps13_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps13_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_13
`ifdef ATCAPBBRG100_SLV_14
	.ps14_psel    (ps14_psel        ), // (u_ahb2apb) => (u_dtrom)
	.ps14_prdata  (ps14_prdata      ), // (u_ahb2apb) <= (u_dtrom)
	.ps14_pready  (ps14_pready      ), // (u_ahb2apb) <= (u_dtrom)
	.ps14_pslverr (ps14_pslverr     ), // (u_ahb2apb) <= (u_dtrom)
`endif // ATCAPBBRG100_SLV_14
`ifdef ATCAPBBRG100_SLV_15
	.ps15_psel    (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.ps15_prdata  (32'h0            ), // (u_ahb2apb) <= ()
	.ps15_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps15_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_15
`ifdef ATCAPBBRG100_SLV_16
	.ps16_psel    (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.ps16_prdata  (32'h0            ), // (u_ahb2apb) <= ()
	.ps16_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps16_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_16
`ifdef ATCAPBBRG100_SLV_17
	.ps17_psel    (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.ps17_prdata  (32'h0            ), // (u_ahb2apb) <= ()
	.ps17_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps17_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_17
`ifdef ATCAPBBRG100_SLV_18
	.ps18_psel    (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.ps18_prdata  (32'h0            ), // (u_ahb2apb) <= ()
	.ps18_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps18_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_18
`ifdef ATCAPBBRG100_SLV_19
	.ps19_psel    (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.ps19_prdata  (32'h0            ), // (u_ahb2apb) <= ()
	.ps19_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps19_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_19
`ifdef ATCAPBBRG100_SLV_20
	.ps20_psel    (ps20_psel        ), // (u_ahb2apb) => (u_spi3)
	.ps20_prdata  (ps20_prdata      ), // (u_ahb2apb) <= (u_spi3)
	.ps20_pready  (ps20_pready      ), // (u_ahb2apb) <= (u_spi3)
	.ps20_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_20
`ifdef ATCAPBBRG100_SLV_21
	.ps21_psel    (ps21_psel        ), // (u_ahb2apb) => (u_spi4)
	.ps21_prdata  (ps21_prdata      ), // (u_ahb2apb) <= (u_spi4)
	.ps21_pready  (ps21_pready      ), // (u_ahb2apb) <= (u_spi4)
	.ps21_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_21
`ifdef ATCAPBBRG100_SLV_22
	.ps22_psel    (ps22_psel        ), // (u_ahb2apb) => (u_i2c2)
	.ps22_prdata  (ps22_prdata      ), // (u_ahb2apb) <= (u_i2c2)
	.ps22_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps22_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_22
`ifdef ATCAPBBRG100_SLV_23
	.ps23_psel    (ps23_psel        ), // (u_ahb2apb) => (u_pit2)
	.ps23_prdata  (ps23_prdata      ), // (u_ahb2apb) <= (u_pit2)
	.ps23_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps23_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_23
`ifdef ATCAPBBRG100_SLV_24
	.ps24_psel    (ps24_psel        ), // (u_ahb2apb) => (u_pit3)
	.ps24_prdata  (ps24_prdata      ), // (u_ahb2apb) <= (u_pit3)
	.ps24_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps24_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_24
`ifdef ATCAPBBRG100_SLV_25
	.ps25_psel    (ps25_psel        ), // (u_ahb2apb) => (u_pit4)
	.ps25_prdata  (ps25_prdata      ), // (u_ahb2apb) <= (u_pit4)
	.ps25_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps25_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_25
`ifdef ATCAPBBRG100_SLV_26
	.ps26_psel    (ps26_psel        ), // (u_ahb2apb) => (u_pit5)
	.ps26_prdata  (ps26_prdata      ), // (u_ahb2apb) <= (u_pit5)
	.ps26_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps26_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_26
`ifdef ATCAPBBRG100_SLV_27
	.ps27_psel    (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.ps27_prdata  (32'h0            ), // (u_ahb2apb) <= ()
	.ps27_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps27_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_27
`ifdef ATCAPBBRG100_SLV_28
	.ps28_psel    (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.ps28_prdata  (32'h0            ), // (u_ahb2apb) <= ()
	.ps28_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps28_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_28
`ifdef ATCAPBBRG100_SLV_29
	.ps29_psel    (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.ps29_prdata  (32'h0            ), // (u_ahb2apb) <= ()
	.ps29_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps29_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_29
`ifdef ATCAPBBRG100_SLV_30
	.ps30_psel    (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.ps30_prdata  (32'h0            ), // (u_ahb2apb) <= ()
	.ps30_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps30_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_30
`ifdef ATCAPBBRG100_SLV_31
	.ps31_psel    (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.ps31_prdata  (32'h0            ), // (u_ahb2apb) <= ()
	.ps31_pready  (1'b1             ), // (u_ahb2apb) <= ()
	.ps31_pslverr (1'b0             ), // (u_ahb2apb) <= ()
`endif // ATCAPBBRG100_SLV_31
	.hclk         (hclk             ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.hresetn      (hresetn          ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.hsel         (ahb2apb_hsel     ), // (u_ahb2apb) <= ()
	.hready_in    (ahb2apb_hready_in), // (u_ahb2apb) <= ()
	.htrans       (ahb2apb_htrans   ), // (u_ahb2apb) <= ()
	.haddr        (ahb2apb_haddr    ), // (u_ahb2apb) <= ()
	.hsize        (ahb2apb_hsize    ), // (u_ahb2apb) <= ()
	.hprot        (ahb2apb_hprot    ), // (u_ahb2apb) <= ()
	.hwrite       (ahb2apb_hwrite   ), // (u_ahb2apb) <= ()
	.hwdata       (ahb2apb_hwdata   ), // (u_ahb2apb) <= ()
	.apb2ahb_clken(apb2ahb_clken    ), // (u_ahb2apb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.hrdata       (ahb2apb_hrdata   ), // (u_ahb2apb) => ()
	.hready       (ahb2apb_hready   ), // (u_ahb2apb) => ()
	.hresp        (ahb2apb_hresp    ), // (u_ahb2apb) => ()
	.pclk         (pclk             ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_dtrom,u_sdc,u_ssp) <= ()
	.presetn      (presetn          ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.pprot        (pprot            ), // (u_ahb2apb) => ()
	.pstrb        (pstrb            ), // (u_ahb2apb) => ()
	.paddr        (paddr            ), // (u_ahb2apb) => (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt)
	.penable      (penable          ), // (u_ahb2apb) => (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt)
	.pwrite       (pwrite           ), // (u_ahb2apb) => (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt)
	.pwdata       (pwdata           )  // (u_ahb2apb) => (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt)
); // end of u_ahb2apb

`ifdef AE350_UART1_SUPPORT
atcuart100 u_uart1 (
   `ifdef ATCUART100_UCLK_PCLK_SAME
   `else
	.uclk      (uart_clk        ), // (u_uart1,u_uart2) <= ()
	.urstn     (uart_rstn       ), // (u_uart1,u_uart2) <= ()
   `endif // ATCUART100_UCLK_PCLK_SAME
	.dma_rx_ack(dma_ack[5]      ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.dma_tx_ack(dma_ack[4]      ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.paddr     (paddr[5:2]      ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk      (pclk_uart1      ), // (u_uart1) <= ()
	.penable   (penable         ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.presetn   (presetn         ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.psel      (ps2_psel        ), // (u_uart1) <= (u_ahb2apb)
	.pwdata    (pwdata          ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite    (pwrite          ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.uart_ctsn (uart1_ctsn      ), // (u_uart1) <= ()
	.uart_dcdn (uart1_dcdn      ), // (u_uart1) <= ()
	.uart_dsrn (uart1_dsrn      ), // (u_uart1) <= ()
	.uart_rin  (uart1_rin       ), // (u_uart1) <= ()
	.uart_sin  (uart1_rxd       ), // (u_uart1) <= ()
	.dma_rx_req(dmareqn_uart1_rx), // (u_uart1) => ()
	.dma_tx_req(dmareqn_uart1_tx), // (u_uart1) => ()
	.prdata    (ps2_prdata      ), // (u_uart1) => (u_ahb2apb)
	.uart_dtrn (uart1_dtrn      ), // (u_uart1) => ()
	.uart_intr (uart1_int       ), // (u_uart1) => ()
	.uart_out1n(uart1_out1n     ), // (u_uart1) => ()
	.uart_out2n(uart1_out2n     ), // (u_uart1) => ()
	.uart_rtsn (uart1_rtsn      ), // (u_uart1) => ()
	.uart_sout (uart1_txd       )  // (u_uart1) => ()
); // end of u_uart1

`endif // AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
atcuart100 u_uart2 (
   `ifdef ATCUART100_UCLK_PCLK_SAME
   `else
	.uclk      (uart_clk        ), // (u_uart1,u_uart2) <= ()
	.urstn     (uart_rstn       ), // (u_uart1,u_uart2) <= ()
   `endif // ATCUART100_UCLK_PCLK_SAME
	.dma_rx_ack(dma_ack[7]      ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.dma_tx_ack(dma_ack[6]      ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.paddr     (paddr[5:2]      ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk      (pclk_uart2      ), // (u_uart2) <= ()
	.penable   (penable         ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.presetn   (presetn         ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.psel      (ps3_psel        ), // (u_uart2) <= (u_ahb2apb)
	.pwdata    (pwdata          ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite    (pwrite          ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.uart_ctsn (uart2_ctsn      ), // (u_uart2) <= ()
	.uart_dcdn (uart2_dcdn      ), // (u_uart2) <= ()
	.uart_dsrn (uart2_dsrn      ), // (u_uart2) <= ()
	.uart_rin  (uart2_rin       ), // (u_uart2) <= ()
	.uart_sin  (uart2_rxd       ), // (u_uart2) <= ()
	.dma_rx_req(dmareqn_uart2_rx), // (u_uart2) => ()
	.dma_tx_req(dmareqn_uart2_tx), // (u_uart2) => ()
	.prdata    (ps3_prdata      ), // (u_uart2) => (u_ahb2apb)
	.uart_dtrn (uart2_dtrn      ), // (u_uart2) => ()
	.uart_intr (uart2_int       ), // (u_uart2) => ()
	.uart_out1n(uart2_out1n     ), // (u_uart2) => ()
	.uart_out2n(uart2_out2n     ), // (u_uart2) => ()
	.uart_rtsn (uart2_rtsn      ), // (u_uart2) => ()
	.uart_sout (uart2_txd       )  // (u_uart2) => ()
); // end of u_uart2

`endif // AE350_UART2_SUPPORT
`ifdef AE350_PIT_SUPPORT
atcpit100 u_pit (
   `ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm  (ch1_pwm   ), // (u_pit) => ()
	.ch1_pwmoe(ch1_pwmoe ), // (u_pit) => ()
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm  (ch2_pwm   ), // (u_pit) => ()
	.ch2_pwmoe(ch2_pwmoe ), // (u_pit) => ()
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm  (ch3_pwm   ), // (u_pit) => ()
	.ch3_pwmoe(ch3_pwmoe ), // (u_pit) => ()
   `endif // ATCPIT100_CH3_SUPPORT
	.extclk   (extclk    ), // (u_gpio,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_wdt) <= ()
	.paddr    (paddr[6:2]), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk     (pclk_pit  ), // (u_pit) <= ()
	.penable  (penable   ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pit_pause(1'b0      ), // (u_pit) <= ()
	.presetn  (presetn   ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.psel     (ps4_psel  ), // (u_pit) <= (u_ahb2apb)
	.pwdata   (pwdata    ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite   (pwrite    ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.ch0_pwm  (ch0_pwm   ), // (u_pit) => ()
	.ch0_pwmoe(ch0_pwmoe ), // (u_pit) => ()
	.pit_intr (pit_intr  ), // (u_pit) => ()
	.prdata   (ps4_prdata)  // (u_pit) => (u_ahb2apb)
); // end of u_pit

`endif // AE350_PIT_SUPPORT
`ifdef AE350_PIT2_SUPPORT
atcpit100 u_pit2 (
   `ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm  (pit2_ch1_pwm  ), // (u_pit2) => ()
	.ch1_pwmoe(pit2_ch1_pwmoe), // (u_pit2) => ()
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm  (pit2_ch2_pwm  ), // (u_pit2) => ()
	.ch2_pwmoe(pit2_ch2_pwmoe), // (u_pit2) => ()
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm  (pit2_ch3_pwm  ), // (u_pit2) => ()
	.ch3_pwmoe(pit2_ch3_pwmoe), // (u_pit2) => ()
   `endif // ATCPIT100_CH3_SUPPORT
	.extclk   (extclk        ), // (u_gpio,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_wdt) <= ()
	.paddr    (paddr[6:2]    ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk     (pclk_pit2     ), // (u_pit2) <= ()
	.penable  (penable       ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pit_pause(1'b0          ), // (u_pit2) <= ()
	.presetn  (presetn       ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.psel     (ps23_psel     ), // (u_pit2) <= (u_ahb2apb)
	.pwdata   (pwdata        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite   (pwrite        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.ch0_pwm  (pit2_ch0_pwm  ), // (u_pit2) => ()
	.ch0_pwmoe(pit2_ch0_pwmoe), // (u_pit2) => ()
	.pit_intr (pit2_int      ), // (u_pit2) => ()
	.prdata   (ps23_prdata   )  // (u_pit2) => (u_ahb2apb)
); // end of u_pit2

`endif // AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
atcpit100 u_pit3 (
   `ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm  (pit3_ch1_pwm  ), // (u_pit3) => ()
	.ch1_pwmoe(pit3_ch1_pwmoe), // (u_pit3) => ()
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm  (pit3_ch2_pwm  ), // (u_pit3) => ()
	.ch2_pwmoe(pit3_ch2_pwmoe), // (u_pit3) => ()
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm  (pit3_ch3_pwm  ), // (u_pit3) => ()
	.ch3_pwmoe(pit3_ch3_pwmoe), // (u_pit3) => ()
   `endif // ATCPIT100_CH3_SUPPORT
	.extclk   (extclk        ), // (u_gpio,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_wdt) <= ()
	.paddr    (paddr[6:2]    ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk     (pclk_pit3     ), // (u_pit3) <= ()
	.penable  (penable       ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pit_pause(1'b0          ), // (u_pit3) <= ()
	.presetn  (presetn       ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.psel     (ps24_psel     ), // (u_pit3) <= (u_ahb2apb)
	.pwdata   (pwdata        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite   (pwrite        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.ch0_pwm  (pit3_ch0_pwm  ), // (u_pit3) => ()
	.ch0_pwmoe(pit3_ch0_pwmoe), // (u_pit3) => ()
	.pit_intr (pit3_int      ), // (u_pit3) => ()
	.prdata   (ps24_prdata   )  // (u_pit3) => (u_ahb2apb)
); // end of u_pit3

`endif // AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
atcpit100 u_pit4 (
   `ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm  (pit4_ch1_pwm  ), // (u_pit4) => ()
	.ch1_pwmoe(pit4_ch1_pwmoe), // (u_pit4) => ()
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm  (pit4_ch2_pwm  ), // (u_pit4) => ()
	.ch2_pwmoe(pit4_ch2_pwmoe), // (u_pit4) => ()
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm  (pit4_ch3_pwm  ), // (u_pit4) => ()
	.ch3_pwmoe(pit4_ch3_pwmoe), // (u_pit4) => ()
   `endif // ATCPIT100_CH3_SUPPORT
	.extclk   (extclk        ), // (u_gpio,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_wdt) <= ()
	.paddr    (paddr[6:2]    ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk     (pclk_pit4     ), // (u_pit4) <= ()
	.penable  (penable       ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pit_pause(1'b0          ), // (u_pit4) <= ()
	.presetn  (presetn       ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.psel     (ps25_psel     ), // (u_pit4) <= (u_ahb2apb)
	.pwdata   (pwdata        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite   (pwrite        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.ch0_pwm  (pit4_ch0_pwm  ), // (u_pit4) => ()
	.ch0_pwmoe(pit4_ch0_pwmoe), // (u_pit4) => ()
	.pit_intr (pit4_int      ), // (u_pit4) => ()
	.prdata   (ps25_prdata   )  // (u_pit4) => (u_ahb2apb)
); // end of u_pit4

`endif // AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
atcpit100 u_pit5 (
   `ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm  (pit5_ch1_pwm  ), // (u_pit5) => ()
	.ch1_pwmoe(pit5_ch1_pwmoe), // (u_pit5) => ()
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm  (pit5_ch2_pwm  ), // (u_pit5) => ()
	.ch2_pwmoe(pit5_ch2_pwmoe), // (u_pit5) => ()
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm  (pit5_ch3_pwm  ), // (u_pit5) => ()
	.ch3_pwmoe(pit5_ch3_pwmoe), // (u_pit5) => ()
   `endif // ATCPIT100_CH3_SUPPORT
	.extclk   (extclk        ), // (u_gpio,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_wdt) <= ()
	.paddr    (paddr[6:2]    ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk     (pclk_pit5     ), // (u_pit5) <= ()
	.penable  (penable       ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pit_pause(1'b0          ), // (u_pit5) <= ()
	.presetn  (presetn       ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.psel     (ps26_psel     ), // (u_pit5) <= (u_ahb2apb)
	.pwdata   (pwdata        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite   (pwrite        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.ch0_pwm  (pit5_ch0_pwm  ), // (u_pit5) => ()
	.ch0_pwmoe(pit5_ch0_pwmoe), // (u_pit5) => ()
	.pit_intr (pit5_int      ), // (u_pit5) => ()
	.prdata   (ps26_prdata   )  // (u_pit5) => (u_ahb2apb)
); // end of u_pit5

`endif // AE350_PIT5_SUPPORT
`ifdef AE350_WDT_SUPPORT
atcwdt200 u_wdt (
	.extclk   (extclk    ), // (u_gpio,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_wdt) <= ()
	.wdt_pause(1'b0      ), // (u_wdt) <= ()
	.wdt_rst  (wdt_rst   ), // (u_wdt) => ()
	.wdt_int  (wdt_int   ), // (u_wdt) => ()
	.pclk     (pclk_wdt  ), // (u_wdt) <= ()
	.presetn  (presetn   ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.psel     (ps5_psel  ), // (u_wdt) <= (u_ahb2apb)
	.penable  (penable   ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.paddr    (paddr[4:2]), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite   (pwrite    ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwdata   (pwdata    ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.prdata   (ps5_prdata)  // (u_wdt) => (u_ahb2apb)
); // end of u_wdt

`endif // AE350_WDT_SUPPORT
`ifdef AE350_GPIO_SUPPORT
atcgpio100 u_gpio (
   `ifdef ATCGPIO100_PULL_SUPPORT
	.gpio_pulldown(gpio_pulldown), // (u_gpio) => ()
	.gpio_pullup  (gpio_pullup  ), // (u_gpio) => ()
   `endif // ATCGPIO100_PULL_SUPPORT
   `ifdef ATCGPIO100_INTR_SUPPORT
	.gpio_intr    (gpio_intr    ), // (u_gpio) => ()
   `endif // ATCGPIO100_INTR_SUPPORT
	.gpio_oe      (gpio_oe      ), // (u_gpio) => ()
	.gpio_out     (gpio_out     ), // (u_gpio) => ()
	.paddr        (paddr[7:0]   ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.penable      (penable      ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.prdata       (ps7_prdata   ), // (u_gpio) => (u_ahb2apb)
	.psel         (ps7_psel     ), // (u_gpio) <= (u_ahb2apb)
	.pwdata       (pwdata       ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite       (pwrite       ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk         (pclk_gpio    ), // (u_gpio) <= ()
	.presetn      (presetn      ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.extclk       (extclk       ), // (u_gpio,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_wdt) <= ()
	.gpio_in      (gpio_in      )  // (u_gpio) <= ()
); // end of u_gpio

`endif // AE350_GPIO_SUPPORT
`ifdef AE350_I2C_SUPPORT
atciic100 u_i2c (
	.i2c_int(i2c_int   ), // (u_i2c) => ()
	.paddr  (paddr[5:2]), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.penable(penable   ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.prdata (ps8_prdata), // (u_i2c) => (u_ahb2apb)
	.psel   (ps8_psel  ), // (u_i2c) <= (u_ahb2apb)
	.pwdata (pwdata    ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite (pwrite    ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk   (pclk_i2c  ), // (u_i2c,u_i2c2) <= ()
	.presetn(presetn   ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.dma_ack(dma_ack[8]), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.dma_req(dmareq_i2c), // (u_i2c) => ()
	.scl_o  (i2c_scl   ), // (u_i2c) => ()
	.sda_o  (i2c_sda   ), // (u_i2c) => ()
	.scl_i  (i2c_scl_in), // (u_i2c) <= ()
	.sda_i  (i2c_sda_in)  // (u_i2c) <= ()
); // end of u_i2c

`endif // AE350_I2C_SUPPORT
`ifdef AE350_I2C2_SUPPORT
atciic100 u_i2c2 (
	.i2c_int(i2c2_int   ), // (u_i2c2) => ()
	.paddr  (paddr[5:2] ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.penable(penable    ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.prdata (ps22_prdata), // (u_i2c2) => (u_ahb2apb)
	.psel   (ps22_psel  ), // (u_i2c2) <= (u_ahb2apb)
	.pwdata (pwdata     ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite (pwrite     ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk   (pclk_i2c   ), // (u_i2c,u_i2c2) <= ()
	.presetn(presetn    ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.dma_ack(dma_ack[13]), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.dma_req(dmareq_i2c2), // (u_i2c2) => ()
	.scl_o  (i2c2_scl   ), // (u_i2c2) => ()
	.sda_o  (i2c2_sda   ), // (u_i2c2) => ()
	.scl_i  (i2c2_scl_in), // (u_i2c2) <= ()
	.sda_i  (i2c2_sda_in)  // (u_i2c2) <= ()
); // end of u_i2c2

`endif // AE350_I2C2_SUPPORT
`ifdef AE350_SPI1_SUPPORT
atcspi200 u_spi1 (
   `ifdef ATCSPI200_AHBBUS_EXIST
	.hclk                (hclk             ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.hresetn             (hresetn          ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
   `endif // ATCSPI200_AHBBUS_EXIST
   `ifdef ATCSPI200_EILMBUS_EXIST
	.eilm_addr           (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_clk            (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_rdata          (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.eilm_req            (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_resetn         (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_wait           (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.eilm_wait_cnt       (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_wdata          (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_web            (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
   `endif // ATCSPI200_EILMBUS_EXIST
   `ifdef ATCSPI200_REG_APB
	.pclk                (pclk_spi1        ), // (u_spi1) <= ()
	.presetn             (presetn          ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.paddr               (paddr            ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.penable             (penable          ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.prdata              (ps9_prdata       ), // (u_spi1) => (u_ahb2apb)
	.pready              (ps9_pready       ), // (u_spi1) => (u_ahb2apb)
	.psel                (ps9_psel         ), // (u_spi1) <= (u_ahb2apb)
	.pwdata              (pwdata           ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite              (pwrite           ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
   `endif // ATCSPI200_REG_APB
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.haddr_mem           (spi_mem_haddr    ), // (u_spi1) <= ()
	.hrdata_mem          (spi_mem_hrdata   ), // (u_spi1) => ()
	.hreadyin_mem        (spi_mem_hready   ), // (u_spi1) <= ()
	.hreadyout_mem       (spi_mem_hreadyout), // (u_spi1) => ()
	.hresp_mem           (spi_mem_hresp    ), // (u_spi1) => ()
	.hsel_mem            (spi_mem_hsel     ), // (u_spi1) <= ()
	.htrans_mem          (spi_mem_htrans   ), // (u_spi1) <= ()
	.hwrite_mem          (spi_mem_hwrite   ), // (u_spi1) <= ()
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_REG_AHB
	.haddr_reg           (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hrdata_reg          (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hreadyin_reg        (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hreadyout_reg       (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hresp_reg           (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hsel_reg            (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.htrans_reg          (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hwdata_reg          (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hwrite_reg          (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
   `endif // ATCSPI200_REG_AHB
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_default_as_slave(1'b0             ), // (u_spi1) <= ()
	.spi_cs_n_in         (spi1_csn_in      ), // (u_spi1) <= ()
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_hold_n_in       (spi1_holdn_in    ), // (u_spi1) <= ()
	.spi_hold_n_oe       (spi1_holdn_oe    ), // (u_spi1) => ()
	.spi_hold_n_out      (spi1_holdn_out   ), // (u_spi1) => ()
	.spi_wp_n_in         (spi1_wpn_in      ), // (u_spi1) <= ()
	.spi_wp_n_oe         (spi1_wpn_oe      ), // (u_spi1) => ()
	.spi_wp_n_out        (spi1_wpn_out     ), // (u_spi1) => ()
   `endif // ATCSPI200_QUADSPI_SUPPORT
   `ifdef ATCSPI200_AHBBUS_EXIST
      `ifdef ATCSPI200_EILMBUS_EXIST
	.ahb2eilm_clken      (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
      `endif // ATCSPI200_EILMBUS_EXIST
      `ifdef ATCSPI200_REG_APB
	.apb2ahb_clken       (apb2ahb_clken    ), // (u_ahb2apb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
      `endif // ATCSPI200_REG_APB
   `endif // ATCSPI200_AHBBUS_EXIST
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
      `ifdef ATCSPI200_HSPLIT_SUPPORT
	.hmaster_mem         (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hsplit_mem          (/* NC */         ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
      `endif // ATCSPI200_HSPLIT_SUPPORT
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_REG_EILM
      `ifdef ATCSPI200_EILM_MEM_SUPPORT
	.eilm_reg_sel        (/* NC */         ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
      `endif // ATCSPI200_EILM_MEM_SUPPORT
   `endif // ATCSPI200_REG_EILM
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi_cs_n_in         (spi1_csn_in      ), // (u_spi1) <= ()
      `endif // ATCSPI200_DIRECT_IO_SUPPORT
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_AHBBUS_EXIST
   `else
      `ifdef ATCSPI200_EILMBUS_EXIST
         `ifdef ATCSPI200_REG_APB
	.apb2eilm_clken      (apb2core_clken   ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
         `endif // ATCSPI200_REG_APB
      `endif // ATCSPI200_EILMBUS_EXIST
   `endif // ATCSPI200_AHBBUS_EXIST
	.spi_clock           (spi_clk          ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_rstn            (spi_rstn         ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_boot_intr       (spi1_int         ), // (u_spi1) => ()
	.spi_default_mode3   (1'b0             ), // (u_spi1) <= ()
	.spi_rx_dma_ack      (dma_ack[1]       ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.spi_rx_dma_req      (dmareq_spi1_rx   ), // (u_spi1) => ()
	.spi_tx_dma_ack      (dma_ack[0]       ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.spi_tx_dma_req      (dmareq_spi1_tx   ), // (u_spi1) => ()
	.scan_enable         (scan_enable      ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.scan_test           (scan_test        ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_clk_in          (spi1_clk_in      ), // (u_spi1) <= ()
	.spi_clk_oe          (spi1_clk_oe      ), // (u_spi1) => ()
	.spi_clk_out         (spi1_clk_out     ), // (u_spi1) => ()
	.spi_cs_n_oe         (spi1_csn_oe      ), // (u_spi1) => ()
	.spi_cs_n_out        (spi1_csn_out     ), // (u_spi1) => ()
	.spi_miso_in         (spi1_miso_in     ), // (u_spi1) <= ()
	.spi_miso_oe         (spi1_miso_oe     ), // (u_spi1) => ()
	.spi_miso_out        (spi1_miso_out    ), // (u_spi1) => ()
	.spi_mosi_in         (spi1_mosi_in     ), // (u_spi1) <= ()
	.spi_mosi_oe         (spi1_mosi_oe     ), // (u_spi1) => ()
	.spi_mosi_out        (spi1_mosi_out    )  // (u_spi1) => ()
); // end of u_spi1

`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
atcspi200 u_spi2 (
   `ifdef ATCSPI200_AHBBUS_EXIST
	.hclk                (hclk          ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.hresetn             (hresetn       ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
   `endif // ATCSPI200_AHBBUS_EXIST
   `ifdef ATCSPI200_EILMBUS_EXIST
	.eilm_addr           (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_clk            (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_rdata          (/* NC */      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.eilm_req            (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_resetn         (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_wait           (/* NC */      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.eilm_wait_cnt       (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_wdata          (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_web            (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
   `endif // ATCSPI200_EILMBUS_EXIST
   `ifdef ATCSPI200_REG_APB
	.pclk                (pclk_spi2     ), // (u_spi2) <= ()
	.presetn             (presetn       ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.paddr               (paddr         ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.penable             (penable       ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.prdata              (ps10_prdata   ), // (u_spi2) => (u_ahb2apb)
	.pready              (ps10_pready   ), // (u_spi2) => (u_ahb2apb)
	.psel                (ps10_psel     ), // (u_spi2) <= (u_ahb2apb)
	.pwdata              (pwdata        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite              (pwrite        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
   `endif // ATCSPI200_REG_APB
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.haddr_mem           ({`ATCSPI200_HADDR_WIDTH{1'b0}}), // () <= ()
	.hrdata_mem          (/* NC */      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hreadyin_mem        (1'b1          ), // (u_spi2) <= ()
	.hreadyout_mem       (/* NC */      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hresp_mem           (/* NC */      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hsel_mem            (1'b0          ), // (u_spi2) <= ()
	.htrans_mem          (2'b0          ), // (u_spi2) <= ()
	.hwrite_mem          (1'b0          ), // (u_spi2) <= ()
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_REG_AHB
	.haddr_reg           (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hrdata_reg          (/* NC */      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hreadyin_reg        (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hreadyout_reg       (/* NC */      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hresp_reg           (/* NC */      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hsel_reg            (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.htrans_reg          (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hwdata_reg          (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hwrite_reg          (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
   `endif // ATCSPI200_REG_AHB
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_default_as_slave(1'b0          ), // (u_spi2) <= ()
	.spi_cs_n_in         (spi2_csn_in   ), // (u_spi2) <= ()
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_hold_n_in       (spi2_holdn_in ), // (u_spi2) <= ()
	.spi_hold_n_oe       (spi2_holdn_oe ), // (u_spi2) => ()
	.spi_hold_n_out      (spi2_holdn_out), // (u_spi2) => ()
	.spi_wp_n_in         (spi2_wpn_in   ), // (u_spi2) <= ()
	.spi_wp_n_oe         (spi2_wpn_oe   ), // (u_spi2) => ()
	.spi_wp_n_out        (spi2_wpn_out  ), // (u_spi2) => ()
   `endif // ATCSPI200_QUADSPI_SUPPORT
   `ifdef ATCSPI200_AHBBUS_EXIST
      `ifdef ATCSPI200_EILMBUS_EXIST
	.ahb2eilm_clken      (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
      `endif // ATCSPI200_EILMBUS_EXIST
      `ifdef ATCSPI200_REG_APB
	.apb2ahb_clken       (apb2ahb_clken ), // (u_ahb2apb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
      `endif // ATCSPI200_REG_APB
   `endif // ATCSPI200_AHBBUS_EXIST
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
      `ifdef ATCSPI200_HSPLIT_SUPPORT
	.hmaster_mem         (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hsplit_mem          (/* NC */      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
      `endif // ATCSPI200_HSPLIT_SUPPORT
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_REG_EILM
      `ifdef ATCSPI200_EILM_MEM_SUPPORT
	.eilm_reg_sel        (/* NC */      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
      `endif // ATCSPI200_EILM_MEM_SUPPORT
   `endif // ATCSPI200_REG_EILM
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi_cs_n_in         (spi2_csn_in   ), // (u_spi2) <= ()
      `endif // ATCSPI200_DIRECT_IO_SUPPORT
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_AHBBUS_EXIST
   `else
      `ifdef ATCSPI200_EILMBUS_EXIST
         `ifdef ATCSPI200_REG_APB
	.apb2eilm_clken      (apb2core_clken), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
         `endif // ATCSPI200_REG_APB
      `endif // ATCSPI200_EILMBUS_EXIST
   `endif // ATCSPI200_AHBBUS_EXIST
	.spi_clock           (spi_clk       ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_rstn            (spi_rstn      ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_boot_intr       (spi2_int      ), // (u_spi2) => ()
	.spi_default_mode3   (1'b0          ), // (u_spi2) <= ()
	.spi_rx_dma_ack      (dma_ack[3]    ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.spi_rx_dma_req      (dmareq_spi2_rx), // (u_spi2) => ()
	.spi_tx_dma_ack      (dma_ack[2]    ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.spi_tx_dma_req      (dmareq_spi2_tx), // (u_spi2) => ()
	.scan_enable         (scan_enable   ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.scan_test           (scan_test     ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_clk_in          (spi2_clk_in   ), // (u_spi2) <= ()
	.spi_clk_oe          (spi2_clk_oe   ), // (u_spi2) => ()
	.spi_clk_out         (spi2_clk_out  ), // (u_spi2) => ()
	.spi_cs_n_oe         (spi2_csn_oe   ), // (u_spi2) => ()
	.spi_cs_n_out        (spi2_csn_out  ), // (u_spi2) => ()
	.spi_miso_in         (spi2_miso_in  ), // (u_spi2) <= ()
	.spi_miso_oe         (spi2_miso_oe  ), // (u_spi2) => ()
	.spi_miso_out        (spi2_miso_out ), // (u_spi2) => ()
	.spi_mosi_in         (spi2_mosi_in  ), // (u_spi2) <= ()
	.spi_mosi_oe         (spi2_mosi_oe  ), // (u_spi2) => ()
	.spi_mosi_out        (spi2_mosi_out )  // (u_spi2) => ()
); // end of u_spi2

`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
atcspi200 u_spi3 (
   `ifdef ATCSPI200_AHBBUS_EXIST
	.hclk                (hclk                          ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.hresetn             (hresetn                       ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
   `endif // ATCSPI200_AHBBUS_EXIST
   `ifdef ATCSPI200_EILMBUS_EXIST
	.eilm_addr           (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_clk            (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_rdata          (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.eilm_req            (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_resetn         (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_wait           (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.eilm_wait_cnt       (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_wdata          (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_web            (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
   `endif // ATCSPI200_EILMBUS_EXIST
   `ifdef ATCSPI200_REG_APB
	.pclk                (pclk_spi3                     ), // (u_spi3) <= ()
	.presetn             (presetn                       ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.paddr               (paddr                         ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.penable             (penable                       ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.prdata              (ps20_prdata                   ), // (u_spi3) => (u_ahb2apb)
	.pready              (ps20_pready                   ), // (u_spi3) => (u_ahb2apb)
	.psel                (ps20_psel                     ), // (u_spi3) <= (u_ahb2apb)
	.pwdata              (pwdata                        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite              (pwrite                        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
   `endif // ATCSPI200_REG_APB
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.haddr_mem           ({`ATCSPI200_HADDR_WIDTH{1'b0}}), // () <= ()
	.hrdata_mem          (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hreadyin_mem        (1'b0                          ), // (u_spi3) <= ()
	.hreadyout_mem       (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hresp_mem           (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hsel_mem            (1'b0                          ), // (u_spi3) <= ()
	.htrans_mem          (2'b0                          ), // (u_spi3) <= ()
	.hwrite_mem          (1'b0                          ), // (u_spi3) <= ()
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_REG_AHB
	.haddr_reg           (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hrdata_reg          (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hreadyin_reg        (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hreadyout_reg       (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hresp_reg           (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hsel_reg            (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.htrans_reg          (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hwdata_reg          (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hwrite_reg          (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
   `endif // ATCSPI200_REG_AHB
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_default_as_slave(1'b0                          ), // (u_spi3) <= ()
	.spi_cs_n_in         (spi3_csn_in                   ), // (u_spi3) <= ()
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_hold_n_in       (spi3_holdn_in                 ), // (u_spi3) <= ()
	.spi_hold_n_oe       (spi3_holdn_oe                 ), // (u_spi3) => ()
	.spi_hold_n_out      (spi3_holdn_out                ), // (u_spi3) => ()
	.spi_wp_n_in         (spi3_wpn_in                   ), // (u_spi3) <= ()
	.spi_wp_n_oe         (spi3_wpn_oe                   ), // (u_spi3) => ()
	.spi_wp_n_out        (spi3_wpn_out                  ), // (u_spi3) => ()
   `endif // ATCSPI200_QUADSPI_SUPPORT
   `ifdef ATCSPI200_AHBBUS_EXIST
      `ifdef ATCSPI200_EILMBUS_EXIST
	.ahb2eilm_clken      (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
      `endif // ATCSPI200_EILMBUS_EXIST
      `ifdef ATCSPI200_REG_APB
	.apb2ahb_clken       (apb2ahb_clken                 ), // (u_ahb2apb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
      `endif // ATCSPI200_REG_APB
   `endif // ATCSPI200_AHBBUS_EXIST
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
      `ifdef ATCSPI200_HSPLIT_SUPPORT
	.hmaster_mem         ({`ATCSPI200_HMASTER_BIT{1'b0}}), // () <= ()
	.hsplit_mem          (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
      `endif // ATCSPI200_HSPLIT_SUPPORT
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_REG_EILM
      `ifdef ATCSPI200_EILM_MEM_SUPPORT
	.eilm_reg_sel        (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
      `endif // ATCSPI200_EILM_MEM_SUPPORT
   `endif // ATCSPI200_REG_EILM
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi_cs_n_in         (spi3_csn_in                   ), // (u_spi3) <= ()
      `endif // ATCSPI200_DIRECT_IO_SUPPORT
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_AHBBUS_EXIST
   `else
      `ifdef ATCSPI200_EILMBUS_EXIST
         `ifdef ATCSPI200_REG_APB
	.apb2eilm_clken      (apb2core_clken                ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
         `endif // ATCSPI200_REG_APB
      `endif // ATCSPI200_EILMBUS_EXIST
   `endif // ATCSPI200_AHBBUS_EXIST
	.spi_clock           (spi_clk                       ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_rstn            (spi_rstn                      ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_boot_intr       (spi3_int                      ), // (u_spi3) => ()
	.spi_default_mode3   (1'b0                          ), // (u_spi3) <= ()
	.spi_rx_dma_ack      (dma_ack[10]                   ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.spi_rx_dma_req      (dmareq_spi3_rx                ), // (u_spi3) => ()
	.spi_tx_dma_ack      (dma_ack[9]                    ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.spi_tx_dma_req      (dmareq_spi3_tx                ), // (u_spi3) => ()
	.scan_enable         (scan_enable                   ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.scan_test           (scan_test                     ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_clk_in          (spi3_clk_in                   ), // (u_spi3) <= ()
	.spi_clk_oe          (spi3_clk_oe                   ), // (u_spi3) => ()
	.spi_clk_out         (spi3_clk_out                  ), // (u_spi3) => ()
	.spi_cs_n_oe         (spi3_csn_oe                   ), // (u_spi3) => ()
	.spi_cs_n_out        (spi3_csn_out                  ), // (u_spi3) => ()
	.spi_miso_in         (spi3_miso_in                  ), // (u_spi3) <= ()
	.spi_miso_oe         (spi3_miso_oe                  ), // (u_spi3) => ()
	.spi_miso_out        (spi3_miso_out                 ), // (u_spi3) => ()
	.spi_mosi_in         (spi3_mosi_in                  ), // (u_spi3) <= ()
	.spi_mosi_oe         (spi3_mosi_oe                  ), // (u_spi3) => ()
	.spi_mosi_out        (spi3_mosi_out                 )  // (u_spi3) => ()
); // end of u_spi3

`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
atcspi200 u_spi4 (
   `ifdef ATCSPI200_AHBBUS_EXIST
	.hclk                (hclk                          ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.hresetn             (hresetn                       ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
   `endif // ATCSPI200_AHBBUS_EXIST
   `ifdef ATCSPI200_EILMBUS_EXIST
	.eilm_addr           (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_clk            (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_rdata          (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.eilm_req            (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_resetn         (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_wait           (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.eilm_wait_cnt       (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_wdata          (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.eilm_web            (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
   `endif // ATCSPI200_EILMBUS_EXIST
   `ifdef ATCSPI200_REG_APB
	.pclk                (pclk_spi4                     ), // (u_spi4) <= ()
	.presetn             (presetn                       ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.paddr               (paddr                         ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.penable             (penable                       ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.prdata              (ps21_prdata                   ), // (u_spi4) => (u_ahb2apb)
	.pready              (ps21_pready                   ), // (u_spi4) => (u_ahb2apb)
	.psel                (ps21_psel                     ), // (u_spi4) <= (u_ahb2apb)
	.pwdata              (pwdata                        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite              (pwrite                        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
   `endif // ATCSPI200_REG_APB
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.haddr_mem           ({`ATCSPI200_HADDR_WIDTH{1'b0}}), // () <= ()
	.hrdata_mem          (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hreadyin_mem        (1'b0                          ), // (u_spi4) <= ()
	.hreadyout_mem       (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hresp_mem           (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hsel_mem            (1'b0                          ), // (u_spi4) <= ()
	.htrans_mem          (2'b0                          ), // (u_spi4) <= ()
	.hwrite_mem          (1'b0                          ), // (u_spi4) <= ()
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_REG_AHB
	.haddr_reg           (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hrdata_reg          (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hreadyin_reg        (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hreadyout_reg       (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hresp_reg           (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hsel_reg            (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.htrans_reg          (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hwdata_reg          (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hwrite_reg          (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
   `endif // ATCSPI200_REG_AHB
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_default_as_slave(1'b0                          ), // (u_spi4) <= ()
	.spi_cs_n_in         (spi4_csn_in                   ), // (u_spi4) <= ()
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_hold_n_in       (spi4_holdn_in                 ), // (u_spi4) <= ()
	.spi_hold_n_oe       (spi4_holdn_oe                 ), // (u_spi4) => ()
	.spi_hold_n_out      (spi4_holdn_out                ), // (u_spi4) => ()
	.spi_wp_n_in         (spi4_wpn_in                   ), // (u_spi4) <= ()
	.spi_wp_n_oe         (spi4_wpn_oe                   ), // (u_spi4) => ()
	.spi_wp_n_out        (spi4_wpn_out                  ), // (u_spi4) => ()
   `endif // ATCSPI200_QUADSPI_SUPPORT
   `ifdef ATCSPI200_AHBBUS_EXIST
      `ifdef ATCSPI200_EILMBUS_EXIST
	.ahb2eilm_clken      (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
      `endif // ATCSPI200_EILMBUS_EXIST
      `ifdef ATCSPI200_REG_APB
	.apb2ahb_clken       (apb2ahb_clken                 ), // (u_ahb2apb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
      `endif // ATCSPI200_REG_APB
   `endif // ATCSPI200_AHBBUS_EXIST
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
      `ifdef ATCSPI200_HSPLIT_SUPPORT
	.hmaster_mem         ({`ATCSPI200_HMASTER_BIT{1'b0}}), // () <= ()
	.hsplit_mem          (/* NC */                      ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
      `endif // ATCSPI200_HSPLIT_SUPPORT
   `endif // ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_REG_EILM
      `ifdef ATCSPI200_EILM_MEM_SUPPORT
	.eilm_reg_sel        (/* NC */                      ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
      `endif // ATCSPI200_EILM_MEM_SUPPORT
   `endif // ATCSPI200_REG_EILM
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi_cs_n_in         (spi4_csn_in                   ), // (u_spi4) <= ()
      `endif // ATCSPI200_DIRECT_IO_SUPPORT
   `endif // ATCSPI200_SLAVE_SUPPORT
   `ifdef ATCSPI200_AHBBUS_EXIST
   `else
      `ifdef ATCSPI200_EILMBUS_EXIST
         `ifdef ATCSPI200_REG_APB
	.apb2eilm_clken      (apb2core_clken                ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
         `endif // ATCSPI200_REG_APB
      `endif // ATCSPI200_EILMBUS_EXIST
   `endif // ATCSPI200_AHBBUS_EXIST
	.spi_clock           (spi_clk                       ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_rstn            (spi_rstn                      ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_boot_intr       (spi4_int                      ), // (u_spi4) => ()
	.spi_default_mode3   (1'b0                          ), // (u_spi4) <= ()
	.spi_rx_dma_ack      (dma_ack[12]                   ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.spi_rx_dma_req      (dmareq_spi4_rx                ), // (u_spi4) => ()
	.spi_tx_dma_ack      (dma_ack[11]                   ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.spi_tx_dma_req      (dmareq_spi4_tx                ), // (u_spi4) => ()
	.scan_enable         (scan_enable                   ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.scan_test           (scan_test                     ), // (u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.spi_clk_in          (spi4_clk_in                   ), // (u_spi4) <= ()
	.spi_clk_oe          (spi4_clk_oe                   ), // (u_spi4) => ()
	.spi_clk_out         (spi4_clk_out                  ), // (u_spi4) => ()
	.spi_cs_n_oe         (spi4_csn_oe                   ), // (u_spi4) => ()
	.spi_cs_n_out        (spi4_csn_out                  ), // (u_spi4) => ()
	.spi_miso_in         (spi4_miso_in                  ), // (u_spi4) <= ()
	.spi_miso_oe         (spi4_miso_oe                  ), // (u_spi4) => ()
	.spi_miso_out        (spi4_miso_out                 ), // (u_spi4) => ()
	.spi_mosi_in         (spi4_mosi_in                  ), // (u_spi4) <= ()
	.spi_mosi_oe         (spi4_mosi_oe                  ), // (u_spi4) => ()
	.spi_mosi_out        (spi4_mosi_out                 )  // (u_spi4) => ()
); // end of u_spi4

`endif // AE350_SPI4_SUPPORT
`ifdef AE350_SDC_SUPPORT
atfsdc010 u_sdc (
	.sys_rstn      (presetn     ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.sys_clk       (pclk        ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_dtrom,u_sdc,u_ssp) <= ()
	.io_sd_rsp     (T_sd_rsp    ), // (u_sdc) <= ()
   `ifdef ATFSDC010_AHB_INF
	.hsel          (/* NC */    ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hreadyi       (/* NC */    ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.haddr         (/* NC */    ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.htrans        (/* NC */    ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hsize         (/* NC */    ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hwrite        (/* NC */    ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
	.hwdata        (/* NC */    ), // (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4) <= (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp)
   `else
	.psel          (ps11_psel   ), // (u_sdc) <= (u_ahb2apb)
	.penable       (penable     ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite        (pwrite      ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwdata        (pwdata      ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.paddr         (paddr[7:0]  ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
   `endif // ATFSDC010_AHB_INF
	.sdc_clk       (sdc_clk     ), // (u_sdc) <= ()
	.sdc_rstn      (presetn     ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.io_sd_cd      (T_sd_cd     ), // (u_sdc) <= ()
	.io_sd_wp      (T_sd_wp     ), // (u_sdc) <= ()
	.io_sd_dat0_in (T_sd_dat0_in), // (u_sdc) <= ()
   `ifdef ATFSDC010_BUS_4
	.io_sd_dat1_in (T_sd_dat1_in), // (u_sdc) <= ()
	.io_sd_dat2_in (T_sd_dat2_in), // (u_sdc) <= ()
	.io_sd_dat3_in (T_sd_dat3_in), // (u_sdc) <= ()
   `endif // ATFSDC010_BUS_4
   `ifdef ATFSDC010_BUS_8
	.io_sd_dat1_in (T_sd_dat1_in), // (u_sdc) <= ()
	.io_sd_dat2_in (T_sd_dat2_in), // (u_sdc) <= ()
	.io_sd_dat3_in (T_sd_dat3_in), // (u_sdc) <= ()
	.io_sd_dat4_in (1'b0        ), // (u_sdc) <= ()
	.io_sd_dat5_in (1'b0        ), // (u_sdc) <= ()
	.io_sd_dat6_in (1'b0        ), // (u_sdc) <= ()
	.io_sd_dat7_in (1'b0        ), // (u_sdc) <= ()
   `endif // ATFSDC010_BUS_8
	.sdc_dma_ack   (dma_ack[9]  ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
   `ifdef ATFSDC010_AHB_INF
	.hrdata        (/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hready        (/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hresp         (/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
   `else
	.prdata        (ps11_prdata ), // (u_sdc) => (u_ahb2apb)
   `endif // ATFSDC010_AHB_INF
	.sdc_dma_req   (dmareq_sdc  ), // (u_sdc) => ()
	.sdc_intr      (sdc_int     ), // (u_sdc) => ()
	.io_sd_cmd     (sd_cmd      ), // (u_sdc) => ()
	.io_sd_cmd_oe  (sd_cmd_oe   ), // (u_sdc) => ()
	.io_sd_dat0_out(sd_dat0_out ), // (u_sdc) => ()
   `ifdef ATFSDC010_BUS_4
	.io_sd_dat1_out(sd_dat1_out ), // (u_sdc) => ()
	.io_sd_dat2_out(sd_dat2_out ), // (u_sdc) => ()
	.io_sd_dat3_out(sd_dat3_out ), // (u_sdc) => ()
   `endif // ATFSDC010_BUS_4
   `ifdef ATFSDC010_BUS_8
	.io_sd_dat1_out(sd_dat1_out ), // (u_sdc) => ()
	.io_sd_dat2_out(sd_dat2_out ), // (u_sdc) => ()
	.io_sd_dat3_out(sd_dat3_out ), // (u_sdc) => ()
	.io_sd_dat4_out(/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.io_sd_dat5_out(/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.io_sd_dat6_out(/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.io_sd_dat7_out(/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
   `endif // ATFSDC010_BUS_8
	.io_sd_dat0_oe (sd_dat0_oe  ), // (u_sdc) => ()
   `ifdef ATFSDC010_BUS_4
	.io_sd_dat1_oe (sd_dat1_oe  ), // (u_sdc) => ()
	.io_sd_dat2_oe (sd_dat2_oe  ), // (u_sdc) => ()
	.io_sd_dat3_oe (sd_dat3_oe  ), // (u_sdc) => ()
   `endif // ATFSDC010_BUS_4
   `ifdef ATFSDC010_BUS_8
	.io_sd_dat1_oe (sd_dat1_oe  ), // (u_sdc) => ()
	.io_sd_dat2_oe (sd_dat2_oe  ), // (u_sdc) => ()
	.io_sd_dat3_oe (sd_dat3_oe  ), // (u_sdc) => ()
	.io_sd_dat4_oe (/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.io_sd_dat5_oe (/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.io_sd_dat6_oe (/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.io_sd_dat7_oe (/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
   `endif // ATFSDC010_BUS_8
	.io_sd_clk     (sd_clk      ), // (u_sdc) => ()
	.io_sd_power   (sd_power    ), // (u_sdc) => ()
	.io_sd_gpo     (/* NC */    )  // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
); // end of u_sdc

`endif // AE350_SDC_SUPPORT
`ifdef AE350_DMA_AXI_SUPPORT
atcdmac300 u_dmac_axi (
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.m1_araddr (dmac1_araddr   ), // (u_dmac_axi) => ()
	.m1_arburst(dmac1_arburst  ), // (u_dmac_axi) => ()
	.m1_arcache(dmac1_arcache  ), // (u_dmac_axi) => ()
	.m1_arid   (dmac1_arid_3bit), // (u_dmac_axi) => ()
	.m1_arlen  (dmac1_arlen    ), // (u_dmac_axi) => ()
	.m1_arlock (dmac1_arlock   ), // (u_dmac_axi) => ()
	.m1_arprot (dmac1_arprot   ), // (u_dmac_axi) => ()
	.m1_arready(dmac1_arready  ), // (u_dmac_axi) <= ()
	.m1_arsize (dmac1_arsize   ), // (u_dmac_axi) => ()
	.m1_arvalid(dmac1_arvalid  ), // (u_dmac_axi) => ()
	.m1_awaddr (dmac1_awaddr   ), // (u_dmac_axi) => ()
	.m1_awburst(dmac1_awburst  ), // (u_dmac_axi) => ()
	.m1_awcache(dmac1_awcache  ), // (u_dmac_axi) => ()
	.m1_awid   (dmac1_awid_3bit), // (u_dmac_axi) => ()
	.m1_awlen  (dmac1_awlen    ), // (u_dmac_axi) => ()
	.m1_awlock (dmac1_awlock   ), // (u_dmac_axi) => ()
	.m1_awprot (dmac1_awprot   ), // (u_dmac_axi) => ()
	.m1_awready(dmac1_awready  ), // (u_dmac_axi) <= ()
	.m1_awsize (dmac1_awsize   ), // (u_dmac_axi) => ()
	.m1_awvalid(dmac1_awvalid  ), // (u_dmac_axi) => ()
	.m1_bid    (dmac1_bid_3bit ), // (u_dmac_axi) <= ()
	.m1_bready (dmac1_bready   ), // (u_dmac_axi) => ()
	.m1_bresp  (dmac1_bresp    ), // (u_dmac_axi) <= ()
	.m1_bvalid (dmac1_bvalid   ), // (u_dmac_axi) <= ()
	.m1_rdata  (dmac1_rdata    ), // (u_dmac_axi) <= ()
	.m1_rid    (dmac1_rid_3bit ), // (u_dmac_axi) <= ()
	.m1_rlast  (dmac1_rlast    ), // (u_dmac_axi) <= ()
	.m1_rready (dmac1_rready   ), // (u_dmac_axi) => ()
	.m1_rresp  (dmac1_rresp    ), // (u_dmac_axi) <= ()
	.m1_rvalid (dmac1_rvalid   ), // (u_dmac_axi) <= ()
	.m1_wdata  (dmac1_wdata    ), // (u_dmac_axi) => ()
	.m1_wlast  (dmac1_wlast    ), // (u_dmac_axi) => ()
	.m1_wready (dmac1_wready   ), // (u_dmac_axi) <= ()
	.m1_wstrb  (dmac1_wstrb    ), // (u_dmac_axi) => ()
	.m1_wvalid (dmac1_wvalid   ), // (u_dmac_axi) => ()
   `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.paddr     (paddr          ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.penable   (penable        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.prdata    (ps12_prdata    ), // (u_dmac_ahb,u_dmac_axi) => (u_ahb2apb)
	.pready    (ps12_pready    ), // (u_dmac_ahb,u_dmac_axi) => (u_ahb2apb)
	.psel      (ps12_psel      ), // (u_dmac_ahb,u_dmac_axi) <= (u_ahb2apb)
	.pslverr   (ps12_pslverr   ), // (u_dmac_ahb,u_dmac_axi) => (u_ahb2apb)
	.pwdata    (pwdata         ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite    (pwrite         ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk      (pclk           ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_dtrom,u_sdc,u_ssp) <= ()
	.presetn   (presetn        ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.m0_araddr (dmac0_araddr   ), // (u_dmac_axi) => ()
	.m0_arburst(dmac0_arburst  ), // (u_dmac_axi) => ()
	.m0_arcache(dmac0_arcache  ), // (u_dmac_axi) => ()
	.m0_arid   (dmac0_arid_3bit), // (u_dmac_axi) => ()
	.m0_arlen  (dmac0_arlen    ), // (u_dmac_axi) => ()
	.m0_arlock (dmac0_arlock   ), // (u_dmac_axi) => ()
	.m0_arprot (dmac0_arprot   ), // (u_dmac_axi) => ()
	.m0_arready(dmac0_arready  ), // (u_dmac_axi) <= ()
	.m0_arsize (dmac0_arsize   ), // (u_dmac_axi) => ()
	.m0_arvalid(dmac0_arvalid  ), // (u_dmac_axi) => ()
	.m0_awaddr (dmac0_awaddr   ), // (u_dmac_axi) => ()
	.m0_awburst(dmac0_awburst  ), // (u_dmac_axi) => ()
	.m0_awcache(dmac0_awcache  ), // (u_dmac_axi) => ()
	.m0_awid   (dmac0_awid_3bit), // (u_dmac_axi) => ()
	.m0_awlen  (dmac0_awlen    ), // (u_dmac_axi) => ()
	.m0_awlock (dmac0_awlock   ), // (u_dmac_axi) => ()
	.m0_awprot (dmac0_awprot   ), // (u_dmac_axi) => ()
	.m0_awready(dmac0_awready  ), // (u_dmac_axi) <= ()
	.m0_awsize (dmac0_awsize   ), // (u_dmac_axi) => ()
	.m0_awvalid(dmac0_awvalid  ), // (u_dmac_axi) => ()
	.m0_bid    (dmac0_bid_3bit ), // (u_dmac_axi) <= ()
	.m0_bready (dmac0_bready   ), // (u_dmac_axi) => ()
	.m0_bresp  (dmac0_bresp    ), // (u_dmac_axi) <= ()
	.m0_bvalid (dmac0_bvalid   ), // (u_dmac_axi) <= ()
	.m0_rdata  (dmac0_rdata    ), // (u_dmac_axi) <= ()
	.m0_rid    (dmac0_rid_3bit ), // (u_dmac_axi) <= ()
	.m0_rlast  (dmac0_rlast    ), // (u_dmac_axi) <= ()
	.m0_rready (dmac0_rready   ), // (u_dmac_axi) => ()
	.m0_rresp  (dmac0_rresp    ), // (u_dmac_axi) <= ()
	.m0_rvalid (dmac0_rvalid   ), // (u_dmac_axi) <= ()
	.m0_wdata  (dmac0_wdata    ), // (u_dmac_axi) => ()
	.m0_wlast  (dmac0_wlast    ), // (u_dmac_axi) => ()
	.m0_wready (dmac0_wready   ), // (u_dmac_axi) <= ()
	.m0_wstrb  (dmac0_wstrb    ), // (u_dmac_axi) => ()
	.m0_wvalid (dmac0_wvalid   ), // (u_dmac_axi) => ()
	.aclk      (aclk           ), // (u_dmac_axi) <= ()
	.aresetn   (aresetn        ), // (u_dmac_axi) <= ()
	.dma_ack   (dma_ack        ), // (u_dmac_ahb,u_dmac_axi) => (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2)
	.dma_req   (dma_req        ), // (u_dmac_ahb,u_dmac_axi) <= ()
	.dma_int   (dma_int        )  // (u_dmac_ahb,u_dmac_axi) => ()
); // end of u_dmac_axi

`endif // AE350_DMA_AXI_SUPPORT
`ifdef AE350_DMA_AHB_SUPPORT
atcdmac110 u_dmac_ahb (
	.haddr_mst  (dmac_haddr  ), // (u_dmac_ahb) => ()
	.hburst_mst (dmac_hburst ), // (u_dmac_ahb) => ()
	.hbusreq_mst(/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hgrant_mst (1'b1        ), // (u_dmac_ahb) <= ()
	.hlock_mst  (/* NC */    ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.hprot_mst  (dmac_hprot  ), // (u_dmac_ahb) => ()
	.hrdata_mst (dmac_hrdata ), // (u_dmac_ahb) <= ()
	.hready_mst (dmac_hready ), // (u_dmac_ahb) <= ()
	.hresp_mst  (dmac_hresp  ), // (u_dmac_ahb) <= ()
	.hsize_mst  (dmac_hsize  ), // (u_dmac_ahb) => ()
	.htrans_mst (dmac_htrans ), // (u_dmac_ahb) => ()
	.hwdata_mst (dmac_hwdata ), // (u_dmac_ahb) => ()
	.hwrite_mst (dmac_hwrite ), // (u_dmac_ahb) => ()
	.hclk       (hclk        ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.hresetn    (hresetn     ), // (u_ahb2apb,u_dmac_ahb,u_spi1,u_spi2,u_spi3,u_spi4) <= ()
	.paddr      (paddr       ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.penable    (penable     ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.prdata     (ps12_prdata ), // (u_dmac_ahb,u_dmac_axi) => (u_ahb2apb)
	.pready     (ps12_pready ), // (u_dmac_ahb,u_dmac_axi) => (u_ahb2apb)
	.psel       (ps12_psel   ), // (u_dmac_ahb,u_dmac_axi) <= (u_ahb2apb)
	.pslverr    (ps12_pslverr), // (u_dmac_ahb,u_dmac_axi) => (u_ahb2apb)
	.pwdata     (pwdata      ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite     (pwrite      ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pclk       (pclk        ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_dtrom,u_sdc,u_ssp) <= ()
	.presetn    (presetn     ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.dma_ack    (dma_ack     ), // (u_dmac_ahb,u_dmac_axi) => (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2)
	.dma_req    (dma_req     ), // (u_dmac_ahb,u_dmac_axi) <= ()
	.dma_int    (dma_int     )  // (u_dmac_ahb,u_dmac_axi) => ()
); // end of u_dmac_ahb

`endif // AE350_DMA_AHB_SUPPORT
`ifdef AE350_SSP_SUPPORT
atfssp020 u_ssp (
	.PCLK          (pclk           ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_dtrom,u_sdc,u_ssp) <= ()
	.SSPCLK        (sspclk         ), // (u_ssp) <= ()
	.PRSTn         (presetn        ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= ()
	.ssp_rstn      (ssp_rstn       ), // (u_ssp) <= ()
	.psel          (ps13_psel      ), // (u_ssp) <= (u_ahb2apb)
	.penable       (penable        ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite        (pwrite         ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pbe           (4'hf           ), // (u_ssp) <= ()
	.paddr         (paddr          ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwdata        (pwdata         ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.ssp_txdmagnt  (dma_ack[14]    ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.ssp_rxdmagnt  (dma_ack[15]    ), // (u_i2c,u_i2c2,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2) <= (u_dmac_ahb,u_dmac_axi)
	.sclk_in       (T_ssp_sclk_in  ), // (u_ssp) <= ()
	.fs_in         (T_ssp_fs_in    ), // (u_ssp) <= ()
	.rxd           (T_ssp_rxd      ), // (u_ssp) <= ()
	.prdata_r      (ps13_prdata    ), // (u_ssp) => (u_ahb2apb)
	.ssp_sclk_oe   (ssp_sclk_oe    ), // (u_ssp) => ()
	.ssp_fs_oe     (ssp_fs_oe      ), // (u_ssp) => ()
	.sclk_out_r    (ssp_sclk_out   ), // (u_ssp) => ()
	.fs_out_r      (ssp_fs_out     ), // (u_ssp) => ()
   `ifdef ATFSSP020_HDA_SUPPORT
	.ssp_rxd_oe    (/* NC */       ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.rxd_out_r     (/* NC */       ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
   `endif // ATFSSP020_HDA_SUPPORT
   `ifdef ATFSSP020_AC97_FUNCTION
	.ac97_resetn_r (ssp_ac97_resetn), // (u_ssp) => ()
   `endif // ATFSSP020_AC97_FUNCTION
	.txd_r         (ssp_txd        ), // (u_ssp) => ()
	.txd_oe_r      (ssp_txd_oe     ), // (u_ssp) => ()
	.ssp_ffmt      (/* NC */       ), // (u_ahb2apb,u_dmac_ahb,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp) => (u_sdc,u_spi1,u_spi2,u_spi3,u_spi4)
	.ssp_txdmareq_r(dmareq_ssp_tx  ), // (u_ssp) => ()
	.ssp_rxdmareq_r(dmareq_ssp_rx  ), // (u_ssp) => ()
	.ssp_intr      (ssp_intr       )  // (u_ssp) => ()
); // end of u_ssp

`endif // AE350_SSP_SUPPORT
`ifdef ATCAPBBRG100_SLV_14
sample_dtrom #(
	.MEM_SIZE_KB     (DTROM_SIZE_KB   )
) u_dtrom (
	.pclk   (pclk        ), // (u_ahb2apb,u_dmac_ahb,u_dmac_axi,u_dtrom,u_sdc,u_ssp) <= ()
	.paddr  (paddr[19:0] ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.psel   (ps14_psel   ), // (u_dtrom) <= (u_ahb2apb)
	.penable(penable     ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwrite (pwrite      ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pwdata (pwdata      ), // (u_dmac_ahb,u_dmac_axi,u_dtrom,u_gpio,u_i2c,u_i2c2,u_pit,u_pit2,u_pit3,u_pit4,u_pit5,u_sdc,u_spi1,u_spi2,u_spi3,u_spi4,u_ssp,u_uart1,u_uart2,u_wdt) <= (u_ahb2apb)
	.pready (ps14_pready ), // (u_dtrom) => (u_ahb2apb)
	.prdata (ps14_prdata ), // (u_dtrom) => (u_ahb2apb)
	.pslverr(ps14_pslverr)  // (u_dtrom) => (u_ahb2apb)
); // end of u_dtrom

`endif // ATCAPBBRG100_SLV_14
endmodule
// VPERL_GENERATED_END
