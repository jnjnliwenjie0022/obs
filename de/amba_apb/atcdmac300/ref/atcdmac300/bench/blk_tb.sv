`timescale 1ns/1ps

`ifdef CLK_PERIOD
`else
`define CLK_PERIOD 15
`endif

`ifdef NDS_TIMEOUT_CYCLES
`else
	`define NDS_TIMEOUT_CYCLES 4000000
`endif

module blk_tb (
// VPERL: &PORTLIST;
// VPERL_GENERATED_BEGIN
	  dma_int,  
	  dma_ack,  
	  dma_req,  
	  aclk,     
	  aresetn,  
	  pclk,     
	  presetn   
// VPERL_GENERATED_END
);

parameter	ADDR_WIDTH = 32;
parameter	DATA_WIDTH = 32;
parameter	ERROR_PROBABILITY = 10;		// Error probability (10%).

parameter APB_PERIOD_MAX = 250; // 250/10 = 25ns  ==>  40MHz
parameter APB_PERIOD_MIN = 18;  //  18/10 = 1.8ns ==> 555MHz
parameter AXI_PERIOD_MAX = 250; // 250/10 = 25ns  ==>  40MHz
parameter AXI_PERIOD_MIN = 18;  //  18/10 = 1.8ns ==> 555MHz

localparam	DATA_BYTES = DATA_WIDTH/8;

input		dma_int;
input		[`ATCDMAC300_REQ_ACK_NUM-1:0] dma_ack;
output		[`ATCDMAC300_REQ_ACK_NUM-1:0] dma_req;
output		aclk;
output		aresetn;
output		pclk;
output		presetn;

reg		[`ATCDMAC300_REQ_ACK_NUM-1:0] dma_req;
reg		aclk;
reg		aresetn;
reg		pclk;
reg		presetn;

integer		aclk_cnt;
// integer		pclk_cnt;

// ===============
// random seed generation
// ===============
int unsigned	seed;

initial begin
	if ($value$plusargs("seed=%d", seed))
		seed = seed ^ 32'hb7cb9216;
	else
		seed = 32'hb7cb9216;
end


`ifdef ATCDMAC300_REQ_SYNC_SUPPORT

// ===============
// clock generation
// ===============
class clk_generate;
	rand int unsigned init_pclk_delay;
	rand int unsigned init_aclk_delay;
	rand int unsigned pclk_period;
	rand int unsigned aclk_period;
	rand int unsigned clk_ratio;
	constraint c_aclk_range {
		aclk_period <= (AXI_PERIOD_MAX*10);
		aclk_period >= (AXI_PERIOD_MIN*10);
	}

	constraint c_pclk_range {
		solve aclk_period before pclk_period;

		pclk_period >= aclk_period;

		pclk_period <= (APB_PERIOD_MAX*10);
		pclk_period >= (APB_PERIOD_MIN*10);
	}

	constraint c_clk_ratio {
		solve aclk_period before clk_ratio;
		solve pclk_period before clk_ratio;

		clk_ratio == (pclk_period/aclk_period);
		clk_ratio <= 4;
	}

	constraint c_aclk_delay {
		solve aclk_period before init_aclk_delay;

		init_aclk_delay < aclk_period;
	}

	constraint c_pclk_delay {
		solve pclk_period before init_pclk_delay;

		init_pclk_delay < pclk_period;
	}

	function new(
		bit init_random = 1 // 0 to disable randomization when new() 
	);
	begin
		if (init_random) begin
			assert (randomize());
			//begin
			//end
			//else begin 
			//	$error("clock generate failed, please cross check constraints and result: aclk_period=%x, pclk_period=%x",aclk_period, pclk_period);
			//	$finish();
			//end
		end
	end
	endfunction
	
endclass

initial begin
	real	init_pclk_delay;
	real	init_aclk_delay;
	real	pclk_period;
	real	aclk_period;
	clk_generate clk_pkt;

	clk_pkt = new;
	init_pclk_delay = clk_pkt.init_pclk_delay/10.0;
	init_aclk_delay = clk_pkt.init_aclk_delay/10.0;
	aclk_period = clk_pkt.aclk_period/10.0;
	pclk_period = clk_pkt.pclk_period/10.0;
	
	fork 
	begin
		// Initial phase of clock
		pclk = 1'b0;
		#(init_pclk_delay);
		// pclk generate 
		forever #(pclk_period/2.0) begin
			pclk = ~pclk;
		end
	end
	begin
		// Initial phase of clock
		aclk = 1'b0;
		#(init_aclk_delay);
		// aclk generate 
		forever #(aclk_period/2.0) begin
			aclk = ~aclk;
			aclk_cnt = aclk_cnt + 1;
		end
	end
	join
end

`else

// ===============
// clock generation
// ===============
initial begin
	int unsigned	init_delay;

	aclk = 1'b0;
	aclk_cnt = 0;

	// Initial phase of clock
	init_delay = {$random(seed)} % `CLK_PERIOD;
	#(init_delay);

	forever begin
		#(`CLK_PERIOD / 2.0) aclk = 1'b1;
		#(`CLK_PERIOD / 2.0) aclk = 1'b0;
		aclk_cnt = aclk_cnt + 1;
	end
end

initial begin
	int unsigned	init_delay;

	pclk = 1'b0;
	// pclk_cnt = 0;

	// Initial phase of clock
	init_delay = {$random(seed)} % `CLK_PERIOD;
	#(init_delay);

	forever begin
		#(`CLK_PERIOD / 2.0) pclk = 1'b1;
		#(`CLK_PERIOD / 2.0) pclk = 1'b0;
		// pclk_cnt = pclk_cnt + 1;
	end
end
`endif

// ===============
// reset generation
// ===============
initial begin
	aresetn = 1'b0;
	repeat (2) @(posedge aclk) ;
	// @(negedge aclk);
	aresetn = 1'b1;
end

initial begin
	presetn = 1'b0;
	repeat (2) @(posedge pclk) ;
	// @(negedge pclk);
	presetn = 1'b1;
end


// ===============
// Initial slave memory
// ===============
// ===============
// glue logic
// ===============

// ===============
// program exit
// ===============
`include "sync_tasks.vh"
initial begin
	logic [31:0] status;

	$timeformat (-9, 3, " ns", 12);

	fork: wait_program_exit 
		begin
			if (ADDR_WIDTH < 24 && ADDR_WIDTH > 64) begin
				$display("%0t:%m:ERROR: Unsupported addr width (%0d)!", $realtime, ADDR_WIDTH);
				disable wait_program_exit;
			end
			if (DATA_WIDTH != 32 && DATA_WIDTH != 64 && DATA_WIDTH != 128 && DATA_WIDTH != 256) begin
				$display("%0t:%m:ERROR: Unsupported DATA_WIDTH (%0d)!", $realtime, DATA_WIDTH);
				disable wait_program_exit;
			end

			if (ERROR_PROBABILITY > 100) begin
				$display("%0t:%m:ERROR: ERROR_PROBABILITY (%0d) is larger than 100!", $realtime, ERROR_PROBABILITY);
				disable wait_program_exit;
			end
			wait_program_done;
			get_program_status(status);
			$display("%0t:%m: exit(%0d) by bench", $realtime, status);
			disable wait_program_exit;
		end
		begin
			fork: wait_masters_exit
				begin
					`APB_MASTER1.wait_program_done;
					`APB_MASTER1.get_program_status(status);
					repeat(10) @(posedge aclk);
					if (status) begin
						disable wait_masters_exit;  // early disable when error
						$display("%0t:%m: exit(%0d) by axi master 1", $realtime, status);
					end
				end
			join
			$display("%0t:%m: exit(%0d) by axi masters.", $realtime, status);
			disable wait_program_exit;
		end
	join

`ifdef NDS_SCOREBOARD_EN
	if (status == 0) begin
		// trigger scoreboard final check
		`NDS_SCB.scb_final_compare();
	end
`endif // NDS_SCOREBOARD_EN
	

	$display("%0t:---- simulated %0d cpu cycles", $realtime, aclk_cnt/2);

	if (status == 0)
		$display("%0t:---- SIMULATION PASSED ----", $realtime);
	else begin
		$display("%0t:---- SIMULATION FAILED ----", $realtime);
		$display("%0t:Exit status = %0d", $realtime, status);
	end

	$finish;
end

typedef struct {
	bit [31:0]	csr;
	bit [31:0]	tot;
	bit [63:0]	src;
	bit [63:0]	dst;
	bit [63:0]	llp;
	bit [64:0]	src_lower;
	bit [64:0]	src_upper;
	bit [64:0]	dst_lower;
	bit [64:0]	dst_upper;
	bit		SrcBusInfIdx;
	bit		DstBusInfIdx;
	bit		LLDBusInfIdx;
	int unsigned	chain;
} descriptor_space;

descriptor_space	descriptor_queue[$];

function bit check_space(int unsigned chain, bit [31:0] csr, bit [31:0] tot, bit [63:0] src, bit [63:0] dst, bit [63:0] llp, bit [3:0] SrcBurstSize, bit [2:0] SrcWidth, bit [2:0] DstWidth, bit [2:0] SrcAddrCtrl, bit [2:0] DstAddrCtrl, bit SrcBusInfIdx, bit DstBusInfIdx, bit LLDBusInfIdx);
	bit [64:0] src_lower;
	bit [64:0] src_upper;
	bit [64:0] dst_lower;
	bit [64:0] dst_upper;
begin
	descriptor_space	d;

	if(SrcAddrCtrl == 3'b0) begin
		src_lower = 65'(src);
		src_upper = 65'(src) + 65'(tot << SrcWidth);
	end
	else if (SrcAddrCtrl == 3'b1) begin
		src_lower = 65'(src) + (65'(1) << SrcWidth) - 65'(tot << SrcWidth);
		src_upper = 65'(src) + (65'(1) << SrcWidth);
	end
	else begin
		src_lower = 65'(src);
		src_upper = 65'(src) + (65'(1) << SrcWidth);
	end

	if(DstAddrCtrl == 3'b0) begin
		dst_lower = 65'(dst);
		dst_upper = 65'(dst) + 65'(tot << SrcWidth);
	end
	else if (DstAddrCtrl == 3'b1) begin
		dst_lower = 65'(dst) + (65'(1) << DstWidth) - 65'(tot << SrcWidth);
		dst_upper = 65'(dst) + (65'(1) << DstWidth);
	end
	else begin
		dst_lower = 65'(dst);
		dst_upper = 65'(dst) + (65'(1) << DstWidth);
	end

	for (int i = 0; i < descriptor_queue.size(); i++) begin
		d = descriptor_queue[i];

		if(SrcBusInfIdx == d.SrcBusInfIdx) begin
			if ((src_upper <= d.src_lower) || (src_lower >= d.src_upper)) begin
			end
			else begin
				$display("%0t:%m:ERROR: Descriptor's source address space overlaps with descriptor%0d's space! (%x ~ %x) conflict (%x ~ %x) d.src=%x AddrCtrl=%0d", $realtime, i, src_lower, src_upper, d.src_lower, d.src_upper, d.src, SrcAddrCtrl);
				$finish;
				return 1'b0;
			end
		end

		if(DstBusInfIdx == d.DstBusInfIdx) begin
			if ((dst_upper <= d.dst_lower) || (dst_lower >= d.dst_upper)) begin
			end
			else begin
				$display("%0t:%m:ERROR: Descriptor's destination address space overlaps with descriptor%0d's space! (%x ~ %x) conflict (%x ~ %x) d.dst=%x", $realtime, i, dst_lower,dst_upper, d.dst_lower, d.dst_upper, d.dst);
				$finish;
				return 1'b0;
			end
		end

		if(LLDBusInfIdx == d.LLDBusInfIdx) begin
			if ((llp != d.llp) || (llp == 64'b0)) begin
			end
			else begin
				$display("%0t:%m:ERROR: Descriptor's link list point overlaps with descriptor%0d's space!", $realtime, i);
				$finish;
				return 1'b0;
			end
		end
	end

	if (((65'(src) & ~(65'(1<<ADDR_WIDTH)-65'(1))) == 65'(0)) && ((src & (64'(1<<SrcWidth)-64'(1))) == 64'(0))) begin
	end
	else begin
		$display("%0t:%m:ERROR: Invalid source address! %x SrcWidth=%x", $realtime, src, SrcWidth);
		$finish;
		return 1'b0;
	end

	if (((65'(dst) & ~(65'(1<<ADDR_WIDTH)-65'(1))) == 65'(0)) && ((dst & (64'(1<<DstWidth)-64'(1))) == 64'(0))) begin
	end
	else begin
		$display("%0t:%m:ERROR: Invalid destination address! %x DstWidth=%x", $realtime, dst, DstWidth);
		$finish;
		return 1'b0;
	end

	if (65'(src_upper) <= 65'(1 << ADDR_WIDTH)) begin
	end
	else begin
		$display("%0t:%m:ERROR: Source region out of range! %x ~ %x > %x AddrCtrl=%x", $realtime, src_lower, src_upper, 65'(1 << ADDR_WIDTH), SrcAddrCtrl);
		$finish;
		return 1'b0;
	end

	if (65'(dst_upper) <= 65'(1 << ADDR_WIDTH)) begin
	end
	else begin
		$display("%0t:%m:ERROR: Destinatino region out of range! %x ~ %x > %x AddrCtrl=%x", $realtime, dst_lower, dst_upper, 65'(1 << ADDR_WIDTH), DstAddrCtrl);
		$finish;
		return 1'b0;
	end

	if (((65'(llp) & ~(65'(1<<ADDR_WIDTH)-65'(1))) == 65'(0)) && (llp[2] == 1'b0) & (llp[1] == 1'b0)) begin
	end
	else begin
		$display("%0t:%m:ERROR: Invalid link list point! %x", $realtime, llp);
		$finish;
		return 1'b0;
	end

	if (SrcWidth < 3'd6) begin
	end
	else begin
		$display("%0t:%m:ERROR: Invalid SrcWidth! %x", $realtime, SrcWidth);
		$finish;
		return 1'b0;
	end

	if (DstWidth < 3'd6) begin
	end
	else begin
		$display("%0t:%m:ERROR: Invalid DstWidth! %x", $realtime, DstWidth);
		$finish;
		return 1'b0;
	end

	if (SrcAddrCtrl < 3'd3) begin
	end
	else begin
		$display("%0t:%m:ERROR: Invalid SrcAddrCtrl! %x", $realtime, SrcAddrCtrl);
		$finish;
		return 1'b0;
	end

	if (DstAddrCtrl < 3'd3) begin
	end
	else begin
		$display("%0t:%m:ERROR: Invalid DstAddrCtrl! %x", $realtime, DstAddrCtrl);
		$finish;
		return 1'b0;
	end

	if (SrcBurstSize < 4'd11) begin
	end
	else begin
		$display("%0t:%m:ERROR: Invalid SrcBurstSize! %x", $realtime, SrcBurstSize);
		$finish;
		return 1'b0;
	end

	d.csr = csr;
	d.tot = tot;
	d.src = src;
	d.dst = dst;
	d.llp = llp;
	d.SrcBusInfIdx = SrcBusInfIdx;
	d.DstBusInfIdx = DstBusInfIdx;
	d.LLDBusInfIdx = LLDBusInfIdx;
	d.src_lower = src_lower;
	d.src_upper = src_upper;
	d.dst_lower = dst_lower;
	d.dst_upper = dst_upper;
	d.chain = chain;

	//$display("create descriptor, csr=%0x, tot=%0x, src=%0x, dst=%0x, llp=%0x\n",csr,tot,src,dst,llp);
	descriptor_queue.push_back(d);
	return 1'b1;
end
endfunction

// ===============
// monitor/dump
// ===============
blk_dump blk_dump();

// ===============
// Misc
// ===============

// common task to wait reset  
task wait_reset_done; 
begin
        wait (aresetn);
        wait (presetn);
end
endtask

// ===============
// user define pattern
// ===============
`ifdef NDS_TB_PAT
	`include "nds_tb.pat"
`endif

endmodule

