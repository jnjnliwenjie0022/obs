// *** Macros ***
// NDS_DELAY_MAX: The maximum amount of delay cycles between normal transfers.
// NDS_XM1_WITH: Additional inline constraints.
//

`ifndef NDS_DELAY_MAX
	`define	NDS_DELAY_MAX	10
`endif

`ifndef NDS_ROUND_NUM
	`define NDS_ROUND_NUM 40
`endif

`define DESC_Q `NDS_BENCH.descriptor_queue[i]


localparam DATA_BYTES = `DMA_WSTRB_WIDTH;
localparam ADDR_WIDTH = `ATCDMAC300_ADDR_WIDTH;

localparam MEM_WIDTH = `NDS_MEM_ADDR_WIDTH;
localparam MEM_MSB = `NDS_MEM_ADDR_WIDTH - 1;

enum {	ID_AND_REVISION_REGISTER_ADDR = 32'h0,
	DMAC_CONFIGURATION_REGISTER_ADDR = 32'h10,
	DMAC_CONTROL_REGISTER_ADDR = 32'h20,
	CHANNEL_ABORT_REGISTER_ADDR = 32'h24,
	INTERRUPT_STATUS_REGISTER_ADDR = 32'h30,
	CHANNEL_ENABLE_REGISTER_ADDR=32'h34,
	CHANNEL_CONTROL_REGISTER_ADDR=32'h40,

	MAX_WAIT_CYCLE = 1000,

	ROUND_NUM = `NDS_ROUND_NUM

} REGISTER_ADDR;


	localparam CHAIN_TRANSFER_SUPPORT = 
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		1;
	`else
		0;
	`endif

	localparam REQ_SYNC_SUPPORT = 
	`ifdef ATCDMAC300_REQ_SYNC_SUPPORT
		1;
	`else
		0;
	`endif	

	localparam DUAL_DMA_CORE_SUPPORT = 
	`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		1;
	`else
		0;
	`endif

	localparam DUAL_MASTER_IF_SUPPORT = 
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		1;
	`else
		0;
	`endif

class descriptor;
	bit 	 [31:0]	csr;
	rand bit [31:0]	tot;
	rand bit [63:0]	src;
	rand bit [63:0]	dst;
	rand bit [63:0]	llp;
	rand bit [63:0] last_llp;
	// csr: [SrcBusInfIdx, DstBusInfIdx, Priority, Reserved, SrcBurstSize, SrcWidth, DstWidth, SrcMode, DstMode, SrcAddrCtrl, DstAddrCtrl,
	//	    31              30          29        28          27-24     23-21     20-18      17       16        15-14       13-12
	//	 SrcReqSel, DstReqSel, IntAbtMask, IntErrMask, IntTCMask, Enable]
	//	    11-8      7-4          3           2           1        0

	rand bit 	SrcBusInfIdx;
	rand bit 	DstBusInfIdx;
	rand bit 	Priority;
	rand bit [ 3:0] SrcBurstSize;
	rand bit [ 2:0] SrcWidth;
	rand bit [ 2:0] DstWidth;
	rand bit 	SrcMode_random;
	rand bit 	DstMode_random;
	rand bit [ 1:0] SrcAddrCtrl;
	rand bit [ 1:0] DstAddrCtrl;
	rand bit [ 3:0] SrcReqSel;
	rand bit [ 3:0] DstReqSel;
	rand bit 	IntAbtMask;
	rand bit 	IntErrMask;
	rand bit 	IntTCMask;
	rand bit	Enable;

	// llp: [LLPointerH, LLPointerL, Reserved, LLDBusInfIdx]
	//         63-32        31-2         1           0
	rand bit	LLDBusInfIdx;

	rand bit [64:0] src_lower;
	rand bit [64:0] src_upper;
	rand bit [64:0] dst_lower;
	rand bit [64:0] dst_upper;

	rand bit	invalid_csr;
	rand bit	invalid_tot;
	rand bit	invalid_src;
	rand bit	invalid_dst;
	rand bit	invalid_desc; // to test the error interrupt handling, invalid desc will be generated to verify if dmac300 can actually detect and issue the err_int.
	
	bit [`ATCDMAC300_ADDR_WIDTH-1:0] mem_addr_mask = (1 << MEM_WIDTH) - 1;

	bit 	SrcMode;
	bit 	DstMode;

	integer	chain; // chain number

	bit first_desc = 0; // for coverage

	bit [63:0]	r_capacity = 0;
	bit [63:0]	w_capacity = 0;

	constraint c_invalid_desc {
		solve invalid_desc before invalid_csr, invalid_tot, invalid_src, invalid_dst;
		solve invalid_csr, invalid_tot, invalid_src, invalid_dst before tot, src, dst, llp;
		solve invalid_csr, invalid_tot, invalid_src, invalid_dst before Priority,SrcBurstSize,SrcWidth,DstWidth,SrcMode_random,DstMode_random,SrcAddrCtrl,DstAddrCtrl,SrcReqSel,DstReqSel,IntAbtMask,IntErrMask,IntTCMask,Enable;	

		if (first_desc == 1) {
			invalid_desc == 0;
		}
		else {
			invalid_desc dist { // invalid dstp:normal desc = 10%:90%
				1 := 10,
				0 := 90
			};
		}

		//invalid_desc == 1;

		if (invalid_desc == 1) {
			// one or more term of configuration is illegal if invalid_desc==1.
			invalid_csr || invalid_tot || invalid_src || invalid_dst == 1;
		}
		else {
			// normal desc is unaccepted to content any illegal configuration.
			invalid_csr == 0;
			invalid_tot == 0;
			invalid_src == 0;
			invalid_dst == 0;
		}
	}

	constraint c_boundary {
		solve src before src_lower, src_upper;
		solve dst before dst_lower, dst_upper;

		if(SrcAddrCtrl == 0) {
			src_lower == src;
			src_upper == src + (tot << SrcWidth);
		 }
		else if (SrcAddrCtrl == 1) {
			src_lower == src + (1 << SrcWidth) - (tot << SrcWidth);
			src_upper == src + (1 << SrcWidth);
		 }
		else {
			src_lower == src;
			src_upper == src + (1 << SrcWidth);
		}

		if(DstAddrCtrl == 0) {
			dst_lower == dst;
			dst_upper == dst + (tot << SrcWidth);
		 }
		else if (DstAddrCtrl == 1) {
			dst_lower == dst + (1 << DstWidth) - (tot << SrcWidth);
			dst_upper == dst + (1 << DstWidth);
		 }
		else {
			dst_lower == dst;
			dst_upper == dst + (1 << DstWidth);
		}
	}

	constraint c_src {
		solve tot		before src;
		solve SrcBusInfIdx	before dst;
		solve DstBusInfIdx	before dst;
		solve Priority		before src;
		solve SrcBurstSize 	before src;
		solve SrcWidth	  	before src;
		solve DstWidth	  	before src;
		solve SrcMode_random	before src;
		solve DstMode_random	before src;
		solve SrcAddrCtrl 	before src;
		solve DstAddrCtrl 	before src;
		solve SrcReqSel	 	before src;
		solve DstReqSel	 	before src;
		solve IntAbtMask 	before src;
		solve IntErrMask 	before src;
		solve IntTCMask	 	before src;
		solve Enable	 	before src;
		
		(src & ~(64'(1<<ADDR_WIDTH)-1)) == 0; // can't access out of range

		if(invalid_src == 0) {
			// normal desc
			src % (1 << SrcWidth) == 0; // size alignment
		}
		else {
			// invalid desc
			src % (1 << SrcWidth) != 0; // size unaligned
		}

		if(SrcAddrCtrl == 0) {
			65'(src) + (tot << SrcWidth) <= 65'(1 << ADDR_WIDTH);

			foreach(`DESC_Q) {
				if(`DESC_Q.SrcBusInfIdx == SrcBusInfIdx) {
					((src + (tot << SrcWidth)) <= `DESC_Q.src_lower) || (src >= `DESC_Q.src_upper); // source region can't overlap with other descriptors'
				}

				if(`DESC_Q.llp[0] == SrcBusInfIdx) {
					((((src + (tot << SrcWidth)) >> MEM_WIDTH) == (src >> MEM_WIDTH)) && ((((src + (tot << SrcWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) || (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= (src & mem_addr_mask)))) ||
					((((src + (tot << SrcWidth)) >> MEM_WIDTH) != (src >> MEM_WIDTH)) && ((((src + (tot << SrcWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) && (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= (src & mem_addr_mask)))); // source region can't overlap with other llp'
				}
			 }
		 }
		else if (SrcAddrCtrl == 1) {
			65'(src) + (1 << SrcWidth) >= (tot << SrcWidth);
			65'(src) + (1 << SrcWidth) <= 65'(1 << ADDR_WIDTH);

			foreach(`DESC_Q) {
				if(`DESC_Q.SrcBusInfIdx == SrcBusInfIdx) {
					((src + (1 << SrcWidth)) <= `DESC_Q.src_lower) || ((src + (1 << SrcWidth) - (tot << SrcWidth)) >= `DESC_Q.src_upper); // source region can't overlap with other descriptors'
				}

				if(`DESC_Q.llp[0] == SrcBusInfIdx) {
					((((src + (1 << SrcWidth)) >> MEM_WIDTH) == ((src + (1 << SrcWidth) - (tot << SrcWidth)) >> MEM_WIDTH)) && ((((src + (1 << SrcWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) || (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= ((src + (1 << SrcWidth) - (tot << SrcWidth)) & mem_addr_mask)))) ||
					((((src + (1 << SrcWidth)) >> MEM_WIDTH) != ((src + (1 << SrcWidth) - (tot << SrcWidth)) >> MEM_WIDTH)) && ((((src + (1 << SrcWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) && (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= ((src + (1 << SrcWidth) - (tot << SrcWidth)) & mem_addr_mask)))); // source region can't overlap with other llp'
				}
			 }
		 }
		else {
			65'(src) + (1 << SrcWidth) <= 65'(1 << ADDR_WIDTH);

			foreach(`DESC_Q) {
				if(`DESC_Q.SrcBusInfIdx == SrcBusInfIdx) {
					((src + (1 << SrcWidth)) <= `DESC_Q.src_lower) || (src >= `DESC_Q.src_upper); // source region can't overlap with other descriptors'
				}

				if(`DESC_Q.llp[0] == SrcBusInfIdx) {
					((((src + (1 << SrcWidth)) >> MEM_WIDTH) == (src >> MEM_WIDTH)) && ((((src + (1 << SrcWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) || (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= (src & mem_addr_mask)))) ||
					((((src + (1 << SrcWidth)) >> MEM_WIDTH) != (src >> MEM_WIDTH)) && ((((src + (1 << SrcWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) && (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= (src & mem_addr_mask)))); // source region can't overlap with other llp'
				}
			 }
		}
	}

	constraint c_dst {
		solve tot		before dst;
		solve SrcBusInfIdx	before dst;
		solve DstBusInfIdx	before dst;
		solve Priority		before dst;	
		solve SrcBurstSize 	before dst;
		solve SrcWidth	  	before dst;
		solve DstWidth	  	before dst;
		solve SrcMode_random	before dst;
		solve DstMode_random	before dst;
		solve SrcAddrCtrl 	before dst;
		solve DstAddrCtrl 	before dst;
		solve SrcReqSel	 	before dst;
		solve DstReqSel	 	before dst;
		solve IntAbtMask 	before dst;
		solve IntErrMask 	before dst;
		solve IntTCMask	 	before dst;
		solve Enable	 	before dst;

		(dst & ~(64'(1<<ADDR_WIDTH)-1)) == 0; // can't access out of range
	
		if(invalid_dst == 0) {
			// normal desc
			dst % (1 << DstWidth) == 0; // size alignment
		}
		else {
			// invalid desc
			dst % (1 << DstWidth) != 0; // size unaligned
		}

		if(DstAddrCtrl == 0) {
			65'(dst) + (tot << SrcWidth) <= 65'(1 << ADDR_WIDTH);

			foreach(`DESC_Q) {
				if(`DESC_Q.DstBusInfIdx == DstBusInfIdx) {
					((dst + (tot << SrcWidth)) <= `DESC_Q.dst_lower) || (dst >= `DESC_Q.dst_upper); // destination region can't overlap with other descriptors'
				}

				if(`DESC_Q.llp[0] == DstBusInfIdx) {
					((((dst + (tot << SrcWidth)) >> MEM_WIDTH) == (dst >> MEM_WIDTH)) && ((((dst + (tot << SrcWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) || (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= (dst & mem_addr_mask)))) ||
					((((dst + (tot << SrcWidth)) >> MEM_WIDTH) != (dst >> MEM_WIDTH)) && ((((dst + (tot << SrcWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) && (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= (dst & mem_addr_mask)))); // destination region can't overlap with other llp'
				}
			 }
		}
		else if (DstAddrCtrl == 1) {
			65'(dst) + (1 << DstWidth) >= (tot << SrcWidth);
			65'(dst) + (1 << DstWidth) <= 65'(1 << ADDR_WIDTH);

			foreach(`DESC_Q) {
				if(`DESC_Q.DstBusInfIdx == DstBusInfIdx) {
					((dst + (1 << DstWidth)) <= `DESC_Q.dst_lower) || ((dst + (1 << DstWidth) - (tot << SrcWidth)) >= `DESC_Q.dst_upper); // destination region can't overlap with other descriptors'
				}

				if(`DESC_Q.llp[0] == DstBusInfIdx) {
					((((dst + (1 << DstWidth)) >> MEM_WIDTH) == ((dst + (1 << DstWidth) - (tot << SrcWidth)) >> MEM_WIDTH)) && ((((dst + (1 << DstWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) || (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= ((dst + (1 << DstWidth) - (tot << SrcWidth)) & mem_addr_mask)))) ||
					((((dst + (1 << DstWidth)) >> MEM_WIDTH) != ((dst + (1 << DstWidth) - (tot << SrcWidth)) >> MEM_WIDTH)) && ((((dst + (1 << DstWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) && (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= ((dst + (1 << DstWidth) - (tot << SrcWidth)) & mem_addr_mask)))); // destination region can't overlap with other llp'
				}
			 }
		}
		else {
			65'(dst) + (1 << DstWidth) <= 65'(1 << ADDR_WIDTH);

			foreach(`DESC_Q) {
				if(`DESC_Q.DstBusInfIdx == DstBusInfIdx) {
					((dst + (1 << DstWidth)) <= `DESC_Q.dst_lower) || (dst >= `DESC_Q.dst_upper); // destination region can't overlap with other descriptors'
				}

				if(`DESC_Q.llp[0] == DstBusInfIdx) {
					((((dst + (1 << DstWidth)) >> MEM_WIDTH) == (dst >> MEM_WIDTH)) && ((((dst + (1 << DstWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) || (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= (dst & mem_addr_mask)))) ||
					((((dst + (1 << DstWidth)) >> MEM_WIDTH) != (dst >> MEM_WIDTH)) && ((((dst + (1 << DstWidth)) & mem_addr_mask) <= {`DESC_Q.llp[MEM_MSB:2],2'b0}) && (({`DESC_Q.llp[MEM_MSB:2],2'b0} + 32) <= (dst & mem_addr_mask)))); // destination region can't overlap with other llp'
				}
			 }
		}
	}
	constraint c_llp {
		solve LLDBusInfIdx	   before llp;
		solve src_lower, src_upper before llp;
		solve dst_lower, dst_upper before llp;

		`ifndef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			LLDBusInfIdx == 0; // only one master interface
		`endif

		llp[63:MEM_WIDTH] == 0; // can't access out of memory width
	
		llp != 0;
		llp != 1;

		llp[0] == LLDBusInfIdx; // interface
		llp[1] == 0; // Reserved
		llp[2] == 0; // link list point need be aligned on double-words. 
		({1'b0,llp[11:2],2'b0} + 13'd32) >> 12 == 0; // can't cross 4k boundary.
																														
		((src_lower[63:MEM_WIDTH] == src_upper[63:MEM_WIDTH]) && ((src_upper[MEM_MSB:0] <= {llp[MEM_MSB:2],2'b0}) || (({llp[MEM_MSB:2],2'b0} + 32) <= src_lower[MEM_MSB:0]))) || 
		((src_lower[63:MEM_WIDTH] != src_upper[63:MEM_WIDTH]) && ((src_upper[MEM_MSB:0] <= {llp[MEM_MSB:2],2'b0}) && (({llp[MEM_MSB:2],2'b0} + 32) <= src_lower[MEM_MSB:0]))); // llp region can't overlap with source

		((dst_lower[63:MEM_WIDTH] == dst_upper[63:MEM_WIDTH]) && ((dst_upper[MEM_MSB:0] <= {llp[MEM_MSB:2],2'b0}) || (({llp[MEM_MSB:2],2'b0} + 32) <= dst_lower[MEM_MSB:0]))) || 
		((dst_lower[63:MEM_WIDTH] != dst_upper[63:MEM_WIDTH]) && ((dst_upper[MEM_MSB:0] <= {llp[MEM_MSB:2],2'b0}) && (({llp[MEM_MSB:2],2'b0} + 32) <= dst_lower[MEM_MSB:0]))); // llp region can't overlap with destination

		foreach(`DESC_Q) {
			if(LLDBusInfIdx == `DESC_Q.llp[0]) {
				((llp + 32) <= `DESC_Q.llp) || (llp >= (`DESC_Q.llp + 32)); // llp can't oerlap with other llps
			}
                                                                                                                                                                                                                                                        
			if(LLDBusInfIdx == `DESC_Q.SrcBusInfIdx) {
				((`DESC_Q.src_lower[63:MEM_WIDTH] == `DESC_Q.src_upper[63:MEM_WIDTH]) && ((`DESC_Q.src_upper[MEM_MSB:0] <= {llp[MEM_MSB:2],2'b0}) || (({llp[MEM_MSB:2],2'b0} + 32) <= `DESC_Q.src_lower[MEM_MSB:0]))) || 
				((`DESC_Q.src_lower[63:MEM_WIDTH] != `DESC_Q.src_upper[63:MEM_WIDTH]) && ((`DESC_Q.src_upper[MEM_MSB:0] <= {llp[MEM_MSB:2],2'b0}) && (({llp[MEM_MSB:2],2'b0} + 32) <= `DESC_Q.src_lower[MEM_MSB:0]))); // llp region can't overlap with other source
			}

			if(LLDBusInfIdx == `DESC_Q.DstBusInfIdx) {
				((`DESC_Q.dst_lower[63:MEM_WIDTH] == `DESC_Q.dst_upper[63:MEM_WIDTH]) && ((`DESC_Q.dst_upper[MEM_MSB:0] <= {llp[MEM_MSB:2],2'b0}) || (({llp[MEM_MSB:2],2'b0} + 32) <= `DESC_Q.dst_lower[MEM_MSB:0]))) || 
				((`DESC_Q.dst_lower[63:MEM_WIDTH] != `DESC_Q.dst_upper[63:MEM_WIDTH]) && ((`DESC_Q.dst_upper[MEM_MSB:0] <= {llp[MEM_MSB:2],2'b0}) && (({llp[MEM_MSB:2],2'b0} + 32) <= `DESC_Q.dst_lower[MEM_MSB:0]))); // llp region can't overlap with other destination
			}
		}	
	}
	
	constraint c_last_llp {
		if(`NDS_BENCH.descriptor_queue.size() == 0) {
			last_llp == 0;
		} else {
			last_llp == `NDS_BENCH.descriptor_queue[`NDS_BENCH.descriptor_queue.size()-1].llp;
		}
	}
	
	constraint c_tot {
		if (first_desc == 1) {
			tot == 3000;
		}
		else {
			if(invalid_tot == 0) {
				// normal desc
				tot dist{
					[   1:  15] :/ 65,
					[  16: 127] :/ 30,
					[ 128:1024] :/ 5
				};
				
				`ifdef ATCDMAC300_DATA_WIDTH_256
				tot < 64;
				`endif
			}
			else {
				// invalid desc
				tot == 0;
			}
		}
	}

	constraint c_csr {
		solve tot		before SrcWidth, DstWidth;

		if(invalid_csr == 0) {
			// normal desc
			`ifndef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
				SrcBusInfIdx	== 0;
				DstBusInfIdx	== 0;
			`endif
			if (first_desc == 1) {
				SrcBurstSize  == 10;
				SrcWidth	== `DMA_DATA_SIZE;
				DstWidth	== `DMA_DATA_SIZE;
				SrcAddrCtrl	== 0;
				DstAddrCtrl	== 0;
			}
			else {
				SrcBurstSize  < 11;
				SrcWidth	<= `DMA_DATA_SIZE;
				DstWidth	<= `DMA_DATA_SIZE;
				SrcAddrCtrl	< 3;
				DstAddrCtrl	< 3;
			}

			(tot << SrcWidth) % (1 << DstWidth) == 0;
			((1 << SrcBurstSize) << SrcWidth) % (1 << DstWidth) == 0;
		}
		else {
			// invalid desc
			SrcBurstSize  >=  11;
			SrcWidth	> `DMA_DATA_SIZE		||
			DstWidth	> `DMA_DATA_SIZE		||
			SrcAddrCtrl	>= 3				||
			DstAddrCtrl	>= 3				||
			(tot << SrcWidth) % (1 << DstWidth) != 0	||
			((1 << SrcBurstSize) << SrcWidth) % (1 << DstWidth) != 0;
		}

		`ifdef NDS_COV_PRIORITY
		Priority == `NDS_COV_PRIORITY;
		`endif

		SrcReqSel	< `ATCDMAC300_REQ_ACK_NUM;
		DstReqSel	< `ATCDMAC300_REQ_ACK_NUM;
		SrcReqSel != DstReqSel;

		Enable	== 1;
	}

	function void post_randomize(); // avoiding two processing channels to use the same req/ack port, trun off the hand shake mode if the generated desc req/ack port havd been used by other desc
	begin
		SrcMode = SrcMode_random;
		DstMode = DstMode_random;
		foreach(`DESC_Q) begin
			if(((`DESC_Q.csr[11:8] == SrcReqSel) && (`DESC_Q.csr[17] == 1)) || ((`DESC_Q.csr[7:4] == SrcReqSel) && (`DESC_Q.csr[16] == 1))) begin
				SrcMode = 0;
				$display("trun off SrcMode because port%0d has been used.", SrcReqSel);
				break;
			end
		end

		foreach(`NDS_SCB.finished_desc_csr[i]) begin
			if(((`NDS_SCB.finished_desc_csr[i][11:8] == SrcReqSel) && (`NDS_SCB.finished_desc_csr[i][17] == 1)) || ((`NDS_SCB.finished_desc_csr[i][7:4] == SrcReqSel) && (`NDS_SCB.finished_desc_csr[i][16] == 1))) begin
				SrcMode = 0;
				$display("trun off SrcMode because port%0d has been used.", SrcReqSel);
				break;
			end
		end

		foreach(`DESC_Q) begin
			if(((`DESC_Q.csr[11:8] == DstReqSel) && (`DESC_Q.csr[17] == 1)) || ((`DESC_Q.csr[7:4] == DstReqSel) && (`DESC_Q.csr[16] == 1))) begin
				DstMode = 0;
				$display("trun off DstMode because port%0d has been used.", DstReqSel);
				break;
			end
		end

		foreach(`NDS_SCB.finished_desc_csr[i]) begin
			if(((`NDS_SCB.finished_desc_csr[i][11:8] == DstReqSel) && (`NDS_SCB.finished_desc_csr[i][17] == 1)) || ((`NDS_SCB.finished_desc_csr[i][7:4] == DstReqSel) && (`NDS_SCB.finished_desc_csr[i][16] == 1))) begin
				DstMode = 0;
				$display("trun off DstMode because port%0d has been used.", DstReqSel);
				break;
			end
		end

		csr = {SrcBusInfIdx, DstBusInfIdx, Priority, 1'b0, SrcBurstSize, SrcWidth, DstWidth, SrcMode, DstMode, SrcAddrCtrl, DstAddrCtrl, SrcReqSel, DstReqSel, IntAbtMask, IntErrMask, IntTCMask, Enable};
	end
	endfunction
endclass

class chain_number;
	rand integer num;

	constraint c_num {
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT 
		num dist {
			     [1:3]	:/ 80,
			     [4:5]	:/ 20
		};
	`else
		num == 1;
	`endif
	}
endclass

descriptor	channel[`DMA_CH_NUM][$];
descriptor	finished_channel_desc[`DMA_CH_NUM]; // finished desc will be pushed here.

int k;
reg [`ATCDMAC300_CH_NUM-1:0] enable;
reg [`ATCDMAC300_CH_NUM-1:0] abort_table;
reg [`ATCDMAC300_CH_NUM-1:0] abort_mask_table;
reg [`ATCDMAC300_CH_NUM-1:0] error_table;
reg [`ATCDMAC300_CH_NUM-1:0] error_resp_table;
reg [31:0] int_status;
reg [ 7:0] tc_status;
reg [ 7:0] err_status;
reg [ 7:0] abort_status;
reg [31:0] slverr;
reg [31:0] csr_temp;
int rnd;
reg [31:0] rdata;
int wait_cycle_count;
int count;

//----- Start of test case -----//
initial begin: MODEL_ID_1_TEST
	descriptor	desc;
	descriptor	descs[$];
	chain_number	chain_num;	
	integer		round;
	#100;

	if (MODEL_ID != 1) disable MODEL_ID_1_TEST;
	// This code block is for MODEL_ID == 1.
	`NDS_BENCH.wait_reset_done();

	desc = new;
	descs = {};
	chain_num = new;


	//set_random_delay_cycle(`NDS_DELAY_MAX, 0);

	$display("============ Start apb_all delay_max=%0d",
		`NDS_DELAY_MAX, " with { ",
		`ifdef NDS_XM1_WITH `STRINGIFY(`NDS_XM1_WITH), `endif
		"; } ===============");


	//check IP info
	read_data(ID_AND_REVISION_REGISTER_ADDR,rdata,slverr);

	if(rdata != `ATCDMAC300_ID) begin
		$display("%0t:%m:ERROR: incorrect IP info! Expected:%x Got:%x",$realtime, `ATCDMAC300_ID, rdata);
		$finish;
	end

	$display("rdata=%x slverr=%x",rdata,slverr);

	// check configuration
	read_data(DMAC_CONFIGURATION_REGISTER_ADDR,rdata,slverr);

	if(rdata != {1'(CHAIN_TRANSFER_SUPPORT), 1'(REQ_SYNC_SUPPORT), 4'b0, 2'(`DMA_DATA_SIZE - 2), 7'(`ATCDMAC300_ADDR_WIDTH), 1'(DUAL_DMA_CORE_SUPPORT), 1'(DUAL_MASTER_IF_SUPPORT), 5'd`ATCDMAC300_REQ_ACK_NUM, 6'd`NDS_FIFO_DEPTH, 4'd`DMA_CH_NUM}) begin
		$display("%0t:%m:ERROR: incorrect configuration! Expected:%x Got:%x",$realtime,{1'(CHAIN_TRANSFER_SUPPORT), 1'(REQ_SYNC_SUPPORT), 5'b0, 2'(`DMA_DATA_SIZE - 2), ADDR_WIDTH, 1'(DUAL_DMA_CORE_SUPPORT), 1'(DUAL_MASTER_IF_SUPPORT), 5'd`ATCDMAC300_REQ_ACK_NUM, 6'd`NDS_FIFO_DEPTH, 4'd`DMA_CH_NUM} , rdata);
		$finish;
	end

	write_data(DMAC_CONTROL_REGISTER_ADDR,32'h1,32'h0,32'h0); // reset

	enable = 0; // channel enable
	abort_table = 0; // expected abort channel
	abort_mask_table = 0; // expected abort channel abtmask
	error_table = 0; // expected error channel
	error_resp_table = 0; // got error response channel
	int_status = 0; // interrupt status	
	tc_status = 0;	// tc status
	err_status = 0;	// error status
	abort_status = 0; // abort status

	count = 0;


	$display("===== Random test =====");


	for (round = 0; round < ROUND_NUM; round = round + 1) begin
		
		$display("Test Round%0d",round);

		read_data(CHANNEL_ENABLE_REGISTER_ADDR,enable,slverr);
		get_int(int_status, tc_status, abort_status, err_status);

		$display("Enable=%b Tc_status=%b\n",enable,tc_status);

		wait_cycle_count = 0;

		`ifdef NDS_COV_FIRST_CH
			while((&enable == 1) || (int_status != 0) || (`NDS_DMAC.dma_int == 1) || (enable[`NDS_COV_FIRST_CH] && (round%2 == 0))) begin // wait when all channels are enable
				dma_status_handling;
			end
		`else
			while((&enable == 1) || (int_status != 0) || (`NDS_DMAC.dma_int == 1)) begin // wait when all channels are enable
				dma_status_handling;
			end
		`endif


		// create chain
		$display("%0t: create chain\n",$realtime);

		chain_num = new; // chain_num: the amount of a chain
		void'(chain_num.randomize());

		k = chain_num.num;

		for (int i = 0; i < k; i++) begin
			desc = new;

			`ifdef WITH_COV
			if ((i == 0) && (round == 0)) begin
				desc.first_desc = 1;
			end
			`endif

			void'(desc.randomize() with {
			`ifdef NDS_DSPT_WITH `NDS_DSPT_WITH; `endif
			});

			desc.chain = round;
		
			if(i == 0) begin 
				desc.last_llp = 0;
			end

			// The last desc llp in a chain = 0
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT 
				if(i == (k - 1)) begin 
					desc.llp = 0;
				end
			`else
				// To test if dmac300 really ignores llp when ATCDMAC300_CHAIN_TRANSFER_SUPPORT is undefined
				// the head desc llp will also be random though the macro is undefined. 
			`endif

			
			if(desc.invalid_desc == 1) begin 
				// this desc is a invalid desc
				// the invalid desc didn't need to check_space
				$display("%0t: push invalid_desc head: invalid_crs=%x invalid_tot=%x invalid_src=%x invalid_dst=%x",
			       		$realtime, desc.invalid_csr, desc.invalid_tot, desc.invalid_src, desc.invalid_dst);
				$display("push invalid desc: chain=%x csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x SrcBurstSize=%x SrcWidth=%x DstWidth=%x SrcAddrCtrl=%x DstAddrCtrl=%x SrcMode=%x SrcReqSel=%0d DstMode=%x DstReqSel=%0d\n",
					  desc.chain, desc.csr, desc.tot, desc.src, desc.dst, desc.llp, desc.last_llp, desc.SrcBurstSize, desc.SrcWidth, desc.DstWidth, desc.SrcAddrCtrl, desc.DstAddrCtrl, desc.SrcMode, desc.SrcReqSel, desc.DstMode, desc.DstReqSel);
				descs.push_back(desc);

				break; // a invalid desc doesn't link to the next desc 
			end
			else begin 
				// this desc is a normal desc
				if(`NDS_BENCH.check_space(desc.chain, desc.csr, desc.tot, desc.src, desc.dst, desc.llp, desc.SrcBurstSize, desc.SrcWidth, desc.DstWidth, desc.SrcAddrCtrl, desc.DstAddrCtrl, desc.SrcBusInfIdx, desc.DstBusInfIdx, desc.LLDBusInfIdx)) begin	
					if(i == 0) begin
						$display("push head: chain=%x csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x SrcBurstSize=%x SrcWidth=%x DstWidth=%x SrcAddrCtrl=%x DstAddrCtrl=%x SrcMode=%x SrcReqSel=%0d DstMode=%x DstReqSel=%0d\n", 
							  desc.chain, desc.csr, desc.tot, desc.src, desc.dst, desc.llp, desc.last_llp, desc.SrcBurstSize, desc.SrcWidth, desc.DstWidth, desc.SrcAddrCtrl, desc.DstAddrCtrl, desc.SrcMode, desc.SrcReqSel, desc.DstMode, desc.DstReqSel);
					end
					else begin
						$display("push llp : chain=%x csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x SrcBurstSize=%x SrcWidth=%x DstWidth=%x SrcAddrCtrl=%x DstAddrCtrl=%x SrcMode=%x SrcReqSel=%0d DstMode=%x DstReqSel=%0d\n",
							  desc.chain, desc.csr, desc.tot, desc.src, desc.dst, desc.llp, desc.last_llp, desc.SrcBurstSize, desc.SrcWidth, desc.DstWidth, desc.SrcAddrCtrl, desc.DstAddrCtrl, desc.SrcMode, desc.SrcReqSel, desc.DstMode, desc.DstReqSel);
					end
					descs.push_back(desc);
				end
			end
		end

		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT 
			set_llp(descs); // setting link lists to slave's memory
		`endif

		// send desc
		`ifdef NDS_COV_FIRST_CH
			if (enable[`NDS_COV_FIRST_CH] == 0)
				rnd = `NDS_COV_FIRST_CH;
		`endif
		while(enable[rnd] != 0) begin
			rnd = {$random(seed)}%(`DMA_CH_NUM);
			if(&enable == 1) begin
				$display("%0t:%m:ERROR: no available channel",$realtime);
				$finish;
			end
		end

		//$display("rnd=%x, enable=%x", rnd, enable);

		desc = descs.pop_front();

		channel[rnd].push_back(desc);

		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT // push corresponded link lists to channel queue
			if(descs.size() != 0) begin
				while(desc.chain == descs[0].chain) begin

					channel[rnd].push_back(descs.pop_front());
					
					if(descs.size() == 0) break;
				end
			end
		`endif

		// write haed desc to dmac300
		write_data((CHANNEL_CONTROL_REGISTER_ADDR + (rnd << 5) + 28),desc.llp[63:32],3'h0,4'h0);
		write_data((CHANNEL_CONTROL_REGISTER_ADDR + (rnd << 5) + 24),desc.llp[31: 0],3'h0,4'h0);
		write_data((CHANNEL_CONTROL_REGISTER_ADDR + (rnd << 5) + 20),desc.dst[63:32],3'h0,4'h0);
		write_data((CHANNEL_CONTROL_REGISTER_ADDR + (rnd << 5) + 16),desc.dst[31: 0],3'h0,4'h0);
		write_data((CHANNEL_CONTROL_REGISTER_ADDR + (rnd << 5) + 12),desc.src[63:32],3'h0,4'h0);
		write_data((CHANNEL_CONTROL_REGISTER_ADDR + (rnd << 5) +  8),desc.src[31: 0],3'h0,4'h0);
		write_data((CHANNEL_CONTROL_REGISTER_ADDR + (rnd << 5) +  4),desc.tot       ,3'h0,4'h0);
		write_data((CHANNEL_CONTROL_REGISTER_ADDR + (rnd << 5)     ),desc.csr       ,3'h0,4'h0);
	end


	wait_cycle_count = 0;

	read_data(CHANNEL_ENABLE_REGISTER_ADDR,enable,slverr);
	get_int(int_status, tc_status, abort_status, err_status);

	while((enable != 0) || (int_status != 0) || (`NDS_BENCH.descriptor_queue.size() != 0)) begin // wait when any channel is enable
		dma_status_handling;
	end

	$display("\n============================= UNFINISHED DSPT ===================================\n");

	for (int i = 0; i < `DMA_CH_NUM; i++) begin
		for (int j = 0; j < channel[i].size(); j++) begin
			//$display("channel %0d Num %0d: csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x\n",i,j+1, channel[i][j].csr, channel[i][j].tot, channel[i][j].src, channel[i][j].dst, channel[i][j].llp, channel[i][j].last_llp);
		end
		if(channel[i].size()) begin
			$display("%0t:%m:ERROR: not all descs are finished.", $realtime, MODEL_ID);
		end
	end

	foreach (`DESC_Q) begin
		$display("unfinished desc: chain=%x src=%x",`DESC_Q.chain,`DESC_Q.src);
	end

	$display("%0t:%m: END of master%0d test.", $realtime, MODEL_ID);


#100;
`NDS_BENCH.program_exit(0);
end

task dma_status_handling;
	reg	 [`ATCDMAC300_CH_NUM-1:0] abnormal_flag; // a flag to indicate if this desc is aborted or error. if it does, the channel register checker will not be called.
	integer	 base_num; // a number to decide the probability of the channel aborted.
begin

	abnormal_flag = 0; // clear the flag

	//$display("%0t: random abort.",$realtime);
	foreach(enable[i]) begin // random abort channels
		if((enable[i] == 1) && (channel[i].size() > 0) && (tc_status[i] != 1) && (abort_status[i] != 1) && (channel[i][0].r_capacity > 0)) begin // abort channel when r_capacity to avoid a channel be aborted at the read llp phase 
			count ++ ;

			if(channel[i][0].tot < 16) begin
				base_num = channel[i][0].tot * 1000;
			end
			else if(channel[i][0].tot < 128) begin
				base_num = channel[i][0].tot * 100;
			end
			else if(channel[i][0].tot < 1024) begin
				base_num = channel[i][0].tot * 10;
			end
			else begin
				base_num = channel[i][0].tot * 3;
			end


			if((({$random(seed)} % base_num) == 0) || ($realtime > 20000000ns) `ifdef NDS_COV_ABT_EVERY_CH || 1'b1 `endif) begin // probability of abort: 1 / (tot of desc*100)
				$display("%0t: abort channel[%0d] probability:1/%0d src:%x tot:%x count:%0d", $realtime, i, base_num, channel[i][0].src, channel[i][0].tot, count);
				abort_table[i] = 1;
				abort_mask_table[i] = channel[i][0].IntAbtMask; // mask = 1: issue dma_int
				count = 0;
				write_data(CHANNEL_ABORT_REGISTER_ADDR,{24'b0, 8'(1<<i)},3'h0,4'h0);
				// abort the channel	
			end
		end
	end

	//$display("%0t: abort check.",$realtime);
	while (abort_status != 0) begin
		foreach(abort_status[i]) begin // clear abort status and dump aborted descs from queues.
			if(abort_status[i] == 1) begin
				abnormal_flag[i] = 1; // toggle the flag

				read_data(CHANNEL_ENABLE_REGISTER_ADDR,enable,slverr);

				while(enable[i] == 1) begin // wait for channel done this burst lengh
					//$display("%0t: abort check 1.",$realtime);
					read_data(CHANNEL_ENABLE_REGISTER_ADDR,enable,slverr);
				end

				if(abort_table[i] != 1) begin // check if the abort interrupt is expected to be happened
					$display("%0t:%m:ERROR: unexpected abort interrupt happened at channel[%0d]",$realtime,i);
					$finish;
				end

				if((abort_mask_table[i] == 0) && (`NDS_BENCH.dma_int != 1)) begin
					$display("%0t:%m:ERROR: channel[%0d] IntAbtMask=0 but dma_int is not asserted",$realtime,i);
					$finish;
				end

				// read modify write to clear the abort interrupt.
				write_data(INTERRUPT_STATUS_REGISTER_ADDR,{8'b0, 8'(1<<i), 8'b0},3'h0,4'h0);
				//$display("%0t:read-modify-write to clear abort interrupt, abort_status=%b channel=%0d enable=%b wcmd=%x",$realtime, abort_status, i, enable,{8'b0, 8'(1<<i),8'b0} );
					
				while(abort_status[i] == 1) begin // wait dmac300 to clear the abort interrupt
					get_int(int_status, tc_status, abort_status, err_status);
				end

				abort_table[i] = 0; // clear the abort table
				abort_mask_table[i] = 0;

				read_data((CHANNEL_CONTROL_REGISTER_ADDR + (i << 5) +  4), rdata ,slverr); // get tot.

				if(err_status[i] == 0) begin // if error status also be asserted, those queues will not be clear until error interrupt handling is finished
					if (({$random(seed)}%2 == 0) && (rdata != 0) && (tc_status[i] == 0) && ($realtime < 20000000ns) && (channel[i].size() > 0)) begin // 33% to re-enable the aborted desc, and a finished desc no need to be re-enabled.

						// read-modify-write to re-enable the channel
						read_data((CHANNEL_CONTROL_REGISTER_ADDR + (i << 5)), rdata, slverr);
						write_data((CHANNEL_CONTROL_REGISTER_ADDR + (i << 5)), {rdata[31:1], 1'b1}, 3'h0, 4'h0);
						$display("Re-enable the aborted channel[%0d].",i);

						abnormal_flag[i] = 0; // clear the abnormal flag
					end
					else begin
						for(k = `NDS_BENCH.descriptor_queue.size() - 1; k > -1; k--) begin // clear all aborted descs in `NDS_BENCH.descriptor.
							if(channel[i].size() > 0) begin
								if(`NDS_BENCH.descriptor_queue[k].chain == channel[i][0].chain) begin
									`NDS_BENCH.descriptor_queue.delete(k); 
									//$display("%0t:`NDS_BENCH.descriptor[%0d] dumped due to abort interrupt",$realtime, i);
								end
							end
						end

						channel[i] = {}; // clear rest descs in the chain since the channel is abort.
						//$display("%0t:channel[%0d] dumped due to abort interrupt",$realtime,i);
						`NDS_SCB.scb_queue[i] = {}; // drop all captured data in scoreboard.
						`NDS_SCB.scb_time[i] = {}; // drop all captured time in scoreboard.
					end
				end
			end
		end
		get_int(int_status, tc_status, abort_status, err_status);
	end

	//$display("%0t: error check.",$realtime);
	while (err_status != 0) begin
		foreach(err_status[i]) begin // clear the error interrupt 
			if(err_status[i] == 1)begin
				abnormal_flag[i] = 1; // toggle the flag

				read_data(CHANNEL_ENABLE_REGISTER_ADDR,enable,slverr);

				//$display("\nerror desc: chain=%x csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x SrcBurstSize=%x SrcWidth=%x DstWidth=%x SrcAddrCtrl=%x DstAddrCtrl=%x %x",channel[i][0].chain, channel[i][0].csr, channel[i][0].tot, channel[i][0].src, channel[i][0].dst, channel[i][0].llp, channel[i][0].last_llp, channel[i][0].SrcBurstSize, channel[i][0].SrcWidth, channel[i][0].DstWidth, channel[i][0].SrcAddrCtrl, channel[i][0].DstAddrCtrl, channel[i][0].dst_lower);
				//$display("error_resp_table=%b",error_resp_table);

				if(enable[i] !== 0) begin // channel[i] should not be still enabled after error interrupt happened.
					$display("%0t:%m:ERROR: channel[%0d] should not be still enabled after error interrupt happened!", $realtime, i);
					$finish;
				end

				if(finished_channel_desc[i] != null) begin
					if((channel[i][0].IntErrMask == 0 && finished_channel_desc[i].IntErrMask == 0) && (`NDS_BENCH.dma_int != 1)) begin
						// when got bus error at reading llp, the IntErrMask should reference to the finished_desc's
						$display("%0t:%m:ERROR: channel[%0d] IntErrMask=0 but dma_int is not asserted",$realtime,i);
						$finish;
					end
				end
				else begin
					if((channel[i][0].IntErrMask == 0) && (`NDS_BENCH.dma_int != 1)) begin
						$display("%0t:%m:ERROR: channel[%0d] IntErrMask=0 but dma_int is not asserted",$realtime,i);
						$finish;
					end
				end

				if((channel[i][0].invalid_desc == 1) || (error_resp_table[i] == 1)) begin // error interrupt caused by programming an invalid desc to channel register. 

					for(k = `NDS_BENCH.descriptor_queue.size() - 1; k > -1; k--) begin // clear all descs in `NDS_BENCH.descriptor
						if(`NDS_BENCH.descriptor_queue[k].chain == channel[i][0].chain) begin
							`NDS_BENCH.descriptor_queue.delete(k); 
							//$display("%0t:`NDS_BENCH.descriptor[%0d] dumped due to error interrupt.",$realtime, i);
						end
					end

					//$display("%0t:channel[%0d] dumped due to error interrupt. src=%x",$realtime,i,channel[i][0].src);
					channel[i] = {}; // clear rest descs in the chain since the channel error.
					`NDS_SCB.scb_queue[i]={}; // drop all captured data in scoreboard.
					`NDS_SCB.scb_time[i]={}; // drop all captured time in scoreboard.
					
					error_resp_table[i] = 0; // clear table 

					// read modify write to clear the error interrupt.
					write_data(INTERRUPT_STATUS_REGISTER_ADDR,{16'b0, 8'(1<<i)},3'h0,4'h0);
					//$display("%0t:read-modify-write to clear error interrupt, error_status=%b channel=%0d enable=%b wcmd=%x",$realtime, err_status, i, enable,{16'b0, 8'(1<<i)} );

					while(err_status[i] == 1) begin // wait dmac300 to clear the error interrupt
						get_int(int_status, tc_status, abort_status, err_status);
					end
				end
				else begin
					$display("%0t:%m:ERROR: unexpected error interrupt happens in channel[%0d]!", $realtime, i);
					$finish;
				end
			end
		end
		get_int(int_status, tc_status, abort_status, err_status);
	end

	while (tc_status != 0) begin
		foreach(tc_status[i]) begin
			if(tc_status[i] == 1) begin

				if((finished_channel_desc[i].IntTCMask == 0) && (`NDS_BENCH.dma_int != 1)) begin
					$display("%0t:%m:ERROR: channel[%0d] IntTCMask=0 but dma_int is not asserted",$realtime,i);
					$finish;
				end

				if(i > `ATCDMAC300_CH_NUM) begin
					$display("%0t:%m:ERROR: tc_interrupt is set at a non-existing channel! tc_status=%x enable=%x", $realtime, tc_status, enable);
				end
				else begin

					if(channel[i].size() > 0) begin // channel.size == 0 means last desc in a chain is finished,
						$display("%0t:%m:ERROR: channel[%0d].szie() > 0 in tc interrupt! tc_status=%x enable=%x", $realtime, i, tc_status, enable);
						$finish;
					end

					read_data(CHANNEL_ENABLE_REGISTER_ADDR,enable,slverr);
					if(enable[i] == 1) begin
						$display("%0t:%m:ERROR: TC_INTERRUPT = 1 while a chain isn't completed! tc_status=%x enable=%x", $realtime, tc_status, enable);
						$finish;
					end

					write_data(INTERRUPT_STATUS_REGISTER_ADDR,{8'(1<<i), 8'b0, 8'b0},3'h0,4'h0);
					$display("read-modify-write to clear tc interrupt, tc_status=%b channel=%0d enable=%b wcmd=%x", tc_status, i, enable,{8'(1<<i), 8'b0, 8'b0} );
					// read modify write to clear the interrupt.

					while(tc_status[i] == 1) begin
						get_int(int_status, tc_status, abort_status, err_status);
					end

					// check if the channel resigter's content is expected
					// channel register only is checked when both abort and error interrupt doesn't happen
					if(abnormal_flag[i] == 0) begin
						check_channel_register(i);
					end
				end
			end
		end
		get_int(int_status, tc_status, abort_status, err_status);
	end
	
	if(wait_cycle_count > MAX_WAIT_CYCLE) begin // wait_cycle will start to count when axi interfaces no activity.
		$display("%0t:%m:ERROR: Timeout! enable=%b tc_status=%b err_status=%b abort_status=%b", $realtime, enable, tc_status, err_status, abort_status);
		foreach(channel[i]) begin
			$display("ch%0d_size=%0d", i, channel[i].size());
			foreach(channel[i][j]) begin
				$display("desc_src=%x", channel[i][j].src);
			end
		end

		$display("residue descriptors:");

		foreach(`DESC_Q) begin
			$display("desc_src=%x", `DESC_Q.src);
		end
		$finish;
	end
	else begin
		if((`AXI_SLAVE0.bvalid == 1) || (`AXI_SLAVE0.rvalid == 1) `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT || (`AXI_SLAVE1.bvalid == 1) || (`AXI_SLAVE1.rvalid == 1) `endif) begin
			wait_cycle_count = 0;
		end
		else begin
			wait_cycle_count = wait_cycle_count + 1;
		end
	end

	read_data(CHANNEL_ENABLE_REGISTER_ADDR,enable,slverr);
	get_int(int_status, tc_status, abort_status, err_status);

	$display("%0t: post check: Enable=%b Tc_status=%b Abort_status=%b Err_status=%b\n",$realtime, enable, tc_status, abort_status, err_status);
end
endtask

task check_channel_register ( // check if the channel register's context is expected
input integer unsigned	i
);
reg [31:0]	rdata_csr;
reg [31:0]	rdata_tot;
reg [63:0]	rdata_src;
reg [63:0]	rdata_dst;
reg [63:0]	rdata_llp;
begin
	rdata_csr = 0;
	rdata_tot = 0;
	rdata_src = 0;
	rdata_dst = 0;
	rdata_llp = 0;

	read_data((CHANNEL_CONTROL_REGISTER_ADDR + (i << 5) + 28),rdata_llp[63:32],slverr);
	read_data((CHANNEL_CONTROL_REGISTER_ADDR + (i << 5) + 24),rdata_llp[31: 0],slverr);
	read_data((CHANNEL_CONTROL_REGISTER_ADDR + (i << 5) + 20),rdata_dst[63:32],slverr);
	read_data((CHANNEL_CONTROL_REGISTER_ADDR + (i << 5) + 16),rdata_dst[31: 0],slverr);
	read_data((CHANNEL_CONTROL_REGISTER_ADDR + (i << 5) + 12),rdata_src[63:32],slverr);
	read_data((CHANNEL_CONTROL_REGISTER_ADDR + (i << 5) +  8),rdata_src[31: 0],slverr);
	read_data((CHANNEL_CONTROL_REGISTER_ADDR + (i << 5) +  4),rdata_tot	  ,slverr);
	read_data((CHANNEL_CONTROL_REGISTER_ADDR + (i << 5)     ),rdata_csr	  ,slverr);

	if(rdata_csr != {finished_channel_desc[i].csr[31:1],1'b0}) begin
		$display("%0t:%m:ERROR: channel[%0d] register data mismatch: rdata_csr=%x excepted=%x",$realtime, i, rdata_csr, {finished_channel_desc[i].csr[31:1],1'b0});
		$finish;
	end

	if(rdata_tot != 0) begin
		$display("%0t:%m:ERROR: channel[%0d] register data mismatch: rdata_tot=%x excepted=%x",$realtime, i, rdata_tot, 0);
		$finish;
	end
	
	if(finished_channel_desc[i].SrcAddrCtrl == 0) begin
		if(rdata_src != (ADDR_WIDTH)'(finished_channel_desc[i].src + (finished_channel_desc[i].tot << finished_channel_desc[i].SrcWidth))) begin
			$display("%0t:%m:ERROR: channel[%0d] register data mismatch: rdata_src=%x excepted=%x",$realtime, i, rdata_src, (finished_channel_desc[i].src + (finished_channel_desc[i].tot << finished_channel_desc[i].SrcWidth)));
			$finish;
		end
	end
	else if(finished_channel_desc[i].SrcAddrCtrl == 1) begin
		if(rdata_src != (ADDR_WIDTH)'(finished_channel_desc[i].src - (finished_channel_desc[i].tot << finished_channel_desc[i].SrcWidth))) begin
			$display("%0t:%m:ERROR: channel[%0d] register data mismatch: rdata_src=%x excepted=%x",$realtime, i, rdata_src, (finished_channel_desc[i].src - (finished_channel_desc[i].tot << finished_channel_desc[i].SrcWidth)));
			$finish;
		end
	end
	else if(finished_channel_desc[i].SrcAddrCtrl == 2) begin
		if(rdata_src != finished_channel_desc[i].src) begin
			$display("%0t:%m:ERROR: channel[%0d] register data mismatch: rdata_src=%x excepted=%x",$realtime, i, rdata_src, finished_channel_desc[i].src);
			$finish;
		end
	end

	if(finished_channel_desc[i].DstAddrCtrl == 0) begin
		if(rdata_dst != (ADDR_WIDTH)'(finished_channel_desc[i].dst + (finished_channel_desc[i].tot << finished_channel_desc[i].SrcWidth))) begin
			$display("%0t:%m:ERROR: channel[%0d] register data mismatch: rdata_dst=%x excepted=%x",$realtime, i, rdata_dst, (finished_channel_desc[i].dst + (finished_channel_desc[i].tot << finished_channel_desc[i].SrcWidth)));
			$finish;
		end
	end
	else if(finished_channel_desc[i].DstAddrCtrl == 1) begin
		if(rdata_dst != (ADDR_WIDTH)'(finished_channel_desc[i].dst - (finished_channel_desc[i].tot << finished_channel_desc[i].SrcWidth))) begin
			$display("%0t:%m:ERROR: channel[%0d] register data mismatch: rdata_dst=%x excepted=%x",$realtime, i, rdata_dst, (finished_channel_desc[i].dst - (finished_channel_desc[i].tot << finished_channel_desc[i].SrcWidth)));
			$finish;
		end
	end
	else if(finished_channel_desc[i].DstAddrCtrl == 2) begin
		if(rdata_dst != finished_channel_desc[i].dst) begin
			$display("%0t:%m:ERROR: channel[%0d] register data mismatch: rdata_dst=%x excepted=%x",$realtime, i, rdata_dst, finished_channel_desc[i].dst);
			$finish;
		end
	end

	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		if(rdata_llp != finished_channel_desc[i].llp) begin
			$display("%0t:%m:ERROR: channel[%0d] register data mismatch: rdata_llp=%x excepted=%x",$realtime, i, rdata_llp, finished_channel_desc[i].llp);
			$finish;
		end
	`else
		if(rdata_llp != 0) begin
			$display("%0t:%m:ERROR: channel[%0d] register data mismatch: rdata_llp=%x excepted=%x",$realtime, i, rdata_llp, finished_channel_desc[i].llp);
			$finish;
		end
	`endif
end
endtask

function void set_llp (
descriptor	descs[$]
); 
descriptor desc;
begin
	foreach(descs[i]) begin  // set link lists to slave memory
		if(descs[i].last_llp != 0) begin // last_llp == 0 means this desc is a head (no last link list).
			desc = new descs[i];
			if(desc.last_llp[0] == 0) begin
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd0 ] = desc.csr[ 7: 0];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd1 ] = desc.csr[15: 8];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd2 ] = desc.csr[23:16];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd3 ] = desc.csr[31:24];
				 
				//$display("%0t: set llp: %x at %x",$realtime,desc.csr,({desc.last_llp[MEM_MSB:2],2'b0} + 64'd0));

				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd4 ] = desc.tot[ 7: 0];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd5 ] = desc.tot[15: 8];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd6 ] = desc.tot[23:16];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd7 ] = desc.tot[31:24];

				//$display("%0t: set llp: %x at %x",$realtime,desc.tot,({desc.last_llp[MEM_MSB:2],2'b0} + 64'd4 ));

				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd8 ] = desc.src[ 7: 0];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd9 ] = desc.src[15: 8];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd10] = desc.src[23:16];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd11] = desc.src[31:24];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd12] = desc.src[39:32];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd13] = desc.src[47:40];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd14] = desc.src[55:48];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd15] = desc.src[63:56];

				//$display("%0t: set llp: %x at %x",$realtime,desc.src[31: 0],({desc.last_llp[MEM_MSB:2],2'b0} + 64'd8 ));
				//$display("%0t: set llp: %x at %x",$realtime,desc.src[63:32],({desc.last_llp[MEM_MSB:2],2'b0} + 64'd12));

				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd16] = desc.dst[ 7: 0];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd17] = desc.dst[15: 8];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd18] = desc.dst[23:16];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd19] = desc.dst[31:24];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd20] = desc.dst[39:32];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd21] = desc.dst[47:40];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd22] = desc.dst[55:48];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd23] = desc.dst[63:56];

				//$display("%0t: set llp: %x at %x",$realtime,desc.dst[31: 0],({desc.last_llp[MEM_MSB:2],2'b0} + 64'd16));
				//$display("%0t: set llp: %x at %x",$realtime,desc.dst[63:32],({desc.last_llp[MEM_MSB:2],2'b0} + 64'd20));

				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd24] = desc.llp[ 7: 0];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd25] = desc.llp[15: 8];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd26] = desc.llp[23:16];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd27] = desc.llp[31:24];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd28] = desc.llp[39:32];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd29] = desc.llp[47:40];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd30] = desc.llp[55:48];
				`AXI_SLAVE0.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd31] = desc.llp[63:56];

				//$display("%0t: set llp: %x at %x",$realtime,desc.llp[31: 0],({desc.last_llp[MEM_MSB:2],2'b0} + 64'd24));
				//$display("%0t: set llp: %x at %x",$realtime,desc.llp[63:32],({desc.last_llp[MEM_MSB:2],2'b0} + 64'd28));
			end
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			else begin
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd0 ] = desc.csr[ 7: 0];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd1 ] = desc.csr[15: 8];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd2 ] = desc.csr[23:16];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd3 ] = desc.csr[31:24];
       
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd4 ] = desc.tot[ 7: 0];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd5 ] = desc.tot[15: 8];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd6 ] = desc.tot[23:16];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd7 ] = desc.tot[31:24];

				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd8 ] = desc.src[ 7: 0];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd9 ] = desc.src[15: 8];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd10] = desc.src[23:16];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd11] = desc.src[31:24];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd12] = desc.src[39:32];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd13] = desc.src[47:40];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd14] = desc.src[55:48];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd15] = desc.src[63:56];
 
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd16] = desc.dst[ 7: 0];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd17] = desc.dst[15: 8];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd18] = desc.dst[23:16];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd19] = desc.dst[31:24];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd20] = desc.dst[39:32];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd21] = desc.dst[47:40];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd22] = desc.dst[55:48];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd23] = desc.dst[63:56];

				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd24] = desc.llp[ 7: 0];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd25] = desc.llp[15: 8];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd26] = desc.llp[23:16];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd27] = desc.llp[31:24];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd28] = desc.llp[39:32];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd29] = desc.llp[47:40];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd30] = desc.llp[55:48];
				`AXI_SLAVE1.mem[{desc.last_llp[MEM_MSB:2],2'b0} + `NDS_MEM_ADDR_WIDTH'd31] = desc.llp[63:56];
			end
			`endif
		end
	end

end
endfunction

task get_int(
output reg [31:0] int_st,
output reg [ 7:0] tc_st,
output reg [ 7:0] abort_st,
output reg [ 7:0] err_st
);
reg [31:0] slave_err;
begin
	read_data(INTERRUPT_STATUS_REGISTER_ADDR,int_st,slave_err);
	tc_st = int_st[23:16];
	abort_st = int_st[15:8];
	err_st = int_st[7:0];	
end
endtask

// Handshake controll

always @ (posedge pclk or negedge presetn) begin
	if(!presetn) begin
		`NDS_BENCH.dma_req = 0;	
	end	
	else begin
		foreach(`NDS_BENCH.dma_ack[i]) fork
			if(`NDS_BENCH.dma_ack[i] == 1) begin
				if(`NDS_BENCH.dma_req[i] == 0) begin
					$display("%0t:%m:ERROR: ACK is asserted while REQ is not issued. sel=%x",$realtime,i);
					$finish;
				end

				repeat({$random(seed)}%10) @(posedge pclk);
				$display("source gets an ACK. sel=%x",i);
				`NDS_BENCH.dma_req[i] <= 0;

				@(posedge `NDS_BENCH.aclk);
				@(posedge `NDS_BENCH.aclk);
				@(posedge `NDS_BENCH.aclk);
				@(posedge `NDS_BENCH.aclk);

				if(`NDS_BENCH.dma_ack[i] != 0) begin
					$display("%0t:%m:ERROR: ACK isn't cleared for too long. sel=%x",$realtime,i);
					$finish;
				end
			end
		join
	end
end

reg  [`ATCDMAC300_REQ_ACK_NUM-1:0] dma_ack_d1;
reg  [`ATCDMAC300_REQ_ACK_NUM-1:0] dma_ack_d2;
wire [`ATCDMAC300_REQ_ACK_NUM-1:0] dma_ack_posedge;

always @ (posedge pclk or negedge presetn) begin
	if (!presetn) begin
		dma_ack_d1 <= 0;
		dma_ack_d2 <= 0;
	end
	else begin
		dma_ack_d1 <= `NDS_BENCH.dma_ack;
		dma_ack_d2 <= dma_ack_d1;
	end
end

assign dma_ack_posedge = ~dma_ack_d2 & dma_ack_d1;

always @ (posedge pclk) begin
	foreach(channel[i]) fork
		if(channel[i].size() > 0) fork
			// issue request
			if((channel[i][0].SrcMode == 1) && (`NDS_BENCH.dma_ack[channel[i][0].SrcReqSel] == 0) && (`NDS_BENCH.dma_req[channel[i][0].SrcReqSel] == 0)) begin
				repeat({$random(seed)}%10) @(posedge pclk);
				//$display("source issues a request. SrcReqSel=%x",channel[i][0].SrcReqSel);
				if(channel[i].size() > 0)`NDS_BENCH.dma_req[channel[i][0].SrcReqSel] <= 1;	
			end

			if((channel[i][0].DstMode == 1) && (`NDS_BENCH.dma_ack[channel[i][0].DstReqSel] == 0) && (`NDS_BENCH.dma_req[channel[i][0].DstReqSel] == 0)) begin
				repeat({$random(seed)}%10) @(posedge pclk);
				if(channel[i].size() > 0)`NDS_BENCH.dma_req[channel[i][0].DstReqSel] <= 1;	
			end	
		join
	join
end

always @ (posedge pclk) begin
	foreach(channel[i]) fork
		if(channel[i].size() > 0) begin
			// redundant handshaking monitoring
			if((channel[i][0].SrcMode == 1) && (dma_ack_posedge[channel[i][0].SrcReqSel] == 1) && (channel[i][0].invalid_desc == 0)) begin
				if(`NDS_SCB.excepcted_src_ack[channel[i][0].SrcReqSel] == 0) begin
					$display("%0t:%m:ERROR: dma_ack(SrcReqSel=%0d) should not be asserted before burst being end, r_capacity=%0x tts=%x SrcBurstSize=%0x SrcWidth=%0x i=%0d csr=%0x",$realtime, channel[i][0].SrcReqSel, channel[i][0].r_capacity, channel[i][0].tot, channel[i][0].SrcBurstSize, channel[i][0].SrcWidth, i, channel[i][0].csr);
					$finish;
				end
				else begin
					`NDS_SCB.excepcted_src_ack[channel[i][0].SrcReqSel] <= 0;
				end
			end

			if((channel[i][0].DstMode == 1) && (dma_ack_posedge[channel[i][0].DstReqSel] == 1) && (channel[i][0].invalid_desc == 0)) begin
				if(`NDS_SCB.excepcted_dst_ack[channel[i][0].DstReqSel] == 0) begin
					$display("%0t:%m:ERROR: dma_ack(DstReqSel=%0d) should not be asserted before burst being end, w_capacity=%0x tts=%x SrcBurstSize=%0x SrcWidth=%0x i=%0d",$realtime, channel[i][0].DstReqSel, channel[i][0].w_capacity, channel[i][0].tot, channel[i][0].SrcBurstSize, channel[i][0].SrcWidth, i);
					$finish;
				end
				else begin
					`NDS_SCB.excepcted_dst_ack[channel[i][0].DstReqSel] <= 0;
					//$display("%0t:clear excepted_dst_ack[%0d]", $realtime,channel[i][0].DstReqSel);
				end
			end
		end

		if(finished_channel_desc[i] != null) begin
			if((finished_channel_desc[i].DstMode == 1) && (dma_ack_posedge[finished_channel_desc[i].DstReqSel] == 1) && (finished_channel_desc[i].invalid_desc == 0)) begin // for the last dst_ack
				if(`NDS_SCB.excepcted_dst_ack[finished_channel_desc[i].DstReqSel] == 1) begin
					`NDS_SCB.excepcted_dst_ack[finished_channel_desc[i].DstReqSel] <= 0;
					//$display("%0t:(finished_ch)clear excepted_dst_ack[%0d]", $realtime,finished_channel_desc[i].DstReqSel);
				end
			end
		end
	join
end

//----- End of test case -----//

