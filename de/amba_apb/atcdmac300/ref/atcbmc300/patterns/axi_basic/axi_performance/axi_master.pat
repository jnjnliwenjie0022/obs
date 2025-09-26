// *** Macros ***
// NDS_XM1_WITH: Additional inline constraints.
//

parameter	DELAY_MAX = 10;
parameter	TRANS_NUM = 500;

const int	connections = `NDS_BENCH.msts_connections[MODEL_ID];
const int	conn_num = $countones(connections);

// At least one connected slave.
initial assert(conn_num != 0) else $error("conn_num(%0d) == 0", conn_num);

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

