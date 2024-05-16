`include "atcbmc200_config.vh"
`include "atcbmc200_const.vh"

//--------------------------
// ATCBMC200 Register File
//--------------------------
module atcbmc200_ahbslv_rf( // VPERL: &PORTLIST;
                            // VPERL_GENERATED_BEGIN
                            	  hrdata,   
                            	  hready,   
                            	  hresp,    
                            	  hclk,     
                            	  hresetn,  
                            	  hready_in,
                            	  haddr,    
                            	  hsel,     
                            	  hsize,    
                            	  htrans,   
                            	  hwdata,   
                            	  hwrite,   
                            	  init_priority,
                            `ifdef ATCBMC200_AHB_MST0
                            	  mst0_sel_err,
                            `endif // ATCBMC200_AHB_MST0
                            `ifdef ATCBMC200_AHB_MST1
                            	  mst1_sel_err,
                            `endif // ATCBMC200_AHB_MST1
                            `ifdef ATCBMC200_AHB_MST2
                            	  mst2_sel_err,
                            `endif // ATCBMC200_AHB_MST2
                            `ifdef ATCBMC200_AHB_MST3
                            	  mst3_sel_err,
                            `endif // ATCBMC200_AHB_MST3
                            `ifdef ATCBMC200_AHB_MST4
                            	  mst4_sel_err,
                            `endif // ATCBMC200_AHB_MST4
                            `ifdef ATCBMC200_AHB_MST5
                            	  mst5_sel_err,
                            `endif // ATCBMC200_AHB_MST5
                            `ifdef ATCBMC200_AHB_MST6
                            	  mst6_sel_err,
                            `endif // ATCBMC200_AHB_MST6
                            `ifdef ATCBMC200_AHB_MST7
                            	  mst7_sel_err,
                            `endif // ATCBMC200_AHB_MST7
                            `ifdef ATCBMC200_AHB_MST8
                            	  mst8_sel_err,
                            `endif // ATCBMC200_AHB_MST8
                            `ifdef ATCBMC200_AHB_MST9
                            	  mst9_sel_err,
                            `endif // ATCBMC200_AHB_MST9
                            `ifdef ATCBMC200_AHB_MST10
                            	  mst10_sel_err,
                            `endif // ATCBMC200_AHB_MST10
                            `ifdef ATCBMC200_AHB_MST11
                            	  mst11_sel_err,
                            `endif // ATCBMC200_AHB_MST11
                            `ifdef ATCBMC200_AHB_MST12
                            	  mst12_sel_err,
                            `endif // ATCBMC200_AHB_MST12
                            `ifdef ATCBMC200_AHB_MST13
                            	  mst13_sel_err,
                            `endif // ATCBMC200_AHB_MST13
                            `ifdef ATCBMC200_AHB_MST14
                            	  mst14_sel_err,
                            `endif // ATCBMC200_AHB_MST14
                            `ifdef ATCBMC200_AHB_MST15
                            	  mst15_sel_err,
                            `endif // ATCBMC200_AHB_MST15
                            `ifdef ATCBMC200_AHB_SLV0
                            	  slv0_base,
                            	  slv0_size,
                            `endif // ATCBMC200_AHB_SLV0
                            `ifdef ATCBMC200_AHB_SLV1
                            	  slv1_base,
                            	  slv1_size,
                            `endif // ATCBMC200_AHB_SLV1
                            `ifdef ATCBMC200_AHB_SLV2
                            	  slv2_base,
                            	  slv2_size,
                            `endif // ATCBMC200_AHB_SLV2
                            `ifdef ATCBMC200_AHB_SLV3
                            	  slv3_base,
                            	  slv3_size,
                            `endif // ATCBMC200_AHB_SLV3
                            `ifdef ATCBMC200_AHB_SLV4
                            	  slv4_base,
                            	  slv4_size,
                            `endif // ATCBMC200_AHB_SLV4
                            `ifdef ATCBMC200_AHB_SLV5
                            	  slv5_base,
                            	  slv5_size,
                            `endif // ATCBMC200_AHB_SLV5
                            `ifdef ATCBMC200_AHB_SLV6
                            	  slv6_base,
                            	  slv6_size,
                            `endif // ATCBMC200_AHB_SLV6
                            `ifdef ATCBMC200_AHB_SLV7
                            	  slv7_base,
                            	  slv7_size,
                            `endif // ATCBMC200_AHB_SLV7
                            `ifdef ATCBMC200_AHB_SLV8
                            	  slv8_base,
                            	  slv8_size,
                            `endif // ATCBMC200_AHB_SLV8
                            `ifdef ATCBMC200_AHB_SLV9
                            	  slv9_base,
                            	  slv9_size,
                            `endif // ATCBMC200_AHB_SLV9
                            `ifdef ATCBMC200_AHB_SLV10
                            	  slv10_base,
                            	  slv10_size,
                            `endif // ATCBMC200_AHB_SLV10
                            `ifdef ATCBMC200_AHB_SLV11
                            	  slv11_base,
                            	  slv11_size,
                            `endif // ATCBMC200_AHB_SLV11
                            `ifdef ATCBMC200_AHB_SLV12
                            	  slv12_base,
                            	  slv12_size,
                            `endif // ATCBMC200_AHB_SLV12
                            `ifdef ATCBMC200_AHB_SLV13
                            	  slv13_base,
                            	  slv13_size,
                            `endif // ATCBMC200_AHB_SLV13
                            `ifdef ATCBMC200_AHB_SLV14
                            	  slv14_base,
                            	  slv14_size,
                            `endif // ATCBMC200_AHB_SLV14
                            `ifdef ATCBMC200_AHB_SLV15
                            	  slv15_base,
                            	  slv15_size,
                            `endif // ATCBMC200_AHB_SLV15
                            	  bmc_intr, 
                            	  mst0_highest_en,
                            	  ctrl_wen, 
                            	  resp_mode 
                            // VPERL_GENERATED_END
);

parameter ADDR_WIDTH = `ATCBMC200_ADDR_MSB + 1;

parameter DATA_WIDTH = `ATCBMC200_DATA_WIDTH;

parameter BASE_ADDR_LSB = (ADDR_WIDTH == 24) ? 10 : 20;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam DW_RATIO = DATA_WIDTH/32;

// AHB slave interface
output                     [DATA_MSB:0] hrdata;
output                                  hready;
output                            [1:0] hresp;
input                                   hclk;
input                                   hresetn;
input					hready_in;
input                      [ADDR_MSB:0] haddr;
input                                   hsel;
input                             [2:0] hsize;
input                             [1:0] htrans;
input                      [DATA_MSB:0] hwdata;
input                                   hwrite;
output                           [15:0] init_priority;

localparam HRESP_OK      = 2'b00;

//#VPERL_BEGIN
//  $MST_NUM = 16;
//  $SLV_NUM = 16;
//  for ($i = 0; $i < $MST_NUM; $i++) {
// : `ifdef ATCBMC200_AHB_MST${i} 
// : input                               mst${i}_sel_err;
// : `endif
//  }
// :
//  for ($i = 0; $i < $SLV_NUM; $i++) {
// : `ifdef ATCBMC200_AHB_SLV${i}
// : output [ADDR_MSB:BASE_ADDR_LSB] slv${i}_base;
// : output                    [3:0] slv${i}_size;
// : `endif
//  }
//#VPERL_END

//#VPERL_GENERATED_BEGIN
`ifdef ATCBMC200_AHB_MST0
input                               mst0_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST1
input                               mst1_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST2
input                               mst2_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST3
input                               mst3_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST4
input                               mst4_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST5
input                               mst5_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST6
input                               mst6_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST7
input                               mst7_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST8
input                               mst8_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST9
input                               mst9_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST10
input                               mst10_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST11
input                               mst11_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST12
input                               mst12_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST13
input                               mst13_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST14
input                               mst14_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST15
input                               mst15_sel_err;
`endif

`ifdef ATCBMC200_AHB_SLV0
output [ADDR_MSB:BASE_ADDR_LSB] slv0_base;
output                    [3:0] slv0_size;
`endif
`ifdef ATCBMC200_AHB_SLV1
output [ADDR_MSB:BASE_ADDR_LSB] slv1_base;
output                    [3:0] slv1_size;
`endif
`ifdef ATCBMC200_AHB_SLV2
output [ADDR_MSB:BASE_ADDR_LSB] slv2_base;
output                    [3:0] slv2_size;
`endif
`ifdef ATCBMC200_AHB_SLV3
output [ADDR_MSB:BASE_ADDR_LSB] slv3_base;
output                    [3:0] slv3_size;
`endif
`ifdef ATCBMC200_AHB_SLV4
output [ADDR_MSB:BASE_ADDR_LSB] slv4_base;
output                    [3:0] slv4_size;
`endif
`ifdef ATCBMC200_AHB_SLV5
output [ADDR_MSB:BASE_ADDR_LSB] slv5_base;
output                    [3:0] slv5_size;
`endif
`ifdef ATCBMC200_AHB_SLV6
output [ADDR_MSB:BASE_ADDR_LSB] slv6_base;
output                    [3:0] slv6_size;
`endif
`ifdef ATCBMC200_AHB_SLV7
output [ADDR_MSB:BASE_ADDR_LSB] slv7_base;
output                    [3:0] slv7_size;
`endif
`ifdef ATCBMC200_AHB_SLV8
output [ADDR_MSB:BASE_ADDR_LSB] slv8_base;
output                    [3:0] slv8_size;
`endif
`ifdef ATCBMC200_AHB_SLV9
output [ADDR_MSB:BASE_ADDR_LSB] slv9_base;
output                    [3:0] slv9_size;
`endif
`ifdef ATCBMC200_AHB_SLV10
output [ADDR_MSB:BASE_ADDR_LSB] slv10_base;
output                    [3:0] slv10_size;
`endif
`ifdef ATCBMC200_AHB_SLV11
output [ADDR_MSB:BASE_ADDR_LSB] slv11_base;
output                    [3:0] slv11_size;
`endif
`ifdef ATCBMC200_AHB_SLV12
output [ADDR_MSB:BASE_ADDR_LSB] slv12_base;
output                    [3:0] slv12_size;
`endif
`ifdef ATCBMC200_AHB_SLV13
output [ADDR_MSB:BASE_ADDR_LSB] slv13_base;
output                    [3:0] slv13_size;
`endif
`ifdef ATCBMC200_AHB_SLV14
output [ADDR_MSB:BASE_ADDR_LSB] slv14_base;
output                    [3:0] slv14_size;
`endif
`ifdef ATCBMC200_AHB_SLV15
output [ADDR_MSB:BASE_ADDR_LSB] slv15_base;
output                    [3:0] slv15_size;
`endif
//#VPERL_GENERATED_END

output                              bmc_intr;
output                              mst0_highest_en;
output                              ctrl_wen;
output                              resp_mode;

//
// VPERL_BEGIN
// for ($i = 0; $i < 11; $i++) {
//: `ifdef ATCBMC200_AHB_SLV${i}
//: parameter [ADDR_MSB:0] AHB_SLV${i}_BASE = `ATCBMC200_AHB_SLV${i}_BASE;
//: assign slv${i}_base = AHB_SLV${i}_BASE[ADDR_MSB:BASE_ADDR_LSB];
//: assign slv${i}_size = `ATCBMC200_AHB_SLV${i}_SIZE;
//: `endif
// }
// for ($i = 11; $i < 16; $i++) {
//: `ifdef ATCBMC200_AHB_SLV${i} 
//: parameter [ADDR_MSB:0] AHB_SLV${i}_BASE = `ATCBMC200_AHB_SLV${i}_BASE;
//: `endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC200_AHB_SLV0
parameter [ADDR_MSB:0] AHB_SLV0_BASE = `ATCBMC200_AHB_SLV0_BASE;
assign slv0_base = AHB_SLV0_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv0_size = `ATCBMC200_AHB_SLV0_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV1
parameter [ADDR_MSB:0] AHB_SLV1_BASE = `ATCBMC200_AHB_SLV1_BASE;
assign slv1_base = AHB_SLV1_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv1_size = `ATCBMC200_AHB_SLV1_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV2
parameter [ADDR_MSB:0] AHB_SLV2_BASE = `ATCBMC200_AHB_SLV2_BASE;
assign slv2_base = AHB_SLV2_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv2_size = `ATCBMC200_AHB_SLV2_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV3
parameter [ADDR_MSB:0] AHB_SLV3_BASE = `ATCBMC200_AHB_SLV3_BASE;
assign slv3_base = AHB_SLV3_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv3_size = `ATCBMC200_AHB_SLV3_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV4
parameter [ADDR_MSB:0] AHB_SLV4_BASE = `ATCBMC200_AHB_SLV4_BASE;
assign slv4_base = AHB_SLV4_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv4_size = `ATCBMC200_AHB_SLV4_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV5
parameter [ADDR_MSB:0] AHB_SLV5_BASE = `ATCBMC200_AHB_SLV5_BASE;
assign slv5_base = AHB_SLV5_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv5_size = `ATCBMC200_AHB_SLV5_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV6
parameter [ADDR_MSB:0] AHB_SLV6_BASE = `ATCBMC200_AHB_SLV6_BASE;
assign slv6_base = AHB_SLV6_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv6_size = `ATCBMC200_AHB_SLV6_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV7
parameter [ADDR_MSB:0] AHB_SLV7_BASE = `ATCBMC200_AHB_SLV7_BASE;
assign slv7_base = AHB_SLV7_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv7_size = `ATCBMC200_AHB_SLV7_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV8
parameter [ADDR_MSB:0] AHB_SLV8_BASE = `ATCBMC200_AHB_SLV8_BASE;
assign slv8_base = AHB_SLV8_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv8_size = `ATCBMC200_AHB_SLV8_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV9
parameter [ADDR_MSB:0] AHB_SLV9_BASE = `ATCBMC200_AHB_SLV9_BASE;
assign slv9_base = AHB_SLV9_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv9_size = `ATCBMC200_AHB_SLV9_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV10
parameter [ADDR_MSB:0] AHB_SLV10_BASE = `ATCBMC200_AHB_SLV10_BASE;
assign slv10_base = AHB_SLV10_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv10_size = `ATCBMC200_AHB_SLV10_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV11
parameter [ADDR_MSB:0] AHB_SLV11_BASE = `ATCBMC200_AHB_SLV11_BASE;
`endif
`ifdef ATCBMC200_AHB_SLV12
parameter [ADDR_MSB:0] AHB_SLV12_BASE = `ATCBMC200_AHB_SLV12_BASE;
`endif
`ifdef ATCBMC200_AHB_SLV13
parameter [ADDR_MSB:0] AHB_SLV13_BASE = `ATCBMC200_AHB_SLV13_BASE;
`endif
`ifdef ATCBMC200_AHB_SLV14
parameter [ADDR_MSB:0] AHB_SLV14_BASE = `ATCBMC200_AHB_SLV14_BASE;
`endif
`ifdef ATCBMC200_AHB_SLV15
parameter [ADDR_MSB:0] AHB_SLV15_BASE = `ATCBMC200_AHB_SLV15_BASE;
`endif
// VPERL_GENERATED_END

`ifdef ATCBMC200_AHB_SLV11
reg [ADDR_MSB:BASE_ADDR_LSB] slv11_base;
reg                    [3:0] slv11_size;
`endif
`ifdef ATCBMC200_AHB_SLV12
reg [ADDR_MSB:BASE_ADDR_LSB] slv12_base;
reg                    [3:0] slv12_size;
`endif
`ifdef ATCBMC200_AHB_SLV13
reg [ADDR_MSB:BASE_ADDR_LSB] slv13_base;
reg                    [3:0] slv13_size;
`endif
`ifdef ATCBMC200_AHB_SLV14
reg [ADDR_MSB:BASE_ADDR_LSB] slv14_base;
reg                    [3:0] slv14_size;
`endif
`ifdef ATCBMC200_AHB_SLV15
reg [ADDR_MSB:BASE_ADDR_LSB] slv15_base;
reg                    [3:0] slv15_size;
`endif


reg                                    mst0_highest_en;
reg                                    intr_en;

wire                            [15:0] intr_mst_sel_err;
wire                            [15:0] init_priority;
// VPERL_BEGIN
// $MST_NUM = 16;
//
// for ($i = 0; $i < $MST_NUM; $i++) {
//: `ifdef ATCBMC200_AHB_MST${i} 
//:     reg                                  intr_mst${i}_sel_err;
//:     reg                                  init_priority${i};
//: `endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC200_AHB_MST0
    reg                                  intr_mst0_sel_err;
    reg                                  init_priority0;
`endif
`ifdef ATCBMC200_AHB_MST1
    reg                                  intr_mst1_sel_err;
    reg                                  init_priority1;
`endif
`ifdef ATCBMC200_AHB_MST2
    reg                                  intr_mst2_sel_err;
    reg                                  init_priority2;
`endif
`ifdef ATCBMC200_AHB_MST3
    reg                                  intr_mst3_sel_err;
    reg                                  init_priority3;
`endif
`ifdef ATCBMC200_AHB_MST4
    reg                                  intr_mst4_sel_err;
    reg                                  init_priority4;
`endif
`ifdef ATCBMC200_AHB_MST5
    reg                                  intr_mst5_sel_err;
    reg                                  init_priority5;
`endif
`ifdef ATCBMC200_AHB_MST6
    reg                                  intr_mst6_sel_err;
    reg                                  init_priority6;
`endif
`ifdef ATCBMC200_AHB_MST7
    reg                                  intr_mst7_sel_err;
    reg                                  init_priority7;
`endif
`ifdef ATCBMC200_AHB_MST8
    reg                                  intr_mst8_sel_err;
    reg                                  init_priority8;
`endif
`ifdef ATCBMC200_AHB_MST9
    reg                                  intr_mst9_sel_err;
    reg                                  init_priority9;
`endif
`ifdef ATCBMC200_AHB_MST10
    reg                                  intr_mst10_sel_err;
    reg                                  init_priority10;
`endif
`ifdef ATCBMC200_AHB_MST11
    reg                                  intr_mst11_sel_err;
    reg                                  init_priority11;
`endif
`ifdef ATCBMC200_AHB_MST12
    reg                                  intr_mst12_sel_err;
    reg                                  init_priority12;
`endif
`ifdef ATCBMC200_AHB_MST13
    reg                                  intr_mst13_sel_err;
    reg                                  init_priority13;
`endif
`ifdef ATCBMC200_AHB_MST14
    reg                                  intr_mst14_sel_err;
    reg                                  init_priority14;
`endif
`ifdef ATCBMC200_AHB_MST15
    reg                                  intr_mst15_sel_err;
    reg                                  init_priority15;
`endif
// VPERL_GENERATED_END

reg                                    resp_mode;

reg				       read_af_write;
reg				 [7:2] haddr_d1;
wire	                        [31:0] hwdata_32_array[0:31];
wire	                               hwdata_32_array_hit[0:31];
wire	                         [3:0] hwdata_32_array_wbe[0:31];
reg             [((DATA_WIDTH/8)-1):0] wbe;
reg             [((DATA_WIDTH/8)-1):0] wbe_nxt;
reg                       [DATA_MSB:0] hrdata;
wire                      [DATA_MSB:0] hrdata_match_data_width;
wire	                        [31:0] hrdata_32_array[0:31];

wire                                   ren;
wire                                   wen;
reg                                    priority_wen;
reg                                    ctrl_wen;
reg                                    intr_wen;
`ifdef ATCBMC200_AHB_SLV11 
reg         slv11_wen; 
`endif 
`ifdef ATCBMC200_AHB_SLV12
reg         slv12_wen; 
`endif
`ifdef ATCBMC200_AHB_SLV13
reg         slv13_wen; 
`endif
`ifdef ATCBMC200_AHB_SLV14
reg         slv14_wen; 
`endif
`ifdef ATCBMC200_AHB_SLV15
reg         slv15_wen; 
`endif


// VPERL_BEGIN
// $MST_NUM = 16;
// : assign bmc_intr = intr_en & ( 
// for ($i = $MST_NUM - 1; $i >= 0; $i--) {
//: `ifdef ATCBMC200_AHB_MST${i} 
//:                    intr_mst${i}_sel_err |
//: `endif
// }
//:                    1'b0 );
// VPERL_END

// VPERL_GENERATED_BEGIN
assign bmc_intr = intr_en & (
`ifdef ATCBMC200_AHB_MST15
                   intr_mst15_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST14
                   intr_mst14_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST13
                   intr_mst13_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST12
                   intr_mst12_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST11
                   intr_mst11_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST10
                   intr_mst10_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST9
                   intr_mst9_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST8
                   intr_mst8_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST7
                   intr_mst7_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST6
                   intr_mst6_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST5
                   intr_mst5_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST4
                   intr_mst4_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST3
                   intr_mst3_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST2
                   intr_mst2_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST1
                   intr_mst1_sel_err |
`endif
`ifdef ATCBMC200_AHB_MST0
                   intr_mst0_sel_err |
`endif
                   1'b0 );
// VPERL_GENERATED_END

// hready is low at read writable register after write the register continuously
assign hready = (~read_af_write);

always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
	read_af_write <= 1'b0;
	haddr_d1      <= 6'h0;
    end else begin
	read_af_write <= (ren & (
	        	(ctrl_wen     & hwdata_32_array_hit[5]) |
	        	(intr_wen     & hwdata_32_array_hit[6]) |
`ifdef ATCBMC200_AHB_SLV11
		      	(slv11_wen    & hwdata_32_array_hit[18]) | 
`endif
`ifdef ATCBMC200_AHB_SLV12
		      	(slv12_wen    & hwdata_32_array_hit[19]) | 
`endif
`ifdef ATCBMC200_AHB_SLV13
		      	(slv13_wen    & hwdata_32_array_hit[20]) | 
`endif
`ifdef ATCBMC200_AHB_SLV14
		      	(slv14_wen    & hwdata_32_array_hit[21]) | 
`endif
`ifdef ATCBMC200_AHB_SLV15
		      	(slv15_wen    & hwdata_32_array_hit[22]) | 
`endif
			(priority_wen & hwdata_32_array_hit[4]))) ;
	haddr_d1      <= haddr[7:2];
    end
end

assign hresp  = HRESP_OK; 


assign wen = hsel & hready_in & hwrite & htrans[1];

// VPERL_BEGIN
// $max_dw = 1024; 
// $max_dw_log2 = log($max_dw/32)/log(2);
// : generate
// for ($i = 0; $i <= $max_dw_log2; $i++) {
// 	$wbe = 2 ** ($i + 2) ;
// 	$dw = 2 ** ($i + 5) ;
//: if (DATA_WIDTH == $dw) begin: gen_hwdata_wbe_$dw
//: 	always @* begin
//:		case (hsize[2:0])
//		for ($hsize=0 ; $hsize <= (log($dw/8)/log(2)) ; $hsize++) {
//:			3\'b%03b: begin	:: $hsize
//			$wbe_nxt_width = (2**$hsize);
//			$msb = ((log($dw/8)/log(2)) - 1);
//			$lsb = $hsize;
//			$compare_aw = ($msb+1) - $lsb;
//			for ($j=$wbe-1 ; $j >= 0 ; $j = $j - $wbe_nxt_width) {
//				$l_brace = ($wbe_nxt_width > 1) ? "{" . $wbe_nxt_width . "{" : " ";
//				$r_brace = ($wbe_nxt_width > 1) ? "}}" : " ";
//				if ($compare_aw > 0) {
//: 				wbe_nxt[%s] = %s(haddr[%s] == ${compare_aw}\'b%0${compare_aw}b)%s;	:: (($hsize>0) ? ($j . ":" . ($j - $wbe_nxt_width+1)) : $j), $l_brace,  (($msb==$lsb) ? $lsb : $msb . ":" .$lsb), ($j >> $lsb), $r_brace
//				} else {
//: 				wbe_nxt[%d:0] = {%d{1'b1}};	:: $wbe - 1 ,$wbe,(2**$wbe) - 1
//				}
//			}
//:			end
//		}
//:			default:
//:				wbe_nxt = $wbe\'b0;
//:		endcase
//:	end
//: end
// }
//: endgenerate
// VPERL_END

// VPERL_GENERATED_BEGIN
generate
if (DATA_WIDTH == 32) begin: gen_hwdata_wbe_32
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				wbe_nxt[3] =  (haddr[1:0] == 2'b11) ;
				wbe_nxt[2] =  (haddr[1:0] == 2'b10) ;
				wbe_nxt[1] =  (haddr[1:0] == 2'b01) ;
				wbe_nxt[0] =  (haddr[1:0] == 2'b00) ;
			end
			3'b001: begin
				wbe_nxt[3:2] = {2{(haddr[1] == 1'b1)}};
				wbe_nxt[1:0] = {2{(haddr[1] == 1'b0)}};
			end
			3'b010: begin
				wbe_nxt[3:0] = {4{1'b1}};
			end
			default:
				wbe_nxt = 4'b0;
		endcase
	end
end
if (DATA_WIDTH == 64) begin: gen_hwdata_wbe_64
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				wbe_nxt[7] =  (haddr[2:0] == 3'b111) ;
				wbe_nxt[6] =  (haddr[2:0] == 3'b110) ;
				wbe_nxt[5] =  (haddr[2:0] == 3'b101) ;
				wbe_nxt[4] =  (haddr[2:0] == 3'b100) ;
				wbe_nxt[3] =  (haddr[2:0] == 3'b011) ;
				wbe_nxt[2] =  (haddr[2:0] == 3'b010) ;
				wbe_nxt[1] =  (haddr[2:0] == 3'b001) ;
				wbe_nxt[0] =  (haddr[2:0] == 3'b000) ;
			end
			3'b001: begin
				wbe_nxt[7:6] = {2{(haddr[2:1] == 2'b11)}};
				wbe_nxt[5:4] = {2{(haddr[2:1] == 2'b10)}};
				wbe_nxt[3:2] = {2{(haddr[2:1] == 2'b01)}};
				wbe_nxt[1:0] = {2{(haddr[2:1] == 2'b00)}};
			end
			3'b010: begin
				wbe_nxt[7:4] = {4{(haddr[2] == 1'b1)}};
				wbe_nxt[3:0] = {4{(haddr[2] == 1'b0)}};
			end
			3'b011: begin
				wbe_nxt[7:0] = {8{1'b1}};
			end
			default:
				wbe_nxt = 8'b0;
		endcase
	end
end
if (DATA_WIDTH == 128) begin: gen_hwdata_wbe_128
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				wbe_nxt[15] =  (haddr[3:0] == 4'b1111) ;
				wbe_nxt[14] =  (haddr[3:0] == 4'b1110) ;
				wbe_nxt[13] =  (haddr[3:0] == 4'b1101) ;
				wbe_nxt[12] =  (haddr[3:0] == 4'b1100) ;
				wbe_nxt[11] =  (haddr[3:0] == 4'b1011) ;
				wbe_nxt[10] =  (haddr[3:0] == 4'b1010) ;
				wbe_nxt[9] =  (haddr[3:0] == 4'b1001) ;
				wbe_nxt[8] =  (haddr[3:0] == 4'b1000) ;
				wbe_nxt[7] =  (haddr[3:0] == 4'b0111) ;
				wbe_nxt[6] =  (haddr[3:0] == 4'b0110) ;
				wbe_nxt[5] =  (haddr[3:0] == 4'b0101) ;
				wbe_nxt[4] =  (haddr[3:0] == 4'b0100) ;
				wbe_nxt[3] =  (haddr[3:0] == 4'b0011) ;
				wbe_nxt[2] =  (haddr[3:0] == 4'b0010) ;
				wbe_nxt[1] =  (haddr[3:0] == 4'b0001) ;
				wbe_nxt[0] =  (haddr[3:0] == 4'b0000) ;
			end
			3'b001: begin
				wbe_nxt[15:14] = {2{(haddr[3:1] == 3'b111)}};
				wbe_nxt[13:12] = {2{(haddr[3:1] == 3'b110)}};
				wbe_nxt[11:10] = {2{(haddr[3:1] == 3'b101)}};
				wbe_nxt[9:8] = {2{(haddr[3:1] == 3'b100)}};
				wbe_nxt[7:6] = {2{(haddr[3:1] == 3'b011)}};
				wbe_nxt[5:4] = {2{(haddr[3:1] == 3'b010)}};
				wbe_nxt[3:2] = {2{(haddr[3:1] == 3'b001)}};
				wbe_nxt[1:0] = {2{(haddr[3:1] == 3'b000)}};
			end
			3'b010: begin
				wbe_nxt[15:12] = {4{(haddr[3:2] == 2'b11)}};
				wbe_nxt[11:8] = {4{(haddr[3:2] == 2'b10)}};
				wbe_nxt[7:4] = {4{(haddr[3:2] == 2'b01)}};
				wbe_nxt[3:0] = {4{(haddr[3:2] == 2'b00)}};
			end
			3'b011: begin
				wbe_nxt[15:8] = {8{(haddr[3] == 1'b1)}};
				wbe_nxt[7:0] = {8{(haddr[3] == 1'b0)}};
			end
			3'b100: begin
				wbe_nxt[15:0] = {16{1'b1}};
			end
			default:
				wbe_nxt = 16'b0;
		endcase
	end
end
if (DATA_WIDTH == 256) begin: gen_hwdata_wbe_256
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				wbe_nxt[31] =  (haddr[4:0] == 5'b11111) ;
				wbe_nxt[30] =  (haddr[4:0] == 5'b11110) ;
				wbe_nxt[29] =  (haddr[4:0] == 5'b11101) ;
				wbe_nxt[28] =  (haddr[4:0] == 5'b11100) ;
				wbe_nxt[27] =  (haddr[4:0] == 5'b11011) ;
				wbe_nxt[26] =  (haddr[4:0] == 5'b11010) ;
				wbe_nxt[25] =  (haddr[4:0] == 5'b11001) ;
				wbe_nxt[24] =  (haddr[4:0] == 5'b11000) ;
				wbe_nxt[23] =  (haddr[4:0] == 5'b10111) ;
				wbe_nxt[22] =  (haddr[4:0] == 5'b10110) ;
				wbe_nxt[21] =  (haddr[4:0] == 5'b10101) ;
				wbe_nxt[20] =  (haddr[4:0] == 5'b10100) ;
				wbe_nxt[19] =  (haddr[4:0] == 5'b10011) ;
				wbe_nxt[18] =  (haddr[4:0] == 5'b10010) ;
				wbe_nxt[17] =  (haddr[4:0] == 5'b10001) ;
				wbe_nxt[16] =  (haddr[4:0] == 5'b10000) ;
				wbe_nxt[15] =  (haddr[4:0] == 5'b01111) ;
				wbe_nxt[14] =  (haddr[4:0] == 5'b01110) ;
				wbe_nxt[13] =  (haddr[4:0] == 5'b01101) ;
				wbe_nxt[12] =  (haddr[4:0] == 5'b01100) ;
				wbe_nxt[11] =  (haddr[4:0] == 5'b01011) ;
				wbe_nxt[10] =  (haddr[4:0] == 5'b01010) ;
				wbe_nxt[9] =  (haddr[4:0] == 5'b01001) ;
				wbe_nxt[8] =  (haddr[4:0] == 5'b01000) ;
				wbe_nxt[7] =  (haddr[4:0] == 5'b00111) ;
				wbe_nxt[6] =  (haddr[4:0] == 5'b00110) ;
				wbe_nxt[5] =  (haddr[4:0] == 5'b00101) ;
				wbe_nxt[4] =  (haddr[4:0] == 5'b00100) ;
				wbe_nxt[3] =  (haddr[4:0] == 5'b00011) ;
				wbe_nxt[2] =  (haddr[4:0] == 5'b00010) ;
				wbe_nxt[1] =  (haddr[4:0] == 5'b00001) ;
				wbe_nxt[0] =  (haddr[4:0] == 5'b00000) ;
			end
			3'b001: begin
				wbe_nxt[31:30] = {2{(haddr[4:1] == 4'b1111)}};
				wbe_nxt[29:28] = {2{(haddr[4:1] == 4'b1110)}};
				wbe_nxt[27:26] = {2{(haddr[4:1] == 4'b1101)}};
				wbe_nxt[25:24] = {2{(haddr[4:1] == 4'b1100)}};
				wbe_nxt[23:22] = {2{(haddr[4:1] == 4'b1011)}};
				wbe_nxt[21:20] = {2{(haddr[4:1] == 4'b1010)}};
				wbe_nxt[19:18] = {2{(haddr[4:1] == 4'b1001)}};
				wbe_nxt[17:16] = {2{(haddr[4:1] == 4'b1000)}};
				wbe_nxt[15:14] = {2{(haddr[4:1] == 4'b0111)}};
				wbe_nxt[13:12] = {2{(haddr[4:1] == 4'b0110)}};
				wbe_nxt[11:10] = {2{(haddr[4:1] == 4'b0101)}};
				wbe_nxt[9:8] = {2{(haddr[4:1] == 4'b0100)}};
				wbe_nxt[7:6] = {2{(haddr[4:1] == 4'b0011)}};
				wbe_nxt[5:4] = {2{(haddr[4:1] == 4'b0010)}};
				wbe_nxt[3:2] = {2{(haddr[4:1] == 4'b0001)}};
				wbe_nxt[1:0] = {2{(haddr[4:1] == 4'b0000)}};
			end
			3'b010: begin
				wbe_nxt[31:28] = {4{(haddr[4:2] == 3'b111)}};
				wbe_nxt[27:24] = {4{(haddr[4:2] == 3'b110)}};
				wbe_nxt[23:20] = {4{(haddr[4:2] == 3'b101)}};
				wbe_nxt[19:16] = {4{(haddr[4:2] == 3'b100)}};
				wbe_nxt[15:12] = {4{(haddr[4:2] == 3'b011)}};
				wbe_nxt[11:8] = {4{(haddr[4:2] == 3'b010)}};
				wbe_nxt[7:4] = {4{(haddr[4:2] == 3'b001)}};
				wbe_nxt[3:0] = {4{(haddr[4:2] == 3'b000)}};
			end
			3'b011: begin
				wbe_nxt[31:24] = {8{(haddr[4:3] == 2'b11)}};
				wbe_nxt[23:16] = {8{(haddr[4:3] == 2'b10)}};
				wbe_nxt[15:8] = {8{(haddr[4:3] == 2'b01)}};
				wbe_nxt[7:0] = {8{(haddr[4:3] == 2'b00)}};
			end
			3'b100: begin
				wbe_nxt[31:16] = {16{(haddr[4] == 1'b1)}};
				wbe_nxt[15:0] = {16{(haddr[4] == 1'b0)}};
			end
			3'b101: begin
				wbe_nxt[31:0] = {32{1'b1}};
			end
			default:
				wbe_nxt = 32'b0;
		endcase
	end
end
if (DATA_WIDTH == 512) begin: gen_hwdata_wbe_512
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				wbe_nxt[63] =  (haddr[5:0] == 6'b111111) ;
				wbe_nxt[62] =  (haddr[5:0] == 6'b111110) ;
				wbe_nxt[61] =  (haddr[5:0] == 6'b111101) ;
				wbe_nxt[60] =  (haddr[5:0] == 6'b111100) ;
				wbe_nxt[59] =  (haddr[5:0] == 6'b111011) ;
				wbe_nxt[58] =  (haddr[5:0] == 6'b111010) ;
				wbe_nxt[57] =  (haddr[5:0] == 6'b111001) ;
				wbe_nxt[56] =  (haddr[5:0] == 6'b111000) ;
				wbe_nxt[55] =  (haddr[5:0] == 6'b110111) ;
				wbe_nxt[54] =  (haddr[5:0] == 6'b110110) ;
				wbe_nxt[53] =  (haddr[5:0] == 6'b110101) ;
				wbe_nxt[52] =  (haddr[5:0] == 6'b110100) ;
				wbe_nxt[51] =  (haddr[5:0] == 6'b110011) ;
				wbe_nxt[50] =  (haddr[5:0] == 6'b110010) ;
				wbe_nxt[49] =  (haddr[5:0] == 6'b110001) ;
				wbe_nxt[48] =  (haddr[5:0] == 6'b110000) ;
				wbe_nxt[47] =  (haddr[5:0] == 6'b101111) ;
				wbe_nxt[46] =  (haddr[5:0] == 6'b101110) ;
				wbe_nxt[45] =  (haddr[5:0] == 6'b101101) ;
				wbe_nxt[44] =  (haddr[5:0] == 6'b101100) ;
				wbe_nxt[43] =  (haddr[5:0] == 6'b101011) ;
				wbe_nxt[42] =  (haddr[5:0] == 6'b101010) ;
				wbe_nxt[41] =  (haddr[5:0] == 6'b101001) ;
				wbe_nxt[40] =  (haddr[5:0] == 6'b101000) ;
				wbe_nxt[39] =  (haddr[5:0] == 6'b100111) ;
				wbe_nxt[38] =  (haddr[5:0] == 6'b100110) ;
				wbe_nxt[37] =  (haddr[5:0] == 6'b100101) ;
				wbe_nxt[36] =  (haddr[5:0] == 6'b100100) ;
				wbe_nxt[35] =  (haddr[5:0] == 6'b100011) ;
				wbe_nxt[34] =  (haddr[5:0] == 6'b100010) ;
				wbe_nxt[33] =  (haddr[5:0] == 6'b100001) ;
				wbe_nxt[32] =  (haddr[5:0] == 6'b100000) ;
				wbe_nxt[31] =  (haddr[5:0] == 6'b011111) ;
				wbe_nxt[30] =  (haddr[5:0] == 6'b011110) ;
				wbe_nxt[29] =  (haddr[5:0] == 6'b011101) ;
				wbe_nxt[28] =  (haddr[5:0] == 6'b011100) ;
				wbe_nxt[27] =  (haddr[5:0] == 6'b011011) ;
				wbe_nxt[26] =  (haddr[5:0] == 6'b011010) ;
				wbe_nxt[25] =  (haddr[5:0] == 6'b011001) ;
				wbe_nxt[24] =  (haddr[5:0] == 6'b011000) ;
				wbe_nxt[23] =  (haddr[5:0] == 6'b010111) ;
				wbe_nxt[22] =  (haddr[5:0] == 6'b010110) ;
				wbe_nxt[21] =  (haddr[5:0] == 6'b010101) ;
				wbe_nxt[20] =  (haddr[5:0] == 6'b010100) ;
				wbe_nxt[19] =  (haddr[5:0] == 6'b010011) ;
				wbe_nxt[18] =  (haddr[5:0] == 6'b010010) ;
				wbe_nxt[17] =  (haddr[5:0] == 6'b010001) ;
				wbe_nxt[16] =  (haddr[5:0] == 6'b010000) ;
				wbe_nxt[15] =  (haddr[5:0] == 6'b001111) ;
				wbe_nxt[14] =  (haddr[5:0] == 6'b001110) ;
				wbe_nxt[13] =  (haddr[5:0] == 6'b001101) ;
				wbe_nxt[12] =  (haddr[5:0] == 6'b001100) ;
				wbe_nxt[11] =  (haddr[5:0] == 6'b001011) ;
				wbe_nxt[10] =  (haddr[5:0] == 6'b001010) ;
				wbe_nxt[9] =  (haddr[5:0] == 6'b001001) ;
				wbe_nxt[8] =  (haddr[5:0] == 6'b001000) ;
				wbe_nxt[7] =  (haddr[5:0] == 6'b000111) ;
				wbe_nxt[6] =  (haddr[5:0] == 6'b000110) ;
				wbe_nxt[5] =  (haddr[5:0] == 6'b000101) ;
				wbe_nxt[4] =  (haddr[5:0] == 6'b000100) ;
				wbe_nxt[3] =  (haddr[5:0] == 6'b000011) ;
				wbe_nxt[2] =  (haddr[5:0] == 6'b000010) ;
				wbe_nxt[1] =  (haddr[5:0] == 6'b000001) ;
				wbe_nxt[0] =  (haddr[5:0] == 6'b000000) ;
			end
			3'b001: begin
				wbe_nxt[63:62] = {2{(haddr[5:1] == 5'b11111)}};
				wbe_nxt[61:60] = {2{(haddr[5:1] == 5'b11110)}};
				wbe_nxt[59:58] = {2{(haddr[5:1] == 5'b11101)}};
				wbe_nxt[57:56] = {2{(haddr[5:1] == 5'b11100)}};
				wbe_nxt[55:54] = {2{(haddr[5:1] == 5'b11011)}};
				wbe_nxt[53:52] = {2{(haddr[5:1] == 5'b11010)}};
				wbe_nxt[51:50] = {2{(haddr[5:1] == 5'b11001)}};
				wbe_nxt[49:48] = {2{(haddr[5:1] == 5'b11000)}};
				wbe_nxt[47:46] = {2{(haddr[5:1] == 5'b10111)}};
				wbe_nxt[45:44] = {2{(haddr[5:1] == 5'b10110)}};
				wbe_nxt[43:42] = {2{(haddr[5:1] == 5'b10101)}};
				wbe_nxt[41:40] = {2{(haddr[5:1] == 5'b10100)}};
				wbe_nxt[39:38] = {2{(haddr[5:1] == 5'b10011)}};
				wbe_nxt[37:36] = {2{(haddr[5:1] == 5'b10010)}};
				wbe_nxt[35:34] = {2{(haddr[5:1] == 5'b10001)}};
				wbe_nxt[33:32] = {2{(haddr[5:1] == 5'b10000)}};
				wbe_nxt[31:30] = {2{(haddr[5:1] == 5'b01111)}};
				wbe_nxt[29:28] = {2{(haddr[5:1] == 5'b01110)}};
				wbe_nxt[27:26] = {2{(haddr[5:1] == 5'b01101)}};
				wbe_nxt[25:24] = {2{(haddr[5:1] == 5'b01100)}};
				wbe_nxt[23:22] = {2{(haddr[5:1] == 5'b01011)}};
				wbe_nxt[21:20] = {2{(haddr[5:1] == 5'b01010)}};
				wbe_nxt[19:18] = {2{(haddr[5:1] == 5'b01001)}};
				wbe_nxt[17:16] = {2{(haddr[5:1] == 5'b01000)}};
				wbe_nxt[15:14] = {2{(haddr[5:1] == 5'b00111)}};
				wbe_nxt[13:12] = {2{(haddr[5:1] == 5'b00110)}};
				wbe_nxt[11:10] = {2{(haddr[5:1] == 5'b00101)}};
				wbe_nxt[9:8] = {2{(haddr[5:1] == 5'b00100)}};
				wbe_nxt[7:6] = {2{(haddr[5:1] == 5'b00011)}};
				wbe_nxt[5:4] = {2{(haddr[5:1] == 5'b00010)}};
				wbe_nxt[3:2] = {2{(haddr[5:1] == 5'b00001)}};
				wbe_nxt[1:0] = {2{(haddr[5:1] == 5'b00000)}};
			end
			3'b010: begin
				wbe_nxt[63:60] = {4{(haddr[5:2] == 4'b1111)}};
				wbe_nxt[59:56] = {4{(haddr[5:2] == 4'b1110)}};
				wbe_nxt[55:52] = {4{(haddr[5:2] == 4'b1101)}};
				wbe_nxt[51:48] = {4{(haddr[5:2] == 4'b1100)}};
				wbe_nxt[47:44] = {4{(haddr[5:2] == 4'b1011)}};
				wbe_nxt[43:40] = {4{(haddr[5:2] == 4'b1010)}};
				wbe_nxt[39:36] = {4{(haddr[5:2] == 4'b1001)}};
				wbe_nxt[35:32] = {4{(haddr[5:2] == 4'b1000)}};
				wbe_nxt[31:28] = {4{(haddr[5:2] == 4'b0111)}};
				wbe_nxt[27:24] = {4{(haddr[5:2] == 4'b0110)}};
				wbe_nxt[23:20] = {4{(haddr[5:2] == 4'b0101)}};
				wbe_nxt[19:16] = {4{(haddr[5:2] == 4'b0100)}};
				wbe_nxt[15:12] = {4{(haddr[5:2] == 4'b0011)}};
				wbe_nxt[11:8] = {4{(haddr[5:2] == 4'b0010)}};
				wbe_nxt[7:4] = {4{(haddr[5:2] == 4'b0001)}};
				wbe_nxt[3:0] = {4{(haddr[5:2] == 4'b0000)}};
			end
			3'b011: begin
				wbe_nxt[63:56] = {8{(haddr[5:3] == 3'b111)}};
				wbe_nxt[55:48] = {8{(haddr[5:3] == 3'b110)}};
				wbe_nxt[47:40] = {8{(haddr[5:3] == 3'b101)}};
				wbe_nxt[39:32] = {8{(haddr[5:3] == 3'b100)}};
				wbe_nxt[31:24] = {8{(haddr[5:3] == 3'b011)}};
				wbe_nxt[23:16] = {8{(haddr[5:3] == 3'b010)}};
				wbe_nxt[15:8] = {8{(haddr[5:3] == 3'b001)}};
				wbe_nxt[7:0] = {8{(haddr[5:3] == 3'b000)}};
			end
			3'b100: begin
				wbe_nxt[63:48] = {16{(haddr[5:4] == 2'b11)}};
				wbe_nxt[47:32] = {16{(haddr[5:4] == 2'b10)}};
				wbe_nxt[31:16] = {16{(haddr[5:4] == 2'b01)}};
				wbe_nxt[15:0] = {16{(haddr[5:4] == 2'b00)}};
			end
			3'b101: begin
				wbe_nxt[63:32] = {32{(haddr[5] == 1'b1)}};
				wbe_nxt[31:0] = {32{(haddr[5] == 1'b0)}};
			end
			3'b110: begin
				wbe_nxt[63:0] = {64{1'b1}};
			end
			default:
				wbe_nxt = 64'b0;
		endcase
	end
end
if (DATA_WIDTH == 1024) begin: gen_hwdata_wbe_1024
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				wbe_nxt[127] =  (haddr[6:0] == 7'b1111111) ;
				wbe_nxt[126] =  (haddr[6:0] == 7'b1111110) ;
				wbe_nxt[125] =  (haddr[6:0] == 7'b1111101) ;
				wbe_nxt[124] =  (haddr[6:0] == 7'b1111100) ;
				wbe_nxt[123] =  (haddr[6:0] == 7'b1111011) ;
				wbe_nxt[122] =  (haddr[6:0] == 7'b1111010) ;
				wbe_nxt[121] =  (haddr[6:0] == 7'b1111001) ;
				wbe_nxt[120] =  (haddr[6:0] == 7'b1111000) ;
				wbe_nxt[119] =  (haddr[6:0] == 7'b1110111) ;
				wbe_nxt[118] =  (haddr[6:0] == 7'b1110110) ;
				wbe_nxt[117] =  (haddr[6:0] == 7'b1110101) ;
				wbe_nxt[116] =  (haddr[6:0] == 7'b1110100) ;
				wbe_nxt[115] =  (haddr[6:0] == 7'b1110011) ;
				wbe_nxt[114] =  (haddr[6:0] == 7'b1110010) ;
				wbe_nxt[113] =  (haddr[6:0] == 7'b1110001) ;
				wbe_nxt[112] =  (haddr[6:0] == 7'b1110000) ;
				wbe_nxt[111] =  (haddr[6:0] == 7'b1101111) ;
				wbe_nxt[110] =  (haddr[6:0] == 7'b1101110) ;
				wbe_nxt[109] =  (haddr[6:0] == 7'b1101101) ;
				wbe_nxt[108] =  (haddr[6:0] == 7'b1101100) ;
				wbe_nxt[107] =  (haddr[6:0] == 7'b1101011) ;
				wbe_nxt[106] =  (haddr[6:0] == 7'b1101010) ;
				wbe_nxt[105] =  (haddr[6:0] == 7'b1101001) ;
				wbe_nxt[104] =  (haddr[6:0] == 7'b1101000) ;
				wbe_nxt[103] =  (haddr[6:0] == 7'b1100111) ;
				wbe_nxt[102] =  (haddr[6:0] == 7'b1100110) ;
				wbe_nxt[101] =  (haddr[6:0] == 7'b1100101) ;
				wbe_nxt[100] =  (haddr[6:0] == 7'b1100100) ;
				wbe_nxt[99] =  (haddr[6:0] == 7'b1100011) ;
				wbe_nxt[98] =  (haddr[6:0] == 7'b1100010) ;
				wbe_nxt[97] =  (haddr[6:0] == 7'b1100001) ;
				wbe_nxt[96] =  (haddr[6:0] == 7'b1100000) ;
				wbe_nxt[95] =  (haddr[6:0] == 7'b1011111) ;
				wbe_nxt[94] =  (haddr[6:0] == 7'b1011110) ;
				wbe_nxt[93] =  (haddr[6:0] == 7'b1011101) ;
				wbe_nxt[92] =  (haddr[6:0] == 7'b1011100) ;
				wbe_nxt[91] =  (haddr[6:0] == 7'b1011011) ;
				wbe_nxt[90] =  (haddr[6:0] == 7'b1011010) ;
				wbe_nxt[89] =  (haddr[6:0] == 7'b1011001) ;
				wbe_nxt[88] =  (haddr[6:0] == 7'b1011000) ;
				wbe_nxt[87] =  (haddr[6:0] == 7'b1010111) ;
				wbe_nxt[86] =  (haddr[6:0] == 7'b1010110) ;
				wbe_nxt[85] =  (haddr[6:0] == 7'b1010101) ;
				wbe_nxt[84] =  (haddr[6:0] == 7'b1010100) ;
				wbe_nxt[83] =  (haddr[6:0] == 7'b1010011) ;
				wbe_nxt[82] =  (haddr[6:0] == 7'b1010010) ;
				wbe_nxt[81] =  (haddr[6:0] == 7'b1010001) ;
				wbe_nxt[80] =  (haddr[6:0] == 7'b1010000) ;
				wbe_nxt[79] =  (haddr[6:0] == 7'b1001111) ;
				wbe_nxt[78] =  (haddr[6:0] == 7'b1001110) ;
				wbe_nxt[77] =  (haddr[6:0] == 7'b1001101) ;
				wbe_nxt[76] =  (haddr[6:0] == 7'b1001100) ;
				wbe_nxt[75] =  (haddr[6:0] == 7'b1001011) ;
				wbe_nxt[74] =  (haddr[6:0] == 7'b1001010) ;
				wbe_nxt[73] =  (haddr[6:0] == 7'b1001001) ;
				wbe_nxt[72] =  (haddr[6:0] == 7'b1001000) ;
				wbe_nxt[71] =  (haddr[6:0] == 7'b1000111) ;
				wbe_nxt[70] =  (haddr[6:0] == 7'b1000110) ;
				wbe_nxt[69] =  (haddr[6:0] == 7'b1000101) ;
				wbe_nxt[68] =  (haddr[6:0] == 7'b1000100) ;
				wbe_nxt[67] =  (haddr[6:0] == 7'b1000011) ;
				wbe_nxt[66] =  (haddr[6:0] == 7'b1000010) ;
				wbe_nxt[65] =  (haddr[6:0] == 7'b1000001) ;
				wbe_nxt[64] =  (haddr[6:0] == 7'b1000000) ;
				wbe_nxt[63] =  (haddr[6:0] == 7'b0111111) ;
				wbe_nxt[62] =  (haddr[6:0] == 7'b0111110) ;
				wbe_nxt[61] =  (haddr[6:0] == 7'b0111101) ;
				wbe_nxt[60] =  (haddr[6:0] == 7'b0111100) ;
				wbe_nxt[59] =  (haddr[6:0] == 7'b0111011) ;
				wbe_nxt[58] =  (haddr[6:0] == 7'b0111010) ;
				wbe_nxt[57] =  (haddr[6:0] == 7'b0111001) ;
				wbe_nxt[56] =  (haddr[6:0] == 7'b0111000) ;
				wbe_nxt[55] =  (haddr[6:0] == 7'b0110111) ;
				wbe_nxt[54] =  (haddr[6:0] == 7'b0110110) ;
				wbe_nxt[53] =  (haddr[6:0] == 7'b0110101) ;
				wbe_nxt[52] =  (haddr[6:0] == 7'b0110100) ;
				wbe_nxt[51] =  (haddr[6:0] == 7'b0110011) ;
				wbe_nxt[50] =  (haddr[6:0] == 7'b0110010) ;
				wbe_nxt[49] =  (haddr[6:0] == 7'b0110001) ;
				wbe_nxt[48] =  (haddr[6:0] == 7'b0110000) ;
				wbe_nxt[47] =  (haddr[6:0] == 7'b0101111) ;
				wbe_nxt[46] =  (haddr[6:0] == 7'b0101110) ;
				wbe_nxt[45] =  (haddr[6:0] == 7'b0101101) ;
				wbe_nxt[44] =  (haddr[6:0] == 7'b0101100) ;
				wbe_nxt[43] =  (haddr[6:0] == 7'b0101011) ;
				wbe_nxt[42] =  (haddr[6:0] == 7'b0101010) ;
				wbe_nxt[41] =  (haddr[6:0] == 7'b0101001) ;
				wbe_nxt[40] =  (haddr[6:0] == 7'b0101000) ;
				wbe_nxt[39] =  (haddr[6:0] == 7'b0100111) ;
				wbe_nxt[38] =  (haddr[6:0] == 7'b0100110) ;
				wbe_nxt[37] =  (haddr[6:0] == 7'b0100101) ;
				wbe_nxt[36] =  (haddr[6:0] == 7'b0100100) ;
				wbe_nxt[35] =  (haddr[6:0] == 7'b0100011) ;
				wbe_nxt[34] =  (haddr[6:0] == 7'b0100010) ;
				wbe_nxt[33] =  (haddr[6:0] == 7'b0100001) ;
				wbe_nxt[32] =  (haddr[6:0] == 7'b0100000) ;
				wbe_nxt[31] =  (haddr[6:0] == 7'b0011111) ;
				wbe_nxt[30] =  (haddr[6:0] == 7'b0011110) ;
				wbe_nxt[29] =  (haddr[6:0] == 7'b0011101) ;
				wbe_nxt[28] =  (haddr[6:0] == 7'b0011100) ;
				wbe_nxt[27] =  (haddr[6:0] == 7'b0011011) ;
				wbe_nxt[26] =  (haddr[6:0] == 7'b0011010) ;
				wbe_nxt[25] =  (haddr[6:0] == 7'b0011001) ;
				wbe_nxt[24] =  (haddr[6:0] == 7'b0011000) ;
				wbe_nxt[23] =  (haddr[6:0] == 7'b0010111) ;
				wbe_nxt[22] =  (haddr[6:0] == 7'b0010110) ;
				wbe_nxt[21] =  (haddr[6:0] == 7'b0010101) ;
				wbe_nxt[20] =  (haddr[6:0] == 7'b0010100) ;
				wbe_nxt[19] =  (haddr[6:0] == 7'b0010011) ;
				wbe_nxt[18] =  (haddr[6:0] == 7'b0010010) ;
				wbe_nxt[17] =  (haddr[6:0] == 7'b0010001) ;
				wbe_nxt[16] =  (haddr[6:0] == 7'b0010000) ;
				wbe_nxt[15] =  (haddr[6:0] == 7'b0001111) ;
				wbe_nxt[14] =  (haddr[6:0] == 7'b0001110) ;
				wbe_nxt[13] =  (haddr[6:0] == 7'b0001101) ;
				wbe_nxt[12] =  (haddr[6:0] == 7'b0001100) ;
				wbe_nxt[11] =  (haddr[6:0] == 7'b0001011) ;
				wbe_nxt[10] =  (haddr[6:0] == 7'b0001010) ;
				wbe_nxt[9] =  (haddr[6:0] == 7'b0001001) ;
				wbe_nxt[8] =  (haddr[6:0] == 7'b0001000) ;
				wbe_nxt[7] =  (haddr[6:0] == 7'b0000111) ;
				wbe_nxt[6] =  (haddr[6:0] == 7'b0000110) ;
				wbe_nxt[5] =  (haddr[6:0] == 7'b0000101) ;
				wbe_nxt[4] =  (haddr[6:0] == 7'b0000100) ;
				wbe_nxt[3] =  (haddr[6:0] == 7'b0000011) ;
				wbe_nxt[2] =  (haddr[6:0] == 7'b0000010) ;
				wbe_nxt[1] =  (haddr[6:0] == 7'b0000001) ;
				wbe_nxt[0] =  (haddr[6:0] == 7'b0000000) ;
			end
			3'b001: begin
				wbe_nxt[127:126] = {2{(haddr[6:1] == 6'b111111)}};
				wbe_nxt[125:124] = {2{(haddr[6:1] == 6'b111110)}};
				wbe_nxt[123:122] = {2{(haddr[6:1] == 6'b111101)}};
				wbe_nxt[121:120] = {2{(haddr[6:1] == 6'b111100)}};
				wbe_nxt[119:118] = {2{(haddr[6:1] == 6'b111011)}};
				wbe_nxt[117:116] = {2{(haddr[6:1] == 6'b111010)}};
				wbe_nxt[115:114] = {2{(haddr[6:1] == 6'b111001)}};
				wbe_nxt[113:112] = {2{(haddr[6:1] == 6'b111000)}};
				wbe_nxt[111:110] = {2{(haddr[6:1] == 6'b110111)}};
				wbe_nxt[109:108] = {2{(haddr[6:1] == 6'b110110)}};
				wbe_nxt[107:106] = {2{(haddr[6:1] == 6'b110101)}};
				wbe_nxt[105:104] = {2{(haddr[6:1] == 6'b110100)}};
				wbe_nxt[103:102] = {2{(haddr[6:1] == 6'b110011)}};
				wbe_nxt[101:100] = {2{(haddr[6:1] == 6'b110010)}};
				wbe_nxt[99:98] = {2{(haddr[6:1] == 6'b110001)}};
				wbe_nxt[97:96] = {2{(haddr[6:1] == 6'b110000)}};
				wbe_nxt[95:94] = {2{(haddr[6:1] == 6'b101111)}};
				wbe_nxt[93:92] = {2{(haddr[6:1] == 6'b101110)}};
				wbe_nxt[91:90] = {2{(haddr[6:1] == 6'b101101)}};
				wbe_nxt[89:88] = {2{(haddr[6:1] == 6'b101100)}};
				wbe_nxt[87:86] = {2{(haddr[6:1] == 6'b101011)}};
				wbe_nxt[85:84] = {2{(haddr[6:1] == 6'b101010)}};
				wbe_nxt[83:82] = {2{(haddr[6:1] == 6'b101001)}};
				wbe_nxt[81:80] = {2{(haddr[6:1] == 6'b101000)}};
				wbe_nxt[79:78] = {2{(haddr[6:1] == 6'b100111)}};
				wbe_nxt[77:76] = {2{(haddr[6:1] == 6'b100110)}};
				wbe_nxt[75:74] = {2{(haddr[6:1] == 6'b100101)}};
				wbe_nxt[73:72] = {2{(haddr[6:1] == 6'b100100)}};
				wbe_nxt[71:70] = {2{(haddr[6:1] == 6'b100011)}};
				wbe_nxt[69:68] = {2{(haddr[6:1] == 6'b100010)}};
				wbe_nxt[67:66] = {2{(haddr[6:1] == 6'b100001)}};
				wbe_nxt[65:64] = {2{(haddr[6:1] == 6'b100000)}};
				wbe_nxt[63:62] = {2{(haddr[6:1] == 6'b011111)}};
				wbe_nxt[61:60] = {2{(haddr[6:1] == 6'b011110)}};
				wbe_nxt[59:58] = {2{(haddr[6:1] == 6'b011101)}};
				wbe_nxt[57:56] = {2{(haddr[6:1] == 6'b011100)}};
				wbe_nxt[55:54] = {2{(haddr[6:1] == 6'b011011)}};
				wbe_nxt[53:52] = {2{(haddr[6:1] == 6'b011010)}};
				wbe_nxt[51:50] = {2{(haddr[6:1] == 6'b011001)}};
				wbe_nxt[49:48] = {2{(haddr[6:1] == 6'b011000)}};
				wbe_nxt[47:46] = {2{(haddr[6:1] == 6'b010111)}};
				wbe_nxt[45:44] = {2{(haddr[6:1] == 6'b010110)}};
				wbe_nxt[43:42] = {2{(haddr[6:1] == 6'b010101)}};
				wbe_nxt[41:40] = {2{(haddr[6:1] == 6'b010100)}};
				wbe_nxt[39:38] = {2{(haddr[6:1] == 6'b010011)}};
				wbe_nxt[37:36] = {2{(haddr[6:1] == 6'b010010)}};
				wbe_nxt[35:34] = {2{(haddr[6:1] == 6'b010001)}};
				wbe_nxt[33:32] = {2{(haddr[6:1] == 6'b010000)}};
				wbe_nxt[31:30] = {2{(haddr[6:1] == 6'b001111)}};
				wbe_nxt[29:28] = {2{(haddr[6:1] == 6'b001110)}};
				wbe_nxt[27:26] = {2{(haddr[6:1] == 6'b001101)}};
				wbe_nxt[25:24] = {2{(haddr[6:1] == 6'b001100)}};
				wbe_nxt[23:22] = {2{(haddr[6:1] == 6'b001011)}};
				wbe_nxt[21:20] = {2{(haddr[6:1] == 6'b001010)}};
				wbe_nxt[19:18] = {2{(haddr[6:1] == 6'b001001)}};
				wbe_nxt[17:16] = {2{(haddr[6:1] == 6'b001000)}};
				wbe_nxt[15:14] = {2{(haddr[6:1] == 6'b000111)}};
				wbe_nxt[13:12] = {2{(haddr[6:1] == 6'b000110)}};
				wbe_nxt[11:10] = {2{(haddr[6:1] == 6'b000101)}};
				wbe_nxt[9:8] = {2{(haddr[6:1] == 6'b000100)}};
				wbe_nxt[7:6] = {2{(haddr[6:1] == 6'b000011)}};
				wbe_nxt[5:4] = {2{(haddr[6:1] == 6'b000010)}};
				wbe_nxt[3:2] = {2{(haddr[6:1] == 6'b000001)}};
				wbe_nxt[1:0] = {2{(haddr[6:1] == 6'b000000)}};
			end
			3'b010: begin
				wbe_nxt[127:124] = {4{(haddr[6:2] == 5'b11111)}};
				wbe_nxt[123:120] = {4{(haddr[6:2] == 5'b11110)}};
				wbe_nxt[119:116] = {4{(haddr[6:2] == 5'b11101)}};
				wbe_nxt[115:112] = {4{(haddr[6:2] == 5'b11100)}};
				wbe_nxt[111:108] = {4{(haddr[6:2] == 5'b11011)}};
				wbe_nxt[107:104] = {4{(haddr[6:2] == 5'b11010)}};
				wbe_nxt[103:100] = {4{(haddr[6:2] == 5'b11001)}};
				wbe_nxt[99:96] = {4{(haddr[6:2] == 5'b11000)}};
				wbe_nxt[95:92] = {4{(haddr[6:2] == 5'b10111)}};
				wbe_nxt[91:88] = {4{(haddr[6:2] == 5'b10110)}};
				wbe_nxt[87:84] = {4{(haddr[6:2] == 5'b10101)}};
				wbe_nxt[83:80] = {4{(haddr[6:2] == 5'b10100)}};
				wbe_nxt[79:76] = {4{(haddr[6:2] == 5'b10011)}};
				wbe_nxt[75:72] = {4{(haddr[6:2] == 5'b10010)}};
				wbe_nxt[71:68] = {4{(haddr[6:2] == 5'b10001)}};
				wbe_nxt[67:64] = {4{(haddr[6:2] == 5'b10000)}};
				wbe_nxt[63:60] = {4{(haddr[6:2] == 5'b01111)}};
				wbe_nxt[59:56] = {4{(haddr[6:2] == 5'b01110)}};
				wbe_nxt[55:52] = {4{(haddr[6:2] == 5'b01101)}};
				wbe_nxt[51:48] = {4{(haddr[6:2] == 5'b01100)}};
				wbe_nxt[47:44] = {4{(haddr[6:2] == 5'b01011)}};
				wbe_nxt[43:40] = {4{(haddr[6:2] == 5'b01010)}};
				wbe_nxt[39:36] = {4{(haddr[6:2] == 5'b01001)}};
				wbe_nxt[35:32] = {4{(haddr[6:2] == 5'b01000)}};
				wbe_nxt[31:28] = {4{(haddr[6:2] == 5'b00111)}};
				wbe_nxt[27:24] = {4{(haddr[6:2] == 5'b00110)}};
				wbe_nxt[23:20] = {4{(haddr[6:2] == 5'b00101)}};
				wbe_nxt[19:16] = {4{(haddr[6:2] == 5'b00100)}};
				wbe_nxt[15:12] = {4{(haddr[6:2] == 5'b00011)}};
				wbe_nxt[11:8] = {4{(haddr[6:2] == 5'b00010)}};
				wbe_nxt[7:4] = {4{(haddr[6:2] == 5'b00001)}};
				wbe_nxt[3:0] = {4{(haddr[6:2] == 5'b00000)}};
			end
			3'b011: begin
				wbe_nxt[127:120] = {8{(haddr[6:3] == 4'b1111)}};
				wbe_nxt[119:112] = {8{(haddr[6:3] == 4'b1110)}};
				wbe_nxt[111:104] = {8{(haddr[6:3] == 4'b1101)}};
				wbe_nxt[103:96] = {8{(haddr[6:3] == 4'b1100)}};
				wbe_nxt[95:88] = {8{(haddr[6:3] == 4'b1011)}};
				wbe_nxt[87:80] = {8{(haddr[6:3] == 4'b1010)}};
				wbe_nxt[79:72] = {8{(haddr[6:3] == 4'b1001)}};
				wbe_nxt[71:64] = {8{(haddr[6:3] == 4'b1000)}};
				wbe_nxt[63:56] = {8{(haddr[6:3] == 4'b0111)}};
				wbe_nxt[55:48] = {8{(haddr[6:3] == 4'b0110)}};
				wbe_nxt[47:40] = {8{(haddr[6:3] == 4'b0101)}};
				wbe_nxt[39:32] = {8{(haddr[6:3] == 4'b0100)}};
				wbe_nxt[31:24] = {8{(haddr[6:3] == 4'b0011)}};
				wbe_nxt[23:16] = {8{(haddr[6:3] == 4'b0010)}};
				wbe_nxt[15:8] = {8{(haddr[6:3] == 4'b0001)}};
				wbe_nxt[7:0] = {8{(haddr[6:3] == 4'b0000)}};
			end
			3'b100: begin
				wbe_nxt[127:112] = {16{(haddr[6:4] == 3'b111)}};
				wbe_nxt[111:96] = {16{(haddr[6:4] == 3'b110)}};
				wbe_nxt[95:80] = {16{(haddr[6:4] == 3'b101)}};
				wbe_nxt[79:64] = {16{(haddr[6:4] == 3'b100)}};
				wbe_nxt[63:48] = {16{(haddr[6:4] == 3'b011)}};
				wbe_nxt[47:32] = {16{(haddr[6:4] == 3'b010)}};
				wbe_nxt[31:16] = {16{(haddr[6:4] == 3'b001)}};
				wbe_nxt[15:0] = {16{(haddr[6:4] == 3'b000)}};
			end
			3'b101: begin
				wbe_nxt[127:96] = {32{(haddr[6:5] == 2'b11)}};
				wbe_nxt[95:64] = {32{(haddr[6:5] == 2'b10)}};
				wbe_nxt[63:32] = {32{(haddr[6:5] == 2'b01)}};
				wbe_nxt[31:0] = {32{(haddr[6:5] == 2'b00)}};
			end
			3'b110: begin
				wbe_nxt[127:64] = {64{(haddr[6] == 1'b1)}};
				wbe_nxt[63:0] = {64{(haddr[6] == 1'b0)}};
			end
			3'b111: begin
				wbe_nxt[127:0] = {128{1'b1}};
			end
			default:
				wbe_nxt = 128'b0;
		endcase
	end
end
endgenerate
// VPERL_GENERATED_END
always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
        	wbe <= {(DATA_WIDTH/8){1'b0}};
	end
	// write transaction
	else if (wen) begin
		// write byte enable
        	wbe <= wbe_nxt;
	end
end

// write enable
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        priority_wen <= 1'b0;
        ctrl_wen     <= 1'b0;
        intr_wen     <= 1'b0;
`ifdef ATCBMC200_AHB_SLV11
      	slv11_wen <= 1'b0; 
`endif
`ifdef ATCBMC200_AHB_SLV12
      	slv12_wen <= 1'b0; 
`endif
`ifdef ATCBMC200_AHB_SLV13
      	slv13_wen <= 1'b0; 
`endif
`ifdef ATCBMC200_AHB_SLV14
      	slv14_wen <= 1'b0; 
`endif
`ifdef ATCBMC200_AHB_SLV15
      	slv15_wen <= 1'b0; 
`endif
    end
    else begin
        priority_wen <= wen & hwdata_32_array_hit[4];
        ctrl_wen     <= wen & hwdata_32_array_hit[5];
        intr_wen     <= wen & hwdata_32_array_hit[6];
`ifdef ATCBMC200_AHB_SLV11
      	slv11_wen <= wen & hwdata_32_array_hit[18]; 
`endif
`ifdef ATCBMC200_AHB_SLV12
      	slv12_wen <= wen & hwdata_32_array_hit[19]; 
`endif
`ifdef ATCBMC200_AHB_SLV13
      	slv13_wen <= wen & hwdata_32_array_hit[20]; 
`endif
`ifdef ATCBMC200_AHB_SLV14
      	slv14_wen <= wen & hwdata_32_array_hit[21]; 
`endif
`ifdef ATCBMC200_AHB_SLV15
      	slv15_wen <= wen & hwdata_32_array_hit[22]; 
`endif
    end
end



always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        mst0_highest_en <= 1'b0;
    end
    else if (priority_wen) begin
	if (hwdata_32_array_wbe[4][3]) begin
	    mst0_highest_en <= hwdata_32_array[4][31];
        end
    end
end

// VPERL_BEGIN
// for ($i = 0; $i < 16; $i++) {
//     $j = int($i/8);
//: `ifdef ATCBMC200_AHB_MST${i}
//:     always @(posedge hclk or negedge hresetn) begin
//:         if (!hresetn) begin
//:             init_priority${i} <= 1'b1;
//:	    end
//:         else if (priority_wen && hwdata_32_array_wbe[4][$j]) begin
//:             init_priority${i} <= hwdata_32_array[4][${i}];
//:	    end
//:     end
//:     assign init_priority[${i}] = init_priority${i};
//: `else
//:     assign init_priority[${i}] = 1'b0;
//: `endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC200_AHB_MST0
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority0 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][0]) begin
            init_priority0 <= hwdata_32_array[4][0];
	    end
    end
    assign init_priority[0] = init_priority0;
`else
    assign init_priority[0] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST1
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority1 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][0]) begin
            init_priority1 <= hwdata_32_array[4][1];
	    end
    end
    assign init_priority[1] = init_priority1;
`else
    assign init_priority[1] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST2
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority2 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][0]) begin
            init_priority2 <= hwdata_32_array[4][2];
	    end
    end
    assign init_priority[2] = init_priority2;
`else
    assign init_priority[2] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST3
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority3 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][0]) begin
            init_priority3 <= hwdata_32_array[4][3];
	    end
    end
    assign init_priority[3] = init_priority3;
`else
    assign init_priority[3] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST4
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority4 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][0]) begin
            init_priority4 <= hwdata_32_array[4][4];
	    end
    end
    assign init_priority[4] = init_priority4;
`else
    assign init_priority[4] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST5
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority5 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][0]) begin
            init_priority5 <= hwdata_32_array[4][5];
	    end
    end
    assign init_priority[5] = init_priority5;
`else
    assign init_priority[5] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST6
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority6 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][0]) begin
            init_priority6 <= hwdata_32_array[4][6];
	    end
    end
    assign init_priority[6] = init_priority6;
`else
    assign init_priority[6] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST7
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority7 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][0]) begin
            init_priority7 <= hwdata_32_array[4][7];
	    end
    end
    assign init_priority[7] = init_priority7;
`else
    assign init_priority[7] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST8
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority8 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][1]) begin
            init_priority8 <= hwdata_32_array[4][8];
	    end
    end
    assign init_priority[8] = init_priority8;
`else
    assign init_priority[8] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST9
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority9 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][1]) begin
            init_priority9 <= hwdata_32_array[4][9];
	    end
    end
    assign init_priority[9] = init_priority9;
`else
    assign init_priority[9] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST10
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority10 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][1]) begin
            init_priority10 <= hwdata_32_array[4][10];
	    end
    end
    assign init_priority[10] = init_priority10;
`else
    assign init_priority[10] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST11
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority11 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][1]) begin
            init_priority11 <= hwdata_32_array[4][11];
	    end
    end
    assign init_priority[11] = init_priority11;
`else
    assign init_priority[11] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST12
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority12 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][1]) begin
            init_priority12 <= hwdata_32_array[4][12];
	    end
    end
    assign init_priority[12] = init_priority12;
`else
    assign init_priority[12] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST13
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority13 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][1]) begin
            init_priority13 <= hwdata_32_array[4][13];
	    end
    end
    assign init_priority[13] = init_priority13;
`else
    assign init_priority[13] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST14
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority14 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][1]) begin
            init_priority14 <= hwdata_32_array[4][14];
	    end
    end
    assign init_priority[14] = init_priority14;
`else
    assign init_priority[14] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST15
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            init_priority15 <= 1'b1;
	    end
        else if (priority_wen && hwdata_32_array_wbe[4][1]) begin
            init_priority15 <= hwdata_32_array[4][15];
	    end
    end
    assign init_priority[15] = init_priority15;
`else
    assign init_priority[15] = 1'b0;
`endif
// VPERL_GENERATED_END

`ifdef ATCBMC200_RESP_MODE_ERROR
wire RESP_MODE_PARM = 1'b1;
`else
wire RESP_MODE_PARM = 1'b0;
`endif

always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        intr_en         <= 1'b0;
        resp_mode       <= RESP_MODE_PARM;
    end
    else if (ctrl_wen) begin
        if (hwdata_32_array_wbe[5][0]) begin
		intr_en <= hwdata_32_array[5][1];
		resp_mode <= hwdata_32_array[5][0];
	end
    end
end

// VPERL_BEGIN
// $MST_NUM = 16;
// for ($i = 0; $i < $MST_NUM; $i++) {
//   $j = int($i/4);
//: `ifdef ATCBMC200_AHB_MST${i} 
//:     always @(posedge hclk or negedge hresetn) begin
//:        if (!hresetn)
//:            intr_mst${i}_sel_err <= 1'b0;
//:        else if (intr_wen && hwdata_32_array_wbe[6][${j}]) 
//:            intr_mst${i}_sel_err <= intr_mst${i}_sel_err & ~hwdata_32_array[6][${i}];
//:        else if (mst${i}_sel_err)
//:            intr_mst${i}_sel_err <= 1'b1;
//:     end
//:     assign intr_mst_sel_err[${i}] = intr_mst${i}_sel_err;
//: `else
//:     assign intr_mst_sel_err[${i}] = 1'b0;
//: `endif
//:
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC200_AHB_MST0
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst0_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][0])
           intr_mst0_sel_err <= intr_mst0_sel_err & ~hwdata_32_array[6][0];
       else if (mst0_sel_err)
           intr_mst0_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[0] = intr_mst0_sel_err;
`else
    assign intr_mst_sel_err[0] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST1
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst1_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][0])
           intr_mst1_sel_err <= intr_mst1_sel_err & ~hwdata_32_array[6][1];
       else if (mst1_sel_err)
           intr_mst1_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[1] = intr_mst1_sel_err;
`else
    assign intr_mst_sel_err[1] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST2
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst2_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][0])
           intr_mst2_sel_err <= intr_mst2_sel_err & ~hwdata_32_array[6][2];
       else if (mst2_sel_err)
           intr_mst2_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[2] = intr_mst2_sel_err;
`else
    assign intr_mst_sel_err[2] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST3
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst3_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][0])
           intr_mst3_sel_err <= intr_mst3_sel_err & ~hwdata_32_array[6][3];
       else if (mst3_sel_err)
           intr_mst3_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[3] = intr_mst3_sel_err;
`else
    assign intr_mst_sel_err[3] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST4
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst4_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][1])
           intr_mst4_sel_err <= intr_mst4_sel_err & ~hwdata_32_array[6][4];
       else if (mst4_sel_err)
           intr_mst4_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[4] = intr_mst4_sel_err;
`else
    assign intr_mst_sel_err[4] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST5
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst5_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][1])
           intr_mst5_sel_err <= intr_mst5_sel_err & ~hwdata_32_array[6][5];
       else if (mst5_sel_err)
           intr_mst5_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[5] = intr_mst5_sel_err;
`else
    assign intr_mst_sel_err[5] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST6
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst6_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][1])
           intr_mst6_sel_err <= intr_mst6_sel_err & ~hwdata_32_array[6][6];
       else if (mst6_sel_err)
           intr_mst6_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[6] = intr_mst6_sel_err;
`else
    assign intr_mst_sel_err[6] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST7
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst7_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][1])
           intr_mst7_sel_err <= intr_mst7_sel_err & ~hwdata_32_array[6][7];
       else if (mst7_sel_err)
           intr_mst7_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[7] = intr_mst7_sel_err;
`else
    assign intr_mst_sel_err[7] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST8
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst8_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][2])
           intr_mst8_sel_err <= intr_mst8_sel_err & ~hwdata_32_array[6][8];
       else if (mst8_sel_err)
           intr_mst8_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[8] = intr_mst8_sel_err;
`else
    assign intr_mst_sel_err[8] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST9
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst9_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][2])
           intr_mst9_sel_err <= intr_mst9_sel_err & ~hwdata_32_array[6][9];
       else if (mst9_sel_err)
           intr_mst9_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[9] = intr_mst9_sel_err;
`else
    assign intr_mst_sel_err[9] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST10
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst10_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][2])
           intr_mst10_sel_err <= intr_mst10_sel_err & ~hwdata_32_array[6][10];
       else if (mst10_sel_err)
           intr_mst10_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[10] = intr_mst10_sel_err;
`else
    assign intr_mst_sel_err[10] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST11
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst11_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][2])
           intr_mst11_sel_err <= intr_mst11_sel_err & ~hwdata_32_array[6][11];
       else if (mst11_sel_err)
           intr_mst11_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[11] = intr_mst11_sel_err;
`else
    assign intr_mst_sel_err[11] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST12
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst12_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][3])
           intr_mst12_sel_err <= intr_mst12_sel_err & ~hwdata_32_array[6][12];
       else if (mst12_sel_err)
           intr_mst12_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[12] = intr_mst12_sel_err;
`else
    assign intr_mst_sel_err[12] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST13
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst13_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][3])
           intr_mst13_sel_err <= intr_mst13_sel_err & ~hwdata_32_array[6][13];
       else if (mst13_sel_err)
           intr_mst13_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[13] = intr_mst13_sel_err;
`else
    assign intr_mst_sel_err[13] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST14
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst14_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][3])
           intr_mst14_sel_err <= intr_mst14_sel_err & ~hwdata_32_array[6][14];
       else if (mst14_sel_err)
           intr_mst14_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[14] = intr_mst14_sel_err;
`else
    assign intr_mst_sel_err[14] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST15
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           intr_mst15_sel_err <= 1'b0;
       else if (intr_wen && hwdata_32_array_wbe[6][3])
           intr_mst15_sel_err <= intr_mst15_sel_err & ~hwdata_32_array[6][15];
       else if (mst15_sel_err)
           intr_mst15_sel_err <= 1'b1;
    end
    assign intr_mst_sel_err[15] = intr_mst15_sel_err;
`else
    assign intr_mst_sel_err[15] = 1'b0;
`endif

// VPERL_GENERATED_END

// VPERL_BEGIN
// $SLV_NUM = 16;
// for ($i = 11; $i < $SLV_NUM; $i++) {
//: `ifdef ATCBMC200_AHB_SLV${i}
//: always @(posedge hclk or negedge hresetn) begin
//:     if (!hresetn) begin
//:         slv${i}_base <= AHB_SLV${i}_BASE[ADDR_MSB:BASE_ADDR_LSB];
//:         slv${i}_size <= `ATCBMC200_AHB_SLV${i}_SIZE;
//:     end
//:     else if (slv${i}_wen) begin
//:         `ifdef ATCBMC200_ADDR_WIDTH_24
//:         if (hwdata_32_array_wbe[%d][2]) slv${i}_base[23:16] <= hwdata_32_array[%d][23:16]; :: $i+7, $i+7 
//:         if (hwdata_32_array_wbe[%d][1]) slv${i}_base[15:10]  <= hwdata_32_array[%d][15:10]; :: $i+7, $i+7 
//:         `else 
//:         if (hwdata_32_array_wbe[%d][3]) slv${i}_base[31:24] <= hwdata_32_array[%d][31:24]; :: $i+7, $i+7 
//:         if (hwdata_32_array_wbe[%d][2]) slv${i}_base[23:20]  <= hwdata_32_array[%d][23:20]; :: $i+7, $i+7 
//:         `endif 
//:      
//:         if (hwdata_32_array_wbe[%d][0]) slv${i}_size       <= hwdata_32_array[%d][3:0]; :: $i+7, $i+7 
//:     end
//: end
//: `endif
//:
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC200_AHB_SLV11
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        slv11_base <= AHB_SLV11_BASE[ADDR_MSB:BASE_ADDR_LSB];
        slv11_size <= `ATCBMC200_AHB_SLV11_SIZE;
    end
    else if (slv11_wen) begin
        `ifdef ATCBMC200_ADDR_WIDTH_24
        if (hwdata_32_array_wbe[18][2]) slv11_base[23:16] <= hwdata_32_array[18][23:16];
        if (hwdata_32_array_wbe[18][1]) slv11_base[15:10]  <= hwdata_32_array[18][15:10];
        `else
        if (hwdata_32_array_wbe[18][3]) slv11_base[31:24] <= hwdata_32_array[18][31:24];
        if (hwdata_32_array_wbe[18][2]) slv11_base[23:20]  <= hwdata_32_array[18][23:20];
        `endif

        if (hwdata_32_array_wbe[18][0]) slv11_size       <= hwdata_32_array[18][3:0];
    end
end
`endif

`ifdef ATCBMC200_AHB_SLV12
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        slv12_base <= AHB_SLV12_BASE[ADDR_MSB:BASE_ADDR_LSB];
        slv12_size <= `ATCBMC200_AHB_SLV12_SIZE;
    end
    else if (slv12_wen) begin
        `ifdef ATCBMC200_ADDR_WIDTH_24
        if (hwdata_32_array_wbe[19][2]) slv12_base[23:16] <= hwdata_32_array[19][23:16];
        if (hwdata_32_array_wbe[19][1]) slv12_base[15:10]  <= hwdata_32_array[19][15:10];
        `else
        if (hwdata_32_array_wbe[19][3]) slv12_base[31:24] <= hwdata_32_array[19][31:24];
        if (hwdata_32_array_wbe[19][2]) slv12_base[23:20]  <= hwdata_32_array[19][23:20];
        `endif

        if (hwdata_32_array_wbe[19][0]) slv12_size       <= hwdata_32_array[19][3:0];
    end
end
`endif

`ifdef ATCBMC200_AHB_SLV13
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        slv13_base <= AHB_SLV13_BASE[ADDR_MSB:BASE_ADDR_LSB];
        slv13_size <= `ATCBMC200_AHB_SLV13_SIZE;
    end
    else if (slv13_wen) begin
        `ifdef ATCBMC200_ADDR_WIDTH_24
        if (hwdata_32_array_wbe[20][2]) slv13_base[23:16] <= hwdata_32_array[20][23:16];
        if (hwdata_32_array_wbe[20][1]) slv13_base[15:10]  <= hwdata_32_array[20][15:10];
        `else
        if (hwdata_32_array_wbe[20][3]) slv13_base[31:24] <= hwdata_32_array[20][31:24];
        if (hwdata_32_array_wbe[20][2]) slv13_base[23:20]  <= hwdata_32_array[20][23:20];
        `endif

        if (hwdata_32_array_wbe[20][0]) slv13_size       <= hwdata_32_array[20][3:0];
    end
end
`endif

`ifdef ATCBMC200_AHB_SLV14
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        slv14_base <= AHB_SLV14_BASE[ADDR_MSB:BASE_ADDR_LSB];
        slv14_size <= `ATCBMC200_AHB_SLV14_SIZE;
    end
    else if (slv14_wen) begin
        `ifdef ATCBMC200_ADDR_WIDTH_24
        if (hwdata_32_array_wbe[21][2]) slv14_base[23:16] <= hwdata_32_array[21][23:16];
        if (hwdata_32_array_wbe[21][1]) slv14_base[15:10]  <= hwdata_32_array[21][15:10];
        `else
        if (hwdata_32_array_wbe[21][3]) slv14_base[31:24] <= hwdata_32_array[21][31:24];
        if (hwdata_32_array_wbe[21][2]) slv14_base[23:20]  <= hwdata_32_array[21][23:20];
        `endif

        if (hwdata_32_array_wbe[21][0]) slv14_size       <= hwdata_32_array[21][3:0];
    end
end
`endif

`ifdef ATCBMC200_AHB_SLV15
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        slv15_base <= AHB_SLV15_BASE[ADDR_MSB:BASE_ADDR_LSB];
        slv15_size <= `ATCBMC200_AHB_SLV15_SIZE;
    end
    else if (slv15_wen) begin
        `ifdef ATCBMC200_ADDR_WIDTH_24
        if (hwdata_32_array_wbe[22][2]) slv15_base[23:16] <= hwdata_32_array[22][23:16];
        if (hwdata_32_array_wbe[22][1]) slv15_base[15:10]  <= hwdata_32_array[22][15:10];
        `else
        if (hwdata_32_array_wbe[22][3]) slv15_base[31:24] <= hwdata_32_array[22][31:24];
        if (hwdata_32_array_wbe[22][2]) slv15_base[23:20]  <= hwdata_32_array[22][23:20];
        `endif

        if (hwdata_32_array_wbe[22][0]) slv15_size       <= hwdata_32_array[22][3:0];
    end
end
`endif

// VPERL_GENERATED_END

// VPERL_BEGIN
// :assign	hrdata_32_array[0] = `ATCBMC200_PRODUCT_ID;
// :assign	hrdata_32_array[4] = {mst0_highest_en, 15'b0, init_priority};
// :assign	hrdata_32_array[5] = {30'h0, intr_en, resp_mode};
// :assign	hrdata_32_array[6] = {16'b0, intr_mst_sel_err};
// for ($i = 8; $i < 23; $i++) {
// :`ifdef ATCBMC200_AHB_SLV%d	:: $i - 7
// :	`ifdef ATCBMC200_ADDR_WIDTH_24
// :assign	hrdata_32_array[%d] = {8'h0, slv%d_base, 6'h0, slv%d_size};	:: $i, $i - 7, $i - 7
// :	`else
// :assign	hrdata_32_array[%d] = {slv%d_base[31:BASE_ADDR_LSB], 16'h0, slv%d_size};	:: $i, $i - 7, $i - 7
// :	`endif
// :`else
// :assign	hrdata_32_array[%d] = 32'h0;	:: $i
// :`endif // ATCBMC200_AHB_SLV%d	:: $i - 7
// }
// for $i (1, 2, 3, 7, 23 .. 31) {
// :assign	hrdata_32_array[%d] = 32'h0; // unused	:: $i
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
assign	hrdata_32_array[0] = `ATCBMC200_PRODUCT_ID;
assign	hrdata_32_array[4] = {mst0_highest_en, 15'b0, init_priority};
assign	hrdata_32_array[5] = {30'h0, intr_en, resp_mode};
assign	hrdata_32_array[6] = {16'b0, intr_mst_sel_err};
`ifdef ATCBMC200_AHB_SLV1
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[8] = {8'h0, slv1_base, 6'h0, slv1_size};
	`else
assign	hrdata_32_array[8] = {slv1_base[31:BASE_ADDR_LSB], 16'h0, slv1_size};
	`endif
`else
assign	hrdata_32_array[8] = 32'h0;
`endif // ATCBMC200_AHB_SLV1
`ifdef ATCBMC200_AHB_SLV2
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[9] = {8'h0, slv2_base, 6'h0, slv2_size};
	`else
assign	hrdata_32_array[9] = {slv2_base[31:BASE_ADDR_LSB], 16'h0, slv2_size};
	`endif
`else
assign	hrdata_32_array[9] = 32'h0;
`endif // ATCBMC200_AHB_SLV2
`ifdef ATCBMC200_AHB_SLV3
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[10] = {8'h0, slv3_base, 6'h0, slv3_size};
	`else
assign	hrdata_32_array[10] = {slv3_base[31:BASE_ADDR_LSB], 16'h0, slv3_size};
	`endif
`else
assign	hrdata_32_array[10] = 32'h0;
`endif // ATCBMC200_AHB_SLV3
`ifdef ATCBMC200_AHB_SLV4
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[11] = {8'h0, slv4_base, 6'h0, slv4_size};
	`else
assign	hrdata_32_array[11] = {slv4_base[31:BASE_ADDR_LSB], 16'h0, slv4_size};
	`endif
`else
assign	hrdata_32_array[11] = 32'h0;
`endif // ATCBMC200_AHB_SLV4
`ifdef ATCBMC200_AHB_SLV5
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[12] = {8'h0, slv5_base, 6'h0, slv5_size};
	`else
assign	hrdata_32_array[12] = {slv5_base[31:BASE_ADDR_LSB], 16'h0, slv5_size};
	`endif
`else
assign	hrdata_32_array[12] = 32'h0;
`endif // ATCBMC200_AHB_SLV5
`ifdef ATCBMC200_AHB_SLV6
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[13] = {8'h0, slv6_base, 6'h0, slv6_size};
	`else
assign	hrdata_32_array[13] = {slv6_base[31:BASE_ADDR_LSB], 16'h0, slv6_size};
	`endif
`else
assign	hrdata_32_array[13] = 32'h0;
`endif // ATCBMC200_AHB_SLV6
`ifdef ATCBMC200_AHB_SLV7
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[14] = {8'h0, slv7_base, 6'h0, slv7_size};
	`else
assign	hrdata_32_array[14] = {slv7_base[31:BASE_ADDR_LSB], 16'h0, slv7_size};
	`endif
`else
assign	hrdata_32_array[14] = 32'h0;
`endif // ATCBMC200_AHB_SLV7
`ifdef ATCBMC200_AHB_SLV8
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[15] = {8'h0, slv8_base, 6'h0, slv8_size};
	`else
assign	hrdata_32_array[15] = {slv8_base[31:BASE_ADDR_LSB], 16'h0, slv8_size};
	`endif
`else
assign	hrdata_32_array[15] = 32'h0;
`endif // ATCBMC200_AHB_SLV8
`ifdef ATCBMC200_AHB_SLV9
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[16] = {8'h0, slv9_base, 6'h0, slv9_size};
	`else
assign	hrdata_32_array[16] = {slv9_base[31:BASE_ADDR_LSB], 16'h0, slv9_size};
	`endif
`else
assign	hrdata_32_array[16] = 32'h0;
`endif // ATCBMC200_AHB_SLV9
`ifdef ATCBMC200_AHB_SLV10
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[17] = {8'h0, slv10_base, 6'h0, slv10_size};
	`else
assign	hrdata_32_array[17] = {slv10_base[31:BASE_ADDR_LSB], 16'h0, slv10_size};
	`endif
`else
assign	hrdata_32_array[17] = 32'h0;
`endif // ATCBMC200_AHB_SLV10
`ifdef ATCBMC200_AHB_SLV11
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[18] = {8'h0, slv11_base, 6'h0, slv11_size};
	`else
assign	hrdata_32_array[18] = {slv11_base[31:BASE_ADDR_LSB], 16'h0, slv11_size};
	`endif
`else
assign	hrdata_32_array[18] = 32'h0;
`endif // ATCBMC200_AHB_SLV11
`ifdef ATCBMC200_AHB_SLV12
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[19] = {8'h0, slv12_base, 6'h0, slv12_size};
	`else
assign	hrdata_32_array[19] = {slv12_base[31:BASE_ADDR_LSB], 16'h0, slv12_size};
	`endif
`else
assign	hrdata_32_array[19] = 32'h0;
`endif // ATCBMC200_AHB_SLV12
`ifdef ATCBMC200_AHB_SLV13
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[20] = {8'h0, slv13_base, 6'h0, slv13_size};
	`else
assign	hrdata_32_array[20] = {slv13_base[31:BASE_ADDR_LSB], 16'h0, slv13_size};
	`endif
`else
assign	hrdata_32_array[20] = 32'h0;
`endif // ATCBMC200_AHB_SLV13
`ifdef ATCBMC200_AHB_SLV14
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[21] = {8'h0, slv14_base, 6'h0, slv14_size};
	`else
assign	hrdata_32_array[21] = {slv14_base[31:BASE_ADDR_LSB], 16'h0, slv14_size};
	`endif
`else
assign	hrdata_32_array[21] = 32'h0;
`endif // ATCBMC200_AHB_SLV14
`ifdef ATCBMC200_AHB_SLV15
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	hrdata_32_array[22] = {8'h0, slv15_base, 6'h0, slv15_size};
	`else
assign	hrdata_32_array[22] = {slv15_base[31:BASE_ADDR_LSB], 16'h0, slv15_size};
	`endif
`else
assign	hrdata_32_array[22] = 32'h0;
`endif // ATCBMC200_AHB_SLV15
assign	hrdata_32_array[1] = 32'h0; // unused
assign	hrdata_32_array[2] = 32'h0; // unused
assign	hrdata_32_array[3] = 32'h0; // unused
assign	hrdata_32_array[7] = 32'h0; // unused
assign	hrdata_32_array[23] = 32'h0; // unused
assign	hrdata_32_array[24] = 32'h0; // unused
assign	hrdata_32_array[25] = 32'h0; // unused
assign	hrdata_32_array[26] = 32'h0; // unused
assign	hrdata_32_array[27] = 32'h0; // unused
assign	hrdata_32_array[28] = 32'h0; // unused
assign	hrdata_32_array[29] = 32'h0; // unused
assign	hrdata_32_array[30] = 32'h0; // unused
assign	hrdata_32_array[31] = 32'h0; // unused
// VPERL_GENERATED_END

wire	[7:2] hrdata_32_array_addr = read_af_write ? haddr_d1[7:2] : haddr[7:2];

// VPERL_BEGIN
// $max_dw = 1024; 
// $max_dw_log2 = log($max_dw/32)/log(2); 
//: generate
// for ($i = 0; $i <= $max_dw_log2; $i++) {
// 	my $k = 2 ** ($i + 5) ;
//: if (DATA_WIDTH == %d) begin: gen_hrdata_dw_%d	:: $k, $k
//:	assign	hrdata_match_data_width	=	\{
//	for ($j = (2**$i)-1; $j >= 0; $j--) {
//		if ($i == 0) {
//:					hrdata_32_array[hrdata_32_array_addr[6:%d]]%s :: $i + 2, ($j == 0) ? "" : ","
//		} elsif ($i > 4) {		
//:					hrdata_32_array[${i}'d${j}]%s :: ($j == 0) ? "" : ","
//		} else {
//:					hrdata_32_array[{hrdata_32_array_addr%s,${i}'d${j}}]%s :: ($i+2 == 6) ? ("[" . ($i + 2) . "]") : ("[6:" . ($i + 2) . "]"), ($j == 0 ) ? "" : ","
//		}
//	}
//:	\};
//	for ($j = 31 ; $j>=0 ; $j=$j-($k/32)) {
//:	assign	\{
//		for ($l = $j; $l>$j-($k/32); $l--) {
//:		hwdata_32_array[$l]%s :: ($l==$j-($k/32)+1) ? "" : ","
//		}
//:		\} = hwdata;
//:	assign	\{
//		for ($l = $j; $l>$j-($k/32); $l--) {
//:		hwdata_32_array_wbe[$l]%s :: ($l==$j-($k/32)+1) ? "" : ","
//		}
//:		\} = wbe;
//:	assign	\{
//		for ($l = $j; $l>$j-($k/32); $l--) {
//:		hwdata_32_array_hit[$l]%s :: ($l==$j-($k/32)+1) ? "" : ","
//		}
//		$aw_compare_msb = 7;
//		$aw_compare_lsb = $i+2;
//		$aw_compare_width = $aw_compare_msb - $aw_compare_lsb + 1;
//:		\} = {%d{haddr[%s]==%d\'d%d}}; :: ($k/32), (($aw_compare_width==1) ? $aw_compare_msb : $aw_compare_msb . ":" . ($aw_compare_lsb)), $aw_compare_width, ($l+1)>>(log($k/32)/log(2));
//	}
//: end // DATA_WIDTH %d	:: $k
// }
//: endgenerate
// VPERL_END

// VPERL_GENERATED_BEGIN
generate
if (DATA_WIDTH == 32) begin: gen_hrdata_dw_32
	assign	hrdata_match_data_width	=	{
					hrdata_32_array[hrdata_32_array_addr[6:2]]
	};
	assign	{
		hwdata_32_array[31]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[31]
		} = wbe;
	assign	{
		hwdata_32_array_hit[31]
		} = {1{haddr[7:2]==6'd31}};
	assign	{
		hwdata_32_array[30]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[30]
		} = wbe;
	assign	{
		hwdata_32_array_hit[30]
		} = {1{haddr[7:2]==6'd30}};
	assign	{
		hwdata_32_array[29]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[29]
		} = wbe;
	assign	{
		hwdata_32_array_hit[29]
		} = {1{haddr[7:2]==6'd29}};
	assign	{
		hwdata_32_array[28]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[28]
		} = wbe;
	assign	{
		hwdata_32_array_hit[28]
		} = {1{haddr[7:2]==6'd28}};
	assign	{
		hwdata_32_array[27]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[27]
		} = wbe;
	assign	{
		hwdata_32_array_hit[27]
		} = {1{haddr[7:2]==6'd27}};
	assign	{
		hwdata_32_array[26]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[26]
		} = wbe;
	assign	{
		hwdata_32_array_hit[26]
		} = {1{haddr[7:2]==6'd26}};
	assign	{
		hwdata_32_array[25]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[25]
		} = wbe;
	assign	{
		hwdata_32_array_hit[25]
		} = {1{haddr[7:2]==6'd25}};
	assign	{
		hwdata_32_array[24]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[24]
		} = wbe;
	assign	{
		hwdata_32_array_hit[24]
		} = {1{haddr[7:2]==6'd24}};
	assign	{
		hwdata_32_array[23]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[23]
		} = wbe;
	assign	{
		hwdata_32_array_hit[23]
		} = {1{haddr[7:2]==6'd23}};
	assign	{
		hwdata_32_array[22]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[22]
		} = wbe;
	assign	{
		hwdata_32_array_hit[22]
		} = {1{haddr[7:2]==6'd22}};
	assign	{
		hwdata_32_array[21]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[21]
		} = wbe;
	assign	{
		hwdata_32_array_hit[21]
		} = {1{haddr[7:2]==6'd21}};
	assign	{
		hwdata_32_array[20]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[20]
		} = wbe;
	assign	{
		hwdata_32_array_hit[20]
		} = {1{haddr[7:2]==6'd20}};
	assign	{
		hwdata_32_array[19]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[19]
		} = wbe;
	assign	{
		hwdata_32_array_hit[19]
		} = {1{haddr[7:2]==6'd19}};
	assign	{
		hwdata_32_array[18]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[18]
		} = wbe;
	assign	{
		hwdata_32_array_hit[18]
		} = {1{haddr[7:2]==6'd18}};
	assign	{
		hwdata_32_array[17]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[17]
		} = wbe;
	assign	{
		hwdata_32_array_hit[17]
		} = {1{haddr[7:2]==6'd17}};
	assign	{
		hwdata_32_array[16]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[16]
		} = wbe;
	assign	{
		hwdata_32_array_hit[16]
		} = {1{haddr[7:2]==6'd16}};
	assign	{
		hwdata_32_array[15]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[15]
		} = wbe;
	assign	{
		hwdata_32_array_hit[15]
		} = {1{haddr[7:2]==6'd15}};
	assign	{
		hwdata_32_array[14]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[14]
		} = wbe;
	assign	{
		hwdata_32_array_hit[14]
		} = {1{haddr[7:2]==6'd14}};
	assign	{
		hwdata_32_array[13]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[13]
		} = wbe;
	assign	{
		hwdata_32_array_hit[13]
		} = {1{haddr[7:2]==6'd13}};
	assign	{
		hwdata_32_array[12]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[12]
		} = wbe;
	assign	{
		hwdata_32_array_hit[12]
		} = {1{haddr[7:2]==6'd12}};
	assign	{
		hwdata_32_array[11]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[11]
		} = wbe;
	assign	{
		hwdata_32_array_hit[11]
		} = {1{haddr[7:2]==6'd11}};
	assign	{
		hwdata_32_array[10]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[10]
		} = wbe;
	assign	{
		hwdata_32_array_hit[10]
		} = {1{haddr[7:2]==6'd10}};
	assign	{
		hwdata_32_array[9]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[9]
		} = wbe;
	assign	{
		hwdata_32_array_hit[9]
		} = {1{haddr[7:2]==6'd9}};
	assign	{
		hwdata_32_array[8]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[8]
		} = wbe;
	assign	{
		hwdata_32_array_hit[8]
		} = {1{haddr[7:2]==6'd8}};
	assign	{
		hwdata_32_array[7]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[7]
		} = wbe;
	assign	{
		hwdata_32_array_hit[7]
		} = {1{haddr[7:2]==6'd7}};
	assign	{
		hwdata_32_array[6]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[6]
		} = wbe;
	assign	{
		hwdata_32_array_hit[6]
		} = {1{haddr[7:2]==6'd6}};
	assign	{
		hwdata_32_array[5]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[5]
		} = wbe;
	assign	{
		hwdata_32_array_hit[5]
		} = {1{haddr[7:2]==6'd5}};
	assign	{
		hwdata_32_array[4]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[4]
		} = wbe;
	assign	{
		hwdata_32_array_hit[4]
		} = {1{haddr[7:2]==6'd4}};
	assign	{
		hwdata_32_array[3]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[3]
		} = wbe;
	assign	{
		hwdata_32_array_hit[3]
		} = {1{haddr[7:2]==6'd3}};
	assign	{
		hwdata_32_array[2]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[2]
		} = wbe;
	assign	{
		hwdata_32_array_hit[2]
		} = {1{haddr[7:2]==6'd2}};
	assign	{
		hwdata_32_array[1]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[1]
		} = wbe;
	assign	{
		hwdata_32_array_hit[1]
		} = {1{haddr[7:2]==6'd1}};
	assign	{
		hwdata_32_array[0]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[0]
		} = wbe;
	assign	{
		hwdata_32_array_hit[0]
		} = {1{haddr[7:2]==6'd0}};
end // DATA_WIDTH 32
if (DATA_WIDTH == 64) begin: gen_hrdata_dw_64
	assign	hrdata_match_data_width	=	{
					hrdata_32_array[{hrdata_32_array_addr[6:3],1'd1}],
					hrdata_32_array[{hrdata_32_array_addr[6:3],1'd0}]
	};
	assign	{
		hwdata_32_array[31],
		hwdata_32_array[30]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[31],
		hwdata_32_array_wbe[30]
		} = wbe;
	assign	{
		hwdata_32_array_hit[31],
		hwdata_32_array_hit[30]
		} = {2{haddr[7:3]==5'd15}};
	assign	{
		hwdata_32_array[29],
		hwdata_32_array[28]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[29],
		hwdata_32_array_wbe[28]
		} = wbe;
	assign	{
		hwdata_32_array_hit[29],
		hwdata_32_array_hit[28]
		} = {2{haddr[7:3]==5'd14}};
	assign	{
		hwdata_32_array[27],
		hwdata_32_array[26]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[27],
		hwdata_32_array_wbe[26]
		} = wbe;
	assign	{
		hwdata_32_array_hit[27],
		hwdata_32_array_hit[26]
		} = {2{haddr[7:3]==5'd13}};
	assign	{
		hwdata_32_array[25],
		hwdata_32_array[24]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[25],
		hwdata_32_array_wbe[24]
		} = wbe;
	assign	{
		hwdata_32_array_hit[25],
		hwdata_32_array_hit[24]
		} = {2{haddr[7:3]==5'd12}};
	assign	{
		hwdata_32_array[23],
		hwdata_32_array[22]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[23],
		hwdata_32_array_wbe[22]
		} = wbe;
	assign	{
		hwdata_32_array_hit[23],
		hwdata_32_array_hit[22]
		} = {2{haddr[7:3]==5'd11}};
	assign	{
		hwdata_32_array[21],
		hwdata_32_array[20]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[21],
		hwdata_32_array_wbe[20]
		} = wbe;
	assign	{
		hwdata_32_array_hit[21],
		hwdata_32_array_hit[20]
		} = {2{haddr[7:3]==5'd10}};
	assign	{
		hwdata_32_array[19],
		hwdata_32_array[18]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[19],
		hwdata_32_array_wbe[18]
		} = wbe;
	assign	{
		hwdata_32_array_hit[19],
		hwdata_32_array_hit[18]
		} = {2{haddr[7:3]==5'd9}};
	assign	{
		hwdata_32_array[17],
		hwdata_32_array[16]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[17],
		hwdata_32_array_wbe[16]
		} = wbe;
	assign	{
		hwdata_32_array_hit[17],
		hwdata_32_array_hit[16]
		} = {2{haddr[7:3]==5'd8}};
	assign	{
		hwdata_32_array[15],
		hwdata_32_array[14]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[15],
		hwdata_32_array_wbe[14]
		} = wbe;
	assign	{
		hwdata_32_array_hit[15],
		hwdata_32_array_hit[14]
		} = {2{haddr[7:3]==5'd7}};
	assign	{
		hwdata_32_array[13],
		hwdata_32_array[12]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[13],
		hwdata_32_array_wbe[12]
		} = wbe;
	assign	{
		hwdata_32_array_hit[13],
		hwdata_32_array_hit[12]
		} = {2{haddr[7:3]==5'd6}};
	assign	{
		hwdata_32_array[11],
		hwdata_32_array[10]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[11],
		hwdata_32_array_wbe[10]
		} = wbe;
	assign	{
		hwdata_32_array_hit[11],
		hwdata_32_array_hit[10]
		} = {2{haddr[7:3]==5'd5}};
	assign	{
		hwdata_32_array[9],
		hwdata_32_array[8]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[9],
		hwdata_32_array_wbe[8]
		} = wbe;
	assign	{
		hwdata_32_array_hit[9],
		hwdata_32_array_hit[8]
		} = {2{haddr[7:3]==5'd4}};
	assign	{
		hwdata_32_array[7],
		hwdata_32_array[6]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[7],
		hwdata_32_array_wbe[6]
		} = wbe;
	assign	{
		hwdata_32_array_hit[7],
		hwdata_32_array_hit[6]
		} = {2{haddr[7:3]==5'd3}};
	assign	{
		hwdata_32_array[5],
		hwdata_32_array[4]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[5],
		hwdata_32_array_wbe[4]
		} = wbe;
	assign	{
		hwdata_32_array_hit[5],
		hwdata_32_array_hit[4]
		} = {2{haddr[7:3]==5'd2}};
	assign	{
		hwdata_32_array[3],
		hwdata_32_array[2]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[3],
		hwdata_32_array_wbe[2]
		} = wbe;
	assign	{
		hwdata_32_array_hit[3],
		hwdata_32_array_hit[2]
		} = {2{haddr[7:3]==5'd1}};
	assign	{
		hwdata_32_array[1],
		hwdata_32_array[0]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[1],
		hwdata_32_array_wbe[0]
		} = wbe;
	assign	{
		hwdata_32_array_hit[1],
		hwdata_32_array_hit[0]
		} = {2{haddr[7:3]==5'd0}};
end // DATA_WIDTH 64
if (DATA_WIDTH == 128) begin: gen_hrdata_dw_128
	assign	hrdata_match_data_width	=	{
					hrdata_32_array[{hrdata_32_array_addr[6:4],2'd3}],
					hrdata_32_array[{hrdata_32_array_addr[6:4],2'd2}],
					hrdata_32_array[{hrdata_32_array_addr[6:4],2'd1}],
					hrdata_32_array[{hrdata_32_array_addr[6:4],2'd0}]
	};
	assign	{
		hwdata_32_array[31],
		hwdata_32_array[30],
		hwdata_32_array[29],
		hwdata_32_array[28]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[31],
		hwdata_32_array_wbe[30],
		hwdata_32_array_wbe[29],
		hwdata_32_array_wbe[28]
		} = wbe;
	assign	{
		hwdata_32_array_hit[31],
		hwdata_32_array_hit[30],
		hwdata_32_array_hit[29],
		hwdata_32_array_hit[28]
		} = {4{haddr[7:4]==4'd7}};
	assign	{
		hwdata_32_array[27],
		hwdata_32_array[26],
		hwdata_32_array[25],
		hwdata_32_array[24]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[27],
		hwdata_32_array_wbe[26],
		hwdata_32_array_wbe[25],
		hwdata_32_array_wbe[24]
		} = wbe;
	assign	{
		hwdata_32_array_hit[27],
		hwdata_32_array_hit[26],
		hwdata_32_array_hit[25],
		hwdata_32_array_hit[24]
		} = {4{haddr[7:4]==4'd6}};
	assign	{
		hwdata_32_array[23],
		hwdata_32_array[22],
		hwdata_32_array[21],
		hwdata_32_array[20]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[23],
		hwdata_32_array_wbe[22],
		hwdata_32_array_wbe[21],
		hwdata_32_array_wbe[20]
		} = wbe;
	assign	{
		hwdata_32_array_hit[23],
		hwdata_32_array_hit[22],
		hwdata_32_array_hit[21],
		hwdata_32_array_hit[20]
		} = {4{haddr[7:4]==4'd5}};
	assign	{
		hwdata_32_array[19],
		hwdata_32_array[18],
		hwdata_32_array[17],
		hwdata_32_array[16]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[19],
		hwdata_32_array_wbe[18],
		hwdata_32_array_wbe[17],
		hwdata_32_array_wbe[16]
		} = wbe;
	assign	{
		hwdata_32_array_hit[19],
		hwdata_32_array_hit[18],
		hwdata_32_array_hit[17],
		hwdata_32_array_hit[16]
		} = {4{haddr[7:4]==4'd4}};
	assign	{
		hwdata_32_array[15],
		hwdata_32_array[14],
		hwdata_32_array[13],
		hwdata_32_array[12]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[15],
		hwdata_32_array_wbe[14],
		hwdata_32_array_wbe[13],
		hwdata_32_array_wbe[12]
		} = wbe;
	assign	{
		hwdata_32_array_hit[15],
		hwdata_32_array_hit[14],
		hwdata_32_array_hit[13],
		hwdata_32_array_hit[12]
		} = {4{haddr[7:4]==4'd3}};
	assign	{
		hwdata_32_array[11],
		hwdata_32_array[10],
		hwdata_32_array[9],
		hwdata_32_array[8]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[11],
		hwdata_32_array_wbe[10],
		hwdata_32_array_wbe[9],
		hwdata_32_array_wbe[8]
		} = wbe;
	assign	{
		hwdata_32_array_hit[11],
		hwdata_32_array_hit[10],
		hwdata_32_array_hit[9],
		hwdata_32_array_hit[8]
		} = {4{haddr[7:4]==4'd2}};
	assign	{
		hwdata_32_array[7],
		hwdata_32_array[6],
		hwdata_32_array[5],
		hwdata_32_array[4]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[7],
		hwdata_32_array_wbe[6],
		hwdata_32_array_wbe[5],
		hwdata_32_array_wbe[4]
		} = wbe;
	assign	{
		hwdata_32_array_hit[7],
		hwdata_32_array_hit[6],
		hwdata_32_array_hit[5],
		hwdata_32_array_hit[4]
		} = {4{haddr[7:4]==4'd1}};
	assign	{
		hwdata_32_array[3],
		hwdata_32_array[2],
		hwdata_32_array[1],
		hwdata_32_array[0]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[3],
		hwdata_32_array_wbe[2],
		hwdata_32_array_wbe[1],
		hwdata_32_array_wbe[0]
		} = wbe;
	assign	{
		hwdata_32_array_hit[3],
		hwdata_32_array_hit[2],
		hwdata_32_array_hit[1],
		hwdata_32_array_hit[0]
		} = {4{haddr[7:4]==4'd0}};
end // DATA_WIDTH 128
if (DATA_WIDTH == 256) begin: gen_hrdata_dw_256
	assign	hrdata_match_data_width	=	{
					hrdata_32_array[{hrdata_32_array_addr[6:5],3'd7}],
					hrdata_32_array[{hrdata_32_array_addr[6:5],3'd6}],
					hrdata_32_array[{hrdata_32_array_addr[6:5],3'd5}],
					hrdata_32_array[{hrdata_32_array_addr[6:5],3'd4}],
					hrdata_32_array[{hrdata_32_array_addr[6:5],3'd3}],
					hrdata_32_array[{hrdata_32_array_addr[6:5],3'd2}],
					hrdata_32_array[{hrdata_32_array_addr[6:5],3'd1}],
					hrdata_32_array[{hrdata_32_array_addr[6:5],3'd0}]
	};
	assign	{
		hwdata_32_array[31],
		hwdata_32_array[30],
		hwdata_32_array[29],
		hwdata_32_array[28],
		hwdata_32_array[27],
		hwdata_32_array[26],
		hwdata_32_array[25],
		hwdata_32_array[24]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[31],
		hwdata_32_array_wbe[30],
		hwdata_32_array_wbe[29],
		hwdata_32_array_wbe[28],
		hwdata_32_array_wbe[27],
		hwdata_32_array_wbe[26],
		hwdata_32_array_wbe[25],
		hwdata_32_array_wbe[24]
		} = wbe;
	assign	{
		hwdata_32_array_hit[31],
		hwdata_32_array_hit[30],
		hwdata_32_array_hit[29],
		hwdata_32_array_hit[28],
		hwdata_32_array_hit[27],
		hwdata_32_array_hit[26],
		hwdata_32_array_hit[25],
		hwdata_32_array_hit[24]
		} = {8{haddr[7:5]==3'd3}};
	assign	{
		hwdata_32_array[23],
		hwdata_32_array[22],
		hwdata_32_array[21],
		hwdata_32_array[20],
		hwdata_32_array[19],
		hwdata_32_array[18],
		hwdata_32_array[17],
		hwdata_32_array[16]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[23],
		hwdata_32_array_wbe[22],
		hwdata_32_array_wbe[21],
		hwdata_32_array_wbe[20],
		hwdata_32_array_wbe[19],
		hwdata_32_array_wbe[18],
		hwdata_32_array_wbe[17],
		hwdata_32_array_wbe[16]
		} = wbe;
	assign	{
		hwdata_32_array_hit[23],
		hwdata_32_array_hit[22],
		hwdata_32_array_hit[21],
		hwdata_32_array_hit[20],
		hwdata_32_array_hit[19],
		hwdata_32_array_hit[18],
		hwdata_32_array_hit[17],
		hwdata_32_array_hit[16]
		} = {8{haddr[7:5]==3'd2}};
	assign	{
		hwdata_32_array[15],
		hwdata_32_array[14],
		hwdata_32_array[13],
		hwdata_32_array[12],
		hwdata_32_array[11],
		hwdata_32_array[10],
		hwdata_32_array[9],
		hwdata_32_array[8]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[15],
		hwdata_32_array_wbe[14],
		hwdata_32_array_wbe[13],
		hwdata_32_array_wbe[12],
		hwdata_32_array_wbe[11],
		hwdata_32_array_wbe[10],
		hwdata_32_array_wbe[9],
		hwdata_32_array_wbe[8]
		} = wbe;
	assign	{
		hwdata_32_array_hit[15],
		hwdata_32_array_hit[14],
		hwdata_32_array_hit[13],
		hwdata_32_array_hit[12],
		hwdata_32_array_hit[11],
		hwdata_32_array_hit[10],
		hwdata_32_array_hit[9],
		hwdata_32_array_hit[8]
		} = {8{haddr[7:5]==3'd1}};
	assign	{
		hwdata_32_array[7],
		hwdata_32_array[6],
		hwdata_32_array[5],
		hwdata_32_array[4],
		hwdata_32_array[3],
		hwdata_32_array[2],
		hwdata_32_array[1],
		hwdata_32_array[0]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[7],
		hwdata_32_array_wbe[6],
		hwdata_32_array_wbe[5],
		hwdata_32_array_wbe[4],
		hwdata_32_array_wbe[3],
		hwdata_32_array_wbe[2],
		hwdata_32_array_wbe[1],
		hwdata_32_array_wbe[0]
		} = wbe;
	assign	{
		hwdata_32_array_hit[7],
		hwdata_32_array_hit[6],
		hwdata_32_array_hit[5],
		hwdata_32_array_hit[4],
		hwdata_32_array_hit[3],
		hwdata_32_array_hit[2],
		hwdata_32_array_hit[1],
		hwdata_32_array_hit[0]
		} = {8{haddr[7:5]==3'd0}};
end // DATA_WIDTH 256
if (DATA_WIDTH == 512) begin: gen_hrdata_dw_512
	assign	hrdata_match_data_width	=	{
					hrdata_32_array[{hrdata_32_array_addr[6],4'd15}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd14}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd13}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd12}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd11}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd10}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd9}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd8}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd7}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd6}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd5}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd4}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd3}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd2}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd1}],
					hrdata_32_array[{hrdata_32_array_addr[6],4'd0}]
	};
	assign	{
		hwdata_32_array[31],
		hwdata_32_array[30],
		hwdata_32_array[29],
		hwdata_32_array[28],
		hwdata_32_array[27],
		hwdata_32_array[26],
		hwdata_32_array[25],
		hwdata_32_array[24],
		hwdata_32_array[23],
		hwdata_32_array[22],
		hwdata_32_array[21],
		hwdata_32_array[20],
		hwdata_32_array[19],
		hwdata_32_array[18],
		hwdata_32_array[17],
		hwdata_32_array[16]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[31],
		hwdata_32_array_wbe[30],
		hwdata_32_array_wbe[29],
		hwdata_32_array_wbe[28],
		hwdata_32_array_wbe[27],
		hwdata_32_array_wbe[26],
		hwdata_32_array_wbe[25],
		hwdata_32_array_wbe[24],
		hwdata_32_array_wbe[23],
		hwdata_32_array_wbe[22],
		hwdata_32_array_wbe[21],
		hwdata_32_array_wbe[20],
		hwdata_32_array_wbe[19],
		hwdata_32_array_wbe[18],
		hwdata_32_array_wbe[17],
		hwdata_32_array_wbe[16]
		} = wbe;
	assign	{
		hwdata_32_array_hit[31],
		hwdata_32_array_hit[30],
		hwdata_32_array_hit[29],
		hwdata_32_array_hit[28],
		hwdata_32_array_hit[27],
		hwdata_32_array_hit[26],
		hwdata_32_array_hit[25],
		hwdata_32_array_hit[24],
		hwdata_32_array_hit[23],
		hwdata_32_array_hit[22],
		hwdata_32_array_hit[21],
		hwdata_32_array_hit[20],
		hwdata_32_array_hit[19],
		hwdata_32_array_hit[18],
		hwdata_32_array_hit[17],
		hwdata_32_array_hit[16]
		} = {16{haddr[7:6]==2'd1}};
	assign	{
		hwdata_32_array[15],
		hwdata_32_array[14],
		hwdata_32_array[13],
		hwdata_32_array[12],
		hwdata_32_array[11],
		hwdata_32_array[10],
		hwdata_32_array[9],
		hwdata_32_array[8],
		hwdata_32_array[7],
		hwdata_32_array[6],
		hwdata_32_array[5],
		hwdata_32_array[4],
		hwdata_32_array[3],
		hwdata_32_array[2],
		hwdata_32_array[1],
		hwdata_32_array[0]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[15],
		hwdata_32_array_wbe[14],
		hwdata_32_array_wbe[13],
		hwdata_32_array_wbe[12],
		hwdata_32_array_wbe[11],
		hwdata_32_array_wbe[10],
		hwdata_32_array_wbe[9],
		hwdata_32_array_wbe[8],
		hwdata_32_array_wbe[7],
		hwdata_32_array_wbe[6],
		hwdata_32_array_wbe[5],
		hwdata_32_array_wbe[4],
		hwdata_32_array_wbe[3],
		hwdata_32_array_wbe[2],
		hwdata_32_array_wbe[1],
		hwdata_32_array_wbe[0]
		} = wbe;
	assign	{
		hwdata_32_array_hit[15],
		hwdata_32_array_hit[14],
		hwdata_32_array_hit[13],
		hwdata_32_array_hit[12],
		hwdata_32_array_hit[11],
		hwdata_32_array_hit[10],
		hwdata_32_array_hit[9],
		hwdata_32_array_hit[8],
		hwdata_32_array_hit[7],
		hwdata_32_array_hit[6],
		hwdata_32_array_hit[5],
		hwdata_32_array_hit[4],
		hwdata_32_array_hit[3],
		hwdata_32_array_hit[2],
		hwdata_32_array_hit[1],
		hwdata_32_array_hit[0]
		} = {16{haddr[7:6]==2'd0}};
end // DATA_WIDTH 512
if (DATA_WIDTH == 1024) begin: gen_hrdata_dw_1024
	assign	hrdata_match_data_width	=	{
					hrdata_32_array[5'd31],
					hrdata_32_array[5'd30],
					hrdata_32_array[5'd29],
					hrdata_32_array[5'd28],
					hrdata_32_array[5'd27],
					hrdata_32_array[5'd26],
					hrdata_32_array[5'd25],
					hrdata_32_array[5'd24],
					hrdata_32_array[5'd23],
					hrdata_32_array[5'd22],
					hrdata_32_array[5'd21],
					hrdata_32_array[5'd20],
					hrdata_32_array[5'd19],
					hrdata_32_array[5'd18],
					hrdata_32_array[5'd17],
					hrdata_32_array[5'd16],
					hrdata_32_array[5'd15],
					hrdata_32_array[5'd14],
					hrdata_32_array[5'd13],
					hrdata_32_array[5'd12],
					hrdata_32_array[5'd11],
					hrdata_32_array[5'd10],
					hrdata_32_array[5'd9],
					hrdata_32_array[5'd8],
					hrdata_32_array[5'd7],
					hrdata_32_array[5'd6],
					hrdata_32_array[5'd5],
					hrdata_32_array[5'd4],
					hrdata_32_array[5'd3],
					hrdata_32_array[5'd2],
					hrdata_32_array[5'd1],
					hrdata_32_array[5'd0]
	};
	assign	{
		hwdata_32_array[31],
		hwdata_32_array[30],
		hwdata_32_array[29],
		hwdata_32_array[28],
		hwdata_32_array[27],
		hwdata_32_array[26],
		hwdata_32_array[25],
		hwdata_32_array[24],
		hwdata_32_array[23],
		hwdata_32_array[22],
		hwdata_32_array[21],
		hwdata_32_array[20],
		hwdata_32_array[19],
		hwdata_32_array[18],
		hwdata_32_array[17],
		hwdata_32_array[16],
		hwdata_32_array[15],
		hwdata_32_array[14],
		hwdata_32_array[13],
		hwdata_32_array[12],
		hwdata_32_array[11],
		hwdata_32_array[10],
		hwdata_32_array[9],
		hwdata_32_array[8],
		hwdata_32_array[7],
		hwdata_32_array[6],
		hwdata_32_array[5],
		hwdata_32_array[4],
		hwdata_32_array[3],
		hwdata_32_array[2],
		hwdata_32_array[1],
		hwdata_32_array[0]
		} = hwdata;
	assign	{
		hwdata_32_array_wbe[31],
		hwdata_32_array_wbe[30],
		hwdata_32_array_wbe[29],
		hwdata_32_array_wbe[28],
		hwdata_32_array_wbe[27],
		hwdata_32_array_wbe[26],
		hwdata_32_array_wbe[25],
		hwdata_32_array_wbe[24],
		hwdata_32_array_wbe[23],
		hwdata_32_array_wbe[22],
		hwdata_32_array_wbe[21],
		hwdata_32_array_wbe[20],
		hwdata_32_array_wbe[19],
		hwdata_32_array_wbe[18],
		hwdata_32_array_wbe[17],
		hwdata_32_array_wbe[16],
		hwdata_32_array_wbe[15],
		hwdata_32_array_wbe[14],
		hwdata_32_array_wbe[13],
		hwdata_32_array_wbe[12],
		hwdata_32_array_wbe[11],
		hwdata_32_array_wbe[10],
		hwdata_32_array_wbe[9],
		hwdata_32_array_wbe[8],
		hwdata_32_array_wbe[7],
		hwdata_32_array_wbe[6],
		hwdata_32_array_wbe[5],
		hwdata_32_array_wbe[4],
		hwdata_32_array_wbe[3],
		hwdata_32_array_wbe[2],
		hwdata_32_array_wbe[1],
		hwdata_32_array_wbe[0]
		} = wbe;
	assign	{
		hwdata_32_array_hit[31],
		hwdata_32_array_hit[30],
		hwdata_32_array_hit[29],
		hwdata_32_array_hit[28],
		hwdata_32_array_hit[27],
		hwdata_32_array_hit[26],
		hwdata_32_array_hit[25],
		hwdata_32_array_hit[24],
		hwdata_32_array_hit[23],
		hwdata_32_array_hit[22],
		hwdata_32_array_hit[21],
		hwdata_32_array_hit[20],
		hwdata_32_array_hit[19],
		hwdata_32_array_hit[18],
		hwdata_32_array_hit[17],
		hwdata_32_array_hit[16],
		hwdata_32_array_hit[15],
		hwdata_32_array_hit[14],
		hwdata_32_array_hit[13],
		hwdata_32_array_hit[12],
		hwdata_32_array_hit[11],
		hwdata_32_array_hit[10],
		hwdata_32_array_hit[9],
		hwdata_32_array_hit[8],
		hwdata_32_array_hit[7],
		hwdata_32_array_hit[6],
		hwdata_32_array_hit[5],
		hwdata_32_array_hit[4],
		hwdata_32_array_hit[3],
		hwdata_32_array_hit[2],
		hwdata_32_array_hit[1],
		hwdata_32_array_hit[0]
		} = {32{haddr[7]==1'd0}};
end // DATA_WIDTH 1024
endgenerate
// VPERL_GENERATED_END

assign ren = hsel & hready_in & ~hwrite & htrans[1];
wire hrdata_sel = read_af_write ? haddr_d1[7] : haddr[7];
always @(posedge hclk) begin
    if (ren || read_af_write) begin
        case (hrdata_sel)
        1'b0: 
		hrdata <= hrdata_match_data_width;
	default:
		hrdata <= {DATA_WIDTH{1'b0}};
	endcase
    end
end

endmodule

