// Generated DFF
	
module atcaxi2tluh500_dff (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  clk,      // spyglass disable W240 Input '*' declared but not read
        	  resetn,   // spyglass disable W240 Input '*' declared but not read
        	  en,       // spyglass disable W240 Input '*' declared but not read
        	  d,        // spyglass disable W240 Input '*' declared but not read
        	  q         // spyglass disable W240 Input '*' declared but not read
        // VPERL_GENERATED_END
);
parameter R = 0;
parameter W = 8;

input			clk;	// spyglass disable W240 Input '*' declared but not read
input			resetn;	// spyglass disable W240 Input '*' declared but not read
input			en;	// spyglass disable W240 Input '*' declared but not read
input           [W-1:0] d;	// spyglass disable W240 Input '*' declared but not read
output          [W-1:0] q;	// spyglass disable W240 Input '*' declared but not read

generate
if (R) begin : gen_dff_w_reset
	reg [W-1:0] reg_q;
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			reg_q <= {(W){1'b0}};
		else if (en)
			reg_q <= d;
	end

	assign q = reg_q;

end
else begin : gen_dff_wo_reset
	wire nds_unused_resetn = resetn;
	reg [W-1:0] reg_q;
	always @(posedge clk) begin
		if (en)
			reg_q <= d;
	end
	assign q = reg_q;
end
endgenerate

endmodule

