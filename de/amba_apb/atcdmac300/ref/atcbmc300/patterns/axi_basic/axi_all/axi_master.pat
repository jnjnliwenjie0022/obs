// *** Macros ***
// NDS_XM1_WITH: Additional inline constraints.
//

parameter	DELAY_MAX = 10;
parameter	TRANS_NUM = 500;

const int	connections = `NDS_BENCH.msts_connections[MODEL_ID];
const int	conn_num = $countones(connections);

// At least one connected slave.
initial assert(conn_num != 0) else $error("conn_num == 0");

`ifdef NDS_PERFORMANCE_TEST
initial assert(DELAY_MAX == 0) else $error("DELAY_MAX(%0d) != 0", DELAY_MAX);
`endif

class addr_range;
	rand int unsigned		space_sel;
	bit [ADDR_WIDTH:0]		addr_start;
	bit [ADDR_WIDTH:0]		addr_end;

	constraint c_space_sel {
		`ifdef NDS_PERFORMANCE_TEST
		space_sel < conn_num;
		`else
		space_sel <= conn_num;
		`endif
		// conn_num: Full space.
		// 0..(conn_num-1): Within one of the slave spaces.
	}

	function void post_randomize();
		if (space_sel == conn_num) begin
			addr_start = ADDR_START;
			addr_end = ADDR_END;
		end
		else begin
			// Find out the address space of the connected slave.
			int	cnt = 0;
			int	i;
			for (i = 0; i < 32; i++) begin
				if (connections[i]) begin
					// Compare cnt before advancing it since
					// space_sel is (n-1) instead of n.
					if (cnt == space_sel) begin
						break;
					end
					cnt++;
				end
			end
			addr_start = `NDS_BENCH.spaces[i].base;
			addr_end = (`NDS_BENCH.spaces[i].base + `NDS_BENCH.spaces[i].capacity);
			// $display("%m:space_sel=%0d i=%0d addr_start=%h addr_end=%h", space_sel, i, addr_start, addr_end);
		end
	endfunction
endclass

//----- Start of test case -----//
initial begin: MASTER_TEST
	addr_range			rng;
	axi_packet			pkt;
	axi_pkt_sequence		pkts;
	logic [31:0]			exp_data;
	logic [`ATCBMC300_ADDR_WIDTH-1:0]	xaddr;

	$display("%0t:%m:connections=%0h conn_num=%0d", $realtime, connections, conn_num);

	// if (MODEL_ID != 1) disable MODEL_ID_1_TEST;
	// // This code block is for MODEL_ID == 1.
	`NDS_BENCH.wait_reset_done();

	rng = new;
	pkts = new;

	set_random_delay_cycle(DELAY_MAX, 0);

	$display("============ axi_master%0d starts axi_all busy_max=%0d",
		MODEL_ID, DELAY_MAX, " with { ",
		`ifdef NDS_XM1_WITH `STRINGIFY(`NDS_XM1_WITH), `endif
		"; } ===============");

	`ifdef ATCBMC300_SLV0_SUPPORT
		`ifdef NDS_COV_ENABLED
	// Read all internal slave registers to improve the coverage.
	xaddr = `ATCBMC300_SLV0_BASE_ADDR;
	pkt = new;
	void'(pkt.randomize() with {
		addr == xaddr;
		axlen == 255;
		write == 1'b0;
		axsize == 2;
		burst == BURST_INCR;
	});
	pkts.add_pkt(pkt);

	if (MODEL_ID == 0) begin
		// Write the priority register.
		// Since multiple master may be running simultaneously, we need
		// to avoid the race condition. Only allow master 0 to do this.
		xaddr = `ATCBMC300_SLV0_BASE_ADDR + (`ATCBMC300_ADDR_WIDTH)'(16);
		pkt = new;
		void'(pkt.randomize() with {
			addr == xaddr;
			axlen == 0;
			write == 1'b1;
			axsize == 2;
			burst == BURST_INCR;
		});
		pkt.wstrb[0] = 'hf;
		exp_data = pkt.data[0];

		exp_data &= 32'h8000ffff;	// Mask reserved bits.

		`ifndef ATCBMC300_MST0_SUPPORT exp_data[0] = 1'b0; `endif
		`ifndef ATCBMC300_MST1_SUPPORT exp_data[1] = 1'b0; `endif
		`ifndef ATCBMC300_MST2_SUPPORT exp_data[2] = 1'b0; `endif
		`ifndef ATCBMC300_MST3_SUPPORT exp_data[3] = 1'b0; `endif
		`ifndef ATCBMC300_MST4_SUPPORT exp_data[4] = 1'b0; `endif
		`ifndef ATCBMC300_MST5_SUPPORT exp_data[5] = 1'b0; `endif
		`ifndef ATCBMC300_MST6_SUPPORT exp_data[6] = 1'b0; `endif
		`ifndef ATCBMC300_MST7_SUPPORT exp_data[7] = 1'b0; `endif
		`ifndef ATCBMC300_MST8_SUPPORT exp_data[8] = 1'b0; `endif
		`ifndef ATCBMC300_MST9_SUPPORT exp_data[9] = 1'b0; `endif
		`ifndef ATCBMC300_MST10_SUPPORT exp_data[10] = 1'b0; `endif
		`ifndef ATCBMC300_MST11_SUPPORT exp_data[11] = 1'b0; `endif
		`ifndef ATCBMC300_MST12_SUPPORT exp_data[12] = 1'b0; `endif
		`ifndef ATCBMC300_MST13_SUPPORT exp_data[13] = 1'b0; `endif
		`ifndef ATCBMC300_MST14_SUPPORT exp_data[14] = 1'b0; `endif
		`ifndef ATCBMC300_MST15_SUPPORT exp_data[15] = 1'b0; `endif

		`ifndef ATCBMC300_MST0_SUPPORT exp_data[31] = 1'b0; `endif

		pkts.add_pkt(pkt);
		pkts.send_trans();

		pkts.pkts.delete();

		// Read the priority register.
		pkt = new;
		void'(pkt.randomize() with {
			addr == xaddr;
			axlen == 0;
			write == 1'b0;
			axsize == 2;
			burst == BURST_INCR;
		});
		pkts.add_pkt(pkt);
		pkts.send_trans();

		if (exp_data !== pkt.data[0]) begin
			$display("%0t:%m:ERROR: Priority register error: exp(%x) != read(%x)", $realtime, exp_data, pkt.data[0]);
			#10 $finish;
		end
	end
		`endif
	`endif

	for (int i = 0; i < TRANS_NUM; i++) begin
		void'(rng.randomize());
		pkt = new;
		pkt.addr_start = rng.addr_start;
		pkt.addr_end = rng.addr_end;
		void'(pkt.randomize() with {
			lock[1] == 1'b0;
			`ifdef NDS_XM1_WITH `NDS_XM1_WITH; `endif
		});
		pkts.add_pkt(pkt);
	end
	pkts.send_trans();

	$display("%0t:%m: END of master%0d test.", $realtime, MODEL_ID);

	program_exit(0);	// Terminate only the current master.
end
//----- End of test case -----//

