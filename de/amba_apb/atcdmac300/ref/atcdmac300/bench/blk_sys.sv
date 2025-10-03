`timescale 1ns/1ps
`include "xmr.vh"

`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

// Decide the AXI data size.
`ifdef ATCDMAC300_DATA_WIDTH_256
	`define DMA_DATA_WIDTH 256 
	`define DMA_WSTRB_WIDTH 32
	`define DMA_DATA_SIZE 5
`elsif ATCDMAC300_DATA_WIDTH_128
	`define DMA_DATA_WIDTH 128 
	`define DMA_WSTRB_WIDTH 16
	`define DMA_DATA_SIZE 4
`elsif ATCDMAC300_DATA_WIDTH_64
	`define DMA_DATA_WIDTH 64
	`define DMA_WSTRB_WIDTH 8
	`define DMA_DATA_SIZE 3
`elsif ATCDMAC300_DATA_WIDTH_32
	`define DMA_DATA_WIDTH 32
	`define DMA_WSTRB_WIDTH 4
	`define DMA_DATA_SIZE 2
`else
	// If ATCDMAC300_DATA_WIDTH_n isn't defined, 64 by default.
	`define ATCDMAC300_DATA_WIDTH_64
	`define DMA_DATA_WIDTH 64
	`define DMA_WSTRB_WIDTH 8
	`define DMA_DATA_SIZE 3
`endif

// Decide the addr width of axi masters
`ifndef ATCDMAC300_ADDR_WIDTH
	`define ATCDMAC300_ADDR_WIDTH 32
`endif

// Decide the addr width of axi masters
`ifndef NDS_MEM_ADDR_WIDTH
	`define NDS_MEM_ADDR_WIDTH 22
`endif

// Decide the channel number
`ifdef ATCDMAC300_CH_NUM_8
	`define DMA_CH_NUM 8 
`elsif ATCDMAC300_CH_NUM_7
	`define DMA_CH_NUM 7 
`elsif ATCDMAC300_CH_NUM_6
	`define DMA_CH_NUM 6 
`elsif ATCDMAC300_CH_NUM_5
	`define DMA_CH_NUM 5 
`elsif ATCDMAC300_CH_NUM_4
	`define DMA_CH_NUM 4 
`elsif ATCDMAC300_CH_NUM_3
	`define DMA_CH_NUM 3 
`elsif ATCDMAC300_CH_NUM_2
	`define DMA_CH_NUM 2 
`elsif ATCDMAC300_CH_NUM_1
	`define DMA_CH_NUM 1 
`else
	// If ATCDMAC300_CH_NUM_n isn't defined, 4 by default.
	`define ATCDMAC300_CH_NUM_4
	`define DMA_CH_NUM 4
`endif

// Decide the fifo depth
`ifdef ATCDMAC300_FIFO_DEPTH_32
	`define NDS_FIFO_DEPTH 32
`elsif ATCDMAC300_FIFO_DEPTH_16
	`define NDS_FIFO_DEPTH 16
`elsif ATCDMAC300_FIFO_DEPTH_8
	`define NDS_FIFO_DEPTH 8
`elsif ATCDMAC300_FIFO_DEPTH_4
	`define NDS_FIFO_DEPTH 4
`else
	// If ATCDMAC300_FIFO_DEPTH_n isn't defined, 8 by default.
	`define ATCDMAC300_FIFO_DEPTH_8
	`define NDS_FIFO_DEPTH 8
`endif

// Decide the dma request/acknowledge number
`ifndef ATCDMAC300_REQ_ACK_NUM
	`define ATCDMAC300_REQ_ACK_NUM 8
`endif

// Decide the error probability
`ifndef NDS_ERROR_PROBABILITY
	`define NDS_ERROR_PROBABILITY	10		// 10%
`endif

// VPERL_BEGIN
// 
// &MODULE("system");
//
// ### Configurable parameters ###
//
// &PARAM("ADDR_WIDTH = `ATCDMAC300_ADDR_WIDTH");
// &PARAM("ADDR_MSB = ADDR_WIDTH -1");
// &PARAM("DATA_SIZE  = \$clog2(`DMA_DATA_WIDTH)-3");
// 
//
// ### Derived or fixed parameters ###
//
// &PARAM("DATA_BYTES = 1 << DATA_SIZE");
// &PARAM("WSTRB_MSB = DATA_BYTES -1");
// &PARAM("DATA_WIDTH = `DMA_DATA_WIDTH");
//
// &FORCE("wire","id_dummy[2:0]");
// :assign id_dummy = 0;
//
// # ==========
// # DUT
// # ==========
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcdmac300/hdl/atcdmac300.v", "dmac300", {
// });
// &CONNECT("dmac300", {
// });
//
// # ==========
// # tb & model
// # ==========
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcdmac300/bench/blk_tb.sv", "bench", {
//	ADDR_WIDTH	=> "ADDR_WIDTH",
//	DATA_WIDTH	=> "DATA_WIDTH"
// });
//
// &INSTANCE("$PVC_LOCALDIR/andes_vip/models/apb/hdl/apb_master_model.sv", "apb_master1", {
//	LOG_MESSAGE	=> "0",
// });
// &CONNECT("apb_master1", {
// });
//
// &DANGLER("pstrb");
// &DANGLER("pprot");
//
// &INSTANCE("$PVC_LOCALDIR/andes_vip/models/axi/hdl/axi_slave_model.v", "axi_slave0", {
//   ADDR_WIDTH		 => "ADDR_WIDTH",
//   DATA_WIDTH		 => "DATA_SIZE",
//   AXI4		 => 1,
//   RAND_INIT_ON_READ_X => 1,
//   ID_WIDTH		 => "3",
//   MEM_ADDR_WIDTH	 => "`NDS_MEM_ADDR_WIDTH",
//   ADDR_DECODE_WIDTH	 => "`NDS_MEM_ADDR_WIDTH",
// });
// &CONNECT("axi_slave0", {
//   aclk   	=> "aclk", 
//   aresetn	=> "aresetn",
//   awid   	=> "m0_awid",
//   awaddr 	=> "m0_awaddr ",
//   awlen  	=> "m0_awlen  ",
//   awsize 	=> "m0_awsize ",
//   awburst	=> "m0_awburst",
//   awlock 	=> "{1'b0,m0_awlock} ",
//   awcache	=> "m0_awcache",
//   awprot 	=> "m0_awprot ",
//   awvalid	=> "m0_awvalid",
//   awready	=> "m0_awready",
//   wid    	=> "id_dummy",
//   wdata  	=> "m0_wdata  ",
//   wstrb  	=> "m0_wstrb  ",
//   wlast  	=> "m0_wlast  ",
//   wvalid 	=> "m0_wvalid ",
//   wready 	=> "m0_wready ",
//   bid    	=> "m0_bid ",
//   bresp  	=> "m0_bresp  ",
//   bvalid 	=> "m0_bvalid ",
//   bready 	=> "m0_bready ",
//   arid   	=> "m0_arid",
//   araddr 	=> "m0_araddr ",
//   arlen  	=> "m0_arlen  ",
//   arsize 	=> "m0_arsize ",
//   arburst	=> "m0_arburst",
//   arlock 	=> "{1'b0,m0_arlock} ",
//   arcache	=> "m0_arcache",
//   arprot 	=> "m0_arprot ",
//   arvalid	=> "m0_arvalid",
//   arready	=> "m0_arready",
//   rid    	=> "m0_rid",
//   rdata  	=> "m0_rdata  ",
//   rresp  	=> "m0_rresp  ",
//   rlast  	=> "m0_rlast  ",
//   rvalid 	=> "m0_rvalid ",
//   rready 	=> "m0_rready ",
//   csysreq	=> "m0_csysreq",
//   csysack	=> "m0_csysack",
//   cactive	=> "m0_cactive",
// });
//
// &DANGLER("m0_bid");
// &DANGLER("m0_rid");
//
// &FORCE("supply0", "m0_csysreq");
// &DANGLER("m0_csysack");
// &DANGLER("m0_cactive");
//
// &INSTANCE("$PVC_LOCALDIR/andes_vip/monitors/hdl/axi_monitor.v", "axi_monitor_s0", {
//   ADDR_WIDTH		=> "ADDR_WIDTH",
//   DATA_WIDTH		=> "DATA_SIZE",
//   AXI4		=> 1,
//   ID_WIDTH		=> "3",
//   MASTER_ID		=> 1,
//   SLAVE_ID 		=> 1,
// });
// &CONNECT("axi_monitor_s0", {
//   aclk   	=> "aclk", 
//   aresetn	=> "aresetn",
//   awid   	=> "m0_awid",
//   awaddr 	=> "m0_awaddr ",
//   awlen  	=> "m0_awlen  ",
//   awsize 	=> "m0_awsize ",
//   awburst	=> "m0_awburst",
//   awlock 	=> "{1'b0,m0_awlock} ",
//   awcache	=> "m0_awcache",
//   awprot 	=> "m0_awprot ",
//   awvalid	=> "m0_awvalid",
//   awready	=> "m0_awready",
//   wid    	=> "id_dummy",
//   wdata  	=> "m0_wdata  ",
//   wstrb  	=> "m0_wstrb  ",
//   wlast  	=> "m0_wlast  ",
//   wvalid 	=> "m0_wvalid ",
//   wready 	=> "m0_wready ",
//   bid    	=> "m0_bid ",
//   bresp  	=> "m0_bresp  ",
//   bvalid 	=> "m0_bvalid ",
//   bready 	=> "m0_bready ",
//   arid   	=> "m0_arid",
//   araddr 	=> "m0_araddr ",
//   arlen  	=> "m0_arlen  ",
//   arsize 	=> "m0_arsize ",
//   arburst	=> "m0_arburst",
//   arlock 	=> "{1'b0,m0_arlock} ",
//   arcache	=> "m0_arcache",
//   arprot 	=> "m0_arprot ",
//   arvalid	=> "m0_arvalid",
//   arready	=> "m0_arready",
//   rid    	=> "m0_rid",
//   rdata  	=> "m0_rdata  ",
//   rresp  	=> "m0_rresp  ",
//   rlast  	=> "m0_rlast  ",
//   rvalid 	=> "m0_rvalid ",
//   rready 	=> "m0_rready ",
// });
//
// &IFDEF("ATCDMAC300_DUAL_MASTER_IF_SUPPORT");
// &INSTANCE("$PVC_LOCALDIR/andes_vip/models/axi/hdl/axi_slave_model.v", "axi_slave1", {
//   ADDR_WIDTH		 => "ADDR_WIDTH",
//   DATA_WIDTH		 => "DATA_SIZE",
//   AXI4		 => 1,
//   RAND_INIT_ON_READ_X => 1,
//   ID_WIDTH		 => "3",
//   MEM_ADDR_WIDTH	 => "`NDS_MEM_ADDR_WIDTH",
//   ADDR_DECODE_WIDTH	 => "`NDS_MEM_ADDR_WIDTH",
// });
// &CONNECT("axi_slave1", {
//   aclk   	=> "aclk", 
//   aresetn	=> "aresetn",
//   awid   	=> "m1_awid",
//   awaddr 	=> "m1_awaddr ",
//   awlen  	=> "m1_awlen  ",
//   awsize 	=> "m1_awsize ",
//   awburst	=> "m1_awburst",
//   awlock 	=> "{1'b0,m1_awlock} ",
//   awcache	=> "m1_awcache",
//   awprot 	=> "m1_awprot ",
//   awvalid	=> "m1_awvalid",
//   awready	=> "m1_awready",
//   wid    	=> "id_dummy",
//   wdata  	=> "m1_wdata  ",
//   wstrb  	=> "m1_wstrb  ",
//   wlast  	=> "m1_wlast  ",
//   wvalid 	=> "m1_wvalid ",
//   wready 	=> "m1_wready ",
//   bid    	=> "m1_bid ",
//   bresp  	=> "m1_bresp  ",
//   bvalid 	=> "m1_bvalid ",
//   bready 	=> "m1_bready ",
//   arid   	=> "m1_arid",
//   araddr 	=> "m1_araddr ",
//   arlen  	=> "m1_arlen  ",
//   arsize 	=> "m1_arsize ",
//   arburst	=> "m1_arburst",
//   arlock 	=> "{1'b0,m1_arlock} ",
//   arcache	=> "m1_arcache",
//   arprot 	=> "m1_arprot ",
//   arvalid	=> "m1_arvalid",
//   arready	=> "m1_arready",
//   rid    	=> "m1_rid",
//   rdata  	=> "m1_rdata  ",
//   rresp  	=> "m1_rresp  ",
//   rlast  	=> "m1_rlast  ",
//   rvalid 	=> "m1_rvalid ",
//   rready 	=> "m1_rready ",
//   csysreq	=> "m1_csysreq",
//   csysack	=> "m1_csysack",
//   cactive	=> "m1_cactive",
// });
//
// &DANGLER("m1_bid");
// &DANGLER("m1_rid");
//
// &FORCE("supply0", "m1_csysreq");
// &DANGLER("m1_csysack");
// &DANGLER("m1_cactive");
//
// &INSTANCE("$PVC_LOCALDIR/andes_vip/monitors/hdl/axi_monitor.v", "axi_monitor_s1", {
//   ADDR_WIDTH		=> "ADDR_WIDTH",
//   DATA_WIDTH		=> "DATA_SIZE",
//   AXI4		=> 1,
//   ID_WIDTH		=> "3",
//   MASTER_ID		=> 2,
//   SLAVE_ID 		=> 2,
// });
// &CONNECT("axi_monitor_s1", {
//   aclk   	=> "aclk", 
//   aresetn	=> "aresetn",
//   awid   	=> "m1_awid",
//   awaddr 	=> "m1_awaddr ",
//   awlen  	=> "m1_awlen  ",
//   awsize 	=> "m1_awsize ",
//   awburst	=> "m1_awburst",
//   awlock 	=> "{1'b0,m1_awlock} ",
//   awcache	=> "m1_awcache",
//   awprot 	=> "m1_awprot ",
//   awvalid	=> "m1_awvalid",
//   awready	=> "m1_awready",
//   wid    	=> "id_dummy",
//   wdata  	=> "m1_wdata  ",
//   wstrb  	=> "m1_wstrb  ",
//   wlast  	=> "m1_wlast  ",
//   wvalid 	=> "m1_wvalid ",
//   wready 	=> "m1_wready ",
//   bid    	=> "m1_bid ",
//   bresp  	=> "m1_bresp  ",
//   bvalid 	=> "m1_bvalid ",
//   bready 	=> "m1_bready ",
//   arid   	=> "m1_arid",
//   araddr 	=> "m1_araddr ",
//   arlen  	=> "m1_arlen  ",
//   arsize 	=> "m1_arsize ",
//   arburst	=> "m1_arburst",
//   arlock 	=> "{1'b0,m1_arlock} ",
//   arcache	=> "m1_arcache",
//   arprot 	=> "m1_arprot ",
//   arvalid	=> "m1_arvalid",
//   arready	=> "m1_arready",
//   rid    	=> "m1_rid",
//   rdata  	=> "m1_rdata  ",
//   rresp  	=> "m1_rresp  ",
//   rlast  	=> "m1_rlast  ",
//   rvalid 	=> "m1_rvalid ",
//   rready 	=> "m1_rready ",
// });
// &ENDIF();
//
// : `ifdef NDS_SCOREBOARD_EN
// : // scoreboard
// : blk_scb  blk_scb();
// : defparam blk_scb.SCB_ADDR_WIDTH = ADDR_WIDTH;
// : defparam blk_scb.SCB_PUSH_START_ADDR = 0;
// : defparam blk_scb.SCB_CAPTURE_LOCK = 1;

// :
// : defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.ADDR_WIDTH = ADDR_WIDTH;
// : defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.ID_WIDTH = 3;
// : defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.AXI4 = 1;
// : defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.DATA_WIDTH_SIZE = DATA_SIZE;
// : defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.PUSH_START_ADDR = 0;
// : defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.CAPTURE_LOCK = 1;
// : defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.IGN_WSTRB = 1;
// : 
// : `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT 
// : defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.ADDR_WIDTH = ADDR_WIDTH;
// : defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.ID_WIDTH = 3;
// : defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.AXI4 = 1;
// : defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.DATA_WIDTH_SIZE = DATA_SIZE;
// : defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.PUSH_START_ADDR = 0;
// : defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.CAPTURE_LOCK = 1;
// : defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.IGN_WSTRB = 1;
// : `endif
// : 
// : `endif // NDS_SCOREBOARD_EN
// :
//
// &ENDMODULE;
//
// : `ifdef NDS_SCOREBOARD_EN
// : // scoreboard
// : bind axi_slave_model : `NDS_SYSTEM.axi_slave0 scb_axis_mon scb_axis_mon (.*, .model_id(8'd1));
// : `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT 
// : bind axi_slave_model : `NDS_SYSTEM.axi_slave1 scb_axis_mon scb_axis_mon (.*, .model_id(8'd2));
// : `endif
// : `endif // NDS_SCOREBOARD_EN
// :
// VPERL_END

// VPERL_GENERATED_BEGIN
module system (
`ifdef NDS_AXI_AWREGION_SUPPORT
	  awregion, // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_AWREGION_SUPPORT
`ifdef NDS_AXI_AWQOS_SUPPORT
	  awqos,    // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_AWQOS_SUPPORT
`ifdef NDS_AXI_AWUSER_SUPPORT
	  awuser,   // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_AWUSER_SUPPORT
`ifdef NDS_AXI_WUSER_SUPPORT
	  wuser,    // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_WUSER_SUPPORT
`ifdef NDS_AXI_ARREGION_SUPPORT
	  arregion, // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_ARREGION_SUPPORT
`ifdef NDS_AXI_ARQOS_SUPPORT
	  arqos,    // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_ARQOS_SUPPORT
`ifdef NDS_AXI_ARUSER_SUPPORT
	  aruser    // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_ARUSER_SUPPORT
);

parameter ADDR_WIDTH = `ATCDMAC300_ADDR_WIDTH;
parameter ADDR_MSB = ADDR_WIDTH -1;
parameter DATA_SIZE  = $clog2(`DMA_DATA_WIDTH)-3;
parameter DATA_BYTES = 1 << DATA_SIZE;
parameter WSTRB_MSB = DATA_BYTES -1;
parameter DATA_WIDTH = `DMA_DATA_WIDTH;

`ifdef NDS_AXI_AWREGION_SUPPORT
input        [3:0] awregion;
`endif // NDS_AXI_AWREGION_SUPPORT
`ifdef NDS_AXI_AWQOS_SUPPORT
input        [3:0] awqos;
`endif // NDS_AXI_AWQOS_SUPPORT
`ifdef NDS_AXI_AWUSER_SUPPORT
input       [-1:0] awuser;
`endif // NDS_AXI_AWUSER_SUPPORT
`ifdef NDS_AXI_WUSER_SUPPORT
input       [-1:0] wuser;
`endif // NDS_AXI_WUSER_SUPPORT
`ifdef NDS_AXI_ARREGION_SUPPORT
input        [3:0] arregion;
`endif // NDS_AXI_ARREGION_SUPPORT
`ifdef NDS_AXI_ARQOS_SUPPORT
input        [3:0] arqos;
`endif // NDS_AXI_ARQOS_SUPPORT
`ifdef NDS_AXI_ARUSER_SUPPORT
input       [-1:0] aruser;
`endif // NDS_AXI_ARUSER_SUPPORT

`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
supply0                                    m1_csysreq;
wire                                       m1_arready;
wire                                       m1_awready;
wire                                 [2:0] m1_bid;
wire                                 [1:0] m1_bresp;
wire                                       m1_bvalid;
wire                                       m1_cactive; // dangler: () => ()
wire                                       m1_csysack; // dangler: () => ()
wire               [(`DMA_DATA_WIDTH-1):0] m1_rdata;
wire                                 [2:0] m1_rid;
wire                                       m1_rlast;
wire                                 [1:0] m1_rresp;
wire                                       m1_rvalid;
wire                                       m1_wready;
wire        [(`ATCDMAC300_ADDR_WIDTH-1):0] m1_araddr;
wire                                 [1:0] m1_arburst;
wire                                 [3:0] m1_arcache;
wire                                 [2:0] m1_arid;
wire                                 [7:0] m1_arlen;
wire                                       m1_arlock;
wire                                 [2:0] m1_arprot;
wire                                 [2:0] m1_arsize;
wire                                       m1_arvalid;
wire        [(`ATCDMAC300_ADDR_WIDTH-1):0] m1_awaddr;
wire                                 [1:0] m1_awburst;
wire                                 [3:0] m1_awcache;
wire                                 [2:0] m1_awid;
wire                                 [7:0] m1_awlen;
wire                                       m1_awlock;
wire                                 [2:0] m1_awprot;
wire                                 [2:0] m1_awsize;
wire                                       m1_awvalid;
wire                                       m1_bready;
wire                                       m1_rready;
wire               [(`DMA_DATA_WIDTH-1):0] m1_wdata;
wire                                       m1_wlast;
wire              [(`DMA_WSTRB_WIDTH-1):0] m1_wstrb;
wire                                       m1_wvalid;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef NDS_AXI_BUSER_SUPPORT
wire                                [-1:0] buser;
`endif // NDS_AXI_BUSER_SUPPORT
`ifdef NDS_AXI_RUSER_SUPPORT
wire                                [-1:0] ruser;
`endif // NDS_AXI_RUSER_SUPPORT
wire                                 [2:0] id_dummy;
supply0                                    m0_csysreq;
wire                                [31:0] paddr;
wire                                       penable;
wire                                 [2:0] pprot; // dangler: () => ()
wire                                       psel;
wire                                 [3:0] pstrb; // dangler: () => ()
wire                                [31:0] pwdata;
wire                                       pwrite;
wire                                       m0_arready;
wire                                       m0_awready;
wire                                 [2:0] m0_bid;
wire                                 [1:0] m0_bresp;
wire                                       m0_bvalid;
wire                                       m0_cactive; // dangler: () => ()
wire                                       m0_csysack; // dangler: () => ()
wire               [(`DMA_DATA_WIDTH-1):0] m0_rdata;
wire                                 [2:0] m0_rid;
wire                                       m0_rlast;
wire                                 [1:0] m0_rresp;
wire                                       m0_rvalid;
wire                                       m0_wready;
wire                                       aclk;
wire                                       aresetn;
wire         [`ATCDMAC300_REQ_ACK_NUM-1:0] dma_req;
wire                                       pclk;
wire                                       presetn;
wire         [`ATCDMAC300_REQ_ACK_NUM-1:0] dma_ack;
wire                                       dma_int;
wire        [(`ATCDMAC300_ADDR_WIDTH-1):0] m0_araddr;
wire                                 [1:0] m0_arburst;
wire                                 [3:0] m0_arcache;
wire                                 [2:0] m0_arid;
wire                                 [7:0] m0_arlen;
wire                                       m0_arlock;
wire                                 [2:0] m0_arprot;
wire                                 [2:0] m0_arsize;
wire                                       m0_arvalid;
wire        [(`ATCDMAC300_ADDR_WIDTH-1):0] m0_awaddr;
wire                                 [1:0] m0_awburst;
wire                                 [3:0] m0_awcache;
wire                                 [2:0] m0_awid;
wire                                 [7:0] m0_awlen;
wire                                       m0_awlock;
wire                                 [2:0] m0_awprot;
wire                                 [2:0] m0_awsize;
wire                                       m0_awvalid;
wire                                       m0_bready;
wire                                       m0_rready;
wire               [(`DMA_DATA_WIDTH-1):0] m0_wdata;
wire                                       m0_wlast;
wire              [(`DMA_WSTRB_WIDTH-1):0] m0_wstrb;
wire                                       m0_wvalid;
wire                                [31:0] prdata;
wire                                       pready;
wire                                       pslverr;

assign id_dummy = 0;
`ifdef NDS_SCOREBOARD_EN
// scoreboard
blk_scb  blk_scb();
defparam blk_scb.SCB_ADDR_WIDTH = ADDR_WIDTH;
defparam blk_scb.SCB_PUSH_START_ADDR = 0;
defparam blk_scb.SCB_CAPTURE_LOCK = 1;

defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.ADDR_WIDTH = ADDR_WIDTH;
defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.ID_WIDTH = 3;
defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.AXI4 = 1;
defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.DATA_WIDTH_SIZE = DATA_SIZE;
defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.PUSH_START_ADDR = 0;
defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.CAPTURE_LOCK = 1;
defparam `NDS_SYSTEM.axi_slave0.scb_axis_mon.IGN_WSTRB = 1;

`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.ADDR_WIDTH = ADDR_WIDTH;
defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.ID_WIDTH = 3;
defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.AXI4 = 1;
defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.DATA_WIDTH_SIZE = DATA_SIZE;
defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.PUSH_START_ADDR = 0;
defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.CAPTURE_LOCK = 1;
defparam `NDS_SYSTEM.axi_slave1.scb_axis_mon.IGN_WSTRB = 1;
`endif

`endif // NDS_SCOREBOARD_EN


atcdmac300 dmac300 (
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.m1_araddr (m1_araddr ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_arburst(m1_arburst), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_arcache(m1_arcache), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_arid   (m1_arid   ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_arlen  (m1_arlen  ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_arlock (m1_arlock ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_arprot (m1_arprot ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_arready(m1_arready), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.m1_arsize (m1_arsize ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_arvalid(m1_arvalid), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_awaddr (m1_awaddr ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_awburst(m1_awburst), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_awcache(m1_awcache), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_awid   (m1_awid   ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_awlen  (m1_awlen  ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_awlock (m1_awlock ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_awprot (m1_awprot ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_awready(m1_awready), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.m1_awsize (m1_awsize ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_awvalid(m1_awvalid), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_bid    (m1_bid    ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.m1_bready (m1_bready ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_bresp  (m1_bresp  ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.m1_bvalid (m1_bvalid ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.m1_rdata  (m1_rdata  ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.m1_rid    (m1_rid    ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.m1_rlast  (m1_rlast  ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.m1_rready (m1_rready ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_rresp  (m1_rresp  ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.m1_rvalid (m1_rvalid ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.m1_wdata  (m1_wdata  ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_wlast  (m1_wlast  ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_wready (m1_wready ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.m1_wstrb  (m1_wstrb  ), // (dmac300) => (axi_monitor_s1,axi_slave1)
	.m1_wvalid (m1_wvalid ), // (dmac300) => (axi_monitor_s1,axi_slave1)
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.paddr     (paddr     ), // (dmac300) <= (apb_master1)
	.penable   (penable   ), // (dmac300) <= (apb_master1)
	.prdata    (prdata    ), // (dmac300) => (apb_master1)
	.pready    (pready    ), // (dmac300) => (apb_master1)
	.psel      (psel      ), // (dmac300) <= (apb_master1)
	.pslverr   (pslverr   ), // (dmac300) => (apb_master1)
	.pwdata    (pwdata    ), // (dmac300) <= (apb_master1)
	.pwrite    (pwrite    ), // (dmac300) <= (apb_master1)
	.pclk      (pclk      ), // (apb_master1,dmac300) <= (bench)
	.presetn   (presetn   ), // (apb_master1,dmac300) <= (bench)
	.m0_araddr (m0_araddr ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_arburst(m0_arburst), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_arcache(m0_arcache), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_arid   (m0_arid   ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_arlen  (m0_arlen  ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_arlock (m0_arlock ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_arprot (m0_arprot ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_arready(m0_arready), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.m0_arsize (m0_arsize ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_arvalid(m0_arvalid), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_awaddr (m0_awaddr ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_awburst(m0_awburst), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_awcache(m0_awcache), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_awid   (m0_awid   ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_awlen  (m0_awlen  ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_awlock (m0_awlock ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_awprot (m0_awprot ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_awready(m0_awready), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.m0_awsize (m0_awsize ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_awvalid(m0_awvalid), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_bid    (m0_bid    ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.m0_bready (m0_bready ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_bresp  (m0_bresp  ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.m0_bvalid (m0_bvalid ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.m0_rdata  (m0_rdata  ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.m0_rid    (m0_rid    ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.m0_rlast  (m0_rlast  ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.m0_rready (m0_rready ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_rresp  (m0_rresp  ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.m0_rvalid (m0_rvalid ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.m0_wdata  (m0_wdata  ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_wlast  (m0_wlast  ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_wready (m0_wready ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.m0_wstrb  (m0_wstrb  ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.m0_wvalid (m0_wvalid ), // (dmac300) => (axi_monitor_s0,axi_slave0)
	.aclk      (aclk      ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300) <= (bench)
	.aresetn   (aresetn   ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300) <= (bench)
	.dma_ack   (dma_ack   ), // (dmac300) => (bench)
	.dma_req   (dma_req   ), // (dmac300) <= (bench)
	.dma_int   (dma_int   )  // (dmac300) => (bench)
); // end of dmac300

defparam bench.ADDR_WIDTH = ADDR_WIDTH;
defparam bench.DATA_WIDTH = DATA_WIDTH;
blk_tb bench (
	.dma_int(dma_int), // (bench) <= (dmac300)
	.dma_ack(dma_ack), // (bench) <= (dmac300)
	.dma_req(dma_req), // (bench) => (dmac300)
	.aclk   (aclk   ), // (bench) => (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300)
	.aresetn(aresetn), // (bench) => (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300)
	.pclk   (pclk   ), // (bench) => (apb_master1,dmac300)
	.presetn(presetn)  // (bench) => (apb_master1,dmac300)
); // end of bench

defparam apb_master1.LOG_MESSAGE = 0;
apb_master_model apb_master1 (
	.pclk   (pclk   ), // (apb_master1,dmac300) <= (bench)
	.presetn(presetn), // (apb_master1,dmac300) <= (bench)
	.paddr  (paddr  ), // (apb_master1) => (dmac300)
	.penable(penable), // (apb_master1) => (dmac300)
	.psel   (psel   ), // (apb_master1) => (dmac300)
	.pwdata (pwdata ), // (apb_master1) => (dmac300)
	.pwrite (pwrite ), // (apb_master1) => (dmac300)
	.pprot  (pprot  ), // (apb_master1) => ()
	.pstrb  (pstrb  ), // (apb_master1) => ()
	.prdata (prdata ), // (apb_master1) <= (dmac300)
	.pready (pready ), // (apb_master1) <= (dmac300)
	.pslverr(pslverr)  // (apb_master1) <= (dmac300)
); // end of apb_master1

defparam axi_slave0.ADDR_DECODE_WIDTH = `NDS_MEM_ADDR_WIDTH;
defparam axi_slave0.ADDR_WIDTH = ADDR_WIDTH;
defparam axi_slave0.AXI4 = 1;
defparam axi_slave0.DATA_WIDTH = DATA_SIZE;
defparam axi_slave0.ID_WIDTH = 3;
defparam axi_slave0.MEM_ADDR_WIDTH = `NDS_MEM_ADDR_WIDTH;
defparam axi_slave0.RAND_INIT_ON_READ_X = 1;
axi_slave_model axi_slave0 (
	.aclk    (aclk            ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300) <= (bench)
	.aresetn (aresetn         ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300) <= (bench)
	.awid    (m0_awid         ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awaddr  (m0_awaddr       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awlen   (m0_awlen        ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awsize  (m0_awsize       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awburst (m0_awburst      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awlock  ({1'b0,m0_awlock}), // () <= ()
	.awcache (m0_awcache      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awprot  (m0_awprot       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awvalid (m0_awvalid      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awready (m0_awready      ), // (axi_slave0) => (axi_monitor_s0,dmac300)
`ifdef NDS_AXI_AWREGION_SUPPORT
	.awregion(awregion        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_AWREGION_SUPPORT
`ifdef NDS_AXI_AWQOS_SUPPORT
	.awqos   (awqos           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_AWQOS_SUPPORT
`ifdef NDS_AXI_AWUSER_SUPPORT
	.awuser  (awuser          ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_AWUSER_SUPPORT
	.wid     (id_dummy        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
	.wdata   (m0_wdata        ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.wstrb   (m0_wstrb        ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.wlast   (m0_wlast        ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.wvalid  (m0_wvalid       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.wready  (m0_wready       ), // (axi_slave0) => (axi_monitor_s0,dmac300)
`ifdef NDS_AXI_WUSER_SUPPORT
	.wuser   (wuser           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_WUSER_SUPPORT
	.bid     (m0_bid          ), // (axi_slave0) => (axi_monitor_s0,dmac300)
	.bresp   (m0_bresp        ), // (axi_slave0) => (axi_monitor_s0,dmac300)
	.bvalid  (m0_bvalid       ), // (axi_slave0) => (axi_monitor_s0,dmac300)
	.bready  (m0_bready       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
`ifdef NDS_AXI_BUSER_SUPPORT
	.buser   (buser           ), // (axi_slave0,axi_slave1) => (axi_monitor_s0,axi_monitor_s1)
`endif // NDS_AXI_BUSER_SUPPORT
	.arid    (m0_arid         ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.araddr  (m0_araddr       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arlen   (m0_arlen        ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arsize  (m0_arsize       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arburst (m0_arburst      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arlock  ({1'b0,m0_arlock}), // () <= ()
	.arcache (m0_arcache      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arprot  (m0_arprot       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arvalid (m0_arvalid      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arready (m0_arready      ), // (axi_slave0) => (axi_monitor_s0,dmac300)
`ifdef NDS_AXI_ARREGION_SUPPORT
	.arregion(arregion        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_ARREGION_SUPPORT
`ifdef NDS_AXI_ARQOS_SUPPORT
	.arqos   (arqos           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_ARQOS_SUPPORT
`ifdef NDS_AXI_ARUSER_SUPPORT
	.aruser  (aruser          ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_ARUSER_SUPPORT
	.rid     (m0_rid          ), // (axi_slave0) => (axi_monitor_s0,dmac300)
	.rdata   (m0_rdata        ), // (axi_slave0) => (axi_monitor_s0,dmac300)
	.rresp   (m0_rresp        ), // (axi_slave0) => (axi_monitor_s0,dmac300)
	.rlast   (m0_rlast        ), // (axi_slave0) => (axi_monitor_s0,dmac300)
	.rvalid  (m0_rvalid       ), // (axi_slave0) => (axi_monitor_s0,dmac300)
`ifdef NDS_AXI_RUSER_SUPPORT
	.ruser   (ruser           ), // (axi_slave0,axi_slave1) => (axi_monitor_s0,axi_monitor_s1)
`endif // NDS_AXI_RUSER_SUPPORT
	.rready  (m0_rready       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.csysreq (m0_csysreq      ), // (axi_slave0) <= ()
	.csysack (m0_csysack      ), // (axi_slave0) => ()
	.cactive (m0_cactive      )  // (axi_slave0) => ()
); // end of axi_slave0

defparam axi_monitor_s0.ADDR_WIDTH = ADDR_WIDTH;
defparam axi_monitor_s0.AXI4 = 1;
defparam axi_monitor_s0.DATA_WIDTH = DATA_SIZE;
defparam axi_monitor_s0.ID_WIDTH = 3;
defparam axi_monitor_s0.MASTER_ID = 1;
defparam axi_monitor_s0.SLAVE_ID = 1;
axi_monitor axi_monitor_s0 (
	.aclk    (aclk            ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300) <= (bench)
	.aresetn (aresetn         ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300) <= (bench)
	.awid    (m0_awid         ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awaddr  (m0_awaddr       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awlen   (m0_awlen        ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awsize  (m0_awsize       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awburst (m0_awburst      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awlock  ({1'b0,m0_awlock}), // () <= ()
	.awcache (m0_awcache      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awprot  (m0_awprot       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awvalid (m0_awvalid      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.awready (m0_awready      ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
`ifdef NDS_AXI_AWREGION_SUPPORT
	.awregion(awregion        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_AWREGION_SUPPORT
`ifdef NDS_AXI_AWQOS_SUPPORT
	.awqos   (awqos           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_AWQOS_SUPPORT
`ifdef NDS_AXI_AWUSER_SUPPORT
	.awuser  (awuser          ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_AWUSER_SUPPORT
	.wid     (id_dummy        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
	.wdata   (m0_wdata        ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.wstrb   (m0_wstrb        ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.wlast   (m0_wlast        ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.wvalid  (m0_wvalid       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.wready  (m0_wready       ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
`ifdef NDS_AXI_WUSER_SUPPORT
	.wuser   (wuser           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_WUSER_SUPPORT
	.bid     (m0_bid          ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.bresp   (m0_bresp        ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.bvalid  (m0_bvalid       ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.bready  (m0_bready       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
`ifdef NDS_AXI_BUSER_SUPPORT
	.buser   (buser           ), // (axi_monitor_s0,axi_monitor_s1) <= (axi_slave0,axi_slave1)
`endif // NDS_AXI_BUSER_SUPPORT
	.arid    (m0_arid         ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.araddr  (m0_araddr       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arlen   (m0_arlen        ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arsize  (m0_arsize       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arburst (m0_arburst      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arlock  ({1'b0,m0_arlock}), // () <= ()
	.arcache (m0_arcache      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arprot  (m0_arprot       ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arvalid (m0_arvalid      ), // (axi_monitor_s0,axi_slave0) <= (dmac300)
	.arready (m0_arready      ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
`ifdef NDS_AXI_ARREGION_SUPPORT
	.arregion(arregion        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_ARREGION_SUPPORT
`ifdef NDS_AXI_ARQOS_SUPPORT
	.arqos   (arqos           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_ARQOS_SUPPORT
`ifdef NDS_AXI_ARUSER_SUPPORT
	.aruser  (aruser          ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
`endif // NDS_AXI_ARUSER_SUPPORT
	.rid     (m0_rid          ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.rdata   (m0_rdata        ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.rresp   (m0_rresp        ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.rlast   (m0_rlast        ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
	.rvalid  (m0_rvalid       ), // (axi_monitor_s0,dmac300) <= (axi_slave0)
`ifdef NDS_AXI_RUSER_SUPPORT
	.ruser   (ruser           ), // (axi_monitor_s0,axi_monitor_s1) <= (axi_slave0,axi_slave1)
`endif // NDS_AXI_RUSER_SUPPORT
	.rready  (m0_rready       )  // (axi_monitor_s0,axi_slave0) <= (dmac300)
); // end of axi_monitor_s0

`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
defparam axi_slave1.ADDR_DECODE_WIDTH = `NDS_MEM_ADDR_WIDTH;
defparam axi_slave1.ADDR_WIDTH = ADDR_WIDTH;
defparam axi_slave1.AXI4 = 1;
defparam axi_slave1.DATA_WIDTH = DATA_SIZE;
defparam axi_slave1.ID_WIDTH = 3;
defparam axi_slave1.MEM_ADDR_WIDTH = `NDS_MEM_ADDR_WIDTH;
defparam axi_slave1.RAND_INIT_ON_READ_X = 1;
axi_slave_model axi_slave1 (
	.aclk    (aclk            ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300) <= (bench)
	.aresetn (aresetn         ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300) <= (bench)
	.awid    (m1_awid         ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awaddr  (m1_awaddr       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awlen   (m1_awlen        ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awsize  (m1_awsize       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awburst (m1_awburst      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awlock  ({1'b0,m1_awlock}), // () <= ()
	.awcache (m1_awcache      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awprot  (m1_awprot       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awvalid (m1_awvalid      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awready (m1_awready      ), // (axi_slave1) => (axi_monitor_s1,dmac300)
   `ifdef NDS_AXI_AWREGION_SUPPORT
	.awregion(awregion        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_AWREGION_SUPPORT
   `ifdef NDS_AXI_AWQOS_SUPPORT
	.awqos   (awqos           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_AWQOS_SUPPORT
   `ifdef NDS_AXI_AWUSER_SUPPORT
	.awuser  (awuser          ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_AWUSER_SUPPORT
	.wid     (id_dummy        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
	.wdata   (m1_wdata        ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.wstrb   (m1_wstrb        ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.wlast   (m1_wlast        ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.wvalid  (m1_wvalid       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.wready  (m1_wready       ), // (axi_slave1) => (axi_monitor_s1,dmac300)
   `ifdef NDS_AXI_WUSER_SUPPORT
	.wuser   (wuser           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_WUSER_SUPPORT
	.bid     (m1_bid          ), // (axi_slave1) => (axi_monitor_s1,dmac300)
	.bresp   (m1_bresp        ), // (axi_slave1) => (axi_monitor_s1,dmac300)
	.bvalid  (m1_bvalid       ), // (axi_slave1) => (axi_monitor_s1,dmac300)
	.bready  (m1_bready       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
   `ifdef NDS_AXI_BUSER_SUPPORT
	.buser   (buser           ), // (axi_slave0,axi_slave1) => (axi_monitor_s0,axi_monitor_s1)
   `endif // NDS_AXI_BUSER_SUPPORT
	.arid    (m1_arid         ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.araddr  (m1_araddr       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arlen   (m1_arlen        ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arsize  (m1_arsize       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arburst (m1_arburst      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arlock  ({1'b0,m1_arlock}), // () <= ()
	.arcache (m1_arcache      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arprot  (m1_arprot       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arvalid (m1_arvalid      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arready (m1_arready      ), // (axi_slave1) => (axi_monitor_s1,dmac300)
   `ifdef NDS_AXI_ARREGION_SUPPORT
	.arregion(arregion        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_ARREGION_SUPPORT
   `ifdef NDS_AXI_ARQOS_SUPPORT
	.arqos   (arqos           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_ARQOS_SUPPORT
   `ifdef NDS_AXI_ARUSER_SUPPORT
	.aruser  (aruser          ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_ARUSER_SUPPORT
	.rid     (m1_rid          ), // (axi_slave1) => (axi_monitor_s1,dmac300)
	.rdata   (m1_rdata        ), // (axi_slave1) => (axi_monitor_s1,dmac300)
	.rresp   (m1_rresp        ), // (axi_slave1) => (axi_monitor_s1,dmac300)
	.rlast   (m1_rlast        ), // (axi_slave1) => (axi_monitor_s1,dmac300)
	.rvalid  (m1_rvalid       ), // (axi_slave1) => (axi_monitor_s1,dmac300)
   `ifdef NDS_AXI_RUSER_SUPPORT
	.ruser   (ruser           ), // (axi_slave0,axi_slave1) => (axi_monitor_s0,axi_monitor_s1)
   `endif // NDS_AXI_RUSER_SUPPORT
	.rready  (m1_rready       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.csysreq (m1_csysreq      ), // (axi_slave1) <= ()
	.csysack (m1_csysack      ), // (axi_slave1) => ()
	.cactive (m1_cactive      )  // (axi_slave1) => ()
); // end of axi_slave1

defparam axi_monitor_s1.ADDR_WIDTH = ADDR_WIDTH;
defparam axi_monitor_s1.AXI4 = 1;
defparam axi_monitor_s1.DATA_WIDTH = DATA_SIZE;
defparam axi_monitor_s1.ID_WIDTH = 3;
defparam axi_monitor_s1.MASTER_ID = 2;
defparam axi_monitor_s1.SLAVE_ID = 2;
axi_monitor axi_monitor_s1 (
	.aclk    (aclk            ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300) <= (bench)
	.aresetn (aresetn         ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1,dmac300) <= (bench)
	.awid    (m1_awid         ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awaddr  (m1_awaddr       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awlen   (m1_awlen        ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awsize  (m1_awsize       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awburst (m1_awburst      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awlock  ({1'b0,m1_awlock}), // () <= ()
	.awcache (m1_awcache      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awprot  (m1_awprot       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awvalid (m1_awvalid      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.awready (m1_awready      ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
   `ifdef NDS_AXI_AWREGION_SUPPORT
	.awregion(awregion        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_AWREGION_SUPPORT
   `ifdef NDS_AXI_AWQOS_SUPPORT
	.awqos   (awqos           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_AWQOS_SUPPORT
   `ifdef NDS_AXI_AWUSER_SUPPORT
	.awuser  (awuser          ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_AWUSER_SUPPORT
	.wid     (id_dummy        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
	.wdata   (m1_wdata        ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.wstrb   (m1_wstrb        ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.wlast   (m1_wlast        ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.wvalid  (m1_wvalid       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.wready  (m1_wready       ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
   `ifdef NDS_AXI_WUSER_SUPPORT
	.wuser   (wuser           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_WUSER_SUPPORT
	.bid     (m1_bid          ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.bresp   (m1_bresp        ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.bvalid  (m1_bvalid       ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.bready  (m1_bready       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
   `ifdef NDS_AXI_BUSER_SUPPORT
	.buser   (buser           ), // (axi_monitor_s0,axi_monitor_s1) <= (axi_slave0,axi_slave1)
   `endif // NDS_AXI_BUSER_SUPPORT
	.arid    (m1_arid         ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.araddr  (m1_araddr       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arlen   (m1_arlen        ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arsize  (m1_arsize       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arburst (m1_arburst      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arlock  ({1'b0,m1_arlock}), // () <= ()
	.arcache (m1_arcache      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arprot  (m1_arprot       ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arvalid (m1_arvalid      ), // (axi_monitor_s1,axi_slave1) <= (dmac300)
	.arready (m1_arready      ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
   `ifdef NDS_AXI_ARREGION_SUPPORT
	.arregion(arregion        ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_ARREGION_SUPPORT
   `ifdef NDS_AXI_ARQOS_SUPPORT
	.arqos   (arqos           ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_ARQOS_SUPPORT
   `ifdef NDS_AXI_ARUSER_SUPPORT
	.aruser  (aruser          ), // (axi_monitor_s0,axi_monitor_s1,axi_slave0,axi_slave1) <= ()
   `endif // NDS_AXI_ARUSER_SUPPORT
	.rid     (m1_rid          ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.rdata   (m1_rdata        ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.rresp   (m1_rresp        ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.rlast   (m1_rlast        ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
	.rvalid  (m1_rvalid       ), // (axi_monitor_s1,dmac300) <= (axi_slave1)
   `ifdef NDS_AXI_RUSER_SUPPORT
	.ruser   (ruser           ), // (axi_monitor_s0,axi_monitor_s1) <= (axi_slave0,axi_slave1)
   `endif // NDS_AXI_RUSER_SUPPORT
	.rready  (m1_rready       )  // (axi_monitor_s1,axi_slave1) <= (dmac300)
); // end of axi_monitor_s1

`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
endmodule
`ifdef NDS_SCOREBOARD_EN
// scoreboard
bind axi_slave_model : `NDS_SYSTEM.axi_slave0 scb_axis_mon scb_axis_mon (.*, .model_id(8'd1));
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
bind axi_slave_model : `NDS_SYSTEM.axi_slave1 scb_axis_mon scb_axis_mon (.*, .model_id(8'd2));
`endif
`endif // NDS_SCOREBOARD_EN

// VPERL_GENERATED_END
