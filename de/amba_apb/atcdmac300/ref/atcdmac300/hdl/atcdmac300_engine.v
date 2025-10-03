`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_engine ( //VPERL: &PORTLIST
                           // VPERL_GENERATED_BEGIN
                           `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  dma_mst1_req,
                           	  dma_mst1_addr,
                           	  dma_mst1_write,
                           	  dma_mst1_size,
                           	  dma_mst1_fix,
                           	  dma_mst1_wdata,
                           	  dma_mst1_len,
                           	  mst1_dma_grant,
                           	  mst1_dma_rd_ack,
                           	  mst1_dma_wr_ack,
                           	  mst1_dma_rdata,
                           	  mst1_dma_rlast,
                           	  mst1_dma_bvalid,
                           	  mst1_dma_error,
                           `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  dma_mst0_req,
                           	  dma_mst_wr_mask,
                           	  dma_mst0_addr,
                           	  dma_mst0_write,
                           	  dma_mst0_size,
                           	  dma_mst0_fix,
                           	  dma_mst0_wdata,
                           	  dma_mst0_len,
                           	  mst0_dma_grant,
                           	  mst0_dma_rd_ack,
                           	  mst0_dma_wr_ack,
                           	  mst0_dma_rdata,
                           	  mst0_dma_rlast,
                           	  mst0_dma_bvalid,
                           	  mst0_dma_error,
                           	  idle_state,
                           	  arb_end,  
                           	  ch_src_addr_ctl,
                           	  ch_dst_addr_ctl,
                           	  ch_src_width,
                           	  ch_dst_width,
                           	  ch_src_burst_size,
                           	  ch_src_mode,
                           	  ch_src_request,
                           	  ch_dst_mode,
                           	  ch_dst_request,
                           	  ch_tts,   
                           	  ch_src_addr,
                           	  ch_dst_addr,
                           	  ch_int_tc_mask,
                           	  ch_int_err_mask,
                           	  ch_int_abt_mask,
                           `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  ch_src_bus_inf_idx,
                           	  ch_dst_bus_inf_idx,
                           `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                           	  ch_llp,   
                              `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  ch_lld_bus_inf_idx,
                              `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                           	  ch_abt,   
                           	  dma_ch_src_ack,
                           	  dma_ch_dst_ack,
                           	  dma_ch_ctl_wen,
                           	  dma_ch_en_wen,
                           	  dma_ch_src_addr_wen,
                           	  dma_ch_dst_addr_wen,
                           `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                           	  dma_ch_llp_wen,
                           `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                           	  dma_ch_tts_wen,
                           	  dma_ch_tc_wen,
                           	  dma_ch_err_wen,
                           	  dma_ch_int_wen,
                           	  dma_ch_ctl_wdata,
                           	  dma_ch_ctl_wdata_pri,
                           `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  dma_ch_ctl_wdata_idx,
                           `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  dma_ch_tts_wdata,
                           	  dma_ch_src_addr_wdata,
                           	  dma_ch_dst_addr_wdata,
                           `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                           	  dma_ch_llp_wdata,
                              `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  dma_ch_llp_wdata_idx,
                              `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                           	  aclk,     
                           	  aresetn,  
                           	  dma_soft_reset 
                           // VPERL_GENERATED_END
);
localparam	ADDR_MSB	= `ATCDMAC300_ADDR_WIDTH - 1;
localparam	TTS_MSB		= `ATCDMAC300_TTS_WIDTH - 1;
localparam	ADDR_WEN_MSB	= ADDR_MSB > 31 ? 1 : 0;

localparam	ST_IDLE		= 3'b000;
localparam	ST_READ		= 3'b001;
localparam	ST_READ_ACK	= 3'b010;
localparam	ST_WRITE	= 3'b011;
localparam	ST_WRITE_ACK	= 3'b100;
localparam	ST_LL		= 3'b101;
localparam	ST_END		= 3'b110;

// AXI master interface
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma_mst1_req;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma_mst1_addr;
output					dma_mst1_write;
output	[2:0]				dma_mst1_size;
output					dma_mst1_fix;
output	[(`DMA_DATA_WIDTH-1):0]		dma_mst1_wdata;
output	[7:0]				dma_mst1_len;
input					mst1_dma_grant;
input					mst1_dma_rd_ack;
input					mst1_dma_wr_ack;
input	[(`DMA_DATA_WIDTH-1):0]		mst1_dma_rdata;
input                                   mst1_dma_rlast;
input                                   mst1_dma_bvalid;
input					mst1_dma_error;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT

output					dma_mst0_req;
output					dma_mst_wr_mask;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma_mst0_addr;
output					dma_mst0_write;
output	[2:0]				dma_mst0_size;
output					dma_mst0_fix;
output	[(`DMA_DATA_WIDTH-1):0]		dma_mst0_wdata;
output	[7:0]				dma_mst0_len;
input					mst0_dma_grant;
input					mst0_dma_rd_ack;
input					mst0_dma_wr_ack;
input	[(`DMA_DATA_WIDTH-1):0]		mst0_dma_rdata;
input                                   mst0_dma_rlast;
input                                   mst0_dma_bvalid;
input					mst0_dma_error;

// Channel mux interface
	// Arbiter interface
output					idle_state;
input 					arb_end;
	// Channel information
input	[1:0]				ch_src_addr_ctl;
input	[1:0]				ch_dst_addr_ctl;
input	[2:0]				ch_src_width;
input	[2:0]				ch_dst_width;
input	[3:0]				ch_src_burst_size;
input					ch_src_mode;
input					ch_src_request;
input					ch_dst_mode;
input					ch_dst_request;
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_tts;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_dst_addr;
input					ch_int_tc_mask;
input					ch_int_err_mask;
input					ch_int_abt_mask;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_src_bus_inf_idx;
input					ch_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT

`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_llp;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_lld_bus_inf_idx;
	`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`else
wire	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_llp = {`ATCDMAC300_ADDR_WIDTH-3{1'b0}};
wire					ch_lld_bus_inf_idx = 1'b0;
`endif
input					ch_abt;
output					dma_ch_src_ack;
output					dma_ch_dst_ack;
output					dma_ch_ctl_wen;
output					dma_ch_en_wen;
output	[ADDR_WEN_MSB:0]		dma_ch_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma_ch_dst_addr_wen;
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma_ch_llp_wen;
`endif
output					dma_ch_tts_wen;
output					dma_ch_tc_wen;
output					dma_ch_err_wen;
output					dma_ch_int_wen;
output	[27:1]				dma_ch_ctl_wdata;
output					dma_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output	[1:0]				dma_ch_ctl_wdata_idx;
`endif
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma_ch_tts_wdata;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma_ch_src_addr_wdata;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma_ch_dst_addr_wdata;
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma_ch_llp_wdata;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma_ch_llp_wdata_idx;
	`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`endif

input					aclk;
input					aresetn;
input					dma_soft_reset;

// fifo interface
reg	[(`ATCDMAC300_BYTE_OFFSET_WIDTH-1):0]	dma_fifo_byte_offset;
wire					dma_fifo_flush;
wire					dma_fifo_last_wr;
wire					dma_fifo_rd;
wire	[2:0]				dma_fifo_size;
wire	[(`DMA_DATA_WIDTH-1):0]		dma_fifo_wdata;
wire					dma_fifo_wr;
wire					dma_fifo_src_addr_dec;
wire					dma_fifo_dst_addr_dec;
wire	[(`DMA_DATA_WIDTH-1):0]		dma_fifo_rdata;

//-------------------------------------
//	Internal Signals
//-------------------------------------
//state related flags
wire					idle_state;
wire					read_state;
wire					write_state;
wire					end_state;
wire					read_end;
wire					write_end;
wire					ll_fetch_end;
reg	[2:0]				dma_state;
reg	[2:0]				dma_state_nxt;
reg					read_state_d1;
reg					write_state_d1;
wire					load_burst_counter;
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef ATCDMAC300_DATA_WIDTH_128
reg					llp_bit3;
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_256
reg	[1:0]				llp_bit4_3;
	`endif

reg					ll_state_d1;
reg					ll_state_bus_inf;
wire					chain_tc_off;
wire					ll_state;
`else
wire					llp_bit3 	 = 1'b0;
wire	[1:0]				llp_bit4_3 	 = 2'b0;
wire					ll_state_d1 	 = 1'b0;
wire					ll_state_bus_inf = 1'b0;
wire					chain_tc_off 	 = 1'b0;
wire					ll_state 	 = 1'b0;
`endif

//config related flags
reg					ch_int_tc_mask_reg;
reg					ch_int_err_mask_reg;
reg					ch_int_abt_mask_reg;
wire					invalid_config;
reg					invalid_config_reg;
wire					uneven_transfer;
wire					addr_unalign;
wire					reserved_src_width;
wire					reserved_dst_width;
wire					reserved_src_addr_ctl;
wire					reserved_dst_addr_ctl;
wire					reserved_src_burst_size;
wire					reserved_config;
wire					src_addr_inc;
wire					dst_addr_inc;
wire					src_addr_dec;
wire					dst_addr_dec;
wire					src_addr_fix;
wire					dst_addr_fix;
wire					src_width_byte;
wire					src_width_hword;
wire					src_width_word;
wire					src_width_double_word;
wire					src_width_quad_word;
wire					src_width_eight_word;
wire					dst_width_byte;
wire					dst_width_hword;
wire					dst_width_word;
wire					dst_width_double_word;
wire					dst_width_quad_word;
wire					dst_width_eight_word;
wire					byte_align_transfer;
wire					hword_align_transfer;
`ifdef 	ATCDMAC300_DATA_WIDTH_GE_64
wire					word_align_transfer;
`else  
wire					word_align_transfer = 1'b0;
`endif  
`ifdef 	ATCDMAC300_DATA_WIDTH_GE_128
wire					double_word_align_transfer;
`else
wire					double_word_align_transfer = 1'b0;
`endif
`ifdef 	ATCDMAC300_DATA_WIDTH_GE_256
wire					quad_word_align_transfer;
`else
wire					quad_word_align_transfer = 1'b0;
`endif

wire	[10:0]				src_burst_size_decode;
//DMA transfer related flags
reg					last_rd_data;
wire					last_rd_data_set;
wire					last_rd_data_clr;
wire					error_response;
reg					err_d1;
reg	[10:0]				burst_counter;

`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
reg	[2:0]				llp_counter;
wire	[2:0]				llp_counter_nxt;
`else
wire	[2:0]				llp_counter = 3'd0;
`endif

//control register related signals
wire	[ADDR_MSB:0]			incr_bytes;
wire	[ADDR_MSB:0]			decr_bytes;
wire	[ADDR_MSB:0]			dma_ch_addr_reg_wdata;
wire	[ADDR_MSB:0]			ch_next_addr;
wire	[31:0]				mst_dma_rdata_aligned;
wire					next_addr_decr;
wire					next_addr_fix;
wire	[10:0]				rd_wr_bytes;
reg	[8:0]				rd_wr_len;
wire	[8:0]				rd_wr_len_nx;
wire	[8:0]				rd_wr_len_sub_1;

wire					dma_mst_req;
reg	[ADDR_MSB:0]			dma_mst_addr;
wire	[ADDR_MSB:0]			dma_mst_addr_nx;
wire					dma_mst_write;
reg	[2:0]				dma_mst_size;
wire	[2:0]				dma_mst_size_nx;
reg					dma_mst_fix;
wire					dma_mst_fix_nx;
wire	[(`DMA_DATA_WIDTH-1):0]		dma_mst_wdata;
wire	[7:0]				dma_mst_len;
wire					mst_dma_grant;
reg					mst_dma_grant_d1;
wire					mst_dma_rd_ack;
wire					mst_dma_wr_ack;
wire	[(`DMA_DATA_WIDTH-1):0]		mst_dma_rdata;
wire					mst_dma_rlast;
wire					mst_dma_bvalid;
wire					mst_dma_error;

reg	[10:0]				fifo_bytes_remain;
reg	[10:0]				total_write_bytes;
wire	[10:0]				fifo_bytes_remain_nx;
wire	[10:0]				small_of_tts_burst_cnt;
wire	[10:0]				small_of_fifo_vs_reach_4k;
wire	[10:0]				small_of_all_len;
wire	[12:0]				reach_4k_bytes;
wire	[11:0]				rw_addr;
wire	[10:0]				rw_fifo_bytes;
wire	[ 2:0]				rw_size;
reg					total_write_bytes_zero;
reg					bvalid_waiting;
wire					bvalid_waiting_nx;

//-------------------------------------
//	Assignments
//-------------------------------------
assign	idle_state 		= (dma_state == ST_IDLE);
assign	read_state 		= (dma_state == ST_READ);
assign	write_state 		= (dma_state == ST_WRITE);
assign	end_state 		= (dma_state == ST_END);
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign	ll_state 		= (dma_state == ST_LL);
`endif

assign	dma_ch_src_ack		= (dma_state == ST_READ_ACK)  && ch_src_request;
assign	dma_ch_dst_ack		= (dma_state == ST_WRITE_ACK) && ch_dst_request;

assign	dma_mst_req		= (write_state && write_state_d1) ||
				  ( read_state &&  read_state_d1) || 
				  (   ll_state &&    ll_state_d1);
assign  dma_mst_wr_mask 	=  total_write_bytes_zero || bvalid_waiting;
assign	dma_mst_write		=  write_state;
assign	dma_mst_wdata		=  dma_fifo_rdata;
assign	dma_mst_addr_nx		=  ll_state ? {ch_llp[(`ATCDMAC300_ADDR_WIDTH-1):3],3'b0} : 
						       write_state ? ch_dst_addr          : ch_src_addr;
assign	dma_mst_size_nx		=  ll_state ?   3'h2 : write_state ? ch_dst_width         : ch_src_width;
assign	dma_mst_fix_nx		=  ll_state ?   1'b0 : write_state ? dst_addr_fix         : src_addr_fix;
assign  dma_mst_len     	=  ll_state ?   8'h7 : rd_wr_len_sub_1[7:0];
assign  rd_wr_len_sub_1		=  rd_wr_len  - 9'h1;
assign	error_response		=  mst_dma_error;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// output to axi master
reg	mst_bus_inf;
wire	mst_bus_inf_nx;
assign	mst_bus_inf_nx		=    ll_state ? ((llp_counter == 3'h0) ? ch_lld_bus_inf_idx : ll_state_bus_inf) :
				   read_state ?                          ch_src_bus_inf_idx : ch_dst_bus_inf_idx;
assign	dma_mst1_addr		=  dma_mst_addr;
assign	dma_mst1_write		=  dma_mst_write;
assign	dma_mst1_size		=  dma_mst_size;
assign	dma_mst1_fix		=  dma_mst_fix;
assign	dma_mst1_wdata		=  dma_mst_wdata;
assign	dma_mst1_len		=  dma_mst_len;
assign	dma_mst0_addr		=  dma_mst_addr;
assign	dma_mst0_write		=  dma_mst_write;
assign	dma_mst0_size		=  dma_mst_size;
assign	dma_mst0_fix		=  dma_mst_fix;
assign	dma_mst0_wdata		=  dma_mst_wdata;
assign	dma_mst0_len		=  dma_mst_len;
assign	dma_mst1_req		=  mst_bus_inf && dma_mst_req;
assign	dma_mst0_req		= !mst_bus_inf && dma_mst_req;
assign	mst_dma_grant		=  mst_bus_inf ? mst1_dma_grant  : mst0_dma_grant;
assign	mst_dma_rd_ack		=  mst_bus_inf ? mst1_dma_rd_ack : mst0_dma_rd_ack;
assign	mst_dma_wr_ack		=  mst_bus_inf ? mst1_dma_wr_ack : mst0_dma_wr_ack;
assign	mst_dma_rdata		=  mst_bus_inf ? mst1_dma_rdata  : mst0_dma_rdata;
assign	mst_dma_error		=  mst_bus_inf ? mst1_dma_error  : mst0_dma_error;
assign	mst_dma_rlast		=  mst_bus_inf ? mst1_dma_rlast  : mst0_dma_rlast;
assign	mst_dma_bvalid		=  mst_bus_inf ? mst1_dma_bvalid : mst0_dma_bvalid;

always @(posedge aclk or negedge aresetn)
	if (!aresetn)
		mst_bus_inf	<= 1'b0;
	else
		mst_bus_inf	<= mst_bus_inf_nx;

`else // ATCDMAC300_DUAL_MASTER_IF_SUPPORT

assign	dma_mst0_addr		=  dma_mst_addr;
assign	dma_mst0_write		=  dma_mst_write;
assign	dma_mst0_size		=  dma_mst_size;
assign	dma_mst0_fix		=  dma_mst_fix;
assign	dma_mst0_wdata		=  dma_mst_wdata;
assign	dma_mst0_len		=  dma_mst_len;

assign	dma_mst0_req		=  dma_mst_req;
assign	mst_dma_grant		=  mst0_dma_grant;
assign	mst_dma_rd_ack		=  mst0_dma_rd_ack;
assign	mst_dma_wr_ack		=  mst0_dma_wr_ack;
assign 	mst_dma_rdata		=  mst0_dma_rdata;
assign	mst_dma_error		=  mst0_dma_error;
assign	mst_dma_rlast		=  mst0_dma_rlast;
assign	mst_dma_bvalid		=  mst0_dma_bvalid;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT

//FIFO interface
assign	dma_fifo_flush 	     	=  err_d1;
assign	dma_fifo_rd		=  write_state  && mst_dma_wr_ack;
assign	dma_fifo_wr		=  read_state   && mst_dma_rd_ack;
assign 	dma_fifo_last_wr 	=  last_rd_data && mst_dma_rlast;
assign	dma_fifo_size		=  read_state ? ch_src_width : ch_dst_width;
assign	dma_fifo_wdata		=  mst_dma_rdata;
assign 	dma_fifo_src_addr_dec 	=  src_addr_dec;
assign 	dma_fifo_dst_addr_dec 	=  dst_addr_dec;

//channel control register interface
assign	mst_dma_rdata_aligned	=
`ifdef ATCDMAC300_DATA_WIDTH_64
				              llp_counter[0] 		   ?	mst_dma_rdata[63:32] :
`endif
`ifdef ATCDMAC300_DATA_WIDTH_128
				   ({llp_bit3,llp_counter[1:0]} == 3'b001) ?	mst_dma_rdata[ 63:32] :
				   ({llp_bit3,llp_counter[1:0]} == 3'b010) ?	mst_dma_rdata[ 95:64] :
				   ({llp_bit3,llp_counter[1:0]} == 3'b011) ?	mst_dma_rdata[127:96] :
				   ({llp_bit3,llp_counter[1:0]} == 3'b100) ?	mst_dma_rdata[ 95:64] :
				   ({llp_bit3,llp_counter[1:0]} == 3'b101) ?	mst_dma_rdata[127:96] :
				   ({llp_bit3,llp_counter[1:0]} == 3'b110) ?	mst_dma_rdata[ 31: 0] :
				   ({llp_bit3,llp_counter[1:0]} == 3'b111) ?	mst_dma_rdata[ 63:32] : 
`endif
`ifdef ATCDMAC300_DATA_WIDTH_256

				   ({llp_bit4_3,llp_counter[2:0]} == 5'b00001) ?	mst_dma_rdata[ 63: 32] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b00010) ?	mst_dma_rdata[ 95: 64] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b00011) ?	mst_dma_rdata[127: 96] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b00100) ?	mst_dma_rdata[159:128] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b00101) ?	mst_dma_rdata[191:160] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b00110) ?	mst_dma_rdata[223:192] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b00111) ?	mst_dma_rdata[255:224] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b01000) ?	mst_dma_rdata[ 95: 64] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b01001) ?	mst_dma_rdata[127: 96] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b01010) ?	mst_dma_rdata[159:128] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b01011) ?	mst_dma_rdata[191:160] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b01100) ?	mst_dma_rdata[223:192] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b01101) ?	mst_dma_rdata[255:224] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b01110) ?	mst_dma_rdata[ 31:  0] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b01111) ?	mst_dma_rdata[ 63: 32] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b10000) ?	mst_dma_rdata[159:128] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b10001) ?	mst_dma_rdata[191:160] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b10010) ?	mst_dma_rdata[223:192] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b10011) ?	mst_dma_rdata[255:224] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b10100) ?	mst_dma_rdata[ 31:  0] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b10101) ?	mst_dma_rdata[ 63: 32] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b10110) ?	mst_dma_rdata[ 95: 64] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b10111) ?	mst_dma_rdata[127: 96] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b11000) ?	mst_dma_rdata[223:192] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b11001) ?	mst_dma_rdata[255:224] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b11010) ?	mst_dma_rdata[ 31:  0] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b11011) ?	mst_dma_rdata[ 63: 32] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b11100) ?	mst_dma_rdata[ 95: 64] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b11101) ?	mst_dma_rdata[127: 96] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b11110) ?	mst_dma_rdata[159:128] :
				   ({llp_bit4_3,llp_counter[2:0]} == 5'b11111) ?	mst_dma_rdata[191:160] : 
`endif
				   							mst_dma_rdata[ 31:  0];

generate 
	if (ADDR_WEN_MSB == 1) begin : address_gt_32_wen
assign 	dma_ch_src_addr_wen[1]	= (ll_state && (llp_counter == 3'b011) && mst_dma_rd_ack) || (read_state  && mst_dma_grant_d1); 
assign 	dma_ch_dst_addr_wen[1]	= (ll_state && (llp_counter == 3'b101) && mst_dma_rd_ack) || (write_state && mst_dma_grant_d1); 
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign 	dma_ch_llp_wen[1]	= (ll_state && (llp_counter == 3'b111) && mst_dma_rd_ack);
	`endif
end
endgenerate

assign	dma_ch_en_wen		= end_state && ((!(|ch_tts)) || ch_abt || invalid_config_reg || err_d1 || chain_tc_off);
assign	dma_ch_ctl_wen		= (ll_state && (llp_counter == 3'b000) && mst_dma_rd_ack);
assign	dma_ch_tts_wen		= (ll_state && (llp_counter == 3'b001) && mst_dma_rd_ack) || (read_state  && mst_dma_grant_d1);
assign 	dma_ch_src_addr_wen[0]	= (ll_state && (llp_counter == 3'b010) && mst_dma_rd_ack) || (read_state  && mst_dma_grant_d1); 
assign 	dma_ch_dst_addr_wen[0] 	= (ll_state && (llp_counter == 3'b100) && mst_dma_rd_ack) || (write_state && mst_dma_grant_d1); 
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign 	dma_ch_llp_wen[0]	= (ll_state && (llp_counter == 3'b110) && mst_dma_rd_ack);
`endif
assign	dma_ch_tc_wen		= end_state && ((!(|ch_tts)) || chain_tc_off) && (!err_d1) && (!invalid_config_reg);
assign 	dma_ch_err_wen		= end_state && (err_d1 ||   invalid_config_reg);
assign 	dma_ch_int_wen		= (dma_ch_tc_wen       && (!ch_int_tc_mask_reg))  ||
				  (dma_ch_err_wen      && (!ch_int_err_mask_reg)) ||
				  (ch_abt && end_state && (!ch_int_abt_mask_reg));
assign	dma_ch_ctl_wdata	=  mst_dma_rdata_aligned[27:1];
assign	dma_ch_ctl_wdata_pri	=  mst_dma_rdata_aligned[29];
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
assign	dma_ch_ctl_wdata_idx	=  mst_dma_rdata_aligned[31:30];
`endif
assign	dma_ch_src_addr_wdata 	=  dma_ch_addr_reg_wdata;
assign	dma_ch_dst_addr_wdata 	=  dma_ch_addr_reg_wdata;
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
assign	dma_ch_llp_wdata_idx	=  mst_dma_rdata_aligned[0];
	`endif
generate
	if (ADDR_MSB < 32) begin : address_width_less_than_32
assign	dma_ch_llp_wdata[ADDR_MSB:3]	=  mst_dma_rdata_aligned[ADDR_MSB:3];
	end
	else begin : address_width_not_less_than_32
assign	dma_ch_llp_wdata[ADDR_MSB:32]	=  mst_dma_rdata_aligned[ADDR_MSB-32:0];
assign	dma_ch_llp_wdata[      31:3]	=  mst_dma_rdata_aligned[         31:3];
	end
endgenerate
`endif
assign	next_addr_decr		= ((read_state && src_addr_dec) || (write_state && dst_addr_dec));
assign	next_addr_fix		= ((read_state && src_addr_fix) || (write_state && dst_addr_fix));
assign	decr_bytes		= {{ADDR_MSB{1'b0}},1'b1} << dma_mst_size;
assign	incr_bytes		= next_addr_fix ? {`ATCDMAC300_ADDR_WIDTH{1'b0}} : {{ADDR_MSB-10{1'b0}},rd_wr_bytes};
assign	dma_ch_tts_wdata	= ll_state ? mst_dma_rdata_aligned[TTS_MSB:0] : (ch_tts - {{(`ATCDMAC300_TTS_WIDTH-9){1'b0}},rd_wr_len});
assign	ch_next_addr		= next_addr_decr ? (dma_mst_addr - decr_bytes) :  (dma_mst_addr + incr_bytes);

generate 
   if (ADDR_MSB > 31) begin : addr_width_gt_32
assign	dma_ch_addr_reg_wdata 	= ll_state ? (((llp_counter == 3'h2) || (llp_counter == 3'h4)) ? {{ADDR_MSB-31{1'b0}},mst_dma_rdata_aligned[31:0]}
                                                                                               : {mst_dma_rdata_aligned[ADDR_MSB-32:0],{32'b0}}
				             ) : ch_next_addr;
   end
   else begin : addr_width_not_gt_32
assign	dma_ch_addr_reg_wdata 	= ll_state ? mst_dma_rdata_aligned[ADDR_MSB:0] : ch_next_addr;
   end
endgenerate
assign	src_addr_inc		= (ch_src_addr_ctl == 2'b00);
assign	src_addr_dec		= (ch_src_addr_ctl == 2'b01);
assign	src_addr_fix		= (ch_src_addr_ctl == 2'b10);
assign	dst_addr_inc		= (ch_dst_addr_ctl == 2'b00);
assign	dst_addr_dec		= (ch_dst_addr_ctl == 2'b01);
assign	dst_addr_fix		= (ch_dst_addr_ctl == 2'b10);

assign	src_width_byte		= (ch_src_width == 3'b000);
assign	src_width_hword		= (ch_src_width == 3'b001);
assign	src_width_word		= (ch_src_width == 3'b010);
assign	src_width_double_word	= (ch_src_width == 3'b011);
assign	src_width_quad_word	= (ch_src_width == 3'b100);
assign	src_width_eight_word	= (ch_src_width == 3'b101);
assign	dst_width_byte		= (ch_dst_width == 3'b000);
assign	dst_width_hword		= (ch_dst_width == 3'b001);
assign	dst_width_word		= (ch_dst_width == 3'b010);
assign	dst_width_double_word	= (ch_dst_width == 3'b011);
assign	dst_width_quad_word	= (ch_dst_width == 3'b100);
assign	dst_width_eight_word	= (ch_dst_width == 3'b101);

assign	addr_unalign		=  (src_width_hword	  &&   ch_src_addr[  0])
				|| (dst_width_hword	  &&   ch_dst_addr[  0])
				|| (src_width_word	  && (|ch_src_addr[1:0]))
				|| (dst_width_word	  && (|ch_dst_addr[1:0]))
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				|| (src_width_double_word && (|ch_src_addr[2:0]))
				|| (dst_width_double_word && (|ch_dst_addr[2:0]))
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (src_width_quad_word	  && (|ch_src_addr[3:0]))
				|| (dst_width_quad_word	  && (|ch_dst_addr[3:0]))
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (src_width_eight_word  && (|ch_src_addr[4:0]))
				|| (dst_width_eight_word  && (|ch_dst_addr[4:0]))
`endif
`endif
`endif
				;

assign 	byte_align_transfer	=   src_width_byte        &&  (ch_tts[  0]           || (ch_src_burst_size == 4'h0));
assign 	hword_align_transfer	=  (src_width_byte        && ((ch_tts[1:0] == 2'h2 ) || (ch_src_burst_size == 4'h1)))
				|| (src_width_hword       &&  (ch_tts[  0]           || (ch_src_burst_size == 4'h0)));
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
assign	word_align_transfer	=  (src_width_byte        && ((ch_tts[2:0] == 3'h4 ) || (ch_src_burst_size == 4'h2)))
				|| (src_width_hword       && ((ch_tts[1:0] == 2'h2 ) || (ch_src_burst_size == 4'h1)))
				|| (src_width_word        &&  (ch_tts[  0]           || (ch_src_burst_size == 4'h0)));
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
assign	double_word_align_transfer = 
				   (src_width_byte        && ((ch_tts[3:0] == 4'h8 ) || (ch_src_burst_size == 4'h3)))
				|| (src_width_hword       && ((ch_tts[2:0] == 3'h4 ) || (ch_src_burst_size == 4'h2)))
				|| (src_width_word        && ((ch_tts[1:0] == 2'h2 ) || (ch_src_burst_size == 4'h1)))
				|| (src_width_double_word &&  (ch_tts[  0]           || (ch_src_burst_size == 4'h0)));
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
assign	quad_word_align_transfer = 
				   (src_width_byte        && ((ch_tts[4:0] == 5'h10) || (ch_src_burst_size == 4'h4)))
				|| (src_width_hword       && ((ch_tts[3:0] == 4'h8 ) || (ch_src_burst_size == 4'h3)))
				|| (src_width_word        && ((ch_tts[2:0] == 3'h4 ) || (ch_src_burst_size == 4'h2)))
				|| (src_width_double_word && ((ch_tts[1:0] == 2'h2 ) || (ch_src_burst_size == 4'h1)))
				|| (src_width_quad_word   &&  (ch_tts[  0]           || (ch_src_burst_size == 4'h0)));
`endif
`endif
`endif

assign	uneven_transfer		=  (dst_width_hword       &&          byte_align_transfer)
				|| (dst_width_word        && (        byte_align_transfer 
                                                            ||       hword_align_transfer))
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				|| (dst_width_double_word && (        byte_align_transfer
                                                            ||       hword_align_transfer
                                                            ||        word_align_transfer))
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (dst_width_quad_word   && (        byte_align_transfer 
                                                            ||       hword_align_transfer
                                                            ||        word_align_transfer 
                                                            || double_word_align_transfer))
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (dst_width_eight_word  && (        byte_align_transfer 
                                                            ||       hword_align_transfer
                                                            ||        word_align_transfer 
                                                            || double_word_align_transfer 
                                                            ||   quad_word_align_transfer))
`endif
`endif
`endif
				;

assign	reserved_src_width 	= (ch_src_width == 3'h7) || (ch_src_width == 3'h6)
`ifdef ATCDMAC300_DATA_WIDTH_32
				|| src_width_eight_word  || src_width_quad_word || src_width_double_word
`endif
`ifdef ATCDMAC300_DATA_WIDTH_64
				|| src_width_eight_word  || src_width_quad_word
`endif
`ifdef ATCDMAC300_DATA_WIDTH_128
				|| src_width_eight_word
`endif
			 	;
assign	reserved_dst_width 	= (ch_dst_width    == 3'h7) || (ch_dst_width == 3'h6)
`ifdef ATCDMAC300_DATA_WIDTH_32
				|| dst_width_eight_word || dst_width_quad_word || dst_width_double_word
`endif
`ifdef ATCDMAC300_DATA_WIDTH_64
				|| dst_width_eight_word || dst_width_quad_word 
`endif
`ifdef ATCDMAC300_DATA_WIDTH_128
				|| dst_width_eight_word 
`endif
				;
assign	reserved_src_addr_ctl 	= (ch_src_addr_ctl == 2'b11);
assign	reserved_dst_addr_ctl 	= (ch_dst_addr_ctl == 2'b11);
assign	reserved_src_burst_size	= (ch_src_burst_size == 4'hb) || (ch_src_burst_size == 4'hc) || (ch_src_burst_size == 4'hd) || 
				  (ch_src_burst_size == 4'he) || (ch_src_burst_size == 4'hf);
assign 	reserved_config		= reserved_src_width || reserved_dst_width || reserved_src_addr_ctl || reserved_dst_addr_ctl ||
				  reserved_src_burst_size;
assign 	invalid_config		= read_state && (!read_state_d1) && ((!(|ch_tts)) || addr_unalign || uneven_transfer || reserved_config);

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		invalid_config_reg <= 1'b0;
	else
		invalid_config_reg <= invalid_config;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		dma_fifo_byte_offset	<= {`ATCDMAC300_BYTE_OFFSET_WIDTH{1'b0}};
	else if (dma_mst_req && mst_dma_grant)
		dma_fifo_byte_offset	<= dma_mst_addr[`ATCDMAC300_BYTE_OFFSET_WIDTH-1:0];
	else if ((mst_dma_wr_ack && write_state && dst_addr_inc) || (mst_dma_rd_ack && read_state && src_addr_inc))
		dma_fifo_byte_offset	<= dma_fifo_byte_offset + ({{`ATCDMAC300_BYTE_OFFSET_WIDTH-1{1'b0}},1'h1} << dma_mst_size);
end

assign	rw_size			  = read_state ? ch_src_width      : ch_dst_width;
assign	rw_addr			  = read_state ? ch_src_addr[11:0] : ch_dst_addr[11:0];
assign	rw_fifo_bytes		  = read_state ? fifo_bytes_remain : total_write_bytes;
assign	reach_4k_bytes		  = 13'h1000 - {1'b0,rw_addr};
assign	small_of_fifo_vs_reach_4k = ((reach_4k_bytes > {2'b0, rw_fifo_bytes}) ? rw_fifo_bytes : reach_4k_bytes[10:0]) >> rw_size;
assign	small_of_tts_burst_cnt	  = ((|ch_tts[31:11]) || (ch_tts[10:0] > burst_counter)) ? burst_counter : ch_tts[10:0];
assign	small_of_all_len	  = ( write_state     || (small_of_tts_burst_cnt > small_of_fifo_vs_reach_4k)) ? small_of_fifo_vs_reach_4k : 
                                                                                                                 small_of_tts_burst_cnt;
assign	rd_wr_len_nx		  = ((read_state && src_addr_dec) || (write_state && dst_addr_dec)) ? 9'h1   :
                                    (((read_state && src_addr_fix) || (write_state && dst_addr_fix)) && (|small_of_all_len[10:4])) ? 9'h10 :
                                    (|small_of_all_len[10:8])                                       ? 9'd256 :   small_of_all_len[8:0]; 
assign	rd_wr_bytes		  = {2'h0,rd_wr_len[8:0]} << (read_state ? ch_src_width : ch_dst_width); 
assign	bvalid_waiting_nx	  = ((write_state && mst_dma_grant) || bvalid_waiting) && (!mst_dma_bvalid);
assign	src_burst_size_decode	  = 11'b1 << ch_src_burst_size;
assign	load_burst_counter	  = idle_state && arb_end;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		burst_counter <= 11'b0;
	else if (load_burst_counter)
		burst_counter <= src_burst_size_decode;
	else if (read_state && mst_dma_grant)
		burst_counter <= burst_counter - {2'b0,rd_wr_len};
end

wire	load_fifo_bytes_remain	= (idle_state && arb_end) || (write_state && write_end);
assign	fifo_bytes_remain_nx	=  fifo_bytes_remain - rd_wr_bytes;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		fifo_bytes_remain <= 11'b0;
	else if (load_fifo_bytes_remain)
		fifo_bytes_remain <= `ATCDMAC300_FIFO_BYTE;
	else if (read_state && mst_dma_grant)
		fifo_bytes_remain <= fifo_bytes_remain_nx;
end

wire	load_total_write_bytes = (idle_state && arb_end) || (write_state && write_end);
always @(posedge aclk or negedge aresetn)
	if (!aresetn)
		total_write_bytes <= 11'b0;
	else if (dma_soft_reset || error_response)
		total_write_bytes <= 11'b0;  
	else if (read_state && mst_dma_grant)
		total_write_bytes <= total_write_bytes + rd_wr_bytes;
	else if (write_state && mst_dma_grant)
		total_write_bytes <= total_write_bytes - rd_wr_bytes;

`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign	llp_counter_nxt = llp_counter + 3'b1;
assign	chain_tc_off	= ll_state_d1 && (!ch_int_tc_mask_reg);

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		llp_counter	<= 3'b0;
	else if (dma_soft_reset || error_response)
		llp_counter	<= 3'b0;
	else if (ll_state && mst_dma_rd_ack)
		llp_counter	<= llp_counter_nxt;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		ll_state_d1	<= 1'b0;
	else if (dma_soft_reset)
		ll_state_d1	<= 1'b0;
	else
		ll_state_d1	<= ll_state;
end
`endif

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_int_tc_mask_reg 	<= 1'b0;
		ch_int_err_mask_reg 	<= 1'b0;
		ch_int_abt_mask_reg 	<= 1'b0;
	end
	else if (idle_state && arb_end) begin
		ch_int_tc_mask_reg	<= ch_int_tc_mask;
		ch_int_err_mask_reg	<= ch_int_err_mask;
		ch_int_abt_mask_reg	<= ch_int_abt_mask;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma_state 	<= ST_IDLE;
		read_state_d1	<= 1'b0;
		write_state_d1	<= 1'b0;
		err_d1		<= 1'b0;
	end
	else if (dma_soft_reset) begin
		dma_state 	<= ST_IDLE;
		read_state_d1	<= 1'b0;
		write_state_d1	<= 1'b0;
		err_d1		<= 1'b0;
	end
	else begin
		dma_state 	<= dma_state_nxt;
		read_state_d1	<= read_state;
		write_state_d1	<= write_state;
		err_d1		<= error_response;
	end
end
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
always @(posedge aclk or negedge aresetn)
	if (!aresetn)
		ll_state_bus_inf	<= 1'b0;
	else if (ll_state && mst_dma_grant)
		ll_state_bus_inf	<= ch_lld_bus_inf_idx;
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_128
always @(posedge aclk or negedge aresetn)
	if (!aresetn)
		llp_bit3		<= 1'b0;
	else if (ll_state && mst_dma_grant)
		llp_bit3		<= ch_llp[3];
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_256
always @(posedge aclk or negedge aresetn)
	if (!aresetn)
		llp_bit4_3		<= 2'b0;
	else if (ll_state && mst_dma_grant)
		llp_bit4_3		<= ch_llp[4:3];
	`endif
`endif

assign last_rd_data_clr = mst_dma_rlast || mst_dma_error;
assign last_rd_data_set = mst_dma_grant && 
		         (read_state    && (
					    (burst_counter 	  == {                           2'b0,rd_wr_len})
					||  (fifo_bytes_remain_nx == {                          11'b0             })
					||  (ch_tts 		  == {{`ATCDMAC300_TTS_WIDTH-9{1'b0}},rd_wr_len})
					   ));

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		last_rd_data 		<= 1'b0;
		bvalid_waiting		<= 1'b0;
		rd_wr_len		<= 9'b0;
		dma_mst_addr		<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		dma_mst_size		<= 3'b0;
		dma_mst_fix		<= 1'b0;
		total_write_bytes_zero	<= 1'b0;
		mst_dma_grant_d1	<= 1'b0;
	end
	else begin
		last_rd_data		<= last_rd_data_set || (last_rd_data && (!last_rd_data_clr));
		bvalid_waiting		<= bvalid_waiting_nx;
		rd_wr_len		<= rd_wr_len_nx;
		dma_mst_addr		<= dma_mst_addr_nx;
		dma_mst_size		<= dma_mst_size_nx;
		dma_mst_fix		<= dma_mst_fix_nx;
		total_write_bytes_zero	<= (total_write_bytes == 11'h0);
		mst_dma_grant_d1	<= mst_dma_grant;
	end
end
assign read_end		=  last_rd_data && mst_dma_rlast;
assign write_end	=  total_write_bytes_zero && mst_dma_bvalid;
assign ll_fetch_end 	= (llp_counter == 3'b111) && mst_dma_rd_ack;

always @(*) begin
	case(dma_state)
		ST_READ: begin
			dma_state_nxt = (invalid_config || error_response) 	? ST_END	: 
					(!read_end) 				? ST_READ	:
					( ch_src_mode && ((!(|burst_counter)) || (!(|ch_tts))))	? ST_READ_ACK	: ST_WRITE;
		end
		ST_READ_ACK: begin
			dma_state_nxt = ch_src_request 				? ST_READ_ACK	: ST_WRITE;
		end
		ST_WRITE: begin
			dma_state_nxt = error_response 				? ST_END	:
					(!write_end)   				? ST_WRITE	:
					((|burst_counter) && (|ch_tts))		? ST_READ	:
					( ch_dst_mode && ((!(|burst_counter)) || (!(|ch_tts))))	? ST_WRITE_ACK	:
					((!(|ch_tts)) && (|ch_llp[(`ATCDMAC300_ADDR_WIDTH-1):3]))
										? ST_LL 	: ST_END;
		end
		ST_WRITE_ACK: begin
			dma_state_nxt = ch_dst_request 				? ST_WRITE_ACK	: 
					((!(|ch_tts)) && (|ch_llp[(`ATCDMAC300_ADDR_WIDTH-1):3]))
										? ST_LL		: ST_END;
		end
		ST_LL: begin
			dma_state_nxt = (!ll_fetch_end)				? ST_LL		:
					(error_response || ch_abt)		? ST_END	: ST_IDLE;
		end
		ST_END: begin
			dma_state_nxt = ST_IDLE;
		end
		default: begin //ST_IDLE
			dma_state_nxt = arb_end 				? ST_READ	: ST_IDLE;
		end

	endcase
end

atcdmac300_fifo atcdmac300_fifo (
	.aclk                  (aclk			),
	.aresetn               (aresetn			),
	.dma_soft_reset        (dma_soft_reset		),
	.dma_fifo_wr           (dma_fifo_wr		),
	.dma_fifo_last_wr      (dma_fifo_last_wr	),
	.dma_fifo_wdata        (dma_fifo_wdata		),
	.dma_fifo_size         (dma_fifo_size		),
	.dma_fifo_rd           (dma_fifo_rd		),
	.dma_fifo_byte_offset  (dma_fifo_byte_offset	),
	.dma_fifo_flush        (dma_fifo_flush		),
	.dma_fifo_src_addr_dec (dma_fifo_src_addr_dec	),
	.dma_fifo_dst_addr_dec (dma_fifo_dst_addr_dec	),
	.dma_fifo_rdata        (dma_fifo_rdata		)
); // end of atcdmac100_fifo


endmodule
