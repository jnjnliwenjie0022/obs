// This module is used in ae350_aopd to emulation isolation cell in FPGA
// iso_cell_fpga iso_cell_fpga(.iso_in(), iso_val(), sel_iso(), iso_out());
module iso_cell_fpga (
	// VPERL: &PORTLIST;
	// VPERL_GENERATED_BEGIN
		  iso_in,   
		  iso_val,  
		  sel_iso,  
		  iso_out   
	// VPERL_GENERATED_END
);

input	iso_in;	
input	iso_val;
input	sel_iso;
output	iso_out;

wire	iso_out;

`ifdef NDS_FPGA
	assign iso_out = sel_iso ? iso_val : iso_in;
`else	// !NDS_FPGA
	assign iso_out = iso_in;
`endif // NDS_FPGA

endmodule
