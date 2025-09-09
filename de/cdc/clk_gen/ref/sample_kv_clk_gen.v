// generate N:1 clock and clock enable
// N: 1 ~ 2
 
module sample_kv_clk_gen (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  clk_in,      
        	  resetn,      
        	  clk_en,
		  clk_out
        // VPERL_GENERATED_END
);
 
parameter RATIO = 1; // 1~4
 
input			clk_in;
input			resetn;
output			clk_en;
output			clk_out;
 
wire			clk_temp;
 
generate
if (RATIO == 1) begin : gen_ratio_1
	assign clk_en = 1'b1;
	assign clk_temp = clk_in;
end
else /*if (RATIO == 2)*/ begin : gen_ratio_2
	reg     cnt;
	reg	clk_en_r;
	always @(posedge clk_in or negedge resetn) begin
		if (!resetn)
			cnt = 1'b0;
		else
			cnt = ~cnt;
	end
 
	always @(posedge clk_in or negedge resetn) begin
		if (!resetn)
			clk_en_r <= 1'b1;
		else
			clk_en_r <= ~clk_en_r;
	end
	assign clk_temp = cnt;
	assign clk_en   = clk_en_r;
end
endgenerate
 
`ifdef NDS_FPGA 
	BUFGCE	TL_UL_CLK_MUX_INST (
		.I	(clk_temp		),
		.CE	(1'b1			),
		.O	(clk_out		)
	);
`else
	assign clk_out = clk_temp;
`endif
 
endmodule
