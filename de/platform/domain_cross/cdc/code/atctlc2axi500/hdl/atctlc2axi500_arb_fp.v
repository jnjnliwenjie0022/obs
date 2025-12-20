// Fix Priority Valid/Ready Arbiter
//	bit 0 has the highest priority
//
// Exmpale:
//	valid:	5'b01100
//	ready:	5'b00111
//	grant:	5'b00100

module atctlc2axi500_arb_fp (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  valids,   
        	  readys,   
        	  grants,   
        	  ready,    
        	  valid     
        // VPERL_GENERATED_END
);
parameter N = 8;
input		[N-1:0]	valids;
output		[N-1:0]	readys;
output		[N-1:0]	grants;
input                   ready;
output                  valid;


integer			i;
reg		[N-1:0] ready_mask;

always @* begin
	ready_mask[0] = 1'b1;
	for (i=1; i<N; i=i+1) begin
		ready_mask[i] = ready_mask[i-1] & ~valids[i-1];
	end
end

assign readys = ready_mask & {N{ready}};
assign grants = valids & ready_mask;
assign valid = |valids;

//------------------------------------
//assertions
//------------------------------------
`ifdef OVL_ASSERT_ON
// pragma coverage off

// pragma coverage on
`endif // OVL_ASSERT_ON


endmodule

