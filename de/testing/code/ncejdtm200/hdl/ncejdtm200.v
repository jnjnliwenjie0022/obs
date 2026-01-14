// VPERL_BEGIN
// 
// &MODULE("ncejdtm200");
//
// &PARAM("DEBUG_INTERFACE = \"jtag\"");
// &PARAM("SYNC_STAGE = 2");
// &PARAM("DMI_ADDR_BITS = 7");
// &LOCALPARAM("DMI_DATA_BITS = 32");
// &LOCALPARAM("DMI_OP_BITS   = 2");
//
// &LOCALPARAM("DMI_REG_BITS = DMI_DATA_BITS + DMI_ADDR_BITS + DMI_OP_BITS");
//
// &FORCE("input", "tdi");
// &FORCE("input", "tms");
// &FORCE("input", "tck");
// &FORCE("input", "pwr_rst_n");
// &FORCE("output", "tdo");
// &FORCE("output", "tdo_out_en");
// &FORCE("input", "test_mode");
// 
// &FORCE("input", "dmi_hclk");
// &FORCE("input", "dmi_hresp");
// &FORCE("input", "dmi_hready");
// &FORCE("input", "dmi_hrdata[31:0]");
// &FORCE("output", "dmi_hresetn");
// &FORCE("output", "dmi_haddr[31:0]");
// &FORCE("output", "dmi_htrans[1:0]");
// &FORCE("output", "dmi_hwrite");
// &FORCE("output", "dmi_hsize[2:0]");
// &FORCE("output", "dmi_hburst[2:0]");
// &FORCE("output", "dmi_hprot[3:0]");
// &FORCE("output", "dmi_hwdata[31:0]");
// &FORCE("output", "dmi_hsel");
//
// &PORT_ORDER("test_mode");
// &PORT_ORDER("pwr_rst_n");
// &PORT_ORDER("tck");
// &PORT_ORDER("tms");
// &PORT_ORDER("tdi");
// &PORT_ORDER("tdo");
// &PORT_ORDER("tdo_out_en");
//
// &PORT_ORDER("dmi_hresetn");
// &PORT_ORDER("dmi_hclk");
// &PORT_ORDER("dmi_hsel");
// &PORT_ORDER("dmi_htrans");
// &PORT_ORDER("dmi_haddr");
// &PORT_ORDER("dmi_hsize");
// &PORT_ORDER("dmi_hburst");
// &PORT_ORDER("dmi_hprot");
// &PORT_ORDER("dmi_hwdata");
// &PORT_ORDER("dmi_hwrite");
// &PORT_ORDER("dmi_hrdata");
// &PORT_ORDER("dmi_hready");
// &PORT_ORDER("dmi_hresp");
//
// &FORCE("wire", "dtm_dmi_resetn");
// &FORCE("wire", "pwr_rst_n_tck");
// &FORCE("wire", "pwr_rst_n_dmi");
//
// &FORCE("wire", "nds_unused_b_rise[1:0]");
// &FORCE("wire", "nds_unused_b_fall[1:0]");
// &FORCE("wire", "nds_unused_b_edge[1:0]");
// &FORCE("wire", "nds_unused_wire");
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_tap.v", "ncejdtm200_tap", {
// 	DEBUG_INTERFACE	=> "DEBUG_INTERFACE",
// 	DMI_ADDR_BITS	=> "DMI_ADDR_BITS",
// });
// &CONNECT("ncejdtm200_tap", {
//	tap_dmi_req	=> "tap_dmi_tck_req",
//	dmi_tap_ack	=> "dmi_tap_tck_ack",
//	pwr_rst_n	=> "pwr_rst_n_tck",
// });
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_dmi.v", "ncejdtm200_dmi", {
//      DMI_ADDR_BITS   => "DMI_ADDR_BITS"
// });
// &CONNECT("ncejdtm200_dmi", {
//	tap_dmi_req	=> "tap_dmi_hclk_req",
//	dmi_tap_ack	=> "dmi_tap_hclk_ack",
// });
//
// &DANGLER("b_signal_rising_edge_pulse");
// &DANGLER("b_signal_falling_edge_pulse");
// &DANGLER("b_signal_edge_pulse");
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/macro/nds_sync_l2l.v", "nds_sync_tap_dmi", {
//      RESET_VALUE     => "1'b0",
//      SYNC_STAGE      => "SYNC_STAGE",
// });
// &CONNECT("nds_sync_tap_dmi", {
// 	b_reset_n			=> "pwr_rst_n_dmi",
// 	b_clk				=> "dmi_hclk",
// 	a_signal			=> "tap_dmi_tck_req",
// 	b_signal			=> "tap_dmi_hclk_req",
//	b_signal_rising_edge_pulse	=> "nds_unused_b_rise[0]",
//	b_signal_falling_edge_pulse	=> "nds_unused_b_fall[0]",
//	b_signal_edge_pulse		=> "nds_unused_b_edge[0]",
// });
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/macro/nds_rst_sync.v", "nds_sync_dtm_dmi_rst");
// &CONNECT("nds_sync_dtm_dmi_rst", {
//      test_mode                       => "test_mode",
//      test_resetn_in                  => "pwr_rst_n",
// 	resetn_in			=> "dtm_dmi_resetn",
// 	clk				=> "dmi_hclk",
// 	resetn_out			=> "dmi_hresetn",
// });
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/macro/nds_sync_l2l.v", "nds_sync_dmi_tap", {
//      RESET_VALUE     => "1'b0",
//      SYNC_STAGE      => "SYNC_STAGE",
// });
// &CONNECT("nds_sync_dmi_tap", {
// 	b_reset_n			=> "pwr_rst_n_tck",
// 	b_clk				=> "tck",
// 	a_signal			=> "dmi_tap_hclk_ack",
// 	b_signal			=> "dmi_tap_tck_ack",
//	b_signal_rising_edge_pulse	=> "nds_unused_b_rise[1]",
//	b_signal_falling_edge_pulse	=> "nds_unused_b_fall[1]",
//	b_signal_edge_pulse		=> "nds_unused_b_edge[1]",
// });
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/macro/nds_rst_sync.v", "nds_sync_pwr_rst_tck");
// &CONNECT("nds_sync_pwr_rst_tck", {
//      test_mode                       => "test_mode",
//      test_resetn_in                  => "pwr_rst_n",
// 	resetn_in			=> "pwr_rst_n",
// 	clk				=> "tck",
// 	resetn_out			=> "pwr_rst_n_tck",
// });
//
// &INSTANCE("$PVC_LOCALDIR/andes_ip/macro/nds_rst_sync.v", "nds_sync_pwr_rst_dmi");
// &CONNECT("nds_sync_pwr_rst_dmi", {
//      test_mode                       => "test_mode",
// 	test_resetn_in			=> "pwr_rst_n",
// 	resetn_in                       => "pwr_rst_n",
// 	clk				=> "dmi_hclk",
// 	resetn_out			=> "pwr_rst_n_dmi",
// });
//
//: assign nds_unused_wire = (|nds_unused_b_rise) | (|nds_unused_b_fall) | (|nds_unused_b_edge);
//
// &ENDMODULE;
//
// VPERL_END

// VPERL_GENERATED_BEGIN
module ncejdtm200 (
	  dbg_wakeup_req, // (ncejdtm200_tap) => ()
	  tms_out_en,     // (ncejdtm200_tap) => ()
	  test_mode,      // (nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_pwr_rst_tck) <= ()
	  pwr_rst_n,      // (nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_pwr_rst_tck) <= ()
	  tck,            // (ncejdtm200_tap,nds_sync_dmi_tap,nds_sync_pwr_rst_tck) <= ()
	  tms,            // (ncejdtm200_tap) <= ()
	  tdi,            // (ncejdtm200_tap) <= ()
	  tdo,            // (ncejdtm200_tap) => ()
	  tdo_out_en,     // (ncejdtm200_tap) => ()
	  dmi_hresetn,    // (nds_sync_dtm_dmi_rst) => (ncejdtm200_dmi)
	  dmi_hclk,       // (ncejdtm200_dmi,nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_tap_dmi) <= ()
	  dmi_hsel,       // (ncejdtm200_dmi) => ()
	  dmi_htrans,     // (ncejdtm200_dmi) => ()
	  dmi_haddr,      // (ncejdtm200_dmi) => ()
	  dmi_hsize,      // (ncejdtm200_dmi) => ()
	  dmi_hburst,     // (ncejdtm200_dmi) => ()
	  dmi_hprot,      // (ncejdtm200_dmi) => ()
	  dmi_hwdata,     // (ncejdtm200_dmi) => ()
	  dmi_hwrite,     // (ncejdtm200_dmi) => ()
	  dmi_hrdata,     // (ncejdtm200_dmi) <= ()
	  dmi_hready,     // (ncejdtm200_dmi) <= ()
	  dmi_hresp       // (ncejdtm200_dmi) <= ()
);

parameter DEBUG_INTERFACE = "jtag";
parameter SYNC_STAGE = 2;
parameter DMI_ADDR_BITS = 7;

localparam DMI_DATA_BITS = 32;
localparam DMI_OP_BITS   = 2;
localparam DMI_REG_BITS = DMI_DATA_BITS + DMI_ADDR_BITS + DMI_OP_BITS;

output             dbg_wakeup_req;
output             tms_out_en;
input              test_mode;
input              pwr_rst_n;
input              tck;             // clock domain b_clk
input              tms;
input              tdi;
output             tdo;
output             tdo_out_en;
output             dmi_hresetn;
input              dmi_hclk;        // clock domain b_clk
output             dmi_hsel;
output       [1:0] dmi_htrans;
output      [31:0] dmi_haddr;
output       [2:0] dmi_hsize;
output       [2:0] dmi_hburst;
output       [3:0] dmi_hprot;
output      [31:0] dmi_hwdata;
output             dmi_hwrite;
input       [31:0] dmi_hrdata;
input              dmi_hready;
input              dmi_hresp;

wire                             nds_unused_wire;
wire                             dmi_tap_hclk_ack;
wire                      [31:0] dmi_tap_hrdata;
wire                             dtm_dmi_resetn;
wire        [(DMI_REG_BITS-1):0] tap_dmi_data;
wire                             tap_dmi_tck_req;
wire                             dmi_tap_tck_ack;
wire                       [1:0] nds_unused_b_edge;
wire                       [1:0] nds_unused_b_fall;
wire                       [1:0] nds_unused_b_rise;
wire                             pwr_rst_n_dmi;
wire                             pwr_rst_n_tck;
wire                             tap_dmi_hclk_req;

assign nds_unused_wire = (|nds_unused_b_rise) | (|nds_unused_b_fall) | (|nds_unused_b_edge);

ncejdtm200_tap #(
	.DEBUG_INTERFACE (DEBUG_INTERFACE ),
	.DMI_ADDR_BITS   (DMI_ADDR_BITS   )
) ncejdtm200_tap (
	.dbg_wakeup_req(dbg_wakeup_req ), // (ncejdtm200_tap) => ()
	.tms_out_en    (tms_out_en     ), // (ncejdtm200_tap) => ()
	.tdi           (tdi            ), // (ncejdtm200_tap) <= ()
	.tms           (tms            ), // (ncejdtm200_tap) <= ()
	.tdo           (tdo            ), // (ncejdtm200_tap) => ()
	.tdo_out_en    (tdo_out_en     ), // (ncejdtm200_tap) => ()
	.tck           (tck            ), // (ncejdtm200_tap,nds_sync_dmi_tap,nds_sync_pwr_rst_tck) <= ()
	.pwr_rst_n     (pwr_rst_n_tck  ), // (ncejdtm200_tap,nds_sync_dmi_tap) <= (nds_sync_pwr_rst_tck)
	.dmi_tap_hrdata(dmi_tap_hrdata ), // (ncejdtm200_tap) <= (ncejdtm200_dmi)
	.dmi_tap_ack   (dmi_tap_tck_ack), // (ncejdtm200_tap) <= (nds_sync_dmi_tap)
	.tap_dmi_req   (tap_dmi_tck_req), // (ncejdtm200_tap) => (nds_sync_tap_dmi)
	.tap_dmi_data  (tap_dmi_data   ), // (ncejdtm200_tap) => (ncejdtm200_dmi)
	.dtm_dmi_resetn(dtm_dmi_resetn )  // (ncejdtm200_tap) => (nds_sync_dtm_dmi_rst)
); // end of ncejdtm200_tap

ncejdtm200_dmi #(
	.DMI_ADDR_BITS   (DMI_ADDR_BITS   )
) ncejdtm200_dmi (
	.dmi_hresetn   (dmi_hresetn     ), // (ncejdtm200_dmi) <= (nds_sync_dtm_dmi_rst)
	.dmi_tap_hrdata(dmi_tap_hrdata  ), // (ncejdtm200_dmi) => (ncejdtm200_tap)
	.dmi_tap_ack   (dmi_tap_hclk_ack), // (ncejdtm200_dmi) => (nds_sync_dmi_tap)
	.tap_dmi_req   (tap_dmi_hclk_req), // (ncejdtm200_dmi) <= (nds_sync_tap_dmi)
	.tap_dmi_data  (tap_dmi_data    ), // (ncejdtm200_dmi) <= (ncejdtm200_tap)
	.dmi_hclk      (dmi_hclk        ), // (ncejdtm200_dmi,nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_tap_dmi) <= ()
	.dmi_hresp     (dmi_hresp       ), // (ncejdtm200_dmi) <= ()
	.dmi_hready    (dmi_hready      ), // (ncejdtm200_dmi) <= ()
	.dmi_hrdata    (dmi_hrdata      ), // (ncejdtm200_dmi) <= ()
	.dmi_haddr     (dmi_haddr       ), // (ncejdtm200_dmi) => ()
	.dmi_htrans    (dmi_htrans      ), // (ncejdtm200_dmi) => ()
	.dmi_hwrite    (dmi_hwrite      ), // (ncejdtm200_dmi) => ()
	.dmi_hsize     (dmi_hsize       ), // (ncejdtm200_dmi) => ()
	.dmi_hburst    (dmi_hburst      ), // (ncejdtm200_dmi) => ()
	.dmi_hprot     (dmi_hprot       ), // (ncejdtm200_dmi) => ()
	.dmi_hwdata    (dmi_hwdata      ), // (ncejdtm200_dmi) => ()
	.dmi_hsel      (dmi_hsel        )  // (ncejdtm200_dmi) => ()
); // end of ncejdtm200_dmi

nds_sync_l2l #(
	.RESET_VALUE     (1'b0            ),
	.SYNC_STAGE      (SYNC_STAGE      )
) nds_sync_tap_dmi (
	.b_reset_n                  (pwr_rst_n_dmi       ), // (nds_sync_tap_dmi) <= (nds_sync_pwr_rst_dmi)
	.b_clk                      (dmi_hclk            ), // (ncejdtm200_dmi,nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_tap_dmi) <= ()
	.a_signal                   (tap_dmi_tck_req     ), // (nds_sync_tap_dmi) <= (ncejdtm200_tap)
	.b_signal                   (tap_dmi_hclk_req    ), // (nds_sync_tap_dmi) => (ncejdtm200_dmi)
	.b_signal_rising_edge_pulse (nds_unused_b_rise[0]), // (nds_sync_dmi_tap,nds_sync_tap_dmi) => ()
	.b_signal_falling_edge_pulse(nds_unused_b_fall[0]), // (nds_sync_dmi_tap,nds_sync_tap_dmi) => ()
	.b_signal_edge_pulse        (nds_unused_b_edge[0])  // (nds_sync_dmi_tap,nds_sync_tap_dmi) => ()
); // end of nds_sync_tap_dmi

nds_rst_sync nds_sync_dtm_dmi_rst (
	.test_mode     (test_mode     ), // (nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_pwr_rst_tck) <= ()
	.test_resetn_in(pwr_rst_n     ), // (nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_pwr_rst_tck) <= ()
	.resetn_in     (dtm_dmi_resetn), // (nds_sync_dtm_dmi_rst) <= (ncejdtm200_tap)
	.clk           (dmi_hclk      ), // (ncejdtm200_dmi,nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_tap_dmi) <= ()
	.resetn_out    (dmi_hresetn   )  // (nds_sync_dtm_dmi_rst) => (ncejdtm200_dmi)
); // end of nds_sync_dtm_dmi_rst

nds_sync_l2l #(
	.RESET_VALUE     (1'b0            ),
	.SYNC_STAGE      (SYNC_STAGE      )
) nds_sync_dmi_tap (
	.b_reset_n                  (pwr_rst_n_tck       ), // (ncejdtm200_tap,nds_sync_dmi_tap) <= (nds_sync_pwr_rst_tck)
	.b_clk                      (tck                 ), // (ncejdtm200_tap,nds_sync_dmi_tap,nds_sync_pwr_rst_tck) <= ()
	.a_signal                   (dmi_tap_hclk_ack    ), // (nds_sync_dmi_tap) <= (ncejdtm200_dmi)
	.b_signal                   (dmi_tap_tck_ack     ), // (nds_sync_dmi_tap) => (ncejdtm200_tap)
	.b_signal_rising_edge_pulse (nds_unused_b_rise[1]), // (nds_sync_dmi_tap,nds_sync_tap_dmi) => ()
	.b_signal_falling_edge_pulse(nds_unused_b_fall[1]), // (nds_sync_dmi_tap,nds_sync_tap_dmi) => ()
	.b_signal_edge_pulse        (nds_unused_b_edge[1])  // (nds_sync_dmi_tap,nds_sync_tap_dmi) => ()
); // end of nds_sync_dmi_tap

nds_rst_sync nds_sync_pwr_rst_tck (
	.test_mode     (test_mode    ), // (nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_pwr_rst_tck) <= ()
	.test_resetn_in(pwr_rst_n    ), // (nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_pwr_rst_tck) <= ()
	.resetn_in     (pwr_rst_n    ), // (nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_pwr_rst_tck) <= ()
	.clk           (tck          ), // (ncejdtm200_tap,nds_sync_dmi_tap,nds_sync_pwr_rst_tck) <= ()
	.resetn_out    (pwr_rst_n_tck)  // (nds_sync_pwr_rst_tck) => (ncejdtm200_tap,nds_sync_dmi_tap)
); // end of nds_sync_pwr_rst_tck

nds_rst_sync nds_sync_pwr_rst_dmi (
	.test_mode     (test_mode    ), // (nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_pwr_rst_tck) <= ()
	.test_resetn_in(pwr_rst_n    ), // (nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_pwr_rst_tck) <= ()
	.resetn_in     (pwr_rst_n    ), // (nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_pwr_rst_tck) <= ()
	.clk           (dmi_hclk     ), // (ncejdtm200_dmi,nds_sync_dtm_dmi_rst,nds_sync_pwr_rst_dmi,nds_sync_tap_dmi) <= ()
	.resetn_out    (pwr_rst_n_dmi)  // (nds_sync_pwr_rst_dmi) => (nds_sync_tap_dmi)
); // end of nds_sync_pwr_rst_dmi

endmodule
// VPERL_GENERATED_END
