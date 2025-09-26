// XMR definitions
`ifdef NDS_XMR_VH
`else // NDS_XMR_VH
`define NDS_XMR_VH

`define NDS_SYSTEM	system
`define NDS_BENCH	`NDS_SYSTEM.bench

`define NDS_BMC		`NDS_SYSTEM.bmc300

// Scoreboard monitor sources.
`define NDS_SCB		`NDS_SYSTEM.blk_scb

`endif // NDS_XMR_VH

