`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_fifo ( //VPERL: &PORTLIST;
                         // VPERL_GENERATED_BEGIN
                         	  aclk,
                         	  aresetn,
                         	  dma_soft_reset,
                         	  dma_fifo_wr,
                         	  dma_fifo_last_wr,
                         	  dma_fifo_wdata,
                         	  dma_fifo_size,
                         	  dma_fifo_rd,
                         	  dma_fifo_byte_offset,
                         	  dma_fifo_flush,
                         	  dma_fifo_src_addr_dec,
                         	  dma_fifo_dst_addr_dec,
                         	  dma_fifo_rdata
                         // VPERL_GENERATED_END
);

localparam	BYTE_OFFSET_WIDTH	= `ATCDMAC300_BYTE_OFFSET_WIDTH;
localparam	DMA_DATA_MSB		= `DMA_DATA_WIDTH - 1;
localparam	BYTE_OFFSET_MSB		=  BYTE_OFFSET_WIDTH - 1;
// transfer size
parameter	SIZE_BYTE		= 3'b000;
parameter	SIZE_HALF_WORD		= 3'b001;
parameter	SIZE_WORD		= 3'b010;
parameter	SIZE_DOUBLE_WORD	= 3'b011;
parameter	SIZE_QUAD_WORD		= 3'b100;
parameter	SIZE_EIGHT_WORD		= 3'b101;

input          					aclk;
input          					aresetn;
input						dma_soft_reset;

input						dma_fifo_wr;
input						dma_fifo_last_wr;
input	[(`DMA_DATA_WIDTH-1):0]			dma_fifo_wdata;
input	[2:0]					dma_fifo_size;
input						dma_fifo_rd;
input	[`ATCDMAC300_BYTE_OFFSET_WIDTH-1:0]	dma_fifo_byte_offset;
input						dma_fifo_flush;
input						dma_fifo_src_addr_dec;
input						dma_fifo_dst_addr_dec;

output	[(`DMA_DATA_WIDTH-1):0]			dma_fifo_rdata;
reg	[(`DMA_DATA_WIDTH-1):0]			dma_fifo_rdata;

wire						byte_offset_clr;
reg	[(`DMA_DATA_WIDTH-1):0]			fifo_wdata_aligned;

wire						fifo_wr;
wire						fifo_rd;
wire						fifo_empty;
wire						fifo_full;
wire						fifo_near_empty;
wire	[(`DMA_DATA_WIDTH-1):0]			fifo_wdata;
wire	[(`DMA_DATA_WIDTH-1):0]			fifo_rdata;
reg	[(`DMA_DATA_WIDTH-1):0]			fifo_rdata_aligned;
wire	[(`DMA_DATA_WIDTH-1):0]			fifo_rdata_ordered;

wire						data_width_byte;
wire						data_width_hword;
wire						data_width_word;
wire						data_width_double_word;
wire						data_width_quad_word;
wire						data_width_eight_word;
wire						src_dst_diff_addr_mode;

wire						fifo_flush;

wire	[`ATCDMAC300_FIFO_POINTER_WIDTH-1:0]	fifo_wr_ptr;
wire	[`ATCDMAC300_FIFO_POINTER_WIDTH-1:0]	fifo_rd_ptr;
wire	[`ATCDMAC300_FIFO_POINTER_WIDTH-1:0]	fifo_wr_ptr_a1;
wire	[`ATCDMAC300_FIFO_POINTER_WIDTH-1:0]	fifo_rd_ptr_a1;

wire 	[BYTE_OFFSET_MSB:0]			reversed_byte_offset;
wire	[BYTE_OFFSET_MSB:0]			reversed_byte_mask;
wire 	[BYTE_OFFSET_MSB:0]			rdata_byte_offset;
wire 	[BYTE_OFFSET_MSB:0]			byte_offset_nxt;
reg 	[BYTE_OFFSET_MSB:0]			byte_offset;
reg 	[BYTE_OFFSET_MSB:0]			last_wr_byte_offset;
wire						last_element;
wire						last_element_wr;
wire 						dma_fifo_empty;

reg 	[7:0]					fifo_wdata_b0_buf;
reg 	[7:0]					fifo_wdata_b1_buf;
reg 	[7:0]					fifo_wdata_b2_buf;
wire	[7:0]					fifo_wdata_b0;
wire	[7:0]					fifo_wdata_b1;
wire	[7:0]					fifo_wdata_b2;
wire 						fifo_wdata_b0_wen;
wire 						fifo_wdata_b1_wen;
wire 						fifo_wdata_b2_wen;
wire 	[7:0]					fifo_wdata_b0_nxt;
wire 	[7:0]					fifo_wdata_b1_nxt;
wire 	[7:0]					fifo_wdata_b2_nxt;
wire	[(`DMA_DATA_WIDTH-1):0]			fifo_wdata_buf_hword;
wire	[(`DMA_DATA_WIDTH-1):0]			fifo_wdata_buf_byte;
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
reg 	[7:0]					fifo_wdata_b3_buf;
reg 	[7:0]					fifo_wdata_b4_buf;
reg 	[7:0]					fifo_wdata_b5_buf;
reg 	[7:0]					fifo_wdata_b6_buf;
wire 	[7:0]					fifo_wdata_b3;
wire 	[7:0]					fifo_wdata_b4;
wire 	[7:0]					fifo_wdata_b5;
wire 	[7:0]					fifo_wdata_b6;
wire 	[7:0]					fifo_wdata_b3_nxt;
wire 	[7:0]					fifo_wdata_b4_nxt;
wire 	[7:0]					fifo_wdata_b5_nxt;
wire 	[7:0]					fifo_wdata_b6_nxt;
wire 						fifo_wdata_b3_wen;
wire 						fifo_wdata_b4_wen;
wire 						fifo_wdata_b5_wen;
wire 						fifo_wdata_b6_wen;
wire	[(`DMA_DATA_WIDTH-1):0]			fifo_wdata_buf_word;
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
reg 	[7:0]					fifo_wdata_b7_buf;
reg 	[7:0]					fifo_wdata_b8_buf;
reg 	[7:0]					fifo_wdata_b9_buf;
reg 	[7:0]					fifo_wdata_b10_buf;
reg 	[7:0]					fifo_wdata_b11_buf;
reg 	[7:0]					fifo_wdata_b12_buf;
reg 	[7:0]					fifo_wdata_b13_buf;
reg 	[7:0]					fifo_wdata_b14_buf;
wire 	[7:0]					fifo_wdata_b7;
wire 	[7:0]					fifo_wdata_b8;
wire 	[7:0]					fifo_wdata_b9;
wire 	[7:0]					fifo_wdata_b10;
wire 	[7:0]					fifo_wdata_b11;
wire 	[7:0]					fifo_wdata_b12;
wire 	[7:0]					fifo_wdata_b13;
wire 	[7:0]					fifo_wdata_b14;
wire 	[7:0]					fifo_wdata_b7_nxt;
wire 	[7:0]					fifo_wdata_b8_nxt;
wire 	[7:0]					fifo_wdata_b9_nxt;
wire 	[7:0]					fifo_wdata_b10_nxt;
wire 	[7:0]					fifo_wdata_b11_nxt;
wire 	[7:0]					fifo_wdata_b12_nxt;
wire 	[7:0]					fifo_wdata_b13_nxt;
wire 	[7:0]					fifo_wdata_b14_nxt;
wire 						fifo_wdata_b7_wen;
wire 						fifo_wdata_b8_wen;
wire 						fifo_wdata_b9_wen;
wire 						fifo_wdata_b10_wen;
wire 						fifo_wdata_b11_wen;
wire 						fifo_wdata_b12_wen;
wire 						fifo_wdata_b13_wen;
wire 						fifo_wdata_b14_wen;
wire	[(`DMA_DATA_WIDTH-1):0]			fifo_wdata_buf_double_word;
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
reg 	[7:0]					fifo_wdata_b15_buf;
reg 	[7:0]					fifo_wdata_b16_buf;
reg 	[7:0]					fifo_wdata_b17_buf;
reg 	[7:0]					fifo_wdata_b18_buf;
reg 	[7:0]					fifo_wdata_b19_buf;
reg 	[7:0]					fifo_wdata_b20_buf;
reg 	[7:0]					fifo_wdata_b21_buf;
reg 	[7:0]					fifo_wdata_b22_buf;
reg 	[7:0]					fifo_wdata_b23_buf;
reg 	[7:0]					fifo_wdata_b24_buf;
reg 	[7:0]					fifo_wdata_b25_buf;
reg 	[7:0]					fifo_wdata_b26_buf;
reg 	[7:0]					fifo_wdata_b27_buf;
reg 	[7:0]					fifo_wdata_b28_buf;
reg 	[7:0]					fifo_wdata_b29_buf;
reg 	[7:0]					fifo_wdata_b30_buf;
wire 	[7:0]					fifo_wdata_b15;
wire 	[7:0]					fifo_wdata_b16;
wire 	[7:0]					fifo_wdata_b17;
wire 	[7:0]					fifo_wdata_b18;
wire 	[7:0]					fifo_wdata_b19;
wire 	[7:0]					fifo_wdata_b20;
wire 	[7:0]					fifo_wdata_b21;
wire 	[7:0]					fifo_wdata_b22;
wire 	[7:0]					fifo_wdata_b23;
wire 	[7:0]					fifo_wdata_b24;
wire 	[7:0]					fifo_wdata_b25;
wire 	[7:0]					fifo_wdata_b26;
wire 	[7:0]					fifo_wdata_b27;
wire 	[7:0]					fifo_wdata_b28;
wire 	[7:0]					fifo_wdata_b29;
wire 	[7:0]					fifo_wdata_b30;
wire 	[7:0]					fifo_wdata_b15_nxt;
wire 	[7:0]					fifo_wdata_b16_nxt;
wire 	[7:0]					fifo_wdata_b17_nxt;
wire 	[7:0]					fifo_wdata_b18_nxt;
wire 	[7:0]					fifo_wdata_b19_nxt;
wire 	[7:0]					fifo_wdata_b20_nxt;
wire 	[7:0]					fifo_wdata_b21_nxt;
wire 	[7:0]					fifo_wdata_b22_nxt;
wire 	[7:0]					fifo_wdata_b23_nxt;
wire 	[7:0]					fifo_wdata_b24_nxt;
wire 	[7:0]					fifo_wdata_b25_nxt;
wire 	[7:0]					fifo_wdata_b26_nxt;
wire 	[7:0]					fifo_wdata_b27_nxt;
wire 	[7:0]					fifo_wdata_b28_nxt;
wire 	[7:0]					fifo_wdata_b29_nxt;
wire 	[7:0]					fifo_wdata_b30_nxt;
wire 						fifo_wdata_b15_wen;
wire 						fifo_wdata_b16_wen;
wire 						fifo_wdata_b17_wen;
wire 						fifo_wdata_b18_wen;
wire 						fifo_wdata_b19_wen;
wire 						fifo_wdata_b20_wen;
wire 						fifo_wdata_b21_wen;
wire 						fifo_wdata_b22_wen;
wire 						fifo_wdata_b23_wen;
wire 						fifo_wdata_b24_wen;
wire 						fifo_wdata_b25_wen;
wire 						fifo_wdata_b26_wen;
wire 						fifo_wdata_b27_wen;
wire 						fifo_wdata_b28_wen;
wire 						fifo_wdata_b29_wen;
wire 						fifo_wdata_b30_wen;
wire	[(`DMA_DATA_WIDTH-1):0]			fifo_wdata_buf_quad_word;

`endif // ATCDMAC300_DATA_WIDTH_GE_256
`endif // ATCDMAC300_DATA_WIDTH_GE_128
`endif // ATCDMAC300_DATA_WIDTH_64

assign	fifo_flush		=  dma_fifo_flush | dma_soft_reset;
assign	data_width_byte		= (dma_fifo_size == SIZE_BYTE);
assign	data_width_hword	= (dma_fifo_size == SIZE_HALF_WORD);
assign	data_width_word		= (dma_fifo_size == SIZE_WORD);
assign	data_width_double_word	= (dma_fifo_size == SIZE_DOUBLE_WORD);
assign	data_width_quad_word	= (dma_fifo_size == SIZE_QUAD_WORD);
assign	data_width_eight_word	= (dma_fifo_size == SIZE_EIGHT_WORD);
assign	src_dst_diff_addr_mode	=  dma_fifo_src_addr_dec ^ dma_fifo_dst_addr_dec;
assign	byte_offset_clr		=  fifo_flush       || (dma_fifo_wr && dma_fifo_last_wr) || (dma_fifo_rd && dma_fifo_empty);
assign	fifo_rd 		=  dma_fifo_rd      && (dma_fifo_empty || last_element);
assign	fifo_wr			=  dma_fifo_wr      &&  last_element_wr;
assign	last_element_wr 	=  dma_fifo_last_wr ||  last_element;
assign	reversed_byte_mask	= {BYTE_OFFSET_WIDTH{1'b1}} << dma_fifo_size;
assign	reversed_byte_offset	= ~byte_offset & reversed_byte_mask;
assign	rdata_byte_offset	=  dma_fifo_dst_addr_dec ? reversed_byte_offset : byte_offset;
assign	fifo_wr_ptr_a1		=  fifo_wr_ptr + `ATCDMAC300_FIFO_POINTER_WIDTH'b1;
assign	fifo_rd_ptr_a1		=  fifo_rd_ptr + `ATCDMAC300_FIFO_POINTER_WIDTH'b1;
assign	fifo_near_empty		= (fifo_rd_ptr_a1 == fifo_wr_ptr);
assign dma_fifo_empty		=  fifo_near_empty && ((byte_offset_nxt == last_wr_byte_offset)
	`ifdef ATCDMAC300_DATA_WIDTH_256
							|| data_width_eight_word
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_128
							|| data_width_quad_word
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_64
							|| data_width_double_word
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_32
							|| data_width_word
	`endif
						       );

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		last_wr_byte_offset <= {BYTE_OFFSET_WIDTH{1'b0}};
	end
	else if (dma_fifo_wr & dma_fifo_last_wr) begin
		last_wr_byte_offset <= byte_offset_nxt;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		byte_offset <= {BYTE_OFFSET_WIDTH{1'b0}};
	end
	else if (byte_offset_clr) begin
		byte_offset <= {BYTE_OFFSET_WIDTH{1'b0}};
	end
	else if ((dma_fifo_wr || dma_fifo_rd)
	`ifdef ATCDMAC300_DATA_WIDTH_32
						&& (!data_width_word)
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_64
						&& (!data_width_double_word)
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_128
						&& (!data_width_quad_word)
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_256
						&& (!data_width_eight_word)
	`endif
		) begin
		byte_offset <= byte_offset_nxt;
	end
end

//fifo
nds_sync_fifo_clr #(
        .DATA_WIDTH	     (`DMA_DATA_WIDTH),
        .FIFO_DEPTH	     (`ATCDMAC300_FIFO_DEPTH),
        .POINTER_INDEX_WIDTH (`ATCDMAC300_FIFO_POINTER_WIDTH)
) nds_sync_fifo_clr (
	.reset_n(aresetn),
	.clk(aclk),
	.wr(fifo_wr),
	.wr_data(fifo_wdata),
	.rd(fifo_rd),
	.rd_data(fifo_rdata),
	.empty(fifo_empty),
	.full(fifo_full),
	.wr_ptr(fifo_wr_ptr),
	.rd_ptr(fifo_rd_ptr),
	.fifo_clr(fifo_flush)
);

	assign	fifo_rdata_ordered = src_dst_diff_addr_mode ? {
				     fifo_rdata[  7:  0], fifo_rdata[ 15:  8], fifo_rdata[ 23: 16], fifo_rdata[ 31: 24]
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				    ,fifo_rdata[ 39: 32], fifo_rdata[ 47: 40], fifo_rdata[ 55: 48], fifo_rdata[ 63: 56]
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				    ,fifo_rdata[ 71: 64], fifo_rdata[ 79: 72], fifo_rdata[ 87: 80], fifo_rdata[ 95: 88]
				    ,fifo_rdata[103: 96], fifo_rdata[111:104], fifo_rdata[119:112], fifo_rdata[127:120]
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				    ,fifo_rdata[135:128], fifo_rdata[143:136], fifo_rdata[151:144], fifo_rdata[159:152]
				    ,fifo_rdata[167:160], fifo_rdata[175:168], fifo_rdata[183:176], fifo_rdata[191:184]
				    ,fifo_rdata[199:192], fifo_rdata[207:200], fifo_rdata[215:208], fifo_rdata[223:216]
				    ,fifo_rdata[231:224], fifo_rdata[239:232], fifo_rdata[247:240], fifo_rdata[255:248]
`endif
`endif
`endif
				     } : fifo_rdata;


//-----------------------------------------------------------------------------------------------------------------------------------------------
`ifdef ATCDMAC300_DATA_WIDTH_32
	assign last_element 	=  (data_width_byte  && (byte_offset ==  {`ATCDMAC300_BYTE_OFFSET_WIDTH{1'b1}}))	 // 2'b11
				|| (data_width_hword && (byte_offset == {{`ATCDMAC300_BYTE_OFFSET_WIDTH-1{1'b1}},1'b0})) // 2'b10
				|| (data_width_word);	 // 2'b00

	assign	byte_offset_nxt =   byte_offset  +
						    (data_width_hword ?	{{`ATCDMAC300_BYTE_OFFSET_WIDTH-1{1'b1}},1'b0} : // 2'b10
						     data_width_byte  ?	{{`ATCDMAC300_BYTE_OFFSET_WIDTH-1{1'b0}},1'b1} : // 2'b01
									 {`ATCDMAC300_BYTE_OFFSET_WIDTH{1'b0}});	 // 2'b00

	//fifo read data alignment
	always @(*) begin
		case (rdata_byte_offset[1:0])
			2'b01: begin
				fifo_rdata_aligned[31:24] 	= fifo_rdata_ordered[7:0];
				fifo_rdata_aligned[23:0] 	= fifo_rdata_ordered[31:8];
			end
			2'b10: begin
				fifo_rdata_aligned[31:16] 	= fifo_rdata_ordered[15:0];
				fifo_rdata_aligned[15:0] 	= fifo_rdata_ordered[31:16];
			end
			2'b11: begin
				fifo_rdata_aligned[31:8] 	= fifo_rdata_ordered[23:0];
				fifo_rdata_aligned[7:0] 	= fifo_rdata_ordered[31:24];
			end
			default: begin //2'b00
				fifo_rdata_aligned 		= fifo_rdata_ordered[31:0];
			end
		endcase
	end

	always @(*) begin
		case (dma_fifo_byte_offset[1:0])	// for 32-bit DATA WIDTH
			2'b01: begin
				dma_fifo_rdata[31:8]	= fifo_rdata_aligned[23:0];
				dma_fifo_rdata[7:0] 	= fifo_rdata_aligned[31:24];
			end
			2'b10: begin
				dma_fifo_rdata[31:16] 	= fifo_rdata_aligned[15:0];
				dma_fifo_rdata[15:0] 	= fifo_rdata_aligned[31:16];
			end
			2'b11: begin
				dma_fifo_rdata[31:24] 	= fifo_rdata_aligned[7:0];
				dma_fifo_rdata[23:0] 	= fifo_rdata_aligned[31:8];
			end
			default: begin //2'b00
				dma_fifo_rdata[31:0]	= fifo_rdata_aligned[31:0];
			end
		endcase
	end

	//fifo write data alignment
	always @(*) begin
		case (dma_fifo_byte_offset[1:0])	// for 32-bit DATA WIDTH
			2'b01: begin
				fifo_wdata_aligned[31:24] 	= dma_fifo_wdata[7:0];
				fifo_wdata_aligned[23:0] 	= dma_fifo_wdata[31:8];
			end
			2'b10: begin
				fifo_wdata_aligned[31:16] 	= dma_fifo_wdata[15:0];
				fifo_wdata_aligned[15:0] 	= dma_fifo_wdata[31:16];
			end
			2'b11: begin
				fifo_wdata_aligned[31:8] 	= dma_fifo_wdata[23:0];
				fifo_wdata_aligned[7:0] 	= dma_fifo_wdata[31:24];
			end
			default: begin //2'b00
				fifo_wdata_aligned 		= dma_fifo_wdata;
			end
		endcase
	end


	assign fifo_wdata = data_width_word  ? 	dma_fifo_wdata :
			    data_width_hword ? 	fifo_wdata_buf_hword :
			    			fifo_wdata_buf_byte;

	assign fifo_wdata_buf_hword = dma_fifo_src_addr_dec ? {fifo_wdata_b1,            fifo_wdata_b0, fifo_wdata_aligned[15:0]} :
						              {fifo_wdata_aligned[15:0], fifo_wdata_b1, fifo_wdata_b0};
	assign fifo_wdata_buf_byte  = dma_fifo_src_addr_dec ? {fifo_wdata_b0,            fifo_wdata_b1, fifo_wdata_b2, fifo_wdata_aligned[7:0]} :
						              {fifo_wdata_aligned[7:0],  fifo_wdata_b2, fifo_wdata_b1, fifo_wdata_b0};

`endif // ATCDMAC300_DATA_WIDTH_32
//-----------------------------------------------------------------------------------------------------------------------------------------------
`ifdef ATCDMAC300_DATA_WIDTH_64
	assign last_element 	=  (data_width_byte	   && (byte_offset ==	3'b111))
				|| (data_width_hword	   && (byte_offset ==	3'b110))
				|| (data_width_word	   && (byte_offset ==	3'b100))
				|| (data_width_double_word);

	assign	byte_offset_nxt	= byte_offset + (data_width_word  	?	3'b100 :
						 data_width_hword 	?	3'b010 :
						 data_width_byte  	?	3'b001 :
										3'b000);
	//fifo read data alignment
	always @(*) begin
		case (rdata_byte_offset[2:0])
			3'b001: begin
				fifo_rdata_aligned[63:56] 	= fifo_rdata_ordered[7:0];
				fifo_rdata_aligned[55:0] 	= fifo_rdata_ordered[63:8];
			end
			3'b010: begin
				fifo_rdata_aligned[63:48] 	= fifo_rdata_ordered[15:0];
				fifo_rdata_aligned[47:0] 	= fifo_rdata_ordered[63:16];
			end
			3'b011: begin
				fifo_rdata_aligned[63:40] 	= fifo_rdata_ordered[23:0];
				fifo_rdata_aligned[39:0] 	= fifo_rdata_ordered[63:24];
			end
			3'b100: begin
				fifo_rdata_aligned[63:32] 	= fifo_rdata_ordered[31:0];
				fifo_rdata_aligned[31:0] 	= fifo_rdata_ordered[63:32];
			end
			3'b101: begin
				fifo_rdata_aligned[63:24] 	= fifo_rdata_ordered[39:0];
				fifo_rdata_aligned[23:0] 	= fifo_rdata_ordered[63:40];
			end
			3'b110: begin
				fifo_rdata_aligned[63:16] 	= fifo_rdata_ordered[47:0];
				fifo_rdata_aligned[15:0] 	= fifo_rdata_ordered[63:48];
			end
			3'b111: begin
				fifo_rdata_aligned[63:8] 	= fifo_rdata_ordered[55:0];
				fifo_rdata_aligned[7:0] 	= fifo_rdata_ordered[63:56];
			end
			default: begin //3'b000
				fifo_rdata_aligned 		= fifo_rdata_ordered[63:0];
			end
		endcase
	end
	always @(*) begin
		case (dma_fifo_byte_offset[2:0])	// for 64-bit DATA WIDTH
			3'b001: begin
				dma_fifo_rdata[63:8]	= fifo_rdata_aligned[55:0];
				dma_fifo_rdata[7:0] 	= fifo_rdata_aligned[63:56];
			end
			3'b010: begin
				dma_fifo_rdata[63:16] 	= fifo_rdata_aligned[47:0];
				dma_fifo_rdata[15:0] 	= fifo_rdata_aligned[63:48];
			end
			3'b011: begin
				dma_fifo_rdata[63:24] 	= fifo_rdata_aligned[39:0];
				dma_fifo_rdata[23:0] 	= fifo_rdata_aligned[63:40];
			end
			3'b100: begin
				dma_fifo_rdata[63:32] 	= fifo_rdata_aligned[31:0];
				dma_fifo_rdata[31:0] 	= fifo_rdata_aligned[63:32];
			end
			3'b101: begin
				dma_fifo_rdata[63:40] 	= fifo_rdata_aligned[23:0];
				dma_fifo_rdata[39:0] 	= fifo_rdata_aligned[63:24];
			end
			3'b110: begin
				dma_fifo_rdata[63:48] 	= fifo_rdata_aligned[15:0];
				dma_fifo_rdata[47:0] 	= fifo_rdata_aligned[63:16];
			end
			3'b111: begin
				dma_fifo_rdata[63:56] 	= fifo_rdata_aligned[7:0];
				dma_fifo_rdata[55:0] 	= fifo_rdata_aligned[63:8];
			end
			default: begin //3'b000
				dma_fifo_rdata 		= fifo_rdata_aligned;
			end
		endcase
	end
	//fifo write data alignment
	always @(*) begin
		case (dma_fifo_byte_offset[2:0])	// for 64-bit DATA WIDTH
			3'b001: begin
				fifo_wdata_aligned[63:56] 	= dma_fifo_wdata[7:0];
				fifo_wdata_aligned[55:0] 	= dma_fifo_wdata[63:8];
			end
			3'b010: begin
				fifo_wdata_aligned[63:48] 	= dma_fifo_wdata[15:0];
				fifo_wdata_aligned[47:0] 	= dma_fifo_wdata[63:16];
			end
			3'b011: begin
				fifo_wdata_aligned[63:40] 	= dma_fifo_wdata[23:0];
				fifo_wdata_aligned[39:0] 	= dma_fifo_wdata[63:24];
			end
			3'b100: begin
				fifo_wdata_aligned[63:32] 	= dma_fifo_wdata[31:0];
				fifo_wdata_aligned[31:0] 	= dma_fifo_wdata[63:32];
			end
			3'b101: begin
				fifo_wdata_aligned[63:24] 	= dma_fifo_wdata[39:0];
				fifo_wdata_aligned[23:0] 	= dma_fifo_wdata[63:40];
			end
			3'b110: begin
				fifo_wdata_aligned[63:16] 	= dma_fifo_wdata[47:0];
				fifo_wdata_aligned[15:0] 	= dma_fifo_wdata[63:48];
			end
			3'b111: begin
				fifo_wdata_aligned[63:8] 	= dma_fifo_wdata[55:0];
				fifo_wdata_aligned[7:0] 	= dma_fifo_wdata[63:56];
			end
			default: begin //2'b00
				fifo_wdata_aligned[63:0] 	= dma_fifo_wdata[63:0];
			end
		endcase
	end

	assign fifo_wdata_buf_word = dma_fifo_src_addr_dec ?
	{fifo_wdata_b3,            fifo_wdata_b2, fifo_wdata_b1, fifo_wdata_b0, fifo_wdata_aligned[31:0]} :
	{fifo_wdata_aligned[31:0], fifo_wdata_b3, fifo_wdata_b2, fifo_wdata_b1, fifo_wdata_b0};
	assign fifo_wdata_buf_hword = dma_fifo_src_addr_dec ?
	{fifo_wdata_b1,            fifo_wdata_b0, fifo_wdata_b3, fifo_wdata_b2, fifo_wdata_b5, fifo_wdata_b4, fifo_wdata_aligned[15:0]} :
	{fifo_wdata_aligned[15:0], fifo_wdata_b5, fifo_wdata_b4, fifo_wdata_b3, fifo_wdata_b2, fifo_wdata_b1, fifo_wdata_b0};
	assign fifo_wdata_buf_byte = dma_fifo_src_addr_dec ?
	{fifo_wdata_b0,           fifo_wdata_b1, fifo_wdata_b2, fifo_wdata_b3, fifo_wdata_b4, fifo_wdata_b5, fifo_wdata_b6, fifo_wdata_aligned[7:0]} :
	{fifo_wdata_aligned[7:0], fifo_wdata_b6, fifo_wdata_b5, fifo_wdata_b4, fifo_wdata_b3, fifo_wdata_b2, fifo_wdata_b1, fifo_wdata_b0};

	assign fifo_wdata = data_width_double_word ? dma_fifo_wdata :
                            data_width_word        ? fifo_wdata_buf_word :
			    data_width_hword       ? fifo_wdata_buf_hword :
                                                     fifo_wdata_buf_byte;

`endif // ATCDMAC300_DATA_WIDTH_64
//-----------------------------------------------------------------------------------------------------------------------------------------------
`ifdef ATCDMAC300_DATA_WIDTH_128
	assign last_element 	=  (data_width_byte	   && (byte_offset ==	4'b1111))
				|| (data_width_hword	   && (byte_offset ==	4'b1110))
				|| (data_width_word	   && (byte_offset ==	4'b1100))
				|| (data_width_double_word && (byte_offset ==	4'b1000))
				|| (data_width_quad_word);

	assign	byte_offset_nxt	= byte_offset + (data_width_double_word	?	4'b1000 :
						 data_width_word	?	4'b0100 :
						 data_width_hword	?	4'b0010 :
						 data_width_byte	?	4'b0001 :
										4'b0000);
	//fifo read data alignment
	always @(*) begin
		case (rdata_byte_offset[3:0])
			4'b0001: begin
				fifo_rdata_aligned[127:120] 	= fifo_rdata_ordered[  7:  0];
				fifo_rdata_aligned[119:  0] 	= fifo_rdata_ordered[127:  8];
			end
			4'b0010: begin
				fifo_rdata_aligned[127:112] 	= fifo_rdata_ordered[ 15:  0];
				fifo_rdata_aligned[111:  0] 	= fifo_rdata_ordered[127:  16];
			end
			4'b0011: begin
				fifo_rdata_aligned[127:104] 	= fifo_rdata_ordered[ 23:  0];
				fifo_rdata_aligned[103:  0] 	= fifo_rdata_ordered[127: 24];
			end
			4'b0100: begin
				fifo_rdata_aligned[127: 96] 	= fifo_rdata_ordered[ 31:  0];
				fifo_rdata_aligned[ 95:  0] 	= fifo_rdata_ordered[127: 32];
			end
			4'b0101: begin
				fifo_rdata_aligned[127: 88] 	= fifo_rdata_ordered[ 39:  0];
				fifo_rdata_aligned[ 87:  0] 	= fifo_rdata_ordered[127: 40];
			end
			4'b0110: begin
				fifo_rdata_aligned[127: 80] 	= fifo_rdata_ordered[ 47:  0];
				fifo_rdata_aligned[ 79:  0] 	= fifo_rdata_ordered[127: 48];
			end
			4'b0111: begin
				fifo_rdata_aligned[127: 72] 	= fifo_rdata_ordered[ 55:  0];
				fifo_rdata_aligned[ 71:  0] 	= fifo_rdata_ordered[127: 56];
			end
			4'b1000: begin
				fifo_rdata_aligned[127: 64] 	= fifo_rdata_ordered[ 63:  0];
				fifo_rdata_aligned[ 63:  0] 	= fifo_rdata_ordered[127: 64];
			end
			4'b1001: begin
				fifo_rdata_aligned[127: 56] 	= fifo_rdata_ordered[ 71:  0];
				fifo_rdata_aligned[ 55:  0] 	= fifo_rdata_ordered[127: 72];
			end
			4'b1010: begin
				fifo_rdata_aligned[127: 48] 	= fifo_rdata_ordered[ 79:  0];
				fifo_rdata_aligned[ 47:  0] 	= fifo_rdata_ordered[127: 80];
			end
			4'b1011: begin
				fifo_rdata_aligned[127: 40] 	= fifo_rdata_ordered[ 87:  0];
				fifo_rdata_aligned[ 39:  0] 	= fifo_rdata_ordered[127: 88];
			end
			4'b1100: begin
				fifo_rdata_aligned[127: 32] 	= fifo_rdata_ordered[ 95:  0];
				fifo_rdata_aligned[ 31:  0] 	= fifo_rdata_ordered[127: 96];
			end
			4'b1101: begin
				fifo_rdata_aligned[127: 24] 	= fifo_rdata_ordered[103:  0];
				fifo_rdata_aligned[ 23:  0] 	= fifo_rdata_ordered[127:104];
			end
			4'b1110: begin
				fifo_rdata_aligned[127: 16] 	= fifo_rdata_ordered[111:  0];
				fifo_rdata_aligned[ 15:  0] 	= fifo_rdata_ordered[127:112];
			end
			4'b1111: begin
				fifo_rdata_aligned[127:  8] 	= fifo_rdata_ordered[119:  0];
				fifo_rdata_aligned[  7:  0] 	= fifo_rdata_ordered[127:120];
			end
			default: begin //4'b0000
				fifo_rdata_aligned[127:  0]	= fifo_rdata_ordered[127:0];
			end
		endcase
	end
	always @(*) begin
		case (dma_fifo_byte_offset[3:0])
			4'b0001: begin
				dma_fifo_rdata[127:  8]		= fifo_rdata_aligned[119:  0];
				dma_fifo_rdata[  7:  0] 	= fifo_rdata_aligned[127:120];
			end
			4'b0010: begin
				dma_fifo_rdata[127: 16] 	= fifo_rdata_aligned[111:  0];
				dma_fifo_rdata[ 15:  0] 	= fifo_rdata_aligned[127:112];
			end
			4'b0011: begin
				dma_fifo_rdata[127: 24] 	= fifo_rdata_aligned[103:  0];
				dma_fifo_rdata[ 23:  0] 	= fifo_rdata_aligned[127:104];
			end
			4'b0100: begin
				dma_fifo_rdata[127: 32] 	= fifo_rdata_aligned[ 95:  0];
				dma_fifo_rdata[ 31:  0] 	= fifo_rdata_aligned[127: 96];
			end
			4'b0101: begin
				dma_fifo_rdata[127: 40] 	= fifo_rdata_aligned[ 87:  0];
				dma_fifo_rdata[ 39:  0] 	= fifo_rdata_aligned[127: 88];
			end
			4'b0110: begin
				dma_fifo_rdata[127: 48] 	= fifo_rdata_aligned[ 79:  0];
				dma_fifo_rdata[ 47:  0] 	= fifo_rdata_aligned[127: 80];
			end
			4'b0111: begin
				dma_fifo_rdata[127: 56] 	= fifo_rdata_aligned[ 71:  0];
				dma_fifo_rdata[ 55:  0] 	= fifo_rdata_aligned[127: 72];
			end
			4'b1000: begin
				dma_fifo_rdata[127: 64] 	= fifo_rdata_aligned[ 63:  0];
				dma_fifo_rdata[ 63:  0] 	= fifo_rdata_aligned[127: 64];
			end
			4'b1001: begin
				dma_fifo_rdata[127: 72]		= fifo_rdata_aligned[ 55:  0];
				dma_fifo_rdata[ 71:  0] 	= fifo_rdata_aligned[127: 56];
			end
			4'b1010: begin
				dma_fifo_rdata[127: 80] 	= fifo_rdata_aligned[ 47:  0];
				dma_fifo_rdata[ 79:  0] 	= fifo_rdata_aligned[127: 48];
			end
			4'b1011: begin
				dma_fifo_rdata[127: 88] 	= fifo_rdata_aligned[ 39:  0];
				dma_fifo_rdata[ 87:  0] 	= fifo_rdata_aligned[127: 40];
			end
			4'b1100: begin
				dma_fifo_rdata[127: 96] 	= fifo_rdata_aligned[ 31:  0];
				dma_fifo_rdata[ 95:  0] 	= fifo_rdata_aligned[127: 32];
			end
			4'b1101: begin
				dma_fifo_rdata[127:104] 	= fifo_rdata_aligned[ 23:  0];
				dma_fifo_rdata[103:  0] 	= fifo_rdata_aligned[127: 24];
			end
			4'b1110: begin
				dma_fifo_rdata[127:112] 	= fifo_rdata_aligned[ 15:  0];
				dma_fifo_rdata[111:  0] 	= fifo_rdata_aligned[127: 16];
			end
			4'b1111: begin
				dma_fifo_rdata[127:120] 	= fifo_rdata_aligned[  7:  0];
				dma_fifo_rdata[119:  0] 	= fifo_rdata_aligned[127:  8];
			end
			default: begin //4'b0000
				dma_fifo_rdata[127:  0] 	= fifo_rdata_aligned[127:  0];
			end
		endcase
	end
	//fifo write data alignment
	always @(*) begin
		case (dma_fifo_byte_offset[3:0])
			4'b0001: begin
				fifo_wdata_aligned[127:120] 	= dma_fifo_wdata[  7:  0];
				fifo_wdata_aligned[119:  0] 	= dma_fifo_wdata[127:  8];
			end
			4'b0010: begin
				fifo_wdata_aligned[127:112] 	= dma_fifo_wdata[ 15:  0];
				fifo_wdata_aligned[111:  0] 	= dma_fifo_wdata[127: 16];
			end
			4'b0011: begin
				fifo_wdata_aligned[127:104] 	= dma_fifo_wdata[ 23:  0];
				fifo_wdata_aligned[103:  0] 	= dma_fifo_wdata[127: 24];
			end
			4'b0100: begin
				fifo_wdata_aligned[127: 96] 	= dma_fifo_wdata[ 31:  0];
				fifo_wdata_aligned[ 95:  0] 	= dma_fifo_wdata[127: 32];
			end
			4'b0101: begin
				fifo_wdata_aligned[127: 88] 	= dma_fifo_wdata[ 39:  0];
				fifo_wdata_aligned[87:   0] 	= dma_fifo_wdata[127: 40];
			end
			4'b0110: begin
				fifo_wdata_aligned[127: 80] 	= dma_fifo_wdata[ 47:  0];
				fifo_wdata_aligned[ 79:  0] 	= dma_fifo_wdata[127: 48];
			end
			4'b0111: begin
				fifo_wdata_aligned[127: 72] 	= dma_fifo_wdata[ 55:  0];
				fifo_wdata_aligned[ 71:  0] 	= dma_fifo_wdata[127: 56];
			end
			4'b1000: begin
				fifo_wdata_aligned[127: 64] 	= dma_fifo_wdata[ 63:  0];
				fifo_wdata_aligned[ 63:  0] 	= dma_fifo_wdata[127: 64];
			end
			4'b1001: begin
				fifo_wdata_aligned[127: 56] 	= dma_fifo_wdata[ 71:  0];
				fifo_wdata_aligned[ 55:  0] 	= dma_fifo_wdata[127: 72];
			end
			4'b1010: begin
				fifo_wdata_aligned[127: 48] 	= dma_fifo_wdata[ 79:  0];
				fifo_wdata_aligned[ 47:  0] 	= dma_fifo_wdata[127: 80];
			end
			4'b1011: begin
				fifo_wdata_aligned[127: 40] 	= dma_fifo_wdata[ 87:  0];
				fifo_wdata_aligned[ 39:  0] 	= dma_fifo_wdata[127: 88];
			end
			4'b1100: begin
				fifo_wdata_aligned[127: 32] 	= dma_fifo_wdata[ 95:  0];
				fifo_wdata_aligned[ 31:  0] 	= dma_fifo_wdata[127: 96];
			end
			4'b1101: begin
				fifo_wdata_aligned[127: 24] 	= dma_fifo_wdata[103:  0];
				fifo_wdata_aligned[ 23:  0] 	= dma_fifo_wdata[127:104];
			end
			4'b1110: begin
				fifo_wdata_aligned[127: 16] 	= dma_fifo_wdata[111:  0];
				fifo_wdata_aligned[ 15:  0] 	= dma_fifo_wdata[127:112];
			end
			4'b1111: begin
				fifo_wdata_aligned[127:  8] 	= dma_fifo_wdata[119:  0];
				fifo_wdata_aligned[  7:  0] 	= dma_fifo_wdata[127:120];
			end
			default: begin //4'b0000
				fifo_wdata_aligned[127:  0] 	= dma_fifo_wdata[127:  0];
			end
		endcase
	end

	assign fifo_wdata_buf_double_word =	 dma_fifo_src_addr_dec ?
						{fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0             ,
						                                                                     fifo_wdata_aligned[63:0]} :
						{fifo_wdata_aligned[63:0]                                                                      ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0           } ;

	assign fifo_wdata_buf_word =		 dma_fifo_src_addr_dec ?
						{fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0             ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8             ,
						                                                                     fifo_wdata_aligned[31:0]} :
						{fifo_wdata_aligned[31:0]                                                                      ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8             ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0           } ;

	assign fifo_wdata_buf_hword =		 dma_fifo_src_addr_dec ?
						{fifo_wdata_b1           , fifo_wdata_b0 , fifo_wdata_b3           , fifo_wdata_b2             ,
						 fifo_wdata_b5           , fifo_wdata_b4 , fifo_wdata_b7           , fifo_wdata_b6             ,
						 fifo_wdata_b9           , fifo_wdata_b8 , fifo_wdata_b11          , fifo_wdata_b10            ,
						 fifo_wdata_b13          , fifo_wdata_b12,                           fifo_wdata_aligned[15:0]} :
						{fifo_wdata_aligned[15:0],                 fifo_wdata_b13          , fifo_wdata_b12            ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8             ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0           } ;

	assign fifo_wdata_buf_byte =		 dma_fifo_src_addr_dec ?
						{fifo_wdata_b0           , fifo_wdata_b1 , fifo_wdata_b2           , fifo_wdata_b3             ,
						 fifo_wdata_b4           , fifo_wdata_b5 , fifo_wdata_b6           , fifo_wdata_b7             ,
						 fifo_wdata_b8           , fifo_wdata_b9 , fifo_wdata_b10          , fifo_wdata_b11            ,
						 fifo_wdata_b12          , fifo_wdata_b13, fifo_wdata_b14          , fifo_wdata_aligned[ 7:0]} :
						{fifo_wdata_aligned[ 7:0], fifo_wdata_b14, fifo_wdata_b13          , fifo_wdata_b12            ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8             ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0           } ;

	assign fifo_wdata = data_width_quad_word   ? dma_fifo_wdata :
			    data_width_double_word ? fifo_wdata_buf_double_word :
                            data_width_word        ? fifo_wdata_buf_word :
			    data_width_hword       ? fifo_wdata_buf_hword :
                                                     fifo_wdata_buf_byte;

`endif // ATCDMAC300_DATA_WIDTH_128
//-----------------------------------------------------------------------------------------------------------------------------------------------
`ifdef ATCDMAC300_DATA_WIDTH_256
	assign last_element 	=  (data_width_byte	   && (byte_offset ==	5'b11111))
				|| (data_width_hword	   && (byte_offset ==	5'b11110))
				|| (data_width_word	   && (byte_offset ==	5'b11100))
				|| (data_width_double_word && (byte_offset ==	5'b11000))
				|| (data_width_quad_word   && (byte_offset ==	5'b10000))
				|| (data_width_eight_word);

	assign	byte_offset_nxt	= byte_offset + (data_width_quad_word	?	5'b10000 :
						 data_width_double_word	?	5'b01000 :
						 data_width_word	?	5'b00100 :
						 data_width_hword	?	5'b00010 :
						 data_width_byte	?	5'b00001 :
								  		5'b00000);
	//fifo read data alignment
	always @(*) begin
		case (rdata_byte_offset[4:0])
			5'b00001: begin
				fifo_rdata_aligned[255:248] 	= fifo_rdata_ordered[  7:  0];
				fifo_rdata_aligned[247:  0] 	= fifo_rdata_ordered[255:  8];
			end
			5'b00010: begin
				fifo_rdata_aligned[255:240] 	= fifo_rdata_ordered[ 15:  0];
				fifo_rdata_aligned[239:  0] 	= fifo_rdata_ordered[255: 16];
			end
			5'b00011: begin
				fifo_rdata_aligned[255:232] 	= fifo_rdata_ordered[ 23:  0];
				fifo_rdata_aligned[231:  0] 	= fifo_rdata_ordered[255: 24];
			end
			5'b00100: begin
				fifo_rdata_aligned[255:224] 	= fifo_rdata_ordered[ 31:  0];
				fifo_rdata_aligned[223:  0] 	= fifo_rdata_ordered[255: 32];
			end
			5'b00101: begin
				fifo_rdata_aligned[255:216] 	= fifo_rdata_ordered[ 39:  0];
				fifo_rdata_aligned[215:  0] 	= fifo_rdata_ordered[255: 40];
			end
			5'b00110: begin
				fifo_rdata_aligned[255:208] 	= fifo_rdata_ordered[ 47:  0];
				fifo_rdata_aligned[207:  0] 	= fifo_rdata_ordered[255: 48];
			end
			5'b00111: begin
				fifo_rdata_aligned[255:200] 	= fifo_rdata_ordered[ 55:  0];
				fifo_rdata_aligned[199:  0] 	= fifo_rdata_ordered[255: 56];
			end
			5'b01000: begin
				fifo_rdata_aligned[255:192] 	= fifo_rdata_ordered[ 63:  0];
				fifo_rdata_aligned[191:  0] 	= fifo_rdata_ordered[255: 64];
			end
			5'b01001: begin
				fifo_rdata_aligned[255:184] 	= fifo_rdata_ordered[ 71:  0];
				fifo_rdata_aligned[183:  0] 	= fifo_rdata_ordered[255: 72];
			end
			5'b01010: begin
				fifo_rdata_aligned[255:176] 	= fifo_rdata_ordered[ 79:  0];
				fifo_rdata_aligned[175:  0] 	= fifo_rdata_ordered[255: 80];
			end
			5'b01011: begin
				fifo_rdata_aligned[255:168] 	= fifo_rdata_ordered[ 87:  0];
				fifo_rdata_aligned[167:  0] 	= fifo_rdata_ordered[255: 88];
			end
			5'b01100: begin
				fifo_rdata_aligned[255:160] 	= fifo_rdata_ordered[ 95:  0];
				fifo_rdata_aligned[159:  0] 	= fifo_rdata_ordered[255: 96];
			end
			5'b01101: begin
				fifo_rdata_aligned[255:152] 	= fifo_rdata_ordered[103:  0];
				fifo_rdata_aligned[151:  0] 	= fifo_rdata_ordered[255:104];
			end
			5'b01110: begin
				fifo_rdata_aligned[255:144] 	= fifo_rdata_ordered[111:  0];
				fifo_rdata_aligned[143:  0] 	= fifo_rdata_ordered[255:112];
			end
			5'b01111: begin
				fifo_rdata_aligned[255:136] 	= fifo_rdata_ordered[119:  0];
				fifo_rdata_aligned[135:  0] 	= fifo_rdata_ordered[255:120];
			end
			5'b10000: begin
				fifo_rdata_aligned[255:128] 	= fifo_rdata_ordered[127:  0];
				fifo_rdata_aligned[127:  0] 	= fifo_rdata_ordered[255:128];
			end
			5'b10001: begin
				fifo_rdata_aligned[255:120] 	= fifo_rdata_ordered[135:  0];
				fifo_rdata_aligned[119:  0] 	= fifo_rdata_ordered[255:136];
			end
			5'b10010: begin
				fifo_rdata_aligned[255:112] 	= fifo_rdata_ordered[143:  0];
				fifo_rdata_aligned[111:  0] 	= fifo_rdata_ordered[255:144];
			end
			5'b10011: begin
				fifo_rdata_aligned[255:104] 	= fifo_rdata_ordered[151:  0];
				fifo_rdata_aligned[103:  0] 	= fifo_rdata_ordered[255:152];
			end
			5'b10100: begin
				fifo_rdata_aligned[255: 96] 	= fifo_rdata_ordered[159:  0];
				fifo_rdata_aligned[ 95:  0] 	= fifo_rdata_ordered[255:160];
			end
			5'b10101: begin
				fifo_rdata_aligned[255: 88] 	= fifo_rdata_ordered[167:  0];
				fifo_rdata_aligned[ 87:  0] 	= fifo_rdata_ordered[255:168];
			end
			5'b10110: begin
				fifo_rdata_aligned[255: 80] 	= fifo_rdata_ordered[175:  0];
				fifo_rdata_aligned[ 79:  0] 	= fifo_rdata_ordered[255:176];
			end
			5'b10111: begin
				fifo_rdata_aligned[255: 72] 	= fifo_rdata_ordered[183:  0];
				fifo_rdata_aligned[ 71:  0] 	= fifo_rdata_ordered[255:184];
			end
			5'b11000: begin
				fifo_rdata_aligned[255: 64] 	= fifo_rdata_ordered[191:  0];
				fifo_rdata_aligned[ 63:  0] 	= fifo_rdata_ordered[255:192];
			end
			5'b11001: begin
				fifo_rdata_aligned[255: 56] 	= fifo_rdata_ordered[199:  0];
				fifo_rdata_aligned[ 55:  0] 	= fifo_rdata_ordered[255:200];
			end
			5'b11010: begin
				fifo_rdata_aligned[255: 48] 	= fifo_rdata_ordered[207:  0];
				fifo_rdata_aligned[ 47:  0] 	= fifo_rdata_ordered[255:208];
			end
			5'b11011: begin
				fifo_rdata_aligned[255: 40] 	= fifo_rdata_ordered[215:  0];
				fifo_rdata_aligned[ 39:  0] 	= fifo_rdata_ordered[255:216];
			end
			5'b11100: begin
				fifo_rdata_aligned[255: 32] 	= fifo_rdata_ordered[223:  0];
				fifo_rdata_aligned[ 31:  0] 	= fifo_rdata_ordered[255:224];
			end
			5'b11101: begin
				fifo_rdata_aligned[255: 24] 	= fifo_rdata_ordered[231:  0];
				fifo_rdata_aligned[ 23:  0] 	= fifo_rdata_ordered[255:232];
			end
			5'b11110: begin
				fifo_rdata_aligned[255: 16] 	= fifo_rdata_ordered[239:  0];
				fifo_rdata_aligned[ 15:  0] 	= fifo_rdata_ordered[255:240];
			end
			5'b11111: begin
				fifo_rdata_aligned[255:  8] 	= fifo_rdata_ordered[247:  0];
				fifo_rdata_aligned[  7:  0] 	= fifo_rdata_ordered[255:248];
			end
			default: begin //5'b00000
				fifo_rdata_aligned[255:  0]	= fifo_rdata_ordered[255:0];
			end
		endcase
	end
	always @(*) begin
		case (dma_fifo_byte_offset[4:0])
			5'b00001: begin
				dma_fifo_rdata[255:  8]		= fifo_rdata_aligned[247:  0];
				dma_fifo_rdata[  7:  0] 	= fifo_rdata_aligned[255:248];
			end
			5'b00010: begin
				dma_fifo_rdata[255: 16] 	= fifo_rdata_aligned[239:  0];
				dma_fifo_rdata[ 15:  0] 	= fifo_rdata_aligned[255:240];
			end
			5'b00011: begin
				dma_fifo_rdata[255: 24] 	= fifo_rdata_aligned[231:  0];
				dma_fifo_rdata[ 23:  0] 	= fifo_rdata_aligned[255:232];
			end
			5'b00100: begin
				dma_fifo_rdata[255: 32] 	= fifo_rdata_aligned[223:  0];
				dma_fifo_rdata[ 31:  0] 	= fifo_rdata_aligned[255:224];
			end
			5'b00101: begin
				dma_fifo_rdata[255: 40] 	= fifo_rdata_aligned[215:  0];
				dma_fifo_rdata[ 39:  0] 	= fifo_rdata_aligned[255:216];
			end
			5'b00110: begin
				dma_fifo_rdata[255: 48] 	= fifo_rdata_aligned[207:  0];
				dma_fifo_rdata[ 47:  0] 	= fifo_rdata_aligned[255:208];
			end
			5'b00111: begin
				dma_fifo_rdata[255: 56] 	= fifo_rdata_aligned[199:  0];
				dma_fifo_rdata[ 55:  0] 	= fifo_rdata_aligned[255:200];
			end
			5'b01000: begin
				dma_fifo_rdata[255: 64] 	= fifo_rdata_aligned[191:  0];
				dma_fifo_rdata[ 63:  0] 	= fifo_rdata_aligned[255:192];
			end
			5'b01001: begin
				dma_fifo_rdata[255: 72]		= fifo_rdata_aligned[183:  0];
				dma_fifo_rdata[ 71:  0] 	= fifo_rdata_aligned[255:184];
			end
			5'b01010: begin
				dma_fifo_rdata[255: 80] 	= fifo_rdata_aligned[175:  0];
				dma_fifo_rdata[ 79:  0] 	= fifo_rdata_aligned[255:176];
			end
			5'b01011: begin
				dma_fifo_rdata[255: 88] 	= fifo_rdata_aligned[167:  0];
				dma_fifo_rdata[ 87:  0] 	= fifo_rdata_aligned[255:168];
			end
			5'b01100: begin
				dma_fifo_rdata[255: 96] 	= fifo_rdata_aligned[159:  0];
				dma_fifo_rdata[ 95:  0] 	= fifo_rdata_aligned[255:160];
			end
			5'b01101: begin
				dma_fifo_rdata[255:104] 	= fifo_rdata_aligned[151:  0];
				dma_fifo_rdata[103:  0] 	= fifo_rdata_aligned[255:152];
			end
			5'b01110: begin
				dma_fifo_rdata[255:112] 	= fifo_rdata_aligned[143:  0];
				dma_fifo_rdata[111:  0] 	= fifo_rdata_aligned[255:144];
			end
			5'b01111: begin
				dma_fifo_rdata[255:120] 	= fifo_rdata_aligned[135:  0];
				dma_fifo_rdata[119:  0] 	= fifo_rdata_aligned[255:136];
			end
			5'b10000: begin
				dma_fifo_rdata[255:128] 	= fifo_rdata_aligned[127:  0];
				dma_fifo_rdata[127:  0] 	= fifo_rdata_aligned[255:128];
			end
			5'b10001: begin
				dma_fifo_rdata[255:136]		= fifo_rdata_aligned[119:  0];
				dma_fifo_rdata[135:  0] 	= fifo_rdata_aligned[255:120];
			end
			5'b10010: begin
				dma_fifo_rdata[255:144] 	= fifo_rdata_aligned[111:  0];
				dma_fifo_rdata[143:  0] 	= fifo_rdata_aligned[255:112];
			end
			5'b10011: begin
				dma_fifo_rdata[255:152] 	= fifo_rdata_aligned[103:  0];
				dma_fifo_rdata[151:  0] 	= fifo_rdata_aligned[255:104];
			end
			5'b10100: begin
				dma_fifo_rdata[255:160] 	= fifo_rdata_aligned[ 95:  0];
				dma_fifo_rdata[159:  0] 	= fifo_rdata_aligned[255: 96];
			end
			5'b10101: begin
				dma_fifo_rdata[255:168] 	= fifo_rdata_aligned[ 87:  0];
				dma_fifo_rdata[167:  0] 	= fifo_rdata_aligned[255: 88];
			end
			5'b10110: begin
				dma_fifo_rdata[255:176] 	= fifo_rdata_aligned[ 79:  0];
				dma_fifo_rdata[175:  0] 	= fifo_rdata_aligned[255: 80];
			end
			5'b10111: begin
				dma_fifo_rdata[255:184] 	= fifo_rdata_aligned[ 71:  0];
				dma_fifo_rdata[183:  0] 	= fifo_rdata_aligned[255: 72];
			end
			5'b11000: begin
				dma_fifo_rdata[255:192] 	= fifo_rdata_aligned[ 63:  0];
				dma_fifo_rdata[191:  0] 	= fifo_rdata_aligned[255: 64];
			end
			5'b11001: begin
				dma_fifo_rdata[255:200]		= fifo_rdata_aligned[ 55:  0];
				dma_fifo_rdata[199:  0] 	= fifo_rdata_aligned[255: 56];
			end
			5'b11010: begin
				dma_fifo_rdata[255:208] 	= fifo_rdata_aligned[ 47:  0];
				dma_fifo_rdata[207:  0] 	= fifo_rdata_aligned[255: 48];
			end
			5'b11011: begin
				dma_fifo_rdata[255:216] 	= fifo_rdata_aligned[ 39:  0];
				dma_fifo_rdata[215:  0] 	= fifo_rdata_aligned[255: 40];
			end
			5'b11100: begin
				dma_fifo_rdata[255:224] 	= fifo_rdata_aligned[ 31:  0];
				dma_fifo_rdata[223:  0] 	= fifo_rdata_aligned[255: 32];
			end
			5'b11101: begin
				dma_fifo_rdata[255:232] 	= fifo_rdata_aligned[ 23:  0];
				dma_fifo_rdata[231:  0] 	= fifo_rdata_aligned[255: 24];
			end
			5'b11110: begin
				dma_fifo_rdata[255:240] 	= fifo_rdata_aligned[ 15:  0];
				dma_fifo_rdata[239:  0] 	= fifo_rdata_aligned[255: 16];
			end
			5'b11111: begin
				dma_fifo_rdata[255:248] 	= fifo_rdata_aligned[  7:  0];
				dma_fifo_rdata[247:  0] 	= fifo_rdata_aligned[255:  8];
			end
			default: begin //4'b0000
				dma_fifo_rdata[255:  0] 	= fifo_rdata_aligned[255:  0];
			end
		endcase
	end
	//fifo write data alignment
	always @(*) begin
		case (dma_fifo_byte_offset[4:0])
			5'b00001: begin
				fifo_wdata_aligned[255:248] 	= dma_fifo_wdata[  7:  0];
				fifo_wdata_aligned[247:  0] 	= dma_fifo_wdata[255:  8];
			end
			5'b00010: begin
				fifo_wdata_aligned[255:240] 	= dma_fifo_wdata[ 15:  0];
				fifo_wdata_aligned[239:  0] 	= dma_fifo_wdata[255: 16];
			end
			5'b00011: begin
				fifo_wdata_aligned[255:232] 	= dma_fifo_wdata[ 23:  0];
				fifo_wdata_aligned[231:  0] 	= dma_fifo_wdata[255: 24];
			end
			5'b00100: begin
				fifo_wdata_aligned[255:224] 	= dma_fifo_wdata[ 31:  0];
				fifo_wdata_aligned[223:  0] 	= dma_fifo_wdata[255: 32];
			end
			5'b00101: begin
				fifo_wdata_aligned[255:216] 	= dma_fifo_wdata[ 39:  0];
				fifo_wdata_aligned[215:  0] 	= dma_fifo_wdata[255: 40];
			end
			5'b00110: begin
				fifo_wdata_aligned[255:208] 	= dma_fifo_wdata[ 47:  0];
				fifo_wdata_aligned[207:  0] 	= dma_fifo_wdata[255: 48];
			end
			5'b00111: begin
				fifo_wdata_aligned[255:200] 	= dma_fifo_wdata[ 55:  0];
				fifo_wdata_aligned[199:  0] 	= dma_fifo_wdata[255: 56];
			end
			5'b01000: begin
				fifo_wdata_aligned[255:192] 	= dma_fifo_wdata[ 63:  0];
				fifo_wdata_aligned[191:  0] 	= dma_fifo_wdata[255: 64];
			end
			5'b01001: begin
				fifo_wdata_aligned[255:184] 	= dma_fifo_wdata[ 71:  0];
				fifo_wdata_aligned[183:  0] 	= dma_fifo_wdata[255: 72];
			end
			5'b01010: begin
				fifo_wdata_aligned[255:176] 	= dma_fifo_wdata[ 79:  0];
				fifo_wdata_aligned[175:  0] 	= dma_fifo_wdata[255: 80];
			end
			5'b01011: begin
				fifo_wdata_aligned[255:168] 	= dma_fifo_wdata[ 87:  0];
				fifo_wdata_aligned[167:  0] 	= dma_fifo_wdata[255: 88];
			end
			5'b01100: begin
				fifo_wdata_aligned[255:160] 	= dma_fifo_wdata[ 95:  0];
				fifo_wdata_aligned[159:  0] 	= dma_fifo_wdata[255: 96];
			end
			5'b01101: begin
				fifo_wdata_aligned[255:152] 	= dma_fifo_wdata[103:  0];
				fifo_wdata_aligned[151:  0] 	= dma_fifo_wdata[255:104];
			end
			5'b01110: begin
				fifo_wdata_aligned[255:144] 	= dma_fifo_wdata[111:  0];
				fifo_wdata_aligned[143:  0] 	= dma_fifo_wdata[255:112];
			end
			5'b01111: begin
				fifo_wdata_aligned[255:136] 	= dma_fifo_wdata[119:  0];
				fifo_wdata_aligned[135:  0] 	= dma_fifo_wdata[255:120];
			end
			5'b10000: begin
				fifo_wdata_aligned[255:128] 	= dma_fifo_wdata[127:  0];
				fifo_wdata_aligned[127:  0] 	= dma_fifo_wdata[255:128];
			end
			5'b10001: begin
				fifo_wdata_aligned[255:120] 	= dma_fifo_wdata[135:  0];
				fifo_wdata_aligned[119:  0] 	= dma_fifo_wdata[255:136];
			end
			5'b10010: begin
				fifo_wdata_aligned[255:112] 	= dma_fifo_wdata[143:  0];
				fifo_wdata_aligned[111:  0] 	= dma_fifo_wdata[255:144];
			end
			5'b10011: begin
				fifo_wdata_aligned[255:104] 	= dma_fifo_wdata[151:  0];
				fifo_wdata_aligned[103:  0] 	= dma_fifo_wdata[255:152];
			end
			5'b10100: begin
				fifo_wdata_aligned[255: 96] 	= dma_fifo_wdata[159:  0];
				fifo_wdata_aligned[ 95:  0] 	= dma_fifo_wdata[255:160];
			end
			5'b10101: begin
				fifo_wdata_aligned[255: 88] 	= dma_fifo_wdata[167:  0];
				fifo_wdata_aligned[87:   0] 	= dma_fifo_wdata[255:168];
			end
			5'b10110: begin
				fifo_wdata_aligned[255: 80] 	= dma_fifo_wdata[175:  0];
				fifo_wdata_aligned[ 79:  0] 	= dma_fifo_wdata[255:176];
			end
			5'b10111: begin
				fifo_wdata_aligned[255: 72] 	= dma_fifo_wdata[183:  0];
				fifo_wdata_aligned[ 71:  0] 	= dma_fifo_wdata[255:184];
			end
			5'b11000: begin
				fifo_wdata_aligned[255: 64] 	= dma_fifo_wdata[191:  0];
				fifo_wdata_aligned[ 63:  0] 	= dma_fifo_wdata[255:192];
			end
			5'b11001: begin
				fifo_wdata_aligned[255: 56] 	= dma_fifo_wdata[199:  0];
				fifo_wdata_aligned[ 55:  0] 	= dma_fifo_wdata[255:200];
			end
			5'b11010: begin
				fifo_wdata_aligned[255: 48] 	= dma_fifo_wdata[207:  0];
				fifo_wdata_aligned[ 47:  0] 	= dma_fifo_wdata[255:208];
			end
			5'b11011: begin
				fifo_wdata_aligned[255: 40] 	= dma_fifo_wdata[215:  0];
				fifo_wdata_aligned[ 39:  0] 	= dma_fifo_wdata[255:216];
			end
			5'b11100: begin
				fifo_wdata_aligned[255: 32] 	= dma_fifo_wdata[223:  0];
				fifo_wdata_aligned[ 31:  0] 	= dma_fifo_wdata[255:224];
			end
			5'b11101: begin
				fifo_wdata_aligned[255: 24] 	= dma_fifo_wdata[231:  0];
				fifo_wdata_aligned[ 23:  0] 	= dma_fifo_wdata[255:232];
			end
			5'b11110: begin
				fifo_wdata_aligned[255: 16] 	= dma_fifo_wdata[239:  0];
				fifo_wdata_aligned[ 15:  0] 	= dma_fifo_wdata[255:240];
			end
			5'b11111: begin
				fifo_wdata_aligned[255:  8] 	= dma_fifo_wdata[247:  0];
				fifo_wdata_aligned[  7:  0] 	= dma_fifo_wdata[255:248];
			end
			default: begin //5'b00000
				fifo_wdata_aligned[255:  0] 	= dma_fifo_wdata[255:  0];
			end
		endcase
	end

	assign fifo_wdata_buf_quad_word =	 dma_fifo_src_addr_dec ?
						{fifo_wdata_b15          , fifo_wdata_b14, fifo_wdata_b13          , fifo_wdata_b12             ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8              ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4              ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0              ,
						                                                                     fifo_wdata_aligned[127:0]} :
						{fifo_wdata_aligned[127:0]                                                                      ,
						 fifo_wdata_b15          , fifo_wdata_b14, fifo_wdata_b13          , fifo_wdata_b12             ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8              ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4              ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0            } ;

	assign fifo_wdata_buf_double_word =	 dma_fifo_src_addr_dec ?
						{fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0             ,
						 fifo_wdata_b15          , fifo_wdata_b14, fifo_wdata_b13          , fifo_wdata_b12            ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8             ,
						 fifo_wdata_b23          , fifo_wdata_b22, fifo_wdata_b21          , fifo_wdata_b20            ,
						 fifo_wdata_b19          , fifo_wdata_b18, fifo_wdata_b17          , fifo_wdata_b16            ,
						                                                                     fifo_wdata_aligned[63:0]} :
						{fifo_wdata_aligned[63:0]                                                                      ,
						 fifo_wdata_b23          , fifo_wdata_b22, fifo_wdata_b21          , fifo_wdata_b20            ,
						 fifo_wdata_b19          , fifo_wdata_b18, fifo_wdata_b17          , fifo_wdata_b16            ,
						 fifo_wdata_b15          , fifo_wdata_b14, fifo_wdata_b13          , fifo_wdata_b12            ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8             ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0           } ;

	assign fifo_wdata_buf_word =		 dma_fifo_src_addr_dec ?
						{fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0             ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8             ,
						 fifo_wdata_b15          , fifo_wdata_b14, fifo_wdata_b13          , fifo_wdata_b12            ,
						 fifo_wdata_b19          , fifo_wdata_b18, fifo_wdata_b17          , fifo_wdata_b16            ,
						 fifo_wdata_b23          , fifo_wdata_b22, fifo_wdata_b21          , fifo_wdata_b20            ,
						 fifo_wdata_b27          , fifo_wdata_b26, fifo_wdata_b25          , fifo_wdata_b24            ,
						                                                                     fifo_wdata_aligned[31:0]} :
						{fifo_wdata_aligned[31:0]                                                                      ,
						 fifo_wdata_b27          , fifo_wdata_b26, fifo_wdata_b25          , fifo_wdata_b24            ,
						 fifo_wdata_b23          , fifo_wdata_b22, fifo_wdata_b21          , fifo_wdata_b20            ,
						 fifo_wdata_b19          , fifo_wdata_b18, fifo_wdata_b17          , fifo_wdata_b16            ,
						 fifo_wdata_b15          , fifo_wdata_b14, fifo_wdata_b13          , fifo_wdata_b12            ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8             ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0           } ;

	assign fifo_wdata_buf_hword =		 dma_fifo_src_addr_dec ?
						{fifo_wdata_b1           , fifo_wdata_b0 , fifo_wdata_b3           , fifo_wdata_b2             ,
						 fifo_wdata_b5           , fifo_wdata_b4 , fifo_wdata_b7           , fifo_wdata_b6             ,
						 fifo_wdata_b9           , fifo_wdata_b8 , fifo_wdata_b11          , fifo_wdata_b10            ,
						 fifo_wdata_b13          , fifo_wdata_b12, fifo_wdata_b15          , fifo_wdata_b14            ,
						 fifo_wdata_b17          , fifo_wdata_b16, fifo_wdata_b19          , fifo_wdata_b18            ,
						 fifo_wdata_b21          , fifo_wdata_b20, fifo_wdata_b23          , fifo_wdata_b22            ,
						 fifo_wdata_b25          , fifo_wdata_b24, fifo_wdata_b27          , fifo_wdata_b26            ,
						 fifo_wdata_b29          , fifo_wdata_b28,                           fifo_wdata_aligned[15:0]} :
						{fifo_wdata_aligned[15:0]                , fifo_wdata_b29          , fifo_wdata_b28            ,
						 fifo_wdata_b27          , fifo_wdata_b26, fifo_wdata_b25          , fifo_wdata_b24            ,
						 fifo_wdata_b23          , fifo_wdata_b22, fifo_wdata_b21          , fifo_wdata_b20            ,
						 fifo_wdata_b19          , fifo_wdata_b18, fifo_wdata_b17          , fifo_wdata_b16            ,
						 fifo_wdata_b15          , fifo_wdata_b14, fifo_wdata_b13          , fifo_wdata_b12            ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8             ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0           } ;

	assign fifo_wdata_buf_byte =		 dma_fifo_src_addr_dec ?
						{fifo_wdata_b0           , fifo_wdata_b1 , fifo_wdata_b2           , fifo_wdata_b3             ,
						 fifo_wdata_b4           , fifo_wdata_b5 , fifo_wdata_b6           , fifo_wdata_b7             ,
						 fifo_wdata_b8           , fifo_wdata_b9 , fifo_wdata_b10          , fifo_wdata_b11            ,
						 fifo_wdata_b12          , fifo_wdata_b13, fifo_wdata_b14          , fifo_wdata_b15            ,
						 fifo_wdata_b16          , fifo_wdata_b17, fifo_wdata_b18          , fifo_wdata_b19            ,
						 fifo_wdata_b20          , fifo_wdata_b21, fifo_wdata_b22          , fifo_wdata_b23            ,
						 fifo_wdata_b24          , fifo_wdata_b25, fifo_wdata_b26          , fifo_wdata_b27            ,
						 fifo_wdata_b28          , fifo_wdata_b29, fifo_wdata_b30          , fifo_wdata_aligned[ 7:0]} :
						{fifo_wdata_aligned[ 7:0], fifo_wdata_b30, fifo_wdata_b29          , fifo_wdata_b28            ,
						 fifo_wdata_b27          , fifo_wdata_b26, fifo_wdata_b25          , fifo_wdata_b24            ,
						 fifo_wdata_b23          , fifo_wdata_b22, fifo_wdata_b21          , fifo_wdata_b20            ,
						 fifo_wdata_b19          , fifo_wdata_b18, fifo_wdata_b17          , fifo_wdata_b16            ,
						 fifo_wdata_b15          , fifo_wdata_b14, fifo_wdata_b13          , fifo_wdata_b12            ,
						 fifo_wdata_b11          , fifo_wdata_b10, fifo_wdata_b9           , fifo_wdata_b8             ,
						 fifo_wdata_b7           , fifo_wdata_b6 , fifo_wdata_b5           , fifo_wdata_b4             ,
						 fifo_wdata_b3           , fifo_wdata_b2 , fifo_wdata_b1           , fifo_wdata_b0           } ;

	assign fifo_wdata = data_width_eight_word  ? dma_fifo_wdata :
			    data_width_quad_word   ? fifo_wdata_buf_quad_word :
			    data_width_double_word ? fifo_wdata_buf_double_word :
                            data_width_word        ? fifo_wdata_buf_word :
			    data_width_hword       ? fifo_wdata_buf_hword :
                                                     fifo_wdata_buf_byte;

`endif // ATCDMAC300_DATA_WIDTH_256
//-----------------------------------------------------------------------------------------------------------------------------------------------
assign fifo_wdata_b0		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b0_wen) ? fifo_wdata_b0_nxt : fifo_wdata_b0_buf;
assign fifo_wdata_b1		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b1_wen) ? fifo_wdata_b1_nxt : fifo_wdata_b1_buf;
assign fifo_wdata_b2		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b2_wen) ? fifo_wdata_b2_nxt : fifo_wdata_b2_buf;
assign fifo_wdata_b0_nxt 	=										fifo_wdata_aligned[ 7: 0];
assign fifo_wdata_b1_nxt	= (data_width_byte 			) ?	fifo_wdata_aligned[ 7: 0] : 	fifo_wdata_aligned[15: 8];
assign fifo_wdata_b2_nxt 	= (data_width_byte || data_width_hword	) ?	fifo_wdata_aligned[ 7: 0] :	fifo_wdata_aligned[23:16];

assign fifo_wdata_b0_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == {BYTE_OFFSET_WIDTH{1'h0}}))
				|| (data_width_hword       && (byte_offset == {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				|| (data_width_word        && (byte_offset == {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (data_width_double_word && (byte_offset == {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (byte_offset == {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
	`endif
				);
assign fifo_wdata_b1_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == {{BYTE_OFFSET_WIDTH-1{1'h0}}, 1'd1}))
				|| (data_width_hword       && (byte_offset ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				|| (data_width_word        && (byte_offset ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (data_width_double_word && (byte_offset ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (byte_offset ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
	`endif
				);
assign fifo_wdata_b2_wen = dma_fifo_wr && (
				   (data_width_byte        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-1{1'h0}}, 2'd2}))
				|| (data_width_hword       && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-1{1'h0}}, 2'd2}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				|| (data_width_word        && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (data_width_double_word && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
	`endif
				);

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b0_buf <= 8'b0;
		else if (fifo_wdata_b0_wen)
			fifo_wdata_b0_buf <= fifo_wdata_b0_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b1_buf <= 8'b0;
		else if (fifo_wdata_b1_wen)
			fifo_wdata_b1_buf <= fifo_wdata_b1_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b2_buf <= 8'b0;
		else if (fifo_wdata_b2_wen)
			fifo_wdata_b2_buf <= fifo_wdata_b2_nxt;
//-----------------------------------------------------------------------------------------------------------------------------------------------
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
assign fifo_wdata_b3		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b3_wen) ? fifo_wdata_b3_nxt : fifo_wdata_b3_buf;
assign fifo_wdata_b4		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b4_wen) ? fifo_wdata_b4_nxt : fifo_wdata_b4_buf;
assign fifo_wdata_b5		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b5_wen) ? fifo_wdata_b5_nxt : fifo_wdata_b5_buf;
assign fifo_wdata_b6		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b6_wen) ? fifo_wdata_b6_nxt : fifo_wdata_b6_buf;

assign fifo_wdata_b3_nxt	=  data_width_byte 					    ? fifo_wdata_aligned[ 7: 0] :
				   data_width_hword					    ? fifo_wdata_aligned[15: 8] : fifo_wdata_aligned[31:24] ;
assign fifo_wdata_b4_nxt	= (data_width_byte  || data_width_hword || data_width_word) ? fifo_wdata_aligned[ 7: 0] : fifo_wdata_aligned[39:32];
assign fifo_wdata_b5_nxt	=  data_width_byte 					    ? fifo_wdata_aligned[ 7: 0] :
				  (data_width_hword || data_width_word) 		    ? fifo_wdata_aligned[15: 8] : fifo_wdata_aligned[47:40];
assign fifo_wdata_b6_nxt	= (data_width_byte  || data_width_hword)		    ? fifo_wdata_aligned[ 7: 0] :
				   data_width_word					    ? fifo_wdata_aligned[23:16] : fifo_wdata_aligned[55:48];


assign fifo_wdata_b3_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 2'd3}))
				|| (data_width_hword       && (byte_offset == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 2'd2}))
				|| (data_width_word        && (byte_offset ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (data_width_double_word && (byte_offset ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (byte_offset ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
				);

assign fifo_wdata_b4_wen = dma_fifo_wr && (
				   (data_width_byte        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
				|| (data_width_hword       && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
				|| (data_width_word        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (data_width_double_word && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
				);

assign fifo_wdata_b5_wen = dma_fifo_wr && (
				   (data_width_byte        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd5}))
				|| (data_width_hword       && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
				|| (data_width_word        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (data_width_double_word && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
				);

assign fifo_wdata_b6_wen = dma_fifo_wr && (
				   (data_width_byte        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd6}))
				|| (data_width_hword       && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd6}))
				|| (data_width_word        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (data_width_double_word && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
				);

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b3_buf <= 8'b0;
		else if (fifo_wdata_b3_wen)
			fifo_wdata_b3_buf <= fifo_wdata_b3_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b4_buf <= 8'b0;
		else if (fifo_wdata_b4_wen)
			fifo_wdata_b4_buf <= fifo_wdata_b4_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b5_buf <= 8'b0;
		else if (fifo_wdata_b5_wen)
			fifo_wdata_b5_buf <= fifo_wdata_b5_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b6_buf <= 8'b0;
		else if (fifo_wdata_b6_wen)
			fifo_wdata_b6_buf <= fifo_wdata_b6_nxt;
//-----------------------------------------------------------------------------------------------------------------------------------------------
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
assign fifo_wdata_b7		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b7_wen)  ? fifo_wdata_b7_nxt  : fifo_wdata_b7_buf;
assign fifo_wdata_b8		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b8_wen)  ? fifo_wdata_b8_nxt  : fifo_wdata_b8_buf;
assign fifo_wdata_b9		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b9_wen)  ? fifo_wdata_b9_nxt  : fifo_wdata_b9_buf;
assign fifo_wdata_b10		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b10_wen) ? fifo_wdata_b10_nxt : fifo_wdata_b10_buf;
assign fifo_wdata_b11		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b11_wen) ? fifo_wdata_b11_nxt : fifo_wdata_b11_buf;
assign fifo_wdata_b12		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b12_wen) ? fifo_wdata_b12_nxt : fifo_wdata_b12_buf;
assign fifo_wdata_b13		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b13_wen) ? fifo_wdata_b13_nxt : fifo_wdata_b13_buf;
assign fifo_wdata_b14		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b14_wen) ? fifo_wdata_b14_nxt : fifo_wdata_b14_buf;

assign fifo_wdata_b7_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
				  (data_width_hword) 				? fifo_wdata_aligned[ 15:  8] :
				  (data_width_word)				? fifo_wdata_aligned[ 31: 24] :
										  fifo_wdata_aligned[ 63: 56] ;

assign fifo_wdata_b8_nxt	= (data_width_byte  || data_width_hword || data_width_word || data_width_double_word)
										? fifo_wdata_aligned[  7:  0] :
										  fifo_wdata_aligned[ 71: 64] ;

assign fifo_wdata_b9_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
				  (data_width_hword || data_width_word || data_width_double_word)
										? fifo_wdata_aligned[ 15:  8] :
										  fifo_wdata_aligned[ 79: 72] ;

assign fifo_wdata_b10_nxt	= (data_width_byte  || data_width_hword)	? fifo_wdata_aligned[  7:  0] :
				  (data_width_word  || data_width_double_word)	? fifo_wdata_aligned[ 23: 16] :
										  fifo_wdata_aligned[ 87: 80] ;

assign fifo_wdata_b11_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
				  (data_width_hword)				? fifo_wdata_aligned[ 15:  8] :
				  (data_width_word  || data_width_double_word)	? fifo_wdata_aligned[ 31: 24] :
										  fifo_wdata_aligned[ 95: 88] ;

assign fifo_wdata_b12_nxt	= (data_width_byte  || data_width_hword || data_width_word)
										? fifo_wdata_aligned[  7:  0] :
				  (data_width_double_word)			? fifo_wdata_aligned[ 39: 32] :
										  fifo_wdata_aligned[103: 96] ;

assign fifo_wdata_b13_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
				  (data_width_hword || data_width_word)		? fifo_wdata_aligned[ 15:  8] :
				  (data_width_double_word)			? fifo_wdata_aligned[ 47: 40] :
										  fifo_wdata_aligned[111:104] ;

assign fifo_wdata_b14_nxt	= (data_width_byte  || data_width_hword)	? fifo_wdata_aligned[  7:  0] :
				  (data_width_word)				? fifo_wdata_aligned[ 23: 16] :
				  (data_width_double_word)			? fifo_wdata_aligned[ 55: 48] :
										  fifo_wdata_aligned[119:112] ;
assign fifo_wdata_b7_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 3'd7}))
				|| (data_width_hword       && (byte_offset == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 3'd6}))
				|| (data_width_word        && (byte_offset == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 3'd4}))
				|| (data_width_double_word && (byte_offset ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (byte_offset ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign fifo_wdata_b8_wen = dma_fifo_wr && (
				   (data_width_byte        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (data_width_hword       && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (data_width_word        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (data_width_double_word && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign fifo_wdata_b9_wen = dma_fifo_wr && (
				   (data_width_byte        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd9}))
				|| (data_width_hword       && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (data_width_word        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (data_width_double_word && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign fifo_wdata_b10_wen = dma_fifo_wr && (
				   (data_width_byte        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd10}))
				|| (data_width_hword       && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd10}))
				|| (data_width_word        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (data_width_double_word && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign fifo_wdata_b11_wen = dma_fifo_wr && (
				   (data_width_byte        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd11}))
				|| (data_width_hword       && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd10}))
				|| (data_width_word        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (data_width_double_word && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign fifo_wdata_b12_wen = dma_fifo_wr && (
				   (data_width_byte        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (data_width_hword       && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (data_width_word        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (data_width_double_word && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign fifo_wdata_b13_wen = dma_fifo_wr && (
				   (data_width_byte        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd13}))
				|| (data_width_hword       && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (data_width_word        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (data_width_double_word && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign fifo_wdata_b14_wen = dma_fifo_wr && (
				   (data_width_byte        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd14}))
				|| (data_width_hword       && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd14}))
				|| (data_width_word        && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (data_width_double_word && ({1'b0, byte_offset} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (data_width_quad_word   && (       byte_offset  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b7_buf <= 8'b0;
		else if (fifo_wdata_b7_wen)
			fifo_wdata_b7_buf <= fifo_wdata_b7_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b8_buf <= 8'b0;
		else if (fifo_wdata_b8_wen)
			fifo_wdata_b8_buf <= fifo_wdata_b8_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b9_buf <= 8'b0;
		else if (fifo_wdata_b9_wen)
			fifo_wdata_b9_buf <= fifo_wdata_b9_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b10_buf <= 8'b0;
		else if (fifo_wdata_b10_wen)
			fifo_wdata_b10_buf <= fifo_wdata_b10_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b11_buf <= 8'b0;
		else if (fifo_wdata_b11_wen)
			fifo_wdata_b11_buf <= fifo_wdata_b11_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b12_buf <= 8'b0;
		else if (fifo_wdata_b12_wen)
			fifo_wdata_b12_buf <= fifo_wdata_b12_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b13_buf <= 8'b0;
		else if (fifo_wdata_b13_wen)
			fifo_wdata_b13_buf <= fifo_wdata_b13_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b14_buf <= 8'b0;
		else if (fifo_wdata_b14_wen)
			fifo_wdata_b14_buf <= fifo_wdata_b14_nxt;
//-----------------------------------------------------------------------------------------------------------------------------------------------
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
assign fifo_wdata_b15		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b15_wen) ? fifo_wdata_b15_nxt : fifo_wdata_b15_buf;
assign fifo_wdata_b16		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b16_wen) ? fifo_wdata_b16_nxt : fifo_wdata_b16_buf;
assign fifo_wdata_b17		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b17_wen) ? fifo_wdata_b17_nxt : fifo_wdata_b17_buf;
assign fifo_wdata_b18		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b18_wen) ? fifo_wdata_b18_nxt : fifo_wdata_b18_buf;
assign fifo_wdata_b19		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b19_wen) ? fifo_wdata_b19_nxt : fifo_wdata_b19_buf;
assign fifo_wdata_b20		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b20_wen) ? fifo_wdata_b20_nxt : fifo_wdata_b20_buf;
assign fifo_wdata_b21		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b21_wen) ? fifo_wdata_b21_nxt : fifo_wdata_b21_buf;
assign fifo_wdata_b22		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b22_wen) ? fifo_wdata_b22_nxt : fifo_wdata_b22_buf;
assign fifo_wdata_b23		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b23_wen) ? fifo_wdata_b23_nxt : fifo_wdata_b23_buf;
assign fifo_wdata_b24		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b24_wen) ? fifo_wdata_b24_nxt : fifo_wdata_b24_buf;
assign fifo_wdata_b25		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b25_wen) ? fifo_wdata_b25_nxt : fifo_wdata_b25_buf;
assign fifo_wdata_b26		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b26_wen) ? fifo_wdata_b26_nxt : fifo_wdata_b26_buf;
assign fifo_wdata_b27		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b27_wen) ? fifo_wdata_b27_nxt : fifo_wdata_b27_buf;
assign fifo_wdata_b28		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b28_wen) ? fifo_wdata_b28_nxt : fifo_wdata_b28_buf;
assign fifo_wdata_b29		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b29_wen) ? fifo_wdata_b29_nxt : fifo_wdata_b29_buf;
assign fifo_wdata_b30		= (dma_fifo_wr & dma_fifo_last_wr & fifo_wdata_b30_wen) ? fifo_wdata_b30_nxt : fifo_wdata_b30_buf;

assign fifo_wdata_b15_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
				  (data_width_hword)				? fifo_wdata_aligned[ 15:  8] :
				  (data_width_word)				? fifo_wdata_aligned[ 31: 24] :
				  (data_width_double_word)			? fifo_wdata_aligned[ 63: 56] :
										  fifo_wdata_aligned[127:120] ;

assign fifo_wdata_b16_nxt	= 						  fifo_wdata_aligned[  7:  0] ;

assign fifo_wdata_b17_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
										  fifo_wdata_aligned[ 15:  8] ;

assign fifo_wdata_b18_nxt	= (data_width_byte  || data_width_hword)	? fifo_wdata_aligned[  7:  0] :
										  fifo_wdata_aligned[ 23: 16] ;

assign fifo_wdata_b19_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
				  (data_width_hword)				? fifo_wdata_aligned[ 15:  8] :
										  fifo_wdata_aligned[ 31: 24] ;

assign fifo_wdata_b20_nxt	= (data_width_byte  || data_width_hword  || data_width_word)
										? fifo_wdata_aligned[  7:  0] :
										  fifo_wdata_aligned[ 39: 32] ;

assign fifo_wdata_b21_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
				  (data_width_hword || data_width_word)		? fifo_wdata_aligned[ 15:  8] :
										  fifo_wdata_aligned[ 47: 40] ;

assign fifo_wdata_b22_nxt	= (data_width_byte  ||data_width_hword)		? fifo_wdata_aligned[  7:  0] :
				  (data_width_word)				? fifo_wdata_aligned[ 23: 16] :
										  fifo_wdata_aligned[ 55: 48] ;

assign fifo_wdata_b23_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
				  (data_width_hword)				? fifo_wdata_aligned[ 15:  8] :
				  (data_width_word)				? fifo_wdata_aligned[ 31: 24] :
										  fifo_wdata_aligned[ 63: 56] ;

assign fifo_wdata_b24_nxt	= (data_width_byte  || data_width_hword  || data_width_word || data_width_double_word)
										? fifo_wdata_aligned[  7:  0] :
										  fifo_wdata_aligned[ 71: 64] ;

assign fifo_wdata_b25_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
				  (data_width_hword || data_width_word   || data_width_double_word)
										? fifo_wdata_aligned[ 15:  8] :
										  fifo_wdata_aligned[ 79: 72] ;

assign fifo_wdata_b26_nxt	= (data_width_byte  || data_width_hword)	? fifo_wdata_aligned[  7:  0] :
				  (data_width_word  || data_width_double_word)	? fifo_wdata_aligned[ 23: 16] :
										  fifo_wdata_aligned[ 87: 80] ;

assign fifo_wdata_b27_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
				  (data_width_hword)				? fifo_wdata_aligned[ 15:  8] :
				  (data_width_word  || data_width_double_word)	? fifo_wdata_aligned[ 31: 24] :
										  fifo_wdata_aligned[ 95: 88] ;

assign fifo_wdata_b28_nxt	= (data_width_byte  || data_width_hword  ||data_width_word )
										? fifo_wdata_aligned[  7:  0] :
				  (data_width_double_word)			? fifo_wdata_aligned[ 39: 32] :
										  fifo_wdata_aligned[103: 96] ;

assign fifo_wdata_b29_nxt	= (data_width_byte)				? fifo_wdata_aligned[  7:  0] :
				  (data_width_hword || data_width_word)		? fifo_wdata_aligned[ 15:  8] :
				  (data_width_double_word)			? fifo_wdata_aligned[ 47: 40] :
										  fifo_wdata_aligned[111:104] ;

assign fifo_wdata_b30_nxt	= (data_width_byte  ||data_width_hword)		? fifo_wdata_aligned[  7:  0] :
				  (data_width_word)				? fifo_wdata_aligned[ 23: 16] :
				  (data_width_double_word)			? fifo_wdata_aligned[ 55: 48] :
										  fifo_wdata_aligned[119:112] ;

assign fifo_wdata_b15_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == {1'h0, 4'd15}))
				|| (data_width_hword       && (byte_offset == {1'h0, 4'd14}))
				|| (data_width_word        && (byte_offset == {1'h0, 4'd12}))
				|| (data_width_double_word && (byte_offset == {1'h0, 4'd8}))
				|| (data_width_quad_word   && (byte_offset ==  5'h0)));

assign fifo_wdata_b16_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd16))
				|| (data_width_hword       && (byte_offset == 5'd16))
				|| (data_width_word        && (byte_offset == 5'd16))
				|| (data_width_double_word && (byte_offset == 5'd16))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b17_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd17))
				|| (data_width_hword       && (byte_offset == 5'd16))
				|| (data_width_word        && (byte_offset == 5'd16))
				|| (data_width_double_word && (byte_offset == 5'd16))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b18_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd18))
				|| (data_width_hword       && (byte_offset == 5'd18))
				|| (data_width_word        && (byte_offset == 5'd16))
				|| (data_width_double_word && (byte_offset == 5'd16))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b19_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd19))
				|| (data_width_hword       && (byte_offset == 5'd18))
				|| (data_width_word        && (byte_offset == 5'd16))
				|| (data_width_double_word && (byte_offset == 5'd16))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b20_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd20))
				|| (data_width_hword       && (byte_offset == 5'd20))
				|| (data_width_word        && (byte_offset == 5'd20))
				|| (data_width_double_word && (byte_offset == 5'd16))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b21_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd21))
				|| (data_width_hword       && (byte_offset == 5'd20))
				|| (data_width_word        && (byte_offset == 5'd20))
				|| (data_width_double_word && (byte_offset == 5'd16))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b22_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd22))
				|| (data_width_hword       && (byte_offset == 5'd22))
				|| (data_width_word        && (byte_offset == 5'd20))
				|| (data_width_double_word && (byte_offset == 5'd16))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b23_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd23))
				|| (data_width_hword       && (byte_offset == 5'd22))
				|| (data_width_word        && (byte_offset == 5'd20))
				|| (data_width_double_word && (byte_offset == 5'd16))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b24_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd24))
				|| (data_width_hword       && (byte_offset == 5'd24))
				|| (data_width_word        && (byte_offset == 5'd24))
				|| (data_width_double_word && (byte_offset == 5'd24))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b25_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd25))
				|| (data_width_hword       && (byte_offset == 5'd24))
				|| (data_width_word        && (byte_offset == 5'd24))
				|| (data_width_double_word && (byte_offset == 5'd24))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b26_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd26))
				|| (data_width_hword       && (byte_offset == 5'd26))
				|| (data_width_word        && (byte_offset == 5'd24))
				|| (data_width_double_word && (byte_offset == 5'd24))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b27_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd27))
				|| (data_width_hword       && (byte_offset == 5'd26))
				|| (data_width_word        && (byte_offset == 5'd24))
				|| (data_width_double_word && (byte_offset == 5'd24))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b28_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd28))
				|| (data_width_hword       && (byte_offset == 5'd28))
				|| (data_width_word        && (byte_offset == 5'd28))
				|| (data_width_double_word && (byte_offset == 5'd24))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b29_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd29))
				|| (data_width_hword       && (byte_offset == 5'd28))
				|| (data_width_word        && (byte_offset == 5'd28))
				|| (data_width_double_word && (byte_offset == 5'd24))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

assign fifo_wdata_b30_wen = dma_fifo_wr && (
				   (data_width_byte        && (byte_offset == 5'd30))
				|| (data_width_hword       && (byte_offset == 5'd30))
				|| (data_width_word        && (byte_offset == 5'd28))
				|| (data_width_double_word && (byte_offset == 5'd24))
				|| (data_width_quad_word   && (byte_offset == 5'd16)));

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b15_buf <= 8'b0;
		else if (fifo_wdata_b15_wen)
			fifo_wdata_b15_buf <= fifo_wdata_b15_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b16_buf <= 8'b0;
		else if (fifo_wdata_b16_wen)
			fifo_wdata_b16_buf <= fifo_wdata_b16_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b17_buf <= 8'b0;
		else if (fifo_wdata_b17_wen)
			fifo_wdata_b17_buf <= fifo_wdata_b17_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b18_buf <= 8'b0;
		else if (fifo_wdata_b18_wen)
			fifo_wdata_b18_buf <= fifo_wdata_b18_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b19_buf <= 8'b0;
		else if (fifo_wdata_b19_wen)
			fifo_wdata_b19_buf <= fifo_wdata_b19_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b20_buf <= 8'b0;
		else if (fifo_wdata_b20_wen)
			fifo_wdata_b20_buf <= fifo_wdata_b20_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b21_buf <= 8'b0;
		else if (fifo_wdata_b21_wen)
			fifo_wdata_b21_buf <= fifo_wdata_b21_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b22_buf <= 8'b0;
		else if (fifo_wdata_b22_wen)
			fifo_wdata_b22_buf <= fifo_wdata_b22_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b23_buf <= 8'b0;
		else if (fifo_wdata_b23_wen)
			fifo_wdata_b23_buf <= fifo_wdata_b23_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b24_buf <= 8'b0;
		else if (fifo_wdata_b24_wen)
			fifo_wdata_b24_buf <= fifo_wdata_b24_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b25_buf <= 8'b0;
		else if (fifo_wdata_b25_wen)
			fifo_wdata_b25_buf <= fifo_wdata_b25_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b26_buf <= 8'b0;
		else if (fifo_wdata_b26_wen)
			fifo_wdata_b26_buf <= fifo_wdata_b26_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b27_buf <= 8'b0;
		else if (fifo_wdata_b27_wen)
			fifo_wdata_b27_buf <= fifo_wdata_b27_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b28_buf <= 8'b0;
		else if (fifo_wdata_b28_wen)
			fifo_wdata_b28_buf <= fifo_wdata_b28_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b29_buf <= 8'b0;
		else if (fifo_wdata_b29_wen)
			fifo_wdata_b29_buf <= fifo_wdata_b29_nxt;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			fifo_wdata_b30_buf <= 8'b0;
		else if (fifo_wdata_b30_wen)
			fifo_wdata_b30_buf <= fifo_wdata_b30_nxt;
`endif // ATCDMAC300_DATA_WIDTH_GE_256
`endif // ATCDMAC300_DATA_WIDTH_GE_128
`endif // ATCDMAC300_DATA_WIDTH_GE_64

endmodule
