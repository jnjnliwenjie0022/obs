clear -all

source $env(PVC_LOCALDIR)/andes_vip/scripts/jg_prolog.tcl

#add ipk file:
use_axi4_ipk

#add file/flist
analyze -sv -f atcbmc300.f
analyze -sv bmc300_checker.sv
# analyze -sv constraint_fast.sv
analyze -sv deadlock_checker.sv

elaborate -top atcbmc300

clock aclk
reset -expression !(aresetn)
set_engine_mode {Hp Ht N K I C}

# programming registers should not be changed at arbitrary time
stopat -env ds0_ctrl.reg_mst0_high_priority
stopat -env ds0_ctrl.reg_priority_reload

# these properties will be replaced with checkers in deadlock_checker.sv with property LATENCY limitations
assert -disable atcbmc300.upstream*.gen_AST_S_WREADY_dead.AST_S_WREADY_dead
assert -disable atcbmc300.upstream*.gen_AST_S_AWREADY_dead.AST_S_AWREADY_dead
assert -disable atcbmc300.upstream*.gen_AST_S_ARREADY_dead.AST_S_ARREADY_dead
assert -disable atcbmc300.*.gen_AST_M_RREADY_dead.AST_M_RREADY_dead
assert -disable atcbmc300.*.gen_AST_M_BREADY_dead.AST_M_BREADY_dead

# atcbmc300 does not support *REGION signals:
assert -disable {atcbmc300.*stream[0-9].gen_AST_M_AWREGION_stable.AST_M_AWREGION_stable} -regexp
assert -disable {atcbmc300.*stream[0-9].gen_AST_M_ARREGION_stable.AST_M_ARREGION_stable} -regexp

assert -disable atcbmc300.upstream1.* -regexp
cover -disable atcbmc300.upstream1.* -regexp

# request with addr==0 will not be dispatched to downstream1 and downstream2:
cover -disable atcbmc300.downstream1.gen_COV_M_ReadBurstTrans.COV_M_ReadBurstTrans
cover -disable atcbmc300.downstream2.gen_COV_M_ReadBurstTrans.COV_M_ReadBurstTrans

# long running propertiers that duplicates those in downstream2.
# (use downstream2 as the primary target downstream under verification)
assert -disable atcbmc300.downstream1.*.AST_M_wstrb_align
assert -disable atcbmc300.downstream1.*.AST_M_WLAST_beat

# downstream1 has FIFO_DEPTH=1 so these will never cover:
cover -disable atcbmc300.downstream1.gen_ASM_S_BID_stable.ASM_S_BID_stable:precondition1
cover -disable atcbmc300.downstream1.gen_ASM_S_BRESP_stable.ASM_S_BRESP_stable:precondition1
cover -disable atcbmc300.downstream1.gen_ASM_S_BVALID_stable.ASM_S_BVALID_stable:precondition1
cover -disable atcbmc300.downstream1.gen_ASM_S_BUSER_stable.ASM_S_BUSER_stable:precondition1

# limit the runtime such that the prove job terminates early
set_prove_time_limit 360s
