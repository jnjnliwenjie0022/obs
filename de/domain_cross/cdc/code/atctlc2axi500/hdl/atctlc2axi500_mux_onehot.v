// One-Hot Multiplexer
//
// Exmaple:
//	wire   [(EXTVALEN*DEPTH)-1:0] addr;		// in
//	reg               [DEPTH-1:0] head_ptr;		// sel (one-hot)
//	wire           [EXTVALEN-1:0] head_addr;	// out
//
//	atctlc2axi500_mux_onehot #(.N(DEPTH), .W(EXTVALEN))   u_head_addr (.out(head_addr),   .sel(head_ptr), .in(addr));



module atctlc2axi500_mux_onehot (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  out,      
        	  sel,      
        	  in        
        // VPERL_GENERATED_END
);
parameter N = 2;
parameter W = 8;
output          [W-1:0] out;
input           [N-1:0] sel;
input       [(N*W)-1:0] in;

wire        [(N*W)-1:0] tmp;

assign tmp[W-1:0] = {W{sel[0]}} & in[W-1:0];

generate
genvar i;
for (i=1; i<N; i=i+1) begin : gen_tmp
	assign tmp[i*W+:W] = tmp[(i-1)*W+:W] | ({W{sel[i]}} & in[i*W+:W]);
end
endgenerate

assign out = tmp[(N-1)*W+:W];


endmodule

