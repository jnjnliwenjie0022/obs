`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

// VPERL_BEGIN
// &MODULE("deadlock_checker");
//      for($i=0;$i<16;$i++) {
//     		&IFDEF("ATCBMC300_MST${i}_SUPPORT");
//     			&FORCE("input", "us${i}_araddr[(`ATCBMC300_ADDR_WIDTH-1):0]");
//     			&FORCE("input", "us${i}_awaddr[(`ATCBMC300_ADDR_WIDTH-1):0]");
//     			&FORCE("input", "us${i}_arvalid");
//     			&FORCE("input", "us${i}_awvalid");
//     			&FORCE("input", "us${i}_arready");
//     			&FORCE("input", "us${i}_awready");
//     			&FORCE("input", "us${i}_rvalid");
//     			&FORCE("input", "us${i}_wvalid");
//     			&FORCE("input", "us${i}_wlast");
//     			&FORCE("input", "us${i}_rlast");
//     			&FORCE("input", "us${i}_bvalid");
//     			&FORCE("input", "us${i}_rready");
//     			&FORCE("input", "us${i}_wready");
//     			&FORCE("input", "us${i}_bready");
//     		&ENDIF;
//      }
//      for($i=1;$i<32;$i++) {
//		&IFDEF("ATCBMC300_SLV${i}_SUPPORT");
//			&FORCE("input", "ds${i}_arvalid");
//			&FORCE("input", "ds${i}_awvalid");
//			&FORCE("input", "ds${i}_rvalid");
//			&FORCE("input", "ds${i}_wvalid");
//			&FORCE("input", "ds${i}_bvalid");
//			&FORCE("input", "ds${i}_arready");
//			&FORCE("input", "ds${i}_awready");
//			&FORCE("input", "ds${i}_rready");
//			&FORCE("input", "ds${i}_wready");
//			&FORCE("input", "ds${i}_bready");
//			&FORCE("input", "ds${i}_wlast");
//			&FORCE("input", "ds${i}_rlast");
//		&ENDIF;
//      }
//		&FORCE("input", "reg_mst0_high_priority");
//		&FORCE("input", "reg_priority_reload[15:0]");
//		&FORCE("input", "aclk");
//		&FORCE("input", "aresetn");
//	&PARAM("MAX_LATENCY=`MAX_LATENCY * 2 * `RMAXLEN + 0");
//	
// # ------------------------------------------------------------
// # constraints to ensure slaves return data promptly
// # ------------------------------------------------------------
//
// #---------------------------------------
// # channel handshaking (Section 3.3 Figure 3-4 and Figure 3-5)
// #---------------------------------------
// # the only required handshake dependencies:
// #
// # read transactions:
// #            (ARVALID & ARREDY)      -->>    RVALID
// #
// # write transactions:
// #            (WVALID & WREADY)       -->>    BVALID
// # -------------------------------------------
//
//      : ASM_reg_mst0_high_priority_fixed: assume property ( @(posedge aclk) disable iff (!aresetn)
//      :                 ##1 $stable(reg_mst0_high_priority));
//      : ASM_reg_priority_reload_fixed: assume property ( @(posedge aclk) disable iff (!aresetn)
//      :                 ##1 $stable(reg_priority_reload) && reg_priority_reload[0]==reg_priority_reload[1] && reg_priority_reload[0]==reg_priority_reload[2]);
//	:
//	
//      : ASM_addr_range_limit: assume property ( @(posedge aclk) disable iff (!aresetn)
//	:		1'b1
//      for ($i=0; $i < 16; $i++) {
//      : `ifdef ATCBMC300_MST${i}_SUPPORT
//	:		&& ((us${i}_araddr[19:0] & 20'hfef00) == 20'h0 && (us${i}_awaddr[19:0] & 20'hfef00) == 20'h0)
//      : `endif
//	}
//	:		);
//      :
//      for ($i=0; $i < 16; $i++) {
//      : `ifdef ATCBMC300_MST${i}_SUPPORT
//	:	reg [2:0]	us${i}_awcnt;
//	:	reg [2:0]	us${i}_wcnt;
//	:	reg [2:0]	us${i}_bcnt;
//	: always @(posedge aclk or negedge aresetn) begin
//	:	if (!aresetn) begin
//	:		us${i}_awcnt <= 3'b0;
//	:	end
//	:	else if (us${i}_awvalid && us${i}_awready) begin
//	:		us${i}_awcnt <= us${i}_awcnt + 3'b1;
//	:	end
//	: end
//	: always @(posedge aclk or negedge aresetn) begin
//	:	if (!aresetn) begin
//	:		us${i}_wcnt <= 3'b0;
//	:	end
//	:	else if (us${i}_wvalid && us${i}_wready && us${i}_wlast) begin
//	:		us${i}_wcnt <= us${i}_wcnt + 3'b1;
//	:	end
//	: end
//	: always @(posedge aclk or negedge aresetn) begin
//	:	if (!aresetn) begin
//	:		us${i}_bcnt <= 3'b0;
//	:	end
//	:	else if (us${i}_bvalid && us${i}_bready) begin
//	:		us${i}_bcnt <= us${i}_bcnt + 3'b1;
//	:	end
//	: end
//	:
//	:	wire us${i}_wvalid_ready = us${i}_wvalid && us${i}_wready && us${i}_wlast;
//	:	wire us${i}_rvalid_ready = us${i}_rvalid && us${i}_rready && us${i}_rlast;
//	:	wire us${i}_awvalid_ready = us${i}_awvalid && us${i}_awready;
//	:	wire us${i}_arvalid_ready = us${i}_arvalid && us${i}_arready;
//	:	wire us${i}_bvalid_ready = us${i}_bvalid && us${i}_bready;
//	:
//      : us${i}_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
//      :                 us${i}_awcnt != us${i}_wcnt |-> ##[1:1+`WMAXLEN*2] us${i}_awcnt == us${i}_wcnt);
//      : `endif
//      }
//
//      for ($i=1; $i < 32; $i++) {
//      :
//      : `ifdef ATCBMC300_SLV${i}_SUPPORT
//	:	reg [2:0]	ds${i}_arcnt;
//	:	reg [2:0]	ds${i}_rcnt;
//	:	reg [2:0]	ds${i}_wcnt;
//	:	reg [2:0]	ds${i}_bcnt;
//	:
//	:	wire ds${i}_wvalid_ready = ds${i}_wvalid && ds${i}_wready && ds${i}_wlast;
//	:	wire ds${i}_rvalid_ready = ds${i}_rvalid && ds${i}_rready && ds${i}_rlast;
//	:	wire ds${i}_awvalid_ready = ds${i}_awvalid && ds${i}_awready;
//	:	wire ds${i}_arvalid_ready = ds${i}_arvalid && ds${i}_arready;
//	:	wire ds${i}_bvalid_ready = ds${i}_bvalid && ds${i}_bready;
//	:
//	: always @(posedge aclk or negedge aresetn) begin
//	:	if (!aresetn) begin
//	:		ds${i}_arcnt <= 3'b0;
//	:	end
//	:	else if (ds${i}_arvalid_ready) begin
//	:		ds${i}_arcnt <= ds${i}_arcnt + 3'b1;
//	:	end
//	: end
//	: always @(posedge aclk or negedge aresetn) begin
//	:	if (!aresetn) begin
//	:		ds${i}_rcnt <= 3'b0;
//	:	end
//	:	else if (ds${i}_rvalid_ready) begin
//	:		ds${i}_rcnt <= ds${i}_rcnt + 3'b1;
//	:	end
//	: end
//	:
//	: always @(posedge aclk or negedge aresetn) begin
//	:	if (!aresetn) begin
//	:		ds${i}_wcnt <= 3'b0;
//	:	end
//	:	else if (ds${i}_wvalid_ready) begin
//	:		ds${i}_wcnt <= ds${i}_wcnt + 3'b1;
//	:	end
//	: end
//	:
//	: always @(posedge aclk or negedge aresetn) begin
//	:	if (!aresetn) begin
//	:		ds${i}_bcnt <= 3'b0;
//	:	end
//	:	else if (ds${i}_bvalid_ready) begin
//	:		ds${i}_bcnt <= ds${i}_bcnt + 3'b1;
//	:	end
//	: end
//	:
//      : ds${i}_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
//      :                 (ds${i}_wcnt != ds${i}_bcnt) |-> ##[1:2] (ds${i}_wcnt == ds${i}_bcnt));
//      : ds${i}_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
//      :                 (ds${i}_arcnt != ds${i}_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds${i}_arcnt == ds${i}_rcnt));
//      : `endif
//      }
//
// # ------------------------------------------------------------
// # deadlock assertions
// # ------------------------------------------------------------
//      $i = 0;
//	ASSERT_MASTER: {
//	:
//     	: `ifdef ATCBMC300_MST${i}_SUPPORT
//	: us${i}_AST_S_WREADY_dead: assert property ( @(posedge aclk) disable iff (!aresetn)
//	:         (us${i}_wvalid && !us${i}_wready) |->  ##[1:MAX_LATENCY] ( us${i}_wready));
//	: 
//	: us${i}_AST_S_AWREADY_dead: assert property ( @(posedge aclk) disable iff (!aresetn)
//	:         (us${i}_awvalid && !us${i}_awready) |->  ##[1:MAX_LATENCY] ( us${i}_awready));
//	: 
//	: us${i}_AST_S_ARREADY_dead: assert property ( @(posedge aclk) disable iff (!aresetn)
//	:         (us${i}_arvalid && !us${i}_arready) |->  ##[1:MAX_LATENCY] ( us${i}_arready));
//     	: `endif
//	}

//	$i = 2;
//	ASSERT_SLAVE: {
//	:
//     	: `ifdef ATCBMC300_SLV${i}_SUPPORT
//	: ds${i}_AST_M_RREADY_dead: assert property ( @(posedge aclk) disable iff (!aresetn)
//	:         (ds${i}_rvalid && !ds${i}_rready) |->  ##[1:MAX_LATENCY] (!ds${i}_rvalid || ds${i}_rready));
//	: 
//	: ds${i}_AST_M_BREADY_dead: assert property ( @(posedge aclk) disable iff (!aresetn)
//	:         (ds${i}_bvalid && !ds${i}_bready) |->  ##[1:MAX_LATENCY] ( ds${i}_bready));
//     	: `endif
//	}
// &ENDMODULE;
// : bind atcbmc300 deadlock_checker deadlock_checker(.*);
// VPERL_END

// VPERL_GENERATED_BEGIN
module deadlock_checker (
`ifdef ATCBMC300_MST0_SUPPORT
	  us0_araddr,             // () <= ()
	  us0_arready,            // () <= ()
	  us0_arvalid,            // () <= ()
	  us0_awaddr,             // () <= ()
	  us0_awready,            // () <= ()
	  us0_awvalid,            // () <= ()
	  us0_bready,             // () <= ()
	  us0_bvalid,             // () <= ()
	  us0_rlast,              // () <= ()
	  us0_rready,             // () <= ()
	  us0_rvalid,             // () <= ()
	  us0_wlast,              // () <= ()
	  us0_wready,             // () <= ()
	  us0_wvalid,             // () <= ()
`endif // ATCBMC300_MST0_SUPPORT
`ifdef ATCBMC300_MST1_SUPPORT
	  us1_araddr,             // () <= ()
	  us1_arready,            // () <= ()
	  us1_arvalid,            // () <= ()
	  us1_awaddr,             // () <= ()
	  us1_awready,            // () <= ()
	  us1_awvalid,            // () <= ()
	  us1_bready,             // () <= ()
	  us1_bvalid,             // () <= ()
	  us1_rlast,              // () <= ()
	  us1_rready,             // () <= ()
	  us1_rvalid,             // () <= ()
	  us1_wlast,              // () <= ()
	  us1_wready,             // () <= ()
	  us1_wvalid,             // () <= ()
`endif // ATCBMC300_MST1_SUPPORT
`ifdef ATCBMC300_MST2_SUPPORT
	  us2_araddr,             // () <= ()
	  us2_arready,            // () <= ()
	  us2_arvalid,            // () <= ()
	  us2_awaddr,             // () <= ()
	  us2_awready,            // () <= ()
	  us2_awvalid,            // () <= ()
	  us2_bready,             // () <= ()
	  us2_bvalid,             // () <= ()
	  us2_rlast,              // () <= ()
	  us2_rready,             // () <= ()
	  us2_rvalid,             // () <= ()
	  us2_wlast,              // () <= ()
	  us2_wready,             // () <= ()
	  us2_wvalid,             // () <= ()
`endif // ATCBMC300_MST2_SUPPORT
`ifdef ATCBMC300_MST3_SUPPORT
	  us3_araddr,             // () <= ()
	  us3_arready,            // () <= ()
	  us3_arvalid,            // () <= ()
	  us3_awaddr,             // () <= ()
	  us3_awready,            // () <= ()
	  us3_awvalid,            // () <= ()
	  us3_bready,             // () <= ()
	  us3_bvalid,             // () <= ()
	  us3_rlast,              // () <= ()
	  us3_rready,             // () <= ()
	  us3_rvalid,             // () <= ()
	  us3_wlast,              // () <= ()
	  us3_wready,             // () <= ()
	  us3_wvalid,             // () <= ()
`endif // ATCBMC300_MST3_SUPPORT
`ifdef ATCBMC300_MST4_SUPPORT
	  us4_araddr,             // () <= ()
	  us4_arready,            // () <= ()
	  us4_arvalid,            // () <= ()
	  us4_awaddr,             // () <= ()
	  us4_awready,            // () <= ()
	  us4_awvalid,            // () <= ()
	  us4_bready,             // () <= ()
	  us4_bvalid,             // () <= ()
	  us4_rlast,              // () <= ()
	  us4_rready,             // () <= ()
	  us4_rvalid,             // () <= ()
	  us4_wlast,              // () <= ()
	  us4_wready,             // () <= ()
	  us4_wvalid,             // () <= ()
`endif // ATCBMC300_MST4_SUPPORT
`ifdef ATCBMC300_MST5_SUPPORT
	  us5_araddr,             // () <= ()
	  us5_arready,            // () <= ()
	  us5_arvalid,            // () <= ()
	  us5_awaddr,             // () <= ()
	  us5_awready,            // () <= ()
	  us5_awvalid,            // () <= ()
	  us5_bready,             // () <= ()
	  us5_bvalid,             // () <= ()
	  us5_rlast,              // () <= ()
	  us5_rready,             // () <= ()
	  us5_rvalid,             // () <= ()
	  us5_wlast,              // () <= ()
	  us5_wready,             // () <= ()
	  us5_wvalid,             // () <= ()
`endif // ATCBMC300_MST5_SUPPORT
`ifdef ATCBMC300_MST6_SUPPORT
	  us6_araddr,             // () <= ()
	  us6_arready,            // () <= ()
	  us6_arvalid,            // () <= ()
	  us6_awaddr,             // () <= ()
	  us6_awready,            // () <= ()
	  us6_awvalid,            // () <= ()
	  us6_bready,             // () <= ()
	  us6_bvalid,             // () <= ()
	  us6_rlast,              // () <= ()
	  us6_rready,             // () <= ()
	  us6_rvalid,             // () <= ()
	  us6_wlast,              // () <= ()
	  us6_wready,             // () <= ()
	  us6_wvalid,             // () <= ()
`endif // ATCBMC300_MST6_SUPPORT
`ifdef ATCBMC300_MST7_SUPPORT
	  us7_araddr,             // () <= ()
	  us7_arready,            // () <= ()
	  us7_arvalid,            // () <= ()
	  us7_awaddr,             // () <= ()
	  us7_awready,            // () <= ()
	  us7_awvalid,            // () <= ()
	  us7_bready,             // () <= ()
	  us7_bvalid,             // () <= ()
	  us7_rlast,              // () <= ()
	  us7_rready,             // () <= ()
	  us7_rvalid,             // () <= ()
	  us7_wlast,              // () <= ()
	  us7_wready,             // () <= ()
	  us7_wvalid,             // () <= ()
`endif // ATCBMC300_MST7_SUPPORT
`ifdef ATCBMC300_MST8_SUPPORT
	  us8_araddr,             // () <= ()
	  us8_arready,            // () <= ()
	  us8_arvalid,            // () <= ()
	  us8_awaddr,             // () <= ()
	  us8_awready,            // () <= ()
	  us8_awvalid,            // () <= ()
	  us8_bready,             // () <= ()
	  us8_bvalid,             // () <= ()
	  us8_rlast,              // () <= ()
	  us8_rready,             // () <= ()
	  us8_rvalid,             // () <= ()
	  us8_wlast,              // () <= ()
	  us8_wready,             // () <= ()
	  us8_wvalid,             // () <= ()
`endif // ATCBMC300_MST8_SUPPORT
`ifdef ATCBMC300_MST9_SUPPORT
	  us9_araddr,             // () <= ()
	  us9_arready,            // () <= ()
	  us9_arvalid,            // () <= ()
	  us9_awaddr,             // () <= ()
	  us9_awready,            // () <= ()
	  us9_awvalid,            // () <= ()
	  us9_bready,             // () <= ()
	  us9_bvalid,             // () <= ()
	  us9_rlast,              // () <= ()
	  us9_rready,             // () <= ()
	  us9_rvalid,             // () <= ()
	  us9_wlast,              // () <= ()
	  us9_wready,             // () <= ()
	  us9_wvalid,             // () <= ()
`endif // ATCBMC300_MST9_SUPPORT
`ifdef ATCBMC300_MST10_SUPPORT
	  us10_araddr,            // () <= ()
	  us10_arready,           // () <= ()
	  us10_arvalid,           // () <= ()
	  us10_awaddr,            // () <= ()
	  us10_awready,           // () <= ()
	  us10_awvalid,           // () <= ()
	  us10_bready,            // () <= ()
	  us10_bvalid,            // () <= ()
	  us10_rlast,             // () <= ()
	  us10_rready,            // () <= ()
	  us10_rvalid,            // () <= ()
	  us10_wlast,             // () <= ()
	  us10_wready,            // () <= ()
	  us10_wvalid,            // () <= ()
`endif // ATCBMC300_MST10_SUPPORT
`ifdef ATCBMC300_MST11_SUPPORT
	  us11_araddr,            // () <= ()
	  us11_arready,           // () <= ()
	  us11_arvalid,           // () <= ()
	  us11_awaddr,            // () <= ()
	  us11_awready,           // () <= ()
	  us11_awvalid,           // () <= ()
	  us11_bready,            // () <= ()
	  us11_bvalid,            // () <= ()
	  us11_rlast,             // () <= ()
	  us11_rready,            // () <= ()
	  us11_rvalid,            // () <= ()
	  us11_wlast,             // () <= ()
	  us11_wready,            // () <= ()
	  us11_wvalid,            // () <= ()
`endif // ATCBMC300_MST11_SUPPORT
`ifdef ATCBMC300_MST12_SUPPORT
	  us12_araddr,            // () <= ()
	  us12_arready,           // () <= ()
	  us12_arvalid,           // () <= ()
	  us12_awaddr,            // () <= ()
	  us12_awready,           // () <= ()
	  us12_awvalid,           // () <= ()
	  us12_bready,            // () <= ()
	  us12_bvalid,            // () <= ()
	  us12_rlast,             // () <= ()
	  us12_rready,            // () <= ()
	  us12_rvalid,            // () <= ()
	  us12_wlast,             // () <= ()
	  us12_wready,            // () <= ()
	  us12_wvalid,            // () <= ()
`endif // ATCBMC300_MST12_SUPPORT
`ifdef ATCBMC300_MST13_SUPPORT
	  us13_araddr,            // () <= ()
	  us13_arready,           // () <= ()
	  us13_arvalid,           // () <= ()
	  us13_awaddr,            // () <= ()
	  us13_awready,           // () <= ()
	  us13_awvalid,           // () <= ()
	  us13_bready,            // () <= ()
	  us13_bvalid,            // () <= ()
	  us13_rlast,             // () <= ()
	  us13_rready,            // () <= ()
	  us13_rvalid,            // () <= ()
	  us13_wlast,             // () <= ()
	  us13_wready,            // () <= ()
	  us13_wvalid,            // () <= ()
`endif // ATCBMC300_MST13_SUPPORT
`ifdef ATCBMC300_MST14_SUPPORT
	  us14_araddr,            // () <= ()
	  us14_arready,           // () <= ()
	  us14_arvalid,           // () <= ()
	  us14_awaddr,            // () <= ()
	  us14_awready,           // () <= ()
	  us14_awvalid,           // () <= ()
	  us14_bready,            // () <= ()
	  us14_bvalid,            // () <= ()
	  us14_rlast,             // () <= ()
	  us14_rready,            // () <= ()
	  us14_rvalid,            // () <= ()
	  us14_wlast,             // () <= ()
	  us14_wready,            // () <= ()
	  us14_wvalid,            // () <= ()
`endif // ATCBMC300_MST14_SUPPORT
`ifdef ATCBMC300_MST15_SUPPORT
	  us15_araddr,            // () <= ()
	  us15_arready,           // () <= ()
	  us15_arvalid,           // () <= ()
	  us15_awaddr,            // () <= ()
	  us15_awready,           // () <= ()
	  us15_awvalid,           // () <= ()
	  us15_bready,            // () <= ()
	  us15_bvalid,            // () <= ()
	  us15_rlast,             // () <= ()
	  us15_rready,            // () <= ()
	  us15_rvalid,            // () <= ()
	  us15_wlast,             // () <= ()
	  us15_wready,            // () <= ()
	  us15_wvalid,            // () <= ()
`endif // ATCBMC300_MST15_SUPPORT
`ifdef ATCBMC300_SLV1_SUPPORT
	  ds1_arready,            // () <= ()
	  ds1_arvalid,            // () <= ()
	  ds1_awready,            // () <= ()
	  ds1_awvalid,            // () <= ()
	  ds1_bready,             // () <= ()
	  ds1_bvalid,             // () <= ()
	  ds1_rlast,              // () <= ()
	  ds1_rready,             // () <= ()
	  ds1_rvalid,             // () <= ()
	  ds1_wlast,              // () <= ()
	  ds1_wready,             // () <= ()
	  ds1_wvalid,             // () <= ()
`endif // ATCBMC300_SLV1_SUPPORT
`ifdef ATCBMC300_SLV2_SUPPORT
	  ds2_arready,            // () <= ()
	  ds2_arvalid,            // () <= ()
	  ds2_awready,            // () <= ()
	  ds2_awvalid,            // () <= ()
	  ds2_bready,             // () <= ()
	  ds2_bvalid,             // () <= ()
	  ds2_rlast,              // () <= ()
	  ds2_rready,             // () <= ()
	  ds2_rvalid,             // () <= ()
	  ds2_wlast,              // () <= ()
	  ds2_wready,             // () <= ()
	  ds2_wvalid,             // () <= ()
`endif // ATCBMC300_SLV2_SUPPORT
`ifdef ATCBMC300_SLV3_SUPPORT
	  ds3_arready,            // () <= ()
	  ds3_arvalid,            // () <= ()
	  ds3_awready,            // () <= ()
	  ds3_awvalid,            // () <= ()
	  ds3_bready,             // () <= ()
	  ds3_bvalid,             // () <= ()
	  ds3_rlast,              // () <= ()
	  ds3_rready,             // () <= ()
	  ds3_rvalid,             // () <= ()
	  ds3_wlast,              // () <= ()
	  ds3_wready,             // () <= ()
	  ds3_wvalid,             // () <= ()
`endif // ATCBMC300_SLV3_SUPPORT
`ifdef ATCBMC300_SLV4_SUPPORT
	  ds4_arready,            // () <= ()
	  ds4_arvalid,            // () <= ()
	  ds4_awready,            // () <= ()
	  ds4_awvalid,            // () <= ()
	  ds4_bready,             // () <= ()
	  ds4_bvalid,             // () <= ()
	  ds4_rlast,              // () <= ()
	  ds4_rready,             // () <= ()
	  ds4_rvalid,             // () <= ()
	  ds4_wlast,              // () <= ()
	  ds4_wready,             // () <= ()
	  ds4_wvalid,             // () <= ()
`endif // ATCBMC300_SLV4_SUPPORT
`ifdef ATCBMC300_SLV5_SUPPORT
	  ds5_arready,            // () <= ()
	  ds5_arvalid,            // () <= ()
	  ds5_awready,            // () <= ()
	  ds5_awvalid,            // () <= ()
	  ds5_bready,             // () <= ()
	  ds5_bvalid,             // () <= ()
	  ds5_rlast,              // () <= ()
	  ds5_rready,             // () <= ()
	  ds5_rvalid,             // () <= ()
	  ds5_wlast,              // () <= ()
	  ds5_wready,             // () <= ()
	  ds5_wvalid,             // () <= ()
`endif // ATCBMC300_SLV5_SUPPORT
`ifdef ATCBMC300_SLV6_SUPPORT
	  ds6_arready,            // () <= ()
	  ds6_arvalid,            // () <= ()
	  ds6_awready,            // () <= ()
	  ds6_awvalid,            // () <= ()
	  ds6_bready,             // () <= ()
	  ds6_bvalid,             // () <= ()
	  ds6_rlast,              // () <= ()
	  ds6_rready,             // () <= ()
	  ds6_rvalid,             // () <= ()
	  ds6_wlast,              // () <= ()
	  ds6_wready,             // () <= ()
	  ds6_wvalid,             // () <= ()
`endif // ATCBMC300_SLV6_SUPPORT
`ifdef ATCBMC300_SLV7_SUPPORT
	  ds7_arready,            // () <= ()
	  ds7_arvalid,            // () <= ()
	  ds7_awready,            // () <= ()
	  ds7_awvalid,            // () <= ()
	  ds7_bready,             // () <= ()
	  ds7_bvalid,             // () <= ()
	  ds7_rlast,              // () <= ()
	  ds7_rready,             // () <= ()
	  ds7_rvalid,             // () <= ()
	  ds7_wlast,              // () <= ()
	  ds7_wready,             // () <= ()
	  ds7_wvalid,             // () <= ()
`endif // ATCBMC300_SLV7_SUPPORT
`ifdef ATCBMC300_SLV8_SUPPORT
	  ds8_arready,            // () <= ()
	  ds8_arvalid,            // () <= ()
	  ds8_awready,            // () <= ()
	  ds8_awvalid,            // () <= ()
	  ds8_bready,             // () <= ()
	  ds8_bvalid,             // () <= ()
	  ds8_rlast,              // () <= ()
	  ds8_rready,             // () <= ()
	  ds8_rvalid,             // () <= ()
	  ds8_wlast,              // () <= ()
	  ds8_wready,             // () <= ()
	  ds8_wvalid,             // () <= ()
`endif // ATCBMC300_SLV8_SUPPORT
`ifdef ATCBMC300_SLV9_SUPPORT
	  ds9_arready,            // () <= ()
	  ds9_arvalid,            // () <= ()
	  ds9_awready,            // () <= ()
	  ds9_awvalid,            // () <= ()
	  ds9_bready,             // () <= ()
	  ds9_bvalid,             // () <= ()
	  ds9_rlast,              // () <= ()
	  ds9_rready,             // () <= ()
	  ds9_rvalid,             // () <= ()
	  ds9_wlast,              // () <= ()
	  ds9_wready,             // () <= ()
	  ds9_wvalid,             // () <= ()
`endif // ATCBMC300_SLV9_SUPPORT
`ifdef ATCBMC300_SLV10_SUPPORT
	  ds10_arready,           // () <= ()
	  ds10_arvalid,           // () <= ()
	  ds10_awready,           // () <= ()
	  ds10_awvalid,           // () <= ()
	  ds10_bready,            // () <= ()
	  ds10_bvalid,            // () <= ()
	  ds10_rlast,             // () <= ()
	  ds10_rready,            // () <= ()
	  ds10_rvalid,            // () <= ()
	  ds10_wlast,             // () <= ()
	  ds10_wready,            // () <= ()
	  ds10_wvalid,            // () <= ()
`endif // ATCBMC300_SLV10_SUPPORT
`ifdef ATCBMC300_SLV11_SUPPORT
	  ds11_arready,           // () <= ()
	  ds11_arvalid,           // () <= ()
	  ds11_awready,           // () <= ()
	  ds11_awvalid,           // () <= ()
	  ds11_bready,            // () <= ()
	  ds11_bvalid,            // () <= ()
	  ds11_rlast,             // () <= ()
	  ds11_rready,            // () <= ()
	  ds11_rvalid,            // () <= ()
	  ds11_wlast,             // () <= ()
	  ds11_wready,            // () <= ()
	  ds11_wvalid,            // () <= ()
`endif // ATCBMC300_SLV11_SUPPORT
`ifdef ATCBMC300_SLV12_SUPPORT
	  ds12_arready,           // () <= ()
	  ds12_arvalid,           // () <= ()
	  ds12_awready,           // () <= ()
	  ds12_awvalid,           // () <= ()
	  ds12_bready,            // () <= ()
	  ds12_bvalid,            // () <= ()
	  ds12_rlast,             // () <= ()
	  ds12_rready,            // () <= ()
	  ds12_rvalid,            // () <= ()
	  ds12_wlast,             // () <= ()
	  ds12_wready,            // () <= ()
	  ds12_wvalid,            // () <= ()
`endif // ATCBMC300_SLV12_SUPPORT
`ifdef ATCBMC300_SLV13_SUPPORT
	  ds13_arready,           // () <= ()
	  ds13_arvalid,           // () <= ()
	  ds13_awready,           // () <= ()
	  ds13_awvalid,           // () <= ()
	  ds13_bready,            // () <= ()
	  ds13_bvalid,            // () <= ()
	  ds13_rlast,             // () <= ()
	  ds13_rready,            // () <= ()
	  ds13_rvalid,            // () <= ()
	  ds13_wlast,             // () <= ()
	  ds13_wready,            // () <= ()
	  ds13_wvalid,            // () <= ()
`endif // ATCBMC300_SLV13_SUPPORT
`ifdef ATCBMC300_SLV14_SUPPORT
	  ds14_arready,           // () <= ()
	  ds14_arvalid,           // () <= ()
	  ds14_awready,           // () <= ()
	  ds14_awvalid,           // () <= ()
	  ds14_bready,            // () <= ()
	  ds14_bvalid,            // () <= ()
	  ds14_rlast,             // () <= ()
	  ds14_rready,            // () <= ()
	  ds14_rvalid,            // () <= ()
	  ds14_wlast,             // () <= ()
	  ds14_wready,            // () <= ()
	  ds14_wvalid,            // () <= ()
`endif // ATCBMC300_SLV14_SUPPORT
`ifdef ATCBMC300_SLV15_SUPPORT
	  ds15_arready,           // () <= ()
	  ds15_arvalid,           // () <= ()
	  ds15_awready,           // () <= ()
	  ds15_awvalid,           // () <= ()
	  ds15_bready,            // () <= ()
	  ds15_bvalid,            // () <= ()
	  ds15_rlast,             // () <= ()
	  ds15_rready,            // () <= ()
	  ds15_rvalid,            // () <= ()
	  ds15_wlast,             // () <= ()
	  ds15_wready,            // () <= ()
	  ds15_wvalid,            // () <= ()
`endif // ATCBMC300_SLV15_SUPPORT
`ifdef ATCBMC300_SLV16_SUPPORT
	  ds16_arready,           // () <= ()
	  ds16_arvalid,           // () <= ()
	  ds16_awready,           // () <= ()
	  ds16_awvalid,           // () <= ()
	  ds16_bready,            // () <= ()
	  ds16_bvalid,            // () <= ()
	  ds16_rlast,             // () <= ()
	  ds16_rready,            // () <= ()
	  ds16_rvalid,            // () <= ()
	  ds16_wlast,             // () <= ()
	  ds16_wready,            // () <= ()
	  ds16_wvalid,            // () <= ()
`endif // ATCBMC300_SLV16_SUPPORT
`ifdef ATCBMC300_SLV17_SUPPORT
	  ds17_arready,           // () <= ()
	  ds17_arvalid,           // () <= ()
	  ds17_awready,           // () <= ()
	  ds17_awvalid,           // () <= ()
	  ds17_bready,            // () <= ()
	  ds17_bvalid,            // () <= ()
	  ds17_rlast,             // () <= ()
	  ds17_rready,            // () <= ()
	  ds17_rvalid,            // () <= ()
	  ds17_wlast,             // () <= ()
	  ds17_wready,            // () <= ()
	  ds17_wvalid,            // () <= ()
`endif // ATCBMC300_SLV17_SUPPORT
`ifdef ATCBMC300_SLV18_SUPPORT
	  ds18_arready,           // () <= ()
	  ds18_arvalid,           // () <= ()
	  ds18_awready,           // () <= ()
	  ds18_awvalid,           // () <= ()
	  ds18_bready,            // () <= ()
	  ds18_bvalid,            // () <= ()
	  ds18_rlast,             // () <= ()
	  ds18_rready,            // () <= ()
	  ds18_rvalid,            // () <= ()
	  ds18_wlast,             // () <= ()
	  ds18_wready,            // () <= ()
	  ds18_wvalid,            // () <= ()
`endif // ATCBMC300_SLV18_SUPPORT
`ifdef ATCBMC300_SLV19_SUPPORT
	  ds19_arready,           // () <= ()
	  ds19_arvalid,           // () <= ()
	  ds19_awready,           // () <= ()
	  ds19_awvalid,           // () <= ()
	  ds19_bready,            // () <= ()
	  ds19_bvalid,            // () <= ()
	  ds19_rlast,             // () <= ()
	  ds19_rready,            // () <= ()
	  ds19_rvalid,            // () <= ()
	  ds19_wlast,             // () <= ()
	  ds19_wready,            // () <= ()
	  ds19_wvalid,            // () <= ()
`endif // ATCBMC300_SLV19_SUPPORT
`ifdef ATCBMC300_SLV20_SUPPORT
	  ds20_arready,           // () <= ()
	  ds20_arvalid,           // () <= ()
	  ds20_awready,           // () <= ()
	  ds20_awvalid,           // () <= ()
	  ds20_bready,            // () <= ()
	  ds20_bvalid,            // () <= ()
	  ds20_rlast,             // () <= ()
	  ds20_rready,            // () <= ()
	  ds20_rvalid,            // () <= ()
	  ds20_wlast,             // () <= ()
	  ds20_wready,            // () <= ()
	  ds20_wvalid,            // () <= ()
`endif // ATCBMC300_SLV20_SUPPORT
`ifdef ATCBMC300_SLV21_SUPPORT
	  ds21_arready,           // () <= ()
	  ds21_arvalid,           // () <= ()
	  ds21_awready,           // () <= ()
	  ds21_awvalid,           // () <= ()
	  ds21_bready,            // () <= ()
	  ds21_bvalid,            // () <= ()
	  ds21_rlast,             // () <= ()
	  ds21_rready,            // () <= ()
	  ds21_rvalid,            // () <= ()
	  ds21_wlast,             // () <= ()
	  ds21_wready,            // () <= ()
	  ds21_wvalid,            // () <= ()
`endif // ATCBMC300_SLV21_SUPPORT
`ifdef ATCBMC300_SLV22_SUPPORT
	  ds22_arready,           // () <= ()
	  ds22_arvalid,           // () <= ()
	  ds22_awready,           // () <= ()
	  ds22_awvalid,           // () <= ()
	  ds22_bready,            // () <= ()
	  ds22_bvalid,            // () <= ()
	  ds22_rlast,             // () <= ()
	  ds22_rready,            // () <= ()
	  ds22_rvalid,            // () <= ()
	  ds22_wlast,             // () <= ()
	  ds22_wready,            // () <= ()
	  ds22_wvalid,            // () <= ()
`endif // ATCBMC300_SLV22_SUPPORT
`ifdef ATCBMC300_SLV23_SUPPORT
	  ds23_arready,           // () <= ()
	  ds23_arvalid,           // () <= ()
	  ds23_awready,           // () <= ()
	  ds23_awvalid,           // () <= ()
	  ds23_bready,            // () <= ()
	  ds23_bvalid,            // () <= ()
	  ds23_rlast,             // () <= ()
	  ds23_rready,            // () <= ()
	  ds23_rvalid,            // () <= ()
	  ds23_wlast,             // () <= ()
	  ds23_wready,            // () <= ()
	  ds23_wvalid,            // () <= ()
`endif // ATCBMC300_SLV23_SUPPORT
`ifdef ATCBMC300_SLV24_SUPPORT
	  ds24_arready,           // () <= ()
	  ds24_arvalid,           // () <= ()
	  ds24_awready,           // () <= ()
	  ds24_awvalid,           // () <= ()
	  ds24_bready,            // () <= ()
	  ds24_bvalid,            // () <= ()
	  ds24_rlast,             // () <= ()
	  ds24_rready,            // () <= ()
	  ds24_rvalid,            // () <= ()
	  ds24_wlast,             // () <= ()
	  ds24_wready,            // () <= ()
	  ds24_wvalid,            // () <= ()
`endif // ATCBMC300_SLV24_SUPPORT
`ifdef ATCBMC300_SLV25_SUPPORT
	  ds25_arready,           // () <= ()
	  ds25_arvalid,           // () <= ()
	  ds25_awready,           // () <= ()
	  ds25_awvalid,           // () <= ()
	  ds25_bready,            // () <= ()
	  ds25_bvalid,            // () <= ()
	  ds25_rlast,             // () <= ()
	  ds25_rready,            // () <= ()
	  ds25_rvalid,            // () <= ()
	  ds25_wlast,             // () <= ()
	  ds25_wready,            // () <= ()
	  ds25_wvalid,            // () <= ()
`endif // ATCBMC300_SLV25_SUPPORT
`ifdef ATCBMC300_SLV26_SUPPORT
	  ds26_arready,           // () <= ()
	  ds26_arvalid,           // () <= ()
	  ds26_awready,           // () <= ()
	  ds26_awvalid,           // () <= ()
	  ds26_bready,            // () <= ()
	  ds26_bvalid,            // () <= ()
	  ds26_rlast,             // () <= ()
	  ds26_rready,            // () <= ()
	  ds26_rvalid,            // () <= ()
	  ds26_wlast,             // () <= ()
	  ds26_wready,            // () <= ()
	  ds26_wvalid,            // () <= ()
`endif // ATCBMC300_SLV26_SUPPORT
`ifdef ATCBMC300_SLV27_SUPPORT
	  ds27_arready,           // () <= ()
	  ds27_arvalid,           // () <= ()
	  ds27_awready,           // () <= ()
	  ds27_awvalid,           // () <= ()
	  ds27_bready,            // () <= ()
	  ds27_bvalid,            // () <= ()
	  ds27_rlast,             // () <= ()
	  ds27_rready,            // () <= ()
	  ds27_rvalid,            // () <= ()
	  ds27_wlast,             // () <= ()
	  ds27_wready,            // () <= ()
	  ds27_wvalid,            // () <= ()
`endif // ATCBMC300_SLV27_SUPPORT
`ifdef ATCBMC300_SLV28_SUPPORT
	  ds28_arready,           // () <= ()
	  ds28_arvalid,           // () <= ()
	  ds28_awready,           // () <= ()
	  ds28_awvalid,           // () <= ()
	  ds28_bready,            // () <= ()
	  ds28_bvalid,            // () <= ()
	  ds28_rlast,             // () <= ()
	  ds28_rready,            // () <= ()
	  ds28_rvalid,            // () <= ()
	  ds28_wlast,             // () <= ()
	  ds28_wready,            // () <= ()
	  ds28_wvalid,            // () <= ()
`endif // ATCBMC300_SLV28_SUPPORT
`ifdef ATCBMC300_SLV29_SUPPORT
	  ds29_arready,           // () <= ()
	  ds29_arvalid,           // () <= ()
	  ds29_awready,           // () <= ()
	  ds29_awvalid,           // () <= ()
	  ds29_bready,            // () <= ()
	  ds29_bvalid,            // () <= ()
	  ds29_rlast,             // () <= ()
	  ds29_rready,            // () <= ()
	  ds29_rvalid,            // () <= ()
	  ds29_wlast,             // () <= ()
	  ds29_wready,            // () <= ()
	  ds29_wvalid,            // () <= ()
`endif // ATCBMC300_SLV29_SUPPORT
`ifdef ATCBMC300_SLV30_SUPPORT
	  ds30_arready,           // () <= ()
	  ds30_arvalid,           // () <= ()
	  ds30_awready,           // () <= ()
	  ds30_awvalid,           // () <= ()
	  ds30_bready,            // () <= ()
	  ds30_bvalid,            // () <= ()
	  ds30_rlast,             // () <= ()
	  ds30_rready,            // () <= ()
	  ds30_rvalid,            // () <= ()
	  ds30_wlast,             // () <= ()
	  ds30_wready,            // () <= ()
	  ds30_wvalid,            // () <= ()
`endif // ATCBMC300_SLV30_SUPPORT
`ifdef ATCBMC300_SLV31_SUPPORT
	  ds31_arready,           // () <= ()
	  ds31_arvalid,           // () <= ()
	  ds31_awready,           // () <= ()
	  ds31_awvalid,           // () <= ()
	  ds31_bready,            // () <= ()
	  ds31_bvalid,            // () <= ()
	  ds31_rlast,             // () <= ()
	  ds31_rready,            // () <= ()
	  ds31_rvalid,            // () <= ()
	  ds31_wlast,             // () <= ()
	  ds31_wready,            // () <= ()
	  ds31_wvalid,            // () <= ()
`endif // ATCBMC300_SLV31_SUPPORT
	  aclk,                   // () <= ()
	  aresetn,                // () <= ()
	  reg_mst0_high_priority, // () <= ()
	  reg_priority_reload     // () <= ()
);

parameter MAX_LATENCY=`MAX_LATENCY * 2 * `RMAXLEN + 0;

`ifdef ATCBMC300_MST0_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us0_araddr;
input                                     us0_arready;
input                                     us0_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us0_awaddr;
input                                     us0_awready;
input                                     us0_awvalid;
input                                     us0_bready;
input                                     us0_bvalid;
input                                     us0_rlast;
input                                     us0_rready;
input                                     us0_rvalid;
input                                     us0_wlast;
input                                     us0_wready;
input                                     us0_wvalid;
`endif // ATCBMC300_MST0_SUPPORT
`ifdef ATCBMC300_MST1_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us1_araddr;
input                                     us1_arready;
input                                     us1_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us1_awaddr;
input                                     us1_awready;
input                                     us1_awvalid;
input                                     us1_bready;
input                                     us1_bvalid;
input                                     us1_rlast;
input                                     us1_rready;
input                                     us1_rvalid;
input                                     us1_wlast;
input                                     us1_wready;
input                                     us1_wvalid;
`endif // ATCBMC300_MST1_SUPPORT
`ifdef ATCBMC300_MST2_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us2_araddr;
input                                     us2_arready;
input                                     us2_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us2_awaddr;
input                                     us2_awready;
input                                     us2_awvalid;
input                                     us2_bready;
input                                     us2_bvalid;
input                                     us2_rlast;
input                                     us2_rready;
input                                     us2_rvalid;
input                                     us2_wlast;
input                                     us2_wready;
input                                     us2_wvalid;
`endif // ATCBMC300_MST2_SUPPORT
`ifdef ATCBMC300_MST3_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us3_araddr;
input                                     us3_arready;
input                                     us3_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us3_awaddr;
input                                     us3_awready;
input                                     us3_awvalid;
input                                     us3_bready;
input                                     us3_bvalid;
input                                     us3_rlast;
input                                     us3_rready;
input                                     us3_rvalid;
input                                     us3_wlast;
input                                     us3_wready;
input                                     us3_wvalid;
`endif // ATCBMC300_MST3_SUPPORT
`ifdef ATCBMC300_MST4_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us4_araddr;
input                                     us4_arready;
input                                     us4_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us4_awaddr;
input                                     us4_awready;
input                                     us4_awvalid;
input                                     us4_bready;
input                                     us4_bvalid;
input                                     us4_rlast;
input                                     us4_rready;
input                                     us4_rvalid;
input                                     us4_wlast;
input                                     us4_wready;
input                                     us4_wvalid;
`endif // ATCBMC300_MST4_SUPPORT
`ifdef ATCBMC300_MST5_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us5_araddr;
input                                     us5_arready;
input                                     us5_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us5_awaddr;
input                                     us5_awready;
input                                     us5_awvalid;
input                                     us5_bready;
input                                     us5_bvalid;
input                                     us5_rlast;
input                                     us5_rready;
input                                     us5_rvalid;
input                                     us5_wlast;
input                                     us5_wready;
input                                     us5_wvalid;
`endif // ATCBMC300_MST5_SUPPORT
`ifdef ATCBMC300_MST6_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us6_araddr;
input                                     us6_arready;
input                                     us6_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us6_awaddr;
input                                     us6_awready;
input                                     us6_awvalid;
input                                     us6_bready;
input                                     us6_bvalid;
input                                     us6_rlast;
input                                     us6_rready;
input                                     us6_rvalid;
input                                     us6_wlast;
input                                     us6_wready;
input                                     us6_wvalid;
`endif // ATCBMC300_MST6_SUPPORT
`ifdef ATCBMC300_MST7_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us7_araddr;
input                                     us7_arready;
input                                     us7_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us7_awaddr;
input                                     us7_awready;
input                                     us7_awvalid;
input                                     us7_bready;
input                                     us7_bvalid;
input                                     us7_rlast;
input                                     us7_rready;
input                                     us7_rvalid;
input                                     us7_wlast;
input                                     us7_wready;
input                                     us7_wvalid;
`endif // ATCBMC300_MST7_SUPPORT
`ifdef ATCBMC300_MST8_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us8_araddr;
input                                     us8_arready;
input                                     us8_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us8_awaddr;
input                                     us8_awready;
input                                     us8_awvalid;
input                                     us8_bready;
input                                     us8_bvalid;
input                                     us8_rlast;
input                                     us8_rready;
input                                     us8_rvalid;
input                                     us8_wlast;
input                                     us8_wready;
input                                     us8_wvalid;
`endif // ATCBMC300_MST8_SUPPORT
`ifdef ATCBMC300_MST9_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us9_araddr;
input                                     us9_arready;
input                                     us9_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us9_awaddr;
input                                     us9_awready;
input                                     us9_awvalid;
input                                     us9_bready;
input                                     us9_bvalid;
input                                     us9_rlast;
input                                     us9_rready;
input                                     us9_rvalid;
input                                     us9_wlast;
input                                     us9_wready;
input                                     us9_wvalid;
`endif // ATCBMC300_MST9_SUPPORT
`ifdef ATCBMC300_MST10_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us10_araddr;
input                                     us10_arready;
input                                     us10_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us10_awaddr;
input                                     us10_awready;
input                                     us10_awvalid;
input                                     us10_bready;
input                                     us10_bvalid;
input                                     us10_rlast;
input                                     us10_rready;
input                                     us10_rvalid;
input                                     us10_wlast;
input                                     us10_wready;
input                                     us10_wvalid;
`endif // ATCBMC300_MST10_SUPPORT
`ifdef ATCBMC300_MST11_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us11_araddr;
input                                     us11_arready;
input                                     us11_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us11_awaddr;
input                                     us11_awready;
input                                     us11_awvalid;
input                                     us11_bready;
input                                     us11_bvalid;
input                                     us11_rlast;
input                                     us11_rready;
input                                     us11_rvalid;
input                                     us11_wlast;
input                                     us11_wready;
input                                     us11_wvalid;
`endif // ATCBMC300_MST11_SUPPORT
`ifdef ATCBMC300_MST12_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us12_araddr;
input                                     us12_arready;
input                                     us12_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us12_awaddr;
input                                     us12_awready;
input                                     us12_awvalid;
input                                     us12_bready;
input                                     us12_bvalid;
input                                     us12_rlast;
input                                     us12_rready;
input                                     us12_rvalid;
input                                     us12_wlast;
input                                     us12_wready;
input                                     us12_wvalid;
`endif // ATCBMC300_MST12_SUPPORT
`ifdef ATCBMC300_MST13_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us13_araddr;
input                                     us13_arready;
input                                     us13_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us13_awaddr;
input                                     us13_awready;
input                                     us13_awvalid;
input                                     us13_bready;
input                                     us13_bvalid;
input                                     us13_rlast;
input                                     us13_rready;
input                                     us13_rvalid;
input                                     us13_wlast;
input                                     us13_wready;
input                                     us13_wvalid;
`endif // ATCBMC300_MST13_SUPPORT
`ifdef ATCBMC300_MST14_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us14_araddr;
input                                     us14_arready;
input                                     us14_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us14_awaddr;
input                                     us14_awready;
input                                     us14_awvalid;
input                                     us14_bready;
input                                     us14_bvalid;
input                                     us14_rlast;
input                                     us14_rready;
input                                     us14_rvalid;
input                                     us14_wlast;
input                                     us14_wready;
input                                     us14_wvalid;
`endif // ATCBMC300_MST14_SUPPORT
`ifdef ATCBMC300_MST15_SUPPORT
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us15_araddr;
input                                     us15_arready;
input                                     us15_arvalid;
input       [(`ATCBMC300_ADDR_WIDTH-1):0] us15_awaddr;
input                                     us15_awready;
input                                     us15_awvalid;
input                                     us15_bready;
input                                     us15_bvalid;
input                                     us15_rlast;
input                                     us15_rready;
input                                     us15_rvalid;
input                                     us15_wlast;
input                                     us15_wready;
input                                     us15_wvalid;
`endif // ATCBMC300_MST15_SUPPORT
`ifdef ATCBMC300_SLV1_SUPPORT
input                                     ds1_arready;
input                                     ds1_arvalid;
input                                     ds1_awready;
input                                     ds1_awvalid;
input                                     ds1_bready;
input                                     ds1_bvalid;
input                                     ds1_rlast;
input                                     ds1_rready;
input                                     ds1_rvalid;
input                                     ds1_wlast;
input                                     ds1_wready;
input                                     ds1_wvalid;
`endif // ATCBMC300_SLV1_SUPPORT
`ifdef ATCBMC300_SLV2_SUPPORT
input                                     ds2_arready;
input                                     ds2_arvalid;
input                                     ds2_awready;
input                                     ds2_awvalid;
input                                     ds2_bready;
input                                     ds2_bvalid;
input                                     ds2_rlast;
input                                     ds2_rready;
input                                     ds2_rvalid;
input                                     ds2_wlast;
input                                     ds2_wready;
input                                     ds2_wvalid;
`endif // ATCBMC300_SLV2_SUPPORT
`ifdef ATCBMC300_SLV3_SUPPORT
input                                     ds3_arready;
input                                     ds3_arvalid;
input                                     ds3_awready;
input                                     ds3_awvalid;
input                                     ds3_bready;
input                                     ds3_bvalid;
input                                     ds3_rlast;
input                                     ds3_rready;
input                                     ds3_rvalid;
input                                     ds3_wlast;
input                                     ds3_wready;
input                                     ds3_wvalid;
`endif // ATCBMC300_SLV3_SUPPORT
`ifdef ATCBMC300_SLV4_SUPPORT
input                                     ds4_arready;
input                                     ds4_arvalid;
input                                     ds4_awready;
input                                     ds4_awvalid;
input                                     ds4_bready;
input                                     ds4_bvalid;
input                                     ds4_rlast;
input                                     ds4_rready;
input                                     ds4_rvalid;
input                                     ds4_wlast;
input                                     ds4_wready;
input                                     ds4_wvalid;
`endif // ATCBMC300_SLV4_SUPPORT
`ifdef ATCBMC300_SLV5_SUPPORT
input                                     ds5_arready;
input                                     ds5_arvalid;
input                                     ds5_awready;
input                                     ds5_awvalid;
input                                     ds5_bready;
input                                     ds5_bvalid;
input                                     ds5_rlast;
input                                     ds5_rready;
input                                     ds5_rvalid;
input                                     ds5_wlast;
input                                     ds5_wready;
input                                     ds5_wvalid;
`endif // ATCBMC300_SLV5_SUPPORT
`ifdef ATCBMC300_SLV6_SUPPORT
input                                     ds6_arready;
input                                     ds6_arvalid;
input                                     ds6_awready;
input                                     ds6_awvalid;
input                                     ds6_bready;
input                                     ds6_bvalid;
input                                     ds6_rlast;
input                                     ds6_rready;
input                                     ds6_rvalid;
input                                     ds6_wlast;
input                                     ds6_wready;
input                                     ds6_wvalid;
`endif // ATCBMC300_SLV6_SUPPORT
`ifdef ATCBMC300_SLV7_SUPPORT
input                                     ds7_arready;
input                                     ds7_arvalid;
input                                     ds7_awready;
input                                     ds7_awvalid;
input                                     ds7_bready;
input                                     ds7_bvalid;
input                                     ds7_rlast;
input                                     ds7_rready;
input                                     ds7_rvalid;
input                                     ds7_wlast;
input                                     ds7_wready;
input                                     ds7_wvalid;
`endif // ATCBMC300_SLV7_SUPPORT
`ifdef ATCBMC300_SLV8_SUPPORT
input                                     ds8_arready;
input                                     ds8_arvalid;
input                                     ds8_awready;
input                                     ds8_awvalid;
input                                     ds8_bready;
input                                     ds8_bvalid;
input                                     ds8_rlast;
input                                     ds8_rready;
input                                     ds8_rvalid;
input                                     ds8_wlast;
input                                     ds8_wready;
input                                     ds8_wvalid;
`endif // ATCBMC300_SLV8_SUPPORT
`ifdef ATCBMC300_SLV9_SUPPORT
input                                     ds9_arready;
input                                     ds9_arvalid;
input                                     ds9_awready;
input                                     ds9_awvalid;
input                                     ds9_bready;
input                                     ds9_bvalid;
input                                     ds9_rlast;
input                                     ds9_rready;
input                                     ds9_rvalid;
input                                     ds9_wlast;
input                                     ds9_wready;
input                                     ds9_wvalid;
`endif // ATCBMC300_SLV9_SUPPORT
`ifdef ATCBMC300_SLV10_SUPPORT
input                                     ds10_arready;
input                                     ds10_arvalid;
input                                     ds10_awready;
input                                     ds10_awvalid;
input                                     ds10_bready;
input                                     ds10_bvalid;
input                                     ds10_rlast;
input                                     ds10_rready;
input                                     ds10_rvalid;
input                                     ds10_wlast;
input                                     ds10_wready;
input                                     ds10_wvalid;
`endif // ATCBMC300_SLV10_SUPPORT
`ifdef ATCBMC300_SLV11_SUPPORT
input                                     ds11_arready;
input                                     ds11_arvalid;
input                                     ds11_awready;
input                                     ds11_awvalid;
input                                     ds11_bready;
input                                     ds11_bvalid;
input                                     ds11_rlast;
input                                     ds11_rready;
input                                     ds11_rvalid;
input                                     ds11_wlast;
input                                     ds11_wready;
input                                     ds11_wvalid;
`endif // ATCBMC300_SLV11_SUPPORT
`ifdef ATCBMC300_SLV12_SUPPORT
input                                     ds12_arready;
input                                     ds12_arvalid;
input                                     ds12_awready;
input                                     ds12_awvalid;
input                                     ds12_bready;
input                                     ds12_bvalid;
input                                     ds12_rlast;
input                                     ds12_rready;
input                                     ds12_rvalid;
input                                     ds12_wlast;
input                                     ds12_wready;
input                                     ds12_wvalid;
`endif // ATCBMC300_SLV12_SUPPORT
`ifdef ATCBMC300_SLV13_SUPPORT
input                                     ds13_arready;
input                                     ds13_arvalid;
input                                     ds13_awready;
input                                     ds13_awvalid;
input                                     ds13_bready;
input                                     ds13_bvalid;
input                                     ds13_rlast;
input                                     ds13_rready;
input                                     ds13_rvalid;
input                                     ds13_wlast;
input                                     ds13_wready;
input                                     ds13_wvalid;
`endif // ATCBMC300_SLV13_SUPPORT
`ifdef ATCBMC300_SLV14_SUPPORT
input                                     ds14_arready;
input                                     ds14_arvalid;
input                                     ds14_awready;
input                                     ds14_awvalid;
input                                     ds14_bready;
input                                     ds14_bvalid;
input                                     ds14_rlast;
input                                     ds14_rready;
input                                     ds14_rvalid;
input                                     ds14_wlast;
input                                     ds14_wready;
input                                     ds14_wvalid;
`endif // ATCBMC300_SLV14_SUPPORT
`ifdef ATCBMC300_SLV15_SUPPORT
input                                     ds15_arready;
input                                     ds15_arvalid;
input                                     ds15_awready;
input                                     ds15_awvalid;
input                                     ds15_bready;
input                                     ds15_bvalid;
input                                     ds15_rlast;
input                                     ds15_rready;
input                                     ds15_rvalid;
input                                     ds15_wlast;
input                                     ds15_wready;
input                                     ds15_wvalid;
`endif // ATCBMC300_SLV15_SUPPORT
`ifdef ATCBMC300_SLV16_SUPPORT
input                                     ds16_arready;
input                                     ds16_arvalid;
input                                     ds16_awready;
input                                     ds16_awvalid;
input                                     ds16_bready;
input                                     ds16_bvalid;
input                                     ds16_rlast;
input                                     ds16_rready;
input                                     ds16_rvalid;
input                                     ds16_wlast;
input                                     ds16_wready;
input                                     ds16_wvalid;
`endif // ATCBMC300_SLV16_SUPPORT
`ifdef ATCBMC300_SLV17_SUPPORT
input                                     ds17_arready;
input                                     ds17_arvalid;
input                                     ds17_awready;
input                                     ds17_awvalid;
input                                     ds17_bready;
input                                     ds17_bvalid;
input                                     ds17_rlast;
input                                     ds17_rready;
input                                     ds17_rvalid;
input                                     ds17_wlast;
input                                     ds17_wready;
input                                     ds17_wvalid;
`endif // ATCBMC300_SLV17_SUPPORT
`ifdef ATCBMC300_SLV18_SUPPORT
input                                     ds18_arready;
input                                     ds18_arvalid;
input                                     ds18_awready;
input                                     ds18_awvalid;
input                                     ds18_bready;
input                                     ds18_bvalid;
input                                     ds18_rlast;
input                                     ds18_rready;
input                                     ds18_rvalid;
input                                     ds18_wlast;
input                                     ds18_wready;
input                                     ds18_wvalid;
`endif // ATCBMC300_SLV18_SUPPORT
`ifdef ATCBMC300_SLV19_SUPPORT
input                                     ds19_arready;
input                                     ds19_arvalid;
input                                     ds19_awready;
input                                     ds19_awvalid;
input                                     ds19_bready;
input                                     ds19_bvalid;
input                                     ds19_rlast;
input                                     ds19_rready;
input                                     ds19_rvalid;
input                                     ds19_wlast;
input                                     ds19_wready;
input                                     ds19_wvalid;
`endif // ATCBMC300_SLV19_SUPPORT
`ifdef ATCBMC300_SLV20_SUPPORT
input                                     ds20_arready;
input                                     ds20_arvalid;
input                                     ds20_awready;
input                                     ds20_awvalid;
input                                     ds20_bready;
input                                     ds20_bvalid;
input                                     ds20_rlast;
input                                     ds20_rready;
input                                     ds20_rvalid;
input                                     ds20_wlast;
input                                     ds20_wready;
input                                     ds20_wvalid;
`endif // ATCBMC300_SLV20_SUPPORT
`ifdef ATCBMC300_SLV21_SUPPORT
input                                     ds21_arready;
input                                     ds21_arvalid;
input                                     ds21_awready;
input                                     ds21_awvalid;
input                                     ds21_bready;
input                                     ds21_bvalid;
input                                     ds21_rlast;
input                                     ds21_rready;
input                                     ds21_rvalid;
input                                     ds21_wlast;
input                                     ds21_wready;
input                                     ds21_wvalid;
`endif // ATCBMC300_SLV21_SUPPORT
`ifdef ATCBMC300_SLV22_SUPPORT
input                                     ds22_arready;
input                                     ds22_arvalid;
input                                     ds22_awready;
input                                     ds22_awvalid;
input                                     ds22_bready;
input                                     ds22_bvalid;
input                                     ds22_rlast;
input                                     ds22_rready;
input                                     ds22_rvalid;
input                                     ds22_wlast;
input                                     ds22_wready;
input                                     ds22_wvalid;
`endif // ATCBMC300_SLV22_SUPPORT
`ifdef ATCBMC300_SLV23_SUPPORT
input                                     ds23_arready;
input                                     ds23_arvalid;
input                                     ds23_awready;
input                                     ds23_awvalid;
input                                     ds23_bready;
input                                     ds23_bvalid;
input                                     ds23_rlast;
input                                     ds23_rready;
input                                     ds23_rvalid;
input                                     ds23_wlast;
input                                     ds23_wready;
input                                     ds23_wvalid;
`endif // ATCBMC300_SLV23_SUPPORT
`ifdef ATCBMC300_SLV24_SUPPORT
input                                     ds24_arready;
input                                     ds24_arvalid;
input                                     ds24_awready;
input                                     ds24_awvalid;
input                                     ds24_bready;
input                                     ds24_bvalid;
input                                     ds24_rlast;
input                                     ds24_rready;
input                                     ds24_rvalid;
input                                     ds24_wlast;
input                                     ds24_wready;
input                                     ds24_wvalid;
`endif // ATCBMC300_SLV24_SUPPORT
`ifdef ATCBMC300_SLV25_SUPPORT
input                                     ds25_arready;
input                                     ds25_arvalid;
input                                     ds25_awready;
input                                     ds25_awvalid;
input                                     ds25_bready;
input                                     ds25_bvalid;
input                                     ds25_rlast;
input                                     ds25_rready;
input                                     ds25_rvalid;
input                                     ds25_wlast;
input                                     ds25_wready;
input                                     ds25_wvalid;
`endif // ATCBMC300_SLV25_SUPPORT
`ifdef ATCBMC300_SLV26_SUPPORT
input                                     ds26_arready;
input                                     ds26_arvalid;
input                                     ds26_awready;
input                                     ds26_awvalid;
input                                     ds26_bready;
input                                     ds26_bvalid;
input                                     ds26_rlast;
input                                     ds26_rready;
input                                     ds26_rvalid;
input                                     ds26_wlast;
input                                     ds26_wready;
input                                     ds26_wvalid;
`endif // ATCBMC300_SLV26_SUPPORT
`ifdef ATCBMC300_SLV27_SUPPORT
input                                     ds27_arready;
input                                     ds27_arvalid;
input                                     ds27_awready;
input                                     ds27_awvalid;
input                                     ds27_bready;
input                                     ds27_bvalid;
input                                     ds27_rlast;
input                                     ds27_rready;
input                                     ds27_rvalid;
input                                     ds27_wlast;
input                                     ds27_wready;
input                                     ds27_wvalid;
`endif // ATCBMC300_SLV27_SUPPORT
`ifdef ATCBMC300_SLV28_SUPPORT
input                                     ds28_arready;
input                                     ds28_arvalid;
input                                     ds28_awready;
input                                     ds28_awvalid;
input                                     ds28_bready;
input                                     ds28_bvalid;
input                                     ds28_rlast;
input                                     ds28_rready;
input                                     ds28_rvalid;
input                                     ds28_wlast;
input                                     ds28_wready;
input                                     ds28_wvalid;
`endif // ATCBMC300_SLV28_SUPPORT
`ifdef ATCBMC300_SLV29_SUPPORT
input                                     ds29_arready;
input                                     ds29_arvalid;
input                                     ds29_awready;
input                                     ds29_awvalid;
input                                     ds29_bready;
input                                     ds29_bvalid;
input                                     ds29_rlast;
input                                     ds29_rready;
input                                     ds29_rvalid;
input                                     ds29_wlast;
input                                     ds29_wready;
input                                     ds29_wvalid;
`endif // ATCBMC300_SLV29_SUPPORT
`ifdef ATCBMC300_SLV30_SUPPORT
input                                     ds30_arready;
input                                     ds30_arvalid;
input                                     ds30_awready;
input                                     ds30_awvalid;
input                                     ds30_bready;
input                                     ds30_bvalid;
input                                     ds30_rlast;
input                                     ds30_rready;
input                                     ds30_rvalid;
input                                     ds30_wlast;
input                                     ds30_wready;
input                                     ds30_wvalid;
`endif // ATCBMC300_SLV30_SUPPORT
`ifdef ATCBMC300_SLV31_SUPPORT
input                                     ds31_arready;
input                                     ds31_arvalid;
input                                     ds31_awready;
input                                     ds31_awvalid;
input                                     ds31_bready;
input                                     ds31_bvalid;
input                                     ds31_rlast;
input                                     ds31_rready;
input                                     ds31_rvalid;
input                                     ds31_wlast;
input                                     ds31_wready;
input                                     ds31_wvalid;
`endif // ATCBMC300_SLV31_SUPPORT
input                                     aclk;
input                                     aresetn;
input                                     reg_mst0_high_priority;
input                              [15:0] reg_priority_reload;


ASM_reg_mst0_high_priority_fixed: assume property ( @(posedge aclk) disable iff (!aresetn)
                ##1 $stable(reg_mst0_high_priority));
ASM_reg_priority_reload_fixed: assume property ( @(posedge aclk) disable iff (!aresetn)
                ##1 $stable(reg_priority_reload) && reg_priority_reload[0]==reg_priority_reload[1] && reg_priority_reload[0]==reg_priority_reload[2]);

ASM_addr_range_limit: assume property ( @(posedge aclk) disable iff (!aresetn)
		1'b1
`ifdef ATCBMC300_MST0_SUPPORT
		&& ((us0_araddr[19:0] & 20'hfef00) == 20'h0 && (us0_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST1_SUPPORT
		&& ((us1_araddr[19:0] & 20'hfef00) == 20'h0 && (us1_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST2_SUPPORT
		&& ((us2_araddr[19:0] & 20'hfef00) == 20'h0 && (us2_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST3_SUPPORT
		&& ((us3_araddr[19:0] & 20'hfef00) == 20'h0 && (us3_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST4_SUPPORT
		&& ((us4_araddr[19:0] & 20'hfef00) == 20'h0 && (us4_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST5_SUPPORT
		&& ((us5_araddr[19:0] & 20'hfef00) == 20'h0 && (us5_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST6_SUPPORT
		&& ((us6_araddr[19:0] & 20'hfef00) == 20'h0 && (us6_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST7_SUPPORT
		&& ((us7_araddr[19:0] & 20'hfef00) == 20'h0 && (us7_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST8_SUPPORT
		&& ((us8_araddr[19:0] & 20'hfef00) == 20'h0 && (us8_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST9_SUPPORT
		&& ((us9_araddr[19:0] & 20'hfef00) == 20'h0 && (us9_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST10_SUPPORT
		&& ((us10_araddr[19:0] & 20'hfef00) == 20'h0 && (us10_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST11_SUPPORT
		&& ((us11_araddr[19:0] & 20'hfef00) == 20'h0 && (us11_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST12_SUPPORT
		&& ((us12_araddr[19:0] & 20'hfef00) == 20'h0 && (us12_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST13_SUPPORT
		&& ((us13_araddr[19:0] & 20'hfef00) == 20'h0 && (us13_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST14_SUPPORT
		&& ((us14_araddr[19:0] & 20'hfef00) == 20'h0 && (us14_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
`ifdef ATCBMC300_MST15_SUPPORT
		&& ((us15_araddr[19:0] & 20'hfef00) == 20'h0 && (us15_awaddr[19:0] & 20'hfef00) == 20'h0)
`endif
		);

`ifdef ATCBMC300_MST0_SUPPORT
	reg [2:0]	us0_awcnt;
	reg [2:0]	us0_wcnt;
	reg [2:0]	us0_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us0_awcnt <= 3'b0;
	end
	else if (us0_awvalid && us0_awready) begin
		us0_awcnt <= us0_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us0_wcnt <= 3'b0;
	end
	else if (us0_wvalid && us0_wready && us0_wlast) begin
		us0_wcnt <= us0_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us0_bcnt <= 3'b0;
	end
	else if (us0_bvalid && us0_bready) begin
		us0_bcnt <= us0_bcnt + 3'b1;
	end
end

	wire us0_wvalid_ready = us0_wvalid && us0_wready && us0_wlast;
	wire us0_rvalid_ready = us0_rvalid && us0_rready && us0_rlast;
	wire us0_awvalid_ready = us0_awvalid && us0_awready;
	wire us0_arvalid_ready = us0_arvalid && us0_arready;
	wire us0_bvalid_ready = us0_bvalid && us0_bready;

us0_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us0_awcnt != us0_wcnt |-> ##[1:1+`WMAXLEN*2] us0_awcnt == us0_wcnt);
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	reg [2:0]	us1_awcnt;
	reg [2:0]	us1_wcnt;
	reg [2:0]	us1_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us1_awcnt <= 3'b0;
	end
	else if (us1_awvalid && us1_awready) begin
		us1_awcnt <= us1_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us1_wcnt <= 3'b0;
	end
	else if (us1_wvalid && us1_wready && us1_wlast) begin
		us1_wcnt <= us1_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us1_bcnt <= 3'b0;
	end
	else if (us1_bvalid && us1_bready) begin
		us1_bcnt <= us1_bcnt + 3'b1;
	end
end

	wire us1_wvalid_ready = us1_wvalid && us1_wready && us1_wlast;
	wire us1_rvalid_ready = us1_rvalid && us1_rready && us1_rlast;
	wire us1_awvalid_ready = us1_awvalid && us1_awready;
	wire us1_arvalid_ready = us1_arvalid && us1_arready;
	wire us1_bvalid_ready = us1_bvalid && us1_bready;

us1_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us1_awcnt != us1_wcnt |-> ##[1:1+`WMAXLEN*2] us1_awcnt == us1_wcnt);
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	reg [2:0]	us2_awcnt;
	reg [2:0]	us2_wcnt;
	reg [2:0]	us2_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us2_awcnt <= 3'b0;
	end
	else if (us2_awvalid && us2_awready) begin
		us2_awcnt <= us2_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us2_wcnt <= 3'b0;
	end
	else if (us2_wvalid && us2_wready && us2_wlast) begin
		us2_wcnt <= us2_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us2_bcnt <= 3'b0;
	end
	else if (us2_bvalid && us2_bready) begin
		us2_bcnt <= us2_bcnt + 3'b1;
	end
end

	wire us2_wvalid_ready = us2_wvalid && us2_wready && us2_wlast;
	wire us2_rvalid_ready = us2_rvalid && us2_rready && us2_rlast;
	wire us2_awvalid_ready = us2_awvalid && us2_awready;
	wire us2_arvalid_ready = us2_arvalid && us2_arready;
	wire us2_bvalid_ready = us2_bvalid && us2_bready;

us2_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us2_awcnt != us2_wcnt |-> ##[1:1+`WMAXLEN*2] us2_awcnt == us2_wcnt);
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	reg [2:0]	us3_awcnt;
	reg [2:0]	us3_wcnt;
	reg [2:0]	us3_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us3_awcnt <= 3'b0;
	end
	else if (us3_awvalid && us3_awready) begin
		us3_awcnt <= us3_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us3_wcnt <= 3'b0;
	end
	else if (us3_wvalid && us3_wready && us3_wlast) begin
		us3_wcnt <= us3_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us3_bcnt <= 3'b0;
	end
	else if (us3_bvalid && us3_bready) begin
		us3_bcnt <= us3_bcnt + 3'b1;
	end
end

	wire us3_wvalid_ready = us3_wvalid && us3_wready && us3_wlast;
	wire us3_rvalid_ready = us3_rvalid && us3_rready && us3_rlast;
	wire us3_awvalid_ready = us3_awvalid && us3_awready;
	wire us3_arvalid_ready = us3_arvalid && us3_arready;
	wire us3_bvalid_ready = us3_bvalid && us3_bready;

us3_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us3_awcnt != us3_wcnt |-> ##[1:1+`WMAXLEN*2] us3_awcnt == us3_wcnt);
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	reg [2:0]	us4_awcnt;
	reg [2:0]	us4_wcnt;
	reg [2:0]	us4_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us4_awcnt <= 3'b0;
	end
	else if (us4_awvalid && us4_awready) begin
		us4_awcnt <= us4_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us4_wcnt <= 3'b0;
	end
	else if (us4_wvalid && us4_wready && us4_wlast) begin
		us4_wcnt <= us4_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us4_bcnt <= 3'b0;
	end
	else if (us4_bvalid && us4_bready) begin
		us4_bcnt <= us4_bcnt + 3'b1;
	end
end

	wire us4_wvalid_ready = us4_wvalid && us4_wready && us4_wlast;
	wire us4_rvalid_ready = us4_rvalid && us4_rready && us4_rlast;
	wire us4_awvalid_ready = us4_awvalid && us4_awready;
	wire us4_arvalid_ready = us4_arvalid && us4_arready;
	wire us4_bvalid_ready = us4_bvalid && us4_bready;

us4_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us4_awcnt != us4_wcnt |-> ##[1:1+`WMAXLEN*2] us4_awcnt == us4_wcnt);
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	reg [2:0]	us5_awcnt;
	reg [2:0]	us5_wcnt;
	reg [2:0]	us5_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us5_awcnt <= 3'b0;
	end
	else if (us5_awvalid && us5_awready) begin
		us5_awcnt <= us5_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us5_wcnt <= 3'b0;
	end
	else if (us5_wvalid && us5_wready && us5_wlast) begin
		us5_wcnt <= us5_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us5_bcnt <= 3'b0;
	end
	else if (us5_bvalid && us5_bready) begin
		us5_bcnt <= us5_bcnt + 3'b1;
	end
end

	wire us5_wvalid_ready = us5_wvalid && us5_wready && us5_wlast;
	wire us5_rvalid_ready = us5_rvalid && us5_rready && us5_rlast;
	wire us5_awvalid_ready = us5_awvalid && us5_awready;
	wire us5_arvalid_ready = us5_arvalid && us5_arready;
	wire us5_bvalid_ready = us5_bvalid && us5_bready;

us5_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us5_awcnt != us5_wcnt |-> ##[1:1+`WMAXLEN*2] us5_awcnt == us5_wcnt);
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	reg [2:0]	us6_awcnt;
	reg [2:0]	us6_wcnt;
	reg [2:0]	us6_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us6_awcnt <= 3'b0;
	end
	else if (us6_awvalid && us6_awready) begin
		us6_awcnt <= us6_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us6_wcnt <= 3'b0;
	end
	else if (us6_wvalid && us6_wready && us6_wlast) begin
		us6_wcnt <= us6_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us6_bcnt <= 3'b0;
	end
	else if (us6_bvalid && us6_bready) begin
		us6_bcnt <= us6_bcnt + 3'b1;
	end
end

	wire us6_wvalid_ready = us6_wvalid && us6_wready && us6_wlast;
	wire us6_rvalid_ready = us6_rvalid && us6_rready && us6_rlast;
	wire us6_awvalid_ready = us6_awvalid && us6_awready;
	wire us6_arvalid_ready = us6_arvalid && us6_arready;
	wire us6_bvalid_ready = us6_bvalid && us6_bready;

us6_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us6_awcnt != us6_wcnt |-> ##[1:1+`WMAXLEN*2] us6_awcnt == us6_wcnt);
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	reg [2:0]	us7_awcnt;
	reg [2:0]	us7_wcnt;
	reg [2:0]	us7_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us7_awcnt <= 3'b0;
	end
	else if (us7_awvalid && us7_awready) begin
		us7_awcnt <= us7_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us7_wcnt <= 3'b0;
	end
	else if (us7_wvalid && us7_wready && us7_wlast) begin
		us7_wcnt <= us7_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us7_bcnt <= 3'b0;
	end
	else if (us7_bvalid && us7_bready) begin
		us7_bcnt <= us7_bcnt + 3'b1;
	end
end

	wire us7_wvalid_ready = us7_wvalid && us7_wready && us7_wlast;
	wire us7_rvalid_ready = us7_rvalid && us7_rready && us7_rlast;
	wire us7_awvalid_ready = us7_awvalid && us7_awready;
	wire us7_arvalid_ready = us7_arvalid && us7_arready;
	wire us7_bvalid_ready = us7_bvalid && us7_bready;

us7_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us7_awcnt != us7_wcnt |-> ##[1:1+`WMAXLEN*2] us7_awcnt == us7_wcnt);
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	reg [2:0]	us8_awcnt;
	reg [2:0]	us8_wcnt;
	reg [2:0]	us8_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us8_awcnt <= 3'b0;
	end
	else if (us8_awvalid && us8_awready) begin
		us8_awcnt <= us8_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us8_wcnt <= 3'b0;
	end
	else if (us8_wvalid && us8_wready && us8_wlast) begin
		us8_wcnt <= us8_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us8_bcnt <= 3'b0;
	end
	else if (us8_bvalid && us8_bready) begin
		us8_bcnt <= us8_bcnt + 3'b1;
	end
end

	wire us8_wvalid_ready = us8_wvalid && us8_wready && us8_wlast;
	wire us8_rvalid_ready = us8_rvalid && us8_rready && us8_rlast;
	wire us8_awvalid_ready = us8_awvalid && us8_awready;
	wire us8_arvalid_ready = us8_arvalid && us8_arready;
	wire us8_bvalid_ready = us8_bvalid && us8_bready;

us8_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us8_awcnt != us8_wcnt |-> ##[1:1+`WMAXLEN*2] us8_awcnt == us8_wcnt);
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	reg [2:0]	us9_awcnt;
	reg [2:0]	us9_wcnt;
	reg [2:0]	us9_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us9_awcnt <= 3'b0;
	end
	else if (us9_awvalid && us9_awready) begin
		us9_awcnt <= us9_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us9_wcnt <= 3'b0;
	end
	else if (us9_wvalid && us9_wready && us9_wlast) begin
		us9_wcnt <= us9_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us9_bcnt <= 3'b0;
	end
	else if (us9_bvalid && us9_bready) begin
		us9_bcnt <= us9_bcnt + 3'b1;
	end
end

	wire us9_wvalid_ready = us9_wvalid && us9_wready && us9_wlast;
	wire us9_rvalid_ready = us9_rvalid && us9_rready && us9_rlast;
	wire us9_awvalid_ready = us9_awvalid && us9_awready;
	wire us9_arvalid_ready = us9_arvalid && us9_arready;
	wire us9_bvalid_ready = us9_bvalid && us9_bready;

us9_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us9_awcnt != us9_wcnt |-> ##[1:1+`WMAXLEN*2] us9_awcnt == us9_wcnt);
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	reg [2:0]	us10_awcnt;
	reg [2:0]	us10_wcnt;
	reg [2:0]	us10_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us10_awcnt <= 3'b0;
	end
	else if (us10_awvalid && us10_awready) begin
		us10_awcnt <= us10_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us10_wcnt <= 3'b0;
	end
	else if (us10_wvalid && us10_wready && us10_wlast) begin
		us10_wcnt <= us10_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us10_bcnt <= 3'b0;
	end
	else if (us10_bvalid && us10_bready) begin
		us10_bcnt <= us10_bcnt + 3'b1;
	end
end

	wire us10_wvalid_ready = us10_wvalid && us10_wready && us10_wlast;
	wire us10_rvalid_ready = us10_rvalid && us10_rready && us10_rlast;
	wire us10_awvalid_ready = us10_awvalid && us10_awready;
	wire us10_arvalid_ready = us10_arvalid && us10_arready;
	wire us10_bvalid_ready = us10_bvalid && us10_bready;

us10_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us10_awcnt != us10_wcnt |-> ##[1:1+`WMAXLEN*2] us10_awcnt == us10_wcnt);
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	reg [2:0]	us11_awcnt;
	reg [2:0]	us11_wcnt;
	reg [2:0]	us11_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us11_awcnt <= 3'b0;
	end
	else if (us11_awvalid && us11_awready) begin
		us11_awcnt <= us11_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us11_wcnt <= 3'b0;
	end
	else if (us11_wvalid && us11_wready && us11_wlast) begin
		us11_wcnt <= us11_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us11_bcnt <= 3'b0;
	end
	else if (us11_bvalid && us11_bready) begin
		us11_bcnt <= us11_bcnt + 3'b1;
	end
end

	wire us11_wvalid_ready = us11_wvalid && us11_wready && us11_wlast;
	wire us11_rvalid_ready = us11_rvalid && us11_rready && us11_rlast;
	wire us11_awvalid_ready = us11_awvalid && us11_awready;
	wire us11_arvalid_ready = us11_arvalid && us11_arready;
	wire us11_bvalid_ready = us11_bvalid && us11_bready;

us11_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us11_awcnt != us11_wcnt |-> ##[1:1+`WMAXLEN*2] us11_awcnt == us11_wcnt);
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	reg [2:0]	us12_awcnt;
	reg [2:0]	us12_wcnt;
	reg [2:0]	us12_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us12_awcnt <= 3'b0;
	end
	else if (us12_awvalid && us12_awready) begin
		us12_awcnt <= us12_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us12_wcnt <= 3'b0;
	end
	else if (us12_wvalid && us12_wready && us12_wlast) begin
		us12_wcnt <= us12_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us12_bcnt <= 3'b0;
	end
	else if (us12_bvalid && us12_bready) begin
		us12_bcnt <= us12_bcnt + 3'b1;
	end
end

	wire us12_wvalid_ready = us12_wvalid && us12_wready && us12_wlast;
	wire us12_rvalid_ready = us12_rvalid && us12_rready && us12_rlast;
	wire us12_awvalid_ready = us12_awvalid && us12_awready;
	wire us12_arvalid_ready = us12_arvalid && us12_arready;
	wire us12_bvalid_ready = us12_bvalid && us12_bready;

us12_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us12_awcnt != us12_wcnt |-> ##[1:1+`WMAXLEN*2] us12_awcnt == us12_wcnt);
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	reg [2:0]	us13_awcnt;
	reg [2:0]	us13_wcnt;
	reg [2:0]	us13_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us13_awcnt <= 3'b0;
	end
	else if (us13_awvalid && us13_awready) begin
		us13_awcnt <= us13_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us13_wcnt <= 3'b0;
	end
	else if (us13_wvalid && us13_wready && us13_wlast) begin
		us13_wcnt <= us13_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us13_bcnt <= 3'b0;
	end
	else if (us13_bvalid && us13_bready) begin
		us13_bcnt <= us13_bcnt + 3'b1;
	end
end

	wire us13_wvalid_ready = us13_wvalid && us13_wready && us13_wlast;
	wire us13_rvalid_ready = us13_rvalid && us13_rready && us13_rlast;
	wire us13_awvalid_ready = us13_awvalid && us13_awready;
	wire us13_arvalid_ready = us13_arvalid && us13_arready;
	wire us13_bvalid_ready = us13_bvalid && us13_bready;

us13_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us13_awcnt != us13_wcnt |-> ##[1:1+`WMAXLEN*2] us13_awcnt == us13_wcnt);
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	reg [2:0]	us14_awcnt;
	reg [2:0]	us14_wcnt;
	reg [2:0]	us14_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us14_awcnt <= 3'b0;
	end
	else if (us14_awvalid && us14_awready) begin
		us14_awcnt <= us14_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us14_wcnt <= 3'b0;
	end
	else if (us14_wvalid && us14_wready && us14_wlast) begin
		us14_wcnt <= us14_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us14_bcnt <= 3'b0;
	end
	else if (us14_bvalid && us14_bready) begin
		us14_bcnt <= us14_bcnt + 3'b1;
	end
end

	wire us14_wvalid_ready = us14_wvalid && us14_wready && us14_wlast;
	wire us14_rvalid_ready = us14_rvalid && us14_rready && us14_rlast;
	wire us14_awvalid_ready = us14_awvalid && us14_awready;
	wire us14_arvalid_ready = us14_arvalid && us14_arready;
	wire us14_bvalid_ready = us14_bvalid && us14_bready;

us14_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us14_awcnt != us14_wcnt |-> ##[1:1+`WMAXLEN*2] us14_awcnt == us14_wcnt);
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	reg [2:0]	us15_awcnt;
	reg [2:0]	us15_wcnt;
	reg [2:0]	us15_bcnt;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us15_awcnt <= 3'b0;
	end
	else if (us15_awvalid && us15_awready) begin
		us15_awcnt <= us15_awcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us15_wcnt <= 3'b0;
	end
	else if (us15_wvalid && us15_wready && us15_wlast) begin
		us15_wcnt <= us15_wcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us15_bcnt <= 3'b0;
	end
	else if (us15_bvalid && us15_bready) begin
		us15_bcnt <= us15_bcnt + 3'b1;
	end
end

	wire us15_wvalid_ready = us15_wvalid && us15_wready && us15_wlast;
	wire us15_rvalid_ready = us15_rvalid && us15_rready && us15_rlast;
	wire us15_awvalid_ready = us15_awvalid && us15_awready;
	wire us15_arvalid_ready = us15_arvalid && us15_arready;
	wire us15_bvalid_ready = us15_bvalid && us15_bready;

us15_wv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                us15_awcnt != us15_wcnt |-> ##[1:1+`WMAXLEN*2] us15_awcnt == us15_wcnt);
`endif

`ifdef ATCBMC300_SLV1_SUPPORT
	reg [2:0]	ds1_arcnt;
	reg [2:0]	ds1_rcnt;
	reg [2:0]	ds1_wcnt;
	reg [2:0]	ds1_bcnt;

	wire ds1_wvalid_ready = ds1_wvalid && ds1_wready && ds1_wlast;
	wire ds1_rvalid_ready = ds1_rvalid && ds1_rready && ds1_rlast;
	wire ds1_awvalid_ready = ds1_awvalid && ds1_awready;
	wire ds1_arvalid_ready = ds1_arvalid && ds1_arready;
	wire ds1_bvalid_ready = ds1_bvalid && ds1_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds1_arcnt <= 3'b0;
	end
	else if (ds1_arvalid_ready) begin
		ds1_arcnt <= ds1_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds1_rcnt <= 3'b0;
	end
	else if (ds1_rvalid_ready) begin
		ds1_rcnt <= ds1_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds1_wcnt <= 3'b0;
	end
	else if (ds1_wvalid_ready) begin
		ds1_wcnt <= ds1_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds1_bcnt <= 3'b0;
	end
	else if (ds1_bvalid_ready) begin
		ds1_bcnt <= ds1_bcnt + 3'b1;
	end
end

ds1_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds1_wcnt != ds1_bcnt) |-> ##[1:2] (ds1_wcnt == ds1_bcnt));
ds1_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds1_arcnt != ds1_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds1_arcnt == ds1_rcnt));
`endif

`ifdef ATCBMC300_SLV2_SUPPORT
	reg [2:0]	ds2_arcnt;
	reg [2:0]	ds2_rcnt;
	reg [2:0]	ds2_wcnt;
	reg [2:0]	ds2_bcnt;

	wire ds2_wvalid_ready = ds2_wvalid && ds2_wready && ds2_wlast;
	wire ds2_rvalid_ready = ds2_rvalid && ds2_rready && ds2_rlast;
	wire ds2_awvalid_ready = ds2_awvalid && ds2_awready;
	wire ds2_arvalid_ready = ds2_arvalid && ds2_arready;
	wire ds2_bvalid_ready = ds2_bvalid && ds2_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds2_arcnt <= 3'b0;
	end
	else if (ds2_arvalid_ready) begin
		ds2_arcnt <= ds2_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds2_rcnt <= 3'b0;
	end
	else if (ds2_rvalid_ready) begin
		ds2_rcnt <= ds2_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds2_wcnt <= 3'b0;
	end
	else if (ds2_wvalid_ready) begin
		ds2_wcnt <= ds2_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds2_bcnt <= 3'b0;
	end
	else if (ds2_bvalid_ready) begin
		ds2_bcnt <= ds2_bcnt + 3'b1;
	end
end

ds2_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds2_wcnt != ds2_bcnt) |-> ##[1:2] (ds2_wcnt == ds2_bcnt));
ds2_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds2_arcnt != ds2_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds2_arcnt == ds2_rcnt));
`endif

`ifdef ATCBMC300_SLV3_SUPPORT
	reg [2:0]	ds3_arcnt;
	reg [2:0]	ds3_rcnt;
	reg [2:0]	ds3_wcnt;
	reg [2:0]	ds3_bcnt;

	wire ds3_wvalid_ready = ds3_wvalid && ds3_wready && ds3_wlast;
	wire ds3_rvalid_ready = ds3_rvalid && ds3_rready && ds3_rlast;
	wire ds3_awvalid_ready = ds3_awvalid && ds3_awready;
	wire ds3_arvalid_ready = ds3_arvalid && ds3_arready;
	wire ds3_bvalid_ready = ds3_bvalid && ds3_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds3_arcnt <= 3'b0;
	end
	else if (ds3_arvalid_ready) begin
		ds3_arcnt <= ds3_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds3_rcnt <= 3'b0;
	end
	else if (ds3_rvalid_ready) begin
		ds3_rcnt <= ds3_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds3_wcnt <= 3'b0;
	end
	else if (ds3_wvalid_ready) begin
		ds3_wcnt <= ds3_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds3_bcnt <= 3'b0;
	end
	else if (ds3_bvalid_ready) begin
		ds3_bcnt <= ds3_bcnt + 3'b1;
	end
end

ds3_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds3_wcnt != ds3_bcnt) |-> ##[1:2] (ds3_wcnt == ds3_bcnt));
ds3_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds3_arcnt != ds3_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds3_arcnt == ds3_rcnt));
`endif

`ifdef ATCBMC300_SLV4_SUPPORT
	reg [2:0]	ds4_arcnt;
	reg [2:0]	ds4_rcnt;
	reg [2:0]	ds4_wcnt;
	reg [2:0]	ds4_bcnt;

	wire ds4_wvalid_ready = ds4_wvalid && ds4_wready && ds4_wlast;
	wire ds4_rvalid_ready = ds4_rvalid && ds4_rready && ds4_rlast;
	wire ds4_awvalid_ready = ds4_awvalid && ds4_awready;
	wire ds4_arvalid_ready = ds4_arvalid && ds4_arready;
	wire ds4_bvalid_ready = ds4_bvalid && ds4_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds4_arcnt <= 3'b0;
	end
	else if (ds4_arvalid_ready) begin
		ds4_arcnt <= ds4_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds4_rcnt <= 3'b0;
	end
	else if (ds4_rvalid_ready) begin
		ds4_rcnt <= ds4_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds4_wcnt <= 3'b0;
	end
	else if (ds4_wvalid_ready) begin
		ds4_wcnt <= ds4_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds4_bcnt <= 3'b0;
	end
	else if (ds4_bvalid_ready) begin
		ds4_bcnt <= ds4_bcnt + 3'b1;
	end
end

ds4_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds4_wcnt != ds4_bcnt) |-> ##[1:2] (ds4_wcnt == ds4_bcnt));
ds4_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds4_arcnt != ds4_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds4_arcnt == ds4_rcnt));
`endif

`ifdef ATCBMC300_SLV5_SUPPORT
	reg [2:0]	ds5_arcnt;
	reg [2:0]	ds5_rcnt;
	reg [2:0]	ds5_wcnt;
	reg [2:0]	ds5_bcnt;

	wire ds5_wvalid_ready = ds5_wvalid && ds5_wready && ds5_wlast;
	wire ds5_rvalid_ready = ds5_rvalid && ds5_rready && ds5_rlast;
	wire ds5_awvalid_ready = ds5_awvalid && ds5_awready;
	wire ds5_arvalid_ready = ds5_arvalid && ds5_arready;
	wire ds5_bvalid_ready = ds5_bvalid && ds5_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds5_arcnt <= 3'b0;
	end
	else if (ds5_arvalid_ready) begin
		ds5_arcnt <= ds5_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds5_rcnt <= 3'b0;
	end
	else if (ds5_rvalid_ready) begin
		ds5_rcnt <= ds5_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds5_wcnt <= 3'b0;
	end
	else if (ds5_wvalid_ready) begin
		ds5_wcnt <= ds5_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds5_bcnt <= 3'b0;
	end
	else if (ds5_bvalid_ready) begin
		ds5_bcnt <= ds5_bcnt + 3'b1;
	end
end

ds5_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds5_wcnt != ds5_bcnt) |-> ##[1:2] (ds5_wcnt == ds5_bcnt));
ds5_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds5_arcnt != ds5_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds5_arcnt == ds5_rcnt));
`endif

`ifdef ATCBMC300_SLV6_SUPPORT
	reg [2:0]	ds6_arcnt;
	reg [2:0]	ds6_rcnt;
	reg [2:0]	ds6_wcnt;
	reg [2:0]	ds6_bcnt;

	wire ds6_wvalid_ready = ds6_wvalid && ds6_wready && ds6_wlast;
	wire ds6_rvalid_ready = ds6_rvalid && ds6_rready && ds6_rlast;
	wire ds6_awvalid_ready = ds6_awvalid && ds6_awready;
	wire ds6_arvalid_ready = ds6_arvalid && ds6_arready;
	wire ds6_bvalid_ready = ds6_bvalid && ds6_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds6_arcnt <= 3'b0;
	end
	else if (ds6_arvalid_ready) begin
		ds6_arcnt <= ds6_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds6_rcnt <= 3'b0;
	end
	else if (ds6_rvalid_ready) begin
		ds6_rcnt <= ds6_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds6_wcnt <= 3'b0;
	end
	else if (ds6_wvalid_ready) begin
		ds6_wcnt <= ds6_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds6_bcnt <= 3'b0;
	end
	else if (ds6_bvalid_ready) begin
		ds6_bcnt <= ds6_bcnt + 3'b1;
	end
end

ds6_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds6_wcnt != ds6_bcnt) |-> ##[1:2] (ds6_wcnt == ds6_bcnt));
ds6_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds6_arcnt != ds6_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds6_arcnt == ds6_rcnt));
`endif

`ifdef ATCBMC300_SLV7_SUPPORT
	reg [2:0]	ds7_arcnt;
	reg [2:0]	ds7_rcnt;
	reg [2:0]	ds7_wcnt;
	reg [2:0]	ds7_bcnt;

	wire ds7_wvalid_ready = ds7_wvalid && ds7_wready && ds7_wlast;
	wire ds7_rvalid_ready = ds7_rvalid && ds7_rready && ds7_rlast;
	wire ds7_awvalid_ready = ds7_awvalid && ds7_awready;
	wire ds7_arvalid_ready = ds7_arvalid && ds7_arready;
	wire ds7_bvalid_ready = ds7_bvalid && ds7_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds7_arcnt <= 3'b0;
	end
	else if (ds7_arvalid_ready) begin
		ds7_arcnt <= ds7_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds7_rcnt <= 3'b0;
	end
	else if (ds7_rvalid_ready) begin
		ds7_rcnt <= ds7_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds7_wcnt <= 3'b0;
	end
	else if (ds7_wvalid_ready) begin
		ds7_wcnt <= ds7_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds7_bcnt <= 3'b0;
	end
	else if (ds7_bvalid_ready) begin
		ds7_bcnt <= ds7_bcnt + 3'b1;
	end
end

ds7_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds7_wcnt != ds7_bcnt) |-> ##[1:2] (ds7_wcnt == ds7_bcnt));
ds7_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds7_arcnt != ds7_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds7_arcnt == ds7_rcnt));
`endif

`ifdef ATCBMC300_SLV8_SUPPORT
	reg [2:0]	ds8_arcnt;
	reg [2:0]	ds8_rcnt;
	reg [2:0]	ds8_wcnt;
	reg [2:0]	ds8_bcnt;

	wire ds8_wvalid_ready = ds8_wvalid && ds8_wready && ds8_wlast;
	wire ds8_rvalid_ready = ds8_rvalid && ds8_rready && ds8_rlast;
	wire ds8_awvalid_ready = ds8_awvalid && ds8_awready;
	wire ds8_arvalid_ready = ds8_arvalid && ds8_arready;
	wire ds8_bvalid_ready = ds8_bvalid && ds8_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds8_arcnt <= 3'b0;
	end
	else if (ds8_arvalid_ready) begin
		ds8_arcnt <= ds8_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds8_rcnt <= 3'b0;
	end
	else if (ds8_rvalid_ready) begin
		ds8_rcnt <= ds8_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds8_wcnt <= 3'b0;
	end
	else if (ds8_wvalid_ready) begin
		ds8_wcnt <= ds8_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds8_bcnt <= 3'b0;
	end
	else if (ds8_bvalid_ready) begin
		ds8_bcnt <= ds8_bcnt + 3'b1;
	end
end

ds8_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds8_wcnt != ds8_bcnt) |-> ##[1:2] (ds8_wcnt == ds8_bcnt));
ds8_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds8_arcnt != ds8_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds8_arcnt == ds8_rcnt));
`endif

`ifdef ATCBMC300_SLV9_SUPPORT
	reg [2:0]	ds9_arcnt;
	reg [2:0]	ds9_rcnt;
	reg [2:0]	ds9_wcnt;
	reg [2:0]	ds9_bcnt;

	wire ds9_wvalid_ready = ds9_wvalid && ds9_wready && ds9_wlast;
	wire ds9_rvalid_ready = ds9_rvalid && ds9_rready && ds9_rlast;
	wire ds9_awvalid_ready = ds9_awvalid && ds9_awready;
	wire ds9_arvalid_ready = ds9_arvalid && ds9_arready;
	wire ds9_bvalid_ready = ds9_bvalid && ds9_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds9_arcnt <= 3'b0;
	end
	else if (ds9_arvalid_ready) begin
		ds9_arcnt <= ds9_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds9_rcnt <= 3'b0;
	end
	else if (ds9_rvalid_ready) begin
		ds9_rcnt <= ds9_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds9_wcnt <= 3'b0;
	end
	else if (ds9_wvalid_ready) begin
		ds9_wcnt <= ds9_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds9_bcnt <= 3'b0;
	end
	else if (ds9_bvalid_ready) begin
		ds9_bcnt <= ds9_bcnt + 3'b1;
	end
end

ds9_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds9_wcnt != ds9_bcnt) |-> ##[1:2] (ds9_wcnt == ds9_bcnt));
ds9_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds9_arcnt != ds9_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds9_arcnt == ds9_rcnt));
`endif

`ifdef ATCBMC300_SLV10_SUPPORT
	reg [2:0]	ds10_arcnt;
	reg [2:0]	ds10_rcnt;
	reg [2:0]	ds10_wcnt;
	reg [2:0]	ds10_bcnt;

	wire ds10_wvalid_ready = ds10_wvalid && ds10_wready && ds10_wlast;
	wire ds10_rvalid_ready = ds10_rvalid && ds10_rready && ds10_rlast;
	wire ds10_awvalid_ready = ds10_awvalid && ds10_awready;
	wire ds10_arvalid_ready = ds10_arvalid && ds10_arready;
	wire ds10_bvalid_ready = ds10_bvalid && ds10_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds10_arcnt <= 3'b0;
	end
	else if (ds10_arvalid_ready) begin
		ds10_arcnt <= ds10_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds10_rcnt <= 3'b0;
	end
	else if (ds10_rvalid_ready) begin
		ds10_rcnt <= ds10_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds10_wcnt <= 3'b0;
	end
	else if (ds10_wvalid_ready) begin
		ds10_wcnt <= ds10_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds10_bcnt <= 3'b0;
	end
	else if (ds10_bvalid_ready) begin
		ds10_bcnt <= ds10_bcnt + 3'b1;
	end
end

ds10_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds10_wcnt != ds10_bcnt) |-> ##[1:2] (ds10_wcnt == ds10_bcnt));
ds10_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds10_arcnt != ds10_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds10_arcnt == ds10_rcnt));
`endif

`ifdef ATCBMC300_SLV11_SUPPORT
	reg [2:0]	ds11_arcnt;
	reg [2:0]	ds11_rcnt;
	reg [2:0]	ds11_wcnt;
	reg [2:0]	ds11_bcnt;

	wire ds11_wvalid_ready = ds11_wvalid && ds11_wready && ds11_wlast;
	wire ds11_rvalid_ready = ds11_rvalid && ds11_rready && ds11_rlast;
	wire ds11_awvalid_ready = ds11_awvalid && ds11_awready;
	wire ds11_arvalid_ready = ds11_arvalid && ds11_arready;
	wire ds11_bvalid_ready = ds11_bvalid && ds11_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds11_arcnt <= 3'b0;
	end
	else if (ds11_arvalid_ready) begin
		ds11_arcnt <= ds11_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds11_rcnt <= 3'b0;
	end
	else if (ds11_rvalid_ready) begin
		ds11_rcnt <= ds11_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds11_wcnt <= 3'b0;
	end
	else if (ds11_wvalid_ready) begin
		ds11_wcnt <= ds11_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds11_bcnt <= 3'b0;
	end
	else if (ds11_bvalid_ready) begin
		ds11_bcnt <= ds11_bcnt + 3'b1;
	end
end

ds11_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds11_wcnt != ds11_bcnt) |-> ##[1:2] (ds11_wcnt == ds11_bcnt));
ds11_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds11_arcnt != ds11_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds11_arcnt == ds11_rcnt));
`endif

`ifdef ATCBMC300_SLV12_SUPPORT
	reg [2:0]	ds12_arcnt;
	reg [2:0]	ds12_rcnt;
	reg [2:0]	ds12_wcnt;
	reg [2:0]	ds12_bcnt;

	wire ds12_wvalid_ready = ds12_wvalid && ds12_wready && ds12_wlast;
	wire ds12_rvalid_ready = ds12_rvalid && ds12_rready && ds12_rlast;
	wire ds12_awvalid_ready = ds12_awvalid && ds12_awready;
	wire ds12_arvalid_ready = ds12_arvalid && ds12_arready;
	wire ds12_bvalid_ready = ds12_bvalid && ds12_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds12_arcnt <= 3'b0;
	end
	else if (ds12_arvalid_ready) begin
		ds12_arcnt <= ds12_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds12_rcnt <= 3'b0;
	end
	else if (ds12_rvalid_ready) begin
		ds12_rcnt <= ds12_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds12_wcnt <= 3'b0;
	end
	else if (ds12_wvalid_ready) begin
		ds12_wcnt <= ds12_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds12_bcnt <= 3'b0;
	end
	else if (ds12_bvalid_ready) begin
		ds12_bcnt <= ds12_bcnt + 3'b1;
	end
end

ds12_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds12_wcnt != ds12_bcnt) |-> ##[1:2] (ds12_wcnt == ds12_bcnt));
ds12_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds12_arcnt != ds12_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds12_arcnt == ds12_rcnt));
`endif

`ifdef ATCBMC300_SLV13_SUPPORT
	reg [2:0]	ds13_arcnt;
	reg [2:0]	ds13_rcnt;
	reg [2:0]	ds13_wcnt;
	reg [2:0]	ds13_bcnt;

	wire ds13_wvalid_ready = ds13_wvalid && ds13_wready && ds13_wlast;
	wire ds13_rvalid_ready = ds13_rvalid && ds13_rready && ds13_rlast;
	wire ds13_awvalid_ready = ds13_awvalid && ds13_awready;
	wire ds13_arvalid_ready = ds13_arvalid && ds13_arready;
	wire ds13_bvalid_ready = ds13_bvalid && ds13_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds13_arcnt <= 3'b0;
	end
	else if (ds13_arvalid_ready) begin
		ds13_arcnt <= ds13_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds13_rcnt <= 3'b0;
	end
	else if (ds13_rvalid_ready) begin
		ds13_rcnt <= ds13_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds13_wcnt <= 3'b0;
	end
	else if (ds13_wvalid_ready) begin
		ds13_wcnt <= ds13_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds13_bcnt <= 3'b0;
	end
	else if (ds13_bvalid_ready) begin
		ds13_bcnt <= ds13_bcnt + 3'b1;
	end
end

ds13_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds13_wcnt != ds13_bcnt) |-> ##[1:2] (ds13_wcnt == ds13_bcnt));
ds13_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds13_arcnt != ds13_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds13_arcnt == ds13_rcnt));
`endif

`ifdef ATCBMC300_SLV14_SUPPORT
	reg [2:0]	ds14_arcnt;
	reg [2:0]	ds14_rcnt;
	reg [2:0]	ds14_wcnt;
	reg [2:0]	ds14_bcnt;

	wire ds14_wvalid_ready = ds14_wvalid && ds14_wready && ds14_wlast;
	wire ds14_rvalid_ready = ds14_rvalid && ds14_rready && ds14_rlast;
	wire ds14_awvalid_ready = ds14_awvalid && ds14_awready;
	wire ds14_arvalid_ready = ds14_arvalid && ds14_arready;
	wire ds14_bvalid_ready = ds14_bvalid && ds14_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds14_arcnt <= 3'b0;
	end
	else if (ds14_arvalid_ready) begin
		ds14_arcnt <= ds14_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds14_rcnt <= 3'b0;
	end
	else if (ds14_rvalid_ready) begin
		ds14_rcnt <= ds14_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds14_wcnt <= 3'b0;
	end
	else if (ds14_wvalid_ready) begin
		ds14_wcnt <= ds14_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds14_bcnt <= 3'b0;
	end
	else if (ds14_bvalid_ready) begin
		ds14_bcnt <= ds14_bcnt + 3'b1;
	end
end

ds14_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds14_wcnt != ds14_bcnt) |-> ##[1:2] (ds14_wcnt == ds14_bcnt));
ds14_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds14_arcnt != ds14_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds14_arcnt == ds14_rcnt));
`endif

`ifdef ATCBMC300_SLV15_SUPPORT
	reg [2:0]	ds15_arcnt;
	reg [2:0]	ds15_rcnt;
	reg [2:0]	ds15_wcnt;
	reg [2:0]	ds15_bcnt;

	wire ds15_wvalid_ready = ds15_wvalid && ds15_wready && ds15_wlast;
	wire ds15_rvalid_ready = ds15_rvalid && ds15_rready && ds15_rlast;
	wire ds15_awvalid_ready = ds15_awvalid && ds15_awready;
	wire ds15_arvalid_ready = ds15_arvalid && ds15_arready;
	wire ds15_bvalid_ready = ds15_bvalid && ds15_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds15_arcnt <= 3'b0;
	end
	else if (ds15_arvalid_ready) begin
		ds15_arcnt <= ds15_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds15_rcnt <= 3'b0;
	end
	else if (ds15_rvalid_ready) begin
		ds15_rcnt <= ds15_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds15_wcnt <= 3'b0;
	end
	else if (ds15_wvalid_ready) begin
		ds15_wcnt <= ds15_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds15_bcnt <= 3'b0;
	end
	else if (ds15_bvalid_ready) begin
		ds15_bcnt <= ds15_bcnt + 3'b1;
	end
end

ds15_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds15_wcnt != ds15_bcnt) |-> ##[1:2] (ds15_wcnt == ds15_bcnt));
ds15_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds15_arcnt != ds15_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds15_arcnt == ds15_rcnt));
`endif

`ifdef ATCBMC300_SLV16_SUPPORT
	reg [2:0]	ds16_arcnt;
	reg [2:0]	ds16_rcnt;
	reg [2:0]	ds16_wcnt;
	reg [2:0]	ds16_bcnt;

	wire ds16_wvalid_ready = ds16_wvalid && ds16_wready && ds16_wlast;
	wire ds16_rvalid_ready = ds16_rvalid && ds16_rready && ds16_rlast;
	wire ds16_awvalid_ready = ds16_awvalid && ds16_awready;
	wire ds16_arvalid_ready = ds16_arvalid && ds16_arready;
	wire ds16_bvalid_ready = ds16_bvalid && ds16_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds16_arcnt <= 3'b0;
	end
	else if (ds16_arvalid_ready) begin
		ds16_arcnt <= ds16_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds16_rcnt <= 3'b0;
	end
	else if (ds16_rvalid_ready) begin
		ds16_rcnt <= ds16_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds16_wcnt <= 3'b0;
	end
	else if (ds16_wvalid_ready) begin
		ds16_wcnt <= ds16_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds16_bcnt <= 3'b0;
	end
	else if (ds16_bvalid_ready) begin
		ds16_bcnt <= ds16_bcnt + 3'b1;
	end
end

ds16_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds16_wcnt != ds16_bcnt) |-> ##[1:2] (ds16_wcnt == ds16_bcnt));
ds16_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds16_arcnt != ds16_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds16_arcnt == ds16_rcnt));
`endif

`ifdef ATCBMC300_SLV17_SUPPORT
	reg [2:0]	ds17_arcnt;
	reg [2:0]	ds17_rcnt;
	reg [2:0]	ds17_wcnt;
	reg [2:0]	ds17_bcnt;

	wire ds17_wvalid_ready = ds17_wvalid && ds17_wready && ds17_wlast;
	wire ds17_rvalid_ready = ds17_rvalid && ds17_rready && ds17_rlast;
	wire ds17_awvalid_ready = ds17_awvalid && ds17_awready;
	wire ds17_arvalid_ready = ds17_arvalid && ds17_arready;
	wire ds17_bvalid_ready = ds17_bvalid && ds17_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds17_arcnt <= 3'b0;
	end
	else if (ds17_arvalid_ready) begin
		ds17_arcnt <= ds17_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds17_rcnt <= 3'b0;
	end
	else if (ds17_rvalid_ready) begin
		ds17_rcnt <= ds17_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds17_wcnt <= 3'b0;
	end
	else if (ds17_wvalid_ready) begin
		ds17_wcnt <= ds17_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds17_bcnt <= 3'b0;
	end
	else if (ds17_bvalid_ready) begin
		ds17_bcnt <= ds17_bcnt + 3'b1;
	end
end

ds17_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds17_wcnt != ds17_bcnt) |-> ##[1:2] (ds17_wcnt == ds17_bcnt));
ds17_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds17_arcnt != ds17_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds17_arcnt == ds17_rcnt));
`endif

`ifdef ATCBMC300_SLV18_SUPPORT
	reg [2:0]	ds18_arcnt;
	reg [2:0]	ds18_rcnt;
	reg [2:0]	ds18_wcnt;
	reg [2:0]	ds18_bcnt;

	wire ds18_wvalid_ready = ds18_wvalid && ds18_wready && ds18_wlast;
	wire ds18_rvalid_ready = ds18_rvalid && ds18_rready && ds18_rlast;
	wire ds18_awvalid_ready = ds18_awvalid && ds18_awready;
	wire ds18_arvalid_ready = ds18_arvalid && ds18_arready;
	wire ds18_bvalid_ready = ds18_bvalid && ds18_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds18_arcnt <= 3'b0;
	end
	else if (ds18_arvalid_ready) begin
		ds18_arcnt <= ds18_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds18_rcnt <= 3'b0;
	end
	else if (ds18_rvalid_ready) begin
		ds18_rcnt <= ds18_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds18_wcnt <= 3'b0;
	end
	else if (ds18_wvalid_ready) begin
		ds18_wcnt <= ds18_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds18_bcnt <= 3'b0;
	end
	else if (ds18_bvalid_ready) begin
		ds18_bcnt <= ds18_bcnt + 3'b1;
	end
end

ds18_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds18_wcnt != ds18_bcnt) |-> ##[1:2] (ds18_wcnt == ds18_bcnt));
ds18_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds18_arcnt != ds18_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds18_arcnt == ds18_rcnt));
`endif

`ifdef ATCBMC300_SLV19_SUPPORT
	reg [2:0]	ds19_arcnt;
	reg [2:0]	ds19_rcnt;
	reg [2:0]	ds19_wcnt;
	reg [2:0]	ds19_bcnt;

	wire ds19_wvalid_ready = ds19_wvalid && ds19_wready && ds19_wlast;
	wire ds19_rvalid_ready = ds19_rvalid && ds19_rready && ds19_rlast;
	wire ds19_awvalid_ready = ds19_awvalid && ds19_awready;
	wire ds19_arvalid_ready = ds19_arvalid && ds19_arready;
	wire ds19_bvalid_ready = ds19_bvalid && ds19_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds19_arcnt <= 3'b0;
	end
	else if (ds19_arvalid_ready) begin
		ds19_arcnt <= ds19_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds19_rcnt <= 3'b0;
	end
	else if (ds19_rvalid_ready) begin
		ds19_rcnt <= ds19_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds19_wcnt <= 3'b0;
	end
	else if (ds19_wvalid_ready) begin
		ds19_wcnt <= ds19_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds19_bcnt <= 3'b0;
	end
	else if (ds19_bvalid_ready) begin
		ds19_bcnt <= ds19_bcnt + 3'b1;
	end
end

ds19_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds19_wcnt != ds19_bcnt) |-> ##[1:2] (ds19_wcnt == ds19_bcnt));
ds19_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds19_arcnt != ds19_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds19_arcnt == ds19_rcnt));
`endif

`ifdef ATCBMC300_SLV20_SUPPORT
	reg [2:0]	ds20_arcnt;
	reg [2:0]	ds20_rcnt;
	reg [2:0]	ds20_wcnt;
	reg [2:0]	ds20_bcnt;

	wire ds20_wvalid_ready = ds20_wvalid && ds20_wready && ds20_wlast;
	wire ds20_rvalid_ready = ds20_rvalid && ds20_rready && ds20_rlast;
	wire ds20_awvalid_ready = ds20_awvalid && ds20_awready;
	wire ds20_arvalid_ready = ds20_arvalid && ds20_arready;
	wire ds20_bvalid_ready = ds20_bvalid && ds20_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds20_arcnt <= 3'b0;
	end
	else if (ds20_arvalid_ready) begin
		ds20_arcnt <= ds20_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds20_rcnt <= 3'b0;
	end
	else if (ds20_rvalid_ready) begin
		ds20_rcnt <= ds20_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds20_wcnt <= 3'b0;
	end
	else if (ds20_wvalid_ready) begin
		ds20_wcnt <= ds20_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds20_bcnt <= 3'b0;
	end
	else if (ds20_bvalid_ready) begin
		ds20_bcnt <= ds20_bcnt + 3'b1;
	end
end

ds20_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds20_wcnt != ds20_bcnt) |-> ##[1:2] (ds20_wcnt == ds20_bcnt));
ds20_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds20_arcnt != ds20_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds20_arcnt == ds20_rcnt));
`endif

`ifdef ATCBMC300_SLV21_SUPPORT
	reg [2:0]	ds21_arcnt;
	reg [2:0]	ds21_rcnt;
	reg [2:0]	ds21_wcnt;
	reg [2:0]	ds21_bcnt;

	wire ds21_wvalid_ready = ds21_wvalid && ds21_wready && ds21_wlast;
	wire ds21_rvalid_ready = ds21_rvalid && ds21_rready && ds21_rlast;
	wire ds21_awvalid_ready = ds21_awvalid && ds21_awready;
	wire ds21_arvalid_ready = ds21_arvalid && ds21_arready;
	wire ds21_bvalid_ready = ds21_bvalid && ds21_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds21_arcnt <= 3'b0;
	end
	else if (ds21_arvalid_ready) begin
		ds21_arcnt <= ds21_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds21_rcnt <= 3'b0;
	end
	else if (ds21_rvalid_ready) begin
		ds21_rcnt <= ds21_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds21_wcnt <= 3'b0;
	end
	else if (ds21_wvalid_ready) begin
		ds21_wcnt <= ds21_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds21_bcnt <= 3'b0;
	end
	else if (ds21_bvalid_ready) begin
		ds21_bcnt <= ds21_bcnt + 3'b1;
	end
end

ds21_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds21_wcnt != ds21_bcnt) |-> ##[1:2] (ds21_wcnt == ds21_bcnt));
ds21_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds21_arcnt != ds21_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds21_arcnt == ds21_rcnt));
`endif

`ifdef ATCBMC300_SLV22_SUPPORT
	reg [2:0]	ds22_arcnt;
	reg [2:0]	ds22_rcnt;
	reg [2:0]	ds22_wcnt;
	reg [2:0]	ds22_bcnt;

	wire ds22_wvalid_ready = ds22_wvalid && ds22_wready && ds22_wlast;
	wire ds22_rvalid_ready = ds22_rvalid && ds22_rready && ds22_rlast;
	wire ds22_awvalid_ready = ds22_awvalid && ds22_awready;
	wire ds22_arvalid_ready = ds22_arvalid && ds22_arready;
	wire ds22_bvalid_ready = ds22_bvalid && ds22_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds22_arcnt <= 3'b0;
	end
	else if (ds22_arvalid_ready) begin
		ds22_arcnt <= ds22_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds22_rcnt <= 3'b0;
	end
	else if (ds22_rvalid_ready) begin
		ds22_rcnt <= ds22_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds22_wcnt <= 3'b0;
	end
	else if (ds22_wvalid_ready) begin
		ds22_wcnt <= ds22_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds22_bcnt <= 3'b0;
	end
	else if (ds22_bvalid_ready) begin
		ds22_bcnt <= ds22_bcnt + 3'b1;
	end
end

ds22_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds22_wcnt != ds22_bcnt) |-> ##[1:2] (ds22_wcnt == ds22_bcnt));
ds22_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds22_arcnt != ds22_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds22_arcnt == ds22_rcnt));
`endif

`ifdef ATCBMC300_SLV23_SUPPORT
	reg [2:0]	ds23_arcnt;
	reg [2:0]	ds23_rcnt;
	reg [2:0]	ds23_wcnt;
	reg [2:0]	ds23_bcnt;

	wire ds23_wvalid_ready = ds23_wvalid && ds23_wready && ds23_wlast;
	wire ds23_rvalid_ready = ds23_rvalid && ds23_rready && ds23_rlast;
	wire ds23_awvalid_ready = ds23_awvalid && ds23_awready;
	wire ds23_arvalid_ready = ds23_arvalid && ds23_arready;
	wire ds23_bvalid_ready = ds23_bvalid && ds23_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds23_arcnt <= 3'b0;
	end
	else if (ds23_arvalid_ready) begin
		ds23_arcnt <= ds23_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds23_rcnt <= 3'b0;
	end
	else if (ds23_rvalid_ready) begin
		ds23_rcnt <= ds23_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds23_wcnt <= 3'b0;
	end
	else if (ds23_wvalid_ready) begin
		ds23_wcnt <= ds23_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds23_bcnt <= 3'b0;
	end
	else if (ds23_bvalid_ready) begin
		ds23_bcnt <= ds23_bcnt + 3'b1;
	end
end

ds23_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds23_wcnt != ds23_bcnt) |-> ##[1:2] (ds23_wcnt == ds23_bcnt));
ds23_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds23_arcnt != ds23_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds23_arcnt == ds23_rcnt));
`endif

`ifdef ATCBMC300_SLV24_SUPPORT
	reg [2:0]	ds24_arcnt;
	reg [2:0]	ds24_rcnt;
	reg [2:0]	ds24_wcnt;
	reg [2:0]	ds24_bcnt;

	wire ds24_wvalid_ready = ds24_wvalid && ds24_wready && ds24_wlast;
	wire ds24_rvalid_ready = ds24_rvalid && ds24_rready && ds24_rlast;
	wire ds24_awvalid_ready = ds24_awvalid && ds24_awready;
	wire ds24_arvalid_ready = ds24_arvalid && ds24_arready;
	wire ds24_bvalid_ready = ds24_bvalid && ds24_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds24_arcnt <= 3'b0;
	end
	else if (ds24_arvalid_ready) begin
		ds24_arcnt <= ds24_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds24_rcnt <= 3'b0;
	end
	else if (ds24_rvalid_ready) begin
		ds24_rcnt <= ds24_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds24_wcnt <= 3'b0;
	end
	else if (ds24_wvalid_ready) begin
		ds24_wcnt <= ds24_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds24_bcnt <= 3'b0;
	end
	else if (ds24_bvalid_ready) begin
		ds24_bcnt <= ds24_bcnt + 3'b1;
	end
end

ds24_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds24_wcnt != ds24_bcnt) |-> ##[1:2] (ds24_wcnt == ds24_bcnt));
ds24_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds24_arcnt != ds24_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds24_arcnt == ds24_rcnt));
`endif

`ifdef ATCBMC300_SLV25_SUPPORT
	reg [2:0]	ds25_arcnt;
	reg [2:0]	ds25_rcnt;
	reg [2:0]	ds25_wcnt;
	reg [2:0]	ds25_bcnt;

	wire ds25_wvalid_ready = ds25_wvalid && ds25_wready && ds25_wlast;
	wire ds25_rvalid_ready = ds25_rvalid && ds25_rready && ds25_rlast;
	wire ds25_awvalid_ready = ds25_awvalid && ds25_awready;
	wire ds25_arvalid_ready = ds25_arvalid && ds25_arready;
	wire ds25_bvalid_ready = ds25_bvalid && ds25_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds25_arcnt <= 3'b0;
	end
	else if (ds25_arvalid_ready) begin
		ds25_arcnt <= ds25_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds25_rcnt <= 3'b0;
	end
	else if (ds25_rvalid_ready) begin
		ds25_rcnt <= ds25_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds25_wcnt <= 3'b0;
	end
	else if (ds25_wvalid_ready) begin
		ds25_wcnt <= ds25_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds25_bcnt <= 3'b0;
	end
	else if (ds25_bvalid_ready) begin
		ds25_bcnt <= ds25_bcnt + 3'b1;
	end
end

ds25_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds25_wcnt != ds25_bcnt) |-> ##[1:2] (ds25_wcnt == ds25_bcnt));
ds25_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds25_arcnt != ds25_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds25_arcnt == ds25_rcnt));
`endif

`ifdef ATCBMC300_SLV26_SUPPORT
	reg [2:0]	ds26_arcnt;
	reg [2:0]	ds26_rcnt;
	reg [2:0]	ds26_wcnt;
	reg [2:0]	ds26_bcnt;

	wire ds26_wvalid_ready = ds26_wvalid && ds26_wready && ds26_wlast;
	wire ds26_rvalid_ready = ds26_rvalid && ds26_rready && ds26_rlast;
	wire ds26_awvalid_ready = ds26_awvalid && ds26_awready;
	wire ds26_arvalid_ready = ds26_arvalid && ds26_arready;
	wire ds26_bvalid_ready = ds26_bvalid && ds26_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds26_arcnt <= 3'b0;
	end
	else if (ds26_arvalid_ready) begin
		ds26_arcnt <= ds26_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds26_rcnt <= 3'b0;
	end
	else if (ds26_rvalid_ready) begin
		ds26_rcnt <= ds26_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds26_wcnt <= 3'b0;
	end
	else if (ds26_wvalid_ready) begin
		ds26_wcnt <= ds26_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds26_bcnt <= 3'b0;
	end
	else if (ds26_bvalid_ready) begin
		ds26_bcnt <= ds26_bcnt + 3'b1;
	end
end

ds26_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds26_wcnt != ds26_bcnt) |-> ##[1:2] (ds26_wcnt == ds26_bcnt));
ds26_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds26_arcnt != ds26_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds26_arcnt == ds26_rcnt));
`endif

`ifdef ATCBMC300_SLV27_SUPPORT
	reg [2:0]	ds27_arcnt;
	reg [2:0]	ds27_rcnt;
	reg [2:0]	ds27_wcnt;
	reg [2:0]	ds27_bcnt;

	wire ds27_wvalid_ready = ds27_wvalid && ds27_wready && ds27_wlast;
	wire ds27_rvalid_ready = ds27_rvalid && ds27_rready && ds27_rlast;
	wire ds27_awvalid_ready = ds27_awvalid && ds27_awready;
	wire ds27_arvalid_ready = ds27_arvalid && ds27_arready;
	wire ds27_bvalid_ready = ds27_bvalid && ds27_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds27_arcnt <= 3'b0;
	end
	else if (ds27_arvalid_ready) begin
		ds27_arcnt <= ds27_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds27_rcnt <= 3'b0;
	end
	else if (ds27_rvalid_ready) begin
		ds27_rcnt <= ds27_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds27_wcnt <= 3'b0;
	end
	else if (ds27_wvalid_ready) begin
		ds27_wcnt <= ds27_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds27_bcnt <= 3'b0;
	end
	else if (ds27_bvalid_ready) begin
		ds27_bcnt <= ds27_bcnt + 3'b1;
	end
end

ds27_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds27_wcnt != ds27_bcnt) |-> ##[1:2] (ds27_wcnt == ds27_bcnt));
ds27_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds27_arcnt != ds27_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds27_arcnt == ds27_rcnt));
`endif

`ifdef ATCBMC300_SLV28_SUPPORT
	reg [2:0]	ds28_arcnt;
	reg [2:0]	ds28_rcnt;
	reg [2:0]	ds28_wcnt;
	reg [2:0]	ds28_bcnt;

	wire ds28_wvalid_ready = ds28_wvalid && ds28_wready && ds28_wlast;
	wire ds28_rvalid_ready = ds28_rvalid && ds28_rready && ds28_rlast;
	wire ds28_awvalid_ready = ds28_awvalid && ds28_awready;
	wire ds28_arvalid_ready = ds28_arvalid && ds28_arready;
	wire ds28_bvalid_ready = ds28_bvalid && ds28_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds28_arcnt <= 3'b0;
	end
	else if (ds28_arvalid_ready) begin
		ds28_arcnt <= ds28_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds28_rcnt <= 3'b0;
	end
	else if (ds28_rvalid_ready) begin
		ds28_rcnt <= ds28_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds28_wcnt <= 3'b0;
	end
	else if (ds28_wvalid_ready) begin
		ds28_wcnt <= ds28_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds28_bcnt <= 3'b0;
	end
	else if (ds28_bvalid_ready) begin
		ds28_bcnt <= ds28_bcnt + 3'b1;
	end
end

ds28_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds28_wcnt != ds28_bcnt) |-> ##[1:2] (ds28_wcnt == ds28_bcnt));
ds28_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds28_arcnt != ds28_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds28_arcnt == ds28_rcnt));
`endif

`ifdef ATCBMC300_SLV29_SUPPORT
	reg [2:0]	ds29_arcnt;
	reg [2:0]	ds29_rcnt;
	reg [2:0]	ds29_wcnt;
	reg [2:0]	ds29_bcnt;

	wire ds29_wvalid_ready = ds29_wvalid && ds29_wready && ds29_wlast;
	wire ds29_rvalid_ready = ds29_rvalid && ds29_rready && ds29_rlast;
	wire ds29_awvalid_ready = ds29_awvalid && ds29_awready;
	wire ds29_arvalid_ready = ds29_arvalid && ds29_arready;
	wire ds29_bvalid_ready = ds29_bvalid && ds29_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds29_arcnt <= 3'b0;
	end
	else if (ds29_arvalid_ready) begin
		ds29_arcnt <= ds29_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds29_rcnt <= 3'b0;
	end
	else if (ds29_rvalid_ready) begin
		ds29_rcnt <= ds29_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds29_wcnt <= 3'b0;
	end
	else if (ds29_wvalid_ready) begin
		ds29_wcnt <= ds29_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds29_bcnt <= 3'b0;
	end
	else if (ds29_bvalid_ready) begin
		ds29_bcnt <= ds29_bcnt + 3'b1;
	end
end

ds29_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds29_wcnt != ds29_bcnt) |-> ##[1:2] (ds29_wcnt == ds29_bcnt));
ds29_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds29_arcnt != ds29_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds29_arcnt == ds29_rcnt));
`endif

`ifdef ATCBMC300_SLV30_SUPPORT
	reg [2:0]	ds30_arcnt;
	reg [2:0]	ds30_rcnt;
	reg [2:0]	ds30_wcnt;
	reg [2:0]	ds30_bcnt;

	wire ds30_wvalid_ready = ds30_wvalid && ds30_wready && ds30_wlast;
	wire ds30_rvalid_ready = ds30_rvalid && ds30_rready && ds30_rlast;
	wire ds30_awvalid_ready = ds30_awvalid && ds30_awready;
	wire ds30_arvalid_ready = ds30_arvalid && ds30_arready;
	wire ds30_bvalid_ready = ds30_bvalid && ds30_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds30_arcnt <= 3'b0;
	end
	else if (ds30_arvalid_ready) begin
		ds30_arcnt <= ds30_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds30_rcnt <= 3'b0;
	end
	else if (ds30_rvalid_ready) begin
		ds30_rcnt <= ds30_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds30_wcnt <= 3'b0;
	end
	else if (ds30_wvalid_ready) begin
		ds30_wcnt <= ds30_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds30_bcnt <= 3'b0;
	end
	else if (ds30_bvalid_ready) begin
		ds30_bcnt <= ds30_bcnt + 3'b1;
	end
end

ds30_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds30_wcnt != ds30_bcnt) |-> ##[1:2] (ds30_wcnt == ds30_bcnt));
ds30_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds30_arcnt != ds30_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds30_arcnt == ds30_rcnt));
`endif

`ifdef ATCBMC300_SLV31_SUPPORT
	reg [2:0]	ds31_arcnt;
	reg [2:0]	ds31_rcnt;
	reg [2:0]	ds31_wcnt;
	reg [2:0]	ds31_bcnt;

	wire ds31_wvalid_ready = ds31_wvalid && ds31_wready && ds31_wlast;
	wire ds31_rvalid_ready = ds31_rvalid && ds31_rready && ds31_rlast;
	wire ds31_awvalid_ready = ds31_awvalid && ds31_awready;
	wire ds31_arvalid_ready = ds31_arvalid && ds31_arready;
	wire ds31_bvalid_ready = ds31_bvalid && ds31_bready;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds31_arcnt <= 3'b0;
	end
	else if (ds31_arvalid_ready) begin
		ds31_arcnt <= ds31_arcnt + 3'b1;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds31_rcnt <= 3'b0;
	end
	else if (ds31_rvalid_ready) begin
		ds31_rcnt <= ds31_rcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds31_wcnt <= 3'b0;
	end
	else if (ds31_wvalid_ready) begin
		ds31_wcnt <= ds31_wcnt + 3'b1;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds31_bcnt <= 3'b0;
	end
	else if (ds31_bvalid_ready) begin
		ds31_bcnt <= ds31_bcnt + 3'b1;
	end
end

ds31_bv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds31_wcnt != ds31_bcnt) |-> ##[1:2] (ds31_wcnt == ds31_bcnt));
ds31_rv_fast: assume property ( @(posedge aclk) disable iff (!aresetn)
                (ds31_arcnt != ds31_rcnt) |-> ##[1:1+`RMAXLEN*2] (ds31_arcnt == ds31_rcnt));
`endif

`ifdef ATCBMC300_MST0_SUPPORT
us0_AST_S_WREADY_dead: assert property ( @(posedge aclk) disable iff (!aresetn)
        (us0_wvalid && !us0_wready) |->  ##[1:MAX_LATENCY] ( us0_wready));

us0_AST_S_AWREADY_dead: assert property ( @(posedge aclk) disable iff (!aresetn)
        (us0_awvalid && !us0_awready) |->  ##[1:MAX_LATENCY] ( us0_awready));

us0_AST_S_ARREADY_dead: assert property ( @(posedge aclk) disable iff (!aresetn)
        (us0_arvalid && !us0_arready) |->  ##[1:MAX_LATENCY] ( us0_arready));
`endif

`ifdef ATCBMC300_SLV2_SUPPORT
ds2_AST_M_RREADY_dead: assert property ( @(posedge aclk) disable iff (!aresetn)
        (ds2_rvalid && !ds2_rready) |->  ##[1:MAX_LATENCY] (!ds2_rvalid || ds2_rready));

ds2_AST_M_BREADY_dead: assert property ( @(posedge aclk) disable iff (!aresetn)
        (ds2_bvalid && !ds2_bready) |->  ##[1:MAX_LATENCY] ( ds2_bready));
`endif

endmodule
bind atcbmc300 deadlock_checker deadlock_checker(.*);
// VPERL_GENERATED_END

