//
// This module implements global scoreboard connections and handling logic by
// referencing xmr.vh.
//
`include "xmr.vh"

module blk_scb();

// The following parameters must match those in scb_axim_mon and scb_axis_mon.
// Reference scoreboard_bus_adapter.sv for more detail.
parameter 	SCB_ADDR_WIDTH		= 32;
parameter 	SCB_PUSH_START_ADDR	= 0;
parameter 	SCB_CAPTURE_LOCK	= 1;

localparam 	SCB_ID_WIDTH		= 8;	// ID width.
localparam 	SCB_DATA_WIDTH		= 8;	// Always check 1B at a time.


// The data bits placement is in {policy, info_data, check_data} structure:
//   +-----------+-----------------------+
//   |     st    |  info {id,addr,data}  |
//   +-----------+-----------------------+
//     ST_WIDTH     INFO_WIDTH
//
//
localparam SCB_LOCK_WIDTH		= 2 * SCB_CAPTURE_LOCK;	// LOCK width.

localparam SCB_XS0_ST_WIDTH		= 2;			// AXI slave status width.
localparam SCB_XS0_ID_WIDTH		= SCB_ID_WIDTH;		// ID width.
localparam SCB_XS0_ADDR_WIDTH		= SCB_ADDR_WIDTH;	// May be different!
localparam SCB_XS0_DATA_WIDTH		= SCB_DATA_WIDTH;
localparam SCB_XS0_INFO_WIDTH		= SCB_XS0_ID_WIDTH + SCB_XS0_ADDR_WIDTH + SCB_XS0_DATA_WIDTH + SCB_LOCK_WIDTH;
localparam SCB_XS0_TOTAL_WIDTH		= SCB_XS0_ST_WIDTH + SCB_XS0_INFO_WIDTH;

`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
localparam SCB_XS1_ST_WIDTH		= 2;			// AXI slave status width.
localparam SCB_XS1_ID_WIDTH		= SCB_ID_WIDTH;		// ID width.
localparam SCB_XS1_ADDR_WIDTH		= SCB_ADDR_WIDTH;	// May be different!
localparam SCB_XS1_DATA_WIDTH		= SCB_DATA_WIDTH;
localparam SCB_XS1_INFO_WIDTH		= SCB_XS1_ID_WIDTH + SCB_XS1_ADDR_WIDTH + SCB_XS1_DATA_WIDTH + SCB_LOCK_WIDTH;
localparam SCB_XS1_TOTAL_WIDTH		= SCB_XS1_ST_WIDTH + SCB_XS1_INFO_WIDTH;
`endif

function [SCB_XS0_DATA_WIDTH-1:0] get_data(
	input [SCB_XS0_TOTAL_WIDTH-1:0]		payload
);
	return payload[SCB_XS0_DATA_WIDTH+SCB_LOCK_WIDTH-1:SCB_LOCK_WIDTH];
endfunction

function [SCB_XS0_DATA_WIDTH-1:0] get_id(
	input [SCB_XS0_TOTAL_WIDTH-1:0]		payload
);
	return payload[SCB_XS0_INFO_WIDTH-1:SCB_XS0_INFO_WIDTH-SCB_ID_WIDTH];
endfunction

function [SCB_XS0_ADDR_WIDTH-1:0] get_addr(
	input [SCB_XS0_TOTAL_WIDTH-1:0]		payload
);
	return payload[SCB_XS0_INFO_WIDTH-SCB_ID_WIDTH-1:SCB_XS0_INFO_WIDTH-SCB_ID_WIDTH-SCB_XS0_ADDR_WIDTH];
endfunction

function [SCB_XS0_ST_WIDTH-1:0] get_status(
	input [SCB_XS0_TOTAL_WIDTH-1:0]		payload
);
	return payload[SCB_XS0_TOTAL_WIDTH-1:SCB_XS0_INFO_WIDTH];
endfunction

function [SCB_XS0_ST_WIDTH-1:0] get_lock(
	input [SCB_XS0_TOTAL_WIDTH-1:0]		payload
);
	return payload[SCB_LOCK_WIDTH-1:0];
endfunction

//
// Underlying scoreboard connections.
//
//

reg [SCB_XS0_TOTAL_WIDTH-1:0]	scb_queue[`DMA_CH_NUM][$];

reg [31:0]			finished_desc_csr[`DMA_CH_NUM];

reg [`ATCDMAC300_REQ_ACK_NUM-1:0] excepcted_src_ack;
reg [`ATCDMAC300_REQ_ACK_NUM-1:0] excepcted_dst_ack;

realtime	scb_time[`DMA_CH_NUM][$];

initial begin
	foreach(excepcted_src_ack[i]) begin
		excepcted_src_ack[i] = 0;
		excepcted_dst_ack[i] = 0;
	end
end

const reg [`DMA_WSTRB_WIDTH-1:0] wstrb_table[0:5] = {	(`DMA_WSTRB_WIDTH)'({(1 << 0){1'b1}}),
							(`DMA_WSTRB_WIDTH)'({(1 << 1){1'b1}}),
							(`DMA_WSTRB_WIDTH)'({(1 << 2){1'b1}}),
							(`DMA_WSTRB_WIDTH)'({(1 << 3){1'b1}}),
							(`DMA_WSTRB_WIDTH)'({(1 << 4){1'b1}}),
							(`DMA_WSTRB_WIDTH)'({(1 << 5){1'b1}})};

//
// Write direction queue.
//

// VPERL_BEGIN
// foreach $i (0 .. 1) {
// if (${i} == 1) {
// :`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// }
// :always @(`NDS_SYSTEM.axi_slave${i}.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S${i}_WRITE
// :	logic	[SCB_XS${i}_TOTAL_WIDTH-1:0]	eg_payload;
// :	realtime				eg_time;
// :	logic	[SCB_XS${i}_ADDR_WIDTH-1:0]	addr, scb_addr;
// :	logic					search_flag;
// :	logic					scb_search_flag;
// :	logic	[`DMA_WSTRB_WIDTH-1:0]		expected_wstrb;
// :
// :	while (`NDS_SYSTEM.axi_slave${i}.scb_axis_mon.scb_wr_queue_size()) begin
// :		`NDS_SYSTEM.axi_slave${i}.scb_axis_mon.scb_wr_dequeue(eg_payload, eg_time);
// :		
// :		search_flag = 0;
// :
// :		addr = get_addr(eg_payload);
// :
// :		foreach(`APB_MASTER1.channel[i]) begin
// :			if(`APB_MASTER1.channel[i].size()) begin
// :				if((addr >= `APB_MASTER1.channel[i][0].dst_lower) && (addr < `APB_MASTER1.channel[i][0].dst_upper) && (`APB_MASTER1.channel[i][0].DstBusInfIdx == ${i}) && (`APB_MASTER1.channel[i][0].invalid_desc == 0)) begin
// :					
// :					expected_wstrb = (`DMA_WSTRB_WIDTH)'(wstrb_table[`APB_MASTER1.channel[i][0].DstWidth] << `NDS_SYSTEM.axi_slave${i}.scb_axis_mon.scb_cur_waddr[`DMA_DATA_SIZE-1:0]);
// :					if (`NDS_SYSTEM.axi_slave${i}.scb_axis_mon.scb_in_wstrb != expected_wstrb) begin
// :						\$display("%t:%m:ERROR: unexpected wstrb! wstrb=%0h expected=%0h awsize=%0d", \$realtime, `NDS_SYSTEM.axi_slave${i}.scb_axis_mon.scb_in_wstrb, expected_wstrb, `APB_MASTER1.channel[i][0].DstWidth);
// :						\$finish;
// :					end
// :
// :					search_flag = 1;
// :
// :					if(get_lock(eg_payload) !== 0) begin
// :						\$display("%t:%m:ERROR: unexpected exclusive access!", \$realtime);
// :						\$finish;
// :					end
// :				
// :					if(`APB_MASTER1.channel[i][0].DstAddrCtrl == 0) begin
// :						scb_addr = addr - `APB_MASTER1.channel[i][0].dst_lower;
// :					end
// :					else if(`APB_MASTER1.channel[i][0].DstAddrCtrl == 1) begin
// :						scb_addr = `APB_MASTER1.channel[i][0].dst_upper - addr - 1;
// :					end
// :					else begin
// :						scb_addr = ((addr - `APB_MASTER1.channel[i][0].dst_lower) >> `APB_MASTER1.channel[i][0].DstWidth) + `APB_MASTER1.channel[i][0].w_capacity;
// :					end
// :					
// :					eg_payload[SCB_XS${i}_INFO_WIDTH-SCB_ID_WIDTH-1:SCB_XS${i}_INFO_WIDTH-SCB_ID_WIDTH-SCB_XS${i}_ADDR_WIDTH] = scb_addr;
// :					eg_payload[SCB_XS${i}_INFO_WIDTH-1:SCB_XS${i}_INFO_WIDTH-SCB_ID_WIDTH] = i;
// :
// :					scb_search_flag = 0;
// :					if(get_status(eg_payload) == 0) begin // only compare the ok response data
// :						foreach(scb_queue[i][k]) begin // searching the match data form queue
// :							if(scb_queue[i][k] == eg_payload) begin
// :								scb_queue[i].delete(k);
// :								scb_search_flag = 1;
// :								break;
// :							end
// :						end
// :					end
// :					else begin // if got any non-ok response toggle the flag
// :						`APB_MASTER1.error_resp_table[i] = 1;
// :						\$display("%t: Write: channel[%0d] got non-okay response: %0x", \$realtime, i, get_status(eg_payload));
// :					end
// :
// :					if((scb_search_flag == 0) && (`APB_MASTER1.error_resp_table[i] == 0)) begin
// :						\$display("%t:%m:ERROR: scoreboard mismatch: slave${i}_write= %x %x(%0d) %x %x %x %x", \$realtime,get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);
// :					end
// :					else begin
// :						//\$display("slave${i}_write= %x %x(%0d) %x %x %x %x", get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);
// :					end
// :
// :					`APB_MASTER1.channel[i][0].w_capacity = `APB_MASTER1.channel[i][0].w_capacity + 1;
// :
// :					//\$display("w_capacity[%0d]=%0x, Burst_size=%0x, Total_size=%0x", i, `APB_MASTER1.channel[i][0].w_capacity, ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth), (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
// :
// :					if(`APB_MASTER1.channel[i][0].w_capacity > (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin
// :						\$display("%0t:%m:ERROR: Channel%0d data more than total length !", \$realtime, i);
// :						\$finish;
// :					end
// :					else if(`APB_MASTER1.channel[i][0].w_capacity == (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin // w_capacity == total_size
// :						#0
// :						\$display("Ch%0d write data: delete desc. w_capacity=%0x", i, `APB_MASTER1.channel[i][0].w_capacity);
// :
// :						if(`APB_MASTER1.error_resp_table[i] == 0) begin 
// :							// scb_queue should be 0 if error happends
// :							// if got error response, scb_queue will be clear by apb_master.pat after headling the error interrupt
// :
// :							if(scb_queue[i].size() > 0) begin
// :								\$display("%t:%m:ERROR: scb_queue[%0d] not empty",\$realtime,i);
// :							end
// :							else begin
// :								\$display("%t: scb_queue[%0d] check finished!",\$realtime,i);
// :							end
// :
// :							foreach(`NDS_BENCH.descriptor_queue[j]) begin // delete the finished descriptor
// :								if(`NDS_BENCH.descriptor_queue[j].src == `APB_MASTER1.channel[i][0].src) begin
// :									`NDS_BENCH.descriptor_queue.delete(j);
// :								end
// :							end
// :
// :							if(`APB_MASTER1.channel[i][0].DstMode == 1) begin // There should be a dst_ack asserted.
// :								excepcted_dst_ack[`APB_MASTER1.channel[i][0].DstReqSel] = 1;
// :								\$display("%t:%m:DBG: Set excepcted_dst_ack[%0d] i=%0d since tts_size==0",\$realtime, `APB_MASTER1.channel[i][0].DstReqSel, i);
// :							end
// :							
// :							`APB_MASTER1.finished_channel_desc[i] = `APB_MASTER1.channel[i].pop_front();
// :							finished_desc_csr[i] = `APB_MASTER1.finished_channel_desc[i].csr;
// :						end
// :						else begin
// :							`APB_MASTER1.channel[i][0].w_capacity = 0;
// :						end
// :					end
// :					else if(((`APB_MASTER1.channel[i][0].w_capacity ) % ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth)) == 0) begin // w_capacity == burst_size
// :						if(`APB_MASTER1.channel[i][0].DstMode == 1) begin // There should be a dst_ack asserted.
// :							excepcted_dst_ack[`APB_MASTER1.channel[i][0].DstReqSel] = 1;
// :							\$display("%t:%m:DBG: Set excepcted_dst_ack[%0d] i=%0d since burst_size==0",\$realtime, `APB_MASTER1.channel[i][0].DstReqSel, i);
// :						end
// :					end
// :				end
// :			end
// :		end	
// :
// :		if(search_flag == 0) begin
// :			\$display("%0t:%m:ERROR: Unexpected write data in slave${i} = %x %x(%0d) %x %x %x %x !",\$realtime, get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);	
// :			\$finish;	
// :		end
// :	end
// :
// :	foreach(`APB_MASTER1.channel[i]) begin
// :		if(`APB_MASTER1.channel[i].size())begin
// :			//\$display("Channel%0d: csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x src_lower=%x src_upper=%x dst_lower=%x dst_upper=%x w_capacity=%x total=%x\\n",i,`APB_MASTER1.channel[i][0].csr, `APB_MASTER1.channel[i][0].tot, `APB_MASTER1.channel[i][0].src, `APB_MASTER1.channel[i][0].dst, `APB_MASTER1.channel[i][0].llp, `APB_MASTER1.channel[i][0].last_llp, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].dst_lower, `APB_MASTER1.channel[i][0].dst_upper, `APB_MASTER1.channel[i][0].w_capacity, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
// :		end
// :	end
// :end
// :
// :
// if (${i} == 1) {
// :`endif
// }
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
always @(`NDS_SYSTEM.axi_slave0.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S0_WRITE
	logic	[SCB_XS0_TOTAL_WIDTH-1:0]	eg_payload;
	realtime				eg_time;
	logic	[SCB_XS0_ADDR_WIDTH-1:0]	addr, scb_addr;
	logic					search_flag;
	logic					scb_search_flag;
	logic	[`DMA_WSTRB_WIDTH-1:0]		expected_wstrb;

	while (`NDS_SYSTEM.axi_slave0.scb_axis_mon.scb_wr_queue_size()) begin
		`NDS_SYSTEM.axi_slave0.scb_axis_mon.scb_wr_dequeue(eg_payload, eg_time);

		search_flag = 0;

		addr = get_addr(eg_payload);

		foreach(`APB_MASTER1.channel[i]) begin
			if(`APB_MASTER1.channel[i].size()) begin
				if((addr >= `APB_MASTER1.channel[i][0].dst_lower) && (addr < `APB_MASTER1.channel[i][0].dst_upper) && (`APB_MASTER1.channel[i][0].DstBusInfIdx == 0) && (`APB_MASTER1.channel[i][0].invalid_desc == 0)) begin

					expected_wstrb = (`DMA_WSTRB_WIDTH)'(wstrb_table[`APB_MASTER1.channel[i][0].DstWidth] << `NDS_SYSTEM.axi_slave0.scb_axis_mon.scb_cur_waddr[`DMA_DATA_SIZE-1:0]);
					if (`NDS_SYSTEM.axi_slave0.scb_axis_mon.scb_in_wstrb != expected_wstrb) begin
						$display("%t:%m:ERROR: unexpected wstrb! wstrb=%0h expected=%0h awsize=%0d", $realtime, `NDS_SYSTEM.axi_slave0.scb_axis_mon.scb_in_wstrb, expected_wstrb, `APB_MASTER1.channel[i][0].DstWidth);
						$finish;
					end

					search_flag = 1;

					if(get_lock(eg_payload) !== 0) begin
						$display("%t:%m:ERROR: unexpected exclusive access!", $realtime);
						$finish;
					end

					if(`APB_MASTER1.channel[i][0].DstAddrCtrl == 0) begin
						scb_addr = addr - `APB_MASTER1.channel[i][0].dst_lower;
					end
					else if(`APB_MASTER1.channel[i][0].DstAddrCtrl == 1) begin
						scb_addr = `APB_MASTER1.channel[i][0].dst_upper - addr - 1;
					end
					else begin
						scb_addr = ((addr - `APB_MASTER1.channel[i][0].dst_lower) >> `APB_MASTER1.channel[i][0].DstWidth) + `APB_MASTER1.channel[i][0].w_capacity;
					end

					eg_payload[SCB_XS0_INFO_WIDTH-SCB_ID_WIDTH-1:SCB_XS0_INFO_WIDTH-SCB_ID_WIDTH-SCB_XS0_ADDR_WIDTH] = scb_addr;
					eg_payload[SCB_XS0_INFO_WIDTH-1:SCB_XS0_INFO_WIDTH-SCB_ID_WIDTH] = i;

					scb_search_flag = 0;
					if(get_status(eg_payload) == 0) begin // only compare the ok response data
						foreach(scb_queue[i][k]) begin // searching the match data form queue
							if(scb_queue[i][k] == eg_payload) begin
								scb_queue[i].delete(k);
								scb_search_flag = 1;
								break;
							end
						end
					end
					else begin // if got any non-ok response toggle the flag
						`APB_MASTER1.error_resp_table[i] = 1;
						$display("%t: Write: channel[%0d] got non-okay response: %0x", $realtime, i, get_status(eg_payload));
					end

					if((scb_search_flag == 0) && (`APB_MASTER1.error_resp_table[i] == 0)) begin
						$display("%t:%m:ERROR: scoreboard mismatch: slave0_write= %x %x(%0d) %x %x %x %x", $realtime,get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);
					end
					else begin
						//$display("slave0_write= %x %x(%0d) %x %x %x %x", get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);
					end

					`APB_MASTER1.channel[i][0].w_capacity = `APB_MASTER1.channel[i][0].w_capacity + 1;

					//$display("w_capacity[%0d]=%0x, Burst_size=%0x, Total_size=%0x", i, `APB_MASTER1.channel[i][0].w_capacity, ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth), (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));

					if(`APB_MASTER1.channel[i][0].w_capacity > (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin
						$display("%0t:%m:ERROR: Channel%0d data more than total length !", $realtime, i);
						$finish;
					end
					else if(`APB_MASTER1.channel[i][0].w_capacity == (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin // w_capacity == total_size
						#0
						$display("Ch%0d write data: delete desc. w_capacity=%0x", i, `APB_MASTER1.channel[i][0].w_capacity);

						if(`APB_MASTER1.error_resp_table[i] == 0) begin
							// scb_queue should be 0 if error happends
							// if got error response, scb_queue will be clear by apb_master.pat after headling the error interrupt

							if(scb_queue[i].size() > 0) begin
								$display("%t:%m:ERROR: scb_queue[%0d] not empty",$realtime,i);
							end
							else begin
								$display("%t: scb_queue[%0d] check finished!",$realtime,i);
							end

							foreach(`NDS_BENCH.descriptor_queue[j]) begin // delete the finished descriptor
								if(`NDS_BENCH.descriptor_queue[j].src == `APB_MASTER1.channel[i][0].src) begin
									`NDS_BENCH.descriptor_queue.delete(j);
								end
							end

							if(`APB_MASTER1.channel[i][0].DstMode == 1) begin // There should be a dst_ack asserted.
								excepcted_dst_ack[`APB_MASTER1.channel[i][0].DstReqSel] = 1;
								$display("%t:%m:DBG: Set excepcted_dst_ack[%0d] i=%0d since tts_size==0",$realtime, `APB_MASTER1.channel[i][0].DstReqSel, i);
							end

							`APB_MASTER1.finished_channel_desc[i] = `APB_MASTER1.channel[i].pop_front();
							finished_desc_csr[i] = `APB_MASTER1.finished_channel_desc[i].csr;
						end
						else begin
							`APB_MASTER1.channel[i][0].w_capacity = 0;
						end
					end
					else if(((`APB_MASTER1.channel[i][0].w_capacity ) % ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth)) == 0) begin // w_capacity == burst_size
						if(`APB_MASTER1.channel[i][0].DstMode == 1) begin // There should be a dst_ack asserted.
							excepcted_dst_ack[`APB_MASTER1.channel[i][0].DstReqSel] = 1;
							$display("%t:%m:DBG: Set excepcted_dst_ack[%0d] i=%0d since burst_size==0",$realtime, `APB_MASTER1.channel[i][0].DstReqSel, i);
						end
					end
				end
			end
		end

		if(search_flag == 0) begin
			$display("%0t:%m:ERROR: Unexpected write data in slave0 = %x %x(%0d) %x %x %x %x !",$realtime, get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);
			$finish;
		end
	end

	foreach(`APB_MASTER1.channel[i]) begin
		if(`APB_MASTER1.channel[i].size())begin
			//$display("Channel%0d: csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x src_lower=%x src_upper=%x dst_lower=%x dst_upper=%x w_capacity=%x total=%x\n",i,`APB_MASTER1.channel[i][0].csr, `APB_MASTER1.channel[i][0].tot, `APB_MASTER1.channel[i][0].src, `APB_MASTER1.channel[i][0].dst, `APB_MASTER1.channel[i][0].llp, `APB_MASTER1.channel[i][0].last_llp, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].dst_lower, `APB_MASTER1.channel[i][0].dst_upper, `APB_MASTER1.channel[i][0].w_capacity, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
		end
	end
end


`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
always @(`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_wr_evt) begin: CAPTURE_S1_WRITE
	logic	[SCB_XS1_TOTAL_WIDTH-1:0]	eg_payload;
	realtime				eg_time;
	logic	[SCB_XS1_ADDR_WIDTH-1:0]	addr, scb_addr;
	logic					search_flag;
	logic					scb_search_flag;
	logic	[`DMA_WSTRB_WIDTH-1:0]		expected_wstrb;

	while (`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_wr_queue_size()) begin
		`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_wr_dequeue(eg_payload, eg_time);

		search_flag = 0;

		addr = get_addr(eg_payload);

		foreach(`APB_MASTER1.channel[i]) begin
			if(`APB_MASTER1.channel[i].size()) begin
				if((addr >= `APB_MASTER1.channel[i][0].dst_lower) && (addr < `APB_MASTER1.channel[i][0].dst_upper) && (`APB_MASTER1.channel[i][0].DstBusInfIdx == 1) && (`APB_MASTER1.channel[i][0].invalid_desc == 0)) begin

					expected_wstrb = (`DMA_WSTRB_WIDTH)'(wstrb_table[`APB_MASTER1.channel[i][0].DstWidth] << `NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_cur_waddr[`DMA_DATA_SIZE-1:0]);
					if (`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_in_wstrb != expected_wstrb) begin
						$display("%t:%m:ERROR: unexpected wstrb! wstrb=%0h expected=%0h awsize=%0d", $realtime, `NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_in_wstrb, expected_wstrb, `APB_MASTER1.channel[i][0].DstWidth);
						$finish;
					end

					search_flag = 1;

					if(get_lock(eg_payload) !== 0) begin
						$display("%t:%m:ERROR: unexpected exclusive access!", $realtime);
						$finish;
					end

					if(`APB_MASTER1.channel[i][0].DstAddrCtrl == 0) begin
						scb_addr = addr - `APB_MASTER1.channel[i][0].dst_lower;
					end
					else if(`APB_MASTER1.channel[i][0].DstAddrCtrl == 1) begin
						scb_addr = `APB_MASTER1.channel[i][0].dst_upper - addr - 1;
					end
					else begin
						scb_addr = ((addr - `APB_MASTER1.channel[i][0].dst_lower) >> `APB_MASTER1.channel[i][0].DstWidth) + `APB_MASTER1.channel[i][0].w_capacity;
					end

					eg_payload[SCB_XS1_INFO_WIDTH-SCB_ID_WIDTH-1:SCB_XS1_INFO_WIDTH-SCB_ID_WIDTH-SCB_XS1_ADDR_WIDTH] = scb_addr;
					eg_payload[SCB_XS1_INFO_WIDTH-1:SCB_XS1_INFO_WIDTH-SCB_ID_WIDTH] = i;

					scb_search_flag = 0;
					if(get_status(eg_payload) == 0) begin // only compare the ok response data
						foreach(scb_queue[i][k]) begin // searching the match data form queue
							if(scb_queue[i][k] == eg_payload) begin
								scb_queue[i].delete(k);
								scb_search_flag = 1;
								break;
							end
						end
					end
					else begin // if got any non-ok response toggle the flag
						`APB_MASTER1.error_resp_table[i] = 1;
						$display("%t: Write: channel[%0d] got non-okay response: %0x", $realtime, i, get_status(eg_payload));
					end

					if((scb_search_flag == 0) && (`APB_MASTER1.error_resp_table[i] == 0)) begin
						$display("%t:%m:ERROR: scoreboard mismatch: slave1_write= %x %x(%0d) %x %x %x %x", $realtime,get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);
					end
					else begin
						//$display("slave1_write= %x %x(%0d) %x %x %x %x", get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);
					end

					`APB_MASTER1.channel[i][0].w_capacity = `APB_MASTER1.channel[i][0].w_capacity + 1;

					//$display("w_capacity[%0d]=%0x, Burst_size=%0x, Total_size=%0x", i, `APB_MASTER1.channel[i][0].w_capacity, ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth), (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));

					if(`APB_MASTER1.channel[i][0].w_capacity > (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin
						$display("%0t:%m:ERROR: Channel%0d data more than total length !", $realtime, i);
						$finish;
					end
					else if(`APB_MASTER1.channel[i][0].w_capacity == (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin // w_capacity == total_size
						#0
						$display("Ch%0d write data: delete desc. w_capacity=%0x", i, `APB_MASTER1.channel[i][0].w_capacity);

						if(`APB_MASTER1.error_resp_table[i] == 0) begin
							// scb_queue should be 0 if error happends
							// if got error response, scb_queue will be clear by apb_master.pat after headling the error interrupt

							if(scb_queue[i].size() > 0) begin
								$display("%t:%m:ERROR: scb_queue[%0d] not empty",$realtime,i);
							end
							else begin
								$display("%t: scb_queue[%0d] check finished!",$realtime,i);
							end

							foreach(`NDS_BENCH.descriptor_queue[j]) begin // delete the finished descriptor
								if(`NDS_BENCH.descriptor_queue[j].src == `APB_MASTER1.channel[i][0].src) begin
									`NDS_BENCH.descriptor_queue.delete(j);
								end
							end

							if(`APB_MASTER1.channel[i][0].DstMode == 1) begin // There should be a dst_ack asserted.
								excepcted_dst_ack[`APB_MASTER1.channel[i][0].DstReqSel] = 1;
								$display("%t:%m:DBG: Set excepcted_dst_ack[%0d] i=%0d since tts_size==0",$realtime, `APB_MASTER1.channel[i][0].DstReqSel, i);
							end

							`APB_MASTER1.finished_channel_desc[i] = `APB_MASTER1.channel[i].pop_front();
							finished_desc_csr[i] = `APB_MASTER1.finished_channel_desc[i].csr;
						end
						else begin
							`APB_MASTER1.channel[i][0].w_capacity = 0;
						end
					end
					else if(((`APB_MASTER1.channel[i][0].w_capacity ) % ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth)) == 0) begin // w_capacity == burst_size
						if(`APB_MASTER1.channel[i][0].DstMode == 1) begin // There should be a dst_ack asserted.
							excepcted_dst_ack[`APB_MASTER1.channel[i][0].DstReqSel] = 1;
							$display("%t:%m:DBG: Set excepcted_dst_ack[%0d] i=%0d since burst_size==0",$realtime, `APB_MASTER1.channel[i][0].DstReqSel, i);
						end
					end
				end
			end
		end

		if(search_flag == 0) begin
			$display("%0t:%m:ERROR: Unexpected write data in slave1 = %x %x(%0d) %x %x %x %x !",$realtime, get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);
			$finish;
		end
	end

	foreach(`APB_MASTER1.channel[i]) begin
		if(`APB_MASTER1.channel[i].size())begin
			//$display("Channel%0d: csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x src_lower=%x src_upper=%x dst_lower=%x dst_upper=%x w_capacity=%x total=%x\n",i,`APB_MASTER1.channel[i][0].csr, `APB_MASTER1.channel[i][0].tot, `APB_MASTER1.channel[i][0].src, `APB_MASTER1.channel[i][0].dst, `APB_MASTER1.channel[i][0].llp, `APB_MASTER1.channel[i][0].last_llp, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].dst_lower, `APB_MASTER1.channel[i][0].dst_upper, `APB_MASTER1.channel[i][0].w_capacity, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
		end
	end
end


`endif
// VPERL_GENERATED_END

// Capture read at the AXI slave.

// VPERL_BEGIN
// foreach $i (0 .. 1) {
// if (${i} == 1) {
// :`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// }
// :always @(`NDS_SYSTEM.axi_slave${i}.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S${i}_READ
// :	logic	[SCB_XS${i}_TOTAL_WIDTH-1:0]	eg_payload;
// :	realtime				eg_time;
// :	logic	[SCB_XS${i}_ADDR_WIDTH-1:0]	addr, scb_addr;
// :	logic					search_flag;
// :	logic					check_arlen;
// :	logic	[31:0]				len_candidate[5];
// :
// :	check_arlen = 0;
// :
// :	while (`NDS_SYSTEM.axi_slave${i}.scb_axis_mon.scb_rd_queue_size()) begin
// :		`NDS_SYSTEM.axi_slave${i}.scb_axis_mon.scb_rd_dequeue(eg_payload, eg_time);
// :
// :		search_flag = 0;
// :
// :		addr = get_addr(eg_payload);
// :
// :		foreach(`APB_MASTER1.channel[i]) begin
// :			if(`APB_MASTER1.channel[i].size()) begin
// :				if((addr >= `APB_MASTER1.channel[i][0].src_lower) && (addr < `APB_MASTER1.channel[i][0].src_upper) && (`APB_MASTER1.channel[i][0].SrcBusInfIdx == ${i}) && (`APB_MASTER1.channel[i][0].invalid_desc == 0)) begin
// :
// :					search_flag = 1; // hit
// :				
// :					// check the arlen at first...
// :					// axlen will be the smallest value among these:
// :					// 1. TOT_LENGTH
// :					// 2. SRC_BURST_LENGTH - transferred bytes in this src burst size
// :					// 3. 256
// :					// 4. (TOTAL_FIFO_BYTES >>SRC_width) - transferred bytes in this src burst size
// :					// 5. (0x1000 - {1'b0, addr[11:0]}) >> SRC_width. (The address range should not cross 4K boundary. The address should be aligned to the size.)
// :					// * the len will always be 1 in decremental address
// :
// :					if(check_arlen == 0) begin // only check arlen at the first byte (check_arlen will be 1 after checking arlen)
// :						len_candidate = {32'(`APB_MASTER1.channel[i][0].tot - (`APB_MASTER1.channel[i][0].r_capacity >> `APB_MASTER1.channel[i][0].SrcWidth)), 32'((1'b1 << `APB_MASTER1.channel[i][0].SrcBurstSize) - ((`APB_MASTER1.channel[i][0].r_capacity >> `APB_MASTER1.channel[i][0].SrcWidth) % (1'b1 << `APB_MASTER1.channel[i][0].SrcBurstSize))), (`AXI_SLAVE${i}.current_rburst == 0 ? 32'(16) : 32'(256)), 32'(((`NDS_FIFO_DEPTH << `DMA_DATA_SIZE) >> `APB_MASTER1.channel[i][0].SrcWidth) - (((`APB_MASTER1.channel[i][0].r_capacity >> `APB_MASTER1.channel[i][0].SrcWidth) % (1'b1 << `APB_MASTER1.channel[i][0].SrcBurstSize)) % ((`NDS_FIFO_DEPTH << `DMA_DATA_SIZE) >> `APB_MASTER1.channel[i][0].SrcWidth))), 32'(((1'b1 << 12) - {1'b0, addr[11:0]}) >> `APB_MASTER1.channel[i][0].SrcWidth)};
// :
// :						//foreach(len_candidate[k])begin
// :						//	\$display("len_candidate[%0d]=%x",k,len_candidate[k]);
// :						//end
// :
// :						len_candidate.sort(); // sort array, the smallest element will be moved to [0]
// :
// :						if(`APB_MASTER1.channel[i][0].SrcAddrCtrl == 1) begin
// :							if(32'(`AXI_SLAVE${i}.current_rlen + 1) != 1) begin
// :								\$display("%t:%m:ERROR: arlen is unexpected, exp: %x got: %x", \$realtime, 1, `AXI_SLAVE${i}.current_rlen + 1);
// :								\$finish;
// :							end
// :						end
// :						else begin
// :							if(32'(`AXI_SLAVE${i}.current_rlen + 1) != len_candidate[0]) begin
// :								\$display("%t:%m:ERROR: arlen is unexpected, exp: %x got: %x", \$realtime, len_candidate[0], `AXI_SLAVE${i}.current_rlen + 1);
// :								\$finish;
// :							end
// :						end
// :						check_arlen = 1; // arlen checking is finished
// :					end
// :
// :					if(get_lock(eg_payload) !== 0) begin
// :						\$display("%t:%m:ERROR: unexpected exclusive access!", \$realtime);
// :						\$finish;
// :					end
// :
// :					if(`APB_MASTER1.channel[i][0].SrcAddrCtrl == 0) begin
// :						scb_addr = addr - `APB_MASTER1.channel[i][0].src_lower;
// :					end
// :					else if(`APB_MASTER1.channel[i][0].SrcAddrCtrl == 1) begin
// :						scb_addr = `APB_MASTER1.channel[i][0].src_upper - addr - 1;
// :					end
// :					else begin
// :						scb_addr = ((addr - `APB_MASTER1.channel[i][0].src_lower) >> `APB_MASTER1.channel[i][0].SrcWidth) + `APB_MASTER1.channel[i][0].r_capacity;
// :						//\$display("Ch%0d read  data: %x + %x = %x", i, ((addr - `APB_MASTER1.channel[i][0].src_lower) >> `APB_MASTER1.channel[i][0].SrcWidth),`APB_MASTER1.channel[i][0].r_capacity, scb_addr);
// :					end
// :					
// :					//\$display("Ch%0d read  data: addr=%x src_lower=%x src_upper=%x r_capacity=%x scb_addr=%x total=%x", i, addr, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].r_capacity, scb_addr, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
// :
// :					eg_payload[SCB_XS${i}_INFO_WIDTH-SCB_ID_WIDTH-1:SCB_XS${i}_INFO_WIDTH-SCB_ID_WIDTH-SCB_XS${i}_ADDR_WIDTH] = scb_addr;
// :					eg_payload[SCB_XS${i}_INFO_WIDTH-1:SCB_XS${i}_INFO_WIDTH-SCB_ID_WIDTH] = i;
// :
// :					if(get_status(eg_payload) == 0) begin // only push the ok response data
// :						scb_queue[i].push_back(eg_payload);
// :						scb_time[i].push_back(eg_time);
// :					end
// :					else begin // if got any non-ok response toggle the flag
// :						`APB_MASTER1.error_resp_table[i] = 1;
// :						\$display("%t: Read: channel[%0d] got non-okay response: %0x", \$realtime, i, get_status(eg_payload));
// :					end
// :
// :					//\$display("slave${i}_read = %x %x(%0d) %x %x %x %x", get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);
// :
// :					`APB_MASTER1.channel[i][0].r_capacity = `APB_MASTER1.channel[i][0].r_capacity + 1;
// :
// :					//\$display("r_capacity[%0d]=%0x, Burst_size=%0x, Total_size=%0x", i, `APB_MASTER1.channel[i][0].r_capacity, ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth), (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
// :
// :					if(`APB_MASTER1.channel[i][0].r_capacity > (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin
// :						\$display("%0t:%m:ERROR: Channel%0d data more than total length !", \$realtime, i);
// :						\$finish;
// :					end
// :					else if((`APB_MASTER1.channel[i][0].r_capacity ) == (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin // r_capacity == total_size
// :						\$display("Ch%0d read  data: read finished. r_capacity=%0x", i, `APB_MASTER1.channel[i][0].r_capacity);
// :						if(`APB_MASTER1.channel[i][0].SrcMode == 1) begin // There should be a src_ack asserted.
// :							excepcted_src_ack[`APB_MASTER1.channel[i][0].SrcReqSel] = 1;
// :							\$display("%t:%m:DBG: Set excepcted_src_ack[%0d] i=%0d since tts_size==0",\$realtime, `APB_MASTER1.channel[i][0].SrcReqSel, i);
// :						end
// :					end
// :					else if(((`APB_MASTER1.channel[i][0].r_capacity ) % ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth)) == 0) begin // r_capacity == burst_size
// :						if(`APB_MASTER1.channel[i][0].SrcMode == 1) begin // There should be a src_ack asserted.
// :							excepcted_src_ack[`APB_MASTER1.channel[i][0].SrcReqSel] = 1;
// :							\$display("%t:%m:DBG: Set excepcted_src_ack[%0d] i=%0d since burst_size==0",\$realtime, `APB_MASTER1.channel[i][0].SrcReqSel, i);
// :						end
// :					end
// :				end
// :			end
// :		end	
// :
// :		if(search_flag == 0) begin // read llp data won't be push to scb_queue.
// :			foreach(`APB_MASTER1.channel[i]) begin
// :				if(`APB_MASTER1.channel[i].size() > 0) begin
// :					if((addr >= {`APB_MASTER1.channel[i][0].last_llp[63:2],2'b0}) && (addr < ({`APB_MASTER1.channel[i][0].last_llp[63:2],2'b0} + 32)) && (`APB_MASTER1.channel[i][0].last_llp[0] == ${i})) begin // current desc will be deleted when finished, so need to check the next desc's last_llp.
// :						if(get_status(eg_payload) != 0) begin // if got error response when read llp
// :							`APB_MASTER1.error_resp_table[i] = 1;
// :							\$display("%t: Read: channel[%0d] got non-okay response: %0x when reading llp", \$realtime, i, get_status(eg_payload));
// :						end
// :						search_flag = 1; // read llp is an expected bus behavior.
// :					end
// :				end
// :			end	
// :		end
// :
// :		if(search_flag == 0) begin // rdata that not belong to any desc or llp will be regarded as unexpexted data.
// :			foreach(`APB_MASTER1.channel[i]) begin
// :				if(`APB_MASTER1.channel[i].size())begin
// :					//\$display("Channel%0d: csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x src_lower=%x src_upper=%x dst_lower=%x upper=%x r_capacity=%x total=%x\\n",i,`APB_MASTER1.channel[i][0].csr, `APB_MASTER1.channel[i][0].tot, `APB_MASTER1.channel[i][0].src, `APB_MASTER1.channel[i][0].dst, `APB_MASTER1.channel[i][0].llp, `APB_MASTER1.channel[i][0].last_llp, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].dst_lower, `APB_MASTER1.channel[i][0].dst_upper, `APB_MASTER1.channel[i][0].r_capacity, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
// :				end
// :			end
// :			\$display("%0t:%m:ERROR: Unexpected read data in slave${i} = %x %x(%0d) %x %x %x %x !",\$realtime, get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);	
// :			\$finish;	
// :		end
// :	end
// :
// :	foreach(`APB_MASTER1.channel[i]) begin
// :		if(`APB_MASTER1.channel[i].size())begin
// :			//\$display("Channel%0d: csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x src_lower=%x src_upper=%x dst_lower=%x upper=%x r_capacity=%x total=%x\\n",i,`APB_MASTER1.channel[i][0].csr, `APB_MASTER1.channel[i][0].tot, `APB_MASTER1.channel[i][0].src, `APB_MASTER1.channel[i][0].dst, `APB_MASTER1.channel[i][0].llp, `APB_MASTER1.channel[i][0].last_llp, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].dst_lower, `APB_MASTER1.channel[i][0].dst_upper, `APB_MASTER1.channel[i][0].r_capacity, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
// :		end
// :	end
// :end
// :
// :
// if (${i} == 1) {
// :`endif
// }
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
always @(`NDS_SYSTEM.axi_slave0.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S0_READ
	logic	[SCB_XS0_TOTAL_WIDTH-1:0]	eg_payload;
	realtime				eg_time;
	logic	[SCB_XS0_ADDR_WIDTH-1:0]	addr, scb_addr;
	logic					search_flag;
	logic					check_arlen;
	logic	[31:0]				len_candidate[5];

	check_arlen = 0;

	while (`NDS_SYSTEM.axi_slave0.scb_axis_mon.scb_rd_queue_size()) begin
		`NDS_SYSTEM.axi_slave0.scb_axis_mon.scb_rd_dequeue(eg_payload, eg_time);

		search_flag = 0;

		addr = get_addr(eg_payload);

		foreach(`APB_MASTER1.channel[i]) begin
			if(`APB_MASTER1.channel[i].size()) begin
				if((addr >= `APB_MASTER1.channel[i][0].src_lower) && (addr < `APB_MASTER1.channel[i][0].src_upper) && (`APB_MASTER1.channel[i][0].SrcBusInfIdx == 0) && (`APB_MASTER1.channel[i][0].invalid_desc == 0)) begin

					search_flag = 1; // hit

					// check the arlen at first...
					// axlen will be the smallest value among these:
					// 1. TOT_LENGTH
					// 2. SRC_BURST_LENGTH - transferred bytes in this src burst size
					// 3. 256
					// 4. (TOTAL_FIFO_BYTES >>SRC_width) - transferred bytes in this src burst size
					// 5. (0x1000 - {1'b0, addr[11:0]}) >> SRC_width. (The address range should not cross 4K boundary. The address should be aligned to the size.)
					// * the len will always be 1 in decremental address

					if(check_arlen == 0) begin // only check arlen at the first byte (check_arlen will be 1 after checking arlen)
						len_candidate = {32'(`APB_MASTER1.channel[i][0].tot - (`APB_MASTER1.channel[i][0].r_capacity >> `APB_MASTER1.channel[i][0].SrcWidth)), 32'((1'b1 << `APB_MASTER1.channel[i][0].SrcBurstSize) - ((`APB_MASTER1.channel[i][0].r_capacity >> `APB_MASTER1.channel[i][0].SrcWidth) % (1'b1 << `APB_MASTER1.channel[i][0].SrcBurstSize))), (`AXI_SLAVE0.current_rburst == 0 ? 32'(16) : 32'(256)), 32'(((`NDS_FIFO_DEPTH << `DMA_DATA_SIZE) >> `APB_MASTER1.channel[i][0].SrcWidth) - (((`APB_MASTER1.channel[i][0].r_capacity >> `APB_MASTER1.channel[i][0].SrcWidth) % (1'b1 << `APB_MASTER1.channel[i][0].SrcBurstSize)) % ((`NDS_FIFO_DEPTH << `DMA_DATA_SIZE) >> `APB_MASTER1.channel[i][0].SrcWidth))), 32'(((1'b1 << 12) - {1'b0, addr[11:0]}) >> `APB_MASTER1.channel[i][0].SrcWidth)};

						//foreach(len_candidate[k])begin
						//	$display("len_candidate[%0d]=%x",k,len_candidate[k]);
						//end

						len_candidate.sort(); // sort array, the smallest element will be moved to [0]

						if(`APB_MASTER1.channel[i][0].SrcAddrCtrl == 1) begin
							if(32'(`AXI_SLAVE0.current_rlen + 1) != 1) begin
								$display("%t:%m:ERROR: arlen is unexpected, exp: %x got: %x", $realtime, 1, `AXI_SLAVE0.current_rlen + 1);
								$finish;
							end
						end
						else begin
							if(32'(`AXI_SLAVE0.current_rlen + 1) != len_candidate[0]) begin
								$display("%t:%m:ERROR: arlen is unexpected, exp: %x got: %x", $realtime, len_candidate[0], `AXI_SLAVE0.current_rlen + 1);
								$finish;
							end
						end
						check_arlen = 1; // arlen checking is finished
					end

					if(get_lock(eg_payload) !== 0) begin
						$display("%t:%m:ERROR: unexpected exclusive access!", $realtime);
						$finish;
					end

					if(`APB_MASTER1.channel[i][0].SrcAddrCtrl == 0) begin
						scb_addr = addr - `APB_MASTER1.channel[i][0].src_lower;
					end
					else if(`APB_MASTER1.channel[i][0].SrcAddrCtrl == 1) begin
						scb_addr = `APB_MASTER1.channel[i][0].src_upper - addr - 1;
					end
					else begin
						scb_addr = ((addr - `APB_MASTER1.channel[i][0].src_lower) >> `APB_MASTER1.channel[i][0].SrcWidth) + `APB_MASTER1.channel[i][0].r_capacity;
						//$display("Ch%0d read  data: %x + %x = %x", i, ((addr - `APB_MASTER1.channel[i][0].src_lower) >> `APB_MASTER1.channel[i][0].SrcWidth),`APB_MASTER1.channel[i][0].r_capacity, scb_addr);
					end

					//$display("Ch%0d read  data: addr=%x src_lower=%x src_upper=%x r_capacity=%x scb_addr=%x total=%x", i, addr, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].r_capacity, scb_addr, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));

					eg_payload[SCB_XS0_INFO_WIDTH-SCB_ID_WIDTH-1:SCB_XS0_INFO_WIDTH-SCB_ID_WIDTH-SCB_XS0_ADDR_WIDTH] = scb_addr;
					eg_payload[SCB_XS0_INFO_WIDTH-1:SCB_XS0_INFO_WIDTH-SCB_ID_WIDTH] = i;

					if(get_status(eg_payload) == 0) begin // only push the ok response data
						scb_queue[i].push_back(eg_payload);
						scb_time[i].push_back(eg_time);
					end
					else begin // if got any non-ok response toggle the flag
						`APB_MASTER1.error_resp_table[i] = 1;
						$display("%t: Read: channel[%0d] got non-okay response: %0x", $realtime, i, get_status(eg_payload));
					end

					//$display("slave0_read = %x %x(%0d) %x %x %x %x", get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);

					`APB_MASTER1.channel[i][0].r_capacity = `APB_MASTER1.channel[i][0].r_capacity + 1;

					//$display("r_capacity[%0d]=%0x, Burst_size=%0x, Total_size=%0x", i, `APB_MASTER1.channel[i][0].r_capacity, ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth), (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));

					if(`APB_MASTER1.channel[i][0].r_capacity > (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin
						$display("%0t:%m:ERROR: Channel%0d data more than total length !", $realtime, i);
						$finish;
					end
					else if((`APB_MASTER1.channel[i][0].r_capacity ) == (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin // r_capacity == total_size
						$display("Ch%0d read  data: read finished. r_capacity=%0x", i, `APB_MASTER1.channel[i][0].r_capacity);
						if(`APB_MASTER1.channel[i][0].SrcMode == 1) begin // There should be a src_ack asserted.
							excepcted_src_ack[`APB_MASTER1.channel[i][0].SrcReqSel] = 1;
							$display("%t:%m:DBG: Set excepcted_src_ack[%0d] i=%0d since tts_size==0",$realtime, `APB_MASTER1.channel[i][0].SrcReqSel, i);
						end
					end
					else if(((`APB_MASTER1.channel[i][0].r_capacity ) % ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth)) == 0) begin // r_capacity == burst_size
						if(`APB_MASTER1.channel[i][0].SrcMode == 1) begin // There should be a src_ack asserted.
							excepcted_src_ack[`APB_MASTER1.channel[i][0].SrcReqSel] = 1;
							$display("%t:%m:DBG: Set excepcted_src_ack[%0d] i=%0d since burst_size==0",$realtime, `APB_MASTER1.channel[i][0].SrcReqSel, i);
						end
					end
				end
			end
		end

		if(search_flag == 0) begin // read llp data won't be push to scb_queue.
			foreach(`APB_MASTER1.channel[i]) begin
				if(`APB_MASTER1.channel[i].size() > 0) begin
					if((addr >= {`APB_MASTER1.channel[i][0].last_llp[63:2],2'b0}) && (addr < ({`APB_MASTER1.channel[i][0].last_llp[63:2],2'b0} + 32)) && (`APB_MASTER1.channel[i][0].last_llp[0] == 0)) begin // current desc will be deleted when finished, so need to check the next desc's last_llp.
						if(get_status(eg_payload) != 0) begin // if got error response when read llp
							`APB_MASTER1.error_resp_table[i] = 1;
							$display("%t: Read: channel[%0d] got non-okay response: %0x when reading llp", $realtime, i, get_status(eg_payload));
						end
						search_flag = 1; // read llp is an expected bus behavior.
					end
				end
			end
		end

		if(search_flag == 0) begin // rdata that not belong to any desc or llp will be regarded as unexpexted data.
			foreach(`APB_MASTER1.channel[i]) begin
				if(`APB_MASTER1.channel[i].size())begin
					//$display("Channel%0d: csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x src_lower=%x src_upper=%x dst_lower=%x upper=%x r_capacity=%x total=%x\n",i,`APB_MASTER1.channel[i][0].csr, `APB_MASTER1.channel[i][0].tot, `APB_MASTER1.channel[i][0].src, `APB_MASTER1.channel[i][0].dst, `APB_MASTER1.channel[i][0].llp, `APB_MASTER1.channel[i][0].last_llp, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].dst_lower, `APB_MASTER1.channel[i][0].dst_upper, `APB_MASTER1.channel[i][0].r_capacity, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
				end
			end
			$display("%0t:%m:ERROR: Unexpected read data in slave0 = %x %x(%0d) %x %x %x %x !",$realtime, get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);
			$finish;
		end
	end

	foreach(`APB_MASTER1.channel[i]) begin
		if(`APB_MASTER1.channel[i].size())begin
			//$display("Channel%0d: csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x src_lower=%x src_upper=%x dst_lower=%x upper=%x r_capacity=%x total=%x\n",i,`APB_MASTER1.channel[i][0].csr, `APB_MASTER1.channel[i][0].tot, `APB_MASTER1.channel[i][0].src, `APB_MASTER1.channel[i][0].dst, `APB_MASTER1.channel[i][0].llp, `APB_MASTER1.channel[i][0].last_llp, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].dst_lower, `APB_MASTER1.channel[i][0].dst_upper, `APB_MASTER1.channel[i][0].r_capacity, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
		end
	end
end


`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
always @(`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_rd_evt) begin: CAPTURE_S1_READ
	logic	[SCB_XS1_TOTAL_WIDTH-1:0]	eg_payload;
	realtime				eg_time;
	logic	[SCB_XS1_ADDR_WIDTH-1:0]	addr, scb_addr;
	logic					search_flag;
	logic					check_arlen;
	logic	[31:0]				len_candidate[5];

	check_arlen = 0;

	while (`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_rd_queue_size()) begin
		`NDS_SYSTEM.axi_slave1.scb_axis_mon.scb_rd_dequeue(eg_payload, eg_time);

		search_flag = 0;

		addr = get_addr(eg_payload);

		foreach(`APB_MASTER1.channel[i]) begin
			if(`APB_MASTER1.channel[i].size()) begin
				if((addr >= `APB_MASTER1.channel[i][0].src_lower) && (addr < `APB_MASTER1.channel[i][0].src_upper) && (`APB_MASTER1.channel[i][0].SrcBusInfIdx == 1) && (`APB_MASTER1.channel[i][0].invalid_desc == 0)) begin

					search_flag = 1; // hit

					// check the arlen at first...
					// axlen will be the smallest value among these:
					// 1. TOT_LENGTH
					// 2. SRC_BURST_LENGTH - transferred bytes in this src burst size
					// 3. 256
					// 4. (TOTAL_FIFO_BYTES >>SRC_width) - transferred bytes in this src burst size
					// 5. (0x1000 - {1'b0, addr[11:0]}) >> SRC_width. (The address range should not cross 4K boundary. The address should be aligned to the size.)
					// * the len will always be 1 in decremental address

					if(check_arlen == 0) begin // only check arlen at the first byte (check_arlen will be 1 after checking arlen)
						len_candidate = {32'(`APB_MASTER1.channel[i][0].tot - (`APB_MASTER1.channel[i][0].r_capacity >> `APB_MASTER1.channel[i][0].SrcWidth)), 32'((1'b1 << `APB_MASTER1.channel[i][0].SrcBurstSize) - ((`APB_MASTER1.channel[i][0].r_capacity >> `APB_MASTER1.channel[i][0].SrcWidth) % (1'b1 << `APB_MASTER1.channel[i][0].SrcBurstSize))), (`AXI_SLAVE1.current_rburst == 0 ? 32'(16) : 32'(256)), 32'(((`NDS_FIFO_DEPTH << `DMA_DATA_SIZE) >> `APB_MASTER1.channel[i][0].SrcWidth) - (((`APB_MASTER1.channel[i][0].r_capacity >> `APB_MASTER1.channel[i][0].SrcWidth) % (1'b1 << `APB_MASTER1.channel[i][0].SrcBurstSize)) % ((`NDS_FIFO_DEPTH << `DMA_DATA_SIZE) >> `APB_MASTER1.channel[i][0].SrcWidth))), 32'(((1'b1 << 12) - {1'b0, addr[11:0]}) >> `APB_MASTER1.channel[i][0].SrcWidth)};

						//foreach(len_candidate[k])begin
						//	$display("len_candidate[%0d]=%x",k,len_candidate[k]);
						//end

						len_candidate.sort(); // sort array, the smallest element will be moved to [0]

						if(`APB_MASTER1.channel[i][0].SrcAddrCtrl == 1) begin
							if(32'(`AXI_SLAVE1.current_rlen + 1) != 1) begin
								$display("%t:%m:ERROR: arlen is unexpected, exp: %x got: %x", $realtime, 1, `AXI_SLAVE1.current_rlen + 1);
								$finish;
							end
						end
						else begin
							if(32'(`AXI_SLAVE1.current_rlen + 1) != len_candidate[0]) begin
								$display("%t:%m:ERROR: arlen is unexpected, exp: %x got: %x", $realtime, len_candidate[0], `AXI_SLAVE1.current_rlen + 1);
								$finish;
							end
						end
						check_arlen = 1; // arlen checking is finished
					end

					if(get_lock(eg_payload) !== 0) begin
						$display("%t:%m:ERROR: unexpected exclusive access!", $realtime);
						$finish;
					end

					if(`APB_MASTER1.channel[i][0].SrcAddrCtrl == 0) begin
						scb_addr = addr - `APB_MASTER1.channel[i][0].src_lower;
					end
					else if(`APB_MASTER1.channel[i][0].SrcAddrCtrl == 1) begin
						scb_addr = `APB_MASTER1.channel[i][0].src_upper - addr - 1;
					end
					else begin
						scb_addr = ((addr - `APB_MASTER1.channel[i][0].src_lower) >> `APB_MASTER1.channel[i][0].SrcWidth) + `APB_MASTER1.channel[i][0].r_capacity;
						//$display("Ch%0d read  data: %x + %x = %x", i, ((addr - `APB_MASTER1.channel[i][0].src_lower) >> `APB_MASTER1.channel[i][0].SrcWidth),`APB_MASTER1.channel[i][0].r_capacity, scb_addr);
					end

					//$display("Ch%0d read  data: addr=%x src_lower=%x src_upper=%x r_capacity=%x scb_addr=%x total=%x", i, addr, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].r_capacity, scb_addr, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));

					eg_payload[SCB_XS1_INFO_WIDTH-SCB_ID_WIDTH-1:SCB_XS1_INFO_WIDTH-SCB_ID_WIDTH-SCB_XS1_ADDR_WIDTH] = scb_addr;
					eg_payload[SCB_XS1_INFO_WIDTH-1:SCB_XS1_INFO_WIDTH-SCB_ID_WIDTH] = i;

					if(get_status(eg_payload) == 0) begin // only push the ok response data
						scb_queue[i].push_back(eg_payload);
						scb_time[i].push_back(eg_time);
					end
					else begin // if got any non-ok response toggle the flag
						`APB_MASTER1.error_resp_table[i] = 1;
						$display("%t: Read: channel[%0d] got non-okay response: %0x", $realtime, i, get_status(eg_payload));
					end

					//$display("slave1_read = %x %x(%0d) %x %x %x %x", get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);

					`APB_MASTER1.channel[i][0].r_capacity = `APB_MASTER1.channel[i][0].r_capacity + 1;

					//$display("r_capacity[%0d]=%0x, Burst_size=%0x, Total_size=%0x", i, `APB_MASTER1.channel[i][0].r_capacity, ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth), (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));

					if(`APB_MASTER1.channel[i][0].r_capacity > (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin
						$display("%0t:%m:ERROR: Channel%0d data more than total length !", $realtime, i);
						$finish;
					end
					else if((`APB_MASTER1.channel[i][0].r_capacity ) == (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth)) begin // r_capacity == total_size
						$display("Ch%0d read  data: read finished. r_capacity=%0x", i, `APB_MASTER1.channel[i][0].r_capacity);
						if(`APB_MASTER1.channel[i][0].SrcMode == 1) begin // There should be a src_ack asserted.
							excepcted_src_ack[`APB_MASTER1.channel[i][0].SrcReqSel] = 1;
							$display("%t:%m:DBG: Set excepcted_src_ack[%0d] i=%0d since tts_size==0",$realtime, `APB_MASTER1.channel[i][0].SrcReqSel, i);
						end
					end
					else if(((`APB_MASTER1.channel[i][0].r_capacity ) % ((1 << `APB_MASTER1.channel[i][0].SrcBurstSize) << `APB_MASTER1.channel[i][0].SrcWidth)) == 0) begin // r_capacity == burst_size
						if(`APB_MASTER1.channel[i][0].SrcMode == 1) begin // There should be a src_ack asserted.
							excepcted_src_ack[`APB_MASTER1.channel[i][0].SrcReqSel] = 1;
							$display("%t:%m:DBG: Set excepcted_src_ack[%0d] i=%0d since burst_size==0",$realtime, `APB_MASTER1.channel[i][0].SrcReqSel, i);
						end
					end
				end
			end
		end

		if(search_flag == 0) begin // read llp data won't be push to scb_queue.
			foreach(`APB_MASTER1.channel[i]) begin
				if(`APB_MASTER1.channel[i].size() > 0) begin
					if((addr >= {`APB_MASTER1.channel[i][0].last_llp[63:2],2'b0}) && (addr < ({`APB_MASTER1.channel[i][0].last_llp[63:2],2'b0} + 32)) && (`APB_MASTER1.channel[i][0].last_llp[0] == 1)) begin // current desc will be deleted when finished, so need to check the next desc's last_llp.
						if(get_status(eg_payload) != 0) begin // if got error response when read llp
							`APB_MASTER1.error_resp_table[i] = 1;
							$display("%t: Read: channel[%0d] got non-okay response: %0x when reading llp", $realtime, i, get_status(eg_payload));
						end
						search_flag = 1; // read llp is an expected bus behavior.
					end
				end
			end
		end

		if(search_flag == 0) begin // rdata that not belong to any desc or llp will be regarded as unexpexted data.
			foreach(`APB_MASTER1.channel[i]) begin
				if(`APB_MASTER1.channel[i].size())begin
					//$display("Channel%0d: csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x src_lower=%x src_upper=%x dst_lower=%x upper=%x r_capacity=%x total=%x\n",i,`APB_MASTER1.channel[i][0].csr, `APB_MASTER1.channel[i][0].tot, `APB_MASTER1.channel[i][0].src, `APB_MASTER1.channel[i][0].dst, `APB_MASTER1.channel[i][0].llp, `APB_MASTER1.channel[i][0].last_llp, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].dst_lower, `APB_MASTER1.channel[i][0].dst_upper, `APB_MASTER1.channel[i][0].r_capacity, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
				end
			end
			$display("%0t:%m:ERROR: Unexpected read data in slave1 = %x %x(%0d) %x %x %x %x !",$realtime, get_status(eg_payload), get_id(eg_payload), get_id(eg_payload), get_addr(eg_payload), get_data(eg_payload), get_lock(eg_payload), addr);
			$finish;
		end
	end

	foreach(`APB_MASTER1.channel[i]) begin
		if(`APB_MASTER1.channel[i].size())begin
			//$display("Channel%0d: csr=%x tot=%x src=%x dst=%x llp=%x last_llp=%x src_lower=%x src_upper=%x dst_lower=%x upper=%x r_capacity=%x total=%x\n",i,`APB_MASTER1.channel[i][0].csr, `APB_MASTER1.channel[i][0].tot, `APB_MASTER1.channel[i][0].src, `APB_MASTER1.channel[i][0].dst, `APB_MASTER1.channel[i][0].llp, `APB_MASTER1.channel[i][0].last_llp, `APB_MASTER1.channel[i][0].src_lower, `APB_MASTER1.channel[i][0].src_upper, `APB_MASTER1.channel[i][0].dst_lower, `APB_MASTER1.channel[i][0].dst_upper, `APB_MASTER1.channel[i][0].r_capacity, (`APB_MASTER1.channel[i][0].tot << `APB_MASTER1.channel[i][0].SrcWidth));
		end
	end
end


`endif
// VPERL_GENERATED_END
//
// Final check.
//
// Call this when the system finishes or the pattern wants to clean out.
task scb_final_compare;
begin
	$display("%0t:%m:INFO: Compare all residues in scoreboards.", $realtime);
	foreach(scb_queue[i]) begin
		if(scb_queue[i].size() > 0) begin
			$display("%0t:%m:ERROR: scb_queue.size() > 0", $realtime);
		end
		else begin
			$display("scb_queue[%0d] clear.",i);
		end
	end

end
endtask

endmodule

