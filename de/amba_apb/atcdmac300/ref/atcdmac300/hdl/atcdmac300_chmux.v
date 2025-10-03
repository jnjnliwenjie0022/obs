`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_chmux ( //VPERL: &PORTLIST;
                          // VPERL_GENERATED_BEGIN
                          	  aclk,     
                          	  aresetn,  
                          	  dma_req,  
                          	  dma_ack,  
                          	  dma_soft_reset,
                          	  ch_0_en,  
                          	  ch_0_int_tc_mask,
                          	  ch_0_int_err_mask,
                          	  ch_0_int_abt_mask,
                          	  ch_0_src_req_sel,
                          	  ch_0_dst_req_sel,
                          	  ch_0_src_addr_ctl,
                          	  ch_0_dst_addr_ctl,
                          	  ch_0_src_mode,
                          	  ch_0_dst_mode,
                          	  ch_0_src_width,
                          	  ch_0_dst_width,
                          	  ch_0_src_burst_size,
                          	  ch_0_priority,
                          	  ch_0_src_addr,
                          	  ch_0_dst_addr,
                          `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  ch_0_src_bus_inf_idx,
                          	  ch_0_dst_bus_inf_idx,
                          `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
				  `ifdef DMAC_CONFIG_CH0
                          	  ch_0_llp_reg,
			           `endif // DMAC_CONFIG_CH0
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
				     `ifdef DMAC_CONFIG_CH0
                          	  ch_0_lld_bus_inf_idx,
				     `endif // DMAC_CONFIG_CH0
                             `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  ch_0_tts, 
                          	  ch_0_abt, 
                          	  ch_1_en,  
                          	  ch_1_int_tc_mask,
                          	  ch_1_int_err_mask,
                          	  ch_1_int_abt_mask,
                          	  ch_1_src_req_sel,
                          	  ch_1_dst_req_sel,
                          	  ch_1_src_addr_ctl,
                          	  ch_1_dst_addr_ctl,
                          	  ch_1_src_mode,
                          	  ch_1_dst_mode,
                          	  ch_1_src_width,
                          	  ch_1_dst_width,
                          	  ch_1_src_burst_size,
                          	  ch_1_priority,
                          	  ch_1_src_addr,
                          	  ch_1_dst_addr,
                          `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  ch_1_src_bus_inf_idx,
                          	  ch_1_dst_bus_inf_idx,
                          `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
				  `ifdef DMAC_CONFIG_CH1
                          	  ch_1_llp_reg,
			          `endif // DMAC_CONFIG_CH1
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
				     `ifdef DMAC_CONFIG_CH1
                          	  ch_1_lld_bus_inf_idx,
				     `endif // DMAC_CONFIG_CH1
                             `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  ch_1_tts, 
                          	  ch_1_abt, 
                          	  ch_2_en,  
                          	  ch_2_int_tc_mask,
                          	  ch_2_int_err_mask,
                          	  ch_2_int_abt_mask,
                          	  ch_2_src_req_sel,
                          	  ch_2_dst_req_sel,
                          	  ch_2_src_addr_ctl,
                          	  ch_2_dst_addr_ctl,
                          	  ch_2_src_mode,
                          	  ch_2_dst_mode,
                          	  ch_2_src_width,
                          	  ch_2_dst_width,
                          	  ch_2_src_burst_size,
                          	  ch_2_priority,
                          	  ch_2_src_addr,
                          	  ch_2_dst_addr,
                          `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  ch_2_src_bus_inf_idx,
                          	  ch_2_dst_bus_inf_idx,
                          `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
				  `ifdef DMAC_CONFIG_CH2
                          	  ch_2_llp_reg,
			          `endif // DMAC_CONFIG_CH2
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
				     `ifdef DMAC_CONFIG_CH2
                          	  ch_2_lld_bus_inf_idx,
				      `endif // DMAC_CONFIG_CH2
                             `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  ch_2_tts, 
                          	  ch_2_abt, 
                          	  ch_3_en,  
                          	  ch_3_int_tc_mask,
                          	  ch_3_int_err_mask,
                          	  ch_3_int_abt_mask,
                          	  ch_3_src_req_sel,
                          	  ch_3_dst_req_sel,
                          	  ch_3_src_addr_ctl,
                          	  ch_3_dst_addr_ctl,
                          	  ch_3_src_mode,
                          	  ch_3_dst_mode,
                          	  ch_3_src_width,
                          	  ch_3_dst_width,
                          	  ch_3_src_burst_size,
                          	  ch_3_priority,
                          	  ch_3_src_addr,
                          	  ch_3_dst_addr,
                          `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  ch_3_src_bus_inf_idx,
                          	  ch_3_dst_bus_inf_idx,
                          `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
				  `ifdef DMAC_CONFIG_CH3
                          	  ch_3_llp_reg,
				   `endif // DMAC_CONFIG_CH3
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
				     `ifdef  DMAC_CONFIG_CH3
                          	  ch_3_lld_bus_inf_idx,
				     `endif// DMAC_CONFIG_CH3
                             `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  ch_3_tts, 
                          	  ch_3_abt, 
                          	  ch_4_en,  
                          	  ch_4_int_tc_mask,
                          	  ch_4_int_err_mask,
                          	  ch_4_int_abt_mask,
                          	  ch_4_src_req_sel,
                          	  ch_4_dst_req_sel,
                          	  ch_4_src_addr_ctl,
                          	  ch_4_dst_addr_ctl,
                          	  ch_4_src_mode,
                          	  ch_4_dst_mode,
                          	  ch_4_src_width,
                          	  ch_4_dst_width,
                          	  ch_4_src_burst_size,
                          	  ch_4_priority,
                          	  ch_4_src_addr,
                          	  ch_4_dst_addr,
                          `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  ch_4_src_bus_inf_idx,
                          	  ch_4_dst_bus_inf_idx,
                          `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
				  `ifdef DMAC_CONFIG_CH4
                          	  ch_4_llp_reg,
				  `endif //DMAC_CONFIG_CH4
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
				     `ifdef DMAC_CONFIG_CH4
                          	  ch_4_lld_bus_inf_idx,
				     `endif // DMAC_CONFIG_CH4
                             `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  ch_4_tts, 
                          	  ch_4_abt, 
                          	  ch_5_en,  
                          	  ch_5_int_tc_mask,
                          	  ch_5_int_err_mask,
                          	  ch_5_int_abt_mask,
                          	  ch_5_src_req_sel,
                          	  ch_5_dst_req_sel,
                          	  ch_5_src_addr_ctl,
                          	  ch_5_dst_addr_ctl,
                          	  ch_5_src_mode,
                          	  ch_5_dst_mode,
                          	  ch_5_src_width,
                          	  ch_5_dst_width,
                          	  ch_5_src_burst_size,
                          	  ch_5_priority,
                          	  ch_5_src_addr,
                          	  ch_5_dst_addr,
                          `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  ch_5_src_bus_inf_idx,
                          	  ch_5_dst_bus_inf_idx,
                          `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
				  `ifdef DMAC_CONFIG_CH5
                          	  ch_5_llp_reg,
			          `endif // DMAC_CONFIG_CH5
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
				   `ifdef DMAC_CONFIG_CH5
                          	  ch_5_lld_bus_inf_idx,
				   `endif // DMAC_CONFIG_CH5
                             `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  ch_5_tts, 
                          	  ch_5_abt, 
                          	  ch_6_en,  
                          	  ch_6_int_tc_mask,
                          	  ch_6_int_err_mask,
                          	  ch_6_int_abt_mask,
                          	  ch_6_src_req_sel,
                          	  ch_6_dst_req_sel,
                          	  ch_6_src_addr_ctl,
                          	  ch_6_dst_addr_ctl,
                          	  ch_6_src_mode,
                          	  ch_6_dst_mode,
                          	  ch_6_src_width,
                          	  ch_6_dst_width,
                          	  ch_6_src_burst_size,
                          	  ch_6_priority,
                          	  ch_6_src_addr,
                          	  ch_6_dst_addr,
                          `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  ch_6_src_bus_inf_idx,
                          	  ch_6_dst_bus_inf_idx,
                          `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
				  `ifdef DMAC_CONFIG_CH6
                          	  ch_6_llp_reg,
			          `endif // DMAC_CONFIG_CH6
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
				   `ifdef DMAC_CONFIG_CH6
                          	  ch_6_lld_bus_inf_idx,
				   `endif // DMAC_CONFIG_CH6
                             `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  ch_6_tts, 
                          	  ch_6_abt, 
                          	  ch_7_en,  
                          	  ch_7_int_tc_mask,
                          	  ch_7_int_err_mask,
                          	  ch_7_int_abt_mask,
                          	  ch_7_src_req_sel,
                          	  ch_7_dst_req_sel,
                          	  ch_7_src_addr_ctl,
                          	  ch_7_dst_addr_ctl,
                          	  ch_7_src_mode,
                          	  ch_7_dst_mode,
                          	  ch_7_src_width,
                          	  ch_7_dst_width,
                          	  ch_7_src_burst_size,
                          	  ch_7_priority,
                          	  ch_7_src_addr,
                          	  ch_7_dst_addr,
                          `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  ch_7_src_bus_inf_idx,
                          	  ch_7_dst_bus_inf_idx,
                          `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
				  `ifdef DMAC_CONFIG_CH7
                          	  ch_7_llp_reg,
				   `endif // DMAC_CONFIG_CH7
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
				    `ifdef DMAC_CONFIG_CH7
                          	  ch_7_lld_bus_inf_idx,
				    `endif // DMAC_CONFIG_CH7
                             `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  ch_7_tts, 
                          	  ch_7_abt, 
                          `ifdef DMAC_CONFIG_CH0
                          	  dma0_ch_0_ctl_wen,
                          	  dma0_ch_0_en_wen,
                          	  dma0_ch_0_src_addr_wen,
                          	  dma0_ch_0_dst_addr_wen,
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_0_llp_wen,
                             `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_0_tts_wen,
                          	  dma0_ch_0_tc_wen,
                          	  dma0_ch_0_err_wen,
                          	  dma0_ch_0_int_wen,
                          `endif // DMAC_CONFIG_CH0
                          `ifdef DMAC_CONFIG_CH1
                          	  dma0_ch_1_ctl_wen,
                          	  dma0_ch_1_en_wen,
                          	  dma0_ch_1_src_addr_wen,
                          	  dma0_ch_1_dst_addr_wen,
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_1_llp_wen,
                             `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_1_tts_wen,
                          	  dma0_ch_1_tc_wen,
                          	  dma0_ch_1_err_wen,
                          	  dma0_ch_1_int_wen,
                          `endif // DMAC_CONFIG_CH1
                          `ifdef DMAC_CONFIG_CH2
                          	  dma0_ch_2_ctl_wen,
                          	  dma0_ch_2_en_wen,
                          	  dma0_ch_2_src_addr_wen,
                          	  dma0_ch_2_dst_addr_wen,
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_2_llp_wen,
                             `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_2_tts_wen,
                          	  dma0_ch_2_tc_wen,
                          	  dma0_ch_2_err_wen,
                          	  dma0_ch_2_int_wen,
                          `endif // DMAC_CONFIG_CH2
                          `ifdef DMAC_CONFIG_CH3
                          	  dma0_ch_3_ctl_wen,
                          	  dma0_ch_3_en_wen,
                          	  dma0_ch_3_src_addr_wen,
                          	  dma0_ch_3_dst_addr_wen,
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_3_llp_wen,
                             `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_3_tts_wen,
                          	  dma0_ch_3_tc_wen,
                          	  dma0_ch_3_err_wen,
                          	  dma0_ch_3_int_wen,
                          `endif // DMAC_CONFIG_CH3
                          `ifdef DMAC_CONFIG_CH4
                          	  dma0_ch_4_ctl_wen,
                          	  dma0_ch_4_en_wen,
                          	  dma0_ch_4_src_addr_wen,
                          	  dma0_ch_4_dst_addr_wen,
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_4_llp_wen,
                             `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_4_tts_wen,
                          	  dma0_ch_4_tc_wen,
                          	  dma0_ch_4_err_wen,
                          	  dma0_ch_4_int_wen,
                          `endif // DMAC_CONFIG_CH4
                          `ifdef DMAC_CONFIG_CH5
                          	  dma0_ch_5_ctl_wen,
                          	  dma0_ch_5_en_wen,
                          	  dma0_ch_5_src_addr_wen,
                          	  dma0_ch_5_dst_addr_wen,
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_5_llp_wen,
                             `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_5_tts_wen,
                          	  dma0_ch_5_tc_wen,
                          	  dma0_ch_5_err_wen,
                          	  dma0_ch_5_int_wen,
                          `endif // DMAC_CONFIG_CH5
                          `ifdef DMAC_CONFIG_CH6
                          	  dma0_ch_6_ctl_wen,
                          	  dma0_ch_6_en_wen,
                          	  dma0_ch_6_src_addr_wen,
                          	  dma0_ch_6_dst_addr_wen,
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_6_llp_wen,
                             `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_6_tts_wen,
                          	  dma0_ch_6_tc_wen,
                          	  dma0_ch_6_err_wen,
                          	  dma0_ch_6_int_wen,
                          `endif // DMAC_CONFIG_CH6
                          `ifdef DMAC_CONFIG_CH7
                          	  dma0_ch_7_ctl_wen,
                          	  dma0_ch_7_en_wen,
                          	  dma0_ch_7_src_addr_wen,
                          	  dma0_ch_7_dst_addr_wen,
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_7_llp_wen,
                             `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_7_tts_wen,
                          	  dma0_ch_7_tc_wen,
                          	  dma0_ch_7_err_wen,
                          	  dma0_ch_7_int_wen,
                          `endif // DMAC_CONFIG_CH7
                          	  granted_channel,
                          	  ch_request,
                          	  ch_level, 
                          	  current_channel,
                          `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                          	  dma1_idle_state,
                          	  dma1_ch_ctl_wen,
                          	  dma1_ch_en_wen,
                          	  dma1_ch_src_addr_wen,
                          	  dma1_ch_dst_addr_wen,
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_llp_wen,
                             `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_tts_wen,
                          	  dma1_ch_tc_wen,
                          	  dma1_ch_err_wen,
                          	  dma1_ch_int_wen,
                          	  dma1_ch_src_ack,
                          	  dma1_ch_dst_ack,
                          	  dma1_arb_end,
                          	  dma1_current_channel,
                          	  dma1_ch_src_addr_ctl,
                          	  dma1_ch_dst_addr_ctl,
                          	  dma1_ch_src_width,
                          	  dma1_ch_dst_width,
                          	  dma1_ch_src_burst_size,
                          	  dma1_ch_src_mode,
                          	  dma1_ch_src_request,
                          	  dma1_ch_dst_mode,
                          	  dma1_ch_dst_request,
                          	  dma1_ch_tts,
                          	  dma1_ch_src_addr,
                          	  dma1_ch_dst_addr,
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  dma1_ch_src_bus_inf_idx,
                          	  dma1_ch_dst_bus_inf_idx,
                             `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_llp,
                                `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  dma1_ch_lld_bus_inf_idx,
                                `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                             `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_abt,
                          	  dma1_ch_int_tc_mask,
                          	  dma1_ch_int_err_mask,
                          	  dma1_ch_int_abt_mask,
                             `ifdef DMAC_CONFIG_CH0
                          	  dma1_ch_0_ctl_wen,
                          	  dma1_ch_0_en_wen,
                          	  dma1_ch_0_src_addr_wen,
                          	  dma1_ch_0_dst_addr_wen,
                                `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_0_llp_wen,
                                `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_0_tts_wen,
                          	  dma1_ch_0_tc_wen,
                          	  dma1_ch_0_err_wen,
                          	  dma1_ch_0_int_wen,
                             `endif // DMAC_CONFIG_CH0
                             `ifdef DMAC_CONFIG_CH1
                          	  dma1_ch_1_ctl_wen,
                          	  dma1_ch_1_en_wen,
                          	  dma1_ch_1_src_addr_wen,
                          	  dma1_ch_1_dst_addr_wen,
                                `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_1_llp_wen,
                                `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_1_tts_wen,
                          	  dma1_ch_1_tc_wen,
                          	  dma1_ch_1_err_wen,
                          	  dma1_ch_1_int_wen,
                             `endif // DMAC_CONFIG_CH1
                             `ifdef DMAC_CONFIG_CH2
                          	  dma1_ch_2_ctl_wen,
                          	  dma1_ch_2_en_wen,
                          	  dma1_ch_2_src_addr_wen,
                          	  dma1_ch_2_dst_addr_wen,
                                `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_2_llp_wen,
                                `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_2_tts_wen,
                          	  dma1_ch_2_tc_wen,
                          	  dma1_ch_2_err_wen,
                          	  dma1_ch_2_int_wen,
                             `endif // DMAC_CONFIG_CH2
                             `ifdef DMAC_CONFIG_CH3
                          	  dma1_ch_3_ctl_wen,
                          	  dma1_ch_3_en_wen,
                          	  dma1_ch_3_src_addr_wen,
                          	  dma1_ch_3_dst_addr_wen,
                                `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_3_llp_wen,
                                `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_3_tts_wen,
                          	  dma1_ch_3_tc_wen,
                          	  dma1_ch_3_err_wen,
                          	  dma1_ch_3_int_wen,
                             `endif // DMAC_CONFIG_CH3
                             `ifdef DMAC_CONFIG_CH4
                          	  dma1_ch_4_ctl_wen,
                          	  dma1_ch_4_en_wen,
                          	  dma1_ch_4_src_addr_wen,
                          	  dma1_ch_4_dst_addr_wen,
                                `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_4_llp_wen,
                                `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_4_tts_wen,
                          	  dma1_ch_4_tc_wen,
                          	  dma1_ch_4_err_wen,
                          	  dma1_ch_4_int_wen,
                             `endif // DMAC_CONFIG_CH4
                             `ifdef DMAC_CONFIG_CH5
                          	  dma1_ch_5_ctl_wen,
                          	  dma1_ch_5_en_wen,
                          	  dma1_ch_5_src_addr_wen,
                          	  dma1_ch_5_dst_addr_wen,
                                `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_5_llp_wen,
                                `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_5_tts_wen,
                          	  dma1_ch_5_tc_wen,
                          	  dma1_ch_5_err_wen,
                          	  dma1_ch_5_int_wen,
                             `endif // DMAC_CONFIG_CH5
                             `ifdef DMAC_CONFIG_CH6
                          	  dma1_ch_6_ctl_wen,
                          	  dma1_ch_6_en_wen,
                          	  dma1_ch_6_src_addr_wen,
                          	  dma1_ch_6_dst_addr_wen,
                                `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_6_llp_wen,
                                `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_6_tts_wen,
                          	  dma1_ch_6_tc_wen,
                          	  dma1_ch_6_err_wen,
                          	  dma1_ch_6_int_wen,
                             `endif // DMAC_CONFIG_CH6
                             `ifdef DMAC_CONFIG_CH7
                          	  dma1_ch_7_ctl_wen,
                          	  dma1_ch_7_en_wen,
                          	  dma1_ch_7_src_addr_wen,
                          	  dma1_ch_7_dst_addr_wen,
                                `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_7_llp_wen,
                                `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_7_tts_wen,
                          	  dma1_ch_7_tc_wen,
                          	  dma1_ch_7_err_wen,
                          	  dma1_ch_7_int_wen,
                             `endif // DMAC_CONFIG_CH7
                          `endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                          	  dma0_idle_state,
                          	  dma0_ch_ctl_wen,
                          	  dma0_ch_en_wen,
                          	  dma0_ch_src_addr_wen,
                          	  dma0_ch_dst_addr_wen,
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_llp_wen,
                          `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_tts_wen,
                          	  dma0_ch_tc_wen,
                          	  dma0_ch_err_wen,
                          	  dma0_ch_int_wen,
                          	  dma0_ch_src_ack,
                          	  dma0_ch_dst_ack,
                          	  dma0_arb_end,
                          	  dma0_current_channel,
                          	  dma0_ch_src_addr_ctl,
                          	  dma0_ch_dst_addr_ctl,
                          	  dma0_ch_src_width,
                          	  dma0_ch_dst_width,
                          	  dma0_ch_src_burst_size,
                          	  dma0_ch_src_mode,
                          	  dma0_ch_src_request,
                          	  dma0_ch_dst_mode,
                          	  dma0_ch_dst_request,
                          	  dma0_ch_tts,
                          	  dma0_ch_src_addr,
                          	  dma0_ch_dst_addr,
                          `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  dma0_ch_src_bus_inf_idx,
                          	  dma0_ch_dst_bus_inf_idx,
                          `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_llp,
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  dma0_ch_lld_bus_inf_idx,
                             `endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          `endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_abt,
                          	  dma0_ch_int_tc_mask,
                          	  dma0_ch_int_err_mask,
                          	  dma0_ch_int_abt_mask 
                          // VPERL_GENERATED_END
);
localparam	ADDR_MSB	= `ATCDMAC300_ADDR_WIDTH - 1;
localparam	ADDR_WEN_MSB	= ADDR_MSB > 31 ? 1 : 0;

input					aclk;
input					aresetn;

input	[(`ATCDMAC300_REQ_ACK_NUM-1):0]	dma_req;	
output	[(`ATCDMAC300_REQ_ACK_NUM-1):0]	dma_ack;
reg	[(`ATCDMAC300_REQ_ACK_NUM-1):0]	dma_ack;

`ifdef ATCDMAC300_REQ_SYNC_SUPPORT
reg	[(`ATCDMAC300_REQ_ACK_NUM-1):0]	dma_req_sync1;
reg	[(`ATCDMAC300_REQ_ACK_NUM-1):0]	dma_req_sync2;
`endif

wire	[16:0]				dma_req_16b;
wire	[15:0]				dma_ack_nxt;

// Register File Interface
input					dma_soft_reset;
input					ch_0_en;
input					ch_0_int_tc_mask;
input					ch_0_int_err_mask;
input					ch_0_int_abt_mask;
input	[3:0]				ch_0_src_req_sel;
input	[3:0]				ch_0_dst_req_sel;
input	[1:0]				ch_0_src_addr_ctl;
input	[1:0]				ch_0_dst_addr_ctl;
input					ch_0_src_mode;
input					ch_0_dst_mode;
input 	[2:0]				ch_0_src_width;
input 	[2:0]				ch_0_dst_width;
input	[3:0]				ch_0_src_burst_size;
input					ch_0_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_0_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_0_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_0_src_bus_inf_idx;
input					ch_0_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH0
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_0_llp_reg;
        `endif // DMAC_CONFIG_CH0
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		`ifdef DMAC_CONFIG_CH0
input					ch_0_lld_bus_inf_idx;
                 `endif //DMAC_CONFIG_CH0
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_0_tts;
input					ch_0_abt;
input					ch_1_en;
input					ch_1_int_tc_mask;
input					ch_1_int_err_mask;
input					ch_1_int_abt_mask;
input	[3:0]				ch_1_src_req_sel;
input	[3:0]				ch_1_dst_req_sel;
input	[1:0]				ch_1_src_addr_ctl;
input	[1:0]				ch_1_dst_addr_ctl;
input					ch_1_src_mode;
input					ch_1_dst_mode;
input 	[2:0]				ch_1_src_width;
input 	[2:0]				ch_1_dst_width;
input	[3:0]				ch_1_src_burst_size;
input					ch_1_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_1_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_1_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_1_src_bus_inf_idx;
input					ch_1_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH1
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_1_llp_reg;
         `endif // DMAC_CONFIG_CH1
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		`ifdef DMAC_CONFIG_CH1
input					ch_1_lld_bus_inf_idx;
                `endif // DMAC_CONFIG_CH1
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_1_tts;
input					ch_1_abt;
input					ch_2_en;
input					ch_2_int_tc_mask;
input					ch_2_int_err_mask;
input					ch_2_int_abt_mask;
input	[3:0]				ch_2_src_req_sel;
input	[3:0]				ch_2_dst_req_sel;
input	[1:0]				ch_2_src_addr_ctl;
input	[1:0]				ch_2_dst_addr_ctl;
input					ch_2_src_mode;
input					ch_2_dst_mode;
input 	[2:0]				ch_2_src_width;
input 	[2:0]				ch_2_dst_width;
input	[3:0]				ch_2_src_burst_size;
input					ch_2_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_2_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_2_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_2_src_bus_inf_idx;
input					ch_2_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH2
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_2_llp_reg;
        `endif // DMAC_CONFIG_CH2
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		`ifdef DMAC_CONFIG_CH2
input					ch_2_lld_bus_inf_idx;
                 `endif // DMAC_CONFIG_CH2
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_2_tts;
input					ch_2_abt;
input					ch_3_en;
input					ch_3_int_tc_mask;
input					ch_3_int_err_mask;
input					ch_3_int_abt_mask;
input	[3:0]				ch_3_src_req_sel;
input	[3:0]				ch_3_dst_req_sel;
input	[1:0]				ch_3_src_addr_ctl;
input	[1:0]				ch_3_dst_addr_ctl;
input					ch_3_src_mode;
input					ch_3_dst_mode;
input 	[2:0]				ch_3_src_width;
input 	[2:0]				ch_3_dst_width;
input	[3:0]				ch_3_src_burst_size;
input					ch_3_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_3_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_3_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_3_src_bus_inf_idx;
input					ch_3_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH3
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_3_llp_reg;
         `endif // DMAC_CONFIG_CH3
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		`ifdef DMAC_CONFIG_CH3
input					ch_3_lld_bus_inf_idx;
                `endif //DMAC_CONFIG_CH3
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_3_tts;
input					ch_3_abt;
input					ch_4_en;
input					ch_4_int_tc_mask;
input					ch_4_int_err_mask;
input					ch_4_int_abt_mask;
input	[3:0]				ch_4_src_req_sel;
input	[3:0]				ch_4_dst_req_sel;
input	[1:0]				ch_4_src_addr_ctl;
input	[1:0]				ch_4_dst_addr_ctl;
input					ch_4_src_mode;
input					ch_4_dst_mode;
input 	[2:0]				ch_4_src_width;
input 	[2:0]				ch_4_dst_width;
input	[3:0]				ch_4_src_burst_size;
input					ch_4_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_4_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_4_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_4_src_bus_inf_idx;
input					ch_4_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH4
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_4_llp_reg;
        `endif //DMAC_CONFIG_CH4
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		`ifdef DMAC_CONFIG_CH4
input					ch_4_lld_bus_inf_idx;
                `endif // DMAC_CONFIG_CH4
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_4_tts;
input					ch_4_abt;
input					ch_5_en;
input					ch_5_int_tc_mask;
input					ch_5_int_err_mask;
input					ch_5_int_abt_mask;
input	[3:0]				ch_5_src_req_sel;
input	[3:0]				ch_5_dst_req_sel;
input	[1:0]				ch_5_src_addr_ctl;
input	[1:0]				ch_5_dst_addr_ctl;
input					ch_5_src_mode;
input					ch_5_dst_mode;
input 	[2:0]				ch_5_src_width;
input 	[2:0]				ch_5_dst_width;
input	[3:0]				ch_5_src_burst_size;
input					ch_5_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_5_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_5_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_5_src_bus_inf_idx;
input					ch_5_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH5
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_5_llp_reg;
         `endif // DMAC_CONFIG_CH5
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		`ifdef DMAC_CONFIG_CH5
input					ch_5_lld_bus_inf_idx;
                `endif // DMAC_CONFIG_CH5
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_5_tts;
input					ch_5_abt;
input					ch_6_en;
input					ch_6_int_tc_mask;
input					ch_6_int_err_mask;
input					ch_6_int_abt_mask;
input	[3:0]				ch_6_src_req_sel;
input	[3:0]				ch_6_dst_req_sel;
input	[1:0]				ch_6_src_addr_ctl;
input	[1:0]				ch_6_dst_addr_ctl;
input					ch_6_src_mode;
input					ch_6_dst_mode;
input 	[2:0]				ch_6_src_width;
input 	[2:0]				ch_6_dst_width;
input	[3:0]				ch_6_src_burst_size;
input					ch_6_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_6_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_6_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_6_src_bus_inf_idx;
input					ch_6_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH6
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_6_llp_reg;
         `endif // DMAC_CONFIG_CH6
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		`ifdef DMAC_CONFIG_CH6
input					ch_6_lld_bus_inf_idx;
                `endif // DMAC_CONFIG_CH6
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_6_tts;
input					ch_6_abt;
input					ch_7_en;
input					ch_7_int_tc_mask;
input					ch_7_int_err_mask;
input					ch_7_int_abt_mask;
input	[3:0]				ch_7_src_req_sel;
input	[3:0]				ch_7_dst_req_sel;
input	[1:0]				ch_7_src_addr_ctl;
input	[1:0]				ch_7_dst_addr_ctl;
input					ch_7_src_mode;
input					ch_7_dst_mode;
input 	[2:0]				ch_7_src_width;
input 	[2:0]				ch_7_dst_width;
input	[3:0]				ch_7_src_burst_size;
input					ch_7_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_7_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_7_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_7_src_bus_inf_idx;
input					ch_7_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef DMAC_CONFIG_CH7
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_7_llp_reg;
        `endif // DMAC_CONFIG_CH7
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		`ifdef DMAC_CONFIG_CH7
input					ch_7_lld_bus_inf_idx;
                `endif // DMAC_CONFIG_CH7
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_7_tts;
input					ch_7_abt;

wire					dma0_ch_0_selected;
wire					dma0_ch_1_selected;
wire					dma0_ch_2_selected;
wire					dma0_ch_3_selected;
wire					dma0_ch_4_selected;
wire					dma0_ch_5_selected;
wire					dma0_ch_6_selected;
wire					dma0_ch_7_selected;

`ifdef DMAC_CONFIG_CH0 
output					dma0_ch_0_ctl_wen;
output					dma0_ch_0_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_0_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_0_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_0_llp_wen;
	`endif
output					dma0_ch_0_tts_wen;
output					dma0_ch_0_tc_wen;
output					dma0_ch_0_err_wen;
output					dma0_ch_0_int_wen;
`endif
`ifdef DMAC_CONFIG_CH1 
output					dma0_ch_1_ctl_wen;
output					dma0_ch_1_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_1_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_1_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_1_llp_wen;
	`endif
output					dma0_ch_1_tts_wen;
output					dma0_ch_1_tc_wen;
output					dma0_ch_1_err_wen;
output					dma0_ch_1_int_wen;
`endif
`ifdef DMAC_CONFIG_CH2 
output					dma0_ch_2_ctl_wen;
output					dma0_ch_2_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_2_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_2_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_2_llp_wen;
	`endif
output					dma0_ch_2_tts_wen;
output					dma0_ch_2_tc_wen;
output					dma0_ch_2_err_wen;
output					dma0_ch_2_int_wen;
`endif
`ifdef DMAC_CONFIG_CH3 
output					dma0_ch_3_ctl_wen;
output					dma0_ch_3_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_3_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_3_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_3_llp_wen;
	`endif
output					dma0_ch_3_tts_wen;
output					dma0_ch_3_tc_wen;
output					dma0_ch_3_err_wen;
output					dma0_ch_3_int_wen;
`endif
`ifdef DMAC_CONFIG_CH4 
output					dma0_ch_4_ctl_wen;
output					dma0_ch_4_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_4_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_4_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_4_llp_wen;
	`endif
output					dma0_ch_4_tts_wen;
output					dma0_ch_4_tc_wen;
output					dma0_ch_4_err_wen;
output					dma0_ch_4_int_wen;
`endif
`ifdef DMAC_CONFIG_CH5 
output					dma0_ch_5_ctl_wen;
output					dma0_ch_5_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_5_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_5_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_5_llp_wen;
	`endif
output					dma0_ch_5_tts_wen;
output					dma0_ch_5_tc_wen;
output					dma0_ch_5_err_wen;
output					dma0_ch_5_int_wen;
`endif
`ifdef DMAC_CONFIG_CH6 
output					dma0_ch_6_ctl_wen;
output					dma0_ch_6_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_6_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_6_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_6_llp_wen;
	`endif
output					dma0_ch_6_tts_wen;
output					dma0_ch_6_tc_wen;
output					dma0_ch_6_err_wen;
output					dma0_ch_6_int_wen;
`endif
`ifdef DMAC_CONFIG_CH7 
output					dma0_ch_7_ctl_wen;
output					dma0_ch_7_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_7_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_7_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_7_llp_wen;
	`endif
output					dma0_ch_7_tts_wen;
output					dma0_ch_7_tc_wen;
output					dma0_ch_7_err_wen;
output					dma0_ch_7_int_wen;
`endif

// Arbiter Interface
input	[2:0]	granted_channel;
output	[7:0]	ch_request;	
output	[7:0]	ch_level;
output	[2:0]	current_channel;

// DMA Engine Interface

`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
input					dma1_idle_state;
input					dma1_ch_ctl_wen;
input					dma1_ch_en_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma1_ch_llp_wen;
	`endif
input					dma1_ch_tts_wen;
input					dma1_ch_tc_wen;
input					dma1_ch_err_wen;
input					dma1_ch_int_wen;
input					dma1_ch_src_ack;
input					dma1_ch_dst_ack;

output					dma1_arb_end;
output	[2:0]				dma1_current_channel;
output	[1:0]				dma1_ch_src_addr_ctl;
output	[1:0]				dma1_ch_dst_addr_ctl;
output	[2:0]				dma1_ch_src_width;
output	[2:0]				dma1_ch_dst_width;
output	[3:0]				dma1_ch_src_burst_size;
output					dma1_ch_src_mode;
output					dma1_ch_src_request;
output					dma1_ch_dst_mode;
output					dma1_ch_dst_request;
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma1_ch_tts;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma1_ch_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma1_ch_dst_addr;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma1_ch_src_bus_inf_idx;
output					dma1_ch_dst_bus_inf_idx;
	`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma1_ch_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma1_ch_lld_bus_inf_idx;
		`endif
	`endif
output					dma1_ch_abt;
output					dma1_ch_int_tc_mask;
output					dma1_ch_int_err_mask;
output					dma1_ch_int_abt_mask;
wire					dma1_arb_en;
reg					dma1_arb_end;
reg	[1:0]				dma1_ch_src_addr_ctl;
reg	[1:0]				dma1_ch_dst_addr_ctl;
reg	[2:0]				dma1_ch_src_width;
reg	[2:0]				dma1_ch_dst_width;
reg	[3:0]				dma1_ch_src_burst_size;
reg					dma1_ch_src_mode;
reg					dma1_ch_src_request;
reg					dma1_ch_dst_mode;
reg					dma1_ch_dst_request;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma1_ch_tts;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma1_ch_src_addr;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma1_ch_dst_addr;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					dma1_ch_src_bus_inf_idx;
reg					dma1_ch_dst_bus_inf_idx;
	`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma1_ch_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					dma1_ch_lld_bus_inf_idx;
		`endif
	`endif
reg					dma1_ch_int_tc_mask;
reg					dma1_ch_int_err_mask;
reg					dma1_ch_int_abt_mask;
reg					dma1_ch_abt;
reg	[2:0]				dma1_current_channel;
wire	[2:0]				dma1_current_channel_nxt;
wire					dma1_ch_0_selected;
wire					dma1_ch_1_selected;
wire					dma1_ch_2_selected;
wire					dma1_ch_3_selected;
wire					dma1_ch_4_selected;
wire					dma1_ch_5_selected;
wire					dma1_ch_6_selected;
wire					dma1_ch_7_selected;
	`ifdef DMAC_CONFIG_CH0 
output					dma1_ch_0_ctl_wen;
output					dma1_ch_0_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_0_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_0_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_0_llp_wen;
		`endif
output					dma1_ch_0_tts_wen;
output					dma1_ch_0_tc_wen;
output					dma1_ch_0_err_wen;
output					dma1_ch_0_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH1 
output					dma1_ch_1_ctl_wen;
output					dma1_ch_1_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_1_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_1_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_1_llp_wen;
		`endif
output					dma1_ch_1_tts_wen;
output					dma1_ch_1_tc_wen;
output					dma1_ch_1_err_wen;
output					dma1_ch_1_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH2 
output					dma1_ch_2_ctl_wen;
output					dma1_ch_2_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_2_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_2_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_2_llp_wen;
		`endif
output					dma1_ch_2_tts_wen;
output					dma1_ch_2_tc_wen;
output					dma1_ch_2_err_wen;
output					dma1_ch_2_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH3 
output					dma1_ch_3_ctl_wen;
output					dma1_ch_3_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_3_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_3_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_3_llp_wen;
		`endif
output					dma1_ch_3_tts_wen;
output					dma1_ch_3_tc_wen;
output					dma1_ch_3_err_wen;
output					dma1_ch_3_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH4 
output					dma1_ch_4_ctl_wen;
output					dma1_ch_4_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_4_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_4_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_4_llp_wen;
		`endif
output					dma1_ch_4_tts_wen;
output					dma1_ch_4_tc_wen;
output					dma1_ch_4_err_wen;
output					dma1_ch_4_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH5 
output					dma1_ch_5_ctl_wen;
output					dma1_ch_5_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_5_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_5_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_5_llp_wen;
		`endif
output					dma1_ch_5_tts_wen;
output					dma1_ch_5_tc_wen;
output					dma1_ch_5_err_wen;
output					dma1_ch_5_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH6 
output					dma1_ch_6_ctl_wen;
output					dma1_ch_6_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_6_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_6_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_6_llp_wen;
		`endif
output					dma1_ch_6_tts_wen;
output					dma1_ch_6_tc_wen;
output					dma1_ch_6_err_wen;
output					dma1_ch_6_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH7 
output					dma1_ch_7_ctl_wen;
output					dma1_ch_7_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_7_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_7_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_7_llp_wen;
		`endif
output					dma1_ch_7_tts_wen;
output					dma1_ch_7_tc_wen;
output					dma1_ch_7_err_wen;
output					dma1_ch_7_int_wen;
	`endif
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT

input					dma0_idle_state;
input					dma0_ch_ctl_wen;
input					dma0_ch_en_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_dst_addr_wen;
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma0_ch_llp_wen;
`endif
input					dma0_ch_tts_wen;
input					dma0_ch_tc_wen;
input					dma0_ch_err_wen;
input					dma0_ch_int_wen;
input					dma0_ch_src_ack;
input					dma0_ch_dst_ack;

output					dma0_arb_end;
output	[2:0]				dma0_current_channel;
output	[1:0]				dma0_ch_src_addr_ctl;
output	[1:0]				dma0_ch_dst_addr_ctl;
output	[2:0]				dma0_ch_src_width;
output	[2:0]				dma0_ch_dst_width;
output	[3:0]				dma0_ch_src_burst_size;
output					dma0_ch_src_mode;
output					dma0_ch_src_request;
output					dma0_ch_dst_mode;
output					dma0_ch_dst_request;
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma0_ch_tts;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma0_ch_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma0_ch_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma0_ch_src_bus_inf_idx;
output					dma0_ch_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma0_ch_llp;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma0_ch_lld_bus_inf_idx;
	`endif
`endif
output					dma0_ch_abt;
output					dma0_ch_int_tc_mask;
output					dma0_ch_int_err_mask;
output					dma0_ch_int_abt_mask;
wire					dma0_arb_en;
reg					dma0_arb_end;
reg	[1:0]				dma0_ch_src_addr_ctl;
reg	[1:0]				dma0_ch_dst_addr_ctl;
reg	[2:0]				dma0_ch_src_width;
reg	[2:0]				dma0_ch_dst_width;
reg	[3:0]				dma0_ch_src_burst_size;
reg					dma0_ch_src_mode;
reg					dma0_ch_src_request;
reg					dma0_ch_dst_mode;
reg					dma0_ch_dst_request;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma0_ch_tts;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma0_ch_src_addr;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma0_ch_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					dma0_ch_src_bus_inf_idx;
reg					dma0_ch_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma0_ch_llp;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					dma0_ch_lld_bus_inf_idx;
	`endif
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
wire	[7:0]				dma0_ch_request;
wire	[7:0]				dma1_ch_request;
wire	[7:0]				dma0_ch_request_mask;
wire	[7:0]				dma1_ch_request_mask;
wire					grant_dma1_arb_nx;
reg					grant_dma1_arb;
`else
wire					grant_dma1_arb = 1'b0;
wire	[7:0]				dma0_ch_request = ch_request;
`endif

reg					dma0_ch_int_tc_mask;
reg					dma0_ch_int_err_mask;
reg					dma0_ch_int_abt_mask;
reg					dma0_ch_abt;
reg	[2:0]				dma0_current_channel;
wire	[2:0]				dma0_current_channel_nxt;


`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT

`ifndef DMAC_CONFIG_CH0
wire [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_0_llp_reg = {`ATCDMAC300_ADDR_WIDTH-3{1'b0}};
`endif

`ifndef DMAC_CONFIG_CH1
wire [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_1_llp_reg = {`ATCDMAC300_ADDR_WIDTH-3{1'b0}};
`endif

`ifndef DMAC_CONFIG_CH2
wire [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_2_llp_reg = {`ATCDMAC300_ADDR_WIDTH-3{1'b0}};
`endif

`ifndef DMAC_CONFIG_CH3
wire [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_3_llp_reg ={`ATCDMAC300_ADDR_WIDTH-3{1'b0}}; 
`endif


`ifndef DMAC_CONFIG_CH4
wire [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_4_llp_reg = {`ATCDMAC300_ADDR_WIDTH-3{1'b0}};
`endif

`ifndef DMAC_CONFIG_CH5
wire [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_5_llp_reg = {`ATCDMAC300_ADDR_WIDTH-3{1'b0}};
`endif

`ifndef DMAC_CONFIG_CH6
wire [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_6_llp_reg = {`ATCDMAC300_ADDR_WIDTH-3{1'b0}};
`endif

`ifndef DMAC_CONFIG_CH7
wire [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_7_llp_reg = {`ATCDMAC300_ADDR_WIDTH-3{1'b0}}; 
`endif

`endif // ATCDMAC300_CHAIN_TRANSFER_SUPPORT


//VPERL_BEGIN
// my $ch_num = 8;
// for ($i=0; $i<$ch_num; $i++) {
// :`ifdef DMAC_CONFIG_CH${i}
// :assign dma0_ch_${i}_selected	= (dma0_current_channel == 3'h${i});
// :assign dma0_ch_${i}_ctl_wen	= dma0_ch_ctl_wen	&& dma0_ch_${i}_selected;
// :assign dma0_ch_${i}_en_wen		= dma0_ch_en_wen	&& dma0_ch_${i}_selected;
// :assign dma0_ch_${i}_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_${i}_selected}};
// :assign dma0_ch_${i}_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_${i}_selected}};
// :`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
// :assign dma0_ch_${i}_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{dma0_ch_${i}_selected}};
// :`endif
// :assign dma0_ch_${i}_tts_wen	= dma0_ch_tts_wen	&& dma0_ch_${i}_selected;
// :assign dma0_ch_${i}_tc_wen		= dma0_ch_tc_wen	&& dma0_ch_${i}_selected;
// :assign dma0_ch_${i}_err_wen	= dma0_ch_err_wen	&& dma0_ch_${i}_selected;
// :assign dma0_ch_${i}_int_wen	= dma0_ch_int_wen	&& dma0_ch_${i}_selected;
// :`else
// :assign dma0_ch_${i}_selected	= 1'b0;
// :`endif //DMAC_CONFIG_CH${i}
// :`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
// :	`ifdef DMAC_CONFIG_CH${i}
// :assign dma1_ch_${i}_selected	= (dma1_current_channel == 3'h${i});
// :assign dma1_ch_${i}_ctl_wen	= dma1_ch_ctl_wen	&& dma1_ch_${i}_selected;
// :assign dma1_ch_${i}_en_wen		= dma1_ch_en_wen	&& dma1_ch_${i}_selected;
// :assign dma1_ch_${i}_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_${i}_selected}};
// :assign dma1_ch_${i}_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_${i}_selected}};
// :		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
// :assign dma1_ch_${i}_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{dma1_ch_${i}_selected}};
// :		`endif
// :assign dma1_ch_${i}_tts_wen	= dma1_ch_tts_wen 	&& dma1_ch_${i}_selected;
// :assign dma1_ch_${i}_tc_wen		= dma1_ch_tc_wen	&& dma1_ch_${i}_selected;
// :assign dma1_ch_${i}_err_wen	= dma1_ch_err_wen	&& dma1_ch_${i}_selected;
// :assign dma1_ch_${i}_int_wen	= dma1_ch_int_wen	&& dma1_ch_${i}_selected;
// :	`else
// :assign dma1_ch_${i}_selected	= 1'b0;
// :	`endif //DMAC_CONFIG_CH${i}
// :`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
// 
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef DMAC_CONFIG_CH0
assign dma0_ch_0_selected	= (dma0_current_channel == 3'h0);
assign dma0_ch_0_ctl_wen	= dma0_ch_ctl_wen	&& dma0_ch_0_selected;
assign dma0_ch_0_en_wen		= dma0_ch_en_wen	&& dma0_ch_0_selected;
assign dma0_ch_0_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_0_selected}};
assign dma0_ch_0_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_0_selected}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_0_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{dma0_ch_0_selected}};
`endif
assign dma0_ch_0_tts_wen	= dma0_ch_tts_wen	&& dma0_ch_0_selected;
assign dma0_ch_0_tc_wen		= dma0_ch_tc_wen	&& dma0_ch_0_selected;
assign dma0_ch_0_err_wen	= dma0_ch_err_wen	&& dma0_ch_0_selected;
assign dma0_ch_0_int_wen	= dma0_ch_int_wen	&& dma0_ch_0_selected;
`else
assign dma0_ch_0_selected	= 1'b0;
`endif //DMAC_CONFIG_CH0
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH0
assign dma1_ch_0_selected	= (dma1_current_channel == 3'h0);
assign dma1_ch_0_ctl_wen	= dma1_ch_ctl_wen	&& dma1_ch_0_selected;
assign dma1_ch_0_en_wen		= dma1_ch_en_wen	&& dma1_ch_0_selected;
assign dma1_ch_0_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_0_selected}};
assign dma1_ch_0_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_0_selected}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_0_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{dma1_ch_0_selected}};
		`endif
assign dma1_ch_0_tts_wen	= dma1_ch_tts_wen 	&& dma1_ch_0_selected;
assign dma1_ch_0_tc_wen		= dma1_ch_tc_wen	&& dma1_ch_0_selected;
assign dma1_ch_0_err_wen	= dma1_ch_err_wen	&& dma1_ch_0_selected;
assign dma1_ch_0_int_wen	= dma1_ch_int_wen	&& dma1_ch_0_selected;
	`else
assign dma1_ch_0_selected	= 1'b0;
	`endif //DMAC_CONFIG_CH0
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
`ifdef DMAC_CONFIG_CH1
assign dma0_ch_1_selected	= (dma0_current_channel == 3'h1);
assign dma0_ch_1_ctl_wen	= dma0_ch_ctl_wen	&& dma0_ch_1_selected;
assign dma0_ch_1_en_wen		= dma0_ch_en_wen	&& dma0_ch_1_selected;
assign dma0_ch_1_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_1_selected}};
assign dma0_ch_1_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_1_selected}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_1_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{dma0_ch_1_selected}};
`endif
assign dma0_ch_1_tts_wen	= dma0_ch_tts_wen	&& dma0_ch_1_selected;
assign dma0_ch_1_tc_wen		= dma0_ch_tc_wen	&& dma0_ch_1_selected;
assign dma0_ch_1_err_wen	= dma0_ch_err_wen	&& dma0_ch_1_selected;
assign dma0_ch_1_int_wen	= dma0_ch_int_wen	&& dma0_ch_1_selected;
`else
assign dma0_ch_1_selected	= 1'b0;
`endif //DMAC_CONFIG_CH1
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH1
assign dma1_ch_1_selected	= (dma1_current_channel == 3'h1);
assign dma1_ch_1_ctl_wen	= dma1_ch_ctl_wen	&& dma1_ch_1_selected;
assign dma1_ch_1_en_wen		= dma1_ch_en_wen	&& dma1_ch_1_selected;
assign dma1_ch_1_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_1_selected}};
assign dma1_ch_1_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_1_selected}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_1_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{dma1_ch_1_selected}};
		`endif
assign dma1_ch_1_tts_wen	= dma1_ch_tts_wen 	&& dma1_ch_1_selected;
assign dma1_ch_1_tc_wen		= dma1_ch_tc_wen	&& dma1_ch_1_selected;
assign dma1_ch_1_err_wen	= dma1_ch_err_wen	&& dma1_ch_1_selected;
assign dma1_ch_1_int_wen	= dma1_ch_int_wen	&& dma1_ch_1_selected;
	`else
assign dma1_ch_1_selected	= 1'b0;
	`endif //DMAC_CONFIG_CH1
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
`ifdef DMAC_CONFIG_CH2
assign dma0_ch_2_selected	= (dma0_current_channel == 3'h2);
assign dma0_ch_2_ctl_wen	= dma0_ch_ctl_wen	&& dma0_ch_2_selected;
assign dma0_ch_2_en_wen		= dma0_ch_en_wen	&& dma0_ch_2_selected;
assign dma0_ch_2_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_2_selected}};
assign dma0_ch_2_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_2_selected}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_2_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{dma0_ch_2_selected}};
`endif
assign dma0_ch_2_tts_wen	= dma0_ch_tts_wen	&& dma0_ch_2_selected;
assign dma0_ch_2_tc_wen		= dma0_ch_tc_wen	&& dma0_ch_2_selected;
assign dma0_ch_2_err_wen	= dma0_ch_err_wen	&& dma0_ch_2_selected;
assign dma0_ch_2_int_wen	= dma0_ch_int_wen	&& dma0_ch_2_selected;
`else
assign dma0_ch_2_selected	= 1'b0;
`endif //DMAC_CONFIG_CH2
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH2
assign dma1_ch_2_selected	= (dma1_current_channel == 3'h2);
assign dma1_ch_2_ctl_wen	= dma1_ch_ctl_wen	&& dma1_ch_2_selected;
assign dma1_ch_2_en_wen		= dma1_ch_en_wen	&& dma1_ch_2_selected;
assign dma1_ch_2_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_2_selected}};
assign dma1_ch_2_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_2_selected}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_2_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{dma1_ch_2_selected}};
		`endif
assign dma1_ch_2_tts_wen	= dma1_ch_tts_wen 	&& dma1_ch_2_selected;
assign dma1_ch_2_tc_wen		= dma1_ch_tc_wen	&& dma1_ch_2_selected;
assign dma1_ch_2_err_wen	= dma1_ch_err_wen	&& dma1_ch_2_selected;
assign dma1_ch_2_int_wen	= dma1_ch_int_wen	&& dma1_ch_2_selected;
	`else
assign dma1_ch_2_selected	= 1'b0;
	`endif //DMAC_CONFIG_CH2
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
`ifdef DMAC_CONFIG_CH3
assign dma0_ch_3_selected	= (dma0_current_channel == 3'h3);
assign dma0_ch_3_ctl_wen	= dma0_ch_ctl_wen	&& dma0_ch_3_selected;
assign dma0_ch_3_en_wen		= dma0_ch_en_wen	&& dma0_ch_3_selected;
assign dma0_ch_3_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_3_selected}};
assign dma0_ch_3_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_3_selected}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_3_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{dma0_ch_3_selected}};
`endif
assign dma0_ch_3_tts_wen	= dma0_ch_tts_wen	&& dma0_ch_3_selected;
assign dma0_ch_3_tc_wen		= dma0_ch_tc_wen	&& dma0_ch_3_selected;
assign dma0_ch_3_err_wen	= dma0_ch_err_wen	&& dma0_ch_3_selected;
assign dma0_ch_3_int_wen	= dma0_ch_int_wen	&& dma0_ch_3_selected;
`else
assign dma0_ch_3_selected	= 1'b0;
`endif //DMAC_CONFIG_CH3
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH3
assign dma1_ch_3_selected	= (dma1_current_channel == 3'h3);
assign dma1_ch_3_ctl_wen	= dma1_ch_ctl_wen	&& dma1_ch_3_selected;
assign dma1_ch_3_en_wen		= dma1_ch_en_wen	&& dma1_ch_3_selected;
assign dma1_ch_3_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_3_selected}};
assign dma1_ch_3_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_3_selected}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_3_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{dma1_ch_3_selected}};
		`endif
assign dma1_ch_3_tts_wen	= dma1_ch_tts_wen 	&& dma1_ch_3_selected;
assign dma1_ch_3_tc_wen		= dma1_ch_tc_wen	&& dma1_ch_3_selected;
assign dma1_ch_3_err_wen	= dma1_ch_err_wen	&& dma1_ch_3_selected;
assign dma1_ch_3_int_wen	= dma1_ch_int_wen	&& dma1_ch_3_selected;
	`else
assign dma1_ch_3_selected	= 1'b0;
	`endif //DMAC_CONFIG_CH3
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
`ifdef DMAC_CONFIG_CH4
assign dma0_ch_4_selected	= (dma0_current_channel == 3'h4);
assign dma0_ch_4_ctl_wen	= dma0_ch_ctl_wen	&& dma0_ch_4_selected;
assign dma0_ch_4_en_wen		= dma0_ch_en_wen	&& dma0_ch_4_selected;
assign dma0_ch_4_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_4_selected}};
assign dma0_ch_4_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_4_selected}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_4_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{dma0_ch_4_selected}};
`endif
assign dma0_ch_4_tts_wen	= dma0_ch_tts_wen	&& dma0_ch_4_selected;
assign dma0_ch_4_tc_wen		= dma0_ch_tc_wen	&& dma0_ch_4_selected;
assign dma0_ch_4_err_wen	= dma0_ch_err_wen	&& dma0_ch_4_selected;
assign dma0_ch_4_int_wen	= dma0_ch_int_wen	&& dma0_ch_4_selected;
`else
assign dma0_ch_4_selected	= 1'b0;
`endif //DMAC_CONFIG_CH4
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH4
assign dma1_ch_4_selected	= (dma1_current_channel == 3'h4);
assign dma1_ch_4_ctl_wen	= dma1_ch_ctl_wen	&& dma1_ch_4_selected;
assign dma1_ch_4_en_wen		= dma1_ch_en_wen	&& dma1_ch_4_selected;
assign dma1_ch_4_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_4_selected}};
assign dma1_ch_4_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_4_selected}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_4_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{dma1_ch_4_selected}};
		`endif
assign dma1_ch_4_tts_wen	= dma1_ch_tts_wen 	&& dma1_ch_4_selected;
assign dma1_ch_4_tc_wen		= dma1_ch_tc_wen	&& dma1_ch_4_selected;
assign dma1_ch_4_err_wen	= dma1_ch_err_wen	&& dma1_ch_4_selected;
assign dma1_ch_4_int_wen	= dma1_ch_int_wen	&& dma1_ch_4_selected;
	`else
assign dma1_ch_4_selected	= 1'b0;
	`endif //DMAC_CONFIG_CH4
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
`ifdef DMAC_CONFIG_CH5
assign dma0_ch_5_selected	= (dma0_current_channel == 3'h5);
assign dma0_ch_5_ctl_wen	= dma0_ch_ctl_wen	&& dma0_ch_5_selected;
assign dma0_ch_5_en_wen		= dma0_ch_en_wen	&& dma0_ch_5_selected;
assign dma0_ch_5_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_5_selected}};
assign dma0_ch_5_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_5_selected}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_5_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{dma0_ch_5_selected}};
`endif
assign dma0_ch_5_tts_wen	= dma0_ch_tts_wen	&& dma0_ch_5_selected;
assign dma0_ch_5_tc_wen		= dma0_ch_tc_wen	&& dma0_ch_5_selected;
assign dma0_ch_5_err_wen	= dma0_ch_err_wen	&& dma0_ch_5_selected;
assign dma0_ch_5_int_wen	= dma0_ch_int_wen	&& dma0_ch_5_selected;
`else
assign dma0_ch_5_selected	= 1'b0;
`endif //DMAC_CONFIG_CH5
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH5
assign dma1_ch_5_selected	= (dma1_current_channel == 3'h5);
assign dma1_ch_5_ctl_wen	= dma1_ch_ctl_wen	&& dma1_ch_5_selected;
assign dma1_ch_5_en_wen		= dma1_ch_en_wen	&& dma1_ch_5_selected;
assign dma1_ch_5_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_5_selected}};
assign dma1_ch_5_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_5_selected}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_5_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{dma1_ch_5_selected}};
		`endif
assign dma1_ch_5_tts_wen	= dma1_ch_tts_wen 	&& dma1_ch_5_selected;
assign dma1_ch_5_tc_wen		= dma1_ch_tc_wen	&& dma1_ch_5_selected;
assign dma1_ch_5_err_wen	= dma1_ch_err_wen	&& dma1_ch_5_selected;
assign dma1_ch_5_int_wen	= dma1_ch_int_wen	&& dma1_ch_5_selected;
	`else
assign dma1_ch_5_selected	= 1'b0;
	`endif //DMAC_CONFIG_CH5
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
`ifdef DMAC_CONFIG_CH6
assign dma0_ch_6_selected	= (dma0_current_channel == 3'h6);
assign dma0_ch_6_ctl_wen	= dma0_ch_ctl_wen	&& dma0_ch_6_selected;
assign dma0_ch_6_en_wen		= dma0_ch_en_wen	&& dma0_ch_6_selected;
assign dma0_ch_6_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_6_selected}};
assign dma0_ch_6_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_6_selected}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_6_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{dma0_ch_6_selected}};
`endif
assign dma0_ch_6_tts_wen	= dma0_ch_tts_wen	&& dma0_ch_6_selected;
assign dma0_ch_6_tc_wen		= dma0_ch_tc_wen	&& dma0_ch_6_selected;
assign dma0_ch_6_err_wen	= dma0_ch_err_wen	&& dma0_ch_6_selected;
assign dma0_ch_6_int_wen	= dma0_ch_int_wen	&& dma0_ch_6_selected;
`else
assign dma0_ch_6_selected	= 1'b0;
`endif //DMAC_CONFIG_CH6
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH6
assign dma1_ch_6_selected	= (dma1_current_channel == 3'h6);
assign dma1_ch_6_ctl_wen	= dma1_ch_ctl_wen	&& dma1_ch_6_selected;
assign dma1_ch_6_en_wen		= dma1_ch_en_wen	&& dma1_ch_6_selected;
assign dma1_ch_6_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_6_selected}};
assign dma1_ch_6_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_6_selected}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_6_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{dma1_ch_6_selected}};
		`endif
assign dma1_ch_6_tts_wen	= dma1_ch_tts_wen 	&& dma1_ch_6_selected;
assign dma1_ch_6_tc_wen		= dma1_ch_tc_wen	&& dma1_ch_6_selected;
assign dma1_ch_6_err_wen	= dma1_ch_err_wen	&& dma1_ch_6_selected;
assign dma1_ch_6_int_wen	= dma1_ch_int_wen	&& dma1_ch_6_selected;
	`else
assign dma1_ch_6_selected	= 1'b0;
	`endif //DMAC_CONFIG_CH6
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
`ifdef DMAC_CONFIG_CH7
assign dma0_ch_7_selected	= (dma0_current_channel == 3'h7);
assign dma0_ch_7_ctl_wen	= dma0_ch_ctl_wen	&& dma0_ch_7_selected;
assign dma0_ch_7_en_wen		= dma0_ch_en_wen	&& dma0_ch_7_selected;
assign dma0_ch_7_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_7_selected}};
assign dma0_ch_7_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma0_ch_7_selected}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_7_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{dma0_ch_7_selected}};
`endif
assign dma0_ch_7_tts_wen	= dma0_ch_tts_wen	&& dma0_ch_7_selected;
assign dma0_ch_7_tc_wen		= dma0_ch_tc_wen	&& dma0_ch_7_selected;
assign dma0_ch_7_err_wen	= dma0_ch_err_wen	&& dma0_ch_7_selected;
assign dma0_ch_7_int_wen	= dma0_ch_int_wen	&& dma0_ch_7_selected;
`else
assign dma0_ch_7_selected	= 1'b0;
`endif //DMAC_CONFIG_CH7
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH7
assign dma1_ch_7_selected	= (dma1_current_channel == 3'h7);
assign dma1_ch_7_ctl_wen	= dma1_ch_ctl_wen	&& dma1_ch_7_selected;
assign dma1_ch_7_en_wen		= dma1_ch_en_wen	&& dma1_ch_7_selected;
assign dma1_ch_7_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_7_selected}};
assign dma1_ch_7_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{dma1_ch_7_selected}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_7_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{dma1_ch_7_selected}};
		`endif
assign dma1_ch_7_tts_wen	= dma1_ch_tts_wen 	&& dma1_ch_7_selected;
assign dma1_ch_7_tc_wen		= dma1_ch_tc_wen	&& dma1_ch_7_selected;
assign dma1_ch_7_err_wen	= dma1_ch_err_wen	&& dma1_ch_7_selected;
assign dma1_ch_7_int_wen	= dma1_ch_int_wen	&& dma1_ch_7_selected;
	`else
assign dma1_ch_7_selected	= 1'b0;
	`endif //DMAC_CONFIG_CH7
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
// VPERL_GENERATED_END

//VPERL_BEGIN
// my $ch_num = 8;
// for ($i=0; $i<$ch_num; $i++) {
// ://source request
// :reg ch_${i}_src_request;
// :always @(*) begin
// :	case(ch_${i}_src_req_sel)
// :		4'h1:	ch_${i}_src_request = dma_req_16b[1];
// :		4'h2:	ch_${i}_src_request = dma_req_16b[2];
// :		4'h3:	ch_${i}_src_request = dma_req_16b[3];
// :		4'h4:	ch_${i}_src_request = dma_req_16b[4];
// :		4'h5:	ch_${i}_src_request = dma_req_16b[5];
// :		4'h6:	ch_${i}_src_request = dma_req_16b[6];
// :		4'h7:	ch_${i}_src_request = dma_req_16b[7];
// :		4'h8:	ch_${i}_src_request = dma_req_16b[8];
// :		4'h9:	ch_${i}_src_request = dma_req_16b[9];
// :		4'ha:	ch_${i}_src_request = dma_req_16b[10];
// :		4'hb:	ch_${i}_src_request = dma_req_16b[11];
// :		4'hc:	ch_${i}_src_request = dma_req_16b[12];
// :		4'hd:	ch_${i}_src_request = dma_req_16b[13];
// :		4'he:	ch_${i}_src_request = dma_req_16b[14];
// :		4'hf:	ch_${i}_src_request = dma_req_16b[15];
// :		default: ch_${i}_src_request = dma_req_16b[0]; //4'h0
// :	endcase
// :end
// :
// ://destination request
// :reg ch_${i}_dst_request;
// :always @(*) begin
// :	case(ch_${i}_dst_req_sel)
// :		4'h1:	ch_${i}_dst_request = dma_req_16b[1];
// :		4'h2:	ch_${i}_dst_request = dma_req_16b[2];
// :		4'h3:	ch_${i}_dst_request = dma_req_16b[3];
// :		4'h4:	ch_${i}_dst_request = dma_req_16b[4];
// :		4'h5:	ch_${i}_dst_request = dma_req_16b[5];
// :		4'h6:	ch_${i}_dst_request = dma_req_16b[6];
// :		4'h7:	ch_${i}_dst_request = dma_req_16b[7];
// :		4'h8:	ch_${i}_dst_request = dma_req_16b[8];
// :		4'h9:	ch_${i}_dst_request = dma_req_16b[9];
// :		4'ha:	ch_${i}_dst_request = dma_req_16b[10];
// :		4'hb:	ch_${i}_dst_request = dma_req_16b[11];
// :		4'hc:	ch_${i}_dst_request = dma_req_16b[12];
// :		4'hd:	ch_${i}_dst_request = dma_req_16b[13];
// :		4'he:	ch_${i}_dst_request = dma_req_16b[14];
// :		4'hf:	ch_${i}_dst_request = dma_req_16b[15];
// :		default: ch_${i}_dst_request = dma_req_16b[0]; //4'h0
// :	endcase
// :end
// :wire	ch_${i}_request_en = ch_${i}_en & (ch_${i}_src_request | ~ch_${i}_src_mode) & (ch_${i}_dst_request | ~ch_${i}_dst_mode);
// }
//VPERL_END

// VPERL_GENERATED_BEGIN
//source request
reg ch_0_src_request;
always @(*) begin
	case(ch_0_src_req_sel)
		4'h1:	ch_0_src_request = dma_req_16b[1];
		4'h2:	ch_0_src_request = dma_req_16b[2];
		4'h3:	ch_0_src_request = dma_req_16b[3];
		4'h4:	ch_0_src_request = dma_req_16b[4];
		4'h5:	ch_0_src_request = dma_req_16b[5];
		4'h6:	ch_0_src_request = dma_req_16b[6];
		4'h7:	ch_0_src_request = dma_req_16b[7];
		4'h8:	ch_0_src_request = dma_req_16b[8];
		4'h9:	ch_0_src_request = dma_req_16b[9];
		4'ha:	ch_0_src_request = dma_req_16b[10];
		4'hb:	ch_0_src_request = dma_req_16b[11];
		4'hc:	ch_0_src_request = dma_req_16b[12];
		4'hd:	ch_0_src_request = dma_req_16b[13];
		4'he:	ch_0_src_request = dma_req_16b[14];
		4'hf:	ch_0_src_request = dma_req_16b[15];
		default: ch_0_src_request = dma_req_16b[0]; //4'h0
	endcase
end

//destination request
reg ch_0_dst_request;
always @(*) begin
	case(ch_0_dst_req_sel)
		4'h1:	ch_0_dst_request = dma_req_16b[1];
		4'h2:	ch_0_dst_request = dma_req_16b[2];
		4'h3:	ch_0_dst_request = dma_req_16b[3];
		4'h4:	ch_0_dst_request = dma_req_16b[4];
		4'h5:	ch_0_dst_request = dma_req_16b[5];
		4'h6:	ch_0_dst_request = dma_req_16b[6];
		4'h7:	ch_0_dst_request = dma_req_16b[7];
		4'h8:	ch_0_dst_request = dma_req_16b[8];
		4'h9:	ch_0_dst_request = dma_req_16b[9];
		4'ha:	ch_0_dst_request = dma_req_16b[10];
		4'hb:	ch_0_dst_request = dma_req_16b[11];
		4'hc:	ch_0_dst_request = dma_req_16b[12];
		4'hd:	ch_0_dst_request = dma_req_16b[13];
		4'he:	ch_0_dst_request = dma_req_16b[14];
		4'hf:	ch_0_dst_request = dma_req_16b[15];
		default: ch_0_dst_request = dma_req_16b[0]; //4'h0
	endcase
end
wire	ch_0_request_en = ch_0_en & (ch_0_src_request | ~ch_0_src_mode) & (ch_0_dst_request | ~ch_0_dst_mode);
//source request
reg ch_1_src_request;
always @(*) begin
	case(ch_1_src_req_sel)
		4'h1:	ch_1_src_request = dma_req_16b[1];
		4'h2:	ch_1_src_request = dma_req_16b[2];
		4'h3:	ch_1_src_request = dma_req_16b[3];
		4'h4:	ch_1_src_request = dma_req_16b[4];
		4'h5:	ch_1_src_request = dma_req_16b[5];
		4'h6:	ch_1_src_request = dma_req_16b[6];
		4'h7:	ch_1_src_request = dma_req_16b[7];
		4'h8:	ch_1_src_request = dma_req_16b[8];
		4'h9:	ch_1_src_request = dma_req_16b[9];
		4'ha:	ch_1_src_request = dma_req_16b[10];
		4'hb:	ch_1_src_request = dma_req_16b[11];
		4'hc:	ch_1_src_request = dma_req_16b[12];
		4'hd:	ch_1_src_request = dma_req_16b[13];
		4'he:	ch_1_src_request = dma_req_16b[14];
		4'hf:	ch_1_src_request = dma_req_16b[15];
		default: ch_1_src_request = dma_req_16b[0]; //4'h0
	endcase
end

//destination request
reg ch_1_dst_request;
always @(*) begin
	case(ch_1_dst_req_sel)
		4'h1:	ch_1_dst_request = dma_req_16b[1];
		4'h2:	ch_1_dst_request = dma_req_16b[2];
		4'h3:	ch_1_dst_request = dma_req_16b[3];
		4'h4:	ch_1_dst_request = dma_req_16b[4];
		4'h5:	ch_1_dst_request = dma_req_16b[5];
		4'h6:	ch_1_dst_request = dma_req_16b[6];
		4'h7:	ch_1_dst_request = dma_req_16b[7];
		4'h8:	ch_1_dst_request = dma_req_16b[8];
		4'h9:	ch_1_dst_request = dma_req_16b[9];
		4'ha:	ch_1_dst_request = dma_req_16b[10];
		4'hb:	ch_1_dst_request = dma_req_16b[11];
		4'hc:	ch_1_dst_request = dma_req_16b[12];
		4'hd:	ch_1_dst_request = dma_req_16b[13];
		4'he:	ch_1_dst_request = dma_req_16b[14];
		4'hf:	ch_1_dst_request = dma_req_16b[15];
		default: ch_1_dst_request = dma_req_16b[0]; //4'h0
	endcase
end
wire	ch_1_request_en = ch_1_en & (ch_1_src_request | ~ch_1_src_mode) & (ch_1_dst_request | ~ch_1_dst_mode);
//source request
reg ch_2_src_request;
always @(*) begin
	case(ch_2_src_req_sel)
		4'h1:	ch_2_src_request = dma_req_16b[1];
		4'h2:	ch_2_src_request = dma_req_16b[2];
		4'h3:	ch_2_src_request = dma_req_16b[3];
		4'h4:	ch_2_src_request = dma_req_16b[4];
		4'h5:	ch_2_src_request = dma_req_16b[5];
		4'h6:	ch_2_src_request = dma_req_16b[6];
		4'h7:	ch_2_src_request = dma_req_16b[7];
		4'h8:	ch_2_src_request = dma_req_16b[8];
		4'h9:	ch_2_src_request = dma_req_16b[9];
		4'ha:	ch_2_src_request = dma_req_16b[10];
		4'hb:	ch_2_src_request = dma_req_16b[11];
		4'hc:	ch_2_src_request = dma_req_16b[12];
		4'hd:	ch_2_src_request = dma_req_16b[13];
		4'he:	ch_2_src_request = dma_req_16b[14];
		4'hf:	ch_2_src_request = dma_req_16b[15];
		default: ch_2_src_request = dma_req_16b[0]; //4'h0
	endcase
end

//destination request
reg ch_2_dst_request;
always @(*) begin
	case(ch_2_dst_req_sel)
		4'h1:	ch_2_dst_request = dma_req_16b[1];
		4'h2:	ch_2_dst_request = dma_req_16b[2];
		4'h3:	ch_2_dst_request = dma_req_16b[3];
		4'h4:	ch_2_dst_request = dma_req_16b[4];
		4'h5:	ch_2_dst_request = dma_req_16b[5];
		4'h6:	ch_2_dst_request = dma_req_16b[6];
		4'h7:	ch_2_dst_request = dma_req_16b[7];
		4'h8:	ch_2_dst_request = dma_req_16b[8];
		4'h9:	ch_2_dst_request = dma_req_16b[9];
		4'ha:	ch_2_dst_request = dma_req_16b[10];
		4'hb:	ch_2_dst_request = dma_req_16b[11];
		4'hc:	ch_2_dst_request = dma_req_16b[12];
		4'hd:	ch_2_dst_request = dma_req_16b[13];
		4'he:	ch_2_dst_request = dma_req_16b[14];
		4'hf:	ch_2_dst_request = dma_req_16b[15];
		default: ch_2_dst_request = dma_req_16b[0]; //4'h0
	endcase
end
wire	ch_2_request_en = ch_2_en & (ch_2_src_request | ~ch_2_src_mode) & (ch_2_dst_request | ~ch_2_dst_mode);
//source request
reg ch_3_src_request;
always @(*) begin
	case(ch_3_src_req_sel)
		4'h1:	ch_3_src_request = dma_req_16b[1];
		4'h2:	ch_3_src_request = dma_req_16b[2];
		4'h3:	ch_3_src_request = dma_req_16b[3];
		4'h4:	ch_3_src_request = dma_req_16b[4];
		4'h5:	ch_3_src_request = dma_req_16b[5];
		4'h6:	ch_3_src_request = dma_req_16b[6];
		4'h7:	ch_3_src_request = dma_req_16b[7];
		4'h8:	ch_3_src_request = dma_req_16b[8];
		4'h9:	ch_3_src_request = dma_req_16b[9];
		4'ha:	ch_3_src_request = dma_req_16b[10];
		4'hb:	ch_3_src_request = dma_req_16b[11];
		4'hc:	ch_3_src_request = dma_req_16b[12];
		4'hd:	ch_3_src_request = dma_req_16b[13];
		4'he:	ch_3_src_request = dma_req_16b[14];
		4'hf:	ch_3_src_request = dma_req_16b[15];
		default: ch_3_src_request = dma_req_16b[0]; //4'h0
	endcase
end

//destination request
reg ch_3_dst_request;
always @(*) begin
	case(ch_3_dst_req_sel)
		4'h1:	ch_3_dst_request = dma_req_16b[1];
		4'h2:	ch_3_dst_request = dma_req_16b[2];
		4'h3:	ch_3_dst_request = dma_req_16b[3];
		4'h4:	ch_3_dst_request = dma_req_16b[4];
		4'h5:	ch_3_dst_request = dma_req_16b[5];
		4'h6:	ch_3_dst_request = dma_req_16b[6];
		4'h7:	ch_3_dst_request = dma_req_16b[7];
		4'h8:	ch_3_dst_request = dma_req_16b[8];
		4'h9:	ch_3_dst_request = dma_req_16b[9];
		4'ha:	ch_3_dst_request = dma_req_16b[10];
		4'hb:	ch_3_dst_request = dma_req_16b[11];
		4'hc:	ch_3_dst_request = dma_req_16b[12];
		4'hd:	ch_3_dst_request = dma_req_16b[13];
		4'he:	ch_3_dst_request = dma_req_16b[14];
		4'hf:	ch_3_dst_request = dma_req_16b[15];
		default: ch_3_dst_request = dma_req_16b[0]; //4'h0
	endcase
end
wire	ch_3_request_en = ch_3_en & (ch_3_src_request | ~ch_3_src_mode) & (ch_3_dst_request | ~ch_3_dst_mode);
//source request
reg ch_4_src_request;
always @(*) begin
	case(ch_4_src_req_sel)
		4'h1:	ch_4_src_request = dma_req_16b[1];
		4'h2:	ch_4_src_request = dma_req_16b[2];
		4'h3:	ch_4_src_request = dma_req_16b[3];
		4'h4:	ch_4_src_request = dma_req_16b[4];
		4'h5:	ch_4_src_request = dma_req_16b[5];
		4'h6:	ch_4_src_request = dma_req_16b[6];
		4'h7:	ch_4_src_request = dma_req_16b[7];
		4'h8:	ch_4_src_request = dma_req_16b[8];
		4'h9:	ch_4_src_request = dma_req_16b[9];
		4'ha:	ch_4_src_request = dma_req_16b[10];
		4'hb:	ch_4_src_request = dma_req_16b[11];
		4'hc:	ch_4_src_request = dma_req_16b[12];
		4'hd:	ch_4_src_request = dma_req_16b[13];
		4'he:	ch_4_src_request = dma_req_16b[14];
		4'hf:	ch_4_src_request = dma_req_16b[15];
		default: ch_4_src_request = dma_req_16b[0]; //4'h0
	endcase
end

//destination request
reg ch_4_dst_request;
always @(*) begin
	case(ch_4_dst_req_sel)
		4'h1:	ch_4_dst_request = dma_req_16b[1];
		4'h2:	ch_4_dst_request = dma_req_16b[2];
		4'h3:	ch_4_dst_request = dma_req_16b[3];
		4'h4:	ch_4_dst_request = dma_req_16b[4];
		4'h5:	ch_4_dst_request = dma_req_16b[5];
		4'h6:	ch_4_dst_request = dma_req_16b[6];
		4'h7:	ch_4_dst_request = dma_req_16b[7];
		4'h8:	ch_4_dst_request = dma_req_16b[8];
		4'h9:	ch_4_dst_request = dma_req_16b[9];
		4'ha:	ch_4_dst_request = dma_req_16b[10];
		4'hb:	ch_4_dst_request = dma_req_16b[11];
		4'hc:	ch_4_dst_request = dma_req_16b[12];
		4'hd:	ch_4_dst_request = dma_req_16b[13];
		4'he:	ch_4_dst_request = dma_req_16b[14];
		4'hf:	ch_4_dst_request = dma_req_16b[15];
		default: ch_4_dst_request = dma_req_16b[0]; //4'h0
	endcase
end
wire	ch_4_request_en = ch_4_en & (ch_4_src_request | ~ch_4_src_mode) & (ch_4_dst_request | ~ch_4_dst_mode);
//source request
reg ch_5_src_request;
always @(*) begin
	case(ch_5_src_req_sel)
		4'h1:	ch_5_src_request = dma_req_16b[1];
		4'h2:	ch_5_src_request = dma_req_16b[2];
		4'h3:	ch_5_src_request = dma_req_16b[3];
		4'h4:	ch_5_src_request = dma_req_16b[4];
		4'h5:	ch_5_src_request = dma_req_16b[5];
		4'h6:	ch_5_src_request = dma_req_16b[6];
		4'h7:	ch_5_src_request = dma_req_16b[7];
		4'h8:	ch_5_src_request = dma_req_16b[8];
		4'h9:	ch_5_src_request = dma_req_16b[9];
		4'ha:	ch_5_src_request = dma_req_16b[10];
		4'hb:	ch_5_src_request = dma_req_16b[11];
		4'hc:	ch_5_src_request = dma_req_16b[12];
		4'hd:	ch_5_src_request = dma_req_16b[13];
		4'he:	ch_5_src_request = dma_req_16b[14];
		4'hf:	ch_5_src_request = dma_req_16b[15];
		default: ch_5_src_request = dma_req_16b[0]; //4'h0
	endcase
end

//destination request
reg ch_5_dst_request;
always @(*) begin
	case(ch_5_dst_req_sel)
		4'h1:	ch_5_dst_request = dma_req_16b[1];
		4'h2:	ch_5_dst_request = dma_req_16b[2];
		4'h3:	ch_5_dst_request = dma_req_16b[3];
		4'h4:	ch_5_dst_request = dma_req_16b[4];
		4'h5:	ch_5_dst_request = dma_req_16b[5];
		4'h6:	ch_5_dst_request = dma_req_16b[6];
		4'h7:	ch_5_dst_request = dma_req_16b[7];
		4'h8:	ch_5_dst_request = dma_req_16b[8];
		4'h9:	ch_5_dst_request = dma_req_16b[9];
		4'ha:	ch_5_dst_request = dma_req_16b[10];
		4'hb:	ch_5_dst_request = dma_req_16b[11];
		4'hc:	ch_5_dst_request = dma_req_16b[12];
		4'hd:	ch_5_dst_request = dma_req_16b[13];
		4'he:	ch_5_dst_request = dma_req_16b[14];
		4'hf:	ch_5_dst_request = dma_req_16b[15];
		default: ch_5_dst_request = dma_req_16b[0]; //4'h0
	endcase
end
wire	ch_5_request_en = ch_5_en & (ch_5_src_request | ~ch_5_src_mode) & (ch_5_dst_request | ~ch_5_dst_mode);
//source request
reg ch_6_src_request;
always @(*) begin
	case(ch_6_src_req_sel)
		4'h1:	ch_6_src_request = dma_req_16b[1];
		4'h2:	ch_6_src_request = dma_req_16b[2];
		4'h3:	ch_6_src_request = dma_req_16b[3];
		4'h4:	ch_6_src_request = dma_req_16b[4];
		4'h5:	ch_6_src_request = dma_req_16b[5];
		4'h6:	ch_6_src_request = dma_req_16b[6];
		4'h7:	ch_6_src_request = dma_req_16b[7];
		4'h8:	ch_6_src_request = dma_req_16b[8];
		4'h9:	ch_6_src_request = dma_req_16b[9];
		4'ha:	ch_6_src_request = dma_req_16b[10];
		4'hb:	ch_6_src_request = dma_req_16b[11];
		4'hc:	ch_6_src_request = dma_req_16b[12];
		4'hd:	ch_6_src_request = dma_req_16b[13];
		4'he:	ch_6_src_request = dma_req_16b[14];
		4'hf:	ch_6_src_request = dma_req_16b[15];
		default: ch_6_src_request = dma_req_16b[0]; //4'h0
	endcase
end

//destination request
reg ch_6_dst_request;
always @(*) begin
	case(ch_6_dst_req_sel)
		4'h1:	ch_6_dst_request = dma_req_16b[1];
		4'h2:	ch_6_dst_request = dma_req_16b[2];
		4'h3:	ch_6_dst_request = dma_req_16b[3];
		4'h4:	ch_6_dst_request = dma_req_16b[4];
		4'h5:	ch_6_dst_request = dma_req_16b[5];
		4'h6:	ch_6_dst_request = dma_req_16b[6];
		4'h7:	ch_6_dst_request = dma_req_16b[7];
		4'h8:	ch_6_dst_request = dma_req_16b[8];
		4'h9:	ch_6_dst_request = dma_req_16b[9];
		4'ha:	ch_6_dst_request = dma_req_16b[10];
		4'hb:	ch_6_dst_request = dma_req_16b[11];
		4'hc:	ch_6_dst_request = dma_req_16b[12];
		4'hd:	ch_6_dst_request = dma_req_16b[13];
		4'he:	ch_6_dst_request = dma_req_16b[14];
		4'hf:	ch_6_dst_request = dma_req_16b[15];
		default: ch_6_dst_request = dma_req_16b[0]; //4'h0
	endcase
end
wire	ch_6_request_en = ch_6_en & (ch_6_src_request | ~ch_6_src_mode) & (ch_6_dst_request | ~ch_6_dst_mode);
//source request
reg ch_7_src_request;
always @(*) begin
	case(ch_7_src_req_sel)
		4'h1:	ch_7_src_request = dma_req_16b[1];
		4'h2:	ch_7_src_request = dma_req_16b[2];
		4'h3:	ch_7_src_request = dma_req_16b[3];
		4'h4:	ch_7_src_request = dma_req_16b[4];
		4'h5:	ch_7_src_request = dma_req_16b[5];
		4'h6:	ch_7_src_request = dma_req_16b[6];
		4'h7:	ch_7_src_request = dma_req_16b[7];
		4'h8:	ch_7_src_request = dma_req_16b[8];
		4'h9:	ch_7_src_request = dma_req_16b[9];
		4'ha:	ch_7_src_request = dma_req_16b[10];
		4'hb:	ch_7_src_request = dma_req_16b[11];
		4'hc:	ch_7_src_request = dma_req_16b[12];
		4'hd:	ch_7_src_request = dma_req_16b[13];
		4'he:	ch_7_src_request = dma_req_16b[14];
		4'hf:	ch_7_src_request = dma_req_16b[15];
		default: ch_7_src_request = dma_req_16b[0]; //4'h0
	endcase
end

//destination request
reg ch_7_dst_request;
always @(*) begin
	case(ch_7_dst_req_sel)
		4'h1:	ch_7_dst_request = dma_req_16b[1];
		4'h2:	ch_7_dst_request = dma_req_16b[2];
		4'h3:	ch_7_dst_request = dma_req_16b[3];
		4'h4:	ch_7_dst_request = dma_req_16b[4];
		4'h5:	ch_7_dst_request = dma_req_16b[5];
		4'h6:	ch_7_dst_request = dma_req_16b[6];
		4'h7:	ch_7_dst_request = dma_req_16b[7];
		4'h8:	ch_7_dst_request = dma_req_16b[8];
		4'h9:	ch_7_dst_request = dma_req_16b[9];
		4'ha:	ch_7_dst_request = dma_req_16b[10];
		4'hb:	ch_7_dst_request = dma_req_16b[11];
		4'hc:	ch_7_dst_request = dma_req_16b[12];
		4'hd:	ch_7_dst_request = dma_req_16b[13];
		4'he:	ch_7_dst_request = dma_req_16b[14];
		4'hf:	ch_7_dst_request = dma_req_16b[15];
		default: ch_7_dst_request = dma_req_16b[0]; //4'h0
	endcase
end
wire	ch_7_request_en = ch_7_en & (ch_7_src_request | ~ch_7_src_mode) & (ch_7_dst_request | ~ch_7_dst_mode);
// VPERL_GENERATED_END
//VPERL_BEGIN
// :always @(*) begin
// :	case(dma0_current_channel)
// my $ch_num = 8;
// for ($i=1; $i<$ch_num; $i++) {
// :		3'h${i}: begin
// :			dma0_ch_src_addr_ctl 	= ch_${i}_src_addr_ctl;
// :			dma0_ch_dst_addr_ctl	= ch_${i}_dst_addr_ctl;
// :			dma0_ch_src_width	= ch_${i}_src_width;
// :			dma0_ch_dst_width	= ch_${i}_dst_width;
// :			dma0_ch_src_burst_size	= ch_${i}_src_burst_size;
// :			dma0_ch_tts		= ch_${i}_tts;
// :			dma0_ch_src_addr	= ch_${i}_src_addr;
// :			dma0_ch_dst_addr	= ch_${i}_dst_addr;
// :`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :			dma0_ch_src_bus_inf_idx	= ch_${i}_src_bus_inf_idx;
// :			dma0_ch_dst_bus_inf_idx	= ch_${i}_dst_bus_inf_idx;
// :`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
// :			dma0_ch_llp		= ch_${i}_llp_reg;
// :	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :			dma0_ch_lld_bus_inf_idx	= ch_${i}_lld_bus_inf_idx;
// :	`endif
// :`endif
// :			dma0_ch_src_mode	= ch_${i}_src_mode;
// :			dma0_ch_src_request	= ch_${i}_src_request;
// :			dma0_ch_dst_mode	= ch_${i}_dst_mode;
// :			dma0_ch_dst_request	= ch_${i}_dst_request;
// :			dma0_ch_abt		= ch_${i}_abt;
// :			dma0_ch_int_tc_mask	= ch_${i}_int_tc_mask;
// :			dma0_ch_int_err_mask	= ch_${i}_int_err_mask;
// :			dma0_ch_int_abt_mask	= ch_${i}_int_abt_mask;
// :		end
// }
// :		default: begin
// :			dma0_ch_src_addr_ctl 	= ch_0_src_addr_ctl;
// :			dma0_ch_dst_addr_ctl 	= ch_0_dst_addr_ctl;
// :			dma0_ch_src_width	= ch_0_src_width;
// :			dma0_ch_dst_width	= ch_0_dst_width;
// :			dma0_ch_src_burst_size	= ch_0_src_burst_size;
// :			dma0_ch_tts		= ch_0_tts;
// :			dma0_ch_src_addr	= ch_0_src_addr;
// :			dma0_ch_dst_addr	= ch_0_dst_addr;
// :`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :			dma0_ch_src_bus_inf_idx	= ch_0_src_bus_inf_idx;
// :			dma0_ch_dst_bus_inf_idx	= ch_0_dst_bus_inf_idx;
// :`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
// :			dma0_ch_llp		= ch_0_llp_reg;
// :	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :			dma0_ch_lld_bus_inf_idx	= ch_0_lld_bus_inf_idx;
// :	`endif
// :`endif
// :			dma0_ch_src_mode	= ch_0_src_mode;
// :			dma0_ch_src_request	= ch_0_src_request;
// :			dma0_ch_dst_mode	= ch_0_dst_mode;
// :			dma0_ch_dst_request	= ch_0_dst_request;
// :			dma0_ch_abt		= ch_0_abt;
// :			dma0_ch_int_tc_mask	= ch_0_int_tc_mask;
// :			dma0_ch_int_err_mask	= ch_0_int_err_mask;
// :			dma0_ch_int_abt_mask	= ch_0_int_abt_mask;
// :		end
// :	endcase
// :end
// :`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
// :always @(*) begin
// :	case(dma1_current_channel)
// my $ch_num = 8;
// for ($i=1; $i<$ch_num; $i++) {
// :		3'h${i}: begin
// :			dma1_ch_src_addr_ctl 	= ch_${i}_src_addr_ctl;
// :			dma1_ch_dst_addr_ctl	= ch_${i}_dst_addr_ctl;
// :			dma1_ch_src_width	= ch_${i}_src_width;
// :			dma1_ch_dst_width	= ch_${i}_dst_width;
// :			dma1_ch_src_burst_size	= ch_${i}_src_burst_size;
// :			dma1_ch_tts		= ch_${i}_tts;
// :			dma1_ch_src_addr	= ch_${i}_src_addr;
// :			dma1_ch_dst_addr	= ch_${i}_dst_addr;
// :`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :			dma1_ch_src_bus_inf_idx	= ch_${i}_src_bus_inf_idx;
// :			dma1_ch_dst_bus_inf_idx	= ch_${i}_dst_bus_inf_idx;
// :`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
// :			dma1_ch_llp		= ch_${i}_llp_reg;
// :		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :			dma1_ch_lld_bus_inf_idx	= ch_${i}_lld_bus_inf_idx;
// :		`endif
// :`endif
// :			dma1_ch_src_mode	= ch_${i}_src_mode;
// :			dma1_ch_src_request	= ch_${i}_src_request;
// :			dma1_ch_dst_mode	= ch_${i}_dst_mode;
// :			dma1_ch_dst_request	= ch_${i}_dst_request;
// :			dma1_ch_abt		= ch_${i}_abt;
// :			dma1_ch_int_tc_mask	= ch_${i}_int_tc_mask;
// :			dma1_ch_int_err_mask	= ch_${i}_int_err_mask;
// :			dma1_ch_int_abt_mask	= ch_${i}_int_abt_mask;
// :		end
// }
// :		default: begin
// :			dma1_ch_src_addr_ctl 	= ch_0_src_addr_ctl;
// :			dma1_ch_dst_addr_ctl 	= ch_0_dst_addr_ctl;
// :			dma1_ch_src_width	= ch_0_src_width;
// :			dma1_ch_dst_width	= ch_0_dst_width;
// :			dma1_ch_src_burst_size	= ch_0_src_burst_size;
// :			dma1_ch_tts		= ch_0_tts;
// :			dma1_ch_src_addr	= ch_0_src_addr;
// :			dma1_ch_dst_addr	= ch_0_dst_addr;
// :`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :			dma1_ch_src_bus_inf_idx	= ch_0_src_bus_inf_idx;
// :			dma1_ch_dst_bus_inf_idx	= ch_0_dst_bus_inf_idx;
// :`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
// :			dma1_ch_llp		= ch_0_llp_reg;
// :		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
// :			dma1_ch_lld_bus_inf_idx	= ch_0_lld_bus_inf_idx;
// :		`endif
// :`endif
// :			dma1_ch_src_mode	= ch_0_src_mode;
// :			dma1_ch_src_request	= ch_0_src_request;
// :			dma1_ch_dst_mode	= ch_0_dst_mode;
// :			dma1_ch_dst_request	= ch_0_dst_request;
// :			dma1_ch_abt		= ch_0_abt;
// :			dma1_ch_int_tc_mask	= ch_0_int_tc_mask;
// :			dma1_ch_int_err_mask	= ch_0_int_err_mask;
// :			dma1_ch_int_abt_mask	= ch_0_int_abt_mask;
// :		end
// :	endcase
// :end
// :`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
//VPERL_END

// VPERL_GENERATED_BEGIN
always @(*) begin
	case(dma0_current_channel)
		3'h1: begin
			dma0_ch_src_addr_ctl 	= ch_1_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_1_dst_addr_ctl;
			dma0_ch_src_width	= ch_1_src_width;
			dma0_ch_dst_width	= ch_1_dst_width;
			dma0_ch_src_burst_size	= ch_1_src_burst_size;
			dma0_ch_tts		= ch_1_tts;
			dma0_ch_src_addr	= ch_1_src_addr;
			dma0_ch_dst_addr	= ch_1_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_1_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_1_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_1_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_1_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_1_src_mode;
			dma0_ch_src_request	= ch_1_src_request;
			dma0_ch_dst_mode	= ch_1_dst_mode;
			dma0_ch_dst_request	= ch_1_dst_request;
			dma0_ch_abt		= ch_1_abt;
			dma0_ch_int_tc_mask	= ch_1_int_tc_mask;
			dma0_ch_int_err_mask	= ch_1_int_err_mask;
			dma0_ch_int_abt_mask	= ch_1_int_abt_mask;
		end
		3'h2: begin
			dma0_ch_src_addr_ctl 	= ch_2_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_2_dst_addr_ctl;
			dma0_ch_src_width	= ch_2_src_width;
			dma0_ch_dst_width	= ch_2_dst_width;
			dma0_ch_src_burst_size	= ch_2_src_burst_size;
			dma0_ch_tts		= ch_2_tts;
			dma0_ch_src_addr	= ch_2_src_addr;
			dma0_ch_dst_addr	= ch_2_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_2_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_2_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_2_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_2_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_2_src_mode;
			dma0_ch_src_request	= ch_2_src_request;
			dma0_ch_dst_mode	= ch_2_dst_mode;
			dma0_ch_dst_request	= ch_2_dst_request;
			dma0_ch_abt		= ch_2_abt;
			dma0_ch_int_tc_mask	= ch_2_int_tc_mask;
			dma0_ch_int_err_mask	= ch_2_int_err_mask;
			dma0_ch_int_abt_mask	= ch_2_int_abt_mask;
		end
		3'h3: begin
			dma0_ch_src_addr_ctl 	= ch_3_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_3_dst_addr_ctl;
			dma0_ch_src_width	= ch_3_src_width;
			dma0_ch_dst_width	= ch_3_dst_width;
			dma0_ch_src_burst_size	= ch_3_src_burst_size;
			dma0_ch_tts		= ch_3_tts;
			dma0_ch_src_addr	= ch_3_src_addr;
			dma0_ch_dst_addr	= ch_3_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_3_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_3_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_3_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_3_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_3_src_mode;
			dma0_ch_src_request	= ch_3_src_request;
			dma0_ch_dst_mode	= ch_3_dst_mode;
			dma0_ch_dst_request	= ch_3_dst_request;
			dma0_ch_abt		= ch_3_abt;
			dma0_ch_int_tc_mask	= ch_3_int_tc_mask;
			dma0_ch_int_err_mask	= ch_3_int_err_mask;
			dma0_ch_int_abt_mask	= ch_3_int_abt_mask;
		end
		3'h4: begin
			dma0_ch_src_addr_ctl 	= ch_4_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_4_dst_addr_ctl;
			dma0_ch_src_width	= ch_4_src_width;
			dma0_ch_dst_width	= ch_4_dst_width;
			dma0_ch_src_burst_size	= ch_4_src_burst_size;
			dma0_ch_tts		= ch_4_tts;
			dma0_ch_src_addr	= ch_4_src_addr;
			dma0_ch_dst_addr	= ch_4_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_4_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_4_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_4_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_4_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_4_src_mode;
			dma0_ch_src_request	= ch_4_src_request;
			dma0_ch_dst_mode	= ch_4_dst_mode;
			dma0_ch_dst_request	= ch_4_dst_request;
			dma0_ch_abt		= ch_4_abt;
			dma0_ch_int_tc_mask	= ch_4_int_tc_mask;
			dma0_ch_int_err_mask	= ch_4_int_err_mask;
			dma0_ch_int_abt_mask	= ch_4_int_abt_mask;
		end
		3'h5: begin
			dma0_ch_src_addr_ctl 	= ch_5_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_5_dst_addr_ctl;
			dma0_ch_src_width	= ch_5_src_width;
			dma0_ch_dst_width	= ch_5_dst_width;
			dma0_ch_src_burst_size	= ch_5_src_burst_size;
			dma0_ch_tts		= ch_5_tts;
			dma0_ch_src_addr	= ch_5_src_addr;
			dma0_ch_dst_addr	= ch_5_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_5_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_5_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_5_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_5_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_5_src_mode;
			dma0_ch_src_request	= ch_5_src_request;
			dma0_ch_dst_mode	= ch_5_dst_mode;
			dma0_ch_dst_request	= ch_5_dst_request;
			dma0_ch_abt		= ch_5_abt;
			dma0_ch_int_tc_mask	= ch_5_int_tc_mask;
			dma0_ch_int_err_mask	= ch_5_int_err_mask;
			dma0_ch_int_abt_mask	= ch_5_int_abt_mask;
		end
		3'h6: begin
			dma0_ch_src_addr_ctl 	= ch_6_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_6_dst_addr_ctl;
			dma0_ch_src_width	= ch_6_src_width;
			dma0_ch_dst_width	= ch_6_dst_width;
			dma0_ch_src_burst_size	= ch_6_src_burst_size;
			dma0_ch_tts		= ch_6_tts;
			dma0_ch_src_addr	= ch_6_src_addr;
			dma0_ch_dst_addr	= ch_6_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_6_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_6_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_6_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_6_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_6_src_mode;
			dma0_ch_src_request	= ch_6_src_request;
			dma0_ch_dst_mode	= ch_6_dst_mode;
			dma0_ch_dst_request	= ch_6_dst_request;
			dma0_ch_abt		= ch_6_abt;
			dma0_ch_int_tc_mask	= ch_6_int_tc_mask;
			dma0_ch_int_err_mask	= ch_6_int_err_mask;
			dma0_ch_int_abt_mask	= ch_6_int_abt_mask;
		end
		3'h7: begin
			dma0_ch_src_addr_ctl 	= ch_7_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_7_dst_addr_ctl;
			dma0_ch_src_width	= ch_7_src_width;
			dma0_ch_dst_width	= ch_7_dst_width;
			dma0_ch_src_burst_size	= ch_7_src_burst_size;
			dma0_ch_tts		= ch_7_tts;
			dma0_ch_src_addr	= ch_7_src_addr;
			dma0_ch_dst_addr	= ch_7_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_7_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_7_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_7_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_7_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_7_src_mode;
			dma0_ch_src_request	= ch_7_src_request;
			dma0_ch_dst_mode	= ch_7_dst_mode;
			dma0_ch_dst_request	= ch_7_dst_request;
			dma0_ch_abt		= ch_7_abt;
			dma0_ch_int_tc_mask	= ch_7_int_tc_mask;
			dma0_ch_int_err_mask	= ch_7_int_err_mask;
			dma0_ch_int_abt_mask	= ch_7_int_abt_mask;
		end
		default: begin
			dma0_ch_src_addr_ctl 	= ch_0_src_addr_ctl;
			dma0_ch_dst_addr_ctl 	= ch_0_dst_addr_ctl;
			dma0_ch_src_width	= ch_0_src_width;
			dma0_ch_dst_width	= ch_0_dst_width;
			dma0_ch_src_burst_size	= ch_0_src_burst_size;
			dma0_ch_tts		= ch_0_tts;
			dma0_ch_src_addr	= ch_0_src_addr;
			dma0_ch_dst_addr	= ch_0_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_0_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_0_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_0_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_0_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_0_src_mode;
			dma0_ch_src_request	= ch_0_src_request;
			dma0_ch_dst_mode	= ch_0_dst_mode;
			dma0_ch_dst_request	= ch_0_dst_request;
			dma0_ch_abt		= ch_0_abt;
			dma0_ch_int_tc_mask	= ch_0_int_tc_mask;
			dma0_ch_int_err_mask	= ch_0_int_err_mask;
			dma0_ch_int_abt_mask	= ch_0_int_abt_mask;
		end
	endcase
end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
always @(*) begin
	case(dma1_current_channel)
		3'h1: begin
			dma1_ch_src_addr_ctl 	= ch_1_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_1_dst_addr_ctl;
			dma1_ch_src_width	= ch_1_src_width;
			dma1_ch_dst_width	= ch_1_dst_width;
			dma1_ch_src_burst_size	= ch_1_src_burst_size;
			dma1_ch_tts		= ch_1_tts;
			dma1_ch_src_addr	= ch_1_src_addr;
			dma1_ch_dst_addr	= ch_1_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_1_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_1_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_1_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_1_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_1_src_mode;
			dma1_ch_src_request	= ch_1_src_request;
			dma1_ch_dst_mode	= ch_1_dst_mode;
			dma1_ch_dst_request	= ch_1_dst_request;
			dma1_ch_abt		= ch_1_abt;
			dma1_ch_int_tc_mask	= ch_1_int_tc_mask;
			dma1_ch_int_err_mask	= ch_1_int_err_mask;
			dma1_ch_int_abt_mask	= ch_1_int_abt_mask;
		end
		3'h2: begin
			dma1_ch_src_addr_ctl 	= ch_2_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_2_dst_addr_ctl;
			dma1_ch_src_width	= ch_2_src_width;
			dma1_ch_dst_width	= ch_2_dst_width;
			dma1_ch_src_burst_size	= ch_2_src_burst_size;
			dma1_ch_tts		= ch_2_tts;
			dma1_ch_src_addr	= ch_2_src_addr;
			dma1_ch_dst_addr	= ch_2_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_2_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_2_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_2_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_2_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_2_src_mode;
			dma1_ch_src_request	= ch_2_src_request;
			dma1_ch_dst_mode	= ch_2_dst_mode;
			dma1_ch_dst_request	= ch_2_dst_request;
			dma1_ch_abt		= ch_2_abt;
			dma1_ch_int_tc_mask	= ch_2_int_tc_mask;
			dma1_ch_int_err_mask	= ch_2_int_err_mask;
			dma1_ch_int_abt_mask	= ch_2_int_abt_mask;
		end
		3'h3: begin
			dma1_ch_src_addr_ctl 	= ch_3_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_3_dst_addr_ctl;
			dma1_ch_src_width	= ch_3_src_width;
			dma1_ch_dst_width	= ch_3_dst_width;
			dma1_ch_src_burst_size	= ch_3_src_burst_size;
			dma1_ch_tts		= ch_3_tts;
			dma1_ch_src_addr	= ch_3_src_addr;
			dma1_ch_dst_addr	= ch_3_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_3_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_3_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_3_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_3_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_3_src_mode;
			dma1_ch_src_request	= ch_3_src_request;
			dma1_ch_dst_mode	= ch_3_dst_mode;
			dma1_ch_dst_request	= ch_3_dst_request;
			dma1_ch_abt		= ch_3_abt;
			dma1_ch_int_tc_mask	= ch_3_int_tc_mask;
			dma1_ch_int_err_mask	= ch_3_int_err_mask;
			dma1_ch_int_abt_mask	= ch_3_int_abt_mask;
		end
		3'h4: begin
			dma1_ch_src_addr_ctl 	= ch_4_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_4_dst_addr_ctl;
			dma1_ch_src_width	= ch_4_src_width;
			dma1_ch_dst_width	= ch_4_dst_width;
			dma1_ch_src_burst_size	= ch_4_src_burst_size;
			dma1_ch_tts		= ch_4_tts;
			dma1_ch_src_addr	= ch_4_src_addr;
			dma1_ch_dst_addr	= ch_4_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_4_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_4_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_4_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_4_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_4_src_mode;
			dma1_ch_src_request	= ch_4_src_request;
			dma1_ch_dst_mode	= ch_4_dst_mode;
			dma1_ch_dst_request	= ch_4_dst_request;
			dma1_ch_abt		= ch_4_abt;
			dma1_ch_int_tc_mask	= ch_4_int_tc_mask;
			dma1_ch_int_err_mask	= ch_4_int_err_mask;
			dma1_ch_int_abt_mask	= ch_4_int_abt_mask;
		end
		3'h5: begin
			dma1_ch_src_addr_ctl 	= ch_5_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_5_dst_addr_ctl;
			dma1_ch_src_width	= ch_5_src_width;
			dma1_ch_dst_width	= ch_5_dst_width;
			dma1_ch_src_burst_size	= ch_5_src_burst_size;
			dma1_ch_tts		= ch_5_tts;
			dma1_ch_src_addr	= ch_5_src_addr;
			dma1_ch_dst_addr	= ch_5_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_5_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_5_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_5_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_5_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_5_src_mode;
			dma1_ch_src_request	= ch_5_src_request;
			dma1_ch_dst_mode	= ch_5_dst_mode;
			dma1_ch_dst_request	= ch_5_dst_request;
			dma1_ch_abt		= ch_5_abt;
			dma1_ch_int_tc_mask	= ch_5_int_tc_mask;
			dma1_ch_int_err_mask	= ch_5_int_err_mask;
			dma1_ch_int_abt_mask	= ch_5_int_abt_mask;
		end
		3'h6: begin
			dma1_ch_src_addr_ctl 	= ch_6_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_6_dst_addr_ctl;
			dma1_ch_src_width	= ch_6_src_width;
			dma1_ch_dst_width	= ch_6_dst_width;
			dma1_ch_src_burst_size	= ch_6_src_burst_size;
			dma1_ch_tts		= ch_6_tts;
			dma1_ch_src_addr	= ch_6_src_addr;
			dma1_ch_dst_addr	= ch_6_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_6_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_6_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_6_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_6_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_6_src_mode;
			dma1_ch_src_request	= ch_6_src_request;
			dma1_ch_dst_mode	= ch_6_dst_mode;
			dma1_ch_dst_request	= ch_6_dst_request;
			dma1_ch_abt		= ch_6_abt;
			dma1_ch_int_tc_mask	= ch_6_int_tc_mask;
			dma1_ch_int_err_mask	= ch_6_int_err_mask;
			dma1_ch_int_abt_mask	= ch_6_int_abt_mask;
		end
		3'h7: begin
			dma1_ch_src_addr_ctl 	= ch_7_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_7_dst_addr_ctl;
			dma1_ch_src_width	= ch_7_src_width;
			dma1_ch_dst_width	= ch_7_dst_width;
			dma1_ch_src_burst_size	= ch_7_src_burst_size;
			dma1_ch_tts		= ch_7_tts;
			dma1_ch_src_addr	= ch_7_src_addr;
			dma1_ch_dst_addr	= ch_7_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_7_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_7_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_7_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_7_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_7_src_mode;
			dma1_ch_src_request	= ch_7_src_request;
			dma1_ch_dst_mode	= ch_7_dst_mode;
			dma1_ch_dst_request	= ch_7_dst_request;
			dma1_ch_abt		= ch_7_abt;
			dma1_ch_int_tc_mask	= ch_7_int_tc_mask;
			dma1_ch_int_err_mask	= ch_7_int_err_mask;
			dma1_ch_int_abt_mask	= ch_7_int_abt_mask;
		end
		default: begin
			dma1_ch_src_addr_ctl 	= ch_0_src_addr_ctl;
			dma1_ch_dst_addr_ctl 	= ch_0_dst_addr_ctl;
			dma1_ch_src_width	= ch_0_src_width;
			dma1_ch_dst_width	= ch_0_dst_width;
			dma1_ch_src_burst_size	= ch_0_src_burst_size;
			dma1_ch_tts		= ch_0_tts;
			dma1_ch_src_addr	= ch_0_src_addr;
			dma1_ch_dst_addr	= ch_0_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_0_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_0_dst_bus_inf_idx;
`endif // ATCDMAC300_DUAL_MASTER_IF_SUPPORT
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_0_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_0_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_0_src_mode;
			dma1_ch_src_request	= ch_0_src_request;
			dma1_ch_dst_mode	= ch_0_dst_mode;
			dma1_ch_dst_request	= ch_0_dst_request;
			dma1_ch_abt		= ch_0_abt;
			dma1_ch_int_tc_mask	= ch_0_int_tc_mask;
			dma1_ch_int_err_mask	= ch_0_int_err_mask;
			dma1_ch_int_abt_mask	= ch_0_int_abt_mask;
		end
	endcase
end
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
// VPERL_GENERATED_END

// VPERL_BEGIN
// my $ack_num=16;
// my $ch_num=8;
// for ($i=0; $i<$ack_num; $i++) {
// :assign dma_ack_nxt[$i] = 
// :`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
// 	for ($j=0; $j<$ch_num; $j++) {
// :	(dma1_ch_${j}_selected & ((dma1_ch_src_ack & ch_${j}_src_mode & (ch_${j}_src_req_sel == 4'h%x)) | (dma1_ch_dst_ack & ch_${j}_dst_mode & (ch_${j}_dst_req_sel == 4'h%x)))) |	:: $i, $i
// 	}
// :`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
// 	for ($j=0; $j<$ch_num; $j++) {
// 		if ($j == $ch_num-1) {
// :	(dma0_ch_${j}_selected & ((dma0_ch_src_ack & ch_${j}_src_mode & (ch_${j}_src_req_sel == 4'h%x)) | (dma0_ch_dst_ack & ch_${j}_dst_mode & (ch_${j}_dst_req_sel == 4'h%x))));		:: $i, $i
// 		}
// 		else {
// :	(dma0_ch_${j}_selected & ((dma0_ch_src_ack & ch_${j}_src_mode & (ch_${j}_src_req_sel == 4'h%x)) | (dma0_ch_dst_ack & ch_${j}_dst_mode & (ch_${j}_dst_req_sel == 4'h%x)))) |	:: $i, $i
// 		}
// 	}
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
assign dma_ack_nxt[0] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h0)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h0)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h0)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h0)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h0)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h0)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h0)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h0)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h0)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h0)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h0)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h0)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h0)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h0)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h0)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h0))));
assign dma_ack_nxt[1] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h1)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h1)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h1)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h1)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h1)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h1)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h1)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h1)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h1)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h1)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h1)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h1)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h1)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h1)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h1)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h1))));
assign dma_ack_nxt[2] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h2)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h2)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h2)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h2)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h2)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h2)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h2)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h2)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h2)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h2)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h2)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h2)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h2)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h2)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h2)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h2))));
assign dma_ack_nxt[3] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h3)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h3)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h3)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h3)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h3)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h3)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h3)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h3)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h3)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h3)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h3)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h3)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h3)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h3)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h3)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h3))));
assign dma_ack_nxt[4] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h4)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h4)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h4)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h4)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h4)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h4)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h4)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h4)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h4)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h4)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h4)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h4)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h4)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h4)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h4)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h4))));
assign dma_ack_nxt[5] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h5)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h5)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h5)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h5)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h5)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h5)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h5)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h5)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h5)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h5)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h5)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h5)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h5)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h5)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h5)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h5))));
assign dma_ack_nxt[6] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h6)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h6)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h6)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h6)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h6)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h6)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h6)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h6)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h6)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h6)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h6)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h6)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h6)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h6)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h6)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h6))));
assign dma_ack_nxt[7] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h7)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h7)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h7)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h7)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h7)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h7)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h7)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h7)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h7)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h7)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h7)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h7)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h7)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h7)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h7)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h7))));
assign dma_ack_nxt[8] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h8)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h8)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h8)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h8)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h8)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h8)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h8)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h8)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h8)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h8)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h8)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h8)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h8)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h8)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h8)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h8))));
assign dma_ack_nxt[9] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h9)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h9)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h9)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h9)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h9)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h9)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h9)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h9)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h9)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h9)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h9)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h9)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h9)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h9)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h9)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h9))));
assign dma_ack_nxt[10] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'ha)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'ha)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'ha)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'ha)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'ha)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'ha)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'ha)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'ha)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'ha)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'ha)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'ha)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'ha)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'ha)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'ha)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'ha)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'ha))));
assign dma_ack_nxt[11] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hb)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hb)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hb)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hb)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hb)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hb)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hb)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hb)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hb)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hb)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hb)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hb)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hb)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hb)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hb)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hb))));
assign dma_ack_nxt[12] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hc)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hc)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hc)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hc)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hc)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hc)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hc)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hc)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hc)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hc)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hc)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hc)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hc)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hc)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hc)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hc))));
assign dma_ack_nxt[13] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hd)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hd)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hd)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hd)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hd)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hd)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hd)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hd)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hd)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hd)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hd)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hd)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hd)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hd)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hd)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hd))));
assign dma_ack_nxt[14] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'he)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'he)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'he)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'he)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'he)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'he)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'he)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'he)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'he)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'he)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'he)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'he)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'he)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'he)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'he)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'he))));
assign dma_ack_nxt[15] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma1_ch_0_selected & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hf)))) |
	(dma1_ch_1_selected & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hf)))) |
	(dma1_ch_2_selected & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hf)))) |
	(dma1_ch_3_selected & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hf)))) |
	(dma1_ch_4_selected & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hf)))) |
	(dma1_ch_5_selected & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hf)))) |
	(dma1_ch_6_selected & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hf)))) |
	(dma1_ch_7_selected & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hf)))) |
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(dma0_ch_0_selected & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hf)))) |
	(dma0_ch_1_selected & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hf)))) |
	(dma0_ch_2_selected & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hf)))) |
	(dma0_ch_3_selected & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hf)))) |
	(dma0_ch_4_selected & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hf)))) |
	(dma0_ch_5_selected & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hf)))) |
	(dma0_ch_6_selected & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hf)))) |
	(dma0_ch_7_selected & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hf))));
// VPERL_GENERATED_END

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma_ack <= {`ATCDMAC300_REQ_ACK_NUM{1'b0}};
	end
	else begin
		dma_ack	<= dma_ack_nxt[`ATCDMAC300_REQ_ACK_NUM-1:0];
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma0_current_channel <= 3'b0;
	end
	else if (dma_soft_reset) begin
		dma0_current_channel <= 3'b0;
	end
	else if (dma0_arb_en && (!dma0_arb_end)) begin
		dma0_current_channel <= dma0_current_channel_nxt;
	end
end

`ifdef ATCDMAC300_REQ_SYNC_SUPPORT
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma_req_sync1 <= {`ATCDMAC300_REQ_ACK_NUM{1'b0}};
		dma_req_sync2 <= {`ATCDMAC300_REQ_ACK_NUM{1'b0}};
	end
	else begin
		dma_req_sync1 <= dma_req;
		dma_req_sync2 <= dma_req_sync1;
	end
end

assign	dma_req_16b = {{17-`ATCDMAC300_REQ_ACK_NUM{1'b0}}, dma_req_sync2};
`else
assign	dma_req_16b = {{17-`ATCDMAC300_REQ_ACK_NUM{1'b0}}, dma_req};
`endif


// channel arbitration
wire [7:0] ch_request_en;

assign	dma0_current_channel_nxt = granted_channel;

assign	ch_request_en 	= {ch_7_request_en, ch_6_request_en, ch_5_request_en, ch_4_request_en, 
			   ch_3_request_en, ch_2_request_en, ch_1_request_en, ch_0_request_en};
assign	ch_level 	= {ch_7_priority, ch_6_priority, ch_5_priority, ch_4_priority, 
			   ch_3_priority, ch_2_priority, ch_1_priority, ch_0_priority};
assign	dma0_arb_en	= (dma0_idle_state && (|dma0_ch_request) && (!grant_dma1_arb));

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma0_arb_end <= 1'b0;
	end
	else begin
		dma0_arb_end <= dma0_arb_en;
	end
end

`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
assign	dma0_ch_request_mask[0] = (dma0_current_channel == 3'h0) && (!dma0_idle_state);
assign	dma0_ch_request_mask[1] = (dma0_current_channel == 3'h1) && (!dma0_idle_state);
assign	dma0_ch_request_mask[2] = (dma0_current_channel == 3'h2) && (!dma0_idle_state);
assign	dma0_ch_request_mask[3] = (dma0_current_channel == 3'h3) && (!dma0_idle_state);
assign	dma0_ch_request_mask[4] = (dma0_current_channel == 3'h4) && (!dma0_idle_state);
assign	dma0_ch_request_mask[5] = (dma0_current_channel == 3'h5) && (!dma0_idle_state);
assign	dma0_ch_request_mask[6] = (dma0_current_channel == 3'h6) && (!dma0_idle_state);
assign	dma0_ch_request_mask[7] = (dma0_current_channel == 3'h7) && (!dma0_idle_state);

assign	dma1_ch_request_mask[0] = (dma1_current_channel == 3'h0) && (!dma1_idle_state);
assign	dma1_ch_request_mask[1] = (dma1_current_channel == 3'h1) && (!dma1_idle_state);
assign	dma1_ch_request_mask[2] = (dma1_current_channel == 3'h2) && (!dma1_idle_state);
assign	dma1_ch_request_mask[3] = (dma1_current_channel == 3'h3) && (!dma1_idle_state);
assign	dma1_ch_request_mask[4] = (dma1_current_channel == 3'h4) && (!dma1_idle_state);
assign	dma1_ch_request_mask[5] = (dma1_current_channel == 3'h5) && (!dma1_idle_state);
assign	dma1_ch_request_mask[6] = (dma1_current_channel == 3'h6) && (!dma1_idle_state);
assign	dma1_ch_request_mask[7] = (dma1_current_channel == 3'h7) && (!dma1_idle_state);

assign	dma1_current_channel_nxt = granted_channel;
assign	dma1_arb_en		 = (dma1_idle_state && (!(dma0_arb_en  ||  dma0_arb_end)) && (|dma1_ch_request));
assign	grant_dma1_arb_nx	 = (grant_dma1_arb  &&    dma1_arb_en) || (dma1_arb_en    && (!dma0_arb_en));
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma1_current_channel <= 3'b0;
	end
	else if (dma_soft_reset) begin
		dma1_current_channel <= 3'b0;
	end
	else if (dma1_arb_en && (!dma1_arb_end)) begin
		dma1_current_channel <= dma1_current_channel_nxt;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma1_arb_end 	<= 1'b0;
		grant_dma1_arb	<= 1'b0;
	end
	else begin
		dma1_arb_end 	<= dma1_arb_en;
		grant_dma1_arb	<= grant_dma1_arb_nx;
	end
end
assign	dma0_ch_request =  ch_request_en     & (~dma1_ch_request_mask);
assign	dma1_ch_request =  ch_request_en     & (~dma0_ch_request_mask);
assign	current_channel =  grant_dma1_arb_nx ?   dma1_current_channel : dma0_current_channel;
assign	ch_request      =  grant_dma1_arb_nx ?   dma1_ch_request      : dma0_ch_request;
`else // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
assign	current_channel	=  dma0_current_channel;
assign	ch_request	=  ch_request_en;
`endif // ATCDMAC300_DUAL_DMA_CORE_SUPPORT
endmodule
