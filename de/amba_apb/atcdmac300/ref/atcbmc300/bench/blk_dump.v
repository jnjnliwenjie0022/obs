`timescale 1ns/1ps

// VPERL_BEGIN
// &DEF_DUMP_MODULE('blk_dump',  # module name
//   'system.atcbmc300',
// );
// VPERL_END

// VPERL_GENERATED_BEGIN
module blk_dump;

supply0 gnd; // ncverilog generates warnings if there are no variables in this module for dumping

`ifdef DUMP_ENABLE
initial begin
	// ----------------------------------
	`ifdef FSDB
		$display("%d:dump:dumping signals to verilog.fsdb", $stime);
		$fsdbDumpfile("verilog.fsdb");
	`else // !FSDB
	`ifdef SHM
		$display("%d:dump:dumping signals to verilog.shm", $stime);
		`ifdef DUMP_SEQUENCE
		$shm_open("verilog.shm", 1);
		`else // !DUMP_SEQUENCE
		$shm_open("verilog.shm");
		`endif // DUMP_SEQUENCE
	`else // !SHM
	`ifdef VCD
		$display("%d:dump:dumping signals to verilog.vcd", $stime);
		$dumpfile("verilog.vcd");
	`else // !VCD
	`ifdef VPD
		$display("%d:dump:dumping signals to verilog.vpd", $stime);
		$vcdplusfile("verilog.vpd");
	`else // !VPD
	`ifdef TRN
		$display("%d:dump:dumping signals to verilog.trn", $stime);
		`ifdef DUMP_SEQUENCE
		$recordfile("verilog.trn", "sequence");
		`else // !DUMP_SEQUENCE
		$recordfile("verilog.trn");
		`endif // DUMP_SEQUENCE
	`else // !TRN
		// non of the above: do nothing
	`endif // TRN
	`endif // VPD
	`endif // VCD
	`endif // SHM
	`endif // FSDB

	// ----------------------------------
	`ifdef DUMP_START
		#(`DUMP_START);
	`endif // DUMP_START
		`ifdef DUMP_ALL
	`ifdef FSDB
		$fsdbDumpvars;
	`else // !FSDB
	`ifdef VPD
		$vcdpluson;
	`else // !VPD
	`ifdef SHM
		$shm_probe("ACMTF");
	`else // !SHM
	`ifdef VCD
		$dumpvars;
	`else // !VCD
	`ifdef TRN
		$recordvars;
	`else // !TRN
		// non of the above: do nothing
	`endif // TRN
	`endif // VCD
	`endif // SHM
	`endif // VPD
	`endif // FSDB
	`else // DUMP_ALL
$display("partial signals are dump. use +define+DUMP_ALL for complete signals");

		`ifdef SHM
		$shm_probe(system.atcbmc300, "ACMTF");
		`else // !SHM
		`ifdef VCD
		$dumpvars(0, system.atcbmc300);
		`else // !VCD
		`ifdef VPD
		$vcdpluson(0, system.atcbmc300);
		`else // !VPD
		`ifdef TRN
		$recordvars(system.atcbmc300);
		`else // !TRN
		`ifdef FSDB
		$fsdbDumpvars(0, system.atcbmc300);
		`else // !FSDB
			// non of the above: do nothing
		`endif // FSDB
		`endif // TRN
		`endif // VPD
		`endif // VCD
		`endif // SHM
	`endif // DUMP_ALL

	// ----------------------------------
	$display("%d:dump:dumping started", $stime);

	// ----------------------------------
	`ifdef DUMP_LEN
		#(`DUMP_LEN);
		$display("%d:dump:ERROR:simulation stopped by end of dumping", $stime);
		$finish;
	`endif // DUMP_LEN

end // end of initial block
`endif // DUMP_ENABLE

endmodule
// VPERL_GENERATED_END
