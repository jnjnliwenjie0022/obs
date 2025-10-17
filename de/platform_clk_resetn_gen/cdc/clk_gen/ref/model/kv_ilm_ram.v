module kv_ilm_ram(
	// VPERL: &PORTLIST;
	// VPERL_GENERATED_BEGIN
		  clk,      
		  ilm_cs,   
		  ilm_we,   
		  ilm_addr, 
		  ilm_byte_we,
		  ilm_wdata,
		  ilm_rdata,
		  ilm_ctrl_in,
		  ilm_ctrl_out 
	// VPERL_GENERATED_END
);
parameter ILM_RAM_AW   = 11;
parameter ILM_RAM_DW   = 64;
parameter ILM_RAM_BWEW = 8;
parameter ILM_RAM_CTRL_IN_WIDTH = 1;
parameter ILM_RAM_CTRL_OUT_WIDTH = 1;

input                                     clk;
input                                     ilm_cs;
input                                     ilm_we;
input                  [(ILM_RAM_AW-1):0] ilm_addr;
input                [(ILM_RAM_BWEW-1):0] ilm_byte_we;
input                  [(ILM_RAM_DW-1):0] ilm_wdata;
output                 [(ILM_RAM_DW-1):0] ilm_rdata;
input       [(ILM_RAM_CTRL_IN_WIDTH-1):0] ilm_ctrl_in;
output     [(ILM_RAM_CTRL_OUT_WIDTH-1):0] ilm_ctrl_out;

nds_ram_model_bwe #(
	.ADDR_WIDTH (ILM_RAM_AW),
	.DATA_BYTE  (ILM_RAM_BWEW) 
) ram_inst (
	.clk (clk      ),
	.cs  (ilm_cs   ),
	.bwe (ilm_byte_we),
	.addr(ilm_addr ),
	.din (ilm_wdata),
	.dout(ilm_rdata ) 
); // end of ilm

wire nds_unused_ilm_ctrl_in = |ilm_ctrl_in;
assign ilm_ctrl_out = {ILM_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule

