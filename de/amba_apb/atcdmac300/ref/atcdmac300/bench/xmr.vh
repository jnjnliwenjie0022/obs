// XMR definitions
`ifdef NDS_XMR_VH
`else // NDS_XMR_VH
`define NDS_XMR_VH

`define NDS_SYSTEM	system
`define NDS_BENCH	`NDS_SYSTEM.bench

`define NDS_DMAC	`NDS_SYSTEM.dmac300

`define APB_MASTER1	`NDS_SYSTEM.apb_master1
`define AXI_SLAVE0	`NDS_SYSTEM.axi_slave0
`define AXI_SLAVE1	`NDS_SYSTEM.axi_slave1

// Scoreboard monitor sources.
`define NDS_SCB		`NDS_SYSTEM.blk_scb

`endif // NDS_XMR_VH

