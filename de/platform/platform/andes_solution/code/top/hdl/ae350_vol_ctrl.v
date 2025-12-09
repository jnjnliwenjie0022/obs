module ae350_vol_ctrl (
//===============
// SMU interface
//===============
// VPERL_BEGING
// $pcs_count = 7;
// for (my $i = 0; $i < $pcs_count; $i++) {
//# pclk domain signal
//:input		pcs${i}_iso			/* synthesis syn_keep=1 */,
//:input		pcs${i}_reten			/* synthesis syn_keep=1 */,
//:input		pcs${i}_vol_scale_req		/* synthesis syn_keep=1 */,
//:input	[2:0]	pcs${i}_vol_scale		/* synthesis syn_keep=1 */,
//:output		pcs${i}_vol_scale_ack		/* synthesis syn_keep=1 */,
//# clk_32k domain
//:output		pd${i}_vol_on			/* synthesis syn_keep=1 */,
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
input		pcs0_iso			/* synthesis syn_keep=1 */,
input		pcs0_reten			/* synthesis syn_keep=1 */,
input		pcs0_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs0_vol_scale		/* synthesis syn_keep=1 */,
output		pcs0_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd0_vol_on			/* synthesis syn_keep=1 */,
input		pcs1_iso			/* synthesis syn_keep=1 */,
input		pcs1_reten			/* synthesis syn_keep=1 */,
input		pcs1_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs1_vol_scale		/* synthesis syn_keep=1 */,
output		pcs1_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd1_vol_on			/* synthesis syn_keep=1 */,
input		pcs2_iso			/* synthesis syn_keep=1 */,
input		pcs2_reten			/* synthesis syn_keep=1 */,
input		pcs2_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs2_vol_scale		/* synthesis syn_keep=1 */,
output		pcs2_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd2_vol_on			/* synthesis syn_keep=1 */,
input		pcs3_iso			/* synthesis syn_keep=1 */,
input		pcs3_reten			/* synthesis syn_keep=1 */,
input		pcs3_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs3_vol_scale		/* synthesis syn_keep=1 */,
output		pcs3_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd3_vol_on			/* synthesis syn_keep=1 */,
input		pcs4_iso			/* synthesis syn_keep=1 */,
input		pcs4_reten			/* synthesis syn_keep=1 */,
input		pcs4_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs4_vol_scale		/* synthesis syn_keep=1 */,
output		pcs4_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd4_vol_on			/* synthesis syn_keep=1 */,
input		pcs5_iso			/* synthesis syn_keep=1 */,
input		pcs5_reten			/* synthesis syn_keep=1 */,
input		pcs5_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs5_vol_scale		/* synthesis syn_keep=1 */,
output		pcs5_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd5_vol_on			/* synthesis syn_keep=1 */,
input		pcs6_iso			/* synthesis syn_keep=1 */,
input		pcs6_reten			/* synthesis syn_keep=1 */,
input		pcs6_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs6_vol_scale		/* synthesis syn_keep=1 */,
output		pcs6_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd6_vol_on			/* synthesis syn_keep=1 */,
// VPERL_GENERATED_END
input		aopd_clk_32k,
input		aopd_rtc_rstn
);

// VPERL_BEGING
// $pcs_count = 7;
// for (my $i = 1; $i < $pcs_count; $i++) {
//:wire voltage${i}_unstable = 1'b0;
//:pd_vol_ctrl pd${i}_vol_ctrl(.vol_on(pd${i}_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage${i}_unstable),
//:		 	.vol_scale_ack(pcs${i}_vol_scale_ack), .vol_scale_req(pcs${i}_vol_scale_req), .vol_scale(pcs${i}_vol_scale));
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
wire voltage1_unstable = 1'b0;
pd_vol_ctrl pd1_vol_ctrl(.vol_on(pd1_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage1_unstable),
		 	.vol_scale_ack(pcs1_vol_scale_ack), .vol_scale_req(pcs1_vol_scale_req), .vol_scale(pcs1_vol_scale));
wire voltage2_unstable = 1'b0;
pd_vol_ctrl pd2_vol_ctrl(.vol_on(pd2_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage2_unstable),
		 	.vol_scale_ack(pcs2_vol_scale_ack), .vol_scale_req(pcs2_vol_scale_req), .vol_scale(pcs2_vol_scale));
wire voltage3_unstable = 1'b0;
pd_vol_ctrl pd3_vol_ctrl(.vol_on(pd3_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage3_unstable),
		 	.vol_scale_ack(pcs3_vol_scale_ack), .vol_scale_req(pcs3_vol_scale_req), .vol_scale(pcs3_vol_scale));
wire voltage4_unstable = 1'b0;
pd_vol_ctrl pd4_vol_ctrl(.vol_on(pd4_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage4_unstable),
		 	.vol_scale_ack(pcs4_vol_scale_ack), .vol_scale_req(pcs4_vol_scale_req), .vol_scale(pcs4_vol_scale));
wire voltage5_unstable = 1'b0;
pd_vol_ctrl pd5_vol_ctrl(.vol_on(pd5_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage5_unstable),
		 	.vol_scale_ack(pcs5_vol_scale_ack), .vol_scale_req(pcs5_vol_scale_req), .vol_scale(pcs5_vol_scale));
wire voltage6_unstable = 1'b0;
pd_vol_ctrl pd6_vol_ctrl(.vol_on(pd6_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage6_unstable),
		 	.vol_scale_ack(pcs6_vol_scale_ack), .vol_scale_req(pcs6_vol_scale_req), .vol_scale(pcs6_vol_scale));
// VPERL_GENERATED_END
assign		pcs0_vol_scale_ack = 1'b0		/* synthesis syn_keep=1 */;
assign		pd0_vol_on = 1'b1			/* synthesis syn_keep=1 */;

endmodule

