`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

module atcbmc300_ds_addr_ctrl (
// VPERL: &PORTLIST;
// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
	  mst0_addr,
	  mst0_len, 
	  mst0_size,
	  mst0_burst,
	  mst0_lock,
	  mst0_cache,
	  mst0_prot,
	  mst0_aid, 
	  mst0_avalid,
	  mst0_connect,
`endif // ATCBMC300_MST0_SUPPORT
`ifdef ATCBMC300_MST1_SUPPORT
	  mst1_addr,
	  mst1_len, 
	  mst1_size,
	  mst1_burst,
	  mst1_lock,
	  mst1_cache,
	  mst1_prot,
	  mst1_aid, 
	  mst1_avalid,
	  mst1_connect,
`endif // ATCBMC300_MST1_SUPPORT
`ifdef ATCBMC300_MST2_SUPPORT
	  mst2_addr,
	  mst2_len, 
	  mst2_size,
	  mst2_burst,
	  mst2_lock,
	  mst2_cache,
	  mst2_prot,
	  mst2_aid, 
	  mst2_avalid,
	  mst2_connect,
`endif // ATCBMC300_MST2_SUPPORT
`ifdef ATCBMC300_MST3_SUPPORT
	  mst3_addr,
	  mst3_len, 
	  mst3_size,
	  mst3_burst,
	  mst3_lock,
	  mst3_cache,
	  mst3_prot,
	  mst3_aid, 
	  mst3_avalid,
	  mst3_connect,
`endif // ATCBMC300_MST3_SUPPORT
`ifdef ATCBMC300_MST4_SUPPORT
	  mst4_addr,
	  mst4_len, 
	  mst4_size,
	  mst4_burst,
	  mst4_lock,
	  mst4_cache,
	  mst4_prot,
	  mst4_aid, 
	  mst4_avalid,
	  mst4_connect,
`endif // ATCBMC300_MST4_SUPPORT
`ifdef ATCBMC300_MST5_SUPPORT
	  mst5_addr,
	  mst5_len, 
	  mst5_size,
	  mst5_burst,
	  mst5_lock,
	  mst5_cache,
	  mst5_prot,
	  mst5_aid, 
	  mst5_avalid,
	  mst5_connect,
`endif // ATCBMC300_MST5_SUPPORT
`ifdef ATCBMC300_MST6_SUPPORT
	  mst6_addr,
	  mst6_len, 
	  mst6_size,
	  mst6_burst,
	  mst6_lock,
	  mst6_cache,
	  mst6_prot,
	  mst6_aid, 
	  mst6_avalid,
	  mst6_connect,
`endif // ATCBMC300_MST6_SUPPORT
`ifdef ATCBMC300_MST7_SUPPORT
	  mst7_addr,
	  mst7_len, 
	  mst7_size,
	  mst7_burst,
	  mst7_lock,
	  mst7_cache,
	  mst7_prot,
	  mst7_aid, 
	  mst7_avalid,
	  mst7_connect,
`endif // ATCBMC300_MST7_SUPPORT
`ifdef ATCBMC300_MST8_SUPPORT
	  mst8_addr,
	  mst8_len, 
	  mst8_size,
	  mst8_burst,
	  mst8_lock,
	  mst8_cache,
	  mst8_prot,
	  mst8_aid, 
	  mst8_avalid,
	  mst8_connect,
`endif // ATCBMC300_MST8_SUPPORT
`ifdef ATCBMC300_MST9_SUPPORT
	  mst9_addr,
	  mst9_len, 
	  mst9_size,
	  mst9_burst,
	  mst9_lock,
	  mst9_cache,
	  mst9_prot,
	  mst9_aid, 
	  mst9_avalid,
	  mst9_connect,
`endif // ATCBMC300_MST9_SUPPORT
`ifdef ATCBMC300_MST10_SUPPORT
	  mst10_addr,
	  mst10_len,
	  mst10_size,
	  mst10_burst,
	  mst10_lock,
	  mst10_cache,
	  mst10_prot,
	  mst10_aid,
	  mst10_avalid,
	  mst10_connect,
`endif // ATCBMC300_MST10_SUPPORT
`ifdef ATCBMC300_MST11_SUPPORT
	  mst11_addr,
	  mst11_len,
	  mst11_size,
	  mst11_burst,
	  mst11_lock,
	  mst11_cache,
	  mst11_prot,
	  mst11_aid,
	  mst11_avalid,
	  mst11_connect,
`endif // ATCBMC300_MST11_SUPPORT
`ifdef ATCBMC300_MST12_SUPPORT
	  mst12_addr,
	  mst12_len,
	  mst12_size,
	  mst12_burst,
	  mst12_lock,
	  mst12_cache,
	  mst12_prot,
	  mst12_aid,
	  mst12_avalid,
	  mst12_connect,
`endif // ATCBMC300_MST12_SUPPORT
`ifdef ATCBMC300_MST13_SUPPORT
	  mst13_addr,
	  mst13_len,
	  mst13_size,
	  mst13_burst,
	  mst13_lock,
	  mst13_cache,
	  mst13_prot,
	  mst13_aid,
	  mst13_avalid,
	  mst13_connect,
`endif // ATCBMC300_MST13_SUPPORT
`ifdef ATCBMC300_MST14_SUPPORT
	  mst14_addr,
	  mst14_len,
	  mst14_size,
	  mst14_burst,
	  mst14_lock,
	  mst14_cache,
	  mst14_prot,
	  mst14_aid,
	  mst14_avalid,
	  mst14_connect,
`endif // ATCBMC300_MST14_SUPPORT
`ifdef ATCBMC300_MST15_SUPPORT
	  mst15_addr,
	  mst15_len,
	  mst15_size,
	  mst15_burst,
	  mst15_lock,
	  mst15_cache,
	  mst15_prot,
	  mst15_aid,
	  mst15_avalid,
	  mst15_connect,
`endif // ATCBMC300_MST15_SUPPORT
	  addr_outstanding_en,
	  slv_aready,
	  arb_mid,  
	  outstanding_ready,
	  addr,     
	  len,      
	  size,     
	  burst,    
	  lock,     
	  cache,    
	  prot,     
	  aid,      
	  avalid,   
	  aready,   
	  reg_mst0_high_priority,
	  reg_priority_reload,
	  aclk,     
	  aresetn   
// VPERL_GENERATED_END
);
parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 64;
parameter ID_WIDTH   = 4;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB   = ID_WIDTH - 1;

// #VPERL_BEGIN
//  for($i=0;$i<16;$i++) {
// :`ifdef ATCBMC300_MST${i}_SUPPORT
// : input [ADDR_MSB:0] mst${i}_addr;
// : input [7:0]        mst${i}_len;
// : input [2:0]        mst${i}_size;
// : input [1:0]        mst${i}_burst;
// : input              mst${i}_lock;
// : input [3:0]        mst${i}_cache;
// : input [2:0]        mst${i}_prot;
// : input [ID_MSB:0]   mst${i}_aid;       
// : input 	        mst${i}_avalid;
// : input		mst${i}_connect;
// : `endif
// }
// #VPERL_END

// #VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
input [ADDR_MSB:0] mst0_addr;
input [7:0]        mst0_len;
input [2:0]        mst0_size;
input [1:0]        mst0_burst;
input              mst0_lock;
input [3:0]        mst0_cache;
input [2:0]        mst0_prot;
input [ID_MSB:0]   mst0_aid;
input 	        mst0_avalid;
input		mst0_connect;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
input [ADDR_MSB:0] mst1_addr;
input [7:0]        mst1_len;
input [2:0]        mst1_size;
input [1:0]        mst1_burst;
input              mst1_lock;
input [3:0]        mst1_cache;
input [2:0]        mst1_prot;
input [ID_MSB:0]   mst1_aid;
input 	        mst1_avalid;
input		mst1_connect;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
input [ADDR_MSB:0] mst2_addr;
input [7:0]        mst2_len;
input [2:0]        mst2_size;
input [1:0]        mst2_burst;
input              mst2_lock;
input [3:0]        mst2_cache;
input [2:0]        mst2_prot;
input [ID_MSB:0]   mst2_aid;
input 	        mst2_avalid;
input		mst2_connect;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
input [ADDR_MSB:0] mst3_addr;
input [7:0]        mst3_len;
input [2:0]        mst3_size;
input [1:0]        mst3_burst;
input              mst3_lock;
input [3:0]        mst3_cache;
input [2:0]        mst3_prot;
input [ID_MSB:0]   mst3_aid;
input 	        mst3_avalid;
input		mst3_connect;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
input [ADDR_MSB:0] mst4_addr;
input [7:0]        mst4_len;
input [2:0]        mst4_size;
input [1:0]        mst4_burst;
input              mst4_lock;
input [3:0]        mst4_cache;
input [2:0]        mst4_prot;
input [ID_MSB:0]   mst4_aid;
input 	        mst4_avalid;
input		mst4_connect;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
input [ADDR_MSB:0] mst5_addr;
input [7:0]        mst5_len;
input [2:0]        mst5_size;
input [1:0]        mst5_burst;
input              mst5_lock;
input [3:0]        mst5_cache;
input [2:0]        mst5_prot;
input [ID_MSB:0]   mst5_aid;
input 	        mst5_avalid;
input		mst5_connect;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
input [ADDR_MSB:0] mst6_addr;
input [7:0]        mst6_len;
input [2:0]        mst6_size;
input [1:0]        mst6_burst;
input              mst6_lock;
input [3:0]        mst6_cache;
input [2:0]        mst6_prot;
input [ID_MSB:0]   mst6_aid;
input 	        mst6_avalid;
input		mst6_connect;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
input [ADDR_MSB:0] mst7_addr;
input [7:0]        mst7_len;
input [2:0]        mst7_size;
input [1:0]        mst7_burst;
input              mst7_lock;
input [3:0]        mst7_cache;
input [2:0]        mst7_prot;
input [ID_MSB:0]   mst7_aid;
input 	        mst7_avalid;
input		mst7_connect;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
input [ADDR_MSB:0] mst8_addr;
input [7:0]        mst8_len;
input [2:0]        mst8_size;
input [1:0]        mst8_burst;
input              mst8_lock;
input [3:0]        mst8_cache;
input [2:0]        mst8_prot;
input [ID_MSB:0]   mst8_aid;
input 	        mst8_avalid;
input		mst8_connect;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
input [ADDR_MSB:0] mst9_addr;
input [7:0]        mst9_len;
input [2:0]        mst9_size;
input [1:0]        mst9_burst;
input              mst9_lock;
input [3:0]        mst9_cache;
input [2:0]        mst9_prot;
input [ID_MSB:0]   mst9_aid;
input 	        mst9_avalid;
input		mst9_connect;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
input [ADDR_MSB:0] mst10_addr;
input [7:0]        mst10_len;
input [2:0]        mst10_size;
input [1:0]        mst10_burst;
input              mst10_lock;
input [3:0]        mst10_cache;
input [2:0]        mst10_prot;
input [ID_MSB:0]   mst10_aid;
input 	        mst10_avalid;
input		mst10_connect;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
input [ADDR_MSB:0] mst11_addr;
input [7:0]        mst11_len;
input [2:0]        mst11_size;
input [1:0]        mst11_burst;
input              mst11_lock;
input [3:0]        mst11_cache;
input [2:0]        mst11_prot;
input [ID_MSB:0]   mst11_aid;
input 	        mst11_avalid;
input		mst11_connect;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
input [ADDR_MSB:0] mst12_addr;
input [7:0]        mst12_len;
input [2:0]        mst12_size;
input [1:0]        mst12_burst;
input              mst12_lock;
input [3:0]        mst12_cache;
input [2:0]        mst12_prot;
input [ID_MSB:0]   mst12_aid;
input 	        mst12_avalid;
input		mst12_connect;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
input [ADDR_MSB:0] mst13_addr;
input [7:0]        mst13_len;
input [2:0]        mst13_size;
input [1:0]        mst13_burst;
input              mst13_lock;
input [3:0]        mst13_cache;
input [2:0]        mst13_prot;
input [ID_MSB:0]   mst13_aid;
input 	        mst13_avalid;
input		mst13_connect;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
input [ADDR_MSB:0] mst14_addr;
input [7:0]        mst14_len;
input [2:0]        mst14_size;
input [1:0]        mst14_burst;
input              mst14_lock;
input [3:0]        mst14_cache;
input [2:0]        mst14_prot;
input [ID_MSB:0]   mst14_aid;
input 	        mst14_avalid;
input		mst14_connect;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
input [ADDR_MSB:0] mst15_addr;
input [7:0]        mst15_len;
input [2:0]        mst15_size;
input [1:0]        mst15_burst;
input              mst15_lock;
input [3:0]        mst15_cache;
input [2:0]        mst15_prot;
input [ID_MSB:0]   mst15_aid;
input 	        mst15_avalid;
input		mst15_connect;
`endif
// #VPERL_GENERATED_END
output 		    addr_outstanding_en;
output              slv_aready;
output [3:0]        arb_mid;
input               outstanding_ready;

output [ADDR_MSB:0] addr;
output [7:0]        len;
output [2:0]        size;
output [1:0]        burst;
output 	            lock;
output [3:0]        cache;
output [2:0]        prot;
output [(ID_MSB+4):0] aid;
output              avalid;
input               aready;
input              reg_mst0_high_priority;
input [15:0]       reg_priority_reload;
input aclk;
input aresetn;

reg [ADDR_MSB:0] addr;
reg [7:0]        len;
reg [2:0]        size;
reg [1:0]        burst;
reg 	         lock;
reg [3:0]        cache;
reg [2:0]        prot;
reg [ID_MSB:0]   us_aid;
reg              avalid;
reg [3:0]        mid;
wire [ID_MSB+4:0] aid;

reg [ADDR_MSB:0] mst_addr  [0:15];
reg [7:0]        mst_len   [0:15];
reg [2:0]        mst_size  [0:15];
reg [1:0]        mst_burst [0:15];
reg 	         mst_lock  [0:15];
reg [3:0]        mst_cache [0:15];
reg [2:0]        mst_prot  [0:15];
reg [ID_MSB:0]   mst_aid   [0:15];
reg [15:0]       mst_avalid;
reg [15:0]       priority_avalid;
wire [15:0]       arb_avalid;
wire 		pending_priority_avalid;
assign pending_priority_avalid = priority_avalid!=16'h0;
// VPERL_BEGIN
//  for($i=0;$i<16;$i++) {
// :`ifdef ATCBMC300_MST${i}_SUPPORT
// : reg mst${i}_priority_avalid;
// : always @(posedge aclk or negedge aresetn) begin
// :	if (!aresetn)
// : 		mst${i}_priority_avalid <= 1'b0;
// :	else 
// :		mst${i}_priority_avalid <= mst${i}_connect & ~((arb_mid==4'd${i}) & slv_aready) & 
// :					   ((~pending_priority_avalid & mst${i}_avalid & reg_priority_reload[${i}]) | mst${i}_priority_avalid);
// : end
// :`endif
// }
// :		
// : always @* begin
//  for($i=0;$i<16;$i++) {
// :`ifdef ATCBMC300_MST${i}_SUPPORT
// : 	mst_addr  [${i}] = mst${i}_addr  & {ADDR_WIDTH{mst${i}_connect}};
// : 	mst_len   [${i}] = mst${i}_len   & {8{mst${i}_connect}};
// : 	mst_size  [${i}] = mst${i}_size  & {3{mst${i}_connect}};
// : 	mst_burst [${i}] = mst${i}_burst & {2{mst${i}_connect}};
// : 	mst_cache [${i}] = mst${i}_cache & {4{mst${i}_connect}};
// : 	mst_prot  [${i}] = mst${i}_prot  & {3{mst${i}_connect}};
// : 	mst_aid   [${i}] = mst${i}_aid   & {ID_WIDTH{mst${i}_connect}};  
// : 	mst_lock  [${i}] = mst${i}_lock  & mst${i}_connect;
// :	mst_avalid[${i}] = mst${i}_avalid   & mst${i}_connect;     
// :	priority_avalid[${i}] = mst${i}_priority_avalid;
// :`else 
// : 	mst_addr  [${i}] = {ADDR_WIDTH{1'b0}};
// : 	mst_len   [${i}] = {8{1'b0}};
// : 	mst_size  [${i}] = {3{1'b0}};
// : 	mst_burst [${i}] = {2{1'b0}};
// : 	mst_cache [${i}] = {4{1'b0}};
// : 	mst_prot  [${i}] = {3{1'b0}};
// : 	mst_aid   [${i}] = {ID_WIDTH{1'b0}};  
// : 	mst_lock  [${i}] = {1{1'b0}};
// :	mst_avalid[${i}] = 1'b0;
// :	priority_avalid[${i}] = 1'b0;
// :`endif
// }
// :end
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_MST0_SUPPORT
reg mst0_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst0_priority_avalid <= 1'b0;
	else
		mst0_priority_avalid <= mst0_connect & ~((arb_mid==4'd0) & slv_aready) &
					   ((~pending_priority_avalid & mst0_avalid & reg_priority_reload[0]) | mst0_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST1_SUPPORT
reg mst1_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst1_priority_avalid <= 1'b0;
	else
		mst1_priority_avalid <= mst1_connect & ~((arb_mid==4'd1) & slv_aready) &
					   ((~pending_priority_avalid & mst1_avalid & reg_priority_reload[1]) | mst1_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST2_SUPPORT
reg mst2_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst2_priority_avalid <= 1'b0;
	else
		mst2_priority_avalid <= mst2_connect & ~((arb_mid==4'd2) & slv_aready) &
					   ((~pending_priority_avalid & mst2_avalid & reg_priority_reload[2]) | mst2_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST3_SUPPORT
reg mst3_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst3_priority_avalid <= 1'b0;
	else
		mst3_priority_avalid <= mst3_connect & ~((arb_mid==4'd3) & slv_aready) &
					   ((~pending_priority_avalid & mst3_avalid & reg_priority_reload[3]) | mst3_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST4_SUPPORT
reg mst4_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst4_priority_avalid <= 1'b0;
	else
		mst4_priority_avalid <= mst4_connect & ~((arb_mid==4'd4) & slv_aready) &
					   ((~pending_priority_avalid & mst4_avalid & reg_priority_reload[4]) | mst4_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST5_SUPPORT
reg mst5_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst5_priority_avalid <= 1'b0;
	else
		mst5_priority_avalid <= mst5_connect & ~((arb_mid==4'd5) & slv_aready) &
					   ((~pending_priority_avalid & mst5_avalid & reg_priority_reload[5]) | mst5_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST6_SUPPORT
reg mst6_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst6_priority_avalid <= 1'b0;
	else
		mst6_priority_avalid <= mst6_connect & ~((arb_mid==4'd6) & slv_aready) &
					   ((~pending_priority_avalid & mst6_avalid & reg_priority_reload[6]) | mst6_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST7_SUPPORT
reg mst7_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst7_priority_avalid <= 1'b0;
	else
		mst7_priority_avalid <= mst7_connect & ~((arb_mid==4'd7) & slv_aready) &
					   ((~pending_priority_avalid & mst7_avalid & reg_priority_reload[7]) | mst7_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST8_SUPPORT
reg mst8_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst8_priority_avalid <= 1'b0;
	else
		mst8_priority_avalid <= mst8_connect & ~((arb_mid==4'd8) & slv_aready) &
					   ((~pending_priority_avalid & mst8_avalid & reg_priority_reload[8]) | mst8_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST9_SUPPORT
reg mst9_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst9_priority_avalid <= 1'b0;
	else
		mst9_priority_avalid <= mst9_connect & ~((arb_mid==4'd9) & slv_aready) &
					   ((~pending_priority_avalid & mst9_avalid & reg_priority_reload[9]) | mst9_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST10_SUPPORT
reg mst10_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst10_priority_avalid <= 1'b0;
	else
		mst10_priority_avalid <= mst10_connect & ~((arb_mid==4'd10) & slv_aready) &
					   ((~pending_priority_avalid & mst10_avalid & reg_priority_reload[10]) | mst10_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST11_SUPPORT
reg mst11_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst11_priority_avalid <= 1'b0;
	else
		mst11_priority_avalid <= mst11_connect & ~((arb_mid==4'd11) & slv_aready) &
					   ((~pending_priority_avalid & mst11_avalid & reg_priority_reload[11]) | mst11_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST12_SUPPORT
reg mst12_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst12_priority_avalid <= 1'b0;
	else
		mst12_priority_avalid <= mst12_connect & ~((arb_mid==4'd12) & slv_aready) &
					   ((~pending_priority_avalid & mst12_avalid & reg_priority_reload[12]) | mst12_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST13_SUPPORT
reg mst13_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst13_priority_avalid <= 1'b0;
	else
		mst13_priority_avalid <= mst13_connect & ~((arb_mid==4'd13) & slv_aready) &
					   ((~pending_priority_avalid & mst13_avalid & reg_priority_reload[13]) | mst13_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST14_SUPPORT
reg mst14_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst14_priority_avalid <= 1'b0;
	else
		mst14_priority_avalid <= mst14_connect & ~((arb_mid==4'd14) & slv_aready) &
					   ((~pending_priority_avalid & mst14_avalid & reg_priority_reload[14]) | mst14_priority_avalid);
end
`endif
`ifdef ATCBMC300_MST15_SUPPORT
reg mst15_priority_avalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst15_priority_avalid <= 1'b0;
	else
		mst15_priority_avalid <= mst15_connect & ~((arb_mid==4'd15) & slv_aready) &
					   ((~pending_priority_avalid & mst15_avalid & reg_priority_reload[15]) | mst15_priority_avalid);
end
`endif

always @* begin
`ifdef ATCBMC300_MST0_SUPPORT
	mst_addr  [0] = mst0_addr  & {ADDR_WIDTH{mst0_connect}};
	mst_len   [0] = mst0_len   & {8{mst0_connect}};
	mst_size  [0] = mst0_size  & {3{mst0_connect}};
	mst_burst [0] = mst0_burst & {2{mst0_connect}};
	mst_cache [0] = mst0_cache & {4{mst0_connect}};
	mst_prot  [0] = mst0_prot  & {3{mst0_connect}};
	mst_aid   [0] = mst0_aid   & {ID_WIDTH{mst0_connect}};
	mst_lock  [0] = mst0_lock  & mst0_connect;
	mst_avalid[0] = mst0_avalid   & mst0_connect;
	priority_avalid[0] = mst0_priority_avalid;
`else
	mst_addr  [0] = {ADDR_WIDTH{1'b0}};
	mst_len   [0] = {8{1'b0}};
	mst_size  [0] = {3{1'b0}};
	mst_burst [0] = {2{1'b0}};
	mst_cache [0] = {4{1'b0}};
	mst_prot  [0] = {3{1'b0}};
	mst_aid   [0] = {ID_WIDTH{1'b0}};
	mst_lock  [0] = {1{1'b0}};
	mst_avalid[0] = 1'b0;
	priority_avalid[0] = 1'b0;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	mst_addr  [1] = mst1_addr  & {ADDR_WIDTH{mst1_connect}};
	mst_len   [1] = mst1_len   & {8{mst1_connect}};
	mst_size  [1] = mst1_size  & {3{mst1_connect}};
	mst_burst [1] = mst1_burst & {2{mst1_connect}};
	mst_cache [1] = mst1_cache & {4{mst1_connect}};
	mst_prot  [1] = mst1_prot  & {3{mst1_connect}};
	mst_aid   [1] = mst1_aid   & {ID_WIDTH{mst1_connect}};
	mst_lock  [1] = mst1_lock  & mst1_connect;
	mst_avalid[1] = mst1_avalid   & mst1_connect;
	priority_avalid[1] = mst1_priority_avalid;
`else
	mst_addr  [1] = {ADDR_WIDTH{1'b0}};
	mst_len   [1] = {8{1'b0}};
	mst_size  [1] = {3{1'b0}};
	mst_burst [1] = {2{1'b0}};
	mst_cache [1] = {4{1'b0}};
	mst_prot  [1] = {3{1'b0}};
	mst_aid   [1] = {ID_WIDTH{1'b0}};
	mst_lock  [1] = {1{1'b0}};
	mst_avalid[1] = 1'b0;
	priority_avalid[1] = 1'b0;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	mst_addr  [2] = mst2_addr  & {ADDR_WIDTH{mst2_connect}};
	mst_len   [2] = mst2_len   & {8{mst2_connect}};
	mst_size  [2] = mst2_size  & {3{mst2_connect}};
	mst_burst [2] = mst2_burst & {2{mst2_connect}};
	mst_cache [2] = mst2_cache & {4{mst2_connect}};
	mst_prot  [2] = mst2_prot  & {3{mst2_connect}};
	mst_aid   [2] = mst2_aid   & {ID_WIDTH{mst2_connect}};
	mst_lock  [2] = mst2_lock  & mst2_connect;
	mst_avalid[2] = mst2_avalid   & mst2_connect;
	priority_avalid[2] = mst2_priority_avalid;
`else
	mst_addr  [2] = {ADDR_WIDTH{1'b0}};
	mst_len   [2] = {8{1'b0}};
	mst_size  [2] = {3{1'b0}};
	mst_burst [2] = {2{1'b0}};
	mst_cache [2] = {4{1'b0}};
	mst_prot  [2] = {3{1'b0}};
	mst_aid   [2] = {ID_WIDTH{1'b0}};
	mst_lock  [2] = {1{1'b0}};
	mst_avalid[2] = 1'b0;
	priority_avalid[2] = 1'b0;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	mst_addr  [3] = mst3_addr  & {ADDR_WIDTH{mst3_connect}};
	mst_len   [3] = mst3_len   & {8{mst3_connect}};
	mst_size  [3] = mst3_size  & {3{mst3_connect}};
	mst_burst [3] = mst3_burst & {2{mst3_connect}};
	mst_cache [3] = mst3_cache & {4{mst3_connect}};
	mst_prot  [3] = mst3_prot  & {3{mst3_connect}};
	mst_aid   [3] = mst3_aid   & {ID_WIDTH{mst3_connect}};
	mst_lock  [3] = mst3_lock  & mst3_connect;
	mst_avalid[3] = mst3_avalid   & mst3_connect;
	priority_avalid[3] = mst3_priority_avalid;
`else
	mst_addr  [3] = {ADDR_WIDTH{1'b0}};
	mst_len   [3] = {8{1'b0}};
	mst_size  [3] = {3{1'b0}};
	mst_burst [3] = {2{1'b0}};
	mst_cache [3] = {4{1'b0}};
	mst_prot  [3] = {3{1'b0}};
	mst_aid   [3] = {ID_WIDTH{1'b0}};
	mst_lock  [3] = {1{1'b0}};
	mst_avalid[3] = 1'b0;
	priority_avalid[3] = 1'b0;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	mst_addr  [4] = mst4_addr  & {ADDR_WIDTH{mst4_connect}};
	mst_len   [4] = mst4_len   & {8{mst4_connect}};
	mst_size  [4] = mst4_size  & {3{mst4_connect}};
	mst_burst [4] = mst4_burst & {2{mst4_connect}};
	mst_cache [4] = mst4_cache & {4{mst4_connect}};
	mst_prot  [4] = mst4_prot  & {3{mst4_connect}};
	mst_aid   [4] = mst4_aid   & {ID_WIDTH{mst4_connect}};
	mst_lock  [4] = mst4_lock  & mst4_connect;
	mst_avalid[4] = mst4_avalid   & mst4_connect;
	priority_avalid[4] = mst4_priority_avalid;
`else
	mst_addr  [4] = {ADDR_WIDTH{1'b0}};
	mst_len   [4] = {8{1'b0}};
	mst_size  [4] = {3{1'b0}};
	mst_burst [4] = {2{1'b0}};
	mst_cache [4] = {4{1'b0}};
	mst_prot  [4] = {3{1'b0}};
	mst_aid   [4] = {ID_WIDTH{1'b0}};
	mst_lock  [4] = {1{1'b0}};
	mst_avalid[4] = 1'b0;
	priority_avalid[4] = 1'b0;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	mst_addr  [5] = mst5_addr  & {ADDR_WIDTH{mst5_connect}};
	mst_len   [5] = mst5_len   & {8{mst5_connect}};
	mst_size  [5] = mst5_size  & {3{mst5_connect}};
	mst_burst [5] = mst5_burst & {2{mst5_connect}};
	mst_cache [5] = mst5_cache & {4{mst5_connect}};
	mst_prot  [5] = mst5_prot  & {3{mst5_connect}};
	mst_aid   [5] = mst5_aid   & {ID_WIDTH{mst5_connect}};
	mst_lock  [5] = mst5_lock  & mst5_connect;
	mst_avalid[5] = mst5_avalid   & mst5_connect;
	priority_avalid[5] = mst5_priority_avalid;
`else
	mst_addr  [5] = {ADDR_WIDTH{1'b0}};
	mst_len   [5] = {8{1'b0}};
	mst_size  [5] = {3{1'b0}};
	mst_burst [5] = {2{1'b0}};
	mst_cache [5] = {4{1'b0}};
	mst_prot  [5] = {3{1'b0}};
	mst_aid   [5] = {ID_WIDTH{1'b0}};
	mst_lock  [5] = {1{1'b0}};
	mst_avalid[5] = 1'b0;
	priority_avalid[5] = 1'b0;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	mst_addr  [6] = mst6_addr  & {ADDR_WIDTH{mst6_connect}};
	mst_len   [6] = mst6_len   & {8{mst6_connect}};
	mst_size  [6] = mst6_size  & {3{mst6_connect}};
	mst_burst [6] = mst6_burst & {2{mst6_connect}};
	mst_cache [6] = mst6_cache & {4{mst6_connect}};
	mst_prot  [6] = mst6_prot  & {3{mst6_connect}};
	mst_aid   [6] = mst6_aid   & {ID_WIDTH{mst6_connect}};
	mst_lock  [6] = mst6_lock  & mst6_connect;
	mst_avalid[6] = mst6_avalid   & mst6_connect;
	priority_avalid[6] = mst6_priority_avalid;
`else
	mst_addr  [6] = {ADDR_WIDTH{1'b0}};
	mst_len   [6] = {8{1'b0}};
	mst_size  [6] = {3{1'b0}};
	mst_burst [6] = {2{1'b0}};
	mst_cache [6] = {4{1'b0}};
	mst_prot  [6] = {3{1'b0}};
	mst_aid   [6] = {ID_WIDTH{1'b0}};
	mst_lock  [6] = {1{1'b0}};
	mst_avalid[6] = 1'b0;
	priority_avalid[6] = 1'b0;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	mst_addr  [7] = mst7_addr  & {ADDR_WIDTH{mst7_connect}};
	mst_len   [7] = mst7_len   & {8{mst7_connect}};
	mst_size  [7] = mst7_size  & {3{mst7_connect}};
	mst_burst [7] = mst7_burst & {2{mst7_connect}};
	mst_cache [7] = mst7_cache & {4{mst7_connect}};
	mst_prot  [7] = mst7_prot  & {3{mst7_connect}};
	mst_aid   [7] = mst7_aid   & {ID_WIDTH{mst7_connect}};
	mst_lock  [7] = mst7_lock  & mst7_connect;
	mst_avalid[7] = mst7_avalid   & mst7_connect;
	priority_avalid[7] = mst7_priority_avalid;
`else
	mst_addr  [7] = {ADDR_WIDTH{1'b0}};
	mst_len   [7] = {8{1'b0}};
	mst_size  [7] = {3{1'b0}};
	mst_burst [7] = {2{1'b0}};
	mst_cache [7] = {4{1'b0}};
	mst_prot  [7] = {3{1'b0}};
	mst_aid   [7] = {ID_WIDTH{1'b0}};
	mst_lock  [7] = {1{1'b0}};
	mst_avalid[7] = 1'b0;
	priority_avalid[7] = 1'b0;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	mst_addr  [8] = mst8_addr  & {ADDR_WIDTH{mst8_connect}};
	mst_len   [8] = mst8_len   & {8{mst8_connect}};
	mst_size  [8] = mst8_size  & {3{mst8_connect}};
	mst_burst [8] = mst8_burst & {2{mst8_connect}};
	mst_cache [8] = mst8_cache & {4{mst8_connect}};
	mst_prot  [8] = mst8_prot  & {3{mst8_connect}};
	mst_aid   [8] = mst8_aid   & {ID_WIDTH{mst8_connect}};
	mst_lock  [8] = mst8_lock  & mst8_connect;
	mst_avalid[8] = mst8_avalid   & mst8_connect;
	priority_avalid[8] = mst8_priority_avalid;
`else
	mst_addr  [8] = {ADDR_WIDTH{1'b0}};
	mst_len   [8] = {8{1'b0}};
	mst_size  [8] = {3{1'b0}};
	mst_burst [8] = {2{1'b0}};
	mst_cache [8] = {4{1'b0}};
	mst_prot  [8] = {3{1'b0}};
	mst_aid   [8] = {ID_WIDTH{1'b0}};
	mst_lock  [8] = {1{1'b0}};
	mst_avalid[8] = 1'b0;
	priority_avalid[8] = 1'b0;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	mst_addr  [9] = mst9_addr  & {ADDR_WIDTH{mst9_connect}};
	mst_len   [9] = mst9_len   & {8{mst9_connect}};
	mst_size  [9] = mst9_size  & {3{mst9_connect}};
	mst_burst [9] = mst9_burst & {2{mst9_connect}};
	mst_cache [9] = mst9_cache & {4{mst9_connect}};
	mst_prot  [9] = mst9_prot  & {3{mst9_connect}};
	mst_aid   [9] = mst9_aid   & {ID_WIDTH{mst9_connect}};
	mst_lock  [9] = mst9_lock  & mst9_connect;
	mst_avalid[9] = mst9_avalid   & mst9_connect;
	priority_avalid[9] = mst9_priority_avalid;
`else
	mst_addr  [9] = {ADDR_WIDTH{1'b0}};
	mst_len   [9] = {8{1'b0}};
	mst_size  [9] = {3{1'b0}};
	mst_burst [9] = {2{1'b0}};
	mst_cache [9] = {4{1'b0}};
	mst_prot  [9] = {3{1'b0}};
	mst_aid   [9] = {ID_WIDTH{1'b0}};
	mst_lock  [9] = {1{1'b0}};
	mst_avalid[9] = 1'b0;
	priority_avalid[9] = 1'b0;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	mst_addr  [10] = mst10_addr  & {ADDR_WIDTH{mst10_connect}};
	mst_len   [10] = mst10_len   & {8{mst10_connect}};
	mst_size  [10] = mst10_size  & {3{mst10_connect}};
	mst_burst [10] = mst10_burst & {2{mst10_connect}};
	mst_cache [10] = mst10_cache & {4{mst10_connect}};
	mst_prot  [10] = mst10_prot  & {3{mst10_connect}};
	mst_aid   [10] = mst10_aid   & {ID_WIDTH{mst10_connect}};
	mst_lock  [10] = mst10_lock  & mst10_connect;
	mst_avalid[10] = mst10_avalid   & mst10_connect;
	priority_avalid[10] = mst10_priority_avalid;
`else
	mst_addr  [10] = {ADDR_WIDTH{1'b0}};
	mst_len   [10] = {8{1'b0}};
	mst_size  [10] = {3{1'b0}};
	mst_burst [10] = {2{1'b0}};
	mst_cache [10] = {4{1'b0}};
	mst_prot  [10] = {3{1'b0}};
	mst_aid   [10] = {ID_WIDTH{1'b0}};
	mst_lock  [10] = {1{1'b0}};
	mst_avalid[10] = 1'b0;
	priority_avalid[10] = 1'b0;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	mst_addr  [11] = mst11_addr  & {ADDR_WIDTH{mst11_connect}};
	mst_len   [11] = mst11_len   & {8{mst11_connect}};
	mst_size  [11] = mst11_size  & {3{mst11_connect}};
	mst_burst [11] = mst11_burst & {2{mst11_connect}};
	mst_cache [11] = mst11_cache & {4{mst11_connect}};
	mst_prot  [11] = mst11_prot  & {3{mst11_connect}};
	mst_aid   [11] = mst11_aid   & {ID_WIDTH{mst11_connect}};
	mst_lock  [11] = mst11_lock  & mst11_connect;
	mst_avalid[11] = mst11_avalid   & mst11_connect;
	priority_avalid[11] = mst11_priority_avalid;
`else
	mst_addr  [11] = {ADDR_WIDTH{1'b0}};
	mst_len   [11] = {8{1'b0}};
	mst_size  [11] = {3{1'b0}};
	mst_burst [11] = {2{1'b0}};
	mst_cache [11] = {4{1'b0}};
	mst_prot  [11] = {3{1'b0}};
	mst_aid   [11] = {ID_WIDTH{1'b0}};
	mst_lock  [11] = {1{1'b0}};
	mst_avalid[11] = 1'b0;
	priority_avalid[11] = 1'b0;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	mst_addr  [12] = mst12_addr  & {ADDR_WIDTH{mst12_connect}};
	mst_len   [12] = mst12_len   & {8{mst12_connect}};
	mst_size  [12] = mst12_size  & {3{mst12_connect}};
	mst_burst [12] = mst12_burst & {2{mst12_connect}};
	mst_cache [12] = mst12_cache & {4{mst12_connect}};
	mst_prot  [12] = mst12_prot  & {3{mst12_connect}};
	mst_aid   [12] = mst12_aid   & {ID_WIDTH{mst12_connect}};
	mst_lock  [12] = mst12_lock  & mst12_connect;
	mst_avalid[12] = mst12_avalid   & mst12_connect;
	priority_avalid[12] = mst12_priority_avalid;
`else
	mst_addr  [12] = {ADDR_WIDTH{1'b0}};
	mst_len   [12] = {8{1'b0}};
	mst_size  [12] = {3{1'b0}};
	mst_burst [12] = {2{1'b0}};
	mst_cache [12] = {4{1'b0}};
	mst_prot  [12] = {3{1'b0}};
	mst_aid   [12] = {ID_WIDTH{1'b0}};
	mst_lock  [12] = {1{1'b0}};
	mst_avalid[12] = 1'b0;
	priority_avalid[12] = 1'b0;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	mst_addr  [13] = mst13_addr  & {ADDR_WIDTH{mst13_connect}};
	mst_len   [13] = mst13_len   & {8{mst13_connect}};
	mst_size  [13] = mst13_size  & {3{mst13_connect}};
	mst_burst [13] = mst13_burst & {2{mst13_connect}};
	mst_cache [13] = mst13_cache & {4{mst13_connect}};
	mst_prot  [13] = mst13_prot  & {3{mst13_connect}};
	mst_aid   [13] = mst13_aid   & {ID_WIDTH{mst13_connect}};
	mst_lock  [13] = mst13_lock  & mst13_connect;
	mst_avalid[13] = mst13_avalid   & mst13_connect;
	priority_avalid[13] = mst13_priority_avalid;
`else
	mst_addr  [13] = {ADDR_WIDTH{1'b0}};
	mst_len   [13] = {8{1'b0}};
	mst_size  [13] = {3{1'b0}};
	mst_burst [13] = {2{1'b0}};
	mst_cache [13] = {4{1'b0}};
	mst_prot  [13] = {3{1'b0}};
	mst_aid   [13] = {ID_WIDTH{1'b0}};
	mst_lock  [13] = {1{1'b0}};
	mst_avalid[13] = 1'b0;
	priority_avalid[13] = 1'b0;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	mst_addr  [14] = mst14_addr  & {ADDR_WIDTH{mst14_connect}};
	mst_len   [14] = mst14_len   & {8{mst14_connect}};
	mst_size  [14] = mst14_size  & {3{mst14_connect}};
	mst_burst [14] = mst14_burst & {2{mst14_connect}};
	mst_cache [14] = mst14_cache & {4{mst14_connect}};
	mst_prot  [14] = mst14_prot  & {3{mst14_connect}};
	mst_aid   [14] = mst14_aid   & {ID_WIDTH{mst14_connect}};
	mst_lock  [14] = mst14_lock  & mst14_connect;
	mst_avalid[14] = mst14_avalid   & mst14_connect;
	priority_avalid[14] = mst14_priority_avalid;
`else
	mst_addr  [14] = {ADDR_WIDTH{1'b0}};
	mst_len   [14] = {8{1'b0}};
	mst_size  [14] = {3{1'b0}};
	mst_burst [14] = {2{1'b0}};
	mst_cache [14] = {4{1'b0}};
	mst_prot  [14] = {3{1'b0}};
	mst_aid   [14] = {ID_WIDTH{1'b0}};
	mst_lock  [14] = {1{1'b0}};
	mst_avalid[14] = 1'b0;
	priority_avalid[14] = 1'b0;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	mst_addr  [15] = mst15_addr  & {ADDR_WIDTH{mst15_connect}};
	mst_len   [15] = mst15_len   & {8{mst15_connect}};
	mst_size  [15] = mst15_size  & {3{mst15_connect}};
	mst_burst [15] = mst15_burst & {2{mst15_connect}};
	mst_cache [15] = mst15_cache & {4{mst15_connect}};
	mst_prot  [15] = mst15_prot  & {3{mst15_connect}};
	mst_aid   [15] = mst15_aid   & {ID_WIDTH{mst15_connect}};
	mst_lock  [15] = mst15_lock  & mst15_connect;
	mst_avalid[15] = mst15_avalid   & mst15_connect;
	priority_avalid[15] = mst15_priority_avalid;
`else
	mst_addr  [15] = {ADDR_WIDTH{1'b0}};
	mst_len   [15] = {8{1'b0}};
	mst_size  [15] = {3{1'b0}};
	mst_burst [15] = {2{1'b0}};
	mst_cache [15] = {4{1'b0}};
	mst_prot  [15] = {3{1'b0}};
	mst_aid   [15] = {ID_WIDTH{1'b0}};
	mst_lock  [15] = {1{1'b0}};
	mst_avalid[15] = 1'b0;
	priority_avalid[15] = 1'b0;
`endif
end
// VPERL_GENERATED_END

assign arb_avalid =    (reg_mst0_high_priority & mst_avalid[0]) ? 16'b1 : 
		                        pending_priority_avalid ? priority_avalid : 
		    ((mst_avalid & reg_priority_reload)!=16'h0) ? (mst_avalid & reg_priority_reload) : mst_avalid;

//assign arb_mid[3] =    (~mid[3] | (~|arb_avalid[7:0])) & (|arb_avalid[15:8]);
//assign arb_mid[2] = arb_mid[3] ? ((~mid[2] | (~|arb_avalid[11:08])) & (|arb_avalid[15:12])) :
//            		   	 ((~mid[2] | (~|arb_avalid[03:00])) & (|arb_avalid[07:04])) ; 
//assign arb_mid[1] = 
//            		(arb_mid[3:2]==2'h3 & ((~mid[1] | (~|arb_avalid[13:12])) & (|arb_avalid[15:14]))) |
//            		(arb_mid[3:2]==2'h2 & ((~mid[1] | (~|arb_avalid[09:08])) & (|arb_avalid[11:10]))) |
//            		(arb_mid[3:2]==2'h1 & ((~mid[1] | (~|arb_avalid[05:04])) & (|arb_avalid[07:06]))) |
//            		(arb_mid[3:2]==2'h0 & ((~mid[1] | (~|arb_avalid[01:00])) & (|arb_avalid[03:02]))) ;
//assign arb_mid[0] = 
//			(arb_mid[3:1]==3'h7 & ((~mid[0] | ~arb_avalid[14]) & arb_avalid[15])) |
//			(arb_mid[3:1]==3'h6 & ((~mid[0] | ~arb_avalid[12]) & arb_avalid[13])) |
//			(arb_mid[3:1]==3'h5 & ((~mid[0] | ~arb_avalid[10]) & arb_avalid[11])) |
//			(arb_mid[3:1]==3'h4 & ((~mid[0] | ~arb_avalid[08]) & arb_avalid[09])) |
//			(arb_mid[3:1]==3'h3 & ((~mid[0] | ~arb_avalid[06]) & arb_avalid[07])) |
//			(arb_mid[3:1]==3'h2 & ((~mid[0] | ~arb_avalid[04]) & arb_avalid[05])) |
//			(arb_mid[3:1]==3'h1 & ((~mid[0] | ~arb_avalid[02]) & arb_avalid[03])) |
//			(arb_mid[3:1]==3'h0 & ((~mid[0] | ~arb_avalid[00]) & arb_avalid[01])) ;

assign arb_mid[3] = (~|arb_avalid[7:0]);
assign arb_mid[2] = arb_mid[3] ? (~|arb_avalid[11:08]) : (~|arb_avalid[03:00]);
assign arb_mid[1] = 
            		(arb_mid[3:2]==2'h3 & (~|arb_avalid[13:12]))|
            		(arb_mid[3:2]==2'h2 & (~|arb_avalid[09:08]))|
            		(arb_mid[3:2]==2'h1 & (~|arb_avalid[05:04]))|
            		(arb_mid[3:2]==2'h0 & (~|arb_avalid[01:00]));
assign arb_mid[0] = 
			(arb_mid[3:1]==3'h7 & ~arb_avalid[14]) |
			(arb_mid[3:1]==3'h6 & ~arb_avalid[12]) |
			(arb_mid[3:1]==3'h5 & ~arb_avalid[10]) |
			(arb_mid[3:1]==3'h4 & ~arb_avalid[08]) |
			(arb_mid[3:1]==3'h3 & ~arb_avalid[06]) |
			(arb_mid[3:1]==3'h2 & ~arb_avalid[04]) |
			(arb_mid[3:1]==3'h1 & ~arb_avalid[02]) |
			(arb_mid[3:1]==3'h0 & ~arb_avalid[00]) ;

assign aid = {us_aid,mid};
assign slv_aready = ~(avalid & ~aready) & outstanding_ready;
assign addr_outstanding_en = (slv_aready & |mst_avalid);
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		avalid <= 1'b0;
	else 
		avalid <= (slv_aready & |mst_avalid) | (avalid & ~aready);
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		addr	<= {ADDR_WIDTH{1'b0}}; 
		len	<= 8'h0;
		size	<= 3'h0;
		burst	<= 2'h0;
		cache	<= 4'h0;
		lock	<= 1'b0;
		prot	<= 3'h0;
		us_aid	<= {ID_WIDTH{1'b0}};
		mid	<= 4'h0;
	end else if (|mst_avalid & slv_aready) begin
		addr	<= mst_addr[arb_mid];
		len	<= mst_len[arb_mid];
		size	<= mst_size[arb_mid];
		burst	<= mst_burst[arb_mid];
		cache	<= mst_cache[arb_mid];
		lock	<= mst_lock[arb_mid];
		prot	<= mst_prot[arb_mid];
		us_aid	<= mst_aid[arb_mid];
		mid	<= arb_mid;
	end	
end
endmodule
