module atctlc2axi500_burst_arb (
    // VPERL: &PORTLIST;
    // VPERL_GENERATED_BEGIN
    	  clk,      
    	  resetn,   
    	  valids,   
    	  readys,   
    	  lasts,    
    	  grants,   
    	  valid,    
    	  ready     
    // VPERL_GENERATED_END
);
parameter N = 2;

input          clk;
input          resetn;
input  [N-1:0] valids;
output [N-1:0] readys;
input  [N-1:0] lasts;
output [N-1:0] grants;
output         valid;
input          ready;

reg  [N-1:0] ready_mask;
reg  [N-1:0] burst_mask;
wire         burst_mask_en;
wire [N-1:0] burst_mask_nx;
wire [N-1:0] valids_masked;
wire         last;

integer i;

assign last = |(grants & lasts);
assign grants = valids_masked & ready_mask;

assign burst_mask_en = valid & ready;
assign burst_mask_nx = grants | {N{last}};

always @(posedge clk or negedge resetn) begin
    if(!resetn)begin
        burst_mask <= {N{1'b1}};
    end
    else if(burst_mask_en)begin
        burst_mask <= burst_mask_nx;
    end
end

assign valids_masked = valids & burst_mask;
assign valid  = |valids_masked;

always @* begin
    ready_mask[0] = 1'b1;
    for (i=1; i<N; i=i+1) begin
        ready_mask[i] = ready_mask[i-1] & ~valids_masked[i-1];
    end
end
assign readys = ready_mask & {N{ready}} & burst_mask;
//------------------------------------
//assertions
//------------------------------------
`ifdef OVL_ASSERT_ON
// pragma coverage off

ovl_always 
#(
    .property_type  (`OVL_ASSERT    ),
    .severity_level (`OVL_FATAL     ),
    .msg            (`__FILE__      )
) 
u_ovl_ready_mask_bit0 (
    .clock      ( clk           ),
    .reset      ( resetn        ),
    .enable     ( 1'b1          ),
    .test_expr  ( ready_mask[0] ),
    .fire       (               )
);

// pragma coverage on
`endif // OVL_ASSERT_ON

endmodule

