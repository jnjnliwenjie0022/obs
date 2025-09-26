// Read performance test from the master's point of view.
module prfm_checker_rmst #(
	bit [3:0]		MID = 4'b0	// Master ID: 0~15.
) (
	input			aclk,
	input			aresetn,
	input			rvalid,
	input			rready,
	input [31:0]		ds_rvalids,
	input			aq_empty,	// Address queue empty flag.
	input [4:0]		sid		// Corresponding slave ID for the current data transfer.
);

bit			checking;
int			pending_cycle_cnt;
int			pending_cycle_cnt_nxt;
logic			valid;
logic [3:0]		mid;		// Master ID.

initial begin
	checking = 1'b0;
	wait(rvalid && rready);
	checking = 1'b1;
end

task check_slave_busy();
begin
	if ((sid == 5'b0) || `NDS_BENCH.prfm_checker.slv_raq_emptys[sid] == 1'b1) begin
		// Ignore the internal slave for now.
		// Or if there's no command for the slave to execute, return.
		// We think the command arbitration is okay. So if this
		// happens, it's not a performance problem.
		return;
	end

	// Then make sure this slave is busy with another master.
	if (!ds_rvalids[sid]) begin
		$display("%0t:%m:ERROR: Master%0d is starving but slave%0d is not busy", $realtime, MID, sid);
		// #10 $finish;
	end
	else begin
		// Check which master the corresponding slave is trying to access.
		valid = `NDS_BENCH.prfm_checker.slv_rvalids_d1[sid];
		mid = `NDS_BENCH.prfm_checker.slv_rmids_d1[sid];

		if ((valid === 1'b1) && (mid === MID)) begin
			$display("%0t:%m:ERROR: Master%0d is starving but slave%0d is not busy with another slave", $realtime, MID, sid);
		end
	end
end
endtask

always @(*) begin
	if (checking) begin
		if ((rvalid && rready) || aq_empty)
			pending_cycle_cnt_nxt = 0;
		else	// No effective valid -> pending...
			pending_cycle_cnt_nxt = pending_cycle_cnt + 1;
	end
	else
		pending_cycle_cnt_nxt = 0;
end

always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		pending_cycle_cnt <= 0;
	else
		pending_cycle_cnt <= pending_cycle_cnt_nxt;
end

always @(posedge aclk) begin
	if (checking && pending_cycle_cnt_nxt != 0)
		check_slave_busy();
end

endmodule

// Write performance test from the slave's point of view: When the slave thinks
// it should be being written by a master but wvalid is still 0, check if that
// master is still writing another slave. If the master is not writing anyone,
// it's an error. If the master is already writing us but we don't see wvalid,
// also an error.
// This can't be checked from the master's point of view. For example, if the
// master thinks it should write a slave but gets stalled, the slave may not
// get wvalid. One reason is another master may need to write the same slave
// before this mater to keep the same AW order while that master may still be
// writing another slave.
module prfm_checker_wslv #(
	bit [4:0]		SID = 5'b0,	// Slave ID: 0~31.
	int			ID_WIDTH = 8	// (Downstream) AXI ID width.
) (
	input			aclk,
	input			aresetn,
	input			wvalid,
	input			wready,
	input			aq_empty,	// Address queue empty flag.
	input [ID_WIDTH-1:0]	xid		// Corresponding master ID for the current data transfer.
);

bit			checking;
int			pending_cycle_cnt;
int			pending_cycle_cnt_nxt;
logic [3:0]		mid;		// Master ID.
logic			valid;
logic			eff_valid_d1;
logic [4:0]		sid;		// Slave ID.

initial begin
	checking = 1'b0;
	wait(wvalid && wready);
	checking = 1'b1;
end

task check_master_busy();
begin
	mid = xid[3:0];
	valid = `NDS_BENCH.prfm_checker.mst_wvalids[mid];
	eff_valid_d1 = `NDS_BENCH.prfm_checker.mst_eff_wvalids_d1[mid];

	// Then make sure this master is busy with another slave.
	if (!`NDS_BENCH.prfm_checker.us_wvalids[mid]) begin
		// The actual write may be buffered.
		if (!valid) begin
			$display("%0t:%m:ERROR: Slave%0d is starving but master%0d is not busy", $realtime, SID, mid);
		end
		// #10 $finish;
	end
	else begin
		// Check which slave the master is trying to access.
		sid = `NDS_BENCH.prfm_checker.mst_wsids_d1[mid];

		// The data needs at least one cycle of delay.
		if ((eff_valid_d1 === 1'b1) && (sid === SID)) begin
			$display("%0t:%m:ERROR: Slave%0d is starving but master%0d is not busy with another slave", $realtime, SID, mid);
		end
	end
end
endtask

always @(*) begin
	if (checking) begin
		if ((wvalid && wready) || aq_empty)
			pending_cycle_cnt_nxt = 0;
		else	// No effective valid -> pending...
			pending_cycle_cnt_nxt = pending_cycle_cnt + 1;
	end
	else
		pending_cycle_cnt_nxt = 0;
end

always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		pending_cycle_cnt <= 0;
	else
		pending_cycle_cnt <= pending_cycle_cnt_nxt;
end

always @(posedge aclk) begin
	if (checking && pending_cycle_cnt_nxt != 0)
		check_master_busy();
end

endmodule

module prfm_checker #(parameter
	int unsigned		ADDR_WIDTH = 32,
	int unsigned		DS_ID_WIDTH = 8
) (
	// VPERL_BEGIN
	// foreach $x (0 .. 15) {
	//   :`ifdef ATCBMC300_MST${x}_SUPPORT
	//   :input			us${x}_arvalid,
	//   :input			us${x}_arready,
	//   :input [ADDR_WIDTH-1:0]	us${x}_araddr,
	//   :input			us${x}_awvalid,
	//   :input			us${x}_awready,
	//   :input [ADDR_WIDTH-1:0]	us${x}_awaddr,
	//   :`endif
	// }
	// foreach $y (1 .. 31) {
	//   :`ifdef ATCBMC300_SLV${y}_SUPPORT
	//   #:input			ds${y}_arvalid,
	//   #:input			ds${y}_arready,
	//   #:input [ADDR_WIDTH-1:0]	ds${y}_araddr,
	//   :input			ds${y}_awvalid,
	//   :input			ds${y}_awready,
	//   #:input [ADDR_WIDTH-1:0]	ds${y}_awaddr,
	//   :`endif
	// }
	// VPERL_END

	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_MST0_SUPPORT
	input			us0_arvalid,
	input			us0_arready,
	input [ADDR_WIDTH-1:0]	us0_araddr,
	input			us0_awvalid,
	input			us0_awready,
	input [ADDR_WIDTH-1:0]	us0_awaddr,
	`endif
	`ifdef ATCBMC300_MST1_SUPPORT
	input			us1_arvalid,
	input			us1_arready,
	input [ADDR_WIDTH-1:0]	us1_araddr,
	input			us1_awvalid,
	input			us1_awready,
	input [ADDR_WIDTH-1:0]	us1_awaddr,
	`endif
	`ifdef ATCBMC300_MST2_SUPPORT
	input			us2_arvalid,
	input			us2_arready,
	input [ADDR_WIDTH-1:0]	us2_araddr,
	input			us2_awvalid,
	input			us2_awready,
	input [ADDR_WIDTH-1:0]	us2_awaddr,
	`endif
	`ifdef ATCBMC300_MST3_SUPPORT
	input			us3_arvalid,
	input			us3_arready,
	input [ADDR_WIDTH-1:0]	us3_araddr,
	input			us3_awvalid,
	input			us3_awready,
	input [ADDR_WIDTH-1:0]	us3_awaddr,
	`endif
	`ifdef ATCBMC300_MST4_SUPPORT
	input			us4_arvalid,
	input			us4_arready,
	input [ADDR_WIDTH-1:0]	us4_araddr,
	input			us4_awvalid,
	input			us4_awready,
	input [ADDR_WIDTH-1:0]	us4_awaddr,
	`endif
	`ifdef ATCBMC300_MST5_SUPPORT
	input			us5_arvalid,
	input			us5_arready,
	input [ADDR_WIDTH-1:0]	us5_araddr,
	input			us5_awvalid,
	input			us5_awready,
	input [ADDR_WIDTH-1:0]	us5_awaddr,
	`endif
	`ifdef ATCBMC300_MST6_SUPPORT
	input			us6_arvalid,
	input			us6_arready,
	input [ADDR_WIDTH-1:0]	us6_araddr,
	input			us6_awvalid,
	input			us6_awready,
	input [ADDR_WIDTH-1:0]	us6_awaddr,
	`endif
	`ifdef ATCBMC300_MST7_SUPPORT
	input			us7_arvalid,
	input			us7_arready,
	input [ADDR_WIDTH-1:0]	us7_araddr,
	input			us7_awvalid,
	input			us7_awready,
	input [ADDR_WIDTH-1:0]	us7_awaddr,
	`endif
	`ifdef ATCBMC300_MST8_SUPPORT
	input			us8_arvalid,
	input			us8_arready,
	input [ADDR_WIDTH-1:0]	us8_araddr,
	input			us8_awvalid,
	input			us8_awready,
	input [ADDR_WIDTH-1:0]	us8_awaddr,
	`endif
	`ifdef ATCBMC300_MST9_SUPPORT
	input			us9_arvalid,
	input			us9_arready,
	input [ADDR_WIDTH-1:0]	us9_araddr,
	input			us9_awvalid,
	input			us9_awready,
	input [ADDR_WIDTH-1:0]	us9_awaddr,
	`endif
	`ifdef ATCBMC300_MST10_SUPPORT
	input			us10_arvalid,
	input			us10_arready,
	input [ADDR_WIDTH-1:0]	us10_araddr,
	input			us10_awvalid,
	input			us10_awready,
	input [ADDR_WIDTH-1:0]	us10_awaddr,
	`endif
	`ifdef ATCBMC300_MST11_SUPPORT
	input			us11_arvalid,
	input			us11_arready,
	input [ADDR_WIDTH-1:0]	us11_araddr,
	input			us11_awvalid,
	input			us11_awready,
	input [ADDR_WIDTH-1:0]	us11_awaddr,
	`endif
	`ifdef ATCBMC300_MST12_SUPPORT
	input			us12_arvalid,
	input			us12_arready,
	input [ADDR_WIDTH-1:0]	us12_araddr,
	input			us12_awvalid,
	input			us12_awready,
	input [ADDR_WIDTH-1:0]	us12_awaddr,
	`endif
	`ifdef ATCBMC300_MST13_SUPPORT
	input			us13_arvalid,
	input			us13_arready,
	input [ADDR_WIDTH-1:0]	us13_araddr,
	input			us13_awvalid,
	input			us13_awready,
	input [ADDR_WIDTH-1:0]	us13_awaddr,
	`endif
	`ifdef ATCBMC300_MST14_SUPPORT
	input			us14_arvalid,
	input			us14_arready,
	input [ADDR_WIDTH-1:0]	us14_araddr,
	input			us14_awvalid,
	input			us14_awready,
	input [ADDR_WIDTH-1:0]	us14_awaddr,
	`endif
	`ifdef ATCBMC300_MST15_SUPPORT
	input			us15_arvalid,
	input			us15_arready,
	input [ADDR_WIDTH-1:0]	us15_araddr,
	input			us15_awvalid,
	input			us15_awready,
	input [ADDR_WIDTH-1:0]	us15_awaddr,
	`endif
	`ifdef ATCBMC300_SLV1_SUPPORT
	input			ds1_awvalid,
	input			ds1_awready,
	`endif
	`ifdef ATCBMC300_SLV2_SUPPORT
	input			ds2_awvalid,
	input			ds2_awready,
	`endif
	`ifdef ATCBMC300_SLV3_SUPPORT
	input			ds3_awvalid,
	input			ds3_awready,
	`endif
	`ifdef ATCBMC300_SLV4_SUPPORT
	input			ds4_awvalid,
	input			ds4_awready,
	`endif
	`ifdef ATCBMC300_SLV5_SUPPORT
	input			ds5_awvalid,
	input			ds5_awready,
	`endif
	`ifdef ATCBMC300_SLV6_SUPPORT
	input			ds6_awvalid,
	input			ds6_awready,
	`endif
	`ifdef ATCBMC300_SLV7_SUPPORT
	input			ds7_awvalid,
	input			ds7_awready,
	`endif
	`ifdef ATCBMC300_SLV8_SUPPORT
	input			ds8_awvalid,
	input			ds8_awready,
	`endif
	`ifdef ATCBMC300_SLV9_SUPPORT
	input			ds9_awvalid,
	input			ds9_awready,
	`endif
	`ifdef ATCBMC300_SLV10_SUPPORT
	input			ds10_awvalid,
	input			ds10_awready,
	`endif
	`ifdef ATCBMC300_SLV11_SUPPORT
	input			ds11_awvalid,
	input			ds11_awready,
	`endif
	`ifdef ATCBMC300_SLV12_SUPPORT
	input			ds12_awvalid,
	input			ds12_awready,
	`endif
	`ifdef ATCBMC300_SLV13_SUPPORT
	input			ds13_awvalid,
	input			ds13_awready,
	`endif
	`ifdef ATCBMC300_SLV14_SUPPORT
	input			ds14_awvalid,
	input			ds14_awready,
	`endif
	`ifdef ATCBMC300_SLV15_SUPPORT
	input			ds15_awvalid,
	input			ds15_awready,
	`endif
	`ifdef ATCBMC300_SLV16_SUPPORT
	input			ds16_awvalid,
	input			ds16_awready,
	`endif
	`ifdef ATCBMC300_SLV17_SUPPORT
	input			ds17_awvalid,
	input			ds17_awready,
	`endif
	`ifdef ATCBMC300_SLV18_SUPPORT
	input			ds18_awvalid,
	input			ds18_awready,
	`endif
	`ifdef ATCBMC300_SLV19_SUPPORT
	input			ds19_awvalid,
	input			ds19_awready,
	`endif
	`ifdef ATCBMC300_SLV20_SUPPORT
	input			ds20_awvalid,
	input			ds20_awready,
	`endif
	`ifdef ATCBMC300_SLV21_SUPPORT
	input			ds21_awvalid,
	input			ds21_awready,
	`endif
	`ifdef ATCBMC300_SLV22_SUPPORT
	input			ds22_awvalid,
	input			ds22_awready,
	`endif
	`ifdef ATCBMC300_SLV23_SUPPORT
	input			ds23_awvalid,
	input			ds23_awready,
	`endif
	`ifdef ATCBMC300_SLV24_SUPPORT
	input			ds24_awvalid,
	input			ds24_awready,
	`endif
	`ifdef ATCBMC300_SLV25_SUPPORT
	input			ds25_awvalid,
	input			ds25_awready,
	`endif
	`ifdef ATCBMC300_SLV26_SUPPORT
	input			ds26_awvalid,
	input			ds26_awready,
	`endif
	`ifdef ATCBMC300_SLV27_SUPPORT
	input			ds27_awvalid,
	input			ds27_awready,
	`endif
	`ifdef ATCBMC300_SLV28_SUPPORT
	input			ds28_awvalid,
	input			ds28_awready,
	`endif
	`ifdef ATCBMC300_SLV29_SUPPORT
	input			ds29_awvalid,
	input			ds29_awready,
	`endif
	`ifdef ATCBMC300_SLV30_SUPPORT
	input			ds30_awvalid,
	input			ds30_awready,
	`endif
	`ifdef ATCBMC300_SLV31_SUPPORT
	input			ds31_awvalid,
	input			ds31_awready,
	`endif
	// VPERL_GENERATED_END
	input			aclk,
	input			aresetn

);

// Each master has a queue to record the corresponding slave for each AR/AW.
bit [4:0]		ar_mst_target_slvids[0:15][$];

// VPERL_BEGIN
// foreach $x (0 .. 15) {
//   :`ifdef ATCBMC300_MST${x}_SUPPORT
//   :wire		us${x}_rvalid = `NDS_SYSTEM.us${x}_rvalid;
//   :wire		us${x}_rready = `NDS_SYSTEM.us${x}_rready;
//   :wire		us${x}_rlast = `NDS_SYSTEM.us${x}_rlast;
//   :wire		us${x}_wvalid = `NDS_SYSTEM.us${x}_wvalid;
//   :wire		us${x}_wready = `NDS_SYSTEM.us${x}_wready;
//   :wire		us${x}_wlast = `NDS_SYSTEM.us${x}_wlast;
//   :`endif
// }
// foreach $y (1 .. 31) {
//   :`ifdef ATCBMC300_SLV${y}_SUPPORT
//   :wire		ds${y}_rvalid = `NDS_SYSTEM.ds${y}_rvalid;
//   :wire		ds${y}_rready = `NDS_SYSTEM.ds${y}_rready;
//   :wire		ds${y}_rlast = `NDS_SYSTEM.ds${y}_rlast;
//   :`endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
wire		us0_rvalid = `NDS_SYSTEM.us0_rvalid;
wire		us0_rready = `NDS_SYSTEM.us0_rready;
wire		us0_rlast = `NDS_SYSTEM.us0_rlast;
wire		us0_wvalid = `NDS_SYSTEM.us0_wvalid;
wire		us0_wready = `NDS_SYSTEM.us0_wready;
wire		us0_wlast = `NDS_SYSTEM.us0_wlast;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
wire		us1_rvalid = `NDS_SYSTEM.us1_rvalid;
wire		us1_rready = `NDS_SYSTEM.us1_rready;
wire		us1_rlast = `NDS_SYSTEM.us1_rlast;
wire		us1_wvalid = `NDS_SYSTEM.us1_wvalid;
wire		us1_wready = `NDS_SYSTEM.us1_wready;
wire		us1_wlast = `NDS_SYSTEM.us1_wlast;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
wire		us2_rvalid = `NDS_SYSTEM.us2_rvalid;
wire		us2_rready = `NDS_SYSTEM.us2_rready;
wire		us2_rlast = `NDS_SYSTEM.us2_rlast;
wire		us2_wvalid = `NDS_SYSTEM.us2_wvalid;
wire		us2_wready = `NDS_SYSTEM.us2_wready;
wire		us2_wlast = `NDS_SYSTEM.us2_wlast;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
wire		us3_rvalid = `NDS_SYSTEM.us3_rvalid;
wire		us3_rready = `NDS_SYSTEM.us3_rready;
wire		us3_rlast = `NDS_SYSTEM.us3_rlast;
wire		us3_wvalid = `NDS_SYSTEM.us3_wvalid;
wire		us3_wready = `NDS_SYSTEM.us3_wready;
wire		us3_wlast = `NDS_SYSTEM.us3_wlast;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
wire		us4_rvalid = `NDS_SYSTEM.us4_rvalid;
wire		us4_rready = `NDS_SYSTEM.us4_rready;
wire		us4_rlast = `NDS_SYSTEM.us4_rlast;
wire		us4_wvalid = `NDS_SYSTEM.us4_wvalid;
wire		us4_wready = `NDS_SYSTEM.us4_wready;
wire		us4_wlast = `NDS_SYSTEM.us4_wlast;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
wire		us5_rvalid = `NDS_SYSTEM.us5_rvalid;
wire		us5_rready = `NDS_SYSTEM.us5_rready;
wire		us5_rlast = `NDS_SYSTEM.us5_rlast;
wire		us5_wvalid = `NDS_SYSTEM.us5_wvalid;
wire		us5_wready = `NDS_SYSTEM.us5_wready;
wire		us5_wlast = `NDS_SYSTEM.us5_wlast;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
wire		us6_rvalid = `NDS_SYSTEM.us6_rvalid;
wire		us6_rready = `NDS_SYSTEM.us6_rready;
wire		us6_rlast = `NDS_SYSTEM.us6_rlast;
wire		us6_wvalid = `NDS_SYSTEM.us6_wvalid;
wire		us6_wready = `NDS_SYSTEM.us6_wready;
wire		us6_wlast = `NDS_SYSTEM.us6_wlast;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
wire		us7_rvalid = `NDS_SYSTEM.us7_rvalid;
wire		us7_rready = `NDS_SYSTEM.us7_rready;
wire		us7_rlast = `NDS_SYSTEM.us7_rlast;
wire		us7_wvalid = `NDS_SYSTEM.us7_wvalid;
wire		us7_wready = `NDS_SYSTEM.us7_wready;
wire		us7_wlast = `NDS_SYSTEM.us7_wlast;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
wire		us8_rvalid = `NDS_SYSTEM.us8_rvalid;
wire		us8_rready = `NDS_SYSTEM.us8_rready;
wire		us8_rlast = `NDS_SYSTEM.us8_rlast;
wire		us8_wvalid = `NDS_SYSTEM.us8_wvalid;
wire		us8_wready = `NDS_SYSTEM.us8_wready;
wire		us8_wlast = `NDS_SYSTEM.us8_wlast;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
wire		us9_rvalid = `NDS_SYSTEM.us9_rvalid;
wire		us9_rready = `NDS_SYSTEM.us9_rready;
wire		us9_rlast = `NDS_SYSTEM.us9_rlast;
wire		us9_wvalid = `NDS_SYSTEM.us9_wvalid;
wire		us9_wready = `NDS_SYSTEM.us9_wready;
wire		us9_wlast = `NDS_SYSTEM.us9_wlast;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
wire		us10_rvalid = `NDS_SYSTEM.us10_rvalid;
wire		us10_rready = `NDS_SYSTEM.us10_rready;
wire		us10_rlast = `NDS_SYSTEM.us10_rlast;
wire		us10_wvalid = `NDS_SYSTEM.us10_wvalid;
wire		us10_wready = `NDS_SYSTEM.us10_wready;
wire		us10_wlast = `NDS_SYSTEM.us10_wlast;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
wire		us11_rvalid = `NDS_SYSTEM.us11_rvalid;
wire		us11_rready = `NDS_SYSTEM.us11_rready;
wire		us11_rlast = `NDS_SYSTEM.us11_rlast;
wire		us11_wvalid = `NDS_SYSTEM.us11_wvalid;
wire		us11_wready = `NDS_SYSTEM.us11_wready;
wire		us11_wlast = `NDS_SYSTEM.us11_wlast;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
wire		us12_rvalid = `NDS_SYSTEM.us12_rvalid;
wire		us12_rready = `NDS_SYSTEM.us12_rready;
wire		us12_rlast = `NDS_SYSTEM.us12_rlast;
wire		us12_wvalid = `NDS_SYSTEM.us12_wvalid;
wire		us12_wready = `NDS_SYSTEM.us12_wready;
wire		us12_wlast = `NDS_SYSTEM.us12_wlast;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
wire		us13_rvalid = `NDS_SYSTEM.us13_rvalid;
wire		us13_rready = `NDS_SYSTEM.us13_rready;
wire		us13_rlast = `NDS_SYSTEM.us13_rlast;
wire		us13_wvalid = `NDS_SYSTEM.us13_wvalid;
wire		us13_wready = `NDS_SYSTEM.us13_wready;
wire		us13_wlast = `NDS_SYSTEM.us13_wlast;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
wire		us14_rvalid = `NDS_SYSTEM.us14_rvalid;
wire		us14_rready = `NDS_SYSTEM.us14_rready;
wire		us14_rlast = `NDS_SYSTEM.us14_rlast;
wire		us14_wvalid = `NDS_SYSTEM.us14_wvalid;
wire		us14_wready = `NDS_SYSTEM.us14_wready;
wire		us14_wlast = `NDS_SYSTEM.us14_wlast;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
wire		us15_rvalid = `NDS_SYSTEM.us15_rvalid;
wire		us15_rready = `NDS_SYSTEM.us15_rready;
wire		us15_rlast = `NDS_SYSTEM.us15_rlast;
wire		us15_wvalid = `NDS_SYSTEM.us15_wvalid;
wire		us15_wready = `NDS_SYSTEM.us15_wready;
wire		us15_wlast = `NDS_SYSTEM.us15_wlast;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
wire		ds1_rvalid = `NDS_SYSTEM.ds1_rvalid;
wire		ds1_rready = `NDS_SYSTEM.ds1_rready;
wire		ds1_rlast = `NDS_SYSTEM.ds1_rlast;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
wire		ds2_rvalid = `NDS_SYSTEM.ds2_rvalid;
wire		ds2_rready = `NDS_SYSTEM.ds2_rready;
wire		ds2_rlast = `NDS_SYSTEM.ds2_rlast;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
wire		ds3_rvalid = `NDS_SYSTEM.ds3_rvalid;
wire		ds3_rready = `NDS_SYSTEM.ds3_rready;
wire		ds3_rlast = `NDS_SYSTEM.ds3_rlast;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
wire		ds4_rvalid = `NDS_SYSTEM.ds4_rvalid;
wire		ds4_rready = `NDS_SYSTEM.ds4_rready;
wire		ds4_rlast = `NDS_SYSTEM.ds4_rlast;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
wire		ds5_rvalid = `NDS_SYSTEM.ds5_rvalid;
wire		ds5_rready = `NDS_SYSTEM.ds5_rready;
wire		ds5_rlast = `NDS_SYSTEM.ds5_rlast;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
wire		ds6_rvalid = `NDS_SYSTEM.ds6_rvalid;
wire		ds6_rready = `NDS_SYSTEM.ds6_rready;
wire		ds6_rlast = `NDS_SYSTEM.ds6_rlast;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
wire		ds7_rvalid = `NDS_SYSTEM.ds7_rvalid;
wire		ds7_rready = `NDS_SYSTEM.ds7_rready;
wire		ds7_rlast = `NDS_SYSTEM.ds7_rlast;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
wire		ds8_rvalid = `NDS_SYSTEM.ds8_rvalid;
wire		ds8_rready = `NDS_SYSTEM.ds8_rready;
wire		ds8_rlast = `NDS_SYSTEM.ds8_rlast;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
wire		ds9_rvalid = `NDS_SYSTEM.ds9_rvalid;
wire		ds9_rready = `NDS_SYSTEM.ds9_rready;
wire		ds9_rlast = `NDS_SYSTEM.ds9_rlast;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
wire		ds10_rvalid = `NDS_SYSTEM.ds10_rvalid;
wire		ds10_rready = `NDS_SYSTEM.ds10_rready;
wire		ds10_rlast = `NDS_SYSTEM.ds10_rlast;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
wire		ds11_rvalid = `NDS_SYSTEM.ds11_rvalid;
wire		ds11_rready = `NDS_SYSTEM.ds11_rready;
wire		ds11_rlast = `NDS_SYSTEM.ds11_rlast;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
wire		ds12_rvalid = `NDS_SYSTEM.ds12_rvalid;
wire		ds12_rready = `NDS_SYSTEM.ds12_rready;
wire		ds12_rlast = `NDS_SYSTEM.ds12_rlast;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
wire		ds13_rvalid = `NDS_SYSTEM.ds13_rvalid;
wire		ds13_rready = `NDS_SYSTEM.ds13_rready;
wire		ds13_rlast = `NDS_SYSTEM.ds13_rlast;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
wire		ds14_rvalid = `NDS_SYSTEM.ds14_rvalid;
wire		ds14_rready = `NDS_SYSTEM.ds14_rready;
wire		ds14_rlast = `NDS_SYSTEM.ds14_rlast;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
wire		ds15_rvalid = `NDS_SYSTEM.ds15_rvalid;
wire		ds15_rready = `NDS_SYSTEM.ds15_rready;
wire		ds15_rlast = `NDS_SYSTEM.ds15_rlast;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
wire		ds16_rvalid = `NDS_SYSTEM.ds16_rvalid;
wire		ds16_rready = `NDS_SYSTEM.ds16_rready;
wire		ds16_rlast = `NDS_SYSTEM.ds16_rlast;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
wire		ds17_rvalid = `NDS_SYSTEM.ds17_rvalid;
wire		ds17_rready = `NDS_SYSTEM.ds17_rready;
wire		ds17_rlast = `NDS_SYSTEM.ds17_rlast;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
wire		ds18_rvalid = `NDS_SYSTEM.ds18_rvalid;
wire		ds18_rready = `NDS_SYSTEM.ds18_rready;
wire		ds18_rlast = `NDS_SYSTEM.ds18_rlast;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
wire		ds19_rvalid = `NDS_SYSTEM.ds19_rvalid;
wire		ds19_rready = `NDS_SYSTEM.ds19_rready;
wire		ds19_rlast = `NDS_SYSTEM.ds19_rlast;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
wire		ds20_rvalid = `NDS_SYSTEM.ds20_rvalid;
wire		ds20_rready = `NDS_SYSTEM.ds20_rready;
wire		ds20_rlast = `NDS_SYSTEM.ds20_rlast;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
wire		ds21_rvalid = `NDS_SYSTEM.ds21_rvalid;
wire		ds21_rready = `NDS_SYSTEM.ds21_rready;
wire		ds21_rlast = `NDS_SYSTEM.ds21_rlast;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
wire		ds22_rvalid = `NDS_SYSTEM.ds22_rvalid;
wire		ds22_rready = `NDS_SYSTEM.ds22_rready;
wire		ds22_rlast = `NDS_SYSTEM.ds22_rlast;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
wire		ds23_rvalid = `NDS_SYSTEM.ds23_rvalid;
wire		ds23_rready = `NDS_SYSTEM.ds23_rready;
wire		ds23_rlast = `NDS_SYSTEM.ds23_rlast;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
wire		ds24_rvalid = `NDS_SYSTEM.ds24_rvalid;
wire		ds24_rready = `NDS_SYSTEM.ds24_rready;
wire		ds24_rlast = `NDS_SYSTEM.ds24_rlast;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
wire		ds25_rvalid = `NDS_SYSTEM.ds25_rvalid;
wire		ds25_rready = `NDS_SYSTEM.ds25_rready;
wire		ds25_rlast = `NDS_SYSTEM.ds25_rlast;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
wire		ds26_rvalid = `NDS_SYSTEM.ds26_rvalid;
wire		ds26_rready = `NDS_SYSTEM.ds26_rready;
wire		ds26_rlast = `NDS_SYSTEM.ds26_rlast;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
wire		ds27_rvalid = `NDS_SYSTEM.ds27_rvalid;
wire		ds27_rready = `NDS_SYSTEM.ds27_rready;
wire		ds27_rlast = `NDS_SYSTEM.ds27_rlast;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
wire		ds28_rvalid = `NDS_SYSTEM.ds28_rvalid;
wire		ds28_rready = `NDS_SYSTEM.ds28_rready;
wire		ds28_rlast = `NDS_SYSTEM.ds28_rlast;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
wire		ds29_rvalid = `NDS_SYSTEM.ds29_rvalid;
wire		ds29_rready = `NDS_SYSTEM.ds29_rready;
wire		ds29_rlast = `NDS_SYSTEM.ds29_rlast;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
wire		ds30_rvalid = `NDS_SYSTEM.ds30_rvalid;
wire		ds30_rready = `NDS_SYSTEM.ds30_rready;
wire		ds30_rlast = `NDS_SYSTEM.ds30_rlast;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
wire		ds31_rvalid = `NDS_SYSTEM.ds31_rvalid;
wire		ds31_rready = `NDS_SYSTEM.ds31_rready;
wire		ds31_rlast = `NDS_SYSTEM.ds31_rlast;
`endif
// VPERL_GENERATED_END

wire [31:0]		ds_rvalids = {
	// VPERL: for ($y = 31; $y > 0; $y--) { print("`ifdef ATCBMC300_SLV${y}_SUPPORT `NDS_SYSTEM.ds${y}_rvalid `else 1'b0 `endif,\n"); }
	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_SLV31_SUPPORT `NDS_SYSTEM.ds31_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV30_SUPPORT `NDS_SYSTEM.ds30_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV29_SUPPORT `NDS_SYSTEM.ds29_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV28_SUPPORT `NDS_SYSTEM.ds28_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV27_SUPPORT `NDS_SYSTEM.ds27_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV26_SUPPORT `NDS_SYSTEM.ds26_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV25_SUPPORT `NDS_SYSTEM.ds25_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV24_SUPPORT `NDS_SYSTEM.ds24_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV23_SUPPORT `NDS_SYSTEM.ds23_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV22_SUPPORT `NDS_SYSTEM.ds22_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV21_SUPPORT `NDS_SYSTEM.ds21_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV20_SUPPORT `NDS_SYSTEM.ds20_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV19_SUPPORT `NDS_SYSTEM.ds19_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV18_SUPPORT `NDS_SYSTEM.ds18_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV17_SUPPORT `NDS_SYSTEM.ds17_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV16_SUPPORT `NDS_SYSTEM.ds16_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV15_SUPPORT `NDS_SYSTEM.ds15_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV14_SUPPORT `NDS_SYSTEM.ds14_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV13_SUPPORT `NDS_SYSTEM.ds13_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV12_SUPPORT `NDS_SYSTEM.ds12_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV11_SUPPORT `NDS_SYSTEM.ds11_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV10_SUPPORT `NDS_SYSTEM.ds10_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV9_SUPPORT `NDS_SYSTEM.ds9_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV8_SUPPORT `NDS_SYSTEM.ds8_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV7_SUPPORT `NDS_SYSTEM.ds7_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV6_SUPPORT `NDS_SYSTEM.ds6_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV5_SUPPORT `NDS_SYSTEM.ds5_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV4_SUPPORT `NDS_SYSTEM.ds4_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV3_SUPPORT `NDS_SYSTEM.ds3_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV2_SUPPORT `NDS_SYSTEM.ds2_rvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV1_SUPPORT `NDS_SYSTEM.ds1_rvalid `else 1'b0 `endif,
	// VPERL_GENERATED_END
	1'b0
};

wire [15:0]		us_wvalids = {
	// VPERL: for ($x = 15; $x > 0; $x--) { print("`ifdef ATCBMC300_MST${x}_SUPPORT us${x}_wvalid `else 1'b0 `endif,\n"); }
	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_MST15_SUPPORT us15_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST14_SUPPORT us14_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST13_SUPPORT us13_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST12_SUPPORT us12_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST11_SUPPORT us11_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST10_SUPPORT us10_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST9_SUPPORT us9_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST8_SUPPORT us8_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST7_SUPPORT us7_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST6_SUPPORT us6_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST5_SUPPORT us5_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST4_SUPPORT us4_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST3_SUPPORT us3_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST2_SUPPORT us2_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST1_SUPPORT us1_wvalid `else 1'b0 `endif,
	// VPERL_GENERATED_END
	`ifdef ATCBMC300_MST0_SUPPORT `NDS_SYSTEM.us0_wvalid `else 1'b0 `endif
};

// The internal bufferd valid.
wire [15:0]		mst_wvalids = {
	// VPERL: for ($x = 15; $x > 0; $x--) { print("`ifdef ATCBMC300_MST${x}_SUPPORT `NDS_BMC.us${x}_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,\n"); }
	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_MST15_SUPPORT `NDS_BMC.us15_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST14_SUPPORT `NDS_BMC.us14_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST13_SUPPORT `NDS_BMC.us13_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST12_SUPPORT `NDS_BMC.us12_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST11_SUPPORT `NDS_BMC.us11_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST10_SUPPORT `NDS_BMC.us10_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST9_SUPPORT `NDS_BMC.us9_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST8_SUPPORT `NDS_BMC.us8_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST7_SUPPORT `NDS_BMC.us7_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST6_SUPPORT `NDS_BMC.us6_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST5_SUPPORT `NDS_BMC.us5_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST4_SUPPORT `NDS_BMC.us4_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST3_SUPPORT `NDS_BMC.us3_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST2_SUPPORT `NDS_BMC.us2_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	`ifdef ATCBMC300_MST1_SUPPORT `NDS_BMC.us1_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif,
	// VPERL_GENERATED_END
	`ifdef ATCBMC300_MST0_SUPPORT `NDS_BMC.us0_ctrl.us_wr_data.mst_wvalid `else 1'b0 `endif
};

wire [31:0]	slv_raq_emptys = {
	// VPERL: for ($y = 31; $y > 0; $y--) { print "`ifdef ATCBMC300_SLV${y}_SUPPORT `NDS_SYSTEM.axi_slave${y}.raq_empty `else 1'b0 `endif,\n"; }
	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_SLV31_SUPPORT `NDS_SYSTEM.axi_slave31.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV30_SUPPORT `NDS_SYSTEM.axi_slave30.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV29_SUPPORT `NDS_SYSTEM.axi_slave29.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV28_SUPPORT `NDS_SYSTEM.axi_slave28.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV27_SUPPORT `NDS_SYSTEM.axi_slave27.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV26_SUPPORT `NDS_SYSTEM.axi_slave26.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV25_SUPPORT `NDS_SYSTEM.axi_slave25.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV24_SUPPORT `NDS_SYSTEM.axi_slave24.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV23_SUPPORT `NDS_SYSTEM.axi_slave23.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV22_SUPPORT `NDS_SYSTEM.axi_slave22.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV21_SUPPORT `NDS_SYSTEM.axi_slave21.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV20_SUPPORT `NDS_SYSTEM.axi_slave20.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV19_SUPPORT `NDS_SYSTEM.axi_slave19.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV18_SUPPORT `NDS_SYSTEM.axi_slave18.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV17_SUPPORT `NDS_SYSTEM.axi_slave17.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV16_SUPPORT `NDS_SYSTEM.axi_slave16.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV15_SUPPORT `NDS_SYSTEM.axi_slave15.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV14_SUPPORT `NDS_SYSTEM.axi_slave14.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV13_SUPPORT `NDS_SYSTEM.axi_slave13.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV12_SUPPORT `NDS_SYSTEM.axi_slave12.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV11_SUPPORT `NDS_SYSTEM.axi_slave11.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV10_SUPPORT `NDS_SYSTEM.axi_slave10.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV9_SUPPORT `NDS_SYSTEM.axi_slave9.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV8_SUPPORT `NDS_SYSTEM.axi_slave8.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV7_SUPPORT `NDS_SYSTEM.axi_slave7.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV6_SUPPORT `NDS_SYSTEM.axi_slave6.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV5_SUPPORT `NDS_SYSTEM.axi_slave5.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV4_SUPPORT `NDS_SYSTEM.axi_slave4.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV3_SUPPORT `NDS_SYSTEM.axi_slave3.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV2_SUPPORT `NDS_SYSTEM.axi_slave2.raq_empty `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV1_SUPPORT `NDS_SYSTEM.axi_slave1.raq_empty `else 1'b0 `endif,
	// VPERL_GENERATED_END
	1'b0
};

function bit [4:0] find_target_slave(
	input int		conns,
	input [ADDR_WIDTH-1:0]	addr
);
int		i;
begin
	for (i = 0; i < 32; i++) begin
		if (`NDS_SYSTEM.bench.spaces[i].capacity == (ADDR_WIDTH)'(0))
			continue;	// Absent slave!
		if (!`NDS_SYSTEM.bench.spaces[i].in_range(addr))
			continue;	// Not within this slave.
		// Hit.
		if ((conns & (1<<i)) == 0) begin// Not connected?
			i = 32;
			break;
		end
		break;
	end
	// In the performance test, only valid slaves
	// should be accessed.
	assert(i < 32);
	return i[4:0];
end
endfunction

// VPERL_BEGIN
// foreach $x (0 .. 15) {
//   :`ifdef ATCBMC300_MST${x}_SUPPORT
//   :always @(negedge aresetn or posedge aclk) begin
//   :	if (!aresetn)
//   :		ar_mst_target_slvids[${x}].delete();
//   :	else begin
//   :		if (us${x}_arvalid && us${x}_arready)
//   :			ar_mst_target_slvids[${x}].push_back(find_target_slave(
//   :				`NDS_M${x}_CONNS, us${x}_araddr));
//   :		if (us${x}_rvalid && us${x}_rready && us${x}_rlast) begin
//   :			// Don't pop the queue immediately otherwise it may cause other
//   :			// codes to run at the same posedge. That is, the new value should be
//   :			// used at the next edge. In addition, there's no extra one-cycle delay
//   :			// since this is read. The slave sends data to the master. When slave needs
//   :			// to check the master, the master should have the newest info.
//   :			#1 void'(ar_mst_target_slvids[${x}].pop_front());
//   :		end
//   :	end
//   :end
//   :`endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[0].delete();
	else begin
		if (us0_arvalid && us0_arready)
			ar_mst_target_slvids[0].push_back(find_target_slave(
				`NDS_M0_CONNS, us0_araddr));
		if (us0_rvalid && us0_rready && us0_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[0].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST1_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[1].delete();
	else begin
		if (us1_arvalid && us1_arready)
			ar_mst_target_slvids[1].push_back(find_target_slave(
				`NDS_M1_CONNS, us1_araddr));
		if (us1_rvalid && us1_rready && us1_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[1].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST2_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[2].delete();
	else begin
		if (us2_arvalid && us2_arready)
			ar_mst_target_slvids[2].push_back(find_target_slave(
				`NDS_M2_CONNS, us2_araddr));
		if (us2_rvalid && us2_rready && us2_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[2].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST3_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[3].delete();
	else begin
		if (us3_arvalid && us3_arready)
			ar_mst_target_slvids[3].push_back(find_target_slave(
				`NDS_M3_CONNS, us3_araddr));
		if (us3_rvalid && us3_rready && us3_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[3].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST4_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[4].delete();
	else begin
		if (us4_arvalid && us4_arready)
			ar_mst_target_slvids[4].push_back(find_target_slave(
				`NDS_M4_CONNS, us4_araddr));
		if (us4_rvalid && us4_rready && us4_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[4].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST5_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[5].delete();
	else begin
		if (us5_arvalid && us5_arready)
			ar_mst_target_slvids[5].push_back(find_target_slave(
				`NDS_M5_CONNS, us5_araddr));
		if (us5_rvalid && us5_rready && us5_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[5].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST6_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[6].delete();
	else begin
		if (us6_arvalid && us6_arready)
			ar_mst_target_slvids[6].push_back(find_target_slave(
				`NDS_M6_CONNS, us6_araddr));
		if (us6_rvalid && us6_rready && us6_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[6].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST7_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[7].delete();
	else begin
		if (us7_arvalid && us7_arready)
			ar_mst_target_slvids[7].push_back(find_target_slave(
				`NDS_M7_CONNS, us7_araddr));
		if (us7_rvalid && us7_rready && us7_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[7].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST8_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[8].delete();
	else begin
		if (us8_arvalid && us8_arready)
			ar_mst_target_slvids[8].push_back(find_target_slave(
				`NDS_M8_CONNS, us8_araddr));
		if (us8_rvalid && us8_rready && us8_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[8].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST9_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[9].delete();
	else begin
		if (us9_arvalid && us9_arready)
			ar_mst_target_slvids[9].push_back(find_target_slave(
				`NDS_M9_CONNS, us9_araddr));
		if (us9_rvalid && us9_rready && us9_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[9].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST10_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[10].delete();
	else begin
		if (us10_arvalid && us10_arready)
			ar_mst_target_slvids[10].push_back(find_target_slave(
				`NDS_M10_CONNS, us10_araddr));
		if (us10_rvalid && us10_rready && us10_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[10].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST11_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[11].delete();
	else begin
		if (us11_arvalid && us11_arready)
			ar_mst_target_slvids[11].push_back(find_target_slave(
				`NDS_M11_CONNS, us11_araddr));
		if (us11_rvalid && us11_rready && us11_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[11].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST12_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[12].delete();
	else begin
		if (us12_arvalid && us12_arready)
			ar_mst_target_slvids[12].push_back(find_target_slave(
				`NDS_M12_CONNS, us12_araddr));
		if (us12_rvalid && us12_rready && us12_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[12].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST13_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[13].delete();
	else begin
		if (us13_arvalid && us13_arready)
			ar_mst_target_slvids[13].push_back(find_target_slave(
				`NDS_M13_CONNS, us13_araddr));
		if (us13_rvalid && us13_rready && us13_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[13].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST14_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[14].delete();
	else begin
		if (us14_arvalid && us14_arready)
			ar_mst_target_slvids[14].push_back(find_target_slave(
				`NDS_M14_CONNS, us14_araddr));
		if (us14_rvalid && us14_rready && us14_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[14].pop_front());
		end
	end
end
`endif
`ifdef ATCBMC300_MST15_SUPPORT
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn)
		ar_mst_target_slvids[15].delete();
	else begin
		if (us15_arvalid && us15_arready)
			ar_mst_target_slvids[15].push_back(find_target_slave(
				`NDS_M15_CONNS, us15_araddr));
		if (us15_rvalid && us15_rready && us15_rlast) begin
			// Don't pop the queue immediately otherwise it may cause other
			// codes to run at the same posedge. That is, the new value should be
			// used at the next edge. In addition, there's no extra one-cycle delay
			// since this is read. The slave sends data to the master. When slave needs
			// to check the master, the master should have the newest info.
			#1 void'(ar_mst_target_slvids[15].pop_front());
		end
	end
end
`endif
// VPERL_GENERATED_END
// VPERL_BEGIN
// foreach $x (0 .. 15) {
//   :`ifdef ATCBMC300_MST${x}_SUPPORT
//   :prfm_checker_rmst #(.MID(4'd${x})) rmst${x} (.*,
//   :	.rvalid(`NDS_SYSTEM.us${x}_rvalid),
//   :	.rready(`NDS_SYSTEM.us${x}_rready),
//   :	.ds_rvalids(ds_rvalids),
//   :	.aq_empty(ar_mst_target_slvids[$x].size()==0),
//   :	.sid(ar_mst_target_slvids[$x][0])
//   :);
//   :`endif
// }
// foreach $y (1 .. 31) {
//   :`ifdef ATCBMC300_SLV${y}_SUPPORT
//   :prfm_checker_wslv #(.SID(5'd${y}), .ID_WIDTH(DS_ID_WIDTH)) wslv${y} (.*,
//   :	.wvalid(`NDS_SYSTEM.ds${y}_wvalid),
//   :	.wready(`NDS_SYSTEM.ds${y}_wready),
//   :	.aq_empty(`NDS_SYSTEM.axi_slave${y}.waq_empty[0]),
//   :	.xid(`NDS_SYSTEM.axi_slave${y}.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
//   :);
//   :`endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
prfm_checker_rmst #(.MID(4'd0)) rmst0 (.*,
	.rvalid(`NDS_SYSTEM.us0_rvalid),
	.rready(`NDS_SYSTEM.us0_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[0].size()==0),
	.sid(ar_mst_target_slvids[0][0])
);
`endif
`ifdef ATCBMC300_MST1_SUPPORT
prfm_checker_rmst #(.MID(4'd1)) rmst1 (.*,
	.rvalid(`NDS_SYSTEM.us1_rvalid),
	.rready(`NDS_SYSTEM.us1_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[1].size()==0),
	.sid(ar_mst_target_slvids[1][0])
);
`endif
`ifdef ATCBMC300_MST2_SUPPORT
prfm_checker_rmst #(.MID(4'd2)) rmst2 (.*,
	.rvalid(`NDS_SYSTEM.us2_rvalid),
	.rready(`NDS_SYSTEM.us2_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[2].size()==0),
	.sid(ar_mst_target_slvids[2][0])
);
`endif
`ifdef ATCBMC300_MST3_SUPPORT
prfm_checker_rmst #(.MID(4'd3)) rmst3 (.*,
	.rvalid(`NDS_SYSTEM.us3_rvalid),
	.rready(`NDS_SYSTEM.us3_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[3].size()==0),
	.sid(ar_mst_target_slvids[3][0])
);
`endif
`ifdef ATCBMC300_MST4_SUPPORT
prfm_checker_rmst #(.MID(4'd4)) rmst4 (.*,
	.rvalid(`NDS_SYSTEM.us4_rvalid),
	.rready(`NDS_SYSTEM.us4_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[4].size()==0),
	.sid(ar_mst_target_slvids[4][0])
);
`endif
`ifdef ATCBMC300_MST5_SUPPORT
prfm_checker_rmst #(.MID(4'd5)) rmst5 (.*,
	.rvalid(`NDS_SYSTEM.us5_rvalid),
	.rready(`NDS_SYSTEM.us5_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[5].size()==0),
	.sid(ar_mst_target_slvids[5][0])
);
`endif
`ifdef ATCBMC300_MST6_SUPPORT
prfm_checker_rmst #(.MID(4'd6)) rmst6 (.*,
	.rvalid(`NDS_SYSTEM.us6_rvalid),
	.rready(`NDS_SYSTEM.us6_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[6].size()==0),
	.sid(ar_mst_target_slvids[6][0])
);
`endif
`ifdef ATCBMC300_MST7_SUPPORT
prfm_checker_rmst #(.MID(4'd7)) rmst7 (.*,
	.rvalid(`NDS_SYSTEM.us7_rvalid),
	.rready(`NDS_SYSTEM.us7_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[7].size()==0),
	.sid(ar_mst_target_slvids[7][0])
);
`endif
`ifdef ATCBMC300_MST8_SUPPORT
prfm_checker_rmst #(.MID(4'd8)) rmst8 (.*,
	.rvalid(`NDS_SYSTEM.us8_rvalid),
	.rready(`NDS_SYSTEM.us8_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[8].size()==0),
	.sid(ar_mst_target_slvids[8][0])
);
`endif
`ifdef ATCBMC300_MST9_SUPPORT
prfm_checker_rmst #(.MID(4'd9)) rmst9 (.*,
	.rvalid(`NDS_SYSTEM.us9_rvalid),
	.rready(`NDS_SYSTEM.us9_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[9].size()==0),
	.sid(ar_mst_target_slvids[9][0])
);
`endif
`ifdef ATCBMC300_MST10_SUPPORT
prfm_checker_rmst #(.MID(4'd10)) rmst10 (.*,
	.rvalid(`NDS_SYSTEM.us10_rvalid),
	.rready(`NDS_SYSTEM.us10_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[10].size()==0),
	.sid(ar_mst_target_slvids[10][0])
);
`endif
`ifdef ATCBMC300_MST11_SUPPORT
prfm_checker_rmst #(.MID(4'd11)) rmst11 (.*,
	.rvalid(`NDS_SYSTEM.us11_rvalid),
	.rready(`NDS_SYSTEM.us11_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[11].size()==0),
	.sid(ar_mst_target_slvids[11][0])
);
`endif
`ifdef ATCBMC300_MST12_SUPPORT
prfm_checker_rmst #(.MID(4'd12)) rmst12 (.*,
	.rvalid(`NDS_SYSTEM.us12_rvalid),
	.rready(`NDS_SYSTEM.us12_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[12].size()==0),
	.sid(ar_mst_target_slvids[12][0])
);
`endif
`ifdef ATCBMC300_MST13_SUPPORT
prfm_checker_rmst #(.MID(4'd13)) rmst13 (.*,
	.rvalid(`NDS_SYSTEM.us13_rvalid),
	.rready(`NDS_SYSTEM.us13_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[13].size()==0),
	.sid(ar_mst_target_slvids[13][0])
);
`endif
`ifdef ATCBMC300_MST14_SUPPORT
prfm_checker_rmst #(.MID(4'd14)) rmst14 (.*,
	.rvalid(`NDS_SYSTEM.us14_rvalid),
	.rready(`NDS_SYSTEM.us14_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[14].size()==0),
	.sid(ar_mst_target_slvids[14][0])
);
`endif
`ifdef ATCBMC300_MST15_SUPPORT
prfm_checker_rmst #(.MID(4'd15)) rmst15 (.*,
	.rvalid(`NDS_SYSTEM.us15_rvalid),
	.rready(`NDS_SYSTEM.us15_rready),
	.ds_rvalids(ds_rvalids),
	.aq_empty(ar_mst_target_slvids[15].size()==0),
	.sid(ar_mst_target_slvids[15][0])
);
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
prfm_checker_wslv #(.SID(5'd1), .ID_WIDTH(DS_ID_WIDTH)) wslv1 (.*,
	.wvalid(`NDS_SYSTEM.ds1_wvalid),
	.wready(`NDS_SYSTEM.ds1_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave1.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave1.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
prfm_checker_wslv #(.SID(5'd2), .ID_WIDTH(DS_ID_WIDTH)) wslv2 (.*,
	.wvalid(`NDS_SYSTEM.ds2_wvalid),
	.wready(`NDS_SYSTEM.ds2_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave2.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave2.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
prfm_checker_wslv #(.SID(5'd3), .ID_WIDTH(DS_ID_WIDTH)) wslv3 (.*,
	.wvalid(`NDS_SYSTEM.ds3_wvalid),
	.wready(`NDS_SYSTEM.ds3_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave3.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave3.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
prfm_checker_wslv #(.SID(5'd4), .ID_WIDTH(DS_ID_WIDTH)) wslv4 (.*,
	.wvalid(`NDS_SYSTEM.ds4_wvalid),
	.wready(`NDS_SYSTEM.ds4_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave4.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave4.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
prfm_checker_wslv #(.SID(5'd5), .ID_WIDTH(DS_ID_WIDTH)) wslv5 (.*,
	.wvalid(`NDS_SYSTEM.ds5_wvalid),
	.wready(`NDS_SYSTEM.ds5_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave5.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave5.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
prfm_checker_wslv #(.SID(5'd6), .ID_WIDTH(DS_ID_WIDTH)) wslv6 (.*,
	.wvalid(`NDS_SYSTEM.ds6_wvalid),
	.wready(`NDS_SYSTEM.ds6_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave6.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave6.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
prfm_checker_wslv #(.SID(5'd7), .ID_WIDTH(DS_ID_WIDTH)) wslv7 (.*,
	.wvalid(`NDS_SYSTEM.ds7_wvalid),
	.wready(`NDS_SYSTEM.ds7_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave7.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave7.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
prfm_checker_wslv #(.SID(5'd8), .ID_WIDTH(DS_ID_WIDTH)) wslv8 (.*,
	.wvalid(`NDS_SYSTEM.ds8_wvalid),
	.wready(`NDS_SYSTEM.ds8_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave8.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave8.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
prfm_checker_wslv #(.SID(5'd9), .ID_WIDTH(DS_ID_WIDTH)) wslv9 (.*,
	.wvalid(`NDS_SYSTEM.ds9_wvalid),
	.wready(`NDS_SYSTEM.ds9_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave9.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave9.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
prfm_checker_wslv #(.SID(5'd10), .ID_WIDTH(DS_ID_WIDTH)) wslv10 (.*,
	.wvalid(`NDS_SYSTEM.ds10_wvalid),
	.wready(`NDS_SYSTEM.ds10_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave10.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave10.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
prfm_checker_wslv #(.SID(5'd11), .ID_WIDTH(DS_ID_WIDTH)) wslv11 (.*,
	.wvalid(`NDS_SYSTEM.ds11_wvalid),
	.wready(`NDS_SYSTEM.ds11_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave11.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave11.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
prfm_checker_wslv #(.SID(5'd12), .ID_WIDTH(DS_ID_WIDTH)) wslv12 (.*,
	.wvalid(`NDS_SYSTEM.ds12_wvalid),
	.wready(`NDS_SYSTEM.ds12_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave12.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave12.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
prfm_checker_wslv #(.SID(5'd13), .ID_WIDTH(DS_ID_WIDTH)) wslv13 (.*,
	.wvalid(`NDS_SYSTEM.ds13_wvalid),
	.wready(`NDS_SYSTEM.ds13_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave13.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave13.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
prfm_checker_wslv #(.SID(5'd14), .ID_WIDTH(DS_ID_WIDTH)) wslv14 (.*,
	.wvalid(`NDS_SYSTEM.ds14_wvalid),
	.wready(`NDS_SYSTEM.ds14_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave14.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave14.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
prfm_checker_wslv #(.SID(5'd15), .ID_WIDTH(DS_ID_WIDTH)) wslv15 (.*,
	.wvalid(`NDS_SYSTEM.ds15_wvalid),
	.wready(`NDS_SYSTEM.ds15_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave15.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave15.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
prfm_checker_wslv #(.SID(5'd16), .ID_WIDTH(DS_ID_WIDTH)) wslv16 (.*,
	.wvalid(`NDS_SYSTEM.ds16_wvalid),
	.wready(`NDS_SYSTEM.ds16_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave16.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave16.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
prfm_checker_wslv #(.SID(5'd17), .ID_WIDTH(DS_ID_WIDTH)) wslv17 (.*,
	.wvalid(`NDS_SYSTEM.ds17_wvalid),
	.wready(`NDS_SYSTEM.ds17_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave17.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave17.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
prfm_checker_wslv #(.SID(5'd18), .ID_WIDTH(DS_ID_WIDTH)) wslv18 (.*,
	.wvalid(`NDS_SYSTEM.ds18_wvalid),
	.wready(`NDS_SYSTEM.ds18_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave18.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave18.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
prfm_checker_wslv #(.SID(5'd19), .ID_WIDTH(DS_ID_WIDTH)) wslv19 (.*,
	.wvalid(`NDS_SYSTEM.ds19_wvalid),
	.wready(`NDS_SYSTEM.ds19_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave19.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave19.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
prfm_checker_wslv #(.SID(5'd20), .ID_WIDTH(DS_ID_WIDTH)) wslv20 (.*,
	.wvalid(`NDS_SYSTEM.ds20_wvalid),
	.wready(`NDS_SYSTEM.ds20_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave20.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave20.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
prfm_checker_wslv #(.SID(5'd21), .ID_WIDTH(DS_ID_WIDTH)) wslv21 (.*,
	.wvalid(`NDS_SYSTEM.ds21_wvalid),
	.wready(`NDS_SYSTEM.ds21_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave21.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave21.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
prfm_checker_wslv #(.SID(5'd22), .ID_WIDTH(DS_ID_WIDTH)) wslv22 (.*,
	.wvalid(`NDS_SYSTEM.ds22_wvalid),
	.wready(`NDS_SYSTEM.ds22_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave22.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave22.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
prfm_checker_wslv #(.SID(5'd23), .ID_WIDTH(DS_ID_WIDTH)) wslv23 (.*,
	.wvalid(`NDS_SYSTEM.ds23_wvalid),
	.wready(`NDS_SYSTEM.ds23_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave23.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave23.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
prfm_checker_wslv #(.SID(5'd24), .ID_WIDTH(DS_ID_WIDTH)) wslv24 (.*,
	.wvalid(`NDS_SYSTEM.ds24_wvalid),
	.wready(`NDS_SYSTEM.ds24_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave24.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave24.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
prfm_checker_wslv #(.SID(5'd25), .ID_WIDTH(DS_ID_WIDTH)) wslv25 (.*,
	.wvalid(`NDS_SYSTEM.ds25_wvalid),
	.wready(`NDS_SYSTEM.ds25_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave25.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave25.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
prfm_checker_wslv #(.SID(5'd26), .ID_WIDTH(DS_ID_WIDTH)) wslv26 (.*,
	.wvalid(`NDS_SYSTEM.ds26_wvalid),
	.wready(`NDS_SYSTEM.ds26_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave26.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave26.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
prfm_checker_wslv #(.SID(5'd27), .ID_WIDTH(DS_ID_WIDTH)) wslv27 (.*,
	.wvalid(`NDS_SYSTEM.ds27_wvalid),
	.wready(`NDS_SYSTEM.ds27_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave27.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave27.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
prfm_checker_wslv #(.SID(5'd28), .ID_WIDTH(DS_ID_WIDTH)) wslv28 (.*,
	.wvalid(`NDS_SYSTEM.ds28_wvalid),
	.wready(`NDS_SYSTEM.ds28_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave28.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave28.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
prfm_checker_wslv #(.SID(5'd29), .ID_WIDTH(DS_ID_WIDTH)) wslv29 (.*,
	.wvalid(`NDS_SYSTEM.ds29_wvalid),
	.wready(`NDS_SYSTEM.ds29_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave29.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave29.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
prfm_checker_wslv #(.SID(5'd30), .ID_WIDTH(DS_ID_WIDTH)) wslv30 (.*,
	.wvalid(`NDS_SYSTEM.ds30_wvalid),
	.wready(`NDS_SYSTEM.ds30_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave30.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave30.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
prfm_checker_wslv #(.SID(5'd31), .ID_WIDTH(DS_ID_WIDTH)) wslv31 (.*,
	.wvalid(`NDS_SYSTEM.ds31_wvalid),
	.wready(`NDS_SYSTEM.ds31_wready),
	.aq_empty(`NDS_SYSTEM.axi_slave31.waq_empty[0]),
	.xid(`NDS_SYSTEM.axi_slave31.waq_rdata_per_id[0][ADDR_WIDTH+DS_ID_WIDTH-1:ADDR_WIDTH])
);
`endif
// VPERL_GENERATED_END

// The read channel master ID for each slave.
reg		slv_rvalids_d1[0:31];	// A flag telling if there's any valid read command.
reg [3:0]	slv_rmids_d1[0:31];	// Corresponding master ID.
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn) begin
		for (int y = 0; y < 32; y++) begin
			slv_rvalids_d1[y] <= 1'b0;
			slv_rmids_d1[y] <= 4'b0;
		end
	end
	else begin
		// The master needs at least one cycle to see the new
		// corresponding rvalid so delay rmid by one cycle.
		// We can't use the info directly inside axi_slave_model since
		// there's some buffering in BMC300. That is, when
		// axi_slave_model thinks it has finished a transaction,
		// actually that transaction may still be pending inside
		// BMC300.
		// VPERL_BEGIN
		// foreach $y (1 .. 31) {
		//   :`ifdef ATCBMC300_SLV${y}_SUPPORT
		//#   :slv_rmids_d1[$y] <= `NDS_SYSTEM.axi_slave${y}.raq_rdata[ADDR_WIDTH+4-1:ADDR_WIDTH];
		//   :slv_rvalids_d1[$y] <= `NDS_BMC.ds${y}_ctrl.ds_rd_data.slv_rvalid;
		//   :slv_rmids_d1[$y] <= `NDS_BMC.ds${y}_ctrl.ds_rd_data.slv_rid[3:0];
		//   :`endif
		// }
		// VPERL_END

		// VPERL_GENERATED_BEGIN
		`ifdef ATCBMC300_SLV1_SUPPORT
		slv_rvalids_d1[1] <= `NDS_BMC.ds1_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[1] <= `NDS_BMC.ds1_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV2_SUPPORT
		slv_rvalids_d1[2] <= `NDS_BMC.ds2_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[2] <= `NDS_BMC.ds2_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV3_SUPPORT
		slv_rvalids_d1[3] <= `NDS_BMC.ds3_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[3] <= `NDS_BMC.ds3_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV4_SUPPORT
		slv_rvalids_d1[4] <= `NDS_BMC.ds4_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[4] <= `NDS_BMC.ds4_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV5_SUPPORT
		slv_rvalids_d1[5] <= `NDS_BMC.ds5_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[5] <= `NDS_BMC.ds5_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV6_SUPPORT
		slv_rvalids_d1[6] <= `NDS_BMC.ds6_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[6] <= `NDS_BMC.ds6_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV7_SUPPORT
		slv_rvalids_d1[7] <= `NDS_BMC.ds7_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[7] <= `NDS_BMC.ds7_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV8_SUPPORT
		slv_rvalids_d1[8] <= `NDS_BMC.ds8_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[8] <= `NDS_BMC.ds8_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV9_SUPPORT
		slv_rvalids_d1[9] <= `NDS_BMC.ds9_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[9] <= `NDS_BMC.ds9_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV10_SUPPORT
		slv_rvalids_d1[10] <= `NDS_BMC.ds10_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[10] <= `NDS_BMC.ds10_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV11_SUPPORT
		slv_rvalids_d1[11] <= `NDS_BMC.ds11_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[11] <= `NDS_BMC.ds11_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV12_SUPPORT
		slv_rvalids_d1[12] <= `NDS_BMC.ds12_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[12] <= `NDS_BMC.ds12_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV13_SUPPORT
		slv_rvalids_d1[13] <= `NDS_BMC.ds13_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[13] <= `NDS_BMC.ds13_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV14_SUPPORT
		slv_rvalids_d1[14] <= `NDS_BMC.ds14_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[14] <= `NDS_BMC.ds14_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV15_SUPPORT
		slv_rvalids_d1[15] <= `NDS_BMC.ds15_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[15] <= `NDS_BMC.ds15_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV16_SUPPORT
		slv_rvalids_d1[16] <= `NDS_BMC.ds16_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[16] <= `NDS_BMC.ds16_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV17_SUPPORT
		slv_rvalids_d1[17] <= `NDS_BMC.ds17_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[17] <= `NDS_BMC.ds17_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV18_SUPPORT
		slv_rvalids_d1[18] <= `NDS_BMC.ds18_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[18] <= `NDS_BMC.ds18_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV19_SUPPORT
		slv_rvalids_d1[19] <= `NDS_BMC.ds19_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[19] <= `NDS_BMC.ds19_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV20_SUPPORT
		slv_rvalids_d1[20] <= `NDS_BMC.ds20_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[20] <= `NDS_BMC.ds20_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV21_SUPPORT
		slv_rvalids_d1[21] <= `NDS_BMC.ds21_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[21] <= `NDS_BMC.ds21_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV22_SUPPORT
		slv_rvalids_d1[22] <= `NDS_BMC.ds22_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[22] <= `NDS_BMC.ds22_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV23_SUPPORT
		slv_rvalids_d1[23] <= `NDS_BMC.ds23_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[23] <= `NDS_BMC.ds23_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV24_SUPPORT
		slv_rvalids_d1[24] <= `NDS_BMC.ds24_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[24] <= `NDS_BMC.ds24_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV25_SUPPORT
		slv_rvalids_d1[25] <= `NDS_BMC.ds25_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[25] <= `NDS_BMC.ds25_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV26_SUPPORT
		slv_rvalids_d1[26] <= `NDS_BMC.ds26_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[26] <= `NDS_BMC.ds26_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV27_SUPPORT
		slv_rvalids_d1[27] <= `NDS_BMC.ds27_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[27] <= `NDS_BMC.ds27_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV28_SUPPORT
		slv_rvalids_d1[28] <= `NDS_BMC.ds28_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[28] <= `NDS_BMC.ds28_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV29_SUPPORT
		slv_rvalids_d1[29] <= `NDS_BMC.ds29_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[29] <= `NDS_BMC.ds29_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV30_SUPPORT
		slv_rvalids_d1[30] <= `NDS_BMC.ds30_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[30] <= `NDS_BMC.ds30_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		`ifdef ATCBMC300_SLV31_SUPPORT
		slv_rvalids_d1[31] <= `NDS_BMC.ds31_ctrl.ds_rd_data.slv_rvalid;
		slv_rmids_d1[31] <= `NDS_BMC.ds31_ctrl.ds_rd_data.slv_rid[3:0];
		`endif
		// VPERL_GENERATED_END
	end
end

// The current write channel slave ID for each master.
reg [15:0]	mst_eff_wvalids_d1;	// A flag telling if there's any valid write command.
reg [4:0]	mst_wsids_d1[0:15];	// Corresponding master ID.
always @(negedge aresetn or posedge aclk) begin
	if (!aresetn) begin
		mst_eff_wvalids_d1 <= 16'b0;
		for (int x = 0; x < 16; x++) begin
			mst_wsids_d1[x] <= 5'b0;
		end
	end
	else begin
		// The slave needs at least one cycle to see the new
		// corresponding wvalid so delay wsid by one cycle.
		// We can't use the info directly inside axi_master_model since
		// there's some buffering in BMC300. That is, when
		// axi_master_model thinks it has finished a transaction,
		// actually that transaction may still be pending inside
		// BMC300.
		// VPERL_BEGIN
		// foreach $x (0 .. 15) {
		//   :`ifdef ATCBMC300_MST${x}_SUPPORT
		// # mst_wvalid means there are data to send to the slave.
		// # However, the slave may not accept this data.
		//   :mst_eff_wvalids_d1[$x] <= `NDS_BMC.us${x}_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us${x}_ctrl.us_wr_data.master_wready;
		//   :mst_wsids_d1[$x] <= `NDS_BMC.us${x}_ctrl.us_wr_data.mst_wsid;
		//   :`endif
		// }
		// VPERL_END

		// VPERL_GENERATED_BEGIN
		`ifdef ATCBMC300_MST0_SUPPORT
		mst_eff_wvalids_d1[0] <= `NDS_BMC.us0_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us0_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[0] <= `NDS_BMC.us0_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST1_SUPPORT
		mst_eff_wvalids_d1[1] <= `NDS_BMC.us1_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us1_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[1] <= `NDS_BMC.us1_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST2_SUPPORT
		mst_eff_wvalids_d1[2] <= `NDS_BMC.us2_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us2_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[2] <= `NDS_BMC.us2_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST3_SUPPORT
		mst_eff_wvalids_d1[3] <= `NDS_BMC.us3_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us3_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[3] <= `NDS_BMC.us3_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST4_SUPPORT
		mst_eff_wvalids_d1[4] <= `NDS_BMC.us4_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us4_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[4] <= `NDS_BMC.us4_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST5_SUPPORT
		mst_eff_wvalids_d1[5] <= `NDS_BMC.us5_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us5_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[5] <= `NDS_BMC.us5_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST6_SUPPORT
		mst_eff_wvalids_d1[6] <= `NDS_BMC.us6_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us6_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[6] <= `NDS_BMC.us6_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST7_SUPPORT
		mst_eff_wvalids_d1[7] <= `NDS_BMC.us7_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us7_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[7] <= `NDS_BMC.us7_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST8_SUPPORT
		mst_eff_wvalids_d1[8] <= `NDS_BMC.us8_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us8_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[8] <= `NDS_BMC.us8_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST9_SUPPORT
		mst_eff_wvalids_d1[9] <= `NDS_BMC.us9_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us9_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[9] <= `NDS_BMC.us9_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST10_SUPPORT
		mst_eff_wvalids_d1[10] <= `NDS_BMC.us10_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us10_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[10] <= `NDS_BMC.us10_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST11_SUPPORT
		mst_eff_wvalids_d1[11] <= `NDS_BMC.us11_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us11_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[11] <= `NDS_BMC.us11_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST12_SUPPORT
		mst_eff_wvalids_d1[12] <= `NDS_BMC.us12_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us12_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[12] <= `NDS_BMC.us12_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST13_SUPPORT
		mst_eff_wvalids_d1[13] <= `NDS_BMC.us13_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us13_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[13] <= `NDS_BMC.us13_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST14_SUPPORT
		mst_eff_wvalids_d1[14] <= `NDS_BMC.us14_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us14_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[14] <= `NDS_BMC.us14_ctrl.us_wr_data.mst_wsid;
		`endif
		`ifdef ATCBMC300_MST15_SUPPORT
		mst_eff_wvalids_d1[15] <= `NDS_BMC.us15_ctrl.us_wr_data.mst_wvalid && `NDS_BMC.us15_ctrl.us_wr_data.master_wready;
		mst_wsids_d1[15] <= `NDS_BMC.us15_ctrl.us_wr_data.mst_wsid;
		`endif
		// VPERL_GENERATED_END
	end
end

endmodule
