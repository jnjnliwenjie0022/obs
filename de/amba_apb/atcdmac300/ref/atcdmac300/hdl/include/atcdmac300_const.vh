`ifdef ATCDMAC300_CONST_VH
`else
`define ATCDMAC300_CONST_VH

//-------------------------------------------------
// ATCDMAC300 ID and Revision Number
//-------------------------------------------------
`define ATCDMAC300_ID        32'h01023002

//-------------------------------------------------
// ATCDMAC300 Configuration
//-------------------------------------------------

`define ATCDMAC300_TTS_WIDTH 32

`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`define ATCDMAC300_CHAIN_TRANSFER_EXIST		1'b1
`else
	`define ATCDMAC300_CHAIN_TRANSFER_EXIST		1'b0
`endif
`ifdef ATCDMAC300_REQ_SYNC_SUPPORT
	`define ATCDMAC300_REQ_SYNC_EXIST		1'b1
`else
	`define ATCDMAC300_REQ_SYNC_EXIST		1'b0
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`define ATCDMAC300_DUAL_DMA_CORE_EXIST		1'b1
`else
	`define ATCDMAC300_DUAL_DMA_CORE_EXIST		1'b0
`endif
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	`define ATCDMAC300_DUAL_MASTER_IF_EXIST		1'b1
`else
	`define ATCDMAC300_DUAL_MASTER_IF_EXIST		1'b0
`endif
`ifdef ATCDMAC300_FIFO_DEPTH_4
	`define ATCDMAC300_FIFO_DEPTH 		6'd4
	`define ATCDMAC300_FIFO_POINTER_WIDTH	3
`else
`ifdef ATCDMAC300_FIFO_DEPTH_8
	`define ATCDMAC300_FIFO_DEPTH 		6'd8
	`define ATCDMAC300_FIFO_POINTER_WIDTH	4
`else
`ifdef ATCDMAC300_FIFO_DEPTH_16
	`define ATCDMAC300_FIFO_DEPTH 		6'd16
	`define ATCDMAC300_FIFO_POINTER_WIDTH	5
`else
`ifdef ATCDMAC300_FIFO_DEPTH_32
	`define ATCDMAC300_FIFO_DEPTH 		6'd32
	`define ATCDMAC300_FIFO_POINTER_WIDTH	6
`endif
`endif
`endif
`endif

`ifdef ATCDMAC300_CH_NUM_1
	`define ATCDMAC300_CH_NUM       4'h1
	`define DMAC_CONFIG_CH0
`else 
`ifdef ATCDMAC300_CH_NUM_2
	`define ATCDMAC300_CH_NUM       4'h2
	`define DMAC_CONFIG_CH0
	`define DMAC_CONFIG_CH1
`else 
`ifdef ATCDMAC300_CH_NUM_3
	`define ATCDMAC300_CH_NUM       4'h3
	`define DMAC_CONFIG_CH0
	`define DMAC_CONFIG_CH1
	`define DMAC_CONFIG_CH2
`else 
`ifdef ATCDMAC300_CH_NUM_4
	`define ATCDMAC300_CH_NUM       4'h4
	`define DMAC_CONFIG_CH0
	`define DMAC_CONFIG_CH1
	`define DMAC_CONFIG_CH2
	`define DMAC_CONFIG_CH3
`else 
`ifdef ATCDMAC300_CH_NUM_5
	`define ATCDMAC300_CH_NUM       4'h5
	`define DMAC_CONFIG_CH0
	`define DMAC_CONFIG_CH1
	`define DMAC_CONFIG_CH2
	`define DMAC_CONFIG_CH3
	`define DMAC_CONFIG_CH4
`else 
`ifdef ATCDMAC300_CH_NUM_6
	`define ATCDMAC300_CH_NUM       4'h6
	`define DMAC_CONFIG_CH0
	`define DMAC_CONFIG_CH1
	`define DMAC_CONFIG_CH2
	`define DMAC_CONFIG_CH3
	`define DMAC_CONFIG_CH4
	`define DMAC_CONFIG_CH5
`else 
`ifdef ATCDMAC300_CH_NUM_7
	`define ATCDMAC300_CH_NUM       4'h7
	`define DMAC_CONFIG_CH0
	`define DMAC_CONFIG_CH1
	`define DMAC_CONFIG_CH2
	`define DMAC_CONFIG_CH3
	`define DMAC_CONFIG_CH4
	`define DMAC_CONFIG_CH5
	`define DMAC_CONFIG_CH6
`else 
`ifdef ATCDMAC300_CH_NUM_8
	`define ATCDMAC300_CH_NUM       4'h8
	`define DMAC_CONFIG_CH0
	`define DMAC_CONFIG_CH1
	`define DMAC_CONFIG_CH2
	`define DMAC_CONFIG_CH3
	`define DMAC_CONFIG_CH4
	`define DMAC_CONFIG_CH5
	`define DMAC_CONFIG_CH6
	`define DMAC_CONFIG_CH7
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif

`ifdef ATCDMAC300_DATA_WIDTH_256
	`define ATCDMAC300_BYTE_OFFSET_WIDTH 5
	`define ATCDMAC300_DATA_WIDTH_GE_256
	`define ATCDMAC300_DATA_WIDTH_GE_128
	`define ATCDMAC300_DATA_WIDTH_GE_64
	`define DMA_DATA_WIDTH 256
	`define DMA_DATA_WIDTH_REG 2'd3
	`define DMA_WSTRB_WIDTH 32
    `ifdef ATCDMAC300_FIFO_DEPTH_4
	`define ATCDMAC300_FIFO_BYTE 11'd128	// 32 * 4 = 128
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_8
	`define ATCDMAC300_FIFO_BYTE 11'd256	// 32 * 8 = 256
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_16
	`define ATCDMAC300_FIFO_BYTE 11'd512	// 32 * 16 = 512
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_32
	`define ATCDMAC300_FIFO_BYTE 11'd1024	// 32 * 32 = 1024
    `endif
`else
`ifdef ATCDMAC300_DATA_WIDTH_128
	`define ATCDMAC300_BYTE_OFFSET_WIDTH 4
	`define ATCDMAC300_DATA_WIDTH_GE_128
	`define ATCDMAC300_DATA_WIDTH_GE_64
	`define DMA_DATA_WIDTH 128
	`define DMA_DATA_WIDTH_REG 2'd2
	`define DMA_WSTRB_WIDTH 16
    `ifdef ATCDMAC300_FIFO_DEPTH_4
	`define ATCDMAC300_FIFO_BYTE 11'd64	// 16 * 4 = 64
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_8
	`define ATCDMAC300_FIFO_BYTE 11'd128	// 16 * 8 = 128
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_16
	`define ATCDMAC300_FIFO_BYTE 11'd256	// 16 * 16 = 256
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_32
	`define ATCDMAC300_FIFO_BYTE 11'd512	// 16 * 32 = 512
    `endif
`else
`ifdef ATCDMAC300_DATA_WIDTH_64
	`define ATCDMAC300_BYTE_OFFSET_WIDTH 3
	`define ATCDMAC300_DATA_WIDTH_GE_64
	`define DMA_DATA_WIDTH 64
	`define DMA_DATA_WIDTH_REG 2'd1
	`define DMA_WSTRB_WIDTH 8
    `ifdef ATCDMAC300_FIFO_DEPTH_4
	`define ATCDMAC300_FIFO_BYTE 11'd32	// 8 * 4 = 32
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_8
	`define ATCDMAC300_FIFO_BYTE 11'd64	// 8 * 8 = 64
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_16
	`define ATCDMAC300_FIFO_BYTE 11'd128	// 8 * 16 = 128
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_32
	`define ATCDMAC300_FIFO_BYTE 11'd256	// 8 * 32 = 256
    `endif
`else
`ifdef ATCDMAC300_DATA_WIDTH_32
	`define ATCDMAC300_BYTE_OFFSET_WIDTH 2
	`define DMA_DATA_WIDTH 32
	`define DMA_DATA_WIDTH_REG 2'd0
	`define DMA_WSTRB_WIDTH 4
    `ifdef ATCDMAC300_FIFO_DEPTH_4
	`define ATCDMAC300_FIFO_BYTE 11'd16	// 4 * 4 = 16
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_8
	`define ATCDMAC300_FIFO_BYTE 11'd32	// 4 * 8 = 32
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_16
	`define ATCDMAC300_FIFO_BYTE 11'd64	// 4 * 16 = 64
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_32
	`define ATCDMAC300_FIFO_BYTE 11'd128	// 4 * 32 = 128
    `endif
`else
	`define ATCDMAC300_DATA_WIDTH_32
	`define ATCDMAC300_BYTE_OFFSET_WIDTH 2
	`define DMA_DATA_WIDTH 32
	`define DMA_DATA_WIDTH_REG 2'd0
	`define DMA_WSTRB_WIDTH 4
    `ifdef ATCDMAC300_FIFO_DEPTH_4
	`define ATCDMAC300_FIFO_BYTE 11'd16	// 4 * 4 = 16
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_8
	`define ATCDMAC300_FIFO_BYTE 11'd32	// 4 * 8 = 32
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_16
	`define ATCDMAC300_FIFO_BYTE 11'd64	// 4 * 16 = 64
    `endif
    `ifdef ATCDMAC300_FIFO_DEPTH_32
	`define ATCDMAC300_FIFO_BYTE 11'd128	// 4 * 32 = 128
    `endif
`endif
`endif
`endif
`endif

`endif // ATCDMAC300_CONST_VH

