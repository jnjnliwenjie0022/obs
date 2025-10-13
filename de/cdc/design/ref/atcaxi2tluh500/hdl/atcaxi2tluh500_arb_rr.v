// Round Rubin Valid/Ready Arbiter

module atcaxi2tluh500_arb_rr (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  clk,      
        	  resetn,   
        	  en,       
        	  valid,    
        	  ready,    
        	  grant     
        // VPERL_GENERATED_END
);
parameter N = 8;

input			clk;
input			resetn;
input			en;
input		[N-1:0]	valid;
output		[N-1:0]	ready;
output		[N-1:0]	grant;



wire          [N*2-1:0] validx2 = {valid, valid};	// for rotate

wire          [N*N-1:0] grant_all;
wire          [N*N-1:0] ready_all;

reg             [N-1:0] sel;
wire                    sel_en = en & (|valid);

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		sel <= {{(N-1){1'b0}}, 1'b1};
	else if (sel_en)
		sel <= {grant[N-2:0], grant[N-1]};
end

atcaxi2tluh500_mux_onehot #(
	.N	(N		),
	.W	(N		)
) u_grant (
	.out	(grant		),
	.sel	(sel		),
	.in	(grant_all	)
);

atcaxi2tluh500_mux_onehot #(
	.N	(N		),
	.W	(N		)
) u_ready (
	.out	(ready		),
	.sel	(sel		),
	.in	(ready_all	)
);

generate
genvar i;
for (i=0; i<N; i=i+1) begin : gen_ent
	wire	[N-1:0]		fp_valid = validx2[i+:N];	// right rotate 
	wire	[N-1:0]		fp_ready;
	wire	[N-1:0]		fp_grant;
	wire	[N*2-1:0]	fp_readyx2 = {fp_ready, fp_ready};
	wire	[N*2-1:0]	fp_grantx2 = {fp_grant, fp_grant};

	atcaxi2tluh500_arb_fp #(
		.N	(N		)
	) u_arb_fp (
		.valid	(fp_valid	),
		.ready	(fp_ready	),
		.grant	(fp_grant	)
	);

	assign ready_all[i*N+:N] = fp_readyx2[N-i+:N];
	assign grant_all[i*N+:N] = fp_grantx2[N-i+:N];

end
endgenerate

`ifdef OVL_ASSERT_ON
// pragma coverage off
wire one_hot_chk_enable = (|valid);
ovl_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (N          )
) u_one_hot_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (one_hot_chk_enable     ),
    .test_expr  (grant                  ),
    .fire       (                       )
);
// pragma coverage on
`endif // OVL_ASSERT_ON

endmodule

