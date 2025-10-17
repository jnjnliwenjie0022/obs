// commom module for zero-extension with parameters
module atcaxi2tluh500_zero_ext #(
	parameter	OW = 8,
	parameter	IW = 8
) (
	output	[OW-1:0]	out,
	input	[IW-1:0]	in
);

assign out[IW-1:0] = in[IW-1:0];

generate
if (OW>IW) begin : gen_msbs
	assign out[OW-1:IW] = {(OW-IW){1'b0}};
end
endgenerate

endmodule

