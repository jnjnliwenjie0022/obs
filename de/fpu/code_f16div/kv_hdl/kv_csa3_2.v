//-------------------------------------------------
// [GIT2PVC INFO] 
// * BRANCH : vpu-next
// * SHA1 ID: 5499113acb4337f25811c177535e68a9fc523d7d
//-------------------------------------------------

module kv_csa3_2 (
    // VPERL: &PORTLIST
    // VPERL_GENERATED_BEGIN
    	  in0,      
    	  in1,      
    	  cin,      
    	  sum,      
    	  cout      
    // VPERL_GENERATED_END
);

parameter   CSA_WIDTH = 32;

integer     i;

input   [CSA_WIDTH-1:0] in0;
input   [CSA_WIDTH-1:0] in1;
input   [CSA_WIDTH-1:0] cin;

output  [CSA_WIDTH-1:0] sum;
output  [CSA_WIDTH-1:0] cout;

reg     [CSA_WIDTH-1:0] sum;
reg     [CSA_WIDTH-1:0] cout;

always @(in0 or in1 or cin) begin
    for (i = 0; i < CSA_WIDTH; i= i+1) begin
	cout[i] = (in0[i] & in1[i]) | (in0[i] & cin[i]) | (in1[i] & cin[i]);//carry
	sum[i]  = (in0[i]^in1[i]^cin[i]); //sum	
    end
end

endmodule
