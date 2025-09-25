`include "config.inc"
`include "global.inc"
`include "ae350_config.vh"
`include "ae350_const.vh"

`include "atcbmc300_config.vh"
`include "atcbmc301_config.vh"
`include "atcbusdec301_config.vh"

`ifdef NDS_IO_SLAVEPORT_COMMON_X1
        `include "atcbusdec302_config.vh"
`endif

//VPERL_BEGIN
//require ("$PVC_LOCALDIR/andes_vip/tools/vperl/axi4.pl");
//require ("$PVC_LOCALDIR/andes_vip/tools/vperl/axi4_prot.pl");
//require ("$PVC_LOCALDIR//andes_ip/kv_core/top/hdl/dcls_util.pl");
//require ("$PVC_LOCALDIR/andes_vip/tools/vperl/ram_ctrl.pl");
//
//&MODULE("ae350_scpu_cluster_subsystem");
//
//&IFDEF("PLATFORM_SLVPORT_DLM_SEL_BIT");
//&LOCALPARAM("SLVPORT_DLM_SEL_BIT        = `PLATFORM_SLVPORT_DLM_SEL_BIT");
//&ELSE("PLATFORM_SLVPORT_DLM_SEL_BIT");
//&LOCALPARAM("SLVPORT_DLM_SEL_BIT        = 21");
//&ENDIF("PLATFORM_SLVPORT_DLM_SEL_BIT");
//
//&LOCALPARAM("PALEN                      = `NDS_BIU_ADDR_WIDTH");
//&LOCALPARAM("BIU_ADDR_WIDTH             = `NDS_BIU_ADDR_WIDTH");
//&LOCALPARAM("BIU_ADDR_MSB               = `NDS_BIU_ADDR_WIDTH-1");
//&LOCALPARAM("BIU_ASYNC_SUPPORT          = `NDS_BIU_ASYNC_SUPPORT");
//&LOCALPARAM("COMPLEX_BRG_TYPE           = `NDS_COMPLEX_BRG_TYPE");
//#&LOCALPARAM("ISA_BASE                  = `NDS_ISA_BASE");
//&LOCALPARAM("XLEN                       = `NDS_XLEN");
//#&LOCALPARAM("MMU_SCHEME                = `NDS_MMU_SCHEME");
//&LOCALPARAM("VALEN                      = `NDS_VALEN");
//&IFDEF("PLATFORM_FORCE_4GB_SPACE");
//      &LOCALPARAM("ADDR_WIDTH           = 32");
//&ELSE("PLATFORM_FORCE_4GB_SPACE");
//      &LOCALPARAM("ADDR_WIDTH           = PALEN");
//&ENDIF("PLATFORM_FORCE_4GB_SPACE");
//&LOCALPARAM("ADDR_MSB                   = (ADDR_WIDTH-1)");
//&LOCALPARAM("RESET_VECTOR_WIDTH         = (VALEN > 32) ? 64 : 32");
//&LOCALPARAM("FLASHIF0_DATA_WIDTH        = `NDS_FLASHIF0_DATA_WIDTH");
//&LOCALPARAM("FLASHIF0_DATA_CODE_WIDTH   = `NDS_FLASHIF0_DATA_CODE_WIDTH");
//&LOCALPARAM("FLASHIF0_ID_WIDTH          = `NDS_FLASHIF0_ID_WIDTH");
//&LOCALPARAM("BIU_DATA_WIDTH             = `NDS_BIU_DATA_WIDTH");
//&LOCALPARAM("BIU_DATA_CODE_WIDTH        = `NDS_BIU_DATA_CODE_WIDTH");
//&LOCALPARAM("PPI_DATA_CODE_WIDTH        = `NDS_PPI_DATA_CODE_WIDTH");
//&LOCALPARAM("BIU_ADDR_CODE_WIDTH        = `NDS_BIU_ADDR_CODE_WIDTH");
//&LOCALPARAM("BIU_CTRL_CODE_WIDTH        = `NDS_BIU_CTRL_CODE_WIDTH");
//&LOCALPARAM("BIU_UTID_WIDTH             = `NDS_BIU_UTID_WIDTH");
//&LOCALPARAM("BIU_DATA_MSB               = (BIU_DATA_WIDTH-1)");
//&LOCALPARAM("BIU_WSTRB_WIDTH            = (BIU_DATA_WIDTH/8)");
//&LOCALPARAM("BIU_WSTRB_MSB              = (BIU_WSTRB_WIDTH-1)");
//&LOCALPARAM("WCTRL_CODE_WIDTH           = 5");
//&LOCALPARAM("BUS_PROTECTION_SUPPORT     = `NDS_BUS_PROTECTION_SUPPORT");

//&LOCALPARAM("IOCP_ID_WIDTH              = `NDS_IOCP_ID_WIDTH");

//&LOCALPARAM("SLVPORT_ID_WIDTH           = `NDS_SLAVE_PORT_ID_WIDTH");
//&LOCALPARAM("SLVPORT_DATA_WIDTH         = `NDS_SLAVE_PORT_DATA_WIDTH");
//&LOCALPARAM("SLVPORT_DATA_MSB           = (SLVPORT_DATA_WIDTH-1)");
//&LOCALPARAM("SLVPORT_WSTRB_WIDTH        = (SLVPORT_DATA_WIDTH/8)");
//&LOCALPARAM("SLVPORT_WSTRB_MSB          = (SLVPORT_WSTRB_WIDTH-1)");

//&LOCALPARAM("SLVP_PROTECTION_SUPPORT = `NDS_SLVP_PROTECTION_SUPPORT");
//&LOCALPARAM("SLV_ADDR_CODE_WIDTH = `NDS_SLV_ADDR_CODE_WIDTH");
//&LOCALPARAM("SLV_DATA_CODE_WIDTH = `NDS_SLV_DATA_CODE_WIDTH");
//&LOCALPARAM("SLV_CTRL_CODE_WIDTH = `NDS_SLV_CTRL_CODE_WIDTH");
//&LOCALPARAM("SLV_UTID_WIDTH = `NDS_SLV_UTID_WIDTH");
//&LOCALPARAM("SLV_ID_CODE_WIDTH = (SLVPORT_ID_WIDTH < 5)  ? 3 : (SLVPORT_ID_WIDTH < 12) ? 4 : 5");
//&LOCALPARAM("SLV_WCTRL_CODE_WIDTH = ((SLVPORT_WSTRB_WIDTH+1) < 5)  ? 3 : ((SLVPORT_WSTRB_WIDTH+1) < 12) ? 4 : 5");

//&LOCALPARAM("BIU_ID_WIDTH               = `NDS_BIU_ID_WIDTH");
//&LOCALPARAM("BIU_ID_MSB                 = (BIU_ID_WIDTH-1)");
//
//&LOCALPARAM("PPI_DATA_WIDTH             = `NDS_PPI_DATA_WIDTH");
//&LOCALPARAM("PPI_ID_WIDTH               = `NDS_PPI_ID_WIDTH");
//
//&LOCALPARAM("VECTOR_PLIC_SUPPORT        = `NDS_VECTOR_PLIC_SUPPORT");
//
//&LOCALPARAM("NCE_DATA_WIDTH             = (BIU_DATA_WIDTH > 64) ? 64 : BIU_DATA_WIDTH");
//&LOCALPARAM("NCE_DATA_MSB               = (NCE_DATA_WIDTH-1)");
//&LOCALPARAM("NCE_WSTRB_WIDTH            = (NCE_DATA_WIDTH/8)");
//&LOCALPARAM("NCE_WSTRB_MSB              = (NCE_WSTRB_WIDTH-1)");
//
//&LOCALPARAM("DM_SYS_DATA_WIDTH          = (BIU_DATA_WIDTH > 128) ? 128 : BIU_DATA_WIDTH");
//&LOCALPARAM("DM_SYS_DATA_MSB            = (DM_SYS_DATA_WIDTH-1)");
//&LOCALPARAM("DM_SYS_WSTRB_WIDTH         = (DM_SYS_DATA_WIDTH/8)");
//&LOCALPARAM("DM_SYS_WSTRB_MSB           = (DM_SYS_WSTRB_WIDTH-1)");

//&LOCALPARAM("SIZEUP_DS_DATA_WIDTH       = BIU_DATA_WIDTH");
//&LOCALPARAM("SIZEUP_DS_DATA_SIZE        = \$unsigned(\$clog2(SIZEUP_DS_DATA_WIDTH)) - 3");
//&LOCALPARAM("SIZEUP_ADDR_WIDTH          = SIZEUP_DS_DATA_SIZE");
//&LOCALPARAM("SIZEUP_ADDR_MSB            = (SIZEUP_ADDR_WIDTH-1)");
//
//&IFDEF("NDS_IO_CLUSTER");
//      &LOCALPARAM("NHART                = `NDS_NHART");
//&ELSE("NDS_IO_CLUSTER");
//      &LOCALPARAM("NHART                = 1");
//&ENDIF("NDS_IO_CLUSTER");
//
//&LOCALPARAM("DLM_RAM_BWEW               = `NDS_DLM_RAM_BWEW");
//&LOCALPARAM("ILM_AW                     = `NDS_ILM_AW");
//&LOCALPARAM("ILM_RAM_DW                 = `NDS_ILM_RAM_DW");
//&LOCALPARAM("ILM_RAM_BWEW               = `NDS_ILM_RAM_BWEW");
//&LOCALPARAM("ILM_ECC_SUPPORT            = `NDS_ILM_ECC_TYPE == \"ecc\"");
//&LOCALPARAM("ILM_TL_UL_RAM_NUM          = (XLEN == 64) ? 1 : 2");
//&LOCALPARAM("ILM_TL_UL_AW               = ILM_AW+3");
//&LOCALPARAM("ILM_TL_UL_EW               = ILM_ECC_SUPPORT ? (XLEN == 64) ? 8 : 7 : 1");
//&LOCALPARAM("ILM_TL_UL_RAM_AW           = ILM_AW");
//&LOCALPARAM("ILM_TL_UL_RAM_DW           = (XLEN == 64) ? ILM_ECC_SUPPORT ? 72 : 64 : ILM_ECC_SUPPORT ? 39 : 32");
//&LOCALPARAM("ILM_TL_UL_RAM_BWEW       = (ILM_TL_UL_RAM_DW == 39) ? 5 : ILM_TL_UL_RAM_DW/8");
//&LOCALPARAM("PLIC_HW_TARGET_NUM         = NHART*2");
//&LOCALPARAM("PLIC_SW_TARGET_NUM         = NHART");
//
//&LOCALPARAM("ILM_HDATA_WIDTH            = XLEN");
//&LOCALPARAM("DLM_HDATA_WIDTH            = XLEN");
//
//&LOCALPARAM("PROGBUF_SIZE               = `PLATFORM_PLDM_PROGBUF_SIZE");
//&LOCALPARAM("HALTGROUP_COUNT            = `PLATFORM_PLDM_HALTGROUP_COUNT");
//&IFDEF("PLATFORM_PLDM_SYS_BUS_ACCESS");
//      &LOCALPARAM("PLDM_SYS_BUS_ACCESS  = \"yes\"");
//&ELSE ("PLATFORM_PLDM_SYS_BUS_ACCESS");
//      &LOCALPARAM("PLDM_SYS_BUS_ACCESS  = \"no\"");
//&ENDIF("PLATFORM_PLDM_SYS_BUS_ACCESS");
//&IFDEF("PLATFORM_TRACE_SUBSYSTEM");
//&LOCALPARAM("DMXTRIGGER_COUNT = 1");
//&ELSE ("PLATFORM_TRACE_SUBSYSTEM");
//&LOCALPARAM("DMXTRIGGER_COUNT = 0");
//&ENDIF("PLATFORM_TRACE_SUBSYSTEM");
//&LOCALPARAM("DMXTRIGGER_MSB = (DMXTRIGGER_COUNT > 0) ? DMXTRIGGER_COUNT - 1 : 0");
//
//&LOCALPARAM("SYNC_STAGE = `NDS_SYNC_STAGE");
//
// #----------------------------------
// # BMC slave connection number
// #----------------------------------
// $BMC_MST_SYS0        = 0;
// $BMC_MST_FLASH0      = 1;
//
// $BMC_SLV_BUSDEC      = 1;
// $BMC_SLV_SYS         = 2;
// $BMC_SLV_FLASH0       = 3;
//
// #----------------------------------
// # BUSDEC slave connection number
// #----------------------------------
// $BUSDEC_SLV_PLIC     = 1;
// $BUSDEC_SLV_PLMT     = 2;
// $BUSDEC_SLV_PLICSW   = 3;
// $BUSDEC_SLV_DM       = 4;
//

// #----------------------------------
// # BUSDEC slave connection number
// #----------------------------------
// $BUSDEC_SLV_HART0    = 1;
// $BUSDEC_SLV_HART1    = 2;
// $BUSDEC_SLV_HART2    = 3;
// $BUSDEC_SLV_HART3    = 4;
//
//###############################################################################
//# Clock & Rest
//###############################################################################
//
//&FORCE("input",  "core_clk[(NHART-1):0]");
//&FORCE("input",  "lm_clk[(NHART-1):0]");
//&FORCE("input",  "core_resetn[(NHART-1):0]");
//&FORCE("input",  "slvp_resetn[(NHART-1):0]");
//&FORCE("input",  "test_mode");
//&FORCE("input",  "test_rstn");
//&FORCE("input",  "por_rstn");
//&FORCE("input",  "mtime_clk");
//&FORCE("input",  "biu_clk");
//&FORCE("input",  "biu_resetn");
//&IFDEF("NDS_IO_DCLS");
//&FORCE("input",  "dcls_core1_clk");
//&FORCE("input",  "dcls_core1_lm_clk");
//&ENDIF("NDS_IO_DCLS");
//
//for (my $i=0; $i < 2;$i++) {
//    &IFDEF("NDS_IO_HART${i}") if(${i});;
//    &FORCE("output", "hart${i}_wakeup_event[5:0]");
//    &ENDIF("NDS_IO_HART${i}") if(${i});;
//}
//
//&FORCE("wire",   "core0_clk");
//&FORCE("wire",   "core0_reset_n");
//&FORCE("wire",   "core0_lm_clk");
//&FORCE("wire",   "core0_slv_clk");
//&FORCE("wire",   "core0_slv_clk_en");
//#&FORCE("wire",   "core0_slv1_clk");
//&FORCE("wire",   "core0_slv1_clk_en");
//&FORCE("wire",   "core0_slvp_reset_n");
//
//&IFDEF("NDS_IO_DCLS");
//&FORCE("reg",    "core0_reset_n_delay[1:0]");
//&FORCE("reg",    "core0_slvp_reset_n_delay[1:0]");
//&FORCE("wire",   "core1_clk");
//&FORCE("wire",   "core1_reset_n");
//&FORCE("wire",   "core1_slv_clk");
//&FORCE("wire",   "core1_slv1_clk");
//&FORCE("wire",   "core1_slvp_reset_n");
//&IFDEF("NDS_IO_LM");
//&FORCE("wire",   "core1_lm_clk");
//&ENDIF("NDS_IO_LM");
//&ENDIF("NDS_IO_DCLS");
//
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire",   "core1_slv_clk_en");
//&FORCE("wire",   "core1_slv1_clk_en");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//
//:assign core0_clk         = core_clk[0];
//:assign core0_reset_n     = core_resetn[0];
//:assign core0_lm_clk      = lm_clk[0];
//:assign core0_slv_clk     = aclk;
//:assign core0_slv_clk_en  = axi_bus_clk_en;
//#:assign core0_slv1_clk    = aclk;
//:assign core0_slv1_clk_en = axi_bus_clk_en;
//:assign core0_slvp_reset_n = slvp_resetn[0];
//
//:`ifdef NDS_IO_DCLS
//:always @(posedge core1_clk or negedge core0_reset_n) begin
//:	if (!core0_reset_n) begin
//:		core0_reset_n_delay <= 2'd0;
//:	end
//:	else begin
//:		core0_reset_n_delay <= {core0_reset_n_delay[0], 1'b1};
//:	end
//:end
//:always @(posedge core1_slv_clk or negedge core0_slvp_reset_n) begin
//:	if (!core0_slvp_reset_n) begin
//:		core0_slvp_reset_n_delay <= 2'd0;
//:	end
//:	else begin
//:		core0_slvp_reset_n_delay <= {core0_slvp_reset_n_delay[0], 1'b1};
//:	end
//:end
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign core1_reset_n = dcls_p_enable_split ? core_resetn[1] : core0_reset_n_delay[1];
//:assign core1_slvp_reset_n = dcls_p_enable_split ? slvp_resetn[1] : core0_slvp_reset_n_delay[1];
//:`else // NDS_IO_DCLS_SPLIT
//:assign core1_reset_n = core0_reset_n_delay[1];
//:assign core1_slvp_reset_n = core0_slvp_reset_n_delay[1];
//:`endif // NDS_IO_DCLS_SPLIT
//:`endif // NDS_IO_DCLS
//
//:`ifdef NDS_IO_DCLS_SPLIT
//: assign core1_clk = dcls_p_enable_split ? core_clk[1] : dcls_core1_clk;
//:`ifdef NDS_IO_LM
//:assign core1_lm_clk  = dcls_p_enable_split ? lm_clk[1] : dcls_core1_lm_clk;
//:`endif // NDS_IO_LM
//:assign core1_slv_clk     = aclk;
//:assign core1_slv1_clk    = aclk;
//:assign core1_slv_clk_en  = axi_bus_clk_en;
//:assign core1_slv1_clk_en = axi_bus_clk_en;
//:
//:`else // NDS_IO_DCLS_SPLIT
//:`ifdef NDS_IO_DCLS
//: assign core1_clk = dcls_core1_clk;
//:`ifdef NDS_IO_LM
//:assign core1_lm_clk  = dcls_core1_lm_clk;
//:`endif // NDS_IO_LM
//:assign core1_slv_clk     = aclk;
//:assign core1_slv1_clk    = aclk;
//:`endif // NDS_IO_DCLS
//:`endif // NDS_IO_DCLS_SPLIT
//
//:`ifdef NDS_IO_LM
//:`else
//:wire	nds_unused_core0_lm_clk = core0_lm_clk;
//:`endif

//:`ifdef NDS_IO_DCLS
//:	`ifdef NDS_IO_SLAVEPORT_COMMON_X2
//:	`else
//:wire	nds_unused_core1_slvp_reset_n = core1_slvp_reset_n;
//:	`endif
//:`endif

//:`ifdef NDS_IO_SLAVEPORT_SYNC
//:`else
//:wire	nds_unused_no_core0_slv0_async = core0_slv_clk_en;
//:`endif
//:`ifdef NDS_IO_SLAVEPORT_SYNC_X2
//:`else
//:wire	nds_unused_no_core0_slv1_async = core0_slv1_clk_en;
//:`endif

//:`ifdef NDS_IO_DCLS_SPLIT
//:	`ifdef NDS_IO_SLAVEPORT_SYNC
//:	`else
//:wire	nds_unused_no_core1_slv0_async = core1_slv_clk_en;
//:	`endif
//:	`ifdef NDS_IO_SLAVEPORT_SYNC_X2
//:	`else
//:wire	nds_unused_no_core1_slv1_async = core1_slv1_clk_en;
//:	`endif
//:`endif

//:`ifdef NDS_IO_SLAVEPORT_ECC_X1
//:	`ifdef ATCBUSDEC302_SLV1_SUPPORT
//:	`else
//:wire	nds_unused_no_core0_slv_ecc = core0_slv_clk;
//:	`endif
//:`else
//:wire	nds_unused_no_core0_slv_ecc = core0_slv_clk;
//:`endif

//for (my $i=0; $i < 2;$i++) {
//printf("`ifdef NDS_IO_HART${i}\n") if(${i});
//:    assign hart${i}_wakeup_event = {hart${i}_meip, hart${i}_seip, 1'b0, mtip[${i}], hart${i}_msip, dm_debugint[${i}]};
//printf("`endif //NDS_IO_HART${i}\n") if(${i});
//:
//}
//
//&FORCE("input",  "axi_bus_clk_en");
//&FORCE("input",  "aclk");
//&FORCE("input",  "aresetn");
//
//###############################################################################
//# LM CLK
//###############################################################################
//&IFDEF("NDS_IO_LM");
//&FORCE("wire", "lm_p_clk");
//&FORCE("wire", "lm_r_clk");
//&ENDIF("NDS_IO_LM");
//
//:`ifdef NDS_IO_LM
//:assign lm_p_clk = lm_clk[0];
//:assign lm_r_clk = lm_clk[0];
//:`endif // NDS_IO_LM
//
//###############################################################################
//# Bus prot 
//###############################################################################
//&IFDEF("NDS_IO_BUS_PROTECTION");
//&DANGLER("core0_fs_bus_m_protection_error");
//&DANGLER("core1_fs_bus_m_protection_error");
//&FORCE("wire","core0_fs_bus_m_protection_error[7:0]");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire","core1_fs_bus_m_protection_error[7:0]");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_BUS_PROTECTION");
//:`ifdef NDS_IO_BUS_PROTECTION
//:wire nds_unused_bus_prot_err;
//:assign nds_unused_bus_prot_err = (|core0_fs_bus_m_protection_error)
//:`ifdef NDS_IO_DCLS_SPLIT
//:                                | (|core1_fs_bus_m_protection_error)
//:`endif // NDS_IO_DCLS_SPLIT
//:                                ;
//:`endif // NDS_IO_BUS_PROTECTION
//
//###############################################################################
//# Bus Protection Config
//###############################################################################
//&IFDEF("NDS_IO_BUS_PROTECTION");
//&FORCE("wire", "core0_cfg_timeout_flash0[7:0]");
//&FORCE("wire", "core0_cfg_timeout_ppi[7:0]");
//&FORCE("wire", "core0_cfg_timeout_spp[7:0]");
//&FORCE("wire", "core0_cfg_timeout_sys0[7:0]");
//&ENDIF("NDS_IO_BUS_PROTECTION");
//
//&IFDEF("NDS_IO_BUS_PROTECTION");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "core1_cfg_timeout_flash0[7:0]");
//&FORCE("wire", "core1_cfg_timeout_ppi[7:0]");
//&FORCE("wire", "core1_cfg_timeout_spp[7:0]");
//&FORCE("wire", "core1_cfg_timeout_sys0[7:0]");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_BUS_PROTECTION");
//
//:`ifdef NDS_IO_BUS_PROTECTION
//:assign core0_cfg_timeout_sys0 = 8'hff;
//:assign core0_cfg_timeout_flash0 = 8'hff;
//:assign core0_cfg_timeout_ppi = 8'hff;
//:assign core0_cfg_timeout_spp = 8'hff;
//:`endif // NDS_IO_BUS_PROTECTION
//:
//:`ifdef NDS_IO_BUS_PROTECTION
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign core1_cfg_timeout_sys0 = 8'hff;
//:assign core1_cfg_timeout_flash0 = 8'hff;
//:assign core1_cfg_timeout_ppi = 8'hff;
//:assign core1_cfg_timeout_spp = 8'hff;
//:`endif // NDS_IO_DCLS_SPLIT
//:`endif // NDS_IO_BUS_PROTECTION
//
//###############################################################################
//# Cluster
//###############################################################################
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/top/hdl/nds_scpu_cluster.v", "u_cluster", {
//});
//&CONNECT("u_cluster", {
//
//      sys0_araddr      => "cluster_sys0_araddr",
//      sys0_arburst     => "cluster_sys0_arburst",
//      sys0_arcache     => "cluster_sys0_arcache",
//      sys0_arid        => "cluster_sys0_arid",
//      sys0_arlen       => "cluster_sys0_arlen",
//      sys0_arlock      => "cluster_sys0_arlock",
//      sys0_arprot      => "cluster_sys0_arprot",
//      sys0_arready     => "cluster_sys0_arready",
//      sys0_arsize      => "cluster_sys0_arsize",
//      sys0_arvalid     => "cluster_sys0_arvalid",
//      sys0_arctl0code  => "cluster_sys0_arctl0code",
//      sys0_arctl1code  => "cluster_sys0_arctl1code",
//      sys0_araddrcode  => "cluster_sys0_araddrcode",
//      sys0_aridcode    => "cluster_sys0_aridcode",
//      sys0_arvalidcode => "cluster_sys0_arvalidcode",
//      sys0_arreadycode => "cluster_sys0_arreadycode",
//      sys0_arutid      => "cluster_sys0_arutid",
//
//      sys0_awaddr      => "cluster_sys0_awaddr",
//      sys0_awburst     => "cluster_sys0_awburst",
//      sys0_awcache     => "cluster_sys0_awcache",
//      sys0_awid        => "cluster_sys0_awid",
//      sys0_awlen       => "cluster_sys0_awlen",
//      sys0_awlock      => "cluster_sys0_awlock",
//      sys0_awprot      => "cluster_sys0_awprot",
//      sys0_awready     => "cluster_sys0_awready",
//      sys0_awsize      => "cluster_sys0_awsize",
//      sys0_awvalid     => "cluster_sys0_awvalid",
//      sys0_awctl0code  => "cluster_sys0_awctl0code",
//      sys0_awctl1code  => "cluster_sys0_awctl1code",
//      sys0_awaddrcode  => "cluster_sys0_awaddrcode",
//      sys0_awidcode    => "cluster_sys0_awidcode",
//      sys0_awvalidcode => "cluster_sys0_awvalidcode",
//      sys0_awreadycode => "cluster_sys0_awreadycode",
//      sys0_awutid      => "cluster_sys0_awutid",
//
//      sys0_bid         => "cluster_sys0_bid",
//      sys0_bready      => "cluster_sys0_bready",
//      sys0_bresp       => "cluster_sys0_bresp",
//      sys0_bvalid      => "cluster_sys0_bvalid",
//      sys0_bvalidcode  => "cluster_sys0_bvalidcode",
//      sys0_breadycode  => "cluster_sys0_breadycode",
//      sys0_bctlcode    => "cluster_sys0_bctlcode",
//      sys0_bidcode     => "cluster_sys0_bidcode",
//      sys0_butid       => "cluster_sys0_butid",
//
//	sys0_rid		=> "cluster_sys0_rid",
//      sys0_rdata       => "cluster_sys0_rdata",
//      sys0_rlast       => "cluster_sys0_rlast",
//      sys0_rready      => "cluster_sys0_rready",
//      sys0_rresp       => "cluster_sys0_rresp",
//      sys0_rvalid      => "cluster_sys0_rvalid",
//      sys0_rvalidcode  => "cluster_sys0_rvalidcode",
//      sys0_rreadycode  => "cluster_sys0_rreadycode",
//      sys0_rdatacode   => "cluster_sys0_rdatacode",
//      sys0_ridcode     => "cluster_sys0_ridcode",
//      sys0_rctlcode    => "cluster_sys0_rctlcode",
//      sys0_reobi	=> "cluster_sys0_reobi",
//      sys0_rutid       => "cluster_sys0_rutid",
//
//
//#     sys_rsnoop      => "cluster_sys0_rsnoop",
//
//      sys0_wdata       => "cluster_sys0_wdata",
//      sys0_wlast       => "cluster_sys0_wlast",
//      sys0_wready      => "cluster_sys0_wready",
//      sys0_wstrb       => "cluster_sys0_wstrb",
//      sys0_wvalid      => "cluster_sys0_wvalid",
//      sys0_wvalidcode  => "cluster_sys0_wvalidcode",
//      sys0_wreadycode  => "cluster_sys0_wreadycode",
//      sys0_wdatacode   => "cluster_sys0_wdatacode",
//      sys0_wctlcode   => "cluster_sys0_wctlcode",
//      sys0_weobi       => "cluster_sys0_weobi",
//      sys0_wutid       => "cluster_sys0_wutid",
//
//      sys0_aclk_en     => "axi_bus_clk_en",
//
//      flash0_araddr      => "cluster_flash0_araddr",
//      flash0_arburst     => "cluster_flash0_arburst",
//      flash0_arcache     => "cluster_flash0_arcache",
//      flash0_arid        => "cluster_flash0_arid",
//      flash0_arlen       => "cluster_flash0_arlen",
//      flash0_arlock      => "cluster_flash0_arlock",
//      flash0_arprot      => "cluster_flash0_arprot",
//      flash0_arready     => "cluster_flash0_arready",
//      flash0_arsize      => "cluster_flash0_arsize",
//      flash0_arvalid     => "cluster_flash0_arvalid",
//      flash0_arctl0code  => "cluster_flash0_arctl0code",
//      flash0_arctl1code  => "cluster_flash0_arctl1code",
//      flash0_araddrcode  => "cluster_flash0_araddrcode",
//      flash0_aridcode    => "cluster_flash0_aridcode",
//      flash0_arvalidcode => "cluster_flash0_arvalidcode",
//      flash0_arreadycode => "cluster_flash0_arreadycode",
//      flash0_arutid      => "cluster_flash0_arutid",
//
//      flash0_awaddr      => "cluster_flash0_awaddr",
//      flash0_awburst     => "cluster_flash0_awburst",
//      flash0_awcache     => "cluster_flash0_awcache",
//      flash0_awid        => "cluster_flash0_awid",
//      flash0_awlen       => "cluster_flash0_awlen",
//      flash0_awlock      => "cluster_flash0_awlock",
//      flash0_awprot      => "cluster_flash0_awprot",
//      flash0_awready     => "cluster_flash0_awready",
//      flash0_awsize      => "cluster_flash0_awsize",
//      flash0_awvalid     => "cluster_flash0_awvalid",
//      flash0_awctl0code  => "cluster_flash0_awctl0code",
//      flash0_awctl1code  => "cluster_flash0_awctl1code",
//      flash0_awaddrcode  => "cluster_flash0_awaddrcode",
//      flash0_awidcode    => "cluster_flash0_awidcode",
//      flash0_awvalidcode => "cluster_flash0_awvalidcode",
//      flash0_awreadycode => "cluster_flash0_awreadycode",
//      flash0_awutid      => "cluster_flash0_awutid",
//
//      flash0_bid         => "cluster_flash0_bid",
//      flash0_bready      => "cluster_flash0_bready",
//      flash0_bresp       => "cluster_flash0_bresp",
//      flash0_bvalid      => "cluster_flash0_bvalid",
//      flash0_bvalidcode  => "cluster_flash0_bvalidcode",
//      flash0_breadycode  => "cluster_flash0_breadycode",
//      flash0_bctlcode    => "cluster_flash0_bctlcode",
//      flash0_bidcode     => "cluster_flash0_bidcode",
//      flash0_butid       => "cluster_flash0_butid",
//
//	flash0_rid	   => "cluster_flash0_rid",
//      flash0_rdata       => "cluster_flash0_rdata",
//      flash0_rlast       => "cluster_flash0_rlast",
//      flash0_rready      => "cluster_flash0_rready",
//      flash0_rresp       => "cluster_flash0_rresp",
//      flash0_rvalid      => "cluster_flash0_rvalid",
//      flash0_rvalidcode  => "cluster_flash0_rvalidcode",
//      flash0_rreadycode  => "cluster_flash0_rreadycode",
//      flash0_rdatacode   => "cluster_flash0_rdatacode",
//      flash0_ridcode     => "cluster_flash0_ridcode",
//      flash0_rctlcode    => "cluster_flash0_rctlcode",
//      flash0_reobi	   => "cluster_flash0_reobi",
//      flash0_rutid       => "cluster_flash0_rutid",
//
//
//#     flash0_rsnoop      => "cluster_flash0_rsnoop",
//
//      flash0_wdata       => "cluster_flash0_wdata",
//      flash0_wlast       => "cluster_flash0_wlast",
//      flash0_wready      => "cluster_flash0_wready",
//      flash0_wstrb       => "cluster_flash0_wstrb",
//      flash0_wvalid      => "cluster_flash0_wvalid",
//      flash0_wvalidcode  => "cluster_flash0_wvalidcode",
//      flash0_wreadycode  => "cluster_flash0_wreadycode",
//      flash0_wdatacode   => "cluster_flash0_wdatacode",
//      flash0_wctlcode   => "cluster_flash0_wctlcode",
//      flash0_weobi       => "cluster_flash0_weobi",
//      flash0_wutid       => "cluster_flash0_wutid",
//
//      flash0_aclk_en     => "axi_bus_clk_en",
//
//});
//
//###############################################################################
//# EDC-After-ECC
//###############################################################################
//&DANGLER("nds_unused_core0_fs_edc_error");
//&DANGLER("nds_unused_core1_fs_edc_error");
//
//&CONNECT("u_cluster", {
//	core0_fs_edc_error	=> "nds_unused_core0_fs_edc_error",
//	core1_fs_edc_error	=> "nds_unused_core1_fs_edc_error",
//});
//
//
//###############################################################################
//# WFI
//###############################################################################
//
//&FORCE("output", "hart0_core_wfi_mode");
//&IFDEF("NDS_IO_HART1");
//&FORCE("output", "hart1_core_wfi_mode");
//&ENDIF("NDS_IO_HART1");
//
//&IFDEF("NDS_IO_DCLS");
//&FORCE("wire", "core0_wfi_mode");
//&ENDIF("NDS_IO_DCLS");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "core1_wfi_mode");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//
//:assign hart0_core_wfi_mode = core0_wfi_mode;
//
//:`ifdef NDS_IO_HART1
//:assign hart1_core_wfi_mode = core1_wfi_mode;
//:`endif // NDS_IO_HART1
//
//###############################################################################
//# ILM BOOT
//###############################################################################
//&IFDEF("NDS_IO_ILM_BOOT");
//&FORCE("wire", "ilm_boot");
//&ENDIF("NDS_IO_ILM_BOOT");
//
//:`ifdef NDS_IO_ILM_BOOT
//:`ifdef SET_ILM_BOOT
//:assign ilm_boot = 1'b1;
//:`else // SET_ILM_BOOT
//:assign ilm_boot = 1'b0;
//:`endif // SET_ILM_BOOT
//:`endif // NDS_IO_ILM_BOOT
//
//###############################################################################
//# MEIP
//###############################################################################
//&FORCE("wire", "hart0_meip");
//&FORCE("wire", "hart0_meiid[9:0]");
//&FORCE("wire", "hart0_meiack");
//&FORCE("wire", "hart1_meip");
//&FORCE("wire", "hart1_meiid[9:0]");
//&FORCE("wire", "hart1_meiack");
//
//&FORCE("wire", "core0_meip");
//&FORCE("wire", "core0_meiid[9:0]");
//&FORCE("wire", "core0_meiack");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "core1_meip");
//&FORCE("wire", "core1_meiid[9:0]");
//&FORCE("wire", "core1_meiack");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//
//:assign core0_meip = hart0_meip;
//:assign core0_meiid = hart0_meiid;
//:assign hart0_meiack = core0_meiack;
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign core1_meip   = hart1_meip;
//:assign core1_meiid  = hart1_meiid;
//:assign hart1_meiack = core1_meiack;
//:`else // NDS_IO_DCLS_SPLIT
//:assign hart1_meiack = 1'b0;
//:`endif // NDS_IO_DCLS_SPLIT
//
//###############################################################################
//# SEIP
//###############################################################################
//&FORCE("wire", "hart0_seip");
//&FORCE("wire", "hart0_seiid[9:0]");
//&FORCE("wire", "hart0_seiack");
//&FORCE("wire", "hart1_seip");
//&FORCE("wire", "hart1_seiid[9:0]");
//&FORCE("wire", "hart1_seiack");
//
//&IFDEF("NDS_IO_SEIP");
//&FORCE("wire", "core0_seip");
//&FORCE("wire", "core0_seiid[9:0]");
//&FORCE("wire", "core0_seiack");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "core1_seip");
//&FORCE("wire", "core1_seiid[9:0]");
//&FORCE("wire", "core1_seiack");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_SEIP");
//
//:`ifdef NDS_IO_SEIP
//:assign core0_seip = hart0_seip;
//:assign core0_seiid = hart0_seiid;
//:assign hart0_seiack = core0_seiack;
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign core1_seip   = hart1_seip;
//:assign core1_seiid  = hart1_seiid;
//:assign hart1_seiack = core1_seiack;
//:`else // NDS_IO_DCLS_SPLIT
//:assign hart1_seiack = 1'b0;
//:`endif // NDS_IO_DCLS_SPLIT
//:`else // NDS_IO_SEIP
//:assign hart0_seiack = 1'b0;
//:assign hart1_seiack = 1'b0;
//:`endif // NDS_IO_SEIP
//
//
//###############################################################################
//# UEIP
//###############################################################################
//&IFDEF("NDS_IO_UEIP");
//&FORCE("wire",   "core0_ueip");
//&DANGLER("nds_unused_core0_ueiack");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire",   "core1_ueip");
//&DANGLER("nds_unused_core1_ueiack");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_UEIP");
//
//:`ifdef NDS_IO_UEIP
//:assign core0_ueip = 1'b0;
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign core1_ueip = 1'b0;
//:`endif // NDS_IO_DCLS_SPLIT
//:`endif // NDS_IO_UEIP
//
//###############################################################################
//# MTIP
//###############################################################################
//
//&FORCE("wire", "mtip[NHART-1:0]");
//&FORCE("wire", "hart0_mtip");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "hart1_mtip");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//
//:assign hart0_mtip = mtip[0];
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign hart1_mtip = mtip[1];
//:`endif // NDS_IO_DCLS_SPLIT
//
//###############################################################################
//# stoptime
//###############################################################################
//&FORCE("wire", "stoptime");
//&IFDEF("NDS_IO_DEBUG");
//&FORCE("wire", "core0_stoptime");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "core1_stoptime");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_DEBUG");
//
//:`ifdef NDS_IO_DEBUG
//:	`ifdef NDS_IO_DCLS_SPLIT
//:		assign stoptime = core0_stoptime | core1_stoptime;
//:	`else // NDS_IO_DCLS_SPLIT
//:		assign stoptime = core0_stoptime;
//:	`endif // NDS_IO_DCLS_SPLIT
//:`else // NDS_IO_DEBUG
//:	assign stoptime = 1'b0;
//:`endif // NDS_IO_DEBUG
//:
//###############################################################################
//# hart_unavail
//###############################################################################
//&IFDEF("NDS_IO_DEBUG");
//&FORCE("wire", "core0_hart_unavail");
//&FORCE("wire", "core0_hart_under_reset");
//&FORCE("wire", "core0_hart_halted");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "core1_hart_unavail");
//&FORCE("wire", "core1_hart_under_reset");
//&FORCE("wire", "core1_hart_halted");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_DEBUG");
//
//###############################################################################
//# debugint
//###############################################################################
//&IFDEF("NDS_IO_DEBUG");
//&FORCE("wire", "core0_debugint");
//&FORCE("wire", "core0_resethaltreq");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "core1_debugint");
//&FORCE("wire", "core1_resethaltreq");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_DEBUG");
//:
//:`ifdef NDS_IO_DEBUG
//:assign core0_debugint = dm_debugint[0];
//:assign core0_resethaltreq = dm_resethaltreq[0];
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign core1_debugint = dm_debugint[1];
//:assign core1_resethaltreq = dm_resethaltreq[1];
//:`endif // NDS_IO_DCLS_SPLIT
//:`endif // NDS_IO_DEBUG
//
//###############################################################################
//# reset_vector
//###############################################################################
//&FORCE("input",  "hart0_reset_vector[(VALEN-1):0]");
//&IFDEF("NDS_IO_HART1");
//&FORCE("input",  "hart1_reset_vector[(VALEN-1):0]");
//&ENDIF("NDS_IO_HART1");
//
//&FORCE("wire", "core0_reset_vector[(VALEN-1):0]");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "core1_reset_vector[(VALEN-1):0]");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//
//:assign core0_reset_vector = hart0_reset_vector;
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign core1_reset_vector = hart1_reset_vector;
//:`endif // NDS_IO_DCLS_SPLIT
//
//###############################################################################
//# nmi
//###############################################################################
//&FORCE("input",  "hart0_nmi");
//&IFDEF("NDS_IO_HART1");
//&FORCE("input",  "hart1_nmi");
//&ENDIF("NDS_IO_HART1");
//
//&FORCE("wire", "core0_nmi");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "core1_nmi");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//
//:assign core0_nmi = hart0_nmi;
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign core1_nmi = hart1_nmi;
//:`endif // NDS_IO_DCLS_SPLIT
//
//
//###############################################################################
//# cache_disable_init
//###############################################################################
//for (my $i=0; $i < 2;$i++) {
//  &IFDEF("NDS_IO_HART${i}") if(${i}!=0);
//      &FORCE("input",  "hart${i}_icache_disable_init");
//      &FORCE("input",  "hart${i}_dcache_disable_init");
//  &ENDIF("NDS_IO_HART${i}") if(${i}!=0);
//}
//
//&IFDEF("NDS_IO_ICACHE0");
//&FORCE("wire", "core0_icache_disable_init");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "core1_icache_disable_init");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_ICACHE0");
//
//&IFDEF("NDS_IO_DCACHE0");
//&FORCE("wire", "core0_dcache_disable_init");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&FORCE("wire", "core1_dcache_disable_init");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_DCACHE0");
//
//:`ifdef NDS_IO_ICACHE0
//:assign core0_icache_disable_init = hart0_icache_disable_init;
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign core1_icache_disable_init = hart1_icache_disable_init;
//:`endif // NDS_IO_DCLS_SPLIT
//:`endif // NDS_IO_ICACHE0
//
//:`ifdef NDS_IO_DCACHE0
//:assign core0_dcache_disable_init = hart0_dcache_disable_init;
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign core1_dcache_disable_init = hart1_dcache_disable_init;
//:`endif // NDS_IO_DCLS_SPLIT
//:`endif // NDS_IO_DCACHE0
//
//###############################################################################
//# Fault Injection
//###############################################################################
//&IFDEF("NDS_IO_DCLS");
//&FORCE("input", "dcls_p_clk");
//&FORCE("input", "dcls_p_reset_n");
//&FORCE("input", "dcls_r_clk");
//&FORCE("input", "dcls_r_reset_n");
//
//&KV_DCLS_ASSIGN_INJECT_FAULT_SIGNALS("$ENV{PVC_LOCALDIR}/andes_ip/kv_core/top/hdl/nds_scpu_cluster.v");
//
//
//&ENDIF("NDS_IO_DCLS");
//
//#:`ifdef NDS_IO_DCLS
//#:assign dcls_p_clk = core0_clk;
//#:assign dcls_p_reset_n = core0_reset_n;
//#:assign dcls_r_clk = core0_clk;
//#:assign dcls_r_reset_n = core0_reset_n;
//#:`endif // NDS_IO_DCLS
//
//###############################################################################
//# Bus - SYS
//###############################################################################
//&FORCE("output", "sys_arid[BIU_ID_MSB:0]");
//&FORCE("output", "sys_araddr[ADDR_MSB:0]");
//&FORCE("output", "sys_arlen[7:0]");
//&FORCE("output", "sys_arsize[2:0]");
//&FORCE("output", "sys_arburst[1:0]");
//&FORCE("output", "sys_arlock");
//&FORCE("output", "sys_arcache[3:0]");
//&FORCE("output", "sys_arprot[2:0]");
//&FORCE("output", "sys_arvalid");
//&FORCE("input",  "sys_arready");
//
//&FORCE("output", "sys_awid[BIU_ID_MSB:0]");
//&FORCE("output", "sys_awaddr[ADDR_MSB:0]");
//&FORCE("output", "sys_awlen[7:0]");
//&FORCE("output", "sys_awsize[2:0]");
//&FORCE("output", "sys_awburst[1:0]");
//&FORCE("output", "sys_awlock");
//&FORCE("output", "sys_awcache[3:0]");
//&FORCE("output", "sys_awprot[2:0]");
//&FORCE("output", "sys_awvalid");
//&FORCE("input",  "sys_awready");
//
//&FORCE("output", "sys_wdata[(BIU_DATA_WIDTH-1):0]");
//&FORCE("output", "sys_wstrb[((BIU_DATA_WIDTH/8)-1):0]");
//&FORCE("output", "sys_wlast");
//&FORCE("output", "sys_wvalid");
//&FORCE("input",  "sys_wready");
//
//&FORCE("input",  "sys_bid[BIU_ID_MSB:0]");
//&FORCE("input",  "sys_bresp[1:0]");
//&FORCE("input",  "sys_bvalid");
//&FORCE("output", "sys_bready");
//
//&FORCE("input",  "sys_rid[BIU_ID_MSB:0]");
//&FORCE("input",  "sys_rdata[(BIU_DATA_WIDTH-1):0]");
//&FORCE("input",  "sys_rresp[1:0]");
//&FORCE("input",  "sys_rlast");
//&FORCE("input",  "sys_rvalid");
//&FORCE("output", "sys_rready");
//
//###############################################################################
//# Bus - Flash
//###############################################################################
//&FORCE("output", "flash0_arid[BIU_ID_MSB:0]");
//&FORCE("output", "flash0_araddr[ADDR_MSB:0]");
//&FORCE("output", "flash0_arlen[7:0]");
//&FORCE("output", "flash0_arsize[2:0]");
//&FORCE("output", "flash0_arburst[1:0]");
//&FORCE("output", "flash0_arlock");
//&FORCE("output", "flash0_arcache[3:0]");
//&FORCE("output", "flash0_arprot[2:0]");
//&FORCE("output", "flash0_arvalid");
//&FORCE("input",  "flash0_arready");
//
//&FORCE("output", "flash0_awid[BIU_ID_MSB:0]");
//&FORCE("output", "flash0_awaddr[ADDR_MSB:0]");
//&FORCE("output", "flash0_awlen[7:0]");
//&FORCE("output", "flash0_awsize[2:0]");
//&FORCE("output", "flash0_awburst[1:0]");
//&FORCE("output", "flash0_awlock");
//&FORCE("output", "flash0_awcache[3:0]");
//&FORCE("output", "flash0_awprot[2:0]");
//&FORCE("output", "flash0_awvalid");
//&FORCE("input",  "flash0_awready");
//
//&FORCE("output", "flash0_wdata[(BIU_DATA_WIDTH-1):0]");
//&FORCE("output", "flash0_wstrb[((BIU_DATA_WIDTH/8)-1):0]");
//&FORCE("output", "flash0_wlast");
//&FORCE("output", "flash0_wvalid");
//&FORCE("input",  "flash0_wready");
//
//&FORCE("input",  "flash0_bid[BIU_ID_MSB:0]");
//&FORCE("input",  "flash0_bresp[1:0]");
//&FORCE("input",  "flash0_bvalid");
//&FORCE("output", "flash0_bready");
//
//&FORCE("input",  "flash0_rid[BIU_ID_MSB:0]");
//&FORCE("input",  "flash0_rdata[(BIU_DATA_WIDTH-1):0]");
//&FORCE("input",  "flash0_rresp[1:0]");
//&FORCE("input",  "flash0_rlast");
//&FORCE("input",  "flash0_rvalid");
//&FORCE("output", "flash0_rready");
//
//###############################################################################
//# 
//###############################################################################
//
//&FORCE("input",  "int_src[31:1]");
//
//&IFDEF("NDS_IO_SLAVEPORT_COMMON_X1");
//      &FORCE("input",  "slv_araddr[ADDR_MSB:0]");
//      &FORCE("input",  "slv_arburst[1:0]");
//      &FORCE("input",  "slv_arcache[3:0]");
//      &FORCE("input",  "slv_arid[(BIU_ID_MSB+4):0]");
//      &FORCE("input",  "slv_arlen[7:0]");
//      &FORCE("input",  "slv_arlock");
//      &FORCE("input",  "slv_arprot[2:0]");
//      &FORCE("input",  "slv_arsize[2:0]");
//      &FORCE("input",  "slv_arvalid");
//      &FORCE("output", "slv_arready");
//
//      &FORCE("input",  "slv_awaddr[ADDR_MSB:0]");
//      &FORCE("input",  "slv_awburst[1:0]");
//      &FORCE("input",  "slv_awcache[3:0]");
//      &FORCE("input",  "slv_awid[(BIU_ID_MSB+4):0]");
//      &FORCE("input",  "slv_awlen[7:0]");
//      &FORCE("input",  "slv_awlock");
//      &FORCE("input",  "slv_awprot[2:0]");
//      &FORCE("input",  "slv_awsize[2:0]");
//      &FORCE("input",  "slv_awvalid");
//      &FORCE("output", "slv_awready");
//
//      &FORCE("input",  "slv_wvalid");
//      &FORCE("output", "slv_wready");
//      &FORCE("input",  "slv_wdata[(SLVPORT_DATA_WIDTH-1):0]");
//      &FORCE("input",  "slv_wlast");
//      &FORCE("input",  "slv_wstrb[((SLVPORT_DATA_WIDTH/8)-1):0]");
//
//      &FORCE("output", "slv_bid[(BIU_ID_MSB+4):0]");
//      &FORCE("output", "slv_bresp[1:0]");
//      &FORCE("output", "slv_bvalid");
//      &FORCE("input",  "slv_bready");
//
//      &FORCE("output", "slv_rdata[(SLVPORT_DATA_WIDTH-1):0]");
//      &FORCE("output", "slv_rid[(BIU_ID_MSB+4):0]");
//      &FORCE("output", "slv_rlast");
//      &FORCE("output", "slv_rresp[1:0]");
//      &FORCE("output", "slv_rvalid");
//      &FORCE("input",  "slv_rready");
//&ENDIF("NDS_IO_SLAVEPORT_COMMON_X1");
//
//for (my $i=0; $i < 2;$i++) {
//&IFDEF("NDS_IO_SLAVEPORT_COMMON_X1");
//      if ($i != 0) {
//          &IFDEF("NDS_IO_DCLS_SPLIT");
//      }
//              :`ifdef NDS_IO_SLAVEPORT_COMMON_X1
//              :       `ifdef ATCBUSDEC302_SLV%d_SUPPORT       :: $i + 1
//              :               assign core${i}_slv_awuser = busdec2slv_awaddr[SLVPORT_DLM_SEL_BIT];
//              :               assign core${i}_slv_aruser = busdec2slv_araddr[SLVPORT_DLM_SEL_BIT];
//              :       `endif // ATCBUSDEC302_SLV%d_SUPPORT    :: $i + 1
//              :`endif // NDS_IO_SLAVEPORT_COMMON_X1
//              &FORCE("wire",  "core${i}_slv_araddr[ADDR_MSB:0]");
//              &FORCE("wire",  "core${i}_slv_arburst[1:0]");
//              &FORCE("wire",  "core${i}_slv_arcache[3:0]");
//              &FORCE("wire",  "core${i}_slv_arid[(SLVPORT_ID_WIDTH-1):0]");
//              &FORCE("wire",  "core${i}_slv_arlen[7:0]");
//              &FORCE("wire",  "core${i}_slv_arlock");
//              &FORCE("wire",  "core${i}_slv_arprot[2:0]");
//              &FORCE("wire",  "core${i}_slv_arsize[2:0]");
//              &FORCE("wire",  "core${i}_slv_arvalid");
//              &FORCE("wire",  "core${i}_slv_arready");
//              &FORCE("wire",  "core${i}_slv_aruser");
//
//              &FORCE("wire",  "core${i}_slv_awaddr[ADDR_MSB:0]");
//              &FORCE("wire",  "core${i}_slv_awburst[1:0]");
//              &FORCE("wire",  "core${i}_slv_awcache[3:0]");
//              &FORCE("wire",  "core${i}_slv_awid[(SLVPORT_ID_WIDTH-1):0]");
//              &FORCE("wire",  "core${i}_slv_awlen[7:0]");
//              &FORCE("wire",  "core${i}_slv_awlock");
//              &FORCE("wire",  "core${i}_slv_awprot[2:0]");
//              &FORCE("wire",  "core${i}_slv_awsize[2:0]");
//              &FORCE("wire",  "core${i}_slv_awvalid");
//              &FORCE("wire",  "core${i}_slv_awready");
//              &FORCE("wire",  "core${i}_slv_awuser");
//
//              &FORCE("wire",  "core${i}_slv_wvalid");
//              &FORCE("wire",  "core${i}_slv_wready");
//              &FORCE("wire",  "core${i}_slv_wdata[(SLVPORT_DATA_WIDTH-1):0]");
//              &FORCE("wire",  "core${i}_slv_wlast");
//              &FORCE("wire",  "core${i}_slv_wstrb[((SLVPORT_DATA_WIDTH/8)-1):0]");
//
//              &FORCE("wire",  "core${i}_slv_bid[(SLVPORT_ID_WIDTH-1):0]");
//              &FORCE("wire",  "core${i}_slv_bresp[1:0]");
//              &FORCE("wire",  "core${i}_slv_bvalid");
//              &FORCE("wire",  "core${i}_slv_bready");
//
//              &FORCE("wire",  "core${i}_slv_rdata[(SLVPORT_DATA_WIDTH-1):0]");
//              &FORCE("wire",  "core${i}_slv_rid[(SLVPORT_ID_WIDTH-1):0]");
//              &FORCE("wire",  "core${i}_slv_rlast");
//              &FORCE("wire",  "core${i}_slv_rresp[1:0]");
//              &FORCE("wire",  "core${i}_slv_rvalid");
//              &FORCE("wire",  "core${i}_slv_rready");
//      if ($i != 0) {
//          &ENDIF("NDS_IO_DCLS_SPLIT");
//      }
//&ENDIF("NDS_IO_SLAVEPORT_COMMON_X1");
//}
//
//for (my $i=0; $i < 2;$i++) {
//&IFDEF("NDS_IO_SLAVEPORT_QOS_X1");
//      if ($i != 0) {
//          &IFDEF("NDS_IO_DCLS_SPLIT");
//      }
//	&FORCE("wire",  "core${i}_slv_awqos[3:0]");
//	&FORCE("wire",  "core${i}_slv_arqos[3:0]");
//      if ($i != 0) {
//      :`ifdef NDS_IO_DCLS_SPLIT
//      }
//      :	`ifdef NDS_IO_SLAVEPORT_QOS_X1
//      :       	assign core${i}_slv_awqos = 4'b0;
//      :       	assign core${i}_slv_arqos = 4'b0;
//      :	`endif
//      if ($i != 0) {
//      :`endif
//      }
//      if ($i != 0) {
//          &ENDIF("NDS_IO_DCLS_SPLIT");
//      }
//&ENDIF("NDS_IO_SLAVEPORT_QOS_X1");
//}

//for (my $i=0; $i < 2;$i++) {
//&IFDEF("NDS_IO_LM_QOS");
//      if ($i != 0) {
//          &IFDEF("NDS_IO_DCLS_SPLIT");
//      }
//	&FORCE("wire",  "core${i}_ifu_ilm_qos[3:0]");
//	&FORCE("wire",  "core${i}_lsu_dlm_qos[3:0]");
//	&FORCE("wire",  "core${i}_lsu_ilm_qos[3:0]");
//      if ($i != 0) {
//      :`ifdef NDS_IO_DCLS_SPLIT
//      }
//      :	`ifdef NDS_IO_LM_QOS
//      :	assign core${i}_ifu_ilm_qos = 4'b0;
//      :	assign core${i}_lsu_dlm_qos = 4'b0;
//      :	assign core${i}_lsu_ilm_qos = 4'b0;
//      :	`endif
//      if ($i != 0) {
//      :`endif
//      }
//      if ($i != 0) {
//          &ENDIF("NDS_IO_DCLS_SPLIT");
//      }
//&ENDIF("NDS_IO_LM_QOS");
//}

//
//#------------------------------------------------------------------------------
//# SPP
//#------------------------------------------------------------------------------
//
//&CONNECT("u_cluster.spp_aclk_en",   "axi_bus_clk_en");
//
//&IFDEF("NDS_IO_SPP");
//my @spp_sig = qw(
//	araddr arburst arcache arid arlen arlock arprot arready arsize arvalid
//	awaddr awburst awcache awid awlen awlock awprot awready awsize awvalid
//	bid bready bresp bvalid
//	rdata rid rlast rready rresp rvalid
//	wdata wlast wready wstrb wvalid
//);
//
//foreach my $sig (@spp_sig) {
//      &FORCE("wire",	"spp_${sig}");
//}
//
//&ENDIF("NDS_IO_SPP");
//
//
// :`ifdef NDS_IO_SPP
// :assign busdec_us_araddr  = axi_spp_araddr;
// :assign busdec_us_arburst = axi_spp_arburst;
// :assign busdec_us_arcache = axi_spp_arcache;
// :assign busdec_us_arid    = {{((BIU_ID_WIDTH+4)-`NDS_SPP_ID_WIDTH){1'b0}}, spp_arid};
// :assign busdec_us_arlen   = axi_spp_arlen;
// :assign busdec_us_arlock  = axi_spp_arlock;
// :assign busdec_us_arprot  = axi_spp_arprot;
// :assign busdec_us_arsize  = axi_spp_arsize;
// :assign busdec_us_arvalid = axi_spp_arvalid;
// :assign axi_spp_arready   = busdec_us_arready;
//
// :assign busdec_us_awaddr  = axi_spp_awaddr;
// :assign busdec_us_awburst = axi_spp_awburst;
// :assign busdec_us_awcache = axi_spp_awcache;
// :assign busdec_us_awid    = {{((BIU_ID_WIDTH+4)-`NDS_SPP_ID_WIDTH){1'b0}}, spp_awid};
// :assign busdec_us_awlen   = axi_spp_awlen;
// :assign busdec_us_awlock  = axi_spp_awlock;
// :assign busdec_us_awprot  = axi_spp_awprot;
// :assign busdec_us_awsize  = axi_spp_awsize;
// :assign busdec_us_awvalid = axi_spp_awvalid;
// :assign axi_spp_awready   = busdec_us_awready;
//
// :assign busdec_us_wdata  = axi_spp_wdata;
// :assign busdec_us_wlast  = axi_spp_wlast;
// :assign busdec_us_wstrb  = axi_spp_wstrb;
// :assign busdec_us_wvalid = axi_spp_wvalid;
// :assign axi_spp_wready   = busdec_us_wready;
//
// :assign axi_spp_bid      = busdec_us_bid[`NDS_SPP_ID_WIDTH-1:0];
// :assign axi_spp_bresp    = busdec_us_bresp;
// :assign axi_spp_bvalid   = busdec_us_bvalid;
// :assign axi_spp_rdata    = busdec_us_rdata;
// :assign axi_spp_rid      = busdec_us_rid[`NDS_SPP_ID_WIDTH-1:0];
// :assign busdec_us_bready = axi_spp_bready;
//
// :assign axi_spp_rlast    = busdec_us_rlast;
// :assign axi_spp_rresp    = busdec_us_rresp;
// :assign axi_spp_rvalid   = busdec_us_rvalid;
// :assign busdec_us_rready = axi_spp_rready;
// :`endif // NDS_IO_SPP
//
//###############################################################################
//# LM Reset
//###############################################################################
//&IFDEF("NDS_IO_LM_RESET");
//&FORCE("wire", "core0_lm_reset_n");
//&ENDIF("NDS_IO_LM_RESET");
//
//&IFDEF("NDS_IO_DCLS");
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&IFDEF("NDS_IO_LM_RESET");
//&FORCE("wire", "core1_lm_reset_n");
//&ENDIF("NDS_IO_LM_RESET");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_DCLS");
//
//#------------------------------------------------------------------------------
//# DLM RAM
//#------------------------------------------------------------------------------
//
//&IFDEF("NDS_IO_DLM_TL_UL");
//
//for (my $i=0; $i<2; $i++) {
//&IFDEF("NDS_IO_DCLS_SPLIT") if(${i});;
//
//&FORCE("wire", "core${i}_dlm_a_parity[7:0]");
//&FORCE("wire", "core${i}_dlm_d_parity[7:0]");
//
//&FORCE("wire", "core${i}_dlm_reset_n");
//
//&IFDEF("NDS_IO_DLM_RAM_ECC");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/memory/model/kv_dlm_wait_fusa_ecc_ram.v", "u_core${i}_dlm_ram0", {
//      DLM_RAM_AMSB    => "`NDS_DLM_AMSB",
//      DLM_RAM_DW      => "`NDS_DLM_RAM_DW",
//      DLM_RAM_BWEW    => "`NDS_DLM_RAM_BWEW",
//      XLEN            => "`NDS_XLEN",
//});
//
//&ELSE("NDS_IO_DLM_RAM_ECC");
//
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/memory/model/kv_dlm_wait_ram.v", "u_core${i}_dlm_ram0", {
//      DLM_RAM_AMSB    => "`NDS_DLM_AMSB",
//      DLM_RAM_DW      => "`NDS_DLM_RAM_DW",
//      DLM_RAM_BWEW    => "`NDS_DLM_RAM_BWEW",
//      XLEN            => "`NDS_XLEN",
//});
//
//&ENDIF("NDS_IO_DLM_RAM_ECC");
//
//my @dlm_wait = qw(
//      dlm_a_addr dlm_a_data dlm_a_mask dlm_a_opcode dlm_a_parity dlm_a_ready dlm_a_size dlm_a_user dlm_a_valid
//      dlm_d_data dlm_d_denied dlm_d_parity dlm_d_ready dlm_d_valid
//);
//
//foreach my $sig (@dlm_wait) {
//      &CONNECT("u_core${i}_dlm_ram0.${sig}", "core${i}_${sig}");
//}
//&CONNECT("u_core${i}_dlm_ram0.lm_clk", "lm_clk[$i]");
//&CONNECT("u_core${i}_dlm_ram0.lm_reset_n", "core${i}_dlm_reset_n");
//
//&ENDIF("NDS_IO_DCLS_SPLIT") if(${i});;
//}
//
//&ENDIF("NDS_IO_DLM_TL_UL");
//
//:`ifdef NDS_IO_DLM_TL_UL
//:assign core0_dlm_reset_n = core0_lm_reset_n;
//:`ifdef NDS_IO_DCLS_SPLIT
//:assign core1_dlm_reset_n = core1_lm_reset_n;
//:`endif // NDS_IO_DCLS
//:`endif // NDS_IO_DLM_TL_UL
// #------------------------------------------------------------------------------
// # ILM RAM
// #------------------------------------------------------------------------------
//
//&IFDEF("NDS_IO_ILM_TL_UL");
//
//for (my $i=0; $i<2; $i++) {
//
//
//&IFDEF("NDS_IO_DCLS_SPLIT") if(${i});;
//&DANGLER("nds_unused_tl_ul_core${i}_ilm0_ctrl_out");
//&DANGLER("nds_unused_tl_ul_core${i}_ilm1_ctrl_out");
//&FORCE("wire", "core${i}_ilm_a_parity0[7:0]");
//&FORCE("wire", "core${i}_ilm_a_parity1[7:0]");
//&FORCE("wire", "core${i}_ilm_d_parity0[7:0]");
//&FORCE("wire", "core${i}_ilm_d_parity1[7:0]");
//&FORCE("wire", "core${i}_ilm_reset_n");
//
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/macro/hdl/sample_kv_clk_gen.v", "u_core${i}_ilm_clock_gen", {
//      RATIO   => 2,
//});
//&CONNECT("u_core${i}_ilm_clock_gen", {
//      clk_in  => "lm_clk[$i]",
//      resetn  => "core${i}_ilm_reset_n",
//      clk_en  => "core${i}_ilm_ram_clk_en",
//      clk_out => "core${i}_ilm_ram_clk",
//});
//&DANGLER("core${i}_ilm_a_user");
//&DANGLER("core${i}_ilm_a_addr");
//&DANGLER("core${i}_ilm_a_parity0");
//&DANGLER("core${i}_ilm_a_parity1");
//&DANGLER("core${i}_ilm_d_parity0");
//&DANGLER("core${i}_ilm_d_parity1");
//
//&FORCE("wire", "core${i}_ilm_a_parity0_in[ILM_TL_UL_EW-1:0]");
//&FORCE("wire", "core${i}_ilm_a_parity1_in[ILM_TL_UL_EW-1:0]");
//&FORCE("wire", "core${i}_ilm_d_parity0_out[ILM_TL_UL_EW-1:0]");
//&FORCE("wire", "core${i}_ilm_d_parity1_out[ILM_TL_UL_EW-1:0]");
//
//&FORCE("wire", "core${i}_ilm0_addr[ILM_TL_UL_RAM_AW-1:0]");
//&FORCE("wire", "core${i}_ilm1_addr[ILM_TL_UL_RAM_AW-1:0]");
//
//&FORCE("wire", "core${i}_ilm0_wdata[ILM_TL_UL_RAM_DW-1:0]");
//&FORCE("wire", "core${i}_ilm1_wdata[ILM_TL_UL_RAM_DW-1:0]");
//
//&FORCE("wire", "core${i}_ilm0_rdata[ILM_TL_UL_RAM_DW-1:0]");
//&FORCE("wire", "core${i}_ilm1_rdata[ILM_TL_UL_RAM_DW-1:0]");
//
//&FORCE("wire", "core${i}_ilm0_bwe[ILM_TL_UL_RAM_BWEW-1:0]");
//&FORCE("wire", "core${i}_ilm1_bwe[ILM_TL_UL_RAM_BWEW-1:0]");
//
//&INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcrambrg500/hdl/atcrambrg500.v", "u_core${i}_ilm_ram_brg", {
//      US_AW                   => ILM_TL_UL_AW,
//      DS_DW                   => ILM_TL_UL_RAM_DW,
//});
//&CONNECT("u_core${i}_ilm_ram_brg", {
//      clk             => "lm_clk[$i]",
//      clk_en          => "core${i}_ilm_ram_clk_en",
//      resetn          => "core${i}_ilm_reset_n",
//
//      a_valid         => "core${i}_ilm_a_valid",
//      a_ready         => "core${i}_ilm_a_ready",
//      a_addr          => "{core${i}_ilm_a_addr, 3'b0}",
//      a_data          => "core${i}_ilm_a_data",
//      a_opcode        => "core${i}_ilm_a_opcode",
//      a_mask          => "core${i}_ilm_a_mask",
//      a_size          => "core${i}_ilm_a_size",
//      a_parity0       => "core${i}_ilm_a_parity0_in",
//      a_parity1       => "core${i}_ilm_a_parity1_in",
//
//      d_valid         => "core${i}_ilm_d_valid",
//      d_ready         => "core${i}_ilm_d_ready",
//      d_data          => "core${i}_ilm_d_data",
//      d_parity0       => "core${i}_ilm_d_parity0_out",
//      d_parity1       => "core${i}_ilm_d_parity1_out",
//      d_denied        => "core${i}_ilm_d_denied",
//
//      ram0_cs         => "core${i}_ilm0_cs",
//      ram0_we         => "core${i}_ilm0_we",
//      ram0_addr       => "core${i}_ilm0_addr",
//      ram0_wdata      => "core${i}_ilm0_wdata",
//      ram0_bwe        => "core${i}_ilm0_bwe",
//      ram0_rdata      => "core${i}_ilm0_rdata",
//
//      ram1_cs         => "core${i}_ilm1_cs",
//      ram1_we         => "core${i}_ilm1_we",
//      ram1_addr       => "core${i}_ilm1_addr",
//      ram1_wdata      => "core${i}_ilm1_wdata",
//      ram1_bwe        => "core${i}_ilm1_bwe",
//      ram1_rdata      => "core${i}_ilm1_rdata",
//});
//&IFDEF("NDS_IO_ILM_RAM_ECC");
//&GENERATE_IF("ILM_TL_UL_RAM_NUM >= 1", "gen_tl_ul_core${i}_ram0");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/memory/model/kv_ilm_fusa_ecc_ram.v", "u_ilm_tl_ul_core${i}_ram0", {
//      ILM_RAM_AW      =>      ILM_TL_UL_RAM_AW,
//      ILM_RAM_DW      =>      ILM_TL_UL_RAM_DW,
//      ILM_RAM_CTRL_IN_WIDTH   => "`NDS_ILM_RAM_CTRL_IN_WIDTH",
//      ILM_RAM_CTRL_OUT_WIDTH  => "`NDS_ILM_RAM_CTRL_OUT_WIDTH",
//});
// &CONNECT("u_ilm_tl_ul_core${i}_ram0", {
//      p_clk           =>      "core${i}_ilm_ram_clk",
//      r_clk           =>      "core${i}_ilm_ram_clk",
//      ilm_p_cs        =>      "core${i}_ilm0_cs",
//      ilm_p_we        =>      "core${i}_ilm0_we",
//      ilm_p_addr      =>      "core${i}_ilm0_addr",
//      ilm_r_cs        =>      "core${i}_ilm0_cs",
//      ilm_r_we        =>      "core${i}_ilm0_we",
//      ilm_r_addr      =>      "core${i}_ilm0_addr",
//      ilm_wdata       =>      "core${i}_ilm0_wdata",
//      ilm_rdata       =>      "core${i}_ilm0_rdata",
//      ilm_ctrl_in     =>      "{`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}",
//      ilm_ctrl_out    =>      "nds_unused_tl_ul_core${i}_ilm0_ctrl_out",
//});
//&ENDGENERATE();
//&GENERATE_IF("ILM_TL_UL_RAM_NUM >= 2", "gen_tl_ul_core${i}_ram1");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/memory/model/kv_ilm_fusa_ecc_ram.v", "u_ilm_tl_ul_core${i}_ram1", {
//      ILM_RAM_AW      =>      ILM_TL_UL_RAM_AW,
//      ILM_RAM_DW      =>      ILM_TL_UL_RAM_DW,
//      ILM_RAM_CTRL_IN_WIDTH   => "`NDS_ILM_RAM_CTRL_IN_WIDTH",
//      ILM_RAM_CTRL_OUT_WIDTH  => "`NDS_ILM_RAM_CTRL_OUT_WIDTH",
//});
//&CONNECT("u_ilm_tl_ul_core${i}_ram1", {
//      p_clk           =>      "core${i}_ilm_ram_clk",
//      r_clk           =>      "core${i}_ilm_ram_clk",
//      ilm_p_cs        =>      "core${i}_ilm1_cs",
//      ilm_p_we        =>      "core${i}_ilm1_we",
//      ilm_p_addr      =>      "core${i}_ilm1_addr",
//      ilm_r_cs        =>      "core${i}_ilm1_cs",
//      ilm_r_we        =>      "core${i}_ilm1_we",
//      ilm_r_addr      =>      "core${i}_ilm1_addr",
//      ilm_wdata       =>      "core${i}_ilm1_wdata",
//      ilm_rdata       =>      "core${i}_ilm1_rdata",
//      ilm_ctrl_in     =>      "{`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}",
//      ilm_ctrl_out    =>      "nds_unused_tl_ul_core${i}_ilm1_ctrl_out",
//});
//&ENDGENERATE();
//&ELSE("NDS_IO_ILM_RAM_ELSE");
//
//&GENERATE_IF("ILM_TL_UL_RAM_NUM >= 1", "gen_tl_ul_core${i}_ram0");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/memory/model/kv_ilm_ram.v", "u_ilm_tl_ul_core${i}_ram0", {
//      ILM_RAM_AW      =>      ILM_TL_UL_RAM_AW,
//      ILM_RAM_DW      =>      ILM_TL_UL_RAM_DW,
//      ILM_RAM_BWEW    =>      ILM_TL_UL_RAM_BWEW,
//      ILM_RAM_CTRL_IN_WIDTH   => "`NDS_ILM_RAM_CTRL_IN_WIDTH",
//      ILM_RAM_CTRL_OUT_WIDTH  => "`NDS_ILM_RAM_CTRL_OUT_WIDTH",
//});
//&CONNECT("u_ilm_tl_ul_core${i}_ram0", {
//     clk              =>      "core${i}_ilm_ram_clk",
//     ilm_cs           =>      "core${i}_ilm0_cs",
//     ilm_we           =>      "core${i}_ilm0_we",
//     ilm_byte_we      =>      "core${i}_ilm0_bwe",
//     ilm_addr         =>      "core${i}_ilm0_addr",
//     ilm_wdata        =>      "core${i}_ilm0_wdata",
//     ilm_rdata        =>      "core${i}_ilm0_rdata",
//      ilm_ctrl_in     =>      "{`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}",
//      ilm_ctrl_out    =>      "nds_unused_tl_ul_core${i}_ilm0_ctrl_out",
//});
//&ENDGENERATE();
//
//&GENERATE_IF("ILM_TL_UL_RAM_NUM >= 2", "gen_tl_ul_core${i}_ram1");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/memory/model/kv_ilm_ram.v", "u_ilm_tl_ul_core${i}_ram1", {
//      ILM_RAM_AW      =>      ILM_TL_UL_RAM_AW,
//      ILM_RAM_DW      =>      ILM_TL_UL_RAM_DW,
//      ILM_RAM_BWEW    =>      ILM_TL_UL_RAM_BWEW,
//      ILM_RAM_CTRL_IN_WIDTH   => "`NDS_ILM_RAM_CTRL_IN_WIDTH",
//      ILM_RAM_CTRL_OUT_WIDTH  => "`NDS_ILM_RAM_CTRL_OUT_WIDTH",
//});
//&CONNECT("u_ilm_tl_ul_core${i}_ram1", {
//     clk              =>      "core${i}_ilm_ram_clk",
//     ilm_cs           =>      "core${i}_ilm1_cs",
//     ilm_we           =>      "core${i}_ilm1_we",
//     ilm_byte_we      =>      "core${i}_ilm1_bwe",
//     ilm_addr         =>      "core${i}_ilm1_addr",
//     ilm_wdata        =>      "core${i}_ilm1_wdata",
//     ilm_rdata        =>      "core${i}_ilm1_rdata",
//      ilm_ctrl_in     =>      "{`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}",
//      ilm_ctrl_out    =>      "nds_unused_tl_ul_core${i}_ilm1_ctrl_out",
//});
//&ENDGENERATE();
//&ENDIF("NDS_IO_ILM_RAM_ECC");
//
//&ENDIF("NDS_IO_DCLS_SPLIT") if(${i});;
//}
//
//&ENDIF("NDS_IO_ILM_TL_UL");
//
//:`ifdef NDS_IO_ILM_TL_UL
//for (my $i=0; $i<2; $i++) {
//:`ifdef NDS_IO_HART${i}
//:assign core${i}_ilm_reset_n = core${i}_lm_reset_n;
//:assign core${i}_ilm_d_parity0[ILM_TL_UL_EW-1:0] = core${i}_ilm_d_parity0_out[ILM_TL_UL_EW-1:0];
//:assign core${i}_ilm_d_parity1[ILM_TL_UL_EW-1:0] = core${i}_ilm_d_parity1_out[ILM_TL_UL_EW-1:0];
//:generate
//:if (ILM_ECC_SUPPORT && (XLEN == 32)) begin : gen_core${i}_ilm_parity_32
//:        wire nds_unused_core${i}_ilm_a_parity0 = core${i}_ilm_a_parity0[7];
//:        wire nds_unused_core${i}_ilm_a_parity1 = core${i}_ilm_a_parity1[7];
//:        assign core${i}_ilm_a_parity0_in = core${i}_ilm_a_parity0[6:0];
//:        assign core${i}_ilm_a_parity1_in = core${i}_ilm_a_parity1[6:0];
//:        assign core${i}_ilm_d_parity0[7] = 1'b0;
//:        assign core${i}_ilm_d_parity1[7] = 1'b0;
//:end
//:else if (ILM_ECC_SUPPORT && (XLEN == 64)) begin : gen_core${i}_ilm_parity_64
//:        assign core${i}_ilm_a_parity0_in = core${i}_ilm_a_parity0[7:0];
//:        assign core${i}_ilm_a_parity1_in = core${i}_ilm_a_parity1[7:0];
//:end
//:else begin : gen_core${i}_ilm_parity_no_ecc
//:        wire nds_unused_core${i}_ilm_a_parity0 = |core${i}_ilm_a_parity0;
//:        wire nds_unused_core${i}_ilm_a_parity1 = |core${i}_ilm_a_parity1;
//:        assign core${i}_ilm_a_parity0_in = 1'b0;
//:        assign core${i}_ilm_a_parity1_in = 1'b0;
//:        assign core${i}_ilm_d_parity0[7:1] = 7'b0;
//:        assign core${i}_ilm_d_parity1[7:1] = 7'b0;
//:end
//:endgenerate
//:
//:`ifdef NDS_IO_ILM_RAM_ECC
//:wire nds_unused_core${i}_bwe = (|core${i}_ilm0_bwe) | (|core${i}_ilm1_bwe);
//:`endif // NDS_IO_ILM_RAM_ECC
//:generate
//:if (ILM_TL_UL_RAM_NUM < 2) begin : gen_ilm_tl_ul_core${i}_ram1_stub
//:        wire nds_unused_core${i}_ram1_if = core${i}_ilm1_cs | core${i}_ilm1_we;
//:        assign core${i}_ilm1_rdata = {ILM_TL_UL_RAM_DW{1'b0}};
//:        assign nds_unused_tl_ul_core${i}_ilm1_ctrl_out = {`NDS_ILM_RAM_CTRL_OUT_WIDTH{1'b0}};
//:end
//:endgenerate
//:`endif // NDS_IO_HART${i}
//}
//:`endif // NDS_IO_ILM_TL_UL
//
// #------------------------------------------------------------------------------
// # BMC
// #------------------------------------------------------------------------------
//      sub CONNECT_AXI_BMC {
//              ($inst, $i, $ms, $prefix) = @_;
//              if ($prefix =~ m/NC/) {
//                      if ($ms =~ m/m/) {
//                              &IFDEF("ATCBMC301_MST${i}_SUPPORT");
//                                      &CONNECT("$inst.us${i}_arready",        "nds_unused_${inst}_us${i}_arready");
//                                      &CONNECT("$inst.us${i}_awready",        "nds_unused_${inst}_us${i}_awready");
//                                      &CONNECT("$inst.us${i}_bid",    "nds_unused_${inst}_us${i}_bid");
//                                      &CONNECT("$inst.us${i}_bresp",  "nds_unused_${inst}_us${i}_bresp");
//                                      &CONNECT("$inst.us${i}_bvalid", "nds_unused_${inst}_us${i}_bvalid");
//                                      &CONNECT("$inst.us${i}_rdata",  "nds_unused_${inst}_us${i}_rdata");
//                                      &CONNECT("$inst.us${i}_rid",    "nds_unused_${inst}_us${i}_rid");
//                                      &CONNECT("$inst.us${i}_rlast",  "nds_unused_${inst}_us${i}_rlast");
//                                      &CONNECT("$inst.us${i}_rresp",  "nds_unused_${inst}_us${i}_rresp");
//                                      &CONNECT("$inst.us${i}_rvalid", "nds_unused_${inst}_us${i}_rvalid");
//                                      &CONNECT("$inst.us${i}_wready", "nds_unused_${inst}_us${i}_wready");
//                                      &CONNECT("$inst.us${i}_araddr", "{ADDR_WIDTH{1'b0}}");
//                                      &CONNECT("$inst.us${i}_arburst",        "2'b0");
//                                      &CONNECT("$inst.us${i}_arcache",        "4'b0");
//                                      &CONNECT("$inst.us${i}_arid",   "{(BIU_ID_WIDTH){1'b0}}");
//                                      &CONNECT("$inst.us${i}_arlen",  "8'b0");
//                                      &CONNECT("$inst.us${i}_arlock", "1'b0");
//                                      &CONNECT("$inst.us${i}_arprot", "3'b0");
//                                      &CONNECT("$inst.us${i}_arsize", "3'b0");
//                                      &CONNECT("$inst.us${i}_arvalid",        "1'b0");
//                                      &CONNECT("$inst.us${i}_awaddr", "{ADDR_WIDTH{1'b0}}");
//                                      &CONNECT("$inst.us${i}_awburst",        "2'b0");
//                                      &CONNECT("$inst.us${i}_awcache",        "4'b0");
//                                      &CONNECT("$inst.us${i}_awid",   "{(BIU_ID_WIDTH){1'b0}}");
//                                      &CONNECT("$inst.us${i}_awlen",  "8'b0");
//                                      &CONNECT("$inst.us${i}_awlock", "1'b0");
//                                      &CONNECT("$inst.us${i}_awprot", "3'b0");
//                                      &CONNECT("$inst.us${i}_awsize", "3'b0");
//                                      &CONNECT("$inst.us${i}_awvalid",        "1'b0");
//                                      &CONNECT("$inst.us${i}_bready", "1'b1");
//                                      &CONNECT("$inst.us${i}_rready", "1'b1");
//                                      &CONNECT("$inst.us${i}_wdata",  "{(BIU_DATA_WIDTH){1'b0}}");
//                                      &CONNECT("$inst.us${i}_wlast",  "1'b0");
//                                      &CONNECT("$inst.us${i}_wstrb",  "{(BIU_WSTRB_WIDTH){1'b0}}");
//                                      &CONNECT("$inst.us${i}_wvalid", "1'b0");
//                              &ENDIF("ATCBMC301_MST${i}_SUPPORT");
//                      } else {
//                              &IFDEF("ATCBMC301_SLV${i}_SUPPORT");
//                                      &CONNECT("$inst.ds${i}_araddr", "nds_unused_${inst}_ds${i}_araddr");
//                                      &CONNECT("$inst.ds${i}_arburst",        "nds_unused_${inst}_ds${i}_arburst");
//                                      &CONNECT("$inst.ds${i}_arcache",        "nds_unused_${inst}_ds${i}_arcache");
//                                      &CONNECT("$inst.ds${i}_arid",   "nds_unused_${inst}_ds${i}_arid");
//                                      &CONNECT("$inst.ds${i}_arlen",  "nds_unused_${inst}_ds${i}_arlen");
//                                      &CONNECT("$inst.ds${i}_arlock", "nds_unused_${inst}_ds${i}_arlock");
//                                      &CONNECT("$inst.ds${i}_arprot", "nds_unused_${inst}_ds${i}_arprot");
//                                      &CONNECT("$inst.ds${i}_arsize", "nds_unused_${inst}_ds${i}_arsize");
//                                      &CONNECT("$inst.ds${i}_arvalid",        "nds_unused_${inst}_ds${i}_arvalid");
//                                      &CONNECT("$inst.ds${i}_awaddr", "nds_unused_${inst}_ds${i}_awaddr");
//                                      &CONNECT("$inst.ds${i}_awburst",        "nds_unused_${inst}_ds${i}_awburst");
//                                      &CONNECT("$inst.ds${i}_awcache",        "nds_unused_${inst}_ds${i}_awcache");
//                                      &CONNECT("$inst.ds${i}_awid",   "nds_unused_${inst}_ds${i}_awid");
//                                      &CONNECT("$inst.ds${i}_awlen",  "nds_unused_${inst}_ds${i}_awlen");
//                                      &CONNECT("$inst.ds${i}_awlock", "nds_unused_${inst}_ds${i}_awlock");
//                                      &CONNECT("$inst.ds${i}_awprot", "nds_unused_${inst}_ds${i}_awprot");
//                                      &CONNECT("$inst.ds${i}_awsize", "nds_unused_${inst}_ds${i}_awsize");
//                                      &CONNECT("$inst.ds${i}_awvalid",        "nds_unused_${inst}_ds${i}_awvalid");
//                                      &CONNECT("$inst.ds${i}_bready", "nds_unused_${inst}_ds${i}_bready");
//                                      &CONNECT("$inst.ds${i}_rready", "nds_unused_${inst}_ds${i}_rready");
//                                      &CONNECT("$inst.ds${i}_wdata",  "nds_unused_${inst}_ds${i}_wdata");
//                                      &CONNECT("$inst.ds${i}_wlast",  "nds_unused_${inst}_ds${i}_wlast");
//                                      &CONNECT("$inst.ds${i}_wstrb",  "nds_unused_${inst}_ds${i}_wstrb");
//                                      &CONNECT("$inst.ds${i}_wvalid", "nds_unused_${inst}_ds${i}_wvalid");
//                                      &CONNECT("$inst.ds${i}_arready",        "1'b1");
//                                      &CONNECT("$inst.ds${i}_awready",        "1'b1");
//                                      &CONNECT("$inst.ds${i}_bid",    "{(BIU_ID_WIDTH+4){1'b0}}");
//                                      &CONNECT("$inst.ds${i}_bresp",  "2'b0");
//                                      &CONNECT("$inst.ds${i}_bvalid", "1'b0");
//                                      &CONNECT("$inst.ds${i}_rdata",  "{(BIU_DATA_WIDTH){1'b0}}");
//                                      &CONNECT("$inst.ds${i}_rid",    "{(BIU_ID_WIDTH+4){1'b0}}");
//                                      &CONNECT("$inst.ds${i}_rlast",  "1'b0");
//                                      &CONNECT("$inst.ds${i}_rresp",  "2'b0");
//                                      &CONNECT("$inst.ds${i}_rvalid", "1'b0");
//                                      &CONNECT("$inst.ds${i}_wready", "1'b1");
//                              &ENDIF("ATCBMC301_SLV${i}_SUPPORT");
//                      }
//              } else {
//                      if ($ms =~ m/m/) {
//                              &IFDEF("ATCBMC301_MST${i}_SUPPORT");
//                                      &CONNECT("$inst.us${i}_araddr",  "${prefix}araddr");
//                                      &CONNECT("$inst.us${i}_arburst", "${prefix}arburst");
//                                      &CONNECT("$inst.us${i}_arcache", "${prefix}arcache");
//                                      &CONNECT("$inst.us${i}_arid",    "${prefix}arid");
//                                      &CONNECT("$inst.us${i}_arlen",   "${prefix}arlen");
//                                      &CONNECT("$inst.us${i}_arlock",  "${prefix}arlock");
//                                      &CONNECT("$inst.us${i}_arprot",  "${prefix}arprot");
//                                      &CONNECT("$inst.us${i}_arready", "${prefix}arready");
//                                      &CONNECT("$inst.us${i}_arsize",  "${prefix}arsize");
//                                      &CONNECT("$inst.us${i}_arvalid", "${prefix}arvalid");
//
//                                      &CONNECT("$inst.us${i}_awaddr",  "${prefix}awaddr");
//                                      &CONNECT("$inst.us${i}_awburst", "${prefix}awburst");
//                                      &CONNECT("$inst.us${i}_awcache", "${prefix}awcache");
//                                      &CONNECT("$inst.us${i}_awid",    "${prefix}awid");
//                                      &CONNECT("$inst.us${i}_awlen",   "${prefix}awlen");
//                                      &CONNECT("$inst.us${i}_awlock",  "${prefix}awlock");
//                                      &CONNECT("$inst.us${i}_awprot",  "${prefix}awprot");
//                                      &CONNECT("$inst.us${i}_awready", "${prefix}awready");
//                                      &CONNECT("$inst.us${i}_awsize",  "${prefix}awsize");
//                                      &CONNECT("$inst.us${i}_awvalid", "${prefix}awvalid");
//
//                                      &CONNECT("$inst.us${i}_wdata",   "${prefix}wdata");
//                                      &CONNECT("$inst.us${i}_wstrb",   "${prefix}wstrb");
//                                      &CONNECT("$inst.us${i}_wlast",   "${prefix}wlast");
//                                      &CONNECT("$inst.us${i}_wvalid",  "${prefix}wvalid");
//                                      &CONNECT("$inst.us${i}_wready",  "${prefix}wready");
//
//                                      &CONNECT("$inst.us${i}_bid",     "${prefix}bid");
//                                      &CONNECT("$inst.us${i}_bresp",   "${prefix}bresp");
//                                      &CONNECT("$inst.us${i}_bvalid",  "${prefix}bvalid");
//                                      &CONNECT("$inst.us${i}_bready",  "${prefix}bready");
//
//                                      &CONNECT("$inst.us${i}_rdata",   "${prefix}rdata");
//                                      &CONNECT("$inst.us${i}_rresp",   "${prefix}rresp");
//                                      &CONNECT("$inst.us${i}_rlast",   "${prefix}rlast");
//                                      &CONNECT("$inst.us${i}_rid",     "${prefix}rid");
//                                      &CONNECT("$inst.us${i}_rvalid",  "${prefix}rvalid");
//                                      &CONNECT("$inst.us${i}_rready",  "${prefix}rready");
//
//                              &ENDIF("ATCBMC301_MST${i}_SUPPORT");
//                      } else {
//                              &IFDEF("ATCBMC301_SLV${i}_SUPPORT");
//					&FORCE("wire", "${prefix}rid_dummy");
//					&FORCE("wire", "${prefix}bid_dummy");
//
//                                      &CONNECT("$inst.ds${i}_araddr",  "${prefix}araddr");
//                                      &CONNECT("$inst.ds${i}_arburst", "${prefix}arburst");
//                                      &CONNECT("$inst.ds${i}_arcache", "${prefix}arcache");
//                                      &CONNECT("$inst.ds${i}_arid",    "{${prefix}arid, ${prefix}arid_dummy}");
//                                      &CONNECT("$inst.ds${i}_arlen",   "${prefix}arlen");
//                                      &CONNECT("$inst.ds${i}_arlock",  "${prefix}arlock");
//                                      &CONNECT("$inst.ds${i}_arprot",  "${prefix}arprot");
//                                      &CONNECT("$inst.ds${i}_arready", "${prefix}arready");
//                                      &CONNECT("$inst.ds${i}_arsize",  "${prefix}arsize");
//                                      &CONNECT("$inst.ds${i}_arvalid", "${prefix}arvalid");
//
//                                      &CONNECT("$inst.ds${i}_awaddr",  "${prefix}awaddr");
//                                      &CONNECT("$inst.ds${i}_awburst", "${prefix}awburst");
//                                      &CONNECT("$inst.ds${i}_awcache", "${prefix}awcache");
//                                      &CONNECT("$inst.ds${i}_awid",    "{${prefix}awid, ${prefix}awid_dummy}");
//                                      &CONNECT("$inst.ds${i}_awlen",   "${prefix}awlen");
//                                      &CONNECT("$inst.ds${i}_awlock",  "${prefix}awlock");
//                                      &CONNECT("$inst.ds${i}_awprot",  "${prefix}awprot");
//                                      &CONNECT("$inst.ds${i}_awready", "${prefix}awready");
//                                      &CONNECT("$inst.ds${i}_awsize",  "${prefix}awsize");
//                                      &CONNECT("$inst.ds${i}_awvalid", "${prefix}awvalid");
//
//                                      &CONNECT("$inst.ds${i}_wdata",   "${prefix}wdata");
//                                      &CONNECT("$inst.ds${i}_wstrb",   "${prefix}wstrb");
//                                      &CONNECT("$inst.ds${i}_wlast",   "${prefix}wlast");
//                                      &CONNECT("$inst.ds${i}_wvalid",  "${prefix}wvalid");
//                                      &CONNECT("$inst.ds${i}_wready",  "${prefix}wready");
//
//                                      &CONNECT("$inst.ds${i}_bid",     "{${prefix}bid, ${prefix}bid_dummy}");
//                                      &CONNECT("$inst.ds${i}_bresp",   "${prefix}bresp");
//                                      &CONNECT("$inst.ds${i}_bvalid",  "${prefix}bvalid");
//                                      &CONNECT("$inst.ds${i}_bready",  "${prefix}bready");
//
//                                      &CONNECT("$inst.ds${i}_rdata",   "${prefix}rdata");
//                                      &CONNECT("$inst.ds${i}_rresp",   "${prefix}rresp");
//                                      &CONNECT("$inst.ds${i}_rlast",   "${prefix}rlast");
//                                      &CONNECT("$inst.ds${i}_rid",     "{${prefix}rid, ${prefix}rid_dummy}");
//                                      &CONNECT("$inst.ds${i}_rvalid",  "${prefix}rvalid");
//                                      &CONNECT("$inst.ds${i}_rready",  "${prefix}rready");
//
//                                      if (${prefix} =~ m/inter/) {
//                                      &FORCE("wire", "${prefix}araddr[ADDR_MSB:0]");
//                                      &FORCE("wire", "${prefix}arburst[1:0]");
//                                      &FORCE("wire", "${prefix}arcache[3:0]");
//                                      &FORCE("wire", "${prefix}arid[BIU_ID_MSB:0]");
//                                      &FORCE("wire", "${prefix}arlen[7:0]");
//                                      &FORCE("wire", "${prefix}arlock");
//                                      &FORCE("wire", "${prefix}arprot[2:0]");
//                                      &FORCE("wire", "${prefix}arready");
//                                      &FORCE("wire", "${prefix}arsize[2:0]");
//                                      &FORCE("wire", "${prefix}arvalid");
//
//                                      &FORCE("wire", "${prefix}awaddr[ADDR_MSB:0]");
//                                      &FORCE("wire", "${prefix}awburst[1:0]");
//                                      &FORCE("wire", "${prefix}awcache[3:0]");
//                                      &FORCE("wire", "${prefix}awid[BIU_ID_MSB:0]");
//                                      &FORCE("wire", "${prefix}awlen[7:0]");
//                                      &FORCE("wire", "${prefix}awlock");
//                                      &FORCE("wire", "${prefix}awprot[2:0]");
//                                      &FORCE("wire", "${prefix}awready");
//                                      &FORCE("wire", "${prefix}awsize[2:0]");
//                                      &FORCE("wire", "${prefix}awvalid");
//
//                                      &FORCE("wire", "${prefix}wdata[BIU_DATA_MSB:0]");
//                                      &FORCE("wire", "${prefix}wstrb[BIU_WSTRB_MSB:0]");
//                                      &FORCE("wire", "${prefix}wlast");
//                                      &FORCE("wire", "${prefix}wvalid");
//                                      &FORCE("wire", "${prefix}wready");
//
//                                      &FORCE("wire", "${prefix}bid[BIU_ID_MSB:0]");
//                                      &FORCE("wire", "${prefix}bresp[1:0]");
//                                      &FORCE("wire", "${prefix}bvalid");
//                                      &FORCE("wire", "${prefix}bready");
//
//                                      &FORCE("wire", "${prefix}rdata[BIU_DATA_MSB:0]");
//                                      &FORCE("wire", "${prefix}rresp[1:0]");
//                                      &FORCE("wire", "${prefix}rlast");
//                                      &FORCE("wire", "${prefix}rid[BIU_ID_MSB:0]");
//                                      &FORCE("wire", "${prefix}rvalid");
//                                      &FORCE("wire", "${prefix}rready");
//                                      }
//                              &ENDIF("ATCBMC301_SLV${i}_SUPPORT");
//                                      &FORCE("wire", "${prefix}arid_dummy[3:0]");
//                                      &FORCE("wire", "${prefix}awid_dummy[3:0]");
//                                      &FORCE("wire", "${prefix}bid_dummy[3:0]");
//                                      &FORCE("wire", "${prefix}rid_dummy[3:0]");
//                      }
//              }
//      }
//
//$inst = "u_axi_bmc";
//&INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301.v", $inst, {
//      ADDR_WIDTH => "ADDR_WIDTH",
//      DATA_WIDTH => "BIU_DATA_WIDTH"
//});
//$i = ${BMC_MST_SYS0};
//$ms = "master";
//$prefix = "axi_sys0_";
//&CONNECT_AXI_BMC(${inst}, ${i}, ${ms}, ${prefix});
//
//$i = ${BMC_MST_FLASH0};
//$ms = "master";
//$prefix = "axi_flash0_";
//&CONNECT_AXI_BMC(${inst}, ${i}, ${ms}, ${prefix});
//
//$i = ${BMC_SLV_BUSDEC};
//$ms = "slave";
//$prefix = "inter_ds1_";
//&CONNECT_AXI_BMC(${inst}, ${i}, ${ms}, ${prefix});
//
//$i = ${BMC_SLV_SYS};
//$ms = "slave";
//$prefix = "sys_exmon_";
//&CONNECT_AXI_BMC(${inst}, ${i}, ${ms}, ${prefix});
//
//$i = ${BMC_SLV_FLASH0};
//$ms = "slave";
//$prefix = "flash0_";
//&CONNECT_AXI_BMC(${inst}, ${i}, ${ms}, ${prefix});
//
//&CONNECT("${inst}.aclk",              "aclk");
//&CONNECT("${inst}.aresetn",           "aresetn");
//
//:`ifdef ATCBMC301_SLV2_SUPPORT
//:assign sys_exmon_bid_dummy = 4'b0; //sys_exmon_bid_dummy;
//:assign sys_exmon_rid_dummy = 4'b0; //sys_exmon_rid_dummy;
//:`endif // ATCBMC301_SLV2_SUPPORT
//
//:`ifdef ATCBMC301_SLV3_SUPPORT
//:assign flash0_bid_dummy = 4'b1;
//:assign flash0_rid_dummy = 4'b1;
//:`endif // ATCBMC301_SLV3_SUPPORT
//
//
//&DANGLER("nds_unused_awqos");
//&DANGLER("nds_unused_awregion");
//&DANGLER("nds_unused_arqos");
//&DANGLER("nds_unused_arregion");
//
//:`ifdef NDS_IO_SPP
//:assign inter_ds1_arready = 1'b0;
//:assign inter_ds1_awready = 1'b0;
//:assign inter_ds1_wready  = 1'b0;
//
//:assign inter_ds1_rdata = {BIU_DATA_WIDTH{1'b0}};
//:assign inter_ds1_rid = {BIU_ID_WIDTH{1'b0}};
//:assign inter_ds1_rid_dummy = 4'd0;
//:assign inter_ds1_rlast = 1'd0;
//:assign inter_ds1_rresp = 2'd0;
//:assign inter_ds1_rvalid = 1'b0;
//
//:assign inter_ds1_bvalid  = 1'b0;
//:assign inter_ds1_bid = {BIU_ID_WIDTH{1'b0}};
//:assign inter_ds1_bid_dummy = 4'd0;
//:assign inter_ds1_bresp = 2'd0;
//:`endif // NDS_IO_SPP
//
// #------------------------------------------------------------------------------
// # SIZEDN
// #------------------------------------------------------------------------------
//&IFDEF("NDS_IO_SPP");
//&ELSE("NDS_IO_SPP");
//      &GENERATE_IF("(BIU_DATA_WIDTH > NCE_DATA_WIDTH)", "gen_axi_sdn");
//
//      #------ sizedn for gt-axibus to 32-hbmc ------
//      &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300.v", "u_axi_sdn", {
//              ID_WIDTH        => "BIU_ID_WIDTH+4",
//              ADDR_WIDTH      => "ADDR_WIDTH",
//              US_DATA_WIDTH   => "BIU_DATA_WIDTH",
//              DS_DATA_WIDTH   => "NCE_DATA_WIDTH",
//      });
//      &ENDGENERATE();
//
//      &CONNECT("u_axi_sdn.aclk",              "aclk");
//      &CONNECT("u_axi_sdn.aresetn",           "aresetn");
//
//      &CONNECT("u_axi_sdn.us_araddr",         "inter_ds1_araddr");
//      &CONNECT("u_axi_sdn.us_arburst",        "inter_ds1_arburst");
//      &CONNECT("u_axi_sdn.us_arcache",        "inter_ds1_arcache");
//      &CONNECT("u_axi_sdn.us_arid",           "{inter_ds1_arid, inter_ds1_arid_dummy}");
//      &CONNECT("u_axi_sdn.us_arlen",          "inter_ds1_arlen");
//      &CONNECT("u_axi_sdn.us_arlock",         "inter_ds1_arlock");
//      &CONNECT("u_axi_sdn.us_arprot",         "inter_ds1_arprot");
//      &CONNECT("u_axi_sdn.us_arsize",         "inter_ds1_arsize");
//      &CONNECT("u_axi_sdn.us_arvalid",        "inter_ds1_arvalid");
//      &CONNECT("u_axi_sdn.us_arready",        "inter_ds1_arready");
//      &CONNECT("u_axi_sdn.us_awaddr",         "inter_ds1_awaddr");
//      &CONNECT("u_axi_sdn.us_awburst",        "inter_ds1_awburst");
//      &CONNECT("u_axi_sdn.us_awcache",        "inter_ds1_awcache");
//      &CONNECT("u_axi_sdn.us_awid",           "{inter_ds1_awid, inter_ds1_awid_dummy}");
//      &CONNECT("u_axi_sdn.us_awlen",          "inter_ds1_awlen");
//      &CONNECT("u_axi_sdn.us_awlock",         "inter_ds1_awlock");
//      &CONNECT("u_axi_sdn.us_awprot",         "inter_ds1_awprot");
//      &CONNECT("u_axi_sdn.us_awsize",         "inter_ds1_awsize");
//      &CONNECT("u_axi_sdn.us_awvalid",        "inter_ds1_awvalid");
//      &CONNECT("u_axi_sdn.us_awready",        "inter_ds1_awready");
//      &CONNECT("u_axi_sdn.us_wdata",          "inter_ds1_wdata");
//      &CONNECT("u_axi_sdn.us_wlast",          "inter_ds1_wlast");
//      &CONNECT("u_axi_sdn.us_wstrb",          "inter_ds1_wstrb");
//      &CONNECT("u_axi_sdn.us_wvalid",         "inter_ds1_wvalid");
//      &CONNECT("u_axi_sdn.us_wready",         "inter_ds1_wready");
//      &CONNECT("u_axi_sdn.us_bready",         "inter_ds1_bready");
//      &CONNECT("u_axi_sdn.us_bid",            "{inter_ds1_bid, inter_ds1_bid_dummy}");
//      &CONNECT("u_axi_sdn.us_bresp",          "inter_ds1_bresp");
//      &CONNECT("u_axi_sdn.us_bvalid",         "inter_ds1_bvalid");
//      &CONNECT("u_axi_sdn.us_rdata",          "inter_ds1_rdata");
//      &CONNECT("u_axi_sdn.us_rid",            "{inter_ds1_rid, inter_ds1_rid_dummy}");
//      &CONNECT("u_axi_sdn.us_rlast",          "inter_ds1_rlast");
//      &CONNECT("u_axi_sdn.us_rresp",          "inter_ds1_rresp");
//      &CONNECT("u_axi_sdn.us_rvalid",         "inter_ds1_rvalid");
//      &CONNECT("u_axi_sdn.us_rready",         "inter_ds1_rready");
//
//      &CONNECT("u_axi_sdn.ds_araddr",         "sdn_araddr");
//      &CONNECT("u_axi_sdn.ds_arburst",        "sdn_arburst");
//      &CONNECT("u_axi_sdn.ds_arcache",        "sdn_arcache");
//      &CONNECT("u_axi_sdn.ds_arlen",          "sdn_arlen");
//      &CONNECT("u_axi_sdn.ds_arlock",         "sdn_arlock");
//      &CONNECT("u_axi_sdn.ds_arprot",         "sdn_arprot");
//      &CONNECT("u_axi_sdn.ds_arsize",         "sdn_arsize");
//      &CONNECT("u_axi_sdn.ds_arvalid",        "sdn_arvalid");
//      &CONNECT("u_axi_sdn.ds_arready",        "sdn_arready");
//      &CONNECT("u_axi_sdn.ds_awaddr",         "sdn_awaddr");
//      &CONNECT("u_axi_sdn.ds_awburst",        "sdn_awburst");
//      &CONNECT("u_axi_sdn.ds_awcache",        "sdn_awcache");
//      &CONNECT("u_axi_sdn.ds_awlen",          "sdn_awlen");
//      &CONNECT("u_axi_sdn.ds_awlock",         "sdn_awlock");
//      &CONNECT("u_axi_sdn.ds_awprot",         "sdn_awprot");
//      &CONNECT("u_axi_sdn.ds_awsize",         "sdn_awsize");
//      &CONNECT("u_axi_sdn.ds_awvalid",        "sdn_awvalid");
//      &CONNECT("u_axi_sdn.ds_awready",        "sdn_awready");
//      &CONNECT("u_axi_sdn.ds_wdata",          "sdn_wdata");
//      &CONNECT("u_axi_sdn.ds_wlast",          "sdn_wlast");
//      &CONNECT("u_axi_sdn.ds_wstrb",          "sdn_wstrb");
//      &CONNECT("u_axi_sdn.ds_wvalid",         "sdn_wvalid");
//      &CONNECT("u_axi_sdn.ds_wready",         "sdn_wready");
//      &CONNECT("u_axi_sdn.ds_bresp",          "sdn_bresp");
//      &CONNECT("u_axi_sdn.ds_bvalid",         "sdn_bvalid");
//      &CONNECT("u_axi_sdn.ds_bready",         "sdn_bready");
//      &CONNECT("u_axi_sdn.ds_rdata",          "sdn_rdata");
//      &CONNECT("u_axi_sdn.ds_rlast",          "sdn_rlast");
//      &CONNECT("u_axi_sdn.ds_rresp",          "sdn_rresp");
//      &CONNECT("u_axi_sdn.ds_rvalid",         "sdn_rvalid");
//      &CONNECT("u_axi_sdn.ds_rready",         "sdn_rready");

//      &FORCE("wire", "sdn_araddr[ADDR_MSB:0]");
//      &FORCE("wire", "sdn_arburst[1:0]");
//      &FORCE("wire", "sdn_arcache[3:0]");
//      &FORCE("wire", "sdn_arid[BIU_ID_MSB+4:0]");
//      &FORCE("wire", "sdn_arlen[7:0]");
//      &FORCE("wire", "sdn_arlock");
//      &FORCE("wire", "sdn_arprot[2:0]");
//      &FORCE("wire", "sdn_arready");
//      &FORCE("wire", "sdn_arsize[2:0]");
//      &FORCE("wire", "sdn_arvalid");
//      &FORCE("wire", "sdn_awaddr[ADDR_MSB:0]");
//      &FORCE("wire", "sdn_awburst[1:0]");
//      &FORCE("wire", "sdn_awcache[3:0]");
//      &FORCE("wire", "sdn_awid[BIU_ID_MSB+4:0]");
//      &FORCE("wire", "sdn_awlen[7:0]");
//      &FORCE("wire", "sdn_awlock");
//      &FORCE("wire", "sdn_awprot[2:0]");
//      &FORCE("wire", "sdn_awready");
//      &FORCE("wire", "sdn_awsize[2:0]");
//      &FORCE("wire", "sdn_awvalid");
//      &FORCE("wire", "sdn_wdata[NCE_DATA_MSB:0]");
//      &FORCE("wire", "sdn_wstrb[NCE_WSTRB_MSB:0]");
//      &FORCE("wire", "sdn_wlast");
//      &FORCE("wire", "sdn_wvalid");
//      &FORCE("wire", "sdn_wready");
//      &FORCE("wire", "sdn_bid[BIU_ID_MSB+4:0]");
//      &FORCE("wire", "sdn_bresp[1:0]");
//      &FORCE("wire", "sdn_bvalid");
//      &FORCE("wire", "sdn_bready");
//      &FORCE("wire", "sdn_rid[BIU_ID_MSB+4:0]");
//      &FORCE("wire", "sdn_rdata[NCE_DATA_MSB:0]");
//      &FORCE("wire", "sdn_rresp[1:0]");
//      &FORCE("wire", "sdn_rlast");
//      &FORCE("wire", "sdn_rvalid");
//      &FORCE("wire", "sdn_rready");
//&ENDIF("NDS_IO_SPP");

//:`ifndef NDS_IO_SPP
//	:generate
//	:if (BIU_DATA_WIDTH > NCE_DATA_WIDTH) begin: gen_connect_axi_sdn
//	:     assign sdn_arid = {(BIU_ID_WIDTH+4){1'b0}};
//	:     assign sdn_awid = {(BIU_ID_WIDTH+4){1'b0}};
//	:end
//	:else begin: gen_connect_axi
//	:             assign sdn_araddr  = inter_ds1_araddr;
//	:             assign sdn_arburst = inter_ds1_arburst;
//	:             assign sdn_arcache = inter_ds1_arcache;
//	:             assign sdn_arid    = {inter_ds1_arid, inter_ds1_arid_dummy};
//	:             assign sdn_arlen   = inter_ds1_arlen;
//	:             assign sdn_arlock  = inter_ds1_arlock;
//	:             assign sdn_arprot  = inter_ds1_arprot;
//	:             assign sdn_arsize  = inter_ds1_arsize;
//	:             assign sdn_arvalid = inter_ds1_arvalid;
//	:             assign inter_ds1_arready  = sdn_arready;
//	:
//	:             assign sdn_awaddr  = inter_ds1_awaddr;
//	:             assign sdn_awburst = inter_ds1_awburst;
//	:             assign sdn_awcache = inter_ds1_awcache;
//	:             assign sdn_awid    = {inter_ds1_awid, inter_ds1_awid_dummy};
//	:             assign sdn_awlen   = inter_ds1_awlen;
//	:             assign sdn_awlock  = inter_ds1_awlock;
//	:             assign sdn_awprot  = inter_ds1_awprot;
//	:             assign sdn_awsize  = inter_ds1_awsize;
//	:             assign sdn_awvalid = inter_ds1_awvalid;
//	:             assign inter_ds1_awready  = sdn_awready;
//	:
//	:             assign {inter_ds1_bid, inter_ds1_bid_dummy} = sdn_bid;
//	:             assign inter_ds1_bresp    = sdn_bresp;
//	:             assign inter_ds1_bvalid   = sdn_bvalid;
//	:             assign sdn_bready  = inter_ds1_bready;
//	:
//	:             assign inter_ds1_rdata    = sdn_rdata;
//	:             assign {inter_ds1_rid, inter_ds1_rid_dummy} = sdn_rid;
//	:             assign inter_ds1_rlast    = sdn_rlast;
//	:             assign inter_ds1_rresp    = sdn_rresp;
//	:             assign inter_ds1_rvalid   = sdn_rvalid;
//	:             assign sdn_rready  = inter_ds1_rready;
//	:
//	:             assign sdn_wdata   = inter_ds1_wdata;
//	:             assign sdn_wlast   = inter_ds1_wlast;
//	:             assign sdn_wstrb   = inter_ds1_wstrb;
//	:             assign sdn_wvalid  = inter_ds1_wvalid;
//	:             assign inter_ds1_wready   = sdn_wready;
//	:end
//	:endgenerate
//
// 	:assign busdec_us_araddr  = sdn_araddr;
// 	:assign busdec_us_arburst = sdn_arburst;
// 	:assign busdec_us_arcache = sdn_arcache;
// 	:assign busdec_us_arid    = sdn_arid;
// 	:assign busdec_us_arlen   = sdn_arlen;
// 	:assign busdec_us_arlock  = sdn_arlock;
// 	:assign busdec_us_arprot  = sdn_arprot;
// 	:assign busdec_us_arsize  = sdn_arsize;
// 	:assign busdec_us_arvalid = sdn_arvalid;
// 	:assign sdn_arready       = busdec_us_arready;
//
// 	:assign busdec_us_awaddr  = sdn_awaddr;
// 	:assign busdec_us_awburst = sdn_awburst;
// 	:assign busdec_us_awcache = sdn_awcache;
// 	:assign busdec_us_awid    = sdn_awid;
// 	:assign busdec_us_awlen   = sdn_awlen;
// 	:assign busdec_us_awlock  = sdn_awlock;
// 	:assign busdec_us_awprot  = sdn_awprot;
// 	:assign busdec_us_awsize  = sdn_awsize;
// 	:assign busdec_us_awvalid = sdn_awvalid;
// 	:assign sdn_awready       = busdec_us_awready;
//
// 	:assign busdec_us_wdata  = sdn_wdata;
// 	:assign busdec_us_wlast  = sdn_wlast;
// 	:assign busdec_us_wstrb  = sdn_wstrb;
// 	:assign busdec_us_wvalid = sdn_wvalid;
// 	:assign sdn_wready       = busdec_us_wready;
//
// 	:assign sdn_bid          = busdec_us_bid;
// 	:assign sdn_bresp        = busdec_us_bresp;
// 	:assign sdn_bvalid       = busdec_us_bvalid;
//
// 	:assign sdn_rdata        = busdec_us_rdata;
// 	:assign sdn_rid          = busdec_us_rid;
// 	:assign busdec_us_bready = sdn_bready;
//
// 	:assign sdn_rlast        = busdec_us_rlast;
// 	:assign sdn_rresp        = busdec_us_rresp;
// 	:assign sdn_rvalid       = busdec_us_rvalid;
// 	:assign busdec_us_rready = sdn_rready;
//:`endif // NDS_IO_SPP
//:
//
//#####################################################################################################
//# EXMON300
//#####################################################################################################
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300.v","u_atcexmon300",{
//              ADDR_WIDTH => "ADDR_WIDTH",
//              ID_WIDTH   => "BIU_ID_WIDTH",
//              DATA_WIDTH => "BIU_DATA_WIDTH",
//              NUM_EX_SEQ => "8",
//      });
// &CONNECT("u_atcexmon300", {
//      aclk            => "aclk",
//      aresetn         => "aresetn",
//
//      us_arvalid      => "sys_exmon_arvalid",
//      us_arid         => "sys_exmon_arid",
//      us_araddr       => "sys_exmon_araddr",
//      us_arlock       => "sys_exmon_arlock",
//      us_arburst      => "sys_exmon_arburst",
//      us_arlen        => "sys_exmon_arlen",
//      us_arcache      => "sys_exmon_arcache",
//      us_arprot       => "sys_exmon_arprot",
//      us_arsize       => "sys_exmon_arsize",
//      us_arready      => "sys_exmon_arready",
//      us_arqos        => "4'b0",
//      us_arregion     => "4'b0",
//      us_rid          => "sys_exmon_rid",
//      us_rresp        => "sys_exmon_rresp",
//      us_rready       => "sys_exmon_rready",
//      us_rdata        => "sys_exmon_rdata",
//      us_rlast        => "sys_exmon_rlast",
//      us_rvalid       => "sys_exmon_rvalid",
//      us_awvalid      => "sys_exmon_awvalid",
//      us_awid         => "sys_exmon_awid",
//      us_awaddr       => "sys_exmon_awaddr",
//      us_awlock       => "sys_exmon_awlock",
//      us_awburst      => "sys_exmon_awburst",
//      us_awlen        => "sys_exmon_awlen",
//      us_awcache      => "sys_exmon_awcache",
//      us_awprot       => "sys_exmon_awprot",
//      us_awsize       => "sys_exmon_awsize",
//      us_awready      => "sys_exmon_awready",
//      us_awqos        => "4'b0",
//      us_awregion     => "4'b0",
//      us_wstrb        => "sys_exmon_wstrb",
//      us_wvalid       => "sys_exmon_wvalid",
//      us_wready       => "sys_exmon_wready",
//      us_wlast        => "sys_exmon_wlast",
//      us_wdata        => "sys_exmon_wdata",
//      us_bvalid       => "sys_exmon_bvalid",
//      us_bid          => "sys_exmon_bid",
//      us_bresp        => "sys_exmon_bresp",
//      us_bready       => "sys_exmon_bready",
//
//      ds_awvalid      => "sys_awvalid",
//      ds_awid         => "sys_awid",
//      ds_awaddr       => "sys_awaddr",
//      ds_awlock       => "sys_awlock",
//      ds_awburst      => "sys_awburst",
//      ds_awlen        => "sys_awlen",
//      ds_awcache      => "sys_awcache",
//      ds_awprot       => "sys_awprot",
//      ds_awsize       => "sys_awsize",
//      ds_awready      => "sys_awready",
//      ds_awqos        => "nds_unused_awqos",
//      ds_awregion     => "nds_unused_awregion",
//      ds_wdata        => "sys_wdata",
//      ds_wlast        => "sys_wlast",
//      ds_wvalid       => "sys_wvalid",
//      ds_wstrb        => "sys_wstrb",
//      ds_wready       => "sys_wready",
//      ds_bvalid       => "sys_bvalid",
//      ds_bresp        => "sys_bresp",
//      ds_bid          => "sys_bid",
//      ds_bready       => "sys_bready",
//      ds_arvalid      => "sys_arvalid",
//      ds_arid         => "sys_arid",
//      ds_araddr       => "sys_araddr",
//      ds_arlock       => "sys_arlock",
//      ds_arburst      => "sys_arburst",
//      ds_arlen        => "sys_arlen",
//      ds_arcache      => "sys_arcache",
//      ds_arprot       => "sys_arprot",
//      ds_arsize       => "sys_arsize",
//      ds_arready      => "sys_arready",
//      ds_arqos        => "nds_unused_arqos",
//      ds_arregion     => "nds_unused_arregion",
//      ds_rready       => "sys_rready",
//      ds_rlast        => "sys_rlast",
//      ds_rvalid       => "sys_rvalid",
//      ds_rresp        => "sys_rresp",
//      ds_rid          => "sys_rid",
//      ds_rdata        => "sys_rdata",
//      });
//
//
// #------------------------------------------------------------------------------
// # BUSDEC for kv_core connects with dm, plmt, plic, plic_sw
// #------------------------------------------------------------------------------
//	&FORCE("wire", "busdec_us_araddr[ADDR_MSB:0]");
//	&FORCE("wire", "busdec_us_arburst[1:0]");
//	&FORCE("wire", "busdec_us_arcache[3:0]");
//	&FORCE("wire", "busdec_us_arid[BIU_ID_MSB+4:0]");
//	&FORCE("wire", "busdec_us_arlen[7:0]");
//	&FORCE("wire", "busdec_us_arlock");
//	&FORCE("wire", "busdec_us_arprot[2:0]");
//	&FORCE("wire", "busdec_us_arready");
//	&FORCE("wire", "busdec_us_arsize[2:0]");
//	&FORCE("wire", "busdec_us_arvalid");
//	&FORCE("wire", "busdec_us_awaddr[ADDR_MSB:0]");
//	&FORCE("wire", "busdec_us_awburst[1:0]");
//	&FORCE("wire", "busdec_us_awcache[3:0]");
//	&FORCE("wire", "busdec_us_awid[BIU_ID_MSB+4:0]");
//	&FORCE("wire", "busdec_us_awlen[7:0]");
//	&FORCE("wire", "busdec_us_awlock");
//	&FORCE("wire", "busdec_us_awprot[2:0]");
//	&FORCE("wire", "busdec_us_awready");
//	&FORCE("wire", "busdec_us_awsize[2:0]");
//	&FORCE("wire", "busdec_us_awvalid");
//	&FORCE("wire", "busdec_us_wdata[NCE_DATA_MSB:0]"); 
//	&FORCE("wire", "busdec_us_wstrb[NCE_WSTRB_MSB:0]"); 
//	&FORCE("wire", "busdec_us_wlast");
//	&FORCE("wire", "busdec_us_wvalid");
//	&FORCE("wire", "busdec_us_wready");
//	&FORCE("wire", "busdec_us_bid[BIU_ID_MSB+4:0]");   
//	&FORCE("wire", "busdec_us_bresp[1:0]"); 
//	&FORCE("wire", "busdec_us_bvalid");
//	&FORCE("wire", "busdec_us_bready");
//	&FORCE("wire", "busdec_us_rid[BIU_ID_MSB+4:0]");   
//	&FORCE("wire", "busdec_us_rdata[NCE_DATA_MSB:0]"); 
//	&FORCE("wire", "busdec_us_rresp[1:0]");
//	&FORCE("wire", "busdec_us_rlast"); 
//	&FORCE("wire", "busdec_us_rvalid");
//	&FORCE("wire", "busdec_us_rready");
//
//	&FORCE("wire", "busdec2nce_awaddr[ADDR_MSB:0]");
//	&FORCE("wire", "busdec2nce_awlen[7:0]");
//	&FORCE("wire", "busdec2nce_awsize[2:0]");
//	&FORCE("wire", "busdec2nce_awburst[1:0]");
//	&FORCE("wire", "busdec2nce_awlock");
//	&FORCE("wire", "busdec2nce_awcache[3:0]");
//	&FORCE("wire", "busdec2nce_awprot[2:0]");
//	&FORCE("wire", "busdec2nce_wdata[NCE_DATA_MSB:0]");
//	&FORCE("wire", "busdec2nce_wstrb[NCE_WSTRB_MSB:0]");
//	&FORCE("wire", "busdec2nce_wlast");
//	&FORCE("wire", "busdec2nce_araddr[ADDR_MSB:0]");
//	&FORCE("wire", "busdec2nce_arlen[7:0]");
//	&FORCE("wire", "busdec2nce_arsize[2:0]");
//	&FORCE("wire", "busdec2nce_arburst[1:0]");
//	&FORCE("wire", "busdec2nce_arlock");
//	&FORCE("wire", "busdec2nce_arcache[3:0]");
//	&FORCE("wire", "busdec2nce_arprot[2:0]");
//
//      &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcbusdec301/hdl/atcbusdec301.v", "u_axi_busdec", {
//                      ADDR_WIDTH => "ADDR_WIDTH",
//                      DATA_WIDTH => "NCE_DATA_WIDTH",
//                      ID_WIDTH => "BIU_ID_WIDTH+4",
//      });
//      sub CONNECT_AXI_BUSDEC {
//              ($i, $prefix) = @_;
//              if ($prefix =~ m/NC/) {
//                      &IFDEF("ATCBUSDEC301_SLV${i}_SUPPORT");
//                              &CONNECT("u_axi_busdec.ds${i}_awvalid", "nds_unused_u_axi_busdec_ds${i}_awvalid");
//                              &CONNECT("u_axi_busdec.ds${i}_awready", "1'b0");
//                              &CONNECT("u_axi_busdec.ds${i}_wvalid",  "nds_unused_u_axi_busdec_ds${i}_wvalid");
//                              &CONNECT("u_axi_busdec.ds${i}_wready",  "1'b1");
//                              &CONNECT("u_axi_busdec.ds${i}_bresp",   "2'b0");
//                              &CONNECT("u_axi_busdec.ds${i}_bvalid",  "1'b0");
//                              &CONNECT("u_axi_busdec.ds${i}_bready",  "nds_unused_u_axi_busdec_ds${i}_bready");
//                              &CONNECT("u_axi_busdec.ds${i}_arvalid", "nds_unused_u_axi_busdec_ds${i}_arvalid");
//                              &CONNECT("u_axi_busdec.ds${i}_arready", "1'b0");
//                              &CONNECT("u_axi_busdec.ds${i}_rdata",   "{NCE_DATA_WIDTH{1'b0}}");
//                              &CONNECT("u_axi_busdec.ds${i}_rresp",   "2'b0");
//                              &CONNECT("u_axi_busdec.ds${i}_rlast",   "1'b0");
//                              &CONNECT("u_axi_busdec.ds${i}_rvalid",  "1'b0");
//                              &CONNECT("u_axi_busdec.ds${i}_rready",  "nds_unused_u_axi_busdec_ds${i}_rready");
//                      &ENDIF("ATCBUSDEC301_SLV${i}_SUPPORT");
//              } else {
//                      &IFDEF("ATCBUSDEC301_SLV${i}_SUPPORT");
//                              &CONNECT("u_axi_busdec.ds${i}_awvalid", "${prefix}awvalid");
//                              &CONNECT("u_axi_busdec.ds${i}_awready", "${prefix}awready");
//                              &CONNECT("u_axi_busdec.ds${i}_wvalid",  "${prefix}wvalid");
//                              &CONNECT("u_axi_busdec.ds${i}_wready",  "${prefix}wready");
//                              &CONNECT("u_axi_busdec.ds${i}_bresp",   "${prefix}bresp");
//                              &CONNECT("u_axi_busdec.ds${i}_bvalid",  "${prefix}bvalid");
//                              &CONNECT("u_axi_busdec.ds${i}_bready",  "${prefix}bready");
//                              &CONNECT("u_axi_busdec.ds${i}_arvalid", "${prefix}arvalid");
//                              &CONNECT("u_axi_busdec.ds${i}_arready", "${prefix}arready");
//                              &CONNECT("u_axi_busdec.ds${i}_rdata",   "${prefix}rdata");
//                              &CONNECT("u_axi_busdec.ds${i}_rresp",   "${prefix}rresp");
//                              &CONNECT("u_axi_busdec.ds${i}_rlast",   "${prefix}rlast");
//                              &CONNECT("u_axi_busdec.ds${i}_rvalid",  "${prefix}rvalid");
//                              &CONNECT("u_axi_busdec.ds${i}_rready",  "${prefix}rready");

//                              &FORCE("wire", "${prefix}araddr[ADDR_MSB:0]");
//                              &FORCE("wire", "${prefix}arburst[1:0]");
//                              &FORCE("wire", "${prefix}arcache[3:0]");
//                              &FORCE("wire", "${prefix}arlen[7:0]");
//                              &FORCE("wire", "${prefix}arlock");
//                              &FORCE("wire", "${prefix}arprot[2:0]");
//                              &FORCE("wire", "${prefix}arready");
//                              &FORCE("wire", "${prefix}arsize[2:0]");
//                              &FORCE("wire", "${prefix}arvalid");
//                              &FORCE("wire", "${prefix}awaddr[ADDR_MSB:0]");
//                              &FORCE("wire", "${prefix}awburst[1:0]");
//                              &FORCE("wire", "${prefix}awcache[3:0]");
//                              &FORCE("wire", "${prefix}awlen[7:0]");
//                              &FORCE("wire", "${prefix}awlock");
//                              &FORCE("wire", "${prefix}awprot[2:0]");
//                              &FORCE("wire", "${prefix}awready");
//                              &FORCE("wire", "${prefix}awsize[2:0]");
//                              &FORCE("wire", "${prefix}awvalid");
//                              &FORCE("wire", "${prefix}wdata[NCE_DATA_MSB:0]");
//                              &FORCE("wire", "${prefix}wstrb[NCE_WSTRB_MSB:0]");
//                              &FORCE("wire", "${prefix}wlast");
//                              &FORCE("wire", "${prefix}wvalid");
//                              &FORCE("wire", "${prefix}wready");
//                              &FORCE("wire", "${prefix}bresp[1:0]");
//                              &FORCE("wire", "${prefix}bvalid");
//                              &FORCE("wire", "${prefix}bready");
//                              &FORCE("wire", "${prefix}rdata[NCE_DATA_MSB:0]");
//                              &FORCE("wire", "${prefix}rresp[1:0]");
//                              &FORCE("wire", "${prefix}rlast");
//                              &FORCE("wire", "${prefix}rvalid");
//                              &FORCE("wire", "${prefix}rready");
//                              :`ifdef ATCBUSDEC301_SLV${i}_SUPPORT
//                              :       assign ${prefix}awaddr  =       busdec2nce_awaddr       ;
//                              :       assign ${prefix}awlen   =       busdec2nce_awlen        ;
//                              :       assign ${prefix}awsize  =       busdec2nce_awsize       ;
//                              :       assign ${prefix}awburst =       busdec2nce_awburst      ;
//                              :       assign ${prefix}awlock  =       busdec2nce_awlock       ;
//                              :       assign ${prefix}awcache =       busdec2nce_awcache      ;
//                              :       assign ${prefix}awprot  =       busdec2nce_awprot       ;
//                              :       assign ${prefix}wdata   =       busdec2nce_wdata        ;
//                              :       assign ${prefix}wstrb   =       busdec2nce_wstrb        ;
//                              :       assign ${prefix}wlast   =       busdec2nce_wlast        ;
//                              :       assign ${prefix}araddr  =       busdec2nce_araddr       ;
//                              :       assign ${prefix}arlen   =       busdec2nce_arlen        ;
//                              :       assign ${prefix}arsize  =       busdec2nce_arsize       ;
//                              :       assign ${prefix}arburst =       busdec2nce_arburst      ;
//                              :       assign ${prefix}arlock  =       busdec2nce_arlock       ;
//                              :       assign ${prefix}arcache =       busdec2nce_arcache      ;
//                              :       assign ${prefix}arprot  =       busdec2nce_arprot       ;
//                              :`endif
//                      &ENDIF("ATCBUSDEC301_SLV${i}_SUPPORT");
//
//              }
//      }
//      &CONNECT("u_axi_busdec.ds_awaddr",      "busdec2nce_awaddr");
//      &CONNECT("u_axi_busdec.ds_awlen",       "busdec2nce_awlen");
//      &CONNECT("u_axi_busdec.ds_awsize",      "busdec2nce_awsize");
//      &CONNECT("u_axi_busdec.ds_awburst",     "busdec2nce_awburst");
//      &CONNECT("u_axi_busdec.ds_awlock",      "busdec2nce_awlock");
//      &CONNECT("u_axi_busdec.ds_awcache",     "busdec2nce_awcache");
//      &CONNECT("u_axi_busdec.ds_awprot",      "busdec2nce_awprot");
//      &CONNECT("u_axi_busdec.ds_wdata",       "busdec2nce_wdata");
//      &CONNECT("u_axi_busdec.ds_wstrb",       "busdec2nce_wstrb");
//      &CONNECT("u_axi_busdec.ds_wlast",       "busdec2nce_wlast");
//      &CONNECT("u_axi_busdec.ds_araddr",      "busdec2nce_araddr");
//      &CONNECT("u_axi_busdec.ds_arlen",       "busdec2nce_arlen");
//      &CONNECT("u_axi_busdec.ds_arsize",      "busdec2nce_arsize");
//      &CONNECT("u_axi_busdec.ds_arburst",     "busdec2nce_arburst");
//      &CONNECT("u_axi_busdec.ds_arlock",      "busdec2nce_arlock");
//      &CONNECT("u_axi_busdec.ds_arcache",     "busdec2nce_arcache");
//      &CONNECT("u_axi_busdec.ds_arprot",      "busdec2nce_arprot");

//      &FORCE("wire", "busdec2nce_awaddr[ADDR_MSB:0]");
//      &FORCE("wire", "busdec2nce_awlen[7:0]");
//      &FORCE("wire", "busdec2nce_awsize[2:0]");
//      &FORCE("wire", "busdec2nce_awburst[1:0]");
//      &FORCE("wire", "busdec2nce_awlock");
//      &FORCE("wire", "busdec2nce_awcache[3:0]");
//      &FORCE("wire", "busdec2nce_awprot[2:0]");
//      &FORCE("wire", "busdec2nce_wdata[NCE_DATA_MSB:0]");
//      &FORCE("wire", "busdec2nce_wstrb[NCE_WSTRB_MSB:0]");
//      &FORCE("wire", "busdec2nce_wlast");
//      &FORCE("wire", "busdec2nce_araddr[ADDR_MSB:0]");
//      &FORCE("wire", "busdec2nce_arlen[7:0]");
//      &FORCE("wire", "busdec2nce_arsize[2:0]");
//      &FORCE("wire", "busdec2nce_arburst[1:0]");
//      &FORCE("wire", "busdec2nce_arlock");
//      &FORCE("wire", "busdec2nce_arcache[3:0]");
//      &FORCE("wire", "busdec2nce_arprot[2:0]");

//      &CONNECT("u_axi_busdec.us_araddr",      "busdec_us_araddr");
//      &CONNECT("u_axi_busdec.us_arburst",     "busdec_us_arburst");
//      &CONNECT("u_axi_busdec.us_arcache",     "busdec_us_arcache");
//      &CONNECT("u_axi_busdec.us_arid",        "busdec_us_arid");
//      &CONNECT("u_axi_busdec.us_arlen",       "busdec_us_arlen");
//      &CONNECT("u_axi_busdec.us_arlock",      "busdec_us_arlock");
//      &CONNECT("u_axi_busdec.us_arprot",      "busdec_us_arprot");
//      &CONNECT("u_axi_busdec.us_arsize",      "busdec_us_arsize");
//      &CONNECT("u_axi_busdec.us_arvalid",     "busdec_us_arvalid");
//      &CONNECT("u_axi_busdec.us_arready",     "busdec_us_arready");
//      &CONNECT("u_axi_busdec.us_awaddr",      "busdec_us_awaddr");
//      &CONNECT("u_axi_busdec.us_awburst",     "busdec_us_awburst");
//      &CONNECT("u_axi_busdec.us_awcache",     "busdec_us_awcache");
//      &CONNECT("u_axi_busdec.us_awid",        "busdec_us_awid");
//      &CONNECT("u_axi_busdec.us_awlen",       "busdec_us_awlen");
//      &CONNECT("u_axi_busdec.us_awlock",      "busdec_us_awlock");
//      &CONNECT("u_axi_busdec.us_awprot",      "busdec_us_awprot");
//      &CONNECT("u_axi_busdec.us_awsize",      "busdec_us_awsize");
//      &CONNECT("u_axi_busdec.us_awvalid",     "busdec_us_awvalid");
//      &CONNECT("u_axi_busdec.us_awready",     "busdec_us_awready");
//      &CONNECT("u_axi_busdec.us_wdata",       "busdec_us_wdata");
//      &CONNECT("u_axi_busdec.us_wlast",       "busdec_us_wlast");
//      &CONNECT("u_axi_busdec.us_wstrb",       "busdec_us_wstrb");
//      &CONNECT("u_axi_busdec.us_wvalid",      "busdec_us_wvalid");
//      &CONNECT("u_axi_busdec.us_wready",      "busdec_us_wready");
//      &CONNECT("u_axi_busdec.us_bready",      "busdec_us_bready");
//      &CONNECT("u_axi_busdec.us_bid",         "busdec_us_bid");
//      &CONNECT("u_axi_busdec.us_bresp",       "busdec_us_bresp");
//      &CONNECT("u_axi_busdec.us_bvalid",      "busdec_us_bvalid");
//      &CONNECT("u_axi_busdec.us_rdata",       "busdec_us_rdata");
//      &CONNECT("u_axi_busdec.us_rid",         "busdec_us_rid");
//      &CONNECT("u_axi_busdec.us_rlast",       "busdec_us_rlast");
//      &CONNECT("u_axi_busdec.us_rresp",       "busdec_us_rresp");
//      &CONNECT("u_axi_busdec.us_rvalid",      "busdec_us_rvalid");
//      &CONNECT("u_axi_busdec.us_rready",      "busdec_us_rready");

//      &CONNECT("u_axi_busdec.aclk",           "aclk");
//      &CONNECT("u_axi_busdec.aresetn",        "aresetn");

//      $i = ${BUSDEC_SLV_PLIC};
//      $prefix = "plic_";
//      &CONNECT_AXI_BUSDEC(${i}, ${prefix});
//
//      $i = ${BUSDEC_SLV_PLMT};
//      $prefix = "plmt_";
//      &CONNECT_AXI_BUSDEC(${i}, ${prefix});
//
//      $i = ${BUSDEC_SLV_PLICSW};
//      $prefix = "plicsw_";
//      &CONNECT_AXI_BUSDEC(${i}, ${prefix});
//
//      &IFDEF("PLATFORM_DEBUG_SUBSYSTEM");
//              $i = ${BUSDEC_SLV_DM};
//              $prefix = "dm_";
//              &CONNECT_AXI_BUSDEC(${i}, ${prefix});
//      &ENDIF("PLATFORM_DEBUG_SUBSYSTEM");

// #------------------------------------------------------------------------------
// # BUSDEC for kv_core connects with dm, plmt, plic, plic_sw
// #------------------------------------------------------------------------------
//&IFDEF("NDS_IO_SLAVEPORT_COMMON_X1");
//      &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcbusdec302/hdl/atcbusdec302.v", "u_slvp_busdec", {
//                      ADDR_WIDTH => "ADDR_WIDTH",
//                      DATA_WIDTH => "SLVPORT_DATA_WIDTH",
//                      ID_WIDTH => "BIU_ID_WIDTH+4",
//      });
//      sub CONNECT_SLVP_BUSDEC {
//              ($i, $prefix) = @_;
//              if ($prefix =~ m/NC/) {
//                      &IFDEF("ATCBUSDEC302_SLV${i}_SUPPORT");
//                              &CONNECT("u_slvp_busdec.ds${i}_awvalid",        "nds_unused_u_slvp_busdec_ds${i}_awvalid");
//                              &CONNECT("u_slvp_busdec.ds${i}_awready",        "1'b0");
//                              &CONNECT("u_slvp_busdec.ds${i}_wvalid",         "nds_unused_u_slvp_busdec_ds${i}_wvalid");
//                              &CONNECT("u_slvp_busdec.ds${i}_wready",         "1'b1");
//                              &CONNECT("u_slvp_busdec.ds${i}_bresp",          "2'b0");
//                              &CONNECT("u_slvp_busdec.ds${i}_bvalid",         "1'b0");
//                              &CONNECT("u_slvp_busdec.ds${i}_bready",         "nds_unused_u_slvp_busdec_ds${i}_bready");
//                              &CONNECT("u_slvp_busdec.ds${i}_arvalid",        "nds_unused_u_slvp_busdec_ds${i}_arvalid");
//                              &CONNECT("u_slvp_busdec.ds${i}_arready",        "1'b0");
//                              &CONNECT("u_slvp_busdec.ds${i}_rdata",          "{SLVPORT_DATA_WIDTH{1'b0}}");
//                              &CONNECT("u_slvp_busdec.ds${i}_rresp",          "2'b0");
//                              &CONNECT("u_slvp_busdec.ds${i}_rlast",          "1'b0");
//                              &CONNECT("u_slvp_busdec.ds${i}_rvalid",         "1'b0");
//                              &CONNECT("u_slvp_busdec.ds${i}_rready",         "nds_unused_u_slvp_busdec_ds${i}_rready");
//
//                              &DANGLER("nds_unused_u_slvp_busdec_ds${i}_awvalid");
//                              &DANGLER("nds_unused_u_slvp_busdec_ds${i}_wvalid");
//                              &DANGLER("nds_unused_u_slvp_busdec_ds${i}_bready");
//                              &DANGLER("nds_unused_u_slvp_busdec_ds${i}_arvalid");
//                              &DANGLER("nds_unused_u_slvp_busdec_ds${i}_rready");
//                      &ENDIF("ATCBUSDEC302_SLV${i}_SUPPORT");
//              } else {
//                      &IFDEF("ATCBUSDEC302_SLV${i}_SUPPORT");
//                              &CONNECT("u_slvp_busdec.ds${i}_awvalid",  "slvp_busdec_ds${i}_awvalid");
//                              &CONNECT("u_slvp_busdec.ds${i}_awready",  "slvp_busdec_ds${i}_awready");
//                              &CONNECT("u_slvp_busdec.ds${i}_wvalid",   "slvp_busdec_ds${i}_wvalid");
//                              &CONNECT("u_slvp_busdec.ds${i}_wready",   "slvp_busdec_ds${i}_wready");
//                              &CONNECT("u_slvp_busdec.ds${i}_bresp",    "slvp_busdec_ds${i}_bresp");
//                              &CONNECT("u_slvp_busdec.ds${i}_bvalid",   "slvp_busdec_ds${i}_bvalid");
//                              &CONNECT("u_slvp_busdec.ds${i}_bready",   "slvp_busdec_ds${i}_bready");
//                              &CONNECT("u_slvp_busdec.ds${i}_arvalid",  "slvp_busdec_ds${i}_arvalid");
//                              &CONNECT("u_slvp_busdec.ds${i}_arready",  "slvp_busdec_ds${i}_arready");
//                              &CONNECT("u_slvp_busdec.ds${i}_rdata",    "slvp_busdec_ds${i}_rdata");
//                              &CONNECT("u_slvp_busdec.ds${i}_rresp",    "slvp_busdec_ds${i}_rresp");
//                              &CONNECT("u_slvp_busdec.ds${i}_rlast",    "slvp_busdec_ds${i}_rlast");
//                              &CONNECT("u_slvp_busdec.ds${i}_rvalid",   "slvp_busdec_ds${i}_rvalid");
//                              &CONNECT("u_slvp_busdec.ds${i}_rready",   "slvp_busdec_ds${i}_rready");
//
//                              &FORCE("wire", "slvp_busdec_ds${i}_arvalid");
//                              &FORCE("wire", "slvp_busdec_ds${i}_arready");
//
//                              &FORCE("wire", "slvp_busdec_ds${i}_awvalid");
//                              &FORCE("wire", "slvp_busdec_ds${i}_awready");
//
//                              &FORCE("wire", "slvp_busdec_ds${i}_wvalid");
//                              &FORCE("wire", "slvp_busdec_ds${i}_wready");
//
//                              &FORCE("wire", "slvp_busdec_ds${i}_rvalid");
//                              &FORCE("wire", "slvp_busdec_ds${i}_rready");
//                              &FORCE("wire", "slvp_busdec_ds${i}_rlast");
//                              &FORCE("wire", "slvp_busdec_ds${i}_rdata[SLVPORT_DATA_MSB:0]");
//                              &FORCE("wire", "slvp_busdec_ds${i}_rresp");
//
//                              &FORCE("wire", "slvp_busdec_ds${i}_bvalid");
//                              &FORCE("wire", "slvp_busdec_ds${i}_bready");
//                              &FORCE("wire", "slvp_busdec_ds${i}_bresp");
//

//              	if ($prefix =~ m/core0/) {
//				&DANGLER("core0_fs_bus_s_protection_error");
//              	} else {
//				&DANGLER("core1_fs_bus_s_protection_error");
//              	}
//				&DANGLER("${prefix}araddrcode");
//				&DANGLER("${prefix}arctl0code");
//				&DANGLER("${prefix}arctl1code");
//				&DANGLER("${prefix}aridcode");
//				&DANGLER("${prefix}arreadycode");
//				&DANGLER("${prefix}arutid");
//				&DANGLER("${prefix}arvalidcode");
//				&DANGLER("${prefix}awaddrcode");
//				&DANGLER("${prefix}awctl0code");
//				&DANGLER("${prefix}awctl1code");
//				&DANGLER("${prefix}awidcode");
//				&DANGLER("${prefix}awreadycode");
//				&DANGLER("${prefix}awutid");
//				&DANGLER("${prefix}awvalidcode");
//				&DANGLER("${prefix}bctlcode");
//				&DANGLER("${prefix}bidcode");
//				&DANGLER("${prefix}breadycode");
//				&DANGLER("${prefix}butid");
//				&DANGLER("${prefix}bvalidcode");
//				&DANGLER("${prefix}rctlcode");
//				&DANGLER("${prefix}rdatacode");
//				&DANGLER("${prefix}reobi");
//				&DANGLER("${prefix}ridcode");
//				&DANGLER("${prefix}rreadycode");
//				&DANGLER("${prefix}rutid");
//				&DANGLER("${prefix}rvalidcode");
//				&DANGLER("${prefix}wctlcode");
//				&DANGLER("${prefix}wdatacode");
//				&DANGLER("${prefix}weobi");
//				&DANGLER("${prefix}wreadycode");
//				&DANGLER("${prefix}wutid");
//				&DANGLER("${prefix}wvalidcode");

//                              :`ifdef NDS_IO_SLAVEPORT_COMMON_X1
//                              :       `ifdef ATCBUSDEC302_SLV${i}_SUPPORT
//                              :       assign ${prefix}arvalid =       slvp_busdec_ds${i}_arvalid;
//                              :       assign ${prefix}awvalid =       slvp_busdec_ds${i}_awvalid;
//                              :       assign ${prefix}wvalid  =       slvp_busdec_ds${i}_wvalid;
//                              :       assign ${prefix}bready  =       slvp_busdec_ds${i}_bready;
//                              :       assign ${prefix}rready  =       slvp_busdec_ds${i}_rready;
//                              :
//                              :       assign slvp_busdec_ds${i}_arready = ${prefix}arready;
//                              :       assign slvp_busdec_ds${i}_awready = ${prefix}awready;
//                              :       assign slvp_busdec_ds${i}_wready  = ${prefix}wready;
//
//                              :       assign slvp_busdec_ds${i}_rvalid = ${prefix}rvalid;
//                              :       assign slvp_busdec_ds${i}_rlast  = ${prefix}rlast;
//                              :       assign slvp_busdec_ds${i}_rdata  = ${prefix}rdata;
//                              :       assign slvp_busdec_ds${i}_rresp  = ${prefix}rresp;
//
//                              :       assign slvp_busdec_ds${i}_bvalid = ${prefix}bvalid;
//                              :       assign slvp_busdec_ds${i}_bresp  = ${prefix}bresp;
//
//                              :       assign ${prefix}awaddr  =       busdec2slv_awaddr       ;
//                              :       assign ${prefix}awlen   =       busdec2slv_awlen        ;
//                              :       assign ${prefix}awsize  =       busdec2slv_awsize       ;
//                              :       assign ${prefix}awburst =       busdec2slv_awburst      ;
//                              :       assign ${prefix}awlock  =       busdec2slv_awlock       ;
//                              :       assign ${prefix}awcache =       busdec2slv_awcache      ;
//                              :       assign ${prefix}awprot  =       busdec2slv_awprot       ;
//                              :       assign ${prefix}wdata   =       busdec2slv_wdata        ;
//                              :       assign ${prefix}wstrb   =       busdec2slv_wstrb        ;
//                              :       assign ${prefix}wlast   =       busdec2slv_wlast        ;
//                              :       assign ${prefix}araddr  =       busdec2slv_araddr       ;
//                              :       assign ${prefix}arlen   =       busdec2slv_arlen        ;
//                              :       assign ${prefix}arsize  =       busdec2slv_arsize       ;
//                              :       assign ${prefix}arburst =       busdec2slv_arburst      ;
//                              :       assign ${prefix}arlock  =       busdec2slv_arlock       ;
//                              :       assign ${prefix}arcache =       busdec2slv_arcache      ;
//                              :       assign ${prefix}arprot  =       busdec2slv_arprot       ;
//
//                              :       assign ${prefix}awid    =       {(SLVPORT_ID_WIDTH){1'b0}}      ;
//                              :       assign ${prefix}arid    =       {(SLVPORT_ID_WIDTH){1'b0}}      ;
//                              :       `endif // ATCBUSDEC302_SLV${i}_SUPPORT
//                              :`endif // NDS_IO_SLAVEPORT_COMMON_X1
//                              :`ifdef NDS_IO_SLAVEPORT_ECC_X1
//                              :       `ifdef ATCBUSDEC302_SLV${i}_SUPPORT
//              	if ($prefix =~ m/core0/) {
//				:	wire nds_unused_core0_fs_bus_s_protection_error = (|core0_fs_bus_s_protection_error);
//              	} else {
//				:	wire nds_unused_core1_fs_bus_s_protection_error = (|core1_fs_bus_s_protection_error);
//              	}
//              		:	`ifdef NDS_IO_SLAVEPORT_QOS_X1
//              		:	wire [11:0]			${prefix}arctl0code_i = {${prefix}arqos,${prefix}aruser,${prefix}arcache,${prefix}arprot};
//              		:	`else
//              		:	wire [7:0]			${prefix}arctl0code_i = {${prefix}aruser,${prefix}arcache,${prefix}arprot};
//              		:	`endif
//              		:	wire [SLV_CTRL_CODE_WIDTH-1:0]	${prefix}arctl0code_o;
//              		:	wire [13:0]			${prefix}arctl1code_i = {${prefix}arlock,${prefix}arburst,${prefix}arsize,${prefix}arlen};
//              		:	wire [SLV_CTRL_CODE_WIDTH-1:0]	${prefix}arctl1code_o;
//              		:	wire [SLVPORT_ID_WIDTH-1:0]	${prefix}aridcode_i = ${prefix}arid[(SLVPORT_ID_WIDTH-1):0];
//              		:	wire [SLV_CTRL_CODE_WIDTH  :0]	${prefix}aridcode_o; // only use [SLV_CTRL_CODE_WIDTH-1:0]

//              		:	`ifdef NDS_IO_SLAVEPORT_QOS_X1
//              		:	wire [11:0]			${prefix}awctl0code_i = {${prefix}awqos,${prefix}awuser,${prefix}awcache,${prefix}awprot};
//              		:	`else
//              		:	wire [7:0]			${prefix}awctl0code_i = {${prefix}awuser,${prefix}awcache,${prefix}awprot};
//              		:	`endif
//              		:	wire [SLV_CTRL_CODE_WIDTH-1:0]	${prefix}awctl0code_o;
//              		:	wire [13:0]			${prefix}awctl1code_i = {${prefix}awlock,${prefix}awburst,${prefix}awsize,${prefix}awlen};
//              		:	wire [SLV_CTRL_CODE_WIDTH-1:0]	${prefix}awctl1code_o;
//              		:	wire [SLVPORT_ID_WIDTH-1:0]	${prefix}awidcode_i = ${prefix}awid[(SLVPORT_ID_WIDTH-1):0];
//              		:	wire [SLV_CTRL_CODE_WIDTH  :0]	${prefix}awidcode_o; // only use [SLV_CTRL_CODE_WIDTH-1:0]

//				:	wire [SLVPORT_WSTRB_WIDTH  :0]  ${prefix}wctlcode_i = {${prefix}wlast, ${prefix}wstrb};
//              		:	wire [SLV_CTRL_CODE_WIDTH :0]	${prefix}wctlcode_o; // only use [SLV_CTRL_CODE_WIDTH-1:0]

//              		:	kv_secded_enc #(.DW(ADDR_WIDTH)) u_${prefix}araddrcode (.data(${prefix}araddr), .parity(${prefix}araddrcode));
//              		:	`ifdef NDS_IO_SLAVEPORT_QOS_X1
//              		:	kv_ded_enc #(.DW(12)) u_${prefix}arctl0code (.data(${prefix}arctl0code_i[11:0]), .parity(${prefix}arctl0code_o[4:0]));
//              		:	`else
//              		:	kv_ded_enc #(.DW(8)) u_${prefix}arctl0code (.data(${prefix}arctl0code_i[7:0]), .parity(${prefix}arctl0code_o[3:0]));
//              		:	assign ${prefix}arctl0code_o[4] = 1'b0;
//              		:	`endif
//              		:	kv_ded_enc #(.DW(14)) u_${prefix}arctl1code (.data(${prefix}arctl1code_i), .parity(${prefix}arctl1code_o));
//              		:	kv_ded_enc #(.DW(SLVPORT_ID_WIDTH)) u_${prefix}aridcode (.data(${prefix}aridcode_i), .parity(${prefix}aridcode_o[SLV_ID_CODE_WIDTH-1:0]));
//              		:	assign ${prefix}aridcode_o[SLV_CTRL_CODE_WIDTH:SLV_ID_CODE_WIDTH] = {(SLV_CTRL_CODE_WIDTH+1-SLV_ID_CODE_WIDTH){1'b0}};

//              		:	kv_secded_enc #(.DW(ADDR_WIDTH)) u_${prefix}awaddrcode (.data(${prefix}awaddr), .parity(${prefix}awaddrcode));
//              		:	`ifdef NDS_IO_SLAVEPORT_QOS_X1
//              		:	kv_ded_enc #(.DW(12)) u_${prefix}awctl0code (.data(${prefix}awctl0code_i[11:0]), .parity(${prefix}awctl0code_o[4:0]));
//              		:	`else
//              		:	kv_ded_enc #(.DW(8)) u_${prefix}awctl0code (.data(${prefix}awctl0code_i[7:0]), .parity(${prefix}awctl0code_o[3:0]));
//              		:	assign ${prefix}awctl0code_o[4] = 1'b0;
//              		:	`endif
//              		:	kv_ded_enc #(.DW(14)) u_${prefix}awctl1code (.data(${prefix}awctl1code_i), .parity(${prefix}awctl1code_o));
//              		:	kv_ded_enc #(.DW(SLVPORT_ID_WIDTH)) u_${prefix}awidcode (.data(${prefix}awidcode_i), .parity(${prefix}awidcode_o[SLV_ID_CODE_WIDTH-1:0]));
//              		:	assign ${prefix}awidcode_o[SLV_CTRL_CODE_WIDTH:SLV_ID_CODE_WIDTH] = {(SLV_CTRL_CODE_WIDTH+1-SLV_ID_CODE_WIDTH){1'b0}};

//              		:	kv_ded_enc #(.DW(SLVPORT_WSTRB_WIDTH+1)) u_${prefix}wctlcode (.data(${prefix}wctlcode_i), .parity(${prefix}wctlcode_o[SLV_WCTRL_CODE_WIDTH-1:0]));
//              		:	assign ${prefix}wctlcode_o[SLV_CTRL_CODE_WIDTH:SLV_WCTRL_CODE_WIDTH] = {(SLV_CTRL_CODE_WIDTH+1-SLV_WCTRL_CODE_WIDTH){1'b0}};

//				:	generate
//				:	genvar ${prefix}wdatacode_idx;
//				:	for (${prefix}wdatacode_idx = 0; ${prefix}wdatacode_idx < (SLVPORT_DATA_WIDTH/64); ${prefix}wdatacode_idx = ${prefix}wdatacode_idx + 1) begin: gen_${prefix}wdatacode
//              		:		kv_secded_enc #(.DW(64)) u_${prefix}wdatacode (.data(${prefix}wdata[${prefix}wdatacode_idx*64+:64]), .parity(${prefix}wdatacode[${prefix}wdatacode_idx*8+:8]));
//				:	end
//				:	endgenerate

//              		:	assign ${prefix}arctl0code  = ${prefix}arctl0code_o;
//              		:	assign ${prefix}arctl1code  = ${prefix}arctl1code_o;
//              		:	assign ${prefix}aridcode    = ${prefix}aridcode_o[SLV_CTRL_CODE_WIDTH-1:0];

//              		:	assign ${prefix}awctl0code  = ${prefix}awctl0code_o;
//              		:	assign ${prefix}awctl1code  = ${prefix}awctl1code_o;
//              		:	assign ${prefix}awidcode    = ${prefix}awidcode_o[SLV_CTRL_CODE_WIDTH-1:0];

//				:	assign ${prefix}wctlcode    = ${prefix}wctlcode_o[SLV_CTRL_CODE_WIDTH-1:0];

//				:	reg ${prefix}weobi_r;
//				:	wire ${prefix}weobi_en;
//				:	wire ${prefix}weobi_nx;
//              	if ($prefix =~ m/core0/) {
//				:	always @ (posedge ${prefix}clk or negedge core0_slvp_reset_n) begin
//				:		if (!core0_slvp_reset_n) begin
//              	} else {
//				:	always @ (posedge ${prefix}clk or negedge core1_slvp_reset_n) begin
//				:		if (!core1_slvp_reset_n) begin
//              	}
//				:			${prefix}weobi_r <= 1'b0;
//				:		end
//				:		else if (${prefix}weobi_en) begin
//				:			${prefix}weobi_r <= ${prefix}weobi_nx;
//				:		end
//				:	end
//				:	assign ${prefix}weobi_en = ${prefix}wvalid & ${prefix}wready;
//				:	assign ${prefix}weobi_nx = ~${prefix}wlast & ~${prefix}weobi_r;
//				:	assign ${prefix}weobi    = ${prefix}weobi_r;

//				:	assign ${prefix}arvalidcode = ~${prefix}arvalid;
//				:	assign ${prefix}awvalidcode = ~${prefix}awvalid;
//				:	assign ${prefix}wvalidcode  = ~${prefix}wvalid;
//				:	assign ${prefix}breadycode  = ~${prefix}bready;
//				:	assign ${prefix}rreadycode  = ~${prefix}rready;

//				:	reg	[(SLV_UTID_WIDTH-1):0]	${prefix}arutid_cnt;
//				:	wire	[SLV_UTID_WIDTH:0]	${prefix}arutid_cnt_incr1;
//				:	assign ${prefix}arutid_cnt_incr1 = ${prefix}arutid_cnt + {{(SLV_UTID_WIDTH-1){1'b0}}, 1'b1};
//              	if ($prefix =~ m/core0/) {
//				:	always @ (posedge ${prefix}clk or negedge core0_slvp_reset_n) begin
//				:		if (!core0_slvp_reset_n)
//              	} else {
//				:	always @ (posedge ${prefix}clk or negedge core1_slvp_reset_n) begin
//				:		if (!core1_slvp_reset_n)
//              	}
//				:			${prefix}arutid_cnt <= {(SLV_UTID_WIDTH){1'b0}};
//				:		else if (${prefix}arvalid & ${prefix}arready)
//				:			${prefix}arutid_cnt <= ${prefix}arutid_cnt_incr1[(SLV_UTID_WIDTH-1):0];
//				:	end
//				:	assign ${prefix}arutid      = ${prefix}arutid_cnt;

//				:	reg	[(SLV_UTID_WIDTH-1):0]	${prefix}awutid_cnt;
//				:	wire	[SLV_UTID_WIDTH:0]	${prefix}awutid_cnt_incr1;
//				:	assign ${prefix}awutid_cnt_incr1 = ${prefix}awutid_cnt + {{(SLV_UTID_WIDTH-1){1'b0}}, 1'b1};
//              	if ($prefix =~ m/core0/) {
//				:	always @ (posedge ${prefix}clk or negedge core0_slvp_reset_n) begin
//				:		if (!core0_slvp_reset_n)
//              	} else {
//				:	always @ (posedge ${prefix}clk or negedge core1_slvp_reset_n) begin
//				:		if (!core1_slvp_reset_n)
//              	}
//				:			${prefix}awutid_cnt <= {(SLV_UTID_WIDTH){1'b0}};
//				:		else if (${prefix}awvalid & ${prefix}awready)
//				:			${prefix}awutid_cnt <= ${prefix}awutid_cnt_incr1[(SLV_UTID_WIDTH-1):0];
//				:	end
//				:	assign ${prefix}awutid      = ${prefix}awutid_cnt;

//				:	wire	${prefix}wutid_wvalid = ${prefix}awvalid & ${prefix}awready;
//				:	wire	nds_unused_${prefix}wutid_wready;
//				:	wire	nds_unused_${prefix}wutid_rvalid;
//				:	wire	${prefix}wutid_rready = ${prefix}wvalid & ${prefix}wready & ${prefix}wlast;
//				:	kv_fifo #(
//				:		.DEPTH           (16),
//				:		.RAR_SUPPORT     (`NDS_RAR_SUPPORT),
//				:		.WIDTH           (SLV_UTID_WIDTH)
//				:	) u_${prefix}wutid (
//				:		.clk    (${prefix}clk),
//              	if ($prefix =~ m/core0/) {
//				:		.reset_n(core0_slvp_reset_n),
//              	} else {
//				:		.reset_n(core1_slvp_reset_n),
//              	}
//              		:		.flush	(1'b0),
//				:		.wdata  (${prefix}awutid),
//				:		.wvalid (${prefix}wutid_wvalid),
//				:		.wready (nds_unused_${prefix}wutid_wready),
//				:		.rdata  (${prefix}wutid),
//				:		.rvalid (nds_unused_${prefix}wutid_rvalid),
//				:		.rready (${prefix}wutid_rready)
//				:	);

//				:	wire nds_unused_${prefix}ecc	=   ${prefix}arreadycode
//				:					|   ${prefix}awreadycode
//				:					| (|${prefix}bctlcode)
//				:					| (|${prefix}bidcode)
//				:					| (|${prefix}butid)
//				:					|   ${prefix}bvalidcode
//				:					| (|${prefix}rctlcode)
//				:					| (|${prefix}rdatacode)
//				:					|   ${prefix}reobi
//				:					| (|${prefix}ridcode)
//				:					| (|${prefix}rutid)
//				:					|   ${prefix}rvalidcode
//				:					|   ${prefix}wreadycode
//				:					;
//                              :       `endif // ATCBUSDEC302_SLV${i}_SUPPORT
//                              :`endif // NDS_IO_SLAVEPORT_ECC_X1

//                      &ENDIF("ATCBUSDEC302_SLV${i}_SUPPORT");
//
//              }
//      }
//      &CONNECT("u_slvp_busdec.ds_awaddr",     "busdec2slv_awaddr");
//      &CONNECT("u_slvp_busdec.ds_awlen",      "busdec2slv_awlen");
//      &CONNECT("u_slvp_busdec.ds_awsize",     "busdec2slv_awsize");
//      &CONNECT("u_slvp_busdec.ds_awburst",    "busdec2slv_awburst");
//      &CONNECT("u_slvp_busdec.ds_awlock",     "busdec2slv_awlock");
//      &CONNECT("u_slvp_busdec.ds_awcache",    "busdec2slv_awcache");
//      &CONNECT("u_slvp_busdec.ds_awprot",     "busdec2slv_awprot");
//      &CONNECT("u_slvp_busdec.ds_wdata",      "busdec2slv_wdata");
//      &CONNECT("u_slvp_busdec.ds_wstrb",      "busdec2slv_wstrb");
//      &CONNECT("u_slvp_busdec.ds_wlast",      "busdec2slv_wlast");
//      &CONNECT("u_slvp_busdec.ds_araddr",     "busdec2slv_araddr");
//      &CONNECT("u_slvp_busdec.ds_arlen",      "busdec2slv_arlen");
//      &CONNECT("u_slvp_busdec.ds_arsize",     "busdec2slv_arsize");
//      &CONNECT("u_slvp_busdec.ds_arburst",    "busdec2slv_arburst");
//      &CONNECT("u_slvp_busdec.ds_arlock",     "busdec2slv_arlock");
//      &CONNECT("u_slvp_busdec.ds_arcache",    "busdec2slv_arcache");
//      &CONNECT("u_slvp_busdec.ds_arprot",     "busdec2slv_arprot");

//      &FORCE("wire", "busdec2slv_awaddr[ADDR_MSB:0]");
//      &FORCE("wire", "busdec2slv_awlen[7:0]");
//      &FORCE("wire", "busdec2slv_awsize[2:0]");
//      &FORCE("wire", "busdec2slv_awburst[1:0]");
//      &FORCE("wire", "busdec2slv_awlock");
//      &FORCE("wire", "busdec2slv_awcache[3:0]");
//      &FORCE("wire", "busdec2slv_awprot[2:0]");
//      &FORCE("wire", "busdec2slv_wdata[SLVPORT_DATA_MSB:0]");
//      &FORCE("wire", "busdec2slv_wstrb[SLVPORT_WSTRB_MSB:0]");
//      &FORCE("wire", "busdec2slv_wlast");
//      &FORCE("wire", "busdec2slv_araddr[ADDR_MSB:0]");
//      &FORCE("wire", "busdec2slv_arlen[7:0]");
//      &FORCE("wire", "busdec2slv_arsize[2:0]");
//      &FORCE("wire", "busdec2slv_arburst[1:0]");
//      &FORCE("wire", "busdec2slv_arlock");
//      &FORCE("wire", "busdec2slv_arcache[3:0]");
//      &FORCE("wire", "busdec2slv_arprot[2:0]");

//      &CONNECT("u_slvp_busdec.us_araddr",     "slv_araddr");
//      &CONNECT("u_slvp_busdec.us_arburst",    "slv_arburst");
//      &CONNECT("u_slvp_busdec.us_arcache",    "slv_arcache");
//      &CONNECT("u_slvp_busdec.us_arid",       "slv_arid");
//      &CONNECT("u_slvp_busdec.us_arlen",      "slv_arlen");
//      &CONNECT("u_slvp_busdec.us_arlock",     "slv_arlock");
//      &CONNECT("u_slvp_busdec.us_arprot",     "slv_arprot");
//      &CONNECT("u_slvp_busdec.us_arsize",     "slv_arsize");
//      &CONNECT("u_slvp_busdec.us_arvalid",    "slv_arvalid");
//      &CONNECT("u_slvp_busdec.us_arready",    "slv_arready");
//      &CONNECT("u_slvp_busdec.us_awaddr",     "slv_awaddr");
//      &CONNECT("u_slvp_busdec.us_awburst",    "slv_awburst");
//      &CONNECT("u_slvp_busdec.us_awcache",    "slv_awcache");
//      &CONNECT("u_slvp_busdec.us_awid",       "slv_awid");
//      &CONNECT("u_slvp_busdec.us_awlen",      "slv_awlen");
//      &CONNECT("u_slvp_busdec.us_awlock",     "slv_awlock");
//      &CONNECT("u_slvp_busdec.us_awprot",     "slv_awprot");
//      &CONNECT("u_slvp_busdec.us_awsize",     "slv_awsize");
//      &CONNECT("u_slvp_busdec.us_awvalid",    "slv_awvalid");
//      &CONNECT("u_slvp_busdec.us_awready",    "slv_awready");
//      &CONNECT("u_slvp_busdec.us_wdata",      "slv_wdata");
//      &CONNECT("u_slvp_busdec.us_wlast",      "slv_wlast");
//      &CONNECT("u_slvp_busdec.us_wstrb",      "slv_wstrb");
//      &CONNECT("u_slvp_busdec.us_wvalid",     "slv_wvalid");
//      &CONNECT("u_slvp_busdec.us_wready",     "slv_wready");
//      &CONNECT("u_slvp_busdec.us_bready",     "slv_bready");
//      &CONNECT("u_slvp_busdec.us_bid",        "slv_bid");
//      &CONNECT("u_slvp_busdec.us_bresp",      "slv_bresp");
//      &CONNECT("u_slvp_busdec.us_bvalid",     "slv_bvalid");
//      &CONNECT("u_slvp_busdec.us_rdata",      "slv_rdata");
//      &CONNECT("u_slvp_busdec.us_rid",        "slv_rid");
//      &CONNECT("u_slvp_busdec.us_rlast",      "slv_rlast");
//      &CONNECT("u_slvp_busdec.us_rresp",      "slv_rresp");
//      &CONNECT("u_slvp_busdec.us_rvalid",     "slv_rvalid");
//      &CONNECT("u_slvp_busdec.us_rready",     "slv_rready");
//      &CONNECT("u_slvp_busdec.aclk",          "aclk");
//      &CONNECT("u_slvp_busdec.aresetn",       "aresetn");

//      $i = ${BUSDEC_SLV_HART0};
//      $prefix = "core0_slv_";
//      &CONNECT_SLVP_BUSDEC(${i}, ${prefix});

//      &IFDEF("NDS_IO_HART1");
//      $i = ${BUSDEC_SLV_HART1};
//      $prefix = "core1_slv_";
//      &CONNECT_SLVP_BUSDEC(${i}, ${prefix});
//      &ENDIF("NDS_IO_HART1");

//      &IFDEF("NDS_IO_HART2");
//      $i = ${BUSDEC_SLV_HART2};
//      $prefix = "NC_";
//      &CONNECT_SLVP_BUSDEC(${i}, ${prefix});
//      &ENDIF("NDS_IO_HART2");

//      &IFDEF("NDS_IO_HART3");
//      $i = ${BUSDEC_SLV_HART3};
//      $prefix = "NC_";
//      &CONNECT_SLVP_BUSDEC(${i}, ${prefix});
//      &ENDIF("NDS_IO_HART3");
//
//&ENDIF("NDS_IO_SLAVEPORT_COMMON_X1");
//
//# debug module to hart
//&FORCE("wire",        "dm_debugint[(NHART-1):0]");
//&FORCE("wire",        "dm_resethaltreq[(NHART-1):0]");
//&FORCE("wire",        "dm_hart_unavail[(NHART-1):0]");
//&FORCE("wire",        "dm_hart_under_reset[(NHART-1):0]");
//
//# --- Debug I/O --
//&FORCE("output",      "dbg_srst_req");
//&IFDEF("PLATFORM_DEBUG_SUBSYSTEM");
//      &FORCE("wire",          "ndmreset");
//      &FORCE("output",        "dmactive");
//      &FORCE("input",         "dmi_haddr[8:0]");
//      &FORCE("input",         "dmi_hburst[2:0]");
//      &FORCE("input",         "dmi_hprot[3:0]");
//      &FORCE("input",         "dmi_hready");
//      &FORCE("input",         "dmi_resetn");
//      &FORCE("input",         "dmi_hsel");
//      &FORCE("input",         "dmi_hsize[2:0]");
//      &FORCE("input",         "dmi_htrans[1:0]");
//      &FORCE("input",         "dmi_hwdata[31:0]");
//      &FORCE("input",         "dmi_hwrite");
//      &FORCE("output",        "dmi_hreadyout");
//      &FORCE("output",        "dmi_hresp[1:0]");
//      &FORCE("output",        "dmi_hrdata[31:0]");
//      &IFDEF("PLATFORM_PLDM_SYS_BUS_ACCESS");
//              &FORCE("output",        "dm_sys_araddr[ADDR_MSB:0]");
//              &FORCE("output",        "dm_sys_arburst[1:0]");
//              &FORCE("output",        "dm_sys_arcache[3:0]");
//              &FORCE("output",        "dm_sys_arid[BIU_ID_MSB:0]");
//              &FORCE("output",        "dm_sys_arlen[7:0]");
//              &FORCE("output",        "dm_sys_arlock");
//              &FORCE("output",        "dm_sys_arprot[2:0]");
//              &FORCE("input",         "dm_sys_arready");
//              &FORCE("output",        "dm_sys_arsize[2:0]");
//              &FORCE("output",        "dm_sys_arvalid");
//              &FORCE("output",        "dm_sys_awaddr[ADDR_MSB:0]");
//              &FORCE("output",        "dm_sys_awburst[1:0]");
//              &FORCE("output",        "dm_sys_awcache[3:0]");
//              &FORCE("output",        "dm_sys_awid[BIU_ID_MSB:0]");
//              &FORCE("output",        "dm_sys_awlen[7:0]");
//              &FORCE("output",        "dm_sys_awlock");
//              &FORCE("output",        "dm_sys_awprot[2:0]");
//              &FORCE("input",         "dm_sys_awready");
//              &FORCE("output",        "dm_sys_awsize[2:0]");
//              &FORCE("output",        "dm_sys_awvalid");
//              &FORCE("input",         "dm_sys_bid[BIU_ID_MSB:0]");
//              &FORCE("output",        "dm_sys_bready");
//              &FORCE("input",         "dm_sys_bresp[1:0]");
//              &FORCE("input",         "dm_sys_bvalid");
//              &FORCE("input",         "dm_sys_rdata[(BIU_DATA_WIDTH-1):0]");
//              &FORCE("input",         "dm_sys_rid[BIU_ID_MSB:0]");
//              &FORCE("input",         "dm_sys_rlast");
//              &FORCE("output",        "dm_sys_rready");
//              &FORCE("input",         "dm_sys_rresp[1:0]");
//              &FORCE("input",         "dm_sys_rvalid");
//              &FORCE("output",        "dm_sys_wdata[(BIU_DATA_WIDTH-1):0]");
//              &FORCE("output",        "dm_sys_wlast");
//              &FORCE("input",         "dm_sys_wready");
//              &FORCE("output",        "dm_sys_wstrb[((BIU_DATA_WIDTH/8)-1):0]");
//              &FORCE("output",        "dm_sys_wvalid");
//      &ELSE("PLATFORM_PLDM_SYS_BUS_ACCESS");
//              &FORCE("wire",  "dm_sys_araddr[ADDR_MSB:0]");
//              &FORCE("wire",  "dm_sys_arburst[1:0]");
//              &FORCE("wire",  "dm_sys_arcache[3:0]");
//              &FORCE("wire",  "dm_sys_arid[BIU_ID_MSB:0]");
//              &FORCE("wire",  "dm_sys_arlen[7:0]");
//              &FORCE("wire",  "dm_sys_arlock");
//              &FORCE("wire",  "dm_sys_arprot[2:0]");
//              &FORCE("wire",  "dm_sys_arready");
//              &FORCE("wire",  "dm_sys_arsize[2:0]");
//              &FORCE("wire",  "dm_sys_arvalid");
//              &FORCE("wire",  "dm_sys_awaddr[ADDR_MSB:0]");
//              &FORCE("wire",  "dm_sys_awburst[1:0]");
//              &FORCE("wire",  "dm_sys_awcache[3:0]");
//              &FORCE("wire",  "dm_sys_awid[BIU_ID_MSB:0]");
//              &FORCE("wire",  "dm_sys_awlen[7:0]");
//              &FORCE("wire",  "dm_sys_awlock");
//              &FORCE("wire",  "dm_sys_awprot[2:0]");
//              &FORCE("wire",  "dm_sys_awready");
//              &FORCE("wire",  "dm_sys_awsize[2:0]");
//              &FORCE("wire",  "dm_sys_awvalid");
//              &FORCE("wire",  "dm_sys_bid[BIU_ID_MSB:0]");
//              &FORCE("wire",  "dm_sys_bready");
//              &FORCE("wire",  "dm_sys_bresp[1:0]");
//              &FORCE("wire",  "dm_sys_bvalid");
//              &FORCE("wire",  "dm_sys_rdata[(BIU_DATA_WIDTH-1):0]");
//              &FORCE("wire",  "dm_sys_rid[BIU_ID_MSB:0]");
//              &FORCE("wire",  "dm_sys_rlast");
//              &FORCE("wire",  "dm_sys_rready");
//              &FORCE("wire",  "dm_sys_rresp[1:0]");
//              &FORCE("wire",  "dm_sys_rvalid");
//              &FORCE("wire",  "dm_sys_wdata[(BIU_DATA_WIDTH-1):0]");
//              &FORCE("wire",  "dm_sys_wlast");
//              &FORCE("wire",  "dm_sys_wready");
//              &FORCE("wire",  "dm_sys_wstrb[((BIU_DATA_WIDTH/8)-1):0]");
//              &FORCE("wire",  "dm_sys_wvalid");
//      &ENDIF("PLATFORM_PLDM_SYS_BUS_ACCESS");
//&ENDIF("PLATFORM_DEBUG_SUBSYSTEM");
//
//###############################################################################
//# Flash0 Ingress
//###############################################################################
//
//&IFDEF("NDS_IO_BUS_PROTECTION");
//&IFDEF("ATCBMC301_MST1_SUPPORT")
//&IFDEF("NDS_IO_FLASHIF0")
//&DANGLER("nds_unused_flash0_event_ctl_err");
//&DANGLER("nds_unused_flash0_event_data_err");
//&DANGLER("nds_unused_flash0_event_handshake_err");
//&DANGLER("nds_unused_flash0_event_eobi_err");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/top/hdl/nds_scpu_bus_ingress.v", "u_flash0_ingress", {
//	ID_WIDTH	    => "FLASHIF0_ID_WIDTH",
//	DATA_WIDTH	    => "BIU_DATA_WIDTH",
//	DS_ADDR_WIDTH	    => "ADDR_WIDTH",
//	US_ADDR_WIDTH	    => "BIU_ADDR_WIDTH",
//	DATA_CODE_WIDTH	    => "BIU_DATA_CODE_WIDTH",
//	ADDR_CODE_WIDTH	    => "BIU_ADDR_CODE_WIDTH",
//	UTID_WIDTH	    => "BIU_UTID_WIDTH",
//	WCTRL_CODE_WIDTH    => "WCTRL_CODE_WIDTH",
//	BIU_CTRL_CODE_WIDTH => "BIU_CTRL_CODE_WIDTH",
//});
//&CONNECT("u_flash0_ingress", {
//	event_ctl_err  => "nds_unused_flash0_event_ctl_err",
//	event_data_err  => "nds_unused_flash0_event_data_err",
//	event_handshake_err  => "nds_unused_flash0_event_handshake_err",
//	event_eobi_err  => "nds_unused_flash0_event_eobi_err",
//      us_araddr      => "cluster_flash0_araddr",
//      us_arburst     => "cluster_flash0_arburst",
//      us_arcache     => "cluster_flash0_arcache",
//      us_arid        => "cluster_flash0_arid",
//      us_arlen       => "cluster_flash0_arlen",
//      us_arlock      => "cluster_flash0_arlock",
//      us_arprot      => "cluster_flash0_arprot",
//      us_arready     => "cluster_flash0_arready",
//      us_arsize      => "cluster_flash0_arsize",
//      us_arvalid     => "cluster_flash0_arvalid",
//      us_arctl0code  => "cluster_flash0_arctl0code",
//      us_arctl1code  => "cluster_flash0_arctl1code",
//      us_araddrcode  => "cluster_flash0_araddrcode",
//      us_aridcode    => "cluster_flash0_aridcode",
//      us_arvalidcode => "cluster_flash0_arvalidcode",
//      us_arreadycode => "cluster_flash0_arreadycode",
//      us_arutid      => "cluster_flash0_arutid",
//
//      us_awaddr      => "cluster_flash0_awaddr",
//      us_awburst     => "cluster_flash0_awburst",
//      us_awcache     => "cluster_flash0_awcache",
//      us_awid        => "cluster_flash0_awid",
//      us_awlen       => "cluster_flash0_awlen",
//      us_awlock      => "cluster_flash0_awlock",
//      us_awprot      => "cluster_flash0_awprot",
//      us_awready     => "cluster_flash0_awready",
//      us_awsize      => "cluster_flash0_awsize",
//      us_awvalid     => "cluster_flash0_awvalid",
//      us_awctl0code  => "cluster_flash0_awctl0code",
//      us_awctl1code  => "cluster_flash0_awctl1code",
//      us_awaddrcode  => "cluster_flash0_awaddrcode",
//      us_awidcode    => "cluster_flash0_awidcode",
//      us_awvalidcode => "cluster_flash0_awvalidcode",
//      us_awreadycode => "cluster_flash0_awreadycode",
//      us_awutid      => "cluster_flash0_awutid",
//
//      us_bid         => "cluster_flash0_bid",
//      us_bready      => "cluster_flash0_bready",
//      us_bresp       => "cluster_flash0_bresp",
//      us_bvalid      => "cluster_flash0_bvalid",
//      us_bvalidcode  => "cluster_flash0_bvalidcode",
//      us_breadycode  => "cluster_flash0_breadycode",
//      us_bctlcode    => "cluster_flash0_bctlcode",
//      us_bidcode     => "cluster_flash0_bidcode",
//      us_butid       => "cluster_flash0_butid",
//
//      us_rid         => "cluster_flash0_rid",
//      us_rdata       => "cluster_flash0_rdata",
//      us_rlast       => "cluster_flash0_rlast",
//      us_rready      => "cluster_flash0_rready",
//      us_rresp       => "cluster_flash0_rresp",
//      us_rvalid      => "cluster_flash0_rvalid",
//      us_rvalidcode  => "cluster_flash0_rvalidcode",
//      us_rreadycode  => "cluster_flash0_rreadycode",
//      us_rdatacode   => "cluster_flash0_rdatacode",
//      us_ridcode     => "cluster_flash0_ridcode",
//      us_rctlcode    => "cluster_flash0_rctlcode",
//      us_reobi       => "cluster_flash0_reobi",
//      us_rutid       => "cluster_flash0_rutid",
//
//
//#     us_rsnoop      => "cluster_flash0_rsnoop",
//
//      us_wdata       => "cluster_flash0_wdata",
//      us_wlast       => "cluster_flash0_wlast",
//      us_wready      => "cluster_flash0_wready",
//      us_wstrb       => "cluster_flash0_wstrb",
//      us_wvalid      => "cluster_flash0_wvalid",
//      us_wvalidcode  => "cluster_flash0_wvalidcode",
//      us_wreadycode  => "cluster_flash0_wreadycode",
//      us_wdatacode   => "cluster_flash0_wdatacode",
//      us_wctlcode   => "cluster_flash0_wctlcode",
//      us_weobi       => "cluster_flash0_weobi",
//      us_wutid       => "cluster_flash0_wutid",
//
//      ds_araddr      => "axi_flash0_araddr",
//      ds_arburst     => "axi_flash0_arburst",
//      ds_arcache     => "axi_flash0_arcache",
//      ds_arid        => "axi_flash0_arid_out",
//      ds_arlen       => "axi_flash0_arlen",
//      ds_arlock      => "axi_flash0_arlock",
//      ds_arprot      => "axi_flash0_arprot",
//      ds_arready     => "axi_flash0_arready",
//      ds_arsize      => "axi_flash0_arsize",
//      ds_arvalid     => "axi_flash0_arvalid",
//
//      ds_awaddr      => "axi_flash0_awaddr",
//      ds_awburst     => "axi_flash0_awburst",
//      ds_awcache     => "axi_flash0_awcache",
//      ds_awid        => "axi_flash0_awid_out",
//      ds_awlen       => "axi_flash0_awlen",
//      ds_awlock      => "axi_flash0_awlock",
//      ds_awprot      => "axi_flash0_awprot",
//      ds_awready     => "axi_flash0_awready",
//      ds_awsize      => "axi_flash0_awsize",
//      ds_awvalid     => "axi_flash0_awvalid",
//
//      ds_bid         => "axi_flash0_bid_in",
//      ds_bready      => "axi_flash0_bready",
//      ds_bresp       => "axi_flash0_bresp",
//      ds_bvalid      => "axi_flash0_bvalid",
//
//	ds_rid	       => "axi_flash0_rid_in",
//      ds_rdata       => "axi_flash0_rdata",
//      ds_rlast       => "axi_flash0_rlast",
//      ds_rready      => "axi_flash0_rready",
//      ds_rresp       => "axi_flash0_rresp",
//      ds_rvalid      => "axi_flash0_rvalid",
//
//
//#     ds_rsnoop      => "axi_flash0_rsnoop",
//
//      ds_wdata       => "axi_flash0_wdata",
//      ds_wlast       => "axi_flash0_wlast",
//      ds_wready      => "axi_flash0_wready",
//      ds_wstrb       => "axi_flash0_wstrb",
//      ds_wvalid      => "axi_flash0_wvalid",
//
//      aclk           => "aclk",
//      aresetn	       => "aresetn",
//
//});
//&ENDIF("NDS_IO_FLASHIF0");
//&ENDIF("ATCBMC301_MST1_SUPPORT");
//&ENDIF("NDS_IO_BUS_PROTECTION");
//
//&IFDEF("ATCBMC301_MST1_SUPPORT")
//&IFDEF("NDS_IO_FLASHIF0")
//&IFDEF("NDS_IO_BUS_PROTECTION")
//&FORCE("wire","axi_flash0_arid[BIU_ID_WIDTH-1:0]");
//&FORCE("wire","axi_flash0_awid[BIU_ID_WIDTH-1:0]");
//&FORCE("wire","axi_flash0_arid_out[FLASHIF0_ID_WIDTH-1:0]");
//&FORCE("wire","axi_flash0_awid_out[FLASHIF0_ID_WIDTH-1:0]");
//&FORCE("wire","axi_flash0_rid[BIU_ID_WIDTH-1:0]");
//&FORCE("wire","axi_flash0_bid[BIU_ID_WIDTH-1:0]");
//&FORCE("wire","axi_flash0_rid_in[FLASHIF0_ID_WIDTH-1:0]");
//&FORCE("wire","axi_flash0_bid_in[FLASHIF0_ID_WIDTH-1:0]");
//&ENDIF("NDS_IO_BUS_PROTECTION");
//&ENDIF("NDS_IO_FLASHIF0");
//&ENDIF("ATCBMC301_MST1_SUPPORT");
//
//:`ifdef ATCBMC301_MST1_SUPPORT
//:`ifdef NDS_IO_FLASHIF0
//:`ifdef NDS_IO_BUS_PROTECTION
//:generate
//:if (FLASHIF0_ID_WIDTH > BIU_ID_WIDTH) begin : gen_id_flash_gt_biu
//:        assign axi_flash0_arid = axi_flash0_arid_out[BIU_ID_WIDTH-1:0];
//:        assign axi_flash0_awid = axi_flash0_awid_out[BIU_ID_WIDTH-1:0];
//:	   assign axi_flash0_rid_in = {{(FLASHIF0_ID_WIDTH-BIU_ID_WIDTH){1'b0}}, axi_flash0_rid}; 
//:	   assign axi_flash0_bid_in = {{(FLASHIF0_ID_WIDTH-BIU_ID_WIDTH){1'b0}}, axi_flash0_bid}; 
//:end
//:else if (FLASHIF0_ID_WIDTH == BIU_ID_WIDTH) begin : gen_id_flash_eq_biu
//:        assign axi_flash0_arid = axi_flash0_arid_out;
//:        assign axi_flash0_awid = axi_flash0_awid_out;
//:	   assign axi_flash0_rid_in = axi_flash0_rid; 
//:	   assign axi_flash0_bid_in = axi_flash0_bid; 
//:end
//:else begin : gen_id_flash_lt_biu
//:        assign axi_flash0_arid = {{(BIU_ID_WIDTH-FLASHIF0_ID_WIDTH){1'b0}}, axi_flash0_arid_out};
//:        assign axi_flash0_awid = {{(BIU_ID_WIDTH-FLASHIF0_ID_WIDTH){1'b0}}, axi_flash0_awid_out};
//:        assign axi_flash0_rid_in = axi_flash0_rid[FLASHIF0_ID_WIDTH-1:0];
//:        assign axi_flash0_bid_in = axi_flash0_bid[FLASHIF0_ID_WIDTH-1:0];
//:end
//:endgenerate
//:`endif // NDS_IO_BUS_PROTECTION
//:`ifndef NDS_IO_BUS_PROTECTION
//:generate
//:if (FLASHIF0_ID_WIDTH > BIU_ID_WIDTH) begin : gen_id_flash_gt_biu
//:        assign axi_flash0_arid = cluster_flash0_arid[BIU_ID_WIDTH-1:0];
//:        assign axi_flash0_awid = cluster_flash0_awid[BIU_ID_WIDTH-1:0];
//:	   assign cluster_flash0_rid = {{(FLASHIF0_ID_WIDTH-BIU_ID_WIDTH){1'b0}}, axi_flash0_rid}; 
//:	   assign cluster_flash0_bid = {{(FLASHIF0_ID_WIDTH-BIU_ID_WIDTH){1'b0}}, axi_flash0_bid}; 
//:end
//:else if (FLASHIF0_ID_WIDTH == BIU_ID_WIDTH) begin : gen_id_flash_eq_biu
//:        assign axi_flash0_arid = cluster_flash0_arid;
//:        assign axi_flash0_awid = cluster_flash0_awid;
//:	   assign cluster_flash0_rid = axi_flash0_rid; 
//:	   assign cluster_flash0_bid = axi_flash0_bid; 
//:end
//:else begin : gen_id_flash_lt_biu
//:        assign axi_flash0_arid = {{(BIU_ID_WIDTH-FLASHIF0_ID_WIDTH){1'b0}}, cluster_flash0_arid};
//:        assign axi_flash0_awid = {{(BIU_ID_WIDTH-FLASHIF0_ID_WIDTH){1'b0}}, cluster_flash0_awid};
//:        assign cluster_flash0_rid = axi_flash0_rid[FLASHIF0_ID_WIDTH-1:0];
//:        assign cluster_flash0_bid = axi_flash0_bid[FLASHIF0_ID_WIDTH-1:0];
//:end
//:endgenerate
//:`endif // NDS_IO_BUS_PROTECTION
//:`endif // NDS_IO_FLASHIF0
//:`endif // ATCBMC301_MST1_SUPPORT
//:`ifdef ATCBMC301_MST1_SUPPORT
//:`ifdef NDS_IO_FLASHIF0
//:`ifndef NDS_IO_BUS_PROTECTION
//:assign cluster_flash0_arready = axi_flash0_arready;
//:assign axi_flash0_arvalid = cluster_flash0_arvalid;
//:assign axi_flash0_araddr  = cluster_flash0_araddr;
//:assign axi_flash0_arburst = cluster_flash0_arburst;
//:assign axi_flash0_arcache = cluster_flash0_arcache;
//:assign axi_flash0_arlen   = cluster_flash0_arlen;
//:assign axi_flash0_arlock  = cluster_flash0_arlock;
//:assign axi_flash0_arprot  = cluster_flash0_arprot;
//:assign axi_flash0_arsize  = cluster_flash0_arsize; 
//:
//:assign cluster_flash0_awready = axi_flash0_awready;
//:assign axi_flash0_awvalid = cluster_flash0_awvalid;
//:assign axi_flash0_awaddr  = cluster_flash0_awaddr;
//:assign axi_flash0_awburst = cluster_flash0_awburst;
//:assign axi_flash0_awcache = cluster_flash0_awcache;
//:assign axi_flash0_awlen   = cluster_flash0_awlen;
//:assign axi_flash0_awlock  = cluster_flash0_awlock;
//:assign axi_flash0_awprot  = cluster_flash0_awprot;
//:assign axi_flash0_awsize  = cluster_flash0_awsize; 
//:
//:assign cluster_flash0_wready  = axi_flash0_wready;
//:assign axi_flash0_wdata  = cluster_flash0_wdata;
//:assign axi_flash0_wlast  = cluster_flash0_wlast;
//:assign axi_flash0_wstrb  = cluster_flash0_wstrb;
//:assign axi_flash0_wvalid = cluster_flash0_wvalid;
//:
//:assign axi_flash0_bready = cluster_flash0_bready;
//:assign cluster_flash0_bresp  = axi_flash0_bresp;
//:assign cluster_flash0_bvalid = axi_flash0_bvalid;
//:
//:assign axi_flash0_rready = cluster_flash0_rready;
//:assign cluster_flash0_rdata  = axi_flash0_rdata;
//:assign cluster_flash0_rlast  = axi_flash0_rlast;
//:assign cluster_flash0_rresp  = axi_flash0_rresp;
//:assign cluster_flash0_rvalid = axi_flash0_rvalid;
//:`endif
//:`endif 
//:`endif 
//
//###############################################################################
//# sys0 Ingress
//###############################################################################
//
//&IFDEF("NDS_IO_BUS_PROTECTION");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/top/hdl/nds_scpu_bus_ingress.v", "u_sys0_ingress", {
//	ID_WIDTH	 => "BIU_ID_WIDTH",
//	DATA_WIDTH	 => "BIU_DATA_WIDTH",
//	US_ADDR_WIDTH	 => "BIU_ADDR_WIDTH",
//	DS_ADDR_WIDTH	 => "ADDR_WIDTH",
//	DATA_CODE_WIDTH	 => "BIU_DATA_CODE_WIDTH",
//	ADDR_CODE_WIDTH	 => "BIU_ADDR_CODE_WIDTH",
//	UTID_WIDTH	 => "BIU_UTID_WIDTH",
//	WCTRL_CODE_WIDTH => "WCTRL_CODE_WIDTH",
//	BIU_CTRL_CODE_WIDTH => "BIU_CTRL_CODE_WIDTH",
//});
//&DANGLER("nds_unused_sys0_event_ctl_err");
//&DANGLER("nds_unused_sys0_event_data_err");
//&DANGLER("nds_unused_sys0_event_handshake_err");
//&DANGLER("nds_unused_sys0_event_eobi_err");
//&CONNECT("u_sys0_ingress", {
//	event_ctl_err  => "nds_unused_sys0_event_ctl_err",
//	event_data_err  => "nds_unused_sys0_event_data_err",
//	event_handshake_err  => "nds_unused_sys0_event_handshake_err",
//	event_eobi_err  => "nds_unused_sys0_event_eobi_err",
//      us_araddr      => "cluster_sys0_araddr",
//      us_arburst     => "cluster_sys0_arburst",
//      us_arcache     => "cluster_sys0_arcache",
//      us_arid        => "cluster_sys0_arid",
//      us_arlen       => "cluster_sys0_arlen",
//      us_arlock      => "cluster_sys0_arlock",
//      us_arprot      => "cluster_sys0_arprot",
//      us_arready     => "cluster_sys0_arready",
//      us_arsize      => "cluster_sys0_arsize",
//      us_arvalid     => "cluster_sys0_arvalid",
//      us_arctl0code  => "cluster_sys0_arctl0code",
//      us_arctl1code  => "cluster_sys0_arctl1code",
//      us_araddrcode  => "cluster_sys0_araddrcode",
//      us_aridcode    => "cluster_sys0_aridcode",
//      us_arvalidcode => "cluster_sys0_arvalidcode",
//      us_arreadycode => "cluster_sys0_arreadycode",
//      us_arutid      => "cluster_sys0_arutid",
//
//      us_awaddr      => "cluster_sys0_awaddr",
//      us_awburst     => "cluster_sys0_awburst",
//      us_awcache     => "cluster_sys0_awcache",
//      us_awid        => "cluster_sys0_awid",
//      us_awlen       => "cluster_sys0_awlen",
//      us_awlock      => "cluster_sys0_awlock",
//      us_awprot      => "cluster_sys0_awprot",
//      us_awready     => "cluster_sys0_awready",
//      us_awsize      => "cluster_sys0_awsize",
//      us_awvalid     => "cluster_sys0_awvalid",
//      us_awctl0code  => "cluster_sys0_awctl0code",
//      us_awctl1code  => "cluster_sys0_awctl1code",
//      us_awaddrcode  => "cluster_sys0_awaddrcode",
//      us_awidcode    => "cluster_sys0_awidcode",
//      us_awvalidcode => "cluster_sys0_awvalidcode",
//      us_awreadycode => "cluster_sys0_awreadycode",
//      us_awutid      => "cluster_sys0_awutid",
//
//      us_bid         => "cluster_sys0_bid",
//      us_bready      => "cluster_sys0_bready",
//      us_bresp       => "cluster_sys0_bresp",
//      us_bvalid      => "cluster_sys0_bvalid",
//      us_bvalidcode  => "cluster_sys0_bvalidcode",
//      us_breadycode  => "cluster_sys0_breadycode",
//      us_bctlcode    => "cluster_sys0_bctlcode",
//      us_bidcode     => "cluster_sys0_bidcode",
//      us_butid       => "cluster_sys0_butid",
//
//      us_rid         => "cluster_sys0_rid",
//      us_rdata       => "cluster_sys0_rdata",
//      us_rlast       => "cluster_sys0_rlast",
//      us_rready      => "cluster_sys0_rready",
//      us_rresp       => "cluster_sys0_rresp",
//      us_rvalid      => "cluster_sys0_rvalid",
//      us_rvalidcode  => "cluster_sys0_rvalidcode",
//      us_rreadycode  => "cluster_sys0_rreadycode",
//      us_rdatacode   => "cluster_sys0_rdatacode",
//      us_ridcode     => "cluster_sys0_ridcode",
//      us_rctlcode    => "cluster_sys0_rctlcode",
//      us_reobi       => "cluster_sys0_reobi",
//      us_rutid       => "cluster_sys0_rutid",
//
//
//#     us_rsnoop      => "cluster_sys0_rsnoop",
//
//      us_wdata       => "cluster_sys0_wdata",
//      us_wlast       => "cluster_sys0_wlast",
//      us_wready      => "cluster_sys0_wready",
//      us_wstrb       => "cluster_sys0_wstrb",
//      us_wvalid      => "cluster_sys0_wvalid",
//      us_wvalidcode  => "cluster_sys0_wvalidcode",
//      us_wreadycode  => "cluster_sys0_wreadycode",
//      us_wdatacode   => "cluster_sys0_wdatacode",
//      us_wctlcode   => "cluster_sys0_wctlcode",
//      us_weobi       => "cluster_sys0_weobi",
//      us_wutid       => "cluster_sys0_wutid",
//
//      ds_araddr      => "axi_sys0_araddr",
//      ds_arburst     => "axi_sys0_arburst",
//      ds_arcache     => "axi_sys0_arcache",
//      ds_arid        => "axi_sys0_arid",
//      ds_arlen       => "axi_sys0_arlen",
//      ds_arlock      => "axi_sys0_arlock",
//      ds_arprot      => "axi_sys0_arprot",
//      ds_arready     => "axi_sys0_arready",
//      ds_arsize      => "axi_sys0_arsize",
//      ds_arvalid     => "axi_sys0_arvalid",
//
//      ds_awaddr      => "axi_sys0_awaddr",
//      ds_awburst     => "axi_sys0_awburst",
//      ds_awcache     => "axi_sys0_awcache",
//      ds_awid        => "axi_sys0_awid",
//      ds_awlen       => "axi_sys0_awlen",
//      ds_awlock      => "axi_sys0_awlock",
//      ds_awprot      => "axi_sys0_awprot",
//      ds_awready     => "axi_sys0_awready",
//      ds_awsize      => "axi_sys0_awsize",
//      ds_awvalid     => "axi_sys0_awvalid",
//
//      ds_bid         => "axi_sys0_bid",
//      ds_bready      => "axi_sys0_bready",
//      ds_bresp       => "axi_sys0_bresp",
//      ds_bvalid      => "axi_sys0_bvalid",
//
//	ds_rid	       => "axi_sys0_rid",
//      ds_rdata       => "axi_sys0_rdata",
//      ds_rlast       => "axi_sys0_rlast",
//      ds_rready      => "axi_sys0_rready",
//      ds_rresp       => "axi_sys0_rresp",
//      ds_rvalid      => "axi_sys0_rvalid",
//
//
//#     ds_rsnoop      => "axi_sys0_rsnoop",
//
//      ds_wdata       => "axi_sys0_wdata",
//      ds_wlast       => "axi_sys0_wlast",
//      ds_wready      => "axi_sys0_wready",
//      ds_wstrb       => "axi_sys0_wstrb",
//      ds_wvalid      => "axi_sys0_wvalid",
//
//      aclk           => "aclk",
//      aresetn	       => "aresetn",
//
//});
//&ENDIF("NDS_IO_BUS_PROTECTION");
//
//:`ifndef NDS_IO_BUS_PROTECTION
//:assign cluster_sys0_arready = axi_sys0_arready;
//:assign axi_sys0_arvalid = cluster_sys0_arvalid;
//:assign axi_sys0_araddr  = cluster_sys0_araddr;
//:assign axi_sys0_arburst = cluster_sys0_arburst;
//:assign axi_sys0_arcache = cluster_sys0_arcache;
//:assign axi_sys0_arid    = cluster_sys0_arid;
//:assign axi_sys0_arlen   = cluster_sys0_arlen;
//:assign axi_sys0_arlock  = cluster_sys0_arlock;
//:assign axi_sys0_arprot  = cluster_sys0_arprot;
//:assign axi_sys0_arsize  = cluster_sys0_arsize; 
//:
//:assign cluster_sys0_awready = axi_sys0_awready;
//:assign axi_sys0_awvalid = cluster_sys0_awvalid;
//:assign axi_sys0_awaddr  = cluster_sys0_awaddr;
//:assign axi_sys0_awburst = cluster_sys0_awburst;
//:assign axi_sys0_awcache = cluster_sys0_awcache;
//:assign axi_sys0_awid    = cluster_sys0_awid;
//:assign axi_sys0_awlen   = cluster_sys0_awlen;
//:assign axi_sys0_awlock  = cluster_sys0_awlock;
//:assign axi_sys0_awprot  = cluster_sys0_awprot;
//:assign axi_sys0_awsize  = cluster_sys0_awsize; 
//:
//:assign cluster_sys0_wready  = axi_sys0_wready;
//:assign axi_sys0_wdata  = cluster_sys0_wdata;
//:assign axi_sys0_wlast  = cluster_sys0_wlast;
//:assign axi_sys0_wstrb  = cluster_sys0_wstrb;
//:assign axi_sys0_wvalid = cluster_sys0_wvalid;
//:
//:assign axi_sys0_bready = cluster_sys0_bready;
//:assign cluster_sys0_bid    = axi_sys0_bid;
//:assign cluster_sys0_bresp  = axi_sys0_bresp;
//:assign cluster_sys0_bvalid = axi_sys0_bvalid;
//:
//:assign axi_sys0_rready = cluster_sys0_rready;
//:assign cluster_sys0_rid    = axi_sys0_rid;
//:assign cluster_sys0_rdata  = axi_sys0_rdata;
//:assign cluster_sys0_rlast  = axi_sys0_rlast;
//:assign cluster_sys0_rresp  = axi_sys0_rresp;
//:assign cluster_sys0_rvalid = axi_sys0_rvalid;
//:`endif
//###############################################################################
//# SPP Ingress
//###############################################################################
//
//&IFDEF("NDS_IO_BUS_PROTECTION");
//&IFDEF("NDS_IO_SPP");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/top/hdl/nds_scpu_bus_ingress.v", "u_spp_ingress", {
//	ID_WIDTH	=> "`NDS_SPP_ID_WIDTH",
//	DATA_WIDTH	=> "`NDS_SPP_DATA_WIDTH",
//	DS_ADDR_WIDTH	=> "ADDR_WIDTH",
//	US_ADDR_WIDTH	=> "BIU_ADDR_WIDTH",
//	DATA_CODE_WIDTH	=> "`NDS_SPP_DATA_CODE_WIDTH",
//	ADDR_CODE_WIDTH	=> "BIU_ADDR_CODE_WIDTH",
//	UTID_WIDTH	=> "BIU_UTID_WIDTH",
//	WCTRL_CODE_WIDTH => "WCTRL_CODE_WIDTH",
//	BIU_CTRL_CODE_WIDTH => "BIU_CTRL_CODE_WIDTH",
//});
//&DANGLER("nds_unused_spp_event_ctl_err");
//&DANGLER("nds_unused_spp_event_data_err");
//&DANGLER("nds_unused_spp_event_handshake_err");
//&DANGLER("nds_unused_spp_event_eobi_err");
//&CONNECT("u_spp_ingress", {
//	event_ctl_err  => "nds_unused_spp_event_ctl_err",
//	event_data_err  => "nds_unused_spp_event_data_err",
//	event_handshake_err  => "nds_unused_spp_event_handshake_err",
//	event_eobi_err  => "nds_unused_spp_event_eobi_err",
//      us_araddr      => "spp_araddr",
//      us_arburst     => "spp_arburst",
//      us_arcache     => "spp_arcache",
//      us_arid        => "spp_arid",
//      us_arlen       => "spp_arlen",
//      us_arlock      => "spp_arlock",
//      us_arprot      => "spp_arprot",
//      us_arready     => "spp_arready",
//      us_arsize      => "spp_arsize",
//      us_arvalid     => "spp_arvalid",
//      us_arctl0code  => "spp_arctl0code",
//      us_arctl1code  => "spp_arctl1code",
//      us_araddrcode  => "spp_araddrcode",
//      us_aridcode    => "spp_aridcode",
//      us_arvalidcode => "spp_arvalidcode",
//      us_arreadycode => "spp_arreadycode",
//      us_arutid      => "spp_arutid",
//
//      us_awaddr      => "spp_awaddr",
//      us_awburst     => "spp_awburst",
//      us_awcache     => "spp_awcache",
//      us_awid        => "spp_awid",
//      us_awlen       => "spp_awlen",
//      us_awlock      => "spp_awlock",
//      us_awprot      => "spp_awprot",
//      us_awready     => "spp_awready",
//      us_awsize      => "spp_awsize",
//      us_awvalid     => "spp_awvalid",
//      us_awctl0code  => "spp_awctl0code",
//      us_awctl1code  => "spp_awctl1code",
//      us_awaddrcode  => "spp_awaddrcode",
//      us_awidcode    => "spp_awidcode",
//      us_awvalidcode => "spp_awvalidcode",
//      us_awreadycode => "spp_awreadycode",
//      us_awutid      => "spp_awutid",
//
//      us_bid         => "spp_bid",
//      us_bready      => "spp_bready",
//      us_bresp       => "spp_bresp",
//      us_bvalid      => "spp_bvalid",
//      us_bvalidcode  => "spp_bvalidcode",
//      us_breadycode  => "spp_breadycode",
//      us_bctlcode    => "spp_bctlcode",
//      us_bidcode     => "spp_bidcode",
//      us_butid       => "spp_butid",
//
//      us_rid         => "spp_rid",
//      us_rdata       => "spp_rdata",
//      us_rlast       => "spp_rlast",
//      us_rready      => "spp_rready",
//      us_rresp       => "spp_rresp",
//      us_rvalid      => "spp_rvalid",
//      us_rvalidcode  => "spp_rvalidcode",
//      us_rreadycode  => "spp_rreadycode",
//      us_rdatacode   => "spp_rdatacode",
//      us_ridcode     => "spp_ridcode",
//      us_rctlcode    => "spp_rctlcode",
//      us_reobi       => "spp_reobi",
//      us_rutid       => "spp_rutid",
//
//
//#     us_rsnoop      => "cluster_spp_rsnoop",
//
//      us_wdata       => "spp_wdata",
//      us_wlast       => "spp_wlast",
//      us_wready      => "spp_wready",
//      us_wstrb       => "spp_wstrb",
//      us_wvalid      => "spp_wvalid",
//      us_wvalidcode  => "spp_wvalidcode",
//      us_wreadycode  => "spp_wreadycode",
//      us_wdatacode   => "spp_wdatacode",
//      us_wctlcode   => "spp_wctlcode",
//      us_weobi       => "spp_weobi",
//      us_wutid       => "spp_wutid",
//
//      ds_araddr      => "axi_spp_araddr",
//      ds_arburst     => "axi_spp_arburst",
//      ds_arcache     => "axi_spp_arcache",
//      ds_arid        => "axi_spp_arid",
//      ds_arlen       => "axi_spp_arlen",
//      ds_arlock      => "axi_spp_arlock",
//      ds_arprot      => "axi_spp_arprot",
//      ds_arready     => "axi_spp_arready",
//      ds_arsize      => "axi_spp_arsize",
//      ds_arvalid     => "axi_spp_arvalid",
//
//      ds_awaddr      => "axi_spp_awaddr",
//      ds_awburst     => "axi_spp_awburst",
//      ds_awcache     => "axi_spp_awcache",
//      ds_awid        => "axi_spp_awid",
//      ds_awlen       => "axi_spp_awlen",
//      ds_awlock      => "axi_spp_awlock",
//      ds_awprot      => "axi_spp_awprot",
//      ds_awready     => "axi_spp_awready",
//      ds_awsize      => "axi_spp_awsize",
//      ds_awvalid     => "axi_spp_awvalid",
//
//      ds_bid         => "axi_spp_bid",
//      ds_bready      => "axi_spp_bready",
//      ds_bresp       => "axi_spp_bresp",
//      ds_bvalid      => "axi_spp_bvalid",
//
//	ds_rid	       => "axi_spp_rid",
//      ds_rdata       => "axi_spp_rdata",
//      ds_rlast       => "axi_spp_rlast",
//      ds_rready      => "axi_spp_rready",
//      ds_rresp       => "axi_spp_rresp",
//      ds_rvalid      => "axi_spp_rvalid",
//
//
//#     ds_rsnoop      => "axi_spp_rsnoop",
//
//      ds_wdata       => "axi_spp_wdata",
//      ds_wlast       => "axi_spp_wlast",
//      ds_wready      => "axi_spp_wready",
//      ds_wstrb       => "axi_spp_wstrb",
//      ds_wvalid      => "axi_spp_wvalid",
//
//      aclk           => "aclk",
//      aresetn	       => "aresetn",
//
//});
//&ENDIF("NDS_IO_SPP");
//&ENDIF("NDS_IO_BUS_PROTECTION");
//
//:`ifdef NDS_IO_SPP
//:`ifndef NDS_IO_BUS_PROTECTION
//:assign spp_arready = axi_spp_arready;
//:assign axi_spp_arvalid = spp_arvalid;
//:assign axi_spp_araddr  = spp_araddr;
//:assign axi_spp_arburst = spp_arburst;
//:assign axi_spp_arcache = spp_arcache;
//:assign axi_spp_arid    = spp_arid;
//:assign axi_spp_arlen   = spp_arlen;
//:assign axi_spp_arlock  = spp_arlock;
//:assign axi_spp_arprot  = spp_arprot;
//:assign axi_spp_arsize  = spp_arsize; 
//:
//:assign spp_awready = axi_spp_awready;
//:assign axi_spp_awvalid = spp_awvalid;
//:assign axi_spp_awaddr  = spp_awaddr;
//:assign axi_spp_awburst = spp_awburst;
//:assign axi_spp_awcache = spp_awcache;
//:assign axi_spp_awid    = spp_awid;
//:assign axi_spp_awlen   = spp_awlen;
//:assign axi_spp_awlock  = spp_awlock;
//:assign axi_spp_awprot  = spp_awprot;
//:assign axi_spp_awsize  = spp_awsize; 
//:
//:assign spp_wready  = axi_spp_wready;
//:assign axi_spp_wdata  = spp_wdata;
//:assign axi_spp_wlast  = spp_wlast;
//:assign axi_spp_wstrb  = spp_wstrb;
//:assign axi_spp_wvalid = spp_wvalid;
//:
//:assign axi_spp_bready = spp_bready;
//:assign spp_bid    = axi_spp_bid;
//:assign spp_bresp  = axi_spp_bresp;
//:assign spp_bvalid = axi_spp_bvalid;
//:
//:assign axi_spp_rready = spp_rready;
//:assign spp_rid    = axi_spp_rid;
//:assign spp_rdata  = axi_spp_rdata;
//:assign spp_rlast  = axi_spp_rlast;
//:assign spp_rresp  = axi_spp_rresp;
//:assign spp_rvalid = axi_spp_rvalid;
//:`endif
//:`endif
//
//
//&IFDEF("NDS_IO_SPP");
//&FORCE("wire", "axi_spp_araddr[((ADDR_WIDTH)-1):0]");
//&FORCE("wire", "axi_spp_arburst[1:0]");
//&FORCE("wire", "axi_spp_arcache[3:0]");
//&FORCE("wire", "axi_spp_arid[(((`NDS_SPP_ID_WIDTH))-1):0]");
//&FORCE("wire", "axi_spp_arlen[7:0]");
//&FORCE("wire", "axi_spp_arlock");
//&FORCE("wire", "axi_spp_arprot[2:0]");
//&FORCE("wire", "axi_spp_arready");
//&FORCE("wire", "axi_spp_arsize[2:0]");
//&FORCE("wire", "axi_spp_arvalid");
//&FORCE("wire", "axi_spp_awaddr[((ADDR_WIDTH)-1):0]");
//&FORCE("wire", "axi_spp_awburst[1:0]");
//&FORCE("wire", "axi_spp_awcache[3:0]");
//&FORCE("wire", "axi_spp_awid[(((`NDS_SPP_ID_WIDTH))-1):0]");
//&FORCE("wire", "axi_spp_awlen[7:0]");
//&FORCE("wire", "axi_spp_awlock");
//&FORCE("wire", "axi_spp_awprot[2:0]");
//&FORCE("wire", "axi_spp_awready");
//&FORCE("wire", "axi_spp_awsize[2:0]");
//&FORCE("wire", "axi_spp_awvalid");
//&FORCE("wire", "axi_spp_bid[(((`NDS_SPP_ID_WIDTH))-1):0]");
//&FORCE("wire", "axi_spp_bready");
//&FORCE("wire", "axi_spp_bresp[1:0]");
//&FORCE("wire", "axi_spp_bvalid");
//&FORCE("wire", "axi_spp_rdata[(((`NDS_SPP_DATA_WIDTH))-1):0]");
//&FORCE("wire", "axi_spp_rid[(((`NDS_SPP_ID_WIDTH))-1):0]");
//&FORCE("wire", "axi_spp_rlast");
//&FORCE("wire", "axi_spp_rready");
//&FORCE("wire", "axi_spp_rresp[1:0]");
//&FORCE("wire", "axi_spp_rvalid");
//&FORCE("wire", "axi_spp_wdata[(((`NDS_SPP_DATA_WIDTH))-1):0]");
//&FORCE("wire", "axi_spp_wlast");
//&FORCE("wire", "axi_spp_wready");
//&FORCE("wire", "axi_spp_wstrb[(((`NDS_SPP_DATA_WIDTH))/8)-1:0]");
//&FORCE("wire", "axi_spp_wvalid");
//
//&ENDIF("NDS_IO_SPP");
//
//for (0..1) {
//    &CONNECT("u_cluster", {
//        "core${_}_current_pc"            => "hart${_}_probe_current_pc",
//        "core${_}_gpr_index"             => "hart${_}_probe_gpr_index",
//        "core${_}_selected_gpr_value"    => "hart${_}_probe_selected_gpr_value",
//
//        "core${_}_gen1_trace_enabled"    => "hart${_}_gen1_trace_enabled",
//        "core${_}_gen1_trace_cause"      => "hart${_}_gen1_trace_cause",
//        "core${_}_gen1_trace_iaddr"      => "hart${_}_gen1_trace_iaddr",
//        "core${_}_gen1_trace_iexception" => "hart${_}_gen1_trace_iexception",
//        "core${_}_gen1_trace_instr"      => "hart${_}_gen1_trace_instr",
//        "core${_}_gen1_trace_interrupt"  => "hart${_}_gen1_trace_interrupt",
//        "core${_}_gen1_trace_ivalid"     => "hart${_}_gen1_trace_ivalid",
//        "core${_}_gen1_trace_priv"       => "hart${_}_gen1_trace_priv",
//        "core${_}_gen1_trace_tval"       => "hart${_}_gen1_trace_tval",
//
//        "core${_}_trace_cause"           => "hart${_}_trace_cause",
//        "core${_}_trace_context"         => "hart${_}_trace_context",
//        "core${_}_trace_ctype"           => "hart${_}_trace_ctype",
//        "core${_}_trace_enabled"         => "hart${_}_trace_enabled",
//        "core${_}_trace_stall"           => "hart${_}_trace_stall",
//        "core${_}_trace_halted"          => "hart${_}_trace_halted",
//        "core${_}_trace_iaddr"           => "hart${_}_trace_iaddr",
//        "core${_}_trace_ilastsize"       => "hart${_}_trace_ilastsize",
//        "core${_}_trace_iretire"         => "hart${_}_trace_iretire",
//        "core${_}_trace_itype"           => "hart${_}_trace_itype",
//        "core${_}_trace_priv"            => "hart${_}_trace_priv",
//        "core${_}_trace_reset"           => "hart${_}_trace_reset",
//        "core${_}_trace_trigger"         => "hart${_}_trace_trigger",
//        "core${_}_trace_tval"            => "hart${_}_trace_tval",
//
//        "core${_}_reset_vector"          => "core${_}_reset_vector",
//        "core${_}_icache_disable_init"   => "core${_}_icache_disable_init",
//        "core${_}_dcache_disable_init"   => "core${_}_dcache_disable_init",
//        "core${_}_wfi_mode"              => "core${_}_wfi_mode",
//        "core${_}_nmi"                   => "core${_}_nmi",
//        "core${_}_slv_reset_n"           => "core${_}_slvp_reset_n",
//        "core${_}_slv1_reset_n"          => "core${_}_slvp_reset_n",
//        "core${_}_ueiack"                => "nds_unused_core${_}_ueiack",
//        "core${_}_ueiid"                 => "10'b0",
//
//        "core${_}_ilm_boot"              => "ilm_boot",
//        "core${_}_dlm_boot"              => "1'b0",
//
//        "core${_}_meiack"                => "core${_}_meiack",
//        "core${_}_meiid"                 => "core${_}_meiid",
//        "core${_}_meip"                  => "core${_}_meip",
//        "core${_}_msip"                  => "hart${_}_msip",
//        "core${_}_mtip"                  => "hart${_}_mtip",
//        "core${_}_seiack"                => "core${_}_seiack",
//        "core${_}_seiid"                 => "core${_}_seiid",
//        "core${_}_seip"                  => "core${_}_seip",
//        "core${_}_ueip"                  => "core${_}_ueip",
//        "core${_}_debugint"              => "core${_}_debugint",
//        "core${_}_stoptime"              => "core${_}_stoptime",
//        "core${_}_resethaltreq"          => "core${_}_resethaltreq",
//
//    });
//}
//
// for my $i (0 .. 1) {
//      &CONNECT("u_cluster", {
//              "core${i}_hart_id"                              => "64'd${i}",
//              "core${i}_lm_reset_n"                           => "core${i}_lm_reset_n",
//
//              "core${i}_slv_araddr"                           => "core${i}_slv_araddr",
//              "core${i}_slv_arburst"                          => "core${i}_slv_arburst",
//              "core${i}_slv_arcache"                          => "core${i}_slv_arcache",
//              "core${i}_slv_arid"                             => "core${i}_slv_arid",
//              "core${i}_slv_arlen"                            => "core${i}_slv_arlen",
//              "core${i}_slv_arlock"                           => "core${i}_slv_arlock",
//              "core${i}_slv_arprot"                           => "core${i}_slv_arprot",
//              "core${i}_slv_arsize"                           => "core${i}_slv_arsize",
//              "core${i}_slv_arvalid"                          => "core${i}_slv_arvalid",
//              "core${i}_slv_arready"                          => "core${i}_slv_arready",
//              "core${i}_slv_aruser"                           => "core${i}_slv_aruser",
//              "core${i}_slv_arqos"                            => "core${i}_slv_arqos",
//
//              "core${i}_slv_awaddr"                           => "core${i}_slv_awaddr",
//              "core${i}_slv_awburst"                          => "core${i}_slv_awburst",
//              "core${i}_slv_awcache"                          => "core${i}_slv_awcache",
//              "core${i}_slv_awid"                             => "core${i}_slv_awid",
//              "core${i}_slv_awlen"                            => "core${i}_slv_awlen",
//              "core${i}_slv_awlock"                           => "core${i}_slv_awlock",
//              "core${i}_slv_awprot"                           => "core${i}_slv_awprot",
//              "core${i}_slv_awsize"                           => "core${i}_slv_awsize",
//              "core${i}_slv_awvalid"                          => "core${i}_slv_awvalid",
//              "core${i}_slv_awready"                          => "core${i}_slv_awready",
//              "core${i}_slv_awuser"                           => "core${i}_slv_awuser",
//              "core${i}_slv_awqos"                            => "core${i}_slv_awqos",
//
//              "core${i}_slv_wvalid"                           => "core${i}_slv_wvalid",
//              "core${i}_slv_wready"                           => "core${i}_slv_wready",
//              "core${i}_slv_wdata"                            => "core${i}_slv_wdata",
//              "core${i}_slv_wlast"                            => "core${i}_slv_wlast",
//              "core${i}_slv_wstrb"                            => "core${i}_slv_wstrb",
//
//              "core${i}_slv_bid"                              => "core${i}_slv_bid",
//              "core${i}_slv_bresp"                            => "core${i}_slv_bresp",
//              "core${i}_slv_bvalid"                           => "core${i}_slv_bvalid",
//              "core${i}_slv_bready"                           => "core${i}_slv_bready",
//
//              "core${i}_slv_rdata"                            => "core${i}_slv_rdata",
//              "core${i}_slv_rid"                              => "core${i}_slv_rid",
//              "core${i}_slv_rlast"                            => "core${i}_slv_rlast",
//              "core${i}_slv_rresp"                            => "core${i}_slv_rresp",
//              "core${i}_slv_rvalid"                           => "core${i}_slv_rvalid",
//              "core${i}_slv_rready"                           => "core${i}_slv_rready",

//              "core${i}_slv1_awid"                            => "{(SLVPORT_ID_WIDTH){1'bx}}",
//              "core${i}_slv1_awaddr"                          => "{(BIU_ADDR_WIDTH){1'bx}}",
//              "core${i}_slv1_awlen"                           => "8'bx",
//              "core${i}_slv1_awsize"                          => "3'bx",
//              "core${i}_slv1_awburst"                         => "2'bx",
//              "core${i}_slv1_awlock"                          => "1'bx",
//              "core${i}_slv1_awcache"                         => "4'bx",
//              "core${i}_slv1_awprot"                          => "3'bx",
//              "core${i}_slv1_awvalid"                         => "1'bx",
//              "core${i}_slv1_awuser"                          => "1'bx",
//              "core${i}_slv1_awqos"                           => "4'bx",
//              "core${i}_slv1_awready"                         => "nds_unused_core${i}_slv1_awready",

//              "core${i}_slv1_arid"                            => "{(SLVPORT_ID_WIDTH){1'bx}}",
//              "core${i}_slv1_araddr"                          => "{BIU_ADDR_WIDTH{1'bx}}",
//              "core${i}_slv1_arlen"                           => "8'bx",
//              "core${i}_slv1_arsize"                          => "3'bx",
//              "core${i}_slv1_arburst"                         => "2'bx",
//              "core${i}_slv1_arlock"                          => "1'bx",
//              "core${i}_slv1_arcache"                         => "4'bx",
//              "core${i}_slv1_arprot"                          => "3'bx",
//              "core${i}_slv1_arvalid"                         => "1'bx",
//              "core${i}_slv1_arready"                         => "nds_unused_core${i}_slv1_arready",
//              "core${i}_slv1_aruser"                          => "1'bx",
//              "core${i}_slv1_arqos"                           => "4'bx",

//              "core${i}_slv1_wdata"                           => "{(BIU_DATA_WIDTH){1'bx}}",
//              "core${i}_slv1_wstrb"                           => "{(BIU_DATA_WIDTH/8){1'bx}}",
//              "core${i}_slv1_wlast"                           => "1'bx",
//              "core${i}_slv1_wvalid"                          => "1'bx",
//              "core${i}_slv1_wready"                          => "nds_unused_core${i}_slv1_wready",

//              "core${i}_slv1_bid"                             => "nds_unused_core${i}_slv1_bid",
//              "core${i}_slv1_bresp"                           => "nds_unused_core${i}_slv1_bresp",
//              "core${i}_slv1_bvalid"                          => "nds_unused_core${i}_slv1_bvalid",
//              "core${i}_slv1_bready"                          => "1'bx",

//              "core${i}_slv1_rid"                             => "nds_unused_core${i}_slv1_rid",
//              "core${i}_slv1_rdata"                           => "nds_unused_core${i}_slv1_rdata",
//              "core${i}_slv1_rresp"                           => "nds_unused_core${i}_slv1_rresp",
//              "core${i}_slv1_rlast"                           => "nds_unused_core${i}_slv1_rlast",
//              "core${i}_slv1_rvalid"                          => "nds_unused_core${i}_slv1_rvalid",
//              "core${i}_slv1_rready"                          => "1'bx",

//		"core${i}_fs_bus_s1_protection_error"	=>	"nds_unused_core${i}_fs_bus_s1_protection_error",

//		"core${i}_slv1_araddrcode"		=>	"{(SLV_ADDR_CODE_WIDTH){1'bx}}",
//		"core${i}_slv1_arctl0code"		=>	"{(SLV_CTRL_CODE_WIDTH){1'bx}}",
//		"core${i}_slv1_arctl1code"		=>	"{(SLV_CTRL_CODE_WIDTH){1'bx}}",
//		"core${i}_slv1_aridcode"		=>	"{(SLV_CTRL_CODE_WIDTH){1'bx}}",
//		"core${i}_slv1_arreadycode"		=>	"nds_unused_core${i}_slv1_arreadycode",
//		"core${i}_slv1_arutid"			=>	"{(SLV_UTID_WIDTH){1'bx}}",
//		"core${i}_slv1_arvalidcode"		=>	"1'bx",
//		"core${i}_slv1_awaddrcode"		=>	"{(SLV_ADDR_CODE_WIDTH){1'bx}}",
//		"core${i}_slv1_awctl0code"		=>	"{(SLV_CTRL_CODE_WIDTH){1'bx}}",
//		"core${i}_slv1_awctl1code"		=>	"{(SLV_CTRL_CODE_WIDTH){1'bx}}",
//		"core${i}_slv1_awidcode"		=>	"{(SLV_CTRL_CODE_WIDTH){1'bx}}",
//		"core${i}_slv1_awreadycode"		=>	"nds_unused_core${i}_slv1_awreadycode",
//		"core${i}_slv1_awutid"			=>	"{(SLV_UTID_WIDTH){1'bx}}",
//		"core${i}_slv1_awvalidcode"		=>	"1'bx",
//		"core${i}_slv1_bctlcode"		=>	"nds_unused_core${i}_slv1_bctlcode",
//		"core${i}_slv1_bidcode"			=>	"nds_unused_core${i}_slv1_bidcode",
//		"core${i}_slv1_breadycode"		=>	"1'bx",
//		"core${i}_slv1_butid"			=>	"nds_unused_core${i}_slv1_butid",
//		"core${i}_slv1_bvalidcode"		=>	"nds_unused_core${i}_slv1_bvalidcode",
//		"core${i}_slv1_rctlcode"		=>	"nds_unused_core${i}_slv1_rctlcode",
//		"core${i}_slv1_rdatacode"		=>	"nds_unused_core${i}_slv1_rdatacode",
//		"core${i}_slv1_reobi"			=>	"nds_unused_core${i}_slv1_reobi",
//		"core${i}_slv1_ridcode"			=>	"nds_unused_core${i}_slv1_ridcode",
//		"core${i}_slv1_rreadycode"		=>	"1'bx",
//		"core${i}_slv1_rutid"			=>	"nds_unused_core${i}_slv1_rutid",
//		"core${i}_slv1_rvalidcode"		=>	"nds_unused_core${i}_slv1_rvalidcode",
//		"core${i}_slv1_wctlcode"		=>	"{(SLV_CTRL_CODE_WIDTH){1'bx}}",
//		"core${i}_slv1_wdatacode"		=>	"{(SLV_DATA_CODE_WIDTH){1'bx}}",
//		"core${i}_slv1_weobi"			=>	"1'bx",
//		"core${i}_slv1_wreadycode"		=>	"nds_unused_core${i}_slv1_wreadycode",
//		"core${i}_slv1_wutid"			=>	"{(SLV_UTID_WIDTH){1'bx}}",
//		"core${i}_slv1_wvalidcode"		=>	"1'bx",

//      });
// }
//
//for (my $i=0; $i < 2;$i++) {
//    &IFDEF("NDS_IO_HART${i}") if(${i}!=0);
//      &IFDEF("NDS_IO_LM");
//        &CONNECT("u_cluster.core${i}_lm_local_int",	"hart${i}_lm_local_int_event")
//      &ENDIF("NDS_IO_LM");
//    &ENDIF("NDS_IO_HART${i}") if(${i}!=0);
//}
//
// for my $i (1) {
//     &DANGLER("hart${i}_msip");
//     &DANGLER("hart${i}_mtip");
//     &DANGLER("hart${i}_stoptime");
// }
//
//#------------------------------------------------------------------------------
//# Trap Status
//#------------------------------------------------------------------------------
//for (my $i=0; $i<2; $i++) {
//
//	&DANGLER("nds_unused_core${i}_fs_halt_mode");
//	&DANGLER("nds_unused_core${i}_fs_trap_status_cause");
//	&DANGLER("nds_unused_core${i}_fs_trap_status_dcause");
//	&DANGLER("nds_unused_core${i}_fs_trap_status_interrupt");
//	&DANGLER("nds_unused_core${i}_fs_trap_status_nmi");
//	&DANGLER("nds_unused_core${i}_fs_trap_status_taken");
//
//	&CONNECT("u_cluster", {
//		"core${i}_fs_halt_mode"			=> "nds_unused_core${i}_fs_halt_mode",
//		"core${i}_fs_trap_status_cause"		=> "nds_unused_core${i}_fs_trap_status_cause",
//		"core${i}_fs_trap_status_dcause"	=> "nds_unused_core${i}_fs_trap_status_dcause",
//		"core${i}_fs_trap_status_interrupt"	=> "nds_unused_core${i}_fs_trap_status_interrupt",
//		"core${i}_fs_trap_status_nmi"		=> "nds_unused_core${i}_fs_trap_status_nmi",
//		"core${i}_fs_trap_status_taken"		=> "nds_unused_core${i}_fs_trap_status_taken",
//	});
//}
//
//
// #------------------------------------------------------------------------------
// # RAM CTRL
// #------------------------------------------------------------------------------
//
//my %ram_ctrl_width = (
//      btb0                    => "NDS_BTB_RAM",
//      btb1                    => "NDS_BTB_RAM",
//      btb2                    => "NDS_BTB_RAM",
//      btb3                    => "NDS_BTB_RAM",
//
//      dcache_tag0             => "NDS_DCACHE_TAG_RAM",
//      dcache_tag1             => "NDS_DCACHE_TAG_RAM",
//      dcache_tag2             => "NDS_DCACHE_TAG_RAM",
//      dcache_tag3             => "NDS_DCACHE_TAG_RAM",
//      dcache_data0            => "NDS_DCACHE_DATA_RAM",
//      dcache_data1            => "NDS_DCACHE_DATA_RAM",
//      dcache_data2            => "NDS_DCACHE_DATA_RAM",
//      dcache_data3            => "NDS_DCACHE_DATA_RAM",
//
//      icache_tag0             => "NDS_ICACHE_TAG_RAM",
//      icache_tag1             => "NDS_ICACHE_TAG_RAM",
//      icache_tag2             => "NDS_ICACHE_TAG_RAM",
//      icache_tag3             => "NDS_ICACHE_TAG_RAM",
//      icache_data0            => "NDS_ICACHE_DATA_RAM",
//      icache_data1            => "NDS_ICACHE_DATA_RAM",
//      icache_data2            => "NDS_ICACHE_DATA_RAM",
//      icache_data3            => "NDS_ICACHE_DATA_RAM",
//      icache_data4            => "NDS_ICACHE_DATA_RAM",
//      icache_data5            => "NDS_ICACHE_DATA_RAM",
//      icache_data6            => "NDS_ICACHE_DATA_RAM",
//      icache_data7            => "NDS_ICACHE_DATA_RAM",
//
//      dlm                     => "NDS_DLM_RAM",
//      dlm1                    => "NDS_DLM_RAM",
//      dlm2                    => "NDS_DLM_RAM",
//      dlm3                    => "NDS_DLM_RAM",
//
//      ilm0                    => "NDS_ILM_RAM",
//      ilm1                    => "NDS_ILM_RAM",
//
//);
//
// &KV_CPU_ASSIGN_RAM_CTRL_SIGNALS("$PVC_LOCALDIR/andes_ip/kv_core/top/hdl/nds_scpu_cluster.v", "u_cluster");
//
//
// #------------------------------------------------------------------------------
// # Timer
// #------------------------------------------------------------------------------
// $m = $AXI_SLV_PLMT0;
// $mt = $AHB_SLV_PLMT0;
//&INSTANCE("$PVC_LOCALDIR/andes_ip/soc/nceplmt100/hdl/nceplmt100.v", "u_plmt", {
//      BUS_TYPE        => "\"axi\"",
//      ADDR_WIDTH      => "ADDR_WIDTH",
//      DATA_WIDTH      => "NCE_DATA_WIDTH",
//      NHART           => "NHART",
//      GRAY_WIDTH      => "2",
//      SYNC_STAGE      => "SYNC_STAGE",
//});
//&CONNECT("u_plmt",{
//      araddr          => "plmt_araddr",
//      arburst         => "plmt_arburst",
//      arcache         => "plmt_arcache",
//      arlen           => "plmt_arlen",
//      arlock          => "plmt_arlock",
//      arprot          => "plmt_arprot",
//      arsize          => "plmt_arsize",
//      arvalid         => "plmt_arvalid",
//      arready         => "plmt_arready",
//      awaddr          => "plmt_awaddr",
//      awburst         => "plmt_awburst",
//      awcache         => "plmt_awcache",
//      awlen           => "plmt_awlen",
//      awlock          => "plmt_awlock",
//      awprot          => "plmt_awprot",
//      awsize          => "plmt_awsize",
//      awvalid         => "plmt_awvalid",
//      awready         => "plmt_awready",
//      bready          => "plmt_bready",
//      bresp           => "plmt_bresp",
//      bvalid          => "plmt_bvalid",
//      rdata           => "plmt_rdata",
//      rlast           => "plmt_rlast",
//      rready          => "plmt_rready",
//      rresp           => "plmt_rresp",
//      rvalid          => "plmt_rvalid",
//      wready          => "plmt_wready",
//      wvalid          => "plmt_wvalid",
//      wdata           => "plmt_wdata",
//      wlast           => "plmt_wlast",
//      wstrb           => "plmt_wstrb",
//      arid            => "4'd0",
//      awid            => "4'd0",
//      bid             => "nds_unused_plmt_bid",
//      rid             => "nds_unused_plmt_rid",
//
//      haddr           => "{ADDR_WIDTH{1'b0}}",
//      hburst          => "3'd0",
//      hrdata          => "nds_unused_plmt_hrdata",
//      hready          => "1'd0",
//      hreadyout       => "nds_unused_plmt_hreadyout",
//      hresp           => "nds_unused_plmt_hresp",
//      hsel            => "1'd0",
//      hsize           => "3'd0",
//      htrans          => "2'd0",
//      hwdata          => "{(NCE_DATA_WIDTH){1'b0}}",
//      hwrite          => "1'd0",
//
//      mtip            => "mtip",
//      stoptime        => "stoptime",
//      clk             => "aclk",
//      resetn          => "aresetn",
//}
//);

// #------------------------------------------------------------------------------
// # Debug
// #------------------------------------------------------------------------------
// &IFDEF("PLATFORM_DEBUG_SUBSYSTEM");
//              $dm = $AXI_SLV_DM;
//              &INSTANCE("$PVC_LOCALDIR/andes_ip/soc/ncepldm200/hdl/ncepldm200.v", "u_pldm", {
//                      NHART                           => "NHART",
//                      SYSTEM_BUS_ACCESS_SUPPORT       => "PLDM_SYS_BUS_ACCESS",
//                      DMXTRIGGER_COUNT       		=> "DMXTRIGGER_COUNT",
//                      SYS_BUS_TYPE                    => "\"axi\"",
//                      RV_BUS_TYPE                     => "\"axi\"",
//                      SYS_ADDR_WIDTH                  => "ADDR_WIDTH",
//                      SYS_ID_WIDTH                    => "BIU_ID_WIDTH",
//                      SYS_DATA_WIDTH                  => "DM_SYS_DATA_WIDTH",
//                      ADDR_WIDTH                      => "ADDR_WIDTH",
//                      DATA_WIDTH                      => "NCE_DATA_WIDTH",
//                      PROGBUF_SIZE                    => "PROGBUF_SIZE",
//                      HALTGROUP_COUNT                 => "HALTGROUP_COUNT",
//                      SYNC_STAGE                      => "SYNC_STAGE"
//              });
//              &CONNECT("u_pldm", {
//                      clk             => "aclk",
//                      bus_resetn      => "aresetn",
//                      rv_hsel         => "1'd0",
//                      rv_htrans       => "2'd0",
//                      rv_haddr        => "{ADDR_WIDTH{1'b0}}",
//                      rv_hsize        => "3'd0",
//                      rv_hburst       => "3'd0",
//                      rv_hwrite       => "1'd0",
//                      rv_hwdata       => "{(NCE_DATA_WIDTH){1'b0}}",
//                      rv_hready       => "1'd0",
//                      rv_hprot        => "4'd0",
//                      rv_hreadyout    => "nds_unused_dm_hreadyout",
//                      rv_hrdata       => "nds_unused_dm_hrdata",
//                      rv_hresp        => "nds_unused_dm_hresp",
//                      rv_araddr       => "dm_araddr",
//                      rv_arburst      => "dm_arburst",
//                      rv_arcache      => "dm_arcache",
//                      rv_arid,        => "4'd0",
//                      rv_arlen        => "dm_arlen",
//                      rv_arlock       => "dm_arlock",
//                      rv_arprot       => "dm_arprot",
//                      rv_arsize       => "dm_arsize",
//                      rv_arready      => "dm_arready",
//                      rv_arvalid      => "dm_arvalid",
//                      rv_awaddr       => "dm_awaddr",
//                      rv_awburst      => "dm_awburst",
//                      rv_awcache      => "dm_awcache",
//                      rv_awid         => "4'd0",
//                      rv_awlen        => "dm_awlen",
//                      rv_awlock       => "dm_awlock",
//                      rv_awprot       => "dm_awprot",
//                      rv_awsize       => "dm_awsize",
//                      rv_awready      => "dm_awready",
//                      rv_awvalid      => "dm_awvalid",
//                      rv_bid          => "nds_unused_dm_bid",
//                      rv_bready       => "dm_bready",
//                      rv_bresp        => "dm_bresp",
//                      rv_bvalid       => "dm_bvalid",
//                      rv_rid          => "nds_unused_dm_rid",
//                      rv_rdata        => "dm_rdata",
//                      rv_rlast        => "dm_rlast",
//                      rv_rready       => "dm_rready",
//                      rv_rresp        => "dm_rresp",
//                      rv_rvalid       => "dm_rvalid",
//                      rv_wvalid       => "dm_wvalid",
//                      rv_wready       => "dm_wready",
//                      rv_wdata        => "dm_wdata",
//                      rv_wlast        => "dm_wlast",
//                      rv_wstrb        => "dm_wstrb",
//                      sys_haddr       => "nds_unused_dm_sup_haddr",
//                      sys_hburst      => "nds_unused_dm_sup_hburst",
//                      sys_hprot       => "nds_unused_dm_sup_hprot",
//                      sys_hrdata      => "{DM_SYS_DATA_WIDTH{1'b0}}",
//                      sys_hready      => "1'b0",
//                      sys_hresp       => "2'h0",
//                      sys_hsize       => "nds_unused_dm_sup_hsize",
//                      sys_htrans      => "nds_unused_dm_sup_htrans",
//                      sys_hwdata      => "nds_unused_dm_sup_hwdata",
//                      sys_hwrite      => "nds_unused_dm_sup_hwrite",
//                      sys_hgrant      => "1'b0",
//                      sys_hbusreq     => "nds_unused_dm_sup_hbusreq",
//                      debugint        => "dm_debugint",
//                      resethaltreq    => "dm_resethaltreq",
//                      hart_unavail    => "dm_hart_unavail",
//                      hart_under_reset => "dm_hart_under_reset",
//                      xtrigger_halt_in        => "{(DMXTRIGGER_MSB+1){1'b0}}",
//                      xtrigger_halt_out       => "nds_unused_xtrigger_halt_out",
//                      xtrigger_resume_in      => "{(DMXTRIGGER_MSB+1){1'b0}}",
//                      xtrigger_resume_out     => "nds_unused_xtrigger_resume_out",
//              });
//#             &IFDEF("PLATFORM_PLDM_SYS_BUS_ACCESS");
//              &CONNECT("u_pldm", {
//                      sys_araddr              => "dm_sup_araddr",
//                      sys_arburst             => "dm_sup_arburst",
//                      sys_arcache             => "dm_sup_arcache",
//                      sys_arid                => "dm_sup_arid",
//                      sys_arlen               => "dm_sup_arlen",
//                      sys_arlock              => "dm_sup_arlock",
//                      sys_arprot              => "dm_sup_arprot",
//                      sys_arready             => "dm_sup_arready",
//                      sys_arsize              => "dm_sup_arsize",
//                      sys_arvalid             => "dm_sup_arvalid",
//                      sys_awaddr              => "dm_sup_awaddr",
//                      sys_awburst             => "dm_sup_awburst",
//                      sys_awcache             => "dm_sup_awcache",
//                      sys_awid                => "dm_sup_awid",
//                      sys_awlen               => "dm_sup_awlen",
//                      sys_awlock              => "dm_sup_awlock",
//                      sys_awprot              => "dm_sup_awprot",
//                      sys_awready             => "dm_sup_awready",
//                      sys_awsize              => "dm_sup_awsize",
//                      sys_awvalid             => "dm_sup_awvalid",
//                      sys_bid                 => "dm_sup_bid",
//                      sys_bready              => "dm_sup_bready",
//                      sys_bresp               => "dm_sup_bresp",
//                      sys_bvalid              => "dm_sup_bvalid",
//                      sys_rdata               => "dm_sup_rdata",
//                      sys_rid                 => "dm_sup_rid",
//                      sys_rlast               => "dm_sup_rlast",
//                      sys_rready              => "dm_sup_rready",
//                      sys_rresp               => "dm_sup_rresp",
//                      sys_rvalid              => "dm_sup_rvalid",
//                      sys_wdata               => "dm_sup_wdata",
//                      sys_wlast               => "dm_sup_wlast",
//                      sys_wready              => "dm_sup_wready",
//                      sys_wstrb               => "dm_sup_wstrb",
//                      sys_wvalid              => "dm_sup_wvalid",
//                      xtrigger_halt_in        => "{(DMXTRIGGER_MSB+1){1'b0}}",
//                      xtrigger_halt_out       => "nds_unused_xtrigger_halt_out",
//                      xtrigger_resume_in      => "{(DMXTRIGGER_MSB+1){1'b0}}",
//                      xtrigger_resume_out     => "nds_unused_xtrigger_resume_out",
//              });
//
//                                      &FORCE("wire", "dm_sup_araddr[ADDR_MSB:0]");
//                                      &FORCE("wire", "dm_sup_arburst[1:0]");
//                                      &FORCE("wire", "dm_sup_arcache[3:0]");
//                                      &FORCE("wire", "dm_sup_arid[BIU_ID_MSB:0]");
//                                      &FORCE("wire", "dm_sup_arlen[7:0]");
//                                      &FORCE("wire", "dm_sup_arlock");
//                                      &FORCE("wire", "dm_sup_arprot[2:0]");
//                                      &FORCE("wire", "dm_sup_arready");
//                                      &FORCE("wire", "dm_sup_arsize[2:0]");
//                                      &FORCE("wire", "dm_sup_arvalid");
//
//                                      &FORCE("wire", "dm_sup_awaddr[ADDR_MSB:0]");
//                                      &FORCE("wire", "dm_sup_awburst[1:0]");
//                                      &FORCE("wire", "dm_sup_awcache[3:0]");
//                                      &FORCE("wire", "dm_sup_awid[BIU_ID_MSB:0]");
//                                      &FORCE("wire", "dm_sup_awlen[7:0]");
//                                      &FORCE("wire", "dm_sup_awlock");
//                                      &FORCE("wire", "dm_sup_awprot[2:0]");
//                                      &FORCE("wire", "dm_sup_awready");
//                                      &FORCE("wire", "dm_sup_awsize[2:0]");
//                                      &FORCE("wire", "dm_sup_awvalid");
//
//                                      &FORCE("wire", "dm_sup_wdata[DM_SYS_DATA_MSB:0]");
//                                      &FORCE("wire", "dm_sup_wstrb[DM_SYS_WSTRB_MSB:0]");
//                                      &FORCE("wire", "dm_sup_wlast");
//                                      &FORCE("wire", "dm_sup_wvalid");
//                                      &FORCE("wire", "dm_sup_wready");
//
//                                      &FORCE("wire", "dm_sup_bid[BIU_ID_MSB:0]");
//                                      &FORCE("wire", "dm_sup_bresp[1:0]");
//                                      &FORCE("wire", "dm_sup_bvalid");
//                                      &FORCE("wire", "dm_sup_bready");
//
//                                      &FORCE("wire", "dm_sup_rdata[DM_SYS_DATA_MSB:0]");
//                                      &FORCE("wire", "dm_sup_rresp[1:0]");
//                                      &FORCE("wire", "dm_sup_rlast");
//                                      &FORCE("wire", "dm_sup_rid[BIU_ID_MSB:0]");
//                                      &FORCE("wire", "dm_sup_rvalid");
//                                      &FORCE("wire", "dm_sup_rready");
//
//
//              &GENERATE_IF("(BIU_DATA_WIDTH > DM_SYS_DATA_WIDTH)", "gen_axi_dm_sup");
//                      &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcsizeup300/hdl/atcsizeup300.v", "u_axi_dm_sup", {
//                  ID_WIDTH         =>     "BIU_ID_WIDTH",
//                              US_DATA_WIDTH    =>     "DM_SYS_DATA_WIDTH",
//                              DS_DATA_WIDTH    =>     "SIZEUP_DS_DATA_WIDTH"
//                      });
//                      &CONNECT("u_axi_dm_sup",{
//                              aclk            =>      "aclk",
//                              aresetn         =>      "aresetn",
//
//                              us_arvalid      =>      "dm_sup_arvalid",
//                              us_arready      =>      "dm_sup_arready",
//                              ds_arvalid      =>      "dm_sys_arvalid",
//                              ds_arready      =>      "dm_sys_arready",
//
//                              us_awvalid      =>      "dm_sup_awvalid",
//                              us_awready      =>      "dm_sup_awready",
//                              ds_awvalid      =>      "dm_sys_awvalid",
//                              ds_awready      =>      "dm_sys_awready",
//
//                              us_rid          =>      "dm_sup_rid",
//                              us_rvalid       =>      "dm_sup_rvalid",
//                              us_rdata        =>      "dm_sup_rdata",
//                              us_rready       =>      "dm_sup_rready",
//                              ds_rlast        =>      "dm_sys_rlast",
//                              ds_rvalid       =>      "dm_sys_rvalid",
//                              ds_rdata        =>      "dm_sys_rdata",
//                              ds_rready       =>      "dm_sys_rready",
//
//                              us_wstrb        =>      "dm_sup_wstrb",
//                              us_wlast        =>      "dm_sup_wlast",
//                              us_wvalid       =>      "dm_sup_wvalid",
//                              us_wdata        =>      "dm_sup_wdata",
//                              us_wready       =>      "dm_sup_wready",
//
//                              ds_wstrb        =>      "dm_sys_wstrb",
//                              ds_wvalid       =>      "dm_sys_wvalid",
//                              ds_wdata        =>      "dm_sys_wdata",
//                              ds_wready       =>      "dm_sys_wready",
//
//                              us_bid          =>      "dm_sup_bid",
//                              us_bvalid       =>      "dm_sup_bvalid",
//                              us_bready       =>      "dm_sup_bready",
//
//                              ds_bvalid       =>      "dm_sys_bvalid",
//                              ds_bready       =>      "dm_sys_bready",
//
//                              us_arid         =>      "dm_sup_arid",
//                              us_araddr       =>      "dm_sup_araddr[SIZEUP_ADDR_MSB:0]",
//                              us_arburst      =>      "dm_sup_arburst",
//                              us_arlen        =>      "dm_sup_arlen[3:0]",
//                              us_arsize       =>      "dm_sup_arsize",
//
//                              us_awid         =>      "dm_sup_awid",
//                              us_awaddr       =>      "dm_sup_awaddr[SIZEUP_ADDR_MSB:0]",
//                              us_awburst      =>      "dm_sup_awburst",
//                              us_awlen        =>      "dm_sup_awlen[3:0]",
//                              us_awsize       =>      "dm_sup_awsize",
//
//                              ds_wlast        =>      "dm_sys_wlast",
//                              us_rlast        =>      "dm_sup_rlast",
//                              us_rresp        =>      "dm_sup_rresp",
//                              ds_rresp        =>      "dm_sys_rresp",
//                              });
//              &ENDGENERATE();
//#             &ENDIF("PLATFORM_PLDM_SYS_BUS_ACCESS");
//              :`ifdef PLATFORM_DEBUG_SUBSYSTEM
//              :       generate
//              :       if (BIU_DATA_WIDTH > DM_SYS_DATA_WIDTH) begin : gen_connect_axi_dm_sup
//              :               assign dm_sys_araddr          = dm_sup_araddr;
//              :               assign dm_sys_arburst         = dm_sup_arburst;
//              :               assign dm_sys_arcache         = dm_sup_arcache;
//              :               assign dm_sys_arid            = {BIU_ID_WIDTH{1'b0}};
//              :               assign dm_sys_arlen           = dm_sup_arlen;
//              :               assign dm_sys_arlock          = dm_sup_arlock;
//              :               assign dm_sys_arprot          = dm_sup_arprot;
//              :               assign dm_sys_arsize          = dm_sup_arsize;
//              :
//              :               assign dm_sys_awaddr          = dm_sup_awaddr;
//              :               assign dm_sys_awburst         = dm_sup_awburst;
//              :               assign dm_sys_awcache         = dm_sup_awcache;
//              :               assign dm_sys_awid            = {BIU_ID_WIDTH{1'b0}};
//              :               assign dm_sys_awlen           = dm_sup_awlen;
//              :               assign dm_sys_awlock          = dm_sup_awlock;
//              :               assign dm_sys_awprot          = dm_sup_awprot;
//              :               assign dm_sys_awsize          = dm_sup_awsize;
//              :
//              :               assign dm_sup_bresp           = dm_sys_bresp;
//              :       end
//              :       else begin : gen_connect_axi_dm
//              :               assign dm_sup_arready         = dm_sys_arready;
//              :               assign dm_sup_awready         = dm_sys_awready;
//              :               assign dm_sup_rvalid          = dm_sys_rvalid;
//              :               assign dm_sup_rdata           = dm_sys_rdata;
//              :               assign dm_sup_rid             = dm_sys_rid;
//              :               assign dm_sup_rlast           = dm_sys_rlast;
//              :               assign dm_sup_rresp           = dm_sys_rresp;
//              :               assign dm_sup_wready          = dm_sys_wready;
//              :               assign dm_sup_bvalid          = dm_sys_bvalid;
//              :               assign dm_sup_bid             = dm_sys_bid;
//              :               assign dm_sup_bresp           = dm_sys_bresp;
//              :
//              :               assign dm_sys_araddr          = dm_sup_araddr;
//              :               assign dm_sys_arburst         = dm_sup_arburst;
//              :               assign dm_sys_arcache         = dm_sup_arcache;
//              :               assign dm_sys_arid            = dm_sup_arid;
//              :               assign dm_sys_arlen           = dm_sup_arlen;
//              :               assign dm_sys_arlock          = dm_sup_arlock;
//              :               assign dm_sys_arprot          = dm_sup_arprot;
//              :               assign dm_sys_arsize          = dm_sup_arsize;
//              :               assign dm_sys_arvalid         = dm_sup_arvalid;
//              :
//              :               assign dm_sys_awaddr          = dm_sup_awaddr;
//              :               assign dm_sys_awburst         = dm_sup_awburst;
//              :               assign dm_sys_awcache         = dm_sup_awcache;
//              :               assign dm_sys_awid            = dm_sup_awid;
//              :               assign dm_sys_awlen           = dm_sup_awlen;
//              :               assign dm_sys_awlock          = dm_sup_awlock;
//              :               assign dm_sys_awprot          = dm_sup_awprot;
//              :               assign dm_sys_awsize          = dm_sup_awsize;
//              :               assign dm_sys_awvalid         = dm_sup_awvalid;
//              :
//              :               assign dm_sys_rready          = dm_sup_rready;
//              :               assign dm_sys_wdata           = dm_sup_wdata;
//              :               assign dm_sys_wlast           = dm_sup_wlast;
//              :               assign dm_sys_wstrb           = dm_sup_wstrb;
//              :               assign dm_sys_wvalid          = dm_sup_wvalid;
//              :               assign dm_sys_bready          = dm_sup_bready;
//              :       end
//              :       endgenerate
//              :       `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
//              :       `else
//              :               // force assign constant if no system debug access support
//              :               assign dm_sys_arready   = 1'b1;
//              :               assign dm_sys_awready   = 1'b1;
//              :               assign dm_sys_rvalid    = 1'b0;
//              :               assign dm_sys_rdata     = {BIU_DATA_WIDTH{1'b0}};
//              :               assign dm_sys_rid       = {BIU_ID_WIDTH{1'b0}};
//              :               assign dm_sys_rlast     = 1'b0;
//              :               assign dm_sys_rresp     = 2'b0;
//              :               assign dm_sys_wready    = 1'b1;
//              :               assign dm_sys_bvalid    = 1'b0;
//              :               assign dm_sys_bid       = {BIU_ID_WIDTH{1'b0}};
//              :               assign dm_sys_bresp     = 2'b0;
//              :       `endif
//              :`endif
// &ENDIF("PLATFORM_DEBUG_SUBSYSTEM");
//
// &DANGLER("dm_hsel");
// &DANGLER("dm_htrans");
// &DANGLER("dm_haddr");
// &DANGLER("dm_hsize");
// &DANGLER("dm_hburst");
// &DANGLER("dm_hwrite");
// &DANGLER("dm_hwdata");
// &DANGLER("dm_hready");
// &DANGLER("dm_hreadyout");
// &DANGLER("dm_hrdata");
// &DANGLER("dm_hresp");
//
// &DANGLER(dm_arready);
// &DANGLER(dm_awready);
// &DANGLER(dm_bresp);
// &DANGLER(dm_bvalid);
// &DANGLER(dm_rdata);
// &DANGLER(dm_rlast);
// &DANGLER(dm_rresp);
// &DANGLER(dm_rvalid);
// &DANGLER(dm_wready);
// &DANGLER(dm_arvalid);
// &DANGLER(dm_awvalid);
// &DANGLER(dm_wvalid);
// &DANGLER(dm_rready);
// &DANGLER(dm_bready);
// &DANGLER("nds_unused_xtrigger_halt_out");
// &DANGLER("nds_unused_xtrigger_resume_out");
//:
//# Debug subsystem <-> Core
//:`ifdef PLATFORM_DEBUG_SUBSYSTEM
//:`else  // PLATFORM_DEBUG_SUBSYSTEM
//:    assign dm_debugint     = {NHART{1'b0}};
//:    assign dm_resethaltreq = {NHART{1'b0}};
//:`endif // PLATFORM_DEBUG_SUBSYSTEM
//:
//# Debug subsystem <-> I/O
//:`ifdef PLATFORM_DEBUG_SUBSYSTEM
//:    assign dbg_srst_req = ndmreset;
//:`else // PLATFORM_DEBUG_SUBSYSTEM
//:    assign dbg_srst_req = 1'b0;
//:`endif // PLATFORM_DEBUG_SUBSYSTEM
//
// #------------------------------------------------------------------------------
// # PLIC
// #------------------------------------------------------------------------------
// $plic = $AXI_SLV_PLIC;
// $plic = $AHB_SLV_PLIC;
//      &INSTANCE("$PVC_LOCALDIR/andes_ip/soc/nceplic100/hdl/nceplic100.v", "u_plic", {
//              INT_NUM               => "31",
//            TARGET_NUM              => "PLIC_HW_TARGET_NUM[5:0]",
//            MAX_PRIORITY            => "3",
//            EDGE_TRIGGER            => "1024'h0",
//            ASYNC_INT               => "1024'hc000000",
//              ADDR_WIDTH            => ADDR_WIDTH,
//              DATA_WIDTH            => NCE_DATA_WIDTH,
//            VECTOR_PLIC_SUPPORT     => "VECTOR_PLIC_SUPPORT",
//              SYNC_STAGE            => "SYNC_STAGE",
//            PLIC_BUS     => "\"axi\""
//      });
//      &CONNECT("u_plic",{
//      ### AXI
//              araddr                  => "plic_araddr",
//              arburst                 => "plic_arburst",
//              arcache                 => "plic_arcache",
//              arid                    => "4'd0",
//              arlen                   => "plic_arlen",
//              arlock                  => "plic_arlock",
//              arprot                  => "plic_arprot",
//              arready                 => "plic_arready",
//              arsize                  => "plic_arsize",
//              arvalid                 => "plic_arvalid",
//              awaddr                  => "plic_awaddr",
//              awburst                 => "plic_awburst",
//              awcache                 => "plic_awcache",
//              awid                    => "4'd0",
//              awlen                   => "plic_awlen",
//              awlock                  => "plic_awlock",
//              awprot                  => "plic_awprot",
//              awready                 => "plic_awready",
//              awsize                  => "plic_awsize",
//              awvalid                 => "plic_awvalid",
//              bid                     => "nds_unused_plic_bid",
//              bready                  => "plic_bready",
//              bresp                   => "plic_bresp",
//              bvalid                  => "plic_bvalid",
//              rdata                   => "plic_rdata",
//              rid                     => "nds_unused_plic_rid",
//              rlast                   => "plic_rlast",
//              rready                  => "plic_rready",
//              rresp                   => "plic_rresp",
//              rvalid                  => "plic_rvalid",
//              wdata                   => "plic_wdata",
//              wlast                   => "plic_wlast",
//              wready                  => "plic_wready",
//              wstrb                   => "plic_wstrb",
//              wvalid                  => "plic_wvalid",
//      # AHB
//              haddr                   => "{ADDR_WIDTH{1'b0}}",
//              hburst                  => "3'd0",
//              hready                  => "1'b0",
//              hsel                    => "1'b0",
//              hsize                   => "3'd0",
//              htrans                  => "2'd0",
//              hwdata                  => "{NCE_DATA_WIDTH{1'b0}}",
//              hwrite                  => "1'b0",
//              hreadyout               => "nds_unused_plic_hreadyout",
//              hresp                   => "nds_unused_plic_hresp",
//              hrdata                  => "nds_unused_plic_hrdata",
//
//              clk                     => "aclk",
//              reset_n                 => "aresetn",
//              int_src                 => "int_src",
//              t0_eip                  => "hart0_meip",
//              t0_eiid                 => "hart0_meiid",
//              t0_eiack                => "hart0_meiack",
//              t1_eip                  => "hart0_seip",
//              t1_eiid                 => "hart0_seiid",
//              t1_eiack                => "hart0_seiack",
//              t2_eip                  => "hart1_meip",
//              t2_eiid                 => "hart1_meiid",
//              t2_eiack                => "hart1_meiack",
//              t3_eip                  => "hart1_seip",
//              t3_eiid                 => "hart1_seiid",
//              t3_eiack                => "hart1_seiack",
//      });
//      foreach (4..15) {
//		&CONNECT("u_plic.t${_}_eip", "nds_unused_plic_t${_}_eip");
//		&CONNECT("u_plic.t${_}_eiid", "nds_unused_plic_t${_}_eiid");
//		&CONNECT("u_plic.t${_}_eiack", "1'b0");
//		&DANGLER("nds_unused_plic_t${_}_eip");
//		&DANGLER("nds_unused_plic_t${_}_eiid");
//
//      }
// :
// #------------------------------------------------------------------------------
// # PLIC_SW
// #------------------------------------------------------------------------------
// :`ifdef PLATFORM_NO_PLIC_SW
// :    assign hart0_msip = 1'b0;
// :    assign hart1_msip = 1'b0;
// :`endif      // PLATFORM_NO_PLIC_SW
//
//&IFDEF("PLATFORM_NO_PLIC_SW");
//&ELSE("PLATFORM_NO_PLIC_SW");
//      &INSTANCE("$PVC_LOCALDIR/andes_ip/soc/nceplic100/hdl/nceplic100.v", "u_plic_sw", {
//            INT_NUM                 => "16",
//            TARGET_NUM              => "PLIC_SW_TARGET_NUM[5:0]",
//            MAX_PRIORITY            => "3",
//            EDGE_TRIGGER            => "1024'd0",
//              ADDR_WIDTH              => ADDR_WIDTH,
//              DATA_WIDTH              => NCE_DATA_WIDTH,
//            VECTOR_PLIC_SUPPORT     => "\"no\"",
//            PLIC_BUS                  => "\"axi\"",
//      });
//      &CONNECT("u_plic_sw",{
//      ### AXI
//              araddr                  => "plicsw_araddr",
//              arburst                 => "plicsw_arburst",
//              arcache                 => "plicsw_arcache",
//              arid                    => "4'd0",
//              arlen                   => "plicsw_arlen",
//              arlock                  => "plicsw_arlock",
//              arprot                  => "plicsw_arprot",
//              arready                 => "plicsw_arready",
//              arsize                  => "plicsw_arsize",
//              arvalid                 => "plicsw_arvalid",
//              awaddr                  => "plicsw_awaddr",
//              awburst                 => "plicsw_awburst",
//              awcache                 => "plicsw_awcache",
//              awid                    => "4'd0",
//              awlen                   => "plicsw_awlen",
//              awlock                  => "plicsw_awlock",
//              awprot                  => "plicsw_awprot",
//              awready                 => "plicsw_awready",
//              awsize                  => "plicsw_awsize",
//              awvalid                 => "plicsw_awvalid",
//              bid                     => "nds_unused_plicsw_bid",
//              bready                  => "plicsw_bready",
//              bresp                   => "plicsw_bresp",
//              bvalid                  => "plicsw_bvalid",
//              rdata                   => "plicsw_rdata",
//              rid                     => "nds_unused_plicsw_rid",
//              rlast                   => "plicsw_rlast",
//              rready                  => "plicsw_rready",
//              rresp                   => "plicsw_rresp",
//              rvalid                  => "plicsw_rvalid",
//              wdata                   => "plicsw_wdata",
//              wlast                   => "plicsw_wlast",
//              wready                  => "plicsw_wready",
//              wstrb                   => "plicsw_wstrb",
//              wvalid                  => "plicsw_wvalid",
//      # AHB
//              haddr                   => "{ADDR_WIDTH{1'b0}}",
//              hburst                  => "3'd0",
//              hready                  => "1'b0",
//              hsel                    => "1'b0",
//              hsize                   => "3'd0",
//              htrans                  => "2'd0",
//              hwdata                  => "{NCE_DATA_WIDTH{1'b0}}",
//              hwrite                  => "1'b0",
//              hreadyout               => "nds_unused_plicsw_hreadyout",
//              hresp                   => "nds_unused_plicsw_hresp",
//              hrdata                  => "nds_unused_plicsw_hrdata",
//
//              clk                     => "aclk",
//              reset_n                 => "aresetn",
//              int_src                 => "16'd0",
//              t0_eip                  => "hart0_msip",
//              t0_eiid                 => "nds_unused_plicsw_t0_eiid",
//              t0_eiack                => "1'b0",
//              t1_eip                  => "hart1_msip",
//              t1_eiid                 => "nds_unused_plicsw_t1_eiid",
//              t1_eiack                => "1'b0",
//              t2_eip                  => "nds_unused_plicsw_t2_eip",
//              t2_eiid                 => "nds_unused_plicsw_t2_eiid",
//              t2_eiack                => "1'b0",
//              t3_eip                  => "nds_unused_plicsw_t3_eip",
//              t3_eiid                 => "nds_unused_plicsw_t3_eiid",
//              t3_eiack                => "1'b0",
//              t4_eip                  => "nds_unused_plicsw_t4_eip",
//              t4_eiid                 => "nds_unused_plicsw_t4_eiid",
//              t4_eiack                => "1'b0",
//              t5_eip                  => "nds_unused_plicsw_t5_eip",
//              t5_eiid                 => "nds_unused_plicsw_t5_eiid",
//              t5_eiack                => "1'b0",
//              t6_eip                  => "nds_unused_plicsw_t6_eip",
//              t6_eiid                 => "nds_unused_plicsw_t6_eiid",
//              t6_eiack                => "1'b0",
//              t7_eip                  => "nds_unused_plicsw_t7_eip",
//              t7_eiid                 => "nds_unused_plicsw_t7_eiid",
//              t7_eiack                => "1'b0",
//              t8_eip                  => "nds_unused_plicsw_t8_eip",
//              t8_eiid                 => "nds_unused_plicsw_t8_eiid",
//              t8_eiack                => "1'b0",
//              t9_eip                  => "nds_unused_plicsw_t9_eip",
//              t9_eiid                 => "nds_unused_plicsw_t9_eiid",
//              t9_eiack                => "1'b0",
//              t10_eip                 => "nds_unused_plicsw_t10_eip",
//              t10_eiid                => "nds_unused_plicsw_t10_eiid",
//              t10_eiack               => "1'b0",
//              t11_eip                 => "nds_unused_plicsw_t11_eip",
//              t11_eiid                => "nds_unused_plicsw_t11_eiid",
//              t11_eiack               => "1'b0",
//              t12_eip                 => "nds_unused_plicsw_t12_eip",
//              t12_eiid                => "nds_unused_plicsw_t12_eiid",
//              t12_eiack               => "1'b0",
//              t13_eip                 => "nds_unused_plicsw_t13_eip",
//              t13_eiid                => "nds_unused_plicsw_t13_eiid",
//              t13_eiack               => "1'b0",
//              t14_eip                 => "nds_unused_plicsw_t14_eip",
//              t14_eiid                => "nds_unused_plicsw_t14_eiid",
//              t14_eiack               => "1'b0",
//              t15_eip                 => "nds_unused_plicsw_t15_eip",
//              t15_eiid                => "nds_unused_plicsw_t15_eiid",
//              t15_eiack               => "1'b0",
//
//      });
//&ENDIF("NDS_NO_PLIC_SW");
//
//#################################################################################################################
//# PPI
//#################################################################################################################
//&IFDEF("NDS_IO_PPI");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/top/hdl/sample_axi_regfile.v", "u_core0_axi_rf", {
//	DATA_WIDTH		=> "PPI_DATA_WIDTH",
//      ADDR_WIDTH		=> "ADDR_WIDTH",
//      ID_WIDTH		=> "PPI_ID_WIDTH",
//});
//
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/top/hdl/sample_axi_regfile.v", "u_core1_axi_rf", {
//	DATA_WIDTH		=> "PPI_DATA_WIDTH",
//      ADDR_WIDTH		=> "ADDR_WIDTH",
//      ID_WIDTH		=> "PPI_ID_WIDTH",
//});
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_PPI");
//
//
//&IFDEF("NDS_IO_PPI_PROT");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/top/hdl/nds_scpu_bus_ingress.v", "u_core0_ppi_ingress", {
//	ID_WIDTH	=> "PPI_ID_WIDTH",
//	DATA_WIDTH	=> "PPI_DATA_WIDTH",
//	DS_ADDR_WIDTH	=> "ADDR_WIDTH",
//	US_ADDR_WIDTH	=> "BIU_ADDR_WIDTH",
//	DATA_CODE_WIDTH	=> "PPI_DATA_CODE_WIDTH",
//	ADDR_CODE_WIDTH	=> "BIU_ADDR_CODE_WIDTH",
//	UTID_WIDTH	=> "BIU_UTID_WIDTH",
//	WCTRL_CODE_WIDTH => "5",
//	BIU_CTRL_CODE_WIDTH => "BIU_CTRL_CODE_WIDTH",
//});
//&DANGLER("nds_unused_ppi0_event_ctl_err");
//&DANGLER("nds_unused_ppi0_event_data_err");
//&DANGLER("nds_unused_ppi0_event_handshake_err");
//&DANGLER("nds_unused_ppi0_event_eobi_err");
//
//&IFDEF("NDS_IO_DCLS_SPLIT");
//&INSTANCE("$PVC_LOCALDIR/andes_ip/kv_core/top/hdl/nds_scpu_bus_ingress.v", "u_core1_ppi_ingress", {
//	ID_WIDTH	=> "PPI_ID_WIDTH",
//	DATA_WIDTH	=> "PPI_DATA_WIDTH",
//	DS_ADDR_WIDTH	=> "ADDR_WIDTH",
//	US_ADDR_WIDTH	=> "BIU_ADDR_WIDTH",
//	DATA_CODE_WIDTH	=> "PPI_DATA_CODE_WIDTH",
//	ADDR_CODE_WIDTH	=> "BIU_ADDR_CODE_WIDTH",
//	UTID_WIDTH	=> "BIU_UTID_WIDTH",
//	WCTRL_CODE_WIDTH => "5",
//	BIU_CTRL_CODE_WIDTH => "BIU_CTRL_CODE_WIDTH",
//});
//&DANGLER("nds_unused_ppi1_event_ctl_err");
//&DANGLER("nds_unused_ppi1_event_data_err");
//&DANGLER("nds_unused_ppi1_event_handshake_err");
//&DANGLER("nds_unused_ppi1_event_eobi_err");
//&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_PPI_PROT");
//
//&IFDEF("NDS_IO_PPI");
//	&KV_AXI4_DECLARE_WIRE("core0_ppi_",            "`NDS_BIU_ADDR_WIDTH", "`NDS_PPI_DATA_WIDTH", "`NDS_PPI_ID_WIDTH");
//	&KV_AXI4_DECLARE_WIRE("core0_axi_rf_",         "`NDS_BIU_ADDR_WIDTH", "`NDS_PPI_DATA_WIDTH", "`NDS_PPI_ID_WIDTH");
//	&IFDEF("NDS_IO_DCLS_SPLIT");
//	&KV_AXI4_DECLARE_WIRE("core1_ppi_",            "`NDS_BIU_ADDR_WIDTH", "`NDS_PPI_DATA_WIDTH", "`NDS_PPI_ID_WIDTH");
//	&KV_AXI4_DECLARE_WIRE("core1_axi_rf_",         "`NDS_BIU_ADDR_WIDTH", "`NDS_PPI_DATA_WIDTH", "`NDS_PPI_ID_WIDTH");
//	&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_PPI");
//
//&IFDEF("NDS_IO_PPI_PROT");
//	my $arcw = 5;
//	my $awcw = 5;
//	my $wcw = 5;
//	my $rcw = 3;
//	my $bcw = 3;
//
//	&KV_AXI4_PROT_DECLARE_WIRE("core0_ppi_",            "`NDS_BIU_ADDR_CODE_WIDTH", "`NDS_PPI_DATA_CODE_WIDTH", "5", $arcw, $awcw, $wcw, $rcw, $bcw, "`NDS_BIU_UTID_WIDTH");
//	&KV_AXI4_PROT_DECLARE_WIRE("core0_ppi_ingress_us_", "`NDS_BIU_ADDR_CODE_WIDTH", "`NDS_PPI_DATA_CODE_WIDTH", "5", $arcw, $awcw, $wcw, $rcw, $bcw, "`NDS_BIU_UTID_WIDTH");
//
//	&KV_AXI4_DECLARE_WIRE("core0_ppi_ingress_us_", "`NDS_BIU_ADDR_WIDTH", "`NDS_PPI_DATA_WIDTH", "`NDS_PPI_ID_WIDTH");
//	&KV_AXI4_DECLARE_WIRE("core0_ppi_ingress_ds_", "`NDS_BIU_ADDR_WIDTH", "`NDS_PPI_DATA_WIDTH", "`NDS_PPI_ID_WIDTH");
//	&IFDEF("NDS_IO_DCLS_SPLIT");
//	&KV_AXI4_PROT_DECLARE_WIRE("core1_ppi_",            "`NDS_BIU_ADDR_CODE_WIDTH", "`NDS_PPI_DATA_CODE_WIDTH", "5", $arcw, $awcw, $wcw, $rcw, $bcw, "`NDS_BIU_UTID_WIDTH");
//	&KV_AXI4_PROT_DECLARE_WIRE("core1_ppi_ingress_us_", "`NDS_BIU_ADDR_CODE_WIDTH", "`NDS_PPI_DATA_CODE_WIDTH", "5", $arcw, $awcw, $wcw, $rcw, $bcw, "`NDS_BIU_UTID_WIDTH");
//
//	&KV_AXI4_DECLARE_WIRE("core1_ppi_ingress_us_", "`NDS_BIU_ADDR_WIDTH", "`NDS_PPI_DATA_WIDTH", "`NDS_PPI_ID_WIDTH");
//	&KV_AXI4_DECLARE_WIRE("core1_ppi_ingress_ds_", "`NDS_BIU_ADDR_WIDTH", "`NDS_PPI_DATA_WIDTH", "`NDS_PPI_ID_WIDTH");
//	&ENDIF("NDS_IO_DCLS_SPLIT");
//&ENDIF("NDS_IO_PPI_PROT");
//
//&KV_AXI4_CONNECT_PORT("u_cluster",           "core0_ppi_", "core0_ppi_");
//&KV_AXI4_CONNECT_PORT("u_core0_ppi_ingress", "us_",        "core0_ppi_ingress_us_");
//&KV_AXI4_CONNECT_PORT("u_core0_ppi_ingress", "ds_",        "core0_ppi_ingress_ds_");
//&KV_AXI4_CONNECT_PORT("u_core0_axi_rf",      "",           "core0_axi_rf_");
//
//&KV_AXI4_PROT_CONNECT_PORT("u_cluster",           "core0_ppi_", "core0_ppi_");
//&KV_AXI4_PROT_CONNECT_PORT("u_core0_ppi_ingress", "us_",        "core0_ppi_ingress_us_");
//&CONNECT("u_core0_ppi_ingress.event_ctl_err", "nds_unused_ppi0_event_ctl_err");
//&CONNECT("u_core0_ppi_ingress.event_data_err", "nds_unused_ppi0_event_data_err");
//&CONNECT("u_core0_ppi_ingress.event_handshake_err", "nds_unused_ppi0_event_handshake_err");
//&CONNECT("u_core0_ppi_ingress.event_eobi_err", "nds_unused_ppi0_event_eobi_err");
//
//&IFDEF("NDS_IO_DCLS_SPLIT");
//	&KV_AXI4_CONNECT_PORT("u_cluster",           "core1_ppi_", "core1_ppi_");
//	&KV_AXI4_CONNECT_PORT("u_core1_ppi_ingress", "us_",        "core1_ppi_ingress_us_");
//	&KV_AXI4_CONNECT_PORT("u_core1_ppi_ingress", "ds_",        "core1_ppi_ingress_ds_");
//	&KV_AXI4_CONNECT_PORT("u_core1_axi_rf",      "",           "core1_axi_rf_");
//
//	&KV_AXI4_PROT_CONNECT_PORT("u_cluster",           "core1_ppi_", "core1_ppi_");
//	&KV_AXI4_PROT_CONNECT_PORT("u_core1_ppi_ingress", "us_",        "core1_ppi_ingress_us_");
//	&CONNECT("u_core1_ppi_ingress.event_ctl_err", "nds_unused_ppi1_event_ctl_err");
//	&CONNECT("u_core1_ppi_ingress.event_data_err", "nds_unused_ppi1_event_data_err");
//	&CONNECT("u_core1_ppi_ingress.event_handshake_err", "nds_unused_ppi1_event_handshake_err");
//	&CONNECT("u_core1_ppi_ingress.event_eobi_err", "nds_unused_ppi1_event_eobi_err");
//
//&ENDIF("NDS_IO_DCLS_SPLIT");
//
//
//:`ifdef NDS_IO_PPI
//:`ifdef NDS_IO_PPI_PROT
//	&KV_AXI4_ASSIGN("core0_ppi_",            "core0_ppi_ingress_us_");
//	&KV_AXI4_ASSIGN("core0_ppi_ingress_ds_", "core0_axi_rf_");
//	&KV_AXI4_PROT_ASSIGN("core0_ppi_",            "core0_ppi_ingress_us_");
//:`else // NDS_IO_PPI_PROT
//	&KV_AXI4_ASSIGN("core0_ppi_", "core0_axi_rf_");
//:`endif // NDS_IO_PPI_PROT 
//:`endif // NDS_IO_PPI
//
//:`ifdef NDS_IO_DCLS 
//:`ifdef NDS_IO_DCLS_SPLIT 
//:`ifdef NDS_IO_PPI
//:`ifdef NDS_IO_PPI_PROT
//	&KV_AXI4_ASSIGN("core1_ppi_",            "core1_ppi_ingress_us_");
//	&KV_AXI4_ASSIGN("core1_ppi_ingress_ds_", "core1_axi_rf_");
//	&KV_AXI4_PROT_ASSIGN("core1_ppi_",            "core1_ppi_ingress_us_");
//:`else // NDS_IO_PPI_PROT
//	&KV_AXI4_ASSIGN("core1_ppi_", "core1_axi_rf_");
//:`endif // NDS_IO_PPI_PROT 
//:`endif // NDS_IO_PPI
//:`endif // NDS_IO_DCLS 
//:`endif // NDS_IO_DCLS_SPLIT 
//
//for (my $core=0; $core<2; $core++) {
//	&CONNECT("u_cluster.core${core}_ppi_aclk_en", "1'b1");
//}
//
//#=====================================
//#           CONNECT
//#=====================================
//for (my $i = 0; $i < 2; $i++) {
//    printf("`ifdef NDS_IO_HART${i}\n") if(${i});
//    :`ifdef NDS_IO_DEBUG
//    :    assign dm_hart_unavail[${i}]        = core${i}_hart_unavail;
//    :    assign dm_hart_under_reset[${i}]    = core${i}_hart_under_reset;
//    :`else// !NDS_IO_DEBUG
//    :    assign dm_hart_unavail[${i}]        = 1'b0;
//    :    assign dm_hart_under_reset[${i}]    = 1'b0;
//    :`endif// !NDS_IO_DEBUG
//    printf("`endif //NDS_IO_HART${i}\n") if(${i});
//    :
//}
//
// #------------------------------------------------------------------------------
// # RAM ctrl signals
// #------------------------------------------------------------------------------
//
// &DANGLER("nds_unused_u_axi_bmc_ds3_araddr");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arburst");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arcache");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arid");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arlen");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arlock");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arprot");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arsize");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arvalid");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awaddr");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awburst");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awcache");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awid");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awlen");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awlock");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awprot");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awsize");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awvalid");
// &DANGLER("nds_unused_u_axi_bmc_ds3_bready");
// &DANGLER("nds_unused_u_axi_bmc_ds3_rready");
// &DANGLER("nds_unused_u_axi_bmc_ds3_wdata");
// &DANGLER("nds_unused_u_axi_bmc_ds3_wlast");
// &DANGLER("nds_unused_u_axi_bmc_ds3_wstrb");
// &DANGLER("nds_unused_u_axi_bmc_ds3_wvalid");
// &DANGLER("nds_unused_u_axi_bmc_us1_arready");
// &DANGLER("nds_unused_u_axi_bmc_us1_awready");
// &DANGLER("nds_unused_u_axi_bmc_us1_bid");
// &DANGLER("nds_unused_u_axi_bmc_us1_bresp");
// &DANGLER("nds_unused_u_axi_bmc_us1_bvalid");
// &DANGLER("nds_unused_u_axi_bmc_us1_rdata");
// &DANGLER("nds_unused_u_axi_bmc_us1_rid");
// &DANGLER("nds_unused_u_axi_bmc_us1_rlast");
// &DANGLER("nds_unused_u_axi_bmc_us1_rresp");
// &DANGLER("nds_unused_u_axi_bmc_us1_rvalid");
// &DANGLER("nds_unused_u_axi_bmc_us1_wready");
// &DANGLER("nds_unused_dm_bid");
// &DANGLER("nds_unused_dm_hrdata");
// &DANGLER("nds_unused_dm_hreadyout");
// &DANGLER("nds_unused_dm_hresp");
// &DANGLER("nds_unused_dm_rid");
// &DANGLER("nds_unused_dm_sup_haddr");
// &DANGLER("nds_unused_dm_sup_hburst");
// &DANGLER("nds_unused_dm_sup_hbusreq");
// &DANGLER("nds_unused_dm_sup_hprot");
// &DANGLER("nds_unused_dm_sup_hsize");
// &DANGLER("nds_unused_dm_sup_htrans");
// &DANGLER("nds_unused_dm_sup_hwdata");
// &DANGLER("nds_unused_dm_sup_hwrite");
// for(0..7){
//     &DANGLER("nds_unused_core${_}_slv1_arready");
//     &DANGLER("nds_unused_core${_}_slv1_awready");
//     &DANGLER("nds_unused_core${_}_slv1_bid");
//     &DANGLER("nds_unused_core${_}_slv1_bresp");
//     &DANGLER("nds_unused_core${_}_slv1_bvalid");
//     &DANGLER("nds_unused_core${_}_slv1_rdata");
//     &DANGLER("nds_unused_core${_}_slv1_rid");
//     &DANGLER("nds_unused_core${_}_slv1_rlast");
//     &DANGLER("nds_unused_core${_}_slv1_rresp");
//     &DANGLER("nds_unused_core${_}_slv1_rvalid");
//     &DANGLER("nds_unused_core${_}_slv1_wready");
//     &DANGLER("nds_unused_hart${_}_ueiack");
//     &DANGLER("nds_unused_core${_}_fs_bus_s1_protection_error");
//     &DANGLER("nds_unused_core${_}_slv1_arreadycode");
//     &DANGLER("nds_unused_core${_}_slv1_awreadycode");
//     &DANGLER("nds_unused_core${_}_slv1_bctlcode");
//     &DANGLER("nds_unused_core${_}_slv1_bidcode");
//     &DANGLER("nds_unused_core${_}_slv1_butid");
//     &DANGLER("nds_unused_core${_}_slv1_bvalidcode");
//     &DANGLER("nds_unused_core${_}_slv1_rctlcode");
//     &DANGLER("nds_unused_core${_}_slv1_rdatacode");
//     &DANGLER("nds_unused_core${_}_slv1_reobi");
//     &DANGLER("nds_unused_core${_}_slv1_ridcode");
//     &DANGLER("nds_unused_core${_}_slv1_rutid");
//     &DANGLER("nds_unused_core${_}_slv1_rvalidcode");
//     &DANGLER("nds_unused_core${_}_slv1_wreadycode");
// }
// for(4..7){
//     &DANGLER("nds_unused_core${_}_slv_arready");
//     &DANGLER("nds_unused_core${_}_slv_awready");
//     &DANGLER("nds_unused_core${_}_slv_bid");
//     &DANGLER("nds_unused_core${_}_slv_bresp");
//     &DANGLER("nds_unused_core${_}_slv_bvalid");
//     &DANGLER("nds_unused_core${_}_slv_rdata");
//     &DANGLER("nds_unused_core${_}_slv_rid");
//     &DANGLER("nds_unused_core${_}_slv_rlast");
//     &DANGLER("nds_unused_core${_}_slv_rresp");
//     &DANGLER("nds_unused_core${_}_slv_rvalid");
//     &DANGLER("nds_unused_core${_}_slv_wready");
// }
// &DANGLER("nds_unused_plicsw_bid");
// &DANGLER("nds_unused_plicsw_hrdata");
// &DANGLER("nds_unused_plicsw_hreadyout");
// &DANGLER("nds_unused_plicsw_hresp");
// &DANGLER("nds_unused_plicsw_rid");
// &DANGLER("nds_unused_plicsw_t0_eiid");
// &DANGLER("nds_unused_plicsw_t10_eiid");
// &DANGLER("nds_unused_plicsw_t10_eip");
// &DANGLER("nds_unused_plicsw_t11_eiid");
// &DANGLER("nds_unused_plicsw_t11_eip");
// &DANGLER("nds_unused_plicsw_t12_eiid");
// &DANGLER("nds_unused_plicsw_t12_eip");
// &DANGLER("nds_unused_plicsw_t13_eiid");
// &DANGLER("nds_unused_plicsw_t13_eip");
// &DANGLER("nds_unused_plicsw_t14_eiid");
// &DANGLER("nds_unused_plicsw_t14_eip");
// &DANGLER("nds_unused_plicsw_t15_eiid");
// &DANGLER("nds_unused_plicsw_t15_eip");
// &DANGLER("nds_unused_plicsw_t1_eiid");
// &DANGLER("nds_unused_plicsw_t2_eiid");
// &DANGLER("nds_unused_plicsw_t2_eip");
// &DANGLER("nds_unused_plicsw_t3_eiid");
// &DANGLER("nds_unused_plicsw_t3_eip");
// &DANGLER("nds_unused_plicsw_t4_eiid");
// &DANGLER("nds_unused_plicsw_t4_eip");
// &DANGLER("nds_unused_plicsw_t5_eiid");
// &DANGLER("nds_unused_plicsw_t5_eip");
// &DANGLER("nds_unused_plicsw_t6_eiid");
// &DANGLER("nds_unused_plicsw_t6_eip");
// &DANGLER("nds_unused_plicsw_t7_eiid");
// &DANGLER("nds_unused_plicsw_t7_eip");
// &DANGLER("nds_unused_plicsw_t8_eiid");
// &DANGLER("nds_unused_plicsw_t8_eip");
// &DANGLER("nds_unused_plicsw_t9_eiid");
// &DANGLER("nds_unused_plicsw_t9_eip");
// &DANGLER("nds_unused_plic_bid");
// &DANGLER("nds_unused_plic_hrdata");
// &DANGLER("nds_unused_plic_hreadyout");
// &DANGLER("nds_unused_plic_hresp");
// &DANGLER("nds_unused_plic_rid");
// &DANGLER("nds_unused_plic_t10_eiid");
// &DANGLER("nds_unused_plic_t10_eip");
// &DANGLER("nds_unused_plic_t11_eiid");
// &DANGLER("nds_unused_plic_t11_eip");
// &DANGLER("nds_unused_plic_t12_eiid");
// &DANGLER("nds_unused_plic_t12_eip");
// &DANGLER("nds_unused_plic_t13_eiid");
// &DANGLER("nds_unused_plic_t13_eip");
// &DANGLER("nds_unused_plic_t14_eiid");
// &DANGLER("nds_unused_plic_t14_eip");
// &DANGLER("nds_unused_plic_t15_eiid");
// &DANGLER("nds_unused_plic_t15_eip");
// &DANGLER("nds_unused_plic_t8_eiid");
// &DANGLER("nds_unused_plic_t8_eip");
// &DANGLER("nds_unused_plic_t9_eiid");
// &DANGLER("nds_unused_plic_t9_eip");
// &DANGLER("nds_unused_plmt_bid");
// &DANGLER("nds_unused_plmt_hrdata");
// &DANGLER("nds_unused_plmt_hreadyout");
// &DANGLER("nds_unused_plmt_hresp");
// &DANGLER("nds_unused_plmt_rid");
// &DANGLER("nds_unused_u_axi_bmc_ds3_araddr");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arburst");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arcache");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arid");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arlen");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arlock");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arprot");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arsize");
// &DANGLER("nds_unused_u_axi_bmc_ds3_arvalid");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awaddr");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awburst");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awcache");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awid");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awlen");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awlock");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awprot");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awsize");
// &DANGLER("nds_unused_u_axi_bmc_ds3_awvalid");
// &DANGLER("nds_unused_u_axi_bmc_ds3_bready");
// &DANGLER("nds_unused_u_axi_bmc_ds3_rready");
// &DANGLER("nds_unused_u_axi_bmc_ds3_wdata");
// &DANGLER("nds_unused_u_axi_bmc_ds3_wlast");
// &DANGLER("nds_unused_u_axi_bmc_ds3_wstrb");
// &DANGLER("nds_unused_u_axi_bmc_ds3_wvalid");

//
//&ENDMODULE;
//VPERL_END

// VPERL_GENERATED_BEGIN
module ae350_scpu_cluster_subsystem (
`ifdef NDS_IO_DCLS
	  dcls_core1_clk,                 // () <= ()
	  dcls_core1_lm_clk,              // () <= ()
	  dcls_comp_out,                  // (u_cluster) => ()
	  dcls_inject_en,                 // (u_cluster) <= ()
	  dcls_p_clk,                     // (u_cluster) <= ()
	  dcls_p_reset_n,                 // (u_cluster) <= ()
	  dcls_r_clk,                     // (u_cluster) <= ()
	  dcls_r_reset_n,                 // (u_cluster) <= ()
`endif // NDS_IO_DCLS
`ifdef NDS_IO_HART1
	  hart1_core_wfi_mode,            // () => ()
	  hart1_dcache_disable_init,      // () <= ()
	  hart1_icache_disable_init,      // () <= ()
	  hart1_nmi,                      // () <= ()
	  hart1_reset_vector,             // () <= ()
	  hart1_wakeup_event,             // () => ()
`endif // NDS_IO_HART1
`ifdef NDS_IO_LM
	  hart0_lm_local_int_event,       // (u_cluster) => ()
`endif // NDS_IO_LM
`ifdef NDS_IO_DCLS_SPLIT
	  dcls_p_enable_split,            // (u_cluster) <= ()
	  dcls_r_enable_split,            // (u_cluster) <= ()
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
	  slv_araddr,                     // (u_slvp_busdec) <= ()
	  slv_arburst,                    // (u_slvp_busdec) <= ()
	  slv_arcache,                    // (u_slvp_busdec) <= ()
	  slv_arid,                       // (u_slvp_busdec) <= ()
	  slv_arlen,                      // (u_slvp_busdec) <= ()
	  slv_arlock,                     // (u_slvp_busdec) <= ()
	  slv_arprot,                     // (u_slvp_busdec) <= ()
	  slv_arready,                    // (u_slvp_busdec) => ()
	  slv_arsize,                     // (u_slvp_busdec) <= ()
	  slv_arvalid,                    // (u_slvp_busdec) <= ()
	  slv_awaddr,                     // (u_slvp_busdec) <= ()
	  slv_awburst,                    // (u_slvp_busdec) <= ()
	  slv_awcache,                    // (u_slvp_busdec) <= ()
	  slv_awid,                       // (u_slvp_busdec) <= ()
	  slv_awlen,                      // (u_slvp_busdec) <= ()
	  slv_awlock,                     // (u_slvp_busdec) <= ()
	  slv_awprot,                     // (u_slvp_busdec) <= ()
	  slv_awready,                    // (u_slvp_busdec) => ()
	  slv_awsize,                     // (u_slvp_busdec) <= ()
	  slv_awvalid,                    // (u_slvp_busdec) <= ()
	  slv_bid,                        // (u_slvp_busdec) => ()
	  slv_bready,                     // (u_slvp_busdec) <= ()
	  slv_bresp,                      // (u_slvp_busdec) => ()
	  slv_bvalid,                     // (u_slvp_busdec) => ()
	  slv_rdata,                      // (u_slvp_busdec) => ()
	  slv_rid,                        // (u_slvp_busdec) => ()
	  slv_rlast,                      // (u_slvp_busdec) => ()
	  slv_rready,                     // (u_slvp_busdec) <= ()
	  slv_rresp,                      // (u_slvp_busdec) => ()
	  slv_rvalid,                     // (u_slvp_busdec) => ()
	  slv_wdata,                      // (u_slvp_busdec) <= ()
	  slv_wlast,                      // (u_slvp_busdec) <= ()
	  slv_wready,                     // (u_slvp_busdec) => ()
	  slv_wstrb,                      // (u_slvp_busdec) <= ()
	  slv_wvalid,                     // (u_slvp_busdec) <= ()
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_TRACE_TILELINK
	  core0_trace_dcu_cmt_addr,       // (u_cluster) => ()
	  core0_trace_dcu_cmt_func,       // (u_cluster) => ()
	  core0_trace_dcu_cmt_valid,      // (u_cluster) => ()
	  core0_trace_dcu_cmt_wdata,      // (u_cluster) => ()
	  core0_trace_i0_wb_alive,        // (u_cluster) => ()
	  core0_trace_i0_wb_pc,           // (u_cluster) => ()
	  core0_trace_i1_wb_alive,        // (u_cluster) => ()
	  core0_trace_i1_wb_pc,           // (u_cluster) => ()
	  core0_trace_ls_i0_instr,        // (u_cluster) => ()
	  core0_trace_ls_i0_pc,           // (u_cluster) => ()
	  core0_trace_sb_va,              // (u_cluster) => ()
	  core0_trace_wb_cause,           // (u_cluster) => ()
	  core0_trace_wb_xcpt,            // (u_cluster) => ()
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_ICACHE0
	  icache0_p_clk,                  // (u_cluster) <= ()
	  icache0_r_clk,                  // (u_cluster) <= ()
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCACHE0
	  dcache0_p_clk,                  // (u_cluster) <= ()
	  dcache0_r_clk,                  // (u_cluster) <= ()
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_PROBING
	  hart0_probe_current_pc,         // (u_cluster) => ()
	  hart0_probe_gpr_index,          // (u_cluster) <= ()
	  hart0_probe_selected_gpr_value, // (u_cluster) => ()
`endif // NDS_IO_PROBING
`ifdef NDS_IO_TRACE_INSTR_GEN1
	  hart0_gen1_trace_cause,         // (u_cluster) => ()
	  hart0_gen1_trace_enabled,       // (u_cluster) <= ()
	  hart0_gen1_trace_iaddr,         // (u_cluster) => ()
	  hart0_gen1_trace_iexception,    // (u_cluster) => ()
	  hart0_gen1_trace_instr,         // (u_cluster) => ()
	  hart0_gen1_trace_interrupt,     // (u_cluster) => ()
	  hart0_gen1_trace_ivalid,        // (u_cluster) => ()
	  hart0_gen1_trace_priv,          // (u_cluster) => ()
	  hart0_gen1_trace_tval,          // (u_cluster) => ()
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
	  hart0_trace_cause,              // (u_cluster) => ()
	  hart0_trace_context,            // (u_cluster) => ()
	  hart0_trace_ctype,              // (u_cluster) => ()
	  hart0_trace_enabled,            // (u_cluster) <= ()
	  hart0_trace_halted,             // (u_cluster) => ()
	  hart0_trace_iaddr,              // (u_cluster) => ()
	  hart0_trace_ilastsize,          // (u_cluster) => ()
	  hart0_trace_iretire,            // (u_cluster) => ()
	  hart0_trace_itype,              // (u_cluster) => ()
	  hart0_trace_priv,               // (u_cluster) => ()
	  hart0_trace_reset,              // (u_cluster) => ()
	  hart0_trace_stall,              // (u_cluster) <= ()
	  hart0_trace_trigger,            // (u_cluster) => ()
	  hart0_trace_tval,               // (u_cluster) => ()
`endif // NDS_IO_TRACE_INSTR
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	  dmactive,                       // (u_pldm) => ()
	  dmi_haddr,                      // (u_pldm) <= ()
	  dmi_hburst,                     // (u_pldm) <= ()
	  dmi_hprot,                      // (u_pldm) <= ()
	  dmi_hrdata,                     // (u_pldm) => ()
	  dmi_hready,                     // (u_pldm) <= ()
	  dmi_hreadyout,                  // (u_pldm) => ()
	  dmi_hresp,                      // (u_pldm) => ()
	  dmi_hsel,                       // (u_pldm) <= ()
	  dmi_hsize,                      // (u_pldm) <= ()
	  dmi_htrans,                     // (u_pldm) <= ()
	  dmi_hwdata,                     // (u_pldm) <= ()
	  dmi_hwrite,                     // (u_pldm) <= ()
	  dmi_resetn,                     // (u_pldm) <= ()
	  hart_nonexistent,               // (u_pldm) <= ()
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_ICACHE0
	  icache1_p_clk,                  // (u_cluster) <= ()
	  icache1_r_clk,                  // (u_cluster) <= ()
   `endif // NDS_IO_ICACHE0
   `ifdef NDS_IO_DCACHE0
	  dcache1_p_clk,                  // (u_cluster) <= ()
	  dcache1_r_clk,                  // (u_cluster) <= ()
   `endif // NDS_IO_DCACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
   `ifdef PLATFORM_DEBUG_SUBSYSTEM
	  dm_sys_araddr,                  // () => ()
	  dm_sys_arburst,                 // () => ()
	  dm_sys_arcache,                 // () => ()
	  dm_sys_arid,                    // () => ()
	  dm_sys_arlen,                   // () => ()
	  dm_sys_arlock,                  // () => ()
	  dm_sys_arprot,                  // () => ()
	  dm_sys_arready,                 // () <= ()
	  dm_sys_arsize,                  // () => ()
	  dm_sys_arvalid,                 // () => ()
	  dm_sys_awaddr,                  // () => ()
	  dm_sys_awburst,                 // () => ()
	  dm_sys_awcache,                 // () => ()
	  dm_sys_awid,                    // () => ()
	  dm_sys_awlen,                   // () => ()
	  dm_sys_awlock,                  // () => ()
	  dm_sys_awprot,                  // () => ()
	  dm_sys_awready,                 // () <= ()
	  dm_sys_awsize,                  // () => ()
	  dm_sys_awvalid,                 // () => ()
	  dm_sys_bid,                     // () <= ()
	  dm_sys_bready,                  // () => ()
	  dm_sys_bresp,                   // () <= ()
	  dm_sys_bvalid,                  // () <= ()
	  dm_sys_rdata,                   // () <= ()
	  dm_sys_rid,                     // () <= ()
	  dm_sys_rlast,                   // () <= ()
	  dm_sys_rready,                  // () => ()
	  dm_sys_rresp,                   // () <= ()
	  dm_sys_rvalid,                  // () <= ()
	  dm_sys_wdata,                   // () => ()
	  dm_sys_wlast,                   // () => ()
	  dm_sys_wready,                  // () <= ()
	  dm_sys_wstrb,                   // () => ()
	  dm_sys_wvalid,                  // () => ()
   `endif // PLATFORM_DEBUG_SUBSYSTEM
`endif // PLATFORM_PLDM_SYS_BUS_ACCESS
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_DCLS_SPLIT
      `ifdef NDS_TRACE_TILELINK
	  core1_trace_dcu_cmt_addr,       // (u_cluster) => ()
	  core1_trace_dcu_cmt_func,       // (u_cluster) => ()
	  core1_trace_dcu_cmt_valid,      // (u_cluster) => ()
	  core1_trace_dcu_cmt_wdata,      // (u_cluster) => ()
	  core1_trace_i0_wb_alive,        // (u_cluster) => ()
	  core1_trace_i0_wb_pc,           // (u_cluster) => ()
	  core1_trace_i1_wb_alive,        // (u_cluster) => ()
	  core1_trace_i1_wb_pc,           // (u_cluster) => ()
	  core1_trace_ls_i0_instr,        // (u_cluster) => ()
	  core1_trace_ls_i0_pc,           // (u_cluster) => ()
	  core1_trace_sb_va,              // (u_cluster) => ()
	  core1_trace_wb_cause,           // (u_cluster) => ()
	  core1_trace_wb_xcpt,            // (u_cluster) => ()
      `endif // NDS_TRACE_TILELINK
      `ifdef NDS_IO_PROBING
	  hart1_probe_current_pc,         // (u_cluster) => ()
	  hart1_probe_gpr_index,          // (u_cluster) <= ()
	  hart1_probe_selected_gpr_value, // (u_cluster) => ()
      `endif // NDS_IO_PROBING
      `ifdef NDS_IO_TRACE_INSTR_GEN1
	  hart1_gen1_trace_cause,         // (u_cluster) => ()
	  hart1_gen1_trace_enabled,       // (u_cluster) <= ()
	  hart1_gen1_trace_iaddr,         // (u_cluster) => ()
	  hart1_gen1_trace_iexception,    // (u_cluster) => ()
	  hart1_gen1_trace_instr,         // (u_cluster) => ()
	  hart1_gen1_trace_interrupt,     // (u_cluster) => ()
	  hart1_gen1_trace_ivalid,        // (u_cluster) => ()
	  hart1_gen1_trace_priv,          // (u_cluster) => ()
	  hart1_gen1_trace_tval,          // (u_cluster) => ()
      `endif // NDS_IO_TRACE_INSTR_GEN1
      `ifdef NDS_IO_TRACE_INSTR
	  hart1_trace_cause,              // (u_cluster) => ()
	  hart1_trace_context,            // (u_cluster) => ()
	  hart1_trace_ctype,              // (u_cluster) => ()
	  hart1_trace_enabled,            // (u_cluster) <= ()
	  hart1_trace_halted,             // (u_cluster) => ()
	  hart1_trace_iaddr,              // (u_cluster) => ()
	  hart1_trace_ilastsize,          // (u_cluster) => ()
	  hart1_trace_iretire,            // (u_cluster) => ()
	  hart1_trace_itype,              // (u_cluster) => ()
	  hart1_trace_priv,               // (u_cluster) => ()
	  hart1_trace_reset,              // (u_cluster) => ()
	  hart1_trace_stall,              // (u_cluster) <= ()
	  hart1_trace_trigger,            // (u_cluster) => ()
	  hart1_trace_tval,               // (u_cluster) => ()
      `endif // NDS_IO_TRACE_INSTR
      `ifdef NDS_IO_HART1
         `ifdef NDS_IO_LM
	  hart1_lm_local_int_event,       // (u_cluster) => ()
         `endif // NDS_IO_LM
      `endif // NDS_IO_HART1
   `endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS
	  core_clk,                       // () <= ()
	  core_resetn,                    // () <= ()
	  dbg_srst_req,                   // () => ()
	  hart0_core_wfi_mode,            // () => ()
	  hart0_dcache_disable_init,      // () <= ()
	  hart0_icache_disable_init,      // () <= ()
	  hart0_nmi,                      // () <= ()
	  hart0_reset_vector,             // () <= ()
	  hart0_wakeup_event,             // () => ()
	  slvp_resetn,                    // () <= ()
	  test_rstn,                      // () <= ()
	  sys_araddr,                     // (u_atcexmon300) => ()
	  sys_arburst,                    // (u_atcexmon300) => ()
	  sys_arcache,                    // (u_atcexmon300) => ()
	  sys_arid,                       // (u_atcexmon300) => ()
	  sys_arlen,                      // (u_atcexmon300) => ()
	  sys_arlock,                     // (u_atcexmon300) => ()
	  sys_arprot,                     // (u_atcexmon300) => ()
	  sys_arready,                    // (u_atcexmon300) <= ()
	  sys_arsize,                     // (u_atcexmon300) => ()
	  sys_arvalid,                    // (u_atcexmon300) => ()
	  sys_awaddr,                     // (u_atcexmon300) => ()
	  sys_awburst,                    // (u_atcexmon300) => ()
	  sys_awcache,                    // (u_atcexmon300) => ()
	  sys_awid,                       // (u_atcexmon300) => ()
	  sys_awlen,                      // (u_atcexmon300) => ()
	  sys_awlock,                     // (u_atcexmon300) => ()
	  sys_awprot,                     // (u_atcexmon300) => ()
	  sys_awready,                    // (u_atcexmon300) <= ()
	  sys_awsize,                     // (u_atcexmon300) => ()
	  sys_awvalid,                    // (u_atcexmon300) => ()
	  sys_bid,                        // (u_atcexmon300) <= ()
	  sys_bready,                     // (u_atcexmon300) => ()
	  sys_bresp,                      // (u_atcexmon300) <= ()
	  sys_bvalid,                     // (u_atcexmon300) <= ()
	  sys_rdata,                      // (u_atcexmon300) <= ()
	  sys_rid,                        // (u_atcexmon300) <= ()
	  sys_rlast,                      // (u_atcexmon300) <= ()
	  sys_rready,                     // (u_atcexmon300) => ()
	  sys_rresp,                      // (u_atcexmon300) <= ()
	  sys_rvalid,                     // (u_atcexmon300) <= ()
	  sys_wdata,                      // (u_atcexmon300) => ()
	  sys_wlast,                      // (u_atcexmon300) => ()
	  sys_wready,                     // (u_atcexmon300) <= ()
	  sys_wstrb,                      // (u_atcexmon300) => ()
	  sys_wvalid,                     // (u_atcexmon300) => ()
	  aclk,                           // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	  aresetn,                        // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	  flash0_araddr,                  // (u_axi_bmc) => ()
	  flash0_arburst,                 // (u_axi_bmc) => ()
	  flash0_arcache,                 // (u_axi_bmc) => ()
	  flash0_arid,                    // (u_axi_bmc) => ()
	  flash0_arlen,                   // (u_axi_bmc) => ()
	  flash0_arlock,                  // (u_axi_bmc) => ()
	  flash0_arprot,                  // (u_axi_bmc) => ()
	  flash0_arready,                 // (u_axi_bmc) <= ()
	  flash0_arsize,                  // (u_axi_bmc) => ()
	  flash0_arvalid,                 // (u_axi_bmc) => ()
	  flash0_awaddr,                  // (u_axi_bmc) => ()
	  flash0_awburst,                 // (u_axi_bmc) => ()
	  flash0_awcache,                 // (u_axi_bmc) => ()
	  flash0_awid,                    // (u_axi_bmc) => ()
	  flash0_awlen,                   // (u_axi_bmc) => ()
	  flash0_awlock,                  // (u_axi_bmc) => ()
	  flash0_awprot,                  // (u_axi_bmc) => ()
	  flash0_awready,                 // (u_axi_bmc) <= ()
	  flash0_awsize,                  // (u_axi_bmc) => ()
	  flash0_awvalid,                 // (u_axi_bmc) => ()
	  flash0_bid,                     // (u_axi_bmc) <= ()
	  flash0_bready,                  // (u_axi_bmc) => ()
	  flash0_bresp,                   // (u_axi_bmc) <= ()
	  flash0_bvalid,                  // (u_axi_bmc) <= ()
	  flash0_rdata,                   // (u_axi_bmc) <= ()
	  flash0_rid,                     // (u_axi_bmc) <= ()
	  flash0_rlast,                   // (u_axi_bmc) <= ()
	  flash0_rready,                  // (u_axi_bmc) => ()
	  flash0_rresp,                   // (u_axi_bmc) <= ()
	  flash0_rvalid,                  // (u_axi_bmc) <= ()
	  flash0_wdata,                   // (u_axi_bmc) => ()
	  flash0_wlast,                   // (u_axi_bmc) => ()
	  flash0_wready,                  // (u_axi_bmc) <= ()
	  flash0_wstrb,                   // (u_axi_bmc) => ()
	  flash0_wvalid,                  // (u_axi_bmc) => ()
	  axi_bus_clk_en,                 // (u_cluster) <= ()
	  biu_clk,                        // (u_cluster) <= ()
	  biu_resetn,                     // (u_cluster) <= ()
	  scan_enable,                    // (u_cluster) <= ()
	  test_mode,                      // (u_cluster,u_plmt) <= ()
	  lm_clk,                         // (u_core0_dlm_ram0,u_core0_ilm_clock_gen,u_core0_ilm_ram_brg,u_core1_dlm_ram0,u_core1_ilm_clock_gen,u_core1_ilm_ram_brg) <= ()
	  int_src,                        // (u_plic) <= ()
	  mtime_clk,                      // (u_plmt) <= ()
	  por_rstn                        // (u_plmt) <= ()
);

`ifdef PLATFORM_SLVPORT_DLM_SEL_BIT
localparam SLVPORT_DLM_SEL_BIT        = `PLATFORM_SLVPORT_DLM_SEL_BIT;
`else
localparam SLVPORT_DLM_SEL_BIT        = 21;
`endif // PLATFORM_SLVPORT_DLM_SEL_BIT
localparam PALEN                      = `NDS_BIU_ADDR_WIDTH;
localparam BIU_ADDR_WIDTH             = `NDS_BIU_ADDR_WIDTH;
localparam BIU_ADDR_MSB               = `NDS_BIU_ADDR_WIDTH-1;
localparam BIU_ASYNC_SUPPORT          = `NDS_BIU_ASYNC_SUPPORT;
localparam COMPLEX_BRG_TYPE           = `NDS_COMPLEX_BRG_TYPE;
localparam XLEN                       = `NDS_XLEN;
localparam VALEN                      = `NDS_VALEN;
`ifdef PLATFORM_FORCE_4GB_SPACE
localparam ADDR_WIDTH           = 32;
`else
localparam ADDR_WIDTH           = PALEN;
`endif // PLATFORM_FORCE_4GB_SPACE
localparam ADDR_MSB                   = (ADDR_WIDTH-1);
localparam RESET_VECTOR_WIDTH         = (VALEN > 32) ? 64 : 32;
localparam FLASHIF0_DATA_WIDTH        = `NDS_FLASHIF0_DATA_WIDTH;
localparam FLASHIF0_DATA_CODE_WIDTH   = `NDS_FLASHIF0_DATA_CODE_WIDTH;
localparam FLASHIF0_ID_WIDTH          = `NDS_FLASHIF0_ID_WIDTH;
localparam BIU_DATA_WIDTH             = `NDS_BIU_DATA_WIDTH;
localparam BIU_DATA_CODE_WIDTH        = `NDS_BIU_DATA_CODE_WIDTH;
localparam PPI_DATA_CODE_WIDTH        = `NDS_PPI_DATA_CODE_WIDTH;
localparam BIU_ADDR_CODE_WIDTH        = `NDS_BIU_ADDR_CODE_WIDTH;
localparam BIU_CTRL_CODE_WIDTH        = `NDS_BIU_CTRL_CODE_WIDTH;
localparam BIU_UTID_WIDTH             = `NDS_BIU_UTID_WIDTH;
localparam BIU_DATA_MSB               = (BIU_DATA_WIDTH-1);
localparam BIU_WSTRB_WIDTH            = (BIU_DATA_WIDTH/8);
localparam BIU_WSTRB_MSB              = (BIU_WSTRB_WIDTH-1);
localparam WCTRL_CODE_WIDTH           = 5;
localparam BUS_PROTECTION_SUPPORT     = `NDS_BUS_PROTECTION_SUPPORT;
localparam IOCP_ID_WIDTH              = `NDS_IOCP_ID_WIDTH;
localparam SLVPORT_ID_WIDTH           = `NDS_SLAVE_PORT_ID_WIDTH;
localparam SLVPORT_DATA_WIDTH         = `NDS_SLAVE_PORT_DATA_WIDTH;
localparam SLVPORT_DATA_MSB           = (SLVPORT_DATA_WIDTH-1);
localparam SLVPORT_WSTRB_WIDTH        = (SLVPORT_DATA_WIDTH/8);
localparam SLVPORT_WSTRB_MSB          = (SLVPORT_WSTRB_WIDTH-1);
localparam SLVP_PROTECTION_SUPPORT = `NDS_SLVP_PROTECTION_SUPPORT;
localparam SLV_ADDR_CODE_WIDTH = `NDS_SLV_ADDR_CODE_WIDTH;
localparam SLV_DATA_CODE_WIDTH = `NDS_SLV_DATA_CODE_WIDTH;
localparam SLV_CTRL_CODE_WIDTH = `NDS_SLV_CTRL_CODE_WIDTH;
localparam SLV_UTID_WIDTH = `NDS_SLV_UTID_WIDTH;
localparam SLV_ID_CODE_WIDTH = (SLVPORT_ID_WIDTH < 5)  ? 3 : (SLVPORT_ID_WIDTH < 12) ? 4 : 5;
localparam SLV_WCTRL_CODE_WIDTH = ((SLVPORT_WSTRB_WIDTH+1) < 5)  ? 3 : ((SLVPORT_WSTRB_WIDTH+1) < 12) ? 4 : 5;
localparam BIU_ID_WIDTH               = `NDS_BIU_ID_WIDTH;
localparam BIU_ID_MSB                 = (BIU_ID_WIDTH-1);
localparam PPI_DATA_WIDTH             = `NDS_PPI_DATA_WIDTH;
localparam PPI_ID_WIDTH               = `NDS_PPI_ID_WIDTH;
localparam VECTOR_PLIC_SUPPORT        = `NDS_VECTOR_PLIC_SUPPORT;
localparam NCE_DATA_WIDTH             = (BIU_DATA_WIDTH > 64) ? 64 : BIU_DATA_WIDTH;
localparam NCE_DATA_MSB               = (NCE_DATA_WIDTH-1);
localparam NCE_WSTRB_WIDTH            = (NCE_DATA_WIDTH/8);
localparam NCE_WSTRB_MSB              = (NCE_WSTRB_WIDTH-1);
localparam DM_SYS_DATA_WIDTH          = (BIU_DATA_WIDTH > 128) ? 128 : BIU_DATA_WIDTH;
localparam DM_SYS_DATA_MSB            = (DM_SYS_DATA_WIDTH-1);
localparam DM_SYS_WSTRB_WIDTH         = (DM_SYS_DATA_WIDTH/8);
localparam DM_SYS_WSTRB_MSB           = (DM_SYS_WSTRB_WIDTH-1);
localparam SIZEUP_DS_DATA_WIDTH       = BIU_DATA_WIDTH;
localparam SIZEUP_DS_DATA_SIZE        = $unsigned($clog2(SIZEUP_DS_DATA_WIDTH)) - 3;
localparam SIZEUP_ADDR_WIDTH          = SIZEUP_DS_DATA_SIZE;
localparam SIZEUP_ADDR_MSB            = (SIZEUP_ADDR_WIDTH-1);
`ifdef NDS_IO_CLUSTER
localparam NHART                = `NDS_NHART;
`else
localparam NHART                = 1;
`endif // NDS_IO_CLUSTER
localparam DLM_RAM_BWEW               = `NDS_DLM_RAM_BWEW;
localparam ILM_AW                     = `NDS_ILM_AW;
localparam ILM_RAM_DW                 = `NDS_ILM_RAM_DW;
localparam ILM_RAM_BWEW               = `NDS_ILM_RAM_BWEW;
localparam ILM_ECC_SUPPORT            = `NDS_ILM_ECC_TYPE == "ecc";
localparam ILM_TL_UL_RAM_NUM          = (XLEN == 64) ? 1 : 2;
localparam ILM_TL_UL_AW               = ILM_AW+3;
localparam ILM_TL_UL_EW               = ILM_ECC_SUPPORT ? (XLEN == 64) ? 8 : 7 : 1;
localparam ILM_TL_UL_RAM_AW           = ILM_AW;
localparam ILM_TL_UL_RAM_DW           = (XLEN == 64) ? ILM_ECC_SUPPORT ? 72 : 64 : ILM_ECC_SUPPORT ? 39 : 32;
localparam ILM_TL_UL_RAM_BWEW       = (ILM_TL_UL_RAM_DW == 39) ? 5 : ILM_TL_UL_RAM_DW/8;
localparam PLIC_HW_TARGET_NUM         = NHART*2;
localparam PLIC_SW_TARGET_NUM         = NHART;
localparam ILM_HDATA_WIDTH            = XLEN;
localparam DLM_HDATA_WIDTH            = XLEN;
localparam PROGBUF_SIZE               = `PLATFORM_PLDM_PROGBUF_SIZE;
localparam HALTGROUP_COUNT            = `PLATFORM_PLDM_HALTGROUP_COUNT;
`ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
localparam PLDM_SYS_BUS_ACCESS  = "yes";
`else
localparam PLDM_SYS_BUS_ACCESS  = "no";
`endif // PLATFORM_PLDM_SYS_BUS_ACCESS
`ifdef PLATFORM_TRACE_SUBSYSTEM
localparam DMXTRIGGER_COUNT = 1;
`else
localparam DMXTRIGGER_COUNT = 0;
`endif // PLATFORM_TRACE_SUBSYSTEM
localparam DMXTRIGGER_MSB = (DMXTRIGGER_COUNT > 0) ? DMXTRIGGER_COUNT - 1 : 0;
localparam SYNC_STAGE = `NDS_SYNC_STAGE;

`ifdef NDS_IO_DCLS
input                                        dcls_core1_clk;
input                                        dcls_core1_lm_clk;
output      [(`NDS_DCLS_COMP_OUT_WIDTH-1):0] dcls_comp_out;
input                                        dcls_inject_en;
input                                        dcls_p_clk;
input                                        dcls_p_reset_n;
input                                        dcls_r_clk;
input                                        dcls_r_reset_n;
`endif // NDS_IO_DCLS
`ifdef NDS_IO_HART1
output                                       hart1_core_wfi_mode;
input                                        hart1_dcache_disable_init;
input                                        hart1_icache_disable_init;
input                                        hart1_nmi;
input                          [(VALEN-1):0] hart1_reset_vector;
output                                 [5:0] hart1_wakeup_event;
`endif // NDS_IO_HART1
`ifdef NDS_IO_LM
output                                       hart0_lm_local_int_event;
`endif // NDS_IO_LM
`ifdef NDS_IO_DCLS_SPLIT
input                                        dcls_p_enable_split;
input                                        dcls_r_enable_split;
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
input                           [ADDR_MSB:0] slv_araddr;
input                                  [1:0] slv_arburst;
input                                  [3:0] slv_arcache;
input                     [(BIU_ID_MSB+4):0] slv_arid;
input                                  [7:0] slv_arlen;
input                                        slv_arlock;
input                                  [2:0] slv_arprot;
output                                       slv_arready;
input                                  [2:0] slv_arsize;
input                                        slv_arvalid;
input                           [ADDR_MSB:0] slv_awaddr;
input                                  [1:0] slv_awburst;
input                                  [3:0] slv_awcache;
input                     [(BIU_ID_MSB+4):0] slv_awid;
input                                  [7:0] slv_awlen;
input                                        slv_awlock;
input                                  [2:0] slv_awprot;
output                                       slv_awready;
input                                  [2:0] slv_awsize;
input                                        slv_awvalid;
output                    [(BIU_ID_MSB+4):0] slv_bid;
input                                        slv_bready;
output                                 [1:0] slv_bresp;
output                                       slv_bvalid;
output            [(SLVPORT_DATA_WIDTH-1):0] slv_rdata;
output                    [(BIU_ID_MSB+4):0] slv_rid;
output                                       slv_rlast;
input                                        slv_rready;
output                                 [1:0] slv_rresp;
output                                       slv_rvalid;
input             [(SLVPORT_DATA_WIDTH-1):0] slv_wdata;
input                                        slv_wlast;
output                                       slv_wready;
input         [((SLVPORT_DATA_WIDTH/8)-1):0] slv_wstrb;
input                                        slv_wvalid;
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_TRACE_TILELINK
output                                [31:0] core0_trace_dcu_cmt_addr;
output                                [11:0] core0_trace_dcu_cmt_func;
output                                       core0_trace_dcu_cmt_valid;
output                                [31:0] core0_trace_dcu_cmt_wdata;
output                                       core0_trace_i0_wb_alive;
output                                [31:0] core0_trace_i0_wb_pc;
output                                       core0_trace_i1_wb_alive;
output                                [31:0] core0_trace_i1_wb_pc;
output                                [31:0] core0_trace_ls_i0_instr;
output                                [31:0] core0_trace_ls_i0_pc;
output                                [31:0] core0_trace_sb_va;
output                                 [5:0] core0_trace_wb_cause;
output                                       core0_trace_wb_xcpt;
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_ICACHE0
input                                        icache0_p_clk;
input                                        icache0_r_clk;
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCACHE0
input                                        dcache0_p_clk;
input                                        dcache0_r_clk;
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_PROBING
output                  [((`NDS_VALEN)-1):0] hart0_probe_current_pc;
input                                 [12:0] hart0_probe_gpr_index;
output                   [((`NDS_XLEN)-1):0] hart0_probe_selected_gpr_value;
`endif // NDS_IO_PROBING
`ifdef NDS_IO_TRACE_INSTR_GEN1
output                                [19:0] hart0_gen1_trace_cause;
input                                        hart0_gen1_trace_enabled;
output                  [(`NDS_VALEN)*2-1:0] hart0_gen1_trace_iaddr;
output                                 [1:0] hart0_gen1_trace_iexception;
output                                [63:0] hart0_gen1_trace_instr;
output                                 [1:0] hart0_gen1_trace_interrupt;
output                                 [1:0] hart0_gen1_trace_ivalid;
output                                 [3:0] hart0_gen1_trace_priv;
output                   [(`NDS_XLEN)*2-1:0] hart0_gen1_trace_tval;
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
output                                 [9:0] hart0_trace_cause;
output                                [31:0] hart0_trace_context;
output                                 [1:0] hart0_trace_ctype;
input                                        hart0_trace_enabled;
output                                       hart0_trace_halted;
output                  [2*(`NDS_VALEN)-1:0] hart0_trace_iaddr;
output                                 [1:0] hart0_trace_ilastsize;
output                                 [3:0] hart0_trace_iretire;
output                                 [7:0] hart0_trace_itype;
output                                 [1:0] hart0_trace_priv;
output                                       hart0_trace_reset;
input                                        hart0_trace_stall;
output                                 [5:0] hart0_trace_trigger;
output                   [((`NDS_XLEN)-1):0] hart0_trace_tval;
`endif // NDS_IO_TRACE_INSTR
`ifdef PLATFORM_DEBUG_SUBSYSTEM
output                                       dmactive;
input                                  [8:0] dmi_haddr;
input                                  [2:0] dmi_hburst;
input                                  [3:0] dmi_hprot;
output                                [31:0] dmi_hrdata;
input                                        dmi_hready;
output                                       dmi_hreadyout;
output                                 [1:0] dmi_hresp;
input                                        dmi_hsel;
input                                  [2:0] dmi_hsize;
input                                  [1:0] dmi_htrans;
input                                 [31:0] dmi_hwdata;
input                                        dmi_hwrite;
input                                        dmi_resetn;
input                          [(NHART-1):0] hart_nonexistent;
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_ICACHE0
input                                        icache1_p_clk;
input                                        icache1_r_clk;
   `endif // NDS_IO_ICACHE0
   `ifdef NDS_IO_DCACHE0
input                                        dcache1_p_clk;
input                                        dcache1_r_clk;
   `endif // NDS_IO_DCACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
   `ifdef PLATFORM_DEBUG_SUBSYSTEM
output                          [ADDR_MSB:0] dm_sys_araddr;
output                                 [1:0] dm_sys_arburst;
output                                 [3:0] dm_sys_arcache;
output                        [BIU_ID_MSB:0] dm_sys_arid;
output                                 [7:0] dm_sys_arlen;
output                                       dm_sys_arlock;
output                                 [2:0] dm_sys_arprot;
input                                        dm_sys_arready;
output                                 [2:0] dm_sys_arsize;
output                                       dm_sys_arvalid;
output                          [ADDR_MSB:0] dm_sys_awaddr;
output                                 [1:0] dm_sys_awburst;
output                                 [3:0] dm_sys_awcache;
output                        [BIU_ID_MSB:0] dm_sys_awid;
output                                 [7:0] dm_sys_awlen;
output                                       dm_sys_awlock;
output                                 [2:0] dm_sys_awprot;
input                                        dm_sys_awready;
output                                 [2:0] dm_sys_awsize;
output                                       dm_sys_awvalid;
input                         [BIU_ID_MSB:0] dm_sys_bid;
output                                       dm_sys_bready;
input                                  [1:0] dm_sys_bresp;
input                                        dm_sys_bvalid;
input                 [(BIU_DATA_WIDTH-1):0] dm_sys_rdata;
input                         [BIU_ID_MSB:0] dm_sys_rid;
input                                        dm_sys_rlast;
output                                       dm_sys_rready;
input                                  [1:0] dm_sys_rresp;
input                                        dm_sys_rvalid;
output                [(BIU_DATA_WIDTH-1):0] dm_sys_wdata;
output                                       dm_sys_wlast;
input                                        dm_sys_wready;
output            [((BIU_DATA_WIDTH/8)-1):0] dm_sys_wstrb;
output                                       dm_sys_wvalid;
   `endif // PLATFORM_DEBUG_SUBSYSTEM
`endif // PLATFORM_PLDM_SYS_BUS_ACCESS
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_DCLS_SPLIT
      `ifdef NDS_TRACE_TILELINK
output                                [31:0] core1_trace_dcu_cmt_addr;
output                                [11:0] core1_trace_dcu_cmt_func;
output                                       core1_trace_dcu_cmt_valid;
output                                [31:0] core1_trace_dcu_cmt_wdata;
output                                       core1_trace_i0_wb_alive;
output                                [31:0] core1_trace_i0_wb_pc;
output                                       core1_trace_i1_wb_alive;
output                                [31:0] core1_trace_i1_wb_pc;
output                                [31:0] core1_trace_ls_i0_instr;
output                                [31:0] core1_trace_ls_i0_pc;
output                                [31:0] core1_trace_sb_va;
output                                 [5:0] core1_trace_wb_cause;
output                                       core1_trace_wb_xcpt;
      `endif // NDS_TRACE_TILELINK
      `ifdef NDS_IO_PROBING
output                  [((`NDS_VALEN)-1):0] hart1_probe_current_pc;
input                                 [12:0] hart1_probe_gpr_index;
output                   [((`NDS_XLEN)-1):0] hart1_probe_selected_gpr_value;
      `endif // NDS_IO_PROBING
      `ifdef NDS_IO_TRACE_INSTR_GEN1
output                                [19:0] hart1_gen1_trace_cause;
input                                        hart1_gen1_trace_enabled;
output                  [(`NDS_VALEN)*2-1:0] hart1_gen1_trace_iaddr;
output                                 [1:0] hart1_gen1_trace_iexception;
output                                [63:0] hart1_gen1_trace_instr;
output                                 [1:0] hart1_gen1_trace_interrupt;
output                                 [1:0] hart1_gen1_trace_ivalid;
output                                 [3:0] hart1_gen1_trace_priv;
output                   [(`NDS_XLEN)*2-1:0] hart1_gen1_trace_tval;
      `endif // NDS_IO_TRACE_INSTR_GEN1
      `ifdef NDS_IO_TRACE_INSTR
output                                 [9:0] hart1_trace_cause;
output                                [31:0] hart1_trace_context;
output                                 [1:0] hart1_trace_ctype;
input                                        hart1_trace_enabled;
output                                       hart1_trace_halted;
output                  [2*(`NDS_VALEN)-1:0] hart1_trace_iaddr;
output                                 [1:0] hart1_trace_ilastsize;
output                                 [3:0] hart1_trace_iretire;
output                                 [7:0] hart1_trace_itype;
output                                 [1:0] hart1_trace_priv;
output                                       hart1_trace_reset;
input                                        hart1_trace_stall;
output                                 [5:0] hart1_trace_trigger;
output                   [((`NDS_XLEN)-1):0] hart1_trace_tval;
      `endif // NDS_IO_TRACE_INSTR
      `ifdef NDS_IO_HART1
         `ifdef NDS_IO_LM
output                                       hart1_lm_local_int_event;
         `endif // NDS_IO_LM
      `endif // NDS_IO_HART1
   `endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS
input                          [(NHART-1):0] core_clk;
input                          [(NHART-1):0] core_resetn;
output                                       dbg_srst_req;
output                                       hart0_core_wfi_mode;
input                                        hart0_dcache_disable_init;
input                                        hart0_icache_disable_init;
input                                        hart0_nmi;
input                          [(VALEN-1):0] hart0_reset_vector;
output                                 [5:0] hart0_wakeup_event;
input                          [(NHART-1):0] slvp_resetn;
input                                        test_rstn;
output                          [ADDR_MSB:0] sys_araddr;
output                                 [1:0] sys_arburst;
output                                 [3:0] sys_arcache;
output                        [BIU_ID_MSB:0] sys_arid;
output                                 [7:0] sys_arlen;
output                                       sys_arlock;
output                                 [2:0] sys_arprot;
input                                        sys_arready;
output                                 [2:0] sys_arsize;
output                                       sys_arvalid;
output                          [ADDR_MSB:0] sys_awaddr;
output                                 [1:0] sys_awburst;
output                                 [3:0] sys_awcache;
output                        [BIU_ID_MSB:0] sys_awid;
output                                 [7:0] sys_awlen;
output                                       sys_awlock;
output                                 [2:0] sys_awprot;
input                                        sys_awready;
output                                 [2:0] sys_awsize;
output                                       sys_awvalid;
input                         [BIU_ID_MSB:0] sys_bid;
output                                       sys_bready;
input                                  [1:0] sys_bresp;
input                                        sys_bvalid;
input                 [(BIU_DATA_WIDTH-1):0] sys_rdata;
input                         [BIU_ID_MSB:0] sys_rid;
input                                        sys_rlast;
output                                       sys_rready;
input                                  [1:0] sys_rresp;
input                                        sys_rvalid;
output                [(BIU_DATA_WIDTH-1):0] sys_wdata;
output                                       sys_wlast;
input                                        sys_wready;
output            [((BIU_DATA_WIDTH/8)-1):0] sys_wstrb;
output                                       sys_wvalid;
input                                        aclk;                            // clock domain b_clk
input                                        aresetn;                         // reset signal in b_clk domain
output                          [ADDR_MSB:0] flash0_araddr;
output                                 [1:0] flash0_arburst;
output                                 [3:0] flash0_arcache;
output                        [BIU_ID_MSB:0] flash0_arid;
output                                 [7:0] flash0_arlen;
output                                       flash0_arlock;
output                                 [2:0] flash0_arprot;
input                                        flash0_arready;
output                                 [2:0] flash0_arsize;
output                                       flash0_arvalid;
output                          [ADDR_MSB:0] flash0_awaddr;
output                                 [1:0] flash0_awburst;
output                                 [3:0] flash0_awcache;
output                        [BIU_ID_MSB:0] flash0_awid;
output                                 [7:0] flash0_awlen;
output                                       flash0_awlock;
output                                 [2:0] flash0_awprot;
input                                        flash0_awready;
output                                 [2:0] flash0_awsize;
output                                       flash0_awvalid;
input                         [BIU_ID_MSB:0] flash0_bid;
output                                       flash0_bready;
input                                  [1:0] flash0_bresp;
input                                        flash0_bvalid;
input                 [(BIU_DATA_WIDTH-1):0] flash0_rdata;
input                         [BIU_ID_MSB:0] flash0_rid;
input                                        flash0_rlast;
output                                       flash0_rready;
input                                  [1:0] flash0_rresp;
input                                        flash0_rvalid;
output                [(BIU_DATA_WIDTH-1):0] flash0_wdata;
output                                       flash0_wlast;
input                                        flash0_wready;
output            [((BIU_DATA_WIDTH/8)-1):0] flash0_wstrb;
output                                       flash0_wvalid;
input                                        axi_bus_clk_en;
input                                        biu_clk;
input                                        biu_resetn;
input                                        scan_enable;
input                                        test_mode;
input                          [(NHART-1):0] lm_clk;
input                                 [31:1] int_src;                         // From Source (e.g. devices)
input                                        mtime_clk;                       // clock domain b_clk
input                                        por_rstn;

`ifdef NDS_IO_DCLS
reg                                               [1:0] core0_reset_n_delay;
reg                                               [1:0] core0_slvp_reset_n_delay;
wire                                                    core1_clk;
wire                                                    core1_reset_n;
wire                                                    core1_slv1_clk;
wire                                                    core1_slv_clk;
wire                                                    core1_slvp_reset_n;
wire                      [((`NDS_BIU_ADDR_WIDTH)-1):0] dcls_inject_fault_m0_a_address;
wire                                                    dcls_inject_fault_m0_a_corrupt;
wire                       [((`NDS_L2_DATA_WIDTH)-1):0] dcls_inject_fault_m0_a_data;
wire                     [((`NDS_L2_DATA_WIDTH)/8)-1:0] dcls_inject_fault_m0_a_mask;
wire                                              [2:0] dcls_inject_fault_m0_a_opcode;
wire                                              [2:0] dcls_inject_fault_m0_a_param;
wire                                              [2:0] dcls_inject_fault_m0_a_size;
wire                       [(`NDS_L2_SOURCE_WIDTH-1):0] dcls_inject_fault_m0_a_source;
wire                             [(`NDS_SCPU_A_UW-1):0] dcls_inject_fault_m0_a_user;
wire                                                    dcls_inject_fault_m0_a_valid;
wire                                                    dcls_inject_fault_m0_b_ready;
wire                      [((`NDS_BIU_ADDR_WIDTH)-1):0] dcls_inject_fault_m0_c_address;
wire                                                    dcls_inject_fault_m0_c_corrupt;
wire                       [((`NDS_L2_DATA_WIDTH)-1):0] dcls_inject_fault_m0_c_data;
wire                                              [2:0] dcls_inject_fault_m0_c_opcode;
wire                                              [2:0] dcls_inject_fault_m0_c_param;
wire                                              [2:0] dcls_inject_fault_m0_c_size;
wire                       [(`NDS_L2_SOURCE_WIDTH-1):0] dcls_inject_fault_m0_c_source;
wire                             [(`NDS_SCPU_C_UW-1):0] dcls_inject_fault_m0_c_user;
wire                                                    dcls_inject_fault_m0_c_valid;
wire                                                    dcls_inject_fault_m0_d_ready;
wire                       [((`NDS_TL_SINK_WIDTH)-1):0] dcls_inject_fault_m0_e_sink;
wire                                                    dcls_inject_fault_m0_e_valid;
wire                      [((`NDS_BIU_ADDR_WIDTH)-1):0] dcls_inject_fault_m1_a_address;
wire                                                    dcls_inject_fault_m1_a_corrupt;
wire                       [((`NDS_L2_DATA_WIDTH)-1):0] dcls_inject_fault_m1_a_data;
wire                     [((`NDS_L2_DATA_WIDTH)/8)-1:0] dcls_inject_fault_m1_a_mask;
wire                                              [2:0] dcls_inject_fault_m1_a_opcode;
wire                                              [2:0] dcls_inject_fault_m1_a_param;
wire                                              [2:0] dcls_inject_fault_m1_a_size;
wire                       [(`NDS_L2_SOURCE_WIDTH-1):0] dcls_inject_fault_m1_a_source;
wire                             [(`NDS_SCPU_A_UW-1):0] dcls_inject_fault_m1_a_user;
wire                                                    dcls_inject_fault_m1_a_valid;
wire                                                    dcls_inject_fault_m1_d_ready;
wire                      [((`NDS_BIU_ADDR_WIDTH)-1):0] dcls_inject_fault_m2_a_address;
wire                                                    dcls_inject_fault_m2_a_corrupt;
wire                       [((`NDS_L2_DATA_WIDTH)-1):0] dcls_inject_fault_m2_a_data;
wire                     [((`NDS_L2_DATA_WIDTH)/8)-1:0] dcls_inject_fault_m2_a_mask;
wire                                              [2:0] dcls_inject_fault_m2_a_opcode;
wire                                              [2:0] dcls_inject_fault_m2_a_param;
wire                                              [2:0] dcls_inject_fault_m2_a_size;
wire                       [(`NDS_L2_SOURCE_WIDTH-1):0] dcls_inject_fault_m2_a_source;
wire                             [(`NDS_SCPU_A_UW-1):0] dcls_inject_fault_m2_a_user;
wire                                                    dcls_inject_fault_m2_a_valid;
wire                                                    dcls_inject_fault_m2_d_ready;
wire                                                    dcls_inject_fault_meiack;
wire                                                    dcls_inject_fault_wfi_mode;
`endif // NDS_IO_DCLS
`ifdef NDS_IO_LM
wire                                                    lm_p_clk;
wire                                                    lm_r_clk;
`endif // NDS_IO_LM
`ifdef NDS_IO_DCLS_SPLIT
wire                                              [9:0] core1_meiid;
wire                                                    core1_meip;
wire                                                    core1_nmi;
wire                                      [(VALEN-1):0] core1_reset_vector;
wire                                                    core1_slv1_clk_en;
wire                                                    core1_slv_clk_en;
wire                                                    hart1_mtip;
wire                                                    core1_meiack;
wire                                                    core1_wfi_mode;
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_BUS_PROTECTION
wire                                              [7:0] core0_cfg_timeout_flash0;
wire                                              [7:0] core0_cfg_timeout_ppi;
wire                                              [7:0] core0_cfg_timeout_spp;
wire                                              [7:0] core0_cfg_timeout_sys0;
wire                      [((BIU_ADDR_CODE_WIDTH)-1):0] cluster_sys0_araddrcode;
wire                        [(BIU_CTRL_CODE_WIDTH-1):0] cluster_sys0_arctl0code;
wire                        [(BIU_CTRL_CODE_WIDTH-1):0] cluster_sys0_arctl1code;
wire                                              [4:0] cluster_sys0_aridcode;
wire                           [((BIU_UTID_WIDTH)-1):0] cluster_sys0_arutid;
wire                                                    cluster_sys0_arvalidcode;
wire                      [((BIU_ADDR_CODE_WIDTH)-1):0] cluster_sys0_awaddrcode;
wire                        [(BIU_CTRL_CODE_WIDTH-1):0] cluster_sys0_awctl0code;
wire                        [(BIU_CTRL_CODE_WIDTH-1):0] cluster_sys0_awctl1code;
wire                                              [4:0] cluster_sys0_awidcode;
wire                           [((BIU_UTID_WIDTH)-1):0] cluster_sys0_awutid;
wire                                                    cluster_sys0_awvalidcode;
wire                                                    cluster_sys0_breadycode;
wire                                                    cluster_sys0_rreadycode;
wire                           [(WCTRL_CODE_WIDTH-1):0] cluster_sys0_wctlcode;
wire                      [((BIU_DATA_CODE_WIDTH)-1):0] cluster_sys0_wdatacode;
wire                                                    cluster_sys0_weobi;
wire                           [((BIU_UTID_WIDTH)-1):0] cluster_sys0_wutid;
wire                                                    cluster_sys0_wvalidcode;
wire                                              [7:0] core0_fs_bus_m_protection_error;
wire                                                    cluster_sys0_arreadycode;
wire                                                    cluster_sys0_awreadycode;
wire                                              [2:0] cluster_sys0_bctlcode;
wire                                              [4:0] cluster_sys0_bidcode;
wire                           [((BIU_UTID_WIDTH)-1):0] cluster_sys0_butid;
wire                                                    cluster_sys0_bvalidcode;
wire                                              [2:0] cluster_sys0_rctlcode;
wire                      [((BIU_DATA_CODE_WIDTH)-1):0] cluster_sys0_rdatacode;
wire                                                    cluster_sys0_reobi;
wire                                              [4:0] cluster_sys0_ridcode;
wire                           [((BIU_UTID_WIDTH)-1):0] cluster_sys0_rutid;
wire                                                    cluster_sys0_rvalidcode;
wire                                                    cluster_sys0_wreadycode;
wire                                                    nds_unused_sys0_event_ctl_err; // dangler: () => ()
wire                                                    nds_unused_sys0_event_data_err; // dangler: () => ()
wire                                                    nds_unused_sys0_event_eobi_err; // dangler: () => ()
wire                                                    nds_unused_sys0_event_handshake_err; // dangler: () => ()
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_SLAVEPORT_COMMON_X2
wire                                                    nds_unused_core0_slv1_arready; // dangler: () => ()
wire                                                    nds_unused_core0_slv1_awready; // dangler: () => ()
wire                 [((`NDS_SLAVE_PORT_ID_WIDTH)-1):0] nds_unused_core0_slv1_bid; // dangler: () => ()
wire                                              [1:0] nds_unused_core0_slv1_bresp; // dangler: () => ()
wire                                                    nds_unused_core0_slv1_bvalid; // dangler: () => ()
wire               [((`NDS_SLAVE_PORT_DATA_WIDTH)-1):0] nds_unused_core0_slv1_rdata; // dangler: () => ()
wire                 [((`NDS_SLAVE_PORT_ID_WIDTH)-1):0] nds_unused_core0_slv1_rid; // dangler: () => ()
wire                                                    nds_unused_core0_slv1_rlast; // dangler: () => ()
wire                                              [1:0] nds_unused_core0_slv1_rresp; // dangler: () => ()
wire                                                    nds_unused_core0_slv1_rvalid; // dangler: () => ()
wire                                                    nds_unused_core0_slv1_wready; // dangler: () => ()
`endif // NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_EDC_AFTER_ECC
wire                                                    nds_unused_core0_fs_edc_error; // dangler: () => ()
`endif // NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_ILM_BOOT
wire                                                    ilm_boot;
`endif // NDS_IO_ILM_BOOT
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
wire                                       [ADDR_MSB:0] core0_slv_araddr;
wire                                              [1:0] core0_slv_arburst;
wire                                              [3:0] core0_slv_arcache;
wire                           [(SLVPORT_ID_WIDTH-1):0] core0_slv_arid;
wire                                              [7:0] core0_slv_arlen;
wire                                                    core0_slv_arlock;
wire                                              [2:0] core0_slv_arprot;
wire                                              [2:0] core0_slv_arsize;
wire                                                    core0_slv_aruser;
wire                                                    core0_slv_arvalid;
wire                                       [ADDR_MSB:0] core0_slv_awaddr;
wire                                              [1:0] core0_slv_awburst;
wire                                              [3:0] core0_slv_awcache;
wire                           [(SLVPORT_ID_WIDTH-1):0] core0_slv_awid;
wire                                              [7:0] core0_slv_awlen;
wire                                                    core0_slv_awlock;
wire                                              [2:0] core0_slv_awprot;
wire                                              [2:0] core0_slv_awsize;
wire                                                    core0_slv_awuser;
wire                                                    core0_slv_awvalid;
wire                                                    core0_slv_bready;
wire                                                    core0_slv_rready;
wire                         [(SLVPORT_DATA_WIDTH-1):0] core0_slv_wdata;
wire                                                    core0_slv_wlast;
wire                     [((SLVPORT_DATA_WIDTH/8)-1):0] core0_slv_wstrb;
wire                                                    core0_slv_wvalid;
wire                                                    core0_slv_arready;
wire                                                    core0_slv_awready;
wire                           [(SLVPORT_ID_WIDTH-1):0] core0_slv_bid;
wire                                              [1:0] core0_slv_bresp;
wire                                                    core0_slv_bvalid;
wire                         [(SLVPORT_DATA_WIDTH-1):0] core0_slv_rdata;
wire                           [(SLVPORT_ID_WIDTH-1):0] core0_slv_rid;
wire                                                    core0_slv_rlast;
wire                                              [1:0] core0_slv_rresp;
wire                                                    core0_slv_rvalid;
wire                                                    core0_slv_wready;
wire                                       [ADDR_MSB:0] busdec2slv_araddr;
wire                                              [1:0] busdec2slv_arburst;
wire                                              [3:0] busdec2slv_arcache;
wire                                              [7:0] busdec2slv_arlen;
wire                                                    busdec2slv_arlock;
wire                                              [2:0] busdec2slv_arprot;
wire                                              [2:0] busdec2slv_arsize;
wire                                       [ADDR_MSB:0] busdec2slv_awaddr;
wire                                              [1:0] busdec2slv_awburst;
wire                                              [3:0] busdec2slv_awcache;
wire                                              [7:0] busdec2slv_awlen;
wire                                                    busdec2slv_awlock;
wire                                              [2:0] busdec2slv_awprot;
wire                                              [2:0] busdec2slv_awsize;
wire                               [SLVPORT_DATA_MSB:0] busdec2slv_wdata;
wire                                                    busdec2slv_wlast;
wire                              [SLVPORT_WSTRB_MSB:0] busdec2slv_wstrb;
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
wire               [(((`NDS_SLV_ADDR_CODE_WIDTH))-1):0] core0_slv_araddrcode; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core0_slv_arctl0code; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core0_slv_arctl1code; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core0_slv_aridcode; // dangler: () <= ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] core0_slv_arutid; // dangler: () <= ()
wire                                                    core0_slv_arvalidcode; // dangler: () <= ()
wire               [(((`NDS_SLV_ADDR_CODE_WIDTH))-1):0] core0_slv_awaddrcode; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core0_slv_awctl0code; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core0_slv_awctl1code; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core0_slv_awidcode; // dangler: () <= ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] core0_slv_awutid; // dangler: () <= ()
wire                                                    core0_slv_awvalidcode; // dangler: () <= ()
wire                                                    core0_slv_breadycode; // dangler: () <= ()
wire                                                    core0_slv_rreadycode; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core0_slv_wctlcode; // dangler: () <= ()
wire               [(((`NDS_SLV_DATA_CODE_WIDTH))-1):0] core0_slv_wdatacode; // dangler: () <= ()
wire                                                    core0_slv_weobi; // dangler: () <= ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] core0_slv_wutid; // dangler: () <= ()
wire                                                    core0_slv_wvalidcode; // dangler: () <= ()
wire                                              [7:0] core0_fs_bus_s_protection_error; // dangler: () => ()
wire                                                    core0_slv_arreadycode; // dangler: () => ()
wire                                                    core0_slv_awreadycode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core0_slv_bctlcode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core0_slv_bidcode; // dangler: () => ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] core0_slv_butid; // dangler: () => ()
wire                                                    core0_slv_bvalidcode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core0_slv_rctlcode; // dangler: () => ()
wire               [(((`NDS_SLV_DATA_CODE_WIDTH))-1):0] core0_slv_rdatacode; // dangler: () => ()
wire                                                    core0_slv_reobi; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core0_slv_ridcode; // dangler: () => ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] core0_slv_rutid; // dangler: () => ()
wire                                                    core0_slv_rvalidcode; // dangler: () => ()
wire                                                    core0_slv_wreadycode; // dangler: () => ()
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X2
wire                                              [7:0] nds_unused_core0_fs_bus_s1_protection_error; // dangler: () => ()
wire                                                    nds_unused_core0_slv1_arreadycode; // dangler: () => ()
wire                                                    nds_unused_core0_slv1_awreadycode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] nds_unused_core0_slv1_bctlcode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] nds_unused_core0_slv1_bidcode; // dangler: () => ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] nds_unused_core0_slv1_butid; // dangler: () => ()
wire                                                    nds_unused_core0_slv1_bvalidcode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] nds_unused_core0_slv1_rctlcode; // dangler: () => ()
wire               [(((`NDS_SLV_DATA_CODE_WIDTH))-1):0] nds_unused_core0_slv1_rdatacode; // dangler: () => ()
wire                                                    nds_unused_core0_slv1_reobi; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] nds_unused_core0_slv1_ridcode; // dangler: () => ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] nds_unused_core0_slv1_rutid; // dangler: () => ()
wire                                                    nds_unused_core0_slv1_rvalidcode; // dangler: () => ()
wire                                                    nds_unused_core0_slv1_wreadycode; // dangler: () => ()
`endif // NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_IO_LM_RESET
wire                                                    core0_lm_reset_n;
`endif // NDS_IO_LM_RESET
`ifdef NDS_IO_ILM_TL_UL
wire                                 [ILM_TL_UL_EW-1:0] core0_ilm_a_parity0_in;
wire                                 [ILM_TL_UL_EW-1:0] core0_ilm_a_parity1_in;
wire                                              [7:0] core0_ilm_d_parity0;
wire                                              [7:0] core0_ilm_d_parity1;
wire                                                    core0_ilm_reset_n;
wire                                [(`NDS_ILM_AW)+2:3] core0_ilm_a_addr;
wire                                             [63:0] core0_ilm_a_data;
wire                                              [7:0] core0_ilm_a_mask;
wire                                              [2:0] core0_ilm_a_opcode;
wire                                              [7:0] core0_ilm_a_parity0;
wire                                              [7:0] core0_ilm_a_parity1;
wire                                              [2:0] core0_ilm_a_size;
wire                                              [1:0] core0_ilm_a_user; // dangler: () => ()
wire                                                    core0_ilm_a_valid;
wire                                                    core0_ilm_d_ready;
wire                                                    core0_ilm_ram_clk;
wire                                                    core0_ilm_ram_clk_en;
wire                             [ILM_TL_UL_RAM_AW-1:0] core0_ilm0_addr;
wire                           [ILM_TL_UL_RAM_BWEW-1:0] core0_ilm0_bwe;
wire                                                    core0_ilm0_cs;
wire                             [ILM_TL_UL_RAM_DW-1:0] core0_ilm0_wdata;
wire                                                    core0_ilm0_we;
wire                             [ILM_TL_UL_RAM_AW-1:0] core0_ilm1_addr;
wire                           [ILM_TL_UL_RAM_BWEW-1:0] core0_ilm1_bwe;
wire                                                    core0_ilm1_cs;
wire                             [ILM_TL_UL_RAM_DW-1:0] core0_ilm1_wdata;
wire                                                    core0_ilm1_we;
wire                                                    core0_ilm_a_ready;
wire                                             [63:0] core0_ilm_d_data;
wire                                                    core0_ilm_d_denied;
wire                                 [ILM_TL_UL_EW-1:0] core0_ilm_d_parity0_out;
wire                                 [ILM_TL_UL_EW-1:0] core0_ilm_d_parity1_out;
wire                                                    core0_ilm_d_valid;
wire                             [ILM_TL_UL_RAM_DW-1:0] core0_ilm0_rdata;
wire                             [ILM_TL_UL_RAM_DW-1:0] core0_ilm1_rdata;
`endif // NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DLM_TL_UL
wire                                                    core0_dlm_reset_n;
wire                      [`NDS_DLM_AMSB:`NDS_DLM_ALSB] core0_dlm_a_addr;
wire                                  [(`NDS_XLEN-1):0] core0_dlm_a_data;
wire                                [(`NDS_XLEN/8)-1:0] core0_dlm_a_mask;
wire                                              [2:0] core0_dlm_a_opcode;
wire                                              [7:0] core0_dlm_a_parity;
wire                                              [2:0] core0_dlm_a_size;
wire                                              [1:0] core0_dlm_a_user;
wire                                                    core0_dlm_a_valid;
wire                                                    core0_dlm_d_ready;
wire                                                    core0_dlm_a_ready;
wire                                  [(`NDS_XLEN-1):0] core0_dlm_d_data;
wire                                                    core0_dlm_d_denied;
wire                                              [7:0] core0_dlm_d_parity;
wire                                                    core0_dlm_d_valid;
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_ICACHE0
wire                                                    core0_icache_disable_init;
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCACHE0
wire                                                    core0_dcache_disable_init;
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_SEIP
wire                                              [9:0] core0_seiid;
wire                                                    core0_seip;
wire                                                    core0_seiack;
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
wire                                                    core0_ueip;
wire                                                    nds_unused_core0_ueiack; // dangler: () => ()
`endif // NDS_IO_UEIP
`ifdef NDS_IO_DEBUG
wire                                                    core0_debugint;
wire                                                    core0_resethaltreq;
wire                                                    core0_hart_halted;
wire                                                    core0_hart_unavail;
wire                                                    core0_hart_under_reset;
wire                                                    core0_stoptime;
`endif // NDS_IO_DEBUG
`ifdef NDS_IO_TRAP_STATUS
wire                                                    nds_unused_core0_fs_halt_mode; // dangler: () => ()
wire                                              [9:0] nds_unused_core0_fs_trap_status_cause; // dangler: () => ()
wire                                              [2:0] nds_unused_core0_fs_trap_status_dcause; // dangler: () => ()
wire                                                    nds_unused_core0_fs_trap_status_interrupt; // dangler: () => ()
wire                                                    nds_unused_core0_fs_trap_status_nmi; // dangler: () => ()
wire                                                    nds_unused_core0_fs_trap_status_taken; // dangler: () => ()
`endif // NDS_IO_TRAP_STATUS
`ifdef NDS_IO_PPI
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core0_axi_rf_araddr;
wire                                              [1:0] core0_axi_rf_arburst;
wire                                              [3:0] core0_axi_rf_arcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_axi_rf_arid;
wire                                              [7:0] core0_axi_rf_arlen;
wire                                                    core0_axi_rf_arlock;
wire                                              [2:0] core0_axi_rf_arprot;
wire                                              [2:0] core0_axi_rf_arsize;
wire                                                    core0_axi_rf_arvalid;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core0_axi_rf_awaddr;
wire                                              [1:0] core0_axi_rf_awburst;
wire                                              [3:0] core0_axi_rf_awcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_axi_rf_awid;
wire                                              [7:0] core0_axi_rf_awlen;
wire                                                    core0_axi_rf_awlock;
wire                                              [2:0] core0_axi_rf_awprot;
wire                                              [2:0] core0_axi_rf_awsize;
wire                                                    core0_axi_rf_awvalid;
wire                                                    core0_axi_rf_bready;
wire                                                    core0_axi_rf_rready;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core0_axi_rf_wdata;
wire                                                    core0_axi_rf_wlast;
wire                      [(`NDS_PPI_DATA_WIDTH/8)-1:0] core0_axi_rf_wstrb;
wire                                                    core0_axi_rf_wvalid;
wire                                                    core0_ppi_arready;
wire                                                    core0_ppi_awready;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_bid;
wire                                              [1:0] core0_ppi_bresp;
wire                                                    core0_ppi_bvalid;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core0_ppi_rdata;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_rid;
wire                                                    core0_ppi_rlast;
wire                                              [1:0] core0_ppi_rresp;
wire                                                    core0_ppi_rvalid;
wire                                                    core0_ppi_wready;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core0_ppi_araddr;
wire                                              [1:0] core0_ppi_arburst;
wire                                              [3:0] core0_ppi_arcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_arid;
wire                                              [7:0] core0_ppi_arlen;
wire                                                    core0_ppi_arlock;
wire                                              [2:0] core0_ppi_arprot;
wire                                              [2:0] core0_ppi_arsize;
wire                                                    core0_ppi_arvalid;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core0_ppi_awaddr;
wire                                              [1:0] core0_ppi_awburst;
wire                                              [3:0] core0_ppi_awcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_awid;
wire                                              [7:0] core0_ppi_awlen;
wire                                                    core0_ppi_awlock;
wire                                              [2:0] core0_ppi_awprot;
wire                                              [2:0] core0_ppi_awsize;
wire                                                    core0_ppi_awvalid;
wire                                                    core0_ppi_bready;
wire                                                    core0_ppi_rready;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core0_ppi_wdata;
wire                                                    core0_ppi_wlast;
wire                      [(`NDS_PPI_DATA_WIDTH/8)-1:0] core0_ppi_wstrb;
wire                                                    core0_ppi_wvalid;
wire                                                    core0_axi_rf_arready;
wire                                                    core0_axi_rf_awready;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_axi_rf_bid;
wire                                              [1:0] core0_axi_rf_bresp;
wire                                                    core0_axi_rf_bvalid;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core0_axi_rf_rdata;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_axi_rf_rid;
wire                                                    core0_axi_rf_rlast;
wire                                              [1:0] core0_axi_rf_rresp;
wire                                                    core0_axi_rf_rvalid;
wire                                                    core0_axi_rf_wready;
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
wire                                                    core0_ppi_arreadycode;
wire                                                    core0_ppi_awreadycode;
wire                                              [2:0] core0_ppi_bctlcode;
wire                                              [4:0] core0_ppi_bidcode;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core0_ppi_butid;
wire                                                    core0_ppi_bvalidcode;
wire                                                    core0_ppi_ingress_ds_arready;
wire                                                    core0_ppi_ingress_ds_awready;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_ingress_ds_bid;
wire                                              [1:0] core0_ppi_ingress_ds_bresp;
wire                                                    core0_ppi_ingress_ds_bvalid;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core0_ppi_ingress_ds_rdata;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_ingress_ds_rid;
wire                                                    core0_ppi_ingress_ds_rlast;
wire                                              [1:0] core0_ppi_ingress_ds_rresp;
wire                                                    core0_ppi_ingress_ds_rvalid;
wire                                                    core0_ppi_ingress_ds_wready;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core0_ppi_ingress_us_araddr;
wire                     [`NDS_BIU_ADDR_CODE_WIDTH-1:0] core0_ppi_ingress_us_araddrcode;
wire                                              [1:0] core0_ppi_ingress_us_arburst;
wire                                              [3:0] core0_ppi_ingress_us_arcache;
wire                                              [4:0] core0_ppi_ingress_us_arctl0code;
wire                                              [4:0] core0_ppi_ingress_us_arctl1code;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_ingress_us_arid;
wire                                              [4:0] core0_ppi_ingress_us_aridcode;
wire                                              [7:0] core0_ppi_ingress_us_arlen;
wire                                                    core0_ppi_ingress_us_arlock;
wire                                              [2:0] core0_ppi_ingress_us_arprot;
wire                                              [2:0] core0_ppi_ingress_us_arsize;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core0_ppi_ingress_us_arutid;
wire                                                    core0_ppi_ingress_us_arvalid;
wire                                                    core0_ppi_ingress_us_arvalidcode;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core0_ppi_ingress_us_awaddr;
wire                     [`NDS_BIU_ADDR_CODE_WIDTH-1:0] core0_ppi_ingress_us_awaddrcode;
wire                                              [1:0] core0_ppi_ingress_us_awburst;
wire                                              [3:0] core0_ppi_ingress_us_awcache;
wire                                              [4:0] core0_ppi_ingress_us_awctl0code;
wire                                              [4:0] core0_ppi_ingress_us_awctl1code;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_ingress_us_awid;
wire                                              [4:0] core0_ppi_ingress_us_awidcode;
wire                                              [7:0] core0_ppi_ingress_us_awlen;
wire                                                    core0_ppi_ingress_us_awlock;
wire                                              [2:0] core0_ppi_ingress_us_awprot;
wire                                              [2:0] core0_ppi_ingress_us_awsize;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core0_ppi_ingress_us_awutid;
wire                                                    core0_ppi_ingress_us_awvalid;
wire                                                    core0_ppi_ingress_us_awvalidcode;
wire                                                    core0_ppi_ingress_us_bready;
wire                                                    core0_ppi_ingress_us_breadycode;
wire                                                    core0_ppi_ingress_us_rready;
wire                                                    core0_ppi_ingress_us_rreadycode;
wire                                              [4:0] core0_ppi_ingress_us_wctlcode;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core0_ppi_ingress_us_wdata;
wire                     [`NDS_PPI_DATA_CODE_WIDTH-1:0] core0_ppi_ingress_us_wdatacode;
wire                                                    core0_ppi_ingress_us_weobi;
wire                                                    core0_ppi_ingress_us_wlast;
wire                      [(`NDS_PPI_DATA_WIDTH/8)-1:0] core0_ppi_ingress_us_wstrb;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core0_ppi_ingress_us_wutid;
wire                                                    core0_ppi_ingress_us_wvalid;
wire                                                    core0_ppi_ingress_us_wvalidcode;
wire                                              [2:0] core0_ppi_rctlcode;
wire                     [`NDS_PPI_DATA_CODE_WIDTH-1:0] core0_ppi_rdatacode;
wire                                                    core0_ppi_reobi;
wire                                              [4:0] core0_ppi_ridcode;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core0_ppi_rutid;
wire                                                    core0_ppi_rvalidcode;
wire                                                    core0_ppi_wreadycode;
wire                     [`NDS_BIU_ADDR_CODE_WIDTH-1:0] core0_ppi_araddrcode;
wire                                              [4:0] core0_ppi_arctl0code;
wire                                              [4:0] core0_ppi_arctl1code;
wire                                              [4:0] core0_ppi_aridcode;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core0_ppi_arutid;
wire                                                    core0_ppi_arvalidcode;
wire                     [`NDS_BIU_ADDR_CODE_WIDTH-1:0] core0_ppi_awaddrcode;
wire                                              [4:0] core0_ppi_awctl0code;
wire                                              [4:0] core0_ppi_awctl1code;
wire                                              [4:0] core0_ppi_awidcode;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core0_ppi_awutid;
wire                                                    core0_ppi_awvalidcode;
wire                                                    core0_ppi_breadycode;
wire                                                    core0_ppi_rreadycode;
wire                                              [4:0] core0_ppi_wctlcode;
wire                     [`NDS_PPI_DATA_CODE_WIDTH-1:0] core0_ppi_wdatacode;
wire                                                    core0_ppi_weobi;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core0_ppi_wutid;
wire                                                    core0_ppi_wvalidcode;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core0_ppi_ingress_ds_araddr;
wire                                              [1:0] core0_ppi_ingress_ds_arburst;
wire                                              [3:0] core0_ppi_ingress_ds_arcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_ingress_ds_arid;
wire                                              [7:0] core0_ppi_ingress_ds_arlen;
wire                                                    core0_ppi_ingress_ds_arlock;
wire                                              [2:0] core0_ppi_ingress_ds_arprot;
wire                                              [2:0] core0_ppi_ingress_ds_arsize;
wire                                                    core0_ppi_ingress_ds_arvalid;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core0_ppi_ingress_ds_awaddr;
wire                                              [1:0] core0_ppi_ingress_ds_awburst;
wire                                              [3:0] core0_ppi_ingress_ds_awcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_ingress_ds_awid;
wire                                              [7:0] core0_ppi_ingress_ds_awlen;
wire                                                    core0_ppi_ingress_ds_awlock;
wire                                              [2:0] core0_ppi_ingress_ds_awprot;
wire                                              [2:0] core0_ppi_ingress_ds_awsize;
wire                                                    core0_ppi_ingress_ds_awvalid;
wire                                                    core0_ppi_ingress_ds_bready;
wire                                                    core0_ppi_ingress_ds_rready;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core0_ppi_ingress_ds_wdata;
wire                                                    core0_ppi_ingress_ds_wlast;
wire                      [(`NDS_PPI_DATA_WIDTH/8)-1:0] core0_ppi_ingress_ds_wstrb;
wire                                                    core0_ppi_ingress_ds_wvalid;
wire                                                    core0_ppi_ingress_us_arready;
wire                                                    core0_ppi_ingress_us_arreadycode;
wire                                                    core0_ppi_ingress_us_awready;
wire                                                    core0_ppi_ingress_us_awreadycode;
wire                                              [2:0] core0_ppi_ingress_us_bctlcode;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_ingress_us_bid;
wire                                              [4:0] core0_ppi_ingress_us_bidcode;
wire                                              [1:0] core0_ppi_ingress_us_bresp;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core0_ppi_ingress_us_butid;
wire                                                    core0_ppi_ingress_us_bvalid;
wire                                                    core0_ppi_ingress_us_bvalidcode;
wire                                              [2:0] core0_ppi_ingress_us_rctlcode;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core0_ppi_ingress_us_rdata;
wire                     [`NDS_PPI_DATA_CODE_WIDTH-1:0] core0_ppi_ingress_us_rdatacode;
wire                                                    core0_ppi_ingress_us_reobi;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core0_ppi_ingress_us_rid;
wire                                              [4:0] core0_ppi_ingress_us_ridcode;
wire                                                    core0_ppi_ingress_us_rlast;
wire                                              [1:0] core0_ppi_ingress_us_rresp;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core0_ppi_ingress_us_rutid;
wire                                                    core0_ppi_ingress_us_rvalid;
wire                                                    core0_ppi_ingress_us_rvalidcode;
wire                                                    core0_ppi_ingress_us_wready;
wire                                                    core0_ppi_ingress_us_wreadycode;
wire                                                    nds_unused_ppi0_event_ctl_err; // dangler: () => ()
wire                                                    nds_unused_ppi0_event_data_err; // dangler: () => ()
wire                                                    nds_unused_ppi0_event_eobi_err; // dangler: () => ()
wire                                                    nds_unused_ppi0_event_handshake_err; // dangler: () => ()
`endif // NDS_IO_PPI_PROT
`ifdef NDS_IO_LM_QOS
wire                                              [3:0] core0_ifu_ilm_qos;
wire                                              [3:0] core0_lsu_dlm_qos;
wire                                              [3:0] core0_lsu_ilm_qos;
`endif // NDS_IO_LM_QOS
`ifdef NDS_IO_SLAVEPORT_QOS_X1
wire                                              [3:0] core0_slv_arqos;
wire                                              [3:0] core0_slv_awqos;
`endif // NDS_IO_SLAVEPORT_QOS_X1
`ifdef NDS_IO_ICACHE0_CTRL_OUT
wire         [(`NDS_ICACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_tag0_ctrl_out; // dangler: () => ()
`endif // NDS_IO_ICACHE0_CTRL_OUT
`ifdef NDS_IO_ICACHE1_CTRL_OUT
wire         [(`NDS_ICACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_tag1_ctrl_out; // dangler: () => ()
`endif // NDS_IO_ICACHE1_CTRL_OUT
`ifdef NDS_IO_ICACHE2_CTRL_OUT
wire         [(`NDS_ICACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_tag2_ctrl_out; // dangler: () => ()
wire         [(`NDS_ICACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_tag3_ctrl_out; // dangler: () => ()
`endif // NDS_IO_ICACHE2_CTRL_OUT
`ifdef NDS_IO_BTB_RAM_CTRL_OUT
wire                [(`NDS_BTB_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_core0_btb0_ctrl_out; // dangler: () => ()
wire                [(`NDS_BTB_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_core0_btb1_ctrl_out; // dangler: () => ()
`endif // NDS_IO_BTB_RAM_CTRL_OUT
`ifdef NDS_IO_BTB2_RAM_CTRL_OUT
wire                [(`NDS_BTB_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_core0_btb2_ctrl_out; // dangler: () => ()
`endif // NDS_IO_BTB2_RAM_CTRL_OUT
`ifdef NDS_IO_BTB3_RAM_CTRL_OUT
wire                [(`NDS_BTB_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_core0_btb3_ctrl_out; // dangler: () => ()
`endif // NDS_IO_BTB3_RAM_CTRL_OUT
`ifdef NDS_IO_FLASHIF0
wire                           [((BIU_ADDR_WIDTH)-1):0] cluster_flash0_araddr;
wire                                              [1:0] cluster_flash0_arburst;
wire                                              [3:0] cluster_flash0_arcache;
wire                        [((FLASHIF0_ID_WIDTH)-1):0] cluster_flash0_arid;
wire                                              [7:0] cluster_flash0_arlen;
wire                                                    cluster_flash0_arlock;
wire                                              [2:0] cluster_flash0_arprot;
wire                                              [2:0] cluster_flash0_arsize;
wire                                                    cluster_flash0_arvalid;
wire                           [((BIU_ADDR_WIDTH)-1):0] cluster_flash0_awaddr;
wire                                              [1:0] cluster_flash0_awburst;
wire                                              [3:0] cluster_flash0_awcache;
wire                        [((FLASHIF0_ID_WIDTH)-1):0] cluster_flash0_awid;
wire                                              [7:0] cluster_flash0_awlen;
wire                                                    cluster_flash0_awlock;
wire                                              [2:0] cluster_flash0_awprot;
wire                                              [2:0] cluster_flash0_awsize;
wire                                                    cluster_flash0_awvalid;
wire                                                    cluster_flash0_bready;
wire                                                    cluster_flash0_rready;
wire                           [((BIU_DATA_WIDTH)-1):0] cluster_flash0_wdata;
wire                                                    cluster_flash0_wlast;
wire                         [((BIU_DATA_WIDTH)/8)-1:0] cluster_flash0_wstrb;
wire                                                    cluster_flash0_wvalid;
wire                                                    cluster_flash0_arready;
wire                                                    cluster_flash0_awready;
wire                        [((FLASHIF0_ID_WIDTH)-1):0] cluster_flash0_bid;
wire                                              [1:0] cluster_flash0_bresp;
wire                                                    cluster_flash0_bvalid;
wire                           [((BIU_DATA_WIDTH)-1):0] cluster_flash0_rdata;
wire                        [((FLASHIF0_ID_WIDTH)-1):0] cluster_flash0_rid;
wire                                                    cluster_flash0_rlast;
wire                                              [1:0] cluster_flash0_rresp;
wire                                                    cluster_flash0_rvalid;
wire                                                    cluster_flash0_wready;
`endif // NDS_IO_FLASHIF0
`ifdef NDS_IO_SPP
wire                                                    axi_spp_arready;
wire                                                    axi_spp_awready;
wire                      [(((`NDS_SPP_ID_WIDTH))-1):0] axi_spp_bid;
wire                                              [1:0] axi_spp_bresp;
wire                                                    axi_spp_bvalid;
wire                    [(((`NDS_SPP_DATA_WIDTH))-1):0] axi_spp_rdata;
wire                      [(((`NDS_SPP_ID_WIDTH))-1):0] axi_spp_rid;
wire                                                    axi_spp_rlast;
wire                                              [1:0] axi_spp_rresp;
wire                                                    axi_spp_rvalid;
wire                                                    axi_spp_wready;
wire                        [(`NDS_BIU_ADDR_WIDTH-1):0] spp_araddr;
wire                                              [1:0] spp_arburst;
wire                                              [3:0] spp_arcache;
wire                          [(`NDS_SPP_ID_WIDTH-1):0] spp_arid;
wire                                              [7:0] spp_arlen;
wire                                                    spp_arlock;
wire                                              [2:0] spp_arprot;
wire                                              [2:0] spp_arsize;
wire                                                    spp_arvalid;
wire                        [(`NDS_BIU_ADDR_WIDTH-1):0] spp_awaddr;
wire                                              [1:0] spp_awburst;
wire                                              [3:0] spp_awcache;
wire                          [(`NDS_SPP_ID_WIDTH-1):0] spp_awid;
wire                                              [7:0] spp_awlen;
wire                                                    spp_awlock;
wire                                              [2:0] spp_awprot;
wire                                              [2:0] spp_awsize;
wire                                                    spp_awvalid;
wire                                                    spp_bready;
wire                                                    spp_rready;
wire                        [(`NDS_SPP_DATA_WIDTH-1):0] spp_wdata;
wire                                                    spp_wlast;
wire                        [`NDS_SPP_DATA_WIDTH/8-1:0] spp_wstrb;
wire                                                    spp_wvalid;
wire                               [((ADDR_WIDTH)-1):0] axi_spp_araddr;
wire                                              [1:0] axi_spp_arburst;
wire                                              [3:0] axi_spp_arcache;
wire                      [(((`NDS_SPP_ID_WIDTH))-1):0] axi_spp_arid;
wire                                              [7:0] axi_spp_arlen;
wire                                                    axi_spp_arlock;
wire                                              [2:0] axi_spp_arprot;
wire                                              [2:0] axi_spp_arsize;
wire                                                    axi_spp_arvalid;
wire                               [((ADDR_WIDTH)-1):0] axi_spp_awaddr;
wire                                              [1:0] axi_spp_awburst;
wire                                              [3:0] axi_spp_awcache;
wire                      [(((`NDS_SPP_ID_WIDTH))-1):0] axi_spp_awid;
wire                                              [7:0] axi_spp_awlen;
wire                                                    axi_spp_awlock;
wire                                              [2:0] axi_spp_awprot;
wire                                              [2:0] axi_spp_awsize;
wire                                                    axi_spp_awvalid;
wire                                                    axi_spp_bready;
wire                                                    axi_spp_rready;
wire                    [(((`NDS_SPP_DATA_WIDTH))-1):0] axi_spp_wdata;
wire                                                    axi_spp_wlast;
wire                  [(((`NDS_SPP_DATA_WIDTH))/8)-1:0] axi_spp_wstrb;
wire                                                    axi_spp_wvalid;
wire                                                    spp_arready;
wire                                                    spp_awready;
wire                          [(`NDS_SPP_ID_WIDTH-1):0] spp_bid;
wire                                              [1:0] spp_bresp;
wire                                                    spp_bvalid;
wire                        [(`NDS_SPP_DATA_WIDTH-1):0] spp_rdata;
wire                          [(`NDS_SPP_ID_WIDTH-1):0] spp_rid;
wire                                                    spp_rlast;
wire                                              [1:0] spp_rresp;
wire                                                    spp_rvalid;
wire                                                    spp_wready;
`else
wire                                   [BIU_ID_MSB+4:0] sdn_arid;
wire                                                    sdn_arready;
wire                                   [BIU_ID_MSB+4:0] sdn_awid;
wire                                                    sdn_awready;
wire                                   [BIU_ID_MSB+4:0] sdn_bid;
wire                                              [1:0] sdn_bresp;
wire                                                    sdn_bvalid;
wire                                   [NCE_DATA_MSB:0] sdn_rdata;
wire                                   [BIU_ID_MSB+4:0] sdn_rid;
wire                                                    sdn_rlast;
wire                                              [1:0] sdn_rresp;
wire                                                    sdn_rvalid;
wire                                                    sdn_wready;
wire                                       [ADDR_MSB:0] sdn_araddr;
wire                                              [1:0] sdn_arburst;
wire                                              [3:0] sdn_arcache;
wire                                              [7:0] sdn_arlen;
wire                                                    sdn_arlock;
wire                                              [2:0] sdn_arprot;
wire                                              [2:0] sdn_arsize;
wire                                                    sdn_arvalid;
wire                                       [ADDR_MSB:0] sdn_awaddr;
wire                                              [1:0] sdn_awburst;
wire                                              [3:0] sdn_awcache;
wire                                              [7:0] sdn_awlen;
wire                                                    sdn_awlock;
wire                                              [2:0] sdn_awprot;
wire                                              [2:0] sdn_awsize;
wire                                                    sdn_awvalid;
wire                                                    sdn_bready;
wire                                                    sdn_rready;
wire                                   [NCE_DATA_MSB:0] sdn_wdata;
wire                                                    sdn_wlast;
wire                                  [NCE_WSTRB_MSB:0] sdn_wstrb;
wire                                                    sdn_wvalid;
`endif // NDS_IO_SPP
`ifdef ATCBMC301_SLV2_SUPPORT
wire                                              [3:0] sys_exmon_bid_dummy;
wire                                              [3:0] sys_exmon_rid_dummy;
`endif // ATCBMC301_SLV2_SUPPORT
`ifdef ATCBMC301_SLV3_SUPPORT
wire                                              [3:0] flash0_bid_dummy;
wire                                              [3:0] flash0_rid_dummy;
wire                                              [3:0] flash0_arid_dummy;
wire                                              [3:0] flash0_awid_dummy;
`endif // ATCBMC301_SLV3_SUPPORT
`ifdef ATCBMC301_MST1_SUPPORT
wire                                 [BIU_ID_WIDTH-1:0] axi_flash0_arid;
wire                                 [BIU_ID_WIDTH-1:0] axi_flash0_awid;
wire                                                    axi_flash0_arready;
wire                                                    axi_flash0_awready;
wire                                 [BIU_ID_WIDTH-1:0] axi_flash0_bid;
wire                                              [1:0] axi_flash0_bresp;
wire                                                    axi_flash0_bvalid;
wire                           [((BIU_DATA_WIDTH)-1):0] axi_flash0_rdata;
wire                                 [BIU_ID_WIDTH-1:0] axi_flash0_rid;
wire                                                    axi_flash0_rlast;
wire                                              [1:0] axi_flash0_rresp;
wire                                                    axi_flash0_rvalid;
wire                                                    axi_flash0_wready;
wire                               [((ADDR_WIDTH)-1):0] axi_flash0_araddr;
wire                                              [1:0] axi_flash0_arburst;
wire                                              [3:0] axi_flash0_arcache;
wire                                              [7:0] axi_flash0_arlen;
wire                                                    axi_flash0_arlock;
wire                                              [2:0] axi_flash0_arprot;
wire                                              [2:0] axi_flash0_arsize;
wire                                                    axi_flash0_arvalid;
wire                               [((ADDR_WIDTH)-1):0] axi_flash0_awaddr;
wire                                              [1:0] axi_flash0_awburst;
wire                                              [3:0] axi_flash0_awcache;
wire                                              [7:0] axi_flash0_awlen;
wire                                                    axi_flash0_awlock;
wire                                              [2:0] axi_flash0_awprot;
wire                                              [2:0] axi_flash0_awsize;
wire                                                    axi_flash0_awvalid;
wire                                                    axi_flash0_bready;
wire                                                    axi_flash0_rready;
wire                           [((BIU_DATA_WIDTH)-1):0] axi_flash0_wdata;
wire                                                    axi_flash0_wlast;
wire                         [((BIU_DATA_WIDTH)/8)-1:0] axi_flash0_wstrb;
wire                                                    axi_flash0_wvalid;
`endif // ATCBMC301_MST1_SUPPORT
`ifdef PLATFORM_DEBUG_SUBSYSTEM
wire                                       [ADDR_MSB:0] dm_araddr;
wire                                              [1:0] dm_arburst;
wire                                              [3:0] dm_arcache;
wire                                              [7:0] dm_arlen;
wire                                                    dm_arlock;
wire                                              [2:0] dm_arprot;
wire                                              [2:0] dm_arsize;
wire                                       [ADDR_MSB:0] dm_awaddr;
wire                                              [1:0] dm_awburst;
wire                                              [3:0] dm_awcache;
wire                                              [7:0] dm_awlen;
wire                                                    dm_awlock;
wire                                              [2:0] dm_awprot;
wire                                              [2:0] dm_awsize;
wire                                              [1:0] dm_sup_bresp;
wire                                   [NCE_DATA_MSB:0] dm_wdata;
wire                                                    dm_wlast;
wire                                  [NCE_WSTRB_MSB:0] dm_wstrb;
wire                                                    dm_arvalid;
wire                                                    dm_awvalid;
wire                                                    dm_bready;
wire                                                    dm_rready;
wire                                                    dm_wvalid;
wire                                                    dm_sup_arready;
wire                                                    dm_sup_awready;
wire                                     [BIU_ID_MSB:0] dm_sup_bid;
wire                                                    dm_sup_bvalid;
wire                                [DM_SYS_DATA_MSB:0] dm_sup_rdata;
wire                                     [BIU_ID_MSB:0] dm_sup_rid;
wire                                                    dm_sup_rlast;
wire                                              [1:0] dm_sup_rresp;
wire                                                    dm_sup_rvalid;
wire                                                    dm_sup_wready;
wire                                                    dm_arready;
wire                                                    dm_awready;
wire                                              [1:0] dm_bresp;
wire                                                    dm_bvalid;
wire                                   [NCE_DATA_MSB:0] dm_rdata;
wire                                                    dm_rlast;
wire                                              [1:0] dm_rresp;
wire                                                    dm_rvalid;
wire                                       [ADDR_MSB:0] dm_sup_araddr;
wire                                              [1:0] dm_sup_arburst;
wire                                              [3:0] dm_sup_arcache;
wire                                     [BIU_ID_MSB:0] dm_sup_arid;
wire                                              [7:0] dm_sup_arlen;
wire                                                    dm_sup_arlock;
wire                                              [2:0] dm_sup_arprot;
wire                                              [2:0] dm_sup_arsize;
wire                                                    dm_sup_arvalid;
wire                                       [ADDR_MSB:0] dm_sup_awaddr;
wire                                              [1:0] dm_sup_awburst;
wire                                              [3:0] dm_sup_awcache;
wire                                     [BIU_ID_MSB:0] dm_sup_awid;
wire                                              [7:0] dm_sup_awlen;
wire                                                    dm_sup_awlock;
wire                                              [2:0] dm_sup_awprot;
wire                                              [2:0] dm_sup_awsize;
wire                                                    dm_sup_awvalid;
wire                                                    dm_sup_bready;
wire                                                    dm_sup_rready;
wire                                [DM_SYS_DATA_MSB:0] dm_sup_wdata;
wire                                                    dm_sup_wlast;
wire                               [DM_SYS_WSTRB_MSB:0] dm_sup_wstrb;
wire                                                    dm_sup_wvalid;
wire                                                    dm_wready;
wire                                                    ndmreset;
wire                                              [3:0] nds_unused_dm_bid; // dangler: () => ()
wire                             [(NCE_DATA_WIDTH-1):0] nds_unused_dm_hrdata; // dangler: () => ()
wire                                                    nds_unused_dm_hreadyout; // dangler: () => ()
wire                                              [1:0] nds_unused_dm_hresp; // dangler: () => ()
wire                                              [3:0] nds_unused_dm_rid; // dangler: () => ()
wire                                 [(ADDR_WIDTH-1):0] nds_unused_dm_sup_haddr; // dangler: () => ()
wire                                              [2:0] nds_unused_dm_sup_hburst; // dangler: () => ()
wire                                                    nds_unused_dm_sup_hbusreq; // dangler: () => ()
wire                                              [3:0] nds_unused_dm_sup_hprot; // dangler: () => ()
wire                                              [2:0] nds_unused_dm_sup_hsize; // dangler: () => ()
wire                                              [1:0] nds_unused_dm_sup_htrans; // dangler: () => ()
wire                          [(DM_SYS_DATA_WIDTH-1):0] nds_unused_dm_sup_hwdata; // dangler: () => ()
wire                                                    nds_unused_dm_sup_hwrite; // dangler: () => ()
wire                                 [DMXTRIGGER_MSB:0] nds_unused_xtrigger_halt_out; // dangler: () => ()
wire                                 [DMXTRIGGER_MSB:0] nds_unused_xtrigger_resume_out; // dangler: () => ()
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef PLATFORM_NO_PLIC_SW
`else
wire                                              [3:0] nds_unused_plicsw_bid; // dangler: () => ()
wire                             [(NCE_DATA_WIDTH-1):0] nds_unused_plicsw_hrdata; // dangler: () => ()
wire                                                    nds_unused_plicsw_hreadyout; // dangler: () => ()
wire                                              [1:0] nds_unused_plicsw_hresp; // dangler: () => ()
wire                                              [3:0] nds_unused_plicsw_rid; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t0_eiid; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t10_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t10_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t11_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t11_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t12_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t12_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t13_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t13_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t14_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t14_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t15_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t15_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t1_eiid; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t2_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t2_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t3_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t3_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t4_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t4_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t5_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t5_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t6_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t6_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t7_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t7_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t8_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t8_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plicsw_t9_eiid; // dangler: () => ()
wire                                                    nds_unused_plicsw_t9_eip; // dangler: () => ()
`endif // PLATFORM_NO_PLIC_SW
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_LM
wire                                                    core1_lm_clk;
wire                                                    dcls_inject_fault_lm_local_int;
   `endif // NDS_IO_LM
   `ifdef NDS_IO_SLAVEPORT_COMMON_X2
wire                                                    dcls_inject_fault_slv1_arready;
wire                                                    dcls_inject_fault_slv1_awready;
wire                 [((`NDS_SLAVE_PORT_ID_WIDTH)-1):0] dcls_inject_fault_slv1_bid;
wire                                              [1:0] dcls_inject_fault_slv1_bresp;
wire                                                    dcls_inject_fault_slv1_bvalid;
wire               [((`NDS_SLAVE_PORT_DATA_WIDTH)-1):0] dcls_inject_fault_slv1_rdata;
wire                 [((`NDS_SLAVE_PORT_ID_WIDTH)-1):0] dcls_inject_fault_slv1_rid;
wire                                                    dcls_inject_fault_slv1_rlast;
wire                                              [1:0] dcls_inject_fault_slv1_rresp;
wire                                                    dcls_inject_fault_slv1_rvalid;
wire                                                    dcls_inject_fault_slv1_wready;
   `endif // NDS_IO_SLAVEPORT_COMMON_X2
   `ifdef NDS_IO_EDC_AFTER_ECC
wire                                                    dcls_inject_fault_fs_edc_error;
   `endif // NDS_IO_EDC_AFTER_ECC
   `ifdef NDS_IO_SLAVEPORT_COMMON_X1
wire                                                    dcls_inject_fault_slv_arready;
wire                                                    dcls_inject_fault_slv_awready;
wire                 [((`NDS_SLAVE_PORT_ID_WIDTH)-1):0] dcls_inject_fault_slv_bid;
wire                                              [1:0] dcls_inject_fault_slv_bresp;
wire                                                    dcls_inject_fault_slv_bvalid;
wire               [((`NDS_SLAVE_PORT_DATA_WIDTH)-1):0] dcls_inject_fault_slv_rdata;
wire                 [((`NDS_SLAVE_PORT_ID_WIDTH)-1):0] dcls_inject_fault_slv_rid;
wire                                                    dcls_inject_fault_slv_rlast;
wire                                              [1:0] dcls_inject_fault_slv_rresp;
wire                                                    dcls_inject_fault_slv_rvalid;
wire                                                    dcls_inject_fault_slv_wready;
   `endif // NDS_IO_SLAVEPORT_COMMON_X1
   `ifdef NDS_IO_SLAVEPORT_ECC_X1
wire                                              [7:0] dcls_inject_fault_fs_bus_s_protection_error;
wire                                                    dcls_inject_fault_slv_arreadycode;
wire                                                    dcls_inject_fault_slv_awreadycode;
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] dcls_inject_fault_slv_bctlcode;
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] dcls_inject_fault_slv_bidcode;
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] dcls_inject_fault_slv_butid;
wire                                                    dcls_inject_fault_slv_bvalidcode;
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] dcls_inject_fault_slv_rctlcode;
wire               [(((`NDS_SLV_DATA_CODE_WIDTH))-1):0] dcls_inject_fault_slv_rdatacode;
wire                                                    dcls_inject_fault_slv_reobi;
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] dcls_inject_fault_slv_ridcode;
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] dcls_inject_fault_slv_rutid;
wire                                                    dcls_inject_fault_slv_rvalidcode;
wire                                                    dcls_inject_fault_slv_wreadycode;
   `endif // NDS_IO_SLAVEPORT_ECC_X1
   `ifdef NDS_IO_SLAVEPORT_ECC_X2
wire                                              [7:0] dcls_inject_fault_fs_bus_s1_protection_error;
wire                                                    dcls_inject_fault_slv1_arreadycode;
wire                                                    dcls_inject_fault_slv1_awreadycode;
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] dcls_inject_fault_slv1_bctlcode;
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] dcls_inject_fault_slv1_bidcode;
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] dcls_inject_fault_slv1_butid;
wire                                                    dcls_inject_fault_slv1_bvalidcode;
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] dcls_inject_fault_slv1_rctlcode;
wire               [(((`NDS_SLV_DATA_CODE_WIDTH))-1):0] dcls_inject_fault_slv1_rdatacode;
wire                                                    dcls_inject_fault_slv1_reobi;
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] dcls_inject_fault_slv1_ridcode;
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] dcls_inject_fault_slv1_rutid;
wire                                                    dcls_inject_fault_slv1_rvalidcode;
wire                                                    dcls_inject_fault_slv1_wreadycode;
   `endif // NDS_IO_SLAVEPORT_ECC_X2
   `ifdef NDS_TRACE_TILELINK
wire                                             [31:0] dcls_inject_fault_trace_dcu_cmt_addr;
wire                                             [11:0] dcls_inject_fault_trace_dcu_cmt_func;
wire                                                    dcls_inject_fault_trace_dcu_cmt_valid;
wire                                             [31:0] dcls_inject_fault_trace_dcu_cmt_wdata;
wire                                                    dcls_inject_fault_trace_i0_wb_alive;
wire                                             [31:0] dcls_inject_fault_trace_i0_wb_pc;
wire                                                    dcls_inject_fault_trace_i1_wb_alive;
wire                                             [31:0] dcls_inject_fault_trace_i1_wb_pc;
wire                                             [31:0] dcls_inject_fault_trace_ls_i0_instr;
wire                                             [31:0] dcls_inject_fault_trace_ls_i0_pc;
wire                                             [31:0] dcls_inject_fault_trace_sb_va;
wire                                              [5:0] dcls_inject_fault_trace_wb_cause;
wire                                                    dcls_inject_fault_trace_wb_xcpt;
   `endif // NDS_TRACE_TILELINK
   `ifdef NDS_IO_LM_RESET
wire                                                    dcls_inject_fault_lm_reset_n;
   `endif // NDS_IO_LM_RESET
   `ifdef NDS_IO_ILM_TL_UL
wire                                [(`NDS_ILM_AW)+2:3] dcls_inject_fault_ilm_a_addr;
wire                                             [63:0] dcls_inject_fault_ilm_a_data;
wire                                              [7:0] dcls_inject_fault_ilm_a_mask;
wire                                              [2:0] dcls_inject_fault_ilm_a_opcode;
wire                                              [7:0] dcls_inject_fault_ilm_a_parity0;
wire                                              [7:0] dcls_inject_fault_ilm_a_parity1;
wire                                              [2:0] dcls_inject_fault_ilm_a_size;
wire                                              [1:0] dcls_inject_fault_ilm_a_user;
wire                                                    dcls_inject_fault_ilm_a_valid;
wire                                                    dcls_inject_fault_ilm_d_ready;
   `endif // NDS_IO_ILM_TL_UL
   `ifdef NDS_IO_DLM_TL_UL
wire                      [`NDS_DLM_AMSB:`NDS_DLM_ALSB] dcls_inject_fault_dlm_a_addr;
wire                                  [(`NDS_XLEN-1):0] dcls_inject_fault_dlm_a_data;
wire                                [(`NDS_XLEN/8)-1:0] dcls_inject_fault_dlm_a_mask;
wire                                              [2:0] dcls_inject_fault_dlm_a_opcode;
wire                                              [7:0] dcls_inject_fault_dlm_a_parity;
wire                                              [2:0] dcls_inject_fault_dlm_a_size;
wire                                              [1:0] dcls_inject_fault_dlm_a_user;
wire                                                    dcls_inject_fault_dlm_a_valid;
wire                                                    dcls_inject_fault_dlm_d_ready;
   `endif // NDS_IO_DLM_TL_UL
   `ifdef NDS_IO_ICACHE0
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data0_addr;
wire                                                    dcls_inject_fault_icache_data0_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data0_wdata;
wire                                                    dcls_inject_fault_icache_data0_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data1_addr;
wire                                                    dcls_inject_fault_icache_data1_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data1_wdata;
wire                                                    dcls_inject_fault_icache_data1_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data2_addr;
wire                                                    dcls_inject_fault_icache_data2_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data2_wdata;
wire                                                    dcls_inject_fault_icache_data2_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data3_addr;
wire                                                    dcls_inject_fault_icache_data3_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data3_wdata;
wire                                                    dcls_inject_fault_icache_data3_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data4_addr;
wire                                                    dcls_inject_fault_icache_data4_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data4_wdata;
wire                                                    dcls_inject_fault_icache_data4_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data5_addr;
wire                                                    dcls_inject_fault_icache_data5_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data5_wdata;
wire                                                    dcls_inject_fault_icache_data5_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data6_addr;
wire                                                    dcls_inject_fault_icache_data6_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data6_wdata;
wire                                                    dcls_inject_fault_icache_data6_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data7_addr;
wire                                                    dcls_inject_fault_icache_data7_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data7_wdata;
wire                                                    dcls_inject_fault_icache_data7_we;
wire                     [(`NDS_ICACHE_TAG_RAM_AW)-1:0] dcls_inject_fault_icache_tag0_addr;
wire                                                    dcls_inject_fault_icache_tag0_cs;
wire                     [(`NDS_ICACHE_TAG_RAM_DW)-1:0] dcls_inject_fault_icache_tag0_wdata;
wire                                                    dcls_inject_fault_icache_tag0_we;
   `endif // NDS_IO_ICACHE0
   `ifdef NDS_IO_PROBING
wire                               [((`NDS_VALEN)-1):0] dcls_inject_fault_current_pc;
wire                                [((`NDS_XLEN)-1):0] dcls_inject_fault_selected_gpr_value;
   `endif // NDS_IO_PROBING
   `ifdef NDS_IO_SEIP
wire                                                    dcls_inject_fault_seiack;
   `endif // NDS_IO_SEIP
   `ifdef NDS_IO_UEIP
wire                                                    dcls_inject_fault_ueiack;
   `endif // NDS_IO_UEIP
   `ifdef NDS_IO_DEBUG
wire                                                    dcls_inject_fault_hart_halted;
wire                                                    dcls_inject_fault_hart_unavail;
wire                                                    dcls_inject_fault_hart_under_reset;
wire                                                    dcls_inject_fault_stoptime;
   `endif // NDS_IO_DEBUG
   `ifdef NDS_IO_TRACE_INSTR_GEN1
wire                                             [19:0] dcls_inject_fault_gen1_trace_cause;
wire                               [(`NDS_VALEN)*2-1:0] dcls_inject_fault_gen1_trace_iaddr;
wire                                              [1:0] dcls_inject_fault_gen1_trace_iexception;
wire                                             [63:0] dcls_inject_fault_gen1_trace_instr;
wire                                              [1:0] dcls_inject_fault_gen1_trace_interrupt;
wire                                              [1:0] dcls_inject_fault_gen1_trace_ivalid;
wire                                              [3:0] dcls_inject_fault_gen1_trace_priv;
wire                                [(`NDS_XLEN)*2-1:0] dcls_inject_fault_gen1_trace_tval;
   `endif // NDS_IO_TRACE_INSTR_GEN1
   `ifdef NDS_IO_TRACE_INSTR
wire                                              [9:0] dcls_inject_fault_trace_cause;
wire                                             [31:0] dcls_inject_fault_trace_context;
wire                                              [1:0] dcls_inject_fault_trace_ctype;
wire                                                    dcls_inject_fault_trace_halted;
wire                               [2*(`NDS_VALEN)-1:0] dcls_inject_fault_trace_iaddr;
wire                                              [1:0] dcls_inject_fault_trace_ilastsize;
wire                                              [3:0] dcls_inject_fault_trace_iretire;
wire                                              [7:0] dcls_inject_fault_trace_itype;
wire                                              [1:0] dcls_inject_fault_trace_priv;
wire                                                    dcls_inject_fault_trace_reset;
wire                                              [5:0] dcls_inject_fault_trace_trigger;
wire                                [((`NDS_XLEN)-1):0] dcls_inject_fault_trace_tval;
   `endif // NDS_IO_TRACE_INSTR
   `ifdef NDS_IO_TRAP_STATUS
wire                                                    dcls_inject_fault_fs_halt_mode;
wire                                              [9:0] dcls_inject_fault_fs_trap_status_cause;
wire                                              [2:0] dcls_inject_fault_fs_trap_status_dcause;
wire                                                    dcls_inject_fault_fs_trap_status_interrupt;
wire                                                    dcls_inject_fault_fs_trap_status_nmi;
wire                                                    dcls_inject_fault_fs_trap_status_taken;
   `endif // NDS_IO_TRAP_STATUS
   `ifdef NDS_IO_PPI
wire                      [((`NDS_BIU_ADDR_WIDTH)-1):0] dcls_inject_fault_ppi_araddr;
wire                                              [1:0] dcls_inject_fault_ppi_arburst;
wire                                              [3:0] dcls_inject_fault_ppi_arcache;
wire                          [(`NDS_PPI_ID_WIDTH)-1:0] dcls_inject_fault_ppi_arid;
wire                                              [7:0] dcls_inject_fault_ppi_arlen;
wire                                                    dcls_inject_fault_ppi_arlock;
wire                                              [2:0] dcls_inject_fault_ppi_arprot;
wire                                              [2:0] dcls_inject_fault_ppi_arsize;
wire                                                    dcls_inject_fault_ppi_arvalid;
wire                      [((`NDS_BIU_ADDR_WIDTH)-1):0] dcls_inject_fault_ppi_awaddr;
wire                                              [1:0] dcls_inject_fault_ppi_awburst;
wire                                              [3:0] dcls_inject_fault_ppi_awcache;
wire                          [(`NDS_PPI_ID_WIDTH)-1:0] dcls_inject_fault_ppi_awid;
wire                                              [7:0] dcls_inject_fault_ppi_awlen;
wire                                                    dcls_inject_fault_ppi_awlock;
wire                                              [2:0] dcls_inject_fault_ppi_awprot;
wire                                              [2:0] dcls_inject_fault_ppi_awsize;
wire                                                    dcls_inject_fault_ppi_awvalid;
wire                                                    dcls_inject_fault_ppi_bready;
wire                                                    dcls_inject_fault_ppi_rready;
wire                        [(`NDS_PPI_DATA_WIDTH-1):0] dcls_inject_fault_ppi_wdata;
wire                                                    dcls_inject_fault_ppi_wlast;
wire                      [(`NDS_PPI_DATA_WIDTH/8)-1:0] dcls_inject_fault_ppi_wstrb;
wire                                                    dcls_inject_fault_ppi_wvalid;
   `endif // NDS_IO_PPI
   `ifdef NDS_IO_PPI_PROT
wire                   [(`NDS_BIU_ADDR_CODE_WIDTH)-1:0] dcls_inject_fault_ppi_araddrcode;
wire                   [(`NDS_BIU_CTRL_CODE_WIDTH)-1:0] dcls_inject_fault_ppi_arctl0code;
wire                   [(`NDS_BIU_CTRL_CODE_WIDTH)-1:0] dcls_inject_fault_ppi_arctl1code;
wire                                              [4:0] dcls_inject_fault_ppi_aridcode;
wire                        [(`NDS_BIU_UTID_WIDTH)-1:0] dcls_inject_fault_ppi_arutid;
wire                                                    dcls_inject_fault_ppi_arvalidcode;
wire                   [(`NDS_BIU_ADDR_CODE_WIDTH)-1:0] dcls_inject_fault_ppi_awaddrcode;
wire                   [(`NDS_BIU_CTRL_CODE_WIDTH)-1:0] dcls_inject_fault_ppi_awctl0code;
wire                   [(`NDS_BIU_CTRL_CODE_WIDTH)-1:0] dcls_inject_fault_ppi_awctl1code;
wire                                              [4:0] dcls_inject_fault_ppi_awidcode;
wire                        [(`NDS_BIU_UTID_WIDTH)-1:0] dcls_inject_fault_ppi_awutid;
wire                                                    dcls_inject_fault_ppi_awvalidcode;
wire                                                    dcls_inject_fault_ppi_breadycode;
wire                                                    dcls_inject_fault_ppi_rreadycode;
wire                                              [4:0] dcls_inject_fault_ppi_wctlcode;
wire                   [(`NDS_PPI_DATA_CODE_WIDTH)-1:0] dcls_inject_fault_ppi_wdatacode;
wire                                                    dcls_inject_fault_ppi_weobi;
wire                        [(`NDS_BIU_UTID_WIDTH)-1:0] dcls_inject_fault_ppi_wutid;
wire                                                    dcls_inject_fault_ppi_wvalidcode;
   `endif // NDS_IO_PPI_PROT
   `ifdef NDS_IO_ILM_RAM0
wire                            [(`NDS_ILM_RAM_AW-1):0] dcls_inject_fault_ilm0_addr;
wire                          [(`NDS_ILM_RAM_BWEW)-1:0] dcls_inject_fault_ilm0_byte_we;
wire                                                    dcls_inject_fault_ilm0_cs;
wire                            [(`NDS_ILM_RAM_DW)-1:0] dcls_inject_fault_ilm0_wdata;
wire                                                    dcls_inject_fault_ilm0_we;
   `endif // NDS_IO_ILM_RAM0
   `ifdef NDS_IO_ILM_RAM1
wire                            [(`NDS_ILM_RAM_AW-1):0] dcls_inject_fault_ilm1_addr;
wire                          [(`NDS_ILM_RAM_BWEW)-1:0] dcls_inject_fault_ilm1_byte_we;
wire                                                    dcls_inject_fault_ilm1_cs;
wire                            [(`NDS_ILM_RAM_DW)-1:0] dcls_inject_fault_ilm1_wdata;
wire                                                    dcls_inject_fault_ilm1_we;
   `endif // NDS_IO_ILM_RAM1
   `ifdef NDS_IO_DLM_RAM0
wire                            [(`NDS_DLM_RAM_AW-1):0] dcls_inject_fault_dlm_addr;
wire                          [(`NDS_DLM_RAM_BWEW-1):0] dcls_inject_fault_dlm_byte_we;
wire                                                    dcls_inject_fault_dlm_cs;
wire                            [(`NDS_DLM_RAM_DW)-1:0] dcls_inject_fault_dlm_wdata;
wire                                                    dcls_inject_fault_dlm_we;
   `endif // NDS_IO_DLM_RAM0
   `ifdef NDS_IO_DLM_RAM1
wire                            [(`NDS_DLM_RAM_AW-1):0] dcls_inject_fault_dlm1_addr;
wire                          [(`NDS_DLM_RAM_BWEW-1):0] dcls_inject_fault_dlm1_byte_we;
wire                                                    dcls_inject_fault_dlm1_cs;
wire                            [(`NDS_DLM_RAM_DW)-1:0] dcls_inject_fault_dlm1_wdata;
wire                                                    dcls_inject_fault_dlm1_we;
   `endif // NDS_IO_DLM_RAM1
   `ifdef NDS_IO_DLM_RAM2
wire                            [(`NDS_DLM_RAM_AW-1):0] dcls_inject_fault_dlm2_addr;
wire                          [(`NDS_DLM_RAM_BWEW-1):0] dcls_inject_fault_dlm2_byte_we;
wire                                                    dcls_inject_fault_dlm2_cs;
wire                            [(`NDS_DLM_RAM_DW)-1:0] dcls_inject_fault_dlm2_wdata;
wire                                                    dcls_inject_fault_dlm2_we;
   `endif // NDS_IO_DLM_RAM2
   `ifdef NDS_IO_DLM_RAM3
wire                            [(`NDS_DLM_RAM_AW-1):0] dcls_inject_fault_dlm3_addr;
wire                          [(`NDS_DLM_RAM_BWEW-1):0] dcls_inject_fault_dlm3_byte_we;
wire                                                    dcls_inject_fault_dlm3_cs;
wire                            [(`NDS_DLM_RAM_DW)-1:0] dcls_inject_fault_dlm3_wdata;
wire                                                    dcls_inject_fault_dlm3_we;
   `endif // NDS_IO_DLM_RAM3
   `ifdef NDS_IO_ICACHE1
wire                     [(`NDS_ICACHE_TAG_RAM_AW)-1:0] dcls_inject_fault_icache_tag1_addr;
wire                                                    dcls_inject_fault_icache_tag1_cs;
wire                     [(`NDS_ICACHE_TAG_RAM_DW)-1:0] dcls_inject_fault_icache_tag1_wdata;
wire                                                    dcls_inject_fault_icache_tag1_we;
   `endif // NDS_IO_ICACHE1
   `ifdef NDS_IO_ICACHE2
wire                     [(`NDS_ICACHE_TAG_RAM_AW)-1:0] dcls_inject_fault_icache_tag2_addr;
wire                                                    dcls_inject_fault_icache_tag2_cs;
wire                     [(`NDS_ICACHE_TAG_RAM_DW)-1:0] dcls_inject_fault_icache_tag2_wdata;
wire                                                    dcls_inject_fault_icache_tag2_we;
wire                     [(`NDS_ICACHE_TAG_RAM_AW)-1:0] dcls_inject_fault_icache_tag3_addr;
wire                                                    dcls_inject_fault_icache_tag3_cs;
wire                     [(`NDS_ICACHE_TAG_RAM_DW)-1:0] dcls_inject_fault_icache_tag3_wdata;
wire                                                    dcls_inject_fault_icache_tag3_we;
   `endif // NDS_IO_ICACHE2
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_SLAVEPORT_COMMON_X1
wire                                       [ADDR_MSB:0] core1_slv_araddr;
wire                                              [1:0] core1_slv_arburst;
wire                                              [3:0] core1_slv_arcache;
wire                           [(SLVPORT_ID_WIDTH-1):0] core1_slv_arid;
wire                                              [7:0] core1_slv_arlen;
wire                                                    core1_slv_arlock;
wire                                              [2:0] core1_slv_arprot;
wire                                              [2:0] core1_slv_arsize;
wire                                                    core1_slv_aruser;
wire                                                    core1_slv_arvalid;
wire                                       [ADDR_MSB:0] core1_slv_awaddr;
wire                                              [1:0] core1_slv_awburst;
wire                                              [3:0] core1_slv_awcache;
wire                           [(SLVPORT_ID_WIDTH-1):0] core1_slv_awid;
wire                                              [7:0] core1_slv_awlen;
wire                                                    core1_slv_awlock;
wire                                              [2:0] core1_slv_awprot;
wire                                              [2:0] core1_slv_awsize;
wire                                                    core1_slv_awuser;
wire                                                    core1_slv_awvalid;
wire                                                    core1_slv_bready;
wire                                                    core1_slv_rready;
wire                         [(SLVPORT_DATA_WIDTH-1):0] core1_slv_wdata;
wire                                                    core1_slv_wlast;
wire                     [((SLVPORT_DATA_WIDTH/8)-1):0] core1_slv_wstrb;
wire                                                    core1_slv_wvalid;
wire                                                    core1_slv_arready;
wire                                                    core1_slv_awready;
wire                           [(SLVPORT_ID_WIDTH-1):0] core1_slv_bid;
wire                                              [1:0] core1_slv_bresp;
wire                                                    core1_slv_bvalid;
wire                         [(SLVPORT_DATA_WIDTH-1):0] core1_slv_rdata;
wire                           [(SLVPORT_ID_WIDTH-1):0] core1_slv_rid;
wire                                                    core1_slv_rlast;
wire                                              [1:0] core1_slv_rresp;
wire                                                    core1_slv_rvalid;
wire                                                    core1_slv_wready;
   `endif // NDS_IO_SLAVEPORT_COMMON_X1
   `ifdef NDS_IO_ILM_TL_UL
wire                                 [ILM_TL_UL_EW-1:0] core1_ilm_a_parity0_in;
wire                                 [ILM_TL_UL_EW-1:0] core1_ilm_a_parity1_in;
wire                                              [7:0] core1_ilm_d_parity0;
wire                                              [7:0] core1_ilm_d_parity1;
wire                                                    core1_ilm_reset_n;
wire                                [(`NDS_ILM_AW)+2:3] core1_ilm_a_addr;
wire                                             [63:0] core1_ilm_a_data;
wire                                              [7:0] core1_ilm_a_mask;
wire                                              [2:0] core1_ilm_a_opcode;
wire                                              [7:0] core1_ilm_a_parity0;
wire                                              [7:0] core1_ilm_a_parity1;
wire                                              [2:0] core1_ilm_a_size;
wire                                                    core1_ilm_a_valid;
wire                                                    core1_ilm_d_ready;
wire                                                    core1_ilm_ram_clk;
wire                                                    core1_ilm_ram_clk_en;
wire                             [ILM_TL_UL_RAM_AW-1:0] core1_ilm0_addr;
wire                           [ILM_TL_UL_RAM_BWEW-1:0] core1_ilm0_bwe;
wire                                                    core1_ilm0_cs;
wire                             [ILM_TL_UL_RAM_DW-1:0] core1_ilm0_wdata;
wire                                                    core1_ilm0_we;
wire                             [ILM_TL_UL_RAM_AW-1:0] core1_ilm1_addr;
wire                           [ILM_TL_UL_RAM_BWEW-1:0] core1_ilm1_bwe;
wire                                                    core1_ilm1_cs;
wire                             [ILM_TL_UL_RAM_DW-1:0] core1_ilm1_wdata;
wire                                                    core1_ilm1_we;
wire                                                    core1_ilm_a_ready;
wire                                             [63:0] core1_ilm_d_data;
wire                                                    core1_ilm_d_denied;
wire                                 [ILM_TL_UL_EW-1:0] core1_ilm_d_parity0_out;
wire                                 [ILM_TL_UL_EW-1:0] core1_ilm_d_parity1_out;
wire                                                    core1_ilm_d_valid;
wire                             [ILM_TL_UL_RAM_DW-1:0] core1_ilm0_rdata;
wire                             [ILM_TL_UL_RAM_DW-1:0] core1_ilm1_rdata;
   `endif // NDS_IO_ILM_TL_UL
   `ifdef NDS_IO_DLM_TL_UL
wire                                                    core1_dlm_reset_n;
wire                      [`NDS_DLM_AMSB:`NDS_DLM_ALSB] core1_dlm_a_addr;
wire                                  [(`NDS_XLEN-1):0] core1_dlm_a_data;
wire                                [(`NDS_XLEN/8)-1:0] core1_dlm_a_mask;
wire                                              [2:0] core1_dlm_a_opcode;
wire                                              [7:0] core1_dlm_a_parity;
wire                                              [2:0] core1_dlm_a_size;
wire                                              [1:0] core1_dlm_a_user;
wire                                                    core1_dlm_a_valid;
wire                                                    core1_dlm_d_ready;
wire                                                    core1_dlm_a_ready;
wire                                  [(`NDS_XLEN-1):0] core1_dlm_d_data;
wire                                                    core1_dlm_d_denied;
wire                                              [7:0] core1_dlm_d_parity;
wire                                                    core1_dlm_d_valid;
   `endif // NDS_IO_DLM_TL_UL
   `ifdef NDS_IO_ICACHE0
wire                                                    core1_icache_disable_init;
   `endif // NDS_IO_ICACHE0
   `ifdef NDS_IO_SEIP
wire                                              [9:0] core1_seiid;
wire                                                    core1_seip;
wire                                                    core1_seiack;
   `endif // NDS_IO_SEIP
   `ifdef NDS_IO_UEIP
wire                                                    core1_ueip;
   `endif // NDS_IO_UEIP
   `ifdef NDS_IO_DEBUG
wire                                                    core1_debugint;
wire                                                    core1_resethaltreq;
wire                                                    core1_hart_halted;
wire                                                    core1_hart_unavail;
wire                                                    core1_hart_under_reset;
wire                                                    core1_stoptime;
   `endif // NDS_IO_DEBUG
   `ifdef NDS_IO_PPI
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core1_axi_rf_araddr;
wire                                              [1:0] core1_axi_rf_arburst;
wire                                              [3:0] core1_axi_rf_arcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_axi_rf_arid;
wire                                              [7:0] core1_axi_rf_arlen;
wire                                                    core1_axi_rf_arlock;
wire                                              [2:0] core1_axi_rf_arprot;
wire                                              [2:0] core1_axi_rf_arsize;
wire                                                    core1_axi_rf_arvalid;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core1_axi_rf_awaddr;
wire                                              [1:0] core1_axi_rf_awburst;
wire                                              [3:0] core1_axi_rf_awcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_axi_rf_awid;
wire                                              [7:0] core1_axi_rf_awlen;
wire                                                    core1_axi_rf_awlock;
wire                                              [2:0] core1_axi_rf_awprot;
wire                                              [2:0] core1_axi_rf_awsize;
wire                                                    core1_axi_rf_awvalid;
wire                                                    core1_axi_rf_bready;
wire                                                    core1_axi_rf_rready;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core1_axi_rf_wdata;
wire                                                    core1_axi_rf_wlast;
wire                      [(`NDS_PPI_DATA_WIDTH/8)-1:0] core1_axi_rf_wstrb;
wire                                                    core1_axi_rf_wvalid;
wire                                                    core1_ppi_arready;
wire                                                    core1_ppi_awready;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_bid;
wire                                              [1:0] core1_ppi_bresp;
wire                                                    core1_ppi_bvalid;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core1_ppi_rdata;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_rid;
wire                                                    core1_ppi_rlast;
wire                                              [1:0] core1_ppi_rresp;
wire                                                    core1_ppi_rvalid;
wire                                                    core1_ppi_wready;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core1_ppi_araddr;
wire                                              [1:0] core1_ppi_arburst;
wire                                              [3:0] core1_ppi_arcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_arid;
wire                                              [7:0] core1_ppi_arlen;
wire                                                    core1_ppi_arlock;
wire                                              [2:0] core1_ppi_arprot;
wire                                              [2:0] core1_ppi_arsize;
wire                                                    core1_ppi_arvalid;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core1_ppi_awaddr;
wire                                              [1:0] core1_ppi_awburst;
wire                                              [3:0] core1_ppi_awcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_awid;
wire                                              [7:0] core1_ppi_awlen;
wire                                                    core1_ppi_awlock;
wire                                              [2:0] core1_ppi_awprot;
wire                                              [2:0] core1_ppi_awsize;
wire                                                    core1_ppi_awvalid;
wire                                                    core1_ppi_bready;
wire                                                    core1_ppi_rready;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core1_ppi_wdata;
wire                                                    core1_ppi_wlast;
wire                      [(`NDS_PPI_DATA_WIDTH/8)-1:0] core1_ppi_wstrb;
wire                                                    core1_ppi_wvalid;
wire                                                    core1_axi_rf_arready;
wire                                                    core1_axi_rf_awready;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_axi_rf_bid;
wire                                              [1:0] core1_axi_rf_bresp;
wire                                                    core1_axi_rf_bvalid;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core1_axi_rf_rdata;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_axi_rf_rid;
wire                                                    core1_axi_rf_rlast;
wire                                              [1:0] core1_axi_rf_rresp;
wire                                                    core1_axi_rf_rvalid;
wire                                                    core1_axi_rf_wready;
   `endif // NDS_IO_PPI
   `ifdef NDS_IO_PPI_PROT
wire                                                    core1_ppi_arreadycode;
wire                                                    core1_ppi_awreadycode;
wire                                              [2:0] core1_ppi_bctlcode;
wire                                              [4:0] core1_ppi_bidcode;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core1_ppi_butid;
wire                                                    core1_ppi_bvalidcode;
wire                                                    core1_ppi_ingress_ds_arready;
wire                                                    core1_ppi_ingress_ds_awready;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_ingress_ds_bid;
wire                                              [1:0] core1_ppi_ingress_ds_bresp;
wire                                                    core1_ppi_ingress_ds_bvalid;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core1_ppi_ingress_ds_rdata;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_ingress_ds_rid;
wire                                                    core1_ppi_ingress_ds_rlast;
wire                                              [1:0] core1_ppi_ingress_ds_rresp;
wire                                                    core1_ppi_ingress_ds_rvalid;
wire                                                    core1_ppi_ingress_ds_wready;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core1_ppi_ingress_us_araddr;
wire                     [`NDS_BIU_ADDR_CODE_WIDTH-1:0] core1_ppi_ingress_us_araddrcode;
wire                                              [1:0] core1_ppi_ingress_us_arburst;
wire                                              [3:0] core1_ppi_ingress_us_arcache;
wire                                              [4:0] core1_ppi_ingress_us_arctl0code;
wire                                              [4:0] core1_ppi_ingress_us_arctl1code;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_ingress_us_arid;
wire                                              [4:0] core1_ppi_ingress_us_aridcode;
wire                                              [7:0] core1_ppi_ingress_us_arlen;
wire                                                    core1_ppi_ingress_us_arlock;
wire                                              [2:0] core1_ppi_ingress_us_arprot;
wire                                              [2:0] core1_ppi_ingress_us_arsize;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core1_ppi_ingress_us_arutid;
wire                                                    core1_ppi_ingress_us_arvalid;
wire                                                    core1_ppi_ingress_us_arvalidcode;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core1_ppi_ingress_us_awaddr;
wire                     [`NDS_BIU_ADDR_CODE_WIDTH-1:0] core1_ppi_ingress_us_awaddrcode;
wire                                              [1:0] core1_ppi_ingress_us_awburst;
wire                                              [3:0] core1_ppi_ingress_us_awcache;
wire                                              [4:0] core1_ppi_ingress_us_awctl0code;
wire                                              [4:0] core1_ppi_ingress_us_awctl1code;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_ingress_us_awid;
wire                                              [4:0] core1_ppi_ingress_us_awidcode;
wire                                              [7:0] core1_ppi_ingress_us_awlen;
wire                                                    core1_ppi_ingress_us_awlock;
wire                                              [2:0] core1_ppi_ingress_us_awprot;
wire                                              [2:0] core1_ppi_ingress_us_awsize;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core1_ppi_ingress_us_awutid;
wire                                                    core1_ppi_ingress_us_awvalid;
wire                                                    core1_ppi_ingress_us_awvalidcode;
wire                                                    core1_ppi_ingress_us_bready;
wire                                                    core1_ppi_ingress_us_breadycode;
wire                                                    core1_ppi_ingress_us_rready;
wire                                                    core1_ppi_ingress_us_rreadycode;
wire                                              [4:0] core1_ppi_ingress_us_wctlcode;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core1_ppi_ingress_us_wdata;
wire                     [`NDS_PPI_DATA_CODE_WIDTH-1:0] core1_ppi_ingress_us_wdatacode;
wire                                                    core1_ppi_ingress_us_weobi;
wire                                                    core1_ppi_ingress_us_wlast;
wire                      [(`NDS_PPI_DATA_WIDTH/8)-1:0] core1_ppi_ingress_us_wstrb;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core1_ppi_ingress_us_wutid;
wire                                                    core1_ppi_ingress_us_wvalid;
wire                                                    core1_ppi_ingress_us_wvalidcode;
wire                                              [2:0] core1_ppi_rctlcode;
wire                     [`NDS_PPI_DATA_CODE_WIDTH-1:0] core1_ppi_rdatacode;
wire                                                    core1_ppi_reobi;
wire                                              [4:0] core1_ppi_ridcode;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core1_ppi_rutid;
wire                                                    core1_ppi_rvalidcode;
wire                                                    core1_ppi_wreadycode;
wire                     [`NDS_BIU_ADDR_CODE_WIDTH-1:0] core1_ppi_araddrcode;
wire                                              [4:0] core1_ppi_arctl0code;
wire                                              [4:0] core1_ppi_arctl1code;
wire                                              [4:0] core1_ppi_aridcode;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core1_ppi_arutid;
wire                                                    core1_ppi_arvalidcode;
wire                     [`NDS_BIU_ADDR_CODE_WIDTH-1:0] core1_ppi_awaddrcode;
wire                                              [4:0] core1_ppi_awctl0code;
wire                                              [4:0] core1_ppi_awctl1code;
wire                                              [4:0] core1_ppi_awidcode;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core1_ppi_awutid;
wire                                                    core1_ppi_awvalidcode;
wire                                                    core1_ppi_breadycode;
wire                                                    core1_ppi_rreadycode;
wire                                              [4:0] core1_ppi_wctlcode;
wire                     [`NDS_PPI_DATA_CODE_WIDTH-1:0] core1_ppi_wdatacode;
wire                                                    core1_ppi_weobi;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core1_ppi_wutid;
wire                                                    core1_ppi_wvalidcode;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core1_ppi_ingress_ds_araddr;
wire                                              [1:0] core1_ppi_ingress_ds_arburst;
wire                                              [3:0] core1_ppi_ingress_ds_arcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_ingress_ds_arid;
wire                                              [7:0] core1_ppi_ingress_ds_arlen;
wire                                                    core1_ppi_ingress_ds_arlock;
wire                                              [2:0] core1_ppi_ingress_ds_arprot;
wire                                              [2:0] core1_ppi_ingress_ds_arsize;
wire                                                    core1_ppi_ingress_ds_arvalid;
wire                          [`NDS_BIU_ADDR_WIDTH-1:0] core1_ppi_ingress_ds_awaddr;
wire                                              [1:0] core1_ppi_ingress_ds_awburst;
wire                                              [3:0] core1_ppi_ingress_ds_awcache;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_ingress_ds_awid;
wire                                              [7:0] core1_ppi_ingress_ds_awlen;
wire                                                    core1_ppi_ingress_ds_awlock;
wire                                              [2:0] core1_ppi_ingress_ds_awprot;
wire                                              [2:0] core1_ppi_ingress_ds_awsize;
wire                                                    core1_ppi_ingress_ds_awvalid;
wire                                                    core1_ppi_ingress_ds_bready;
wire                                                    core1_ppi_ingress_ds_rready;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core1_ppi_ingress_ds_wdata;
wire                                                    core1_ppi_ingress_ds_wlast;
wire                      [(`NDS_PPI_DATA_WIDTH/8)-1:0] core1_ppi_ingress_ds_wstrb;
wire                                                    core1_ppi_ingress_ds_wvalid;
wire                                                    core1_ppi_ingress_us_arready;
wire                                                    core1_ppi_ingress_us_arreadycode;
wire                                                    core1_ppi_ingress_us_awready;
wire                                                    core1_ppi_ingress_us_awreadycode;
wire                                              [2:0] core1_ppi_ingress_us_bctlcode;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_ingress_us_bid;
wire                                              [4:0] core1_ppi_ingress_us_bidcode;
wire                                              [1:0] core1_ppi_ingress_us_bresp;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core1_ppi_ingress_us_butid;
wire                                                    core1_ppi_ingress_us_bvalid;
wire                                                    core1_ppi_ingress_us_bvalidcode;
wire                                              [2:0] core1_ppi_ingress_us_rctlcode;
wire                          [`NDS_PPI_DATA_WIDTH-1:0] core1_ppi_ingress_us_rdata;
wire                     [`NDS_PPI_DATA_CODE_WIDTH-1:0] core1_ppi_ingress_us_rdatacode;
wire                                                    core1_ppi_ingress_us_reobi;
wire                            [`NDS_PPI_ID_WIDTH-1:0] core1_ppi_ingress_us_rid;
wire                                              [4:0] core1_ppi_ingress_us_ridcode;
wire                                                    core1_ppi_ingress_us_rlast;
wire                                              [1:0] core1_ppi_ingress_us_rresp;
wire                          [`NDS_BIU_UTID_WIDTH-1:0] core1_ppi_ingress_us_rutid;
wire                                                    core1_ppi_ingress_us_rvalid;
wire                                                    core1_ppi_ingress_us_rvalidcode;
wire                                                    core1_ppi_ingress_us_wready;
wire                                                    core1_ppi_ingress_us_wreadycode;
wire                                                    nds_unused_ppi1_event_ctl_err; // dangler: () => ()
wire                                                    nds_unused_ppi1_event_data_err; // dangler: () => ()
wire                                                    nds_unused_ppi1_event_eobi_err; // dangler: () => ()
wire                                                    nds_unused_ppi1_event_handshake_err; // dangler: () => ()
   `endif // NDS_IO_PPI_PROT
   `ifdef NDS_IO_LM_QOS
wire                                              [3:0] core1_ifu_ilm_qos;
wire                                              [3:0] core1_lsu_dlm_qos;
wire                                              [3:0] core1_lsu_ilm_qos;
   `endif // NDS_IO_LM_QOS
   `ifdef NDS_IO_SLAVEPORT_QOS_X1
wire                                              [3:0] core1_slv_arqos;
wire                                              [3:0] core1_slv_awqos;
   `endif // NDS_IO_SLAVEPORT_QOS_X1
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_BUS_PROTECTION
wire                                              [7:0] dcls_inject_fault_fs_bus_m_protection_error;
   `endif // NDS_IO_BUS_PROTECTION
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_BUS_PROTECTION
wire                                              [7:0] core1_cfg_timeout_flash0;
wire                                              [7:0] core1_cfg_timeout_ppi;
wire                                              [7:0] core1_cfg_timeout_spp;
wire                                              [7:0] core1_cfg_timeout_sys0;
wire                                              [7:0] core1_fs_bus_m_protection_error;
   `endif // NDS_IO_BUS_PROTECTION
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_BUS_PROTECTION
   `ifdef NDS_IO_FLASHIF0
wire                      [((BIU_ADDR_CODE_WIDTH)-1):0] cluster_flash0_araddrcode;
wire                        [(BIU_CTRL_CODE_WIDTH-1):0] cluster_flash0_arctl0code;
wire                        [(BIU_CTRL_CODE_WIDTH-1):0] cluster_flash0_arctl1code;
wire                                              [4:0] cluster_flash0_aridcode;
wire                           [((BIU_UTID_WIDTH)-1):0] cluster_flash0_arutid;
wire                                                    cluster_flash0_arvalidcode;
wire                      [((BIU_ADDR_CODE_WIDTH)-1):0] cluster_flash0_awaddrcode;
wire                        [(BIU_CTRL_CODE_WIDTH-1):0] cluster_flash0_awctl0code;
wire                        [(BIU_CTRL_CODE_WIDTH-1):0] cluster_flash0_awctl1code;
wire                                              [4:0] cluster_flash0_awidcode;
wire                           [((BIU_UTID_WIDTH)-1):0] cluster_flash0_awutid;
wire                                                    cluster_flash0_awvalidcode;
wire                                                    cluster_flash0_breadycode;
wire                                                    cluster_flash0_rreadycode;
wire                           [(WCTRL_CODE_WIDTH-1):0] cluster_flash0_wctlcode;
wire                      [((BIU_DATA_CODE_WIDTH)-1):0] cluster_flash0_wdatacode;
wire                                                    cluster_flash0_weobi;
wire                           [((BIU_UTID_WIDTH)-1):0] cluster_flash0_wutid;
wire                                                    cluster_flash0_wvalidcode;
wire                                                    cluster_flash0_arreadycode;
wire                                                    cluster_flash0_awreadycode;
wire                                              [2:0] cluster_flash0_bctlcode;
wire                                              [4:0] cluster_flash0_bidcode;
wire                           [((BIU_UTID_WIDTH)-1):0] cluster_flash0_butid;
wire                                                    cluster_flash0_bvalidcode;
wire                                              [2:0] cluster_flash0_rctlcode;
wire                      [((BIU_DATA_CODE_WIDTH)-1):0] cluster_flash0_rdatacode;
wire                                                    cluster_flash0_reobi;
wire                                              [4:0] cluster_flash0_ridcode;
wire                           [((BIU_UTID_WIDTH)-1):0] cluster_flash0_rutid;
wire                                                    cluster_flash0_rvalidcode;
wire                                                    cluster_flash0_wreadycode;
   `endif // NDS_IO_FLASHIF0
   `ifdef NDS_IO_SPP
wire                   [(`NDS_BIU_ADDR_CODE_WIDTH-1):0] spp_araddrcode;
wire                   [(`NDS_BIU_CTRL_CODE_WIDTH-1):0] spp_arctl0code;
wire                   [(`NDS_BIU_CTRL_CODE_WIDTH-1):0] spp_arctl1code;
wire                                              [4:0] spp_aridcode;
wire                        [(`NDS_BIU_UTID_WIDTH-1):0] spp_arutid;
wire                                                    spp_arvalidcode;
wire                   [(`NDS_BIU_ADDR_CODE_WIDTH-1):0] spp_awaddrcode;
wire                   [(`NDS_BIU_CTRL_CODE_WIDTH-1):0] spp_awctl0code;
wire                   [(`NDS_BIU_CTRL_CODE_WIDTH-1):0] spp_awctl1code;
wire                                              [4:0] spp_awidcode;
wire                        [(`NDS_BIU_UTID_WIDTH-1):0] spp_awutid;
wire                                                    spp_awvalidcode;
wire                                                    spp_breadycode;
wire                                                    spp_rreadycode;
wire                  [(`NDS_BIU_WCTRL_CODE_WIDTH-1):0] spp_wctlcode;
wire                   [(`NDS_SPP_DATA_CODE_WIDTH-1):0] spp_wdatacode;
wire                                                    spp_weobi;
wire                        [(`NDS_BIU_UTID_WIDTH-1):0] spp_wutid;
wire                                                    spp_wvalidcode;
wire                                                    nds_unused_spp_event_ctl_err; // dangler: () => ()
wire                                                    nds_unused_spp_event_data_err; // dangler: () => ()
wire                                                    nds_unused_spp_event_eobi_err; // dangler: () => ()
wire                                                    nds_unused_spp_event_handshake_err; // dangler: () => ()
wire                                                    spp_arreadycode;
wire                                                    spp_awreadycode;
wire                                              [2:0] spp_bctlcode;
wire                                              [4:0] spp_bidcode;
wire                        [(`NDS_BIU_UTID_WIDTH-1):0] spp_butid;
wire                                                    spp_bvalidcode;
wire                                              [2:0] spp_rctlcode;
wire                   [(`NDS_SPP_DATA_CODE_WIDTH-1):0] spp_rdatacode;
wire                                                    spp_reobi;
wire                                              [4:0] spp_ridcode;
wire                        [(`NDS_BIU_UTID_WIDTH-1):0] spp_rutid;
wire                                                    spp_rvalidcode;
wire                                                    spp_wreadycode;
   `endif // NDS_IO_SPP
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_ICACHE0
   `ifdef NDS_IO_ICACHE0_CTRL_OUT
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data0_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data1_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data2_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data3_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data4_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data5_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data6_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data7_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_DCACHE0
wire                    [(`NDS_DCACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_dcache_data0_addr;
wire                  [(`NDS_DCACHE_DATA_RAM_BWEW)-1:0] dcls_inject_fault_dcache_data0_byte_we;
wire                                                    dcls_inject_fault_dcache_data0_cs;
wire                    [(`NDS_DCACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_dcache_data0_wdata;
wire                                                    dcls_inject_fault_dcache_data0_we;
wire                    [(`NDS_DCACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_dcache_data1_addr;
wire                  [(`NDS_DCACHE_DATA_RAM_BWEW)-1:0] dcls_inject_fault_dcache_data1_byte_we;
wire                                                    dcls_inject_fault_dcache_data1_cs;
wire                    [(`NDS_DCACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_dcache_data1_wdata;
wire                                                    dcls_inject_fault_dcache_data1_we;
wire                    [(`NDS_DCACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_dcache_data2_addr;
wire                  [(`NDS_DCACHE_DATA_RAM_BWEW)-1:0] dcls_inject_fault_dcache_data2_byte_we;
wire                                                    dcls_inject_fault_dcache_data2_cs;
wire                    [(`NDS_DCACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_dcache_data2_wdata;
wire                                                    dcls_inject_fault_dcache_data2_we;
wire                    [(`NDS_DCACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_dcache_data3_addr;
wire                  [(`NDS_DCACHE_DATA_RAM_BWEW)-1:0] dcls_inject_fault_dcache_data3_byte_we;
wire                                                    dcls_inject_fault_dcache_data3_cs;
wire                    [(`NDS_DCACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_dcache_data3_wdata;
wire                                                    dcls_inject_fault_dcache_data3_we;
wire                     [(`NDS_DCACHE_TAG_RAM_AW)-1:0] dcls_inject_fault_dcache_tag0_addr;
wire                                                    dcls_inject_fault_dcache_tag0_cs;
wire                     [(`NDS_DCACHE_TAG_RAM_DW)-1:0] dcls_inject_fault_dcache_tag0_wdata;
wire                                                    dcls_inject_fault_dcache_tag0_we;
   `endif // NDS_IO_DCACHE0
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_DCACHE0
wire                                                    core1_dcache_disable_init;
   `endif // NDS_IO_DCACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCACHE0
   `ifdef NDS_IO_DCACHE0_CTRL_OUT
wire         [(`NDS_DCACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_tag0_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_DCACHE0_CTRL_OUT
   `ifdef NDS_IO_DCACHE_CTRL_OUT
wire        [(`NDS_DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_data0_ctrl_out; // dangler: () => ()
wire        [(`NDS_DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_data1_ctrl_out; // dangler: () => ()
wire        [(`NDS_DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_data2_ctrl_out; // dangler: () => ()
wire        [(`NDS_DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_data3_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_BTB_RAM_CTRL_OUT
wire                [(`NDS_BTB_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_core1_btb0_ctrl_out; // dangler: () => ()
wire                [(`NDS_BTB_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_core1_btb1_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_BTB_RAM_CTRL_OUT
   `ifdef NDS_IO_BTB2_RAM_CTRL_OUT
wire                [(`NDS_BTB_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_core1_btb2_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_BTB2_RAM_CTRL_OUT
   `ifdef NDS_IO_BTB3_RAM_CTRL_OUT
wire                [(`NDS_BTB_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_core1_btb3_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_BTB3_RAM_CTRL_OUT
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ILM_RAM0
   `ifdef NDS_IO_ILM_RAM0_CTRL_OUT
wire                [(`NDS_ILM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_ilm0_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
   `ifdef NDS_IO_ILM_RAM1_CTRL_OUT
wire                [(`NDS_ILM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_ilm1_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
   `ifdef NDS_IO_DLM_RAM0_CTRL_OUT
wire                [(`NDS_DLM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dlm_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
   `ifdef NDS_IO_DLM_RAM1_CTRL_OUT
wire                [(`NDS_DLM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dlm1_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
   `ifdef NDS_IO_DLM_RAM2_CTRL_OUT
wire                [(`NDS_DLM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dlm2_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
   `ifdef NDS_IO_DLM_RAM3_CTRL_OUT
wire                [(`NDS_DLM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dlm3_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_BTB_RAM
wire                    [(`NDS_BTB_RAM_ADDR_WIDTH)-1:0] dcls_inject_fault_btb0_addr;
wire                                                    dcls_inject_fault_btb0_cs;
wire                    [(`NDS_BTB_RAM_DATA_WIDTH)-1:0] dcls_inject_fault_btb0_wdata;
wire                                                    dcls_inject_fault_btb0_we;
wire                    [(`NDS_BTB_RAM_ADDR_WIDTH)-1:0] dcls_inject_fault_btb1_addr;
wire                                                    dcls_inject_fault_btb1_cs;
wire                    [(`NDS_BTB_RAM_DATA_WIDTH)-1:0] dcls_inject_fault_btb1_wdata;
wire                                                    dcls_inject_fault_btb1_we;
   `endif // NDS_IO_BTB_RAM
   `ifdef NDS_IO_BTB2_RAM
wire                    [(`NDS_BTB_RAM_ADDR_WIDTH)-1:0] dcls_inject_fault_btb2_addr;
wire                                                    dcls_inject_fault_btb2_cs;
wire                    [(`NDS_BTB_RAM_DATA_WIDTH)-1:0] dcls_inject_fault_btb2_wdata;
wire                                                    dcls_inject_fault_btb2_we;
   `endif // NDS_IO_BTB2_RAM
   `ifdef NDS_IO_BTB3_RAM
wire                    [(`NDS_BTB_RAM_ADDR_WIDTH)-1:0] dcls_inject_fault_btb3_addr;
wire                                                    dcls_inject_fault_btb3_cs;
wire                    [(`NDS_BTB_RAM_DATA_WIDTH)-1:0] dcls_inject_fault_btb3_wdata;
wire                                                    dcls_inject_fault_btb3_we;
   `endif // NDS_IO_BTB3_RAM
   `ifdef NDS_IO_DCACHE1
wire                     [(`NDS_DCACHE_TAG_RAM_AW)-1:0] dcls_inject_fault_dcache_tag1_addr;
wire                                                    dcls_inject_fault_dcache_tag1_cs;
wire                     [(`NDS_DCACHE_TAG_RAM_DW)-1:0] dcls_inject_fault_dcache_tag1_wdata;
wire                                                    dcls_inject_fault_dcache_tag1_we;
   `endif // NDS_IO_DCACHE1
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE1
   `ifdef NDS_IO_DCACHE1_CTRL_OUT
wire         [(`NDS_DCACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_tag1_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_DCACHE1_CTRL_OUT
`endif // NDS_IO_DCACHE1
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_DCACHE2
wire                     [(`NDS_DCACHE_TAG_RAM_AW)-1:0] dcls_inject_fault_dcache_tag2_addr;
wire                                                    dcls_inject_fault_dcache_tag2_cs;
wire                     [(`NDS_DCACHE_TAG_RAM_DW)-1:0] dcls_inject_fault_dcache_tag2_wdata;
wire                                                    dcls_inject_fault_dcache_tag2_we;
wire                     [(`NDS_DCACHE_TAG_RAM_AW)-1:0] dcls_inject_fault_dcache_tag3_addr;
wire                                                    dcls_inject_fault_dcache_tag3_cs;
wire                     [(`NDS_DCACHE_TAG_RAM_DW)-1:0] dcls_inject_fault_dcache_tag3_wdata;
wire                                                    dcls_inject_fault_dcache_tag3_we;
   `endif // NDS_IO_DCACHE2
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE2
   `ifdef NDS_IO_DCACHE2_CTRL_OUT
wire         [(`NDS_DCACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_tag2_ctrl_out; // dangler: () => ()
wire         [(`NDS_DCACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_tag3_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_DCACHE2_CTRL_OUT
`endif // NDS_IO_DCACHE2
`ifdef NDS_IO_ILM_TL_UL
   `ifdef NDS_IO_ILM_RAM_ECC
wire              [((`NDS_ILM_RAM_CTRL_OUT_WIDTH)-1):0] nds_unused_tl_ul_core0_ilm0_ctrl_out; // dangler: () => ()
wire              [((`NDS_ILM_RAM_CTRL_OUT_WIDTH)-1):0] nds_unused_tl_ul_core0_ilm1_ctrl_out; // dangler: () => ()
   `else
wire              [((`NDS_ILM_RAM_CTRL_OUT_WIDTH)-1):0] nds_unused_tl_ul_core0_ilm0_ctrl_out; // dangler: () => ()
wire              [((`NDS_ILM_RAM_CTRL_OUT_WIDTH)-1):0] nds_unused_tl_ul_core0_ilm1_ctrl_out; // dangler: () => ()
   `endif // NDS_IO_ILM_RAM_ECC
`endif // NDS_IO_ILM_TL_UL
`ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
`else
   `ifdef PLATFORM_DEBUG_SUBSYSTEM
wire                                       [ADDR_MSB:0] dm_sys_araddr;
wire                                              [1:0] dm_sys_arburst;
wire                                              [3:0] dm_sys_arcache;
wire                                     [BIU_ID_MSB:0] dm_sys_arid;
wire                                              [7:0] dm_sys_arlen;
wire                                                    dm_sys_arlock;
wire                                              [2:0] dm_sys_arprot;
wire                                                    dm_sys_arready;
wire                                              [2:0] dm_sys_arsize;
wire                                       [ADDR_MSB:0] dm_sys_awaddr;
wire                                              [1:0] dm_sys_awburst;
wire                                              [3:0] dm_sys_awcache;
wire                                     [BIU_ID_MSB:0] dm_sys_awid;
wire                                              [7:0] dm_sys_awlen;
wire                                                    dm_sys_awlock;
wire                                              [2:0] dm_sys_awprot;
wire                                                    dm_sys_awready;
wire                                              [2:0] dm_sys_awsize;
wire                                     [BIU_ID_MSB:0] dm_sys_bid;
wire                                              [1:0] dm_sys_bresp;
wire                                                    dm_sys_bvalid;
wire                             [(BIU_DATA_WIDTH-1):0] dm_sys_rdata;
wire                                     [BIU_ID_MSB:0] dm_sys_rid;
wire                                                    dm_sys_rlast;
wire                                              [1:0] dm_sys_rresp;
wire                                                    dm_sys_rvalid;
wire                                                    dm_sys_wready;
wire                                                    dm_sys_arvalid;
wire                                                    dm_sys_awvalid;
wire                                                    dm_sys_bready;
wire                                                    dm_sys_rready;
wire                             [(BIU_DATA_WIDTH-1):0] dm_sys_wdata;
wire                                                    dm_sys_wlast;
wire                         [((BIU_DATA_WIDTH/8)-1):0] dm_sys_wstrb;
wire                                                    dm_sys_wvalid;
   `endif // PLATFORM_DEBUG_SUBSYSTEM
`endif // PLATFORM_PLDM_SYS_BUS_ACCESS
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
   `ifdef ATCBUSDEC302_SLV1_SUPPORT
wire                                                    slvp_busdec_ds1_arready;
wire                                                    slvp_busdec_ds1_awready;
wire                                              [1:0] slvp_busdec_ds1_bresp;
wire                                                    slvp_busdec_ds1_bvalid;
wire                               [SLVPORT_DATA_MSB:0] slvp_busdec_ds1_rdata;
wire                                                    slvp_busdec_ds1_rlast;
wire                                              [1:0] slvp_busdec_ds1_rresp;
wire                                                    slvp_busdec_ds1_rvalid;
wire                                                    slvp_busdec_ds1_wready;
wire                                                    slvp_busdec_ds1_arvalid;
wire                                                    slvp_busdec_ds1_awvalid;
wire                                                    slvp_busdec_ds1_bready;
wire                                                    slvp_busdec_ds1_rready;
wire                                                    slvp_busdec_ds1_wvalid;
   `endif // ATCBUSDEC302_SLV1_SUPPORT
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_DCLS_SPLIT
      `ifdef NDS_IO_SLAVEPORT_COMMON_X2
wire                                                    nds_unused_core1_slv1_arready; // dangler: () => ()
wire                                                    nds_unused_core1_slv1_awready; // dangler: () => ()
wire                 [((`NDS_SLAVE_PORT_ID_WIDTH)-1):0] nds_unused_core1_slv1_bid; // dangler: () => ()
wire                                              [1:0] nds_unused_core1_slv1_bresp; // dangler: () => ()
wire                                                    nds_unused_core1_slv1_bvalid; // dangler: () => ()
wire               [((`NDS_SLAVE_PORT_DATA_WIDTH)-1):0] nds_unused_core1_slv1_rdata; // dangler: () => ()
wire                 [((`NDS_SLAVE_PORT_ID_WIDTH)-1):0] nds_unused_core1_slv1_rid; // dangler: () => ()
wire                                                    nds_unused_core1_slv1_rlast; // dangler: () => ()
wire                                              [1:0] nds_unused_core1_slv1_rresp; // dangler: () => ()
wire                                                    nds_unused_core1_slv1_rvalid; // dangler: () => ()
wire                                                    nds_unused_core1_slv1_wready; // dangler: () => ()
      `endif // NDS_IO_SLAVEPORT_COMMON_X2
      `ifdef NDS_IO_EDC_AFTER_ECC
wire                                                    nds_unused_core1_fs_edc_error; // dangler: () => ()
      `endif // NDS_IO_EDC_AFTER_ECC
      `ifdef NDS_IO_SLAVEPORT_ECC_X1
wire               [(((`NDS_SLV_ADDR_CODE_WIDTH))-1):0] core1_slv_araddrcode; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core1_slv_arctl0code; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core1_slv_arctl1code; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core1_slv_aridcode; // dangler: () <= ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] core1_slv_arutid; // dangler: () <= ()
wire                                                    core1_slv_arvalidcode; // dangler: () <= ()
wire               [(((`NDS_SLV_ADDR_CODE_WIDTH))-1):0] core1_slv_awaddrcode; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core1_slv_awctl0code; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core1_slv_awctl1code; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core1_slv_awidcode; // dangler: () <= ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] core1_slv_awutid; // dangler: () <= ()
wire                                                    core1_slv_awvalidcode; // dangler: () <= ()
wire                                                    core1_slv_breadycode; // dangler: () <= ()
wire                                                    core1_slv_rreadycode; // dangler: () <= ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core1_slv_wctlcode; // dangler: () <= ()
wire               [(((`NDS_SLV_DATA_CODE_WIDTH))-1):0] core1_slv_wdatacode; // dangler: () <= ()
wire                                                    core1_slv_weobi; // dangler: () <= ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] core1_slv_wutid; // dangler: () <= ()
wire                                                    core1_slv_wvalidcode; // dangler: () <= ()
wire                                              [7:0] core1_fs_bus_s_protection_error; // dangler: () => ()
wire                                                    core1_slv_arreadycode; // dangler: () => ()
wire                                                    core1_slv_awreadycode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core1_slv_bctlcode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core1_slv_bidcode; // dangler: () => ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] core1_slv_butid; // dangler: () => ()
wire                                                    core1_slv_bvalidcode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core1_slv_rctlcode; // dangler: () => ()
wire               [(((`NDS_SLV_DATA_CODE_WIDTH))-1):0] core1_slv_rdatacode; // dangler: () => ()
wire                                                    core1_slv_reobi; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] core1_slv_ridcode; // dangler: () => ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] core1_slv_rutid; // dangler: () => ()
wire                                                    core1_slv_rvalidcode; // dangler: () => ()
wire                                                    core1_slv_wreadycode; // dangler: () => ()
      `endif // NDS_IO_SLAVEPORT_ECC_X1
      `ifdef NDS_IO_SLAVEPORT_ECC_X2
wire                                              [7:0] nds_unused_core1_fs_bus_s1_protection_error; // dangler: () => ()
wire                                                    nds_unused_core1_slv1_arreadycode; // dangler: () => ()
wire                                                    nds_unused_core1_slv1_awreadycode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] nds_unused_core1_slv1_bctlcode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] nds_unused_core1_slv1_bidcode; // dangler: () => ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] nds_unused_core1_slv1_butid; // dangler: () => ()
wire                                                    nds_unused_core1_slv1_bvalidcode; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] nds_unused_core1_slv1_rctlcode; // dangler: () => ()
wire               [(((`NDS_SLV_DATA_CODE_WIDTH))-1):0] nds_unused_core1_slv1_rdatacode; // dangler: () => ()
wire                                                    nds_unused_core1_slv1_reobi; // dangler: () => ()
wire               [(((`NDS_SLV_CTRL_CODE_WIDTH))-1):0] nds_unused_core1_slv1_ridcode; // dangler: () => ()
wire                    [(((`NDS_SLV_UTID_WIDTH))-1):0] nds_unused_core1_slv1_rutid; // dangler: () => ()
wire                                                    nds_unused_core1_slv1_rvalidcode; // dangler: () => ()
wire                                                    nds_unused_core1_slv1_wreadycode; // dangler: () => ()
      `endif // NDS_IO_SLAVEPORT_ECC_X2
      `ifdef NDS_IO_LM_RESET
wire                                                    core1_lm_reset_n;
      `endif // NDS_IO_LM_RESET
      `ifdef NDS_IO_ILM_TL_UL
wire                                              [1:0] core1_ilm_a_user; // dangler: () => ()
      `endif // NDS_IO_ILM_TL_UL
      `ifdef NDS_IO_ICACHE0
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data10_addr;
wire                                                    dcls_inject_fault_icache_data10_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data10_wdata;
wire                                                    dcls_inject_fault_icache_data10_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data11_addr;
wire                                                    dcls_inject_fault_icache_data11_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data11_wdata;
wire                                                    dcls_inject_fault_icache_data11_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data12_addr;
wire                                                    dcls_inject_fault_icache_data12_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data12_wdata;
wire                                                    dcls_inject_fault_icache_data12_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data13_addr;
wire                                                    dcls_inject_fault_icache_data13_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data13_wdata;
wire                                                    dcls_inject_fault_icache_data13_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data14_addr;
wire                                                    dcls_inject_fault_icache_data14_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data14_wdata;
wire                                                    dcls_inject_fault_icache_data14_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data15_addr;
wire                                                    dcls_inject_fault_icache_data15_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data15_wdata;
wire                                                    dcls_inject_fault_icache_data15_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data8_addr;
wire                                                    dcls_inject_fault_icache_data8_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data8_wdata;
wire                                                    dcls_inject_fault_icache_data8_we;
wire                    [(`NDS_ICACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_icache_data9_addr;
wire                                                    dcls_inject_fault_icache_data9_cs;
wire                    [(`NDS_ICACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_icache_data9_wdata;
wire                                                    dcls_inject_fault_icache_data9_we;
      `endif // NDS_IO_ICACHE0
      `ifdef NDS_IO_UEIP
wire                                                    nds_unused_core1_ueiack; // dangler: () => ()
      `endif // NDS_IO_UEIP
      `ifdef NDS_IO_TRAP_STATUS
wire                                                    nds_unused_core1_fs_halt_mode; // dangler: () => ()
wire                                              [9:0] nds_unused_core1_fs_trap_status_cause; // dangler: () => ()
wire                                              [2:0] nds_unused_core1_fs_trap_status_dcause; // dangler: () => ()
wire                                                    nds_unused_core1_fs_trap_status_interrupt; // dangler: () => ()
wire                                                    nds_unused_core1_fs_trap_status_nmi; // dangler: () => ()
wire                                                    nds_unused_core1_fs_trap_status_taken; // dangler: () => ()
      `endif // NDS_IO_TRAP_STATUS
      `ifdef NDS_IO_ILM_RAM0
wire                            [(`NDS_ILM_RAM_AW-1):0] dcls_inject_fault_ilm2_addr;
wire                          [(`NDS_ILM_RAM_BWEW)-1:0] dcls_inject_fault_ilm2_byte_we;
wire                                                    dcls_inject_fault_ilm2_cs;
wire                            [(`NDS_ILM_RAM_DW)-1:0] dcls_inject_fault_ilm2_wdata;
wire                                                    dcls_inject_fault_ilm2_we;
      `endif // NDS_IO_ILM_RAM0
      `ifdef NDS_IO_ILM_RAM1
wire                            [(`NDS_ILM_RAM_AW-1):0] dcls_inject_fault_ilm3_addr;
wire                          [(`NDS_ILM_RAM_BWEW)-1:0] dcls_inject_fault_ilm3_byte_we;
wire                                                    dcls_inject_fault_ilm3_cs;
wire                            [(`NDS_ILM_RAM_DW)-1:0] dcls_inject_fault_ilm3_wdata;
wire                                                    dcls_inject_fault_ilm3_we;
      `endif // NDS_IO_ILM_RAM1
      `ifdef NDS_IO_DLM_RAM0
wire                            [(`NDS_DLM_RAM_AW-1):0] dcls_inject_fault_dlm4_addr;
wire                          [(`NDS_DLM_RAM_BWEW-1):0] dcls_inject_fault_dlm4_byte_we;
wire                                                    dcls_inject_fault_dlm4_cs;
wire                            [(`NDS_DLM_RAM_DW)-1:0] dcls_inject_fault_dlm4_wdata;
wire                                                    dcls_inject_fault_dlm4_we;
      `endif // NDS_IO_DLM_RAM0
      `ifdef NDS_IO_DLM_RAM1
wire                            [(`NDS_DLM_RAM_AW-1):0] dcls_inject_fault_dlm5_addr;
wire                          [(`NDS_DLM_RAM_BWEW-1):0] dcls_inject_fault_dlm5_byte_we;
wire                                                    dcls_inject_fault_dlm5_cs;
wire                            [(`NDS_DLM_RAM_DW)-1:0] dcls_inject_fault_dlm5_wdata;
wire                                                    dcls_inject_fault_dlm5_we;
      `endif // NDS_IO_DLM_RAM1
      `ifdef NDS_IO_DLM_RAM2
wire                            [(`NDS_DLM_RAM_AW-1):0] dcls_inject_fault_dlm6_addr;
wire                          [(`NDS_DLM_RAM_BWEW-1):0] dcls_inject_fault_dlm6_byte_we;
wire                                                    dcls_inject_fault_dlm6_cs;
wire                            [(`NDS_DLM_RAM_DW)-1:0] dcls_inject_fault_dlm6_wdata;
wire                                                    dcls_inject_fault_dlm6_we;
      `endif // NDS_IO_DLM_RAM2
      `ifdef NDS_IO_DLM_RAM3
wire                            [(`NDS_DLM_RAM_AW-1):0] dcls_inject_fault_dlm7_addr;
wire                          [(`NDS_DLM_RAM_BWEW-1):0] dcls_inject_fault_dlm7_byte_we;
wire                                                    dcls_inject_fault_dlm7_cs;
wire                            [(`NDS_DLM_RAM_DW)-1:0] dcls_inject_fault_dlm7_wdata;
wire                                                    dcls_inject_fault_dlm7_we;
      `endif // NDS_IO_DLM_RAM3
   `endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_ICACHE0
      `ifdef NDS_IO_ICACHE0_CTRL_OUT
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data10_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data11_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data12_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data13_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data14_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data15_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data8_ctrl_out; // dangler: () => ()
wire        [(`NDS_ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_icache_data9_ctrl_out; // dangler: () => ()
      `endif // NDS_IO_ICACHE0_CTRL_OUT
   `endif // NDS_IO_ICACHE0
   `ifdef NDS_IO_ILM_RAM0
      `ifdef NDS_IO_ILM_RAM0_CTRL_OUT
wire                [(`NDS_ILM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_ilm2_ctrl_out; // dangler: () => ()
      `endif // NDS_IO_ILM_RAM0_CTRL_OUT
   `endif // NDS_IO_ILM_RAM0
   `ifdef NDS_IO_ILM_RAM1
      `ifdef NDS_IO_ILM_RAM1_CTRL_OUT
wire                [(`NDS_ILM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_ilm3_ctrl_out; // dangler: () => ()
      `endif // NDS_IO_ILM_RAM1_CTRL_OUT
   `endif // NDS_IO_ILM_RAM1
   `ifdef NDS_IO_DLM_RAM0
      `ifdef NDS_IO_DLM_RAM0_CTRL_OUT
wire                [(`NDS_DLM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dlm4_ctrl_out; // dangler: () => ()
      `endif // NDS_IO_DLM_RAM0_CTRL_OUT
   `endif // NDS_IO_DLM_RAM0
   `ifdef NDS_IO_DLM_RAM1
      `ifdef NDS_IO_DLM_RAM1_CTRL_OUT
wire                [(`NDS_DLM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dlm5_ctrl_out; // dangler: () => ()
      `endif // NDS_IO_DLM_RAM1_CTRL_OUT
   `endif // NDS_IO_DLM_RAM1
   `ifdef NDS_IO_DLM_RAM2
      `ifdef NDS_IO_DLM_RAM2_CTRL_OUT
wire                [(`NDS_DLM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dlm6_ctrl_out; // dangler: () => ()
      `endif // NDS_IO_DLM_RAM2_CTRL_OUT
   `endif // NDS_IO_DLM_RAM2
   `ifdef NDS_IO_DLM_RAM3
      `ifdef NDS_IO_DLM_RAM3_CTRL_OUT
wire                [(`NDS_DLM_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dlm7_ctrl_out; // dangler: () => ()
      `endif // NDS_IO_DLM_RAM3_CTRL_OUT
   `endif // NDS_IO_DLM_RAM3
   `ifdef NDS_IO_ILM_TL_UL
      `ifdef NDS_IO_ILM_RAM_ECC
wire              [((`NDS_ILM_RAM_CTRL_OUT_WIDTH)-1):0] nds_unused_tl_ul_core1_ilm0_ctrl_out; // dangler: () => ()
wire              [((`NDS_ILM_RAM_CTRL_OUT_WIDTH)-1):0] nds_unused_tl_ul_core1_ilm1_ctrl_out; // dangler: () => ()
      `else
wire              [((`NDS_ILM_RAM_CTRL_OUT_WIDTH)-1):0] nds_unused_tl_ul_core1_ilm0_ctrl_out; // dangler: () => ()
wire              [((`NDS_ILM_RAM_CTRL_OUT_WIDTH)-1):0] nds_unused_tl_ul_core1_ilm1_ctrl_out; // dangler: () => ()
      `endif // NDS_IO_ILM_RAM_ECC
   `endif // NDS_IO_ILM_TL_UL
   `ifdef NDS_IO_DCLS
      `ifdef NDS_IO_DCACHE0
wire                    [(`NDS_DCACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_dcache_data4_addr;
wire                  [(`NDS_DCACHE_DATA_RAM_BWEW)-1:0] dcls_inject_fault_dcache_data4_byte_we;
wire                                                    dcls_inject_fault_dcache_data4_cs;
wire                    [(`NDS_DCACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_dcache_data4_wdata;
wire                                                    dcls_inject_fault_dcache_data4_we;
wire                    [(`NDS_DCACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_dcache_data5_addr;
wire                  [(`NDS_DCACHE_DATA_RAM_BWEW)-1:0] dcls_inject_fault_dcache_data5_byte_we;
wire                                                    dcls_inject_fault_dcache_data5_cs;
wire                    [(`NDS_DCACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_dcache_data5_wdata;
wire                                                    dcls_inject_fault_dcache_data5_we;
wire                    [(`NDS_DCACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_dcache_data6_addr;
wire                  [(`NDS_DCACHE_DATA_RAM_BWEW)-1:0] dcls_inject_fault_dcache_data6_byte_we;
wire                                                    dcls_inject_fault_dcache_data6_cs;
wire                    [(`NDS_DCACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_dcache_data6_wdata;
wire                                                    dcls_inject_fault_dcache_data6_we;
wire                    [(`NDS_DCACHE_DATA_RAM_AW)-1:0] dcls_inject_fault_dcache_data7_addr;
wire                  [(`NDS_DCACHE_DATA_RAM_BWEW)-1:0] dcls_inject_fault_dcache_data7_byte_we;
wire                                                    dcls_inject_fault_dcache_data7_cs;
wire                    [(`NDS_DCACHE_DATA_RAM_DW)-1:0] dcls_inject_fault_dcache_data7_wdata;
wire                                                    dcls_inject_fault_dcache_data7_we;
      `endif // NDS_IO_DCACHE0
   `endif // NDS_IO_DCLS
   `ifdef NDS_IO_DCACHE0
      `ifdef NDS_IO_DCACHE_CTRL_OUT
wire        [(`NDS_DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_data4_ctrl_out; // dangler: () => ()
wire        [(`NDS_DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_data5_ctrl_out; // dangler: () => ()
wire        [(`NDS_DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_data6_ctrl_out; // dangler: () => ()
wire        [(`NDS_DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] nds_unused_dcache_data7_ctrl_out; // dangler: () => ()
      `endif // NDS_IO_DCACHE_CTRL_OUT
   `endif // NDS_IO_DCACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_BUS_PROTECTION
   `ifdef NDS_IO_FLASHIF0
      `ifdef ATCBMC301_MST1_SUPPORT
wire                            [FLASHIF0_ID_WIDTH-1:0] axi_flash0_bid_in;
wire                            [FLASHIF0_ID_WIDTH-1:0] axi_flash0_rid_in;
wire                            [FLASHIF0_ID_WIDTH-1:0] axi_flash0_arid_out;
wire                            [FLASHIF0_ID_WIDTH-1:0] axi_flash0_awid_out;
wire                                                    nds_unused_flash0_event_ctl_err; // dangler: () => ()
wire                                                    nds_unused_flash0_event_data_err; // dangler: () => ()
wire                                                    nds_unused_flash0_event_eobi_err; // dangler: () => ()
wire                                                    nds_unused_flash0_event_handshake_err; // dangler: () => ()
      `endif // ATCBMC301_MST1_SUPPORT
   `endif // NDS_IO_FLASHIF0
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_HART1
   `ifdef NDS_IO_SLAVEPORT_COMMON_X1
      `ifdef ATCBUSDEC302_SLV2_SUPPORT
wire                                                    slvp_busdec_ds2_arready;
wire                                                    slvp_busdec_ds2_awready;
wire                                              [1:0] slvp_busdec_ds2_bresp;
wire                                                    slvp_busdec_ds2_bvalid;
wire                               [SLVPORT_DATA_MSB:0] slvp_busdec_ds2_rdata;
wire                                                    slvp_busdec_ds2_rlast;
wire                                              [1:0] slvp_busdec_ds2_rresp;
wire                                                    slvp_busdec_ds2_rvalid;
wire                                                    slvp_busdec_ds2_wready;
wire                                                    slvp_busdec_ds2_arvalid;
wire                                                    slvp_busdec_ds2_awvalid;
wire                                                    slvp_busdec_ds2_bready;
wire                                                    slvp_busdec_ds2_rready;
wire                                                    slvp_busdec_ds2_wvalid;
      `endif // ATCBUSDEC302_SLV2_SUPPORT
   `endif // NDS_IO_SLAVEPORT_COMMON_X1
`endif // NDS_IO_HART1
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
   `ifdef ATCBUSDEC302_SLV3_SUPPORT
      `ifdef NDS_IO_HART2
wire                                                    nds_unused_u_slvp_busdec_ds3_arvalid; // dangler: () => ()
wire                                                    nds_unused_u_slvp_busdec_ds3_awvalid; // dangler: () => ()
wire                                                    nds_unused_u_slvp_busdec_ds3_bready; // dangler: () => ()
wire                                                    nds_unused_u_slvp_busdec_ds3_rready; // dangler: () => ()
wire                                                    nds_unused_u_slvp_busdec_ds3_wvalid; // dangler: () => ()
      `endif // NDS_IO_HART2
   `endif // ATCBUSDEC302_SLV3_SUPPORT
   `ifdef ATCBUSDEC302_SLV4_SUPPORT
      `ifdef NDS_IO_HART3
wire                                                    nds_unused_u_slvp_busdec_ds4_arvalid; // dangler: () => ()
wire                                                    nds_unused_u_slvp_busdec_ds4_awvalid; // dangler: () => ()
wire                                                    nds_unused_u_slvp_busdec_ds4_bready; // dangler: () => ()
wire                                                    nds_unused_u_slvp_busdec_ds4_rready; // dangler: () => ()
wire                                                    nds_unused_u_slvp_busdec_ds4_wvalid; // dangler: () => ()
      `endif // NDS_IO_HART3
   `endif // ATCBUSDEC302_SLV4_SUPPORT
`endif // NDS_IO_SLAVEPORT_COMMON_X1
wire                                       [ADDR_MSB:0] busdec_us_araddr;
wire                                              [1:0] busdec_us_arburst;
wire                                              [3:0] busdec_us_arcache;
wire                                   [BIU_ID_MSB+4:0] busdec_us_arid;
wire                                              [7:0] busdec_us_arlen;
wire                                                    busdec_us_arlock;
wire                                              [2:0] busdec_us_arprot;
wire                                              [2:0] busdec_us_arsize;
wire                                                    busdec_us_arvalid;
wire                                       [ADDR_MSB:0] busdec_us_awaddr;
wire                                              [1:0] busdec_us_awburst;
wire                                              [3:0] busdec_us_awcache;
wire                                   [BIU_ID_MSB+4:0] busdec_us_awid;
wire                                              [7:0] busdec_us_awlen;
wire                                                    busdec_us_awlock;
wire                                              [2:0] busdec_us_awprot;
wire                                              [2:0] busdec_us_awsize;
wire                                                    busdec_us_awvalid;
wire                                                    busdec_us_bready;
wire                                                    busdec_us_rready;
wire                                   [NCE_DATA_MSB:0] busdec_us_wdata;
wire                                                    busdec_us_wlast;
wire                                  [NCE_WSTRB_MSB:0] busdec_us_wstrb;
wire                                                    busdec_us_wvalid;
wire                                                    core0_clk;
wire                                                    core0_lm_clk;
wire                                              [9:0] core0_meiid;
wire                                                    core0_meip;
wire                                                    core0_nmi;
wire                                                    core0_reset_n;
wire                                      [(VALEN-1):0] core0_reset_vector;
wire                                                    core0_slv1_clk_en;
wire                                                    core0_slv_clk;
wire                                                    core0_slv_clk_en;
wire                                                    core0_slvp_reset_n;
wire                                      [(NHART-1):0] dm_hart_unavail;
wire                                      [(NHART-1):0] dm_hart_under_reset;
wire                                                    hart0_meiack;
wire                                                    hart0_mtip;
wire                                                    hart0_seiack;
wire                                                    hart1_meiack;
wire                                                    hart1_seiack;
wire                                       [ADDR_MSB:0] plic_araddr;
wire                                              [1:0] plic_arburst;
wire                                              [3:0] plic_arcache;
wire                                              [7:0] plic_arlen;
wire                                                    plic_arlock;
wire                                              [2:0] plic_arprot;
wire                                              [2:0] plic_arsize;
wire                                       [ADDR_MSB:0] plic_awaddr;
wire                                              [1:0] plic_awburst;
wire                                              [3:0] plic_awcache;
wire                                              [7:0] plic_awlen;
wire                                                    plic_awlock;
wire                                              [2:0] plic_awprot;
wire                                              [2:0] plic_awsize;
wire                                   [NCE_DATA_MSB:0] plic_wdata;
wire                                                    plic_wlast;
wire                                  [NCE_WSTRB_MSB:0] plic_wstrb;
wire                                       [ADDR_MSB:0] plicsw_araddr;
wire                                              [1:0] plicsw_arburst;
wire                                              [3:0] plicsw_arcache;
wire                                              [7:0] plicsw_arlen;
wire                                                    plicsw_arlock;
wire                                              [2:0] plicsw_arprot;
wire                                              [2:0] plicsw_arsize;
wire                                       [ADDR_MSB:0] plicsw_awaddr;
wire                                              [1:0] plicsw_awburst;
wire                                              [3:0] plicsw_awcache;
wire                                              [7:0] plicsw_awlen;
wire                                                    plicsw_awlock;
wire                                              [2:0] plicsw_awprot;
wire                                              [2:0] plicsw_awsize;
wire                                   [NCE_DATA_MSB:0] plicsw_wdata;
wire                                                    plicsw_wlast;
wire                                  [NCE_WSTRB_MSB:0] plicsw_wstrb;
wire                                       [ADDR_MSB:0] plmt_araddr;
wire                                              [1:0] plmt_arburst;
wire                                              [3:0] plmt_arcache;
wire                                              [7:0] plmt_arlen;
wire                                                    plmt_arlock;
wire                                              [2:0] plmt_arprot;
wire                                              [2:0] plmt_arsize;
wire                                       [ADDR_MSB:0] plmt_awaddr;
wire                                              [1:0] plmt_awburst;
wire                                              [3:0] plmt_awcache;
wire                                              [7:0] plmt_awlen;
wire                                                    plmt_awlock;
wire                                              [2:0] plmt_awprot;
wire                                              [2:0] plmt_awsize;
wire                                   [NCE_DATA_MSB:0] plmt_wdata;
wire                                                    plmt_wlast;
wire                                  [NCE_WSTRB_MSB:0] plmt_wstrb;
wire                                                    stoptime;
wire                                              [3:0] nds_unused_arqos; // dangler: () => ()
wire                                              [3:0] nds_unused_arregion; // dangler: () => ()
wire                                              [3:0] nds_unused_awqos; // dangler: () => ()
wire                                              [3:0] nds_unused_awregion; // dangler: () => ()
wire                                                    sys_exmon_arready;
wire                                                    sys_exmon_awready;
wire                               [(BIU_ID_WIDTH-1):0] sys_exmon_bid;
wire                                              [1:0] sys_exmon_bresp;
wire                                                    sys_exmon_bvalid;
wire                             [(BIU_DATA_WIDTH-1):0] sys_exmon_rdata;
wire                               [(BIU_ID_WIDTH-1):0] sys_exmon_rid;
wire                                                    sys_exmon_rlast;
wire                                              [1:0] sys_exmon_rresp;
wire                                                    sys_exmon_rvalid;
wire                                                    sys_exmon_wready;
wire                                                    axi_sys0_arready;
wire                                                    axi_sys0_awready;
wire                             [((BIU_ID_WIDTH)-1):0] axi_sys0_bid;
wire                                              [1:0] axi_sys0_bresp;
wire                                                    axi_sys0_bvalid;
wire                           [((BIU_DATA_WIDTH)-1):0] axi_sys0_rdata;
wire                             [((BIU_ID_WIDTH)-1):0] axi_sys0_rid;
wire                                                    axi_sys0_rlast;
wire                                              [1:0] axi_sys0_rresp;
wire                                                    axi_sys0_rvalid;
wire                                                    axi_sys0_wready;
wire                                       [ADDR_MSB:0] inter_ds1_araddr;
wire                                              [1:0] inter_ds1_arburst;
wire                                              [3:0] inter_ds1_arcache;
wire                                     [BIU_ID_MSB:0] inter_ds1_arid;
wire                                              [3:0] inter_ds1_arid_dummy;
wire                                              [7:0] inter_ds1_arlen;
wire                                                    inter_ds1_arlock;
wire                                              [2:0] inter_ds1_arprot;
wire                                              [2:0] inter_ds1_arsize;
wire                                                    inter_ds1_arvalid;
wire                                       [ADDR_MSB:0] inter_ds1_awaddr;
wire                                              [1:0] inter_ds1_awburst;
wire                                              [3:0] inter_ds1_awcache;
wire                                     [BIU_ID_MSB:0] inter_ds1_awid;
wire                                              [3:0] inter_ds1_awid_dummy;
wire                                              [7:0] inter_ds1_awlen;
wire                                                    inter_ds1_awlock;
wire                                              [2:0] inter_ds1_awprot;
wire                                              [2:0] inter_ds1_awsize;
wire                                                    inter_ds1_awvalid;
wire                                                    inter_ds1_bready;
wire                                                    inter_ds1_rready;
wire                                   [BIU_DATA_MSB:0] inter_ds1_wdata;
wire                                                    inter_ds1_wlast;
wire                                  [BIU_WSTRB_MSB:0] inter_ds1_wstrb;
wire                                                    inter_ds1_wvalid;
wire                                 [(ADDR_WIDTH-1):0] sys_exmon_araddr;
wire                                              [1:0] sys_exmon_arburst;
wire                                              [3:0] sys_exmon_arcache;
wire                               [(BIU_ID_WIDTH-1):0] sys_exmon_arid;
wire                                              [3:0] sys_exmon_arid_dummy;
wire                                              [7:0] sys_exmon_arlen;
wire                                                    sys_exmon_arlock;
wire                                              [2:0] sys_exmon_arprot;
wire                                              [2:0] sys_exmon_arsize;
wire                                                    sys_exmon_arvalid;
wire                                 [(ADDR_WIDTH-1):0] sys_exmon_awaddr;
wire                                              [1:0] sys_exmon_awburst;
wire                                              [3:0] sys_exmon_awcache;
wire                               [(BIU_ID_WIDTH-1):0] sys_exmon_awid;
wire                                              [3:0] sys_exmon_awid_dummy;
wire                                              [7:0] sys_exmon_awlen;
wire                                                    sys_exmon_awlock;
wire                                              [2:0] sys_exmon_awprot;
wire                                              [2:0] sys_exmon_awsize;
wire                                                    sys_exmon_awvalid;
wire                                                    sys_exmon_bready;
wire                                                    sys_exmon_rready;
wire                             [(BIU_DATA_WIDTH-1):0] sys_exmon_wdata;
wire                                                    sys_exmon_wlast;
wire                           [(BIU_DATA_WIDTH/8)-1:0] sys_exmon_wstrb;
wire                                                    sys_exmon_wvalid;
wire                                       [ADDR_MSB:0] busdec2nce_araddr;
wire                                              [1:0] busdec2nce_arburst;
wire                                              [3:0] busdec2nce_arcache;
wire                                              [7:0] busdec2nce_arlen;
wire                                                    busdec2nce_arlock;
wire                                              [2:0] busdec2nce_arprot;
wire                                              [2:0] busdec2nce_arsize;
wire                                       [ADDR_MSB:0] busdec2nce_awaddr;
wire                                              [1:0] busdec2nce_awburst;
wire                                              [3:0] busdec2nce_awcache;
wire                                              [7:0] busdec2nce_awlen;
wire                                                    busdec2nce_awlock;
wire                                              [2:0] busdec2nce_awprot;
wire                                              [2:0] busdec2nce_awsize;
wire                                   [NCE_DATA_MSB:0] busdec2nce_wdata;
wire                                                    busdec2nce_wlast;
wire                                  [NCE_WSTRB_MSB:0] busdec2nce_wstrb;
wire                                                    busdec_us_arready;
wire                                                    busdec_us_awready;
wire                                   [BIU_ID_MSB+4:0] busdec_us_bid;
wire                                              [1:0] busdec_us_bresp;
wire                                                    busdec_us_bvalid;
wire                                   [NCE_DATA_MSB:0] busdec_us_rdata;
wire                                   [BIU_ID_MSB+4:0] busdec_us_rid;
wire                                                    busdec_us_rlast;
wire                                              [1:0] busdec_us_rresp;
wire                                                    busdec_us_rvalid;
wire                                                    busdec_us_wready;
wire                                                    plic_arvalid;
wire                                                    plic_awvalid;
wire                                                    plic_bready;
wire                                                    plic_rready;
wire                                                    plic_wvalid;
wire                                                    plicsw_arvalid;
wire                                                    plicsw_awvalid;
wire                                                    plicsw_bready;
wire                                                    plicsw_rready;
wire                                                    plicsw_wvalid;
wire                                                    plmt_arvalid;
wire                                                    plmt_awvalid;
wire                                                    plmt_bready;
wire                                                    plmt_rready;
wire                                                    plmt_wvalid;
wire                                                    inter_ds1_arready;
wire                                                    inter_ds1_awready;
wire                                     [BIU_ID_MSB:0] inter_ds1_bid;
wire                                              [3:0] inter_ds1_bid_dummy;
wire                                              [1:0] inter_ds1_bresp;
wire                                                    inter_ds1_bvalid;
wire                                   [BIU_DATA_MSB:0] inter_ds1_rdata;
wire                                     [BIU_ID_MSB:0] inter_ds1_rid;
wire                                              [3:0] inter_ds1_rid_dummy;
wire                                                    inter_ds1_rlast;
wire                                              [1:0] inter_ds1_rresp;
wire                                                    inter_ds1_rvalid;
wire                                                    inter_ds1_wready;
wire                           [((BIU_ADDR_WIDTH)-1):0] cluster_sys0_araddr;
wire                                              [1:0] cluster_sys0_arburst;
wire                                              [3:0] cluster_sys0_arcache;
wire                             [((BIU_ID_WIDTH)-1):0] cluster_sys0_arid;
wire                                              [7:0] cluster_sys0_arlen;
wire                                                    cluster_sys0_arlock;
wire                                              [2:0] cluster_sys0_arprot;
wire                                              [2:0] cluster_sys0_arsize;
wire                                                    cluster_sys0_arvalid;
wire                           [((BIU_ADDR_WIDTH)-1):0] cluster_sys0_awaddr;
wire                                              [1:0] cluster_sys0_awburst;
wire                                              [3:0] cluster_sys0_awcache;
wire                             [((BIU_ID_WIDTH)-1):0] cluster_sys0_awid;
wire                                              [7:0] cluster_sys0_awlen;
wire                                                    cluster_sys0_awlock;
wire                                              [2:0] cluster_sys0_awprot;
wire                                              [2:0] cluster_sys0_awsize;
wire                                                    cluster_sys0_awvalid;
wire                                                    cluster_sys0_bready;
wire                                                    cluster_sys0_rready;
wire                           [((BIU_DATA_WIDTH)-1):0] cluster_sys0_wdata;
wire                                                    cluster_sys0_wlast;
wire                         [((BIU_DATA_WIDTH)/8)-1:0] cluster_sys0_wstrb;
wire                                                    cluster_sys0_wvalid;
wire                                                    core0_meiack;
wire                                                    core0_wfi_mode;
wire                                      [(NHART-1):0] dm_debugint;
wire                                      [(NHART-1):0] dm_resethaltreq;
wire                                              [9:0] hart0_meiid;
wire                                                    hart0_meip;
wire                                              [9:0] hart0_seiid;
wire                                                    hart0_seip;
wire                                              [9:0] hart1_meiid;
wire                                                    hart1_meip;
wire                                              [9:0] hart1_seiid;
wire                                                    hart1_seip;
wire                                              [3:0] nds_unused_plic_bid; // dangler: () => ()
wire                             [(NCE_DATA_WIDTH-1):0] nds_unused_plic_hrdata; // dangler: () => ()
wire                                                    nds_unused_plic_hreadyout; // dangler: () => ()
wire                                              [1:0] nds_unused_plic_hresp; // dangler: () => ()
wire                                              [3:0] nds_unused_plic_rid; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t10_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t10_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t11_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t11_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t12_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t12_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t13_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t13_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t14_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t14_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t15_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t15_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t4_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t4_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t5_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t5_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t6_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t6_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t7_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t7_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t8_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t8_eip; // dangler: () => ()
wire                                              [9:0] nds_unused_plic_t9_eiid; // dangler: () => ()
wire                                                    nds_unused_plic_t9_eip; // dangler: () => ()
wire                                                    plic_arready;
wire                                                    plic_awready;
wire                                              [1:0] plic_bresp;
wire                                                    plic_bvalid;
wire                                   [NCE_DATA_MSB:0] plic_rdata;
wire                                                    plic_rlast;
wire                                              [1:0] plic_rresp;
wire                                                    plic_rvalid;
wire                                                    plic_wready;
wire                                                    hart0_msip;
wire                                                    hart1_msip;
wire                                                    plicsw_arready;
wire                                                    plicsw_awready;
wire                                              [1:0] plicsw_bresp;
wire                                                    plicsw_bvalid;
wire                                   [NCE_DATA_MSB:0] plicsw_rdata;
wire                                                    plicsw_rlast;
wire                                              [1:0] plicsw_rresp;
wire                                                    plicsw_rvalid;
wire                                                    plicsw_wready;
wire                                        [NHART-1:0] mtip;
wire                                              [3:0] nds_unused_plmt_bid; // dangler: () => ()
wire                             [(NCE_DATA_WIDTH-1):0] nds_unused_plmt_hrdata; // dangler: () => ()
wire                                                    nds_unused_plmt_hreadyout; // dangler: () => ()
wire                                              [1:0] nds_unused_plmt_hresp; // dangler: () => ()
wire                                              [3:0] nds_unused_plmt_rid; // dangler: () => ()
wire                                                    plmt_arready;
wire                                                    plmt_awready;
wire                                              [1:0] plmt_bresp;
wire                                                    plmt_bvalid;
wire                                   [NCE_DATA_MSB:0] plmt_rdata;
wire                                                    plmt_rlast;
wire                                              [1:0] plmt_rresp;
wire                                                    plmt_rvalid;
wire                                                    plmt_wready;
wire                               [((ADDR_WIDTH)-1):0] axi_sys0_araddr;
wire                                              [1:0] axi_sys0_arburst;
wire                                              [3:0] axi_sys0_arcache;
wire                             [((BIU_ID_WIDTH)-1):0] axi_sys0_arid;
wire                                              [7:0] axi_sys0_arlen;
wire                                                    axi_sys0_arlock;
wire                                              [2:0] axi_sys0_arprot;
wire                                              [2:0] axi_sys0_arsize;
wire                                                    axi_sys0_arvalid;
wire                               [((ADDR_WIDTH)-1):0] axi_sys0_awaddr;
wire                                              [1:0] axi_sys0_awburst;
wire                                              [3:0] axi_sys0_awcache;
wire                             [((BIU_ID_WIDTH)-1):0] axi_sys0_awid;
wire                                              [7:0] axi_sys0_awlen;
wire                                                    axi_sys0_awlock;
wire                                              [2:0] axi_sys0_awprot;
wire                                              [2:0] axi_sys0_awsize;
wire                                                    axi_sys0_awvalid;
wire                                                    axi_sys0_bready;
wire                                                    axi_sys0_rready;
wire                           [((BIU_DATA_WIDTH)-1):0] axi_sys0_wdata;
wire                                                    axi_sys0_wlast;
wire                         [((BIU_DATA_WIDTH)/8)-1:0] axi_sys0_wstrb;
wire                                                    axi_sys0_wvalid;
wire                                                    cluster_sys0_arready;
wire                                                    cluster_sys0_awready;
wire                             [((BIU_ID_WIDTH)-1):0] cluster_sys0_bid;
wire                                              [1:0] cluster_sys0_bresp;
wire                                                    cluster_sys0_bvalid;
wire                           [((BIU_DATA_WIDTH)-1):0] cluster_sys0_rdata;
wire                             [((BIU_ID_WIDTH)-1):0] cluster_sys0_rid;
wire                                                    cluster_sys0_rlast;
wire                                              [1:0] cluster_sys0_rresp;
wire                                                    cluster_sys0_rvalid;
wire                                                    cluster_sys0_wready;

assign core0_clk         = core_clk[0];
assign core0_reset_n     = core_resetn[0];
assign core0_lm_clk      = lm_clk[0];
assign core0_slv_clk     = aclk;
assign core0_slv_clk_en  = axi_bus_clk_en;
assign core0_slv1_clk_en = axi_bus_clk_en;
assign core0_slvp_reset_n = slvp_resetn[0];
`ifdef NDS_IO_DCLS
always @(posedge core1_clk or negedge core0_reset_n) begin
	if (!core0_reset_n) begin
		core0_reset_n_delay <= 2'd0;
	end
	else begin
		core0_reset_n_delay <= {core0_reset_n_delay[0], 1'b1};
	end
end
always @(posedge core1_slv_clk or negedge core0_slvp_reset_n) begin
	if (!core0_slvp_reset_n) begin
		core0_slvp_reset_n_delay <= 2'd0;
	end
	else begin
		core0_slvp_reset_n_delay <= {core0_slvp_reset_n_delay[0], 1'b1};
	end
end
`ifdef NDS_IO_DCLS_SPLIT
assign core1_reset_n = dcls_p_enable_split ? core_resetn[1] : core0_reset_n_delay[1];
assign core1_slvp_reset_n = dcls_p_enable_split ? slvp_resetn[1] : core0_slvp_reset_n_delay[1];
`else // NDS_IO_DCLS_SPLIT
assign core1_reset_n = core0_reset_n_delay[1];
assign core1_slvp_reset_n = core0_slvp_reset_n_delay[1];
`endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
assign core1_clk = dcls_p_enable_split ? core_clk[1] : dcls_core1_clk;
`ifdef NDS_IO_LM
assign core1_lm_clk  = dcls_p_enable_split ? lm_clk[1] : dcls_core1_lm_clk;
`endif // NDS_IO_LM
assign core1_slv_clk     = aclk;
assign core1_slv1_clk    = aclk;
assign core1_slv_clk_en  = axi_bus_clk_en;
assign core1_slv1_clk_en = axi_bus_clk_en;

`else // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCLS
assign core1_clk = dcls_core1_clk;
`ifdef NDS_IO_LM
assign core1_lm_clk  = dcls_core1_lm_clk;
`endif // NDS_IO_LM
assign core1_slv_clk     = aclk;
assign core1_slv1_clk    = aclk;
`endif // NDS_IO_DCLS
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_LM
`else
wire	nds_unused_core0_lm_clk = core0_lm_clk;
`endif
`ifdef NDS_IO_DCLS
	`ifdef NDS_IO_SLAVEPORT_COMMON_X2
	`else
wire	nds_unused_core1_slvp_reset_n = core1_slvp_reset_n;
	`endif
`endif
`ifdef NDS_IO_SLAVEPORT_SYNC
`else
wire	nds_unused_no_core0_slv0_async = core0_slv_clk_en;
`endif
`ifdef NDS_IO_SLAVEPORT_SYNC_X2
`else
wire	nds_unused_no_core0_slv1_async = core0_slv1_clk_en;
`endif
`ifdef NDS_IO_DCLS_SPLIT
	`ifdef NDS_IO_SLAVEPORT_SYNC
	`else
wire	nds_unused_no_core1_slv0_async = core1_slv_clk_en;
	`endif
	`ifdef NDS_IO_SLAVEPORT_SYNC_X2
	`else
wire	nds_unused_no_core1_slv1_async = core1_slv1_clk_en;
	`endif
`endif
`ifdef NDS_IO_SLAVEPORT_ECC_X1
	`ifdef ATCBUSDEC302_SLV1_SUPPORT
	`else
wire	nds_unused_no_core0_slv_ecc = core0_slv_clk;
	`endif
`else
wire	nds_unused_no_core0_slv_ecc = core0_slv_clk;
`endif
   assign hart0_wakeup_event = {hart0_meip, hart0_seip, 1'b0, mtip[0], hart0_msip, dm_debugint[0]};

`ifdef NDS_IO_HART1
   assign hart1_wakeup_event = {hart1_meip, hart1_seip, 1'b0, mtip[1], hart1_msip, dm_debugint[1]};
`endif //NDS_IO_HART1

`ifdef NDS_IO_LM
assign lm_p_clk = lm_clk[0];
assign lm_r_clk = lm_clk[0];
`endif // NDS_IO_LM
`ifdef NDS_IO_BUS_PROTECTION
wire nds_unused_bus_prot_err;
assign nds_unused_bus_prot_err = (|core0_fs_bus_m_protection_error)
`ifdef NDS_IO_DCLS_SPLIT
                               | (|core1_fs_bus_m_protection_error)
`endif // NDS_IO_DCLS_SPLIT
                               ;
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_BUS_PROTECTION
assign core0_cfg_timeout_sys0 = 8'hff;
assign core0_cfg_timeout_flash0 = 8'hff;
assign core0_cfg_timeout_ppi = 8'hff;
assign core0_cfg_timeout_spp = 8'hff;
`endif // NDS_IO_BUS_PROTECTION

`ifdef NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS_SPLIT
assign core1_cfg_timeout_sys0 = 8'hff;
assign core1_cfg_timeout_flash0 = 8'hff;
assign core1_cfg_timeout_ppi = 8'hff;
assign core1_cfg_timeout_spp = 8'hff;
`endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_BUS_PROTECTION
assign hart0_core_wfi_mode = core0_wfi_mode;
`ifdef NDS_IO_HART1
assign hart1_core_wfi_mode = core1_wfi_mode;
`endif // NDS_IO_HART1
`ifdef NDS_IO_ILM_BOOT
`ifdef SET_ILM_BOOT
assign ilm_boot = 1'b1;
`else // SET_ILM_BOOT
assign ilm_boot = 1'b0;
`endif // SET_ILM_BOOT
`endif // NDS_IO_ILM_BOOT
assign core0_meip = hart0_meip;
assign core0_meiid = hart0_meiid;
assign hart0_meiack = core0_meiack;
`ifdef NDS_IO_DCLS_SPLIT
assign core1_meip   = hart1_meip;
assign core1_meiid  = hart1_meiid;
assign hart1_meiack = core1_meiack;
`else // NDS_IO_DCLS_SPLIT
assign hart1_meiack = 1'b0;
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_SEIP
assign core0_seip = hart0_seip;
assign core0_seiid = hart0_seiid;
assign hart0_seiack = core0_seiack;
`ifdef NDS_IO_DCLS_SPLIT
assign core1_seip   = hart1_seip;
assign core1_seiid  = hart1_seiid;
assign hart1_seiack = core1_seiack;
`else // NDS_IO_DCLS_SPLIT
assign hart1_seiack = 1'b0;
`endif // NDS_IO_DCLS_SPLIT
`else // NDS_IO_SEIP
assign hart0_seiack = 1'b0;
assign hart1_seiack = 1'b0;
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
assign core0_ueip = 1'b0;
`ifdef NDS_IO_DCLS_SPLIT
assign core1_ueip = 1'b0;
`endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_UEIP
assign hart0_mtip = mtip[0];
`ifdef NDS_IO_DCLS_SPLIT
assign hart1_mtip = mtip[1];
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DEBUG
	`ifdef NDS_IO_DCLS_SPLIT
		assign stoptime = core0_stoptime | core1_stoptime;
	`else // NDS_IO_DCLS_SPLIT
		assign stoptime = core0_stoptime;
	`endif // NDS_IO_DCLS_SPLIT
`else // NDS_IO_DEBUG
	assign stoptime = 1'b0;
`endif // NDS_IO_DEBUG


`ifdef NDS_IO_DEBUG
assign core0_debugint = dm_debugint[0];
assign core0_resethaltreq = dm_resethaltreq[0];
`ifdef NDS_IO_DCLS_SPLIT
assign core1_debugint = dm_debugint[1];
assign core1_resethaltreq = dm_resethaltreq[1];
`endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DEBUG
assign core0_reset_vector = hart0_reset_vector;
`ifdef NDS_IO_DCLS_SPLIT
assign core1_reset_vector = hart1_reset_vector;
`endif // NDS_IO_DCLS_SPLIT
assign core0_nmi = hart0_nmi;
`ifdef NDS_IO_DCLS_SPLIT
assign core1_nmi = hart1_nmi;
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ICACHE0
assign core0_icache_disable_init = hart0_icache_disable_init;
`ifdef NDS_IO_DCLS_SPLIT
assign core1_icache_disable_init = hart1_icache_disable_init;
`endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCACHE0
assign core0_dcache_disable_init = hart0_dcache_disable_init;
`ifdef NDS_IO_DCLS_SPLIT
assign core1_dcache_disable_init = hart1_dcache_disable_init;
`endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_SLAVEPORT_COMMON_X2
`endif // NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_BUS_PROTECTION
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_EDC_AFTER_ECC
`endif // NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_LM
`endif // NDS_IO_LM
`ifdef NDS_IO_ILM_BOOT
`endif // NDS_IO_ILM_BOOT
`ifdef NDS_IO_DLM_BOOT
`endif // NDS_IO_DLM_BOOT
`ifdef NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_SLAVEPORT_SYNC
`endif // NDS_IO_SLAVEPORT_SYNC
`ifdef NDS_IO_SLAVEPORT_SYNC_X2
`endif // NDS_IO_SLAVEPORT_SYNC_X2
`ifdef NDS_IO_PPI_SYNC
`endif // NDS_IO_PPI_SYNC
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X2
`endif // NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_TRACE_TILELINK
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_LM_RESET
`endif // NDS_IO_LM_RESET
`ifdef NDS_IO_ILM_TL_UL
`endif // NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DLM_TL_UL
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_ICACHE0
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCACHE0
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_PROBING
`endif // NDS_IO_PROBING
`ifdef NDS_IO_SEIP
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
`endif // NDS_IO_UEIP
`ifdef NDS_IO_DEBUG
`endif // NDS_IO_DEBUG
`ifdef NDS_IO_TRACE_INSTR_GEN1
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_TRAP_STATUS
`endif // NDS_IO_TRAP_STATUS
`ifdef NDS_IO_PPI
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
`endif // NDS_IO_PPI_PROT
`ifdef NDS_IO_LM_QOS
`endif // NDS_IO_LM_QOS
`ifdef NDS_IO_SLAVEPORT_QOS_X1
`endif // NDS_IO_SLAVEPORT_QOS_X1
`ifdef NDS_IO_SLAVEPORT_QOS_X2
`endif // NDS_IO_SLAVEPORT_QOS_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`ifdef NDS_IO_ICACHE0_CTRL_IN
`endif // NDS_IO_ICACHE0_CTRL_IN
`ifdef NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0_CTRL_OUT
`ifdef NDS_IO_ICACHE1_CTRL_IN
`endif // NDS_IO_ICACHE1_CTRL_IN
`ifdef NDS_IO_ICACHE1_CTRL_OUT
`endif // NDS_IO_ICACHE1_CTRL_OUT
`ifdef NDS_IO_ICACHE2_CTRL_IN
`endif // NDS_IO_ICACHE2_CTRL_IN
`ifdef NDS_IO_ICACHE2_CTRL_OUT
`endif // NDS_IO_ICACHE2_CTRL_OUT
`ifdef NDS_IO_BTB_RAM_CTRL_IN
`endif // NDS_IO_BTB_RAM_CTRL_IN
`ifdef NDS_IO_BTB_RAM_CTRL_OUT
`endif // NDS_IO_BTB_RAM_CTRL_OUT
`ifdef NDS_IO_BTB2_RAM_CTRL_IN
`endif // NDS_IO_BTB2_RAM_CTRL_IN
`ifdef NDS_IO_BTB2_RAM_CTRL_OUT
`endif // NDS_IO_BTB2_RAM_CTRL_OUT
`ifdef NDS_IO_BTB3_RAM_CTRL_IN
`endif // NDS_IO_BTB3_RAM_CTRL_IN
`ifdef NDS_IO_BTB3_RAM_CTRL_OUT
`endif // NDS_IO_BTB3_RAM_CTRL_OUT
`ifdef NDS_IO_FLASHIF0
`endif // NDS_IO_FLASHIF0
`ifdef NDS_IO_SPP
`endif // NDS_IO_SPP
`ifdef NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`ifdef NDS_IO_FLASHIF0
`endif // NDS_IO_FLASHIF0
`ifdef NDS_IO_SPP
`endif // NDS_IO_SPP
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ICACHE0
`endif // NDS_IO_ICACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ICACHE0
`ifdef NDS_IO_ICACHE0_CTRL_IN
`endif // NDS_IO_ICACHE0_CTRL_IN
`ifdef NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCACHE0
`endif // NDS_IO_DCACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCACHE0
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE0_CTRL_IN
`endif // NDS_IO_DCACHE0_CTRL_IN
`ifdef NDS_IO_DCACHE0_CTRL_OUT
`endif // NDS_IO_DCACHE0_CTRL_OUT
`ifdef NDS_IO_DCACHE_CTRL_IN
`endif // NDS_IO_DCACHE_CTRL_IN
`ifdef NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_LM
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_TRACE_TILELINK
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_LM_RESET
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM_RESET
`ifdef NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DLM_TL_UL
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_ICACHE0
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_PROBING
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PROBING
`ifdef NDS_IO_SEIP
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_UEIP
`ifdef NDS_IO_DEBUG
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DEBUG
`ifdef NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_TRAP_STATUS
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRAP_STATUS
`ifdef NDS_IO_PPI
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PPI_PROT
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_ILM_RAM0
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_ICACHE1
`endif // NDS_IO_ICACHE1
`ifdef NDS_IO_ICACHE2
`endif // NDS_IO_ICACHE2
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_BTB_RAM_CTRL_IN
`endif // NDS_IO_BTB_RAM_CTRL_IN
`ifdef NDS_IO_BTB_RAM_CTRL_OUT
`endif // NDS_IO_BTB_RAM_CTRL_OUT
`ifdef NDS_IO_BTB2_RAM_CTRL_IN
`endif // NDS_IO_BTB2_RAM_CTRL_IN
`ifdef NDS_IO_BTB2_RAM_CTRL_OUT
`endif // NDS_IO_BTB2_RAM_CTRL_OUT
`ifdef NDS_IO_BTB3_RAM_CTRL_IN
`endif // NDS_IO_BTB3_RAM_CTRL_IN
`ifdef NDS_IO_BTB3_RAM_CTRL_OUT
`endif // NDS_IO_BTB3_RAM_CTRL_OUT
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM0_CTRL_IN
`endif // NDS_IO_ILM_RAM0_CTRL_IN
`ifdef NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
`ifdef NDS_IO_ILM_RAM1_CTRL_IN
`endif // NDS_IO_ILM_RAM1_CTRL_IN
`ifdef NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM0_CTRL_IN
`endif // NDS_IO_DLM_RAM0_CTRL_IN
`ifdef NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM1_CTRL_IN
`endif // NDS_IO_DLM_RAM1_CTRL_IN
`ifdef NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM2_CTRL_IN
`endif // NDS_IO_DLM_RAM2_CTRL_IN
`ifdef NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
`ifdef NDS_IO_DLM_RAM3_CTRL_IN
`endif // NDS_IO_DLM_RAM3_CTRL_IN
`ifdef NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_BTB_RAM
`endif // NDS_IO_BTB_RAM
`ifdef NDS_IO_BTB2_RAM
`endif // NDS_IO_BTB2_RAM
`ifdef NDS_IO_BTB3_RAM
`endif // NDS_IO_BTB3_RAM
`ifdef NDS_IO_DCACHE1
`endif // NDS_IO_DCACHE1
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE1
`ifdef NDS_IO_DCACHE1_CTRL_IN
`endif // NDS_IO_DCACHE1_CTRL_IN
`ifdef NDS_IO_DCACHE1_CTRL_OUT
`endif // NDS_IO_DCACHE1_CTRL_OUT
`endif // NDS_IO_DCACHE1
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_DCACHE2
`endif // NDS_IO_DCACHE2
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE2
`ifdef NDS_IO_DCACHE2_CTRL_IN
`endif // NDS_IO_DCACHE2_CTRL_IN
`ifdef NDS_IO_DCACHE2_CTRL_OUT
`endif // NDS_IO_DCACHE2_CTRL_OUT
`endif // NDS_IO_DCACHE2
`ifdef NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ICACHE0
`ifdef NDS_IO_ICACHE0_CTRL_IN
`endif // NDS_IO_ICACHE0_CTRL_IN
`ifdef NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM0_CTRL_IN
`endif // NDS_IO_ILM_RAM0_CTRL_IN
`ifdef NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
`ifdef NDS_IO_ILM_RAM1_CTRL_IN
`endif // NDS_IO_ILM_RAM1_CTRL_IN
`ifdef NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM0_CTRL_IN
`endif // NDS_IO_DLM_RAM0_CTRL_IN
`ifdef NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM1_CTRL_IN
`endif // NDS_IO_DLM_RAM1_CTRL_IN
`ifdef NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM2_CTRL_IN
`endif // NDS_IO_DLM_RAM2_CTRL_IN
`ifdef NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
`ifdef NDS_IO_DLM_RAM3_CTRL_IN
`endif // NDS_IO_DLM_RAM3_CTRL_IN
`ifdef NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_DCACHE0
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE_CTRL_IN
`endif // NDS_IO_DCACHE_CTRL_IN
`ifdef NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_LM
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM
`ifdef NDS_IO_ILM_BOOT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_ILM_BOOT
`ifdef NDS_IO_DLM_BOOT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DLM_BOOT
`ifdef NDS_IO_SLAVEPORT_SYNC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_SYNC
`ifdef NDS_IO_SLAVEPORT_SYNC_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_SYNC_X2
`ifdef NDS_IO_PPI_SYNC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PPI_SYNC
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_TRACE_TILELINK
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_LM_RESET
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM_RESET
`ifdef NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DLM_TL_UL
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_ICACHE0
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_PROBING
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PROBING
`ifdef NDS_IO_SEIP
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_UEIP
`ifdef NDS_IO_DEBUG
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DEBUG
`ifdef NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_TRAP_STATUS
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRAP_STATUS
`ifdef NDS_IO_PPI
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PPI_PROT
`ifdef NDS_IO_LM_QOS
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM_QOS
`ifdef NDS_IO_SLAVEPORT_QOS_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_QOS_X1
`ifdef NDS_IO_SLAVEPORT_QOS_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_QOS_X2
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_ILM_RAM0
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
`endif // NDS_IO_DLM_RAM3
`endif // NDS_IO_DCLS
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_SLAVEPORT_COMMON_X2
`endif // NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_BUS_PROTECTION
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_EDC_AFTER_ECC
`endif // NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_LM
`endif // NDS_IO_LM
`ifdef NDS_IO_ILM_BOOT
`endif // NDS_IO_ILM_BOOT
`ifdef NDS_IO_DLM_BOOT
`endif // NDS_IO_DLM_BOOT
`ifdef NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_SLAVEPORT_SYNC
`endif // NDS_IO_SLAVEPORT_SYNC
`ifdef NDS_IO_SLAVEPORT_SYNC_X2
`endif // NDS_IO_SLAVEPORT_SYNC_X2
`ifdef NDS_IO_PPI_SYNC
`endif // NDS_IO_PPI_SYNC
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X2
`endif // NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_TRACE_TILELINK
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_LM_RESET
`endif // NDS_IO_LM_RESET
`ifdef NDS_IO_ILM_TL_UL
`endif // NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DLM_TL_UL
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_ICACHE0
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCACHE0
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_PROBING
`endif // NDS_IO_PROBING
`ifdef NDS_IO_SEIP
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
`endif // NDS_IO_UEIP
`ifdef NDS_IO_DEBUG
`endif // NDS_IO_DEBUG
`ifdef NDS_IO_TRACE_INSTR_GEN1
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_TRAP_STATUS
`endif // NDS_IO_TRAP_STATUS
`ifdef NDS_IO_PPI
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
`endif // NDS_IO_PPI_PROT
`ifdef NDS_IO_LM_QOS
`endif // NDS_IO_LM_QOS
`ifdef NDS_IO_SLAVEPORT_QOS_X1
`endif // NDS_IO_SLAVEPORT_QOS_X1
`ifdef NDS_IO_SLAVEPORT_QOS_X2
`endif // NDS_IO_SLAVEPORT_QOS_X2
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_m0_a_address = ~{(`NDS_BIU_ADDR_WIDTH){1'b0}};
assign dcls_inject_fault_m0_a_corrupt = ~1'd0;
assign dcls_inject_fault_m0_a_data = ~{(`NDS_L2_DATA_WIDTH){1'b0}};
assign dcls_inject_fault_m0_a_mask = ~{((`NDS_L2_DATA_WIDTH)/8){1'b0}};
assign dcls_inject_fault_m0_a_opcode = ~3'd0;
assign dcls_inject_fault_m0_a_param = ~3'd0;
assign dcls_inject_fault_m0_a_size = ~3'd0;
assign dcls_inject_fault_m0_a_source = ~{(`NDS_L2_SOURCE_WIDTH){1'b0}};
assign dcls_inject_fault_m0_a_user = ~{(`NDS_SCPU_A_UW){1'b0}};
assign dcls_inject_fault_m0_a_valid = ~1'd0;
assign dcls_inject_fault_m0_b_ready = ~1'd0;
assign dcls_inject_fault_m0_c_address = ~{(`NDS_BIU_ADDR_WIDTH){1'b0}};
assign dcls_inject_fault_m0_c_corrupt = ~1'd0;
assign dcls_inject_fault_m0_c_data = ~{(`NDS_L2_DATA_WIDTH){1'b0}};
assign dcls_inject_fault_m0_c_opcode = ~3'd0;
assign dcls_inject_fault_m0_c_param = ~3'd0;
assign dcls_inject_fault_m0_c_size = ~3'd0;
assign dcls_inject_fault_m0_c_source = ~{(`NDS_L2_SOURCE_WIDTH){1'b0}};
assign dcls_inject_fault_m0_c_user = ~{(`NDS_SCPU_C_UW){1'b0}};
assign dcls_inject_fault_m0_c_valid = ~1'd0;
assign dcls_inject_fault_m0_d_ready = ~1'd0;
assign dcls_inject_fault_m0_e_sink = ~{(`NDS_TL_SINK_WIDTH){1'b0}};
assign dcls_inject_fault_m0_e_valid = ~1'd0;
assign dcls_inject_fault_m1_a_address = ~{(`NDS_BIU_ADDR_WIDTH){1'b0}};
assign dcls_inject_fault_m1_a_corrupt = ~1'd0;
assign dcls_inject_fault_m1_a_data = ~{(`NDS_L2_DATA_WIDTH){1'b0}};
assign dcls_inject_fault_m1_a_mask = ~{((`NDS_L2_DATA_WIDTH)/8){1'b0}};
assign dcls_inject_fault_m1_a_opcode = ~3'd0;
assign dcls_inject_fault_m1_a_param = ~3'd0;
assign dcls_inject_fault_m1_a_size = ~3'd0;
assign dcls_inject_fault_m1_a_source = ~{(`NDS_L2_SOURCE_WIDTH){1'b0}};
assign dcls_inject_fault_m1_a_user = ~{(`NDS_SCPU_A_UW){1'b0}};
assign dcls_inject_fault_m1_a_valid = ~1'd0;
assign dcls_inject_fault_m1_d_ready = ~1'd0;
assign dcls_inject_fault_m2_a_address = ~{(`NDS_BIU_ADDR_WIDTH){1'b0}};
assign dcls_inject_fault_m2_a_corrupt = ~1'd0;
assign dcls_inject_fault_m2_a_data = ~{(`NDS_L2_DATA_WIDTH){1'b0}};
assign dcls_inject_fault_m2_a_mask = ~{((`NDS_L2_DATA_WIDTH)/8){1'b0}};
assign dcls_inject_fault_m2_a_opcode = ~3'd0;
assign dcls_inject_fault_m2_a_param = ~3'd0;
assign dcls_inject_fault_m2_a_size = ~3'd0;
assign dcls_inject_fault_m2_a_source = ~{(`NDS_L2_SOURCE_WIDTH){1'b0}};
assign dcls_inject_fault_m2_a_user = ~{(`NDS_SCPU_A_UW){1'b0}};
assign dcls_inject_fault_m2_a_valid = ~1'd0;
assign dcls_inject_fault_m2_d_ready = ~1'd0;
assign dcls_inject_fault_meiack = ~1'd0;
assign dcls_inject_fault_wfi_mode = ~1'd0;
`endif // NDS_IO_DCLS
`ifdef NDS_IO_ICACHE0_CTRL_IN
`endif // NDS_IO_ICACHE0_CTRL_IN
`ifdef NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0_CTRL_OUT
`ifdef NDS_IO_ICACHE1_CTRL_IN
`endif // NDS_IO_ICACHE1_CTRL_IN
`ifdef NDS_IO_ICACHE1_CTRL_OUT
`endif // NDS_IO_ICACHE1_CTRL_OUT
`ifdef NDS_IO_ICACHE2_CTRL_IN
`endif // NDS_IO_ICACHE2_CTRL_IN
`ifdef NDS_IO_ICACHE2_CTRL_OUT
`endif // NDS_IO_ICACHE2_CTRL_OUT
`ifdef NDS_IO_BTB_RAM_CTRL_IN
`endif // NDS_IO_BTB_RAM_CTRL_IN
`ifdef NDS_IO_BTB_RAM_CTRL_OUT
`endif // NDS_IO_BTB_RAM_CTRL_OUT
`ifdef NDS_IO_BTB2_RAM_CTRL_IN
`endif // NDS_IO_BTB2_RAM_CTRL_IN
`ifdef NDS_IO_BTB2_RAM_CTRL_OUT
`endif // NDS_IO_BTB2_RAM_CTRL_OUT
`ifdef NDS_IO_BTB3_RAM_CTRL_IN
`endif // NDS_IO_BTB3_RAM_CTRL_IN
`ifdef NDS_IO_BTB3_RAM_CTRL_OUT
`endif // NDS_IO_BTB3_RAM_CTRL_OUT
`ifdef NDS_IO_FLASHIF0
`endif // NDS_IO_FLASHIF0
`ifdef NDS_IO_SPP
`endif // NDS_IO_SPP
`ifdef NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_fs_bus_m_protection_error = ~8'd0;
`endif // NDS_IO_DCLS
`ifdef NDS_IO_FLASHIF0
`endif // NDS_IO_FLASHIF0
`ifdef NDS_IO_SPP
`endif // NDS_IO_SPP
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ICACHE0
`endif // NDS_IO_ICACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ICACHE0
`ifdef NDS_IO_ICACHE0_CTRL_IN
`endif // NDS_IO_ICACHE0_CTRL_IN
`ifdef NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCACHE0
`endif // NDS_IO_DCACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCACHE0
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_dcache_data0_addr = ~{(`NDS_DCACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_data0_byte_we = ~{(`NDS_DCACHE_DATA_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dcache_data0_cs = ~1'd0;
assign dcls_inject_fault_dcache_data0_wdata = ~{(`NDS_DCACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_data0_we = ~1'd0;
assign dcls_inject_fault_dcache_data1_addr = ~{(`NDS_DCACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_data1_byte_we = ~{(`NDS_DCACHE_DATA_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dcache_data1_cs = ~1'd0;
assign dcls_inject_fault_dcache_data1_wdata = ~{(`NDS_DCACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_data1_we = ~1'd0;
assign dcls_inject_fault_dcache_data2_addr = ~{(`NDS_DCACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_data2_byte_we = ~{(`NDS_DCACHE_DATA_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dcache_data2_cs = ~1'd0;
assign dcls_inject_fault_dcache_data2_wdata = ~{(`NDS_DCACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_data2_we = ~1'd0;
assign dcls_inject_fault_dcache_data3_addr = ~{(`NDS_DCACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_data3_byte_we = ~{(`NDS_DCACHE_DATA_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dcache_data3_cs = ~1'd0;
assign dcls_inject_fault_dcache_data3_wdata = ~{(`NDS_DCACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_data3_we = ~1'd0;
assign dcls_inject_fault_dcache_tag0_addr = ~{(`NDS_DCACHE_TAG_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_tag0_cs = ~1'd0;
assign dcls_inject_fault_dcache_tag0_wdata = ~{(`NDS_DCACHE_TAG_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_tag0_we = ~1'd0;
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE0_CTRL_IN
`endif // NDS_IO_DCACHE0_CTRL_IN
`ifdef NDS_IO_DCACHE0_CTRL_OUT
`endif // NDS_IO_DCACHE0_CTRL_OUT
`ifdef NDS_IO_DCACHE_CTRL_IN
`endif // NDS_IO_DCACHE_CTRL_IN
`ifdef NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_slv1_arready = ~1'd0;
assign dcls_inject_fault_slv1_awready = ~1'd0;
assign dcls_inject_fault_slv1_bid = ~{(`NDS_SLAVE_PORT_ID_WIDTH){1'b0}};
assign dcls_inject_fault_slv1_bresp = ~2'd0;
assign dcls_inject_fault_slv1_bvalid = ~1'd0;
assign dcls_inject_fault_slv1_rdata = ~{(`NDS_SLAVE_PORT_DATA_WIDTH){1'b0}};
assign dcls_inject_fault_slv1_rid = ~{(`NDS_SLAVE_PORT_ID_WIDTH){1'b0}};
assign dcls_inject_fault_slv1_rlast = ~1'd0;
assign dcls_inject_fault_slv1_rresp = ~2'd0;
assign dcls_inject_fault_slv1_rvalid = ~1'd0;
assign dcls_inject_fault_slv1_wready = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_fs_edc_error = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_LM
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_lm_local_int = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_slv_arready = ~1'd0;
assign dcls_inject_fault_slv_awready = ~1'd0;
assign dcls_inject_fault_slv_bid = ~{(`NDS_SLAVE_PORT_ID_WIDTH){1'b0}};
assign dcls_inject_fault_slv_bresp = ~2'd0;
assign dcls_inject_fault_slv_bvalid = ~1'd0;
assign dcls_inject_fault_slv_rdata = ~{(`NDS_SLAVE_PORT_DATA_WIDTH){1'b0}};
assign dcls_inject_fault_slv_rid = ~{(`NDS_SLAVE_PORT_ID_WIDTH){1'b0}};
assign dcls_inject_fault_slv_rlast = ~1'd0;
assign dcls_inject_fault_slv_rresp = ~2'd0;
assign dcls_inject_fault_slv_rvalid = ~1'd0;
assign dcls_inject_fault_slv_wready = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_fs_bus_s_protection_error = ~8'd0;
assign dcls_inject_fault_slv_arreadycode = ~1'd0;
assign dcls_inject_fault_slv_awreadycode = ~1'd0;
assign dcls_inject_fault_slv_bctlcode = ~{((`NDS_SLV_CTRL_CODE_WIDTH)){1'b0}};
assign dcls_inject_fault_slv_bidcode = ~{((`NDS_SLV_CTRL_CODE_WIDTH)){1'b0}};
assign dcls_inject_fault_slv_butid = ~{((`NDS_SLV_UTID_WIDTH)){1'b0}};
assign dcls_inject_fault_slv_bvalidcode = ~1'd0;
assign dcls_inject_fault_slv_rctlcode = ~{((`NDS_SLV_CTRL_CODE_WIDTH)){1'b0}};
assign dcls_inject_fault_slv_rdatacode = ~{((`NDS_SLV_DATA_CODE_WIDTH)){1'b0}};
assign dcls_inject_fault_slv_reobi = ~1'd0;
assign dcls_inject_fault_slv_ridcode = ~{((`NDS_SLV_CTRL_CODE_WIDTH)){1'b0}};
assign dcls_inject_fault_slv_rutid = ~{((`NDS_SLV_UTID_WIDTH)){1'b0}};
assign dcls_inject_fault_slv_rvalidcode = ~1'd0;
assign dcls_inject_fault_slv_wreadycode = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_fs_bus_s1_protection_error = ~8'd0;
assign dcls_inject_fault_slv1_arreadycode = ~1'd0;
assign dcls_inject_fault_slv1_awreadycode = ~1'd0;
assign dcls_inject_fault_slv1_bctlcode = ~{((`NDS_SLV_CTRL_CODE_WIDTH)){1'b0}};
assign dcls_inject_fault_slv1_bidcode = ~{((`NDS_SLV_CTRL_CODE_WIDTH)){1'b0}};
assign dcls_inject_fault_slv1_butid = ~{((`NDS_SLV_UTID_WIDTH)){1'b0}};
assign dcls_inject_fault_slv1_bvalidcode = ~1'd0;
assign dcls_inject_fault_slv1_rctlcode = ~{((`NDS_SLV_CTRL_CODE_WIDTH)){1'b0}};
assign dcls_inject_fault_slv1_rdatacode = ~{((`NDS_SLV_DATA_CODE_WIDTH)){1'b0}};
assign dcls_inject_fault_slv1_reobi = ~1'd0;
assign dcls_inject_fault_slv1_ridcode = ~{((`NDS_SLV_CTRL_CODE_WIDTH)){1'b0}};
assign dcls_inject_fault_slv1_rutid = ~{((`NDS_SLV_UTID_WIDTH)){1'b0}};
assign dcls_inject_fault_slv1_rvalidcode = ~1'd0;
assign dcls_inject_fault_slv1_wreadycode = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_TRACE_TILELINK
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_trace_dcu_cmt_addr = ~32'd0;
assign dcls_inject_fault_trace_dcu_cmt_func = ~12'd0;
assign dcls_inject_fault_trace_dcu_cmt_valid = ~1'd0;
assign dcls_inject_fault_trace_dcu_cmt_wdata = ~32'd0;
assign dcls_inject_fault_trace_i0_wb_alive = ~1'd0;
assign dcls_inject_fault_trace_i0_wb_pc = ~32'd0;
assign dcls_inject_fault_trace_i1_wb_alive = ~1'd0;
assign dcls_inject_fault_trace_i1_wb_pc = ~32'd0;
assign dcls_inject_fault_trace_ls_i0_instr = ~32'd0;
assign dcls_inject_fault_trace_ls_i0_pc = ~32'd0;
assign dcls_inject_fault_trace_sb_va = ~32'd0;
assign dcls_inject_fault_trace_wb_cause = ~6'd0;
assign dcls_inject_fault_trace_wb_xcpt = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_LM_RESET
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_lm_reset_n = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM_RESET
`ifdef NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_ilm_a_addr = ~{((`NDS_ILM_AW)+2-3+1){1'b0}};
assign dcls_inject_fault_ilm_a_data = ~64'd0;
assign dcls_inject_fault_ilm_a_mask = ~8'd0;
assign dcls_inject_fault_ilm_a_opcode = ~3'd0;
assign dcls_inject_fault_ilm_a_parity0 = ~8'd0;
assign dcls_inject_fault_ilm_a_parity1 = ~8'd0;
assign dcls_inject_fault_ilm_a_size = ~3'd0;
assign dcls_inject_fault_ilm_a_user = ~2'd0;
assign dcls_inject_fault_ilm_a_valid = ~1'd0;
assign dcls_inject_fault_ilm_d_ready = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DLM_TL_UL
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_dlm_a_addr = ~{(`NDS_DLM_AMSB-`NDS_DLM_ALSB+1){1'b0}};
assign dcls_inject_fault_dlm_a_data = ~{(`NDS_XLEN){1'b0}};
assign dcls_inject_fault_dlm_a_mask = ~{(`NDS_XLEN/8){1'b0}};
assign dcls_inject_fault_dlm_a_opcode = ~3'd0;
assign dcls_inject_fault_dlm_a_parity = ~8'd0;
assign dcls_inject_fault_dlm_a_size = ~3'd0;
assign dcls_inject_fault_dlm_a_user = ~2'd0;
assign dcls_inject_fault_dlm_a_valid = ~1'd0;
assign dcls_inject_fault_dlm_d_ready = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_ICACHE0
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_icache_data0_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data0_cs = ~1'd0;
assign dcls_inject_fault_icache_data0_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data0_we = ~1'd0;
assign dcls_inject_fault_icache_data1_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data1_cs = ~1'd0;
assign dcls_inject_fault_icache_data1_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data1_we = ~1'd0;
assign dcls_inject_fault_icache_data2_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data2_cs = ~1'd0;
assign dcls_inject_fault_icache_data2_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data2_we = ~1'd0;
assign dcls_inject_fault_icache_data3_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data3_cs = ~1'd0;
assign dcls_inject_fault_icache_data3_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data3_we = ~1'd0;
assign dcls_inject_fault_icache_data4_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data4_cs = ~1'd0;
assign dcls_inject_fault_icache_data4_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data4_we = ~1'd0;
assign dcls_inject_fault_icache_data5_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data5_cs = ~1'd0;
assign dcls_inject_fault_icache_data5_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data5_we = ~1'd0;
assign dcls_inject_fault_icache_data6_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data6_cs = ~1'd0;
assign dcls_inject_fault_icache_data6_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data6_we = ~1'd0;
assign dcls_inject_fault_icache_data7_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data7_cs = ~1'd0;
assign dcls_inject_fault_icache_data7_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data7_we = ~1'd0;
assign dcls_inject_fault_icache_tag0_addr = ~{(`NDS_ICACHE_TAG_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_tag0_cs = ~1'd0;
assign dcls_inject_fault_icache_tag0_wdata = ~{(`NDS_ICACHE_TAG_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_tag0_we = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_PROBING
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_current_pc = ~{(`NDS_VALEN){1'b0}};
assign dcls_inject_fault_selected_gpr_value = ~{(`NDS_XLEN){1'b0}};
`endif // NDS_IO_DCLS
`endif // NDS_IO_PROBING
`ifdef NDS_IO_SEIP
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_seiack = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_ueiack = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_UEIP
`ifdef NDS_IO_DEBUG
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_hart_halted = ~1'd0;
assign dcls_inject_fault_hart_unavail = ~1'd0;
assign dcls_inject_fault_hart_under_reset = ~1'd0;
assign dcls_inject_fault_stoptime = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_DEBUG
`ifdef NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_gen1_trace_cause = ~20'd0;
assign dcls_inject_fault_gen1_trace_iaddr = ~{((`NDS_VALEN)*2){1'b0}};
assign dcls_inject_fault_gen1_trace_iexception = ~2'd0;
assign dcls_inject_fault_gen1_trace_instr = ~64'd0;
assign dcls_inject_fault_gen1_trace_interrupt = ~2'd0;
assign dcls_inject_fault_gen1_trace_ivalid = ~2'd0;
assign dcls_inject_fault_gen1_trace_priv = ~4'd0;
assign dcls_inject_fault_gen1_trace_tval = ~{((`NDS_XLEN)*2){1'b0}};
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_trace_cause = ~10'd0;
assign dcls_inject_fault_trace_context = ~32'd0;
assign dcls_inject_fault_trace_ctype = ~2'd0;
assign dcls_inject_fault_trace_halted = ~1'd0;
assign dcls_inject_fault_trace_iaddr = ~{(2*(`NDS_VALEN)){1'b0}};
assign dcls_inject_fault_trace_ilastsize = ~2'd0;
assign dcls_inject_fault_trace_iretire = ~4'd0;
assign dcls_inject_fault_trace_itype = ~8'd0;
assign dcls_inject_fault_trace_priv = ~2'd0;
assign dcls_inject_fault_trace_reset = ~1'd0;
assign dcls_inject_fault_trace_trigger = ~6'd0;
assign dcls_inject_fault_trace_tval = ~{(`NDS_XLEN){1'b0}};
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_TRAP_STATUS
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_fs_halt_mode = ~1'd0;
assign dcls_inject_fault_fs_trap_status_cause = ~10'd0;
assign dcls_inject_fault_fs_trap_status_dcause = ~3'd0;
assign dcls_inject_fault_fs_trap_status_interrupt = ~1'd0;
assign dcls_inject_fault_fs_trap_status_nmi = ~1'd0;
assign dcls_inject_fault_fs_trap_status_taken = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRAP_STATUS
`ifdef NDS_IO_PPI
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_ppi_araddr = ~{(`NDS_BIU_ADDR_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_arburst = ~2'd0;
assign dcls_inject_fault_ppi_arcache = ~4'd0;
assign dcls_inject_fault_ppi_arid = ~{(`NDS_PPI_ID_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_arlen = ~8'd0;
assign dcls_inject_fault_ppi_arlock = ~1'd0;
assign dcls_inject_fault_ppi_arprot = ~3'd0;
assign dcls_inject_fault_ppi_arsize = ~3'd0;
assign dcls_inject_fault_ppi_arvalid = ~1'd0;
assign dcls_inject_fault_ppi_awaddr = ~{(`NDS_BIU_ADDR_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_awburst = ~2'd0;
assign dcls_inject_fault_ppi_awcache = ~4'd0;
assign dcls_inject_fault_ppi_awid = ~{(`NDS_PPI_ID_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_awlen = ~8'd0;
assign dcls_inject_fault_ppi_awlock = ~1'd0;
assign dcls_inject_fault_ppi_awprot = ~3'd0;
assign dcls_inject_fault_ppi_awsize = ~3'd0;
assign dcls_inject_fault_ppi_awvalid = ~1'd0;
assign dcls_inject_fault_ppi_bready = ~1'd0;
assign dcls_inject_fault_ppi_rready = ~1'd0;
assign dcls_inject_fault_ppi_wdata = ~{(`NDS_PPI_DATA_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_wlast = ~1'd0;
assign dcls_inject_fault_ppi_wstrb = ~{(`NDS_PPI_DATA_WIDTH/8){1'b0}};
assign dcls_inject_fault_ppi_wvalid = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_ppi_araddrcode = ~{(`NDS_BIU_ADDR_CODE_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_arctl0code = ~{(`NDS_BIU_CTRL_CODE_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_arctl1code = ~{(`NDS_BIU_CTRL_CODE_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_aridcode = ~5'd0;
assign dcls_inject_fault_ppi_arutid = ~{(`NDS_BIU_UTID_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_arvalidcode = ~1'd0;
assign dcls_inject_fault_ppi_awaddrcode = ~{(`NDS_BIU_ADDR_CODE_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_awctl0code = ~{(`NDS_BIU_CTRL_CODE_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_awctl1code = ~{(`NDS_BIU_CTRL_CODE_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_awidcode = ~5'd0;
assign dcls_inject_fault_ppi_awutid = ~{(`NDS_BIU_UTID_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_awvalidcode = ~1'd0;
assign dcls_inject_fault_ppi_breadycode = ~1'd0;
assign dcls_inject_fault_ppi_rreadycode = ~1'd0;
assign dcls_inject_fault_ppi_wctlcode = ~5'd0;
assign dcls_inject_fault_ppi_wdatacode = ~{(`NDS_PPI_DATA_CODE_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_weobi = ~1'd0;
assign dcls_inject_fault_ppi_wutid = ~{(`NDS_BIU_UTID_WIDTH){1'b0}};
assign dcls_inject_fault_ppi_wvalidcode = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_PPI_PROT
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_ILM_RAM0
assign dcls_inject_fault_ilm0_addr = ~{(`NDS_ILM_RAM_AW){1'b0}};
assign dcls_inject_fault_ilm0_byte_we = ~{(`NDS_ILM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_ilm0_cs = ~1'd0;
assign dcls_inject_fault_ilm0_wdata = ~{(`NDS_ILM_RAM_DW){1'b0}};
assign dcls_inject_fault_ilm0_we = ~1'd0;
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
assign dcls_inject_fault_ilm1_addr = ~{(`NDS_ILM_RAM_AW){1'b0}};
assign dcls_inject_fault_ilm1_byte_we = ~{(`NDS_ILM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_ilm1_cs = ~1'd0;
assign dcls_inject_fault_ilm1_wdata = ~{(`NDS_ILM_RAM_DW){1'b0}};
assign dcls_inject_fault_ilm1_we = ~1'd0;
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
assign dcls_inject_fault_dlm_addr = ~{(`NDS_DLM_RAM_AW){1'b0}};
assign dcls_inject_fault_dlm_byte_we = ~{(`NDS_DLM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dlm_cs = ~1'd0;
assign dcls_inject_fault_dlm_wdata = ~{(`NDS_DLM_RAM_DW){1'b0}};
assign dcls_inject_fault_dlm_we = ~1'd0;
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
assign dcls_inject_fault_dlm1_addr = ~{(`NDS_DLM_RAM_AW){1'b0}};
assign dcls_inject_fault_dlm1_byte_we = ~{(`NDS_DLM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dlm1_cs = ~1'd0;
assign dcls_inject_fault_dlm1_wdata = ~{(`NDS_DLM_RAM_DW){1'b0}};
assign dcls_inject_fault_dlm1_we = ~1'd0;
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
assign dcls_inject_fault_dlm2_addr = ~{(`NDS_DLM_RAM_AW){1'b0}};
assign dcls_inject_fault_dlm2_byte_we = ~{(`NDS_DLM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dlm2_cs = ~1'd0;
assign dcls_inject_fault_dlm2_wdata = ~{(`NDS_DLM_RAM_DW){1'b0}};
assign dcls_inject_fault_dlm2_we = ~1'd0;
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
assign dcls_inject_fault_dlm3_addr = ~{(`NDS_DLM_RAM_AW){1'b0}};
assign dcls_inject_fault_dlm3_byte_we = ~{(`NDS_DLM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dlm3_cs = ~1'd0;
assign dcls_inject_fault_dlm3_wdata = ~{(`NDS_DLM_RAM_DW){1'b0}};
assign dcls_inject_fault_dlm3_we = ~1'd0;
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_ICACHE1
assign dcls_inject_fault_icache_tag1_addr = ~{(`NDS_ICACHE_TAG_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_tag1_cs = ~1'd0;
assign dcls_inject_fault_icache_tag1_wdata = ~{(`NDS_ICACHE_TAG_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_tag1_we = ~1'd0;
`endif // NDS_IO_ICACHE1
`ifdef NDS_IO_ICACHE2
assign dcls_inject_fault_icache_tag2_addr = ~{(`NDS_ICACHE_TAG_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_tag2_cs = ~1'd0;
assign dcls_inject_fault_icache_tag2_wdata = ~{(`NDS_ICACHE_TAG_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_tag2_we = ~1'd0;
assign dcls_inject_fault_icache_tag3_addr = ~{(`NDS_ICACHE_TAG_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_tag3_cs = ~1'd0;
assign dcls_inject_fault_icache_tag3_wdata = ~{(`NDS_ICACHE_TAG_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_tag3_we = ~1'd0;
`endif // NDS_IO_ICACHE2
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_BTB_RAM_CTRL_IN
`endif // NDS_IO_BTB_RAM_CTRL_IN
`ifdef NDS_IO_BTB_RAM_CTRL_OUT
`endif // NDS_IO_BTB_RAM_CTRL_OUT
`ifdef NDS_IO_BTB2_RAM_CTRL_IN
`endif // NDS_IO_BTB2_RAM_CTRL_IN
`ifdef NDS_IO_BTB2_RAM_CTRL_OUT
`endif // NDS_IO_BTB2_RAM_CTRL_OUT
`ifdef NDS_IO_BTB3_RAM_CTRL_IN
`endif // NDS_IO_BTB3_RAM_CTRL_IN
`ifdef NDS_IO_BTB3_RAM_CTRL_OUT
`endif // NDS_IO_BTB3_RAM_CTRL_OUT
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM0_CTRL_IN
`endif // NDS_IO_ILM_RAM0_CTRL_IN
`ifdef NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
`ifdef NDS_IO_ILM_RAM1_CTRL_IN
`endif // NDS_IO_ILM_RAM1_CTRL_IN
`ifdef NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM0_CTRL_IN
`endif // NDS_IO_DLM_RAM0_CTRL_IN
`ifdef NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM1_CTRL_IN
`endif // NDS_IO_DLM_RAM1_CTRL_IN
`ifdef NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM2_CTRL_IN
`endif // NDS_IO_DLM_RAM2_CTRL_IN
`ifdef NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
`ifdef NDS_IO_DLM_RAM3_CTRL_IN
`endif // NDS_IO_DLM_RAM3_CTRL_IN
`ifdef NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_BTB_RAM
assign dcls_inject_fault_btb0_addr = ~{(`NDS_BTB_RAM_ADDR_WIDTH){1'b0}};
assign dcls_inject_fault_btb0_cs = ~1'd0;
assign dcls_inject_fault_btb0_wdata = ~{(`NDS_BTB_RAM_DATA_WIDTH){1'b0}};
assign dcls_inject_fault_btb0_we = ~1'd0;
assign dcls_inject_fault_btb1_addr = ~{(`NDS_BTB_RAM_ADDR_WIDTH){1'b0}};
assign dcls_inject_fault_btb1_cs = ~1'd0;
assign dcls_inject_fault_btb1_wdata = ~{(`NDS_BTB_RAM_DATA_WIDTH){1'b0}};
assign dcls_inject_fault_btb1_we = ~1'd0;
`endif // NDS_IO_BTB_RAM
`ifdef NDS_IO_BTB2_RAM
assign dcls_inject_fault_btb2_addr = ~{(`NDS_BTB_RAM_ADDR_WIDTH){1'b0}};
assign dcls_inject_fault_btb2_cs = ~1'd0;
assign dcls_inject_fault_btb2_wdata = ~{(`NDS_BTB_RAM_DATA_WIDTH){1'b0}};
assign dcls_inject_fault_btb2_we = ~1'd0;
`endif // NDS_IO_BTB2_RAM
`ifdef NDS_IO_BTB3_RAM
assign dcls_inject_fault_btb3_addr = ~{(`NDS_BTB_RAM_ADDR_WIDTH){1'b0}};
assign dcls_inject_fault_btb3_cs = ~1'd0;
assign dcls_inject_fault_btb3_wdata = ~{(`NDS_BTB_RAM_DATA_WIDTH){1'b0}};
assign dcls_inject_fault_btb3_we = ~1'd0;
`endif // NDS_IO_BTB3_RAM
`ifdef NDS_IO_DCACHE1
assign dcls_inject_fault_dcache_tag1_addr = ~{(`NDS_DCACHE_TAG_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_tag1_cs = ~1'd0;
assign dcls_inject_fault_dcache_tag1_wdata = ~{(`NDS_DCACHE_TAG_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_tag1_we = ~1'd0;
`endif // NDS_IO_DCACHE1
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE1
`ifdef NDS_IO_DCACHE1_CTRL_IN
`endif // NDS_IO_DCACHE1_CTRL_IN
`ifdef NDS_IO_DCACHE1_CTRL_OUT
`endif // NDS_IO_DCACHE1_CTRL_OUT
`endif // NDS_IO_DCACHE1
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_DCACHE2
assign dcls_inject_fault_dcache_tag2_addr = ~{(`NDS_DCACHE_TAG_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_tag2_cs = ~1'd0;
assign dcls_inject_fault_dcache_tag2_wdata = ~{(`NDS_DCACHE_TAG_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_tag2_we = ~1'd0;
assign dcls_inject_fault_dcache_tag3_addr = ~{(`NDS_DCACHE_TAG_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_tag3_cs = ~1'd0;
assign dcls_inject_fault_dcache_tag3_wdata = ~{(`NDS_DCACHE_TAG_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_tag3_we = ~1'd0;
`endif // NDS_IO_DCACHE2
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE2
`ifdef NDS_IO_DCACHE2_CTRL_IN
`endif // NDS_IO_DCACHE2_CTRL_IN
`ifdef NDS_IO_DCACHE2_CTRL_OUT
`endif // NDS_IO_DCACHE2_CTRL_OUT
`endif // NDS_IO_DCACHE2
`ifdef NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ICACHE0
`ifdef NDS_IO_ICACHE0_CTRL_IN
`endif // NDS_IO_ICACHE0_CTRL_IN
`ifdef NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM0_CTRL_IN
`endif // NDS_IO_ILM_RAM0_CTRL_IN
`ifdef NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
`ifdef NDS_IO_ILM_RAM1_CTRL_IN
`endif // NDS_IO_ILM_RAM1_CTRL_IN
`ifdef NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM0_CTRL_IN
`endif // NDS_IO_DLM_RAM0_CTRL_IN
`ifdef NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM1_CTRL_IN
`endif // NDS_IO_DLM_RAM1_CTRL_IN
`ifdef NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM2_CTRL_IN
`endif // NDS_IO_DLM_RAM2_CTRL_IN
`ifdef NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
`ifdef NDS_IO_DLM_RAM3_CTRL_IN
`endif // NDS_IO_DLM_RAM3_CTRL_IN
`ifdef NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_DCACHE0
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_dcache_data4_addr = ~{(`NDS_DCACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_data4_byte_we = ~{(`NDS_DCACHE_DATA_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dcache_data4_cs = ~1'd0;
assign dcls_inject_fault_dcache_data4_wdata = ~{(`NDS_DCACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_data4_we = ~1'd0;
assign dcls_inject_fault_dcache_data5_addr = ~{(`NDS_DCACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_data5_byte_we = ~{(`NDS_DCACHE_DATA_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dcache_data5_cs = ~1'd0;
assign dcls_inject_fault_dcache_data5_wdata = ~{(`NDS_DCACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_data5_we = ~1'd0;
assign dcls_inject_fault_dcache_data6_addr = ~{(`NDS_DCACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_data6_byte_we = ~{(`NDS_DCACHE_DATA_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dcache_data6_cs = ~1'd0;
assign dcls_inject_fault_dcache_data6_wdata = ~{(`NDS_DCACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_data6_we = ~1'd0;
assign dcls_inject_fault_dcache_data7_addr = ~{(`NDS_DCACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_dcache_data7_byte_we = ~{(`NDS_DCACHE_DATA_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dcache_data7_cs = ~1'd0;
assign dcls_inject_fault_dcache_data7_wdata = ~{(`NDS_DCACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_dcache_data7_we = ~1'd0;
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE_CTRL_IN
`endif // NDS_IO_DCACHE_CTRL_IN
`ifdef NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_LM
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM
`ifdef NDS_IO_ILM_BOOT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_ILM_BOOT
`ifdef NDS_IO_DLM_BOOT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DLM_BOOT
`ifdef NDS_IO_SLAVEPORT_SYNC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_SYNC
`ifdef NDS_IO_SLAVEPORT_SYNC_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_SYNC_X2
`ifdef NDS_IO_PPI_SYNC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PPI_SYNC
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_TRACE_TILELINK
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_LM_RESET
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM_RESET
`ifdef NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DLM_TL_UL
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_ICACHE0
`ifdef NDS_IO_DCLS
assign dcls_inject_fault_icache_data10_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data10_cs = ~1'd0;
assign dcls_inject_fault_icache_data10_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data10_we = ~1'd0;
assign dcls_inject_fault_icache_data11_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data11_cs = ~1'd0;
assign dcls_inject_fault_icache_data11_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data11_we = ~1'd0;
assign dcls_inject_fault_icache_data12_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data12_cs = ~1'd0;
assign dcls_inject_fault_icache_data12_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data12_we = ~1'd0;
assign dcls_inject_fault_icache_data13_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data13_cs = ~1'd0;
assign dcls_inject_fault_icache_data13_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data13_we = ~1'd0;
assign dcls_inject_fault_icache_data14_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data14_cs = ~1'd0;
assign dcls_inject_fault_icache_data14_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data14_we = ~1'd0;
assign dcls_inject_fault_icache_data15_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data15_cs = ~1'd0;
assign dcls_inject_fault_icache_data15_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data15_we = ~1'd0;
assign dcls_inject_fault_icache_data8_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data8_cs = ~1'd0;
assign dcls_inject_fault_icache_data8_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data8_we = ~1'd0;
assign dcls_inject_fault_icache_data9_addr = ~{(`NDS_ICACHE_DATA_RAM_AW){1'b0}};
assign dcls_inject_fault_icache_data9_cs = ~1'd0;
assign dcls_inject_fault_icache_data9_wdata = ~{(`NDS_ICACHE_DATA_RAM_DW){1'b0}};
assign dcls_inject_fault_icache_data9_we = ~1'd0;
`endif // NDS_IO_DCLS
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_PROBING
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PROBING
`ifdef NDS_IO_SEIP
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_UEIP
`ifdef NDS_IO_DEBUG
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DEBUG
`ifdef NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_TRAP_STATUS
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_TRAP_STATUS
`ifdef NDS_IO_PPI
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PPI_PROT
`ifdef NDS_IO_LM_QOS
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM_QOS
`ifdef NDS_IO_SLAVEPORT_QOS_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_QOS_X1
`ifdef NDS_IO_SLAVEPORT_QOS_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_QOS_X2
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_ILM_RAM0
assign dcls_inject_fault_ilm2_addr = ~{(`NDS_ILM_RAM_AW){1'b0}};
assign dcls_inject_fault_ilm2_byte_we = ~{(`NDS_ILM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_ilm2_cs = ~1'd0;
assign dcls_inject_fault_ilm2_wdata = ~{(`NDS_ILM_RAM_DW){1'b0}};
assign dcls_inject_fault_ilm2_we = ~1'd0;
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
assign dcls_inject_fault_ilm3_addr = ~{(`NDS_ILM_RAM_AW){1'b0}};
assign dcls_inject_fault_ilm3_byte_we = ~{(`NDS_ILM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_ilm3_cs = ~1'd0;
assign dcls_inject_fault_ilm3_wdata = ~{(`NDS_ILM_RAM_DW){1'b0}};
assign dcls_inject_fault_ilm3_we = ~1'd0;
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
assign dcls_inject_fault_dlm4_addr = ~{(`NDS_DLM_RAM_AW){1'b0}};
assign dcls_inject_fault_dlm4_byte_we = ~{(`NDS_DLM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dlm4_cs = ~1'd0;
assign dcls_inject_fault_dlm4_wdata = ~{(`NDS_DLM_RAM_DW){1'b0}};
assign dcls_inject_fault_dlm4_we = ~1'd0;
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
assign dcls_inject_fault_dlm5_addr = ~{(`NDS_DLM_RAM_AW){1'b0}};
assign dcls_inject_fault_dlm5_byte_we = ~{(`NDS_DLM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dlm5_cs = ~1'd0;
assign dcls_inject_fault_dlm5_wdata = ~{(`NDS_DLM_RAM_DW){1'b0}};
assign dcls_inject_fault_dlm5_we = ~1'd0;
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
assign dcls_inject_fault_dlm6_addr = ~{(`NDS_DLM_RAM_AW){1'b0}};
assign dcls_inject_fault_dlm6_byte_we = ~{(`NDS_DLM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dlm6_cs = ~1'd0;
assign dcls_inject_fault_dlm6_wdata = ~{(`NDS_DLM_RAM_DW){1'b0}};
assign dcls_inject_fault_dlm6_we = ~1'd0;
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
assign dcls_inject_fault_dlm7_addr = ~{(`NDS_DLM_RAM_AW){1'b0}};
assign dcls_inject_fault_dlm7_byte_we = ~{(`NDS_DLM_RAM_BWEW){1'b0}};
assign dcls_inject_fault_dlm7_cs = ~1'd0;
assign dcls_inject_fault_dlm7_wdata = ~{(`NDS_DLM_RAM_DW){1'b0}};
assign dcls_inject_fault_dlm7_we = ~1'd0;
`endif // NDS_IO_DLM_RAM3
`endif // NDS_IO_DCLS
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS_SPLIT
`ifdef DISABLE_FUSA_MON
`else // DISABLE_FUSA_MON
`ifdef OVL_ASSERT_ON
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS
`ifdef NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_EDC_AFTER_ECC
`endif // OVL_ASSERT_ON
`endif // DISABLE_FUSA_MON
`ifdef NDS_IO_SLAVEPORT_COMMON_X2
`endif // NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_BUS_PROTECTION
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_EDC_AFTER_ECC
`endif // NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_LM
`endif // NDS_IO_LM
`ifdef NDS_IO_ILM_BOOT
`endif // NDS_IO_ILM_BOOT
`ifdef NDS_IO_DLM_BOOT
`endif // NDS_IO_DLM_BOOT
`ifdef NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_SLAVEPORT_SYNC
`endif // NDS_IO_SLAVEPORT_SYNC
`ifdef NDS_IO_SLAVEPORT_SYNC_X2
`endif // NDS_IO_SLAVEPORT_SYNC_X2
`ifdef NDS_IO_PPI_SYNC
`endif // NDS_IO_PPI_SYNC
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X2
`endif // NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_TRACE_TILELINK
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_LM_RESET
`endif // NDS_IO_LM_RESET
`ifdef NDS_IO_ILM_TL_UL
`endif // NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DLM_TL_UL
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_ICACHE0
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCACHE0
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_PROBING
`endif // NDS_IO_PROBING
`ifdef NDS_IO_SEIP
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
`endif // NDS_IO_UEIP
`ifdef NDS_IO_DEBUG
`endif // NDS_IO_DEBUG
`ifdef NDS_IO_TRACE_INSTR_GEN1
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_TRAP_STATUS
`endif // NDS_IO_TRAP_STATUS
`ifdef NDS_IO_PPI
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
`endif // NDS_IO_PPI_PROT
`ifdef NDS_IO_LM_QOS
`endif // NDS_IO_LM_QOS
`ifdef NDS_IO_SLAVEPORT_QOS_X1
`endif // NDS_IO_SLAVEPORT_QOS_X1
`ifdef NDS_IO_SLAVEPORT_QOS_X2
`endif // NDS_IO_SLAVEPORT_QOS_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`ifdef NDS_IO_ICACHE0_CTRL_IN
`endif // NDS_IO_ICACHE0_CTRL_IN
`ifdef NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0_CTRL_OUT
`ifdef NDS_IO_ICACHE1_CTRL_IN
`endif // NDS_IO_ICACHE1_CTRL_IN
`ifdef NDS_IO_ICACHE1_CTRL_OUT
`endif // NDS_IO_ICACHE1_CTRL_OUT
`ifdef NDS_IO_ICACHE2_CTRL_IN
`endif // NDS_IO_ICACHE2_CTRL_IN
`ifdef NDS_IO_ICACHE2_CTRL_OUT
`endif // NDS_IO_ICACHE2_CTRL_OUT
`ifdef NDS_IO_BTB_RAM_CTRL_IN
`endif // NDS_IO_BTB_RAM_CTRL_IN
`ifdef NDS_IO_BTB_RAM_CTRL_OUT
`endif // NDS_IO_BTB_RAM_CTRL_OUT
`ifdef NDS_IO_BTB2_RAM_CTRL_IN
`endif // NDS_IO_BTB2_RAM_CTRL_IN
`ifdef NDS_IO_BTB2_RAM_CTRL_OUT
`endif // NDS_IO_BTB2_RAM_CTRL_OUT
`ifdef NDS_IO_BTB3_RAM_CTRL_IN
`endif // NDS_IO_BTB3_RAM_CTRL_IN
`ifdef NDS_IO_BTB3_RAM_CTRL_OUT
`endif // NDS_IO_BTB3_RAM_CTRL_OUT
`ifdef NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ICACHE0
`endif // NDS_IO_ICACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM0_CTRL_IN
`endif // NDS_IO_ILM_RAM0_CTRL_IN
`ifdef NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
`ifdef NDS_IO_ILM_RAM1_CTRL_IN
`endif // NDS_IO_ILM_RAM1_CTRL_IN
`ifdef NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM0_CTRL_IN
`endif // NDS_IO_DLM_RAM0_CTRL_IN
`ifdef NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM1_CTRL_IN
`endif // NDS_IO_DLM_RAM1_CTRL_IN
`ifdef NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM2_CTRL_IN
`endif // NDS_IO_DLM_RAM2_CTRL_IN
`ifdef NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
`ifdef NDS_IO_DLM_RAM3_CTRL_IN
`endif // NDS_IO_DLM_RAM3_CTRL_IN
`ifdef NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_BTB_RAM
`endif // NDS_IO_BTB_RAM
`ifdef NDS_IO_BTB2_RAM
`endif // NDS_IO_BTB2_RAM
`ifdef NDS_IO_BTB3_RAM
`endif // NDS_IO_BTB3_RAM
`endif // NDS_IO_DCLS
`ifdef NDS_IO_ICACHE0
`ifdef NDS_IO_ICACHE0_CTRL_IN
`endif // NDS_IO_ICACHE0_CTRL_IN
`ifdef NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCACHE0
`endif // NDS_IO_DCACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCACHE0
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE0_CTRL_IN
`endif // NDS_IO_DCACHE0_CTRL_IN
`ifdef NDS_IO_DCACHE0_CTRL_OUT
`endif // NDS_IO_DCACHE0_CTRL_OUT
`ifdef NDS_IO_DCACHE_CTRL_IN
`endif // NDS_IO_DCACHE_CTRL_IN
`ifdef NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_DCACHE1
`endif // NDS_IO_DCACHE1
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE1
`ifdef NDS_IO_DCACHE1_CTRL_IN
`endif // NDS_IO_DCACHE1_CTRL_IN
`ifdef NDS_IO_DCACHE1_CTRL_OUT
`endif // NDS_IO_DCACHE1_CTRL_OUT
`endif // NDS_IO_DCACHE1
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_DCACHE2
`endif // NDS_IO_DCACHE2
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE2
`ifdef NDS_IO_DCACHE2_CTRL_IN
`endif // NDS_IO_DCACHE2_CTRL_IN
`ifdef NDS_IO_DCACHE2_CTRL_OUT
`endif // NDS_IO_DCACHE2_CTRL_OUT
`endif // NDS_IO_DCACHE2
`ifdef NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_LM
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_TRACE_TILELINK
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_LM_RESET
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM_RESET
`ifdef NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_ILM_RAM0
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_TL_UL
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_DLM_RAM0
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_ICACHE0
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_ICACHE1
`endif // NDS_IO_ICACHE1
`ifdef NDS_IO_ICACHE2
`endif // NDS_IO_ICACHE2
`ifdef NDS_IO_PROBING
`endif // NDS_IO_PROBING
`ifdef NDS_IO_SEIP
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
`endif // NDS_IO_UEIP
`ifdef NDS_IO_DEBUG
`endif // NDS_IO_DEBUG
`ifdef NDS_IO_TRACE_INSTR_GEN1
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_TRAP_STATUS
`endif // NDS_IO_TRAP_STATUS
`ifdef NDS_IO_PPI
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
`endif // NDS_IO_PPI_PROT
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_BTB_RAM_CTRL_IN
`endif // NDS_IO_BTB_RAM_CTRL_IN
`ifdef NDS_IO_BTB_RAM_CTRL_OUT
`endif // NDS_IO_BTB_RAM_CTRL_OUT
`ifdef NDS_IO_BTB2_RAM_CTRL_IN
`endif // NDS_IO_BTB2_RAM_CTRL_IN
`ifdef NDS_IO_BTB2_RAM_CTRL_OUT
`endif // NDS_IO_BTB2_RAM_CTRL_OUT
`ifdef NDS_IO_BTB3_RAM_CTRL_IN
`endif // NDS_IO_BTB3_RAM_CTRL_IN
`ifdef NDS_IO_BTB3_RAM_CTRL_OUT
`endif // NDS_IO_BTB3_RAM_CTRL_OUT
`ifdef NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM0_CTRL_IN
`endif // NDS_IO_ILM_RAM0_CTRL_IN
`ifdef NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
`ifdef NDS_IO_ILM_RAM1_CTRL_IN
`endif // NDS_IO_ILM_RAM1_CTRL_IN
`ifdef NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM0_CTRL_IN
`endif // NDS_IO_DLM_RAM0_CTRL_IN
`ifdef NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM1_CTRL_IN
`endif // NDS_IO_DLM_RAM1_CTRL_IN
`ifdef NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM2_CTRL_IN
`endif // NDS_IO_DLM_RAM2_CTRL_IN
`ifdef NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
`ifdef NDS_IO_DLM_RAM3_CTRL_IN
`endif // NDS_IO_DLM_RAM3_CTRL_IN
`ifdef NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_ICACHE0
`ifdef NDS_IO_ICACHE0_CTRL_IN
`endif // NDS_IO_ICACHE0_CTRL_IN
`ifdef NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCACHE0
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE_CTRL_IN
`endif // NDS_IO_DCACHE_CTRL_IN
`ifdef NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_LM
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM
`ifdef NDS_IO_ILM_BOOT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_ILM_BOOT
`ifdef NDS_IO_DLM_BOOT
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_DLM_BOOT
`ifdef NDS_IO_SLAVEPORT_SYNC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_SYNC
`ifdef NDS_IO_SLAVEPORT_SYNC_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_SYNC_X2
`ifdef NDS_IO_PPI_SYNC
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_PPI_SYNC
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_TRACE_TILELINK
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_LM_RESET
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_LM_RESET
`ifdef NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DCLS
`endif // NDS_IO_DCLS
`endif // NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_ILM_RAM0
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_TL_UL
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_DLM_RAM0
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_ICACHE0
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_PROBING
`endif // NDS_IO_PROBING
`ifdef NDS_IO_SEIP
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
`endif // NDS_IO_UEIP
`ifdef NDS_IO_DEBUG
`endif // NDS_IO_DEBUG
`ifdef NDS_IO_TRACE_INSTR_GEN1
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_TRAP_STATUS
`endif // NDS_IO_TRAP_STATUS
`ifdef NDS_IO_PPI
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
`endif // NDS_IO_PPI_PROT
`ifdef NDS_IO_LM_QOS
`endif // NDS_IO_LM_QOS
`ifdef NDS_IO_SLAVEPORT_QOS_X1
`endif // NDS_IO_SLAVEPORT_QOS_X1
`ifdef NDS_IO_SLAVEPORT_QOS_X2
`endif // NDS_IO_SLAVEPORT_QOS_X2
`endif // NDS_IO_DCLS
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_BUS_PROTECTION
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_FLASHIF0
`endif // NDS_IO_FLASHIF0
`ifdef NDS_IO_SPP
`endif // NDS_IO_SPP
`ifdef NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_FLASHIF0
`endif // NDS_IO_FLASHIF0
`ifdef NDS_IO_SPP
`endif // NDS_IO_SPP
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
      `ifdef ATCBUSDEC302_SLV1_SUPPORT
              assign core0_slv_awuser = busdec2slv_awaddr[SLVPORT_DLM_SEL_BIT];
              assign core0_slv_aruser = busdec2slv_araddr[SLVPORT_DLM_SEL_BIT];
      `endif // ATCBUSDEC302_SLV1_SUPPORT
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
      `ifdef ATCBUSDEC302_SLV2_SUPPORT
              assign core1_slv_awuser = busdec2slv_awaddr[SLVPORT_DLM_SEL_BIT];
              assign core1_slv_aruser = busdec2slv_araddr[SLVPORT_DLM_SEL_BIT];
      `endif // ATCBUSDEC302_SLV2_SUPPORT
`endif // NDS_IO_SLAVEPORT_COMMON_X1
	`ifdef NDS_IO_SLAVEPORT_QOS_X1
      	assign core0_slv_awqos = 4'b0;
      	assign core0_slv_arqos = 4'b0;
	`endif
`ifdef NDS_IO_DCLS_SPLIT
	`ifdef NDS_IO_SLAVEPORT_QOS_X1
      	assign core1_slv_awqos = 4'b0;
      	assign core1_slv_arqos = 4'b0;
	`endif
`endif
	`ifdef NDS_IO_LM_QOS
	assign core0_ifu_ilm_qos = 4'b0;
	assign core0_lsu_dlm_qos = 4'b0;
	assign core0_lsu_ilm_qos = 4'b0;
	`endif
`ifdef NDS_IO_DCLS_SPLIT
	`ifdef NDS_IO_LM_QOS
	assign core1_ifu_ilm_qos = 4'b0;
	assign core1_lsu_dlm_qos = 4'b0;
	assign core1_lsu_ilm_qos = 4'b0;
	`endif
`endif
`ifdef NDS_IO_SPP
assign busdec_us_araddr  = axi_spp_araddr;
assign busdec_us_arburst = axi_spp_arburst;
assign busdec_us_arcache = axi_spp_arcache;
assign busdec_us_arid    = {{((BIU_ID_WIDTH+4)-`NDS_SPP_ID_WIDTH){1'b0}}, spp_arid};
assign busdec_us_arlen   = axi_spp_arlen;
assign busdec_us_arlock  = axi_spp_arlock;
assign busdec_us_arprot  = axi_spp_arprot;
assign busdec_us_arsize  = axi_spp_arsize;
assign busdec_us_arvalid = axi_spp_arvalid;
assign axi_spp_arready   = busdec_us_arready;
assign busdec_us_awaddr  = axi_spp_awaddr;
assign busdec_us_awburst = axi_spp_awburst;
assign busdec_us_awcache = axi_spp_awcache;
assign busdec_us_awid    = {{((BIU_ID_WIDTH+4)-`NDS_SPP_ID_WIDTH){1'b0}}, spp_awid};
assign busdec_us_awlen   = axi_spp_awlen;
assign busdec_us_awlock  = axi_spp_awlock;
assign busdec_us_awprot  = axi_spp_awprot;
assign busdec_us_awsize  = axi_spp_awsize;
assign busdec_us_awvalid = axi_spp_awvalid;
assign axi_spp_awready   = busdec_us_awready;
assign busdec_us_wdata  = axi_spp_wdata;
assign busdec_us_wlast  = axi_spp_wlast;
assign busdec_us_wstrb  = axi_spp_wstrb;
assign busdec_us_wvalid = axi_spp_wvalid;
assign axi_spp_wready   = busdec_us_wready;
assign axi_spp_bid      = busdec_us_bid[`NDS_SPP_ID_WIDTH-1:0];
assign axi_spp_bresp    = busdec_us_bresp;
assign axi_spp_bvalid   = busdec_us_bvalid;
assign axi_spp_rdata    = busdec_us_rdata;
assign axi_spp_rid      = busdec_us_rid[`NDS_SPP_ID_WIDTH-1:0];
assign busdec_us_bready = axi_spp_bready;
assign axi_spp_rlast    = busdec_us_rlast;
assign axi_spp_rresp    = busdec_us_rresp;
assign axi_spp_rvalid   = busdec_us_rvalid;
assign busdec_us_rready = axi_spp_rready;
`endif // NDS_IO_SPP
`ifdef NDS_IO_DLM_TL_UL
assign core0_dlm_reset_n = core0_lm_reset_n;
`ifdef NDS_IO_DCLS_SPLIT
assign core1_dlm_reset_n = core1_lm_reset_n;
`endif // NDS_IO_DCLS
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_ILM_TL_UL
`ifdef NDS_IO_HART0
assign core0_ilm_reset_n = core0_lm_reset_n;
assign core0_ilm_d_parity0[ILM_TL_UL_EW-1:0] = core0_ilm_d_parity0_out[ILM_TL_UL_EW-1:0];
assign core0_ilm_d_parity1[ILM_TL_UL_EW-1:0] = core0_ilm_d_parity1_out[ILM_TL_UL_EW-1:0];
generate
if (ILM_ECC_SUPPORT && (XLEN == 32)) begin : gen_core0_ilm_parity_32
       wire nds_unused_core0_ilm_a_parity0 = core0_ilm_a_parity0[7];
       wire nds_unused_core0_ilm_a_parity1 = core0_ilm_a_parity1[7];
       assign core0_ilm_a_parity0_in = core0_ilm_a_parity0[6:0];
       assign core0_ilm_a_parity1_in = core0_ilm_a_parity1[6:0];
       assign core0_ilm_d_parity0[7] = 1'b0;
       assign core0_ilm_d_parity1[7] = 1'b0;
end
else if (ILM_ECC_SUPPORT && (XLEN == 64)) begin : gen_core0_ilm_parity_64
       assign core0_ilm_a_parity0_in = core0_ilm_a_parity0[7:0];
       assign core0_ilm_a_parity1_in = core0_ilm_a_parity1[7:0];
end
else begin : gen_core0_ilm_parity_no_ecc
       wire nds_unused_core0_ilm_a_parity0 = |core0_ilm_a_parity0;
       wire nds_unused_core0_ilm_a_parity1 = |core0_ilm_a_parity1;
       assign core0_ilm_a_parity0_in = 1'b0;
       assign core0_ilm_a_parity1_in = 1'b0;
       assign core0_ilm_d_parity0[7:1] = 7'b0;
       assign core0_ilm_d_parity1[7:1] = 7'b0;
end
endgenerate

`ifdef NDS_IO_ILM_RAM_ECC
wire nds_unused_core0_bwe = (|core0_ilm0_bwe) | (|core0_ilm1_bwe);
`endif // NDS_IO_ILM_RAM_ECC
generate
if (ILM_TL_UL_RAM_NUM < 2) begin : gen_ilm_tl_ul_core0_ram1_stub
       wire nds_unused_core0_ram1_if = core0_ilm1_cs | core0_ilm1_we;
       assign core0_ilm1_rdata = {ILM_TL_UL_RAM_DW{1'b0}};
       assign nds_unused_tl_ul_core0_ilm1_ctrl_out = {`NDS_ILM_RAM_CTRL_OUT_WIDTH{1'b0}};
end
endgenerate
`endif // NDS_IO_HART0
`ifdef NDS_IO_HART1
assign core1_ilm_reset_n = core1_lm_reset_n;
assign core1_ilm_d_parity0[ILM_TL_UL_EW-1:0] = core1_ilm_d_parity0_out[ILM_TL_UL_EW-1:0];
assign core1_ilm_d_parity1[ILM_TL_UL_EW-1:0] = core1_ilm_d_parity1_out[ILM_TL_UL_EW-1:0];
generate
if (ILM_ECC_SUPPORT && (XLEN == 32)) begin : gen_core1_ilm_parity_32
       wire nds_unused_core1_ilm_a_parity0 = core1_ilm_a_parity0[7];
       wire nds_unused_core1_ilm_a_parity1 = core1_ilm_a_parity1[7];
       assign core1_ilm_a_parity0_in = core1_ilm_a_parity0[6:0];
       assign core1_ilm_a_parity1_in = core1_ilm_a_parity1[6:0];
       assign core1_ilm_d_parity0[7] = 1'b0;
       assign core1_ilm_d_parity1[7] = 1'b0;
end
else if (ILM_ECC_SUPPORT && (XLEN == 64)) begin : gen_core1_ilm_parity_64
       assign core1_ilm_a_parity0_in = core1_ilm_a_parity0[7:0];
       assign core1_ilm_a_parity1_in = core1_ilm_a_parity1[7:0];
end
else begin : gen_core1_ilm_parity_no_ecc
       wire nds_unused_core1_ilm_a_parity0 = |core1_ilm_a_parity0;
       wire nds_unused_core1_ilm_a_parity1 = |core1_ilm_a_parity1;
       assign core1_ilm_a_parity0_in = 1'b0;
       assign core1_ilm_a_parity1_in = 1'b0;
       assign core1_ilm_d_parity0[7:1] = 7'b0;
       assign core1_ilm_d_parity1[7:1] = 7'b0;
end
endgenerate

`ifdef NDS_IO_ILM_RAM_ECC
wire nds_unused_core1_bwe = (|core1_ilm0_bwe) | (|core1_ilm1_bwe);
`endif // NDS_IO_ILM_RAM_ECC
generate
if (ILM_TL_UL_RAM_NUM < 2) begin : gen_ilm_tl_ul_core1_ram1_stub
       wire nds_unused_core1_ram1_if = core1_ilm1_cs | core1_ilm1_we;
       assign core1_ilm1_rdata = {ILM_TL_UL_RAM_DW{1'b0}};
       assign nds_unused_tl_ul_core1_ilm1_ctrl_out = {`NDS_ILM_RAM_CTRL_OUT_WIDTH{1'b0}};
end
endgenerate
`endif // NDS_IO_HART1
`endif // NDS_IO_ILM_TL_UL
`ifdef ATCBMC301_SLV2_SUPPORT
assign sys_exmon_bid_dummy = 4'b0; //sys_exmon_bid_dummy;
assign sys_exmon_rid_dummy = 4'b0; //sys_exmon_rid_dummy;
`endif // ATCBMC301_SLV2_SUPPORT
`ifdef ATCBMC301_SLV3_SUPPORT
assign flash0_bid_dummy = 4'b1;
assign flash0_rid_dummy = 4'b1;
`endif // ATCBMC301_SLV3_SUPPORT
`ifdef NDS_IO_SPP
assign inter_ds1_arready = 1'b0;
assign inter_ds1_awready = 1'b0;
assign inter_ds1_wready  = 1'b0;
assign inter_ds1_rdata = {BIU_DATA_WIDTH{1'b0}};
assign inter_ds1_rid = {BIU_ID_WIDTH{1'b0}};
assign inter_ds1_rid_dummy = 4'd0;
assign inter_ds1_rlast = 1'd0;
assign inter_ds1_rresp = 2'd0;
assign inter_ds1_rvalid = 1'b0;
assign inter_ds1_bvalid  = 1'b0;
assign inter_ds1_bid = {BIU_ID_WIDTH{1'b0}};
assign inter_ds1_bid_dummy = 4'd0;
assign inter_ds1_bresp = 2'd0;
`endif // NDS_IO_SPP
`ifndef NDS_IO_SPP
generate
if (BIU_DATA_WIDTH > NCE_DATA_WIDTH) begin: gen_connect_axi_sdn
    assign sdn_arid = {(BIU_ID_WIDTH+4){1'b0}};
    assign sdn_awid = {(BIU_ID_WIDTH+4){1'b0}};
end
else begin: gen_connect_axi
            assign sdn_araddr  = inter_ds1_araddr;
            assign sdn_arburst = inter_ds1_arburst;
            assign sdn_arcache = inter_ds1_arcache;
            assign sdn_arid    = {inter_ds1_arid, inter_ds1_arid_dummy};
            assign sdn_arlen   = inter_ds1_arlen;
            assign sdn_arlock  = inter_ds1_arlock;
            assign sdn_arprot  = inter_ds1_arprot;
            assign sdn_arsize  = inter_ds1_arsize;
            assign sdn_arvalid = inter_ds1_arvalid;
            assign inter_ds1_arready  = sdn_arready;

            assign sdn_awaddr  = inter_ds1_awaddr;
            assign sdn_awburst = inter_ds1_awburst;
            assign sdn_awcache = inter_ds1_awcache;
            assign sdn_awid    = {inter_ds1_awid, inter_ds1_awid_dummy};
            assign sdn_awlen   = inter_ds1_awlen;
            assign sdn_awlock  = inter_ds1_awlock;
            assign sdn_awprot  = inter_ds1_awprot;
            assign sdn_awsize  = inter_ds1_awsize;
            assign sdn_awvalid = inter_ds1_awvalid;
            assign inter_ds1_awready  = sdn_awready;

            assign {inter_ds1_bid, inter_ds1_bid_dummy} = sdn_bid;
            assign inter_ds1_bresp    = sdn_bresp;
            assign inter_ds1_bvalid   = sdn_bvalid;
            assign sdn_bready  = inter_ds1_bready;

            assign inter_ds1_rdata    = sdn_rdata;
            assign {inter_ds1_rid, inter_ds1_rid_dummy} = sdn_rid;
            assign inter_ds1_rlast    = sdn_rlast;
            assign inter_ds1_rresp    = sdn_rresp;
            assign inter_ds1_rvalid   = sdn_rvalid;
            assign sdn_rready  = inter_ds1_rready;

            assign sdn_wdata   = inter_ds1_wdata;
            assign sdn_wlast   = inter_ds1_wlast;
            assign sdn_wstrb   = inter_ds1_wstrb;
            assign sdn_wvalid  = inter_ds1_wvalid;
            assign inter_ds1_wready   = sdn_wready;
end
endgenerate
assign busdec_us_araddr  = sdn_araddr;
assign busdec_us_arburst = sdn_arburst;
assign busdec_us_arcache = sdn_arcache;
assign busdec_us_arid    = sdn_arid;
assign busdec_us_arlen   = sdn_arlen;
assign busdec_us_arlock  = sdn_arlock;
assign busdec_us_arprot  = sdn_arprot;
assign busdec_us_arsize  = sdn_arsize;
assign busdec_us_arvalid = sdn_arvalid;
assign sdn_arready       = busdec_us_arready;
assign busdec_us_awaddr  = sdn_awaddr;
assign busdec_us_awburst = sdn_awburst;
assign busdec_us_awcache = sdn_awcache;
assign busdec_us_awid    = sdn_awid;
assign busdec_us_awlen   = sdn_awlen;
assign busdec_us_awlock  = sdn_awlock;
assign busdec_us_awprot  = sdn_awprot;
assign busdec_us_awsize  = sdn_awsize;
assign busdec_us_awvalid = sdn_awvalid;
assign sdn_awready       = busdec_us_awready;
assign busdec_us_wdata  = sdn_wdata;
assign busdec_us_wlast  = sdn_wlast;
assign busdec_us_wstrb  = sdn_wstrb;
assign busdec_us_wvalid = sdn_wvalid;
assign sdn_wready       = busdec_us_wready;
assign sdn_bid          = busdec_us_bid;
assign sdn_bresp        = busdec_us_bresp;
assign sdn_bvalid       = busdec_us_bvalid;
assign sdn_rdata        = busdec_us_rdata;
assign sdn_rid          = busdec_us_rid;
assign busdec_us_bready = sdn_bready;
assign sdn_rlast        = busdec_us_rlast;
assign sdn_rresp        = busdec_us_rresp;
assign sdn_rvalid       = busdec_us_rvalid;
assign busdec_us_rready = sdn_rready;
`endif // NDS_IO_SPP

`ifdef ATCBUSDEC301_SLV1_SUPPORT
      assign plic_awaddr  =       busdec2nce_awaddr       ;
      assign plic_awlen   =       busdec2nce_awlen        ;
      assign plic_awsize  =       busdec2nce_awsize       ;
      assign plic_awburst =       busdec2nce_awburst      ;
      assign plic_awlock  =       busdec2nce_awlock       ;
      assign plic_awcache =       busdec2nce_awcache      ;
      assign plic_awprot  =       busdec2nce_awprot       ;
      assign plic_wdata   =       busdec2nce_wdata        ;
      assign plic_wstrb   =       busdec2nce_wstrb        ;
      assign plic_wlast   =       busdec2nce_wlast        ;
      assign plic_araddr  =       busdec2nce_araddr       ;
      assign plic_arlen   =       busdec2nce_arlen        ;
      assign plic_arsize  =       busdec2nce_arsize       ;
      assign plic_arburst =       busdec2nce_arburst      ;
      assign plic_arlock  =       busdec2nce_arlock       ;
      assign plic_arcache =       busdec2nce_arcache      ;
      assign plic_arprot  =       busdec2nce_arprot       ;
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
      assign plmt_awaddr  =       busdec2nce_awaddr       ;
      assign plmt_awlen   =       busdec2nce_awlen        ;
      assign plmt_awsize  =       busdec2nce_awsize       ;
      assign plmt_awburst =       busdec2nce_awburst      ;
      assign plmt_awlock  =       busdec2nce_awlock       ;
      assign plmt_awcache =       busdec2nce_awcache      ;
      assign plmt_awprot  =       busdec2nce_awprot       ;
      assign plmt_wdata   =       busdec2nce_wdata        ;
      assign plmt_wstrb   =       busdec2nce_wstrb        ;
      assign plmt_wlast   =       busdec2nce_wlast        ;
      assign plmt_araddr  =       busdec2nce_araddr       ;
      assign plmt_arlen   =       busdec2nce_arlen        ;
      assign plmt_arsize  =       busdec2nce_arsize       ;
      assign plmt_arburst =       busdec2nce_arburst      ;
      assign plmt_arlock  =       busdec2nce_arlock       ;
      assign plmt_arcache =       busdec2nce_arcache      ;
      assign plmt_arprot  =       busdec2nce_arprot       ;
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
      assign plicsw_awaddr  =       busdec2nce_awaddr       ;
      assign plicsw_awlen   =       busdec2nce_awlen        ;
      assign plicsw_awsize  =       busdec2nce_awsize       ;
      assign plicsw_awburst =       busdec2nce_awburst      ;
      assign plicsw_awlock  =       busdec2nce_awlock       ;
      assign plicsw_awcache =       busdec2nce_awcache      ;
      assign plicsw_awprot  =       busdec2nce_awprot       ;
      assign plicsw_wdata   =       busdec2nce_wdata        ;
      assign plicsw_wstrb   =       busdec2nce_wstrb        ;
      assign plicsw_wlast   =       busdec2nce_wlast        ;
      assign plicsw_araddr  =       busdec2nce_araddr       ;
      assign plicsw_arlen   =       busdec2nce_arlen        ;
      assign plicsw_arsize  =       busdec2nce_arsize       ;
      assign plicsw_arburst =       busdec2nce_arburst      ;
      assign plicsw_arlock  =       busdec2nce_arlock       ;
      assign plicsw_arcache =       busdec2nce_arcache      ;
      assign plicsw_arprot  =       busdec2nce_arprot       ;
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
      assign dm_awaddr  =       busdec2nce_awaddr       ;
      assign dm_awlen   =       busdec2nce_awlen        ;
      assign dm_awsize  =       busdec2nce_awsize       ;
      assign dm_awburst =       busdec2nce_awburst      ;
      assign dm_awlock  =       busdec2nce_awlock       ;
      assign dm_awcache =       busdec2nce_awcache      ;
      assign dm_awprot  =       busdec2nce_awprot       ;
      assign dm_wdata   =       busdec2nce_wdata        ;
      assign dm_wstrb   =       busdec2nce_wstrb        ;
      assign dm_wlast   =       busdec2nce_wlast        ;
      assign dm_araddr  =       busdec2nce_araddr       ;
      assign dm_arlen   =       busdec2nce_arlen        ;
      assign dm_arsize  =       busdec2nce_arsize       ;
      assign dm_arburst =       busdec2nce_arburst      ;
      assign dm_arlock  =       busdec2nce_arlock       ;
      assign dm_arcache =       busdec2nce_arcache      ;
      assign dm_arprot  =       busdec2nce_arprot       ;
`endif
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
      `ifdef ATCBUSDEC302_SLV1_SUPPORT
      assign core0_slv_arvalid =       slvp_busdec_ds1_arvalid;
      assign core0_slv_awvalid =       slvp_busdec_ds1_awvalid;
      assign core0_slv_wvalid  =       slvp_busdec_ds1_wvalid;
      assign core0_slv_bready  =       slvp_busdec_ds1_bready;
      assign core0_slv_rready  =       slvp_busdec_ds1_rready;

      assign slvp_busdec_ds1_arready = core0_slv_arready;
      assign slvp_busdec_ds1_awready = core0_slv_awready;
      assign slvp_busdec_ds1_wready  = core0_slv_wready;
      assign slvp_busdec_ds1_rvalid = core0_slv_rvalid;
      assign slvp_busdec_ds1_rlast  = core0_slv_rlast;
      assign slvp_busdec_ds1_rdata  = core0_slv_rdata;
      assign slvp_busdec_ds1_rresp  = core0_slv_rresp;
      assign slvp_busdec_ds1_bvalid = core0_slv_bvalid;
      assign slvp_busdec_ds1_bresp  = core0_slv_bresp;
      assign core0_slv_awaddr  =       busdec2slv_awaddr       ;
      assign core0_slv_awlen   =       busdec2slv_awlen        ;
      assign core0_slv_awsize  =       busdec2slv_awsize       ;
      assign core0_slv_awburst =       busdec2slv_awburst      ;
      assign core0_slv_awlock  =       busdec2slv_awlock       ;
      assign core0_slv_awcache =       busdec2slv_awcache      ;
      assign core0_slv_awprot  =       busdec2slv_awprot       ;
      assign core0_slv_wdata   =       busdec2slv_wdata        ;
      assign core0_slv_wstrb   =       busdec2slv_wstrb        ;
      assign core0_slv_wlast   =       busdec2slv_wlast        ;
      assign core0_slv_araddr  =       busdec2slv_araddr       ;
      assign core0_slv_arlen   =       busdec2slv_arlen        ;
      assign core0_slv_arsize  =       busdec2slv_arsize       ;
      assign core0_slv_arburst =       busdec2slv_arburst      ;
      assign core0_slv_arlock  =       busdec2slv_arlock       ;
      assign core0_slv_arcache =       busdec2slv_arcache      ;
      assign core0_slv_arprot  =       busdec2slv_arprot       ;
      assign core0_slv_awid    =       {(SLVPORT_ID_WIDTH){1'b0}}      ;
      assign core0_slv_arid    =       {(SLVPORT_ID_WIDTH){1'b0}}      ;
      `endif // ATCBUSDEC302_SLV1_SUPPORT
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
      `ifdef ATCBUSDEC302_SLV1_SUPPORT
	wire nds_unused_core0_fs_bus_s_protection_error = (|core0_fs_bus_s_protection_error);
	`ifdef NDS_IO_SLAVEPORT_QOS_X1
	wire [11:0]			core0_slv_arctl0code_i = {core0_slv_arqos,core0_slv_aruser,core0_slv_arcache,core0_slv_arprot};
	`else
	wire [7:0]			core0_slv_arctl0code_i = {core0_slv_aruser,core0_slv_arcache,core0_slv_arprot};
	`endif
	wire [SLV_CTRL_CODE_WIDTH-1:0]	core0_slv_arctl0code_o;
	wire [13:0]			core0_slv_arctl1code_i = {core0_slv_arlock,core0_slv_arburst,core0_slv_arsize,core0_slv_arlen};
	wire [SLV_CTRL_CODE_WIDTH-1:0]	core0_slv_arctl1code_o;
	wire [SLVPORT_ID_WIDTH-1:0]	core0_slv_aridcode_i = core0_slv_arid[(SLVPORT_ID_WIDTH-1):0];
	wire [SLV_CTRL_CODE_WIDTH  :0]	core0_slv_aridcode_o; // only use [SLV_CTRL_CODE_WIDTH-1:0]
	`ifdef NDS_IO_SLAVEPORT_QOS_X1
	wire [11:0]			core0_slv_awctl0code_i = {core0_slv_awqos,core0_slv_awuser,core0_slv_awcache,core0_slv_awprot};
	`else
	wire [7:0]			core0_slv_awctl0code_i = {core0_slv_awuser,core0_slv_awcache,core0_slv_awprot};
	`endif
	wire [SLV_CTRL_CODE_WIDTH-1:0]	core0_slv_awctl0code_o;
	wire [13:0]			core0_slv_awctl1code_i = {core0_slv_awlock,core0_slv_awburst,core0_slv_awsize,core0_slv_awlen};
	wire [SLV_CTRL_CODE_WIDTH-1:0]	core0_slv_awctl1code_o;
	wire [SLVPORT_ID_WIDTH-1:0]	core0_slv_awidcode_i = core0_slv_awid[(SLVPORT_ID_WIDTH-1):0];
	wire [SLV_CTRL_CODE_WIDTH  :0]	core0_slv_awidcode_o; // only use [SLV_CTRL_CODE_WIDTH-1:0]
	wire [SLVPORT_WSTRB_WIDTH  :0]  core0_slv_wctlcode_i = {core0_slv_wlast, core0_slv_wstrb};
	wire [SLV_CTRL_CODE_WIDTH :0]	core0_slv_wctlcode_o; // only use [SLV_CTRL_CODE_WIDTH-1:0]
	kv_secded_enc #(.DW(ADDR_WIDTH)) u_core0_slv_araddrcode (.data(core0_slv_araddr), .parity(core0_slv_araddrcode));
	`ifdef NDS_IO_SLAVEPORT_QOS_X1
	kv_ded_enc #(.DW(12)) u_core0_slv_arctl0code (.data(core0_slv_arctl0code_i[11:0]), .parity(core0_slv_arctl0code_o[4:0]));
	`else
	kv_ded_enc #(.DW(8)) u_core0_slv_arctl0code (.data(core0_slv_arctl0code_i[7:0]), .parity(core0_slv_arctl0code_o[3:0]));
	assign core0_slv_arctl0code_o[4] = 1'b0;
	`endif
	kv_ded_enc #(.DW(14)) u_core0_slv_arctl1code (.data(core0_slv_arctl1code_i), .parity(core0_slv_arctl1code_o));
	kv_ded_enc #(.DW(SLVPORT_ID_WIDTH)) u_core0_slv_aridcode (.data(core0_slv_aridcode_i), .parity(core0_slv_aridcode_o[SLV_ID_CODE_WIDTH-1:0]));
	assign core0_slv_aridcode_o[SLV_CTRL_CODE_WIDTH:SLV_ID_CODE_WIDTH] = {(SLV_CTRL_CODE_WIDTH+1-SLV_ID_CODE_WIDTH){1'b0}};
	kv_secded_enc #(.DW(ADDR_WIDTH)) u_core0_slv_awaddrcode (.data(core0_slv_awaddr), .parity(core0_slv_awaddrcode));
	`ifdef NDS_IO_SLAVEPORT_QOS_X1
	kv_ded_enc #(.DW(12)) u_core0_slv_awctl0code (.data(core0_slv_awctl0code_i[11:0]), .parity(core0_slv_awctl0code_o[4:0]));
	`else
	kv_ded_enc #(.DW(8)) u_core0_slv_awctl0code (.data(core0_slv_awctl0code_i[7:0]), .parity(core0_slv_awctl0code_o[3:0]));
	assign core0_slv_awctl0code_o[4] = 1'b0;
	`endif
	kv_ded_enc #(.DW(14)) u_core0_slv_awctl1code (.data(core0_slv_awctl1code_i), .parity(core0_slv_awctl1code_o));
	kv_ded_enc #(.DW(SLVPORT_ID_WIDTH)) u_core0_slv_awidcode (.data(core0_slv_awidcode_i), .parity(core0_slv_awidcode_o[SLV_ID_CODE_WIDTH-1:0]));
	assign core0_slv_awidcode_o[SLV_CTRL_CODE_WIDTH:SLV_ID_CODE_WIDTH] = {(SLV_CTRL_CODE_WIDTH+1-SLV_ID_CODE_WIDTH){1'b0}};
	kv_ded_enc #(.DW(SLVPORT_WSTRB_WIDTH+1)) u_core0_slv_wctlcode (.data(core0_slv_wctlcode_i), .parity(core0_slv_wctlcode_o[SLV_WCTRL_CODE_WIDTH-1:0]));
	assign core0_slv_wctlcode_o[SLV_CTRL_CODE_WIDTH:SLV_WCTRL_CODE_WIDTH] = {(SLV_CTRL_CODE_WIDTH+1-SLV_WCTRL_CODE_WIDTH){1'b0}};
	generate
	genvar core0_slv_wdatacode_idx;
	for (core0_slv_wdatacode_idx = 0; core0_slv_wdatacode_idx < (SLVPORT_DATA_WIDTH/64); core0_slv_wdatacode_idx = core0_slv_wdatacode_idx + 1) begin: gen_core0_slv_wdatacode
		kv_secded_enc #(.DW(64)) u_core0_slv_wdatacode (.data(core0_slv_wdata[core0_slv_wdatacode_idx*64+:64]), .parity(core0_slv_wdatacode[core0_slv_wdatacode_idx*8+:8]));
	end
	endgenerate
	assign core0_slv_arctl0code  = core0_slv_arctl0code_o;
	assign core0_slv_arctl1code  = core0_slv_arctl1code_o;
	assign core0_slv_aridcode    = core0_slv_aridcode_o[SLV_CTRL_CODE_WIDTH-1:0];
	assign core0_slv_awctl0code  = core0_slv_awctl0code_o;
	assign core0_slv_awctl1code  = core0_slv_awctl1code_o;
	assign core0_slv_awidcode    = core0_slv_awidcode_o[SLV_CTRL_CODE_WIDTH-1:0];
	assign core0_slv_wctlcode    = core0_slv_wctlcode_o[SLV_CTRL_CODE_WIDTH-1:0];
	reg core0_slv_weobi_r;
	wire core0_slv_weobi_en;
	wire core0_slv_weobi_nx;
	always @ (posedge core0_slv_clk or negedge core0_slvp_reset_n) begin
		if (!core0_slvp_reset_n) begin
			core0_slv_weobi_r <= 1'b0;
		end
		else if (core0_slv_weobi_en) begin
			core0_slv_weobi_r <= core0_slv_weobi_nx;
		end
	end
	assign core0_slv_weobi_en = core0_slv_wvalid & core0_slv_wready;
	assign core0_slv_weobi_nx = ~core0_slv_wlast & ~core0_slv_weobi_r;
	assign core0_slv_weobi    = core0_slv_weobi_r;
	assign core0_slv_arvalidcode = ~core0_slv_arvalid;
	assign core0_slv_awvalidcode = ~core0_slv_awvalid;
	assign core0_slv_wvalidcode  = ~core0_slv_wvalid;
	assign core0_slv_breadycode  = ~core0_slv_bready;
	assign core0_slv_rreadycode  = ~core0_slv_rready;
	reg	[(SLV_UTID_WIDTH-1):0]	core0_slv_arutid_cnt;
	wire	[SLV_UTID_WIDTH:0]	core0_slv_arutid_cnt_incr1;
	assign core0_slv_arutid_cnt_incr1 = core0_slv_arutid_cnt + {{(SLV_UTID_WIDTH-1){1'b0}}, 1'b1};
	always @ (posedge core0_slv_clk or negedge core0_slvp_reset_n) begin
		if (!core0_slvp_reset_n)
			core0_slv_arutid_cnt <= {(SLV_UTID_WIDTH){1'b0}};
		else if (core0_slv_arvalid & core0_slv_arready)
			core0_slv_arutid_cnt <= core0_slv_arutid_cnt_incr1[(SLV_UTID_WIDTH-1):0];
	end
	assign core0_slv_arutid      = core0_slv_arutid_cnt;
	reg	[(SLV_UTID_WIDTH-1):0]	core0_slv_awutid_cnt;
	wire	[SLV_UTID_WIDTH:0]	core0_slv_awutid_cnt_incr1;
	assign core0_slv_awutid_cnt_incr1 = core0_slv_awutid_cnt + {{(SLV_UTID_WIDTH-1){1'b0}}, 1'b1};
	always @ (posedge core0_slv_clk or negedge core0_slvp_reset_n) begin
		if (!core0_slvp_reset_n)
			core0_slv_awutid_cnt <= {(SLV_UTID_WIDTH){1'b0}};
		else if (core0_slv_awvalid & core0_slv_awready)
			core0_slv_awutid_cnt <= core0_slv_awutid_cnt_incr1[(SLV_UTID_WIDTH-1):0];
	end
	assign core0_slv_awutid      = core0_slv_awutid_cnt;
	wire	core0_slv_wutid_wvalid = core0_slv_awvalid & core0_slv_awready;
	wire	nds_unused_core0_slv_wutid_wready;
	wire	nds_unused_core0_slv_wutid_rvalid;
	wire	core0_slv_wutid_rready = core0_slv_wvalid & core0_slv_wready & core0_slv_wlast;
	kv_fifo #(
		.DEPTH           (16),
		.RAR_SUPPORT     (`NDS_RAR_SUPPORT),
		.WIDTH           (SLV_UTID_WIDTH)
	) u_core0_slv_wutid (
		.clk    (core0_slv_clk),
		.reset_n(core0_slvp_reset_n),
		.flush	(1'b0),
		.wdata  (core0_slv_awutid),
		.wvalid (core0_slv_wutid_wvalid),
		.wready (nds_unused_core0_slv_wutid_wready),
		.rdata  (core0_slv_wutid),
		.rvalid (nds_unused_core0_slv_wutid_rvalid),
		.rready (core0_slv_wutid_rready)
	);
	wire nds_unused_core0_slv_ecc	=   core0_slv_arreadycode
					|   core0_slv_awreadycode
					| (|core0_slv_bctlcode)
					| (|core0_slv_bidcode)
					| (|core0_slv_butid)
					|   core0_slv_bvalidcode
					| (|core0_slv_rctlcode)
					| (|core0_slv_rdatacode)
					|   core0_slv_reobi
					| (|core0_slv_ridcode)
					| (|core0_slv_rutid)
					|   core0_slv_rvalidcode
					|   core0_slv_wreadycode
					;
      `endif // ATCBUSDEC302_SLV1_SUPPORT
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
      `ifdef ATCBUSDEC302_SLV2_SUPPORT
      assign core1_slv_arvalid =       slvp_busdec_ds2_arvalid;
      assign core1_slv_awvalid =       slvp_busdec_ds2_awvalid;
      assign core1_slv_wvalid  =       slvp_busdec_ds2_wvalid;
      assign core1_slv_bready  =       slvp_busdec_ds2_bready;
      assign core1_slv_rready  =       slvp_busdec_ds2_rready;

      assign slvp_busdec_ds2_arready = core1_slv_arready;
      assign slvp_busdec_ds2_awready = core1_slv_awready;
      assign slvp_busdec_ds2_wready  = core1_slv_wready;
      assign slvp_busdec_ds2_rvalid = core1_slv_rvalid;
      assign slvp_busdec_ds2_rlast  = core1_slv_rlast;
      assign slvp_busdec_ds2_rdata  = core1_slv_rdata;
      assign slvp_busdec_ds2_rresp  = core1_slv_rresp;
      assign slvp_busdec_ds2_bvalid = core1_slv_bvalid;
      assign slvp_busdec_ds2_bresp  = core1_slv_bresp;
      assign core1_slv_awaddr  =       busdec2slv_awaddr       ;
      assign core1_slv_awlen   =       busdec2slv_awlen        ;
      assign core1_slv_awsize  =       busdec2slv_awsize       ;
      assign core1_slv_awburst =       busdec2slv_awburst      ;
      assign core1_slv_awlock  =       busdec2slv_awlock       ;
      assign core1_slv_awcache =       busdec2slv_awcache      ;
      assign core1_slv_awprot  =       busdec2slv_awprot       ;
      assign core1_slv_wdata   =       busdec2slv_wdata        ;
      assign core1_slv_wstrb   =       busdec2slv_wstrb        ;
      assign core1_slv_wlast   =       busdec2slv_wlast        ;
      assign core1_slv_araddr  =       busdec2slv_araddr       ;
      assign core1_slv_arlen   =       busdec2slv_arlen        ;
      assign core1_slv_arsize  =       busdec2slv_arsize       ;
      assign core1_slv_arburst =       busdec2slv_arburst      ;
      assign core1_slv_arlock  =       busdec2slv_arlock       ;
      assign core1_slv_arcache =       busdec2slv_arcache      ;
      assign core1_slv_arprot  =       busdec2slv_arprot       ;
      assign core1_slv_awid    =       {(SLVPORT_ID_WIDTH){1'b0}}      ;
      assign core1_slv_arid    =       {(SLVPORT_ID_WIDTH){1'b0}}      ;
      `endif // ATCBUSDEC302_SLV2_SUPPORT
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
      `ifdef ATCBUSDEC302_SLV2_SUPPORT
	wire nds_unused_core1_fs_bus_s_protection_error = (|core1_fs_bus_s_protection_error);
	`ifdef NDS_IO_SLAVEPORT_QOS_X1
	wire [11:0]			core1_slv_arctl0code_i = {core1_slv_arqos,core1_slv_aruser,core1_slv_arcache,core1_slv_arprot};
	`else
	wire [7:0]			core1_slv_arctl0code_i = {core1_slv_aruser,core1_slv_arcache,core1_slv_arprot};
	`endif
	wire [SLV_CTRL_CODE_WIDTH-1:0]	core1_slv_arctl0code_o;
	wire [13:0]			core1_slv_arctl1code_i = {core1_slv_arlock,core1_slv_arburst,core1_slv_arsize,core1_slv_arlen};
	wire [SLV_CTRL_CODE_WIDTH-1:0]	core1_slv_arctl1code_o;
	wire [SLVPORT_ID_WIDTH-1:0]	core1_slv_aridcode_i = core1_slv_arid[(SLVPORT_ID_WIDTH-1):0];
	wire [SLV_CTRL_CODE_WIDTH  :0]	core1_slv_aridcode_o; // only use [SLV_CTRL_CODE_WIDTH-1:0]
	`ifdef NDS_IO_SLAVEPORT_QOS_X1
	wire [11:0]			core1_slv_awctl0code_i = {core1_slv_awqos,core1_slv_awuser,core1_slv_awcache,core1_slv_awprot};
	`else
	wire [7:0]			core1_slv_awctl0code_i = {core1_slv_awuser,core1_slv_awcache,core1_slv_awprot};
	`endif
	wire [SLV_CTRL_CODE_WIDTH-1:0]	core1_slv_awctl0code_o;
	wire [13:0]			core1_slv_awctl1code_i = {core1_slv_awlock,core1_slv_awburst,core1_slv_awsize,core1_slv_awlen};
	wire [SLV_CTRL_CODE_WIDTH-1:0]	core1_slv_awctl1code_o;
	wire [SLVPORT_ID_WIDTH-1:0]	core1_slv_awidcode_i = core1_slv_awid[(SLVPORT_ID_WIDTH-1):0];
	wire [SLV_CTRL_CODE_WIDTH  :0]	core1_slv_awidcode_o; // only use [SLV_CTRL_CODE_WIDTH-1:0]
	wire [SLVPORT_WSTRB_WIDTH  :0]  core1_slv_wctlcode_i = {core1_slv_wlast, core1_slv_wstrb};
	wire [SLV_CTRL_CODE_WIDTH :0]	core1_slv_wctlcode_o; // only use [SLV_CTRL_CODE_WIDTH-1:0]
	kv_secded_enc #(.DW(ADDR_WIDTH)) u_core1_slv_araddrcode (.data(core1_slv_araddr), .parity(core1_slv_araddrcode));
	`ifdef NDS_IO_SLAVEPORT_QOS_X1
	kv_ded_enc #(.DW(12)) u_core1_slv_arctl0code (.data(core1_slv_arctl0code_i[11:0]), .parity(core1_slv_arctl0code_o[4:0]));
	`else
	kv_ded_enc #(.DW(8)) u_core1_slv_arctl0code (.data(core1_slv_arctl0code_i[7:0]), .parity(core1_slv_arctl0code_o[3:0]));
	assign core1_slv_arctl0code_o[4] = 1'b0;
	`endif
	kv_ded_enc #(.DW(14)) u_core1_slv_arctl1code (.data(core1_slv_arctl1code_i), .parity(core1_slv_arctl1code_o));
	kv_ded_enc #(.DW(SLVPORT_ID_WIDTH)) u_core1_slv_aridcode (.data(core1_slv_aridcode_i), .parity(core1_slv_aridcode_o[SLV_ID_CODE_WIDTH-1:0]));
	assign core1_slv_aridcode_o[SLV_CTRL_CODE_WIDTH:SLV_ID_CODE_WIDTH] = {(SLV_CTRL_CODE_WIDTH+1-SLV_ID_CODE_WIDTH){1'b0}};
	kv_secded_enc #(.DW(ADDR_WIDTH)) u_core1_slv_awaddrcode (.data(core1_slv_awaddr), .parity(core1_slv_awaddrcode));
	`ifdef NDS_IO_SLAVEPORT_QOS_X1
	kv_ded_enc #(.DW(12)) u_core1_slv_awctl0code (.data(core1_slv_awctl0code_i[11:0]), .parity(core1_slv_awctl0code_o[4:0]));
	`else
	kv_ded_enc #(.DW(8)) u_core1_slv_awctl0code (.data(core1_slv_awctl0code_i[7:0]), .parity(core1_slv_awctl0code_o[3:0]));
	assign core1_slv_awctl0code_o[4] = 1'b0;
	`endif
	kv_ded_enc #(.DW(14)) u_core1_slv_awctl1code (.data(core1_slv_awctl1code_i), .parity(core1_slv_awctl1code_o));
	kv_ded_enc #(.DW(SLVPORT_ID_WIDTH)) u_core1_slv_awidcode (.data(core1_slv_awidcode_i), .parity(core1_slv_awidcode_o[SLV_ID_CODE_WIDTH-1:0]));
	assign core1_slv_awidcode_o[SLV_CTRL_CODE_WIDTH:SLV_ID_CODE_WIDTH] = {(SLV_CTRL_CODE_WIDTH+1-SLV_ID_CODE_WIDTH){1'b0}};
	kv_ded_enc #(.DW(SLVPORT_WSTRB_WIDTH+1)) u_core1_slv_wctlcode (.data(core1_slv_wctlcode_i), .parity(core1_slv_wctlcode_o[SLV_WCTRL_CODE_WIDTH-1:0]));
	assign core1_slv_wctlcode_o[SLV_CTRL_CODE_WIDTH:SLV_WCTRL_CODE_WIDTH] = {(SLV_CTRL_CODE_WIDTH+1-SLV_WCTRL_CODE_WIDTH){1'b0}};
	generate
	genvar core1_slv_wdatacode_idx;
	for (core1_slv_wdatacode_idx = 0; core1_slv_wdatacode_idx < (SLVPORT_DATA_WIDTH/64); core1_slv_wdatacode_idx = core1_slv_wdatacode_idx + 1) begin: gen_core1_slv_wdatacode
		kv_secded_enc #(.DW(64)) u_core1_slv_wdatacode (.data(core1_slv_wdata[core1_slv_wdatacode_idx*64+:64]), .parity(core1_slv_wdatacode[core1_slv_wdatacode_idx*8+:8]));
	end
	endgenerate
	assign core1_slv_arctl0code  = core1_slv_arctl0code_o;
	assign core1_slv_arctl1code  = core1_slv_arctl1code_o;
	assign core1_slv_aridcode    = core1_slv_aridcode_o[SLV_CTRL_CODE_WIDTH-1:0];
	assign core1_slv_awctl0code  = core1_slv_awctl0code_o;
	assign core1_slv_awctl1code  = core1_slv_awctl1code_o;
	assign core1_slv_awidcode    = core1_slv_awidcode_o[SLV_CTRL_CODE_WIDTH-1:0];
	assign core1_slv_wctlcode    = core1_slv_wctlcode_o[SLV_CTRL_CODE_WIDTH-1:0];
	reg core1_slv_weobi_r;
	wire core1_slv_weobi_en;
	wire core1_slv_weobi_nx;
	always @ (posedge core1_slv_clk or negedge core1_slvp_reset_n) begin
		if (!core1_slvp_reset_n) begin
			core1_slv_weobi_r <= 1'b0;
		end
		else if (core1_slv_weobi_en) begin
			core1_slv_weobi_r <= core1_slv_weobi_nx;
		end
	end
	assign core1_slv_weobi_en = core1_slv_wvalid & core1_slv_wready;
	assign core1_slv_weobi_nx = ~core1_slv_wlast & ~core1_slv_weobi_r;
	assign core1_slv_weobi    = core1_slv_weobi_r;
	assign core1_slv_arvalidcode = ~core1_slv_arvalid;
	assign core1_slv_awvalidcode = ~core1_slv_awvalid;
	assign core1_slv_wvalidcode  = ~core1_slv_wvalid;
	assign core1_slv_breadycode  = ~core1_slv_bready;
	assign core1_slv_rreadycode  = ~core1_slv_rready;
	reg	[(SLV_UTID_WIDTH-1):0]	core1_slv_arutid_cnt;
	wire	[SLV_UTID_WIDTH:0]	core1_slv_arutid_cnt_incr1;
	assign core1_slv_arutid_cnt_incr1 = core1_slv_arutid_cnt + {{(SLV_UTID_WIDTH-1){1'b0}}, 1'b1};
	always @ (posedge core1_slv_clk or negedge core1_slvp_reset_n) begin
		if (!core1_slvp_reset_n)
			core1_slv_arutid_cnt <= {(SLV_UTID_WIDTH){1'b0}};
		else if (core1_slv_arvalid & core1_slv_arready)
			core1_slv_arutid_cnt <= core1_slv_arutid_cnt_incr1[(SLV_UTID_WIDTH-1):0];
	end
	assign core1_slv_arutid      = core1_slv_arutid_cnt;
	reg	[(SLV_UTID_WIDTH-1):0]	core1_slv_awutid_cnt;
	wire	[SLV_UTID_WIDTH:0]	core1_slv_awutid_cnt_incr1;
	assign core1_slv_awutid_cnt_incr1 = core1_slv_awutid_cnt + {{(SLV_UTID_WIDTH-1){1'b0}}, 1'b1};
	always @ (posedge core1_slv_clk or negedge core1_slvp_reset_n) begin
		if (!core1_slvp_reset_n)
			core1_slv_awutid_cnt <= {(SLV_UTID_WIDTH){1'b0}};
		else if (core1_slv_awvalid & core1_slv_awready)
			core1_slv_awutid_cnt <= core1_slv_awutid_cnt_incr1[(SLV_UTID_WIDTH-1):0];
	end
	assign core1_slv_awutid      = core1_slv_awutid_cnt;
	wire	core1_slv_wutid_wvalid = core1_slv_awvalid & core1_slv_awready;
	wire	nds_unused_core1_slv_wutid_wready;
	wire	nds_unused_core1_slv_wutid_rvalid;
	wire	core1_slv_wutid_rready = core1_slv_wvalid & core1_slv_wready & core1_slv_wlast;
	kv_fifo #(
		.DEPTH           (16),
		.RAR_SUPPORT     (`NDS_RAR_SUPPORT),
		.WIDTH           (SLV_UTID_WIDTH)
	) u_core1_slv_wutid (
		.clk    (core1_slv_clk),
		.reset_n(core1_slvp_reset_n),
		.flush	(1'b0),
		.wdata  (core1_slv_awutid),
		.wvalid (core1_slv_wutid_wvalid),
		.wready (nds_unused_core1_slv_wutid_wready),
		.rdata  (core1_slv_wutid),
		.rvalid (nds_unused_core1_slv_wutid_rvalid),
		.rready (core1_slv_wutid_rready)
	);
	wire nds_unused_core1_slv_ecc	=   core1_slv_arreadycode
					|   core1_slv_awreadycode
					| (|core1_slv_bctlcode)
					| (|core1_slv_bidcode)
					| (|core1_slv_butid)
					|   core1_slv_bvalidcode
					| (|core1_slv_rctlcode)
					| (|core1_slv_rdatacode)
					|   core1_slv_reobi
					| (|core1_slv_ridcode)
					| (|core1_slv_rutid)
					|   core1_slv_rvalidcode
					|   core1_slv_wreadycode
					;
      `endif // ATCBUSDEC302_SLV2_SUPPORT
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef ATCBMC301_MST1_SUPPORT
`ifdef NDS_IO_FLASHIF0
`ifdef NDS_IO_BUS_PROTECTION
generate
if (FLASHIF0_ID_WIDTH > BIU_ID_WIDTH) begin : gen_id_flash_gt_biu
       assign axi_flash0_arid = axi_flash0_arid_out[BIU_ID_WIDTH-1:0];
       assign axi_flash0_awid = axi_flash0_awid_out[BIU_ID_WIDTH-1:0];
	   assign axi_flash0_rid_in = {{(FLASHIF0_ID_WIDTH-BIU_ID_WIDTH){1'b0}}, axi_flash0_rid};
	   assign axi_flash0_bid_in = {{(FLASHIF0_ID_WIDTH-BIU_ID_WIDTH){1'b0}}, axi_flash0_bid};
end
else if (FLASHIF0_ID_WIDTH == BIU_ID_WIDTH) begin : gen_id_flash_eq_biu
       assign axi_flash0_arid = axi_flash0_arid_out;
       assign axi_flash0_awid = axi_flash0_awid_out;
	   assign axi_flash0_rid_in = axi_flash0_rid;
	   assign axi_flash0_bid_in = axi_flash0_bid;
end
else begin : gen_id_flash_lt_biu
       assign axi_flash0_arid = {{(BIU_ID_WIDTH-FLASHIF0_ID_WIDTH){1'b0}}, axi_flash0_arid_out};
       assign axi_flash0_awid = {{(BIU_ID_WIDTH-FLASHIF0_ID_WIDTH){1'b0}}, axi_flash0_awid_out};
       assign axi_flash0_rid_in = axi_flash0_rid[FLASHIF0_ID_WIDTH-1:0];
       assign axi_flash0_bid_in = axi_flash0_bid[FLASHIF0_ID_WIDTH-1:0];
end
endgenerate
`endif // NDS_IO_BUS_PROTECTION
`ifndef NDS_IO_BUS_PROTECTION
generate
if (FLASHIF0_ID_WIDTH > BIU_ID_WIDTH) begin : gen_id_flash_gt_biu
       assign axi_flash0_arid = cluster_flash0_arid[BIU_ID_WIDTH-1:0];
       assign axi_flash0_awid = cluster_flash0_awid[BIU_ID_WIDTH-1:0];
	   assign cluster_flash0_rid = {{(FLASHIF0_ID_WIDTH-BIU_ID_WIDTH){1'b0}}, axi_flash0_rid};
	   assign cluster_flash0_bid = {{(FLASHIF0_ID_WIDTH-BIU_ID_WIDTH){1'b0}}, axi_flash0_bid};
end
else if (FLASHIF0_ID_WIDTH == BIU_ID_WIDTH) begin : gen_id_flash_eq_biu
       assign axi_flash0_arid = cluster_flash0_arid;
       assign axi_flash0_awid = cluster_flash0_awid;
	   assign cluster_flash0_rid = axi_flash0_rid;
	   assign cluster_flash0_bid = axi_flash0_bid;
end
else begin : gen_id_flash_lt_biu
       assign axi_flash0_arid = {{(BIU_ID_WIDTH-FLASHIF0_ID_WIDTH){1'b0}}, cluster_flash0_arid};
       assign axi_flash0_awid = {{(BIU_ID_WIDTH-FLASHIF0_ID_WIDTH){1'b0}}, cluster_flash0_awid};
       assign cluster_flash0_rid = axi_flash0_rid[FLASHIF0_ID_WIDTH-1:0];
       assign cluster_flash0_bid = axi_flash0_bid[FLASHIF0_ID_WIDTH-1:0];
end
endgenerate
`endif // NDS_IO_BUS_PROTECTION
`endif // NDS_IO_FLASHIF0
`endif // ATCBMC301_MST1_SUPPORT
`ifdef ATCBMC301_MST1_SUPPORT
`ifdef NDS_IO_FLASHIF0
`ifndef NDS_IO_BUS_PROTECTION
assign cluster_flash0_arready = axi_flash0_arready;
assign axi_flash0_arvalid = cluster_flash0_arvalid;
assign axi_flash0_araddr  = cluster_flash0_araddr;
assign axi_flash0_arburst = cluster_flash0_arburst;
assign axi_flash0_arcache = cluster_flash0_arcache;
assign axi_flash0_arlen   = cluster_flash0_arlen;
assign axi_flash0_arlock  = cluster_flash0_arlock;
assign axi_flash0_arprot  = cluster_flash0_arprot;
assign axi_flash0_arsize  = cluster_flash0_arsize;

assign cluster_flash0_awready = axi_flash0_awready;
assign axi_flash0_awvalid = cluster_flash0_awvalid;
assign axi_flash0_awaddr  = cluster_flash0_awaddr;
assign axi_flash0_awburst = cluster_flash0_awburst;
assign axi_flash0_awcache = cluster_flash0_awcache;
assign axi_flash0_awlen   = cluster_flash0_awlen;
assign axi_flash0_awlock  = cluster_flash0_awlock;
assign axi_flash0_awprot  = cluster_flash0_awprot;
assign axi_flash0_awsize  = cluster_flash0_awsize;

assign cluster_flash0_wready  = axi_flash0_wready;
assign axi_flash0_wdata  = cluster_flash0_wdata;
assign axi_flash0_wlast  = cluster_flash0_wlast;
assign axi_flash0_wstrb  = cluster_flash0_wstrb;
assign axi_flash0_wvalid = cluster_flash0_wvalid;

assign axi_flash0_bready = cluster_flash0_bready;
assign cluster_flash0_bresp  = axi_flash0_bresp;
assign cluster_flash0_bvalid = axi_flash0_bvalid;

assign axi_flash0_rready = cluster_flash0_rready;
assign cluster_flash0_rdata  = axi_flash0_rdata;
assign cluster_flash0_rlast  = axi_flash0_rlast;
assign cluster_flash0_rresp  = axi_flash0_rresp;
assign cluster_flash0_rvalid = axi_flash0_rvalid;
`endif
`endif
`endif
`ifndef NDS_IO_BUS_PROTECTION
assign cluster_sys0_arready = axi_sys0_arready;
assign axi_sys0_arvalid = cluster_sys0_arvalid;
assign axi_sys0_araddr  = cluster_sys0_araddr;
assign axi_sys0_arburst = cluster_sys0_arburst;
assign axi_sys0_arcache = cluster_sys0_arcache;
assign axi_sys0_arid    = cluster_sys0_arid;
assign axi_sys0_arlen   = cluster_sys0_arlen;
assign axi_sys0_arlock  = cluster_sys0_arlock;
assign axi_sys0_arprot  = cluster_sys0_arprot;
assign axi_sys0_arsize  = cluster_sys0_arsize;

assign cluster_sys0_awready = axi_sys0_awready;
assign axi_sys0_awvalid = cluster_sys0_awvalid;
assign axi_sys0_awaddr  = cluster_sys0_awaddr;
assign axi_sys0_awburst = cluster_sys0_awburst;
assign axi_sys0_awcache = cluster_sys0_awcache;
assign axi_sys0_awid    = cluster_sys0_awid;
assign axi_sys0_awlen   = cluster_sys0_awlen;
assign axi_sys0_awlock  = cluster_sys0_awlock;
assign axi_sys0_awprot  = cluster_sys0_awprot;
assign axi_sys0_awsize  = cluster_sys0_awsize;

assign cluster_sys0_wready  = axi_sys0_wready;
assign axi_sys0_wdata  = cluster_sys0_wdata;
assign axi_sys0_wlast  = cluster_sys0_wlast;
assign axi_sys0_wstrb  = cluster_sys0_wstrb;
assign axi_sys0_wvalid = cluster_sys0_wvalid;

assign axi_sys0_bready = cluster_sys0_bready;
assign cluster_sys0_bid    = axi_sys0_bid;
assign cluster_sys0_bresp  = axi_sys0_bresp;
assign cluster_sys0_bvalid = axi_sys0_bvalid;

assign axi_sys0_rready = cluster_sys0_rready;
assign cluster_sys0_rid    = axi_sys0_rid;
assign cluster_sys0_rdata  = axi_sys0_rdata;
assign cluster_sys0_rlast  = axi_sys0_rlast;
assign cluster_sys0_rresp  = axi_sys0_rresp;
assign cluster_sys0_rvalid = axi_sys0_rvalid;
`endif
`ifdef NDS_IO_SPP
`ifndef NDS_IO_BUS_PROTECTION
assign spp_arready = axi_spp_arready;
assign axi_spp_arvalid = spp_arvalid;
assign axi_spp_araddr  = spp_araddr;
assign axi_spp_arburst = spp_arburst;
assign axi_spp_arcache = spp_arcache;
assign axi_spp_arid    = spp_arid;
assign axi_spp_arlen   = spp_arlen;
assign axi_spp_arlock  = spp_arlock;
assign axi_spp_arprot  = spp_arprot;
assign axi_spp_arsize  = spp_arsize;

assign spp_awready = axi_spp_awready;
assign axi_spp_awvalid = spp_awvalid;
assign axi_spp_awaddr  = spp_awaddr;
assign axi_spp_awburst = spp_awburst;
assign axi_spp_awcache = spp_awcache;
assign axi_spp_awid    = spp_awid;
assign axi_spp_awlen   = spp_awlen;
assign axi_spp_awlock  = spp_awlock;
assign axi_spp_awprot  = spp_awprot;
assign axi_spp_awsize  = spp_awsize;

assign spp_wready  = axi_spp_wready;
assign axi_spp_wdata  = spp_wdata;
assign axi_spp_wlast  = spp_wlast;
assign axi_spp_wstrb  = spp_wstrb;
assign axi_spp_wvalid = spp_wvalid;

assign axi_spp_bready = spp_bready;
assign spp_bid    = axi_spp_bid;
assign spp_bresp  = axi_spp_bresp;
assign spp_bvalid = axi_spp_bvalid;

assign axi_spp_rready = spp_rready;
assign spp_rid    = axi_spp_rid;
assign spp_rdata  = axi_spp_rdata;
assign spp_rlast  = axi_spp_rlast;
assign spp_rresp  = axi_spp_rresp;
assign spp_rvalid = axi_spp_rvalid;
`endif
`endif
`ifdef PLATFORM_DEBUG_SUBSYSTEM
      generate
      if (BIU_DATA_WIDTH > DM_SYS_DATA_WIDTH) begin : gen_connect_axi_dm_sup
              assign dm_sys_araddr          = dm_sup_araddr;
              assign dm_sys_arburst         = dm_sup_arburst;
              assign dm_sys_arcache         = dm_sup_arcache;
              assign dm_sys_arid            = {BIU_ID_WIDTH{1'b0}};
              assign dm_sys_arlen           = dm_sup_arlen;
              assign dm_sys_arlock          = dm_sup_arlock;
              assign dm_sys_arprot          = dm_sup_arprot;
              assign dm_sys_arsize          = dm_sup_arsize;

              assign dm_sys_awaddr          = dm_sup_awaddr;
              assign dm_sys_awburst         = dm_sup_awburst;
              assign dm_sys_awcache         = dm_sup_awcache;
              assign dm_sys_awid            = {BIU_ID_WIDTH{1'b0}};
              assign dm_sys_awlen           = dm_sup_awlen;
              assign dm_sys_awlock          = dm_sup_awlock;
              assign dm_sys_awprot          = dm_sup_awprot;
              assign dm_sys_awsize          = dm_sup_awsize;

              assign dm_sup_bresp           = dm_sys_bresp;
      end
      else begin : gen_connect_axi_dm
              assign dm_sup_arready         = dm_sys_arready;
              assign dm_sup_awready         = dm_sys_awready;
              assign dm_sup_rvalid          = dm_sys_rvalid;
              assign dm_sup_rdata           = dm_sys_rdata;
              assign dm_sup_rid             = dm_sys_rid;
              assign dm_sup_rlast           = dm_sys_rlast;
              assign dm_sup_rresp           = dm_sys_rresp;
              assign dm_sup_wready          = dm_sys_wready;
              assign dm_sup_bvalid          = dm_sys_bvalid;
              assign dm_sup_bid             = dm_sys_bid;
              assign dm_sup_bresp           = dm_sys_bresp;

              assign dm_sys_araddr          = dm_sup_araddr;
              assign dm_sys_arburst         = dm_sup_arburst;
              assign dm_sys_arcache         = dm_sup_arcache;
              assign dm_sys_arid            = dm_sup_arid;
              assign dm_sys_arlen           = dm_sup_arlen;
              assign dm_sys_arlock          = dm_sup_arlock;
              assign dm_sys_arprot          = dm_sup_arprot;
              assign dm_sys_arsize          = dm_sup_arsize;
              assign dm_sys_arvalid         = dm_sup_arvalid;

              assign dm_sys_awaddr          = dm_sup_awaddr;
              assign dm_sys_awburst         = dm_sup_awburst;
              assign dm_sys_awcache         = dm_sup_awcache;
              assign dm_sys_awid            = dm_sup_awid;
              assign dm_sys_awlen           = dm_sup_awlen;
              assign dm_sys_awlock          = dm_sup_awlock;
              assign dm_sys_awprot          = dm_sup_awprot;
              assign dm_sys_awsize          = dm_sup_awsize;
              assign dm_sys_awvalid         = dm_sup_awvalid;

              assign dm_sys_rready          = dm_sup_rready;
              assign dm_sys_wdata           = dm_sup_wdata;
              assign dm_sys_wlast           = dm_sup_wlast;
              assign dm_sys_wstrb           = dm_sup_wstrb;
              assign dm_sys_wvalid          = dm_sup_wvalid;
              assign dm_sys_bready          = dm_sup_bready;
      end
      endgenerate
      `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
      `else
              // force assign constant if no system debug access support
              assign dm_sys_arready   = 1'b1;
              assign dm_sys_awready   = 1'b1;
              assign dm_sys_rvalid    = 1'b0;
              assign dm_sys_rdata     = {BIU_DATA_WIDTH{1'b0}};
              assign dm_sys_rid       = {BIU_ID_WIDTH{1'b0}};
              assign dm_sys_rlast     = 1'b0;
              assign dm_sys_rresp     = 2'b0;
              assign dm_sys_wready    = 1'b1;
              assign dm_sys_bvalid    = 1'b0;
              assign dm_sys_bid       = {BIU_ID_WIDTH{1'b0}};
              assign dm_sys_bresp     = 2'b0;
      `endif
`endif

`ifdef PLATFORM_DEBUG_SUBSYSTEM
`else  // PLATFORM_DEBUG_SUBSYSTEM
   assign dm_debugint     = {NHART{1'b0}};
   assign dm_resethaltreq = {NHART{1'b0}};
`endif // PLATFORM_DEBUG_SUBSYSTEM

`ifdef PLATFORM_DEBUG_SUBSYSTEM
   assign dbg_srst_req = ndmreset;
`else // PLATFORM_DEBUG_SUBSYSTEM
   assign dbg_srst_req = 1'b0;
`endif // PLATFORM_DEBUG_SUBSYSTEM

`ifdef PLATFORM_NO_PLIC_SW
   assign hart0_msip = 1'b0;
   assign hart1_msip = 1'b0;
`endif      // PLATFORM_NO_PLIC_SW
`ifdef NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
assign core0_ppi_ingress_us_araddr = core0_ppi_araddr;
assign core0_ppi_ingress_us_arburst = core0_ppi_arburst;
assign core0_ppi_ingress_us_arcache = core0_ppi_arcache;
assign core0_ppi_ingress_us_arid = core0_ppi_arid;
assign core0_ppi_ingress_us_arlen = core0_ppi_arlen;
assign core0_ppi_ingress_us_arlock = core0_ppi_arlock;
assign core0_ppi_ingress_us_arprot = core0_ppi_arprot;
assign core0_ppi_ingress_us_arsize = core0_ppi_arsize;
assign core0_ppi_ingress_us_arvalid = core0_ppi_arvalid;
assign core0_ppi_ingress_us_awaddr = core0_ppi_awaddr;
assign core0_ppi_ingress_us_awburst = core0_ppi_awburst;
assign core0_ppi_ingress_us_awcache = core0_ppi_awcache;
assign core0_ppi_ingress_us_awid = core0_ppi_awid;
assign core0_ppi_ingress_us_awlen = core0_ppi_awlen;
assign core0_ppi_ingress_us_awlock = core0_ppi_awlock;
assign core0_ppi_ingress_us_awprot = core0_ppi_awprot;
assign core0_ppi_ingress_us_awsize = core0_ppi_awsize;
assign core0_ppi_ingress_us_awvalid = core0_ppi_awvalid;
assign core0_ppi_ingress_us_wdata = core0_ppi_wdata;
assign core0_ppi_ingress_us_wlast = core0_ppi_wlast;
assign core0_ppi_ingress_us_wstrb = core0_ppi_wstrb;
assign core0_ppi_ingress_us_wvalid = core0_ppi_wvalid;
assign core0_ppi_ingress_us_bready = core0_ppi_bready;
assign core0_ppi_ingress_us_rready = core0_ppi_rready;
assign core0_ppi_arready = core0_ppi_ingress_us_arready;
assign core0_ppi_awready = core0_ppi_ingress_us_awready;
assign core0_ppi_wready = core0_ppi_ingress_us_wready;
assign core0_ppi_bid = core0_ppi_ingress_us_bid;
assign core0_ppi_bresp = core0_ppi_ingress_us_bresp;
assign core0_ppi_bvalid = core0_ppi_ingress_us_bvalid;
assign core0_ppi_rdata = core0_ppi_ingress_us_rdata;
assign core0_ppi_rid = core0_ppi_ingress_us_rid;
assign core0_ppi_rlast = core0_ppi_ingress_us_rlast;
assign core0_ppi_rresp = core0_ppi_ingress_us_rresp;
assign core0_ppi_rvalid = core0_ppi_ingress_us_rvalid;
assign core0_axi_rf_araddr = core0_ppi_ingress_ds_araddr;
assign core0_axi_rf_arburst = core0_ppi_ingress_ds_arburst;
assign core0_axi_rf_arcache = core0_ppi_ingress_ds_arcache;
assign core0_axi_rf_arid = core0_ppi_ingress_ds_arid;
assign core0_axi_rf_arlen = core0_ppi_ingress_ds_arlen;
assign core0_axi_rf_arlock = core0_ppi_ingress_ds_arlock;
assign core0_axi_rf_arprot = core0_ppi_ingress_ds_arprot;
assign core0_axi_rf_arsize = core0_ppi_ingress_ds_arsize;
assign core0_axi_rf_arvalid = core0_ppi_ingress_ds_arvalid;
assign core0_axi_rf_awaddr = core0_ppi_ingress_ds_awaddr;
assign core0_axi_rf_awburst = core0_ppi_ingress_ds_awburst;
assign core0_axi_rf_awcache = core0_ppi_ingress_ds_awcache;
assign core0_axi_rf_awid = core0_ppi_ingress_ds_awid;
assign core0_axi_rf_awlen = core0_ppi_ingress_ds_awlen;
assign core0_axi_rf_awlock = core0_ppi_ingress_ds_awlock;
assign core0_axi_rf_awprot = core0_ppi_ingress_ds_awprot;
assign core0_axi_rf_awsize = core0_ppi_ingress_ds_awsize;
assign core0_axi_rf_awvalid = core0_ppi_ingress_ds_awvalid;
assign core0_axi_rf_wdata = core0_ppi_ingress_ds_wdata;
assign core0_axi_rf_wlast = core0_ppi_ingress_ds_wlast;
assign core0_axi_rf_wstrb = core0_ppi_ingress_ds_wstrb;
assign core0_axi_rf_wvalid = core0_ppi_ingress_ds_wvalid;
assign core0_axi_rf_bready = core0_ppi_ingress_ds_bready;
assign core0_axi_rf_rready = core0_ppi_ingress_ds_rready;
assign core0_ppi_ingress_ds_arready = core0_axi_rf_arready;
assign core0_ppi_ingress_ds_awready = core0_axi_rf_awready;
assign core0_ppi_ingress_ds_wready = core0_axi_rf_wready;
assign core0_ppi_ingress_ds_bid = core0_axi_rf_bid;
assign core0_ppi_ingress_ds_bresp = core0_axi_rf_bresp;
assign core0_ppi_ingress_ds_bvalid = core0_axi_rf_bvalid;
assign core0_ppi_ingress_ds_rdata = core0_axi_rf_rdata;
assign core0_ppi_ingress_ds_rid = core0_axi_rf_rid;
assign core0_ppi_ingress_ds_rlast = core0_axi_rf_rlast;
assign core0_ppi_ingress_ds_rresp = core0_axi_rf_rresp;
assign core0_ppi_ingress_ds_rvalid = core0_axi_rf_rvalid;
assign core0_ppi_ingress_us_araddrcode = core0_ppi_araddrcode;
assign core0_ppi_ingress_us_arctl0code = core0_ppi_arctl0code;
assign core0_ppi_ingress_us_arctl1code = core0_ppi_arctl1code;
assign core0_ppi_ingress_us_aridcode = core0_ppi_aridcode;
assign core0_ppi_ingress_us_arutid = core0_ppi_arutid;
assign core0_ppi_ingress_us_arvalidcode = core0_ppi_arvalidcode;
assign core0_ppi_ingress_us_awaddrcode = core0_ppi_awaddrcode;
assign core0_ppi_ingress_us_awctl0code = core0_ppi_awctl0code;
assign core0_ppi_ingress_us_awctl1code = core0_ppi_awctl1code;
assign core0_ppi_ingress_us_awidcode = core0_ppi_awidcode;
assign core0_ppi_ingress_us_awutid = core0_ppi_awutid;
assign core0_ppi_ingress_us_awvalidcode = core0_ppi_awvalidcode;
assign core0_ppi_ingress_us_wctlcode = core0_ppi_wctlcode;
assign core0_ppi_ingress_us_wdatacode = core0_ppi_wdatacode;
assign core0_ppi_ingress_us_weobi = core0_ppi_weobi;
assign core0_ppi_ingress_us_wutid = core0_ppi_wutid;
assign core0_ppi_ingress_us_wvalidcode = core0_ppi_wvalidcode;
assign core0_ppi_ingress_us_breadycode = core0_ppi_breadycode;
assign core0_ppi_ingress_us_rreadycode = core0_ppi_rreadycode;
assign core0_ppi_arreadycode = core0_ppi_ingress_us_arreadycode;
assign core0_ppi_awreadycode = core0_ppi_ingress_us_awreadycode;
assign core0_ppi_wreadycode = core0_ppi_ingress_us_wreadycode;
assign core0_ppi_bctlcode = core0_ppi_ingress_us_bctlcode;
assign core0_ppi_bidcode = core0_ppi_ingress_us_bidcode;
assign core0_ppi_butid = core0_ppi_ingress_us_butid;
assign core0_ppi_bvalidcode = core0_ppi_ingress_us_bvalidcode;
assign core0_ppi_rdatacode = core0_ppi_ingress_us_rdatacode;
assign core0_ppi_ridcode = core0_ppi_ingress_us_ridcode;
assign core0_ppi_rctlcode = core0_ppi_ingress_us_rctlcode;
assign core0_ppi_reobi = core0_ppi_ingress_us_reobi;
assign core0_ppi_rutid = core0_ppi_ingress_us_rutid;
assign core0_ppi_rvalidcode = core0_ppi_ingress_us_rvalidcode;
`else // NDS_IO_PPI_PROT
assign core0_axi_rf_araddr = core0_ppi_araddr;
assign core0_axi_rf_arburst = core0_ppi_arburst;
assign core0_axi_rf_arcache = core0_ppi_arcache;
assign core0_axi_rf_arid = core0_ppi_arid;
assign core0_axi_rf_arlen = core0_ppi_arlen;
assign core0_axi_rf_arlock = core0_ppi_arlock;
assign core0_axi_rf_arprot = core0_ppi_arprot;
assign core0_axi_rf_arsize = core0_ppi_arsize;
assign core0_axi_rf_arvalid = core0_ppi_arvalid;
assign core0_axi_rf_awaddr = core0_ppi_awaddr;
assign core0_axi_rf_awburst = core0_ppi_awburst;
assign core0_axi_rf_awcache = core0_ppi_awcache;
assign core0_axi_rf_awid = core0_ppi_awid;
assign core0_axi_rf_awlen = core0_ppi_awlen;
assign core0_axi_rf_awlock = core0_ppi_awlock;
assign core0_axi_rf_awprot = core0_ppi_awprot;
assign core0_axi_rf_awsize = core0_ppi_awsize;
assign core0_axi_rf_awvalid = core0_ppi_awvalid;
assign core0_axi_rf_wdata = core0_ppi_wdata;
assign core0_axi_rf_wlast = core0_ppi_wlast;
assign core0_axi_rf_wstrb = core0_ppi_wstrb;
assign core0_axi_rf_wvalid = core0_ppi_wvalid;
assign core0_axi_rf_bready = core0_ppi_bready;
assign core0_axi_rf_rready = core0_ppi_rready;
assign core0_ppi_arready = core0_axi_rf_arready;
assign core0_ppi_awready = core0_axi_rf_awready;
assign core0_ppi_wready = core0_axi_rf_wready;
assign core0_ppi_bid = core0_axi_rf_bid;
assign core0_ppi_bresp = core0_axi_rf_bresp;
assign core0_ppi_bvalid = core0_axi_rf_bvalid;
assign core0_ppi_rdata = core0_axi_rf_rdata;
assign core0_ppi_rid = core0_axi_rf_rid;
assign core0_ppi_rlast = core0_axi_rf_rlast;
assign core0_ppi_rresp = core0_axi_rf_rresp;
assign core0_ppi_rvalid = core0_axi_rf_rvalid;
`endif // NDS_IO_PPI_PROT
`endif // NDS_IO_PPI
`ifdef NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
assign core1_ppi_ingress_us_araddr = core1_ppi_araddr;
assign core1_ppi_ingress_us_arburst = core1_ppi_arburst;
assign core1_ppi_ingress_us_arcache = core1_ppi_arcache;
assign core1_ppi_ingress_us_arid = core1_ppi_arid;
assign core1_ppi_ingress_us_arlen = core1_ppi_arlen;
assign core1_ppi_ingress_us_arlock = core1_ppi_arlock;
assign core1_ppi_ingress_us_arprot = core1_ppi_arprot;
assign core1_ppi_ingress_us_arsize = core1_ppi_arsize;
assign core1_ppi_ingress_us_arvalid = core1_ppi_arvalid;
assign core1_ppi_ingress_us_awaddr = core1_ppi_awaddr;
assign core1_ppi_ingress_us_awburst = core1_ppi_awburst;
assign core1_ppi_ingress_us_awcache = core1_ppi_awcache;
assign core1_ppi_ingress_us_awid = core1_ppi_awid;
assign core1_ppi_ingress_us_awlen = core1_ppi_awlen;
assign core1_ppi_ingress_us_awlock = core1_ppi_awlock;
assign core1_ppi_ingress_us_awprot = core1_ppi_awprot;
assign core1_ppi_ingress_us_awsize = core1_ppi_awsize;
assign core1_ppi_ingress_us_awvalid = core1_ppi_awvalid;
assign core1_ppi_ingress_us_wdata = core1_ppi_wdata;
assign core1_ppi_ingress_us_wlast = core1_ppi_wlast;
assign core1_ppi_ingress_us_wstrb = core1_ppi_wstrb;
assign core1_ppi_ingress_us_wvalid = core1_ppi_wvalid;
assign core1_ppi_ingress_us_bready = core1_ppi_bready;
assign core1_ppi_ingress_us_rready = core1_ppi_rready;
assign core1_ppi_arready = core1_ppi_ingress_us_arready;
assign core1_ppi_awready = core1_ppi_ingress_us_awready;
assign core1_ppi_wready = core1_ppi_ingress_us_wready;
assign core1_ppi_bid = core1_ppi_ingress_us_bid;
assign core1_ppi_bresp = core1_ppi_ingress_us_bresp;
assign core1_ppi_bvalid = core1_ppi_ingress_us_bvalid;
assign core1_ppi_rdata = core1_ppi_ingress_us_rdata;
assign core1_ppi_rid = core1_ppi_ingress_us_rid;
assign core1_ppi_rlast = core1_ppi_ingress_us_rlast;
assign core1_ppi_rresp = core1_ppi_ingress_us_rresp;
assign core1_ppi_rvalid = core1_ppi_ingress_us_rvalid;
assign core1_axi_rf_araddr = core1_ppi_ingress_ds_araddr;
assign core1_axi_rf_arburst = core1_ppi_ingress_ds_arburst;
assign core1_axi_rf_arcache = core1_ppi_ingress_ds_arcache;
assign core1_axi_rf_arid = core1_ppi_ingress_ds_arid;
assign core1_axi_rf_arlen = core1_ppi_ingress_ds_arlen;
assign core1_axi_rf_arlock = core1_ppi_ingress_ds_arlock;
assign core1_axi_rf_arprot = core1_ppi_ingress_ds_arprot;
assign core1_axi_rf_arsize = core1_ppi_ingress_ds_arsize;
assign core1_axi_rf_arvalid = core1_ppi_ingress_ds_arvalid;
assign core1_axi_rf_awaddr = core1_ppi_ingress_ds_awaddr;
assign core1_axi_rf_awburst = core1_ppi_ingress_ds_awburst;
assign core1_axi_rf_awcache = core1_ppi_ingress_ds_awcache;
assign core1_axi_rf_awid = core1_ppi_ingress_ds_awid;
assign core1_axi_rf_awlen = core1_ppi_ingress_ds_awlen;
assign core1_axi_rf_awlock = core1_ppi_ingress_ds_awlock;
assign core1_axi_rf_awprot = core1_ppi_ingress_ds_awprot;
assign core1_axi_rf_awsize = core1_ppi_ingress_ds_awsize;
assign core1_axi_rf_awvalid = core1_ppi_ingress_ds_awvalid;
assign core1_axi_rf_wdata = core1_ppi_ingress_ds_wdata;
assign core1_axi_rf_wlast = core1_ppi_ingress_ds_wlast;
assign core1_axi_rf_wstrb = core1_ppi_ingress_ds_wstrb;
assign core1_axi_rf_wvalid = core1_ppi_ingress_ds_wvalid;
assign core1_axi_rf_bready = core1_ppi_ingress_ds_bready;
assign core1_axi_rf_rready = core1_ppi_ingress_ds_rready;
assign core1_ppi_ingress_ds_arready = core1_axi_rf_arready;
assign core1_ppi_ingress_ds_awready = core1_axi_rf_awready;
assign core1_ppi_ingress_ds_wready = core1_axi_rf_wready;
assign core1_ppi_ingress_ds_bid = core1_axi_rf_bid;
assign core1_ppi_ingress_ds_bresp = core1_axi_rf_bresp;
assign core1_ppi_ingress_ds_bvalid = core1_axi_rf_bvalid;
assign core1_ppi_ingress_ds_rdata = core1_axi_rf_rdata;
assign core1_ppi_ingress_ds_rid = core1_axi_rf_rid;
assign core1_ppi_ingress_ds_rlast = core1_axi_rf_rlast;
assign core1_ppi_ingress_ds_rresp = core1_axi_rf_rresp;
assign core1_ppi_ingress_ds_rvalid = core1_axi_rf_rvalid;
assign core1_ppi_ingress_us_araddrcode = core1_ppi_araddrcode;
assign core1_ppi_ingress_us_arctl0code = core1_ppi_arctl0code;
assign core1_ppi_ingress_us_arctl1code = core1_ppi_arctl1code;
assign core1_ppi_ingress_us_aridcode = core1_ppi_aridcode;
assign core1_ppi_ingress_us_arutid = core1_ppi_arutid;
assign core1_ppi_ingress_us_arvalidcode = core1_ppi_arvalidcode;
assign core1_ppi_ingress_us_awaddrcode = core1_ppi_awaddrcode;
assign core1_ppi_ingress_us_awctl0code = core1_ppi_awctl0code;
assign core1_ppi_ingress_us_awctl1code = core1_ppi_awctl1code;
assign core1_ppi_ingress_us_awidcode = core1_ppi_awidcode;
assign core1_ppi_ingress_us_awutid = core1_ppi_awutid;
assign core1_ppi_ingress_us_awvalidcode = core1_ppi_awvalidcode;
assign core1_ppi_ingress_us_wctlcode = core1_ppi_wctlcode;
assign core1_ppi_ingress_us_wdatacode = core1_ppi_wdatacode;
assign core1_ppi_ingress_us_weobi = core1_ppi_weobi;
assign core1_ppi_ingress_us_wutid = core1_ppi_wutid;
assign core1_ppi_ingress_us_wvalidcode = core1_ppi_wvalidcode;
assign core1_ppi_ingress_us_breadycode = core1_ppi_breadycode;
assign core1_ppi_ingress_us_rreadycode = core1_ppi_rreadycode;
assign core1_ppi_arreadycode = core1_ppi_ingress_us_arreadycode;
assign core1_ppi_awreadycode = core1_ppi_ingress_us_awreadycode;
assign core1_ppi_wreadycode = core1_ppi_ingress_us_wreadycode;
assign core1_ppi_bctlcode = core1_ppi_ingress_us_bctlcode;
assign core1_ppi_bidcode = core1_ppi_ingress_us_bidcode;
assign core1_ppi_butid = core1_ppi_ingress_us_butid;
assign core1_ppi_bvalidcode = core1_ppi_ingress_us_bvalidcode;
assign core1_ppi_rdatacode = core1_ppi_ingress_us_rdatacode;
assign core1_ppi_ridcode = core1_ppi_ingress_us_ridcode;
assign core1_ppi_rctlcode = core1_ppi_ingress_us_rctlcode;
assign core1_ppi_reobi = core1_ppi_ingress_us_reobi;
assign core1_ppi_rutid = core1_ppi_ingress_us_rutid;
assign core1_ppi_rvalidcode = core1_ppi_ingress_us_rvalidcode;
`else // NDS_IO_PPI_PROT
assign core1_axi_rf_araddr = core1_ppi_araddr;
assign core1_axi_rf_arburst = core1_ppi_arburst;
assign core1_axi_rf_arcache = core1_ppi_arcache;
assign core1_axi_rf_arid = core1_ppi_arid;
assign core1_axi_rf_arlen = core1_ppi_arlen;
assign core1_axi_rf_arlock = core1_ppi_arlock;
assign core1_axi_rf_arprot = core1_ppi_arprot;
assign core1_axi_rf_arsize = core1_ppi_arsize;
assign core1_axi_rf_arvalid = core1_ppi_arvalid;
assign core1_axi_rf_awaddr = core1_ppi_awaddr;
assign core1_axi_rf_awburst = core1_ppi_awburst;
assign core1_axi_rf_awcache = core1_ppi_awcache;
assign core1_axi_rf_awid = core1_ppi_awid;
assign core1_axi_rf_awlen = core1_ppi_awlen;
assign core1_axi_rf_awlock = core1_ppi_awlock;
assign core1_axi_rf_awprot = core1_ppi_awprot;
assign core1_axi_rf_awsize = core1_ppi_awsize;
assign core1_axi_rf_awvalid = core1_ppi_awvalid;
assign core1_axi_rf_wdata = core1_ppi_wdata;
assign core1_axi_rf_wlast = core1_ppi_wlast;
assign core1_axi_rf_wstrb = core1_ppi_wstrb;
assign core1_axi_rf_wvalid = core1_ppi_wvalid;
assign core1_axi_rf_bready = core1_ppi_bready;
assign core1_axi_rf_rready = core1_ppi_rready;
assign core1_ppi_arready = core1_axi_rf_arready;
assign core1_ppi_awready = core1_axi_rf_awready;
assign core1_ppi_wready = core1_axi_rf_wready;
assign core1_ppi_bid = core1_axi_rf_bid;
assign core1_ppi_bresp = core1_axi_rf_bresp;
assign core1_ppi_bvalid = core1_axi_rf_bvalid;
assign core1_ppi_rdata = core1_axi_rf_rdata;
assign core1_ppi_rid = core1_axi_rf_rid;
assign core1_ppi_rlast = core1_axi_rf_rlast;
assign core1_ppi_rresp = core1_axi_rf_rresp;
assign core1_ppi_rvalid = core1_axi_rf_rvalid;
`endif // NDS_IO_PPI_PROT
`endif // NDS_IO_PPI
`endif // NDS_IO_DCLS
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DEBUG
   assign dm_hart_unavail[0]        = core0_hart_unavail;
   assign dm_hart_under_reset[0]    = core0_hart_under_reset;
`else// !NDS_IO_DEBUG
   assign dm_hart_unavail[0]        = 1'b0;
   assign dm_hart_under_reset[0]    = 1'b0;
`endif// !NDS_IO_DEBUG

`ifdef NDS_IO_HART1
`ifdef NDS_IO_DEBUG
   assign dm_hart_unavail[1]        = core1_hart_unavail;
   assign dm_hart_under_reset[1]    = core1_hart_under_reset;
`else// !NDS_IO_DEBUG
   assign dm_hart_unavail[1]        = 1'b0;
   assign dm_hart_under_reset[1]    = 1'b0;
`endif// !NDS_IO_DEBUG
`endif //NDS_IO_HART1


nds_scpu_cluster u_cluster (
`ifdef NDS_IO_SLAVEPORT_COMMON_X2
	.core0_slv1_araddr                           ({BIU_ADDR_WIDTH{1'bx}}                      ), // () <= ()
	.core0_slv1_arburst                          (2'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_arcache                          (4'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_arid                             ({(SLVPORT_ID_WIDTH){1'bx}}                  ), // () <= ()
	.core0_slv1_arlen                            (8'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_arlock                           (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_arprot                           (3'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_arready                          (nds_unused_core0_slv1_arready               ), // (u_cluster) => ()
	.core0_slv1_arsize                           (3'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_aruser                           (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_arvalid                          (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_awaddr                           ({(BIU_ADDR_WIDTH){1'bx}}                    ), // () <= ()
	.core0_slv1_awburst                          (2'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_awcache                          (4'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_awid                             ({(SLVPORT_ID_WIDTH){1'bx}}                  ), // () <= ()
	.core0_slv1_awlen                            (8'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_awlock                           (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_awprot                           (3'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_awready                          (nds_unused_core0_slv1_awready               ), // (u_cluster) => ()
	.core0_slv1_awsize                           (3'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_awuser                           (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_awvalid                          (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_bid                              (nds_unused_core0_slv1_bid                   ), // (u_cluster) => ()
	.core0_slv1_bready                           (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_bresp                            (nds_unused_core0_slv1_bresp                 ), // (u_cluster) => ()
	.core0_slv1_bvalid                           (nds_unused_core0_slv1_bvalid                ), // (u_cluster) => ()
	.core0_slv1_rdata                            (nds_unused_core0_slv1_rdata                 ), // (u_cluster) => ()
	.core0_slv1_reset_n                          (core0_slvp_reset_n                          ), // (u_cluster) <= ()
	.core0_slv1_rid                              (nds_unused_core0_slv1_rid                   ), // (u_cluster) => ()
	.core0_slv1_rlast                            (nds_unused_core0_slv1_rlast                 ), // (u_cluster) => ()
	.core0_slv1_rready                           (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_rresp                            (nds_unused_core0_slv1_rresp                 ), // (u_cluster) => ()
	.core0_slv1_rvalid                           (nds_unused_core0_slv1_rvalid                ), // (u_cluster) => ()
	.core0_slv1_wdata                            ({(BIU_DATA_WIDTH){1'bx}}                    ), // () <= ()
	.core0_slv1_wlast                            (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_wready                           (nds_unused_core0_slv1_wready                ), // (u_cluster) => ()
	.core0_slv1_wstrb                            ({(BIU_DATA_WIDTH/8){1'bx}}                  ), // () <= ()
	.core0_slv1_wvalid                           (1'bx                                        ), // (u_cluster) <= ()
`endif // NDS_IO_SLAVEPORT_COMMON_X2
`ifdef NDS_IO_BUS_PROTECTION
	.sys0_araddrcode                             (cluster_sys0_araddrcode                     ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arctl0code                             (cluster_sys0_arctl0code                     ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arctl1code                             (cluster_sys0_arctl1code                     ), // (u_cluster) => (u_sys0_ingress)
	.sys0_aridcode                               (cluster_sys0_aridcode                       ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arreadycode                            (cluster_sys0_arreadycode                    ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_arutid                                 (cluster_sys0_arutid                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arvalidcode                            (cluster_sys0_arvalidcode                    ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awaddrcode                             (cluster_sys0_awaddrcode                     ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awctl0code                             (cluster_sys0_awctl0code                     ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awctl1code                             (cluster_sys0_awctl1code                     ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awidcode                               (cluster_sys0_awidcode                       ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awreadycode                            (cluster_sys0_awreadycode                    ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_awutid                                 (cluster_sys0_awutid                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awvalidcode                            (cluster_sys0_awvalidcode                    ), // (u_cluster) => (u_sys0_ingress)
	.sys0_bctlcode                               (cluster_sys0_bctlcode                       ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_bidcode                                (cluster_sys0_bidcode                        ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_breadycode                             (cluster_sys0_breadycode                     ), // (u_cluster) => (u_sys0_ingress)
	.sys0_butid                                  (cluster_sys0_butid                          ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_bvalidcode                             (cluster_sys0_bvalidcode                     ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_rctlcode                               (cluster_sys0_rctlcode                       ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_rdatacode                              (cluster_sys0_rdatacode                      ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_reobi                                  (cluster_sys0_reobi                          ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_ridcode                                (cluster_sys0_ridcode                        ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_rreadycode                             (cluster_sys0_rreadycode                     ), // (u_cluster) => (u_sys0_ingress)
	.sys0_rutid                                  (cluster_sys0_rutid                          ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_rvalidcode                             (cluster_sys0_rvalidcode                     ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_wctlcode                               (cluster_sys0_wctlcode                       ), // (u_cluster) => (u_sys0_ingress)
	.sys0_wdatacode                              (cluster_sys0_wdatacode                      ), // (u_cluster) => (u_sys0_ingress)
	.sys0_weobi                                  (cluster_sys0_weobi                          ), // (u_cluster) => (u_sys0_ingress)
	.sys0_wreadycode                             (cluster_sys0_wreadycode                     ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_wutid                                  (cluster_sys0_wutid                          ), // (u_cluster) => (u_sys0_ingress)
	.sys0_wvalidcode                             (cluster_sys0_wvalidcode                     ), // (u_cluster) => (u_sys0_ingress)
	.core0_cfg_timeout_flash0                    (core0_cfg_timeout_flash0                    ), // (u_cluster) <= ()
	.core0_cfg_timeout_ppi                       (core0_cfg_timeout_ppi                       ), // (u_cluster) <= ()
	.core0_cfg_timeout_spp                       (core0_cfg_timeout_spp                       ), // (u_cluster) <= ()
	.core0_cfg_timeout_sys0                      (core0_cfg_timeout_sys0                      ), // (u_cluster) <= ()
	.core0_fs_bus_m_protection_error             (core0_fs_bus_m_protection_error             ), // (u_cluster) => ()
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_EDC_AFTER_ECC
	.core0_fs_edc_error                          (nds_unused_core0_fs_edc_error               ), // (u_cluster) => ()
`endif // NDS_IO_EDC_AFTER_ECC
`ifdef NDS_IO_LM
	.core0_lm_clk                                (core0_lm_clk                                ), // (u_cluster) <= ()
	.core0_lm_local_int                          (hart0_lm_local_int_event                    ), // (u_cluster) => ()
	.lm_p_clk                                    (lm_p_clk                                    ), // (u_cluster) <= ()
	.lm_r_clk                                    (lm_r_clk                                    ), // (u_cluster) <= ()
`endif // NDS_IO_LM
`ifdef NDS_IO_ILM_BOOT
	.core0_ilm_boot                              (ilm_boot                                    ), // (u_cluster) <= ()
`endif // NDS_IO_ILM_BOOT
`ifdef NDS_IO_DLM_BOOT
	.core0_dlm_boot                              (1'b0                                        ), // (u_cluster) <= ()
`endif // NDS_IO_DLM_BOOT
`ifdef NDS_IO_DCLS_SPLIT
	.dcls_p_enable_split                         (dcls_p_enable_split                         ), // (u_cluster) <= ()
	.dcls_r_enable_split                         (dcls_r_enable_split                         ), // (u_cluster) <= ()
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_SLAVEPORT_SYNC
	.core0_slv_clk_en                            (core0_slv_clk_en                            ), // (u_cluster) <= ()
`endif // NDS_IO_SLAVEPORT_SYNC
`ifdef NDS_IO_SLAVEPORT_SYNC_X2
	.core0_slv1_clk_en                           (core0_slv1_clk_en                           ), // (u_cluster) <= ()
`endif // NDS_IO_SLAVEPORT_SYNC_X2
`ifdef NDS_IO_PPI_SYNC
	.core0_ppi_aclk_en                           (1'b1                                        ), // (u_cluster) <= ()
`endif // NDS_IO_PPI_SYNC
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
	.core0_slv_araddr                            (core0_slv_araddr                            ), // (u_cluster) <= ()
	.core0_slv_arburst                           (core0_slv_arburst                           ), // (u_cluster) <= ()
	.core0_slv_arcache                           (core0_slv_arcache                           ), // (u_cluster) <= ()
	.core0_slv_arid                              (core0_slv_arid                              ), // (u_cluster) <= ()
	.core0_slv_arlen                             (core0_slv_arlen                             ), // (u_cluster) <= ()
	.core0_slv_arlock                            (core0_slv_arlock                            ), // (u_cluster) <= ()
	.core0_slv_arprot                            (core0_slv_arprot                            ), // (u_cluster) <= ()
	.core0_slv_arready                           (core0_slv_arready                           ), // (u_cluster) => ()
	.core0_slv_arsize                            (core0_slv_arsize                            ), // (u_cluster) <= ()
	.core0_slv_aruser                            (core0_slv_aruser                            ), // (u_cluster) <= ()
	.core0_slv_arvalid                           (core0_slv_arvalid                           ), // (u_cluster) <= ()
	.core0_slv_awaddr                            (core0_slv_awaddr                            ), // (u_cluster) <= ()
	.core0_slv_awburst                           (core0_slv_awburst                           ), // (u_cluster) <= ()
	.core0_slv_awcache                           (core0_slv_awcache                           ), // (u_cluster) <= ()
	.core0_slv_awid                              (core0_slv_awid                              ), // (u_cluster) <= ()
	.core0_slv_awlen                             (core0_slv_awlen                             ), // (u_cluster) <= ()
	.core0_slv_awlock                            (core0_slv_awlock                            ), // (u_cluster) <= ()
	.core0_slv_awprot                            (core0_slv_awprot                            ), // (u_cluster) <= ()
	.core0_slv_awready                           (core0_slv_awready                           ), // (u_cluster) => ()
	.core0_slv_awsize                            (core0_slv_awsize                            ), // (u_cluster) <= ()
	.core0_slv_awuser                            (core0_slv_awuser                            ), // (u_cluster) <= ()
	.core0_slv_awvalid                           (core0_slv_awvalid                           ), // (u_cluster) <= ()
	.core0_slv_bid                               (core0_slv_bid                               ), // (u_cluster) => ()
	.core0_slv_bready                            (core0_slv_bready                            ), // (u_cluster) <= ()
	.core0_slv_bresp                             (core0_slv_bresp                             ), // (u_cluster) => ()
	.core0_slv_bvalid                            (core0_slv_bvalid                            ), // (u_cluster) => ()
	.core0_slv_rdata                             (core0_slv_rdata                             ), // (u_cluster) => ()
	.core0_slv_reset_n                           (core0_slvp_reset_n                          ), // (u_cluster) <= ()
	.core0_slv_rid                               (core0_slv_rid                               ), // (u_cluster) => ()
	.core0_slv_rlast                             (core0_slv_rlast                             ), // (u_cluster) => ()
	.core0_slv_rready                            (core0_slv_rready                            ), // (u_cluster) <= ()
	.core0_slv_rresp                             (core0_slv_rresp                             ), // (u_cluster) => ()
	.core0_slv_rvalid                            (core0_slv_rvalid                            ), // (u_cluster) => ()
	.core0_slv_wdata                             (core0_slv_wdata                             ), // (u_cluster) <= ()
	.core0_slv_wlast                             (core0_slv_wlast                             ), // (u_cluster) <= ()
	.core0_slv_wready                            (core0_slv_wready                            ), // (u_cluster) => ()
	.core0_slv_wstrb                             (core0_slv_wstrb                             ), // (u_cluster) <= ()
	.core0_slv_wvalid                            (core0_slv_wvalid                            ), // (u_cluster) <= ()
`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X1
	.core0_fs_bus_s_protection_error             (core0_fs_bus_s_protection_error             ), // (u_cluster) => ()
	.core0_slv_araddrcode                        (core0_slv_araddrcode                        ), // (u_cluster) <= ()
	.core0_slv_arctl0code                        (core0_slv_arctl0code                        ), // (u_cluster) <= ()
	.core0_slv_arctl1code                        (core0_slv_arctl1code                        ), // (u_cluster) <= ()
	.core0_slv_aridcode                          (core0_slv_aridcode                          ), // (u_cluster) <= ()
	.core0_slv_arreadycode                       (core0_slv_arreadycode                       ), // (u_cluster) => ()
	.core0_slv_arutid                            (core0_slv_arutid                            ), // (u_cluster) <= ()
	.core0_slv_arvalidcode                       (core0_slv_arvalidcode                       ), // (u_cluster) <= ()
	.core0_slv_awaddrcode                        (core0_slv_awaddrcode                        ), // (u_cluster) <= ()
	.core0_slv_awctl0code                        (core0_slv_awctl0code                        ), // (u_cluster) <= ()
	.core0_slv_awctl1code                        (core0_slv_awctl1code                        ), // (u_cluster) <= ()
	.core0_slv_awidcode                          (core0_slv_awidcode                          ), // (u_cluster) <= ()
	.core0_slv_awreadycode                       (core0_slv_awreadycode                       ), // (u_cluster) => ()
	.core0_slv_awutid                            (core0_slv_awutid                            ), // (u_cluster) <= ()
	.core0_slv_awvalidcode                       (core0_slv_awvalidcode                       ), // (u_cluster) <= ()
	.core0_slv_bctlcode                          (core0_slv_bctlcode                          ), // (u_cluster) => ()
	.core0_slv_bidcode                           (core0_slv_bidcode                           ), // (u_cluster) => ()
	.core0_slv_breadycode                        (core0_slv_breadycode                        ), // (u_cluster) <= ()
	.core0_slv_butid                             (core0_slv_butid                             ), // (u_cluster) => ()
	.core0_slv_bvalidcode                        (core0_slv_bvalidcode                        ), // (u_cluster) => ()
	.core0_slv_rctlcode                          (core0_slv_rctlcode                          ), // (u_cluster) => ()
	.core0_slv_rdatacode                         (core0_slv_rdatacode                         ), // (u_cluster) => ()
	.core0_slv_reobi                             (core0_slv_reobi                             ), // (u_cluster) => ()
	.core0_slv_ridcode                           (core0_slv_ridcode                           ), // (u_cluster) => ()
	.core0_slv_rreadycode                        (core0_slv_rreadycode                        ), // (u_cluster) <= ()
	.core0_slv_rutid                             (core0_slv_rutid                             ), // (u_cluster) => ()
	.core0_slv_rvalidcode                        (core0_slv_rvalidcode                        ), // (u_cluster) => ()
	.core0_slv_wctlcode                          (core0_slv_wctlcode                          ), // (u_cluster) <= ()
	.core0_slv_wdatacode                         (core0_slv_wdatacode                         ), // (u_cluster) <= ()
	.core0_slv_weobi                             (core0_slv_weobi                             ), // (u_cluster) <= ()
	.core0_slv_wreadycode                        (core0_slv_wreadycode                        ), // (u_cluster) => ()
	.core0_slv_wutid                             (core0_slv_wutid                             ), // (u_cluster) <= ()
	.core0_slv_wvalidcode                        (core0_slv_wvalidcode                        ), // (u_cluster) <= ()
`endif // NDS_IO_SLAVEPORT_ECC_X1
`ifdef NDS_IO_SLAVEPORT_ECC_X2
	.core0_fs_bus_s1_protection_error            (nds_unused_core0_fs_bus_s1_protection_error ), // (u_cluster) => ()
	.core0_slv1_araddrcode                       ({(SLV_ADDR_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core0_slv1_arctl0code                       ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core0_slv1_arctl1code                       ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core0_slv1_aridcode                         ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core0_slv1_arreadycode                      (nds_unused_core0_slv1_arreadycode           ), // (u_cluster) => ()
	.core0_slv1_arutid                           ({(SLV_UTID_WIDTH){1'bx}}                    ), // () <= ()
	.core0_slv1_arvalidcode                      (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_awaddrcode                       ({(SLV_ADDR_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core0_slv1_awctl0code                       ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core0_slv1_awctl1code                       ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core0_slv1_awidcode                         ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core0_slv1_awreadycode                      (nds_unused_core0_slv1_awreadycode           ), // (u_cluster) => ()
	.core0_slv1_awutid                           ({(SLV_UTID_WIDTH){1'bx}}                    ), // () <= ()
	.core0_slv1_awvalidcode                      (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_bctlcode                         (nds_unused_core0_slv1_bctlcode              ), // (u_cluster) => ()
	.core0_slv1_bidcode                          (nds_unused_core0_slv1_bidcode               ), // (u_cluster) => ()
	.core0_slv1_breadycode                       (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_butid                            (nds_unused_core0_slv1_butid                 ), // (u_cluster) => ()
	.core0_slv1_bvalidcode                       (nds_unused_core0_slv1_bvalidcode            ), // (u_cluster) => ()
	.core0_slv1_rctlcode                         (nds_unused_core0_slv1_rctlcode              ), // (u_cluster) => ()
	.core0_slv1_rdatacode                        (nds_unused_core0_slv1_rdatacode             ), // (u_cluster) => ()
	.core0_slv1_reobi                            (nds_unused_core0_slv1_reobi                 ), // (u_cluster) => ()
	.core0_slv1_ridcode                          (nds_unused_core0_slv1_ridcode               ), // (u_cluster) => ()
	.core0_slv1_rreadycode                       (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_rutid                            (nds_unused_core0_slv1_rutid                 ), // (u_cluster) => ()
	.core0_slv1_rvalidcode                       (nds_unused_core0_slv1_rvalidcode            ), // (u_cluster) => ()
	.core0_slv1_wctlcode                         ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core0_slv1_wdatacode                        ({(SLV_DATA_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core0_slv1_weobi                            (1'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_wreadycode                       (nds_unused_core0_slv1_wreadycode            ), // (u_cluster) => ()
	.core0_slv1_wutid                            ({(SLV_UTID_WIDTH){1'bx}}                    ), // () <= ()
	.core0_slv1_wvalidcode                       (1'bx                                        ), // (u_cluster) <= ()
`endif // NDS_IO_SLAVEPORT_ECC_X2
`ifdef NDS_TRACE_TILELINK
	.core0_trace_dcu_cmt_addr                    (core0_trace_dcu_cmt_addr                    ), // (u_cluster) => ()
	.core0_trace_dcu_cmt_func                    (core0_trace_dcu_cmt_func                    ), // (u_cluster) => ()
	.core0_trace_dcu_cmt_valid                   (core0_trace_dcu_cmt_valid                   ), // (u_cluster) => ()
	.core0_trace_dcu_cmt_wdata                   (core0_trace_dcu_cmt_wdata                   ), // (u_cluster) => ()
	.core0_trace_i0_wb_alive                     (core0_trace_i0_wb_alive                     ), // (u_cluster) => ()
	.core0_trace_i0_wb_pc                        (core0_trace_i0_wb_pc                        ), // (u_cluster) => ()
	.core0_trace_i1_wb_alive                     (core0_trace_i1_wb_alive                     ), // (u_cluster) => ()
	.core0_trace_i1_wb_pc                        (core0_trace_i1_wb_pc                        ), // (u_cluster) => ()
	.core0_trace_ls_i0_instr                     (core0_trace_ls_i0_instr                     ), // (u_cluster) => ()
	.core0_trace_ls_i0_pc                        (core0_trace_ls_i0_pc                        ), // (u_cluster) => ()
	.core0_trace_sb_va                           (core0_trace_sb_va                           ), // (u_cluster) => ()
	.core0_trace_wb_cause                        (core0_trace_wb_cause                        ), // (u_cluster) => ()
	.core0_trace_wb_xcpt                         (core0_trace_wb_xcpt                         ), // (u_cluster) => ()
`endif // NDS_TRACE_TILELINK
`ifdef NDS_IO_LM_RESET
	.core0_lm_reset_n                            (core0_lm_reset_n                            ), // (u_cluster) => ()
`endif // NDS_IO_LM_RESET
`ifdef NDS_IO_ILM_TL_UL
	.core0_ilm_a_addr                            (core0_ilm_a_addr                            ), // (u_cluster) => (u_core0_ilm_ram_brg)
	.core0_ilm_a_data                            (core0_ilm_a_data                            ), // (u_cluster) => (u_core0_ilm_ram_brg)
	.core0_ilm_a_mask                            (core0_ilm_a_mask                            ), // (u_cluster) => (u_core0_ilm_ram_brg)
	.core0_ilm_a_opcode                          (core0_ilm_a_opcode                          ), // (u_cluster) => (u_core0_ilm_ram_brg)
	.core0_ilm_a_parity0                         (core0_ilm_a_parity0                         ), // (u_cluster) => ()
	.core0_ilm_a_parity1                         (core0_ilm_a_parity1                         ), // (u_cluster) => ()
	.core0_ilm_a_ready                           (core0_ilm_a_ready                           ), // (u_cluster) <= (u_core0_ilm_ram_brg)
	.core0_ilm_a_size                            (core0_ilm_a_size                            ), // (u_cluster) => (u_core0_ilm_ram_brg)
	.core0_ilm_a_user                            (core0_ilm_a_user                            ), // (u_cluster) => ()
	.core0_ilm_a_valid                           (core0_ilm_a_valid                           ), // (u_cluster) => (u_core0_ilm_ram_brg)
	.core0_ilm_d_data                            (core0_ilm_d_data                            ), // (u_cluster) <= (u_core0_ilm_ram_brg)
	.core0_ilm_d_denied                          (core0_ilm_d_denied                          ), // (u_cluster) <= (u_core0_ilm_ram_brg)
	.core0_ilm_d_parity0                         (core0_ilm_d_parity0                         ), // (u_cluster) <= ()
	.core0_ilm_d_parity1                         (core0_ilm_d_parity1                         ), // (u_cluster) <= ()
	.core0_ilm_d_ready                           (core0_ilm_d_ready                           ), // (u_cluster) => (u_core0_ilm_ram_brg)
	.core0_ilm_d_valid                           (core0_ilm_d_valid                           ), // (u_cluster) <= (u_core0_ilm_ram_brg)
`endif // NDS_IO_ILM_TL_UL
`ifdef NDS_IO_DLM_TL_UL
	.core0_dlm_a_addr                            (core0_dlm_a_addr                            ), // (u_cluster) => (u_core0_dlm_ram0)
	.core0_dlm_a_data                            (core0_dlm_a_data                            ), // (u_cluster) => (u_core0_dlm_ram0)
	.core0_dlm_a_mask                            (core0_dlm_a_mask                            ), // (u_cluster) => (u_core0_dlm_ram0)
	.core0_dlm_a_opcode                          (core0_dlm_a_opcode                          ), // (u_cluster) => (u_core0_dlm_ram0)
	.core0_dlm_a_parity                          (core0_dlm_a_parity                          ), // (u_cluster) => (u_core0_dlm_ram0)
	.core0_dlm_a_ready                           (core0_dlm_a_ready                           ), // (u_cluster) <= (u_core0_dlm_ram0)
	.core0_dlm_a_size                            (core0_dlm_a_size                            ), // (u_cluster) => (u_core0_dlm_ram0)
	.core0_dlm_a_user                            (core0_dlm_a_user                            ), // (u_cluster) => (u_core0_dlm_ram0)
	.core0_dlm_a_valid                           (core0_dlm_a_valid                           ), // (u_cluster) => (u_core0_dlm_ram0)
	.core0_dlm_d_data                            (core0_dlm_d_data                            ), // (u_cluster) <= (u_core0_dlm_ram0)
	.core0_dlm_d_denied                          (core0_dlm_d_denied                          ), // (u_cluster) <= (u_core0_dlm_ram0)
	.core0_dlm_d_parity                          (core0_dlm_d_parity                          ), // (u_cluster) <= (u_core0_dlm_ram0)
	.core0_dlm_d_ready                           (core0_dlm_d_ready                           ), // (u_cluster) => (u_core0_dlm_ram0)
	.core0_dlm_d_valid                           (core0_dlm_d_valid                           ), // (u_cluster) <= (u_core0_dlm_ram0)
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_ICACHE0
	.core0_icache_disable_init                   (core0_icache_disable_init                   ), // (u_cluster) <= ()
	.icache0_p_clk                               (icache0_p_clk                               ), // (u_cluster) <= ()
	.icache0_r_clk                               (icache0_r_clk                               ), // (u_cluster) <= ()
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCACHE0
	.core0_dcache_disable_init                   (core0_dcache_disable_init                   ), // (u_cluster) <= ()
	.dcache0_p_clk                               (dcache0_p_clk                               ), // (u_cluster) <= ()
	.dcache0_r_clk                               (dcache0_r_clk                               ), // (u_cluster) <= ()
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_PROBING
	.core0_current_pc                            (hart0_probe_current_pc                      ), // (u_cluster) => ()
	.core0_gpr_index                             (hart0_probe_gpr_index                       ), // (u_cluster) <= ()
	.core0_selected_gpr_value                    (hart0_probe_selected_gpr_value              ), // (u_cluster) => ()
`endif // NDS_IO_PROBING
`ifdef NDS_IO_SEIP
	.core0_seiack                                (core0_seiack                                ), // (u_cluster) => ()
	.core0_seiid                                 (core0_seiid                                 ), // (u_cluster) <= ()
	.core0_seip                                  (core0_seip                                  ), // (u_cluster) <= ()
`endif // NDS_IO_SEIP
`ifdef NDS_IO_UEIP
	.core0_ueiack                                (nds_unused_core0_ueiack                     ), // (u_cluster) => ()
	.core0_ueiid                                 (10'b0                                       ), // (u_cluster) <= ()
	.core0_ueip                                  (core0_ueip                                  ), // (u_cluster) <= ()
`endif // NDS_IO_UEIP
`ifdef NDS_IO_DEBUG
	.core0_debugint                              (core0_debugint                              ), // (u_cluster) <= ()
	.core0_hart_halted                           (core0_hart_halted                           ), // (u_cluster) => ()
	.core0_hart_unavail                          (core0_hart_unavail                          ), // (u_cluster) => ()
	.core0_hart_under_reset                      (core0_hart_under_reset                      ), // (u_cluster) => ()
	.core0_resethaltreq                          (core0_resethaltreq                          ), // (u_cluster) <= ()
	.core0_stoptime                              (core0_stoptime                              ), // (u_cluster) => ()
`endif // NDS_IO_DEBUG
`ifdef NDS_IO_TRACE_INSTR_GEN1
	.core0_gen1_trace_cause                      (hart0_gen1_trace_cause                      ), // (u_cluster) => ()
	.core0_gen1_trace_enabled                    (hart0_gen1_trace_enabled                    ), // (u_cluster) <= ()
	.core0_gen1_trace_iaddr                      (hart0_gen1_trace_iaddr                      ), // (u_cluster) => ()
	.core0_gen1_trace_iexception                 (hart0_gen1_trace_iexception                 ), // (u_cluster) => ()
	.core0_gen1_trace_instr                      (hart0_gen1_trace_instr                      ), // (u_cluster) => ()
	.core0_gen1_trace_interrupt                  (hart0_gen1_trace_interrupt                  ), // (u_cluster) => ()
	.core0_gen1_trace_ivalid                     (hart0_gen1_trace_ivalid                     ), // (u_cluster) => ()
	.core0_gen1_trace_priv                       (hart0_gen1_trace_priv                       ), // (u_cluster) => ()
	.core0_gen1_trace_tval                       (hart0_gen1_trace_tval                       ), // (u_cluster) => ()
`endif // NDS_IO_TRACE_INSTR_GEN1
`ifdef NDS_IO_TRACE_INSTR
	.core0_trace_cause                           (hart0_trace_cause                           ), // (u_cluster) => ()
	.core0_trace_context                         (hart0_trace_context                         ), // (u_cluster) => ()
	.core0_trace_ctype                           (hart0_trace_ctype                           ), // (u_cluster) => ()
	.core0_trace_enabled                         (hart0_trace_enabled                         ), // (u_cluster) <= ()
	.core0_trace_halted                          (hart0_trace_halted                          ), // (u_cluster) => ()
	.core0_trace_iaddr                           (hart0_trace_iaddr                           ), // (u_cluster) => ()
	.core0_trace_ilastsize                       (hart0_trace_ilastsize                       ), // (u_cluster) => ()
	.core0_trace_iretire                         (hart0_trace_iretire                         ), // (u_cluster) => ()
	.core0_trace_itype                           (hart0_trace_itype                           ), // (u_cluster) => ()
	.core0_trace_priv                            (hart0_trace_priv                            ), // (u_cluster) => ()
	.core0_trace_reset                           (hart0_trace_reset                           ), // (u_cluster) => ()
	.core0_trace_stall                           (hart0_trace_stall                           ), // (u_cluster) <= ()
	.core0_trace_trigger                         (hart0_trace_trigger                         ), // (u_cluster) => ()
	.core0_trace_tval                            (hart0_trace_tval                            ), // (u_cluster) => ()
`endif // NDS_IO_TRACE_INSTR
`ifdef NDS_IO_TRAP_STATUS
	.core0_fs_halt_mode                          (nds_unused_core0_fs_halt_mode               ), // (u_cluster) => ()
	.core0_fs_trap_status_cause                  (nds_unused_core0_fs_trap_status_cause       ), // (u_cluster) => ()
	.core0_fs_trap_status_dcause                 (nds_unused_core0_fs_trap_status_dcause      ), // (u_cluster) => ()
	.core0_fs_trap_status_interrupt              (nds_unused_core0_fs_trap_status_interrupt   ), // (u_cluster) => ()
	.core0_fs_trap_status_nmi                    (nds_unused_core0_fs_trap_status_nmi         ), // (u_cluster) => ()
	.core0_fs_trap_status_taken                  (nds_unused_core0_fs_trap_status_taken       ), // (u_cluster) => ()
`endif // NDS_IO_TRAP_STATUS
`ifdef NDS_IO_PPI
	.core0_ppi_araddr                            (core0_ppi_araddr                            ), // (u_cluster) => ()
	.core0_ppi_arburst                           (core0_ppi_arburst                           ), // (u_cluster) => ()
	.core0_ppi_arcache                           (core0_ppi_arcache                           ), // (u_cluster) => ()
	.core0_ppi_arid                              (core0_ppi_arid                              ), // (u_cluster) => ()
	.core0_ppi_arlen                             (core0_ppi_arlen                             ), // (u_cluster) => ()
	.core0_ppi_arlock                            (core0_ppi_arlock                            ), // (u_cluster) => ()
	.core0_ppi_arprot                            (core0_ppi_arprot                            ), // (u_cluster) => ()
	.core0_ppi_arready                           (core0_ppi_arready                           ), // (u_cluster) <= ()
	.core0_ppi_arsize                            (core0_ppi_arsize                            ), // (u_cluster) => ()
	.core0_ppi_arvalid                           (core0_ppi_arvalid                           ), // (u_cluster) => ()
	.core0_ppi_awaddr                            (core0_ppi_awaddr                            ), // (u_cluster) => ()
	.core0_ppi_awburst                           (core0_ppi_awburst                           ), // (u_cluster) => ()
	.core0_ppi_awcache                           (core0_ppi_awcache                           ), // (u_cluster) => ()
	.core0_ppi_awid                              (core0_ppi_awid                              ), // (u_cluster) => ()
	.core0_ppi_awlen                             (core0_ppi_awlen                             ), // (u_cluster) => ()
	.core0_ppi_awlock                            (core0_ppi_awlock                            ), // (u_cluster) => ()
	.core0_ppi_awprot                            (core0_ppi_awprot                            ), // (u_cluster) => ()
	.core0_ppi_awready                           (core0_ppi_awready                           ), // (u_cluster) <= ()
	.core0_ppi_awsize                            (core0_ppi_awsize                            ), // (u_cluster) => ()
	.core0_ppi_awvalid                           (core0_ppi_awvalid                           ), // (u_cluster) => ()
	.core0_ppi_bid                               (core0_ppi_bid                               ), // (u_cluster) <= ()
	.core0_ppi_bready                            (core0_ppi_bready                            ), // (u_cluster) => ()
	.core0_ppi_bresp                             (core0_ppi_bresp                             ), // (u_cluster) <= ()
	.core0_ppi_bvalid                            (core0_ppi_bvalid                            ), // (u_cluster) <= ()
	.core0_ppi_rdata                             (core0_ppi_rdata                             ), // (u_cluster) <= ()
	.core0_ppi_rid                               (core0_ppi_rid                               ), // (u_cluster) <= ()
	.core0_ppi_rlast                             (core0_ppi_rlast                             ), // (u_cluster) <= ()
	.core0_ppi_rready                            (core0_ppi_rready                            ), // (u_cluster) => ()
	.core0_ppi_rresp                             (core0_ppi_rresp                             ), // (u_cluster) <= ()
	.core0_ppi_rvalid                            (core0_ppi_rvalid                            ), // (u_cluster) <= ()
	.core0_ppi_wdata                             (core0_ppi_wdata                             ), // (u_cluster) => ()
	.core0_ppi_wlast                             (core0_ppi_wlast                             ), // (u_cluster) => ()
	.core0_ppi_wready                            (core0_ppi_wready                            ), // (u_cluster) <= ()
	.core0_ppi_wstrb                             (core0_ppi_wstrb                             ), // (u_cluster) => ()
	.core0_ppi_wvalid                            (core0_ppi_wvalid                            ), // (u_cluster) => ()
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
	.core0_ppi_araddrcode                        (core0_ppi_araddrcode                        ), // (u_cluster) => ()
	.core0_ppi_arctl0code                        (core0_ppi_arctl0code                        ), // (u_cluster) => ()
	.core0_ppi_arctl1code                        (core0_ppi_arctl1code                        ), // (u_cluster) => ()
	.core0_ppi_aridcode                          (core0_ppi_aridcode                          ), // (u_cluster) => ()
	.core0_ppi_arreadycode                       (core0_ppi_arreadycode                       ), // (u_cluster) <= ()
	.core0_ppi_arutid                            (core0_ppi_arutid                            ), // (u_cluster) => ()
	.core0_ppi_arvalidcode                       (core0_ppi_arvalidcode                       ), // (u_cluster) => ()
	.core0_ppi_awaddrcode                        (core0_ppi_awaddrcode                        ), // (u_cluster) => ()
	.core0_ppi_awctl0code                        (core0_ppi_awctl0code                        ), // (u_cluster) => ()
	.core0_ppi_awctl1code                        (core0_ppi_awctl1code                        ), // (u_cluster) => ()
	.core0_ppi_awidcode                          (core0_ppi_awidcode                          ), // (u_cluster) => ()
	.core0_ppi_awreadycode                       (core0_ppi_awreadycode                       ), // (u_cluster) <= ()
	.core0_ppi_awutid                            (core0_ppi_awutid                            ), // (u_cluster) => ()
	.core0_ppi_awvalidcode                       (core0_ppi_awvalidcode                       ), // (u_cluster) => ()
	.core0_ppi_bctlcode                          (core0_ppi_bctlcode                          ), // (u_cluster) <= ()
	.core0_ppi_bidcode                           (core0_ppi_bidcode                           ), // (u_cluster) <= ()
	.core0_ppi_breadycode                        (core0_ppi_breadycode                        ), // (u_cluster) => ()
	.core0_ppi_butid                             (core0_ppi_butid                             ), // (u_cluster) <= ()
	.core0_ppi_bvalidcode                        (core0_ppi_bvalidcode                        ), // (u_cluster) <= ()
	.core0_ppi_rctlcode                          (core0_ppi_rctlcode                          ), // (u_cluster) <= ()
	.core0_ppi_rdatacode                         (core0_ppi_rdatacode                         ), // (u_cluster) <= ()
	.core0_ppi_reobi                             (core0_ppi_reobi                             ), // (u_cluster) <= ()
	.core0_ppi_ridcode                           (core0_ppi_ridcode                           ), // (u_cluster) <= ()
	.core0_ppi_rreadycode                        (core0_ppi_rreadycode                        ), // (u_cluster) => ()
	.core0_ppi_rutid                             (core0_ppi_rutid                             ), // (u_cluster) <= ()
	.core0_ppi_rvalidcode                        (core0_ppi_rvalidcode                        ), // (u_cluster) <= ()
	.core0_ppi_wctlcode                          (core0_ppi_wctlcode                          ), // (u_cluster) => ()
	.core0_ppi_wdatacode                         (core0_ppi_wdatacode                         ), // (u_cluster) => ()
	.core0_ppi_weobi                             (core0_ppi_weobi                             ), // (u_cluster) => ()
	.core0_ppi_wreadycode                        (core0_ppi_wreadycode                        ), // (u_cluster) <= ()
	.core0_ppi_wutid                             (core0_ppi_wutid                             ), // (u_cluster) => ()
	.core0_ppi_wvalidcode                        (core0_ppi_wvalidcode                        ), // (u_cluster) => ()
`endif // NDS_IO_PPI_PROT
`ifdef NDS_IO_LM_QOS
	.core0_ifu_ilm_qos                           (core0_ifu_ilm_qos                           ), // (u_cluster) <= ()
	.core0_lsu_dlm_qos                           (core0_lsu_dlm_qos                           ), // (u_cluster) <= ()
	.core0_lsu_ilm_qos                           (core0_lsu_ilm_qos                           ), // (u_cluster) <= ()
`endif // NDS_IO_LM_QOS
`ifdef NDS_IO_SLAVEPORT_QOS_X1
	.core0_slv_arqos                             (core0_slv_arqos                             ), // (u_cluster) <= ()
	.core0_slv_awqos                             (core0_slv_awqos                             ), // (u_cluster) <= ()
`endif // NDS_IO_SLAVEPORT_QOS_X1
`ifdef NDS_IO_SLAVEPORT_QOS_X2
	.core0_slv1_arqos                            (4'bx                                        ), // (u_cluster) <= ()
	.core0_slv1_awqos                            (4'bx                                        ), // (u_cluster) <= ()
`endif // NDS_IO_SLAVEPORT_QOS_X2
`ifdef NDS_IO_DCLS
	.core1_clk                                   (core1_clk                                   ), // (u_cluster) <= ()
	.core1_reset_n                               (core1_reset_n                               ), // (u_cluster) <= ()
	.dcls_comp_out                               (dcls_comp_out                               ), // (u_cluster) => ()
	.dcls_inject_en                              (dcls_inject_en                              ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_a_address              (dcls_inject_fault_m0_a_address              ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_a_corrupt              (dcls_inject_fault_m0_a_corrupt              ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_a_data                 (dcls_inject_fault_m0_a_data                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_a_mask                 (dcls_inject_fault_m0_a_mask                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_a_opcode               (dcls_inject_fault_m0_a_opcode               ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_a_param                (dcls_inject_fault_m0_a_param                ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_a_size                 (dcls_inject_fault_m0_a_size                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_a_source               (dcls_inject_fault_m0_a_source               ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_a_user                 (dcls_inject_fault_m0_a_user                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_a_valid                (dcls_inject_fault_m0_a_valid                ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_b_ready                (dcls_inject_fault_m0_b_ready                ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_c_address              (dcls_inject_fault_m0_c_address              ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_c_corrupt              (dcls_inject_fault_m0_c_corrupt              ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_c_data                 (dcls_inject_fault_m0_c_data                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_c_opcode               (dcls_inject_fault_m0_c_opcode               ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_c_param                (dcls_inject_fault_m0_c_param                ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_c_size                 (dcls_inject_fault_m0_c_size                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_c_source               (dcls_inject_fault_m0_c_source               ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_c_user                 (dcls_inject_fault_m0_c_user                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_c_valid                (dcls_inject_fault_m0_c_valid                ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_d_ready                (dcls_inject_fault_m0_d_ready                ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_e_sink                 (dcls_inject_fault_m0_e_sink                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m0_e_valid                (dcls_inject_fault_m0_e_valid                ), // (u_cluster) <= ()
	.dcls_inject_fault_m1_a_address              (dcls_inject_fault_m1_a_address              ), // (u_cluster) <= ()
	.dcls_inject_fault_m1_a_corrupt              (dcls_inject_fault_m1_a_corrupt              ), // (u_cluster) <= ()
	.dcls_inject_fault_m1_a_data                 (dcls_inject_fault_m1_a_data                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m1_a_mask                 (dcls_inject_fault_m1_a_mask                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m1_a_opcode               (dcls_inject_fault_m1_a_opcode               ), // (u_cluster) <= ()
	.dcls_inject_fault_m1_a_param                (dcls_inject_fault_m1_a_param                ), // (u_cluster) <= ()
	.dcls_inject_fault_m1_a_size                 (dcls_inject_fault_m1_a_size                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m1_a_source               (dcls_inject_fault_m1_a_source               ), // (u_cluster) <= ()
	.dcls_inject_fault_m1_a_user                 (dcls_inject_fault_m1_a_user                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m1_a_valid                (dcls_inject_fault_m1_a_valid                ), // (u_cluster) <= ()
	.dcls_inject_fault_m1_d_ready                (dcls_inject_fault_m1_d_ready                ), // (u_cluster) <= ()
	.dcls_inject_fault_m2_a_address              (dcls_inject_fault_m2_a_address              ), // (u_cluster) <= ()
	.dcls_inject_fault_m2_a_corrupt              (dcls_inject_fault_m2_a_corrupt              ), // (u_cluster) <= ()
	.dcls_inject_fault_m2_a_data                 (dcls_inject_fault_m2_a_data                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m2_a_mask                 (dcls_inject_fault_m2_a_mask                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m2_a_opcode               (dcls_inject_fault_m2_a_opcode               ), // (u_cluster) <= ()
	.dcls_inject_fault_m2_a_param                (dcls_inject_fault_m2_a_param                ), // (u_cluster) <= ()
	.dcls_inject_fault_m2_a_size                 (dcls_inject_fault_m2_a_size                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m2_a_source               (dcls_inject_fault_m2_a_source               ), // (u_cluster) <= ()
	.dcls_inject_fault_m2_a_user                 (dcls_inject_fault_m2_a_user                 ), // (u_cluster) <= ()
	.dcls_inject_fault_m2_a_valid                (dcls_inject_fault_m2_a_valid                ), // (u_cluster) <= ()
	.dcls_inject_fault_m2_d_ready                (dcls_inject_fault_m2_d_ready                ), // (u_cluster) <= ()
	.dcls_inject_fault_meiack                    (dcls_inject_fault_meiack                    ), // (u_cluster) <= ()
	.dcls_inject_fault_wfi_mode                  (dcls_inject_fault_wfi_mode                  ), // (u_cluster) <= ()
	.dcls_p_clk                                  (dcls_p_clk                                  ), // (u_cluster) <= ()
	.dcls_p_reset_n                              (dcls_p_reset_n                              ), // (u_cluster) <= ()
	.dcls_r_clk                                  (dcls_r_clk                                  ), // (u_cluster) <= ()
	.dcls_r_reset_n                              (dcls_r_reset_n                              ), // (u_cluster) <= ()
`endif // NDS_IO_DCLS
`ifdef NDS_IO_ICACHE0_CTRL_IN
	.icache_tag0_ctrl_in                         ({`NDS_ICACHE_TAG_RAM_CTRL_IN_WIDTH{1'b0}}   ), // () <= ()
`endif // NDS_IO_ICACHE0_CTRL_IN
`ifdef NDS_IO_ICACHE0_CTRL_OUT
	.icache_tag0_ctrl_out                        (nds_unused_icache_tag0_ctrl_out             ), // (u_cluster) => ()
`endif // NDS_IO_ICACHE0_CTRL_OUT
`ifdef NDS_IO_ICACHE1_CTRL_IN
	.icache_tag1_ctrl_in                         ({`NDS_ICACHE_TAG_RAM_CTRL_IN_WIDTH{1'b0}}   ), // () <= ()
`endif // NDS_IO_ICACHE1_CTRL_IN
`ifdef NDS_IO_ICACHE1_CTRL_OUT
	.icache_tag1_ctrl_out                        (nds_unused_icache_tag1_ctrl_out             ), // (u_cluster) => ()
`endif // NDS_IO_ICACHE1_CTRL_OUT
`ifdef NDS_IO_ICACHE2_CTRL_IN
	.icache_tag2_ctrl_in                         ({`NDS_ICACHE_TAG_RAM_CTRL_IN_WIDTH{1'b0}}   ), // () <= ()
	.icache_tag3_ctrl_in                         ({`NDS_ICACHE_TAG_RAM_CTRL_IN_WIDTH{1'b0}}   ), // () <= ()
`endif // NDS_IO_ICACHE2_CTRL_IN
`ifdef NDS_IO_ICACHE2_CTRL_OUT
	.icache_tag2_ctrl_out                        (nds_unused_icache_tag2_ctrl_out             ), // (u_cluster) => ()
	.icache_tag3_ctrl_out                        (nds_unused_icache_tag3_ctrl_out             ), // (u_cluster) => ()
`endif // NDS_IO_ICACHE2_CTRL_OUT
`ifdef NDS_IO_BTB_RAM_CTRL_IN
	.core0_btb0_ctrl_in                          ({`NDS_BTB_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
	.core0_btb1_ctrl_in                          ({`NDS_BTB_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
`endif // NDS_IO_BTB_RAM_CTRL_IN
`ifdef NDS_IO_BTB_RAM_CTRL_OUT
	.core0_btb0_ctrl_out                         (nds_unused_core0_btb0_ctrl_out              ), // (u_cluster) => ()
	.core0_btb1_ctrl_out                         (nds_unused_core0_btb1_ctrl_out              ), // (u_cluster) => ()
`endif // NDS_IO_BTB_RAM_CTRL_OUT
`ifdef NDS_IO_BTB2_RAM_CTRL_IN
	.core0_btb2_ctrl_in                          ({`NDS_BTB_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
`endif // NDS_IO_BTB2_RAM_CTRL_IN
`ifdef NDS_IO_BTB2_RAM_CTRL_OUT
	.core0_btb2_ctrl_out                         (nds_unused_core0_btb2_ctrl_out              ), // (u_cluster) => ()
`endif // NDS_IO_BTB2_RAM_CTRL_OUT
`ifdef NDS_IO_BTB3_RAM_CTRL_IN
	.core0_btb3_ctrl_in                          ({`NDS_BTB_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
`endif // NDS_IO_BTB3_RAM_CTRL_IN
`ifdef NDS_IO_BTB3_RAM_CTRL_OUT
	.core0_btb3_ctrl_out                         (nds_unused_core0_btb3_ctrl_out              ), // (u_cluster) => ()
`endif // NDS_IO_BTB3_RAM_CTRL_OUT
`ifdef NDS_IO_FLASHIF0
	.flash0_aclk_en                              (axi_bus_clk_en                              ), // (u_cluster) <= ()
	.flash0_araddr                               (cluster_flash0_araddr                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arburst                              (cluster_flash0_arburst                      ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arcache                              (cluster_flash0_arcache                      ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arid                                 (cluster_flash0_arid                         ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arlen                                (cluster_flash0_arlen                        ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arlock                               (cluster_flash0_arlock                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arprot                               (cluster_flash0_arprot                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arready                              (cluster_flash0_arready                      ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_arsize                               (cluster_flash0_arsize                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arvalid                              (cluster_flash0_arvalid                      ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awaddr                               (cluster_flash0_awaddr                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awburst                              (cluster_flash0_awburst                      ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awcache                              (cluster_flash0_awcache                      ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awid                                 (cluster_flash0_awid                         ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awlen                                (cluster_flash0_awlen                        ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awlock                               (cluster_flash0_awlock                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awprot                               (cluster_flash0_awprot                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awready                              (cluster_flash0_awready                      ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_awsize                               (cluster_flash0_awsize                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awvalid                              (cluster_flash0_awvalid                      ), // (u_cluster) => (u_flash0_ingress)
	.flash0_bid                                  (cluster_flash0_bid                          ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_bready                               (cluster_flash0_bready                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_bresp                                (cluster_flash0_bresp                        ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_bvalid                               (cluster_flash0_bvalid                       ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_rdata                                (cluster_flash0_rdata                        ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_rid                                  (cluster_flash0_rid                          ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_rlast                                (cluster_flash0_rlast                        ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_rready                               (cluster_flash0_rready                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_rresp                                (cluster_flash0_rresp                        ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_rvalid                               (cluster_flash0_rvalid                       ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_wdata                                (cluster_flash0_wdata                        ), // (u_cluster) => (u_flash0_ingress)
	.flash0_wlast                                (cluster_flash0_wlast                        ), // (u_cluster) => (u_flash0_ingress)
	.flash0_wready                               (cluster_flash0_wready                       ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_wstrb                                (cluster_flash0_wstrb                        ), // (u_cluster) => (u_flash0_ingress)
	.flash0_wvalid                               (cluster_flash0_wvalid                       ), // (u_cluster) => (u_flash0_ingress)
`endif // NDS_IO_FLASHIF0
`ifdef NDS_IO_SPP
	.spp_aclk_en                                 (axi_bus_clk_en                              ), // (u_cluster) <= ()
	.spp_araddr                                  (spp_araddr                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_arburst                                 (spp_arburst                                 ), // (u_cluster) => (u_spp_ingress)
	.spp_arcache                                 (spp_arcache                                 ), // (u_cluster) => (u_spp_ingress)
	.spp_arid                                    (spp_arid                                    ), // (u_cluster) => (u_spp_ingress)
	.spp_arlen                                   (spp_arlen                                   ), // (u_cluster) => (u_spp_ingress)
	.spp_arlock                                  (spp_arlock                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_arprot                                  (spp_arprot                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_arready                                 (spp_arready                                 ), // (u_cluster) <= (u_spp_ingress)
	.spp_arsize                                  (spp_arsize                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_arvalid                                 (spp_arvalid                                 ), // (u_cluster) => (u_spp_ingress)
	.spp_awaddr                                  (spp_awaddr                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_awburst                                 (spp_awburst                                 ), // (u_cluster) => (u_spp_ingress)
	.spp_awcache                                 (spp_awcache                                 ), // (u_cluster) => (u_spp_ingress)
	.spp_awid                                    (spp_awid                                    ), // (u_cluster) => (u_spp_ingress)
	.spp_awlen                                   (spp_awlen                                   ), // (u_cluster) => (u_spp_ingress)
	.spp_awlock                                  (spp_awlock                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_awprot                                  (spp_awprot                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_awready                                 (spp_awready                                 ), // (u_cluster) <= (u_spp_ingress)
	.spp_awsize                                  (spp_awsize                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_awvalid                                 (spp_awvalid                                 ), // (u_cluster) => (u_spp_ingress)
	.spp_bid                                     (spp_bid                                     ), // (u_cluster) <= (u_spp_ingress)
	.spp_bready                                  (spp_bready                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_bresp                                   (spp_bresp                                   ), // (u_cluster) <= (u_spp_ingress)
	.spp_bvalid                                  (spp_bvalid                                  ), // (u_cluster) <= (u_spp_ingress)
	.spp_rdata                                   (spp_rdata                                   ), // (u_cluster) <= (u_spp_ingress)
	.spp_rid                                     (spp_rid                                     ), // (u_cluster) <= (u_spp_ingress)
	.spp_rlast                                   (spp_rlast                                   ), // (u_cluster) <= (u_spp_ingress)
	.spp_rready                                  (spp_rready                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_rresp                                   (spp_rresp                                   ), // (u_cluster) <= (u_spp_ingress)
	.spp_rvalid                                  (spp_rvalid                                  ), // (u_cluster) <= (u_spp_ingress)
	.spp_wdata                                   (spp_wdata                                   ), // (u_cluster) => (u_spp_ingress)
	.spp_wlast                                   (spp_wlast                                   ), // (u_cluster) => (u_spp_ingress)
	.spp_wready                                  (spp_wready                                  ), // (u_cluster) <= (u_spp_ingress)
	.spp_wstrb                                   (spp_wstrb                                   ), // (u_cluster) => (u_spp_ingress)
	.spp_wvalid                                  (spp_wvalid                                  ), // (u_cluster) => (u_spp_ingress)
`endif // NDS_IO_SPP
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_BUS_PROTECTION
	.dcls_inject_fault_fs_bus_m_protection_error (dcls_inject_fault_fs_bus_m_protection_error ), // (u_cluster) <= ()
   `endif // NDS_IO_BUS_PROTECTION
`endif // NDS_IO_DCLS
`ifdef NDS_IO_BUS_PROTECTION
   `ifdef NDS_IO_FLASHIF0
	.flash0_araddrcode                           (cluster_flash0_araddrcode                   ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arctl0code                           (cluster_flash0_arctl0code                   ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arctl1code                           (cluster_flash0_arctl1code                   ), // (u_cluster) => (u_flash0_ingress)
	.flash0_aridcode                             (cluster_flash0_aridcode                     ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arreadycode                          (cluster_flash0_arreadycode                  ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_arutid                               (cluster_flash0_arutid                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_arvalidcode                          (cluster_flash0_arvalidcode                  ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awaddrcode                           (cluster_flash0_awaddrcode                   ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awctl0code                           (cluster_flash0_awctl0code                   ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awctl1code                           (cluster_flash0_awctl1code                   ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awidcode                             (cluster_flash0_awidcode                     ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awreadycode                          (cluster_flash0_awreadycode                  ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_awutid                               (cluster_flash0_awutid                       ), // (u_cluster) => (u_flash0_ingress)
	.flash0_awvalidcode                          (cluster_flash0_awvalidcode                  ), // (u_cluster) => (u_flash0_ingress)
	.flash0_bctlcode                             (cluster_flash0_bctlcode                     ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_bidcode                              (cluster_flash0_bidcode                      ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_breadycode                           (cluster_flash0_breadycode                   ), // (u_cluster) => (u_flash0_ingress)
	.flash0_butid                                (cluster_flash0_butid                        ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_bvalidcode                           (cluster_flash0_bvalidcode                   ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_rctlcode                             (cluster_flash0_rctlcode                     ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_rdatacode                            (cluster_flash0_rdatacode                    ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_reobi                                (cluster_flash0_reobi                        ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_ridcode                              (cluster_flash0_ridcode                      ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_rreadycode                           (cluster_flash0_rreadycode                   ), // (u_cluster) => (u_flash0_ingress)
	.flash0_rutid                                (cluster_flash0_rutid                        ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_rvalidcode                           (cluster_flash0_rvalidcode                   ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_wctlcode                             (cluster_flash0_wctlcode                     ), // (u_cluster) => (u_flash0_ingress)
	.flash0_wdatacode                            (cluster_flash0_wdatacode                    ), // (u_cluster) => (u_flash0_ingress)
	.flash0_weobi                                (cluster_flash0_weobi                        ), // (u_cluster) => (u_flash0_ingress)
	.flash0_wreadycode                           (cluster_flash0_wreadycode                   ), // (u_cluster) <= (u_flash0_ingress)
	.flash0_wutid                                (cluster_flash0_wutid                        ), // (u_cluster) => (u_flash0_ingress)
	.flash0_wvalidcode                           (cluster_flash0_wvalidcode                   ), // (u_cluster) => (u_flash0_ingress)
   `endif // NDS_IO_FLASHIF0
   `ifdef NDS_IO_SPP
	.spp_araddrcode                              (spp_araddrcode                              ), // (u_cluster) => (u_spp_ingress)
	.spp_arctl0code                              (spp_arctl0code                              ), // (u_cluster) => (u_spp_ingress)
	.spp_arctl1code                              (spp_arctl1code                              ), // (u_cluster) => (u_spp_ingress)
	.spp_aridcode                                (spp_aridcode                                ), // (u_cluster) => (u_spp_ingress)
	.spp_arreadycode                             (spp_arreadycode                             ), // (u_cluster) <= (u_spp_ingress)
	.spp_arutid                                  (spp_arutid                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_arvalidcode                             (spp_arvalidcode                             ), // (u_cluster) => (u_spp_ingress)
	.spp_awaddrcode                              (spp_awaddrcode                              ), // (u_cluster) => (u_spp_ingress)
	.spp_awctl0code                              (spp_awctl0code                              ), // (u_cluster) => (u_spp_ingress)
	.spp_awctl1code                              (spp_awctl1code                              ), // (u_cluster) => (u_spp_ingress)
	.spp_awidcode                                (spp_awidcode                                ), // (u_cluster) => (u_spp_ingress)
	.spp_awreadycode                             (spp_awreadycode                             ), // (u_cluster) <= (u_spp_ingress)
	.spp_awutid                                  (spp_awutid                                  ), // (u_cluster) => (u_spp_ingress)
	.spp_awvalidcode                             (spp_awvalidcode                             ), // (u_cluster) => (u_spp_ingress)
	.spp_bctlcode                                (spp_bctlcode                                ), // (u_cluster) <= (u_spp_ingress)
	.spp_bidcode                                 (spp_bidcode                                 ), // (u_cluster) <= (u_spp_ingress)
	.spp_breadycode                              (spp_breadycode                              ), // (u_cluster) => (u_spp_ingress)
	.spp_butid                                   (spp_butid                                   ), // (u_cluster) <= (u_spp_ingress)
	.spp_bvalidcode                              (spp_bvalidcode                              ), // (u_cluster) <= (u_spp_ingress)
	.spp_rctlcode                                (spp_rctlcode                                ), // (u_cluster) <= (u_spp_ingress)
	.spp_rdatacode                               (spp_rdatacode                               ), // (u_cluster) <= (u_spp_ingress)
	.spp_reobi                                   (spp_reobi                                   ), // (u_cluster) <= (u_spp_ingress)
	.spp_ridcode                                 (spp_ridcode                                 ), // (u_cluster) <= (u_spp_ingress)
	.spp_rreadycode                              (spp_rreadycode                              ), // (u_cluster) => (u_spp_ingress)
	.spp_rutid                                   (spp_rutid                                   ), // (u_cluster) <= (u_spp_ingress)
	.spp_rvalidcode                              (spp_rvalidcode                              ), // (u_cluster) <= (u_spp_ingress)
	.spp_wctlcode                                (spp_wctlcode                                ), // (u_cluster) => (u_spp_ingress)
	.spp_wdatacode                               (spp_wdatacode                               ), // (u_cluster) => (u_spp_ingress)
	.spp_weobi                                   (spp_weobi                                   ), // (u_cluster) => (u_spp_ingress)
	.spp_wreadycode                              (spp_wreadycode                              ), // (u_cluster) <= (u_spp_ingress)
	.spp_wutid                                   (spp_wutid                                   ), // (u_cluster) => (u_spp_ingress)
	.spp_wvalidcode                              (spp_wvalidcode                              ), // (u_cluster) => (u_spp_ingress)
   `endif // NDS_IO_SPP
`endif // NDS_IO_BUS_PROTECTION
`ifdef NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_ICACHE0
	.icache1_p_clk                               (icache1_p_clk                               ), // (u_cluster) <= ()
	.icache1_r_clk                               (icache1_r_clk                               ), // (u_cluster) <= ()
   `endif // NDS_IO_ICACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ICACHE0
   `ifdef NDS_IO_ICACHE0_CTRL_IN
	.icache_data0_ctrl_in                        ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data1_ctrl_in                        ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data2_ctrl_in                        ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data3_ctrl_in                        ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data4_ctrl_in                        ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data5_ctrl_in                        ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data6_ctrl_in                        ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data7_ctrl_in                        ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
   `endif // NDS_IO_ICACHE0_CTRL_IN
   `ifdef NDS_IO_ICACHE0_CTRL_OUT
	.icache_data0_ctrl_out                       (nds_unused_icache_data0_ctrl_out            ), // (u_cluster) => ()
	.icache_data1_ctrl_out                       (nds_unused_icache_data1_ctrl_out            ), // (u_cluster) => ()
	.icache_data2_ctrl_out                       (nds_unused_icache_data2_ctrl_out            ), // (u_cluster) => ()
	.icache_data3_ctrl_out                       (nds_unused_icache_data3_ctrl_out            ), // (u_cluster) => ()
	.icache_data4_ctrl_out                       (nds_unused_icache_data4_ctrl_out            ), // (u_cluster) => ()
	.icache_data5_ctrl_out                       (nds_unused_icache_data5_ctrl_out            ), // (u_cluster) => ()
	.icache_data6_ctrl_out                       (nds_unused_icache_data6_ctrl_out            ), // (u_cluster) => ()
	.icache_data7_ctrl_out                       (nds_unused_icache_data7_ctrl_out            ), // (u_cluster) => ()
   `endif // NDS_IO_ICACHE0_CTRL_OUT
`endif // NDS_IO_ICACHE0
`ifdef NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_DCACHE0
	.dcache1_p_clk                               (dcache1_p_clk                               ), // (u_cluster) <= ()
	.dcache1_r_clk                               (dcache1_r_clk                               ), // (u_cluster) <= ()
   `endif // NDS_IO_DCACHE0
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_DCACHE0
	.dcls_inject_fault_dcache_data0_addr         (dcls_inject_fault_dcache_data0_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data0_byte_we      (dcls_inject_fault_dcache_data0_byte_we      ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data0_cs           (dcls_inject_fault_dcache_data0_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data0_wdata        (dcls_inject_fault_dcache_data0_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data0_we           (dcls_inject_fault_dcache_data0_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data1_addr         (dcls_inject_fault_dcache_data1_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data1_byte_we      (dcls_inject_fault_dcache_data1_byte_we      ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data1_cs           (dcls_inject_fault_dcache_data1_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data1_wdata        (dcls_inject_fault_dcache_data1_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data1_we           (dcls_inject_fault_dcache_data1_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data2_addr         (dcls_inject_fault_dcache_data2_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data2_byte_we      (dcls_inject_fault_dcache_data2_byte_we      ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data2_cs           (dcls_inject_fault_dcache_data2_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data2_wdata        (dcls_inject_fault_dcache_data2_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data2_we           (dcls_inject_fault_dcache_data2_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data3_addr         (dcls_inject_fault_dcache_data3_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data3_byte_we      (dcls_inject_fault_dcache_data3_byte_we      ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data3_cs           (dcls_inject_fault_dcache_data3_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data3_wdata        (dcls_inject_fault_dcache_data3_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data3_we           (dcls_inject_fault_dcache_data3_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag0_addr          (dcls_inject_fault_dcache_tag0_addr          ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag0_cs            (dcls_inject_fault_dcache_tag0_cs            ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag0_wdata         (dcls_inject_fault_dcache_tag0_wdata         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag0_we            (dcls_inject_fault_dcache_tag0_we            ), // (u_cluster) <= ()
   `endif // NDS_IO_DCACHE0
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE0
   `ifdef NDS_IO_DCACHE0_CTRL_IN
	.dcache_tag0_ctrl_in                         ({`NDS_DCACHE_TAG_RAM_CTRL_IN_WIDTH{1'b0}}   ), // () <= ()
   `endif // NDS_IO_DCACHE0_CTRL_IN
   `ifdef NDS_IO_DCACHE0_CTRL_OUT
	.dcache_tag0_ctrl_out                        (nds_unused_dcache_tag0_ctrl_out             ), // (u_cluster) => ()
   `endif // NDS_IO_DCACHE0_CTRL_OUT
   `ifdef NDS_IO_DCACHE_CTRL_IN
	.dcache_data0_ctrl_in                        ({`NDS_DCACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.dcache_data1_ctrl_in                        ({`NDS_DCACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.dcache_data2_ctrl_in                        ({`NDS_DCACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.dcache_data3_ctrl_in                        ({`NDS_DCACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
   `endif // NDS_IO_DCACHE_CTRL_IN
   `ifdef NDS_IO_DCACHE_CTRL_OUT
	.dcache_data0_ctrl_out                       (nds_unused_dcache_data0_ctrl_out            ), // (u_cluster) => ()
	.dcache_data1_ctrl_out                       (nds_unused_dcache_data1_ctrl_out            ), // (u_cluster) => ()
	.dcache_data2_ctrl_out                       (nds_unused_dcache_data2_ctrl_out            ), // (u_cluster) => ()
	.dcache_data3_ctrl_out                       (nds_unused_dcache_data3_ctrl_out            ), // (u_cluster) => ()
   `endif // NDS_IO_DCACHE_CTRL_OUT
`endif // NDS_IO_DCACHE0
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_SLAVEPORT_COMMON_X2
	.core1_slv1_reset_n                          (core1_slvp_reset_n                          ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_arready              (dcls_inject_fault_slv1_arready              ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_awready              (dcls_inject_fault_slv1_awready              ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_bid                  (dcls_inject_fault_slv1_bid                  ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_bresp                (dcls_inject_fault_slv1_bresp                ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_bvalid               (dcls_inject_fault_slv1_bvalid               ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_rdata                (dcls_inject_fault_slv1_rdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_rid                  (dcls_inject_fault_slv1_rid                  ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_rlast                (dcls_inject_fault_slv1_rlast                ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_rresp                (dcls_inject_fault_slv1_rresp                ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_rvalid               (dcls_inject_fault_slv1_rvalid               ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_wready               (dcls_inject_fault_slv1_wready               ), // (u_cluster) <= ()
   `endif // NDS_IO_SLAVEPORT_COMMON_X2
   `ifdef NDS_IO_EDC_AFTER_ECC
	.dcls_inject_fault_fs_edc_error              (dcls_inject_fault_fs_edc_error              ), // (u_cluster) <= ()
   `endif // NDS_IO_EDC_AFTER_ECC
   `ifdef NDS_IO_LM
	.core1_lm_clk                                (core1_lm_clk                                ), // (u_cluster) <= ()
	.dcls_inject_fault_lm_local_int              (dcls_inject_fault_lm_local_int              ), // (u_cluster) <= ()
   `endif // NDS_IO_LM
   `ifdef NDS_IO_DCLS_SPLIT
	.core1_hart_id                               (64'd1                                       ), // (u_cluster) <= ()
	.core1_meiack                                (core1_meiack                                ), // (u_cluster) => ()
	.core1_meiid                                 (core1_meiid                                 ), // (u_cluster) <= ()
	.core1_meip                                  (core1_meip                                  ), // (u_cluster) <= ()
	.core1_msip                                  (hart1_msip                                  ), // (u_cluster) <= (u_plic_sw)
	.core1_mtip                                  (hart1_mtip                                  ), // (u_cluster) <= ()
	.core1_nmi                                   (core1_nmi                                   ), // (u_cluster) <= ()
	.core1_reset_vector                          (core1_reset_vector                          ), // (u_cluster) <= ()
	.core1_wfi_mode                              (core1_wfi_mode                              ), // (u_cluster) => ()
   `endif // NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_SLAVEPORT_COMMON_X1
	.core1_slv_reset_n                           (core1_slvp_reset_n                          ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_arready               (dcls_inject_fault_slv_arready               ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_awready               (dcls_inject_fault_slv_awready               ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_bid                   (dcls_inject_fault_slv_bid                   ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_bresp                 (dcls_inject_fault_slv_bresp                 ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_bvalid                (dcls_inject_fault_slv_bvalid                ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_rdata                 (dcls_inject_fault_slv_rdata                 ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_rid                   (dcls_inject_fault_slv_rid                   ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_rlast                 (dcls_inject_fault_slv_rlast                 ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_rresp                 (dcls_inject_fault_slv_rresp                 ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_rvalid                (dcls_inject_fault_slv_rvalid                ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_wready                (dcls_inject_fault_slv_wready                ), // (u_cluster) <= ()
   `endif // NDS_IO_SLAVEPORT_COMMON_X1
   `ifdef NDS_IO_SLAVEPORT_ECC_X1
	.dcls_inject_fault_fs_bus_s_protection_error (dcls_inject_fault_fs_bus_s_protection_error ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_arreadycode           (dcls_inject_fault_slv_arreadycode           ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_awreadycode           (dcls_inject_fault_slv_awreadycode           ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_bctlcode              (dcls_inject_fault_slv_bctlcode              ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_bidcode               (dcls_inject_fault_slv_bidcode               ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_butid                 (dcls_inject_fault_slv_butid                 ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_bvalidcode            (dcls_inject_fault_slv_bvalidcode            ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_rctlcode              (dcls_inject_fault_slv_rctlcode              ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_rdatacode             (dcls_inject_fault_slv_rdatacode             ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_reobi                 (dcls_inject_fault_slv_reobi                 ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_ridcode               (dcls_inject_fault_slv_ridcode               ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_rutid                 (dcls_inject_fault_slv_rutid                 ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_rvalidcode            (dcls_inject_fault_slv_rvalidcode            ), // (u_cluster) <= ()
	.dcls_inject_fault_slv_wreadycode            (dcls_inject_fault_slv_wreadycode            ), // (u_cluster) <= ()
   `endif // NDS_IO_SLAVEPORT_ECC_X1
   `ifdef NDS_IO_SLAVEPORT_ECC_X2
	.dcls_inject_fault_fs_bus_s1_protection_error(dcls_inject_fault_fs_bus_s1_protection_error), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_arreadycode          (dcls_inject_fault_slv1_arreadycode          ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_awreadycode          (dcls_inject_fault_slv1_awreadycode          ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_bctlcode             (dcls_inject_fault_slv1_bctlcode             ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_bidcode              (dcls_inject_fault_slv1_bidcode              ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_butid                (dcls_inject_fault_slv1_butid                ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_bvalidcode           (dcls_inject_fault_slv1_bvalidcode           ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_rctlcode             (dcls_inject_fault_slv1_rctlcode             ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_rdatacode            (dcls_inject_fault_slv1_rdatacode            ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_reobi                (dcls_inject_fault_slv1_reobi                ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_ridcode              (dcls_inject_fault_slv1_ridcode              ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_rutid                (dcls_inject_fault_slv1_rutid                ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_rvalidcode           (dcls_inject_fault_slv1_rvalidcode           ), // (u_cluster) <= ()
	.dcls_inject_fault_slv1_wreadycode           (dcls_inject_fault_slv1_wreadycode           ), // (u_cluster) <= ()
   `endif // NDS_IO_SLAVEPORT_ECC_X2
   `ifdef NDS_TRACE_TILELINK
	.dcls_inject_fault_trace_dcu_cmt_addr        (dcls_inject_fault_trace_dcu_cmt_addr        ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_dcu_cmt_func        (dcls_inject_fault_trace_dcu_cmt_func        ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_dcu_cmt_valid       (dcls_inject_fault_trace_dcu_cmt_valid       ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_dcu_cmt_wdata       (dcls_inject_fault_trace_dcu_cmt_wdata       ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_i0_wb_alive         (dcls_inject_fault_trace_i0_wb_alive         ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_i0_wb_pc            (dcls_inject_fault_trace_i0_wb_pc            ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_i1_wb_alive         (dcls_inject_fault_trace_i1_wb_alive         ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_i1_wb_pc            (dcls_inject_fault_trace_i1_wb_pc            ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_ls_i0_instr         (dcls_inject_fault_trace_ls_i0_instr         ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_ls_i0_pc            (dcls_inject_fault_trace_ls_i0_pc            ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_sb_va               (dcls_inject_fault_trace_sb_va               ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_wb_cause            (dcls_inject_fault_trace_wb_cause            ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_wb_xcpt             (dcls_inject_fault_trace_wb_xcpt             ), // (u_cluster) <= ()
   `endif // NDS_TRACE_TILELINK
   `ifdef NDS_IO_LM_RESET
	.dcls_inject_fault_lm_reset_n                (dcls_inject_fault_lm_reset_n                ), // (u_cluster) <= ()
   `endif // NDS_IO_LM_RESET
   `ifdef NDS_IO_ILM_TL_UL
	.dcls_inject_fault_ilm_a_addr                (dcls_inject_fault_ilm_a_addr                ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm_a_data                (dcls_inject_fault_ilm_a_data                ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm_a_mask                (dcls_inject_fault_ilm_a_mask                ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm_a_opcode              (dcls_inject_fault_ilm_a_opcode              ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm_a_parity0             (dcls_inject_fault_ilm_a_parity0             ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm_a_parity1             (dcls_inject_fault_ilm_a_parity1             ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm_a_size                (dcls_inject_fault_ilm_a_size                ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm_a_user                (dcls_inject_fault_ilm_a_user                ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm_a_valid               (dcls_inject_fault_ilm_a_valid               ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm_d_ready               (dcls_inject_fault_ilm_d_ready               ), // (u_cluster) <= ()
   `endif // NDS_IO_ILM_TL_UL
   `ifdef NDS_IO_DLM_TL_UL
	.dcls_inject_fault_dlm_a_addr                (dcls_inject_fault_dlm_a_addr                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_a_data                (dcls_inject_fault_dlm_a_data                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_a_mask                (dcls_inject_fault_dlm_a_mask                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_a_opcode              (dcls_inject_fault_dlm_a_opcode              ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_a_parity              (dcls_inject_fault_dlm_a_parity              ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_a_size                (dcls_inject_fault_dlm_a_size                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_a_user                (dcls_inject_fault_dlm_a_user                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_a_valid               (dcls_inject_fault_dlm_a_valid               ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_d_ready               (dcls_inject_fault_dlm_d_ready               ), // (u_cluster) <= ()
   `endif // NDS_IO_DLM_TL_UL
   `ifdef NDS_IO_ICACHE0
	.dcls_inject_fault_icache_data0_addr         (dcls_inject_fault_icache_data0_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data0_cs           (dcls_inject_fault_icache_data0_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data0_wdata        (dcls_inject_fault_icache_data0_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data0_we           (dcls_inject_fault_icache_data0_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data1_addr         (dcls_inject_fault_icache_data1_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data1_cs           (dcls_inject_fault_icache_data1_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data1_wdata        (dcls_inject_fault_icache_data1_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data1_we           (dcls_inject_fault_icache_data1_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data2_addr         (dcls_inject_fault_icache_data2_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data2_cs           (dcls_inject_fault_icache_data2_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data2_wdata        (dcls_inject_fault_icache_data2_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data2_we           (dcls_inject_fault_icache_data2_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data3_addr         (dcls_inject_fault_icache_data3_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data3_cs           (dcls_inject_fault_icache_data3_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data3_wdata        (dcls_inject_fault_icache_data3_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data3_we           (dcls_inject_fault_icache_data3_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data4_addr         (dcls_inject_fault_icache_data4_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data4_cs           (dcls_inject_fault_icache_data4_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data4_wdata        (dcls_inject_fault_icache_data4_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data4_we           (dcls_inject_fault_icache_data4_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data5_addr         (dcls_inject_fault_icache_data5_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data5_cs           (dcls_inject_fault_icache_data5_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data5_wdata        (dcls_inject_fault_icache_data5_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data5_we           (dcls_inject_fault_icache_data5_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data6_addr         (dcls_inject_fault_icache_data6_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data6_cs           (dcls_inject_fault_icache_data6_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data6_wdata        (dcls_inject_fault_icache_data6_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data6_we           (dcls_inject_fault_icache_data6_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data7_addr         (dcls_inject_fault_icache_data7_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data7_cs           (dcls_inject_fault_icache_data7_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data7_wdata        (dcls_inject_fault_icache_data7_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data7_we           (dcls_inject_fault_icache_data7_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag0_addr          (dcls_inject_fault_icache_tag0_addr          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag0_cs            (dcls_inject_fault_icache_tag0_cs            ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag0_wdata         (dcls_inject_fault_icache_tag0_wdata         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag0_we            (dcls_inject_fault_icache_tag0_we            ), // (u_cluster) <= ()
   `endif // NDS_IO_ICACHE0
   `ifdef NDS_IO_PROBING
	.dcls_inject_fault_current_pc                (dcls_inject_fault_current_pc                ), // (u_cluster) <= ()
	.dcls_inject_fault_selected_gpr_value        (dcls_inject_fault_selected_gpr_value        ), // (u_cluster) <= ()
   `endif // NDS_IO_PROBING
   `ifdef NDS_IO_SEIP
	.dcls_inject_fault_seiack                    (dcls_inject_fault_seiack                    ), // (u_cluster) <= ()
   `endif // NDS_IO_SEIP
   `ifdef NDS_IO_UEIP
	.dcls_inject_fault_ueiack                    (dcls_inject_fault_ueiack                    ), // (u_cluster) <= ()
   `endif // NDS_IO_UEIP
   `ifdef NDS_IO_DEBUG
	.dcls_inject_fault_hart_halted               (dcls_inject_fault_hart_halted               ), // (u_cluster) <= ()
	.dcls_inject_fault_hart_unavail              (dcls_inject_fault_hart_unavail              ), // (u_cluster) <= ()
	.dcls_inject_fault_hart_under_reset          (dcls_inject_fault_hart_under_reset          ), // (u_cluster) <= ()
	.dcls_inject_fault_stoptime                  (dcls_inject_fault_stoptime                  ), // (u_cluster) <= ()
   `endif // NDS_IO_DEBUG
   `ifdef NDS_IO_TRACE_INSTR_GEN1
	.dcls_inject_fault_gen1_trace_cause          (dcls_inject_fault_gen1_trace_cause          ), // (u_cluster) <= ()
	.dcls_inject_fault_gen1_trace_iaddr          (dcls_inject_fault_gen1_trace_iaddr          ), // (u_cluster) <= ()
	.dcls_inject_fault_gen1_trace_iexception     (dcls_inject_fault_gen1_trace_iexception     ), // (u_cluster) <= ()
	.dcls_inject_fault_gen1_trace_instr          (dcls_inject_fault_gen1_trace_instr          ), // (u_cluster) <= ()
	.dcls_inject_fault_gen1_trace_interrupt      (dcls_inject_fault_gen1_trace_interrupt      ), // (u_cluster) <= ()
	.dcls_inject_fault_gen1_trace_ivalid         (dcls_inject_fault_gen1_trace_ivalid         ), // (u_cluster) <= ()
	.dcls_inject_fault_gen1_trace_priv           (dcls_inject_fault_gen1_trace_priv           ), // (u_cluster) <= ()
	.dcls_inject_fault_gen1_trace_tval           (dcls_inject_fault_gen1_trace_tval           ), // (u_cluster) <= ()
   `endif // NDS_IO_TRACE_INSTR_GEN1
   `ifdef NDS_IO_TRACE_INSTR
	.dcls_inject_fault_trace_cause               (dcls_inject_fault_trace_cause               ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_context             (dcls_inject_fault_trace_context             ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_ctype               (dcls_inject_fault_trace_ctype               ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_halted              (dcls_inject_fault_trace_halted              ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_iaddr               (dcls_inject_fault_trace_iaddr               ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_ilastsize           (dcls_inject_fault_trace_ilastsize           ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_iretire             (dcls_inject_fault_trace_iretire             ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_itype               (dcls_inject_fault_trace_itype               ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_priv                (dcls_inject_fault_trace_priv                ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_reset               (dcls_inject_fault_trace_reset               ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_trigger             (dcls_inject_fault_trace_trigger             ), // (u_cluster) <= ()
	.dcls_inject_fault_trace_tval                (dcls_inject_fault_trace_tval                ), // (u_cluster) <= ()
   `endif // NDS_IO_TRACE_INSTR
   `ifdef NDS_IO_TRAP_STATUS
	.dcls_inject_fault_fs_halt_mode              (dcls_inject_fault_fs_halt_mode              ), // (u_cluster) <= ()
	.dcls_inject_fault_fs_trap_status_cause      (dcls_inject_fault_fs_trap_status_cause      ), // (u_cluster) <= ()
	.dcls_inject_fault_fs_trap_status_dcause     (dcls_inject_fault_fs_trap_status_dcause     ), // (u_cluster) <= ()
	.dcls_inject_fault_fs_trap_status_interrupt  (dcls_inject_fault_fs_trap_status_interrupt  ), // (u_cluster) <= ()
	.dcls_inject_fault_fs_trap_status_nmi        (dcls_inject_fault_fs_trap_status_nmi        ), // (u_cluster) <= ()
	.dcls_inject_fault_fs_trap_status_taken      (dcls_inject_fault_fs_trap_status_taken      ), // (u_cluster) <= ()
   `endif // NDS_IO_TRAP_STATUS
   `ifdef NDS_IO_PPI
	.dcls_inject_fault_ppi_araddr                (dcls_inject_fault_ppi_araddr                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arburst               (dcls_inject_fault_ppi_arburst               ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arcache               (dcls_inject_fault_ppi_arcache               ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arid                  (dcls_inject_fault_ppi_arid                  ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arlen                 (dcls_inject_fault_ppi_arlen                 ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arlock                (dcls_inject_fault_ppi_arlock                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arprot                (dcls_inject_fault_ppi_arprot                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arsize                (dcls_inject_fault_ppi_arsize                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arvalid               (dcls_inject_fault_ppi_arvalid               ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awaddr                (dcls_inject_fault_ppi_awaddr                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awburst               (dcls_inject_fault_ppi_awburst               ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awcache               (dcls_inject_fault_ppi_awcache               ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awid                  (dcls_inject_fault_ppi_awid                  ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awlen                 (dcls_inject_fault_ppi_awlen                 ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awlock                (dcls_inject_fault_ppi_awlock                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awprot                (dcls_inject_fault_ppi_awprot                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awsize                (dcls_inject_fault_ppi_awsize                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awvalid               (dcls_inject_fault_ppi_awvalid               ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_bready                (dcls_inject_fault_ppi_bready                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_rready                (dcls_inject_fault_ppi_rready                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_wdata                 (dcls_inject_fault_ppi_wdata                 ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_wlast                 (dcls_inject_fault_ppi_wlast                 ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_wstrb                 (dcls_inject_fault_ppi_wstrb                 ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_wvalid                (dcls_inject_fault_ppi_wvalid                ), // (u_cluster) <= ()
   `endif // NDS_IO_PPI
   `ifdef NDS_IO_PPI_PROT
	.dcls_inject_fault_ppi_araddrcode            (dcls_inject_fault_ppi_araddrcode            ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arctl0code            (dcls_inject_fault_ppi_arctl0code            ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arctl1code            (dcls_inject_fault_ppi_arctl1code            ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_aridcode              (dcls_inject_fault_ppi_aridcode              ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arutid                (dcls_inject_fault_ppi_arutid                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_arvalidcode           (dcls_inject_fault_ppi_arvalidcode           ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awaddrcode            (dcls_inject_fault_ppi_awaddrcode            ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awctl0code            (dcls_inject_fault_ppi_awctl0code            ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awctl1code            (dcls_inject_fault_ppi_awctl1code            ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awidcode              (dcls_inject_fault_ppi_awidcode              ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awutid                (dcls_inject_fault_ppi_awutid                ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_awvalidcode           (dcls_inject_fault_ppi_awvalidcode           ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_breadycode            (dcls_inject_fault_ppi_breadycode            ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_rreadycode            (dcls_inject_fault_ppi_rreadycode            ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_wctlcode              (dcls_inject_fault_ppi_wctlcode              ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_wdatacode             (dcls_inject_fault_ppi_wdatacode             ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_weobi                 (dcls_inject_fault_ppi_weobi                 ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_wutid                 (dcls_inject_fault_ppi_wutid                 ), // (u_cluster) <= ()
	.dcls_inject_fault_ppi_wvalidcode            (dcls_inject_fault_ppi_wvalidcode            ), // (u_cluster) <= ()
   `endif // NDS_IO_PPI_PROT
   `ifdef NDS_IO_ILM_RAM0
	.dcls_inject_fault_ilm0_addr                 (dcls_inject_fault_ilm0_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm0_byte_we              (dcls_inject_fault_ilm0_byte_we              ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm0_cs                   (dcls_inject_fault_ilm0_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm0_wdata                (dcls_inject_fault_ilm0_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm0_we                   (dcls_inject_fault_ilm0_we                   ), // (u_cluster) <= ()
   `endif // NDS_IO_ILM_RAM0
   `ifdef NDS_IO_ILM_RAM1
	.dcls_inject_fault_ilm1_addr                 (dcls_inject_fault_ilm1_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm1_byte_we              (dcls_inject_fault_ilm1_byte_we              ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm1_cs                   (dcls_inject_fault_ilm1_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm1_wdata                (dcls_inject_fault_ilm1_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm1_we                   (dcls_inject_fault_ilm1_we                   ), // (u_cluster) <= ()
   `endif // NDS_IO_ILM_RAM1
   `ifdef NDS_IO_DLM_RAM0
	.dcls_inject_fault_dlm_addr                  (dcls_inject_fault_dlm_addr                  ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_byte_we               (dcls_inject_fault_dlm_byte_we               ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_cs                    (dcls_inject_fault_dlm_cs                    ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_wdata                 (dcls_inject_fault_dlm_wdata                 ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm_we                    (dcls_inject_fault_dlm_we                    ), // (u_cluster) <= ()
   `endif // NDS_IO_DLM_RAM0
   `ifdef NDS_IO_DLM_RAM1
	.dcls_inject_fault_dlm1_addr                 (dcls_inject_fault_dlm1_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm1_byte_we              (dcls_inject_fault_dlm1_byte_we              ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm1_cs                   (dcls_inject_fault_dlm1_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm1_wdata                (dcls_inject_fault_dlm1_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm1_we                   (dcls_inject_fault_dlm1_we                   ), // (u_cluster) <= ()
   `endif // NDS_IO_DLM_RAM1
   `ifdef NDS_IO_DLM_RAM2
	.dcls_inject_fault_dlm2_addr                 (dcls_inject_fault_dlm2_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm2_byte_we              (dcls_inject_fault_dlm2_byte_we              ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm2_cs                   (dcls_inject_fault_dlm2_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm2_wdata                (dcls_inject_fault_dlm2_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm2_we                   (dcls_inject_fault_dlm2_we                   ), // (u_cluster) <= ()
   `endif // NDS_IO_DLM_RAM2
   `ifdef NDS_IO_DLM_RAM3
	.dcls_inject_fault_dlm3_addr                 (dcls_inject_fault_dlm3_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm3_byte_we              (dcls_inject_fault_dlm3_byte_we              ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm3_cs                   (dcls_inject_fault_dlm3_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm3_wdata                (dcls_inject_fault_dlm3_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm3_we                   (dcls_inject_fault_dlm3_we                   ), // (u_cluster) <= ()
   `endif // NDS_IO_DLM_RAM3
   `ifdef NDS_IO_ICACHE1
	.dcls_inject_fault_icache_tag1_addr          (dcls_inject_fault_icache_tag1_addr          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag1_cs            (dcls_inject_fault_icache_tag1_cs            ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag1_wdata         (dcls_inject_fault_icache_tag1_wdata         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag1_we            (dcls_inject_fault_icache_tag1_we            ), // (u_cluster) <= ()
   `endif // NDS_IO_ICACHE1
   `ifdef NDS_IO_ICACHE2
	.dcls_inject_fault_icache_tag2_addr          (dcls_inject_fault_icache_tag2_addr          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag2_cs            (dcls_inject_fault_icache_tag2_cs            ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag2_wdata         (dcls_inject_fault_icache_tag2_wdata         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag2_we            (dcls_inject_fault_icache_tag2_we            ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag3_addr          (dcls_inject_fault_icache_tag3_addr          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag3_cs            (dcls_inject_fault_icache_tag3_cs            ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag3_wdata         (dcls_inject_fault_icache_tag3_wdata         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_tag3_we            (dcls_inject_fault_icache_tag3_we            ), // (u_cluster) <= ()
   `endif // NDS_IO_ICACHE2
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_BTB_RAM_CTRL_IN
	.core1_btb0_ctrl_in                          ({`NDS_BTB_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
	.core1_btb1_ctrl_in                          ({`NDS_BTB_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
   `endif // NDS_IO_BTB_RAM_CTRL_IN
   `ifdef NDS_IO_BTB_RAM_CTRL_OUT
	.core1_btb0_ctrl_out                         (nds_unused_core1_btb0_ctrl_out              ), // (u_cluster) => ()
	.core1_btb1_ctrl_out                         (nds_unused_core1_btb1_ctrl_out              ), // (u_cluster) => ()
   `endif // NDS_IO_BTB_RAM_CTRL_OUT
   `ifdef NDS_IO_BTB2_RAM_CTRL_IN
	.core1_btb2_ctrl_in                          ({`NDS_BTB_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
   `endif // NDS_IO_BTB2_RAM_CTRL_IN
   `ifdef NDS_IO_BTB2_RAM_CTRL_OUT
	.core1_btb2_ctrl_out                         (nds_unused_core1_btb2_ctrl_out              ), // (u_cluster) => ()
   `endif // NDS_IO_BTB2_RAM_CTRL_OUT
   `ifdef NDS_IO_BTB3_RAM_CTRL_IN
	.core1_btb3_ctrl_in                          ({`NDS_BTB_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
   `endif // NDS_IO_BTB3_RAM_CTRL_IN
   `ifdef NDS_IO_BTB3_RAM_CTRL_OUT
	.core1_btb3_ctrl_out                         (nds_unused_core1_btb3_ctrl_out              ), // (u_cluster) => ()
   `endif // NDS_IO_BTB3_RAM_CTRL_OUT
`endif // NDS_IO_DCLS_SPLIT
`ifdef NDS_IO_ILM_RAM0
   `ifdef NDS_IO_ILM_RAM0_CTRL_IN
	.ilm0_ctrl_in                                ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
   `endif // NDS_IO_ILM_RAM0_CTRL_IN
   `ifdef NDS_IO_ILM_RAM0_CTRL_OUT
	.ilm0_ctrl_out                               (nds_unused_ilm0_ctrl_out                    ), // (u_cluster) => ()
   `endif // NDS_IO_ILM_RAM0_CTRL_OUT
`endif // NDS_IO_ILM_RAM0
`ifdef NDS_IO_ILM_RAM1
   `ifdef NDS_IO_ILM_RAM1_CTRL_IN
	.ilm1_ctrl_in                                ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
   `endif // NDS_IO_ILM_RAM1_CTRL_IN
   `ifdef NDS_IO_ILM_RAM1_CTRL_OUT
	.ilm1_ctrl_out                               (nds_unused_ilm1_ctrl_out                    ), // (u_cluster) => ()
   `endif // NDS_IO_ILM_RAM1_CTRL_OUT
`endif // NDS_IO_ILM_RAM1
`ifdef NDS_IO_DLM_RAM0
   `ifdef NDS_IO_DLM_RAM0_CTRL_IN
	.dlm_ctrl_in                                 ({`NDS_DLM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
   `endif // NDS_IO_DLM_RAM0_CTRL_IN
   `ifdef NDS_IO_DLM_RAM0_CTRL_OUT
	.dlm_ctrl_out                                (nds_unused_dlm_ctrl_out                     ), // (u_cluster) => ()
   `endif // NDS_IO_DLM_RAM0_CTRL_OUT
`endif // NDS_IO_DLM_RAM0
`ifdef NDS_IO_DLM_RAM1
   `ifdef NDS_IO_DLM_RAM1_CTRL_IN
	.dlm1_ctrl_in                                ({`NDS_DLM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
   `endif // NDS_IO_DLM_RAM1_CTRL_IN
   `ifdef NDS_IO_DLM_RAM1_CTRL_OUT
	.dlm1_ctrl_out                               (nds_unused_dlm1_ctrl_out                    ), // (u_cluster) => ()
   `endif // NDS_IO_DLM_RAM1_CTRL_OUT
`endif // NDS_IO_DLM_RAM1
`ifdef NDS_IO_DLM_RAM2
   `ifdef NDS_IO_DLM_RAM2_CTRL_IN
	.dlm2_ctrl_in                                ({`NDS_DLM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
   `endif // NDS_IO_DLM_RAM2_CTRL_IN
   `ifdef NDS_IO_DLM_RAM2_CTRL_OUT
	.dlm2_ctrl_out                               (nds_unused_dlm2_ctrl_out                    ), // (u_cluster) => ()
   `endif // NDS_IO_DLM_RAM2_CTRL_OUT
`endif // NDS_IO_DLM_RAM2
`ifdef NDS_IO_DLM_RAM3
   `ifdef NDS_IO_DLM_RAM3_CTRL_IN
	.dlm3_ctrl_in                                ({`NDS_DLM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
   `endif // NDS_IO_DLM_RAM3_CTRL_IN
   `ifdef NDS_IO_DLM_RAM3_CTRL_OUT
	.dlm3_ctrl_out                               (nds_unused_dlm3_ctrl_out                    ), // (u_cluster) => ()
   `endif // NDS_IO_DLM_RAM3_CTRL_OUT
`endif // NDS_IO_DLM_RAM3
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_BTB_RAM
	.dcls_inject_fault_btb0_addr                 (dcls_inject_fault_btb0_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_btb0_cs                   (dcls_inject_fault_btb0_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_btb0_wdata                (dcls_inject_fault_btb0_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_btb0_we                   (dcls_inject_fault_btb0_we                   ), // (u_cluster) <= ()
	.dcls_inject_fault_btb1_addr                 (dcls_inject_fault_btb1_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_btb1_cs                   (dcls_inject_fault_btb1_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_btb1_wdata                (dcls_inject_fault_btb1_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_btb1_we                   (dcls_inject_fault_btb1_we                   ), // (u_cluster) <= ()
   `endif // NDS_IO_BTB_RAM
   `ifdef NDS_IO_BTB2_RAM
	.dcls_inject_fault_btb2_addr                 (dcls_inject_fault_btb2_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_btb2_cs                   (dcls_inject_fault_btb2_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_btb2_wdata                (dcls_inject_fault_btb2_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_btb2_we                   (dcls_inject_fault_btb2_we                   ), // (u_cluster) <= ()
   `endif // NDS_IO_BTB2_RAM
   `ifdef NDS_IO_BTB3_RAM
	.dcls_inject_fault_btb3_addr                 (dcls_inject_fault_btb3_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_btb3_cs                   (dcls_inject_fault_btb3_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_btb3_wdata                (dcls_inject_fault_btb3_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_btb3_we                   (dcls_inject_fault_btb3_we                   ), // (u_cluster) <= ()
   `endif // NDS_IO_BTB3_RAM
   `ifdef NDS_IO_DCACHE1
	.dcls_inject_fault_dcache_tag1_addr          (dcls_inject_fault_dcache_tag1_addr          ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag1_cs            (dcls_inject_fault_dcache_tag1_cs            ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag1_wdata         (dcls_inject_fault_dcache_tag1_wdata         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag1_we            (dcls_inject_fault_dcache_tag1_we            ), // (u_cluster) <= ()
   `endif // NDS_IO_DCACHE1
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE1
   `ifdef NDS_IO_DCACHE1_CTRL_IN
	.dcache_tag1_ctrl_in                         ({`NDS_DCACHE_TAG_RAM_CTRL_IN_WIDTH{1'b0}}   ), // () <= ()
   `endif // NDS_IO_DCACHE1_CTRL_IN
   `ifdef NDS_IO_DCACHE1_CTRL_OUT
	.dcache_tag1_ctrl_out                        (nds_unused_dcache_tag1_ctrl_out             ), // (u_cluster) => ()
   `endif // NDS_IO_DCACHE1_CTRL_OUT
`endif // NDS_IO_DCACHE1
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_DCACHE2
	.dcls_inject_fault_dcache_tag2_addr          (dcls_inject_fault_dcache_tag2_addr          ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag2_cs            (dcls_inject_fault_dcache_tag2_cs            ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag2_wdata         (dcls_inject_fault_dcache_tag2_wdata         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag2_we            (dcls_inject_fault_dcache_tag2_we            ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag3_addr          (dcls_inject_fault_dcache_tag3_addr          ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag3_cs            (dcls_inject_fault_dcache_tag3_cs            ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag3_wdata         (dcls_inject_fault_dcache_tag3_wdata         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_tag3_we            (dcls_inject_fault_dcache_tag3_we            ), // (u_cluster) <= ()
   `endif // NDS_IO_DCACHE2
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCACHE2
   `ifdef NDS_IO_DCACHE2_CTRL_IN
	.dcache_tag2_ctrl_in                         ({`NDS_DCACHE_TAG_RAM_CTRL_IN_WIDTH{1'b0}}   ), // () <= ()
	.dcache_tag3_ctrl_in                         ({`NDS_DCACHE_TAG_RAM_CTRL_IN_WIDTH{1'b0}}   ), // () <= ()
   `endif // NDS_IO_DCACHE2_CTRL_IN
   `ifdef NDS_IO_DCACHE2_CTRL_OUT
	.dcache_tag2_ctrl_out                        (nds_unused_dcache_tag2_ctrl_out             ), // (u_cluster) => ()
	.dcache_tag3_ctrl_out                        (nds_unused_dcache_tag3_ctrl_out             ), // (u_cluster) => ()
   `endif // NDS_IO_DCACHE2_CTRL_OUT
`endif // NDS_IO_DCACHE2
`ifdef NDS_IO_DCLS
   `ifdef NDS_IO_DCLS_SPLIT
      `ifdef NDS_IO_BUS_PROTECTION
	.core1_cfg_timeout_flash0                    (core1_cfg_timeout_flash0                    ), // (u_cluster) <= ()
	.core1_cfg_timeout_ppi                       (core1_cfg_timeout_ppi                       ), // (u_cluster) <= ()
	.core1_cfg_timeout_spp                       (core1_cfg_timeout_spp                       ), // (u_cluster) <= ()
	.core1_cfg_timeout_sys0                      (core1_cfg_timeout_sys0                      ), // (u_cluster) <= ()
	.core1_fs_bus_m_protection_error             (core1_fs_bus_m_protection_error             ), // (u_cluster) => ()
      `endif // NDS_IO_BUS_PROTECTION
   `endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DCLS
`ifdef NDS_IO_DCLS_SPLIT
   `ifdef NDS_IO_ICACHE0
      `ifdef NDS_IO_ICACHE0_CTRL_IN
	.icache_data10_ctrl_in                       ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data11_ctrl_in                       ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data12_ctrl_in                       ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data13_ctrl_in                       ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data14_ctrl_in                       ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data15_ctrl_in                       ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data8_ctrl_in                        ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.icache_data9_ctrl_in                        ({`NDS_ICACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
      `endif // NDS_IO_ICACHE0_CTRL_IN
      `ifdef NDS_IO_ICACHE0_CTRL_OUT
	.icache_data10_ctrl_out                      (nds_unused_icache_data10_ctrl_out           ), // (u_cluster) => ()
	.icache_data11_ctrl_out                      (nds_unused_icache_data11_ctrl_out           ), // (u_cluster) => ()
	.icache_data12_ctrl_out                      (nds_unused_icache_data12_ctrl_out           ), // (u_cluster) => ()
	.icache_data13_ctrl_out                      (nds_unused_icache_data13_ctrl_out           ), // (u_cluster) => ()
	.icache_data14_ctrl_out                      (nds_unused_icache_data14_ctrl_out           ), // (u_cluster) => ()
	.icache_data15_ctrl_out                      (nds_unused_icache_data15_ctrl_out           ), // (u_cluster) => ()
	.icache_data8_ctrl_out                       (nds_unused_icache_data8_ctrl_out            ), // (u_cluster) => ()
	.icache_data9_ctrl_out                       (nds_unused_icache_data9_ctrl_out            ), // (u_cluster) => ()
      `endif // NDS_IO_ICACHE0_CTRL_OUT
   `endif // NDS_IO_ICACHE0
   `ifdef NDS_IO_ILM_RAM0
      `ifdef NDS_IO_ILM_RAM0_CTRL_IN
	.ilm2_ctrl_in                                ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
      `endif // NDS_IO_ILM_RAM0_CTRL_IN
      `ifdef NDS_IO_ILM_RAM0_CTRL_OUT
	.ilm2_ctrl_out                               (nds_unused_ilm2_ctrl_out                    ), // (u_cluster) => ()
      `endif // NDS_IO_ILM_RAM0_CTRL_OUT
   `endif // NDS_IO_ILM_RAM0
   `ifdef NDS_IO_ILM_RAM1
      `ifdef NDS_IO_ILM_RAM1_CTRL_IN
	.ilm3_ctrl_in                                ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
      `endif // NDS_IO_ILM_RAM1_CTRL_IN
      `ifdef NDS_IO_ILM_RAM1_CTRL_OUT
	.ilm3_ctrl_out                               (nds_unused_ilm3_ctrl_out                    ), // (u_cluster) => ()
      `endif // NDS_IO_ILM_RAM1_CTRL_OUT
   `endif // NDS_IO_ILM_RAM1
   `ifdef NDS_IO_DLM_RAM0
      `ifdef NDS_IO_DLM_RAM0_CTRL_IN
	.dlm4_ctrl_in                                ({`NDS_DLM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
      `endif // NDS_IO_DLM_RAM0_CTRL_IN
      `ifdef NDS_IO_DLM_RAM0_CTRL_OUT
	.dlm4_ctrl_out                               (nds_unused_dlm4_ctrl_out                    ), // (u_cluster) => ()
      `endif // NDS_IO_DLM_RAM0_CTRL_OUT
   `endif // NDS_IO_DLM_RAM0
   `ifdef NDS_IO_DLM_RAM1
      `ifdef NDS_IO_DLM_RAM1_CTRL_IN
	.dlm5_ctrl_in                                ({`NDS_DLM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
      `endif // NDS_IO_DLM_RAM1_CTRL_IN
      `ifdef NDS_IO_DLM_RAM1_CTRL_OUT
	.dlm5_ctrl_out                               (nds_unused_dlm5_ctrl_out                    ), // (u_cluster) => ()
      `endif // NDS_IO_DLM_RAM1_CTRL_OUT
   `endif // NDS_IO_DLM_RAM1
   `ifdef NDS_IO_DLM_RAM2
      `ifdef NDS_IO_DLM_RAM2_CTRL_IN
	.dlm6_ctrl_in                                ({`NDS_DLM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
      `endif // NDS_IO_DLM_RAM2_CTRL_IN
      `ifdef NDS_IO_DLM_RAM2_CTRL_OUT
	.dlm6_ctrl_out                               (nds_unused_dlm6_ctrl_out                    ), // (u_cluster) => ()
      `endif // NDS_IO_DLM_RAM2_CTRL_OUT
   `endif // NDS_IO_DLM_RAM2
   `ifdef NDS_IO_DLM_RAM3
      `ifdef NDS_IO_DLM_RAM3_CTRL_IN
	.dlm7_ctrl_in                                ({`NDS_DLM_RAM_CTRL_IN_WIDTH{1'b0}}          ), // () <= ()
      `endif // NDS_IO_DLM_RAM3_CTRL_IN
      `ifdef NDS_IO_DLM_RAM3_CTRL_OUT
	.dlm7_ctrl_out                               (nds_unused_dlm7_ctrl_out                    ), // (u_cluster) => ()
      `endif // NDS_IO_DLM_RAM3_CTRL_OUT
   `endif // NDS_IO_DLM_RAM3
   `ifdef NDS_IO_DCLS
      `ifdef NDS_IO_DCACHE0
	.core1_dcache_disable_init                   (core1_dcache_disable_init                   ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data4_addr         (dcls_inject_fault_dcache_data4_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data4_byte_we      (dcls_inject_fault_dcache_data4_byte_we      ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data4_cs           (dcls_inject_fault_dcache_data4_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data4_wdata        (dcls_inject_fault_dcache_data4_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data4_we           (dcls_inject_fault_dcache_data4_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data5_addr         (dcls_inject_fault_dcache_data5_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data5_byte_we      (dcls_inject_fault_dcache_data5_byte_we      ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data5_cs           (dcls_inject_fault_dcache_data5_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data5_wdata        (dcls_inject_fault_dcache_data5_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data5_we           (dcls_inject_fault_dcache_data5_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data6_addr         (dcls_inject_fault_dcache_data6_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data6_byte_we      (dcls_inject_fault_dcache_data6_byte_we      ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data6_cs           (dcls_inject_fault_dcache_data6_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data6_wdata        (dcls_inject_fault_dcache_data6_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data6_we           (dcls_inject_fault_dcache_data6_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data7_addr         (dcls_inject_fault_dcache_data7_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data7_byte_we      (dcls_inject_fault_dcache_data7_byte_we      ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data7_cs           (dcls_inject_fault_dcache_data7_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data7_wdata        (dcls_inject_fault_dcache_data7_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_dcache_data7_we           (dcls_inject_fault_dcache_data7_we           ), // (u_cluster) <= ()
      `endif // NDS_IO_DCACHE0
   `endif // NDS_IO_DCLS
   `ifdef NDS_IO_DCACHE0
      `ifdef NDS_IO_DCACHE_CTRL_IN
	.dcache_data4_ctrl_in                        ({`NDS_DCACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.dcache_data5_ctrl_in                        ({`NDS_DCACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.dcache_data6_ctrl_in                        ({`NDS_DCACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
	.dcache_data7_ctrl_in                        ({`NDS_DCACHE_DATA_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
      `endif // NDS_IO_DCACHE_CTRL_IN
      `ifdef NDS_IO_DCACHE_CTRL_OUT
	.dcache_data4_ctrl_out                       (nds_unused_dcache_data4_ctrl_out            ), // (u_cluster) => ()
	.dcache_data5_ctrl_out                       (nds_unused_dcache_data5_ctrl_out            ), // (u_cluster) => ()
	.dcache_data6_ctrl_out                       (nds_unused_dcache_data6_ctrl_out            ), // (u_cluster) => ()
	.dcache_data7_ctrl_out                       (nds_unused_dcache_data7_ctrl_out            ), // (u_cluster) => ()
      `endif // NDS_IO_DCACHE_CTRL_OUT
   `endif // NDS_IO_DCACHE0
   `ifdef NDS_IO_DCLS
      `ifdef NDS_IO_SLAVEPORT_COMMON_X2
	.core1_slv1_araddr                           ({BIU_ADDR_WIDTH{1'bx}}                      ), // () <= ()
	.core1_slv1_arburst                          (2'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_arcache                          (4'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_arid                             ({(SLVPORT_ID_WIDTH){1'bx}}                  ), // () <= ()
	.core1_slv1_arlen                            (8'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_arlock                           (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_arprot                           (3'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_arready                          (nds_unused_core1_slv1_arready               ), // (u_cluster) => ()
	.core1_slv1_arsize                           (3'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_aruser                           (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_arvalid                          (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_awaddr                           ({(BIU_ADDR_WIDTH){1'bx}}                    ), // () <= ()
	.core1_slv1_awburst                          (2'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_awcache                          (4'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_awid                             ({(SLVPORT_ID_WIDTH){1'bx}}                  ), // () <= ()
	.core1_slv1_awlen                            (8'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_awlock                           (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_awprot                           (3'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_awready                          (nds_unused_core1_slv1_awready               ), // (u_cluster) => ()
	.core1_slv1_awsize                           (3'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_awuser                           (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_awvalid                          (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_bid                              (nds_unused_core1_slv1_bid                   ), // (u_cluster) => ()
	.core1_slv1_bready                           (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_bresp                            (nds_unused_core1_slv1_bresp                 ), // (u_cluster) => ()
	.core1_slv1_bvalid                           (nds_unused_core1_slv1_bvalid                ), // (u_cluster) => ()
	.core1_slv1_rdata                            (nds_unused_core1_slv1_rdata                 ), // (u_cluster) => ()
	.core1_slv1_rid                              (nds_unused_core1_slv1_rid                   ), // (u_cluster) => ()
	.core1_slv1_rlast                            (nds_unused_core1_slv1_rlast                 ), // (u_cluster) => ()
	.core1_slv1_rready                           (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_rresp                            (nds_unused_core1_slv1_rresp                 ), // (u_cluster) => ()
	.core1_slv1_rvalid                           (nds_unused_core1_slv1_rvalid                ), // (u_cluster) => ()
	.core1_slv1_wdata                            ({(BIU_DATA_WIDTH){1'bx}}                    ), // () <= ()
	.core1_slv1_wlast                            (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_wready                           (nds_unused_core1_slv1_wready                ), // (u_cluster) => ()
	.core1_slv1_wstrb                            ({(BIU_DATA_WIDTH/8){1'bx}}                  ), // () <= ()
	.core1_slv1_wvalid                           (1'bx                                        ), // (u_cluster) <= ()
      `endif // NDS_IO_SLAVEPORT_COMMON_X2
      `ifdef NDS_IO_EDC_AFTER_ECC
	.core1_fs_edc_error                          (nds_unused_core1_fs_edc_error               ), // (u_cluster) => ()
      `endif // NDS_IO_EDC_AFTER_ECC
      `ifdef NDS_IO_LM
	.core1_lm_local_int                          (hart1_lm_local_int_event                    ), // (u_cluster) => ()
      `endif // NDS_IO_LM
      `ifdef NDS_IO_ILM_BOOT
	.core1_ilm_boot                              (ilm_boot                                    ), // (u_cluster) <= ()
      `endif // NDS_IO_ILM_BOOT
      `ifdef NDS_IO_DLM_BOOT
	.core1_dlm_boot                              (1'b0                                        ), // (u_cluster) <= ()
      `endif // NDS_IO_DLM_BOOT
      `ifdef NDS_IO_SLAVEPORT_SYNC
	.core1_slv_clk_en                            (core1_slv_clk_en                            ), // (u_cluster) <= ()
      `endif // NDS_IO_SLAVEPORT_SYNC
      `ifdef NDS_IO_SLAVEPORT_SYNC_X2
	.core1_slv1_clk_en                           (core1_slv1_clk_en                           ), // (u_cluster) <= ()
      `endif // NDS_IO_SLAVEPORT_SYNC_X2
      `ifdef NDS_IO_PPI_SYNC
	.core1_ppi_aclk_en                           (1'b1                                        ), // (u_cluster) <= ()
      `endif // NDS_IO_PPI_SYNC
      `ifdef NDS_IO_SLAVEPORT_COMMON_X1
	.core1_slv_araddr                            (core1_slv_araddr                            ), // (u_cluster) <= ()
	.core1_slv_arburst                           (core1_slv_arburst                           ), // (u_cluster) <= ()
	.core1_slv_arcache                           (core1_slv_arcache                           ), // (u_cluster) <= ()
	.core1_slv_arid                              (core1_slv_arid                              ), // (u_cluster) <= ()
	.core1_slv_arlen                             (core1_slv_arlen                             ), // (u_cluster) <= ()
	.core1_slv_arlock                            (core1_slv_arlock                            ), // (u_cluster) <= ()
	.core1_slv_arprot                            (core1_slv_arprot                            ), // (u_cluster) <= ()
	.core1_slv_arready                           (core1_slv_arready                           ), // (u_cluster) => ()
	.core1_slv_arsize                            (core1_slv_arsize                            ), // (u_cluster) <= ()
	.core1_slv_aruser                            (core1_slv_aruser                            ), // (u_cluster) <= ()
	.core1_slv_arvalid                           (core1_slv_arvalid                           ), // (u_cluster) <= ()
	.core1_slv_awaddr                            (core1_slv_awaddr                            ), // (u_cluster) <= ()
	.core1_slv_awburst                           (core1_slv_awburst                           ), // (u_cluster) <= ()
	.core1_slv_awcache                           (core1_slv_awcache                           ), // (u_cluster) <= ()
	.core1_slv_awid                              (core1_slv_awid                              ), // (u_cluster) <= ()
	.core1_slv_awlen                             (core1_slv_awlen                             ), // (u_cluster) <= ()
	.core1_slv_awlock                            (core1_slv_awlock                            ), // (u_cluster) <= ()
	.core1_slv_awprot                            (core1_slv_awprot                            ), // (u_cluster) <= ()
	.core1_slv_awready                           (core1_slv_awready                           ), // (u_cluster) => ()
	.core1_slv_awsize                            (core1_slv_awsize                            ), // (u_cluster) <= ()
	.core1_slv_awuser                            (core1_slv_awuser                            ), // (u_cluster) <= ()
	.core1_slv_awvalid                           (core1_slv_awvalid                           ), // (u_cluster) <= ()
	.core1_slv_bid                               (core1_slv_bid                               ), // (u_cluster) => ()
	.core1_slv_bready                            (core1_slv_bready                            ), // (u_cluster) <= ()
	.core1_slv_bresp                             (core1_slv_bresp                             ), // (u_cluster) => ()
	.core1_slv_bvalid                            (core1_slv_bvalid                            ), // (u_cluster) => ()
	.core1_slv_rdata                             (core1_slv_rdata                             ), // (u_cluster) => ()
	.core1_slv_rid                               (core1_slv_rid                               ), // (u_cluster) => ()
	.core1_slv_rlast                             (core1_slv_rlast                             ), // (u_cluster) => ()
	.core1_slv_rready                            (core1_slv_rready                            ), // (u_cluster) <= ()
	.core1_slv_rresp                             (core1_slv_rresp                             ), // (u_cluster) => ()
	.core1_slv_rvalid                            (core1_slv_rvalid                            ), // (u_cluster) => ()
	.core1_slv_wdata                             (core1_slv_wdata                             ), // (u_cluster) <= ()
	.core1_slv_wlast                             (core1_slv_wlast                             ), // (u_cluster) <= ()
	.core1_slv_wready                            (core1_slv_wready                            ), // (u_cluster) => ()
	.core1_slv_wstrb                             (core1_slv_wstrb                             ), // (u_cluster) <= ()
	.core1_slv_wvalid                            (core1_slv_wvalid                            ), // (u_cluster) <= ()
      `endif // NDS_IO_SLAVEPORT_COMMON_X1
      `ifdef NDS_IO_SLAVEPORT_ECC_X1
	.core1_fs_bus_s_protection_error             (core1_fs_bus_s_protection_error             ), // (u_cluster) => ()
	.core1_slv_araddrcode                        (core1_slv_araddrcode                        ), // (u_cluster) <= ()
	.core1_slv_arctl0code                        (core1_slv_arctl0code                        ), // (u_cluster) <= ()
	.core1_slv_arctl1code                        (core1_slv_arctl1code                        ), // (u_cluster) <= ()
	.core1_slv_aridcode                          (core1_slv_aridcode                          ), // (u_cluster) <= ()
	.core1_slv_arreadycode                       (core1_slv_arreadycode                       ), // (u_cluster) => ()
	.core1_slv_arutid                            (core1_slv_arutid                            ), // (u_cluster) <= ()
	.core1_slv_arvalidcode                       (core1_slv_arvalidcode                       ), // (u_cluster) <= ()
	.core1_slv_awaddrcode                        (core1_slv_awaddrcode                        ), // (u_cluster) <= ()
	.core1_slv_awctl0code                        (core1_slv_awctl0code                        ), // (u_cluster) <= ()
	.core1_slv_awctl1code                        (core1_slv_awctl1code                        ), // (u_cluster) <= ()
	.core1_slv_awidcode                          (core1_slv_awidcode                          ), // (u_cluster) <= ()
	.core1_slv_awreadycode                       (core1_slv_awreadycode                       ), // (u_cluster) => ()
	.core1_slv_awutid                            (core1_slv_awutid                            ), // (u_cluster) <= ()
	.core1_slv_awvalidcode                       (core1_slv_awvalidcode                       ), // (u_cluster) <= ()
	.core1_slv_bctlcode                          (core1_slv_bctlcode                          ), // (u_cluster) => ()
	.core1_slv_bidcode                           (core1_slv_bidcode                           ), // (u_cluster) => ()
	.core1_slv_breadycode                        (core1_slv_breadycode                        ), // (u_cluster) <= ()
	.core1_slv_butid                             (core1_slv_butid                             ), // (u_cluster) => ()
	.core1_slv_bvalidcode                        (core1_slv_bvalidcode                        ), // (u_cluster) => ()
	.core1_slv_rctlcode                          (core1_slv_rctlcode                          ), // (u_cluster) => ()
	.core1_slv_rdatacode                         (core1_slv_rdatacode                         ), // (u_cluster) => ()
	.core1_slv_reobi                             (core1_slv_reobi                             ), // (u_cluster) => ()
	.core1_slv_ridcode                           (core1_slv_ridcode                           ), // (u_cluster) => ()
	.core1_slv_rreadycode                        (core1_slv_rreadycode                        ), // (u_cluster) <= ()
	.core1_slv_rutid                             (core1_slv_rutid                             ), // (u_cluster) => ()
	.core1_slv_rvalidcode                        (core1_slv_rvalidcode                        ), // (u_cluster) => ()
	.core1_slv_wctlcode                          (core1_slv_wctlcode                          ), // (u_cluster) <= ()
	.core1_slv_wdatacode                         (core1_slv_wdatacode                         ), // (u_cluster) <= ()
	.core1_slv_weobi                             (core1_slv_weobi                             ), // (u_cluster) <= ()
	.core1_slv_wreadycode                        (core1_slv_wreadycode                        ), // (u_cluster) => ()
	.core1_slv_wutid                             (core1_slv_wutid                             ), // (u_cluster) <= ()
	.core1_slv_wvalidcode                        (core1_slv_wvalidcode                        ), // (u_cluster) <= ()
      `endif // NDS_IO_SLAVEPORT_ECC_X1
      `ifdef NDS_IO_SLAVEPORT_ECC_X2
	.core1_fs_bus_s1_protection_error            (nds_unused_core1_fs_bus_s1_protection_error ), // (u_cluster) => ()
	.core1_slv1_araddrcode                       ({(SLV_ADDR_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core1_slv1_arctl0code                       ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core1_slv1_arctl1code                       ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core1_slv1_aridcode                         ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core1_slv1_arreadycode                      (nds_unused_core1_slv1_arreadycode           ), // (u_cluster) => ()
	.core1_slv1_arutid                           ({(SLV_UTID_WIDTH){1'bx}}                    ), // () <= ()
	.core1_slv1_arvalidcode                      (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_awaddrcode                       ({(SLV_ADDR_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core1_slv1_awctl0code                       ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core1_slv1_awctl1code                       ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core1_slv1_awidcode                         ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core1_slv1_awreadycode                      (nds_unused_core1_slv1_awreadycode           ), // (u_cluster) => ()
	.core1_slv1_awutid                           ({(SLV_UTID_WIDTH){1'bx}}                    ), // () <= ()
	.core1_slv1_awvalidcode                      (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_bctlcode                         (nds_unused_core1_slv1_bctlcode              ), // (u_cluster) => ()
	.core1_slv1_bidcode                          (nds_unused_core1_slv1_bidcode               ), // (u_cluster) => ()
	.core1_slv1_breadycode                       (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_butid                            (nds_unused_core1_slv1_butid                 ), // (u_cluster) => ()
	.core1_slv1_bvalidcode                       (nds_unused_core1_slv1_bvalidcode            ), // (u_cluster) => ()
	.core1_slv1_rctlcode                         (nds_unused_core1_slv1_rctlcode              ), // (u_cluster) => ()
	.core1_slv1_rdatacode                        (nds_unused_core1_slv1_rdatacode             ), // (u_cluster) => ()
	.core1_slv1_reobi                            (nds_unused_core1_slv1_reobi                 ), // (u_cluster) => ()
	.core1_slv1_ridcode                          (nds_unused_core1_slv1_ridcode               ), // (u_cluster) => ()
	.core1_slv1_rreadycode                       (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_rutid                            (nds_unused_core1_slv1_rutid                 ), // (u_cluster) => ()
	.core1_slv1_rvalidcode                       (nds_unused_core1_slv1_rvalidcode            ), // (u_cluster) => ()
	.core1_slv1_wctlcode                         ({(SLV_CTRL_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core1_slv1_wdatacode                        ({(SLV_DATA_CODE_WIDTH){1'bx}}               ), // () <= ()
	.core1_slv1_weobi                            (1'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_wreadycode                       (nds_unused_core1_slv1_wreadycode            ), // (u_cluster) => ()
	.core1_slv1_wutid                            ({(SLV_UTID_WIDTH){1'bx}}                    ), // () <= ()
	.core1_slv1_wvalidcode                       (1'bx                                        ), // (u_cluster) <= ()
      `endif // NDS_IO_SLAVEPORT_ECC_X2
      `ifdef NDS_TRACE_TILELINK
	.core1_trace_dcu_cmt_addr                    (core1_trace_dcu_cmt_addr                    ), // (u_cluster) => ()
	.core1_trace_dcu_cmt_func                    (core1_trace_dcu_cmt_func                    ), // (u_cluster) => ()
	.core1_trace_dcu_cmt_valid                   (core1_trace_dcu_cmt_valid                   ), // (u_cluster) => ()
	.core1_trace_dcu_cmt_wdata                   (core1_trace_dcu_cmt_wdata                   ), // (u_cluster) => ()
	.core1_trace_i0_wb_alive                     (core1_trace_i0_wb_alive                     ), // (u_cluster) => ()
	.core1_trace_i0_wb_pc                        (core1_trace_i0_wb_pc                        ), // (u_cluster) => ()
	.core1_trace_i1_wb_alive                     (core1_trace_i1_wb_alive                     ), // (u_cluster) => ()
	.core1_trace_i1_wb_pc                        (core1_trace_i1_wb_pc                        ), // (u_cluster) => ()
	.core1_trace_ls_i0_instr                     (core1_trace_ls_i0_instr                     ), // (u_cluster) => ()
	.core1_trace_ls_i0_pc                        (core1_trace_ls_i0_pc                        ), // (u_cluster) => ()
	.core1_trace_sb_va                           (core1_trace_sb_va                           ), // (u_cluster) => ()
	.core1_trace_wb_cause                        (core1_trace_wb_cause                        ), // (u_cluster) => ()
	.core1_trace_wb_xcpt                         (core1_trace_wb_xcpt                         ), // (u_cluster) => ()
      `endif // NDS_TRACE_TILELINK
      `ifdef NDS_IO_LM_RESET
	.core1_lm_reset_n                            (core1_lm_reset_n                            ), // (u_cluster) => ()
      `endif // NDS_IO_LM_RESET
      `ifdef NDS_IO_ILM_TL_UL
	.core1_ilm_a_addr                            (core1_ilm_a_addr                            ), // (u_cluster) => (u_core1_ilm_ram_brg)
	.core1_ilm_a_data                            (core1_ilm_a_data                            ), // (u_cluster) => (u_core1_ilm_ram_brg)
	.core1_ilm_a_mask                            (core1_ilm_a_mask                            ), // (u_cluster) => (u_core1_ilm_ram_brg)
	.core1_ilm_a_opcode                          (core1_ilm_a_opcode                          ), // (u_cluster) => (u_core1_ilm_ram_brg)
	.core1_ilm_a_parity0                         (core1_ilm_a_parity0                         ), // (u_cluster) => ()
	.core1_ilm_a_parity1                         (core1_ilm_a_parity1                         ), // (u_cluster) => ()
	.core1_ilm_a_ready                           (core1_ilm_a_ready                           ), // (u_cluster) <= (u_core1_ilm_ram_brg)
	.core1_ilm_a_size                            (core1_ilm_a_size                            ), // (u_cluster) => (u_core1_ilm_ram_brg)
	.core1_ilm_a_user                            (core1_ilm_a_user                            ), // (u_cluster) => ()
	.core1_ilm_a_valid                           (core1_ilm_a_valid                           ), // (u_cluster) => (u_core1_ilm_ram_brg)
	.core1_ilm_d_data                            (core1_ilm_d_data                            ), // (u_cluster) <= (u_core1_ilm_ram_brg)
	.core1_ilm_d_denied                          (core1_ilm_d_denied                          ), // (u_cluster) <= (u_core1_ilm_ram_brg)
	.core1_ilm_d_parity0                         (core1_ilm_d_parity0                         ), // (u_cluster) <= ()
	.core1_ilm_d_parity1                         (core1_ilm_d_parity1                         ), // (u_cluster) <= ()
	.core1_ilm_d_ready                           (core1_ilm_d_ready                           ), // (u_cluster) => (u_core1_ilm_ram_brg)
	.core1_ilm_d_valid                           (core1_ilm_d_valid                           ), // (u_cluster) <= (u_core1_ilm_ram_brg)
      `endif // NDS_IO_ILM_TL_UL
      `ifdef NDS_IO_DLM_TL_UL
	.core1_dlm_a_addr                            (core1_dlm_a_addr                            ), // (u_cluster) => (u_core1_dlm_ram0)
	.core1_dlm_a_data                            (core1_dlm_a_data                            ), // (u_cluster) => (u_core1_dlm_ram0)
	.core1_dlm_a_mask                            (core1_dlm_a_mask                            ), // (u_cluster) => (u_core1_dlm_ram0)
	.core1_dlm_a_opcode                          (core1_dlm_a_opcode                          ), // (u_cluster) => (u_core1_dlm_ram0)
	.core1_dlm_a_parity                          (core1_dlm_a_parity                          ), // (u_cluster) => (u_core1_dlm_ram0)
	.core1_dlm_a_ready                           (core1_dlm_a_ready                           ), // (u_cluster) <= (u_core1_dlm_ram0)
	.core1_dlm_a_size                            (core1_dlm_a_size                            ), // (u_cluster) => (u_core1_dlm_ram0)
	.core1_dlm_a_user                            (core1_dlm_a_user                            ), // (u_cluster) => (u_core1_dlm_ram0)
	.core1_dlm_a_valid                           (core1_dlm_a_valid                           ), // (u_cluster) => (u_core1_dlm_ram0)
	.core1_dlm_d_data                            (core1_dlm_d_data                            ), // (u_cluster) <= (u_core1_dlm_ram0)
	.core1_dlm_d_denied                          (core1_dlm_d_denied                          ), // (u_cluster) <= (u_core1_dlm_ram0)
	.core1_dlm_d_parity                          (core1_dlm_d_parity                          ), // (u_cluster) <= (u_core1_dlm_ram0)
	.core1_dlm_d_ready                           (core1_dlm_d_ready                           ), // (u_cluster) => (u_core1_dlm_ram0)
	.core1_dlm_d_valid                           (core1_dlm_d_valid                           ), // (u_cluster) <= (u_core1_dlm_ram0)
      `endif // NDS_IO_DLM_TL_UL
      `ifdef NDS_IO_ICACHE0
	.core1_icache_disable_init                   (core1_icache_disable_init                   ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data10_addr        (dcls_inject_fault_icache_data10_addr        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data10_cs          (dcls_inject_fault_icache_data10_cs          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data10_wdata       (dcls_inject_fault_icache_data10_wdata       ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data10_we          (dcls_inject_fault_icache_data10_we          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data11_addr        (dcls_inject_fault_icache_data11_addr        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data11_cs          (dcls_inject_fault_icache_data11_cs          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data11_wdata       (dcls_inject_fault_icache_data11_wdata       ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data11_we          (dcls_inject_fault_icache_data11_we          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data12_addr        (dcls_inject_fault_icache_data12_addr        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data12_cs          (dcls_inject_fault_icache_data12_cs          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data12_wdata       (dcls_inject_fault_icache_data12_wdata       ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data12_we          (dcls_inject_fault_icache_data12_we          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data13_addr        (dcls_inject_fault_icache_data13_addr        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data13_cs          (dcls_inject_fault_icache_data13_cs          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data13_wdata       (dcls_inject_fault_icache_data13_wdata       ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data13_we          (dcls_inject_fault_icache_data13_we          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data14_addr        (dcls_inject_fault_icache_data14_addr        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data14_cs          (dcls_inject_fault_icache_data14_cs          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data14_wdata       (dcls_inject_fault_icache_data14_wdata       ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data14_we          (dcls_inject_fault_icache_data14_we          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data15_addr        (dcls_inject_fault_icache_data15_addr        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data15_cs          (dcls_inject_fault_icache_data15_cs          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data15_wdata       (dcls_inject_fault_icache_data15_wdata       ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data15_we          (dcls_inject_fault_icache_data15_we          ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data8_addr         (dcls_inject_fault_icache_data8_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data8_cs           (dcls_inject_fault_icache_data8_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data8_wdata        (dcls_inject_fault_icache_data8_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data8_we           (dcls_inject_fault_icache_data8_we           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data9_addr         (dcls_inject_fault_icache_data9_addr         ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data9_cs           (dcls_inject_fault_icache_data9_cs           ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data9_wdata        (dcls_inject_fault_icache_data9_wdata        ), // (u_cluster) <= ()
	.dcls_inject_fault_icache_data9_we           (dcls_inject_fault_icache_data9_we           ), // (u_cluster) <= ()
      `endif // NDS_IO_ICACHE0
      `ifdef NDS_IO_PROBING
	.core1_current_pc                            (hart1_probe_current_pc                      ), // (u_cluster) => ()
	.core1_gpr_index                             (hart1_probe_gpr_index                       ), // (u_cluster) <= ()
	.core1_selected_gpr_value                    (hart1_probe_selected_gpr_value              ), // (u_cluster) => ()
      `endif // NDS_IO_PROBING
      `ifdef NDS_IO_SEIP
	.core1_seiack                                (core1_seiack                                ), // (u_cluster) => ()
	.core1_seiid                                 (core1_seiid                                 ), // (u_cluster) <= ()
	.core1_seip                                  (core1_seip                                  ), // (u_cluster) <= ()
      `endif // NDS_IO_SEIP
      `ifdef NDS_IO_UEIP
	.core1_ueiack                                (nds_unused_core1_ueiack                     ), // (u_cluster) => ()
	.core1_ueiid                                 (10'b0                                       ), // (u_cluster) <= ()
	.core1_ueip                                  (core1_ueip                                  ), // (u_cluster) <= ()
      `endif // NDS_IO_UEIP
      `ifdef NDS_IO_DEBUG
	.core1_debugint                              (core1_debugint                              ), // (u_cluster) <= ()
	.core1_hart_halted                           (core1_hart_halted                           ), // (u_cluster) => ()
	.core1_hart_unavail                          (core1_hart_unavail                          ), // (u_cluster) => ()
	.core1_hart_under_reset                      (core1_hart_under_reset                      ), // (u_cluster) => ()
	.core1_resethaltreq                          (core1_resethaltreq                          ), // (u_cluster) <= ()
	.core1_stoptime                              (core1_stoptime                              ), // (u_cluster) => ()
      `endif // NDS_IO_DEBUG
      `ifdef NDS_IO_TRACE_INSTR_GEN1
	.core1_gen1_trace_cause                      (hart1_gen1_trace_cause                      ), // (u_cluster) => ()
	.core1_gen1_trace_enabled                    (hart1_gen1_trace_enabled                    ), // (u_cluster) <= ()
	.core1_gen1_trace_iaddr                      (hart1_gen1_trace_iaddr                      ), // (u_cluster) => ()
	.core1_gen1_trace_iexception                 (hart1_gen1_trace_iexception                 ), // (u_cluster) => ()
	.core1_gen1_trace_instr                      (hart1_gen1_trace_instr                      ), // (u_cluster) => ()
	.core1_gen1_trace_interrupt                  (hart1_gen1_trace_interrupt                  ), // (u_cluster) => ()
	.core1_gen1_trace_ivalid                     (hart1_gen1_trace_ivalid                     ), // (u_cluster) => ()
	.core1_gen1_trace_priv                       (hart1_gen1_trace_priv                       ), // (u_cluster) => ()
	.core1_gen1_trace_tval                       (hart1_gen1_trace_tval                       ), // (u_cluster) => ()
      `endif // NDS_IO_TRACE_INSTR_GEN1
      `ifdef NDS_IO_TRACE_INSTR
	.core1_trace_cause                           (hart1_trace_cause                           ), // (u_cluster) => ()
	.core1_trace_context                         (hart1_trace_context                         ), // (u_cluster) => ()
	.core1_trace_ctype                           (hart1_trace_ctype                           ), // (u_cluster) => ()
	.core1_trace_enabled                         (hart1_trace_enabled                         ), // (u_cluster) <= ()
	.core1_trace_halted                          (hart1_trace_halted                          ), // (u_cluster) => ()
	.core1_trace_iaddr                           (hart1_trace_iaddr                           ), // (u_cluster) => ()
	.core1_trace_ilastsize                       (hart1_trace_ilastsize                       ), // (u_cluster) => ()
	.core1_trace_iretire                         (hart1_trace_iretire                         ), // (u_cluster) => ()
	.core1_trace_itype                           (hart1_trace_itype                           ), // (u_cluster) => ()
	.core1_trace_priv                            (hart1_trace_priv                            ), // (u_cluster) => ()
	.core1_trace_reset                           (hart1_trace_reset                           ), // (u_cluster) => ()
	.core1_trace_stall                           (hart1_trace_stall                           ), // (u_cluster) <= ()
	.core1_trace_trigger                         (hart1_trace_trigger                         ), // (u_cluster) => ()
	.core1_trace_tval                            (hart1_trace_tval                            ), // (u_cluster) => ()
      `endif // NDS_IO_TRACE_INSTR
      `ifdef NDS_IO_TRAP_STATUS
	.core1_fs_halt_mode                          (nds_unused_core1_fs_halt_mode               ), // (u_cluster) => ()
	.core1_fs_trap_status_cause                  (nds_unused_core1_fs_trap_status_cause       ), // (u_cluster) => ()
	.core1_fs_trap_status_dcause                 (nds_unused_core1_fs_trap_status_dcause      ), // (u_cluster) => ()
	.core1_fs_trap_status_interrupt              (nds_unused_core1_fs_trap_status_interrupt   ), // (u_cluster) => ()
	.core1_fs_trap_status_nmi                    (nds_unused_core1_fs_trap_status_nmi         ), // (u_cluster) => ()
	.core1_fs_trap_status_taken                  (nds_unused_core1_fs_trap_status_taken       ), // (u_cluster) => ()
      `endif // NDS_IO_TRAP_STATUS
      `ifdef NDS_IO_PPI
	.core1_ppi_araddr                            (core1_ppi_araddr                            ), // (u_cluster) => ()
	.core1_ppi_arburst                           (core1_ppi_arburst                           ), // (u_cluster) => ()
	.core1_ppi_arcache                           (core1_ppi_arcache                           ), // (u_cluster) => ()
	.core1_ppi_arid                              (core1_ppi_arid                              ), // (u_cluster) => ()
	.core1_ppi_arlen                             (core1_ppi_arlen                             ), // (u_cluster) => ()
	.core1_ppi_arlock                            (core1_ppi_arlock                            ), // (u_cluster) => ()
	.core1_ppi_arprot                            (core1_ppi_arprot                            ), // (u_cluster) => ()
	.core1_ppi_arready                           (core1_ppi_arready                           ), // (u_cluster) <= ()
	.core1_ppi_arsize                            (core1_ppi_arsize                            ), // (u_cluster) => ()
	.core1_ppi_arvalid                           (core1_ppi_arvalid                           ), // (u_cluster) => ()
	.core1_ppi_awaddr                            (core1_ppi_awaddr                            ), // (u_cluster) => ()
	.core1_ppi_awburst                           (core1_ppi_awburst                           ), // (u_cluster) => ()
	.core1_ppi_awcache                           (core1_ppi_awcache                           ), // (u_cluster) => ()
	.core1_ppi_awid                              (core1_ppi_awid                              ), // (u_cluster) => ()
	.core1_ppi_awlen                             (core1_ppi_awlen                             ), // (u_cluster) => ()
	.core1_ppi_awlock                            (core1_ppi_awlock                            ), // (u_cluster) => ()
	.core1_ppi_awprot                            (core1_ppi_awprot                            ), // (u_cluster) => ()
	.core1_ppi_awready                           (core1_ppi_awready                           ), // (u_cluster) <= ()
	.core1_ppi_awsize                            (core1_ppi_awsize                            ), // (u_cluster) => ()
	.core1_ppi_awvalid                           (core1_ppi_awvalid                           ), // (u_cluster) => ()
	.core1_ppi_bid                               (core1_ppi_bid                               ), // (u_cluster) <= ()
	.core1_ppi_bready                            (core1_ppi_bready                            ), // (u_cluster) => ()
	.core1_ppi_bresp                             (core1_ppi_bresp                             ), // (u_cluster) <= ()
	.core1_ppi_bvalid                            (core1_ppi_bvalid                            ), // (u_cluster) <= ()
	.core1_ppi_rdata                             (core1_ppi_rdata                             ), // (u_cluster) <= ()
	.core1_ppi_rid                               (core1_ppi_rid                               ), // (u_cluster) <= ()
	.core1_ppi_rlast                             (core1_ppi_rlast                             ), // (u_cluster) <= ()
	.core1_ppi_rready                            (core1_ppi_rready                            ), // (u_cluster) => ()
	.core1_ppi_rresp                             (core1_ppi_rresp                             ), // (u_cluster) <= ()
	.core1_ppi_rvalid                            (core1_ppi_rvalid                            ), // (u_cluster) <= ()
	.core1_ppi_wdata                             (core1_ppi_wdata                             ), // (u_cluster) => ()
	.core1_ppi_wlast                             (core1_ppi_wlast                             ), // (u_cluster) => ()
	.core1_ppi_wready                            (core1_ppi_wready                            ), // (u_cluster) <= ()
	.core1_ppi_wstrb                             (core1_ppi_wstrb                             ), // (u_cluster) => ()
	.core1_ppi_wvalid                            (core1_ppi_wvalid                            ), // (u_cluster) => ()
      `endif // NDS_IO_PPI
      `ifdef NDS_IO_PPI_PROT
	.core1_ppi_araddrcode                        (core1_ppi_araddrcode                        ), // (u_cluster) => ()
	.core1_ppi_arctl0code                        (core1_ppi_arctl0code                        ), // (u_cluster) => ()
	.core1_ppi_arctl1code                        (core1_ppi_arctl1code                        ), // (u_cluster) => ()
	.core1_ppi_aridcode                          (core1_ppi_aridcode                          ), // (u_cluster) => ()
	.core1_ppi_arreadycode                       (core1_ppi_arreadycode                       ), // (u_cluster) <= ()
	.core1_ppi_arutid                            (core1_ppi_arutid                            ), // (u_cluster) => ()
	.core1_ppi_arvalidcode                       (core1_ppi_arvalidcode                       ), // (u_cluster) => ()
	.core1_ppi_awaddrcode                        (core1_ppi_awaddrcode                        ), // (u_cluster) => ()
	.core1_ppi_awctl0code                        (core1_ppi_awctl0code                        ), // (u_cluster) => ()
	.core1_ppi_awctl1code                        (core1_ppi_awctl1code                        ), // (u_cluster) => ()
	.core1_ppi_awidcode                          (core1_ppi_awidcode                          ), // (u_cluster) => ()
	.core1_ppi_awreadycode                       (core1_ppi_awreadycode                       ), // (u_cluster) <= ()
	.core1_ppi_awutid                            (core1_ppi_awutid                            ), // (u_cluster) => ()
	.core1_ppi_awvalidcode                       (core1_ppi_awvalidcode                       ), // (u_cluster) => ()
	.core1_ppi_bctlcode                          (core1_ppi_bctlcode                          ), // (u_cluster) <= ()
	.core1_ppi_bidcode                           (core1_ppi_bidcode                           ), // (u_cluster) <= ()
	.core1_ppi_breadycode                        (core1_ppi_breadycode                        ), // (u_cluster) => ()
	.core1_ppi_butid                             (core1_ppi_butid                             ), // (u_cluster) <= ()
	.core1_ppi_bvalidcode                        (core1_ppi_bvalidcode                        ), // (u_cluster) <= ()
	.core1_ppi_rctlcode                          (core1_ppi_rctlcode                          ), // (u_cluster) <= ()
	.core1_ppi_rdatacode                         (core1_ppi_rdatacode                         ), // (u_cluster) <= ()
	.core1_ppi_reobi                             (core1_ppi_reobi                             ), // (u_cluster) <= ()
	.core1_ppi_ridcode                           (core1_ppi_ridcode                           ), // (u_cluster) <= ()
	.core1_ppi_rreadycode                        (core1_ppi_rreadycode                        ), // (u_cluster) => ()
	.core1_ppi_rutid                             (core1_ppi_rutid                             ), // (u_cluster) <= ()
	.core1_ppi_rvalidcode                        (core1_ppi_rvalidcode                        ), // (u_cluster) <= ()
	.core1_ppi_wctlcode                          (core1_ppi_wctlcode                          ), // (u_cluster) => ()
	.core1_ppi_wdatacode                         (core1_ppi_wdatacode                         ), // (u_cluster) => ()
	.core1_ppi_weobi                             (core1_ppi_weobi                             ), // (u_cluster) => ()
	.core1_ppi_wreadycode                        (core1_ppi_wreadycode                        ), // (u_cluster) <= ()
	.core1_ppi_wutid                             (core1_ppi_wutid                             ), // (u_cluster) => ()
	.core1_ppi_wvalidcode                        (core1_ppi_wvalidcode                        ), // (u_cluster) => ()
      `endif // NDS_IO_PPI_PROT
      `ifdef NDS_IO_LM_QOS
	.core1_ifu_ilm_qos                           (core1_ifu_ilm_qos                           ), // (u_cluster) <= ()
	.core1_lsu_dlm_qos                           (core1_lsu_dlm_qos                           ), // (u_cluster) <= ()
	.core1_lsu_ilm_qos                           (core1_lsu_ilm_qos                           ), // (u_cluster) <= ()
      `endif // NDS_IO_LM_QOS
      `ifdef NDS_IO_SLAVEPORT_QOS_X1
	.core1_slv_arqos                             (core1_slv_arqos                             ), // (u_cluster) <= ()
	.core1_slv_awqos                             (core1_slv_awqos                             ), // (u_cluster) <= ()
      `endif // NDS_IO_SLAVEPORT_QOS_X1
      `ifdef NDS_IO_SLAVEPORT_QOS_X2
	.core1_slv1_arqos                            (4'bx                                        ), // (u_cluster) <= ()
	.core1_slv1_awqos                            (4'bx                                        ), // (u_cluster) <= ()
      `endif // NDS_IO_SLAVEPORT_QOS_X2
      `ifdef NDS_IO_ILM_RAM0
	.dcls_inject_fault_ilm2_addr                 (dcls_inject_fault_ilm2_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm2_byte_we              (dcls_inject_fault_ilm2_byte_we              ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm2_cs                   (dcls_inject_fault_ilm2_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm2_wdata                (dcls_inject_fault_ilm2_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm2_we                   (dcls_inject_fault_ilm2_we                   ), // (u_cluster) <= ()
      `endif // NDS_IO_ILM_RAM0
      `ifdef NDS_IO_ILM_RAM1
	.dcls_inject_fault_ilm3_addr                 (dcls_inject_fault_ilm3_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm3_byte_we              (dcls_inject_fault_ilm3_byte_we              ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm3_cs                   (dcls_inject_fault_ilm3_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm3_wdata                (dcls_inject_fault_ilm3_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_ilm3_we                   (dcls_inject_fault_ilm3_we                   ), // (u_cluster) <= ()
      `endif // NDS_IO_ILM_RAM1
      `ifdef NDS_IO_DLM_RAM0
	.dcls_inject_fault_dlm4_addr                 (dcls_inject_fault_dlm4_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm4_byte_we              (dcls_inject_fault_dlm4_byte_we              ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm4_cs                   (dcls_inject_fault_dlm4_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm4_wdata                (dcls_inject_fault_dlm4_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm4_we                   (dcls_inject_fault_dlm4_we                   ), // (u_cluster) <= ()
      `endif // NDS_IO_DLM_RAM0
      `ifdef NDS_IO_DLM_RAM1
	.dcls_inject_fault_dlm5_addr                 (dcls_inject_fault_dlm5_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm5_byte_we              (dcls_inject_fault_dlm5_byte_we              ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm5_cs                   (dcls_inject_fault_dlm5_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm5_wdata                (dcls_inject_fault_dlm5_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm5_we                   (dcls_inject_fault_dlm5_we                   ), // (u_cluster) <= ()
      `endif // NDS_IO_DLM_RAM1
      `ifdef NDS_IO_DLM_RAM2
	.dcls_inject_fault_dlm6_addr                 (dcls_inject_fault_dlm6_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm6_byte_we              (dcls_inject_fault_dlm6_byte_we              ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm6_cs                   (dcls_inject_fault_dlm6_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm6_wdata                (dcls_inject_fault_dlm6_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm6_we                   (dcls_inject_fault_dlm6_we                   ), // (u_cluster) <= ()
      `endif // NDS_IO_DLM_RAM2
      `ifdef NDS_IO_DLM_RAM3
	.dcls_inject_fault_dlm7_addr                 (dcls_inject_fault_dlm7_addr                 ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm7_byte_we              (dcls_inject_fault_dlm7_byte_we              ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm7_cs                   (dcls_inject_fault_dlm7_cs                   ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm7_wdata                (dcls_inject_fault_dlm7_wdata                ), // (u_cluster) <= ()
	.dcls_inject_fault_dlm7_we                   (dcls_inject_fault_dlm7_we                   ), // (u_cluster) <= ()
      `endif // NDS_IO_DLM_RAM3
   `endif // NDS_IO_DCLS
`endif // NDS_IO_DCLS_SPLIT
	.biu_clk                                     (biu_clk                                     ), // (u_cluster) <= ()
	.biu_resetn                                  (biu_resetn                                  ), // (u_cluster) <= ()
	.sys0_aclk_en                                (axi_bus_clk_en                              ), // (u_cluster) <= ()
	.sys0_araddr                                 (cluster_sys0_araddr                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arburst                                (cluster_sys0_arburst                        ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arcache                                (cluster_sys0_arcache                        ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arid                                   (cluster_sys0_arid                           ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arlen                                  (cluster_sys0_arlen                          ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arlock                                 (cluster_sys0_arlock                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arprot                                 (cluster_sys0_arprot                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arready                                (cluster_sys0_arready                        ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_arsize                                 (cluster_sys0_arsize                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_arvalid                                (cluster_sys0_arvalid                        ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awaddr                                 (cluster_sys0_awaddr                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awburst                                (cluster_sys0_awburst                        ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awcache                                (cluster_sys0_awcache                        ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awid                                   (cluster_sys0_awid                           ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awlen                                  (cluster_sys0_awlen                          ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awlock                                 (cluster_sys0_awlock                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awprot                                 (cluster_sys0_awprot                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awready                                (cluster_sys0_awready                        ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_awsize                                 (cluster_sys0_awsize                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_awvalid                                (cluster_sys0_awvalid                        ), // (u_cluster) => (u_sys0_ingress)
	.sys0_bid                                    (cluster_sys0_bid                            ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_bready                                 (cluster_sys0_bready                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_bresp                                  (cluster_sys0_bresp                          ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_bvalid                                 (cluster_sys0_bvalid                         ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_rdata                                  (cluster_sys0_rdata                          ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_rid                                    (cluster_sys0_rid                            ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_rlast                                  (cluster_sys0_rlast                          ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_rready                                 (cluster_sys0_rready                         ), // (u_cluster) => (u_sys0_ingress)
	.sys0_rresp                                  (cluster_sys0_rresp                          ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_rvalid                                 (cluster_sys0_rvalid                         ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_wdata                                  (cluster_sys0_wdata                          ), // (u_cluster) => (u_sys0_ingress)
	.sys0_wlast                                  (cluster_sys0_wlast                          ), // (u_cluster) => (u_sys0_ingress)
	.sys0_wready                                 (cluster_sys0_wready                         ), // (u_cluster) <= (u_sys0_ingress)
	.sys0_wstrb                                  (cluster_sys0_wstrb                          ), // (u_cluster) => (u_sys0_ingress)
	.sys0_wvalid                                 (cluster_sys0_wvalid                         ), // (u_cluster) => (u_sys0_ingress)
	.core0_clk                                   (core0_clk                                   ), // (u_cluster) <= ()
	.core0_hart_id                               (64'd0                                       ), // (u_cluster) <= ()
	.core0_meiack                                (core0_meiack                                ), // (u_cluster) => ()
	.core0_meiid                                 (core0_meiid                                 ), // (u_cluster) <= ()
	.core0_meip                                  (core0_meip                                  ), // (u_cluster) <= ()
	.core0_msip                                  (hart0_msip                                  ), // (u_cluster) <= (u_plic_sw)
	.core0_mtip                                  (hart0_mtip                                  ), // (u_cluster) <= ()
	.core0_nmi                                   (core0_nmi                                   ), // (u_cluster) <= ()
	.core0_reset_n                               (core0_reset_n                               ), // (u_cluster) <= ()
	.core0_reset_vector                          (core0_reset_vector                          ), // (u_cluster) <= ()
	.core0_wfi_mode                              (core0_wfi_mode                              ), // (u_cluster) => ()
	.scan_enable                                 (scan_enable                                 ), // (u_cluster) <= ()
	.test_mode                                   (test_mode                                   )  // (u_cluster,u_plmt) <= ()
); // end of u_cluster

`ifdef NDS_IO_DLM_TL_UL
   `ifdef NDS_IO_DLM_RAM_ECC
kv_dlm_wait_fusa_ecc_ram #(
	.DLM_RAM_AMSB    (`NDS_DLM_AMSB   ),
	.DLM_RAM_BWEW    (`NDS_DLM_RAM_BWEW),
	.DLM_RAM_DW      (`NDS_DLM_RAM_DW ),
	.XLEN            (`NDS_XLEN       )
) u_core0_dlm_ram0 (
	.lm_clk      (lm_clk[0]         ), // (u_core0_dlm_ram0,u_core0_ilm_clock_gen,u_core0_ilm_ram_brg,u_core1_dlm_ram0,u_core1_ilm_clock_gen,u_core1_ilm_ram_brg) <= ()
	.lm_reset_n  (core0_dlm_reset_n ), // (u_core0_dlm_ram0) <= ()
	.dlm_a_addr  (core0_dlm_a_addr  ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_data  (core0_dlm_a_data  ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_mask  (core0_dlm_a_mask  ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_opcode(core0_dlm_a_opcode), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_parity(core0_dlm_a_parity), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_size  (core0_dlm_a_size  ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_user  (core0_dlm_a_user  ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_valid (core0_dlm_a_valid ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_ready (core0_dlm_a_ready ), // (u_core0_dlm_ram0) => (u_cluster)
	.dlm_d_data  (core0_dlm_d_data  ), // (u_core0_dlm_ram0) => (u_cluster)
	.dlm_d_parity(core0_dlm_d_parity), // (u_core0_dlm_ram0) => (u_cluster)
	.dlm_d_denied(core0_dlm_d_denied), // (u_core0_dlm_ram0) => (u_cluster)
	.dlm_d_ready (core0_dlm_d_ready ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_d_valid (core0_dlm_d_valid )  // (u_core0_dlm_ram0) => (u_cluster)
); // end of u_core0_dlm_ram0

   `else
kv_dlm_wait_ram #(
	.DLM_RAM_AMSB    (`NDS_DLM_AMSB   ),
	.DLM_RAM_BWEW    (`NDS_DLM_RAM_BWEW),
	.DLM_RAM_DW      (`NDS_DLM_RAM_DW ),
	.XLEN            (`NDS_XLEN       )
) u_core0_dlm_ram0 (
	.lm_clk      (lm_clk[0]         ), // () <= ()
	.lm_reset_n  (core0_dlm_reset_n ), // (u_core0_dlm_ram0) <= ()
	.dlm_a_addr  (core0_dlm_a_addr  ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_data  (core0_dlm_a_data  ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_mask  (core0_dlm_a_mask  ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_opcode(core0_dlm_a_opcode), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_size  (core0_dlm_a_size  ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_user  (core0_dlm_a_user  ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_valid (core0_dlm_a_valid ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_parity(core0_dlm_a_parity), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_a_ready (core0_dlm_a_ready ), // (u_core0_dlm_ram0) => (u_cluster)
	.dlm_d_data  (core0_dlm_d_data  ), // (u_core0_dlm_ram0) => (u_cluster)
	.dlm_d_denied(core0_dlm_d_denied), // (u_core0_dlm_ram0) => (u_cluster)
	.dlm_d_ready (core0_dlm_d_ready ), // (u_core0_dlm_ram0) <= (u_cluster)
	.dlm_d_parity(core0_dlm_d_parity), // (u_core0_dlm_ram0) => (u_cluster)
	.dlm_d_valid (core0_dlm_d_valid )  // (u_core0_dlm_ram0) => (u_cluster)
); // end of u_core0_dlm_ram0

   `endif // NDS_IO_DLM_RAM_ECC
   `ifdef NDS_IO_DCLS_SPLIT
      `ifdef NDS_IO_DLM_RAM_ECC
kv_dlm_wait_fusa_ecc_ram #(
	.DLM_RAM_AMSB    (`NDS_DLM_AMSB   ),
	.DLM_RAM_BWEW    (`NDS_DLM_RAM_BWEW),
	.DLM_RAM_DW      (`NDS_DLM_RAM_DW ),
	.XLEN            (`NDS_XLEN       )
) u_core1_dlm_ram0 (
	.lm_clk      (lm_clk[1]         ), // (u_core0_dlm_ram0,u_core0_ilm_clock_gen,u_core0_ilm_ram_brg,u_core1_dlm_ram0,u_core1_ilm_clock_gen,u_core1_ilm_ram_brg) <= ()
	.lm_reset_n  (core1_dlm_reset_n ), // (u_core1_dlm_ram0) <= ()
	.dlm_a_addr  (core1_dlm_a_addr  ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_data  (core1_dlm_a_data  ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_mask  (core1_dlm_a_mask  ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_opcode(core1_dlm_a_opcode), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_parity(core1_dlm_a_parity), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_size  (core1_dlm_a_size  ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_user  (core1_dlm_a_user  ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_valid (core1_dlm_a_valid ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_ready (core1_dlm_a_ready ), // (u_core1_dlm_ram0) => (u_cluster)
	.dlm_d_data  (core1_dlm_d_data  ), // (u_core1_dlm_ram0) => (u_cluster)
	.dlm_d_parity(core1_dlm_d_parity), // (u_core1_dlm_ram0) => (u_cluster)
	.dlm_d_denied(core1_dlm_d_denied), // (u_core1_dlm_ram0) => (u_cluster)
	.dlm_d_ready (core1_dlm_d_ready ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_d_valid (core1_dlm_d_valid )  // (u_core1_dlm_ram0) => (u_cluster)
); // end of u_core1_dlm_ram0

      `else
kv_dlm_wait_ram #(
	.DLM_RAM_AMSB    (`NDS_DLM_AMSB   ),
	.DLM_RAM_BWEW    (`NDS_DLM_RAM_BWEW),
	.DLM_RAM_DW      (`NDS_DLM_RAM_DW ),
	.XLEN            (`NDS_XLEN       )
) u_core1_dlm_ram0 (
	.lm_clk      (lm_clk[1]         ), // () <= ()
	.lm_reset_n  (core1_dlm_reset_n ), // (u_core1_dlm_ram0) <= ()
	.dlm_a_addr  (core1_dlm_a_addr  ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_data  (core1_dlm_a_data  ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_mask  (core1_dlm_a_mask  ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_opcode(core1_dlm_a_opcode), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_size  (core1_dlm_a_size  ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_user  (core1_dlm_a_user  ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_valid (core1_dlm_a_valid ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_parity(core1_dlm_a_parity), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_a_ready (core1_dlm_a_ready ), // (u_core1_dlm_ram0) => (u_cluster)
	.dlm_d_data  (core1_dlm_d_data  ), // (u_core1_dlm_ram0) => (u_cluster)
	.dlm_d_denied(core1_dlm_d_denied), // (u_core1_dlm_ram0) => (u_cluster)
	.dlm_d_ready (core1_dlm_d_ready ), // (u_core1_dlm_ram0) <= (u_cluster)
	.dlm_d_parity(core1_dlm_d_parity), // (u_core1_dlm_ram0) => (u_cluster)
	.dlm_d_valid (core1_dlm_d_valid )  // (u_core1_dlm_ram0) => (u_cluster)
); // end of u_core1_dlm_ram0

      `endif // NDS_IO_DLM_RAM_ECC
   `endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_DLM_TL_UL
`ifdef NDS_IO_ILM_TL_UL
sample_kv_clk_gen #(
	.RATIO           (2               )
) u_core0_ilm_clock_gen (
	.clk_in (lm_clk[0]           ), // (u_core0_dlm_ram0,u_core0_ilm_clock_gen,u_core0_ilm_ram_brg,u_core1_dlm_ram0,u_core1_ilm_clock_gen,u_core1_ilm_ram_brg) <= ()
	.resetn (core0_ilm_reset_n   ), // (u_core0_ilm_clock_gen,u_core0_ilm_ram_brg) <= ()
	.clk_en (core0_ilm_ram_clk_en), // (u_core0_ilm_clock_gen) => (u_core0_ilm_ram_brg)
	.clk_out(core0_ilm_ram_clk   )  // (u_core0_ilm_clock_gen) => (u_ilm_tl_ul_core0_ram0,u_ilm_tl_ul_core0_ram1)
); // end of u_core0_ilm_clock_gen

atcrambrg500 #(
	.DS_DW           (ILM_TL_UL_RAM_DW),
	.US_AW           (ILM_TL_UL_AW    )
) u_core0_ilm_ram_brg (
	.clk       (lm_clk[0]              ), // (u_core0_dlm_ram0,u_core0_ilm_clock_gen,u_core0_ilm_ram_brg,u_core1_dlm_ram0,u_core1_ilm_clock_gen,u_core1_ilm_ram_brg) <= ()
	.clk_en    (core0_ilm_ram_clk_en   ), // (u_core0_ilm_ram_brg) <= (u_core0_ilm_clock_gen)
	.resetn    (core0_ilm_reset_n      ), // (u_core0_ilm_clock_gen,u_core0_ilm_ram_brg) <= ()
	.a_valid   (core0_ilm_a_valid      ), // (u_core0_ilm_ram_brg) <= (u_cluster)
	.a_ready   (core0_ilm_a_ready      ), // (u_core0_ilm_ram_brg) => (u_cluster)
	.a_addr    ({core0_ilm_a_addr,3'b0}), // () <= ()
	.a_data    (core0_ilm_a_data       ), // (u_core0_ilm_ram_brg) <= (u_cluster)
	.a_opcode  (core0_ilm_a_opcode     ), // (u_core0_ilm_ram_brg) <= (u_cluster)
	.a_mask    (core0_ilm_a_mask       ), // (u_core0_ilm_ram_brg) <= (u_cluster)
	.a_size    (core0_ilm_a_size       ), // (u_core0_ilm_ram_brg) <= (u_cluster)
	.a_parity0 (core0_ilm_a_parity0_in ), // (u_core0_ilm_ram_brg) <= ()
	.a_parity1 (core0_ilm_a_parity1_in ), // (u_core0_ilm_ram_brg) <= ()
	.d_valid   (core0_ilm_d_valid      ), // (u_core0_ilm_ram_brg) => (u_cluster)
	.d_ready   (core0_ilm_d_ready      ), // (u_core0_ilm_ram_brg) <= (u_cluster)
	.d_data    (core0_ilm_d_data       ), // (u_core0_ilm_ram_brg) => (u_cluster)
	.d_parity0 (core0_ilm_d_parity0_out), // (u_core0_ilm_ram_brg) => ()
	.d_parity1 (core0_ilm_d_parity1_out), // (u_core0_ilm_ram_brg) => ()
	.d_denied  (core0_ilm_d_denied     ), // (u_core0_ilm_ram_brg) => (u_cluster)
	.ram0_cs   (core0_ilm0_cs          ), // (u_core0_ilm_ram_brg) => (u_ilm_tl_ul_core0_ram0)
	.ram0_we   (core0_ilm0_we          ), // (u_core0_ilm_ram_brg) => (u_ilm_tl_ul_core0_ram0)
	.ram0_addr (core0_ilm0_addr        ), // (u_core0_ilm_ram_brg) => (u_ilm_tl_ul_core0_ram0)
	.ram0_wdata(core0_ilm0_wdata       ), // (u_core0_ilm_ram_brg) => (u_ilm_tl_ul_core0_ram0)
	.ram0_bwe  (core0_ilm0_bwe         ), // (u_core0_ilm_ram_brg) => (u_ilm_tl_ul_core0_ram0)
	.ram0_rdata(core0_ilm0_rdata       ), // (u_core0_ilm_ram_brg) <= (u_ilm_tl_ul_core0_ram0)
	.ram1_cs   (core0_ilm1_cs          ), // (u_core0_ilm_ram_brg) => (u_ilm_tl_ul_core0_ram1)
	.ram1_we   (core0_ilm1_we          ), // (u_core0_ilm_ram_brg) => (u_ilm_tl_ul_core0_ram1)
	.ram1_addr (core0_ilm1_addr        ), // (u_core0_ilm_ram_brg) => (u_ilm_tl_ul_core0_ram1)
	.ram1_wdata(core0_ilm1_wdata       ), // (u_core0_ilm_ram_brg) => (u_ilm_tl_ul_core0_ram1)
	.ram1_bwe  (core0_ilm1_bwe         ), // (u_core0_ilm_ram_brg) => (u_ilm_tl_ul_core0_ram1)
	.ram1_rdata(core0_ilm1_rdata       )  // (u_core0_ilm_ram_brg) <= (u_ilm_tl_ul_core0_ram1)
); // end of u_core0_ilm_ram_brg

   `ifdef NDS_IO_ILM_RAM_ECC
generate
if (ILM_TL_UL_RAM_NUM >= 1) begin : gen_tl_ul_core0_ram0

	kv_ilm_fusa_ecc_ram #(
		.ILM_RAM_AW      (ILM_TL_UL_RAM_AW),
		.ILM_RAM_CTRL_IN_WIDTH(`NDS_ILM_RAM_CTRL_IN_WIDTH),
		.ILM_RAM_CTRL_OUT_WIDTH(`NDS_ILM_RAM_CTRL_OUT_WIDTH),
		.ILM_RAM_DW      (ILM_TL_UL_RAM_DW)
	) u_ilm_tl_ul_core0_ram0 (
		.p_clk       (core0_ilm_ram_clk                   ), // (u_ilm_tl_ul_core0_ram0,u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_clock_gen)
		.r_clk       (core0_ilm_ram_clk                   ), // (u_ilm_tl_ul_core0_ram0,u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_clock_gen)
		.ilm_p_cs    (core0_ilm0_cs                       ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_r_cs    (core0_ilm0_cs                       ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_p_addr  (core0_ilm0_addr                     ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_r_addr  (core0_ilm0_addr                     ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_p_we    (core0_ilm0_we                       ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_r_we    (core0_ilm0_we                       ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_rdata   (core0_ilm0_rdata                    ), // (u_ilm_tl_ul_core0_ram0) => (u_core0_ilm_ram_brg)
		.ilm_wdata   (core0_ilm0_wdata                    ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_ctrl_in ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
		.ilm_ctrl_out(nds_unused_tl_ul_core0_ilm0_ctrl_out)  // (u_ilm_tl_ul_core0_ram0) => ()
	); // end of u_ilm_tl_ul_core0_ram0

end // end of gen_tl_ul_core0_ram0
endgenerate

generate
if (ILM_TL_UL_RAM_NUM >= 2) begin : gen_tl_ul_core0_ram1

	kv_ilm_fusa_ecc_ram #(
		.ILM_RAM_AW      (ILM_TL_UL_RAM_AW),
		.ILM_RAM_CTRL_IN_WIDTH(`NDS_ILM_RAM_CTRL_IN_WIDTH),
		.ILM_RAM_CTRL_OUT_WIDTH(`NDS_ILM_RAM_CTRL_OUT_WIDTH),
		.ILM_RAM_DW      (ILM_TL_UL_RAM_DW)
	) u_ilm_tl_ul_core0_ram1 (
		.p_clk       (core0_ilm_ram_clk                   ), // (u_ilm_tl_ul_core0_ram0,u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_clock_gen)
		.r_clk       (core0_ilm_ram_clk                   ), // (u_ilm_tl_ul_core0_ram0,u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_clock_gen)
		.ilm_p_cs    (core0_ilm1_cs                       ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_r_cs    (core0_ilm1_cs                       ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_p_addr  (core0_ilm1_addr                     ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_r_addr  (core0_ilm1_addr                     ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_p_we    (core0_ilm1_we                       ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_r_we    (core0_ilm1_we                       ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_rdata   (core0_ilm1_rdata                    ), // (u_ilm_tl_ul_core0_ram1) => (u_core0_ilm_ram_brg)
		.ilm_wdata   (core0_ilm1_wdata                    ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_ctrl_in ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
		.ilm_ctrl_out(nds_unused_tl_ul_core0_ilm1_ctrl_out)  // (u_ilm_tl_ul_core0_ram1) => ()
	); // end of u_ilm_tl_ul_core0_ram1

end // end of gen_tl_ul_core0_ram1
endgenerate

   `else
generate
if (ILM_TL_UL_RAM_NUM >= 1) begin : gen_tl_ul_core0_ram0

	kv_ilm_ram #(
		.ILM_RAM_AW      (ILM_TL_UL_RAM_AW),
		.ILM_RAM_BWEW    (ILM_TL_UL_RAM_BWEW),
		.ILM_RAM_CTRL_IN_WIDTH(`NDS_ILM_RAM_CTRL_IN_WIDTH),
		.ILM_RAM_CTRL_OUT_WIDTH(`NDS_ILM_RAM_CTRL_OUT_WIDTH),
		.ILM_RAM_DW      (ILM_TL_UL_RAM_DW)
	) u_ilm_tl_ul_core0_ram0 (
		.clk         (core0_ilm_ram_clk                   ), // (u_ilm_tl_ul_core0_ram0,u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_clock_gen)
		.ilm_cs      (core0_ilm0_cs                       ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_we      (core0_ilm0_we                       ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_addr    (core0_ilm0_addr                     ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_byte_we (core0_ilm0_bwe                      ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_wdata   (core0_ilm0_wdata                    ), // (u_ilm_tl_ul_core0_ram0) <= (u_core0_ilm_ram_brg)
		.ilm_rdata   (core0_ilm0_rdata                    ), // (u_ilm_tl_ul_core0_ram0) => (u_core0_ilm_ram_brg)
		.ilm_ctrl_in ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
		.ilm_ctrl_out(nds_unused_tl_ul_core0_ilm0_ctrl_out)  // (u_ilm_tl_ul_core0_ram0) => ()
	); // end of u_ilm_tl_ul_core0_ram0

end // end of gen_tl_ul_core0_ram0
endgenerate

generate
if (ILM_TL_UL_RAM_NUM >= 2) begin : gen_tl_ul_core0_ram1

	kv_ilm_ram #(
		.ILM_RAM_AW      (ILM_TL_UL_RAM_AW),
		.ILM_RAM_BWEW    (ILM_TL_UL_RAM_BWEW),
		.ILM_RAM_CTRL_IN_WIDTH(`NDS_ILM_RAM_CTRL_IN_WIDTH),
		.ILM_RAM_CTRL_OUT_WIDTH(`NDS_ILM_RAM_CTRL_OUT_WIDTH),
		.ILM_RAM_DW      (ILM_TL_UL_RAM_DW)
	) u_ilm_tl_ul_core0_ram1 (
		.clk         (core0_ilm_ram_clk                   ), // (u_ilm_tl_ul_core0_ram0,u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_clock_gen)
		.ilm_cs      (core0_ilm1_cs                       ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_we      (core0_ilm1_we                       ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_addr    (core0_ilm1_addr                     ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_byte_we (core0_ilm1_bwe                      ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_wdata   (core0_ilm1_wdata                    ), // (u_ilm_tl_ul_core0_ram1) <= (u_core0_ilm_ram_brg)
		.ilm_rdata   (core0_ilm1_rdata                    ), // (u_ilm_tl_ul_core0_ram1) => (u_core0_ilm_ram_brg)
		.ilm_ctrl_in ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
		.ilm_ctrl_out(nds_unused_tl_ul_core0_ilm1_ctrl_out)  // (u_ilm_tl_ul_core0_ram1) => ()
	); // end of u_ilm_tl_ul_core0_ram1

end // end of gen_tl_ul_core0_ram1
endgenerate

   `endif // NDS_IO_ILM_RAM_ECC
   `ifdef NDS_IO_DCLS_SPLIT
sample_kv_clk_gen #(
	.RATIO           (2               )
) u_core1_ilm_clock_gen (
	.clk_in (lm_clk[1]           ), // (u_core0_dlm_ram0,u_core0_ilm_clock_gen,u_core0_ilm_ram_brg,u_core1_dlm_ram0,u_core1_ilm_clock_gen,u_core1_ilm_ram_brg) <= ()
	.resetn (core1_ilm_reset_n   ), // (u_core1_ilm_clock_gen,u_core1_ilm_ram_brg) <= ()
	.clk_en (core1_ilm_ram_clk_en), // (u_core1_ilm_clock_gen) => (u_core1_ilm_ram_brg)
	.clk_out(core1_ilm_ram_clk   )  // (u_core1_ilm_clock_gen) => (u_ilm_tl_ul_core1_ram0,u_ilm_tl_ul_core1_ram1)
); // end of u_core1_ilm_clock_gen

atcrambrg500 #(
	.DS_DW           (ILM_TL_UL_RAM_DW),
	.US_AW           (ILM_TL_UL_AW    )
) u_core1_ilm_ram_brg (
	.clk       (lm_clk[1]              ), // (u_core0_dlm_ram0,u_core0_ilm_clock_gen,u_core0_ilm_ram_brg,u_core1_dlm_ram0,u_core1_ilm_clock_gen,u_core1_ilm_ram_brg) <= ()
	.clk_en    (core1_ilm_ram_clk_en   ), // (u_core1_ilm_ram_brg) <= (u_core1_ilm_clock_gen)
	.resetn    (core1_ilm_reset_n      ), // (u_core1_ilm_clock_gen,u_core1_ilm_ram_brg) <= ()
	.a_valid   (core1_ilm_a_valid      ), // (u_core1_ilm_ram_brg) <= (u_cluster)
	.a_ready   (core1_ilm_a_ready      ), // (u_core1_ilm_ram_brg) => (u_cluster)
	.a_addr    ({core1_ilm_a_addr,3'b0}), // () <= ()
	.a_data    (core1_ilm_a_data       ), // (u_core1_ilm_ram_brg) <= (u_cluster)
	.a_opcode  (core1_ilm_a_opcode     ), // (u_core1_ilm_ram_brg) <= (u_cluster)
	.a_mask    (core1_ilm_a_mask       ), // (u_core1_ilm_ram_brg) <= (u_cluster)
	.a_size    (core1_ilm_a_size       ), // (u_core1_ilm_ram_brg) <= (u_cluster)
	.a_parity0 (core1_ilm_a_parity0_in ), // (u_core1_ilm_ram_brg) <= ()
	.a_parity1 (core1_ilm_a_parity1_in ), // (u_core1_ilm_ram_brg) <= ()
	.d_valid   (core1_ilm_d_valid      ), // (u_core1_ilm_ram_brg) => (u_cluster)
	.d_ready   (core1_ilm_d_ready      ), // (u_core1_ilm_ram_brg) <= (u_cluster)
	.d_data    (core1_ilm_d_data       ), // (u_core1_ilm_ram_brg) => (u_cluster)
	.d_parity0 (core1_ilm_d_parity0_out), // (u_core1_ilm_ram_brg) => ()
	.d_parity1 (core1_ilm_d_parity1_out), // (u_core1_ilm_ram_brg) => ()
	.d_denied  (core1_ilm_d_denied     ), // (u_core1_ilm_ram_brg) => (u_cluster)
	.ram0_cs   (core1_ilm0_cs          ), // (u_core1_ilm_ram_brg) => (u_ilm_tl_ul_core1_ram0)
	.ram0_we   (core1_ilm0_we          ), // (u_core1_ilm_ram_brg) => (u_ilm_tl_ul_core1_ram0)
	.ram0_addr (core1_ilm0_addr        ), // (u_core1_ilm_ram_brg) => (u_ilm_tl_ul_core1_ram0)
	.ram0_wdata(core1_ilm0_wdata       ), // (u_core1_ilm_ram_brg) => (u_ilm_tl_ul_core1_ram0)
	.ram0_bwe  (core1_ilm0_bwe         ), // (u_core1_ilm_ram_brg) => (u_ilm_tl_ul_core1_ram0)
	.ram0_rdata(core1_ilm0_rdata       ), // (u_core1_ilm_ram_brg) <= (u_ilm_tl_ul_core1_ram0)
	.ram1_cs   (core1_ilm1_cs          ), // (u_core1_ilm_ram_brg) => (u_ilm_tl_ul_core1_ram1)
	.ram1_we   (core1_ilm1_we          ), // (u_core1_ilm_ram_brg) => (u_ilm_tl_ul_core1_ram1)
	.ram1_addr (core1_ilm1_addr        ), // (u_core1_ilm_ram_brg) => (u_ilm_tl_ul_core1_ram1)
	.ram1_wdata(core1_ilm1_wdata       ), // (u_core1_ilm_ram_brg) => (u_ilm_tl_ul_core1_ram1)
	.ram1_bwe  (core1_ilm1_bwe         ), // (u_core1_ilm_ram_brg) => (u_ilm_tl_ul_core1_ram1)
	.ram1_rdata(core1_ilm1_rdata       )  // (u_core1_ilm_ram_brg) <= (u_ilm_tl_ul_core1_ram1)
); // end of u_core1_ilm_ram_brg

      `ifdef NDS_IO_ILM_RAM_ECC
generate
if (ILM_TL_UL_RAM_NUM >= 1) begin : gen_tl_ul_core1_ram0

	kv_ilm_fusa_ecc_ram #(
		.ILM_RAM_AW      (ILM_TL_UL_RAM_AW),
		.ILM_RAM_CTRL_IN_WIDTH(`NDS_ILM_RAM_CTRL_IN_WIDTH),
		.ILM_RAM_CTRL_OUT_WIDTH(`NDS_ILM_RAM_CTRL_OUT_WIDTH),
		.ILM_RAM_DW      (ILM_TL_UL_RAM_DW)
	) u_ilm_tl_ul_core1_ram0 (
		.p_clk       (core1_ilm_ram_clk                   ), // (u_ilm_tl_ul_core1_ram0,u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_clock_gen)
		.r_clk       (core1_ilm_ram_clk                   ), // (u_ilm_tl_ul_core1_ram0,u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_clock_gen)
		.ilm_p_cs    (core1_ilm0_cs                       ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_r_cs    (core1_ilm0_cs                       ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_p_addr  (core1_ilm0_addr                     ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_r_addr  (core1_ilm0_addr                     ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_p_we    (core1_ilm0_we                       ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_r_we    (core1_ilm0_we                       ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_rdata   (core1_ilm0_rdata                    ), // (u_ilm_tl_ul_core1_ram0) => (u_core1_ilm_ram_brg)
		.ilm_wdata   (core1_ilm0_wdata                    ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_ctrl_in ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
		.ilm_ctrl_out(nds_unused_tl_ul_core1_ilm0_ctrl_out)  // (u_ilm_tl_ul_core1_ram0) => ()
	); // end of u_ilm_tl_ul_core1_ram0

end // end of gen_tl_ul_core1_ram0
endgenerate

generate
if (ILM_TL_UL_RAM_NUM >= 2) begin : gen_tl_ul_core1_ram1

	kv_ilm_fusa_ecc_ram #(
		.ILM_RAM_AW      (ILM_TL_UL_RAM_AW),
		.ILM_RAM_CTRL_IN_WIDTH(`NDS_ILM_RAM_CTRL_IN_WIDTH),
		.ILM_RAM_CTRL_OUT_WIDTH(`NDS_ILM_RAM_CTRL_OUT_WIDTH),
		.ILM_RAM_DW      (ILM_TL_UL_RAM_DW)
	) u_ilm_tl_ul_core1_ram1 (
		.p_clk       (core1_ilm_ram_clk                   ), // (u_ilm_tl_ul_core1_ram0,u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_clock_gen)
		.r_clk       (core1_ilm_ram_clk                   ), // (u_ilm_tl_ul_core1_ram0,u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_clock_gen)
		.ilm_p_cs    (core1_ilm1_cs                       ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_r_cs    (core1_ilm1_cs                       ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_p_addr  (core1_ilm1_addr                     ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_r_addr  (core1_ilm1_addr                     ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_p_we    (core1_ilm1_we                       ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_r_we    (core1_ilm1_we                       ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_rdata   (core1_ilm1_rdata                    ), // (u_ilm_tl_ul_core1_ram1) => (u_core1_ilm_ram_brg)
		.ilm_wdata   (core1_ilm1_wdata                    ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_ctrl_in ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
		.ilm_ctrl_out(nds_unused_tl_ul_core1_ilm1_ctrl_out)  // (u_ilm_tl_ul_core1_ram1) => ()
	); // end of u_ilm_tl_ul_core1_ram1

end // end of gen_tl_ul_core1_ram1
endgenerate

      `else
generate
if (ILM_TL_UL_RAM_NUM >= 1) begin : gen_tl_ul_core1_ram0

	kv_ilm_ram #(
		.ILM_RAM_AW      (ILM_TL_UL_RAM_AW),
		.ILM_RAM_BWEW    (ILM_TL_UL_RAM_BWEW),
		.ILM_RAM_CTRL_IN_WIDTH(`NDS_ILM_RAM_CTRL_IN_WIDTH),
		.ILM_RAM_CTRL_OUT_WIDTH(`NDS_ILM_RAM_CTRL_OUT_WIDTH),
		.ILM_RAM_DW      (ILM_TL_UL_RAM_DW)
	) u_ilm_tl_ul_core1_ram0 (
		.clk         (core1_ilm_ram_clk                   ), // (u_ilm_tl_ul_core1_ram0,u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_clock_gen)
		.ilm_cs      (core1_ilm0_cs                       ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_we      (core1_ilm0_we                       ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_addr    (core1_ilm0_addr                     ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_byte_we (core1_ilm0_bwe                      ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_wdata   (core1_ilm0_wdata                    ), // (u_ilm_tl_ul_core1_ram0) <= (u_core1_ilm_ram_brg)
		.ilm_rdata   (core1_ilm0_rdata                    ), // (u_ilm_tl_ul_core1_ram0) => (u_core1_ilm_ram_brg)
		.ilm_ctrl_in ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
		.ilm_ctrl_out(nds_unused_tl_ul_core1_ilm0_ctrl_out)  // (u_ilm_tl_ul_core1_ram0) => ()
	); // end of u_ilm_tl_ul_core1_ram0

end // end of gen_tl_ul_core1_ram0
endgenerate

generate
if (ILM_TL_UL_RAM_NUM >= 2) begin : gen_tl_ul_core1_ram1

	kv_ilm_ram #(
		.ILM_RAM_AW      (ILM_TL_UL_RAM_AW),
		.ILM_RAM_BWEW    (ILM_TL_UL_RAM_BWEW),
		.ILM_RAM_CTRL_IN_WIDTH(`NDS_ILM_RAM_CTRL_IN_WIDTH),
		.ILM_RAM_CTRL_OUT_WIDTH(`NDS_ILM_RAM_CTRL_OUT_WIDTH),
		.ILM_RAM_DW      (ILM_TL_UL_RAM_DW)
	) u_ilm_tl_ul_core1_ram1 (
		.clk         (core1_ilm_ram_clk                   ), // (u_ilm_tl_ul_core1_ram0,u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_clock_gen)
		.ilm_cs      (core1_ilm1_cs                       ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_we      (core1_ilm1_we                       ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_addr    (core1_ilm1_addr                     ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_byte_we (core1_ilm1_bwe                      ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_wdata   (core1_ilm1_wdata                    ), // (u_ilm_tl_ul_core1_ram1) <= (u_core1_ilm_ram_brg)
		.ilm_rdata   (core1_ilm1_rdata                    ), // (u_ilm_tl_ul_core1_ram1) => (u_core1_ilm_ram_brg)
		.ilm_ctrl_in ({`NDS_ILM_RAM_CTRL_IN_WIDTH{1'b0}}  ), // () <= ()
		.ilm_ctrl_out(nds_unused_tl_ul_core1_ilm1_ctrl_out)  // (u_ilm_tl_ul_core1_ram1) => ()
	); // end of u_ilm_tl_ul_core1_ram1

end // end of gen_tl_ul_core1_ram1
endgenerate

      `endif // NDS_IO_ILM_RAM_ECC
   `endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_ILM_TL_UL
atcbmc301 #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (BIU_DATA_WIDTH  )
) u_axi_bmc (
`ifdef ATCBMC301_MST0_SUPPORT
	.us0_araddr (axi_sys0_araddr                      ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_arburst(axi_sys0_arburst                     ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_arcache(axi_sys0_arcache                     ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_arid   (axi_sys0_arid                        ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_arlen  (axi_sys0_arlen                       ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_arlock (axi_sys0_arlock                      ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_arprot (axi_sys0_arprot                      ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_arready(axi_sys0_arready                     ), // (u_axi_bmc) => (u_sys0_ingress)
	.us0_arsize (axi_sys0_arsize                      ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_arvalid(axi_sys0_arvalid                     ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_awaddr (axi_sys0_awaddr                      ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_awburst(axi_sys0_awburst                     ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_awcache(axi_sys0_awcache                     ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_awid   (axi_sys0_awid                        ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_awlen  (axi_sys0_awlen                       ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_awlock (axi_sys0_awlock                      ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_awprot (axi_sys0_awprot                      ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_awready(axi_sys0_awready                     ), // (u_axi_bmc) => (u_sys0_ingress)
	.us0_awsize (axi_sys0_awsize                      ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_awvalid(axi_sys0_awvalid                     ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_bid    (axi_sys0_bid                         ), // (u_axi_bmc) => (u_sys0_ingress)
	.us0_bready (axi_sys0_bready                      ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_bresp  (axi_sys0_bresp                       ), // (u_axi_bmc) => (u_sys0_ingress)
	.us0_bvalid (axi_sys0_bvalid                      ), // (u_axi_bmc) => (u_sys0_ingress)
	.us0_rdata  (axi_sys0_rdata                       ), // (u_axi_bmc) => (u_sys0_ingress)
	.us0_rid    (axi_sys0_rid                         ), // (u_axi_bmc) => (u_sys0_ingress)
	.us0_rlast  (axi_sys0_rlast                       ), // (u_axi_bmc) => (u_sys0_ingress)
	.us0_rready (axi_sys0_rready                      ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_rresp  (axi_sys0_rresp                       ), // (u_axi_bmc) => (u_sys0_ingress)
	.us0_rvalid (axi_sys0_rvalid                      ), // (u_axi_bmc) => (u_sys0_ingress)
	.us0_wdata  (axi_sys0_wdata                       ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_wlast  (axi_sys0_wlast                       ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_wready (axi_sys0_wready                      ), // (u_axi_bmc) => (u_sys0_ingress)
	.us0_wstrb  (axi_sys0_wstrb                       ), // (u_axi_bmc) <= (u_sys0_ingress)
	.us0_wvalid (axi_sys0_wvalid                      ), // (u_axi_bmc) <= (u_sys0_ingress)
`endif // ATCBMC301_MST0_SUPPORT
`ifdef ATCBMC301_SLV1_SUPPORT
	.ds1_araddr (inter_ds1_araddr                     ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_arburst(inter_ds1_arburst                    ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_arcache(inter_ds1_arcache                    ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_arid   ({inter_ds1_arid,inter_ds1_arid_dummy}), // () => ()
	.ds1_arlen  (inter_ds1_arlen                      ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_arlock (inter_ds1_arlock                     ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_arprot (inter_ds1_arprot                     ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_arready(inter_ds1_arready                    ), // (u_axi_bmc) <= (u_axi_sdn)
	.ds1_arsize (inter_ds1_arsize                     ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_arvalid(inter_ds1_arvalid                    ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_awaddr (inter_ds1_awaddr                     ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_awburst(inter_ds1_awburst                    ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_awcache(inter_ds1_awcache                    ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_awid   ({inter_ds1_awid,inter_ds1_awid_dummy}), // () => ()
	.ds1_awlen  (inter_ds1_awlen                      ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_awlock (inter_ds1_awlock                     ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_awprot (inter_ds1_awprot                     ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_awready(inter_ds1_awready                    ), // (u_axi_bmc) <= (u_axi_sdn)
	.ds1_awsize (inter_ds1_awsize                     ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_awvalid(inter_ds1_awvalid                    ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_bid    ({inter_ds1_bid,inter_ds1_bid_dummy}  ), // () <= ()
	.ds1_bready (inter_ds1_bready                     ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_bresp  (inter_ds1_bresp                      ), // (u_axi_bmc) <= (u_axi_sdn)
	.ds1_bvalid (inter_ds1_bvalid                     ), // (u_axi_bmc) <= (u_axi_sdn)
	.ds1_rdata  (inter_ds1_rdata                      ), // (u_axi_bmc) <= (u_axi_sdn)
	.ds1_rid    ({inter_ds1_rid,inter_ds1_rid_dummy}  ), // () <= ()
	.ds1_rlast  (inter_ds1_rlast                      ), // (u_axi_bmc) <= (u_axi_sdn)
	.ds1_rready (inter_ds1_rready                     ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_rresp  (inter_ds1_rresp                      ), // (u_axi_bmc) <= (u_axi_sdn)
	.ds1_rvalid (inter_ds1_rvalid                     ), // (u_axi_bmc) <= (u_axi_sdn)
	.ds1_wdata  (inter_ds1_wdata                      ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_wlast  (inter_ds1_wlast                      ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_wready (inter_ds1_wready                     ), // (u_axi_bmc) <= (u_axi_sdn)
	.ds1_wstrb  (inter_ds1_wstrb                      ), // (u_axi_bmc) => (u_axi_sdn)
	.ds1_wvalid (inter_ds1_wvalid                     ), // (u_axi_bmc) => (u_axi_sdn)
`endif // ATCBMC301_SLV1_SUPPORT
`ifdef ATCBMC301_SLV2_SUPPORT
	.ds2_araddr (sys_exmon_araddr                     ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_arburst(sys_exmon_arburst                    ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_arcache(sys_exmon_arcache                    ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_arid   ({sys_exmon_arid,sys_exmon_arid_dummy}), // () => ()
	.ds2_arlen  (sys_exmon_arlen                      ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_arlock (sys_exmon_arlock                     ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_arprot (sys_exmon_arprot                     ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_arready(sys_exmon_arready                    ), // (u_axi_bmc) <= (u_atcexmon300)
	.ds2_arsize (sys_exmon_arsize                     ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_arvalid(sys_exmon_arvalid                    ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_awaddr (sys_exmon_awaddr                     ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_awburst(sys_exmon_awburst                    ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_awcache(sys_exmon_awcache                    ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_awid   ({sys_exmon_awid,sys_exmon_awid_dummy}), // () => ()
	.ds2_awlen  (sys_exmon_awlen                      ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_awlock (sys_exmon_awlock                     ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_awprot (sys_exmon_awprot                     ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_awready(sys_exmon_awready                    ), // (u_axi_bmc) <= (u_atcexmon300)
	.ds2_awsize (sys_exmon_awsize                     ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_awvalid(sys_exmon_awvalid                    ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_bid    ({sys_exmon_bid,sys_exmon_bid_dummy}  ), // () <= ()
	.ds2_bready (sys_exmon_bready                     ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_bresp  (sys_exmon_bresp                      ), // (u_axi_bmc) <= (u_atcexmon300)
	.ds2_bvalid (sys_exmon_bvalid                     ), // (u_axi_bmc) <= (u_atcexmon300)
	.ds2_rdata  (sys_exmon_rdata                      ), // (u_axi_bmc) <= (u_atcexmon300)
	.ds2_rid    ({sys_exmon_rid,sys_exmon_rid_dummy}  ), // () <= ()
	.ds2_rlast  (sys_exmon_rlast                      ), // (u_axi_bmc) <= (u_atcexmon300)
	.ds2_rready (sys_exmon_rready                     ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_rresp  (sys_exmon_rresp                      ), // (u_axi_bmc) <= (u_atcexmon300)
	.ds2_rvalid (sys_exmon_rvalid                     ), // (u_axi_bmc) <= (u_atcexmon300)
	.ds2_wdata  (sys_exmon_wdata                      ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_wlast  (sys_exmon_wlast                      ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_wready (sys_exmon_wready                     ), // (u_axi_bmc) <= (u_atcexmon300)
	.ds2_wstrb  (sys_exmon_wstrb                      ), // (u_axi_bmc) => (u_atcexmon300)
	.ds2_wvalid (sys_exmon_wvalid                     ), // (u_axi_bmc) => (u_atcexmon300)
`endif // ATCBMC301_SLV2_SUPPORT
`ifdef ATCBMC301_SLV3_SUPPORT
	.ds3_araddr (flash0_araddr                        ), // (u_axi_bmc) => ()
	.ds3_arburst(flash0_arburst                       ), // (u_axi_bmc) => ()
	.ds3_arcache(flash0_arcache                       ), // (u_axi_bmc) => ()
	.ds3_arid   ({flash0_arid,flash0_arid_dummy}      ), // () => ()
	.ds3_arlen  (flash0_arlen                         ), // (u_axi_bmc) => ()
	.ds3_arlock (flash0_arlock                        ), // (u_axi_bmc) => ()
	.ds3_arprot (flash0_arprot                        ), // (u_axi_bmc) => ()
	.ds3_arready(flash0_arready                       ), // (u_axi_bmc) <= ()
	.ds3_arsize (flash0_arsize                        ), // (u_axi_bmc) => ()
	.ds3_arvalid(flash0_arvalid                       ), // (u_axi_bmc) => ()
	.ds3_awaddr (flash0_awaddr                        ), // (u_axi_bmc) => ()
	.ds3_awburst(flash0_awburst                       ), // (u_axi_bmc) => ()
	.ds3_awcache(flash0_awcache                       ), // (u_axi_bmc) => ()
	.ds3_awid   ({flash0_awid,flash0_awid_dummy}      ), // () => ()
	.ds3_awlen  (flash0_awlen                         ), // (u_axi_bmc) => ()
	.ds3_awlock (flash0_awlock                        ), // (u_axi_bmc) => ()
	.ds3_awprot (flash0_awprot                        ), // (u_axi_bmc) => ()
	.ds3_awready(flash0_awready                       ), // (u_axi_bmc) <= ()
	.ds3_awsize (flash0_awsize                        ), // (u_axi_bmc) => ()
	.ds3_awvalid(flash0_awvalid                       ), // (u_axi_bmc) => ()
	.ds3_bid    ({flash0_bid,flash0_bid_dummy}        ), // () <= ()
	.ds3_bready (flash0_bready                        ), // (u_axi_bmc) => ()
	.ds3_bresp  (flash0_bresp                         ), // (u_axi_bmc) <= ()
	.ds3_bvalid (flash0_bvalid                        ), // (u_axi_bmc) <= ()
	.ds3_rdata  (flash0_rdata                         ), // (u_axi_bmc) <= ()
	.ds3_rid    ({flash0_rid,flash0_rid_dummy}        ), // () <= ()
	.ds3_rlast  (flash0_rlast                         ), // (u_axi_bmc) <= ()
	.ds3_rready (flash0_rready                        ), // (u_axi_bmc) => ()
	.ds3_rresp  (flash0_rresp                         ), // (u_axi_bmc) <= ()
	.ds3_rvalid (flash0_rvalid                        ), // (u_axi_bmc) <= ()
	.ds3_wdata  (flash0_wdata                         ), // (u_axi_bmc) => ()
	.ds3_wlast  (flash0_wlast                         ), // (u_axi_bmc) => ()
	.ds3_wready (flash0_wready                        ), // (u_axi_bmc) <= ()
	.ds3_wstrb  (flash0_wstrb                         ), // (u_axi_bmc) => ()
	.ds3_wvalid (flash0_wvalid                        ), // (u_axi_bmc) => ()
`endif // ATCBMC301_SLV3_SUPPORT
`ifdef ATCBMC301_MST1_SUPPORT
	.us1_araddr (axi_flash0_araddr                    ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_arburst(axi_flash0_arburst                   ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_arcache(axi_flash0_arcache                   ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_arid   (axi_flash0_arid                      ), // (u_axi_bmc) <= ()
	.us1_arlen  (axi_flash0_arlen                     ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_arlock (axi_flash0_arlock                    ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_arprot (axi_flash0_arprot                    ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_arready(axi_flash0_arready                   ), // (u_axi_bmc) => (u_flash0_ingress)
	.us1_arsize (axi_flash0_arsize                    ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_arvalid(axi_flash0_arvalid                   ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_awaddr (axi_flash0_awaddr                    ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_awburst(axi_flash0_awburst                   ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_awcache(axi_flash0_awcache                   ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_awid   (axi_flash0_awid                      ), // (u_axi_bmc) <= ()
	.us1_awlen  (axi_flash0_awlen                     ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_awlock (axi_flash0_awlock                    ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_awprot (axi_flash0_awprot                    ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_awready(axi_flash0_awready                   ), // (u_axi_bmc) => (u_flash0_ingress)
	.us1_awsize (axi_flash0_awsize                    ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_awvalid(axi_flash0_awvalid                   ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_bid    (axi_flash0_bid                       ), // (u_axi_bmc) => ()
	.us1_bready (axi_flash0_bready                    ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_bresp  (axi_flash0_bresp                     ), // (u_axi_bmc) => (u_flash0_ingress)
	.us1_bvalid (axi_flash0_bvalid                    ), // (u_axi_bmc) => (u_flash0_ingress)
	.us1_rdata  (axi_flash0_rdata                     ), // (u_axi_bmc) => (u_flash0_ingress)
	.us1_rid    (axi_flash0_rid                       ), // (u_axi_bmc) => ()
	.us1_rlast  (axi_flash0_rlast                     ), // (u_axi_bmc) => (u_flash0_ingress)
	.us1_rready (axi_flash0_rready                    ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_rresp  (axi_flash0_rresp                     ), // (u_axi_bmc) => (u_flash0_ingress)
	.us1_rvalid (axi_flash0_rvalid                    ), // (u_axi_bmc) => (u_flash0_ingress)
	.us1_wdata  (axi_flash0_wdata                     ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_wlast  (axi_flash0_wlast                     ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_wready (axi_flash0_wready                    ), // (u_axi_bmc) => (u_flash0_ingress)
	.us1_wstrb  (axi_flash0_wstrb                     ), // (u_axi_bmc) <= (u_flash0_ingress)
	.us1_wvalid (axi_flash0_wvalid                    ), // (u_axi_bmc) <= (u_flash0_ingress)
`endif // ATCBMC301_MST1_SUPPORT
	.aclk       (aclk                                 ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.aresetn    (aresetn                              )  // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
); // end of u_axi_bmc

`ifdef NDS_IO_SPP
`else
generate
if ((BIU_DATA_WIDTH > NCE_DATA_WIDTH)) begin : gen_axi_sdn

	atcsizedn300 #(
		.ADDR_WIDTH      (ADDR_WIDTH      ),
		.DS_DATA_WIDTH   (NCE_DATA_WIDTH  ),
		.ID_WIDTH        (BIU_ID_WIDTH+4  ),
		.US_DATA_WIDTH   (BIU_DATA_WIDTH  )
	) u_axi_sdn (
		.ds_bready (sdn_bready                           ), // (u_axi_sdn) => ()
		.ds_bresp  (sdn_bresp                            ), // (u_axi_sdn) <= ()
		.ds_bvalid (sdn_bvalid                           ), // (u_axi_sdn) <= ()
		.ds_rdata  (sdn_rdata                            ), // (u_axi_sdn) <= ()
		.ds_rlast  (sdn_rlast                            ), // (u_axi_sdn) <= ()
		.ds_rready (sdn_rready                           ), // (u_axi_sdn) => ()
		.ds_rresp  (sdn_rresp                            ), // (u_axi_sdn) <= ()
		.ds_rvalid (sdn_rvalid                           ), // (u_axi_sdn) <= ()
		.ds_wdata  (sdn_wdata                            ), // (u_axi_sdn) => ()
		.ds_wlast  (sdn_wlast                            ), // (u_axi_sdn) => ()
		.ds_wready (sdn_wready                           ), // (u_axi_sdn) <= ()
		.ds_wstrb  (sdn_wstrb                            ), // (u_axi_sdn) => ()
		.ds_wvalid (sdn_wvalid                           ), // (u_axi_sdn) => ()
		.us_bid    ({inter_ds1_bid,inter_ds1_bid_dummy}  ), // () => ()
		.us_bready (inter_ds1_bready                     ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_bresp  (inter_ds1_bresp                      ), // (u_axi_sdn) => (u_axi_bmc)
		.us_bvalid (inter_ds1_bvalid                     ), // (u_axi_sdn) => (u_axi_bmc)
		.us_rdata  (inter_ds1_rdata                      ), // (u_axi_sdn) => (u_axi_bmc)
		.us_rid    ({inter_ds1_rid,inter_ds1_rid_dummy}  ), // () => ()
		.us_rlast  (inter_ds1_rlast                      ), // (u_axi_sdn) => (u_axi_bmc)
		.us_rready (inter_ds1_rready                     ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_rresp  (inter_ds1_rresp                      ), // (u_axi_sdn) => (u_axi_bmc)
		.us_rvalid (inter_ds1_rvalid                     ), // (u_axi_sdn) => (u_axi_bmc)
		.us_wdata  (inter_ds1_wdata                      ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_wlast  (inter_ds1_wlast                      ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_wready (inter_ds1_wready                     ), // (u_axi_sdn) => (u_axi_bmc)
		.us_wstrb  (inter_ds1_wstrb                      ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_wvalid (inter_ds1_wvalid                     ), // (u_axi_sdn) <= (u_axi_bmc)
		.ds_arready(sdn_arready                          ), // (u_axi_sdn) <= ()
		.aclk      (aclk                                 ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
		.aresetn   (aresetn                              ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
		.ds_awready(sdn_awready                          ), // (u_axi_sdn) <= ()
		.ds_araddr (sdn_araddr                           ), // (u_axi_sdn) => ()
		.ds_arburst(sdn_arburst                          ), // (u_axi_sdn) => ()
		.ds_arcache(sdn_arcache                          ), // (u_axi_sdn) => ()
		.ds_arlen  (sdn_arlen                            ), // (u_axi_sdn) => ()
		.ds_arlock (sdn_arlock                           ), // (u_axi_sdn) => ()
		.ds_arprot (sdn_arprot                           ), // (u_axi_sdn) => ()
		.ds_arsize (sdn_arsize                           ), // (u_axi_sdn) => ()
		.ds_arvalid(sdn_arvalid                          ), // (u_axi_sdn) => ()
		.us_araddr (inter_ds1_araddr                     ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_arburst(inter_ds1_arburst                    ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_arcache(inter_ds1_arcache                    ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_arid   ({inter_ds1_arid,inter_ds1_arid_dummy}), // () <= ()
		.us_arlen  (inter_ds1_arlen                      ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_arlock (inter_ds1_arlock                     ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_arprot (inter_ds1_arprot                     ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_arready(inter_ds1_arready                    ), // (u_axi_sdn) => (u_axi_bmc)
		.us_arsize (inter_ds1_arsize                     ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_arvalid(inter_ds1_arvalid                    ), // (u_axi_sdn) <= (u_axi_bmc)
		.ds_awaddr (sdn_awaddr                           ), // (u_axi_sdn) => ()
		.ds_awburst(sdn_awburst                          ), // (u_axi_sdn) => ()
		.ds_awcache(sdn_awcache                          ), // (u_axi_sdn) => ()
		.ds_awlen  (sdn_awlen                            ), // (u_axi_sdn) => ()
		.ds_awlock (sdn_awlock                           ), // (u_axi_sdn) => ()
		.ds_awprot (sdn_awprot                           ), // (u_axi_sdn) => ()
		.ds_awsize (sdn_awsize                           ), // (u_axi_sdn) => ()
		.ds_awvalid(sdn_awvalid                          ), // (u_axi_sdn) => ()
		.us_awaddr (inter_ds1_awaddr                     ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_awburst(inter_ds1_awburst                    ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_awcache(inter_ds1_awcache                    ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_awid   ({inter_ds1_awid,inter_ds1_awid_dummy}), // () <= ()
		.us_awlen  (inter_ds1_awlen                      ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_awlock (inter_ds1_awlock                     ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_awprot (inter_ds1_awprot                     ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_awready(inter_ds1_awready                    ), // (u_axi_sdn) => (u_axi_bmc)
		.us_awsize (inter_ds1_awsize                     ), // (u_axi_sdn) <= (u_axi_bmc)
		.us_awvalid(inter_ds1_awvalid                    )  // (u_axi_sdn) <= (u_axi_bmc)
	); // end of u_axi_sdn

end // end of gen_axi_sdn
endgenerate

`endif // NDS_IO_SPP
atcexmon300 #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (BIU_DATA_WIDTH  ),
	.ID_WIDTH        (BIU_ID_WIDTH    ),
	.NUM_EX_SEQ      (8               )
) u_atcexmon300 (
	.aclk       (aclk               ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.aresetn    (aresetn            ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.us_awid    (sys_exmon_awid     ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_awaddr  (sys_exmon_awaddr   ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_awlock  (sys_exmon_awlock   ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_awburst (sys_exmon_awburst  ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_awlen   (sys_exmon_awlen    ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_awcache (sys_exmon_awcache  ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_awprot  (sys_exmon_awprot   ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_awsize  (sys_exmon_awsize   ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_awqos   (4'b0               ), // (u_atcexmon300) <= ()
	.us_awregion(4'b0               ), // (u_atcexmon300) <= ()
	.us_awvalid (sys_exmon_awvalid  ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_awready (sys_exmon_awready  ), // (u_atcexmon300) => (u_axi_bmc)
	.us_wdata   (sys_exmon_wdata    ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_wstrb   (sys_exmon_wstrb    ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_wlast   (sys_exmon_wlast    ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_wvalid  (sys_exmon_wvalid   ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_wready  (sys_exmon_wready   ), // (u_atcexmon300) => (u_axi_bmc)
	.us_bresp   (sys_exmon_bresp    ), // (u_atcexmon300) => (u_axi_bmc)
	.us_bid     (sys_exmon_bid      ), // (u_atcexmon300) => (u_axi_bmc)
	.us_bvalid  (sys_exmon_bvalid   ), // (u_atcexmon300) => (u_axi_bmc)
	.us_bready  (sys_exmon_bready   ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_arid    (sys_exmon_arid     ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_araddr  (sys_exmon_araddr   ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_arlock  (sys_exmon_arlock   ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_arburst (sys_exmon_arburst  ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_arlen   (sys_exmon_arlen    ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_arcache (sys_exmon_arcache  ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_arprot  (sys_exmon_arprot   ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_arsize  (sys_exmon_arsize   ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_arqos   (4'b0               ), // (u_atcexmon300) <= ()
	.us_arregion(4'b0               ), // (u_atcexmon300) <= ()
	.us_arvalid (sys_exmon_arvalid  ), // (u_atcexmon300) <= (u_axi_bmc)
	.us_arready (sys_exmon_arready  ), // (u_atcexmon300) => (u_axi_bmc)
	.us_rid     (sys_exmon_rid      ), // (u_atcexmon300) => (u_axi_bmc)
	.us_rresp   (sys_exmon_rresp    ), // (u_atcexmon300) => (u_axi_bmc)
	.us_rdata   (sys_exmon_rdata    ), // (u_atcexmon300) => (u_axi_bmc)
	.us_rlast   (sys_exmon_rlast    ), // (u_atcexmon300) => (u_axi_bmc)
	.us_rvalid  (sys_exmon_rvalid   ), // (u_atcexmon300) => (u_axi_bmc)
	.us_rready  (sys_exmon_rready   ), // (u_atcexmon300) <= (u_axi_bmc)
	.ds_awid    (sys_awid           ), // (u_atcexmon300) => ()
	.ds_awaddr  (sys_awaddr         ), // (u_atcexmon300) => ()
	.ds_awlock  (sys_awlock         ), // (u_atcexmon300) => ()
	.ds_awburst (sys_awburst        ), // (u_atcexmon300) => ()
	.ds_awlen   (sys_awlen          ), // (u_atcexmon300) => ()
	.ds_awcache (sys_awcache        ), // (u_atcexmon300) => ()
	.ds_awprot  (sys_awprot         ), // (u_atcexmon300) => ()
	.ds_awsize  (sys_awsize         ), // (u_atcexmon300) => ()
	.ds_awqos   (nds_unused_awqos   ), // (u_atcexmon300) => ()
	.ds_awregion(nds_unused_awregion), // (u_atcexmon300) => ()
	.ds_awvalid (sys_awvalid        ), // (u_atcexmon300) => ()
	.ds_awready (sys_awready        ), // (u_atcexmon300) <= ()
	.ds_wdata   (sys_wdata          ), // (u_atcexmon300) => ()
	.ds_wstrb   (sys_wstrb          ), // (u_atcexmon300) => ()
	.ds_wlast   (sys_wlast          ), // (u_atcexmon300) => ()
	.ds_wvalid  (sys_wvalid         ), // (u_atcexmon300) => ()
	.ds_wready  (sys_wready         ), // (u_atcexmon300) <= ()
	.ds_bresp   (sys_bresp          ), // (u_atcexmon300) <= ()
	.ds_bid     (sys_bid            ), // (u_atcexmon300) <= ()
	.ds_bvalid  (sys_bvalid         ), // (u_atcexmon300) <= ()
	.ds_bready  (sys_bready         ), // (u_atcexmon300) => ()
	.ds_arid    (sys_arid           ), // (u_atcexmon300) => ()
	.ds_araddr  (sys_araddr         ), // (u_atcexmon300) => ()
	.ds_arlock  (sys_arlock         ), // (u_atcexmon300) => ()
	.ds_arburst (sys_arburst        ), // (u_atcexmon300) => ()
	.ds_arlen   (sys_arlen          ), // (u_atcexmon300) => ()
	.ds_arcache (sys_arcache        ), // (u_atcexmon300) => ()
	.ds_arprot  (sys_arprot         ), // (u_atcexmon300) => ()
	.ds_arsize  (sys_arsize         ), // (u_atcexmon300) => ()
	.ds_arqos   (nds_unused_arqos   ), // (u_atcexmon300) => ()
	.ds_arregion(nds_unused_arregion), // (u_atcexmon300) => ()
	.ds_arvalid (sys_arvalid        ), // (u_atcexmon300) => ()
	.ds_arready (sys_arready        ), // (u_atcexmon300) <= ()
	.ds_rid     (sys_rid            ), // (u_atcexmon300) <= ()
	.ds_rresp   (sys_rresp          ), // (u_atcexmon300) <= ()
	.ds_rdata   (sys_rdata          ), // (u_atcexmon300) <= ()
	.ds_rlast   (sys_rlast          ), // (u_atcexmon300) <= ()
	.ds_rvalid  (sys_rvalid         ), // (u_atcexmon300) <= ()
	.ds_rready  (sys_rready         )  // (u_atcexmon300) => ()
); // end of u_atcexmon300

atcbusdec301 #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (NCE_DATA_WIDTH  ),
	.ID_WIDTH        (BIU_ID_WIDTH+4  )
) u_axi_busdec (
`ifdef ATCBUSDEC301_SLV1_SUPPORT
	.ds1_awvalid(plic_awvalid      ), // (u_axi_busdec) => (u_plic)
	.ds1_awready(plic_awready      ), // (u_axi_busdec) <= (u_plic)
	.ds1_wvalid (plic_wvalid       ), // (u_axi_busdec) => (u_plic)
	.ds1_wready (plic_wready       ), // (u_axi_busdec) <= (u_plic)
	.ds1_bresp  (plic_bresp        ), // (u_axi_busdec) <= (u_plic)
	.ds1_bvalid (plic_bvalid       ), // (u_axi_busdec) <= (u_plic)
	.ds1_bready (plic_bready       ), // (u_axi_busdec) => (u_plic)
	.ds1_arvalid(plic_arvalid      ), // (u_axi_busdec) => (u_plic)
	.ds1_arready(plic_arready      ), // (u_axi_busdec) <= (u_plic)
	.ds1_rdata  (plic_rdata        ), // (u_axi_busdec) <= (u_plic)
	.ds1_rresp  (plic_rresp        ), // (u_axi_busdec) <= (u_plic)
	.ds1_rlast  (plic_rlast        ), // (u_axi_busdec) <= (u_plic)
	.ds1_rvalid (plic_rvalid       ), // (u_axi_busdec) <= (u_plic)
	.ds1_rready (plic_rready       ), // (u_axi_busdec) => (u_plic)
`endif // ATCBUSDEC301_SLV1_SUPPORT
`ifdef ATCBUSDEC301_SLV2_SUPPORT
	.ds2_awvalid(plmt_awvalid      ), // (u_axi_busdec) => (u_plmt)
	.ds2_awready(plmt_awready      ), // (u_axi_busdec) <= (u_plmt)
	.ds2_wvalid (plmt_wvalid       ), // (u_axi_busdec) => (u_plmt)
	.ds2_wready (plmt_wready       ), // (u_axi_busdec) <= (u_plmt)
	.ds2_bresp  (plmt_bresp        ), // (u_axi_busdec) <= (u_plmt)
	.ds2_bvalid (plmt_bvalid       ), // (u_axi_busdec) <= (u_plmt)
	.ds2_bready (plmt_bready       ), // (u_axi_busdec) => (u_plmt)
	.ds2_arvalid(plmt_arvalid      ), // (u_axi_busdec) => (u_plmt)
	.ds2_arready(plmt_arready      ), // (u_axi_busdec) <= (u_plmt)
	.ds2_rdata  (plmt_rdata        ), // (u_axi_busdec) <= (u_plmt)
	.ds2_rresp  (plmt_rresp        ), // (u_axi_busdec) <= (u_plmt)
	.ds2_rlast  (plmt_rlast        ), // (u_axi_busdec) <= (u_plmt)
	.ds2_rvalid (plmt_rvalid       ), // (u_axi_busdec) <= (u_plmt)
	.ds2_rready (plmt_rready       ), // (u_axi_busdec) => (u_plmt)
`endif // ATCBUSDEC301_SLV2_SUPPORT
`ifdef ATCBUSDEC301_SLV3_SUPPORT
	.ds3_awvalid(plicsw_awvalid    ), // (u_axi_busdec) => (u_plic_sw)
	.ds3_awready(plicsw_awready    ), // (u_axi_busdec) <= (u_plic_sw)
	.ds3_wvalid (plicsw_wvalid     ), // (u_axi_busdec) => (u_plic_sw)
	.ds3_wready (plicsw_wready     ), // (u_axi_busdec) <= (u_plic_sw)
	.ds3_bresp  (plicsw_bresp      ), // (u_axi_busdec) <= (u_plic_sw)
	.ds3_bvalid (plicsw_bvalid     ), // (u_axi_busdec) <= (u_plic_sw)
	.ds3_bready (plicsw_bready     ), // (u_axi_busdec) => (u_plic_sw)
	.ds3_arvalid(plicsw_arvalid    ), // (u_axi_busdec) => (u_plic_sw)
	.ds3_arready(plicsw_arready    ), // (u_axi_busdec) <= (u_plic_sw)
	.ds3_rdata  (plicsw_rdata      ), // (u_axi_busdec) <= (u_plic_sw)
	.ds3_rresp  (plicsw_rresp      ), // (u_axi_busdec) <= (u_plic_sw)
	.ds3_rlast  (plicsw_rlast      ), // (u_axi_busdec) <= (u_plic_sw)
	.ds3_rvalid (plicsw_rvalid     ), // (u_axi_busdec) <= (u_plic_sw)
	.ds3_rready (plicsw_rready     ), // (u_axi_busdec) => (u_plic_sw)
`endif // ATCBUSDEC301_SLV3_SUPPORT
`ifdef ATCBUSDEC301_SLV4_SUPPORT
	.ds4_awvalid(dm_awvalid        ), // (u_axi_busdec) => (u_pldm)
	.ds4_awready(dm_awready        ), // (u_axi_busdec) <= (u_pldm)
	.ds4_wvalid (dm_wvalid         ), // (u_axi_busdec) => (u_pldm)
	.ds4_wready (dm_wready         ), // (u_axi_busdec) <= (u_pldm)
	.ds4_bresp  (dm_bresp          ), // (u_axi_busdec) <= (u_pldm)
	.ds4_bvalid (dm_bvalid         ), // (u_axi_busdec) <= (u_pldm)
	.ds4_bready (dm_bready         ), // (u_axi_busdec) => (u_pldm)
	.ds4_arvalid(dm_arvalid        ), // (u_axi_busdec) => (u_pldm)
	.ds4_arready(dm_arready        ), // (u_axi_busdec) <= (u_pldm)
	.ds4_rdata  (dm_rdata          ), // (u_axi_busdec) <= (u_pldm)
	.ds4_rresp  (dm_rresp          ), // (u_axi_busdec) <= (u_pldm)
	.ds4_rlast  (dm_rlast          ), // (u_axi_busdec) <= (u_pldm)
	.ds4_rvalid (dm_rvalid         ), // (u_axi_busdec) <= (u_pldm)
	.ds4_rready (dm_rready         ), // (u_axi_busdec) => (u_pldm)
`endif // ATCBUSDEC301_SLV4_SUPPORT
	.ds_awaddr  (busdec2nce_awaddr ), // (u_axi_busdec) => ()
	.ds_awlen   (busdec2nce_awlen  ), // (u_axi_busdec) => ()
	.ds_awsize  (busdec2nce_awsize ), // (u_axi_busdec) => ()
	.ds_awburst (busdec2nce_awburst), // (u_axi_busdec) => ()
	.ds_awlock  (busdec2nce_awlock ), // (u_axi_busdec) => ()
	.ds_awcache (busdec2nce_awcache), // (u_axi_busdec) => ()
	.ds_awprot  (busdec2nce_awprot ), // (u_axi_busdec) => ()
	.ds_wdata   (busdec2nce_wdata  ), // (u_axi_busdec) => ()
	.ds_wstrb   (busdec2nce_wstrb  ), // (u_axi_busdec) => ()
	.ds_wlast   (busdec2nce_wlast  ), // (u_axi_busdec) => ()
	.ds_araddr  (busdec2nce_araddr ), // (u_axi_busdec) => ()
	.ds_arlen   (busdec2nce_arlen  ), // (u_axi_busdec) => ()
	.ds_arsize  (busdec2nce_arsize ), // (u_axi_busdec) => ()
	.ds_arburst (busdec2nce_arburst), // (u_axi_busdec) => ()
	.ds_arlock  (busdec2nce_arlock ), // (u_axi_busdec) => ()
	.ds_arcache (busdec2nce_arcache), // (u_axi_busdec) => ()
	.ds_arprot  (busdec2nce_arprot ), // (u_axi_busdec) => ()
	.us_awid    (busdec_us_awid    ), // (u_axi_busdec) <= ()
	.us_awaddr  (busdec_us_awaddr  ), // (u_axi_busdec) <= ()
	.us_awlen   (busdec_us_awlen   ), // (u_axi_busdec) <= ()
	.us_awsize  (busdec_us_awsize  ), // (u_axi_busdec) <= ()
	.us_awburst (busdec_us_awburst ), // (u_axi_busdec) <= ()
	.us_awlock  (busdec_us_awlock  ), // (u_axi_busdec) <= ()
	.us_awcache (busdec_us_awcache ), // (u_axi_busdec) <= ()
	.us_awprot  (busdec_us_awprot  ), // (u_axi_busdec) <= ()
	.us_awvalid (busdec_us_awvalid ), // (u_axi_busdec) <= ()
	.us_awready (busdec_us_awready ), // (u_axi_busdec) => ()
	.us_wdata   (busdec_us_wdata   ), // (u_axi_busdec) <= ()
	.us_wstrb   (busdec_us_wstrb   ), // (u_axi_busdec) <= ()
	.us_wlast   (busdec_us_wlast   ), // (u_axi_busdec) <= ()
	.us_wvalid  (busdec_us_wvalid  ), // (u_axi_busdec) <= ()
	.us_wready  (busdec_us_wready  ), // (u_axi_busdec) => ()
	.us_bid     (busdec_us_bid     ), // (u_axi_busdec) => ()
	.us_bresp   (busdec_us_bresp   ), // (u_axi_busdec) => ()
	.us_bvalid  (busdec_us_bvalid  ), // (u_axi_busdec) => ()
	.us_bready  (busdec_us_bready  ), // (u_axi_busdec) <= ()
	.us_arid    (busdec_us_arid    ), // (u_axi_busdec) <= ()
	.us_araddr  (busdec_us_araddr  ), // (u_axi_busdec) <= ()
	.us_arlen   (busdec_us_arlen   ), // (u_axi_busdec) <= ()
	.us_arsize  (busdec_us_arsize  ), // (u_axi_busdec) <= ()
	.us_arburst (busdec_us_arburst ), // (u_axi_busdec) <= ()
	.us_arlock  (busdec_us_arlock  ), // (u_axi_busdec) <= ()
	.us_arcache (busdec_us_arcache ), // (u_axi_busdec) <= ()
	.us_arprot  (busdec_us_arprot  ), // (u_axi_busdec) <= ()
	.us_arvalid (busdec_us_arvalid ), // (u_axi_busdec) <= ()
	.us_arready (busdec_us_arready ), // (u_axi_busdec) => ()
	.us_rid     (busdec_us_rid     ), // (u_axi_busdec) => ()
	.us_rdata   (busdec_us_rdata   ), // (u_axi_busdec) => ()
	.us_rresp   (busdec_us_rresp   ), // (u_axi_busdec) => ()
	.us_rlast   (busdec_us_rlast   ), // (u_axi_busdec) => ()
	.us_rvalid  (busdec_us_rvalid  ), // (u_axi_busdec) => ()
	.us_rready  (busdec_us_rready  ), // (u_axi_busdec) <= ()
	.aclk       (aclk              ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.aresetn    (aresetn           )  // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
); // end of u_axi_busdec

`ifdef NDS_IO_SLAVEPORT_COMMON_X1
atcbusdec302 #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (SLVPORT_DATA_WIDTH),
	.ID_WIDTH        (BIU_ID_WIDTH+4  )
) u_slvp_busdec (
   `ifdef ATCBUSDEC302_SLV1_SUPPORT
	.ds1_awvalid(slvp_busdec_ds1_awvalid             ), // (u_slvp_busdec) => ()
	.ds1_awready(slvp_busdec_ds1_awready             ), // (u_slvp_busdec) <= ()
	.ds1_wvalid (slvp_busdec_ds1_wvalid              ), // (u_slvp_busdec) => ()
	.ds1_wready (slvp_busdec_ds1_wready              ), // (u_slvp_busdec) <= ()
	.ds1_bresp  (slvp_busdec_ds1_bresp               ), // (u_slvp_busdec) <= ()
	.ds1_bvalid (slvp_busdec_ds1_bvalid              ), // (u_slvp_busdec) <= ()
	.ds1_bready (slvp_busdec_ds1_bready              ), // (u_slvp_busdec) => ()
	.ds1_arvalid(slvp_busdec_ds1_arvalid             ), // (u_slvp_busdec) => ()
	.ds1_arready(slvp_busdec_ds1_arready             ), // (u_slvp_busdec) <= ()
	.ds1_rdata  (slvp_busdec_ds1_rdata               ), // (u_slvp_busdec) <= ()
	.ds1_rresp  (slvp_busdec_ds1_rresp               ), // (u_slvp_busdec) <= ()
	.ds1_rlast  (slvp_busdec_ds1_rlast               ), // (u_slvp_busdec) <= ()
	.ds1_rvalid (slvp_busdec_ds1_rvalid              ), // (u_slvp_busdec) <= ()
	.ds1_rready (slvp_busdec_ds1_rready              ), // (u_slvp_busdec) => ()
   `endif // ATCBUSDEC302_SLV1_SUPPORT
   `ifdef ATCBUSDEC302_SLV2_SUPPORT
	.ds2_awvalid(slvp_busdec_ds2_awvalid             ), // (u_slvp_busdec) => ()
	.ds2_awready(slvp_busdec_ds2_awready             ), // (u_slvp_busdec) <= ()
	.ds2_wvalid (slvp_busdec_ds2_wvalid              ), // (u_slvp_busdec) => ()
	.ds2_wready (slvp_busdec_ds2_wready              ), // (u_slvp_busdec) <= ()
	.ds2_bresp  (slvp_busdec_ds2_bresp               ), // (u_slvp_busdec) <= ()
	.ds2_bvalid (slvp_busdec_ds2_bvalid              ), // (u_slvp_busdec) <= ()
	.ds2_bready (slvp_busdec_ds2_bready              ), // (u_slvp_busdec) => ()
	.ds2_arvalid(slvp_busdec_ds2_arvalid             ), // (u_slvp_busdec) => ()
	.ds2_arready(slvp_busdec_ds2_arready             ), // (u_slvp_busdec) <= ()
	.ds2_rdata  (slvp_busdec_ds2_rdata               ), // (u_slvp_busdec) <= ()
	.ds2_rresp  (slvp_busdec_ds2_rresp               ), // (u_slvp_busdec) <= ()
	.ds2_rlast  (slvp_busdec_ds2_rlast               ), // (u_slvp_busdec) <= ()
	.ds2_rvalid (slvp_busdec_ds2_rvalid              ), // (u_slvp_busdec) <= ()
	.ds2_rready (slvp_busdec_ds2_rready              ), // (u_slvp_busdec) => ()
   `endif // ATCBUSDEC302_SLV2_SUPPORT
   `ifdef ATCBUSDEC302_SLV3_SUPPORT
	.ds3_awvalid(nds_unused_u_slvp_busdec_ds3_awvalid), // (u_slvp_busdec) => ()
	.ds3_awready(1'b0                                ), // (u_slvp_busdec) <= ()
	.ds3_wvalid (nds_unused_u_slvp_busdec_ds3_wvalid ), // (u_slvp_busdec) => ()
	.ds3_wready (1'b1                                ), // (u_slvp_busdec) <= ()
	.ds3_bresp  (2'b0                                ), // (u_slvp_busdec) <= ()
	.ds3_bvalid (1'b0                                ), // (u_slvp_busdec) <= ()
	.ds3_bready (nds_unused_u_slvp_busdec_ds3_bready ), // (u_slvp_busdec) => ()
	.ds3_arvalid(nds_unused_u_slvp_busdec_ds3_arvalid), // (u_slvp_busdec) => ()
	.ds3_arready(1'b0                                ), // (u_slvp_busdec) <= ()
	.ds3_rdata  ({SLVPORT_DATA_WIDTH{1'b0}}          ), // () <= ()
	.ds3_rresp  (2'b0                                ), // (u_slvp_busdec) <= ()
	.ds3_rlast  (1'b0                                ), // (u_slvp_busdec) <= ()
	.ds3_rvalid (1'b0                                ), // (u_slvp_busdec) <= ()
	.ds3_rready (nds_unused_u_slvp_busdec_ds3_rready ), // (u_slvp_busdec) => ()
   `endif // ATCBUSDEC302_SLV3_SUPPORT
   `ifdef ATCBUSDEC302_SLV4_SUPPORT
	.ds4_awvalid(nds_unused_u_slvp_busdec_ds4_awvalid), // (u_slvp_busdec) => ()
	.ds4_awready(1'b0                                ), // (u_slvp_busdec) <= ()
	.ds4_wvalid (nds_unused_u_slvp_busdec_ds4_wvalid ), // (u_slvp_busdec) => ()
	.ds4_wready (1'b1                                ), // (u_slvp_busdec) <= ()
	.ds4_bresp  (2'b0                                ), // (u_slvp_busdec) <= ()
	.ds4_bvalid (1'b0                                ), // (u_slvp_busdec) <= ()
	.ds4_bready (nds_unused_u_slvp_busdec_ds4_bready ), // (u_slvp_busdec) => ()
	.ds4_arvalid(nds_unused_u_slvp_busdec_ds4_arvalid), // (u_slvp_busdec) => ()
	.ds4_arready(1'b0                                ), // (u_slvp_busdec) <= ()
	.ds4_rdata  ({SLVPORT_DATA_WIDTH{1'b0}}          ), // () <= ()
	.ds4_rresp  (2'b0                                ), // (u_slvp_busdec) <= ()
	.ds4_rlast  (1'b0                                ), // (u_slvp_busdec) <= ()
	.ds4_rvalid (1'b0                                ), // (u_slvp_busdec) <= ()
	.ds4_rready (nds_unused_u_slvp_busdec_ds4_rready ), // (u_slvp_busdec) => ()
   `endif // ATCBUSDEC302_SLV4_SUPPORT
	.ds_awaddr  (busdec2slv_awaddr                   ), // (u_slvp_busdec) => ()
	.ds_awlen   (busdec2slv_awlen                    ), // (u_slvp_busdec) => ()
	.ds_awsize  (busdec2slv_awsize                   ), // (u_slvp_busdec) => ()
	.ds_awburst (busdec2slv_awburst                  ), // (u_slvp_busdec) => ()
	.ds_awlock  (busdec2slv_awlock                   ), // (u_slvp_busdec) => ()
	.ds_awcache (busdec2slv_awcache                  ), // (u_slvp_busdec) => ()
	.ds_awprot  (busdec2slv_awprot                   ), // (u_slvp_busdec) => ()
	.ds_wdata   (busdec2slv_wdata                    ), // (u_slvp_busdec) => ()
	.ds_wstrb   (busdec2slv_wstrb                    ), // (u_slvp_busdec) => ()
	.ds_wlast   (busdec2slv_wlast                    ), // (u_slvp_busdec) => ()
	.ds_araddr  (busdec2slv_araddr                   ), // (u_slvp_busdec) => ()
	.ds_arlen   (busdec2slv_arlen                    ), // (u_slvp_busdec) => ()
	.ds_arsize  (busdec2slv_arsize                   ), // (u_slvp_busdec) => ()
	.ds_arburst (busdec2slv_arburst                  ), // (u_slvp_busdec) => ()
	.ds_arlock  (busdec2slv_arlock                   ), // (u_slvp_busdec) => ()
	.ds_arcache (busdec2slv_arcache                  ), // (u_slvp_busdec) => ()
	.ds_arprot  (busdec2slv_arprot                   ), // (u_slvp_busdec) => ()
	.us_awid    (slv_awid                            ), // (u_slvp_busdec) <= ()
	.us_awaddr  (slv_awaddr                          ), // (u_slvp_busdec) <= ()
	.us_awlen   (slv_awlen                           ), // (u_slvp_busdec) <= ()
	.us_awsize  (slv_awsize                          ), // (u_slvp_busdec) <= ()
	.us_awburst (slv_awburst                         ), // (u_slvp_busdec) <= ()
	.us_awlock  (slv_awlock                          ), // (u_slvp_busdec) <= ()
	.us_awcache (slv_awcache                         ), // (u_slvp_busdec) <= ()
	.us_awprot  (slv_awprot                          ), // (u_slvp_busdec) <= ()
	.us_awvalid (slv_awvalid                         ), // (u_slvp_busdec) <= ()
	.us_awready (slv_awready                         ), // (u_slvp_busdec) => ()
	.us_wdata   (slv_wdata                           ), // (u_slvp_busdec) <= ()
	.us_wstrb   (slv_wstrb                           ), // (u_slvp_busdec) <= ()
	.us_wlast   (slv_wlast                           ), // (u_slvp_busdec) <= ()
	.us_wvalid  (slv_wvalid                          ), // (u_slvp_busdec) <= ()
	.us_wready  (slv_wready                          ), // (u_slvp_busdec) => ()
	.us_bid     (slv_bid                             ), // (u_slvp_busdec) => ()
	.us_bresp   (slv_bresp                           ), // (u_slvp_busdec) => ()
	.us_bvalid  (slv_bvalid                          ), // (u_slvp_busdec) => ()
	.us_bready  (slv_bready                          ), // (u_slvp_busdec) <= ()
	.us_arid    (slv_arid                            ), // (u_slvp_busdec) <= ()
	.us_araddr  (slv_araddr                          ), // (u_slvp_busdec) <= ()
	.us_arlen   (slv_arlen                           ), // (u_slvp_busdec) <= ()
	.us_arsize  (slv_arsize                          ), // (u_slvp_busdec) <= ()
	.us_arburst (slv_arburst                         ), // (u_slvp_busdec) <= ()
	.us_arlock  (slv_arlock                          ), // (u_slvp_busdec) <= ()
	.us_arcache (slv_arcache                         ), // (u_slvp_busdec) <= ()
	.us_arprot  (slv_arprot                          ), // (u_slvp_busdec) <= ()
	.us_arvalid (slv_arvalid                         ), // (u_slvp_busdec) <= ()
	.us_arready (slv_arready                         ), // (u_slvp_busdec) => ()
	.us_rid     (slv_rid                             ), // (u_slvp_busdec) => ()
	.us_rdata   (slv_rdata                           ), // (u_slvp_busdec) => ()
	.us_rresp   (slv_rresp                           ), // (u_slvp_busdec) => ()
	.us_rlast   (slv_rlast                           ), // (u_slvp_busdec) => ()
	.us_rvalid  (slv_rvalid                          ), // (u_slvp_busdec) => ()
	.us_rready  (slv_rready                          ), // (u_slvp_busdec) <= ()
	.aclk       (aclk                                ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.aresetn    (aresetn                             )  // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
); // end of u_slvp_busdec

`endif // NDS_IO_SLAVEPORT_COMMON_X1
`ifdef NDS_IO_BUS_PROTECTION
   `ifdef NDS_IO_FLASHIF0
      `ifdef ATCBMC301_MST1_SUPPORT
nds_scpu_bus_ingress #(
	.ADDR_CODE_WIDTH (BIU_ADDR_CODE_WIDTH),
	.BIU_CTRL_CODE_WIDTH(BIU_CTRL_CODE_WIDTH),
	.DATA_CODE_WIDTH (BIU_DATA_CODE_WIDTH),
	.DATA_WIDTH      (BIU_DATA_WIDTH  ),
	.DS_ADDR_WIDTH   (ADDR_WIDTH      ),
	.ID_WIDTH        (FLASHIF0_ID_WIDTH),
	.US_ADDR_WIDTH   (BIU_ADDR_WIDTH  ),
	.UTID_WIDTH      (BIU_UTID_WIDTH  ),
	.WCTRL_CODE_WIDTH(WCTRL_CODE_WIDTH)
) u_flash0_ingress (
	.aclk               (aclk                                 ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.aresetn            (aresetn                              ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.us_araddr          (cluster_flash0_araddr                ), // (u_flash0_ingress) <= (u_cluster)
	.us_araddrcode      (cluster_flash0_araddrcode            ), // (u_flash0_ingress) <= (u_cluster)
	.us_arburst         (cluster_flash0_arburst               ), // (u_flash0_ingress) <= (u_cluster)
	.us_arcache         (cluster_flash0_arcache               ), // (u_flash0_ingress) <= (u_cluster)
	.us_arctl0code      (cluster_flash0_arctl0code            ), // (u_flash0_ingress) <= (u_cluster)
	.us_arctl1code      (cluster_flash0_arctl1code            ), // (u_flash0_ingress) <= (u_cluster)
	.us_arid            (cluster_flash0_arid                  ), // (u_flash0_ingress) <= (u_cluster)
	.us_aridcode        (cluster_flash0_aridcode              ), // (u_flash0_ingress) <= (u_cluster)
	.us_arlen           (cluster_flash0_arlen                 ), // (u_flash0_ingress) <= (u_cluster)
	.us_arlock          (cluster_flash0_arlock                ), // (u_flash0_ingress) <= (u_cluster)
	.us_arprot          (cluster_flash0_arprot                ), // (u_flash0_ingress) <= (u_cluster)
	.us_arready         (cluster_flash0_arready               ), // (u_flash0_ingress) => (u_cluster)
	.us_arreadycode     (cluster_flash0_arreadycode           ), // (u_flash0_ingress) => (u_cluster)
	.us_arsize          (cluster_flash0_arsize                ), // (u_flash0_ingress) <= (u_cluster)
	.us_arutid          (cluster_flash0_arutid                ), // (u_flash0_ingress) <= (u_cluster)
	.us_arvalid         (cluster_flash0_arvalid               ), // (u_flash0_ingress) <= (u_cluster)
	.us_arvalidcode     (cluster_flash0_arvalidcode           ), // (u_flash0_ingress) <= (u_cluster)
	.us_awaddr          (cluster_flash0_awaddr                ), // (u_flash0_ingress) <= (u_cluster)
	.us_awaddrcode      (cluster_flash0_awaddrcode            ), // (u_flash0_ingress) <= (u_cluster)
	.us_awburst         (cluster_flash0_awburst               ), // (u_flash0_ingress) <= (u_cluster)
	.us_awcache         (cluster_flash0_awcache               ), // (u_flash0_ingress) <= (u_cluster)
	.us_awctl0code      (cluster_flash0_awctl0code            ), // (u_flash0_ingress) <= (u_cluster)
	.us_awctl1code      (cluster_flash0_awctl1code            ), // (u_flash0_ingress) <= (u_cluster)
	.us_awid            (cluster_flash0_awid                  ), // (u_flash0_ingress) <= (u_cluster)
	.us_awidcode        (cluster_flash0_awidcode              ), // (u_flash0_ingress) <= (u_cluster)
	.us_awlen           (cluster_flash0_awlen                 ), // (u_flash0_ingress) <= (u_cluster)
	.us_awlock          (cluster_flash0_awlock                ), // (u_flash0_ingress) <= (u_cluster)
	.us_awprot          (cluster_flash0_awprot                ), // (u_flash0_ingress) <= (u_cluster)
	.us_awready         (cluster_flash0_awready               ), // (u_flash0_ingress) => (u_cluster)
	.us_awreadycode     (cluster_flash0_awreadycode           ), // (u_flash0_ingress) => (u_cluster)
	.us_awsize          (cluster_flash0_awsize                ), // (u_flash0_ingress) <= (u_cluster)
	.us_awutid          (cluster_flash0_awutid                ), // (u_flash0_ingress) <= (u_cluster)
	.us_awvalid         (cluster_flash0_awvalid               ), // (u_flash0_ingress) <= (u_cluster)
	.us_awvalidcode     (cluster_flash0_awvalidcode           ), // (u_flash0_ingress) <= (u_cluster)
	.us_bctlcode        (cluster_flash0_bctlcode              ), // (u_flash0_ingress) => (u_cluster)
	.us_bid             (cluster_flash0_bid                   ), // (u_flash0_ingress) => (u_cluster)
	.us_bidcode         (cluster_flash0_bidcode               ), // (u_flash0_ingress) => (u_cluster)
	.us_bready          (cluster_flash0_bready                ), // (u_flash0_ingress) <= (u_cluster)
	.us_breadycode      (cluster_flash0_breadycode            ), // (u_flash0_ingress) <= (u_cluster)
	.us_bresp           (cluster_flash0_bresp                 ), // (u_flash0_ingress) => (u_cluster)
	.us_butid           (cluster_flash0_butid                 ), // (u_flash0_ingress) => (u_cluster)
	.us_bvalid          (cluster_flash0_bvalid                ), // (u_flash0_ingress) => (u_cluster)
	.us_bvalidcode      (cluster_flash0_bvalidcode            ), // (u_flash0_ingress) => (u_cluster)
	.us_rctlcode        (cluster_flash0_rctlcode              ), // (u_flash0_ingress) => (u_cluster)
	.us_rdata           (cluster_flash0_rdata                 ), // (u_flash0_ingress) => (u_cluster)
	.us_rdatacode       (cluster_flash0_rdatacode             ), // (u_flash0_ingress) => (u_cluster)
	.us_reobi           (cluster_flash0_reobi                 ), // (u_flash0_ingress) => (u_cluster)
	.us_rid             (cluster_flash0_rid                   ), // (u_flash0_ingress) => (u_cluster)
	.us_ridcode         (cluster_flash0_ridcode               ), // (u_flash0_ingress) => (u_cluster)
	.us_rlast           (cluster_flash0_rlast                 ), // (u_flash0_ingress) => (u_cluster)
	.us_rresp           (cluster_flash0_rresp                 ), // (u_flash0_ingress) => (u_cluster)
	.us_rutid           (cluster_flash0_rutid                 ), // (u_flash0_ingress) => (u_cluster)
	.us_rvalid          (cluster_flash0_rvalid                ), // (u_flash0_ingress) => (u_cluster)
	.us_rvalidcode      (cluster_flash0_rvalidcode            ), // (u_flash0_ingress) => (u_cluster)
	.us_rready          (cluster_flash0_rready                ), // (u_flash0_ingress) <= (u_cluster)
	.us_rreadycode      (cluster_flash0_rreadycode            ), // (u_flash0_ingress) <= (u_cluster)
	.us_wctlcode        (cluster_flash0_wctlcode              ), // (u_flash0_ingress) <= (u_cluster)
	.us_wdata           (cluster_flash0_wdata                 ), // (u_flash0_ingress) <= (u_cluster)
	.us_wdatacode       (cluster_flash0_wdatacode             ), // (u_flash0_ingress) <= (u_cluster)
	.us_weobi           (cluster_flash0_weobi                 ), // (u_flash0_ingress) <= (u_cluster)
	.us_wlast           (cluster_flash0_wlast                 ), // (u_flash0_ingress) <= (u_cluster)
	.us_wstrb           (cluster_flash0_wstrb                 ), // (u_flash0_ingress) <= (u_cluster)
	.us_wutid           (cluster_flash0_wutid                 ), // (u_flash0_ingress) <= (u_cluster)
	.us_wvalid          (cluster_flash0_wvalid                ), // (u_flash0_ingress) <= (u_cluster)
	.us_wvalidcode      (cluster_flash0_wvalidcode            ), // (u_flash0_ingress) <= (u_cluster)
	.us_wready          (cluster_flash0_wready                ), // (u_flash0_ingress) => (u_cluster)
	.us_wreadycode      (cluster_flash0_wreadycode            ), // (u_flash0_ingress) => (u_cluster)
	.ds_araddr          (axi_flash0_araddr                    ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_arburst         (axi_flash0_arburst                   ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_arcache         (axi_flash0_arcache                   ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_arid            (axi_flash0_arid_out                  ), // (u_flash0_ingress) => ()
	.ds_arlen           (axi_flash0_arlen                     ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_arlock          (axi_flash0_arlock                    ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_arprot          (axi_flash0_arprot                    ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_arsize          (axi_flash0_arsize                    ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_arvalid         (axi_flash0_arvalid                   ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_arready         (axi_flash0_arready                   ), // (u_flash0_ingress) <= (u_axi_bmc)
	.ds_awaddr          (axi_flash0_awaddr                    ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_awburst         (axi_flash0_awburst                   ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_awcache         (axi_flash0_awcache                   ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_awid            (axi_flash0_awid_out                  ), // (u_flash0_ingress) => ()
	.ds_awlen           (axi_flash0_awlen                     ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_awlock          (axi_flash0_awlock                    ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_awprot          (axi_flash0_awprot                    ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_awready         (axi_flash0_awready                   ), // (u_flash0_ingress) <= (u_axi_bmc)
	.ds_awsize          (axi_flash0_awsize                    ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_awvalid         (axi_flash0_awvalid                   ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_bid             (axi_flash0_bid_in                    ), // (u_flash0_ingress) <= ()
	.ds_bready          (axi_flash0_bready                    ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_bresp           (axi_flash0_bresp                     ), // (u_flash0_ingress) <= (u_axi_bmc)
	.ds_bvalid          (axi_flash0_bvalid                    ), // (u_flash0_ingress) <= (u_axi_bmc)
	.ds_rdata           (axi_flash0_rdata                     ), // (u_flash0_ingress) <= (u_axi_bmc)
	.ds_rid             (axi_flash0_rid_in                    ), // (u_flash0_ingress) <= ()
	.ds_rlast           (axi_flash0_rlast                     ), // (u_flash0_ingress) <= (u_axi_bmc)
	.ds_rready          (axi_flash0_rready                    ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_rresp           (axi_flash0_rresp                     ), // (u_flash0_ingress) <= (u_axi_bmc)
	.ds_rvalid          (axi_flash0_rvalid                    ), // (u_flash0_ingress) <= (u_axi_bmc)
	.ds_wdata           (axi_flash0_wdata                     ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_wlast           (axi_flash0_wlast                     ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_wready          (axi_flash0_wready                    ), // (u_flash0_ingress) <= (u_axi_bmc)
	.ds_wstrb           (axi_flash0_wstrb                     ), // (u_flash0_ingress) => (u_axi_bmc)
	.ds_wvalid          (axi_flash0_wvalid                    ), // (u_flash0_ingress) => (u_axi_bmc)
	.event_handshake_err(nds_unused_flash0_event_handshake_err), // (u_flash0_ingress) => ()
	.event_eobi_err     (nds_unused_flash0_event_eobi_err     ), // (u_flash0_ingress) => ()
	.event_data_err     (nds_unused_flash0_event_data_err     ), // (u_flash0_ingress) => ()
	.event_ctl_err      (nds_unused_flash0_event_ctl_err      )  // (u_flash0_ingress) => ()
); // end of u_flash0_ingress

      `endif // ATCBMC301_MST1_SUPPORT
   `endif // NDS_IO_FLASHIF0
nds_scpu_bus_ingress #(
	.ADDR_CODE_WIDTH (BIU_ADDR_CODE_WIDTH),
	.BIU_CTRL_CODE_WIDTH(BIU_CTRL_CODE_WIDTH),
	.DATA_CODE_WIDTH (BIU_DATA_CODE_WIDTH),
	.DATA_WIDTH      (BIU_DATA_WIDTH  ),
	.DS_ADDR_WIDTH   (ADDR_WIDTH      ),
	.ID_WIDTH        (BIU_ID_WIDTH    ),
	.US_ADDR_WIDTH   (BIU_ADDR_WIDTH  ),
	.UTID_WIDTH      (BIU_UTID_WIDTH  ),
	.WCTRL_CODE_WIDTH(WCTRL_CODE_WIDTH)
) u_sys0_ingress (
	.aclk               (aclk                               ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.aresetn            (aresetn                            ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.us_araddr          (cluster_sys0_araddr                ), // (u_sys0_ingress) <= (u_cluster)
	.us_araddrcode      (cluster_sys0_araddrcode            ), // (u_sys0_ingress) <= (u_cluster)
	.us_arburst         (cluster_sys0_arburst               ), // (u_sys0_ingress) <= (u_cluster)
	.us_arcache         (cluster_sys0_arcache               ), // (u_sys0_ingress) <= (u_cluster)
	.us_arctl0code      (cluster_sys0_arctl0code            ), // (u_sys0_ingress) <= (u_cluster)
	.us_arctl1code      (cluster_sys0_arctl1code            ), // (u_sys0_ingress) <= (u_cluster)
	.us_arid            (cluster_sys0_arid                  ), // (u_sys0_ingress) <= (u_cluster)
	.us_aridcode        (cluster_sys0_aridcode              ), // (u_sys0_ingress) <= (u_cluster)
	.us_arlen           (cluster_sys0_arlen                 ), // (u_sys0_ingress) <= (u_cluster)
	.us_arlock          (cluster_sys0_arlock                ), // (u_sys0_ingress) <= (u_cluster)
	.us_arprot          (cluster_sys0_arprot                ), // (u_sys0_ingress) <= (u_cluster)
	.us_arready         (cluster_sys0_arready               ), // (u_sys0_ingress) => (u_cluster)
	.us_arreadycode     (cluster_sys0_arreadycode           ), // (u_sys0_ingress) => (u_cluster)
	.us_arsize          (cluster_sys0_arsize                ), // (u_sys0_ingress) <= (u_cluster)
	.us_arutid          (cluster_sys0_arutid                ), // (u_sys0_ingress) <= (u_cluster)
	.us_arvalid         (cluster_sys0_arvalid               ), // (u_sys0_ingress) <= (u_cluster)
	.us_arvalidcode     (cluster_sys0_arvalidcode           ), // (u_sys0_ingress) <= (u_cluster)
	.us_awaddr          (cluster_sys0_awaddr                ), // (u_sys0_ingress) <= (u_cluster)
	.us_awaddrcode      (cluster_sys0_awaddrcode            ), // (u_sys0_ingress) <= (u_cluster)
	.us_awburst         (cluster_sys0_awburst               ), // (u_sys0_ingress) <= (u_cluster)
	.us_awcache         (cluster_sys0_awcache               ), // (u_sys0_ingress) <= (u_cluster)
	.us_awctl0code      (cluster_sys0_awctl0code            ), // (u_sys0_ingress) <= (u_cluster)
	.us_awctl1code      (cluster_sys0_awctl1code            ), // (u_sys0_ingress) <= (u_cluster)
	.us_awid            (cluster_sys0_awid                  ), // (u_sys0_ingress) <= (u_cluster)
	.us_awidcode        (cluster_sys0_awidcode              ), // (u_sys0_ingress) <= (u_cluster)
	.us_awlen           (cluster_sys0_awlen                 ), // (u_sys0_ingress) <= (u_cluster)
	.us_awlock          (cluster_sys0_awlock                ), // (u_sys0_ingress) <= (u_cluster)
	.us_awprot          (cluster_sys0_awprot                ), // (u_sys0_ingress) <= (u_cluster)
	.us_awready         (cluster_sys0_awready               ), // (u_sys0_ingress) => (u_cluster)
	.us_awreadycode     (cluster_sys0_awreadycode           ), // (u_sys0_ingress) => (u_cluster)
	.us_awsize          (cluster_sys0_awsize                ), // (u_sys0_ingress) <= (u_cluster)
	.us_awutid          (cluster_sys0_awutid                ), // (u_sys0_ingress) <= (u_cluster)
	.us_awvalid         (cluster_sys0_awvalid               ), // (u_sys0_ingress) <= (u_cluster)
	.us_awvalidcode     (cluster_sys0_awvalidcode           ), // (u_sys0_ingress) <= (u_cluster)
	.us_bctlcode        (cluster_sys0_bctlcode              ), // (u_sys0_ingress) => (u_cluster)
	.us_bid             (cluster_sys0_bid                   ), // (u_sys0_ingress) => (u_cluster)
	.us_bidcode         (cluster_sys0_bidcode               ), // (u_sys0_ingress) => (u_cluster)
	.us_bready          (cluster_sys0_bready                ), // (u_sys0_ingress) <= (u_cluster)
	.us_breadycode      (cluster_sys0_breadycode            ), // (u_sys0_ingress) <= (u_cluster)
	.us_bresp           (cluster_sys0_bresp                 ), // (u_sys0_ingress) => (u_cluster)
	.us_butid           (cluster_sys0_butid                 ), // (u_sys0_ingress) => (u_cluster)
	.us_bvalid          (cluster_sys0_bvalid                ), // (u_sys0_ingress) => (u_cluster)
	.us_bvalidcode      (cluster_sys0_bvalidcode            ), // (u_sys0_ingress) => (u_cluster)
	.us_rctlcode        (cluster_sys0_rctlcode              ), // (u_sys0_ingress) => (u_cluster)
	.us_rdata           (cluster_sys0_rdata                 ), // (u_sys0_ingress) => (u_cluster)
	.us_rdatacode       (cluster_sys0_rdatacode             ), // (u_sys0_ingress) => (u_cluster)
	.us_reobi           (cluster_sys0_reobi                 ), // (u_sys0_ingress) => (u_cluster)
	.us_rid             (cluster_sys0_rid                   ), // (u_sys0_ingress) => (u_cluster)
	.us_ridcode         (cluster_sys0_ridcode               ), // (u_sys0_ingress) => (u_cluster)
	.us_rlast           (cluster_sys0_rlast                 ), // (u_sys0_ingress) => (u_cluster)
	.us_rresp           (cluster_sys0_rresp                 ), // (u_sys0_ingress) => (u_cluster)
	.us_rutid           (cluster_sys0_rutid                 ), // (u_sys0_ingress) => (u_cluster)
	.us_rvalid          (cluster_sys0_rvalid                ), // (u_sys0_ingress) => (u_cluster)
	.us_rvalidcode      (cluster_sys0_rvalidcode            ), // (u_sys0_ingress) => (u_cluster)
	.us_rready          (cluster_sys0_rready                ), // (u_sys0_ingress) <= (u_cluster)
	.us_rreadycode      (cluster_sys0_rreadycode            ), // (u_sys0_ingress) <= (u_cluster)
	.us_wctlcode        (cluster_sys0_wctlcode              ), // (u_sys0_ingress) <= (u_cluster)
	.us_wdata           (cluster_sys0_wdata                 ), // (u_sys0_ingress) <= (u_cluster)
	.us_wdatacode       (cluster_sys0_wdatacode             ), // (u_sys0_ingress) <= (u_cluster)
	.us_weobi           (cluster_sys0_weobi                 ), // (u_sys0_ingress) <= (u_cluster)
	.us_wlast           (cluster_sys0_wlast                 ), // (u_sys0_ingress) <= (u_cluster)
	.us_wstrb           (cluster_sys0_wstrb                 ), // (u_sys0_ingress) <= (u_cluster)
	.us_wutid           (cluster_sys0_wutid                 ), // (u_sys0_ingress) <= (u_cluster)
	.us_wvalid          (cluster_sys0_wvalid                ), // (u_sys0_ingress) <= (u_cluster)
	.us_wvalidcode      (cluster_sys0_wvalidcode            ), // (u_sys0_ingress) <= (u_cluster)
	.us_wready          (cluster_sys0_wready                ), // (u_sys0_ingress) => (u_cluster)
	.us_wreadycode      (cluster_sys0_wreadycode            ), // (u_sys0_ingress) => (u_cluster)
	.ds_araddr          (axi_sys0_araddr                    ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_arburst         (axi_sys0_arburst                   ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_arcache         (axi_sys0_arcache                   ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_arid            (axi_sys0_arid                      ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_arlen           (axi_sys0_arlen                     ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_arlock          (axi_sys0_arlock                    ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_arprot          (axi_sys0_arprot                    ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_arsize          (axi_sys0_arsize                    ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_arvalid         (axi_sys0_arvalid                   ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_arready         (axi_sys0_arready                   ), // (u_sys0_ingress) <= (u_axi_bmc)
	.ds_awaddr          (axi_sys0_awaddr                    ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_awburst         (axi_sys0_awburst                   ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_awcache         (axi_sys0_awcache                   ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_awid            (axi_sys0_awid                      ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_awlen           (axi_sys0_awlen                     ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_awlock          (axi_sys0_awlock                    ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_awprot          (axi_sys0_awprot                    ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_awready         (axi_sys0_awready                   ), // (u_sys0_ingress) <= (u_axi_bmc)
	.ds_awsize          (axi_sys0_awsize                    ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_awvalid         (axi_sys0_awvalid                   ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_bid             (axi_sys0_bid                       ), // (u_sys0_ingress) <= (u_axi_bmc)
	.ds_bready          (axi_sys0_bready                    ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_bresp           (axi_sys0_bresp                     ), // (u_sys0_ingress) <= (u_axi_bmc)
	.ds_bvalid          (axi_sys0_bvalid                    ), // (u_sys0_ingress) <= (u_axi_bmc)
	.ds_rdata           (axi_sys0_rdata                     ), // (u_sys0_ingress) <= (u_axi_bmc)
	.ds_rid             (axi_sys0_rid                       ), // (u_sys0_ingress) <= (u_axi_bmc)
	.ds_rlast           (axi_sys0_rlast                     ), // (u_sys0_ingress) <= (u_axi_bmc)
	.ds_rready          (axi_sys0_rready                    ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_rresp           (axi_sys0_rresp                     ), // (u_sys0_ingress) <= (u_axi_bmc)
	.ds_rvalid          (axi_sys0_rvalid                    ), // (u_sys0_ingress) <= (u_axi_bmc)
	.ds_wdata           (axi_sys0_wdata                     ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_wlast           (axi_sys0_wlast                     ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_wready          (axi_sys0_wready                    ), // (u_sys0_ingress) <= (u_axi_bmc)
	.ds_wstrb           (axi_sys0_wstrb                     ), // (u_sys0_ingress) => (u_axi_bmc)
	.ds_wvalid          (axi_sys0_wvalid                    ), // (u_sys0_ingress) => (u_axi_bmc)
	.event_handshake_err(nds_unused_sys0_event_handshake_err), // (u_sys0_ingress) => ()
	.event_eobi_err     (nds_unused_sys0_event_eobi_err     ), // (u_sys0_ingress) => ()
	.event_data_err     (nds_unused_sys0_event_data_err     ), // (u_sys0_ingress) => ()
	.event_ctl_err      (nds_unused_sys0_event_ctl_err      )  // (u_sys0_ingress) => ()
); // end of u_sys0_ingress

   `ifdef NDS_IO_SPP
nds_scpu_bus_ingress #(
	.ADDR_CODE_WIDTH (BIU_ADDR_CODE_WIDTH),
	.BIU_CTRL_CODE_WIDTH(BIU_CTRL_CODE_WIDTH),
	.DATA_CODE_WIDTH (`NDS_SPP_DATA_CODE_WIDTH),
	.DATA_WIDTH      (`NDS_SPP_DATA_WIDTH),
	.DS_ADDR_WIDTH   (ADDR_WIDTH      ),
	.ID_WIDTH        (`NDS_SPP_ID_WIDTH),
	.US_ADDR_WIDTH   (BIU_ADDR_WIDTH  ),
	.UTID_WIDTH      (BIU_UTID_WIDTH  ),
	.WCTRL_CODE_WIDTH(WCTRL_CODE_WIDTH)
) u_spp_ingress (
	.aclk               (aclk                              ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.aresetn            (aresetn                           ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.us_araddr          (spp_araddr                        ), // (u_spp_ingress) <= (u_cluster)
	.us_araddrcode      (spp_araddrcode                    ), // (u_spp_ingress) <= (u_cluster)
	.us_arburst         (spp_arburst                       ), // (u_spp_ingress) <= (u_cluster)
	.us_arcache         (spp_arcache                       ), // (u_spp_ingress) <= (u_cluster)
	.us_arctl0code      (spp_arctl0code                    ), // (u_spp_ingress) <= (u_cluster)
	.us_arctl1code      (spp_arctl1code                    ), // (u_spp_ingress) <= (u_cluster)
	.us_arid            (spp_arid                          ), // (u_spp_ingress) <= (u_cluster)
	.us_aridcode        (spp_aridcode                      ), // (u_spp_ingress) <= (u_cluster)
	.us_arlen           (spp_arlen                         ), // (u_spp_ingress) <= (u_cluster)
	.us_arlock          (spp_arlock                        ), // (u_spp_ingress) <= (u_cluster)
	.us_arprot          (spp_arprot                        ), // (u_spp_ingress) <= (u_cluster)
	.us_arready         (spp_arready                       ), // (u_spp_ingress) => (u_cluster)
	.us_arreadycode     (spp_arreadycode                   ), // (u_spp_ingress) => (u_cluster)
	.us_arsize          (spp_arsize                        ), // (u_spp_ingress) <= (u_cluster)
	.us_arutid          (spp_arutid                        ), // (u_spp_ingress) <= (u_cluster)
	.us_arvalid         (spp_arvalid                       ), // (u_spp_ingress) <= (u_cluster)
	.us_arvalidcode     (spp_arvalidcode                   ), // (u_spp_ingress) <= (u_cluster)
	.us_awaddr          (spp_awaddr                        ), // (u_spp_ingress) <= (u_cluster)
	.us_awaddrcode      (spp_awaddrcode                    ), // (u_spp_ingress) <= (u_cluster)
	.us_awburst         (spp_awburst                       ), // (u_spp_ingress) <= (u_cluster)
	.us_awcache         (spp_awcache                       ), // (u_spp_ingress) <= (u_cluster)
	.us_awctl0code      (spp_awctl0code                    ), // (u_spp_ingress) <= (u_cluster)
	.us_awctl1code      (spp_awctl1code                    ), // (u_spp_ingress) <= (u_cluster)
	.us_awid            (spp_awid                          ), // (u_spp_ingress) <= (u_cluster)
	.us_awidcode        (spp_awidcode                      ), // (u_spp_ingress) <= (u_cluster)
	.us_awlen           (spp_awlen                         ), // (u_spp_ingress) <= (u_cluster)
	.us_awlock          (spp_awlock                        ), // (u_spp_ingress) <= (u_cluster)
	.us_awprot          (spp_awprot                        ), // (u_spp_ingress) <= (u_cluster)
	.us_awready         (spp_awready                       ), // (u_spp_ingress) => (u_cluster)
	.us_awreadycode     (spp_awreadycode                   ), // (u_spp_ingress) => (u_cluster)
	.us_awsize          (spp_awsize                        ), // (u_spp_ingress) <= (u_cluster)
	.us_awutid          (spp_awutid                        ), // (u_spp_ingress) <= (u_cluster)
	.us_awvalid         (spp_awvalid                       ), // (u_spp_ingress) <= (u_cluster)
	.us_awvalidcode     (spp_awvalidcode                   ), // (u_spp_ingress) <= (u_cluster)
	.us_bctlcode        (spp_bctlcode                      ), // (u_spp_ingress) => (u_cluster)
	.us_bid             (spp_bid                           ), // (u_spp_ingress) => (u_cluster)
	.us_bidcode         (spp_bidcode                       ), // (u_spp_ingress) => (u_cluster)
	.us_bready          (spp_bready                        ), // (u_spp_ingress) <= (u_cluster)
	.us_breadycode      (spp_breadycode                    ), // (u_spp_ingress) <= (u_cluster)
	.us_bresp           (spp_bresp                         ), // (u_spp_ingress) => (u_cluster)
	.us_butid           (spp_butid                         ), // (u_spp_ingress) => (u_cluster)
	.us_bvalid          (spp_bvalid                        ), // (u_spp_ingress) => (u_cluster)
	.us_bvalidcode      (spp_bvalidcode                    ), // (u_spp_ingress) => (u_cluster)
	.us_rctlcode        (spp_rctlcode                      ), // (u_spp_ingress) => (u_cluster)
	.us_rdata           (spp_rdata                         ), // (u_spp_ingress) => (u_cluster)
	.us_rdatacode       (spp_rdatacode                     ), // (u_spp_ingress) => (u_cluster)
	.us_reobi           (spp_reobi                         ), // (u_spp_ingress) => (u_cluster)
	.us_rid             (spp_rid                           ), // (u_spp_ingress) => (u_cluster)
	.us_ridcode         (spp_ridcode                       ), // (u_spp_ingress) => (u_cluster)
	.us_rlast           (spp_rlast                         ), // (u_spp_ingress) => (u_cluster)
	.us_rresp           (spp_rresp                         ), // (u_spp_ingress) => (u_cluster)
	.us_rutid           (spp_rutid                         ), // (u_spp_ingress) => (u_cluster)
	.us_rvalid          (spp_rvalid                        ), // (u_spp_ingress) => (u_cluster)
	.us_rvalidcode      (spp_rvalidcode                    ), // (u_spp_ingress) => (u_cluster)
	.us_rready          (spp_rready                        ), // (u_spp_ingress) <= (u_cluster)
	.us_rreadycode      (spp_rreadycode                    ), // (u_spp_ingress) <= (u_cluster)
	.us_wctlcode        (spp_wctlcode                      ), // (u_spp_ingress) <= (u_cluster)
	.us_wdata           (spp_wdata                         ), // (u_spp_ingress) <= (u_cluster)
	.us_wdatacode       (spp_wdatacode                     ), // (u_spp_ingress) <= (u_cluster)
	.us_weobi           (spp_weobi                         ), // (u_spp_ingress) <= (u_cluster)
	.us_wlast           (spp_wlast                         ), // (u_spp_ingress) <= (u_cluster)
	.us_wstrb           (spp_wstrb                         ), // (u_spp_ingress) <= (u_cluster)
	.us_wutid           (spp_wutid                         ), // (u_spp_ingress) <= (u_cluster)
	.us_wvalid          (spp_wvalid                        ), // (u_spp_ingress) <= (u_cluster)
	.us_wvalidcode      (spp_wvalidcode                    ), // (u_spp_ingress) <= (u_cluster)
	.us_wready          (spp_wready                        ), // (u_spp_ingress) => (u_cluster)
	.us_wreadycode      (spp_wreadycode                    ), // (u_spp_ingress) => (u_cluster)
	.ds_araddr          (axi_spp_araddr                    ), // (u_spp_ingress) => ()
	.ds_arburst         (axi_spp_arburst                   ), // (u_spp_ingress) => ()
	.ds_arcache         (axi_spp_arcache                   ), // (u_spp_ingress) => ()
	.ds_arid            (axi_spp_arid                      ), // (u_spp_ingress) => ()
	.ds_arlen           (axi_spp_arlen                     ), // (u_spp_ingress) => ()
	.ds_arlock          (axi_spp_arlock                    ), // (u_spp_ingress) => ()
	.ds_arprot          (axi_spp_arprot                    ), // (u_spp_ingress) => ()
	.ds_arsize          (axi_spp_arsize                    ), // (u_spp_ingress) => ()
	.ds_arvalid         (axi_spp_arvalid                   ), // (u_spp_ingress) => ()
	.ds_arready         (axi_spp_arready                   ), // (u_spp_ingress) <= ()
	.ds_awaddr          (axi_spp_awaddr                    ), // (u_spp_ingress) => ()
	.ds_awburst         (axi_spp_awburst                   ), // (u_spp_ingress) => ()
	.ds_awcache         (axi_spp_awcache                   ), // (u_spp_ingress) => ()
	.ds_awid            (axi_spp_awid                      ), // (u_spp_ingress) => ()
	.ds_awlen           (axi_spp_awlen                     ), // (u_spp_ingress) => ()
	.ds_awlock          (axi_spp_awlock                    ), // (u_spp_ingress) => ()
	.ds_awprot          (axi_spp_awprot                    ), // (u_spp_ingress) => ()
	.ds_awready         (axi_spp_awready                   ), // (u_spp_ingress) <= ()
	.ds_awsize          (axi_spp_awsize                    ), // (u_spp_ingress) => ()
	.ds_awvalid         (axi_spp_awvalid                   ), // (u_spp_ingress) => ()
	.ds_bid             (axi_spp_bid                       ), // (u_spp_ingress) <= ()
	.ds_bready          (axi_spp_bready                    ), // (u_spp_ingress) => ()
	.ds_bresp           (axi_spp_bresp                     ), // (u_spp_ingress) <= ()
	.ds_bvalid          (axi_spp_bvalid                    ), // (u_spp_ingress) <= ()
	.ds_rdata           (axi_spp_rdata                     ), // (u_spp_ingress) <= ()
	.ds_rid             (axi_spp_rid                       ), // (u_spp_ingress) <= ()
	.ds_rlast           (axi_spp_rlast                     ), // (u_spp_ingress) <= ()
	.ds_rready          (axi_spp_rready                    ), // (u_spp_ingress) => ()
	.ds_rresp           (axi_spp_rresp                     ), // (u_spp_ingress) <= ()
	.ds_rvalid          (axi_spp_rvalid                    ), // (u_spp_ingress) <= ()
	.ds_wdata           (axi_spp_wdata                     ), // (u_spp_ingress) => ()
	.ds_wlast           (axi_spp_wlast                     ), // (u_spp_ingress) => ()
	.ds_wready          (axi_spp_wready                    ), // (u_spp_ingress) <= ()
	.ds_wstrb           (axi_spp_wstrb                     ), // (u_spp_ingress) => ()
	.ds_wvalid          (axi_spp_wvalid                    ), // (u_spp_ingress) => ()
	.event_handshake_err(nds_unused_spp_event_handshake_err), // (u_spp_ingress) => ()
	.event_eobi_err     (nds_unused_spp_event_eobi_err     ), // (u_spp_ingress) => ()
	.event_data_err     (nds_unused_spp_event_data_err     ), // (u_spp_ingress) => ()
	.event_ctl_err      (nds_unused_spp_event_ctl_err      )  // (u_spp_ingress) => ()
); // end of u_spp_ingress

   `endif // NDS_IO_SPP
`endif // NDS_IO_BUS_PROTECTION
nceplmt100 #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BUS_TYPE        ("axi"           ),
	.DATA_WIDTH      (NCE_DATA_WIDTH  ),
	.GRAY_WIDTH      (2               ),
	.NHART           (NHART           ),
	.SYNC_STAGE      (SYNC_STAGE      )
) u_plmt (
	.araddr   (plmt_araddr              ), // (u_plmt) <= ()
	.arburst  (plmt_arburst             ), // (u_plmt) <= ()
	.arcache  (plmt_arcache             ), // (u_plmt) <= ()
	.arid     (4'd0                     ), // (u_plmt) <= ()
	.arlen    (plmt_arlen               ), // (u_plmt) <= ()
	.arlock   (plmt_arlock              ), // (u_plmt) <= ()
	.arprot   (plmt_arprot              ), // (u_plmt) <= ()
	.arready  (plmt_arready             ), // (u_plmt) => (u_axi_busdec)
	.arsize   (plmt_arsize              ), // (u_plmt) <= ()
	.arvalid  (plmt_arvalid             ), // (u_plmt) <= (u_axi_busdec)
	.awaddr   (plmt_awaddr              ), // (u_plmt) <= ()
	.awburst  (plmt_awburst             ), // (u_plmt) <= ()
	.awcache  (plmt_awcache             ), // (u_plmt) <= ()
	.awid     (4'd0                     ), // (u_plmt) <= ()
	.awlen    (plmt_awlen               ), // (u_plmt) <= ()
	.awlock   (plmt_awlock              ), // (u_plmt) <= ()
	.awprot   (plmt_awprot              ), // (u_plmt) <= ()
	.awready  (plmt_awready             ), // (u_plmt) => (u_axi_busdec)
	.awsize   (plmt_awsize              ), // (u_plmt) <= ()
	.awvalid  (plmt_awvalid             ), // (u_plmt) <= (u_axi_busdec)
	.bid      (nds_unused_plmt_bid      ), // (u_plmt) => ()
	.bready   (plmt_bready              ), // (u_plmt) <= (u_axi_busdec)
	.bresp    (plmt_bresp               ), // (u_plmt) => (u_axi_busdec)
	.bvalid   (plmt_bvalid              ), // (u_plmt) => (u_axi_busdec)
	.haddr    ({ADDR_WIDTH{1'b0}}       ), // () <= ()
	.hburst   (3'd0                     ), // (u_plmt) <= ()
	.hrdata   (nds_unused_plmt_hrdata   ), // (u_plmt) => ()
	.hready   (1'd0                     ), // (u_plmt) <= ()
	.hreadyout(nds_unused_plmt_hreadyout), // (u_plmt) => ()
	.hresp    (nds_unused_plmt_hresp    ), // (u_plmt) => ()
	.hsel     (1'd0                     ), // (u_plmt) <= ()
	.hsize    (3'd0                     ), // (u_plmt) <= ()
	.htrans   (2'd0                     ), // (u_plmt) <= ()
	.hwdata   ({(NCE_DATA_WIDTH){1'b0}} ), // () <= ()
	.hwrite   (1'd0                     ), // (u_plmt) <= ()
	.mtip     (mtip                     ), // (u_plmt) => ()
	.rdata    (plmt_rdata               ), // (u_plmt) => (u_axi_busdec)
	.rid      (nds_unused_plmt_rid      ), // (u_plmt) => ()
	.rlast    (plmt_rlast               ), // (u_plmt) => (u_axi_busdec)
	.rready   (plmt_rready              ), // (u_plmt) <= (u_axi_busdec)
	.rresp    (plmt_rresp               ), // (u_plmt) => (u_axi_busdec)
	.rvalid   (plmt_rvalid              ), // (u_plmt) => (u_axi_busdec)
	.wdata    (plmt_wdata               ), // (u_plmt) <= ()
	.wlast    (plmt_wlast               ), // (u_plmt) <= ()
	.wready   (plmt_wready              ), // (u_plmt) => (u_axi_busdec)
	.wstrb    (plmt_wstrb               ), // (u_plmt) <= ()
	.wvalid   (plmt_wvalid              ), // (u_plmt) <= (u_axi_busdec)
	.clk      (aclk                     ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.resetn   (aresetn                  ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.mtime_clk(mtime_clk                ), // (u_plmt) <= ()
	.por_rstn (por_rstn                 ), // (u_plmt) <= ()
	.test_mode(test_mode                ), // (u_cluster,u_plmt) <= ()
	.stoptime (stoptime                 )  // (u_plmt) <= ()
); // end of u_plmt

`ifdef PLATFORM_DEBUG_SUBSYSTEM
ncepldm200 #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (NCE_DATA_WIDTH  ),
	.DMXTRIGGER_COUNT(DMXTRIGGER_COUNT),
	.HALTGROUP_COUNT (HALTGROUP_COUNT ),
	.NHART           (NHART           ),
	.PROGBUF_SIZE    (PROGBUF_SIZE    ),
	.RV_BUS_TYPE     ("axi"           ),
	.SYNC_STAGE      (SYNC_STAGE      ),
	.SYSTEM_BUS_ACCESS_SUPPORT(PLDM_SYS_BUS_ACCESS),
	.SYS_ADDR_WIDTH  (ADDR_WIDTH      ),
	.SYS_BUS_TYPE    ("axi"           ),
	.SYS_DATA_WIDTH  (DM_SYS_DATA_WIDTH),
	.SYS_ID_WIDTH    (BIU_ID_WIDTH    )
) u_pldm (
	.debugint           (dm_debugint                   ), // (u_pldm) => ()
	.resethaltreq       (dm_resethaltreq               ), // (u_pldm) => ()
	.dmactive           (dmactive                      ), // (u_pldm) => ()
	.ndmreset           (ndmreset                      ), // (u_pldm) => ()
	.clk                (aclk                          ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.dmi_resetn         (dmi_resetn                    ), // (u_pldm) <= ()
	.hart_nonexistent   (hart_nonexistent              ), // (u_pldm) <= ()
	.hart_unavail       (dm_hart_unavail               ), // (u_pldm) <= ()
	.hart_under_reset   (dm_hart_under_reset           ), // (u_pldm) <= ()
	.bus_resetn         (aresetn                       ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.rv_haddr           ({ADDR_WIDTH{1'b0}}            ), // () <= ()
	.rv_htrans          (2'd0                          ), // (u_pldm) <= ()
	.rv_hwrite          (1'd0                          ), // (u_pldm) <= ()
	.rv_hsize           (3'd0                          ), // (u_pldm) <= ()
	.rv_hburst          (3'd0                          ), // (u_pldm) <= ()
	.rv_hprot           (4'd0                          ), // (u_pldm) <= ()
	.rv_hwdata          ({(NCE_DATA_WIDTH){1'b0}}      ), // () <= ()
	.rv_hsel            (1'd0                          ), // (u_pldm) <= ()
	.rv_hready          (1'd0                          ), // (u_pldm) <= ()
	.rv_hrdata          (nds_unused_dm_hrdata          ), // (u_pldm) => ()
	.rv_hreadyout       (nds_unused_dm_hreadyout       ), // (u_pldm) => ()
	.rv_hresp           (nds_unused_dm_hresp           ), // (u_pldm) => ()
	.rv_awid            (4'd0                          ), // (u_pldm) <= ()
	.rv_awaddr          (dm_awaddr                     ), // (u_pldm) <= ()
	.rv_awlen           (dm_awlen                      ), // (u_pldm) <= ()
	.rv_awsize          (dm_awsize                     ), // (u_pldm) <= ()
	.rv_awburst         (dm_awburst                    ), // (u_pldm) <= ()
	.rv_awlock          (dm_awlock                     ), // (u_pldm) <= ()
	.rv_awcache         (dm_awcache                    ), // (u_pldm) <= ()
	.rv_awprot          (dm_awprot                     ), // (u_pldm) <= ()
	.rv_awvalid         (dm_awvalid                    ), // (u_pldm) <= (u_axi_busdec)
	.rv_awready         (dm_awready                    ), // (u_pldm) => (u_axi_busdec)
	.rv_wdata           (dm_wdata                      ), // (u_pldm) <= ()
	.rv_wstrb           (dm_wstrb                      ), // (u_pldm) <= ()
	.rv_wlast           (dm_wlast                      ), // (u_pldm) <= ()
	.rv_wvalid          (dm_wvalid                     ), // (u_pldm) <= (u_axi_busdec)
	.rv_wready          (dm_wready                     ), // (u_pldm) => (u_axi_busdec)
	.rv_bid             (nds_unused_dm_bid             ), // (u_pldm) => ()
	.rv_bresp           (dm_bresp                      ), // (u_pldm) => (u_axi_busdec)
	.rv_bvalid          (dm_bvalid                     ), // (u_pldm) => (u_axi_busdec)
	.rv_bready          (dm_bready                     ), // (u_pldm) <= (u_axi_busdec)
	.rv_arid            (4'd0                          ), // (u_pldm) <= ()
	.rv_araddr          (dm_araddr                     ), // (u_pldm) <= ()
	.rv_arlen           (dm_arlen                      ), // (u_pldm) <= ()
	.rv_arsize          (dm_arsize                     ), // (u_pldm) <= ()
	.rv_arburst         (dm_arburst                    ), // (u_pldm) <= ()
	.rv_arlock          (dm_arlock                     ), // (u_pldm) <= ()
	.rv_arcache         (dm_arcache                    ), // (u_pldm) <= ()
	.rv_arprot          (dm_arprot                     ), // (u_pldm) <= ()
	.rv_arvalid         (dm_arvalid                    ), // (u_pldm) <= (u_axi_busdec)
	.rv_arready         (dm_arready                    ), // (u_pldm) => (u_axi_busdec)
	.rv_rid             (nds_unused_dm_rid             ), // (u_pldm) => ()
	.rv_rdata           (dm_rdata                      ), // (u_pldm) => (u_axi_busdec)
	.rv_rresp           (dm_rresp                      ), // (u_pldm) => (u_axi_busdec)
	.rv_rlast           (dm_rlast                      ), // (u_pldm) => (u_axi_busdec)
	.rv_rvalid          (dm_rvalid                     ), // (u_pldm) => (u_axi_busdec)
	.rv_rready          (dm_rready                     ), // (u_pldm) <= (u_axi_busdec)
	.sys_awid           (dm_sup_awid                   ), // (u_pldm) => (u_axi_dm_sup)
	.sys_awaddr         (dm_sup_awaddr                 ), // (u_pldm) => (u_axi_dm_sup)
	.sys_awlen          (dm_sup_awlen                  ), // (u_pldm) => (u_axi_dm_sup)
	.sys_awsize         (dm_sup_awsize                 ), // (u_pldm) => (u_axi_dm_sup)
	.sys_awburst        (dm_sup_awburst                ), // (u_pldm) => (u_axi_dm_sup)
	.sys_awlock         (dm_sup_awlock                 ), // (u_pldm) => ()
	.sys_awcache        (dm_sup_awcache                ), // (u_pldm) => ()
	.sys_awprot         (dm_sup_awprot                 ), // (u_pldm) => ()
	.sys_awvalid        (dm_sup_awvalid                ), // (u_pldm) => (u_axi_dm_sup)
	.sys_awready        (dm_sup_awready                ), // (u_pldm) <= (u_axi_dm_sup)
	.sys_wdata          (dm_sup_wdata                  ), // (u_pldm) => (u_axi_dm_sup)
	.sys_wstrb          (dm_sup_wstrb                  ), // (u_pldm) => (u_axi_dm_sup)
	.sys_wlast          (dm_sup_wlast                  ), // (u_pldm) => (u_axi_dm_sup)
	.sys_wvalid         (dm_sup_wvalid                 ), // (u_pldm) => (u_axi_dm_sup)
	.sys_wready         (dm_sup_wready                 ), // (u_pldm) <= (u_axi_dm_sup)
	.sys_bid            (dm_sup_bid                    ), // (u_pldm) <= (u_axi_dm_sup)
	.sys_bresp          (dm_sup_bresp                  ), // (u_pldm) <= ()
	.sys_bvalid         (dm_sup_bvalid                 ), // (u_pldm) <= (u_axi_dm_sup)
	.sys_bready         (dm_sup_bready                 ), // (u_pldm) => (u_axi_dm_sup)
	.sys_arid           (dm_sup_arid                   ), // (u_pldm) => (u_axi_dm_sup)
	.sys_araddr         (dm_sup_araddr                 ), // (u_pldm) => (u_axi_dm_sup)
	.sys_arlen          (dm_sup_arlen                  ), // (u_pldm) => (u_axi_dm_sup)
	.sys_arsize         (dm_sup_arsize                 ), // (u_pldm) => (u_axi_dm_sup)
	.sys_arburst        (dm_sup_arburst                ), // (u_pldm) => (u_axi_dm_sup)
	.sys_arlock         (dm_sup_arlock                 ), // (u_pldm) => ()
	.sys_arcache        (dm_sup_arcache                ), // (u_pldm) => ()
	.sys_arprot         (dm_sup_arprot                 ), // (u_pldm) => ()
	.sys_arvalid        (dm_sup_arvalid                ), // (u_pldm) => (u_axi_dm_sup)
	.sys_arready        (dm_sup_arready                ), // (u_pldm) <= (u_axi_dm_sup)
	.sys_rid            (dm_sup_rid                    ), // (u_pldm) <= (u_axi_dm_sup)
	.sys_rdata          (dm_sup_rdata                  ), // (u_pldm) <= (u_axi_dm_sup)
	.sys_rresp          (dm_sup_rresp                  ), // (u_pldm) <= (u_axi_dm_sup)
	.sys_rlast          (dm_sup_rlast                  ), // (u_pldm) <= (u_axi_dm_sup)
	.sys_rvalid         (dm_sup_rvalid                 ), // (u_pldm) <= (u_axi_dm_sup)
	.sys_rready         (dm_sup_rready                 ), // (u_pldm) => (u_axi_dm_sup)
	.sys_haddr          (nds_unused_dm_sup_haddr       ), // (u_pldm) => ()
	.sys_htrans         (nds_unused_dm_sup_htrans      ), // (u_pldm) => ()
	.sys_hwrite         (nds_unused_dm_sup_hwrite      ), // (u_pldm) => ()
	.sys_hsize          (nds_unused_dm_sup_hsize       ), // (u_pldm) => ()
	.sys_hburst         (nds_unused_dm_sup_hburst      ), // (u_pldm) => ()
	.sys_hprot          (nds_unused_dm_sup_hprot       ), // (u_pldm) => ()
	.sys_hwdata         (nds_unused_dm_sup_hwdata      ), // (u_pldm) => ()
	.sys_hbusreq        (nds_unused_dm_sup_hbusreq     ), // (u_pldm) => ()
	.sys_hrdata         ({DM_SYS_DATA_WIDTH{1'b0}}     ), // () <= ()
	.sys_hready         (1'b0                          ), // (u_pldm) <= ()
	.sys_hresp          (2'h0                          ), // (u_pldm) <= ()
	.sys_hgrant         (1'b0                          ), // (u_pldm) <= ()
	.dmi_haddr          (dmi_haddr                     ), // (u_pldm) <= ()
	.dmi_htrans         (dmi_htrans                    ), // (u_pldm) <= ()
	.dmi_hwrite         (dmi_hwrite                    ), // (u_pldm) <= ()
	.dmi_hsize          (dmi_hsize                     ), // (u_pldm) <= ()
	.dmi_hburst         (dmi_hburst                    ), // (u_pldm) <= ()
	.dmi_hprot          (dmi_hprot                     ), // (u_pldm) <= ()
	.dmi_hwdata         (dmi_hwdata                    ), // (u_pldm) <= ()
	.dmi_hsel           (dmi_hsel                      ), // (u_pldm) <= ()
	.dmi_hready         (dmi_hready                    ), // (u_pldm) <= ()
	.dmi_hrdata         (dmi_hrdata                    ), // (u_pldm) => ()
	.dmi_hreadyout      (dmi_hreadyout                 ), // (u_pldm) => ()
	.dmi_hresp          (dmi_hresp                     ), // (u_pldm) => ()
	.xtrigger_halt_in   ({(DMXTRIGGER_MSB+1){1'b0}}    ), // () <= ()
	.xtrigger_halt_out  (nds_unused_xtrigger_halt_out  ), // (u_pldm) => ()
	.xtrigger_resume_in ({(DMXTRIGGER_MSB+1){1'b0}}    ), // () <= ()
	.xtrigger_resume_out(nds_unused_xtrigger_resume_out)  // (u_pldm) => ()
); // end of u_pldm

generate
if ((BIU_DATA_WIDTH > DM_SYS_DATA_WIDTH)) begin : gen_axi_dm_sup

	atcsizeup300 #(
		.DS_DATA_WIDTH   (SIZEUP_DS_DATA_WIDTH),
		.ID_WIDTH        (BIU_ID_WIDTH    ),
		.US_DATA_WIDTH   (DM_SYS_DATA_WIDTH)
	) u_axi_dm_sup (
		.aclk      (aclk                            ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
		.aresetn   (aresetn                         ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
		.us_arvalid(dm_sup_arvalid                  ), // (u_axi_dm_sup) <= (u_pldm)
		.us_arid   (dm_sup_arid                     ), // (u_axi_dm_sup) <= (u_pldm)
		.us_araddr (dm_sup_araddr[SIZEUP_ADDR_MSB:0]), // (u_axi_dm_sup) <= (u_pldm)
		.us_arlen  (dm_sup_arlen[3:0]               ), // (u_axi_dm_sup) <= (u_pldm)
		.us_arsize (dm_sup_arsize                   ), // (u_axi_dm_sup) <= (u_pldm)
		.us_arburst(dm_sup_arburst                  ), // (u_axi_dm_sup) <= (u_pldm)
		.us_arready(dm_sup_arready                  ), // (u_axi_dm_sup) => (u_pldm)
		.us_awvalid(dm_sup_awvalid                  ), // (u_axi_dm_sup) <= (u_pldm)
		.us_awid   (dm_sup_awid                     ), // (u_axi_dm_sup) <= (u_pldm)
		.us_awaddr (dm_sup_awaddr[SIZEUP_ADDR_MSB:0]), // (u_axi_dm_sup) <= (u_pldm)
		.us_awlen  (dm_sup_awlen[3:0]               ), // (u_axi_dm_sup) <= (u_pldm)
		.us_awsize (dm_sup_awsize                   ), // (u_axi_dm_sup) <= (u_pldm)
		.us_awburst(dm_sup_awburst                  ), // (u_axi_dm_sup) <= (u_pldm)
		.us_awready(dm_sup_awready                  ), // (u_axi_dm_sup) => (u_pldm)
		.ds_arvalid(dm_sys_arvalid                  ), // (u_axi_dm_sup) => ()
		.ds_arready(dm_sys_arready                  ), // (u_axi_dm_sup) <= ()
		.ds_awvalid(dm_sys_awvalid                  ), // (u_axi_dm_sup) => ()
		.ds_awready(dm_sys_awready                  ), // (u_axi_dm_sup) <= ()
		.us_rid    (dm_sup_rid                      ), // (u_axi_dm_sup) => (u_pldm)
		.us_rvalid (dm_sup_rvalid                   ), // (u_axi_dm_sup) => (u_pldm)
		.us_rdata  (dm_sup_rdata                    ), // (u_axi_dm_sup) => (u_pldm)
		.us_rready (dm_sup_rready                   ), // (u_axi_dm_sup) <= (u_pldm)
		.ds_rlast  (dm_sys_rlast                    ), // (u_axi_dm_sup) <= ()
		.ds_rvalid (dm_sys_rvalid                   ), // (u_axi_dm_sup) <= ()
		.ds_rdata  (dm_sys_rdata                    ), // (u_axi_dm_sup) <= ()
		.ds_rready (dm_sys_rready                   ), // (u_axi_dm_sup) => ()
		.us_wstrb  (dm_sup_wstrb                    ), // (u_axi_dm_sup) <= (u_pldm)
		.us_wlast  (dm_sup_wlast                    ), // (u_axi_dm_sup) <= (u_pldm)
		.us_wvalid (dm_sup_wvalid                   ), // (u_axi_dm_sup) <= (u_pldm)
		.us_wdata  (dm_sup_wdata                    ), // (u_axi_dm_sup) <= (u_pldm)
		.us_wready (dm_sup_wready                   ), // (u_axi_dm_sup) => (u_pldm)
		.ds_wstrb  (dm_sys_wstrb                    ), // (u_axi_dm_sup) => ()
		.ds_wvalid (dm_sys_wvalid                   ), // (u_axi_dm_sup) => ()
		.ds_wdata  (dm_sys_wdata                    ), // (u_axi_dm_sup) => ()
		.ds_wready (dm_sys_wready                   ), // (u_axi_dm_sup) <= ()
		.ds_wlast  (dm_sys_wlast                    ), // (u_axi_dm_sup) => ()
		.us_rlast  (dm_sup_rlast                    ), // (u_axi_dm_sup) => (u_pldm)
		.us_rresp  (dm_sup_rresp                    ), // (u_axi_dm_sup) => (u_pldm)
		.ds_rresp  (dm_sys_rresp                    ), // (u_axi_dm_sup) <= ()
		.us_bid    (dm_sup_bid                      ), // (u_axi_dm_sup) => (u_pldm)
		.us_bvalid (dm_sup_bvalid                   ), // (u_axi_dm_sup) => (u_pldm)
		.us_bready (dm_sup_bready                   ), // (u_axi_dm_sup) <= (u_pldm)
		.ds_bvalid (dm_sys_bvalid                   ), // (u_axi_dm_sup) <= ()
		.ds_bready (dm_sys_bready                   )  // (u_axi_dm_sup) => ()
	); // end of u_axi_dm_sup

end // end of gen_axi_dm_sup
endgenerate

`endif // PLATFORM_DEBUG_SUBSYSTEM
nceplic100 #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.ASYNC_INT       (1024'hc000000   ),
	.DATA_WIDTH      (NCE_DATA_WIDTH  ),
	.EDGE_TRIGGER    (1024'h0         ),
	.INT_NUM         (31              ),
	.MAX_PRIORITY    (3               ),
	.PLIC_BUS        ("axi"           ),
	.SYNC_STAGE      (SYNC_STAGE      ),
	.TARGET_NUM      (PLIC_HW_TARGET_NUM[5:0]),
	.VECTOR_PLIC_SUPPORT(VECTOR_PLIC_SUPPORT)
) u_plic (
	.araddr   (plic_araddr              ), // (u_plic) <= ()
	.arburst  (plic_arburst             ), // (u_plic) <= ()
	.arcache  (plic_arcache             ), // (u_plic) <= ()
	.arid     (4'd0                     ), // (u_plic) <= ()
	.arlen    (plic_arlen               ), // (u_plic) <= ()
	.arlock   (plic_arlock              ), // (u_plic) <= ()
	.arprot   (plic_arprot              ), // (u_plic) <= ()
	.arready  (plic_arready             ), // (u_plic) => (u_axi_busdec)
	.arsize   (plic_arsize              ), // (u_plic) <= ()
	.arvalid  (plic_arvalid             ), // (u_plic) <= (u_axi_busdec)
	.awaddr   (plic_awaddr              ), // (u_plic) <= ()
	.awburst  (plic_awburst             ), // (u_plic) <= ()
	.awcache  (plic_awcache             ), // (u_plic) <= ()
	.awid     (4'd0                     ), // (u_plic) <= ()
	.awlen    (plic_awlen               ), // (u_plic) <= ()
	.awlock   (plic_awlock              ), // (u_plic) <= ()
	.awprot   (plic_awprot              ), // (u_plic) <= ()
	.awready  (plic_awready             ), // (u_plic) => (u_axi_busdec)
	.awsize   (plic_awsize              ), // (u_plic) <= ()
	.awvalid  (plic_awvalid             ), // (u_plic) <= (u_axi_busdec)
	.bid      (nds_unused_plic_bid      ), // (u_plic) => ()
	.bready   (plic_bready              ), // (u_plic) <= (u_axi_busdec)
	.bresp    (plic_bresp               ), // (u_plic) => (u_axi_busdec)
	.bvalid   (plic_bvalid              ), // (u_plic) => (u_axi_busdec)
	.haddr    ({ADDR_WIDTH{1'b0}}       ), // () <= ()
	.hburst   (3'd0                     ), // (u_plic) <= ()
	.hrdata   (nds_unused_plic_hrdata   ), // (u_plic) => ()
	.hready   (1'b0                     ), // (u_plic) <= ()
	.hreadyout(nds_unused_plic_hreadyout), // (u_plic) => ()
	.hresp    (nds_unused_plic_hresp    ), // (u_plic) => ()
	.hsel     (1'b0                     ), // (u_plic) <= ()
	.hsize    (3'd0                     ), // (u_plic) <= ()
	.htrans   (2'd0                     ), // (u_plic) <= ()
	.hwdata   ({NCE_DATA_WIDTH{1'b0}}   ), // () <= ()
	.hwrite   (1'b0                     ), // (u_plic) <= ()
	.rdata    (plic_rdata               ), // (u_plic) => (u_axi_busdec)
	.rid      (nds_unused_plic_rid      ), // (u_plic) => ()
	.rlast    (plic_rlast               ), // (u_plic) => (u_axi_busdec)
	.rready   (plic_rready              ), // (u_plic) <= (u_axi_busdec)
	.rresp    (plic_rresp               ), // (u_plic) => (u_axi_busdec)
	.rvalid   (plic_rvalid              ), // (u_plic) => (u_axi_busdec)
	.wdata    (plic_wdata               ), // (u_plic) <= ()
	.wlast    (plic_wlast               ), // (u_plic) <= ()
	.wready   (plic_wready              ), // (u_plic) => (u_axi_busdec)
	.wstrb    (plic_wstrb               ), // (u_plic) <= ()
	.wvalid   (plic_wvalid              ), // (u_plic) <= (u_axi_busdec)
	.clk      (aclk                     ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.reset_n  (aresetn                  ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.int_src  (int_src                  ), // (u_plic) <= ()
	.t0_eip   (hart0_meip               ), // (u_plic) => ()
	.t0_eiid  (hart0_meiid              ), // (u_plic) => ()
	.t0_eiack (hart0_meiack             ), // (u_plic) <= ()
	.t1_eip   (hart0_seip               ), // (u_plic) => ()
	.t1_eiid  (hart0_seiid              ), // (u_plic) => ()
	.t1_eiack (hart0_seiack             ), // (u_plic) <= ()
	.t2_eip   (hart1_meip               ), // (u_plic) => ()
	.t2_eiid  (hart1_meiid              ), // (u_plic) => ()
	.t2_eiack (hart1_meiack             ), // (u_plic) <= ()
	.t3_eip   (hart1_seip               ), // (u_plic) => ()
	.t3_eiid  (hart1_seiid              ), // (u_plic) => ()
	.t3_eiack (hart1_seiack             ), // (u_plic) <= ()
	.t4_eip   (nds_unused_plic_t4_eip   ), // (u_plic) => ()
	.t4_eiid  (nds_unused_plic_t4_eiid  ), // (u_plic) => ()
	.t4_eiack (1'b0                     ), // (u_plic) <= ()
	.t5_eip   (nds_unused_plic_t5_eip   ), // (u_plic) => ()
	.t5_eiid  (nds_unused_plic_t5_eiid  ), // (u_plic) => ()
	.t5_eiack (1'b0                     ), // (u_plic) <= ()
	.t6_eip   (nds_unused_plic_t6_eip   ), // (u_plic) => ()
	.t6_eiid  (nds_unused_plic_t6_eiid  ), // (u_plic) => ()
	.t6_eiack (1'b0                     ), // (u_plic) <= ()
	.t7_eip   (nds_unused_plic_t7_eip   ), // (u_plic) => ()
	.t7_eiid  (nds_unused_plic_t7_eiid  ), // (u_plic) => ()
	.t7_eiack (1'b0                     ), // (u_plic) <= ()
	.t8_eip   (nds_unused_plic_t8_eip   ), // (u_plic) => ()
	.t8_eiid  (nds_unused_plic_t8_eiid  ), // (u_plic) => ()
	.t8_eiack (1'b0                     ), // (u_plic) <= ()
	.t9_eip   (nds_unused_plic_t9_eip   ), // (u_plic) => ()
	.t9_eiid  (nds_unused_plic_t9_eiid  ), // (u_plic) => ()
	.t9_eiack (1'b0                     ), // (u_plic) <= ()
	.t10_eip  (nds_unused_plic_t10_eip  ), // (u_plic) => ()
	.t10_eiid (nds_unused_plic_t10_eiid ), // (u_plic) => ()
	.t10_eiack(1'b0                     ), // (u_plic) <= ()
	.t11_eip  (nds_unused_plic_t11_eip  ), // (u_plic) => ()
	.t11_eiid (nds_unused_plic_t11_eiid ), // (u_plic) => ()
	.t11_eiack(1'b0                     ), // (u_plic) <= ()
	.t12_eip  (nds_unused_plic_t12_eip  ), // (u_plic) => ()
	.t12_eiid (nds_unused_plic_t12_eiid ), // (u_plic) => ()
	.t12_eiack(1'b0                     ), // (u_plic) <= ()
	.t13_eip  (nds_unused_plic_t13_eip  ), // (u_plic) => ()
	.t13_eiid (nds_unused_plic_t13_eiid ), // (u_plic) => ()
	.t13_eiack(1'b0                     ), // (u_plic) <= ()
	.t14_eip  (nds_unused_plic_t14_eip  ), // (u_plic) => ()
	.t14_eiid (nds_unused_plic_t14_eiid ), // (u_plic) => ()
	.t14_eiack(1'b0                     ), // (u_plic) <= ()
	.t15_eip  (nds_unused_plic_t15_eip  ), // (u_plic) => ()
	.t15_eiid (nds_unused_plic_t15_eiid ), // (u_plic) => ()
	.t15_eiack(1'b0                     )  // (u_plic) <= ()
); // end of u_plic

`ifdef PLATFORM_NO_PLIC_SW
`else
nceplic100 #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (NCE_DATA_WIDTH  ),
	.EDGE_TRIGGER    (1024'd0         ),
	.INT_NUM         (16              ),
	.MAX_PRIORITY    (3               ),
	.PLIC_BUS        ("axi"           ),
	.TARGET_NUM      (PLIC_SW_TARGET_NUM[5:0]),
	.VECTOR_PLIC_SUPPORT("no"            )
) u_plic_sw (
	.araddr   (plicsw_araddr              ), // (u_plic_sw) <= ()
	.arburst  (plicsw_arburst             ), // (u_plic_sw) <= ()
	.arcache  (plicsw_arcache             ), // (u_plic_sw) <= ()
	.arid     (4'd0                       ), // (u_plic_sw) <= ()
	.arlen    (plicsw_arlen               ), // (u_plic_sw) <= ()
	.arlock   (plicsw_arlock              ), // (u_plic_sw) <= ()
	.arprot   (plicsw_arprot              ), // (u_plic_sw) <= ()
	.arready  (plicsw_arready             ), // (u_plic_sw) => (u_axi_busdec)
	.arsize   (plicsw_arsize              ), // (u_plic_sw) <= ()
	.arvalid  (plicsw_arvalid             ), // (u_plic_sw) <= (u_axi_busdec)
	.awaddr   (plicsw_awaddr              ), // (u_plic_sw) <= ()
	.awburst  (plicsw_awburst             ), // (u_plic_sw) <= ()
	.awcache  (plicsw_awcache             ), // (u_plic_sw) <= ()
	.awid     (4'd0                       ), // (u_plic_sw) <= ()
	.awlen    (plicsw_awlen               ), // (u_plic_sw) <= ()
	.awlock   (plicsw_awlock              ), // (u_plic_sw) <= ()
	.awprot   (plicsw_awprot              ), // (u_plic_sw) <= ()
	.awready  (plicsw_awready             ), // (u_plic_sw) => (u_axi_busdec)
	.awsize   (plicsw_awsize              ), // (u_plic_sw) <= ()
	.awvalid  (plicsw_awvalid             ), // (u_plic_sw) <= (u_axi_busdec)
	.bid      (nds_unused_plicsw_bid      ), // (u_plic_sw) => ()
	.bready   (plicsw_bready              ), // (u_plic_sw) <= (u_axi_busdec)
	.bresp    (plicsw_bresp               ), // (u_plic_sw) => (u_axi_busdec)
	.bvalid   (plicsw_bvalid              ), // (u_plic_sw) => (u_axi_busdec)
	.haddr    ({ADDR_WIDTH{1'b0}}         ), // () <= ()
	.hburst   (3'd0                       ), // (u_plic_sw) <= ()
	.hrdata   (nds_unused_plicsw_hrdata   ), // (u_plic_sw) => ()
	.hready   (1'b0                       ), // (u_plic_sw) <= ()
	.hreadyout(nds_unused_plicsw_hreadyout), // (u_plic_sw) => ()
	.hresp    (nds_unused_plicsw_hresp    ), // (u_plic_sw) => ()
	.hsel     (1'b0                       ), // (u_plic_sw) <= ()
	.hsize    (3'd0                       ), // (u_plic_sw) <= ()
	.htrans   (2'd0                       ), // (u_plic_sw) <= ()
	.hwdata   ({NCE_DATA_WIDTH{1'b0}}     ), // () <= ()
	.hwrite   (1'b0                       ), // (u_plic_sw) <= ()
	.rdata    (plicsw_rdata               ), // (u_plic_sw) => (u_axi_busdec)
	.rid      (nds_unused_plicsw_rid      ), // (u_plic_sw) => ()
	.rlast    (plicsw_rlast               ), // (u_plic_sw) => (u_axi_busdec)
	.rready   (plicsw_rready              ), // (u_plic_sw) <= (u_axi_busdec)
	.rresp    (plicsw_rresp               ), // (u_plic_sw) => (u_axi_busdec)
	.rvalid   (plicsw_rvalid              ), // (u_plic_sw) => (u_axi_busdec)
	.wdata    (plicsw_wdata               ), // (u_plic_sw) <= ()
	.wlast    (plicsw_wlast               ), // (u_plic_sw) <= ()
	.wready   (plicsw_wready              ), // (u_plic_sw) => (u_axi_busdec)
	.wstrb    (plicsw_wstrb               ), // (u_plic_sw) <= ()
	.wvalid   (plicsw_wvalid              ), // (u_plic_sw) <= (u_axi_busdec)
	.clk      (aclk                       ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.reset_n  (aresetn                    ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.int_src  (16'd0                      ), // (u_plic_sw) <= ()
	.t0_eip   (hart0_msip                 ), // (u_plic_sw) => (u_cluster)
	.t0_eiid  (nds_unused_plicsw_t0_eiid  ), // (u_plic_sw) => ()
	.t0_eiack (1'b0                       ), // (u_plic_sw) <= ()
	.t1_eip   (hart1_msip                 ), // (u_plic_sw) => (u_cluster)
	.t1_eiid  (nds_unused_plicsw_t1_eiid  ), // (u_plic_sw) => ()
	.t1_eiack (1'b0                       ), // (u_plic_sw) <= ()
	.t2_eip   (nds_unused_plicsw_t2_eip   ), // (u_plic_sw) => ()
	.t2_eiid  (nds_unused_plicsw_t2_eiid  ), // (u_plic_sw) => ()
	.t2_eiack (1'b0                       ), // (u_plic_sw) <= ()
	.t3_eip   (nds_unused_plicsw_t3_eip   ), // (u_plic_sw) => ()
	.t3_eiid  (nds_unused_plicsw_t3_eiid  ), // (u_plic_sw) => ()
	.t3_eiack (1'b0                       ), // (u_plic_sw) <= ()
	.t4_eip   (nds_unused_plicsw_t4_eip   ), // (u_plic_sw) => ()
	.t4_eiid  (nds_unused_plicsw_t4_eiid  ), // (u_plic_sw) => ()
	.t4_eiack (1'b0                       ), // (u_plic_sw) <= ()
	.t5_eip   (nds_unused_plicsw_t5_eip   ), // (u_plic_sw) => ()
	.t5_eiid  (nds_unused_plicsw_t5_eiid  ), // (u_plic_sw) => ()
	.t5_eiack (1'b0                       ), // (u_plic_sw) <= ()
	.t6_eip   (nds_unused_plicsw_t6_eip   ), // (u_plic_sw) => ()
	.t6_eiid  (nds_unused_plicsw_t6_eiid  ), // (u_plic_sw) => ()
	.t6_eiack (1'b0                       ), // (u_plic_sw) <= ()
	.t7_eip   (nds_unused_plicsw_t7_eip   ), // (u_plic_sw) => ()
	.t7_eiid  (nds_unused_plicsw_t7_eiid  ), // (u_plic_sw) => ()
	.t7_eiack (1'b0                       ), // (u_plic_sw) <= ()
	.t8_eip   (nds_unused_plicsw_t8_eip   ), // (u_plic_sw) => ()
	.t8_eiid  (nds_unused_plicsw_t8_eiid  ), // (u_plic_sw) => ()
	.t8_eiack (1'b0                       ), // (u_plic_sw) <= ()
	.t9_eip   (nds_unused_plicsw_t9_eip   ), // (u_plic_sw) => ()
	.t9_eiid  (nds_unused_plicsw_t9_eiid  ), // (u_plic_sw) => ()
	.t9_eiack (1'b0                       ), // (u_plic_sw) <= ()
	.t10_eip  (nds_unused_plicsw_t10_eip  ), // (u_plic_sw) => ()
	.t10_eiid (nds_unused_plicsw_t10_eiid ), // (u_plic_sw) => ()
	.t10_eiack(1'b0                       ), // (u_plic_sw) <= ()
	.t11_eip  (nds_unused_plicsw_t11_eip  ), // (u_plic_sw) => ()
	.t11_eiid (nds_unused_plicsw_t11_eiid ), // (u_plic_sw) => ()
	.t11_eiack(1'b0                       ), // (u_plic_sw) <= ()
	.t12_eip  (nds_unused_plicsw_t12_eip  ), // (u_plic_sw) => ()
	.t12_eiid (nds_unused_plicsw_t12_eiid ), // (u_plic_sw) => ()
	.t12_eiack(1'b0                       ), // (u_plic_sw) <= ()
	.t13_eip  (nds_unused_plicsw_t13_eip  ), // (u_plic_sw) => ()
	.t13_eiid (nds_unused_plicsw_t13_eiid ), // (u_plic_sw) => ()
	.t13_eiack(1'b0                       ), // (u_plic_sw) <= ()
	.t14_eip  (nds_unused_plicsw_t14_eip  ), // (u_plic_sw) => ()
	.t14_eiid (nds_unused_plicsw_t14_eiid ), // (u_plic_sw) => ()
	.t14_eiack(1'b0                       ), // (u_plic_sw) <= ()
	.t15_eip  (nds_unused_plicsw_t15_eip  ), // (u_plic_sw) => ()
	.t15_eiid (nds_unused_plicsw_t15_eiid ), // (u_plic_sw) => ()
	.t15_eiack(1'b0                       )  // (u_plic_sw) <= ()
); // end of u_plic_sw

`endif // PLATFORM_NO_PLIC_SW
`ifdef NDS_IO_PPI
sample_axi_regfile #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (PPI_DATA_WIDTH  ),
	.ID_WIDTH        (PPI_ID_WIDTH    )
) u_core0_axi_rf (
	.aclk   (aclk                ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.aresetn(aresetn             ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.araddr (core0_axi_rf_araddr ), // (u_core0_axi_rf) <= ()
	.arburst(core0_axi_rf_arburst), // (u_core0_axi_rf) <= ()
	.arcache(core0_axi_rf_arcache), // (u_core0_axi_rf) <= ()
	.arid   (core0_axi_rf_arid   ), // (u_core0_axi_rf) <= ()
	.arlen  (core0_axi_rf_arlen  ), // (u_core0_axi_rf) <= ()
	.arlock (core0_axi_rf_arlock ), // (u_core0_axi_rf) <= ()
	.arprot (core0_axi_rf_arprot ), // (u_core0_axi_rf) <= ()
	.arready(core0_axi_rf_arready), // (u_core0_axi_rf) => ()
	.arsize (core0_axi_rf_arsize ), // (u_core0_axi_rf) <= ()
	.arvalid(core0_axi_rf_arvalid), // (u_core0_axi_rf) <= ()
	.rdata  (core0_axi_rf_rdata  ), // (u_core0_axi_rf) => ()
	.rid    (core0_axi_rf_rid    ), // (u_core0_axi_rf) => ()
	.rlast  (core0_axi_rf_rlast  ), // (u_core0_axi_rf) => ()
	.rready (core0_axi_rf_rready ), // (u_core0_axi_rf) <= ()
	.rresp  (core0_axi_rf_rresp  ), // (u_core0_axi_rf) => ()
	.rvalid (core0_axi_rf_rvalid ), // (u_core0_axi_rf) => ()
	.awaddr (core0_axi_rf_awaddr ), // (u_core0_axi_rf) <= ()
	.awburst(core0_axi_rf_awburst), // (u_core0_axi_rf) <= ()
	.awcache(core0_axi_rf_awcache), // (u_core0_axi_rf) <= ()
	.awid   (core0_axi_rf_awid   ), // (u_core0_axi_rf) <= ()
	.awlen  (core0_axi_rf_awlen  ), // (u_core0_axi_rf) <= ()
	.awlock (core0_axi_rf_awlock ), // (u_core0_axi_rf) <= ()
	.awprot (core0_axi_rf_awprot ), // (u_core0_axi_rf) <= ()
	.awready(core0_axi_rf_awready), // (u_core0_axi_rf) => ()
	.awsize (core0_axi_rf_awsize ), // (u_core0_axi_rf) <= ()
	.awvalid(core0_axi_rf_awvalid), // (u_core0_axi_rf) <= ()
	.bid    (core0_axi_rf_bid    ), // (u_core0_axi_rf) => ()
	.bready (core0_axi_rf_bready ), // (u_core0_axi_rf) <= ()
	.bresp  (core0_axi_rf_bresp  ), // (u_core0_axi_rf) => ()
	.bvalid (core0_axi_rf_bvalid ), // (u_core0_axi_rf) => ()
	.wdata  (core0_axi_rf_wdata  ), // (u_core0_axi_rf) <= ()
	.wlast  (core0_axi_rf_wlast  ), // (u_core0_axi_rf) <= ()
	.wready (core0_axi_rf_wready ), // (u_core0_axi_rf) => ()
	.wstrb  (core0_axi_rf_wstrb  ), // (u_core0_axi_rf) <= ()
	.wvalid (core0_axi_rf_wvalid )  // (u_core0_axi_rf) <= ()
); // end of u_core0_axi_rf

   `ifdef NDS_IO_DCLS_SPLIT
sample_axi_regfile #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (PPI_DATA_WIDTH  ),
	.ID_WIDTH        (PPI_ID_WIDTH    )
) u_core1_axi_rf (
	.aclk   (aclk                ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.aresetn(aresetn             ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.araddr (core1_axi_rf_araddr ), // (u_core1_axi_rf) <= ()
	.arburst(core1_axi_rf_arburst), // (u_core1_axi_rf) <= ()
	.arcache(core1_axi_rf_arcache), // (u_core1_axi_rf) <= ()
	.arid   (core1_axi_rf_arid   ), // (u_core1_axi_rf) <= ()
	.arlen  (core1_axi_rf_arlen  ), // (u_core1_axi_rf) <= ()
	.arlock (core1_axi_rf_arlock ), // (u_core1_axi_rf) <= ()
	.arprot (core1_axi_rf_arprot ), // (u_core1_axi_rf) <= ()
	.arready(core1_axi_rf_arready), // (u_core1_axi_rf) => ()
	.arsize (core1_axi_rf_arsize ), // (u_core1_axi_rf) <= ()
	.arvalid(core1_axi_rf_arvalid), // (u_core1_axi_rf) <= ()
	.rdata  (core1_axi_rf_rdata  ), // (u_core1_axi_rf) => ()
	.rid    (core1_axi_rf_rid    ), // (u_core1_axi_rf) => ()
	.rlast  (core1_axi_rf_rlast  ), // (u_core1_axi_rf) => ()
	.rready (core1_axi_rf_rready ), // (u_core1_axi_rf) <= ()
	.rresp  (core1_axi_rf_rresp  ), // (u_core1_axi_rf) => ()
	.rvalid (core1_axi_rf_rvalid ), // (u_core1_axi_rf) => ()
	.awaddr (core1_axi_rf_awaddr ), // (u_core1_axi_rf) <= ()
	.awburst(core1_axi_rf_awburst), // (u_core1_axi_rf) <= ()
	.awcache(core1_axi_rf_awcache), // (u_core1_axi_rf) <= ()
	.awid   (core1_axi_rf_awid   ), // (u_core1_axi_rf) <= ()
	.awlen  (core1_axi_rf_awlen  ), // (u_core1_axi_rf) <= ()
	.awlock (core1_axi_rf_awlock ), // (u_core1_axi_rf) <= ()
	.awprot (core1_axi_rf_awprot ), // (u_core1_axi_rf) <= ()
	.awready(core1_axi_rf_awready), // (u_core1_axi_rf) => ()
	.awsize (core1_axi_rf_awsize ), // (u_core1_axi_rf) <= ()
	.awvalid(core1_axi_rf_awvalid), // (u_core1_axi_rf) <= ()
	.bid    (core1_axi_rf_bid    ), // (u_core1_axi_rf) => ()
	.bready (core1_axi_rf_bready ), // (u_core1_axi_rf) <= ()
	.bresp  (core1_axi_rf_bresp  ), // (u_core1_axi_rf) => ()
	.bvalid (core1_axi_rf_bvalid ), // (u_core1_axi_rf) => ()
	.wdata  (core1_axi_rf_wdata  ), // (u_core1_axi_rf) <= ()
	.wlast  (core1_axi_rf_wlast  ), // (u_core1_axi_rf) <= ()
	.wready (core1_axi_rf_wready ), // (u_core1_axi_rf) => ()
	.wstrb  (core1_axi_rf_wstrb  ), // (u_core1_axi_rf) <= ()
	.wvalid (core1_axi_rf_wvalid )  // (u_core1_axi_rf) <= ()
); // end of u_core1_axi_rf

   `endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_PPI
`ifdef NDS_IO_PPI_PROT
nds_scpu_bus_ingress #(
	.ADDR_CODE_WIDTH (BIU_ADDR_CODE_WIDTH),
	.BIU_CTRL_CODE_WIDTH(BIU_CTRL_CODE_WIDTH),
	.DATA_CODE_WIDTH (PPI_DATA_CODE_WIDTH),
	.DATA_WIDTH      (PPI_DATA_WIDTH  ),
	.DS_ADDR_WIDTH   (ADDR_WIDTH      ),
	.ID_WIDTH        (PPI_ID_WIDTH    ),
	.US_ADDR_WIDTH   (BIU_ADDR_WIDTH  ),
	.UTID_WIDTH      (BIU_UTID_WIDTH  ),
	.WCTRL_CODE_WIDTH(5               )
) u_core0_ppi_ingress (
	.aclk               (aclk                               ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.aresetn            (aresetn                            ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.us_araddr          (core0_ppi_ingress_us_araddr        ), // (u_core0_ppi_ingress) <= ()
	.us_araddrcode      (core0_ppi_ingress_us_araddrcode    ), // (u_core0_ppi_ingress) <= ()
	.us_arburst         (core0_ppi_ingress_us_arburst       ), // (u_core0_ppi_ingress) <= ()
	.us_arcache         (core0_ppi_ingress_us_arcache       ), // (u_core0_ppi_ingress) <= ()
	.us_arctl0code      (core0_ppi_ingress_us_arctl0code    ), // (u_core0_ppi_ingress) <= ()
	.us_arctl1code      (core0_ppi_ingress_us_arctl1code    ), // (u_core0_ppi_ingress) <= ()
	.us_arid            (core0_ppi_ingress_us_arid          ), // (u_core0_ppi_ingress) <= ()
	.us_aridcode        (core0_ppi_ingress_us_aridcode      ), // (u_core0_ppi_ingress) <= ()
	.us_arlen           (core0_ppi_ingress_us_arlen         ), // (u_core0_ppi_ingress) <= ()
	.us_arlock          (core0_ppi_ingress_us_arlock        ), // (u_core0_ppi_ingress) <= ()
	.us_arprot          (core0_ppi_ingress_us_arprot        ), // (u_core0_ppi_ingress) <= ()
	.us_arready         (core0_ppi_ingress_us_arready       ), // (u_core0_ppi_ingress) => ()
	.us_arreadycode     (core0_ppi_ingress_us_arreadycode   ), // (u_core0_ppi_ingress) => ()
	.us_arsize          (core0_ppi_ingress_us_arsize        ), // (u_core0_ppi_ingress) <= ()
	.us_arutid          (core0_ppi_ingress_us_arutid        ), // (u_core0_ppi_ingress) <= ()
	.us_arvalid         (core0_ppi_ingress_us_arvalid       ), // (u_core0_ppi_ingress) <= ()
	.us_arvalidcode     (core0_ppi_ingress_us_arvalidcode   ), // (u_core0_ppi_ingress) <= ()
	.us_awaddr          (core0_ppi_ingress_us_awaddr        ), // (u_core0_ppi_ingress) <= ()
	.us_awaddrcode      (core0_ppi_ingress_us_awaddrcode    ), // (u_core0_ppi_ingress) <= ()
	.us_awburst         (core0_ppi_ingress_us_awburst       ), // (u_core0_ppi_ingress) <= ()
	.us_awcache         (core0_ppi_ingress_us_awcache       ), // (u_core0_ppi_ingress) <= ()
	.us_awctl0code      (core0_ppi_ingress_us_awctl0code    ), // (u_core0_ppi_ingress) <= ()
	.us_awctl1code      (core0_ppi_ingress_us_awctl1code    ), // (u_core0_ppi_ingress) <= ()
	.us_awid            (core0_ppi_ingress_us_awid          ), // (u_core0_ppi_ingress) <= ()
	.us_awidcode        (core0_ppi_ingress_us_awidcode      ), // (u_core0_ppi_ingress) <= ()
	.us_awlen           (core0_ppi_ingress_us_awlen         ), // (u_core0_ppi_ingress) <= ()
	.us_awlock          (core0_ppi_ingress_us_awlock        ), // (u_core0_ppi_ingress) <= ()
	.us_awprot          (core0_ppi_ingress_us_awprot        ), // (u_core0_ppi_ingress) <= ()
	.us_awready         (core0_ppi_ingress_us_awready       ), // (u_core0_ppi_ingress) => ()
	.us_awreadycode     (core0_ppi_ingress_us_awreadycode   ), // (u_core0_ppi_ingress) => ()
	.us_awsize          (core0_ppi_ingress_us_awsize        ), // (u_core0_ppi_ingress) <= ()
	.us_awutid          (core0_ppi_ingress_us_awutid        ), // (u_core0_ppi_ingress) <= ()
	.us_awvalid         (core0_ppi_ingress_us_awvalid       ), // (u_core0_ppi_ingress) <= ()
	.us_awvalidcode     (core0_ppi_ingress_us_awvalidcode   ), // (u_core0_ppi_ingress) <= ()
	.us_bctlcode        (core0_ppi_ingress_us_bctlcode      ), // (u_core0_ppi_ingress) => ()
	.us_bid             (core0_ppi_ingress_us_bid           ), // (u_core0_ppi_ingress) => ()
	.us_bidcode         (core0_ppi_ingress_us_bidcode       ), // (u_core0_ppi_ingress) => ()
	.us_bready          (core0_ppi_ingress_us_bready        ), // (u_core0_ppi_ingress) <= ()
	.us_breadycode      (core0_ppi_ingress_us_breadycode    ), // (u_core0_ppi_ingress) <= ()
	.us_bresp           (core0_ppi_ingress_us_bresp         ), // (u_core0_ppi_ingress) => ()
	.us_butid           (core0_ppi_ingress_us_butid         ), // (u_core0_ppi_ingress) => ()
	.us_bvalid          (core0_ppi_ingress_us_bvalid        ), // (u_core0_ppi_ingress) => ()
	.us_bvalidcode      (core0_ppi_ingress_us_bvalidcode    ), // (u_core0_ppi_ingress) => ()
	.us_rctlcode        (core0_ppi_ingress_us_rctlcode      ), // (u_core0_ppi_ingress) => ()
	.us_rdata           (core0_ppi_ingress_us_rdata         ), // (u_core0_ppi_ingress) => ()
	.us_rdatacode       (core0_ppi_ingress_us_rdatacode     ), // (u_core0_ppi_ingress) => ()
	.us_reobi           (core0_ppi_ingress_us_reobi         ), // (u_core0_ppi_ingress) => ()
	.us_rid             (core0_ppi_ingress_us_rid           ), // (u_core0_ppi_ingress) => ()
	.us_ridcode         (core0_ppi_ingress_us_ridcode       ), // (u_core0_ppi_ingress) => ()
	.us_rlast           (core0_ppi_ingress_us_rlast         ), // (u_core0_ppi_ingress) => ()
	.us_rresp           (core0_ppi_ingress_us_rresp         ), // (u_core0_ppi_ingress) => ()
	.us_rutid           (core0_ppi_ingress_us_rutid         ), // (u_core0_ppi_ingress) => ()
	.us_rvalid          (core0_ppi_ingress_us_rvalid        ), // (u_core0_ppi_ingress) => ()
	.us_rvalidcode      (core0_ppi_ingress_us_rvalidcode    ), // (u_core0_ppi_ingress) => ()
	.us_rready          (core0_ppi_ingress_us_rready        ), // (u_core0_ppi_ingress) <= ()
	.us_rreadycode      (core0_ppi_ingress_us_rreadycode    ), // (u_core0_ppi_ingress) <= ()
	.us_wctlcode        (core0_ppi_ingress_us_wctlcode      ), // (u_core0_ppi_ingress) <= ()
	.us_wdata           (core0_ppi_ingress_us_wdata         ), // (u_core0_ppi_ingress) <= ()
	.us_wdatacode       (core0_ppi_ingress_us_wdatacode     ), // (u_core0_ppi_ingress) <= ()
	.us_weobi           (core0_ppi_ingress_us_weobi         ), // (u_core0_ppi_ingress) <= ()
	.us_wlast           (core0_ppi_ingress_us_wlast         ), // (u_core0_ppi_ingress) <= ()
	.us_wstrb           (core0_ppi_ingress_us_wstrb         ), // (u_core0_ppi_ingress) <= ()
	.us_wutid           (core0_ppi_ingress_us_wutid         ), // (u_core0_ppi_ingress) <= ()
	.us_wvalid          (core0_ppi_ingress_us_wvalid        ), // (u_core0_ppi_ingress) <= ()
	.us_wvalidcode      (core0_ppi_ingress_us_wvalidcode    ), // (u_core0_ppi_ingress) <= ()
	.us_wready          (core0_ppi_ingress_us_wready        ), // (u_core0_ppi_ingress) => ()
	.us_wreadycode      (core0_ppi_ingress_us_wreadycode    ), // (u_core0_ppi_ingress) => ()
	.ds_araddr          (core0_ppi_ingress_ds_araddr        ), // (u_core0_ppi_ingress) => ()
	.ds_arburst         (core0_ppi_ingress_ds_arburst       ), // (u_core0_ppi_ingress) => ()
	.ds_arcache         (core0_ppi_ingress_ds_arcache       ), // (u_core0_ppi_ingress) => ()
	.ds_arid            (core0_ppi_ingress_ds_arid          ), // (u_core0_ppi_ingress) => ()
	.ds_arlen           (core0_ppi_ingress_ds_arlen         ), // (u_core0_ppi_ingress) => ()
	.ds_arlock          (core0_ppi_ingress_ds_arlock        ), // (u_core0_ppi_ingress) => ()
	.ds_arprot          (core0_ppi_ingress_ds_arprot        ), // (u_core0_ppi_ingress) => ()
	.ds_arsize          (core0_ppi_ingress_ds_arsize        ), // (u_core0_ppi_ingress) => ()
	.ds_arvalid         (core0_ppi_ingress_ds_arvalid       ), // (u_core0_ppi_ingress) => ()
	.ds_arready         (core0_ppi_ingress_ds_arready       ), // (u_core0_ppi_ingress) <= ()
	.ds_awaddr          (core0_ppi_ingress_ds_awaddr        ), // (u_core0_ppi_ingress) => ()
	.ds_awburst         (core0_ppi_ingress_ds_awburst       ), // (u_core0_ppi_ingress) => ()
	.ds_awcache         (core0_ppi_ingress_ds_awcache       ), // (u_core0_ppi_ingress) => ()
	.ds_awid            (core0_ppi_ingress_ds_awid          ), // (u_core0_ppi_ingress) => ()
	.ds_awlen           (core0_ppi_ingress_ds_awlen         ), // (u_core0_ppi_ingress) => ()
	.ds_awlock          (core0_ppi_ingress_ds_awlock        ), // (u_core0_ppi_ingress) => ()
	.ds_awprot          (core0_ppi_ingress_ds_awprot        ), // (u_core0_ppi_ingress) => ()
	.ds_awready         (core0_ppi_ingress_ds_awready       ), // (u_core0_ppi_ingress) <= ()
	.ds_awsize          (core0_ppi_ingress_ds_awsize        ), // (u_core0_ppi_ingress) => ()
	.ds_awvalid         (core0_ppi_ingress_ds_awvalid       ), // (u_core0_ppi_ingress) => ()
	.ds_bid             (core0_ppi_ingress_ds_bid           ), // (u_core0_ppi_ingress) <= ()
	.ds_bready          (core0_ppi_ingress_ds_bready        ), // (u_core0_ppi_ingress) => ()
	.ds_bresp           (core0_ppi_ingress_ds_bresp         ), // (u_core0_ppi_ingress) <= ()
	.ds_bvalid          (core0_ppi_ingress_ds_bvalid        ), // (u_core0_ppi_ingress) <= ()
	.ds_rdata           (core0_ppi_ingress_ds_rdata         ), // (u_core0_ppi_ingress) <= ()
	.ds_rid             (core0_ppi_ingress_ds_rid           ), // (u_core0_ppi_ingress) <= ()
	.ds_rlast           (core0_ppi_ingress_ds_rlast         ), // (u_core0_ppi_ingress) <= ()
	.ds_rready          (core0_ppi_ingress_ds_rready        ), // (u_core0_ppi_ingress) => ()
	.ds_rresp           (core0_ppi_ingress_ds_rresp         ), // (u_core0_ppi_ingress) <= ()
	.ds_rvalid          (core0_ppi_ingress_ds_rvalid        ), // (u_core0_ppi_ingress) <= ()
	.ds_wdata           (core0_ppi_ingress_ds_wdata         ), // (u_core0_ppi_ingress) => ()
	.ds_wlast           (core0_ppi_ingress_ds_wlast         ), // (u_core0_ppi_ingress) => ()
	.ds_wready          (core0_ppi_ingress_ds_wready        ), // (u_core0_ppi_ingress) <= ()
	.ds_wstrb           (core0_ppi_ingress_ds_wstrb         ), // (u_core0_ppi_ingress) => ()
	.ds_wvalid          (core0_ppi_ingress_ds_wvalid        ), // (u_core0_ppi_ingress) => ()
	.event_handshake_err(nds_unused_ppi0_event_handshake_err), // (u_core0_ppi_ingress) => ()
	.event_eobi_err     (nds_unused_ppi0_event_eobi_err     ), // (u_core0_ppi_ingress) => ()
	.event_data_err     (nds_unused_ppi0_event_data_err     ), // (u_core0_ppi_ingress) => ()
	.event_ctl_err      (nds_unused_ppi0_event_ctl_err      )  // (u_core0_ppi_ingress) => ()
); // end of u_core0_ppi_ingress

   `ifdef NDS_IO_DCLS_SPLIT
nds_scpu_bus_ingress #(
	.ADDR_CODE_WIDTH (BIU_ADDR_CODE_WIDTH),
	.BIU_CTRL_CODE_WIDTH(BIU_CTRL_CODE_WIDTH),
	.DATA_CODE_WIDTH (PPI_DATA_CODE_WIDTH),
	.DATA_WIDTH      (PPI_DATA_WIDTH  ),
	.DS_ADDR_WIDTH   (ADDR_WIDTH      ),
	.ID_WIDTH        (PPI_ID_WIDTH    ),
	.US_ADDR_WIDTH   (BIU_ADDR_WIDTH  ),
	.UTID_WIDTH      (BIU_UTID_WIDTH  ),
	.WCTRL_CODE_WIDTH(5               )
) u_core1_ppi_ingress (
	.aclk               (aclk                               ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.aresetn            (aresetn                            ), // (u_atcexmon300,u_axi_bmc,u_axi_busdec,u_axi_dm_sup,u_axi_sdn,u_core0_axi_rf,u_core0_ppi_ingress,u_core1_axi_rf,u_core1_ppi_ingress,u_flash0_ingress,u_pldm,u_plic,u_plic_sw,u_plmt,u_slvp_busdec,u_spp_ingress,u_sys0_ingress) <= ()
	.us_araddr          (core1_ppi_ingress_us_araddr        ), // (u_core1_ppi_ingress) <= ()
	.us_araddrcode      (core1_ppi_ingress_us_araddrcode    ), // (u_core1_ppi_ingress) <= ()
	.us_arburst         (core1_ppi_ingress_us_arburst       ), // (u_core1_ppi_ingress) <= ()
	.us_arcache         (core1_ppi_ingress_us_arcache       ), // (u_core1_ppi_ingress) <= ()
	.us_arctl0code      (core1_ppi_ingress_us_arctl0code    ), // (u_core1_ppi_ingress) <= ()
	.us_arctl1code      (core1_ppi_ingress_us_arctl1code    ), // (u_core1_ppi_ingress) <= ()
	.us_arid            (core1_ppi_ingress_us_arid          ), // (u_core1_ppi_ingress) <= ()
	.us_aridcode        (core1_ppi_ingress_us_aridcode      ), // (u_core1_ppi_ingress) <= ()
	.us_arlen           (core1_ppi_ingress_us_arlen         ), // (u_core1_ppi_ingress) <= ()
	.us_arlock          (core1_ppi_ingress_us_arlock        ), // (u_core1_ppi_ingress) <= ()
	.us_arprot          (core1_ppi_ingress_us_arprot        ), // (u_core1_ppi_ingress) <= ()
	.us_arready         (core1_ppi_ingress_us_arready       ), // (u_core1_ppi_ingress) => ()
	.us_arreadycode     (core1_ppi_ingress_us_arreadycode   ), // (u_core1_ppi_ingress) => ()
	.us_arsize          (core1_ppi_ingress_us_arsize        ), // (u_core1_ppi_ingress) <= ()
	.us_arutid          (core1_ppi_ingress_us_arutid        ), // (u_core1_ppi_ingress) <= ()
	.us_arvalid         (core1_ppi_ingress_us_arvalid       ), // (u_core1_ppi_ingress) <= ()
	.us_arvalidcode     (core1_ppi_ingress_us_arvalidcode   ), // (u_core1_ppi_ingress) <= ()
	.us_awaddr          (core1_ppi_ingress_us_awaddr        ), // (u_core1_ppi_ingress) <= ()
	.us_awaddrcode      (core1_ppi_ingress_us_awaddrcode    ), // (u_core1_ppi_ingress) <= ()
	.us_awburst         (core1_ppi_ingress_us_awburst       ), // (u_core1_ppi_ingress) <= ()
	.us_awcache         (core1_ppi_ingress_us_awcache       ), // (u_core1_ppi_ingress) <= ()
	.us_awctl0code      (core1_ppi_ingress_us_awctl0code    ), // (u_core1_ppi_ingress) <= ()
	.us_awctl1code      (core1_ppi_ingress_us_awctl1code    ), // (u_core1_ppi_ingress) <= ()
	.us_awid            (core1_ppi_ingress_us_awid          ), // (u_core1_ppi_ingress) <= ()
	.us_awidcode        (core1_ppi_ingress_us_awidcode      ), // (u_core1_ppi_ingress) <= ()
	.us_awlen           (core1_ppi_ingress_us_awlen         ), // (u_core1_ppi_ingress) <= ()
	.us_awlock          (core1_ppi_ingress_us_awlock        ), // (u_core1_ppi_ingress) <= ()
	.us_awprot          (core1_ppi_ingress_us_awprot        ), // (u_core1_ppi_ingress) <= ()
	.us_awready         (core1_ppi_ingress_us_awready       ), // (u_core1_ppi_ingress) => ()
	.us_awreadycode     (core1_ppi_ingress_us_awreadycode   ), // (u_core1_ppi_ingress) => ()
	.us_awsize          (core1_ppi_ingress_us_awsize        ), // (u_core1_ppi_ingress) <= ()
	.us_awutid          (core1_ppi_ingress_us_awutid        ), // (u_core1_ppi_ingress) <= ()
	.us_awvalid         (core1_ppi_ingress_us_awvalid       ), // (u_core1_ppi_ingress) <= ()
	.us_awvalidcode     (core1_ppi_ingress_us_awvalidcode   ), // (u_core1_ppi_ingress) <= ()
	.us_bctlcode        (core1_ppi_ingress_us_bctlcode      ), // (u_core1_ppi_ingress) => ()
	.us_bid             (core1_ppi_ingress_us_bid           ), // (u_core1_ppi_ingress) => ()
	.us_bidcode         (core1_ppi_ingress_us_bidcode       ), // (u_core1_ppi_ingress) => ()
	.us_bready          (core1_ppi_ingress_us_bready        ), // (u_core1_ppi_ingress) <= ()
	.us_breadycode      (core1_ppi_ingress_us_breadycode    ), // (u_core1_ppi_ingress) <= ()
	.us_bresp           (core1_ppi_ingress_us_bresp         ), // (u_core1_ppi_ingress) => ()
	.us_butid           (core1_ppi_ingress_us_butid         ), // (u_core1_ppi_ingress) => ()
	.us_bvalid          (core1_ppi_ingress_us_bvalid        ), // (u_core1_ppi_ingress) => ()
	.us_bvalidcode      (core1_ppi_ingress_us_bvalidcode    ), // (u_core1_ppi_ingress) => ()
	.us_rctlcode        (core1_ppi_ingress_us_rctlcode      ), // (u_core1_ppi_ingress) => ()
	.us_rdata           (core1_ppi_ingress_us_rdata         ), // (u_core1_ppi_ingress) => ()
	.us_rdatacode       (core1_ppi_ingress_us_rdatacode     ), // (u_core1_ppi_ingress) => ()
	.us_reobi           (core1_ppi_ingress_us_reobi         ), // (u_core1_ppi_ingress) => ()
	.us_rid             (core1_ppi_ingress_us_rid           ), // (u_core1_ppi_ingress) => ()
	.us_ridcode         (core1_ppi_ingress_us_ridcode       ), // (u_core1_ppi_ingress) => ()
	.us_rlast           (core1_ppi_ingress_us_rlast         ), // (u_core1_ppi_ingress) => ()
	.us_rresp           (core1_ppi_ingress_us_rresp         ), // (u_core1_ppi_ingress) => ()
	.us_rutid           (core1_ppi_ingress_us_rutid         ), // (u_core1_ppi_ingress) => ()
	.us_rvalid          (core1_ppi_ingress_us_rvalid        ), // (u_core1_ppi_ingress) => ()
	.us_rvalidcode      (core1_ppi_ingress_us_rvalidcode    ), // (u_core1_ppi_ingress) => ()
	.us_rready          (core1_ppi_ingress_us_rready        ), // (u_core1_ppi_ingress) <= ()
	.us_rreadycode      (core1_ppi_ingress_us_rreadycode    ), // (u_core1_ppi_ingress) <= ()
	.us_wctlcode        (core1_ppi_ingress_us_wctlcode      ), // (u_core1_ppi_ingress) <= ()
	.us_wdata           (core1_ppi_ingress_us_wdata         ), // (u_core1_ppi_ingress) <= ()
	.us_wdatacode       (core1_ppi_ingress_us_wdatacode     ), // (u_core1_ppi_ingress) <= ()
	.us_weobi           (core1_ppi_ingress_us_weobi         ), // (u_core1_ppi_ingress) <= ()
	.us_wlast           (core1_ppi_ingress_us_wlast         ), // (u_core1_ppi_ingress) <= ()
	.us_wstrb           (core1_ppi_ingress_us_wstrb         ), // (u_core1_ppi_ingress) <= ()
	.us_wutid           (core1_ppi_ingress_us_wutid         ), // (u_core1_ppi_ingress) <= ()
	.us_wvalid          (core1_ppi_ingress_us_wvalid        ), // (u_core1_ppi_ingress) <= ()
	.us_wvalidcode      (core1_ppi_ingress_us_wvalidcode    ), // (u_core1_ppi_ingress) <= ()
	.us_wready          (core1_ppi_ingress_us_wready        ), // (u_core1_ppi_ingress) => ()
	.us_wreadycode      (core1_ppi_ingress_us_wreadycode    ), // (u_core1_ppi_ingress) => ()
	.ds_araddr          (core1_ppi_ingress_ds_araddr        ), // (u_core1_ppi_ingress) => ()
	.ds_arburst         (core1_ppi_ingress_ds_arburst       ), // (u_core1_ppi_ingress) => ()
	.ds_arcache         (core1_ppi_ingress_ds_arcache       ), // (u_core1_ppi_ingress) => ()
	.ds_arid            (core1_ppi_ingress_ds_arid          ), // (u_core1_ppi_ingress) => ()
	.ds_arlen           (core1_ppi_ingress_ds_arlen         ), // (u_core1_ppi_ingress) => ()
	.ds_arlock          (core1_ppi_ingress_ds_arlock        ), // (u_core1_ppi_ingress) => ()
	.ds_arprot          (core1_ppi_ingress_ds_arprot        ), // (u_core1_ppi_ingress) => ()
	.ds_arsize          (core1_ppi_ingress_ds_arsize        ), // (u_core1_ppi_ingress) => ()
	.ds_arvalid         (core1_ppi_ingress_ds_arvalid       ), // (u_core1_ppi_ingress) => ()
	.ds_arready         (core1_ppi_ingress_ds_arready       ), // (u_core1_ppi_ingress) <= ()
	.ds_awaddr          (core1_ppi_ingress_ds_awaddr        ), // (u_core1_ppi_ingress) => ()
	.ds_awburst         (core1_ppi_ingress_ds_awburst       ), // (u_core1_ppi_ingress) => ()
	.ds_awcache         (core1_ppi_ingress_ds_awcache       ), // (u_core1_ppi_ingress) => ()
	.ds_awid            (core1_ppi_ingress_ds_awid          ), // (u_core1_ppi_ingress) => ()
	.ds_awlen           (core1_ppi_ingress_ds_awlen         ), // (u_core1_ppi_ingress) => ()
	.ds_awlock          (core1_ppi_ingress_ds_awlock        ), // (u_core1_ppi_ingress) => ()
	.ds_awprot          (core1_ppi_ingress_ds_awprot        ), // (u_core1_ppi_ingress) => ()
	.ds_awready         (core1_ppi_ingress_ds_awready       ), // (u_core1_ppi_ingress) <= ()
	.ds_awsize          (core1_ppi_ingress_ds_awsize        ), // (u_core1_ppi_ingress) => ()
	.ds_awvalid         (core1_ppi_ingress_ds_awvalid       ), // (u_core1_ppi_ingress) => ()
	.ds_bid             (core1_ppi_ingress_ds_bid           ), // (u_core1_ppi_ingress) <= ()
	.ds_bready          (core1_ppi_ingress_ds_bready        ), // (u_core1_ppi_ingress) => ()
	.ds_bresp           (core1_ppi_ingress_ds_bresp         ), // (u_core1_ppi_ingress) <= ()
	.ds_bvalid          (core1_ppi_ingress_ds_bvalid        ), // (u_core1_ppi_ingress) <= ()
	.ds_rdata           (core1_ppi_ingress_ds_rdata         ), // (u_core1_ppi_ingress) <= ()
	.ds_rid             (core1_ppi_ingress_ds_rid           ), // (u_core1_ppi_ingress) <= ()
	.ds_rlast           (core1_ppi_ingress_ds_rlast         ), // (u_core1_ppi_ingress) <= ()
	.ds_rready          (core1_ppi_ingress_ds_rready        ), // (u_core1_ppi_ingress) => ()
	.ds_rresp           (core1_ppi_ingress_ds_rresp         ), // (u_core1_ppi_ingress) <= ()
	.ds_rvalid          (core1_ppi_ingress_ds_rvalid        ), // (u_core1_ppi_ingress) <= ()
	.ds_wdata           (core1_ppi_ingress_ds_wdata         ), // (u_core1_ppi_ingress) => ()
	.ds_wlast           (core1_ppi_ingress_ds_wlast         ), // (u_core1_ppi_ingress) => ()
	.ds_wready          (core1_ppi_ingress_ds_wready        ), // (u_core1_ppi_ingress) <= ()
	.ds_wstrb           (core1_ppi_ingress_ds_wstrb         ), // (u_core1_ppi_ingress) => ()
	.ds_wvalid          (core1_ppi_ingress_ds_wvalid        ), // (u_core1_ppi_ingress) => ()
	.event_handshake_err(nds_unused_ppi1_event_handshake_err), // (u_core1_ppi_ingress) => ()
	.event_eobi_err     (nds_unused_ppi1_event_eobi_err     ), // (u_core1_ppi_ingress) => ()
	.event_data_err     (nds_unused_ppi1_event_data_err     ), // (u_core1_ppi_ingress) => ()
	.event_ctl_err      (nds_unused_ppi1_event_ctl_err      )  // (u_core1_ppi_ingress) => ()
); // end of u_core1_ppi_ingress

   `endif // NDS_IO_DCLS_SPLIT
`endif // NDS_IO_PPI_PROT
endmodule
// VPERL_GENERATED_END
//
