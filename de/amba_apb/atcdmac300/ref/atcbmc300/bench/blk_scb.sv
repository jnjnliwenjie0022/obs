//
// This module implements global scoreboard connections and handling logic by
// referencing xmr.vh.
//
`include "xmr.vh"

module blk_scb();

typedef scb_pkg::bus_adapter #(
	.POLICY_WIDTH(3),
	.STATUS_WIDTH(2),	// rresp or bresp.
	.ADDR_WIDTH(`ATCBMC300_ADDR_WIDTH),
	.DATA_WIDTH(8),		// Compare 8 bits at a time.
	.MISC_WIDTH(2+cfg_pkg::US_ID_WIDTH),	// Lock + AXI ID.
	.INFO_WIDTH(4)		// Width of master/slave's MODEL_ID.
) scb_bus_adapter_t;
typedef scb_bus_adapter_t::pkt_t	xpkt_t;

typedef struct packed {
	xpkt_t::status_t		status;
	cfg_pkg::mid_t			mid;	// Master/slave's model ID.
	xpkt_t::addr_t			addr;
	xpkt_t::data_t			data;
	logic [1:0]			lock;	// AXI awlock.
	cfg_pkg::us_id_t		brid;	// AXI B or R ID tag.
} scb_us_payload_t;

typedef struct packed {
	xpkt_t::status_t		status;
	cfg_pkg::mid_t			mid;	// Master/slave's model ID.
	xpkt_t::addr_t			addr;
	xpkt_t::data_t			data;
	logic [1:0]			lock;	// AXI awlock.
	cfg_pkg::ds_id_t		brid;	// AXI B or R ID tag.
} scb_ds_payload_t;

class scb_bus_adapter_group;
	string				name;
	scb_bus_adapter_t		adapters[0:15];	// For each master.

	function new(string name);
	begin
		this.name = name;
		// VPERL_BEGIN
		// foreach $x (0 .. 15) {
		//   : `ifdef ATCBMC300_MST${x}_SUPPORT
		//   : adapters[$x] = new ({name, "_m$x"});
		//   : `else
		//   : adapters[$x] = null;
		//   : `endif
		// }
		// VPERL_END

		// VPERL_GENERATED_BEGIN
		`ifdef ATCBMC300_MST0_SUPPORT
		adapters[0] = new ({name, "_m0"});
		`else
		adapters[0] = null;
		`endif
		`ifdef ATCBMC300_MST1_SUPPORT
		adapters[1] = new ({name, "_m1"});
		`else
		adapters[1] = null;
		`endif
		`ifdef ATCBMC300_MST2_SUPPORT
		adapters[2] = new ({name, "_m2"});
		`else
		adapters[2] = null;
		`endif
		`ifdef ATCBMC300_MST3_SUPPORT
		adapters[3] = new ({name, "_m3"});
		`else
		adapters[3] = null;
		`endif
		`ifdef ATCBMC300_MST4_SUPPORT
		adapters[4] = new ({name, "_m4"});
		`else
		adapters[4] = null;
		`endif
		`ifdef ATCBMC300_MST5_SUPPORT
		adapters[5] = new ({name, "_m5"});
		`else
		adapters[5] = null;
		`endif
		`ifdef ATCBMC300_MST6_SUPPORT
		adapters[6] = new ({name, "_m6"});
		`else
		adapters[6] = null;
		`endif
		`ifdef ATCBMC300_MST7_SUPPORT
		adapters[7] = new ({name, "_m7"});
		`else
		adapters[7] = null;
		`endif
		`ifdef ATCBMC300_MST8_SUPPORT
		adapters[8] = new ({name, "_m8"});
		`else
		adapters[8] = null;
		`endif
		`ifdef ATCBMC300_MST9_SUPPORT
		adapters[9] = new ({name, "_m9"});
		`else
		adapters[9] = null;
		`endif
		`ifdef ATCBMC300_MST10_SUPPORT
		adapters[10] = new ({name, "_m10"});
		`else
		adapters[10] = null;
		`endif
		`ifdef ATCBMC300_MST11_SUPPORT
		adapters[11] = new ({name, "_m11"});
		`else
		adapters[11] = null;
		`endif
		`ifdef ATCBMC300_MST12_SUPPORT
		adapters[12] = new ({name, "_m12"});
		`else
		adapters[12] = null;
		`endif
		`ifdef ATCBMC300_MST13_SUPPORT
		adapters[13] = new ({name, "_m13"});
		`else
		adapters[13] = null;
		`endif
		`ifdef ATCBMC300_MST14_SUPPORT
		adapters[14] = new ({name, "_m14"});
		`else
		adapters[14] = null;
		`endif
		`ifdef ATCBMC300_MST15_SUPPORT
		adapters[15] = new ({name, "_m15"});
		`else
		adapters[15] = null;
		`endif
		// VPERL_GENERATED_END
	end
	endfunction
endclass

scb_bus_adapter_group	sbags[0:31];	// For each slave.

initial begin: blk_scb_init
	string		str;
	#1;	// Make sure `NDS_BENCH.spaces has been built.
	sbags[0] = null;	// Slave0 can't be monitored.
	for (int i = 1; i < 32; i++) begin
		if (`NDS_BENCH.spaces[i].capacity == 0) begin
			sbags[i] = null;
			continue;
		end
		// Create an scb_bus_adapter_group for each present slave.
		$sformat(str, "s%0d", i);
		sbags[i] = new (str);
	end
end


//
// Write direction queue.
//
// Capture writes at AXI masters.
// VPERL_BEGIN
// foreach $x (0 .. 15) {
//   : `ifdef ATCBMC300_MST${x}_SUPPORT
//   : always @(`NDS_SYSTEM.axi_master${x}.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M${x}_WRITE
//   : 	int				i;
//   : 	realtime			ig_time;
//   : 	scb_us_payload_t		pd;	// Payload.
//   : 	xpkt_t:\:policy_t		policy;
//   : 	xpkt_t				p;
//   :
//   : 	while (`NDS_SYSTEM.axi_master${x}.scb_axim_mon.scb_wr_queue_size()) begin
//   : 		ig_time = `NDS_SYSTEM.axi_master${x}.scb_axim_mon.scb_wr_qtime.pop_front();
//   : 		pd = \{
//   : 			`NDS_SYSTEM.axi_master${x}.scb_axim_mon.scb_wr_queue.pop_front(),
//   : 			`NDS_SYSTEM.axi_master${x}.scb_axim_mon.scb_wr_qid.pop_front()\};
//   : 
//   : 		for (i = 0; i < 32; i++) begin
//   : 			if (`NDS_BENCH.spaces[i].capacity == 0)
//   : 				continue;	// Absent slave!
//   : 			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
//   : 				continue;	// Not within this slave.
//   : 			// Hit.
//   : 			if ((`NDS_M${x}_CONNS & (1<<i)) == 0) begin	// Not connected?
//   : 				i = 32;
//   : 				break;
//   : 			end
//   : 			if (i == 0) begin	// Internal slave?
//   : 				if (pd.status != 2'd0)
//   : 					\$display("%0t:%m:ERROR: Response (%0d) != OKAY when master${x} writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
//   : 						\$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
//   : 				break;		// Drop the write silently.
//   : 			end
//   : 			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
//   : 			// mid won't be really compared. Just for the info purpose.
//   : 			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
//   : 			sbags[i].adapters[$x].wc_ig_enqueue(p);
//   : 			// $display("%0t:%m:sbags[%0d].wc.ig.size = %d", $realtime, i, sbags[i].adapters[$x].wc.ig.size);
//   : 			break;
//   : 		end
//   : 		if (i == 32) begin	// No match!
//   : 			if (pd.status != 2'd3) begin
//   : 				\$display("%0t:%m:ERROR: Response (%0d) != DECERR when master${x} writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
//   : 					\$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
//   : 			end
//   : 		end
//   : 	end
//   : end
//   : `endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
always @(`NDS_SYSTEM.axi_master0.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M0_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master0.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master0.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master0.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master0.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M0_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master0 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[0].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[0].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master0 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST1_SUPPORT
always @(`NDS_SYSTEM.axi_master1.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M1_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master1.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master1.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master1.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master1.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M1_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master1 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[1].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[1].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master1 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST2_SUPPORT
always @(`NDS_SYSTEM.axi_master2.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M2_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master2.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master2.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master2.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master2.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M2_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master2 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[2].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[2].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master2 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST3_SUPPORT
always @(`NDS_SYSTEM.axi_master3.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M3_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master3.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master3.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master3.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master3.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M3_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master3 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[3].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[3].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master3 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST4_SUPPORT
always @(`NDS_SYSTEM.axi_master4.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M4_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master4.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master4.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master4.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master4.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M4_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master4 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[4].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[4].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master4 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST5_SUPPORT
always @(`NDS_SYSTEM.axi_master5.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M5_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master5.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master5.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master5.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master5.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M5_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master5 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[5].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[5].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master5 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST6_SUPPORT
always @(`NDS_SYSTEM.axi_master6.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M6_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master6.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master6.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master6.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master6.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M6_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master6 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[6].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[6].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master6 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST7_SUPPORT
always @(`NDS_SYSTEM.axi_master7.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M7_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master7.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master7.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master7.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master7.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M7_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master7 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[7].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[7].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master7 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST8_SUPPORT
always @(`NDS_SYSTEM.axi_master8.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M8_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master8.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master8.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master8.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master8.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M8_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master8 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[8].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[8].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master8 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST9_SUPPORT
always @(`NDS_SYSTEM.axi_master9.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M9_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master9.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master9.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master9.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master9.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M9_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master9 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[9].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[9].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master9 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST10_SUPPORT
always @(`NDS_SYSTEM.axi_master10.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M10_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master10.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master10.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master10.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master10.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M10_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master10 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[10].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[10].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master10 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST11_SUPPORT
always @(`NDS_SYSTEM.axi_master11.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M11_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master11.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master11.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master11.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master11.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M11_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master11 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[11].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[11].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master11 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST12_SUPPORT
always @(`NDS_SYSTEM.axi_master12.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M12_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master12.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master12.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master12.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master12.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M12_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master12 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[12].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[12].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master12 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST13_SUPPORT
always @(`NDS_SYSTEM.axi_master13.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M13_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master13.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master13.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master13.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master13.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M13_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master13 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[13].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[13].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master13 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST14_SUPPORT
always @(`NDS_SYSTEM.axi_master14.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M14_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master14.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master14.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master14.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master14.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M14_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master14 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[14].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[14].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master14 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST15_SUPPORT
always @(`NDS_SYSTEM.axi_master15.scb_axim_mon.scb_wr_evt) begin: CAPTURE_M15_WRITE
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master15.scb_axim_mon.scb_wr_queue_size()) begin
		ig_time = `NDS_SYSTEM.axi_master15.scb_axim_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_master15.scb_axim_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_master15.scb_axim_mon.scb_wr_qid.pop_front()};

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M15_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			if (i == 0) begin	// Internal slave?
				if (pd.status != 2'd0)
					$display("%0t:%m:ERROR: Response (%0d) != OKAY when master15 writes the internal slave: ADDR=%h DATA=%h BID=%h at %0t!",
						$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
				break;		// Drop the write silently.
			end
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[15].wc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].wc.ig.size = %d", , i, sbags[i].adapters[15].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master15 writes an invalid address: ADDR=%h DATA=%h BID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
// VPERL_GENERATED_END

// Capture writes at AXI slaves.
// VPERL_BEGIN
// foreach $y (1 .. 31) {
//   : `ifdef ATCBMC300_SLV${y}_SUPPORT
//   : always @(`NDS_SYSTEM.axi_slave${y}.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S${y}_WRITE
//   : 	realtime			eg_time;
//   : 	scb_ds_payload_t		pd;	// Payload.
//   : 	xpkt_t:\:policy_t		policy;
//   : 	xpkt_t				p;
//   : 	while (`NDS_SYSTEM.axi_slave${y}.scb_axis_mon.scb_wr_queue_size()) begin
//   : 		eg_time = `NDS_SYSTEM.axi_slave${y}.scb_axis_mon.scb_wr_qtime.pop_front();
//   : 		pd = \{
//   : 			`NDS_SYSTEM.axi_slave${y}.scb_axis_mon.scb_wr_queue.pop_front(),
//   : 			`NDS_SYSTEM.axi_slave${y}.scb_axis_mon.scb_wr_qid.pop_front()\};
//   : 		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
//   : 		// The lower bits of bid store the master's MODEL_ID.
//   : 		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg:\:DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
//   : 		sbags[$y].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
//   : 		// \$display("%0t:%m:sbags[${y}].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", \$realtime, sbags[${y}].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
//   : 	end
//   : end
//   : `endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_SLV1_SUPPORT
always @(`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S1_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[1].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[1].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[1].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
always @(`NDS_SYSTEM.axi_slave2.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S2_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave2.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave2.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave2.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave2.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[2].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[2].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[2].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
always @(`NDS_SYSTEM.axi_slave3.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S3_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave3.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave3.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave3.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave3.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[3].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[3].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[3].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
always @(`NDS_SYSTEM.axi_slave4.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S4_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave4.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave4.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave4.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave4.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[4].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[4].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[4].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
always @(`NDS_SYSTEM.axi_slave5.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S5_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave5.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave5.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave5.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave5.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[5].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[5].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[5].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
always @(`NDS_SYSTEM.axi_slave6.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S6_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave6.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave6.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave6.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave6.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[6].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[6].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[6].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
always @(`NDS_SYSTEM.axi_slave7.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S7_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave7.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave7.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave7.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave7.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[7].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[7].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[7].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
always @(`NDS_SYSTEM.axi_slave8.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S8_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave8.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave8.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave8.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave8.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[8].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[8].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[8].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
always @(`NDS_SYSTEM.axi_slave9.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S9_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave9.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave9.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave9.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave9.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[9].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[9].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[9].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
always @(`NDS_SYSTEM.axi_slave10.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S10_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave10.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave10.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave10.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave10.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[10].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[10].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[10].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
always @(`NDS_SYSTEM.axi_slave11.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S11_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave11.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave11.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave11.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave11.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[11].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[11].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[11].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
always @(`NDS_SYSTEM.axi_slave12.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S12_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave12.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave12.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave12.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave12.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[12].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[12].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[12].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
always @(`NDS_SYSTEM.axi_slave13.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S13_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave13.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave13.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave13.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave13.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[13].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[13].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[13].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
always @(`NDS_SYSTEM.axi_slave14.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S14_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave14.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave14.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave14.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave14.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[14].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[14].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[14].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
always @(`NDS_SYSTEM.axi_slave15.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S15_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave15.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave15.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave15.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave15.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[15].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[15].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[15].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
always @(`NDS_SYSTEM.axi_slave16.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S16_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave16.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave16.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave16.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave16.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[16].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[16].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[16].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
always @(`NDS_SYSTEM.axi_slave17.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S17_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave17.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave17.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave17.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave17.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[17].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[17].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[17].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
always @(`NDS_SYSTEM.axi_slave18.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S18_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave18.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave18.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave18.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave18.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[18].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[18].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[18].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
always @(`NDS_SYSTEM.axi_slave19.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S19_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave19.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave19.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave19.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave19.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[19].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[19].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[19].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
always @(`NDS_SYSTEM.axi_slave20.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S20_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave20.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave20.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave20.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave20.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[20].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[20].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[20].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
always @(`NDS_SYSTEM.axi_slave21.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S21_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave21.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave21.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave21.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave21.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[21].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[21].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[21].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
always @(`NDS_SYSTEM.axi_slave22.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S22_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave22.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave22.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave22.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave22.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[22].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[22].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[22].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
always @(`NDS_SYSTEM.axi_slave23.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S23_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave23.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave23.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave23.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave23.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[23].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[23].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[23].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
always @(`NDS_SYSTEM.axi_slave24.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S24_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave24.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave24.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave24.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave24.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[24].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[24].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[24].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
always @(`NDS_SYSTEM.axi_slave25.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S25_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave25.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave25.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave25.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave25.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[25].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[25].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[25].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
always @(`NDS_SYSTEM.axi_slave26.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S26_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave26.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave26.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave26.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave26.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[26].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[26].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[26].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
always @(`NDS_SYSTEM.axi_slave27.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S27_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave27.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave27.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave27.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave27.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[27].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[27].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[27].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
always @(`NDS_SYSTEM.axi_slave28.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S28_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave28.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave28.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave28.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave28.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[28].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[28].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[28].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
always @(`NDS_SYSTEM.axi_slave29.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S29_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave29.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave29.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave29.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave29.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[29].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[29].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[29].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
always @(`NDS_SYSTEM.axi_slave30.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S30_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave30.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave30.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave30.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave30.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[30].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[30].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[30].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
always @(`NDS_SYSTEM.axi_slave31.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S31_WRITE
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave31.scb_axis_mon.scb_wr_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave31.scb_axis_mon.scb_wr_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave31.scb_axis_mon.scb_wr_queue.pop_front(),
			`NDS_SYSTEM.axi_slave31.scb_axis_mon.scb_wr_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		// The lower bits of bid store the master's MODEL_ID.
		p = new(eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[31].adapters[pd.brid[3:0]].wc_eg_enqueue(p);
		// $display("%0t:%m:sbags[31].adapters[%0d].wc.qdata_eg.size=%0d status=%0h slave_mid=%0h addr=%0h data=%h lock=%h brid=%0h", $realtime, sbags[31].adapters[pd.brid[3:0]].wc.eg.size(), pd.status, pd.brid[3:0], pd.mid, pd.addr, pd.data, pd.lock, pd.brid);
	end
end
`endif
// VPERL_GENERATED_END

`ifdef ATCBMC300_SLV0_SUPPORT
task compare_slave0_read(realtime t, int master_id, logic [1:0] status, xpkt_t::addr_t addr, xpkt_t::data_t data, cfg_pkg::us_id_t rid);
begin
	xpkt_t::addr_t			offset;
	xpkt_t::addr_t			offset2;
	bit [63:0]			exp_qw;
	bit [7:0]			exp;
	logic [63:0]			mask0;
	logic [63:0]			mask1;

	if (status != 2'b0) begin
		$display("%0t:%m:ERROR: Response (%0d) != OKAY when master%0d reads the internal slave: ADDR=%h DATA=%h RID=%h at %0t!",
			$realtime, status, master_id, addr, data, rid, t);
	end

	offset = addr - `ATCBMC300_SLV0_BASE_ADDR;
	offset2 = (offset/8)*8;	// Align to 8 bytes.

	case (offset2)
	0:	exp_qw = {32'b0, `ATCBMC300_PRODUCT_ID};
	16: begin
		mask0 = 64'hffff_ffff_7fff_0000;
		mask1 = mask0 >> offset[2:0];
		// The masked bits should always be 0.
		if ((mask1[7:0] & data) != 8'b0) begin
			$display("%0t:%m:ERROR: (mask(%h) & read_data(0x%02h)) != 0 for reading address 0x%0h in the internal slave!", $realtime, mask1[7:0], data, addr);
		end
		// Because of the possible races among masters and the
		// scoreboard monitors, we can't correctly predict the value.
		// So just ignore the value.
		return;
	end
	// VPERL_BEGIN
	// foreach $y (0 .. 31) {
	//   $addr = 256 + $y * 8;
	//   : `ifdef ATCBMC300_SLV${y}_SUPPORT
	//   :$addr:	exp_qw = `ATCBMC300_SLV${y}_BASE_ADDR | `ATCBMC300_SLV${y}_SIZE;
	//   : `endif
	// }
	// VPERL_END

	// VPERL_GENERATED_BEGIN
	`ifdef ATCBMC300_SLV0_SUPPORT
	256:	exp_qw = `ATCBMC300_SLV0_BASE_ADDR | `ATCBMC300_SLV0_SIZE;
	`endif
	`ifdef ATCBMC300_SLV1_SUPPORT
	264:	exp_qw = `ATCBMC300_SLV1_BASE_ADDR | `ATCBMC300_SLV1_SIZE;
	`endif
	`ifdef ATCBMC300_SLV2_SUPPORT
	272:	exp_qw = `ATCBMC300_SLV2_BASE_ADDR | `ATCBMC300_SLV2_SIZE;
	`endif
	`ifdef ATCBMC300_SLV3_SUPPORT
	280:	exp_qw = `ATCBMC300_SLV3_BASE_ADDR | `ATCBMC300_SLV3_SIZE;
	`endif
	`ifdef ATCBMC300_SLV4_SUPPORT
	288:	exp_qw = `ATCBMC300_SLV4_BASE_ADDR | `ATCBMC300_SLV4_SIZE;
	`endif
	`ifdef ATCBMC300_SLV5_SUPPORT
	296:	exp_qw = `ATCBMC300_SLV5_BASE_ADDR | `ATCBMC300_SLV5_SIZE;
	`endif
	`ifdef ATCBMC300_SLV6_SUPPORT
	304:	exp_qw = `ATCBMC300_SLV6_BASE_ADDR | `ATCBMC300_SLV6_SIZE;
	`endif
	`ifdef ATCBMC300_SLV7_SUPPORT
	312:	exp_qw = `ATCBMC300_SLV7_BASE_ADDR | `ATCBMC300_SLV7_SIZE;
	`endif
	`ifdef ATCBMC300_SLV8_SUPPORT
	320:	exp_qw = `ATCBMC300_SLV8_BASE_ADDR | `ATCBMC300_SLV8_SIZE;
	`endif
	`ifdef ATCBMC300_SLV9_SUPPORT
	328:	exp_qw = `ATCBMC300_SLV9_BASE_ADDR | `ATCBMC300_SLV9_SIZE;
	`endif
	`ifdef ATCBMC300_SLV10_SUPPORT
	336:	exp_qw = `ATCBMC300_SLV10_BASE_ADDR | `ATCBMC300_SLV10_SIZE;
	`endif
	`ifdef ATCBMC300_SLV11_SUPPORT
	344:	exp_qw = `ATCBMC300_SLV11_BASE_ADDR | `ATCBMC300_SLV11_SIZE;
	`endif
	`ifdef ATCBMC300_SLV12_SUPPORT
	352:	exp_qw = `ATCBMC300_SLV12_BASE_ADDR | `ATCBMC300_SLV12_SIZE;
	`endif
	`ifdef ATCBMC300_SLV13_SUPPORT
	360:	exp_qw = `ATCBMC300_SLV13_BASE_ADDR | `ATCBMC300_SLV13_SIZE;
	`endif
	`ifdef ATCBMC300_SLV14_SUPPORT
	368:	exp_qw = `ATCBMC300_SLV14_BASE_ADDR | `ATCBMC300_SLV14_SIZE;
	`endif
	`ifdef ATCBMC300_SLV15_SUPPORT
	376:	exp_qw = `ATCBMC300_SLV15_BASE_ADDR | `ATCBMC300_SLV15_SIZE;
	`endif
	`ifdef ATCBMC300_SLV16_SUPPORT
	384:	exp_qw = `ATCBMC300_SLV16_BASE_ADDR | `ATCBMC300_SLV16_SIZE;
	`endif
	`ifdef ATCBMC300_SLV17_SUPPORT
	392:	exp_qw = `ATCBMC300_SLV17_BASE_ADDR | `ATCBMC300_SLV17_SIZE;
	`endif
	`ifdef ATCBMC300_SLV18_SUPPORT
	400:	exp_qw = `ATCBMC300_SLV18_BASE_ADDR | `ATCBMC300_SLV18_SIZE;
	`endif
	`ifdef ATCBMC300_SLV19_SUPPORT
	408:	exp_qw = `ATCBMC300_SLV19_BASE_ADDR | `ATCBMC300_SLV19_SIZE;
	`endif
	`ifdef ATCBMC300_SLV20_SUPPORT
	416:	exp_qw = `ATCBMC300_SLV20_BASE_ADDR | `ATCBMC300_SLV20_SIZE;
	`endif
	`ifdef ATCBMC300_SLV21_SUPPORT
	424:	exp_qw = `ATCBMC300_SLV21_BASE_ADDR | `ATCBMC300_SLV21_SIZE;
	`endif
	`ifdef ATCBMC300_SLV22_SUPPORT
	432:	exp_qw = `ATCBMC300_SLV22_BASE_ADDR | `ATCBMC300_SLV22_SIZE;
	`endif
	`ifdef ATCBMC300_SLV23_SUPPORT
	440:	exp_qw = `ATCBMC300_SLV23_BASE_ADDR | `ATCBMC300_SLV23_SIZE;
	`endif
	`ifdef ATCBMC300_SLV24_SUPPORT
	448:	exp_qw = `ATCBMC300_SLV24_BASE_ADDR | `ATCBMC300_SLV24_SIZE;
	`endif
	`ifdef ATCBMC300_SLV25_SUPPORT
	456:	exp_qw = `ATCBMC300_SLV25_BASE_ADDR | `ATCBMC300_SLV25_SIZE;
	`endif
	`ifdef ATCBMC300_SLV26_SUPPORT
	464:	exp_qw = `ATCBMC300_SLV26_BASE_ADDR | `ATCBMC300_SLV26_SIZE;
	`endif
	`ifdef ATCBMC300_SLV27_SUPPORT
	472:	exp_qw = `ATCBMC300_SLV27_BASE_ADDR | `ATCBMC300_SLV27_SIZE;
	`endif
	`ifdef ATCBMC300_SLV28_SUPPORT
	480:	exp_qw = `ATCBMC300_SLV28_BASE_ADDR | `ATCBMC300_SLV28_SIZE;
	`endif
	`ifdef ATCBMC300_SLV29_SUPPORT
	488:	exp_qw = `ATCBMC300_SLV29_BASE_ADDR | `ATCBMC300_SLV29_SIZE;
	`endif
	`ifdef ATCBMC300_SLV30_SUPPORT
	496:	exp_qw = `ATCBMC300_SLV30_BASE_ADDR | `ATCBMC300_SLV30_SIZE;
	`endif
	`ifdef ATCBMC300_SLV31_SUPPORT
	504:	exp_qw = `ATCBMC300_SLV31_BASE_ADDR | `ATCBMC300_SLV31_SIZE;
	`endif
	// VPERL_GENERATED_END
	default:	exp_qw = 64'h0;
	endcase

	case (offset[2:0])
	3'd0:	exp = exp_qw[ 7: 0];
	3'd1:	exp = exp_qw[15: 8];
	3'd2:	exp = exp_qw[23:16];
	3'd3:	exp = exp_qw[31:24];
	3'd4:	exp = exp_qw[39:32];
	3'd5:	exp = exp_qw[47:40];
	3'd6:	exp = exp_qw[55:48];
	default:exp = exp_qw[63:56];
	endcase

	if (exp !== data) begin
		$display("%0t:%m:ERROR: Exp (0x%02h) != real (0x%02h) for reading address 0x%0h in the internal slave!", $realtime, exp, data, addr);
	end
end
endtask
`endif	// ATCBMC300_SLV0_SUPPORT

//
// Read direction queue.
//
// Capture reads at AXI masters.
// VPERL_BEGIN
// foreach $x (0 .. 15) {
//   : `ifdef ATCBMC300_MST${x}_SUPPORT
//   : always @(`NDS_SYSTEM.axi_master${x}.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M${x}_READ
//   : 	int				i;
//   : 	realtime			ig_time;
//   : 	scb_us_payload_t		pd;	// Payload.
//   : 	xpkt_t:\:policy_t		policy;
//   : 	xpkt_t				p;
//   : 
//   : 	while (`NDS_SYSTEM.axi_master${x}.scb_axim_mon.scb_rd_queue_size()) begin
//   : 		pd = \{
//   : 			`NDS_SYSTEM.axi_master${x}.scb_axim_mon.scb_rd_queue.pop_front(),
//   : 			`NDS_SYSTEM.axi_master${x}.scb_axim_mon.scb_rd_qid.pop_front()\};
//   : 		ig_time = `NDS_SYSTEM.axi_master${x}.scb_axim_mon.scb_rd_qtime.pop_front();
//   : 
//   : 		for (i = 0; i < 32; i++) begin
//   : 			if (`NDS_BENCH.spaces[i].capacity == 0)
//   : 				continue;	// Absent slave!
//   : 			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
//   : 				continue;	// Not within this slave.
//   : 			// Hit.
//   :			if ((`NDS_M${x}_CONNS & (1<<i)) == 0) begin	// Not connected?
//   :				i = 32;
//   :				break;
//   :			end
//   : 			`ifdef ATCBMC300_SLV0_SUPPORT
//   : 			if (i == 0) begin	// Internal slave?
//   : 				compare_slave0_read(ig_time, $x, pd.status, pd.addr, pd.data, pd.brid);
//   : 				break;
//   : 			end
//   : 			`endif
//   : 			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
//   : 			// mid won't be really compared. Just for the info purpose.
//   : 			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
//   : 			sbags[i].adapters[${x}].rc_ig_enqueue(p);
//   : 			// ("%0t:%m:sbags[%0d].adapters[$x].wc.ig.size = %d", $realtime, i, sbags[$x].wc.ig.size);
//   : 			break;
//   : 		end
//   : 		if (i == 32) begin	// No match!
//   : 			if (pd.status != 2'd3) begin
//   : 				\$display("%0t:%m:ERROR: Response (%0d) != DECERR when master${x} reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
//   : 					\$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
//   : 			end
//   : 		end
//   : 	end
//   : end
//   : `endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
always @(`NDS_SYSTEM.axi_master0.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M0_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master0.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master0.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master0.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master0.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M0_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 0, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[0].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[0].wc.ig.size = %d", , i, sbags[0].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master0 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST1_SUPPORT
always @(`NDS_SYSTEM.axi_master1.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M1_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master1.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master1.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master1.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master1.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M1_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 1, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[1].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[1].wc.ig.size = %d", , i, sbags[1].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master1 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST2_SUPPORT
always @(`NDS_SYSTEM.axi_master2.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M2_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master2.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master2.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master2.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master2.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M2_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 2, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[2].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[2].wc.ig.size = %d", , i, sbags[2].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master2 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST3_SUPPORT
always @(`NDS_SYSTEM.axi_master3.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M3_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master3.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master3.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master3.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master3.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M3_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 3, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[3].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[3].wc.ig.size = %d", , i, sbags[3].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master3 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST4_SUPPORT
always @(`NDS_SYSTEM.axi_master4.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M4_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master4.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master4.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master4.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master4.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M4_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 4, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[4].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[4].wc.ig.size = %d", , i, sbags[4].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master4 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST5_SUPPORT
always @(`NDS_SYSTEM.axi_master5.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M5_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master5.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master5.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master5.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master5.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M5_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 5, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[5].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[5].wc.ig.size = %d", , i, sbags[5].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master5 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST6_SUPPORT
always @(`NDS_SYSTEM.axi_master6.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M6_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master6.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master6.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master6.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master6.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M6_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 6, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[6].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[6].wc.ig.size = %d", , i, sbags[6].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master6 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST7_SUPPORT
always @(`NDS_SYSTEM.axi_master7.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M7_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master7.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master7.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master7.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master7.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M7_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 7, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[7].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[7].wc.ig.size = %d", , i, sbags[7].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master7 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST8_SUPPORT
always @(`NDS_SYSTEM.axi_master8.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M8_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master8.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master8.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master8.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master8.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M8_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 8, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[8].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[8].wc.ig.size = %d", , i, sbags[8].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master8 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST9_SUPPORT
always @(`NDS_SYSTEM.axi_master9.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M9_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master9.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master9.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master9.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master9.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M9_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 9, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[9].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[9].wc.ig.size = %d", , i, sbags[9].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master9 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST10_SUPPORT
always @(`NDS_SYSTEM.axi_master10.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M10_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master10.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master10.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master10.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master10.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M10_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 10, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[10].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[10].wc.ig.size = %d", , i, sbags[10].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master10 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST11_SUPPORT
always @(`NDS_SYSTEM.axi_master11.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M11_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master11.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master11.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master11.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master11.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M11_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 11, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[11].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[11].wc.ig.size = %d", , i, sbags[11].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master11 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST12_SUPPORT
always @(`NDS_SYSTEM.axi_master12.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M12_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master12.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master12.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master12.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master12.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M12_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 12, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[12].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[12].wc.ig.size = %d", , i, sbags[12].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master12 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST13_SUPPORT
always @(`NDS_SYSTEM.axi_master13.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M13_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master13.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master13.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master13.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master13.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M13_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 13, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[13].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[13].wc.ig.size = %d", , i, sbags[13].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master13 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST14_SUPPORT
always @(`NDS_SYSTEM.axi_master14.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M14_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master14.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master14.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master14.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master14.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M14_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 14, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[14].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[14].wc.ig.size = %d", , i, sbags[14].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master14 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
`ifdef ATCBMC300_MST15_SUPPORT
always @(`NDS_SYSTEM.axi_master15.scb_axim_mon.scb_rd_evt) begin: CAPTURE_M15_READ
	int				i;
	realtime			ig_time;
	scb_us_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;

	while (`NDS_SYSTEM.axi_master15.scb_axim_mon.scb_rd_queue_size()) begin
		pd = {
			`NDS_SYSTEM.axi_master15.scb_axim_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_master15.scb_axim_mon.scb_rd_qid.pop_front()};
		ig_time = `NDS_SYSTEM.axi_master15.scb_axim_mon.scb_rd_qtime.pop_front();

		for (i = 0; i < 32; i++) begin
			if (`NDS_BENCH.spaces[i].capacity == 0)
				continue;	// Absent slave!
			if (!`NDS_BENCH.spaces[i].in_range(pd.addr))
				continue;	// Not within this slave.
			// Hit.
			if ((`NDS_M15_CONNS & (1<<i)) == 0) begin	// Not connected?
				i = 32;
				break;
			end
			`ifdef ATCBMC300_SLV0_SUPPORT
			if (i == 0) begin	// Internal slave?
				compare_slave0_read(ig_time, 15, pd.status, pd.addr, pd.data, pd.brid);
				break;
			end
			`endif
			policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
			// mid won't be really compared. Just for the info purpose.
			p = new (ig_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid}, pd.mid[3:0]);
			sbags[i].adapters[15].rc_ig_enqueue(p);
			// ("%0t:%m:sbags[%0d].adapters[15].wc.ig.size = %d", , i, sbags[15].wc.ig.size);
			break;
		end
		if (i == 32) begin	// No match!
			if (pd.status != 2'd3) begin
				$display("%0t:%m:ERROR: Response (%0d) != DECERR when master15 reads an invalid address: ADDR=%h DATA=%h RID=%h at %0t!",
					$realtime, pd.status, pd.addr, pd.data, pd.brid, ig_time);
			end
		end
	end
end
`endif
// VPERL_GENERATED_END

// Capture reads at AXI slaves.
// VPERL_BEGIN
// foreach $y (1 .. 31) {
//   : `ifdef ATCBMC300_SLV${y}_SUPPORT
//   : always @(`NDS_SYSTEM.axi_slave${y}.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S${y}_READ
//   : 	realtime			eg_time;
//   : 	scb_ds_payload_t		pd;	// Payload.
//   : 	xpkt_t:\:policy_t		policy;
//   : 	xpkt_t				p;
//   : 	while (`NDS_SYSTEM.axi_slave${y}.scb_axis_mon.scb_rd_queue_size()) begin
//   : 		eg_time = `NDS_SYSTEM.axi_slave${y}.scb_axis_mon.scb_rd_qtime.pop_front();
//   : 		pd = \{
//   : 			`NDS_SYSTEM.axi_slave${y}.scb_axis_mon.scb_rd_queue.pop_front(),
//   : 			`NDS_SYSTEM.axi_slave${y}.scb_axis_mon.scb_rd_qid.pop_front()\};
//   : 		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
// # : 		// The lower bits of rid store the master's MODEL_ID.
//   : 		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg:\:DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
//   : 		sbags[$y].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
//   : 		// $display("%0t:%m:sbags[${y}].adapters[%0d].rc.qdata_eg.size = %d", \$realtime, pd.brid[3:0], sbags[${y}].adapters[pd.brid[3:0]].rc.qdata_eg.size());
//   : 	end
//   : end
//   : `endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_SLV1_SUPPORT
always @(`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S1_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[1].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[1].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[1].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
always @(`NDS_SYSTEM.axi_slave2.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S2_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave2.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave2.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave2.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave2.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[2].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[2].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[2].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
always @(`NDS_SYSTEM.axi_slave3.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S3_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave3.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave3.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave3.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave3.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[3].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[3].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[3].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
always @(`NDS_SYSTEM.axi_slave4.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S4_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave4.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave4.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave4.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave4.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[4].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[4].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[4].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
always @(`NDS_SYSTEM.axi_slave5.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S5_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave5.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave5.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave5.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave5.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[5].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[5].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[5].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
always @(`NDS_SYSTEM.axi_slave6.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S6_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave6.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave6.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave6.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave6.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[6].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[6].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[6].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
always @(`NDS_SYSTEM.axi_slave7.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S7_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave7.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave7.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave7.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave7.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[7].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[7].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[7].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
always @(`NDS_SYSTEM.axi_slave8.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S8_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave8.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave8.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave8.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave8.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[8].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[8].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[8].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
always @(`NDS_SYSTEM.axi_slave9.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S9_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave9.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave9.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave9.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave9.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[9].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[9].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[9].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
always @(`NDS_SYSTEM.axi_slave10.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S10_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave10.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave10.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave10.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave10.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[10].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[10].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[10].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
always @(`NDS_SYSTEM.axi_slave11.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S11_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave11.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave11.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave11.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave11.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[11].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[11].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[11].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
always @(`NDS_SYSTEM.axi_slave12.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S12_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave12.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave12.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave12.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave12.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[12].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[12].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[12].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
always @(`NDS_SYSTEM.axi_slave13.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S13_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave13.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave13.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave13.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave13.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[13].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[13].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[13].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
always @(`NDS_SYSTEM.axi_slave14.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S14_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave14.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave14.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave14.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave14.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[14].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[14].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[14].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
always @(`NDS_SYSTEM.axi_slave15.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S15_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave15.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave15.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave15.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave15.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[15].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[15].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[15].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
always @(`NDS_SYSTEM.axi_slave16.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S16_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave16.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave16.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave16.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave16.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[16].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[16].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[16].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
always @(`NDS_SYSTEM.axi_slave17.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S17_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave17.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave17.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave17.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave17.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[17].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[17].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[17].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
always @(`NDS_SYSTEM.axi_slave18.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S18_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave18.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave18.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave18.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave18.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[18].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[18].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[18].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
always @(`NDS_SYSTEM.axi_slave19.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S19_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave19.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave19.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave19.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave19.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[19].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[19].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[19].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
always @(`NDS_SYSTEM.axi_slave20.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S20_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave20.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave20.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave20.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave20.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[20].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[20].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[20].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
always @(`NDS_SYSTEM.axi_slave21.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S21_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave21.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave21.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave21.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave21.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[21].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[21].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[21].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
always @(`NDS_SYSTEM.axi_slave22.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S22_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave22.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave22.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave22.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave22.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[22].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[22].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[22].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
always @(`NDS_SYSTEM.axi_slave23.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S23_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave23.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave23.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave23.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave23.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[23].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[23].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[23].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
always @(`NDS_SYSTEM.axi_slave24.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S24_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave24.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave24.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave24.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave24.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[24].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[24].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[24].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
always @(`NDS_SYSTEM.axi_slave25.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S25_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave25.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave25.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave25.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave25.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[25].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[25].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[25].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
always @(`NDS_SYSTEM.axi_slave26.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S26_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave26.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave26.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave26.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave26.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[26].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[26].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[26].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
always @(`NDS_SYSTEM.axi_slave27.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S27_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave27.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave27.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave27.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave27.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[27].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[27].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[27].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
always @(`NDS_SYSTEM.axi_slave28.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S28_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave28.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave28.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave28.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave28.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[28].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[28].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[28].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
always @(`NDS_SYSTEM.axi_slave29.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S29_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave29.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave29.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave29.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave29.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[29].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[29].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[29].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
always @(`NDS_SYSTEM.axi_slave30.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S30_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave30.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave30.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave30.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave30.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[30].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[30].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[30].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
always @(`NDS_SYSTEM.axi_slave31.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S31_READ
	realtime			eg_time;
	scb_ds_payload_t		pd;	// Payload.
	xpkt_t::policy_t		policy;
	xpkt_t				p;
	while (`NDS_SYSTEM.axi_slave31.scb_axis_mon.scb_rd_queue_size()) begin
		eg_time = `NDS_SYSTEM.axi_slave31.scb_axis_mon.scb_rd_qtime.pop_front();
		pd = {
			`NDS_SYSTEM.axi_slave31.scb_axis_mon.scb_rd_queue.pop_front(),
			`NDS_SYSTEM.axi_slave31.scb_axis_mon.scb_rd_qid.pop_front()};
		policy = pd.status[1] ? 2'b1 : 2'b0;	// Error or Normal policy.
		p = new (eg_time, policy, pd.status, pd.addr, pd.data, {pd.lock, pd.brid[cfg_pkg::DS_ID_WIDTH-1:4]}, pd.brid[3:0]);
		sbags[31].adapters[pd.brid[3:0]].rc_eg_enqueue(p);
		// ("%0t:%m:sbags[31].adapters[%0d].rc.qdata_eg.size = %d", $realtime, pd.brid[3:0], sbags[31].adapters[pd.brid[3:0]].rc.qdata_eg.size());
	end
end
`endif
// VPERL_GENERATED_END

//
// Final check.
//
// Call this when the system finishes or the pattern wants to clean out.
task scb_final_compare;
begin
	$display("%0t:%m:INFO: Compare all residues in scoreboards.", $realtime);
	for (int i = 1; i < 32; i++) begin
		if (`NDS_BENCH.spaces[i].capacity == 0)
			continue;
		// Create an scb_bus_adapter_group for each present slave.
		for (int j = 0; j < 16; j++) begin
			if (sbags[i].adapters[j] != null)
				sbags[i].adapters[j].final_compare(1'b1);// 1'b1 to allow zero count.
		end
	end
end
endtask

endmodule

