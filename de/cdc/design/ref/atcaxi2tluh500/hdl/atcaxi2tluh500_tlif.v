module atcaxi2tluh500_tlif (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  clk,      
        	  resetn,   
        	  a_valid,  
        	  a_ready,  
        	  a_opcode, 
        	  a_size,   
        	  a_source, 
        	  a_address,
        	  a_mask,   
        	  a_data,   
        	  a_user,   
        	  a_corrupt,
        	  a_param,  
        	  d_valid,  
        	  d_ready,  
        	  d_opcode, 
        	  d_source, 
        	  d_denied, 
        	  d_corrupt,
        	  d_data,   
        	  d_user,   
        	  tluh_0_a_valid,
        	  tluh_0_a_ready,
        	  tluh_0_a_opcode,
        	  tluh_0_a_size,
        	  tluh_0_a_source,
        	  tluh_0_a_address,
        	  tluh_0_a_mask,
        	  tluh_0_a_data,
        	  tluh_0_a_user,
        	  tluh_0_a_corrupt,
        	  tluh_0_a_param,
        	  tluh_0_d_valid,
        	  tluh_0_d_ready,
        	  tluh_0_d_opcode,
        	  tluh_0_d_size,
        	  tluh_0_d_source,
        	  tluh_0_d_denied,
        	  tluh_0_d_corrupt,
        	  tluh_0_d_data,
        	  tluh_0_d_user,
        	  tluh_0_d_param, // UNUSED
        	  tluh_0_d_sink, // UNUSED
        	  tluh_1_a_valid,
        	  tluh_1_a_ready,
        	  tluh_1_a_opcode,
        	  tluh_1_a_size,
        	  tluh_1_a_source,
        	  tluh_1_a_address,
        	  tluh_1_a_mask,
        	  tluh_1_a_data,
        	  tluh_1_a_user,
        	  tluh_1_a_corrupt,
        	  tluh_1_a_param,
        	  tluh_1_d_valid,
        	  tluh_1_d_ready,
        	  tluh_1_d_opcode,
        	  tluh_1_d_size,
        	  tluh_1_d_source,
        	  tluh_1_d_denied,
        	  tluh_1_d_corrupt,
        	  tluh_1_d_data,
        	  tluh_1_d_user,
        	  tluh_1_d_param, // UNUSED
        	  tluh_1_d_sink, // UNUSED
        	  tluh_2_a_valid,
        	  tluh_2_a_ready,
        	  tluh_2_a_opcode,
        	  tluh_2_a_size,
        	  tluh_2_a_source,
        	  tluh_2_a_address,
        	  tluh_2_a_mask,
        	  tluh_2_a_data,
        	  tluh_2_a_user,
        	  tluh_2_a_corrupt,
        	  tluh_2_a_param,
        	  tluh_2_d_valid,
        	  tluh_2_d_ready,
        	  tluh_2_d_opcode,
        	  tluh_2_d_size,
        	  tluh_2_d_source,
        	  tluh_2_d_denied,
        	  tluh_2_d_corrupt,
        	  tluh_2_d_data,
        	  tluh_2_d_user,
        	  tluh_2_d_param, // UNUSED
        	  tluh_2_d_sink, // UNUSED
        	  tluh_3_a_valid,
        	  tluh_3_a_ready,
        	  tluh_3_a_opcode,
        	  tluh_3_a_size,
        	  tluh_3_a_source,
        	  tluh_3_a_address,
        	  tluh_3_a_mask,
        	  tluh_3_a_data,
        	  tluh_3_a_user,
        	  tluh_3_a_corrupt,
        	  tluh_3_a_param,
        	  tluh_3_d_valid,
        	  tluh_3_d_ready,
        	  tluh_3_d_opcode,
        	  tluh_3_d_size,
        	  tluh_3_d_source,
        	  tluh_3_d_denied,
        	  tluh_3_d_corrupt,
        	  tluh_3_d_data,
        	  tluh_3_d_user,
        	  tluh_3_d_param, // UNUSED
        	  tluh_3_d_sink  // UNUSED
        // VPERL_GENERATED_END
);

// Parameter
parameter	ADDR_WIDTH	= 64;
parameter	DATA_WIDTH	= 256;
parameter	TL_SIZE_WIDTH	= 4;
parameter	TL_SINK_WIDTH	= 1;
parameter	TL_SOURCE_WIDTH	= 3;
parameter	TL_A_USER_WIDTH	= 8;
parameter	TL_D_USER_WIDTH	= 8;
parameter 	TL_OUTSTANDING	= 8;
parameter	TL_CHANNEL_NUM	= 4;
parameter	RAR_SUPPORT	= 0;

localparam 	OUT_IDX_WIDTH	=  (TL_OUTSTANDING == 1) ? 1 : $clog2(TL_OUTSTANDING);

input							clk;
input							resetn;
// TL-A
input	[(TL_CHANNEL_NUM-1):0]				a_valid;	
output  [(TL_CHANNEL_NUM-1):0]				a_ready;
input	[((TL_CHANNEL_NUM*3)-1):0]			a_opcode;
input	[((TL_CHANNEL_NUM*3)-1):0]			a_size;
input	[((TL_CHANNEL_NUM*TL_SOURCE_WIDTH)-1):0]	a_source;
input	[((TL_CHANNEL_NUM*ADDR_WIDTH)-1):0]		a_address;
input	[((TL_CHANNEL_NUM*(DATA_WIDTH/8))-1):0]		a_mask;
input	[((TL_CHANNEL_NUM*DATA_WIDTH)-1):0]		a_data;
input	[((TL_CHANNEL_NUM*7)-1):0]			a_user;
input	[(TL_CHANNEL_NUM-1):0]				a_corrupt;	
input	[((TL_CHANNEL_NUM*3)-1):0]			a_param;
//TL-D
output	[(TL_CHANNEL_NUM-1):0]				d_valid;
input	[(TL_CHANNEL_NUM-1):0]				d_ready;
output	[((TL_CHANNEL_NUM*3)-1):0]			d_opcode;
output	[((TL_CHANNEL_NUM*TL_SOURCE_WIDTH)-1):0]	d_source;
output	[(TL_CHANNEL_NUM-1):0]				d_denied;
output	[(TL_CHANNEL_NUM-1):0]				d_corrupt;
output	[((TL_CHANNEL_NUM*DATA_WIDTH)-1):0]		d_data;
output	[((TL_CHANNEL_NUM*2)-1):0]			d_user;
// TL-A
output							tluh_0_a_valid;	
input							tluh_0_a_ready;
output	[2:0]						tluh_0_a_opcode;
output	[(TL_SIZE_WIDTH-1):0]				tluh_0_a_size;
output	[(TL_SOURCE_WIDTH-1):0]				tluh_0_a_source;
output	[(ADDR_WIDTH-1):0]				tluh_0_a_address;
output	[((DATA_WIDTH/8)-1):0]				tluh_0_a_mask;
output	[(DATA_WIDTH-1):0]				tluh_0_a_data;
output	[(TL_A_USER_WIDTH-1):0]				tluh_0_a_user;
output							tluh_0_a_corrupt;	
output	[2:0]						tluh_0_a_param;
//TL-D
input							tluh_0_d_valid;
output							tluh_0_d_ready;
input	[2:0]						tluh_0_d_opcode;
input	[(TL_SIZE_WIDTH-1):0]				tluh_0_d_size;
input	[(TL_SOURCE_WIDTH-1):0]				tluh_0_d_source;
input							tluh_0_d_denied;
input							tluh_0_d_corrupt;
input	[(DATA_WIDTH-1):0]				tluh_0_d_data;
input	[(TL_D_USER_WIDTH-1):0]				tluh_0_d_user;
input	[1:0]						tluh_0_d_param; // UNUSED
input	[(TL_SINK_WIDTH-1):0]				tluh_0_d_sink; // UNUSED
// TL-A
output							tluh_1_a_valid;	
input							tluh_1_a_ready;
output	[2:0]						tluh_1_a_opcode;
output	[(TL_SIZE_WIDTH-1):0]				tluh_1_a_size;
output	[(TL_SOURCE_WIDTH-1):0]				tluh_1_a_source;
output	[(ADDR_WIDTH-1):0]				tluh_1_a_address;
output	[((DATA_WIDTH/8)-1):0]				tluh_1_a_mask;
output	[(DATA_WIDTH-1):0]				tluh_1_a_data;
output	[(TL_A_USER_WIDTH-1):0]				tluh_1_a_user;
output							tluh_1_a_corrupt;	
output	[2:0]						tluh_1_a_param;
//TL-D
input							tluh_1_d_valid;
output							tluh_1_d_ready;
input	[2:0]						tluh_1_d_opcode;
input	[(TL_SIZE_WIDTH-1):0]				tluh_1_d_size;
input	[(TL_SOURCE_WIDTH-1):0]				tluh_1_d_source;
input							tluh_1_d_denied;
input							tluh_1_d_corrupt;
input	[(DATA_WIDTH-1):0]				tluh_1_d_data;
input	[(TL_D_USER_WIDTH-1):0]				tluh_1_d_user;
input	[1:0]						tluh_1_d_param; // UNUSED
input	[(TL_SINK_WIDTH-1):0]				tluh_1_d_sink; // UNUSED
// TL-A
output							tluh_2_a_valid;	
input							tluh_2_a_ready;
output	[2:0]						tluh_2_a_opcode;
output	[(TL_SIZE_WIDTH-1):0]				tluh_2_a_size;
output	[(TL_SOURCE_WIDTH-1):0]				tluh_2_a_source;
output	[(ADDR_WIDTH-1):0]				tluh_2_a_address;
output	[((DATA_WIDTH/8)-1):0]				tluh_2_a_mask;
output	[(DATA_WIDTH-1):0]				tluh_2_a_data;
output	[(TL_A_USER_WIDTH-1):0]				tluh_2_a_user;
output							tluh_2_a_corrupt;	
output	[2:0]						tluh_2_a_param;
//TL-D
input							tluh_2_d_valid;
output							tluh_2_d_ready;
input	[2:0]						tluh_2_d_opcode;
input	[(TL_SIZE_WIDTH-1):0]				tluh_2_d_size;
input	[(TL_SOURCE_WIDTH-1):0]				tluh_2_d_source;
input							tluh_2_d_denied;
input							tluh_2_d_corrupt;
input	[(DATA_WIDTH-1):0]				tluh_2_d_data;
input	[(TL_D_USER_WIDTH-1):0]				tluh_2_d_user;
input	[1:0]						tluh_2_d_param; // UNUSED
input	[(TL_SINK_WIDTH-1):0]				tluh_2_d_sink; // UNUSED
// TL-A
output							tluh_3_a_valid;	
input							tluh_3_a_ready;
output	[2:0]						tluh_3_a_opcode;
output	[(TL_SIZE_WIDTH-1):0]				tluh_3_a_size;
output	[(TL_SOURCE_WIDTH-1):0]				tluh_3_a_source;
output	[(ADDR_WIDTH-1):0]				tluh_3_a_address;
output	[((DATA_WIDTH/8)-1):0]				tluh_3_a_mask;
output	[(DATA_WIDTH-1):0]				tluh_3_a_data;
output	[(TL_A_USER_WIDTH-1):0]				tluh_3_a_user;
output							tluh_3_a_corrupt;	
output	[2:0]						tluh_3_a_param;
//TL-D
input							tluh_3_d_valid;
output							tluh_3_d_ready;
input	[2:0]						tluh_3_d_opcode;
input	[(TL_SIZE_WIDTH-1):0]				tluh_3_d_size;
input	[(TL_SOURCE_WIDTH-1):0]				tluh_3_d_source;
input							tluh_3_d_denied;
input							tluh_3_d_corrupt;
input	[(DATA_WIDTH-1):0]				tluh_3_d_data;
input	[(TL_D_USER_WIDTH-1):0]				tluh_3_d_user;
input	[1:0]						tluh_3_d_param; // UNUSED
input	[(TL_SINK_WIDTH-1):0]				tluh_3_d_sink; // UNUSED

generate
genvar ch_idx;
	for (ch_idx = 0; ch_idx < 4; ch_idx = ch_idx + 1) begin: gen_ch
		wire							tluh_a_valid;	
		wire  							tluh_a_ready;
		wire	[2:0]						tluh_a_opcode;
		wire	[(TL_SIZE_WIDTH-1):0]				tluh_a_size;
		wire	[(TL_SOURCE_WIDTH-1):0]				tluh_a_source;
		wire	[(ADDR_WIDTH-1):0]				tluh_a_address;
		wire	[((DATA_WIDTH/8)-1):0]				tluh_a_mask;
		wire	[(DATA_WIDTH-1):0]				tluh_a_data;
		wire	[(TL_A_USER_WIDTH-1):0]				tluh_a_user;
		wire							tluh_d_valid;
		wire							tluh_d_ready;
		wire	[2:0]						tluh_d_opcode;
		wire	[(TL_SOURCE_WIDTH-1):0]				tluh_d_source;
		wire							tluh_d_denied;
		wire							tluh_d_corrupt;
		wire	[(DATA_WIDTH-1):0]				tluh_d_data;
		wire	[(TL_D_USER_WIDTH-1):0]				tluh_d_user;


		if (ch_idx < TL_CHANNEL_NUM) begin: gen_ch_exist
			if (OUT_IDX_WIDTH==0) begin: gen_a_source_no_outstanding
				atcaxi2tluh500_elastic_buffer_o #(
					.DW		(3+3+ADDR_WIDTH+(DATA_WIDTH/8)+DATA_WIDTH+7),
					.RAR_SUPPORT	(RAR_SUPPORT)
				) u_tl_a_buffer (
					.clk		(clk),
					.clk_en		(1'b1),
					.resetn		(resetn),
					.i_valid	(a_valid[ch_idx]),
					.i_ready	(a_ready[ch_idx]),
					.din		({ 	a_opcode[ch_idx*3+:3]
							,	a_size[ch_idx*3+:3]
							,	a_address[ch_idx*ADDR_WIDTH+:ADDR_WIDTH]
							,	a_mask[ch_idx*(DATA_WIDTH/8)+:(DATA_WIDTH/8)]
							,	a_data[ch_idx*DATA_WIDTH+:DATA_WIDTH]
							,	a_user[ch_idx*7+:7]
							}),
					.o_valid	(tluh_a_valid),
					.o_ready	(tluh_a_ready),
					.dout		({ 	tluh_a_opcode
							,	tluh_a_size[2:0]
							,	tluh_a_address
							,	tluh_a_mask
							,	tluh_a_data
							,	tluh_a_user[6:0]
							})
				);
			end
			else begin: gen_a_source_outstanding
				atcaxi2tluh500_elastic_buffer_o #(
					.DW		(3+3+OUT_IDX_WIDTH+ADDR_WIDTH+(DATA_WIDTH/8)+DATA_WIDTH+7),
					.RAR_SUPPORT	(RAR_SUPPORT)
				) u_tl_a_buffer (
					.clk		(clk),
					.clk_en		(1'b1),
					.resetn		(resetn),
					.i_valid	(a_valid[ch_idx]),
					.i_ready	(a_ready[ch_idx]),
					.din		({ 	a_opcode[ch_idx*3+:3]
							,	a_size[ch_idx*3+:3]
							,	a_source[ch_idx*TL_SOURCE_WIDTH+:OUT_IDX_WIDTH]
							,	a_address[ch_idx*ADDR_WIDTH+:ADDR_WIDTH]
							,	a_mask[ch_idx*(DATA_WIDTH/8)+:(DATA_WIDTH/8)]
							,	a_data[ch_idx*DATA_WIDTH+:DATA_WIDTH]
							,	a_user[ch_idx*7+:7]
							}),
					.o_valid	(tluh_a_valid),
					.o_ready	(tluh_a_ready),
					.dout		({ 	tluh_a_opcode
							,	tluh_a_size[2:0]
							,	tluh_a_source[(OUT_IDX_WIDTH-1): 0]
							,	tluh_a_address
							,	tluh_a_mask
							,	tluh_a_data
							,	tluh_a_user[6:0]
							})
				);
			end

			if (TL_SOURCE_WIDTH>OUT_IDX_WIDTH) begin: gen_a_source_zext
				assign	tluh_a_source[TL_SOURCE_WIDTH-1:OUT_IDX_WIDTH] = {(TL_SOURCE_WIDTH-OUT_IDX_WIDTH){1'b0}};
			end
			if (TL_SIZE_WIDTH>3) begin: gen_a_size_zext
				assign	tluh_a_size[TL_SIZE_WIDTH-1:3] = {(TL_SIZE_WIDTH-3){1'b0}};
			end
			if (TL_A_USER_WIDTH>7) begin: gen_a_user_zext
				assign	tluh_a_user[TL_A_USER_WIDTH-1:7] = {(TL_A_USER_WIDTH-7){1'b0}};
			end

			if (OUT_IDX_WIDTH==0) begin: gen_d_source_no_outstanding
				atcaxi2tluh500_elastic_buffer_i #(
					.DW		(3+1+1+DATA_WIDTH+2),
					.RAR_SUPPORT	(RAR_SUPPORT)
				) u_tl_d_buffer (
					.clk		(clk),
					.clk_en		(1'b1),
					.resetn		(resetn),
					.i_valid	(tluh_d_valid),
					.i_ready	(tluh_d_ready),
					.din		({ 	tluh_d_opcode
							,	tluh_d_denied
							,	tluh_d_corrupt
							,	tluh_d_data
							,	tluh_d_user[1:0]
							}),
					.o_valid	(d_valid[ch_idx]),
					.o_ready	(d_ready[ch_idx]),
					.dout		({ 	d_opcode[ch_idx*3+:3]
							,	d_denied[ch_idx]
							,	d_corrupt[ch_idx]
							,	d_data[ch_idx*DATA_WIDTH+:DATA_WIDTH]
							,	d_user[ch_idx*2+:2]
							})
				);
			end
			else begin: gen_d_source_outstanding
				atcaxi2tluh500_elastic_buffer_i #(
					.DW		(3+OUT_IDX_WIDTH+1+1+DATA_WIDTH+2),
					.RAR_SUPPORT	(RAR_SUPPORT)
				) u_tl_d_buffer (
					.clk		(clk),
					.clk_en		(1'b1),
					.resetn		(resetn),
					.i_valid	(tluh_d_valid),
					.i_ready	(tluh_d_ready),
					.din		({ 	tluh_d_opcode
							,	tluh_d_source[(OUT_IDX_WIDTH-1): 0]
							,	tluh_d_denied
							,	tluh_d_corrupt
							,	tluh_d_data
							,	tluh_d_user[1:0]
							}),
					.o_valid	(d_valid[ch_idx]),
					.o_ready	(d_ready[ch_idx]),
					.dout		({ 	d_opcode[ch_idx*3+:3]
							,	d_source[ch_idx*TL_SOURCE_WIDTH+:OUT_IDX_WIDTH]
							,	d_denied[ch_idx]
							,	d_corrupt[ch_idx]
							,	d_data[ch_idx*DATA_WIDTH+:DATA_WIDTH]
							,	d_user[ch_idx*2+:2]
							})
				);
			end
			if (TL_SOURCE_WIDTH>OUT_IDX_WIDTH) begin: gen_d_source_zext
				assign	d_source[(ch_idx*TL_SOURCE_WIDTH)+OUT_IDX_WIDTH+:TL_SOURCE_WIDTH-OUT_IDX_WIDTH] = {(TL_SOURCE_WIDTH-OUT_IDX_WIDTH){1'b0}};
			end
		end
		else begin: gen_ch_not_exist
			assign	tluh_a_valid			= 1'b0;	
			assign	tluh_a_opcode			= 3'b0;
			assign	tluh_a_size			= {TL_SIZE_WIDTH{1'b0}};
			assign	tluh_a_source			= {TL_SOURCE_WIDTH{1'b0}};
			assign	tluh_a_address			= {ADDR_WIDTH{1'b0}};
			assign	tluh_a_mask			= {(DATA_WIDTH/8){1'b0}};
			assign	tluh_a_data			= {DATA_WIDTH{1'b0}};
			assign	tluh_a_user			= {TL_A_USER_WIDTH{1'b0}};
			assign	tluh_d_ready			= 1'b1;
			wire				nds_unused_tluh_a_ready		= tluh_a_ready;
			wire				nds_unused_tluh_d_valid		= tluh_d_valid;
			wire	[2:0]			nds_unused_tluh_d_opcode	= tluh_d_opcode;
			wire	[(TL_SOURCE_WIDTH-1):0]	nds_unused_tluh_d_source	= tluh_d_source;
			wire				nds_unused_tluh_d_denied	= tluh_d_denied;
			wire				nds_unused_tluh_d_corrupt	= tluh_d_corrupt;
			wire	[(DATA_WIDTH-1):0]	nds_unused_tluh_d_data		= tluh_d_data;
			wire	[(TL_D_USER_WIDTH-1):0]	nds_unused_tluh_d_user		= tluh_d_user;
		end
		

		// VPERL_BEGIN
		// for ($ch = 0; $ch < 4; $ch++) {
		// :if (ch_idx == $ch) begin: gen_connect_ch_${ch}
		// :	assign	tluh_${ch}_a_valid		= tluh_a_valid;	
		// :	assign	tluh_a_ready		= tluh_${ch}_a_ready;
		// :	assign	tluh_${ch}_a_opcode		= tluh_a_opcode;
		// :	assign	tluh_${ch}_a_size		= tluh_a_size;
		// :	assign	tluh_${ch}_a_source		= tluh_a_source;
		// :	assign	tluh_${ch}_a_address	= tluh_a_address;
		// :	assign	tluh_${ch}_a_mask		= tluh_a_mask;
		// :	assign	tluh_${ch}_a_data		= tluh_a_data;
		// :	assign	tluh_${ch}_a_user		= tluh_a_user;
		// :	assign	tluh_${ch}_a_corrupt	= 1'b0;	
		// :	assign	tluh_${ch}_a_param		= 3'b0;
		// :	assign	tluh_d_valid		= tluh_${ch}_d_valid;
		// :	assign	tluh_${ch}_d_ready		= tluh_d_ready;
		// :	assign	tluh_d_opcode		= tluh_${ch}_d_opcode;
		// :	wire	[(TL_SIZE_WIDTH-1):0]	nds_unused_tluh_d_size  = tluh_${ch}_d_size;
		// :	assign	tluh_d_source		= tluh_${ch}_d_source;
		// :	assign	tluh_d_denied		= tluh_${ch}_d_denied;
		// :	assign	tluh_d_corrupt		= tluh_${ch}_d_corrupt;
		// :	assign	tluh_d_data		= tluh_${ch}_d_data;
		// :	assign	tluh_d_user		= tluh_${ch}_d_user;
		// :	wire	[1:0]			nds_unused_tluh_d_param = tluh_${ch}_d_param;
		// :	wire	[(TL_SINK_WIDTH-1):0]	nds_unused_tluh_d_sink  = tluh_${ch}_d_sink;
		// :end
		// }
		// VPERL_END

		// VPERL_GENERATED_BEGIN
		if (ch_idx == 0) begin: gen_connect_ch_0
			assign	tluh_0_a_valid		= tluh_a_valid;
			assign	tluh_a_ready		= tluh_0_a_ready;
			assign	tluh_0_a_opcode		= tluh_a_opcode;
			assign	tluh_0_a_size		= tluh_a_size;
			assign	tluh_0_a_source		= tluh_a_source;
			assign	tluh_0_a_address	= tluh_a_address;
			assign	tluh_0_a_mask		= tluh_a_mask;
			assign	tluh_0_a_data		= tluh_a_data;
			assign	tluh_0_a_user		= tluh_a_user;
			assign	tluh_0_a_corrupt	= 1'b0;
			assign	tluh_0_a_param		= 3'b0;
			assign	tluh_d_valid		= tluh_0_d_valid;
			assign	tluh_0_d_ready		= tluh_d_ready;
			assign	tluh_d_opcode		= tluh_0_d_opcode;
			wire	[(TL_SIZE_WIDTH-1):0]	nds_unused_tluh_d_size  = tluh_0_d_size;
			assign	tluh_d_source		= tluh_0_d_source;
			assign	tluh_d_denied		= tluh_0_d_denied;
			assign	tluh_d_corrupt		= tluh_0_d_corrupt;
			assign	tluh_d_data		= tluh_0_d_data;
			assign	tluh_d_user		= tluh_0_d_user;
			wire	[1:0]			nds_unused_tluh_d_param = tluh_0_d_param;
			wire	[(TL_SINK_WIDTH-1):0]	nds_unused_tluh_d_sink  = tluh_0_d_sink;
		end
		if (ch_idx == 1) begin: gen_connect_ch_1
			assign	tluh_1_a_valid		= tluh_a_valid;
			assign	tluh_a_ready		= tluh_1_a_ready;
			assign	tluh_1_a_opcode		= tluh_a_opcode;
			assign	tluh_1_a_size		= tluh_a_size;
			assign	tluh_1_a_source		= tluh_a_source;
			assign	tluh_1_a_address	= tluh_a_address;
			assign	tluh_1_a_mask		= tluh_a_mask;
			assign	tluh_1_a_data		= tluh_a_data;
			assign	tluh_1_a_user		= tluh_a_user;
			assign	tluh_1_a_corrupt	= 1'b0;
			assign	tluh_1_a_param		= 3'b0;
			assign	tluh_d_valid		= tluh_1_d_valid;
			assign	tluh_1_d_ready		= tluh_d_ready;
			assign	tluh_d_opcode		= tluh_1_d_opcode;
			wire	[(TL_SIZE_WIDTH-1):0]	nds_unused_tluh_d_size  = tluh_1_d_size;
			assign	tluh_d_source		= tluh_1_d_source;
			assign	tluh_d_denied		= tluh_1_d_denied;
			assign	tluh_d_corrupt		= tluh_1_d_corrupt;
			assign	tluh_d_data		= tluh_1_d_data;
			assign	tluh_d_user		= tluh_1_d_user;
			wire	[1:0]			nds_unused_tluh_d_param = tluh_1_d_param;
			wire	[(TL_SINK_WIDTH-1):0]	nds_unused_tluh_d_sink  = tluh_1_d_sink;
		end
		if (ch_idx == 2) begin: gen_connect_ch_2
			assign	tluh_2_a_valid		= tluh_a_valid;
			assign	tluh_a_ready		= tluh_2_a_ready;
			assign	tluh_2_a_opcode		= tluh_a_opcode;
			assign	tluh_2_a_size		= tluh_a_size;
			assign	tluh_2_a_source		= tluh_a_source;
			assign	tluh_2_a_address	= tluh_a_address;
			assign	tluh_2_a_mask		= tluh_a_mask;
			assign	tluh_2_a_data		= tluh_a_data;
			assign	tluh_2_a_user		= tluh_a_user;
			assign	tluh_2_a_corrupt	= 1'b0;
			assign	tluh_2_a_param		= 3'b0;
			assign	tluh_d_valid		= tluh_2_d_valid;
			assign	tluh_2_d_ready		= tluh_d_ready;
			assign	tluh_d_opcode		= tluh_2_d_opcode;
			wire	[(TL_SIZE_WIDTH-1):0]	nds_unused_tluh_d_size  = tluh_2_d_size;
			assign	tluh_d_source		= tluh_2_d_source;
			assign	tluh_d_denied		= tluh_2_d_denied;
			assign	tluh_d_corrupt		= tluh_2_d_corrupt;
			assign	tluh_d_data		= tluh_2_d_data;
			assign	tluh_d_user		= tluh_2_d_user;
			wire	[1:0]			nds_unused_tluh_d_param = tluh_2_d_param;
			wire	[(TL_SINK_WIDTH-1):0]	nds_unused_tluh_d_sink  = tluh_2_d_sink;
		end
		if (ch_idx == 3) begin: gen_connect_ch_3
			assign	tluh_3_a_valid		= tluh_a_valid;
			assign	tluh_a_ready		= tluh_3_a_ready;
			assign	tluh_3_a_opcode		= tluh_a_opcode;
			assign	tluh_3_a_size		= tluh_a_size;
			assign	tluh_3_a_source		= tluh_a_source;
			assign	tluh_3_a_address	= tluh_a_address;
			assign	tluh_3_a_mask		= tluh_a_mask;
			assign	tluh_3_a_data		= tluh_a_data;
			assign	tluh_3_a_user		= tluh_a_user;
			assign	tluh_3_a_corrupt	= 1'b0;
			assign	tluh_3_a_param		= 3'b0;
			assign	tluh_d_valid		= tluh_3_d_valid;
			assign	tluh_3_d_ready		= tluh_d_ready;
			assign	tluh_d_opcode		= tluh_3_d_opcode;
			wire	[(TL_SIZE_WIDTH-1):0]	nds_unused_tluh_d_size  = tluh_3_d_size;
			assign	tluh_d_source		= tluh_3_d_source;
			assign	tluh_d_denied		= tluh_3_d_denied;
			assign	tluh_d_corrupt		= tluh_3_d_corrupt;
			assign	tluh_d_data		= tluh_3_d_data;
			assign	tluh_d_user		= tluh_3_d_user;
			wire	[1:0]			nds_unused_tluh_d_param = tluh_3_d_param;
			wire	[(TL_SINK_WIDTH-1):0]	nds_unused_tluh_d_sink  = tluh_3_d_sink;
		end
		// VPERL_GENERATED_END
	end

	
endgenerate

endmodule
