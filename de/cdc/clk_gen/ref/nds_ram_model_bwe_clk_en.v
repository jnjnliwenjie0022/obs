//
// Generic synchronous SRAM model with byte-write-enable with clk_en
//
// bwe is high-active. (bwe == 0) indicates a read request.
//

module nds_ram_model_bwe_clk_en (
	clk_en,
	clk,
	cs,
	bwe,
	addr,
	din,
	dout
);
parameter ADDR_WIDTH		= 5;
parameter DATA_BYTE		= 4;
parameter OUT_DELAY		= 0;
parameter [0:0]	HOLD_DOUT	= 1'b1;
parameter ENABLE		= "yes";
parameter BIT_PER_BYTE		= 8;	// To support parity

// Derived parameters
localparam DATA_WIDTH		= DATA_BYTE * BIT_PER_BYTE;

input				clk_en;
input				clk;
input				cs;
input [(DATA_BYTE-1):0]		bwe;
input [(ADDR_WIDTH-1):0]	addr;
input [(DATA_WIDTH-1):0]	din;
output [(DATA_WIDTH-1):0]	dout;

wire				gated_clk;

gck gck0(
	.clk_out		(gated_clk		),
	.clk_en			(clk_en			),
	.clk_in			(clk			),
	.test_en		(1'b0			)
);

nds_ram_model_bwe #(
	.ADDR_WIDTH		(ADDR_WIDTH		),
	.DATA_BYTE		(DATA_BYTE		),
	.OUT_DELAY		(OUT_DELAY		),
	.HOLD_DOUT		(HOLD_DOUT		),
	.ENABLE			(ENABLE			),
	.BIT_PER_BYTE		(BIT_PER_BYTE		)
) ram (
	.clk			(gated_clk		),
	.cs			(cs			),
	.bwe			(bwe			),
	.addr			(addr			),
	.din			(din			),
	.dout			(dout			)
);

endmodule
