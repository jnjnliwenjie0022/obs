// generate N:1 clock and clock enable
// N: 2 ~ 4 

module kv_clk_gen (
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

generate
if (RATIO == 1) begin : gen_ratio_1
	assign clk_en = 1'b1;
	assign clk_out = clk_in;
end
else if (RATIO == 2) begin : gen_ratio_2
	reg     cnt;
	always @(posedge clk_in or negedge resetn) begin
		if (!resetn)
			cnt <= 1'b0;
		else
			cnt <= ~cnt;
	end
	assign clk_en = ~cnt;
	assign clk_out = cnt;
end
else if (RATIO == 3) begin : gen_ratio_3
	reg	[1:0]		cnt;
	wire	[1:0]		cnt_nx;
	always @(posedge clk_in or negedge resetn) begin
		if (!resetn)
			cnt <= 2'b0;
		else
			cnt <= cnt_nx;
	end
	assign cnt_nx = (cnt == 2'b10) ? 2'b00 : cnt + 2'b1;
	assign clk_en = cnt[1];
	assign clk_out = clk_en;
end
else begin : gen_ratio_others
	reg	[2:0]	cnt;
	wire	[2:0]	cnt_nx;

	always @(posedge clk_in or negedge resetn) begin
		if (!resetn)
			cnt <= 2'b0;
		else
			cnt <= cnt_nx;
	end
	assign cnt_nx = cnt + 2'b1;
	assign clk_en = (cnt[1:0] == 2'b11);
	assign clk_out = cnt[2]; 
end
endgenerate

endmodule

