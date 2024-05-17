`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

module atcbmc300_internal_slave (
// VPERL: &PORTLIST;
// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
	  mst0_awid,
	  mst0_awaddr,
	  mst0_awlen,
	  mst0_awsize,
	  mst0_awburst,
	  mst0_awvalid,
	  mst0_wvalid,
	  mst0_wsid,
	  mst0_wlast,
	  mst0_wdata,
	  mst0_wstrb,
	  mst0_bready,
	  mst0_bsid,
	  mst0_connect,
	  mst0_arid,
	  mst0_araddr,
	  mst0_arlen,
	  mst0_arsize,
	  mst0_arburst,
	  mst0_arvalid,
	  mst0_rready,
	  mst0_rsid,
`endif // ATCBMC300_MST0_SUPPORT
`ifdef ATCBMC300_MST1_SUPPORT
	  mst1_awid,
	  mst1_awaddr,
	  mst1_awlen,
	  mst1_awsize,
	  mst1_awburst,
	  mst1_awvalid,
	  mst1_wvalid,
	  mst1_wsid,
	  mst1_wlast,
	  mst1_wdata,
	  mst1_wstrb,
	  mst1_bready,
	  mst1_bsid,
	  mst1_connect,
	  mst1_arid,
	  mst1_araddr,
	  mst1_arlen,
	  mst1_arsize,
	  mst1_arburst,
	  mst1_arvalid,
	  mst1_rready,
	  mst1_rsid,
`endif // ATCBMC300_MST1_SUPPORT
`ifdef ATCBMC300_MST2_SUPPORT
	  mst2_awid,
	  mst2_awaddr,
	  mst2_awlen,
	  mst2_awsize,
	  mst2_awburst,
	  mst2_awvalid,
	  mst2_wvalid,
	  mst2_wsid,
	  mst2_wlast,
	  mst2_wdata,
	  mst2_wstrb,
	  mst2_bready,
	  mst2_bsid,
	  mst2_connect,
	  mst2_arid,
	  mst2_araddr,
	  mst2_arlen,
	  mst2_arsize,
	  mst2_arburst,
	  mst2_arvalid,
	  mst2_rready,
	  mst2_rsid,
`endif // ATCBMC300_MST2_SUPPORT
`ifdef ATCBMC300_MST3_SUPPORT
	  mst3_awid,
	  mst3_awaddr,
	  mst3_awlen,
	  mst3_awsize,
	  mst3_awburst,
	  mst3_awvalid,
	  mst3_wvalid,
	  mst3_wsid,
	  mst3_wlast,
	  mst3_wdata,
	  mst3_wstrb,
	  mst3_bready,
	  mst3_bsid,
	  mst3_connect,
	  mst3_arid,
	  mst3_araddr,
	  mst3_arlen,
	  mst3_arsize,
	  mst3_arburst,
	  mst3_arvalid,
	  mst3_rready,
	  mst3_rsid,
`endif // ATCBMC300_MST3_SUPPORT
`ifdef ATCBMC300_MST4_SUPPORT
	  mst4_awid,
	  mst4_awaddr,
	  mst4_awlen,
	  mst4_awsize,
	  mst4_awburst,
	  mst4_awvalid,
	  mst4_wvalid,
	  mst4_wsid,
	  mst4_wlast,
	  mst4_wdata,
	  mst4_wstrb,
	  mst4_bready,
	  mst4_bsid,
	  mst4_connect,
	  mst4_arid,
	  mst4_araddr,
	  mst4_arlen,
	  mst4_arsize,
	  mst4_arburst,
	  mst4_arvalid,
	  mst4_rready,
	  mst4_rsid,
`endif // ATCBMC300_MST4_SUPPORT
`ifdef ATCBMC300_MST5_SUPPORT
	  mst5_awid,
	  mst5_awaddr,
	  mst5_awlen,
	  mst5_awsize,
	  mst5_awburst,
	  mst5_awvalid,
	  mst5_wvalid,
	  mst5_wsid,
	  mst5_wlast,
	  mst5_wdata,
	  mst5_wstrb,
	  mst5_bready,
	  mst5_bsid,
	  mst5_connect,
	  mst5_arid,
	  mst5_araddr,
	  mst5_arlen,
	  mst5_arsize,
	  mst5_arburst,
	  mst5_arvalid,
	  mst5_rready,
	  mst5_rsid,
`endif // ATCBMC300_MST5_SUPPORT
`ifdef ATCBMC300_MST6_SUPPORT
	  mst6_awid,
	  mst6_awaddr,
	  mst6_awlen,
	  mst6_awsize,
	  mst6_awburst,
	  mst6_awvalid,
	  mst6_wvalid,
	  mst6_wsid,
	  mst6_wlast,
	  mst6_wdata,
	  mst6_wstrb,
	  mst6_bready,
	  mst6_bsid,
	  mst6_connect,
	  mst6_arid,
	  mst6_araddr,
	  mst6_arlen,
	  mst6_arsize,
	  mst6_arburst,
	  mst6_arvalid,
	  mst6_rready,
	  mst6_rsid,
`endif // ATCBMC300_MST6_SUPPORT
`ifdef ATCBMC300_MST7_SUPPORT
	  mst7_awid,
	  mst7_awaddr,
	  mst7_awlen,
	  mst7_awsize,
	  mst7_awburst,
	  mst7_awvalid,
	  mst7_wvalid,
	  mst7_wsid,
	  mst7_wlast,
	  mst7_wdata,
	  mst7_wstrb,
	  mst7_bready,
	  mst7_bsid,
	  mst7_connect,
	  mst7_arid,
	  mst7_araddr,
	  mst7_arlen,
	  mst7_arsize,
	  mst7_arburst,
	  mst7_arvalid,
	  mst7_rready,
	  mst7_rsid,
`endif // ATCBMC300_MST7_SUPPORT
`ifdef ATCBMC300_MST8_SUPPORT
	  mst8_awid,
	  mst8_awaddr,
	  mst8_awlen,
	  mst8_awsize,
	  mst8_awburst,
	  mst8_awvalid,
	  mst8_wvalid,
	  mst8_wsid,
	  mst8_wlast,
	  mst8_wdata,
	  mst8_wstrb,
	  mst8_bready,
	  mst8_bsid,
	  mst8_connect,
	  mst8_arid,
	  mst8_araddr,
	  mst8_arlen,
	  mst8_arsize,
	  mst8_arburst,
	  mst8_arvalid,
	  mst8_rready,
	  mst8_rsid,
`endif // ATCBMC300_MST8_SUPPORT
`ifdef ATCBMC300_MST9_SUPPORT
	  mst9_awid,
	  mst9_awaddr,
	  mst9_awlen,
	  mst9_awsize,
	  mst9_awburst,
	  mst9_awvalid,
	  mst9_wvalid,
	  mst9_wsid,
	  mst9_wlast,
	  mst9_wdata,
	  mst9_wstrb,
	  mst9_bready,
	  mst9_bsid,
	  mst9_connect,
	  mst9_arid,
	  mst9_araddr,
	  mst9_arlen,
	  mst9_arsize,
	  mst9_arburst,
	  mst9_arvalid,
	  mst9_rready,
	  mst9_rsid,
`endif // ATCBMC300_MST9_SUPPORT
`ifdef ATCBMC300_MST10_SUPPORT
	  mst10_awid,
	  mst10_awaddr,
	  mst10_awlen,
	  mst10_awsize,
	  mst10_awburst,
	  mst10_awvalid,
	  mst10_wvalid,
	  mst10_wsid,
	  mst10_wlast,
	  mst10_wdata,
	  mst10_wstrb,
	  mst10_bready,
	  mst10_bsid,
	  mst10_connect,
	  mst10_arid,
	  mst10_araddr,
	  mst10_arlen,
	  mst10_arsize,
	  mst10_arburst,
	  mst10_arvalid,
	  mst10_rready,
	  mst10_rsid,
`endif // ATCBMC300_MST10_SUPPORT
`ifdef ATCBMC300_MST11_SUPPORT
	  mst11_awid,
	  mst11_awaddr,
	  mst11_awlen,
	  mst11_awsize,
	  mst11_awburst,
	  mst11_awvalid,
	  mst11_wvalid,
	  mst11_wsid,
	  mst11_wlast,
	  mst11_wdata,
	  mst11_wstrb,
	  mst11_bready,
	  mst11_bsid,
	  mst11_connect,
	  mst11_arid,
	  mst11_araddr,
	  mst11_arlen,
	  mst11_arsize,
	  mst11_arburst,
	  mst11_arvalid,
	  mst11_rready,
	  mst11_rsid,
`endif // ATCBMC300_MST11_SUPPORT
`ifdef ATCBMC300_MST12_SUPPORT
	  mst12_awid,
	  mst12_awaddr,
	  mst12_awlen,
	  mst12_awsize,
	  mst12_awburst,
	  mst12_awvalid,
	  mst12_wvalid,
	  mst12_wsid,
	  mst12_wlast,
	  mst12_wdata,
	  mst12_wstrb,
	  mst12_bready,
	  mst12_bsid,
	  mst12_connect,
	  mst12_arid,
	  mst12_araddr,
	  mst12_arlen,
	  mst12_arsize,
	  mst12_arburst,
	  mst12_arvalid,
	  mst12_rready,
	  mst12_rsid,
`endif // ATCBMC300_MST12_SUPPORT
`ifdef ATCBMC300_MST13_SUPPORT
	  mst13_awid,
	  mst13_awaddr,
	  mst13_awlen,
	  mst13_awsize,
	  mst13_awburst,
	  mst13_awvalid,
	  mst13_wvalid,
	  mst13_wsid,
	  mst13_wlast,
	  mst13_wdata,
	  mst13_wstrb,
	  mst13_bready,
	  mst13_bsid,
	  mst13_connect,
	  mst13_arid,
	  mst13_araddr,
	  mst13_arlen,
	  mst13_arsize,
	  mst13_arburst,
	  mst13_arvalid,
	  mst13_rready,
	  mst13_rsid,
`endif // ATCBMC300_MST13_SUPPORT
`ifdef ATCBMC300_MST14_SUPPORT
	  mst14_awid,
	  mst14_awaddr,
	  mst14_awlen,
	  mst14_awsize,
	  mst14_awburst,
	  mst14_awvalid,
	  mst14_wvalid,
	  mst14_wsid,
	  mst14_wlast,
	  mst14_wdata,
	  mst14_wstrb,
	  mst14_bready,
	  mst14_bsid,
	  mst14_connect,
	  mst14_arid,
	  mst14_araddr,
	  mst14_arlen,
	  mst14_arsize,
	  mst14_arburst,
	  mst14_arvalid,
	  mst14_rready,
	  mst14_rsid,
`endif // ATCBMC300_MST14_SUPPORT
`ifdef ATCBMC300_MST15_SUPPORT
	  mst15_awid,
	  mst15_awaddr,
	  mst15_awlen,
	  mst15_awsize,
	  mst15_awburst,
	  mst15_awvalid,
	  mst15_wvalid,
	  mst15_wsid,
	  mst15_wlast,
	  mst15_wdata,
	  mst15_wstrb,
	  mst15_bready,
	  mst15_bsid,
	  mst15_connect,
	  mst15_arid,
	  mst15_araddr,
	  mst15_arlen,
	  mst15_arsize,
	  mst15_arburst,
	  mst15_arvalid,
	  mst15_rready,
	  mst15_rsid,
`endif // ATCBMC300_MST15_SUPPORT
`ifdef ATCBMC300_SLV0_SUPPORT
	  slv0_base_addr,
`endif // ATCBMC300_SLV0_SUPPORT
`ifdef ATCBMC300_SLV1_SUPPORT
	  slv1_base_addr,
`endif // ATCBMC300_SLV1_SUPPORT
`ifdef ATCBMC300_SLV2_SUPPORT
	  slv2_base_addr,
`endif // ATCBMC300_SLV2_SUPPORT
`ifdef ATCBMC300_SLV3_SUPPORT
	  slv3_base_addr,
`endif // ATCBMC300_SLV3_SUPPORT
`ifdef ATCBMC300_SLV4_SUPPORT
	  slv4_base_addr,
`endif // ATCBMC300_SLV4_SUPPORT
`ifdef ATCBMC300_SLV5_SUPPORT
	  slv5_base_addr,
`endif // ATCBMC300_SLV5_SUPPORT
`ifdef ATCBMC300_SLV6_SUPPORT
	  slv6_base_addr,
`endif // ATCBMC300_SLV6_SUPPORT
`ifdef ATCBMC300_SLV7_SUPPORT
	  slv7_base_addr,
`endif // ATCBMC300_SLV7_SUPPORT
`ifdef ATCBMC300_SLV8_SUPPORT
	  slv8_base_addr,
`endif // ATCBMC300_SLV8_SUPPORT
`ifdef ATCBMC300_SLV9_SUPPORT
	  slv9_base_addr,
`endif // ATCBMC300_SLV9_SUPPORT
`ifdef ATCBMC300_SLV10_SUPPORT
	  slv10_base_addr,
`endif // ATCBMC300_SLV10_SUPPORT
`ifdef ATCBMC300_SLV11_SUPPORT
	  slv11_base_addr,
`endif // ATCBMC300_SLV11_SUPPORT
`ifdef ATCBMC300_SLV12_SUPPORT
	  slv12_base_addr,
`endif // ATCBMC300_SLV12_SUPPORT
`ifdef ATCBMC300_SLV13_SUPPORT
	  slv13_base_addr,
`endif // ATCBMC300_SLV13_SUPPORT
`ifdef ATCBMC300_SLV14_SUPPORT
	  slv14_base_addr,
`endif // ATCBMC300_SLV14_SUPPORT
`ifdef ATCBMC300_SLV15_SUPPORT
	  slv15_base_addr,
`endif // ATCBMC300_SLV15_SUPPORT
`ifdef ATCBMC300_SLV16_SUPPORT
	  slv16_base_addr,
`endif // ATCBMC300_SLV16_SUPPORT
`ifdef ATCBMC300_SLV17_SUPPORT
	  slv17_base_addr,
`endif // ATCBMC300_SLV17_SUPPORT
`ifdef ATCBMC300_SLV18_SUPPORT
	  slv18_base_addr,
`endif // ATCBMC300_SLV18_SUPPORT
`ifdef ATCBMC300_SLV19_SUPPORT
	  slv19_base_addr,
`endif // ATCBMC300_SLV19_SUPPORT
`ifdef ATCBMC300_SLV20_SUPPORT
	  slv20_base_addr,
`endif // ATCBMC300_SLV20_SUPPORT
`ifdef ATCBMC300_SLV21_SUPPORT
	  slv21_base_addr,
`endif // ATCBMC300_SLV21_SUPPORT
`ifdef ATCBMC300_SLV22_SUPPORT
	  slv22_base_addr,
`endif // ATCBMC300_SLV22_SUPPORT
`ifdef ATCBMC300_SLV23_SUPPORT
	  slv23_base_addr,
`endif // ATCBMC300_SLV23_SUPPORT
`ifdef ATCBMC300_SLV24_SUPPORT
	  slv24_base_addr,
`endif // ATCBMC300_SLV24_SUPPORT
`ifdef ATCBMC300_SLV25_SUPPORT
	  slv25_base_addr,
`endif // ATCBMC300_SLV25_SUPPORT
`ifdef ATCBMC300_SLV26_SUPPORT
	  slv26_base_addr,
`endif // ATCBMC300_SLV26_SUPPORT
`ifdef ATCBMC300_SLV27_SUPPORT
	  slv27_base_addr,
`endif // ATCBMC300_SLV27_SUPPORT
`ifdef ATCBMC300_SLV28_SUPPORT
	  slv28_base_addr,
`endif // ATCBMC300_SLV28_SUPPORT
`ifdef ATCBMC300_SLV29_SUPPORT
	  slv29_base_addr,
`endif // ATCBMC300_SLV29_SUPPORT
`ifdef ATCBMC300_SLV30_SUPPORT
	  slv30_base_addr,
`endif // ATCBMC300_SLV30_SUPPORT
`ifdef ATCBMC300_SLV31_SUPPORT
	  slv31_base_addr,
`endif // ATCBMC300_SLV31_SUPPORT
	  slv0_rid, 
	  slv0_read_data,
	  slv0_rvalid,
	  slv0_bid, 
	  slv0_bresp,
	  slv0_bvalid,
	  slv0_wready,
	  slv0_wmid,
	  slv0_arready,
	  slv0_awready,
	  slv0_ar_mid,
	  slv0_aw_mid,
	  reg_mst0_high_priority,
	  reg_priority_reload,
	  aclk,     
	  aresetn   
// VPERL_GENERATED_END
);
parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 64;
parameter ID_WIDTH   = 4;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB   = ID_WIDTH - 1;

localparam SELF_ID = 5'h0;
localparam MULTIPLE_WR_DATA = 256/DATA_WIDTH; 
// #VPERL_BEGIN
//  for ($i=0;$i<16;$i++) {
// :`ifdef ATCBMC300_MST${i}_SUPPORT
// : input [ID_MSB:0]   		mst${i}_awid;       
// : input [19:0]	 		mst${i}_awaddr;
// : input [3:0]        		mst${i}_awlen;
// : input [2:0]        		mst${i}_awsize;
// : input [1:0]        		mst${i}_awburst;
// : input 	        		mst${i}_awvalid;
// : input              		mst${i}_wvalid;
// : input [4:0]                	mst${i}_wsid;
// : input              		mst${i}_wlast;
// : input [DATA_MSB:0]         	mst${i}_wdata;
// : input [(DATA_WIDTH/8)-1:0] 	mst${i}_wstrb;
// : input				mst${i}_bready;
// : input [4:0]                	mst${i}_bsid;
// : input 			    	mst${i}_connect;
// #: input 				rst_mst${i}_priority_reload;
// :
// : input [ID_MSB:0]   		mst${i}_arid;       
// : input [ADDR_MSB:0] 		mst${i}_araddr;
// : input [7:0]        		mst${i}_arlen;
// : input [2:0]        		mst${i}_arsize;
// : input [1:0]        		mst${i}_arburst;
// : input 	        		mst${i}_arvalid;
// : input				mst${i}_rready;
// : input [4:0]                	mst${i}_rsid;
// : `endif
// }
//  for ($i=0;$i<32;$i++) {
// :`ifdef ATCBMC300_SLV${i}_SUPPORT
// : input [63:20]	slv${i}_base_addr;
// :`endif
// }
// #VPERL_END

// #VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
input [ID_MSB:0]   		mst0_awid;
input [19:0] 			mst0_awaddr;
input [3:0]        		mst0_awlen;
input [2:0]        		mst0_awsize;
input [1:0]        		mst0_awburst;
input 	        		mst0_awvalid;
input              		mst0_wvalid;
input [4:0]                	mst0_wsid;
input              		mst0_wlast;
input [DATA_MSB:0]         	mst0_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst0_wstrb;
input				mst0_bready;
input [4:0]                	mst0_bsid;
input 			    	mst0_connect;

input [ID_MSB:0]   		mst0_arid;
input [ADDR_MSB:0] 		mst0_araddr;
input [7:0]        		mst0_arlen;
input [2:0]        		mst0_arsize;
input [1:0]        		mst0_arburst;
input 	        		mst0_arvalid;
input				mst0_rready;
input [4:0]                	mst0_rsid;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
input [ID_MSB:0]   		mst1_awid;
input [19:0] 			mst1_awaddr;
input [3:0]        		mst1_awlen;
input [2:0]        		mst1_awsize;
input [1:0]        		mst1_awburst;
input 	        		mst1_awvalid;
input              		mst1_wvalid;
input [4:0]                	mst1_wsid;
input              		mst1_wlast;
input [DATA_MSB:0]         	mst1_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst1_wstrb;
input				mst1_bready;
input [4:0]                	mst1_bsid;
input 			    	mst1_connect;

input [ID_MSB:0]   		mst1_arid;
input [ADDR_MSB:0] 		mst1_araddr;
input [7:0]        		mst1_arlen;
input [2:0]        		mst1_arsize;
input [1:0]        		mst1_arburst;
input 	        		mst1_arvalid;
input				mst1_rready;
input [4:0]                	mst1_rsid;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
input [ID_MSB:0]   		mst2_awid;
input [19:0] 			mst2_awaddr;
input [3:0]        		mst2_awlen;
input [2:0]        		mst2_awsize;
input [1:0]        		mst2_awburst;
input 	        		mst2_awvalid;
input              		mst2_wvalid;
input [4:0]                	mst2_wsid;
input              		mst2_wlast;
input [DATA_MSB:0]         	mst2_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst2_wstrb;
input				mst2_bready;
input [4:0]                	mst2_bsid;
input 			    	mst2_connect;

input [ID_MSB:0]   		mst2_arid;
input [ADDR_MSB:0] 		mst2_araddr;
input [7:0]        		mst2_arlen;
input [2:0]        		mst2_arsize;
input [1:0]        		mst2_arburst;
input 	        		mst2_arvalid;
input				mst2_rready;
input [4:0]                	mst2_rsid;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
input [ID_MSB:0]   		mst3_awid;
input [19:0] 			mst3_awaddr;
input [3:0]        		mst3_awlen;
input [2:0]        		mst3_awsize;
input [1:0]        		mst3_awburst;
input 	        		mst3_awvalid;
input              		mst3_wvalid;
input [4:0]                	mst3_wsid;
input              		mst3_wlast;
input [DATA_MSB:0]         	mst3_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst3_wstrb;
input				mst3_bready;
input [4:0]                	mst3_bsid;
input 			    	mst3_connect;

input [ID_MSB:0]   		mst3_arid;
input [ADDR_MSB:0] 		mst3_araddr;
input [7:0]        		mst3_arlen;
input [2:0]        		mst3_arsize;
input [1:0]        		mst3_arburst;
input 	        		mst3_arvalid;
input				mst3_rready;
input [4:0]                	mst3_rsid;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
input [ID_MSB:0]   		mst4_awid;
input [19:0] 			mst4_awaddr;
input [3:0]        		mst4_awlen;
input [2:0]        		mst4_awsize;
input [1:0]        		mst4_awburst;
input 	        		mst4_awvalid;
input              		mst4_wvalid;
input [4:0]                	mst4_wsid;
input              		mst4_wlast;
input [DATA_MSB:0]         	mst4_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst4_wstrb;
input				mst4_bready;
input [4:0]                	mst4_bsid;
input 			    	mst4_connect;

input [ID_MSB:0]   		mst4_arid;
input [ADDR_MSB:0] 		mst4_araddr;
input [7:0]        		mst4_arlen;
input [2:0]        		mst4_arsize;
input [1:0]        		mst4_arburst;
input 	        		mst4_arvalid;
input				mst4_rready;
input [4:0]                	mst4_rsid;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
input [ID_MSB:0]   		mst5_awid;
input [19:0] 			mst5_awaddr;
input [3:0]        		mst5_awlen;
input [2:0]        		mst5_awsize;
input [1:0]        		mst5_awburst;
input 	        		mst5_awvalid;
input              		mst5_wvalid;
input [4:0]                	mst5_wsid;
input              		mst5_wlast;
input [DATA_MSB:0]         	mst5_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst5_wstrb;
input				mst5_bready;
input [4:0]                	mst5_bsid;
input 			    	mst5_connect;

input [ID_MSB:0]   		mst5_arid;
input [ADDR_MSB:0] 		mst5_araddr;
input [7:0]        		mst5_arlen;
input [2:0]        		mst5_arsize;
input [1:0]        		mst5_arburst;
input 	        		mst5_arvalid;
input				mst5_rready;
input [4:0]                	mst5_rsid;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
input [ID_MSB:0]   		mst6_awid;
input [19:0] 			mst6_awaddr;
input [3:0]        		mst6_awlen;
input [2:0]        		mst6_awsize;
input [1:0]        		mst6_awburst;
input 	        		mst6_awvalid;
input              		mst6_wvalid;
input [4:0]                	mst6_wsid;
input              		mst6_wlast;
input [DATA_MSB:0]         	mst6_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst6_wstrb;
input				mst6_bready;
input [4:0]                	mst6_bsid;
input 			    	mst6_connect;

input [ID_MSB:0]   		mst6_arid;
input [ADDR_MSB:0] 		mst6_araddr;
input [7:0]        		mst6_arlen;
input [2:0]        		mst6_arsize;
input [1:0]        		mst6_arburst;
input 	        		mst6_arvalid;
input				mst6_rready;
input [4:0]                	mst6_rsid;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
input [ID_MSB:0]   		mst7_awid;
input [19:0] 			mst7_awaddr;
input [3:0]        		mst7_awlen;
input [2:0]        		mst7_awsize;
input [1:0]        		mst7_awburst;
input 	        		mst7_awvalid;
input              		mst7_wvalid;
input [4:0]                	mst7_wsid;
input              		mst7_wlast;
input [DATA_MSB:0]         	mst7_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst7_wstrb;
input				mst7_bready;
input [4:0]                	mst7_bsid;
input 			    	mst7_connect;

input [ID_MSB:0]   		mst7_arid;
input [ADDR_MSB:0] 		mst7_araddr;
input [7:0]        		mst7_arlen;
input [2:0]        		mst7_arsize;
input [1:0]        		mst7_arburst;
input 	        		mst7_arvalid;
input				mst7_rready;
input [4:0]                	mst7_rsid;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
input [ID_MSB:0]   		mst8_awid;
input [19:0] 			mst8_awaddr;
input [3:0]        		mst8_awlen;
input [2:0]        		mst8_awsize;
input [1:0]        		mst8_awburst;
input 	        		mst8_awvalid;
input              		mst8_wvalid;
input [4:0]                	mst8_wsid;
input              		mst8_wlast;
input [DATA_MSB:0]         	mst8_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst8_wstrb;
input				mst8_bready;
input [4:0]                	mst8_bsid;
input 			    	mst8_connect;

input [ID_MSB:0]   		mst8_arid;
input [ADDR_MSB:0] 		mst8_araddr;
input [7:0]        		mst8_arlen;
input [2:0]        		mst8_arsize;
input [1:0]        		mst8_arburst;
input 	        		mst8_arvalid;
input				mst8_rready;
input [4:0]                	mst8_rsid;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
input [ID_MSB:0]   		mst9_awid;
input [19:0] 			mst9_awaddr;
input [3:0]        		mst9_awlen;
input [2:0]        		mst9_awsize;
input [1:0]        		mst9_awburst;
input 	        		mst9_awvalid;
input              		mst9_wvalid;
input [4:0]                	mst9_wsid;
input              		mst9_wlast;
input [DATA_MSB:0]         	mst9_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst9_wstrb;
input				mst9_bready;
input [4:0]                	mst9_bsid;
input 			    	mst9_connect;

input [ID_MSB:0]   		mst9_arid;
input [ADDR_MSB:0] 		mst9_araddr;
input [7:0]        		mst9_arlen;
input [2:0]        		mst9_arsize;
input [1:0]        		mst9_arburst;
input 	        		mst9_arvalid;
input				mst9_rready;
input [4:0]                	mst9_rsid;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
input [ID_MSB:0]   		mst10_awid;
input [19:0] 			mst10_awaddr;
input [3:0]        		mst10_awlen;
input [2:0]        		mst10_awsize;
input [1:0]        		mst10_awburst;
input 	        		mst10_awvalid;
input              		mst10_wvalid;
input [4:0]                	mst10_wsid;
input              		mst10_wlast;
input [DATA_MSB:0]         	mst10_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst10_wstrb;
input				mst10_bready;
input [4:0]                	mst10_bsid;
input 			    	mst10_connect;

input [ID_MSB:0]   		mst10_arid;
input [ADDR_MSB:0] 		mst10_araddr;
input [7:0]        		mst10_arlen;
input [2:0]        		mst10_arsize;
input [1:0]        		mst10_arburst;
input 	        		mst10_arvalid;
input				mst10_rready;
input [4:0]                	mst10_rsid;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
input [ID_MSB:0]   		mst11_awid;
input [19:0] 			mst11_awaddr;
input [3:0]        		mst11_awlen;
input [2:0]        		mst11_awsize;
input [1:0]        		mst11_awburst;
input 	        		mst11_awvalid;
input              		mst11_wvalid;
input [4:0]                	mst11_wsid;
input              		mst11_wlast;
input [DATA_MSB:0]         	mst11_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst11_wstrb;
input				mst11_bready;
input [4:0]                	mst11_bsid;
input 			    	mst11_connect;

input [ID_MSB:0]   		mst11_arid;
input [ADDR_MSB:0] 		mst11_araddr;
input [7:0]        		mst11_arlen;
input [2:0]        		mst11_arsize;
input [1:0]        		mst11_arburst;
input 	        		mst11_arvalid;
input				mst11_rready;
input [4:0]                	mst11_rsid;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
input [ID_MSB:0]   		mst12_awid;
input [19:0] 			mst12_awaddr;
input [3:0]        		mst12_awlen;
input [2:0]        		mst12_awsize;
input [1:0]        		mst12_awburst;
input 	        		mst12_awvalid;
input              		mst12_wvalid;
input [4:0]                	mst12_wsid;
input              		mst12_wlast;
input [DATA_MSB:0]         	mst12_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst12_wstrb;
input				mst12_bready;
input [4:0]                	mst12_bsid;
input 			    	mst12_connect;

input [ID_MSB:0]   		mst12_arid;
input [ADDR_MSB:0] 		mst12_araddr;
input [7:0]        		mst12_arlen;
input [2:0]        		mst12_arsize;
input [1:0]        		mst12_arburst;
input 	        		mst12_arvalid;
input				mst12_rready;
input [4:0]                	mst12_rsid;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
input [ID_MSB:0]   		mst13_awid;
input [19:0] 			mst13_awaddr;
input [3:0]        		mst13_awlen;
input [2:0]        		mst13_awsize;
input [1:0]        		mst13_awburst;
input 	        		mst13_awvalid;
input              		mst13_wvalid;
input [4:0]                	mst13_wsid;
input              		mst13_wlast;
input [DATA_MSB:0]         	mst13_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst13_wstrb;
input				mst13_bready;
input [4:0]                	mst13_bsid;
input 			    	mst13_connect;

input [ID_MSB:0]   		mst13_arid;
input [ADDR_MSB:0] 		mst13_araddr;
input [7:0]        		mst13_arlen;
input [2:0]        		mst13_arsize;
input [1:0]        		mst13_arburst;
input 	        		mst13_arvalid;
input				mst13_rready;
input [4:0]                	mst13_rsid;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
input [ID_MSB:0]   		mst14_awid;
input [19:0] 			mst14_awaddr;
input [3:0]        		mst14_awlen;
input [2:0]        		mst14_awsize;
input [1:0]        		mst14_awburst;
input 	        		mst14_awvalid;
input              		mst14_wvalid;
input [4:0]                	mst14_wsid;
input              		mst14_wlast;
input [DATA_MSB:0]         	mst14_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst14_wstrb;
input				mst14_bready;
input [4:0]                	mst14_bsid;
input 			    	mst14_connect;

input [ID_MSB:0]   		mst14_arid;
input [ADDR_MSB:0] 		mst14_araddr;
input [7:0]        		mst14_arlen;
input [2:0]        		mst14_arsize;
input [1:0]        		mst14_arburst;
input 	        		mst14_arvalid;
input				mst14_rready;
input [4:0]                	mst14_rsid;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
input [ID_MSB:0]   		mst15_awid;
input [19:0] 			mst15_awaddr;
input [3:0]        		mst15_awlen;
input [2:0]        		mst15_awsize;
input [1:0]        		mst15_awburst;
input 	        		mst15_awvalid;
input              		mst15_wvalid;
input [4:0]                	mst15_wsid;
input              		mst15_wlast;
input [DATA_MSB:0]         	mst15_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst15_wstrb;
input				mst15_bready;
input [4:0]                	mst15_bsid;
input 			    	mst15_connect;

input [ID_MSB:0]   		mst15_arid;
input [ADDR_MSB:0] 		mst15_araddr;
input [7:0]        		mst15_arlen;
input [2:0]        		mst15_arsize;
input [1:0]        		mst15_arburst;
input 	        		mst15_arvalid;
input				mst15_rready;
input [4:0]                	mst15_rsid;
`endif
`ifdef ATCBMC300_SLV0_SUPPORT
input [63:20]	slv0_base_addr;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
input [63:20]	slv1_base_addr;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
input [63:20]	slv2_base_addr;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
input [63:20]	slv3_base_addr;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
input [63:20]	slv4_base_addr;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
input [63:20]	slv5_base_addr;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
input [63:20]	slv6_base_addr;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
input [63:20]	slv7_base_addr;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
input [63:20]	slv8_base_addr;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
input [63:20]	slv9_base_addr;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
input [63:20]	slv10_base_addr;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
input [63:20]	slv11_base_addr;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
input [63:20]	slv12_base_addr;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
input [63:20]	slv13_base_addr;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
input [63:20]	slv14_base_addr;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
input [63:20]	slv15_base_addr;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
input [63:20]	slv16_base_addr;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
input [63:20]	slv17_base_addr;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
input [63:20]	slv18_base_addr;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
input [63:20]	slv19_base_addr;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
input [63:20]	slv20_base_addr;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
input [63:20]	slv21_base_addr;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
input [63:20]	slv22_base_addr;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
input [63:20]	slv23_base_addr;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
input [63:20]	slv24_base_addr;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
input [63:20]	slv25_base_addr;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
input [63:20]	slv26_base_addr;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
input [63:20]	slv27_base_addr;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
input [63:20]	slv28_base_addr;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
input [63:20]	slv29_base_addr;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
input [63:20]	slv30_base_addr;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
input [63:20]	slv31_base_addr;
`endif
// #VPERL_GENERATED_END
output [(ID_MSB+4):0] slv0_rid;
output [(DATA_MSB+3):0] slv0_read_data;
output 	     	    slv0_rvalid;

output [ID_MSB+4:0] slv0_bid;
output [1:0] 	    slv0_bresp;
output 	     	    slv0_bvalid;

output	     	    slv0_wready;
output [3:0] 	    slv0_wmid;

output	     	    slv0_arready;
output	     	    slv0_awready;
output [3:0]	    slv0_ar_mid;
output [3:0]	    slv0_aw_mid;

output              reg_mst0_high_priority;
output [15:0]       reg_priority_reload;

input aclk;
input aresetn;

localparam ARRDY = 3'h0;
localparam  RVLD = 3'h1;
localparam AWRDY = 3'h2;
localparam  WRDY = 3'h3;
localparam  BVLD = 3'h4;
localparam AXI_INCR = 2'b01;
localparam AXI_WRAP = 2'b10;

reg [ADDR_MSB:0] araddr;
reg [3:0]        arwrap_len;
reg [2:0]        arsize;
reg [1:0]        arburst;
reg [ID_MSB:0] 	 arid;
reg [7:0]        cnt;
reg [3:0] 	 rmid;
reg [19:0] 	 awaddr;
reg [3:0]        awwrap_len;
reg [2:0]        awsize;
reg [1:0]        awburst;
reg [ID_MSB:0] 	 awid;
reg [3:0] 	 wmid;
//reg [2:0]        rw_reg_cs;
reg [ADDR_MSB:0] mst_araddr  [0:15];
reg [7:0]        mst_arlen   [0:15];
reg [2:0]        mst_arsize  [0:15];
reg [1:0]        mst_arburst [0:15];
reg [ID_MSB:0]   mst_arid    [0:15];
reg [15:0]	 mst_arvalid;
reg [19:0] 	 mst_awaddr  [0:15];
reg [3:0]        mst_awlen   [0:15];
reg [2:0]        mst_awsize  [0:15];
reg [1:0]        mst_awburst [0:15];
reg [ID_MSB:0]   mst_awid    [0:15];
reg [15:0]	 mst_awvalid;
reg [DATA_MSB:0] 	   mst_wdata [0:15];
reg [(DATA_WIDTH/8)-1:0] mst_wstrb [0:15];
reg [15:0]	 mst_wvalid;
reg [15:0]	 mst_wlast;
reg [15:0]	 mst_bready;
reg [15:0]	 mst_rready;
reg 		 slv0_rlast;
reg [DATA_MSB:0] slv0_rdata;
reg 		 slv0_rvalid;
reg 		 slv0_wready;
reg 		 slv0_bvalid;
reg [63:0]	 slave_base_size [0:31];
wire              reg_mst0_high_priority;
wire [15:0]       reg_priority_reload;
//reg [15:0]       granted_avalid;
wire [15:0]       priority_arvalid;
wire [15:0]       priority_awvalid;
reg [255:0] 	 rdata_256b;
reg [63:0] slave_base_size_rdata[0:3];
wire [7:0]      cnt_nxt;
wire [15:0]     arb_arvalid;
wire [15:0]     arb_awvalid;
wire 		granted_arvalid;
wire 		granted_awvalid;
wire		araddr_accept;
wire		awaddr_accept;
wire [3:0]      arb_armid;
wire [3:0]      arb_awmid;
wire 		rdata_en;
wire     	wdata_en;
wire pending_priority_arvalid;
wire pending_priority_awvalid;
assign pending_priority_arvalid = priority_arvalid!=16'h0;
assign pending_priority_awvalid = priority_awvalid!=16'h0;
// VPERL_BEGIN
//  for ($i=0;$i<16;$i++) {
// :`ifdef ATCBMC300_MST${i}_SUPPORT
// : reg mst${i}_priority_arvalid;
// : assign priority_arvalid[${i}] = mst${i}_priority_arvalid;
// : always @(posedge aclk or negedge aresetn) begin
// :	if (!aresetn)
// : 		mst${i}_priority_arvalid <= 1'b0;
// :	else 
// :		mst${i}_priority_arvalid <= mst${i}_connect & ~((arb_armid==4'd${i}) & slv0_arready) & 
// :					   ((~pending_priority_arvalid & mst${i}_arvalid & reg_priority_reload[${i}]) | mst${i}_priority_arvalid);
// : end
//
// : reg mst${i}_priority_awvalid;
// : assign priority_awvalid[${i}] = mst${i}_priority_awvalid;
// : always @(posedge aclk or negedge aresetn) begin
// :	if (!aresetn)
// : 		mst${i}_priority_awvalid <= 1'b0;
// :	else 
// :		mst${i}_priority_awvalid <= mst${i}_connect & ~((arb_awmid==4'd${i}) & slv0_awready) & 
// :					   ((~pending_priority_awvalid & mst${i}_awvalid & reg_priority_reload[${i}]) | mst${i}_priority_awvalid);
// : end
// :`else
// : assign priority_arvalid[${i}] = 1'b0;
// : assign priority_awvalid[${i}] = 1'b0;
// :`endif
// }
// : always @* begin
//  for ($i=0;$i<16;$i++) {
// :`ifdef ATCBMC300_MST${i}_SUPPORT
// : 	mst_araddr  [${i}] = mst${i}_araddr  & {ADDR_WIDTH{mst${i}_connect}};
// : 	mst_arlen   [${i}] = mst${i}_arlen   & {8{mst${i}_connect}};
// : 	mst_arsize  [${i}] = mst${i}_arsize  & {3{mst${i}_connect}};
// : 	mst_arburst [${i}] = mst${i}_arburst & {2{mst${i}_connect}};
// : 	mst_arid    [${i}] = mst${i}_arid    & {ID_WIDTH{mst${i}_connect}};  
// :	mst_arvalid [${i}] = mst${i}_arvalid & mst${i}_connect;     
// : 	mst_awaddr  [${i}] = mst${i}_awaddr  & {20{mst${i}_connect}};
// : 	mst_awlen   [${i}] = mst${i}_awlen   & {4{mst${i}_connect}};
// : 	mst_awsize  [${i}] = mst${i}_awsize  & {3{mst${i}_connect}};
// : 	mst_awburst [${i}] = mst${i}_awburst & {2{mst${i}_connect}};
// : 	mst_awid    [${i}] = mst${i}_awid    & {ID_WIDTH{mst${i}_connect}};  
// :	mst_awvalid [${i}] = mst${i}_awvalid & mst${i}_connect;     
// :	mst_wvalid  [${i}] = mst${i}_wvalid & mst${i}_connect & (mst${i}_wsid==SELF_ID);     
// : 	mst_wlast [${i}]  = mst${i}_wlast  & mst${i}_connect;
// : 	mst_wdata [${i}] = mst${i}_wdata  & {DATA_WIDTH{mst${i}_connect}};
// : 	mst_wstrb [${i}] = mst${i}_wstrb  & {(DATA_WIDTH/8){mst_wvalid[${i}] & slv0_wready}};
// : 	mst_bready[${i}] = mst${i}_bready & mst${i}_connect & (mst${i}_bsid==SELF_ID);
// : 	mst_rready[${i}] = mst${i}_rready & mst${i}_connect & (mst${i}_rsid==SELF_ID);
// :`else 
// : 	mst_araddr  [${i}] = {ADDR_WIDTH{1'b0}};
// : 	mst_arlen   [${i}] = {8{1'b0}};         
// : 	mst_arsize  [${i}] = {3{1'b0}};         
// : 	mst_arburst [${i}] = {2{1'b0}};         
// : 	mst_arid    [${i}] = {ID_WIDTH{1'b0}};  
// :	mst_arvalid [${i}] = 1'b0;
// : 	mst_awaddr  [${i}] = {20{1'b0}};
// : 	mst_awlen   [${i}] = {4{1'b0}};         
// : 	mst_awsize  [${i}] = {3{1'b0}};         
// : 	mst_awburst [${i}] = {2{1'b0}};         
// : 	mst_awid    [${i}] = {ID_WIDTH{1'b0}};  
// :	mst_awvalid [${i}] = 1'b0;
// : 	mst_wdata [${i}] = {DATA_WIDTH{1'b0}};
// : 	mst_wstrb [${i}] = {(DATA_WIDTH/8){1'b0}};
// : 	mst_wlast [${i}] = 1'b0;
// : 	mst_wvalid[${i}] = 1'b0;
// : 	mst_bready[${i}] = 1'b0;
// : 	mst_rready[${i}] = 1'b0;
// :`endif
// }
// :end
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
reg mst0_priority_arvalid;
assign priority_arvalid[0] = mst0_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst0_priority_arvalid <= 1'b0;
	else
		mst0_priority_arvalid <= mst0_connect & ~((arb_armid==4'd0) & slv0_arready) &
					   ((~pending_priority_arvalid & mst0_arvalid & reg_priority_reload[0]) | mst0_priority_arvalid);
end
reg mst0_priority_awvalid;
assign priority_awvalid[0] = mst0_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst0_priority_awvalid <= 1'b0;
	else
		mst0_priority_awvalid <= mst0_connect & ~((arb_awmid==4'd0) & slv0_awready) &
					   ((~pending_priority_awvalid & mst0_awvalid & reg_priority_reload[0]) | mst0_priority_awvalid);
end
`else
assign priority_arvalid[0] = 1'b0;
assign priority_awvalid[0] = 1'b0;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
reg mst1_priority_arvalid;
assign priority_arvalid[1] = mst1_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst1_priority_arvalid <= 1'b0;
	else
		mst1_priority_arvalid <= mst1_connect & ~((arb_armid==4'd1) & slv0_arready) &
					   ((~pending_priority_arvalid & mst1_arvalid & reg_priority_reload[1]) | mst1_priority_arvalid);
end
reg mst1_priority_awvalid;
assign priority_awvalid[1] = mst1_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst1_priority_awvalid <= 1'b0;
	else
		mst1_priority_awvalid <= mst1_connect & ~((arb_awmid==4'd1) & slv0_awready) &
					   ((~pending_priority_awvalid & mst1_awvalid & reg_priority_reload[1]) | mst1_priority_awvalid);
end
`else
assign priority_arvalid[1] = 1'b0;
assign priority_awvalid[1] = 1'b0;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
reg mst2_priority_arvalid;
assign priority_arvalid[2] = mst2_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst2_priority_arvalid <= 1'b0;
	else
		mst2_priority_arvalid <= mst2_connect & ~((arb_armid==4'd2) & slv0_arready) &
					   ((~pending_priority_arvalid & mst2_arvalid & reg_priority_reload[2]) | mst2_priority_arvalid);
end
reg mst2_priority_awvalid;
assign priority_awvalid[2] = mst2_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst2_priority_awvalid <= 1'b0;
	else
		mst2_priority_awvalid <= mst2_connect & ~((arb_awmid==4'd2) & slv0_awready) &
					   ((~pending_priority_awvalid & mst2_awvalid & reg_priority_reload[2]) | mst2_priority_awvalid);
end
`else
assign priority_arvalid[2] = 1'b0;
assign priority_awvalid[2] = 1'b0;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
reg mst3_priority_arvalid;
assign priority_arvalid[3] = mst3_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst3_priority_arvalid <= 1'b0;
	else
		mst3_priority_arvalid <= mst3_connect & ~((arb_armid==4'd3) & slv0_arready) &
					   ((~pending_priority_arvalid & mst3_arvalid & reg_priority_reload[3]) | mst3_priority_arvalid);
end
reg mst3_priority_awvalid;
assign priority_awvalid[3] = mst3_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst3_priority_awvalid <= 1'b0;
	else
		mst3_priority_awvalid <= mst3_connect & ~((arb_awmid==4'd3) & slv0_awready) &
					   ((~pending_priority_awvalid & mst3_awvalid & reg_priority_reload[3]) | mst3_priority_awvalid);
end
`else
assign priority_arvalid[3] = 1'b0;
assign priority_awvalid[3] = 1'b0;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
reg mst4_priority_arvalid;
assign priority_arvalid[4] = mst4_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst4_priority_arvalid <= 1'b0;
	else
		mst4_priority_arvalid <= mst4_connect & ~((arb_armid==4'd4) & slv0_arready) &
					   ((~pending_priority_arvalid & mst4_arvalid & reg_priority_reload[4]) | mst4_priority_arvalid);
end
reg mst4_priority_awvalid;
assign priority_awvalid[4] = mst4_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst4_priority_awvalid <= 1'b0;
	else
		mst4_priority_awvalid <= mst4_connect & ~((arb_awmid==4'd4) & slv0_awready) &
					   ((~pending_priority_awvalid & mst4_awvalid & reg_priority_reload[4]) | mst4_priority_awvalid);
end
`else
assign priority_arvalid[4] = 1'b0;
assign priority_awvalid[4] = 1'b0;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
reg mst5_priority_arvalid;
assign priority_arvalid[5] = mst5_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst5_priority_arvalid <= 1'b0;
	else
		mst5_priority_arvalid <= mst5_connect & ~((arb_armid==4'd5) & slv0_arready) &
					   ((~pending_priority_arvalid & mst5_arvalid & reg_priority_reload[5]) | mst5_priority_arvalid);
end
reg mst5_priority_awvalid;
assign priority_awvalid[5] = mst5_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst5_priority_awvalid <= 1'b0;
	else
		mst5_priority_awvalid <= mst5_connect & ~((arb_awmid==4'd5) & slv0_awready) &
					   ((~pending_priority_awvalid & mst5_awvalid & reg_priority_reload[5]) | mst5_priority_awvalid);
end
`else
assign priority_arvalid[5] = 1'b0;
assign priority_awvalid[5] = 1'b0;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
reg mst6_priority_arvalid;
assign priority_arvalid[6] = mst6_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst6_priority_arvalid <= 1'b0;
	else
		mst6_priority_arvalid <= mst6_connect & ~((arb_armid==4'd6) & slv0_arready) &
					   ((~pending_priority_arvalid & mst6_arvalid & reg_priority_reload[6]) | mst6_priority_arvalid);
end
reg mst6_priority_awvalid;
assign priority_awvalid[6] = mst6_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst6_priority_awvalid <= 1'b0;
	else
		mst6_priority_awvalid <= mst6_connect & ~((arb_awmid==4'd6) & slv0_awready) &
					   ((~pending_priority_awvalid & mst6_awvalid & reg_priority_reload[6]) | mst6_priority_awvalid);
end
`else
assign priority_arvalid[6] = 1'b0;
assign priority_awvalid[6] = 1'b0;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
reg mst7_priority_arvalid;
assign priority_arvalid[7] = mst7_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst7_priority_arvalid <= 1'b0;
	else
		mst7_priority_arvalid <= mst7_connect & ~((arb_armid==4'd7) & slv0_arready) &
					   ((~pending_priority_arvalid & mst7_arvalid & reg_priority_reload[7]) | mst7_priority_arvalid);
end
reg mst7_priority_awvalid;
assign priority_awvalid[7] = mst7_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst7_priority_awvalid <= 1'b0;
	else
		mst7_priority_awvalid <= mst7_connect & ~((arb_awmid==4'd7) & slv0_awready) &
					   ((~pending_priority_awvalid & mst7_awvalid & reg_priority_reload[7]) | mst7_priority_awvalid);
end
`else
assign priority_arvalid[7] = 1'b0;
assign priority_awvalid[7] = 1'b0;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
reg mst8_priority_arvalid;
assign priority_arvalid[8] = mst8_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst8_priority_arvalid <= 1'b0;
	else
		mst8_priority_arvalid <= mst8_connect & ~((arb_armid==4'd8) & slv0_arready) &
					   ((~pending_priority_arvalid & mst8_arvalid & reg_priority_reload[8]) | mst8_priority_arvalid);
end
reg mst8_priority_awvalid;
assign priority_awvalid[8] = mst8_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst8_priority_awvalid <= 1'b0;
	else
		mst8_priority_awvalid <= mst8_connect & ~((arb_awmid==4'd8) & slv0_awready) &
					   ((~pending_priority_awvalid & mst8_awvalid & reg_priority_reload[8]) | mst8_priority_awvalid);
end
`else
assign priority_arvalid[8] = 1'b0;
assign priority_awvalid[8] = 1'b0;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
reg mst9_priority_arvalid;
assign priority_arvalid[9] = mst9_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst9_priority_arvalid <= 1'b0;
	else
		mst9_priority_arvalid <= mst9_connect & ~((arb_armid==4'd9) & slv0_arready) &
					   ((~pending_priority_arvalid & mst9_arvalid & reg_priority_reload[9]) | mst9_priority_arvalid);
end
reg mst9_priority_awvalid;
assign priority_awvalid[9] = mst9_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst9_priority_awvalid <= 1'b0;
	else
		mst9_priority_awvalid <= mst9_connect & ~((arb_awmid==4'd9) & slv0_awready) &
					   ((~pending_priority_awvalid & mst9_awvalid & reg_priority_reload[9]) | mst9_priority_awvalid);
end
`else
assign priority_arvalid[9] = 1'b0;
assign priority_awvalid[9] = 1'b0;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
reg mst10_priority_arvalid;
assign priority_arvalid[10] = mst10_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst10_priority_arvalid <= 1'b0;
	else
		mst10_priority_arvalid <= mst10_connect & ~((arb_armid==4'd10) & slv0_arready) &
					   ((~pending_priority_arvalid & mst10_arvalid & reg_priority_reload[10]) | mst10_priority_arvalid);
end
reg mst10_priority_awvalid;
assign priority_awvalid[10] = mst10_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst10_priority_awvalid <= 1'b0;
	else
		mst10_priority_awvalid <= mst10_connect & ~((arb_awmid==4'd10) & slv0_awready) &
					   ((~pending_priority_awvalid & mst10_awvalid & reg_priority_reload[10]) | mst10_priority_awvalid);
end
`else
assign priority_arvalid[10] = 1'b0;
assign priority_awvalid[10] = 1'b0;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
reg mst11_priority_arvalid;
assign priority_arvalid[11] = mst11_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst11_priority_arvalid <= 1'b0;
	else
		mst11_priority_arvalid <= mst11_connect & ~((arb_armid==4'd11) & slv0_arready) &
					   ((~pending_priority_arvalid & mst11_arvalid & reg_priority_reload[11]) | mst11_priority_arvalid);
end
reg mst11_priority_awvalid;
assign priority_awvalid[11] = mst11_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst11_priority_awvalid <= 1'b0;
	else
		mst11_priority_awvalid <= mst11_connect & ~((arb_awmid==4'd11) & slv0_awready) &
					   ((~pending_priority_awvalid & mst11_awvalid & reg_priority_reload[11]) | mst11_priority_awvalid);
end
`else
assign priority_arvalid[11] = 1'b0;
assign priority_awvalid[11] = 1'b0;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
reg mst12_priority_arvalid;
assign priority_arvalid[12] = mst12_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst12_priority_arvalid <= 1'b0;
	else
		mst12_priority_arvalid <= mst12_connect & ~((arb_armid==4'd12) & slv0_arready) &
					   ((~pending_priority_arvalid & mst12_arvalid & reg_priority_reload[12]) | mst12_priority_arvalid);
end
reg mst12_priority_awvalid;
assign priority_awvalid[12] = mst12_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst12_priority_awvalid <= 1'b0;
	else
		mst12_priority_awvalid <= mst12_connect & ~((arb_awmid==4'd12) & slv0_awready) &
					   ((~pending_priority_awvalid & mst12_awvalid & reg_priority_reload[12]) | mst12_priority_awvalid);
end
`else
assign priority_arvalid[12] = 1'b0;
assign priority_awvalid[12] = 1'b0;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
reg mst13_priority_arvalid;
assign priority_arvalid[13] = mst13_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst13_priority_arvalid <= 1'b0;
	else
		mst13_priority_arvalid <= mst13_connect & ~((arb_armid==4'd13) & slv0_arready) &
					   ((~pending_priority_arvalid & mst13_arvalid & reg_priority_reload[13]) | mst13_priority_arvalid);
end
reg mst13_priority_awvalid;
assign priority_awvalid[13] = mst13_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst13_priority_awvalid <= 1'b0;
	else
		mst13_priority_awvalid <= mst13_connect & ~((arb_awmid==4'd13) & slv0_awready) &
					   ((~pending_priority_awvalid & mst13_awvalid & reg_priority_reload[13]) | mst13_priority_awvalid);
end
`else
assign priority_arvalid[13] = 1'b0;
assign priority_awvalid[13] = 1'b0;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
reg mst14_priority_arvalid;
assign priority_arvalid[14] = mst14_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst14_priority_arvalid <= 1'b0;
	else
		mst14_priority_arvalid <= mst14_connect & ~((arb_armid==4'd14) & slv0_arready) &
					   ((~pending_priority_arvalid & mst14_arvalid & reg_priority_reload[14]) | mst14_priority_arvalid);
end
reg mst14_priority_awvalid;
assign priority_awvalid[14] = mst14_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst14_priority_awvalid <= 1'b0;
	else
		mst14_priority_awvalid <= mst14_connect & ~((arb_awmid==4'd14) & slv0_awready) &
					   ((~pending_priority_awvalid & mst14_awvalid & reg_priority_reload[14]) | mst14_priority_awvalid);
end
`else
assign priority_arvalid[14] = 1'b0;
assign priority_awvalid[14] = 1'b0;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
reg mst15_priority_arvalid;
assign priority_arvalid[15] = mst15_priority_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst15_priority_arvalid <= 1'b0;
	else
		mst15_priority_arvalid <= mst15_connect & ~((arb_armid==4'd15) & slv0_arready) &
					   ((~pending_priority_arvalid & mst15_arvalid & reg_priority_reload[15]) | mst15_priority_arvalid);
end
reg mst15_priority_awvalid;
assign priority_awvalid[15] = mst15_priority_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst15_priority_awvalid <= 1'b0;
	else
		mst15_priority_awvalid <= mst15_connect & ~((arb_awmid==4'd15) & slv0_awready) &
					   ((~pending_priority_awvalid & mst15_awvalid & reg_priority_reload[15]) | mst15_priority_awvalid);
end
`else
assign priority_arvalid[15] = 1'b0;
assign priority_awvalid[15] = 1'b0;
`endif
always @* begin
`ifdef ATCBMC300_MST0_SUPPORT
	mst_araddr  [0] = mst0_araddr  & {ADDR_WIDTH{mst0_connect}};
	mst_arlen   [0] = mst0_arlen   & {8{mst0_connect}};
	mst_arsize  [0] = mst0_arsize  & {3{mst0_connect}};
	mst_arburst [0] = mst0_arburst & {2{mst0_connect}};
	mst_arid    [0] = mst0_arid    & {ID_WIDTH{mst0_connect}};
	mst_arvalid [0] = mst0_arvalid & mst0_connect;
	mst_awaddr  [0] = mst0_awaddr  & {20{mst0_connect}};
	mst_awlen   [0] = mst0_awlen   & {4{mst0_connect}};
	mst_awsize  [0] = mst0_awsize  & {3{mst0_connect}};
	mst_awburst [0] = mst0_awburst & {2{mst0_connect}};
	mst_awid    [0] = mst0_awid    & {ID_WIDTH{mst0_connect}};
	mst_awvalid [0] = mst0_awvalid & mst0_connect;
	mst_wvalid  [0] = mst0_wvalid & mst0_connect & (mst0_wsid==SELF_ID);
	mst_wlast [0]  = mst0_wlast  & mst0_connect;
	mst_wdata [0] = mst0_wdata  & {DATA_WIDTH{mst0_connect}};
	mst_wstrb [0] = mst0_wstrb  & {(DATA_WIDTH/8){mst_wvalid[0] & slv0_wready}};
	mst_bready[0] = mst0_bready & mst0_connect & (mst0_bsid==SELF_ID);
	mst_rready[0] = mst0_rready & mst0_connect & (mst0_rsid==SELF_ID);
`else
	mst_araddr  [0] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [0] = {8{1'b0}};
	mst_arsize  [0] = {3{1'b0}};
	mst_arburst [0] = {2{1'b0}};
	mst_arid    [0] = {ID_WIDTH{1'b0}};
	mst_arvalid [0] = 1'b0;
	mst_awaddr  [0] = {20{1'b0}};
	mst_awlen   [0] = {4{1'b0}};
	mst_awsize  [0] = {3{1'b0}};
	mst_awburst [0] = {2{1'b0}};
	mst_awid    [0] = {ID_WIDTH{1'b0}};
	mst_awvalid [0] = 1'b0;
	mst_wdata [0] = {DATA_WIDTH{1'b0}};
	mst_wstrb [0] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [0] = 1'b0;
	mst_wvalid[0] = 1'b0;
	mst_bready[0] = 1'b0;
	mst_rready[0] = 1'b0;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	mst_araddr  [1] = mst1_araddr  & {ADDR_WIDTH{mst1_connect}};
	mst_arlen   [1] = mst1_arlen   & {8{mst1_connect}};
	mst_arsize  [1] = mst1_arsize  & {3{mst1_connect}};
	mst_arburst [1] = mst1_arburst & {2{mst1_connect}};
	mst_arid    [1] = mst1_arid    & {ID_WIDTH{mst1_connect}};
	mst_arvalid [1] = mst1_arvalid & mst1_connect;
	mst_awaddr  [1] = mst1_awaddr  & {20{mst1_connect}};
	mst_awlen   [1] = mst1_awlen   & {4{mst1_connect}};
	mst_awsize  [1] = mst1_awsize  & {3{mst1_connect}};
	mst_awburst [1] = mst1_awburst & {2{mst1_connect}};
	mst_awid    [1] = mst1_awid    & {ID_WIDTH{mst1_connect}};
	mst_awvalid [1] = mst1_awvalid & mst1_connect;
	mst_wvalid  [1] = mst1_wvalid & mst1_connect & (mst1_wsid==SELF_ID);
	mst_wlast [1]  = mst1_wlast  & mst1_connect;
	mst_wdata [1] = mst1_wdata  & {DATA_WIDTH{mst1_connect}};
	mst_wstrb [1] = mst1_wstrb  & {(DATA_WIDTH/8){mst_wvalid[1] & slv0_wready}};
	mst_bready[1] = mst1_bready & mst1_connect & (mst1_bsid==SELF_ID);
	mst_rready[1] = mst1_rready & mst1_connect & (mst1_rsid==SELF_ID);
`else
	mst_araddr  [1] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [1] = {8{1'b0}};
	mst_arsize  [1] = {3{1'b0}};
	mst_arburst [1] = {2{1'b0}};
	mst_arid    [1] = {ID_WIDTH{1'b0}};
	mst_arvalid [1] = 1'b0;
	mst_awaddr  [1] = {20{1'b0}};
	mst_awlen   [1] = {4{1'b0}};
	mst_awsize  [1] = {3{1'b0}};
	mst_awburst [1] = {2{1'b0}};
	mst_awid    [1] = {ID_WIDTH{1'b0}};
	mst_awvalid [1] = 1'b0;
	mst_wdata [1] = {DATA_WIDTH{1'b0}};
	mst_wstrb [1] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [1] = 1'b0;
	mst_wvalid[1] = 1'b0;
	mst_bready[1] = 1'b0;
	mst_rready[1] = 1'b0;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	mst_araddr  [2] = mst2_araddr  & {ADDR_WIDTH{mst2_connect}};
	mst_arlen   [2] = mst2_arlen   & {8{mst2_connect}};
	mst_arsize  [2] = mst2_arsize  & {3{mst2_connect}};
	mst_arburst [2] = mst2_arburst & {2{mst2_connect}};
	mst_arid    [2] = mst2_arid    & {ID_WIDTH{mst2_connect}};
	mst_arvalid [2] = mst2_arvalid & mst2_connect;
	mst_awaddr  [2] = mst2_awaddr  & {20{mst2_connect}};
	mst_awlen   [2] = mst2_awlen   & {4{mst2_connect}};
	mst_awsize  [2] = mst2_awsize  & {3{mst2_connect}};
	mst_awburst [2] = mst2_awburst & {2{mst2_connect}};
	mst_awid    [2] = mst2_awid    & {ID_WIDTH{mst2_connect}};
	mst_awvalid [2] = mst2_awvalid & mst2_connect;
	mst_wvalid  [2] = mst2_wvalid & mst2_connect & (mst2_wsid==SELF_ID);
	mst_wlast [2]  = mst2_wlast  & mst2_connect;
	mst_wdata [2] = mst2_wdata  & {DATA_WIDTH{mst2_connect}};
	mst_wstrb [2] = mst2_wstrb  & {(DATA_WIDTH/8){mst_wvalid[2] & slv0_wready}};
	mst_bready[2] = mst2_bready & mst2_connect & (mst2_bsid==SELF_ID);
	mst_rready[2] = mst2_rready & mst2_connect & (mst2_rsid==SELF_ID);
`else
	mst_araddr  [2] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [2] = {8{1'b0}};
	mst_arsize  [2] = {3{1'b0}};
	mst_arburst [2] = {2{1'b0}};
	mst_arid    [2] = {ID_WIDTH{1'b0}};
	mst_arvalid [2] = 1'b0;
	mst_awaddr  [2] = {20{1'b0}};
	mst_awlen   [2] = {4{1'b0}};
	mst_awsize  [2] = {3{1'b0}};
	mst_awburst [2] = {2{1'b0}};
	mst_awid    [2] = {ID_WIDTH{1'b0}};
	mst_awvalid [2] = 1'b0;
	mst_wdata [2] = {DATA_WIDTH{1'b0}};
	mst_wstrb [2] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [2] = 1'b0;
	mst_wvalid[2] = 1'b0;
	mst_bready[2] = 1'b0;
	mst_rready[2] = 1'b0;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	mst_araddr  [3] = mst3_araddr  & {ADDR_WIDTH{mst3_connect}};
	mst_arlen   [3] = mst3_arlen   & {8{mst3_connect}};
	mst_arsize  [3] = mst3_arsize  & {3{mst3_connect}};
	mst_arburst [3] = mst3_arburst & {2{mst3_connect}};
	mst_arid    [3] = mst3_arid    & {ID_WIDTH{mst3_connect}};
	mst_arvalid [3] = mst3_arvalid & mst3_connect;
	mst_awaddr  [3] = mst3_awaddr  & {20{mst3_connect}};
	mst_awlen   [3] = mst3_awlen   & {4{mst3_connect}};
	mst_awsize  [3] = mst3_awsize  & {3{mst3_connect}};
	mst_awburst [3] = mst3_awburst & {2{mst3_connect}};
	mst_awid    [3] = mst3_awid    & {ID_WIDTH{mst3_connect}};
	mst_awvalid [3] = mst3_awvalid & mst3_connect;
	mst_wvalid  [3] = mst3_wvalid & mst3_connect & (mst3_wsid==SELF_ID);
	mst_wlast [3]  = mst3_wlast  & mst3_connect;
	mst_wdata [3] = mst3_wdata  & {DATA_WIDTH{mst3_connect}};
	mst_wstrb [3] = mst3_wstrb  & {(DATA_WIDTH/8){mst_wvalid[3] & slv0_wready}};
	mst_bready[3] = mst3_bready & mst3_connect & (mst3_bsid==SELF_ID);
	mst_rready[3] = mst3_rready & mst3_connect & (mst3_rsid==SELF_ID);
`else
	mst_araddr  [3] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [3] = {8{1'b0}};
	mst_arsize  [3] = {3{1'b0}};
	mst_arburst [3] = {2{1'b0}};
	mst_arid    [3] = {ID_WIDTH{1'b0}};
	mst_arvalid [3] = 1'b0;
	mst_awaddr  [3] = {20{1'b0}};
	mst_awlen   [3] = {4{1'b0}};
	mst_awsize  [3] = {3{1'b0}};
	mst_awburst [3] = {2{1'b0}};
	mst_awid    [3] = {ID_WIDTH{1'b0}};
	mst_awvalid [3] = 1'b0;
	mst_wdata [3] = {DATA_WIDTH{1'b0}};
	mst_wstrb [3] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [3] = 1'b0;
	mst_wvalid[3] = 1'b0;
	mst_bready[3] = 1'b0;
	mst_rready[3] = 1'b0;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	mst_araddr  [4] = mst4_araddr  & {ADDR_WIDTH{mst4_connect}};
	mst_arlen   [4] = mst4_arlen   & {8{mst4_connect}};
	mst_arsize  [4] = mst4_arsize  & {3{mst4_connect}};
	mst_arburst [4] = mst4_arburst & {2{mst4_connect}};
	mst_arid    [4] = mst4_arid    & {ID_WIDTH{mst4_connect}};
	mst_arvalid [4] = mst4_arvalid & mst4_connect;
	mst_awaddr  [4] = mst4_awaddr  & {20{mst4_connect}};
	mst_awlen   [4] = mst4_awlen   & {4{mst4_connect}};
	mst_awsize  [4] = mst4_awsize  & {3{mst4_connect}};
	mst_awburst [4] = mst4_awburst & {2{mst4_connect}};
	mst_awid    [4] = mst4_awid    & {ID_WIDTH{mst4_connect}};
	mst_awvalid [4] = mst4_awvalid & mst4_connect;
	mst_wvalid  [4] = mst4_wvalid & mst4_connect & (mst4_wsid==SELF_ID);
	mst_wlast [4]  = mst4_wlast  & mst4_connect;
	mst_wdata [4] = mst4_wdata  & {DATA_WIDTH{mst4_connect}};
	mst_wstrb [4] = mst4_wstrb  & {(DATA_WIDTH/8){mst_wvalid[4] & slv0_wready}};
	mst_bready[4] = mst4_bready & mst4_connect & (mst4_bsid==SELF_ID);
	mst_rready[4] = mst4_rready & mst4_connect & (mst4_rsid==SELF_ID);
`else
	mst_araddr  [4] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [4] = {8{1'b0}};
	mst_arsize  [4] = {3{1'b0}};
	mst_arburst [4] = {2{1'b0}};
	mst_arid    [4] = {ID_WIDTH{1'b0}};
	mst_arvalid [4] = 1'b0;
	mst_awaddr  [4] = {20{1'b0}};
	mst_awlen   [4] = {4{1'b0}};
	mst_awsize  [4] = {3{1'b0}};
	mst_awburst [4] = {2{1'b0}};
	mst_awid    [4] = {ID_WIDTH{1'b0}};
	mst_awvalid [4] = 1'b0;
	mst_wdata [4] = {DATA_WIDTH{1'b0}};
	mst_wstrb [4] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [4] = 1'b0;
	mst_wvalid[4] = 1'b0;
	mst_bready[4] = 1'b0;
	mst_rready[4] = 1'b0;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	mst_araddr  [5] = mst5_araddr  & {ADDR_WIDTH{mst5_connect}};
	mst_arlen   [5] = mst5_arlen   & {8{mst5_connect}};
	mst_arsize  [5] = mst5_arsize  & {3{mst5_connect}};
	mst_arburst [5] = mst5_arburst & {2{mst5_connect}};
	mst_arid    [5] = mst5_arid    & {ID_WIDTH{mst5_connect}};
	mst_arvalid [5] = mst5_arvalid & mst5_connect;
	mst_awaddr  [5] = mst5_awaddr  & {20{mst5_connect}};
	mst_awlen   [5] = mst5_awlen   & {4{mst5_connect}};
	mst_awsize  [5] = mst5_awsize  & {3{mst5_connect}};
	mst_awburst [5] = mst5_awburst & {2{mst5_connect}};
	mst_awid    [5] = mst5_awid    & {ID_WIDTH{mst5_connect}};
	mst_awvalid [5] = mst5_awvalid & mst5_connect;
	mst_wvalid  [5] = mst5_wvalid & mst5_connect & (mst5_wsid==SELF_ID);
	mst_wlast [5]  = mst5_wlast  & mst5_connect;
	mst_wdata [5] = mst5_wdata  & {DATA_WIDTH{mst5_connect}};
	mst_wstrb [5] = mst5_wstrb  & {(DATA_WIDTH/8){mst_wvalid[5] & slv0_wready}};
	mst_bready[5] = mst5_bready & mst5_connect & (mst5_bsid==SELF_ID);
	mst_rready[5] = mst5_rready & mst5_connect & (mst5_rsid==SELF_ID);
`else
	mst_araddr  [5] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [5] = {8{1'b0}};
	mst_arsize  [5] = {3{1'b0}};
	mst_arburst [5] = {2{1'b0}};
	mst_arid    [5] = {ID_WIDTH{1'b0}};
	mst_arvalid [5] = 1'b0;
	mst_awaddr  [5] = {20{1'b0}};
	mst_awlen   [5] = {4{1'b0}};
	mst_awsize  [5] = {3{1'b0}};
	mst_awburst [5] = {2{1'b0}};
	mst_awid    [5] = {ID_WIDTH{1'b0}};
	mst_awvalid [5] = 1'b0;
	mst_wdata [5] = {DATA_WIDTH{1'b0}};
	mst_wstrb [5] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [5] = 1'b0;
	mst_wvalid[5] = 1'b0;
	mst_bready[5] = 1'b0;
	mst_rready[5] = 1'b0;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	mst_araddr  [6] = mst6_araddr  & {ADDR_WIDTH{mst6_connect}};
	mst_arlen   [6] = mst6_arlen   & {8{mst6_connect}};
	mst_arsize  [6] = mst6_arsize  & {3{mst6_connect}};
	mst_arburst [6] = mst6_arburst & {2{mst6_connect}};
	mst_arid    [6] = mst6_arid    & {ID_WIDTH{mst6_connect}};
	mst_arvalid [6] = mst6_arvalid & mst6_connect;
	mst_awaddr  [6] = mst6_awaddr  & {20{mst6_connect}};
	mst_awlen   [6] = mst6_awlen   & {4{mst6_connect}};
	mst_awsize  [6] = mst6_awsize  & {3{mst6_connect}};
	mst_awburst [6] = mst6_awburst & {2{mst6_connect}};
	mst_awid    [6] = mst6_awid    & {ID_WIDTH{mst6_connect}};
	mst_awvalid [6] = mst6_awvalid & mst6_connect;
	mst_wvalid  [6] = mst6_wvalid & mst6_connect & (mst6_wsid==SELF_ID);
	mst_wlast [6]  = mst6_wlast  & mst6_connect;
	mst_wdata [6] = mst6_wdata  & {DATA_WIDTH{mst6_connect}};
	mst_wstrb [6] = mst6_wstrb  & {(DATA_WIDTH/8){mst_wvalid[6] & slv0_wready}};
	mst_bready[6] = mst6_bready & mst6_connect & (mst6_bsid==SELF_ID);
	mst_rready[6] = mst6_rready & mst6_connect & (mst6_rsid==SELF_ID);
`else
	mst_araddr  [6] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [6] = {8{1'b0}};
	mst_arsize  [6] = {3{1'b0}};
	mst_arburst [6] = {2{1'b0}};
	mst_arid    [6] = {ID_WIDTH{1'b0}};
	mst_arvalid [6] = 1'b0;
	mst_awaddr  [6] = {20{1'b0}};
	mst_awlen   [6] = {4{1'b0}};
	mst_awsize  [6] = {3{1'b0}};
	mst_awburst [6] = {2{1'b0}};
	mst_awid    [6] = {ID_WIDTH{1'b0}};
	mst_awvalid [6] = 1'b0;
	mst_wdata [6] = {DATA_WIDTH{1'b0}};
	mst_wstrb [6] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [6] = 1'b0;
	mst_wvalid[6] = 1'b0;
	mst_bready[6] = 1'b0;
	mst_rready[6] = 1'b0;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	mst_araddr  [7] = mst7_araddr  & {ADDR_WIDTH{mst7_connect}};
	mst_arlen   [7] = mst7_arlen   & {8{mst7_connect}};
	mst_arsize  [7] = mst7_arsize  & {3{mst7_connect}};
	mst_arburst [7] = mst7_arburst & {2{mst7_connect}};
	mst_arid    [7] = mst7_arid    & {ID_WIDTH{mst7_connect}};
	mst_arvalid [7] = mst7_arvalid & mst7_connect;
	mst_awaddr  [7] = mst7_awaddr  & {20{mst7_connect}};
	mst_awlen   [7] = mst7_awlen   & {4{mst7_connect}};
	mst_awsize  [7] = mst7_awsize  & {3{mst7_connect}};
	mst_awburst [7] = mst7_awburst & {2{mst7_connect}};
	mst_awid    [7] = mst7_awid    & {ID_WIDTH{mst7_connect}};
	mst_awvalid [7] = mst7_awvalid & mst7_connect;
	mst_wvalid  [7] = mst7_wvalid & mst7_connect & (mst7_wsid==SELF_ID);
	mst_wlast [7]  = mst7_wlast  & mst7_connect;
	mst_wdata [7] = mst7_wdata  & {DATA_WIDTH{mst7_connect}};
	mst_wstrb [7] = mst7_wstrb  & {(DATA_WIDTH/8){mst_wvalid[7] & slv0_wready}};
	mst_bready[7] = mst7_bready & mst7_connect & (mst7_bsid==SELF_ID);
	mst_rready[7] = mst7_rready & mst7_connect & (mst7_rsid==SELF_ID);
`else
	mst_araddr  [7] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [7] = {8{1'b0}};
	mst_arsize  [7] = {3{1'b0}};
	mst_arburst [7] = {2{1'b0}};
	mst_arid    [7] = {ID_WIDTH{1'b0}};
	mst_arvalid [7] = 1'b0;
	mst_awaddr  [7] = {20{1'b0}};
	mst_awlen   [7] = {4{1'b0}};
	mst_awsize  [7] = {3{1'b0}};
	mst_awburst [7] = {2{1'b0}};
	mst_awid    [7] = {ID_WIDTH{1'b0}};
	mst_awvalid [7] = 1'b0;
	mst_wdata [7] = {DATA_WIDTH{1'b0}};
	mst_wstrb [7] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [7] = 1'b0;
	mst_wvalid[7] = 1'b0;
	mst_bready[7] = 1'b0;
	mst_rready[7] = 1'b0;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	mst_araddr  [8] = mst8_araddr  & {ADDR_WIDTH{mst8_connect}};
	mst_arlen   [8] = mst8_arlen   & {8{mst8_connect}};
	mst_arsize  [8] = mst8_arsize  & {3{mst8_connect}};
	mst_arburst [8] = mst8_arburst & {2{mst8_connect}};
	mst_arid    [8] = mst8_arid    & {ID_WIDTH{mst8_connect}};
	mst_arvalid [8] = mst8_arvalid & mst8_connect;
	mst_awaddr  [8] = mst8_awaddr  & {20{mst8_connect}};
	mst_awlen   [8] = mst8_awlen   & {4{mst8_connect}};
	mst_awsize  [8] = mst8_awsize  & {3{mst8_connect}};
	mst_awburst [8] = mst8_awburst & {2{mst8_connect}};
	mst_awid    [8] = mst8_awid    & {ID_WIDTH{mst8_connect}};
	mst_awvalid [8] = mst8_awvalid & mst8_connect;
	mst_wvalid  [8] = mst8_wvalid & mst8_connect & (mst8_wsid==SELF_ID);
	mst_wlast [8]  = mst8_wlast  & mst8_connect;
	mst_wdata [8] = mst8_wdata  & {DATA_WIDTH{mst8_connect}};
	mst_wstrb [8] = mst8_wstrb  & {(DATA_WIDTH/8){mst_wvalid[8] & slv0_wready}};
	mst_bready[8] = mst8_bready & mst8_connect & (mst8_bsid==SELF_ID);
	mst_rready[8] = mst8_rready & mst8_connect & (mst8_rsid==SELF_ID);
`else
	mst_araddr  [8] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [8] = {8{1'b0}};
	mst_arsize  [8] = {3{1'b0}};
	mst_arburst [8] = {2{1'b0}};
	mst_arid    [8] = {ID_WIDTH{1'b0}};
	mst_arvalid [8] = 1'b0;
	mst_awaddr  [8] = {20{1'b0}};
	mst_awlen   [8] = {4{1'b0}};
	mst_awsize  [8] = {3{1'b0}};
	mst_awburst [8] = {2{1'b0}};
	mst_awid    [8] = {ID_WIDTH{1'b0}};
	mst_awvalid [8] = 1'b0;
	mst_wdata [8] = {DATA_WIDTH{1'b0}};
	mst_wstrb [8] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [8] = 1'b0;
	mst_wvalid[8] = 1'b0;
	mst_bready[8] = 1'b0;
	mst_rready[8] = 1'b0;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	mst_araddr  [9] = mst9_araddr  & {ADDR_WIDTH{mst9_connect}};
	mst_arlen   [9] = mst9_arlen   & {8{mst9_connect}};
	mst_arsize  [9] = mst9_arsize  & {3{mst9_connect}};
	mst_arburst [9] = mst9_arburst & {2{mst9_connect}};
	mst_arid    [9] = mst9_arid    & {ID_WIDTH{mst9_connect}};
	mst_arvalid [9] = mst9_arvalid & mst9_connect;
	mst_awaddr  [9] = mst9_awaddr  & {20{mst9_connect}};
	mst_awlen   [9] = mst9_awlen   & {4{mst9_connect}};
	mst_awsize  [9] = mst9_awsize  & {3{mst9_connect}};
	mst_awburst [9] = mst9_awburst & {2{mst9_connect}};
	mst_awid    [9] = mst9_awid    & {ID_WIDTH{mst9_connect}};
	mst_awvalid [9] = mst9_awvalid & mst9_connect;
	mst_wvalid  [9] = mst9_wvalid & mst9_connect & (mst9_wsid==SELF_ID);
	mst_wlast [9]  = mst9_wlast  & mst9_connect;
	mst_wdata [9] = mst9_wdata  & {DATA_WIDTH{mst9_connect}};
	mst_wstrb [9] = mst9_wstrb  & {(DATA_WIDTH/8){mst_wvalid[9] & slv0_wready}};
	mst_bready[9] = mst9_bready & mst9_connect & (mst9_bsid==SELF_ID);
	mst_rready[9] = mst9_rready & mst9_connect & (mst9_rsid==SELF_ID);
`else
	mst_araddr  [9] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [9] = {8{1'b0}};
	mst_arsize  [9] = {3{1'b0}};
	mst_arburst [9] = {2{1'b0}};
	mst_arid    [9] = {ID_WIDTH{1'b0}};
	mst_arvalid [9] = 1'b0;
	mst_awaddr  [9] = {20{1'b0}};
	mst_awlen   [9] = {4{1'b0}};
	mst_awsize  [9] = {3{1'b0}};
	mst_awburst [9] = {2{1'b0}};
	mst_awid    [9] = {ID_WIDTH{1'b0}};
	mst_awvalid [9] = 1'b0;
	mst_wdata [9] = {DATA_WIDTH{1'b0}};
	mst_wstrb [9] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [9] = 1'b0;
	mst_wvalid[9] = 1'b0;
	mst_bready[9] = 1'b0;
	mst_rready[9] = 1'b0;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	mst_araddr  [10] = mst10_araddr  & {ADDR_WIDTH{mst10_connect}};
	mst_arlen   [10] = mst10_arlen   & {8{mst10_connect}};
	mst_arsize  [10] = mst10_arsize  & {3{mst10_connect}};
	mst_arburst [10] = mst10_arburst & {2{mst10_connect}};
	mst_arid    [10] = mst10_arid    & {ID_WIDTH{mst10_connect}};
	mst_arvalid [10] = mst10_arvalid & mst10_connect;
	mst_awaddr  [10] = mst10_awaddr  & {20{mst10_connect}};
	mst_awlen   [10] = mst10_awlen   & {4{mst10_connect}};
	mst_awsize  [10] = mst10_awsize  & {3{mst10_connect}};
	mst_awburst [10] = mst10_awburst & {2{mst10_connect}};
	mst_awid    [10] = mst10_awid    & {ID_WIDTH{mst10_connect}};
	mst_awvalid [10] = mst10_awvalid & mst10_connect;
	mst_wvalid  [10] = mst10_wvalid & mst10_connect & (mst10_wsid==SELF_ID);
	mst_wlast [10]  = mst10_wlast  & mst10_connect;
	mst_wdata [10] = mst10_wdata  & {DATA_WIDTH{mst10_connect}};
	mst_wstrb [10] = mst10_wstrb  & {(DATA_WIDTH/8){mst_wvalid[10] & slv0_wready}};
	mst_bready[10] = mst10_bready & mst10_connect & (mst10_bsid==SELF_ID);
	mst_rready[10] = mst10_rready & mst10_connect & (mst10_rsid==SELF_ID);
`else
	mst_araddr  [10] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [10] = {8{1'b0}};
	mst_arsize  [10] = {3{1'b0}};
	mst_arburst [10] = {2{1'b0}};
	mst_arid    [10] = {ID_WIDTH{1'b0}};
	mst_arvalid [10] = 1'b0;
	mst_awaddr  [10] = {20{1'b0}};
	mst_awlen   [10] = {4{1'b0}};
	mst_awsize  [10] = {3{1'b0}};
	mst_awburst [10] = {2{1'b0}};
	mst_awid    [10] = {ID_WIDTH{1'b0}};
	mst_awvalid [10] = 1'b0;
	mst_wdata [10] = {DATA_WIDTH{1'b0}};
	mst_wstrb [10] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [10] = 1'b0;
	mst_wvalid[10] = 1'b0;
	mst_bready[10] = 1'b0;
	mst_rready[10] = 1'b0;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	mst_araddr  [11] = mst11_araddr  & {ADDR_WIDTH{mst11_connect}};
	mst_arlen   [11] = mst11_arlen   & {8{mst11_connect}};
	mst_arsize  [11] = mst11_arsize  & {3{mst11_connect}};
	mst_arburst [11] = mst11_arburst & {2{mst11_connect}};
	mst_arid    [11] = mst11_arid    & {ID_WIDTH{mst11_connect}};
	mst_arvalid [11] = mst11_arvalid & mst11_connect;
	mst_awaddr  [11] = mst11_awaddr  & {20{mst11_connect}};
	mst_awlen   [11] = mst11_awlen   & {4{mst11_connect}};
	mst_awsize  [11] = mst11_awsize  & {3{mst11_connect}};
	mst_awburst [11] = mst11_awburst & {2{mst11_connect}};
	mst_awid    [11] = mst11_awid    & {ID_WIDTH{mst11_connect}};
	mst_awvalid [11] = mst11_awvalid & mst11_connect;
	mst_wvalid  [11] = mst11_wvalid & mst11_connect & (mst11_wsid==SELF_ID);
	mst_wlast [11]  = mst11_wlast  & mst11_connect;
	mst_wdata [11] = mst11_wdata  & {DATA_WIDTH{mst11_connect}};
	mst_wstrb [11] = mst11_wstrb  & {(DATA_WIDTH/8){mst_wvalid[11] & slv0_wready}};
	mst_bready[11] = mst11_bready & mst11_connect & (mst11_bsid==SELF_ID);
	mst_rready[11] = mst11_rready & mst11_connect & (mst11_rsid==SELF_ID);
`else
	mst_araddr  [11] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [11] = {8{1'b0}};
	mst_arsize  [11] = {3{1'b0}};
	mst_arburst [11] = {2{1'b0}};
	mst_arid    [11] = {ID_WIDTH{1'b0}};
	mst_arvalid [11] = 1'b0;
	mst_awaddr  [11] = {20{1'b0}};
	mst_awlen   [11] = {4{1'b0}};
	mst_awsize  [11] = {3{1'b0}};
	mst_awburst [11] = {2{1'b0}};
	mst_awid    [11] = {ID_WIDTH{1'b0}};
	mst_awvalid [11] = 1'b0;
	mst_wdata [11] = {DATA_WIDTH{1'b0}};
	mst_wstrb [11] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [11] = 1'b0;
	mst_wvalid[11] = 1'b0;
	mst_bready[11] = 1'b0;
	mst_rready[11] = 1'b0;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	mst_araddr  [12] = mst12_araddr  & {ADDR_WIDTH{mst12_connect}};
	mst_arlen   [12] = mst12_arlen   & {8{mst12_connect}};
	mst_arsize  [12] = mst12_arsize  & {3{mst12_connect}};
	mst_arburst [12] = mst12_arburst & {2{mst12_connect}};
	mst_arid    [12] = mst12_arid    & {ID_WIDTH{mst12_connect}};
	mst_arvalid [12] = mst12_arvalid & mst12_connect;
	mst_awaddr  [12] = mst12_awaddr  & {20{mst12_connect}};
	mst_awlen   [12] = mst12_awlen   & {4{mst12_connect}};
	mst_awsize  [12] = mst12_awsize  & {3{mst12_connect}};
	mst_awburst [12] = mst12_awburst & {2{mst12_connect}};
	mst_awid    [12] = mst12_awid    & {ID_WIDTH{mst12_connect}};
	mst_awvalid [12] = mst12_awvalid & mst12_connect;
	mst_wvalid  [12] = mst12_wvalid & mst12_connect & (mst12_wsid==SELF_ID);
	mst_wlast [12]  = mst12_wlast  & mst12_connect;
	mst_wdata [12] = mst12_wdata  & {DATA_WIDTH{mst12_connect}};
	mst_wstrb [12] = mst12_wstrb  & {(DATA_WIDTH/8){mst_wvalid[12] & slv0_wready}};
	mst_bready[12] = mst12_bready & mst12_connect & (mst12_bsid==SELF_ID);
	mst_rready[12] = mst12_rready & mst12_connect & (mst12_rsid==SELF_ID);
`else
	mst_araddr  [12] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [12] = {8{1'b0}};
	mst_arsize  [12] = {3{1'b0}};
	mst_arburst [12] = {2{1'b0}};
	mst_arid    [12] = {ID_WIDTH{1'b0}};
	mst_arvalid [12] = 1'b0;
	mst_awaddr  [12] = {20{1'b0}};
	mst_awlen   [12] = {4{1'b0}};
	mst_awsize  [12] = {3{1'b0}};
	mst_awburst [12] = {2{1'b0}};
	mst_awid    [12] = {ID_WIDTH{1'b0}};
	mst_awvalid [12] = 1'b0;
	mst_wdata [12] = {DATA_WIDTH{1'b0}};
	mst_wstrb [12] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [12] = 1'b0;
	mst_wvalid[12] = 1'b0;
	mst_bready[12] = 1'b0;
	mst_rready[12] = 1'b0;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	mst_araddr  [13] = mst13_araddr  & {ADDR_WIDTH{mst13_connect}};
	mst_arlen   [13] = mst13_arlen   & {8{mst13_connect}};
	mst_arsize  [13] = mst13_arsize  & {3{mst13_connect}};
	mst_arburst [13] = mst13_arburst & {2{mst13_connect}};
	mst_arid    [13] = mst13_arid    & {ID_WIDTH{mst13_connect}};
	mst_arvalid [13] = mst13_arvalid & mst13_connect;
	mst_awaddr  [13] = mst13_awaddr  & {20{mst13_connect}};
	mst_awlen   [13] = mst13_awlen   & {4{mst13_connect}};
	mst_awsize  [13] = mst13_awsize  & {3{mst13_connect}};
	mst_awburst [13] = mst13_awburst & {2{mst13_connect}};
	mst_awid    [13] = mst13_awid    & {ID_WIDTH{mst13_connect}};
	mst_awvalid [13] = mst13_awvalid & mst13_connect;
	mst_wvalid  [13] = mst13_wvalid & mst13_connect & (mst13_wsid==SELF_ID);
	mst_wlast [13]  = mst13_wlast  & mst13_connect;
	mst_wdata [13] = mst13_wdata  & {DATA_WIDTH{mst13_connect}};
	mst_wstrb [13] = mst13_wstrb  & {(DATA_WIDTH/8){mst_wvalid[13] & slv0_wready}};
	mst_bready[13] = mst13_bready & mst13_connect & (mst13_bsid==SELF_ID);
	mst_rready[13] = mst13_rready & mst13_connect & (mst13_rsid==SELF_ID);
`else
	mst_araddr  [13] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [13] = {8{1'b0}};
	mst_arsize  [13] = {3{1'b0}};
	mst_arburst [13] = {2{1'b0}};
	mst_arid    [13] = {ID_WIDTH{1'b0}};
	mst_arvalid [13] = 1'b0;
	mst_awaddr  [13] = {20{1'b0}};
	mst_awlen   [13] = {4{1'b0}};
	mst_awsize  [13] = {3{1'b0}};
	mst_awburst [13] = {2{1'b0}};
	mst_awid    [13] = {ID_WIDTH{1'b0}};
	mst_awvalid [13] = 1'b0;
	mst_wdata [13] = {DATA_WIDTH{1'b0}};
	mst_wstrb [13] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [13] = 1'b0;
	mst_wvalid[13] = 1'b0;
	mst_bready[13] = 1'b0;
	mst_rready[13] = 1'b0;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	mst_araddr  [14] = mst14_araddr  & {ADDR_WIDTH{mst14_connect}};
	mst_arlen   [14] = mst14_arlen   & {8{mst14_connect}};
	mst_arsize  [14] = mst14_arsize  & {3{mst14_connect}};
	mst_arburst [14] = mst14_arburst & {2{mst14_connect}};
	mst_arid    [14] = mst14_arid    & {ID_WIDTH{mst14_connect}};
	mst_arvalid [14] = mst14_arvalid & mst14_connect;
	mst_awaddr  [14] = mst14_awaddr  & {20{mst14_connect}};
	mst_awlen   [14] = mst14_awlen   & {4{mst14_connect}};
	mst_awsize  [14] = mst14_awsize  & {3{mst14_connect}};
	mst_awburst [14] = mst14_awburst & {2{mst14_connect}};
	mst_awid    [14] = mst14_awid    & {ID_WIDTH{mst14_connect}};
	mst_awvalid [14] = mst14_awvalid & mst14_connect;
	mst_wvalid  [14] = mst14_wvalid & mst14_connect & (mst14_wsid==SELF_ID);
	mst_wlast [14]  = mst14_wlast  & mst14_connect;
	mst_wdata [14] = mst14_wdata  & {DATA_WIDTH{mst14_connect}};
	mst_wstrb [14] = mst14_wstrb  & {(DATA_WIDTH/8){mst_wvalid[14] & slv0_wready}};
	mst_bready[14] = mst14_bready & mst14_connect & (mst14_bsid==SELF_ID);
	mst_rready[14] = mst14_rready & mst14_connect & (mst14_rsid==SELF_ID);
`else
	mst_araddr  [14] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [14] = {8{1'b0}};
	mst_arsize  [14] = {3{1'b0}};
	mst_arburst [14] = {2{1'b0}};
	mst_arid    [14] = {ID_WIDTH{1'b0}};
	mst_arvalid [14] = 1'b0;
	mst_awaddr  [14] = {20{1'b0}};
	mst_awlen   [14] = {4{1'b0}};
	mst_awsize  [14] = {3{1'b0}};
	mst_awburst [14] = {2{1'b0}};
	mst_awid    [14] = {ID_WIDTH{1'b0}};
	mst_awvalid [14] = 1'b0;
	mst_wdata [14] = {DATA_WIDTH{1'b0}};
	mst_wstrb [14] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [14] = 1'b0;
	mst_wvalid[14] = 1'b0;
	mst_bready[14] = 1'b0;
	mst_rready[14] = 1'b0;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	mst_araddr  [15] = mst15_araddr  & {ADDR_WIDTH{mst15_connect}};
	mst_arlen   [15] = mst15_arlen   & {8{mst15_connect}};
	mst_arsize  [15] = mst15_arsize  & {3{mst15_connect}};
	mst_arburst [15] = mst15_arburst & {2{mst15_connect}};
	mst_arid    [15] = mst15_arid    & {ID_WIDTH{mst15_connect}};
	mst_arvalid [15] = mst15_arvalid & mst15_connect;
	mst_awaddr  [15] = mst15_awaddr  & {20{mst15_connect}};
	mst_awlen   [15] = mst15_awlen   & {4{mst15_connect}};
	mst_awsize  [15] = mst15_awsize  & {3{mst15_connect}};
	mst_awburst [15] = mst15_awburst & {2{mst15_connect}};
	mst_awid    [15] = mst15_awid    & {ID_WIDTH{mst15_connect}};
	mst_awvalid [15] = mst15_awvalid & mst15_connect;
	mst_wvalid  [15] = mst15_wvalid & mst15_connect & (mst15_wsid==SELF_ID);
	mst_wlast [15]  = mst15_wlast  & mst15_connect;
	mst_wdata [15] = mst15_wdata  & {DATA_WIDTH{mst15_connect}};
	mst_wstrb [15] = mst15_wstrb  & {(DATA_WIDTH/8){mst_wvalid[15] & slv0_wready}};
	mst_bready[15] = mst15_bready & mst15_connect & (mst15_bsid==SELF_ID);
	mst_rready[15] = mst15_rready & mst15_connect & (mst15_rsid==SELF_ID);
`else
	mst_araddr  [15] = {ADDR_WIDTH{1'b0}};
	mst_arlen   [15] = {8{1'b0}};
	mst_arsize  [15] = {3{1'b0}};
	mst_arburst [15] = {2{1'b0}};
	mst_arid    [15] = {ID_WIDTH{1'b0}};
	mst_arvalid [15] = 1'b0;
	mst_awaddr  [15] = {20{1'b0}};
	mst_awlen   [15] = {4{1'b0}};
	mst_awsize  [15] = {3{1'b0}};
	mst_awburst [15] = {2{1'b0}};
	mst_awid    [15] = {ID_WIDTH{1'b0}};
	mst_awvalid [15] = 1'b0;
	mst_wdata [15] = {DATA_WIDTH{1'b0}};
	mst_wstrb [15] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [15] = 1'b0;
	mst_wvalid[15] = 1'b0;
	mst_bready[15] = 1'b0;
	mst_rready[15] = 1'b0;
`endif
end
// VPERL_GENERATED_END
assign slv0_ar_mid = arb_armid;
assign slv0_aw_mid = arb_awmid;
assign slv0_rid = {arid,rmid};
assign slv0_bid = {awid,wmid};
assign slv0_bresp = 2'b00;
assign slv0_wmid = wmid;
assign slv0_arready = ~slv0_rvalid;
assign slv0_awready = ~slv0_wready & ~slv0_bvalid;
assign slv0_read_data = {2'b00, slv0_rlast, slv0_rdata};
//assign mst_req = mst_arvalid | mst_awvalid;
assign granted_arvalid = mst_arvalid[arb_armid];
assign granted_awvalid = mst_awvalid[arb_awmid];
assign araddr_accept = (granted_arvalid & slv0_arready);
assign awaddr_accept = (granted_awvalid & slv0_awready);
assign rdata_en = (slv0_rvalid & mst_rready[rmid]);
assign wdata_en = (mst_wvalid[wmid] & slv0_wready);
//always @(posedge aclk or negedge aresetn) begin
//	if (!aresetn)
//		priority_avalid <= 16'h0;
//	else if (((mst_req & reg_priority_reload)!=16'h0) & (priority_avalid==16'h0))
//		priority_avalid <= mst_req & reg_priority_reload & ~granted_avalid;
//	else if ((priority_avalid!=16'h0) & addr_accept)
//		priority_avalid[arb_mid] <= 1'b0;
//end

assign arb_arvalid =       (reg_mst0_high_priority & mst_arvalid[0]) ? 16'b1 : 
		                    (priority_arvalid!=16'h0) ? priority_arvalid : 
		    ((mst_arvalid & reg_priority_reload)!=16'h0) ? (mst_arvalid & reg_priority_reload) : mst_arvalid;
//assign arb_mid[3] =    (~mid[3] | (~|arb_req[7:0])) & (|arb_req[15:8]);
//assign arb_mid[2] = arb_mid[3] ? ((~mid[2] | (~|arb_req[11:08])) & (|arb_req[15:12])) :
//            		   	 ((~mid[2] | (~|arb_req[03:00])) & (|arb_req[07:04])) ; 
//assign arb_mid[1] = 
//            		(arb_mid[3:2]==2'h3 & ((~mid[1] | (~|arb_req[13:12])) & (|arb_req[15:14]))) |
//            		(arb_mid[3:2]==2'h2 & ((~mid[1] | (~|arb_req[09:08])) & (|arb_req[11:10]))) |
//            		(arb_mid[3:2]==2'h1 & ((~mid[1] | (~|arb_req[05:04])) & (|arb_req[07:06]))) |
//            		(arb_mid[3:2]==2'h0 & ((~mid[1] | (~|arb_req[01:00])) & (|arb_req[03:02]))) ;
//assign arb_mid[0] = 
//			(arb_mid[3:1]==3'h7 & ((~mid[0] | ~arb_req[14]) & arb_req[15])) |
//			(arb_mid[3:1]==3'h6 & ((~mid[0] | ~arb_req[12]) & arb_req[13])) |
//			(arb_mid[3:1]==3'h5 & ((~mid[0] | ~arb_req[10]) & arb_req[11])) |
//			(arb_mid[3:1]==3'h4 & ((~mid[0] | ~arb_req[08]) & arb_req[09])) |
//			(arb_mid[3:1]==3'h3 & ((~mid[0] | ~arb_req[06]) & arb_req[07])) |
//			(arb_mid[3:1]==3'h2 & ((~mid[0] | ~arb_req[04]) & arb_req[05])) |
//			(arb_mid[3:1]==3'h1 & ((~mid[0] | ~arb_req[02]) & arb_req[03])) |
//			(arb_mid[3:1]==3'h0 & ((~mid[0] | ~arb_req[00]) & arb_req[01])) ;
assign arb_armid[3] = (~|arb_arvalid[7:0]);
assign arb_armid[2] = arb_armid[3] ? (~|arb_arvalid[11:08]) : (~|arb_arvalid[03:00]);
assign arb_armid[1] = 
            		(arb_armid[3:2]==2'h3 & (~|arb_arvalid[13:12]))|
            		(arb_armid[3:2]==2'h2 & (~|arb_arvalid[09:08]))|
            		(arb_armid[3:2]==2'h1 & (~|arb_arvalid[05:04]))|
            		(arb_armid[3:2]==2'h0 & (~|arb_arvalid[01:00]));
assign arb_armid[0] = 
			(arb_armid[3:1]==3'h7 & ~arb_arvalid[14]) |
			(arb_armid[3:1]==3'h6 & ~arb_arvalid[12]) |
			(arb_armid[3:1]==3'h5 & ~arb_arvalid[10]) |
			(arb_armid[3:1]==3'h4 & ~arb_arvalid[08]) |
			(arb_armid[3:1]==3'h3 & ~arb_arvalid[06]) |
			(arb_armid[3:1]==3'h2 & ~arb_arvalid[04]) |
			(arb_armid[3:1]==3'h1 & ~arb_arvalid[02]) |
			(arb_armid[3:1]==3'h0 & ~arb_arvalid[00]) ;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		arsize     <= 3'h0;
		arwrap_len <= 4'h0;
		arburst    <= 2'h0;
		arid 	   <= {ID_WIDTH{1'b0}};
		rmid 	   <= {4{1'b0}};
	end else if (araddr_accept) begin
		arsize     <= mst_arsize[arb_armid] ;
		arwrap_len <= mst_arlen[arb_armid][3:0];
		arburst    <= mst_arburst[arb_armid];
		arid 	   <= mst_arid[arb_armid];
		rmid 	   <= arb_armid;
	end
end

wire [ADDR_MSB:0] araddr_adder = {{(ADDR_WIDTH-1){1'b0}},1'b1} << arsize;
wire [ADDR_MSB:0] araddr_inc = araddr + araddr_adder;
wire [ADDR_MSB:0] araddr_burst_mask = ({{(ADDR_WIDTH-12){1'b0}},{12{(arburst==AXI_INCR)}}} |
			              {{(ADDR_WIDTH-4){1'b0}},({4{(arburst==AXI_WRAP)}} & arwrap_len[3:0])}) << arsize;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) 
		araddr  	<= {ADDR_WIDTH{1'b0}}; 
	else if (araddr_accept)
		araddr  	<= mst_araddr[arb_armid] ;
	else if (rdata_en)
		araddr  	<= (araddr_burst_mask & araddr_inc) | (~araddr_burst_mask & araddr);
end


assign cnt_nxt = araddr_accept ? mst_arlen[arb_armid] : cnt - {7'b0,rdata_en & (cnt!=8'h0)};
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) 
		cnt   	<= 8'h0;
	else
		cnt   	<= cnt_nxt;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) 
		slv0_rlast <= 1'b0;
	else 
		slv0_rlast <= cnt_nxt==8'h0;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) 
		slv0_rvalid  	<= 1'b0;
	else 
		slv0_rvalid  	<= araddr_accept | (slv0_rvalid & ~(mst_rready[rmid] & slv0_rlast));
end

//always @(posedge aclk or negedge aresetn) begin
//	if (!aresetn)
//		rw_reg_cs <= ARRDY;
//	else if (granted_arvalid & slv0_arready)
//		rw_reg_cs <= RVLD;
//	else if (granted_awvalid & (slv0_arready | (rdata_en & slv0_rlast)))
//		rw_reg_cs <= AWRDY;
//	else if (granted_awvalid & slv0_awready)
//		rw_reg_cs <= WRDY;
//	else if (wdata_en & mst_wlast[mid])
//		rw_reg_cs <= BVLD;
//	else if ((mst_bready[mid] & slv0_bvalid) | (rdata_en & slv0_rlast))
//		rw_reg_cs <= ARRDY;
// end

// Read Data
always @* begin
	slave_base_size_rdata[3] = slave_base_size[{araddr[7:5],2'b11}];
	slave_base_size_rdata[2] = slave_base_size[{araddr[7:5],2'b10}];
	slave_base_size_rdata[1] = slave_base_size[{araddr[7:5],2'b01}];
	slave_base_size_rdata[0] = slave_base_size[{araddr[7:5],2'b00}];
end
always @* begin
	if (araddr[19:9]==11'b0)
		if (araddr[8])
			rdata_256b = {	slave_base_size_rdata[3],
					slave_base_size_rdata[2],
					slave_base_size_rdata[1],
					slave_base_size_rdata[0]};
		else if (araddr[7:5]==3'b000)
			rdata_256b = {	32'h0,
					32'h0,
					32'h0,
					reg_mst0_high_priority, 15'h0, reg_priority_reload,
					32'h0,
					32'h0,
					32'h0,
					`ATCBMC300_PRODUCT_ID};
		else
			rdata_256b = {256'h0};
	else
			rdata_256b = {256'h0};
end
		
generate
	if (DATA_MSB==31) begin: INTERNAL_READ_DATA32
		always @* begin
			case(araddr[4:2])
				3'h7: slv0_rdata = rdata_256b[255:224];
				3'h6: slv0_rdata = rdata_256b[223:192];
				3'h5: slv0_rdata = rdata_256b[191:160];
				3'h4: slv0_rdata = rdata_256b[159:128];
				3'h3: slv0_rdata = rdata_256b[127:96];
				3'h2: slv0_rdata = rdata_256b[95:64];
				3'h1: slv0_rdata = rdata_256b[63:32];
				3'h0: slv0_rdata = rdata_256b[31:00];
			endcase
		end
	end
	else if (DATA_MSB==63) begin: INTERNAL_READ_DATA64
		always @* begin
			case(araddr[4:3])
				2'h3: slv0_rdata = rdata_256b[255:192];
				2'h2: slv0_rdata = rdata_256b[191:128];
				2'h1: slv0_rdata = rdata_256b[127:64];
				2'h0: slv0_rdata = rdata_256b[63:00];
			endcase
		end
	end
	else if (DATA_MSB==127) begin: INTERNAL_READ_DATA128
		always @* begin
			case(araddr[4])
				1'h1: slv0_rdata = rdata_256b[255:128];
				1'h0: slv0_rdata = rdata_256b[127:00];
			endcase
		end
	end 
	else if (DATA_MSB==255) begin: INTERNAL_READ_DATA256
		always @* begin
			slv0_rdata = rdata_256b[255:00];
		end
	end
endgenerate
//always @* begin
//`ifdef ATCBMC300_DATA_WIDTH_32
//	case(araddr[3:2])
//		2'h3: slv0_rdata = rdata_128b[127:96];
//		2'h2: slv0_rdata = rdata_128b[95:64];
//		2'h1: slv0_rdata = rdata_128b[63:32];
//	     default: slv0_rdata = rdata_128b[31:00];
//	endcase
//`else
//	`ifdef ATCBMC300_DATA_WIDTH_64
//		if (araddr[3])
//			slv0_rdata = rdata_128b[127:64];
//		else
//			slv0_rdata = rdata_128b[63:00];
//	`else
//
//		slv0_rdata = rdata_128b[127:00];
//	`endif
//`endif
//end

//Write Data
assign arb_awvalid =   (reg_mst0_high_priority & mst_awvalid[0]) ? 16'b1 : 
		                        (priority_awvalid!=16'h0) ? priority_awvalid : 
		    ((mst_awvalid & reg_priority_reload)!=16'h0) ? (mst_awvalid & reg_priority_reload) : mst_awvalid;
assign arb_awmid[3] = (~|arb_awvalid[7:0]);
assign arb_awmid[2] = arb_awmid[3] ? (~|arb_awvalid[11:08]) : (~|arb_awvalid[03:00]);
assign arb_awmid[1] = 
            		(arb_awmid[3:2]==2'h3 & (~|arb_awvalid[13:12]))|
            		(arb_awmid[3:2]==2'h2 & (~|arb_awvalid[09:08]))|
            		(arb_awmid[3:2]==2'h1 & (~|arb_awvalid[05:04]))|
            		(arb_awmid[3:2]==2'h0 & (~|arb_awvalid[01:00]));
assign arb_awmid[0] = 
			(arb_awmid[3:1]==3'h7 & ~arb_awvalid[14]) |
			(arb_awmid[3:1]==3'h6 & ~arb_awvalid[12]) |
			(arb_awmid[3:1]==3'h5 & ~arb_awvalid[10]) |
			(arb_awmid[3:1]==3'h4 & ~arb_awvalid[08]) |
			(arb_awmid[3:1]==3'h3 & ~arb_awvalid[06]) |
			(arb_awmid[3:1]==3'h2 & ~arb_awvalid[04]) |
			(arb_awmid[3:1]==3'h1 & ~arb_awvalid[02]) |
			(arb_awmid[3:1]==3'h0 & ~arb_awvalid[00]) ;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		awsize  	<= 3'h0;
		awwrap_len<= 4'h0;
		awburst 	<= 2'h0;
		awid 	<= {ID_WIDTH{1'b0}};
		wmid 	<= {4{1'b0}};
	end else if (awaddr_accept) begin
		awsize     <= mst_awsize [arb_awmid] ;
		awwrap_len <= mst_awlen  [arb_awmid];
		awburst    <= mst_awburst[arb_awmid];
		awid 	   <= mst_awid   [arb_awmid];
		wmid 	   <= arb_awmid;
	end
end

wire [19:0] awaddr_adder = {{19{1'b0}},1'b1} << awsize;
wire [19:0] awaddr_inc = awaddr + awaddr_adder;
wire [19:0] awaddr_burst_mask = ({{8{1'b0}},{12{(awburst==AXI_INCR)}}} |
			         {{16{1'b0}},({4{(awburst==AXI_WRAP)}} & awwrap_len[3:0])}) << awsize;


always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) 
		awaddr  	<= {20{1'b0}}; 
	else if (awaddr_accept)
		awaddr  	<= mst_awaddr[arb_awmid] ;
	else if (wdata_en)
		awaddr  	<= (awaddr_burst_mask & awaddr_inc) | (~awaddr_burst_mask & awaddr);
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) 
		slv0_wready  	<= 1'b0;
	else 
		slv0_wready  	<= awaddr_accept | (slv0_wready & ~(mst_wvalid[wmid] & mst_wlast[wmid]));
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) 
		slv0_bvalid  	<= 1'b0;
	else 
		slv0_bvalid  	<= (slv0_wready & mst_wvalid[wmid] & mst_wlast[wmid]) | (slv0_bvalid & ~mst_bready[wmid]);
end

wire [31:0] aw_wstrb_mask = awsize==3'h0 ? (32'b1    	            <<  awaddr[4:0]) :
                            awsize==3'h1 ? (32'b11   	            << {awaddr[4:1],1'b0}) :
		            awsize==3'h2 ? (32'b1111 	            << {awaddr[4:2],2'b0}) :
		            awsize==3'h3 ? (32'b1111_1111           << {awaddr[4:3],3'b0}) :
		            awsize==3'h4 ? (32'b1111_1111_1111_1111 << {awaddr[4],4'b0}) :
                                         ({32{1'b1}}); 
wire [31:0] wstrb_wen = {MULTIPLE_WR_DATA{mst_wstrb[wmid]}} & aw_wstrb_mask;
wire [255:0] wdata_bit_wen = {
			      {8{wstrb_wen[31]}}, 
			      {8{wstrb_wen[30]}}, 
			      {8{wstrb_wen[29]}}, 
			      {8{wstrb_wen[28]}}, 
			      {8{wstrb_wen[27]}}, 
			      {8{wstrb_wen[26]}}, 
			      {8{wstrb_wen[25]}}, 
			      {8{wstrb_wen[24]}}, 
			      {8{wstrb_wen[23]}}, 
			      {8{wstrb_wen[22]}}, 
			      {8{wstrb_wen[21]}}, 
			      {8{wstrb_wen[20]}}, 
			      {8{wstrb_wen[19]}}, 
			      {8{wstrb_wen[18]}}, 
			      {8{wstrb_wen[17]}}, 
			      {8{wstrb_wen[16]}}, 
			      {8{wstrb_wen[15]}}, 
			      {8{wstrb_wen[14]}}, 
			      {8{wstrb_wen[13]}}, 
			      {8{wstrb_wen[12]}}, 
			      {8{wstrb_wen[11]}}, 
			      {8{wstrb_wen[10]}}, 
			      {8{wstrb_wen[09]}}, 
			      {8{wstrb_wen[08]}}, 
			      {8{wstrb_wen[07]}}, 
			      {8{wstrb_wen[06]}}, 
			      {8{wstrb_wen[05]}}, 
			      {8{wstrb_wen[04]}}, 
			      {8{wstrb_wen[03]}}, 
			      {8{wstrb_wen[02]}}, 
			      {8{wstrb_wen[01]}}, 
			      {8{wstrb_wen[00]}}
			     }; 
wire [255:0] wr_data  = {MULTIPLE_WR_DATA{mst_wdata[wmid]}};

`ifdef ATCBMC300_MST0_SUPPORT
localparam RESET_M0_HIGH_PRIORITY = `ATCBMC300_MST0_DEFAULT_HIGH_PRIORITY;
reg m0_hi_pri;
assign reg_mst0_high_priority = m0_hi_pri;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) 
		m0_hi_pri <= RESET_M0_HIGH_PRIORITY[0];
	else if (awaddr[19:5]==15'h00 & wdata_bit_wen[31+128])
		m0_hi_pri <= wr_data[31+128];
end
`else
assign reg_mst0_high_priority = 1'b0;
`endif
//always @(posedge aclk or negedge aresetn) begin
//	if (!aresetn) 
//		reg_priority_reload[15:0] <= 1'b0;
//	else if (awaddr[19:4]==16'h10)
//		reg_priority_reload[15:0] <= {wstrb_wen[1] ? wr_data[15:8] : reg_priority_reload[15:8],
//                                              wstrb_wen[0] ? wr_data[07:0] : reg_priority_reload[07:0]};
// end


// VPERL_BEGIN
//  for ($i=0;$i<16;$i++) {
// :`ifdef ATCBMC300_MST${i}_SUPPORT
// : localparam RESET_M${i}_PRI_RELOAD = `ATCBMC300_MST${i}_DEFAULT_PRIORITY_RELOAD;
// : reg mst${i}_pri_reload;
// : assign reg_priority_reload[${i}] = mst${i}_pri_reload;
// :always @(posedge aclk or negedge aresetn) begin
// :	if (!aresetn) 
// :  		mst${i}_pri_reload <= RESET_M${i}_PRI_RELOAD[0];
// :	else
// :  		mst${i}_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[${i}+128])? wr_data[${i}+128] : mst${i}_pri_reload;
// :end
// :`else
// : assign reg_priority_reload[${i}] = 1'b0;
// :`endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
localparam RESET_M0_PRI_RELOAD = `ATCBMC300_MST0_DEFAULT_PRIORITY_RELOAD;
reg mst0_pri_reload;
assign reg_priority_reload[0] = mst0_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst0_pri_reload <= RESET_M0_PRI_RELOAD[0];
	else
 		mst0_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[0+128])? wr_data[0+128] : mst0_pri_reload;
end
`else
assign reg_priority_reload[0] = 1'b0;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
localparam RESET_M1_PRI_RELOAD = `ATCBMC300_MST1_DEFAULT_PRIORITY_RELOAD;
reg mst1_pri_reload;
assign reg_priority_reload[1] = mst1_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst1_pri_reload <= RESET_M1_PRI_RELOAD[0];
	else
 		mst1_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[1+128])? wr_data[1+128] : mst1_pri_reload;
end
`else
assign reg_priority_reload[1] = 1'b0;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
localparam RESET_M2_PRI_RELOAD = `ATCBMC300_MST2_DEFAULT_PRIORITY_RELOAD;
reg mst2_pri_reload;
assign reg_priority_reload[2] = mst2_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst2_pri_reload <= RESET_M2_PRI_RELOAD[0];
	else
 		mst2_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[2+128])? wr_data[2+128] : mst2_pri_reload;
end
`else
assign reg_priority_reload[2] = 1'b0;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
localparam RESET_M3_PRI_RELOAD = `ATCBMC300_MST3_DEFAULT_PRIORITY_RELOAD;
reg mst3_pri_reload;
assign reg_priority_reload[3] = mst3_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst3_pri_reload <= RESET_M3_PRI_RELOAD[0];
	else
 		mst3_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[3+128])? wr_data[3+128] : mst3_pri_reload;
end
`else
assign reg_priority_reload[3] = 1'b0;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
localparam RESET_M4_PRI_RELOAD = `ATCBMC300_MST4_DEFAULT_PRIORITY_RELOAD;
reg mst4_pri_reload;
assign reg_priority_reload[4] = mst4_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst4_pri_reload <= RESET_M4_PRI_RELOAD[0];
	else
 		mst4_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[4+128])? wr_data[4+128] : mst4_pri_reload;
end
`else
assign reg_priority_reload[4] = 1'b0;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
localparam RESET_M5_PRI_RELOAD = `ATCBMC300_MST5_DEFAULT_PRIORITY_RELOAD;
reg mst5_pri_reload;
assign reg_priority_reload[5] = mst5_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst5_pri_reload <= RESET_M5_PRI_RELOAD[0];
	else
 		mst5_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[5+128])? wr_data[5+128] : mst5_pri_reload;
end
`else
assign reg_priority_reload[5] = 1'b0;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
localparam RESET_M6_PRI_RELOAD = `ATCBMC300_MST6_DEFAULT_PRIORITY_RELOAD;
reg mst6_pri_reload;
assign reg_priority_reload[6] = mst6_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst6_pri_reload <= RESET_M6_PRI_RELOAD[0];
	else
 		mst6_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[6+128])? wr_data[6+128] : mst6_pri_reload;
end
`else
assign reg_priority_reload[6] = 1'b0;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
localparam RESET_M7_PRI_RELOAD = `ATCBMC300_MST7_DEFAULT_PRIORITY_RELOAD;
reg mst7_pri_reload;
assign reg_priority_reload[7] = mst7_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst7_pri_reload <= RESET_M7_PRI_RELOAD[0];
	else
 		mst7_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[7+128])? wr_data[7+128] : mst7_pri_reload;
end
`else
assign reg_priority_reload[7] = 1'b0;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
localparam RESET_M8_PRI_RELOAD = `ATCBMC300_MST8_DEFAULT_PRIORITY_RELOAD;
reg mst8_pri_reload;
assign reg_priority_reload[8] = mst8_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst8_pri_reload <= RESET_M8_PRI_RELOAD[0];
	else
 		mst8_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[8+128])? wr_data[8+128] : mst8_pri_reload;
end
`else
assign reg_priority_reload[8] = 1'b0;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
localparam RESET_M9_PRI_RELOAD = `ATCBMC300_MST9_DEFAULT_PRIORITY_RELOAD;
reg mst9_pri_reload;
assign reg_priority_reload[9] = mst9_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst9_pri_reload <= RESET_M9_PRI_RELOAD[0];
	else
 		mst9_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[9+128])? wr_data[9+128] : mst9_pri_reload;
end
`else
assign reg_priority_reload[9] = 1'b0;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
localparam RESET_M10_PRI_RELOAD = `ATCBMC300_MST10_DEFAULT_PRIORITY_RELOAD;
reg mst10_pri_reload;
assign reg_priority_reload[10] = mst10_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst10_pri_reload <= RESET_M10_PRI_RELOAD[0];
	else
 		mst10_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[10+128])? wr_data[10+128] : mst10_pri_reload;
end
`else
assign reg_priority_reload[10] = 1'b0;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
localparam RESET_M11_PRI_RELOAD = `ATCBMC300_MST11_DEFAULT_PRIORITY_RELOAD;
reg mst11_pri_reload;
assign reg_priority_reload[11] = mst11_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst11_pri_reload <= RESET_M11_PRI_RELOAD[0];
	else
 		mst11_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[11+128])? wr_data[11+128] : mst11_pri_reload;
end
`else
assign reg_priority_reload[11] = 1'b0;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
localparam RESET_M12_PRI_RELOAD = `ATCBMC300_MST12_DEFAULT_PRIORITY_RELOAD;
reg mst12_pri_reload;
assign reg_priority_reload[12] = mst12_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst12_pri_reload <= RESET_M12_PRI_RELOAD[0];
	else
 		mst12_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[12+128])? wr_data[12+128] : mst12_pri_reload;
end
`else
assign reg_priority_reload[12] = 1'b0;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
localparam RESET_M13_PRI_RELOAD = `ATCBMC300_MST13_DEFAULT_PRIORITY_RELOAD;
reg mst13_pri_reload;
assign reg_priority_reload[13] = mst13_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst13_pri_reload <= RESET_M13_PRI_RELOAD[0];
	else
 		mst13_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[13+128])? wr_data[13+128] : mst13_pri_reload;
end
`else
assign reg_priority_reload[13] = 1'b0;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
localparam RESET_M14_PRI_RELOAD = `ATCBMC300_MST14_DEFAULT_PRIORITY_RELOAD;
reg mst14_pri_reload;
assign reg_priority_reload[14] = mst14_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst14_pri_reload <= RESET_M14_PRI_RELOAD[0];
	else
 		mst14_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[14+128])? wr_data[14+128] : mst14_pri_reload;
end
`else
assign reg_priority_reload[14] = 1'b0;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
localparam RESET_M15_PRI_RELOAD = `ATCBMC300_MST15_DEFAULT_PRIORITY_RELOAD;
reg mst15_pri_reload;
assign reg_priority_reload[15] = mst15_pri_reload;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		mst15_pri_reload <= RESET_M15_PRI_RELOAD[0];
	else
 		mst15_pri_reload <= ((awaddr[19:5]==15'h00) & wdata_bit_wen[15+128])? wr_data[15+128] : mst15_pri_reload;
end
`else
assign reg_priority_reload[15] = 1'b0;
`endif
// VPERL_GENERATED_END
// VPERL_BEGIN
//  for ($i=0;$i<32;$i++) {
// :`ifdef ATCBMC300_SLV${i}_SUPPORT
// :    localparam        SLV${i}_SIZE = `ATCBMC300_SLV${i}_SIZE;
// :`endif
// }
// :always @* begin
//  for ($i=0;$i<32;$i++) {
// :`ifdef ATCBMC300_SLV${i}_SUPPORT
// :    slave_base_size[${i}] =  {slv${i}_base_addr[63:20],12'h0,SLV${i}_SIZE[7:0]};
// :`else
// :    slave_base_size[${i}] =  64'h0;
// :`endif
// }
// :end
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_SLV0_SUPPORT
   localparam        SLV0_SIZE = `ATCBMC300_SLV0_SIZE;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
   localparam        SLV1_SIZE = `ATCBMC300_SLV1_SIZE;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
   localparam        SLV2_SIZE = `ATCBMC300_SLV2_SIZE;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
   localparam        SLV3_SIZE = `ATCBMC300_SLV3_SIZE;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
   localparam        SLV4_SIZE = `ATCBMC300_SLV4_SIZE;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
   localparam        SLV5_SIZE = `ATCBMC300_SLV5_SIZE;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
   localparam        SLV6_SIZE = `ATCBMC300_SLV6_SIZE;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
   localparam        SLV7_SIZE = `ATCBMC300_SLV7_SIZE;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
   localparam        SLV8_SIZE = `ATCBMC300_SLV8_SIZE;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
   localparam        SLV9_SIZE = `ATCBMC300_SLV9_SIZE;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
   localparam        SLV10_SIZE = `ATCBMC300_SLV10_SIZE;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
   localparam        SLV11_SIZE = `ATCBMC300_SLV11_SIZE;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
   localparam        SLV12_SIZE = `ATCBMC300_SLV12_SIZE;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
   localparam        SLV13_SIZE = `ATCBMC300_SLV13_SIZE;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
   localparam        SLV14_SIZE = `ATCBMC300_SLV14_SIZE;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
   localparam        SLV15_SIZE = `ATCBMC300_SLV15_SIZE;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
   localparam        SLV16_SIZE = `ATCBMC300_SLV16_SIZE;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
   localparam        SLV17_SIZE = `ATCBMC300_SLV17_SIZE;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
   localparam        SLV18_SIZE = `ATCBMC300_SLV18_SIZE;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
   localparam        SLV19_SIZE = `ATCBMC300_SLV19_SIZE;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
   localparam        SLV20_SIZE = `ATCBMC300_SLV20_SIZE;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
   localparam        SLV21_SIZE = `ATCBMC300_SLV21_SIZE;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
   localparam        SLV22_SIZE = `ATCBMC300_SLV22_SIZE;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
   localparam        SLV23_SIZE = `ATCBMC300_SLV23_SIZE;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
   localparam        SLV24_SIZE = `ATCBMC300_SLV24_SIZE;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
   localparam        SLV25_SIZE = `ATCBMC300_SLV25_SIZE;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
   localparam        SLV26_SIZE = `ATCBMC300_SLV26_SIZE;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
   localparam        SLV27_SIZE = `ATCBMC300_SLV27_SIZE;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
   localparam        SLV28_SIZE = `ATCBMC300_SLV28_SIZE;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
   localparam        SLV29_SIZE = `ATCBMC300_SLV29_SIZE;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
   localparam        SLV30_SIZE = `ATCBMC300_SLV30_SIZE;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
   localparam        SLV31_SIZE = `ATCBMC300_SLV31_SIZE;
`endif
always @* begin
`ifdef ATCBMC300_SLV0_SUPPORT
   slave_base_size[0] =  {slv0_base_addr[63:20],12'h0,SLV0_SIZE[7:0]};
`else
   slave_base_size[0] =  64'h0;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
   slave_base_size[1] =  {slv1_base_addr[63:20],12'h0,SLV1_SIZE[7:0]};
`else
   slave_base_size[1] =  64'h0;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
   slave_base_size[2] =  {slv2_base_addr[63:20],12'h0,SLV2_SIZE[7:0]};
`else
   slave_base_size[2] =  64'h0;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
   slave_base_size[3] =  {slv3_base_addr[63:20],12'h0,SLV3_SIZE[7:0]};
`else
   slave_base_size[3] =  64'h0;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
   slave_base_size[4] =  {slv4_base_addr[63:20],12'h0,SLV4_SIZE[7:0]};
`else
   slave_base_size[4] =  64'h0;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
   slave_base_size[5] =  {slv5_base_addr[63:20],12'h0,SLV5_SIZE[7:0]};
`else
   slave_base_size[5] =  64'h0;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
   slave_base_size[6] =  {slv6_base_addr[63:20],12'h0,SLV6_SIZE[7:0]};
`else
   slave_base_size[6] =  64'h0;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
   slave_base_size[7] =  {slv7_base_addr[63:20],12'h0,SLV7_SIZE[7:0]};
`else
   slave_base_size[7] =  64'h0;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
   slave_base_size[8] =  {slv8_base_addr[63:20],12'h0,SLV8_SIZE[7:0]};
`else
   slave_base_size[8] =  64'h0;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
   slave_base_size[9] =  {slv9_base_addr[63:20],12'h0,SLV9_SIZE[7:0]};
`else
   slave_base_size[9] =  64'h0;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
   slave_base_size[10] =  {slv10_base_addr[63:20],12'h0,SLV10_SIZE[7:0]};
`else
   slave_base_size[10] =  64'h0;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
   slave_base_size[11] =  {slv11_base_addr[63:20],12'h0,SLV11_SIZE[7:0]};
`else
   slave_base_size[11] =  64'h0;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
   slave_base_size[12] =  {slv12_base_addr[63:20],12'h0,SLV12_SIZE[7:0]};
`else
   slave_base_size[12] =  64'h0;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
   slave_base_size[13] =  {slv13_base_addr[63:20],12'h0,SLV13_SIZE[7:0]};
`else
   slave_base_size[13] =  64'h0;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
   slave_base_size[14] =  {slv14_base_addr[63:20],12'h0,SLV14_SIZE[7:0]};
`else
   slave_base_size[14] =  64'h0;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
   slave_base_size[15] =  {slv15_base_addr[63:20],12'h0,SLV15_SIZE[7:0]};
`else
   slave_base_size[15] =  64'h0;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
   slave_base_size[16] =  {slv16_base_addr[63:20],12'h0,SLV16_SIZE[7:0]};
`else
   slave_base_size[16] =  64'h0;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
   slave_base_size[17] =  {slv17_base_addr[63:20],12'h0,SLV17_SIZE[7:0]};
`else
   slave_base_size[17] =  64'h0;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
   slave_base_size[18] =  {slv18_base_addr[63:20],12'h0,SLV18_SIZE[7:0]};
`else
   slave_base_size[18] =  64'h0;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
   slave_base_size[19] =  {slv19_base_addr[63:20],12'h0,SLV19_SIZE[7:0]};
`else
   slave_base_size[19] =  64'h0;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
   slave_base_size[20] =  {slv20_base_addr[63:20],12'h0,SLV20_SIZE[7:0]};
`else
   slave_base_size[20] =  64'h0;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
   slave_base_size[21] =  {slv21_base_addr[63:20],12'h0,SLV21_SIZE[7:0]};
`else
   slave_base_size[21] =  64'h0;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
   slave_base_size[22] =  {slv22_base_addr[63:20],12'h0,SLV22_SIZE[7:0]};
`else
   slave_base_size[22] =  64'h0;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
   slave_base_size[23] =  {slv23_base_addr[63:20],12'h0,SLV23_SIZE[7:0]};
`else
   slave_base_size[23] =  64'h0;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
   slave_base_size[24] =  {slv24_base_addr[63:20],12'h0,SLV24_SIZE[7:0]};
`else
   slave_base_size[24] =  64'h0;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
   slave_base_size[25] =  {slv25_base_addr[63:20],12'h0,SLV25_SIZE[7:0]};
`else
   slave_base_size[25] =  64'h0;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
   slave_base_size[26] =  {slv26_base_addr[63:20],12'h0,SLV26_SIZE[7:0]};
`else
   slave_base_size[26] =  64'h0;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
   slave_base_size[27] =  {slv27_base_addr[63:20],12'h0,SLV27_SIZE[7:0]};
`else
   slave_base_size[27] =  64'h0;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
   slave_base_size[28] =  {slv28_base_addr[63:20],12'h0,SLV28_SIZE[7:0]};
`else
   slave_base_size[28] =  64'h0;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
   slave_base_size[29] =  {slv29_base_addr[63:20],12'h0,SLV29_SIZE[7:0]};
`else
   slave_base_size[29] =  64'h0;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
   slave_base_size[30] =  {slv30_base_addr[63:20],12'h0,SLV30_SIZE[7:0]};
`else
   slave_base_size[30] =  64'h0;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
   slave_base_size[31] =  {slv31_base_addr[63:20],12'h0,SLV31_SIZE[7:0]};
`else
   slave_base_size[31] =  64'h0;
`endif
end
// VPERL_GENERATED_END
endmodule
