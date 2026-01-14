module ncejdtm200_tap (
// VPERL: &PORTLIST;
// VPERL_GENERATED_BEGIN
	  dbg_wakeup_req,
	  tms_out_en,
	  tdi,      
	  tms,      
	  tdo,      
	  tdo_out_en,
	  tck,      
	  pwr_rst_n, // Use the power on reset to drive trst
	  dmi_tap_hrdata,
	  dmi_tap_ack,
	  tap_dmi_req,
	  tap_dmi_data,
	  dtm_dmi_resetn 
// VPERL_GENERATED_END
);

// JTAG_TWOWIRE_SUPPORT
parameter DEBUG_INTERFACE = "jtag";	// jtag_host_port or serial_debug_port
parameter DMI_ADDR_BITS  = 7;

// DMI_ACCESS
localparam  DMI_DATA_BITS  = 32;
localparam  DMI_OP_BITS    = 2;

// DTMCS_IDLE
localparam DTMCS_IDLE_CYCLES = 3'd7;

// IDCODE
// JTAG_VERSION  = 4'h1
// JTAG_PART_NUM = 16'h0005
// JTAG_MANUF_ID = 11'h31E
// The last bit is 1'b1
localparam JTAG_IDCODE = 32'h1000563D;
   
// TAP Controller FSM encoding
localparam TEST_LOGIC_RESET = 4'b0000;
localparam RUN_TEST_IDLE    = 4'b1000;
localparam SELECT_DR_SCAN   = 4'b1001;
localparam CAPTURE_DR	    = 4'b1010;
localparam SHIFT_DR	    = 4'b1011;
localparam EXIT1_DR	    = 4'b1100;
localparam PAUSE_DR	    = 4'b1101;
localparam EXIT2_DR	    = 4'b1110;
localparam UPDATE_DR	    = 4'b1111;
localparam SELECT_IR_SCAN   = 4'b0001;
localparam CAPTURE_IR	    = 4'b0010;
localparam SHIFT_IR	    = 4'b0011;
localparam EXIT1_IR	    = 4'b0100;
localparam PAUSE_IR	    = 4'b0101;
localparam EXIT2_IR	    = 4'b0110;
localparam UPDATE_IR	    = 4'b0111;

// TAP instruction encoding
localparam IDCODE           = 5'b00001;
localparam DTM_CTRL_ST      = 5'b10000;
localparam DMI_ACCESS       = 5'b10001;

// Define of NDS_AHB bus response codes.
localparam   DMI_OP_NOP          = 2'b00;
localparam   DMI_OP_READ         = 2'b01;
localparam   DMI_OP_WRITE        = 2'b10;
localparam   DMI_OP_RSV          = 2'b11;

localparam IR_BITS = 5;

localparam DMI_REG_BITS = DMI_DATA_BITS + DMI_ADDR_BITS + DMI_OP_BITS;

// IO for Debug transport hardware
// Debug wakeup 
output			dbg_wakeup_req;
// For two wire
output			tms_out_en;

// For five wire
input			tdi;
input			tms;
output			tdo;
output			tdo_out_en;

input			tck;
input			pwr_rst_n; // Use the power on reset to drive trst

// IO for dmi
input	[31:0]			dmi_tap_hrdata;
input				dmi_tap_ack;
output				tap_dmi_req;
output	[DMI_REG_BITS-1:0]	tap_dmi_data;
output				dtm_dmi_resetn;

// trst control 
reg		rst_tap;
wire		rst_tap_nx;

// reset for dmi interface
wire	dtm_dmi_resetn_nx;

// tap FSM control
wire		in_shift_st;
wire		in_shift_ir_st;
wire		in_capture_ir_st;
wire		in_update_ir_st;
wire		in_shift_dr_st;
wire		in_capture_dr_st;
wire		in_update_dr_st;
wire		is_bypass;
wire		is_idcode;
wire		is_dtm_ctrl_st;
wire		is_dmi_access;
reg	[3:0]	tap_ctr_ns;
reg	[3:0]	tap_ctr_cs;

// tap instruction
reg	[IR_BITS-1:0]	tap_ir;

// tap data scan chain
reg	[DMI_REG_BITS-1:0]	tap_data_scan;
wire	[DMI_REG_BITS-1:0]	tap_data_scan_chain;
wire	[DMI_REG_BITS-1:0] 	tap_data_scan_nx;

// DTMCS reg
reg	[1:0]	dtmcs_dmistat;
wire	[31:0]	dtmcs;
wire	[3:0]	dtmcs_version;
wire	[5:0]	dtmcs_abits;
wire	[2:0]	dtmcs_idle;
wire		dtmcs_dmihardreset;
wire		dtmcs_dmireset;

// DMI reg
reg	[DMI_REG_BITS-1:0]	dmi;
wire				dmi_busy_state;
reg				dtm_dmi_resetn;

// DMI bus request
reg tap_dmi_req;

// TDO
reg	tdo;
reg	bypass;
wire	tdo_nx;

// TDI, TMS and TDO control
wire	in_shift_tdi;
wire	in_shift_tms_d1;
wire	tdi_i;
wire	tms_i;

// Debug wake up
reg	dbg_wakeup_req;
wire	dbg_wakeup_req_nx;

generate
if (DEBUG_INTERFACE == "serial") begin: gen_jtag_twowire_control
	wire	in_shift_tms;
	wire	in_shift_tms_nx;
	wire	in_shift_tdo_nx;
	reg	in_shift_tdo_reg;
	reg	in_shift_tms_reg;
	reg	tms_reg;
	reg	tms_out_en_reg;

	assign	tms_out_en = tms_out_en_reg;

	assign	tdi_i = tms;
	assign	tms_i = in_shift_st ? tms_reg : tms;

	assign	in_shift_tdi	= in_shift_st & ~in_shift_tms & ~in_shift_tdo_reg;
	assign	in_shift_tms    = in_shift_tms_reg;
	assign	in_shift_tms_d1 = in_shift_tdo_reg;
	assign	in_shift_tms_nx = in_shift_tdi;
	assign	in_shift_tdo_nx = in_shift_tms;
	always @(posedge tck or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			in_shift_tms_reg <= 1'b0;
			in_shift_tdo_reg <= 1'b0;
		end
		else begin
			in_shift_tms_reg <= in_shift_tms_nx;
			in_shift_tdo_reg <= in_shift_tdo_nx;
		end
	end
	
	always @(posedge tck or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			tms_reg <= 1'b0;
		end
		else if (in_shift_tms) begin
			tms_reg <= tms;
		end
	end
	
	always @(negedge tck or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			tms_out_en_reg <= 1'b0;
		end
		else begin
			tms_out_en_reg <= in_shift_tdo_reg;
		end
	end
	assign  tdo_out_en = 1'b0;
end
else begin: gen_jtag_fivewire_control
	reg	tdo_out_en_reg;

	assign	tdi_i           = tdi; 
	assign	tms_i           = tms;
	assign	in_shift_tdi    = in_shift_st;
	assign	in_shift_tms_d1 = 1'b1;
	assign  tms_out_en      = 1'b0;
	assign	tdo_out_en      = tdo_out_en_reg;

	always @(negedge tck or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			tdo_out_en_reg <= 1'b0;
		end
		else if (in_shift_st) begin
			tdo_out_en_reg <= 1'b1;
		end
		else begin
			tdo_out_en_reg <= 1'b0;
		end
	end
end
endgenerate


assign dtm_dmi_resetn_nx = ~dtmcs_dmihardreset;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		dtm_dmi_resetn <= 1'b0;
	end
	else begin
		dtm_dmi_resetn <= dtm_dmi_resetn_nx;
	end
end

// ----------------
// trst control FSM
// ----------------
assign	rst_tap_nx = (tap_ctr_ns == TEST_LOGIC_RESET);
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		rst_tap <= 1'b0;
	end
	else begin
		rst_tap <= rst_tap_nx;
	end
end

// ----------------
// tap control FSM
// ----------------
wire	tap_ctr_cs_en;

assign	tap_ctr_cs_en = ~in_shift_st | in_shift_tms_d1;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		tap_ctr_cs <= TEST_LOGIC_RESET;
	end
	else if (tap_ctr_cs_en) begin
		tap_ctr_cs <= tap_ctr_ns;
	end
end

always @(tap_ctr_cs or tms_i) begin
	case (tap_ctr_cs)
		//TEST_LOGIC_RESET: begin => merge as default state
		RUN_TEST_IDLE: begin
			if (tms_i)
				tap_ctr_ns = SELECT_DR_SCAN;
			else
				tap_ctr_ns = RUN_TEST_IDLE;
		end
		
		// DR states
		SELECT_DR_SCAN: begin
			if (tms_i)
				tap_ctr_ns = SELECT_IR_SCAN;
			else
				tap_ctr_ns = CAPTURE_DR;
		end
		CAPTURE_DR: begin
			if (tms_i) 
				tap_ctr_ns = EXIT1_DR;
			else
				tap_ctr_ns = SHIFT_DR;
		end
		SHIFT_DR: begin
			if (tms_i)
				tap_ctr_ns = EXIT1_DR;
			else
				tap_ctr_ns = SHIFT_DR;
		end
		EXIT1_DR: begin
			if (tms_i)
				tap_ctr_ns = UPDATE_DR;
			else
				tap_ctr_ns = PAUSE_DR;
		end
		PAUSE_DR: begin
			if (tms_i)
				tap_ctr_ns = EXIT2_DR;
			else
				tap_ctr_ns = PAUSE_DR;
		end
		EXIT2_DR: begin
			if (tms_i)
				tap_ctr_ns = UPDATE_DR;
			else
				tap_ctr_ns = SHIFT_DR;
		end
		UPDATE_DR: begin
			if (tms_i)
				tap_ctr_ns = SELECT_DR_SCAN;
			else
				tap_ctr_ns = RUN_TEST_IDLE;
		end
		
		// IR states 
		SELECT_IR_SCAN: begin
			if (tms_i)
				tap_ctr_ns = TEST_LOGIC_RESET;
			else
				tap_ctr_ns = CAPTURE_IR;
		end
		CAPTURE_IR: begin
			if (tms_i) 
				tap_ctr_ns = EXIT1_IR;
			else
				tap_ctr_ns = SHIFT_IR;
		end
		SHIFT_IR: begin
			if (tms_i)
				tap_ctr_ns = EXIT1_IR;
			else
				tap_ctr_ns = SHIFT_IR;
		end
		EXIT1_IR: begin
			if (tms_i)
				tap_ctr_ns = UPDATE_IR;
			else
				tap_ctr_ns = PAUSE_IR;
		end
		PAUSE_IR: begin
			if (tms_i)
				tap_ctr_ns = EXIT2_IR;
			else
				tap_ctr_ns = PAUSE_IR;
		end
		EXIT2_IR: begin
			if (tms_i)
				tap_ctr_ns = UPDATE_IR;
			else
				tap_ctr_ns = SHIFT_IR;
		end
		UPDATE_IR: begin
			if (tms_i)
				tap_ctr_ns = SELECT_DR_SCAN;
			else
				tap_ctr_ns = RUN_TEST_IDLE;
		end
`ifdef WITH_COV
// pragma coverage off
`endif // WITH_COV
		default: begin
			if (tms_i)
				tap_ctr_ns = TEST_LOGIC_RESET;
			else 
				tap_ctr_ns = RUN_TEST_IDLE;
		end
`ifdef WITH_COV
// pragma coverage on
`endif // WITH_COV
	endcase
end

// jtag state decode
assign	in_shift_ir_st   = (tap_ctr_cs == SHIFT_IR);
assign	in_capture_ir_st = (tap_ctr_cs == CAPTURE_IR);
assign	in_update_ir_st  = (tap_ctr_cs == UPDATE_IR);
assign	in_shift_dr_st   = (tap_ctr_cs == SHIFT_DR);
assign	in_capture_dr_st = (tap_ctr_cs == CAPTURE_DR);
assign	in_update_dr_st  = (tap_ctr_cs == UPDATE_DR);
assign	in_shift_st = in_shift_ir_st | in_shift_dr_st;

// jtag inst decode
assign	is_bypass      = ~is_idcode & ~is_dtm_ctrl_st & ~is_dmi_access;
assign	is_idcode      = (tap_ir == IDCODE);
assign	is_dtm_ctrl_st = (tap_ir == DTM_CTRL_ST);
assign	is_dmi_access  = (tap_ir == DMI_ACCESS);


// --------------------
// DMI BUSY status masker after dmihardreset
// --------------------
reg	busy_mask;
wire	busy_mask_set;
wire	busy_mask_clr;

assign	busy_mask_set = dtmcs_dmihardreset & (tap_dmi_req | dmi_tap_ack);
assign	busy_mask_clr = tap_dmi_req & ~dmi_tap_ack;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		busy_mask <= 1'b0;
	end
	else if (busy_mask_set) begin
		busy_mask <= 1'b1;
	end
	else if (busy_mask_clr) begin
		busy_mask <= 1'b0;
	end

end

// --------------------
// tap data scan chain
// --------------------
wire			    data_scan_update_en;
wire	[DMI_REG_BITS-1:0]  tap_rdata;
wire			    tap_data_scan_en;
wire			    is_dmi_read;
wire			    is_dmi_write;
wire			    is_busy;
wire			    dmi_access_done;

assign	dmi_access_done	    = ~(tap_dmi_req | (dmi_tap_ack & ~busy_mask));
assign	is_dmi_read	    = dmi_access_done & is_dmi_access & (dmi[1:0] == DMI_OP_READ) & ~dmi_busy_state;
assign	is_dmi_write	    = dmi_access_done & is_dmi_access & (dmi[1:0] == DMI_OP_WRITE) & ~dmi_busy_state;
assign	is_busy		    = (~dmi_access_done | dmi_busy_state) & is_dmi_access;

assign	tap_rdata           = in_capture_ir_st ? {{(DMI_REG_BITS-IR_BITS){1'b0}}, tap_ir} : 
			      ({{(DMI_REG_BITS-32){1'b0}}, ({32{is_idcode}} & JTAG_IDCODE)} |
			      {{(DMI_REG_BITS-32){1'b0}}, ({32{is_dtm_ctrl_st}} & dtmcs)} |
			      ({dmi[DMI_REG_BITS-1:2], 2'd0} & {DMI_REG_BITS{is_dmi_write}}) |			// dmi write is successful
			      ({dmi[DMI_REG_BITS-1:34], dmi_tap_hrdata, 2'd0} & {DMI_REG_BITS{is_dmi_read}}) |	// dmi hrdata return
			      ({dmi[DMI_REG_BITS-1:34], 32'd0, 2'd3} & {DMI_REG_BITS{is_busy}}));		// dmi access is in busy state
assign	data_scan_update_en = (in_capture_dr_st & (is_idcode | is_dtm_ctrl_st | is_dmi_access)) | 
			      (in_capture_ir_st);
assign	tap_data_scan_chain = in_shift_ir_st ? {{(DMI_REG_BITS-IR_BITS){1'b0}}, tdi_i, tap_data_scan[IR_BITS-1:1]} :
			      is_dmi_access  ? {tdi_i, tap_data_scan[DMI_REG_BITS-1:1]} : {{(DMI_REG_BITS-32){1'b0}}, tdi_i, tap_data_scan[31:1]};
assign 	tap_data_scan_nx    = data_scan_update_en ? tap_rdata : tap_data_scan_chain;
assign	tap_data_scan_en    = in_shift_tdi | in_capture_dr_st | in_capture_ir_st;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		tap_data_scan <= {(DMI_REG_BITS){1'b0}};
	end
	else if (rst_tap) begin
		tap_data_scan <= {(DMI_REG_BITS){1'b0}};
	end
	else if (tap_data_scan_en) begin
		tap_data_scan <= tap_data_scan_nx;
	end
end

// ------------------
// Tap IR register
// ------------------
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		tap_ir <= IDCODE;
	end
	else if (rst_tap) begin
		tap_ir <= IDCODE;
	end
	else if (in_update_ir_st) begin
		tap_ir <= tap_data_scan[IR_BITS-1:0];
	end
end

// --------------------
// DTM control and status
// --------------------
wire	dtmcs_dmistat_clr;
wire	dtmcs_dmistat_set;

assign	dtmcs_dmihardreset = is_dtm_ctrl_st & in_update_dr_st & tap_data_scan[17];
assign	dtmcs_dmireset     = is_dtm_ctrl_st & in_update_dr_st & tap_data_scan[16];
assign	dtmcs_idle	   = DTMCS_IDLE_CYCLES; // Wait cycles
assign	dtmcs_abits	   = DMI_ADDR_BITS[5:0];
assign	dtmcs_version	   = 4'd1; 	 // Debug spec version: 0.13

assign	dtmcs_dmistat_set  = in_capture_dr_st & is_dmi_access & ~dmi_access_done;
assign	dtmcs_dmistat_clr  = dtmcs_dmireset | rst_tap | dtmcs_dmihardreset;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		dtmcs_dmistat <= 2'd0;
	end
	else if (dtmcs_dmistat_clr) begin
		dtmcs_dmistat <= 2'd0;
	end
	else if (dtmcs_dmistat_set) begin
		dtmcs_dmistat <= 2'd3;
	end

end

// Write 1 to reset: 		     dmihardreset  dmireset
assign	dtmcs   	   = {14'b0,         1'b0,     1'b0, 1'b0, dtmcs_idle, dtmcs_dmistat, dtmcs_abits, dtmcs_version};

// --------------------
// DMI bus request
// --------------------
wire	tap_dmi_req_set;
wire	tap_dmi_req_clr;
wire	dmi_rw;

assign	dmi_busy_state  = (dtmcs_dmistat == 2'd3);
assign	dmi_rw 	        = ^tap_data_scan[1:0];
assign	tap_dmi_req_set = in_update_dr_st & is_dmi_access & dmi_rw & ~dmi_busy_state;
assign	tap_dmi_req_clr = (dmi_tap_ack & ~busy_mask) | rst_tap | dtmcs_dmihardreset;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		tap_dmi_req <= 1'b0;
	end
	else if (tap_dmi_req_clr) begin
		tap_dmi_req <= 1'b0;
	end
	else if (tap_dmi_req_set) begin
		tap_dmi_req <= 1'b1;
	end

end

// --------------------
// DMI register
// --------------------
wire	dmi_update_en;

assign	dmi_update_en  = in_update_dr_st & is_dmi_access & ~dmi_busy_state;
assign	tap_dmi_data   = dmi;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		dmi <= {(DMI_REG_BITS){1'b0}};
	end
	else if (rst_tap) begin
		dmi <= {(DMI_REG_BITS){1'b0}};
	end
	else if (dmi_update_en) begin
		dmi <= tap_data_scan;
	end
end

// --------------------
// TDO
// --------------------
wire	bypass_clr;

assign	tdo_nx     = (in_shift_dr_st & (is_bypass ? bypass : tap_data_scan[0])) |
		     (in_shift_ir_st & tap_data_scan[0]);
assign	bypass_clr = in_capture_dr_st | rst_tap;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		bypass <= 1'b0;
	end
	else if (bypass_clr) begin
		bypass <= 1'b0;
	end
	else if (in_shift_dr_st & in_shift_tdi) begin
		bypass <= tdi_i;
	end
end

always @(negedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		tdo <= 1'b0;
	end
	else if (rst_tap) begin
		tdo <= 1'b0;
	end
	else if (in_shift_tdi)begin
		tdo <= tdo_nx;
	end
end

// --------------------
// Debug wake up 
// --------------------
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		dbg_wakeup_req <= 1'b0;
	end
	else begin
		dbg_wakeup_req <= dbg_wakeup_req_nx;
	end
end

assign dbg_wakeup_req_nx = dbg_wakeup_req | (tap_ctr_cs != TEST_LOGIC_RESET);

endmodule
