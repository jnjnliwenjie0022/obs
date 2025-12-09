`include "ae350_config.vh"
`include "ae350_const.vh"

`include "atcapbbrg100_config.vh"
`include "atcapbbrg100_const.vh"

// VPERL_BEGIN
// &MODULE("ae350_aopd");
// 
//&IFDEF("NDS_NHART");
//	&LOCALPARAM("NHART                    = `NDS_NHART");
//&ELSE("NDS_NHART");
//	&LOCALPARAM("NHART                    = 1");
//&ENDIF("NDS_NHART");
//
// &IFDEF("ATCAPBBRG100_SLV_14");
//   &IFDEF("AE350_DTROM_SIZE_KB");
//     &LOCALPARAM("DTROM_SIZE_KB = `AE350_DTROM_SIZE_KB");
//   &ELSE("AE350_DTROM_SIZE_KB");
//     &LOCALPARAM("DTROM_SIZE_KB = 8");
//   &ENDIF("AE350_DTROM_SIZE_KB");
// &ENDIF("ATCAPBBRG100_SLV_14");
// &IFDEF("NDS_L2C_BIU_DATA_WIDTH");
//  &LOCALPARAM("L2C_BIU_DATA_WIDTH	= `NDS_L2C_BIU_DATA_WIDTH");
// &ELSE("NDS_L2C_BIU_DATA_WIDTH");
//  &LOCALPARAM("L2C_BIU_DATA_WIDTH	= 64");
// &ENDIF("NDS_L2C_BIU_DATA_WIDTH");
//
// &IFDEF("PLATFORM_JTAG_TWOWIRE");
//      &LOCALPARAM("DEBUG_INTERFACE        = \"serial\"");
// &ELSE("PLATFORM_JTAG_TWOWIRE");
//      &LOCALPARAM("DEBUG_INTERFACE        = \"jtag\"");
// &ENDIF("PLATFORM_JTAG_TWOWIRE");
// &IFDEF("PLATFORM_JTAG_TAP_NUM");
//      &LOCALPARAM("JTAG_TAP_NUM           = `PLATFORM_JTAG_TAP_NUM");
// &ELSE ("PLATFORM_JTAG_TAP_NUM");
//      &LOCALPARAM("JTAG_TAP_NUM           = 1");
// &ENDIF("PLATFORM_JTAG_TAP_NUM");
// &IFDEF("PLATFORM_DM_TAP_ID");
//      &LOCALPARAM("DM_TAP_ID              = `PLATFORM_DM_TAP_ID");
// &ELSE ("PLATFORM_DM_TAP_ID");
//      &LOCALPARAM("DM_TAP_ID              = 0");
// &ENDIF("PLATFORM_DM_TAP_ID");
//
// &PARAM("SYNC_STAGE = 2");
//
// #    NDS_MULTI_JTAG_DEVICE connects a N8 core to TAP#1 
// #    To enable this feature, user should
// #            - Check file lists (especially for RAMs)
// #            - Make sure PLATFORM_JTAG_TAP_NUM ls larger than 2
// #            - Make sure JTAG_DEVICE_TAP_ID != DM_TAP_ID
// #            - Only support EILM/EDLM for FPGA in n8_core_top_N8
// #            - To change JTAG_DEVICE_TAP_ID, it should also be set to ae350_tb
// &IFDEF("NDS_MULTI_JTAG_DEVICE");
//      &LOCALPARAM("JTAG_DEVICE_TAP_ID     = 1");
// &ENDIF("NDS_MULTI_JTAG_DEVICE");
//
// #------------------------------------------------------------------------------
// # Output for Power Control 
// #------------------------------------------------------------------------------
// &FORCE("output", "pcs0_iso");
// &FORCE("output", "pcs1_iso");
// &FORCE("output", "pcs2_iso");
// &FORCE("output", "pcs3_iso");
// &FORCE("output", "pcs4_iso");
// &FORCE("output", "pcs5_iso");
// &FORCE("output", "pcs6_iso");
// &FORCE("output", "pd0_vol_on");
// &FORCE("output", "pd1_vol_on");
// &FORCE("output", "pd2_vol_on");
// &FORCE("output", "pd3_vol_on");
// &FORCE("output", "pd4_vol_on");
// &FORCE("output", "pd5_vol_on");
// &FORCE("output", "pd6_vol_on");
//
// &IFDEF("NDS_NHART");
// &IFDEF("NDS_IO_L2C");
//	&FORCE("output", "core0_wfi_sel_iso_sync");
//	&FORCE("output", "core1_wfi_sel_iso_sync");
//	&FORCE("output", "core2_wfi_sel_iso_sync");
//	&FORCE("output", "core3_wfi_sel_iso_sync");
//	&INSTANCE("$PVC_LOCALDIR/andes_ip/macro/nds_sync_l2l.v", "nds_sync_core0_wfi_iso", {
//	        RESET_VALUE => "1'b0",
//	        SYNC_STAGE  => "SYNC_STAGE",
//	});
//	&CONNECT("nds_sync_core0_wfi_iso", {
//		b_reset_n			=> "por_b_psync",
//		b_clk				=> "root_clk",
//		a_signal			=> "pcs3_iso",
//		b_signal			=> "core0_wfi_sel_iso_sync",
//		b_signal_rising_edge_pulse	=> "",
//		b_signal_falling_edge_pulse	=> "",
//		b_signal_edge_pulse		=> "",
//	});
//	&INSTANCE("$PVC_LOCALDIR/andes_ip/macro/nds_sync_l2l.v", "nds_sync_core1_wfi_iso", {
//	        RESET_VALUE => "1'b0",
//	        SYNC_STAGE  => "SYNC_STAGE",
//	});
//	&CONNECT("nds_sync_core1_wfi_iso", {
//		b_reset_n			=> "por_b_psync",
//		b_clk				=> "root_clk",
//		a_signal			=> "pcs4_iso",
//		b_signal			=> "core1_wfi_sel_iso_sync",
//		b_signal_rising_edge_pulse	=> "",
//		b_signal_falling_edge_pulse	=> "",
//		b_signal_edge_pulse		=> "",
//	});
//	&INSTANCE("$PVC_LOCALDIR/andes_ip/macro/nds_sync_l2l.v", "nds_sync_core2_wfi_iso", {
//	        RESET_VALUE => "1'b0",
//	        SYNC_STAGE  => "SYNC_STAGE",
//	});
//	&CONNECT("nds_sync_core2_wfi_iso", {
//		b_reset_n			=> "por_b_psync",
//		b_clk				=> "root_clk",
//		a_signal			=> "pcs5_iso",
//		b_signal			=> "core2_wfi_sel_iso_sync",
//		b_signal_rising_edge_pulse	=> "",
//		b_signal_falling_edge_pulse	=> "",
//		b_signal_edge_pulse		=> "",
//	});
//	&INSTANCE("$PVC_LOCALDIR/andes_ip/macro/nds_sync_l2l.v", "nds_sync_core3_wfi_iso", {
//	        RESET_VALUE => "1'b0",
//	        SYNC_STAGE  => "SYNC_STAGE",
//	});
//	&CONNECT("nds_sync_core3_wfi_iso", {
//		b_reset_n			=> "por_b_psync",
//		b_clk				=> "root_clk",
//		a_signal			=> "pcs6_iso",
//		b_signal			=> "core3_wfi_sel_iso_sync",
//		b_signal_rising_edge_pulse	=> "",
//		b_signal_falling_edge_pulse	=> "",
//		b_signal_edge_pulse		=> "",
//	});
// &ENDIF("NDS_IO_L2C");
// &ENDIF("NDS_NHART");
//
// #------------------------------------------------------------------------------
// # APB slave interface for SMU and RTC
// #------------------------------------------------------------------------------
// &FORCE("input", "paddr[`ATCAPBBRG100_ADDR_MSB:0]");
// &IFDEF("AE350_RTC_SUPPORT");
//      &FORCE("output", "rtc_pready");
//      &FORCE("output", "rtc_pslverr");
// &ENDIF("AE350_RTC_SUPPORT");
// #------------------------------------------------------------------------------
// # APB slave SMU 
// #------------------------------------------------------------------------------
// &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcsmu100/hdl/atcsmu100.v", "ae350_smu");
// &CONNECT("ae350_smu.pclk",    "aopd_pclk");
// &CONNECT("ae350_smu.presetn", "aopd_por_dbg_rstn");
// &CONNECT("ae350_smu.psel",    "smu_psel" );
// &CONNECT("ae350_smu.prdata",  "smu_prdata" );
// &CONNECT("ae350_smu.pready",  "smu_pready" );
// &CONNECT("ae350_smu.pslverr", "smu_pslverr");
// &IFDEF("NDS_BOARD_CF1");
//   &CONNECT("ae350_smu.paddr",   "paddr[12:2]" );
// &ELSE("NDS_BOARD_CF1");
//   &CONNECT("ae350_smu.paddr",   "paddr[9:2]" );
// &ENDIF("NDS_BOARD_CF1");
// &CONNECT("ae350_smu.pwrite",  "pwrite" );
// &CONNECT("ae350_smu.pwdata",  "pwdata" );
// &CONNECT("ae350_smu.penable", "penable");
//
// &FORCE("wire", "mpd_por_rstn");
// :assign mpd_por_rstn = por_b_psync;
//
// &FORCE("wire", "extclk");
// :assign extclk   = clk_32k;
// 
// for ($i=0; $i<7; $i++) {
//	&FORCE("wire", "pcs${i}_int");
//	&FORCE("wire", "pcs${i}_mem_init");
//	&FORCE("wire", "pcs${i}_standby_ok");
//	&FORCE("wire", "pcs${i}_standby_req");
//	&FORCE("wire", "pcs${i}_wakeup");
//	&FORCE("wire", "pcs${i}_wakeup_event");
// }
//
// &FORCE("wire", "core_clk[(NHART-1):0]");
// &FORCE("output", "core_resetn[(NHART-1):0]");
//
// &IFDEF("NDS_NHART");
//  	&IFDEF("NDS_IO_L2C");
//		# &FORCE("input", "l2c_pcs_standby_req");  
// 		&FORCE("output", "pcs_core0_sleep_req");  
// 		&FORCE("output", "pcs_core1_sleep_req");  
// 		&FORCE("output", "pcs_core2_sleep_req");  
// 		&FORCE("output", "pcs_core3_sleep_req");  
// 		&FORCE("input",	"pcs_core0_sleep_ok");  
// 		&FORCE("input",	"pcs_core1_sleep_ok");  
// 		&FORCE("input",	"pcs_core2_sleep_ok");  
// 		&FORCE("input",	"pcs_core3_sleep_ok");  
// 	&ENDIF("NDS_IO_L2C");
// &ENDIF("NDS_NHART");
//
// &FORCE("input",  "hart0_core_wfi_mode");
// &FORCE("output", "hart0_icache_disable_init");
// &FORCE("output", "hart0_dcache_disable_init");
// &FORCE("wire",   "hart0_standby_ok");
// &IFDEF("NDS_NHART");
//	&IFDEF("NDS_IO_HART1");
//		&FORCE("input",  "hart1_core_wfi_mode");
//		&FORCE("output", "hart1_icache_disable_init");
//		&FORCE("output", "hart1_dcache_disable_init");
//		&FORCE("wire",   "hart1_standby_ok");
//	&ENDIF("NDS_IO_HART1");
//	&IFDEF("NDS_IO_HART2");
//		&FORCE("input",  "hart2_core_wfi_mode");
//		&FORCE("output", "hart2_icache_disable_init");
//		&FORCE("output", "hart2_dcache_disable_init");
//		&FORCE("wire",	 "hart2_standby_ok");
//	&ENDIF("NDS_IO_HART2");
//	&IFDEF("NDS_IO_HART3");
//		&FORCE("input",  "hart3_core_wfi_mode");
//		&FORCE("output", "hart3_icache_disable_init");
//		&FORCE("output", "hart3_dcache_disable_init");
//		&FORCE("wire",   "hart3_standby_ok");
//	&ENDIF("NDS_IO_HART3");
// &ENDIF("NDS_NHART");
//
// :assign pcs0_standby_ok = 1'b1;
// :assign pcs1_standby_ok = 1'b1;
// :assign pcs2_standby_ok = 1'b1;
// :assign pcs0_wakeup_event = pcs_wakeup_event_general;
// :assign pcs1_wakeup_event = pcs_wakeup_event_general;
// :assign pcs2_wakeup_event = pcs_wakeup_event_general;
//
// :assign hart0_icache_disable_init = ~pcs3_mem_init[0];
// :assign hart0_dcache_disable_init = ~pcs3_mem_init[1];
//
// :`ifdef NDS_NHART
// :	`ifdef NDS_IO_L2C
// :			assign pcs_core0_sleep_req = pcs3_standby_req;
// :			assign pcs_core1_sleep_req = pcs4_standby_req;
// :			assign pcs_core2_sleep_req = pcs5_standby_req;
// :			assign pcs_core3_sleep_req = pcs6_standby_req;
// :			assign hart0_standby_ok    = pcs_core0_sleep_ok;
// :			`ifdef NDS_IO_HART1
// :				assign hart1_standby_ok    = pcs_core1_sleep_ok;
// :			`endif
// :			`ifdef NDS_IO_HART2
// :				assign hart2_standby_ok    = pcs_core2_sleep_ok;
// :			`endif
// :			`ifdef NDS_IO_HART3
// :				assign hart3_standby_ok    = pcs_core3_sleep_ok;
// :			`endif
// :	`endif	// NDS_IO_L2C
// :`else // !NDS_NHART
// :	assign hart0_standby_ok = hart0_core_wfi_mode;
// :`endif // NDS_NHART
// :
// : assign pcs3_standby_ok = hart0_standby_ok;
//
// :`ifdef NDS_NHART
// :	`ifdef NDS_IO_HART1
// :		assign hart1_icache_disable_init = ~pcs4_mem_init[0];
// :		assign hart1_dcache_disable_init = ~pcs4_mem_init[1];
// :		assign pcs4_standby_ok           = hart1_standby_ok;
// :	`else 
// :		assign pcs4_standby_ok		 = 1'b1;
// :	`endif // NDS_IO_HART1
// :	`ifdef NDS_IO_HART2
// :		assign hart2_icache_disable_init = ~pcs5_mem_init[0];
// :		assign hart2_dcache_disable_init = ~pcs5_mem_init[1];
// :		assign pcs5_standby_ok           = hart2_standby_ok;
// :	`else 
// :		assign pcs5_standby_ok		 = 1'b1;
// :	`endif // NDS_IO_HART2
// :	`ifdef NDS_IO_HART3
// :		assign hart3_icache_disable_init = ~pcs6_mem_init[0];
// :		assign hart3_dcache_disable_init = ~pcs6_mem_init[1];
// :		assign pcs6_standby_ok           = hart3_standby_ok;
// :	`else 
// :		assign pcs6_standby_ok		 = 1'b1;
// :	`endif //NDS_IO_HART3
// :`else 
// :		assign pcs4_standby_ok		 = 1'b1;
// :		assign pcs5_standby_ok		 = 1'b1;
// :		assign pcs6_standby_ok		 = 1'b1;
// :`endif // NDS_NHART
//
// #-----------------------------------------------------------------------------
// # Interrupts
// #-----------------------------------------------------------------------------
//  
// #------ ext_int define     -----#
// &IFDEF("AE350_RTC_SUPPORT")
//      &FORCE("input", "rtc_int_period");
//      &FORCE("wire",  "rtc_int_alarm");
// &ENDIF("AE350_RTC_SUPPORT")
// &FORCE("input", "pit_intr");
// &FORCE("input", "spi1_int");
// &FORCE("input", "spi2_int");
// &FORCE("input", "i2c_int");
// &FORCE("input", "gpio_intr");
// &FORCE("input", "uart1_int");
// &FORCE("input", "uart2_int");
// &FORCE("input", "dma_int");
// &IFDEF("AE350_AHB_SUPPORT");
//	&FORCE("input",   "bmc_intr");
// &ENDIF("AE350_AHB_SUPPORT");
// &FORCE("input", "wdt_int");
// &IFDEF("NDS_NHART");
// 	&IFDEF("NDS_IO_L2C");
//		&FORCE("input",   "l2c_err_int");
// 	&ENDIF("NDS_IO_L2C");
// &ENDIF("NDS_NHART");
// &FORCE("input", "ssp_intr");
// &FORCE("input", "sdc_int");
// &FORCE("input", "mac_int");
// &FORCE("input", "lcd_intr");
//
// # CF1
// for ($i = 0; $i < 4; $i++) {
//   $j = 2 + $i;
//   &FORCE("input", "pit${j}_int");
// }
// &FORCE("input", "spi3_int");
// &FORCE("input", "spi4_int");
// &FORCE("input", "i2c2_int");
// &FORCE("input", "pit2_int");
// &FORCE("input", "pit3_int");
// &FORCE("input", "pit4_int");
// &FORCE("input", "pit5_int");
//
//
// &IFDEF("NDS_BOARD_CF1");
//   &FORCE("output", "int_src[32:1]");
// &ELSE("NDS_BOARD_CF1");
//   &FORCE("output", "int_src[31:1]");
// &ENDIF("NDS_BOARD_CF1");
// #------ ext_int 18 control -----#
// : `ifdef AE350_RTC_SUPPORT
// :    assign int_src[1]  =  rtc_int_period;
// :    assign int_src[2]  =  rtc_int_alarm;
// : `else
// :    assign int_src[1]  =  1'b0;
// :    assign int_src[2]  =  1'b0;
// : `endif //AE350_RTC_SUPPORT
// : assign int_src[3]  =  pit_intr;
// : assign int_src[4]  =  spi1_int;
// : assign int_src[5]  =  spi2_int;
// : assign int_src[6]  =  i2c_int;
// : assign int_src[7]  =  gpio_intr;
// : assign int_src[8]  =  uart1_int;
// : assign int_src[9]  =  uart2_int;
// : assign int_src[10] =  dma_int;
// : `ifdef AE350_AXI_SUPPORT
// : assign int_src[11] =  1'b0;
// : `else
// : assign int_src[11] =  bmc_intr;
// : `endif
// : assign int_src[12] =  1'b0;
// : assign int_src[13] =  1'b0;
// : assign int_src[14] =  1'b0;
// :`ifdef NDS_BOARD_CF1
// : assign int_src[15] =  spi3_int;
// :`else	// !NDS_BOARD_CF1
// : assign int_src[15] =  1'b0;
// :`endif	// !NDS_BOARD_CF1
// :`ifdef NDS_NHART
// :	`ifdef NDS_IO_L2C
// :assign int_src[16] =  l2c_err_int;
// :	`else	// !NDS_IO_L2C
// :assign int_src[16] =  1'b0;
// :	`endif	// !NDS_IO_L2C
// :`else	// !NDS_NHART
// :	`ifdef NDS_BOARD_CF1
// :assign int_src[16] =  spi4_int;
// :	`else	// !NDS_BOARD_CF1
// :assign int_src[16] =  1'b0;
// :	`endif	// !NDS_BOARD_CF1
// :`endif	// !NDS_NHART
// : assign int_src[17] =  ssp_intr;
// : assign int_src[18] =  sdc_int;
// : assign int_src[19] =  mac_int;
// : assign int_src[20] =  lcd_intr;
// : assign int_src[21] =  1'b0;
// : assign int_src[22] =  1'b0;
// :`ifdef NDS_BOARD_CF1
// : assign int_src[23] =  1'b0;
// : assign int_src[24] =  1'b0;
// : assign int_src[25] =  |pcs_int;
// : assign int_src[26] =  pcs3_standby_req;
// : assign int_src[27] =  pcs3_wakeup;
// : assign int_src[28] =  i2c2_int;
// : assign int_src[29] =  pit2_int;
// : assign int_src[30] =  pit3_int;
// : assign int_src[31] =  pit4_int;
// : assign int_src[32] =  pit5_int;
// :`else	// !NDS_BOARD_CF1
// : assign int_src[23] =  pcs3_standby_req;
// : assign int_src[24] =  pcs4_standby_req;
// : assign int_src[25] =  pcs5_standby_req;
// : assign int_src[26] =  pcs6_standby_req;
// : assign int_src[27] =  pcs3_wakeup;
// : assign int_src[28] =  pcs4_wakeup;
// : assign int_src[29] =  pcs5_wakeup;
// : assign int_src[30] =  pcs6_wakeup;
// : assign int_src[31] =  |pcs_int;
// :`endif	// !NDS_BOARD_CF1
//
// # need to modify
// &FORCE("wire", "T_wakeup_in");
// &FORCE("wire", "T_wakeup_in_pclk");
// &FORCE("wire", "pcs_int[6:0]");
// :assign pcs_int = {pcs6_int, pcs5_int, pcs4_int, pcs3_int, pcs2_int, pcs1_int, pcs0_int};
// : nds_sync_l2l #(
// :    .RESET_VALUE    (1'b0      ),
// :    .SYNC_STAGE     (SYNC_STAGE)
// : ) T_wakeup_in_sync (
// : 	.b_reset_n			(aopd_prstn),
// : 	.b_clk				(aopd_pclk),
// : 	.a_signal			(T_wakeup_in),
// : 	.b_signal			(T_wakeup_in_pclk),
// : 	.b_signal_rising_edge_pulse	(),
// : 	.b_signal_falling_edge_pulse	(),
// : 	.b_signal_edge_pulse		()
// : );
// &FORCE("wire", "pcs_wakeup_event_general[31:1]");
//
// &FORCE("input", "hart0_wakeup_event[5:0]");
// &FORCE("wire",  "hart0_wakeup_event_sync[5:0]");
// &IFDEF("NDS_NHART");
// &IFDEF("NDS_IO_HART1");
//	&FORCE("input", "hart1_wakeup_event[5:0]");
//	&FORCE("wire",  "hart1_wakeup_event_sync[5:0]");
//	&FORCE("wire",  "hart1_meip");
//	&FORCE("wire",  "hart1_seip");
//	&FORCE("wire",  "hart1_ueip");
//	&FORCE("wire",  "hart1_mtip");
//	&FORCE("wire",  "hart1_msip");
//	&FORCE("wire",  "hart1_debugint");
// &ENDIF("NDS_IO_HART1");
// &IFDEF("NDS_IO_HART2");
//	&FORCE("input", "hart2_wakeup_event[5:0]");
//	&FORCE("wire",  "hart2_wakeup_event_sync[5:0]");
//	&FORCE("wire",  "hart2_meip");
//	&FORCE("wire",  "hart2_seip");
//	&FORCE("wire",  "hart2_ueip");
//	&FORCE("wire",  "hart2_mtip");
//	&FORCE("wire",  "hart2_msip");
//	&FORCE("wire",  "hart2_debugint");
// &ENDIF("NDS_IO_HART2");
// &IFDEF("NDS_IO_HART3");
//	&FORCE("input", "hart3_wakeup_event[5:0]");
//	&FORCE("wire",  "hart3_wakeup_event_sync[5:0]");
//	&FORCE("wire",  "hart3_meip");
//	&FORCE("wire",  "hart3_seip");
//	&FORCE("wire",  "hart3_ueip");
//	&FORCE("wire",  "hart3_mtip");
//	&FORCE("wire",  "hart3_msip");
//	&FORCE("wire",  "hart3_debugint");
// &ENDIF("NDS_IO_HART3");
// &ENDIF("NDS_NHART");
//
// &FORCE("wire", "hart0_meip");
// &FORCE("wire", "hart0_seip");
// &FORCE("wire", "hart0_ueip");
// &FORCE("wire", "hart0_mtip");
// &FORCE("wire", "hart0_msip");
// &FORCE("wire", "hart0_debugint");
// :assign hart0_meip     = hart0_wakeup_event_sync[5];
// :assign hart0_seip     = hart0_wakeup_event_sync[4];
// :assign hart0_ueip     = hart0_wakeup_event_sync[3];
// :assign hart0_mtip     = hart0_wakeup_event_sync[2];
// :assign hart0_msip     = hart0_wakeup_event_sync[1];
// :assign hart0_debugint = hart0_wakeup_event_sync[0];
// :`ifdef NDS_NHART
// :	`ifdef NDS_IO_HART1
// :		assign hart1_meip     = hart1_wakeup_event_sync[5];
// :		assign hart1_seip     = hart1_wakeup_event_sync[4];
// :		assign hart1_ueip     = hart1_wakeup_event_sync[3];
// :		assign hart1_mtip     = hart1_wakeup_event_sync[2];
// :		assign hart1_msip     = hart1_wakeup_event_sync[1];
// :		assign hart1_debugint = hart1_wakeup_event_sync[0];
// :	`endif // NDS_IO_HART1
// :	`ifdef NDS_IO_HART2
// :		assign hart2_meip     = hart2_wakeup_event_sync[5];
// :		assign hart2_seip     = hart2_wakeup_event_sync[4];
// :		assign hart2_ueip     = hart2_wakeup_event_sync[3];
// :		assign hart2_mtip     = hart2_wakeup_event_sync[2];
// :		assign hart2_msip     = hart2_wakeup_event_sync[1];
// :		assign hart2_debugint = hart2_wakeup_event_sync[0];
// :	`endif // NDS_IO_HART2
// :	`ifdef NDS_IO_HART3
// :		assign hart3_meip     = hart3_wakeup_event_sync[5];
// :		assign hart3_seip     = hart3_wakeup_event_sync[4];
// :		assign hart3_ueip     = hart3_wakeup_event_sync[3];
// :		assign hart3_mtip     = hart3_wakeup_event_sync[2];
// :		assign hart3_msip     = hart3_wakeup_event_sync[1];
// :		assign hart3_debugint = hart3_wakeup_event_sync[0];
// :	`endif // NDS_IO_HART3
// :`endif //NDS_NHART
//
// &FORCE("wire", "int_src_sync[20:1]");
// :generate
// :genvar i_int_src;
// :for (i_int_src = 1; i_int_src <= 20; i_int_src = i_int_src + 1) begin: gen_sync_l2l_for_int_src
// : nds_sync_l2l #(
// :    .RESET_VALUE    (1'b0      ),
// :    .SYNC_STAGE     (SYNC_STAGE)
// : ) int_src_sync_l2l (
// :            .b_reset_n			(aopd_prstn),
// :            .b_clk				(aopd_pclk),
// :            .a_signal			(int_src[i_int_src]),
// :            .b_signal			(int_src_sync[i_int_src]),
// :            .b_signal_rising_edge_pulse	(),
// :            .b_signal_falling_edge_pulse	(),
// :            .b_signal_edge_pulse		()
// :    );
// :end
// :endgenerate
//
// :generate
// :genvar i_hart0;
// :for (i_hart0 = 0; i_hart0 <= 5; i_hart0 = i_hart0 + 1) begin: gen_sync_l2l_for_hart0
// : nds_sync_l2l #(
// :    .RESET_VALUE    (1'b0      ),
// :    .SYNC_STAGE     (SYNC_STAGE)
// : ) hart0_wakeup_event_sync_l2l (
// :            .b_reset_n                      (aopd_prstn),
// :            .b_clk                          (aopd_pclk),
// :            .a_signal                       (hart0_wakeup_event[i_hart0]),
// :            .b_signal                       (hart0_wakeup_event_sync[i_hart0]),
// :            .b_signal_rising_edge_pulse     (),
// :            .b_signal_falling_edge_pulse    (),
// :            .b_signal_edge_pulse            ()
// :    );
// :end
// :endgenerate
//
// :`ifdef NDS_NHART
// :	`ifdef NDS_IO_HART1
// :generate
// :genvar i_hart1;
// :for (i_hart1 = 0; i_hart1 <= 5; i_hart1 = i_hart1 + 1) begin: gen_sync_l2l_for_hart1
// : nds_sync_l2l #(
// :    .RESET_VALUE    (1'b0      ),
// :    .SYNC_STAGE     (SYNC_STAGE)
// : ) hart1_wakeup_event_sync_l2l (
// :            .b_reset_n                          (aopd_prstn),
// :            .b_clk                              (aopd_pclk),
// :            .a_signal                           (hart1_wakeup_event[i_hart1]),
// :            .b_signal                           (hart1_wakeup_event_sync[i_hart1]),
// :            .b_signal_rising_edge_pulse         (),
// :            .b_signal_falling_edge_pulse        (),
// :            .b_signal_edge_pulse                ()
// :    );
// :end
// :endgenerate
// :	`endif // NDS_IO_HART1
// :	`ifdef NDS_IO_HART2
// :generate
// :genvar i_hart2;
// :for (i_hart2 = 0; i_hart2 <= 5; i_hart2 = i_hart2 + 1) begin: gen_sync_l2l_for_hart2
// : nds_sync_l2l #(
// :    .RESET_VALUE    (1'b0      ),
// :    .SYNC_STAGE     (SYNC_STAGE)
// : ) hart2_wakeup_event_sync_l2l (
// :            .b_reset_n                          (aopd_prstn),
// :            .b_clk                              (aopd_pclk),
// :            .a_signal                           (hart2_wakeup_event[i_hart2]),
// :            .b_signal                           (hart2_wakeup_event_sync[i_hart2]),
// :            .b_signal_rising_edge_pulse         (),
// :            .b_signal_falling_edge_pulse        (),
// :            .b_signal_edge_pulse                ()
// :    );
// :end
// :endgenerate
// :	`endif // NDS_IO_HART2
// :	`ifdef NDS_IO_HART3
// :generate
// :genvar i_hart3;
// :for (i_hart3 = 0; i_hart3 <= 5; i_hart3 = i_hart3 + 1) begin: gen_sync_l2l_for_hart3
// : nds_sync_l2l #(
// :    .RESET_VALUE    (1'b0      ),
// :    .SYNC_STAGE     (SYNC_STAGE)
// : ) hart3_wakeup_event_sync_l2l (
// :            .b_reset_n                          (aopd_prstn),
// :            .b_clk                              (aopd_pclk),
// :            .a_signal                           (hart3_wakeup_event[i_hart3]),
// :            .b_signal                           (hart3_wakeup_event_sync[i_hart3]),
// :            .b_signal_rising_edge_pulse         (),
// :            .b_signal_falling_edge_pulse        (),
// :            .b_signal_edge_pulse                ()
// :    );
// :end
// :endgenerate
// :	`endif // NDS_IO_HART3
// :`endif //NDS_NHART
//
//  printf "assign pcs_wakeup_event_general[31:1] =      \n";
//  printf "\t\t {hart0_meip|hart0_seip|hart0_ueip// [31]\n";
//  printf "\t\t ,hart0_mtip			// [30]\n";
//  printf "\t\t ,hart0_msip			// [29]\n";
//  printf "\t\t ,hart0_debugint 		// [28]core_clk[0]\n";
//  printf "\t\t ,1'b0				// [27]\n";
//  printf "\t\t ,1'b0				// [26]\n";
//  printf "\t\t ,1'b0				// [25]\n";
//  printf "\t\t ,1'b0				// [24]\n";
//  printf "\t\t ,1'b0				// [23]\n";
//  printf "\t\t ,T_wakeup_in_pclk		// [22]SYNC\n";
//  printf "\t\t ,dbg_wakeup_req_sync		// [21]core_clk[0]\n";
//  printf "\t\t ,int_src_sync[20:1]};		// [20:1]\n";
//
//  ## hart0 is always exist
//  printf "assign pcs3_wakeup_event[31:1] =		\n", $hart_pcs_num;
//  printf "\t\t {hart0_meip|hart0_seip|hart0_ueip	// [31]	\n";
//  printf "\t\t ,hart0_mtip				// [30]	\n";
//  printf "\t\t ,hart0_msip				// [29]	\n";
//  printf "\t\t ,hart0_debugint 			// [28]	\n";
//  printf "\t\t ,wdt_int				// [27]	\n";
//  printf "\t\t ,6'd0					// [26:21]\n";
//  printf "\t\t ,pcs_wakeup_event_general[20:1]};	// [20:1]\n";
//
// my $hart0_pcs = 3;
// for (my $i_hart = 1; $i_hart < 4 ; $i_hart++) {
// $hart_pcs_num = $i_hart + $hart0_pcs;
// &FORCE("wire", "pcs${hart_pcs_num}_wakeup_event[31:1]");
//  printf "assign pcs%d_wakeup_event[31:1] =		\n", $hart_pcs_num;
//  printf "`ifdef NDS_IO_HART%d\n", $i_hart;
//  printf "\t\t {hart%d_meip|hart%d_seip|hart%d_ueip	// [31]	\n", $i_hart, $i_hart, $i_hart;
//  printf "\t\t ,hart%d_mtip				// [30]	\n", $i_hart;
//  printf "\t\t ,hart%d_msip				// [29]	\n", $i_hart;
//  printf "\t\t ,hart%d_debugint 			// [28]	\n", $i_hart;
//  printf "\t\t ,7'd0					// [27:21]\n";
//  printf "\t\t ,pcs_wakeup_event_general[20:1]};	// [20:1]\n";
//  printf "`else \/\/ NDS_IO_HART%d\n", $i_hart;
//  printf "\t\t 31'b0;\n";
//  printf "`endif \/\/ NDS_IO_HART%d\n", $i_hart;
// }
//
// &IFDEF("NDS_NHART");
// 	&IFDEF("NDS_IO_L2C");
// 		&FORCE("input",   "l2c_pcs_standby_ok");
// 		&FORCE("wire",    "l2c_idle");
// 	&ELSE("NDS_IO_L2C");
// 		&FORCE("supply1", "l2c_pcs_standby_ok");
// 		&FORCE("supply0", "l2c_idle");
// 	&ENDIF("NDS_IO_L2C");
// &ELSE("NDS_NHART");
// 	&FORCE("supply1", "l2c_pcs_standby_ok");
// 	&FORCE("supply0", "l2c_idle");
// &ENDIF("NDS_NHART");
// :`ifdef NDS_NHART
// :	`ifdef NDS_IO_L2C
// :assign l2c_idle = l2c_pcs_standby_ok;
// :	`endif	// NDS_L2C_IO
// :`endif	// NDS_NHART
//
// &IFDEF("NDS_FPGA");
// &ELSE("NDS_FPGA");
//   &FORCE("inout", "X_aopd_por_b");
//   &FORCE("inout", "X_om");
// &ENDIF("NDS_FPGA");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_aopd_pin.v",	"ae350_aopd_pin");
// &CONNECT("ae350_aopd_pin", {
//       rtc_alarm_wakeup	=> "alarm_wakeup",
//       mpd_por_b		=> "T_por_b",
//       mpd_pwr_off		=> "~pd2_vol_on",
// });
//
// #------------------------------------------------------------------------------
// # APB slave RTC  
// #------------------------------------------------------------------------------
// &IFDEF("AE350_RTC_SUPPORT");
//   &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcrtc100/hdl/atcrtc100.v", "u_rtc");
//   &CONNECT("u_rtc.rtc_clk"		, "aopd_clk_32k");
//   &CONNECT("u_rtc.rtc_rstn"		, "aopd_rtc_rstn");
//   &CONNECT("u_rtc.pclk"		, "aopd_pclk"	);
//   &CONNECT("u_rtc.presetn"		, "aopd_prstn"	);
//   &CONNECT("u_rtc.psel"		, "rtc_psel"	);
//   &CONNECT("u_rtc.prdata"		, "rtc_prdata"	);
//   &CONNECT("u_rtc.paddr"		, "paddr[5:2]"	);
//   &CONNECT("u_rtc.pwrite"		, "pwrite"	);
//   &CONNECT("u_rtc.pwdata"		, "pwdata"	);
//   &CONNECT("u_rtc.penable"		, "penable"	);
//   &CONNECT("u_rtc.freq_test_en"	, "/* NC */"	);
//   &CONNECT("u_rtc.freq_test_out"	, "/* NC */"	);
//   # &CONNECT("u_rtc.alarm_wakeup"	, "/* NC */"	);
//   &FORCE("wire", "rtc_int_period");
//   &FORCE("wire", "rtc_int_hsec");
//   &FORCE("wire", "rtc_int_sec");
//   &FORCE("wire", "rtc_int_min");
//   &FORCE("wire", "rtc_int_hour");
//   &FORCE("wire", "rtc_int_day");
// &ENDIF("AE350_RTC_SUPPORT");
// 
// :`ifdef AE350_RTC_SUPPORT
// :    assign rtc_pslverr = 1'b0;
// :    assign rtc_pready  = 1'b1;
// :       `ifdef ATCRTC100_HALF_SECOND_SUPPORT
// :            assign rtc_int_period = rtc_int_hsec | rtc_int_sec | rtc_int_min | rtc_int_hour | rtc_int_day;
// :       `else //~ATCRTC100_HALF_SECOND_SUPPORT
// :            assign rtc_int_period = rtc_int_sec | rtc_int_min | rtc_int_hour | rtc_int_day;
// :       `endif //ATCRTC100_HALF_SECOND_SUPPORT
// :`endif //AE350_RTC_SUPPORT
//
// #------------------------------------------------------------------------------
// # Clock generator and Reset generator: Output to ae350_chip
// #------------------------------------------------------------------------------
// &FORCE("output", "spi_clk");
// &FORCE("output", "uart_clk");
// &IFDEF("AE350_SSP_SUPPORT");
//      &FORCE("output", "sspclk");
// &ENDIF("AE350_SSP_SUPPORT");
// &FORCE("output", "extclk");
// &FORCE("output", "aclk");
// &FORCE("output", "pclk");
// &FORCE("output", "hclk");
// &FORCE("output", "core_clk");
// &FORCE("output", "dc_clk");
// &FORCE("output", "lm_clk");
// &FORCE("output", "te_clk");
//
// &FORCE("output", "por_rstn");
// &FORCE("output", "hresetn");
//
// #------------------------------------------------------------------------------
// # Clock generator, Reset generator, and Test generator
// #------------------------------------------------------------------------------
// &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_clkgen.v",	"ae350_clkgen");
// &FORCE("wire", "clk_32k");
// &FORCE("wire", "test_clk");
// &FORCE("wire", "test_mode");
// &FORCE("wire", "test_rstn");
//
// &FORCE("input", "wdt_rst");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_rstgen.v",	"ae350_rstgen", {
//      SYNC_STAGE => "SYNC_STAGE",
// });
// &CONNECT("ae350_rstgen", {
// 	wdt_rstn	=> "~wdt_rst",
// });
// &FORCE("wire", "por_b_psync");
// &FORCE("wire", "aopd_por_rstn");
// &FORCE("wire", "aopd_prstn");
// &FORCE("wire", "pldm_bus_resetn");
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_vol_ctrl.v",	"ae350_vol_ctrl");
//
// #------------------------------------------------------------------------------
// # Test generator
// #------------------------------------------------------------------------------
// &INSTANCE("$PVC_LOCALDIR/andes_ip/ae350/top/hdl/ae350_aopd_testgen.v", "ae350_aopd_testgen");
// &FORCE("output", "scan_enable");
// &FORCE("output", "scan_test");
// &FORCE("output", "test_mode");
// &FORCE("output", "test_rstn");
//
// #------------------------------------------------------------------------------
// # JDTM
// #------------------------------------------------------------------------------
// &IFDEF("PLATFORM_DEBUG_SUBSYSTEM");
//	&FORCE("output", "dmi_haddr[31:0]");
//	&FORCE("input",  "dmi_hready");
//	&FORCE("output", "dmi_resetn");
//	&FORCE("input",  "dmi_hresp[1:0]");
//
//	&FORCE("wire", "jdtm_tck");
//	&FORCE("wire", "jdtm_tdi");
//	&FORCE("wire", "jdtm_tdo");
//	&FORCE("wire", "jdtm_tms");
//	&FORCE("wire", "jdtm_tdo_out_en");
//
//	&FORCE("wire", "bus_clk");
// 	
// 	&IFDEF("PLATFORM_JDTM_SECURE_SUPPORT");
// 		&FORCE("input", "secure_mode[1:0]");
// 		&FORCE("input", "secure_code[127:0]");
//		&INSTANCE("$PVC_LOCALDIR/andes_ip/soc/ncedbglock100/hdl/ncedbglock100.v", "ncedbglock100");
// 	&CONNECT("ncedbglock100", {
//		tck		=> "jdtm_tck",
//		pwr_rst_n	=> "por_rstn",
//		tms_i		=> "jdtm_tms",
//		tms_o		=> "jdtm_tms_internal",
// 	});
// 	&ENDIF("PLATFORM_JDTM_SECURE_SUPPORT");
//:`ifdef PLATFORM_DEBUG_SUBSYSTEM 	
//:	`ifdef PLATFORM_JDTM_SECURE_SUPPORT
//:	`else
//:		assign jdtm_tms_internal = jdtm_tms;
//:	`endif
//:`endif
//
//      &IFDEF("NDS_IO_TRACE_INSTR");
//              &LOCALPARAM("DMI_ADDR_BITS = 15"); # for up to 8-cores
//      &ELSE("NDS_IO_TRACE_INSTR");
//              &LOCALPARAM("DMI_ADDR_BITS = 7");
//      &ENDIF("NDS_IO_TRACE_INSTR");
//	&INSTANCE("$PVC_LOCALDIR/andes_ip/soc/ncejdtm200/hdl/ncejdtm200.v", "ncejdtm200", {
//		DEBUG_INTERFACE	=>      "\"jtag\"",
//		SYNC_STAGE	=>      "SYNC_STAGE",
//		DMI_ADDR_BITS	=>      "DMI_ADDR_BITS",
//	});
//	&CONNECT("ncejdtm200", {
//		dmi_hclk	=> "bus_clk",
//		dmi_hready	=> "dmi_hready",
//		dmi_haddr	=> "dmi_haddr",
//		dmi_hresetn	=> "dmi_resetn",
//		dmi_hresp	=> "dmi_hresp[0]",
//		pwr_rst_n	=> "por_rstn",
//		test_mode	=> "test_mode",
//		tck		=> "jdtm_tck",
//		tdi		=> "jdtm_tdi",
//		tdo_out_en      => "jdtm_tdo_out_en",
//		tdo		=> "jdtm_tdo",
//		tms		=> "jdtm_tms_internal",
//		tms_out_en	=> "/* NC */"
//	});
// &ENDIF("PLATFORM_DEBUG_SUBSYSTEM");
// &FORCE("wire", "dbg_wakeup_req");
// &FORCE("wire", "dbg_wakeup_req_sync");
// :`ifdef PLATFORM_DEBUG_SUBSYSTEM
// :	`ifdef NDS_IO_AHB
// :		assign bus_clk = hclk;
// :	`else	// !NDS_IO_AHB
// :		assign bus_clk = aclk;
// :	`endif	// NDS_IO_AHB
// :`else // !PLATFORM_DEBUG_SUBSYSTEM
// :	assign dbg_wakeup_req      = 1'b0;
// :	assign dbg_wakeup_req_sync = 1'b0;
// :`endif	// PLATFORM_DEBUG_SUBSYSTEM
// 
// :`ifdef PLATFORM_DEBUG_SUBSYSTEM
// : nds_sync_l2l #(
// :    .RESET_VALUE    (1'b0      ),
// :    .SYNC_STAGE     (SYNC_STAGE)
// : ) dbg_wakeup_req_sync_l2l (
// :            .b_reset_n                      (aopd_prstn),
// :            .b_clk                          (aopd_pclk),
// :            .a_signal                       (dbg_wakeup_req),
// :            .b_signal                       (dbg_wakeup_req_sync),
// :            .b_signal_rising_edge_pulse     (),
// :            .b_signal_falling_edge_pulse    (),
// :            .b_signal_edge_pulse            ()
// :    );
// :`endif // !PLATFORM_DEBUG_SUBSYSTEM
//
// :`ifdef PLATFORM_DEBUG_SUBSYSTEM
// :	`ifdef PLATFORM_DEBUG_PORT
// :		assign jdtm_tck = tap_tck[DM_TAP_ID];
// :		assign jdtm_tdi = tap_tdi[DM_TAP_ID];
// :		assign jdtm_tms = tap_tms[DM_TAP_ID];
// :		assign tap_tdo    [DM_TAP_ID] = jdtm_tdo;
// :// If any TAP supports TDO_OUT_EN, connect tap_tdo_out_en to any of them. 
// :// If no  TAP supports TDO_OUT_EN, connect tap_tdo_out_en to 1'b1.
// :		assign tap_tdo_out_en = jdtm_tdo_out_en;  
// :	`else // !PLATFORM_DEBUG_PORT
// :		assign jdtm_tck = 1'b0;
// :		assign jdtm_tdi = 1'b1;
// :		assign jdtm_tms = 1'b0;
// :	`endif	// PLATFORM_DEBUG_PORT
// :`endif	// PLATFORM_DEBUG_SUBSYSTEM
//
// #------------------------------------------------------------------------------
// # Debug interface connection
// #------------------------------------------------------------------------------
// &IFDEF("PLATFORM_DEBUG_PORT");
// &INSTANCE("$PVC_LOCALDIR/andes_ip/soc/jtag_chain/hdl/jtag_chain.v",    "ae350_jtag_chain", {
//      INTERFACE => "DEBUG_INTERFACE",
//      TAP_NUM   => "JTAG_TAP_NUM",
// });
// &CONNECT("ae350_jtag_chain", {
//      pwr_rst_n       => "por_rstn",
//      pin_tck         => "aopd_dbg_tck",
//      pin_trst        => "pin_trst_in",
//      pin_tms         => "pin_tms_in",
//      pin_tdi         => "pin_tdi_in",
//      pin_tdo         => "pin_tdo_out",
//      pin_tdo_out_en  => "pin_tdo_out_en",
//      pin_tmsc_in     => "pin_tms_in",
//      pin_tmsc_out    => "pin_tms_out",
//      pin_tmsc_out_en => "pin_tms_out_en",
//      tap_tdo_out_en  => "tap_tdo_out_en",
// });
//
// &FORCE("wire", "tap_tck   [(JTAG_TAP_NUM-1):0]");
// &FORCE("wire", "tap_tms   [(JTAG_TAP_NUM-1):0]");
// &FORCE("wire", "tap_tdi   [(JTAG_TAP_NUM-1):0]");
// &FORCE("wire", "tap_tdo   [(JTAG_TAP_NUM-1):0]");
// &FORCE("wire", "tap_trst  [(JTAG_TAP_NUM-1):0]");
// &FORCE("wire", "tap_tdo_out_en");
// &ENDIF("PLATFORM_DEBUG_PORT");
//
//:`ifdef PLATFORM_DEBUG_PORT
//:generate 
//:genvar i_tap;
//:for (i_tap = 0; i_tap < JTAG_TAP_NUM; i_tap = i_tap + 1) begin : gen_tap_default_conn
//:        if (i_tap != DM_TAP_ID 
//:        `ifdef NDS_MULTI_JTAG_DEVICE
//:            && i_tap != JTAG_DEVICE_TAP_ID
//:        `endif // NDS_MULTI_JTAG_DEVICE
//:        ) begin : gen_tap_unconnected
//:                assign  tap_tdo   [i_tap]    = 1'b0;
//:        end
//:end
//:endgenerate
//:`endif // PLATFORM_DEBUG_PORT
//
// #------------------------------------------------------------------------------
// # Multi JTAG device
// #------------------------------------------------------------------------------
// &IFDEF("PLATFORM_DEBUG_PORT");
//      &IFDEF("NDS_MULTI_JTAG_DEVICE");
//              &INSTANCE("$PVC_LOCALDIR/andes_ip/jtag_device/top/hdl/jtag_device_n8.v", "jtag_device");
//              &CONNECT("jtag_device", {
//                 jtag_device_clk	=> "core_clk[0]",
//                 jtag_device_reset_n	=> "core_resetn[0]",
//                 # JTAG Signals
//                 jtag_device_tck	=> "tap_tck [JTAG_DEVICE_TAP_ID]",
//                 jtag_device_trst	=> "tap_trst[JTAG_DEVICE_TAP_ID]",
//                 jtag_device_tms	=> "tap_tms [JTAG_DEVICE_TAP_ID]",
//                 jtag_device_tdi	=> "tap_tdi [JTAG_DEVICE_TAP_ID]",
//                 jtag_device_tdo	=> "tap_tdo [JTAG_DEVICE_TAP_ID]",
//              });
//      &ENDIF("NDS_MULTI_JTAG_DEVICE");
// &ENDIF("PLATFORM_DEBUG_PORT");
//
// # -----------------------
// # External interrupts
// # -----------------------
//
// # for (my $i = 3; $i < 19; $i++) {
// #   &FORCE("wire", "ext_int_${i}");
// #   :assign ext_int_${i} = 1'b0;
// # }
//
// &IFDEF("NDS_FPGA");
// &ELSE("NDS_FPGA");
//   &FORCE("inout", "X_osclio");
// &ENDIF("NDS_FPGA");
//
// &IFDEF("PLATFORM_DEBUG_PORT");
//	&FORCE("inout", "X_tck");
// &ENDIF("PLATFORM_DEBUG_PORT");
//
// &IFDEF("AE350_RTC_SUPPORT");
//   &IFDEF("NDS_FPGA");
//   &ELSE("NDS_FPGA");
//     &FORCE("inout", "X_rtc_wakeup");
//   &ENDIF("NDS_FPGA");
// &ENDIF("AE350_RTC_SUPPORT");
// &FORCE("inout", "X_wakeup_in");
//
// &IFDEF("NDS_FPGA");
// &ELSE("NDS_FPGA");
//   &FORCE("inout", "X_mpd_pwr_off");
// &ENDIF("NDS_FPGA");
//
// &IFDEF("PLATFORM_DEBUG_SUBSYSTEM");
// &IFDEF("NDS_IO_TRACE_INSTR");
//      &FORCE("output", "ts_clk");
//      &FORCE("output", "ts_reset_n");
// &ENDIF("NDS_IO_TRACE_INSTR");
// &ENDIF("PLATFORM_DEBUG_SUBSYSTEM");
//
// &ENDMODULE
// VPERL_END

// VPERL_GENERATED_BEGIN
module ae350_aopd (
`ifdef AE350_RTC_SUPPORT
	  rtc_pready,                // () => ()
	  rtc_pslverr,               // () => ()
	  rtc_prdata,                // (u_rtc) => ()
	  rtc_psel,                  // (u_rtc) <= ()
`endif // AE350_RTC_SUPPORT
`ifdef NDS_BOARD_CF1
	  int_src,                   // () => ()
	  cf1_pinmux_ctrl0,          // (ae350_smu) => ()
	  cf1_pinmux_ctrl1,          // (ae350_smu) => ()
`else
	  int_src,                   // () => ()
`endif // NDS_BOARD_CF1
`ifdef NDS_FPGA
	  sdc_clk,                   // (ae350_clkgen) => ()
`else
	  X_aopd_por_b,              // (ae350_aopd_pin) <=> (ae350_aopd_pin)
	  X_mpd_pwr_off,             // (ae350_aopd_pin) <=> (ae350_aopd_pin)
	  X_om,                      // (ae350_aopd_pin) <=> (ae350_aopd_pin)
	  X_osclio,                  // (ae350_aopd_pin) <=> (ae350_aopd_pin)
	  sdc_clk,                   // (ae350_clkgen) => ()
`endif // NDS_FPGA
`ifdef AE350_AHB_SUPPORT
	  bmc_intr,                  // () <= ()
`endif // AE350_AHB_SUPPORT
`ifdef PLATFORM_DEBUG_PORT
	  X_tck,                     // (ae350_aopd_pin) <=> (ae350_aopd_pin)
	  pin_tdi_in,                // (ae350_jtag_chain) <= ()
	  pin_tdo_out,               // (ae350_jtag_chain) => ()
	  pin_tdo_out_en,            // (ae350_jtag_chain) => ()
	  pin_tms_in,                // (ae350_jtag_chain) <= ()
	  pin_tms_out,               // (ae350_jtag_chain) => ()
	  pin_tms_out_en,            // (ae350_jtag_chain) => ()
	  pin_trst_in,               // (ae350_jtag_chain) <= ()
`endif // PLATFORM_DEBUG_PORT
`ifdef AE350_SSP_SUPPORT
	  sspclk,                    // (ae350_clkgen) => (ae350_rstgen)
	  ssp_rstn,                  // (ae350_rstgen) => ()
`endif // AE350_SSP_SUPPORT
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	  dmi_haddr,                 // (ncejdtm200) => ()
	  dmi_hburst,                // (ncejdtm200) => ()
	  dmi_hprot,                 // (ncejdtm200) => ()
	  dmi_hrdata,                // (ncejdtm200) <= ()
	  dmi_hready,                // (ncejdtm200) <= ()
	  dmi_hresp,                 // (ncejdtm200) <= ()
	  dmi_hsel,                  // (ncejdtm200) => ()
	  dmi_hsize,                 // (ncejdtm200) => ()
	  dmi_htrans,                // (ncejdtm200) => ()
	  dmi_hwdata,                // (ncejdtm200) => ()
	  dmi_hwrite,                // (ncejdtm200) => ()
	  dmi_resetn,                // (ncejdtm200) => (ae350_rstgen)
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef AE350_LCDC_SUPPORT
	  lcd_clk,                   // (ae350_clkgen) => ()
	  lcd_clkn,                  // (ae350_clkgen) => ()
`endif // AE350_LCDC_SUPPORT
`ifdef AE350_K7DDR3_SUPPORT
	  ddr3_aresetn,              // (ae350_rstgen) => ()
`endif // AE350_K7DDR3_SUPPORT
`ifdef AE350_VUDDR4_SUPPORT
	  ddr4_aresetn,              // (ae350_rstgen) => ()
`endif // AE350_VUDDR4_SUPPORT
`ifdef NDS_NHART
   `ifdef NDS_IO_L2C
	  l2c_err_int,               // () <= ()
	  l2c_pcs_standby_ok,        // () <= ()
	  pcs_core0_sleep_ok,        // () <= ()
	  pcs_core0_sleep_req,       // () => ()
	  pcs_core1_sleep_ok,        // () <= ()
	  pcs_core1_sleep_req,       // () => ()
	  pcs_core2_sleep_ok,        // () <= ()
	  pcs_core2_sleep_req,       // () => ()
	  pcs_core3_sleep_ok,        // () <= ()
	  pcs_core3_sleep_req,       // () => ()
	  core0_wfi_sel_iso_sync,    // (nds_sync_core0_wfi_iso) => ()
	  core1_wfi_sel_iso_sync,    // (nds_sync_core1_wfi_iso) => ()
	  core2_wfi_sel_iso_sync,    // (nds_sync_core2_wfi_iso) => ()
	  core3_wfi_sel_iso_sync,    // (nds_sync_core3_wfi_iso) => ()
   `endif // NDS_IO_L2C
`endif // NDS_NHART
`ifdef AE350_RTC_SUPPORT
   `ifdef NDS_FPGA
   `else
	  X_rtc_wakeup,              // (ae350_aopd_pin) <=> (ae350_aopd_pin)
   `endif // NDS_FPGA
`endif // AE350_RTC_SUPPORT
`ifdef NDS_FPGA
   `ifdef AE350_DDR_LATENCY
	  ddr3_bw_ctrl,              // (ae350_smu) => ()
	  ddr3_latency,              // (ae350_smu) => ()
   `endif // AE350_DDR_LATENCY
`endif // NDS_FPGA
`ifdef NDS_NHART
   `ifdef NDS_IO_HART1
	  hart1_core_wfi_mode,       // () <= ()
	  hart1_dcache_disable_init, // () => ()
	  hart1_icache_disable_init, // () => ()
	  hart1_wakeup_event,        // () <= ()
   `endif // NDS_IO_HART1
   `ifdef NDS_IO_HART2
	  hart2_core_wfi_mode,       // () <= ()
	  hart2_dcache_disable_init, // () => ()
	  hart2_icache_disable_init, // () => ()
	  hart2_wakeup_event,        // () <= ()
   `endif // NDS_IO_HART2
   `ifdef NDS_IO_HART3
	  hart3_core_wfi_mode,       // () <= ()
	  hart3_dcache_disable_init, // () => ()
	  hart3_icache_disable_init, // () => ()
	  hart3_wakeup_event,        // () <= ()
   `endif // NDS_IO_HART3
`endif // NDS_NHART
`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef PLATFORM_JDTM_SECURE_SUPPORT
	  secure_code,               // (ncedbglock100) <= ()
	  secure_mode,               // (ncedbglock100) <= ()
   `endif // PLATFORM_JDTM_SECURE_SUPPORT
   `ifdef NDS_IO_TRACE_INSTR
	  ts_clk,                    // (ae350_clkgen) => (ae350_rstgen)
	  te_reset_n,                // (ae350_rstgen) => ()
	  ts_reset_n,                // (ae350_rstgen) => ()
   `endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
	  dma_int,                   // () <= ()
	  extclk,                    // () => ()
	  gpio_intr,                 // () <= ()
	  hart0_core_wfi_mode,       // () <= ()
	  hart0_dcache_disable_init, // () => ()
	  hart0_icache_disable_init, // () => ()
	  hart0_wakeup_event,        // () <= ()
	  i2c2_int,                  // () <= ()
	  i2c_int,                   // () <= ()
	  lcd_intr,                  // () <= ()
	  mac_int,                   // () <= ()
	  pit2_int,                  // () <= ()
	  pit3_int,                  // () <= ()
	  pit4_int,                  // () <= ()
	  pit5_int,                  // () <= ()
	  pit_intr,                  // () <= ()
	  sdc_int,                   // () <= ()
	  spi1_int,                  // () <= ()
	  spi2_int,                  // () <= ()
	  spi3_int,                  // () <= ()
	  spi4_int,                  // () <= ()
	  ssp_intr,                  // () <= ()
	  uart1_int,                 // () <= ()
	  uart2_int,                 // () <= ()
	  wdt_int,                   // () <= ()
	  X_osclin,                  // (ae350_aopd_pin) <= ()
	  X_wakeup_in,               // (ae350_aopd_pin) <=> (ae350_aopd_pin)
	  T_por_b,                   // (ae350_aopd_pin,ae350_rstgen) <= ()
	  scan_enable,               // (ae350_aopd_testgen) => (ae350_clkgen,ae350_jtag_chain)
	  scan_test,                 // (ae350_aopd_testgen) => (ae350_clkgen,ae350_jtag_chain)
	  test_mode,                 // (ae350_aopd_testgen) => (ae350_clkgen,ae350_rstgen,ncejdtm200)
	  test_rstn,                 // (ae350_aopd_testgen) => (ae350_rstgen)
	  T_osch,                    // (ae350_aopd_testgen,ae350_clkgen,ae350_rstgen) <= ()
	  aclk,                      // (ae350_clkgen) => (ae350_rstgen)
	  ahb2core_clken,            // (ae350_clkgen) => ()
	  apb2ahb_clken,             // (ae350_clkgen) => ()
	  apb2core_clken,            // (ae350_clkgen) => ()
	  axi2core_clken,            // (ae350_clkgen) => ()
	  core_clk,                  // (ae350_clkgen) => (ae350_rstgen,jtag_device)
	  dc_clk,                    // (ae350_clkgen) => ()
	  hclk,                      // (ae350_clkgen) => (ae350_rstgen)
	  lm_clk,                    // (ae350_clkgen) => ()
	  pclk,                      // (ae350_clkgen) => (ae350_rstgen)
	  pclk_gpio,                 // (ae350_clkgen) => ()
	  pclk_i2c,                  // (ae350_clkgen) => ()
	  pclk_pit,                  // (ae350_clkgen) => ()
	  pclk_spi1,                 // (ae350_clkgen) => ()
	  pclk_spi2,                 // (ae350_clkgen) => ()
	  pclk_uart1,                // (ae350_clkgen) => ()
	  pclk_uart2,                // (ae350_clkgen) => ()
	  pclk_wdt,                  // (ae350_clkgen) => ()
	  spi_clk,                   // (ae350_clkgen) => (ae350_rstgen)
	  te_clk,                    // (ae350_clkgen) => ()
	  uart_clk,                  // (ae350_clkgen) => (ae350_rstgen)
	  T_hw_rstn,                 // (ae350_rstgen) <= ()
	  aresetn,                   // (ae350_rstgen) => ()
	  core_resetn,               // (ae350_rstgen) => (jtag_device)
	  dbg_srst_req,              // (ae350_rstgen) <= ()
	  hresetn,                   // (ae350_rstgen) => (ae350_clkgen)
	  init_calib_complete,       // (ae350_rstgen) <= ()
	  por_rstn,                  // (ae350_rstgen) => (ae350_jtag_chain,ncedbglock100,ncejdtm200)
	  presetn,                   // (ae350_rstgen) => ()
	  spi_rstn,                  // (ae350_rstgen) => ()
	  uart_rstn,                 // (ae350_rstgen) => ()
	  ui_clk,                    // (ae350_rstgen) <= ()
	  wdt_rst,                   // (ae350_rstgen) <= ()
	  core_reset_vectors,        // (ae350_smu) => ()
	  pcs0_iso,                  // (ae350_smu) => (ae350_vol_ctrl)
	  pcs1_iso,                  // (ae350_smu) => (ae350_vol_ctrl)
	  pcs2_iso,                  // (ae350_smu) => (ae350_vol_ctrl)
	  pcs3_iso,                  // (ae350_smu) => (ae350_vol_ctrl,nds_sync_core0_wfi_iso)
	  pcs4_iso,                  // (ae350_smu) => (ae350_vol_ctrl,nds_sync_core1_wfi_iso)
	  pcs5_iso,                  // (ae350_smu) => (ae350_vol_ctrl,nds_sync_core2_wfi_iso)
	  pcs6_iso,                  // (ae350_smu) => (ae350_vol_ctrl,nds_sync_core3_wfi_iso)
	  smu_prdata,                // (ae350_smu) => ()
	  smu_pready,                // (ae350_smu) => ()
	  smu_psel,                  // (ae350_smu) <= ()
	  smu_pslverr,               // (ae350_smu) => ()
	  paddr,                     // (ae350_smu,u_rtc) <= ()
	  penable,                   // (ae350_smu,u_rtc) <= ()
	  pwdata,                    // (ae350_smu,u_rtc) <= ()
	  pwrite,                    // (ae350_smu,u_rtc) <= ()
	  pd0_vol_on,                // (ae350_vol_ctrl) => ()
	  pd1_vol_on,                // (ae350_vol_ctrl) => ()
	  pd2_vol_on,                // (ae350_vol_ctrl) => (ae350_aopd_pin)
	  pd3_vol_on,                // (ae350_vol_ctrl) => ()
	  pd4_vol_on,                // (ae350_vol_ctrl) => ()
	  pd5_vol_on,                // (ae350_vol_ctrl) => ()
	  pd6_vol_on                 // (ae350_vol_ctrl) => ()
);

parameter SYNC_STAGE = 2;

`ifdef NDS_NHART
localparam NHART                    = `NDS_NHART;
`else
localparam NHART                    = 1;
`endif // NDS_NHART
`ifdef ATCAPBBRG100_SLV_14
   `ifdef AE350_DTROM_SIZE_KB
localparam DTROM_SIZE_KB = `AE350_DTROM_SIZE_KB;
   `else
localparam DTROM_SIZE_KB = 8;
   `endif // AE350_DTROM_SIZE_KB
`endif // ATCAPBBRG100_SLV_14
`ifdef NDS_L2C_BIU_DATA_WIDTH
localparam L2C_BIU_DATA_WIDTH	= `NDS_L2C_BIU_DATA_WIDTH;
`else
localparam L2C_BIU_DATA_WIDTH	= 64;
`endif // NDS_L2C_BIU_DATA_WIDTH
`ifdef PLATFORM_JTAG_TWOWIRE
localparam DEBUG_INTERFACE        = "serial";
`else
localparam DEBUG_INTERFACE        = "jtag";
`endif // PLATFORM_JTAG_TWOWIRE
`ifdef PLATFORM_JTAG_TAP_NUM
localparam JTAG_TAP_NUM           = `PLATFORM_JTAG_TAP_NUM;
`else
localparam JTAG_TAP_NUM           = 1;
`endif // PLATFORM_JTAG_TAP_NUM
`ifdef PLATFORM_DM_TAP_ID
localparam DM_TAP_ID              = `PLATFORM_DM_TAP_ID;
`else
localparam DM_TAP_ID              = 0;
`endif // PLATFORM_DM_TAP_ID
`ifdef NDS_MULTI_JTAG_DEVICE
localparam JTAG_DEVICE_TAP_ID     = 1;
`endif // NDS_MULTI_JTAG_DEVICE
`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef NDS_IO_TRACE_INSTR
localparam DMI_ADDR_BITS = 15;
   `else
localparam DMI_ADDR_BITS = 7;
   `endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM

`ifdef AE350_RTC_SUPPORT
output                                 rtc_pready;
output                                 rtc_pslverr;
output                          [31:0] rtc_prdata;
input                                  rtc_psel;
`endif // AE350_RTC_SUPPORT
`ifdef NDS_BOARD_CF1
output                          [32:1] int_src;
output                          [31:0] cf1_pinmux_ctrl0;
output                          [31:0] cf1_pinmux_ctrl1;
`else
output                          [31:1] int_src;
`endif // NDS_BOARD_CF1
`ifdef NDS_FPGA
output                                 sdc_clk;                    // synthesis syn_keep=1 */
`else
inout                                  X_aopd_por_b;
inout                                  X_mpd_pwr_off;
inout                                  X_om;
inout                                  X_osclio;
output                                 sdc_clk;
`endif // NDS_FPGA
`ifdef AE350_AHB_SUPPORT
input                                  bmc_intr;
`endif // AE350_AHB_SUPPORT
`ifdef PLATFORM_DEBUG_PORT
inout                                  X_tck;
input                                  pin_tdi_in;
output                                 pin_tdo_out;
output                                 pin_tdo_out_en;
input                                  pin_tms_in;
output                                 pin_tms_out;
output                                 pin_tms_out_en;
input                                  pin_trst_in;
`endif // PLATFORM_DEBUG_PORT
`ifdef AE350_SSP_SUPPORT
output                                 sspclk;
output                                 ssp_rstn;
`endif // AE350_SSP_SUPPORT
`ifdef PLATFORM_DEBUG_SUBSYSTEM
output                          [31:0] dmi_haddr;
output                           [2:0] dmi_hburst;
output                           [3:0] dmi_hprot;
input                           [31:0] dmi_hrdata;
input                                  dmi_hready;
input                            [1:0] dmi_hresp;
output                                 dmi_hsel;
output                           [2:0] dmi_hsize;
output                           [1:0] dmi_htrans;
output                          [31:0] dmi_hwdata;
output                                 dmi_hwrite;
output                                 dmi_resetn;
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef AE350_LCDC_SUPPORT
output                                 lcd_clk;
output                                 lcd_clkn;
`endif // AE350_LCDC_SUPPORT
`ifdef AE350_K7DDR3_SUPPORT
output                                 ddr3_aresetn;
`endif // AE350_K7DDR3_SUPPORT
`ifdef AE350_VUDDR4_SUPPORT
output                                 ddr4_aresetn;
`endif // AE350_VUDDR4_SUPPORT
`ifdef NDS_NHART
   `ifdef NDS_IO_L2C
input                                  l2c_err_int;
input                                  l2c_pcs_standby_ok;
input                                  pcs_core0_sleep_ok;
output                                 pcs_core0_sleep_req;
input                                  pcs_core1_sleep_ok;
output                                 pcs_core1_sleep_req;
input                                  pcs_core2_sleep_ok;
output                                 pcs_core2_sleep_req;
input                                  pcs_core3_sleep_ok;
output                                 pcs_core3_sleep_req;
output                                 core0_wfi_sel_iso_sync;     // level signal in b_clk domain
output                                 core1_wfi_sel_iso_sync;     // level signal in b_clk domain
output                                 core2_wfi_sel_iso_sync;     // level signal in b_clk domain
output                                 core3_wfi_sel_iso_sync;     // level signal in b_clk domain
   `endif // NDS_IO_L2C
`endif // NDS_NHART
`ifdef AE350_RTC_SUPPORT
   `ifdef NDS_FPGA
   `else
inout                                  X_rtc_wakeup;
   `endif // NDS_FPGA
`endif // AE350_RTC_SUPPORT
`ifdef NDS_FPGA
   `ifdef AE350_DDR_LATENCY
output                           [1:0] ddr3_bw_ctrl;
output                           [3:0] ddr3_latency;
   `endif // AE350_DDR_LATENCY
`endif // NDS_FPGA
`ifdef NDS_NHART
   `ifdef NDS_IO_HART1
input                                  hart1_core_wfi_mode;
output                                 hart1_dcache_disable_init;
output                                 hart1_icache_disable_init;
input                            [5:0] hart1_wakeup_event;
   `endif // NDS_IO_HART1
   `ifdef NDS_IO_HART2
input                                  hart2_core_wfi_mode;
output                                 hart2_dcache_disable_init;
output                                 hart2_icache_disable_init;
input                            [5:0] hart2_wakeup_event;
   `endif // NDS_IO_HART2
   `ifdef NDS_IO_HART3
input                                  hart3_core_wfi_mode;
output                                 hart3_dcache_disable_init;
output                                 hart3_icache_disable_init;
input                            [5:0] hart3_wakeup_event;
   `endif // NDS_IO_HART3
`endif // NDS_NHART
`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef PLATFORM_JDTM_SECURE_SUPPORT
input                          [127:0] secure_code;
input                            [1:0] secure_mode;
   `endif // PLATFORM_JDTM_SECURE_SUPPORT
   `ifdef NDS_IO_TRACE_INSTR
output                                 ts_clk;                     // timestamp clock
output                   [(NHART-1):0] te_reset_n;
output                                 ts_reset_n;
   `endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
input                                  dma_int;
output                                 extclk;
input                                  gpio_intr;
input                                  hart0_core_wfi_mode;
output                                 hart0_dcache_disable_init;
output                                 hart0_icache_disable_init;
input                            [5:0] hart0_wakeup_event;
input                                  i2c2_int;
input                                  i2c_int;
input                                  lcd_intr;
input                                  mac_int;
input                                  pit2_int;
input                                  pit3_int;
input                                  pit4_int;
input                                  pit5_int;
input                                  pit_intr;
input                                  sdc_int;
input                                  spi1_int;
input                                  spi2_int;
input                                  spi3_int;
input                                  spi4_int;
input                                  ssp_intr;
input                                  uart1_int;
input                                  uart2_int;
input                                  wdt_int;
input                                  X_osclin;
inout                                  X_wakeup_in;
input                                  T_por_b;
output                                 scan_enable;                // synthesis syn_keep=1 */
output                                 scan_test;                  // synthesis syn_keep=1 */,
output                                 test_mode;                  // synthesis syn_keep=1 */,
output                                 test_rstn;                  // synthesis syn_keep=1 */,
input                                  T_osch;                     // synthesis syn_keep=1 */,
output                                 aclk;                       // synthesis syn_keep=1 */
output                                 ahb2core_clken;
output                                 apb2ahb_clken;
output                                 apb2core_clken;
output                                 axi2core_clken;
output                   [(NHART-1):0] core_clk;                   // synthesis syn_keep=1 */
output                   [(NHART-1):0] dc_clk;                     // synthesis syn_keep=1 */
output                                 hclk;                       // synthesis syn_keep=1 */
output                   [(NHART-1):0] lm_clk;                     // synthesis syn_keep=1 */
output                                 pclk;                       // synthesis syn_keep=1 */
output                                 pclk_gpio;
output                                 pclk_i2c;
output                                 pclk_pit;
output                                 pclk_spi1;
output                                 pclk_spi2;
output                                 pclk_uart1;
output                                 pclk_uart2;
output                                 pclk_wdt;
output                                 spi_clk;                    // synthesis syn_keep=1 */
output                   [(NHART-1):0] te_clk;                     // synthesis syn_keep=1 */
output                                 uart_clk;                   // synthesis syn_keep=1 */
input                                  T_hw_rstn;
output                                 aresetn;
output                   [(NHART-1):0] core_resetn;
input                                  dbg_srst_req;
output                                 hresetn;
input                                  init_calib_complete;
output                                 por_rstn;
output                                 presetn;
output                                 spi_rstn;
output                                 uart_rstn;
input                                  ui_clk;
input                                  wdt_rst;
output                         [255:0] core_reset_vectors;         // = 64*4-1
output                                 pcs0_iso;                   // synthesis syn_keep=1 */,
output                                 pcs1_iso;                   // synthesis syn_keep=1 */,
output                                 pcs2_iso;                   // synthesis syn_keep=1 */,
output                                 pcs3_iso;                   // level signal in a_clk domain
output                                 pcs4_iso;                   // level signal in a_clk domain
output                                 pcs5_iso;                   // level signal in a_clk domain
output                                 pcs6_iso;                   // level signal in a_clk domain
output                          [31:0] smu_prdata;
output                                 smu_pready;
input                                  smu_psel;
output                                 smu_pslverr;
input       [`ATCAPBBRG100_ADDR_MSB:0] paddr;
input                                  penable;
input                           [31:0] pwdata;
input                                  pwrite;
output                                 pd0_vol_on;                 // synthesis syn_keep=1 */,
output                                 pd1_vol_on;                 // synthesis syn_keep=1 */,
output                                 pd2_vol_on;                 // synthesis syn_keep=1 */,
output                                 pd3_vol_on;                 // synthesis syn_keep=1 */,
output                                 pd4_vol_on;                 // synthesis syn_keep=1 */,
output                                 pd5_vol_on;                 // synthesis syn_keep=1 */,
output                                 pd6_vol_on;                 // synthesis syn_keep=1 */,

`ifdef NDS_NHART
`else
wire                                   l2c_idle = 1'b0;
wire                                   l2c_pcs_standby_ok = 1'b1;
`endif // NDS_NHART
`ifdef AE350_RTC_SUPPORT
wire                                   rtc_int_period;
wire                                   alarm_wakeup;
wire                                   rtc_int_alarm;
wire                                   rtc_int_day;
wire                                   rtc_int_hour;
wire                                   rtc_int_hsec;
wire                                   rtc_int_min;
wire                                   rtc_int_sec;
`endif // AE350_RTC_SUPPORT
`ifdef PLATFORM_DEBUG_PORT
wire                                   tap_tdo_out_en;
wire              [(JTAG_TAP_NUM-1):0] tap_tck;
wire              [(JTAG_TAP_NUM-1):0] tap_tdi;
wire              [(JTAG_TAP_NUM-1):0] tap_tms;
wire              [(JTAG_TAP_NUM-1):0] tap_trst;
wire              [(JTAG_TAP_NUM-1):0] tap_tdo;
`endif // PLATFORM_DEBUG_PORT
`ifdef PLATFORM_DEBUG_SUBSYSTEM
wire                                   bus_clk;
wire                                   jdtm_tck;
wire                                   jdtm_tdi;
wire                                   jdtm_tms;
wire                                   jdtm_tms_internal;
wire                                   jdtm_tdo;
wire                                   jdtm_tdo_out_en;
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_NHART
   `ifdef NDS_IO_L2C
wire                                   l2c_idle;
   `else
wire                                   l2c_idle = 1'b0;
wire                                   l2c_pcs_standby_ok = 1'b1;
   `endif // NDS_IO_L2C
   `ifdef NDS_IO_HART1
wire                                   hart1_debugint;
wire                                   hart1_meip;
wire                                   hart1_msip;
wire                                   hart1_mtip;
wire                                   hart1_seip;
wire                                   hart1_standby_ok;
wire                                   hart1_ueip;
wire                             [5:0] hart1_wakeup_event_sync;
   `endif // NDS_IO_HART1
   `ifdef NDS_IO_HART2
wire                                   hart2_debugint;
wire                                   hart2_meip;
wire                                   hart2_msip;
wire                                   hart2_mtip;
wire                                   hart2_seip;
wire                                   hart2_standby_ok;
wire                                   hart2_ueip;
wire                             [5:0] hart2_wakeup_event_sync;
   `endif // NDS_IO_HART2
   `ifdef NDS_IO_HART3
wire                                   hart3_debugint;
wire                                   hart3_meip;
wire                                   hart3_msip;
wire                                   hart3_mtip;
wire                                   hart3_seip;
wire                                   hart3_standby_ok;
wire                                   hart3_ueip;
wire                             [5:0] hart3_wakeup_event_sync;
   `endif // NDS_IO_HART3
`endif // NDS_NHART
wire                                   T_wakeup_in_pclk;
wire                                   dbg_wakeup_req_sync;
wire                                   hart0_debugint;
wire                                   hart0_meip;
wire                                   hart0_msip;
wire                                   hart0_mtip;
wire                                   hart0_seip;
wire                                   hart0_standby_ok;
wire                                   hart0_ueip;
wire                             [5:0] hart0_wakeup_event_sync;
wire                            [20:1] int_src_sync;
wire                                   mpd_por_rstn;
wire                                   pcs0_standby_ok;
wire                            [31:1] pcs0_wakeup_event;
wire                                   pcs1_standby_ok;
wire                            [31:1] pcs1_wakeup_event;
wire                                   pcs2_standby_ok;
wire                            [31:1] pcs2_wakeup_event;
wire                                   pcs3_standby_ok;
wire                            [31:1] pcs3_wakeup_event;
wire                                   pcs4_standby_ok;
wire                            [31:1] pcs4_wakeup_event;
wire                                   pcs5_standby_ok;
wire                            [31:1] pcs5_wakeup_event;
wire                                   pcs6_standby_ok;
wire                            [31:1] pcs6_wakeup_event;
wire                             [6:0] pcs_int;
wire                            [31:1] pcs_wakeup_event_general;
wire                                   T_aopd_por_b;
wire                                   T_om;
wire                                   T_oscl;
wire                                   T_tck;
wire                                   T_wakeup_in;
wire                                   test_clk;
wire                                   aopd_clk_32k;
wire                                   aopd_dbg_tck;
wire                                   aopd_pclk;
wire                                   clk_32k;
wire                                   dm_clk;
wire                                   pcs0_frq_scale_ack;
wire                                   pcs1_frq_scale_ack;
wire                                   pcs2_frq_scale_ack;
wire                                   pcs3_frq_scale_ack;
wire                                   pcs4_frq_scale_ack;
wire                                   pcs5_frq_scale_ack;
wire                                   pcs6_frq_scale_ack;
wire                                   root_clk;
wire                                   aopd_por_dbg_rstn;
wire                                   aopd_por_rstn;
wire                                   aopd_prstn;
wire                                   aopd_rtc_rstn;
wire                                   main_rstn;
wire                                   main_rstn_csync;
wire                             [4:0] pcs0_reset_source;
wire                             [4:0] pcs1_reset_source;
wire                             [4:0] pcs2_reset_source;
wire                             [4:0] pcs3_reset_source;
wire                             [4:0] pcs4_reset_source;
wire                             [4:0] pcs5_reset_source;
wire                             [4:0] pcs6_reset_source;
wire                                   pldm_bus_resetn;
wire                                   por_b_psync;
wire                            [31:0] pcs0_frq_clkon;
wire                             [2:0] pcs0_frq_scale;
wire                                   pcs0_frq_scale_req;
wire                                   pcs0_int;
wire                             [3:0] pcs0_mem_init;
wire                                   pcs0_resetn;
wire                                   pcs0_reten;
wire                                   pcs0_standby_req;
wire                             [2:0] pcs0_vol_scale;
wire                                   pcs0_vol_scale_req;
wire                                   pcs0_wakeup;
wire                            [31:0] pcs1_frq_clkon;
wire                             [2:0] pcs1_frq_scale;
wire                                   pcs1_frq_scale_req;
wire                                   pcs1_int;
wire                             [3:0] pcs1_mem_init;
wire                                   pcs1_resetn;
wire                                   pcs1_reten;
wire                                   pcs1_standby_req;
wire                             [2:0] pcs1_vol_scale;
wire                                   pcs1_vol_scale_req;
wire                                   pcs1_wakeup;
wire                            [31:0] pcs2_frq_clkon;
wire                             [2:0] pcs2_frq_scale;
wire                                   pcs2_frq_scale_req;
wire                                   pcs2_int;
wire                             [3:0] pcs2_mem_init;
wire                                   pcs2_resetn;
wire                                   pcs2_reten;
wire                                   pcs2_standby_req;
wire                             [2:0] pcs2_vol_scale;
wire                                   pcs2_vol_scale_req;
wire                                   pcs2_wakeup;
wire                            [31:0] pcs3_frq_clkon;
wire                             [2:0] pcs3_frq_scale;
wire                                   pcs3_frq_scale_req;
wire                                   pcs3_int;
wire                             [3:0] pcs3_mem_init;
wire                                   pcs3_resetn;
wire                                   pcs3_reten;
wire                                   pcs3_standby_req;
wire                             [2:0] pcs3_vol_scale;
wire                                   pcs3_vol_scale_req;
wire                                   pcs3_wakeup;
wire                            [31:0] pcs4_frq_clkon;
wire                             [2:0] pcs4_frq_scale;
wire                                   pcs4_frq_scale_req;
wire                                   pcs4_int;
wire                             [3:0] pcs4_mem_init;
wire                                   pcs4_resetn;
wire                                   pcs4_reten;
wire                                   pcs4_standby_req;
wire                             [2:0] pcs4_vol_scale;
wire                                   pcs4_vol_scale_req;
wire                                   pcs4_wakeup;
wire                            [31:0] pcs5_frq_clkon;
wire                             [2:0] pcs5_frq_scale;
wire                                   pcs5_frq_scale_req;
wire                                   pcs5_int;
wire                             [3:0] pcs5_mem_init;
wire                                   pcs5_resetn;
wire                                   pcs5_reten;
wire                                   pcs5_standby_req;
wire                             [2:0] pcs5_vol_scale;
wire                                   pcs5_vol_scale_req;
wire                                   pcs5_wakeup;
wire                            [31:0] pcs6_frq_clkon;
wire                             [2:0] pcs6_frq_scale;
wire                                   pcs6_frq_scale_req;
wire                                   pcs6_int;
wire                             [3:0] pcs6_mem_init;
wire                                   pcs6_resetn;
wire                                   pcs6_reten;
wire                                   pcs6_standby_req;
wire                             [2:0] pcs6_vol_scale;
wire                                   pcs6_vol_scale_req;
wire                                   pcs6_wakeup;
wire                             [4:0] system_clock_ratio;
wire                                   pcs0_vol_scale_ack;
wire                                   pcs1_vol_scale_ack;
wire                                   pcs2_vol_scale_ack;
wire                                   pcs3_vol_scale_ack;
wire                                   pcs4_vol_scale_ack;
wire                                   pcs5_vol_scale_ack;
wire                                   pcs6_vol_scale_ack;
wire                                   dbg_wakeup_req;

assign mpd_por_rstn = por_b_psync;
assign extclk   = clk_32k;
assign pcs0_standby_ok = 1'b1;
assign pcs1_standby_ok = 1'b1;
assign pcs2_standby_ok = 1'b1;
assign pcs0_wakeup_event = pcs_wakeup_event_general;
assign pcs1_wakeup_event = pcs_wakeup_event_general;
assign pcs2_wakeup_event = pcs_wakeup_event_general;
assign hart0_icache_disable_init = ~pcs3_mem_init[0];
assign hart0_dcache_disable_init = ~pcs3_mem_init[1];
`ifdef NDS_NHART
	`ifdef NDS_IO_L2C
			assign pcs_core0_sleep_req = pcs3_standby_req;
			assign pcs_core1_sleep_req = pcs4_standby_req;
			assign pcs_core2_sleep_req = pcs5_standby_req;
			assign pcs_core3_sleep_req = pcs6_standby_req;
			assign hart0_standby_ok    = pcs_core0_sleep_ok;
			`ifdef NDS_IO_HART1
				assign hart1_standby_ok    = pcs_core1_sleep_ok;
			`endif
			`ifdef NDS_IO_HART2
				assign hart2_standby_ok    = pcs_core2_sleep_ok;
			`endif
			`ifdef NDS_IO_HART3
				assign hart3_standby_ok    = pcs_core3_sleep_ok;
			`endif
	`endif	// NDS_IO_L2C
`else // !NDS_NHART
	assign hart0_standby_ok = hart0_core_wfi_mode;
`endif // NDS_NHART

assign pcs3_standby_ok = hart0_standby_ok;
`ifdef NDS_NHART
	`ifdef NDS_IO_HART1
		assign hart1_icache_disable_init = ~pcs4_mem_init[0];
		assign hart1_dcache_disable_init = ~pcs4_mem_init[1];
		assign pcs4_standby_ok           = hart1_standby_ok;
	`else
		assign pcs4_standby_ok		 = 1'b1;
	`endif // NDS_IO_HART1
	`ifdef NDS_IO_HART2
		assign hart2_icache_disable_init = ~pcs5_mem_init[0];
		assign hart2_dcache_disable_init = ~pcs5_mem_init[1];
		assign pcs5_standby_ok           = hart2_standby_ok;
	`else
		assign pcs5_standby_ok		 = 1'b1;
	`endif // NDS_IO_HART2
	`ifdef NDS_IO_HART3
		assign hart3_icache_disable_init = ~pcs6_mem_init[0];
		assign hart3_dcache_disable_init = ~pcs6_mem_init[1];
		assign pcs6_standby_ok           = hart3_standby_ok;
	`else
		assign pcs6_standby_ok		 = 1'b1;
	`endif //NDS_IO_HART3
`else
		assign pcs4_standby_ok		 = 1'b1;
		assign pcs5_standby_ok		 = 1'b1;
		assign pcs6_standby_ok		 = 1'b1;
`endif // NDS_NHART
`ifdef AE350_RTC_SUPPORT
   assign int_src[1]  =  rtc_int_period;
   assign int_src[2]  =  rtc_int_alarm;
`else
   assign int_src[1]  =  1'b0;
   assign int_src[2]  =  1'b0;
`endif //AE350_RTC_SUPPORT
assign int_src[3]  =  pit_intr;
assign int_src[4]  =  spi1_int;
assign int_src[5]  =  spi2_int;
assign int_src[6]  =  i2c_int;
assign int_src[7]  =  gpio_intr;
assign int_src[8]  =  uart1_int;
assign int_src[9]  =  uart2_int;
assign int_src[10] =  dma_int;
`ifdef AE350_AXI_SUPPORT
assign int_src[11] =  1'b0;
`else
assign int_src[11] =  bmc_intr;
`endif
assign int_src[12] =  1'b0;
assign int_src[13] =  1'b0;
assign int_src[14] =  1'b0;
`ifdef NDS_BOARD_CF1
assign int_src[15] =  spi3_int;
`else	// !NDS_BOARD_CF1
assign int_src[15] =  1'b0;
`endif	// !NDS_BOARD_CF1
`ifdef NDS_NHART
	`ifdef NDS_IO_L2C
assign int_src[16] =  l2c_err_int;
	`else	// !NDS_IO_L2C
assign int_src[16] =  1'b0;
	`endif	// !NDS_IO_L2C
`else	// !NDS_NHART
	`ifdef NDS_BOARD_CF1
assign int_src[16] =  spi4_int;
	`else	// !NDS_BOARD_CF1
assign int_src[16] =  1'b0;
	`endif	// !NDS_BOARD_CF1
`endif	// !NDS_NHART
assign int_src[17] =  ssp_intr;
assign int_src[18] =  sdc_int;
assign int_src[19] =  mac_int;
assign int_src[20] =  lcd_intr;
assign int_src[21] =  1'b0;
assign int_src[22] =  1'b0;
`ifdef NDS_BOARD_CF1
assign int_src[23] =  1'b0;
assign int_src[24] =  1'b0;
assign int_src[25] =  |pcs_int;
assign int_src[26] =  pcs3_standby_req;
assign int_src[27] =  pcs3_wakeup;
assign int_src[28] =  i2c2_int;
assign int_src[29] =  pit2_int;
assign int_src[30] =  pit3_int;
assign int_src[31] =  pit4_int;
assign int_src[32] =  pit5_int;
`else	// !NDS_BOARD_CF1
assign int_src[23] =  pcs3_standby_req;
assign int_src[24] =  pcs4_standby_req;
assign int_src[25] =  pcs5_standby_req;
assign int_src[26] =  pcs6_standby_req;
assign int_src[27] =  pcs3_wakeup;
assign int_src[28] =  pcs4_wakeup;
assign int_src[29] =  pcs5_wakeup;
assign int_src[30] =  pcs6_wakeup;
assign int_src[31] =  |pcs_int;
`endif	// !NDS_BOARD_CF1
assign pcs_int = {pcs6_int, pcs5_int, pcs4_int, pcs3_int, pcs2_int, pcs1_int, pcs0_int};
nds_sync_l2l #(
   .RESET_VALUE    (1'b0      ),
   .SYNC_STAGE     (SYNC_STAGE)
) T_wakeup_in_sync (
	.b_reset_n			(aopd_prstn),
	.b_clk				(aopd_pclk),
	.a_signal			(T_wakeup_in),
	.b_signal			(T_wakeup_in_pclk),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);
assign hart0_meip     = hart0_wakeup_event_sync[5];
assign hart0_seip     = hart0_wakeup_event_sync[4];
assign hart0_ueip     = hart0_wakeup_event_sync[3];
assign hart0_mtip     = hart0_wakeup_event_sync[2];
assign hart0_msip     = hart0_wakeup_event_sync[1];
assign hart0_debugint = hart0_wakeup_event_sync[0];
`ifdef NDS_NHART
	`ifdef NDS_IO_HART1
		assign hart1_meip     = hart1_wakeup_event_sync[5];
		assign hart1_seip     = hart1_wakeup_event_sync[4];
		assign hart1_ueip     = hart1_wakeup_event_sync[3];
		assign hart1_mtip     = hart1_wakeup_event_sync[2];
		assign hart1_msip     = hart1_wakeup_event_sync[1];
		assign hart1_debugint = hart1_wakeup_event_sync[0];
	`endif // NDS_IO_HART1
	`ifdef NDS_IO_HART2
		assign hart2_meip     = hart2_wakeup_event_sync[5];
		assign hart2_seip     = hart2_wakeup_event_sync[4];
		assign hart2_ueip     = hart2_wakeup_event_sync[3];
		assign hart2_mtip     = hart2_wakeup_event_sync[2];
		assign hart2_msip     = hart2_wakeup_event_sync[1];
		assign hart2_debugint = hart2_wakeup_event_sync[0];
	`endif // NDS_IO_HART2
	`ifdef NDS_IO_HART3
		assign hart3_meip     = hart3_wakeup_event_sync[5];
		assign hart3_seip     = hart3_wakeup_event_sync[4];
		assign hart3_ueip     = hart3_wakeup_event_sync[3];
		assign hart3_mtip     = hart3_wakeup_event_sync[2];
		assign hart3_msip     = hart3_wakeup_event_sync[1];
		assign hart3_debugint = hart3_wakeup_event_sync[0];
	`endif // NDS_IO_HART3
`endif //NDS_NHART
generate
genvar i_int_src;
for (i_int_src = 1; i_int_src <= 20; i_int_src = i_int_src + 1) begin: gen_sync_l2l_for_int_src
nds_sync_l2l #(
   .RESET_VALUE    (1'b0      ),
   .SYNC_STAGE     (SYNC_STAGE)
) int_src_sync_l2l (
           .b_reset_n			(aopd_prstn),
           .b_clk				(aopd_pclk),
           .a_signal			(int_src[i_int_src]),
           .b_signal			(int_src_sync[i_int_src]),
           .b_signal_rising_edge_pulse	(),
           .b_signal_falling_edge_pulse	(),
           .b_signal_edge_pulse		()
   );
end
endgenerate
generate
genvar i_hart0;
for (i_hart0 = 0; i_hart0 <= 5; i_hart0 = i_hart0 + 1) begin: gen_sync_l2l_for_hart0
nds_sync_l2l #(
   .RESET_VALUE    (1'b0      ),
   .SYNC_STAGE     (SYNC_STAGE)
) hart0_wakeup_event_sync_l2l (
           .b_reset_n                      (aopd_prstn),
           .b_clk                          (aopd_pclk),
           .a_signal                       (hart0_wakeup_event[i_hart0]),
           .b_signal                       (hart0_wakeup_event_sync[i_hart0]),
           .b_signal_rising_edge_pulse     (),
           .b_signal_falling_edge_pulse    (),
           .b_signal_edge_pulse            ()
   );
end
endgenerate
`ifdef NDS_NHART
	`ifdef NDS_IO_HART1
generate
genvar i_hart1;
for (i_hart1 = 0; i_hart1 <= 5; i_hart1 = i_hart1 + 1) begin: gen_sync_l2l_for_hart1
nds_sync_l2l #(
   .RESET_VALUE    (1'b0      ),
   .SYNC_STAGE     (SYNC_STAGE)
) hart1_wakeup_event_sync_l2l (
           .b_reset_n                          (aopd_prstn),
           .b_clk                              (aopd_pclk),
           .a_signal                           (hart1_wakeup_event[i_hart1]),
           .b_signal                           (hart1_wakeup_event_sync[i_hart1]),
           .b_signal_rising_edge_pulse         (),
           .b_signal_falling_edge_pulse        (),
           .b_signal_edge_pulse                ()
   );
end
endgenerate
	`endif // NDS_IO_HART1
	`ifdef NDS_IO_HART2
generate
genvar i_hart2;
for (i_hart2 = 0; i_hart2 <= 5; i_hart2 = i_hart2 + 1) begin: gen_sync_l2l_for_hart2
nds_sync_l2l #(
   .RESET_VALUE    (1'b0      ),
   .SYNC_STAGE     (SYNC_STAGE)
) hart2_wakeup_event_sync_l2l (
           .b_reset_n                          (aopd_prstn),
           .b_clk                              (aopd_pclk),
           .a_signal                           (hart2_wakeup_event[i_hart2]),
           .b_signal                           (hart2_wakeup_event_sync[i_hart2]),
           .b_signal_rising_edge_pulse         (),
           .b_signal_falling_edge_pulse        (),
           .b_signal_edge_pulse                ()
   );
end
endgenerate
	`endif // NDS_IO_HART2
	`ifdef NDS_IO_HART3
generate
genvar i_hart3;
for (i_hart3 = 0; i_hart3 <= 5; i_hart3 = i_hart3 + 1) begin: gen_sync_l2l_for_hart3
nds_sync_l2l #(
   .RESET_VALUE    (1'b0      ),
   .SYNC_STAGE     (SYNC_STAGE)
) hart3_wakeup_event_sync_l2l (
           .b_reset_n                          (aopd_prstn),
           .b_clk                              (aopd_pclk),
           .a_signal                           (hart3_wakeup_event[i_hart3]),
           .b_signal                           (hart3_wakeup_event_sync[i_hart3]),
           .b_signal_rising_edge_pulse         (),
           .b_signal_falling_edge_pulse        (),
           .b_signal_edge_pulse                ()
   );
end
endgenerate
	`endif // NDS_IO_HART3
`endif //NDS_NHART
assign pcs_wakeup_event_general[31:1] =      
		 {hart0_meip|hart0_seip|hart0_ueip// [31]
		 ,hart0_mtip			// [30]
		 ,hart0_msip			// [29]
		 ,hart0_debugint 		// [28]core_clk[0]
		 ,1'b0				// [27]
		 ,1'b0				// [26]
		 ,1'b0				// [25]
		 ,1'b0				// [24]
		 ,1'b0				// [23]
		 ,T_wakeup_in_pclk		// [22]SYNC
		 ,dbg_wakeup_req_sync		// [21]core_clk[0]
		 ,int_src_sync[20:1]};		// [20:1]
assign pcs3_wakeup_event[31:1] =		
		 {hart0_meip|hart0_seip|hart0_ueip	// [31]	
		 ,hart0_mtip				// [30]	
		 ,hart0_msip				// [29]	
		 ,hart0_debugint 			// [28]	
		 ,wdt_int				// [27]	
		 ,6'd0					// [26:21]
		 ,pcs_wakeup_event_general[20:1]};	// [20:1]
assign pcs4_wakeup_event[31:1] =		
`ifdef NDS_IO_HART1
		 {hart1_meip|hart1_seip|hart1_ueip	// [31]	
		 ,hart1_mtip				// [30]	
		 ,hart1_msip				// [29]	
		 ,hart1_debugint 			// [28]	
		 ,7'd0					// [27:21]
		 ,pcs_wakeup_event_general[20:1]};	// [20:1]
`else // NDS_IO_HART1
		 31'b0;
`endif // NDS_IO_HART1
assign pcs5_wakeup_event[31:1] =		
`ifdef NDS_IO_HART2
		 {hart2_meip|hart2_seip|hart2_ueip	// [31]	
		 ,hart2_mtip				// [30]	
		 ,hart2_msip				// [29]	
		 ,hart2_debugint 			// [28]	
		 ,7'd0					// [27:21]
		 ,pcs_wakeup_event_general[20:1]};	// [20:1]
`else // NDS_IO_HART2
		 31'b0;
`endif // NDS_IO_HART2
assign pcs6_wakeup_event[31:1] =		
`ifdef NDS_IO_HART3
		 {hart3_meip|hart3_seip|hart3_ueip	// [31]	
		 ,hart3_mtip				// [30]	
		 ,hart3_msip				// [29]	
		 ,hart3_debugint 			// [28]	
		 ,7'd0					// [27:21]
		 ,pcs_wakeup_event_general[20:1]};	// [20:1]
`else // NDS_IO_HART3
		 31'b0;
`endif // NDS_IO_HART3
`ifdef NDS_NHART
	`ifdef NDS_IO_L2C
assign l2c_idle = l2c_pcs_standby_ok;
	`endif	// NDS_L2C_IO
`endif	// NDS_NHART
`ifdef AE350_RTC_SUPPORT
   assign rtc_pslverr = 1'b0;
   assign rtc_pready  = 1'b1;
      `ifdef ATCRTC100_HALF_SECOND_SUPPORT
           assign rtc_int_period = rtc_int_hsec | rtc_int_sec | rtc_int_min | rtc_int_hour | rtc_int_day;
      `else //~ATCRTC100_HALF_SECOND_SUPPORT
           assign rtc_int_period = rtc_int_sec | rtc_int_min | rtc_int_hour | rtc_int_day;
      `endif //ATCRTC100_HALF_SECOND_SUPPORT
`endif //AE350_RTC_SUPPORT
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	`ifdef PLATFORM_JDTM_SECURE_SUPPORT
	`else
		assign jdtm_tms_internal = jdtm_tms;
	`endif
`endif
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	`ifdef NDS_IO_AHB
		assign bus_clk = hclk;
	`else	// !NDS_IO_AHB
		assign bus_clk = aclk;
	`endif	// NDS_IO_AHB
`else // !PLATFORM_DEBUG_SUBSYSTEM
	assign dbg_wakeup_req      = 1'b0;
	assign dbg_wakeup_req_sync = 1'b0;
`endif	// PLATFORM_DEBUG_SUBSYSTEM
`ifdef PLATFORM_DEBUG_SUBSYSTEM
nds_sync_l2l #(
   .RESET_VALUE    (1'b0      ),
   .SYNC_STAGE     (SYNC_STAGE)
) dbg_wakeup_req_sync_l2l (
           .b_reset_n                      (aopd_prstn),
           .b_clk                          (aopd_pclk),
           .a_signal                       (dbg_wakeup_req),
           .b_signal                       (dbg_wakeup_req_sync),
           .b_signal_rising_edge_pulse     (),
           .b_signal_falling_edge_pulse    (),
           .b_signal_edge_pulse            ()
   );
`endif // !PLATFORM_DEBUG_SUBSYSTEM
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	`ifdef PLATFORM_DEBUG_PORT
		assign jdtm_tck = tap_tck[DM_TAP_ID];
		assign jdtm_tdi = tap_tdi[DM_TAP_ID];
		assign jdtm_tms = tap_tms[DM_TAP_ID];
		assign tap_tdo    [DM_TAP_ID] = jdtm_tdo;
// If any TAP supports TDO_OUT_EN, connect tap_tdo_out_en to any of them.
// If no  TAP supports TDO_OUT_EN, connect tap_tdo_out_en to 1'b1.
		assign tap_tdo_out_en = jdtm_tdo_out_en;
	`else // !PLATFORM_DEBUG_PORT
		assign jdtm_tck = 1'b0;
		assign jdtm_tdi = 1'b1;
		assign jdtm_tms = 1'b0;
	`endif	// PLATFORM_DEBUG_PORT
`endif	// PLATFORM_DEBUG_SUBSYSTEM
`ifdef PLATFORM_DEBUG_PORT
generate
genvar i_tap;
for (i_tap = 0; i_tap < JTAG_TAP_NUM; i_tap = i_tap + 1) begin : gen_tap_default_conn
       if (i_tap != DM_TAP_ID
       `ifdef NDS_MULTI_JTAG_DEVICE
           && i_tap != JTAG_DEVICE_TAP_ID
       `endif // NDS_MULTI_JTAG_DEVICE
       ) begin : gen_tap_unconnected
               assign  tap_tdo   [i_tap]    = 1'b0;
       end
end
endgenerate
`endif // PLATFORM_DEBUG_PORT

`ifdef NDS_NHART
   `ifdef NDS_IO_L2C
nds_sync_l2l #(
	.RESET_VALUE     (1'b0            ),
	.SYNC_STAGE      (SYNC_STAGE      )
) nds_sync_core0_wfi_iso (
	.b_reset_n                  (por_b_psync), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) <= (ae350_rstgen)
	.b_clk                      (root_clk   ), // (ae350_rstgen,nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) <= (ae350_clkgen)
	.a_signal                   (pcs3_iso   ), // (ae350_vol_ctrl,nds_sync_core0_wfi_iso) <= (ae350_smu)
	.b_signal                   (core0_wfi_sel_iso_sync), // (nds_sync_core0_wfi_iso) => ()
	.b_signal_rising_edge_pulse (           ), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
	.b_signal_falling_edge_pulse(           ), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
	.b_signal_edge_pulse        (           )  // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
); // end of nds_sync_core0_wfi_iso

nds_sync_l2l #(
	.RESET_VALUE     (1'b0            ),
	.SYNC_STAGE      (SYNC_STAGE      )
) nds_sync_core1_wfi_iso (
	.b_reset_n                  (por_b_psync), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) <= (ae350_rstgen)
	.b_clk                      (root_clk   ), // (ae350_rstgen,nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) <= (ae350_clkgen)
	.a_signal                   (pcs4_iso   ), // (ae350_vol_ctrl,nds_sync_core1_wfi_iso) <= (ae350_smu)
	.b_signal                   (core1_wfi_sel_iso_sync), // (nds_sync_core1_wfi_iso) => ()
	.b_signal_rising_edge_pulse (           ), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
	.b_signal_falling_edge_pulse(           ), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
	.b_signal_edge_pulse        (           )  // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
); // end of nds_sync_core1_wfi_iso

nds_sync_l2l #(
	.RESET_VALUE     (1'b0            ),
	.SYNC_STAGE      (SYNC_STAGE      )
) nds_sync_core2_wfi_iso (
	.b_reset_n                  (por_b_psync), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) <= (ae350_rstgen)
	.b_clk                      (root_clk   ), // (ae350_rstgen,nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) <= (ae350_clkgen)
	.a_signal                   (pcs5_iso   ), // (ae350_vol_ctrl,nds_sync_core2_wfi_iso) <= (ae350_smu)
	.b_signal                   (core2_wfi_sel_iso_sync), // (nds_sync_core2_wfi_iso) => ()
	.b_signal_rising_edge_pulse (           ), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
	.b_signal_falling_edge_pulse(           ), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
	.b_signal_edge_pulse        (           )  // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
); // end of nds_sync_core2_wfi_iso

nds_sync_l2l #(
	.RESET_VALUE     (1'b0            ),
	.SYNC_STAGE      (SYNC_STAGE      )
) nds_sync_core3_wfi_iso (
	.b_reset_n                  (por_b_psync), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) <= (ae350_rstgen)
	.b_clk                      (root_clk   ), // (ae350_rstgen,nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) <= (ae350_clkgen)
	.a_signal                   (pcs6_iso   ), // (ae350_vol_ctrl,nds_sync_core3_wfi_iso) <= (ae350_smu)
	.b_signal                   (core3_wfi_sel_iso_sync), // (nds_sync_core3_wfi_iso) => ()
	.b_signal_rising_edge_pulse (           ), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
	.b_signal_falling_edge_pulse(           ), // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
	.b_signal_edge_pulse        (           )  // (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) => ()
); // end of nds_sync_core3_wfi_iso

   `endif // NDS_IO_L2C
`endif // NDS_NHART
atcsmu100 ae350_smu (
`ifdef NDS_BOARD_CF1
	.paddr             (paddr[12:2]       ), // (ae350_smu,u_rtc) <= ()
	.cf1_pinmux_ctrl0  (cf1_pinmux_ctrl0  ), // (ae350_smu) => ()
	.cf1_pinmux_ctrl1  (cf1_pinmux_ctrl1  ), // (ae350_smu) => ()
`else
	.paddr             (paddr[9:2]        ), // (ae350_smu,u_rtc) <= ()
`endif // NDS_BOARD_CF1
`ifdef NDS_FPGA
   `ifdef AE350_DDR_LATENCY
	.ddr3_bw_ctrl      (ddr3_bw_ctrl      ), // (ae350_smu) => ()
	.ddr3_latency      (ddr3_latency      ), // (ae350_smu) => ()
   `endif // AE350_DDR_LATENCY
`endif // NDS_FPGA
	.pcs0_resetn       (pcs0_resetn       ), // (ae350_smu) => (ae350_rstgen)
	.core_reset_vectors(core_reset_vectors), // (ae350_smu) => ()
	.mpd_por_rstn      (mpd_por_rstn      ), // (ae350_smu) <= ()
	.penable           (penable           ), // (ae350_smu,u_rtc) <= ()
	.prdata            (smu_prdata        ), // (ae350_smu) => ()
	.pready            (smu_pready        ), // (ae350_smu) => ()
	.psel              (smu_psel          ), // (ae350_smu) <= ()
	.pslverr           (smu_pslverr       ), // (ae350_smu) => ()
	.pwdata            (pwdata            ), // (ae350_smu,u_rtc) <= ()
	.pwrite            (pwrite            ), // (ae350_smu,u_rtc) <= ()
	.system_clock_ratio(system_clock_ratio), // (ae350_smu) => (ae350_clkgen)
	.pcs0_reset_source (pcs0_reset_source ), // (ae350_smu) <= (ae350_rstgen)
	.pclk              (aopd_pclk         ), // (ae350_rstgen,ae350_smu,u_rtc) <= (ae350_clkgen)
	.presetn           (aopd_por_dbg_rstn ), // (ae350_clkgen,ae350_smu) <= (ae350_rstgen)
	.pcs1_reset_source (pcs1_reset_source ), // (ae350_smu) <= (ae350_rstgen)
	.pcs2_reset_source (pcs2_reset_source ), // (ae350_smu) <= (ae350_rstgen)
	.pcs3_reset_source (pcs3_reset_source ), // (ae350_smu) <= (ae350_rstgen)
	.pcs4_reset_source (pcs4_reset_source ), // (ae350_smu) <= (ae350_rstgen)
	.pcs5_reset_source (pcs5_reset_source ), // (ae350_smu) <= (ae350_rstgen)
	.pcs6_reset_source (pcs6_reset_source ), // (ae350_smu) <= (ae350_rstgen)
	.pcs0_frq_clkon    (pcs0_frq_clkon    ), // (ae350_smu) => (ae350_clkgen)
	.pcs0_frq_scale    (pcs0_frq_scale    ), // (ae350_smu) => (ae350_clkgen)
	.pcs0_frq_scale_ack(pcs0_frq_scale_ack), // (ae350_smu) <= (ae350_clkgen)
	.pcs0_frq_scale_req(pcs0_frq_scale_req), // (ae350_smu) => (ae350_clkgen)
	.pcs0_int          (pcs0_int          ), // (ae350_smu) => ()
	.pcs0_iso          (pcs0_iso          ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs0_mem_init     (pcs0_mem_init     ), // (ae350_smu) => ()
	.pcs0_reten        (pcs0_reten        ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs0_standby_ok   (pcs0_standby_ok   ), // (ae350_smu) <= ()
	.pcs0_standby_req  (pcs0_standby_req  ), // (ae350_smu) => ()
	.pcs0_vol_scale    (pcs0_vol_scale    ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs0_vol_scale_ack(pcs0_vol_scale_ack), // (ae350_smu) <= (ae350_vol_ctrl)
	.pcs0_vol_scale_req(pcs0_vol_scale_req), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs0_wakeup       (pcs0_wakeup       ), // (ae350_smu) => ()
	.pcs0_wakeup_event (pcs0_wakeup_event ), // (ae350_smu) <= ()
	.pcs1_frq_clkon    (pcs1_frq_clkon    ), // (ae350_smu) => (ae350_clkgen)
	.pcs1_frq_scale    (pcs1_frq_scale    ), // (ae350_smu) => (ae350_clkgen)
	.pcs1_frq_scale_ack(pcs1_frq_scale_ack), // (ae350_smu) <= (ae350_clkgen)
	.pcs1_frq_scale_req(pcs1_frq_scale_req), // (ae350_smu) => (ae350_clkgen)
	.pcs1_int          (pcs1_int          ), // (ae350_smu) => ()
	.pcs1_iso          (pcs1_iso          ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs1_mem_init     (pcs1_mem_init     ), // (ae350_smu) => ()
	.pcs1_resetn       (pcs1_resetn       ), // (ae350_smu) => (ae350_rstgen)
	.pcs1_reten        (pcs1_reten        ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs1_standby_ok   (pcs1_standby_ok   ), // (ae350_smu) <= ()
	.pcs1_standby_req  (pcs1_standby_req  ), // (ae350_smu) => ()
	.pcs1_vol_scale    (pcs1_vol_scale    ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs1_vol_scale_ack(pcs1_vol_scale_ack), // (ae350_smu) <= (ae350_vol_ctrl)
	.pcs1_vol_scale_req(pcs1_vol_scale_req), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs1_wakeup       (pcs1_wakeup       ), // (ae350_smu) => ()
	.pcs1_wakeup_event (pcs1_wakeup_event ), // (ae350_smu) <= ()
	.pcs2_frq_clkon    (pcs2_frq_clkon    ), // (ae350_smu) => (ae350_clkgen)
	.pcs2_frq_scale    (pcs2_frq_scale    ), // (ae350_smu) => (ae350_clkgen)
	.pcs2_frq_scale_ack(pcs2_frq_scale_ack), // (ae350_smu) <= (ae350_clkgen)
	.pcs2_frq_scale_req(pcs2_frq_scale_req), // (ae350_smu) => (ae350_clkgen)
	.pcs2_int          (pcs2_int          ), // (ae350_smu) => ()
	.pcs2_iso          (pcs2_iso          ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs2_mem_init     (pcs2_mem_init     ), // (ae350_smu) => ()
	.pcs2_resetn       (pcs2_resetn       ), // (ae350_smu) => (ae350_rstgen)
	.pcs2_reten        (pcs2_reten        ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs2_standby_ok   (pcs2_standby_ok   ), // (ae350_smu) <= ()
	.pcs2_standby_req  (pcs2_standby_req  ), // (ae350_smu) => ()
	.pcs2_vol_scale    (pcs2_vol_scale    ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs2_vol_scale_ack(pcs2_vol_scale_ack), // (ae350_smu) <= (ae350_vol_ctrl)
	.pcs2_vol_scale_req(pcs2_vol_scale_req), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs2_wakeup       (pcs2_wakeup       ), // (ae350_smu) => ()
	.pcs2_wakeup_event (pcs2_wakeup_event ), // (ae350_smu) <= ()
	.pcs3_frq_clkon    (pcs3_frq_clkon    ), // (ae350_smu) => (ae350_clkgen)
	.pcs3_frq_scale    (pcs3_frq_scale    ), // (ae350_smu) => (ae350_clkgen)
	.pcs3_frq_scale_ack(pcs3_frq_scale_ack), // (ae350_smu) <= (ae350_clkgen)
	.pcs3_frq_scale_req(pcs3_frq_scale_req), // (ae350_smu) => (ae350_clkgen)
	.pcs3_int          (pcs3_int          ), // (ae350_smu) => ()
	.pcs3_iso          (pcs3_iso          ), // (ae350_smu) => (ae350_vol_ctrl,nds_sync_core0_wfi_iso)
	.pcs3_mem_init     (pcs3_mem_init     ), // (ae350_smu) => ()
	.pcs3_resetn       (pcs3_resetn       ), // (ae350_smu) => (ae350_rstgen)
	.pcs3_reten        (pcs3_reten        ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs3_standby_ok   (pcs3_standby_ok   ), // (ae350_smu) <= ()
	.pcs3_standby_req  (pcs3_standby_req  ), // (ae350_smu) => ()
	.pcs3_vol_scale    (pcs3_vol_scale    ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs3_vol_scale_ack(pcs3_vol_scale_ack), // (ae350_smu) <= (ae350_vol_ctrl)
	.pcs3_vol_scale_req(pcs3_vol_scale_req), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs3_wakeup       (pcs3_wakeup       ), // (ae350_smu) => ()
	.pcs3_wakeup_event (pcs3_wakeup_event ), // (ae350_smu) <= ()
	.pcs4_frq_clkon    (pcs4_frq_clkon    ), // (ae350_smu) => (ae350_clkgen)
	.pcs4_frq_scale    (pcs4_frq_scale    ), // (ae350_smu) => (ae350_clkgen)
	.pcs4_frq_scale_ack(pcs4_frq_scale_ack), // (ae350_smu) <= (ae350_clkgen)
	.pcs4_frq_scale_req(pcs4_frq_scale_req), // (ae350_smu) => (ae350_clkgen)
	.pcs4_int          (pcs4_int          ), // (ae350_smu) => ()
	.pcs4_iso          (pcs4_iso          ), // (ae350_smu) => (ae350_vol_ctrl,nds_sync_core1_wfi_iso)
	.pcs4_mem_init     (pcs4_mem_init     ), // (ae350_smu) => ()
	.pcs4_resetn       (pcs4_resetn       ), // (ae350_smu) => (ae350_rstgen)
	.pcs4_reten        (pcs4_reten        ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs4_standby_ok   (pcs4_standby_ok   ), // (ae350_smu) <= ()
	.pcs4_standby_req  (pcs4_standby_req  ), // (ae350_smu) => ()
	.pcs4_vol_scale    (pcs4_vol_scale    ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs4_vol_scale_ack(pcs4_vol_scale_ack), // (ae350_smu) <= (ae350_vol_ctrl)
	.pcs4_vol_scale_req(pcs4_vol_scale_req), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs4_wakeup       (pcs4_wakeup       ), // (ae350_smu) => ()
	.pcs4_wakeup_event (pcs4_wakeup_event ), // (ae350_smu) <= ()
	.pcs5_frq_clkon    (pcs5_frq_clkon    ), // (ae350_smu) => (ae350_clkgen)
	.pcs5_frq_scale    (pcs5_frq_scale    ), // (ae350_smu) => (ae350_clkgen)
	.pcs5_frq_scale_ack(pcs5_frq_scale_ack), // (ae350_smu) <= (ae350_clkgen)
	.pcs5_frq_scale_req(pcs5_frq_scale_req), // (ae350_smu) => (ae350_clkgen)
	.pcs5_int          (pcs5_int          ), // (ae350_smu) => ()
	.pcs5_iso          (pcs5_iso          ), // (ae350_smu) => (ae350_vol_ctrl,nds_sync_core2_wfi_iso)
	.pcs5_mem_init     (pcs5_mem_init     ), // (ae350_smu) => ()
	.pcs5_resetn       (pcs5_resetn       ), // (ae350_smu) => (ae350_rstgen)
	.pcs5_reten        (pcs5_reten        ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs5_standby_ok   (pcs5_standby_ok   ), // (ae350_smu) <= ()
	.pcs5_standby_req  (pcs5_standby_req  ), // (ae350_smu) => ()
	.pcs5_vol_scale    (pcs5_vol_scale    ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs5_vol_scale_ack(pcs5_vol_scale_ack), // (ae350_smu) <= (ae350_vol_ctrl)
	.pcs5_vol_scale_req(pcs5_vol_scale_req), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs5_wakeup       (pcs5_wakeup       ), // (ae350_smu) => ()
	.pcs5_wakeup_event (pcs5_wakeup_event ), // (ae350_smu) <= ()
	.pcs6_frq_clkon    (pcs6_frq_clkon    ), // (ae350_smu) => (ae350_clkgen)
	.pcs6_frq_scale    (pcs6_frq_scale    ), // (ae350_smu) => (ae350_clkgen)
	.pcs6_frq_scale_ack(pcs6_frq_scale_ack), // (ae350_smu) <= (ae350_clkgen)
	.pcs6_frq_scale_req(pcs6_frq_scale_req), // (ae350_smu) => (ae350_clkgen)
	.pcs6_int          (pcs6_int          ), // (ae350_smu) => ()
	.pcs6_iso          (pcs6_iso          ), // (ae350_smu) => (ae350_vol_ctrl,nds_sync_core3_wfi_iso)
	.pcs6_mem_init     (pcs6_mem_init     ), // (ae350_smu) => ()
	.pcs6_resetn       (pcs6_resetn       ), // (ae350_smu) => (ae350_rstgen)
	.pcs6_reten        (pcs6_reten        ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs6_standby_ok   (pcs6_standby_ok   ), // (ae350_smu) <= ()
	.pcs6_standby_req  (pcs6_standby_req  ), // (ae350_smu) => ()
	.pcs6_vol_scale    (pcs6_vol_scale    ), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs6_vol_scale_ack(pcs6_vol_scale_ack), // (ae350_smu) <= (ae350_vol_ctrl)
	.pcs6_vol_scale_req(pcs6_vol_scale_req), // (ae350_smu) => (ae350_vol_ctrl)
	.pcs6_wakeup       (pcs6_wakeup       ), // (ae350_smu) => ()
	.pcs6_wakeup_event (pcs6_wakeup_event )  // (ae350_smu) <= ()
); // end of ae350_smu

ae350_aopd_pin ae350_aopd_pin (
`ifdef NDS_FPGA
`else
	.X_osclio        (X_osclio     ), // (ae350_aopd_pin) <=> (ae350_aopd_pin)
`endif // NDS_FPGA
	.X_osclin        (X_osclin     ), // (ae350_aopd_pin) <= ()
	.T_oscl          (T_oscl       ), // (ae350_aopd_pin) => (ae350_clkgen)
`ifdef PLATFORM_DEBUG_PORT
	.X_tck           (X_tck        ), // (ae350_aopd_pin) <=> (ae350_aopd_pin)
`endif // PLATFORM_DEBUG_PORT
	.T_tck           (T_tck        ), // (ae350_aopd_pin) => (ae350_clkgen)
`ifdef NDS_FPGA
	.mpd_por_b       (T_por_b      ), // (ae350_aopd_pin,ae350_rstgen) <= ()
`else
	.X_aopd_por_b    (X_aopd_por_b ), // (ae350_aopd_pin) <=> (ae350_aopd_pin)
	.X_om            (X_om         ), // (ae350_aopd_pin) <=> (ae350_aopd_pin)
`endif // NDS_FPGA
	.T_aopd_por_b    (T_aopd_por_b ), // (ae350_aopd_pin) => (ae350_aopd_testgen,ae350_rstgen)
	.T_om            (T_om         ), // (ae350_aopd_pin) => (ae350_aopd_testgen)
	.X_wakeup_in     (X_wakeup_in  ), // (ae350_aopd_pin) <=> (ae350_aopd_pin)
	.T_wakeup_in     (T_wakeup_in  ), // (ae350_aopd_pin) => ()
`ifdef AE350_RTC_SUPPORT
   `ifdef NDS_FPGA
   `else
	.X_rtc_wakeup    (X_rtc_wakeup ), // (ae350_aopd_pin) <=> (ae350_aopd_pin)
	.rtc_alarm_wakeup(alarm_wakeup ), // (ae350_aopd_pin) <= (u_rtc)
   `endif // NDS_FPGA
`endif // AE350_RTC_SUPPORT
`ifdef NDS_FPGA
`else
	.X_mpd_pwr_off   (X_mpd_pwr_off), // (ae350_aopd_pin) <=> (ae350_aopd_pin)
`endif // NDS_FPGA
	.mpd_pwr_off     (~pd2_vol_on  )  // (ae350_aopd_pin) <= (ae350_vol_ctrl)
); // end of ae350_aopd_pin

`ifdef AE350_RTC_SUPPORT
atcrtc100 u_rtc (
   `ifdef ATCRTC100_HALF_SECOND_SUPPORT
	.rtc_int_hsec (rtc_int_hsec ), // (u_rtc) => ()
   `endif // ATCRTC100_HALF_SECOND_SUPPORT
	.freq_test_en (/* NC */     ), // (ncejdtm200,u_rtc) => ()
	.paddr        (paddr[5:2]   ), // (ae350_smu,u_rtc) <= ()
	.penable      (penable      ), // (ae350_smu,u_rtc) <= ()
	.prdata       (rtc_prdata   ), // (u_rtc) => ()
	.psel         (rtc_psel     ), // (u_rtc) <= ()
	.pwdata       (pwdata       ), // (ae350_smu,u_rtc) <= ()
	.pwrite       (pwrite       ), // (ae350_smu,u_rtc) <= ()
	.rtc_int_alarm(rtc_int_alarm), // (u_rtc) => ()
	.rtc_int_day  (rtc_int_day  ), // (u_rtc) => ()
	.rtc_int_hour (rtc_int_hour ), // (u_rtc) => ()
	.rtc_int_min  (rtc_int_min  ), // (u_rtc) => ()
	.rtc_int_sec  (rtc_int_sec  ), // (u_rtc) => ()
	.rtc_clk      (aopd_clk_32k ), // (ae350_rstgen,ae350_vol_ctrl,u_rtc) <= (ae350_clkgen)
	.rtc_rstn     (aopd_rtc_rstn), // (ae350_vol_ctrl,u_rtc) <= (ae350_rstgen)
	.pclk         (aopd_pclk    ), // (ae350_rstgen,ae350_smu,u_rtc) <= (ae350_clkgen)
	.presetn      (aopd_prstn   ), // (u_rtc) <= (ae350_rstgen)
	.alarm_wakeup (alarm_wakeup ), // (u_rtc) => (ae350_aopd_pin)
	.freq_test_out(/* NC */     )  // (ncejdtm200,u_rtc) => ()
); // end of u_rtc

`endif // AE350_RTC_SUPPORT
ae350_clkgen ae350_clkgen (
	.root_clk          (root_clk          ), // (ae350_clkgen) => (ae350_rstgen,nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso)
	.test_mode         (test_mode         ), // (ae350_clkgen,ae350_rstgen,ncejdtm200) <= (ae350_aopd_testgen)
	.test_clk          (test_clk          ), // (ae350_clkgen) <= (ae350_aopd_testgen)
`ifdef NDS_FPGA
`else
	.scan_test         (scan_test         ), // (ae350_clkgen,ae350_jtag_chain) <= (ae350_aopd_testgen)
	.scan_enable       (scan_enable       ), // (ae350_clkgen,ae350_jtag_chain) <= (ae350_aopd_testgen)
`endif // NDS_FPGA
	.system_clock_ratio(system_clock_ratio), // (ae350_clkgen) <= (ae350_smu)
	.pcs0_frq_scale_req(pcs0_frq_scale_req), // (ae350_clkgen) <= (ae350_smu)
	.pcs0_frq_scale    (pcs0_frq_scale    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs0_frq_clkon    (pcs0_frq_clkon    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs0_frq_scale_ack(pcs0_frq_scale_ack), // (ae350_clkgen) => (ae350_smu)
	.pcs1_frq_scale_req(pcs1_frq_scale_req), // (ae350_clkgen) <= (ae350_smu)
	.pcs1_frq_scale    (pcs1_frq_scale    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs1_frq_clkon    (pcs1_frq_clkon    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs1_frq_scale_ack(pcs1_frq_scale_ack), // (ae350_clkgen) => (ae350_smu)
	.pcs2_frq_scale_req(pcs2_frq_scale_req), // (ae350_clkgen) <= (ae350_smu)
	.pcs2_frq_scale    (pcs2_frq_scale    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs2_frq_clkon    (pcs2_frq_clkon    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs2_frq_scale_ack(pcs2_frq_scale_ack), // (ae350_clkgen) => (ae350_smu)
	.pcs3_frq_scale_req(pcs3_frq_scale_req), // (ae350_clkgen) <= (ae350_smu)
	.pcs3_frq_scale    (pcs3_frq_scale    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs3_frq_clkon    (pcs3_frq_clkon    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs3_frq_scale_ack(pcs3_frq_scale_ack), // (ae350_clkgen) => (ae350_smu)
	.pcs4_frq_scale_req(pcs4_frq_scale_req), // (ae350_clkgen) <= (ae350_smu)
	.pcs4_frq_scale    (pcs4_frq_scale    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs4_frq_clkon    (pcs4_frq_clkon    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs4_frq_scale_ack(pcs4_frq_scale_ack), // (ae350_clkgen) => (ae350_smu)
	.pcs5_frq_scale_req(pcs5_frq_scale_req), // (ae350_clkgen) <= (ae350_smu)
	.pcs5_frq_scale    (pcs5_frq_scale    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs5_frq_clkon    (pcs5_frq_clkon    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs5_frq_scale_ack(pcs5_frq_scale_ack), // (ae350_clkgen) => (ae350_smu)
	.pcs6_frq_scale_req(pcs6_frq_scale_req), // (ae350_clkgen) <= (ae350_smu)
	.pcs6_frq_scale    (pcs6_frq_scale    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs6_frq_clkon    (pcs6_frq_clkon    ), // (ae350_clkgen) <= (ae350_smu)
	.pcs6_frq_scale_ack(pcs6_frq_scale_ack), // (ae350_clkgen) => (ae350_smu)
	.T_tck             (T_tck             ), // (ae350_clkgen) <= (ae350_aopd_pin)
	.T_oscl            (T_oscl            ), // (ae350_clkgen) <= (ae350_aopd_pin)
	.aopd_dbg_tck      (aopd_dbg_tck      ), // (ae350_clkgen) => (ae350_jtag_chain,ae350_rstgen)
	.aopd_clk_32k      (aopd_clk_32k      ), // (ae350_clkgen) => (ae350_rstgen,ae350_vol_ctrl,u_rtc)
	.aopd_pclk         (aopd_pclk         ), // (ae350_clkgen) => (ae350_rstgen,ae350_smu,u_rtc)
	.dm_clk            (dm_clk            ), // (ae350_clkgen) => (ae350_rstgen)
`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef NDS_IO_TRACE_INSTR
	.ts_clk            (ts_clk            ), // (ae350_clkgen) => (ae350_rstgen)
   `endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef NDS_FPGA
	.core_clk          (core_clk          ), // (ae350_clkgen) => (ae350_rstgen,jtag_device)
	.dc_clk            (dc_clk            ), // (ae350_clkgen) => ()
	.lm_clk            (lm_clk            ), // (ae350_clkgen) => ()
	.te_clk            (te_clk            ), // (ae350_clkgen) => ()
`else
	.core_clk          (core_clk          ), // (ae350_clkgen) => (ae350_rstgen,jtag_device)
	.dc_clk            (dc_clk            ), // (ae350_clkgen) => ()
	.lm_clk            (lm_clk            ), // (ae350_clkgen) => ()
	.te_clk            (te_clk            ), // (ae350_clkgen) => ()
`endif // NDS_FPGA
	.clk_32k           (clk_32k           ), // (ae350_clkgen) => ()
	.T_osch            (T_osch            ), // (ae350_aopd_testgen,ae350_clkgen,ae350_rstgen) <= ()
	.main_rstn         (main_rstn         ), // (ae350_clkgen) <= (ae350_rstgen)
	.main_rstn_csync   (main_rstn_csync   ), // (ae350_clkgen) <= (ae350_rstgen)
	.aopd_por_dbg_rstn (aopd_por_dbg_rstn ), // (ae350_clkgen,ae350_smu) <= (ae350_rstgen)
	.hresetn           (hresetn           ), // (ae350_clkgen) <= (ae350_rstgen)
`ifdef AE350_LCDC_SUPPORT
	.lcd_clk           (lcd_clk           ), // (ae350_clkgen) => ()
	.lcd_clkn          (lcd_clkn          ), // (ae350_clkgen) => ()
`endif // AE350_LCDC_SUPPORT
`ifdef AE350_SSP_SUPPORT
	.sspclk            (sspclk            ), // (ae350_clkgen) => (ae350_rstgen)
`endif // AE350_SSP_SUPPORT
`ifdef NDS_FPGA
	.aclk              (aclk              ), // (ae350_clkgen) => (ae350_rstgen)
	.hclk              (hclk              ), // (ae350_clkgen) => (ae350_rstgen)
	.pclk              (pclk              ), // (ae350_clkgen) => (ae350_rstgen)
	.uart_clk          (uart_clk          ), // (ae350_clkgen) => (ae350_rstgen)
	.spi_clk           (spi_clk           ), // (ae350_clkgen) => (ae350_rstgen)
	.sdc_clk           (sdc_clk           ), // (ae350_clkgen) => ()
`else
	.aclk              (aclk              ), // (ae350_clkgen) => (ae350_rstgen)
	.hclk              (hclk              ), // (ae350_clkgen) => (ae350_rstgen)
	.pclk              (pclk              ), // (ae350_clkgen) => (ae350_rstgen)
	.uart_clk          (uart_clk          ), // (ae350_clkgen) => (ae350_rstgen)
	.spi_clk           (spi_clk           ), // (ae350_clkgen) => (ae350_rstgen)
	.sdc_clk           (sdc_clk           ), // (ae350_clkgen) => ()
`endif // NDS_FPGA
	.pclk_uart1        (pclk_uart1        ), // (ae350_clkgen) => ()
	.pclk_uart2        (pclk_uart2        ), // (ae350_clkgen) => ()
	.pclk_spi1         (pclk_spi1         ), // (ae350_clkgen) => ()
	.pclk_spi2         (pclk_spi2         ), // (ae350_clkgen) => ()
	.pclk_gpio         (pclk_gpio         ), // (ae350_clkgen) => ()
	.pclk_pit          (pclk_pit          ), // (ae350_clkgen) => ()
	.pclk_i2c          (pclk_i2c          ), // (ae350_clkgen) => ()
	.pclk_wdt          (pclk_wdt          ), // (ae350_clkgen) => ()
	.apb2ahb_clken     (apb2ahb_clken     ), // (ae350_clkgen) => ()
	.ahb2core_clken    (ahb2core_clken    ), // (ae350_clkgen) => ()
	.axi2core_clken    (axi2core_clken    ), // (ae350_clkgen) => ()
	.apb2core_clken    (apb2core_clken    )  // (ae350_clkgen) => ()
); // end of ae350_clkgen

ae350_rstgen #(
	.SYNC_STAGE      (SYNC_STAGE      )
) ae350_rstgen (
	.test_mode          (test_mode          ), // (ae350_clkgen,ae350_rstgen,ncejdtm200) <= (ae350_aopd_testgen)
	.test_rstn          (test_rstn          ), // (ae350_rstgen) <= (ae350_aopd_testgen)
	.pcs0_resetn        (pcs0_resetn        ), // (ae350_rstgen) <= (ae350_smu)
	.pcs0_reset_source  (pcs0_reset_source  ), // (ae350_rstgen) => (ae350_smu)
	.pcs1_resetn        (pcs1_resetn        ), // (ae350_rstgen) <= (ae350_smu)
	.pcs1_reset_source  (pcs1_reset_source  ), // (ae350_rstgen) => (ae350_smu)
	.pcs2_resetn        (pcs2_resetn        ), // (ae350_rstgen) <= (ae350_smu)
	.pcs2_reset_source  (pcs2_reset_source  ), // (ae350_rstgen) => (ae350_smu)
	.pcs3_resetn        (pcs3_resetn        ), // (ae350_rstgen) <= (ae350_smu)
	.pcs3_reset_source  (pcs3_reset_source  ), // (ae350_rstgen) => (ae350_smu)
	.pcs4_resetn        (pcs4_resetn        ), // (ae350_rstgen) <= (ae350_smu)
	.pcs4_reset_source  (pcs4_reset_source  ), // (ae350_rstgen) => (ae350_smu)
	.pcs5_resetn        (pcs5_resetn        ), // (ae350_rstgen) <= (ae350_smu)
	.pcs5_reset_source  (pcs5_reset_source  ), // (ae350_rstgen) => (ae350_smu)
	.pcs6_resetn        (pcs6_resetn        ), // (ae350_rstgen) <= (ae350_smu)
	.pcs6_reset_source  (pcs6_reset_source  ), // (ae350_rstgen) => (ae350_smu)
	.T_aopd_por_b       (T_aopd_por_b       ), // (ae350_aopd_testgen,ae350_rstgen) <= (ae350_aopd_pin)
	.aopd_pclk          (aopd_pclk          ), // (ae350_rstgen,ae350_smu,u_rtc) <= (ae350_clkgen)
	.aopd_clk_32k       (aopd_clk_32k       ), // (ae350_rstgen,ae350_vol_ctrl,u_rtc) <= (ae350_clkgen)
	.aopd_dbg_tck       (aopd_dbg_tck       ), // (ae350_jtag_chain,ae350_rstgen) <= (ae350_clkgen)
	.aopd_prstn         (aopd_prstn         ), // (ae350_rstgen) => (u_rtc)
	.aopd_rtc_rstn      (aopd_rtc_rstn      ), // (ae350_rstgen) => (ae350_vol_ctrl,u_rtc)
	.aopd_por_rstn      (aopd_por_rstn      ), // (ae350_rstgen) => ()
	.aopd_por_dbg_rstn  (aopd_por_dbg_rstn  ), // (ae350_rstgen) => (ae350_clkgen,ae350_smu)
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	.dm_clk             (dm_clk             ), // (ae350_rstgen) <= (ae350_clkgen)
	.dmi_resetn         (dmi_resetn         ), // (ae350_rstgen) <= (ncejdtm200)
	.pldm_bus_resetn    (pldm_bus_resetn    ), // (ae350_rstgen) => ()
   `ifdef NDS_IO_TRACE_INSTR
	.ts_clk             (ts_clk             ), // (ae350_rstgen) <= (ae350_clkgen)
	.ts_reset_n         (ts_reset_n         ), // (ae350_rstgen) => ()
   `endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
	.T_por_b            (T_por_b            ), // (ae350_aopd_pin,ae350_rstgen) <= ()
	.dbg_srst_req       (dbg_srst_req       ), // (ae350_rstgen) <= ()
	.T_osch             (T_osch             ), // (ae350_aopd_testgen,ae350_clkgen,ae350_rstgen) <= ()
	.uart_clk           (uart_clk           ), // (ae350_rstgen) <= (ae350_clkgen)
	.spi_clk            (spi_clk            ), // (ae350_rstgen) <= (ae350_clkgen)
	.pclk               (pclk               ), // (ae350_rstgen) <= (ae350_clkgen)
	.hclk               (hclk               ), // (ae350_rstgen) <= (ae350_clkgen)
	.aclk               (aclk               ), // (ae350_rstgen) <= (ae350_clkgen)
	.root_clk           (root_clk           ), // (ae350_rstgen,nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso) <= (ae350_clkgen)
	.T_hw_rstn          (T_hw_rstn          ), // (ae350_rstgen) <= ()
	.wdt_rstn           (~wdt_rst           ), // (ae350_rstgen) <= ()
	.init_calib_complete(init_calib_complete), // (ae350_rstgen) <= ()
	.main_rstn          (main_rstn          ), // (ae350_rstgen) => (ae350_clkgen)
	.main_rstn_csync    (main_rstn_csync    ), // (ae350_rstgen) => (ae350_clkgen)
	.uart_rstn          (uart_rstn          ), // (ae350_rstgen) => ()
	.spi_rstn           (spi_rstn           ), // (ae350_rstgen) => ()
	.presetn            (presetn            ), // (ae350_rstgen) => ()
	.hresetn            (hresetn            ), // (ae350_rstgen) => (ae350_clkgen)
	.aresetn            (aresetn            ), // (ae350_rstgen) => ()
`ifdef AE350_SSP_SUPPORT
	.sspclk             (sspclk             ), // (ae350_rstgen) <= (ae350_clkgen)
	.ssp_rstn           (ssp_rstn           ), // (ae350_rstgen) => ()
`endif // AE350_SSP_SUPPORT
`ifdef AE350_K7DDR3_SUPPORT
	.ui_clk             (ui_clk             ), // (ae350_rstgen) <= ()
	.ddr3_aresetn       (ddr3_aresetn       ), // (ae350_rstgen) => ()
`endif // AE350_K7DDR3_SUPPORT
`ifdef AE350_VUDDR4_SUPPORT
	.ui_clk             (ui_clk             ), // (ae350_rstgen) <= ()
	.ddr4_aresetn       (ddr4_aresetn       ), // (ae350_rstgen) => ()
`endif // AE350_VUDDR4_SUPPORT
	.por_b_psync        (por_b_psync        ), // (ae350_rstgen) => (nds_sync_core0_wfi_iso,nds_sync_core1_wfi_iso,nds_sync_core2_wfi_iso,nds_sync_core3_wfi_iso)
	.por_rstn           (por_rstn           ), // (ae350_rstgen) => (ae350_jtag_chain,ncedbglock100,ncejdtm200)
`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef NDS_IO_TRACE_INSTR
	.te_reset_n         (te_reset_n         ), // (ae350_rstgen) => ()
   `endif // NDS_IO_TRACE_INSTR
`endif // PLATFORM_DEBUG_SUBSYSTEM
	.core_clk           (core_clk           ), // (ae350_rstgen,jtag_device) <= (ae350_clkgen)
	.core_resetn        (core_resetn        )  // (ae350_rstgen) => (jtag_device)
); // end of ae350_rstgen

ae350_vol_ctrl ae350_vol_ctrl (
	.pcs0_iso          (pcs0_iso          ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs0_reten        (pcs0_reten        ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs0_vol_scale_req(pcs0_vol_scale_req), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs0_vol_scale    (pcs0_vol_scale    ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs0_vol_scale_ack(pcs0_vol_scale_ack), // (ae350_vol_ctrl) => (ae350_smu)
	.pd0_vol_on        (pd0_vol_on        ), // (ae350_vol_ctrl) => ()
	.pcs1_iso          (pcs1_iso          ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs1_reten        (pcs1_reten        ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs1_vol_scale_req(pcs1_vol_scale_req), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs1_vol_scale    (pcs1_vol_scale    ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs1_vol_scale_ack(pcs1_vol_scale_ack), // (ae350_vol_ctrl) => (ae350_smu)
	.pd1_vol_on        (pd1_vol_on        ), // (ae350_vol_ctrl) => ()
	.pcs2_iso          (pcs2_iso          ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs2_reten        (pcs2_reten        ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs2_vol_scale_req(pcs2_vol_scale_req), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs2_vol_scale    (pcs2_vol_scale    ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs2_vol_scale_ack(pcs2_vol_scale_ack), // (ae350_vol_ctrl) => (ae350_smu)
	.pd2_vol_on        (pd2_vol_on        ), // (ae350_vol_ctrl) => (ae350_aopd_pin)
	.pcs3_iso          (pcs3_iso          ), // (ae350_vol_ctrl,nds_sync_core0_wfi_iso) <= (ae350_smu)
	.pcs3_reten        (pcs3_reten        ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs3_vol_scale_req(pcs3_vol_scale_req), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs3_vol_scale    (pcs3_vol_scale    ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs3_vol_scale_ack(pcs3_vol_scale_ack), // (ae350_vol_ctrl) => (ae350_smu)
	.pd3_vol_on        (pd3_vol_on        ), // (ae350_vol_ctrl) => ()
	.pcs4_iso          (pcs4_iso          ), // (ae350_vol_ctrl,nds_sync_core1_wfi_iso) <= (ae350_smu)
	.pcs4_reten        (pcs4_reten        ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs4_vol_scale_req(pcs4_vol_scale_req), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs4_vol_scale    (pcs4_vol_scale    ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs4_vol_scale_ack(pcs4_vol_scale_ack), // (ae350_vol_ctrl) => (ae350_smu)
	.pd4_vol_on        (pd4_vol_on        ), // (ae350_vol_ctrl) => ()
	.pcs5_iso          (pcs5_iso          ), // (ae350_vol_ctrl,nds_sync_core2_wfi_iso) <= (ae350_smu)
	.pcs5_reten        (pcs5_reten        ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs5_vol_scale_req(pcs5_vol_scale_req), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs5_vol_scale    (pcs5_vol_scale    ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs5_vol_scale_ack(pcs5_vol_scale_ack), // (ae350_vol_ctrl) => (ae350_smu)
	.pd5_vol_on        (pd5_vol_on        ), // (ae350_vol_ctrl) => ()
	.pcs6_iso          (pcs6_iso          ), // (ae350_vol_ctrl,nds_sync_core3_wfi_iso) <= (ae350_smu)
	.pcs6_reten        (pcs6_reten        ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs6_vol_scale_req(pcs6_vol_scale_req), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs6_vol_scale    (pcs6_vol_scale    ), // (ae350_vol_ctrl) <= (ae350_smu)
	.pcs6_vol_scale_ack(pcs6_vol_scale_ack), // (ae350_vol_ctrl) => (ae350_smu)
	.pd6_vol_on        (pd6_vol_on        ), // (ae350_vol_ctrl) => ()
	.aopd_clk_32k      (aopd_clk_32k      ), // (ae350_rstgen,ae350_vol_ctrl,u_rtc) <= (ae350_clkgen)
	.aopd_rtc_rstn     (aopd_rtc_rstn     )  // (ae350_vol_ctrl,u_rtc) <= (ae350_rstgen)
); // end of ae350_vol_ctrl

ae350_aopd_testgen ae350_aopd_testgen (
	.T_om        (T_om        ), // (ae350_aopd_testgen) <= (ae350_aopd_pin)
	.T_osch      (T_osch      ), // (ae350_aopd_testgen,ae350_clkgen,ae350_rstgen) <= ()
	.T_aopd_por_b(T_aopd_por_b), // (ae350_aopd_testgen,ae350_rstgen) <= (ae350_aopd_pin)
	.test_mode   (test_mode   ), // (ae350_aopd_testgen) => (ae350_clkgen,ae350_rstgen,ncejdtm200)
	.test_clk    (test_clk    ), // (ae350_aopd_testgen) => (ae350_clkgen)
	.test_rstn   (test_rstn   ), // (ae350_aopd_testgen) => (ae350_rstgen)
	.scan_test   (scan_test   ), // (ae350_aopd_testgen) => (ae350_clkgen,ae350_jtag_chain)
	.scan_enable (scan_enable )  // (ae350_aopd_testgen) => (ae350_clkgen,ae350_jtag_chain)
); // end of ae350_aopd_testgen

`ifdef PLATFORM_DEBUG_SUBSYSTEM
   `ifdef PLATFORM_JDTM_SECURE_SUPPORT
ncedbglock100 ncedbglock100 (
	.tck        (jdtm_tck         ), // (ncedbglock100,ncejdtm200) <= ()
	.pwr_rst_n  (por_rstn         ), // (ae350_jtag_chain,ncedbglock100,ncejdtm200) <= (ae350_rstgen)
	.secure_mode(secure_mode      ), // (ncedbglock100) <= ()
	.secure_code(secure_code      ), // (ncedbglock100) <= ()
	.tms_i      (jdtm_tms         ), // (ncedbglock100) <= ()
	.tms_o      (jdtm_tms_internal)  // (ncedbglock100) => (ncejdtm200)
); // end of ncedbglock100

   `endif // PLATFORM_JDTM_SECURE_SUPPORT
ncejdtm200 #(
	.DEBUG_INTERFACE ("jtag"          ),
	.DMI_ADDR_BITS   (DMI_ADDR_BITS   ),
	.SYNC_STAGE      (SYNC_STAGE      )
) ncejdtm200 (
	.dbg_wakeup_req(dbg_wakeup_req   ), // (ncejdtm200) => ()
	.tms_out_en    (/* NC */         ), // (ncejdtm200,u_rtc) => ()
	.test_mode     (test_mode        ), // (ae350_clkgen,ae350_rstgen,ncejdtm200) <= (ae350_aopd_testgen)
	.pwr_rst_n     (por_rstn         ), // (ae350_jtag_chain,ncedbglock100,ncejdtm200) <= (ae350_rstgen)
	.tck           (jdtm_tck         ), // (ncedbglock100,ncejdtm200) <= ()
	.tms           (jdtm_tms_internal), // (ncejdtm200) <= (ncedbglock100)
	.tdi           (jdtm_tdi         ), // (ncejdtm200) <= ()
	.tdo           (jdtm_tdo         ), // (ncejdtm200) => ()
	.tdo_out_en    (jdtm_tdo_out_en  ), // (ncejdtm200) => ()
	.dmi_hresetn   (dmi_resetn       ), // (ncejdtm200) => (ae350_rstgen)
	.dmi_hclk      (bus_clk          ), // (ncejdtm200) <= ()
	.dmi_hsel      (dmi_hsel         ), // (ncejdtm200) => ()
	.dmi_htrans    (dmi_htrans       ), // (ncejdtm200) => ()
	.dmi_haddr     (dmi_haddr        ), // (ncejdtm200) => ()
	.dmi_hsize     (dmi_hsize        ), // (ncejdtm200) => ()
	.dmi_hburst    (dmi_hburst       ), // (ncejdtm200) => ()
	.dmi_hprot     (dmi_hprot        ), // (ncejdtm200) => ()
	.dmi_hwdata    (dmi_hwdata       ), // (ncejdtm200) => ()
	.dmi_hwrite    (dmi_hwrite       ), // (ncejdtm200) => ()
	.dmi_hrdata    (dmi_hrdata       ), // (ncejdtm200) <= ()
	.dmi_hready    (dmi_hready       ), // (ncejdtm200) <= ()
	.dmi_hresp     (dmi_hresp[0]     )  // (ncejdtm200) <= ()
); // end of ncejdtm200

`endif // PLATFORM_DEBUG_SUBSYSTEM
`ifdef PLATFORM_DEBUG_PORT
jtag_chain #(
	.INTERFACE       (DEBUG_INTERFACE ),
	.TAP_NUM         (JTAG_TAP_NUM    )
) ae350_jtag_chain (
   `ifdef NDS_FPGA
   `else
	.scan_enable    (scan_enable   ), // (ae350_clkgen,ae350_jtag_chain) <= (ae350_aopd_testgen)
	.scan_test      (scan_test     ), // (ae350_clkgen,ae350_jtag_chain) <= (ae350_aopd_testgen)
   `endif // NDS_FPGA
	.pin_tdi        (pin_tdi_in    ), // (ae350_jtag_chain) <= ()
	.pin_tdo        (pin_tdo_out   ), // (ae350_jtag_chain) => ()
	.pin_tdo_out_en (pin_tdo_out_en), // (ae350_jtag_chain) => ()
	.pin_tms        (pin_tms_in    ), // (ae350_jtag_chain) <= ()
	.pin_trst       (pin_trst_in   ), // (ae350_jtag_chain) <= ()
	.tap_tdo_out_en (tap_tdo_out_en), // (ae350_jtag_chain) <= ()
	.tap_tck        (tap_tck       ), // (ae350_jtag_chain) => (jtag_device)
	.tap_tdi        (tap_tdi       ), // (ae350_jtag_chain) => (jtag_device)
	.tap_tdo        (tap_tdo       ), // (ae350_jtag_chain) <= (jtag_device)
	.tap_tms        (tap_tms       ), // (ae350_jtag_chain) => (jtag_device)
	.tap_trst       (tap_trst      ), // (ae350_jtag_chain) => (jtag_device)
	.pin_tck        (aopd_dbg_tck  ), // (ae350_jtag_chain,ae350_rstgen) <= (ae350_clkgen)
	.pin_tmsc_in    (pin_tms_in    ), // (ae350_jtag_chain) <= ()
	.pin_tmsc_out   (pin_tms_out   ), // (ae350_jtag_chain) => ()
	.pin_tmsc_out_en(pin_tms_out_en), // (ae350_jtag_chain) => ()
	.pwr_rst_n      (por_rstn      )  // (ae350_jtag_chain,ncedbglock100,ncejdtm200) <= (ae350_rstgen)
); // end of ae350_jtag_chain

   `ifdef NDS_MULTI_JTAG_DEVICE
jtag_device_n8 jtag_device (
	.jtag_device_clk    (core_clk[0]                 ), // (ae350_rstgen,jtag_device) <= (ae350_clkgen)
	.jtag_device_reset_n(core_resetn[0]              ), // (jtag_device) <= (ae350_rstgen)
	.jtag_device_tck    (tap_tck[JTAG_DEVICE_TAP_ID] ), // (jtag_device) <= (ae350_jtag_chain)
	.jtag_device_tdi    (tap_tdi[JTAG_DEVICE_TAP_ID] ), // (jtag_device) <= (ae350_jtag_chain)
	.jtag_device_tdo    (tap_tdo[JTAG_DEVICE_TAP_ID] ), // (jtag_device) => (ae350_jtag_chain)
	.jtag_device_tms    (tap_tms[JTAG_DEVICE_TAP_ID] ), // (jtag_device) <= (ae350_jtag_chain)
	.jtag_device_trst   (tap_trst[JTAG_DEVICE_TAP_ID])  // (jtag_device) <= (ae350_jtag_chain)
); // end of jtag_device

   `endif // NDS_MULTI_JTAG_DEVICE
`endif // PLATFORM_DEBUG_PORT
endmodule
// VPERL_GENERATED_END
