`include "config.inc"
`include "ae350_const.vh"
`include "atcsmu100_config.vh"
`include "atcsmu100_const.vh"

module atcsmu100_apbif (
	// VPERL: &PORTLIST;
	// VPERL_GENERATED_BEGIN
		  mpd_por_rstn, // reset_vector 
		  pclk,     
		  presetn,  
		  psel,     
		  penable,  
		  paddr,    
		  pwdata,   
		  pwrite,   
		  prdata,   
		  pready,   
		  pslverr,  
		  pcs0_rdata,
		  pcs1_rdata,
		  pcs2_rdata,
		  pcs3_rdata,
		  pcs4_rdata,
		  pcs5_rdata,
		  pcs6_rdata,
		  pcs7_rdata,
		  pcs0_reset_source,
		  pcs1_reset_source,
		  pcs2_reset_source,
		  pcs3_reset_source,
		  pcs4_reset_source,
		  pcs5_reset_source,
		  pcs6_reset_source,
		  pcs_sel,  
		  pcs_wdata,
		  pcs_write,
		  pcs_sel_cfg,
		  pcs_sel_scratch,
		  pcs_sel_misc,
		  pcs_sel_misc2,
		  pcs_sel_we,
		  pcs_sel_ctl,
		  pcs_sel_status,
		  pcs_sel_cer,
	`ifdef NDS_FPGA
	   `ifdef AE350_DDR_LATENCY
		  ddr3_latency,
		  ddr3_bw_ctrl,
	   `endif // AE350_DDR_LATENCY
	`endif // NDS_FPGA
		  smu_sw_rst,
		  core_reset_vectors, // = 64*4-1
	`ifdef NDS_BOARD_CF1
		  cf1_pinmux_ctrl0,
		  cf1_pinmux_ctrl1,
	`endif // NDS_BOARD_CF1
		  system_clock_ratio 
	// VPERL_GENERATED_END
);

// Configuration
`ifdef NDS_NHART
parameter	NDS_NHART = `NDS_NHART;	// 1 ~ 4
`else	// !NDS_NHART
parameter	NDS_NHART = 1;		// 1 ~ 4
`endif	//  NDS_NHART
parameter	PCS_NUM    = 8;		// 1 ~ 8
parameter	SYS_TS     = 32'h0;	// `AE350_TIMESTAMP, temprary set to 0
parameter	PRODUCT_ID = `AE350_PRODUCT_ID;	// `AE350_PRODUCT_ID
parameter	BOARD_ID   = `AE350_BOARD_ID;	// `AE350_BOARD_ID

input		mpd_por_rstn; 		// reset_vector 
// APB
input		pclk;
input		presetn;
input		psel;
input		penable;
input	[12:2]	paddr;
input	[31:0]	pwdata;
input		pwrite;
output	[31:0]	prdata;
output		pready;
output		pslverr;


// PCS 
input	[31:0]	pcs0_rdata;
input	[31:0]	pcs1_rdata;
input	[31:0]	pcs2_rdata;
input	[31:0]	pcs3_rdata;
input	[31:0]	pcs4_rdata;
input	[31:0]	pcs5_rdata;
input	[31:0]	pcs6_rdata;
input	[31:0]	pcs7_rdata;

input	[4:0]	pcs0_reset_source;
input	[4:0]	pcs1_reset_source;
input	[4:0]	pcs2_reset_source;
input	[4:0]	pcs3_reset_source;
input	[4:0]	pcs4_reset_source;
input	[4:0]	pcs5_reset_source;
input	[4:0]	pcs6_reset_source;

output	[7:0]	pcs_sel;
output	[31:0]	pcs_wdata;
output		pcs_write;
output		pcs_sel_cfg;
output		pcs_sel_scratch;
output		pcs_sel_misc;
output		pcs_sel_misc2;
output		pcs_sel_we;
output		pcs_sel_ctl;
output		pcs_sel_status;
output		pcs_sel_cer;

`ifdef NDS_FPGA
	`ifdef AE350_DDR_LATENCY
output	[3:0]	ddr3_latency;
output	[1:0]	ddr3_bw_ctrl;
	`endif
`endif

// Old SMU Compatable
output reg	smu_sw_rst;

// System - core
output	[255:0]	core_reset_vectors;	// = 64*4-1

`ifdef NDS_BOARD_CF1
output       [31:0] cf1_pinmux_ctrl0;
output       [31:0] cf1_pinmux_ctrl1;
`endif

// System - clk gen
output reg [4:0] system_clock_ratio;


// TODO: upgrade the localparam to parameter when the feature is implemented
localparam	PCS_BATCH_SUPPORT = 0;
localparam	DVFS_SUPPORT = 0;
localparam	FIX_VOLTAGE = 1;

localparam	OFFSET_SYSTEMVER    	= 13'h0000; // 8'h00
localparam	OFFSET_BOARDID     	= 13'h0004; // 8'h01
localparam	OFFSET_SYSTEMCFG    	= 13'h0008; // 8'h02
localparam	OFFSET_SMUVER       	= 13'h000c; // 8'h03
localparam	OFFSET_WAKEUPST     	= 13'h0010; // 8'h04	=> change 7'h04 to wakeup status to compatable with old SMU
localparam	OFFSET_SMUCR      	= 13'h0014; // 8'h05
localparam	OFFSET_CLKEN		= 13'h0020; // 8'h08
localparam	OFFSET_SYSTEMCR     	= 13'h0024; // 8'h09	=> change clock ratio to 7'h09 to compatable with old SMU
localparam	OFFSET_PCS_SEL      	= 13'h0030; // 8'h0c

localparam	OFFSET_HART0_RST_VEC	= 13'h0050; // 8'b14 
localparam	OFFSET_HART1_RST_VEC	= 13'h0054; // 8'h15 
localparam	OFFSET_HART2_RST_VEC	= 13'h0058; // 8'h16
localparam	OFFSET_HART3_RST_VEC	= 13'h005c; // 8'h17

localparam	OFFSET_HART0_RST_VEC_HI = 13'h0060; // 8'b18 
localparam	OFFSET_HART1_RST_VEC_HI = 13'h0064; // 8'h19 
localparam	OFFSET_HART2_RST_VEC_HI = 13'h0068; // 8'h1a
localparam	OFFSET_HART3_RST_VEC_HI = 13'h006c; // 8'h1b

localparam	OFFSET_SYSTEMTS		= 13'h0070; // 8'h1c

localparam	OFFSET_CFG		= 13'h0080; // 8'h20
localparam	OFFSET_SCRATCH		= 13'h0084; // 8'h21
localparam	OFFSET_MISC		= 13'h0088; // 8'h22
localparam	OFFSET_MISC2		= 13'h008c; // 8'h23
localparam	OFFSET_WE		= 13'h0090; // 8'h24
localparam	OFFSET_CTL		= 13'h0094; // 8'h25
localparam	OFFSET_STATUS		= 13'h0098; // 8'h26

localparam	RESET_VECTOR_DEFAULT	= `ATCSMU100_RESET_VECTOR_LO_DEFAULT;
localparam	RESET_VECTOR_HI_DEFAULT	= `ATCSMU100_RESET_VECTOR_HI_DEFAULT;


localparam	OFFSET_DDR3_LATENCY    	= 13'h0300; // 8'hc0
localparam	OFFSET_SRAM_SIZE      	= 13'h0304; // 8'hc1

localparam	OFFSET_PINMUX_CTRL0	= 13'h1000;
localparam	OFFSET_PINMUX_CTRL1	= 13'h1004;


// Configuration
wire	[7:0]	core_num = NDS_NHART[7:0];

`ifdef NDS_IO_L2C
wire		l2c_existence = 1'b1;
`else
wire		l2c_existence = 1'b0;
`endif

`ifdef NDS_FPGA
	`ifdef AE350_DDR_LATENCY
wire	[31:0]	ddr3_latency_reg_out;
wire	[31:0]	sram_size_reg_out;
	`endif
`endif

`ifdef NDS_BOARD_CF1
wire            cf1_pinmux_ctrl0_sel;
reg     [31:0]  cf1_pinmux_ctrl0;
wire            cf1_pinmux_ctrl1_sel;
reg     [31:0]  cf1_pinmux_ctrl1;
`endif	// NDS_BOARD_CF1


// ===============
//  PCS
// ===============
assign		pcs_wdata = pwdata;
assign		pcs_write = pwrite & penable & psel;

assign		pcs_sel_cfg	= (paddr[4:2] == OFFSET_CFG[4:2]	);
assign		pcs_sel_scratch	= (paddr[4:2] == OFFSET_SCRATCH[4:2]	);
assign		pcs_sel_misc	= (paddr[4:2] == OFFSET_MISC[4:2]	);
assign		pcs_sel_misc2	= (paddr[4:2] == OFFSET_MISC2[4:2]	);
assign		pcs_sel_we	= (paddr[4:2] == OFFSET_WE[4:2]		);
assign		pcs_sel_ctl	= (paddr[4:2] == OFFSET_CTL[4:2]	);
assign		pcs_sel_status	= (paddr[4:2] == OFFSET_STATUS[4:2]	);
assign		pcs_sel_cer	= (paddr[4:2] == OFFSET_CLKEN[4:2]      );

wire	[31:0]	prdata_pcs;
wire	[4:0]	pcs_reset_source;

generate
if (PCS_BATCH_SUPPORT) begin: gen_pcs_batch_mode
	assign pcs_sel = 0;
	assign prdata_pcs = 0;
	assign pcs_reset_source = 5'd0;
end
else begin: gen_pcs_singal_mode
	assign pcs_sel[0] = (PCS_NUM > 0) & (paddr[12:5] == 8'b000_00_100) & psel; // 0x80 ~ 0x9c
	assign pcs_sel[1] = (PCS_NUM > 1) & (paddr[12:5] == 8'b000_00_101) & psel;
	assign pcs_sel[2] = (PCS_NUM > 2) & (paddr[12:5] == 8'b000_00_110) & psel;
	assign pcs_sel[3] = (PCS_NUM > 3) & (paddr[12:5] == 8'b000_00_111) & psel;
	assign pcs_sel[4] = (PCS_NUM > 4) & (paddr[12:5] == 8'b000_01_000) & psel; //0x100 ~ 0x11c
	assign pcs_sel[5] = (PCS_NUM > 5) & (paddr[12:5] == 8'b000_01_001) & psel;
	assign pcs_sel[6] = (PCS_NUM > 6) & (paddr[12:5] == 8'b000_01_010) & psel;
	assign pcs_sel[7] = (PCS_NUM > 7) & (paddr[12:5] == 8'b000_01_011) & psel;
	
	// data is ready in both APB_SETUP & APB_ENABLE state (can be 2 cycle path)
	assign prdata_pcs = ({32{pcs_sel[0]}} & pcs0_rdata)
			  | ({32{pcs_sel[1]}} & pcs1_rdata)
			  | ({32{pcs_sel[2]}} & pcs2_rdata)
			  | ({32{pcs_sel[3]}} & pcs3_rdata)
			  | ({32{pcs_sel[4]}} & pcs4_rdata)
			  | ({32{pcs_sel[5]}} & pcs5_rdata)
			  | ({32{pcs_sel[6]}} & pcs6_rdata)
			  | ({32{pcs_sel[7]}} & pcs7_rdata);

	wire	default_reset_source;
	assign default_reset_source = ~|pcs_sel[7:1];
	assign pcs_reset_source = ({5{default_reset_source}} & pcs0_reset_source)
			        | ({5{pcs_sel[1]}} & pcs1_reset_source)
			        | ({5{pcs_sel[2]}} & pcs2_reset_source)
			        | ({5{pcs_sel[3]}} & pcs3_reset_source)
			        | ({5{pcs_sel[4]}} & pcs4_reset_source)
			        | ({5{pcs_sel[5]}} & pcs5_reset_source)
			        | ({5{pcs_sel[6]}} & pcs6_reset_source);
end
endgenerate

//===============
// system control
//===============
wire		sr_sel_pcs;
wire		sr_sel_systemver =     (paddr[12:2] == OFFSET_SYSTEMVER[12:2]);
wire		sr_sel_boardid   =     (paddr[12:2] == OFFSET_BOARDID  [12:2]);
wire		sr_sel_systemcfg =     (paddr[12:2] == OFFSET_SYSTEMCFG[12:2]);
wire		sr_sel_smuver    =     (paddr[12:2] == OFFSET_SMUVER   [12:2]);
wire		sr_sel_systemcr  =     (paddr[12:2] == OFFSET_SYSTEMCR [12:2]);
wire		sr_sel_wakeup_rst_st = (paddr[12:2] == OFFSET_WAKEUPST [12:2]);
wire		sr_sel_clken     =     (paddr[12:2] == OFFSET_CLKEN    [12:2]);
wire		sr_sel_systemts  =     (paddr[12:2] == OFFSET_SYSTEMTS [12:2]);

`ifdef NDS_FPGA
	`ifdef AE350_DDR_LATENCY
wire		sr_sel_ddr3_latency = (paddr[12:2] == OFFSET_DDR3_LATENCY[12:2]);
wire		sr_sel_sram_size    = (paddr[12:2] == OFFSET_SRAM_SIZE[12:2]);
	`endif
`endif

`ifdef NDS_BOARD_CF1
assign		cf1_pinmux_ctrl0_sel = (paddr[12:2] == OFFSET_PINMUX_CTRL0[12:2]);
assign		cf1_pinmux_ctrl1_sel = (paddr[12:2] == OFFSET_PINMUX_CTRL1[12:2]);
`endif	// NDS_BOARD_CF1




wire [3:0]	sr_sel_hart_rst_vec_lo = {(NDS_NHART > 3) & (paddr[12:2] == OFFSET_HART3_RST_VEC[12:2]), 
				          (NDS_NHART > 2) & (paddr[12:2] == OFFSET_HART2_RST_VEC[12:2]), 
				          (NDS_NHART > 1) & (paddr[12:2] == OFFSET_HART1_RST_VEC[12:2]), 
				          (NDS_NHART > 0) & (paddr[12:2] == OFFSET_HART0_RST_VEC[12:2])}; 

wire [3:0]	sr_sel_hart_rst_vec_hi;
assign	sr_sel_hart_rst_vec_hi = {(NDS_NHART > 3) & (paddr[12:2] == OFFSET_HART3_RST_VEC_HI[12:2]), 
			          (NDS_NHART > 2) & (paddr[12:2] == OFFSET_HART2_RST_VEC_HI[12:2]), 
			          (NDS_NHART > 1) & (paddr[12:2] == OFFSET_HART1_RST_VEC_HI[12:2]), 
			          (NDS_NHART > 0) & (paddr[12:2] == OFFSET_HART0_RST_VEC_HI[12:2])}; 

wire pwrite_valid = psel & pwrite & penable;

reg	[2:0] sr_cer;
wire	cer_wen = pwrite_valid & sr_sel_clken;
always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		sr_cer <= 3'b111;
	end
	else if (cer_wen) begin
		sr_cer <= pwdata[2:0];
	end
end

// SMUCR related
wire	smucr_wen = pwrite_valid & (paddr[12:2] == OFFSET_SMUCR[12:2]);
wire	smu_sw_rst_cmd = smucr_wen & (pwdata[7:0] == 8'h3c);
wire	smu_sw_rst_nx;
assign smu_sw_rst_nx = smu_sw_rst_cmd & ~smu_sw_rst;
always @(posedge pclk or negedge presetn) 
begin
	if (!presetn) begin
		smu_sw_rst <= 1'b0;
	end
	else begin
		smu_sw_rst <= smu_sw_rst_nx;
	end
end

wire		update_systemcr = pwrite_valid & sr_sel_systemcr;
always @(posedge pclk or negedge presetn) 
begin
	if (!presetn) begin
		system_clock_ratio <= `ATCSMU100_CLKR_DEFAULT;
	end
	else if (update_systemcr) begin
		system_clock_ratio <= pwdata[4:0];
	end
end

wire	apor_rstn;
wire	mpor_rstn;
wire	hw_rstn;
wire	wdt_rstn;
wire	sw_rstn;

reg	apor_rstn_st;
reg	mpor_rstn_st;
reg	hw_rstn_st;
reg	wdt_rstn_st;
reg	sw_rstn_st;

assign apor_rstn = ~pcs_reset_source[0];
assign mpor_rstn = ~pcs_reset_source[4];
assign hw_rstn   = ~pcs_reset_source[3];
assign wdt_rstn  = ~pcs_reset_source[2];
assign sw_rstn   = ~pcs_reset_source[1];

wire	[31:0]	sr_systemver = PRODUCT_ID;
wire	[31:0]	sr_boardid   = BOARD_ID;
wire	[31:0]	sr_systemts = SYS_TS[31:0];
wire	[31:0]	sr_systemcfg = {23'b0, l2c_existence, core_num};
wire	[31:0]	sr_smuver = `ATCSMU100_VERID;
wire	[31:0]	sr_systemcr = {27'b0, system_clock_ratio};
				   //{21'h0, wrsr_dbg, wrsr_alm, wrsr_extw, 3'h0, wrsr_sw, wrsr_wdt, wrsr_hw, wrsr_mpor, wrsr_apor};
wire	[31:0]	sr_wakeup_rst_st = {27'd0, sw_rstn_st, wdt_rstn_st, hw_rstn_st, mpor_rstn_st, apor_rstn_st};
wire	[31:0] sr_hart_rst_vec_lo [0:3];
wire	[31:0] sr_hart_rst_vec_hi [0:3];
wire	[63:0] sr_hart_rst_vec [0:3];

assign sr_hart_rst_vec[0] = {sr_hart_rst_vec_hi[0], sr_hart_rst_vec_lo[0]};
assign sr_hart_rst_vec[1] = {sr_hart_rst_vec_hi[1], sr_hart_rst_vec_lo[1]};
assign sr_hart_rst_vec[2] = {sr_hart_rst_vec_hi[2], sr_hart_rst_vec_lo[2]};
assign sr_hart_rst_vec[3] = {sr_hart_rst_vec_hi[3], sr_hart_rst_vec_lo[3]};

assign		core_reset_vectors = {sr_hart_rst_vec[3],
				      sr_hart_rst_vec[2],
				      sr_hart_rst_vec[1],
				      sr_hart_rst_vec[0]};

////// wakeup_rst source
wire	clr_apor_rstn_st;
assign clr_apor_rstn_st = sr_sel_wakeup_rst_st & pwdata[0] & pwrite_valid;
always @(posedge pclk or negedge apor_rstn) begin
	if (!apor_rstn) begin
		apor_rstn_st <= 1'b1;
	end
	else if (clr_apor_rstn_st) begin
		apor_rstn_st <= 1'b0;
	end
end

wire	clr_mpor_rstn_st;
assign clr_mpor_rstn_st = sr_sel_wakeup_rst_st & pwdata[1] & pwrite_valid;
always @(posedge pclk or negedge mpor_rstn) begin
	if (!mpor_rstn) begin
		mpor_rstn_st <= 1'b1;
	end
	else if (clr_mpor_rstn_st) begin
		mpor_rstn_st <= 1'b0;
	end
end

wire	clr_hw_rstn_st;
wire	set_hw_rstn_st;
wire	hw_rstn_st_nx;
assign set_hw_rstn_st = !hw_rstn;
assign clr_hw_rstn_st = sr_sel_wakeup_rst_st & pwdata[2] & pwrite_valid;
assign hw_rstn_st_nx  = set_hw_rstn_st | (~clr_hw_rstn_st & hw_rstn_st);
always @(posedge pclk or negedge apor_rstn) begin
	if (!apor_rstn) begin
		hw_rstn_st <= 1'b0;
	end
	else begin
		hw_rstn_st <= hw_rstn_st_nx;
	end
end

wire	clr_wdt_rstn_st;
wire	set_wdt_rstn_st;
wire	wdt_rstn_st_nx;
assign set_wdt_rstn_st = !wdt_rstn;
assign clr_wdt_rstn_st = sr_sel_wakeup_rst_st & pwdata[3] & pwrite_valid;
assign wdt_rstn_st_nx  = set_wdt_rstn_st | (~clr_wdt_rstn_st & wdt_rstn_st);
always @(posedge pclk or negedge apor_rstn) begin
	if (!apor_rstn) begin
		wdt_rstn_st <= 1'b0;
	end
	else begin
		wdt_rstn_st <= wdt_rstn_st_nx;
	end
end

wire	clr_sw_rstn_st;
wire	set_sw_rstn_st;
wire	sw_rstn_st_nx;
assign set_sw_rstn_st = !sw_rstn;
assign clr_sw_rstn_st = sr_sel_wakeup_rst_st & pwdata[4] & pwrite_valid;
assign sw_rstn_st_nx  = set_sw_rstn_st | (~clr_sw_rstn_st & sw_rstn_st);
always @(posedge pclk or negedge apor_rstn) begin
	if (!apor_rstn) begin
		sw_rstn_st <= 1'b0;
	end
	else begin
		sw_rstn_st <= sw_rstn_st_nx;
	end
end

reg	[31:2]	reg_sr_hart_rst_vec_lo [0:NDS_NHART-1];
reg	[31:0]	reg_sr_hart_rst_vec_hi [0:NDS_NHART-1];
genvar i;
generate
for (i = 0 ; i < 4 ; i = i + 1) begin: gen_rst_vectors_lo
	if (NDS_NHART > i) begin: gen_rst_vector_setup
		always @(negedge mpd_por_rstn or posedge pclk) begin
			if (!mpd_por_rstn)
				reg_sr_hart_rst_vec_lo[i] <= RESET_VECTOR_DEFAULT[31:2];
			else if (pwrite_valid & sr_sel_hart_rst_vec_lo[i])
				reg_sr_hart_rst_vec_lo[i] <= pwdata[31:2];
		end

		assign sr_hart_rst_vec_lo[i] = {reg_sr_hart_rst_vec_lo[i],2'b0};
	end
	else begin: gen_rst_vector_lo_default
		assign sr_hart_rst_vec_lo[i] = 32'b0;
	end
end
endgenerate

generate
for (i = 0 ; i < 4 ; i = i + 1) begin: gen_rst_vectors_hi
	if (NDS_NHART > i) begin: gen_rst_vector_hi_setup
		always @(negedge mpd_por_rstn or posedge pclk) begin
			if (!mpd_por_rstn)
				reg_sr_hart_rst_vec_hi[i] <= RESET_VECTOR_HI_DEFAULT[31:0];
			else if (pwrite_valid & sr_sel_hart_rst_vec_hi[i])
				reg_sr_hart_rst_vec_hi[i] <= pwdata[31:0];
		end

		assign sr_hart_rst_vec_hi[i] = {reg_sr_hart_rst_vec_hi[i]};
	end
	else begin: gen_rst_vector_hi_default
		assign sr_hart_rst_vec_hi[i] = 32'd0;
	end
end
endgenerate

assign sr_sel_pcs = |pcs_sel;

`ifdef NDS_BOARD_CF1
// CF1 pinmux
always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		cf1_pinmux_ctrl0 <= `ATCSMU100_CF1_PINMUX_CTRL0_DEFAULT;
	else if (pwrite_valid && cf1_pinmux_ctrl0_sel)
		cf1_pinmux_ctrl0 <= pwdata[31:0];
	else
		cf1_pinmux_ctrl0 <= cf1_pinmux_ctrl0;
end

always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		cf1_pinmux_ctrl1 <= `ATCSMU100_CF1_PINMUX_CTRL1_DEFAULT;
	else if (pwrite_valid && cf1_pinmux_ctrl1_sel)
		cf1_pinmux_ctrl1 <= pwdata[31:0];
	else
		cf1_pinmux_ctrl1 <= cf1_pinmux_ctrl1;
end

`endif // NDS_BOARD_CF1

assign		prdata = ({32{sr_sel_systemver    }} & sr_systemver    )
		       | ({32{sr_sel_boardid      }} & sr_boardid      )
		       | ({32{sr_sel_systemts     }} & sr_systemts     )
		       | ({32{sr_sel_systemcfg    }} & sr_systemcfg    )
		       | ({32{sr_sel_smuver       }} & sr_smuver       )
		       | ({32{sr_sel_systemcr     }} & sr_systemcr     )
		       | ({32{sr_sel_wakeup_rst_st}} & sr_wakeup_rst_st)
		       | ({32{sr_sel_clken        }} & {29'h0, sr_cer} )
		       | ({32{sr_sel_hart_rst_vec_lo[0]}} & sr_hart_rst_vec_lo[0])
		       | ({32{sr_sel_hart_rst_vec_lo[1]}} & sr_hart_rst_vec_lo[1])
		       | ({32{sr_sel_hart_rst_vec_lo[2]}} & sr_hart_rst_vec_lo[2])
		       | ({32{sr_sel_hart_rst_vec_lo[3]}} & sr_hart_rst_vec_lo[3])
		       | ({32{sr_sel_hart_rst_vec_hi[0]}} & sr_hart_rst_vec_hi[0])
		       | ({32{sr_sel_hart_rst_vec_hi[1]}} & sr_hart_rst_vec_hi[1])
		       | ({32{sr_sel_hart_rst_vec_hi[2]}} & sr_hart_rst_vec_hi[2])
		       | ({32{sr_sel_hart_rst_vec_hi[3]}} & sr_hart_rst_vec_hi[3])
`ifdef NDS_FPGA
	`ifdef AE350_DDR_LATENCY
		       | ({32{sr_sel_ddr3_latency}} & ddr3_latency_reg_out)
		       | ({32{sr_sel_sram_size}}    & sram_size_reg_out)
       `endif
`endif // NDS_FPGA
`ifdef NDS_BOARD_CF1
		       | ({32{cf1_pinmux_ctrl0_sel}} & cf1_pinmux_ctrl0)
		       | ({32{cf1_pinmux_ctrl1_sel}} & cf1_pinmux_ctrl1)
`endif	// NDS_BOARD_CF1
		       | ({32{sr_sel_pcs}} & prdata_pcs);

assign		pready = 1'b1;
assign		pslverr = 1'b0;

`ifdef NDS_FPGA
	`ifdef AE350_DDR_LATENCY
		`ifdef AE350_K7DDR3_SUPPORT
			`define NDS_DDR_LATENCY_REG
		`elsif AE350_VUDDR4_SUPPORT
			`define NDS_DDR_LATENCY_REG
		`else
			`define NDS_NO_DDR_LATENCY_REG
		`endif
	`endif // AE350_DDR_LATENCY
`endif // NDS_FPGA

`ifdef NDS_DDR_LATENCY_REG
	// ddr3_latency reg
	reg	[3:0]	ddr3_latency_reg; 
	reg	[1:0]	ddr3_bw_ctrl_reg; 
	reg		ddr3_latency_en; 
	always @(negedge presetn or posedge pclk)
	begin
	        if (!presetn) begin
	                ddr3_latency_reg <= 4'd0;
	                ddr3_bw_ctrl_reg <= 2'd0;
	                ddr3_latency_en  <= 1'b0;
		end
	        else if (pwrite_valid & sr_sel_ddr3_latency) begin
	                ddr3_latency_reg <= pwdata[3:0];
	                ddr3_bw_ctrl_reg <= pwdata[5:4];
			ddr3_latency_en  <= pwdata[31];
		end
	end
	
	assign ddr3_latency_reg_out = {ddr3_latency_en, 25'h0, ddr3_bw_ctrl_reg, ddr3_latency_reg};
	assign ddr3_latency = ddr3_latency_en ? ddr3_latency_reg : 4'b0;
        assign ddr3_bw_ctrl = ddr3_bw_ctrl_reg;
`endif // NDS_DDR_LATENCY_REG

`ifdef NDS_NO_DDR_LATENCY_REG
	assign ddr3_latency_reg_out = 32'h0;
	assign ddr3_latency = 4'h0;
        assign ddr3_bw_ctrl = 2'b0;
`endif // NDS_NO_DDR_LATENCY_REG

`ifdef NDS_FPGA
	`ifdef AE350_DDR_LATENCY
                `ifdef AE350_RAMBRG200_SUPPORT
// VPERL_BEGIN
// for (my $i = 0 ; $i < 13 ; $i++) {
// 	my $label;
// 	my $size;
// 	if ($i >= 10) {
// 		$label = "MB";
// 		$size = $i - 10 ;
// 	} else {
// 		$label = "KB";
// 		$size = $i ;
// 	}
// : 	`ifdef AE350_SRAM_%d%s	:: 1 << $size, $label
// : 		localparam SRAM_SIZE_KB = \$clog2(%d) + 1; // %d %s	:: 1 << $i, 1 << $size, $label 
// : 	`endif // AE350_SRAM_%d%s     :: 1 << $size, $label
// 
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
	`ifdef AE350_SRAM_1KB
		localparam SRAM_SIZE_KB = $clog2(1) + 1; // 1 KB
	`endif // AE350_SRAM_1KB
	`ifdef AE350_SRAM_2KB
		localparam SRAM_SIZE_KB = $clog2(2) + 1; // 2 KB
	`endif // AE350_SRAM_2KB
	`ifdef AE350_SRAM_4KB
		localparam SRAM_SIZE_KB = $clog2(4) + 1; // 4 KB
	`endif // AE350_SRAM_4KB
	`ifdef AE350_SRAM_8KB
		localparam SRAM_SIZE_KB = $clog2(8) + 1; // 8 KB
	`endif // AE350_SRAM_8KB
	`ifdef AE350_SRAM_16KB
		localparam SRAM_SIZE_KB = $clog2(16) + 1; // 16 KB
	`endif // AE350_SRAM_16KB
	`ifdef AE350_SRAM_32KB
		localparam SRAM_SIZE_KB = $clog2(32) + 1; // 32 KB
	`endif // AE350_SRAM_32KB
	`ifdef AE350_SRAM_64KB
		localparam SRAM_SIZE_KB = $clog2(64) + 1; // 64 KB
	`endif // AE350_SRAM_64KB
	`ifdef AE350_SRAM_128KB
		localparam SRAM_SIZE_KB = $clog2(128) + 1; // 128 KB
	`endif // AE350_SRAM_128KB
	`ifdef AE350_SRAM_256KB
		localparam SRAM_SIZE_KB = $clog2(256) + 1; // 256 KB
	`endif // AE350_SRAM_256KB
	`ifdef AE350_SRAM_512KB
		localparam SRAM_SIZE_KB = $clog2(512) + 1; // 512 KB
	`endif // AE350_SRAM_512KB
	`ifdef AE350_SRAM_1MB
		localparam SRAM_SIZE_KB = $clog2(1024) + 1; // 1 MB
	`endif // AE350_SRAM_1MB
	`ifdef AE350_SRAM_2MB
		localparam SRAM_SIZE_KB = $clog2(2048) + 1; // 2 MB
	`endif // AE350_SRAM_2MB
	`ifdef AE350_SRAM_4MB
		localparam SRAM_SIZE_KB = $clog2(4096) + 1; // 4 MB
	`endif // AE350_SRAM_4MB
// VPERL_GENERATED_END
	assign sram_size_reg_out = SRAM_SIZE_KB ;
                `else
	assign sram_size_reg_out = 32'h0;
                `endif	// AE350_RAMBRG200_SUPPORT
	`endif // AE350_DDR_LATENCY
`endif	// NDS_FPGA

endmodule
