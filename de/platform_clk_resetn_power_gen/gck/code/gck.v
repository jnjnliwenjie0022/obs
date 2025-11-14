////////////////////////////////////////////////////////////////////////
//                                                                    //
//                                                                    //
//    Andes Technology Corp. Confidential                             //
//    Copyright 2006 Andes Technology Corp. - All Rights Reserved.    //
//                                                                    //
//    Design: gck.v                                                   //
//    Designer: Leon Chang                                            //
//    Function: Gated clock module                                    //
//                                                                    //
////////////////////////////////////////////////////////////////////////


module gck (clk_out, clk_en, clk_in, test_en);

parameter BYPASS_CLKEN_IN_FPGA = 0;
`ifdef NDS_FPGA
(* gated_clock = "true" *) input clk_in;        // clock input
`else //!NDS_FPGA
input clk_in;        // clock input
`endif //!NDS_FPGA
input clk_en;        // clock enable
input test_en;       // test_enable

output clk_out;      // clock output


reg latch_out;

always @(clk_in or clk_en or test_en)
	if (~clk_in)
		latch_out <= clk_en | test_en;

generate
if (BYPASS_CLKEN_IN_FPGA) begin: gen_bypass_clk_en
	`ifdef NDS_FPGA
	assign clk_out = clk_in;
	`else
	assign clk_out = clk_in & latch_out;
	`endif
end
else begin: gen_nobypass_clk_en
	// clock gating occurs at the negedge of clk_in.
	assign clk_out = clk_in & latch_out;
end
endgenerate

endmodule   
