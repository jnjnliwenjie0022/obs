`include "atcbmc200_config.vh"
`include "atcbmc200_const.vh"

// VPERL_BEGIN
//
// &MODULE("atcbmc200_mst_decoder");
//
// &PARAM("ADDR_WIDTH = `ATCBMC200_ADDR_MSB + 1");
// &PARAM("BASE_ADDR_LSB = (ADDR_WIDTH == 24) ? 10 : 20");
//
// &LOCALPARAM("ADDR_MSB = ADDR_WIDTH - 1");
//
// &IFDEF("ATCBMC200_EXT_ENABLE");
//   # Only for AHB slave 1~10
//   for($i = 1; $i < 11; ++$i) {
//     &FORCE("input", "ahb_slv${i}_en");
//   }
// &ENDIF("ATCBMC200_EXT_ENABLE");
//
// for($i = 0; $i < 16; ++$i) {
//   &IFDEF("ATCBMC200_AHB_SLV${i}");
//   &FORCE("wire", "slv${i}_dec_en");
//   &INSTANCE("$PVC_LOCALDIR/andes_ip/peripheral_ip/atcbmc200/hdl/atcbmc200_addrdec.v", "u_ahb_addrdec${i}", {ADDR_WIDTH => ADDR_WIDTH, BASE_ADDR_LSB => BASE_ADDR_LSB});
//   &CONNECT("u_ahb_addrdec${i}.base", "slv${i}_base");
//   &CONNECT("u_ahb_addrdec${i}.size", "slv${i}_size");
//   &CONNECT("u_ahb_addrdec${i}.sel", "slv${i}_pre_sel");
//   &DANGLER("slv${i}_pre_sel");
//   &FORCE("output", "slv${i}_sel");
//   &CONNECT("u_ahb_addrdec${i}.dec_en", "slv${i}_dec_en");
//   &ENDIF("ATCBMC200_AHB_SLV${i}");
// }
//
//
// &FORCE("input", "dec_en");
// &FORCE("output", "slv_sel_err");
//
// &FORCE("wire", "no_hit");
//
// &FORCE("wire", "or_layer0_0");
// &FORCE("wire", "or_layer0_1");
// &FORCE("wire", "or_layer0_2");
// &FORCE("wire", "or_layer0_3");
// &FORCE("wire", "or_layer0_4");
// &FORCE("wire", "or_layer0_5");
// &FORCE("wire", "or_layer0_6");
// &FORCE("wire", "or_layer0_7");
// &FORCE("wire", "or_layer1_0");
// &FORCE("wire", "or_layer1_1");
// &FORCE("wire", "or_layer1_2");
// &FORCE("wire", "or_layer1_3");
// &FORCE("wire", "or_layer2_0");
// &FORCE("wire", "or_layer2_1");
// &FORCE("wire", "or_layer3_0");
//
//: 
//: assign slv_sel_err = dec_en & no_hit; 
//: assign no_hit = ~or_layer3_0;
//
//:
// for ($i = 0; $i < 16; $i=$i+2) {
//: assign or_layer0_%d =					:: $i/2
//:`ifdef ATCBMC200_AHB_SLV%d					:: $i
//:	`ifdef ATCBMC200_AHB_SLV%d				:: $i+1
//:                           slv%d_pre_sel | slv%d_pre_sel;	:: $i, $i+1
//:	`else
//:                           slv%d_pre_sel;			:: $i
//:	`endif
//:`else
//:	`ifdef ATCBMC200_AHB_SLV%d				:: $i+1
//:                           slv%d_pre_sel;			:: $i+1
//:	`else
//:                           1'b0;
//:	`endif
//:`endif
// }
//:
// &IFDEF("ATCBMC200_PRIORITY_DECODE");
// &FORCE("wire", "slv_pre_sel[15:0]");
// &ENDIF("ATCBMC200_PRIORITY_DECODE");
//
//:`ifdef ATCBMC200_PRIORITY_DECODE
// for ($i = 0; $i < 16; $i=$i+1) {
//:	`ifdef ATCBMC200_AHB_SLV${i}
//:		assign	slv_pre_sel[${i}] = slv${i}_pre_sel;
//:	`else // ! ATCBMC200_AHB_SLV${i}
//:		assign	slv_pre_sel[${i}] = 1'b0;
//:	`endif // ATCBMC200_AHB_SLV${i}
// }
//:`endif // ATCBMC200_PRIORITY_DECODE
//:
// for ($i = 0; $i < 16; $i=$i+1) {
//:`ifdef ATCBMC200_AHB_SLV${i}
//:	`ifdef ATCBMC200_PRIORITY_DECODE
//		if ($i == 0) {
//:		assign slv${i}_sel = slv${i}_pre_sel;
//		} elsif ($i == 1) {
//:		assign slv${i}_sel = slv${i}_pre_sel & (~slv_pre_sel[0]);
//		} else {
//:		assign slv${i}_sel = slv${i}_pre_sel & (~(|slv_pre_sel[%d:0]));	:: $i-1 
//		}
//:	`else
//:		assign slv${i}_sel = slv${i}_pre_sel;
//:	`endif
//:`endif // ATCBMC200_AHB_SLV${i}
// }
//:
//: assign or_layer1_0 = or_layer0_0 | or_layer0_1;
//: assign or_layer1_1 = or_layer0_2 | or_layer0_3;
//: assign or_layer1_2 = or_layer0_4 | or_layer0_5;
//: assign or_layer1_3 = or_layer0_6 | or_layer0_7;
//: assign or_layer2_0 = or_layer1_0 | or_layer1_1;
//: assign or_layer2_1 = or_layer1_2 | or_layer1_3;
//: assign or_layer3_0 = or_layer2_0 | or_layer2_1;
//:
// for($i = 0; $i < 16; ++$i) {
//:`ifdef ATCBMC200_AHB_SLV${i}
//   if ($i>0 && $i<11) {
//: assign slv${i}_dec_en   = dec_en
//:	`ifdef ATCBMC200_EXT_ENABLE
//:				& ahb_slv${i}_en
//:	`endif
//:				;
//   }
//   else {
//: assign slv${i}_dec_en   = dec_en;
//   }
//:`endif
// }
//
//#: `ifdef ATCBMC200_EXT_ENABLE
//# for ($i = 0; $i < 16; $i=$i+1) {
//#   if ($i>0 && $i<11) {
//#:   `ifdef ATCBMC200_AHB_SLV${i} assign slv${i}_dec_en = dec_en & ahb_slv${i}_en;  `endif
//#   }
//#   else {
//#:   `ifdef ATCBMC200_AHB_SLV${i} assign slv${i}_dec_en = dec_en;  `endif
//#   }
//# }
//#: `else
//# for ($i = 0; $i < 16; $i=$i+1) {
//#:   `ifdef ATCBMC200_AHB_SLV${i} assign slv${i}_dec_en = dec_en;  `endif
//# }
//#: `endif // ATCBMC200_EXT_ENABLE
// &ENDMODULE;
// VPERL_END

// VPERL_GENERATED_BEGIN
module atcbmc200_mst_decoder (
`ifdef ATCBMC200_EXT_ENABLE
	  ahb_slv10_en, // () <= ()
	  ahb_slv1_en,  // () <= ()
	  ahb_slv2_en,  // () <= ()
	  ahb_slv3_en,  // () <= ()
	  ahb_slv4_en,  // () <= ()
	  ahb_slv5_en,  // () <= ()
	  ahb_slv6_en,  // () <= ()
	  ahb_slv7_en,  // () <= ()
	  ahb_slv8_en,  // () <= ()
	  ahb_slv9_en,  // () <= ()
`endif // ATCBMC200_EXT_ENABLE
`ifdef ATCBMC200_AHB_SLV0
	  slv0_sel,     // () => ()
	  slv0_base,    // (u_ahb_addrdec0) <= ()
	  slv0_size,    // (u_ahb_addrdec0) <= ()
`endif // ATCBMC200_AHB_SLV0
`ifdef ATCBMC200_AHB_SLV1
	  slv1_sel,     // () => ()
	  slv1_base,    // (u_ahb_addrdec1) <= ()
	  slv1_size,    // (u_ahb_addrdec1) <= ()
`endif // ATCBMC200_AHB_SLV1
`ifdef ATCBMC200_AHB_SLV2
	  slv2_sel,     // () => ()
	  slv2_base,    // (u_ahb_addrdec2) <= ()
	  slv2_size,    // (u_ahb_addrdec2) <= ()
`endif // ATCBMC200_AHB_SLV2
`ifdef ATCBMC200_AHB_SLV3
	  slv3_sel,     // () => ()
	  slv3_base,    // (u_ahb_addrdec3) <= ()
	  slv3_size,    // (u_ahb_addrdec3) <= ()
`endif // ATCBMC200_AHB_SLV3
`ifdef ATCBMC200_AHB_SLV4
	  slv4_sel,     // () => ()
	  slv4_base,    // (u_ahb_addrdec4) <= ()
	  slv4_size,    // (u_ahb_addrdec4) <= ()
`endif // ATCBMC200_AHB_SLV4
`ifdef ATCBMC200_AHB_SLV5
	  slv5_sel,     // () => ()
	  slv5_base,    // (u_ahb_addrdec5) <= ()
	  slv5_size,    // (u_ahb_addrdec5) <= ()
`endif // ATCBMC200_AHB_SLV5
`ifdef ATCBMC200_AHB_SLV6
	  slv6_sel,     // () => ()
	  slv6_base,    // (u_ahb_addrdec6) <= ()
	  slv6_size,    // (u_ahb_addrdec6) <= ()
`endif // ATCBMC200_AHB_SLV6
`ifdef ATCBMC200_AHB_SLV7
	  slv7_sel,     // () => ()
	  slv7_base,    // (u_ahb_addrdec7) <= ()
	  slv7_size,    // (u_ahb_addrdec7) <= ()
`endif // ATCBMC200_AHB_SLV7
`ifdef ATCBMC200_AHB_SLV8
	  slv8_sel,     // () => ()
	  slv8_base,    // (u_ahb_addrdec8) <= ()
	  slv8_size,    // (u_ahb_addrdec8) <= ()
`endif // ATCBMC200_AHB_SLV8
`ifdef ATCBMC200_AHB_SLV9
	  slv9_sel,     // () => ()
	  slv9_base,    // (u_ahb_addrdec9) <= ()
	  slv9_size,    // (u_ahb_addrdec9) <= ()
`endif // ATCBMC200_AHB_SLV9
`ifdef ATCBMC200_AHB_SLV10
	  slv10_sel,    // () => ()
	  slv10_base,   // (u_ahb_addrdec10) <= ()
	  slv10_size,   // (u_ahb_addrdec10) <= ()
`endif // ATCBMC200_AHB_SLV10
`ifdef ATCBMC200_AHB_SLV11
	  slv11_sel,    // () => ()
	  slv11_base,   // (u_ahb_addrdec11) <= ()
	  slv11_size,   // (u_ahb_addrdec11) <= ()
`endif // ATCBMC200_AHB_SLV11
`ifdef ATCBMC200_AHB_SLV12
	  slv12_sel,    // () => ()
	  slv12_base,   // (u_ahb_addrdec12) <= ()
	  slv12_size,   // (u_ahb_addrdec12) <= ()
`endif // ATCBMC200_AHB_SLV12
`ifdef ATCBMC200_AHB_SLV13
	  slv13_sel,    // () => ()
	  slv13_base,   // (u_ahb_addrdec13) <= ()
	  slv13_size,   // (u_ahb_addrdec13) <= ()
`endif // ATCBMC200_AHB_SLV13
`ifdef ATCBMC200_AHB_SLV14
	  slv14_sel,    // () => ()
	  slv14_base,   // (u_ahb_addrdec14) <= ()
	  slv14_size,   // (u_ahb_addrdec14) <= ()
`endif // ATCBMC200_AHB_SLV14
`ifdef ATCBMC200_AHB_SLV15
	  slv15_sel,    // () => ()
	  slv15_base,   // (u_ahb_addrdec15) <= ()
	  slv15_size,   // (u_ahb_addrdec15) <= ()
`endif // ATCBMC200_AHB_SLV15
	  dec_en,       // () <= ()
	  slv_sel_err,  // () => ()
	  addr          // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
);

parameter ADDR_WIDTH = `ATCBMC200_ADDR_MSB + 1;
parameter BASE_ADDR_LSB = (ADDR_WIDTH == 24) ? 10 : 20;

localparam ADDR_MSB = ADDR_WIDTH - 1;

`ifdef ATCBMC200_EXT_ENABLE
input                                ahb_slv10_en;
input                                ahb_slv1_en;
input                                ahb_slv2_en;
input                                ahb_slv3_en;
input                                ahb_slv4_en;
input                                ahb_slv5_en;
input                                ahb_slv6_en;
input                                ahb_slv7_en;
input                                ahb_slv8_en;
input                                ahb_slv9_en;
`endif // ATCBMC200_EXT_ENABLE
`ifdef ATCBMC200_AHB_SLV0
output                               slv0_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv0_base;
input                          [3:0] slv0_size;
`endif // ATCBMC200_AHB_SLV0
`ifdef ATCBMC200_AHB_SLV1
output                               slv1_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv1_base;
input                          [3:0] slv1_size;
`endif // ATCBMC200_AHB_SLV1
`ifdef ATCBMC200_AHB_SLV2
output                               slv2_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv2_base;
input                          [3:0] slv2_size;
`endif // ATCBMC200_AHB_SLV2
`ifdef ATCBMC200_AHB_SLV3
output                               slv3_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv3_base;
input                          [3:0] slv3_size;
`endif // ATCBMC200_AHB_SLV3
`ifdef ATCBMC200_AHB_SLV4
output                               slv4_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv4_base;
input                          [3:0] slv4_size;
`endif // ATCBMC200_AHB_SLV4
`ifdef ATCBMC200_AHB_SLV5
output                               slv5_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv5_base;
input                          [3:0] slv5_size;
`endif // ATCBMC200_AHB_SLV5
`ifdef ATCBMC200_AHB_SLV6
output                               slv6_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv6_base;
input                          [3:0] slv6_size;
`endif // ATCBMC200_AHB_SLV6
`ifdef ATCBMC200_AHB_SLV7
output                               slv7_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv7_base;
input                          [3:0] slv7_size;
`endif // ATCBMC200_AHB_SLV7
`ifdef ATCBMC200_AHB_SLV8
output                               slv8_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv8_base;
input                          [3:0] slv8_size;
`endif // ATCBMC200_AHB_SLV8
`ifdef ATCBMC200_AHB_SLV9
output                               slv9_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv9_base;
input                          [3:0] slv9_size;
`endif // ATCBMC200_AHB_SLV9
`ifdef ATCBMC200_AHB_SLV10
output                               slv10_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv10_base;
input                          [3:0] slv10_size;
`endif // ATCBMC200_AHB_SLV10
`ifdef ATCBMC200_AHB_SLV11
output                               slv11_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv11_base;
input                          [3:0] slv11_size;
`endif // ATCBMC200_AHB_SLV11
`ifdef ATCBMC200_AHB_SLV12
output                               slv12_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv12_base;
input                          [3:0] slv12_size;
`endif // ATCBMC200_AHB_SLV12
`ifdef ATCBMC200_AHB_SLV13
output                               slv13_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv13_base;
input                          [3:0] slv13_size;
`endif // ATCBMC200_AHB_SLV13
`ifdef ATCBMC200_AHB_SLV14
output                               slv14_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv14_base;
input                          [3:0] slv14_size;
`endif // ATCBMC200_AHB_SLV14
`ifdef ATCBMC200_AHB_SLV15
output                               slv15_sel;
input       [ADDR_MSB:BASE_ADDR_LSB] slv15_base;
input                          [3:0] slv15_size;
`endif // ATCBMC200_AHB_SLV15
input                                dec_en;
output                               slv_sel_err;
input                   [ADDR_MSB:0] addr;

`ifdef ATCBMC200_AHB_SLV0
wire                                 slv0_dec_en;
wire                                 slv0_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV0
`ifdef ATCBMC200_PRIORITY_DECODE
wire                          [15:0] slv_pre_sel;
`endif // ATCBMC200_PRIORITY_DECODE
`ifdef ATCBMC200_AHB_SLV1
wire                                 slv1_dec_en;
wire                                 slv1_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV1
`ifdef ATCBMC200_AHB_SLV2
wire                                 slv2_dec_en;
wire                                 slv2_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV2
`ifdef ATCBMC200_AHB_SLV3
wire                                 slv3_dec_en;
wire                                 slv3_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV3
`ifdef ATCBMC200_AHB_SLV4
wire                                 slv4_dec_en;
wire                                 slv4_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV4
`ifdef ATCBMC200_AHB_SLV5
wire                                 slv5_dec_en;
wire                                 slv5_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV5
`ifdef ATCBMC200_AHB_SLV6
wire                                 slv6_dec_en;
wire                                 slv6_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV6
`ifdef ATCBMC200_AHB_SLV7
wire                                 slv7_dec_en;
wire                                 slv7_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV7
`ifdef ATCBMC200_AHB_SLV8
wire                                 slv8_dec_en;
wire                                 slv8_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV8
`ifdef ATCBMC200_AHB_SLV9
wire                                 slv9_dec_en;
wire                                 slv9_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV9
`ifdef ATCBMC200_AHB_SLV10
wire                                 slv10_dec_en;
wire                                 slv10_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV10
`ifdef ATCBMC200_AHB_SLV11
wire                                 slv11_dec_en;
wire                                 slv11_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV11
`ifdef ATCBMC200_AHB_SLV12
wire                                 slv12_dec_en;
wire                                 slv12_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV12
`ifdef ATCBMC200_AHB_SLV13
wire                                 slv13_dec_en;
wire                                 slv13_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV13
`ifdef ATCBMC200_AHB_SLV14
wire                                 slv14_dec_en;
wire                                 slv14_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV14
`ifdef ATCBMC200_AHB_SLV15
wire                                 slv15_dec_en;
wire                                 slv15_pre_sel; // dangler: () => ()
`endif // ATCBMC200_AHB_SLV15
wire                                 no_hit;
wire                                 or_layer0_0;
wire                                 or_layer0_1;
wire                                 or_layer0_2;
wire                                 or_layer0_3;
wire                                 or_layer0_4;
wire                                 or_layer0_5;
wire                                 or_layer0_6;
wire                                 or_layer0_7;
wire                                 or_layer1_0;
wire                                 or_layer1_1;
wire                                 or_layer1_2;
wire                                 or_layer1_3;
wire                                 or_layer2_0;
wire                                 or_layer2_1;
wire                                 or_layer3_0;


assign slv_sel_err = dec_en & no_hit;
assign no_hit = ~or_layer3_0;

assign or_layer0_0 =
`ifdef ATCBMC200_AHB_SLV0
	`ifdef ATCBMC200_AHB_SLV1
                          slv0_pre_sel | slv1_pre_sel;
	`else
                          slv0_pre_sel;
	`endif
`else
	`ifdef ATCBMC200_AHB_SLV1
                          slv1_pre_sel;
	`else
                          1'b0;
	`endif
`endif
assign or_layer0_1 =
`ifdef ATCBMC200_AHB_SLV2
	`ifdef ATCBMC200_AHB_SLV3
                          slv2_pre_sel | slv3_pre_sel;
	`else
                          slv2_pre_sel;
	`endif
`else
	`ifdef ATCBMC200_AHB_SLV3
                          slv3_pre_sel;
	`else
                          1'b0;
	`endif
`endif
assign or_layer0_2 =
`ifdef ATCBMC200_AHB_SLV4
	`ifdef ATCBMC200_AHB_SLV5
                          slv4_pre_sel | slv5_pre_sel;
	`else
                          slv4_pre_sel;
	`endif
`else
	`ifdef ATCBMC200_AHB_SLV5
                          slv5_pre_sel;
	`else
                          1'b0;
	`endif
`endif
assign or_layer0_3 =
`ifdef ATCBMC200_AHB_SLV6
	`ifdef ATCBMC200_AHB_SLV7
                          slv6_pre_sel | slv7_pre_sel;
	`else
                          slv6_pre_sel;
	`endif
`else
	`ifdef ATCBMC200_AHB_SLV7
                          slv7_pre_sel;
	`else
                          1'b0;
	`endif
`endif
assign or_layer0_4 =
`ifdef ATCBMC200_AHB_SLV8
	`ifdef ATCBMC200_AHB_SLV9
                          slv8_pre_sel | slv9_pre_sel;
	`else
                          slv8_pre_sel;
	`endif
`else
	`ifdef ATCBMC200_AHB_SLV9
                          slv9_pre_sel;
	`else
                          1'b0;
	`endif
`endif
assign or_layer0_5 =
`ifdef ATCBMC200_AHB_SLV10
	`ifdef ATCBMC200_AHB_SLV11
                          slv10_pre_sel | slv11_pre_sel;
	`else
                          slv10_pre_sel;
	`endif
`else
	`ifdef ATCBMC200_AHB_SLV11
                          slv11_pre_sel;
	`else
                          1'b0;
	`endif
`endif
assign or_layer0_6 =
`ifdef ATCBMC200_AHB_SLV12
	`ifdef ATCBMC200_AHB_SLV13
                          slv12_pre_sel | slv13_pre_sel;
	`else
                          slv12_pre_sel;
	`endif
`else
	`ifdef ATCBMC200_AHB_SLV13
                          slv13_pre_sel;
	`else
                          1'b0;
	`endif
`endif
assign or_layer0_7 =
`ifdef ATCBMC200_AHB_SLV14
	`ifdef ATCBMC200_AHB_SLV15
                          slv14_pre_sel | slv15_pre_sel;
	`else
                          slv14_pre_sel;
	`endif
`else
	`ifdef ATCBMC200_AHB_SLV15
                          slv15_pre_sel;
	`else
                          1'b0;
	`endif
`endif

`ifdef ATCBMC200_PRIORITY_DECODE
	`ifdef ATCBMC200_AHB_SLV0
		assign	slv_pre_sel[0] = slv0_pre_sel;
	`else // ! ATCBMC200_AHB_SLV0
		assign	slv_pre_sel[0] = 1'b0;
	`endif // ATCBMC200_AHB_SLV0
	`ifdef ATCBMC200_AHB_SLV1
		assign	slv_pre_sel[1] = slv1_pre_sel;
	`else // ! ATCBMC200_AHB_SLV1
		assign	slv_pre_sel[1] = 1'b0;
	`endif // ATCBMC200_AHB_SLV1
	`ifdef ATCBMC200_AHB_SLV2
		assign	slv_pre_sel[2] = slv2_pre_sel;
	`else // ! ATCBMC200_AHB_SLV2
		assign	slv_pre_sel[2] = 1'b0;
	`endif // ATCBMC200_AHB_SLV2
	`ifdef ATCBMC200_AHB_SLV3
		assign	slv_pre_sel[3] = slv3_pre_sel;
	`else // ! ATCBMC200_AHB_SLV3
		assign	slv_pre_sel[3] = 1'b0;
	`endif // ATCBMC200_AHB_SLV3
	`ifdef ATCBMC200_AHB_SLV4
		assign	slv_pre_sel[4] = slv4_pre_sel;
	`else // ! ATCBMC200_AHB_SLV4
		assign	slv_pre_sel[4] = 1'b0;
	`endif // ATCBMC200_AHB_SLV4
	`ifdef ATCBMC200_AHB_SLV5
		assign	slv_pre_sel[5] = slv5_pre_sel;
	`else // ! ATCBMC200_AHB_SLV5
		assign	slv_pre_sel[5] = 1'b0;
	`endif // ATCBMC200_AHB_SLV5
	`ifdef ATCBMC200_AHB_SLV6
		assign	slv_pre_sel[6] = slv6_pre_sel;
	`else // ! ATCBMC200_AHB_SLV6
		assign	slv_pre_sel[6] = 1'b0;
	`endif // ATCBMC200_AHB_SLV6
	`ifdef ATCBMC200_AHB_SLV7
		assign	slv_pre_sel[7] = slv7_pre_sel;
	`else // ! ATCBMC200_AHB_SLV7
		assign	slv_pre_sel[7] = 1'b0;
	`endif // ATCBMC200_AHB_SLV7
	`ifdef ATCBMC200_AHB_SLV8
		assign	slv_pre_sel[8] = slv8_pre_sel;
	`else // ! ATCBMC200_AHB_SLV8
		assign	slv_pre_sel[8] = 1'b0;
	`endif // ATCBMC200_AHB_SLV8
	`ifdef ATCBMC200_AHB_SLV9
		assign	slv_pre_sel[9] = slv9_pre_sel;
	`else // ! ATCBMC200_AHB_SLV9
		assign	slv_pre_sel[9] = 1'b0;
	`endif // ATCBMC200_AHB_SLV9
	`ifdef ATCBMC200_AHB_SLV10
		assign	slv_pre_sel[10] = slv10_pre_sel;
	`else // ! ATCBMC200_AHB_SLV10
		assign	slv_pre_sel[10] = 1'b0;
	`endif // ATCBMC200_AHB_SLV10
	`ifdef ATCBMC200_AHB_SLV11
		assign	slv_pre_sel[11] = slv11_pre_sel;
	`else // ! ATCBMC200_AHB_SLV11
		assign	slv_pre_sel[11] = 1'b0;
	`endif // ATCBMC200_AHB_SLV11
	`ifdef ATCBMC200_AHB_SLV12
		assign	slv_pre_sel[12] = slv12_pre_sel;
	`else // ! ATCBMC200_AHB_SLV12
		assign	slv_pre_sel[12] = 1'b0;
	`endif // ATCBMC200_AHB_SLV12
	`ifdef ATCBMC200_AHB_SLV13
		assign	slv_pre_sel[13] = slv13_pre_sel;
	`else // ! ATCBMC200_AHB_SLV13
		assign	slv_pre_sel[13] = 1'b0;
	`endif // ATCBMC200_AHB_SLV13
	`ifdef ATCBMC200_AHB_SLV14
		assign	slv_pre_sel[14] = slv14_pre_sel;
	`else // ! ATCBMC200_AHB_SLV14
		assign	slv_pre_sel[14] = 1'b0;
	`endif // ATCBMC200_AHB_SLV14
	`ifdef ATCBMC200_AHB_SLV15
		assign	slv_pre_sel[15] = slv15_pre_sel;
	`else // ! ATCBMC200_AHB_SLV15
		assign	slv_pre_sel[15] = 1'b0;
	`endif // ATCBMC200_AHB_SLV15
`endif // ATCBMC200_PRIORITY_DECODE

`ifdef ATCBMC200_AHB_SLV0
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv0_sel = slv0_pre_sel;
	`else
		assign slv0_sel = slv0_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV0
`ifdef ATCBMC200_AHB_SLV1
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv1_sel = slv1_pre_sel & (~slv_pre_sel[0]);
	`else
		assign slv1_sel = slv1_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV1
`ifdef ATCBMC200_AHB_SLV2
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv2_sel = slv2_pre_sel & (~(|slv_pre_sel[1:0]));
	`else
		assign slv2_sel = slv2_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV2
`ifdef ATCBMC200_AHB_SLV3
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv3_sel = slv3_pre_sel & (~(|slv_pre_sel[2:0]));
	`else
		assign slv3_sel = slv3_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV3
`ifdef ATCBMC200_AHB_SLV4
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv4_sel = slv4_pre_sel & (~(|slv_pre_sel[3:0]));
	`else
		assign slv4_sel = slv4_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV4
`ifdef ATCBMC200_AHB_SLV5
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv5_sel = slv5_pre_sel & (~(|slv_pre_sel[4:0]));
	`else
		assign slv5_sel = slv5_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV5
`ifdef ATCBMC200_AHB_SLV6
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv6_sel = slv6_pre_sel & (~(|slv_pre_sel[5:0]));
	`else
		assign slv6_sel = slv6_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV6
`ifdef ATCBMC200_AHB_SLV7
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv7_sel = slv7_pre_sel & (~(|slv_pre_sel[6:0]));
	`else
		assign slv7_sel = slv7_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV7
`ifdef ATCBMC200_AHB_SLV8
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv8_sel = slv8_pre_sel & (~(|slv_pre_sel[7:0]));
	`else
		assign slv8_sel = slv8_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV8
`ifdef ATCBMC200_AHB_SLV9
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv9_sel = slv9_pre_sel & (~(|slv_pre_sel[8:0]));
	`else
		assign slv9_sel = slv9_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV9
`ifdef ATCBMC200_AHB_SLV10
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv10_sel = slv10_pre_sel & (~(|slv_pre_sel[9:0]));
	`else
		assign slv10_sel = slv10_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV10
`ifdef ATCBMC200_AHB_SLV11
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv11_sel = slv11_pre_sel & (~(|slv_pre_sel[10:0]));
	`else
		assign slv11_sel = slv11_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV11
`ifdef ATCBMC200_AHB_SLV12
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv12_sel = slv12_pre_sel & (~(|slv_pre_sel[11:0]));
	`else
		assign slv12_sel = slv12_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV12
`ifdef ATCBMC200_AHB_SLV13
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv13_sel = slv13_pre_sel & (~(|slv_pre_sel[12:0]));
	`else
		assign slv13_sel = slv13_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV13
`ifdef ATCBMC200_AHB_SLV14
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv14_sel = slv14_pre_sel & (~(|slv_pre_sel[13:0]));
	`else
		assign slv14_sel = slv14_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV14
`ifdef ATCBMC200_AHB_SLV15
	`ifdef ATCBMC200_PRIORITY_DECODE
		assign slv15_sel = slv15_pre_sel & (~(|slv_pre_sel[14:0]));
	`else
		assign slv15_sel = slv15_pre_sel;
	`endif
`endif // ATCBMC200_AHB_SLV15

assign or_layer1_0 = or_layer0_0 | or_layer0_1;
assign or_layer1_1 = or_layer0_2 | or_layer0_3;
assign or_layer1_2 = or_layer0_4 | or_layer0_5;
assign or_layer1_3 = or_layer0_6 | or_layer0_7;
assign or_layer2_0 = or_layer1_0 | or_layer1_1;
assign or_layer2_1 = or_layer1_2 | or_layer1_3;
assign or_layer3_0 = or_layer2_0 | or_layer2_1;

`ifdef ATCBMC200_AHB_SLV0
assign slv0_dec_en   = dec_en;
`endif
`ifdef ATCBMC200_AHB_SLV1
assign slv1_dec_en   = dec_en
	`ifdef ATCBMC200_EXT_ENABLE
				& ahb_slv1_en
	`endif
				;
`endif
`ifdef ATCBMC200_AHB_SLV2
assign slv2_dec_en   = dec_en
	`ifdef ATCBMC200_EXT_ENABLE
				& ahb_slv2_en
	`endif
				;
`endif
`ifdef ATCBMC200_AHB_SLV3
assign slv3_dec_en   = dec_en
	`ifdef ATCBMC200_EXT_ENABLE
				& ahb_slv3_en
	`endif
				;
`endif
`ifdef ATCBMC200_AHB_SLV4
assign slv4_dec_en   = dec_en
	`ifdef ATCBMC200_EXT_ENABLE
				& ahb_slv4_en
	`endif
				;
`endif
`ifdef ATCBMC200_AHB_SLV5
assign slv5_dec_en   = dec_en
	`ifdef ATCBMC200_EXT_ENABLE
				& ahb_slv5_en
	`endif
				;
`endif
`ifdef ATCBMC200_AHB_SLV6
assign slv6_dec_en   = dec_en
	`ifdef ATCBMC200_EXT_ENABLE
				& ahb_slv6_en
	`endif
				;
`endif
`ifdef ATCBMC200_AHB_SLV7
assign slv7_dec_en   = dec_en
	`ifdef ATCBMC200_EXT_ENABLE
				& ahb_slv7_en
	`endif
				;
`endif
`ifdef ATCBMC200_AHB_SLV8
assign slv8_dec_en   = dec_en
	`ifdef ATCBMC200_EXT_ENABLE
				& ahb_slv8_en
	`endif
				;
`endif
`ifdef ATCBMC200_AHB_SLV9
assign slv9_dec_en   = dec_en
	`ifdef ATCBMC200_EXT_ENABLE
				& ahb_slv9_en
	`endif
				;
`endif
`ifdef ATCBMC200_AHB_SLV10
assign slv10_dec_en   = dec_en
	`ifdef ATCBMC200_EXT_ENABLE
				& ahb_slv10_en
	`endif
				;
`endif
`ifdef ATCBMC200_AHB_SLV11
assign slv11_dec_en   = dec_en;
`endif
`ifdef ATCBMC200_AHB_SLV12
assign slv12_dec_en   = dec_en;
`endif
`ifdef ATCBMC200_AHB_SLV13
assign slv13_dec_en   = dec_en;
`endif
`ifdef ATCBMC200_AHB_SLV14
assign slv14_dec_en   = dec_en;
`endif
`ifdef ATCBMC200_AHB_SLV15
assign slv15_dec_en   = dec_en;
`endif

`ifdef ATCBMC200_AHB_SLV0
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec0 (
	.base  (slv0_base   ), // (u_ahb_addrdec0) <= ()
	.addr  (addr        ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv0_size   ), // (u_ahb_addrdec0) <= ()
	.dec_en(slv0_dec_en ), // (u_ahb_addrdec0) <= ()
	.sel   (slv0_pre_sel)  // (u_ahb_addrdec0) => ()
); // end of u_ahb_addrdec0

`endif // ATCBMC200_AHB_SLV0
`ifdef ATCBMC200_AHB_SLV1
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec1 (
	.base  (slv1_base   ), // (u_ahb_addrdec1) <= ()
	.addr  (addr        ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv1_size   ), // (u_ahb_addrdec1) <= ()
	.dec_en(slv1_dec_en ), // (u_ahb_addrdec1) <= ()
	.sel   (slv1_pre_sel)  // (u_ahb_addrdec1) => ()
); // end of u_ahb_addrdec1

`endif // ATCBMC200_AHB_SLV1
`ifdef ATCBMC200_AHB_SLV2
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec2 (
	.base  (slv2_base   ), // (u_ahb_addrdec2) <= ()
	.addr  (addr        ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv2_size   ), // (u_ahb_addrdec2) <= ()
	.dec_en(slv2_dec_en ), // (u_ahb_addrdec2) <= ()
	.sel   (slv2_pre_sel)  // (u_ahb_addrdec2) => ()
); // end of u_ahb_addrdec2

`endif // ATCBMC200_AHB_SLV2
`ifdef ATCBMC200_AHB_SLV3
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec3 (
	.base  (slv3_base   ), // (u_ahb_addrdec3) <= ()
	.addr  (addr        ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv3_size   ), // (u_ahb_addrdec3) <= ()
	.dec_en(slv3_dec_en ), // (u_ahb_addrdec3) <= ()
	.sel   (slv3_pre_sel)  // (u_ahb_addrdec3) => ()
); // end of u_ahb_addrdec3

`endif // ATCBMC200_AHB_SLV3
`ifdef ATCBMC200_AHB_SLV4
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec4 (
	.base  (slv4_base   ), // (u_ahb_addrdec4) <= ()
	.addr  (addr        ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv4_size   ), // (u_ahb_addrdec4) <= ()
	.dec_en(slv4_dec_en ), // (u_ahb_addrdec4) <= ()
	.sel   (slv4_pre_sel)  // (u_ahb_addrdec4) => ()
); // end of u_ahb_addrdec4

`endif // ATCBMC200_AHB_SLV4
`ifdef ATCBMC200_AHB_SLV5
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec5 (
	.base  (slv5_base   ), // (u_ahb_addrdec5) <= ()
	.addr  (addr        ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv5_size   ), // (u_ahb_addrdec5) <= ()
	.dec_en(slv5_dec_en ), // (u_ahb_addrdec5) <= ()
	.sel   (slv5_pre_sel)  // (u_ahb_addrdec5) => ()
); // end of u_ahb_addrdec5

`endif // ATCBMC200_AHB_SLV5
`ifdef ATCBMC200_AHB_SLV6
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec6 (
	.base  (slv6_base   ), // (u_ahb_addrdec6) <= ()
	.addr  (addr        ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv6_size   ), // (u_ahb_addrdec6) <= ()
	.dec_en(slv6_dec_en ), // (u_ahb_addrdec6) <= ()
	.sel   (slv6_pre_sel)  // (u_ahb_addrdec6) => ()
); // end of u_ahb_addrdec6

`endif // ATCBMC200_AHB_SLV6
`ifdef ATCBMC200_AHB_SLV7
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec7 (
	.base  (slv7_base   ), // (u_ahb_addrdec7) <= ()
	.addr  (addr        ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv7_size   ), // (u_ahb_addrdec7) <= ()
	.dec_en(slv7_dec_en ), // (u_ahb_addrdec7) <= ()
	.sel   (slv7_pre_sel)  // (u_ahb_addrdec7) => ()
); // end of u_ahb_addrdec7

`endif // ATCBMC200_AHB_SLV7
`ifdef ATCBMC200_AHB_SLV8
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec8 (
	.base  (slv8_base   ), // (u_ahb_addrdec8) <= ()
	.addr  (addr        ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv8_size   ), // (u_ahb_addrdec8) <= ()
	.dec_en(slv8_dec_en ), // (u_ahb_addrdec8) <= ()
	.sel   (slv8_pre_sel)  // (u_ahb_addrdec8) => ()
); // end of u_ahb_addrdec8

`endif // ATCBMC200_AHB_SLV8
`ifdef ATCBMC200_AHB_SLV9
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec9 (
	.base  (slv9_base   ), // (u_ahb_addrdec9) <= ()
	.addr  (addr        ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv9_size   ), // (u_ahb_addrdec9) <= ()
	.dec_en(slv9_dec_en ), // (u_ahb_addrdec9) <= ()
	.sel   (slv9_pre_sel)  // (u_ahb_addrdec9) => ()
); // end of u_ahb_addrdec9

`endif // ATCBMC200_AHB_SLV9
`ifdef ATCBMC200_AHB_SLV10
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec10 (
	.base  (slv10_base   ), // (u_ahb_addrdec10) <= ()
	.addr  (addr         ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv10_size   ), // (u_ahb_addrdec10) <= ()
	.dec_en(slv10_dec_en ), // (u_ahb_addrdec10) <= ()
	.sel   (slv10_pre_sel)  // (u_ahb_addrdec10) => ()
); // end of u_ahb_addrdec10

`endif // ATCBMC200_AHB_SLV10
`ifdef ATCBMC200_AHB_SLV11
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec11 (
	.base  (slv11_base   ), // (u_ahb_addrdec11) <= ()
	.addr  (addr         ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv11_size   ), // (u_ahb_addrdec11) <= ()
	.dec_en(slv11_dec_en ), // (u_ahb_addrdec11) <= ()
	.sel   (slv11_pre_sel)  // (u_ahb_addrdec11) => ()
); // end of u_ahb_addrdec11

`endif // ATCBMC200_AHB_SLV11
`ifdef ATCBMC200_AHB_SLV12
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec12 (
	.base  (slv12_base   ), // (u_ahb_addrdec12) <= ()
	.addr  (addr         ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv12_size   ), // (u_ahb_addrdec12) <= ()
	.dec_en(slv12_dec_en ), // (u_ahb_addrdec12) <= ()
	.sel   (slv12_pre_sel)  // (u_ahb_addrdec12) => ()
); // end of u_ahb_addrdec12

`endif // ATCBMC200_AHB_SLV12
`ifdef ATCBMC200_AHB_SLV13
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec13 (
	.base  (slv13_base   ), // (u_ahb_addrdec13) <= ()
	.addr  (addr         ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv13_size   ), // (u_ahb_addrdec13) <= ()
	.dec_en(slv13_dec_en ), // (u_ahb_addrdec13) <= ()
	.sel   (slv13_pre_sel)  // (u_ahb_addrdec13) => ()
); // end of u_ahb_addrdec13

`endif // ATCBMC200_AHB_SLV13
`ifdef ATCBMC200_AHB_SLV14
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec14 (
	.base  (slv14_base   ), // (u_ahb_addrdec14) <= ()
	.addr  (addr         ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv14_size   ), // (u_ahb_addrdec14) <= ()
	.dec_en(slv14_dec_en ), // (u_ahb_addrdec14) <= ()
	.sel   (slv14_pre_sel)  // (u_ahb_addrdec14) => ()
); // end of u_ahb_addrdec14

`endif // ATCBMC200_AHB_SLV14
`ifdef ATCBMC200_AHB_SLV15
atcbmc200_addrdec #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_ahb_addrdec15 (
	.base  (slv15_base   ), // (u_ahb_addrdec15) <= ()
	.addr  (addr         ), // (u_ahb_addrdec0,u_ahb_addrdec1,u_ahb_addrdec10,u_ahb_addrdec11,u_ahb_addrdec12,u_ahb_addrdec13,u_ahb_addrdec14,u_ahb_addrdec15,u_ahb_addrdec2,u_ahb_addrdec3,u_ahb_addrdec4,u_ahb_addrdec5,u_ahb_addrdec6,u_ahb_addrdec7,u_ahb_addrdec8,u_ahb_addrdec9) <= ()
	.size  (slv15_size   ), // (u_ahb_addrdec15) <= ()
	.dec_en(slv15_dec_en ), // (u_ahb_addrdec15) <= ()
	.sel   (slv15_pre_sel)  // (u_ahb_addrdec15) => ()
); // end of u_ahb_addrdec15

`endif // ATCBMC200_AHB_SLV15
endmodule
// VPERL_GENERATED_END
