// Fix Priority Valid/Ready Arbiter
//	bit 0 has the highest priority
//
// Exmpale:
//	valid:	5'b01100
//	ready:	5'b00111
//	grant:	5'b00100

module atcaxi2tluh500_arb_fp (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  valid,    
        	  ready,    
        	  grant     
        // VPERL_GENERATED_END
);
parameter N = 8;
input		[N-1:0]	valid;
output		[N-1:0]	ready;
output		[N-1:0]	grant;


assign ready[0] = 1'b1;

generate
genvar i;
for (i=1; i<N; i=i+1) begin : gen_ready
	assign ready[i] = ~|valid[i-1:0];
end
endgenerate

assign grant = valid & ready;

endmodule

