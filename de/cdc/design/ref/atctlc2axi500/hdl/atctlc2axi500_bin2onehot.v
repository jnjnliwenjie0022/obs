// Binary to One-Hot Converter
//
// Example:
//	wire  [2:0] in;		// 3'd6
//	wire  [6:0] out;	// 7'd1000000
//
//	kv_bin2onehot #(.N(7)) u_out (.out(out), .in(in));


module atctlc2axi500_bin2onehot (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  out,      
        	  in        
        // VPERL_GENERATED_END
);
parameter N = 8;
localparam W = $unsigned($clog2(N));


output   [N-1:0] out;
input    [W-1:0] in;

assign out = {{(N-1){1'b0}}, 1'b1} << in;

endmodule


