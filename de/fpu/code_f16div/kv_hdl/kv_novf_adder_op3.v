// This module is a three input adder without overflow for SpyGlass check
module kv_novf_adder_op3 (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  op1,        
        	  op2,        
        	  op3,        
        	  sum         
        // VPERL_GENERATED_END
);

parameter	EW = 32;
localparam	CW = 2;

input	[(EW-1):0]	op1;
input	[(EW-1):0]	op2;
input	[(EW-1):0]	op3;
output	[(EW-1):0]	sum;
wire	[(CW-1):0]	nds_unused_c;

assign {nds_unused_c,sum} = op1 + op2 + op3;

endmodule
