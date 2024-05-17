`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

module atcbmc300_us_write_addr_ctrl (
// VPERL: &PORTLIST;
// VPERL_GENERATED_BEGIN
	  self_id,  
`ifdef ATCBMC300_SLV0_SUPPORT
	  slv0_aw_mid,
	  slv0_awready,
	  slv0_masked_base_addr,
	  slv0_addr_mask,
	  slv0_awvalid,
	  slv0_connect,
`endif // ATCBMC300_SLV0_SUPPORT
`ifdef ATCBMC300_SLV1_SUPPORT
	  slv1_aw_mid,
	  slv1_awready,
	  slv1_masked_base_addr,
	  slv1_addr_mask,
	  slv1_awvalid,
	  slv1_connect,
`endif // ATCBMC300_SLV1_SUPPORT
`ifdef ATCBMC300_SLV2_SUPPORT
	  slv2_aw_mid,
	  slv2_awready,
	  slv2_masked_base_addr,
	  slv2_addr_mask,
	  slv2_awvalid,
	  slv2_connect,
`endif // ATCBMC300_SLV2_SUPPORT
`ifdef ATCBMC300_SLV3_SUPPORT
	  slv3_aw_mid,
	  slv3_awready,
	  slv3_masked_base_addr,
	  slv3_addr_mask,
	  slv3_awvalid,
	  slv3_connect,
`endif // ATCBMC300_SLV3_SUPPORT
`ifdef ATCBMC300_SLV4_SUPPORT
	  slv4_aw_mid,
	  slv4_awready,
	  slv4_masked_base_addr,
	  slv4_addr_mask,
	  slv4_awvalid,
	  slv4_connect,
`endif // ATCBMC300_SLV4_SUPPORT
`ifdef ATCBMC300_SLV5_SUPPORT
	  slv5_aw_mid,
	  slv5_awready,
	  slv5_masked_base_addr,
	  slv5_addr_mask,
	  slv5_awvalid,
	  slv5_connect,
`endif // ATCBMC300_SLV5_SUPPORT
`ifdef ATCBMC300_SLV6_SUPPORT
	  slv6_aw_mid,
	  slv6_awready,
	  slv6_masked_base_addr,
	  slv6_addr_mask,
	  slv6_awvalid,
	  slv6_connect,
`endif // ATCBMC300_SLV6_SUPPORT
`ifdef ATCBMC300_SLV7_SUPPORT
	  slv7_aw_mid,
	  slv7_awready,
	  slv7_masked_base_addr,
	  slv7_addr_mask,
	  slv7_awvalid,
	  slv7_connect,
`endif // ATCBMC300_SLV7_SUPPORT
`ifdef ATCBMC300_SLV8_SUPPORT
	  slv8_aw_mid,
	  slv8_awready,
	  slv8_masked_base_addr,
	  slv8_addr_mask,
	  slv8_awvalid,
	  slv8_connect,
`endif // ATCBMC300_SLV8_SUPPORT
`ifdef ATCBMC300_SLV9_SUPPORT
	  slv9_aw_mid,
	  slv9_awready,
	  slv9_masked_base_addr,
	  slv9_addr_mask,
	  slv9_awvalid,
	  slv9_connect,
`endif // ATCBMC300_SLV9_SUPPORT
`ifdef ATCBMC300_SLV10_SUPPORT
	  slv10_aw_mid,
	  slv10_awready,
	  slv10_masked_base_addr,
	  slv10_addr_mask,
	  slv10_awvalid,
	  slv10_connect,
`endif // ATCBMC300_SLV10_SUPPORT
`ifdef ATCBMC300_SLV11_SUPPORT
	  slv11_aw_mid,
	  slv11_awready,
	  slv11_masked_base_addr,
	  slv11_addr_mask,
	  slv11_awvalid,
	  slv11_connect,
`endif // ATCBMC300_SLV11_SUPPORT
`ifdef ATCBMC300_SLV12_SUPPORT
	  slv12_aw_mid,
	  slv12_awready,
	  slv12_masked_base_addr,
	  slv12_addr_mask,
	  slv12_awvalid,
	  slv12_connect,
`endif // ATCBMC300_SLV12_SUPPORT
`ifdef ATCBMC300_SLV13_SUPPORT
	  slv13_aw_mid,
	  slv13_awready,
	  slv13_masked_base_addr,
	  slv13_addr_mask,
	  slv13_awvalid,
	  slv13_connect,
`endif // ATCBMC300_SLV13_SUPPORT
`ifdef ATCBMC300_SLV14_SUPPORT
	  slv14_aw_mid,
	  slv14_awready,
	  slv14_masked_base_addr,
	  slv14_addr_mask,
	  slv14_awvalid,
	  slv14_connect,
`endif // ATCBMC300_SLV14_SUPPORT
`ifdef ATCBMC300_SLV15_SUPPORT
	  slv15_aw_mid,
	  slv15_awready,
	  slv15_masked_base_addr,
	  slv15_addr_mask,
	  slv15_awvalid,
	  slv15_connect,
`endif // ATCBMC300_SLV15_SUPPORT
`ifdef ATCBMC300_SLV16_SUPPORT
	  slv16_aw_mid,
	  slv16_awready,
	  slv16_masked_base_addr,
	  slv16_addr_mask,
	  slv16_awvalid,
	  slv16_connect,
`endif // ATCBMC300_SLV16_SUPPORT
`ifdef ATCBMC300_SLV17_SUPPORT
	  slv17_aw_mid,
	  slv17_awready,
	  slv17_masked_base_addr,
	  slv17_addr_mask,
	  slv17_awvalid,
	  slv17_connect,
`endif // ATCBMC300_SLV17_SUPPORT
`ifdef ATCBMC300_SLV18_SUPPORT
	  slv18_aw_mid,
	  slv18_awready,
	  slv18_masked_base_addr,
	  slv18_addr_mask,
	  slv18_awvalid,
	  slv18_connect,
`endif // ATCBMC300_SLV18_SUPPORT
`ifdef ATCBMC300_SLV19_SUPPORT
	  slv19_aw_mid,
	  slv19_awready,
	  slv19_masked_base_addr,
	  slv19_addr_mask,
	  slv19_awvalid,
	  slv19_connect,
`endif // ATCBMC300_SLV19_SUPPORT
`ifdef ATCBMC300_SLV20_SUPPORT
	  slv20_aw_mid,
	  slv20_awready,
	  slv20_masked_base_addr,
	  slv20_addr_mask,
	  slv20_awvalid,
	  slv20_connect,
`endif // ATCBMC300_SLV20_SUPPORT
`ifdef ATCBMC300_SLV21_SUPPORT
	  slv21_aw_mid,
	  slv21_awready,
	  slv21_masked_base_addr,
	  slv21_addr_mask,
	  slv21_awvalid,
	  slv21_connect,
`endif // ATCBMC300_SLV21_SUPPORT
`ifdef ATCBMC300_SLV22_SUPPORT
	  slv22_aw_mid,
	  slv22_awready,
	  slv22_masked_base_addr,
	  slv22_addr_mask,
	  slv22_awvalid,
	  slv22_connect,
`endif // ATCBMC300_SLV22_SUPPORT
`ifdef ATCBMC300_SLV23_SUPPORT
	  slv23_aw_mid,
	  slv23_awready,
	  slv23_masked_base_addr,
	  slv23_addr_mask,
	  slv23_awvalid,
	  slv23_connect,
`endif // ATCBMC300_SLV23_SUPPORT
`ifdef ATCBMC300_SLV24_SUPPORT
	  slv24_aw_mid,
	  slv24_awready,
	  slv24_masked_base_addr,
	  slv24_addr_mask,
	  slv24_awvalid,
	  slv24_connect,
`endif // ATCBMC300_SLV24_SUPPORT
`ifdef ATCBMC300_SLV25_SUPPORT
	  slv25_aw_mid,
	  slv25_awready,
	  slv25_masked_base_addr,
	  slv25_addr_mask,
	  slv25_awvalid,
	  slv25_connect,
`endif // ATCBMC300_SLV25_SUPPORT
`ifdef ATCBMC300_SLV26_SUPPORT
	  slv26_aw_mid,
	  slv26_awready,
	  slv26_masked_base_addr,
	  slv26_addr_mask,
	  slv26_awvalid,
	  slv26_connect,
`endif // ATCBMC300_SLV26_SUPPORT
`ifdef ATCBMC300_SLV27_SUPPORT
	  slv27_aw_mid,
	  slv27_awready,
	  slv27_masked_base_addr,
	  slv27_addr_mask,
	  slv27_awvalid,
	  slv27_connect,
`endif // ATCBMC300_SLV27_SUPPORT
`ifdef ATCBMC300_SLV28_SUPPORT
	  slv28_aw_mid,
	  slv28_awready,
	  slv28_masked_base_addr,
	  slv28_addr_mask,
	  slv28_awvalid,
	  slv28_connect,
`endif // ATCBMC300_SLV28_SUPPORT
`ifdef ATCBMC300_SLV29_SUPPORT
	  slv29_aw_mid,
	  slv29_awready,
	  slv29_masked_base_addr,
	  slv29_addr_mask,
	  slv29_awvalid,
	  slv29_connect,
`endif // ATCBMC300_SLV29_SUPPORT
`ifdef ATCBMC300_SLV30_SUPPORT
	  slv30_aw_mid,
	  slv30_awready,
	  slv30_masked_base_addr,
	  slv30_addr_mask,
	  slv30_awvalid,
	  slv30_connect,
`endif // ATCBMC300_SLV30_SUPPORT
`ifdef ATCBMC300_SLV31_SUPPORT
	  slv31_aw_mid,
	  slv31_awready,
	  slv31_masked_base_addr,
	  slv31_addr_mask,
	  slv31_awvalid,
	  slv31_connect,
`endif // ATCBMC300_SLV31_SUPPORT
	  us_awaddr,
	  us_awlen, 
	  us_awsize,
	  us_awburst,
	  us_awlock,
	  us_awcache,
	  us_awprot,
	  us_awid,  
	  us_awvalid,
	  us_awready,
	  mst_awaddr,
	  mst_awlen,
	  mst_awsize,
	  mst_awburst,
	  mst_awlock,
	  mst_awcache,
	  mst_awprot,
	  mst_awid, 
	  dec_err_wready,
	  dec_err_bvalid,
	  dec_err_wvalid,
	  dec_err_wlast,
	  dec_err_bready,
	  aw_outstanding_id,
	  dec_err_bresp,
	  dec_err_bid,
	  aw_addr_outstanding_en,
	  aw_outstanding_ready,
	  wd_outstanding_idle,
	  br_outstanding_idle,
	  master_arlock,
	  master_arvalid,
	  master_arid,
	  mst_arlocking,
	  locking_arid,
	  us_bid,   
	  us_bvalid,
	  us_bready,
	  mst_awlocking,
	  locking_awid,
	  aclk,     
	  aresetn   
// VPERL_GENERATED_END
);
parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 64;
parameter ID_WIDTH   = 4;

parameter RESP_INORDER_ONLY = 1;
parameter OUTSTAND_ID_WIDTH = 5;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB   = ID_WIDTH - 1;
localparam OUTSTAND_ID_MSB = OUTSTAND_ID_WIDTH - 1;

input [3:0]     self_id;
//# VPERL_BEGIN
//  for ($i=0;$i<32;$i++) {
// :`ifdef ATCBMC300_SLV${i}_SUPPORT
// : input [3:0]        slv${i}_aw_mid;
// : input              slv${i}_awready;
// : input [64:0]	slv${i}_masked_base_addr;
// : input [64:0]	slv${i}_addr_mask;
// : output		slv${i}_awvalid;
// : input              slv${i}_connect;
// : `endif
// }
//# VPERL_END

//#VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_SLV0_SUPPORT
input [3:0]        slv0_aw_mid;
input              slv0_awready;
input [64:0]	   slv0_masked_base_addr;
input [64:0]	   slv0_addr_mask;
output		   slv0_awvalid;
input              slv0_connect;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
input [3:0]        slv1_aw_mid;
input              slv1_awready;
input [64:0]	   slv1_masked_base_addr;
input [64:0]	   slv1_addr_mask;
output		   slv1_awvalid;
input              slv1_connect;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
input [3:0]        slv2_aw_mid;
input              slv2_awready;
input [64:0]	slv2_masked_base_addr;
input [64:0]	slv2_addr_mask;
output		slv2_awvalid;
input              slv2_connect;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
input [3:0]        slv3_aw_mid;
input              slv3_awready;
input [64:0]	slv3_masked_base_addr;
input [64:0]	slv3_addr_mask;
output		slv3_awvalid;
input              slv3_connect;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
input [3:0]        slv4_aw_mid;
input              slv4_awready;
input [64:0]	slv4_masked_base_addr;
input [64:0]	slv4_addr_mask;
output		slv4_awvalid;
input              slv4_connect;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
input [3:0]        slv5_aw_mid;
input              slv5_awready;
input [64:0]	slv5_masked_base_addr;
input [64:0]	slv5_addr_mask;
output		slv5_awvalid;
input              slv5_connect;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
input [3:0]        slv6_aw_mid;
input              slv6_awready;
input [64:0]	slv6_masked_base_addr;
input [64:0]	slv6_addr_mask;
output		slv6_awvalid;
input              slv6_connect;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
input [3:0]        slv7_aw_mid;
input              slv7_awready;
input [64:0]	slv7_masked_base_addr;
input [64:0]	slv7_addr_mask;
output		slv7_awvalid;
input              slv7_connect;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
input [3:0]        slv8_aw_mid;
input              slv8_awready;
input [64:0]	slv8_masked_base_addr;
input [64:0]	slv8_addr_mask;
output		slv8_awvalid;
input              slv8_connect;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
input [3:0]        slv9_aw_mid;
input              slv9_awready;
input [64:0]	slv9_masked_base_addr;
input [64:0]	slv9_addr_mask;
output		slv9_awvalid;
input              slv9_connect;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
input [3:0]        slv10_aw_mid;
input              slv10_awready;
input [64:0]	slv10_masked_base_addr;
input [64:0]	slv10_addr_mask;
output		slv10_awvalid;
input              slv10_connect;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
input [3:0]        slv11_aw_mid;
input              slv11_awready;
input [64:0]	slv11_masked_base_addr;
input [64:0]	slv11_addr_mask;
output		slv11_awvalid;
input              slv11_connect;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
input [3:0]        slv12_aw_mid;
input              slv12_awready;
input [64:0]	slv12_masked_base_addr;
input [64:0]	slv12_addr_mask;
output		slv12_awvalid;
input              slv12_connect;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
input [3:0]        slv13_aw_mid;
input              slv13_awready;
input [64:0]	slv13_masked_base_addr;
input [64:0]	slv13_addr_mask;
output		slv13_awvalid;
input              slv13_connect;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
input [3:0]        slv14_aw_mid;
input              slv14_awready;
input [64:0]	slv14_masked_base_addr;
input [64:0]	slv14_addr_mask;
output		slv14_awvalid;
input              slv14_connect;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
input [3:0]        slv15_aw_mid;
input              slv15_awready;
input [64:0]	slv15_masked_base_addr;
input [64:0]	slv15_addr_mask;
output		slv15_awvalid;
input              slv15_connect;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
input [3:0]        slv16_aw_mid;
input              slv16_awready;
input [64:0]	slv16_masked_base_addr;
input [64:0]	slv16_addr_mask;
output		slv16_awvalid;
input              slv16_connect;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
input [3:0]        slv17_aw_mid;
input              slv17_awready;
input [64:0]	slv17_masked_base_addr;
input [64:0]	slv17_addr_mask;
output		slv17_awvalid;
input              slv17_connect;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
input [3:0]        slv18_aw_mid;
input              slv18_awready;
input [64:0]	slv18_masked_base_addr;
input [64:0]	slv18_addr_mask;
output		slv18_awvalid;
input              slv18_connect;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
input [3:0]        slv19_aw_mid;
input              slv19_awready;
input [64:0]	slv19_masked_base_addr;
input [64:0]	slv19_addr_mask;
output		slv19_awvalid;
input              slv19_connect;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
input [3:0]        slv20_aw_mid;
input              slv20_awready;
input [64:0]	slv20_masked_base_addr;
input [64:0]	slv20_addr_mask;
output		slv20_awvalid;
input              slv20_connect;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
input [3:0]        slv21_aw_mid;
input              slv21_awready;
input [64:0]	slv21_masked_base_addr;
input [64:0]	slv21_addr_mask;
output		slv21_awvalid;
input              slv21_connect;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
input [3:0]        slv22_aw_mid;
input              slv22_awready;
input [64:0]	slv22_masked_base_addr;
input [64:0]	slv22_addr_mask;
output		slv22_awvalid;
input              slv22_connect;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
input [3:0]        slv23_aw_mid;
input              slv23_awready;
input [64:0]	slv23_masked_base_addr;
input [64:0]	slv23_addr_mask;
output		slv23_awvalid;
input              slv23_connect;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
input [3:0]        slv24_aw_mid;
input              slv24_awready;
input [64:0]	slv24_masked_base_addr;
input [64:0]	slv24_addr_mask;
output		slv24_awvalid;
input              slv24_connect;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
input [3:0]        slv25_aw_mid;
input              slv25_awready;
input [64:0]	slv25_masked_base_addr;
input [64:0]	slv25_addr_mask;
output		slv25_awvalid;
input              slv25_connect;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
input [3:0]        slv26_aw_mid;
input              slv26_awready;
input [64:0]	slv26_masked_base_addr;
input [64:0]	slv26_addr_mask;
output		slv26_awvalid;
input              slv26_connect;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
input [3:0]        slv27_aw_mid;
input              slv27_awready;
input [64:0]	slv27_masked_base_addr;
input [64:0]	slv27_addr_mask;
output		slv27_awvalid;
input              slv27_connect;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
input [3:0]        slv28_aw_mid;
input              slv28_awready;
input [64:0]	slv28_masked_base_addr;
input [64:0]	slv28_addr_mask;
output		slv28_awvalid;
input              slv28_connect;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
input [3:0]        slv29_aw_mid;
input              slv29_awready;
input [64:0]	slv29_masked_base_addr;
input [64:0]	slv29_addr_mask;
output		slv29_awvalid;
input              slv29_connect;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
input [3:0]        slv30_aw_mid;
input              slv30_awready;
input [64:0]	slv30_masked_base_addr;
input [64:0]	slv30_addr_mask;
output		slv30_awvalid;
input              slv30_connect;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
input [3:0]        slv31_aw_mid;
input              slv31_awready;
input [64:0]	slv31_masked_base_addr;
input [64:0]	slv31_addr_mask;
output		slv31_awvalid;
input              slv31_connect;
`endif
//# VPERL_GENERATED_END
input [ADDR_MSB:0] us_awaddr;
input [7:0]        us_awlen;
input [2:0]        us_awsize;
input [1:0]        us_awburst;
input 	           us_awlock;
input [3:0]        us_awcache;
input [2:0]        us_awprot;
input [ID_MSB:0]   us_awid;       
input              us_awvalid;
output             us_awready;

output [ADDR_MSB:0] mst_awaddr;
output [7:0]        mst_awlen;
output [2:0]        mst_awsize;
output [1:0]        mst_awburst;
output 	            mst_awlock;
output [3:0]        mst_awcache;
output [2:0]        mst_awprot;
output [ID_MSB:0]   mst_awid;       
output 		    dec_err_wready;
output 		    dec_err_bvalid;
input		    dec_err_wvalid;
input		    dec_err_wlast;
input 		    dec_err_bready;
//input  [3:0]	    def_slave_amid;
output [OUTSTAND_ID_MSB:0]  	    aw_outstanding_id;
output [1:0] dec_err_bresp;
output [ID_MSB:0] dec_err_bid;
output 		    aw_addr_outstanding_en;
input		    aw_outstanding_ready;
input     	    wd_outstanding_idle;
input     	    br_outstanding_idle;
input       	    master_arlock;
input        	    master_arvalid;
input  [ID_MSB:0]   master_arid;
input 		    mst_arlocking;
input  [ID_MSB:0]   locking_arid;
input  [ID_MSB:0]   us_bid;
input               us_bvalid;
input               us_bready;
output 		    mst_awlocking;
output [ID_MSB:0]   locking_awid;
input aclk;
input aresetn;

reg [ADDR_MSB:0] pending_awaddr;
reg [7:0]        pending_awlen;
reg [2:0]        pending_awsize;
reg [1:0]        pending_awburst;
reg 	         pending_awlock;
reg [3:0]        pending_awcache;
reg [2:0]        pending_awprot;
reg [ID_MSB:0]   pending_awid;
reg              pending_awvalid;
reg [ADDR_MSB:0] mst_awaddr;
reg [7:0]        mst_awlen;
reg [2:0]        mst_awsize;
reg [1:0]        mst_awburst;
reg 	         mst_awlock;
reg [3:0]        mst_awcache;
reg [2:0]        mst_awprot;
reg [ID_MSB:0]   mst_awid;       
wire [31:0]      mst_awvalid;
reg 		 dec_err_wready;
reg 		 dec_err_bvalid;
reg 		 mst_awlocking;
reg [ID_MSB:0]   locking_awid;
wire [ADDR_MSB:0] master_awaddr;
wire [ID_MSB:0] master_awid;
wire        master_awvalid;
wire        master_awlock;
wire [31:0] slave_awready;
wire [31:0] slave_hit;
wire [31:0] slave_pre_hit;
wire        master_awready;
wire        data_channel_ready;
wire        write_exclusive_blocking;
wire [4:0]  slave_sel_id;
wire	    dec_err_sel;

generate
	if (RESP_INORDER_ONLY==1) begin:only_slave_id
		assign aw_outstanding_id = slave_sel_id;
	end else begin:include_awid
		assign aw_outstanding_id = {master_awid,slave_sel_id};
	end
endgenerate

assign slave_sel_id[4] =  |slave_hit[31:16];
assign slave_sel_id[3] = |{slave_hit[31:24],slave_hit[15:08]};
assign slave_sel_id[2] = |{slave_hit[31:28],slave_hit[23:20],
     	          	   slave_hit[15:12],slave_hit[07:04]};
assign slave_sel_id[1] = |{slave_hit[31:30],slave_hit[27:26],
                           slave_hit[23:22],slave_hit[19:18], 
                           slave_hit[15:14],slave_hit[11:10], 
                           slave_hit[07:06],slave_hit[03:02]};
assign slave_sel_id[0] = |{slave_hit[31],slave_hit[29],slave_hit[27],slave_hit[25],
                           slave_hit[23],slave_hit[21],slave_hit[19],slave_hit[17], 
                           slave_hit[15],slave_hit[13],slave_hit[11],slave_hit[09], 
                           slave_hit[07],slave_hit[05],slave_hit[03],slave_hit[01]};
assign dec_err_sel = master_awvalid & (~|slave_hit);
assign aw_addr_outstanding_en = (|slave_hit) & master_awready;

// VPERL_BEGIN
//  for ($i=0;$i<32;$i++) {
// :`ifdef ATCBMC300_SLV${i}_SUPPORT
// : reg slv${i}_awvalid;
// :always @(posedge aclk or negedge aresetn) begin
// :	if (!aresetn)
// :		slv${i}_awvalid <= 1'b0;
// :	else 
// :		slv${i}_awvalid <= master_awready ? slave_hit[${i}] : (slv${i}_awvalid & ~slave_awready[${i}]);
// :end
// :
// :	assign mst_awvalid[${i}] = slv${i}_awvalid;
// :	assign slave_pre_hit[${i}] = master_awvalid & slv${i}_connect & (slv${i}_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv${i}_addr_mask));
// :	`ifdef ATCBMC300_PRIORITY_DECODE
//		if ($i == 0) {
// :		assign slave_hit[${i}] = slave_pre_hit[${i}];
//		} elsif ($i == 1) {
// :		assign slave_hit[${i}] = slave_pre_hit[${i}] & (~slave_pre_hit[0]);
//		} else {
// :		assign slave_hit[${i}] = slave_pre_hit[${i}] & (~(|slave_pre_hit[%d:0]));	:: $i-1 
//		}
// :	`else
// :		assign slave_hit[${i}] = slave_pre_hit[${i}];
// :	`endif // ATCBMC300_PRIORITY_DECODE
// :	assign slave_awready[${i}] = (slv${i}_aw_mid==self_id) & slv${i}_awready & slv${i}_connect;
// :`else 
// : 	assign slave_hit[${i}] = 1'b0;
// : 	assign slave_pre_hit[${i}] = 1'b0;
// :	assign slave_awready[${i}] = 1'b0;
// :	assign mst_awvalid[${i}] = 1'b0;
// :`endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_SLV0_SUPPORT
reg slv0_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv0_awvalid <= 1'b0;
	else
		slv0_awvalid <= master_awready ? slave_hit[0] : (slv0_awvalid & ~slave_awready[0]);
end

	assign mst_awvalid[0] = slv0_awvalid;
	assign slave_pre_hit[0] = master_awvalid & slv0_connect & (slv0_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv0_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[0] = slave_pre_hit[0];
	`else
		assign slave_hit[0] = slave_pre_hit[0];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[0] = (slv0_aw_mid==self_id) & slv0_awready & slv0_connect;
`else
	assign slave_hit[0] = 1'b0;
	assign slave_pre_hit[0] = 1'b0;
	assign slave_awready[0] = 1'b0;
	assign mst_awvalid[0] = 1'b0;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
reg slv1_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv1_awvalid <= 1'b0;
	else
		slv1_awvalid <= master_awready ? slave_hit[1] : (slv1_awvalid & ~slave_awready[1]);
end

	assign mst_awvalid[1] = slv1_awvalid;
	assign slave_pre_hit[1] = master_awvalid & slv1_connect & (slv1_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv1_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[1] = slave_pre_hit[1] & (~slave_pre_hit[0]);
	`else
		assign slave_hit[1] = slave_pre_hit[1];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[1] = (slv1_aw_mid==self_id) & slv1_awready & slv1_connect;
`else
	assign slave_hit[1] = 1'b0;
	assign slave_pre_hit[1] = 1'b0;
	assign slave_awready[1] = 1'b0;
	assign mst_awvalid[1] = 1'b0;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
reg slv2_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv2_awvalid <= 1'b0;
	else
		slv2_awvalid <= master_awready ? slave_hit[2] : (slv2_awvalid & ~slave_awready[2]);
end

	assign mst_awvalid[2] = slv2_awvalid;
	assign slave_pre_hit[2] = master_awvalid & slv2_connect & (slv2_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv2_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[2] = slave_pre_hit[2] & (~(|slave_pre_hit[1:0]));
	`else
		assign slave_hit[2] = slave_pre_hit[2];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[2] = (slv2_aw_mid==self_id) & slv2_awready & slv2_connect;
`else
	assign slave_hit[2] = 1'b0;
	assign slave_pre_hit[2] = 1'b0;
	assign slave_awready[2] = 1'b0;
	assign mst_awvalid[2] = 1'b0;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
reg slv3_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv3_awvalid <= 1'b0;
	else
		slv3_awvalid <= master_awready ? slave_hit[3] : (slv3_awvalid & ~slave_awready[3]);
end

	assign mst_awvalid[3] = slv3_awvalid;
	assign slave_pre_hit[3] = master_awvalid & slv3_connect & (slv3_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv3_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[3] = slave_pre_hit[3] & (~(|slave_pre_hit[2:0]));
	`else
		assign slave_hit[3] = slave_pre_hit[3];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[3] = (slv3_aw_mid==self_id) & slv3_awready & slv3_connect;
`else
	assign slave_hit[3] = 1'b0;
	assign slave_pre_hit[3] = 1'b0;
	assign slave_awready[3] = 1'b0;
	assign mst_awvalid[3] = 1'b0;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
reg slv4_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv4_awvalid <= 1'b0;
	else
		slv4_awvalid <= master_awready ? slave_hit[4] : (slv4_awvalid & ~slave_awready[4]);
end

	assign mst_awvalid[4] = slv4_awvalid;
	assign slave_pre_hit[4] = master_awvalid & slv4_connect & (slv4_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv4_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[4] = slave_pre_hit[4] & (~(|slave_pre_hit[3:0]));
	`else
		assign slave_hit[4] = slave_pre_hit[4];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[4] = (slv4_aw_mid==self_id) & slv4_awready & slv4_connect;
`else
	assign slave_hit[4] = 1'b0;
	assign slave_pre_hit[4] = 1'b0;
	assign slave_awready[4] = 1'b0;
	assign mst_awvalid[4] = 1'b0;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
reg slv5_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv5_awvalid <= 1'b0;
	else
		slv5_awvalid <= master_awready ? slave_hit[5] : (slv5_awvalid & ~slave_awready[5]);
end

	assign mst_awvalid[5] = slv5_awvalid;
	assign slave_pre_hit[5] = master_awvalid & slv5_connect & (slv5_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv5_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[5] = slave_pre_hit[5] & (~(|slave_pre_hit[4:0]));
	`else
		assign slave_hit[5] = slave_pre_hit[5];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[5] = (slv5_aw_mid==self_id) & slv5_awready & slv5_connect;
`else
	assign slave_hit[5] = 1'b0;
	assign slave_pre_hit[5] = 1'b0;
	assign slave_awready[5] = 1'b0;
	assign mst_awvalid[5] = 1'b0;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
reg slv6_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv6_awvalid <= 1'b0;
	else
		slv6_awvalid <= master_awready ? slave_hit[6] : (slv6_awvalid & ~slave_awready[6]);
end

	assign mst_awvalid[6] = slv6_awvalid;
	assign slave_pre_hit[6] = master_awvalid & slv6_connect & (slv6_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv6_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[6] = slave_pre_hit[6] & (~(|slave_pre_hit[5:0]));
	`else
		assign slave_hit[6] = slave_pre_hit[6];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[6] = (slv6_aw_mid==self_id) & slv6_awready & slv6_connect;
`else
	assign slave_hit[6] = 1'b0;
	assign slave_pre_hit[6] = 1'b0;
	assign slave_awready[6] = 1'b0;
	assign mst_awvalid[6] = 1'b0;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
reg slv7_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv7_awvalid <= 1'b0;
	else
		slv7_awvalid <= master_awready ? slave_hit[7] : (slv7_awvalid & ~slave_awready[7]);
end

	assign mst_awvalid[7] = slv7_awvalid;
	assign slave_pre_hit[7] = master_awvalid & slv7_connect & (slv7_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv7_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[7] = slave_pre_hit[7] & (~(|slave_pre_hit[6:0]));
	`else
		assign slave_hit[7] = slave_pre_hit[7];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[7] = (slv7_aw_mid==self_id) & slv7_awready & slv7_connect;
`else
	assign slave_hit[7] = 1'b0;
	assign slave_pre_hit[7] = 1'b0;
	assign slave_awready[7] = 1'b0;
	assign mst_awvalid[7] = 1'b0;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
reg slv8_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv8_awvalid <= 1'b0;
	else
		slv8_awvalid <= master_awready ? slave_hit[8] : (slv8_awvalid & ~slave_awready[8]);
end

	assign mst_awvalid[8] = slv8_awvalid;
	assign slave_pre_hit[8] = master_awvalid & slv8_connect & (slv8_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv8_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[8] = slave_pre_hit[8] & (~(|slave_pre_hit[7:0]));
	`else
		assign slave_hit[8] = slave_pre_hit[8];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[8] = (slv8_aw_mid==self_id) & slv8_awready & slv8_connect;
`else
	assign slave_hit[8] = 1'b0;
	assign slave_pre_hit[8] = 1'b0;
	assign slave_awready[8] = 1'b0;
	assign mst_awvalid[8] = 1'b0;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
reg slv9_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv9_awvalid <= 1'b0;
	else
		slv9_awvalid <= master_awready ? slave_hit[9] : (slv9_awvalid & ~slave_awready[9]);
end

	assign mst_awvalid[9] = slv9_awvalid;
	assign slave_pre_hit[9] = master_awvalid & slv9_connect & (slv9_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv9_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[9] = slave_pre_hit[9] & (~(|slave_pre_hit[8:0]));
	`else
		assign slave_hit[9] = slave_pre_hit[9];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[9] = (slv9_aw_mid==self_id) & slv9_awready & slv9_connect;
`else
	assign slave_hit[9] = 1'b0;
	assign slave_pre_hit[9] = 1'b0;
	assign slave_awready[9] = 1'b0;
	assign mst_awvalid[9] = 1'b0;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
reg slv10_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv10_awvalid <= 1'b0;
	else
		slv10_awvalid <= master_awready ? slave_hit[10] : (slv10_awvalid & ~slave_awready[10]);
end

	assign mst_awvalid[10] = slv10_awvalid;
	assign slave_pre_hit[10] = master_awvalid & slv10_connect & (slv10_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv10_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[10] = slave_pre_hit[10] & (~(|slave_pre_hit[9:0]));
	`else
		assign slave_hit[10] = slave_pre_hit[10];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[10] = (slv10_aw_mid==self_id) & slv10_awready & slv10_connect;
`else
	assign slave_hit[10] = 1'b0;
	assign slave_pre_hit[10] = 1'b0;
	assign slave_awready[10] = 1'b0;
	assign mst_awvalid[10] = 1'b0;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
reg slv11_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv11_awvalid <= 1'b0;
	else
		slv11_awvalid <= master_awready ? slave_hit[11] : (slv11_awvalid & ~slave_awready[11]);
end

	assign mst_awvalid[11] = slv11_awvalid;
	assign slave_pre_hit[11] = master_awvalid & slv11_connect & (slv11_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv11_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[11] = slave_pre_hit[11] & (~(|slave_pre_hit[10:0]));
	`else
		assign slave_hit[11] = slave_pre_hit[11];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[11] = (slv11_aw_mid==self_id) & slv11_awready & slv11_connect;
`else
	assign slave_hit[11] = 1'b0;
	assign slave_pre_hit[11] = 1'b0;
	assign slave_awready[11] = 1'b0;
	assign mst_awvalid[11] = 1'b0;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
reg slv12_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv12_awvalid <= 1'b0;
	else
		slv12_awvalid <= master_awready ? slave_hit[12] : (slv12_awvalid & ~slave_awready[12]);
end

	assign mst_awvalid[12] = slv12_awvalid;
	assign slave_pre_hit[12] = master_awvalid & slv12_connect & (slv12_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv12_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[12] = slave_pre_hit[12] & (~(|slave_pre_hit[11:0]));
	`else
		assign slave_hit[12] = slave_pre_hit[12];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[12] = (slv12_aw_mid==self_id) & slv12_awready & slv12_connect;
`else
	assign slave_hit[12] = 1'b0;
	assign slave_pre_hit[12] = 1'b0;
	assign slave_awready[12] = 1'b0;
	assign mst_awvalid[12] = 1'b0;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
reg slv13_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv13_awvalid <= 1'b0;
	else
		slv13_awvalid <= master_awready ? slave_hit[13] : (slv13_awvalid & ~slave_awready[13]);
end

	assign mst_awvalid[13] = slv13_awvalid;
	assign slave_pre_hit[13] = master_awvalid & slv13_connect & (slv13_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv13_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[13] = slave_pre_hit[13] & (~(|slave_pre_hit[12:0]));
	`else
		assign slave_hit[13] = slave_pre_hit[13];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[13] = (slv13_aw_mid==self_id) & slv13_awready & slv13_connect;
`else
	assign slave_hit[13] = 1'b0;
	assign slave_pre_hit[13] = 1'b0;
	assign slave_awready[13] = 1'b0;
	assign mst_awvalid[13] = 1'b0;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
reg slv14_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv14_awvalid <= 1'b0;
	else
		slv14_awvalid <= master_awready ? slave_hit[14] : (slv14_awvalid & ~slave_awready[14]);
end

	assign mst_awvalid[14] = slv14_awvalid;
	assign slave_pre_hit[14] = master_awvalid & slv14_connect & (slv14_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv14_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[14] = slave_pre_hit[14] & (~(|slave_pre_hit[13:0]));
	`else
		assign slave_hit[14] = slave_pre_hit[14];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[14] = (slv14_aw_mid==self_id) & slv14_awready & slv14_connect;
`else
	assign slave_hit[14] = 1'b0;
	assign slave_pre_hit[14] = 1'b0;
	assign slave_awready[14] = 1'b0;
	assign mst_awvalid[14] = 1'b0;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
reg slv15_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv15_awvalid <= 1'b0;
	else
		slv15_awvalid <= master_awready ? slave_hit[15] : (slv15_awvalid & ~slave_awready[15]);
end

	assign mst_awvalid[15] = slv15_awvalid;
	assign slave_pre_hit[15] = master_awvalid & slv15_connect & (slv15_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv15_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[15] = slave_pre_hit[15] & (~(|slave_pre_hit[14:0]));
	`else
		assign slave_hit[15] = slave_pre_hit[15];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[15] = (slv15_aw_mid==self_id) & slv15_awready & slv15_connect;
`else
	assign slave_hit[15] = 1'b0;
	assign slave_pre_hit[15] = 1'b0;
	assign slave_awready[15] = 1'b0;
	assign mst_awvalid[15] = 1'b0;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
reg slv16_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv16_awvalid <= 1'b0;
	else
		slv16_awvalid <= master_awready ? slave_hit[16] : (slv16_awvalid & ~slave_awready[16]);
end

	assign mst_awvalid[16] = slv16_awvalid;
	assign slave_pre_hit[16] = master_awvalid & slv16_connect & (slv16_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv16_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[16] = slave_pre_hit[16] & (~(|slave_pre_hit[15:0]));
	`else
		assign slave_hit[16] = slave_pre_hit[16];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[16] = (slv16_aw_mid==self_id) & slv16_awready & slv16_connect;
`else
	assign slave_hit[16] = 1'b0;
	assign slave_pre_hit[16] = 1'b0;
	assign slave_awready[16] = 1'b0;
	assign mst_awvalid[16] = 1'b0;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
reg slv17_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv17_awvalid <= 1'b0;
	else
		slv17_awvalid <= master_awready ? slave_hit[17] : (slv17_awvalid & ~slave_awready[17]);
end

	assign mst_awvalid[17] = slv17_awvalid;
	assign slave_pre_hit[17] = master_awvalid & slv17_connect & (slv17_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv17_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[17] = slave_pre_hit[17] & (~(|slave_pre_hit[16:0]));
	`else
		assign slave_hit[17] = slave_pre_hit[17];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[17] = (slv17_aw_mid==self_id) & slv17_awready & slv17_connect;
`else
	assign slave_hit[17] = 1'b0;
	assign slave_pre_hit[17] = 1'b0;
	assign slave_awready[17] = 1'b0;
	assign mst_awvalid[17] = 1'b0;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
reg slv18_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv18_awvalid <= 1'b0;
	else
		slv18_awvalid <= master_awready ? slave_hit[18] : (slv18_awvalid & ~slave_awready[18]);
end

	assign mst_awvalid[18] = slv18_awvalid;
	assign slave_pre_hit[18] = master_awvalid & slv18_connect & (slv18_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv18_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[18] = slave_pre_hit[18] & (~(|slave_pre_hit[17:0]));
	`else
		assign slave_hit[18] = slave_pre_hit[18];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[18] = (slv18_aw_mid==self_id) & slv18_awready & slv18_connect;
`else
	assign slave_hit[18] = 1'b0;
	assign slave_pre_hit[18] = 1'b0;
	assign slave_awready[18] = 1'b0;
	assign mst_awvalid[18] = 1'b0;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
reg slv19_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv19_awvalid <= 1'b0;
	else
		slv19_awvalid <= master_awready ? slave_hit[19] : (slv19_awvalid & ~slave_awready[19]);
end

	assign mst_awvalid[19] = slv19_awvalid;
	assign slave_pre_hit[19] = master_awvalid & slv19_connect & (slv19_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv19_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[19] = slave_pre_hit[19] & (~(|slave_pre_hit[18:0]));
	`else
		assign slave_hit[19] = slave_pre_hit[19];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[19] = (slv19_aw_mid==self_id) & slv19_awready & slv19_connect;
`else
	assign slave_hit[19] = 1'b0;
	assign slave_pre_hit[19] = 1'b0;
	assign slave_awready[19] = 1'b0;
	assign mst_awvalid[19] = 1'b0;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
reg slv20_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv20_awvalid <= 1'b0;
	else
		slv20_awvalid <= master_awready ? slave_hit[20] : (slv20_awvalid & ~slave_awready[20]);
end

	assign mst_awvalid[20] = slv20_awvalid;
	assign slave_pre_hit[20] = master_awvalid & slv20_connect & (slv20_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv20_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[20] = slave_pre_hit[20] & (~(|slave_pre_hit[19:0]));
	`else
		assign slave_hit[20] = slave_pre_hit[20];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[20] = (slv20_aw_mid==self_id) & slv20_awready & slv20_connect;
`else
	assign slave_hit[20] = 1'b0;
	assign slave_pre_hit[20] = 1'b0;
	assign slave_awready[20] = 1'b0;
	assign mst_awvalid[20] = 1'b0;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
reg slv21_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv21_awvalid <= 1'b0;
	else
		slv21_awvalid <= master_awready ? slave_hit[21] : (slv21_awvalid & ~slave_awready[21]);
end

	assign mst_awvalid[21] = slv21_awvalid;
	assign slave_pre_hit[21] = master_awvalid & slv21_connect & (slv21_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv21_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[21] = slave_pre_hit[21] & (~(|slave_pre_hit[20:0]));
	`else
		assign slave_hit[21] = slave_pre_hit[21];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[21] = (slv21_aw_mid==self_id) & slv21_awready & slv21_connect;
`else
	assign slave_hit[21] = 1'b0;
	assign slave_pre_hit[21] = 1'b0;
	assign slave_awready[21] = 1'b0;
	assign mst_awvalid[21] = 1'b0;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
reg slv22_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv22_awvalid <= 1'b0;
	else
		slv22_awvalid <= master_awready ? slave_hit[22] : (slv22_awvalid & ~slave_awready[22]);
end

	assign mst_awvalid[22] = slv22_awvalid;
	assign slave_pre_hit[22] = master_awvalid & slv22_connect & (slv22_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv22_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[22] = slave_pre_hit[22] & (~(|slave_pre_hit[21:0]));
	`else
		assign slave_hit[22] = slave_pre_hit[22];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[22] = (slv22_aw_mid==self_id) & slv22_awready & slv22_connect;
`else
	assign slave_hit[22] = 1'b0;
	assign slave_pre_hit[22] = 1'b0;
	assign slave_awready[22] = 1'b0;
	assign mst_awvalid[22] = 1'b0;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
reg slv23_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv23_awvalid <= 1'b0;
	else
		slv23_awvalid <= master_awready ? slave_hit[23] : (slv23_awvalid & ~slave_awready[23]);
end

	assign mst_awvalid[23] = slv23_awvalid;
	assign slave_pre_hit[23] = master_awvalid & slv23_connect & (slv23_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv23_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[23] = slave_pre_hit[23] & (~(|slave_pre_hit[22:0]));
	`else
		assign slave_hit[23] = slave_pre_hit[23];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[23] = (slv23_aw_mid==self_id) & slv23_awready & slv23_connect;
`else
	assign slave_hit[23] = 1'b0;
	assign slave_pre_hit[23] = 1'b0;
	assign slave_awready[23] = 1'b0;
	assign mst_awvalid[23] = 1'b0;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
reg slv24_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv24_awvalid <= 1'b0;
	else
		slv24_awvalid <= master_awready ? slave_hit[24] : (slv24_awvalid & ~slave_awready[24]);
end

	assign mst_awvalid[24] = slv24_awvalid;
	assign slave_pre_hit[24] = master_awvalid & slv24_connect & (slv24_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv24_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[24] = slave_pre_hit[24] & (~(|slave_pre_hit[23:0]));
	`else
		assign slave_hit[24] = slave_pre_hit[24];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[24] = (slv24_aw_mid==self_id) & slv24_awready & slv24_connect;
`else
	assign slave_hit[24] = 1'b0;
	assign slave_pre_hit[24] = 1'b0;
	assign slave_awready[24] = 1'b0;
	assign mst_awvalid[24] = 1'b0;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
reg slv25_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv25_awvalid <= 1'b0;
	else
		slv25_awvalid <= master_awready ? slave_hit[25] : (slv25_awvalid & ~slave_awready[25]);
end

	assign mst_awvalid[25] = slv25_awvalid;
	assign slave_pre_hit[25] = master_awvalid & slv25_connect & (slv25_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv25_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[25] = slave_pre_hit[25] & (~(|slave_pre_hit[24:0]));
	`else
		assign slave_hit[25] = slave_pre_hit[25];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[25] = (slv25_aw_mid==self_id) & slv25_awready & slv25_connect;
`else
	assign slave_hit[25] = 1'b0;
	assign slave_pre_hit[25] = 1'b0;
	assign slave_awready[25] = 1'b0;
	assign mst_awvalid[25] = 1'b0;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
reg slv26_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv26_awvalid <= 1'b0;
	else
		slv26_awvalid <= master_awready ? slave_hit[26] : (slv26_awvalid & ~slave_awready[26]);
end

	assign mst_awvalid[26] = slv26_awvalid;
	assign slave_pre_hit[26] = master_awvalid & slv26_connect & (slv26_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv26_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[26] = slave_pre_hit[26] & (~(|slave_pre_hit[25:0]));
	`else
		assign slave_hit[26] = slave_pre_hit[26];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[26] = (slv26_aw_mid==self_id) & slv26_awready & slv26_connect;
`else
	assign slave_hit[26] = 1'b0;
	assign slave_pre_hit[26] = 1'b0;
	assign slave_awready[26] = 1'b0;
	assign mst_awvalid[26] = 1'b0;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
reg slv27_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv27_awvalid <= 1'b0;
	else
		slv27_awvalid <= master_awready ? slave_hit[27] : (slv27_awvalid & ~slave_awready[27]);
end

	assign mst_awvalid[27] = slv27_awvalid;
	assign slave_pre_hit[27] = master_awvalid & slv27_connect & (slv27_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv27_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[27] = slave_pre_hit[27] & (~(|slave_pre_hit[26:0]));
	`else
		assign slave_hit[27] = slave_pre_hit[27];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[27] = (slv27_aw_mid==self_id) & slv27_awready & slv27_connect;
`else
	assign slave_hit[27] = 1'b0;
	assign slave_pre_hit[27] = 1'b0;
	assign slave_awready[27] = 1'b0;
	assign mst_awvalid[27] = 1'b0;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
reg slv28_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv28_awvalid <= 1'b0;
	else
		slv28_awvalid <= master_awready ? slave_hit[28] : (slv28_awvalid & ~slave_awready[28]);
end

	assign mst_awvalid[28] = slv28_awvalid;
	assign slave_pre_hit[28] = master_awvalid & slv28_connect & (slv28_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv28_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[28] = slave_pre_hit[28] & (~(|slave_pre_hit[27:0]));
	`else
		assign slave_hit[28] = slave_pre_hit[28];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[28] = (slv28_aw_mid==self_id) & slv28_awready & slv28_connect;
`else
	assign slave_hit[28] = 1'b0;
	assign slave_pre_hit[28] = 1'b0;
	assign slave_awready[28] = 1'b0;
	assign mst_awvalid[28] = 1'b0;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
reg slv29_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv29_awvalid <= 1'b0;
	else
		slv29_awvalid <= master_awready ? slave_hit[29] : (slv29_awvalid & ~slave_awready[29]);
end

	assign mst_awvalid[29] = slv29_awvalid;
	assign slave_pre_hit[29] = master_awvalid & slv29_connect & (slv29_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv29_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[29] = slave_pre_hit[29] & (~(|slave_pre_hit[28:0]));
	`else
		assign slave_hit[29] = slave_pre_hit[29];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[29] = (slv29_aw_mid==self_id) & slv29_awready & slv29_connect;
`else
	assign slave_hit[29] = 1'b0;
	assign slave_pre_hit[29] = 1'b0;
	assign slave_awready[29] = 1'b0;
	assign mst_awvalid[29] = 1'b0;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
reg slv30_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv30_awvalid <= 1'b0;
	else
		slv30_awvalid <= master_awready ? slave_hit[30] : (slv30_awvalid & ~slave_awready[30]);
end

	assign mst_awvalid[30] = slv30_awvalid;
	assign slave_pre_hit[30] = master_awvalid & slv30_connect & (slv30_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv30_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[30] = slave_pre_hit[30] & (~(|slave_pre_hit[29:0]));
	`else
		assign slave_hit[30] = slave_pre_hit[30];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[30] = (slv30_aw_mid==self_id) & slv30_awready & slv30_connect;
`else
	assign slave_hit[30] = 1'b0;
	assign slave_pre_hit[30] = 1'b0;
	assign slave_awready[30] = 1'b0;
	assign mst_awvalid[30] = 1'b0;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
reg slv31_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv31_awvalid <= 1'b0;
	else
		slv31_awvalid <= master_awready ? slave_hit[31] : (slv31_awvalid & ~slave_awready[31]);
end

	assign mst_awvalid[31] = slv31_awvalid;
	assign slave_pre_hit[31] = master_awvalid & slv31_connect & (slv31_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},master_awaddr} & slv31_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign slave_hit[31] = slave_pre_hit[31] & (~(|slave_pre_hit[30:0]));
	`else
		assign slave_hit[31] = slave_pre_hit[31];
	`endif // ATCBMC300_PRIORITY_DECODE
	assign slave_awready[31] = (slv31_aw_mid==self_id) & slv31_awready & slv31_connect;
`else
	assign slave_hit[31] = 1'b0;
	assign slave_pre_hit[31] = 1'b0;
	assign slave_awready[31] = 1'b0;
	assign mst_awvalid[31] = 1'b0;
`endif
// VPERL_GENERATED_END
assign us_awready = ~pending_awvalid;
assign master_awvalid = pending_awvalid | us_awvalid;
assign master_awaddr  = pending_awvalid ? pending_awaddr : us_awaddr;
assign master_awid    = pending_awvalid ? pending_awid   : us_awid;
assign master_awlock  = pending_awvalid ? pending_awlock : us_awlock ;
assign master_awready = ~|(mst_awvalid & ~slave_awready) & data_channel_ready & ~write_exclusive_blocking;
assign data_channel_ready = ~dec_err_wready & ~dec_err_bvalid & (dec_err_sel ? (wd_outstanding_idle & br_outstanding_idle) : aw_outstanding_ready);
assign write_exclusive_blocking = (master_awlock &  
                          	   (~(br_outstanding_idle & ~us_bvalid & wd_outstanding_idle) | //No store outstanding before receiving store exclusive (SE) address
                                    (master_arvalid & master_arlock & (master_arid==master_awid)) | // Blocking SE address if the read exclusive(RE) which is same ID is receiving 
                                     (mst_arlocking & (locking_arid==master_awid)))); //  Blocking SE address when the SE which is same ID is outstanding 
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		pending_awvalid <= 1'b0;
	else 
		pending_awvalid <= master_awvalid & ~master_awready;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		pending_awaddr  <= {ADDR_WIDTH{1'b0}}; 
		pending_awlen   <= 8'b0;
		pending_awsize  <= 3'b0;
		pending_awburst <= 2'b0;
		pending_awcache <= 4'b0;
		pending_awlock  <= 1'b0;
		pending_awprot  <= 3'b0;
		pending_awid   <= {ID_WIDTH{1'b0}};
	end else if (us_awvalid && !master_awready && !pending_awvalid) begin
		pending_awaddr  <=  us_awaddr ;
		pending_awlen   <=  us_awlen  ;
		pending_awsize  <=  us_awsize ;
		pending_awburst <=  us_awburst;
		pending_awcache <=  us_awcache;
		pending_awlock  <=  us_awlock ;
		pending_awprot  <=  us_awprot ;
		pending_awid    <=  us_awid  ;
	end	
end
 
always @(posedge aclk or negedge aresetn) begin
  if (!aresetn) begin
	mst_awaddr  <= {ADDR_WIDTH{1'b0}}; 
	mst_awlen   <= 8'b0;
	mst_awsize  <= 3'b0;
	mst_awburst <= 2'b0;
	mst_awcache <= 4'b0;
	mst_awlock  <= 1'b0;
	mst_awprot  <= 3'b0;
	mst_awid   <= {ID_WIDTH{1'b0}};
  end else if (master_awvalid & master_awready) begin
	mst_awaddr  <=  master_awaddr ;
	mst_awlen   <=  pending_awvalid ? pending_awlen   : us_awlen  ;
	mst_awsize  <=  pending_awvalid ? pending_awsize  : us_awsize ;
	mst_awburst <=  pending_awvalid ? pending_awburst : us_awburst;
	mst_awcache <=  pending_awvalid ? pending_awcache : us_awcache;
	mst_awlock  <=  master_awlock;
	mst_awprot  <=  pending_awvalid ? pending_awprot  : us_awprot ;
	mst_awid   <=  master_awid;
  end
end
	
assign dec_err_bresp = 2'b11;
assign dec_err_bid = mst_awid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		dec_err_wready <= 1'b0;
	else 
		dec_err_wready <= (master_awready & dec_err_sel) | (dec_err_wready & ~(dec_err_wvalid & dec_err_wlast));
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		dec_err_bvalid <= 1'b0;
	else 
		dec_err_bvalid <= (dec_err_wready & dec_err_wvalid & dec_err_wlast) | (dec_err_bvalid & ~dec_err_bready);
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		mst_awlocking  <= 1'b0;
		locking_awid   <= {ID_WIDTH{1'b0}};
	end else if (master_awvalid & master_awready & master_awlock) begin
		mst_awlocking  <= 1'b1;
		locking_awid   <= master_awid;
        end else if (us_bvalid & us_bready & (us_bid==locking_awid))
		mst_awlocking  <= 1'b0;
end

endmodule
