`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

module atcbmc300_us_wdata_ctrl (
// VPERL: &PORTLIST;
// VPERL_GENERATED_BEGIN
	  self_id,  
`ifdef ATCBMC300_SLV0_SUPPORT
	  slv0_wmid,
	  slv0_wready,
	  slv0_connect,
`endif // ATCBMC300_SLV0_SUPPORT
`ifdef ATCBMC300_SLV1_SUPPORT
	  slv1_wmid,
	  slv1_wready,
	  slv1_connect,
`endif // ATCBMC300_SLV1_SUPPORT
`ifdef ATCBMC300_SLV2_SUPPORT
	  slv2_wmid,
	  slv2_wready,
	  slv2_connect,
`endif // ATCBMC300_SLV2_SUPPORT
`ifdef ATCBMC300_SLV3_SUPPORT
	  slv3_wmid,
	  slv3_wready,
	  slv3_connect,
`endif // ATCBMC300_SLV3_SUPPORT
`ifdef ATCBMC300_SLV4_SUPPORT
	  slv4_wmid,
	  slv4_wready,
	  slv4_connect,
`endif // ATCBMC300_SLV4_SUPPORT
`ifdef ATCBMC300_SLV5_SUPPORT
	  slv5_wmid,
	  slv5_wready,
	  slv5_connect,
`endif // ATCBMC300_SLV5_SUPPORT
`ifdef ATCBMC300_SLV6_SUPPORT
	  slv6_wmid,
	  slv6_wready,
	  slv6_connect,
`endif // ATCBMC300_SLV6_SUPPORT
`ifdef ATCBMC300_SLV7_SUPPORT
	  slv7_wmid,
	  slv7_wready,
	  slv7_connect,
`endif // ATCBMC300_SLV7_SUPPORT
`ifdef ATCBMC300_SLV8_SUPPORT
	  slv8_wmid,
	  slv8_wready,
	  slv8_connect,
`endif // ATCBMC300_SLV8_SUPPORT
`ifdef ATCBMC300_SLV9_SUPPORT
	  slv9_wmid,
	  slv9_wready,
	  slv9_connect,
`endif // ATCBMC300_SLV9_SUPPORT
`ifdef ATCBMC300_SLV10_SUPPORT
	  slv10_wmid,
	  slv10_wready,
	  slv10_connect,
`endif // ATCBMC300_SLV10_SUPPORT
`ifdef ATCBMC300_SLV11_SUPPORT
	  slv11_wmid,
	  slv11_wready,
	  slv11_connect,
`endif // ATCBMC300_SLV11_SUPPORT
`ifdef ATCBMC300_SLV12_SUPPORT
	  slv12_wmid,
	  slv12_wready,
	  slv12_connect,
`endif // ATCBMC300_SLV12_SUPPORT
`ifdef ATCBMC300_SLV13_SUPPORT
	  slv13_wmid,
	  slv13_wready,
	  slv13_connect,
`endif // ATCBMC300_SLV13_SUPPORT
`ifdef ATCBMC300_SLV14_SUPPORT
	  slv14_wmid,
	  slv14_wready,
	  slv14_connect,
`endif // ATCBMC300_SLV14_SUPPORT
`ifdef ATCBMC300_SLV15_SUPPORT
	  slv15_wmid,
	  slv15_wready,
	  slv15_connect,
`endif // ATCBMC300_SLV15_SUPPORT
`ifdef ATCBMC300_SLV16_SUPPORT
	  slv16_wmid,
	  slv16_wready,
	  slv16_connect,
`endif // ATCBMC300_SLV16_SUPPORT
`ifdef ATCBMC300_SLV17_SUPPORT
	  slv17_wmid,
	  slv17_wready,
	  slv17_connect,
`endif // ATCBMC300_SLV17_SUPPORT
`ifdef ATCBMC300_SLV18_SUPPORT
	  slv18_wmid,
	  slv18_wready,
	  slv18_connect,
`endif // ATCBMC300_SLV18_SUPPORT
`ifdef ATCBMC300_SLV19_SUPPORT
	  slv19_wmid,
	  slv19_wready,
	  slv19_connect,
`endif // ATCBMC300_SLV19_SUPPORT
`ifdef ATCBMC300_SLV20_SUPPORT
	  slv20_wmid,
	  slv20_wready,
	  slv20_connect,
`endif // ATCBMC300_SLV20_SUPPORT
`ifdef ATCBMC300_SLV21_SUPPORT
	  slv21_wmid,
	  slv21_wready,
	  slv21_connect,
`endif // ATCBMC300_SLV21_SUPPORT
`ifdef ATCBMC300_SLV22_SUPPORT
	  slv22_wmid,
	  slv22_wready,
	  slv22_connect,
`endif // ATCBMC300_SLV22_SUPPORT
`ifdef ATCBMC300_SLV23_SUPPORT
	  slv23_wmid,
	  slv23_wready,
	  slv23_connect,
`endif // ATCBMC300_SLV23_SUPPORT
`ifdef ATCBMC300_SLV24_SUPPORT
	  slv24_wmid,
	  slv24_wready,
	  slv24_connect,
`endif // ATCBMC300_SLV24_SUPPORT
`ifdef ATCBMC300_SLV25_SUPPORT
	  slv25_wmid,
	  slv25_wready,
	  slv25_connect,
`endif // ATCBMC300_SLV25_SUPPORT
`ifdef ATCBMC300_SLV26_SUPPORT
	  slv26_wmid,
	  slv26_wready,
	  slv26_connect,
`endif // ATCBMC300_SLV26_SUPPORT
`ifdef ATCBMC300_SLV27_SUPPORT
	  slv27_wmid,
	  slv27_wready,
	  slv27_connect,
`endif // ATCBMC300_SLV27_SUPPORT
`ifdef ATCBMC300_SLV28_SUPPORT
	  slv28_wmid,
	  slv28_wready,
	  slv28_connect,
`endif // ATCBMC300_SLV28_SUPPORT
`ifdef ATCBMC300_SLV29_SUPPORT
	  slv29_wmid,
	  slv29_wready,
	  slv29_connect,
`endif // ATCBMC300_SLV29_SUPPORT
`ifdef ATCBMC300_SLV30_SUPPORT
	  slv30_wmid,
	  slv30_wready,
	  slv30_connect,
`endif // ATCBMC300_SLV30_SUPPORT
`ifdef ATCBMC300_SLV31_SUPPORT
	  slv31_wmid,
	  slv31_wready,
	  slv31_connect,
`endif // ATCBMC300_SLV31_SUPPORT
	  us_wdata, 
	  us_wlast, 
	  us_wstrb, 
	  us_wvalid,
	  us_wready,
	  aw_outstanding_id,
	  aw_addr_outstanding_en,
	  aw_outstanding_ready,
	  wd_outstanding_idle,
	  resp_outstanding_en,
	  outstanding_resp_ready,
	  dec_err_wready,
	  dec_err_wvalid,
	  dec_err_wlast,
	  mst_wsid, 
	  mst_wvalid,
	  mst_wdata,
	  mst_wlast,
	  mst_wstrb,
	  aclk,     
	  aresetn   
// VPERL_GENERATED_END
);
parameter DATA_WIDTH = 64;
parameter OUTSTAND_ID_WIDTH = 5;
parameter OUTSTANDING_DEPTH = 2;

localparam DATA_MSB = DATA_WIDTH - 1;
localparam OUTSTAND_ID_MSB = OUTSTAND_ID_WIDTH - 1;
localparam WD_FIFO_WIDTH = DATA_WIDTH + DATA_WIDTH/8 +1;
localparam WD_FIFO_DEPTH = 8;

input [3:0] 	    self_id;
// #VPERL_BEGIN
//  for($i=0;$i<32;$i++) {
// :`ifdef ATCBMC300_SLV${i}_SUPPORT
// : input [3:0]        slv${i}_wmid;
// : input              slv${i}_wready;
// : input 	 	slv${i}_connect;
// : `endif
// }
// #VPERL_END

// #VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_SLV0_SUPPORT
input [3:0]        slv0_wmid;
input              slv0_wready;
input 	 	slv0_connect;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
input [3:0]        slv1_wmid;
input              slv1_wready;
input 	 	slv1_connect;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
input [3:0]        slv2_wmid;
input              slv2_wready;
input 	 	slv2_connect;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
input [3:0]        slv3_wmid;
input              slv3_wready;
input 	 	slv3_connect;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
input [3:0]        slv4_wmid;
input              slv4_wready;
input 	 	slv4_connect;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
input [3:0]        slv5_wmid;
input              slv5_wready;
input 	 	slv5_connect;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
input [3:0]        slv6_wmid;
input              slv6_wready;
input 	 	slv6_connect;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
input [3:0]        slv7_wmid;
input              slv7_wready;
input 	 	slv7_connect;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
input [3:0]        slv8_wmid;
input              slv8_wready;
input 	 	slv8_connect;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
input [3:0]        slv9_wmid;
input              slv9_wready;
input 	 	slv9_connect;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
input [3:0]        slv10_wmid;
input              slv10_wready;
input 	 	slv10_connect;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
input [3:0]        slv11_wmid;
input              slv11_wready;
input 	 	slv11_connect;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
input [3:0]        slv12_wmid;
input              slv12_wready;
input 	 	slv12_connect;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
input [3:0]        slv13_wmid;
input              slv13_wready;
input 	 	slv13_connect;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
input [3:0]        slv14_wmid;
input              slv14_wready;
input 	 	slv14_connect;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
input [3:0]        slv15_wmid;
input              slv15_wready;
input 	 	slv15_connect;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
input [3:0]        slv16_wmid;
input              slv16_wready;
input 	 	slv16_connect;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
input [3:0]        slv17_wmid;
input              slv17_wready;
input 	 	slv17_connect;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
input [3:0]        slv18_wmid;
input              slv18_wready;
input 	 	slv18_connect;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
input [3:0]        slv19_wmid;
input              slv19_wready;
input 	 	slv19_connect;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
input [3:0]        slv20_wmid;
input              slv20_wready;
input 	 	slv20_connect;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
input [3:0]        slv21_wmid;
input              slv21_wready;
input 	 	slv21_connect;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
input [3:0]        slv22_wmid;
input              slv22_wready;
input 	 	slv22_connect;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
input [3:0]        slv23_wmid;
input              slv23_wready;
input 	 	slv23_connect;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
input [3:0]        slv24_wmid;
input              slv24_wready;
input 	 	slv24_connect;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
input [3:0]        slv25_wmid;
input              slv25_wready;
input 	 	slv25_connect;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
input [3:0]        slv26_wmid;
input              slv26_wready;
input 	 	slv26_connect;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
input [3:0]        slv27_wmid;
input              slv27_wready;
input 	 	slv27_connect;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
input [3:0]        slv28_wmid;
input              slv28_wready;
input 	 	slv28_connect;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
input [3:0]        slv29_wmid;
input              slv29_wready;
input 	 	slv29_connect;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
input [3:0]        slv30_wmid;
input              slv30_wready;
input 	 	slv30_connect;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
input [3:0]        slv31_wmid;
input              slv31_wready;
input 	 	slv31_connect;
`endif
// #VPERL_GENERATED_END
input [DATA_MSB:0] us_wdata;
input 	           us_wlast;
input [(DATA_WIDTH/8)-1:0] us_wstrb;
input              us_wvalid;
output             us_wready;

input [OUTSTAND_ID_MSB:0] aw_outstanding_id;
input	  	   aw_addr_outstanding_en;
output		   aw_outstanding_ready;
output		   wd_outstanding_idle;

output		   resp_outstanding_en;
input		   outstanding_resp_ready;
//input [3:0]        def_slave_wmid;
input		   dec_err_wready;
output		   dec_err_wvalid;
output		   dec_err_wlast;
output [4:0]       mst_wsid;
output		   	    mst_wvalid;
output [DATA_MSB:0] 	    mst_wdata;
output 	                    mst_wlast;
output [(DATA_WIDTH/8)-1:0] mst_wstrb;

input aclk;
input aresetn;

wire 			 slave_sel_wready;
wire [31:0] 		 slave_wready;
wire [OUTSTAND_ID_MSB:0] wsid_fifo_wdata;
wire [OUTSTAND_ID_MSB:0] wsid_fifo_rdata;
wire                     wsid_fifo_empty;
wire			 wsid_fifo_full;
wire                     wsid_fifo_rd;
wire			 wsid_fifo_wr;

wire [WD_FIFO_WIDTH-1:0] wdata_fifo_wdata;
wire [WD_FIFO_WIDTH-1:0] wdata_fifo_rdata;
wire                     wdata_fifo_empty;
wire			 wdata_fifo_full;
wire                     wdata_fifo_rd;
wire			 wdata_fifo_wr;

assign aw_outstanding_ready = ~wsid_fifo_full;
assign wd_outstanding_idle  = wsid_fifo_empty;
assign wsid_fifo_rd = ~wdata_fifo_empty & mst_wlast & outstanding_resp_ready & ~wsid_fifo_empty & slave_sel_wready;
assign wsid_fifo_wr = aw_addr_outstanding_en;
assign wsid_fifo_wdata = aw_outstanding_id;
assign resp_outstanding_en = wsid_fifo_rd;
assign mst_wsid = wsid_fifo_rdata[4:0];

// VPERL_BEGIN
//  for($i=0;$i<32;$i++) {
// :`ifdef ATCBMC300_SLV${i}_SUPPORT
// :	assign slave_wready[${i}] = (slv${i}_wmid==self_id) & slv${i}_wready & slv${i}_connect;
// :`else
// :	assign slave_wready[${i}] = 1'b0;
// :`endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_SLV0_SUPPORT
	assign slave_wready[0] = (slv0_wmid==self_id) & slv0_wready & slv0_connect;
`else
	assign slave_wready[0] = 1'b0;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	assign slave_wready[1] = (slv1_wmid==self_id) & slv1_wready & slv1_connect;
`else
	assign slave_wready[1] = 1'b0;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	assign slave_wready[2] = (slv2_wmid==self_id) & slv2_wready & slv2_connect;
`else
	assign slave_wready[2] = 1'b0;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	assign slave_wready[3] = (slv3_wmid==self_id) & slv3_wready & slv3_connect;
`else
	assign slave_wready[3] = 1'b0;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	assign slave_wready[4] = (slv4_wmid==self_id) & slv4_wready & slv4_connect;
`else
	assign slave_wready[4] = 1'b0;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	assign slave_wready[5] = (slv5_wmid==self_id) & slv5_wready & slv5_connect;
`else
	assign slave_wready[5] = 1'b0;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	assign slave_wready[6] = (slv6_wmid==self_id) & slv6_wready & slv6_connect;
`else
	assign slave_wready[6] = 1'b0;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	assign slave_wready[7] = (slv7_wmid==self_id) & slv7_wready & slv7_connect;
`else
	assign slave_wready[7] = 1'b0;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	assign slave_wready[8] = (slv8_wmid==self_id) & slv8_wready & slv8_connect;
`else
	assign slave_wready[8] = 1'b0;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	assign slave_wready[9] = (slv9_wmid==self_id) & slv9_wready & slv9_connect;
`else
	assign slave_wready[9] = 1'b0;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	assign slave_wready[10] = (slv10_wmid==self_id) & slv10_wready & slv10_connect;
`else
	assign slave_wready[10] = 1'b0;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	assign slave_wready[11] = (slv11_wmid==self_id) & slv11_wready & slv11_connect;
`else
	assign slave_wready[11] = 1'b0;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	assign slave_wready[12] = (slv12_wmid==self_id) & slv12_wready & slv12_connect;
`else
	assign slave_wready[12] = 1'b0;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	assign slave_wready[13] = (slv13_wmid==self_id) & slv13_wready & slv13_connect;
`else
	assign slave_wready[13] = 1'b0;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	assign slave_wready[14] = (slv14_wmid==self_id) & slv14_wready & slv14_connect;
`else
	assign slave_wready[14] = 1'b0;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	assign slave_wready[15] = (slv15_wmid==self_id) & slv15_wready & slv15_connect;
`else
	assign slave_wready[15] = 1'b0;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	assign slave_wready[16] = (slv16_wmid==self_id) & slv16_wready & slv16_connect;
`else
	assign slave_wready[16] = 1'b0;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	assign slave_wready[17] = (slv17_wmid==self_id) & slv17_wready & slv17_connect;
`else
	assign slave_wready[17] = 1'b0;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	assign slave_wready[18] = (slv18_wmid==self_id) & slv18_wready & slv18_connect;
`else
	assign slave_wready[18] = 1'b0;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	assign slave_wready[19] = (slv19_wmid==self_id) & slv19_wready & slv19_connect;
`else
	assign slave_wready[19] = 1'b0;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	assign slave_wready[20] = (slv20_wmid==self_id) & slv20_wready & slv20_connect;
`else
	assign slave_wready[20] = 1'b0;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	assign slave_wready[21] = (slv21_wmid==self_id) & slv21_wready & slv21_connect;
`else
	assign slave_wready[21] = 1'b0;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	assign slave_wready[22] = (slv22_wmid==self_id) & slv22_wready & slv22_connect;
`else
	assign slave_wready[22] = 1'b0;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	assign slave_wready[23] = (slv23_wmid==self_id) & slv23_wready & slv23_connect;
`else
	assign slave_wready[23] = 1'b0;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	assign slave_wready[24] = (slv24_wmid==self_id) & slv24_wready & slv24_connect;
`else
	assign slave_wready[24] = 1'b0;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	assign slave_wready[25] = (slv25_wmid==self_id) & slv25_wready & slv25_connect;
`else
	assign slave_wready[25] = 1'b0;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	assign slave_wready[26] = (slv26_wmid==self_id) & slv26_wready & slv26_connect;
`else
	assign slave_wready[26] = 1'b0;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	assign slave_wready[27] = (slv27_wmid==self_id) & slv27_wready & slv27_connect;
`else
	assign slave_wready[27] = 1'b0;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	assign slave_wready[28] = (slv28_wmid==self_id) & slv28_wready & slv28_connect;
`else
	assign slave_wready[28] = 1'b0;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	assign slave_wready[29] = (slv29_wmid==self_id) & slv29_wready & slv29_connect;
`else
	assign slave_wready[29] = 1'b0;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	assign slave_wready[30] = (slv30_wmid==self_id) & slv30_wready & slv30_connect;
`else
	assign slave_wready[30] = 1'b0;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	assign slave_wready[31] = (slv31_wmid==self_id) & slv31_wready & slv31_connect;
`else
	assign slave_wready[31] = 1'b0;
`endif
// VPERL_GENERATED_END
assign us_wready = ~wdata_fifo_full;
assign dec_err_wvalid = ~wdata_fifo_empty & wsid_fifo_empty;
assign dec_err_wlast = mst_wlast;
assign slave_sel_wready = slave_wready[mst_wsid];

nds_sync_fifo_afe #(
                .DATA_WIDTH (OUTSTAND_ID_WIDTH),
                .FIFO_DEPTH (OUTSTANDING_DEPTH)
) wsid_fifo (
	.reset_n     (aresetn               ),
	.clk         (aclk                  ),
	.wr          (wsid_fifo_wr          ),
	.wr_data     (wsid_fifo_wdata       ),
	.rd          (wsid_fifo_rd          ),
	.rd_data     (wsid_fifo_rdata       ),
	.almost_empty(                      ),
	.almost_full (                      ),
	.empty       (wsid_fifo_empty       ),
	.full        (wsid_fifo_full        )
);

nds_sync_fifo_afe #(
                .DATA_WIDTH(WD_FIFO_WIDTH), 
                .FIFO_DEPTH(WD_FIFO_DEPTH) 
) wdata_fifo (
	.reset_n     (aresetn               ),
	.clk         (aclk                  ),
	.wr          (wdata_fifo_wr         ),
	.wr_data     (wdata_fifo_wdata      ),
	.rd          (wdata_fifo_rd         ),
	.rd_data     (wdata_fifo_rdata      ),
	.almost_empty(                      ),
	.almost_full (                      ),
	.empty       (wdata_fifo_empty      ),
	.full        (wdata_fifo_full       )
);

assign wdata_fifo_wdata = {us_wlast,us_wstrb, us_wdata};
assign wdata_fifo_wr    = us_wvalid & ~wdata_fifo_full;
assign wdata_fifo_rd    = ~wdata_fifo_empty & (dec_err_wready | (slave_sel_wready & (~mst_wlast | outstanding_resp_ready) & ~wsid_fifo_empty));
assign mst_wlast        = wdata_fifo_rdata[WD_FIFO_WIDTH-1];
assign mst_wstrb        = wdata_fifo_rdata[DATA_WIDTH+DATA_WIDTH/8-1:DATA_WIDTH];
assign mst_wdata        = wdata_fifo_rdata[DATA_WIDTH-1:0];
assign mst_wvalid       = ~wdata_fifo_empty & ~(mst_wlast & ~outstanding_resp_ready) & ~wsid_fifo_empty;

endmodule
