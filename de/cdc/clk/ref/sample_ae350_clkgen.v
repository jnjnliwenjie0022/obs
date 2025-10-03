
`include "config.inc"
`include "sample_ae350_smu_const.vh"

`ifdef NDS_FPGA
	`define USE_CLK_RATIO_LOGIC
`else
	`ifndef SYNTHESIS
		`define USE_CLK_RATIO_LOGIC
	`endif
`endif

module sample_ae350_clkgen (
	//VPERL: &PORTLIST
	// VPERL_GENERATED_BEGIN
		  root_clk,
		  test_mode,
		  test_clk,
	`ifdef NDS_FPGA
	`else
		  scan_test,
		  scan_enable,
	`endif // NDS_FPGA
		  system_clock_ratio,    // was 	[3:0]			clock_ratio_reg 
		  pcs0_frq_scale_req,
		  pcs0_frq_scale,
		  pcs0_frq_clkon,        // reserved for PLS
		  pcs0_frq_scale_ack,
		  pcs1_frq_scale_req,
		  pcs1_frq_scale,
		  pcs1_frq_clkon,        // reserved for PLS
		  pcs1_frq_scale_ack,
		  pcs2_frq_scale_req,
		  pcs2_frq_scale,
		  pcs2_frq_clkon,        // reserved for PLS
		  pcs2_frq_scale_ack,
		  pcs3_frq_scale_req,
		  pcs3_frq_scale,
		  pcs3_frq_clkon,        // reserved for PLS
		  pcs3_frq_scale_ack,
		  pcs4_frq_scale_req,
		  pcs4_frq_scale,
		  pcs4_frq_clkon,        // reserved for PLS
		  pcs4_frq_scale_ack,
		  pcs5_frq_scale_req,
		  pcs5_frq_scale,
		  pcs5_frq_clkon,        // reserved for PLS
		  pcs5_frq_scale_ack,
		  pcs6_frq_scale_req,
		  pcs6_frq_scale,
		  pcs6_frq_clkon,        // reserved for PLS
		  pcs6_frq_scale_ack,
		  pcs7_frq_scale_req,
		  pcs7_frq_scale,
		  pcs7_frq_clkon,        // reserved for PLS
		  pcs7_frq_scale_ack,
		  pcs8_frq_scale_req,
		  pcs8_frq_scale,
		  pcs8_frq_clkon,        // reserved for PLS
		  pcs8_frq_scale_ack,
		  pcs9_frq_scale_req,
		  pcs9_frq_scale,
		  pcs9_frq_clkon,        // reserved for PLS
		  pcs9_frq_scale_ack,
		  pcs10_frq_scale_req,
		  pcs10_frq_scale,
		  pcs10_frq_clkon,       // reserved for PLS
		  pcs10_frq_scale_ack,
		  T_tck,
		  T_oscl,
		  aopd_dbg_tck,
		  aopd_clk_32k,
		  aopd_pclk,             // SMU clk
		  dm_clk,                // to PLDM/ncejdtm200 clk/dmi_hclk (were aclk=core_clk)
	`ifdef PLATFORM_TRACE_SUBSYSTEM
		  ts_clk,                // timestamp clock
	`endif // PLATFORM_TRACE_SUBSYSTEM
		  core_clk,
		  l2_clk,
		  dc_clk,
		  lm_clk,
		  biu_clk,
	`ifdef NDS_FUSA_SUPPORT
	   `ifdef NDS_IO_DCLS
		  dcls_p_clk,
		  dcls_r_clk,
		  dcls_core1_clk,
		  dcls_core1_lm_clk,
		  dcls_r_reset_n,
	   `endif // NDS_IO_DCLS
	   `ifdef NDS_IO_DCACHE0
		  dcache0_p_clk,
		  dcache0_r_clk,
	      `ifdef NDS_IO_DCLS_SPLIT
		  dcache1_p_clk,
		  dcache1_r_clk,
	      `endif // NDS_IO_DCLS_SPLIT
	   `endif // NDS_IO_DCACHE0
	   `ifdef NDS_IO_ICACHE0
		  icache0_p_clk,
		  icache0_r_clk,
	      `ifdef NDS_IO_DCLS_SPLIT
		  icache1_p_clk,
		  icache1_r_clk,
	      `endif // NDS_IO_DCLS_SPLIT
	   `endif // NDS_IO_ICACHE0
	`endif // NDS_FUSA_SUPPORT
		  vpu_clk_en,
		  vpu_clk,
		  vpu_vlsu_clk_en,
		  vpu_vlsu_clk,
		  vpu_valu_clk_en,
		  vpu_valu_clk,
		  vpu_vfmis_clk_en,
		  vpu_vfmis_clk,
		  vpu_vmac_clk_en,
		  vpu_vmac_clk,
		  vpu_vfdiv_clk_en,
		  vpu_vfdiv_clk,
		  vpu_vdiv_clk_en,
		  vpu_vdiv_clk,
		  vpu_vmask_clk_en,
		  vpu_vmask_clk,
		  vpu_vpermut_clk_en,
		  vpu_vpermut_clk,
		  vpu_vace_clk_en,
		  vpu_vace_clk,
		  vpu_vsp_clk_en,
		  vpu_vsp_clk,
		  te_clk,
		  hvm_clk,
		  clk_32k,
		  T_osch,
		  main_rstn,
		  main_rstn_csync,
		  aopd_por_dbg_rstn,
		  hresetn,
	`ifdef AE350_LCDC_SUPPORT
		  lcd_clk,
		  lcd_clkn,
	`endif // AE350_LCDC_SUPPORT
	`ifdef AE350_SSP_SUPPORT
		  sspclk,
	`endif // AE350_SSP_SUPPORT
		  aclk,
		  hclk,
		  pclk,
		  uart_clk,
		  spi_clk,
		  sdc_clk,
	`ifdef NDS_IO_DFS
		  aresetn,
		  dfs_awaddr,
		  dfs_awvalid,
		  dfs_awready,
		  dfs_wdata,
		  dfs_wstrb,
		  dfs_wvalid,
		  dfs_wready,
		  dfs_bresp,
		  dfs_bvalid,
		  dfs_bready,
		  dfs_araddr,
		  dfs_arvalid,
		  dfs_arready,
		  dfs_rdata,
		  dfs_rresp,
		  dfs_rvalid,
		  dfs_rready,
	`endif // NDS_IO_DFS
		  pclk_uart1,
		  pclk_uart2,
		  pclk_spi1,
		  pclk_spi2,
		  pclk_gpio,
		  pclk_pit,
		  pclk_i2c,
		  pclk_wdt,
		  apb2ahb_clken,
		  ahb2core_clken,
		  axi2core_clken,
		  apb2core_clken
	// VPERL_GENERATED_END
);

`ifdef NDS_NHART
	localparam NHART = `NDS_NHART;
`else 
	localparam NHART = 1;
`endif

localparam SYNC_STAGE = `NDS_SYNC_STAGE;

output		root_clk;
input		test_mode;
input		test_clk;
`ifdef NDS_FPGA
`else // NDS_FPGA
input		scan_test;
input		scan_enable;
`endif // NDS_FPGA

//===============
// SMU interface
//===============
// pclk domain signal
input	[3:0]	system_clock_ratio;		// was 	[3:0]			clock_ratio_reg 
input		pcs0_frq_scale_req;
input	[2:0]	pcs0_frq_scale;
input	[31:0]	pcs0_frq_clkon;	 // reserved for PLS
output		pcs0_frq_scale_ack;
input		pcs1_frq_scale_req;
input	[2:0]	pcs1_frq_scale;
input	[31:0]	pcs1_frq_clkon;	 // reserved for PLS
output		pcs1_frq_scale_ack;
input		pcs2_frq_scale_req;
input	[2:0]	pcs2_frq_scale;
input	[31:0]	pcs2_frq_clkon;	 // reserved for PLS
output		pcs2_frq_scale_ack;
input		pcs3_frq_scale_req;
input	[2:0]	pcs3_frq_scale;
input	[31:0]	pcs3_frq_clkon;	 // reserved for PLS
output		pcs3_frq_scale_ack;
input		pcs4_frq_scale_req;
input	[2:0]	pcs4_frq_scale;
input	[31:0]	pcs4_frq_clkon;	 // reserved for PLS
output		pcs4_frq_scale_ack;
input		pcs5_frq_scale_req;
input	[2:0]	pcs5_frq_scale;
input	[31:0]	pcs5_frq_clkon;	 // reserved for PLS
output		pcs5_frq_scale_ack;
input		pcs6_frq_scale_req;
input	[2:0]	pcs6_frq_scale;
input	[31:0]	pcs6_frq_clkon;	 // reserved for PLS
output		pcs6_frq_scale_ack;
input		pcs7_frq_scale_req;
input	[2:0]	pcs7_frq_scale;
input	[31:0]	pcs7_frq_clkon;	 // reserved for PLS
output		pcs7_frq_scale_ack;
input		pcs8_frq_scale_req;
input	[2:0]	pcs8_frq_scale;
input	[31:0]	pcs8_frq_clkon;	 // reserved for PLS
output		pcs8_frq_scale_ack;
input		pcs9_frq_scale_req;
input	[2:0]	pcs9_frq_scale;
input	[31:0]	pcs9_frq_clkon;	 // reserved for PLS
output		pcs9_frq_scale_ack;
input		pcs10_frq_scale_req;
input	[2:0]	pcs10_frq_scale;
input	[31:0]	pcs10_frq_clkon;	 // reserved for PLS
output		pcs10_frq_scale_ack;

//===============
//PCS0: SMU/RTC/ncejdtm200.ncejdtm200_tap
//===============
input		T_tck;
input		T_oscl;
output		aopd_dbg_tck;
output		aopd_clk_32k;
output		aopd_pclk;	// SMU clk

//===============
//PCS1: (PLDM/ncejdtm200)
//===============
output		dm_clk;		// to PLDM/ncejdtm200 clk/dmi_hclk (were aclk=core_clk)
`ifdef PLATFORM_TRACE_SUBSYSTEM
output          ts_clk;         // timestamp clock
`endif

//===============
//PCS3~6: COREs
//===============
output	[(NHART-1):0]	core_clk;
output			l2_clk;
output	[(NHART-1):0]	dc_clk;
output	[(NHART-1):0]	lm_clk;
output                  biu_clk;
`ifdef NDS_FUSA_SUPPORT
   `ifdef NDS_IO_DCLS
output			dcls_p_clk;
output			dcls_r_clk;
output			dcls_core1_clk;
output			dcls_core1_lm_clk;
input			dcls_r_reset_n;
   `endif // NDS_IO_DCLS
   `ifdef NDS_IO_DCACHE0
output                                      dcache0_p_clk;
output                                      dcache0_r_clk;
   `ifdef NDS_IO_DCLS_SPLIT
output                                      dcache1_p_clk;
output                                      dcache1_r_clk;
   `endif // NDS_IO_DCLS_SPLIT
   `endif // NDS_IO_DCACHE0

   `ifdef NDS_IO_ICACHE0
output                                      icache0_p_clk;
output                                      icache0_r_clk;
   `ifdef NDS_IO_DCLS_SPLIT
output                                      icache1_p_clk;
output                                      icache1_r_clk;
   `endif // NDS_IO_DCLS_SPLIT
   `endif // NDS_IO_ICACHE0

`endif // NDS_FUSA_SUPPORT
input   [(NHART-1):0]   vpu_clk_en;
output  [(NHART-1):0]   vpu_clk;
input   [(NHART-1):0]   vpu_vlsu_clk_en;
output  [(NHART-1):0]   vpu_vlsu_clk;
input   [(NHART-1):0]   vpu_valu_clk_en;
output  [(NHART-1):0]   vpu_valu_clk;
input   [(NHART-1):0]   vpu_vfmis_clk_en;
output  [(NHART-1):0]   vpu_vfmis_clk;
input   [(NHART-1):0]   vpu_vmac_clk_en;
output  [(NHART-1):0]   vpu_vmac_clk;
input   [(NHART-1):0]   vpu_vfdiv_clk_en;
output  [(NHART-1):0]   vpu_vfdiv_clk;
input   [(NHART-1):0]   vpu_vdiv_clk_en;
output  [(NHART-1):0]   vpu_vdiv_clk;
input   [(NHART-1):0]   vpu_vmask_clk_en;
output  [(NHART-1):0]   vpu_vmask_clk;
input   [(NHART-1):0]   vpu_vpermut_clk_en;
output  [(NHART-1):0]   vpu_vpermut_clk;
input   [(NHART-1):0]   vpu_vace_clk_en;
output  [(NHART-1):0]   vpu_vace_clk;
input   [(NHART-1):0]   vpu_vsp_clk_en;
output  [(NHART-1):0]   vpu_vsp_clk;
output	[(NHART-1):0]   te_clk;
output                  hvm_clk;

//===============
//PCS2: other IPs (original MPD)
//===============
output		clk_32k;
input		T_osch;
input		main_rstn;
input		main_rstn_csync;
input		aopd_por_dbg_rstn;
input		hresetn;
`ifdef AE350_LCDC_SUPPORT
output		lcd_clk;
output		lcd_clkn;
`endif
`ifdef AE350_SSP_SUPPORT
output		sspclk;
`endif

output		aclk;
output		hclk;
output		pclk;
output		uart_clk;
output		spi_clk;
output		sdc_clk;

`ifdef NDS_IO_DFS
input		aresetn;
input	[10:0]	dfs_awaddr;
input		dfs_awvalid;
output		dfs_awready;
input	[31:0]	dfs_wdata;
input	[3:0]	dfs_wstrb;
input		dfs_wvalid;
output		dfs_wready;
output	[1:0]	dfs_bresp;
output		dfs_bvalid;
input		dfs_bready;
input	[10:0]	dfs_araddr;
input		dfs_arvalid;
output		dfs_arready;
output	[31:0]	dfs_rdata;
output	[1:0]	dfs_rresp;
output		dfs_rvalid;
input		dfs_rready;
`endif // !NDS_IO_DFS
output		pclk_uart1;
output		pclk_uart2;
output		pclk_spi1;
output		pclk_spi2;
output		pclk_gpio;
output		pclk_pit;
output		pclk_i2c;
output		pclk_wdt;
output		apb2ahb_clken;
output		ahb2core_clken;
output		axi2core_clken;
output		apb2core_clken;

wire    [7:0]   clk_en_aclk_sync_dfs;
`ifdef NDS_IO_DFS
wire	[7:0]	dfs_clk;
wire            dfs_locked;
`else
        assign  clk_en_aclk_sync_dfs = {8{1'b1}};
`endif // NDS_IO_DFS

wire [7:0]	root_dfs_clk;

// The SYNTHESIS macro should be implicitly defind by the synthesis tool (DC,
// RC & Synplify) according to Section 6.2 of the IEEE Std 1364.1-2002 LRM.
`ifdef SYNTHESIS
//*** ASIC/FPGA synthesis ***
//wire   root_clk_dly = root_clk;
//wire   main_rstn_csync_dly = main_rstn_csync;
`elsif NDS_FPGA
//*** FPGA RTL simulations ***
//wire   root_clk_dly = root_clk;
//wire   main_rstn_csync_dly = main_rstn_csync;
`else
//*** ASIC RTL simulations ***
// Balance clock skews against BUS clock in simulation to avoid event-ordering problems.
//
//  order-1      order-2                       order-3
// root_clk => root_clk_dly  = core_clk     => core_clk_cnt, ahb2core_clken, apb2core_clken
//          => hclk_div      = hclk         => hclk_cnt, apb2ahb_clken
//          => pclk_div      = pclk
//          => root_clk_cnt                 => root_clk_cnt_dly
//          => uart_clk
//          => main_rstn_csync              => main_rstn_csync_dly
//                                          => clock_unstable
//                                          => ratio_sync
//
// expressions with event-ordering problem:
// order-2-signal <= order-1-signal
// order-3-signal <= order-1-signal
// order-3-signal <= order-2-signal
//
// NOTE: the following expression is okay, because core_clk is gated when smu_core_clk_2_hclk_ratio_sync is changing
//assign ahb2core_clken =  (smu_core_clk_2_hclk_ratio_sync == 2'd0)
//                      | ((smu_core_clk_2_hclk_ratio_sync == 2'd1) & core_clk_cnt[0]);
reg    root_clk_dly;
reg    main_rstn_csync_dly;
always @(root_clk) begin
       root_clk_dly <= root_clk;
end
    `ifdef NDS_IO_DFS
reg[7:0] dfs_clk_dly;
    always @(dfs_clk) begin
           dfs_clk_dly <= dfs_clk;
    end
    `endif //NDS_IO_DFS
always @(main_rstn_csync) begin
	main_rstn_csync_dly <= main_rstn_csync;
end
`endif

//===============
// global control
//===============
localparam CLKR_DEFAULT = `SAMPLE_AE350_SMU_CLKR_DEFAULT;
wire            clock_unstable;
wire		pclk_mux_test;

reg		reg_sysclk_sel;
always @(posedge root_clk or negedge main_rstn_csync) 
begin
	if (!main_rstn_csync) begin
		reg_sysclk_sel <= CLKR_DEFAULT[0];
	end
	else begin
		reg_sysclk_sel <= system_clock_ratio[0];
	end
end
wire	smu_core_clk_sel = reg_sysclk_sel;


`ifdef USE_CLK_RATIO_LOGIC
reg	[2:0]	reg_bus_ratio;

always @(posedge root_clk or negedge main_rstn_csync) 
begin
	if (!main_rstn_csync) begin
		reg_bus_ratio <= CLKR_DEFAULT[3:1];
	end
	else begin
		reg_bus_ratio <= system_clock_ratio[3:1];
	end
end
	
reg	[1:0]	smu_core_clk_2_hclk_ratio;
reg	[1:0]	smu_hclk_2_pclk_ratio;
always @* begin
	case(reg_bus_ratio)		// was [3:1]clock_ratio_reg
		3'b000: smu_core_clk_2_hclk_ratio = 2'b00;
		3'b001: smu_core_clk_2_hclk_ratio = 2'b00;
		3'b010: smu_core_clk_2_hclk_ratio = 2'b00;
		3'b011: smu_core_clk_2_hclk_ratio = 2'b01;
		3'b100: smu_core_clk_2_hclk_ratio = 2'b01;
		default: smu_core_clk_2_hclk_ratio = 2'b00;
	endcase
end
always @* begin
	case(reg_bus_ratio)
		3'b000: smu_hclk_2_pclk_ratio = 2'b00;
		3'b001: smu_hclk_2_pclk_ratio = 2'b01;
		3'b010: smu_hclk_2_pclk_ratio = 2'b10;
		3'b011: smu_hclk_2_pclk_ratio = 2'b00;
		3'b100: smu_hclk_2_pclk_ratio = 2'b01;
		default: smu_hclk_2_pclk_ratio = 2'b00;
	endcase
end
`endif

`ifdef NDS_FPGA 
	assign clock_unstable = 1'b0;
`else
	`ifdef SYNTHESIS
		assign clock_unstable = 1'b0;
	`endif
`endif	// !NDS_FPGA

wire	[(NHART-1):0] core_clk;
wire	[(NHART-1):0] dc_clk;
wire	[(NHART-1):0] lm_clk;

wire	[(NHART-1):0] te_clk;

assign	pcs0_frq_scale_ack = 1'b0;

wire [7:0] pd_clock_unstable;
genvar i;
`ifdef NDS_IO_DFS
wire locked_n = dfs_locked & (~clock_unstable);
reg [(NHART-1):0] dfs_clock_unstable_d1;
reg [(NHART-1):0] dfs_clock_unstable_d2;
generate
for (i = 0; i < NHART; i = i + 1) begin: gen_dfs_unstable_sync
    wire root_dfs_clk_tmp =  root_dfs_clk[i];
    always @(posedge root_dfs_clk_tmp or negedge locked_n) begin
        if (!locked_n) begin
            dfs_clock_unstable_d1[i] <= 1'b1 ; 
            dfs_clock_unstable_d2[i] <= 1'b1 ; 
        end
        else begin
            dfs_clock_unstable_d1[i] <= 1'b0 ; 
            dfs_clock_unstable_d2[i] <= dfs_clock_unstable_d1[i] ; 
        end
    end 
end
endgenerate
generate
for (i = 0; i < 8; i = i + 1) begin: dfs_connect_clock_unstable
    if (i<NHART) begin: gen_pd_clock_unstable
        assign pd_clock_unstable[i] = dfs_clock_unstable_d2[i];
    end else begin: gen_no_pd_clock_unstable
        assign pd_clock_unstable[i] = 1'b0;
    end
end
endgenerate
`else // !NDS_IO_DFS
    assign pd_clock_unstable = {8{clock_unstable}};
`endif //NDS_IO_DFS

wire	[10:1]	pcs_clk_en;
pd_clk_ctrl pd1_clk_ctrl(.clk_en(pcs_clk_en[1]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		 	.frq_scale_ack(pcs1_frq_scale_ack), .frq_scale_req(pcs1_frq_scale_req), .frq_scale(pcs1_frq_scale));
pd_clk_ctrl pd2_clk_ctrl(.clk_en(pcs_clk_en[2]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		 	.frq_scale_ack(pcs2_frq_scale_ack), .frq_scale_req(pcs2_frq_scale_req), .frq_scale(pcs2_frq_scale));
pd_clk_ctrl pd3_clk_ctrl(.clk_en(pcs_clk_en[3]), .clk(root_dfs_clk[0]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[0]),
		 	.frq_scale_ack(pcs3_frq_scale_ack), .frq_scale_req(pcs3_frq_scale_req), .frq_scale(pcs3_frq_scale));
pd_clk_ctrl pd4_clk_ctrl(.clk_en(pcs_clk_en[4]), .clk(root_dfs_clk[1]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[1]),
		 	.frq_scale_ack(pcs4_frq_scale_ack), .frq_scale_req(pcs4_frq_scale_req), .frq_scale(pcs4_frq_scale));
pd_clk_ctrl pd5_clk_ctrl(.clk_en(pcs_clk_en[5]), .clk(root_dfs_clk[2]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[2]),
		 	.frq_scale_ack(pcs5_frq_scale_ack), .frq_scale_req(pcs5_frq_scale_req), .frq_scale(pcs5_frq_scale));
pd_clk_ctrl pd6_clk_ctrl(.clk_en(pcs_clk_en[6]), .clk(root_dfs_clk[3]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[3]),
		 	.frq_scale_ack(pcs6_frq_scale_ack), .frq_scale_req(pcs6_frq_scale_req), .frq_scale(pcs6_frq_scale));
pd_clk_ctrl pd7_clk_ctrl(.clk_en(pcs_clk_en[7]), .clk(root_dfs_clk[4]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[4]),
		 	.frq_scale_ack(pcs7_frq_scale_ack), .frq_scale_req(pcs7_frq_scale_req), .frq_scale(pcs7_frq_scale));
pd_clk_ctrl pd8_clk_ctrl(.clk_en(pcs_clk_en[8]), .clk(root_dfs_clk[5]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[5]),
		 	.frq_scale_ack(pcs8_frq_scale_ack), .frq_scale_req(pcs8_frq_scale_req), .frq_scale(pcs8_frq_scale));
pd_clk_ctrl pd9_clk_ctrl(.clk_en(pcs_clk_en[9]), .clk(root_dfs_clk[6]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[6]),
		 	.frq_scale_ack(pcs9_frq_scale_ack), .frq_scale_req(pcs9_frq_scale_req), .frq_scale(pcs9_frq_scale));
pd_clk_ctrl pd10_clk_ctrl(.clk_en(pcs_clk_en[10]), .clk(root_dfs_clk[7]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[7]),
		 	.frq_scale_ack(pcs10_frq_scale_ack),.frq_scale_req(pcs10_frq_scale_req),.frq_scale(pcs10_frq_scale));

wire	[7:0]	core_clkon;
wire	[7:0]	nds_unused_core_clkon_ack;	// no use
pd_clk_ctrl core0_clkon(.clk_en(core_clkon[0]), .clk(root_dfs_clk[0]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[0]),
		 	.frq_scale_ack(nds_unused_core_clkon_ack[0]), .frq_scale_req(pcs3_frq_scale_req), .frq_scale({2'd0, pcs3_frq_clkon[0]}));
pd_clk_ctrl core1_clkon(.clk_en(core_clkon[1]), .clk(root_dfs_clk[1]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[1]),
		 	.frq_scale_ack(nds_unused_core_clkon_ack[1]), .frq_scale_req(pcs4_frq_scale_req), .frq_scale({2'd0, pcs4_frq_clkon[0]}));
pd_clk_ctrl core2_clkon(.clk_en(core_clkon[2]), .clk(root_dfs_clk[2]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[2]),
		 	.frq_scale_ack(nds_unused_core_clkon_ack[2]), .frq_scale_req(pcs5_frq_scale_req), .frq_scale({2'd0, pcs5_frq_clkon[0]}));
pd_clk_ctrl core3_clkon(.clk_en(core_clkon[3]), .clk(root_dfs_clk[3]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[3]),
		 	.frq_scale_ack(nds_unused_core_clkon_ack[3]), .frq_scale_req(pcs6_frq_scale_req), .frq_scale({2'd0, pcs6_frq_clkon[0]}));
pd_clk_ctrl core4_clkon(.clk_en(core_clkon[4]), .clk(root_dfs_clk[4]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[4]),
		 	.frq_scale_ack(nds_unused_core_clkon_ack[4]), .frq_scale_req(pcs7_frq_scale_req), .frq_scale({2'd0, pcs7_frq_clkon[0]}));
pd_clk_ctrl core5_clkon(.clk_en(core_clkon[5]), .clk(root_dfs_clk[5]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[5]),
		 	.frq_scale_ack(nds_unused_core_clkon_ack[5]), .frq_scale_req(pcs8_frq_scale_req), .frq_scale({2'd0, pcs8_frq_clkon[0]}));
pd_clk_ctrl core6_clkon(.clk_en(core_clkon[6]), .clk(root_dfs_clk[6]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[6]),
		 	.frq_scale_ack(nds_unused_core_clkon_ack[6]), .frq_scale_req(pcs9_frq_scale_req), .frq_scale({2'd0, pcs9_frq_clkon[0]}));
pd_clk_ctrl core7_clkon(.clk_en(core_clkon[7]), .clk(root_dfs_clk[7]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[7]),
		 	.frq_scale_ack(nds_unused_core_clkon_ack[7]), .frq_scale_req(pcs10_frq_scale_req),.frq_scale({2'd0, pcs10_frq_clkon[0]}));

wire	[7:0]	dc_clkon;
wire	[7:0]	nds_unused_dc_clkon_ack;	// no use
pd_clk_ctrl dc0_clkon(.clk_en(dc_clkon[0]), .clk(root_dfs_clk[0]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[0]),
		      .frq_scale_ack(nds_unused_dc_clkon_ack[0]), .frq_scale_req(pcs3_frq_scale_req), .frq_scale({2'd0, pcs3_frq_clkon[13]}));
pd_clk_ctrl dc1_clkon(.clk_en(dc_clkon[1]), .clk(root_dfs_clk[1]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[1]),
	      	      .frq_scale_ack(nds_unused_dc_clkon_ack[1]), .frq_scale_req(pcs4_frq_scale_req), .frq_scale({2'd0, pcs4_frq_clkon[13]}));
pd_clk_ctrl dc2_clkon(.clk_en(dc_clkon[2]), .clk(root_dfs_clk[2]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[2]),
	      	      .frq_scale_ack(nds_unused_dc_clkon_ack[2]), .frq_scale_req(pcs5_frq_scale_req), .frq_scale({2'd0, pcs5_frq_clkon[13]}));
pd_clk_ctrl dc3_clkon(.clk_en(dc_clkon[3]), .clk(root_dfs_clk[3]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[3]),
		      .frq_scale_ack(nds_unused_dc_clkon_ack[3]), .frq_scale_req(pcs6_frq_scale_req), .frq_scale({2'd0, pcs6_frq_clkon[13]}));
pd_clk_ctrl dc4_clkon(.clk_en(dc_clkon[4]), .clk(root_dfs_clk[4]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[4]),
		      .frq_scale_ack(nds_unused_dc_clkon_ack[4]), .frq_scale_req(pcs7_frq_scale_req), .frq_scale({2'd0, pcs7_frq_clkon[13]}));
pd_clk_ctrl dc5_clkon(.clk_en(dc_clkon[5]), .clk(root_dfs_clk[5]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[5]),
		      .frq_scale_ack(nds_unused_dc_clkon_ack[5]), .frq_scale_req(pcs8_frq_scale_req), .frq_scale({2'd0, pcs8_frq_clkon[13]}));
pd_clk_ctrl dc6_clkon(.clk_en(dc_clkon[6]), .clk(root_dfs_clk[6]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[6]),
		      .frq_scale_ack(nds_unused_dc_clkon_ack[6]), .frq_scale_req(pcs9_frq_scale_req), .frq_scale({2'd0, pcs9_frq_clkon[13]}));
pd_clk_ctrl dc7_clkon(.clk_en(dc_clkon[7]), .clk(root_dfs_clk[7]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[7]),
		      .frq_scale_ack(nds_unused_dc_clkon_ack[7]), .frq_scale_req(pcs10_frq_scale_req),.frq_scale({2'd0, pcs10_frq_clkon[13]}));

wire	[7:0]	lm_clkon;
wire	[7:0]	nds_unused_lm_clkon_ack;	// no use
pd_clk_ctrl lm0_clkon(.clk_en(lm_clkon[0]), .clk(root_dfs_clk[0]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[0]),
		      .frq_scale_ack(nds_unused_lm_clkon_ack[0]), .frq_scale_req(pcs3_frq_scale_req), .frq_scale({2'd0, pcs3_frq_clkon[12]}));
pd_clk_ctrl lm1_clkon(.clk_en(lm_clkon[1]), .clk(root_dfs_clk[1]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[1]),
	      	      .frq_scale_ack(nds_unused_lm_clkon_ack[1]), .frq_scale_req(pcs4_frq_scale_req), .frq_scale({2'd0, pcs4_frq_clkon[12]}));
pd_clk_ctrl lm2_clkon(.clk_en(lm_clkon[2]), .clk(root_dfs_clk[2]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[2]),
	      	      .frq_scale_ack(nds_unused_lm_clkon_ack[2]), .frq_scale_req(pcs5_frq_scale_req), .frq_scale({2'd0, pcs5_frq_clkon[12]}));
pd_clk_ctrl lm3_clkon(.clk_en(lm_clkon[3]), .clk(root_dfs_clk[3]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[3]),
		      .frq_scale_ack(nds_unused_lm_clkon_ack[3]), .frq_scale_req(pcs6_frq_scale_req), .frq_scale({2'd0, pcs6_frq_clkon[12]}));
pd_clk_ctrl lm4_clkon(.clk_en(lm_clkon[4]), .clk(root_dfs_clk[4]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[4]),
		      .frq_scale_ack(nds_unused_lm_clkon_ack[4]), .frq_scale_req(pcs7_frq_scale_req), .frq_scale({2'd0, pcs7_frq_clkon[12]}));
pd_clk_ctrl lm5_clkon(.clk_en(lm_clkon[5]), .clk(root_dfs_clk[5]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[5]),
		      .frq_scale_ack(nds_unused_lm_clkon_ack[5]), .frq_scale_req(pcs8_frq_scale_req), .frq_scale({2'd0, pcs8_frq_clkon[12]}));
pd_clk_ctrl lm6_clkon(.clk_en(lm_clkon[6]), .clk(root_dfs_clk[6]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[6]),
		      .frq_scale_ack(nds_unused_lm_clkon_ack[6]), .frq_scale_req(pcs9_frq_scale_req), .frq_scale({2'd0, pcs9_frq_clkon[12]}));
pd_clk_ctrl lm7_clkon(.clk_en(lm_clkon[7]), .clk(root_dfs_clk[7]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[7]),
		      .frq_scale_ack(nds_unused_lm_clkon_ack[7]), .frq_scale_req(pcs10_frq_scale_req),.frq_scale({2'd0, pcs10_frq_clkon[12]}));

wire	[7:0]	l2c_clkon;
wire	[7:0]	l2c_freq_scale;
wire	[7:0]	nds_unused_l2c_clkon_ack;	// no use

assign	l2c_freq_scale[0] = pcs3_frq_clkon[0] | pcs3_frq_clkon[12] | pcs3_frq_clkon[13];
assign	l2c_freq_scale[1] = pcs4_frq_clkon[0] | pcs4_frq_clkon[12] | pcs4_frq_clkon[13];
assign	l2c_freq_scale[2] = pcs5_frq_clkon[0] | pcs5_frq_clkon[12] | pcs5_frq_clkon[13];
assign	l2c_freq_scale[3] = pcs6_frq_clkon[0] | pcs6_frq_clkon[12] | pcs6_frq_clkon[13];
assign	l2c_freq_scale[4] = pcs7_frq_clkon[0] | pcs7_frq_clkon[12] | pcs7_frq_clkon[13];
assign	l2c_freq_scale[5] = pcs8_frq_clkon[0] | pcs8_frq_clkon[12] | pcs8_frq_clkon[13];
assign	l2c_freq_scale[6] = pcs9_frq_clkon[0] | pcs9_frq_clkon[12] | pcs9_frq_clkon[13];
assign	l2c_freq_scale[7] = pcs10_frq_clkon[0]| pcs10_frq_clkon[12]| pcs10_frq_clkon[13];

pd_clk_ctrl l2c0_clkon(.clk_en(l2c_clkon[0]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(nds_unused_l2c_clkon_ack[0]), .frq_scale_req(pcs3_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[0]}));
pd_clk_ctrl l2c1_clkon(.clk_en(l2c_clkon[1]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
	      	      .frq_scale_ack(nds_unused_l2c_clkon_ack[1]), .frq_scale_req(pcs4_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[1]}));
pd_clk_ctrl l2c2_clkon(.clk_en(l2c_clkon[2]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
	      	      .frq_scale_ack(nds_unused_l2c_clkon_ack[2]), .frq_scale_req(pcs5_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[2]}));
pd_clk_ctrl l2c3_clkon(.clk_en(l2c_clkon[3]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(nds_unused_l2c_clkon_ack[3]), .frq_scale_req(pcs6_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[3]}));
pd_clk_ctrl l2c4_clkon(.clk_en(l2c_clkon[4]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(nds_unused_l2c_clkon_ack[4]), .frq_scale_req(pcs7_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[4]}));
pd_clk_ctrl l2c5_clkon(.clk_en(l2c_clkon[5]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(nds_unused_l2c_clkon_ack[5]), .frq_scale_req(pcs8_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[5]}));
pd_clk_ctrl l2c6_clkon(.clk_en(l2c_clkon[6]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(nds_unused_l2c_clkon_ack[6]), .frq_scale_req(pcs9_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[6]}));
pd_clk_ctrl l2c7_clkon(.clk_en(l2c_clkon[7]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(nds_unused_l2c_clkon_ack[7]), .frq_scale_req(pcs10_frq_scale_req),.frq_scale({2'd0, l2c_freq_scale[7]}));

// FuSa BIU
wire	[7:0]	biu_clkon;
wire	[1:0]		biu_freq_scale;
wire	[1:0]		nds_unused_biu_clkon_ack;	// no use

assign	biu_freq_scale[0] = pcs3_frq_clkon[0] | pcs3_frq_clkon[12] | pcs3_frq_clkon[13];
assign	biu_freq_scale[1] = pcs4_frq_clkon[0] | pcs4_frq_clkon[12] | pcs4_frq_clkon[13];

pd_clk_ctrl biu0_clkon(.clk_en(biu_clkon[0]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(nds_unused_biu_clkon_ack[0]), .frq_scale_req(pcs3_frq_scale_req), .frq_scale({2'd0, biu_freq_scale[0]}));
pd_clk_ctrl biu1_clkon(.clk_en(biu_clkon[1]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
	      	      .frq_scale_ack(nds_unused_biu_clkon_ack[1]), .frq_scale_req(pcs4_frq_scale_req), .frq_scale({2'd0, biu_freq_scale[1]}));
assign biu_clkon[7:2] = 6'b0;

wire	[(NHART-1):0]	te_clkon = {NHART{1'b1}};

wire	aclkon;
wire	hclkon;
wire	pclkon;

wire	nds_unused_aclkon_ack;	// no use	
wire	nds_unused_hclkon_ack;	// no use
wire	nds_unused_pclkon_ack;	// no use

pd_clk_ctrl pd_aclkon(.clk_en(aclkon), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
	             .frq_scale_ack(nds_unused_aclkon_ack), .frq_scale_req(pcs2_frq_scale_req), .frq_scale({2'd0, pcs2_frq_clkon[11]}));
pd_clk_ctrl pd_hclkon(.clk_en(hclkon), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
	             .frq_scale_ack(nds_unused_hclkon_ack), .frq_scale_req(pcs2_frq_scale_req), .frq_scale({2'd0, pcs2_frq_clkon[1]}));
pd_clk_ctrl pd_pclkon(.clk_en(pclkon), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
	             .frq_scale_ack(nds_unused_pclkon_ack), .frq_scale_req(pcs2_frq_scale_req), .frq_scale({2'd0, pcs2_frq_clkon[2]}));

sample_ae350_aopd_clkgen sample_ae350_aopd_clkgen (
	.test_mode(test_mode   ), 	//  <= (ae350_aopd_testgen)
	.test_clk (test_clk    ), 	//  <= (ae350_aopd_testgen)
	.clk_32k  (aopd_clk_32k), 	//  => (sample_ae350_aopd_rstgen)
	.T_oscl   (T_oscl      ), 	//  <= (ae350_aopd_pin)
	.dbg_tck  (aopd_dbg_tck),	//  => (sample_ae350_aopd_rstgen)
	.T_tck    (T_tck       )  	//  <= (ae350_aopd_pin)
); // end of sample_ae350_aopd_clkgen

wire	smu_aclk_en = pcs_clk_en[2] & aclkon;
wire	smu_hclk_en = pcs_clk_en[2] & hclkon;
wire	smu_pclk_en = pcs_clk_en[2] & pclkon;

`ifdef NDS_FPGA
wire	smu_debug_clk_en = pcs_clk_en[1];

wire		clkfb_in;
wire		fast_clk;
wire		slow_clk;
wire		root_clk;
wire		hclk_pri;
wire		pclk_pri;

reg		osch_div2;

reg	[1:0]	root_clk_cnt;
reg		div_n_hclk;
reg	[1:0]	smu_core_clk_2_hclk_ratio_sync;
wire		hclk_div_n_select_sync;

reg		div_n_pclk;
reg	[1:0]	smu_hclk_2_pclk_ratio_sync;

wire            pclk_div_n_select_sync;

reg		ahb2core_clken;
reg		apb2ahb_clken;
reg		apb2core_clken;

reg		gen_clkmux_clk_en;

wire		clk_30m, clk_40m, clk_20m_0, clk_20m_1, spi_clk_66m, clk_60m_sdc;

wire		root_clk_dly = root_clk;
wire		main_rstn_csync_dly = main_rstn_csync;


	`ifdef AE350_CORE_CLK_66MHZ
wire            core_clk_66m;
mmcm1_66m ae350_fpga_clkgen (
	.resetn		(main_rstn		),
	.clk_in1	(T_osch			),
	.clkfb_in	(clkfb_in		),
	.clkfb_out	(clkfb_in		),
	.clk_out1	(core_clk_66m		),	// 66M
	.clk_out2	(clk_30m		),	// 30M
	.clk_out3	(clk_40m		),	// 40M
	.clk_out4	(clk_20m_0		),	// 20M
	.clk_out5	(clk_20m_1		),	// 20M
	.clk_out6	(spi_clk_66m		),	// 66M
	.clk_out7	(clk_60m_sdc		)	// 60M
);
	`else
wire		clk_60m;
mmcm1 ae350_fpga_clkgen (
	.resetn		(main_rstn		),
	.clk_in1	(T_osch			),
	.clkfb_in	(clkfb_in		),
	.clkfb_out	(clkfb_in		),
	.clk_out1	(clk_60m		),	// 60M
	.clk_out2	(clk_30m		),	// 30M
	.clk_out3	(clk_40m		),	// 40M
	.clk_out4	(clk_20m_0		),	// 20M
	.clk_out5	(clk_20m_1		),	// 20M
	.clk_out6	(spi_clk_66m		),	// 66M
	.clk_out7	(clk_60m_sdc		)	// 60M
);
	`endif

	`ifdef AE350_CORE_CLK_40MHZ
assign fast_clk		= clk_40m;
assign slow_clk		= clk_20m_0;
	`else
		`ifdef AE350_CORE_CLK_66MHZ
assign fast_clk		= core_clk_66m;
assign slow_clk		= clk_30m;
		`else	// AE350_CORE_CLK_60MHZ
assign fast_clk		= clk_60m;
assign slow_clk		= clk_30m;
		`endif
	`endif	// !AE350_CORE_CLK_40MHZ

assign uart_clk		= clk_20m_1;
assign spi_clk		= spi_clk_66m;
//assign sdc_clk		= clk_60m_sdc;
BUFGCE bufgce_sd_clk (.O(sdc_clk), .I(clk_60m_sdc), .CE(1'b1));


// Light Sleep mode: core_clk => off, dc_clk => off
//		     pcs_clk_en = 0, psc_clkon = 0
// Standby mode    : core_clk => off, dc_clk => on
//		     pcs_clk_en = 1, pcs_clkon = 1

wire gen_debug_clkmux_en = gen_clkmux_clk_en & smu_debug_clk_en;
wire gen_hclk_clkmux_en  = gen_clkmux_clk_en & smu_hclk_en;
wire gen_aclk_clkmux_en  = gen_clkmux_clk_en & smu_aclk_en;
wire gen_pclk_clkmux_en  = gen_clkmux_clk_en & smu_pclk_en;

wire gen_core0_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[3] & core_clkon[0] & clk_en_aclk_sync_dfs[0]);
wire gen_core1_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[4] & core_clkon[1] & clk_en_aclk_sync_dfs[1]);
wire gen_core2_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[5] & core_clkon[2] & clk_en_aclk_sync_dfs[2]);
wire gen_core3_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[6] & core_clkon[3] & clk_en_aclk_sync_dfs[3]);
wire gen_core4_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[7] & core_clkon[4] & clk_en_aclk_sync_dfs[4]);
wire gen_core5_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[8] & core_clkon[5] & clk_en_aclk_sync_dfs[5]);
wire gen_core6_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[9] & core_clkon[6] & clk_en_aclk_sync_dfs[6]);
wire gen_core7_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[10]& core_clkon[7] & clk_en_aclk_sync_dfs[7]);

wire	[7:0] gen_core_clkmux_en = {gen_core7_clkmux_en, gen_core6_clkmux_en, gen_core5_clkmux_en, gen_core4_clkmux_en,
                                    gen_core3_clkmux_en, gen_core2_clkmux_en, gen_core1_clkmux_en, gen_core0_clkmux_en};

wire gen_dc0_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[3] & dc_clkon[0] & clk_en_aclk_sync_dfs[0]);
wire gen_dc1_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[4] & dc_clkon[1] & clk_en_aclk_sync_dfs[1]);
wire gen_dc2_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[5] & dc_clkon[2] & clk_en_aclk_sync_dfs[2]);
wire gen_dc3_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[6] & dc_clkon[3] & clk_en_aclk_sync_dfs[3]);
wire gen_dc4_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[7] & dc_clkon[4] & clk_en_aclk_sync_dfs[4]);
wire gen_dc5_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[8] & dc_clkon[5] & clk_en_aclk_sync_dfs[5]);
wire gen_dc6_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[9] & dc_clkon[6] & clk_en_aclk_sync_dfs[6]);
wire gen_dc7_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[10]& dc_clkon[7] & clk_en_aclk_sync_dfs[7]);

wire	[7:0] gen_dc_clkmux_en = {gen_dc7_clkmux_en, gen_dc6_clkmux_en, gen_dc5_clkmux_en, gen_dc4_clkmux_en,
                                  gen_dc3_clkmux_en, gen_dc2_clkmux_en, gen_dc1_clkmux_en, gen_dc0_clkmux_en};

wire gen_lm0_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[3] & lm_clkon[0] & clk_en_aclk_sync_dfs[0]);
wire gen_lm1_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[4] & lm_clkon[1] & clk_en_aclk_sync_dfs[1]);
wire gen_lm2_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[5] & lm_clkon[2] & clk_en_aclk_sync_dfs[2]);
wire gen_lm3_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[6] & lm_clkon[3] & clk_en_aclk_sync_dfs[3]);
wire gen_lm4_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[7] & lm_clkon[4] & clk_en_aclk_sync_dfs[4]);
wire gen_lm5_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[8] & lm_clkon[5] & clk_en_aclk_sync_dfs[5]);
wire gen_lm6_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[9] & lm_clkon[6] & clk_en_aclk_sync_dfs[6]);
wire gen_lm7_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[10]& lm_clkon[7] & clk_en_aclk_sync_dfs[7]);

wire	[7:0] gen_lm_clkmux_en = {gen_lm7_clkmux_en, gen_lm6_clkmux_en, gen_lm5_clkmux_en, gen_lm4_clkmux_en,
                                  gen_lm3_clkmux_en, gen_lm2_clkmux_en, gen_lm1_clkmux_en, gen_lm0_clkmux_en};

wire gen_l2c0_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[0]);
wire gen_l2c1_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[1]);
wire gen_l2c2_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[2]);
wire gen_l2c3_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[3]);
wire gen_l2c4_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[4]);
wire gen_l2c5_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[5]);
wire gen_l2c6_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[6]);
wire gen_l2c7_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[7]);

wire	[7:0] gen_l2c_clkmux_en = {gen_l2c7_clkmux_en, gen_l2c6_clkmux_en, gen_l2c5_clkmux_en, gen_l2c4_clkmux_en,
                                   gen_l2c3_clkmux_en, gen_l2c2_clkmux_en, gen_l2c1_clkmux_en, gen_l2c0_clkmux_en};
wire	gen_l2_clkmux_en = (|gen_l2c_clkmux_en[NHART-1:0]);

// FuSa BIU
wire gen_biu0_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & biu_clkon[0]);
wire gen_biu1_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & biu_clkon[1]);

wire	[7:0] gen_biu_n_clkmux_en = {6'b0, gen_biu1_clkmux_en, gen_biu0_clkmux_en};
wire	gen_biu_clkmux_en = (|gen_biu_n_clkmux_en[NHART-1:0]);


// --------------------------
// clock select and gated
// --------------------------
BUFGCTRL ROOT_CLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(1'b1			),
	.CE1		(1'b1			),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(root_clk		)
);

`ifdef NDS_IO_DFS
	wire	clkfb_dfs;

	BUFGCE	ROOT_DFS_CLK_0_MUX_INST (
		.I	(dfs_clk[0]		),
		.CE	(1'b1			),
		.O	(root_dfs_clk[0]	)
	);
	BUFGCE	ROOT_DFS_CLK_1_MUX_INST (
		.I	(dfs_clk[1]		),
		.CE	(1'b1			),
		.O	(root_dfs_clk[1]	)
	);
	BUFGCE	ROOT_DFS_CLK_2_MUX_INST (
		.I	(dfs_clk[2]		),
		.CE	(1'b1			),
		.O	(root_dfs_clk[2]	)
	);
	BUFGCE	ROOT_DFS_CLK_3_MUX_INST (
		.I	(dfs_clk[3]		),
		.CE	(1'b1			),
		.O	(root_dfs_clk[3]	)
	);
	BUFGCE	ROOT_DFS_CLK_4_MUX_INST (
		.I	(dfs_clk[4]		),
		.CE	(1'b1			),
		.O	(root_dfs_clk[4]	)
	);
	BUFGCE	ROOT_DFS_CLK_5_MUX_INST (
		.I	(dfs_clk[5]		),
		.CE	(1'b1			),
		.O	(root_dfs_clk[5]	)
	);
	BUFGCE	ROOT_DFS_CLK_6_MUX_INST (
		.I	(dfs_clk[6]		),
		.CE	(1'b1			),
		.O	(root_dfs_clk[6]	)
	);
	BUFGCE	ROOT_DFS_CLK_7_MUX_INST (
		.I	(dfs_clk[7]		),
		.CE	(1'b1			),
		.O	(root_dfs_clk[7]	)
	);

        sample_ae350_dfs_wrapper	#(
		.SYNC_STAGE      (SYNC_STAGE      )
	) ae350_fpga_dfs_wrapper (
		  .aclk(aclk),     
		  .aresetn(aresetn),  
		  .aopd_por_dbg_rstn(aopd_por_dbg_rstn),
		  .dfs_awaddr(dfs_awaddr),
		  .dfs_awvalid(dfs_awvalid),
		  .dfs_awready(dfs_awready),
		  .dfs_wdata(dfs_wdata),
		  .dfs_wstrb(dfs_wstrb),
		  .dfs_wvalid(dfs_wvalid),
		  .dfs_wready(dfs_wready),
		  .dfs_bresp(dfs_bresp),
		  .dfs_bvalid(dfs_bvalid),
		  .dfs_bready(dfs_bready),
		  .dfs_araddr(dfs_araddr),
		  .dfs_arvalid(dfs_arvalid),
		  .dfs_arready(dfs_arready),
		  .dfs_rdata(dfs_rdata),
		  .dfs_rresp(dfs_rresp),
		  .dfs_rvalid(dfs_rvalid),
		  .dfs_rready(dfs_rready),
		  .dfs_clk(dfs_clk),  
		  .dfs_locked(dfs_locked),
		  .T_osch(T_osch),   
		  .clk_en_aclk_sync_dfs(clk_en_aclk_sync_dfs)
        );

        assign hvm_clk = root_dfs_clk[0];

	genvar i_bufg;
	generate
	for (i_bufg = 0; i_bufg < NHART; i_bufg = i_bufg + 1) begin: gen_bufg
		BUFGCE	CORE_CLK_MUX_INST (
			.I	(dfs_clk[i_bufg]		),
			.CE	(gen_core_clkmux_en[i_bufg]	),
			.O	(core_clk[i_bufg]		)
		);

		BUFGCE	DC_CLK_MUX_INST (
			.I	(dfs_clk[i_bufg]		),
			.CE	(gen_dc_clkmux_en[i_bufg]	),
			.O	(dc_clk[i_bufg]			)
		);

		BUFGCE	LM_CLK_MUX_INST (
			.I	(dfs_clk[i_bufg]		),
			.CE	(gen_lm_clkmux_en[i_bufg]	),
			.O	(lm_clk[i_bufg]		)
		);

		assign vpu_clk[i_bufg] = core_clk[i_bufg];
		assign vpu_vlsu_clk[i_bufg] = core_clk[i_bufg];
		assign vpu_valu_clk[i_bufg] = core_clk[i_bufg];
		assign vpu_vfmis_clk[i_bufg] = core_clk[i_bufg];
		assign vpu_vmac_clk[i_bufg] = core_clk[i_bufg];
		assign vpu_vfdiv_clk[i_bufg] = core_clk[i_bufg];
		assign vpu_vdiv_clk[i_bufg] = core_clk[i_bufg];
		assign vpu_vmask_clk[i_bufg] = core_clk[i_bufg];
		assign vpu_vpermut_clk[i_bufg] = core_clk[i_bufg];
		assign vpu_vace_clk[i_bufg] = core_clk[i_bufg];
		assign vpu_vsp_clk[i_bufg] = core_clk[i_bufg];
		assign te_clk[i_bufg]  = root_dfs_clk[i_bufg];

	end
	endgenerate
	`ifdef NDS_FUSA_SUPPORT
		`ifdef NDS_IO_DCLS
			reg [1:0] dcls_core1_clk_en_delay;
			reg [1:0] dcls_core1_lm_clk_en_delay;
			always @(posedge dfs_clk[0] or negedge dcls_r_reset_n) begin
				if (!dcls_r_reset_n) begin
					dcls_core1_clk_en_delay <= 2'd0;
				end
				else begin
					dcls_core1_clk_en_delay <= {dcls_core1_clk_en_delay[0], gen_core_clkmux_en[0]};
			end
			always @(posedge dfs_clk[0] or negedge dcls_r_reset_n) begin
				if (!dcls_r_reset_n) begin
					dcls_core1_lm_clk_en_delay <= 2'd0;
				end
				else begin
					dcls_core1_lm_clk_en_delay <= {dcls_core1_lm_clk_en_delay[0], gen_lm_clkmux_en[0]};
			end
			wire dcls_p_clk_en = |dcls_core1_lm_clk_en_delay | gen_lm_clkmux_en[0];
			wire dcls_r_clk_en = |dcls_core1_lm_clk_en_delay | gen_lm_clkmux_en[0];
			BUFGCE	DCLS_P_CLK_MUX_INST (
				.I	(dfs_clk[0]			),
				.CE	(dcls_p_clk_en			),
				.O	(dcls_p_clk			)
			);
			BUFGCE	DCLS_R_CLK_MUX_INST (
				.I	(dfs_clk[0]			),
				.CE	(dcls_r_clk_en			),
				.O	(dcls_r_clk			)
			);
			BUFGCE	DCLS_CORE1_CLK_MUX_INST (
				.I	(dfs_clk[0]			),
				.CE	(dcls_core1_clk_en_delay[1]	),
				.O	(dcls_core1_clk			)
			);
			BUFGCE	DCLS_CORE1_LM_CLK_MUX_INST (
				.I	(dfs_clk[0]			),
				.CE	(dcls_core1_lm_clk_en_delay[1]	),
				.O	(dcls_core1_lm_clk		)
			);
end		`endif // NDS_IO_DCLS
		`ifdef NDS_IO_DCACHE0
		assign dcache0_p_clk = dfs_clk[0];
		assign dcache0_r_clk = dfs_clk[0];
		`ifdef NDS_IO_DCLS_SPLIT
		assign dcache1_p_clk = dfs_clk[0];
		assign dcache1_r_clk = dfs_clk[0];
		`endif // NDS_IO_DCLS_SPLIT
		`endif // NDS_IO_DCACHE0

		`ifdef NDS_IO_ICACHE0
		assign icache0_p_clk = dfs_clk[0];
		assign icache0_r_clk = dfs_clk[0];
		`ifdef NDS_IO_DCLS_SPLIT
		assign icache1_p_clk = dfs_clk[0];
		assign icache1_r_clk = dfs_clk[0];
		`endif // NDS_IO_DCLS_SPLIT
		`endif // NDS_IO_ICACHE0
	`endif // NDS_FUSA_SUPPORT
`else
        assign root_dfs_clk = {8{root_clk}};
	BUFGCTRL CORE_CLK_MUX_INST (
		.I0		(fast_clk		),
		.I1		(slow_clk		),
		.CE0		(1'b1			),
		.CE1		(1'b1			),
		.S0		(~smu_core_clk_sel	),
		.S1		( smu_core_clk_sel	),
		.IGNORE0	(1'b0			),
		.IGNORE1	(1'b0			),
		.O		(core_clk[0]		)
	);

        assign hvm_clk = core_clk[0];
	`ifdef NDS_IO_HART1 
	assign core_clk[(NHART-1):1] = {(NHART-1){core_clk[0]}};
	`endif
	assign te_clk[(NHART-1):0]  = {NHART{core_clk[0]}};
	assign vpu_clk[(NHART-1):0] = {NHART{core_clk[0]}};
	assign vpu_vlsu_clk[(NHART-1):0] = {NHART{core_clk[0]}};
	assign vpu_valu_clk[(NHART-1):0] = {NHART{core_clk[0]}};
	assign vpu_vfmis_clk[(NHART-1):0] = {NHART{core_clk[0]}};
	assign vpu_vmac_clk[(NHART-1):0] = {NHART{core_clk[0]}};
	assign vpu_vfdiv_clk[(NHART-1):0] = {NHART{core_clk[0]}};
	assign vpu_vdiv_clk[(NHART-1):0] = {NHART{core_clk[0]}};
	assign vpu_vmask_clk[(NHART-1):0] = {NHART{core_clk[0]}};
	assign vpu_vpermut_clk[(NHART-1):0] = {NHART{core_clk[0]}};
	assign vpu_vace_clk[(NHART-1):0] = {NHART{core_clk[0]}};
	assign vpu_vsp_clk[(NHART-1):0] = {NHART{core_clk[0]}};
	assign dc_clk[(NHART-1):0]  = {NHART{core_clk[0]}};
	assign lm_clk[(NHART-1):0]  = {NHART{core_clk[0]}};
	`ifdef NDS_FUSA_SUPPORT
		`ifdef NDS_IO_DCLS
			assign	dcls_p_clk = core_clk[0];
			assign	dcls_r_clk = core_clk[0];
			assign	dcls_core1_clk = core_clk[0];
			assign	dcls_core1_lm_clk = core_clk[0];
		`endif // NDS_IO_DCLS
		`ifdef NDS_IO_DCACHE0
			assign dcache0_p_clk = core_clk[0];
			assign dcache0_r_clk = core_clk[0];
			`ifdef NDS_IO_DCLS_SPLIT
			assign dcache1_p_clk = core_clk[0];
			assign dcache1_r_clk = core_clk[0];
			`endif // NDS_IO_DCLS_SPLIT
		`endif // NDS_IO_DCACHE0

		`ifdef NDS_IO_ICACHE0
			assign icache0_p_clk = core_clk[0];
			assign icache0_r_clk = core_clk[0];
			`ifdef NDS_IO_DCLS_SPLIT
			assign icache1_p_clk = core_clk[0];
			assign icache1_r_clk = core_clk[0];
			`endif // NDS_IO_DCLS_SPLIT
		`endif // NDS_IO_ICACHE0
	`endif // NDS_FUSA_SUPPORT

`endif

BUFGCTRL BIU_CLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(gen_biu_clkmux_en	),
	.CE1		(gen_biu_clkmux_en	),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(biu_clk		)
);

BUFGCTRL L2_CLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(gen_l2_clkmux_en	),
	.CE1		(gen_l2_clkmux_en	),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(l2_clk			)
);

BUFGCTRL DEBUG_CLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(gen_debug_clkmux_en    ),
	.CE1		(gen_debug_clkmux_en    ),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(dm_clk			)
);
`ifdef PLATFORM_TRACE_SUBSYSTEM
assign ts_clk = dm_clk;
`endif


BUFGCTRL ACLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(gen_aclk_clkmux_en     ),
	.CE1		(gen_aclk_clkmux_en     ),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(aclk		)
);

BUFGCTRL HCLK_MUX_INST (
	.I0		(root_clk		),
	.I1		(div_n_hclk		),
	.CE0		(gen_hclk_clkmux_en     ),
	.CE1		(gen_hclk_clkmux_en     ),
	.S0		(~hclk_div_n_select_sync),
	.S1		( hclk_div_n_select_sync),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(hclk			)
);

BUFGCTRL PCLK_MUX_INST (
	.I0		(root_clk		),
	.I1		(div_n_pclk		),
	.CE0		(gen_pclk_clkmux_en     ),
	.CE1		(gen_pclk_clkmux_en     ),
	.S0		(~pclk_div_n_select_sync),
	.S1		( pclk_div_n_select_sync),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(pclk			)
);

// The BUFG related usage rules:
// 1. BUFG to BUFG can only has two branch
//          (BUFG)      (BUFG)
//	mmcm -> root_clk -> hclk	(O)
//			 -> pclk	(O)
//			 -> aopd_pclk	(X)
//
// 2. BUFG to BUFG can only has two level connection
//          (BUFG)      (BUFG)	   (BUFGCE)(X)
//	mmcm -> root_clk -> aopd_pclk -> pclk
// 
// *According to the rules, the aopd_pclk should be generated by another
//  root_clk(aopd_root_clk) since the original root_clk has already drive the
//  PCLK and HCLK

wire	aopd_root_clk;
BUFGCTRL AOPD_ROOT_CLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(1'b1			),
	.CE1		(1'b1			),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(aopd_root_clk		)
);

BUFGCTRL AOPD_PCLK_MUX_INST (
	.I0		(aopd_root_clk		),
	.I1		(div_n_pclk		),
	.CE0		(gen_clkmux_clk_en	),
	.CE1		(gen_clkmux_clk_en	),
	.S0		(~pclk_div_n_select_sync),
	.S1		( pclk_div_n_select_sync),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(aopd_pclk		)
);

	`ifdef AE350_LCDC_SUPPORT
// BUFG lcd_bufg (
// 	.I		(hclk			),
// 	.O		(lcd_clk		)
// );
assign lcd_clk = hclk;
assign lcd_clkn = ~lcd_clk;
	`endif	// !AE350_LCDC_SUPPORT
	`ifdef AE350_SSP_SUPPORT
// BUFG ssp_bufg (
// 	.I		(core_clk		),
// 	.O		(sspclk			)
// );
assign sspclk = root_clk;
	`endif	// !AE350_SSP_SUPPORT

assign pclk_uart1 = pclk;
assign pclk_uart2 = pclk;
assign pclk_spi1  = pclk;
assign pclk_spi2  = pclk;
assign pclk_gpio  = pclk;
assign pclk_pit   = pclk;
assign pclk_i2c   = pclk;
assign pclk_wdt   = pclk;

assign clk_32k	  = aopd_clk_32k;

// --------------------------
// main clock cnt
// --------------------------
wire	[1:0] root_clk_cnt_nx;
assign	root_clk_cnt_nx = root_clk_cnt + 2'b1;
always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		root_clk_cnt	<= 2'b0;
	else
		root_clk_cnt	<= root_clk_cnt_nx;
end

// --------------------------
// ratio change clock break
// --------------------------
wire		clock_ratio_change;
assign clock_ratio_change =
	(smu_core_clk_2_hclk_ratio_sync != smu_core_clk_2_hclk_ratio) |
	(smu_hclk_2_pclk_ratio_sync != smu_hclk_2_pclk_ratio);

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		gen_clkmux_clk_en <= 1'b1;
	else if ((clock_ratio_change | ~gen_clkmux_clk_en) & root_clk_cnt == 2'b11)
		gen_clkmux_clk_en <= ~gen_clkmux_clk_en;

end

// --------------------------
// The 2nd stage -> hclk
// --------------------------
wire	      hclk_inv_cond;
wire	      ahb2core_clken_low_cond;
wire	      ahb2core_clken_high_cond;


assign hclk_inv_cond = ~smu_core_clk_2_hclk_ratio_sync[1] |
		       (smu_core_clk_2_hclk_ratio_sync[1] & ~root_clk_cnt[0]); // 2'b11 is not configurable

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		div_n_hclk <= 1'b0;
	else if (hclk_inv_cond)
		div_n_hclk <= ~div_n_hclk;
end

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		smu_core_clk_2_hclk_ratio_sync <= 2'b00;
	else if ((smu_core_clk_2_hclk_ratio_sync != smu_core_clk_2_hclk_ratio) & (root_clk_cnt == 2'b11))
		smu_core_clk_2_hclk_ratio_sync <= smu_core_clk_2_hclk_ratio;
end

assign ahb2core_clken_low_cond = ahb2core_clken & (smu_core_clk_2_hclk_ratio_sync != 2'b00);
assign ahb2core_clken_high_cond =
	((smu_core_clk_2_hclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'b01) & (root_clk_cnt[0])) | // 2'b01 | 2'b11
	((smu_core_clk_2_hclk_ratio_sync == 2'b10) & (root_clk_cnt[1:0] == 2'b11)); // 2'b11

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		ahb2core_clken <= 1'b0;
	else if (ahb2core_clken_low_cond)
		ahb2core_clken <= 1'b0;
	else if (ahb2core_clken_high_cond)
		ahb2core_clken <= 1'b1;
end

assign hclk_div_n_select_sync = smu_core_clk_2_hclk_ratio_sync != 2'b00;


// --------------------------
// The 3rd stage -> pclk
// --------------------------
wire          pclk_inv_cond;
wire          apb2ahb_clken_low_cond;
wire          apb2ahb_clken_high_cond;

wire	[1:0] core_clk_2_pclk_ratio_sync;

assign	      core_clk_2_pclk_ratio_sync = (smu_core_clk_2_hclk_ratio_sync == 2'b0) ? smu_hclk_2_pclk_ratio_sync :
										      smu_hclk_2_pclk_ratio_sync + 2'b01;

assign pclk_inv_cond = (~core_clk_2_pclk_ratio_sync[1]) |
		       ((core_clk_2_pclk_ratio_sync == 2'b10) & (root_clk_cnt[0] == 1'b0)); // 2'b11 is not configurable

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		div_n_pclk <= 1'b0;
	else if (pclk_inv_cond)
		div_n_pclk <= ~div_n_pclk;
end
always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		smu_hclk_2_pclk_ratio_sync <= 2'b00; // default divide by 2
	else if ((smu_hclk_2_pclk_ratio_sync != smu_hclk_2_pclk_ratio) & (root_clk_cnt == 2'b11))
		smu_hclk_2_pclk_ratio_sync <= smu_hclk_2_pclk_ratio;
end
assign apb2ahb_clken_low_cond = (smu_core_clk_2_hclk_ratio_sync == 2'b00) ?
					(apb2ahb_clken & (smu_hclk_2_pclk_ratio_sync != 2'b00)) :
					(apb2ahb_clken & (smu_hclk_2_pclk_ratio_sync != 2'b00) & root_clk_cnt == 2'b00);

assign apb2ahb_clken_high_cond = (smu_core_clk_2_hclk_ratio_sync == 2'b00) ?
                                  ((smu_hclk_2_pclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
				  ((smu_hclk_2_pclk_ratio_sync == 2'b01) & ((root_clk_cnt == 2'b01) | (root_clk_cnt == 2'b11))) |
				  ((smu_hclk_2_pclk_ratio_sync == 2'b10) & (root_clk_cnt == 2'b11)) :
				  ((smu_hclk_2_pclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
				  ((smu_hclk_2_pclk_ratio_sync == 2'b01) & (root_clk_cnt == 2'b10));

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		apb2ahb_clken <= 1'b0;
	else if (apb2ahb_clken_low_cond)
		apb2ahb_clken <= 1'b0;
	else if (apb2ahb_clken_high_cond)
		apb2ahb_clken <= 1'b1;
end
assign pclk_div_n_select_sync = core_clk_2_pclk_ratio_sync != 2'b00;

wire	      apb2core_clken_low_cond;
wire	      apb2core_clken_high_cond;

assign apb2core_clken_low_cond = (apb2core_clken & (core_clk_2_pclk_ratio_sync != 2'b00));
assign apb2core_clken_high_cond = ((core_clk_2_pclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
				  ((core_clk_2_pclk_ratio_sync == 2'b01) & (root_clk_cnt[0])) | // 2'b01 | 2'b11
				  ((core_clk_2_pclk_ratio_sync == 2'b10) & (root_clk_cnt[1:0] == 2'b11)); // 2'b11
always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		apb2core_clken <= 1'b0;
	else if (apb2core_clken_low_cond)
		apb2core_clken <= 1'b0;
	else if (apb2core_clken_high_cond)
		apb2core_clken <= 1'b1;
end

assign axi2core_clken = 1'b1;

`else	// !NDS_FPGA

	`ifdef SYNTHESIS
	wire [(NHART-1):0] nds_unused_te_clkon = te_clkon;
	wire [7:0] nds_unused_core_clkon = core_clkon;
	wire [7:0] nds_unused_dc_clkon = dc_clkon;
	wire [7:0] nds_unused_lm_clkon = lm_clkon;
	wire [7:0] nds_unused_l2c_clkon = l2c_clkon;
	wire [7:0] nds_unused_biu_clkon = biu_clkon;
	wire nds_unused_smu_aclk_en = smu_aclk_en;
	wire nds_unused_smu_hclk_en = smu_hclk_en;
	wire nds_unused_smu_pclk_en = smu_pclk_en;
		`ifdef NDS_IO_DFS
	wire [7:0] nds_unused_dfs_clk = dfs_clk;
        assign  clk_en_aclk_sync_dfs = {8{1'b1}};
		`endif
	wire nds_unused_smu_core_clk_sel = smu_core_clk_sel;
	wire [7:0] nds_unused_clk_en_aclk_sync_dfs = clk_en_aclk_sync_dfs;
//*** ASIC synthesis ***

//assign		aopd_dbg_tck = T_tck;	// merge into sample_ae350_aopd_clkgen	
//assign		aopd_clk_32k = T_oscl;	// merge into sample_ae350_aopd_clkgen
assign		aopd_pclk = T_osch;
assign		clk_32k = T_oscl;
assign		dm_clk = T_osch;
`ifdef PLATFORM_TRACE_SUBSYSTEM
assign          ts_clk = T_osch;
`endif
assign		core_clk = {NHART{T_osch}};
assign		dc_clk   = {NHART{T_osch}};
assign		lm_clk   = {NHART{T_osch}};
`ifdef NDS_FUSA_SUPPORT
	`ifdef NDS_IO_DCLS
		assign	dcls_p_clk = T_osch;
		assign	dcls_r_clk = T_osch;
		assign	dcls_core1_clk = T_osch;
		assign	dcls_core1_lm_clk = T_osch;
	`endif // NDS_IO_DCLS
	`ifdef NDS_IO_DCACHE0
		assign dcache0_p_clk = T_osch;
		assign dcache0_r_clk = T_osch;
		`ifdef NDS_IO_DCLS_SPLIT
		assign dcache1_p_clk = T_osch;
		assign dcache1_r_clk = T_osch;
		`endif// NDS_IO_DCLS_SPLIT
	`endif // NDS_IO_DCACHE0

	`ifdef NDS_IO_ICACHE0
		assign icache0_p_clk = T_osch;
		assign icache0_r_clk = T_osch;
		`ifdef NDS_IO_DCLS_SPLIT
		assign icache1_p_clk = T_osch;
		assign icache1_r_clk = T_osch;
		`endif// NDS_IO_DCLS_SPLIT
	`endif // NDS_IO_ICACHE0
`endif // NDS_FUSA_SUPPORT
assign		te_clk   = {NHART{T_osch}};
assign		vpu_clk  = {NHART{T_osch}};
assign		vpu_vlsu_clk  = {NHART{T_osch}};
assign		vpu_valu_clk  = {NHART{T_osch}};
assign		vpu_vfmis_clk  = {NHART{T_osch}};
assign		vpu_vmac_clk  = {NHART{T_osch}};
assign		vpu_vfdiv_clk  = {NHART{T_osch}};
assign		vpu_vdiv_clk  = {NHART{T_osch}};
assign		vpu_vmask_clk  = {NHART{T_osch}};
assign		vpu_vpermut_clk  = {NHART{T_osch}};
assign		vpu_vace_clk  = {NHART{T_osch}};
assign		vpu_vsp_clk  = {NHART{T_osch}};
assign		aclk = T_osch;
assign		hclk = T_osch;
assign		pclk = T_osch;
assign		pclk_uart1 = T_osch;
assign		pclk_uart2 = T_osch;
assign		pclk_spi1 = T_osch;
assign		pclk_spi2 = T_osch;
assign		pclk_gpio = T_osch;
assign		pclk_pit = T_osch;
assign		pclk_i2c = T_osch;
assign		pclk_wdt = T_osch;
assign		apb2ahb_clken = 1'b1;
assign		ahb2core_clken = 1'b1;
assign		axi2core_clken = 1'b1;
assign		root_clk = T_osch;
assign		root_dfs_clk = {8{T_osch}};
assign		uart_clk = T_osch;
assign		spi_clk = T_osch;
assign		sdc_clk = T_osch;
assign		apb2core_clken = 1'b1;
assign		l2_clk   = T_osch;
assign		hvm_clk   = T_osch;
assign          biu_clk  = T_osch;
`ifdef NDS_IO_DFS
assign          dfs_locked = 1'b1;
assign          dfs_wready = 1'b1;
assign          dfs_rvalid = 1'b1;
assign          dfs_rdata  = 32'd0;
assign          dfs_bvalid = 1'b1;
assign          dfs_rresp = 2'd0;
assign          dfs_bresp = 2'd0;
assign          dfs_awready = 1'b1;
assign          dfs_arready = 1'b1;
assign          dfs_clk = {8{T_osch}};
`endif //NDS_IO_DFS
		`ifdef AE350_LCDC_SUPPORT
assign lcd_clk       = T_osch;
assign lcd_clkn      = ~lcd_clk;
		`endif
		`ifdef AE350_SSP_SUPPORT
assign sspclk        = T_osch;
		`endif
	`else	// !SYNTHESIS
//*** ASIC RTL simulation ***
wire		root_clk_premux;
wire		hclk_pri;
wire		pclk_pri;

wire		osch_div2_mux_test;
wire		hclk_mux_test;

reg		osch_div2;

reg	[1:0]	smu_core_clk_2_hclk_ratio_sync;
reg	[1:0]	smu_hclk_2_pclk_ratio_sync;

wire		hclk_clk_en;
wire		pclk_clk_en;
wire		pclk_uart1_clk_en;
wire		pclk_uart2_clk_en;
wire		pclk_spi1_clk_en;
wire		pclk_spi2_clk_en;
wire		pclk_gpio_clk_en;
wire		pclk_i2c_clk_en;
wire		pclk_wdt_clk_en;
wire		pclk_pit_clk_en;

		`ifdef AE350_LCDC_SUPPORT
assign lcd_clk  = hclk;
assign lcd_clkn = ~lcd_clk;
		`endif
		`ifdef AE350_SSP_SUPPORT
assign sspclk = root_clk_dly;
		`endif

// --------------------------
// The 1st stage -> core_clk
// --------------------------
always @(posedge T_osch or negedge main_rstn) begin
	if (!main_rstn)
		osch_div2	<= 1'b0;
	else
		osch_div2	<= ~osch_div2;
end

assign	osch_div2_mux_test = scan_test ? test_clk : osch_div2;
async_clkmux #(.ASYNC_CLK_MUX ("no")) u_core_clk_mux (
	.reset0_n	(main_rstn		),
	.reset1_n	(main_rstn		),
	.clk_in0	(T_osch			),
	.clk_in1	(osch_div2_mux_test	),
	.test_mode	(scan_enable		),
	.select		(smu_core_clk_sel	),
	.clk_out	(root_clk_premux	)
);

// To avoid HAL CLKOUT warnings, don't directly use output signals.
wire	root_clk_src = scan_test ? test_clk : root_clk_premux;
assign	root_clk = root_clk_src;

// --------------------------
// Clock Dividers (Order-2)
// --------------------------
reg             hclk_div;
reg       [1:0] pclk_div;
wire      [1:0] pclk_div_addend;
wire      [1:0] pclk_div_nx = pclk_div + pclk_div_addend;
reg       [2:0] root_clk_cnt;
wire      [2:0] root_clk_cnt_nx = root_clk_cnt + 3'd1;
reg             uart_clk;

wire            root_clk_div4 = root_clk_cnt[1];

always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		hclk_div <= 1'b1;
	else
		hclk_div <= ~hclk_div;
end
always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		pclk_div <= 2'd2;
	else
		pclk_div <= pclk_div_nx;
end

always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		root_clk_cnt <= 3'd0;
	else
		root_clk_cnt <= root_clk_cnt_nx;
end

always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		uart_clk <= 1'b0;
	else
		uart_clk <= root_clk_div4;
end


assign pclk_div_addend =
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd2)) ? 2'd1 :
        ((smu_core_clk_2_hclk_ratio_sync == 2'd1) & (smu_hclk_2_pclk_ratio_sync == 2'd1)) ? 2'd1 : 2'd2;

reg   [2:0] root_clk_cnt_dly;
always @(root_clk_cnt) begin
	root_clk_cnt_dly <= root_clk_cnt;
end

// --------------------------
// Ratio change
// --------------------------
reg             clock_stable;
wire            clock_stable_nx;

wire            all_clocks_aligned = &root_clk_cnt_dly;
wire            clock_ratio_change;


always @(posedge root_clk_dly or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly)
		clock_stable <= 1'b0;
	else
		clock_stable <= clock_stable_nx;
end

always @(posedge root_clk_dly or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly) begin
		smu_core_clk_2_hclk_ratio_sync <= 2'd0;
		smu_hclk_2_pclk_ratio_sync     <= 2'd0;
	end
	else if (clock_ratio_change) begin
		smu_core_clk_2_hclk_ratio_sync <= smu_core_clk_2_hclk_ratio;
		smu_hclk_2_pclk_ratio_sync     <= smu_hclk_2_pclk_ratio;
	end
end

assign clock_ratio_change = clock_stable & all_clocks_aligned &
	((smu_core_clk_2_hclk_ratio_sync != smu_core_clk_2_hclk_ratio) |
	 (smu_hclk_2_pclk_ratio_sync != smu_hclk_2_pclk_ratio));

assign clock_stable_nx    = clock_ratio_change  ? 1'b0 :
                            &all_clocks_aligned ? 1'b1 : clock_stable;

assign  clock_unstable = ( clock_stable &  clock_ratio_change)
                       | (~clock_stable & ~all_clocks_aligned);

// --------------------------
// aclk gck
// --------------------------
wire  aclk_en = smu_aclk_en;

// To avoid HAL CLKOUT warnings, don't directly use output signals.
wire	aclk_src;
assign	aclk = aclk_src;

gck gck_aclk(
	.clk_out	(aclk_src		),
	.clk_en		(aclk_en		),
	.clk_in		(root_clk_dly		),
	.test_en	(scan_enable		)
);

// --------------------------
// core_clk
// --------------------------
reg      [1:0] core_clk_cnt;
wire     [1:0] core_clk_cnt_nx = core_clk_cnt + 2'd1;

always @(posedge aclk_src or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly)
		core_clk_cnt <= 2'd3;
	else
		core_clk_cnt <= core_clk_cnt_nx;
end

assign ahb2core_clken =
	(smu_core_clk_2_hclk_ratio_sync == 2'd0) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd1) & core_clk_cnt[0]);

assign apb2core_clken =
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd0)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd1) & (core_clk_cnt[0] == 1'd1)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd2) & (core_clk_cnt    == 2'd3)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd1) & (smu_hclk_2_pclk_ratio_sync == 2'd0) & (core_clk_cnt[0] == 1'd1)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd1) & (smu_hclk_2_pclk_ratio_sync == 2'd1) & (core_clk_cnt    == 2'd3));

assign axi2core_clken = 1'b1;

// --------------------------
// hclk
// --------------------------
wire         hclk_mux_in0 = root_clk_dly;
wire         hclk_mux_in1 = hclk_div;
wire         hclk_mux_sel = (smu_core_clk_2_hclk_ratio_sync != 2'd0);

async_clkmux #(.ASYNC_CLK_MUX ("no")) u_hclk_mux (
	.reset0_n	(main_rstn_csync	),
	.reset1_n	(main_rstn_csync	),
	.clk_in0	(hclk_mux_in0		),
	.clk_in1	(hclk_mux_in1		),
	.test_mode	(scan_enable		),
	.select		(hclk_mux_sel		),
	.clk_out	(hclk_pri		)
);

assign	hclk_mux_test	= scan_test ? test_clk : hclk_pri;

assign  hclk_clk_en = smu_hclk_en & ~clock_unstable;

// To avoid HAL CLKOUT warnings, don't directly use output signals.
wire	hclk_src;
assign	hclk = hclk_src;

gck gck_hclk (
	.clk_out	(hclk_src		),
	.clk_en		(hclk_clk_en		),
	.clk_in		(hclk_mux_test		),
	.test_en	(scan_enable		)
);

// --------------------------
// hclk
// --------------------------
reg    [1:0] hclk_cnt;
wire   [1:0] hclk_cnt_nx = hclk_cnt + 2'd1;
always @(posedge hclk_src or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly)
		hclk_cnt <= 2'd3;
	else
		hclk_cnt <= hclk_cnt_nx;
end

assign apb2ahb_clken =  (smu_hclk_2_pclk_ratio_sync == 2'd0)
                     | ((smu_hclk_2_pclk_ratio_sync == 2'd1) & (hclk_cnt[0] == 1'b1))
                     | ((smu_hclk_2_pclk_ratio_sync == 2'd2) & (hclk_cnt    == 2'd3));


// --------------------------
// pclk
// --------------------------
wire          pclk_mux_in0 = root_clk_dly;
wire          pclk_mux_in1 = pclk_div[1];
wire          pclk_mux_sel = (smu_core_clk_2_hclk_ratio_sync != 2'b0) | (smu_hclk_2_pclk_ratio_sync != 2'b0);

async_clkmux #(.ASYNC_CLK_MUX ("no")) u_pclk_a1_mux (
	.reset0_n	(main_rstn_csync	),
	.reset1_n	(main_rstn_csync	),
	.clk_in0	(pclk_mux_in0		),
	.clk_in1	(pclk_mux_in1		),
	.test_mode	(scan_enable		),
	.select		(pclk_mux_sel		),
	.clk_out	(pclk_pri		)
);

assign pclk_mux_test = scan_test ? test_clk : pclk_pri;
assign pclk_clk_en   = smu_pclk_en & ~clock_unstable;

wire	smu_pclk_uart1_en = pcs_clk_en[2] & pclkon;
wire	smu_pclk_uart2_en = pcs_clk_en[2] & pclkon;
wire	smu_pclk_spi1_en  = pcs_clk_en[2] & pclkon;
wire	smu_pclk_spi2_en  = pcs_clk_en[2] & pclkon;
wire	smu_pclk_gpio_en  = pcs_clk_en[2] & pclkon;
wire	smu_pclk_i2c_en   = pcs_clk_en[2] & pclkon;	
wire	smu_pclk_wdt_en   = pcs_clk_en[2] & pclkon;	
wire	smu_pclk_pit_en   = pcs_clk_en[2] & pclkon;	

assign pclk_uart1_clk_en = smu_pclk_uart1_en & ~clock_unstable;
assign pclk_uart2_clk_en = smu_pclk_uart2_en & ~clock_unstable;
assign pclk_spi1_clk_en  = smu_pclk_spi1_en  & ~clock_unstable;
assign pclk_spi2_clk_en  = smu_pclk_spi2_en  & ~clock_unstable;
assign pclk_gpio_clk_en  = smu_pclk_gpio_en  & ~clock_unstable;
assign pclk_i2c_clk_en   = smu_pclk_i2c_en   & ~clock_unstable;
assign pclk_wdt_clk_en   = smu_pclk_wdt_en   & ~clock_unstable;
assign pclk_pit_clk_en   = smu_pclk_pit_en   & ~clock_unstable;

gck gck_pclk (
	.clk_out	(pclk			),
	.clk_en		(pclk_clk_en		),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);

gck gck_pclk_uart1 (
	.clk_out	(pclk_uart1		),
	.clk_en		(pclk_uart1_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_uart2 (
	.clk_out	(pclk_uart2		),
	.clk_en		(pclk_uart2_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_spi1 (
	.clk_out	(pclk_spi1		),
	.clk_en		(pclk_spi1_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_spi2 (
	.clk_out	(pclk_spi2		),
	.clk_en		(pclk_spi2_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_gpio (
	.clk_out	(pclk_gpio		),
	.clk_en		(pclk_gpio_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_i2c (
	.clk_out	(pclk_i2c		),
	.clk_en		(pclk_i2c_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_wdt (
	.clk_out	(pclk_wdt		),
	.clk_en		(pclk_wdt_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_pit (
	.clk_out	(pclk_pit		),
	.clk_en		(pclk_pit_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);

// --------------------------
// SPI clock
// --------------------------

assign aopd_pclk = pclk_mux_test;	// TODO: the signal should be moved to sample_ae350_aopd_clkgen in the future
// --------------------------
// SPI clock
// --------------------------

gck gck_spi_clk (
	.clk_out	(spi_clk		),
	.clk_en		(pcs_clk_en[2]		),
	.clk_in		(T_osch			),
	.test_en	(scan_enable		)
);

gck gck_sdc_clk (
	.clk_out	(sdc_clk		),
	.clk_en		(pcs_clk_en[2]		),
	.clk_in		(T_osch			),
	.test_en	(scan_enable		)
);

gck gck_clk_32k (
	.clk_out	(clk_32k		),
	.clk_en		(pcs_clk_en[2]		),
	.clk_in		(T_oscl			),
	.test_en	(scan_enable		)
);

//===============
//PCS1: (PLDM/ncejdtm200)
//===============
// to PLDM/ncejdtm200 clk/dmi_hclk

// To avoid HAL CLKOUT warnings, don't directly use output signals.
wire	dm_clk_en;
wire	dm_clk_src;
assign dm_clk_en = pcs_clk_en[1];
assign dm_clk    = dm_clk_src;
`ifdef PLATFORM_TRACE_SUBSYSTEM
assign ts_clk = dm_clk_src;
`endif

gck gck_dm_clk(
	.clk_out	(dm_clk_src		),
	.clk_en		(dm_clk_en		),
	.clk_in		(root_clk_dly		),
	.test_en	(scan_enable		)
);

//===============
//PCS3~10: COREs
//===============

wire	[(NHART-1):0] core_clk_en;
wire	[(NHART-1):0] vcore_clk_en;
wire	[(NHART-1):0] vcore_vlsu_clk_en;
wire	[(NHART-1):0] vcore_valu_clk_en;
wire	[(NHART-1):0] vcore_vfmis_clk_en;
wire	[(NHART-1):0] vcore_vmac_clk_en;
wire	[(NHART-1):0] vcore_vfdiv_clk_en;
wire	[(NHART-1):0] vcore_vdiv_clk_en;
wire	[(NHART-1):0] vcore_vmask_clk_en;
wire	[(NHART-1):0] vcore_vpermut_clk_en;
wire	[(NHART-1):0] vcore_vace_clk_en;
wire	[(NHART-1):0] vcore_vsp_clk_en;
wire	[(NHART-1):0] core_clk_src;
wire	[(NHART-1):0] dc_clk_en;
wire	[(NHART-1):0] dc_clk_src;
wire	[(NHART-1):0] lm_clk_en;
wire	[(NHART-1):0] lm_clk_src;
wire    [(NHART-1):0] l2c_clk_en;
wire		      l2_clk_src;
wire                  l2_clk_en;
wire    [(NHART-1):0] biu_n_clk_en;
wire		      biu_clk_src;
wire                  biu_clk_en;
wire	[(NHART-1):0] te_clk_en;
wire	[(NHART-1):0] te_clk_src;

`ifdef NDS_IO_DFS
    assign		hvm_clk   = dfs_clk_dly[0];
`else // ~NDS_IO_DFS
    assign		hvm_clk   = root_clk_dly;
`endif //NDS_IO_DFS

genvar i_clk;
generate
for (i_clk = 0; i_clk < NHART; i_clk = i_clk +1) begin: gen_simulation_clk
        `ifdef NDS_IO_DFS
            wire gck_core_clk_in = dfs_clk_dly[i_clk];
            wire gck_dc_clk_in   = dfs_clk_dly[i_clk];
            wire gck_lm_clk_in   = dfs_clk_dly[i_clk];
        `else // ~NDS_IO_DFS
            wire gck_core_clk_in = root_clk_dly;
            wire gck_dc_clk_in   = root_clk_dly;
            wire gck_lm_clk_in   = root_clk_dly;
        `endif //NDS_IO_DFS
	assign core_clk_en[i_clk] = (pcs_clk_en[(i_clk+3)] & core_clkon[i_clk] & clk_en_aclk_sync_dfs[i_clk]);
	assign core_clk[i_clk]    = core_clk_src[i_clk];
	gck gck_core_clk(
		.clk_out	(core_clk_src[i_clk]	),
		.clk_en		(core_clk_en[i_clk]	),
		.clk_in		(gck_core_clk_in	),
		.test_en	(scan_enable		)
	);
	
	assign dc_clk_en[i_clk] = (pcs_clk_en[(i_clk+3)] & dc_clkon[i_clk] & clk_en_aclk_sync_dfs[i_clk]);
	assign dc_clk[i_clk]    = dc_clk_src[i_clk];
	gck gck_dc_clk(
		.clk_out	(dc_clk_src[i_clk]	),
		.clk_en		(dc_clk_en[i_clk]	),
		.clk_in		(gck_dc_clk_in		),
		.test_en	(scan_enable		)
	);

	assign lm_clk_en[i_clk] = (pcs_clk_en[(i_clk+3)] & lm_clkon[i_clk] & clk_en_aclk_sync_dfs[i_clk]);
	assign lm_clk[i_clk]    = lm_clk_src[i_clk];
	gck gck_lm_clk(
		.clk_out	(lm_clk_src[i_clk]	),
		.clk_en		(lm_clk_en[i_clk]	),
		.clk_in		(gck_lm_clk_in		),
		.test_en	(scan_enable		)
	);

	assign te_clk_en[i_clk] = (pcs_clk_en[(i_clk+3)] & te_clkon[i_clk]);
	assign te_clk[i_clk]    = te_clk_src[i_clk];
	gck gck_te_clk(
		.clk_out	(te_clk_src[i_clk]	),
		.clk_en		(te_clk_en[i_clk]	),
		.clk_in		(gck_dc_clk_in		),
		.test_en	(scan_enable		)
	);

	assign vcore_clk_en[i_clk]		= core_clk_en[i_clk]  & vpu_clk_en[i_clk];
	assign vcore_vlsu_clk_en[i_clk]		= core_clk_en[i_clk]  & vpu_vlsu_clk_en[i_clk];
	assign vcore_valu_clk_en[i_clk]		= core_clk_en[i_clk]  & vpu_valu_clk_en[i_clk];
	assign vcore_vfmis_clk_en[i_clk]	= core_clk_en[i_clk]  & vpu_vfmis_clk_en[i_clk];
	assign vcore_vmac_clk_en[i_clk]		= core_clk_en[i_clk]  & vpu_vmac_clk_en[i_clk];
	assign vcore_vfdiv_clk_en[i_clk]	= core_clk_en[i_clk]  & vpu_vfdiv_clk_en[i_clk];
	assign vcore_vdiv_clk_en[i_clk]		= core_clk_en[i_clk]  & vpu_vdiv_clk_en[i_clk];
	assign vcore_vmask_clk_en[i_clk]	= core_clk_en[i_clk]  & vpu_vmask_clk_en[i_clk];
	assign vcore_vpermut_clk_en[i_clk]	= core_clk_en[i_clk]  & vpu_vpermut_clk_en[i_clk];
	assign vcore_vace_clk_en[i_clk]		= core_clk_en[i_clk]  & vpu_vace_clk_en[i_clk];
	assign vcore_vsp_clk_en[i_clk]		= core_clk_en[i_clk]  & vpu_vsp_clk_en[i_clk];
	gck gck_vpu_clk(
		.clk_out	(vpu_clk[i_clk]		),
		.clk_en		(vcore_clk_en[i_clk]	),
		.clk_in		(core_clk[i_clk]	),
		.test_en	(scan_enable		)
	);
	gck gck_vpu_vlsu_clk(
		.clk_out	(vpu_vlsu_clk[i_clk]	),
		.clk_en		(vcore_vlsu_clk_en[i_clk]),
		.clk_in		(core_clk[i_clk]	),
		.test_en	(scan_enable		)
	);
	gck gck_vpu_valu_clk(
		.clk_out	(vpu_valu_clk[i_clk]	),
		.clk_en		(vcore_valu_clk_en[i_clk]),
		.clk_in		(core_clk[i_clk]	),
		.test_en	(scan_enable		)
	);
	gck gck_vpu_vfmis_clk(
		.clk_out	(vpu_vfmis_clk[i_clk]	),
		.clk_en		(vcore_vfmis_clk_en[i_clk]),
		.clk_in		(core_clk[i_clk]	),
		.test_en	(scan_enable		)
	);
	gck gck_vpu_vmac_clk(
		.clk_out	(vpu_vmac_clk[i_clk]	),
		.clk_en		(vcore_vmac_clk_en[i_clk]),
		.clk_in		(core_clk[i_clk]	),
		.test_en	(scan_enable		)
	);
	gck gck_vpu_vfdiv_clk(
		.clk_out	(vpu_vfdiv_clk[i_clk]	),
		.clk_en		(vcore_vfdiv_clk_en[i_clk]),
		.clk_in		(core_clk[i_clk]	),
		.test_en	(scan_enable		)
	);
	gck gck_vpu_vdiv_clk(
		.clk_out	(vpu_vdiv_clk[i_clk]	),
		.clk_en		(vcore_vdiv_clk_en[i_clk]),
		.clk_in		(core_clk[i_clk]	),
		.test_en	(scan_enable		)
	);
	gck gck_vpu_vmask_clk(
		.clk_out	(vpu_vmask_clk[i_clk]	  ),
		.clk_en		(vcore_vmask_clk_en[i_clk]),
		.clk_in		(core_clk[i_clk]	),
		.test_en	(scan_enable		)
	);
	gck gck_vpu_vpermut_clk(
		.clk_out	(vpu_vpermut_clk[i_clk]	    ),
		.clk_en		(vcore_vpermut_clk_en[i_clk]),
		.clk_in		(core_clk[i_clk]	),
		.test_en	(scan_enable		)
	);
	gck gck_vpu_vace_clk(
		.clk_out	(vpu_vace_clk[i_clk]	),
		.clk_en		(vcore_vace_clk_en[i_clk]),
		.clk_in		(core_clk[i_clk]	),
		.test_en	(scan_enable		)
	);
	gck gck_vpu_vsp_clk(
		.clk_out	(vpu_vsp_clk[i_clk]	),
		.clk_en		(vcore_vsp_clk_en[i_clk]),
		.clk_in		(core_clk[i_clk]	),
		.test_en	(scan_enable		)
	);

	assign l2c_clk_en[i_clk] = (smu_aclk_en & l2c_clkon[i_clk]);
	assign biu_n_clk_en[i_clk] = (smu_aclk_en & biu_clkon[i_clk]);

end
endgenerate

`ifdef NDS_FUSA_SUPPORT
	`ifdef NDS_IO_DCLS
		reg [1:0] dcls_core1_clk_en_delay;
		reg [1:0] dcls_core1_lm_clk_en_delay;
		`ifdef NDS_IO_DFS
		wire dcls_root_clk = dfs_clk_dly[0];
		`else
		wire dcls_root_clk = root_clk_dly;
		`endif

		always @(posedge dcls_root_clk or negedge dcls_r_reset_n) begin
			if (!dcls_r_reset_n) begin
				dcls_core1_clk_en_delay <= 2'd0;
			end
			else begin
				dcls_core1_clk_en_delay <= {dcls_core1_clk_en_delay[0], core_clk_en[0]};
			end
		end
		always @(posedge dcls_root_clk or negedge dcls_r_reset_n) begin
			if (!dcls_r_reset_n) begin
				dcls_core1_lm_clk_en_delay <= 2'd0;
			end
			else begin
				dcls_core1_lm_clk_en_delay <= {dcls_core1_lm_clk_en_delay[0], lm_clk_en[0]};
			end
		end
		wire dcls_p_clk_en = |dcls_core1_lm_clk_en_delay | lm_clk_en[0];
		wire dcls_r_clk_en = |dcls_core1_lm_clk_en_delay | lm_clk_en[0];

		gck gck_dcls_p_clk (
			.clk_out	(dcls_p_clk			),
			.clk_en		(dcls_p_clk_en			),
			.clk_in		(dcls_root_clk			),
			.test_en	(scan_enable			)
		);
		gck gck_dcls_r_clk (
			.clk_out	(dcls_r_clk			),
			.clk_en		(dcls_r_clk_en			),
			.clk_in		(dcls_root_clk			),
			.test_en	(scan_enable			)
		);
		gck gck_dcls_core1_clk (
			.clk_out	(dcls_core1_clk			),
			.clk_en		(dcls_core1_clk_en_delay[1]	),
			.clk_in		(dcls_root_clk			),
			.test_en	(scan_enable			)
		);
		gck gck_dcls_core1_lm_clk (
			.clk_out	(dcls_core1_lm_clk		),
			.clk_en		(dcls_core1_lm_clk_en_delay[1]	),
			.clk_in		(dcls_root_clk			),
			.test_en	(scan_enable			)
		);
		`ifdef NDS_IO_ICACHE0
		assign icache0_p_clk = dcls_root_clk;
		assign icache0_r_clk = dcls_root_clk;
		`ifdef NDS_IO_DCLS_SPLIT
		assign icache1_p_clk = dcls_root_clk;
		assign icache1_r_clk = dcls_root_clk;
		`endif // NDS_IO_DCLS_SPLIT
		`endif // NDS_IO_ICACHE0

		`ifdef NDS_IO_DCACHE0
		assign dcache0_p_clk = dcls_root_clk;
		assign dcache0_r_clk = dcls_root_clk;
		`ifdef NDS_IO_DCLS_SPLIT
		assign dcache1_p_clk = dcls_root_clk;
		assign dcache1_r_clk = dcls_root_clk;
		`endif // NDS_IO_DCLS_SPLIT
		`endif // NDS_IO_DCACHE0
	`endif // NDS_IO_DCLS
`endif // NDS_FUSA_SUPPORT


assign l2_clk_en = (|l2c_clk_en[NHART-1:0]);
assign l2_clk    = l2_clk_src;
gck gck_l2_clk(
	.clk_out	(l2_clk_src		),
	.clk_en		(l2_clk_en        ),
	.clk_in		(root_clk_dly		),
	.test_en	(scan_enable		)
);

assign biu_clk_en = (|biu_n_clk_en[NHART-1:0]);
assign biu_clk    = biu_clk_src;
gck gck_biu_clk(
	.clk_out	(biu_clk_src		),
	.clk_en		(biu_clk_en        ),
	.clk_in		(root_clk_dly		),
	.test_en	(scan_enable		)
);


            `ifdef NDS_IO_DFS
        sample_ae350_dfs_wrapper	ae350_sim_dfs_wrapper (
		  .aclk(aclk),     
		  .aresetn(aresetn),  
		  .aopd_por_dbg_rstn(aopd_por_dbg_rstn),
		  .dfs_awaddr(dfs_awaddr),
		  .dfs_awvalid(dfs_awvalid),
		  .dfs_awready(dfs_awready),
		  .dfs_wdata(dfs_wdata),
		  .dfs_wstrb(dfs_wstrb),
		  .dfs_wvalid(dfs_wvalid),
		  .dfs_wready(dfs_wready),
		  .dfs_bresp(dfs_bresp),
		  .dfs_bvalid(dfs_bvalid),
		  .dfs_bready(dfs_bready),
		  .dfs_araddr(dfs_araddr),
		  .dfs_arvalid(dfs_arvalid),
		  .dfs_arready(dfs_arready),
		  .dfs_rdata(dfs_rdata),
		  .dfs_rresp(dfs_rresp),
		  .dfs_rvalid(dfs_rvalid),
		  .dfs_rready(dfs_rready),
		  .dfs_clk(dfs_clk),  
		  .dfs_locked(dfs_locked),
		  .T_osch(T_osch),   
		  .clk_en_aclk_sync_dfs(clk_en_aclk_sync_dfs)
        );
            assign root_dfs_clk = dfs_clk; 
            `else
            assign root_dfs_clk = {8{root_clk}};
            `endif // NDS_IO_DFS
// VPERL_GENERATED_END
	`endif	// !SYNTHESIS
`endif	// !NDS_FPGA
endmodule
