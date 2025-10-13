// VPERL_BEGIN
// &MODULE(atcaxi2tluh500);
//&PORT_ORDER("clk");
//&PORT_ORDER("resetn");
//&PORT_ORDER("aclk");
//&PORT_ORDER("araddr");
//&PORT_ORDER("arburst");
//&PORT_ORDER("arcache");
//&PORT_ORDER("aresetn");
//&PORT_ORDER("arid");
//&PORT_ORDER("arlen");
//&PORT_ORDER("arlock");
//&PORT_ORDER("arprot");
//&PORT_ORDER("arready");
//&PORT_ORDER("arsize");
//&PORT_ORDER("arvalid");
//&PORT_ORDER("awaddr");
//&PORT_ORDER("awburst");
//&PORT_ORDER("awcache");
//&PORT_ORDER("awid");
//&PORT_ORDER("awlen");
//&PORT_ORDER("awlock");
//&PORT_ORDER("awprot");
//&PORT_ORDER("awready");
//&PORT_ORDER("awsize");
//&PORT_ORDER("awvalid");
//&PORT_ORDER("bid");
//&PORT_ORDER("bready");
//&PORT_ORDER("bresp");
//&PORT_ORDER("bvalid");
//&PORT_ORDER("clk_en");
//&PORT_ORDER("rdata");
//&PORT_ORDER("rid");
//&PORT_ORDER("rlast");
//&PORT_ORDER("rready");
//&PORT_ORDER("rresp");
//&PORT_ORDER("rvalid");
//&PORT_ORDER("wdata");
//&PORT_ORDER("wlast");
//&PORT_ORDER("wready");
//&PORT_ORDER("wstrb");
//&PORT_ORDER("wvalid");
//&PORT_ORDER("tluh_0_a_address");
//&PORT_ORDER("tluh_0_a_corrupt");
//&PORT_ORDER("tluh_0_a_data");
//&PORT_ORDER("tluh_0_a_mask");
//&PORT_ORDER("tluh_0_a_opcode");
//&PORT_ORDER("tluh_0_a_param");
//&PORT_ORDER("tluh_0_a_ready");
//&PORT_ORDER("tluh_0_a_size");
//&PORT_ORDER("tluh_0_a_source");
//&PORT_ORDER("tluh_0_a_user");
//&PORT_ORDER("tluh_0_a_valid");
//&PORT_ORDER("tluh_0_d_corrupt");
//&PORT_ORDER("tluh_0_d_data");
//&PORT_ORDER("tluh_0_d_denied");
//&PORT_ORDER("tluh_0_d_opcode");
//&PORT_ORDER("tluh_0_d_param");
//&PORT_ORDER("tluh_0_d_ready");
//&PORT_ORDER("tluh_0_d_sink");
//&PORT_ORDER("tluh_0_d_size");
//&PORT_ORDER("tluh_0_d_source");
//&PORT_ORDER("tluh_0_d_user");
//&PORT_ORDER("tluh_0_d_valid");
//&PORT_ORDER("tluh_1_a_address");
//&PORT_ORDER("tluh_1_a_corrupt");
//&PORT_ORDER("tluh_1_a_data");
//&PORT_ORDER("tluh_1_a_mask");
//&PORT_ORDER("tluh_1_a_opcode");
//&PORT_ORDER("tluh_1_a_param");
//&PORT_ORDER("tluh_1_a_ready");
//&PORT_ORDER("tluh_1_a_size");
//&PORT_ORDER("tluh_1_a_source");
//&PORT_ORDER("tluh_1_a_user");
//&PORT_ORDER("tluh_1_a_valid");
//&PORT_ORDER("tluh_1_d_corrupt");
//&PORT_ORDER("tluh_1_d_data");
//&PORT_ORDER("tluh_1_d_denied");
//&PORT_ORDER("tluh_1_d_opcode");
//&PORT_ORDER("tluh_1_d_param");
//&PORT_ORDER("tluh_1_d_ready");
//&PORT_ORDER("tluh_1_d_sink");
//&PORT_ORDER("tluh_1_d_size");
//&PORT_ORDER("tluh_1_d_source");
//&PORT_ORDER("tluh_1_d_user");
//&PORT_ORDER("tluh_1_d_valid");
//&PORT_ORDER("tluh_2_a_address");
//&PORT_ORDER("tluh_2_a_corrupt");
//&PORT_ORDER("tluh_2_a_data");
//&PORT_ORDER("tluh_2_a_mask");
//&PORT_ORDER("tluh_2_a_opcode");
//&PORT_ORDER("tluh_2_a_param");
//&PORT_ORDER("tluh_2_a_ready");
//&PORT_ORDER("tluh_2_a_size");
//&PORT_ORDER("tluh_2_a_source");
//&PORT_ORDER("tluh_2_a_user");
//&PORT_ORDER("tluh_2_a_valid");
//&PORT_ORDER("tluh_2_d_corrupt");
//&PORT_ORDER("tluh_2_d_data");
//&PORT_ORDER("tluh_2_d_denied");
//&PORT_ORDER("tluh_2_d_opcode");
//&PORT_ORDER("tluh_2_d_param");
//&PORT_ORDER("tluh_2_d_ready");
//&PORT_ORDER("tluh_2_d_sink");
//&PORT_ORDER("tluh_2_d_size");
//&PORT_ORDER("tluh_2_d_source");
//&PORT_ORDER("tluh_2_d_user");
//&PORT_ORDER("tluh_2_d_valid");
//&PORT_ORDER("tluh_3_a_address");
//&PORT_ORDER("tluh_3_a_corrupt");
//&PORT_ORDER("tluh_3_a_data");
//&PORT_ORDER("tluh_3_a_mask");
//&PORT_ORDER("tluh_3_a_opcode");
//&PORT_ORDER("tluh_3_a_param");
//&PORT_ORDER("tluh_3_a_ready");
//&PORT_ORDER("tluh_3_a_size");
//&PORT_ORDER("tluh_3_a_source");
//&PORT_ORDER("tluh_3_a_user");
//&PORT_ORDER("tluh_3_a_valid");
//&PORT_ORDER("tluh_3_d_corrupt");
//&PORT_ORDER("tluh_3_d_data");
//&PORT_ORDER("tluh_3_d_denied");
//&PORT_ORDER("tluh_3_d_opcode");
//&PORT_ORDER("tluh_3_d_param");
//&PORT_ORDER("tluh_3_d_ready");
//&PORT_ORDER("tluh_3_d_sink");
//&PORT_ORDER("tluh_3_d_size");
//&PORT_ORDER("tluh_3_d_source");
//&PORT_ORDER("tluh_3_d_user");
//&PORT_ORDER("tluh_3_d_valid");

// &PARAM("ADDR_WIDTH 		= 64");
// &PARAM("DATA_WIDTH		= 256");
// &PARAM("ID_WIDTH		= 4");
// &PARAM("TL_SIZE_WIDTH	= 4");
// &PARAM("TL_SINK_WIDTH	= 1");
// &PARAM("TL_SOURCE_WIDTH	= 3");
// &PARAM("TL_A_USER_WIDTH	= 8");
// &PARAM("TL_D_USER_WIDTH	= 8");
// &PARAM("TL_OUTSTANDING	= 8");
// &PARAM("TL_CHANNEL_NUM	= 4");
// &PARAM("ASYNC		= 0");
// &PARAM("SYNC_STAGE		= 3");
// &PARAM("ASYNC_DEPTH		= 8");
// &PARAM("AFIFO_DP_SYNC	= 1");
// &PARAM("RAR_SUPPORT		= 0");
// &LOCALPARAM("PRODUCT_ID = 32'h00115050");

// &PARAM("DEVICE_REGION0_BASE = 64'hffffffff_ffffffff");
// &PARAM("DEVICE_REGION0_MASK = 64'h00000000_00000000");
// &PARAM("DEVICE_REGION1_BASE = 64'hffffffff_ffffffff");
// &PARAM("DEVICE_REGION1_MASK = 64'h00000000_00000000");
// &PARAM("DEVICE_REGION2_BASE = 64'hffffffff_ffffffff");
// &PARAM("DEVICE_REGION2_MASK = 64'h00000000_00000000");
// &PARAM("DEVICE_REGION3_BASE = 64'hffffffff_ffffffff");
// &PARAM("DEVICE_REGION3_MASK = 64'h00000000_00000000");
// &PARAM("DEVICE_REGION4_BASE = 64'hffffffff_ffffffff");
// &PARAM("DEVICE_REGION4_MASK = 64'h00000000_00000000");
// &PARAM("DEVICE_REGION5_BASE = 64'hffffffff_ffffffff");
// &PARAM("DEVICE_REGION5_MASK = 64'h00000000_00000000");
// &PARAM("DEVICE_REGION6_BASE = 64'hffffffff_ffffffff");
// &PARAM("DEVICE_REGION6_MASK = 64'h00000000_00000000");
// &PARAM("DEVICE_REGION7_BASE = 64'hffffffff_ffffffff");
// &PARAM("DEVICE_REGION7_MASK = 64'h00000000_00000000");

// &LOCALPARAM("OUT_IDX_WIDTH	= $clog2(TL_OUTSTANDING)");
// &LOCALPARAM("CH_IDX_WIDTH		= $clog2(TL_CHANNEL_NUM)");
// &LOCALPARAM("HR_IDX_WIDTH		= ((OUT_IDX_WIDTH + CH_IDX_WIDTH) == 0) ?  1 : (OUT_IDX_WIDTH + CH_IDX_WIDTH)");
// &LOCALPARAM("HR_NUM		= 2**(OUT_IDX_WIDTH + CH_IDX_WIDTH)");
// &LOCALPARAM("AX_FUNC_BITS		= 4");
// # bit 0 : read
// # bit 1 : write
// # bit 2 : single
// # bit 3 : memory

// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcaxi2tluh500/hdl/atcaxi2tluh500_axif.v","u_axif",{
// 	ADDR_WIDTH	=>	ADDR_WIDTH,	
// 	DATA_WIDTH	=>	DATA_WIDTH,	
// 	ID_WIDTH	=>	ID_WIDTH,	
// 	ASYNC		=>	ASYNC,
// 	SYNC_STAGE	=>	SYNC_STAGE,	
// 	ASYNC_DEPTH	=>	ASYNC_DEPTH,	
// 	AFIFO_DP_SYNC	=>	AFIFO_DP_SYNC,	
//	RAR_SUPPORT	=>	RAR_SUPPORT,
// });

// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcaxi2tluh500/hdl/atcaxi2tluh500_axiarb.v","u_axiarb",{
// 	ADDR_WIDTH		=>	ADDR_WIDTH,	
// 	DATA_WIDTH		=>	DATA_WIDTH,	
// 	ID_WIDTH		=>	ID_WIDTH,	
// 	TL_OUTSTANDING		=>	TL_OUTSTANDING,	
// 	TL_CHANNEL_NUM		=>	TL_CHANNEL_NUM,	
// 	AX_FUNC_BITS		=>	AX_FUNC_BITS,	
//	DEVICE_REGION0_BASE	=>	DEVICE_REGION0_BASE,
//	DEVICE_REGION0_MASK	=>	DEVICE_REGION0_MASK,
//	DEVICE_REGION1_BASE	=>	DEVICE_REGION1_BASE,
//	DEVICE_REGION1_MASK	=>	DEVICE_REGION1_MASK,
//	DEVICE_REGION2_BASE	=>	DEVICE_REGION2_BASE,
//	DEVICE_REGION2_MASK	=>	DEVICE_REGION2_MASK,
//	DEVICE_REGION3_BASE	=>	DEVICE_REGION3_BASE,
//	DEVICE_REGION3_MASK	=>	DEVICE_REGION3_MASK,
//	DEVICE_REGION4_BASE	=>	DEVICE_REGION4_BASE,
//	DEVICE_REGION4_MASK	=>	DEVICE_REGION4_MASK,
//	DEVICE_REGION5_BASE	=>	DEVICE_REGION5_BASE,
//	DEVICE_REGION5_MASK	=>	DEVICE_REGION5_MASK,
//	DEVICE_REGION6_BASE	=>	DEVICE_REGION6_BASE,
//	DEVICE_REGION6_MASK	=>	DEVICE_REGION6_MASK,
//	DEVICE_REGION7_BASE	=>	DEVICE_REGION7_BASE,
//	DEVICE_REGION7_MASK	=>	DEVICE_REGION7_MASK,
//	RAR_SUPPORT		=>	RAR_SUPPORT,
// });

// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcaxi2tluh500/hdl/atcaxi2tluh500_hr.v","u_hr",{
// 	ADDR_WIDTH	=>	ADDR_WIDTH,	
// 	DATA_WIDTH	=>	DATA_WIDTH,	
// 	TL_SIZE_WIDTH	=>	TL_SIZE_WIDTH,	
// 	TL_SOURCE_WIDTH	=>	TL_SOURCE_WIDTH,	
// 	TL_A_USER_WIDTH	=>	TL_A_USER_WIDTH,	
// 	TL_D_USER_WIDTH	=>	TL_D_USER_WIDTH,	
// 	TL_OUTSTANDING	=>	TL_OUTSTANDING,	
// 	TL_CHANNEL_NUM	=>	TL_CHANNEL_NUM,	
// 	AX_FUNC_BITS	=>	AX_FUNC_BITS,	
//	RAR_SUPPORT	=>	RAR_SUPPORT,
// });

// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcaxi2tluh500/hdl/atcaxi2tluh500_tlif.v","u_tlif",{
// 	ADDR_WIDTH	=>	ADDR_WIDTH,	
// 	DATA_WIDTH	=>	DATA_WIDTH,	
// 	TL_SIZE_WIDTH	=>	TL_SIZE_WIDTH,	
// 	TL_SINK_WIDTH	=>	TL_SINK_WIDTH,	
// 	TL_SOURCE_WIDTH	=>	TL_SOURCE_WIDTH,	
// 	TL_A_USER_WIDTH	=>	TL_A_USER_WIDTH,	
// 	TL_D_USER_WIDTH	=>	TL_D_USER_WIDTH,	
// 	TL_OUTSTANDING	=>	TL_OUTSTANDING,	
// 	TL_CHANNEL_NUM	=>	TL_CHANNEL_NUM,	
//	RAR_SUPPORT	=>	RAR_SUPPORT,
// });

//&FORCE("input", awlock);
//&FORCE("input", arlock);
//:wire	nds_unused_awlock = awlock;
//:wire	nds_unused_arlock = arlock;

// &ENDMODULE;
// VPERL_END

// VPERL_GENERATED_BEGIN
module atcaxi2tluh500 (
	  clk,              // (u_axiarb,u_axif,u_hr,u_tlif) <= ()
	  resetn,           // (u_axiarb,u_axif,u_hr,u_tlif) <= ()
	  aclk,             // (u_axif) <= ()
	  araddr,           // (u_axif) <= ()
	  arburst,          // (u_axif) <= ()
	  arcache,          // (u_axif) <= ()
	  aresetn,          // (u_axif) <= ()
	  arid,             // (u_axif) <= ()
	  arlen,            // (u_axif) <= ()
	  arlock,           // () <= ()
	  arprot,           // (u_axif) <= ()
	  arready,          // (u_axif) => ()
	  arsize,           // (u_axif) <= ()
	  arvalid,          // (u_axif) <= ()
	  awaddr,           // (u_axif) <= ()
	  awburst,          // (u_axif) <= ()
	  awcache,          // (u_axif) <= ()
	  awid,             // (u_axif) <= ()
	  awlen,            // (u_axif) <= ()
	  awlock,           // () <= ()
	  awprot,           // (u_axif) <= ()
	  awready,          // (u_axif) => ()
	  awsize,           // (u_axif) <= ()
	  awvalid,          // (u_axif) <= ()
	  bid,              // (u_axif) => ()
	  bready,           // (u_axif) <= ()
	  bresp,            // (u_axif) => ()
	  bvalid,           // (u_axif) => ()
	  clk_en,           // (u_axif) <= ()
	  rdata,            // (u_axif) => ()
	  rid,              // (u_axif) => ()
	  rlast,            // (u_axif) => ()
	  rready,           // (u_axif) <= ()
	  rresp,            // (u_axif) => ()
	  rvalid,           // (u_axif) => ()
	  wdata,            // (u_axif) <= ()
	  wlast,            // (u_axif) <= ()
	  wready,           // (u_axif) => ()
	  wstrb,            // (u_axif) <= ()
	  wvalid,           // (u_axif) <= ()
	  tluh_0_a_address, // (u_tlif) => ()
	  tluh_0_a_corrupt, // (u_tlif) => ()
	  tluh_0_a_data,    // (u_tlif) => ()
	  tluh_0_a_mask,    // (u_tlif) => ()
	  tluh_0_a_opcode,  // (u_tlif) => ()
	  tluh_0_a_param,   // (u_tlif) => ()
	  tluh_0_a_ready,   // (u_tlif) <= ()
	  tluh_0_a_size,    // (u_tlif) => ()
	  tluh_0_a_source,  // (u_tlif) => ()
	  tluh_0_a_user,    // (u_tlif) => ()
	  tluh_0_a_valid,   // (u_tlif) => ()
	  tluh_0_d_corrupt, // (u_tlif) <= ()
	  tluh_0_d_data,    // (u_tlif) <= ()
	  tluh_0_d_denied,  // (u_tlif) <= ()
	  tluh_0_d_opcode,  // (u_tlif) <= ()
	  tluh_0_d_param,   // (u_tlif) <= ()
	  tluh_0_d_ready,   // (u_tlif) => ()
	  tluh_0_d_sink,    // (u_tlif) <= ()
	  tluh_0_d_size,    // (u_tlif) <= ()
	  tluh_0_d_source,  // (u_tlif) <= ()
	  tluh_0_d_user,    // (u_tlif) <= ()
	  tluh_0_d_valid,   // (u_tlif) <= ()
	  tluh_1_a_address, // (u_tlif) => ()
	  tluh_1_a_corrupt, // (u_tlif) => ()
	  tluh_1_a_data,    // (u_tlif) => ()
	  tluh_1_a_mask,    // (u_tlif) => ()
	  tluh_1_a_opcode,  // (u_tlif) => ()
	  tluh_1_a_param,   // (u_tlif) => ()
	  tluh_1_a_ready,   // (u_tlif) <= ()
	  tluh_1_a_size,    // (u_tlif) => ()
	  tluh_1_a_source,  // (u_tlif) => ()
	  tluh_1_a_user,    // (u_tlif) => ()
	  tluh_1_a_valid,   // (u_tlif) => ()
	  tluh_1_d_corrupt, // (u_tlif) <= ()
	  tluh_1_d_data,    // (u_tlif) <= ()
	  tluh_1_d_denied,  // (u_tlif) <= ()
	  tluh_1_d_opcode,  // (u_tlif) <= ()
	  tluh_1_d_param,   // (u_tlif) <= ()
	  tluh_1_d_ready,   // (u_tlif) => ()
	  tluh_1_d_sink,    // (u_tlif) <= ()
	  tluh_1_d_size,    // (u_tlif) <= ()
	  tluh_1_d_source,  // (u_tlif) <= ()
	  tluh_1_d_user,    // (u_tlif) <= ()
	  tluh_1_d_valid,   // (u_tlif) <= ()
	  tluh_2_a_address, // (u_tlif) => ()
	  tluh_2_a_corrupt, // (u_tlif) => ()
	  tluh_2_a_data,    // (u_tlif) => ()
	  tluh_2_a_mask,    // (u_tlif) => ()
	  tluh_2_a_opcode,  // (u_tlif) => ()
	  tluh_2_a_param,   // (u_tlif) => ()
	  tluh_2_a_ready,   // (u_tlif) <= ()
	  tluh_2_a_size,    // (u_tlif) => ()
	  tluh_2_a_source,  // (u_tlif) => ()
	  tluh_2_a_user,    // (u_tlif) => ()
	  tluh_2_a_valid,   // (u_tlif) => ()
	  tluh_2_d_corrupt, // (u_tlif) <= ()
	  tluh_2_d_data,    // (u_tlif) <= ()
	  tluh_2_d_denied,  // (u_tlif) <= ()
	  tluh_2_d_opcode,  // (u_tlif) <= ()
	  tluh_2_d_param,   // (u_tlif) <= ()
	  tluh_2_d_ready,   // (u_tlif) => ()
	  tluh_2_d_sink,    // (u_tlif) <= ()
	  tluh_2_d_size,    // (u_tlif) <= ()
	  tluh_2_d_source,  // (u_tlif) <= ()
	  tluh_2_d_user,    // (u_tlif) <= ()
	  tluh_2_d_valid,   // (u_tlif) <= ()
	  tluh_3_a_address, // (u_tlif) => ()
	  tluh_3_a_corrupt, // (u_tlif) => ()
	  tluh_3_a_data,    // (u_tlif) => ()
	  tluh_3_a_mask,    // (u_tlif) => ()
	  tluh_3_a_opcode,  // (u_tlif) => ()
	  tluh_3_a_param,   // (u_tlif) => ()
	  tluh_3_a_ready,   // (u_tlif) <= ()
	  tluh_3_a_size,    // (u_tlif) => ()
	  tluh_3_a_source,  // (u_tlif) => ()
	  tluh_3_a_user,    // (u_tlif) => ()
	  tluh_3_a_valid,   // (u_tlif) => ()
	  tluh_3_d_corrupt, // (u_tlif) <= ()
	  tluh_3_d_data,    // (u_tlif) <= ()
	  tluh_3_d_denied,  // (u_tlif) <= ()
	  tluh_3_d_opcode,  // (u_tlif) <= ()
	  tluh_3_d_param,   // (u_tlif) <= ()
	  tluh_3_d_ready,   // (u_tlif) => ()
	  tluh_3_d_sink,    // (u_tlif) <= ()
	  tluh_3_d_size,    // (u_tlif) <= ()
	  tluh_3_d_source,  // (u_tlif) <= ()
	  tluh_3_d_user,    // (u_tlif) <= ()
	  tluh_3_d_valid    // (u_tlif) <= ()
);

parameter ADDR_WIDTH 		= 64;
parameter DATA_WIDTH		= 256;
parameter ID_WIDTH		= 4;
parameter TL_SIZE_WIDTH	= 4;
parameter TL_SINK_WIDTH	= 1;
parameter TL_SOURCE_WIDTH	= 3;
parameter TL_A_USER_WIDTH	= 8;
parameter TL_D_USER_WIDTH	= 8;
parameter TL_OUTSTANDING	= 8;
parameter TL_CHANNEL_NUM	= 4;
parameter ASYNC		= 0;
parameter SYNC_STAGE		= 3;
parameter ASYNC_DEPTH		= 8;
parameter AFIFO_DP_SYNC	= 1;
parameter RAR_SUPPORT		= 0;
parameter DEVICE_REGION0_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION0_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION1_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION1_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION2_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION2_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION3_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION3_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION4_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION4_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION5_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION5_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION6_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION6_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION7_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION7_MASK = 64'h00000000_00000000;

localparam PRODUCT_ID = 32'h00115050;
localparam OUT_IDX_WIDTH	= $clog2(TL_OUTSTANDING);
localparam CH_IDX_WIDTH		= $clog2(TL_CHANNEL_NUM);
localparam HR_IDX_WIDTH		= ((OUT_IDX_WIDTH + CH_IDX_WIDTH) == 0) ?  1 : (OUT_IDX_WIDTH + CH_IDX_WIDTH);
localparam HR_NUM		= 2**(OUT_IDX_WIDTH + CH_IDX_WIDTH);
localparam AX_FUNC_BITS		= 4;

input                               clk;
input                               resetn;
input                               aclk;
input            [(ADDR_WIDTH-1):0] araddr;
input                         [1:0] arburst;
input                         [3:0] arcache;
input                               aresetn;
input              [(ID_WIDTH-1):0] arid;
input                         [7:0] arlen;
input                               arlock;
input                         [2:0] arprot;
output                              arready;
input                         [2:0] arsize;
input                               arvalid;
input            [(ADDR_WIDTH-1):0] awaddr;
input                         [1:0] awburst;
input                         [3:0] awcache;
input              [(ID_WIDTH-1):0] awid;
input                         [7:0] awlen;
input                               awlock;
input                         [2:0] awprot;
output                              awready;
input                         [2:0] awsize;
input                               awvalid;
output             [(ID_WIDTH-1):0] bid;
input                               bready;
output                        [1:0] bresp;
output                              bvalid;
input                               clk_en;
output           [(DATA_WIDTH-1):0] rdata;
output             [(ID_WIDTH-1):0] rid;
output                              rlast;
input                               rready;
output                        [1:0] rresp;
output                              rvalid;
input            [(DATA_WIDTH-1):0] wdata;
input                               wlast;
output                              wready;
input        [((DATA_WIDTH/8)-1):0] wstrb;
input                               wvalid;
output           [(ADDR_WIDTH-1):0] tluh_0_a_address;
output                              tluh_0_a_corrupt;
output           [(DATA_WIDTH-1):0] tluh_0_a_data;
output       [((DATA_WIDTH/8)-1):0] tluh_0_a_mask;
output                        [2:0] tluh_0_a_opcode;
output                        [2:0] tluh_0_a_param;
input                               tluh_0_a_ready;
output        [(TL_SIZE_WIDTH-1):0] tluh_0_a_size;
output      [(TL_SOURCE_WIDTH-1):0] tluh_0_a_source;
output      [(TL_A_USER_WIDTH-1):0] tluh_0_a_user;
output                              tluh_0_a_valid;
input                               tluh_0_d_corrupt;
input            [(DATA_WIDTH-1):0] tluh_0_d_data;
input                               tluh_0_d_denied;
input                         [2:0] tluh_0_d_opcode;
input                         [1:0] tluh_0_d_param;    // UNUSED
output                              tluh_0_d_ready;
input         [(TL_SINK_WIDTH-1):0] tluh_0_d_sink;     // UNUSED
input         [(TL_SIZE_WIDTH-1):0] tluh_0_d_size;
input       [(TL_SOURCE_WIDTH-1):0] tluh_0_d_source;
input       [(TL_D_USER_WIDTH-1):0] tluh_0_d_user;
input                               tluh_0_d_valid;
output           [(ADDR_WIDTH-1):0] tluh_1_a_address;
output                              tluh_1_a_corrupt;
output           [(DATA_WIDTH-1):0] tluh_1_a_data;
output       [((DATA_WIDTH/8)-1):0] tluh_1_a_mask;
output                        [2:0] tluh_1_a_opcode;
output                        [2:0] tluh_1_a_param;
input                               tluh_1_a_ready;
output        [(TL_SIZE_WIDTH-1):0] tluh_1_a_size;
output      [(TL_SOURCE_WIDTH-1):0] tluh_1_a_source;
output      [(TL_A_USER_WIDTH-1):0] tluh_1_a_user;
output                              tluh_1_a_valid;
input                               tluh_1_d_corrupt;
input            [(DATA_WIDTH-1):0] tluh_1_d_data;
input                               tluh_1_d_denied;
input                         [2:0] tluh_1_d_opcode;
input                         [1:0] tluh_1_d_param;    // UNUSED
output                              tluh_1_d_ready;
input         [(TL_SINK_WIDTH-1):0] tluh_1_d_sink;     // UNUSED
input         [(TL_SIZE_WIDTH-1):0] tluh_1_d_size;
input       [(TL_SOURCE_WIDTH-1):0] tluh_1_d_source;
input       [(TL_D_USER_WIDTH-1):0] tluh_1_d_user;
input                               tluh_1_d_valid;
output           [(ADDR_WIDTH-1):0] tluh_2_a_address;
output                              tluh_2_a_corrupt;
output           [(DATA_WIDTH-1):0] tluh_2_a_data;
output       [((DATA_WIDTH/8)-1):0] tluh_2_a_mask;
output                        [2:0] tluh_2_a_opcode;
output                        [2:0] tluh_2_a_param;
input                               tluh_2_a_ready;
output        [(TL_SIZE_WIDTH-1):0] tluh_2_a_size;
output      [(TL_SOURCE_WIDTH-1):0] tluh_2_a_source;
output      [(TL_A_USER_WIDTH-1):0] tluh_2_a_user;
output                              tluh_2_a_valid;
input                               tluh_2_d_corrupt;
input            [(DATA_WIDTH-1):0] tluh_2_d_data;
input                               tluh_2_d_denied;
input                         [2:0] tluh_2_d_opcode;
input                         [1:0] tluh_2_d_param;    // UNUSED
output                              tluh_2_d_ready;
input         [(TL_SINK_WIDTH-1):0] tluh_2_d_sink;     // UNUSED
input         [(TL_SIZE_WIDTH-1):0] tluh_2_d_size;
input       [(TL_SOURCE_WIDTH-1):0] tluh_2_d_source;
input       [(TL_D_USER_WIDTH-1):0] tluh_2_d_user;
input                               tluh_2_d_valid;
output           [(ADDR_WIDTH-1):0] tluh_3_a_address;
output                              tluh_3_a_corrupt;
output           [(DATA_WIDTH-1):0] tluh_3_a_data;
output       [((DATA_WIDTH/8)-1):0] tluh_3_a_mask;
output                        [2:0] tluh_3_a_opcode;
output                        [2:0] tluh_3_a_param;
input                               tluh_3_a_ready;
output        [(TL_SIZE_WIDTH-1):0] tluh_3_a_size;
output      [(TL_SOURCE_WIDTH-1):0] tluh_3_a_source;
output      [(TL_A_USER_WIDTH-1):0] tluh_3_a_user;
output                              tluh_3_a_valid;
input                               tluh_3_d_corrupt;
input            [(DATA_WIDTH-1):0] tluh_3_d_data;
input                               tluh_3_d_denied;
input                         [2:0] tluh_3_d_opcode;
input                         [1:0] tluh_3_d_param;    // UNUSED
output                              tluh_3_d_ready;
input         [(TL_SINK_WIDTH-1):0] tluh_3_d_sink;     // UNUSED
input         [(TL_SIZE_WIDTH-1):0] tluh_3_d_size;
input       [(TL_SOURCE_WIDTH-1):0] tluh_3_d_source;
input       [(TL_D_USER_WIDTH-1):0] tluh_3_d_user;
input                               tluh_3_d_valid;

wire                                                 arready_buf;
wire                                                 awready_buf;
wire                              [(ADDR_WIDTH-1):0] axaddr_arb;
wire                                           [5:0] axaddrlast_arb;
wire                                           [1:0] axburst_arb;
wire                                           [5:0] axburstlen_arb;
wire                                           [3:0] axcache_arb;
wire                            [(AX_FUNC_BITS-1):0] axfunc_arb;
wire                            [(HR_IDX_WIDTH-1):0] axid_arb;
wire                                           [7:0] axlen_arb;
wire                                           [2:0] axprot_arb;
wire                                           [2:0] axsize_arb;
wire                                                 axvalid_arb;
wire                                [(ID_WIDTH-1):0] bid_buf;
wire                                                 bready_arb;
wire                                           [1:0] bresp_buf;
wire                                                 bvalid_buf;
wire                              [(DATA_WIDTH-1):0] rdata_buf;
wire                                [(ID_WIDTH-1):0] rid_buf;
wire                                                 rlast_buf;
wire                                                 rready_arb;
wire                                           [1:0] rresp_buf;
wire                                                 rvalid_buf;
wire                              [(DATA_WIDTH-1):0] wdata_arb;
wire                            [(HR_IDX_WIDTH-1):0] wid_arb;
wire                                                 wlast_arb;
wire                                                 wready_buf;
wire                          [((DATA_WIDTH/8)-1):0] wstrb_arb;
wire                                                 wvalid_arb;
wire                              [(ADDR_WIDTH-1):0] araddr_buf;
wire                                           [1:0] arburst_buf;
wire                                           [3:0] arcache_buf;
wire                                [(ID_WIDTH-1):0] arid_buf;
wire                                           [7:0] arlen_buf;
wire                                           [2:0] arprot_buf;
wire                                           [2:0] arsize_buf;
wire                                                 arvalid_buf;
wire                              [(ADDR_WIDTH-1):0] awaddr_buf;
wire                                           [1:0] awburst_buf;
wire                                           [3:0] awcache_buf;
wire                                [(ID_WIDTH-1):0] awid_buf;
wire                                           [7:0] awlen_buf;
wire                                           [2:0] awprot_buf;
wire                                           [2:0] awsize_buf;
wire                                                 awvalid_buf;
wire                                                 bready_buf;
wire                                                 rready_buf;
wire                              [(DATA_WIDTH-1):0] wdata_buf;
wire                                                 wlast_buf;
wire                          [((DATA_WIDTH/8)-1):0] wstrb_buf;
wire                                                 wvalid_buf;
wire             [((TL_CHANNEL_NUM*ADDR_WIDTH)-1):0] a_address;
wire                          [(TL_CHANNEL_NUM-1):0] a_corrupt;
wire             [((TL_CHANNEL_NUM*DATA_WIDTH)-1):0] a_data;
wire         [((TL_CHANNEL_NUM*(DATA_WIDTH/8))-1):0] a_mask;
wire                      [((TL_CHANNEL_NUM*3)-1):0] a_opcode;
wire                      [((TL_CHANNEL_NUM*3)-1):0] a_param;
wire                      [((TL_CHANNEL_NUM*3)-1):0] a_size;
wire        [((TL_CHANNEL_NUM*TL_SOURCE_WIDTH)-1):0] a_source;
wire                      [((TL_CHANNEL_NUM*7)-1):0] a_user;
wire                          [(TL_CHANNEL_NUM-1):0] a_valid;
wire                                                 axready_arb;
wire                            [(HR_IDX_WIDTH-1):0] bid_arb;
wire                                           [1:0] bresp_arb;
wire                                                 bvalid_arb;
wire                          [(TL_CHANNEL_NUM-1):0] d_ready;
wire                              [(DATA_WIDTH-1):0] rdata_arb;
wire                            [(HR_IDX_WIDTH-1):0] rid_arb;
wire                                                 rlast_arb;
wire                                           [1:0] rresp_arb;
wire                                                 rvalid_arb;
wire                                                 wready_arb;
wire                          [(TL_CHANNEL_NUM-1):0] a_ready;
wire                          [(TL_CHANNEL_NUM-1):0] d_corrupt;
wire             [((TL_CHANNEL_NUM*DATA_WIDTH)-1):0] d_data;
wire                          [(TL_CHANNEL_NUM-1):0] d_denied;
wire                      [((TL_CHANNEL_NUM*3)-1):0] d_opcode;
wire        [((TL_CHANNEL_NUM*TL_SOURCE_WIDTH)-1):0] d_source;
wire                      [((TL_CHANNEL_NUM*2)-1):0] d_user;
wire                          [(TL_CHANNEL_NUM-1):0] d_valid;

wire	nds_unused_awlock = awlock;
wire	nds_unused_arlock = arlock;

atcaxi2tluh500_axif #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.AFIFO_DP_SYNC   (AFIFO_DP_SYNC   ),
	.ASYNC           (ASYNC           ),
	.ASYNC_DEPTH     (ASYNC_DEPTH     ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.RAR_SUPPORT     (RAR_SUPPORT     ),
	.SYNC_STAGE      (SYNC_STAGE      )
) u_axif (
	.aclk       (aclk       ), // (u_axif) <= ()
	.aresetn    (aresetn    ), // (u_axif) <= ()
	.clk        (clk        ), // (u_axiarb,u_axif,u_hr,u_tlif) <= ()
	.clk_en     (clk_en     ), // (u_axif) <= ()
	.resetn     (resetn     ), // (u_axiarb,u_axif,u_hr,u_tlif) <= ()
	.awready    (awready    ), // (u_axif) => ()
	.awvalid    (awvalid    ), // (u_axif) <= ()
	.awid       (awid       ), // (u_axif) <= ()
	.awaddr     (awaddr     ), // (u_axif) <= ()
	.awlen      (awlen      ), // (u_axif) <= ()
	.awsize     (awsize     ), // (u_axif) <= ()
	.awburst    (awburst    ), // (u_axif) <= ()
	.awcache    (awcache    ), // (u_axif) <= ()
	.awprot     (awprot     ), // (u_axif) <= ()
	.wready     (wready     ), // (u_axif) => ()
	.wvalid     (wvalid     ), // (u_axif) <= ()
	.wdata      (wdata      ), // (u_axif) <= ()
	.wstrb      (wstrb      ), // (u_axif) <= ()
	.wlast      (wlast      ), // (u_axif) <= ()
	.bready     (bready     ), // (u_axif) <= ()
	.bvalid     (bvalid     ), // (u_axif) => ()
	.bid        (bid        ), // (u_axif) => ()
	.bresp      (bresp      ), // (u_axif) => ()
	.arready    (arready    ), // (u_axif) => ()
	.arvalid    (arvalid    ), // (u_axif) <= ()
	.arid       (arid       ), // (u_axif) <= ()
	.araddr     (araddr     ), // (u_axif) <= ()
	.arlen      (arlen      ), // (u_axif) <= ()
	.arsize     (arsize     ), // (u_axif) <= ()
	.arburst    (arburst    ), // (u_axif) <= ()
	.arcache    (arcache    ), // (u_axif) <= ()
	.arprot     (arprot     ), // (u_axif) <= ()
	.rready     (rready     ), // (u_axif) <= ()
	.rvalid     (rvalid     ), // (u_axif) => ()
	.rid        (rid        ), // (u_axif) => ()
	.rdata      (rdata      ), // (u_axif) => ()
	.rresp      (rresp      ), // (u_axif) => ()
	.rlast      (rlast      ), // (u_axif) => ()
	.awready_buf(awready_buf), // (u_axif) <= (u_axiarb)
	.awvalid_buf(awvalid_buf), // (u_axif) => (u_axiarb)
	.awid_buf   (awid_buf   ), // (u_axif) => (u_axiarb)
	.awaddr_buf (awaddr_buf ), // (u_axif) => (u_axiarb)
	.awlen_buf  (awlen_buf  ), // (u_axif) => (u_axiarb)
	.awsize_buf (awsize_buf ), // (u_axif) => (u_axiarb)
	.awburst_buf(awburst_buf), // (u_axif) => (u_axiarb)
	.awcache_buf(awcache_buf), // (u_axif) => (u_axiarb)
	.awprot_buf (awprot_buf ), // (u_axif) => (u_axiarb)
	.wready_buf (wready_buf ), // (u_axif) <= (u_axiarb)
	.wvalid_buf (wvalid_buf ), // (u_axif) => (u_axiarb)
	.wdata_buf  (wdata_buf  ), // (u_axif) => (u_axiarb)
	.wstrb_buf  (wstrb_buf  ), // (u_axif) => (u_axiarb)
	.wlast_buf  (wlast_buf  ), // (u_axif) => (u_axiarb)
	.bready_buf (bready_buf ), // (u_axif) => (u_axiarb)
	.bvalid_buf (bvalid_buf ), // (u_axif) <= (u_axiarb)
	.bid_buf    (bid_buf    ), // (u_axif) <= (u_axiarb)
	.bresp_buf  (bresp_buf  ), // (u_axif) <= (u_axiarb)
	.arready_buf(arready_buf), // (u_axif) <= (u_axiarb)
	.arvalid_buf(arvalid_buf), // (u_axif) => (u_axiarb)
	.arid_buf   (arid_buf   ), // (u_axif) => (u_axiarb)
	.araddr_buf (araddr_buf ), // (u_axif) => (u_axiarb)
	.arlen_buf  (arlen_buf  ), // (u_axif) => (u_axiarb)
	.arsize_buf (arsize_buf ), // (u_axif) => (u_axiarb)
	.arburst_buf(arburst_buf), // (u_axif) => (u_axiarb)
	.arcache_buf(arcache_buf), // (u_axif) => (u_axiarb)
	.arprot_buf (arprot_buf ), // (u_axif) => (u_axiarb)
	.rready_buf (rready_buf ), // (u_axif) => (u_axiarb)
	.rvalid_buf (rvalid_buf ), // (u_axif) <= (u_axiarb)
	.rid_buf    (rid_buf    ), // (u_axif) <= (u_axiarb)
	.rdata_buf  (rdata_buf  ), // (u_axif) <= (u_axiarb)
	.rresp_buf  (rresp_buf  ), // (u_axif) <= (u_axiarb)
	.rlast_buf  (rlast_buf  )  // (u_axif) <= (u_axiarb)
); // end of u_axif

atcaxi2tluh500_axiarb #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.AX_FUNC_BITS    (AX_FUNC_BITS    ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.DEVICE_REGION0_BASE(DEVICE_REGION0_BASE),
	.DEVICE_REGION0_MASK(DEVICE_REGION0_MASK),
	.DEVICE_REGION1_BASE(DEVICE_REGION1_BASE),
	.DEVICE_REGION1_MASK(DEVICE_REGION1_MASK),
	.DEVICE_REGION2_BASE(DEVICE_REGION2_BASE),
	.DEVICE_REGION2_MASK(DEVICE_REGION2_MASK),
	.DEVICE_REGION3_BASE(DEVICE_REGION3_BASE),
	.DEVICE_REGION3_MASK(DEVICE_REGION3_MASK),
	.DEVICE_REGION4_BASE(DEVICE_REGION4_BASE),
	.DEVICE_REGION4_MASK(DEVICE_REGION4_MASK),
	.DEVICE_REGION5_BASE(DEVICE_REGION5_BASE),
	.DEVICE_REGION5_MASK(DEVICE_REGION5_MASK),
	.DEVICE_REGION6_BASE(DEVICE_REGION6_BASE),
	.DEVICE_REGION6_MASK(DEVICE_REGION6_MASK),
	.DEVICE_REGION7_BASE(DEVICE_REGION7_BASE),
	.DEVICE_REGION7_MASK(DEVICE_REGION7_MASK),
	.ID_WIDTH        (ID_WIDTH        ),
	.RAR_SUPPORT     (RAR_SUPPORT     ),
	.TL_CHANNEL_NUM  (TL_CHANNEL_NUM  ),
	.TL_OUTSTANDING  (TL_OUTSTANDING  )
) u_axiarb (
	.clk           (clk           ), // (u_axiarb,u_axif,u_hr,u_tlif) <= ()
	.resetn        (resetn        ), // (u_axiarb,u_axif,u_hr,u_tlif) <= ()
	.awready_buf   (awready_buf   ), // (u_axiarb) => (u_axif)
	.awvalid_buf   (awvalid_buf   ), // (u_axiarb) <= (u_axif)
	.awid_buf      (awid_buf      ), // (u_axiarb) <= (u_axif)
	.awaddr_buf    (awaddr_buf    ), // (u_axiarb) <= (u_axif)
	.awlen_buf     (awlen_buf     ), // (u_axiarb) <= (u_axif)
	.awsize_buf    (awsize_buf    ), // (u_axiarb) <= (u_axif)
	.awburst_buf   (awburst_buf   ), // (u_axiarb) <= (u_axif)
	.awcache_buf   (awcache_buf   ), // (u_axiarb) <= (u_axif)
	.awprot_buf    (awprot_buf    ), // (u_axiarb) <= (u_axif)
	.wready_buf    (wready_buf    ), // (u_axiarb) => (u_axif)
	.wvalid_buf    (wvalid_buf    ), // (u_axiarb) <= (u_axif)
	.wdata_buf     (wdata_buf     ), // (u_axiarb) <= (u_axif)
	.wstrb_buf     (wstrb_buf     ), // (u_axiarb) <= (u_axif)
	.wlast_buf     (wlast_buf     ), // (u_axiarb) <= (u_axif)
	.bready_buf    (bready_buf    ), // (u_axiarb) <= (u_axif)
	.bvalid_buf    (bvalid_buf    ), // (u_axiarb) => (u_axif)
	.bid_buf       (bid_buf       ), // (u_axiarb) => (u_axif)
	.bresp_buf     (bresp_buf     ), // (u_axiarb) => (u_axif)
	.arready_buf   (arready_buf   ), // (u_axiarb) => (u_axif)
	.arvalid_buf   (arvalid_buf   ), // (u_axiarb) <= (u_axif)
	.arid_buf      (arid_buf      ), // (u_axiarb) <= (u_axif)
	.araddr_buf    (araddr_buf    ), // (u_axiarb) <= (u_axif)
	.arlen_buf     (arlen_buf     ), // (u_axiarb) <= (u_axif)
	.arsize_buf    (arsize_buf    ), // (u_axiarb) <= (u_axif)
	.arburst_buf   (arburst_buf   ), // (u_axiarb) <= (u_axif)
	.arcache_buf   (arcache_buf   ), // (u_axiarb) <= (u_axif)
	.arprot_buf    (arprot_buf    ), // (u_axiarb) <= (u_axif)
	.rready_buf    (rready_buf    ), // (u_axiarb) <= (u_axif)
	.rvalid_buf    (rvalid_buf    ), // (u_axiarb) => (u_axif)
	.rid_buf       (rid_buf       ), // (u_axiarb) => (u_axif)
	.rdata_buf     (rdata_buf     ), // (u_axiarb) => (u_axif)
	.rresp_buf     (rresp_buf     ), // (u_axiarb) => (u_axif)
	.rlast_buf     (rlast_buf     ), // (u_axiarb) => (u_axif)
	.axvalid_arb   (axvalid_arb   ), // (u_axiarb) => (u_hr)
	.axready_arb   (axready_arb   ), // (u_axiarb) <= (u_hr)
	.axid_arb      (axid_arb      ), // (u_axiarb) => (u_hr)
	.axaddr_arb    (axaddr_arb    ), // (u_axiarb) => (u_hr)
	.axlen_arb     (axlen_arb     ), // (u_axiarb) => (u_hr)
	.axsize_arb    (axsize_arb    ), // (u_axiarb) => (u_hr)
	.axburst_arb   (axburst_arb   ), // (u_axiarb) => (u_hr)
	.axcache_arb   (axcache_arb   ), // (u_axiarb) => (u_hr)
	.axprot_arb    (axprot_arb    ), // (u_axiarb) => (u_hr)
	.axfunc_arb    (axfunc_arb    ), // (u_axiarb) => (u_hr)
	.axaddrlast_arb(axaddrlast_arb), // (u_axiarb) => (u_hr)
	.axburstlen_arb(axburstlen_arb), // (u_axiarb) => (u_hr)
	.wvalid_arb    (wvalid_arb    ), // (u_axiarb) => (u_hr)
	.wready_arb    (wready_arb    ), // (u_axiarb) <= (u_hr)
	.wid_arb       (wid_arb       ), // (u_axiarb) => (u_hr)
	.wdata_arb     (wdata_arb     ), // (u_axiarb) => (u_hr)
	.wstrb_arb     (wstrb_arb     ), // (u_axiarb) => (u_hr)
	.wlast_arb     (wlast_arb     ), // (u_axiarb) => (u_hr)
	.bvalid_arb    (bvalid_arb    ), // (u_axiarb) <= (u_hr)
	.bready_arb    (bready_arb    ), // (u_axiarb) => (u_hr)
	.bid_arb       (bid_arb       ), // (u_axiarb) <= (u_hr)
	.bresp_arb     (bresp_arb     ), // (u_axiarb) <= (u_hr)
	.rvalid_arb    (rvalid_arb    ), // (u_axiarb) <= (u_hr)
	.rready_arb    (rready_arb    ), // (u_axiarb) => (u_hr)
	.rid_arb       (rid_arb       ), // (u_axiarb) <= (u_hr)
	.rresp_arb     (rresp_arb     ), // (u_axiarb) <= (u_hr)
	.rdata_arb     (rdata_arb     ), // (u_axiarb) <= (u_hr)
	.rlast_arb     (rlast_arb     )  // (u_axiarb) <= (u_hr)
); // end of u_axiarb

atcaxi2tluh500_hr #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.AX_FUNC_BITS    (AX_FUNC_BITS    ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.RAR_SUPPORT     (RAR_SUPPORT     ),
	.TL_A_USER_WIDTH (TL_A_USER_WIDTH ),
	.TL_CHANNEL_NUM  (TL_CHANNEL_NUM  ),
	.TL_D_USER_WIDTH (TL_D_USER_WIDTH ),
	.TL_OUTSTANDING  (TL_OUTSTANDING  ),
	.TL_SIZE_WIDTH   (TL_SIZE_WIDTH   ),
	.TL_SOURCE_WIDTH (TL_SOURCE_WIDTH )
) u_hr (
	.clk           (clk           ), // (u_axiarb,u_axif,u_hr,u_tlif) <= ()
	.resetn        (resetn        ), // (u_axiarb,u_axif,u_hr,u_tlif) <= ()
	.axvalid_arb   (axvalid_arb   ), // (u_hr) <= (u_axiarb)
	.axready_arb   (axready_arb   ), // (u_hr) => (u_axiarb)
	.axid_arb      (axid_arb      ), // (u_hr) <= (u_axiarb)
	.axaddr_arb    (axaddr_arb    ), // (u_hr) <= (u_axiarb)
	.axlen_arb     (axlen_arb     ), // (u_hr) <= (u_axiarb)
	.axsize_arb    (axsize_arb    ), // (u_hr) <= (u_axiarb)
	.axburst_arb   (axburst_arb   ), // (u_hr) <= (u_axiarb)
	.axcache_arb   (axcache_arb   ), // (u_hr) <= (u_axiarb)
	.axprot_arb    (axprot_arb    ), // (u_hr) <= (u_axiarb)
	.axfunc_arb    (axfunc_arb    ), // (u_hr) <= (u_axiarb)
	.axaddrlast_arb(axaddrlast_arb), // (u_hr) <= (u_axiarb)
	.axburstlen_arb(axburstlen_arb), // (u_hr) <= (u_axiarb)
	.wvalid_arb    (wvalid_arb    ), // (u_hr) <= (u_axiarb)
	.wready_arb    (wready_arb    ), // (u_hr) => (u_axiarb)
	.wid_arb       (wid_arb       ), // (u_hr) <= (u_axiarb)
	.wdata_arb     (wdata_arb     ), // (u_hr) <= (u_axiarb)
	.wstrb_arb     (wstrb_arb     ), // (u_hr) <= (u_axiarb)
	.wlast_arb     (wlast_arb     ), // (u_hr) <= (u_axiarb)
	.bvalid_arb    (bvalid_arb    ), // (u_hr) => (u_axiarb)
	.bready_arb    (bready_arb    ), // (u_hr) <= (u_axiarb)
	.bid_arb       (bid_arb       ), // (u_hr) => (u_axiarb)
	.bresp_arb     (bresp_arb     ), // (u_hr) => (u_axiarb)
	.rvalid_arb    (rvalid_arb    ), // (u_hr) => (u_axiarb)
	.rready_arb    (rready_arb    ), // (u_hr) <= (u_axiarb)
	.rid_arb       (rid_arb       ), // (u_hr) => (u_axiarb)
	.rresp_arb     (rresp_arb     ), // (u_hr) => (u_axiarb)
	.rdata_arb     (rdata_arb     ), // (u_hr) => (u_axiarb)
	.rlast_arb     (rlast_arb     ), // (u_hr) => (u_axiarb)
	.a_valid       (a_valid       ), // (u_hr) => (u_tlif)
	.a_ready       (a_ready       ), // (u_hr) <= (u_tlif)
	.a_opcode      (a_opcode      ), // (u_hr) => (u_tlif)
	.a_size        (a_size        ), // (u_hr) => (u_tlif)
	.a_source      (a_source      ), // (u_hr) => (u_tlif)
	.a_address     (a_address     ), // (u_hr) => (u_tlif)
	.a_mask        (a_mask        ), // (u_hr) => (u_tlif)
	.a_data        (a_data        ), // (u_hr) => (u_tlif)
	.a_user        (a_user        ), // (u_hr) => (u_tlif)
	.a_corrupt     (a_corrupt     ), // (u_hr) => (u_tlif)
	.a_param       (a_param       ), // (u_hr) => (u_tlif)
	.d_valid       (d_valid       ), // (u_hr) <= (u_tlif)
	.d_ready       (d_ready       ), // (u_hr) => (u_tlif)
	.d_opcode      (d_opcode      ), // (u_hr) <= (u_tlif)
	.d_source      (d_source      ), // (u_hr) <= (u_tlif)
	.d_denied      (d_denied      ), // (u_hr) <= (u_tlif)
	.d_corrupt     (d_corrupt     ), // (u_hr) <= (u_tlif)
	.d_data        (d_data        ), // (u_hr) <= (u_tlif)
	.d_user        (d_user        )  // (u_hr) <= (u_tlif)
); // end of u_hr

atcaxi2tluh500_tlif #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.RAR_SUPPORT     (RAR_SUPPORT     ),
	.TL_A_USER_WIDTH (TL_A_USER_WIDTH ),
	.TL_CHANNEL_NUM  (TL_CHANNEL_NUM  ),
	.TL_D_USER_WIDTH (TL_D_USER_WIDTH ),
	.TL_OUTSTANDING  (TL_OUTSTANDING  ),
	.TL_SINK_WIDTH   (TL_SINK_WIDTH   ),
	.TL_SIZE_WIDTH   (TL_SIZE_WIDTH   ),
	.TL_SOURCE_WIDTH (TL_SOURCE_WIDTH )
) u_tlif (
	.clk             (clk             ), // (u_axiarb,u_axif,u_hr,u_tlif) <= ()
	.resetn          (resetn          ), // (u_axiarb,u_axif,u_hr,u_tlif) <= ()
	.a_valid         (a_valid         ), // (u_tlif) <= (u_hr)
	.a_ready         (a_ready         ), // (u_tlif) => (u_hr)
	.a_opcode        (a_opcode        ), // (u_tlif) <= (u_hr)
	.a_size          (a_size          ), // (u_tlif) <= (u_hr)
	.a_source        (a_source        ), // (u_tlif) <= (u_hr)
	.a_address       (a_address       ), // (u_tlif) <= (u_hr)
	.a_mask          (a_mask          ), // (u_tlif) <= (u_hr)
	.a_data          (a_data          ), // (u_tlif) <= (u_hr)
	.a_user          (a_user          ), // (u_tlif) <= (u_hr)
	.a_corrupt       (a_corrupt       ), // (u_tlif) <= (u_hr)
	.a_param         (a_param         ), // (u_tlif) <= (u_hr)
	.d_valid         (d_valid         ), // (u_tlif) => (u_hr)
	.d_ready         (d_ready         ), // (u_tlif) <= (u_hr)
	.d_opcode        (d_opcode        ), // (u_tlif) => (u_hr)
	.d_source        (d_source        ), // (u_tlif) => (u_hr)
	.d_denied        (d_denied        ), // (u_tlif) => (u_hr)
	.d_corrupt       (d_corrupt       ), // (u_tlif) => (u_hr)
	.d_data          (d_data          ), // (u_tlif) => (u_hr)
	.d_user          (d_user          ), // (u_tlif) => (u_hr)
	.tluh_0_a_valid  (tluh_0_a_valid  ), // (u_tlif) => ()
	.tluh_0_a_ready  (tluh_0_a_ready  ), // (u_tlif) <= ()
	.tluh_0_a_opcode (tluh_0_a_opcode ), // (u_tlif) => ()
	.tluh_0_a_size   (tluh_0_a_size   ), // (u_tlif) => ()
	.tluh_0_a_source (tluh_0_a_source ), // (u_tlif) => ()
	.tluh_0_a_address(tluh_0_a_address), // (u_tlif) => ()
	.tluh_0_a_mask   (tluh_0_a_mask   ), // (u_tlif) => ()
	.tluh_0_a_data   (tluh_0_a_data   ), // (u_tlif) => ()
	.tluh_0_a_user   (tluh_0_a_user   ), // (u_tlif) => ()
	.tluh_0_a_corrupt(tluh_0_a_corrupt), // (u_tlif) => ()
	.tluh_0_a_param  (tluh_0_a_param  ), // (u_tlif) => ()
	.tluh_0_d_valid  (tluh_0_d_valid  ), // (u_tlif) <= ()
	.tluh_0_d_ready  (tluh_0_d_ready  ), // (u_tlif) => ()
	.tluh_0_d_opcode (tluh_0_d_opcode ), // (u_tlif) <= ()
	.tluh_0_d_size   (tluh_0_d_size   ), // (u_tlif) <= ()
	.tluh_0_d_source (tluh_0_d_source ), // (u_tlif) <= ()
	.tluh_0_d_denied (tluh_0_d_denied ), // (u_tlif) <= ()
	.tluh_0_d_corrupt(tluh_0_d_corrupt), // (u_tlif) <= ()
	.tluh_0_d_data   (tluh_0_d_data   ), // (u_tlif) <= ()
	.tluh_0_d_user   (tluh_0_d_user   ), // (u_tlif) <= ()
	.tluh_0_d_param  (tluh_0_d_param  ), // (u_tlif) <= ()
	.tluh_0_d_sink   (tluh_0_d_sink   ), // (u_tlif) <= ()
	.tluh_1_a_valid  (tluh_1_a_valid  ), // (u_tlif) => ()
	.tluh_1_a_ready  (tluh_1_a_ready  ), // (u_tlif) <= ()
	.tluh_1_a_opcode (tluh_1_a_opcode ), // (u_tlif) => ()
	.tluh_1_a_size   (tluh_1_a_size   ), // (u_tlif) => ()
	.tluh_1_a_source (tluh_1_a_source ), // (u_tlif) => ()
	.tluh_1_a_address(tluh_1_a_address), // (u_tlif) => ()
	.tluh_1_a_mask   (tluh_1_a_mask   ), // (u_tlif) => ()
	.tluh_1_a_data   (tluh_1_a_data   ), // (u_tlif) => ()
	.tluh_1_a_user   (tluh_1_a_user   ), // (u_tlif) => ()
	.tluh_1_a_corrupt(tluh_1_a_corrupt), // (u_tlif) => ()
	.tluh_1_a_param  (tluh_1_a_param  ), // (u_tlif) => ()
	.tluh_1_d_valid  (tluh_1_d_valid  ), // (u_tlif) <= ()
	.tluh_1_d_ready  (tluh_1_d_ready  ), // (u_tlif) => ()
	.tluh_1_d_opcode (tluh_1_d_opcode ), // (u_tlif) <= ()
	.tluh_1_d_size   (tluh_1_d_size   ), // (u_tlif) <= ()
	.tluh_1_d_source (tluh_1_d_source ), // (u_tlif) <= ()
	.tluh_1_d_denied (tluh_1_d_denied ), // (u_tlif) <= ()
	.tluh_1_d_corrupt(tluh_1_d_corrupt), // (u_tlif) <= ()
	.tluh_1_d_data   (tluh_1_d_data   ), // (u_tlif) <= ()
	.tluh_1_d_user   (tluh_1_d_user   ), // (u_tlif) <= ()
	.tluh_1_d_param  (tluh_1_d_param  ), // (u_tlif) <= ()
	.tluh_1_d_sink   (tluh_1_d_sink   ), // (u_tlif) <= ()
	.tluh_2_a_valid  (tluh_2_a_valid  ), // (u_tlif) => ()
	.tluh_2_a_ready  (tluh_2_a_ready  ), // (u_tlif) <= ()
	.tluh_2_a_opcode (tluh_2_a_opcode ), // (u_tlif) => ()
	.tluh_2_a_size   (tluh_2_a_size   ), // (u_tlif) => ()
	.tluh_2_a_source (tluh_2_a_source ), // (u_tlif) => ()
	.tluh_2_a_address(tluh_2_a_address), // (u_tlif) => ()
	.tluh_2_a_mask   (tluh_2_a_mask   ), // (u_tlif) => ()
	.tluh_2_a_data   (tluh_2_a_data   ), // (u_tlif) => ()
	.tluh_2_a_user   (tluh_2_a_user   ), // (u_tlif) => ()
	.tluh_2_a_corrupt(tluh_2_a_corrupt), // (u_tlif) => ()
	.tluh_2_a_param  (tluh_2_a_param  ), // (u_tlif) => ()
	.tluh_2_d_valid  (tluh_2_d_valid  ), // (u_tlif) <= ()
	.tluh_2_d_ready  (tluh_2_d_ready  ), // (u_tlif) => ()
	.tluh_2_d_opcode (tluh_2_d_opcode ), // (u_tlif) <= ()
	.tluh_2_d_size   (tluh_2_d_size   ), // (u_tlif) <= ()
	.tluh_2_d_source (tluh_2_d_source ), // (u_tlif) <= ()
	.tluh_2_d_denied (tluh_2_d_denied ), // (u_tlif) <= ()
	.tluh_2_d_corrupt(tluh_2_d_corrupt), // (u_tlif) <= ()
	.tluh_2_d_data   (tluh_2_d_data   ), // (u_tlif) <= ()
	.tluh_2_d_user   (tluh_2_d_user   ), // (u_tlif) <= ()
	.tluh_2_d_param  (tluh_2_d_param  ), // (u_tlif) <= ()
	.tluh_2_d_sink   (tluh_2_d_sink   ), // (u_tlif) <= ()
	.tluh_3_a_valid  (tluh_3_a_valid  ), // (u_tlif) => ()
	.tluh_3_a_ready  (tluh_3_a_ready  ), // (u_tlif) <= ()
	.tluh_3_a_opcode (tluh_3_a_opcode ), // (u_tlif) => ()
	.tluh_3_a_size   (tluh_3_a_size   ), // (u_tlif) => ()
	.tluh_3_a_source (tluh_3_a_source ), // (u_tlif) => ()
	.tluh_3_a_address(tluh_3_a_address), // (u_tlif) => ()
	.tluh_3_a_mask   (tluh_3_a_mask   ), // (u_tlif) => ()
	.tluh_3_a_data   (tluh_3_a_data   ), // (u_tlif) => ()
	.tluh_3_a_user   (tluh_3_a_user   ), // (u_tlif) => ()
	.tluh_3_a_corrupt(tluh_3_a_corrupt), // (u_tlif) => ()
	.tluh_3_a_param  (tluh_3_a_param  ), // (u_tlif) => ()
	.tluh_3_d_valid  (tluh_3_d_valid  ), // (u_tlif) <= ()
	.tluh_3_d_ready  (tluh_3_d_ready  ), // (u_tlif) => ()
	.tluh_3_d_opcode (tluh_3_d_opcode ), // (u_tlif) <= ()
	.tluh_3_d_size   (tluh_3_d_size   ), // (u_tlif) <= ()
	.tluh_3_d_source (tluh_3_d_source ), // (u_tlif) <= ()
	.tluh_3_d_denied (tluh_3_d_denied ), // (u_tlif) <= ()
	.tluh_3_d_corrupt(tluh_3_d_corrupt), // (u_tlif) <= ()
	.tluh_3_d_data   (tluh_3_d_data   ), // (u_tlif) <= ()
	.tluh_3_d_user   (tluh_3_d_user   ), // (u_tlif) <= ()
	.tluh_3_d_param  (tluh_3_d_param  ), // (u_tlif) <= ()
	.tluh_3_d_sink   (tluh_3_d_sink   )  // (u_tlif) <= ()
); // end of u_tlif

endmodule
// VPERL_GENERATED_END
