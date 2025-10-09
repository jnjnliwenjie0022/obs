//    Copyright 2006 Andes Technology Corp. - All Rights Reserved.    //


module gck (clk_out, clk_en, clk_in, test_en);

input clk_in;
input clk_en;
input test_en;

output clk_out;


reg latch_out;

always @(clk_in or clk_en or test_en)
	if (~clk_in)
		latch_out <= clk_en | test_en;

assign clk_out = clk_in & latch_out;

endmodule
