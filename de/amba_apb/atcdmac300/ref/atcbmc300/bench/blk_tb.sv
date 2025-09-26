`timescale 1ns/1ps

`ifdef CLK_PERIOD
`else
	`define CLK_PERIOD		15
`endif

module blk_tb (
	  // VPERL_BEGIN
	  // foreach $x (0 .. 15) {
	  //   :`ifdef ATCBMC300_MST${x}_SUPPORT
	  //   :us${x}_arvalid,
	  //   :us${x}_arready,
	  //   :us${x}_araddr,
	  //   :us${x}_awvalid,
	  //   :us${x}_awready,
	  //   :us${x}_awaddr,
	  //   :`endif
	  // }
	  // foreach $y (1 .. 31) {
	  //   :`ifdef ATCBMC300_SLV${y}_SUPPORT
	  //   :ds${y}_arvalid,
	  //   :ds${y}_arready,
	  //   :ds${y}_awvalid,
	  //   :ds${y}_awready,
	  //   :`endif
	  // }
	  // VPERL_END

	  // VPERL_GENERATED_BEGIN
	  `ifdef ATCBMC300_MST0_SUPPORT
	  us0_arvalid,
	  us0_arready,
	  us0_araddr,
	  us0_awvalid,
	  us0_awready,
	  us0_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST1_SUPPORT
	  us1_arvalid,
	  us1_arready,
	  us1_araddr,
	  us1_awvalid,
	  us1_awready,
	  us1_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST2_SUPPORT
	  us2_arvalid,
	  us2_arready,
	  us2_araddr,
	  us2_awvalid,
	  us2_awready,
	  us2_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST3_SUPPORT
	  us3_arvalid,
	  us3_arready,
	  us3_araddr,
	  us3_awvalid,
	  us3_awready,
	  us3_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST4_SUPPORT
	  us4_arvalid,
	  us4_arready,
	  us4_araddr,
	  us4_awvalid,
	  us4_awready,
	  us4_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST5_SUPPORT
	  us5_arvalid,
	  us5_arready,
	  us5_araddr,
	  us5_awvalid,
	  us5_awready,
	  us5_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST6_SUPPORT
	  us6_arvalid,
	  us6_arready,
	  us6_araddr,
	  us6_awvalid,
	  us6_awready,
	  us6_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST7_SUPPORT
	  us7_arvalid,
	  us7_arready,
	  us7_araddr,
	  us7_awvalid,
	  us7_awready,
	  us7_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST8_SUPPORT
	  us8_arvalid,
	  us8_arready,
	  us8_araddr,
	  us8_awvalid,
	  us8_awready,
	  us8_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST9_SUPPORT
	  us9_arvalid,
	  us9_arready,
	  us9_araddr,
	  us9_awvalid,
	  us9_awready,
	  us9_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST10_SUPPORT
	  us10_arvalid,
	  us10_arready,
	  us10_araddr,
	  us10_awvalid,
	  us10_awready,
	  us10_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST11_SUPPORT
	  us11_arvalid,
	  us11_arready,
	  us11_araddr,
	  us11_awvalid,
	  us11_awready,
	  us11_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST12_SUPPORT
	  us12_arvalid,
	  us12_arready,
	  us12_araddr,
	  us12_awvalid,
	  us12_awready,
	  us12_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST13_SUPPORT
	  us13_arvalid,
	  us13_arready,
	  us13_araddr,
	  us13_awvalid,
	  us13_awready,
	  us13_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST14_SUPPORT
	  us14_arvalid,
	  us14_arready,
	  us14_araddr,
	  us14_awvalid,
	  us14_awready,
	  us14_awaddr,
	  `endif
	  `ifdef ATCBMC300_MST15_SUPPORT
	  us15_arvalid,
	  us15_arready,
	  us15_araddr,
	  us15_awvalid,
	  us15_awready,
	  us15_awaddr,
	  `endif
	  `ifdef ATCBMC300_SLV1_SUPPORT
	  ds1_arvalid,
	  ds1_arready,
	  ds1_awvalid,
	  ds1_awready,
	  `endif
	  `ifdef ATCBMC300_SLV2_SUPPORT
	  ds2_arvalid,
	  ds2_arready,
	  ds2_awvalid,
	  ds2_awready,
	  `endif
	  `ifdef ATCBMC300_SLV3_SUPPORT
	  ds3_arvalid,
	  ds3_arready,
	  ds3_awvalid,
	  ds3_awready,
	  `endif
	  `ifdef ATCBMC300_SLV4_SUPPORT
	  ds4_arvalid,
	  ds4_arready,
	  ds4_awvalid,
	  ds4_awready,
	  `endif
	  `ifdef ATCBMC300_SLV5_SUPPORT
	  ds5_arvalid,
	  ds5_arready,
	  ds5_awvalid,
	  ds5_awready,
	  `endif
	  `ifdef ATCBMC300_SLV6_SUPPORT
	  ds6_arvalid,
	  ds6_arready,
	  ds6_awvalid,
	  ds6_awready,
	  `endif
	  `ifdef ATCBMC300_SLV7_SUPPORT
	  ds7_arvalid,
	  ds7_arready,
	  ds7_awvalid,
	  ds7_awready,
	  `endif
	  `ifdef ATCBMC300_SLV8_SUPPORT
	  ds8_arvalid,
	  ds8_arready,
	  ds8_awvalid,
	  ds8_awready,
	  `endif
	  `ifdef ATCBMC300_SLV9_SUPPORT
	  ds9_arvalid,
	  ds9_arready,
	  ds9_awvalid,
	  ds9_awready,
	  `endif
	  `ifdef ATCBMC300_SLV10_SUPPORT
	  ds10_arvalid,
	  ds10_arready,
	  ds10_awvalid,
	  ds10_awready,
	  `endif
	  `ifdef ATCBMC300_SLV11_SUPPORT
	  ds11_arvalid,
	  ds11_arready,
	  ds11_awvalid,
	  ds11_awready,
	  `endif
	  `ifdef ATCBMC300_SLV12_SUPPORT
	  ds12_arvalid,
	  ds12_arready,
	  ds12_awvalid,
	  ds12_awready,
	  `endif
	  `ifdef ATCBMC300_SLV13_SUPPORT
	  ds13_arvalid,
	  ds13_arready,
	  ds13_awvalid,
	  ds13_awready,
	  `endif
	  `ifdef ATCBMC300_SLV14_SUPPORT
	  ds14_arvalid,
	  ds14_arready,
	  ds14_awvalid,
	  ds14_awready,
	  `endif
	  `ifdef ATCBMC300_SLV15_SUPPORT
	  ds15_arvalid,
	  ds15_arready,
	  ds15_awvalid,
	  ds15_awready,
	  `endif
	  `ifdef ATCBMC300_SLV16_SUPPORT
	  ds16_arvalid,
	  ds16_arready,
	  ds16_awvalid,
	  ds16_awready,
	  `endif
	  `ifdef ATCBMC300_SLV17_SUPPORT
	  ds17_arvalid,
	  ds17_arready,
	  ds17_awvalid,
	  ds17_awready,
	  `endif
	  `ifdef ATCBMC300_SLV18_SUPPORT
	  ds18_arvalid,
	  ds18_arready,
	  ds18_awvalid,
	  ds18_awready,
	  `endif
	  `ifdef ATCBMC300_SLV19_SUPPORT
	  ds19_arvalid,
	  ds19_arready,
	  ds19_awvalid,
	  ds19_awready,
	  `endif
	  `ifdef ATCBMC300_SLV20_SUPPORT
	  ds20_arvalid,
	  ds20_arready,
	  ds20_awvalid,
	  ds20_awready,
	  `endif
	  `ifdef ATCBMC300_SLV21_SUPPORT
	  ds21_arvalid,
	  ds21_arready,
	  ds21_awvalid,
	  ds21_awready,
	  `endif
	  `ifdef ATCBMC300_SLV22_SUPPORT
	  ds22_arvalid,
	  ds22_arready,
	  ds22_awvalid,
	  ds22_awready,
	  `endif
	  `ifdef ATCBMC300_SLV23_SUPPORT
	  ds23_arvalid,
	  ds23_arready,
	  ds23_awvalid,
	  ds23_awready,
	  `endif
	  `ifdef ATCBMC300_SLV24_SUPPORT
	  ds24_arvalid,
	  ds24_arready,
	  ds24_awvalid,
	  ds24_awready,
	  `endif
	  `ifdef ATCBMC300_SLV25_SUPPORT
	  ds25_arvalid,
	  ds25_arready,
	  ds25_awvalid,
	  ds25_awready,
	  `endif
	  `ifdef ATCBMC300_SLV26_SUPPORT
	  ds26_arvalid,
	  ds26_arready,
	  ds26_awvalid,
	  ds26_awready,
	  `endif
	  `ifdef ATCBMC300_SLV27_SUPPORT
	  ds27_arvalid,
	  ds27_arready,
	  ds27_awvalid,
	  ds27_awready,
	  `endif
	  `ifdef ATCBMC300_SLV28_SUPPORT
	  ds28_arvalid,
	  ds28_arready,
	  ds28_awvalid,
	  ds28_awready,
	  `endif
	  `ifdef ATCBMC300_SLV29_SUPPORT
	  ds29_arvalid,
	  ds29_arready,
	  ds29_awvalid,
	  ds29_awready,
	  `endif
	  `ifdef ATCBMC300_SLV30_SUPPORT
	  ds30_arvalid,
	  ds30_arready,
	  ds30_awvalid,
	  ds30_awready,
	  `endif
	  `ifdef ATCBMC300_SLV31_SUPPORT
	  ds31_arvalid,
	  ds31_arready,
	  ds31_awvalid,
	  ds31_awready,
	  `endif
	  // VPERL_GENERATED_END
// VPERL: &PORTLIST;
// VPERL_GENERATED_BEGIN
	  aclk,     
	  aresetn   
// VPERL_GENERATED_END
);

parameter unsigned	ADDR_WIDTH = 32;
parameter bit [2:0]	DATA_SIZE = 2;
parameter unsigned	ERROR_PROBABILITY = 10;		// Error probability (10%).
parameter unsigned	DS_ID_WIDTH = 8;

// VPERL_BEGIN
// foreach $x (0 .. 15) {
//   : `ifdef ATCBMC300_MST${x}_SUPPORT
//   : input			us${x}_arvalid;
//   : input			us${x}_arready;
//   : input [ADDR_WIDTH-1:0]	us${x}_araddr;
//   : input			us${x}_awvalid;
//   : input			us${x}_awready;
//   : input [ADDR_WIDTH-1:0]	us${x}_awaddr;
//   : `endif
// }
// foreach $y (1 .. 31) {
//   : `ifdef ATCBMC300_SLV${y}_SUPPORT
//   : input			ds${y}_arvalid;
//   : input			ds${y}_arready;
//   : input			ds${y}_awvalid;
//   : input			ds${y}_awready;
//   : `endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
input			us0_arvalid;
input			us0_arready;
input [ADDR_WIDTH-1:0]	us0_araddr;
input			us0_awvalid;
input			us0_awready;
input [ADDR_WIDTH-1:0]	us0_awaddr;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
input			us1_arvalid;
input			us1_arready;
input [ADDR_WIDTH-1:0]	us1_araddr;
input			us1_awvalid;
input			us1_awready;
input [ADDR_WIDTH-1:0]	us1_awaddr;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
input			us2_arvalid;
input			us2_arready;
input [ADDR_WIDTH-1:0]	us2_araddr;
input			us2_awvalid;
input			us2_awready;
input [ADDR_WIDTH-1:0]	us2_awaddr;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
input			us3_arvalid;
input			us3_arready;
input [ADDR_WIDTH-1:0]	us3_araddr;
input			us3_awvalid;
input			us3_awready;
input [ADDR_WIDTH-1:0]	us3_awaddr;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
input			us4_arvalid;
input			us4_arready;
input [ADDR_WIDTH-1:0]	us4_araddr;
input			us4_awvalid;
input			us4_awready;
input [ADDR_WIDTH-1:0]	us4_awaddr;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
input			us5_arvalid;
input			us5_arready;
input [ADDR_WIDTH-1:0]	us5_araddr;
input			us5_awvalid;
input			us5_awready;
input [ADDR_WIDTH-1:0]	us5_awaddr;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
input			us6_arvalid;
input			us6_arready;
input [ADDR_WIDTH-1:0]	us6_araddr;
input			us6_awvalid;
input			us6_awready;
input [ADDR_WIDTH-1:0]	us6_awaddr;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
input			us7_arvalid;
input			us7_arready;
input [ADDR_WIDTH-1:0]	us7_araddr;
input			us7_awvalid;
input			us7_awready;
input [ADDR_WIDTH-1:0]	us7_awaddr;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
input			us8_arvalid;
input			us8_arready;
input [ADDR_WIDTH-1:0]	us8_araddr;
input			us8_awvalid;
input			us8_awready;
input [ADDR_WIDTH-1:0]	us8_awaddr;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
input			us9_arvalid;
input			us9_arready;
input [ADDR_WIDTH-1:0]	us9_araddr;
input			us9_awvalid;
input			us9_awready;
input [ADDR_WIDTH-1:0]	us9_awaddr;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
input			us10_arvalid;
input			us10_arready;
input [ADDR_WIDTH-1:0]	us10_araddr;
input			us10_awvalid;
input			us10_awready;
input [ADDR_WIDTH-1:0]	us10_awaddr;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
input			us11_arvalid;
input			us11_arready;
input [ADDR_WIDTH-1:0]	us11_araddr;
input			us11_awvalid;
input			us11_awready;
input [ADDR_WIDTH-1:0]	us11_awaddr;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
input			us12_arvalid;
input			us12_arready;
input [ADDR_WIDTH-1:0]	us12_araddr;
input			us12_awvalid;
input			us12_awready;
input [ADDR_WIDTH-1:0]	us12_awaddr;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
input			us13_arvalid;
input			us13_arready;
input [ADDR_WIDTH-1:0]	us13_araddr;
input			us13_awvalid;
input			us13_awready;
input [ADDR_WIDTH-1:0]	us13_awaddr;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
input			us14_arvalid;
input			us14_arready;
input [ADDR_WIDTH-1:0]	us14_araddr;
input			us14_awvalid;
input			us14_awready;
input [ADDR_WIDTH-1:0]	us14_awaddr;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
input			us15_arvalid;
input			us15_arready;
input [ADDR_WIDTH-1:0]	us15_araddr;
input			us15_awvalid;
input			us15_awready;
input [ADDR_WIDTH-1:0]	us15_awaddr;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
input			ds1_arvalid;
input			ds1_arready;
input			ds1_awvalid;
input			ds1_awready;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
input			ds2_arvalid;
input			ds2_arready;
input			ds2_awvalid;
input			ds2_awready;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
input			ds3_arvalid;
input			ds3_arready;
input			ds3_awvalid;
input			ds3_awready;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
input			ds4_arvalid;
input			ds4_arready;
input			ds4_awvalid;
input			ds4_awready;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
input			ds5_arvalid;
input			ds5_arready;
input			ds5_awvalid;
input			ds5_awready;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
input			ds6_arvalid;
input			ds6_arready;
input			ds6_awvalid;
input			ds6_awready;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
input			ds7_arvalid;
input			ds7_arready;
input			ds7_awvalid;
input			ds7_awready;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
input			ds8_arvalid;
input			ds8_arready;
input			ds8_awvalid;
input			ds8_awready;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
input			ds9_arvalid;
input			ds9_arready;
input			ds9_awvalid;
input			ds9_awready;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
input			ds10_arvalid;
input			ds10_arready;
input			ds10_awvalid;
input			ds10_awready;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
input			ds11_arvalid;
input			ds11_arready;
input			ds11_awvalid;
input			ds11_awready;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
input			ds12_arvalid;
input			ds12_arready;
input			ds12_awvalid;
input			ds12_awready;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
input			ds13_arvalid;
input			ds13_arready;
input			ds13_awvalid;
input			ds13_awready;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
input			ds14_arvalid;
input			ds14_arready;
input			ds14_awvalid;
input			ds14_awready;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
input			ds15_arvalid;
input			ds15_arready;
input			ds15_awvalid;
input			ds15_awready;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
input			ds16_arvalid;
input			ds16_arready;
input			ds16_awvalid;
input			ds16_awready;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
input			ds17_arvalid;
input			ds17_arready;
input			ds17_awvalid;
input			ds17_awready;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
input			ds18_arvalid;
input			ds18_arready;
input			ds18_awvalid;
input			ds18_awready;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
input			ds19_arvalid;
input			ds19_arready;
input			ds19_awvalid;
input			ds19_awready;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
input			ds20_arvalid;
input			ds20_arready;
input			ds20_awvalid;
input			ds20_awready;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
input			ds21_arvalid;
input			ds21_arready;
input			ds21_awvalid;
input			ds21_awready;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
input			ds22_arvalid;
input			ds22_arready;
input			ds22_awvalid;
input			ds22_awready;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
input			ds23_arvalid;
input			ds23_arready;
input			ds23_awvalid;
input			ds23_awready;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
input			ds24_arvalid;
input			ds24_arready;
input			ds24_awvalid;
input			ds24_awready;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
input			ds25_arvalid;
input			ds25_arready;
input			ds25_awvalid;
input			ds25_awready;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
input			ds26_arvalid;
input			ds26_arready;
input			ds26_awvalid;
input			ds26_awready;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
input			ds27_arvalid;
input			ds27_arready;
input			ds27_awvalid;
input			ds27_awready;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
input			ds28_arvalid;
input			ds28_arready;
input			ds28_awvalid;
input			ds28_awready;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
input			ds29_arvalid;
input			ds29_arready;
input			ds29_awvalid;
input			ds29_awready;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
input			ds30_arvalid;
input			ds30_arready;
input			ds30_awvalid;
input			ds30_awready;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
input			ds31_arvalid;
input			ds31_arready;
input			ds31_awvalid;
input			ds31_awready;
`endif
// VPERL_GENERATED_END
output			aclk;
output			aresetn;

reg			aclk;
reg			aresetn;

bit [31:0]	msts_connections[0:15] = {
	// VPERL_BEGIN
	// foreach $i (0 .. 14) {
	// :`ifdef ATCBMC300_MST${i}_SUPPORT `NDS_M${i}_CONNS `else 32'b0 `endif,
	// }
	// VPERL_END

	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_MST0_SUPPORT `NDS_M0_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST1_SUPPORT `NDS_M1_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST2_SUPPORT `NDS_M2_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST3_SUPPORT `NDS_M3_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST4_SUPPORT `NDS_M4_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST5_SUPPORT `NDS_M5_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST6_SUPPORT `NDS_M6_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST7_SUPPORT `NDS_M7_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST8_SUPPORT `NDS_M8_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST9_SUPPORT `NDS_M9_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST10_SUPPORT `NDS_M10_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST11_SUPPORT `NDS_M11_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST12_SUPPORT `NDS_M12_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST13_SUPPORT `NDS_M13_CONNS `else 32'b0 `endif,
	`ifdef ATCBMC300_MST14_SUPPORT `NDS_M14_CONNS `else 32'b0 `endif,
	// VPERL_GENERATED_END
	`ifdef ATCBMC300_MST15_SUPPORT `NDS_M15_CONNS `else 32'b0 `endif
};

bit [ADDR_WIDTH-1:0]	slv_bases[0:31] = '{
	// VPERL_BEGIN
	// foreach $y (0 .. 30) {
	//   :`ifdef ATCBMC300_SLV${y}_SUPPORT `ATCBMC300_SLV${y}_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	// }
	// VPERL_END

	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_SLV0_SUPPORT `ATCBMC300_SLV0_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV1_SUPPORT `ATCBMC300_SLV1_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV2_SUPPORT `ATCBMC300_SLV2_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV3_SUPPORT `ATCBMC300_SLV3_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV4_SUPPORT `ATCBMC300_SLV4_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV5_SUPPORT `ATCBMC300_SLV5_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV6_SUPPORT `ATCBMC300_SLV6_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV7_SUPPORT `ATCBMC300_SLV7_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV8_SUPPORT `ATCBMC300_SLV8_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV9_SUPPORT `ATCBMC300_SLV9_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV10_SUPPORT `ATCBMC300_SLV10_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV11_SUPPORT `ATCBMC300_SLV11_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV12_SUPPORT `ATCBMC300_SLV12_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV13_SUPPORT `ATCBMC300_SLV13_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV14_SUPPORT `ATCBMC300_SLV14_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV15_SUPPORT `ATCBMC300_SLV15_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV16_SUPPORT `ATCBMC300_SLV16_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV17_SUPPORT `ATCBMC300_SLV17_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV18_SUPPORT `ATCBMC300_SLV18_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV19_SUPPORT `ATCBMC300_SLV19_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV20_SUPPORT `ATCBMC300_SLV20_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV21_SUPPORT `ATCBMC300_SLV21_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV22_SUPPORT `ATCBMC300_SLV22_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV23_SUPPORT `ATCBMC300_SLV23_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV24_SUPPORT `ATCBMC300_SLV24_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV25_SUPPORT `ATCBMC300_SLV25_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV26_SUPPORT `ATCBMC300_SLV26_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV27_SUPPORT `ATCBMC300_SLV27_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV28_SUPPORT `ATCBMC300_SLV28_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV29_SUPPORT `ATCBMC300_SLV29_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV30_SUPPORT `ATCBMC300_SLV30_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	// VPERL_GENERATED_END
	`ifdef ATCBMC300_SLV31_SUPPORT `ATCBMC300_SLV31_BASE_ADDR `else `ATCBMC300_ADDR_WIDTH'b0 `endif
};
bit [ADDR_WIDTH-1:0]	slv_eff_sizes[0:31] = '{
	// VPERL_BEGIN
	// foreach $y (0 .. 30) {
	//   :`ifdef ATCBMC300_SLV${y}_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV${y}_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	// }
	// VPERL_END

	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_SLV0_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV0_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV1_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV1_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV2_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV2_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV3_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV3_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV4_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV4_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV5_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV5_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV6_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV6_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV7_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV7_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV8_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV8_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV9_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV9_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV10_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV10_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV11_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV11_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV12_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV12_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV13_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV13_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV14_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV14_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV15_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV15_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV16_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV16_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV17_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV17_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV18_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV18_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV19_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV19_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV20_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV20_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV21_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV21_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV22_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV22_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV23_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV23_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV24_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV24_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV25_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV25_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV26_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV26_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV27_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV27_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV28_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV28_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV29_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV29_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	`ifdef ATCBMC300_SLV30_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV30_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif,
	// VPERL_GENERATED_END
	`ifdef ATCBMC300_SLV31_SUPPORT (ADDR_WIDTH)'(1<<(`ATCBMC300_SLV31_SIZE+19)) `else `ATCBMC300_ADDR_WIDTH'b0 `endif
};

// ===============
// random seed generation
// ===============
int unsigned	seed;
initial begin
	if ($value$plusargs("seed=%d", seed))
		seed = seed ^ 32'hb7cb9216;
	else
		seed = 32'hb7cb9216;
end

// ===============
// clock generation
// ===============
integer		aclk_cnt;
initial begin
	int unsigned	init_delay;

	aclk = 1'b0;
	aclk_cnt = 0;

	// Initial phase of clock
	init_delay = {$random(seed)} % `CLK_PERIOD;
	#(init_delay);

	forever begin
		#(`CLK_PERIOD / 2.0) aclk = 1'b1;
		#(`CLK_PERIOD / 2.0) aclk = 1'b0;
		aclk_cnt = aclk_cnt + 1;
	end
end

// ===============
// reset generation
// ===============
initial begin
	aresetn = 1'b0;
	repeat (2) @(posedge aclk) ;
	// @(negedge aclk);
	aresetn = 1'b1;
end

// ===============
// glue logic
// ===============

// ===============
// program exit
// ===============
initial begin: main
	reg [31:0]		status;

	status = 1;

	$timeformat (-9, 3, " ns", 12);

	begin: wait_program_exit 
		if (ADDR_WIDTH < 24 || ADDR_WIDTH > 64) begin
			$display("%m:ERROR: Unsupported addr width (%0d)!", ADDR_WIDTH);
			disable wait_program_exit;
		end
		if (DATA_SIZE < 3'd2 || DATA_SIZE > 3'd5) begin
			$display("%m:ERROR: Unsupported DATA_SIZE (%0d)!", DATA_SIZE);
			disable wait_program_exit;
		end
		// VPERL_BEGIN
		// foreach $i (0 .. 31) {
		// : `ifdef ATCBMC300_SLV${i}_SUPPORT
		// : assert({1'b0, `ATCBMC300_SLV${i}_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		// : assert((`ATCBMC300_SLV${i}_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV${i}_SIZE != 0);
		// : `endif
		// }
		// VPERL_END

		// VPERL_GENERATED_BEGIN
		`ifdef ATCBMC300_SLV0_SUPPORT
		assert({1'b0, `ATCBMC300_SLV0_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV0_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV0_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV1_SUPPORT
		assert({1'b0, `ATCBMC300_SLV1_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV1_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV1_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV2_SUPPORT
		assert({1'b0, `ATCBMC300_SLV2_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV2_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV2_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV3_SUPPORT
		assert({1'b0, `ATCBMC300_SLV3_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV3_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV3_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV4_SUPPORT
		assert({1'b0, `ATCBMC300_SLV4_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV4_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV4_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV5_SUPPORT
		assert({1'b0, `ATCBMC300_SLV5_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV5_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV5_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV6_SUPPORT
		assert({1'b0, `ATCBMC300_SLV6_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV6_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV6_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV7_SUPPORT
		assert({1'b0, `ATCBMC300_SLV7_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV7_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV7_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV8_SUPPORT
		assert({1'b0, `ATCBMC300_SLV8_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV8_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV8_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV9_SUPPORT
		assert({1'b0, `ATCBMC300_SLV9_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV9_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV9_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV10_SUPPORT
		assert({1'b0, `ATCBMC300_SLV10_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV10_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV10_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV11_SUPPORT
		assert({1'b0, `ATCBMC300_SLV11_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV11_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV11_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV12_SUPPORT
		assert({1'b0, `ATCBMC300_SLV12_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV12_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV12_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV13_SUPPORT
		assert({1'b0, `ATCBMC300_SLV13_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV13_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV13_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV14_SUPPORT
		assert({1'b0, `ATCBMC300_SLV14_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV14_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV14_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV15_SUPPORT
		assert({1'b0, `ATCBMC300_SLV15_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV15_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV15_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV16_SUPPORT
		assert({1'b0, `ATCBMC300_SLV16_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV16_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV16_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV17_SUPPORT
		assert({1'b0, `ATCBMC300_SLV17_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV17_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV17_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV18_SUPPORT
		assert({1'b0, `ATCBMC300_SLV18_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV18_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV18_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV19_SUPPORT
		assert({1'b0, `ATCBMC300_SLV19_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV19_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV19_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV20_SUPPORT
		assert({1'b0, `ATCBMC300_SLV20_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV20_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV20_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV21_SUPPORT
		assert({1'b0, `ATCBMC300_SLV21_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV21_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV21_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV22_SUPPORT
		assert({1'b0, `ATCBMC300_SLV22_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV22_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV22_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV23_SUPPORT
		assert({1'b0, `ATCBMC300_SLV23_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV23_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV23_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV24_SUPPORT
		assert({1'b0, `ATCBMC300_SLV24_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV24_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV24_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV25_SUPPORT
		assert({1'b0, `ATCBMC300_SLV25_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV25_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV25_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV26_SUPPORT
		assert({1'b0, `ATCBMC300_SLV26_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV26_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV26_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV27_SUPPORT
		assert({1'b0, `ATCBMC300_SLV27_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV27_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV27_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV28_SUPPORT
		assert({1'b0, `ATCBMC300_SLV28_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV28_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV28_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV29_SUPPORT
		assert({1'b0, `ATCBMC300_SLV29_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV29_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV29_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV30_SUPPORT
		assert({1'b0, `ATCBMC300_SLV30_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV30_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV30_SIZE != 0);
		`endif
		`ifdef ATCBMC300_SLV31_SUPPORT
		assert({1'b0, `ATCBMC300_SLV31_BASE_ADDR} < (1+ADDR_WIDTH)'(1<<ADDR_WIDTH));
		assert((`ATCBMC300_SLV31_SIZE+19) < ADDR_WIDTH && `ATCBMC300_SLV31_SIZE != 0);
		`endif
		// VPERL_GENERATED_END
		for (int y = 0; y < 32; y++) begin
			if (({1'b0, slv_bases[y]}+{1'b0, slv_eff_sizes[y]}) > (1+ADDR_WIDTH)'(1<<ADDR_WIDTH)) begin
				$display("%m:ERROR: SLV%0d_BASE_ADDR(0x%0h)+SIZE(0x%0h) >= (1<<ADDR_WIDTH(%0d))!", y, slv_bases[y], slv_eff_sizes[y], ADDR_WIDTH);
				disable wait_program_exit;
			end
			if (slv_bases[y] % slv_eff_sizes[y] != (ADDR_WIDTH)'(0)) begin
				$display("%m:ERROR: SLV%0d_BASE_ADDR(0x%0h) is not aligned to 0x%0h!", y, slv_bases[y], slv_eff_sizes[y]);
				disable wait_program_exit;
			end
			if (! check_slave_space(y, slv_bases[y], slv_eff_sizes[y])) begin
				disable wait_program_exit;
			end
		end

		// Print info so that the external script can know
		// what devices are present and some other properties.
		$write("DUMP:PROPERTIES: -m BMC300 ADDR_WIDTH=%0d DATA_WIDTH=%0d ID_WIDTH=%0d", `ATCBMC300_ADDR_WIDTH, `ATCBMC300_DATA_WIDTH, `ATCBMC300_ID_WIDTH);
		for (int i = 0; i < 16; i++) begin
			if (msts_connections[i] != 0)
				$write(" xm%0d", i);		// AXI master.
		end
		$write(" ID_WIDTH=%0d", `ATCBMC300_ID_WIDTH+4);
		for (int i = 1; i < 32; i++) begin	// Exclude the internal slave.
			if (spaces[i].capacity != (ADDR_WIDTH)'(0))
				$write(" xs%0d", i);		// AXI slave.
		end
		$write("\n");


		if (ERROR_PROBABILITY > 100) begin
			$display("%m:ERROR: ERROR_PROBABILITY (%0d) is larger than 100!", ERROR_PROBABILITY);
			disable wait_program_exit;
		end

		begin: wait_masters_exit
			fork
			// VPERL_BEGIN
			// foreach $i (0 .. 15) {
			//   : `ifdef ATCBMC300_MST${i}_SUPPORT
			//   : begin
			//   : 	`NDS_SYSTEM.axi_master${i}.wait_program_done;
			//   : 	`NDS_SYSTEM.axi_master${i}.get_program_status(status);
			//   : 	\$display("%0t:%m: Master ${i} exited (%0d).", \$realtime, status);
			//   : 	if (status)
			//   : 		disable wait_masters_exit;  // Early terminate upon error.
			//   : end
			//   : `endif
			// }
			// VPERL_END

			// VPERL_GENERATED_BEGIN
			`ifdef ATCBMC300_MST0_SUPPORT
			begin
				`NDS_SYSTEM.axi_master0.wait_program_done;
				`NDS_SYSTEM.axi_master0.get_program_status(status);
				$display("%0t:%m: Master 0 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST1_SUPPORT
			begin
				`NDS_SYSTEM.axi_master1.wait_program_done;
				`NDS_SYSTEM.axi_master1.get_program_status(status);
				$display("%0t:%m: Master 1 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST2_SUPPORT
			begin
				`NDS_SYSTEM.axi_master2.wait_program_done;
				`NDS_SYSTEM.axi_master2.get_program_status(status);
				$display("%0t:%m: Master 2 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST3_SUPPORT
			begin
				`NDS_SYSTEM.axi_master3.wait_program_done;
				`NDS_SYSTEM.axi_master3.get_program_status(status);
				$display("%0t:%m: Master 3 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST4_SUPPORT
			begin
				`NDS_SYSTEM.axi_master4.wait_program_done;
				`NDS_SYSTEM.axi_master4.get_program_status(status);
				$display("%0t:%m: Master 4 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST5_SUPPORT
			begin
				`NDS_SYSTEM.axi_master5.wait_program_done;
				`NDS_SYSTEM.axi_master5.get_program_status(status);
				$display("%0t:%m: Master 5 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST6_SUPPORT
			begin
				`NDS_SYSTEM.axi_master6.wait_program_done;
				`NDS_SYSTEM.axi_master6.get_program_status(status);
				$display("%0t:%m: Master 6 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST7_SUPPORT
			begin
				`NDS_SYSTEM.axi_master7.wait_program_done;
				`NDS_SYSTEM.axi_master7.get_program_status(status);
				$display("%0t:%m: Master 7 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST8_SUPPORT
			begin
				`NDS_SYSTEM.axi_master8.wait_program_done;
				`NDS_SYSTEM.axi_master8.get_program_status(status);
				$display("%0t:%m: Master 8 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST9_SUPPORT
			begin
				`NDS_SYSTEM.axi_master9.wait_program_done;
				`NDS_SYSTEM.axi_master9.get_program_status(status);
				$display("%0t:%m: Master 9 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST10_SUPPORT
			begin
				`NDS_SYSTEM.axi_master10.wait_program_done;
				`NDS_SYSTEM.axi_master10.get_program_status(status);
				$display("%0t:%m: Master 10 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST11_SUPPORT
			begin
				`NDS_SYSTEM.axi_master11.wait_program_done;
				`NDS_SYSTEM.axi_master11.get_program_status(status);
				$display("%0t:%m: Master 11 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST12_SUPPORT
			begin
				`NDS_SYSTEM.axi_master12.wait_program_done;
				`NDS_SYSTEM.axi_master12.get_program_status(status);
				$display("%0t:%m: Master 12 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST13_SUPPORT
			begin
				`NDS_SYSTEM.axi_master13.wait_program_done;
				`NDS_SYSTEM.axi_master13.get_program_status(status);
				$display("%0t:%m: Master 13 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST14_SUPPORT
			begin
				`NDS_SYSTEM.axi_master14.wait_program_done;
				`NDS_SYSTEM.axi_master14.get_program_status(status);
				$display("%0t:%m: Master 14 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			`ifdef ATCBMC300_MST15_SUPPORT
			begin
				`NDS_SYSTEM.axi_master15.wait_program_done;
				`NDS_SYSTEM.axi_master15.get_program_status(status);
				$display("%0t:%m: Master 15 exited (%0d).", $realtime, status);
				if (status)
					disable wait_masters_exit;  // Early terminate upon error.
			end
			`endif
			// VPERL_GENERATED_END
			join

			$display("%0t:%m: All masters exited normally.", $realtime);
		end
	end

`ifdef NDS_SCOREBOARD_EN
	if (status == 0) begin
		// trigger scoreboard final check
		`NDS_SCB.scb_final_compare();
	end
`endif // NDS_SCOREBOARD_EN
	

	$display("%0t:---- simulated %0d cpu cycles", $realtime, aclk_cnt);

	if (status == 0)
		$display("%0t:---- SIMULATION PASSED ----", $realtime);
	else begin
		$display("%0t:---- SIMULATION FAILED ----", $realtime);
		$display("%0t:Exit status = %0d", $realtime, status);
	end

	$finish;
end

class slave_space_t;
	int			index;
	bit [ADDR_WIDTH-1:0]	base;
	bit [ADDR_WIDTH-1:0]	capacity;

	function new(int index, bit [ADDR_WIDTH-1:0] base, bit [ADDR_WIDTH-1:0] capacity);
	begin
		this.index = index;
		this.base = base;
		this.capacity = capacity;
	end
	endfunction

	function bit in_range(bit [ADDR_WIDTH-1:0] addr);
		if (addr >= base && {1'b0, addr} < ({1'b0, base} + {1'b0, capacity}))
			return 1'b1;
		else
			return 1'b0;
	endfunction
endclass

slave_space_t		spaces[$];

function bit check_slave_space(int index, bit [ADDR_WIDTH-1:0] base, bit [ADDR_WIDTH-1:0] capacity);
begin
	slave_space_t		s;

	bit [ADDR_WIDTH-1:0]	top_of_region;
	bit [ADDR_WIDTH-1:0]	top_of_region_i;

	top_of_region = base + capacity;
	for (int i = 0; i < spaces.size(); i++) begin
		s = spaces[i];
		top_of_region_i = s.base + s.capacity;

		if (top_of_region <= s.base || base >= top_of_region_i) begin
			// Not overlapped.
		end
		else begin
			$display("%m:ERROR: Slave%0d's address space overlaps with slave%0d's!", index, s.index);
			return 1'b0;
		end
	end
	// Note index is now redundent here...
	s = new (index, base, capacity);
	spaces.push_back(s);

	return 1'b1;
end
endfunction

	// VPERL_BEGIN
	// foreach $x (0 .. 15) {
	//   :`ifdef ATCBMC300_MST${x}_SUPPORT
	//   :wire us${x}_arreadys_int;
	//   :wire us${x}_awreadys_int;
	//   :`endif
	// }
	// foreach $y (1 .. 31) {
	//   :`ifdef ATCBMC300_SLV${y}_SUPPORT
	//   :wire ds${y}_arvalids_int;
	//   :wire ds${y}_awvalids_int;
	//   :`endif
	// }
	// VPERL_END

	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_MST0_SUPPORT
	wire us0_arreadys_int;
	wire us0_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST1_SUPPORT
	wire us1_arreadys_int;
	wire us1_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST2_SUPPORT
	wire us2_arreadys_int;
	wire us2_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST3_SUPPORT
	wire us3_arreadys_int;
	wire us3_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST4_SUPPORT
	wire us4_arreadys_int;
	wire us4_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST5_SUPPORT
	wire us5_arreadys_int;
	wire us5_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST6_SUPPORT
	wire us6_arreadys_int;
	wire us6_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST7_SUPPORT
	wire us7_arreadys_int;
	wire us7_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST8_SUPPORT
	wire us8_arreadys_int;
	wire us8_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST9_SUPPORT
	wire us9_arreadys_int;
	wire us9_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST10_SUPPORT
	wire us10_arreadys_int;
	wire us10_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST11_SUPPORT
	wire us11_arreadys_int;
	wire us11_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST12_SUPPORT
	wire us12_arreadys_int;
	wire us12_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST13_SUPPORT
	wire us13_arreadys_int;
	wire us13_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST14_SUPPORT
	wire us14_arreadys_int;
	wire us14_awreadys_int;
	`endif
	`ifdef ATCBMC300_MST15_SUPPORT
	wire us15_arreadys_int;
	wire us15_awreadys_int;
	`endif
	`ifdef ATCBMC300_SLV1_SUPPORT
	wire ds1_arvalids_int;
	wire ds1_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV2_SUPPORT
	wire ds2_arvalids_int;
	wire ds2_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV3_SUPPORT
	wire ds3_arvalids_int;
	wire ds3_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV4_SUPPORT
	wire ds4_arvalids_int;
	wire ds4_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV5_SUPPORT
	wire ds5_arvalids_int;
	wire ds5_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV6_SUPPORT
	wire ds6_arvalids_int;
	wire ds6_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV7_SUPPORT
	wire ds7_arvalids_int;
	wire ds7_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV8_SUPPORT
	wire ds8_arvalids_int;
	wire ds8_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV9_SUPPORT
	wire ds9_arvalids_int;
	wire ds9_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV10_SUPPORT
	wire ds10_arvalids_int;
	wire ds10_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV11_SUPPORT
	wire ds11_arvalids_int;
	wire ds11_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV12_SUPPORT
	wire ds12_arvalids_int;
	wire ds12_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV13_SUPPORT
	wire ds13_arvalids_int;
	wire ds13_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV14_SUPPORT
	wire ds14_arvalids_int;
	wire ds14_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV15_SUPPORT
	wire ds15_arvalids_int;
	wire ds15_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV16_SUPPORT
	wire ds16_arvalids_int;
	wire ds16_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV17_SUPPORT
	wire ds17_arvalids_int;
	wire ds17_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV18_SUPPORT
	wire ds18_arvalids_int;
	wire ds18_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV19_SUPPORT
	wire ds19_arvalids_int;
	wire ds19_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV20_SUPPORT
	wire ds20_arvalids_int;
	wire ds20_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV21_SUPPORT
	wire ds21_arvalids_int;
	wire ds21_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV22_SUPPORT
	wire ds22_arvalids_int;
	wire ds22_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV23_SUPPORT
	wire ds23_arvalids_int;
	wire ds23_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV24_SUPPORT
	wire ds24_arvalids_int;
	wire ds24_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV25_SUPPORT
	wire ds25_arvalids_int;
	wire ds25_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV26_SUPPORT
	wire ds26_arvalids_int;
	wire ds26_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV27_SUPPORT
	wire ds27_arvalids_int;
	wire ds27_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV28_SUPPORT
	wire ds28_arvalids_int;
	wire ds28_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV29_SUPPORT
	wire ds29_arvalids_int;
	wire ds29_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV30_SUPPORT
	wire ds30_arvalids_int;
	wire ds30_awvalids_int;
	`endif
	`ifdef ATCBMC300_SLV31_SUPPORT
	wire ds31_arvalids_int;
	wire ds31_awvalids_int;
	`endif
	// VPERL_GENERATED_END
`ifdef NDS_NO_PBMC
`else
pbmc300 #(.ADDR_WIDTH(ADDR_WIDTH))	pbmc300(.*,
	// VPERL_BEGIN
	// foreach $x (0 .. 15) {
	//   :`ifdef ATCBMC300_MST${x}_SUPPORT
	//   :.us${x}_arready_int	(us${x}_arreadys_int),
	//   :.us${x}_awready_int	(us${x}_awreadys_int),
	//   :`endif
	// }
	// foreach $y (1 .. 31) {
	//   :`ifdef ATCBMC300_SLV${y}_SUPPORT
	//   :.ds${y}_arvalid_int	(ds${y}_arvalids_int),
	//   :.ds${y}_awvalid_int	(ds${y}_awvalids_int),
	//   :`endif
	// }
	// VPERL_END

	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_MST0_SUPPORT
	.us0_arready_int	(us0_arreadys_int),
	.us0_awready_int	(us0_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST1_SUPPORT
	.us1_arready_int	(us1_arreadys_int),
	.us1_awready_int	(us1_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST2_SUPPORT
	.us2_arready_int	(us2_arreadys_int),
	.us2_awready_int	(us2_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST3_SUPPORT
	.us3_arready_int	(us3_arreadys_int),
	.us3_awready_int	(us3_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST4_SUPPORT
	.us4_arready_int	(us4_arreadys_int),
	.us4_awready_int	(us4_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST5_SUPPORT
	.us5_arready_int	(us5_arreadys_int),
	.us5_awready_int	(us5_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST6_SUPPORT
	.us6_arready_int	(us6_arreadys_int),
	.us6_awready_int	(us6_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST7_SUPPORT
	.us7_arready_int	(us7_arreadys_int),
	.us7_awready_int	(us7_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST8_SUPPORT
	.us8_arready_int	(us8_arreadys_int),
	.us8_awready_int	(us8_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST9_SUPPORT
	.us9_arready_int	(us9_arreadys_int),
	.us9_awready_int	(us9_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST10_SUPPORT
	.us10_arready_int	(us10_arreadys_int),
	.us10_awready_int	(us10_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST11_SUPPORT
	.us11_arready_int	(us11_arreadys_int),
	.us11_awready_int	(us11_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST12_SUPPORT
	.us12_arready_int	(us12_arreadys_int),
	.us12_awready_int	(us12_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST13_SUPPORT
	.us13_arready_int	(us13_arreadys_int),
	.us13_awready_int	(us13_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST14_SUPPORT
	.us14_arready_int	(us14_arreadys_int),
	.us14_awready_int	(us14_awreadys_int),
	`endif
	`ifdef ATCBMC300_MST15_SUPPORT
	.us15_arready_int	(us15_arreadys_int),
	.us15_awready_int	(us15_awreadys_int),
	`endif
	`ifdef ATCBMC300_SLV1_SUPPORT
	.ds1_arvalid_int	(ds1_arvalids_int),
	.ds1_awvalid_int	(ds1_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV2_SUPPORT
	.ds2_arvalid_int	(ds2_arvalids_int),
	.ds2_awvalid_int	(ds2_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV3_SUPPORT
	.ds3_arvalid_int	(ds3_arvalids_int),
	.ds3_awvalid_int	(ds3_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV4_SUPPORT
	.ds4_arvalid_int	(ds4_arvalids_int),
	.ds4_awvalid_int	(ds4_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV5_SUPPORT
	.ds5_arvalid_int	(ds5_arvalids_int),
	.ds5_awvalid_int	(ds5_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV6_SUPPORT
	.ds6_arvalid_int	(ds6_arvalids_int),
	.ds6_awvalid_int	(ds6_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV7_SUPPORT
	.ds7_arvalid_int	(ds7_arvalids_int),
	.ds7_awvalid_int	(ds7_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV8_SUPPORT
	.ds8_arvalid_int	(ds8_arvalids_int),
	.ds8_awvalid_int	(ds8_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV9_SUPPORT
	.ds9_arvalid_int	(ds9_arvalids_int),
	.ds9_awvalid_int	(ds9_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV10_SUPPORT
	.ds10_arvalid_int	(ds10_arvalids_int),
	.ds10_awvalid_int	(ds10_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV11_SUPPORT
	.ds11_arvalid_int	(ds11_arvalids_int),
	.ds11_awvalid_int	(ds11_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV12_SUPPORT
	.ds12_arvalid_int	(ds12_arvalids_int),
	.ds12_awvalid_int	(ds12_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV13_SUPPORT
	.ds13_arvalid_int	(ds13_arvalids_int),
	.ds13_awvalid_int	(ds13_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV14_SUPPORT
	.ds14_arvalid_int	(ds14_arvalids_int),
	.ds14_awvalid_int	(ds14_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV15_SUPPORT
	.ds15_arvalid_int	(ds15_arvalids_int),
	.ds15_awvalid_int	(ds15_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV16_SUPPORT
	.ds16_arvalid_int	(ds16_arvalids_int),
	.ds16_awvalid_int	(ds16_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV17_SUPPORT
	.ds17_arvalid_int	(ds17_arvalids_int),
	.ds17_awvalid_int	(ds17_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV18_SUPPORT
	.ds18_arvalid_int	(ds18_arvalids_int),
	.ds18_awvalid_int	(ds18_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV19_SUPPORT
	.ds19_arvalid_int	(ds19_arvalids_int),
	.ds19_awvalid_int	(ds19_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV20_SUPPORT
	.ds20_arvalid_int	(ds20_arvalids_int),
	.ds20_awvalid_int	(ds20_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV21_SUPPORT
	.ds21_arvalid_int	(ds21_arvalids_int),
	.ds21_awvalid_int	(ds21_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV22_SUPPORT
	.ds22_arvalid_int	(ds22_arvalids_int),
	.ds22_awvalid_int	(ds22_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV23_SUPPORT
	.ds23_arvalid_int	(ds23_arvalids_int),
	.ds23_awvalid_int	(ds23_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV24_SUPPORT
	.ds24_arvalid_int	(ds24_arvalids_int),
	.ds24_awvalid_int	(ds24_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV25_SUPPORT
	.ds25_arvalid_int	(ds25_arvalids_int),
	.ds25_awvalid_int	(ds25_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV26_SUPPORT
	.ds26_arvalid_int	(ds26_arvalids_int),
	.ds26_awvalid_int	(ds26_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV27_SUPPORT
	.ds27_arvalid_int	(ds27_arvalids_int),
	.ds27_awvalid_int	(ds27_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV28_SUPPORT
	.ds28_arvalid_int	(ds28_arvalids_int),
	.ds28_awvalid_int	(ds28_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV29_SUPPORT
	.ds29_arvalid_int	(ds29_arvalids_int),
	.ds29_awvalid_int	(ds29_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV30_SUPPORT
	.ds30_arvalid_int	(ds30_arvalids_int),
	.ds30_awvalid_int	(ds30_awvalids_int),
	`endif
	`ifdef ATCBMC300_SLV31_SUPPORT
	.ds31_arvalid_int	(ds31_arvalids_int),
	.ds31_awvalid_int	(ds31_awvalids_int),
	`endif
	// VPERL_GENERATED_END
	.slv_bases		(slv_bases),
	.slv_eff_sizes		(slv_eff_sizes)
);

// VPERL_BEGIN
// foreach $x (0 .. 15) {
// : `ifdef ATCBMC300_MST${x}_SUPPORT
// : us${x}_arready_check: assert property (@(posedge aclk) us${x}_arready == us${x}_arreadys_int);
// : us${x}_awready_check: assert property (@(posedge aclk) us${x}_awready == us${x}_awreadys_int);
// : `endif
// }
// foreach $y (1 .. 31) {
// : `ifdef ATCBMC300_SLV${y}_SUPPORT
// : ds${y}_arready_check: assert property (@(posedge aclk) ds${y}_arvalid == ds${y}_arvalids_int);
// : ds${y}_awready_check: assert property (@(posedge aclk) ds${y}_awvalid == ds${y}_awvalids_int);
// : `endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
us0_arready_check: assert property (@(posedge aclk) us0_arready == us0_arreadys_int);
us0_awready_check: assert property (@(posedge aclk) us0_awready == us0_awreadys_int);
`endif
`ifdef ATCBMC300_MST1_SUPPORT
us1_arready_check: assert property (@(posedge aclk) us1_arready == us1_arreadys_int);
us1_awready_check: assert property (@(posedge aclk) us1_awready == us1_awreadys_int);
`endif
`ifdef ATCBMC300_MST2_SUPPORT
us2_arready_check: assert property (@(posedge aclk) us2_arready == us2_arreadys_int);
us2_awready_check: assert property (@(posedge aclk) us2_awready == us2_awreadys_int);
`endif
`ifdef ATCBMC300_MST3_SUPPORT
us3_arready_check: assert property (@(posedge aclk) us3_arready == us3_arreadys_int);
us3_awready_check: assert property (@(posedge aclk) us3_awready == us3_awreadys_int);
`endif
`ifdef ATCBMC300_MST4_SUPPORT
us4_arready_check: assert property (@(posedge aclk) us4_arready == us4_arreadys_int);
us4_awready_check: assert property (@(posedge aclk) us4_awready == us4_awreadys_int);
`endif
`ifdef ATCBMC300_MST5_SUPPORT
us5_arready_check: assert property (@(posedge aclk) us5_arready == us5_arreadys_int);
us5_awready_check: assert property (@(posedge aclk) us5_awready == us5_awreadys_int);
`endif
`ifdef ATCBMC300_MST6_SUPPORT
us6_arready_check: assert property (@(posedge aclk) us6_arready == us6_arreadys_int);
us6_awready_check: assert property (@(posedge aclk) us6_awready == us6_awreadys_int);
`endif
`ifdef ATCBMC300_MST7_SUPPORT
us7_arready_check: assert property (@(posedge aclk) us7_arready == us7_arreadys_int);
us7_awready_check: assert property (@(posedge aclk) us7_awready == us7_awreadys_int);
`endif
`ifdef ATCBMC300_MST8_SUPPORT
us8_arready_check: assert property (@(posedge aclk) us8_arready == us8_arreadys_int);
us8_awready_check: assert property (@(posedge aclk) us8_awready == us8_awreadys_int);
`endif
`ifdef ATCBMC300_MST9_SUPPORT
us9_arready_check: assert property (@(posedge aclk) us9_arready == us9_arreadys_int);
us9_awready_check: assert property (@(posedge aclk) us9_awready == us9_awreadys_int);
`endif
`ifdef ATCBMC300_MST10_SUPPORT
us10_arready_check: assert property (@(posedge aclk) us10_arready == us10_arreadys_int);
us10_awready_check: assert property (@(posedge aclk) us10_awready == us10_awreadys_int);
`endif
`ifdef ATCBMC300_MST11_SUPPORT
us11_arready_check: assert property (@(posedge aclk) us11_arready == us11_arreadys_int);
us11_awready_check: assert property (@(posedge aclk) us11_awready == us11_awreadys_int);
`endif
`ifdef ATCBMC300_MST12_SUPPORT
us12_arready_check: assert property (@(posedge aclk) us12_arready == us12_arreadys_int);
us12_awready_check: assert property (@(posedge aclk) us12_awready == us12_awreadys_int);
`endif
`ifdef ATCBMC300_MST13_SUPPORT
us13_arready_check: assert property (@(posedge aclk) us13_arready == us13_arreadys_int);
us13_awready_check: assert property (@(posedge aclk) us13_awready == us13_awreadys_int);
`endif
`ifdef ATCBMC300_MST14_SUPPORT
us14_arready_check: assert property (@(posedge aclk) us14_arready == us14_arreadys_int);
us14_awready_check: assert property (@(posedge aclk) us14_awready == us14_awreadys_int);
`endif
`ifdef ATCBMC300_MST15_SUPPORT
us15_arready_check: assert property (@(posedge aclk) us15_arready == us15_arreadys_int);
us15_awready_check: assert property (@(posedge aclk) us15_awready == us15_awreadys_int);
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
ds1_arready_check: assert property (@(posedge aclk) ds1_arvalid == ds1_arvalids_int);
ds1_awready_check: assert property (@(posedge aclk) ds1_awvalid == ds1_awvalids_int);
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
ds2_arready_check: assert property (@(posedge aclk) ds2_arvalid == ds2_arvalids_int);
ds2_awready_check: assert property (@(posedge aclk) ds2_awvalid == ds2_awvalids_int);
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
ds3_arready_check: assert property (@(posedge aclk) ds3_arvalid == ds3_arvalids_int);
ds3_awready_check: assert property (@(posedge aclk) ds3_awvalid == ds3_awvalids_int);
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
ds4_arready_check: assert property (@(posedge aclk) ds4_arvalid == ds4_arvalids_int);
ds4_awready_check: assert property (@(posedge aclk) ds4_awvalid == ds4_awvalids_int);
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
ds5_arready_check: assert property (@(posedge aclk) ds5_arvalid == ds5_arvalids_int);
ds5_awready_check: assert property (@(posedge aclk) ds5_awvalid == ds5_awvalids_int);
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
ds6_arready_check: assert property (@(posedge aclk) ds6_arvalid == ds6_arvalids_int);
ds6_awready_check: assert property (@(posedge aclk) ds6_awvalid == ds6_awvalids_int);
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
ds7_arready_check: assert property (@(posedge aclk) ds7_arvalid == ds7_arvalids_int);
ds7_awready_check: assert property (@(posedge aclk) ds7_awvalid == ds7_awvalids_int);
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
ds8_arready_check: assert property (@(posedge aclk) ds8_arvalid == ds8_arvalids_int);
ds8_awready_check: assert property (@(posedge aclk) ds8_awvalid == ds8_awvalids_int);
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
ds9_arready_check: assert property (@(posedge aclk) ds9_arvalid == ds9_arvalids_int);
ds9_awready_check: assert property (@(posedge aclk) ds9_awvalid == ds9_awvalids_int);
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
ds10_arready_check: assert property (@(posedge aclk) ds10_arvalid == ds10_arvalids_int);
ds10_awready_check: assert property (@(posedge aclk) ds10_awvalid == ds10_awvalids_int);
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
ds11_arready_check: assert property (@(posedge aclk) ds11_arvalid == ds11_arvalids_int);
ds11_awready_check: assert property (@(posedge aclk) ds11_awvalid == ds11_awvalids_int);
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
ds12_arready_check: assert property (@(posedge aclk) ds12_arvalid == ds12_arvalids_int);
ds12_awready_check: assert property (@(posedge aclk) ds12_awvalid == ds12_awvalids_int);
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
ds13_arready_check: assert property (@(posedge aclk) ds13_arvalid == ds13_arvalids_int);
ds13_awready_check: assert property (@(posedge aclk) ds13_awvalid == ds13_awvalids_int);
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
ds14_arready_check: assert property (@(posedge aclk) ds14_arvalid == ds14_arvalids_int);
ds14_awready_check: assert property (@(posedge aclk) ds14_awvalid == ds14_awvalids_int);
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
ds15_arready_check: assert property (@(posedge aclk) ds15_arvalid == ds15_arvalids_int);
ds15_awready_check: assert property (@(posedge aclk) ds15_awvalid == ds15_awvalids_int);
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
ds16_arready_check: assert property (@(posedge aclk) ds16_arvalid == ds16_arvalids_int);
ds16_awready_check: assert property (@(posedge aclk) ds16_awvalid == ds16_awvalids_int);
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
ds17_arready_check: assert property (@(posedge aclk) ds17_arvalid == ds17_arvalids_int);
ds17_awready_check: assert property (@(posedge aclk) ds17_awvalid == ds17_awvalids_int);
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
ds18_arready_check: assert property (@(posedge aclk) ds18_arvalid == ds18_arvalids_int);
ds18_awready_check: assert property (@(posedge aclk) ds18_awvalid == ds18_awvalids_int);
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
ds19_arready_check: assert property (@(posedge aclk) ds19_arvalid == ds19_arvalids_int);
ds19_awready_check: assert property (@(posedge aclk) ds19_awvalid == ds19_awvalids_int);
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
ds20_arready_check: assert property (@(posedge aclk) ds20_arvalid == ds20_arvalids_int);
ds20_awready_check: assert property (@(posedge aclk) ds20_awvalid == ds20_awvalids_int);
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
ds21_arready_check: assert property (@(posedge aclk) ds21_arvalid == ds21_arvalids_int);
ds21_awready_check: assert property (@(posedge aclk) ds21_awvalid == ds21_awvalids_int);
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
ds22_arready_check: assert property (@(posedge aclk) ds22_arvalid == ds22_arvalids_int);
ds22_awready_check: assert property (@(posedge aclk) ds22_awvalid == ds22_awvalids_int);
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
ds23_arready_check: assert property (@(posedge aclk) ds23_arvalid == ds23_arvalids_int);
ds23_awready_check: assert property (@(posedge aclk) ds23_awvalid == ds23_awvalids_int);
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
ds24_arready_check: assert property (@(posedge aclk) ds24_arvalid == ds24_arvalids_int);
ds24_awready_check: assert property (@(posedge aclk) ds24_awvalid == ds24_awvalids_int);
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
ds25_arready_check: assert property (@(posedge aclk) ds25_arvalid == ds25_arvalids_int);
ds25_awready_check: assert property (@(posedge aclk) ds25_awvalid == ds25_awvalids_int);
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
ds26_arready_check: assert property (@(posedge aclk) ds26_arvalid == ds26_arvalids_int);
ds26_awready_check: assert property (@(posedge aclk) ds26_awvalid == ds26_awvalids_int);
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
ds27_arready_check: assert property (@(posedge aclk) ds27_arvalid == ds27_arvalids_int);
ds27_awready_check: assert property (@(posedge aclk) ds27_awvalid == ds27_awvalids_int);
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
ds28_arready_check: assert property (@(posedge aclk) ds28_arvalid == ds28_arvalids_int);
ds28_awready_check: assert property (@(posedge aclk) ds28_awvalid == ds28_awvalids_int);
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
ds29_arready_check: assert property (@(posedge aclk) ds29_arvalid == ds29_arvalids_int);
ds29_awready_check: assert property (@(posedge aclk) ds29_awvalid == ds29_awvalids_int);
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
ds30_arready_check: assert property (@(posedge aclk) ds30_arvalid == ds30_arvalids_int);
ds30_awready_check: assert property (@(posedge aclk) ds30_awvalid == ds30_awvalids_int);
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
ds31_arready_check: assert property (@(posedge aclk) ds31_arvalid == ds31_arvalids_int);
ds31_awready_check: assert property (@(posedge aclk) ds31_awvalid == ds31_awvalids_int);
`endif
// VPERL_GENERATED_END
`endif	// !NDS_NO_PBMC


`ifdef NDS_PERFORMANCE_TEST
prfm_checker #(.ADDR_WIDTH(ADDR_WIDTH), .DS_ID_WIDTH(DS_ID_WIDTH)) prfm_checker(.*);
`endif

// ===============
// monitor/dump
// ===============
blk_dump blk_dump();

// ===============
// Misc
// ===============

// common task to wait reset  
task wait_reset_done; 
begin
        wait (aresetn);
end
endtask

// ===============
// user define pattern
// ===============
`ifdef NDS_TB_PAT
	`include "nds_tb.pat"
`endif

endmodule

// vim: set textwidth=0 :
