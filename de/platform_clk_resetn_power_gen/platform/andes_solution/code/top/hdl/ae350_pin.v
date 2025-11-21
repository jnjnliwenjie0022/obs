`include "ae350_config.vh"
`include "ae350_const.vh"

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

`ifdef AE350_GPIO_SUPPORT
	`include "atcgpio100_config.vh"
	`include "atcgpio100_const.vh"
`endif 
`ifdef AE350_PIT_SUPPORT
	`include "atcpit100_config.vh"
	`include "atcpit100_const.vh"
`endif 

module ae350_pin (
// VPERL: &PORTLIST;
// VPERL_GENERATED_BEGIN
	  X_hw_rstn,
	  T_hw_rstn,
	  X_por_b,  
	  T_por_b,  
`ifdef PLATFORM_DEBUG_PORT
	  X_tms,    
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
	  X_trst,   
	  X_tdi,    
	  X_tdo,    
   `endif // PLATFORM_JTAG_TWOWIRE
	  pin_tms_in,
	  pin_tms_out,
	  pin_tms_out_en,
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
	  pin_trst_in,
	  pin_trst_out,
	  pin_trst_out_en,
	  pin_tdi_in,
	  pin_tdi_out,
	  pin_tdi_out_en,
	  pin_tdo_in,
	  pin_tdo_out,
	  pin_tdo_out_en,
   `endif // PLATFORM_JTAG_TWOWIRE
   `ifdef PLATFORM_JDTM_SECURE_SUPPORT
	  X_secure_mode,
	  T_secure_mode,
   `endif // PLATFORM_JDTM_SECURE_SUPPORT
`endif // PLATFORM_DEBUG_PORT
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi1_holdn,
	  X_spi1_wpn,
	  spi1_holdn_in,
	  spi1_wpn_in,
	  spi1_holdn_out,
	  spi1_holdn_oe,
	  spi1_wpn_out,
	  spi1_wpn_oe,
   `endif // ATCSPI200_QUADSPI_SUPPORT
	  X_spi1_clk,
	  X_spi1_csn,
	  X_spi1_miso,
	  X_spi1_mosi,
	  spi1_clk_in,
	  spi1_csn_in,
	  spi1_miso_in,
	  spi1_mosi_in,
	  spi1_clk_out,
	  spi1_clk_oe,
	  spi1_csn_out,
	  spi1_csn_oe,
	  spi1_miso_out,
	  spi1_miso_oe,
	  spi1_mosi_out,
	  spi1_mosi_oe,
`endif // AE350_SPI1_SUPPORT
`ifdef AE350_SPI2_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
	  X_spi2_clk,
	  X_spi2_csn,
	  X_spi2_miso,
	  X_spi2_mosi,
   `endif // NDS_BOARD_CF1
	  spi2_clk_in,
	  spi2_csn_in,
	  spi2_miso_in,
	  spi2_mosi_in,
	  spi2_clk_out,
	  spi2_clk_oe,
	  spi2_csn_out,
	  spi2_csn_oe,
	  spi2_miso_out,
	  spi2_miso_oe,
	  spi2_mosi_out,
	  spi2_mosi_oe,
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi2_holdn,
	  X_spi2_wpn,
	  spi2_holdn_in,
	  spi2_wpn_in,
	  spi2_holdn_out,
	  spi2_holdn_oe,
	  spi2_wpn_out,
	  spi2_wpn_oe,
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI2_SUPPORT
`ifdef AE350_SPI3_SUPPORT
	  X_spi3_clk,
	  X_spi3_csn,
	  X_spi3_miso,
	  X_spi3_mosi,
	  spi3_clk_in,
	  spi3_csn_in,
	  spi3_miso_in,
	  spi3_mosi_in,
	  spi3_clk_out,
	  spi3_clk_oe,
	  spi3_csn_out,
	  spi3_csn_oe,
	  spi3_miso_out,
	  spi3_miso_oe,
	  spi3_mosi_out,
	  spi3_mosi_oe,
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi3_holdn,
	  X_spi3_wpn,
	  spi3_holdn_in,
	  spi3_wpn_in,
	  spi3_holdn_out,
	  spi3_holdn_oe,
	  spi3_wpn_out,
	  spi3_wpn_oe,
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI3_SUPPORT
`ifdef AE350_SPI4_SUPPORT
	  X_spi4_clk,
	  X_spi4_csn,
	  X_spi4_miso,
	  X_spi4_mosi,
	  spi4_clk_in,
	  spi4_csn_in,
	  spi4_miso_in,
	  spi4_mosi_in,
	  spi4_clk_out,
	  spi4_clk_oe,
	  spi4_csn_out,
	  spi4_csn_oe,
	  spi4_miso_out,
	  spi4_miso_oe,
	  spi4_mosi_out,
	  spi4_mosi_oe,
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi4_holdn,
	  X_spi4_wpn,
	  spi4_holdn_in,
	  spi4_wpn_in,
	  spi4_holdn_out,
	  spi4_holdn_oe,
	  spi4_wpn_out,
	  spi4_wpn_oe,
   `endif // ATCSPI200_QUADSPI_SUPPORT
`endif // AE350_SPI4_SUPPORT
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE350_I2C_SUPPORT
	  X_i2c_scl,
	  X_i2c_sda,
   `endif // AE350_I2C_SUPPORT
`endif // NDS_BOARD_CF1
`ifdef AE350_I2C_SUPPORT
	  i2c_scl_in,
	  i2c_sda_in,
	  i2c_scl,  
	  i2c_sda,  
`endif // AE350_I2C_SUPPORT
`ifdef AE350_I2C2_SUPPORT
	  i2c2_scl_in,
	  i2c2_sda_in,
	  i2c2_scl, 
	  i2c2_sda, 
`endif // AE350_I2C2_SUPPORT
`ifdef AE350_SSP_SUPPORT
	  X_ssp_rxd, // (I),   Receive data
	  X_ssp_txd, // (O),   Transmit Data
	  X_ssp_sclk, // (IO),  Serial clock
	  X_ssp_fs,  // (IO),  Frame/Sync 
	  X_ssp_ac97_resetn, // (O),   AC97 reset
	  T_ssp_rxd,
	  ssp_txd,  
	  T_ssp_sclk_in,
	  T_ssp_fs_in,
	  ssp_ac97_resetn,
	  ssp_sclk_out,
	  ssp_fs_out,
	  ssp_txd_oe,
	  ssp_sclk_oe,
	  ssp_fs_oe,
`endif // AE350_SSP_SUPPORT
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE350_UART1_SUPPORT
	  X_uart1_txd,
	  X_uart1_rxd,
   `endif // AE350_UART1_SUPPORT
`endif // NDS_BOARD_CF1
`ifdef AE350_UART1_SUPPORT
   `ifdef NDS_FPGA
   `else
	  X_uart1_dsrn,
	  X_uart1_dcdn,
	  X_uart1_rin,
	  X_uart1_dtrn,
	  X_uart1_out1n,
	  X_uart1_out2n,
      `ifdef AE350_UART2_SUPPORT
	  X_uart1_ctsn,
	  X_uart1_rtsn,
      `endif // AE350_UART2_SUPPORT
   `endif // NDS_FPGA
   `ifdef AE350_UART2_SUPPORT
   `else
	  X_uart1_ctsn,
	  X_uart1_rtsn,
   `endif // AE350_UART2_SUPPORT
`endif // AE350_UART1_SUPPORT
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE350_UART2_SUPPORT
	  X_uart2_txd,
	  X_uart2_rxd,
   `endif // AE350_UART2_SUPPORT
`endif // NDS_BOARD_CF1
`ifdef NDS_FPGA
`else
   `ifdef AE350_UART2_SUPPORT
	  X_uart2_ctsn,
	  X_uart2_rtsn,
	  X_uart2_dcdn,
	  X_uart2_dsrn,
	  X_uart2_rin,
	  X_uart2_dtrn,
	  X_uart2_out1n,
	  X_uart2_out2n,
   `endif // AE350_UART2_SUPPORT
`endif // NDS_FPGA
`ifdef AE350_UART1_SUPPORT
	  uart1_txd,
	  uart1_rtsn,
	  uart1_rxd,
	  uart1_ctsn,
	  uart1_dsrn,
	  uart1_dcdn,
	  uart1_rin,
	  uart1_dtrn,
	  uart1_out1n,
	  uart1_out2n,
`endif // AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
	  uart2_txd,
	  uart2_rtsn,
	  uart2_rxd,
	  uart2_ctsn,
	  uart2_dcdn,
	  uart2_dsrn,
	  uart2_rin,
	  uart2_dtrn,
	  uart2_out1n,
	  uart2_out2n,
`endif // AE350_UART2_SUPPORT
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE350_PIT_SUPPORT
	  X_pwm_ch0,
   `endif // AE350_PIT_SUPPORT
`endif // NDS_BOARD_CF1
`ifdef AE350_PIT_SUPPORT
	  ch0_pwm,  
	  ch0_pwmoe,
   `ifdef NDS_BOARD_CF1
   `else
      `ifdef ATCPIT100_CH1_SUPPORT
	  X_pwm_ch1,
      `endif // ATCPIT100_CH1_SUPPORT
   `endif // NDS_BOARD_CF1
   `ifdef ATCPIT100_CH1_SUPPORT
	  ch1_pwm,  
	  ch1_pwmoe,
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
      `ifdef ATCPIT100_CH2_SUPPORT
	  X_pwm_ch2,
      `endif // ATCPIT100_CH2_SUPPORT
   `endif // NDS_BOARD_CF1
   `ifdef ATCPIT100_CH2_SUPPORT
	  ch2_pwm,  
	  ch2_pwmoe,
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef NDS_BOARD_CF1
   `else
      `ifdef ATCPIT100_CH3_SUPPORT
	  X_pwm_ch3,
      `endif // ATCPIT100_CH3_SUPPORT
   `endif // NDS_BOARD_CF1
   `ifdef ATCPIT100_CH3_SUPPORT
	  ch3_pwm,  
	  ch3_pwmoe,
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT_SUPPORT
`ifdef AE350_PIT2_SUPPORT
	  pit2_ch0_pwm,
	  pit2_ch0_pwmoe,
   `ifdef ATCPIT100_CH1_SUPPORT
	  pit2_ch1_pwm,
	  pit2_ch1_pwmoe,
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	  pit2_ch2_pwm,
	  pit2_ch2_pwmoe,
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	  pit2_ch3_pwm,
	  pit2_ch3_pwmoe,
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT2_SUPPORT
`ifdef AE350_PIT3_SUPPORT
	  pit3_ch0_pwm,
	  pit3_ch0_pwmoe,
   `ifdef ATCPIT100_CH1_SUPPORT
	  pit3_ch1_pwm,
	  pit3_ch1_pwmoe,
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	  pit3_ch2_pwm,
	  pit3_ch2_pwmoe,
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	  pit3_ch3_pwm,
	  pit3_ch3_pwmoe,
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT3_SUPPORT
`ifdef AE350_PIT4_SUPPORT
	  pit4_ch0_pwm,
	  pit4_ch0_pwmoe,
   `ifdef ATCPIT100_CH1_SUPPORT
	  pit4_ch1_pwm,
	  pit4_ch1_pwmoe,
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	  pit4_ch2_pwm,
	  pit4_ch2_pwmoe,
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	  pit4_ch3_pwm,
	  pit4_ch3_pwmoe,
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT4_SUPPORT
`ifdef AE350_PIT5_SUPPORT
	  pit5_ch0_pwm,
	  pit5_ch0_pwmoe,
   `ifdef ATCPIT100_CH1_SUPPORT
	  pit5_ch1_pwm,
	  pit5_ch1_pwmoe,
   `endif // ATCPIT100_CH1_SUPPORT
   `ifdef ATCPIT100_CH2_SUPPORT
	  pit5_ch2_pwm,
	  pit5_ch2_pwmoe,
   `endif // ATCPIT100_CH2_SUPPORT
   `ifdef ATCPIT100_CH3_SUPPORT
	  pit5_ch3_pwm,
	  pit5_ch3_pwmoe,
   `endif // ATCPIT100_CH3_SUPPORT
`endif // AE350_PIT5_SUPPORT
`ifdef NDS_FPGA
   `ifdef NDS_BOARD_ORCA
	  X_flash_dir,
   `endif // NDS_BOARD_ORCA
`endif // NDS_FPGA
`ifdef AE350_SDC_SUPPORT
	  X_sd_cd,   // (I),   Card detect
	  X_sd_wp,   // (I),   Card write protect
	  X_sd_clk,  // (O),   Clock
	  X_sd_cmd_rsp, // (IO),  Commands and responses
	  X_sd_dat0, // (IO),  Data line bit[0]
	  X_sd_dat1, // (IO),  Data line bit[1]
	  X_sd_dat2, // (IO),  Data line bit[2]
	  X_sd_dat3, // (IO),  Data line bit[3]
	  X_sd_power_on,
	  T_sd_cd,  
	  T_sd_wp,  
	  sd_clk,   
	  T_sd_rsp, 
	  sd_cmd,   
	  sd_cmd_oe,
	  T_sd_dat3_in,
	  T_sd_dat2_in,
	  T_sd_dat1_in,
	  T_sd_dat0_in,
	  sd_dat3_out,
	  sd_dat2_out,
	  sd_dat1_out,
	  sd_dat0_out,
	  sd_dat3_oe,
	  sd_dat2_oe,
	  sd_dat1_oe,
	  sd_dat0_oe,
	  sd_power, 
`endif // AE350_SDC_SUPPORT
`ifdef NDS_FPGA
   `ifdef AE350_SMC_SUPPORT
	  X_memdata, // (IO),  Memory data bus
   `endif // AE350_SMC_SUPPORT
`else
   `ifdef AE350_SMC_SUPPORT
	  X_memdata, // (IO),  Memory data bus
   `endif // AE350_SMC_SUPPORT
`endif // NDS_FPGA
`ifdef AE350_SMC_SUPPORT
	  X_memaddr, // (IO),  Memory address bus
	  X_smc_we_b,
	  X_smc_cs_b, // (O),   Chip select
	  X_smc_oe_b, // (O),   Output enable
	  smc_we_n, 
	  smc_cs_n_0,
	  smc_oe_n, 
	  T_memdata,
	  smc_dqout,
	  smc_data_oe,
	  smc_addr, 
`endif // AE350_SMC_SUPPORT
`ifdef AE350_MAC_SUPPORT
	  X_tx_clk,  // (I),   MII transmit clock
	  X_tx_en,   // (O),   MII transmit enable
	  X_txd,     // (O),   MII transmit data
	  X_rx_clk,  // (I),   MII receive clock
	  X_rx_dv,   // (I),   MII receive data valid
	  X_rx_er,   // (I),   MII receive error
	  X_rxd,     // (I),   MII receive data
	  X_crs,     // (I),   MII carrier sense
	  X_col,     // (I),   MII collision detected
	  X_mdc,     // (O),   MII management data clock
	  X_mdio,    // (IO),  MII management data input/output
	  X_phy_linksts, // (I),   PHY link status
	  X_pdn_phy, // (O),   This pin is used to power down PHY
	  T_tx_clk, 
	  tx_en,    
	  txd,      
	  T_rx_clk, 
	  T_rx_dv,  
	  T_rx_er,  
	  T_rxd,    
	  T_crs,    
	  T_col,    
	  mdc,      
	  T_mdio,   
	  mdio_out, 
	  mdio_out_en,
	  T_phy_linksts,
	  pdn_phy,  
`endif // AE350_MAC_SUPPORT
`ifdef AE350_LCDC_SUPPORT
	  X_clpower, // (O),   LCD panel power enable
	  X_cllp,    // (O),   Line syn. pulse(STN)/horizontal syn. pulse(TFT)
	  X_clcp,    // (O),   LCD panel clock
	  X_clfp,    // (O),   Frame pulse(STN)/vertical syn. pulse(TFT)
	  X_clac,    // (O),   STN AC bias driver or TFT data enable output
	  X_cld,     // (O),   LCD panel data
	  X_clle,    // (O),   Line end signal
	  clpower,  
	  cllp,     
	  clcp,     
	  clfp,     
	  clac,     
	  cld,      
	  clle,     
`endif // AE350_LCDC_SUPPORT
`ifdef NDS_BOARD_CF1
	  cf1_pinmux_ctrl0,
	  cf1_pinmux_ctrl1,
   `ifdef AE350_GPIO_SUPPORT
	  X_gpio,   
   `endif // AE350_GPIO_SUPPORT
`else
   `ifdef AE350_GPIO_SUPPORT
	  X_gpio,   
   `endif // AE350_GPIO_SUPPORT
`endif // NDS_BOARD_CF1
`ifdef AE350_GPIO_SUPPORT
	  gpio_in,  
	  gpio_oe,  
	  gpio_out, 
   `ifdef ATCGPIO100_PULL_SUPPORT
	  gpio_pulldown,
	  gpio_pullup,
   `endif // ATCGPIO100_PULL_SUPPORT
`endif // AE350_GPIO_SUPPORT
`ifdef NDS_FPGA
`else
	  X_oschio, 
`endif // NDS_FPGA
	  X_oschin, 
	  T_osch    
// VPERL_GENERATED_END

);

// Reset interface
inout		X_hw_rstn;
output		T_hw_rstn;

// Power-on reset
inout		X_por_b;
output		T_por_b;

// JTAG Connector
`ifdef PLATFORM_DEBUG_PORT
inout		X_tms;
	`ifdef	PLATFORM_JTAG_TWOWIRE
	`else	// !PLATFORM_JTAG_TWOWIRE
inout		X_trst;
inout		X_tdi;
inout		X_tdo;
	`endif	// !PLATFORM_JTAG_TWOWIRE

output          pin_tms_in;
input           pin_tms_out;
input           pin_tms_out_en;
	`ifdef	PLATFORM_JTAG_TWOWIRE
	`else	// !PLATFORM_JTAG_TWOWIRE
output          pin_trst_in;
input           pin_trst_out;
input           pin_trst_out_en;
output          pin_tdi_in;
input           pin_tdi_out;
input           pin_tdi_out_en;
output          pin_tdo_in;
input           pin_tdo_out;
input           pin_tdo_out_en;
	`endif	// !PLATFORM_JTAG_TWOWIRE

	`ifdef PLATFORM_JDTM_SECURE_SUPPORT
inout	[1:0]	X_secure_mode;
output	[1:0]	T_secure_mode;	
	`endif	// PLATFORM_JDTM_SECURE_SUPPORT

`endif	// PLATFORM_DEBUG_PORT


// SPI interfaces
`ifdef AE350_SPI1_SUPPORT
	`ifdef ATCSPI200_QUADSPI_SUPPORT
inout          	X_spi1_holdn;
inout		X_spi1_wpn;
output		spi1_holdn_in;
output		spi1_wpn_in;
input          	spi1_holdn_out;
input		spi1_holdn_oe;
input		spi1_wpn_out;
input		spi1_wpn_oe;
	`endif	// ATCSPI200_QUADSPI_SUPPORT
inout		X_spi1_clk;
inout		X_spi1_csn;
inout		X_spi1_miso;
inout		X_spi1_mosi;
output		spi1_clk_in;
output		spi1_csn_in;
output		spi1_miso_in;
output		spi1_mosi_in;
input		spi1_clk_out;
input		spi1_clk_oe;
input		spi1_csn_out;
input		spi1_csn_oe;
input		spi1_miso_out;
input		spi1_miso_oe;
input		spi1_mosi_out;
input		spi1_mosi_oe;
`endif	// AE350_SPI1_SUPPORT

`ifdef AE350_SPI2_SUPPORT
	`ifndef NDS_BOARD_CF1
inout		X_spi2_clk;
inout		X_spi2_csn;
inout		X_spi2_miso;
inout		X_spi2_mosi;
	`endif	// !NDS_BOARD_CF1
output		spi2_clk_in;
output		spi2_csn_in;
output		spi2_miso_in;
output		spi2_mosi_in;
input		spi2_clk_out;
input		spi2_clk_oe;
input		spi2_csn_out;
input		spi2_csn_oe;
input		spi2_miso_out;
input		spi2_miso_oe;
input		spi2_mosi_out;
input		spi2_mosi_oe;
	`ifdef ATCSPI200_QUADSPI_SUPPORT
inout          	X_spi2_holdn;
inout		X_spi2_wpn;
output		spi2_holdn_in;
output		spi2_wpn_in;
input          	spi2_holdn_out;
input		spi2_holdn_oe;
input		spi2_wpn_out;
input		spi2_wpn_oe;
	`endif	// ATCSPI200_QUADSPI_SUPPORT
`else	// !AE350_SPI2_SUPPORT
wire		spi2_clk_out = 1'b0;
wire		spi2_clk_oe = 1'b0;
wire		spi2_csn_out = 1'b0;
wire		spi2_csn_oe = 1'b0;
wire		spi2_miso_out = 1'b0;
wire		spi2_miso_oe = 1'b0;
wire		spi2_mosi_out = 1'b0;
wire		spi2_mosi_oe = 1'b0;
`endif	// !AE350_SPI2_SUPPORT

`ifdef AE350_SPI3_SUPPORT
inout		X_spi3_clk;
inout		X_spi3_csn;
inout		X_spi3_miso;
inout		X_spi3_mosi;
output		spi3_clk_in;
output		spi3_csn_in;
output		spi3_miso_in;
output		spi3_mosi_in;
input		spi3_clk_out;
input		spi3_clk_oe;
input		spi3_csn_out;
input		spi3_csn_oe;
input		spi3_miso_out;
input		spi3_miso_oe;
input		spi3_mosi_out;
input		spi3_mosi_oe;
	`ifdef ATCSPI200_QUADSPI_SUPPORT
inout          	X_spi3_holdn;
inout		X_spi3_wpn;
output		spi3_holdn_in;
output		spi3_wpn_in;
input          	spi3_holdn_out;
input		spi3_holdn_oe;
input		spi3_wpn_out;
input		spi3_wpn_oe;
	`endif	// ATCSPI200_QUADSPI_SUPPORT
`endif	// AE350_SPI3_SUPPORT

`ifdef AE350_SPI4_SUPPORT
inout		X_spi4_clk;
inout		X_spi4_csn;
inout		X_spi4_miso;
inout		X_spi4_mosi;
output		spi4_clk_in;
output		spi4_csn_in;
output		spi4_miso_in;
output		spi4_mosi_in;
input		spi4_clk_out;
input		spi4_clk_oe;
input		spi4_csn_out;
input		spi4_csn_oe;
input		spi4_miso_out;
input		spi4_miso_oe;
input		spi4_mosi_out;
input		spi4_mosi_oe;
	`ifdef ATCSPI200_QUADSPI_SUPPORT
inout          	X_spi4_holdn;
inout		X_spi4_wpn;
output		spi4_holdn_in;
output		spi4_wpn_in;
input          	spi4_holdn_out;
input		spi4_holdn_oe;
input		spi4_wpn_out;
input		spi4_wpn_oe;
	`endif	// ATCSPI200_QUADSPI_SUPPORT
`endif	// AE350_SPI4_SUPPORT

// I2C interface
`ifdef AE350_I2C_SUPPORT
	`ifndef NDS_BOARD_CF1
inout		X_i2c_scl;
inout		X_i2c_sda;
	`endif	// !NDS_BOARD_CF1
output		i2c_scl_in;
output		i2c_sda_in;
input		i2c_scl;
input		i2c_sda;
`else	// !AE350_I2C_SUPPORT
wire		i2c_scl = 1'b0;
wire		i2c_sda = 1'b0;
`endif	// !AE350_I2C_SUPPORT

// I2C2 interface
`ifdef AE350_I2C2_SUPPORT
output		i2c2_scl_in;
output		i2c2_sda_in;
input		i2c2_scl;
input		i2c2_sda;
`else	// !AE350_I2C_SUPPORT
wire		i2c2_scl = 1'b0;
wire		i2c2_sda = 1'b0;
`endif	// !AE350_I2C_SUPPORT

`ifdef AE350_SSP_SUPPORT
inout   X_ssp_rxd;         // (I),   Receive data
inout   X_ssp_txd;         // (O),   Transmit Data
inout   X_ssp_sclk;        // (IO),  Serial clock
inout   X_ssp_fs;          // (IO),  Frame/Sync 
inout   X_ssp_ac97_resetn; // (O),   AC97 reset

output  T_ssp_rxd;
input   ssp_txd;
output  T_ssp_sclk_in;
output  T_ssp_fs_in;
input   ssp_ac97_resetn;
input   ssp_sclk_out;
input   ssp_fs_out;
input   ssp_txd_oe;
input   ssp_sclk_oe;
input   ssp_fs_oe;
`endif	// AE350_SSP_SUPPORT

// UART interfaces
`ifdef AE350_UART1_SUPPORT
	`ifdef NDS_BOARD_CF1
		// CF1 doesn't have UART1 I/O pads (actually muxed in PINMUX).
	`else	// !NDS_BOARD_CF1
inout		X_uart1_txd;
inout		X_uart1_rxd;
	`endif	// !NDS_BOARD_CF1

	`ifdef NDS_FPGA
	`else	// !NDS_FPGA
inout		X_uart1_dsrn;
inout		X_uart1_dcdn;
inout		X_uart1_rin;
inout		X_uart1_dtrn;
inout		X_uart1_out1n;
inout		X_uart1_out2n;
	`endif	// !NDS_FPGA
	`ifdef AE350_UART2_SUPPORT
		`ifndef NDS_FPGA
inout		X_uart1_ctsn;
inout		X_uart1_rtsn;
		`endif	// NDS_FPGA
	`else	// !AE350_UART2_SUPPORT
inout		X_uart1_ctsn;
inout		X_uart1_rtsn;
	`endif	// !AE350_UART2_SUPPORT
`endif	// AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
	`ifndef NDS_BOARD_CF1
inout		X_uart2_txd;
inout		X_uart2_rxd;
	`endif	// !NDS_BOARD_CF1
	`ifdef NDS_FPGA
	`else	// !NDS_FPGA
inout		X_uart2_ctsn;
inout		X_uart2_rtsn;
inout		X_uart2_dcdn;
inout		X_uart2_dsrn;
inout		X_uart2_rin;
inout		X_uart2_dtrn;
inout		X_uart2_out1n;
inout		X_uart2_out2n;
	`endif	// !NDS_FPGA
`endif	// AE350_UART2_SUPPORT
`ifdef AE350_UART1_SUPPORT
input		uart1_txd;
input		uart1_rtsn;
output		uart1_rxd;
output		uart1_ctsn;
output          uart1_dsrn;
output          uart1_dcdn;
output          uart1_rin;
input           uart1_dtrn;
input           uart1_out1n;
input           uart1_out2n;
`else	// !AE350_UART1_SUPPORT
wire		uart1_txd = 1'b0;
`endif	// !AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
input		uart2_txd;
input		uart2_rtsn;
output		uart2_rxd;
output		uart2_ctsn;
output          uart2_dcdn;
output          uart2_dsrn;
output          uart2_rin;
input           uart2_dtrn;
input           uart2_out1n;
input           uart2_out2n;
`else	// !AE350_UART2_SUPPORT
wire		uart2_txd = 1'b0;
`endif	// !AE350_UART2_SUPPORT

`ifdef AE350_PIT_SUPPORT
// PIT interface
	`ifndef NDS_BOARD_CF1
inout		   X_pwm_ch0;
	`endif	// !NDS_BOARD_CF1
input              ch0_pwm;
input              ch0_pwmoe;
	`ifdef ATCPIT100_CH1_SUPPORT
		`ifndef NDS_BOARD_CF1
inout		   X_pwm_ch1;
		`endif	// !NDS_BOARD_CF1
input              ch1_pwm;
input              ch1_pwmoe;
	`endif	// ATCPIT100_CH1_SUPPORT
	`ifdef ATCPIT100_CH2_SUPPORT
		`ifndef NDS_BOARD_CF1
inout		   X_pwm_ch2;
		`endif	// !NDS_BOARD_CF1
input              ch2_pwm;
input              ch2_pwmoe;
	`endif	// ATCPIT100_CH2_SUPPORT
	`ifdef ATCPIT100_CH3_SUPPORT
		`ifndef NDS_BOARD_CF1
inout		   X_pwm_ch3;
		`endif	// !NDS_BOARD_CF1
input              ch3_pwm;
input              ch3_pwmoe;
	`endif	// ATCPIT100_CH3_SUPPORT
`endif	// AE350_PIT_SUPPORT

`ifdef AE350_PIT2_SUPPORT
input		pit2_ch0_pwm;
input		pit2_ch0_pwmoe;
	`ifdef ATCPIT100_CH1_SUPPORT
input		pit2_ch1_pwm;
input		pit2_ch1_pwmoe;
	`endif	// ATCPIT100_CH1_SUPPORT
	`ifdef ATCPIT100_CH2_SUPPORT
input		pit2_ch2_pwm;
input		pit2_ch2_pwmoe;
	`endif	// ATCPIT100_CH2_SUPPORT
	`ifdef ATCPIT100_CH3_SUPPORT
input		pit2_ch3_pwm;
input		pit2_ch3_pwmoe;
	`endif	// ATCPIT100_CH3_SUPPORT
`else	// !AE350_PIT2_SUPPORT
wire		pit2_ch0_pwm = 1'b0;
wire		pit2_ch0_pwmoe = 1'b0;
wire		pit2_ch1_pwm = 1'b0;
wire		pit2_ch1_pwmoe = 1'b0;
wire		pit2_ch2_pwm = 1'b0;
wire		pit2_ch2_pwmoe = 1'b0;
wire		pit2_ch3_pwm = 1'b0;
wire		pit2_ch3_pwmoe = 1'b0;
`endif	// !AE350_PIT2_SUPPORT

`ifdef AE350_PIT3_SUPPORT
input		pit3_ch0_pwm;
input		pit3_ch0_pwmoe;
	`ifdef ATCPIT100_CH1_SUPPORT
input		pit3_ch1_pwm;
input		pit3_ch1_pwmoe;
	`endif	// ATCPIT100_CH1_SUPPORT
	`ifdef ATCPIT100_CH2_SUPPORT
input		pit3_ch2_pwm;
input		pit3_ch2_pwmoe;
	`endif	// ATCPIT100_CH2_SUPPORT
	`ifdef ATCPIT100_CH3_SUPPORT
input		pit3_ch3_pwm;
input		pit3_ch3_pwmoe;
	`endif	// ATCPIT100_CH3_SUPPORT
`else	// !AE350_PIT3_SUPPORT
wire		pit3_ch0_pwm = 1'b0;
wire		pit3_ch0_pwmoe = 1'b0;
wire		pit3_ch1_pwm = 1'b0;
wire		pit3_ch1_pwmoe = 1'b0;
wire		pit3_ch2_pwm = 1'b0;
wire		pit3_ch2_pwmoe = 1'b0;
wire		pit3_ch3_pwm = 1'b0;
wire		pit3_ch3_pwmoe = 1'b0;
`endif	// !AE350_PIT3_SUPPORT

`ifdef AE350_PIT4_SUPPORT
input		pit4_ch0_pwm;
input		pit4_ch0_pwmoe;
	`ifdef ATCPIT100_CH1_SUPPORT
input		pit4_ch1_pwm;
input		pit4_ch1_pwmoe;
	`endif	// ATCPIT100_CH1_SUPPORT
	`ifdef ATCPIT100_CH2_SUPPORT
input		pit4_ch2_pwm;
input		pit4_ch2_pwmoe;
	`endif	// ATCPIT100_CH2_SUPPORT
	`ifdef ATCPIT100_CH3_SUPPORT
input		pit4_ch3_pwm;
input		pit4_ch3_pwmoe;
	`endif // ATCPIT100_CH3_SUPPORT
`else	// !AE350_PIT4_SUPPORT
wire		pit4_ch0_pwm = 1'b0;
wire		pit4_ch0_pwmoe = 1'b0;
wire		pit4_ch1_pwm = 1'b0;
wire		pit4_ch1_pwmoe = 1'b0;
wire		pit4_ch2_pwm = 1'b0;
wire		pit4_ch2_pwmoe = 1'b0;
wire		pit4_ch3_pwm = 1'b0;
wire		pit4_ch3_pwmoe = 1'b0;
`endif	// !AE350_PIT4_SUPPORT

`ifdef AE350_PIT5_SUPPORT
input		pit5_ch0_pwm;
input		pit5_ch0_pwmoe;
	`ifdef ATCPIT100_CH1_SUPPORT
input		pit5_ch1_pwm;
input		pit5_ch1_pwmoe;
	`endif	// ATCPIT100_CH1_SUPPORT
	`ifdef ATCPIT100_CH2_SUPPORT
input		pit5_ch2_pwm;
input		pit5_ch2_pwmoe;
	`endif	// ATCPIT100_CH2_SUPPORT
	`ifdef ATCPIT100_CH3_SUPPORT
input		pit5_ch3_pwm;
input		pit5_ch3_pwmoe;
	`endif	// ATCPIT100_CH3_SUPPORT
`else	// !AE350_PIT5_SUPPORT
wire		pit5_ch0_pwm = 1'b0;
wire		pit5_ch0_pwmoe = 1'b0;
wire		pit5_ch1_pwm = 1'b0;
wire		pit5_ch1_pwmoe = 1'b0;
wire		pit5_ch2_pwm = 1'b0;
wire		pit5_ch2_pwmoe = 1'b0;
wire		pit5_ch3_pwm = 1'b0;
wire		pit5_ch3_pwmoe = 1'b0;
`endif	// !AE350_PIT5_SUPPORT

`ifdef NDS_FPGA
	`ifdef NDS_BOARD_ORCA
// inout              X_flash_cs;
inout              X_flash_dir;
	`endif // !NDS_BOARD_ORCA
`endif	// NDS_FPGA


`ifdef AE350_SDC_SUPPORT
inout       X_sd_cd     ; // (I),   Card detect
inout       X_sd_wp     ; // (I),   Card write protect
inout       X_sd_clk    ; // (O),   Clock
inout       X_sd_cmd_rsp; // (IO),  Commands and responses
inout       X_sd_dat0; // (IO),  Data line bit[0]
inout       X_sd_dat1; // (IO),  Data line bit[1]
inout       X_sd_dat2; // (IO),  Data line bit[2]
inout       X_sd_dat3; // (IO),  Data line bit[3]
inout	    X_sd_power_on;

output      T_sd_cd;
output      T_sd_wp;
input       sd_clk;
output      T_sd_rsp;
input       sd_cmd;
input       sd_cmd_oe;
output      T_sd_dat3_in;
output      T_sd_dat2_in;
output      T_sd_dat1_in;
output      T_sd_dat0_in;
input       sd_dat3_out;
input       sd_dat2_out;
input       sd_dat1_out;
input       sd_dat0_out;
input       sd_dat3_oe;
input       sd_dat2_oe;
input       sd_dat1_oe;
input       sd_dat0_oe;
input [4:0] sd_power;
`endif	// AE350_SDC_SUPPORT
`ifdef AE350_SMC_SUPPORT
	`ifdef NDS_FPGA
inout   [15:0]  X_memdata; // (IO),  Memory data bus
	`else
inout   [31:0]  X_memdata; // (IO),  Memory data bus
	`endif
inout   [24:0]  X_memaddr; // (IO),  Memory address bus
inout           X_smc_we_b;
inout           X_smc_cs_b; // (O),   Chip select
inout           X_smc_oe_b; // (O),   Output enable

input        smc_we_n;
input        smc_cs_n_0;
input        smc_oe_n;

output  [31:0]  T_memdata;
input   [31:0]  smc_dqout;
input   [31:0]  smc_data_oe;
input   [24:0]  smc_addr;
`endif	// AE350_SMC_SUPPORT
// MAC 
`ifdef AE350_MAC_SUPPORT
inout         X_tx_clk;		// (I),   MII transmit clock
inout         X_tx_en;		// (O),   MII transmit enable
inout  [3:0]  X_txd;		// (O),   MII transmit data
inout         X_rx_clk;		// (I),   MII receive clock
inout         X_rx_dv;		// (I),   MII receive data valid
inout         X_rx_er;		// (I),   MII receive error
inout  [3:0]  X_rxd;		// (I),   MII receive data
inout         X_crs;		// (I),   MII carrier sense
inout         X_col;		// (I),   MII collision detected
inout         X_mdc;		// (O),   MII management data clock
inout         X_mdio;		// (IO),  MII management data input/output
inout         X_phy_linksts;	// (I),   PHY link status
inout         X_pdn_phy;	// (O),   This pin is used to power down PHY

output        T_tx_clk;
input         tx_en;
input   [3:0] txd;
output        T_rx_clk;
output        T_rx_dv;
output        T_rx_er;
output  [3:0] T_rxd;
output        T_crs;
output        T_col;
input         mdc;
output        T_mdio;
input         mdio_out;
input         mdio_out_en;
output        T_phy_linksts;
input         pdn_phy;
`endif	// AE350_MAC_SUPPORT

`ifdef AE350_LCDC_SUPPORT
inout          X_clpower; // (O),   LCD panel power enable
inout          X_cllp; // (O),   Line syn. pulse(STN)/horizontal syn. pulse(TFT)
inout          X_clcp; // (O),   LCD panel clock
inout          X_clfp; // (O),   Frame pulse(STN)/vertical syn. pulse(TFT)
inout          X_clac; // (O),   STN AC bias driver or TFT data enable output
inout  [23:0]  X_cld; // (O),   LCD panel data
inout          X_clle; // (O),   Line end signal

input          clpower;
input          cllp;
input          clcp;
input          clfp;
input          clac;
input  [23:0]  cld;
input          clle;
`endif	// LCDC_SUPPORT

`ifdef NDS_BOARD_CF1
input   [31:0]	cf1_pinmux_ctrl0;
input   [31:0]	cf1_pinmux_ctrl1;
`endif	// NDS_BOARD_CF1

`ifdef AE350_GPIO_SUPPORT
	`ifdef NDS_BOARD_CF1
inout	[31:1]	X_gpio;
	`else	// !NDS_BOARD_CF1
inout	[31:0]	X_gpio;
	`endif	// !NDS_BOARD_CF1
output	[31:0]	gpio_in;
input	[31:0]	gpio_oe;
input	[31:0]	gpio_out;
	`ifdef ATCGPIO100_PULL_SUPPORT
input	[31:0]	gpio_pulldown;
input	[31:0]	gpio_pullup;
	`endif	// ATCGPIO100_PULL_SUPPORT
`endif	// AE350_GPIO_SUPPORT

// OSCH interface
`ifdef NDS_FPGA
wire		X_oschio;
`else	// !NDS_FPGA
inout		X_oschio;
`endif	// !NDS_FPGA
input		X_oschin;
output		T_osch;

`ifdef AE350_GPIO_SUPPORT
// GPIO intefaces
// VPERL_BEGIN
// for my $i (0 .. 31) {
//   if ($i >= 12) {
//     $j = sprintf("%02d", $i);
//     :wire		gpio_in_${j};
//     :wire		gpio_out_${j};
//     :wire		gpio_oe_${j};
//     :wire		gpio_pullup_${j};
//     :wire		gpio_pulldown_${j};
//   }
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
wire		gpio_in_12;
wire		gpio_out_12;
wire		gpio_oe_12;
wire		gpio_pullup_12;
wire		gpio_pulldown_12;
wire		gpio_in_13;
wire		gpio_out_13;
wire		gpio_oe_13;
wire		gpio_pullup_13;
wire		gpio_pulldown_13;
wire		gpio_in_14;
wire		gpio_out_14;
wire		gpio_oe_14;
wire		gpio_pullup_14;
wire		gpio_pulldown_14;
wire		gpio_in_15;
wire		gpio_out_15;
wire		gpio_oe_15;
wire		gpio_pullup_15;
wire		gpio_pulldown_15;
wire		gpio_in_16;
wire		gpio_out_16;
wire		gpio_oe_16;
wire		gpio_pullup_16;
wire		gpio_pulldown_16;
wire		gpio_in_17;
wire		gpio_out_17;
wire		gpio_oe_17;
wire		gpio_pullup_17;
wire		gpio_pulldown_17;
wire		gpio_in_18;
wire		gpio_out_18;
wire		gpio_oe_18;
wire		gpio_pullup_18;
wire		gpio_pulldown_18;
wire		gpio_in_19;
wire		gpio_out_19;
wire		gpio_oe_19;
wire		gpio_pullup_19;
wire		gpio_pulldown_19;
wire		gpio_in_20;
wire		gpio_out_20;
wire		gpio_oe_20;
wire		gpio_pullup_20;
wire		gpio_pulldown_20;
wire		gpio_in_21;
wire		gpio_out_21;
wire		gpio_oe_21;
wire		gpio_pullup_21;
wire		gpio_pulldown_21;
wire		gpio_in_22;
wire		gpio_out_22;
wire		gpio_oe_22;
wire		gpio_pullup_22;
wire		gpio_pulldown_22;
wire		gpio_in_23;
wire		gpio_out_23;
wire		gpio_oe_23;
wire		gpio_pullup_23;
wire		gpio_pulldown_23;
wire		gpio_in_24;
wire		gpio_out_24;
wire		gpio_oe_24;
wire		gpio_pullup_24;
wire		gpio_pulldown_24;
wire		gpio_in_25;
wire		gpio_out_25;
wire		gpio_oe_25;
wire		gpio_pullup_25;
wire		gpio_pulldown_25;
wire		gpio_in_26;
wire		gpio_out_26;
wire		gpio_oe_26;
wire		gpio_pullup_26;
wire		gpio_pulldown_26;
wire		gpio_in_27;
wire		gpio_out_27;
wire		gpio_oe_27;
wire		gpio_pullup_27;
wire		gpio_pulldown_27;
wire		gpio_in_28;
wire		gpio_out_28;
wire		gpio_oe_28;
wire		gpio_pullup_28;
wire		gpio_pulldown_28;
wire		gpio_in_29;
wire		gpio_out_29;
wire		gpio_oe_29;
wire		gpio_pullup_29;
wire		gpio_pulldown_29;
wire		gpio_in_30;
wire		gpio_out_30;
wire		gpio_oe_30;
wire		gpio_pullup_30;
wire		gpio_pulldown_30;
wire		gpio_in_31;
wire		gpio_out_31;
wire		gpio_oe_31;
wire		gpio_pullup_31;
wire		gpio_pulldown_31;
// VPERL_GENERATED_END
`endif	// AE350_GPIO_SUPPORT

// OSCH interface
nds_osc_pad   osch_pad		(.O(T_osch), .I(X_oschin), .IO(X_oschio));

// Reset interface
wire 	hw_rstn;
nds_inout_pad hw_rstn_pad      (.O(hw_rstn), .I(1'b0), .IO(X_hw_rstn), .E(1'b0), .PU(1'b0), .PD(1'b0));

`ifdef NDS_BOARD_VCU118
    assign T_hw_rstn = ~hw_rstn;
`else
    assign T_hw_rstn =  hw_rstn;
`endif


// Power-on reset
nds_inout_pad porb_pad		(.O(T_por_b), .I(1'b0), .IO(X_por_b), .E(1'b0), .PU(1'b0), .PD(1'b0));

// JTAG Connector
`ifdef PLATFORM_DEBUG_PORT
nds_inout_pad jtag_tms_pad	(.O(pin_tms_in),  .I(pin_tms_out),  .IO(X_tms),  .E(pin_tms_out_en),  .PU(1'b1), .PD(1'b0));
	`ifndef PLATFORM_JTAG_TWOWIRE
nds_inout_pad jtag_trst_pad	(.O(pin_trst_in), .I(pin_trst_out), .IO(X_trst), .E(pin_trst_out_en), .PU(1'b0), .PD(1'b0));
nds_inout_pad jtag_tdi_pad	(.O(pin_tdi_in),  .I(pin_tdi_out),  .IO(X_tdi),  .E(pin_tdi_out_en),  .PU(1'b0), .PD(1'b0));
nds_inout_pad jtag_tdo_pad	(.O(pin_tdo_in),  .I(pin_tdo_out),  .IO(X_tdo),  .E(pin_tdo_out_en),  .PU(1'b0), .PD(1'b0));
	`endif	// !PLATFORM_JTAG_TWOWIRE

	`ifdef PLATFORM_JDTM_SECURE_SUPPORT
nds_inout_pad secure_mode_pad_0	(.O(T_secure_mode[0]),  .I(1'b0),  .IO(X_secure_mode[0]),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad secure_mode_pad_1	(.O(T_secure_mode[1]),  .I(1'b0),  .IO(X_secure_mode[1]),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
	`endif	// PLATFORM_JDTM_SECURE_SUPPORT


`endif	// PLATFORM_DEBUG_PORT

// SPI interfaces
`ifdef AE350_SPI1_SUPPORT
nds_inout_pad spi1_clk_pad	(.O(spi1_clk_in),   .I(spi1_clk_out),   .IO(X_spi1_clk),   .E(spi1_clk_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_csn_pad	(.O(spi1_csn_in),   .I(spi1_csn_out),   .IO(X_spi1_csn),   .E(spi1_csn_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_miso_pad	(.O(spi1_miso_in),  .I(spi1_miso_out),  .IO(X_spi1_miso),  .E(spi1_miso_oe),  .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_mosi_pad	(.O(spi1_mosi_in),  .I(spi1_mosi_out),  .IO(X_spi1_mosi),  .E(spi1_mosi_oe),  .PU(1'b0), .PD(1'b0));
	`ifdef ATCSPI200_QUADSPI_SUPPORT
nds_inout_pad spi1_holdn_pad	(.O(spi1_holdn_in), .I(spi1_holdn_out), .IO(X_spi1_holdn), .E(spi1_holdn_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_wpn_pad	(.O(spi1_wpn_in),   .I(spi1_wpn_out),   .IO(X_spi1_wpn),   .E(spi1_wpn_oe),   .PU(1'b0), .PD(1'b0));
	`endif	// ATCSPI200_QUADSPI_SUPPORT
`endif	// AE350_SPI1_SUPPORT

`ifdef AE350_SPI2_SUPPORT
	`ifndef NDS_BOARD_CF1
nds_inout_pad spi2_clk_pad	(.O(spi2_clk_in),   .I(spi2_clk_out),   .IO(X_spi2_clk),   .E(spi2_clk_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_csn_pad	(.O(spi2_csn_in),   .I(spi2_csn_out),   .IO(X_spi2_csn),   .E(spi2_csn_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_miso_pad	(.O(spi2_miso_in),  .I(spi2_miso_out),  .IO(X_spi2_miso),  .E(spi2_miso_oe),  .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_mosi_pad	(.O(spi2_mosi_in),  .I(spi2_mosi_out),  .IO(X_spi2_mosi),  .E(spi2_mosi_oe),  .PU(1'b0), .PD(1'b0));
	`endif	// !NDS_BOARD_CF1
	`ifdef ATCSPI200_QUADSPI_SUPPORT
nds_inout_pad spi2_holdn_pad	(.O(spi2_holdn_in), .I(spi2_holdn_out), .IO(X_spi2_holdn), .E(spi2_holdn_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_wpn_pad	(.O(spi2_wpn_in),   .I(spi2_wpn_out),   .IO(X_spi2_wpn),   .E(spi2_wpn_oe),   .PU(1'b0), .PD(1'b0));
	`endif	// ATCSPI200_QUADSPI_SUPPORT
`endif	// AE350_SPI2_SUPPORT

`ifdef AE350_SPI3_SUPPORT
nds_inout_pad spi3_clk_pad	(.O(spi3_clk_in),   .I(spi3_clk_out),   .IO(X_spi3_clk),   .E(spi3_clk_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi3_csn_pad	(.O(spi3_csn_in),   .I(spi3_csn_out),   .IO(X_spi3_csn),   .E(spi3_csn_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi3_miso_pad	(.O(spi3_miso_in),  .I(spi3_miso_out),  .IO(X_spi3_miso),  .E(spi3_miso_oe),  .PU(1'b0), .PD(1'b0));
nds_inout_pad spi3_mosi_pad	(.O(spi3_mosi_in),  .I(spi3_mosi_out),  .IO(X_spi3_mosi),  .E(spi3_mosi_oe),  .PU(1'b0), .PD(1'b0));
	`ifdef ATCSPI200_QUADSPI_SUPPORT
nds_inout_pad spi3_holdn_pad	(.O(spi3_holdn_in), .I(spi3_holdn_out), .IO(X_spi3_holdn), .E(spi3_holdn_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad spi3_wpn_pad	(.O(spi3_wpn_in),   .I(spi3_wpn_out),   .IO(X_spi3_wpn),   .E(spi3_wpn_oe),   .PU(1'b0), .PD(1'b0));
	`endif	// ATCSPI200_QUADSPI_SUPPORT
`endif	// AE350_SPI3_SUPPORT

`ifdef AE350_SPI4_SUPPORT
nds_inout_pad spi4_clk_pad	(.O(spi4_clk_in),   .I(spi4_clk_out),   .IO(X_spi4_clk),   .E(spi4_clk_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi4_csn_pad	(.O(spi4_csn_in),   .I(spi4_csn_out),   .IO(X_spi4_csn),   .E(spi4_csn_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi4_miso_pad	(.O(spi4_miso_in),  .I(spi4_miso_out),  .IO(X_spi4_miso),  .E(spi4_miso_oe),  .PU(1'b0), .PD(1'b0));
nds_inout_pad spi4_mosi_pad	(.O(spi4_mosi_in),  .I(spi4_mosi_out),  .IO(X_spi4_mosi),  .E(spi4_mosi_oe),  .PU(1'b0), .PD(1'b0));
	`ifdef ATCSPI200_QUADSPI_SUPPORT
nds_inout_pad spi4_holdn_pad	(.O(spi4_holdn_in), .I(spi4_holdn_out), .IO(X_spi4_holdn), .E(spi4_holdn_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad spi4_wpn_pad	(.O(spi4_wpn_in),   .I(spi4_wpn_out),   .IO(X_spi4_wpn),   .E(spi4_wpn_oe),   .PU(1'b0), .PD(1'b0));
	`endif	// ATCSPI200_QUADSPI_SUPPORT
`endif	// AE350_SPI4_SUPPORT

// I2C interfaces
`ifdef AE350_I2C_SUPPORT
	`ifndef NDS_BOARD_CF1
nds_inout_pad i2c_scl_pad	(.O(i2c_scl_in),  .I(1'b0),  .IO(X_i2c_scl),  .E(~i2c_scl),  .PU(1'b0), .PD(1'b0));
nds_inout_pad i2c_sda_pad	(.O(i2c_sda_in),  .I(1'b0),  .IO(X_i2c_sda),  .E(~i2c_sda),  .PU(1'b0), .PD(1'b0));
	`endif	// !NDS_BOARD_CF1
`endif	// AE350_I2C_SUPPORT


// UART interfaces
`ifdef AE350_UART1_SUPPORT
	`ifndef NDS_BOARD_CF1
nds_inout_pad uart1_txd_pad	(.O(),  	  .I(uart1_txd),  .IO(X_uart1_txd),   .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_rxd_pad	(.O(uart1_rxd),   .I(1'b0),       .IO(X_uart1_rxd),   .E(1'b0),  .PU(1'b0), .PD(1'b0));
	`endif	// !NDS_BOARD_CF1

	`ifdef NDS_FPGA
assign uart1_dcdn = 1'b0;
assign uart1_dsrn = 1'b0;
assign uart1_rin = 1'b0;
	`else	// !NDS_FPGA
nds_inout_pad uart1_out1n_pad	(.O(),  	  .I(uart1_out1n),.IO(X_uart1_out1n), .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_out2n_pad	(.O(),  	  .I(uart1_out2n),.IO(X_uart1_out2n), .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_dtrn_pad	(.O(),  	  .I(uart1_dtrn), .IO(X_uart1_dtrn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_dcdn_pad	(.O(uart1_dcdn),  .I(1'b0),       .IO(X_uart1_dcdn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_dsrn_pad	(.O(uart1_dsrn),  .I(1'b0),       .IO(X_uart1_dsrn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_rin_pad	(.O(uart1_rin),   .I(1'b0),       .IO(X_uart1_rin),   .E(1'b0),  .PU(1'b0), .PD(1'b0));
	`endif	// !NDS_FPGA

	`ifdef AE350_UART2_SUPPORT
		`ifdef NDS_FPGA
	// On ORCA, some efforts haven been spent to connect UART1 and UART2
	// together to do self-test on FPGA. There, an external level-shifter
	// IC (3.3->5V, MAX3243CAI) is used . However, it doesn't provide
	// enough channels so that we can't connect all signals directly on
	// the board.  As a result, some flow control pins are internally
	// connected in advance. Codes are not complete yet. We should need
	// a control pin to do the corresponding muxing.
	assign	uart1_ctsn = uart2_rtsn;
	assign	uart2_ctsn = uart1_rtsn;
		`else	// !NDS_FPGA
	nds_inout_pad uart1_ctsn_pad	(.O(uart1_ctsn),  .I(1'b0),       .IO(X_uart1_ctsn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
	nds_inout_pad uart1_rtsn_pad	(.O(),  	 .I(uart1_rtsn),  .IO(X_uart1_rtsn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
	nds_inout_pad uart2_ctsn_pad	(.O(uart2_ctsn),  .I(1'b0),       .IO(X_uart2_ctsn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
	nds_inout_pad uart2_rtsn_pad	(.O(),  	 .I(uart2_rtsn),  .IO(X_uart2_rtsn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
		`endif	// !NDS_FPGA
	`else	// !AE350_UART2_SUPPORT
	nds_inout_pad uart1_ctsn_pad	(.O(uart1_ctsn),  .I(1'b0),       .IO(X_uart1_ctsn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
	nds_inout_pad uart1_rtsn_pad	(.O(),  	 .I(uart1_rtsn),  .IO(X_uart1_rtsn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
	`endif	// !AE350_UART2_SUPPORT
`endif	// AE350_UART1_SUPPORT

`ifdef AE350_UART2_SUPPORT
	`ifndef NDS_BOARD_CF1
nds_inout_pad uart2_txd_pad	(.O(),  	 .I(uart2_txd),  .IO(X_uart2_txd),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_rxd_pad	(.O(uart2_rxd),  .I(1'b0),       .IO(X_uart2_rxd),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
	`endif	// !NDS_BOARD_CF1

	`ifdef NDS_BOARD_VCU118
assign	uart2_ctsn = 1'b1;
	`endif // !NDS_BOARD_VCU118

	`ifdef NDS_FPGA
assign	uart2_dcdn = 1'b1;
assign	uart2_dsrn = 1'b1;
assign	uart2_rin  = 1'b1;
	`else	// !NDS_FPGA
nds_inout_pad uart2_dtrn_pad	(.O(),  	 .I(uart2_dtrn),  .IO(X_uart2_dtrn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_out1n_pad	(.O(),  	 .I(uart2_out1n), .IO(X_uart2_out1n),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_out2n_pad	(.O(),  	 .I(uart2_out2n), .IO(X_uart2_out2n),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_dcdn_pad	(.O(uart2_dcdn),  .I(1'b0),       .IO(X_uart2_dcdn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_dsrn_pad	(.O(uart2_dsrn),  .I(1'b0),       .IO(X_uart2_dsrn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_rin_pad	(.O(uart2_rin),   .I(1'b0),       .IO(X_uart2_rin),   .E(1'b0),  .PU(1'b0), .PD(1'b0));
	`endif	// !NDS_FPGA
`endif	// AE350_UART2_SUPPORT

`ifdef AE350_PIT_SUPPORT
	`ifndef NDS_BOARD_CF1
// PIT interface
nds_inout_pad pwm_ch0_pad	(.O(),  	 .I(ch0_pwm),  .IO(X_pwm_ch0),  .E(ch0_pwmoe),  .PU(1'b0), .PD(1'b0));
		`ifdef ATCPIT100_CH1_SUPPORT
nds_inout_pad pwm_ch1_pad	(.O(),  	 .I(ch1_pwm),  .IO(X_pwm_ch1),  .E(ch1_pwmoe),  .PU(1'b0), .PD(1'b0));
		`endif // ATCPIT100_CH1_SUPPORT
		`ifdef ATCPIT100_CH2_SUPPORT
nds_inout_pad pwm_ch2_pad	(.O(),  	 .I(ch2_pwm),  .IO(X_pwm_ch2),  .E(ch2_pwmoe),  .PU(1'b0), .PD(1'b0));
		`endif // ATCPIT100_CH2_SUPPORT
		`ifdef ATCPIT100_CH3_SUPPORT
nds_inout_pad pwm_ch3_pad	(.O(),  	 .I(ch3_pwm),  .IO(X_pwm_ch3),  .E(ch3_pwmoe),  .PU(1'b0), .PD(1'b0));
		`endif // ATCPIT100_CH3_SUPPORT
	`endif	// !NDS_BOARD_CF1
`endif	// AE350_PIT_SUPPORT

`ifdef NDS_FPGA
	`ifndef NDS_BOARD_CF1
// nds_inout_pad pad_flash_cs	(.O(), .I(1'b0),  .IO(X_flash_cs),   .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_flash_dir	(.O(), .I(1'b1),  .IO(X_flash_dir),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
	`endif	// !NDS_BOARD_CF1
`endif	// NDS_FPGA
//--------------------------------------------------------------------------------------
// SMC
//--------------------------------------------------------------------------------------
`ifdef AE350_SMC_SUPPORT
	`ifdef NDS_FPGA
// ORCA and BigORCA only have 16-bit NOR flash chips.
assign T_memdata[31] = smc_dqout[31] & smc_data_oe[31];
assign T_memdata[30] = smc_dqout[30] & smc_data_oe[30];
assign T_memdata[29] = smc_dqout[29] & smc_data_oe[29];
assign T_memdata[28] = smc_dqout[28] & smc_data_oe[28];
assign T_memdata[27] = smc_dqout[27] & smc_data_oe[27];
assign T_memdata[26] = smc_dqout[26] & smc_data_oe[26];
assign T_memdata[25] = smc_dqout[25] & smc_data_oe[25];
assign T_memdata[24] = smc_dqout[24] & smc_data_oe[24];
assign T_memdata[23] = smc_dqout[23] & smc_data_oe[23];
assign T_memdata[22] = smc_dqout[22] & smc_data_oe[22];
assign T_memdata[21] = smc_dqout[21] & smc_data_oe[21];
assign T_memdata[20] = smc_dqout[20] & smc_data_oe[20];
assign T_memdata[19] = smc_dqout[19] & smc_data_oe[19];
assign T_memdata[18] = smc_dqout[18] & smc_data_oe[18];
assign T_memdata[17] = smc_dqout[17] & smc_data_oe[17];
assign T_memdata[16] = smc_dqout[16] & smc_data_oe[16];
	`else	// !NDS_FPGA
nds_inout_pad  pad_memdata31 (.O(T_memdata[31]), .I(smc_dqout[31]), .IO(X_memdata[31]), .E(smc_data_oe[31]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata30 (.O(T_memdata[30]), .I(smc_dqout[30]), .IO(X_memdata[30]), .E(smc_data_oe[30]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata29 (.O(T_memdata[29]), .I(smc_dqout[29]), .IO(X_memdata[29]), .E(smc_data_oe[29]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata28 (.O(T_memdata[28]), .I(smc_dqout[28]), .IO(X_memdata[28]), .E(smc_data_oe[28]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata27 (.O(T_memdata[27]), .I(smc_dqout[27]), .IO(X_memdata[27]), .E(smc_data_oe[27]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata26 (.O(T_memdata[26]), .I(smc_dqout[26]), .IO(X_memdata[26]), .E(smc_data_oe[26]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata25 (.O(T_memdata[25]), .I(smc_dqout[25]), .IO(X_memdata[25]), .E(smc_data_oe[25]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata24 (.O(T_memdata[24]), .I(smc_dqout[24]), .IO(X_memdata[24]), .E(smc_data_oe[24]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata23 (.O(T_memdata[23]), .I(smc_dqout[23]), .IO(X_memdata[23]), .E(smc_data_oe[23]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata22 (.O(T_memdata[22]), .I(smc_dqout[22]), .IO(X_memdata[22]), .E(smc_data_oe[22]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata21 (.O(T_memdata[21]), .I(smc_dqout[21]), .IO(X_memdata[21]), .E(smc_data_oe[21]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata20 (.O(T_memdata[20]), .I(smc_dqout[20]), .IO(X_memdata[20]), .E(smc_data_oe[20]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata19 (.O(T_memdata[19]), .I(smc_dqout[19]), .IO(X_memdata[19]), .E(smc_data_oe[19]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata18 (.O(T_memdata[18]), .I(smc_dqout[18]), .IO(X_memdata[18]), .E(smc_data_oe[18]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata17 (.O(T_memdata[17]), .I(smc_dqout[17]), .IO(X_memdata[17]), .E(smc_data_oe[17]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata16 (.O(T_memdata[16]), .I(smc_dqout[16]), .IO(X_memdata[16]), .E(smc_data_oe[16]), .PU(1'b0), .PD(1'b0));
	`endif	// !NDS_FPGA
nds_inout_pad  pad_memdata15 (.O(T_memdata[15]), .I(smc_dqout[15]), .IO(X_memdata[15]), .E(smc_data_oe[15]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata14 (.O(T_memdata[14]), .I(smc_dqout[14]), .IO(X_memdata[14]), .E(smc_data_oe[14]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata13 (.O(T_memdata[13]), .I(smc_dqout[13]), .IO(X_memdata[13]), .E(smc_data_oe[13]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata12 (.O(T_memdata[12]), .I(smc_dqout[12]), .IO(X_memdata[12]), .E(smc_data_oe[12]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata11 (.O(T_memdata[11]), .I(smc_dqout[11]), .IO(X_memdata[11]), .E(smc_data_oe[11]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata10 (.O(T_memdata[10]), .I(smc_dqout[10]), .IO(X_memdata[10]), .E(smc_data_oe[10]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata09 (.O(T_memdata[ 9]), .I(smc_dqout[ 9]), .IO(X_memdata[ 9]), .E(smc_data_oe[ 9]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata08 (.O(T_memdata[ 8]), .I(smc_dqout[ 8]), .IO(X_memdata[ 8]), .E(smc_data_oe[ 8]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata07 (.O(T_memdata[ 7]), .I(smc_dqout[ 7]), .IO(X_memdata[ 7]), .E(smc_data_oe[ 7]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata06 (.O(T_memdata[ 6]), .I(smc_dqout[ 6]), .IO(X_memdata[ 6]), .E(smc_data_oe[ 6]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata05 (.O(T_memdata[ 5]), .I(smc_dqout[ 5]), .IO(X_memdata[ 5]), .E(smc_data_oe[ 5]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata04 (.O(T_memdata[ 4]), .I(smc_dqout[ 4]), .IO(X_memdata[ 4]), .E(smc_data_oe[ 4]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata03 (.O(T_memdata[ 3]), .I(smc_dqout[ 3]), .IO(X_memdata[ 3]), .E(smc_data_oe[ 3]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata02 (.O(T_memdata[ 2]), .I(smc_dqout[ 2]), .IO(X_memdata[ 2]), .E(smc_data_oe[ 2]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata01 (.O(T_memdata[ 1]), .I(smc_dqout[ 1]), .IO(X_memdata[ 1]), .E(smc_data_oe[ 1]), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memdata00 (.O(T_memdata[ 0]), .I(smc_dqout[ 0]), .IO(X_memdata[ 0]), .E(smc_data_oe[ 0]), .PU(1'b0), .PD(1'b0));

nds_inout_pad  pad_memaddr24 (.O(), .I(smc_addr[24]),  .IO(X_memaddr[24]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr23 (.O(), .I(smc_addr[23]),  .IO(X_memaddr[23]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr22 (.O(), .I(smc_addr[22]),  .IO(X_memaddr[22]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr21 (.O(), .I(smc_addr[21]),  .IO(X_memaddr[21]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr20 (.O(), .I(smc_addr[20]),  .IO(X_memaddr[20]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr19 (.O(), .I(smc_addr[19]),  .IO(X_memaddr[19]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr18 (.O(), .I(smc_addr[18]),  .IO(X_memaddr[18]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr17 (.O(), .I(smc_addr[17]),  .IO(X_memaddr[17]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr16 (.O(), .I(smc_addr[16]),  .IO(X_memaddr[16]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr15 (.O(), .I(smc_addr[15]),  .IO(X_memaddr[15]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr14 (.O(), .I(smc_addr[14]),  .IO(X_memaddr[14]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr13 (.O(), .I(smc_addr[13]),  .IO(X_memaddr[13]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr12 (.O(), .I(smc_addr[12]),  .IO(X_memaddr[12]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr11 (.O(), .I(smc_addr[11]),  .IO(X_memaddr[11]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr10 (.O(), .I(smc_addr[10]),  .IO(X_memaddr[10]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr09 (.O(), .I(smc_addr[ 9]),  .IO(X_memaddr[ 9]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr08 (.O(), .I(smc_addr[ 8]),  .IO(X_memaddr[ 8]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr07 (.O(), .I(smc_addr[ 7]),  .IO(X_memaddr[ 7]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr06 (.O(), .I(smc_addr[ 6]),  .IO(X_memaddr[ 6]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr05 (.O(), .I(smc_addr[ 5]),  .IO(X_memaddr[ 5]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr04 (.O(), .I(smc_addr[ 4]),  .IO(X_memaddr[ 4]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr03 (.O(), .I(smc_addr[ 3]),  .IO(X_memaddr[ 3]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr02 (.O(), .I(smc_addr[ 2]),  .IO(X_memaddr[ 2]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr01 (.O(), .I(smc_addr[ 1]),  .IO(X_memaddr[ 1]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_memaddr00 (.O(), .I(smc_addr[ 0]),  .IO(X_memaddr[ 0]),  .E(1'b1),  .PU(1'b0), .PD(1'b0));

nds_inout_pad  pad_smc_we_b  (.O(), .I(smc_we_n),   .IO(X_smc_we_b),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_smc_cs_b0 (.O(), .I(smc_cs_n_0), .IO(X_smc_cs_b),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_smc_oe_b  (.O(), .I(smc_oe_n),   .IO(X_smc_oe_b), .E(1'b1),  .PU(1'b0), .PD(1'b0));
`endif	// AE350_SMC_SUPPORT

`ifdef AE350_MAC_SUPPORT
//--------------------------------------------------------------------------------------
// MAC
//--------------------------------------------------------------------------------------

nds_inout_pad  pad_tx_clk  (.O(T_tx_clk), .IO(X_tx_clk), .I(1'b0), .E(1'b0), .PU(1'b0), .PD(1'b0));

nds_inout_pad pad_tx_en (.O(), .IO(X_tx_en),  .I(tx_en),  .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_txd3  (.O(), .IO(X_txd[3]), .I(txd[3]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_txd2  (.O(), .IO(X_txd[2]), .I(txd[2]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_txd1  (.O(), .IO(X_txd[1]), .I(txd[1]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_txd0  (.O(), .IO(X_txd[0]), .I(txd[0]), .E(1'b1), .PU(1'b0), .PD(1'b0));

nds_inout_pad  pad_rx_clk (.O(T_rx_clk), .IO(X_rx_clk), .I(1'b0), .E(1'b0), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_rx_dv  (.O(T_rx_dv),  .IO(X_rx_dv), .I(1'b0), .E(1'b0), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_rx_er  (.O(T_rx_er),  .IO(X_rx_er), .I(1'b0), .E(1'b0), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_rxd3   (.O(T_rxd[3]), .IO(X_rxd[3]), .I(1'b0), .E(1'b0), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_rxd2   (.O(T_rxd[2]), .IO(X_rxd[2]), .I(1'b0), .E(1'b0), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_rxd1   (.O(T_rxd[1]), .IO(X_rxd[1]), .I(1'b0), .E(1'b0), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_rxd0   (.O(T_rxd[0]), .IO(X_rxd[0]), .I(1'b0), .E(1'b0), .PU(1'b0), .PD(1'b0));

nds_inout_pad  pad_crs    (.O(T_crs), .IO(X_crs), .I(1'b0), .E(1'b0), .PU(1'b0), .PD(1'b0));
nds_inout_pad  pad_col    (.O(T_col), .IO(X_col), .I(1'b0), .E(1'b0), .PU(1'b0), .PD(1'b0));

nds_inout_pad pad_mdc     (.O(), .IO(X_mdc), .I(mdc), .E(1'b1), .PU(1'b0), .PD(1'b0));

nds_inout_pad pad_mdio    (.O(T_mdio), .I(mdio_out), .IO(X_mdio), .E(mdio_out_en), .PU(1'b0), .PD(1'b0));

nds_inout_pad  pad_phy_linksts (.O(T_phy_linksts), .IO(X_phy_linksts), .I(1'b0), .E(1'b0), .PU(1'b0), .PD(1'b0));

nds_inout_pad pad_pdn_phy   (.O(), .IO(X_pdn_phy), .I(pdn_phy), .E(1'b1), .PU(1'b0), .PD(1'b0));
`endif	// AE350_MAC_SUPPORT

`ifdef AE350_LCDC_SUPPORT
//--------------------------------------------------------------------------------------
// CLCD
//--------------------------------------------------------------------------------------

nds_inout_pad pad_clpower (.O(), .I(clpower), .IO(X_clpower), .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cllp    (.O(), .I(cllp),    .IO(X_cllp),    .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_clcp    (.O(), .I(clcp),    .IO(X_clcp),    .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_clfp    (.O(), .I(clfp),    .IO(X_clfp),    .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_clac    (.O(), .I(clac),    .IO(X_clac),    .E(1'b1),  .PU(1'b0), .PD(1'b0));


nds_inout_pad pad_cld23   (.O(), .I(cld[23]), .IO(X_cld[23]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld22   (.O(), .I(cld[22]), .IO(X_cld[22]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld21   (.O(), .I(cld[21]), .IO(X_cld[21]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld20   (.O(), .I(cld[20]), .IO(X_cld[20]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld19   (.O(), .I(cld[19]), .IO(X_cld[19]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld18   (.O(), .I(cld[18]), .IO(X_cld[18]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld17   (.O(), .I(cld[17]), .IO(X_cld[17]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld16   (.O(), .I(cld[16]), .IO(X_cld[16]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld15   (.O(), .I(cld[15]), .IO(X_cld[15]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld14   (.O(), .I(cld[14]), .IO(X_cld[14]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld13   (.O(), .I(cld[13]), .IO(X_cld[13]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld12   (.O(), .I(cld[12]), .IO(X_cld[12]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld11   (.O(), .I(cld[11]), .IO(X_cld[11]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld10   (.O(), .I(cld[10]), .IO(X_cld[10]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld09   (.O(), .I(cld[ 9]), .IO(X_cld[ 9]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld08   (.O(), .I(cld[ 8]), .IO(X_cld[ 8]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld07   (.O(), .I(cld[ 7]), .IO(X_cld[ 7]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld06   (.O(), .I(cld[ 6]), .IO(X_cld[ 6]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld05   (.O(), .I(cld[ 5]), .IO(X_cld[ 5]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld04   (.O(), .I(cld[ 4]), .IO(X_cld[ 4]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld03   (.O(), .I(cld[ 3]), .IO(X_cld[ 3]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld02   (.O(), .I(cld[ 2]), .IO(X_cld[ 2]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld01   (.O(), .I(cld[ 1]), .IO(X_cld[ 1]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_cld00   (.O(), .I(cld[ 0]), .IO(X_cld[ 0]), .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_clle   (.O(), .I(clle), .IO(X_clle), .E(1'b1), .PU(1'b0), .PD(1'b0));
`endif	// LCDC_SUPPORT

`ifdef AE350_SDC_SUPPORT
//--------------------------------------------------------------------------------------
// SDC
//--------------------------------------------------------------------------------------

nds_inout_pad   pad_sd_cd   (.O(T_sd_cd), .I(1'b0), .IO(X_sd_cd), .E(1'b0), .PU(1'b0), .PD(1'b0));
nds_inout_pad   pad_sd_wp   (.O(T_sd_wp), .I(1'b0), .IO(X_sd_wp), .E(1'b0), .PU(1'b0), .PD(1'b0));

nds_inout_pad   pad_sd_clk  (.O(), .IO(X_sd_clk),      .I(sd_clk),      .E(1'b1), .PU(1'b0), .PD(1'b0));
nds_inout_pad   pad_sd_pwron(.O(), .IO(X_sd_power_on), .I(sd_power[4]), .E(1'b1), .PU(1'b0), .PD(1'b0));

nds_inout_pad pad_io_sd_rsp  (.O(T_sd_rsp),     .I(sd_cmd),      .IO(X_sd_cmd_rsp), .E(sd_cmd_oe),  .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_io_sd_dat3 (.O(T_sd_dat3_in), .I(sd_dat3_out), .IO(X_sd_dat3),    .E(sd_dat3_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_io_sd_dat2 (.O(T_sd_dat2_in), .I(sd_dat2_out), .IO(X_sd_dat2),    .E(sd_dat2_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_io_sd_dat1 (.O(T_sd_dat1_in), .I(sd_dat1_out), .IO(X_sd_dat1),    .E(sd_dat1_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_io_sd_dat0 (.O(T_sd_dat0_in), .I(sd_dat0_out), .IO(X_sd_dat0),    .E(sd_dat0_oe), .PU(1'b0), .PD(1'b0));

`endif	// AE350_SDC_SUPPORT

`ifdef AE350_SSP_SUPPORT
nds_inout_pad  pad_ssp_rxd (.O(T_ssp_rxd), .I(1'b0), .IO(X_ssp_rxd), .E(1'b0), .PU(1'b0), .PD(1'b0)); 

nds_inout_pad pad_ssp_txd   (.O(), .I(ssp_txd), .IO(X_ssp_txd), .E(ssp_txd_oe), .PU(1'b0), .PD(1'b0));

nds_inout_pad pad_ssp_sclk  (.O(T_ssp_sclk_in), .I(ssp_sclk_out), .IO(X_ssp_sclk), .E(ssp_sclk_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_ssp_fs    (.O(T_ssp_fs_in),   .I(ssp_fs_out),   .IO(X_ssp_fs),   .E(ssp_fs_oe),   .PU(1'b0), .PD(1'b0));

nds_inout_pad pad_ssp_ac97_resetn   (.O(), .I(ssp_ac97_resetn), .IO(X_ssp_ac97_resetn), .E(1'b1), .PU(1'b0), .PD(1'b0));
`endif	// AE350_SSP_SUPPORT

`ifdef AE350_GPIO_SUPPORT
// GPIO intefaces
// VPERL_BEGIN
// for my $i (0 .. 31) {
//   if ($i == 0) {
//     :	`ifdef NDS_BOARD_CF1
//     :assign gpio_in[0] = gpio_out[0];
//     :	`else	// !NDS_BOARD_CF1
//   }
//   if ($i < 12) {
//     :nds_inout_pad gpio${i}_pad	(.O(gpio_in[${i}]), .I(gpio_out[${i}]), .IO(X_gpio[${i}]), .E(gpio_oe[${i}]),  .PU(gpio_pullup[${i}]), .PD(gpio_pulldown[${i}]));
//   } else {
//     $j = sprintf("%02d", $i);
//     :nds_inout_pad gpio${i}_pad	(.O(gpio_in_${j}), .I(gpio_out_${j}), .IO(X_gpio[${i}]), .E(gpio_oe_${j}),  .PU(gpio_pullup_${j}), .PD(gpio_pulldown_${j}));
//   }
//   if ($i == 0) {
//     :	`endif	// !NDS_BOARD_CF1
//   }
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
	`ifdef NDS_BOARD_CF1
assign gpio_in[0] = gpio_out[0];
	`else	// !NDS_BOARD_CF1
nds_inout_pad gpio0_pad	(.O(gpio_in[0]), .I(gpio_out[0]), .IO(X_gpio[0]), .E(gpio_oe[0]),  .PU(gpio_pullup[0]), .PD(gpio_pulldown[0]));
	`endif	// !NDS_BOARD_CF1
nds_inout_pad gpio1_pad	(.O(gpio_in[1]), .I(gpio_out[1]), .IO(X_gpio[1]), .E(gpio_oe[1]),  .PU(gpio_pullup[1]), .PD(gpio_pulldown[1]));
nds_inout_pad gpio2_pad	(.O(gpio_in[2]), .I(gpio_out[2]), .IO(X_gpio[2]), .E(gpio_oe[2]),  .PU(gpio_pullup[2]), .PD(gpio_pulldown[2]));
nds_inout_pad gpio3_pad	(.O(gpio_in[3]), .I(gpio_out[3]), .IO(X_gpio[3]), .E(gpio_oe[3]),  .PU(gpio_pullup[3]), .PD(gpio_pulldown[3]));
nds_inout_pad gpio4_pad	(.O(gpio_in[4]), .I(gpio_out[4]), .IO(X_gpio[4]), .E(gpio_oe[4]),  .PU(gpio_pullup[4]), .PD(gpio_pulldown[4]));
nds_inout_pad gpio5_pad	(.O(gpio_in[5]), .I(gpio_out[5]), .IO(X_gpio[5]), .E(gpio_oe[5]),  .PU(gpio_pullup[5]), .PD(gpio_pulldown[5]));
nds_inout_pad gpio6_pad	(.O(gpio_in[6]), .I(gpio_out[6]), .IO(X_gpio[6]), .E(gpio_oe[6]),  .PU(gpio_pullup[6]), .PD(gpio_pulldown[6]));
nds_inout_pad gpio7_pad	(.O(gpio_in[7]), .I(gpio_out[7]), .IO(X_gpio[7]), .E(gpio_oe[7]),  .PU(gpio_pullup[7]), .PD(gpio_pulldown[7]));
nds_inout_pad gpio8_pad	(.O(gpio_in[8]), .I(gpio_out[8]), .IO(X_gpio[8]), .E(gpio_oe[8]),  .PU(gpio_pullup[8]), .PD(gpio_pulldown[8]));
nds_inout_pad gpio9_pad	(.O(gpio_in[9]), .I(gpio_out[9]), .IO(X_gpio[9]), .E(gpio_oe[9]),  .PU(gpio_pullup[9]), .PD(gpio_pulldown[9]));
nds_inout_pad gpio10_pad	(.O(gpio_in[10]), .I(gpio_out[10]), .IO(X_gpio[10]), .E(gpio_oe[10]),  .PU(gpio_pullup[10]), .PD(gpio_pulldown[10]));
nds_inout_pad gpio11_pad	(.O(gpio_in[11]), .I(gpio_out[11]), .IO(X_gpio[11]), .E(gpio_oe[11]),  .PU(gpio_pullup[11]), .PD(gpio_pulldown[11]));
nds_inout_pad gpio12_pad	(.O(gpio_in_12), .I(gpio_out_12), .IO(X_gpio[12]), .E(gpio_oe_12),  .PU(gpio_pullup_12), .PD(gpio_pulldown_12));
nds_inout_pad gpio13_pad	(.O(gpio_in_13), .I(gpio_out_13), .IO(X_gpio[13]), .E(gpio_oe_13),  .PU(gpio_pullup_13), .PD(gpio_pulldown_13));
nds_inout_pad gpio14_pad	(.O(gpio_in_14), .I(gpio_out_14), .IO(X_gpio[14]), .E(gpio_oe_14),  .PU(gpio_pullup_14), .PD(gpio_pulldown_14));
nds_inout_pad gpio15_pad	(.O(gpio_in_15), .I(gpio_out_15), .IO(X_gpio[15]), .E(gpio_oe_15),  .PU(gpio_pullup_15), .PD(gpio_pulldown_15));
nds_inout_pad gpio16_pad	(.O(gpio_in_16), .I(gpio_out_16), .IO(X_gpio[16]), .E(gpio_oe_16),  .PU(gpio_pullup_16), .PD(gpio_pulldown_16));
nds_inout_pad gpio17_pad	(.O(gpio_in_17), .I(gpio_out_17), .IO(X_gpio[17]), .E(gpio_oe_17),  .PU(gpio_pullup_17), .PD(gpio_pulldown_17));
nds_inout_pad gpio18_pad	(.O(gpio_in_18), .I(gpio_out_18), .IO(X_gpio[18]), .E(gpio_oe_18),  .PU(gpio_pullup_18), .PD(gpio_pulldown_18));
nds_inout_pad gpio19_pad	(.O(gpio_in_19), .I(gpio_out_19), .IO(X_gpio[19]), .E(gpio_oe_19),  .PU(gpio_pullup_19), .PD(gpio_pulldown_19));
nds_inout_pad gpio20_pad	(.O(gpio_in_20), .I(gpio_out_20), .IO(X_gpio[20]), .E(gpio_oe_20),  .PU(gpio_pullup_20), .PD(gpio_pulldown_20));
nds_inout_pad gpio21_pad	(.O(gpio_in_21), .I(gpio_out_21), .IO(X_gpio[21]), .E(gpio_oe_21),  .PU(gpio_pullup_21), .PD(gpio_pulldown_21));
nds_inout_pad gpio22_pad	(.O(gpio_in_22), .I(gpio_out_22), .IO(X_gpio[22]), .E(gpio_oe_22),  .PU(gpio_pullup_22), .PD(gpio_pulldown_22));
nds_inout_pad gpio23_pad	(.O(gpio_in_23), .I(gpio_out_23), .IO(X_gpio[23]), .E(gpio_oe_23),  .PU(gpio_pullup_23), .PD(gpio_pulldown_23));
nds_inout_pad gpio24_pad	(.O(gpio_in_24), .I(gpio_out_24), .IO(X_gpio[24]), .E(gpio_oe_24),  .PU(gpio_pullup_24), .PD(gpio_pulldown_24));
nds_inout_pad gpio25_pad	(.O(gpio_in_25), .I(gpio_out_25), .IO(X_gpio[25]), .E(gpio_oe_25),  .PU(gpio_pullup_25), .PD(gpio_pulldown_25));
nds_inout_pad gpio26_pad	(.O(gpio_in_26), .I(gpio_out_26), .IO(X_gpio[26]), .E(gpio_oe_26),  .PU(gpio_pullup_26), .PD(gpio_pulldown_26));
nds_inout_pad gpio27_pad	(.O(gpio_in_27), .I(gpio_out_27), .IO(X_gpio[27]), .E(gpio_oe_27),  .PU(gpio_pullup_27), .PD(gpio_pulldown_27));
nds_inout_pad gpio28_pad	(.O(gpio_in_28), .I(gpio_out_28), .IO(X_gpio[28]), .E(gpio_oe_28),  .PU(gpio_pullup_28), .PD(gpio_pulldown_28));
nds_inout_pad gpio29_pad	(.O(gpio_in_29), .I(gpio_out_29), .IO(X_gpio[29]), .E(gpio_oe_29),  .PU(gpio_pullup_29), .PD(gpio_pulldown_29));
nds_inout_pad gpio30_pad	(.O(gpio_in_30), .I(gpio_out_30), .IO(X_gpio[30]), .E(gpio_oe_30),  .PU(gpio_pullup_30), .PD(gpio_pulldown_30));
nds_inout_pad gpio31_pad	(.O(gpio_in_31), .I(gpio_out_31), .IO(X_gpio[31]), .E(gpio_oe_31),  .PU(gpio_pullup_31), .PD(gpio_pulldown_31));
// VPERL_GENERATED_END

	`ifdef NDS_BOARD_CF1
wire	[63:0]	cf1_pinmux_ctrls = {cf1_pinmux_ctrl1, cf1_pinmux_ctrl0};
	`else	// !NDS_BOARD_CF1
// In non-CF1, select 2'b10 for muxes of gpio[16,17,26,27,28,29,30,31] so that GPIOs
// can work normally.
//				       31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
wire	[63:0]	cf1_pinmux_ctrls = 64'b10_10_10_10_10_10_00_00_00_00_00_00_00_00_10_10_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00;
	`endif	// !NDS_BOARD_CF1
// VPERL_BEGIN
// foreach ($i = 12; $i < 32; $i++) {
//   printf("wire [1:0]	pm_sel_%02d = cf1_pinmux_ctrls[%2d:%2d];\n", $i, $i*2+1, $i*2);
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
wire [1:0]	pm_sel_12 = cf1_pinmux_ctrls[25:24];
wire [1:0]	pm_sel_13 = cf1_pinmux_ctrls[27:26];
wire [1:0]	pm_sel_14 = cf1_pinmux_ctrls[29:28];
wire [1:0]	pm_sel_15 = cf1_pinmux_ctrls[31:30];
wire [1:0]	pm_sel_16 = cf1_pinmux_ctrls[33:32];
wire [1:0]	pm_sel_17 = cf1_pinmux_ctrls[35:34];
wire [1:0]	pm_sel_18 = cf1_pinmux_ctrls[37:36];
wire [1:0]	pm_sel_19 = cf1_pinmux_ctrls[39:38];
wire [1:0]	pm_sel_20 = cf1_pinmux_ctrls[41:40];
wire [1:0]	pm_sel_21 = cf1_pinmux_ctrls[43:42];
wire [1:0]	pm_sel_22 = cf1_pinmux_ctrls[45:44];
wire [1:0]	pm_sel_23 = cf1_pinmux_ctrls[47:46];
wire [1:0]	pm_sel_24 = cf1_pinmux_ctrls[49:48];
wire [1:0]	pm_sel_25 = cf1_pinmux_ctrls[51:50];
wire [1:0]	pm_sel_26 = cf1_pinmux_ctrls[53:52];
wire [1:0]	pm_sel_27 = cf1_pinmux_ctrls[55:54];
wire [1:0]	pm_sel_28 = cf1_pinmux_ctrls[57:56];
wire [1:0]	pm_sel_29 = cf1_pinmux_ctrls[59:58];
wire [1:0]	pm_sel_30 = cf1_pinmux_ctrls[61:60];
wire [1:0]	pm_sel_31 = cf1_pinmux_ctrls[63:62];
// VPERL_GENERATED_END

//
// PINMUX Inputs
//
assign gpio_in[12]	= (pm_sel_12==2'd0) ? gpio_in_12 : 1'b0;
assign gpio_in[13]	= (pm_sel_13==2'd0) ? gpio_in_13 : 1'b0;
assign gpio_in[14]	= (pm_sel_14==2'd0) ? gpio_in_14 : 1'b0;
assign gpio_in[15]	= (pm_sel_15==2'd0) ? gpio_in_15 : 1'b0;
assign gpio_in[16]	= (pm_sel_16==2'd2) ? gpio_in_16 : 1'b0;
assign gpio_in[17]	= (pm_sel_17==2'd2) ? gpio_in_17 : 1'b0;
assign gpio_in[18]	= (pm_sel_18==2'd0) ? gpio_in_18 : 1'b0;
assign gpio_in[19]	= (pm_sel_19==2'd0) ? gpio_in_19 : 1'b0;
assign gpio_in[20]	= (pm_sel_20==2'd0) ? gpio_in_20 : 1'b0;
assign gpio_in[21]	= (pm_sel_21==2'd0) ? gpio_in_21 : 1'b0;
assign gpio_in[22]	= (pm_sel_22==2'd0) ? gpio_in_22 : 1'b0;
assign gpio_in[23]	= (pm_sel_23==2'd0) ? gpio_in_23 : 1'b0;
assign gpio_in[24]	= (pm_sel_24==2'd0) ? gpio_in_24 : 1'b0;
assign gpio_in[25]	= (pm_sel_25==2'd0) ? gpio_in_25 : 1'b0;
assign gpio_in[26]	= (pm_sel_26==2'd2) ? gpio_in_26 : 1'b0;
assign gpio_in[27]	= (pm_sel_27==2'd2) ? gpio_in_27 : 1'b0;
assign gpio_in[28]	= (pm_sel_28==2'd2) ? gpio_in_28 : 1'b0;
assign gpio_in[29]	= (pm_sel_29==2'd2) ? gpio_in_29 : 1'b0;
assign gpio_in[30]	= (pm_sel_30==2'd2) ? gpio_in_30 : 1'b0;
assign gpio_in[31]	= (pm_sel_31==2'd2) ? gpio_in_31 : 1'b0;

	`ifdef AE350_I2C2_SUPPORT
assign i2c2_sda_in	= (pm_sel_24==2'd2) ? gpio_in_24 : 1'b0;
assign i2c2_scl_in	= (pm_sel_25==2'd2) ? gpio_in_25 : 1'b0;
	`endif	// AE350_I2C2_SUPPORT

	`ifdef NDS_BOARD_CF1
		`ifdef AE350_UART2_SUPPORT
assign uart2_rxd	= (pm_sel_16==2'd0) ? gpio_in_16 : 1'b0;
		`endif
		`ifdef AE350_UART1_SUPPORT
assign uart1_rxd	= (pm_sel_18==2'd2) ? gpio_in_18 : 1'b0;
		`endif

		`ifdef AE350_SPI2_SUPPORT
assign spi2_csn_in	= (pm_sel_26==2'd0) ? gpio_in_26 : 1'b0;
assign spi2_mosi_in	= (pm_sel_27==2'd0) ? gpio_in_27 : 1'b0;
assign spi2_miso_in	= (pm_sel_28==2'd0) ? gpio_in_28 : 1'b0;
assign spi2_clk_in	= (pm_sel_29==2'd0) ? gpio_in_29 : 1'b0;
		`endif

		`ifdef AE350_I2C_SUPPORT
assign i2c_sda_in	= (pm_sel_30==2'd0) ? gpio_in_30 : 1'b0;
assign i2c_scl_in	= (pm_sel_31==2'd0) ? gpio_in_31 : 1'b0;
		`endif
	`endif	// NDS_BOARD_CF1


//
// PINMUX Outputs
//
// out
assign gpio_out_12	= (pm_sel_12==2'd0) ? gpio_out[12]	: (pm_sel_12==2'd1) ? pit2_ch0_pwm	: (pm_sel_12==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_13	= (pm_sel_13==2'd0) ? gpio_out[13]	: (pm_sel_13==2'd1) ? pit2_ch1_pwm	: (pm_sel_13==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_14	= (pm_sel_14==2'd0) ? gpio_out[14]	: (pm_sel_14==2'd1) ? pit2_ch2_pwm	: (pm_sel_14==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_15	= (pm_sel_15==2'd0) ? gpio_out[15]	: (pm_sel_15==2'd1) ? pit2_ch3_pwm	: (pm_sel_15==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_16	= (pm_sel_16==2'd0) ? /*uart2_rxd*/1'b0	: (pm_sel_16==2'd1) ? pit3_ch0_pwm	: (pm_sel_16==2'd2) ? gpio_out[16]	: 1'b0;
assign gpio_out_17	= (pm_sel_17==2'd0) ? uart2_txd		: (pm_sel_17==2'd1) ? pit3_ch1_pwm	: (pm_sel_17==2'd2) ? gpio_out[17]	: 1'b0;
assign gpio_out_18	= (pm_sel_18==2'd0) ? gpio_out[18]	: (pm_sel_18==2'd1) ? pit3_ch2_pwm	: (pm_sel_18==2'd2) ? /*uart1_rxd*/1'b0	: 1'b0;
assign gpio_out_19	= (pm_sel_19==2'd0) ? gpio_out[19]	: (pm_sel_19==2'd1) ? pit3_ch3_pwm	: (pm_sel_19==2'd2) ? uart1_txd		: 1'b0;
assign gpio_out_20	= (pm_sel_20==2'd0) ? gpio_out[20]	: (pm_sel_20==2'd1) ? pit4_ch0_pwm	: (pm_sel_20==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_21	= (pm_sel_21==2'd0) ? gpio_out[21]	: (pm_sel_21==2'd1) ? pit4_ch1_pwm	: (pm_sel_21==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_22	= (pm_sel_22==2'd0) ? gpio_out[22]	: (pm_sel_22==2'd1) ? pit4_ch2_pwm	: (pm_sel_22==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_23	= (pm_sel_23==2'd0) ? gpio_out[23]	: (pm_sel_23==2'd1) ? pit4_ch3_pwm	: (pm_sel_23==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_24	= (pm_sel_24==2'd0) ? gpio_out[24]	: (pm_sel_24==2'd1) ? pit5_ch0_pwm	: (pm_sel_24==2'd2) ? /*i2c2_sda*/1'b0	: 1'b0;
assign gpio_out_25	= (pm_sel_25==2'd0) ? gpio_out[25]	: (pm_sel_25==2'd1) ? pit5_ch1_pwm	: (pm_sel_25==2'd2) ? /*i2c2_scl*/1'b0	: 1'b0;
assign gpio_out_26	= (pm_sel_26==2'd0) ? spi2_csn_out	: (pm_sel_26==2'd1) ? pit5_ch2_pwm	: (pm_sel_26==2'd2) ? gpio_out[26]	: 1'b0;
assign gpio_out_27	= (pm_sel_27==2'd0) ? spi2_mosi_out	: (pm_sel_27==2'd1) ? pit5_ch3_pwm	: (pm_sel_27==2'd2) ? gpio_out[27]	: 1'b0;
assign gpio_out_28	= (pm_sel_28==2'd0) ? spi2_miso_out	: (pm_sel_28==2'd1) ? 1'b0		: (pm_sel_28==2'd2) ? gpio_out[28]	: 1'b0;
assign gpio_out_29	= (pm_sel_29==2'd0) ? spi2_clk_out	: (pm_sel_29==2'd1) ? 1'b0		: (pm_sel_29==2'd2) ? gpio_out[29]	: 1'b0;
assign gpio_out_30	= (pm_sel_30==2'd0) ? /*i2c_sda*/1'b0	: (pm_sel_30==2'd1) ? 1'b0		: (pm_sel_30==2'd2) ? gpio_out[30]	: 1'b0;
assign gpio_out_31	= (pm_sel_31==2'd0) ? /*i2c_scl*/1'b0	: (pm_sel_31==2'd1) ? 1'b0		: (pm_sel_31==2'd2) ? gpio_out[31]	: 1'b0;

// oe
assign gpio_oe_12	= (pm_sel_12==2'd0) ? gpio_oe[12]	: (pm_sel_12==2'd1) ? pit2_ch0_pwmoe	: (pm_sel_12==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_13	= (pm_sel_13==2'd0) ? gpio_oe[13]	: (pm_sel_13==2'd1) ? pit2_ch1_pwmoe	: (pm_sel_13==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_14	= (pm_sel_14==2'd0) ? gpio_oe[14]	: (pm_sel_14==2'd1) ? pit2_ch2_pwmoe	: (pm_sel_14==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_15	= (pm_sel_15==2'd0) ? gpio_oe[15]	: (pm_sel_15==2'd1) ? pit2_ch3_pwmoe	: (pm_sel_15==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_16	= (pm_sel_16==2'd0) ? /*uart2_rxd*/1'b0	: (pm_sel_16==2'd1) ? pit3_ch0_pwmoe	: (pm_sel_16==2'd2) ? gpio_oe[16]	: 1'b0;
assign gpio_oe_17	= (pm_sel_17==2'd0) ? /*uart2_txd*/1'b1	: (pm_sel_17==2'd1) ? pit3_ch1_pwmoe	: (pm_sel_17==2'd2) ? gpio_oe[17]	: 1'b0;
assign gpio_oe_18	= (pm_sel_18==2'd0) ? gpio_oe[18]	: (pm_sel_18==2'd1) ? pit3_ch2_pwmoe	: (pm_sel_18==2'd2) ? /*uart1_rxd*/1'b0	: 1'b0;
assign gpio_oe_19	= (pm_sel_19==2'd0) ? gpio_oe[19]	: (pm_sel_19==2'd1) ? pit3_ch3_pwmoe	: (pm_sel_19==2'd2) ? /*uart1_txd*/1'b1	: 1'b0;
assign gpio_oe_20	= (pm_sel_20==2'd0) ? gpio_oe[20]	: (pm_sel_20==2'd1) ? pit4_ch0_pwmoe	: (pm_sel_20==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_21	= (pm_sel_21==2'd0) ? gpio_oe[21]	: (pm_sel_21==2'd1) ? pit4_ch1_pwmoe	: (pm_sel_21==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_22	= (pm_sel_22==2'd0) ? gpio_oe[22]	: (pm_sel_22==2'd1) ? pit4_ch2_pwmoe	: (pm_sel_22==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_23	= (pm_sel_23==2'd0) ? gpio_oe[23]	: (pm_sel_23==2'd1) ? pit4_ch3_pwmoe	: (pm_sel_23==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_24	= (pm_sel_24==2'd0) ? gpio_oe[24]	: (pm_sel_24==2'd1) ? pit5_ch0_pwmoe	: (pm_sel_24==2'd2) ? ~i2c2_sda		: 1'b0;
assign gpio_oe_25	= (pm_sel_25==2'd0) ? gpio_oe[25]	: (pm_sel_25==2'd1) ? pit5_ch1_pwmoe	: (pm_sel_25==2'd2) ? ~i2c2_scl		: 1'b0;
assign gpio_oe_26	= (pm_sel_26==2'd0) ? spi2_csn_oe	: (pm_sel_26==2'd1) ? pit5_ch2_pwmoe	: (pm_sel_26==2'd2) ? gpio_oe[26]	: 1'b0;
assign gpio_oe_27	= (pm_sel_27==2'd0) ? spi2_mosi_oe	: (pm_sel_27==2'd1) ? pit5_ch3_pwmoe	: (pm_sel_27==2'd2) ? gpio_oe[27]	: 1'b0;
assign gpio_oe_28	= (pm_sel_28==2'd0) ? spi2_miso_oe	: (pm_sel_28==2'd1) ? 1'b0		: (pm_sel_28==2'd2) ? gpio_oe[28]	: 1'b0;
assign gpio_oe_29	= (pm_sel_29==2'd0) ? spi2_clk_oe	: (pm_sel_29==2'd1) ? 1'b0		: (pm_sel_29==2'd2) ? gpio_oe[29]	: 1'b0;
assign gpio_oe_30	= (pm_sel_30==2'd0) ? ~i2c_sda		: (pm_sel_30==2'd1) ? 1'b0		: (pm_sel_30==2'd2) ? gpio_oe[30]	: 1'b0;
assign gpio_oe_31	= (pm_sel_31==2'd0) ? ~i2c_scl		: (pm_sel_31==2'd1) ? 1'b0		: (pm_sel_31==2'd2) ? gpio_oe[31]	: 1'b0;

// pullup
assign gpio_pullup_12	= (pm_sel_12==2'd0) ? gpio_pullup[12]	: (pm_sel_12==2'd1) ? 1'b0		: (pm_sel_12==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_13	= (pm_sel_13==2'd0) ? gpio_pullup[13]	: (pm_sel_13==2'd1) ? 1'b0		: (pm_sel_13==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_14	= (pm_sel_14==2'd0) ? gpio_pullup[14]	: (pm_sel_14==2'd1) ? 1'b0		: (pm_sel_14==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_15	= (pm_sel_15==2'd0) ? gpio_pullup[15]	: (pm_sel_15==2'd1) ? 1'b0		: (pm_sel_15==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_16	= (pm_sel_16==2'd0) ? 1'b0		: (pm_sel_16==2'd1) ? 1'b0		: (pm_sel_16==2'd2) ? gpio_pullup[16]	: 1'b0;
assign gpio_pullup_17	= (pm_sel_17==2'd0) ? 1'b0		: (pm_sel_17==2'd1) ? 1'b0		: (pm_sel_17==2'd2) ? gpio_pullup[17]	: 1'b0;
assign gpio_pullup_18	= (pm_sel_18==2'd0) ? gpio_pullup[18]	: (pm_sel_18==2'd1) ? 1'b0		: (pm_sel_18==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_19	= (pm_sel_19==2'd0) ? gpio_pullup[19]	: (pm_sel_19==2'd1) ? 1'b0		: (pm_sel_19==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_20	= (pm_sel_20==2'd0) ? gpio_pullup[20]	: (pm_sel_20==2'd1) ? 1'b0		: (pm_sel_20==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_21	= (pm_sel_21==2'd0) ? gpio_pullup[21]	: (pm_sel_21==2'd1) ? 1'b0		: (pm_sel_21==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_22	= (pm_sel_22==2'd0) ? gpio_pullup[22]	: (pm_sel_22==2'd1) ? 1'b0		: (pm_sel_22==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_23	= (pm_sel_23==2'd0) ? gpio_pullup[23]	: (pm_sel_23==2'd1) ? 1'b0		: (pm_sel_23==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_24	= (pm_sel_24==2'd0) ? gpio_pullup[24]	: (pm_sel_24==2'd1) ? 1'b0		: (pm_sel_24==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_25	= (pm_sel_25==2'd0) ? gpio_pullup[25]	: (pm_sel_25==2'd1) ? 1'b0		: (pm_sel_25==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_26	= (pm_sel_26==2'd0) ? 1'b0		: (pm_sel_26==2'd1) ? 1'b0		: (pm_sel_26==2'd2) ? gpio_pullup[26]	: 1'b0;
assign gpio_pullup_27	= (pm_sel_27==2'd0) ? 1'b0		: (pm_sel_27==2'd1) ? 1'b0		: (pm_sel_27==2'd2) ? gpio_pullup[27]	: 1'b0;
assign gpio_pullup_28	= (pm_sel_28==2'd0) ? 1'b0		: (pm_sel_28==2'd1) ? 1'b0		: (pm_sel_28==2'd2) ? gpio_pullup[28]	: 1'b0;
assign gpio_pullup_29	= (pm_sel_29==2'd0) ? 1'b0		: (pm_sel_29==2'd1) ? 1'b0		: (pm_sel_29==2'd2) ? gpio_pullup[29]	: 1'b0;
assign gpio_pullup_30	= (pm_sel_30==2'd0) ? 1'b0		: (pm_sel_30==2'd1) ? 1'b0		: (pm_sel_30==2'd2) ? gpio_pullup[30]	: 1'b0;
assign gpio_pullup_31	= (pm_sel_31==2'd0) ? 1'b0		: (pm_sel_31==2'd1) ? 1'b0		: (pm_sel_31==2'd2) ? gpio_pullup[31]	: 1'b0;

// pulldown
assign gpio_pulldown_12	= (pm_sel_12==2'd0) ? gpio_pulldown[12]	: (pm_sel_12==2'd1) ? 1'b0		: (pm_sel_12==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_13	= (pm_sel_13==2'd0) ? gpio_pulldown[13]	: (pm_sel_13==2'd1) ? 1'b0		: (pm_sel_13==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_14	= (pm_sel_14==2'd0) ? gpio_pulldown[14]	: (pm_sel_14==2'd1) ? 1'b0		: (pm_sel_14==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_15	= (pm_sel_15==2'd0) ? gpio_pulldown[15]	: (pm_sel_15==2'd1) ? 1'b0		: (pm_sel_15==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_16	= (pm_sel_16==2'd0) ? 1'b0		: (pm_sel_16==2'd1) ? 1'b0		: (pm_sel_16==2'd2) ? gpio_pulldown[16]	: 1'b0;
assign gpio_pulldown_17	= (pm_sel_17==2'd0) ? 1'b0		: (pm_sel_17==2'd1) ? 1'b0		: (pm_sel_17==2'd2) ? gpio_pulldown[17]	: 1'b0;
assign gpio_pulldown_18	= (pm_sel_18==2'd0) ? gpio_pulldown[18]	: (pm_sel_18==2'd1) ? 1'b0		: (pm_sel_18==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_19	= (pm_sel_19==2'd0) ? gpio_pulldown[19]	: (pm_sel_19==2'd1) ? 1'b0		: (pm_sel_19==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_20	= (pm_sel_20==2'd0) ? gpio_pulldown[20]	: (pm_sel_20==2'd1) ? 1'b0		: (pm_sel_20==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_21	= (pm_sel_21==2'd0) ? gpio_pulldown[21]	: (pm_sel_21==2'd1) ? 1'b0		: (pm_sel_21==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_22	= (pm_sel_22==2'd0) ? gpio_pulldown[22]	: (pm_sel_22==2'd1) ? 1'b0		: (pm_sel_22==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_23	= (pm_sel_23==2'd0) ? gpio_pulldown[23]	: (pm_sel_23==2'd1) ? 1'b0		: (pm_sel_23==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_24	= (pm_sel_24==2'd0) ? gpio_pulldown[24]	: (pm_sel_24==2'd1) ? 1'b0		: (pm_sel_24==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_25	= (pm_sel_25==2'd0) ? gpio_pulldown[25]	: (pm_sel_25==2'd1) ? 1'b0		: (pm_sel_25==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_26	= (pm_sel_26==2'd0) ? 1'b0		: (pm_sel_26==2'd1) ? 1'b0		: (pm_sel_26==2'd2) ? gpio_pulldown[26]	: 1'b0;
assign gpio_pulldown_27	= (pm_sel_27==2'd0) ? 1'b0		: (pm_sel_27==2'd1) ? 1'b0		: (pm_sel_27==2'd2) ? gpio_pulldown[27]	: 1'b0;
assign gpio_pulldown_28	= (pm_sel_28==2'd0) ? 1'b0		: (pm_sel_28==2'd1) ? 1'b0		: (pm_sel_28==2'd2) ? gpio_pulldown[28]	: 1'b0;
assign gpio_pulldown_29	= (pm_sel_29==2'd0) ? 1'b0		: (pm_sel_29==2'd1) ? 1'b0		: (pm_sel_29==2'd2) ? gpio_pulldown[29]	: 1'b0;
assign gpio_pulldown_30	= (pm_sel_30==2'd0) ? 1'b0		: (pm_sel_30==2'd1) ? 1'b0		: (pm_sel_30==2'd2) ? gpio_pulldown[30]	: 1'b0;
assign gpio_pulldown_31	= (pm_sel_31==2'd0) ? 1'b0		: (pm_sel_31==2'd1) ? 1'b0		: (pm_sel_31==2'd2) ? gpio_pulldown[31]	: 1'b0;

`endif	// AE350_GPIO_SUPPORT

endmodule
