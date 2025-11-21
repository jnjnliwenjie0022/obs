`include "config.inc"
`include "atcsmu100_config.vh"
`include "atcsmu100_const.vh"
// VPERL_BEGIN
// &MODULE("atcsmu100");

// my $pcs_count = 7;
// &PARAM("PCS_NUM = $pcs_count");

// &FORCE("wire", "pcs_sel[7:0]");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcsmu100/hdl/atcsmu100_apbif.v",    "smu_apbif", {
//	PCS_NUM => PCS_NUM,
// });
// &CONNECT("smu_apbif.paddr", "paddr_12_2}");
// &DANGLER("paddr_12_2");
// &IFDEF("NDS_BOARD_CF1");
//   &FORCE("input", "paddr[12:2]");
// &ELSE("NDS_BOARD_CF1");
//   &FORCE("input", "paddr[9:2]");
// &ENDIF("NDS_BOARD_CF1");
// &FORCE("wire", "smu_sw_rst");

// my $i = 0;
// &FORCE("input", "pcs${i}_wakeup_event[31:1]"); 
// &FORCE("output", "pcs${i}_int");
// &FORCE("output", "pcs${i}_wakeup");
// &FORCE("output", "pcs${i}_standby_req");
// &FORCE("input", "pcs${i}_standby_ok");
// &FORCE("output", "pcs${i}_frq_scale_req");
// &FORCE("output", "pcs${i}_frq_scale[2:0]");
// &FORCE("output", "pcs${i}_frq_clkon[31:0]");	  
// &FORCE("input", "pcs${i}_frq_scale_ack");
// &FORCE("output", "pcs${i}_vol_scale_req");
// &FORCE("output", "pcs${i}_vol_scale[2:0]");
// &FORCE("input", "pcs${i}_vol_scale_ack");
// &FORCE("output", "pcs${i}_iso");
// &FORCE("output", "pcs${i}_reten");
// &FORCE("output", "pcs${i}_resetn");
// &FORCE("output", "pcs${i}_mem_init[3:0]");	  
// &FORCE("input", "pcs${i}_reset_source[4:0]");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcsmu100/hdl/atcsmu100_pcs.v",      "smu_pcs${i}");
// &CONNECT("smu_pcs${i}.pcs_sel", "pcs_sel[$i]");
// &CONNECT("smu_pcs${i}.pcs_rdata","pcs${i}_rdata");
// &CONNECT("smu_pcs${i}.pcs_wakeup_event","pcs${i}_wakeup_event");
// &CONNECT("smu_pcs${i}.pcs_int","pcs${i}_int");
// &CONNECT("smu_pcs${i}.pcs_wakeup","pcs${i}_wakeup");
// &CONNECT("smu_pcs${i}.pcs_standby_req","pcs${i}_standby_req");
// &CONNECT("smu_pcs${i}.pcs_standby_ok","pcs${i}_standby_ok");
// &CONNECT("smu_pcs${i}.pcs_frq_scale_req","pcs${i}_frq_scale_req");
// &CONNECT("smu_pcs${i}.pcs_frq_scale","pcs${i}_frq_scale");
// &CONNECT("smu_pcs${i}.pcs_frq_clkon","pcs${i}_frq_clkon");
// &CONNECT("smu_pcs${i}.pcs_frq_scale_ack","pcs${i}_frq_scale_ack");
// &CONNECT("smu_pcs${i}.pcs_vol_scale_req","pcs${i}_vol_scale_req");
// &CONNECT("smu_pcs${i}.pcs_vol_scale","pcs${i}_vol_scale");
// &CONNECT("smu_pcs${i}.pcs_vol_scale_ack","pcs${i}_vol_scale_ack");
// &CONNECT("smu_pcs${i}.pcs_iso","pcs${i}_iso");
// &CONNECT("smu_pcs${i}.pcs_reten","pcs${i}_reten");
// &CONNECT("smu_pcs${i}.pcs_resetn","pcs${i}_resetn_new");
// &CONNECT("smu_pcs${i}.pcs_mem_init","pcs${i}_mem_init");
// &CONNECT("smu_pcs${i}.pcs_reset_source","pcs${i}_reset_source");
//
// &FORCE("wire", "pcs${i}_resetn_new");
// : assign pcs0_resetn = pcs0_resetn_new & ~smu_sw_rst;
//

// for (my $i = 1; $i < $pcs_count; $i++) {
//	&FORCE("input", "pcs${i}_wakeup_event[31:1]"); 
//	&FORCE("output", "pcs${i}_int");
//	&FORCE("output", "pcs${i}_wakeup");
//	&FORCE("output", "pcs${i}_standby_req");
//	&FORCE("input", "pcs${i}_standby_ok");
//	&FORCE("output", "pcs${i}_frq_scale_req");
//	&FORCE("output", "pcs${i}_frq_scale[2:0]");
//	&FORCE("output", "pcs${i}_frq_clkon[31:0]");	  
//	&FORCE("input", "pcs${i}_frq_scale_ack");
//	&FORCE("output", "pcs${i}_vol_scale_req");
//	&FORCE("output", "pcs${i}_vol_scale[2:0]");
//	&FORCE("input", "pcs${i}_vol_scale_ack");
//	&FORCE("output", "pcs${i}_iso");
//	&FORCE("output", "pcs${i}_reten");
//	&FORCE("output", "pcs${i}_resetn");
//	&FORCE("output", "pcs${i}_mem_init[3:0]");	  
//	&FORCE("input", "pcs${i}_reset_source[4:0]");
//	&INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcsmu100/hdl/atcsmu100_pcs.v",      "smu_pcs${i}");
//		&CONNECT("smu_pcs${i}.pcs_sel", "pcs_sel[$i]");
//		&CONNECT("smu_pcs${i}.pcs_rdata","pcs${i}_rdata");
//		&CONNECT("smu_pcs${i}.pcs_wakeup_event","pcs${i}_wakeup_event");
//		&CONNECT("smu_pcs${i}.pcs_int","pcs${i}_int");
//		&CONNECT("smu_pcs${i}.pcs_wakeup","pcs${i}_wakeup");
//		&CONNECT("smu_pcs${i}.pcs_standby_req","pcs${i}_standby_req");
//		&CONNECT("smu_pcs${i}.pcs_standby_ok","pcs${i}_standby_ok");
//		&CONNECT("smu_pcs${i}.pcs_frq_scale_req","pcs${i}_frq_scale_req");
//		&CONNECT("smu_pcs${i}.pcs_frq_scale","pcs${i}_frq_scale");
//		&CONNECT("smu_pcs${i}.pcs_frq_clkon","pcs${i}_frq_clkon");
//		&CONNECT("smu_pcs${i}.pcs_frq_scale_ack","pcs${i}_frq_scale_ack");
//		&CONNECT("smu_pcs${i}.pcs_vol_scale_req","pcs${i}_vol_scale_req");
//		&CONNECT("smu_pcs${i}.pcs_vol_scale","pcs${i}_vol_scale");
//		&CONNECT("smu_pcs${i}.pcs_vol_scale_ack","pcs${i}_vol_scale_ack");
//		&CONNECT("smu_pcs${i}.pcs_iso","pcs${i}_iso");
//		&CONNECT("smu_pcs${i}.pcs_reten","pcs${i}_reten");
//		&CONNECT("smu_pcs${i}.pcs_resetn","pcs${i}_resetn");
//		&CONNECT("smu_pcs${i}.pcs_mem_init","pcs${i}_mem_init");
//		&CONNECT("smu_pcs${i}.pcs_reset_source","pcs${i}_reset_source");
// }

// :`ifdef NDS_ILA_SMU
// :	defparam smu_pcs0.ILA_ON = 0;
// :	defparam smu_pcs1.ILA_ON = 0;
// :	defparam smu_pcs2.ILA_ON = 0;
// :	defparam smu_pcs3.ILA_ON = 1;
// :	defparam smu_pcs4.ILA_ON = 1;
// :	defparam smu_pcs5.ILA_ON = 0;
// :	defparam smu_pcs6.ILA_ON = 0;
// :`endif // NDS_ILA_SMU

// :`ifdef NDS_BOARD_CF1
// :assign paddr_12_2 = paddr[12:2];
// :`else	// !NDS_BOARD_CF1
// :assign paddr_12_2 = {3'b0, paddr[9:2]};
// :`endif	// !NDS_BOARD_CF1
//
// for ($i = $pcs_count; $i < 8; $i++) {
// 	&FORCE("supply0", "pcs${i}_rdata");
// }
// &ENDMODULE
// VPERL_END

// VPERL_GENERATED_BEGIN
module atcsmu100 (
`ifdef NDS_BOARD_CF1
	  paddr,              // () <= ()
	  cf1_pinmux_ctrl0,   // (smu_apbif) => ()
	  cf1_pinmux_ctrl1,   // (smu_apbif) => ()
`else
	  paddr,              // () <= ()
`endif // NDS_BOARD_CF1
`ifdef NDS_FPGA
   `ifdef AE350_DDR_LATENCY
	  ddr3_bw_ctrl,       // (smu_apbif) => ()
	  ddr3_latency,       // (smu_apbif) => ()
   `endif // AE350_DDR_LATENCY
`endif // NDS_FPGA
	  pcs0_resetn,        // () => ()
	  core_reset_vectors, // (smu_apbif) => ()
	  mpd_por_rstn,       // (smu_apbif) <= ()
	  penable,            // (smu_apbif) <= ()
	  prdata,             // (smu_apbif) => ()
	  pready,             // (smu_apbif) => ()
	  psel,               // (smu_apbif) <= ()
	  pslverr,            // (smu_apbif) => ()
	  pwdata,             // (smu_apbif) <= ()
	  pwrite,             // (smu_apbif) <= ()
	  system_clock_ratio, // (smu_apbif) => ()
	  pcs0_reset_source,  // (smu_apbif,smu_pcs0) <= ()
	  pclk,               // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	  presetn,            // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	  pcs1_reset_source,  // (smu_apbif,smu_pcs1) <= ()
	  pcs2_reset_source,  // (smu_apbif,smu_pcs2) <= ()
	  pcs3_reset_source,  // (smu_apbif,smu_pcs3) <= ()
	  pcs4_reset_source,  // (smu_apbif,smu_pcs4) <= ()
	  pcs5_reset_source,  // (smu_apbif,smu_pcs5) <= ()
	  pcs6_reset_source,  // (smu_apbif,smu_pcs6) <= ()
	  pcs0_frq_clkon,     // (smu_pcs0) => ()
	  pcs0_frq_scale,     // (smu_pcs0) => ()
	  pcs0_frq_scale_ack, // (smu_pcs0) <= ()
	  pcs0_frq_scale_req, // (smu_pcs0) => ()
	  pcs0_int,           // (smu_pcs0) => ()
	  pcs0_iso,           // (smu_pcs0) => ()
	  pcs0_mem_init,      // (smu_pcs0) => ()
	  pcs0_reten,         // (smu_pcs0) => ()
	  pcs0_standby_ok,    // (smu_pcs0) <= ()
	  pcs0_standby_req,   // (smu_pcs0) => ()
	  pcs0_vol_scale,     // (smu_pcs0) => ()
	  pcs0_vol_scale_ack, // (smu_pcs0) <= ()
	  pcs0_vol_scale_req, // (smu_pcs0) => ()
	  pcs0_wakeup,        // (smu_pcs0) => ()
	  pcs0_wakeup_event,  // (smu_pcs0) <= ()
	  pcs1_frq_clkon,     // (smu_pcs1) => ()
	  pcs1_frq_scale,     // (smu_pcs1) => ()
	  pcs1_frq_scale_ack, // (smu_pcs1) <= ()
	  pcs1_frq_scale_req, // (smu_pcs1) => ()
	  pcs1_int,           // (smu_pcs1) => ()
	  pcs1_iso,           // (smu_pcs1) => ()
	  pcs1_mem_init,      // (smu_pcs1) => ()
	  pcs1_resetn,        // (smu_pcs1) => ()
	  pcs1_reten,         // (smu_pcs1) => ()
	  pcs1_standby_ok,    // (smu_pcs1) <= ()
	  pcs1_standby_req,   // (smu_pcs1) => ()
	  pcs1_vol_scale,     // (smu_pcs1) => ()
	  pcs1_vol_scale_ack, // (smu_pcs1) <= ()
	  pcs1_vol_scale_req, // (smu_pcs1) => ()
	  pcs1_wakeup,        // (smu_pcs1) => ()
	  pcs1_wakeup_event,  // (smu_pcs1) <= ()
	  pcs2_frq_clkon,     // (smu_pcs2) => ()
	  pcs2_frq_scale,     // (smu_pcs2) => ()
	  pcs2_frq_scale_ack, // (smu_pcs2) <= ()
	  pcs2_frq_scale_req, // (smu_pcs2) => ()
	  pcs2_int,           // (smu_pcs2) => ()
	  pcs2_iso,           // (smu_pcs2) => ()
	  pcs2_mem_init,      // (smu_pcs2) => ()
	  pcs2_resetn,        // (smu_pcs2) => ()
	  pcs2_reten,         // (smu_pcs2) => ()
	  pcs2_standby_ok,    // (smu_pcs2) <= ()
	  pcs2_standby_req,   // (smu_pcs2) => ()
	  pcs2_vol_scale,     // (smu_pcs2) => ()
	  pcs2_vol_scale_ack, // (smu_pcs2) <= ()
	  pcs2_vol_scale_req, // (smu_pcs2) => ()
	  pcs2_wakeup,        // (smu_pcs2) => ()
	  pcs2_wakeup_event,  // (smu_pcs2) <= ()
	  pcs3_frq_clkon,     // (smu_pcs3) => ()
	  pcs3_frq_scale,     // (smu_pcs3) => ()
	  pcs3_frq_scale_ack, // (smu_pcs3) <= ()
	  pcs3_frq_scale_req, // (smu_pcs3) => ()
	  pcs3_int,           // (smu_pcs3) => ()
	  pcs3_iso,           // (smu_pcs3) => ()
	  pcs3_mem_init,      // (smu_pcs3) => ()
	  pcs3_resetn,        // (smu_pcs3) => ()
	  pcs3_reten,         // (smu_pcs3) => ()
	  pcs3_standby_ok,    // (smu_pcs3) <= ()
	  pcs3_standby_req,   // (smu_pcs3) => ()
	  pcs3_vol_scale,     // (smu_pcs3) => ()
	  pcs3_vol_scale_ack, // (smu_pcs3) <= ()
	  pcs3_vol_scale_req, // (smu_pcs3) => ()
	  pcs3_wakeup,        // (smu_pcs3) => ()
	  pcs3_wakeup_event,  // (smu_pcs3) <= ()
	  pcs4_frq_clkon,     // (smu_pcs4) => ()
	  pcs4_frq_scale,     // (smu_pcs4) => ()
	  pcs4_frq_scale_ack, // (smu_pcs4) <= ()
	  pcs4_frq_scale_req, // (smu_pcs4) => ()
	  pcs4_int,           // (smu_pcs4) => ()
	  pcs4_iso,           // (smu_pcs4) => ()
	  pcs4_mem_init,      // (smu_pcs4) => ()
	  pcs4_resetn,        // (smu_pcs4) => ()
	  pcs4_reten,         // (smu_pcs4) => ()
	  pcs4_standby_ok,    // (smu_pcs4) <= ()
	  pcs4_standby_req,   // (smu_pcs4) => ()
	  pcs4_vol_scale,     // (smu_pcs4) => ()
	  pcs4_vol_scale_ack, // (smu_pcs4) <= ()
	  pcs4_vol_scale_req, // (smu_pcs4) => ()
	  pcs4_wakeup,        // (smu_pcs4) => ()
	  pcs4_wakeup_event,  // (smu_pcs4) <= ()
	  pcs5_frq_clkon,     // (smu_pcs5) => ()
	  pcs5_frq_scale,     // (smu_pcs5) => ()
	  pcs5_frq_scale_ack, // (smu_pcs5) <= ()
	  pcs5_frq_scale_req, // (smu_pcs5) => ()
	  pcs5_int,           // (smu_pcs5) => ()
	  pcs5_iso,           // (smu_pcs5) => ()
	  pcs5_mem_init,      // (smu_pcs5) => ()
	  pcs5_resetn,        // (smu_pcs5) => ()
	  pcs5_reten,         // (smu_pcs5) => ()
	  pcs5_standby_ok,    // (smu_pcs5) <= ()
	  pcs5_standby_req,   // (smu_pcs5) => ()
	  pcs5_vol_scale,     // (smu_pcs5) => ()
	  pcs5_vol_scale_ack, // (smu_pcs5) <= ()
	  pcs5_vol_scale_req, // (smu_pcs5) => ()
	  pcs5_wakeup,        // (smu_pcs5) => ()
	  pcs5_wakeup_event,  // (smu_pcs5) <= ()
	  pcs6_frq_clkon,     // (smu_pcs6) => ()
	  pcs6_frq_scale,     // (smu_pcs6) => ()
	  pcs6_frq_scale_ack, // (smu_pcs6) <= ()
	  pcs6_frq_scale_req, // (smu_pcs6) => ()
	  pcs6_int,           // (smu_pcs6) => ()
	  pcs6_iso,           // (smu_pcs6) => ()
	  pcs6_mem_init,      // (smu_pcs6) => ()
	  pcs6_resetn,        // (smu_pcs6) => ()
	  pcs6_reten,         // (smu_pcs6) => ()
	  pcs6_standby_ok,    // (smu_pcs6) <= ()
	  pcs6_standby_req,   // (smu_pcs6) => ()
	  pcs6_vol_scale,     // (smu_pcs6) => ()
	  pcs6_vol_scale_ack, // (smu_pcs6) <= ()
	  pcs6_vol_scale_req, // (smu_pcs6) => ()
	  pcs6_wakeup,        // (smu_pcs6) => ()
	  pcs6_wakeup_event   // (smu_pcs6) <= ()
);

parameter PCS_NUM = 7;

`ifdef NDS_BOARD_CF1
input        [12:2] paddr;
output       [31:0] cf1_pinmux_ctrl0;
output       [31:0] cf1_pinmux_ctrl1;
`else
input         [9:2] paddr;
`endif // NDS_BOARD_CF1
`ifdef NDS_FPGA
   `ifdef AE350_DDR_LATENCY
output        [1:0] ddr3_bw_ctrl;
output        [3:0] ddr3_latency;
   `endif // AE350_DDR_LATENCY
`endif // NDS_FPGA
output              pcs0_resetn;
output      [255:0] core_reset_vectors;  // = 64*4-1
input               mpd_por_rstn;        // reset_vector
input               penable;
output       [31:0] prdata;
output              pready;
input               psel;
output              pslverr;
input        [31:0] pwdata;
input               pwrite;
output        [4:0] system_clock_ratio;
input         [4:0] pcs0_reset_source;
input               pclk;
input               presetn;
input         [4:0] pcs1_reset_source;
input         [4:0] pcs2_reset_source;
input         [4:0] pcs3_reset_source;
input         [4:0] pcs4_reset_source;
input         [4:0] pcs5_reset_source;
input         [4:0] pcs6_reset_source;
output       [31:0] pcs0_frq_clkon;      // reserved for PLS
output        [2:0] pcs0_frq_scale;
input               pcs0_frq_scale_ack;
output              pcs0_frq_scale_req;
output              pcs0_int;
output              pcs0_iso;
output        [3:0] pcs0_mem_init;       // was icache_disable_init, dcache_disable_init
output              pcs0_reten;
input               pcs0_standby_ok;
output              pcs0_standby_req;
output        [2:0] pcs0_vol_scale;
input               pcs0_vol_scale_ack;
output              pcs0_vol_scale_req;
output              pcs0_wakeup;
input        [31:1] pcs0_wakeup_event;   // Level trigger
output       [31:0] pcs1_frq_clkon;      // reserved for PLS
output        [2:0] pcs1_frq_scale;
input               pcs1_frq_scale_ack;
output              pcs1_frq_scale_req;
output              pcs1_int;
output              pcs1_iso;
output        [3:0] pcs1_mem_init;       // was icache_disable_init, dcache_disable_init
output              pcs1_resetn;
output              pcs1_reten;
input               pcs1_standby_ok;
output              pcs1_standby_req;
output        [2:0] pcs1_vol_scale;
input               pcs1_vol_scale_ack;
output              pcs1_vol_scale_req;
output              pcs1_wakeup;
input        [31:1] pcs1_wakeup_event;   // Level trigger
output       [31:0] pcs2_frq_clkon;      // reserved for PLS
output        [2:0] pcs2_frq_scale;
input               pcs2_frq_scale_ack;
output              pcs2_frq_scale_req;
output              pcs2_int;
output              pcs2_iso;
output        [3:0] pcs2_mem_init;       // was icache_disable_init, dcache_disable_init
output              pcs2_resetn;
output              pcs2_reten;
input               pcs2_standby_ok;
output              pcs2_standby_req;
output        [2:0] pcs2_vol_scale;
input               pcs2_vol_scale_ack;
output              pcs2_vol_scale_req;
output              pcs2_wakeup;
input        [31:1] pcs2_wakeup_event;   // Level trigger
output       [31:0] pcs3_frq_clkon;      // reserved for PLS
output        [2:0] pcs3_frq_scale;
input               pcs3_frq_scale_ack;
output              pcs3_frq_scale_req;
output              pcs3_int;
output              pcs3_iso;
output        [3:0] pcs3_mem_init;       // was icache_disable_init, dcache_disable_init
output              pcs3_resetn;
output              pcs3_reten;
input               pcs3_standby_ok;
output              pcs3_standby_req;
output        [2:0] pcs3_vol_scale;
input               pcs3_vol_scale_ack;
output              pcs3_vol_scale_req;
output              pcs3_wakeup;
input        [31:1] pcs3_wakeup_event;   // Level trigger
output       [31:0] pcs4_frq_clkon;      // reserved for PLS
output        [2:0] pcs4_frq_scale;
input               pcs4_frq_scale_ack;
output              pcs4_frq_scale_req;
output              pcs4_int;
output              pcs4_iso;
output        [3:0] pcs4_mem_init;       // was icache_disable_init, dcache_disable_init
output              pcs4_resetn;
output              pcs4_reten;
input               pcs4_standby_ok;
output              pcs4_standby_req;
output        [2:0] pcs4_vol_scale;
input               pcs4_vol_scale_ack;
output              pcs4_vol_scale_req;
output              pcs4_wakeup;
input        [31:1] pcs4_wakeup_event;   // Level trigger
output       [31:0] pcs5_frq_clkon;      // reserved for PLS
output        [2:0] pcs5_frq_scale;
input               pcs5_frq_scale_ack;
output              pcs5_frq_scale_req;
output              pcs5_int;
output              pcs5_iso;
output        [3:0] pcs5_mem_init;       // was icache_disable_init, dcache_disable_init
output              pcs5_resetn;
output              pcs5_reten;
input               pcs5_standby_ok;
output              pcs5_standby_req;
output        [2:0] pcs5_vol_scale;
input               pcs5_vol_scale_ack;
output              pcs5_vol_scale_req;
output              pcs5_wakeup;
input        [31:1] pcs5_wakeup_event;   // Level trigger
output       [31:0] pcs6_frq_clkon;      // reserved for PLS
output        [2:0] pcs6_frq_scale;
input               pcs6_frq_scale_ack;
output              pcs6_frq_scale_req;
output              pcs6_int;
output              pcs6_iso;
output        [3:0] pcs6_mem_init;       // was icache_disable_init, dcache_disable_init
output              pcs6_resetn;
output              pcs6_reten;
input               pcs6_standby_ok;
output              pcs6_standby_req;
output        [2:0] pcs6_vol_scale;
input               pcs6_vol_scale_ack;
output              pcs6_vol_scale_req;
output              pcs6_wakeup;
input        [31:1] pcs6_wakeup_event;   // Level trigger

wire         [12:2] paddr_12_2; // dangler: () <= ()
wire         [31:0] pcs7_rdata = 32'b0;
wire          [7:0] pcs_sel;
wire                pcs_sel_cer;
wire                pcs_sel_cfg;
wire                pcs_sel_ctl;
wire                pcs_sel_misc;
wire                pcs_sel_misc2;
wire                pcs_sel_scratch;
wire                pcs_sel_status;
wire                pcs_sel_we;
wire         [31:0] pcs_wdata;
wire                pcs_write;
wire                smu_sw_rst;
wire         [31:0] pcs0_rdata;
wire                pcs0_resetn_new;
wire         [31:0] pcs1_rdata;
wire         [31:0] pcs2_rdata;
wire         [31:0] pcs3_rdata;
wire         [31:0] pcs4_rdata;
wire         [31:0] pcs5_rdata;
wire         [31:0] pcs6_rdata;

assign pcs0_resetn = pcs0_resetn_new & ~smu_sw_rst;
`ifdef NDS_ILA_SMU
	defparam smu_pcs0.ILA_ON = 0;
	defparam smu_pcs1.ILA_ON = 0;
	defparam smu_pcs2.ILA_ON = 0;
	defparam smu_pcs3.ILA_ON = 1;
	defparam smu_pcs4.ILA_ON = 1;
	defparam smu_pcs5.ILA_ON = 0;
	defparam smu_pcs6.ILA_ON = 0;
`endif // NDS_ILA_SMU
`ifdef NDS_BOARD_CF1
assign paddr_12_2 = paddr[12:2];
`else	// !NDS_BOARD_CF1
assign paddr_12_2 = {3'b0, paddr[9:2]};
`endif	// !NDS_BOARD_CF1

atcsmu100_apbif #(
	.PCS_NUM         (PCS_NUM         )
) smu_apbif (
	.mpd_por_rstn      (mpd_por_rstn      ), // (smu_apbif) <= ()
	.pclk              (pclk              ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.presetn           (presetn           ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.psel              (psel              ), // (smu_apbif) <= ()
	.penable           (penable           ), // (smu_apbif) <= ()
	.paddr             (paddr_12_2        ), // (smu_apbif) <= ()
	.pwdata            (pwdata            ), // (smu_apbif) <= ()
	.pwrite            (pwrite            ), // (smu_apbif) <= ()
	.prdata            (prdata            ), // (smu_apbif) => ()
	.pready            (pready            ), // (smu_apbif) => ()
	.pslverr           (pslverr           ), // (smu_apbif) => ()
	.pcs0_rdata        (pcs0_rdata        ), // (smu_apbif) <= (smu_pcs0)
	.pcs1_rdata        (pcs1_rdata        ), // (smu_apbif) <= (smu_pcs1)
	.pcs2_rdata        (pcs2_rdata        ), // (smu_apbif) <= (smu_pcs2)
	.pcs3_rdata        (pcs3_rdata        ), // (smu_apbif) <= (smu_pcs3)
	.pcs4_rdata        (pcs4_rdata        ), // (smu_apbif) <= (smu_pcs4)
	.pcs5_rdata        (pcs5_rdata        ), // (smu_apbif) <= (smu_pcs5)
	.pcs6_rdata        (pcs6_rdata        ), // (smu_apbif) <= (smu_pcs6)
	.pcs7_rdata        (pcs7_rdata        ), // (smu_apbif) <= ()
	.pcs0_reset_source (pcs0_reset_source ), // (smu_apbif,smu_pcs0) <= ()
	.pcs1_reset_source (pcs1_reset_source ), // (smu_apbif,smu_pcs1) <= ()
	.pcs2_reset_source (pcs2_reset_source ), // (smu_apbif,smu_pcs2) <= ()
	.pcs3_reset_source (pcs3_reset_source ), // (smu_apbif,smu_pcs3) <= ()
	.pcs4_reset_source (pcs4_reset_source ), // (smu_apbif,smu_pcs4) <= ()
	.pcs5_reset_source (pcs5_reset_source ), // (smu_apbif,smu_pcs5) <= ()
	.pcs6_reset_source (pcs6_reset_source ), // (smu_apbif,smu_pcs6) <= ()
	.pcs_sel           (pcs_sel           ), // (smu_apbif) => (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6)
	.pcs_wdata         (pcs_wdata         ), // (smu_apbif) => (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6)
	.pcs_write         (pcs_write         ), // (smu_apbif) => (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6)
	.pcs_sel_cfg       (pcs_sel_cfg       ), // (smu_apbif) => (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6)
	.pcs_sel_scratch   (pcs_sel_scratch   ), // (smu_apbif) => (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6)
	.pcs_sel_misc      (pcs_sel_misc      ), // (smu_apbif) => (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6)
	.pcs_sel_misc2     (pcs_sel_misc2     ), // (smu_apbif) => (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6)
	.pcs_sel_we        (pcs_sel_we        ), // (smu_apbif) => (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6)
	.pcs_sel_ctl       (pcs_sel_ctl       ), // (smu_apbif) => (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6)
	.pcs_sel_status    (pcs_sel_status    ), // (smu_apbif) => (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6)
	.pcs_sel_cer       (pcs_sel_cer       ), // (smu_apbif) => (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6)
`ifdef NDS_FPGA
   `ifdef AE350_DDR_LATENCY
	.ddr3_latency      (ddr3_latency      ), // (smu_apbif) => ()
	.ddr3_bw_ctrl      (ddr3_bw_ctrl      ), // (smu_apbif) => ()
   `endif // AE350_DDR_LATENCY
`endif // NDS_FPGA
	.smu_sw_rst        (smu_sw_rst        ), // (smu_apbif) => ()
	.core_reset_vectors(core_reset_vectors), // (smu_apbif) => ()
`ifdef NDS_BOARD_CF1
	.cf1_pinmux_ctrl0  (cf1_pinmux_ctrl0  ), // (smu_apbif) => ()
	.cf1_pinmux_ctrl1  (cf1_pinmux_ctrl1  ), // (smu_apbif) => ()
`endif // NDS_BOARD_CF1
	.system_clock_ratio(system_clock_ratio)  // (smu_apbif) => ()
); // end of smu_apbif

atcsmu100_pcs smu_pcs0 (
	.pclk             (pclk              ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.presetn          (presetn           ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.pcs_rdata        (pcs0_rdata        ), // (smu_pcs0) => (smu_apbif)
	.pcs_sel          (pcs_sel[0]        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wdata        (pcs_wdata         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_write        (pcs_write         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cfg      (pcs_sel_cfg       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_scratch  (pcs_sel_scratch   ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc     (pcs_sel_misc      ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc2    (pcs_sel_misc2     ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_we       (pcs_sel_we        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_ctl      (pcs_sel_ctl       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_status   (pcs_sel_status    ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cer      (pcs_sel_cer       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wakeup_event (pcs0_wakeup_event ), // (smu_pcs0) <= ()
	.pcs_int          (pcs0_int          ), // (smu_pcs0) => ()
	.pcs_wakeup       (pcs0_wakeup       ), // (smu_pcs0) => ()
	.pcs_standby_req  (pcs0_standby_req  ), // (smu_pcs0) => ()
	.pcs_standby_ok   (pcs0_standby_ok   ), // (smu_pcs0) <= ()
	.pcs_frq_scale_req(pcs0_frq_scale_req), // (smu_pcs0) => ()
	.pcs_frq_scale    (pcs0_frq_scale    ), // (smu_pcs0) => ()
	.pcs_frq_clkon    (pcs0_frq_clkon    ), // (smu_pcs0) => ()
	.pcs_frq_scale_ack(pcs0_frq_scale_ack), // (smu_pcs0) <= ()
	.pcs_vol_scale_req(pcs0_vol_scale_req), // (smu_pcs0) => ()
	.pcs_vol_scale    (pcs0_vol_scale    ), // (smu_pcs0) => ()
	.pcs_vol_scale_ack(pcs0_vol_scale_ack), // (smu_pcs0) <= ()
	.pcs_iso          (pcs0_iso          ), // (smu_pcs0) => ()
	.pcs_reten        (pcs0_reten        ), // (smu_pcs0) => ()
	.pcs_resetn       (pcs0_resetn_new   ), // (smu_pcs0) => ()
	.pcs_mem_init     (pcs0_mem_init     ), // (smu_pcs0) => ()
	.pcs_reset_source (pcs0_reset_source )  // (smu_apbif,smu_pcs0) <= ()
); // end of smu_pcs0

atcsmu100_pcs smu_pcs1 (
	.pclk             (pclk              ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.presetn          (presetn           ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.pcs_rdata        (pcs1_rdata        ), // (smu_pcs1) => (smu_apbif)
	.pcs_sel          (pcs_sel[1]        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wdata        (pcs_wdata         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_write        (pcs_write         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cfg      (pcs_sel_cfg       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_scratch  (pcs_sel_scratch   ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc     (pcs_sel_misc      ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc2    (pcs_sel_misc2     ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_we       (pcs_sel_we        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_ctl      (pcs_sel_ctl       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_status   (pcs_sel_status    ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cer      (pcs_sel_cer       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wakeup_event (pcs1_wakeup_event ), // (smu_pcs1) <= ()
	.pcs_int          (pcs1_int          ), // (smu_pcs1) => ()
	.pcs_wakeup       (pcs1_wakeup       ), // (smu_pcs1) => ()
	.pcs_standby_req  (pcs1_standby_req  ), // (smu_pcs1) => ()
	.pcs_standby_ok   (pcs1_standby_ok   ), // (smu_pcs1) <= ()
	.pcs_frq_scale_req(pcs1_frq_scale_req), // (smu_pcs1) => ()
	.pcs_frq_scale    (pcs1_frq_scale    ), // (smu_pcs1) => ()
	.pcs_frq_clkon    (pcs1_frq_clkon    ), // (smu_pcs1) => ()
	.pcs_frq_scale_ack(pcs1_frq_scale_ack), // (smu_pcs1) <= ()
	.pcs_vol_scale_req(pcs1_vol_scale_req), // (smu_pcs1) => ()
	.pcs_vol_scale    (pcs1_vol_scale    ), // (smu_pcs1) => ()
	.pcs_vol_scale_ack(pcs1_vol_scale_ack), // (smu_pcs1) <= ()
	.pcs_iso          (pcs1_iso          ), // (smu_pcs1) => ()
	.pcs_reten        (pcs1_reten        ), // (smu_pcs1) => ()
	.pcs_resetn       (pcs1_resetn       ), // (smu_pcs1) => ()
	.pcs_mem_init     (pcs1_mem_init     ), // (smu_pcs1) => ()
	.pcs_reset_source (pcs1_reset_source )  // (smu_apbif,smu_pcs1) <= ()
); // end of smu_pcs1

atcsmu100_pcs smu_pcs2 (
	.pclk             (pclk              ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.presetn          (presetn           ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.pcs_rdata        (pcs2_rdata        ), // (smu_pcs2) => (smu_apbif)
	.pcs_sel          (pcs_sel[2]        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wdata        (pcs_wdata         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_write        (pcs_write         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cfg      (pcs_sel_cfg       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_scratch  (pcs_sel_scratch   ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc     (pcs_sel_misc      ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc2    (pcs_sel_misc2     ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_we       (pcs_sel_we        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_ctl      (pcs_sel_ctl       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_status   (pcs_sel_status    ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cer      (pcs_sel_cer       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wakeup_event (pcs2_wakeup_event ), // (smu_pcs2) <= ()
	.pcs_int          (pcs2_int          ), // (smu_pcs2) => ()
	.pcs_wakeup       (pcs2_wakeup       ), // (smu_pcs2) => ()
	.pcs_standby_req  (pcs2_standby_req  ), // (smu_pcs2) => ()
	.pcs_standby_ok   (pcs2_standby_ok   ), // (smu_pcs2) <= ()
	.pcs_frq_scale_req(pcs2_frq_scale_req), // (smu_pcs2) => ()
	.pcs_frq_scale    (pcs2_frq_scale    ), // (smu_pcs2) => ()
	.pcs_frq_clkon    (pcs2_frq_clkon    ), // (smu_pcs2) => ()
	.pcs_frq_scale_ack(pcs2_frq_scale_ack), // (smu_pcs2) <= ()
	.pcs_vol_scale_req(pcs2_vol_scale_req), // (smu_pcs2) => ()
	.pcs_vol_scale    (pcs2_vol_scale    ), // (smu_pcs2) => ()
	.pcs_vol_scale_ack(pcs2_vol_scale_ack), // (smu_pcs2) <= ()
	.pcs_iso          (pcs2_iso          ), // (smu_pcs2) => ()
	.pcs_reten        (pcs2_reten        ), // (smu_pcs2) => ()
	.pcs_resetn       (pcs2_resetn       ), // (smu_pcs2) => ()
	.pcs_mem_init     (pcs2_mem_init     ), // (smu_pcs2) => ()
	.pcs_reset_source (pcs2_reset_source )  // (smu_apbif,smu_pcs2) <= ()
); // end of smu_pcs2

atcsmu100_pcs smu_pcs3 (
	.pclk             (pclk              ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.presetn          (presetn           ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.pcs_rdata        (pcs3_rdata        ), // (smu_pcs3) => (smu_apbif)
	.pcs_sel          (pcs_sel[3]        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wdata        (pcs_wdata         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_write        (pcs_write         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cfg      (pcs_sel_cfg       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_scratch  (pcs_sel_scratch   ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc     (pcs_sel_misc      ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc2    (pcs_sel_misc2     ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_we       (pcs_sel_we        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_ctl      (pcs_sel_ctl       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_status   (pcs_sel_status    ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cer      (pcs_sel_cer       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wakeup_event (pcs3_wakeup_event ), // (smu_pcs3) <= ()
	.pcs_int          (pcs3_int          ), // (smu_pcs3) => ()
	.pcs_wakeup       (pcs3_wakeup       ), // (smu_pcs3) => ()
	.pcs_standby_req  (pcs3_standby_req  ), // (smu_pcs3) => ()
	.pcs_standby_ok   (pcs3_standby_ok   ), // (smu_pcs3) <= ()
	.pcs_frq_scale_req(pcs3_frq_scale_req), // (smu_pcs3) => ()
	.pcs_frq_scale    (pcs3_frq_scale    ), // (smu_pcs3) => ()
	.pcs_frq_clkon    (pcs3_frq_clkon    ), // (smu_pcs3) => ()
	.pcs_frq_scale_ack(pcs3_frq_scale_ack), // (smu_pcs3) <= ()
	.pcs_vol_scale_req(pcs3_vol_scale_req), // (smu_pcs3) => ()
	.pcs_vol_scale    (pcs3_vol_scale    ), // (smu_pcs3) => ()
	.pcs_vol_scale_ack(pcs3_vol_scale_ack), // (smu_pcs3) <= ()
	.pcs_iso          (pcs3_iso          ), // (smu_pcs3) => ()
	.pcs_reten        (pcs3_reten        ), // (smu_pcs3) => ()
	.pcs_resetn       (pcs3_resetn       ), // (smu_pcs3) => ()
	.pcs_mem_init     (pcs3_mem_init     ), // (smu_pcs3) => ()
	.pcs_reset_source (pcs3_reset_source )  // (smu_apbif,smu_pcs3) <= ()
); // end of smu_pcs3

atcsmu100_pcs smu_pcs4 (
	.pclk             (pclk              ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.presetn          (presetn           ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.pcs_rdata        (pcs4_rdata        ), // (smu_pcs4) => (smu_apbif)
	.pcs_sel          (pcs_sel[4]        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wdata        (pcs_wdata         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_write        (pcs_write         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cfg      (pcs_sel_cfg       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_scratch  (pcs_sel_scratch   ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc     (pcs_sel_misc      ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc2    (pcs_sel_misc2     ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_we       (pcs_sel_we        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_ctl      (pcs_sel_ctl       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_status   (pcs_sel_status    ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cer      (pcs_sel_cer       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wakeup_event (pcs4_wakeup_event ), // (smu_pcs4) <= ()
	.pcs_int          (pcs4_int          ), // (smu_pcs4) => ()
	.pcs_wakeup       (pcs4_wakeup       ), // (smu_pcs4) => ()
	.pcs_standby_req  (pcs4_standby_req  ), // (smu_pcs4) => ()
	.pcs_standby_ok   (pcs4_standby_ok   ), // (smu_pcs4) <= ()
	.pcs_frq_scale_req(pcs4_frq_scale_req), // (smu_pcs4) => ()
	.pcs_frq_scale    (pcs4_frq_scale    ), // (smu_pcs4) => ()
	.pcs_frq_clkon    (pcs4_frq_clkon    ), // (smu_pcs4) => ()
	.pcs_frq_scale_ack(pcs4_frq_scale_ack), // (smu_pcs4) <= ()
	.pcs_vol_scale_req(pcs4_vol_scale_req), // (smu_pcs4) => ()
	.pcs_vol_scale    (pcs4_vol_scale    ), // (smu_pcs4) => ()
	.pcs_vol_scale_ack(pcs4_vol_scale_ack), // (smu_pcs4) <= ()
	.pcs_iso          (pcs4_iso          ), // (smu_pcs4) => ()
	.pcs_reten        (pcs4_reten        ), // (smu_pcs4) => ()
	.pcs_resetn       (pcs4_resetn       ), // (smu_pcs4) => ()
	.pcs_mem_init     (pcs4_mem_init     ), // (smu_pcs4) => ()
	.pcs_reset_source (pcs4_reset_source )  // (smu_apbif,smu_pcs4) <= ()
); // end of smu_pcs4

atcsmu100_pcs smu_pcs5 (
	.pclk             (pclk              ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.presetn          (presetn           ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.pcs_rdata        (pcs5_rdata        ), // (smu_pcs5) => (smu_apbif)
	.pcs_sel          (pcs_sel[5]        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wdata        (pcs_wdata         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_write        (pcs_write         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cfg      (pcs_sel_cfg       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_scratch  (pcs_sel_scratch   ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc     (pcs_sel_misc      ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc2    (pcs_sel_misc2     ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_we       (pcs_sel_we        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_ctl      (pcs_sel_ctl       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_status   (pcs_sel_status    ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cer      (pcs_sel_cer       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wakeup_event (pcs5_wakeup_event ), // (smu_pcs5) <= ()
	.pcs_int          (pcs5_int          ), // (smu_pcs5) => ()
	.pcs_wakeup       (pcs5_wakeup       ), // (smu_pcs5) => ()
	.pcs_standby_req  (pcs5_standby_req  ), // (smu_pcs5) => ()
	.pcs_standby_ok   (pcs5_standby_ok   ), // (smu_pcs5) <= ()
	.pcs_frq_scale_req(pcs5_frq_scale_req), // (smu_pcs5) => ()
	.pcs_frq_scale    (pcs5_frq_scale    ), // (smu_pcs5) => ()
	.pcs_frq_clkon    (pcs5_frq_clkon    ), // (smu_pcs5) => ()
	.pcs_frq_scale_ack(pcs5_frq_scale_ack), // (smu_pcs5) <= ()
	.pcs_vol_scale_req(pcs5_vol_scale_req), // (smu_pcs5) => ()
	.pcs_vol_scale    (pcs5_vol_scale    ), // (smu_pcs5) => ()
	.pcs_vol_scale_ack(pcs5_vol_scale_ack), // (smu_pcs5) <= ()
	.pcs_iso          (pcs5_iso          ), // (smu_pcs5) => ()
	.pcs_reten        (pcs5_reten        ), // (smu_pcs5) => ()
	.pcs_resetn       (pcs5_resetn       ), // (smu_pcs5) => ()
	.pcs_mem_init     (pcs5_mem_init     ), // (smu_pcs5) => ()
	.pcs_reset_source (pcs5_reset_source )  // (smu_apbif,smu_pcs5) <= ()
); // end of smu_pcs5

atcsmu100_pcs smu_pcs6 (
	.pclk             (pclk              ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.presetn          (presetn           ), // (smu_apbif,smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= ()
	.pcs_rdata        (pcs6_rdata        ), // (smu_pcs6) => (smu_apbif)
	.pcs_sel          (pcs_sel[6]        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wdata        (pcs_wdata         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_write        (pcs_write         ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cfg      (pcs_sel_cfg       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_scratch  (pcs_sel_scratch   ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc     (pcs_sel_misc      ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_misc2    (pcs_sel_misc2     ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_we       (pcs_sel_we        ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_ctl      (pcs_sel_ctl       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_status   (pcs_sel_status    ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_sel_cer      (pcs_sel_cer       ), // (smu_pcs0,smu_pcs1,smu_pcs2,smu_pcs3,smu_pcs4,smu_pcs5,smu_pcs6) <= (smu_apbif)
	.pcs_wakeup_event (pcs6_wakeup_event ), // (smu_pcs6) <= ()
	.pcs_int          (pcs6_int          ), // (smu_pcs6) => ()
	.pcs_wakeup       (pcs6_wakeup       ), // (smu_pcs6) => ()
	.pcs_standby_req  (pcs6_standby_req  ), // (smu_pcs6) => ()
	.pcs_standby_ok   (pcs6_standby_ok   ), // (smu_pcs6) <= ()
	.pcs_frq_scale_req(pcs6_frq_scale_req), // (smu_pcs6) => ()
	.pcs_frq_scale    (pcs6_frq_scale    ), // (smu_pcs6) => ()
	.pcs_frq_clkon    (pcs6_frq_clkon    ), // (smu_pcs6) => ()
	.pcs_frq_scale_ack(pcs6_frq_scale_ack), // (smu_pcs6) <= ()
	.pcs_vol_scale_req(pcs6_vol_scale_req), // (smu_pcs6) => ()
	.pcs_vol_scale    (pcs6_vol_scale    ), // (smu_pcs6) => ()
	.pcs_vol_scale_ack(pcs6_vol_scale_ack), // (smu_pcs6) <= ()
	.pcs_iso          (pcs6_iso          ), // (smu_pcs6) => ()
	.pcs_reten        (pcs6_reten        ), // (smu_pcs6) => ()
	.pcs_resetn       (pcs6_resetn       ), // (smu_pcs6) => ()
	.pcs_mem_init     (pcs6_mem_init     ), // (smu_pcs6) => ()
	.pcs_reset_source (pcs6_reset_source )  // (smu_apbif,smu_pcs6) <= ()
); // end of smu_pcs6

endmodule
// VPERL_GENERATED_END
