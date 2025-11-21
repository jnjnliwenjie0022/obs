`include "config.inc"
`include "atcsmu100_config.vh"
`include "atcsmu100_const.vh"
// Power control slot
module atcsmu100_pcs (
// APB
input		pclk,
input		presetn,

// APBIF
output	[31:0]	pcs_rdata,
input		pcs_sel,
input	[31:0]	pcs_wdata,
input		pcs_write,
input		pcs_sel_cfg,
input		pcs_sel_scratch,
input		pcs_sel_misc,
input		pcs_sel_misc2, 		//reserved for PLS
input		pcs_sel_we,
input		pcs_sel_ctl,
input		pcs_sel_status,
input		pcs_sel_cer,

//SMU interface
input	[31:1]	pcs_wakeup_event,	// Level trigger

// PD interface
output		pcs_int,
output		pcs_wakeup,
output		pcs_standby_req,
input		pcs_standby_ok,
output		pcs_frq_scale_req,
output	[2:0]	pcs_frq_scale,
output	[31:0]	pcs_frq_clkon,		//reserved for PLS
input		pcs_frq_scale_ack,
output		pcs_vol_scale_req,
output	[2:0]	pcs_vol_scale,
input		pcs_vol_scale_ack,
output	reg	pcs_iso,
output	reg	pcs_reten,
output	reg	pcs_resetn,
output	[3:0]	pcs_mem_init,		//was icache_disable_init, dcache_disable_init
input	[4:0]	pcs_reset_source
);

`ifdef NDS_ILA_SMU
parameter	ILA_ON = 0;
`endif // NDS_ILA_SMU

// Configuration
//parameter	PCS_SUPPORT = 1;
parameter	PCS_RESET_SUPPORT = 1;		// 0 1
parameter	LIGHT_SLEEP_SUPPORT = 1;	// 0 1
parameter	DEEP_SLEEP_SUPPORT = 1;		// 0 1
parameter	FIELD_MEM_INIT = 0;		// 0 ~ 4

// CLKON_DEFAULT_SETTING
parameter	CORE_CLK_EN_IN_LS  = 1'b0;
parameter	CORE_CLK_EN_IN_DS  = 1'b0;
parameter	CORE_CLK_EN_IN_STB = 1'b0;

parameter	HCLK_EN_IN_LS      = 1'b1;
parameter	HCLK_EN_IN_DS	   = 1'b0;
parameter	HCLK_EN_IN_STB     = 1'b1;

parameter	PCLK_EN_IN_LS      = 1'b1;
parameter	PCLK_EN_IN_DS      = 1'b0;
parameter	PCLK_EN_IN_STB     = 1'b1;

parameter	ACLK_EN_IN_LS      = 1'b1;
parameter	ACLK_EN_IN_DS      = 1'b0;
parameter	ACLK_EN_IN_STB     = 1'b1;

parameter	LM_CLK_EN_IN_LS    = 1'b1;
parameter	LM_CLK_EN_IN_DS    = 1'b0;
parameter	LM_CLK_EN_IN_STB   = 1'b1;

parameter	DC_CLK_EN_IN_LS    = 1'b0;
parameter	DC_CLK_EN_IN_DS    = 1'b0;
parameter	DC_CLK_EN_IN_STB   = 1'b1;

parameter	CLKON_DEFAULT_VAL  = 1'b1;

// TODO: upgrade the localparam to parameter when the feature is implemented
localparam	DVFS_SUPPORT = 0;
localparam	FIX_VOLTAGE = 1;

// DO NOT change the encoding
localparam	ST_ACTIVE	= 4'b0000;	// ACT
localparam	ST_WAIT_STBY	= 4'b0001;	// WAI
localparam	ST_FRQ		= 4'b0010;	// FRQ
localparam	ST_ISO		= 4'b0011;	// ISO
localparam	ST_RETEN	= 4'b0100;	// RET
localparam	ST_RESET	= 4'b0101;	// RST
localparam	ST_VOL		= 4'b0110;	// VOL
localparam	ST_DEEP_SLEEP	= 4'b0111;	// DS
localparam	ST_LIGHT_SLEEP	= 4'b1111;	// LS
// PCS_STATUS.cmd_status
localparam	CMD_STATUS_SUCCESS = 3'd0;
localparam	CMD_STATUS_WAIVE   = 3'd6;
localparam	CMD_STATUS_ILLEGAL = 3'd7;


reg	[3:0]	pcs_cs;
reg	[3:0]	pcs_ns;
wire		is_ACT	    = (pcs_cs[3:0] == ST_ACTIVE     );	// 4'b0000
wire		is_WAI	    = (pcs_cs[3:0] == ST_WAIT_STBY  );	// 4'b0001
wire		is_FRQ	    = (pcs_cs[3:0] == ST_FRQ	    );	// 4'b0010
wire		is_ISO	    = (pcs_cs[3:0] == ST_ISO	    );	// 4'b0011
wire		is_RET	    = (pcs_cs[3:0] == ST_RETEN      );	// 4'b0100
wire		is_RST	    = (pcs_cs[3:0] == ST_RESET      );	// 4'b0101
wire		is_VOL	    = (pcs_cs[3:0] == ST_VOL	    );	// 4'b0110
wire		is_DS 	    = (pcs_cs[3:0] == ST_DEEP_SLEEP );	// 4'b0111
wire		is_LS 	    = (pcs_cs[3:0] == ST_LIGHT_SLEEP);	// 4'b1111

wire		is_DSLS = &pcs_cs[2:0];		// is deepsleep/lightsleep
wire		is_busy = is_FRQ | is_ISO | is_RET | is_RST | is_VOL;

wire		wakeup_event_taken;
wire	[4:0]	wakeup_vector;

wire		dc_clkon;
wire		lm_clkon;
wire		aclkon;
wire		pclkon;
wire		hclkon;
wire		core_clkon;
wire		clkon_default;

wire		pcs_frq_scale_ack_sync;
wire		pcs_vol_scale_ack_sync;

nds_sync_l2l #(
	.RESET_VALUE			(1'b0		)
) frq_scale_ack_sync ( 
	.b_reset_n			(presetn	       ),
	.b_clk				(pclk		       ),
	.a_signal			(pcs_frq_scale_ack     ),
	.b_signal			(pcs_frq_scale_ack_sync), // synchronized level signal
	.b_signal_rising_edge_pulse	( /* NC */	       ), // rising edge detector
	.b_signal_falling_edge_pulse	( /* NC */	       ), // falling edge detector
	.b_signal_edge_pulse		( /* NC */	       )  // either edge detector
);

nds_sync_l2l #(
	.RESET_VALUE			(1'b0		)
) vol_scale_ack_sync ( 
	.b_reset_n			(presetn	       ),
	.b_clk				(pclk		       ),
	.a_signal			(pcs_vol_scale_ack     ),
	.b_signal			(pcs_vol_scale_ack_sync), // synchronized level signal
	.b_signal_rising_edge_pulse	( /* NC */	       ), // rising edge detector
	.b_signal_falling_edge_pulse	( /* NC */	       ), // falling edge detector
	.b_signal_edge_pulse		( /* NC */	       )  // either edge detector
);


//======================
// PCS system registers
//======================
reg	[31:0]	pcs_scratch;
reg	[31:1]	pcs_we_31_1;	
// Write PCS system registers
wire pcs_write_valid = pcs_sel & pcs_write;
wire update_pcs_scratch = pcs_write_valid & pcs_sel_scratch;
always @(posedge pclk or negedge presetn) 
begin
	if (!presetn)
		pcs_scratch <= 32'b0;
	else if (update_pcs_scratch)
		pcs_scratch <= pcs_wdata[31:0];
end

wire	[3:0]	mem_init; 
reg	[3:0]	iso_cyc; 
reg	[7:0]	reten_cyc; 
//reg [15:0]	to_cyc; 
wire update_pcs_misc = pcs_write_valid & pcs_sel_misc;
always @(posedge pclk or negedge presetn) 
begin
	if (!presetn) begin
		iso_cyc <= 4'hf;
		reten_cyc <= 8'hff;
	end
	else if (update_pcs_misc) begin
		iso_cyc <= pcs_wdata[3:0];
		reten_cyc <= pcs_wdata[11:4];
	end
end

generate
if (FIELD_MEM_INIT) begin: gen_blk_pcs_mem_init
	reg [FIELD_MEM_INIT-1:0] reg_mem_init;
	always @(posedge pclk or negedge presetn) 
	begin
		if (!presetn) begin
			reg_mem_init <= {FIELD_MEM_INIT{1'b1}};
		end
		else if (update_pcs_misc) begin
			reg_mem_init <= pcs_wdata[FIELD_MEM_INIT-1:0];
		end
	end
	assign mem_init[3:0] = {{(4-FIELD_MEM_INIT){1'b0}},reg_mem_init[FIELD_MEM_INIT-1:0]};
end
else begin: gen_mem_init_default_value
	assign mem_init[3:0] = 4'b1111;
end
endgenerate

wire update_pcs_we = pcs_write_valid & pcs_sel_we;
always @(posedge pclk or negedge presetn) 
begin
	if (!presetn) begin
		pcs_we_31_1 <= {31{1'b1}};
	end
	else if (update_pcs_we) begin
		pcs_we_31_1 <= pcs_wdata[31:1];
	end
end

// PCS operations:
//	  0: Run (or Cancel)
//	  1: PCS_reset*
//	  2: DVFS
//	  3: Sleep
reg	[1:0]	ctl_cmd; 
reg	[4:0]	ctl_param; 
reg		write_ctl_d1;
wire		match_cycle;

wire		cmd_wakeup	= (ctl_cmd == 2'h0) & (ctl_param[1:0] == 2'h1);
wire		cmd_reset	= (PCS_RESET_SUPPORT==1)   & (ctl_cmd == 2'h1);
wire		cmd_lightsleep	= (LIGHT_SLEEP_SUPPORT==1) & (ctl_cmd == 2'h3) & (~ctl_param[0]);
wire		cmd_deepsleep	= (DEEP_SLEEP_SUPPORT==1)  & (ctl_cmd == 2'h3) & (ctl_param[0]);
wire		cmd_sleep	= cmd_lightsleep | cmd_deepsleep; 

wire		waive_write_ctl = is_busy | is_WAI;
wire		ctl_cmd_done = (cmd_sleep & is_DSLS) | (cmd_reset & is_RST & match_cycle) | 
			       (cmd_sleep & is_WAI & pcs_standby_ok & wakeup_event_taken);
always @(posedge pclk or negedge presetn) 
begin
	if (!presetn) begin
		write_ctl_d1 <= 1'h0;
		ctl_cmd <= 2'h0;
		ctl_param <= 5'h0;
	end
	else if (pcs_write_valid & pcs_sel_ctl & !waive_write_ctl) begin
		write_ctl_d1 <= 1'h1;
		ctl_cmd <= pcs_wdata[1:0];
		ctl_param <= pcs_wdata[7:3];
	end
	else if (ctl_cmd_done) begin // clr
		write_ctl_d1 <= 1'h0;
		ctl_cmd <= 2'h0;
		ctl_param <= 5'h0;
	end
	else
		write_ctl_d1 <= 1'h0;
end

wire		legal_ctl_cmd = (is_DSLS & cmd_wakeup) | (is_ACT & (cmd_reset | cmd_sleep));
wire	[2:0]	cmd_status_nx = (pcs_write_valid & pcs_sel_status) 		  ? pcs_wdata[10:8]:
				(pcs_write_valid & pcs_sel_ctl & waive_write_ctl) ? CMD_STATUS_WAIVE:
				(write_ctl_d1 & ~legal_ctl_cmd) 		  ? CMD_STATUS_ILLEGAL:
										    CMD_STATUS_SUCCESS; // write_ctl_d1

wire		update_cmd_status = (pcs_write_valid & pcs_sel_status)
				  | (pcs_write_valid & pcs_sel_ctl & waive_write_ctl)
				  | write_ctl_d1;

reg	[2:0]	cmd_status;
always @(posedge pclk or negedge presetn) 
begin
	if (!presetn) begin
		cmd_status <= 3'h0;
	end
	else if (update_cmd_status) begin
		cmd_status <= cmd_status_nx;
	end
end

// pcs_reset_source is a reset signal after DFT (it becomes test_resetn in test_mode).
// it should be converted into a flop out signal to ensure pd_status is testable.
wire [4:0] pcs_reset_source_sync;

wire reset0_n = ~pcs_reset_source[0];
wire reset4_n = ~pcs_reset_source[4];

reg pcs_reset_source0_ff;
reg pcs_reset_source4_ff;
always @(posedge pclk or negedge reset0_n) begin
        if (!reset0_n) begin
                pcs_reset_source0_ff <= 1'b0;
        end
        else begin
                pcs_reset_source0_ff <= 1'b1;
        end
end
always @(posedge pclk or negedge reset4_n) begin
        if (!reset4_n) begin
                pcs_reset_source4_ff <= 1'b0;
        end
        else begin
                pcs_reset_source4_ff <= 1'b1;
        end
end

assign pcs_reset_source_sync = {pcs_reset_source4_ff, pcs_reset_source[3:1], pcs_reset_source0_ff};

//PCS_STATUS - Power control slot status
//0: Active
//1: Reset
//2: Sleep
//3: Busy_Wait
reg	[2:0]	pd_type;
reg	[4:0]	pd_status;
always @(posedge pclk or negedge presetn)
begin
	if (!presetn) begin
		pd_type <= 3'h1;
		pd_status <= 5'h0;	// global power-on reset
	end
	else if (|pcs_reset_source_sync) begin
		pd_type <= 3'h1;
		pd_status[4:0] <= pcs_reset_source_sync[4:0];
	end
	else if (is_WAI & (pcs_ns == ST_ACTIVE)) begin // ACT <- WAI
		pd_type <= 3'h0;
		pd_status <= wakeup_vector;
	end
	else if (is_busy | is_WAI) begin
		pd_type <= 3'h3;
		pd_status[4:3] <= {~is_WAI,1'b0};
		pd_status[2:0] <= {1'b0, cmd_sleep, cmd_deepsleep};
	end
	else if (pcs_write_valid & pcs_sel_status) begin	// & ~(is_busy | is_WAI)
		pd_type <= pcs_wdata[2:0];
		pd_status <= pcs_wdata[7:3];
	end
	else if (is_DSLS) begin
		pd_type <= 3'h2;
		pd_status[4:0] <= {is_DS, 4'b0};
	end
end


reg		wakeup_int;
wire		wakeup_int_clr = pcs_write_valid & pcs_sel_status & pcs_wdata[30]; //W1C
wire		wakeup_int_set = is_WAI & (pcs_ns == ST_ACTIVE); 
wire		wakeup_int_nx = wakeup_int_set | (wakeup_int & ~wakeup_int_clr);
wire		update_wakeup_int = wakeup_int_set | wakeup_int_clr;
always @(posedge pclk or negedge presetn) 
begin
	if (!presetn) begin
		wakeup_int <= 1'h0;
	end
	else if (update_wakeup_int) begin
		wakeup_int <= wakeup_int_nx;
	end
end

reg		pend_int;
wire		pend_int_clr = pcs_write_valid & pcs_sel_status & pcs_wdata[31]; //W1C
wire		pend_int_set = write_ctl_d1 & ~legal_ctl_cmd;
wire		pend_int_nx = pend_int_set | (pend_int & ~pend_int_clr);
wire		update_pend_int = pend_int_set | pend_int_clr;
always @(posedge pclk or negedge presetn) 
begin
	if (!presetn) begin
		pend_int <= 1'h0;
	end
	else if (update_pend_int) begin
		pend_int <= pend_int_nx;
	end
end


// PCS system registers
wire	[31:0]	pcs_cfg		= {26'b0, 
				   2'b0, 
				   DEEP_SLEEP_SUPPORT==1,
				   LIGHT_SLEEP_SUPPORT==1,
				   DVFS_SUPPORT==1,
				   1'b1};
wire	[31:0]	pcs_misc	= {mem_init[3:0],
				   16'b0,
				   reten_cyc[7:0],
				   iso_cyc[3:0]};
wire	[31:0]	pcs_misc2	= {18'd0, dc_clkon, lm_clkon, aclkon, 8'd0, pclkon, hclkon, core_clkon};
wire	[31:0]	pcs_we		= {pcs_we_31_1,1'b1};	
wire	[31:0]	pcs_ctl		= {24'b0,
				   ctl_param[4:0],
				   1'b0, ctl_cmd[1:0]};
wire	[31:0]	pcs_status	= {pend_int,
				   wakeup_int,
				   19'b0,
				   cmd_status,
				   pd_status,
				   pd_type};

assign 		pcs_rdata	= ({32{pcs_sel_cfg    }} & pcs_cfg	)
			 	| ({32{pcs_sel_scratch}} & pcs_scratch	)
			 	| ({32{pcs_sel_misc   }} & pcs_misc	)
			 	| ({32{pcs_sel_misc2  }} & pcs_misc2	)
			 	| ({32{pcs_sel_we     }} & pcs_we	)
			 	| ({32{pcs_sel_ctl    }} & pcs_ctl	)
			 	| ({32{pcs_sel_status }} & pcs_status	);


//======================
// Control 
//======================

wire [31:0] unmasked_wakeup_event = {pcs_wakeup_event,cmd_wakeup} & pcs_we;
assign wakeup_event_taken = |unmasked_wakeup_event;

leading_zero_detect_32to5 leading_zero_detect_32to5(.reverse(1'b1),	// TODO: confirm
						    .data_in(unmasked_wakeup_event),
						    .leading_zero_vector(wakeup_vector));

// 8-bit counter
reg	[7:0]	counter; 
wire	[7:0]	counter_minus1 = counter - 8'b1;
assign		match_cycle = ~(|counter[7:1]);					// counter = 1 or 0
wire	[7:0]	sel_next_count = ({8{is_ACT}} & {3'b0, ctl_param[4:0]}) |
				 ({8{is_FRQ}} & {4'b0, iso_cyc[3:0]}) |
				 ({8{is_ISO}} & {reten_cyc[7:0]}) |		// PD_reset cycle
				 8'b0;						// DeepSleep reset state cycle
// State goes to "is_ISO | is_RET | is_RST" then load counter
wire		load_counter = (is_ACT & cmd_reset)		// ACT -> RST
			     | (is_FRQ & pcs_frq_scale_ack)	// - FRQ - (& cmd_deepsleep)
			     | (match_cycle)			// - ISO - RET - RST -
			     | (is_VOL & pcs_vol_scale_ack);	// RST <- VOL

always @(posedge pclk or negedge presetn) 
begin
	if (!presetn) begin
		counter <= 8'b0;
	end
	else if (load_counter) begin
		counter <= sel_next_count;
	end
	else if (is_ISO | is_RET | is_RST) begin
		counter <= counter_minus1;
	end
end

wire	frq_req_taken = pcs_frq_scale_req & pcs_frq_scale_ack_sync;
wire	vol_req_taken = pcs_vol_scale_req & pcs_vol_scale_ack_sync;

//======================
// FSM 
//======================
// FSM sequence:
// ACT(0) - RST
// ACT(0) - WAI* - FRQ - ISO - RET - RST - VOL - DS(7)
//		       - LS
//* immediately wakeup from WAI

always @* begin
	case (pcs_cs)
	ST_ACTIVE:
		if (cmd_sleep)
			pcs_ns = ST_WAIT_STBY;
		else if (cmd_reset & pcs_standby_ok)
			pcs_ns = ST_RESET;
		else 
			pcs_ns = ST_ACTIVE;
	ST_WAIT_STBY:
		if (cmd_sleep & pcs_standby_ok & ~wakeup_event_taken)
			pcs_ns = ST_FRQ;
		else if (cmd_sleep & wakeup_event_taken)
			pcs_ns = ST_ACTIVE;
		else if (~cmd_sleep)
			pcs_ns = ST_ACTIVE;
		else 
			pcs_ns = ST_WAIT_STBY;
	ST_FRQ:
		if (frq_req_taken & cmd_deepsleep)
			pcs_ns = ST_ISO;
		else if (frq_req_taken & cmd_lightsleep)
			pcs_ns = ST_LIGHT_SLEEP;
		else if (frq_req_taken)			// wakeup
			pcs_ns = ST_WAIT_STBY;
		else 
			pcs_ns = ST_FRQ;
	ST_ISO:
		if (cmd_sleep & match_cycle)
			pcs_ns = ST_RETEN;
		else if (match_cycle)			// wakeup
			pcs_ns = ST_FRQ;
		else 
			pcs_ns = ST_ISO;
	ST_RETEN:
		if (cmd_sleep & match_cycle)
			pcs_ns = ST_RESET;
		else if (match_cycle)			// wakeup
			pcs_ns = ST_ISO;
		else 
			pcs_ns = ST_RETEN;
	ST_RESET:
		if (cmd_sleep & match_cycle)
			pcs_ns = ST_VOL;
		else if (cmd_reset & match_cycle)
			pcs_ns = ST_ACTIVE;
		else if (match_cycle)			// wakeup
			pcs_ns = ST_RETEN;
		else 
			pcs_ns = ST_RESET;
	ST_VOL:
		if (vol_req_taken & cmd_sleep)
			pcs_ns = ST_DEEP_SLEEP;
		else if (vol_req_taken)			// wakeup
			pcs_ns = ST_RESET;
		else 
			pcs_ns = ST_VOL;
	ST_DEEP_SLEEP:
		if (wakeup_event_taken)
			pcs_ns = ST_VOL;
		else 
			pcs_ns = ST_DEEP_SLEEP;
	ST_LIGHT_SLEEP:
		if (wakeup_event_taken)
			pcs_ns = ST_FRQ;	
		else 
			pcs_ns = ST_LIGHT_SLEEP;
	default:
			pcs_ns = 4'bx;
	endcase
end

wire update_pcs_cs = (|ctl_cmd[1:0]) | wakeup_event_taken;
always @(posedge pclk or negedge presetn) 
begin
	if (!presetn) begin
		pcs_cs <= ST_ACTIVE;
	end
	else if (update_pcs_cs) begin
		pcs_cs <= pcs_ns;
	end
end

reg	reg_frq_scale_req;
wire	set_reg_frq_scale_req; 
wire	clr_reg_frq_scale_req;
wire	reg_frq_scale_req_nx;

reg	reg_vol_scale_req;
wire	set_reg_vol_scale_req; 
wire	clr_reg_vol_scale_req;
wire	reg_vol_scale_req_nx;

reg [11:0] clkon_for_cer;

wire update_cer = pcs_write_valid & pcs_sel_cer;
always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		clkon_for_cer <= 12'hfff;
	end
	else if (update_cer) begin
		clkon_for_cer <= pcs_wdata[11:0];
	end
end

reg reg_ls_core_clkon;
reg reg_ls_hclkon;
reg reg_ls_pclkon;
reg reg_ls_aclkon;
reg reg_ls_lm_clkon;
reg reg_ls_dc_clkon;

wire update_clkon = pcs_write_valid & pcs_sel_misc2;
always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		reg_ls_core_clkon   <= CORE_CLK_EN_IN_LS;
		reg_ls_hclkon       <= HCLK_EN_IN_LS;
		reg_ls_pclkon       <= PCLK_EN_IN_LS;
		reg_ls_aclkon       <= ACLK_EN_IN_LS;
		reg_ls_lm_clkon     <= LM_CLK_EN_IN_LS;
		reg_ls_dc_clkon     <= DC_CLK_EN_IN_LS;
	end
	else if (update_clkon) begin
		reg_ls_core_clkon   <= pcs_wdata[0];
		reg_ls_hclkon       <= pcs_wdata[1];
		reg_ls_pclkon       <= pcs_wdata[2];
		reg_ls_aclkon       <= pcs_wdata[11];
		reg_ls_lm_clkon     <= pcs_wdata[12];
		reg_ls_dc_clkon     <= pcs_wdata[13];
	end
end

// clkon: 0 => off, 1 => on
// cer:   0 => off, 1 => on
assign 	clkon_default = ~(cmd_deepsleep | cmd_lightsleep);

assign core_clkon = (cmd_deepsleep  & CORE_CLK_EN_IN_DS)
		  | (cmd_lightsleep & reg_ls_core_clkon)
		  | (clkon_default  & clkon_for_cer[0]);

assign hclkon     = (cmd_deepsleep  & HCLK_EN_IN_DS)
		  | (cmd_lightsleep & reg_ls_hclkon)
		  | (clkon_default  & clkon_for_cer[1]);

assign pclkon     = (cmd_deepsleep  & PCLK_EN_IN_DS)
		  | (cmd_lightsleep & reg_ls_pclkon)
		  | (clkon_default  & clkon_for_cer[2]);

assign aclkon     = (cmd_deepsleep  & ACLK_EN_IN_DS)
		  | (cmd_lightsleep & reg_ls_aclkon)
		  | (clkon_default  & clkon_for_cer[11]);

assign lm_clkon   = (cmd_deepsleep  & LM_CLK_EN_IN_DS)
		  | (cmd_lightsleep & reg_ls_lm_clkon)
		  | (clkon_default  & CLKON_DEFAULT_VAL);

assign dc_clkon   = (cmd_deepsleep  & DC_CLK_EN_IN_DS)
		  | (cmd_lightsleep & reg_ls_dc_clkon)
		  | (clkon_default  & CLKON_DEFAULT_VAL);

//======================
// PD interface
//======================
assign		pcs_int = pend_int;
assign		pcs_wakeup = wakeup_int;
assign		pcs_standby_req = cmd_sleep | cmd_reset;
assign		pcs_frq_scale_req = reg_frq_scale_req;
assign		pcs_frq_scale = cmd_deepsleep ? 3'b0 : 3'b1;	// use clkon to partially control light sleep clk

assign		pcs_frq_clkon[0]  = core_clkon;
assign		pcs_frq_clkon[1]  = hclkon;
assign		pcs_frq_clkon[2]  = pclkon;
assign		pcs_frq_clkon[11] = aclkon;
assign		pcs_frq_clkon[12] = lm_clkon;
assign		pcs_frq_clkon[13] = dc_clkon;
assign		pcs_frq_clkon[10:3]  = 8'h0;
assign		pcs_frq_clkon[31:14] = 18'h0;

assign		pcs_vol_scale_req = reg_vol_scale_req;
assign		pcs_vol_scale = cmd_sleep ? 3'b0 : 3'b1;
wire		pcs_iso_nx    =   is_ISO | is_RET | is_RST | is_VOL | is_DS;	// ISO - RET - RST - VOL - DS
wire		pcs_reten_nx  =   is_RET | is_RST | is_VOL | is_DS;		// RET - RST - VOL - DS 
wire		pcs_resetn_nx = ~(is_RST | is_VOL | is_DS);		        // RST - VOL - DS
assign		pcs_mem_init = mem_init;

// set pcs_resetn/pcs_reten/pcs_iso as flop out to avoid glitches on reset-gen / isolation cell /retention cell
always @(posedge pclk or negedge presetn) 
begin
	if (!presetn) begin
		pcs_resetn <= 1'b1;
		pcs_iso    <= 1'b0;
		pcs_reten  <= 1'b0;
	end
	else begin
		pcs_resetn <= pcs_resetn_nx;
		pcs_iso    <= pcs_iso_nx;
		pcs_reten  <= pcs_reten_nx;
	end
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		reg_frq_scale_req <= 1'b0;
		reg_vol_scale_req <= 1'b0;
	end
	else begin
		reg_frq_scale_req <= reg_frq_scale_req_nx;
		reg_vol_scale_req <= reg_vol_scale_req_nx;
	end
end

assign set_reg_frq_scale_req = is_FRQ & ~pcs_frq_scale_ack_sync;
assign clr_reg_frq_scale_req = pcs_frq_scale_ack_sync;
assign reg_frq_scale_req_nx  = set_reg_frq_scale_req | (~clr_reg_frq_scale_req & reg_frq_scale_req);

assign set_reg_vol_scale_req = is_VOL & ~pcs_vol_scale_ack_sync;
assign clr_reg_vol_scale_req = pcs_vol_scale_ack_sync;
assign reg_vol_scale_req_nx  = set_reg_vol_scale_req | (~clr_reg_vol_scale_req & reg_vol_scale_req);

`ifdef NDS_ILA_SMU
generate
if (ILA_ON == 1) begin : gen_PCS_ILA

reg	[31:0] reg_wakeup_event;
always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		reg_wakeup_event <= 32'd0;
	end
	else begin
		reg_wakeup_event <= unmasked_wakeup_event;
	end
end

(* mark_debug = "true" *) wire [31:0] probe10 = {17'd0, cmd_lightsleep, cmd_deepsleep, ctl_cmd_done, 
						 1'b0, is_ACT, is_WAI, is_FRQ, is_ISO, is_RET, is_RST, is_VOL, is_DS, is_LS, 1'b0, 1'b0};
(* mark_debug = "true" *) wire [31:0] probe11 = {17'd0, pcs_iso, 1'b0, pd_type, pd_status, wakeup_event_taken, 
						 pcs_frq_scale_req, pcs_frq_scale_ack_sync, pcs_vol_scale_req, pcs_vol_scale_ack_sync};
(* mark_debug = "true" *) wire [31:0] probe12 = unmasked_wakeup_event;
(* mark_debug = "true" *) wire [31:0] probe13 = {pcs_wakeup_event,cmd_wakeup};


ila16384_4x32b ila16384_4x32b_1(pclk, trig_in, trig_in_ack, trig_out, trig_out_ack, probe10, probe11, probe12, probe13);

end
endgenerate

`endif // NDS_ILA_SMU

endmodule


