`include "config.inc"
`include "global.inc"
`include "ae350_config.vh"
`include "ae350_const.vh"

`ifdef NDS_IO_AHB
	`include "vc_bmch_config.vh"
	`include "vc_busdech_config.vh"
`else // NDS_IO_AXI or NDS_IO_ACU
	`include "atcbmc300_config.vh"
	`include "vc_bmcx_config.vh"
	`include "vc_busdecx_config.vh"
`endif
`ifdef NDS_IO_SLAVEPORT
	`include "vc_slvport_busdech_config.vh"
`endif

module ae350_cpu_subsystem (
	// VPERL: &PORTLIST;
	// VPERL_GENERATED_BEGIN
	`ifdef NDS_NHART
		  aclk,     
		  aresetn,  
		  arid,     
		  araddr,   
		  arlen,    
		  arsize,   
		  arburst,  
		  arlock,   
		  arcache,  
		  arprot,   
		  arvalid,  
		  arready,  
		  awid,     
		  awaddr,   
		  awlen,    
		  awsize,   
		  awburst,  
		  awlock,   
		  awcache,  
		  awprot,   
		  awvalid,  
		  awready,  
		  wdata,    
		  wstrb,    
		  wlast,    
		  wvalid,   
		  wready,   
		  bid,      
		  bresp,    
		  bvalid,   
		  bready,   
		  rid,      
		  rdata,    
		  rresp,    
		  rlast,    
		  rvalid,   
		  rready,   
	`endif // NDS_NHART
	`ifdef NDS_IO_TRACE_INSTR_GEN1
		  hart0_gen1_trace_enabled,
		  hart0_gen1_trace_cause,
		  hart0_gen1_trace_iaddr,
		  hart0_gen1_trace_iexception,
		  hart0_gen1_trace_instr,
		  hart0_gen1_trace_interrupt,
		  hart0_gen1_trace_ivalid,
		  hart0_gen1_trace_priv,
		  hart0_gen1_trace_tval,
	`endif // NDS_IO_TRACE_INSTR_GEN1
	`ifdef NDS_IO_TRACE_INSTR
		  hart0_trace_enabled,
		  hart0_trace_cause,
		  hart0_trace_halted,
		  hart0_trace_iaddr,
		  hart0_trace_ilastsize,
		  hart0_trace_iretire,
		  hart0_trace_itype,
		  hart0_trace_priv,
		  hart0_trace_reset,
		  hart0_trace_trigger,
		  hart0_trace_tval,
	`endif // NDS_IO_TRACE_INSTR
	`ifdef NDS_IO_VPU
		  hart0_vc_valu_idle,
		  hart0_vc_vdiv_idle,
		  hart0_vc_vfdiv_idle,
		  hart0_vc_vfmac_idle,
		  hart0_vc_vfmis_idle,
		  hart0_vc_vlsu_idle,
		  hart0_vc_vmac_idle,
		  hart0_vc_vmsk_idle,
		  hart0_vc_vper_idle,
		  hart0_vc_vpu_idle,
	`endif // NDS_IO_VPU
	`ifdef PLATFORM_DEBUG_SUBSYSTEM
		  dmactive, 
		  dmi_haddr,
		  dmi_hburst,
		  dmi_hprot,
		  dmi_hrdata,
		  dmi_hready,
		  dmi_hreadyout,
		  dmi_hresp,
		  dmi_hsel, 
		  dmi_hsize,
		  dmi_htrans,
		  dmi_hwdata,
		  dmi_hwrite,
		  dmi_resetn,
	`endif // PLATFORM_DEBUG_SUBSYSTEM
	`ifdef NDS_NHART
	   `ifdef NDS_IO_HART1
		  hart1_wakeup_event,
		  hart1_reset_vector,
		  hart1_icache_disable_init,
		  hart1_dcache_disable_init,
		  hart1_core_wfi_mode,
		  hart1_nmi,
	   `endif // NDS_IO_HART1
	   `ifdef NDS_IO_HART2
		  hart2_wakeup_event,
		  hart2_reset_vector,
		  hart2_icache_disable_init,
		  hart2_dcache_disable_init,
		  hart2_core_wfi_mode,
		  hart2_nmi,
	   `endif // NDS_IO_HART2
	   `ifdef NDS_IO_HART3
		  hart3_wakeup_event,
		  hart3_reset_vector,
		  hart3_icache_disable_init,
		  hart3_dcache_disable_init,
		  hart3_core_wfi_mode,
		  hart3_nmi,
	   `endif // NDS_IO_HART3
	   `ifdef NDS_IO_L2C
		  axi_bus_clk_en,
		  l2c_err_int,
		  l2c_pcs_standby_ok,
		  pcs_core0_sleep_ok,
		  pcs_core0_sleep_req,
		  pcs_core1_sleep_ok,
		  pcs_core1_sleep_req,
		  pcs_core2_sleep_ok,
		  pcs_core2_sleep_req,
		  pcs_core3_sleep_ok,
		  pcs_core3_sleep_req,
		  l2c_reset_n,
	   `endif // NDS_IO_L2C
	`else
	   `ifdef NDS_IO_AHB
		  ahb_bus_clk_en,
		  hclk,     
		  hresetn,  
	   `endif // NDS_IO_AHB
	`endif // NDS_NHART
	`ifdef NDS_IO_AHB
	   `ifdef NDS_IO_BIU_X2
		  d_haddr,  
		  d_hburst, 
		  d_hprot,  
		  d_hrdata, 
		  d_hready, 
		  d_hresp,  
		  d_hsize,  
		  d_htrans, 
		  d_hwdata, 
		  d_hwrite, 
		  i_haddr,  
		  i_hburst, 
		  i_hprot,  
		  i_hrdata, 
		  i_hready, 
		  i_hresp,  
		  i_hsize,  
		  i_htrans, 
		  i_hwdata, 
		  i_hwrite, 
	   `else
		  haddr,    
		  hburst,   
		  hprot,    
		  hrdata,   
		  hready,   
		  hresp,    
		  hsize,    
		  htrans,   
		  hwdata,   
		  hwrite,   
	   `endif // NDS_IO_BIU_X2
	   `ifdef NDS_IO_SLAVEPORT
		  slv_haddr,
		  slv_hburst,
		  slv_hprot,
		  slv_hrdata,
		  slv_hready,
		  slv_hreadyout,
		  slv_hresp,
		  slv_hsel, 
		  slv_hsize,
		  slv_htrans,
		  slv_hwdata,
		  slv_hwrite,
	   `endif // NDS_IO_SLAVEPORT
	`else
	   `ifdef NDS_NHART
	   `else
		  aclk,     
		  aresetn,  
		  axi_bus_clk_en,
	   `endif // NDS_NHART
	   `ifdef NDS_IO_SLAVEPORT
		  slv_araddr,
		  slv_arburst,
		  slv_arcache,
		  slv_arid, 
		  slv_arlen,
		  slv_arlock,
		  slv_arprot,
		  slv_arready,
		  slv_arsize,
		  slv_arvalid,
		  slv_awaddr,
		  slv_awburst,
		  slv_awcache,
		  slv_awid, 
		  slv_awlen,
		  slv_awlock,
		  slv_awprot,
		  slv_awready,
		  slv_awsize,
		  slv_awvalid,
		  slv_bid,  
		  slv_bready,
		  slv_bresp,
		  slv_bvalid,
		  slv_rdata,
		  slv_rid,  
		  slv_rlast,
		  slv_rready,
		  slv_rresp,
		  slv_rvalid,
		  slv_wdata,
		  slv_wlast,
		  slv_wready,
		  slv_wstrb,
		  slv_wvalid,
	   `endif // NDS_IO_SLAVEPORT
	`endif // NDS_IO_AHB
	`ifdef NDS_NHART
	   `ifdef NDS_IO_TRACE_INSTR_GEN1
	      `ifdef NDS_IO_HART1
		  hart1_gen1_trace_enabled,
		  hart1_gen1_trace_cause,
		  hart1_gen1_trace_iaddr,
		  hart1_gen1_trace_iexception,
		  hart1_gen1_trace_instr,
		  hart1_gen1_trace_interrupt,
		  hart1_gen1_trace_ivalid,
		  hart1_gen1_trace_priv,
		  hart1_gen1_trace_tval,
	      `endif // NDS_IO_HART1
	   `endif // NDS_IO_TRACE_INSTR_GEN1
	   `ifdef NDS_IO_TRACE_INSTR
	      `ifdef NDS_IO_HART1
		  hart1_trace_enabled,
		  hart1_trace_cause,
		  hart1_trace_halted,
		  hart1_trace_iaddr,
		  hart1_trace_ilastsize,
		  hart1_trace_iretire,
		  hart1_trace_itype,
		  hart1_trace_priv,
		  hart1_trace_reset,
		  hart1_trace_trigger,
		  hart1_trace_tval,
	      `endif // NDS_IO_HART1
	   `endif // NDS_IO_TRACE_INSTR
	   `ifdef NDS_IO_VPU
	      `ifdef NDS_IO_HART1
		  hart1_vc_valu_idle,
		  hart1_vc_vdiv_idle,
		  hart1_vc_vfdiv_idle,
		  hart1_vc_vfmac_idle,
		  hart1_vc_vfmis_idle,
		  hart1_vc_vlsu_idle,
		  hart1_vc_vmac_idle,
		  hart1_vc_vmsk_idle,
		  hart1_vc_vper_idle,
		  hart1_vc_vpu_idle,
	      `endif // NDS_IO_HART1
	   `endif // NDS_IO_VPU
	   `ifdef NDS_IO_TRACE_INSTR_GEN1
	      `ifdef NDS_IO_HART2
		  hart2_gen1_trace_enabled,
		  hart2_gen1_trace_cause,
		  hart2_gen1_trace_iaddr,
		  hart2_gen1_trace_iexception,
		  hart2_gen1_trace_instr,
		  hart2_gen1_trace_interrupt,
		  hart2_gen1_trace_ivalid,
		  hart2_gen1_trace_priv,
		  hart2_gen1_trace_tval,
	      `endif // NDS_IO_HART2
	   `endif // NDS_IO_TRACE_INSTR_GEN1
	   `ifdef NDS_IO_TRACE_INSTR
	      `ifdef NDS_IO_HART2
		  hart2_trace_enabled,
		  hart2_trace_cause,
		  hart2_trace_halted,
		  hart2_trace_iaddr,
		  hart2_trace_ilastsize,
		  hart2_trace_iretire,
		  hart2_trace_itype,
		  hart2_trace_priv,
		  hart2_trace_reset,
		  hart2_trace_trigger,
		  hart2_trace_tval,
	      `endif // NDS_IO_HART2
	   `endif // NDS_IO_TRACE_INSTR
	   `ifdef NDS_IO_VPU
	      `ifdef NDS_IO_HART2
		  hart2_vc_valu_idle,
		  hart2_vc_vdiv_idle,
		  hart2_vc_vfdiv_idle,
		  hart2_vc_vfmac_idle,
		  hart2_vc_vfmis_idle,
		  hart2_vc_vlsu_idle,
		  hart2_vc_vmac_idle,
		  hart2_vc_vmsk_idle,
		  hart2_vc_vper_idle,
		  hart2_vc_vpu_idle,
	      `endif // NDS_IO_HART2
	   `endif // NDS_IO_VPU
	   `ifdef NDS_IO_TRACE_INSTR_GEN1
	      `ifdef NDS_IO_HART3
		  hart3_gen1_trace_enabled,
		  hart3_gen1_trace_cause,
		  hart3_gen1_trace_iaddr,
		  hart3_gen1_trace_iexception,
		  hart3_gen1_trace_instr,
		  hart3_gen1_trace_interrupt,
		  hart3_gen1_trace_ivalid,
		  hart3_gen1_trace_priv,
		  hart3_gen1_trace_tval,
	      `endif // NDS_IO_HART3
	   `endif // NDS_IO_TRACE_INSTR_GEN1
	   `ifdef NDS_IO_TRACE_INSTR
	      `ifdef NDS_IO_HART3
		  hart3_trace_enabled,
		  hart3_trace_cause,
		  hart3_trace_halted,
		  hart3_trace_iaddr,
		  hart3_trace_ilastsize,
		  hart3_trace_iretire,
		  hart3_trace_itype,
		  hart3_trace_priv,
		  hart3_trace_reset,
		  hart3_trace_trigger,
		  hart3_trace_tval,
	      `endif // NDS_IO_HART3
	   `endif // NDS_IO_TRACE_INSTR
	   `ifdef NDS_IO_VPU
	      `ifdef NDS_IO_HART3
		  hart3_vc_valu_idle,
		  hart3_vc_vdiv_idle,
		  hart3_vc_vfdiv_idle,
		  hart3_vc_vfmac_idle,
		  hart3_vc_vfmis_idle,
		  hart3_vc_vlsu_idle,
		  hart3_vc_vmac_idle,
		  hart3_vc_vmsk_idle,
		  hart3_vc_vper_idle,
		  hart3_vc_vpu_idle,
	      `endif // NDS_IO_HART3
	   `endif // NDS_IO_VPU
	   `ifdef NDS_IO_L2C
	      `ifdef NDS_IO_L2C_IO_COHERENCE
		  m4_araddr,
		  m4_awaddr,
		  m4_arburst,
		  m4_arcache,
		  m4_arid,  
		  m4_arlen, 
		  m4_arlock,
		  m4_arprot,
		  m4_arready,
		  m4_arsize,
		  m4_arvalid,
		  m4_awburst,
		  m4_awcache,
		  m4_awid,  
		  m4_awlen, 
		  m4_awlock,
		  m4_awprot,
		  m4_awready,
		  m4_awsize,
		  m4_awvalid,
		  m4_bid,   
		  m4_bready,
		  m4_bresp, 
		  m4_bvalid,
		  m4_clk_en,
		  m4_rdata, 
		  m4_rid,   
		  m4_rlast, 
		  m4_rready,
		  m4_rresp, 
		  m4_rvalid,
		  m4_wdata, 
		  m4_wlast, 
		  m4_wready,
		  m4_wstrb, 
		  m4_wvalid,
	      `endif // NDS_IO_L2C_IO_COHERENCE
	      `ifdef NDS_IO_L2C_IO_SLV
		  l2c_io_araddr,
		  l2c_io_arburst,
		  l2c_io_arcache,
		  l2c_io_arid,
		  l2c_io_arlen,
		  l2c_io_arlock,
		  l2c_io_arprot,
		  l2c_io_arready,
		  l2c_io_arsize,
		  l2c_io_arvalid,
		  l2c_io_awaddr,
		  l2c_io_awburst,
		  l2c_io_awcache,
		  l2c_io_awid,
		  l2c_io_awlen,
		  l2c_io_awlock,
		  l2c_io_awprot,
		  l2c_io_awready,
		  l2c_io_awsize,
		  l2c_io_awvalid,
		  l2c_io_bid,
		  l2c_io_bready,
		  l2c_io_bresp,
		  l2c_io_bvalid,
		  l2c_io_rdata,
		  l2c_io_rid,
		  l2c_io_rlast,
		  l2c_io_rready,
		  l2c_io_rresp,
		  l2c_io_rvalid,
		  l2c_io_wdata,
		  l2c_io_wlast,
		  l2c_io_wready,
		  l2c_io_wstrb,
		  l2c_io_wvalid,
	      `endif // NDS_IO_L2C_IO_SLV
	   `endif // NDS_IO_L2C
	`endif // NDS_NHART
	`ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
	   `ifdef PLATFORM_DEBUG_SUBSYSTEM
	      `ifdef NDS_IO_AHB
		  dm_sys_haddr,
		  dm_sys_hburst,
		  dm_sys_hbusreq,
		  dm_sys_hgrant,
		  dm_sys_hprot,
		  dm_sys_hrdata,
		  dm_sys_hready,
		  dm_sys_hresp,
		  dm_sys_hsize,
		  dm_sys_htrans,
		  dm_sys_hwdata,
		  dm_sys_hwrite,
	      `endif // NDS_IO_AHB
	   `endif // PLATFORM_DEBUG_SUBSYSTEM
	`endif // PLATFORM_PLDM_SYS_BUS_ACCESS
	`ifdef NDS_NHART
	`else
	   `ifdef NDS_IO_AHB
	   `else
	      `ifdef NDS_IO_BIU_X2
		  i_arid,   
		  i_araddr, 
		  i_arlen,  
		  i_arsize, 
		  i_arburst,
		  i_arlock, 
		  i_arcache,
		  i_arprot, 
		  i_arvalid,
		  i_arready,
		  i_awid,   
		  i_awaddr, 
		  i_awlen,  
		  i_awsize, 
		  i_awburst,
		  i_awlock, 
		  i_awcache,
		  i_awprot, 
		  i_awvalid,
		  i_awready,
		  i_wdata,  
		  i_wstrb,  
		  i_wlast,  
		  i_wvalid, 
		  i_wready, 
		  i_bid,    
		  i_bresp,  
		  i_bvalid, 
		  i_bready, 
		  i_rid,    
		  i_rdata,  
		  i_rresp,  
		  i_rlast,  
		  i_rvalid, 
		  i_rready, 
		  d_arid,   
		  d_araddr, 
		  d_arlen,  
		  d_arsize, 
		  d_arburst,
		  d_arlock, 
		  d_arcache,
		  d_arprot, 
		  d_arvalid,
		  d_arready,
		  d_awid,   
		  d_awaddr, 
		  d_awlen,  
		  d_awsize, 
		  d_awburst,
		  d_awlock, 
		  d_awcache,
		  d_awprot, 
		  d_awvalid,
		  d_awready,
		  d_wdata,  
		  d_wstrb,  
		  d_wlast,  
		  d_wvalid, 
		  d_wready, 
		  d_bid,    
		  d_bresp,  
		  d_bvalid, 
		  d_bready, 
		  d_rid,    
		  d_rdata,  
		  d_rresp,  
		  d_rlast,  
		  d_rvalid, 
		  d_rready, 
	      `else
		  arid,     
		  araddr,   
		  arlen,    
		  arsize,   
		  arburst,  
		  arlock,   
		  arcache,  
		  arprot,   
		  arvalid,  
		  arready,  
		  awid,     
		  awaddr,   
		  awlen,    
		  awsize,   
		  awburst,  
		  awlock,   
		  awcache,  
		  awprot,   
		  awvalid,  
		  awready,  
		  wdata,    
		  wstrb,    
		  wlast,    
		  wvalid,   
		  wready,   
		  bid,      
		  bresp,    
		  bvalid,   
		  bready,   
		  rid,      
		  rdata,    
		  rresp,    
		  rlast,    
		  rvalid,   
		  rready,   
	      `endif // NDS_IO_BIU_X2
	   `endif // NDS_IO_AHB
	`endif // NDS_NHART
	`ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
	   `ifdef PLATFORM_DEBUG_SUBSYSTEM
	      `ifdef NDS_IO_AHB
	      `else
		  dm_sys_araddr,
		  dm_sys_arburst,
		  dm_sys_arcache,
		  dm_sys_arid,
		  dm_sys_arlen,
		  dm_sys_arlock,
		  dm_sys_arprot,
		  dm_sys_arready,
		  dm_sys_arsize,
		  dm_sys_arvalid,
		  dm_sys_awaddr,
		  dm_sys_awburst,
		  dm_sys_awcache,
		  dm_sys_awid,
		  dm_sys_awlen,
		  dm_sys_awlock,
		  dm_sys_awprot,
		  dm_sys_awready,
		  dm_sys_awsize,
		  dm_sys_awvalid,
		  dm_sys_bid,
		  dm_sys_bready,
		  dm_sys_bresp,
		  dm_sys_bvalid,
		  dm_sys_rdata,
		  dm_sys_rid,
		  dm_sys_rlast,
		  dm_sys_rready,
		  dm_sys_rresp,
		  dm_sys_rvalid,
		  dm_sys_wdata,
		  dm_sys_wlast,
		  dm_sys_wready,
		  dm_sys_wstrb,
		  dm_sys_wvalid,
	      `endif // NDS_IO_AHB
	   `endif // PLATFORM_DEBUG_SUBSYSTEM
	`endif // PLATFORM_PLDM_SYS_BUS_ACCESS
	`ifdef NDS_NHART
	`else
	   `ifdef NDS_IO_DLM_AHBLITE
	      `ifdef PLATFORM_DLM_AHBLITE_USE_SYNCDN
		  pclk,     
		  apb2ahb_clken,
	      `endif // PLATFORM_DLM_AHBLITE_USE_SYNCDN
	   `endif // NDS_IO_DLM_AHBLITE
	   `ifdef NDS_IO_ACE_VPU
	      `ifdef NDS_CUSTOM_ACE_VPU
		  cp_cpu_rdata, // load data from ACE ifc logic
		  cp_cpu_rdata_ready, // load ready from ACE ifc logic
		  cp_cpu_rdata_valid, // load data from ACE ifc logic
		  cpu_cp_wdata, // store data to ACE ifc logic
		  cpu_cp_wdata_bwe, // store byte enable to ACE ifc logic
		  cpu_cp_wdata_ready, // store ready from ACE ifc logic
		  cpu_cp_wdata_valid, // store valid to ACE ifc logic
	      `endif // NDS_CUSTOM_ACE_VPU
	   `endif // NDS_IO_ACE_VPU
	`endif // NDS_NHART
	`ifdef NDS_NHART
	   `ifdef NDS_IO_L2C
		  core0_wfi_sel_iso,
		  core1_wfi_sel_iso,
		  core2_wfi_sel_iso,
		  core3_wfi_sel_iso,
	   `endif // NDS_IO_L2C
	`endif // NDS_NHART
		  core_clk, 
		  core_resetn,
		  dbg_srst_req,
		  dc_clk,   
		  hart0_wakeup_event,
		  lm_clk,   
		  int_src,   // From Source (e.g. devices)
		  mtime_clk, // clock domain b_clk
		  por_rstn, 
		  scan_enable,
		  test_mode,
		  test_rstn,
		  hart0_reset_vector,
		  hart0_icache_disable_init,
		  hart0_dcache_disable_init,
		  hart0_core_wfi_mode,
		  hart0_nmi 
	// VPERL_GENERATED_END
);

localparam PALEN			= `NDS_BIU_ADDR_WIDTH;
localparam BIU_ADDR_WIDTH		= `NDS_BIU_ADDR_WIDTH;
localparam BIU_ADDR_MSB		= BIU_ADDR_WIDTH - 1;
localparam ISA_BASE			= `NDS_ISA_BASE;
localparam XLEN			= ISA_BASE == "rv64i" ? 64 : 32;
localparam MMU_SCHEME			= `NDS_MMU_SCHEME;
localparam VALEN			= (MMU_SCHEME == "bare") ? PALEN : (MMU_SCHEME == "sv32") ? 32 : (MMU_SCHEME == "sv39") ? 39: 48;
`ifdef PLATFORM_FORCE_4GB_SPACE
localparam ADDR_WIDTH			= 32;
`else
localparam ADDR_WIDTH			= PALEN;
`endif // PLATFORM_FORCE_4GB_SPACE
localparam ADDR_MSB			= ADDR_WIDTH - 1;
localparam CPUCORE_BIU_ID_WIDTH	= `NDS_BIU_ID_WIDTH;
localparam CPUCORE_BIU_ID_MSB		= CPUCORE_BIU_ID_WIDTH - 1;
localparam CPUCORE_BIU_DATA_WIDTH	= `NDS_BIU_DATA_WIDTH;
localparam CPUCORE_BIU_DATA_MSB	= CPUCORE_BIU_DATA_WIDTH - 1;
localparam CPUCORE_BIU_WSTRB_WIDTH	= CPUCORE_BIU_DATA_WIDTH / 8;
localparam CPUCORE_BIU_WSTRB_MSB	= CPUCORE_BIU_WSTRB_WIDTH - 1;
`ifdef NDS_NHART
localparam CPUSUB_BIU_DATA_WIDTH	= `NDS_L2C_BIU_DATA_WIDTH;
   `ifdef NDS_SNOOP_DISABLED
localparam CPUSUB_BIU_ID_WIDTH	= `NDS_BIU_ID_WIDTH;
   `else
localparam CPUSUB_BIU_ID_WIDTH	= `NDS_BIU_ID_WIDTH + 3;
   `endif // NDS_SNOOP_DISABLED
localparam MAC_DATA_WIDTH		= `NDS_BIU_DATA_WIDTH;
`else
localparam CPUSUB_BIU_DATA_WIDTH		= `NDS_BIU_DATA_WIDTH;
localparam CPUSUB_BIU_ID_WIDTH		= `NDS_BIU_ID_WIDTH;
`endif // NDS_NHART
localparam CPUSUB_BIU_ID_MSB		= CPUSUB_BIU_ID_WIDTH - 1;
localparam CPUSUB_BIU_DATA_MSB	= CPUSUB_BIU_DATA_WIDTH - 1;
localparam CPUSUB_BIU_WSTRB_WIDTH	= CPUSUB_BIU_DATA_WIDTH / 8;
localparam CPUSUB_BIU_WSTRB_MSB	= CPUSUB_BIU_WSTRB_WIDTH - 1;
localparam SLVPORT_DATA_WIDTH		= `NDS_SLAVE_PORT_DATA_WIDTH;
localparam SLVPORT_DATA_MSB		= SLVPORT_DATA_WIDTH - 1;
localparam SLVPORT_WSTRB_WIDTH	= SLVPORT_DATA_WIDTH / 8;
localparam SLVPORT_WSTRB_MSB		= SLVPORT_WSTRB_WIDTH - 1;
`ifdef AE350_AXI_SUPPORT
localparam SYSTEM_BUS_TYPE		= "axi";
`else
localparam SYSTEM_BUS_TYPE		= "ahb";
`endif // AE350_AXI_SUPPORT
`ifdef AE350_AXI_SUPPORT
localparam ROMHBMC_DATA_WIDTH	= 32;
`else
localparam ROMHBMC_DATA_WIDTH	= CPUSUB_BIU_DATA_WIDTH;
`endif // AE350_AXI_SUPPORT
localparam ROMHBMC_DATA_MSB		= ROMHBMC_DATA_WIDTH - 1;
`ifdef NDS_ASP_DATA_WIDTH
localparam ASP_DATA_WIDTH		= `NDS_ASP_DATA_WIDTH;
localparam ASP_BWE_WIDTH  = ASP_DATA_WIDTH/8;
`endif // NDS_ASP_DATA_WIDTH
`ifdef PLATFORM_SLVPORT_DLM_SEL_BIT
localparam SLVPORT_DLM_SEL_BIT	= `PLATFORM_SLVPORT_DLM_SEL_BIT;
`else
localparam SLVPORT_DLM_SEL_BIT	= 21;
`endif // PLATFORM_SLVPORT_DLM_SEL_BIT
localparam RESET_VECTOR_WIDTH	= (VALEN > 32) ? 64 : 32;
localparam SDN2BUSDEC_ID_WIDTH	= CPUSUB_BIU_ID_WIDTH;
localparam SLVPORT_ID_WIDTH	= CPUSUB_BIU_ID_WIDTH;
localparam SDN2BUSDEC_ID_MSB	= SDN2BUSDEC_ID_WIDTH - 1;
localparam SLVPORT_ID_MSB		= SLVPORT_ID_WIDTH - 1;
`ifdef NDS_BOARD_CF1
localparam INT_NUM                  = 32;
`else
localparam INT_NUM                  = 31;
`endif // NDS_BOARD_CF1
localparam VECTOR_PLIC_SUPPORT	= `NDS_VECTOR_PLIC_SUPPORT;
localparam NCE_DATA_WIDTH		= (CPUSUB_BIU_DATA_WIDTH > 64) ? 64 : CPUSUB_BIU_DATA_WIDTH;
localparam NCE_DATA_MSB		= (NCE_DATA_WIDTH-1);
localparam NCE_WSTRB_WIDTH		= (NCE_DATA_WIDTH/8);
localparam NCE_WSTRB_MSB		= (NCE_WSTRB_WIDTH-1);
localparam DM_SYS_DATA_WIDTH	= (CPUSUB_BIU_DATA_WIDTH > 128) ? 128 : CPUSUB_BIU_DATA_WIDTH;
localparam DM_SYS_DATA_MSB		= (DM_SYS_DATA_WIDTH-1);
localparam DM_SYS_WSTRB_WIDTH	= (DM_SYS_DATA_WIDTH/8);
localparam DM_SYS_WSTRB_MSB		= (DM_SYS_WSTRB_WIDTH-1);
localparam SIZEUP_DS_DATA_WIDTH     = CPUSUB_BIU_DATA_WIDTH;
localparam SIZEUP_DS_DATA_SIZE      = $clog2(SIZEUP_DS_DATA_WIDTH) - 3;
localparam SIZEUP_ADDR_WIDTH	= SIZEUP_DS_DATA_SIZE;
localparam SIZEUP_ADDR_MSB		= (SIZEUP_ADDR_WIDTH-1);
`ifdef NDS_NHART
localparam NHART                    = `NDS_NHART;
`else
localparam NHART                    = 1;
`endif // NDS_NHART
localparam DLM_RAM_AW		= `NDS_DLM_RAM_AW;
localparam DLM_RAM_DW		= `NDS_DLM_RAM_DW;
localparam DLM_RAM_BWEW		= `NDS_DLM_RAM_BWEW;
localparam ILM_RAM_AW		= `NDS_ILM_RAM_AW;
localparam ILM_RAM_DW		= `NDS_ILM_RAM_DW;
localparam ILM_RAM_BWEW		= `NDS_ILM_RAM_BWEW;
localparam [4:0] PLIC_HW_TARGET_NUM = NHART*2;
localparam [4:0] PLIC_SW_TARGET_NUM = NHART;
localparam ILM_HDATA_WIDTH		= XLEN;
localparam DLM_HDATA_WIDTH		= XLEN;
localparam PROGBUF_SIZE	= `PLATFORM_PLDM_PROGBUF_SIZE;
localparam HALTGROUP_COUNT  = `PLATFORM_PLDM_HALTGROUP_COUNT;
`ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
localparam PLDM_SYS_BUS_ACCESS        = "yes";
`else
localparam PLDM_SYS_BUS_ACCESS        = "no";
`endif // PLATFORM_PLDM_SYS_BUS_ACCESS
`ifdef NDS_NHART
   `ifdef NDS_L2C_DISABLE_INIT
localparam L2C_DISABLE_INIT = 1'b1;
   `else
localparam L2C_DISABLE_INIT = 1'b0;
   `endif // NDS_L2C_DISABLE_INIT
`endif // NDS_NHART


`ifdef NDS_NHART
input                                      aclk;
input                                      aresetn;
output               [CPUSUB_BIU_ID_MSB:0] arid;
output                        [ADDR_MSB:0] araddr;
output                               [7:0] arlen;
output                               [2:0] arsize;
output                               [1:0] arburst;
output                                     arlock;
output                               [3:0] arcache;
output                               [2:0] arprot;
output                                     arvalid;
input                                      arready;
output               [CPUSUB_BIU_ID_MSB:0] awid;
output                        [ADDR_MSB:0] awaddr;
output                               [7:0] awlen;
output                               [2:0] awsize;
output                               [1:0] awburst;
output                                     awlock;
output                               [3:0] awcache;
output                               [2:0] awprot;
output                                     awvalid;
input                                      awready;
output              [(BIU_DATA_WIDTH-1):0] wdata;
output          [((BIU_DATA_WIDTH/8)-1):0] wstrb;
output                                     wlast;
output                                     wvalid;
input                                      wready;
input                [CPUSUB_BIU_ID_MSB:0] bid;
input                                [1:0] bresp;
input                                      bvalid;
output                                     bready;
input                [CPUSUB_BIU_ID_MSB:0] rid;
input               [(BIU_DATA_WIDTH-1):0] rdata;
input                                [1:0] rresp;
input                                      rlast;
input                                      rvalid;
output                                     rready;
`endif // NDS_NHART
`ifdef NDS_IO_TRACE_INSTR_GEN1
output                                     hart0_gen1_trace_enabled;
output                               [9:0] hart0_gen1_trace_cause;
output                  [(`NDS_VALEN-1):0] hart0_gen1_trace_iaddr;
output                                     hart0_gen1_trace_iexception;
output                              [31:0] hart0_gen1_trace_instr;
output                                     hart0_gen1_trace_interrupt;
output                                     hart0_gen1_trace_ivalid;
output                               [2:0] hart0_gen1_trace_priv;
output                   [(`NDS_XLEN-1):0] hart0_gen1_trace_tval;
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
input                                      hart0_trace_enabled;
output                               [9:0] hart0_trace_cause;
output                                     hart0_trace_halted;
output                [((`NDS_VALEN)-1):0] hart0_trace_iaddr;
output                                     hart0_trace_ilastsize;
output                               [1:0] hart0_trace_iretire;
output                               [3:0] hart0_trace_itype;
output                               [1:0] hart0_trace_priv;
output                                     hart0_trace_reset;
output                               [2:0] hart0_trace_trigger;
output                 [((`NDS_XLEN)-1):0] hart0_trace_tval;
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_VPU
output                                     hart0_vc_valu_idle;
output                                     hart0_vc_vdiv_idle;
output                                     hart0_vc_vfdiv_idle;
output                                     hart0_vc_vfmac_idle;
output                                     hart0_vc_vfmis_idle;
output                                     hart0_vc_vlsu_idle;
output                                     hart0_vc_vmac_idle;
output                                     hart0_vc_vmsk_idle;
output                                     hart0_vc_vper_idle;
output                                     hart0_vc_vpu_idle;
`endif // NDS_IO_VPU
`ifdef PLATFORM_DEBUG_SUBSYSTEM
output                                     dmactive;
input                                [8:0] dmi_haddr;
input                                [2:0] dmi_hburst;
input                                [3:0] dmi_hprot;
output                              [31:0] dmi_hrdata;
input                                      dmi_hready;
output                                     dmi_hreadyout;
output                               [1:0] dmi_hresp;
input                                      dmi_hsel;
input                                [2:0] dmi_hsize;
input                                [1:0] dmi_htrans;
input                               [31:0] dmi_hwdata;
input                                      dmi_hwrite;
input                                      dmi_resetn;
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_NHART
   `ifdef NDS_IO_HART1
output                               [5:0] hart1_wakeup_event;
input                        [(VALEN-1):0] hart1_reset_vector;
input                                      hart1_icache_disable_init;
input                                      hart1_dcache_disable_init;
output                                     hart1_core_wfi_mode;
input                                      hart1_nmi;
   `endif // NDS_IO_HART1
   `ifdef NDS_IO_HART2
output                               [5:0] hart2_wakeup_event;
input                        [(VALEN-1):0] hart2_reset_vector;
input                                      hart2_icache_disable_init;
input                                      hart2_dcache_disable_init;
output                                     hart2_core_wfi_mode;
input                                      hart2_nmi;
   `endif // NDS_IO_HART2
   `ifdef NDS_IO_HART3
output                               [5:0] hart3_wakeup_event;
input                        [(VALEN-1):0] hart3_reset_vector;
input                                      hart3_icache_disable_init;
input                                      hart3_dcache_disable_init;
output                                     hart3_core_wfi_mode;
input                                      hart3_nmi;
   `endif // NDS_IO_HART3
   `ifdef NDS_IO_L2C
input                                      axi_bus_clk_en;
output                                     l2c_err_int;
output                                     l2c_pcs_standby_ok;
output                                     pcs_core0_sleep_ok;
input                                      pcs_core0_sleep_req;
output                                     pcs_core1_sleep_ok;
input                                      pcs_core1_sleep_req;
output                                     pcs_core2_sleep_ok;
input                                      pcs_core2_sleep_req;
output                                     pcs_core3_sleep_ok;
input                                      pcs_core3_sleep_req;
input                                      l2c_reset_n;
   `endif // NDS_IO_L2C
`else
   `ifdef NDS_IO_AHB
input                                      ahb_bus_clk_en;
input                                      hclk;
input                                      hresetn;
   `endif // NDS_IO_AHB
`endif // NDS_NHART
`ifdef NDS_IO_AHB
   `ifdef NDS_IO_BIU_X2
output                        [ADDR_MSB:0] d_haddr;
output                               [2:0] d_hburst;
output                               [3:0] d_hprot;
input               [(BIU_DATA_WIDTH-1):0] d_hrdata;
input                                      d_hready;
input                                [1:0] d_hresp;
output                               [2:0] d_hsize;
output                               [1:0] d_htrans;
output              [(BIU_DATA_WIDTH-1):0] d_hwdata;
output                                     d_hwrite;
output                        [ADDR_MSB:0] i_haddr;
output                               [2:0] i_hburst;
output                               [3:0] i_hprot;
input               [(BIU_DATA_WIDTH-1):0] i_hrdata;
input                                      i_hready;
input                                [1:0] i_hresp;
output                               [2:0] i_hsize;
output                               [1:0] i_htrans;
output              [(BIU_DATA_WIDTH-1):0] i_hwdata;
output                                     i_hwrite;
   `else
output                        [ADDR_MSB:0] haddr;
output                               [2:0] hburst;
output                               [3:0] hprot;
input               [(BIU_DATA_WIDTH-1):0] hrdata;
input                                      hready;
input                                [1:0] hresp;
output                               [2:0] hsize;
output                               [1:0] htrans;
output              [(BIU_DATA_WIDTH-1):0] hwdata;
output                                     hwrite;
   `endif // NDS_IO_BIU_X2
   `ifdef NDS_IO_SLAVEPORT
input                         [ADDR_MSB:0] slv_haddr;
input                                [2:0] slv_hburst;
input                                [3:0] slv_hprot;
output          [(SLVPORT_DATA_WIDTH-1):0] slv_hrdata;
input                                      slv_hready;
output                                     slv_hreadyout;
output                               [1:0] slv_hresp;
input                                      slv_hsel;
input                                [2:0] slv_hsize;
input                                [1:0] slv_htrans;
input           [(SLVPORT_DATA_WIDTH-1):0] slv_hwdata;
input                                      slv_hwrite;
   `endif // NDS_IO_SLAVEPORT
`else
   `ifdef NDS_NHART
   `else
input                                      aclk;
input                                      aresetn;
input                                      axi_bus_clk_en;
   `endif // NDS_NHART
   `ifdef NDS_IO_SLAVEPORT
input                         [ADDR_MSB:0] slv_araddr;
input                                [1:0] slv_arburst;
input                                [3:0] slv_arcache;
input            [(CPUSUB_BIU_ID_MSB+4):0] slv_arid;
input                                [7:0] slv_arlen;
input                                      slv_arlock;
input                                [2:0] slv_arprot;
output                                     slv_arready;
input                                [2:0] slv_arsize;
input                                      slv_arvalid;
input                         [ADDR_MSB:0] slv_awaddr;
input                                [1:0] slv_awburst;
input                                [3:0] slv_awcache;
input            [(CPUSUB_BIU_ID_MSB+4):0] slv_awid;
input                                [7:0] slv_awlen;
input                                      slv_awlock;
input                                [2:0] slv_awprot;
output                                     slv_awready;
input                                [2:0] slv_awsize;
input                                      slv_awvalid;
output           [(CPUSUB_BIU_ID_MSB+4):0] slv_bid;
input                                      slv_bready;
output                               [1:0] slv_bresp;
output                                     slv_bvalid;
output          [(SLVPORT_DATA_WIDTH-1):0] slv_rdata;
output           [(CPUSUB_BIU_ID_MSB+4):0] slv_rid;
output                                     slv_rlast;
input                                      slv_rready;
output                               [1:0] slv_rresp;
output                                     slv_rvalid;
input           [(SLVPORT_DATA_WIDTH-1):0] slv_wdata;
input                                      slv_wlast;
output                                     slv_wready;
input       [((SLVPORT_DATA_WIDTH/8)-1):0] slv_wstrb;
input                                      slv_wvalid;
   `endif // NDS_IO_SLAVEPORT
`endif // NDS_IO_AHB
`ifdef NDS_NHART
   `ifdef NDS_IO_HART1
      `ifdef NDS_IO_TRACE_INSTR_GEN1
input                                      hart1_gen1_trace_enabled;
output                               [9:0] hart1_gen1_trace_cause;
output                  [(`NDS_VALEN-1):0] hart1_gen1_trace_iaddr;
output                                     hart1_gen1_trace_iexception;
output                              [31:0] hart1_gen1_trace_instr;
output                                     hart1_gen1_trace_interrupt;
output                                     hart1_gen1_trace_ivalid;
output                               [2:0] hart1_gen1_trace_priv;
output                   [(`NDS_XLEN-1):0] hart1_gen1_trace_tval;
      `endif // NDS_IO_TRACE_INSTR_GEN1
      `ifdef NDS_IO_TRACE_INSTR
input                                      hart1_trace_enabled;
output                               [9:0] hart1_trace_cause;
output                                     hart1_trace_halted;
output                [((`NDS_VALEN)-1):0] hart1_trace_iaddr;
output                                     hart1_trace_ilastsize;
output                               [1:0] hart1_trace_iretire;
output                               [3:0] hart1_trace_itype;
output                               [1:0] hart1_trace_priv;
output                                     hart1_trace_reset;
output                               [2:0] hart1_trace_trigger;
output                 [((`NDS_XLEN)-1):0] hart1_trace_tval;
      `endif // NDS_IO_TRACE_INSTR
      `ifdef NDS_IO_VPU
output                                     hart1_vc_valu_idle;
output                                     hart1_vc_vdiv_idle;
output                                     hart1_vc_vfdiv_idle;
output                                     hart1_vc_vfmac_idle;
output                                     hart1_vc_vfmis_idle;
output                                     hart1_vc_vlsu_idle;
output                                     hart1_vc_vmac_idle;
output                                     hart1_vc_vmsk_idle;
output                                     hart1_vc_vper_idle;
output                                     hart1_vc_vpu_idle;
      `endif // NDS_IO_VPU
   `endif // NDS_IO_HART1
   `ifdef NDS_IO_HART2
      `ifdef NDS_IO_TRACE_INSTR_GEN1
input                                      hart2_gen1_trace_enabled;
output                               [9:0] hart2_gen1_trace_cause;
output                  [(`NDS_VALEN-1):0] hart2_gen1_trace_iaddr;
output                                     hart2_gen1_trace_iexception;
output                              [31:0] hart2_gen1_trace_instr;
output                                     hart2_gen1_trace_interrupt;
output                                     hart2_gen1_trace_ivalid;
output                               [2:0] hart2_gen1_trace_priv;
output                   [(`NDS_XLEN-1):0] hart2_gen1_trace_tval;
      `endif // NDS_IO_TRACE_INSTR_GEN1
      `ifdef NDS_IO_TRACE_INSTR
input                                      hart2_trace_enabled;
output                               [9:0] hart2_trace_cause;
output                                     hart2_trace_halted;
output                [((`NDS_VALEN)-1):0] hart2_trace_iaddr;
output                                     hart2_trace_ilastsize;
output                               [1:0] hart2_trace_iretire;
output                               [3:0] hart2_trace_itype;
output                               [1:0] hart2_trace_priv;
output                                     hart2_trace_reset;
output                               [2:0] hart2_trace_trigger;
output                 [((`NDS_XLEN)-1):0] hart2_trace_tval;
      `endif // NDS_IO_TRACE_INSTR
      `ifdef NDS_IO_VPU
output                                     hart2_vc_valu_idle;
output                                     hart2_vc_vdiv_idle;
output                                     hart2_vc_vfdiv_idle;
output                                     hart2_vc_vfmac_idle;
output                                     hart2_vc_vfmis_idle;
output                                     hart2_vc_vlsu_idle;
output                                     hart2_vc_vmac_idle;
output                                     hart2_vc_vmsk_idle;
output                                     hart2_vc_vper_idle;
output                                     hart2_vc_vpu_idle;
      `endif // NDS_IO_VPU
   `endif // NDS_IO_HART2
   `ifdef NDS_IO_HART3
      `ifdef NDS_IO_TRACE_INSTR_GEN1
input                                      hart3_gen1_trace_enabled;
output                               [9:0] hart3_gen1_trace_cause;
output                  [(`NDS_VALEN-1):0] hart3_gen1_trace_iaddr;
output                                     hart3_gen1_trace_iexception;
output                              [31:0] hart3_gen1_trace_instr;
output                                     hart3_gen1_trace_interrupt;
output                                     hart3_gen1_trace_ivalid;
output                               [2:0] hart3_gen1_trace_priv;
output                   [(`NDS_XLEN-1):0] hart3_gen1_trace_tval;
      `endif // NDS_IO_TRACE_INSTR_GEN1
      `ifdef NDS_IO_TRACE_INSTR
input                                      hart3_trace_enabled;
output                               [9:0] hart3_trace_cause;
output                                     hart3_trace_halted;
output                [((`NDS_VALEN)-1):0] hart3_trace_iaddr;
output                                     hart3_trace_ilastsize;
output                               [1:0] hart3_trace_iretire;
output                               [3:0] hart3_trace_itype;
output                               [1:0] hart3_trace_priv;
output                                     hart3_trace_reset;
output                               [2:0] hart3_trace_trigger;
output                 [((`NDS_XLEN)-1):0] hart3_trace_tval;
      `endif // NDS_IO_TRACE_INSTR
      `ifdef NDS_IO_VPU
output                                     hart3_vc_valu_idle;
output                                     hart3_vc_vdiv_idle;
output                                     hart3_vc_vfdiv_idle;
output                                     hart3_vc_vfmac_idle;
output                                     hart3_vc_vfmis_idle;
output                                     hart3_vc_vlsu_idle;
output                                     hart3_vc_vmac_idle;
output                                     hart3_vc_vmsk_idle;
output                                     hart3_vc_vper_idle;
output                                     hart3_vc_vpu_idle;
      `endif // NDS_IO_VPU
   `endif // NDS_IO_HART3
   `ifdef NDS_IO_L2C
      `ifdef NDS_IO_L2C_IO_COHERENCE
input                            [ADDR_MSB:0] m4_araddr;
input                            [ADDR_MSB:0] m4_awaddr;
input                                   [1:0] m4_arburst;
input                                   [3:0] m4_arcache;
input                  [CPUCORE_BIU_ID_MSB:0] m4_arid;
input                                   [7:0] m4_arlen;
input                                         m4_arlock;
input                                   [2:0] m4_arprot;
output                                        m4_arready;
input                                   [2:0] m4_arsize;
input                                         m4_arvalid;
input                                   [1:0] m4_awburst;
input                                   [3:0] m4_awcache;
input                  [CPUCORE_BIU_ID_MSB:0] m4_awid;
input                                   [7:0] m4_awlen;
input                                         m4_awlock;
input                                   [2:0] m4_awprot;
output                                        m4_awready;
input                                   [2:0] m4_awsize;
input                                         m4_awvalid;
output                 [CPUCORE_BIU_ID_MSB:0] m4_bid;
input                                         m4_bready;
output                                  [1:0] m4_bresp;
output                                        m4_bvalid;
input                                         m4_clk_en;
output          [((`NDS_BIU_DATA_WIDTH)-1):0] m4_rdata;
output                 [CPUCORE_BIU_ID_MSB:0] m4_rid;
output                                        m4_rlast;
input                                         m4_rready;
output                                  [1:0] m4_rresp;
output                                        m4_rvalid;
input           [((`NDS_BIU_DATA_WIDTH)-1):0] m4_wdata;
input                                         m4_wlast;
output                                        m4_wready;
input       [(((`NDS_BIU_DATA_WIDTH)/8)-1):0] m4_wstrb;
input                                         m4_wvalid;
      `endif // NDS_IO_L2C_IO_COHERENCE
      `ifdef NDS_IO_L2C_IO_SLV
output                           [ADDR_MSB:0] l2c_io_araddr;
output                                  [1:0] l2c_io_arburst;
output                                  [3:0] l2c_io_arcache;
output                  [CPUSUB_BIU_ID_MSB:0] l2c_io_arid;
output                                  [7:0] l2c_io_arlen;
output                                        l2c_io_arlock;
output                                  [2:0] l2c_io_arprot;
input                                         l2c_io_arready;
output                                  [2:0] l2c_io_arsize;
output                                        l2c_io_arvalid;
output                           [ADDR_MSB:0] l2c_io_awaddr;
output                                  [1:0] l2c_io_awburst;
output                                  [3:0] l2c_io_awcache;
output                  [CPUSUB_BIU_ID_MSB:0] l2c_io_awid;
output                                  [7:0] l2c_io_awlen;
output                                        l2c_io_awlock;
output                                  [2:0] l2c_io_awprot;
input                                         l2c_io_awready;
output                                  [2:0] l2c_io_awsize;
output                                        l2c_io_awvalid;
input                   [CPUSUB_BIU_ID_MSB:0] l2c_io_bid;
output                                        l2c_io_bready;
input                                   [1:0] l2c_io_bresp;
input                                         l2c_io_bvalid;
input                 [CPUSUB_BIU_DATA_MSB:0] l2c_io_rdata;
input                   [CPUSUB_BIU_ID_MSB:0] l2c_io_rid;
input                                         l2c_io_rlast;
output                                        l2c_io_rready;
input                                   [1:0] l2c_io_rresp;
input                                         l2c_io_rvalid;
output                [CPUSUB_BIU_DATA_MSB:0] l2c_io_wdata;
output                                        l2c_io_wlast;
input                                         l2c_io_wready;
output               [CPUSUB_BIU_WSTRB_MSB:0] l2c_io_wstrb;
output                                        l2c_io_wvalid;
      `endif // NDS_IO_L2C_IO_SLV
   `endif // NDS_IO_L2C
`endif // NDS_NHART
`ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
   `ifdef NDS_IO_AHB
      `ifdef PLATFORM_DEBUG_SUBSYSTEM
output                        [ADDR_MSB:0] dm_sys_haddr;
output                               [2:0] dm_sys_hburst;
output                                     dm_sys_hbusreq;
input                                      dm_sys_hgrant;
output                               [3:0] dm_sys_hprot;
input               [(BIU_DATA_WIDTH-1):0] dm_sys_hrdata;
input                                      dm_sys_hready;
input                                [1:0] dm_sys_hresp;
output                               [2:0] dm_sys_hsize;
output                               [1:0] dm_sys_htrans;
output              [(BIU_DATA_WIDTH-1):0] dm_sys_hwdata;
output                                     dm_sys_hwrite;
      `endif // PLATFORM_DEBUG_SUBSYSTEM
   `endif // NDS_IO_AHB
`endif // PLATFORM_PLDM_SYS_BUS_ACCESS
`ifdef NDS_NHART
`else
   `ifdef NDS_IO_AHB
   `else
      `ifdef NDS_IO_BIU_X2
output               [CPUSUB_BIU_ID_MSB:0] i_arid;
output                        [ADDR_MSB:0] i_araddr;
output                               [7:0] i_arlen;
output                               [2:0] i_arsize;
output                               [1:0] i_arburst;
output                                     i_arlock;
output                               [3:0] i_arcache;
output                               [2:0] i_arprot;
output                                     i_arvalid;
input                                      i_arready;
output               [CPUSUB_BIU_ID_MSB:0] i_awid;
output                        [ADDR_MSB:0] i_awaddr;
output                               [7:0] i_awlen;
output                               [2:0] i_awsize;
output                               [1:0] i_awburst;
output                                     i_awlock;
output                               [3:0] i_awcache;
output                               [2:0] i_awprot;
output                                     i_awvalid;
input                                      i_awready;
output              [(BIU_DATA_WIDTH-1):0] i_wdata;
output          [((BIU_DATA_WIDTH/8)-1):0] i_wstrb;
output                                     i_wlast;
output                                     i_wvalid;
input                                      i_wready;
input                [CPUSUB_BIU_ID_MSB:0] i_bid;
input                                [1:0] i_bresp;
input                                      i_bvalid;
output                                     i_bready;
input                [CPUSUB_BIU_ID_MSB:0] i_rid;
input               [(BIU_DATA_WIDTH-1):0] i_rdata;
input                                [1:0] i_rresp;
input                                      i_rlast;
input                                      i_rvalid;
output                                     i_rready;
output               [CPUSUB_BIU_ID_MSB:0] d_arid;
output                        [ADDR_MSB:0] d_araddr;
output                               [7:0] d_arlen;
output                               [2:0] d_arsize;
output                               [1:0] d_arburst;
output                                     d_arlock;
output                               [3:0] d_arcache;
output                               [2:0] d_arprot;
output                                     d_arvalid;
input                                      d_arready;
output               [CPUSUB_BIU_ID_MSB:0] d_awid;
output                        [ADDR_MSB:0] d_awaddr;
output                               [7:0] d_awlen;
output                               [2:0] d_awsize;
output                               [1:0] d_awburst;
output                                     d_awlock;
output                               [3:0] d_awcache;
output                               [2:0] d_awprot;
output                                     d_awvalid;
input                                      d_awready;
output              [(BIU_DATA_WIDTH-1):0] d_wdata;
output          [((BIU_DATA_WIDTH/8)-1):0] d_wstrb;
output                                     d_wlast;
output                                     d_wvalid;
input                                      d_wready;
input                [CPUSUB_BIU_ID_MSB:0] d_bid;
input                                [1:0] d_bresp;
input                                      d_bvalid;
output                                     d_bready;
input                [CPUSUB_BIU_ID_MSB:0] d_rid;
input               [(BIU_DATA_WIDTH-1):0] d_rdata;
input                                [1:0] d_rresp;
input                                      d_rlast;
input                                      d_rvalid;
output                                     d_rready;
      `else
output               [CPUSUB_BIU_ID_MSB:0] arid;
output                        [ADDR_MSB:0] araddr;
output                               [7:0] arlen;
output                               [2:0] arsize;
output                               [1:0] arburst;
output                                     arlock;
output                               [3:0] arcache;
output                               [2:0] arprot;
output                                     arvalid;
input                                      arready;
output               [CPUSUB_BIU_ID_MSB:0] awid;
output                        [ADDR_MSB:0] awaddr;
output                               [7:0] awlen;
output                               [2:0] awsize;
output                               [1:0] awburst;
output                                     awlock;
output                               [3:0] awcache;
output                               [2:0] awprot;
output                                     awvalid;
input                                      awready;
output              [(BIU_DATA_WIDTH-1):0] wdata;
output          [((BIU_DATA_WIDTH/8)-1):0] wstrb;
output                                     wlast;
output                                     wvalid;
input                                      wready;
input                [CPUSUB_BIU_ID_MSB:0] bid;
input                                [1:0] bresp;
input                                      bvalid;
output                                     bready;
input                [CPUSUB_BIU_ID_MSB:0] rid;
input               [(BIU_DATA_WIDTH-1):0] rdata;
input                                [1:0] rresp;
input                                      rlast;
input                                      rvalid;
output                                     rready;
      `endif // NDS_IO_BIU_X2
   `endif // NDS_IO_AHB
`endif // NDS_NHART
`ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
   `ifdef NDS_IO_AHB
   `else
      `ifdef PLATFORM_DEBUG_SUBSYSTEM
output                        [ADDR_MSB:0] dm_sys_araddr;
output                               [1:0] dm_sys_arburst;
output                               [3:0] dm_sys_arcache;
output               [CPUSUB_BIU_ID_MSB:0] dm_sys_arid;
output                               [7:0] dm_sys_arlen;
output                                     dm_sys_arlock;
output                               [2:0] dm_sys_arprot;
input                                      dm_sys_arready;
output                               [2:0] dm_sys_arsize;
output                                     dm_sys_arvalid;
output                        [ADDR_MSB:0] dm_sys_awaddr;
output                               [1:0] dm_sys_awburst;
output                               [3:0] dm_sys_awcache;
output               [CPUSUB_BIU_ID_MSB:0] dm_sys_awid;
output                               [7:0] dm_sys_awlen;
output                                     dm_sys_awlock;
output                               [2:0] dm_sys_awprot;
input                                      dm_sys_awready;
output                               [2:0] dm_sys_awsize;
output                                     dm_sys_awvalid;
input                [CPUSUB_BIU_ID_MSB:0] dm_sys_bid;
output                                     dm_sys_bready;
input                                [1:0] dm_sys_bresp;
input                                      dm_sys_bvalid;
input               [(BIU_DATA_WIDTH-1):0] dm_sys_rdata;
input                [CPUSUB_BIU_ID_MSB:0] dm_sys_rid;
input                                      dm_sys_rlast;
output                                     dm_sys_rready;
input                                [1:0] dm_sys_rresp;
input                                      dm_sys_rvalid;
output              [(BIU_DATA_WIDTH-1):0] dm_sys_wdata;
output                                     dm_sys_wlast;
input                                      dm_sys_wready;
output          [((BIU_DATA_WIDTH/8)-1):0] dm_sys_wstrb;
output                                     dm_sys_wvalid;
      `endif // PLATFORM_DEBUG_SUBSYSTEM
   `endif // NDS_IO_AHB
`endif // PLATFORM_PLDM_SYS_BUS_ACCESS
`ifdef NDS_NHART
`else
   `ifdef NDS_IO_DLM_AHBLITE
      `ifdef PLATFORM_DLM_AHBLITE_USE_SYNCDN
input                                      pclk;
input                                      apb2ahb_clken;
      `endif // PLATFORM_DLM_AHBLITE_USE_SYNCDN
   `endif // NDS_IO_DLM_AHBLITE
   `ifdef NDS_IO_ACE_VPU
      `ifdef NDS_CUSTOM_ACE_VPU
input           [((`NDS_ASP_DATA_WIDTH)-1):0] cp_cpu_rdata;               // load data from ACE ifc logic
output                                        cp_cpu_rdata_ready;         // load ready from ACE ifc logic
input                                         cp_cpu_rdata_valid;         // load data from ACE ifc logic
output          [((`NDS_ASP_DATA_WIDTH)-1):0] cpu_cp_wdata;               // store data to ACE ifc logic
output             [((ASP_DATA_WIDTH/8)-1):0] cpu_cp_wdata_bwe;           // store byte enable to ACE ifc logic
input                                         cpu_cp_wdata_ready;         // store ready from ACE ifc logic
output                                        cpu_cp_wdata_valid;         // store valid to ACE ifc logic
      `endif // NDS_CUSTOM_ACE_VPU
   `endif // NDS_IO_ACE_VPU
`endif // NDS_NHART

`ifdef NDS_NHART
	`ifdef NDS_IO_L2C
input					core0_wfi_sel_iso;
input					core1_wfi_sel_iso;
input					core2_wfi_sel_iso;
input					core3_wfi_sel_iso;
	`endif // NDS_IO_L2C
`endif // NDS_NHART
input                        [(NHART-1):0] core_clk;
input                        [(NHART-1):0] core_resetn;
output                                     dbg_srst_req;
input                        [(NHART-1):0] dc_clk;
output                               [5:0] hart0_wakeup_event;
input                        [(NHART-1):0] lm_clk;
input                          [INT_NUM:1] int_src;                    // From Source (e.g. devices)
input                                      mtime_clk;                  // clock domain b_clk
input                                      por_rstn;
input                                      scan_enable;
input                                      test_mode;
input                                      test_rstn;
input                        [(VALEN-1):0] hart0_reset_vector;
input                                      hart0_icache_disable_init;
input                                      hart0_dcache_disable_init;
output                                     hart0_core_wfi_mode;
input                                      hart0_nmi;

endmodule
