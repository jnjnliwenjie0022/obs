`ifdef ATCBMC200_CONST_VH
`else
`define ATCBMC200_CONST_VH

// ================================================================
// Constant Definition Items of ATCBMC200
// Please **DO NOT** modify any of the following definitions
// ================================================================

//-------------------------------------------------
// AHB Master Port
//-------------------------------------------------
//`define ATCBMC200_AHB_MST0 

//-------------------------------------------------
// AHB Slave Ports
//-------------------------------------------------
//`define ATCBMC200_AHB_SLV0  // ATCBMC200 register file
`ifdef ATCBMC200_ADDR_WIDTH_24
	`define ATCBMC200_AHB_SLV0_SIZE  4'h3
`else
	`define ATCBMC200_AHB_SLV0_SIZE  4'h1
`endif // ATCBMC200_ADDR_WIDTH_24

//-------------------------------------------------
// Data Width
//-------------------------------------------------
`ifdef ATCBMC200_DATA_WIDTH_1024
	`define ATCBMC200_DATA_WIDTH 1024
	`define ATCBMC200_DATA_MSB 1023
`elsif ATCBMC200_DATA_WIDTH_512
	`define ATCBMC200_DATA_WIDTH 512
	`define ATCBMC200_DATA_MSB 511
`elsif ATCBMC200_DATA_WIDTH_256
	`define ATCBMC200_DATA_WIDTH 256
	`define ATCBMC200_DATA_MSB 255
`elsif ATCBMC200_DATA_WIDTH_128
	`define ATCBMC200_DATA_WIDTH 128
	`define ATCBMC200_DATA_MSB 127
`elsif ATCBMC200_DATA_WIDTH_64
	`define ATCBMC200_DATA_WIDTH 64
	`define ATCBMC200_DATA_MSB 63
`else // ATCBMC200_DATA_WIDTH_32
	`define ATCBMC200_DATA_WIDTH 32
	`define ATCBMC200_DATA_MSB 31
`endif




//-------------------------------------------------
// AHB Slave Disable Ports from External
//-------------------------------------------------
//`define ATCBMC200_EXT_ENABLE

//-------------------------------------------------
// Address Mode
//-------------------------------------------------
`ifdef ATCBMC200_ADDR_WIDTH_24
  `define ATCBMC200_ADDR_MSB       23
  `define ATCBMC200_BASEINADDR_LSB 10
  `define ATCBMC200_BASE_MSB       13 // `ATCBMC200_ADDR_MSB - `ATCBMC200_AHBBASE_MSB
`else
        `ifdef  ATCBMC200_ADDR_WIDTH
                `define ATCBMC200_ADDR_MSB       `ATCBMC200_ADDR_WIDTH-1
                `define ATCBMC200_BASEINADDR_LSB 20
                `define ATCBMC200_BASE_MSB       `ATCBMC200_ADDR_MSB-20 // `ATCBMC200_ADDR_MSB - `ATCBMC200_BASEINADDR_LSB
        `else
                `define ATCBMC200_ADDR_MSB       31
                `define ATCBMC200_BASEINADDR_LSB 20
                `define ATCBMC200_BASE_MSB       11 // `ATCBMC200_ADDR_MSB - `ATCBMC200_BASEINADDR_LSB
        `endif
`endif // ATCBMC200_ADDR_WIDTH_24

//-------------------------------------------------
// ATCBMC200 Product ID
//-------------------------------------------------
`define ATCBMC200_PRODUCT_ID	32'h00002024


`endif // ATCBMC200_CONST_VH


