+libext+.sv+.v

// =============
// Test bench
// =============
$PVC_LOCALDIR/andes_ip/peripheral_ip/atcdmac300/bench/blk_sys.sv
+incdir+$PVC_LOCALDIR/andes_ip/peripheral_ip/atcdmac300/bench
+incdir+$PVC_LOCALDIR/andes_vip/models/common/hdl
-y $PVC_LOCALDIR/andes_ip/peripheral_ip/atcdmac300/bench


// =============
// RTL
// =============
#include "atcdmac300.f"

// =============
// Model
// =============
-y $PVC_LOCALDIR/andes_vip/models/axi/hdl
+incdir+$PVC_LOCALDIR/andes_vip/models/axi/hdl
-y $PVC_LOCALDIR/andes_vip/models/apb/hdl
+incdir+$PVC_LOCALDIR/andes_vip/models/apb/hdl
+incdir+$PVC_LOCALDIR/andes_vip/monitors/hdl
-y $PVC_LOCALDIR/andes_vip/monitors/hdl

// =============
// Coverage
// =============
#ifdef WITH_COV
+nccovfile+$PVC_LOCALDIR/andes_ip/peripheral_ip/atcdmac300/coverage/atcdmac300_cov.tcl
#endif

