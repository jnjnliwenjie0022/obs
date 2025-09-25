
// find first set
// Example:
//	in:  00010100
//	out: 00000100

module atctlc2axi500_ffs (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  out,      
        	  in        
        // VPERL_GENERATED_END
);


parameter WIDTH = 8;

output	[WIDTH-1:0] out;
input	[WIDTH-1:0] in;



wire    [WIDTH-1:0] neg;


assign neg = ~in + {{(WIDTH-1){1'b0}}, 1'b1};
assign out = in & neg;

endmodule

