`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_apbslv( //VPERL: &PORTLIST;
                          // VPERL_GENERATED_BEGIN
                          	  pclk,     
                          	  presetn,  
                          	  paddr,    
                          	  psel,     
                          	  penable,  
                          	  pwrite,   
                          	  pwdata,   
                          	  pready,   
                          	  prdata,   
                          	  pslverr,  
                          	  cmd_buff_wr,
                          	  cmd_buff_wdata,
                          	  cmd_buff_full,
                          	  rdata_buff_rd,
                          	  rdata_buff_rdata,
                          	  rdata_buff_empty 
                          // VPERL_GENERATED_END
);

// APB bus interface
input		pclk;
input		presetn;
input	[31:0]	paddr;
input		psel;
input		penable;
input		pwrite;
input	[31:0]	pwdata;
output		pready;
output	[31:0]	prdata;
output		pslverr;
// CMD Buffer and RDATA buffer
output		cmd_buff_wr;
output	[39:0]	cmd_buff_wdata;
input		cmd_buff_full;
output		rdata_buff_rd;
input	[31:0] 	rdata_buff_rdata;
input		rdata_buff_empty;

reg		rdata_not_ready;
reg		apb_cmd_valid_d1;
wire		apb_cmd_valid;
wire		apb_rd_cmd_valid;
wire		rdata_not_ready_nx;

assign	apb_cmd_valid		=   psel 	  && (!penable);
assign	apb_rd_cmd_valid	=   apb_cmd_valid && (!pwrite);
assign	cmd_buff_wr		=   apb_cmd_valid && (!cmd_buff_full);
assign	cmd_buff_wdata		=  {pwrite, paddr[8:2], pwdata};
assign	rdata_buff_rd		=  !rdata_buff_empty;
assign	prdata			=   rdata_buff_rdata;
assign	rdata_not_ready_nx	=  (apb_rd_cmd_valid || rdata_not_ready) && rdata_buff_empty;
assign	pready			= !(cmd_buff_full    || rdata_not_ready  || apb_cmd_valid_d1);
assign	pslverr			=   1'b0;

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		rdata_not_ready     <= 1'b0;
		apb_cmd_valid_d1    <= 1'b0;
	end
	else begin
		rdata_not_ready     <= rdata_not_ready_nx;
		apb_cmd_valid_d1    <= apb_cmd_valid;
	end
end

endmodule
