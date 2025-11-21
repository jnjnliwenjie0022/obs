//------------------------------------------------------------------------
// Filename     : ae350_config.inc
// Description  : Add for peripheral IP configurations
//------------------------------------------------------------------------
`ifdef AE350_CONFIG_VH
`else
`define AE350_CONFIG_VH

//`define AE350_GPIO_SUPPORT
//`define AE350_DMA_SUPPORT
//`define AE350_SMC_SUPPORT
//`define AE350_SDC_SUPPORT
//`define AE350_MAC_SUPPORT
//`define AE350_LCDC_SUPPORT
//`define AE350_SSP_SUPPORT
`define	AE350_SPI1_SUPPORT
//`define AE350_SPI2_SUPPORT
//`define AE350_I2C_SUPPORT
//`define AE350_UART1_SUPPORT
//`define AE350_UART2_SUPPORT
//`define AE350_PIT_SUPPORT
//`define AE350_WDT_SUPPORT
//`define AE350_RTC_SUPPORT
//------------------------------------------------------------------------
// Debug configs
//------------------------------------------------------------------------
//`define PLATFORM_NO_DEBUG_SUPPORT
//
//--- minor configurations
//`define PLATFORM_JTAG_TWOWIRE
//`define PLATFORM_PLDM_SYS_BUS_ACCESS
`define PLATFORM_PLDM_PROGBUF_SIZE      8
`define PLATFORM_PLDM_HALTGROUP_COUNT   0

//------------------------------------------------------------------------
// Unconfigurable
//------------------------------------------------------------------------
//`define AE350_AXI_SUPPORT
`define AE350_ADDR_WIDTH_32

`ifndef PLATFORM_NO_DEBUG_SUPPORT
`define PLATFORM_DEBUG_PORT
`define PLATFORM_DEBUG_SUBSYSTEM
`endif // PLATFORM_NO_DEBUG_SUPPORT

`ifdef NDS_ANDLA_I370
    `define AE350_DMA_SUPPORT
`endif // NDS_ANDLA_I370


`endif //AE350_CONFIG_VH
