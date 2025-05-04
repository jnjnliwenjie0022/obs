module vc_mshr(
	// VPERL: &PORTLIST;
	// VPERL_GENERATED_BEGIN
		  clk,      
		  reset_n,  
		  mshr_self_reset,
		  mshr_idle,
		  mshr_vec_fastpath_inprogress,
		  cur_privileged,
		  lsu_kill, 
		  mshr_alloc_req,
		  mshr_alloc_en,
		  mshr_alloc_ready,
		  mshr_alloc_addr,
		  mshr_alloc_ctw,
		  mshr_alloc_cacheability,
		  mshr_alloc_device,
		  mshr_alloc_uncache,
		  mshr_alloc_cache_fill,
		  mshr_alloc_cctl_fill,
		  mshr_alloc_cache_fill_way,
		  mshr_alloc_size,
		  mshr_alloc_type,
		  mshr_alloc_privileged,
		  mshr_alloc_lock,
		  mshr_alloc_length,
		  mshr_alloc_vector_fastpath,
		  mshr_alloc_sub_block,
		  mshr_alloc_sub_block_main_entry_id,
		  mshr_alloc_dest_vrf,
		  mshr_alloc_dest_frf,
		  mshr_alloc_dest_xrf,
		  mshr_alloc_dest_sb,
		  mshr_alloc_dest_index,
		  mshr_alloc_func,
		  mshr_alloc_evict,
		  mshr_alloc_evict_tag,
		  mshr_alloc_atomic_store,
		  mshr_alloc_pure_evict,
		  mshr_alloc_cctl_lock,
		  mshr_alloc_blocking,
		  mshr_alloc_replace,
		  mshr_alloc_vec_access,
		  mshr_alloc_vec_fp_confirmed,
		  mshr_alloc_entry_ptr,
		  mshr_alloc_fb_valid,
		  mshr_alloc_sub_block_valid,
		  mshr_alloc_uncache_vector_unalign_first,
		  mshr_alloc_uncache_vector_unalign_second,
		  mshr_resp_valid,
		  mshr_resp_ready,
		  mshr_resp_rdata,
		  mshr_resp_rf_index,
		  mshr_resp_size,
		  mshr_resp_func,
		  mshr_resp_offset, // FIXME, extend to 6 when BIU=512 is supported
		  mshr_resp_error,
		  mshr_resp_to_vrf,
		  mshr_resp_to_frf,
		  mshr_resp_to_xrf,
		  mshr_resp_to_sb,
		  mshr_resp_vector_fastpath,
		  mshr_resp_blocking,
		  mshr_resp_blocking_been_kill,
		  mshr_resp_fill_entry_id,
		  mshr_resp_fill_done,
		  mshr_resp_fill_way,
		  mshr_resp_lock_fail,
		  mshr_fill_tag_req,
		  mshr_fill_tag_req_grant,
		  mshr_fill_tag_req_addr,
		  mshr_fill_tag_req_cmd,
		  mshr_fill_tag_req_wdata,
		  mshr_fill_tag_req_way,
		  mshr_fill_data_req,
		  mshr_fill_data_req_grant,
		  mshr_fill_data_req_wdata,
		  mshr_fill_data_req_way,
		  mshr_fill_data_req_index,
		  mshr_fill_data_req_offset,
		  mshr_load_req,
		  mshr_load_req_addr,
		  mshr_load_req_length,
		  mshr_load_req_size,
		  mshr_load_req_cacheability,
		  mshr_load_req_privileged,
		  mshr_load_req_lock_clear,
		  mshr_load_req_lock,
		  mshr_load_req_write,
		  mshr_load_req_type,
		  mshr_load_req_id,
		  mshr_load_req_kill, // no need for MSHR arch
		  mshr_load_req_grant, // biu_lsu_load_grant
		  mshr_load_resp_rdata,
		  mshr_load_resp_read_error,
		  mshr_load_resp_read_ack,
		  mshr_load_resp_read_grant, // biu_load_rdata_wait
		  mshr_load_resp_rsnoop,
		  mshr_load_resp_last,
		  mshr_load_resp_id,
		  mshr_load_resp_lock_fail,
		  mshr_store_req,
		  mshr_store_req_grant,
		  mshr_store_req_addr,
		  mshr_store_req_last,
		  mshr_store_req_length,
		  mshr_store_req_size,
		  mshr_store_req_type,
		  mshr_store_req_bwe,
		  mshr_store_req_wdata,
		  mshr_store_req_data_valid,
		  mshr_store_req_cacheability,
		  mshr_store_req_privileged,
		  mshr_store_req_lock,
		  mshr_store_req_precise,
		  mshr_store_req_id,
		  mshr_store_req_data_ack, // biu_lsu_store_accept_write_ack
		  mshr_evict_req,
		  mshr_evict_req_grant,
		  mshr_evict_req_way,
		  mshr_evict_req_index,
		  mshr_evict_req_offset,
		  mshr_evict_resp_valid,
		  mshr_evict_resp_data,
		  mshr_fill_done,
		  mshr_fill_abort,
		  mshr_fill_done_id,
		  mshr_evict_done,
		  mshr_entry_busy,
		  dcu_dphase_addr,
		  dcu_dphase_hit_mshr,
		  dcu_dphase_hit_mshr_ex,
		  dcu_dphase_hit_mshr_way,
		  dcu_dphase_hit_mshr_entry_id,
		  dcu_dphase_hit_mshr_fill_done,
		  dcu_dphase_hit_data_ready_mshr,
		  dcu_dphase_hit_data_ready_mshr_rdata,
		  dcu_dphase_hit_eviction,
		  dcu_dphase_hit_replacement,
		  dcu_dphase_hit_lock,
		  dcu_dphase_hit_same_index,
		  dcu_dphase_hit_same_index_way,
		  dcu_dphase_hit_same_index_way_lock,
		  dcu_mm_pa,
		  dcu_mm_hit_load_cacheline,
		  dcu_mm_hit_load_512b,
		  dcu_rphase_lookup_mshr,
		  dcu_rphase_lookup_mshr_id,
		  dcu_rphase_lookup_hit_mshr,
		  dcu_rphase_lookup_fill_done,
		  mshr_vector_fastpath_confirm,
		  mshr_vector_fastpath_confirm_mshr_entry_id 
	// VPERL_GENERATED_END
);

parameter MSHR_DEPTH		= 8; // MAX DEPTH depend on the BIU_ID_WIDTH, power of 2 
parameter MSHR_SUB_BLOCK_DEPTH	= 4; // 2~4
parameter MSHR_FB_DEPTH		= 4;

parameter BIU_ADDR_WIDTH 	= 32; 
parameter BIU_DATA_WIDTH 	= 64;
parameter BIU_LENGTH_WIDTH 	= 3;
parameter BIU_ID_WIDTH 	   	= 4;
parameter BIU_SIZE		= 3'd3;
parameter BURST_LENGTH		= {BIU_LENGTH_WIDTH{1'b0}};

parameter DCACHE_SIZE_KB 	= 0;
parameter DCACHE_TAG_RAM_AW	= 10;
parameter DCACHE_TAG_DW		= 10;
parameter CACHE_LINE_SIZE 	= 32;
parameter TAG_DW		= 20;
parameter TAG_MSB		= 15;
parameter TAG_LSB		= 10;

parameter OFFSET_WIDTH		= 2;
parameter OFFSET_MSB		= 4;
parameter OFFSET_LSB		= 2;

parameter LS_DEST_BITS          = 6;

parameter INDEX_MSB		= 10;
parameter INDEX_LSB		= 6;
parameter CACHE_LINE_BEATS     	= 4;
parameter MSHR_CTW_WIDTH	= 2;

parameter MEM_WIDTH = 32;

parameter MSHR_EVICT_MODE	= "fast";
parameter RVV_SUPPORT		= "no";
localparam			  MSHR_SUB_BLOCK_ALLOC_PTR_WIDTH= $clog2(MSHR_SUB_BLOCK_DEPTH);
localparam			  CACHE_LINE_DATA_WIDTH		= CACHE_LINE_SIZE*8;
localparam 			  CACHE_LINE_BURST_LENGTH 	= CACHE_LINE_BEATS-1;
localparam			  MSHR_DRDY_WIDTH		= CACHE_LINE_BEATS;

localparam 			  EB_CNT_LAST			= CACHE_LINE_BEATS-1;
localparam 	  		  OFFSET_CNT_LAST		= CACHE_LINE_BEATS-1;
localparam 			  EB_FIFO_IDX_WIDTH		= (BIU_DATA_WIDTH == 256) ? 2 : $clog2(CACHE_LINE_BEATS) + 1;
localparam 			  MSHR_FILL_TAG_WDATA_WIDTH	= 2 + 1 + TAG_DW;   // state:2, lock:1, TAG
//Memory attribute
localparam [3:0] WRITEBACK_RW_ALLOC	=  4'hf;

localparam READ_NO_SNOOP	= 3'b000;
localparam READ_ONCE		= 3'b001;
localparam READ_SHARED		= 3'b010;
localparam READ_EXCLUSIVE	= 3'b011;
localparam WRITE_NO_SNOOP	= 3'b000;
localparam WRITE_SNOOP		= 3'b011;
localparam WRITE_MERGE		= 3'b100;
localparam L2_READ_MERGE	= 3'b100;

localparam UC_NON_FASTPASS_REQ_ID = 5'b00111;
localparam ATOMIC_REQ_ID	  = 5'b00000;

localparam EVICT_ID		= {{BIU_ID_WIDTH-2{1'b0}}, 2'b11};

localparam ALLOC_FIFO_RESET	= 1'b0;
localparam ALLOC_FIFO_RESET_DONE= 1'b1;
localparam ALLOC_FIFO_DATA_WIDTH  = 4;
//localparam ALLOC_FIFO_INDEX_WIDTH = $clog2(MSHR_DEPTH);
localparam ALLOC_FIFO_INDEX_WIDTH = (MSHR_DEPTH < 4) ? 2 : $clog2(MSHR_DEPTH)+1;
localparam ALLOC_FIFO_LAST = MSHR_DEPTH-1;

localparam ISSUE_FIFO_INDEX_WIDTH = (MSHR_DEPTH < 4) ? 2 : $clog2(MSHR_DEPTH)+1;

localparam ALLOC_FB_FIFO_INDEX_WIDTH = (MSHR_FB_DEPTH < 4) ? 2 : $clog2(MSHR_FB_DEPTH)+1;
localparam ALLOC_FB_FIFO_LAST = MSHR_FB_DEPTH-1;

localparam MSHR_INVALID_STATE	= 2'b00;
localparam MSHR_PENDING_STATE	= 2'b01;
localparam MSHR_ISSUE_STATE	= 2'b10;
localparam MSHR_FILL_STATE	= 2'b11;

localparam DRDY_PTR_DEC_MSB	= ((BIU_DATA_WIDTH == 32) & (CACHE_LINE_SIZE == 32)) ? 7 :
				  ((BIU_DATA_WIDTH == 32) & (CACHE_LINE_SIZE == 16)) ? 11:
				  ((BIU_DATA_WIDTH == 64) & (CACHE_LINE_SIZE == 32)) ? 15:
				  ((BIU_DATA_WIDTH == 64) & (CACHE_LINE_SIZE == 64)) ? 23:
				  ((BIU_DATA_WIDTH ==128) & (CACHE_LINE_SIZE == 64)) ? 27: 
				  ((BIU_DATA_WIDTH ==256) & (CACHE_LINE_SIZE == 64)) ? 29: 30;
localparam DRDY_PTR_DEC_LSB	= ((BIU_DATA_WIDTH == 32) & (CACHE_LINE_SIZE == 32)) ? 0 :
				  ((BIU_DATA_WIDTH == 32) & (CACHE_LINE_SIZE == 16)) ? 8 :
				  ((BIU_DATA_WIDTH == 64) & (CACHE_LINE_SIZE == 32)) ? 12:
				  ((BIU_DATA_WIDTH == 64) & (CACHE_LINE_SIZE == 64)) ? 16:
				  ((BIU_DATA_WIDTH ==128) & (CACHE_LINE_SIZE == 64)) ? 24: 
				  ((BIU_DATA_WIDTH ==256) & (CACHE_LINE_SIZE == 64)) ? 28: 30;

localparam DQ_DEPTH		= 4;
localparam DQ_DATA_WIDTH		= BIU_DATA_WIDTH + 5 + 4 + 1 + 1 + 1; // Req ID + Entry ID + error + lock_fail + last
localparam DQ_FIFO_LAST_BIT		= 0;
localparam DQ_FIFO_LOCK_FAIL_BIT	= DQ_FIFO_LAST_BIT+1;
localparam DQ_FIFO_ERROR_BIT		= DQ_FIFO_LOCK_FAIL_BIT+1;
localparam DQ_FIFO_ID_LSB_BIT		= DQ_FIFO_ERROR_BIT+1;
localparam DQ_FIFO_ID_MSB_BIT		= DQ_FIFO_ID_LSB_BIT+4;
localparam DQ_FIFO_ENTRY_ID_LSB_BIT	= DQ_FIFO_ID_MSB_BIT+1;
localparam DQ_FIFO_ENTRY_ID_MSB_BIT	= DQ_FIFO_ENTRY_ID_LSB_BIT+3;
localparam DQ_FIFO_BIU_DATA_LSB_BIT 	= DQ_FIFO_ENTRY_ID_MSB_BIT+1;
localparam DQ_FIFO_BIU_DATA_MSB_BIT 	= DQ_FIFO_BIU_DATA_LSB_BIT+BIU_DATA_WIDTH-1;
localparam DQ_INDEX_WIDTH	= $clog2(DQ_DEPTH)+1; 

//MESI 
localparam INVALID		= 2'b00;
localparam SHARE		= 2'b01;
localparam EXCLUSIVE		= 2'b10;
localparam MODIFIED		= 2'b11;

localparam CACHE_LINE_INDEX_LSB = $clog2(CACHE_LINE_SIZE);

input 					clk;
input 					reset_n;
output 					mshr_self_reset;
output					mshr_idle;
output					mshr_vec_fastpath_inprogress;

input 					cur_privileged;
input					lsu_kill;

// MSHR allocate
input					mshr_alloc_req;
input					mshr_alloc_en;
output					mshr_alloc_ready;
input	[BIU_ADDR_WIDTH-1:0]		mshr_alloc_addr;
input	[MSHR_CTW_WIDTH-1:0]		mshr_alloc_ctw;
input	[3:0]				mshr_alloc_cacheability;
input					mshr_alloc_device;
input					mshr_alloc_uncache;
input					mshr_alloc_cache_fill;
input					mshr_alloc_cctl_fill;
input	[3:0]				mshr_alloc_cache_fill_way;
input	[2:0]				mshr_alloc_size;
input	[2:0]				mshr_alloc_type;
input					mshr_alloc_privileged;
input					mshr_alloc_lock;
input	[3:0]				mshr_alloc_length;
input					mshr_alloc_vector_fastpath;
input					mshr_alloc_sub_block;
input	[3:0]				mshr_alloc_sub_block_main_entry_id;
input					mshr_alloc_dest_vrf;
input					mshr_alloc_dest_frf;
input					mshr_alloc_dest_xrf;
input					mshr_alloc_dest_sb;
input	[LS_DEST_BITS-1:0]		mshr_alloc_dest_index;
input	[2:0]				mshr_alloc_func;
input					mshr_alloc_evict;
input   [TAG_DW-1:0]			mshr_alloc_evict_tag;
input					mshr_alloc_atomic_store;
input					mshr_alloc_pure_evict;
input					mshr_alloc_cctl_lock;
input					mshr_alloc_blocking;
input					mshr_alloc_replace;
input					mshr_alloc_vec_access;
input					mshr_alloc_vec_fp_confirmed;


output  [3:0]				mshr_alloc_entry_ptr;
output				 	mshr_alloc_fb_valid;
output					mshr_alloc_sub_block_valid;
input					mshr_alloc_uncache_vector_unalign_first;
input					mshr_alloc_uncache_vector_unalign_second;
// MSHR response data
output 					mshr_resp_valid;
input 					mshr_resp_ready;
output	[BIU_DATA_WIDTH-1:0]		mshr_resp_rdata;
output	[LS_DEST_BITS-1:0]		mshr_resp_rf_index;
output  [2:0]				mshr_resp_size;
output  [2:0]				mshr_resp_func;
output  [5:0]				mshr_resp_offset; //FIXME, extend to 6 when BIU=512 is supported
output					mshr_resp_error;
output					mshr_resp_to_vrf;
output					mshr_resp_to_frf;
output					mshr_resp_to_xrf;
output					mshr_resp_to_sb;
output					mshr_resp_vector_fastpath;
output					mshr_resp_blocking;
output					mshr_resp_blocking_been_kill;
output	[3:0]				mshr_resp_fill_entry_id;
output  				mshr_resp_fill_done;
output  [3:0]				mshr_resp_fill_way;
output					mshr_resp_lock_fail;
// MSHR Fill DCACHE 
// TAG
output					mshr_fill_tag_req;
input					mshr_fill_tag_req_grant;
output	[DCACHE_TAG_RAM_AW-1:0]		mshr_fill_tag_req_addr;
output  [1:0]				mshr_fill_tag_req_cmd;
output  [DCACHE_TAG_DW-1:0]		mshr_fill_tag_req_wdata;
output	[3:0]				mshr_fill_tag_req_way;
// DATA
output					mshr_fill_data_req;
input					mshr_fill_data_req_grant;
output	[BIU_DATA_WIDTH-1:0]		mshr_fill_data_req_wdata;
output	[3:0]				mshr_fill_data_req_way;
output	[INDEX_MSB:INDEX_LSB]		mshr_fill_data_req_index;
output	[OFFSET_WIDTH-1:0]		mshr_fill_data_req_offset;

// MSHR Load req
// Req
output					mshr_load_req;
output	[BIU_ADDR_WIDTH-1:0] 		mshr_load_req_addr;
output	[(BIU_LENGTH_WIDTH-1):0]	mshr_load_req_length;
output	[2:0] 				mshr_load_req_size;
output	[3:0]				mshr_load_req_cacheability;
output					mshr_load_req_privileged;
output					mshr_load_req_lock_clear;
output					mshr_load_req_lock;        
output					mshr_load_req_write;        
output	[2:0]				mshr_load_req_type;        
output	[(BIU_ID_WIDTH-1):0]		mshr_load_req_id;
output					mshr_load_req_kill; // no need for MSHR arch
input					mshr_load_req_grant;  // biu_lsu_load_grant
// Resp
input	[BIU_DATA_WIDTH-1:0] 		mshr_load_resp_rdata;
input					mshr_load_resp_read_error;
input					mshr_load_resp_read_ack;
output					mshr_load_resp_read_grant; // biu_load_rdata_wait
input	[1:0]				mshr_load_resp_rsnoop; 
input					mshr_load_resp_last;
input	[(BIU_ID_WIDTH-1):0]		mshr_load_resp_id;
input					mshr_load_resp_lock_fail;


// MSHR Store req (Cache Line Eviction)
output             			mshr_store_req;
input					mshr_store_req_grant;  
output	[BIU_ADDR_WIDTH-1:0] 		mshr_store_req_addr;
output	             			mshr_store_req_last;       
output	[(BIU_LENGTH_WIDTH-1):0]	mshr_store_req_length;  
output	[2:0] 				mshr_store_req_size;  
output	[2:0] 				mshr_store_req_type;  
output	[(BIU_DATA_WIDTH/8)-1:0] 	mshr_store_req_bwe;    
output	[BIU_DATA_WIDTH-1:0] 		mshr_store_req_wdata; 
output	 				mshr_store_req_data_valid; 
output	[3:0] 				mshr_store_req_cacheability; 
output      				mshr_store_req_privileged;
output      		       		mshr_store_req_lock;
output      		       		mshr_store_req_precise;
output	[(BIU_ID_WIDTH-1):0]		mshr_store_req_id;         
input					mshr_store_req_data_ack; // biu_lsu_store_accept_write_ack
// MSHR eviction fetch data RAM 
output					mshr_evict_req;
input					mshr_evict_req_grant;
output	[3:0]				mshr_evict_req_way;
output	[INDEX_MSB:INDEX_LSB]		mshr_evict_req_index;
output	[OFFSET_WIDTH-1:0]		mshr_evict_req_offset;
input					mshr_evict_resp_valid;
input	[BIU_DATA_WIDTH-1:0]		mshr_evict_resp_data;
			
// MISC
output					mshr_fill_done;
output					mshr_fill_abort;
output	[3:0]				mshr_fill_done_id;
output					mshr_evict_done;
output	[15:0]				mshr_entry_busy;
// MM (Data phase) dcu lookup mshr
input	[BIU_ADDR_WIDTH-1:0]			dcu_dphase_addr;
output						dcu_dphase_hit_mshr;
output						dcu_dphase_hit_mshr_ex;
output	[3:0]					dcu_dphase_hit_mshr_way;
output	[3:0]					dcu_dphase_hit_mshr_entry_id;
output						dcu_dphase_hit_mshr_fill_done;
output						dcu_dphase_hit_data_ready_mshr;
output	[MEM_WIDTH-1:0]				dcu_dphase_hit_data_ready_mshr_rdata;
output						dcu_dphase_hit_eviction;
output						dcu_dphase_hit_replacement;
output						dcu_dphase_hit_lock;
output						dcu_dphase_hit_same_index;
output	[3:0]					dcu_dphase_hit_same_index_way;
output  [3:0]					dcu_dphase_hit_same_index_way_lock;
input	[BIU_ADDR_WIDTH-1:0]			dcu_mm_pa;
output						dcu_mm_hit_load_cacheline;
output						dcu_mm_hit_load_512b;

// Resp phase dcu lookup mshr entry
input						dcu_rphase_lookup_mshr;
input   [3:0]					dcu_rphase_lookup_mshr_id;
output						dcu_rphase_lookup_hit_mshr;
output						dcu_rphase_lookup_fill_done;

//Vector Fastpath Confirm
input						mshr_vector_fastpath_confirm;
input	[3:0]					mshr_vector_fastpath_confirm_mshr_entry_id;


//====================================================
//			Declare
//====================================================

//Allocate FIFO
wire 					alloc_fifo_push;
wire [ALLOC_FIFO_DATA_WIDTH-1:0]	alloc_fifo_wdata;
wire 					alloc_fifo_pop;
wire [ALLOC_FIFO_DATA_WIDTH-1:0] 	alloc_fifo_rdata;
wire					alloc_fifo_empty;
wire					alloc_fifo_w_clk_empty;
wire					alloc_fifo_full;
//Allocate FIFO FSM
reg  [ALLOC_FIFO_DATA_WIDTH-1:0]	alloc_fifo_init_cnt;
wire					alloc_fifo_init_last;
wire					alloc_fifo_initing;
wire [ALLOC_FIFO_DATA_WIDTH-1:0]	alloc_fifo_init_cnt_incr;
reg					alloc_fifo_init_done;
wire					alloc_fifo_init_done_set;

wire 				 	alloc_fb_fifo_push;
wire [ALLOC_FIFO_DATA_WIDTH-1:0] 	alloc_fb_fifo_wdata;
wire 				 	alloc_fb_fifo_pop;
wire [ALLOC_FIFO_DATA_WIDTH-1:0] 	alloc_fb_fifo_rdata;
wire				 	alloc_fb_fifo_empty;
wire				 	alloc_fb_fifo_w_clk_empty;
wire					alloc_fb_fifo_full;

wire [3:0]			 	mshr_fb_entry_id[0:15];
//Issue FIFO
wire					issue_fifo_push;
wire [3:0]				issue_fifo_wdata;
wire					issue_fifo_pop;
wire [3:0]				issue_fifo_rdata;
wire	    				issue_fifo_empty;
wire	    				issue_fifo_w_clk_empty;
wire	    				issue_fifo_full;

reg  [3:0] 				reg_issue_ptr;
wire [3:0] 				reg_issue_ptr_nx;
wire        				reg_issue_ptr_en;

reg	    				issue_ptr_valid;
wire	    				issue_ptr_valid_set;
wire	    				issue_ptr_valid_clr;
wire	    				issue_ptr_valid_nx;

// MSHR Alloc
wire					mshr_alloc = (mshr_alloc_req & (mshr_alloc_en | mshr_alloc_pure_evict)) | mshr_alloc_cctl_fill;
wire [3:0]				mshr_alloc_ptr;
wire 					mshr_entry_alloc[0:(MSHR_DEPTH-1)];
wire 					mshr_sub_block_alloc[0:(MSHR_DEPTH-1)];
wire					mshr_alloc_dep;
wire [3:0]				mshr_alloc_dep_id;
wire					mshr_alloc_assign_id;
wire [4:0]				mshr_alloc_assigned_id;
wire					mshr_alloc_dep_id_last_rdata;
reg					mshr_alloc_vector_slowpath_inprogress;
wire					mshr_alloc_vector_slowpath_inprogress_nx;
wire					mshr_alloc_vector_slowpath_inprogress_set;
wire					mshr_alloc_vector_slowpath_inprogress_clr;

wire [MSHR_DEPTH-1:0] 			alloc_fifo_rdata_hit_mshr_entry;
wire 					alloc_req_id_occupied;

wire   					mshr_alloc_vector_slowpath;
wire   					mshr_alloc_vector_fastpath_cross_512b;

wire [3:0] 				latest_vector_fastpath_entry_id;
wire [3:0] 				latest_vector_slowpath_entry_id;
// MSHR Retire
wire [15:0]				mshr_entry_retire;
wire [15:0]				mshr_entry_retire_grant;
wire [15:0]				mshr_entry_retire_arb_in;
wire 					mshr_entry_retired;
reg [3:0]				mshr_entry_retire_id;

// MSHR Issue 
wire					mshr_done_issue;//
wire [3:0]				mshr_issue_ptr;
//MSHR Entries Info
reg  [1:0]				state_cs[0:(MSHR_DEPTH-1)];
reg  [1:0]				state_ns[0:(MSHR_DEPTH-1)];
wire [1:0]				mshr_state[0:(MSHR_DEPTH-1)];
wire [1:0]				mshr_state_ext[0:15];
wire [BIU_ADDR_WIDTH-1:0]		mshr_addr[0:15];
wire [MSHR_CTW_WIDTH-1:0]		mshr_ctw[0:15];
wire [MSHR_DRDY_WIDTH-1:0]		mshr_drdy[0:15];
wire [3:0]				mshr_mem_attri[0:15];
wire 					mshr_error[0:(MSHR_DEPTH-1)];
wire 					mshr_cache_fill[0:15];
wire [3:0]				mshr_way[0:15];
wire [2:0]				mshr_size[0:15];
wire 					mshr_privileged[0:15];
wire [3:0]				mshr_length[0:15];
wire 					mshr_lock[0:15];
wire [2:0]				mshr_type[0:15];
wire					mshr_vector_fastpath[0:15];
wire [15:0]				mshr_latch_data_en;
wire [4:0]				mshr_req_id[0:15];
wire [3:0]				mshr_entry_id[0:(MSHR_DEPTH-1)];
wire					mshr_atomic_store[0:15];
wire					mshr_blocking[0:15];
wire					mshr_blocking_been_kill[0:15];
wire [(MSHR_DEPTH-1):0]			mshr_device;
wire [(MSHR_DEPTH-1):0]			mshr_entry_fastpath_inprogress;

wire [15:0]				mshr_rdata_last;
wire [15:0]				mshr_rdata_done;

wire [(MSHR_DEPTH-1):0]			mshr_entry_issue_done;
wire [15:0]				mshr_entry_issue_done_ext;

wire [15:0]				mshr_entry_cache_fill_done;

wire [(MSHR_DEPTH-1):0]			mshr_entry_fill_done;
wire [15:0]				mshr_entry_fill_abort;
wire [MSHR_DEPTH-1:0]			mshr_fill_done_grant;

wire [15:0]				mshr_fill_done_arb_in;
reg  [3:0]				mshr_fill_done_arb_id;

wire [LS_DEST_BITS-1:0]			mshr_sub_block_dest_idx[0:15];
wire					mshr_sub_block_dest_to_vrf[0:15];
wire					mshr_sub_block_dest_to_frf[0:15];
wire					mshr_sub_block_dest_to_xrf[0:15];
wire					mshr_sub_block_dest_to_sb[0:15];
wire [BIU_DATA_WIDTH-1:0]		mshr_sub_block_rdata[0:15];	     
wire [5:0]				mshr_sub_block_offset[0:15];
wire [2:0]				mshr_sub_block_size[0:15];
wire [2:0]				mshr_sub_block_func[0:15];
wire					mshr_sub_block_error[0:15];
wire					mshr_sub_block_lock_fail[0:15];
wire [MSHR_CTW_WIDTH-1:0]		mshr_sub_block_ctw[0:15];
wire [15:0]				mshr_sub_block_full;

wire [MSHR_DEPTH-1:0]			mshr_eb_valid;
wire [MSHR_DEPTH-1:0]			mshr_replace_valid;
wire [TAG_DW-1:0]			mshr_eb_tag[0:(MSHR_DEPTH-1)];

wire [15:0]				mshr_eb_push;
wire [15:0]				mshr_eb_pop;
wire [MSHR_DEPTH-1:0]			mshr_eb_empty;


wire					mshr_load_biu_req[0:15];
wire					mshr_load_biu_grant[0:(MSHR_DEPTH-1)];

wire [(MSHR_DEPTH-1):0]			mshr_sub_block_lsu_req;
wire [(MSHR_DEPTH-1):0]			mshr_sub_block_lsu_req_grant;
wire [15:0]				mshr_sub_block_lsu_req_ext_grant;
wire [15:0]				mshr_sub_block_lsu_req_arb_in;
reg  [3:0]				mshr_sub_block_lsu_req_arb_out;
wire [LS_DEST_BITS-1:0]			mshr_sub_block_lsu_req_dest_idx;
wire					mshr_sub_block_lsu_req_dest_to_vrf;
wire					mshr_sub_block_lsu_req_dest_to_frf;
wire					mshr_sub_block_lsu_req_dest_to_xrf;
wire					mshr_sub_block_lsu_req_dest_to_sb;
wire [BIU_DATA_WIDTH-1:0]		mshr_sub_block_lsu_req_rdata;	     
wire [5:0]				mshr_sub_block_lsu_req_offset;
wire [2:0]				mshr_sub_block_lsu_req_size;
wire [2:0]				mshr_sub_block_lsu_req_func;
wire					mshr_sub_block_lsu_req_error;
wire					mshr_sub_block_lsu_req_lock_fail;
wire					mshr_sub_block_lsu_req_blocking;
wire					mshr_sub_block_lsu_req_blocking_been_kill;
wire					mshr_sub_block_lsu_req_fill_done;
wire [3:0]				mshr_sub_block_lsu_req_fill_way;

wire					biu_rdata_match_mshr[0:15];

wire					mshr_evict_fetch_req[0:15];
wire [DCACHE_TAG_RAM_AW-1:0]		mshr_evict_fetch_index[0:15];
wire [3:0]				mshr_evict_fetch_way[0:15];
wire [OFFSET_WIDTH-1:0]			mshr_evict_fetch_offset[0:15];
wire					mshr_evict_fetch_grant[0:(MSHR_DEPTH-1)];

wire [MSHR_DEPTH-1:0]			mshr_evict_data_resp;

wire					mshr_evict_biu_req[0:15];
wire					mshr_evict_biu_req_grant[0:(MSHR_DEPTH-1)];
wire [BIU_ADDR_WIDTH-1:0]		mshr_evict_biu_req_addr[0:15];
wire					mshr_evict_biu_req_data_valid[0:15];
wire					mshr_evict_biu_req_data_ack[0:(MSHR_DEPTH-1)];
wire					mshr_evict_biu_req_last[0:15];

//MSHR FILL DCACHE TAG
wire [MSHR_DEPTH-1:0]			mshr_tag_req;
wire [MSHR_DEPTH-1:0]			mshr_tag_req_grant;
wire [DCACHE_TAG_RAM_AW-1:0]		mshr_tag_addr[0:15];
wire [MSHR_FILL_TAG_WDATA_WIDTH-1:0]	mshr_tag_wdata[0:15];
wire [15:0]				mshr_tag_req_ext;
reg  [3:0]				mshr_tag_req_arb_out;

//MSHR FILL DCACHE DATA
wire [MSHR_DEPTH-1:0]			mshr_data_req;
wire [MSHR_DEPTH-1:0]			mshr_data_req_grant;
wire [BIU_DATA_WIDTH-1:0]		mshr_data_wdata[0:15];
wire [INDEX_MSB:INDEX_LSB]		mshr_data_index[0:15];
wire [OFFSET_WIDTH-1:0]			mshr_data_offset[0:15];
wire [15:0]				mshr_data_req_ext;
wire [15:0]				mshr_cache_fill_done_ext;
reg  [3:0]				mshr_data_req_arb_out;
reg 					mshr_fill_arb_locked;
wire 					mshr_fill_arb_locked_set;
wire 					mshr_fill_arb_locked_clr;
wire 					mshr_fill_arb_locked_nx;
wire					mshr_fill_locked_entry_en;
reg [3:0]				mshr_fill_locked_entry;
//DQ, fifo
wire					dq_fifo_push;
wire					dq_fifo_pop;
wire [DQ_DATA_WIDTH-1:0]		dq_fifo_rdata;
wire [DQ_DATA_WIDTH-1:0]		dq_fifo_wdata;
wire					dq_fifo_full;
wire					dq_fifo_empty;
wire					dq_fifo_w_clk_empty;

wire					dq_rdata_match_mshr[0:15];

wire [BIU_DATA_WIDTH-1:0]		dq_read_data;
wire [3:0]				dq_read_entry_id;
wire [4:0]				dq_read_id;
wire 					dq_read_error;
wire					dq_read_lock_fail;
wire 					dq_read_last;

wire					dq_req_valid;

wire					dq_lsu_req;
wire					dq_lsu_grant;

//mshr resp
wire					mshr_lsu_req;
wire					mshr_lsu_grant;

wire					mshr_resp_sel_dq;

wire [15:0]				mshr_latch_data_en_ext;
wire [4:0]				mshr_req_id_ext[0:15];
//wire [15:0]				dq_read_id_matching_mshr_req_id;// one-hot
wire [15:0]				dq_push_id_matching_mshr_req_id;// one-hot
//reg  [3:0]				dq_read_req_id;
wire  [3:0]				dq_read_req_id;
reg  [3:0]				dq_push_req_id;


wire					dcu_dphase_hit_mshr_alloc;
wire					dcu_dphase_hit_mshr_alloc_evict;
wire					dcu_dphase_hit_mshr_alloc_replace;

wire [(MSHR_DEPTH-1):0]			dcu_dphase_hit_mshr_entry_evict;
wire [(MSHR_DEPTH-1):0]			dcu_dphase_hit_mshr_entry_replace;
wire [(MSHR_DEPTH-1):0]			dcu_dphase_hit_mshr_entry;
wire [(MSHR_DEPTH-1):0]			dcu_mm_hit_mshr_entry_load_cacheline;
wire [(MSHR_DEPTH-1):0]			dcu_mm_hit_mshr_entry_load_512b;
wire [(MSHR_DEPTH-1):0]			dcu_dphase_hit_ex_mshr_entry;
wire [15:0]				dcu_dphase_hit_mshr_entry_ext;
reg  [3:0]				dcu_dphase_hit_mshr_id;
wire [BIU_DATA_WIDTH-1:0]  		dcu_dphase_lookup_mshr_data[0:15];
wire [OFFSET_MSB:OFFSET_LSB]		dcu_dphase_lookup_mshr_data_sel;

wire [(MSHR_DEPTH-1):0]			dcu_dphase_hit_index_way[0:3];
wire [(MSHR_DEPTH-1):0]			dcu_dphase_hit_index_way_lock[0:3];
wire [3:0]				dcu_dphase_hit_index_way_hit;
wire [3:0]				dcu_dphase_hit_index_way_hit_lock;
wire 					dcu_dphase_hit_mshr_alloc_same_index;
wire [3:0]				dcu_dphase_hit_mshr_alloc_same_index_way;
wire [3:0]				dcu_dphase_hit_mshr_alloc_same_index_way_lock;

//EB
wire					eb_fifo_push;
wire					eb_fifo_pop;
wire [BIU_DATA_WIDTH-1:0]		eb_fifo_wdata;
wire [BIU_DATA_WIDTH-1:0]		eb_fifo_rdata;
wire					eb_fifo_empty;
wire					eb_fifo_w_clk_empty;
wire					eb_fifo_full;

//FB
wire [BIU_DATA_WIDTH-1:0] 		fb_fill_wdata[0:15];
wire [BIU_DATA_WIDTH-1:0] 		fb_sub_block_rdata[0:15];
wire  					fb_sub_block_error[0:15];
wire  					fb_sub_block_lock_fail[0:15];
wire [BIU_DATA_WIDTH-1:0] 		fb_dcu_lookup_mshr_data[0:15];

//MISC
reg   					mshr_load_req_lock_clear_reg;
wire  					mshr_load_req_lock_clear_nx;

//For Linting
wire [MSHR_CTW_WIDTH-1:0]		const_1;

generate
if (MSHR_CTW_WIDTH == 1) begin : gen_const_1_with_mshr_ctw_width_eq1
	assign const_1 = 1'b1;
end
else begin : gen_const_1_with_mshr_ctw_width_not_eq1
	assign const_1 = {{(MSHR_CTW_WIDTH-1){1'b0}}, 1'b1};
end
endgenerate


//====================================================
//			RTL 
//====================================================

//Allocate FIFO
//Use nds_sync_fifo_ll and a self_reset FSM to initial the FIFO
//The FIFO should be Full after reset
//The FIFO would receive N write req with wr_data 0 ~ (n-1)
assign mshr_self_reset 		= ~alloc_fifo_init_done;
assign alloc_fifo_initing 	= ~alloc_fifo_init_done;
assign alloc_fifo_init_last 	= (alloc_fifo_init_cnt == ALLOC_FIFO_LAST[ALLOC_FIFO_DATA_WIDTH-1:0]);

assign alloc_fifo_init_done_set = alloc_fifo_initing & alloc_fifo_init_last;
always @(posedge clk or negedge reset_n) begin
	if (!reset_n) 
		alloc_fifo_init_done <= 1'b0;
	else if (alloc_fifo_init_done_set)
		alloc_fifo_init_done <= 1'b1;
end

assign alloc_fifo_init_cnt_incr = alloc_fifo_init_cnt + {{(ALLOC_FIFO_DATA_WIDTH-1){1'b0}},1'b1};
always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		alloc_fifo_init_cnt <= {ALLOC_FIFO_DATA_WIDTH{1'b0}};
	else if (alloc_fifo_initing)
		alloc_fifo_init_cnt <= alloc_fifo_init_cnt_incr;
end

assign alloc_fifo_push = alloc_fifo_initing | mshr_entry_retired;
assign alloc_fifo_wdata = alloc_fifo_initing ? alloc_fifo_init_cnt : mshr_entry_retire_id;

assign alloc_fifo_pop = mshr_alloc & mshr_alloc_ready & ~mshr_alloc_sub_block;
//MSHR ALLOC

assign alloc_req_id_occupied = |alloc_fifo_rdata_hit_mshr_entry;
assign mshr_alloc_ready = ~alloc_fifo_empty & ~alloc_req_id_occupied; 
assign mshr_alloc_sub_block_valid = ~mshr_sub_block_full[mshr_alloc_sub_block_main_entry_id];
//assign mshr_alloc_ready = (~mshr_alloc_sub_block & ~alloc_fifo_empty) | 
//			  (mshr_alloc_sub_block & ~mshr_sub_block_full[mshr_alloc_sub_block_main_entry_id]);
assign mshr_alloc_ptr = alloc_fifo_rdata;
assign mshr_alloc_entry_ptr = mshr_alloc_ptr;

assign mshr_alloc_vector_slowpath 	     = (mshr_alloc_uncache & ~mshr_alloc_vector_fastpath & mshr_alloc_vec_access);
assign mshr_alloc_vector_fastpath_cross_512b = (mshr_alloc_uncache & mshr_alloc_vector_fastpath  & mshr_alloc_uncache_vector_unalign_second);

assign mshr_alloc_assign_id = mshr_alloc_lock 				| //AMO 
			      mshr_alloc_vector_slowpath		| //Vector slow path
			      mshr_alloc_vector_fastpath_cross_512b	; //Vector Fast path cross 512-byte

assign mshr_alloc_assigned_id = {{5{mshr_alloc_lock			  }} & ATOMIC_REQ_ID	                     }  | 
	                        {{5{mshr_alloc_vector_slowpath		  }} & UC_NON_FASTPASS_REQ_ID	             }  |
	                        {{5{mshr_alloc_vector_fastpath_cross_512b }} & {1'b1,latest_vector_fastpath_entry_id}}  ;

assign mshr_alloc_dep_id = mshr_alloc_vector_fastpath ? latest_vector_fastpath_entry_id : latest_vector_slowpath_entry_id;
assign mshr_alloc_dep_id_last_rdata = (dq_rdata_match_mshr[mshr_alloc_dep_id] & mshr_latch_data_en[mshr_alloc_dep_id] & (mshr_length[mshr_alloc_dep_id] == 4'b0)); 
assign mshr_alloc_dep = (((mshr_alloc_vector_slowpath & mshr_alloc_vector_slowpath_inprogress) | (mshr_alloc_vector_fastpath_cross_512b & mshr_latch_data_en[mshr_alloc_dep_id])) & ~mshr_alloc_dep_id_last_rdata);


generate
if (RVV_SUPPORT == "yes") begin : gen_rvv_entry_id
	reg  [3:0] 				latest_vector_fastpath_entry_id_reg;
	wire [3:0] 				latest_vector_fastpath_entry_id_nx;
	wire   					latest_vector_fastpath_entry_id_en;

	assign latest_vector_fastpath_entry_id_en = mshr_alloc & mshr_alloc_ready & mshr_alloc_vector_fastpath & mshr_alloc_uncache_vector_unalign_first & mshr_alloc_uncache;
	assign latest_vector_fastpath_entry_id_nx = mshr_alloc_ptr;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			latest_vector_fastpath_entry_id_reg <= 4'b0;
		else if (latest_vector_fastpath_entry_id_en)
			latest_vector_fastpath_entry_id_reg <= latest_vector_fastpath_entry_id_nx;
	end
	assign latest_vector_fastpath_entry_id = latest_vector_fastpath_entry_id_reg;
	reg  [3:0] 				latest_vector_slowpath_entry_id_reg;
	wire [3:0] 				latest_vector_slowpath_entry_id_nx;
	wire 	     				latest_vector_slowpath_entry_id_en;
	
	assign latest_vector_slowpath_entry_id_en = mshr_alloc & mshr_alloc_ready & mshr_alloc_vector_slowpath;
	assign latest_vector_slowpath_entry_id_nx = mshr_alloc_ptr;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			latest_vector_slowpath_entry_id_reg <= 4'b0;
		else if (latest_vector_slowpath_entry_id_en)
			latest_vector_slowpath_entry_id_reg <= latest_vector_slowpath_entry_id_nx;
	end
	assign latest_vector_slowpath_entry_id = latest_vector_slowpath_entry_id_reg;
end
else begin : gen_no_rvv_entry_id
	assign latest_vector_fastpath_entry_id = 4'b0;
	assign latest_vector_slowpath_entry_id = 4'b0;
end
endgenerate
assign mshr_alloc_vector_slowpath_inprogress_nx  = mshr_alloc_vector_slowpath_inprogress_set | (mshr_alloc_vector_slowpath_inprogress & ~mshr_alloc_vector_slowpath_inprogress_clr);
assign mshr_alloc_vector_slowpath_inprogress_set = mshr_alloc & mshr_alloc_ready & mshr_alloc_vector_slowpath;
assign mshr_alloc_vector_slowpath_inprogress_clr = (dq_rdata_match_mshr[latest_vector_slowpath_entry_id] & mshr_latch_data_en[latest_vector_slowpath_entry_id] & (mshr_length[latest_vector_slowpath_entry_id] == 4'b0));
always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		mshr_alloc_vector_slowpath_inprogress <= 1'b0;
	else
		mshr_alloc_vector_slowpath_inprogress <= mshr_alloc_vector_slowpath_inprogress_nx;
end

generate
genvar k;
for (k=0;k<MSHR_DEPTH;k=k+1) begin: gen_mshr_entry_alloc
	assign mshr_entry_alloc[k] 				= mshr_alloc & mshr_alloc_ready & ~mshr_alloc_sub_block & (mshr_alloc_ptr == mshr_entry_id[k]);
	assign mshr_sub_block_alloc[k] 				= mshr_alloc & mshr_alloc_ready & mshr_alloc_sub_block & (mshr_alloc_sub_block_main_entry_id == mshr_entry_id[k]);
	assign mshr_load_biu_grant[k] 				= mshr_load_req_grant & (mshr_issue_ptr == mshr_entry_id[k]);
	assign mshr_entry_retire_grant[k]  			= mshr_entry_retired & (mshr_entry_retire_id == mshr_entry_id[k]);
	assign biu_rdata_match_mshr[k] 				= mshr_load_resp_read_ack & mshr_load_resp_read_grant & (mshr_load_resp_id == mshr_req_id[k]);
	assign dq_rdata_match_mshr[k] 				= dq_fifo_pop & (dq_read_id == mshr_req_id[k]);
	assign mshr_evict_biu_req_data_ack[k]			= mshr_store_req_data_ack & (mshr_issue_ptr == mshr_entry_id[k]); 
	assign mshr_evict_fetch_grant[k] 			= mshr_evict_req_grant & (mshr_issue_ptr == mshr_entry_id[k]);
	assign mshr_evict_data_resp[k] 				= mshr_evict_resp_valid & (mshr_issue_ptr == mshr_entry_id[k]);
	assign mshr_evict_biu_req_grant[k] 			= mshr_store_req_grant & (mshr_issue_ptr == mshr_entry_id[k]);
	assign mshr_fill_done_grant[k]				= (mshr_fill_done_arb_id == mshr_entry_id[k]);
	assign mshr_eb_empty[k]					= eb_fifo_empty & (mshr_issue_ptr == mshr_entry_id[k]);
	assign mshr_entry_fastpath_inprogress[k]		= (mshr_state[k] != MSHR_INVALID_STATE) & mshr_vector_fastpath[k];
	assign alloc_fifo_rdata_hit_mshr_entry[k]		= (mshr_state[k] != MSHR_INVALID_STATE) & (mshr_req_id[k] == {1'b1,alloc_fifo_rdata});	
end
endgenerate
assign mshr_vec_fastpath_inprogress = |mshr_entry_fastpath_inprogress;

assign mshr_idle = alloc_fifo_full;
nds_sync_fifo_ll #(.DATA_WIDTH		(ALLOC_FIFO_DATA_WIDTH	),
		   .FIFO_DEPTH		(MSHR_DEPTH		),
		   .POINTER_INDEX_WIDTH (ALLOC_FIFO_INDEX_WIDTH )
		  ) alloc_fifo (  .w_reset_n	(reset_n	 ),
				  .r_reset_n	(reset_n	 ),
				  .w_clk	(clk		 ),
				  .r_clk	(clk		 ),
				  .wr		(alloc_fifo_push ),
				  .wr_data	(alloc_fifo_wdata),
				  .rd		(alloc_fifo_pop	 ),
				  .rd_data	(alloc_fifo_rdata),
				  .w_clk_empty	(alloc_fifo_w_clk_empty),
				  .empty	(alloc_fifo_empty),
				  .full		(alloc_fifo_full )
			       );
assign alloc_fb_fifo_push = (alloc_fifo_initing & (alloc_fifo_init_cnt <= ALLOC_FB_FIFO_LAST[ALLOC_FIFO_DATA_WIDTH-1:0])) | 
	                    (mshr_entry_retired & mshr_cache_fill[mshr_entry_retire_id]);

assign alloc_fb_fifo_wdata = alloc_fifo_initing ? alloc_fifo_init_cnt : mshr_fb_entry_id[mshr_entry_retire_id];

assign alloc_fb_fifo_pop = mshr_alloc & mshr_alloc_ready & ~mshr_alloc_sub_block & mshr_alloc_cache_fill; 

assign mshr_alloc_fb_valid = ~alloc_fb_fifo_empty;

nds_sync_fifo_ll #(.DATA_WIDTH		(ALLOC_FIFO_DATA_WIDTH	   ),
		   .FIFO_DEPTH		(MSHR_FB_DEPTH		   ),
		   .POINTER_INDEX_WIDTH (ALLOC_FB_FIFO_INDEX_WIDTH )
		  ) alloc_fb_fifo (  	.w_reset_n	(reset_n	 	),
				     	.r_reset_n	(reset_n	 	),
				  	.w_clk		(clk		 	),
				  	.r_clk		(clk		 	),
				  	.wr		(alloc_fb_fifo_push 	),
				  	.wr_data	(alloc_fb_fifo_wdata	),
				  	.rd		(alloc_fb_fifo_pop	),
				  	.rd_data	(alloc_fb_fifo_rdata	),
				  	.w_clk_empty	(alloc_fb_fifo_w_clk_empty),
				  	.empty		(alloc_fb_fifo_empty	),
				  	.full		(alloc_fb_fifo_full	)
			       	  );


// Issue FIFO 
// Issue FIFO points to the MSHR which is issuing to BIU (Including Eviction)

assign reg_issue_ptr_en = issue_ptr_valid_set;
assign reg_issue_ptr_nx = issue_fifo_empty ? alloc_fifo_rdata : issue_fifo_rdata;

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		reg_issue_ptr <= 4'b0;
	else if (reg_issue_ptr_en)
		reg_issue_ptr <= reg_issue_ptr_nx;
end

assign issue_ptr_valid_set = (alloc_fifo_pop & issue_fifo_empty & ~issue_ptr_valid		    ) | 
	                     (                ~issue_fifo_empty &  issue_ptr_valid & mshr_done_issue) |
			     (alloc_fifo_pop & issue_fifo_empty &  issue_ptr_valid & mshr_done_issue) ;
assign issue_ptr_valid_clr = mshr_done_issue;
assign issue_ptr_valid_nx  = issue_ptr_valid_set | (issue_ptr_valid & ~issue_ptr_valid_clr);

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		issue_ptr_valid <= 1'b0;
	else
		issue_ptr_valid <= issue_ptr_valid_nx;
end

assign mshr_evict_done	= |mshr_entry_issue_done;
generate
if (MSHR_DEPTH == 16) begin : gen_mshr_entry_issue_done_eq_16
	assign mshr_entry_issue_done_ext = mshr_entry_issue_done;
end
else begin : gen_mshr_entry_issue_done_less_than_max
	assign mshr_entry_issue_done_ext = {{(16-MSHR_DEPTH){1'b0}},mshr_entry_issue_done};
end
endgenerate
assign mshr_done_issue = mshr_entry_issue_done_ext[mshr_issue_ptr]; 	

assign issue_fifo_push = (issue_ptr_valid & ~issue_fifo_empty & alloc_fifo_pop) 		  | 
	                 (issue_ptr_valid & issue_fifo_empty  & alloc_fifo_pop & ~mshr_done_issue);
assign issue_fifo_wdata = alloc_fifo_rdata;
assign issue_fifo_pop = mshr_done_issue & issue_ptr_valid & ~issue_fifo_empty;
assign mshr_issue_ptr = reg_issue_ptr;
nds_sync_fifo_ll #(.DATA_WIDTH		(4			),
		   .FIFO_DEPTH		(MSHR_DEPTH		),
		   .POINTER_INDEX_WIDTH (ISSUE_FIFO_INDEX_WIDTH )
		  ) issue_fifo (  .w_reset_n	(reset_n	 ),
				  .r_reset_n	(reset_n	 ),
				  .w_clk	(clk		 ),
				  .r_clk	(clk		 ),
				  .wr		(issue_fifo_push ),
				  .wr_data	(issue_fifo_wdata),
				  .rd		(issue_fifo_pop	 ),
				  .rd_data	(issue_fifo_rdata),
				  .w_clk_empty	(issue_fifo_w_clk_empty),
				  .empty	(issue_fifo_empty),
				  .full		(issue_fifo_full)
			       );
// MSHR Retire
assign mshr_entry_retire_arb_in = mshr_entry_retire;

always @* begin
	casez (mshr_entry_retire_arb_in)
	16'b????????_???????1: mshr_entry_retire_id = 4'd0;
	16'b????????_??????10: mshr_entry_retire_id = 4'd1;
	16'b????????_?????100: mshr_entry_retire_id = 4'd2;
	16'b????????_????1000: mshr_entry_retire_id = 4'd3;
	16'b????????_???10000: mshr_entry_retire_id = 4'd4;
	16'b????????_??100000: mshr_entry_retire_id = 4'd5;
	16'b????????_?1000000: mshr_entry_retire_id = 4'd6;
	16'b????????_10000000: mshr_entry_retire_id = 4'd7;
	16'b???????1_00000000: mshr_entry_retire_id = 4'd8;
	16'b??????10_00000000: mshr_entry_retire_id = 4'd9;
	16'b?????100_00000000: mshr_entry_retire_id = 4'd10;
	16'b????1000_00000000: mshr_entry_retire_id = 4'd11;
	16'b???10000_00000000: mshr_entry_retire_id = 4'd12;
	16'b??100000_00000000: mshr_entry_retire_id = 4'd13;
	16'b?1000000_00000000: mshr_entry_retire_id = 4'd14;
	16'b10000000_00000000: mshr_entry_retire_id = 4'd15;
	default : mshr_entry_retire_id = 4'b0;
	endcase
end

assign  mshr_entry_retired = |mshr_entry_retire;

//MSHR Fill Done
generate
if (MSHR_DEPTH == 16) begin : gen_mshr_entry_fill_done_eq_16
	assign mshr_fill_done_arb_in = mshr_entry_fill_done;
end
else begin : gen_mshr_entry_fill_done_less_than_max
	assign mshr_fill_done_arb_in = {{(16-MSHR_DEPTH){1'b0}},mshr_entry_fill_done};
end
endgenerate

always @* begin
	casez (mshr_fill_done_arb_in)
	16'b????????_???????1: mshr_fill_done_arb_id = 4'd0;
	16'b????????_??????10: mshr_fill_done_arb_id = 4'd1;
	16'b????????_?????100: mshr_fill_done_arb_id = 4'd2;
	16'b????????_????1000: mshr_fill_done_arb_id = 4'd3;
	16'b????????_???10000: mshr_fill_done_arb_id = 4'd4;
	16'b????????_??100000: mshr_fill_done_arb_id = 4'd5;
	16'b????????_?1000000: mshr_fill_done_arb_id = 4'd6;
	16'b????????_10000000: mshr_fill_done_arb_id = 4'd7;
	16'b???????1_00000000: mshr_fill_done_arb_id = 4'd8;
	16'b??????10_00000000: mshr_fill_done_arb_id = 4'd9;
	16'b?????100_00000000: mshr_fill_done_arb_id = 4'd10;
	16'b????1000_00000000: mshr_fill_done_arb_id = 4'd11;
	16'b???10000_00000000: mshr_fill_done_arb_id = 4'd12;
	16'b??100000_00000000: mshr_fill_done_arb_id = 4'd13;
	16'b?1000000_00000000: mshr_fill_done_arb_id = 4'd14;
	16'b10000000_00000000: mshr_fill_done_arb_id = 4'd15;
	default    : mshr_fill_done_arb_id = 4'b0;
	endcase
end

assign mshr_fill_done_id = mshr_fill_done_arb_id;
assign mshr_fill_done 	 = |mshr_entry_fill_done;
assign mshr_fill_abort   = mshr_entry_fill_abort[mshr_fill_done_arb_id];

//DCU data phase lookup MSHR entry

assign dcu_dphase_hit_mshr_alloc 	= mshr_alloc & mshr_alloc_ready & mshr_alloc_cache_fill & ~mshr_alloc_sub_block & (mshr_alloc_addr[BIU_ADDR_WIDTH-1:INDEX_LSB] == dcu_dphase_addr[BIU_ADDR_WIDTH-1:INDEX_LSB]);
assign dcu_dphase_hit_mshr_alloc_evict 	= mshr_alloc & mshr_alloc_ready & mshr_alloc_evict & (dcu_dphase_addr[TAG_MSB:TAG_LSB] == mshr_alloc_evict_tag) & (dcu_dphase_addr[INDEX_MSB:INDEX_LSB] == mshr_alloc_addr[INDEX_MSB:INDEX_LSB]);
assign dcu_dphase_hit_mshr_alloc_replace= mshr_alloc & mshr_alloc_ready & mshr_alloc_replace & (dcu_dphase_addr[TAG_MSB:TAG_LSB] == mshr_alloc_evict_tag) & (dcu_dphase_addr[INDEX_MSB:INDEX_LSB] == mshr_alloc_addr[INDEX_MSB:INDEX_LSB]);

generate
genvar x;
for (x=0; x<MSHR_DEPTH; x=x+1) begin : gen_dcu_dphase_hit_mshr_entry
	assign dcu_dphase_hit_mshr_entry[x]			= mshr_cache_fill[x] & (mshr_state[x] != MSHR_INVALID_STATE) & (mshr_addr[x][BIU_ADDR_WIDTH-1:INDEX_LSB] == dcu_dphase_addr[BIU_ADDR_WIDTH-1:INDEX_LSB]) & ~mshr_error[x];
	assign dcu_dphase_hit_ex_mshr_entry[x]			= dcu_dphase_hit_mshr_entry[x] & (mshr_type[x] == READ_EXCLUSIVE);
	assign dcu_dphase_hit_mshr_entry_evict[x] 		= mshr_eb_valid[x] & (dcu_dphase_addr[TAG_MSB:TAG_LSB] == mshr_eb_tag[x]) & (dcu_dphase_addr[INDEX_MSB:INDEX_LSB] == mshr_addr[x][INDEX_MSB:INDEX_LSB]);
        assign dcu_dphase_hit_mshr_entry_replace[x]		= mshr_replace_valid[x] & (dcu_dphase_addr[TAG_MSB:TAG_LSB] == mshr_eb_tag[x]) & (dcu_dphase_addr[INDEX_MSB:INDEX_LSB] == mshr_addr[x][INDEX_MSB:INDEX_LSB]);	
	assign dcu_mm_hit_mshr_entry_load_cacheline[x] 		= ~mshr_cache_fill[x] & ~mshr_device[x] & (mshr_state[x] != MSHR_INVALID_STATE) & (mshr_addr[x][BIU_ADDR_WIDTH-1:CACHE_LINE_INDEX_LSB] == dcu_mm_pa[BIU_ADDR_WIDTH-1:CACHE_LINE_INDEX_LSB]);	
	assign dcu_mm_hit_mshr_entry_load_512b[x] 		= ~mshr_cache_fill[x] & ~mshr_device[x] & (mshr_state[x] != MSHR_INVALID_STATE) & (mshr_addr[x][BIU_ADDR_WIDTH-1:9] == dcu_mm_pa[BIU_ADDR_WIDTH-1:9]);	
end
endgenerate
generate
genvar y;
for (y=0; y < MSHR_DEPTH ; y = y+1) begin : gen_dphase_hit_index_way
	wire dcu_dphase_hit_mshr_entry_with_same_index = (dcu_dphase_addr[INDEX_MSB:INDEX_LSB] == mshr_addr[y][INDEX_MSB:INDEX_LSB]) & 
		                                         (dcu_dphase_addr[TAG_MSB:TAG_LSB] != mshr_addr[y][TAG_MSB:TAG_LSB]) & 
	                                                 (mshr_state[y] != MSHR_INVALID_STATE) & mshr_cache_fill[y];
	assign dcu_dphase_hit_index_way[0][y] =  dcu_dphase_hit_mshr_entry_with_same_index & (mshr_way[y] == 4'b0001);
	assign dcu_dphase_hit_index_way[1][y] =  dcu_dphase_hit_mshr_entry_with_same_index & (mshr_way[y] == 4'b0010);
	assign dcu_dphase_hit_index_way[2][y] =  dcu_dphase_hit_mshr_entry_with_same_index & (mshr_way[y] == 4'b0100);
	assign dcu_dphase_hit_index_way[3][y] =  dcu_dphase_hit_mshr_entry_with_same_index & (mshr_way[y] == 4'b1000);
	assign dcu_dphase_hit_index_way_lock[0][y] =  dcu_dphase_hit_index_way[0][y] & mshr_lock[y];
	assign dcu_dphase_hit_index_way_lock[1][y] =  dcu_dphase_hit_index_way[1][y] & mshr_lock[y];
	assign dcu_dphase_hit_index_way_lock[2][y] =  dcu_dphase_hit_index_way[2][y] & mshr_lock[y];
	assign dcu_dphase_hit_index_way_lock[3][y] =  dcu_dphase_hit_index_way[3][y] & mshr_lock[y];
end
endgenerate

assign dcu_dphase_hit_mshr_alloc_same_index = (mshr_alloc_addr[INDEX_MSB:INDEX_LSB] == dcu_dphase_addr[INDEX_MSB:INDEX_LSB]) & (mshr_alloc_addr[TAG_MSB:TAG_LSB] != dcu_dphase_addr[TAG_MSB:TAG_LSB]) & 
	                                       mshr_alloc & mshr_alloc_ready & ~mshr_alloc_sub_block & mshr_alloc_cache_fill;

assign dcu_dphase_hit_mshr_alloc_same_index_way[0] = dcu_dphase_hit_mshr_alloc_same_index & (mshr_alloc_cache_fill_way == 4'b0001);
assign dcu_dphase_hit_mshr_alloc_same_index_way[1] = dcu_dphase_hit_mshr_alloc_same_index & (mshr_alloc_cache_fill_way == 4'b0010);
assign dcu_dphase_hit_mshr_alloc_same_index_way[2] = dcu_dphase_hit_mshr_alloc_same_index & (mshr_alloc_cache_fill_way == 4'b0100);
assign dcu_dphase_hit_mshr_alloc_same_index_way[3] = dcu_dphase_hit_mshr_alloc_same_index & (mshr_alloc_cache_fill_way == 4'b1000);

assign dcu_dphase_hit_mshr_alloc_same_index_way_lock[0] = dcu_dphase_hit_mshr_alloc_same_index_way[0] & mshr_alloc_cctl_lock;
assign dcu_dphase_hit_mshr_alloc_same_index_way_lock[1] = dcu_dphase_hit_mshr_alloc_same_index_way[1] & mshr_alloc_cctl_lock;
assign dcu_dphase_hit_mshr_alloc_same_index_way_lock[2] = dcu_dphase_hit_mshr_alloc_same_index_way[2] & mshr_alloc_cctl_lock;
assign dcu_dphase_hit_mshr_alloc_same_index_way_lock[3] = dcu_dphase_hit_mshr_alloc_same_index_way[3] & mshr_alloc_cctl_lock;

assign dcu_dphase_hit_index_way_hit[0] = |dcu_dphase_hit_index_way[0] | dcu_dphase_hit_mshr_alloc_same_index_way[0];
assign dcu_dphase_hit_index_way_hit[1] = |dcu_dphase_hit_index_way[1] | dcu_dphase_hit_mshr_alloc_same_index_way[1];
assign dcu_dphase_hit_index_way_hit[2] = |dcu_dphase_hit_index_way[2] | dcu_dphase_hit_mshr_alloc_same_index_way[2];
assign dcu_dphase_hit_index_way_hit[3] = |dcu_dphase_hit_index_way[3] | dcu_dphase_hit_mshr_alloc_same_index_way[3];

assign dcu_dphase_hit_index_way_hit_lock[0] = |dcu_dphase_hit_index_way_lock[0] | dcu_dphase_hit_mshr_alloc_same_index_way_lock[0];
assign dcu_dphase_hit_index_way_hit_lock[1] = |dcu_dphase_hit_index_way_lock[1] | dcu_dphase_hit_mshr_alloc_same_index_way_lock[1];
assign dcu_dphase_hit_index_way_hit_lock[2] = |dcu_dphase_hit_index_way_lock[2] | dcu_dphase_hit_mshr_alloc_same_index_way_lock[2];
assign dcu_dphase_hit_index_way_hit_lock[3] = |dcu_dphase_hit_index_way_lock[3] | dcu_dphase_hit_mshr_alloc_same_index_way_lock[3];

assign dcu_dphase_hit_same_index = |dcu_dphase_hit_index_way_hit;
assign dcu_dphase_hit_same_index_way = dcu_dphase_hit_index_way_hit;
assign dcu_dphase_hit_same_index_way_lock = dcu_dphase_hit_index_way_hit_lock;

generate
if (MSHR_DEPTH == 16) begin : gen_dphase_hit_mshr_entry_ext_eq_16
	assign dcu_dphase_hit_mshr_entry_ext = |dcu_dphase_hit_ex_mshr_entry ? dcu_dphase_hit_ex_mshr_entry : dcu_dphase_hit_mshr_entry;
end
else begin : gen_dphase_hit_mshr_entry_ext_less_than_16
	assign dcu_dphase_hit_mshr_entry_ext = |dcu_dphase_hit_ex_mshr_entry ? {{(16-MSHR_DEPTH){1'b0}}, dcu_dphase_hit_ex_mshr_entry} : {{(16-MSHR_DEPTH){1'b0}}, dcu_dphase_hit_mshr_entry};
end
endgenerate


always @* begin
	casez(dcu_dphase_hit_mshr_entry_ext)
	16'b????????_???????1: dcu_dphase_hit_mshr_id = 4'd0;
	16'b????????_??????10: dcu_dphase_hit_mshr_id = 4'd1;
	16'b????????_?????100: dcu_dphase_hit_mshr_id = 4'd2;
	16'b????????_????1000: dcu_dphase_hit_mshr_id = 4'd3;
	16'b????????_???10000: dcu_dphase_hit_mshr_id = 4'd4;
	16'b????????_??100000: dcu_dphase_hit_mshr_id = 4'd5;
	16'b????????_?1000000: dcu_dphase_hit_mshr_id = 4'd6;
	16'b????????_10000000: dcu_dphase_hit_mshr_id = 4'd7;
	16'b???????1_00000000: dcu_dphase_hit_mshr_id = 4'd8;
	16'b??????10_00000000: dcu_dphase_hit_mshr_id = 4'd9;
	16'b?????100_00000000: dcu_dphase_hit_mshr_id = 4'd10;
	16'b????1000_00000000: dcu_dphase_hit_mshr_id = 4'd11;
	16'b???10000_00000000: dcu_dphase_hit_mshr_id = 4'd12;
	16'b??100000_00000000: dcu_dphase_hit_mshr_id = 4'd13;
	16'b?1000000_00000000: dcu_dphase_hit_mshr_id = 4'd14;
	16'b10000000_00000000: dcu_dphase_hit_mshr_id = 4'd15;
	default	   : dcu_dphase_hit_mshr_id = 4'b0000;
	endcase
end
generate
//if ((BIU_DATA_WIDTH == 256) begin : gen_dcu_dphase_lookup_data_sel_256b
if ((CACHE_LINE_BEATS == 1)) begin : gen_dcu_dphase_lookup_data_sel_single_beat
	assign dcu_dphase_lookup_mshr_data_sel		= {OFFSET_WIDTH{1'b0}};
	assign dcu_dphase_hit_data_ready_mshr		= dcu_dphase_hit_mshr_alloc ? 1'b0 :mshr_drdy[dcu_dphase_hit_mshr_id][0];
end
else begin : gen_dcu_dphase_lookup_data_sel_multi_beat
	assign dcu_dphase_lookup_mshr_data_sel		= dcu_dphase_addr[OFFSET_MSB:OFFSET_LSB];
	assign dcu_dphase_hit_data_ready_mshr		= dcu_dphase_hit_mshr_alloc ? 1'b0 :mshr_drdy[dcu_dphase_hit_mshr_id][dcu_dphase_lookup_mshr_data_sel];
end
endgenerate

assign dcu_dphase_hit_mshr			= (|dcu_dphase_hit_mshr_entry) | dcu_dphase_hit_mshr_alloc;
assign dcu_dphase_hit_mshr_ex			= (|dcu_dphase_hit_ex_mshr_entry) | (dcu_dphase_hit_mshr_alloc & (mshr_alloc_type == READ_EXCLUSIVE));
assign dcu_dphase_hit_mshr_way			= dcu_dphase_hit_mshr_alloc ? mshr_alloc_cache_fill_way : mshr_way[dcu_dphase_hit_mshr_id];
assign dcu_dphase_hit_mshr_entry_id		= dcu_dphase_hit_mshr_alloc ? mshr_alloc_ptr : dcu_dphase_hit_mshr_id;
assign dcu_dphase_hit_mshr_fill_done		= dcu_dphase_hit_mshr_alloc ? 1'b0 : mshr_entry_cache_fill_done[dcu_dphase_hit_mshr_id];
assign dcu_dphase_hit_eviction			= (|dcu_dphase_hit_mshr_entry_evict) | dcu_dphase_hit_mshr_alloc_evict;
assign dcu_dphase_hit_replacement		= (|dcu_dphase_hit_mshr_entry_replace) | dcu_dphase_hit_mshr_alloc_replace;
assign dcu_dphase_hit_lock			= dcu_dphase_hit_mshr_alloc ? mshr_alloc_cctl_lock : mshr_lock[dcu_dphase_hit_mshr_id];  
assign dcu_mm_hit_load_cacheline		= (|dcu_mm_hit_mshr_entry_load_cacheline);
assign dcu_mm_hit_load_512b			= (|dcu_mm_hit_mshr_entry_load_512b);

generate
if ((MEM_WIDTH == 32) && (BIU_DATA_WIDTH == 64)) begin : gen_mshr_bypass_data_xlen32_biu64
	assign dcu_dphase_hit_data_ready_mshr_rdata	= dcu_dphase_addr[2] ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][63:32] : 
		                                                               dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][31: 0];
end
else if ((MEM_WIDTH == 64) && (BIU_DATA_WIDTH == 128)) begin : gen_mshr_bypass_data_xlen64_biu128
	assign dcu_dphase_hit_data_ready_mshr_rdata	= dcu_dphase_addr[3] ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][127:64] :
		                                                               dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][ 63: 0] ;
end
else if ((MEM_WIDTH == 64) && (BIU_DATA_WIDTH == 256)) begin : gen_mshr_bypass_data_xlen64_biu256
	assign dcu_dphase_hit_data_ready_mshr_rdata	= (dcu_dphase_addr[4:3] == 2'b00) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][ 63:  0] :
	                                                  (dcu_dphase_addr[4:3] == 2'b01) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][127: 64] :	
	                                                  (dcu_dphase_addr[4:3] == 2'b10) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][191:128] : 
							                                    dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][255:192] ;	
end
else if ((MEM_WIDTH == 32) && (BIU_DATA_WIDTH == 128)) begin : gen_mshr_bypass_data_xlen32_biu128
	assign dcu_dphase_hit_data_ready_mshr_rdata	= (dcu_dphase_addr[3:2] == 2'b00) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][ 31: 0] :
					                  (dcu_dphase_addr[3:2] == 2'b01) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][ 63:32] :	
	                                                  (dcu_dphase_addr[3:2] == 2'b10) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][ 95:64] : 
							                                    dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][127:96] ;	
end
else if ((MEM_WIDTH == 32) && (BIU_DATA_WIDTH == 256)) begin : gen_mshr_bypass_data_xlen32_biu256
	assign dcu_dphase_hit_data_ready_mshr_rdata	= (dcu_dphase_addr[4:2] == 3'b000) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][ 31:  0] :
	                                                  (dcu_dphase_addr[4:2] == 3'b001) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][ 63: 32] :	
	                                                  (dcu_dphase_addr[4:2] == 3'b010) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][ 95: 64] :
							  (dcu_dphase_addr[4:2] == 3'b011) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][127: 96] :
	                                                  (dcu_dphase_addr[4:2] == 3'b100) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][159:128] :	
	                                                  (dcu_dphase_addr[4:2] == 3'b101) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][191:160] : 
	                                                  (dcu_dphase_addr[4:2] == 3'b110) ? dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][223:192] :
						  					     dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id][255:224] ;	  
end
else begin : gen_mshr_bypass_data_xlen_eq_biu
	assign dcu_dphase_hit_data_ready_mshr_rdata	= dcu_dphase_lookup_mshr_data[dcu_dphase_hit_mshr_id];
end
endgenerate

//DCU resp phase lookup mshr
generate
genvar d;
for (d=0;d<16;d=d+1) begin: gen_mshr_state_ext
	if (d < MSHR_DEPTH) begin: gen_mshr_state
		assign mshr_state_ext[d] = mshr_state[d];
		assign mshr_entry_busy[d] = (mshr_state[d] != MSHR_INVALID_STATE);
	end
	else begin : gen_unused_mshr_state
		assign mshr_state_ext[d] = 2'b0;
		assign mshr_entry_busy[d] = 1'b0;
	end
end
endgenerate
assign dcu_rphase_lookup_hit_mshr	= dcu_rphase_lookup_mshr & (mshr_state_ext[dcu_rphase_lookup_mshr_id] != MSHR_INVALID_STATE) & ~mshr_entry_retire[dcu_rphase_lookup_mshr_id];
assign dcu_rphase_lookup_fill_done  = mshr_entry_cache_fill_done[dcu_rphase_lookup_mshr_id]; 


//MSHR Entries
//Each MSHR contains a main entry, 2~4 sub-block
genvar i;
genvar j;
genvar jj;
genvar m;
generate
for (i = 0; i < MSHR_DEPTH;i = i + 1) begin : gen_mshr_entry
	//main entry
	wire [1:0]				st_cs = state_cs[i];
	wire [1:0]				st_ns = state_ns[i];
	reg [BIU_ADDR_WIDTH-1:0]		addr;
	reg [MSHR_CTW_WIDTH-1:0]		ctw;
	reg [MSHR_DRDY_WIDTH-1:0]		drdy;
	reg [3:0]				mem_attri;
	reg 					error;
	reg 					cache_fill;
	reg [3:0]				way;
	reg [2:0]				size;
	reg 					privileged;
	reg [3:0]				length;
	reg 					lock;
	reg [2:0]				load_type;
	reg					vector_fastpath;
	reg					dep;
	reg [3:0]				dep_id;
	reg					latch_data_en;
	reg [4:0]				req_id;
	reg					atomic_store;
	reg					rsnoop;
	reg					cctl_lock;
	reg					device;
	reg [3:0]				fb_entry_id;
	reg					vec_fp_confirmed;
	

	wire [BIU_ADDR_WIDTH-1:0]		addr_nx;
	wire [3:0]				mem_attri_nx;
	wire 					error_en;
	wire 					error_nx;
	wire 					cache_fill_nx;
	wire [3:0]				way_nx;
	wire [2:0]				size_nx;
	wire 					privileged_nx;
	wire 					lock_nx;
	wire [2:0]				load_type_nx;
	wire					vector_fastpath_nx;
	wire					dep_nx;
	wire [3:0]				dep_id_nx;
	wire [4:0]				req_id_nx;
	wire					atomic_store_nx;
	wire					cctl_lock_nx;
	wire					device_nx;
	
	wire					vec_fp_confirmed_nx;
	wire					vec_fp_confirmed_set;
	wire					vec_fp_confirmed_clr;

	wire [MSHR_CTW_WIDTH-1:0]		ctw_nx;
	wire [MSHR_CTW_WIDTH-1:0]		ctw_incr;
	wire 					ctw_en;
	
	wire [MSHR_DRDY_WIDTH-1:0]		drdy_nx;
	wire [MSHR_DRDY_WIDTH-1:0]		drdy_biu_pop_nx;
	wire					drdy_en;
	reg  [MSHR_DRDY_WIDTH-1:0]		drdy_ptr;
	wire [7:0]				drdy_ptr_8b;					
	wire					drdy_ptr_en;
	wire [MSHR_DRDY_WIDTH-1:0]		drdy_ptr_nx;
	wire [MSHR_DRDY_WIDTH-1:0]		drdy_ptr_init;
	wire [7:0]				drdy_ptr_biu_pop_nx;
	wire [30:0]				drdy_ptr_init_dec;

	wire [3:0]				length_nx;
	wire [3:0]				length_decrease;
	wire					length_en;

	wire					latch_data_en_set;
	wire					latch_data_en_clr;
	wire					latch_data_en_nx;
	wire					latch_data_en_en;

	wire					rsnoop_nx;
	wire					rsnoop_set;
	wire					rsnoop_clr;

	wire [1:0]				mshr_fill_tag_state;
	wire					mshr_fill_tag_lock;
	reg					cache_fill_tag_done;
	wire					cache_fill_tag_done_nx;
	wire					cache_fill_tag_done_en;
	wire					cache_fill_tag_done_set;
	wire					cache_fill_tag_done_clr;

	reg					cache_fill_data_done;
	wire					cache_fill_data_done_nx;
	wire					cache_fill_data_done_en;
	wire					cache_fill_data_done_set;
	wire					cache_fill_data_done_clr;

	reg  [OFFSET_WIDTH-1:0]			cache_fill_data_offset;
	wire					cache_fill_data_offset_en;
	wire [OFFSET_WIDTH-1:0]			cache_fill_data_offset_nx;
	wire [OFFSET_WIDTH-1:0]			cache_fill_data_offset_incr;
	
	wire					mshr_pending_state;
	wire					dq_rdata_matching;
	wire					dq_rdata_last_matching;
	wire					dq_dep_rdata_last_matching;
	wire					biu_rdata_matching_fill;
	wire					biu_rdata_last_match_fill;
	wire					biu_dep_rdata_last_matching;

	reg					biu_req_done;
	wire					biu_req_done_nx;
	wire					biu_req_done_en;
	wire					biu_req_done_set;
	wire					biu_req_done_clr;

	reg					biu_rdata_done;
	wire					biu_rdata_done_nx;
	wire					biu_rdata_done_set;
	wire					biu_rdata_done_clr;

	reg					fill_done_to_lsu_complete;
	wire					fill_done_to_lsu_complete_nx;
	wire					fill_done_to_lsu_complete_set;
	wire					fill_done_to_lsu_complete_clr;

	//sub-block
	//data is handled outside this generate block
	wire [MSHR_SUB_BLOCK_DEPTH-1:0]			sub_block_alloc;
	reg  [2:0]					sub_block_alloc_ptr;
	wire [7:0]					sub_block_valid;
	wire [LS_DEST_BITS-1:0]				sub_block_rf_index[0:7];
	wire [7:0]					sub_block_dest_to_vrf;
	wire [7:0]					sub_block_dest_to_frf;
	wire [7:0]					sub_block_dest_to_xrf;
	wire [7:0]					sub_block_dest_to_sb;
	wire [MSHR_CTW_WIDTH-1:0]			sub_block_sub_ctw[0:7];
	wire [7:0]					sub_block_data_ready;
	wire [5:0]					sub_block_offset[0:7];
	wire [2:0]					sub_block_size[0:7];
	wire [2:0]					sub_block_func[0:7];
	wire [7:0]					sub_block_blocking;
	wire 						sub_block_blocking_been_killed[0:7];

	wire [7:0]					sub_block_lsu_req;	
	wire [7:0]					sub_block_lsu_req_grant;	
	wire [7:0]					sub_block_lsu_req_ext_grant;	
	wire [7:0]					sub_block_lsu_req_arb_in;
	reg  [2:0]					sub_block_lsu_req_arb_grant;
	
	//Evcition buffer
	wire						mshr_alloc_eb;

	reg						eb_valid;
	wire						eb_valid_nx;
	wire						eb_valid_set;
	wire						eb_valid_clr;

	reg						replace_valid;
	wire						replace_valid_nx;
	wire						replace_valid_set;
	wire						replace_valid_clr;

	reg						eb_rd_data_done;
	wire						eb_rd_data_done_nx;
	wire						eb_rd_data_done_set;
	wire						eb_rd_data_done_clr;

	reg						eb_evict_req_en;
	wire						eb_evict_req_en_nx;
	wire						eb_evict_req_en_set;
	wire						eb_evict_req_en_clr;

	reg						eb_evict_req_done;
	wire						eb_evict_req_done_nx;
	wire						eb_evict_req_done_set;
	wire						eb_evict_req_done_clr;

	reg						eb_wr_data_done;
	wire						eb_wr_data_done_nx;
	wire						eb_wr_data_done_set;
	wire						eb_wr_data_done_clr;

	reg [TAG_DW-1:0]				eb_tag;
	wire						eb_tag_en;
	wire [TAG_DW-1:0]				eb_tag_nx;

	reg [MSHR_CTW_WIDTH-1:0]			eb_fetch_cnt;
	wire						eb_fetch_cnt_en;
	wire						eb_fetch_cnt_incr;
	wire						eb_fetch_cnt_reset;
	wire [MSHR_CTW_WIDTH-1:0]			eb_fetch_cnt_nx;

	reg [MSHR_CTW_WIDTH-1:0]			eb_rdata_cnt;
	wire						eb_rdata_cnt_en;
	wire						eb_rdata_cnt_incr;
	wire						eb_rdata_cnt_reset;
	wire [MSHR_CTW_WIDTH-1:0]			eb_rdata_cnt_nx;

	reg						eb_rdata_full;
	wire						eb_rdata_full_set;
	wire						eb_rdata_full_clr;
	wire						eb_rdata_full_nx;

	reg [MSHR_CTW_WIDTH-1:0]			eb_biu_cnt;
	wire						eb_biu_cnt_en;
	wire [MSHR_CTW_WIDTH-1:0]			eb_biu_cnt_nx;
	wire						eb_biu_cnt_reset;
	wire						eb_biu_cnt_incr;

	wire						eb_push;
	wire						eb_pop;
	wire 						eb_empty;

	wire						eb_fetch_req;	

	wire						sub_block_has_blocking_req;
	wire						sub_block_has_dest_to_sb;

	//General
	
	assign dq_rdata_matching 		= (dq_rdata_match_mshr[i] & latch_data_en);
	assign dq_rdata_last_matching 		= (dq_rdata_match_mshr[i] & latch_data_en & (length == 4'b0));
	assign dq_dep_rdata_last_matching 	= (dq_rdata_match_mshr[dep_id] & (dq_read_last | (mshr_length[dep_id] == 4'b0)) & mshr_latch_data_en[dep_id]);
	assign biu_rdata_matching_fill		= (biu_rdata_match_mshr[i] & latch_data_en & cache_fill);
	assign biu_rdata_last_match_fill	= (biu_rdata_match_mshr[i] & latch_data_en & cache_fill & ((length == 4'b0) | mshr_load_resp_last));
	assign biu_dep_rdata_last_matching	= (biu_rdata_match_mshr[dep_id] & (mshr_length[dep_id] == 4'b0) & mshr_latch_data_en[dep_id] & mshr_cache_fill[dep_id]);


	assign addr_nx			= mshr_alloc_addr;
	assign mem_attri_nx		= mshr_alloc_cacheability;
	assign cache_fill_nx		= mshr_alloc_cache_fill;
	assign way_nx			= mshr_alloc_cache_fill_way;
	assign size_nx			= mshr_alloc_size;
	assign privileged_nx		= mshr_alloc_privileged;
	assign lock_nx			= mshr_alloc_lock;
	assign load_type_nx		= mshr_alloc_type;
	assign vector_fastpath_nx	= mshr_alloc_vector_fastpath;
	assign dep_nx			= mshr_alloc_dep;
	assign dep_id_nx		= mshr_alloc_dep_id;
	assign req_id_nx		= mshr_alloc_assign_id ? mshr_alloc_assigned_id : {1'b1,mshr_alloc_ptr};
	assign atomic_store_nx		= mshr_alloc_atomic_store;
	assign cctl_lock_nx		= mshr_alloc_cctl_lock;
	assign device_nx		= mshr_alloc_device;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			addr 			<= {BIU_ADDR_WIDTH{1'b0}};
			mem_attri		<= 4'b0;
			cache_fill		<= 1'b0;
			way			<= 4'b0;
			size			<= 3'b0;
			privileged		<= 1'b0;
			lock			<= 1'b0;
			load_type		<= 3'b0;
			vector_fastpath		<= 1'b0;
			dep			<= 1'b0;
			dep_id			<= 4'b0;
			req_id			<= 5'b0;
			atomic_store		<= 1'b0;
			cctl_lock		<= 1'b0;
			device			<= 1'b0;
		end
		else if (mshr_entry_alloc[i]) begin
			addr 		<= addr_nx;
			mem_attri	<= mem_attri_nx;
			cache_fill	<= cache_fill_nx;
			way		<= way_nx;
			size		<= size_nx;
			privileged	<= privileged_nx;
			lock		<= lock_nx;
			load_type	<= load_type_nx;
			vector_fastpath	<= vector_fastpath_nx;
			dep		<= dep_nx;
			dep_id		<= dep_id_nx;
			req_id		<= req_id_nx;
			atomic_store	<= atomic_store_nx;
			cctl_lock	<= cctl_lock_nx;
			device		<= device_nx;
		end
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			fb_entry_id <= 4'b0;
		else if (mshr_entry_alloc[i] && mshr_alloc_cache_fill)
			fb_entry_id <= alloc_fb_fifo_rdata;
	end
	//ctw
	assign ctw_nx = mshr_entry_alloc[i] ? mshr_alloc_ctw : ctw_incr;
	assign ctw_incr = ctw + const_1[MSHR_CTW_WIDTH-1:0];
	assign ctw_en = mshr_entry_alloc[i] | biu_rdata_matching_fill;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			ctw <= {MSHR_CTW_WIDTH{1'b0}};
		else if (ctw_en)
			ctw <= ctw_nx;
	end
	//drdy
	assign drdy_nx = mshr_entry_alloc[i] ?  {MSHR_DRDY_WIDTH{1'b0}} : 
						mshr_load_resp_last ? {MSHR_DRDY_WIDTH{1'b1}} :  drdy_biu_pop_nx;
	assign drdy_en = mshr_entry_alloc[i] | biu_rdata_matching_fill;
	assign drdy_biu_pop_nx = drdy | drdy_ptr;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			drdy <= {MSHR_DRDY_WIDTH{1'b0}};
		else if (drdy_en)
			drdy <= drdy_nx;
	end
	assign drdy_ptr_nx = mshr_entry_alloc[i] ? drdy_ptr_init : drdy_ptr_biu_pop_nx[MSHR_DRDY_WIDTH-1:0];
	assign drdy_ptr_en = mshr_entry_alloc[i] | biu_rdata_matching_fill;
	assign drdy_ptr_init_dec = drdy_ptr_dec(addr_nx[5:2]);
	assign drdy_ptr_init = drdy_ptr_init_dec[DRDY_PTR_DEC_MSB:DRDY_PTR_DEC_LSB];
	assign drdy_ptr_8b = {{(8-MSHR_DRDY_WIDTH){1'b0}}, drdy_ptr};
	assign drdy_ptr_biu_pop_nx = (MSHR_DRDY_WIDTH == 8) ? {drdy_ptr_8b[6:0],drdy_ptr_8b[MSHR_DRDY_WIDTH-1]}        :
				     (MSHR_DRDY_WIDTH == 4) ? {4'b0,drdy_ptr_8b[2:0],drdy_ptr_8b[MSHR_DRDY_WIDTH-1]}   :
				     (MSHR_DRDY_WIDTH == 2) ? {6'b0,drdy_ptr_8b[0],drdy_ptr_8b[MSHR_DRDY_WIDTH-1]}     :
				     			      {8{drdy_ptr_8b[0]}};
		
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			drdy_ptr <= {MSHR_DRDY_WIDTH{1'b0}};
		else if (drdy_ptr_en)
			drdy_ptr <= drdy_ptr_nx;
	end
	//Error, for cache fill only
	assign error_en = mshr_entry_alloc[i] | (biu_rdata_matching_fill & ~error); 
	assign error_nx = mshr_entry_alloc[i] ? 1'b0 : mshr_load_resp_read_error;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			error <= 1'b0;
		else if (error_en)
			error <= error_nx;
	end
	//Length
	//Set while allocated, decrease while data return
	//also use as mshr retire condition
	assign length_en = mshr_entry_alloc[i] | dq_rdata_matching | biu_rdata_matching_fill;
	assign length_decrease = length - {3'b0,1'b1};
	assign length_nx = (mshr_entry_alloc[i] & mshr_alloc_cache_fill)  ? BURST_LENGTH[3:0] :
		            mshr_entry_alloc[i] 			  ? mshr_alloc_length : length_decrease;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			length <= 4'b0;
		else if (length_en)
			length <= length_nx;
	end
	//latch_data_en
	//Set while allocated and without dep
	//If with dep, set while the dep entry is retire (no need grant)
	//Clr while the entry is retire (no need grant)
	assign latch_data_en_nx = (latch_data_en_set | latch_data_en) & ~latch_data_en_clr;
	assign latch_data_en_en = latch_data_en_set | latch_data_en_clr;
	assign latch_data_en_set = (mshr_entry_alloc[i] & ~(mshr_alloc_dep & ~(mshr_rdata_last[dep_id_nx] | mshr_rdata_done[dep_id_nx]))) | 
				   ((mshr_state[i] != MSHR_INVALID_STATE) & dq_dep_rdata_last_matching & dep & ~cache_fill) | 
				   ((mshr_state[i] != MSHR_INVALID_STATE) & biu_dep_rdata_last_matching & dep & cache_fill) ;
	assign latch_data_en_clr = dq_rdata_last_matching | biu_rdata_last_match_fill | (mshr_entry_retire[i] && mshr_entry_retire_grant[i]);
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			latch_data_en <= 1'b0;
		else if (latch_data_en_en)
			latch_data_en <= latch_data_en_nx;
	end
	//rsnoop
	assign rsnoop_nx = rsnoop_set | (rsnoop & ~rsnoop_clr);
	assign rsnoop_set = biu_rdata_matching_fill & mshr_load_resp_rsnoop[0] & ~rsnoop;
        assign rsnoop_clr = mshr_entry_alloc[i];	
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			rsnoop <= 1'b0;
		else
			rsnoop <= rsnoop_nx;
	end
	//biu_req_done
	assign biu_req_done_nx  = (biu_req_done_set | biu_req_done) & ~biu_req_done_clr;
	assign biu_req_done_en  = biu_req_done_set | biu_req_done_clr;
	assign biu_req_done_set = (mshr_entry_alloc[i] & mshr_alloc_pure_evict) | 
		                  (mshr_load_biu_req[i] & mshr_load_biu_grant[i]);
	assign biu_req_done_clr = mshr_entry_retire[i] && mshr_entry_retire_grant[i];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			biu_req_done <= 1'b0;
		else if (biu_req_done_en)
			biu_req_done <= biu_req_done_nx;
	end
	//biu_rdata_done
	assign biu_rdata_done_nx  = biu_rdata_done_set | (biu_rdata_done & ~biu_rdata_done_clr);
	assign biu_rdata_done_set = biu_rdata_last_match_fill | dq_rdata_last_matching | 
		                    (mshr_entry_alloc[i] & mshr_alloc_pure_evict) | 
				    (atomic_store & mshr_load_biu_req[i] & mshr_load_biu_grant[i]);
	assign biu_rdata_done_clr = mshr_entry_retire[i] && mshr_entry_retire_grant[i];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			biu_rdata_done <= 1'b0;
		else
			biu_rdata_done <= biu_rdata_done_nx;
	end
	assign mshr_rdata_last[i] = biu_rdata_last_match_fill | dq_rdata_last_matching;
	//state
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			state_cs[i] <= MSHR_INVALID_STATE;
		end
		else begin
			state_cs[i] <= st_ns;
		end
	end
	//Vector Fastpath confirm
	assign vec_fp_confirmed_nx  = (vec_fp_confirmed_set | vec_fp_confirmed) & ~vec_fp_confirmed_clr;
	assign vec_fp_confirmed_set = (mshr_vector_fastpath_confirm & (mshr_vector_fastpath_confirm_mshr_entry_id == mshr_entry_id[i])) |
		                      (mshr_entry_alloc[i] & mshr_alloc_vector_fastpath & (mshr_alloc_uncache_vector_unalign_second | mshr_alloc_vec_fp_confirmed));
        assign vec_fp_confirmed_clr = mshr_entry_alloc[i] & ~mshr_alloc_uncache_vector_unalign_second & ~mshr_alloc_vec_fp_confirmed;	
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			vec_fp_confirmed <= 1'b0;
		else
			vec_fp_confirmed <= vec_fp_confirmed_nx;
	end
	//MSHR FSM
	always @* begin
		case(state_cs[i])
			MSHR_INVALID_STATE: begin 
				if (mshr_entry_alloc[i] & ~mshr_alloc_pure_evict)
					state_ns[i] = MSHR_PENDING_STATE;
				else
					state_ns[i] = MSHR_INVALID_STATE;
			end
			MSHR_PENDING_STATE: begin
				if (mshr_load_biu_grant[i])
					state_ns[i] = MSHR_ISSUE_STATE;
				else
					state_ns[i] = MSHR_PENDING_STATE;
			end
			MSHR_ISSUE_STATE: begin
				if (atomic_store)
					state_ns[i] = MSHR_INVALID_STATE;
				else if (biu_rdata_matching_fill | dq_rdata_matching)
					state_ns[i] = MSHR_FILL_STATE;
				else
					state_ns[i] = MSHR_ISSUE_STATE;
			end
			MSHR_FILL_STATE: begin
				if (mshr_entry_retire[i] && mshr_entry_retire_grant[i])
					state_ns[i] = MSHR_INVALID_STATE;
				else
					state_ns[i] = MSHR_FILL_STATE;
			end
`ifdef WITH_COV
// pragma coverage off
`endif // WITH_COV
		default : state_ns[i] = 2'bx;
`ifdef WITH_COV
// pragma coverage on
`endif // WITH_COV
		endcase
	end

	//Cache fill tag done
	assign cache_fill_tag_done_nx  = cache_fill_tag_done_set | (cache_fill_tag_done & ~cache_fill_tag_done_clr);
	assign cache_fill_tag_done_en  = cache_fill_tag_done_set | cache_fill_tag_done_clr;
	assign cache_fill_tag_done_set = mshr_tag_req[i] & mshr_tag_req_grant[i]; 
	assign cache_fill_tag_done_clr = (mshr_entry_alloc[i] & mshr_alloc_cache_fill) | 
					 (mshr_entry_retire[i] & mshr_entry_retire_grant[i]);
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			cache_fill_tag_done <= 1'b0;
		else if (cache_fill_tag_done_en)	
			cache_fill_tag_done <= cache_fill_tag_done_nx;
	end

	assign mshr_fill_tag_state		= error ? INVALID:
						  rsnoop ? SHARE : EXCLUSIVE;
					
	assign mshr_fill_tag_lock		= error ? 1'b0: cctl_lock;
	assign mshr_tag_req[i]			= biu_rdata_done & cache_fill & ~cache_fill_tag_done;
	assign mshr_tag_addr[i]			= addr[INDEX_MSB:INDEX_LSB];
	assign mshr_tag_wdata[i]		= {mshr_fill_tag_state,mshr_fill_tag_lock,addr[TAG_MSB:TAG_LSB]};

	//Cache_fill data done
	assign cache_fill_data_done_nx  = cache_fill_data_done_set | (cache_fill_data_done & ~cache_fill_data_done_clr);
	assign cache_fill_data_done_en  = cache_fill_data_done_set | cache_fill_data_done_clr;
	assign cache_fill_data_done_set = (mshr_data_req[i] & mshr_data_req_grant[i] & (cache_fill_data_offset == OFFSET_CNT_LAST[OFFSET_WIDTH-1:0])) | 
					  (biu_rdata_matching_fill & mshr_load_resp_read_error); //Error not filling DATA RAM
	assign cache_fill_data_done_clr = (mshr_entry_alloc[i] & mshr_alloc_cache_fill)      | 
					  (mshr_entry_retire[i] & mshr_entry_retire_grant[i]);
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			cache_fill_data_done <= 1'b0;
		else if (cache_fill_data_done_en)	
			cache_fill_data_done <= cache_fill_data_done_nx;
	end
	
	assign cache_fill_data_offset_en = (mshr_entry_alloc[i] & mshr_alloc_cache_fill) | 
					   (mshr_data_req[i] & mshr_data_req_grant[i]);
	assign cache_fill_data_offset_nx = (mshr_entry_alloc[i] & mshr_alloc_cache_fill) ? {OFFSET_WIDTH{1'b0}} : cache_fill_data_offset_incr;
	assign cache_fill_data_offset_incr = cache_fill_data_offset + {{(OFFSET_WIDTH-1){1'b0}},1'b1};

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			cache_fill_data_offset <= {OFFSET_WIDTH{1'b0}};
		else if (cache_fill_data_offset_en)
			cache_fill_data_offset <= cache_fill_data_offset_nx;
	end

	assign fill_done_to_lsu_complete_nx  = fill_done_to_lsu_complete_set | (fill_done_to_lsu_complete & ~fill_done_to_lsu_complete_clr);
	assign fill_done_to_lsu_complete_set = mshr_entry_fill_done[i] & mshr_fill_done_grant[i];
	assign fill_done_to_lsu_complete_clr = (mshr_entry_retire[i] & mshr_entry_retire_grant[i]);

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			fill_done_to_lsu_complete <= 1'b0;
		else
			fill_done_to_lsu_complete <= fill_done_to_lsu_complete_nx;	
	end

	assign sub_block_has_dest_to_sb		= |(sub_block_valid & sub_block_dest_to_sb);
	assign mshr_entry_fill_done[i] 		= (cache_fill & cache_fill_data_done & cache_fill_tag_done & ~fill_done_to_lsu_complete & ~sub_block_has_dest_to_sb);
	assign mshr_entry_fill_abort[i]		= mshr_entry_fill_done[i] ? error : 1'b0;

	assign mshr_data_req[i] 	= biu_rdata_done & cache_fill & ~cache_fill_data_done & (~eb_valid | eb_rd_data_done); 
	assign mshr_data_index[i]	= addr[INDEX_MSB:INDEX_LSB];
	assign mshr_data_offset[i]	= cache_fill_data_offset;

	assign mshr_pending_state		= (st_cs == MSHR_PENDING_STATE);
	assign mshr_load_biu_req[i]		= mshr_pending_state  & (vec_fp_confirmed | ~vector_fastpath);

	assign mshr_entry_retire[i]		= biu_rdata_done & 												// read data all come back from bus
						  ~(|sub_block_valid) & 											// no pending sub_block (all required data had return to LSU)
						  (~cache_fill | (cache_fill & cache_fill_data_done & cache_fill_tag_done & fill_done_to_lsu_complete)) & 	// no cache_fill (uncache or device) or cache_fill and had done fill tag ram and data ram
						  (~eb_valid | (eb_valid & eb_evict_req_done & eb_wr_data_done));						// no eviction or had eviction and had done sending request and data  
					  		// TBD, pure eviction ( CCTL) and uncache atomic store


	assign mshr_state[i]			= st_cs;         	
	assign mshr_addr[i]			= addr;          	
	assign mshr_ctw[i]			= ctw;           	
	assign mshr_drdy[i]			= drdy;          	
	assign mshr_mem_attri[i]		= mem_attri;     	
	assign mshr_error[i]			= error;         	
	assign mshr_cache_fill[i]		= cache_fill;    	
	assign mshr_way[i]			= way;           	
	assign mshr_size[i]			= size;          	
	assign mshr_privileged[i]		= privileged;    	
	assign mshr_length[i]			= length;        	
	assign mshr_lock[i]			= lock;          	
	assign mshr_type[i]			= load_type;          	
	assign mshr_vector_fastpath[i]		= vector_fastpath;	
	assign mshr_latch_data_en[i]		= latch_data_en; 	
	assign mshr_req_id[i]			= req_id;
	assign mshr_entry_id[i] 		= i[3:0];
	assign mshr_atomic_store[i]		= atomic_store;
	assign mshr_blocking[i]			= sub_block_blocking[sub_block_lsu_req_arb_grant];
	assign mshr_blocking_been_kill[i]	= sub_block_blocking_been_killed[sub_block_lsu_req_arb_grant];
	assign mshr_entry_issue_done[i]		= (biu_req_done & (~eb_valid | eb_wr_data_done)) | (mshr_entry_retire[i] && mshr_entry_retire_grant[i] && atomic_store) ;
        assign mshr_entry_cache_fill_done[i]	= cache_fill_data_done;
	assign mshr_rdata_done[i]		= biu_rdata_done;
	assign mshr_device[i]			= device;
	assign mshr_fb_entry_id[i]		= fb_entry_id;

	assign mshr_sub_block_rdata[i] 		= fb_sub_block_rdata[fb_entry_id];
	assign mshr_sub_block_error[i]		= fb_sub_block_error[fb_entry_id];
	assign mshr_sub_block_lock_fail[i]	= fb_sub_block_lock_fail[fb_entry_id];
	assign mshr_data_wdata[i]      		= fb_fill_wdata[fb_entry_id];
	assign dcu_dphase_lookup_mshr_data[i] 	= fb_dcu_lookup_mshr_data[fb_entry_id];

	for (m=0;m<MSHR_SUB_BLOCK_DEPTH;m=m+1) begin : gen_sub_blk_alloc
		wire [2:0] sub_block_index = m[2:0];
		if (m == 0) begin : gen_sub_block_alloc_entry0
			assign sub_block_alloc[m] = (mshr_sub_block_alloc[i] & (sub_block_index == sub_block_alloc_ptr)) | (mshr_entry_alloc[i] & ~(mshr_alloc_pure_evict | mshr_alloc_atomic_store));
		end
		else begin : gen_sub_block_alloc_other_entry
			assign sub_block_alloc[m] = mshr_sub_block_alloc[i] & (sub_block_index == sub_block_alloc_ptr);
		end
	end
	always @* begin
		casez(sub_block_valid)
		8'b???????0: sub_block_alloc_ptr = 3'd0;
		8'b??????01: sub_block_alloc_ptr = 3'd1;
		8'b?????011: sub_block_alloc_ptr = 3'd2;
		8'b????0111: sub_block_alloc_ptr = 3'd3;
		8'b???01111: sub_block_alloc_ptr = 3'd4;
		8'b??011111: sub_block_alloc_ptr = 3'd5;
		8'b?0111111: sub_block_alloc_ptr = 3'd6;
		8'b01111111: sub_block_alloc_ptr = 3'd7;
		default: sub_block_alloc_ptr = 3'd0;
		endcase
	end
	assign sub_block_has_blocking_req = (|(sub_block_blocking & sub_block_valid));	
	assign sub_block_lsu_req =  sub_block_has_blocking_req ? (sub_block_blocking & sub_block_valid & sub_block_data_ready) : (sub_block_valid & sub_block_data_ready);
	assign sub_block_lsu_req_arb_in = sub_block_lsu_req;
	always @* begin
		casez(sub_block_lsu_req_arb_in)
		8'b???????1 : sub_block_lsu_req_arb_grant = 3'd0;
		8'b??????10 : sub_block_lsu_req_arb_grant = 3'd1;
		8'b?????100 : sub_block_lsu_req_arb_grant = 3'd2;
		8'b????1000 : sub_block_lsu_req_arb_grant = 3'd3;
		8'b???10000 : sub_block_lsu_req_arb_grant = 3'd4;
		8'b??100000 : sub_block_lsu_req_arb_grant = 3'd5;
		8'b?1000000 : sub_block_lsu_req_arb_grant = 3'd6;
		8'b10000000 : sub_block_lsu_req_arb_grant = 3'd7;
		default : sub_block_lsu_req_arb_grant = 3'd0;
		endcase
	end
	assign sub_block_lsu_req_ext_grant[0]	= sub_block_lsu_req_arb_in[0] & mshr_sub_block_lsu_req_grant[i] & (sub_block_lsu_req_arb_grant == 3'd0);
	assign sub_block_lsu_req_ext_grant[1]	= sub_block_lsu_req_arb_in[1] & mshr_sub_block_lsu_req_grant[i] & (sub_block_lsu_req_arb_grant == 3'd1);
	assign sub_block_lsu_req_ext_grant[2]	= sub_block_lsu_req_arb_in[2] & mshr_sub_block_lsu_req_grant[i] & (sub_block_lsu_req_arb_grant == 3'd2);
	assign sub_block_lsu_req_ext_grant[3]	= sub_block_lsu_req_arb_in[3] & mshr_sub_block_lsu_req_grant[i] & (sub_block_lsu_req_arb_grant == 3'd3);
	assign sub_block_lsu_req_ext_grant[4]	= sub_block_lsu_req_arb_in[4] & mshr_sub_block_lsu_req_grant[i] & (sub_block_lsu_req_arb_grant == 3'd4);
	assign sub_block_lsu_req_ext_grant[5]	= sub_block_lsu_req_arb_in[5] & mshr_sub_block_lsu_req_grant[i] & (sub_block_lsu_req_arb_grant == 3'd5);
	assign sub_block_lsu_req_ext_grant[6]	= sub_block_lsu_req_arb_in[6] & mshr_sub_block_lsu_req_grant[i] & (sub_block_lsu_req_arb_grant == 3'd6);
	assign sub_block_lsu_req_ext_grant[7]	= sub_block_lsu_req_arb_in[7] & mshr_sub_block_lsu_req_grant[i] & (sub_block_lsu_req_arb_grant == 3'd7);

	assign sub_block_lsu_req_grant = sub_block_lsu_req_ext_grant;

	assign mshr_sub_block_lsu_req[i]		= |sub_block_lsu_req[MSHR_SUB_BLOCK_DEPTH-1:0];
	assign mshr_sub_block_dest_idx[i]		= sub_block_rf_index[sub_block_lsu_req_arb_grant];
	assign mshr_sub_block_dest_to_vrf[i]		= sub_block_dest_to_vrf[sub_block_lsu_req_arb_grant];
	assign mshr_sub_block_dest_to_frf[i]		= sub_block_dest_to_frf[sub_block_lsu_req_arb_grant];
	assign mshr_sub_block_dest_to_xrf[i]		= sub_block_dest_to_xrf[sub_block_lsu_req_arb_grant];
	assign mshr_sub_block_dest_to_sb[i]		= sub_block_dest_to_sb[sub_block_lsu_req_arb_grant];
	assign mshr_sub_block_offset[i]			= sub_block_offset[sub_block_lsu_req_arb_grant];
	assign mshr_sub_block_size[i]			= sub_block_size[sub_block_lsu_req_arb_grant];
	assign mshr_sub_block_func[i]			= sub_block_func[sub_block_lsu_req_arb_grant];
	assign mshr_sub_block_ctw[i]			= sub_block_sub_ctw[sub_block_lsu_req_arb_grant];
	assign mshr_sub_block_full[i]			= &sub_block_valid[MSHR_SUB_BLOCK_DEPTH-1:0];
	//Sub_block
	for (j=0; j<MSHR_SUB_BLOCK_DEPTH;j=j+1) begin : gen_sub_block
		reg  [LS_DEST_BITS-1:0]		rf_index;
		wire 				rf_index_en;
		wire [LS_DEST_BITS-1:0]		rf_index_nx;
		wire [LS_DEST_BITS-1:0]		rf_index_increase;
		
		reg 				dest_to_vrf;
		reg 				dest_to_frf;
		reg 				dest_to_xrf;
		reg 				dest_to_sb;
		reg [MSHR_CTW_WIDTH-1:0]	sub_ctw;
		reg [5:0]			offset;
		reg [2:0]			size;
		reg [2:0]			func;
		
		reg 				valid;
		wire				valid_nx;
		wire				valid_clr;
		wire				valid_set;
		wire				valid_en;

		wire 				data_ready;
		reg				blocking;
		reg				blocking_been_kill;
		wire				blocking_been_kill_en;
		wire				blocking_been_kill_nx;	
		//Latch while alloc, increase for uncache while pop from DQ
		assign rf_index_en = sub_block_alloc[j] | dq_rdata_matching;
		assign rf_index_nx = sub_block_alloc[j] ? mshr_alloc_dest_index : rf_index_increase;
		assign rf_index_increase = rf_index + {{(LS_DEST_BITS-1){1'b0}},1'b1};
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n) 
				rf_index 	<= {LS_DEST_BITS{1'b0}};
			else if (rf_index_en) 
				rf_index 	<= rf_index_nx;
		end
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n) 
				dest_to_vrf	<= 1'b0;
			else if (sub_block_alloc[j]) 
				dest_to_vrf	<= mshr_alloc_dest_vrf;
		end
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n) 
				dest_to_frf	<= 1'b0;
			else if (sub_block_alloc[j]) 
				dest_to_frf	<= mshr_alloc_dest_frf;
		end
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n) 
				dest_to_xrf	<= 1'b0;
			else if (sub_block_alloc[j]) 
				dest_to_xrf	<= mshr_alloc_dest_xrf;
		end
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n) 
				dest_to_sb	<= 1'b0;
			else if (sub_block_alloc[j]) 
				dest_to_sb	<= mshr_alloc_dest_sb;
		end
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n) 
				sub_ctw		<= {MSHR_CTW_WIDTH{1'b0}};
			else if (sub_block_alloc[j]) 
				sub_ctw		<= mshr_alloc_ctw;
		end
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n) 
				offset		<= 6'b0;
			else if (sub_block_alloc[j]) 
				offset		<= mshr_alloc_addr[5:0];
		end
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n) 
				size		<= 3'b0;
			else if (sub_block_alloc[j]) 
				size		<= mshr_alloc_size;
		end
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n) 
				func		<= 3'b0;
			else if (sub_block_alloc[j]) 
				func		<= mshr_alloc_func;
		end
		//valid
		//set when alloc
		//clr when LSU take sub_block data or device/uncache data
		//return from biu
		assign valid_en = valid_set | valid_clr;
		assign valid_nx = valid_set | (valid & ~valid_clr);
		assign valid_set = sub_block_alloc[j];
		assign valid_clr = dq_rdata_last_matching | sub_block_lsu_req_grant[j];
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n)
				valid <= 1'b0;
			else if (valid_en)
				valid <= valid_nx;
		end
		//data_ready
		assign data_ready = drdy[sub_ctw];
		//Blocking been killed
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n)
				blocking <= 1'b0;
			else if (sub_block_alloc[j]) 
				blocking <= mshr_alloc_blocking;
		end
		assign blocking_been_kill_en = (valid & lsu_kill & blocking) | (mshr_entry_retire[i] & mshr_entry_retire_grant[i]);
		assign blocking_been_kill_nx = (mshr_entry_retire[i] & mshr_entry_retire_grant[i]) ? 1'b0 : 1'b1;
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n)
				blocking_been_kill 	<= 1'b0;
			else if (blocking_been_kill_en)
				blocking_been_kill 	<= blocking_been_kill_nx;
		end


		assign sub_block_valid[j]		 = valid;
		assign sub_block_rf_index[j]		 = rf_index;
		assign sub_block_dest_to_vrf[j]		 = dest_to_vrf;
		assign sub_block_dest_to_frf[j]		 = dest_to_frf;
		assign sub_block_dest_to_xrf[j]		 = dest_to_xrf;
		assign sub_block_dest_to_sb[j]		 = dest_to_sb;
		assign sub_block_sub_ctw[j]		 = sub_ctw;
		assign sub_block_data_ready[j]		 = data_ready;
		assign sub_block_offset[j]		 = offset;
		assign sub_block_size[j]		 = size; 
		assign sub_block_func[j]		 = func; 
		assign sub_block_blocking[j]		 = blocking;
		assign sub_block_blocking_been_killed[j] = blocking_been_kill;
	end
	for (jj=MSHR_SUB_BLOCK_DEPTH; jj<8;jj=jj+1) begin : gen_unused_sub_block
		assign sub_block_valid[jj]		 = 1'b0;
		assign sub_block_rf_index[jj]		 = {LS_DEST_BITS{1'b0}};
		assign sub_block_dest_to_vrf[jj]	 = 1'b0;
		assign sub_block_dest_to_frf[jj]	 = 1'b0;
		assign sub_block_dest_to_xrf[jj]	 = 1'b0;
		assign sub_block_dest_to_sb[jj]		 = 1'b0;
		assign sub_block_sub_ctw[jj]		 = {MSHR_CTW_WIDTH{1'b0}};
		assign sub_block_data_ready[jj]		 = 1'b0;
		assign sub_block_offset[jj]		 = 6'b0;
		assign sub_block_size[jj]		 = 3'b0; 
		assign sub_block_func[jj]		 = 3'b0; 
		assign sub_block_blocking[jj]		 = 1'b0;
		assign sub_block_blocking_been_killed[jj] = 1'b0;
	end

	//Eviction buffer
	//eb_valid
	assign mshr_alloc_eb = mshr_entry_alloc[i] & mshr_alloc_evict;

	assign eb_valid_nx = eb_valid_set | (eb_valid & ~eb_valid_clr);
	assign eb_valid_set= mshr_alloc_eb;
	assign eb_valid_clr= mshr_entry_retire[i] & mshr_entry_retire_grant[i];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_valid <= 1'b0;
		else
			eb_valid <= eb_valid_nx;
	end
	//Replacement valid
	assign replace_valid_nx = replace_valid_set | (replace_valid & ~replace_valid_clr);
	assign replace_valid_set= mshr_entry_alloc[i] & mshr_alloc_replace;
	//assign replace_valid_clr= mshr_entry_retire[i] & mshr_entry_retire_grant[i];
	assign replace_valid_clr = mshr_tag_req[i] & mshr_tag_req_grant[i];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			replace_valid <= 1'b0;
		else
			replace_valid <= replace_valid_nx;
	end

	//eb_tag
	assign eb_tag_en = mshr_entry_alloc[i] & (mshr_alloc_evict | mshr_alloc_replace);
	assign eb_tag_nx = mshr_alloc_evict_tag;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_tag <= {TAG_DW{1'b0}};
		else if (eb_tag_en)
			eb_tag <= eb_tag_nx;
	end
	//eb_fetch_cnt
	assign eb_fetch_cnt_en = eb_fetch_cnt_incr | eb_fetch_cnt_reset;
        assign eb_fetch_cnt_nx = eb_fetch_cnt_reset ? {MSHR_CTW_WIDTH{1'b0}} : eb_fetch_cnt + const_1[MSHR_CTW_WIDTH-1:0];
        assign eb_fetch_cnt_incr = eb_fetch_req & mshr_evict_fetch_grant[i];
        assign eb_fetch_cnt_reset = mshr_entry_retire[i] & mshr_entry_retire_grant[i];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_fetch_cnt <= {MSHR_CTW_WIDTH{1'b0}};
		else if (eb_fetch_cnt_en)
			eb_fetch_cnt <= eb_fetch_cnt_nx;
	end
	//eb_rdata_cnt
	assign eb_rdata_cnt_en = eb_rdata_cnt_incr | eb_rdata_cnt_reset;
        assign eb_rdata_cnt_nx = eb_rdata_cnt_reset ? {MSHR_CTW_WIDTH{1'b0}} : eb_rdata_cnt + const_1[MSHR_CTW_WIDTH-1:0];
        assign eb_rdata_cnt_incr = mshr_evict_data_resp[i];
        assign eb_rdata_cnt_reset = mshr_entry_retire[i] & mshr_entry_retire_grant[i];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_rdata_cnt <= {MSHR_CTW_WIDTH{1'b0}};
		else if (eb_rdata_cnt_en)
			eb_rdata_cnt <= eb_rdata_cnt_nx;
	end
	assign eb_rdata_full_set = mshr_evict_data_resp[i] & (eb_rdata_cnt == EB_CNT_LAST[MSHR_CTW_WIDTH-1:0]);
	assign eb_rdata_full_clr = mshr_entry_retire[i] & mshr_entry_retire_grant[i];
	assign eb_rdata_full_nx  = eb_rdata_full_set | (eb_rdata_full & ~eb_rdata_full_clr);
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_rdata_full <= 1'b0;
		else
			eb_rdata_full <= eb_rdata_full_nx;
	end
	//eb_biu_cnt
	assign eb_biu_cnt_en = eb_biu_cnt_reset | eb_biu_cnt_incr;
	assign eb_biu_cnt_reset =  mshr_entry_retire[i] & mshr_entry_retire_grant[i];
	assign eb_biu_cnt_incr = mshr_evict_biu_req_data_valid[i] & mshr_evict_biu_req_data_ack[i];
        assign eb_biu_cnt_nx = eb_biu_cnt_reset ? {MSHR_CTW_WIDTH{1'b0}} : eb_biu_cnt + const_1[MSHR_CTW_WIDTH-1:0];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_biu_cnt <= {MSHR_CTW_WIDTH{1'b0}};
		else if (eb_biu_cnt_en)
			eb_biu_cnt <= eb_biu_cnt_nx;
	end
	//eb_rd_rdata_done
	assign eb_rd_data_done_nx  = eb_rd_data_done_set | (eb_rd_data_done & ~eb_rd_data_done_clr);
	assign eb_rd_data_done_set = eb_fetch_req & mshr_evict_fetch_grant[i] & (eb_fetch_cnt == EB_CNT_LAST[MSHR_CTW_WIDTH-1:0]);
	assign eb_rd_data_done_clr = mshr_entry_retire[i] & mshr_entry_retire_grant[i];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_rd_data_done 	<= 1'b0;
		else 
			eb_rd_data_done 	<= eb_rd_data_done_nx;
	end
	//eb_evict_req_en
	assign eb_evict_req_en_nx  = eb_evict_req_en_set | (eb_evict_req_en & ~eb_evict_req_en_clr);
	//assign eb_evict_req_en_set = eb_fetch_req & mshr_evict_fetch_grant[i] & (eb_fetch_cnt == {MSHR_CTW_WIDTH{1'b0}});
	assign eb_evict_req_en_set = mshr_evict_data_resp[i] & ((eb_empty & (MSHR_EVICT_MODE == "fast")) | ((MSHR_EVICT_MODE == "slow") & (eb_rdata_cnt == EB_CNT_LAST[MSHR_CTW_WIDTH-1:0])));
	assign eb_evict_req_en_clr = mshr_entry_retire[i] & mshr_entry_retire_grant[i];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_evict_req_en <= 1'b0;
		else
			eb_evict_req_en <= eb_evict_req_en_nx;
	end
	//eb_evict_req_done
	assign eb_evict_req_done_nx  = eb_evict_req_done_set | (eb_evict_req_done & ~eb_evict_req_done_clr);
	assign eb_evict_req_done_set = mshr_evict_biu_req[i] & mshr_evict_biu_req_grant[i];
	assign eb_evict_req_done_clr = mshr_entry_retire[i] & mshr_entry_retire_grant[i];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_evict_req_done <= 1'b0;
		else
			eb_evict_req_done <= eb_evict_req_done_nx;
	end
	//eb_wr_data_done
	assign eb_wr_data_done_nx  = eb_wr_data_done_set | (eb_wr_data_done & ~eb_wr_data_done_clr);
	assign eb_wr_data_done_set = mshr_evict_biu_req_data_valid[i] & mshr_evict_biu_req_last[i] & mshr_evict_biu_req_data_ack[i];
	assign eb_wr_data_done_clr = mshr_entry_retire[i] & mshr_entry_retire_grant[i];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_wr_data_done <= 1'b0;
		else
			eb_wr_data_done <= eb_wr_data_done_nx;
	end
		


	assign eb_fetch_req = eb_valid & ~eb_rd_data_done;

	assign eb_push = mshr_evict_data_resp[i] & ~eb_rdata_full;
	assign eb_pop = ~eb_empty & mshr_evict_biu_req_data_ack[i];	

	assign mshr_evict_biu_req[i]	  	= eb_valid & eb_evict_req_en & ~eb_evict_req_done;
	assign mshr_evict_biu_req_addr[i] 	= {eb_tag,addr[INDEX_MSB:INDEX_LSB],{OFFSET_WIDTH{1'b0}},{(OFFSET_LSB){1'b0}}};
	assign mshr_evict_biu_req_data_valid[i] = ~eb_empty & eb_evict_req_en;
	assign mshr_evict_biu_req_last[i] 	= (eb_biu_cnt == EB_CNT_LAST[MSHR_CTW_WIDTH-1:0]);

	assign mshr_evict_fetch_req[i] 				= eb_fetch_req;
	assign mshr_evict_fetch_index[i] 			= addr[INDEX_MSB:INDEX_LSB];
	assign mshr_evict_fetch_offset[i][MSHR_CTW_WIDTH-1:0] 	= eb_fetch_cnt;
	assign mshr_evict_fetch_way[i] 				= way;

	assign mshr_eb_valid[i]			= eb_valid;
	assign mshr_replace_valid[i]		= replace_valid;
	assign mshr_eb_tag[i]			= eb_tag;
	assign mshr_eb_push[i]			= eb_push;	
	assign mshr_eb_pop[i]			= eb_pop;
	assign eb_empty				= mshr_eb_empty[i];
		
end
endgenerate

genvar ii;
generate
if (OFFSET_WIDTH != MSHR_CTW_WIDTH) begin: gen_redundant_mshr_evict_fetch_offset
	for (ii = 0; ii < MSHR_DEPTH;ii = ii + 1) begin : gen_mshr_evict_fetch_offset
		assign mshr_evict_fetch_offset[ii][OFFSET_WIDTH-1:MSHR_CTW_WIDTH] 	= {(OFFSET_WIDTH-MSHR_CTW_WIDTH){1'b0}};
	end
end
endgenerate
genvar uu;
generate
for (uu = MSHR_DEPTH; uu < 16; uu = uu + 1 ) begin : gen_unused_mshr_info
	assign mshr_sub_block_full[uu] 		= 1'b0;
        assign dq_rdata_match_mshr[uu] 		= 1'b0;
	assign mshr_latch_data_en[uu] 		= 1'b0;
	assign mshr_length[uu]			= 4'b0;
	assign mshr_cache_fill[uu]		= 1'b0;
	assign mshr_fb_entry_id[uu]		= 4'b0;
	assign mshr_entry_fill_abort[uu]	= 1'b0;
	assign mshr_way[uu]			= 4'b0;
	assign mshr_entry_cache_fill_done[uu] 	= 1'b0;
	assign mshr_drdy[uu]			= {MSHR_DRDY_WIDTH{1'b0}};
	assign mshr_lock[uu]			= 1'b0;
	assign dcu_dphase_lookup_mshr_data[uu]  = {BIU_DATA_WIDTH{1'b0}};
        assign mshr_entry_retire[uu]		= 1'b0;
	assign biu_rdata_match_mshr[uu]		= 1'b0;
	assign mshr_rdata_last[uu]		= 1'b0;
	assign mshr_rdata_done[uu]		= 1'b0;
	assign mshr_sub_block_rdata[uu]		= {BIU_DATA_WIDTH{1'b0}};
	assign mshr_addr[uu]			= {BIU_ADDR_WIDTH{1'b0}};
	assign mshr_eb_push[uu]			= 1'b0;
	assign mshr_eb_pop[uu]			= 1'b0;
	assign mshr_sub_block_ctw[uu]		= {MSHR_CTW_WIDTH{1'b0}};
        assign mshr_data_offset[uu]		= {OFFSET_WIDTH{1'b0}};
	assign mshr_entry_retire_grant[uu]	= 1'b0;
	assign mshr_ctw[uu]			= {MSHR_CTW_WIDTH{1'b0}};
	assign mshr_sub_block_dest_idx[uu]	= {LS_DEST_BITS{1'b0}};		
	assign mshr_sub_block_dest_to_vrf[uu]	= 1'b0;
	assign mshr_sub_block_dest_to_frf[uu]	= 1'b0;
	assign mshr_sub_block_dest_to_xrf[uu]	= 1'b0;
	assign mshr_sub_block_dest_to_sb[uu]	= 1'b0; 
	assign mshr_sub_block_offset[uu]	= 6'b0;     
	assign mshr_sub_block_size[uu]		= 3'b0;       
	assign mshr_sub_block_func[uu]		= 3'b0;       
	assign mshr_sub_block_error[uu]		= 1'b0;
  	assign mshr_sub_block_lock_fail[uu]	= 1'b0;
	assign mshr_blocking[uu]		= 1'b0;
	assign mshr_blocking_been_kill[uu]	= 1'b0;
	assign mshr_vector_fastpath[uu]		= 1'b0;
	assign mshr_load_biu_req[uu]		= 1'b0;
	assign mshr_size[uu]			= 3'b0;
        assign mshr_mem_attri[uu]		= 4'b0;
	assign mshr_privileged[uu]		= 1'b0;
	assign mshr_atomic_store[uu]		= 1'b0;
	assign mshr_type[uu]			= 3'b0;
	assign mshr_req_id[uu]			= 5'b0;
	assign mshr_evict_biu_req[uu]		= 1'b0;
	assign mshr_evict_biu_req_addr[uu]	= {BIU_ADDR_WIDTH{1'b0}};
	assign mshr_evict_biu_req_last[uu]	= 1'b0;
	assign mshr_evict_biu_req_data_valid[uu]= 1'b0;
	assign mshr_evict_fetch_req[uu]		= 1'b0;
	assign mshr_evict_fetch_way[uu]		= 4'b0;
	assign mshr_evict_fetch_index[uu]	= {DCACHE_TAG_RAM_AW{1'b0}};
	assign mshr_evict_fetch_offset[uu]	= {OFFSET_WIDTH{1'b0}};
	assign mshr_tag_addr[uu]		= {DCACHE_TAG_RAM_AW{1'b0}};
        assign mshr_tag_wdata[uu]		= {MSHR_FILL_TAG_WDATA_WIDTH{1'b0}};
	assign mshr_data_wdata[uu]		= {BIU_DATA_WIDTH{1'b0}};
	assign mshr_data_index[uu]		= {(INDEX_MSB-INDEX_LSB+1){1'b0}};	
		
end
endgenerate


assign eb_fifo_push = mshr_eb_push[mshr_issue_ptr];
assign eb_fifo_pop  = mshr_eb_pop[mshr_issue_ptr];
assign eb_fifo_wdata = mshr_evict_resp_data;

//Eviction buffer
generate
if (CACHE_LINE_BEATS != 1) begin : gen_eb_fifo_biu_not_single_beat
	nds_sync_fifo_ll #(.DATA_WIDTH		(BIU_DATA_WIDTH		),
		   	   .FIFO_DEPTH		(CACHE_LINE_BEATS	),
		   	   .POINTER_INDEX_WIDTH (EB_FIFO_IDX_WIDTH	)
		  ) eb_fifo    (  .w_reset_n	(reset_n	 ),
				  .r_reset_n	(reset_n	 ),
				  .w_clk	(clk		 ),
				  .r_clk	(clk		 ),
				  .wr		(eb_fifo_push    ),
				  .wr_data	(eb_fifo_wdata   ),
				  .rd		(eb_fifo_pop	 ),
				  .rd_data	(eb_fifo_rdata   ),
				  .w_clk_empty	(eb_fifo_w_clk_empty   ),
				  .empty	(eb_fifo_empty	 ),
				  .full		(eb_fifo_full)
			       );
end
else begin : gen_eb_fifo_single_beat
	reg [(BIU_DATA_WIDTH-1):0] 	eb_data;
	reg	    			eb_full;
	wire	    			eb_full_set;
	wire	    			eb_full_clr;
	wire	    			eb_full_nx;

	assign eb_full_set = eb_fifo_push;
	assign eb_full_clr = eb_fifo_pop;
	assign eb_full_nx  = eb_full_set | (eb_full & ~eb_full_clr);

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_full <= 1'b0;
		else 
			eb_full <= eb_full_nx;
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			eb_data <= {BIU_DATA_WIDTH{1'b0}};
		else if (eb_fifo_push)
			eb_data <= eb_fifo_wdata;
	end
	assign eb_fifo_empty = ~eb_full;
	assign eb_fifo_rdata = eb_data;
	assign eb_fifo_w_clk_empty = 1'b0;
	assign eb_fifo_full = eb_full;
end
endgenerate


//MSHR DATA block, latch whole cacheline
generate
genvar r;
genvar s;
for (r=0;r<MSHR_FB_DEPTH;r=r+1) begin: gen_mshr_cachable_data_field
	wire [3:0] fb_id = r[3:0];
	reg  [3:0] fb_mshr_entry_id;
	wire	   fb_mshr_entry_id_en;

	reg 	   fb_valid;
	wire 	   fb_valid_set;
	wire 	   fb_valid_clr;
	wire 	   fb_valid_nx;

	wire [BIU_DATA_WIDTH-1:0] cache_line_data[0:(CACHE_LINE_BEATS-1)];
	wire  			  cache_line_error[0:(CACHE_LINE_BEATS-1)];
	wire  			  cache_line_lock_fail[0:(CACHE_LINE_BEATS-1)];

	assign fb_mshr_entry_id_en = mshr_alloc & mshr_alloc_ready & ~mshr_alloc_sub_block & mshr_alloc_cache_fill & (fb_id == alloc_fb_fifo_rdata); 
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			fb_mshr_entry_id <= 4'b0;
		else if (fb_mshr_entry_id_en)
			fb_mshr_entry_id <= mshr_alloc_ptr; 
	end

	assign fb_valid_set = fb_mshr_entry_id_en;
	assign fb_valid_clr = (mshr_entry_retire[fb_mshr_entry_id] && mshr_entry_retire_grant[fb_mshr_entry_id]);
	assign fb_valid_nx  = fb_valid_set | (fb_valid & ~fb_valid_clr);
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			fb_valid <= 1'b0;
		else 
			fb_valid <= fb_valid_nx; 
	end

	for (s=0;s<CACHE_LINE_BEATS;s=s+1) begin: gen_cache_line_beats
		reg [BIU_DATA_WIDTH-1:0] 	data;

		reg				error;
		wire				error_set;
		wire				error_clr;
		wire				error_nx;

		reg				lock_fail;
		wire				lock_fail_set;
		wire				lock_fail_clr;
		wire				lock_fail_nx;

		wire 				data_en;
		wire [MSHR_CTW_WIDTH-1:0]	data_ptr = s[MSHR_CTW_WIDTH-1:0];

		assign data_en = fb_valid & biu_rdata_match_mshr[fb_mshr_entry_id] & mshr_cache_fill[fb_mshr_entry_id] & mshr_latch_data_en[fb_mshr_entry_id] & (mshr_ctw[fb_mshr_entry_id] == data_ptr);
	       	always @(posedge clk or negedge reset_n) begin
			if (!reset_n) 
				data   		<= {BIU_DATA_WIDTH{1'b0}};
			else if (data_en) 
				data 		<= mshr_load_resp_rdata;
		end
		assign error_nx  = ~error_clr & (error_set | error);
		assign error_set = fb_valid & biu_rdata_match_mshr[fb_mshr_entry_id] & mshr_cache_fill[fb_mshr_entry_id] & 
			           mshr_latch_data_en[fb_mshr_entry_id] & ((mshr_ctw[fb_mshr_entry_id] == data_ptr) | (~mshr_drdy[fb_mshr_entry_id][data_ptr] & mshr_load_resp_last)) & mshr_load_resp_read_error;
		assign error_clr = fb_valid_clr;
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n)
				error   <= 1'b0;
			else
				error	<= error_nx;
		end
		assign lock_fail_nx     = ~lock_fail_clr & (lock_fail_set | lock_fail);
		assign lock_fail_set    = fb_valid & biu_rdata_match_mshr[fb_mshr_entry_id] & mshr_cache_fill[fb_mshr_entry_id] & 
			           	  mshr_latch_data_en[fb_mshr_entry_id] & ((mshr_ctw[fb_mshr_entry_id] == data_ptr) | (~mshr_drdy[fb_mshr_entry_id][data_ptr] & mshr_load_resp_last)) & mshr_load_resp_lock_fail;
		assign lock_fail_clr 	= fb_valid_clr;
		always @(posedge clk or negedge reset_n) begin
			if (!reset_n)
				lock_fail   <= 1'b0;
			else
				lock_fail   <= lock_fail_nx;
		end		
		assign cache_line_data[s] 	= data;
		assign cache_line_error[s] 	= error;
		assign cache_line_lock_fail[s] 	= lock_fail;
	end
	if (CACHE_LINE_BEATS == 1) begin : gen_fb_rdata_single_beat
		assign fb_sub_block_rdata[r] 		= cache_line_data[0];
		assign fb_sub_block_error[r]		= cache_line_error[0];
		assign fb_sub_block_lock_fail[r]	= cache_line_lock_fail[0];
		assign fb_fill_wdata[r]      		= cache_line_data[0];
		assign fb_dcu_lookup_mshr_data[r] 	= cache_line_data[0];
	end	
	else begin : gen_fb_rdata_biu_multi_beat
		wire [MSHR_CTW_WIDTH-1:0] cache_line_data_sel = mshr_sub_block_ctw[fb_mshr_entry_id];
		wire [OFFSET_WIDTH-1:0]	  cache_line_fill_data_sel = mshr_data_offset[fb_mshr_entry_id];

		assign fb_sub_block_rdata[r] 		= cache_line_data[cache_line_data_sel];
		assign fb_sub_block_error[r]		= cache_line_error[cache_line_data_sel];
		assign fb_sub_block_lock_fail[r]	= cache_line_lock_fail[cache_line_data_sel];
		assign fb_fill_wdata[r]      		= cache_line_data[cache_line_fill_data_sel];
		assign fb_dcu_lookup_mshr_data[r] 	= cache_line_data[dcu_dphase_lookup_mshr_data_sel];
	end	
end
endgenerate
generate
genvar ufb;
for (ufb = MSHR_FB_DEPTH; ufb < 16; ufb = ufb + 1) begin : gen_unused_fb_entry
	assign fb_sub_block_rdata[ufb] 		= {BIU_DATA_WIDTH{1'b0}};
	assign fb_sub_block_error[ufb] 		= 1'b0;
	assign fb_sub_block_lock_fail[ufb] 	= 1'b0;
        assign fb_fill_wdata[ufb]      		= {BIU_DATA_WIDTH{1'b0}};
	assign fb_dcu_lookup_mshr_data[ufb] 	= {BIU_DATA_WIDTH{1'b0}};
        	
end
endgenerate

//DQ FIFO

assign dq_fifo_push 	= mshr_load_resp_read_ack & mshr_load_resp_read_grant & ~mshr_cache_fill[dq_push_req_id];
assign dq_fifo_wdata[DQ_FIFO_BIU_DATA_MSB_BIT:DQ_FIFO_BIU_DATA_LSB_BIT] = mshr_load_resp_rdata;
assign dq_fifo_wdata[DQ_FIFO_ENTRY_ID_MSB_BIT:DQ_FIFO_ENTRY_ID_LSB_BIT] = dq_push_req_id;
assign dq_fifo_wdata[DQ_FIFO_ID_MSB_BIT:DQ_FIFO_ID_LSB_BIT]		= mshr_load_resp_id[4:0];
assign dq_fifo_wdata[DQ_FIFO_ERROR_BIT]					= mshr_load_resp_read_error;
assign dq_fifo_wdata[DQ_FIFO_LOCK_FAIL_BIT]				= mshr_load_resp_lock_fail;
assign dq_fifo_wdata[DQ_FIFO_LAST_BIT]					= mshr_load_resp_last;

assign dq_fifo_pop	= (dq_lsu_req & dq_lsu_grant);

assign dq_read_data 		= dq_fifo_rdata[DQ_FIFO_BIU_DATA_MSB_BIT:DQ_FIFO_BIU_DATA_LSB_BIT];
assign dq_read_entry_id 	= dq_fifo_rdata[DQ_FIFO_ENTRY_ID_MSB_BIT:DQ_FIFO_ENTRY_ID_LSB_BIT];
assign dq_read_id 		= dq_fifo_rdata[DQ_FIFO_ID_MSB_BIT:DQ_FIFO_ID_LSB_BIT];
assign dq_read_error 		= dq_fifo_rdata[DQ_FIFO_ERROR_BIT];
assign dq_read_lock_fail	= dq_fifo_rdata[DQ_FIFO_LOCK_FAIL_BIT];
assign dq_read_last 		= dq_fifo_rdata[DQ_FIFO_LAST_BIT];

assign dq_req_valid	= ~dq_fifo_empty;
assign dq_lsu_req	= dq_req_valid;

nds_sync_fifo_ll #(.DATA_WIDTH		(DQ_DATA_WIDTH	),
		   .FIFO_DEPTH		(DQ_DEPTH	),
		   .POINTER_INDEX_WIDTH (DQ_INDEX_WIDTH	)
		  ) dq_fifo    (  .w_reset_n	(reset_n	 ),
				  .r_reset_n	(reset_n	 ),
				  .w_clk	(clk		 ),
				  .r_clk	(clk		 ),
				  .wr		(dq_fifo_push 	),
				  .wr_data	(dq_fifo_wdata	),
				  .rd		(dq_fifo_pop	 ),
				  .rd_data	(dq_fifo_rdata	),
				  .w_clk_empty	(dq_fifo_w_clk_empty  ),
				  .empty	(dq_fifo_empty	),
				  .full		(dq_fifo_full	 )
			       );

assign mshr_load_resp_read_grant = ~dq_fifo_full; //Modified for critical path, performance might drop if uncache load stuck (dq_fifo_full), the later cacheable data would be block
//assign mshr_load_resp_read_grant = (~mshr_cache_fill[dq_push_req_id] & ~dq_fifo_full) |        //device un-cache
//				     mshr_cache_fill[dq_push_req_id];			       //cacheable fill	

// MSHR LSU req arb
generate
if (MSHR_DEPTH == 16) begin : gen_sub_block_lsu_req_eq_16
	assign mshr_sub_block_lsu_req_arb_in = mshr_sub_block_lsu_req;
end
else begin : gen_sub_block_lsu_req_less_than_16
	assign mshr_sub_block_lsu_req_arb_in = {{(16-MSHR_DEPTH){1'b0}},mshr_sub_block_lsu_req};
end
endgenerate
always @* begin
	casez(mshr_sub_block_lsu_req_arb_in)
	16'b????????_???????1: mshr_sub_block_lsu_req_arb_out = 4'd0;
	16'b????????_??????10: mshr_sub_block_lsu_req_arb_out = 4'd1;
	16'b????????_?????100: mshr_sub_block_lsu_req_arb_out = 4'd2;
	16'b????????_????1000: mshr_sub_block_lsu_req_arb_out = 4'd3;
	16'b????????_???10000: mshr_sub_block_lsu_req_arb_out = 4'd4;
	16'b????????_??100000: mshr_sub_block_lsu_req_arb_out = 4'd5;
	16'b????????_?1000000: mshr_sub_block_lsu_req_arb_out = 4'd6;
	16'b????????_10000000: mshr_sub_block_lsu_req_arb_out = 4'd7;
	16'b???????1_00000000: mshr_sub_block_lsu_req_arb_out = 4'd8;
	16'b??????10_00000000: mshr_sub_block_lsu_req_arb_out = 4'd9;
	16'b?????100_00000000: mshr_sub_block_lsu_req_arb_out = 4'd10;
	16'b????1000_00000000: mshr_sub_block_lsu_req_arb_out = 4'd11;
	16'b???10000_00000000: mshr_sub_block_lsu_req_arb_out = 4'd12;
	16'b??100000_00000000: mshr_sub_block_lsu_req_arb_out = 4'd13;
	16'b?1000000_00000000: mshr_sub_block_lsu_req_arb_out = 4'd14;
	16'b10000000_00000000: mshr_sub_block_lsu_req_arb_out = 4'd15;
	default: mshr_sub_block_lsu_req_arb_out = 4'b0;
	endcase
end
assign mshr_sub_block_lsu_req_dest_idx		= mshr_sub_block_dest_idx[mshr_sub_block_lsu_req_arb_out];   
assign mshr_sub_block_lsu_req_dest_to_vrf	= mshr_sub_block_dest_to_vrf[mshr_sub_block_lsu_req_arb_out];
assign mshr_sub_block_lsu_req_dest_to_frf	= mshr_sub_block_dest_to_frf[mshr_sub_block_lsu_req_arb_out];
assign mshr_sub_block_lsu_req_dest_to_xrf	= mshr_sub_block_dest_to_xrf[mshr_sub_block_lsu_req_arb_out];
assign mshr_sub_block_lsu_req_dest_to_sb	= mshr_sub_block_dest_to_sb[mshr_sub_block_lsu_req_arb_out]; 
assign mshr_sub_block_lsu_req_rdata		= mshr_sub_block_rdata[mshr_sub_block_lsu_req_arb_out];	     	     
assign mshr_sub_block_lsu_req_offset		= mshr_sub_block_offset[mshr_sub_block_lsu_req_arb_out];     
assign mshr_sub_block_lsu_req_size		= mshr_sub_block_size[mshr_sub_block_lsu_req_arb_out];       
assign mshr_sub_block_lsu_req_func		= mshr_sub_block_func[mshr_sub_block_lsu_req_arb_out];       
assign mshr_sub_block_lsu_req_error		= mshr_sub_block_error[mshr_sub_block_lsu_req_arb_out];
assign mshr_sub_block_lsu_req_lock_fail		= mshr_sub_block_lock_fail[mshr_sub_block_lsu_req_arb_out];
assign mshr_sub_block_lsu_req_blocking		= mshr_blocking[mshr_sub_block_lsu_req_arb_out];
assign mshr_sub_block_lsu_req_blocking_been_kill= mshr_blocking_been_kill[mshr_sub_block_lsu_req_arb_out];
assign mshr_sub_block_lsu_req_fill_done		= mshr_entry_cache_fill_done[mshr_sub_block_lsu_req_arb_out];
assign mshr_sub_block_lsu_req_fill_way		= mshr_way[mshr_sub_block_lsu_req_arb_out];


assign mshr_lsu_req = |mshr_sub_block_lsu_req;
generate 
genvar kk;
for (kk=0;kk<16;kk=kk+1) begin : gen_mshr_sub_block_lsu_req_ext_grant
	wire [3:0] var_kk = kk[3:0];
	assign mshr_sub_block_lsu_req_ext_grant[kk]  = mshr_lsu_grant & (mshr_sub_block_lsu_req_arb_out == var_kk );
end
endgenerate

assign mshr_sub_block_lsu_req_grant = mshr_sub_block_lsu_req_ext_grant[(MSHR_DEPTH-1):0];

// MSHR RESP to LSU

assign mshr_latch_data_en_ext 		  = mshr_latch_data_en;
generate
genvar n;
for (n=0;n<16;n=n+1) begin : gen_mshr_req_ext
	if (n < MSHR_DEPTH) begin: gen_mshr_req_id
		assign mshr_req_id_ext[n] = mshr_req_id[n];
	end
	else begin : gen_unused_mshr_req_id
		assign mshr_req_id_ext[n] = 5'b0;
	end
end
endgenerate

generate 
genvar rr;
for (rr=0;rr<16;rr=rr+1) begin : gen_dq_push_read_id_matching_wires
//	assign dq_read_id_matching_mshr_req_id[rr] = mshr_latch_data_en_ext[rr] & (dq_read_id == mshr_req_id_ext[rr] ); 
	assign dq_push_id_matching_mshr_req_id[rr] = mshr_latch_data_en_ext[rr] & (mshr_load_resp_id[4:0] == mshr_req_id_ext[rr]); 
end
endgenerate
//always @* begin
//	casez(dq_read_id_matching_mshr_req_id)
//	16'b????????_???????1: dq_read_req_id = 4'd0;
//	16'b????????_??????10: dq_read_req_id = 4'd1;
//	16'b????????_?????100: dq_read_req_id = 4'd2;
//	16'b????????_????1000: dq_read_req_id = 4'd3;
//	16'b????????_???10000: dq_read_req_id = 4'd4;
//	16'b????????_??100000: dq_read_req_id = 4'd5;
//	16'b????????_?1000000: dq_read_req_id = 4'd6;
//	16'b????????_10000000: dq_read_req_id = 4'd7;
//	16'b???????1_00000000: dq_read_req_id = 4'd8;
//	16'b??????10_00000000: dq_read_req_id = 4'd9;
//	16'b?????100_00000000: dq_read_req_id = 4'd10;
//	16'b????1000_00000000: dq_read_req_id = 4'd11;
//	16'b???10000_00000000: dq_read_req_id = 4'd12;
//	16'b??100000_00000000: dq_read_req_id = 4'd13;
//	16'b?1000000_00000000: dq_read_req_id = 4'd14;
//	16'b10000000_00000000: dq_read_req_id = 4'd15;
//	default:dq_read_req_id = 4'b0;
//	endcase
//end
assign dq_read_req_id = dq_read_entry_id;
always @* begin
	casez(dq_push_id_matching_mshr_req_id)
	16'b????????_???????1: dq_push_req_id = 4'd0;
	16'b????????_??????10: dq_push_req_id = 4'd1;
	16'b????????_?????100: dq_push_req_id = 4'd2;
	16'b????????_????1000: dq_push_req_id = 4'd3;
	16'b????????_???10000: dq_push_req_id = 4'd4;
	16'b????????_??100000: dq_push_req_id = 4'd5;
	16'b????????_?1000000: dq_push_req_id = 4'd6;
	16'b????????_10000000: dq_push_req_id = 4'd7;
	16'b???????1_00000000: dq_push_req_id = 4'd8;
	16'b??????10_00000000: dq_push_req_id = 4'd9;
	16'b?????100_00000000: dq_push_req_id = 4'd10;
	16'b????1000_00000000: dq_push_req_id = 4'd11;
	16'b???10000_00000000: dq_push_req_id = 4'd12;
	16'b??100000_00000000: dq_push_req_id = 4'd13;
	16'b?1000000_00000000: dq_push_req_id = 4'd14;
	16'b10000000_00000000: dq_push_req_id = 4'd15;
	default:dq_push_req_id = 4'b0;
	endcase
end
assign mshr_resp_sel_dq		= dq_lsu_req;

assign mshr_resp_valid			= mshr_lsu_req | dq_lsu_req;
assign mshr_resp_rdata			= mshr_resp_sel_dq ? dq_read_data				: mshr_sub_block_lsu_req_rdata			;
assign mshr_resp_rf_index		= mshr_resp_sel_dq ? mshr_sub_block_dest_idx[dq_read_req_id]	: mshr_sub_block_lsu_req_dest_idx		;
assign mshr_resp_size			= mshr_resp_sel_dq ? mshr_sub_block_size[dq_read_req_id]	: mshr_sub_block_lsu_req_size			;
assign mshr_resp_func			= mshr_resp_sel_dq ? mshr_sub_block_func[dq_read_req_id]	: mshr_sub_block_lsu_req_func			;
assign mshr_resp_offset			= mshr_resp_sel_dq ? mshr_sub_block_offset[dq_read_req_id]	: mshr_sub_block_lsu_req_offset			;
assign mshr_resp_error			= mshr_resp_sel_dq ? dq_read_error				: mshr_sub_block_lsu_req_error			;
assign mshr_resp_lock_fail		= mshr_resp_sel_dq ? dq_read_lock_fail				: mshr_sub_block_lsu_req_lock_fail		;
assign mshr_resp_to_vrf			= mshr_resp_sel_dq ? mshr_sub_block_dest_to_vrf[dq_read_req_id]	: mshr_sub_block_lsu_req_dest_to_vrf		;
assign mshr_resp_to_frf			= mshr_resp_sel_dq ? mshr_sub_block_dest_to_frf[dq_read_req_id]	: mshr_sub_block_lsu_req_dest_to_frf		;
assign mshr_resp_to_xrf			= mshr_resp_sel_dq ? mshr_sub_block_dest_to_xrf[dq_read_req_id]	: mshr_sub_block_lsu_req_dest_to_xrf		;
assign mshr_resp_to_sb			= mshr_resp_sel_dq ? mshr_sub_block_dest_to_sb[dq_read_req_id]	: mshr_sub_block_lsu_req_dest_to_sb		;
assign mshr_resp_vector_fastpath	= mshr_resp_sel_dq ? mshr_vector_fastpath[dq_read_req_id]	: 1'b0						;
assign mshr_resp_blocking		= mshr_resp_sel_dq ? mshr_blocking[dq_read_req_id]		: mshr_sub_block_lsu_req_blocking		;
assign mshr_resp_blocking_been_kill	= mshr_resp_sel_dq ? mshr_blocking_been_kill[dq_read_req_id]	: mshr_sub_block_lsu_req_blocking_been_kill	;
assign mshr_resp_fill_done		= mshr_resp_sel_dq ? 1'b1					: mshr_sub_block_lsu_req_fill_done		;
assign mshr_resp_fill_entry_id		= mshr_resp_sel_dq ? 4'b0					: mshr_sub_block_lsu_req_arb_out		;
assign mshr_resp_fill_way		= mshr_resp_sel_dq ? 4'b0					: mshr_sub_block_lsu_req_fill_way		;

assign mshr_lsu_grant 		= mshr_resp_valid & mshr_resp_ready & ~mshr_resp_sel_dq;
assign dq_lsu_grant		= mshr_resp_valid & mshr_resp_ready & mshr_resp_sel_dq;
// MSHR Load req
assign mshr_load_req			= mshr_load_biu_req[mshr_issue_ptr];
assign mshr_load_req_addr		= mshr_cache_fill[mshr_issue_ptr] ? {mshr_addr[mshr_issue_ptr][TAG_MSB:OFFSET_LSB], {OFFSET_LSB{1'b0}}} : mshr_addr[mshr_issue_ptr];
assign mshr_load_req_length		= mshr_cache_fill[mshr_issue_ptr] ? BURST_LENGTH : {{(BIU_LENGTH_WIDTH-4){1'b0}},mshr_length[mshr_issue_ptr]};
assign mshr_load_req_size		= mshr_cache_fill[mshr_issue_ptr] ? BIU_SIZE 	 : mshr_size[mshr_issue_ptr];
assign mshr_load_req_cacheability	= mshr_mem_attri[mshr_issue_ptr];
assign mshr_load_req_privileged		= mshr_privileged[mshr_issue_ptr];
assign mshr_load_req_lock		= mshr_lock[mshr_issue_ptr];        
assign mshr_load_req_write		= mshr_atomic_store[mshr_issue_ptr];        
assign mshr_load_req_type		= mshr_type[mshr_issue_ptr];        
assign mshr_load_req_id			= mshr_req_id[mshr_issue_ptr];
assign mshr_load_req_kill 		= 1'b0;// no need for MSHR arch

// the flop : mshr_load_req_lock_clear_reg is used for handle the case;
// a lsu_biu_lock_clr is sent while a atomic access is sent to MSHR but not
// send to BIU yet.
// The flop is set when an atomic access send to BIU but found it had been
// killed (or killed when issued)
// The flop is assert for one cycle after the atomic access is sent to BIU.
assign mshr_load_req_lock_clear_nx = mshr_load_req & mshr_load_req_grant & mshr_load_req_lock & (mshr_blocking_been_kill[mshr_issue_ptr] | lsu_kill); 
always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		mshr_load_req_lock_clear_reg <= 1'b0;
	else
		mshr_load_req_lock_clear_reg <= mshr_load_req_lock_clear_nx;
end

assign mshr_load_req_lock_clear		= mshr_load_req_lock_clear_reg;

//MSHR Store req

assign mshr_store_req 			= mshr_evict_biu_req[mshr_issue_ptr];
assign mshr_store_req_addr 		= mshr_evict_biu_req_addr[mshr_issue_ptr];
assign mshr_store_req_last 		= mshr_evict_biu_req_last[mshr_issue_ptr];
assign mshr_store_req_wdata 		= eb_fifo_rdata;
assign mshr_store_req_data_valid 	= mshr_evict_biu_req_data_valid[mshr_issue_ptr];

assign mshr_store_req_bwe		= {(BIU_DATA_WIDTH/8){1'b1}};
assign mshr_store_req_cacheability 	= WRITEBACK_RW_ALLOC;
assign mshr_store_req_privileged        = cur_privileged;
assign mshr_store_req_lock		= 1'b0;
assign mshr_store_req_precise		= 1'b0;
assign mshr_store_req_length		= CACHE_LINE_BURST_LENGTH[BIU_LENGTH_WIDTH-1:0];
assign mshr_store_req_size		= BIU_SIZE;
assign mshr_store_req_type		= WRITE_SNOOP;
assign mshr_store_req_id		= EVICT_ID;

//MHSR Evict fetch_req
assign mshr_evict_req			= mshr_evict_fetch_req[mshr_issue_ptr];
assign mshr_evict_req_way		= mshr_evict_fetch_way[mshr_issue_ptr];
assign mshr_evict_req_index		= mshr_evict_fetch_index[mshr_issue_ptr];
assign mshr_evict_req_offset		= mshr_evict_fetch_offset[mshr_issue_ptr];

//MSHR FILL DCACHE TAG
generate
if (MSHR_DEPTH == 16) begin : gen_tag_req_eq_16
	assign mshr_tag_req_ext			= mshr_tag_req;
end
else begin : gen_tag_req_less_than_16
	assign mshr_tag_req_ext			= {{(16-MSHR_DEPTH){1'b0}},mshr_tag_req};
end
endgenerate

always @* begin
	casez(mshr_tag_req_ext)
	16'b????????_???????1: mshr_tag_req_arb_out = 4'd0;
	16'b????????_??????10: mshr_tag_req_arb_out = 4'd1;
	16'b????????_?????100: mshr_tag_req_arb_out = 4'd2;
	16'b????????_????1000: mshr_tag_req_arb_out = 4'd3;
	16'b????????_???10000: mshr_tag_req_arb_out = 4'd4;
	16'b????????_??100000: mshr_tag_req_arb_out = 4'd5;
	16'b????????_?1000000: mshr_tag_req_arb_out = 4'd6;
	16'b????????_10000000: mshr_tag_req_arb_out = 4'd7;
	16'b???????1_00000000: mshr_tag_req_arb_out = 4'd8;
	16'b??????10_00000000: mshr_tag_req_arb_out = 4'd9;
	16'b?????100_00000000: mshr_tag_req_arb_out = 4'd10;
	16'b????1000_00000000: mshr_tag_req_arb_out = 4'd11;
	16'b???10000_00000000: mshr_tag_req_arb_out = 4'd12;
	16'b??100000_00000000: mshr_tag_req_arb_out = 4'd13;
	16'b?1000000_00000000: mshr_tag_req_arb_out = 4'd14;
	16'b10000000_00000000: mshr_tag_req_arb_out = 4'd15;
	default: mshr_tag_req_arb_out = 4'b0000;
	endcase
end

assign mshr_fill_tag_req		= mshr_tag_req_ext[mshr_tag_req_arb_out];
assign mshr_fill_tag_req_addr		= mshr_tag_addr[mshr_tag_req_arb_out];
assign mshr_fill_tag_req_way		= mshr_way[mshr_tag_req_arb_out];
assign mshr_fill_tag_req_cmd		= {2{mshr_fill_tag_req}};

generate
if (DCACHE_TAG_DW == 1) begin : gen_mshr_fill_tag_wdata_no_dcsh
	assign mshr_fill_tag_req_wdata		= |mshr_tag_wdata[mshr_tag_req_arb_out];
end
else begin : gen_mshr_fill_tag_wdata_wt_dcsh
	assign mshr_fill_tag_req_wdata		= mshr_tag_wdata[mshr_tag_req_arb_out];
end
endgenerate


//MSHR FILL DCACHE DATA
generate
if (MSHR_DEPTH == 16) begin : gen_data_req_eq_16
	assign mshr_data_req_ext		= mshr_data_req;
end
else begin : gen_data_req_less_than_16
	assign mshr_data_req_ext		= {{(16-MSHR_DEPTH){1'b0}},mshr_data_req};
end
endgenerate

assign mshr_cache_fill_done_ext		= mshr_entry_cache_fill_done;

assign mshr_fill_arb_locked_nx  = mshr_fill_arb_locked_set | (mshr_fill_arb_locked & ~mshr_fill_arb_locked_clr);
assign mshr_fill_arb_locked_set = ~mshr_fill_arb_locked & (|mshr_data_req);
assign mshr_fill_arb_locked_clr = mshr_cache_fill_done_ext[mshr_fill_locked_entry];
always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		mshr_fill_arb_locked <= 1'b0;
	else
		mshr_fill_arb_locked <= mshr_fill_arb_locked_nx;
end

assign mshr_fill_locked_entry_en = mshr_fill_arb_locked_set;
always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		mshr_fill_locked_entry <= 4'b0;
	else if (mshr_fill_locked_entry_en)
		mshr_fill_locked_entry <= mshr_data_req_arb_out;
end
always @* begin
	if (mshr_fill_arb_locked)
		mshr_data_req_arb_out = mshr_fill_locked_entry;
	else begin
		casez(mshr_data_req_ext)
		16'b????????_???????1: mshr_data_req_arb_out = 4'd0;
		16'b????????_??????10: mshr_data_req_arb_out = 4'd1;
		16'b????????_?????100: mshr_data_req_arb_out = 4'd2;
		16'b????????_????1000: mshr_data_req_arb_out = 4'd3;
		16'b????????_???10000: mshr_data_req_arb_out = 4'd4;
		16'b????????_??100000: mshr_data_req_arb_out = 4'd5;
		16'b????????_?1000000: mshr_data_req_arb_out = 4'd6;
		16'b????????_10000000: mshr_data_req_arb_out = 4'd7;
		16'b???????1_00000000: mshr_data_req_arb_out = 4'd8;
		16'b??????10_00000000: mshr_data_req_arb_out = 4'd9;
		16'b?????100_00000000: mshr_data_req_arb_out = 4'd10;
		16'b????1000_00000000: mshr_data_req_arb_out = 4'd11;
		16'b???10000_00000000: mshr_data_req_arb_out = 4'd12;
		16'b??100000_00000000: mshr_data_req_arb_out = 4'd13;
		16'b?1000000_00000000: mshr_data_req_arb_out = 4'd14;
		16'b10000000_00000000: mshr_data_req_arb_out = 4'd15;
		default: mshr_data_req_arb_out = 4'b0000;
		endcase
	end
end

assign mshr_fill_data_req		= mshr_data_req_ext[mshr_data_req_arb_out];
assign mshr_fill_data_req_wdata		= mshr_data_wdata[mshr_data_req_arb_out];
assign mshr_fill_data_req_way		= mshr_way[mshr_data_req_arb_out];
assign mshr_fill_data_req_index		= mshr_data_index[mshr_data_req_arb_out];
assign mshr_fill_data_req_offset 	= mshr_data_offset[mshr_data_req_arb_out];

generate
genvar p;
for (p=0;p<MSHR_DEPTH;p=p+1) begin:gen_mshr_tag_req_grant
	assign mshr_tag_req_grant[p] = mshr_fill_tag_req & mshr_fill_tag_req_grant & (mshr_tag_req_arb_out == mshr_entry_id[p]);
	assign mshr_data_req_grant[p] = mshr_fill_data_req & mshr_fill_data_req_grant & (mshr_data_req_arb_out == mshr_entry_id[p]);
end
endgenerate

wire nds_unused_wire = (|dcu_dphase_lookup_mshr_data_sel) | (|mshr_sub_block_ctw[0]) | (|mshr_sub_block_ctw[1]) | (|mshr_sub_block_ctw[2]) | (|mshr_sub_block_ctw[3]) |
	            (|mshr_sub_block_ctw[4]) | (|mshr_sub_block_ctw[5]) | (|mshr_sub_block_ctw[6]) | (|mshr_sub_block_ctw[7]) |
		    (|mshr_sub_block_ctw[8]) | (|mshr_sub_block_ctw[9]) | (|mshr_sub_block_ctw[10]) | (|mshr_sub_block_ctw[11]) |
		    (|mshr_sub_block_ctw[12]) | (|mshr_sub_block_ctw[13]) | (|mshr_sub_block_ctw[14]) | (|mshr_sub_block_ctw[15]) |
	            alloc_fifo_w_clk_empty | alloc_fb_fifo_w_clk_empty | alloc_fb_fifo_full | mshr_alloc_uncache_vector_unalign_first |  
	            issue_fifo_w_clk_empty | issue_fifo_full | eb_fifo_w_clk_empty | eb_fifo_full | dq_fifo_w_clk_empty;

function [30:0] drdy_ptr_dec;
input [5:2] offset;
begin
	//29 is for single beat, BIU256+32B or BIU512+64B
	drdy_ptr_dec[30] = 1'b1;
	//29-28 is for BIU256 + 64B
	drdy_ptr_dec[29] = (offset[5] == 1'b1);
	drdy_ptr_dec[28] = (offset[5] == 1'b0);
	//27:24 decodes offset[5:4], for BIU128 + Cache line size 64
	drdy_ptr_dec[27] = (offset[5:4] == 2'b11);
	drdy_ptr_dec[26] = (offset[5:4] == 2'b10);
	drdy_ptr_dec[25] = (offset[5:4] == 2'b01);
	drdy_ptr_dec[24] = (offset[5:4] == 2'b00);
	//23:16 is for BIU64, cache line size 64
	drdy_ptr_dec[23] = (offset[5:3] == 3'b111);
	drdy_ptr_dec[22] = (offset[5:3] == 3'b110);
	drdy_ptr_dec[21] = (offset[5:3] == 3'b101);
	drdy_ptr_dec[20] = (offset[5:3] == 3'b100);
	drdy_ptr_dec[19] = (offset[5:3] == 3'b011);
	drdy_ptr_dec[18] = (offset[5:3] == 3'b010);
	drdy_ptr_dec[17] = (offset[5:3] == 3'b001);
	drdy_ptr_dec[16] = (offset[5:3] == 3'b000);
	//15:12 decodes offset[4:3], for BIU64 + Cache line size 32
	drdy_ptr_dec[15] = (offset[4:3] == 2'b11);
	drdy_ptr_dec[14] = (offset[4:3] == 2'b10);
	drdy_ptr_dec[13] = (offset[4:3] == 2'b01);
	drdy_ptr_dec[12] = (offset[4:3] == 2'b00);
	//11:8  decodes offset[3:2], for BIU32 + cache line 16
	drdy_ptr_dec[11] = (offset[3:2] == 2'b11);
	drdy_ptr_dec[10] = (offset[3:2] == 2'b10);
	drdy_ptr_dec[9]  = (offset[3:2] == 2'b01);
	drdy_ptr_dec[8]  = (offset[3:2] == 2'b00);
	//7:0  decodes offset[4:2], for BIU32 + cache line 32
	drdy_ptr_dec[7]  = (offset[4:2] == 3'b111);
	drdy_ptr_dec[6]  = (offset[4:2] == 3'b110);
	drdy_ptr_dec[5]  = (offset[4:2] == 3'b101);
	drdy_ptr_dec[4]  = (offset[4:2] == 3'b100);
	drdy_ptr_dec[3]  = (offset[4:2] == 3'b011);
	drdy_ptr_dec[2]  = (offset[4:2] == 3'b010);
	drdy_ptr_dec[1]  = (offset[4:2] == 3'b001);
	drdy_ptr_dec[0]  = (offset[4:2] == 3'b000);
end
endfunction

endmodule


