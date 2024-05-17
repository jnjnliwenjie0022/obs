//-------------------------------------------------
// [GIT2PVC INFO] 
// * BRANCH : vpu-next
// * SHA1 ID: 5499113acb4337f25811c177535e68a9fc523d7d
//-------------------------------------------------

module kv_csa4_2 (
    // VPERL: &PORTLIST
    // VPERL_GENERATED_BEGIN
    	  in1,      
    	  in2,      
    	  in3,      
    	  in4,      
    	  sum,      
    	  carry     
    // VPERL_GENERATED_END
);

parameter   CSA_WIDTH = 32;

input   [CSA_WIDTH-1:0] in1;
input   [CSA_WIDTH-1:0] in2;
input   [CSA_WIDTH-1:0] in3;
input   [CSA_WIDTH-1:0] in4;

output  [CSA_WIDTH  :0] sum;
output  [CSA_WIDTH-1:0] carry;

wire    [CSA_WIDTH-1:0] carry_tmp;

assign carry_tmp = (in1 & in2) | (in1 & in3) | (in2 & in3);
assign sum       = {carry_tmp[CSA_WIDTH-1], in1 ^ in2 ^ in3 ^ in4 ^ {carry_tmp[CSA_WIDTH-2:0], 1'b0}};
assign carry     = ((in1 ^ in2 ^ in3) & in4) | ((in1 ^ in2 ^ in3) & {carry_tmp[CSA_WIDTH-2:0], 1'b0}) | (in4 & {carry_tmp[CSA_WIDTH-2:0], 1'b0});

endmodule
