module atcaxi2tluh500_leading_zero (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  i,        
        	  o,        
        	  nlz       
        // VPERL_GENERATED_END
);

parameter	N = 2;	// N <= 256
localparam 	W = $unsigned($clog2(N));

input	[N-1:0]	i;
output	[W-1:0]	o;
output		nlz;

assign	nlz	= &i;

wire	[N-1:0]	i_tmp = ~i & (i + {{(N-1){1'b0}}, 1'b1});

atcaxi2tluh500_onehot2bin #(
	.N	(N)
) u_onehot2bin (
	.out	(o),
	.in	(i_tmp)
);

endmodule
