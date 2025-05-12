// This module is an adder without overflow for SpyGlass check
module kv_nooverflow_add (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  a,        
        	  b,        
        	  s         
        // VPERL_GENERATED_END
);

parameter	EW = 32;
localparam	CW = 1;

input	[(EW-1):0]	a;
input	[(EW-1):0]	b;
output	[(EW-1):0]	s;
wire	[(CW-1):0]	nds_unused_c;

assign {nds_unused_c,s} = a + b;

endmodule
