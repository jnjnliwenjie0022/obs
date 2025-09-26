+libext+.sv+.v

// =============
// Test bench
// =============
$PVC_LOCALDIR/andes_ip/peripheral_ip/atcbmc300/bench/blk_sys.sv
$PVC_LOCALDIR/andes_vip/monitors/hdl/scb_pkg.sv
+incdir+$PVC_LOCALDIR/andes_ip/peripheral_ip/atcbmc300/bench
+incdir+$PVC_LOCALDIR/andes_vip/models/common/hdl
-y $PVC_LOCALDIR/andes_ip/peripheral_ip/atcbmc300/bench


// =============
// RTL
// =============
#include "atcbmc300.f"

// =============
// Model
// =============
-y $PVC_LOCALDIR/andes_vip/models/axi/hdl
+incdir+$PVC_LOCALDIR/andes_vip/models/axi/hdl
+incdir+$PVC_LOCALDIR/andes_vip/monitors/hdl
-y $PVC_LOCALDIR/andes_vip/monitors/hdl

// =============
// Coverage
// =============
#ifdef WITH_COV
+nccovfile+$PVC_LOCALDIR/andes_ip/peripheral_ip/atcbmc300/coverage/atcbmc300_cov.tcl
#endif

