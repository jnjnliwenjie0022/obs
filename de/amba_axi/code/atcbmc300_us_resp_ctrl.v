`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

module atcbmc300_us_resp_ctrl (
// VPERL: &PORTLIST;
// VPERL_GENERATED_BEGIN
	  self_id,  
`ifdef ATCBMC300_SLV0_SUPPORT
	  slv0_resp_data,
	  slv0_resp_id,
	  slv0_resp_valid,
	  slv0_connect,
`endif // ATCBMC300_SLV0_SUPPORT
`ifdef ATCBMC300_SLV1_SUPPORT
	  slv1_resp_data,
	  slv1_resp_id,
	  slv1_resp_valid,
	  slv1_connect,
`endif // ATCBMC300_SLV1_SUPPORT
`ifdef ATCBMC300_SLV2_SUPPORT
	  slv2_resp_data,
	  slv2_resp_id,
	  slv2_resp_valid,
	  slv2_connect,
`endif // ATCBMC300_SLV2_SUPPORT
`ifdef ATCBMC300_SLV3_SUPPORT
	  slv3_resp_data,
	  slv3_resp_id,
	  slv3_resp_valid,
	  slv3_connect,
`endif // ATCBMC300_SLV3_SUPPORT
`ifdef ATCBMC300_SLV4_SUPPORT
	  slv4_resp_data,
	  slv4_resp_id,
	  slv4_resp_valid,
	  slv4_connect,
`endif // ATCBMC300_SLV4_SUPPORT
`ifdef ATCBMC300_SLV5_SUPPORT
	  slv5_resp_data,
	  slv5_resp_id,
	  slv5_resp_valid,
	  slv5_connect,
`endif // ATCBMC300_SLV5_SUPPORT
`ifdef ATCBMC300_SLV6_SUPPORT
	  slv6_resp_data,
	  slv6_resp_id,
	  slv6_resp_valid,
	  slv6_connect,
`endif // ATCBMC300_SLV6_SUPPORT
`ifdef ATCBMC300_SLV7_SUPPORT
	  slv7_resp_data,
	  slv7_resp_id,
	  slv7_resp_valid,
	  slv7_connect,
`endif // ATCBMC300_SLV7_SUPPORT
`ifdef ATCBMC300_SLV8_SUPPORT
	  slv8_resp_data,
	  slv8_resp_id,
	  slv8_resp_valid,
	  slv8_connect,
`endif // ATCBMC300_SLV8_SUPPORT
`ifdef ATCBMC300_SLV9_SUPPORT
	  slv9_resp_data,
	  slv9_resp_id,
	  slv9_resp_valid,
	  slv9_connect,
`endif // ATCBMC300_SLV9_SUPPORT
`ifdef ATCBMC300_SLV10_SUPPORT
	  slv10_resp_data,
	  slv10_resp_id,
	  slv10_resp_valid,
	  slv10_connect,
`endif // ATCBMC300_SLV10_SUPPORT
`ifdef ATCBMC300_SLV11_SUPPORT
	  slv11_resp_data,
	  slv11_resp_id,
	  slv11_resp_valid,
	  slv11_connect,
`endif // ATCBMC300_SLV11_SUPPORT
`ifdef ATCBMC300_SLV12_SUPPORT
	  slv12_resp_data,
	  slv12_resp_id,
	  slv12_resp_valid,
	  slv12_connect,
`endif // ATCBMC300_SLV12_SUPPORT
`ifdef ATCBMC300_SLV13_SUPPORT
	  slv13_resp_data,
	  slv13_resp_id,
	  slv13_resp_valid,
	  slv13_connect,
`endif // ATCBMC300_SLV13_SUPPORT
`ifdef ATCBMC300_SLV14_SUPPORT
	  slv14_resp_data,
	  slv14_resp_id,
	  slv14_resp_valid,
	  slv14_connect,
`endif // ATCBMC300_SLV14_SUPPORT
`ifdef ATCBMC300_SLV15_SUPPORT
	  slv15_resp_data,
	  slv15_resp_id,
	  slv15_resp_valid,
	  slv15_connect,
`endif // ATCBMC300_SLV15_SUPPORT
`ifdef ATCBMC300_SLV16_SUPPORT
	  slv16_resp_data,
	  slv16_resp_id,
	  slv16_resp_valid,
	  slv16_connect,
`endif // ATCBMC300_SLV16_SUPPORT
`ifdef ATCBMC300_SLV17_SUPPORT
	  slv17_resp_data,
	  slv17_resp_id,
	  slv17_resp_valid,
	  slv17_connect,
`endif // ATCBMC300_SLV17_SUPPORT
`ifdef ATCBMC300_SLV18_SUPPORT
	  slv18_resp_data,
	  slv18_resp_id,
	  slv18_resp_valid,
	  slv18_connect,
`endif // ATCBMC300_SLV18_SUPPORT
`ifdef ATCBMC300_SLV19_SUPPORT
	  slv19_resp_data,
	  slv19_resp_id,
	  slv19_resp_valid,
	  slv19_connect,
`endif // ATCBMC300_SLV19_SUPPORT
`ifdef ATCBMC300_SLV20_SUPPORT
	  slv20_resp_data,
	  slv20_resp_id,
	  slv20_resp_valid,
	  slv20_connect,
`endif // ATCBMC300_SLV20_SUPPORT
`ifdef ATCBMC300_SLV21_SUPPORT
	  slv21_resp_data,
	  slv21_resp_id,
	  slv21_resp_valid,
	  slv21_connect,
`endif // ATCBMC300_SLV21_SUPPORT
`ifdef ATCBMC300_SLV22_SUPPORT
	  slv22_resp_data,
	  slv22_resp_id,
	  slv22_resp_valid,
	  slv22_connect,
`endif // ATCBMC300_SLV22_SUPPORT
`ifdef ATCBMC300_SLV23_SUPPORT
	  slv23_resp_data,
	  slv23_resp_id,
	  slv23_resp_valid,
	  slv23_connect,
`endif // ATCBMC300_SLV23_SUPPORT
`ifdef ATCBMC300_SLV24_SUPPORT
	  slv24_resp_data,
	  slv24_resp_id,
	  slv24_resp_valid,
	  slv24_connect,
`endif // ATCBMC300_SLV24_SUPPORT
`ifdef ATCBMC300_SLV25_SUPPORT
	  slv25_resp_data,
	  slv25_resp_id,
	  slv25_resp_valid,
	  slv25_connect,
`endif // ATCBMC300_SLV25_SUPPORT
`ifdef ATCBMC300_SLV26_SUPPORT
	  slv26_resp_data,
	  slv26_resp_id,
	  slv26_resp_valid,
	  slv26_connect,
`endif // ATCBMC300_SLV26_SUPPORT
`ifdef ATCBMC300_SLV27_SUPPORT
	  slv27_resp_data,
	  slv27_resp_id,
	  slv27_resp_valid,
	  slv27_connect,
`endif // ATCBMC300_SLV27_SUPPORT
`ifdef ATCBMC300_SLV28_SUPPORT
	  slv28_resp_data,
	  slv28_resp_id,
	  slv28_resp_valid,
	  slv28_connect,
`endif // ATCBMC300_SLV28_SUPPORT
`ifdef ATCBMC300_SLV29_SUPPORT
	  slv29_resp_data,
	  slv29_resp_id,
	  slv29_resp_valid,
	  slv29_connect,
`endif // ATCBMC300_SLV29_SUPPORT
`ifdef ATCBMC300_SLV30_SUPPORT
	  slv30_resp_data,
	  slv30_resp_id,
	  slv30_resp_valid,
	  slv30_connect,
`endif // ATCBMC300_SLV30_SUPPORT
`ifdef ATCBMC300_SLV31_SUPPORT
	  slv31_resp_data,
	  slv31_resp_id,
	  slv31_resp_valid,
	  slv31_connect,
`endif // ATCBMC300_SLV31_SUPPORT
	  mst_resp_slave_id,
	  mst_resp_ready,
	  dec_err_resp_id,
	  dec_err_resp_data,
	  dec_err_resp_valid,
	  dec_err_resp_ready,
	  outstanding_id,
	  outstanding_en,
	  outstanding_ready,
	  outstanding_idle,
	  resp_id,  
	  resp_data,
	  resp_valid,
	  resp_ready,
	  aclk,     
	  aresetn   
// VPERL_GENERATED_END
);
parameter RESP_DATA_WIDTH = 3;
parameter ID_WIDTH   = 4;
parameter BRESP_CHANNEL = 1;
parameter RESP_INORDER_ONLY = 1;
parameter OUTSTAND_ID_WIDTH = 5;
parameter OUTSTANDING_DEPTH = 4;

localparam ID_MSB = ID_WIDTH - 1;
localparam OUTSTAND_ID_MSB = OUTSTAND_ID_WIDTH - 1;
localparam RESP_DATA_MSB = RESP_DATA_WIDTH - 1;

input [3:0] 	self_id;
// #VPERL_BEGIN
//  for ($i=0;$i<32;$i++) {
// :`ifdef ATCBMC300_SLV${i}_SUPPORT
// : input [RESP_DATA_MSB:0] slv${i}_resp_data;
// : input [ID_MSB+4:0] slv${i}_resp_id;
// : input              slv${i}_resp_valid;
// : input              slv${i}_connect;
// : `endif
// }
// #VPERL_END

// #VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_SLV0_SUPPORT
input [RESP_DATA_MSB:0] slv0_resp_data;
input [ID_MSB+4:0] slv0_resp_id;
input              slv0_resp_valid;
input              slv0_connect;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
input [RESP_DATA_MSB:0] slv1_resp_data;
input [ID_MSB+4:0] slv1_resp_id;
input              slv1_resp_valid;
input              slv1_connect;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
input [RESP_DATA_MSB:0] slv2_resp_data;
input [ID_MSB+4:0] slv2_resp_id;
input              slv2_resp_valid;
input              slv2_connect;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
input [RESP_DATA_MSB:0] slv3_resp_data;
input [ID_MSB+4:0] slv3_resp_id;
input              slv3_resp_valid;
input              slv3_connect;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
input [RESP_DATA_MSB:0] slv4_resp_data;
input [ID_MSB+4:0] slv4_resp_id;
input              slv4_resp_valid;
input              slv4_connect;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
input [RESP_DATA_MSB:0] slv5_resp_data;
input [ID_MSB+4:0] slv5_resp_id;
input              slv5_resp_valid;
input              slv5_connect;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
input [RESP_DATA_MSB:0] slv6_resp_data;
input [ID_MSB+4:0] slv6_resp_id;
input              slv6_resp_valid;
input              slv6_connect;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
input [RESP_DATA_MSB:0] slv7_resp_data;
input [ID_MSB+4:0] slv7_resp_id;
input              slv7_resp_valid;
input              slv7_connect;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
input [RESP_DATA_MSB:0] slv8_resp_data;
input [ID_MSB+4:0] slv8_resp_id;
input              slv8_resp_valid;
input              slv8_connect;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
input [RESP_DATA_MSB:0] slv9_resp_data;
input [ID_MSB+4:0] slv9_resp_id;
input              slv9_resp_valid;
input              slv9_connect;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
input [RESP_DATA_MSB:0] slv10_resp_data;
input [ID_MSB+4:0] slv10_resp_id;
input              slv10_resp_valid;
input              slv10_connect;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
input [RESP_DATA_MSB:0] slv11_resp_data;
input [ID_MSB+4:0] slv11_resp_id;
input              slv11_resp_valid;
input              slv11_connect;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
input [RESP_DATA_MSB:0] slv12_resp_data;
input [ID_MSB+4:0] slv12_resp_id;
input              slv12_resp_valid;
input              slv12_connect;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
input [RESP_DATA_MSB:0] slv13_resp_data;
input [ID_MSB+4:0] slv13_resp_id;
input              slv13_resp_valid;
input              slv13_connect;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
input [RESP_DATA_MSB:0] slv14_resp_data;
input [ID_MSB+4:0] slv14_resp_id;
input              slv14_resp_valid;
input              slv14_connect;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
input [RESP_DATA_MSB:0] slv15_resp_data;
input [ID_MSB+4:0] slv15_resp_id;
input              slv15_resp_valid;
input              slv15_connect;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
input [RESP_DATA_MSB:0] slv16_resp_data;
input [ID_MSB+4:0] slv16_resp_id;
input              slv16_resp_valid;
input              slv16_connect;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
input [RESP_DATA_MSB:0] slv17_resp_data;
input [ID_MSB+4:0] slv17_resp_id;
input              slv17_resp_valid;
input              slv17_connect;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
input [RESP_DATA_MSB:0] slv18_resp_data;
input [ID_MSB+4:0] slv18_resp_id;
input              slv18_resp_valid;
input              slv18_connect;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
input [RESP_DATA_MSB:0] slv19_resp_data;
input [ID_MSB+4:0] slv19_resp_id;
input              slv19_resp_valid;
input              slv19_connect;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
input [RESP_DATA_MSB:0] slv20_resp_data;
input [ID_MSB+4:0] slv20_resp_id;
input              slv20_resp_valid;
input              slv20_connect;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
input [RESP_DATA_MSB:0] slv21_resp_data;
input [ID_MSB+4:0] slv21_resp_id;
input              slv21_resp_valid;
input              slv21_connect;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
input [RESP_DATA_MSB:0] slv22_resp_data;
input [ID_MSB+4:0] slv22_resp_id;
input              slv22_resp_valid;
input              slv22_connect;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
input [RESP_DATA_MSB:0] slv23_resp_data;
input [ID_MSB+4:0] slv23_resp_id;
input              slv23_resp_valid;
input              slv23_connect;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
input [RESP_DATA_MSB:0] slv24_resp_data;
input [ID_MSB+4:0] slv24_resp_id;
input              slv24_resp_valid;
input              slv24_connect;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
input [RESP_DATA_MSB:0] slv25_resp_data;
input [ID_MSB+4:0] slv25_resp_id;
input              slv25_resp_valid;
input              slv25_connect;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
input [RESP_DATA_MSB:0] slv26_resp_data;
input [ID_MSB+4:0] slv26_resp_id;
input              slv26_resp_valid;
input              slv26_connect;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
input [RESP_DATA_MSB:0] slv27_resp_data;
input [ID_MSB+4:0] slv27_resp_id;
input              slv27_resp_valid;
input              slv27_connect;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
input [RESP_DATA_MSB:0] slv28_resp_data;
input [ID_MSB+4:0] slv28_resp_id;
input              slv28_resp_valid;
input              slv28_connect;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
input [RESP_DATA_MSB:0] slv29_resp_data;
input [ID_MSB+4:0] slv29_resp_id;
input              slv29_resp_valid;
input              slv29_connect;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
input [RESP_DATA_MSB:0] slv30_resp_data;
input [ID_MSB+4:0] slv30_resp_id;
input              slv30_resp_valid;
input              slv30_connect;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
input [RESP_DATA_MSB:0] slv31_resp_data;
input [ID_MSB+4:0] slv31_resp_id;
input              slv31_resp_valid;
input              slv31_connect;
`endif
// #VPERL_GENERATED_END
output  [4:0]       mst_resp_slave_id;
output              mst_resp_ready;

input [ID_MSB:0] 	dec_err_resp_id;
input [RESP_DATA_MSB:0]	dec_err_resp_data;
input    		dec_err_resp_valid;
output          	dec_err_resp_ready;

input [OUTSTAND_ID_MSB:0] outstanding_id;
//input		   	  dec_err_sel;
input 		   	  outstanding_en;
output		   	  outstanding_ready;
output			  outstanding_idle;

output [ID_MSB:0]   	  resp_id;
output [RESP_DATA_MSB:0]  resp_data;
output                    resp_valid;
input              	  resp_ready;

input aclk;
input aresetn;

reg [ID_MSB:0]      	resp_id;
reg [RESP_DATA_MSB:0] 	resp_data;
reg                   	resp_valid;
reg [ID_MSB:0] 	slave_resp_id [0:31];
reg [RESP_DATA_MSB:0] 	slave_resp_data [0:31];
reg [31:0] 	      	slave_resp_valid;

wire last_resp;
// VPERL_BEGIN
// :always @* begin
//  for ($i=0;$i<32;$i++) {
// :`ifdef ATCBMC300_SLV${i}_SUPPORT
// : 	slave_resp_valid[${i}] = slv${i}_resp_valid & (slv${i}_resp_id[3:0]==self_id) & slv${i}_connect;
// :	slave_resp_data[${i}]  = {RESP_DATA_WIDTH{slv${i}_connect}} & slv${i}_resp_data;
// :	slave_resp_id[${i}]    = {ID_WIDTH{slv${i}_connect}} & slv${i}_resp_id[ID_MSB+4:4];
// :`else
// : 	slave_resp_valid[${i}] = 1'b0;
// :	slave_resp_data[${i}]  = {RESP_DATA_WIDTH{1'b0}};
// :	slave_resp_id[${i}]    = {ID_WIDTH{1'b0}};
// :`endif
// }
// :end
// VPERL_END

// VPERL_GENERATED_BEGIN
always @* begin
`ifdef ATCBMC300_SLV0_SUPPORT
	slave_resp_valid[0] = slv0_resp_valid & (slv0_resp_id[3:0]==self_id) & slv0_connect;
	slave_resp_data[0]  = {RESP_DATA_WIDTH{slv0_connect}} & slv0_resp_data;
	slave_resp_id[0]    = {ID_WIDTH{slv0_connect}} & slv0_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[0] = 1'b0;
	slave_resp_data[0]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[0]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	slave_resp_valid[1] = slv1_resp_valid & (slv1_resp_id[3:0]==self_id) & slv1_connect;
	slave_resp_data[1]  = {RESP_DATA_WIDTH{slv1_connect}} & slv1_resp_data;
	slave_resp_id[1]    = {ID_WIDTH{slv1_connect}} & slv1_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[1] = 1'b0;
	slave_resp_data[1]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[1]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	slave_resp_valid[2] = slv2_resp_valid & (slv2_resp_id[3:0]==self_id) & slv2_connect;
	slave_resp_data[2]  = {RESP_DATA_WIDTH{slv2_connect}} & slv2_resp_data;
	slave_resp_id[2]    = {ID_WIDTH{slv2_connect}} & slv2_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[2] = 1'b0;
	slave_resp_data[2]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[2]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	slave_resp_valid[3] = slv3_resp_valid & (slv3_resp_id[3:0]==self_id) & slv3_connect;
	slave_resp_data[3]  = {RESP_DATA_WIDTH{slv3_connect}} & slv3_resp_data;
	slave_resp_id[3]    = {ID_WIDTH{slv3_connect}} & slv3_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[3] = 1'b0;
	slave_resp_data[3]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[3]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	slave_resp_valid[4] = slv4_resp_valid & (slv4_resp_id[3:0]==self_id) & slv4_connect;
	slave_resp_data[4]  = {RESP_DATA_WIDTH{slv4_connect}} & slv4_resp_data;
	slave_resp_id[4]    = {ID_WIDTH{slv4_connect}} & slv4_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[4] = 1'b0;
	slave_resp_data[4]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[4]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	slave_resp_valid[5] = slv5_resp_valid & (slv5_resp_id[3:0]==self_id) & slv5_connect;
	slave_resp_data[5]  = {RESP_DATA_WIDTH{slv5_connect}} & slv5_resp_data;
	slave_resp_id[5]    = {ID_WIDTH{slv5_connect}} & slv5_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[5] = 1'b0;
	slave_resp_data[5]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[5]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	slave_resp_valid[6] = slv6_resp_valid & (slv6_resp_id[3:0]==self_id) & slv6_connect;
	slave_resp_data[6]  = {RESP_DATA_WIDTH{slv6_connect}} & slv6_resp_data;
	slave_resp_id[6]    = {ID_WIDTH{slv6_connect}} & slv6_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[6] = 1'b0;
	slave_resp_data[6]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[6]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	slave_resp_valid[7] = slv7_resp_valid & (slv7_resp_id[3:0]==self_id) & slv7_connect;
	slave_resp_data[7]  = {RESP_DATA_WIDTH{slv7_connect}} & slv7_resp_data;
	slave_resp_id[7]    = {ID_WIDTH{slv7_connect}} & slv7_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[7] = 1'b0;
	slave_resp_data[7]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[7]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	slave_resp_valid[8] = slv8_resp_valid & (slv8_resp_id[3:0]==self_id) & slv8_connect;
	slave_resp_data[8]  = {RESP_DATA_WIDTH{slv8_connect}} & slv8_resp_data;
	slave_resp_id[8]    = {ID_WIDTH{slv8_connect}} & slv8_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[8] = 1'b0;
	slave_resp_data[8]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[8]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	slave_resp_valid[9] = slv9_resp_valid & (slv9_resp_id[3:0]==self_id) & slv9_connect;
	slave_resp_data[9]  = {RESP_DATA_WIDTH{slv9_connect}} & slv9_resp_data;
	slave_resp_id[9]    = {ID_WIDTH{slv9_connect}} & slv9_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[9] = 1'b0;
	slave_resp_data[9]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[9]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	slave_resp_valid[10] = slv10_resp_valid & (slv10_resp_id[3:0]==self_id) & slv10_connect;
	slave_resp_data[10]  = {RESP_DATA_WIDTH{slv10_connect}} & slv10_resp_data;
	slave_resp_id[10]    = {ID_WIDTH{slv10_connect}} & slv10_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[10] = 1'b0;
	slave_resp_data[10]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[10]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	slave_resp_valid[11] = slv11_resp_valid & (slv11_resp_id[3:0]==self_id) & slv11_connect;
	slave_resp_data[11]  = {RESP_DATA_WIDTH{slv11_connect}} & slv11_resp_data;
	slave_resp_id[11]    = {ID_WIDTH{slv11_connect}} & slv11_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[11] = 1'b0;
	slave_resp_data[11]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[11]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	slave_resp_valid[12] = slv12_resp_valid & (slv12_resp_id[3:0]==self_id) & slv12_connect;
	slave_resp_data[12]  = {RESP_DATA_WIDTH{slv12_connect}} & slv12_resp_data;
	slave_resp_id[12]    = {ID_WIDTH{slv12_connect}} & slv12_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[12] = 1'b0;
	slave_resp_data[12]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[12]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	slave_resp_valid[13] = slv13_resp_valid & (slv13_resp_id[3:0]==self_id) & slv13_connect;
	slave_resp_data[13]  = {RESP_DATA_WIDTH{slv13_connect}} & slv13_resp_data;
	slave_resp_id[13]    = {ID_WIDTH{slv13_connect}} & slv13_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[13] = 1'b0;
	slave_resp_data[13]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[13]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	slave_resp_valid[14] = slv14_resp_valid & (slv14_resp_id[3:0]==self_id) & slv14_connect;
	slave_resp_data[14]  = {RESP_DATA_WIDTH{slv14_connect}} & slv14_resp_data;
	slave_resp_id[14]    = {ID_WIDTH{slv14_connect}} & slv14_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[14] = 1'b0;
	slave_resp_data[14]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[14]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	slave_resp_valid[15] = slv15_resp_valid & (slv15_resp_id[3:0]==self_id) & slv15_connect;
	slave_resp_data[15]  = {RESP_DATA_WIDTH{slv15_connect}} & slv15_resp_data;
	slave_resp_id[15]    = {ID_WIDTH{slv15_connect}} & slv15_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[15] = 1'b0;
	slave_resp_data[15]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[15]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	slave_resp_valid[16] = slv16_resp_valid & (slv16_resp_id[3:0]==self_id) & slv16_connect;
	slave_resp_data[16]  = {RESP_DATA_WIDTH{slv16_connect}} & slv16_resp_data;
	slave_resp_id[16]    = {ID_WIDTH{slv16_connect}} & slv16_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[16] = 1'b0;
	slave_resp_data[16]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[16]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	slave_resp_valid[17] = slv17_resp_valid & (slv17_resp_id[3:0]==self_id) & slv17_connect;
	slave_resp_data[17]  = {RESP_DATA_WIDTH{slv17_connect}} & slv17_resp_data;
	slave_resp_id[17]    = {ID_WIDTH{slv17_connect}} & slv17_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[17] = 1'b0;
	slave_resp_data[17]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[17]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	slave_resp_valid[18] = slv18_resp_valid & (slv18_resp_id[3:0]==self_id) & slv18_connect;
	slave_resp_data[18]  = {RESP_DATA_WIDTH{slv18_connect}} & slv18_resp_data;
	slave_resp_id[18]    = {ID_WIDTH{slv18_connect}} & slv18_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[18] = 1'b0;
	slave_resp_data[18]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[18]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	slave_resp_valid[19] = slv19_resp_valid & (slv19_resp_id[3:0]==self_id) & slv19_connect;
	slave_resp_data[19]  = {RESP_DATA_WIDTH{slv19_connect}} & slv19_resp_data;
	slave_resp_id[19]    = {ID_WIDTH{slv19_connect}} & slv19_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[19] = 1'b0;
	slave_resp_data[19]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[19]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	slave_resp_valid[20] = slv20_resp_valid & (slv20_resp_id[3:0]==self_id) & slv20_connect;
	slave_resp_data[20]  = {RESP_DATA_WIDTH{slv20_connect}} & slv20_resp_data;
	slave_resp_id[20]    = {ID_WIDTH{slv20_connect}} & slv20_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[20] = 1'b0;
	slave_resp_data[20]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[20]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	slave_resp_valid[21] = slv21_resp_valid & (slv21_resp_id[3:0]==self_id) & slv21_connect;
	slave_resp_data[21]  = {RESP_DATA_WIDTH{slv21_connect}} & slv21_resp_data;
	slave_resp_id[21]    = {ID_WIDTH{slv21_connect}} & slv21_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[21] = 1'b0;
	slave_resp_data[21]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[21]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	slave_resp_valid[22] = slv22_resp_valid & (slv22_resp_id[3:0]==self_id) & slv22_connect;
	slave_resp_data[22]  = {RESP_DATA_WIDTH{slv22_connect}} & slv22_resp_data;
	slave_resp_id[22]    = {ID_WIDTH{slv22_connect}} & slv22_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[22] = 1'b0;
	slave_resp_data[22]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[22]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	slave_resp_valid[23] = slv23_resp_valid & (slv23_resp_id[3:0]==self_id) & slv23_connect;
	slave_resp_data[23]  = {RESP_DATA_WIDTH{slv23_connect}} & slv23_resp_data;
	slave_resp_id[23]    = {ID_WIDTH{slv23_connect}} & slv23_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[23] = 1'b0;
	slave_resp_data[23]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[23]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	slave_resp_valid[24] = slv24_resp_valid & (slv24_resp_id[3:0]==self_id) & slv24_connect;
	slave_resp_data[24]  = {RESP_DATA_WIDTH{slv24_connect}} & slv24_resp_data;
	slave_resp_id[24]    = {ID_WIDTH{slv24_connect}} & slv24_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[24] = 1'b0;
	slave_resp_data[24]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[24]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	slave_resp_valid[25] = slv25_resp_valid & (slv25_resp_id[3:0]==self_id) & slv25_connect;
	slave_resp_data[25]  = {RESP_DATA_WIDTH{slv25_connect}} & slv25_resp_data;
	slave_resp_id[25]    = {ID_WIDTH{slv25_connect}} & slv25_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[25] = 1'b0;
	slave_resp_data[25]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[25]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	slave_resp_valid[26] = slv26_resp_valid & (slv26_resp_id[3:0]==self_id) & slv26_connect;
	slave_resp_data[26]  = {RESP_DATA_WIDTH{slv26_connect}} & slv26_resp_data;
	slave_resp_id[26]    = {ID_WIDTH{slv26_connect}} & slv26_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[26] = 1'b0;
	slave_resp_data[26]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[26]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	slave_resp_valid[27] = slv27_resp_valid & (slv27_resp_id[3:0]==self_id) & slv27_connect;
	slave_resp_data[27]  = {RESP_DATA_WIDTH{slv27_connect}} & slv27_resp_data;
	slave_resp_id[27]    = {ID_WIDTH{slv27_connect}} & slv27_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[27] = 1'b0;
	slave_resp_data[27]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[27]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	slave_resp_valid[28] = slv28_resp_valid & (slv28_resp_id[3:0]==self_id) & slv28_connect;
	slave_resp_data[28]  = {RESP_DATA_WIDTH{slv28_connect}} & slv28_resp_data;
	slave_resp_id[28]    = {ID_WIDTH{slv28_connect}} & slv28_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[28] = 1'b0;
	slave_resp_data[28]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[28]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	slave_resp_valid[29] = slv29_resp_valid & (slv29_resp_id[3:0]==self_id) & slv29_connect;
	slave_resp_data[29]  = {RESP_DATA_WIDTH{slv29_connect}} & slv29_resp_data;
	slave_resp_id[29]    = {ID_WIDTH{slv29_connect}} & slv29_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[29] = 1'b0;
	slave_resp_data[29]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[29]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	slave_resp_valid[30] = slv30_resp_valid & (slv30_resp_id[3:0]==self_id) & slv30_connect;
	slave_resp_data[30]  = {RESP_DATA_WIDTH{slv30_connect}} & slv30_resp_data;
	slave_resp_id[30]    = {ID_WIDTH{slv30_connect}} & slv30_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[30] = 1'b0;
	slave_resp_data[30]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[30]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	slave_resp_valid[31] = slv31_resp_valid & (slv31_resp_id[3:0]==self_id) & slv31_connect;
	slave_resp_data[31]  = {RESP_DATA_WIDTH{slv31_connect}} & slv31_resp_data;
	slave_resp_id[31]    = {ID_WIDTH{slv31_connect}} & slv31_resp_id[ID_MSB+4:4];
`else
	slave_resp_valid[31] = 1'b0;
	slave_resp_data[31]  = {RESP_DATA_WIDTH{1'b0}};
	slave_resp_id[31]    = {ID_WIDTH{1'b0}};
`endif
end
// VPERL_GENERATED_END
assign       mst_resp_ready = ~(resp_valid & ~resp_ready) & ~outstanding_idle;
assign dec_err_resp_ready = ~(resp_valid & ~resp_ready) & outstanding_idle;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		resp_data <= {RESP_DATA_WIDTH{1'b0}};
		resp_id   <= {ID_WIDTH{1'b0}};
		resp_valid <= 1'b0;
	end else if (dec_err_resp_valid && dec_err_resp_ready) begin
		resp_data <= dec_err_resp_data;
		resp_id   <= dec_err_resp_id[ID_MSB:0];
		resp_valid <= 1'b1;
	end else if (slave_resp_valid[mst_resp_slave_id] && mst_resp_ready) begin
		resp_data <= slave_resp_data[mst_resp_slave_id];
		resp_id   <= slave_resp_id[mst_resp_slave_id];
		resp_valid <= 1'b1;
	end else if (resp_ready)
		resp_valid <= 1'b0;
end

generate
	if (BRESP_CHANNEL==1) begin:always_bresp_last
		assign last_resp = 1'b1;
	end else begin: rdata_last
		assign last_resp = dec_err_resp_valid ? dec_err_resp_data[RESP_DATA_WIDTH-3] : slave_resp_data[mst_resp_slave_id][RESP_DATA_WIDTH-3];
	end
endgenerate
//generate
//	if (RESP_INORDER_ONLY==1) begin:inorder_fifo
		wire rsid_fifo_wr          ;
		wire [4:0] rsid_fifo_wdata       ;
		wire rsid_fifo_rd          ;
		wire [4:0] rsid_fifo_rdata       ;
		wire rsid_fifo_empty	   ;
		wire rsid_fifo_full 	   ;
		assign outstanding_idle = rsid_fifo_empty;
		assign outstanding_ready = ~rsid_fifo_full;
		assign rsid_fifo_wr    = outstanding_en;
		assign rsid_fifo_wdata = outstanding_id[4:0];
		assign rsid_fifo_rd    = slave_resp_valid[mst_resp_slave_id] & mst_resp_ready & last_resp;
		assign mst_resp_slave_id = rsid_fifo_rdata[4:0];
		nds_sync_fifo_afe #(
		                .DATA_WIDTH (5),
		                .FIFO_DEPTH (OUTSTANDING_DEPTH)
                        ) rsid_fifo (
			.reset_n     (aresetn               ),
			.clk         (aclk                  ),
			.wr          (rsid_fifo_wr          ),
			.wr_data     (rsid_fifo_wdata       ),
			.rd          (rsid_fifo_rd          ),
			.rd_data     (rsid_fifo_rdata       ),
			.almost_empty(                      ),
			.almost_full (                      ),
			.empty       (rsid_fifo_empty       ),
			.full        (rsid_fifo_full        )
					   );
//	end
//endgenerate

endmodule
