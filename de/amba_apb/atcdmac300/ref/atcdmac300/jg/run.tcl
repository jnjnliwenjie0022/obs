clear -all
source $env(PVC_LOCALDIR)/andes_vip/scripts/jg_prolog.tcl
use_axi4_ipk
use_apb_ipk

analyze -sv    $PVC_LOCALDIR/andes_ip/peripheral_ip/atcdmac300/jg/atcdmac300_config_llp.vh
analyze -sv -f $PVC_LOCALDIR/andes_ip/peripheral_ip/atcdmac300/jg/flist.f
analyze -sv    $PVC_LOCALDIR/andes_ip/peripheral_ip/atcdmac300/jg/system.sv

elaborate
clock aclk pclk
#clock pclk
reset -expression !(aresetn) !(presetn)
#reset -expression  !(presetn)

set_engine_mode {Ht Hp B N I K C C2}

assume  {paddr[1:0] == 2'b0}
# soruce address word aligned
assume	{m0_araddr[1:0] == 2'h0}

#Ignore dma_soft_reset
assume	{atcdmac300.dma_soft_reset != 1'b1} 

#Ignore Link List Descriptor corss 4K boundary
assume  {atcdmac300.atcdmac300_engine_0.ch_llp[4:3] == 2'b0}
assume  {atcdmac300.atcdmac300_engine_1.ch_llp[4:3] == 2'b0}

# When channel n is enabled, do not program this channel again.
assume  {!(atcdmac300.ch_0_en && atcdmac300.atcdmac300_register.ch_0_ctl_w_sel)}
assume  {!(atcdmac300.ch_0_en && atcdmac300.atcdmac300_register.ch_0_tts_w_sel)}
assume  {!(atcdmac300.ch_0_en && atcdmac300.atcdmac300_register.ch_0_src_addr_w_sel)}
assume  {!(atcdmac300.ch_0_en && atcdmac300.atcdmac300_register.ch_0_dst_addr_w_sel)}
assume  {!(atcdmac300.ch_0_en && atcdmac300.atcdmac300_register.ch_0_llp_w_sel)}

assume  {!(atcdmac300.ch_1_en && atcdmac300.atcdmac300_register.ch_1_ctl_w_sel)}
assume  {!(atcdmac300.ch_1_en && atcdmac300.atcdmac300_register.ch_1_tts_w_sel)}
assume  {!(atcdmac300.ch_1_en && atcdmac300.atcdmac300_register.ch_1_src_addr_w_sel)}
assume  {!(atcdmac300.ch_1_en && atcdmac300.atcdmac300_register.ch_1_dst_addr_w_sel)}
assume  {!(atcdmac300.ch_1_en && atcdmac300.atcdmac300_register.ch_1_llp_w_sel)}

assume  {!(atcdmac300.ch_2_en && atcdmac300.atcdmac300_register.ch_2_ctl_w_sel)}
assume  {!(atcdmac300.ch_2_en && atcdmac300.atcdmac300_register.ch_2_tts_w_sel)}
assume  {!(atcdmac300.ch_2_en && atcdmac300.atcdmac300_register.ch_2_src_addr_w_sel)}
assume  {!(atcdmac300.ch_2_en && atcdmac300.atcdmac300_register.ch_2_dst_addr_w_sel)}
assume  {!(atcdmac300.ch_2_en && atcdmac300.atcdmac300_register.ch_2_llp_w_sel)}

assume  {!(atcdmac300.ch_3_en && atcdmac300.atcdmac300_register.ch_3_ctl_w_sel)}
assume  {!(atcdmac300.ch_3_en && atcdmac300.atcdmac300_register.ch_3_tts_w_sel)}
assume  {!(atcdmac300.ch_3_en && atcdmac300.atcdmac300_register.ch_3_src_addr_w_sel)}
assume  {!(atcdmac300.ch_3_en && atcdmac300.atcdmac300_register.ch_3_dst_addr_w_sel)}
assume  {!(atcdmac300.ch_3_en && atcdmac300.atcdmac300_register.ch_3_llp_w_sel)}

#assume  {!(atcdmac300.ch_4_en && atcdmac300.atcdmac300_register.ch_4_ctl_w_sel)}
#assume  {!(atcdmac300.ch_4_en && atcdmac300.atcdmac300_register.ch_4_tts_w_sel)}
#assume  {!(atcdmac300.ch_4_en && atcdmac300.atcdmac300_register.ch_4_src_addr_w_sel)}
#assume  {!(atcdmac300.ch_4_en && atcdmac300.atcdmac300_register.ch_4_dst_addr_w_sel)}
#assume  {!(atcdmac300.ch_4_en && atcdmac300.atcdmac300_register.ch_4_llp_w_sel)}

#assume  {!(atcdmac300.ch_5_en && atcdmac300.atcdmac300_register.ch_5_ctl_w_sel)}
#assume  {!(atcdmac300.ch_5_en && atcdmac300.atcdmac300_register.ch_5_tts_w_sel)}
#assume  {!(atcdmac300.ch_5_en && atcdmac300.atcdmac300_register.ch_5_src_addr_w_sel)}
#assume  {!(atcdmac300.ch_5_en && atcdmac300.atcdmac300_register.ch_5_dst_addr_w_sel)}
#assume  {!(atcdmac300.ch_5_en && atcdmac300.atcdmac300_register.ch_5_llp_w_sel)}

#assume  {!(atcdmac300.ch_6_en && atcdmac300.atcdmac300_register.ch_6_ctl_w_sel)}
#assume  {!(atcdmac300.ch_6_en && atcdmac300.atcdmac300_register.ch_6_tts_w_sel)}
#assume  {!(atcdmac300.ch_6_en && atcdmac300.atcdmac300_register.ch_6_src_addr_w_sel)}
#assume  {!(atcdmac300.ch_6_en && atcdmac300.atcdmac300_register.ch_6_dst_addr_w_sel)}
#assume  {!(atcdmac300.ch_6_en && atcdmac300.atcdmac300_register.ch_6_llp_w_sel)}

#assume  {!(atcdmac300.ch_7_en && atcdmac300.atcdmac300_register.ch_7_ctl_w_sel)}
#assume  {!(atcdmac300.ch_7_en && atcdmac300.atcdmac300_register.ch_7_tts_w_sel)}
#assume  {!(atcdmac300.ch_7_en && atcdmac300.atcdmac300_register.ch_7_src_addr_w_sel)}
#assume  {!(atcdmac300.ch_7_en && atcdmac300.atcdmac300_register.ch_7_dst_addr_w_sel)}
#assume  {!(atcdmac300.ch_7_en && atcdmac300.atcdmac300_register.ch_7_llp_w_sel)}

### APB Waive List ###
cover -disable <embedded>::system.dmac300_apb_slave.COV_S_PSLVERR_cfg_err

### AXI4 Waive List ###
# Wrap transfer is not supported
assert -disable <embedded>::system.axi4_vip.gen_AST_M_ARADDR_wrap_align_4B.AST_M_ARADDR_wrap_align_4B
assert -disable <embedded>::system.axi4_vip.gen_AST_M_AWADDR_wrap_align_4B.AST_M_AWADDR_wrap_align_4B
assert -disable <embedded>::system.axi4_vip.gen_AST_M_AWADDR_wrap_align_2B.AST_M_AWADDR_wrap_align_2B
assert -disable <embedded>::system.axi4_vip.gen_AST_M_ARADDR_wrap_align_2B.AST_M_ARADDR_wrap_align_2B

assert -disable <embedded>::system.axi4_vip.gen_AST_M_AWLEN_wrap.AST_M_AWLEN_wrap
assert -disable <embedded>::system.axi4_vip.gen_AST_M_ARLEN_wrap.AST_M_ARLEN_wrap
cover -disable <embedded>::system.axi4_vip.gen_COV_M_AWBURST_cfg_wrap.COV_M_AWBURST_cfg_wrap
cover -disable <embedded>::system.axi4_vip.gen_COV_M_ARBURST_cfg_wrap.COV_M_ARBURST_cfg_wrap

# Cacheable/Bufferable are not supported
cover -disable <embedded>::system.axi4_vip.gen_COV_M_Cacheable.COV_M_Cacheable
cover -disable <embedded>::system.axi4_vip.gen_COV_M_Bufferable.COV_M_Bufferable
cover -disable <embedded>::system.axi4_vip.gen_COV_M_Cacheable_bufferable.COV_M_Cacheable_bufferable
cover -disable <embedded>::system.axi4_vip.gen_COV_M_ARCACHE_cfg_cacheable.COV_M_ARCACHE_cfg_cacheable
cover -disable <embedded>::system.axi4_vip.gen_COV_M_AWCACHE_cfg_cacheable.COV_M_AWCACHE_cfg_cacheable
cover -disable <embedded>::system.axi4_vip.gen_COV_M_Cacheable_writeback_rw.COV_M_Cacheable_writeback_rw
cover -disable <embedded>::system.axi4_vip.gen_COV_M_Cacheable_writeback_read.COV_M_Cacheable_writeback_read
cover -disable <embedded>::system.axi4_vip.gen_COV_M_Cacheable_writeback_write.COV_M_Cacheable_writeback_write
cover -disable <embedded>::system.axi4_vip.gen_COV_M_Cacheable_writethrough_rw.COV_M_Cacheable_writethrough_rw
cover -disable <embedded>::system.axi4_vip.gen_COV_M_Cacheable_writethrough_read.COV_M_Cacheable_writethrough_read
cover -disable <embedded>::system.axi4_vip.gen_COV_M_Cacheable_writethrough_write.COV_M_Cacheable_writethrough_write

# Read/Write protection is not supported
cover -disable <embedded>::system.axi4_vip.gen_COV_M_ARPROT_cfg_non_secure.COV_M_ARPROT_cfg_non_secure
cover -disable <embedded>::system.axi4_vip.gen_COV_M_AWPROT_cfg_non_secure.COV_M_AWPROT_cfg_non_secure
cover -disable <embedded>::system.axi4_vip.gen_COV_M_ARPROT_cfg_privileged.COV_M_ARPROT_cfg_privileged
cover -disable <embedded>::system.axi4_vip.gen_COV_M_AWPROT_cfg_privileged.COV_M_AWPROT_cfg_privileged
cover -disable <embedded>::system.axi4_vip.gen_COV_M_ARPROT_cfg_instruction.COV_M_ARPROT_cfg_instruction
cover -disable <embedded>::system.axi4_vip.gen_COV_M_AWPROT_cfg_instruction.COV_M_AWPROT_cfg_instruction

# BREADY is always asserted when write command is received. The (BVALID && !BREADY) couldn't be covered
cover -disable <embedded>::system.axi4_vip.gen_ASM_S_BID_stable.ASM_S_BID_stable:precondition1
cover -disable <embedded>::system.axi4_vip.gen_ASM_S_BRESP_stable.ASM_S_BRESP_stable:precondition1
cover -disable <embedded>::system.axi4_vip.gen_ASM_S_BVALID_stable.ASM_S_BVALID_stable:precondition1
cover -disable <embedded>::system.axi4_vip.gen_ASM_S_BUSER_stable.ASM_S_BUSER_stable:precondition1

# RREADY is always asserted because DMAC300 always issues read request data bytes <= FIFO spaces
cover -disable <embedded>::system.axi4_vip.gen_ASM_S_RID_stable.ASM_S_RID_stable:precondition1
cover -disable <embedded>::system.axi4_vip.gen_ASM_S_RDATA_stable.ASM_S_RDATA_stable:precondition1
cover -disable <embedded>::system.axi4_vip.gen_ASM_S_RRESP_stable.ASM_S_RRESP_stable:precondition1
cover -disable <embedded>::system.axi4_vip.gen_ASM_S_RLAST_stable.ASM_S_RLAST_stable:precondition1
cover -disable <embedded>::system.axi4_vip.gen_ASM_S_RVALID_stable.ASM_S_RVALID_stable:precondition1
cover -disable <embedded>::system.axi4_vip.gen_ASM_S_RUSER_stable.ASM_S_RUSER_stable:precondition1
 
cover -disable <embedded>::system.axi4_vip.gen_AST_param_RMAXBURSTS_large_enough.AST_param_RMAXBURSTS_large_enough:precondition1
