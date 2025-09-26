// Pseudo BMC300.

`include "xmr.vh"

module pbmc300_ax_slv (
	input			aclk,
	input			aresetn,
	// Each slave can have at most 16 requests (from 16 masters).
	input [15:0]		mst_axvalids,
	input [31:0]		mst_priority_reg,
	input			outstanding_ready,
	output bit [3:0]	arb_mid,
	output			slv_axready,
	output bit		ds_axvalid_int,
	input			ds_axready
);

bit [15:0]		pending_priorities;
wire			pending_priority_avail;
wire [15:0]		incoming_priorities;
wire			incoming_priority_avail;
wire [15:0]		priorities_mx;
wire			priorities_mx_load;
wire [15:0]		arb_avalids;

// Whether any request has priority and is pending...
assign pending_priority_avail = |{pending_priorities};

// Note we don't filter-out the pending requests since they should have been
// included in pending_priorities.
assign incoming_priorities = mst_priority_reg[15:0] & mst_axvalids;
assign incoming_priority_avail = |{incoming_priorities};

// Pending priority request or incoming priority request...
assign priorities_mx = pending_priority_avail ? pending_priorities :
	incoming_priorities;
assign priorities_mx_load = |{priorities_mx};

assign arb_avalids =
	// First check if mst0 takes highest priority.
	(mst_priority_reg[31] && mst_axvalids[0]) ? 16'b1 :
	pending_priority_avail ? pending_priorities :
	incoming_priority_avail ? incoming_priorities :
	mst_axvalids;

// Decide arb_mid[] depending on the priority.
always @(*) begin
	casez (arb_avalids)
	16'b???????????????1:	arb_mid = 4'd0;
	16'b??????????????10:	arb_mid = 4'd1;
	16'b?????????????100:	arb_mid = 4'd2;
	16'b????????????1000:	arb_mid = 4'd3;
	16'b???????????10000:	arb_mid = 4'd4;
	16'b??????????100000:	arb_mid = 4'd5;
	16'b?????????1000000:	arb_mid = 4'd6;
	16'b????????10000000:	arb_mid = 4'd7;
	16'b???????100000000:	arb_mid = 4'd8;
	16'b??????1000000000:	arb_mid = 4'd9;
	16'b?????10000000000:	arb_mid = 4'd10;
	16'b????100000000000:	arb_mid = 4'd11;
	16'b???1000000000000:	arb_mid = 4'd12;
	16'b??10000000000000:	arb_mid = 4'd13;
	16'b?100000000000000:	arb_mid = 4'd14;
	16'b1000000000000000:	arb_mid = 4'd15;
	16'b0000000000000000:	arb_mid = 4'd15;
	default:		arb_mid = 4'bx;
	endcase
end

always @(negedge aresetn or posedge aclk) begin
	if (!aresetn) begin
		ds_axvalid_int <= 1'b0;
	end
	else begin
		if (ds_axvalid_int && !ds_axready) begin
			// Stalled request. Hold the value.
		end
		// Now either no request or the request is accepted.
		else if (outstanding_ready && mst_axvalids[arb_mid]) begin
			// A new valid request comes at the same time.
			ds_axvalid_int <= 1'b1;
		end
		else begin
			ds_axvalid_int <= 1'b0;
		end

		if (pending_priority_avail) begin
			if (!(ds_axvalid_int && !ds_axready) &&
					outstanding_ready) begin
				// Not stalled.... So either no request or the
				// request is accepted. This means a new
				// request can be processed.
				if (mst_priority_reg[31] && arb_mid == 4'b0)begin
					// mst0 may be flopped into
					// pending_priority or may not
					// depending on whether
					// pending_priorities are empty when
					// mst0's request comes...
				end
				else
					assert(pending_priorities[arb_mid]);
				pending_priorities[arb_mid] <= 1'b0;
			end
		end
		else begin
			// Flop new requsts with priority reload flags.
			for (int x = 0; x < 16; x++) begin
				// Note that in RTL, even when mst0 already
				// has the highest priority, it will still
				// be flopped into pending_priorities.
				pending_priorities[x] <= mst_axvalids[x] &&
					// If the current valid can be serviced,
					// skip it.
					!(arb_mid == x[3:0] && slv_axready) &&
					mst_priority_reg[x];
			end
		end
	end
end

// Whether there is a "valid" and it is not stalled, and the FIFO can
// accommodate more entries...
assign slv_axready = !(ds_axvalid_int && !ds_axready) && outstanding_ready;

endmodule


module pbmc300_ax_mst #(parameter
	bit [3:0]		MID = 4'd0,
	int			ADDR_WIDTH = 32
) (
	input			aclk,
	input			aresetn,
	input			us_axvalid,
	output			us_axready_int,
	input [ADDR_WIDTH-1:0]	us_axaddr,

	// This master drives a valid for each slave.
	output bit [31:0]	mst_slv_axvalids,
	// Each slave returns a ready (not for any specific master).
	input [31:0]		slv_axreadys,
	input [ADDR_WIDTH-1:0]	slv_bases[0:31],
	input [ADDR_WIDTH-1:0]	slv_eff_sizes[0:31],
	input [31:0]		mst_connection,

	// Each slave engine chooses a master ID for the arbitration.
	input [3:0]		arb_mids[0:31],
	input			data_channel_ready,
	input			exclusive_blocking
);

bit			pending_axvalid;
bit [ADDR_WIDTH-1:0]	pending_axaddr;

// If the pending buffer has no data, axready is high to receive more data.
assign us_axready_int = ~pending_axvalid;

wire			incoming_axvalid = pending_axvalid || us_axvalid;

// If the pending buffer has data, use the data there first.
wire [ADDR_WIDTH-1:0]	incoming_axaddr = pending_axvalid ? pending_axaddr :
	us_axaddr;

// Effective upstream axvalid's.
assign us_eff_axvalid = us_axvalid && us_axready_int;

// Consider the slave-chosen mid. That is, if that slave doesn't choose us,
// we are still stalled by that slave.
bit [31:0]	slave_axreadys;

// The master's slave interface may not be able to send out the request.
bit [31:0]	slv_blockeds;
// Decide if the slave interface has the stalled request.
bit		blocked;

always @(*) begin
	for (int y = 0; y < 32; y++) begin
		// The chosen master is us.
		slave_axreadys[y] = slv_axreadys[y] && (arb_mids[y] == MID);
		// Check if the request can be sent out to the slave.
		slv_blockeds[y] = mst_slv_axvalids[y] && ~slave_axreadys[y];
	end

	// To make things simpler, if any of the request for any slave from
	// the same master can't be serviced, we can't push new data in even
	// when the new request is for another slave. That is, we don't check
	// the target slave address first.
	blocked = |{slv_blockeds} | !data_channel_ready | exclusive_blocking;
end

always @(negedge aresetn or posedge aclk) begin
	if (!aresetn) begin
		mst_slv_axvalids <= 32'b0;
		pending_axvalid <= 1'b0;
		pending_axaddr <= {ADDR_WIDTH{1'b0}};
	end
	else begin
		for (int y = 0; y < 32; y++) begin
			if (blocked) begin
				// We can't accept the new command from either
				// the pending buffer or axvalid. However,
				// each individual valid may be consumed by
				// the slave.
				mst_slv_axvalids[y] <= mst_slv_axvalids[y] &&
					~slave_axreadys[y];
				// Hold the value when blocked.
			end
			else begin
				// Either empty or the request is accepted.
				// Then flop the new one.
				if (mst_connection[y] && incoming_axvalid &&
					incoming_axaddr >= slv_bases[y] &&
					{1'b0, incoming_axaddr} < ({1'b0, slv_bases[y]} + {1'b0, slv_eff_sizes[y]})) begin
					mst_slv_axvalids[y] <= 1'b1;
				end
				else begin
					mst_slv_axvalids[y] <= 1'b0;
				end
			end
		end

		if (blocked && us_eff_axvalid) begin
			// Stalled and the pending buffer is empty now.
			// Stored to the pending buffer.
			pending_axvalid <= 1'b1;
			pending_axaddr <= us_axaddr;
		end
		else if (!blocked && pending_axvalid) begin
			// Shifted to the slave interface.
			pending_axvalid <= 1'b0;
		end
		// The pending buffer's valid must go low for one cycle
		// before the new request can be flopped since awready
		// goes high only after the buffer is released. As
		// a result, we don't need to shift the pending buffer
		// to the interface and accept the new data at the same
		// time.
	end
end
endmodule


module pbmc300 #(parameter
	int			ADDR_WIDTH = 32
) (
	input			aclk,
	input			aresetn,
	// VPERL_BEGIN
	// foreach $x (0 .. 15) {
	//   :`ifdef ATCBMC300_MST${x}_SUPPORT
	//   :input			us${x}_arvalid,
	//   :output			us${x}_arready_int,
	//   :input [ADDR_WIDTH-1:0]	us${x}_araddr,
	//   :input			us${x}_awvalid,
	//   :output			us${x}_awready_int,
	//   :input [ADDR_WIDTH-1:0]	us${x}_awaddr,
	//   :`endif
	// }
	// foreach $y (1 .. 31) {
	//   :`ifdef ATCBMC300_SLV${y}_SUPPORT
	//   :output			ds${y}_arvalid_int,
	//   :input			ds${y}_arready,
	//   :output			ds${y}_awvalid_int,
	//   :input			ds${y}_awready,
	//   :`endif
	// }
	// VPERL_END

	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_MST0_SUPPORT
	input			us0_arvalid,
	output			us0_arready_int,
	input [ADDR_WIDTH-1:0]	us0_araddr,
	input			us0_awvalid,
	output			us0_awready_int,
	input [ADDR_WIDTH-1:0]	us0_awaddr,
	`endif
	`ifdef ATCBMC300_MST1_SUPPORT
	input			us1_arvalid,
	output			us1_arready_int,
	input [ADDR_WIDTH-1:0]	us1_araddr,
	input			us1_awvalid,
	output			us1_awready_int,
	input [ADDR_WIDTH-1:0]	us1_awaddr,
	`endif
	`ifdef ATCBMC300_MST2_SUPPORT
	input			us2_arvalid,
	output			us2_arready_int,
	input [ADDR_WIDTH-1:0]	us2_araddr,
	input			us2_awvalid,
	output			us2_awready_int,
	input [ADDR_WIDTH-1:0]	us2_awaddr,
	`endif
	`ifdef ATCBMC300_MST3_SUPPORT
	input			us3_arvalid,
	output			us3_arready_int,
	input [ADDR_WIDTH-1:0]	us3_araddr,
	input			us3_awvalid,
	output			us3_awready_int,
	input [ADDR_WIDTH-1:0]	us3_awaddr,
	`endif
	`ifdef ATCBMC300_MST4_SUPPORT
	input			us4_arvalid,
	output			us4_arready_int,
	input [ADDR_WIDTH-1:0]	us4_araddr,
	input			us4_awvalid,
	output			us4_awready_int,
	input [ADDR_WIDTH-1:0]	us4_awaddr,
	`endif
	`ifdef ATCBMC300_MST5_SUPPORT
	input			us5_arvalid,
	output			us5_arready_int,
	input [ADDR_WIDTH-1:0]	us5_araddr,
	input			us5_awvalid,
	output			us5_awready_int,
	input [ADDR_WIDTH-1:0]	us5_awaddr,
	`endif
	`ifdef ATCBMC300_MST6_SUPPORT
	input			us6_arvalid,
	output			us6_arready_int,
	input [ADDR_WIDTH-1:0]	us6_araddr,
	input			us6_awvalid,
	output			us6_awready_int,
	input [ADDR_WIDTH-1:0]	us6_awaddr,
	`endif
	`ifdef ATCBMC300_MST7_SUPPORT
	input			us7_arvalid,
	output			us7_arready_int,
	input [ADDR_WIDTH-1:0]	us7_araddr,
	input			us7_awvalid,
	output			us7_awready_int,
	input [ADDR_WIDTH-1:0]	us7_awaddr,
	`endif
	`ifdef ATCBMC300_MST8_SUPPORT
	input			us8_arvalid,
	output			us8_arready_int,
	input [ADDR_WIDTH-1:0]	us8_araddr,
	input			us8_awvalid,
	output			us8_awready_int,
	input [ADDR_WIDTH-1:0]	us8_awaddr,
	`endif
	`ifdef ATCBMC300_MST9_SUPPORT
	input			us9_arvalid,
	output			us9_arready_int,
	input [ADDR_WIDTH-1:0]	us9_araddr,
	input			us9_awvalid,
	output			us9_awready_int,
	input [ADDR_WIDTH-1:0]	us9_awaddr,
	`endif
	`ifdef ATCBMC300_MST10_SUPPORT
	input			us10_arvalid,
	output			us10_arready_int,
	input [ADDR_WIDTH-1:0]	us10_araddr,
	input			us10_awvalid,
	output			us10_awready_int,
	input [ADDR_WIDTH-1:0]	us10_awaddr,
	`endif
	`ifdef ATCBMC300_MST11_SUPPORT
	input			us11_arvalid,
	output			us11_arready_int,
	input [ADDR_WIDTH-1:0]	us11_araddr,
	input			us11_awvalid,
	output			us11_awready_int,
	input [ADDR_WIDTH-1:0]	us11_awaddr,
	`endif
	`ifdef ATCBMC300_MST12_SUPPORT
	input			us12_arvalid,
	output			us12_arready_int,
	input [ADDR_WIDTH-1:0]	us12_araddr,
	input			us12_awvalid,
	output			us12_awready_int,
	input [ADDR_WIDTH-1:0]	us12_awaddr,
	`endif
	`ifdef ATCBMC300_MST13_SUPPORT
	input			us13_arvalid,
	output			us13_arready_int,
	input [ADDR_WIDTH-1:0]	us13_araddr,
	input			us13_awvalid,
	output			us13_awready_int,
	input [ADDR_WIDTH-1:0]	us13_awaddr,
	`endif
	`ifdef ATCBMC300_MST14_SUPPORT
	input			us14_arvalid,
	output			us14_arready_int,
	input [ADDR_WIDTH-1:0]	us14_araddr,
	input			us14_awvalid,
	output			us14_awready_int,
	input [ADDR_WIDTH-1:0]	us14_awaddr,
	`endif
	`ifdef ATCBMC300_MST15_SUPPORT
	input			us15_arvalid,
	output			us15_arready_int,
	input [ADDR_WIDTH-1:0]	us15_araddr,
	input			us15_awvalid,
	output			us15_awready_int,
	input [ADDR_WIDTH-1:0]	us15_awaddr,
	`endif
	`ifdef ATCBMC300_SLV1_SUPPORT
	output			ds1_arvalid_int,
	input			ds1_arready,
	output			ds1_awvalid_int,
	input			ds1_awready,
	`endif
	`ifdef ATCBMC300_SLV2_SUPPORT
	output			ds2_arvalid_int,
	input			ds2_arready,
	output			ds2_awvalid_int,
	input			ds2_awready,
	`endif
	`ifdef ATCBMC300_SLV3_SUPPORT
	output			ds3_arvalid_int,
	input			ds3_arready,
	output			ds3_awvalid_int,
	input			ds3_awready,
	`endif
	`ifdef ATCBMC300_SLV4_SUPPORT
	output			ds4_arvalid_int,
	input			ds4_arready,
	output			ds4_awvalid_int,
	input			ds4_awready,
	`endif
	`ifdef ATCBMC300_SLV5_SUPPORT
	output			ds5_arvalid_int,
	input			ds5_arready,
	output			ds5_awvalid_int,
	input			ds5_awready,
	`endif
	`ifdef ATCBMC300_SLV6_SUPPORT
	output			ds6_arvalid_int,
	input			ds6_arready,
	output			ds6_awvalid_int,
	input			ds6_awready,
	`endif
	`ifdef ATCBMC300_SLV7_SUPPORT
	output			ds7_arvalid_int,
	input			ds7_arready,
	output			ds7_awvalid_int,
	input			ds7_awready,
	`endif
	`ifdef ATCBMC300_SLV8_SUPPORT
	output			ds8_arvalid_int,
	input			ds8_arready,
	output			ds8_awvalid_int,
	input			ds8_awready,
	`endif
	`ifdef ATCBMC300_SLV9_SUPPORT
	output			ds9_arvalid_int,
	input			ds9_arready,
	output			ds9_awvalid_int,
	input			ds9_awready,
	`endif
	`ifdef ATCBMC300_SLV10_SUPPORT
	output			ds10_arvalid_int,
	input			ds10_arready,
	output			ds10_awvalid_int,
	input			ds10_awready,
	`endif
	`ifdef ATCBMC300_SLV11_SUPPORT
	output			ds11_arvalid_int,
	input			ds11_arready,
	output			ds11_awvalid_int,
	input			ds11_awready,
	`endif
	`ifdef ATCBMC300_SLV12_SUPPORT
	output			ds12_arvalid_int,
	input			ds12_arready,
	output			ds12_awvalid_int,
	input			ds12_awready,
	`endif
	`ifdef ATCBMC300_SLV13_SUPPORT
	output			ds13_arvalid_int,
	input			ds13_arready,
	output			ds13_awvalid_int,
	input			ds13_awready,
	`endif
	`ifdef ATCBMC300_SLV14_SUPPORT
	output			ds14_arvalid_int,
	input			ds14_arready,
	output			ds14_awvalid_int,
	input			ds14_awready,
	`endif
	`ifdef ATCBMC300_SLV15_SUPPORT
	output			ds15_arvalid_int,
	input			ds15_arready,
	output			ds15_awvalid_int,
	input			ds15_awready,
	`endif
	`ifdef ATCBMC300_SLV16_SUPPORT
	output			ds16_arvalid_int,
	input			ds16_arready,
	output			ds16_awvalid_int,
	input			ds16_awready,
	`endif
	`ifdef ATCBMC300_SLV17_SUPPORT
	output			ds17_arvalid_int,
	input			ds17_arready,
	output			ds17_awvalid_int,
	input			ds17_awready,
	`endif
	`ifdef ATCBMC300_SLV18_SUPPORT
	output			ds18_arvalid_int,
	input			ds18_arready,
	output			ds18_awvalid_int,
	input			ds18_awready,
	`endif
	`ifdef ATCBMC300_SLV19_SUPPORT
	output			ds19_arvalid_int,
	input			ds19_arready,
	output			ds19_awvalid_int,
	input			ds19_awready,
	`endif
	`ifdef ATCBMC300_SLV20_SUPPORT
	output			ds20_arvalid_int,
	input			ds20_arready,
	output			ds20_awvalid_int,
	input			ds20_awready,
	`endif
	`ifdef ATCBMC300_SLV21_SUPPORT
	output			ds21_arvalid_int,
	input			ds21_arready,
	output			ds21_awvalid_int,
	input			ds21_awready,
	`endif
	`ifdef ATCBMC300_SLV22_SUPPORT
	output			ds22_arvalid_int,
	input			ds22_arready,
	output			ds22_awvalid_int,
	input			ds22_awready,
	`endif
	`ifdef ATCBMC300_SLV23_SUPPORT
	output			ds23_arvalid_int,
	input			ds23_arready,
	output			ds23_awvalid_int,
	input			ds23_awready,
	`endif
	`ifdef ATCBMC300_SLV24_SUPPORT
	output			ds24_arvalid_int,
	input			ds24_arready,
	output			ds24_awvalid_int,
	input			ds24_awready,
	`endif
	`ifdef ATCBMC300_SLV25_SUPPORT
	output			ds25_arvalid_int,
	input			ds25_arready,
	output			ds25_awvalid_int,
	input			ds25_awready,
	`endif
	`ifdef ATCBMC300_SLV26_SUPPORT
	output			ds26_arvalid_int,
	input			ds26_arready,
	output			ds26_awvalid_int,
	input			ds26_awready,
	`endif
	`ifdef ATCBMC300_SLV27_SUPPORT
	output			ds27_arvalid_int,
	input			ds27_arready,
	output			ds27_awvalid_int,
	input			ds27_awready,
	`endif
	`ifdef ATCBMC300_SLV28_SUPPORT
	output			ds28_arvalid_int,
	input			ds28_arready,
	output			ds28_awvalid_int,
	input			ds28_awready,
	`endif
	`ifdef ATCBMC300_SLV29_SUPPORT
	output			ds29_arvalid_int,
	input			ds29_arready,
	output			ds29_awvalid_int,
	input			ds29_awready,
	`endif
	`ifdef ATCBMC300_SLV30_SUPPORT
	output			ds30_arvalid_int,
	input			ds30_arready,
	output			ds30_awvalid_int,
	input			ds30_awready,
	`endif
	`ifdef ATCBMC300_SLV31_SUPPORT
	output			ds31_arvalid_int,
	input			ds31_arready,
	output			ds31_awvalid_int,
	input			ds31_awready,
	`endif
	// VPERL_GENERATED_END
	input [ADDR_WIDTH-1:0]	slv_bases[0:31],
	input [ADDR_WIDTH-1:0]	slv_eff_sizes[0:31]
);

wire [31:0]	slv_arreadys, slv_awreadys;
wire [3:0]	ar_arb_mids[0:31], aw_arb_mids[0:31];
wire [31:0]	mst_slv_arvalids0, mst_slv_arvalids1, mst_slv_arvalids2,
		mst_slv_arvalids3, mst_slv_arvalids4, mst_slv_arvalids5,
		mst_slv_arvalids6, mst_slv_arvalids7, mst_slv_arvalids8,
		mst_slv_arvalids9, mst_slv_arvalids10, mst_slv_arvalids11,
		mst_slv_arvalids12, mst_slv_arvalids13, mst_slv_arvalids14,
		mst_slv_arvalids15;
wire [31:0]	mst_slv_awvalids0, mst_slv_awvalids1, mst_slv_awvalids2,
		mst_slv_awvalids3, mst_slv_awvalids4, mst_slv_awvalids5,
		mst_slv_awvalids6, mst_slv_awvalids7, mst_slv_awvalids8,
		mst_slv_awvalids9, mst_slv_awvalids10, mst_slv_awvalids11,
		mst_slv_awvalids12, mst_slv_awvalids13, mst_slv_awvalids14,
		mst_slv_awvalids15;

wire [31:0]	mst_priority_reg = {
	`NDS_BMC.reg_mst0_high_priority,
	15'b0,
	`NDS_BMC.reg_priority_reload
};

wire [31:0]	ar_outstanding_readys = {
	// VPERL: for ($y = 31; $y > 0; $y--) { print("`ifdef ATCBMC300_SLV${y}_SUPPORT `NDS_BMC.ds${y}_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,\n"); }
	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_SLV31_SUPPORT `NDS_BMC.ds31_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV30_SUPPORT `NDS_BMC.ds30_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV29_SUPPORT `NDS_BMC.ds29_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV28_SUPPORT `NDS_BMC.ds28_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV27_SUPPORT `NDS_BMC.ds27_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV26_SUPPORT `NDS_BMC.ds26_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV25_SUPPORT `NDS_BMC.ds25_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV24_SUPPORT `NDS_BMC.ds24_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV23_SUPPORT `NDS_BMC.ds23_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV22_SUPPORT `NDS_BMC.ds22_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV21_SUPPORT `NDS_BMC.ds21_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV20_SUPPORT `NDS_BMC.ds20_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV19_SUPPORT `NDS_BMC.ds19_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV18_SUPPORT `NDS_BMC.ds18_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV17_SUPPORT `NDS_BMC.ds17_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV16_SUPPORT `NDS_BMC.ds16_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV15_SUPPORT `NDS_BMC.ds15_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV14_SUPPORT `NDS_BMC.ds14_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV13_SUPPORT `NDS_BMC.ds13_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV12_SUPPORT `NDS_BMC.ds12_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV11_SUPPORT `NDS_BMC.ds11_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV10_SUPPORT `NDS_BMC.ds10_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV9_SUPPORT `NDS_BMC.ds9_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV8_SUPPORT `NDS_BMC.ds8_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV7_SUPPORT `NDS_BMC.ds7_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV6_SUPPORT `NDS_BMC.ds6_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV5_SUPPORT `NDS_BMC.ds5_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV4_SUPPORT `NDS_BMC.ds4_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV3_SUPPORT `NDS_BMC.ds3_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV2_SUPPORT `NDS_BMC.ds2_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV1_SUPPORT `NDS_BMC.ds1_ctrl.ds_rd_data.outstanding_ready `else 1'b0 `endif,
	// VPERL_GENERATED_END
	1'b1
};
wire [31:0]	aw_outstanding_readys = {
	// VPERL: for ($y = 31; $y > 0; $y--) { print("`ifdef ATCBMC300_SLV${y}_SUPPORT `NDS_BMC.ds${y}_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,\n"); }
	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_SLV31_SUPPORT `NDS_BMC.ds31_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV30_SUPPORT `NDS_BMC.ds30_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV29_SUPPORT `NDS_BMC.ds29_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV28_SUPPORT `NDS_BMC.ds28_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV27_SUPPORT `NDS_BMC.ds27_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV26_SUPPORT `NDS_BMC.ds26_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV25_SUPPORT `NDS_BMC.ds25_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV24_SUPPORT `NDS_BMC.ds24_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV23_SUPPORT `NDS_BMC.ds23_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV22_SUPPORT `NDS_BMC.ds22_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV21_SUPPORT `NDS_BMC.ds21_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV20_SUPPORT `NDS_BMC.ds20_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV19_SUPPORT `NDS_BMC.ds19_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV18_SUPPORT `NDS_BMC.ds18_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV17_SUPPORT `NDS_BMC.ds17_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV16_SUPPORT `NDS_BMC.ds16_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV15_SUPPORT `NDS_BMC.ds15_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV14_SUPPORT `NDS_BMC.ds14_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV13_SUPPORT `NDS_BMC.ds13_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV12_SUPPORT `NDS_BMC.ds12_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV11_SUPPORT `NDS_BMC.ds11_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV10_SUPPORT `NDS_BMC.ds10_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV9_SUPPORT `NDS_BMC.ds9_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV8_SUPPORT `NDS_BMC.ds8_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV7_SUPPORT `NDS_BMC.ds7_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV6_SUPPORT `NDS_BMC.ds6_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV5_SUPPORT `NDS_BMC.ds5_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV4_SUPPORT `NDS_BMC.ds4_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV3_SUPPORT `NDS_BMC.ds3_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV2_SUPPORT `NDS_BMC.ds2_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	`ifdef ATCBMC300_SLV1_SUPPORT `NDS_BMC.ds1_ctrl.ds_wdata_bresp.outstanding_ready `else 1'b0 `endif,
	// VPERL_GENERATED_END
	1'b1
};

// VPERL_BEGIN
// foreach $w ("r", "w") {
//   foreach $x (0 .. 15) {
//     : `ifdef ATCBMC300_MST${x}_SUPPORT
//     : pbmc300_ax_mst #(.MID(4'd$x), .ADDR_WIDTH(ADDR_WIDTH)) a${w}_mst${x}(.*,
//     : 	.us_axvalid	(us${x}_a${w}valid),
//     : 	.us_axready_int	(us${x}_a${w}ready_int),
//     : 	.us_axaddr	(us${x}_a${w}addr),
//     : 	.mst_slv_axvalids(mst_slv_a${w}valids${x}),
//     : 	.slv_axreadys	(slv_a${w}readys),
//     : 	.mst_connection	(`NDS_M${x}_CONNS),
//     : 	.arb_mids	(a${w}_arb_mids),
//     : 	.data_channel_ready(`ifdef ATCBMC300_MST${x}_SUPPORT `NDS_BMC.us${x}_ctrl.us_a${w}_addr.data_channel_ready `else 1'b1 `endif),
//     if ($w eq "r") {
//       : 	.exclusive_blocking(`ifdef ATCBMC300_MST${x}_SUPPORT `NDS_BMC.us${x}_ctrl.us_a${w}_addr.read_exclusive_blocking `else 1'b0 `endif)
//     } else {
//       : 	.exclusive_blocking(`ifdef ATCBMC300_MST${x}_SUPPORT `NDS_BMC.us${x}_ctrl.us_a${w}_addr.write_exclusive_blocking `else 1'b0 `endif)
//     }
//     : );
//     : `else
//     : assign us${x}_a${w}_ready_int = 1'b1;
//     : assign mst_slv_a${w}valids${x} = 32'b0;
//     : `endif
//   }
// }
// foreach $w ("r", "w") {
//   foreach $y (1 .. 31) {
//     : `ifdef ATCBMC300_SLV${y}_SUPPORT
//     : pbmc300_ax_slv a${w}_slv${y}(.*,
//     : 	.mst_axvalids	(\{
//     :		mst_slv_a${w}valids15[$y], mst_slv_a${w}valids14[$y], 
//     :		mst_slv_a${w}valids13[$y], mst_slv_a${w}valids12[$y], 
//     :		mst_slv_a${w}valids11[$y], mst_slv_a${w}valids10[$y], 
//     :		mst_slv_a${w}valids9[$y], mst_slv_a${w}valids8[$y], 
//     :		mst_slv_a${w}valids7[$y], mst_slv_a${w}valids6[$y], 
//     :		mst_slv_a${w}valids5[$y], mst_slv_a${w}valids4[$y], 
//     :		mst_slv_a${w}valids3[$y], mst_slv_a${w}valids2[$y], 
//     :		mst_slv_a${w}valids1[$y], mst_slv_a${w}valids0[$y]\}),
//     : 	.outstanding_ready(a${w}_outstanding_readys[$y]),
//     : 	.arb_mid	(a${w}_arb_mids[$y]),
//     : 	.slv_axready	(slv_a${w}readys[$y]),
//     : 	.ds_axvalid_int	(ds${y}_a${w}valid_int),
//     if ($y == 0) {
//       : 	.ds_axready	(`NDS_BMC.ds0_ctrl.slv0_a${w}ready)
//     } else {
//       : 	.ds_axready	(ds${y}_a${w}ready)
//     }
//     : );
//     : `else
//     : assign a${w}_arb_mids[$y] = 4'hf;
//     : assign slv_a${w}readys[$y] = 1'b1;
//     : assign ds${y}_a${w}valid_int = 1'b0;
//     : `endif
//   }
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
pbmc300_ax_mst #(.MID(4'd0), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst0(.*,
	.us_axvalid	(us0_arvalid),
	.us_axready_int	(us0_arready_int),
	.us_axaddr	(us0_araddr),
	.mst_slv_axvalids(mst_slv_arvalids0),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M0_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST0_SUPPORT `NDS_BMC.us0_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST0_SUPPORT `NDS_BMC.us0_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us0_ar_ready_int = 1'b1;
assign mst_slv_arvalids0 = 32'b0;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
pbmc300_ax_mst #(.MID(4'd1), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst1(.*,
	.us_axvalid	(us1_arvalid),
	.us_axready_int	(us1_arready_int),
	.us_axaddr	(us1_araddr),
	.mst_slv_axvalids(mst_slv_arvalids1),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M1_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST1_SUPPORT `NDS_BMC.us1_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST1_SUPPORT `NDS_BMC.us1_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us1_ar_ready_int = 1'b1;
assign mst_slv_arvalids1 = 32'b0;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
pbmc300_ax_mst #(.MID(4'd2), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst2(.*,
	.us_axvalid	(us2_arvalid),
	.us_axready_int	(us2_arready_int),
	.us_axaddr	(us2_araddr),
	.mst_slv_axvalids(mst_slv_arvalids2),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M2_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST2_SUPPORT `NDS_BMC.us2_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST2_SUPPORT `NDS_BMC.us2_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us2_ar_ready_int = 1'b1;
assign mst_slv_arvalids2 = 32'b0;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
pbmc300_ax_mst #(.MID(4'd3), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst3(.*,
	.us_axvalid	(us3_arvalid),
	.us_axready_int	(us3_arready_int),
	.us_axaddr	(us3_araddr),
	.mst_slv_axvalids(mst_slv_arvalids3),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M3_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST3_SUPPORT `NDS_BMC.us3_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST3_SUPPORT `NDS_BMC.us3_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us3_ar_ready_int = 1'b1;
assign mst_slv_arvalids3 = 32'b0;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
pbmc300_ax_mst #(.MID(4'd4), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst4(.*,
	.us_axvalid	(us4_arvalid),
	.us_axready_int	(us4_arready_int),
	.us_axaddr	(us4_araddr),
	.mst_slv_axvalids(mst_slv_arvalids4),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M4_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST4_SUPPORT `NDS_BMC.us4_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST4_SUPPORT `NDS_BMC.us4_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us4_ar_ready_int = 1'b1;
assign mst_slv_arvalids4 = 32'b0;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
pbmc300_ax_mst #(.MID(4'd5), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst5(.*,
	.us_axvalid	(us5_arvalid),
	.us_axready_int	(us5_arready_int),
	.us_axaddr	(us5_araddr),
	.mst_slv_axvalids(mst_slv_arvalids5),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M5_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST5_SUPPORT `NDS_BMC.us5_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST5_SUPPORT `NDS_BMC.us5_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us5_ar_ready_int = 1'b1;
assign mst_slv_arvalids5 = 32'b0;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
pbmc300_ax_mst #(.MID(4'd6), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst6(.*,
	.us_axvalid	(us6_arvalid),
	.us_axready_int	(us6_arready_int),
	.us_axaddr	(us6_araddr),
	.mst_slv_axvalids(mst_slv_arvalids6),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M6_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST6_SUPPORT `NDS_BMC.us6_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST6_SUPPORT `NDS_BMC.us6_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us6_ar_ready_int = 1'b1;
assign mst_slv_arvalids6 = 32'b0;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
pbmc300_ax_mst #(.MID(4'd7), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst7(.*,
	.us_axvalid	(us7_arvalid),
	.us_axready_int	(us7_arready_int),
	.us_axaddr	(us7_araddr),
	.mst_slv_axvalids(mst_slv_arvalids7),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M7_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST7_SUPPORT `NDS_BMC.us7_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST7_SUPPORT `NDS_BMC.us7_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us7_ar_ready_int = 1'b1;
assign mst_slv_arvalids7 = 32'b0;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
pbmc300_ax_mst #(.MID(4'd8), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst8(.*,
	.us_axvalid	(us8_arvalid),
	.us_axready_int	(us8_arready_int),
	.us_axaddr	(us8_araddr),
	.mst_slv_axvalids(mst_slv_arvalids8),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M8_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST8_SUPPORT `NDS_BMC.us8_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST8_SUPPORT `NDS_BMC.us8_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us8_ar_ready_int = 1'b1;
assign mst_slv_arvalids8 = 32'b0;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
pbmc300_ax_mst #(.MID(4'd9), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst9(.*,
	.us_axvalid	(us9_arvalid),
	.us_axready_int	(us9_arready_int),
	.us_axaddr	(us9_araddr),
	.mst_slv_axvalids(mst_slv_arvalids9),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M9_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST9_SUPPORT `NDS_BMC.us9_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST9_SUPPORT `NDS_BMC.us9_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us9_ar_ready_int = 1'b1;
assign mst_slv_arvalids9 = 32'b0;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
pbmc300_ax_mst #(.MID(4'd10), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst10(.*,
	.us_axvalid	(us10_arvalid),
	.us_axready_int	(us10_arready_int),
	.us_axaddr	(us10_araddr),
	.mst_slv_axvalids(mst_slv_arvalids10),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M10_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST10_SUPPORT `NDS_BMC.us10_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST10_SUPPORT `NDS_BMC.us10_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us10_ar_ready_int = 1'b1;
assign mst_slv_arvalids10 = 32'b0;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
pbmc300_ax_mst #(.MID(4'd11), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst11(.*,
	.us_axvalid	(us11_arvalid),
	.us_axready_int	(us11_arready_int),
	.us_axaddr	(us11_araddr),
	.mst_slv_axvalids(mst_slv_arvalids11),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M11_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST11_SUPPORT `NDS_BMC.us11_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST11_SUPPORT `NDS_BMC.us11_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us11_ar_ready_int = 1'b1;
assign mst_slv_arvalids11 = 32'b0;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
pbmc300_ax_mst #(.MID(4'd12), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst12(.*,
	.us_axvalid	(us12_arvalid),
	.us_axready_int	(us12_arready_int),
	.us_axaddr	(us12_araddr),
	.mst_slv_axvalids(mst_slv_arvalids12),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M12_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST12_SUPPORT `NDS_BMC.us12_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST12_SUPPORT `NDS_BMC.us12_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us12_ar_ready_int = 1'b1;
assign mst_slv_arvalids12 = 32'b0;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
pbmc300_ax_mst #(.MID(4'd13), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst13(.*,
	.us_axvalid	(us13_arvalid),
	.us_axready_int	(us13_arready_int),
	.us_axaddr	(us13_araddr),
	.mst_slv_axvalids(mst_slv_arvalids13),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M13_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST13_SUPPORT `NDS_BMC.us13_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST13_SUPPORT `NDS_BMC.us13_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us13_ar_ready_int = 1'b1;
assign mst_slv_arvalids13 = 32'b0;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
pbmc300_ax_mst #(.MID(4'd14), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst14(.*,
	.us_axvalid	(us14_arvalid),
	.us_axready_int	(us14_arready_int),
	.us_axaddr	(us14_araddr),
	.mst_slv_axvalids(mst_slv_arvalids14),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M14_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST14_SUPPORT `NDS_BMC.us14_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST14_SUPPORT `NDS_BMC.us14_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us14_ar_ready_int = 1'b1;
assign mst_slv_arvalids14 = 32'b0;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
pbmc300_ax_mst #(.MID(4'd15), .ADDR_WIDTH(ADDR_WIDTH)) ar_mst15(.*,
	.us_axvalid	(us15_arvalid),
	.us_axready_int	(us15_arready_int),
	.us_axaddr	(us15_araddr),
	.mst_slv_axvalids(mst_slv_arvalids15),
	.slv_axreadys	(slv_arreadys),
	.mst_connection	(`NDS_M15_CONNS),
	.arb_mids	(ar_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST15_SUPPORT `NDS_BMC.us15_ctrl.us_ar_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST15_SUPPORT `NDS_BMC.us15_ctrl.us_ar_addr.read_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us15_ar_ready_int = 1'b1;
assign mst_slv_arvalids15 = 32'b0;
`endif
`ifdef ATCBMC300_MST0_SUPPORT
pbmc300_ax_mst #(.MID(4'd0), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst0(.*,
	.us_axvalid	(us0_awvalid),
	.us_axready_int	(us0_awready_int),
	.us_axaddr	(us0_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids0),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M0_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST0_SUPPORT `NDS_BMC.us0_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST0_SUPPORT `NDS_BMC.us0_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us0_aw_ready_int = 1'b1;
assign mst_slv_awvalids0 = 32'b0;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
pbmc300_ax_mst #(.MID(4'd1), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst1(.*,
	.us_axvalid	(us1_awvalid),
	.us_axready_int	(us1_awready_int),
	.us_axaddr	(us1_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids1),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M1_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST1_SUPPORT `NDS_BMC.us1_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST1_SUPPORT `NDS_BMC.us1_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us1_aw_ready_int = 1'b1;
assign mst_slv_awvalids1 = 32'b0;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
pbmc300_ax_mst #(.MID(4'd2), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst2(.*,
	.us_axvalid	(us2_awvalid),
	.us_axready_int	(us2_awready_int),
	.us_axaddr	(us2_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids2),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M2_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST2_SUPPORT `NDS_BMC.us2_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST2_SUPPORT `NDS_BMC.us2_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us2_aw_ready_int = 1'b1;
assign mst_slv_awvalids2 = 32'b0;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
pbmc300_ax_mst #(.MID(4'd3), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst3(.*,
	.us_axvalid	(us3_awvalid),
	.us_axready_int	(us3_awready_int),
	.us_axaddr	(us3_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids3),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M3_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST3_SUPPORT `NDS_BMC.us3_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST3_SUPPORT `NDS_BMC.us3_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us3_aw_ready_int = 1'b1;
assign mst_slv_awvalids3 = 32'b0;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
pbmc300_ax_mst #(.MID(4'd4), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst4(.*,
	.us_axvalid	(us4_awvalid),
	.us_axready_int	(us4_awready_int),
	.us_axaddr	(us4_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids4),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M4_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST4_SUPPORT `NDS_BMC.us4_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST4_SUPPORT `NDS_BMC.us4_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us4_aw_ready_int = 1'b1;
assign mst_slv_awvalids4 = 32'b0;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
pbmc300_ax_mst #(.MID(4'd5), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst5(.*,
	.us_axvalid	(us5_awvalid),
	.us_axready_int	(us5_awready_int),
	.us_axaddr	(us5_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids5),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M5_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST5_SUPPORT `NDS_BMC.us5_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST5_SUPPORT `NDS_BMC.us5_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us5_aw_ready_int = 1'b1;
assign mst_slv_awvalids5 = 32'b0;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
pbmc300_ax_mst #(.MID(4'd6), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst6(.*,
	.us_axvalid	(us6_awvalid),
	.us_axready_int	(us6_awready_int),
	.us_axaddr	(us6_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids6),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M6_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST6_SUPPORT `NDS_BMC.us6_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST6_SUPPORT `NDS_BMC.us6_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us6_aw_ready_int = 1'b1;
assign mst_slv_awvalids6 = 32'b0;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
pbmc300_ax_mst #(.MID(4'd7), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst7(.*,
	.us_axvalid	(us7_awvalid),
	.us_axready_int	(us7_awready_int),
	.us_axaddr	(us7_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids7),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M7_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST7_SUPPORT `NDS_BMC.us7_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST7_SUPPORT `NDS_BMC.us7_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us7_aw_ready_int = 1'b1;
assign mst_slv_awvalids7 = 32'b0;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
pbmc300_ax_mst #(.MID(4'd8), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst8(.*,
	.us_axvalid	(us8_awvalid),
	.us_axready_int	(us8_awready_int),
	.us_axaddr	(us8_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids8),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M8_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST8_SUPPORT `NDS_BMC.us8_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST8_SUPPORT `NDS_BMC.us8_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us8_aw_ready_int = 1'b1;
assign mst_slv_awvalids8 = 32'b0;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
pbmc300_ax_mst #(.MID(4'd9), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst9(.*,
	.us_axvalid	(us9_awvalid),
	.us_axready_int	(us9_awready_int),
	.us_axaddr	(us9_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids9),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M9_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST9_SUPPORT `NDS_BMC.us9_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST9_SUPPORT `NDS_BMC.us9_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us9_aw_ready_int = 1'b1;
assign mst_slv_awvalids9 = 32'b0;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
pbmc300_ax_mst #(.MID(4'd10), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst10(.*,
	.us_axvalid	(us10_awvalid),
	.us_axready_int	(us10_awready_int),
	.us_axaddr	(us10_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids10),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M10_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST10_SUPPORT `NDS_BMC.us10_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST10_SUPPORT `NDS_BMC.us10_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us10_aw_ready_int = 1'b1;
assign mst_slv_awvalids10 = 32'b0;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
pbmc300_ax_mst #(.MID(4'd11), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst11(.*,
	.us_axvalid	(us11_awvalid),
	.us_axready_int	(us11_awready_int),
	.us_axaddr	(us11_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids11),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M11_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST11_SUPPORT `NDS_BMC.us11_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST11_SUPPORT `NDS_BMC.us11_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us11_aw_ready_int = 1'b1;
assign mst_slv_awvalids11 = 32'b0;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
pbmc300_ax_mst #(.MID(4'd12), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst12(.*,
	.us_axvalid	(us12_awvalid),
	.us_axready_int	(us12_awready_int),
	.us_axaddr	(us12_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids12),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M12_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST12_SUPPORT `NDS_BMC.us12_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST12_SUPPORT `NDS_BMC.us12_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us12_aw_ready_int = 1'b1;
assign mst_slv_awvalids12 = 32'b0;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
pbmc300_ax_mst #(.MID(4'd13), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst13(.*,
	.us_axvalid	(us13_awvalid),
	.us_axready_int	(us13_awready_int),
	.us_axaddr	(us13_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids13),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M13_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST13_SUPPORT `NDS_BMC.us13_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST13_SUPPORT `NDS_BMC.us13_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us13_aw_ready_int = 1'b1;
assign mst_slv_awvalids13 = 32'b0;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
pbmc300_ax_mst #(.MID(4'd14), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst14(.*,
	.us_axvalid	(us14_awvalid),
	.us_axready_int	(us14_awready_int),
	.us_axaddr	(us14_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids14),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M14_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST14_SUPPORT `NDS_BMC.us14_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST14_SUPPORT `NDS_BMC.us14_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us14_aw_ready_int = 1'b1;
assign mst_slv_awvalids14 = 32'b0;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
pbmc300_ax_mst #(.MID(4'd15), .ADDR_WIDTH(ADDR_WIDTH)) aw_mst15(.*,
	.us_axvalid	(us15_awvalid),
	.us_axready_int	(us15_awready_int),
	.us_axaddr	(us15_awaddr),
	.mst_slv_axvalids(mst_slv_awvalids15),
	.slv_axreadys	(slv_awreadys),
	.mst_connection	(`NDS_M15_CONNS),
	.arb_mids	(aw_arb_mids),
	.data_channel_ready(`ifdef ATCBMC300_MST15_SUPPORT `NDS_BMC.us15_ctrl.us_aw_addr.data_channel_ready `else 1'b1 `endif),
	.exclusive_blocking(`ifdef ATCBMC300_MST15_SUPPORT `NDS_BMC.us15_ctrl.us_aw_addr.write_exclusive_blocking `else 1'b0 `endif)
);
`else
assign us15_aw_ready_int = 1'b1;
assign mst_slv_awvalids15 = 32'b0;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
pbmc300_ax_slv ar_slv1(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[1], mst_slv_arvalids14[1],
		mst_slv_arvalids13[1], mst_slv_arvalids12[1],
		mst_slv_arvalids11[1], mst_slv_arvalids10[1],
		mst_slv_arvalids9[1], mst_slv_arvalids8[1],
		mst_slv_arvalids7[1], mst_slv_arvalids6[1],
		mst_slv_arvalids5[1], mst_slv_arvalids4[1],
		mst_slv_arvalids3[1], mst_slv_arvalids2[1],
		mst_slv_arvalids1[1], mst_slv_arvalids0[1]}),
	.outstanding_ready(ar_outstanding_readys[1]),
	.arb_mid	(ar_arb_mids[1]),
	.slv_axready	(slv_arreadys[1]),
	.ds_axvalid_int	(ds1_arvalid_int),
	.ds_axready	(ds1_arready)
);
`else
assign ar_arb_mids[1] = 4'hf;
assign slv_arreadys[1] = 1'b1;
assign ds1_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
pbmc300_ax_slv ar_slv2(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[2], mst_slv_arvalids14[2],
		mst_slv_arvalids13[2], mst_slv_arvalids12[2],
		mst_slv_arvalids11[2], mst_slv_arvalids10[2],
		mst_slv_arvalids9[2], mst_slv_arvalids8[2],
		mst_slv_arvalids7[2], mst_slv_arvalids6[2],
		mst_slv_arvalids5[2], mst_slv_arvalids4[2],
		mst_slv_arvalids3[2], mst_slv_arvalids2[2],
		mst_slv_arvalids1[2], mst_slv_arvalids0[2]}),
	.outstanding_ready(ar_outstanding_readys[2]),
	.arb_mid	(ar_arb_mids[2]),
	.slv_axready	(slv_arreadys[2]),
	.ds_axvalid_int	(ds2_arvalid_int),
	.ds_axready	(ds2_arready)
);
`else
assign ar_arb_mids[2] = 4'hf;
assign slv_arreadys[2] = 1'b1;
assign ds2_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
pbmc300_ax_slv ar_slv3(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[3], mst_slv_arvalids14[3],
		mst_slv_arvalids13[3], mst_slv_arvalids12[3],
		mst_slv_arvalids11[3], mst_slv_arvalids10[3],
		mst_slv_arvalids9[3], mst_slv_arvalids8[3],
		mst_slv_arvalids7[3], mst_slv_arvalids6[3],
		mst_slv_arvalids5[3], mst_slv_arvalids4[3],
		mst_slv_arvalids3[3], mst_slv_arvalids2[3],
		mst_slv_arvalids1[3], mst_slv_arvalids0[3]}),
	.outstanding_ready(ar_outstanding_readys[3]),
	.arb_mid	(ar_arb_mids[3]),
	.slv_axready	(slv_arreadys[3]),
	.ds_axvalid_int	(ds3_arvalid_int),
	.ds_axready	(ds3_arready)
);
`else
assign ar_arb_mids[3] = 4'hf;
assign slv_arreadys[3] = 1'b1;
assign ds3_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
pbmc300_ax_slv ar_slv4(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[4], mst_slv_arvalids14[4],
		mst_slv_arvalids13[4], mst_slv_arvalids12[4],
		mst_slv_arvalids11[4], mst_slv_arvalids10[4],
		mst_slv_arvalids9[4], mst_slv_arvalids8[4],
		mst_slv_arvalids7[4], mst_slv_arvalids6[4],
		mst_slv_arvalids5[4], mst_slv_arvalids4[4],
		mst_slv_arvalids3[4], mst_slv_arvalids2[4],
		mst_slv_arvalids1[4], mst_slv_arvalids0[4]}),
	.outstanding_ready(ar_outstanding_readys[4]),
	.arb_mid	(ar_arb_mids[4]),
	.slv_axready	(slv_arreadys[4]),
	.ds_axvalid_int	(ds4_arvalid_int),
	.ds_axready	(ds4_arready)
);
`else
assign ar_arb_mids[4] = 4'hf;
assign slv_arreadys[4] = 1'b1;
assign ds4_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
pbmc300_ax_slv ar_slv5(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[5], mst_slv_arvalids14[5],
		mst_slv_arvalids13[5], mst_slv_arvalids12[5],
		mst_slv_arvalids11[5], mst_slv_arvalids10[5],
		mst_slv_arvalids9[5], mst_slv_arvalids8[5],
		mst_slv_arvalids7[5], mst_slv_arvalids6[5],
		mst_slv_arvalids5[5], mst_slv_arvalids4[5],
		mst_slv_arvalids3[5], mst_slv_arvalids2[5],
		mst_slv_arvalids1[5], mst_slv_arvalids0[5]}),
	.outstanding_ready(ar_outstanding_readys[5]),
	.arb_mid	(ar_arb_mids[5]),
	.slv_axready	(slv_arreadys[5]),
	.ds_axvalid_int	(ds5_arvalid_int),
	.ds_axready	(ds5_arready)
);
`else
assign ar_arb_mids[5] = 4'hf;
assign slv_arreadys[5] = 1'b1;
assign ds5_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
pbmc300_ax_slv ar_slv6(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[6], mst_slv_arvalids14[6],
		mst_slv_arvalids13[6], mst_slv_arvalids12[6],
		mst_slv_arvalids11[6], mst_slv_arvalids10[6],
		mst_slv_arvalids9[6], mst_slv_arvalids8[6],
		mst_slv_arvalids7[6], mst_slv_arvalids6[6],
		mst_slv_arvalids5[6], mst_slv_arvalids4[6],
		mst_slv_arvalids3[6], mst_slv_arvalids2[6],
		mst_slv_arvalids1[6], mst_slv_arvalids0[6]}),
	.outstanding_ready(ar_outstanding_readys[6]),
	.arb_mid	(ar_arb_mids[6]),
	.slv_axready	(slv_arreadys[6]),
	.ds_axvalid_int	(ds6_arvalid_int),
	.ds_axready	(ds6_arready)
);
`else
assign ar_arb_mids[6] = 4'hf;
assign slv_arreadys[6] = 1'b1;
assign ds6_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
pbmc300_ax_slv ar_slv7(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[7], mst_slv_arvalids14[7],
		mst_slv_arvalids13[7], mst_slv_arvalids12[7],
		mst_slv_arvalids11[7], mst_slv_arvalids10[7],
		mst_slv_arvalids9[7], mst_slv_arvalids8[7],
		mst_slv_arvalids7[7], mst_slv_arvalids6[7],
		mst_slv_arvalids5[7], mst_slv_arvalids4[7],
		mst_slv_arvalids3[7], mst_slv_arvalids2[7],
		mst_slv_arvalids1[7], mst_slv_arvalids0[7]}),
	.outstanding_ready(ar_outstanding_readys[7]),
	.arb_mid	(ar_arb_mids[7]),
	.slv_axready	(slv_arreadys[7]),
	.ds_axvalid_int	(ds7_arvalid_int),
	.ds_axready	(ds7_arready)
);
`else
assign ar_arb_mids[7] = 4'hf;
assign slv_arreadys[7] = 1'b1;
assign ds7_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
pbmc300_ax_slv ar_slv8(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[8], mst_slv_arvalids14[8],
		mst_slv_arvalids13[8], mst_slv_arvalids12[8],
		mst_slv_arvalids11[8], mst_slv_arvalids10[8],
		mst_slv_arvalids9[8], mst_slv_arvalids8[8],
		mst_slv_arvalids7[8], mst_slv_arvalids6[8],
		mst_slv_arvalids5[8], mst_slv_arvalids4[8],
		mst_slv_arvalids3[8], mst_slv_arvalids2[8],
		mst_slv_arvalids1[8], mst_slv_arvalids0[8]}),
	.outstanding_ready(ar_outstanding_readys[8]),
	.arb_mid	(ar_arb_mids[8]),
	.slv_axready	(slv_arreadys[8]),
	.ds_axvalid_int	(ds8_arvalid_int),
	.ds_axready	(ds8_arready)
);
`else
assign ar_arb_mids[8] = 4'hf;
assign slv_arreadys[8] = 1'b1;
assign ds8_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
pbmc300_ax_slv ar_slv9(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[9], mst_slv_arvalids14[9],
		mst_slv_arvalids13[9], mst_slv_arvalids12[9],
		mst_slv_arvalids11[9], mst_slv_arvalids10[9],
		mst_slv_arvalids9[9], mst_slv_arvalids8[9],
		mst_slv_arvalids7[9], mst_slv_arvalids6[9],
		mst_slv_arvalids5[9], mst_slv_arvalids4[9],
		mst_slv_arvalids3[9], mst_slv_arvalids2[9],
		mst_slv_arvalids1[9], mst_slv_arvalids0[9]}),
	.outstanding_ready(ar_outstanding_readys[9]),
	.arb_mid	(ar_arb_mids[9]),
	.slv_axready	(slv_arreadys[9]),
	.ds_axvalid_int	(ds9_arvalid_int),
	.ds_axready	(ds9_arready)
);
`else
assign ar_arb_mids[9] = 4'hf;
assign slv_arreadys[9] = 1'b1;
assign ds9_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
pbmc300_ax_slv ar_slv10(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[10], mst_slv_arvalids14[10],
		mst_slv_arvalids13[10], mst_slv_arvalids12[10],
		mst_slv_arvalids11[10], mst_slv_arvalids10[10],
		mst_slv_arvalids9[10], mst_slv_arvalids8[10],
		mst_slv_arvalids7[10], mst_slv_arvalids6[10],
		mst_slv_arvalids5[10], mst_slv_arvalids4[10],
		mst_slv_arvalids3[10], mst_slv_arvalids2[10],
		mst_slv_arvalids1[10], mst_slv_arvalids0[10]}),
	.outstanding_ready(ar_outstanding_readys[10]),
	.arb_mid	(ar_arb_mids[10]),
	.slv_axready	(slv_arreadys[10]),
	.ds_axvalid_int	(ds10_arvalid_int),
	.ds_axready	(ds10_arready)
);
`else
assign ar_arb_mids[10] = 4'hf;
assign slv_arreadys[10] = 1'b1;
assign ds10_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
pbmc300_ax_slv ar_slv11(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[11], mst_slv_arvalids14[11],
		mst_slv_arvalids13[11], mst_slv_arvalids12[11],
		mst_slv_arvalids11[11], mst_slv_arvalids10[11],
		mst_slv_arvalids9[11], mst_slv_arvalids8[11],
		mst_slv_arvalids7[11], mst_slv_arvalids6[11],
		mst_slv_arvalids5[11], mst_slv_arvalids4[11],
		mst_slv_arvalids3[11], mst_slv_arvalids2[11],
		mst_slv_arvalids1[11], mst_slv_arvalids0[11]}),
	.outstanding_ready(ar_outstanding_readys[11]),
	.arb_mid	(ar_arb_mids[11]),
	.slv_axready	(slv_arreadys[11]),
	.ds_axvalid_int	(ds11_arvalid_int),
	.ds_axready	(ds11_arready)
);
`else
assign ar_arb_mids[11] = 4'hf;
assign slv_arreadys[11] = 1'b1;
assign ds11_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
pbmc300_ax_slv ar_slv12(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[12], mst_slv_arvalids14[12],
		mst_slv_arvalids13[12], mst_slv_arvalids12[12],
		mst_slv_arvalids11[12], mst_slv_arvalids10[12],
		mst_slv_arvalids9[12], mst_slv_arvalids8[12],
		mst_slv_arvalids7[12], mst_slv_arvalids6[12],
		mst_slv_arvalids5[12], mst_slv_arvalids4[12],
		mst_slv_arvalids3[12], mst_slv_arvalids2[12],
		mst_slv_arvalids1[12], mst_slv_arvalids0[12]}),
	.outstanding_ready(ar_outstanding_readys[12]),
	.arb_mid	(ar_arb_mids[12]),
	.slv_axready	(slv_arreadys[12]),
	.ds_axvalid_int	(ds12_arvalid_int),
	.ds_axready	(ds12_arready)
);
`else
assign ar_arb_mids[12] = 4'hf;
assign slv_arreadys[12] = 1'b1;
assign ds12_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
pbmc300_ax_slv ar_slv13(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[13], mst_slv_arvalids14[13],
		mst_slv_arvalids13[13], mst_slv_arvalids12[13],
		mst_slv_arvalids11[13], mst_slv_arvalids10[13],
		mst_slv_arvalids9[13], mst_slv_arvalids8[13],
		mst_slv_arvalids7[13], mst_slv_arvalids6[13],
		mst_slv_arvalids5[13], mst_slv_arvalids4[13],
		mst_slv_arvalids3[13], mst_slv_arvalids2[13],
		mst_slv_arvalids1[13], mst_slv_arvalids0[13]}),
	.outstanding_ready(ar_outstanding_readys[13]),
	.arb_mid	(ar_arb_mids[13]),
	.slv_axready	(slv_arreadys[13]),
	.ds_axvalid_int	(ds13_arvalid_int),
	.ds_axready	(ds13_arready)
);
`else
assign ar_arb_mids[13] = 4'hf;
assign slv_arreadys[13] = 1'b1;
assign ds13_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
pbmc300_ax_slv ar_slv14(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[14], mst_slv_arvalids14[14],
		mst_slv_arvalids13[14], mst_slv_arvalids12[14],
		mst_slv_arvalids11[14], mst_slv_arvalids10[14],
		mst_slv_arvalids9[14], mst_slv_arvalids8[14],
		mst_slv_arvalids7[14], mst_slv_arvalids6[14],
		mst_slv_arvalids5[14], mst_slv_arvalids4[14],
		mst_slv_arvalids3[14], mst_slv_arvalids2[14],
		mst_slv_arvalids1[14], mst_slv_arvalids0[14]}),
	.outstanding_ready(ar_outstanding_readys[14]),
	.arb_mid	(ar_arb_mids[14]),
	.slv_axready	(slv_arreadys[14]),
	.ds_axvalid_int	(ds14_arvalid_int),
	.ds_axready	(ds14_arready)
);
`else
assign ar_arb_mids[14] = 4'hf;
assign slv_arreadys[14] = 1'b1;
assign ds14_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
pbmc300_ax_slv ar_slv15(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[15], mst_slv_arvalids14[15],
		mst_slv_arvalids13[15], mst_slv_arvalids12[15],
		mst_slv_arvalids11[15], mst_slv_arvalids10[15],
		mst_slv_arvalids9[15], mst_slv_arvalids8[15],
		mst_slv_arvalids7[15], mst_slv_arvalids6[15],
		mst_slv_arvalids5[15], mst_slv_arvalids4[15],
		mst_slv_arvalids3[15], mst_slv_arvalids2[15],
		mst_slv_arvalids1[15], mst_slv_arvalids0[15]}),
	.outstanding_ready(ar_outstanding_readys[15]),
	.arb_mid	(ar_arb_mids[15]),
	.slv_axready	(slv_arreadys[15]),
	.ds_axvalid_int	(ds15_arvalid_int),
	.ds_axready	(ds15_arready)
);
`else
assign ar_arb_mids[15] = 4'hf;
assign slv_arreadys[15] = 1'b1;
assign ds15_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
pbmc300_ax_slv ar_slv16(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[16], mst_slv_arvalids14[16],
		mst_slv_arvalids13[16], mst_slv_arvalids12[16],
		mst_slv_arvalids11[16], mst_slv_arvalids10[16],
		mst_slv_arvalids9[16], mst_slv_arvalids8[16],
		mst_slv_arvalids7[16], mst_slv_arvalids6[16],
		mst_slv_arvalids5[16], mst_slv_arvalids4[16],
		mst_slv_arvalids3[16], mst_slv_arvalids2[16],
		mst_slv_arvalids1[16], mst_slv_arvalids0[16]}),
	.outstanding_ready(ar_outstanding_readys[16]),
	.arb_mid	(ar_arb_mids[16]),
	.slv_axready	(slv_arreadys[16]),
	.ds_axvalid_int	(ds16_arvalid_int),
	.ds_axready	(ds16_arready)
);
`else
assign ar_arb_mids[16] = 4'hf;
assign slv_arreadys[16] = 1'b1;
assign ds16_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
pbmc300_ax_slv ar_slv17(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[17], mst_slv_arvalids14[17],
		mst_slv_arvalids13[17], mst_slv_arvalids12[17],
		mst_slv_arvalids11[17], mst_slv_arvalids10[17],
		mst_slv_arvalids9[17], mst_slv_arvalids8[17],
		mst_slv_arvalids7[17], mst_slv_arvalids6[17],
		mst_slv_arvalids5[17], mst_slv_arvalids4[17],
		mst_slv_arvalids3[17], mst_slv_arvalids2[17],
		mst_slv_arvalids1[17], mst_slv_arvalids0[17]}),
	.outstanding_ready(ar_outstanding_readys[17]),
	.arb_mid	(ar_arb_mids[17]),
	.slv_axready	(slv_arreadys[17]),
	.ds_axvalid_int	(ds17_arvalid_int),
	.ds_axready	(ds17_arready)
);
`else
assign ar_arb_mids[17] = 4'hf;
assign slv_arreadys[17] = 1'b1;
assign ds17_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
pbmc300_ax_slv ar_slv18(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[18], mst_slv_arvalids14[18],
		mst_slv_arvalids13[18], mst_slv_arvalids12[18],
		mst_slv_arvalids11[18], mst_slv_arvalids10[18],
		mst_slv_arvalids9[18], mst_slv_arvalids8[18],
		mst_slv_arvalids7[18], mst_slv_arvalids6[18],
		mst_slv_arvalids5[18], mst_slv_arvalids4[18],
		mst_slv_arvalids3[18], mst_slv_arvalids2[18],
		mst_slv_arvalids1[18], mst_slv_arvalids0[18]}),
	.outstanding_ready(ar_outstanding_readys[18]),
	.arb_mid	(ar_arb_mids[18]),
	.slv_axready	(slv_arreadys[18]),
	.ds_axvalid_int	(ds18_arvalid_int),
	.ds_axready	(ds18_arready)
);
`else
assign ar_arb_mids[18] = 4'hf;
assign slv_arreadys[18] = 1'b1;
assign ds18_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
pbmc300_ax_slv ar_slv19(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[19], mst_slv_arvalids14[19],
		mst_slv_arvalids13[19], mst_slv_arvalids12[19],
		mst_slv_arvalids11[19], mst_slv_arvalids10[19],
		mst_slv_arvalids9[19], mst_slv_arvalids8[19],
		mst_slv_arvalids7[19], mst_slv_arvalids6[19],
		mst_slv_arvalids5[19], mst_slv_arvalids4[19],
		mst_slv_arvalids3[19], mst_slv_arvalids2[19],
		mst_slv_arvalids1[19], mst_slv_arvalids0[19]}),
	.outstanding_ready(ar_outstanding_readys[19]),
	.arb_mid	(ar_arb_mids[19]),
	.slv_axready	(slv_arreadys[19]),
	.ds_axvalid_int	(ds19_arvalid_int),
	.ds_axready	(ds19_arready)
);
`else
assign ar_arb_mids[19] = 4'hf;
assign slv_arreadys[19] = 1'b1;
assign ds19_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
pbmc300_ax_slv ar_slv20(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[20], mst_slv_arvalids14[20],
		mst_slv_arvalids13[20], mst_slv_arvalids12[20],
		mst_slv_arvalids11[20], mst_slv_arvalids10[20],
		mst_slv_arvalids9[20], mst_slv_arvalids8[20],
		mst_slv_arvalids7[20], mst_slv_arvalids6[20],
		mst_slv_arvalids5[20], mst_slv_arvalids4[20],
		mst_slv_arvalids3[20], mst_slv_arvalids2[20],
		mst_slv_arvalids1[20], mst_slv_arvalids0[20]}),
	.outstanding_ready(ar_outstanding_readys[20]),
	.arb_mid	(ar_arb_mids[20]),
	.slv_axready	(slv_arreadys[20]),
	.ds_axvalid_int	(ds20_arvalid_int),
	.ds_axready	(ds20_arready)
);
`else
assign ar_arb_mids[20] = 4'hf;
assign slv_arreadys[20] = 1'b1;
assign ds20_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
pbmc300_ax_slv ar_slv21(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[21], mst_slv_arvalids14[21],
		mst_slv_arvalids13[21], mst_slv_arvalids12[21],
		mst_slv_arvalids11[21], mst_slv_arvalids10[21],
		mst_slv_arvalids9[21], mst_slv_arvalids8[21],
		mst_slv_arvalids7[21], mst_slv_arvalids6[21],
		mst_slv_arvalids5[21], mst_slv_arvalids4[21],
		mst_slv_arvalids3[21], mst_slv_arvalids2[21],
		mst_slv_arvalids1[21], mst_slv_arvalids0[21]}),
	.outstanding_ready(ar_outstanding_readys[21]),
	.arb_mid	(ar_arb_mids[21]),
	.slv_axready	(slv_arreadys[21]),
	.ds_axvalid_int	(ds21_arvalid_int),
	.ds_axready	(ds21_arready)
);
`else
assign ar_arb_mids[21] = 4'hf;
assign slv_arreadys[21] = 1'b1;
assign ds21_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
pbmc300_ax_slv ar_slv22(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[22], mst_slv_arvalids14[22],
		mst_slv_arvalids13[22], mst_slv_arvalids12[22],
		mst_slv_arvalids11[22], mst_slv_arvalids10[22],
		mst_slv_arvalids9[22], mst_slv_arvalids8[22],
		mst_slv_arvalids7[22], mst_slv_arvalids6[22],
		mst_slv_arvalids5[22], mst_slv_arvalids4[22],
		mst_slv_arvalids3[22], mst_slv_arvalids2[22],
		mst_slv_arvalids1[22], mst_slv_arvalids0[22]}),
	.outstanding_ready(ar_outstanding_readys[22]),
	.arb_mid	(ar_arb_mids[22]),
	.slv_axready	(slv_arreadys[22]),
	.ds_axvalid_int	(ds22_arvalid_int),
	.ds_axready	(ds22_arready)
);
`else
assign ar_arb_mids[22] = 4'hf;
assign slv_arreadys[22] = 1'b1;
assign ds22_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
pbmc300_ax_slv ar_slv23(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[23], mst_slv_arvalids14[23],
		mst_slv_arvalids13[23], mst_slv_arvalids12[23],
		mst_slv_arvalids11[23], mst_slv_arvalids10[23],
		mst_slv_arvalids9[23], mst_slv_arvalids8[23],
		mst_slv_arvalids7[23], mst_slv_arvalids6[23],
		mst_slv_arvalids5[23], mst_slv_arvalids4[23],
		mst_slv_arvalids3[23], mst_slv_arvalids2[23],
		mst_slv_arvalids1[23], mst_slv_arvalids0[23]}),
	.outstanding_ready(ar_outstanding_readys[23]),
	.arb_mid	(ar_arb_mids[23]),
	.slv_axready	(slv_arreadys[23]),
	.ds_axvalid_int	(ds23_arvalid_int),
	.ds_axready	(ds23_arready)
);
`else
assign ar_arb_mids[23] = 4'hf;
assign slv_arreadys[23] = 1'b1;
assign ds23_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
pbmc300_ax_slv ar_slv24(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[24], mst_slv_arvalids14[24],
		mst_slv_arvalids13[24], mst_slv_arvalids12[24],
		mst_slv_arvalids11[24], mst_slv_arvalids10[24],
		mst_slv_arvalids9[24], mst_slv_arvalids8[24],
		mst_slv_arvalids7[24], mst_slv_arvalids6[24],
		mst_slv_arvalids5[24], mst_slv_arvalids4[24],
		mst_slv_arvalids3[24], mst_slv_arvalids2[24],
		mst_slv_arvalids1[24], mst_slv_arvalids0[24]}),
	.outstanding_ready(ar_outstanding_readys[24]),
	.arb_mid	(ar_arb_mids[24]),
	.slv_axready	(slv_arreadys[24]),
	.ds_axvalid_int	(ds24_arvalid_int),
	.ds_axready	(ds24_arready)
);
`else
assign ar_arb_mids[24] = 4'hf;
assign slv_arreadys[24] = 1'b1;
assign ds24_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
pbmc300_ax_slv ar_slv25(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[25], mst_slv_arvalids14[25],
		mst_slv_arvalids13[25], mst_slv_arvalids12[25],
		mst_slv_arvalids11[25], mst_slv_arvalids10[25],
		mst_slv_arvalids9[25], mst_slv_arvalids8[25],
		mst_slv_arvalids7[25], mst_slv_arvalids6[25],
		mst_slv_arvalids5[25], mst_slv_arvalids4[25],
		mst_slv_arvalids3[25], mst_slv_arvalids2[25],
		mst_slv_arvalids1[25], mst_slv_arvalids0[25]}),
	.outstanding_ready(ar_outstanding_readys[25]),
	.arb_mid	(ar_arb_mids[25]),
	.slv_axready	(slv_arreadys[25]),
	.ds_axvalid_int	(ds25_arvalid_int),
	.ds_axready	(ds25_arready)
);
`else
assign ar_arb_mids[25] = 4'hf;
assign slv_arreadys[25] = 1'b1;
assign ds25_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
pbmc300_ax_slv ar_slv26(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[26], mst_slv_arvalids14[26],
		mst_slv_arvalids13[26], mst_slv_arvalids12[26],
		mst_slv_arvalids11[26], mst_slv_arvalids10[26],
		mst_slv_arvalids9[26], mst_slv_arvalids8[26],
		mst_slv_arvalids7[26], mst_slv_arvalids6[26],
		mst_slv_arvalids5[26], mst_slv_arvalids4[26],
		mst_slv_arvalids3[26], mst_slv_arvalids2[26],
		mst_slv_arvalids1[26], mst_slv_arvalids0[26]}),
	.outstanding_ready(ar_outstanding_readys[26]),
	.arb_mid	(ar_arb_mids[26]),
	.slv_axready	(slv_arreadys[26]),
	.ds_axvalid_int	(ds26_arvalid_int),
	.ds_axready	(ds26_arready)
);
`else
assign ar_arb_mids[26] = 4'hf;
assign slv_arreadys[26] = 1'b1;
assign ds26_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
pbmc300_ax_slv ar_slv27(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[27], mst_slv_arvalids14[27],
		mst_slv_arvalids13[27], mst_slv_arvalids12[27],
		mst_slv_arvalids11[27], mst_slv_arvalids10[27],
		mst_slv_arvalids9[27], mst_slv_arvalids8[27],
		mst_slv_arvalids7[27], mst_slv_arvalids6[27],
		mst_slv_arvalids5[27], mst_slv_arvalids4[27],
		mst_slv_arvalids3[27], mst_slv_arvalids2[27],
		mst_slv_arvalids1[27], mst_slv_arvalids0[27]}),
	.outstanding_ready(ar_outstanding_readys[27]),
	.arb_mid	(ar_arb_mids[27]),
	.slv_axready	(slv_arreadys[27]),
	.ds_axvalid_int	(ds27_arvalid_int),
	.ds_axready	(ds27_arready)
);
`else
assign ar_arb_mids[27] = 4'hf;
assign slv_arreadys[27] = 1'b1;
assign ds27_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
pbmc300_ax_slv ar_slv28(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[28], mst_slv_arvalids14[28],
		mst_slv_arvalids13[28], mst_slv_arvalids12[28],
		mst_slv_arvalids11[28], mst_slv_arvalids10[28],
		mst_slv_arvalids9[28], mst_slv_arvalids8[28],
		mst_slv_arvalids7[28], mst_slv_arvalids6[28],
		mst_slv_arvalids5[28], mst_slv_arvalids4[28],
		mst_slv_arvalids3[28], mst_slv_arvalids2[28],
		mst_slv_arvalids1[28], mst_slv_arvalids0[28]}),
	.outstanding_ready(ar_outstanding_readys[28]),
	.arb_mid	(ar_arb_mids[28]),
	.slv_axready	(slv_arreadys[28]),
	.ds_axvalid_int	(ds28_arvalid_int),
	.ds_axready	(ds28_arready)
);
`else
assign ar_arb_mids[28] = 4'hf;
assign slv_arreadys[28] = 1'b1;
assign ds28_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
pbmc300_ax_slv ar_slv29(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[29], mst_slv_arvalids14[29],
		mst_slv_arvalids13[29], mst_slv_arvalids12[29],
		mst_slv_arvalids11[29], mst_slv_arvalids10[29],
		mst_slv_arvalids9[29], mst_slv_arvalids8[29],
		mst_slv_arvalids7[29], mst_slv_arvalids6[29],
		mst_slv_arvalids5[29], mst_slv_arvalids4[29],
		mst_slv_arvalids3[29], mst_slv_arvalids2[29],
		mst_slv_arvalids1[29], mst_slv_arvalids0[29]}),
	.outstanding_ready(ar_outstanding_readys[29]),
	.arb_mid	(ar_arb_mids[29]),
	.slv_axready	(slv_arreadys[29]),
	.ds_axvalid_int	(ds29_arvalid_int),
	.ds_axready	(ds29_arready)
);
`else
assign ar_arb_mids[29] = 4'hf;
assign slv_arreadys[29] = 1'b1;
assign ds29_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
pbmc300_ax_slv ar_slv30(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[30], mst_slv_arvalids14[30],
		mst_slv_arvalids13[30], mst_slv_arvalids12[30],
		mst_slv_arvalids11[30], mst_slv_arvalids10[30],
		mst_slv_arvalids9[30], mst_slv_arvalids8[30],
		mst_slv_arvalids7[30], mst_slv_arvalids6[30],
		mst_slv_arvalids5[30], mst_slv_arvalids4[30],
		mst_slv_arvalids3[30], mst_slv_arvalids2[30],
		mst_slv_arvalids1[30], mst_slv_arvalids0[30]}),
	.outstanding_ready(ar_outstanding_readys[30]),
	.arb_mid	(ar_arb_mids[30]),
	.slv_axready	(slv_arreadys[30]),
	.ds_axvalid_int	(ds30_arvalid_int),
	.ds_axready	(ds30_arready)
);
`else
assign ar_arb_mids[30] = 4'hf;
assign slv_arreadys[30] = 1'b1;
assign ds30_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
pbmc300_ax_slv ar_slv31(.*,
	.mst_axvalids	({
		mst_slv_arvalids15[31], mst_slv_arvalids14[31],
		mst_slv_arvalids13[31], mst_slv_arvalids12[31],
		mst_slv_arvalids11[31], mst_slv_arvalids10[31],
		mst_slv_arvalids9[31], mst_slv_arvalids8[31],
		mst_slv_arvalids7[31], mst_slv_arvalids6[31],
		mst_slv_arvalids5[31], mst_slv_arvalids4[31],
		mst_slv_arvalids3[31], mst_slv_arvalids2[31],
		mst_slv_arvalids1[31], mst_slv_arvalids0[31]}),
	.outstanding_ready(ar_outstanding_readys[31]),
	.arb_mid	(ar_arb_mids[31]),
	.slv_axready	(slv_arreadys[31]),
	.ds_axvalid_int	(ds31_arvalid_int),
	.ds_axready	(ds31_arready)
);
`else
assign ar_arb_mids[31] = 4'hf;
assign slv_arreadys[31] = 1'b1;
assign ds31_arvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
pbmc300_ax_slv aw_slv1(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[1], mst_slv_awvalids14[1],
		mst_slv_awvalids13[1], mst_slv_awvalids12[1],
		mst_slv_awvalids11[1], mst_slv_awvalids10[1],
		mst_slv_awvalids9[1], mst_slv_awvalids8[1],
		mst_slv_awvalids7[1], mst_slv_awvalids6[1],
		mst_slv_awvalids5[1], mst_slv_awvalids4[1],
		mst_slv_awvalids3[1], mst_slv_awvalids2[1],
		mst_slv_awvalids1[1], mst_slv_awvalids0[1]}),
	.outstanding_ready(aw_outstanding_readys[1]),
	.arb_mid	(aw_arb_mids[1]),
	.slv_axready	(slv_awreadys[1]),
	.ds_axvalid_int	(ds1_awvalid_int),
	.ds_axready	(ds1_awready)
);
`else
assign aw_arb_mids[1] = 4'hf;
assign slv_awreadys[1] = 1'b1;
assign ds1_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
pbmc300_ax_slv aw_slv2(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[2], mst_slv_awvalids14[2],
		mst_slv_awvalids13[2], mst_slv_awvalids12[2],
		mst_slv_awvalids11[2], mst_slv_awvalids10[2],
		mst_slv_awvalids9[2], mst_slv_awvalids8[2],
		mst_slv_awvalids7[2], mst_slv_awvalids6[2],
		mst_slv_awvalids5[2], mst_slv_awvalids4[2],
		mst_slv_awvalids3[2], mst_slv_awvalids2[2],
		mst_slv_awvalids1[2], mst_slv_awvalids0[2]}),
	.outstanding_ready(aw_outstanding_readys[2]),
	.arb_mid	(aw_arb_mids[2]),
	.slv_axready	(slv_awreadys[2]),
	.ds_axvalid_int	(ds2_awvalid_int),
	.ds_axready	(ds2_awready)
);
`else
assign aw_arb_mids[2] = 4'hf;
assign slv_awreadys[2] = 1'b1;
assign ds2_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
pbmc300_ax_slv aw_slv3(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[3], mst_slv_awvalids14[3],
		mst_slv_awvalids13[3], mst_slv_awvalids12[3],
		mst_slv_awvalids11[3], mst_slv_awvalids10[3],
		mst_slv_awvalids9[3], mst_slv_awvalids8[3],
		mst_slv_awvalids7[3], mst_slv_awvalids6[3],
		mst_slv_awvalids5[3], mst_slv_awvalids4[3],
		mst_slv_awvalids3[3], mst_slv_awvalids2[3],
		mst_slv_awvalids1[3], mst_slv_awvalids0[3]}),
	.outstanding_ready(aw_outstanding_readys[3]),
	.arb_mid	(aw_arb_mids[3]),
	.slv_axready	(slv_awreadys[3]),
	.ds_axvalid_int	(ds3_awvalid_int),
	.ds_axready	(ds3_awready)
);
`else
assign aw_arb_mids[3] = 4'hf;
assign slv_awreadys[3] = 1'b1;
assign ds3_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
pbmc300_ax_slv aw_slv4(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[4], mst_slv_awvalids14[4],
		mst_slv_awvalids13[4], mst_slv_awvalids12[4],
		mst_slv_awvalids11[4], mst_slv_awvalids10[4],
		mst_slv_awvalids9[4], mst_slv_awvalids8[4],
		mst_slv_awvalids7[4], mst_slv_awvalids6[4],
		mst_slv_awvalids5[4], mst_slv_awvalids4[4],
		mst_slv_awvalids3[4], mst_slv_awvalids2[4],
		mst_slv_awvalids1[4], mst_slv_awvalids0[4]}),
	.outstanding_ready(aw_outstanding_readys[4]),
	.arb_mid	(aw_arb_mids[4]),
	.slv_axready	(slv_awreadys[4]),
	.ds_axvalid_int	(ds4_awvalid_int),
	.ds_axready	(ds4_awready)
);
`else
assign aw_arb_mids[4] = 4'hf;
assign slv_awreadys[4] = 1'b1;
assign ds4_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
pbmc300_ax_slv aw_slv5(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[5], mst_slv_awvalids14[5],
		mst_slv_awvalids13[5], mst_slv_awvalids12[5],
		mst_slv_awvalids11[5], mst_slv_awvalids10[5],
		mst_slv_awvalids9[5], mst_slv_awvalids8[5],
		mst_slv_awvalids7[5], mst_slv_awvalids6[5],
		mst_slv_awvalids5[5], mst_slv_awvalids4[5],
		mst_slv_awvalids3[5], mst_slv_awvalids2[5],
		mst_slv_awvalids1[5], mst_slv_awvalids0[5]}),
	.outstanding_ready(aw_outstanding_readys[5]),
	.arb_mid	(aw_arb_mids[5]),
	.slv_axready	(slv_awreadys[5]),
	.ds_axvalid_int	(ds5_awvalid_int),
	.ds_axready	(ds5_awready)
);
`else
assign aw_arb_mids[5] = 4'hf;
assign slv_awreadys[5] = 1'b1;
assign ds5_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
pbmc300_ax_slv aw_slv6(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[6], mst_slv_awvalids14[6],
		mst_slv_awvalids13[6], mst_slv_awvalids12[6],
		mst_slv_awvalids11[6], mst_slv_awvalids10[6],
		mst_slv_awvalids9[6], mst_slv_awvalids8[6],
		mst_slv_awvalids7[6], mst_slv_awvalids6[6],
		mst_slv_awvalids5[6], mst_slv_awvalids4[6],
		mst_slv_awvalids3[6], mst_slv_awvalids2[6],
		mst_slv_awvalids1[6], mst_slv_awvalids0[6]}),
	.outstanding_ready(aw_outstanding_readys[6]),
	.arb_mid	(aw_arb_mids[6]),
	.slv_axready	(slv_awreadys[6]),
	.ds_axvalid_int	(ds6_awvalid_int),
	.ds_axready	(ds6_awready)
);
`else
assign aw_arb_mids[6] = 4'hf;
assign slv_awreadys[6] = 1'b1;
assign ds6_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
pbmc300_ax_slv aw_slv7(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[7], mst_slv_awvalids14[7],
		mst_slv_awvalids13[7], mst_slv_awvalids12[7],
		mst_slv_awvalids11[7], mst_slv_awvalids10[7],
		mst_slv_awvalids9[7], mst_slv_awvalids8[7],
		mst_slv_awvalids7[7], mst_slv_awvalids6[7],
		mst_slv_awvalids5[7], mst_slv_awvalids4[7],
		mst_slv_awvalids3[7], mst_slv_awvalids2[7],
		mst_slv_awvalids1[7], mst_slv_awvalids0[7]}),
	.outstanding_ready(aw_outstanding_readys[7]),
	.arb_mid	(aw_arb_mids[7]),
	.slv_axready	(slv_awreadys[7]),
	.ds_axvalid_int	(ds7_awvalid_int),
	.ds_axready	(ds7_awready)
);
`else
assign aw_arb_mids[7] = 4'hf;
assign slv_awreadys[7] = 1'b1;
assign ds7_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
pbmc300_ax_slv aw_slv8(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[8], mst_slv_awvalids14[8],
		mst_slv_awvalids13[8], mst_slv_awvalids12[8],
		mst_slv_awvalids11[8], mst_slv_awvalids10[8],
		mst_slv_awvalids9[8], mst_slv_awvalids8[8],
		mst_slv_awvalids7[8], mst_slv_awvalids6[8],
		mst_slv_awvalids5[8], mst_slv_awvalids4[8],
		mst_slv_awvalids3[8], mst_slv_awvalids2[8],
		mst_slv_awvalids1[8], mst_slv_awvalids0[8]}),
	.outstanding_ready(aw_outstanding_readys[8]),
	.arb_mid	(aw_arb_mids[8]),
	.slv_axready	(slv_awreadys[8]),
	.ds_axvalid_int	(ds8_awvalid_int),
	.ds_axready	(ds8_awready)
);
`else
assign aw_arb_mids[8] = 4'hf;
assign slv_awreadys[8] = 1'b1;
assign ds8_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
pbmc300_ax_slv aw_slv9(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[9], mst_slv_awvalids14[9],
		mst_slv_awvalids13[9], mst_slv_awvalids12[9],
		mst_slv_awvalids11[9], mst_slv_awvalids10[9],
		mst_slv_awvalids9[9], mst_slv_awvalids8[9],
		mst_slv_awvalids7[9], mst_slv_awvalids6[9],
		mst_slv_awvalids5[9], mst_slv_awvalids4[9],
		mst_slv_awvalids3[9], mst_slv_awvalids2[9],
		mst_slv_awvalids1[9], mst_slv_awvalids0[9]}),
	.outstanding_ready(aw_outstanding_readys[9]),
	.arb_mid	(aw_arb_mids[9]),
	.slv_axready	(slv_awreadys[9]),
	.ds_axvalid_int	(ds9_awvalid_int),
	.ds_axready	(ds9_awready)
);
`else
assign aw_arb_mids[9] = 4'hf;
assign slv_awreadys[9] = 1'b1;
assign ds9_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
pbmc300_ax_slv aw_slv10(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[10], mst_slv_awvalids14[10],
		mst_slv_awvalids13[10], mst_slv_awvalids12[10],
		mst_slv_awvalids11[10], mst_slv_awvalids10[10],
		mst_slv_awvalids9[10], mst_slv_awvalids8[10],
		mst_slv_awvalids7[10], mst_slv_awvalids6[10],
		mst_slv_awvalids5[10], mst_slv_awvalids4[10],
		mst_slv_awvalids3[10], mst_slv_awvalids2[10],
		mst_slv_awvalids1[10], mst_slv_awvalids0[10]}),
	.outstanding_ready(aw_outstanding_readys[10]),
	.arb_mid	(aw_arb_mids[10]),
	.slv_axready	(slv_awreadys[10]),
	.ds_axvalid_int	(ds10_awvalid_int),
	.ds_axready	(ds10_awready)
);
`else
assign aw_arb_mids[10] = 4'hf;
assign slv_awreadys[10] = 1'b1;
assign ds10_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
pbmc300_ax_slv aw_slv11(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[11], mst_slv_awvalids14[11],
		mst_slv_awvalids13[11], mst_slv_awvalids12[11],
		mst_slv_awvalids11[11], mst_slv_awvalids10[11],
		mst_slv_awvalids9[11], mst_slv_awvalids8[11],
		mst_slv_awvalids7[11], mst_slv_awvalids6[11],
		mst_slv_awvalids5[11], mst_slv_awvalids4[11],
		mst_slv_awvalids3[11], mst_slv_awvalids2[11],
		mst_slv_awvalids1[11], mst_slv_awvalids0[11]}),
	.outstanding_ready(aw_outstanding_readys[11]),
	.arb_mid	(aw_arb_mids[11]),
	.slv_axready	(slv_awreadys[11]),
	.ds_axvalid_int	(ds11_awvalid_int),
	.ds_axready	(ds11_awready)
);
`else
assign aw_arb_mids[11] = 4'hf;
assign slv_awreadys[11] = 1'b1;
assign ds11_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
pbmc300_ax_slv aw_slv12(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[12], mst_slv_awvalids14[12],
		mst_slv_awvalids13[12], mst_slv_awvalids12[12],
		mst_slv_awvalids11[12], mst_slv_awvalids10[12],
		mst_slv_awvalids9[12], mst_slv_awvalids8[12],
		mst_slv_awvalids7[12], mst_slv_awvalids6[12],
		mst_slv_awvalids5[12], mst_slv_awvalids4[12],
		mst_slv_awvalids3[12], mst_slv_awvalids2[12],
		mst_slv_awvalids1[12], mst_slv_awvalids0[12]}),
	.outstanding_ready(aw_outstanding_readys[12]),
	.arb_mid	(aw_arb_mids[12]),
	.slv_axready	(slv_awreadys[12]),
	.ds_axvalid_int	(ds12_awvalid_int),
	.ds_axready	(ds12_awready)
);
`else
assign aw_arb_mids[12] = 4'hf;
assign slv_awreadys[12] = 1'b1;
assign ds12_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
pbmc300_ax_slv aw_slv13(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[13], mst_slv_awvalids14[13],
		mst_slv_awvalids13[13], mst_slv_awvalids12[13],
		mst_slv_awvalids11[13], mst_slv_awvalids10[13],
		mst_slv_awvalids9[13], mst_slv_awvalids8[13],
		mst_slv_awvalids7[13], mst_slv_awvalids6[13],
		mst_slv_awvalids5[13], mst_slv_awvalids4[13],
		mst_slv_awvalids3[13], mst_slv_awvalids2[13],
		mst_slv_awvalids1[13], mst_slv_awvalids0[13]}),
	.outstanding_ready(aw_outstanding_readys[13]),
	.arb_mid	(aw_arb_mids[13]),
	.slv_axready	(slv_awreadys[13]),
	.ds_axvalid_int	(ds13_awvalid_int),
	.ds_axready	(ds13_awready)
);
`else
assign aw_arb_mids[13] = 4'hf;
assign slv_awreadys[13] = 1'b1;
assign ds13_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
pbmc300_ax_slv aw_slv14(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[14], mst_slv_awvalids14[14],
		mst_slv_awvalids13[14], mst_slv_awvalids12[14],
		mst_slv_awvalids11[14], mst_slv_awvalids10[14],
		mst_slv_awvalids9[14], mst_slv_awvalids8[14],
		mst_slv_awvalids7[14], mst_slv_awvalids6[14],
		mst_slv_awvalids5[14], mst_slv_awvalids4[14],
		mst_slv_awvalids3[14], mst_slv_awvalids2[14],
		mst_slv_awvalids1[14], mst_slv_awvalids0[14]}),
	.outstanding_ready(aw_outstanding_readys[14]),
	.arb_mid	(aw_arb_mids[14]),
	.slv_axready	(slv_awreadys[14]),
	.ds_axvalid_int	(ds14_awvalid_int),
	.ds_axready	(ds14_awready)
);
`else
assign aw_arb_mids[14] = 4'hf;
assign slv_awreadys[14] = 1'b1;
assign ds14_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
pbmc300_ax_slv aw_slv15(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[15], mst_slv_awvalids14[15],
		mst_slv_awvalids13[15], mst_slv_awvalids12[15],
		mst_slv_awvalids11[15], mst_slv_awvalids10[15],
		mst_slv_awvalids9[15], mst_slv_awvalids8[15],
		mst_slv_awvalids7[15], mst_slv_awvalids6[15],
		mst_slv_awvalids5[15], mst_slv_awvalids4[15],
		mst_slv_awvalids3[15], mst_slv_awvalids2[15],
		mst_slv_awvalids1[15], mst_slv_awvalids0[15]}),
	.outstanding_ready(aw_outstanding_readys[15]),
	.arb_mid	(aw_arb_mids[15]),
	.slv_axready	(slv_awreadys[15]),
	.ds_axvalid_int	(ds15_awvalid_int),
	.ds_axready	(ds15_awready)
);
`else
assign aw_arb_mids[15] = 4'hf;
assign slv_awreadys[15] = 1'b1;
assign ds15_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
pbmc300_ax_slv aw_slv16(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[16], mst_slv_awvalids14[16],
		mst_slv_awvalids13[16], mst_slv_awvalids12[16],
		mst_slv_awvalids11[16], mst_slv_awvalids10[16],
		mst_slv_awvalids9[16], mst_slv_awvalids8[16],
		mst_slv_awvalids7[16], mst_slv_awvalids6[16],
		mst_slv_awvalids5[16], mst_slv_awvalids4[16],
		mst_slv_awvalids3[16], mst_slv_awvalids2[16],
		mst_slv_awvalids1[16], mst_slv_awvalids0[16]}),
	.outstanding_ready(aw_outstanding_readys[16]),
	.arb_mid	(aw_arb_mids[16]),
	.slv_axready	(slv_awreadys[16]),
	.ds_axvalid_int	(ds16_awvalid_int),
	.ds_axready	(ds16_awready)
);
`else
assign aw_arb_mids[16] = 4'hf;
assign slv_awreadys[16] = 1'b1;
assign ds16_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
pbmc300_ax_slv aw_slv17(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[17], mst_slv_awvalids14[17],
		mst_slv_awvalids13[17], mst_slv_awvalids12[17],
		mst_slv_awvalids11[17], mst_slv_awvalids10[17],
		mst_slv_awvalids9[17], mst_slv_awvalids8[17],
		mst_slv_awvalids7[17], mst_slv_awvalids6[17],
		mst_slv_awvalids5[17], mst_slv_awvalids4[17],
		mst_slv_awvalids3[17], mst_slv_awvalids2[17],
		mst_slv_awvalids1[17], mst_slv_awvalids0[17]}),
	.outstanding_ready(aw_outstanding_readys[17]),
	.arb_mid	(aw_arb_mids[17]),
	.slv_axready	(slv_awreadys[17]),
	.ds_axvalid_int	(ds17_awvalid_int),
	.ds_axready	(ds17_awready)
);
`else
assign aw_arb_mids[17] = 4'hf;
assign slv_awreadys[17] = 1'b1;
assign ds17_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
pbmc300_ax_slv aw_slv18(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[18], mst_slv_awvalids14[18],
		mst_slv_awvalids13[18], mst_slv_awvalids12[18],
		mst_slv_awvalids11[18], mst_slv_awvalids10[18],
		mst_slv_awvalids9[18], mst_slv_awvalids8[18],
		mst_slv_awvalids7[18], mst_slv_awvalids6[18],
		mst_slv_awvalids5[18], mst_slv_awvalids4[18],
		mst_slv_awvalids3[18], mst_slv_awvalids2[18],
		mst_slv_awvalids1[18], mst_slv_awvalids0[18]}),
	.outstanding_ready(aw_outstanding_readys[18]),
	.arb_mid	(aw_arb_mids[18]),
	.slv_axready	(slv_awreadys[18]),
	.ds_axvalid_int	(ds18_awvalid_int),
	.ds_axready	(ds18_awready)
);
`else
assign aw_arb_mids[18] = 4'hf;
assign slv_awreadys[18] = 1'b1;
assign ds18_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
pbmc300_ax_slv aw_slv19(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[19], mst_slv_awvalids14[19],
		mst_slv_awvalids13[19], mst_slv_awvalids12[19],
		mst_slv_awvalids11[19], mst_slv_awvalids10[19],
		mst_slv_awvalids9[19], mst_slv_awvalids8[19],
		mst_slv_awvalids7[19], mst_slv_awvalids6[19],
		mst_slv_awvalids5[19], mst_slv_awvalids4[19],
		mst_slv_awvalids3[19], mst_slv_awvalids2[19],
		mst_slv_awvalids1[19], mst_slv_awvalids0[19]}),
	.outstanding_ready(aw_outstanding_readys[19]),
	.arb_mid	(aw_arb_mids[19]),
	.slv_axready	(slv_awreadys[19]),
	.ds_axvalid_int	(ds19_awvalid_int),
	.ds_axready	(ds19_awready)
);
`else
assign aw_arb_mids[19] = 4'hf;
assign slv_awreadys[19] = 1'b1;
assign ds19_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
pbmc300_ax_slv aw_slv20(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[20], mst_slv_awvalids14[20],
		mst_slv_awvalids13[20], mst_slv_awvalids12[20],
		mst_slv_awvalids11[20], mst_slv_awvalids10[20],
		mst_slv_awvalids9[20], mst_slv_awvalids8[20],
		mst_slv_awvalids7[20], mst_slv_awvalids6[20],
		mst_slv_awvalids5[20], mst_slv_awvalids4[20],
		mst_slv_awvalids3[20], mst_slv_awvalids2[20],
		mst_slv_awvalids1[20], mst_slv_awvalids0[20]}),
	.outstanding_ready(aw_outstanding_readys[20]),
	.arb_mid	(aw_arb_mids[20]),
	.slv_axready	(slv_awreadys[20]),
	.ds_axvalid_int	(ds20_awvalid_int),
	.ds_axready	(ds20_awready)
);
`else
assign aw_arb_mids[20] = 4'hf;
assign slv_awreadys[20] = 1'b1;
assign ds20_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
pbmc300_ax_slv aw_slv21(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[21], mst_slv_awvalids14[21],
		mst_slv_awvalids13[21], mst_slv_awvalids12[21],
		mst_slv_awvalids11[21], mst_slv_awvalids10[21],
		mst_slv_awvalids9[21], mst_slv_awvalids8[21],
		mst_slv_awvalids7[21], mst_slv_awvalids6[21],
		mst_slv_awvalids5[21], mst_slv_awvalids4[21],
		mst_slv_awvalids3[21], mst_slv_awvalids2[21],
		mst_slv_awvalids1[21], mst_slv_awvalids0[21]}),
	.outstanding_ready(aw_outstanding_readys[21]),
	.arb_mid	(aw_arb_mids[21]),
	.slv_axready	(slv_awreadys[21]),
	.ds_axvalid_int	(ds21_awvalid_int),
	.ds_axready	(ds21_awready)
);
`else
assign aw_arb_mids[21] = 4'hf;
assign slv_awreadys[21] = 1'b1;
assign ds21_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
pbmc300_ax_slv aw_slv22(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[22], mst_slv_awvalids14[22],
		mst_slv_awvalids13[22], mst_slv_awvalids12[22],
		mst_slv_awvalids11[22], mst_slv_awvalids10[22],
		mst_slv_awvalids9[22], mst_slv_awvalids8[22],
		mst_slv_awvalids7[22], mst_slv_awvalids6[22],
		mst_slv_awvalids5[22], mst_slv_awvalids4[22],
		mst_slv_awvalids3[22], mst_slv_awvalids2[22],
		mst_slv_awvalids1[22], mst_slv_awvalids0[22]}),
	.outstanding_ready(aw_outstanding_readys[22]),
	.arb_mid	(aw_arb_mids[22]),
	.slv_axready	(slv_awreadys[22]),
	.ds_axvalid_int	(ds22_awvalid_int),
	.ds_axready	(ds22_awready)
);
`else
assign aw_arb_mids[22] = 4'hf;
assign slv_awreadys[22] = 1'b1;
assign ds22_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
pbmc300_ax_slv aw_slv23(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[23], mst_slv_awvalids14[23],
		mst_slv_awvalids13[23], mst_slv_awvalids12[23],
		mst_slv_awvalids11[23], mst_slv_awvalids10[23],
		mst_slv_awvalids9[23], mst_slv_awvalids8[23],
		mst_slv_awvalids7[23], mst_slv_awvalids6[23],
		mst_slv_awvalids5[23], mst_slv_awvalids4[23],
		mst_slv_awvalids3[23], mst_slv_awvalids2[23],
		mst_slv_awvalids1[23], mst_slv_awvalids0[23]}),
	.outstanding_ready(aw_outstanding_readys[23]),
	.arb_mid	(aw_arb_mids[23]),
	.slv_axready	(slv_awreadys[23]),
	.ds_axvalid_int	(ds23_awvalid_int),
	.ds_axready	(ds23_awready)
);
`else
assign aw_arb_mids[23] = 4'hf;
assign slv_awreadys[23] = 1'b1;
assign ds23_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
pbmc300_ax_slv aw_slv24(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[24], mst_slv_awvalids14[24],
		mst_slv_awvalids13[24], mst_slv_awvalids12[24],
		mst_slv_awvalids11[24], mst_slv_awvalids10[24],
		mst_slv_awvalids9[24], mst_slv_awvalids8[24],
		mst_slv_awvalids7[24], mst_slv_awvalids6[24],
		mst_slv_awvalids5[24], mst_slv_awvalids4[24],
		mst_slv_awvalids3[24], mst_slv_awvalids2[24],
		mst_slv_awvalids1[24], mst_slv_awvalids0[24]}),
	.outstanding_ready(aw_outstanding_readys[24]),
	.arb_mid	(aw_arb_mids[24]),
	.slv_axready	(slv_awreadys[24]),
	.ds_axvalid_int	(ds24_awvalid_int),
	.ds_axready	(ds24_awready)
);
`else
assign aw_arb_mids[24] = 4'hf;
assign slv_awreadys[24] = 1'b1;
assign ds24_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
pbmc300_ax_slv aw_slv25(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[25], mst_slv_awvalids14[25],
		mst_slv_awvalids13[25], mst_slv_awvalids12[25],
		mst_slv_awvalids11[25], mst_slv_awvalids10[25],
		mst_slv_awvalids9[25], mst_slv_awvalids8[25],
		mst_slv_awvalids7[25], mst_slv_awvalids6[25],
		mst_slv_awvalids5[25], mst_slv_awvalids4[25],
		mst_slv_awvalids3[25], mst_slv_awvalids2[25],
		mst_slv_awvalids1[25], mst_slv_awvalids0[25]}),
	.outstanding_ready(aw_outstanding_readys[25]),
	.arb_mid	(aw_arb_mids[25]),
	.slv_axready	(slv_awreadys[25]),
	.ds_axvalid_int	(ds25_awvalid_int),
	.ds_axready	(ds25_awready)
);
`else
assign aw_arb_mids[25] = 4'hf;
assign slv_awreadys[25] = 1'b1;
assign ds25_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
pbmc300_ax_slv aw_slv26(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[26], mst_slv_awvalids14[26],
		mst_slv_awvalids13[26], mst_slv_awvalids12[26],
		mst_slv_awvalids11[26], mst_slv_awvalids10[26],
		mst_slv_awvalids9[26], mst_slv_awvalids8[26],
		mst_slv_awvalids7[26], mst_slv_awvalids6[26],
		mst_slv_awvalids5[26], mst_slv_awvalids4[26],
		mst_slv_awvalids3[26], mst_slv_awvalids2[26],
		mst_slv_awvalids1[26], mst_slv_awvalids0[26]}),
	.outstanding_ready(aw_outstanding_readys[26]),
	.arb_mid	(aw_arb_mids[26]),
	.slv_axready	(slv_awreadys[26]),
	.ds_axvalid_int	(ds26_awvalid_int),
	.ds_axready	(ds26_awready)
);
`else
assign aw_arb_mids[26] = 4'hf;
assign slv_awreadys[26] = 1'b1;
assign ds26_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
pbmc300_ax_slv aw_slv27(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[27], mst_slv_awvalids14[27],
		mst_slv_awvalids13[27], mst_slv_awvalids12[27],
		mst_slv_awvalids11[27], mst_slv_awvalids10[27],
		mst_slv_awvalids9[27], mst_slv_awvalids8[27],
		mst_slv_awvalids7[27], mst_slv_awvalids6[27],
		mst_slv_awvalids5[27], mst_slv_awvalids4[27],
		mst_slv_awvalids3[27], mst_slv_awvalids2[27],
		mst_slv_awvalids1[27], mst_slv_awvalids0[27]}),
	.outstanding_ready(aw_outstanding_readys[27]),
	.arb_mid	(aw_arb_mids[27]),
	.slv_axready	(slv_awreadys[27]),
	.ds_axvalid_int	(ds27_awvalid_int),
	.ds_axready	(ds27_awready)
);
`else
assign aw_arb_mids[27] = 4'hf;
assign slv_awreadys[27] = 1'b1;
assign ds27_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
pbmc300_ax_slv aw_slv28(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[28], mst_slv_awvalids14[28],
		mst_slv_awvalids13[28], mst_slv_awvalids12[28],
		mst_slv_awvalids11[28], mst_slv_awvalids10[28],
		mst_slv_awvalids9[28], mst_slv_awvalids8[28],
		mst_slv_awvalids7[28], mst_slv_awvalids6[28],
		mst_slv_awvalids5[28], mst_slv_awvalids4[28],
		mst_slv_awvalids3[28], mst_slv_awvalids2[28],
		mst_slv_awvalids1[28], mst_slv_awvalids0[28]}),
	.outstanding_ready(aw_outstanding_readys[28]),
	.arb_mid	(aw_arb_mids[28]),
	.slv_axready	(slv_awreadys[28]),
	.ds_axvalid_int	(ds28_awvalid_int),
	.ds_axready	(ds28_awready)
);
`else
assign aw_arb_mids[28] = 4'hf;
assign slv_awreadys[28] = 1'b1;
assign ds28_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
pbmc300_ax_slv aw_slv29(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[29], mst_slv_awvalids14[29],
		mst_slv_awvalids13[29], mst_slv_awvalids12[29],
		mst_slv_awvalids11[29], mst_slv_awvalids10[29],
		mst_slv_awvalids9[29], mst_slv_awvalids8[29],
		mst_slv_awvalids7[29], mst_slv_awvalids6[29],
		mst_slv_awvalids5[29], mst_slv_awvalids4[29],
		mst_slv_awvalids3[29], mst_slv_awvalids2[29],
		mst_slv_awvalids1[29], mst_slv_awvalids0[29]}),
	.outstanding_ready(aw_outstanding_readys[29]),
	.arb_mid	(aw_arb_mids[29]),
	.slv_axready	(slv_awreadys[29]),
	.ds_axvalid_int	(ds29_awvalid_int),
	.ds_axready	(ds29_awready)
);
`else
assign aw_arb_mids[29] = 4'hf;
assign slv_awreadys[29] = 1'b1;
assign ds29_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
pbmc300_ax_slv aw_slv30(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[30], mst_slv_awvalids14[30],
		mst_slv_awvalids13[30], mst_slv_awvalids12[30],
		mst_slv_awvalids11[30], mst_slv_awvalids10[30],
		mst_slv_awvalids9[30], mst_slv_awvalids8[30],
		mst_slv_awvalids7[30], mst_slv_awvalids6[30],
		mst_slv_awvalids5[30], mst_slv_awvalids4[30],
		mst_slv_awvalids3[30], mst_slv_awvalids2[30],
		mst_slv_awvalids1[30], mst_slv_awvalids0[30]}),
	.outstanding_ready(aw_outstanding_readys[30]),
	.arb_mid	(aw_arb_mids[30]),
	.slv_axready	(slv_awreadys[30]),
	.ds_axvalid_int	(ds30_awvalid_int),
	.ds_axready	(ds30_awready)
);
`else
assign aw_arb_mids[30] = 4'hf;
assign slv_awreadys[30] = 1'b1;
assign ds30_awvalid_int = 1'b0;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
pbmc300_ax_slv aw_slv31(.*,
	.mst_axvalids	({
		mst_slv_awvalids15[31], mst_slv_awvalids14[31],
		mst_slv_awvalids13[31], mst_slv_awvalids12[31],
		mst_slv_awvalids11[31], mst_slv_awvalids10[31],
		mst_slv_awvalids9[31], mst_slv_awvalids8[31],
		mst_slv_awvalids7[31], mst_slv_awvalids6[31],
		mst_slv_awvalids5[31], mst_slv_awvalids4[31],
		mst_slv_awvalids3[31], mst_slv_awvalids2[31],
		mst_slv_awvalids1[31], mst_slv_awvalids0[31]}),
	.outstanding_ready(aw_outstanding_readys[31]),
	.arb_mid	(aw_arb_mids[31]),
	.slv_axready	(slv_awreadys[31]),
	.ds_axvalid_int	(ds31_awvalid_int),
	.ds_axready	(ds31_awready)
);
`else
assign aw_arb_mids[31] = 4'hf;
assign slv_awreadys[31] = 1'b1;
assign ds31_awvalid_int = 1'b0;
`endif
// VPERL_GENERATED_END

// Internal slave signals. We don't emulate the internal slave.
`ifdef ATCBMC300_SLV0_SUPPORT
assign slv_arreadys[0] = `NDS_BMC.ds0_ctrl.slv0_arready;
assign slv_awreadys[0] = `NDS_BMC.ds0_ctrl.slv0_awready;
assign ar_arb_mids[0] = `NDS_BMC.ds0_ctrl.slv0_ar_mid;
assign aw_arb_mids[0] = `NDS_BMC.ds0_ctrl.slv0_aw_mid;
`else
assign slv_arreadys[0] = 1'b1;
assign slv_awreadys[0] = 1'b1;
assign ar_arb_mids[0] = 4'hf;
assign aw_arb_mids[0] = 4'hf;
`endif

endmodule
