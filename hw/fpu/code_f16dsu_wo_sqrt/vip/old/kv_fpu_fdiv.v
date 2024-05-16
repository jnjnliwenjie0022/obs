// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

assign f1_frs_hp = f1_sew[0];
assign f1_frs_sp = f1_sew[1] & fp_single_precision_support;
assign f1_frs_dp = f1_sew[2] & fp_double_precision_support;
wire f1_nanbox_check_en = f1_scalar_fpu_instr;
wire f1_op1_h_nanboxing = f1_nanbox_check_en ? ((f1_frs_hp & (FLEN == 64)) ? &f1_op1_data[63:16] : (f1_frs_hp & (FLEN == 32)) ? &f1_op1_data[31:16] : 1'b0) : 1'b1;
wire f1_op2_h_nanboxing = f1_nanbox_check_en ? ((f1_frs_hp & (FLEN == 64)) ? &f1_op2_data[63:16] : (f1_frs_hp & (FLEN == 32)) ? &f1_op2_data[31:16] : 1'b0) : 1'b1;
wire f1_op1_s_nanboxing = f1_nanbox_check_en ? ((f1_frs_sp & (FLEN == 64)) ? &f1_op1_data[63:32] : (f1_frs_sp & (FLEN == 32)) ? 1'b1 : 1'b0) : 1'b1;
wire f1_op2_s_nanboxing = f1_nanbox_check_en ? ((f1_frs_sp & (FLEN == 64)) ? &f1_op2_data[63:32] : (f1_frs_sp & (FLEN == 32)) ? 1'b1 : 1'b0) : 1'b1;
wire f1_op1_is_nanboxed = f1_frs_hp ? f1_op1_h_nanboxing : f1_frs_sp ? f1_op1_s_nanboxing : 1'b1;
wire f1_op2_is_nanboxed = f1_frs_hp ? f1_op2_h_nanboxing : f1_frs_sp ? f1_op2_s_nanboxing : 1'b1;
wire f1_op1_h_is_inf = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9:0] == 10'b0) & (f1_op1_h_nanboxing);
wire f1_op1_h_is_subnor = (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] != 10'b0) & (f1_op1_h_nanboxing);
wire f1_op1_h_is_qnan = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9]) | ~(f1_op1_h_nanboxing);
wire f1_op1_h_is_snan = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[8:0] != 9'b0) & (f1_op1_h_nanboxing) & ~f1_op1_data[9];
wire f1_op2_h_is_inf = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[9:0] == 10'b0) & (f1_op2_h_nanboxing);
wire f1_op2_h_is_subnor = (f1_op2_data[14:10] == 5'b0) & (f1_op2_data[9:0] != 10'b0) & (f1_op2_h_nanboxing);
wire f1_op2_h_is_qnan = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[9]) | ~(f1_op2_h_nanboxing);
wire f1_op2_h_is_snan = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[8:0] != 9'b0) & (f1_op2_h_nanboxing) & ~f1_op2_data[9];
wire f1_op1_s_is_inf = (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22:0] == 23'b0) & (f1_op1_s_nanboxing);
wire f1_op1_s_is_subnor = (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] != 23'b0) & (f1_op1_s_nanboxing);
wire f1_op1_s_is_qnan = (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22]) | ~(f1_op1_s_nanboxing);
wire f1_op1_s_is_snan = (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[21:0] != 22'b0) & (f1_op1_s_nanboxing) & ~f1_op1_data[22];
wire f1_op2_s_is_inf = (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[22:0] == 23'b0) & (f1_op2_s_nanboxing);
wire f1_op2_s_is_subnor = (f1_op2_data[30:23] == 8'b0) & (f1_op2_data[22:0] != 23'b0) & (f1_op2_s_nanboxing);
wire f1_op2_s_is_qnan = (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[22]) | ~(f1_op2_s_nanboxing);
wire f1_op2_s_is_snan = (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[21:0] != 22'b0) & (f1_op2_s_nanboxing) & ~f1_op2_data[22];
wire f1_op1_is_inf = f1_frs_hp & f1_op1_h_is_inf | f1_frs_sp & f1_op1_s_is_inf | f1_frs_dp & f1_op1_d_is_inf;
wire f1_op1_is_snan = f1_frs_hp & f1_op1_h_is_snan | f1_frs_sp & f1_op1_s_is_snan | f1_frs_dp & f1_op1_d_is_snan;
wire f1_op1_is_qnan = f1_frs_hp & f1_op1_h_is_qnan | f1_frs_sp & f1_op1_s_is_qnan | f1_frs_dp & f1_op1_d_is_qnan;
wire f1_op2_is_inf = f1_frs_hp & f1_op2_h_is_inf | f1_frs_sp & f1_op2_s_is_inf | f1_frs_dp & f1_op2_d_is_inf;
wire f1_op2_is_snan = f1_frs_hp & f1_op2_h_is_snan | f1_frs_sp & f1_op2_s_is_snan | f1_frs_dp & f1_op2_d_is_snan;
wire f1_op2_is_qnan = f1_frs_hp & f1_op2_h_is_qnan | f1_frs_sp & f1_op2_s_is_qnan | f1_frs_dp & f1_op2_d_is_qnan;
wire f1_op1_is_nan = f1_op1_is_qnan | f1_op1_is_snan;
wire f1_op2_is_nan = f1_op2_is_qnan | f1_op2_is_snan;
wire f1_md_diff_signed = f1_op1_signed ^ f1_op2_signed;
assign f1_frd_is_zero = (f1_div_instr | f1_vdiv_instr) & ~f1_op2_is_zero & ~f1_op2_is_nan & f1_op1_is_zero & f1_op1_is_nanboxed & f1_op2_is_nanboxed | (f1_div_instr | f1_vdiv_instr) & ~f1_op1_is_nan & f1_op2_is_inf & f1_op1_is_nanboxed & f1_op2_is_nanboxed | (f1_sqrt_instr | f1_vsqrt_instr) & f1_op1_is_zero & f1_op1_is_nanboxed | (f1_vfrece7_instr) & f1_op1_is_inf & f1_op1_is_nanboxed | (f1_vfrsqrte7_instr) & f1_op1_is_inf & ~f1_op1_signed & f1_op1_is_nanboxed & f1_op2_is_nanboxed;
assign f1_frd_is_inf = (f1_div_instr | f1_vdiv_instr) & ~(f1_op1_is_zero | f1_op1_is_nan) & f1_op2_is_zero & f1_op1_is_nanboxed & f1_op2_is_nanboxed | (f1_div_instr | f1_vdiv_instr) & ~(f1_op2_is_inf | f1_op2_is_nan) & f1_op1_is_inf & f1_op1_is_nanboxed & f1_op2_is_nanboxed | (f1_sqrt_instr | f1_vsqrt_instr) & f1_op1_is_inf & f1_op1_is_nanboxed | (f1_vfrece7_instr | f1_vfrsqrte7_instr) & f1_op1_is_zero & f1_op1_is_nanboxed;
assign f1_frd_is_qnan = (f1_div_instr | f1_vdiv_instr) & (f1_op1_is_nan | f1_op2_is_nan) | (f1_div_instr | f1_vdiv_instr) & (f1_op1_is_inf & f1_op2_is_inf) | (f1_div_instr | f1_vdiv_instr) & (f1_op1_is_zero & f1_op2_is_zero) | (f1_sqrt_instr | f1_vsqrt_instr | f1_vfrsqrte7_instr) & (f1_op1_is_nan | (f1_op1_signed & ~f1_op1_is_zero)) | (f1_vfrece7_instr) & (f1_op1_is_nan);
assign f1_dz_exception = (f1_div_instr | f1_vdiv_instr) & f1_op2_is_zero & ~(f1_op1_is_zero | f1_op1_is_nan | f1_op1_is_inf) & f1_op2_is_nanboxed | (f1_vfrece7_instr | f1_vfrsqrte7_instr) & f1_op1_is_zero & f1_op1_is_nanboxed;
assign f1_nv_exception = (f1_div_instr | f1_vdiv_instr) & (f1_op1_is_inf & f1_op2_is_inf) & f1_op1_is_nanboxed & f1_op2_is_nanboxed | (f1_div_instr | f1_vdiv_instr) & (f1_op1_is_zero & f1_op2_is_zero) & f1_op1_is_nanboxed & f1_op2_is_nanboxed | (f1_div_instr | f1_vdiv_instr) & ((f1_op1_is_snan & f1_op1_is_nanboxed) | (f1_op2_is_snan & f1_op2_is_nanboxed)) | (f1_sqrt_instr | f1_vsqrt_instr | f1_vfrsqrte7_instr) & (f1_op1_signed & ~f1_op1_is_zero & ~f1_op1_is_nan) & f1_op1_is_nanboxed | (f1_sqrt_instr | f1_vsqrt_instr | f1_vfrsqrte7_instr) & f1_op1_is_snan & f1_op1_is_nanboxed | (f1_vfrece7_instr) & f1_op1_is_snan & f1_op1_is_nanboxed;
assign f1_frd_zero_sign = (f1_div_instr | f1_vdiv_instr) & f1_md_diff_signed | (f1_sqrt_instr | f1_vsqrt_instr) & f1_op1_signed;
assign f1_frd_inf_sign = (f1_div_instr | f1_vdiv_instr) & (f1_op1_is_inf | f1_op2_is_inf) & f1_md_diff_signed | (f1_div_instr | f1_vdiv_instr) & (f1_op2_is_zero) & f1_md_diff_signed;
assign f1_vdiv_instr = 1'b0;
assign f1_vsqrt_instr = 1'b0;
assign f1_div_instr = (f1_ex_ctrl[4:0] == 5'b00000);
assign f1_sqrt_instr = (f1_ex_ctrl[4:0] == 5'b00001);
assign f1_scalar_fpu_instr = f1_div_instr | f1_sqrt_instr;
assign f1_estimate7_instr = f1_vfrece7_instr | f1_vfrsqrte7_instr;
assign f2_estimate7_instr = f2_vfrece7_instr | f2_vfrsqrte7_instr;
assign f2_div_instr_nx = f1_div_instr | f1_vdiv_instr;
assign f2_sqrt_instr_nx = f1_sqrt_instr | f1_vsqrt_instr;
assign f1_op1_is_zero = f1_frs_hp & (~(|f1_op1_data[14:0])) | f1_frs_sp & (~(|f1_op1_data[30:0])) | f1_frs_dp & (~(|f1_op1_data[62:0]));
assign f1_op2_is_zero = f1_frs_hp & (~(|f1_op2_data[14:0])) | f1_frs_sp & (~(|f1_op2_data[30:0])) | f1_frs_dp & (~(|f1_op2_data[62:0]));
assign f1_op1_is_subnorm = f1_frs_hp & (~(|f1_op1_data[14:10])) | f1_frs_sp & (~(|f1_op1_data[30:23])) | f1_frs_dp & (~(|f1_op1_data[62:52]));
assign f1_op2_is_subnorm = f1_frs_hp & (~(|f1_op2_data[14:10])) | f1_frs_sp & (~(|f1_op2_data[30:23])) | f1_frs_dp & (~(|f1_op2_data[62:52]));
assign f1_op1_hidden_one = ~f1_op1_is_subnorm;
assign f1_op2_hidden_one = ~f1_op2_is_subnorm;
assign f1_op1_signed = f1_frs_hp & f1_op1_data[15] | f1_frs_sp & f1_op1_data[31] | f1_frs_dp & f1_op1_data[63];
assign f1_op2_signed = f1_frs_hp & f1_op2_data[15] | f1_frs_sp & f1_op2_data[31] | f1_frs_dp & f1_op2_data[63];
assign f1_arith_sign = f1_estimate7_instr ? f1_op1_signed : f1_frd_is_zero ? f1_frd_zero_sign : f1_frd_is_inf ? f1_frd_inf_sign : (f1_vsqrt_instr | f1_sqrt_instr) ? 1'b0 : f1_op1_signed ^ f1_op2_signed;
assign f1_ds_din0_dp = {54{f1_frs_hp & (~f1_div_instr) & f1_op1_normal_exp[0]}} & {2'd1,f1_op1_fraction[51:42],42'd0} | {54{f1_frs_sp & (~f1_div_instr) & f1_op1_normal_exp[0]}} & {2'd1,f1_op1_fraction[51:29],29'd0} | {54{f1_frs_dp & (~f1_div_instr) & f1_op1_normal_exp[0]}} & {2'd1,f1_op1_fraction[51:0]} | {54{f1_frs_hp & (f1_div_instr | ~f1_op1_normal_exp[0])}} & {1'd1,f1_op1_fraction[51:42],43'd0} | {54{f1_frs_sp & (f1_div_instr | ~f1_op1_normal_exp[0])}} & {1'd1,f1_op1_fraction[51:29],30'd0} | {54{f1_frs_dp & (f1_div_instr | ~f1_op1_normal_exp[0])}} & {1'd1,f1_op1_fraction[51:0],1'd0};
assign f1_ds_din1_dp = {53{f1_frs_hp}} & {1'd1,f1_op2_fraction[51:42],42'd0} | {53{f1_frs_sp}} & {1'b1,f1_op2_fraction[51:29],29'd0} | {53{f1_frs_dp}} & {1'b1,f1_op2_fraction[51:0]};
wire f1_div_enable = f1_div_instr & f1_valid & ~f3_main_pipe_stall;
wire f1_sqrt_enable = f1_sqrt_instr & f1_valid & ~f3_main_pipe_stall;
assign ds_stall = 1'b0;
assign f1_frs_type = f1_frs_hp ? 2'b10 : f1_frs_sp ? 2'b01 : f1_frs_dp ? 2'b00 : 2'b00;
wire dsu_ds_invalidate = kill;

module kv_fpu_fdiv (
    fdiv_standby_ready,
    f4_wdata,
    f4_wdata_en,
    f4_flag_set,
    f4_result_type,
    f4_tag,
    f4_frf_stall,
    f1_op1_data,
    f1_op2_data,
    f1_valid,
    f1_round_mode,
    f1_sew,
    f1_ediv,
    f1_ex_ctrl,
    f1_tag,
    kill,
    f3_main_pipe_stall,
    req_ready,
    core_clk,
    core_reset_n
);
parameter FLEN = 32;
localparam DSU_FRA_MSB = (FLEN == 64) ? 161 : (FLEN == 32) ? 132 : 119;
localparam DSU_FRA_LSB = 108;
localparam DSU_FRA_RND = 107;
localparam DSU_SRT_MSB = DSU_FRA_MSB;
localparam DSU_SRT_LSB = 104;
localparam FRACTION_WIDTH = (FLEN == 64) ? 53 : (FLEN == 32) ? 24 : 11;
localparam FRACTION_MSB = (FRACTION_WIDTH - 1);
localparam DS_DIN_WIDTH = (FRACTION_WIDTH + 1);
localparam DS_DIN_MSB = (DS_DIN_WIDTH - 1);
localparam DS_DOUT_WIDTH = (FRACTION_WIDTH + 5);
localparam DS_DOUT_MSB = (DS_DOUT_WIDTH - 1);
localparam ROUND_ZERO = 2'b00;
localparam ROUND_NEG = 2'b01;
localparam ROUND_POS = 2'b10;
localparam ROUND_NEAREST = 2'b11;
localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;
localparam HP = 3'b001;
localparam SP = 3'b010;
localparam DP = 3'b011;
output fdiv_standby_ready;
output [63:0] f4_wdata;
output f4_wdata_en;
output [4:0] f4_flag_set;
output [4:0] f4_tag;
output [1:0] f4_result_type;
input f4_frf_stall;
input [63:0] f1_op1_data;
input [63:0] f1_op2_data;
input f1_valid;
input [4:0] f1_tag;
input [2:0] f1_round_mode;
input [2:0] f1_sew;
input [1:0] f1_ediv;
input [5:0] f1_ex_ctrl;
input core_clk;
input core_reset_n;
input kill;
input f3_main_pipe_stall;
output req_ready;


wire f1_vfrece7_instr;
wire f1_vfrsqrte7_instr;
wire f1_estimate7_instr;
wire [11:0] f1_estimate7_exp;
wire f1_op1_subnorm_overflow;
wire f1_vdiv_instr;
wire f1_vsqrt_instr;
wire f1_div_instr;
wire f1_sqrt_instr;
wire f1_scalar_fpu_instr;
wire f1_frs_hp;
wire f1_frs_sp;
wire f1_frs_dp;
wire f1_frd_is_inf;
wire f1_frd_is_zero;
wire f1_frd_is_qnan;
wire f1_frd_zero_sign;
wire f1_frd_inf_sign;
wire f1_op1_is_zero;
wire f1_op2_is_zero;
wire f1_op1_is_subnorm;
wire f1_op2_is_subnorm;
wire f1_op1_hidden_one;
wire f1_op2_hidden_one;
wire f1_op1_signed;
wire f1_op2_signed;
wire f1_op1_d_is_inf;
wire f1_op1_d_is_subnor;
wire f1_op1_d_is_qnan;
wire f1_op1_d_is_snan;
wire f1_op2_d_is_inf;
wire f1_op2_d_is_subnor;
wire f1_op2_d_is_qnan;
wire f1_op2_d_is_snan;
wire [11:0] f1_op1_normal_exp;
wire [11:0] f1_op2_normal_exp;
wire [FRACTION_MSB:0] f1_op1_normal_fraction;
wire [FRACTION_MSB:0] f1_op2_normal_fraction;
wire f1_dz_exception;
wire f1_nv_exception;
wire f1_arith_sign;
wire f2_div_instr_nx;
wire f2_sqrt_instr_nx;
reg f2_vfrece7_instr;
reg f2_vfrsqrte7_instr;
wire f2_estimate7_instr;
wire [63:0] f2_estimate7_wdata;
wire [4:0] f2_estimate7_flag;
wire [1:0] f2_estimate7_result_type;
wire f2_frd_hp;
wire f2_frd_sp;
wire f2_frd_dp;
wire [FRACTION_MSB:0] f2_op1_normal_fraction;
wire [FRACTION_MSB:0] f2_op2_normal_fraction;
wire [11:0] f2_op1_normal_exp;
wire [11:0] f2_op2_normal_exp;
wire [11:0] f2_op1_exp;
wire [11:0] f2_op2_exp;
wire [12:0] f2_op1_exp_no_bias;
wire [12:0] f2_op1_exp_with_bias;
wire [12:0] f2_op2_exp_with_bias;
wire [12:0] f2_div_exp;
wire [12:0] f2_ds_exp;
wire [12:0] f2_ds_exp_minus_1;
wire [52:0] f1_op1_fraction;
wire [52:0] f1_op2_fraction;
wire [1:0] f1_frs_type;
wire [53:1] f1_ds_din1_dp;
wire [53:0] f1_ds_din0_dp;
reg [2:0] f2_round_mode;
reg f2_frs_hp;
reg f2_frs_sp;
reg f2_frs_dp;
reg f2_frd_is_inf;
reg f2_frd_is_zero;
reg f2_frd_is_qnan;
reg f2_div_instr;
reg f2_sqrt_instr;
reg f2_scalar_fpu_instr;
reg f2_dz_exception;
reg f2_nv_exception;
reg f2_arith_sign;
reg f2_valid;
reg [4:0] f2_tag;
wire correct_qr_nx;
wire ds_sticky_nx;
wire f3_dz_exception = f2_dz_exception;
wire f3_nv_exception = f2_nv_exception;
wire f3_frd_is_inf = f2_frd_is_inf;
wire f3_frd_is_zero = f2_frd_is_zero;
wire f3_frd_is_qnan = f2_frd_is_qnan;
wire f3_frd_hp = f2_frd_hp;
wire f3_frd_sp = f2_frd_sp;
wire f3_frd_dp = f2_frd_dp;
wire f3_arith_sign = f2_arith_sign;
wire f3_div_instr = f2_div_instr;
wire [2:0] f3_round_mode = f2_round_mode;
wire [DSU_SRT_MSB:DSU_SRT_LSB] f3_normal_result;
wire [DS_DOUT_MSB:0] f3_shifted_ds_result;
wire [DS_DOUT_MSB:0] f3_ds_result;
wire [DS_DOUT_MSB:0] f3_ds_result0;
wire [DS_DOUT_MSB:0] f3_ds_result1;
wire [DS_DOUT_MSB:0] ds_result_added;
wire f3_ds_exp_adj;
wire [12:0] f3_ds_exp;
wire [12:0] f3_ds_exp_minus_1;
wire [12:0] f3_subnorm_pred_num;
wire f3_subnorm_pred;
wire f3_hp_subnorm_pred;
wire f3_sp_subnorm_pred;
wire f3_dp_subnorm_pred;
wire [5:0] f3_sbs_amount;
wire [DS_DOUT_MSB:0] f3_sbs_prepare;
wire [DS_DOUT_MSB:0] f3_sbs_l0;
wire [DS_DOUT_MSB:0] f3_sbs_l1;
wire [DS_DOUT_MSB:0] f3_sbs_l2;
wire [DS_DOUT_MSB:0] f3_sbs_l3;
wire [DS_DOUT_MSB:0] f3_sbs_l4;
wire [DS_DOUT_MSB:0] f3_sbs_l5;
wire f3_sbs_sticky_l0;
wire f3_sbs_sticky_l1;
wire f3_sbs_sticky_l2;
wire f3_sbs_sticky_l3;
wire f3_sbs_sticky_l4;
wire f3_sbs_sticky_l5;
wire f3_sbs_sticky;
wire f3_exp_p0_d_gt_ovf_bound;
wire f3_exp_p0_d_gt_sub_bound;
wire f3_exp_p0_d_gt_udf_bound;
wire f3_exp_p0_s_gt_ovf_bound;
wire f3_exp_p0_s_gt_sub_bound;
wire f3_exp_p0_s_gt_udf_bound;
wire f3_exp_p0_h_gt_ovf_bound;
wire f3_exp_p0_h_gt_sub_bound;
wire f3_exp_p0_h_gt_udf_bound;
wire f3_exp_p1_d_gt_ovf_bound;
wire f3_exp_p1_d_gt_sub_bound;
wire f3_exp_p1_d_gt_udf_bound;
wire f3_exp_p1_s_gt_ovf_bound;
wire f3_exp_p1_s_gt_sub_bound;
wire f3_exp_p1_s_gt_udf_bound;
wire f3_exp_p1_h_gt_ovf_bound;
wire f3_exp_p1_h_gt_sub_bound;
wire f3_exp_p1_h_gt_udf_bound;
wire f3_stall;
reg f3_valid;
reg ds_sticky;
reg correct_qr;
reg [4:0] f3_tag;
reg [1:0] f4_rounding_nx;
wire f4_rn_nx;
wire f4_ri_nx;
wire [12:0] f4_dsu_exp_nx;
wire f4_ds_sticky_nx;
wire f4_arith_sign_nx;
wire f4_exp_p0_gt_ovf_bound_nx;
wire f4_exp_p0_gt_sub_bound_nx;
wire f4_exp_p0_gt_udf_bound_nx;
wire f4_exp_p1_gt_ovf_bound_nx;
wire f4_exp_p1_gt_sub_bound_nx;
wire f4_exp_p1_gt_udf_bound_nx;
wire f4_scalar_fpu_instr = f2_scalar_fpu_instr;
wire [2:0] f4_round_mode = f3_round_mode;
wire f4_dz_exception = f3_dz_exception;
wire f4_nv_exception = f3_nv_exception;
wire f4_arith_sign = f3_arith_sign;
wire f4_frd_is_inf = f3_frd_is_inf;
wire f4_frd_is_zero = f3_frd_is_zero;
wire f4_frd_is_qnan = f3_frd_is_qnan;
wire f4_frd_hp = f3_frd_hp;
wire f4_frd_sp = f3_frd_sp;
wire f4_frd_dp = f3_frd_dp;
wire f4_frd_result_zero;
wire f4_frd_result_inf;
wire f4_frd_result_largest;
wire f4_frd_result_smallest;
wire f4_frd_is_special;
wire f4_frd_is_qnan_hp;
wire f4_frd_is_qnan_sp;
wire f4_frd_is_qnan_dp;
wire f4_frd_result_inf_hp;
wire f4_frd_result_inf_sp;
wire f4_frd_result_inf_dp;
wire f4_frd_result_zero_hp;
wire f4_frd_result_zero_sp;
wire f4_frd_result_zero_dp;
wire f4_frd_result_largest_hp;
wire f4_frd_result_largest_sp;
wire f4_frd_result_largest_dp;
wire f4_frd_result_smallest_hp;
wire f4_frd_result_smallest_sp;
wire f4_frd_result_smallest_dp;
wire [DSU_SRT_MSB:DSU_SRT_LSB] f4_normal_result;
wire [DSU_FRA_MSB:DSU_FRA_RND] f4_round_adder_result;
wire [DSU_FRA_MSB:DSU_FRA_RND] f4_round_adder_op0;
wire [DSU_FRA_MSB:108] f4_fraction;
wire f4_zero_sign;
wire f4_wdata_en;
wire [63:0] f4_wdata;
wire [63:0] f4_arith_wdata;
wire [63:0] f4_non_arith_wdata;
wire f4_non_arith_wdata_en;
wire f4_rn;
wire f4_ri;
wire f4_round_bit;
wire [1:0] f4_round_digit;
wire [1:0] f4_round_ha;
wire [11:0] f4_dsu_exp;
wire [11:0] f4_exp_bias;
wire f4_exp_inc;
wire f4_exp_gt_ovf_bound;
wire f4_exp_gt_sub_bound;
wire f4_exp_gt_udf_bound;
wire f4_exp_p0_gt_ovf_bound;
wire f4_exp_p0_gt_sub_bound;
wire f4_exp_p0_gt_udf_bound;
wire f4_exp_p1_gt_ovf_bound;
wire f4_exp_p1_gt_sub_bound;
wire f4_exp_p1_gt_udf_bound;
wire f4_nx_exception;
wire f4_of_exception;
wire f4_uf_exception;
wire f4_subnorm;
wire f4_subnorm_to_normal;
wire f4_subnorm_set_uf;
wire f4_subnorm_set_uf_cond1;
wire f4_subnorm_set_uf_cond2;
wire f4_subnorm_uf_cond1;
wire f4_subnorm_uf_cond2;
wire [11:0] f4_subnorm_amount;
wire f4_ds_sticky;
wire f4_sticky;
wire f4_sticky_lsb;
wire f4_sticky_lsb_hi_bit_106;
wire f4_all_zero;
wire f4_fraction_all_zero;
wire f4_fraction_lsb;
wire f4_tie_clr_lsb;
wire f4_tie;
reg f4_valid;
reg [4:0] f4_tag;
reg f4_retired;
wire f4_retired_set;
wire f4_retired_clr;
wire f4_retired_nx;
wire f4_retired_en;
reg ds_busy_d1;
wire [DS_DIN_MSB:0] ds_din0;
wire [DS_DIN_MSB:1] ds_din1;
wire [DS_DOUT_MSB:0] ds_result0;
wire [DS_DOUT_MSB:0] ds_result1;
wire ds_busy;
wire ds_gen_sticky;
wire ds_calc_done;
wire ds_stall;
wire f3_sel_ds;
wire f2_pipe_en;
wire f3_pipe_en;
wire f4_pipe_en;
assign fdiv_standby_ready = ~f1_valid & ~f2_valid & ~f3_valid & ~f4_valid;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f2_tag <= 5'b0;
    end
    else if (f2_pipe_en) begin
        f2_tag <= f1_tag;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f3_tag <= 5'b0;
    end
    else if (f3_pipe_en) begin
        f3_tag <= f2_tag;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f4_tag <= 5'b0;
    end
    else if (f4_pipe_en) begin
        f4_tag <= f3_tag;
    end
end

assign f4_retired_set = f4_valid & f4_frf_stall;
assign f4_retired_clr = f4_valid & ~f4_frf_stall;
assign f4_retired_nx = (f4_retired & ~f4_retired_clr) | f4_retired_set;
assign f4_retired_en = f4_retired_set | f4_retired_clr;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f4_retired <= 1'b0;
    end
    else if (f4_retired_en) begin
        f4_retired <= f4_retired_nx;
    end
end

wire fp_double_precision_support = (FLEN == 64);
wire fp_single_precision_support = (FLEN == 32) | fp_double_precision_support;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ds_busy_d1 <= 1'b0;
    end
    else if (f1_valid | f2_valid | f3_valid | f4_valid) begin
        ds_busy_d1 <= ds_busy;
    end
end

assign req_ready = (~f1_valid & ~f2_valid & ~f3_valid & ~f4_valid) | (f4_valid & ~f1_valid & ~f2_valid & ~f3_valid & ~f4_frf_stall);
wire f2_valid_nx = (f1_valid & ~kill & ~f3_stall & ~(f4_frf_stall & f4_valid) & ~f3_main_pipe_stall) | (f2_valid & ~kill & f3_main_pipe_stall);
wire f3_valid_nx = (f3_stall & ~kill) | (f2_valid & ~f2_estimate7_instr & ~kill & ~f3_main_pipe_stall);
wire f4_valid_nx = (~f3_stall & f3_valid & ~kill) | (f4_frf_stall & f4_valid & (~kill | f4_retired));
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f2_valid <= 1'b0;
        f3_valid <= 1'b0;
        f4_valid <= 1'b0;
    end
    else begin
        f2_valid <= f2_valid_nx;
        f3_valid <= f3_valid_nx;
        f4_valid <= f4_valid_nx;
    end
end

assign f3_sel_ds = ds_gen_sticky | ds_calc_done;
assign f2_pipe_en = f1_valid & ~f3_stall & ~(f4_frf_stall & f4_valid);
assign f3_pipe_en = f2_valid & ~f2_estimate7_instr & ~f3_main_pipe_stall;
assign f4_pipe_en = f3_valid & ~f3_stall;
reg [DS_DOUT_MSB:0] ds_fraction_1;
reg [DS_DOUT_MSB:0] ds_fraction_2;
wire [DS_DOUT_MSB:0] ds_fraction_1_nx;
wire [DS_DOUT_MSB:0] ds_fraction_2_nx;
wire [DS_DOUT_MSB:0] f3_control_bits;
assign f3_control_bits = {{(DS_DOUT_WIDTH - 9){1'b0}},f4_ds_sticky_nx,f4_ri_nx,f4_rn_nx,f4_exp_p0_gt_ovf_bound_nx,f4_exp_p0_gt_sub_bound_nx,f4_exp_p0_gt_udf_bound_nx,f4_exp_p1_gt_ovf_bound_nx,f4_exp_p1_gt_sub_bound_nx,f4_exp_p1_gt_udf_bound_nx};
assign {f4_ds_sticky,f4_ri,f4_rn,f4_exp_p0_gt_ovf_bound,f4_exp_p0_gt_sub_bound,f4_exp_p0_gt_udf_bound,f4_exp_p1_gt_ovf_bound,f4_exp_p1_gt_sub_bound,f4_exp_p1_gt_udf_bound} = ds_fraction_2[8:0];
assign ds_fraction_1_nx = {(DS_DOUT_WIDTH){f2_pipe_en}} & {5'b0,f1_op1_normal_fraction} | {(DS_DOUT_WIDTH){f3_sel_ds}} & ds_result0 | {(DS_DOUT_WIDTH){f4_pipe_en}} & f3_normal_result;
assign ds_fraction_2_nx = {(DS_DOUT_WIDTH){f2_pipe_en}} & {5'b0,f1_op2_normal_fraction} | {(DS_DOUT_WIDTH){f3_sel_ds}} & ds_result1 | {(DS_DOUT_WIDTH){f4_pipe_en}} & f3_control_bits;
assign f2_op1_normal_fraction = ds_fraction_1[FRACTION_MSB:0];
assign f2_op2_normal_fraction = ds_fraction_2[FRACTION_MSB:0];
assign f3_ds_result0 = ds_fraction_1;
assign f3_ds_result1 = ds_fraction_2;
assign f4_normal_result = ds_fraction_1;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ds_fraction_1 <= {(DS_DOUT_MSB + 1){1'b0}};
        ds_fraction_2 <= {(DS_DOUT_MSB + 1){1'b0}};
    end
    else if (f2_pipe_en | f3_sel_ds | f4_pipe_en) begin
        ds_fraction_1 <= ds_fraction_1_nx;
        ds_fraction_2 <= ds_fraction_2_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        correct_qr <= 1'b0;
        ds_sticky <= 1'b0;
    end
    else if (ds_gen_sticky) begin
        correct_qr <= correct_qr_nx;
        ds_sticky <= ds_sticky_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f2_scalar_fpu_instr <= 1'b0;
        f2_frd_is_inf <= 1'b0;
        f2_frd_is_zero <= 1'b0;
        f2_frd_is_qnan <= 1'b0;
        f2_frs_hp <= 1'b0;
        f2_frs_sp <= 1'b0;
        f2_frs_dp <= 1'b0;
        f2_round_mode <= 3'b0;
        f2_div_instr <= 1'b0;
        f2_sqrt_instr <= 1'b0;
        f2_nv_exception <= 1'b0;
        f2_dz_exception <= 1'b0;
        f2_arith_sign <= 1'b0;
        f2_vfrece7_instr <= 1'b0;
        f2_vfrsqrte7_instr <= 1'b0;
    end
    else if (f2_pipe_en) begin
        f2_scalar_fpu_instr <= f1_scalar_fpu_instr;
        f2_frd_is_inf <= f1_frd_is_inf;
        f2_frd_is_zero <= f1_frd_is_zero;
        f2_frd_is_qnan <= f1_frd_is_qnan;
        f2_frs_hp <= f1_frs_hp;
        f2_frs_sp <= f1_frs_sp;
        f2_frs_dp <= f1_frs_dp;
        f2_round_mode <= f1_round_mode;
        f2_div_instr <= f2_div_instr_nx;
        f2_sqrt_instr <= f2_sqrt_instr_nx;
        f2_nv_exception <= f1_nv_exception;
        f2_dz_exception <= f1_dz_exception;
        f2_arith_sign <= f1_arith_sign;
        f2_vfrece7_instr <= f1_vfrece7_instr;
        f2_vfrsqrte7_instr <= f1_vfrsqrte7_instr;
    end
end

reg [12:0] ds_exp_1;
reg [12:0] ds_exp_2;
wire [12:0] ds_exp_1_nx;
wire [12:0] ds_exp_2_nx;
assign ds_exp_1_nx = {13{f2_pipe_en}} & {1'b0,f1_op1_normal_exp} | {13{f3_pipe_en}} & f2_ds_exp | {13{f4_pipe_en}} & f4_dsu_exp_nx;
assign ds_exp_2_nx = {13{f2_pipe_en & f1_estimate7_instr}} & {f1_op1_subnorm_overflow,f1_estimate7_exp} | {13{f2_pipe_en & ~f1_estimate7_instr}} & {1'b0,f1_op2_normal_exp} | {13{f3_pipe_en}} & f2_ds_exp_minus_1;
assign f2_op1_normal_exp = ds_exp_1[11:0];
assign f2_op2_normal_exp = ds_exp_2[11:0];
assign f3_ds_exp = ds_exp_1;
assign f3_ds_exp_minus_1 = ds_exp_2;
assign f4_dsu_exp = ds_exp_1[11:0];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ds_exp_1 <= 13'b0;
        ds_exp_2 <= 13'b0;
    end
    else if (f2_pipe_en | f3_pipe_en | f4_pipe_en) begin
        ds_exp_1 <= ds_exp_1_nx;
        ds_exp_2 <= ds_exp_2_nx;
    end
end

kv_fpu_dsu #(
    .FLEN(FLEN)
) kv_fpu_dsu (
    .ds_busy(ds_busy),
    .ds_gen_sticky(ds_gen_sticky),
    .ds_calc_done(ds_calc_done),
    .ds_result0(ds_result0),
    .ds_result1(ds_result1),
    .ds_din0(ds_din0),
    .ds_din1(ds_din1[DS_DIN_MSB:1]),
    .div_enable(f1_div_enable),
    .sqrt_enable(f1_sqrt_enable),
    .ds_invalidate(dsu_ds_invalidate),
    .ds_type(f1_frs_type),
    .f3_stall(ds_stall),
    .core_clk(core_clk),
    .core_reset_n(core_reset_n)
);
assign f2_op1_exp_no_bias = {f2_op1_exp[11],f2_op1_exp} - (({13{f2_frs_hp}} & 13'd15) | ({13{f2_frs_sp}} & 13'd127) | ({13{f2_frs_dp}} & 13'd1023));
assign f2_op1_exp_with_bias = {f2_op1_exp[11],f2_op1_exp};
assign f2_op2_exp_with_bias = {f2_op2_exp[11],f2_op2_exp};
assign f2_div_exp = f2_op1_exp_with_bias - f2_op2_exp_with_bias;
assign f2_ds_exp = f2_div_instr ? f2_div_exp : {f2_op1_exp_no_bias[12],f2_op1_exp_no_bias[12:1]};
assign f2_ds_exp_minus_1 = f2_ds_exp - 13'd1;
assign f2_frd_hp = f2_frs_hp;
assign f2_frd_sp = f2_frs_sp;
assign f2_frd_dp = f2_frs_dp;
assign ds_result_added = ds_fraction_1 + ds_fraction_2;
assign correct_qr_nx = ds_result_added[(DS_DOUT_MSB - 1)];
assign ds_sticky_nx = |ds_result_added[(DS_DOUT_MSB - 1):0];
assign f3_ds_result = correct_qr ? f3_ds_result1 : f3_ds_result0;
assign f3_shifted_ds_result = f3_ds_exp_adj ? {f3_ds_result[(DS_DOUT_MSB - 1):0],1'b0} : f3_ds_result;
assign f3_normal_result = f3_sbs_l5[DS_DOUT_MSB:0];
assign f3_stall = f3_valid & (ds_busy | ds_busy_d1 | f3_main_pipe_stall | (f4_frf_stall & f4_valid));
assign f4_dsu_exp_nx = (f3_div_instr & f3_ds_exp_adj) ? f3_ds_exp_minus_1 : f3_ds_exp;
assign f4_arith_sign_nx = f3_arith_sign;
assign f4_ds_sticky_nx = ds_sticky | f3_sbs_sticky;
assign f3_exp_p0_h_gt_ovf_bound = ~f4_dsu_exp_nx[12] & (f4_dsu_exp_nx[11:0] > 12'd15);
assign f3_exp_p0_h_gt_sub_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd14);
assign f3_exp_p0_h_gt_udf_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd25);
assign f3_exp_p1_h_gt_ovf_bound = ~f4_dsu_exp_nx[12] & (f4_dsu_exp_nx[11:0] > 12'd14);
assign f3_exp_p1_h_gt_sub_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd15);
assign f3_exp_p1_h_gt_udf_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd26);
assign f4_exp_p0_gt_ovf_bound_nx = (f3_frd_hp & f3_exp_p0_h_gt_ovf_bound) | (f3_frd_sp & f3_exp_p0_s_gt_ovf_bound) | (f3_frd_dp & f3_exp_p0_d_gt_ovf_bound);
assign f4_exp_p0_gt_sub_bound_nx = (f3_frd_hp & f3_exp_p0_h_gt_sub_bound) | (f3_frd_sp & f3_exp_p0_s_gt_sub_bound) | (f3_frd_dp & f3_exp_p0_d_gt_sub_bound);
assign f4_exp_p0_gt_udf_bound_nx = (f3_frd_hp & f3_exp_p0_h_gt_udf_bound) | (f3_frd_sp & f3_exp_p0_s_gt_udf_bound) | (f3_frd_dp & f3_exp_p0_d_gt_udf_bound);
assign f4_exp_p1_gt_ovf_bound_nx = (f3_frd_hp & f3_exp_p1_h_gt_ovf_bound) | (f3_frd_sp & f3_exp_p1_s_gt_ovf_bound) | (f3_frd_dp & f3_exp_p1_d_gt_ovf_bound);
assign f4_exp_p1_gt_sub_bound_nx = (f3_frd_hp & f3_exp_p1_h_gt_sub_bound) | (f3_frd_sp & f3_exp_p1_s_gt_sub_bound) | (f3_frd_dp & f3_exp_p1_d_gt_sub_bound);
assign f4_exp_p1_gt_udf_bound_nx = (f3_frd_hp & f3_exp_p1_h_gt_udf_bound) | (f3_frd_sp & f3_exp_p1_s_gt_udf_bound) | (f3_frd_dp & f3_exp_p1_d_gt_udf_bound);
assign f3_dp_subnorm_pred = ~f3_exp_p0_d_gt_sub_bound & f3_exp_p1_d_gt_udf_bound;
assign f3_sp_subnorm_pred = ~f3_exp_p0_s_gt_sub_bound & f3_exp_p1_s_gt_udf_bound;
assign f3_hp_subnorm_pred = ~f3_exp_p0_h_gt_sub_bound & f3_exp_p1_h_gt_udf_bound;
assign f3_subnorm_pred = (f3_frd_hp & f3_hp_subnorm_pred | f3_frd_sp & f3_sp_subnorm_pred | f3_frd_dp & f3_dp_subnorm_pred) & f3_valid & ~ds_busy_d1 & ~(f3_frd_is_inf | f3_frd_is_zero | f3_frd_is_qnan);
assign f3_subnorm_pred_num = ~f4_dsu_exp_nx - (f3_frd_hp ? 13'd13 : f3_frd_sp ? 13'd125 : 13'd1021);
assign f3_sbs_amount = {6{f3_subnorm_pred}} & f3_subnorm_pred_num[5:0];
assign f3_sbs_prepare = {f3_shifted_ds_result[(DS_DOUT_MSB - 1):0],1'b0};
generate
    if (FLEN > 32) begin:gen_f3_sbs_l0_for_dp
        assign f3_sbs_l0 = f3_sbs_amount[5] ? {{32'b0},f3_sbs_prepare[DS_DOUT_MSB:32]} : f3_sbs_prepare;
        assign f3_sbs_sticky_l0 = (f3_sbs_amount[5] & (|f3_sbs_prepare[31:0]));
    end
    else begin:gen_f3_sbs_l0_for_hp_sp
        assign f3_sbs_l0 = f3_sbs_prepare;
        assign f3_sbs_sticky_l0 = 1'b0;
    end
endgenerate
generate
    if (FLEN > 16) begin:gen_f3_sbs_l1_for_dp_sp
        assign f3_sbs_l1 = f3_sbs_amount[4] ? {{16'b0},f3_sbs_l0[DS_DOUT_MSB:16]} : f3_sbs_l0;
        assign f3_sbs_sticky_l1 = (f3_sbs_amount[4] & (|f3_sbs_l0[15:0]));
    end
    else begin:gen_f3_sbs_l1_for_hp
        assign f3_sbs_l1 = f3_sbs_l0;
        assign f3_sbs_sticky_l1 = 1'b0;
    end
endgenerate
assign f3_sbs_l2 = f3_sbs_amount[3] ? {{8'b0},f3_sbs_l1[DS_DOUT_MSB:8]} : f3_sbs_l1;
assign f3_sbs_l3 = f3_sbs_amount[2] ? {{4'b0},f3_sbs_l2[DS_DOUT_MSB:4]} : f3_sbs_l2;
assign f3_sbs_l4 = f3_sbs_amount[1] ? {{2'b0},f3_sbs_l3[DS_DOUT_MSB:2]} : f3_sbs_l3;
assign f3_sbs_l5 = f3_sbs_amount[0] ? {{1'b0},f3_sbs_l4[DS_DOUT_MSB:1]} : f3_sbs_l4;
assign f3_sbs_sticky_l2 = (f3_sbs_amount[3] & (|f3_sbs_l1[7:0]));
assign f3_sbs_sticky_l3 = (f3_sbs_amount[2] & (|f3_sbs_l2[3:0]));
assign f3_sbs_sticky_l4 = (f3_sbs_amount[1] & (|f3_sbs_l3[1:0]));
assign f3_sbs_sticky_l5 = (f3_sbs_amount[0] & (|f3_sbs_l4[0]));
assign f3_sbs_sticky = f3_sbs_sticky_l5 | f3_sbs_sticky_l4 | f3_sbs_sticky_l3 | f3_sbs_sticky_l2 | f3_sbs_sticky_l1 | f3_sbs_sticky_l0;
always @* begin
    case (f3_round_mode)
        ROUND_RMM: f4_rounding_nx = ROUND_NEAREST;
        ROUND_RUP: f4_rounding_nx = ROUND_POS;
        ROUND_RDN: f4_rounding_nx = ROUND_NEG;
        ROUND_RTZ: f4_rounding_nx = ROUND_ZERO;
        default: f4_rounding_nx = ROUND_NEAREST;
    endcase
end

assign f4_rn_nx = f4_rounding_nx[0] & f4_rounding_nx[1];
assign f4_ri_nx = (~f4_arith_sign_nx & ~f4_rounding_nx[0] & f4_rounding_nx[1]) | (f4_arith_sign_nx & f4_rounding_nx[0] & ~f4_rounding_nx[1]);
assign f4_sticky_lsb = |f4_normal_result[(DSU_FRA_RND - 1):DSU_SRT_LSB];
assign f4_sticky = f4_sticky_lsb | f4_ds_sticky;
assign f4_round_adder_op0 = f4_normal_result[DSU_FRA_MSB:DSU_FRA_RND];
assign f4_round_adder_result = f4_round_adder_op0 + {{(DSU_FRA_MSB - DSU_FRA_RND){1'b0}},f4_round_digit[1]} + {{(DSU_FRA_MSB - DSU_FRA_RND){1'b0}},f4_round_digit[0]};
assign f4_round_bit = f4_normal_result[DSU_FRA_RND];
assign f4_tie = f4_round_bit & ~f4_sticky;
assign f4_tie_clr_lsb = f4_tie & (f4_round_mode == ROUND_RNE);
assign f4_fraction_lsb = f4_tie_clr_lsb ? 1'b0 : f4_round_adder_result[DSU_FRA_LSB];
assign f4_fraction = {f4_round_adder_result[DSU_FRA_MSB:(DSU_FRA_LSB + 1)],f4_fraction_lsb};
assign f4_round_digit = {(f4_sticky & f4_ri),(f4_rn | f4_ri)};
assign f4_round_ha = {(f4_round_digit[1] & f4_round_digit[0]),(f4_round_digit[1] ^ f4_round_digit[0])};
assign f4_all_zero = ~(|f4_normal_result[DSU_SRT_MSB:DSU_SRT_LSB]);
assign f4_fraction_all_zero = ~(|f4_fraction[DSU_FRA_MSB:DSU_FRA_LSB]);
assign f4_frd_result_zero = ~f4_frd_is_qnan & ~f4_frd_is_inf & (f4_frd_is_zero | f4_fraction_all_zero | (f4_uf_exception & ~f4_subnorm & ((f4_round_mode == ROUND_RNE) | (f4_round_mode == ROUND_RMM) | (f4_round_mode == ROUND_RTZ) | ((f4_round_mode == ROUND_RUP) & f4_arith_sign) | ((f4_round_mode == ROUND_RDN) & ~f4_arith_sign))));
assign f4_frd_result_smallest = f4_uf_exception & ~f4_subnorm & (((f4_round_mode == ROUND_RUP) & ~f4_arith_sign) | ((f4_round_mode == ROUND_RDN) & f4_arith_sign));
assign f4_frd_result_inf = ~f4_frd_is_qnan & (f4_frd_is_inf | (f4_of_exception & ((f4_round_mode == ROUND_RNE) | (f4_round_mode == ROUND_RMM) | ((f4_round_mode == ROUND_RDN) & f4_arith_sign) | ((f4_round_mode == ROUND_RUP) & ~f4_arith_sign))));
assign f4_frd_result_largest = f4_of_exception & ((f4_round_mode == ROUND_RTZ) | ((f4_round_mode == ROUND_RUP) & f4_arith_sign) | ((f4_round_mode == ROUND_RDN) & ~f4_arith_sign));
assign f4_exp_gt_ovf_bound = f4_exp_inc ? f4_exp_p1_gt_ovf_bound : f4_exp_p0_gt_ovf_bound;
assign f4_exp_gt_sub_bound = f4_exp_inc ? f4_exp_p1_gt_sub_bound : f4_exp_p0_gt_sub_bound;
assign f4_exp_gt_udf_bound = f4_exp_inc ? f4_exp_p1_gt_udf_bound : f4_exp_p0_gt_udf_bound;
assign f4_frd_is_special = f4_frd_is_inf | f4_frd_is_qnan | f4_frd_is_zero;
assign f4_of_exception = f4_exp_gt_ovf_bound & ~(f4_dz_exception | f4_frd_is_special);
assign f4_subnorm = ~f4_exp_gt_sub_bound & f4_exp_gt_udf_bound;
assign f4_sticky_lsb_hi_bit_106 = f4_normal_result[106];
assign f4_subnorm_set_uf_cond1 = f4_subnorm_uf_cond1 & ~(f4_round_ha[1] | (f4_round_ha[0] & f4_sticky_lsb_hi_bit_106));
assign f4_subnorm_set_uf_cond2 = f4_subnorm_uf_cond2 & (f4_sticky | f4_round_bit) & (f4_ri & !f4_rn);
assign f4_subnorm_amount = ~f4_dsu_exp - (f4_frd_hp ? 12'd13 : f4_frd_sp ? 12'd125 : f4_frd_dp ? 12'd1021 : 12'd0);
assign f4_subnorm_set_uf = (f4_subnorm_amount == 12'b1) & (f4_subnorm_set_uf_cond1 | f4_subnorm_set_uf_cond2);
assign f4_uf_exception = f4_subnorm & (f4_round_bit | f4_sticky) & (~f4_subnorm_to_normal | f4_subnorm_set_uf) | (~f4_exp_gt_udf_bound & ~(f4_dz_exception | f4_nv_exception | f4_frd_is_special | (f4_all_zero & ~f4_round_bit & ~f4_sticky)));
assign f4_nx_exception = ~(f4_frd_is_qnan | f4_frd_is_zero) & ((f4_round_bit | f4_sticky) & ~(f4_nv_exception | f4_frd_is_inf) | f4_of_exception | f4_uf_exception);
assign f4_zero_sign = (f4_fraction_all_zero & ~f4_round_bit & ~f4_sticky & ~f4_frd_is_zero) ? (f4_round_mode == ROUND_RDN) : f4_arith_sign;
assign f4_frd_is_qnan_hp = f4_frd_hp & f4_frd_is_qnan;
assign f4_frd_is_qnan_sp = f4_frd_sp & f4_frd_is_qnan;
assign f4_frd_is_qnan_dp = f4_frd_dp & f4_frd_is_qnan;
assign f4_frd_result_inf_hp = f4_frd_hp & f4_frd_result_inf;
assign f4_frd_result_inf_sp = f4_frd_sp & f4_frd_result_inf;
assign f4_frd_result_inf_dp = f4_frd_dp & f4_frd_result_inf;
assign f4_frd_result_zero_hp = f4_frd_hp & f4_frd_result_zero;
assign f4_frd_result_zero_sp = f4_frd_sp & f4_frd_result_zero;
assign f4_frd_result_zero_dp = f4_frd_dp & f4_frd_result_zero;
assign f4_frd_result_largest_hp = f4_frd_hp & f4_frd_result_largest;
assign f4_frd_result_largest_sp = f4_frd_sp & f4_frd_result_largest;
assign f4_frd_result_largest_dp = f4_frd_dp & f4_frd_result_largest;
assign f4_frd_result_smallest_hp = f4_frd_hp & f4_frd_result_smallest;
assign f4_frd_result_smallest_sp = f4_frd_sp & f4_frd_result_smallest;
assign f4_frd_result_smallest_dp = f4_frd_dp & f4_frd_result_smallest;
assign f4_non_arith_wdata = ({64{f4_frd_is_qnan_hp}} & {48'hffffffffffff,1'b0,5'h1f,10'h200}) | ({64{f4_frd_is_qnan_sp}} & {32'hffffffff,1'b0,8'hff,23'h400000}) | ({64{f4_frd_is_qnan_dp}} & {1'b0,11'h7ff,52'h8000000000000}) | ({64{f4_frd_result_inf_hp}} & {48'hffffffffffff,f4_arith_sign,5'h1f,10'h0}) | ({64{f4_frd_result_inf_sp}} & {32'hffffffff,f4_arith_sign,8'hff,23'h0}) | ({64{f4_frd_result_inf_dp}} & {f4_arith_sign,11'h7ff,52'h0}) | ({64{f4_frd_result_zero_hp}} & {48'hffffffffffff,f4_zero_sign,5'h00,10'h0}) | ({64{f4_frd_result_zero_sp}} & {32'hffffffff,f4_zero_sign,8'h00,23'h0}) | ({64{f4_frd_result_zero_dp}} & {f4_zero_sign,11'h000,52'h0}) | ({64{f4_frd_result_largest_hp}} & {48'hffffffffffff,f4_arith_sign,5'h1e,10'h3ff}) | ({64{f4_frd_result_largest_sp}} & {32'hffffffff,f4_arith_sign,8'hfe,23'h7fffff}) | ({64{f4_frd_result_largest_dp}} & {f4_arith_sign,11'h7fe,52'hfffffffffffff}) | ({64{f4_frd_result_smallest_hp}} & {48'hffffffffffff,f4_arith_sign,5'h00,10'h1}) | ({64{f4_frd_result_smallest_sp}} & {32'hffffffff,f4_arith_sign,8'h00,23'h1}) | ({64{f4_frd_result_smallest_dp}} & {f4_arith_sign,11'h000,52'h1});
assign f4_non_arith_wdata_en = f4_frd_result_inf | f4_frd_result_zero | f4_frd_is_qnan | f4_frd_result_largest | f4_frd_result_smallest;
assign f4_wdata = f2_estimate7_instr ? f2_estimate7_wdata : f4_non_arith_wdata_en ? f4_non_arith_wdata : f4_arith_wdata;
assign f4_wdata_en = f4_valid & (~kill | f4_retired) | (f2_estimate7_instr & f2_valid);
assign f4_flag_set = f2_estimate7_instr ? f2_estimate7_flag : {(5){f4_valid}} & {f4_nv_exception,f4_dz_exception,f4_of_exception,f4_uf_exception,f4_nx_exception};
assign f4_result_type = f2_estimate7_instr ? f2_estimate7_result_type : f4_scalar_fpu_instr ? 2'b11 : f4_frd_dp ? 2'b10 : f4_frd_sp ? 2'b01 : 2'b00;
generate
    if (FLEN == 64) begin:gen_fpu_dp
        assign f1_op1_d_is_inf = (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51:0] == 52'b0);
        assign f1_op1_d_is_subnor = (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] != 52'b0);
        assign f1_op1_d_is_qnan = (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51]);
        assign f1_op1_d_is_snan = (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[50:0] != 51'b0) & ~f1_op1_data[51];
        assign f1_op2_d_is_inf = (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[51:0] == 52'b0);
        assign f1_op2_d_is_subnor = (f1_op2_data[62:52] == 11'b0) & (f1_op2_data[51:0] != 52'b0);
        assign f1_op2_d_is_qnan = (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[51]);
        assign f1_op2_d_is_snan = (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[50:0] != 51'b0) & ~f1_op2_data[51];
        assign ds_din0 = f1_ds_din0_dp;
        assign ds_din1 = f1_ds_din1_dp;
        assign f3_ds_exp_adj = f3_frd_hp ? (correct_qr ? ~f3_ds_result1[13] : ~f3_ds_result0[13]) : f3_frd_sp ? (correct_qr ? ~f3_ds_result1[26] : ~f3_ds_result0[26]) : (correct_qr ? ~f3_ds_result1[55] : ~f3_ds_result0[55]);
        assign f3_exp_p1_d_gt_ovf_bound = ~f4_dsu_exp_nx[12] & (f4_dsu_exp_nx[11:0] > 12'd1022);
        assign f3_exp_p1_d_gt_sub_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd1023);
        assign f3_exp_p1_d_gt_udf_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd1076);
        assign f3_exp_p0_d_gt_ovf_bound = ~f4_dsu_exp_nx[12] & (f4_dsu_exp_nx[11:0] > 12'd1023);
        assign f3_exp_p0_d_gt_sub_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd1022);
        assign f3_exp_p0_d_gt_udf_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd1075);
        assign f3_exp_p0_s_gt_ovf_bound = ~f4_dsu_exp_nx[12] & (f4_dsu_exp_nx[11:0] > 12'd127);
        assign f3_exp_p0_s_gt_sub_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd126);
        assign f3_exp_p0_s_gt_udf_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd150);
        assign f3_exp_p1_s_gt_ovf_bound = ~f4_dsu_exp_nx[12] & (f4_dsu_exp_nx[11:0] > 12'd126);
        assign f3_exp_p1_s_gt_sub_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd127);
        assign f3_exp_p1_s_gt_udf_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd151);
        assign f4_subnorm_uf_cond1 = f4_frd_hp & (f4_normal_result[117:107] == 11'h7ff) | f4_frd_sp & (f4_normal_result[130:107] == 24'hffffff) | f4_frd_dp & (f4_normal_result[159:107] == 53'h1fffffffffffff);
        assign f4_subnorm_uf_cond2 = f4_frd_hp & (f4_normal_result[117:107] == 11'h7fe) | f4_frd_sp & (f4_normal_result[130:107] == 24'hfffffe) | f4_frd_dp & (f4_normal_result[159:107] == 53'h1ffffffffffffe);
        assign f4_subnorm_to_normal = f4_frd_hp ? f4_fraction[118] : f4_frd_sp ? f4_fraction[131] : f4_fraction[160];
        assign f4_exp_inc = f4_frd_dp & f4_round_adder_result[161] | f4_frd_sp & f4_round_adder_result[132] | f4_frd_hp & f4_round_adder_result[119];
        assign f4_exp_bias = f4_subnorm ? ({11'b0,f4_frd_hp ? f4_fraction[118] : f4_frd_sp ? f4_fraction[131] : f4_fraction[160]}) : (f4_dsu_exp + (f4_frd_hp ? 12'd15 : f4_frd_sp ? 12'd127 : 12'd1023) + {11'b0,f4_exp_inc});
        assign f4_arith_wdata = f4_frd_hp ? {48'hffffffffffff,f4_arith_sign,f4_exp_bias[4:0],f4_fraction[117:108]} : f4_frd_sp ? {32'hffffffff,f4_arith_sign,f4_exp_bias[7:0],f4_fraction[130:108]} : {f4_arith_sign,f4_exp_bias[10:0],f4_fraction[159:108]};
    end
    else if (FLEN == 32) begin:gen_fpu_sp
        assign f1_op1_d_is_inf = 1'b0;
        assign f1_op1_d_is_subnor = 1'b0;
        assign f1_op1_d_is_qnan = 1'b0;
        assign f1_op1_d_is_snan = 1'b0;
        assign f1_op2_d_is_inf = 1'b0;
        assign f1_op2_d_is_subnor = 1'b0;
        assign f1_op2_d_is_qnan = 1'b0;
        assign f1_op2_d_is_snan = 1'b0;
        assign ds_din0 = f1_ds_din0_dp[53:29];
        assign ds_din1 = f1_ds_din1_dp[53:30];
        assign f3_ds_exp_adj = f3_frd_hp ? correct_qr ? ~f3_ds_result1[13] : ~f3_ds_result0[13] : correct_qr ? ~f3_ds_result1[26] : ~f3_ds_result0[26];
        assign f3_exp_p1_d_gt_ovf_bound = 1'b0;
        assign f3_exp_p1_d_gt_sub_bound = 1'b0;
        assign f3_exp_p1_d_gt_udf_bound = 1'b0;
        assign f3_exp_p0_d_gt_ovf_bound = 1'b0;
        assign f3_exp_p0_d_gt_sub_bound = 1'b0;
        assign f3_exp_p0_d_gt_udf_bound = 1'b0;
        assign f3_exp_p0_s_gt_ovf_bound = ~f4_dsu_exp_nx[12] & (f4_dsu_exp_nx[11:0] > 12'd127);
        assign f3_exp_p0_s_gt_sub_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd126);
        assign f3_exp_p0_s_gt_udf_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd150);
        assign f3_exp_p1_s_gt_ovf_bound = ~f4_dsu_exp_nx[12] & (f4_dsu_exp_nx[11:0] > 12'd126);
        assign f3_exp_p1_s_gt_sub_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd127);
        assign f3_exp_p1_s_gt_udf_bound = ~f4_dsu_exp_nx[12] | (~f4_dsu_exp_nx[11:0] < 12'd151);
        assign f4_subnorm_uf_cond1 = f4_frd_hp & (f4_normal_result[117:107] == 11'h7ff) | f4_frd_sp & (f4_normal_result[130:107] == 24'hffffff);
        assign f4_subnorm_uf_cond2 = f4_frd_hp & (f4_normal_result[117:107] == 11'h7fe) | f4_frd_sp & (f4_normal_result[130:107] == 24'hfffffe);
        assign f4_exp_inc = f4_frd_sp & f4_round_adder_result[132] | f4_frd_hp & f4_round_adder_result[119];
        assign f4_subnorm_to_normal = f4_frd_hp ? f4_fraction[118] : f4_fraction[131];
        assign f4_exp_bias = f4_subnorm ? {11'b0,(f4_frd_hp ? f4_fraction[118] : f4_fraction[131])} : (f4_dsu_exp + (f4_frd_hp ? 12'd15 : 12'd127) + {11'b0,f4_exp_inc});
        assign f4_arith_wdata = f4_frd_hp ? {48'hffffffffffff,f4_arith_sign,f4_exp_bias[4:0],f4_fraction[117:108]} : {32'hffffffff,f4_arith_sign,f4_exp_bias[7:0],f4_fraction[130:108]};
    end
    else begin:gen_fpu_hp
        assign f1_op1_d_is_inf = 1'b0;
        assign f1_op1_d_is_subnor = 1'b0;
        assign f1_op1_d_is_qnan = 1'b0;
        assign f1_op1_d_is_snan = 1'b0;
        assign f1_op2_d_is_inf = 1'b0;
        assign f1_op2_d_is_subnor = 1'b0;
        assign f1_op2_d_is_qnan = 1'b0;
        assign f1_op2_d_is_snan = 1'b0;
        assign ds_din0 = f1_ds_din0_dp[53:42];
        assign ds_din1 = f1_ds_din1_dp[53:43];
        assign f3_ds_exp_adj = correct_qr ? ~f3_ds_result1[13] : ~f3_ds_result0[13];
        assign f3_exp_p1_d_gt_ovf_bound = 1'b0;
        assign f3_exp_p1_d_gt_sub_bound = 1'b0;
        assign f3_exp_p1_d_gt_udf_bound = 1'b0;
        assign f3_exp_p0_d_gt_ovf_bound = 1'b0;
        assign f3_exp_p0_d_gt_sub_bound = 1'b0;
        assign f3_exp_p0_d_gt_udf_bound = 1'b0;
        assign f3_exp_p1_s_gt_ovf_bound = 1'b0;
        assign f3_exp_p1_s_gt_sub_bound = 1'b0;
        assign f3_exp_p1_s_gt_udf_bound = 1'b0;
        assign f3_exp_p0_s_gt_ovf_bound = 1'b0;
        assign f3_exp_p0_s_gt_sub_bound = 1'b0;
        assign f3_exp_p0_s_gt_udf_bound = 1'b0;
        assign f4_subnorm_uf_cond1 = (f4_normal_result[117:107] == 11'h7ff);
        assign f4_subnorm_uf_cond2 = (f4_normal_result[117:107] == 11'h7fe);
        assign f4_exp_inc = f4_round_adder_result[119];
        assign f4_subnorm_to_normal = f4_fraction[118];
        assign f4_exp_bias = f4_subnorm ? {11'b0,f4_fraction[118]} : (f4_dsu_exp + 12'd15 + {11'b0,f4_exp_inc});
        assign f4_arith_wdata = {48'hffffffffffff,f4_arith_sign,f4_exp_bias[4:0],f4_fraction[117:108]};
    end
endgenerate
generate
    if (FLEN == 16) begin:gen_fpu_hp_subnormal_input
        reg [5:0] h_op1_lead_one_num;
        reg [5:0] h_op2_lead_one_num;
        wire [3:0] op1_lz_num = {4{f1_op1_is_subnorm}} & h_op1_lead_one_num[3:0];
        wire [3:0] op2_lz_num = {4{f1_op2_is_subnorm}} & h_op2_lead_one_num[3:0];
        wire [9:0] h_op1_fraction_in = f1_op1_data[9:0];
        wire [9:0] h_op1_fraction_l0 = op1_lz_num[0] ? {h_op1_fraction_in[9 - 1:0],1'd0} : h_op1_fraction_in;
        wire [9:0] h_op1_fraction_l1 = op1_lz_num[1] ? {h_op1_fraction_l0[9 - 2:0],2'd0} : h_op1_fraction_l0;
        wire [9:0] h_op1_fraction_l2 = op1_lz_num[2] ? {h_op1_fraction_l1[9 - 4:0],4'd0} : h_op1_fraction_l1;
        wire [9:0] h_op1_fraction_l3 = op1_lz_num[3] ? {h_op1_fraction_l2[9 - 8:0],8'd0} : h_op1_fraction_l2;
        wire [5:0] exp_h_op1_with_bias = 6'd1 - h_op1_lead_one_num;
        wire [9:0] h_op2_fraction_in = f1_op2_data[9:0];
        wire [9:0] h_op2_fraction_l0 = op2_lz_num[0] ? {h_op2_fraction_in[9 - 1:0],1'd0} : h_op2_fraction_in;
        wire [9:0] h_op2_fraction_l1 = op2_lz_num[1] ? {h_op2_fraction_l0[9 - 2:0],2'd0} : h_op2_fraction_l0;
        wire [9:0] h_op2_fraction_l2 = op2_lz_num[2] ? {h_op2_fraction_l1[9 - 4:0],4'd0} : h_op2_fraction_l1;
        wire [9:0] h_op2_fraction_l3 = op2_lz_num[3] ? {h_op2_fraction_l2[9 - 8:0],8'd0} : h_op2_fraction_l2;
        wire [5:0] exp_h_op2_with_bias = 6'd1 - h_op2_lead_one_num;
        assign f1_op1_normal_fraction = {f1_op1_hidden_one,h_op1_fraction_l3};
        assign f1_op2_normal_fraction = {f1_op2_hidden_one,h_op2_fraction_l3};
        assign f1_op1_fraction = {f1_op1_normal_fraction[10:0],42'b0};
        assign f1_op2_fraction = {f1_op2_normal_fraction[10:0],42'b0};
        wire [5:0] f1_op1_exp = {1'b0,f1_op1_data[14:10]};
        wire [5:0] f1_op2_exp = {1'b0,f1_op2_data[14:10]};
        assign f1_op1_normal_exp = f1_op1_is_zero ? 12'b0 : f1_op1_is_subnorm ? {{6{exp_h_op1_with_bias[5]}},exp_h_op1_with_bias[5:0]} : {6'b0,f1_op1_exp};
        assign f1_op2_normal_exp = f1_op2_is_zero ? 12'b0 : f1_op2_is_subnorm ? {{6{exp_h_op2_with_bias[5]}},exp_h_op2_with_bias[5:0]} : {6'b0,f1_op2_exp};
        assign f2_op1_exp = {{(7){f2_op1_normal_exp[5]}},f2_op1_normal_exp[4:0]};
        assign f2_op2_exp = {{(7){f2_op2_normal_exp[5]}},f2_op2_normal_exp[4:0]};
        always @* begin
            casez (h_op1_fraction_in[9:0])
                {1'd1,{9{1'b?}}}: h_op1_lead_one_num = 6'd1;
                {2'd1,{8{1'b?}}}: h_op1_lead_one_num = 6'd2;
                {3'd1,{7{1'b?}}}: h_op1_lead_one_num = 6'd3;
                {4'd1,{6{1'b?}}}: h_op1_lead_one_num = 6'd4;
                {5'd1,{5{1'b?}}}: h_op1_lead_one_num = 6'd5;
                {6'd1,{4{1'b?}}}: h_op1_lead_one_num = 6'd6;
                {7'd1,{3{1'b?}}}: h_op1_lead_one_num = 6'd7;
                {8'd1,{2{1'b?}}}: h_op1_lead_one_num = 6'd8;
                {9'd1,{1{1'b?}}}: h_op1_lead_one_num = 6'd9;
                default: h_op1_lead_one_num = 6'd10;
            endcase
        end

        always @* begin
            casez (h_op2_fraction_in[9:0])
                {1'd1,{9{1'b?}}}: h_op2_lead_one_num = 6'd1;
                {2'd1,{8{1'b?}}}: h_op2_lead_one_num = 6'd2;
                {3'd1,{7{1'b?}}}: h_op2_lead_one_num = 6'd3;
                {4'd1,{6{1'b?}}}: h_op2_lead_one_num = 6'd4;
                {5'd1,{5{1'b?}}}: h_op2_lead_one_num = 6'd5;
                {6'd1,{4{1'b?}}}: h_op2_lead_one_num = 6'd6;
                {7'd1,{3{1'b?}}}: h_op2_lead_one_num = 6'd7;
                {8'd1,{2{1'b?}}}: h_op2_lead_one_num = 6'd8;
                {9'd1,{1{1'b?}}}: h_op2_lead_one_num = 6'd9;
                default: h_op2_lead_one_num = 6'd10;
            endcase
        end

    end
    else if (FLEN == 32) begin:gen_fpu_sp_subnormal_input
        wire [8:0] s_op1_lead_one_num;
        wire [8:0] s_op2_lead_one_num;
        wire [4:0] op1_lz_num = {5{f1_op1_is_subnorm}} & s_op1_lead_one_num[4:0];
        wire [4:0] op2_lz_num = {5{f1_op2_is_subnorm}} & s_op2_lead_one_num[4:0];
        wire [22:0] s_op1_fraction_in = {23{f1_frs_sp}} & f1_op1_data[22:0] | {23{f1_frs_hp}} & {f1_op1_data[9:0],13'b0};
        wire [22:0] s_op1_fraction_l0 = op1_lz_num[0] ? {s_op1_fraction_in[22 - 1:0],1'd0} : s_op1_fraction_in;
        wire [22:0] s_op1_fraction_l1 = op1_lz_num[1] ? {s_op1_fraction_l0[22 - 2:0],2'd0} : s_op1_fraction_l0;
        wire [22:0] s_op1_fraction_l2 = op1_lz_num[2] ? {s_op1_fraction_l1[22 - 4:0],4'd0} : s_op1_fraction_l1;
        wire [22:0] s_op1_fraction_l3 = op1_lz_num[3] ? {s_op1_fraction_l2[22 - 8:0],8'd0} : s_op1_fraction_l2;
        wire [22:0] s_op1_fraction_l4 = op1_lz_num[4] ? {s_op1_fraction_l3[22 - 16:0],16'd0} : s_op1_fraction_l3;
        wire [8:0] exp_s_op1_with_bias = 9'd1 - s_op1_lead_one_num;
        wire [22:0] s_op2_fraction_in = {23{f1_frs_sp}} & f1_op2_data[22:0] | {23{f1_frs_hp}} & {f1_op2_data[9:0],13'b0};
        wire [22:0] s_op2_fraction_l0 = op2_lz_num[0] ? {s_op2_fraction_in[22 - 1:0],1'd0} : s_op2_fraction_in;
        wire [22:0] s_op2_fraction_l1 = op2_lz_num[1] ? {s_op2_fraction_l0[22 - 2:0],2'd0} : s_op2_fraction_l0;
        wire [22:0] s_op2_fraction_l2 = op2_lz_num[2] ? {s_op2_fraction_l1[22 - 4:0],4'd0} : s_op2_fraction_l1;
        wire [22:0] s_op2_fraction_l3 = op2_lz_num[3] ? {s_op2_fraction_l2[22 - 8:0],8'd0} : s_op2_fraction_l2;
        wire [22:0] s_op2_fraction_l4 = op2_lz_num[4] ? {s_op2_fraction_l3[22 - 16:0],16'd0} : s_op2_fraction_l3;
        wire [8:0] exp_s_op2_with_bias = 9'd1 - s_op2_lead_one_num;
        assign f1_op1_normal_fraction = {f1_op1_hidden_one,s_op1_fraction_l4};
        assign f1_op2_normal_fraction = {f1_op2_hidden_one,s_op2_fraction_l4};
        assign f1_op1_fraction = {f1_op1_normal_fraction[23:0],29'b0};
        assign f1_op2_fraction = {f1_op2_normal_fraction[23:0],29'b0};
        wire [8:0] f1_op1_exp = f1_frs_sp ? {1'b0,f1_op1_data[30:23]} : {4'b0,f1_op1_data[14:10]};
        wire [8:0] f1_op2_exp = f1_frs_sp ? {1'b0,f1_op2_data[30:23]} : {4'b0,f1_op2_data[14:10]};
        assign f1_op1_normal_exp = f1_op1_is_zero ? 12'b0 : f1_op1_is_subnorm ? {{3{exp_s_op1_with_bias[8]}},exp_s_op1_with_bias[8:0]} : {3'b0,f1_op1_exp};
        assign f1_op2_normal_exp = f1_op2_is_zero ? 12'b0 : f1_op2_is_subnorm ? {{3{exp_s_op2_with_bias[8]}},exp_s_op2_with_bias[8:0]} : {3'b0,f1_op2_exp};
        assign f2_op1_exp = {{(4){f2_op1_normal_exp[8]}},f2_op1_normal_exp[7:0]};
        assign f2_op2_exp = {{(4){f2_op2_normal_exp[8]}},f2_op2_normal_exp[7:0]};
        wire [31:0] f1_op1_lz_count_32;
        wire [15:0] f1_op1_lz_count_16;
        wire [7:0] f1_op1_lz_count_8;
        wire [3:0] f1_op1_lz_count_4;
        wire [1:0] f1_op1_lz_count_2;
        wire [4:0] f1_op1_lz_num;
        assign f1_op1_lz_num[4] = ~|f1_op1_lz_count_32[31:16];
        assign f1_op1_lz_num[3] = ~|f1_op1_lz_count_16[15:8];
        assign f1_op1_lz_num[2] = ~|f1_op1_lz_count_8[7:4];
        assign f1_op1_lz_num[1] = ~|f1_op1_lz_count_4[3:2];
        assign f1_op1_lz_num[0] = ~f1_op1_lz_count_2[1];
        assign f1_op1_lz_count_32 = {1'b0,s_op1_fraction_in[22:0],8'b0};
        assign f1_op1_lz_count_16 = f1_op1_lz_num[4] ? f1_op1_lz_count_32[15:0] : f1_op1_lz_count_32[31:16];
        assign f1_op1_lz_count_8 = f1_op1_lz_num[3] ? f1_op1_lz_count_16[7:0] : f1_op1_lz_count_16[15:8];
        assign f1_op1_lz_count_4 = f1_op1_lz_num[2] ? f1_op1_lz_count_8[3:0] : f1_op1_lz_count_8[7:4];
        assign f1_op1_lz_count_2 = f1_op1_lz_num[1] ? f1_op1_lz_count_4[1:0] : f1_op1_lz_count_4[3:2];
        assign s_op1_lead_one_num = {4'b0,f1_op1_lz_num[4:0]};
        wire [31:0] f1_op2_lz_count_32;
        wire [15:0] f1_op2_lz_count_16;
        wire [7:0] f1_op2_lz_count_8;
        wire [3:0] f1_op2_lz_count_4;
        wire [1:0] f1_op2_lz_count_2;
        wire [4:0] f1_op2_lz_num;
        assign f1_op2_lz_num[4] = ~|f1_op2_lz_count_32[31:16];
        assign f1_op2_lz_num[3] = ~|f1_op2_lz_count_16[15:8];
        assign f1_op2_lz_num[2] = ~|f1_op2_lz_count_8[7:4];
        assign f1_op2_lz_num[1] = ~|f1_op2_lz_count_4[3:2];
        assign f1_op2_lz_num[0] = ~f1_op2_lz_count_2[1];
        assign f1_op2_lz_count_32 = {1'b0,s_op2_fraction_in[22:0],8'b0};
        assign f1_op2_lz_count_16 = f1_op2_lz_num[4] ? f1_op2_lz_count_32[15:0] : f1_op2_lz_count_32[31:16];
        assign f1_op2_lz_count_8 = f1_op2_lz_num[3] ? f1_op2_lz_count_16[7:0] : f1_op2_lz_count_16[15:8];
        assign f1_op2_lz_count_4 = f1_op2_lz_num[2] ? f1_op2_lz_count_8[3:0] : f1_op2_lz_count_8[7:4];
        assign f1_op2_lz_count_2 = f1_op2_lz_num[1] ? f1_op2_lz_count_4[1:0] : f1_op2_lz_count_4[3:2];
        assign s_op2_lead_one_num = {4'b0,f1_op2_lz_num[4:0]};
    end
    else begin:gen_fpu_dp_subnormal_input
        wire [11:0] d_op1_lead_one_num;
        wire [11:0] d_op2_lead_one_num;
        wire [5:0] op1_lz_num = {6{f1_op1_is_subnorm}} & d_op1_lead_one_num[5:0];
        wire [5:0] op2_lz_num = {6{f1_op2_is_subnorm}} & d_op2_lead_one_num[5:0];
        wire [51:0] d_op1_fraction_in = {52{f1_frs_dp}} & f1_op1_data[51:0] | {52{f1_frs_sp}} & {f1_op1_data[22:0],29'b0} | {52{f1_frs_hp}} & {f1_op1_data[9:0],42'b0};
        wire [51:0] d_op1_fraction_l0 = op1_lz_num[0] ? {d_op1_fraction_in[51 - 1:0],1'd0} : d_op1_fraction_in;
        wire [51:0] d_op1_fraction_l1 = op1_lz_num[1] ? {d_op1_fraction_l0[51 - 2:0],2'd0} : d_op1_fraction_l0;
        wire [51:0] d_op1_fraction_l2 = op1_lz_num[2] ? {d_op1_fraction_l1[51 - 4:0],4'd0} : d_op1_fraction_l1;
        wire [51:0] d_op1_fraction_l3 = op1_lz_num[3] ? {d_op1_fraction_l2[51 - 8:0],8'd0} : d_op1_fraction_l2;
        wire [51:0] d_op1_fraction_l4 = op1_lz_num[4] ? {d_op1_fraction_l3[51 - 16:0],16'd0} : d_op1_fraction_l3;
        wire [51:0] d_op1_fraction_l5 = op1_lz_num[5] ? {d_op1_fraction_l4[51 - 32:0],32'd0} : d_op1_fraction_l4;
        wire [11:0] exp_d_op1_with_bias = 12'd1 - d_op1_lead_one_num;
        wire [51:0] d_op2_fraction_in = {52{f1_frs_dp}} & f1_op2_data[51:0] | {52{f1_frs_sp}} & {f1_op2_data[22:0],29'b0} | {52{f1_frs_hp}} & {f1_op2_data[9:0],42'b0};
        wire [51:0] d_op2_fraction_l0 = op2_lz_num[0] ? {d_op2_fraction_in[51 - 1:0],1'd0} : d_op2_fraction_in;
        wire [51:0] d_op2_fraction_l1 = op2_lz_num[1] ? {d_op2_fraction_l0[51 - 2:0],2'd0} : d_op2_fraction_l0;
        wire [51:0] d_op2_fraction_l2 = op2_lz_num[2] ? {d_op2_fraction_l1[51 - 4:0],4'd0} : d_op2_fraction_l1;
        wire [51:0] d_op2_fraction_l3 = op2_lz_num[3] ? {d_op2_fraction_l2[51 - 8:0],8'd0} : d_op2_fraction_l2;
        wire [51:0] d_op2_fraction_l4 = op2_lz_num[4] ? {d_op2_fraction_l3[51 - 16:0],16'd0} : d_op2_fraction_l3;
        wire [51:0] d_op2_fraction_l5 = op2_lz_num[5] ? {d_op2_fraction_l4[51 - 32:0],32'd0} : d_op2_fraction_l4;
        wire [11:0] exp_d_op2_with_bias = 12'd1 - d_op2_lead_one_num;
        assign f1_op1_normal_fraction = {f1_op1_hidden_one,d_op1_fraction_l5};
        assign f1_op2_normal_fraction = {f1_op2_hidden_one,d_op2_fraction_l5};
        assign f1_op1_fraction = f1_op1_normal_fraction[52:0];
        assign f1_op2_fraction = f1_op2_normal_fraction[52:0];
        wire [11:0] f1_op1_exp = {12{f1_frs_dp}} & {1'b0,f1_op1_data[62:52]} | {12{f1_frs_sp}} & {4'b0,f1_op1_data[30:23]} | {12{f1_frs_hp}} & {7'b0,f1_op1_data[14:10]};
        wire [11:0] f1_op2_exp = {12{f1_frs_dp}} & {1'b0,f1_op2_data[62:52]} | {12{f1_frs_sp}} & {4'b0,f1_op2_data[30:23]} | {12{f1_frs_hp}} & {7'b0,f1_op2_data[14:10]};
        assign f1_op1_normal_exp = f1_op1_is_zero ? 12'b0 : f1_op1_is_subnorm ? exp_d_op1_with_bias[11:0] : f1_op1_exp;
        assign f1_op2_normal_exp = f1_op2_is_zero ? 12'b0 : f1_op2_is_subnorm ? exp_d_op2_with_bias[11:0] : f1_op2_exp;
        assign f2_op1_exp = f2_op1_normal_exp[11:0];
        assign f2_op2_exp = f2_op2_normal_exp[11:0];
        wire [63:0] f1_op1_lz_count_64;
        wire [31:0] f1_op1_lz_count_32;
        wire [15:0] f1_op1_lz_count_16;
        wire [7:0] f1_op1_lz_count_8;
        wire [3:0] f1_op1_lz_count_4;
        wire [1:0] f1_op1_lz_count_2;
        wire f1_op1_lz_num_5_mux;
        wire [1:0] f1_op1_lz_num_4_mux;
        wire [1:0] f1_op1_lz_num_3_mux;
        wire [1:0] f1_op1_lz_num_2_mux;
        wire [1:0] f1_op1_lz_num_1_mux;
        wire [5:0] f1_op1_lz_num;
        assign f1_op1_lz_count_64 = {1'b0,d_op1_fraction_in[51:0],11'b0};
        assign f1_op1_lz_num_5_mux = ~|f1_op1_lz_count_64[63:32];
        assign f1_op1_lz_num_4_mux[1] = ~|f1_op1_lz_count_64[31:16];
        assign f1_op1_lz_num_4_mux[0] = ~|f1_op1_lz_count_64[63:48];
        assign f1_op1_lz_num_3_mux[1] = f1_op1_lz_num[5] ? ~|f1_op1_lz_count_64[15:8] : ~|f1_op1_lz_count_64[47:40];
        assign f1_op1_lz_num_3_mux[0] = f1_op1_lz_num[5] ? ~|f1_op1_lz_count_64[31:24] : ~|f1_op1_lz_count_64[63:56];
        assign f1_op1_lz_num_2_mux[1] = ((f1_op1_lz_num[5:4] == 2'b11) & (~|f1_op1_lz_count_64[7:4])) | ((f1_op1_lz_num[5:4] == 2'b10) & (~|f1_op1_lz_count_64[23:20])) | ((f1_op1_lz_num[5:4] == 2'b01) & (~|f1_op1_lz_count_64[39:36])) | ((f1_op1_lz_num[5:4] == 2'b00) & (~|f1_op1_lz_count_64[55:52]));
        assign f1_op1_lz_num_2_mux[0] = ((f1_op1_lz_num[5:4] == 2'b11) & (~|f1_op1_lz_count_64[15:12])) | ((f1_op1_lz_num[5:4] == 2'b10) & (~|f1_op1_lz_count_64[31:28])) | ((f1_op1_lz_num[5:4] == 2'b01) & (~|f1_op1_lz_count_64[47:44])) | ((f1_op1_lz_num[5:4] == 2'b00) & (~|f1_op1_lz_count_64[63:60]));
        assign f1_op1_lz_num_1_mux[1] = ((f1_op1_lz_num[5:3] == 3'b111) & (~|f1_op1_lz_count_64[3:2])) | ((f1_op1_lz_num[5:3] == 3'b110) & (~|f1_op1_lz_count_64[11:10])) | ((f1_op1_lz_num[5:3] == 3'b101) & (~|f1_op1_lz_count_64[19:18])) | ((f1_op1_lz_num[5:3] == 3'b100) & (~|f1_op1_lz_count_64[27:26])) | ((f1_op1_lz_num[5:3] == 3'b011) & (~|f1_op1_lz_count_64[35:34])) | ((f1_op1_lz_num[5:3] == 3'b010) & (~|f1_op1_lz_count_64[43:42])) | ((f1_op1_lz_num[5:3] == 3'b001) & (~|f1_op1_lz_count_64[51:50])) | ((f1_op1_lz_num[5:3] == 3'b000) & (~|f1_op1_lz_count_64[59:58]));
        assign f1_op1_lz_num_1_mux[0] = ((f1_op1_lz_num[5:3] == 3'b111) & (~|f1_op1_lz_count_64[7:6])) | ((f1_op1_lz_num[5:3] == 3'b110) & (~|f1_op1_lz_count_64[15:14])) | ((f1_op1_lz_num[5:3] == 3'b101) & (~|f1_op1_lz_count_64[23:22])) | ((f1_op1_lz_num[5:3] == 3'b100) & (~|f1_op1_lz_count_64[31:30])) | ((f1_op1_lz_num[5:3] == 3'b011) & (~|f1_op1_lz_count_64[39:38])) | ((f1_op1_lz_num[5:3] == 3'b010) & (~|f1_op1_lz_count_64[47:46])) | ((f1_op1_lz_num[5:3] == 3'b001) & (~|f1_op1_lz_count_64[55:54])) | ((f1_op1_lz_num[5:3] == 3'b000) & (~|f1_op1_lz_count_64[63:62]));
        assign f1_op1_lz_num[5] = f1_op1_lz_num_5_mux;
        assign f1_op1_lz_num[4] = f1_op1_lz_num[5] ? f1_op1_lz_num_4_mux[1] : f1_op1_lz_num_4_mux[0];
        assign f1_op1_lz_num[3] = f1_op1_lz_num[4] ? f1_op1_lz_num_3_mux[1] : f1_op1_lz_num_3_mux[0];
        assign f1_op1_lz_num[2] = f1_op1_lz_num[3] ? f1_op1_lz_num_2_mux[1] : f1_op1_lz_num_2_mux[0];
        assign f1_op1_lz_num[1] = f1_op1_lz_num[2] ? f1_op1_lz_num_1_mux[1] : f1_op1_lz_num_1_mux[0];
        assign f1_op1_lz_num[0] = ~f1_op1_lz_count_2[1];
        assign f1_op1_lz_count_32 = f1_op1_lz_num[5] ? f1_op1_lz_count_64[31:0] : f1_op1_lz_count_64[63:32];
        assign f1_op1_lz_count_16 = f1_op1_lz_num[4] ? f1_op1_lz_count_32[15:0] : f1_op1_lz_count_32[31:16];
        assign f1_op1_lz_count_8 = f1_op1_lz_num[3] ? f1_op1_lz_count_16[7:0] : f1_op1_lz_count_16[15:8];
        assign f1_op1_lz_count_4 = f1_op1_lz_num[2] ? f1_op1_lz_count_8[3:0] : f1_op1_lz_count_8[7:4];
        assign f1_op1_lz_count_2 = f1_op1_lz_num[1] ? f1_op1_lz_count_4[1:0] : f1_op1_lz_count_4[3:2];
        assign d_op1_lead_one_num = {6'b0,f1_op1_lz_num[5:0]};
        wire [63:0] f1_op2_lz_count_64;
        wire [31:0] f1_op2_lz_count_32;
        wire [15:0] f1_op2_lz_count_16;
        wire [7:0] f1_op2_lz_count_8;
        wire [3:0] f1_op2_lz_count_4;
        wire [1:0] f1_op2_lz_count_2;
        wire f1_op2_lz_num_5_mux;
        wire [1:0] f1_op2_lz_num_4_mux;
        wire [1:0] f1_op2_lz_num_3_mux;
        wire [1:0] f1_op2_lz_num_2_mux;
        wire [1:0] f1_op2_lz_num_1_mux;
        wire [5:0] f1_op2_lz_num;
        assign f1_op2_lz_count_64 = {1'b0,d_op2_fraction_in[51:0],11'b0};
        assign f1_op2_lz_num_5_mux = ~|f1_op2_lz_count_64[63:32];
        assign f1_op2_lz_num_4_mux[1] = ~|f1_op2_lz_count_64[31:16];
        assign f1_op2_lz_num_4_mux[0] = ~|f1_op2_lz_count_64[63:48];
        assign f1_op2_lz_num_3_mux[1] = f1_op2_lz_num[5] ? ~|f1_op2_lz_count_64[15:8] : ~|f1_op2_lz_count_64[47:40];
        assign f1_op2_lz_num_3_mux[0] = f1_op2_lz_num[5] ? ~|f1_op2_lz_count_64[31:24] : ~|f1_op2_lz_count_64[63:56];
        assign f1_op2_lz_num_2_mux[1] = ((f1_op2_lz_num[5:4] == 2'b11) & (~|f1_op2_lz_count_64[7:4])) | ((f1_op2_lz_num[5:4] == 2'b10) & (~|f1_op2_lz_count_64[23:20])) | ((f1_op2_lz_num[5:4] == 2'b01) & (~|f1_op2_lz_count_64[39:36])) | ((f1_op2_lz_num[5:4] == 2'b00) & (~|f1_op2_lz_count_64[55:52]));
        assign f1_op2_lz_num_2_mux[0] = ((f1_op2_lz_num[5:4] == 2'b11) & (~|f1_op2_lz_count_64[15:12])) | ((f1_op2_lz_num[5:4] == 2'b10) & (~|f1_op2_lz_count_64[31:28])) | ((f1_op2_lz_num[5:4] == 2'b01) & (~|f1_op2_lz_count_64[47:44])) | ((f1_op2_lz_num[5:4] == 2'b00) & (~|f1_op2_lz_count_64[63:60]));
        assign f1_op2_lz_num_1_mux[1] = ((f1_op2_lz_num[5:3] == 3'b111) & (~|f1_op2_lz_count_64[3:2])) | ((f1_op2_lz_num[5:3] == 3'b110) & (~|f1_op2_lz_count_64[11:10])) | ((f1_op2_lz_num[5:3] == 3'b101) & (~|f1_op2_lz_count_64[19:18])) | ((f1_op2_lz_num[5:3] == 3'b100) & (~|f1_op2_lz_count_64[27:26])) | ((f1_op2_lz_num[5:3] == 3'b011) & (~|f1_op2_lz_count_64[35:34])) | ((f1_op2_lz_num[5:3] == 3'b010) & (~|f1_op2_lz_count_64[43:42])) | ((f1_op2_lz_num[5:3] == 3'b001) & (~|f1_op2_lz_count_64[51:50])) | ((f1_op2_lz_num[5:3] == 3'b000) & (~|f1_op2_lz_count_64[59:58]));
        assign f1_op2_lz_num_1_mux[0] = ((f1_op2_lz_num[5:3] == 3'b111) & (~|f1_op2_lz_count_64[7:6])) | ((f1_op2_lz_num[5:3] == 3'b110) & (~|f1_op2_lz_count_64[15:14])) | ((f1_op2_lz_num[5:3] == 3'b101) & (~|f1_op2_lz_count_64[23:22])) | ((f1_op2_lz_num[5:3] == 3'b100) & (~|f1_op2_lz_count_64[31:30])) | ((f1_op2_lz_num[5:3] == 3'b011) & (~|f1_op2_lz_count_64[39:38])) | ((f1_op2_lz_num[5:3] == 3'b010) & (~|f1_op2_lz_count_64[47:46])) | ((f1_op2_lz_num[5:3] == 3'b001) & (~|f1_op2_lz_count_64[55:54])) | ((f1_op2_lz_num[5:3] == 3'b000) & (~|f1_op2_lz_count_64[63:62]));
        assign f1_op2_lz_num[5] = f1_op2_lz_num_5_mux;
        assign f1_op2_lz_num[4] = f1_op2_lz_num[5] ? f1_op2_lz_num_4_mux[1] : f1_op2_lz_num_4_mux[0];
        assign f1_op2_lz_num[3] = f1_op2_lz_num[4] ? f1_op2_lz_num_3_mux[1] : f1_op2_lz_num_3_mux[0];
        assign f1_op2_lz_num[2] = f1_op2_lz_num[3] ? f1_op2_lz_num_2_mux[1] : f1_op2_lz_num_2_mux[0];
        assign f1_op2_lz_num[1] = f1_op2_lz_num[2] ? f1_op2_lz_num_1_mux[1] : f1_op2_lz_num_1_mux[0];
        assign f1_op2_lz_num[0] = ~f1_op2_lz_count_2[1];
        assign f1_op2_lz_count_32 = f1_op2_lz_num[5] ? f1_op2_lz_count_64[31:0] : f1_op2_lz_count_64[63:32];
        assign f1_op2_lz_count_16 = f1_op2_lz_num[4] ? f1_op2_lz_count_32[15:0] : f1_op2_lz_count_32[31:16];
        assign f1_op2_lz_count_8 = f1_op2_lz_num[3] ? f1_op2_lz_count_16[7:0] : f1_op2_lz_count_16[15:8];
        assign f1_op2_lz_count_4 = f1_op2_lz_num[2] ? f1_op2_lz_count_8[3:0] : f1_op2_lz_count_8[7:4];
        assign f1_op2_lz_count_2 = f1_op2_lz_num[1] ? f1_op2_lz_count_4[1:0] : f1_op2_lz_count_4[3:2];
        assign d_op2_lead_one_num = {6'b0,f1_op2_lz_num[5:0]};
    end
endgenerate
assign f1_vfrece7_instr = 1'b0;
assign f1_vfrsqrte7_instr = 1'b0;
assign f1_estimate7_exp = 12'b0;
assign f1_op1_subnorm_overflow = 1'b0;
assign f2_estimate7_wdata = 64'h0;
assign f2_estimate7_flag = 5'h0;
assign f2_estimate7_result_type = 2'b0;
endmodule

