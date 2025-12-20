module atcaxi2tluh500_hr_ent (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  clk,      
        	  resetn,   
        	  axvalid,  
        	  axready,  
        	  axaddr,   
        	  axlen,    
        	  axsize,   
        	  axburst,  
        	  axcache,  
        	  axprot,   
        	  axfunc,   
        	  axaddrlast,
        	  axburstlen,
        	  wvalid,   
        	  wready,   
        	  wdata,    
        	  wstrb,    
        	  wlast,    
        	  bvalid,   
        	  bready,   
        	  bresp,    
        	  rvalid,   
        	  rready,   
        	  rresp,    
        	  rdata,    
        	  rlast,    
        	  a_valid,  
        	  a_ready,  
        	  a_opcode, 
        	  a_size,   
        	  a_address,
        	  a_mask,   
        	  a_data,   
        	  a_user,   
        	  a_last,   
        	  d_valid,  
        	  d_ready,  
        	  d_opcode, 
        	  d_denied, 
        	  d_corrupt,
        	  d_data,   
        	  d_user    
        // VPERL_GENERATED_END

);

// Parameter
parameter	ADDR_WIDTH 		= 64;
parameter	DATA_WIDTH 		= 256;
parameter	TL_SIZE_WIDTH		= 4;
parameter	TL_A_USER_WIDTH		= 8;
parameter	TL_D_USER_WIDTH		= 8;
parameter	AX_FUNC_BITS		= 4;
parameter	RAR_SUPPORT		= 0;

// Local Parameter
localparam	AXI_BURST_FIXED		= 2'd0;
localparam	AXI_BURST_INCR		= 2'd1;
localparam	AXI_BURST_WRAP		= 2'd2;
localparam	AXI_BURST_RSVD		= 2'd3;

localparam	AXI_RESP_OKAY		= 2'd0;
localparam	AXI_RESP_EXOKAY		= 2'd1;
localparam	AXI_RESP_SLVERR		= 2'd2;
localparam	AXI_RESP_DECERR		= 2'd3;

localparam	TL_OP_PUTPART		= 3'd1;
localparam	TL_OP_GET		= 3'd4;

localparam	TL_OP_ACCESSACK		= 3'd0;
localparam	TL_OP_ACCESSACKDATA	= 3'd1;

localparam	AX_FUNC_W		= 0;
localparam	AX_FUNC_R		= 1;
localparam	AX_FUNC_SINGLE		= 2;
localparam	AX_FUNC_MEM		= 3;

localparam	AXI_SIZE_BYTE		= 3'd0; // 8
localparam	AXI_SIZE_HWORD		= 3'd1; // 16
localparam	AXI_SIZE_WORD		= 3'd2; // 32
localparam	AXI_SIZE_DWORD		= 3'd3; // 64
localparam	AXI_SIZE_QWORD		= 3'd4; // 128
localparam	AXI_SIZE_DQWORD		= 3'd5; // 256
localparam	AXI_SIZE_QQWORD		= 3'd6; // 512

localparam	DATA_BYTES		= DATA_WIDTH/8;
localparam	BUF_OFFSET_WIDTH	= $clog2(DATA_BYTES);

// Common
input					clk;
input					resetn;

// AXI_CMD
input					axvalid;
output					axready;
input	[(ADDR_WIDTH-1):0]		axaddr;
input	[7:0]				axlen;
input	[2:0]				axsize;
input	[1:0]				axburst;
input	[3:0]				axcache;
input	[2:0]				axprot;
input	[(AX_FUNC_BITS-1):0]		axfunc;
input	[5:0]				axaddrlast;
input	[5:0]				axburstlen;
// AXI WDATA
input					wvalid;
output					wready;
input	[(DATA_WIDTH-1):0]		wdata;
input	[((DATA_WIDTH/8)-1):0]		wstrb;
input					wlast;
// AXI_RESP
output					bvalid;
input					bready;
output	[1:0]				bresp;
output					rvalid;
input					rready;
output	[1:0]				rresp;
output	[(DATA_WIDTH-1):0]		rdata;
output					rlast;
// TL-A
output					a_valid;	
input					a_ready;
output	[2:0]				a_opcode;
output	[2:0]				a_size;
output	[(ADDR_WIDTH-1):0]		a_address;
output	[((DATA_WIDTH/8)-1):0]		a_mask;
output	[(DATA_WIDTH-1):0]		a_data;
output	[6:0]				a_user;
output					a_last;
//TL-D
input					d_valid;
output					d_ready;
input	[2:0]				d_opcode;
input					d_denied;
input					d_corrupt;
input	[(DATA_WIDTH-1):0]		d_data;
input	[1:0]				d_user;

reg					issue_valid;
wire					issue_valid_set;
wire					issue_valid_clr;
wire					issue_valid_en = issue_valid_set | issue_valid_clr;

wire	[(ADDR_WIDTH-1):0]		issue_addr;
wire	[5:0]				issue_addr_last;
wire	[1:0]				issue_burst;
wire	[7:0]				issue_len;
wire	[2:0]				issue_size;
wire	[6:0]				issue_user;	// {axcache, axprot};
wire	[6:0]				issue_user_nx;	// {axcache, axprot};
wire	[(AX_FUNC_BITS-1):0]		issue_func;

wire					issue_last;
reg					issue_stall;
wire					issue_stall_set;
wire					issue_stall_clr;
wire					issue_stall_en = issue_stall_set | issue_stall_clr;
wire	[11:0]				issue_single_addr;
wire	[11:0]				issue_single_addr_fixed;
wire	[12:0]				issue_single_addr_incr_single_byte;
wire	[12:0]				issue_single_addr_incr_single_hword;
wire	[12:0]				issue_single_addr_incr_single_word;
wire	[12:0]				issue_single_addr_incr_single_dword;
wire	[12:0]				issue_single_addr_incr_single_qword;
wire	[12:0]				issue_single_addr_incr_single_dqword;
wire	[12:0]				issue_single_addr_incr_single_qqword;
wire	[11:0]				issue_single_addr_incr_burst_write;
wire	[12:0]				issue_single_addr_incr_burst_read;
wire	[11:0]				issue_single_addr_incr;
wire	[11:0]				issue_single_addr_wrap;
wire	[11:0]				issue_burst_addr;
reg	[7:0]				issue_cnt;
wire					issue_cnt_inc;
wire	[5:0]				issue_burst_len;

wire					issue_dummy_init;
wire					issue_dummy_last;

reg	[(DATA_BYTES-1):0]		buf_valid;
wire	[(DATA_BYTES-1):0]		buf_valid_w_set;
wire					buf_valid_w_clr;
wire					buf_valid_r_set;
wire	[(DATA_BYTES-1):0]		buf_valid_r_clr;
wire	[5:0]				buf_valid_mask;
reg					buf_valid_one;
wire					buf_valid_one_en;
wire					buf_valid_one_nx;
reg					buf_valid_all;
wire					buf_valid_all_en;
wire					buf_valid_all_nx;
reg	[(DATA_BYTES-1):0]		buf_strb;
reg	[7:0]				buf_data[0:DATA_BYTES-1];
reg					buf_resp_valid;
wire					buf_resp_valid_set;
reg	[1:0]				buf_resp;
wire	[1:0]				buf_resp_nx;
wire					buf_resp_new;
wire					buf_resp_merge;
wire					buf_resp_clr;
wire					buf_resp_set;


reg	[5:0]				buf_offset_unit;
wire	[5:0]				buf_offset_unit_init;
reg	[5:0]				buf_cur_offset;
wire	[5:0]				buf_cur_offset_nx;
wire					buf_cur_offset_inc;
wire	[5:0]	                        buf_cur_offset_init;

reg	[8:0]				buf_w_cnt;
wire					buf_w_cnt_inc;
wire					buf_w_stall;
wire	[(DATA_BYTES-1):0]		buf_w_ready;

reg					resp_valid;
wire					resp_valid_set;
wire					resp_valid_clr;
wire					resp_valid_en = resp_valid_set | resp_valid_clr;

wire					resp_last;
reg					resp_stall;
wire					resp_stall_set;
wire					resp_stall_clr;
wire					resp_stall_en = resp_stall_set | resp_stall_clr;
reg	[8:0]				resp_cnt;
wire					resp_cnt_inc;
wire	[11:0]				resp_burst_addr;

wire	 				resp_dummy;

reg	[7:0]				retire_cnt;
wire					retire_cnt_clr;
wire					retire_cnt_inc;
wire					retire_last = (issue_func[AX_FUNC_R] & (retire_cnt == issue_len));

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		issue_valid <= 1'b0;
	end
	else if (issue_valid_en) begin
		issue_valid <= issue_valid_set;
	end
end

atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(ADDR_WIDTH  )) u_issue_addr_dff      (.clk(clk), .resetn(resetn), .en(issue_valid_set), .d(axaddr),        .q(issue_addr));
atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(6           )) u_issue_addr_last_dff (.clk(clk), .resetn(resetn), .en(issue_valid_set), .d(axaddrlast),    .q(issue_addr_last));
atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(2           )) u_issue_burst_dff     (.clk(clk), .resetn(resetn), .en(issue_valid_set), .d(axburst),       .q(issue_burst));
atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(8           )) u_issue_len_dff       (.clk(clk), .resetn(resetn), .en(issue_valid_set), .d(axlen),         .q(issue_len));
atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(3           )) u_issue_size_dff      (.clk(clk), .resetn(resetn), .en(issue_valid_set), .d(axsize),        .q(issue_size));
assign issue_user_nx = {( {4{axfunc[AX_FUNC_MEM]}} & axcache), axprot};
atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(7           )) u_issue_user_dff      (.clk(clk), .resetn(resetn), .en(issue_valid_set), .d(issue_user_nx), .q(issue_user));
atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(AX_FUNC_BITS)) u_issue_func_dff      (.clk(clk), .resetn(resetn), .en(issue_valid_set), .d(axfunc),        .q(issue_func));
atcaxi2tluh500_dff #(.R(RAR_SUPPORT), .W(6           )) u_issue_burst_len_dff (.clk(clk), .resetn(resetn), .en(issue_valid_set), .d(axburstlen),    .q(issue_burst_len));

assign	issue_cnt_inc = a_valid & a_ready & ~issue_last;

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		issue_cnt <= 8'b0;
	end
	else if (issue_valid_set) begin
		issue_cnt <= 8'b0;
	end
	else if (issue_cnt_inc) begin
		issue_cnt <= issue_cnt + 8'b1;
	end
end

assign	resp_cnt_inc = d_valid & d_ready & ~resp_last;

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		resp_cnt <= 9'b0;
	end
	else if (issue_valid_set) begin
		resp_cnt <= 9'b0;
	end
	else if (resp_cnt_inc) begin
		resp_cnt <= resp_cnt + 9'b1;
	end
end


assign	issue_valid_set = axvalid & axready;
assign	issue_valid_clr = a_valid & a_ready & issue_last;

assign	issue_last = ( issue_func[AX_FUNC_SINGLE] & (issue_cnt[7:0] == issue_len))
                   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W]                            & (DATA_WIDTH == 512))
                   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[0]   == 1'h1) & (DATA_WIDTH == 256))
                   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[1:0] == 2'h3) & (DATA_WIDTH == 128))
                   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[2:0] == 3'h7) & (DATA_WIDTH == 64 ))
                   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[3:0] == 4'hf) & (DATA_WIDTH == 32 ))
                   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (issue_cnt[5:0] == issue_burst_len[5:0]))
		   ; 

assign	resp_last = ( issue_func[AX_FUNC_SINGLE] & (resp_cnt[7:0] ==  issue_len))
                  | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W]                                                                        ) // broadcast write always the last response
                  | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_cnt[5:0] ==  issue_burst_len[5:0]       ) & (DATA_WIDTH == 512))
                  | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_cnt[6:0] == {issue_burst_len[5:0], 1'h1}) & (DATA_WIDTH == 256))
                  | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_cnt[7:0] == {issue_burst_len[5:0], 2'h3}) & (DATA_WIDTH == 128))
                  | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_cnt[8:0] == {issue_burst_len[5:0], 3'h7}) & (DATA_WIDTH == 64 ))
                  | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_cnt[8:0] == {issue_burst_len[4:0], 4'hf}) & (DATA_WIDTH == 32 ))
                  ; 

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		issue_stall <= 1'b0;
	end
	else if (issue_stall_en) begin
		issue_stall <= issue_stall_set;
	end
end

assign	issue_stall_set = (a_valid & a_ready &  issue_func[AX_FUNC_SINGLE]                                                                         )
                        | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W]                            & (DATA_WIDTH == 512))
                        | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[  0] == 1'h1) & (DATA_WIDTH == 256))
                        | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[1:0] == 2'h3) & (DATA_WIDTH == 128))
                        | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[2:0] == 3'h7) & (DATA_WIDTH == 64 ))
                        | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[3:0] == 4'hf) & (DATA_WIDTH == 32 ))
                        | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R]                                                 )
                        ;
assign	issue_stall_clr = (d_valid & d_ready &  issue_func[AX_FUNC_SINGLE]                                                                        )
                        | (d_valid & d_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W]                                                )
                        | (d_valid & d_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R]                           & (DATA_WIDTH == 512))
                        | (d_valid & d_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_cnt[  0] == 1'h1) & (DATA_WIDTH == 256))
                        | (d_valid & d_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_cnt[1:0] == 2'h3) & (DATA_WIDTH == 128))
                        | (d_valid & d_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_cnt[2:0] == 3'h7) & (DATA_WIDTH == 64 ))
                        | (d_valid & d_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_cnt[3:0] == 4'hf) & (DATA_WIDTH == 32 ))
                        ;

assign	axready = (~issue_valid & ~resp_valid & ~buf_valid_one);

assign	a_valid = (~issue_stall & issue_valid & issue_func[AX_FUNC_W] & (/*(issue_dummy_init & buf_valid_one) | */issue_dummy_last | buf_valid_all))
                | (~issue_stall & issue_valid & issue_func[AX_FUNC_R]                                                                    )
		;
assign	a_address[(ADDR_WIDTH-1):12] = issue_addr[(ADDR_WIDTH-1):12];
assign	a_address[11:0] = ({(12){ issue_func[AX_FUNC_SINGLE]}} & issue_single_addr)
                        | ({(12){~issue_func[AX_FUNC_SINGLE]}} & {issue_burst_addr[11:6], 6'b0})
			;
assign	issue_single_addr = ({(12){(issue_burst == AXI_BURST_FIXED)}} & issue_single_addr_fixed)
                          | ({(12){(issue_burst == AXI_BURST_INCR )}} & issue_single_addr_incr )
                          | ({(12){(issue_burst == AXI_BURST_WRAP )}} & issue_single_addr_wrap )
		          ;
assign	issue_burst_addr = issue_single_addr_incr;

assign	issue_single_addr_fixed = ({(12){(issue_size == AXI_SIZE_BYTE  )}} & ( issue_addr[11:0]       ))
                                | ({(12){(issue_size == AXI_SIZE_HWORD )}} & ({issue_addr[11:1], 1'b0}))
                                | ({(12){(issue_size == AXI_SIZE_WORD  )}} & ({issue_addr[11:2], 2'b0}))
                                | ({(12){(issue_size == AXI_SIZE_DWORD )}} & ({issue_addr[11:3], 3'b0}))
                                | ({(12){(issue_size == AXI_SIZE_QWORD )}} & ({issue_addr[11:4], 4'b0}))
                                | ({(12){(issue_size == AXI_SIZE_DQWORD)}} & ({issue_addr[11:5], 5'b0}))
                                | ({(12){(issue_size == AXI_SIZE_QQWORD)}} & ({issue_addr[11:6], 6'b0}))
                                ;

assign	issue_single_addr_incr_single_byte   =  issue_addr[11:0]        + {4'b0, issue_cnt[7:0]      };
assign	issue_single_addr_incr_single_hword  = {issue_addr[11:1], 1'b0} + {3'b0, issue_cnt[7:0], 1'b0};
assign	issue_single_addr_incr_single_word   = {issue_addr[11:2], 2'b0} + {2'b0, issue_cnt[7:0], 2'b0};
assign	issue_single_addr_incr_single_dword  = {issue_addr[11:3], 3'b0} + {1'b0, issue_cnt[7:0], 3'b0};
assign	issue_single_addr_incr_single_qword  = {issue_addr[11:4], 4'b0} + {      issue_cnt[7:0], 4'b0};
assign	issue_single_addr_incr_single_dqword = {issue_addr[11:5], 5'b0} + {      issue_cnt[6:0], 5'b0};
assign	issue_single_addr_incr_single_qqword = {issue_addr[11:6], 6'b0} + {      issue_cnt[5:0], 6'b0};
generate
if (DATA_WIDTH > 256) begin: gen_issue_single_addr_dw_gt_256
	assign	issue_single_addr_incr_burst_write   = {issue_addr[11:6], {BUF_OFFSET_WIDTH{1'b0}}};
end
else begin: gen_issue_single_addr_dw_le_256
	assign	issue_single_addr_incr_burst_write   = {issue_addr[11:6], issue_cnt[(5-BUF_OFFSET_WIDTH):0], {BUF_OFFSET_WIDTH{1'b0}}};
end
endgenerate
assign	issue_single_addr_incr_burst_read    = {issue_addr[11:6], 6'b0} + {      issue_cnt[5:0],                     6'b0    };

assign	issue_single_addr_incr = ({(12){ issue_func[AX_FUNC_SINGLE] & (issue_size == AXI_SIZE_BYTE  )}} & issue_single_addr_incr_single_byte[11:0]  )
                               | ({(12){ issue_func[AX_FUNC_SINGLE] & (issue_size == AXI_SIZE_HWORD )}} & issue_single_addr_incr_single_hword[11:0] )
                               | ({(12){ issue_func[AX_FUNC_SINGLE] & (issue_size == AXI_SIZE_WORD  )}} & issue_single_addr_incr_single_word[11:0]  )
                               | ({(12){ issue_func[AX_FUNC_SINGLE] & (issue_size == AXI_SIZE_DWORD )}} & issue_single_addr_incr_single_dword[11:0] )
                               | ({(12){ issue_func[AX_FUNC_SINGLE] & (issue_size == AXI_SIZE_QWORD )}} & issue_single_addr_incr_single_qword[11:0] )
                               | ({(12){ issue_func[AX_FUNC_SINGLE] & (issue_size == AXI_SIZE_DQWORD)}} & issue_single_addr_incr_single_dqword[11:0])
                               | ({(12){ issue_func[AX_FUNC_SINGLE] & (issue_size == AXI_SIZE_QQWORD)}} & issue_single_addr_incr_single_qqword[11:0])
                               | ({(12){~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W]          }} & issue_single_addr_incr_burst_write[11:0]  )
                               | ({(12){~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R]          }} & issue_single_addr_incr_burst_read[11:0]   )
                               ;

assign	issue_single_addr_wrap = ({12{((issue_len==8'h1 ) & (issue_size==AXI_SIZE_BYTE  ))}} & {issue_addr[11:1],  issue_single_addr_incr[0]  })
                               | ({12{((issue_len==8'h1 ) & (issue_size==AXI_SIZE_HWORD ))}} & {issue_addr[11:2],  issue_single_addr_incr[1:0]})
                               | ({12{((issue_len==8'h1 ) & (issue_size==AXI_SIZE_WORD  ))}} & {issue_addr[11:3],  issue_single_addr_incr[2:0]})
                               | ({12{((issue_len==8'h1 ) & (issue_size==AXI_SIZE_DWORD ))}} & {issue_addr[11:4],  issue_single_addr_incr[3:0]})
                               | ({12{((issue_len==8'h1 ) & (issue_size==AXI_SIZE_QWORD ))}} & {issue_addr[11:5],  issue_single_addr_incr[4:0]})
                               | ({12{((issue_len==8'h1 ) & (issue_size==AXI_SIZE_DQWORD))}} & {issue_addr[11:6],  issue_single_addr_incr[5:0]})
                               | ({12{((issue_len==8'h1 ) & (issue_size==AXI_SIZE_QQWORD))}} & {issue_addr[11:7],  issue_single_addr_incr[6:0]})
                               | ({12{((issue_len==8'h3 ) & (issue_size==AXI_SIZE_BYTE  ))}} & {issue_addr[11:2],  issue_single_addr_incr[1:0]})
                               | ({12{((issue_len==8'h3 ) & (issue_size==AXI_SIZE_HWORD ))}} & {issue_addr[11:3],  issue_single_addr_incr[2:0]})
                               | ({12{((issue_len==8'h3 ) & (issue_size==AXI_SIZE_WORD  ))}} & {issue_addr[11:4],  issue_single_addr_incr[3:0]})
                               | ({12{((issue_len==8'h3 ) & (issue_size==AXI_SIZE_DWORD ))}} & {issue_addr[11:5],  issue_single_addr_incr[4:0]})
                               | ({12{((issue_len==8'h3 ) & (issue_size==AXI_SIZE_QWORD ))}} & {issue_addr[11:6],  issue_single_addr_incr[5:0]})
                               | ({12{((issue_len==8'h3 ) & (issue_size==AXI_SIZE_DQWORD))}} & {issue_addr[11:7],  issue_single_addr_incr[6:0]})
                               | ({12{((issue_len==8'h3 ) & (issue_size==AXI_SIZE_QQWORD))}} & {issue_addr[11:8],  issue_single_addr_incr[7:0]})
                               | ({12{((issue_len==8'h7 ) & (issue_size==AXI_SIZE_BYTE  ))}} & {issue_addr[11:3],  issue_single_addr_incr[2:0]})
                               | ({12{((issue_len==8'h7 ) & (issue_size==AXI_SIZE_HWORD ))}} & {issue_addr[11:4],  issue_single_addr_incr[3:0]})
                               | ({12{((issue_len==8'h7 ) & (issue_size==AXI_SIZE_WORD  ))}} & {issue_addr[11:5],  issue_single_addr_incr[4:0]})
                               | ({12{((issue_len==8'h7 ) & (issue_size==AXI_SIZE_DWORD ))}} & {issue_addr[11:6],  issue_single_addr_incr[5:0]})
                               | ({12{((issue_len==8'h7 ) & (issue_size==AXI_SIZE_QWORD ))}} & {issue_addr[11:7],  issue_single_addr_incr[6:0]})
                               | ({12{((issue_len==8'h7 ) & (issue_size==AXI_SIZE_DQWORD))}} & {issue_addr[11:8],  issue_single_addr_incr[7:0]})
                               | ({12{((issue_len==8'h7 ) & (issue_size==AXI_SIZE_QQWORD))}} & {issue_addr[11:9],  issue_single_addr_incr[8:0]})
                               | ({12{((issue_len==8'hf ) & (issue_size==AXI_SIZE_BYTE  ))}} & {issue_addr[11:4],  issue_single_addr_incr[3:0]})
                               | ({12{((issue_len==8'hf ) & (issue_size==AXI_SIZE_HWORD ))}} & {issue_addr[11:5],  issue_single_addr_incr[4:0]})
                               | ({12{((issue_len==8'hf ) & (issue_size==AXI_SIZE_WORD  ))}} & {issue_addr[11:6],  issue_single_addr_incr[5:0]})
                               | ({12{((issue_len==8'hf ) & (issue_size==AXI_SIZE_DWORD ))}} & {issue_addr[11:7],  issue_single_addr_incr[6:0]})
                               | ({12{((issue_len==8'hf ) & (issue_size==AXI_SIZE_QWORD ))}} & {issue_addr[11:8],  issue_single_addr_incr[7:0]})
                               | ({12{((issue_len==8'hf ) & (issue_size==AXI_SIZE_DQWORD))}} & {issue_addr[11:9],  issue_single_addr_incr[8:0]})
                               | ({12{((issue_len==8'hf ) & (issue_size==AXI_SIZE_QQWORD))}} & {issue_addr[11:10], issue_single_addr_incr[9:0]})
                               ;       

// DATA_WIDTH >= 512 will no dummy transaction
assign	issue_dummy_init = (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_burst_addr[5]   < issue_addr[5]       ) & (DATA_WIDTH == 256))
		         | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_burst_addr[5:4] < issue_addr[5:4]     ) & (DATA_WIDTH == 128))
		         | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_burst_addr[5:3] < issue_addr[5:3]     ) & (DATA_WIDTH == 64 ))
		         | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_burst_addr[5:2] < issue_addr[5:2]     ) & (DATA_WIDTH == 32 ))
			 ;
assign	issue_dummy_last = (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_burst_addr[5]   > issue_addr_last[5]  ) & (DATA_WIDTH == 256))
		         | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_burst_addr[5:4] > issue_addr_last[5:4]) & (DATA_WIDTH == 128))
		         | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_burst_addr[5:3] > issue_addr_last[5:3]) & (DATA_WIDTH == 64 ))
		         | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_burst_addr[5:2] > issue_addr_last[5:2]) & (DATA_WIDTH == 32 ))
		         ;

assign	a_opcode = ({(3){issue_func[AX_FUNC_W]}} & TL_OP_PUTPART)
                 | ({(3){issue_func[AX_FUNC_R]}} & TL_OP_GET)
		 ;

assign	a_size[2:0] = ({(3){ issue_func[AX_FUNC_SINGLE]}} & issue_size)
                    | ({(3){~issue_func[AX_FUNC_SINGLE]}} & 3'h6)
                    ;
assign	a_user[6:0] = issue_user[6:0];

generate
if (DATA_WIDTH > 256) begin: gen_a_last_dw_gt_256
	assign	a_last = ( issue_func[AX_FUNC_SINGLE])
	               | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W])
	               | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R])
	               ;
end
else begin: gen_a_last_dw_le_256
	assign	a_last = ( issue_func[AX_FUNC_SINGLE])
	               | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (&issue_cnt[5-BUF_OFFSET_WIDTH:0]))
	               | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R]                                   )
	               ;
end
endgenerate


assign buf_cur_offset_inc = (wvalid & wready) | (rvalid & rready);
wire nds_unused_buf_cur_offset_carry; // don't care the carry, the offset will be wrap around
assign {nds_unused_buf_cur_offset_carry, buf_cur_offset_nx} = buf_cur_offset + buf_offset_unit;

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		buf_offset_unit <= 6'b0;
		buf_cur_offset <= 6'b0;
	end
	else if (issue_valid_set) begin
		buf_offset_unit <= buf_offset_unit_init;
		buf_cur_offset <= buf_cur_offset_init;
	end
	else if (buf_cur_offset_inc) begin
		buf_cur_offset <= buf_cur_offset_nx;
	end
end

// Maximum DW is 256, when read/write AXI_SIZE_DQWORD, 
// the offset is equal to zero
assign	buf_offset_unit_init = ({6{(axsize==AXI_SIZE_BYTE  )}} & 6'h1 )
                             | ({6{(axsize==AXI_SIZE_HWORD )}} & 6'h2 )
                             | ({6{(axsize==AXI_SIZE_WORD  )}} & 6'h4 )
                             | ({6{(axsize==AXI_SIZE_DWORD )}} & 6'h8 )
                             | ({6{(axsize==AXI_SIZE_QWORD )}} & 6'h10)
                             | ({6{(axsize==AXI_SIZE_DQWORD)}} & 6'h20)
		             ;

assign	buf_cur_offset_init = ({6{(axsize==AXI_SIZE_BYTE  )}} &  axaddr[5:0]       )
                            | ({6{(axsize==AXI_SIZE_HWORD )}} & {axaddr[5:1], 1'b0})
                            | ({6{(axsize==AXI_SIZE_WORD  )}} & {axaddr[5:2], 2'b0})
                            | ({6{(axsize==AXI_SIZE_DWORD )}} & {axaddr[5:3], 3'b0})
                            | ({6{(axsize==AXI_SIZE_QWORD )}} & {axaddr[5:4], 4'b0})
                            | ({6{(axsize==AXI_SIZE_DQWORD)}} & {axaddr[5],   5'b0})
		            ;

assign	buf_w_cnt_inc = wvalid & wready;

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		buf_w_cnt <= 9'b0;
	end
	else if (issue_valid_set) begin
		buf_w_cnt <= 9'b0;
	end
	else if (buf_w_cnt_inc) begin
		buf_w_cnt <= buf_w_cnt + 9'b1;
	end
end

assign	buf_w_stall = (buf_w_cnt == ({1'b0, issue_len} + 9'b1));

assign	buf_valid_mask = ({6{(issue_size==AXI_SIZE_BYTE  )}} & 6'h0  )
                       | ({6{(issue_size==AXI_SIZE_HWORD )}} & 6'h1  )
                       | ({6{(issue_size==AXI_SIZE_WORD  )}} & 6'h3  )
                       | ({6{(issue_size==AXI_SIZE_DWORD )}} & 6'h7  )
                       | ({6{(issue_size==AXI_SIZE_QWORD )}} & 6'hf  )
                       | ({6{(issue_size==AXI_SIZE_DQWORD)}} & 6'h1f )
                       | ({6{(issue_size==AXI_SIZE_QQWORD)}} & 6'h3f )
		       ;

assign buf_valid_one_en = (|buf_valid_w_set) | buf_valid_r_set | buf_valid_w_clr | (|buf_valid_r_clr);

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		buf_valid_one <= 1'b0;
	end
	else if (buf_valid_one_en) begin
		buf_valid_one <= buf_valid_one_nx;
	end
end
assign	buf_valid_one_nx = |((buf_valid_w_set | {DATA_BYTES{buf_valid_r_set}}) | (buf_valid & {DATA_BYTES{~buf_valid_w_clr}} & ~buf_valid_r_clr));

assign	buf_valid_all_en = (|buf_valid_w_set) | buf_valid_r_set | buf_valid_w_clr | (|buf_valid_r_clr);

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		buf_valid_all <= 1'b0;
	end
	else if (buf_valid_all_en) begin
		buf_valid_all <= buf_valid_all_nx;
	end
end
assign	buf_valid_all_nx = &((buf_valid_w_set | {DATA_BYTES{buf_valid_r_set}}) | (buf_valid & {DATA_BYTES{~buf_valid_w_clr}} & ~buf_valid_r_clr));

assign	buf_valid_r_set = d_valid & d_ready & (d_opcode == TL_OP_ACCESSACKDATA) & (~resp_dummy);
assign	buf_valid_w_clr = a_valid & a_ready & (a_opcode == TL_OP_PUTPART) & (~issue_dummy_init);

generate
genvar buf_idx;
for (buf_idx = 0; buf_idx < (DATA_WIDTH/8); buf_idx = buf_idx + 1) begin: gen_buf_valid
	wire		a_r_mask;
	wire		buf_strb_w_nx;
	wire		buf_strb_w_en = buf_valid_w_clr | (buf_valid_w_set[buf_idx] & wstrb[buf_idx]);
	wire	[7:0]	buf_data_w_nx;
	wire		buf_strb_r_nx;
	wire		buf_strb_r_en = buf_valid_r_clr[buf_idx] | buf_valid_r_set;
	wire	[7:0]	buf_data_r_nx;
	wire		buf_valid_en = buf_valid_w_clr | buf_valid_w_set[buf_idx] | buf_valid_r_clr[buf_idx] | buf_valid_r_set;

	assign	buf_valid_w_set[buf_idx] = (wvalid & wready &  issue_func[AX_FUNC_SINGLE])
	                                 | (wvalid & wready & ~issue_func[AX_FUNC_SINGLE] & ((buf_cur_offset[(BUF_OFFSET_WIDTH-1):0] | buf_valid_mask[(BUF_OFFSET_WIDTH-1):0]) == (buf_idx[(BUF_OFFSET_WIDTH-1):0] | buf_valid_mask[(BUF_OFFSET_WIDTH-1):0])))
	                                 | (wvalid & wready & ~issue_func[AX_FUNC_SINGLE] & (&(buf_cur_offset[(BUF_OFFSET_WIDTH-1):0] | buf_valid_mask[(BUF_OFFSET_WIDTH-1):0])))
	                                 | (wvalid & wready & ~issue_func[AX_FUNC_SINGLE] & wlast)
		                         ;
	assign	buf_valid_r_clr[buf_idx] = (rvalid & rready &  issue_func[AX_FUNC_SINGLE])
	                                 | (rvalid & rready & ~issue_func[AX_FUNC_SINGLE] & ((buf_cur_offset[(BUF_OFFSET_WIDTH-1):0] | buf_valid_mask[(BUF_OFFSET_WIDTH-1):0]) == (buf_idx[(BUF_OFFSET_WIDTH-1):0] | buf_valid_mask[(BUF_OFFSET_WIDTH-1):0])))
	                                 | (rvalid & rready & ~issue_func[AX_FUNC_SINGLE] & (&(buf_cur_offset[(BUF_OFFSET_WIDTH-1):0] | buf_valid_mask[(BUF_OFFSET_WIDTH-1):0])))
	                                 | (rvalid & rready & ~issue_func[AX_FUNC_SINGLE] & rlast)
	                                 ;

	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			buf_valid[buf_idx] <= 1'b0;
		end
		else if (buf_valid_en) begin
			buf_valid[buf_idx] <= buf_valid_w_set[buf_idx] | buf_valid_r_set;
		end
	end

	assign buf_strb_w_nx = buf_valid_w_set[buf_idx] & wstrb[buf_idx];
	assign buf_data_w_nx = {8{ buf_valid_w_set[buf_idx]}} & wdata[8*buf_idx+:8]; 
	assign buf_strb_r_nx = 1'b0;
	assign buf_data_r_nx = {8{ buf_valid_r_set}} & d_data[8*buf_idx+:8];

	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			buf_strb[buf_idx] <= 1'b0;
			buf_data[buf_idx] <= 8'b0;
		end
		else if (buf_strb_w_en) begin
			buf_strb[buf_idx] <= buf_strb_w_nx;
			buf_data[buf_idx] <= buf_data_w_nx;
		end
		else if (buf_strb_r_en) begin
			buf_strb[buf_idx] <= buf_strb_r_nx;
			buf_data[buf_idx] <= buf_data_r_nx;
		end
	end

	assign	a_r_mask = ((issue_single_addr[(BUF_OFFSET_WIDTH-1):0] | buf_valid_mask[(BUF_OFFSET_WIDTH-1):0]) == (buf_idx[(BUF_OFFSET_WIDTH-1):0] | buf_valid_mask[(BUF_OFFSET_WIDTH-1):0]));
	assign	a_mask[buf_idx] = ( issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W]                                          & buf_strb[buf_idx])
	                        | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & ~(issue_dummy_init | issue_dummy_last) & buf_strb[buf_idx])
	                        | ( issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & a_r_mask                                                  )
	                        | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R]                                                             )
				;
	assign	a_data[buf_idx*8+:8] = {8{~(issue_dummy_init | issue_dummy_last)}} & buf_data[buf_idx];

end
endgenerate

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		resp_valid <= 1'b0;
	end
	else if (resp_valid_en) begin
		resp_valid <= resp_valid_set;
	end
end

assign	resp_valid_set  = issue_valid_set;
assign	resp_valid_clr = d_valid & d_ready & resp_last ;

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		resp_stall <= 1'b0;
	end
	else if (resp_stall_en) begin
		resp_stall <= resp_stall_set;
	end
end

// DATA_WIDTH >= 512 will no stall response
assign	resp_stall_set = (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[  0] != 1'b1   ) & (DATA_WIDTH == 256))
                       | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[1:0] != 2'b11  ) & (DATA_WIDTH == 128))
                       | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[2:0] != 3'b111 ) & (DATA_WIDTH == 64 ))
                       | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[3:0] != 4'b1111) & (DATA_WIDTH == 32 ))
                       ;
assign	resp_stall_clr = (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[  0] == 1'b1   ) & (DATA_WIDTH == 256))
                       | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[1:0] == 2'b11  ) & (DATA_WIDTH == 128))
                       | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[2:0] == 3'b111 ) & (DATA_WIDTH == 64 ))
                       | (a_valid & a_ready & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & (issue_cnt[3:0] == 4'b1111) & (DATA_WIDTH == 32 ))
                       ;

assign	d_ready = (resp_valid & issue_func[AX_FUNC_W] & ~resp_stall & ~buf_resp_valid)
                | (resp_valid & issue_func[AX_FUNC_R] & (~|(buf_valid & ~buf_valid_r_clr)))
		;


// DATA_WIDTH >= 512 will no dummy response
assign	resp_dummy = (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_burst_addr[5]   < issue_addr[5]       ) & (resp_cnt[6:1] == 6'h0          ) & (DATA_WIDTH == 256))
		   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_burst_addr[5:4] < issue_addr[5:4]     ) & (resp_cnt[7:2] == 6'h0          ) & (DATA_WIDTH == 128))
		   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_burst_addr[5:3] < issue_addr[5:3]     ) & (resp_cnt[8:3] == 6'h0          ) & (DATA_WIDTH == 64 ))
		   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_burst_addr[5:2] < issue_addr[5:2]     ) & (resp_cnt[8:4] == 5'h0          ) & (DATA_WIDTH == 32 ))
		   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_burst_addr[5]   > issue_addr_last[5]  ) & (resp_cnt[6:1] == issue_burst_len[5:0]) & (DATA_WIDTH == 256))
		   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_burst_addr[5:4] > issue_addr_last[5:4]) & (resp_cnt[7:2] == issue_burst_len[5:0]) & (DATA_WIDTH == 128))
		   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_burst_addr[5:3] > issue_addr_last[5:3]) & (resp_cnt[8:3] == issue_burst_len[5:0]) & (DATA_WIDTH == 64 ))
		   | (~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_R] & (resp_burst_addr[5:2] > issue_addr_last[5:2]) & (resp_cnt[8:4] == issue_burst_len[4:0]) & (DATA_WIDTH == 32 ))
		   ;

assign	resp_burst_addr = ({(12){issue_func[AX_FUNC_R]}} & {3'b0, resp_cnt[(8-BUF_OFFSET_WIDTH):0], {BUF_OFFSET_WIDTH{1'b0}}});

assign	buf_w_ready = buf_valid & ~({DATA_BYTES{buf_valid_w_clr & ~buf_w_stall}});

assign	wready = (issue_valid &  issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & ~issue_valid_clr & ~(|buf_w_ready)                 )
               | (issue_valid & ~issue_func[AX_FUNC_SINGLE] & issue_func[AX_FUNC_W] & ~issue_valid_clr & ~(&buf_w_ready) & (~issue_dummy_last))
	       ;

reg	rvalid_arb_req;
wire	rvalid_arb_req_en = buf_valid_r_set | (|buf_valid_r_clr);
wire	rvalid_arb_req_nx;
always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		rvalid_arb_req <= 1'b0;
	end
	else if (rvalid_arb_req_en) begin
		rvalid_arb_req <= rvalid_arb_req_nx;
	end
end
assign	rvalid_arb_req_nx = buf_valid_r_set | (|(buf_valid & ~buf_valid_r_clr));

assign	rvalid = rvalid_arb_req;
assign	rresp = {2{issue_func[AX_FUNC_R]}} & buf_resp;
generate
genvar resp_data_idx;
for (resp_data_idx = 0; resp_data_idx < (DATA_WIDTH/8); resp_data_idx = resp_data_idx + 1) begin: gen_resp_data
	assign	rdata[resp_data_idx*8+:8] = buf_data[resp_data_idx];
end
endgenerate
assign	rlast = issue_func[AX_FUNC_R] & retire_last;

reg	bvalid_arb_req;
wire	bvalid_arb_req_en = (buf_resp_merge & resp_last) | (bvalid & bready);
wire	bvalid_arb_req_nx;
always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		bvalid_arb_req <= 1'b0;
	end
	else if (bvalid_arb_req_en) begin
		bvalid_arb_req <= bvalid_arb_req_nx;
	end
end
assign	bvalid_arb_req_nx = (buf_resp_merge & resp_last);

assign	bvalid = bvalid_arb_req;
assign	bresp = {2{issue_func[AX_FUNC_W]}} & buf_resp;

assign	retire_cnt_clr = rvalid & rready & rlast;
assign	retire_cnt_inc = rvalid & rready;
always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		retire_cnt <= 8'b0;
	end
	else if (retire_cnt_clr) begin
		retire_cnt <= 8'b0;
	end
	else if (retire_cnt_inc) begin
		retire_cnt <= retire_cnt + 8'b1;
	end
end


assign	buf_resp_valid_set = buf_resp_new | (buf_resp_merge & resp_last);

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		buf_resp_valid <= 1'b0;
	end
	else if (buf_resp_clr) begin
		buf_resp_valid <= 1'b0;
	end
	else if (buf_resp_valid_set) begin
		buf_resp_valid <= 1'b1;
	end
end

assign	buf_resp_set = buf_resp_new | buf_resp_merge;

always @ (posedge clk or negedge resetn) begin
	if (!resetn) begin
		buf_resp <= 2'b0;
	end
	else if (buf_resp_clr) begin
		buf_resp <= 2'b0;
	end
	else if (buf_resp_set) begin
		buf_resp <= buf_resp_nx;
	end
end

assign 	buf_resp_new   = d_valid & d_ready & (d_opcode == TL_OP_ACCESSACKDATA) & (~resp_dummy);
assign 	buf_resp_merge = d_valid & d_ready & (d_opcode == TL_OP_ACCESSACK);
assign	buf_resp_nx = {2{buf_resp_new}}   & (           {d_user[1], (d_user[1] & d_user[0])} | {d_denied, 1'b0} | {d_corrupt, 1'b0})
                    | {2{buf_resp_merge}} & (buf_resp | {d_user[1], (d_user[1] & d_user[0])} | {d_denied, 1'b0} | {d_corrupt, 1'b0})
		    ;
assign	buf_resp_clr = rvalid & rready & rlast | bvalid & bready;

`ifdef OVL_ASSERT_ON
// pragma coverage off
reg [1:0] cnt;
wire cnt_inc = axvalid & axready;
wire cnt_dec = (bvalid & bready) | (rvalid & rready & rlast);
wire [1:0] cnt_nx = (cnt_inc & !cnt_dec) ? cnt + 2'b1:
                    (!cnt_inc & cnt_dec) ? cnt - 2'd1:
                    cnt;
always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
                cnt <= 2'd0;
        end else begin
                cnt <= cnt_nx;
        end
end

wire	u_ovl_never_cnt_overflow_enable = 1'b1; 
wire	u_ovl_never_cnt_overflow_test_expr = cnt>1;
ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_never_cnt_overflow_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_never_cnt_overflow_enable	),
	.test_expr	(u_ovl_never_cnt_overflow_test_expr	),
	.fire		(				)
);

wire	u_ovl_always_a_opcode_enable = a_valid & a_ready; 
wire	u_ovl_always_a_opcode_test_expr = (a_opcode == 3'd1) | (a_opcode == 3'd4);
ovl_always #(
	.msg		(`__FILE__	)
) u_ovl_always_a_opcode_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_always_a_opcode_enable	),
	.test_expr	(u_ovl_always_a_opcode_test_expr	),
	.fire		(				)
);

wire	u_ovl_always_d_opcode_enable = d_valid & d_ready; 
wire	u_ovl_always_d_opcode_test_expr = (d_opcode == 3'd0) | (d_opcode == 3'd1);
ovl_always #(
	.msg		(`__FILE__	)
) u_ovl_always_d_opcode_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_always_d_opcode_enable	),
	.test_expr	(u_ovl_always_d_opcode_test_expr	),
	.fire		(				)
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (2          )
) u_zero_one_hot_issue_valid_set_issue_valid_clr_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  ({issue_valid_set, issue_valid_clr} ),
    .fire       (                       )
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (2          )
) u_zero_one_hot_issue_valid_set_issue_cnt_inc_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  ({issue_valid_set, issue_cnt_inc} ),
    .fire       (                       )
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (2          )
) u_zero_one_hot_issue_valid_set_resp_cnt_inc_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  ({issue_valid_set, resp_cnt_inc} ),
    .fire       (                       )
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (2          )
) u_zero_one_hot_issue_stall_set_issue_stall_clr_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  ({issue_stall_set, issue_stall_clr} ),
    .fire       (                       )
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (2          )
) u_zero_one_hot_issue_valid_set_buf_cur_offset_inc_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  ({issue_valid_set, buf_cur_offset_inc} ),
    .fire       (                       )
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (2          )
) u_zero_one_hot_issue_valid_set_buf_w_cnt_inc_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  ({issue_valid_set, buf_w_cnt_inc} ),
    .fire       (                       )
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (2          )
) u_zero_one_hot_buf_valid_w_set_buf_valid_r_set_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  ({(|buf_valid_w_set), buf_valid_r_set} ),
    .fire       (                       )
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (2          )
) u_zero_one_hot_buf_valid_w_clr_buf_valid_r_clr_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  ({buf_valid_w_clr, (|buf_valid_r_clr)} ),
    .fire       (                       )
);

ovl_zero_one_hot #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (2          )
) u_zero_one_hot_resp_stall_set_resp_stall_clr_chk (
    .clock      (clk                    ),
    .reset      (resetn                 ),
    .enable     (1'b1                   ),
    .test_expr  ({resp_stall_set, resp_stall_clr} ),
    .fire       (                       )
);

wire    tl_a_trans = a_valid & a_ready;
wire[(ADDR_WIDTH-1):0] a_end_address = a_address + (1<<a_size) - 1;
wire    addr_cross_64byte = a_end_address[(ADDR_WIDTH-1):6] != a_address [(ADDR_WIDTH-1):6];
wire    addr_cross_4KB = a_end_address[(ADDR_WIDTH-1):12] != a_address [(ADDR_WIDTH-1):12];

wire	u_ovl_always_mem_wr_INCR_enable = tl_a_trans & issue_func[AX_FUNC_W] & (issue_func[AX_FUNC_MEM] & issue_user[6:4] != 3'b000) & (issue_burst == AXI_BURST_INCR);
wire	u_ovl_always_mem_wr_INCR_test_expr = (a_size == 3'd6) & ~addr_cross_64byte;
ovl_always #(
	.msg		(`__FILE__	)
) u_ovl_always_mem_wr_INCR_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_always_mem_wr_INCR_enable	),
	.test_expr	(u_ovl_always_mem_wr_INCR_test_expr	),
	.fire		(				)
);

wire	u_ovl_always_mem_rd_INCR_enable = tl_a_trans & issue_func[AX_FUNC_R] & (issue_func[AX_FUNC_MEM] & issue_user[6:4] != 3'b000) & (issue_burst == AXI_BURST_INCR);
wire	u_ovl_always_mem_rd_INCR_test_expr = (a_size == 3'd6) & ~addr_cross_4KB;
ovl_always #(
	.msg		(`__FILE__	)
) u_ovl_always_mem_rd_INCR_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_always_mem_rd_INCR_enable	),
	.test_expr	(u_ovl_always_mem_rd_INCR_test_expr	),
	.fire		(				)
);

localparam DATA_BYTE_WIDTH = $clog2(DATA_WIDTH/8);
wire	u_ovl_always_device_rw_INCR_enable = tl_a_trans & ~(issue_func[AX_FUNC_MEM] & issue_user[6:4] != 3'b000) & (issue_burst == AXI_BURST_INCR);
wire	u_ovl_always_device_rw_INCR_test_expr = (a_size <= DATA_BYTE_WIDTH) & ~addr_cross_4KB;
ovl_always #(
	.msg		(`__FILE__	)
) u_ovl_always_device_rw_INCR_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_always_device_rw_INCR_enable	),
	.test_expr	(u_ovl_always_device_rw_INCR_test_expr	),
	.fire		(				)
);

reg [ADDR_WIDTH-1:0] exp_addr;
always @(posedge clk or negedge resetn) begin
        if (!resetn)
                exp_addr <= {ADDR_WIDTH{1'b0}};
        else begin
                if (issue_valid_set)
                        exp_addr <= (axaddr >> axsize) << axsize;
        end
end

wire	u_ovl_always_device_rw_FIXED_enable = tl_a_trans & (issue_burst == AXI_BURST_FIXED);
wire	u_ovl_always_device_rw_FIXED_test_expr = (a_size <= DATA_BYTE_WIDTH) & (exp_addr == a_address);
ovl_always #(
	.msg		(`__FILE__	)
) u_ovl_always_device_rw_FIXED_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_always_device_rw_FIXED_enable	),
	.test_expr	(u_ovl_always_device_rw_FIXED_test_expr	),
	.fire		(				)
);

wire [2:0] len_log2 = ({3{(issue_len == 8'd1 )}} & 3'd1)
                    | ({3{(issue_len == 8'd3 )}} & 3'd2)
                    | ({3{(issue_len == 8'd7 )}} & 3'd3)
                    | ({3{(issue_len == 8'd15)}} & 3'd4);
wire [3:0] sft_amt = len_log2 + issue_size;
wire [ADDR_WIDTH-1:0] wrap_boundary = issue_addr >> sft_amt;
wire [ADDR_WIDTH-1:0] a_address_boundary = a_address >> sft_amt;
wire	u_ovl_always_device_rw_WRAP_enable = tl_a_trans & (issue_burst == AXI_BURST_WRAP);
wire	u_ovl_always_device_rw_WRAP_test_expr = (a_size <= DATA_BYTE_WIDTH) & (wrap_boundary == a_address_boundary);
ovl_always #(
	.msg		(`__FILE__	)
) u_ovl_always_device_rw_WRAP_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_always_device_rw_WRAP_enable	),
	.test_expr	(u_ovl_always_device_rw_WRAP_test_expr	),
	.fire		(				)
);


wire [11:0] st_addr = (issue_addr[11:0] >> issue_size) << issue_size;
wire [11:0] end_addr = st_addr + ((issue_len + 12'd1) << issue_size) - 12'd1;
wire [6:0] max_burst_cnt = (end_addr[11:6] - st_addr[11:6]) + 6'd1;
reg [6:0] burst_cnt;
always @ (posedge clk or negedge resetn) begin
        if (!resetn)
                burst_cnt <= 7'd0;
        else begin
                if (issue_valid_set)
                        burst_cnt <= 7'd0;
                else if (tl_a_trans)
                        burst_cnt <= burst_cnt + 7'd1;
        end
end

wire	u_ovl_always_rd_burst_cnt_enable = tl_a_trans & (issue_func[AX_FUNC_MEM] & issue_user[6:4] != 3'b000) & issue_func[AX_FUNC_R] & (issue_burst == AXI_BURST_INCR);
wire	u_ovl_always_rd_burst_cnt_test_expr = (a_size == 3'd6) & (burst_cnt < max_burst_cnt);
ovl_always #(
	.msg		(`__FILE__	)
) u_ovl_always_rd_burst_cnt_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_always_rd_burst_cnt_enable	),
	.test_expr	(u_ovl_always_rd_burst_cnt_test_expr	),
	.fire		(				)
);

reg a_valid_d1;
reg a_ready_d1;
always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
                a_valid_d1 <= 1'b0;
                a_ready_d1 <= 1'b0;
        end else begin 
                a_valid_d1 <= a_valid;
                a_ready_d1 <= a_ready;
        end
end
wire a_valid_deassert = a_valid_d1 & ~a_valid;

wire	u_ovl_never_a_valid_deassert_wo_a_ready_enable = 1'b1;
wire	u_ovl_never_a_valid_deassert_wo_a_ready_test_expr = a_valid_deassert & ~a_ready_d1;
ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_never_a_valid_deassert_wo_a_ready_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_never_a_valid_deassert_wo_a_ready_enable	),
	.test_expr	(u_ovl_never_a_valid_deassert_wo_a_ready_test_expr	),
	.fire		(				)
);

reg d_valid_d1;
reg d_ready_d1;
always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
                d_valid_d1 <= 1'b0;
                d_ready_d1 <= 1'b0;
        end else begin 
                d_valid_d1 <= d_valid;
                d_ready_d1 <= d_ready;
        end
end
wire d_valid_deassert = d_valid_d1 & ~d_valid;

wire	u_ovl_never_d_valid_deassert_wo_d_ready_enable = 1'b1;
wire	u_ovl_never_d_valid_deassert_wo_d_ready_test_expr = d_valid_deassert & ~d_ready_d1;
ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_never_d_valid_deassert_wo_d_ready_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_never_d_valid_deassert_wo_d_ready_enable	),
	.test_expr	(u_ovl_never_d_valid_deassert_wo_d_ready_test_expr	),
	.fire		(				)
);

wire	u_ovl_never_rd_cmd_buf_valid_w_set_enable = issue_func[AX_FUNC_R];
wire	u_ovl_never_rd_cmd_buf_valid_w_set_test_expr = wvalid & wready;
ovl_never #(
	.msg		(`__FILE__	)
) u_ovl_never_rd_cmd_buf_valid_w_set_chk (
	.clock		(clk				),
	.reset		(resetn				),
	.enable		(u_ovl_never_rd_cmd_buf_valid_w_set_enable	),
	.test_expr	(u_ovl_never_rd_cmd_buf_valid_w_set_test_expr	),
	.fire		(				)
);

// pragma coverage on
`endif // OVL_ASSERT_ON
endmodule
