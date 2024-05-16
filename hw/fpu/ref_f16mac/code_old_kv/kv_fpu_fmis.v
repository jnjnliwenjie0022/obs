// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fpu_fmis (
    fmis_standby_ready,
    f2_cmp_result,
    f2_narr_wdata,
    f2_wdata,
    f2_wdata_en,
    f2_flag_set,
    f2_result_type,
    f1_op1_data,
    f1_op2_data,
    f1_valid,
    f1_round_mode,
    f1_sew,
    f1_ediv,
    f1_ex_ctrl,
    f1_vmask,
    f1_sign,
    f1_fmis_scalar_valid,
    f1_op1_invalid,
    f1_op2_invalid,
    f1_widen,
    f1_narrow,
    f1_fcvtwh_instr,
    f1_fcvtws_instr,
    f1_fcvtwd_instr,
    f1_fcvtlh_instr,
    f1_fcvtls_instr,
    f1_fcvtld_instr,
    f1_fcvthw_instr,
    f1_fcvthl_instr,
    f1_fcvtsw_instr,
    f1_fcvtsl_instr,
    f1_fcvtdw_instr,
    f1_fcvtdl_instr,
    f1_fcvths_instr,
    f1_fcvthd_instr,
    f1_fcvtsh_instr,
    f1_fcvtsd_instr,
    f1_fcvtdh_instr,
    f1_fcvtds_instr,
    f1_fcvtbs_instr,
    f1_fcvtsb_instr,
    f1_fmin_instr,
    f1_fmax_instr,
    f1_feq_instr,
    f1_fle_instr,
    f1_flt_instr,
    f1_fclass_instr,
    f2_stall,
    core_clk,
    lane_pipe_id_0,
    core_reset_n
);
parameter FLEN = 32;
parameter XLEN = 64;
localparam ROUND_ZERO = 2'b00;
localparam ROUND_NEG = 2'b01;
localparam ROUND_POS = 2'b10;
localparam ROUND_NEAREST = 2'b11;
localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;
localparam ROUND_ROD = 3'b101;
localparam HP = 3'b001;
localparam SP = 3'b010;
localparam DP = 3'b011;
localparam SEW_8_BIT = 2'b00;
localparam SEW_16_BIT = 2'b01;
localparam SEW_32_BIT = 2'b10;
localparam SEW_64_BIT = 2'b11;
localparam TYPE_8_BIT = 2'b00;
localparam TYPE_16_BIT = 2'b01;
localparam TYPE_32_BIT = 2'b10;
localparam TYPE_64_BIT = 2'b11;
localparam CVT_BS_MSB = (FLEN == 16) ? 26 : 63;
localparam CVT_BS_RND = 10;
localparam CVT_BS_LSB = (FLEN == 16) ? 10 : 0;
localparam CVT_ABS_MSB = 63;
localparam CVT_ABS_LSB = 0;
localparam CVT_ABS_RND = 10;
localparam CVT_NBS_MSB = (FLEN == 16) ? 63 : (FLEN == 32) ? 76 : 105;
localparam CVT_NBS_LSB = (FLEN == 16) ? 48 : 0;
localparam CVT_NBS_RND = 52;
localparam LZD_MSB = (FLEN == 16) ? 15 : 63;
localparam FRD_TYPE_DP = 3'b111;
localparam FRD_TYPE_SP = 3'b110;
localparam FRD_TYPE_HP = 3'b101;
localparam FRD_TYPE_BP = 3'b100;
localparam FRD_TYPE_LONG = 3'b011;
localparam FRD_TYPE_WORD = 3'b010;
localparam FRD_TYPE_HALF = 3'b001;
localparam FRD_TYPE_BYTE = 3'b000;
localparam ITYPE_F2F = 2'b00;
localparam ITYPE_I2F = 2'b01;
localparam ITYPE_F2I = 2'b10;
localparam ITYPE_NCVT = 2'b11;
output fmis_standby_ready;
output f2_cmp_result;
output [63:0] f2_narr_wdata;
output [63:0] f2_wdata;
output f2_wdata_en;
output [4:0] f2_flag_set;
output [1:0] f2_result_type;
input [63:0] f1_op1_data;
input [63:0] f1_op2_data;
input f1_valid;
input [2:0] f1_round_mode;
input [2:0] f1_sew;
input [1:0] f1_ediv;
input [5:0] f1_ex_ctrl;
input f1_vmask;
input f1_sign;
input f1_fmis_scalar_valid;
input f1_op1_invalid;
input f1_op2_invalid;
input f1_widen;
input f1_narrow;
input core_clk;
input lane_pipe_id_0;
input core_reset_n;
input f2_stall;
input f1_fcvtwh_instr;
input f1_fcvtws_instr;
input f1_fcvtwd_instr;
input f1_fcvtlh_instr;
input f1_fcvtls_instr;
input f1_fcvtld_instr;
input f1_fcvthw_instr;
input f1_fcvthl_instr;
input f1_fcvtsw_instr;
input f1_fcvtsl_instr;
input f1_fcvtdw_instr;
input f1_fcvtdl_instr;
input f1_fcvths_instr;
input f1_fcvthd_instr;
input f1_fcvtsh_instr;
input f1_fcvtsd_instr;
input f1_fcvtdh_instr;
input f1_fcvtds_instr;
input f1_fcvtbs_instr;
input f1_fcvtsb_instr;
input f1_fmin_instr;
input f1_fmax_instr;
input f1_feq_instr;
input f1_fle_instr;
input f1_flt_instr;
input f1_fclass_instr;


wire pipe0;
wire f1_op1_h_nanboxing;
wire f1_op2_h_nanboxing;
wire f1_op1_s_nanboxing;
wire f1_op2_s_nanboxing;
wire f1_vfcvtx_instr;
wire f1_vfcvtf_instr;
wire f1_vfwcvtx_instr;
wire f1_vfwcvtf_instr;
wire f1_vfwcvtff_instr;
wire f1_vfncvtx_instr;
wire f1_vfncvtf_instr;
wire f1_vfncvtff_instr;
wire f1_vfncvtffrod_instr;
wire f1_vfncvtxfrtz_instr;
wire f1_vfwcvtxfrtz_instr;
wire f1_vfcvtxfrtz_instr;
wire f1_vfncvtbs_instr;
wire f1_vfwcvtsb_instr;
wire f1_vfmv_instr;
wire f1_vfmin_instr;
wire f1_vfmax_instr;
wire f1_vfmerge_instr;
wire f1_vfsgnj_instr;
wire f1_vfsgnjn_instr;
wire f1_vfsgnjx_instr;
wire f1_vfeq_instr;
wire f1_vfne_instr;
wire f1_vfle_instr;
wire f1_vflt_instr;
wire f1_vfge_instr;
wire f1_vfgt_instr;
wire f1_vfclass_instr;
wire f1_vfredmin_instr;
wire f1_vfredmax_instr;
wire f1_fp2int_signed;
wire f1_abs_sticky;
wire f1_abs_sticky_l0;
wire f1_abs_sticky_l1;
wire f1_abs_sticky_l2;
wire f1_abs_sticky_l3;
wire f1_abs_sticky_l4;
wire f1_abs_sticky_l5;
wire f1_frd_is_zero;
wire f1_frd_is_inf;
wire f1_frd_is_qnan;
wire f1_nv_exception;
wire f1_nbs_sticky;
wire [2:0] f1_round_mode;
wire [5:0] f1_lz_num;
wire [63:0] f1_op1_int_pos;
wire [LZD_MSB:0] f1_op1_int2fp_nbs;
wire [12:0] f1_abs_amount;
wire f1_abs_amount_hi_part;
wire f1_op1_sign_dp;
wire f1_op1_sign_sp;
wire f1_op1_sign_hp;
wire [10:0] f1_op1_exp_dp;
wire [7:0] f1_op1_exp_sp;
wire [4:0] f1_op1_exp_hp;
wire [51:0] f1_op1_fraction_dp;
wire [22:0] f1_op1_fraction_sp;
wire [9:0] f1_op1_fraction_hp;
wire [12:0] f1_exp_op1_no_bias;
wire [12:0] f1_exp_no_bias_add_src1;
wire [12:0] f1_exp_no_bias_add_src2;
wire [12:0] f1_fp2int_diff;
wire [12:0] f1_fp2fp_abs_amount;
wire [12:0] f1_fp2hp_abs_amount;
wire [12:0] f1_dp2sp_abs_amount;
wire f1_op1_is_fp_zero;
wire f1_fp2int_round_need;
wire f1_dp2sp_subnorm;
wire f1_dp2hp_subnorm;
wire f1_sp2hp_subnorm;
wire [63:0] f1_op1_data;
wire [63:0] f1_op2_data;
wire [63:0] f1_rd_result;
wire [63:0] f1_bf2s_result;
wire [63:0] f1_sign_inject_result;
wire [63:0] f1_compare_result;
wire [63:0] f1_classify_result;
wire [CVT_NBS_MSB:CVT_NBS_LSB] f1_nbs_lsh;
wire [CVT_NBS_MSB:CVT_NBS_LSB] f1_nbs_l0;
wire [CVT_NBS_MSB:CVT_NBS_LSB] f1_nbs_l1;
wire [CVT_NBS_MSB:CVT_NBS_LSB] f1_nbs_l2;
wire [CVT_NBS_MSB:CVT_NBS_LSB] f1_nbs_l3;
wire [CVT_NBS_MSB:CVT_NBS_LSB] f1_nbs_l4;
wire [CVT_NBS_MSB:CVT_NBS_LSB] f1_nbs_l5;
wire [CVT_ABS_MSB:CVT_ABS_LSB] f1_abs_in;
wire [CVT_ABS_MSB:CVT_ABS_LSB] f1_abs_l0;
wire [CVT_ABS_MSB:CVT_ABS_LSB] f1_abs_l1;
wire [CVT_ABS_MSB:CVT_ABS_LSB] f1_abs_l2;
wire [CVT_ABS_MSB:CVT_ABS_LSB] f1_abs_l3;
wire [CVT_ABS_MSB:CVT_ABS_LSB] f1_abs_l4;
wire [CVT_ABS_MSB:CVT_ABS_LSB] f1_abs_l5;
wire [CVT_ABS_MSB:CVT_ABS_LSB] f1_abs_final_out;
wire [CVT_NBS_MSB:CVT_NBS_RND] f2_nbs_result_nx;
wire [CVT_ABS_MSB:CVT_ABS_LSB] f2_abs_result_nx;
wire [CVT_BS_MSB:CVT_BS_LSB] f2_bs_result_nx;
wire [CVT_BS_MSB:CVT_BS_RND] f2_round_adder_src1;
wire [2:0] f2_round_mode_nx;
wire f1_cmp_instr_inv_op;
wire f2_sticky_nx;
wire f2_abs_sticky_nx;
wire f2_nbs_sticky_nx;
wire f2_vmask_nx;
wire f2_rn_nx;
wire f2_ri_nx;
wire f2_fp2int_conv_except;
wire f2_fp2int_conv_except_narr;
wire f2_pipe_en;
wire f2_tie;
wire f2_tie_clr_lsb;
wire f2_rod_set_lsb;
wire f2_rod;
wire f2_round_bit;
wire f2_fraction_lsb;
wire f2_fp_subnorm;
wire f2_subnorm_set_uf;
wire f2_exp_inc;
wire f2_cmp_result;
wire [1:0] f2_round_digit_nx;
wire [54:1] f2_fraction;
wire [54:0] f2_round_adder_result;
wire [12:0] f2_exp_nx;
wire [5:0] f2_exp_op2_nx;
wire [12:0] f2_exp_adjust_p0;
wire [12:0] f2_exp_adjust_p1;
wire [12:0] f2_exp_adjust;
wire [63:0] f2_fp2int_arith_result;
wire [63:0] f2_fp2int_arith_result_narr;
wire [63:0] f2_noncvt_result;
wire [63:0] f2_fp2int_result;
wire [63:0] f2_fp2int_result_narr;
wire [63:0] f2_arith_result;
wire [63:0] f2_int2fp_result;
wire [63:0] f2_fp2int_special_value;
wire [63:0] f2_fp2int_special_value_narr;
wire [63:0] f2_int2fp_special_value;
wire [63:0] f2_fp2l_result;
wire [63:0] f2_fp2int_unround;
wire [31:0] f2_fp2w_result;
wire [15:0] f2_fp2hw_result_narr;
wire [4:0] f2_fp2fp_fcsr_wdata;
wire [4:0] f2_int2fp_fcsr_wdata;
wire [4:0] f2_fp2int_fcsr_wdata;
wire [4:0] f2_non_conv_fcsr_wdata;
wire [1:0] f2_instr_type_nx;
wire [2:0] f2_frd_type_nx;
wire f2_arith_sign_nx;
wire f2_s2bf_is_subnorm_nx;
wire f1_sp2long_no_round_need;
wire f1_fp2int_neg;
reg f2_sp2long_no_round_need;
reg f2_rn;
reg f2_ri;
reg [1:0] f2_rounding_nx;
reg [1:0] f2_round_digit;
reg f2_dp2sp_subnorm;
reg f2_dp2hp_subnorm;
reg f2_sp2hp_subnorm;
reg f2_s2bf_is_subnorm;
reg f2_frd_is_inf;
reg f2_frd_is_zero;
reg f2_frd_is_qnan;
reg f2_valid;
reg f2_sticky;
wire [12:0] f2_exp_added;
reg [12:0] f2_exp;
reg [5:0] f2_exp_op2;
reg [CVT_BS_MSB:CVT_BS_LSB] f2_bs_result;
reg [2:0] f2_round_mode;
reg [1:0] f2_instr_type;
reg f2_arith_sign;
reg f2_sign;
reg [2:0] f2_frd_type;
reg f2_fp2int_round_need;
reg f2_nv_exception;
reg f2_fp2int_neg;
assign fmis_standby_ready = ~f1_valid & ~f2_valid;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f2_valid <= 1'b0;
    end
    else if (~f2_stall) begin
        f2_valid <= f1_valid;
    end
end

always @(posedge core_clk) begin
    if (f2_pipe_en) begin
        f2_exp <= f2_exp_nx;
        f2_exp_op2 <= f2_exp_op2_nx;
        f2_round_digit <= f2_round_digit_nx;
        f2_sticky <= f2_sticky_nx;
        f2_bs_result <= f2_bs_result_nx;
        f2_round_mode <= f2_round_mode_nx;
        f2_rn <= f2_rn_nx;
        f2_ri <= f2_ri_nx;
        f2_sign <= f1_sign;
        f2_arith_sign <= f2_arith_sign_nx;
        f2_fp2int_round_need <= f1_fp2int_round_need;
        f2_sp2long_no_round_need <= f1_sp2long_no_round_need;
        f2_fp2int_neg <= f1_fp2int_neg;
    end
end

assign f2_pipe_en = f1_valid & ~f2_stall;
assign f2_wdata_en = f2_valid;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f2_frd_is_inf <= 1'b0;
        f2_frd_is_zero <= 1'b0;
        f2_frd_is_qnan <= 1'b0;
        f2_nv_exception <= 1'b0;
        f2_frd_type <= 3'b0;
        f2_instr_type <= 2'b0;
        f2_s2bf_is_subnorm <= 1'b0;
        f2_dp2hp_subnorm <= 1'b0;
        f2_sp2hp_subnorm <= 1'b0;
        f2_dp2sp_subnorm <= 1'b0;
    end
    else if (f2_pipe_en) begin
        f2_frd_is_inf <= f1_frd_is_inf;
        f2_frd_is_zero <= f1_frd_is_zero;
        f2_frd_is_qnan <= f1_frd_is_qnan;
        f2_nv_exception <= f1_nv_exception;
        f2_frd_type <= f2_frd_type_nx;
        f2_instr_type <= f2_instr_type_nx;
        f2_s2bf_is_subnorm <= f2_s2bf_is_subnorm_nx;
        f2_dp2hp_subnorm <= f1_dp2hp_subnorm;
        f2_sp2hp_subnorm <= f1_sp2hp_subnorm;
        f2_dp2sp_subnorm <= f1_dp2sp_subnorm;
    end
end

wire fp_dp_support = (FLEN == 64);
wire fp_sp_support = (FLEN == 32) | fp_dp_support;
wire f1_sew_64_bit = f1_sew[2];
wire f1_sew_32_bit = f1_sew[1];
wire f1_sew_16_bit = f1_sew[0];
wire f1_sew_8_bit = 1'b0;
wire f1_fmis_valid = f1_fmis_scalar_valid;
wire f1_fsgnj_instr = 1'b0;
wire f1_fsgnjn_instr = 1'b0;
wire f1_fsgnjx_instr = 1'b0;
wire f1_fmvf_instr = 1'b0;
wire f1_fmvx_instr = 1'b0;
assign f1_vfcvtx_instr = 1'b0;
assign f1_vfcvtf_instr = 1'b0;
assign f1_vfwcvtx_instr = 1'b0;
assign f1_vfwcvtf_instr = 1'b0;
assign f1_vfwcvtff_instr = 1'b0;
assign f1_vfncvtx_instr = 1'b0;
assign f1_vfncvtf_instr = 1'b0;
assign f1_vfncvtff_instr = 1'b0;
assign f1_vfncvtffrod_instr = 1'b0;
assign f1_vfncvtxfrtz_instr = 1'b0;
assign f1_vfwcvtxfrtz_instr = 1'b0;
assign f1_vfcvtxfrtz_instr = 1'b0;
assign f1_vfncvtbs_instr = 1'b0;
assign f1_vfwcvtsb_instr = 1'b0;
assign f1_vfmv_instr = 1'b0;
assign f1_vfmin_instr = 1'b0;
assign f1_vfmax_instr = 1'b0;
assign f1_vfmerge_instr = 1'b0;
assign f1_vfsgnj_instr = 1'b0;
assign f1_vfsgnjn_instr = 1'b0;
assign f1_vfsgnjx_instr = 1'b0;
assign f1_vfeq_instr = 1'b0;
assign f1_vfne_instr = 1'b0;
assign f1_vfle_instr = 1'b0;
assign f1_vflt_instr = 1'b0;
assign f1_vfge_instr = 1'b0;
assign f1_vfgt_instr = 1'b0;
assign f1_vfclass_instr = 1'b0;
assign f1_vfredmin_instr = 1'b0;
assign f1_vfredmax_instr = 1'b0;
wire f1_same_width = ~(f1_widen | f1_narrow);
wire f1_scalar_fp2int_instr = (f1_fcvtwh_instr | f1_fcvtws_instr | f1_fcvtwd_instr | f1_fcvtlh_instr | f1_fcvtls_instr | f1_fcvtld_instr) & fp_sp_support;
wire f1_scalar_int2fp_instr = (f1_fcvthw_instr | f1_fcvthl_instr | f1_fcvtsw_instr | f1_fcvtsl_instr | f1_fcvtdw_instr | f1_fcvtdl_instr) & fp_sp_support;
wire f1_scalar_fp2fp_instr = (f1_fcvths_instr | f1_fcvthd_instr | f1_fcvtsh_instr | f1_fcvtsd_instr | f1_fcvtdh_instr | f1_fcvtds_instr | f1_fcvtbs_instr | f1_fcvtsb_instr) & fp_sp_support;
wire f1_scalar_fp_widen_instr = (f1_fcvtsh_instr | f1_fcvtdh_instr | f1_fcvtds_instr) & fp_sp_support;
wire f1_bf2s_instr = (f1_vfwcvtsb_instr | f1_fcvtsb_instr) & fp_sp_support;
wire f1_s2bf_instr = (f1_vfncvtbs_instr | f1_fcvtbs_instr) & fp_sp_support;
wire f1_fp2int_instr = f1_vfcvtx_instr | f1_vfwcvtx_instr | f1_vfncvtx_instr | f1_scalar_fp2int_instr | f1_vfncvtxfrtz_instr | f1_vfwcvtxfrtz_instr | f1_vfcvtxfrtz_instr;
wire f1_int2fp_instr = f1_vfcvtf_instr | f1_vfwcvtf_instr | f1_vfncvtf_instr | f1_scalar_int2fp_instr;
wire f1_fp2fp_instr = (f1_vfwcvtff_instr | f1_vfncvtff_instr | f1_scalar_fp2fp_instr | f1_vfncvtffrod_instr | f1_bf2s_instr | f1_s2bf_instr) & fp_sp_support;
wire f1_mv_instr = f1_vfmv_instr | f1_fmvf_instr | f1_fmvx_instr;
wire f1_minh_instr = (f1_vfmin_instr | f1_vfredmin_instr | f1_fmin_instr) & f1_sew_16_bit;
wire f1_maxh_instr = (f1_vfmax_instr | f1_vfredmax_instr | f1_fmax_instr) & f1_sew_16_bit;
wire f1_sgnjh_instr = (f1_vfsgnj_instr | f1_fsgnj_instr) & f1_sew_16_bit;
wire f1_sgnjnh_instr = (f1_vfsgnjn_instr | f1_fsgnjn_instr) & f1_sew_16_bit;
wire f1_sgnjxh_instr = (f1_vfsgnjx_instr | f1_fsgnjx_instr) & f1_sew_16_bit;
wire f1_eqh_instr = (f1_vfeq_instr | f1_feq_instr) & f1_sew_16_bit;
wire f1_lth_instr = (f1_vflt_instr | f1_flt_instr) & f1_sew_16_bit;
wire f1_leh_instr = (f1_vfle_instr | f1_fle_instr) & f1_sew_16_bit;
wire f1_classh_instr = (f1_vfclass_instr | f1_fclass_instr) & f1_sew_16_bit;
wire f1_neh_instr = (f1_vfne_instr) & f1_sew_16_bit;
wire f1_geh_instr = (f1_vfge_instr) & f1_sew_16_bit;
wire f1_gth_instr = (f1_vfgt_instr) & f1_sew_16_bit;
wire f1_mergeh_instr = (f1_vfmerge_instr) & f1_sew_16_bit;
wire f1_min_instr = (f1_vfmin_instr | f1_vfredmin_instr | f1_fmin_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_max_instr = (f1_vfmax_instr | f1_vfredmax_instr | f1_fmax_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_sgnj_instr = (f1_vfsgnj_instr | f1_fsgnj_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_sgnjn_instr = (f1_vfsgnjn_instr | f1_fsgnjn_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_sgnjx_instr = (f1_vfsgnjx_instr | f1_fsgnjx_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_eq_instr = (f1_vfeq_instr | f1_feq_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_lt_instr = (f1_vflt_instr | f1_flt_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_le_instr = (f1_vfle_instr | f1_fle_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_class_instr = (f1_vfclass_instr | f1_fclass_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_ne_instr = (f1_vfne_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_ge_instr = (f1_vfge_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_gt_instr = (f1_vfgt_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_merge_instr = (f1_vfmerge_instr) & f1_sew_32_bit & fp_sp_support;
wire f1_mind_instr = (f1_vfmin_instr | f1_vfredmin_instr | f1_fmin_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_maxd_instr = (f1_vfmax_instr | f1_vfredmax_instr | f1_fmax_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_sgnjd_instr = (f1_vfsgnj_instr | f1_fsgnj_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_sgnjnd_instr = (f1_vfsgnjn_instr | f1_fsgnjn_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_sgnjxd_instr = (f1_vfsgnjx_instr | f1_fsgnjx_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_eqd_instr = (f1_vfeq_instr | f1_feq_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_ltd_instr = (f1_vflt_instr | f1_flt_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_led_instr = (f1_vfle_instr | f1_fle_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_classd_instr = (f1_vfclass_instr | f1_fclass_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_ned_instr = (f1_vfne_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_ged_instr = (f1_vfge_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_gtd_instr = (f1_vfgt_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_merged_instr = (f1_vfmerge_instr) & f1_sew_64_bit & fp_dp_support;
wire f1_fp2fp_widen_instr = f1_scalar_fp_widen_instr | (f1_fp2fp_instr & f1_widen);
wire f1_cmp_instr = f1_ne_instr | f1_eq_instr | f1_lt_instr | f1_le_instr | f1_ge_instr | f1_gt_instr | f1_max_instr | f1_min_instr | f1_merge_instr | f1_neh_instr | f1_eqh_instr | f1_lth_instr | f1_leh_instr | f1_geh_instr | f1_gth_instr | f1_maxh_instr | f1_minh_instr | f1_mergeh_instr | f1_ned_instr | f1_eqd_instr | f1_ltd_instr | f1_led_instr | f1_ged_instr | f1_gtd_instr | f1_maxd_instr | f1_mind_instr | f1_merged_instr;
wire f1_sign_inject_instr = f1_sgnj_instr | f1_sgnjn_instr | f1_sgnjx_instr | f1_sgnjh_instr | f1_sgnjnh_instr | f1_sgnjxh_instr | f1_sgnjd_instr | f1_sgnjnd_instr | f1_sgnjxd_instr;
wire f1_classify_instr = f1_class_instr | f1_classd_instr | f1_classh_instr;
wire f1_non_conv_instr = f1_cmp_instr | f1_bf2s_instr | f1_mv_instr | f1_classify_instr | f1_sign_inject_instr;
wire f1_min_max_instr = f1_min_instr | f1_max_instr | f1_minh_instr | f1_maxh_instr | f1_mind_instr | f1_maxd_instr;
wire f1_vfcvtrtz_instr = f1_vfncvtxfrtz_instr | f1_vfwcvtxfrtz_instr | f1_vfcvtxfrtz_instr;
wire f1_desti_long = f1_fp2int_instr & ((~f1_fmis_scalar_valid & ((f1_sew_64_bit & (f1_same_width | f1_narrow)) | (f1_sew_32_bit & f1_widen))) | (f1_fcvtlh_instr | f1_fcvtls_instr | f1_fcvtld_instr)) & fp_sp_support;
wire f1_desti_word = f1_fp2int_instr & ((~f1_fmis_scalar_valid & ((f1_sew_32_bit & (f1_same_width | f1_narrow)) | (f1_sew_16_bit & f1_widen))) | (f1_fcvtwh_instr | f1_fcvtws_instr | f1_fcvtwd_instr)) & fp_sp_support;
wire f1_desti_half = f1_fp2int_instr & ((~f1_fmis_scalar_valid & ((f1_sew_16_bit & (f1_same_width | f1_narrow)) | (f1_sew_8_bit & f1_widen))) | (1'b0));
wire f1_desti_byte = f1_fp2int_instr & ((~f1_fmis_scalar_valid & ((f1_sew_8_bit & (f1_same_width | f1_narrow)))) | (1'b0));
wire f1_frd_bp = f1_s2bf_instr;
wire f1_frd_dp = ~f1_fp2int_instr & ((~f1_scalar_fp2fp_instr & ~f1_scalar_int2fp_instr & ((f1_sew_64_bit & (f1_same_width | f1_narrow)) | (f1_sew_32_bit & f1_widen))) | (f1_fcvtdw_instr | f1_fcvtdl_instr | f1_fcvtdh_instr | f1_fcvtds_instr)) & fp_dp_support;
wire f1_frd_sp = ~f1_fp2int_instr & ((~f1_scalar_fp2fp_instr & ~f1_scalar_int2fp_instr & ((f1_sew_32_bit & (f1_same_width | f1_narrow)) | (f1_sew_16_bit & f1_widen))) | (f1_fcvtsw_instr | f1_fcvtsl_instr | f1_fcvtsh_instr | f1_fcvtsd_instr)) & ~f1_frd_bp & fp_sp_support;
wire f1_frd_hp = ~f1_fp2int_instr & ((~f1_scalar_fp2fp_instr & ~f1_scalar_int2fp_instr & ((f1_sew_16_bit & (f1_same_width | f1_narrow)) | (f1_sew_8_bit & f1_widen))) | (f1_fcvthw_instr | f1_fcvthl_instr | f1_fcvths_instr | f1_fcvthd_instr)) & ~f1_frd_bp;
wire f1_conv_source_64bit = (((f1_sew_64_bit & (f1_same_width)) | (f1_sew_32_bit & f1_narrow)) & ~f1_fmis_scalar_valid | (f1_fcvtsl_instr | f1_fcvthl_instr | f1_fcvtdl_instr)) & fp_sp_support;
wire f1_conv_source_32bit = (((f1_sew_32_bit & (f1_same_width | f1_widen)) | (f1_sew_16_bit & f1_narrow)) & ~f1_fmis_scalar_valid | (f1_fcvthw_instr | f1_fcvtsw_instr | f1_fcvtdw_instr)) & fp_sp_support;
wire f1_conv_source_16bit = ((f1_sew_16_bit & (f1_same_width | f1_widen)) | (f1_sew_8_bit & f1_narrow));
wire f1_conv_source_8bit = ((f1_sew_8_bit & (f1_same_width | f1_widen)));
wire f1_frs_bp = f1_bf2s_instr;
wire f1_frs_dp = f1_sew_64_bit & (f1_non_conv_instr | f1_fcvtwd_instr | f1_fcvtld_instr | f1_fcvthd_instr | f1_fcvtsd_instr) & fp_dp_support & ~f1_frs_bp;
wire f1_frs_sp = f1_sew_32_bit & (f1_non_conv_instr | f1_fcvtws_instr | f1_fcvtls_instr | f1_fcvths_instr | f1_fcvtds_instr | f1_fcvtbs_instr) & fp_sp_support & ~f1_frs_bp;
wire f1_frs_hp = f1_sew_16_bit & (f1_non_conv_instr | f1_fcvtwh_instr | f1_fcvtlh_instr | f1_fcvtsh_instr | f1_fcvtdh_instr) & ~f1_frs_bp;
assign pipe0 = lane_pipe_id_0;
wire f1_nanbox_check_en = (pipe0 & f1_fmis_valid & (f1_ex_ctrl != 6'b101100) & (f1_ex_ctrl != 6'b110100));
assign f1_op1_h_nanboxing = f1_nanbox_check_en ? ((f1_frs_hp & (FLEN == 64)) ? &f1_op1_data[63:16] : (f1_frs_hp & (FLEN == 32)) ? &f1_op1_data[31:16] : 1'b0) : 1'b1;
assign f1_op2_h_nanboxing = f1_nanbox_check_en ? ((f1_frs_hp & (FLEN == 64)) ? &f1_op2_data[63:16] : (f1_frs_hp & (FLEN == 32)) ? &f1_op2_data[31:16] : 1'b0) : 1'b1;
assign f1_op1_s_nanboxing = f1_nanbox_check_en ? ((f1_frs_sp & (FLEN == 64)) ? &f1_op1_data[63:32] : (f1_frs_sp & (FLEN == 32)) ? 1'b1 : 1'b0) : 1'b1;
assign f1_op2_s_nanboxing = f1_nanbox_check_en ? ((f1_frs_sp & (FLEN == 64)) ? &f1_op2_data[63:32] : (f1_frs_sp & (FLEN == 32)) ? 1'b1 : 1'b0) : 1'b1;
wire f1_op1_h_is_inf = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9:0] == 10'b0) & (f1_op1_h_nanboxing);
wire f1_op1_h_is_subnor = (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] != 10'b0) & (f1_op1_h_nanboxing);
wire f1_op1_h_is_qnan = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9]) | ~(f1_op1_h_nanboxing) | f1_op1_invalid;
wire f1_op1_h_is_snan = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[8:0] != 9'b0) & (f1_op1_h_nanboxing) & ~f1_op1_data[9] & ~f1_op1_invalid;
wire f1_op2_h_is_qnan = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[9]) | ~(f1_op2_h_nanboxing) | f1_op2_invalid;
wire f1_op2_h_is_snan = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[8:0] != 9'b0) & (f1_op2_h_nanboxing) & ~f1_op2_data[9] & ~f1_op2_invalid;
wire f1_op1_s_is_inf = fp_sp_support & (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22:0] == 23'b0) & (f1_op1_s_nanboxing);
wire f1_op1_s_is_subnor = fp_sp_support & (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] != 23'b0) & (f1_op1_s_nanboxing);
wire f1_op1_s_is_qnan = fp_sp_support & (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22]) | ~(f1_op1_s_nanboxing) | f1_op1_invalid;
wire f1_op1_s_is_snan = fp_sp_support & (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[21:0] != 22'b0) & (f1_op1_s_nanboxing) & ~f1_op1_data[22] & ~f1_op1_invalid;
wire f1_op2_s_is_qnan = fp_sp_support & (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[22]) | ~(f1_op2_s_nanboxing) | f1_op2_invalid;
wire f1_op2_s_is_snan = fp_sp_support & (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[21:0] != 22'b0) & (f1_op2_s_nanboxing) & ~f1_op2_data[22] & ~f1_op2_invalid;
wire f1_op1_bf_is_nan = fp_sp_support & (f1_op1_data[14:7] == 8'hff) & (f1_op1_data[6:0] != 7'b0);
wire f1_op1_bf_is_snan = fp_sp_support & (f1_op1_data[14:7] == 8'hff) & (f1_op1_data[6] == 1'b0) & (f1_op1_data[5:0] != 6'b0);
wire f1_op1_bf_is_qnan = fp_sp_support & (f1_op1_data[14:7] == 8'hff) & (f1_op1_data[6] == 1'b1);
wire f1_op1_dp_is_zero = (f1_op1_data[62:0] == 63'b0) & fp_dp_support;
wire f1_op1_sp_is_zero = (f1_op1_data[30:0] == 31'b0) & fp_sp_support;
wire f1_op1_hp_is_zero = (f1_op1_data[14:0] == 15'b0);
wire f1_op1_d_is_inf = fp_dp_support & (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51:0] == 52'b0);
wire f1_op1_d_is_subnor = fp_dp_support & (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] != 52'b0);
wire f1_op1_d_is_qnan = fp_dp_support & (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51]) | f1_op1_invalid;
wire f1_op1_d_is_snan = fp_dp_support & (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[50:0] != 51'b0) & ~f1_op1_data[51] & ~f1_op1_invalid;
wire f1_op2_d_is_qnan = fp_dp_support & (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[51]) | f1_op2_invalid;
wire f1_op2_d_is_snan = fp_dp_support & (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[50:0] != 51'b0) & ~f1_op2_data[51] & ~f1_op2_invalid;
wire f1_op1_is_subnor = (f1_frs_dp & f1_op1_d_is_subnor) | (f1_frs_sp & f1_op1_s_is_subnor) | ((f1_frs_hp | f1_frs_bp) & f1_op1_h_is_subnor);
wire f1_op1_is_inf = (f1_frs_dp & f1_op1_d_is_inf) | (f1_frs_sp & f1_op1_s_is_inf) | ((f1_frs_hp | f1_frs_bp) & f1_op1_h_is_inf);
wire f1_op1_is_snan = (f1_frs_dp & f1_op1_d_is_snan) | (f1_frs_sp & f1_op1_s_is_snan) | (f1_frs_hp & f1_op1_h_is_snan) | (f1_frs_bp & f1_op1_bf_is_snan);
wire f1_op1_is_qnan = (f1_frs_dp & f1_op1_d_is_qnan) | (f1_frs_sp & f1_op1_s_is_qnan) | (f1_frs_hp & f1_op1_h_is_qnan) | (f1_frs_bp & f1_op1_bf_is_qnan);
wire f1_op2_is_snan = (f1_frs_dp & f1_op2_d_is_snan) | (f1_frs_sp & f1_op2_s_is_snan) | ((f1_frs_hp | f1_frs_bp) & f1_op2_h_is_snan);
wire f1_op2_is_qnan = (f1_frs_dp & f1_op2_d_is_qnan) | (f1_frs_sp & f1_op2_s_is_qnan) | ((f1_frs_hp | f1_frs_bp) & f1_op2_h_is_qnan);
wire f1_op1_is_nan = f1_op1_is_qnan | f1_op1_is_snan;
wire f1_op2_is_nan = f1_op2_is_qnan | f1_op2_is_snan;
wire f1_op1_s_is_nan = f1_op1_s_is_snan | f1_op1_s_is_qnan;
wire f1_op2_s_is_nan = f1_op2_s_is_snan | f1_op2_s_is_qnan;
wire f1_op1_d_is_nan = f1_op1_d_is_snan | f1_op1_d_is_qnan;
wire f1_op2_d_is_nan = f1_op2_d_is_snan | f1_op2_d_is_qnan;
wire f1_op1_h_is_nan = f1_op1_h_is_snan | f1_op1_h_is_qnan;
wire f1_op2_h_is_nan = f1_op2_h_is_snan | f1_op2_h_is_qnan;
wire f1_op1_is_int_zero = ((f1_op1_data == 64'b0) & f1_sew_64_bit) | ((f1_op1_data[31:0] == 32'b0) & f1_sew_32_bit);
assign f1_frd_is_zero = f1_fp2int_instr & f1_op1_is_fp_zero | f1_fp2fp_instr & f1_op1_is_fp_zero | f1_int2fp_instr & f1_op1_is_int_zero;
assign f1_frd_is_inf = f1_fp2fp_instr & f1_op1_is_inf | f1_fp2int_instr & f1_op1_is_inf;
assign f1_frd_is_qnan = f1_fp2fp_instr & f1_op1_is_nan | f1_fp2int_instr & f1_op1_is_nan;
assign f1_nv_exception = f1_fp2fp_instr & f1_op1_is_snan | f1_fp2int_instr & f1_op1_is_snan | f1_cmp_instr_inv_op;
wire [31:0] f1_op1_data_nanboxed_sp;
wire [31:0] f1_op2_data_nanboxed_sp;
wire [15:0] f1_op1_data_nanboxed_hp;
wire [15:0] f1_op2_data_nanboxed_hp;
assign f1_op1_data_nanboxed_sp = f1_op1_s_nanboxing ? f1_op1_data[31:0] : 32'h7fc00000;
assign f1_op2_data_nanboxed_sp = f1_op2_s_nanboxing ? f1_op2_data[31:0] : 32'h7fc00000;
assign f1_op1_data_nanboxed_hp = f1_op1_h_nanboxing ? f1_op1_data[15:0] : 16'h7e00;
assign f1_op2_data_nanboxed_hp = f1_op2_h_nanboxing ? f1_op2_data[15:0] : 16'h7e00;
assign f1_sign_inject_result = f1_sgnjd_instr ? {f1_op2_data[63],f1_op1_data[62:0]} : f1_sgnjnd_instr ? {~f1_op2_data[63],f1_op1_data[62:0]} : f1_sgnjxd_instr ? {f1_op1_data[63] ^ f1_op2_data[63],f1_op1_data[62:0]} : f1_sgnj_instr ? {32'hffffffff,f1_op2_data_nanboxed_sp[31],f1_op1_data_nanboxed_sp[30:0]} : f1_sgnjn_instr ? {32'hffffffff,~f1_op2_data_nanboxed_sp[31],f1_op1_data_nanboxed_sp[30:0]} : f1_sgnjx_instr ? {32'hffffffff,f1_op1_data_nanboxed_sp[31] ^ f1_op2_data_nanboxed_sp[31],f1_op1_data_nanboxed_sp[30:0]} : f1_sgnjh_instr ? {32'hffffffff,16'hffff,f1_op2_data_nanboxed_hp[15],f1_op1_data_nanboxed_hp[14:0]} : f1_sgnjnh_instr ? {32'hffffffff,16'hffff,~f1_op2_data_nanboxed_hp[15],f1_op1_data_nanboxed_hp[14:0]} : {32'hffffffff,16'hffff,f1_op1_data_nanboxed_hp[15] ^ f1_op2_data_nanboxed_hp[15],f1_op1_data_nanboxed_hp[14:0]};
wire f1_op1_eqh_op2 = (f1_op1_data[15] == f1_op2_data[15]) & (f1_op1_data[14:10] == f1_op2_data[14:10]) & (f1_op1_data[9:0] == f1_op2_data[9:0]) | (f1_op1_data[15] != f1_op2_data[15]) & (f1_op1_data[14:0] == 15'h0) & (f1_op2_data[14:0] == 15'h0);
wire f1_op1_lth_op2 = (f1_op1_data[15] == 1'b1) & (f1_op2_data[15] == 1'b0) & (~((f1_op1_data[14:0] == 15'h0) & (f1_op2_data[14:0] == 15'h0)) | f1_min_max_instr) | (f1_op1_data[15] == 1'b1) & (f1_op2_data[15] == 1'b1) & (f1_op1_data[14:10] > f1_op2_data[14:10]) | (f1_op1_data[15] == 1'b0) & (f1_op2_data[15] == 1'b0) & (f1_op1_data[14:10] < f1_op2_data[14:10]) | (f1_op1_data[15] == 1'b1) & (f1_op2_data[15] == 1'b1) & (f1_op1_data[14:10] == f1_op2_data[14:10]) & (f1_op1_data[9:0] > f1_op2_data[9:0]) | (f1_op1_data[15] == 1'b0) & (f1_op2_data[15] == 1'b0) & (f1_op1_data[14:10] == f1_op2_data[14:10]) & (f1_op1_data[9:0] < f1_op2_data[9:0]);
wire f1_op1_leh_op2 = f1_op1_eqh_op2 | f1_op1_lth_op2;
wire f1_op1_neh_op2 = ~f1_op1_eqh_op2 | f1_op1_is_nan | f1_op2_is_nan;
wire f1_op1_geh_op2 = ~f1_op1_lth_op2;
wire f1_op1_gth_op2 = ~f1_op1_leh_op2;
wire f1_op1_eq_op2 = ((f1_op1_data[31] == f1_op2_data[31]) & (f1_op1_data[30:23] == f1_op2_data[30:23]) & (f1_op1_data[22:0] == f1_op2_data[22:0]) | (f1_op1_data[31] != f1_op2_data[31]) & (f1_op1_data[30:0] == 31'h0) & (f1_op2_data[30:0] == 31'h0)) & fp_sp_support;
wire f1_op1_lt_op2 = ((f1_op1_data[31] == 1'b1) & (f1_op2_data[31] == 1'b0) & (~((f1_op1_data[30:0] == 31'h0) & (f1_op2_data[30:0] == 31'h0)) | f1_min_max_instr) | (f1_op1_data[31] == 1'b1) & (f1_op2_data[31] == 1'b1) & (f1_op1_data[30:23] > f1_op2_data[30:23]) | (f1_op1_data[31] == 1'b0) & (f1_op2_data[31] == 1'b0) & (f1_op1_data[30:23] < f1_op2_data[30:23]) | (f1_op1_data[31] == 1'b1) & (f1_op2_data[31] == 1'b1) & (f1_op1_data[30:23] == f1_op2_data[30:23]) & (f1_op1_data[22:0] > f1_op2_data[22:0]) | (f1_op1_data[31] == 1'b0) & (f1_op2_data[31] == 1'b0) & (f1_op1_data[30:23] == f1_op2_data[30:23]) & (f1_op1_data[22:0] < f1_op2_data[22:0])) & fp_sp_support;
wire f1_op1_le_op2 = f1_op1_eq_op2 | f1_op1_lt_op2;
wire f1_op1_ne_op2 = ~f1_op1_eq_op2 | f1_op1_is_nan | f1_op2_is_nan;
wire f1_op1_ge_op2 = ~f1_op1_lt_op2;
wire f1_op1_gt_op2 = ~f1_op1_le_op2;
wire f1_op1_eqd_op2 = ((f1_op1_data[63] == f1_op2_data[63]) & (f1_op1_data[62:52] == f1_op2_data[62:52]) & (f1_op1_data[51:0] == f1_op2_data[51:0]) | (f1_op1_data[63] != f1_op2_data[63]) & (f1_op1_data[62:0] == 63'h0) & (f1_op2_data[62:0] == 63'h0)) & fp_dp_support;
wire f1_op1_ltd_op2 = ((f1_op1_data[63] == 1'b1) & (f1_op2_data[63] == 1'b0) & (~((f1_op1_data[62:0] == 63'h0) & (f1_op2_data[62:0] == 63'h0)) | f1_min_max_instr) | (f1_op1_data[63] == 1'b1) & (f1_op2_data[63] == 1'b1) & (f1_op1_data[62:52] > f1_op2_data[62:52]) | (f1_op1_data[63] == 1'b0) & (f1_op2_data[63] == 1'b0) & (f1_op1_data[62:52] < f1_op2_data[62:52]) | (f1_op1_data[63] == 1'b1) & (f1_op2_data[63] == 1'b1) & (f1_op1_data[62:52] == f1_op2_data[62:52]) & (f1_op1_data[51:0] > f1_op2_data[51:0]) | (f1_op1_data[63] == 1'b0) & (f1_op2_data[63] == 1'b0) & (f1_op1_data[62:52] == f1_op2_data[62:52]) & (f1_op1_data[51:0] < f1_op2_data[51:0])) & fp_dp_support;
wire f1_op1_led_op2 = f1_op1_eqd_op2 | f1_op1_ltd_op2;
wire f1_op1_ned_op2 = ~f1_op1_eqd_op2 | f1_op1_is_nan | f1_op2_is_nan;
wire f1_op1_ged_op2 = ~f1_op1_ltd_op2;
wire f1_op1_gtd_op2 = ~f1_op1_led_op2;
wire f1_cmp_result_0 = (f1_op1_is_nan | f1_op2_is_nan) & ~f1_vfne_instr | (f1_frd_sp & (~f1_op1_s_nanboxing | ~f1_op2_s_nanboxing));
wire f1_min_max_nan = f1_min_max_instr & f1_op1_is_nan & f1_op2_is_nan;
assign f1_compare_result = f1_min_max_nan ? f1_frd_dp ? {64'h7ff8000000000000} : f1_frd_sp ? {32'hffffffff,32'h7fc00000} : {32'hffffffff,32'hffff7e00} : f1_mind_instr ? f1_op1_is_nan ? f1_op2_data : f1_op2_is_nan ? f1_op1_data : f1_op1_ltd_op2 ? f1_op1_data : f1_op2_data : f1_maxd_instr ? f1_op1_is_nan ? f1_op2_data : f1_op2_is_nan ? f1_op1_data : f1_op1_ltd_op2 ? f1_op2_data : f1_op1_data : f1_merged_instr ? f1_vmask ? f1_op2_data[63:0] : f1_op1_data[63:0] : f1_mergeh_instr ? f1_vmask ? {32'hffffffff,16'hffff,f1_op2_data[15:0]} : {32'hffffffff,16'hffff,f1_op1_data[15:0]} : f1_merge_instr ? f1_vmask ? {32'hffffffff,f1_op2_data[31:0]} : {32'hffffffff,f1_op1_data[31:0]} : f1_minh_instr ? f1_op1_is_nan ? {32'hffffffff,16'hffff,f1_op2_data[15:0]} : f1_op2_is_nan ? {32'hffffffff,16'hffff,f1_op1_data[15:0]} : f1_op1_lth_op2 ? {32'hffffffff,16'hffff,f1_op1_data[15:0]} : {32'hffffffff,16'hffff,f1_op2_data[15:0]} : f1_maxh_instr ? f1_op1_is_nan ? {32'hffffffff,16'hffff,f1_op2_data[15:0]} : f1_op2_is_nan ? {32'hffffffff,16'hffff,f1_op1_data[15:0]} : f1_op1_lth_op2 ? {32'hffffffff,16'hffff,f1_op2_data[15:0]} : {32'hffffffff,16'hffff,f1_op1_data[15:0]} : f1_min_instr ? f1_op1_is_nan ? {32'hffffffff,f1_op2_data[31:0]} : f1_op2_is_nan ? {32'hffffffff,f1_op1_data[31:0]} : f1_op1_lt_op2 ? {32'hffffffff,f1_op1_data[31:0]} : {32'hffffffff,f1_op2_data[31:0]} : f1_max_instr ? f1_op1_is_nan ? {32'hffffffff,f1_op2_data[31:0]} : f1_op2_is_nan ? {32'hffffffff,f1_op1_data[31:0]} : f1_op1_lt_op2 ? {32'hffffffff,f1_op2_data[31:0]} : {32'hffffffff,f1_op1_data[31:0]} : f1_cmp_result_0 ? {64'b0} : f1_ged_instr ? {63'b0,f1_op1_ged_op2} : f1_gtd_instr ? {63'b0,f1_op1_gtd_op2} : f1_eqd_instr ? {63'b0,f1_op1_eqd_op2} : f1_ned_instr ? {63'b0,f1_op1_ned_op2} : f1_ltd_instr ? {63'b0,f1_op1_ltd_op2} : f1_led_instr ? {63'b0,f1_op1_led_op2} : f1_ge_instr ? {63'b0,f1_op1_ge_op2} : f1_gt_instr ? {63'b0,f1_op1_gt_op2} : f1_eq_instr ? {63'b0,f1_op1_eq_op2} : f1_ne_instr ? {63'b0,f1_op1_ne_op2} : f1_lt_instr ? {63'b0,f1_op1_lt_op2} : f1_le_instr ? {63'b0,f1_op1_le_op2} : f1_geh_instr ? {63'b0,f1_op1_geh_op2} : f1_gth_instr ? {63'b0,f1_op1_gth_op2} : f1_eqh_instr ? {63'b0,f1_op1_eqh_op2} : f1_neh_instr ? {63'b0,f1_op1_neh_op2} : f1_lth_instr ? {63'b0,f1_op1_lth_op2} : {63'b0,f1_op1_leh_op2};
wire f1_op1_h_is_neg_inf = (f1_op1_data[15] == 1'b1) & (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9:0] == 10'b0);
wire f1_op1_h_is_pos_inf = (f1_op1_data[15] == 1'b0) & (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9:0] == 10'b0);
wire f1_op1_h_is_neg_subnor = (f1_op1_data[15] == 1'b1) & (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] != 10'b0);
wire f1_op1_h_is_pos_subnor = (f1_op1_data[15] == 1'b0) & (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] != 10'b0);
wire f1_op1_h_is_neg_zero = (f1_op1_data[15] == 1'b1) & (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] == 10'b0);
wire f1_op1_h_is_pos_zero = (f1_op1_data[15] == 1'b0) & (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] == 10'b0);
wire f1_op1_h_is_neg_nor = (f1_op1_data[15] == 1'b1) & (f1_op1_data[14:10] != 5'h1f) & (f1_op1_data[14:10] != 5'b0);
wire f1_op1_h_is_pos_nor = (f1_op1_data[15] == 1'b0) & (f1_op1_data[14:10] != 5'h1f) & (f1_op1_data[14:10] != 5'b0);
wire f1_op1_s_is_neg_inf = (f1_op1_data[31] == 1'b1) & (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22:0] == 23'b0) & fp_sp_support;
wire f1_op1_s_is_pos_inf = (f1_op1_data[31] == 1'b0) & (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22:0] == 23'b0) & fp_sp_support;
wire f1_op1_s_is_neg_subnor = (f1_op1_data[31] == 1'b1) & (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] != 23'b0) & fp_sp_support;
wire f1_op1_s_is_pos_subnor = (f1_op1_data[31] == 1'b0) & (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] != 23'b0) & fp_sp_support;
wire f1_op1_s_is_neg_zero = (f1_op1_data[31] == 1'b1) & (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] == 23'b0) & fp_sp_support;
wire f1_op1_s_is_pos_zero = (f1_op1_data[31] == 1'b0) & (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] == 23'b0) & fp_sp_support;
wire f1_op1_s_is_neg_nor = (f1_op1_data[31] == 1'b1) & (f1_op1_data[30:23] != 8'hff) & (f1_op1_data[30:23] != 8'b0) & fp_sp_support;
wire f1_op1_s_is_pos_nor = (f1_op1_data[31] == 1'b0) & (f1_op1_data[30:23] != 8'hff) & (f1_op1_data[30:23] != 8'b0) & fp_sp_support;
wire f1_op1_d_is_neg_inf = (f1_op1_data[63] == 1'b1) & (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51:0] == 52'b0) & fp_dp_support;
wire f1_op1_d_is_pos_inf = (f1_op1_data[63] == 1'b0) & (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51:0] == 52'b0) & fp_dp_support;
wire f1_op1_d_is_neg_subnor = (f1_op1_data[63] == 1'b1) & (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] != 52'b0) & fp_dp_support;
wire f1_op1_d_is_pos_subnor = (f1_op1_data[63] == 1'b0) & (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] != 52'b0) & fp_dp_support;
wire f1_op1_d_is_neg_zero = (f1_op1_data[63] == 1'b1) & (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] == 52'b0) & fp_dp_support;
wire f1_op1_d_is_pos_zero = (f1_op1_data[63] == 1'b0) & (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] == 52'b0) & fp_dp_support;
wire f1_op1_d_is_neg_nor = (f1_op1_data[63] == 1'b1) & (f1_op1_data[62:52] != 11'h7ff) & (f1_op1_data[62:52] != 11'h0) & fp_dp_support;
wire f1_op1_d_is_pos_nor = (f1_op1_data[63] == 1'b0) & (f1_op1_data[62:52] != 11'h7ff) & (f1_op1_data[62:52] != 11'b0) & fp_dp_support;
assign f1_classify_result = f1_frd_dp ? (f1_op1_d_is_qnan ? 64'h200 : f1_op1_d_is_snan ? 64'h100 : f1_op1_d_is_pos_inf ? 64'h80 : f1_op1_d_is_pos_nor ? 64'h40 : f1_op1_d_is_pos_subnor ? 64'h20 : f1_op1_d_is_pos_zero ? 64'h10 : f1_op1_d_is_neg_zero ? 64'h8 : f1_op1_d_is_neg_subnor ? 64'h4 : f1_op1_d_is_neg_nor ? 64'h2 : 64'h1) : f1_frd_sp ? (f1_op1_s_is_qnan ? 64'h200 : f1_op1_s_is_snan ? 64'h100 : f1_op1_s_is_pos_inf ? 64'h80 : f1_op1_s_is_pos_nor ? 64'h40 : f1_op1_s_is_pos_subnor ? 64'h20 : f1_op1_s_is_pos_zero ? 64'h10 : f1_op1_s_is_neg_zero ? 64'h8 : f1_op1_s_is_neg_subnor ? 64'h4 : f1_op1_s_is_neg_nor ? 64'h2 : 64'h1) : (f1_op1_h_is_qnan ? 64'h200 : f1_op1_h_is_snan ? 64'h100 : f1_op1_h_is_pos_inf ? 64'h80 : f1_op1_h_is_pos_nor ? 64'h40 : f1_op1_h_is_pos_subnor ? 64'h20 : f1_op1_h_is_pos_zero ? 64'h10 : f1_op1_h_is_neg_zero ? 64'h8 : f1_op1_h_is_neg_subnor ? 64'h4 : f1_op1_h_is_neg_nor ? 64'h2 : 64'h1);
assign f1_cmp_instr_inv_op = f1_cmp_instr & (f1_lt_instr | f1_le_instr | f1_ge_instr | f1_gt_instr) & (f1_op1_s_is_nan | f1_op2_s_is_nan | ~f1_op1_s_nanboxing | ~f1_op2_s_nanboxing) | f1_cmp_instr & (f1_lth_instr | f1_leh_instr | f1_geh_instr | f1_gth_instr) & (f1_op1_h_is_nan | f1_op2_h_is_nan | ~f1_op1_h_nanboxing | ~f1_op2_h_nanboxing) | f1_cmp_instr & (f1_ltd_instr | f1_led_instr | f1_ged_instr | f1_gtd_instr) & (f1_op1_d_is_nan | f1_op2_d_is_nan) | f1_cmp_instr & (f1_eq_instr | f1_ne_instr | f1_min_instr | f1_max_instr) & ((f1_op1_s_is_snan & f1_op1_s_nanboxing) | (f1_op2_s_is_snan & f1_op2_s_nanboxing)) | f1_cmp_instr & (f1_eqh_instr | f1_neh_instr | f1_minh_instr | f1_maxh_instr) & ((f1_op1_h_is_snan & f1_op1_h_nanboxing) | (f1_op2_h_is_snan & f1_op2_h_nanboxing)) | f1_cmp_instr & (f1_eqd_instr | f1_ned_instr | f1_mind_instr | f1_maxd_instr) & (f1_op1_d_is_snan | f1_op2_d_is_snan) | f1_bf2s_instr & f1_op1_bf_is_snan;
assign f1_bf2s_result = {32'hffffffff,(f1_op1_bf_is_nan ? 16'h7fc0 : f1_op1_data[15:0]),16'b0} & {64{fp_sp_support}};
assign f1_rd_result = {64{f1_sign_inject_instr}} & f1_sign_inject_result | {64{f1_cmp_instr}} & f1_compare_result | {64{f1_classify_instr}} & f1_classify_result | {64{f1_bf2s_instr}} & f1_bf2s_result;
wire f1_op1_hidden_bit_dp = ~(f1_op1_data[62:52] == 11'b0) & fp_dp_support;
wire f1_op1_hidden_bit_sp = ~(f1_op1_data[30:23] == 8'b0) & fp_sp_support;
wire f1_op1_hidden_bit_hp = ~(f1_op1_data[14:10] == 5'b0);
assign f1_op1_sign_dp = {1{fp_dp_support}} & f1_op1_data[63];
assign f1_op1_exp_dp = {11{fp_dp_support}} & f1_op1_data[62:52];
assign f1_op1_fraction_dp = {52{fp_dp_support}} & f1_op1_data[51:0];
assign f1_op1_sign_sp = {1{fp_sp_support}} & f1_op1_data[31];
assign f1_op1_exp_sp = {8{fp_sp_support}} & f1_op1_data[30:23];
assign f1_op1_fraction_sp = {23{fp_sp_support}} & f1_op1_data[22:0];
assign f1_op1_sign_hp = f1_op1_data[15];
assign f1_op1_exp_hp = f1_op1_data[14:10];
assign f1_op1_fraction_hp = f1_op1_data[9:0];
wire f1_op1_int_sign = (f1_sew_64_bit & f1_op1_data[63]) | (f1_sew_32_bit & f1_op1_data[31]) | (f1_sew_16_bit & f1_op1_data[15]) | (f1_sew_8_bit & f1_op1_data[7]);
wire f1_op1_int_neg = f1_sign & f1_op1_int_sign;
assign f1_nbs_l2 = f1_lz_num[3] ? {f1_nbs_l1[CVT_NBS_MSB - 8:CVT_NBS_LSB],8'b0} : f1_nbs_l1;
assign f1_nbs_l3 = f1_lz_num[2] ? {f1_nbs_l2[CVT_NBS_MSB - 4:CVT_NBS_LSB],4'b0} : f1_nbs_l2;
assign f1_nbs_l4 = f1_lz_num[1] ? {f1_nbs_l3[CVT_NBS_MSB - 2:CVT_NBS_LSB],2'b0} : f1_nbs_l3;
assign f1_nbs_l5 = f1_lz_num[0] ? {f1_nbs_l4[CVT_NBS_MSB - 1:CVT_NBS_LSB],1'b0} : f1_nbs_l4;
assign f1_fp2int_signed = (f1_frs_dp & f1_op1_sign_dp) | (f1_frs_sp & f1_op1_sign_sp) | ((f1_frs_hp | f1_frs_bp) & f1_op1_sign_hp);
assign f1_op1_is_fp_zero = (f1_frs_dp & f1_op1_dp_is_zero) | (f1_frs_sp & f1_op1_sp_is_zero) | ((f1_frs_hp | f1_frs_bp) & f1_op1_hp_is_zero);
wire f1_sp2hp = f1_fp2fp_instr & f1_frs_sp & f1_frd_hp;
wire f1_dp2hp = f1_fp2fp_instr & f1_frs_dp & f1_frd_hp;
wire f1_dp2sp = f1_fp2fp_instr & f1_frs_dp & f1_frd_sp;
assign f1_exp_no_bias_add_src1 = ({13{f1_frs_dp}} & {2'd0,f1_op1_exp_dp}) | ({13{f1_frs_sp}} & {5'd0,f1_op1_exp_sp}) | ({13{f1_frs_hp | f1_frs_bp}} & {8'd0,f1_op1_exp_hp});
assign f1_exp_no_bias_add_src2 = ({13{f1_frs_dp}} & 13'b1110000000001) | ({13{f1_frs_sp}} & 13'b1111110000001) | ({13{f1_frs_hp | f1_frs_bp}} & 13'b1111111110001);
assign f1_exp_op1_no_bias = (f1_exp_no_bias_add_src1 + f1_exp_no_bias_add_src2 + {12'b0,(f1_op1_is_subnor & ~f1_s2bf_instr)}) & {13{~f1_frd_is_zero}};
assign f1_sp2hp_subnorm = (f1_op1_exp_sp < 8'd113) & f1_sp2hp & fp_sp_support;
assign f1_dp2hp_subnorm = (f1_op1_exp_dp < 11'd1009) & f1_dp2hp & fp_dp_support;
assign f1_dp2sp_subnorm = (f1_op1_exp_dp < 11'd897) & f1_dp2sp & fp_dp_support;
assign f1_fp2hp_abs_amount = (f1_sp2hp_subnorm | f1_dp2hp_subnorm) ? ~f1_exp_op1_no_bias + 13'd29 : 13'd42;
assign f1_dp2sp_abs_amount = f1_dp2sp_subnorm ? ~f1_exp_op1_no_bias - 13'd96 : 13'd29;
assign f1_fp2fp_abs_amount = {13{f1_dp2sp}} & f1_dp2sp_abs_amount | {13{(f1_sp2hp | f1_dp2hp)}} & f1_fp2hp_abs_amount;
assign f1_abs_amount = {13{f1_s2bf_instr}} & 13'd45 | {13{f1_fp2fp_instr}} & f1_fp2fp_abs_amount | {13{f1_fp2int_instr}} & f1_fp2int_diff;
assign f1_fp2int_neg = f1_fp2int_signed & f1_fp2int_instr & f1_sign;
assign f1_abs_in = ({64{f1_frs_dp}} & {f1_op1_hidden_bit_dp,f1_op1_fraction_dp,11'b0}) | ({64{f1_frs_sp}} & {f1_op1_hidden_bit_sp,f1_op1_fraction_sp,40'b0}) | ({64{f1_frs_hp | f1_frs_bp}} & {f1_op1_hidden_bit_hp,f1_op1_fraction_hp,53'b0});
assign f1_abs_l0 = f1_abs_amount[5] ? {32'b0,f1_abs_in[CVT_ABS_MSB:CVT_ABS_LSB + 32]} : f1_abs_in;
assign f1_abs_l1 = f1_abs_amount[4] ? {16'b0,f1_abs_l0[CVT_ABS_MSB:CVT_ABS_LSB + 16]} : f1_abs_l0;
assign f1_abs_l2 = f1_abs_amount[3] ? {8'b0,f1_abs_l1[CVT_ABS_MSB:CVT_ABS_LSB + 8]} : f1_abs_l1;
assign f1_abs_l3 = f1_abs_amount[2] ? {4'b0,f1_abs_l2[CVT_ABS_MSB:CVT_ABS_LSB + 4]} : f1_abs_l2;
assign f1_abs_l4 = f1_abs_amount[1] ? {2'b0,f1_abs_l3[CVT_ABS_MSB:CVT_ABS_LSB + 2]} : f1_abs_l3;
assign f1_abs_l5 = f1_abs_amount[0] ? {1'b0,f1_abs_l4[CVT_ABS_MSB:CVT_ABS_LSB + 1]} : f1_abs_l4;
assign f1_abs_sticky_l0 = (f1_abs_amount[5] & (|f1_abs_in[CVT_ABS_LSB + 31:CVT_ABS_LSB]));
assign f1_abs_sticky_l1 = (f1_abs_amount[4] & (|f1_abs_l0[CVT_ABS_LSB + 15:CVT_ABS_LSB])) | f1_abs_sticky_l0;
assign f1_abs_sticky_l2 = (f1_abs_amount[3] & (|f1_abs_l1[CVT_ABS_LSB + 7:CVT_ABS_LSB])) | f1_abs_sticky_l1;
assign f1_abs_sticky_l3 = (f1_abs_amount[2] & (|f1_abs_l2[CVT_ABS_LSB + 3:CVT_ABS_LSB])) | f1_abs_sticky_l2;
assign f1_abs_sticky_l4 = (f1_abs_amount[1] & (|f1_abs_l3[CVT_ABS_LSB + 1:CVT_ABS_LSB])) | f1_abs_sticky_l3;
assign f1_abs_sticky_l5 = (f1_abs_amount[0] & (f1_abs_l4[CVT_ABS_LSB])) | f1_abs_sticky_l4;
assign f1_abs_sticky = f1_abs_amount_hi_part | (|f1_abs_l5[CVT_ABS_RND - 1:CVT_ABS_LSB]) | f1_abs_sticky_l5;
assign f1_abs_amount_hi_part = |f1_abs_amount[12:6];
assign f1_abs_final_out = f1_abs_amount_hi_part ? {(CVT_ABS_MSB - CVT_ABS_LSB + 1){1'b0}} : f1_abs_l5;
assign f2_exp_nx = ((f1_fp2fp_instr | f1_fp2int_instr) ? f1_exp_op1_no_bias : f1_conv_source_64bit ? 13'd63 : f1_conv_source_32bit ? 13'd31 : f1_conv_source_16bit ? 13'd15 : 13'd7);
assign f2_exp_op2_nx = ((f1_s2bf_instr | f1_fp2int_instr) ? 6'b0 : f1_lz_num);
assign f2_nbs_result_nx = f1_nbs_l5[CVT_NBS_MSB:CVT_NBS_RND];
assign f2_abs_result_nx = f1_abs_final_out[CVT_ABS_MSB:CVT_ABS_LSB];
assign f2_abs_sticky_nx = f1_abs_sticky & ~f1_fp2fp_widen_instr;
assign f2_nbs_sticky_nx = f1_nbs_sticky;
assign f2_arith_sign_nx = f1_int2fp_instr ? f1_op1_int_neg : f1_fp2int_signed;
assign f2_s2bf_is_subnorm_nx = f1_op1_s_is_subnor & f1_s2bf_instr;
assign f2_vmask_nx = f1_vmask | f1_vfmerge_instr;
assign f2_round_mode_nx = f1_vfncvtffrod_instr ? ROUND_ROD : f1_vfcvtrtz_instr ? ROUND_RTZ : f1_round_mode;
assign f2_instr_type_nx = f1_non_conv_instr ? ITYPE_NCVT : f1_int2fp_instr ? ITYPE_I2F : f1_fp2int_instr ? ITYPE_F2I : ITYPE_F2F;
assign f2_frd_type_nx = f1_desti_long ? FRD_TYPE_LONG : f1_desti_word ? FRD_TYPE_WORD : f1_desti_half ? FRD_TYPE_HALF : f1_desti_byte ? FRD_TYPE_BYTE : f1_frd_dp ? FRD_TYPE_DP : f1_frd_sp ? FRD_TYPE_SP : f1_frd_bp ? FRD_TYPE_BP : FRD_TYPE_HP;
always @* begin
    case (f2_round_mode_nx)
        ROUND_RUP: f2_rounding_nx = ROUND_POS;
        ROUND_RDN: f2_rounding_nx = ROUND_NEG;
        ROUND_RTZ: f2_rounding_nx = ROUND_ZERO;
        ROUND_ROD: f2_rounding_nx = ROUND_ZERO;
        default: f2_rounding_nx = ROUND_NEAREST;
    endcase
end

assign f2_rn_nx = f2_rounding_nx[0] & f2_rounding_nx[1];
assign f2_ri_nx = (~f2_arith_sign_nx & ~f2_rounding_nx[0] & f2_rounding_nx[1]) | (f2_arith_sign_nx & f2_rounding_nx[0] & ~f2_rounding_nx[1]);
assign f2_sticky_nx = f1_int2fp_instr ? f2_nbs_sticky_nx : f2_abs_sticky_nx;
assign f2_round_digit_nx = {(f2_sticky_nx & f2_ri_nx),(f2_rn_nx | f2_ri_nx)};
wire f2_desti_long = (f2_frd_type == FRD_TYPE_LONG) & fp_sp_support;
wire f2_desti_word = (f2_frd_type == FRD_TYPE_WORD) & fp_sp_support;
wire f2_desti_half = (f2_frd_type == FRD_TYPE_HALF);
wire f2_desti_byte = (f2_frd_type == FRD_TYPE_BYTE);
wire f2_frd_dp = (f2_frd_type == FRD_TYPE_DP) & fp_dp_support;
wire f2_frd_sp = (f2_frd_type == FRD_TYPE_SP) & fp_sp_support;
wire f2_frd_bp = (f2_frd_type == FRD_TYPE_BP);
wire f2_frd_hp = (f2_frd_type == FRD_TYPE_HP);
wire f2_non_conv_instr = f2_instr_type == ITYPE_NCVT;
wire f2_int2fp_instr = f2_instr_type == ITYPE_I2F;
wire f2_fp2int_instr = f2_instr_type == ITYPE_F2I;
wire f2_fp2fp_instr = f2_instr_type == ITYPE_F2F;
assign f2_exp_added = f2_exp - {7'b0,f2_exp_op2};
assign f2_round_adder_src1 = f2_bs_result[CVT_BS_MSB:CVT_BS_RND];
assign f2_round_bit = f2_bs_result[CVT_BS_RND];
assign f2_tie = f2_round_bit & ~f2_sticky;
assign f2_rod = f2_round_bit | f2_sticky;
assign f2_tie_clr_lsb = f2_tie & (f2_round_mode == ROUND_RNE);
assign f2_rod_set_lsb = f2_rod & (f2_round_mode == ROUND_ROD);
assign f2_fraction_lsb = f2_tie_clr_lsb ? 1'b0 : f2_rod_set_lsb ? 1'b1 : f2_round_adder_result[1];
assign f2_fraction = {f2_round_adder_result[54:2],f2_fraction_lsb};
assign f2_exp_inc = f2_frd_dp & f2_round_adder_result[54] | f2_frd_sp & (f2_round_adder_result[25] | (f2_dp2sp_subnorm & f2_round_adder_result[24])) | f2_frd_hp & (f2_round_adder_result[12] | ((f2_sp2hp_subnorm | f2_dp2hp_subnorm) & f2_round_adder_result[11])) | f2_frd_bp & (f2_round_adder_result[9] | (f2_s2bf_is_subnorm & f2_round_adder_result[8]));
assign f2_exp_adjust_p0 = (f2_frd_dp ? 13'd1023 : (f2_frd_sp | f2_frd_bp) ? 13'd127 : 13'd15) + f2_exp_added;
assign f2_exp_adjust_p1 = (f2_frd_dp ? 13'd1024 : (f2_frd_sp | f2_frd_bp) ? 13'd128 : 13'd16) + f2_exp_added;
assign f2_exp_adjust = f2_exp_inc ? f2_exp_adjust_p1 : f2_exp_adjust_p0;
assign f2_arith_result = {64{f2_frd_dp}} & {f2_arith_sign,f2_exp_adjust[10:0],f2_fraction[52:1]} | {64{f2_frd_sp}} & {32'hffffffff,f2_arith_sign,f2_exp_adjust[7:0] & {8{~f2_fp_subnorm}},f2_fraction[23:1]} | {64{f2_frd_bp}} & {48'hffffffffffff,f2_arith_sign,f2_exp_adjust[7:0] & {8{~f2_fp_subnorm}},f2_fraction[7:1]} | {64{f2_frd_hp}} & {48'hffffffffffff,f2_arith_sign,f2_exp_adjust[4:0] & {5{~f2_fp_subnorm}},f2_fraction[10:1]};
assign f2_fp2int_arith_result = f2_desti_long ? f2_fp2l_result : {{32{f2_fp2w_result[31]}},f2_fp2w_result};
wire f2_fraction_all_zero = ~(|f2_fraction[54:1]);
wire f2_exp_s_gt_ovf_bound_p0 = ~f2_exp_added[12] & (f2_exp_added[11:0] > 12'd127) & fp_sp_support;
wire f2_exp_s_gt_sub_bound_p0 = ~f2_exp_added[12] | (~f2_exp_added[11:0] < 12'd126) & fp_sp_support;
wire f2_exp_s_gt_udf_bound_p0 = ~f2_exp_added[12] | (~f2_exp_added[11:0] < 12'd150) & fp_sp_support;
wire f2_exp_h_gt_ovf_bound_p0 = ~f2_exp_added[12] & (f2_exp_added[11:0] > 12'd15);
wire f2_exp_h_gt_sub_bound_p0 = ~f2_exp_added[12] | (~f2_exp_added[11:0] < 12'd14);
wire f2_exp_h_gt_udf_bound_p0 = ~f2_exp_added[12] | (~f2_exp_added[11:0] < 12'd25);
wire f2_exp_s_gt_ovf_bound_p1 = ~f2_exp_added[12] & (f2_exp_added[11:0] > 12'd126) & fp_sp_support;
wire f2_exp_s_gt_sub_bound_p1 = ~f2_exp_added[12] | (~f2_exp_added[11:0] < 12'd127) & fp_sp_support;
wire f2_exp_s_gt_udf_bound_p1 = ~f2_exp_added[12] | (~f2_exp_added[11:0] < 12'd151) & fp_sp_support;
wire f2_exp_h_gt_ovf_bound_p1 = ~f2_exp_added[12] & (f2_exp_added[11:0] > 12'd14);
wire f2_exp_h_gt_sub_bound_p1 = ~f2_exp_added[12] | (~f2_exp_added[11:0] < 12'd15);
wire f2_exp_h_gt_udf_bound_p1 = ~f2_exp_added[12] | (~f2_exp_added[11:0] < 12'd26);
wire f2_exp_s_gt_ovf_bound = f2_exp_inc ? f2_exp_s_gt_ovf_bound_p1 : f2_exp_s_gt_ovf_bound_p0;
wire f2_exp_s_gt_sub_bound = f2_exp_inc ? f2_exp_s_gt_sub_bound_p1 : f2_exp_s_gt_sub_bound_p0;
wire f2_exp_s_gt_udf_bound = f2_exp_inc ? f2_exp_s_gt_udf_bound_p1 : f2_exp_s_gt_udf_bound_p0;
wire f2_exp_h_gt_ovf_bound = f2_exp_inc ? f2_exp_h_gt_ovf_bound_p1 : f2_exp_h_gt_ovf_bound_p0;
wire f2_exp_h_gt_sub_bound = f2_exp_inc ? f2_exp_h_gt_sub_bound_p1 : f2_exp_h_gt_sub_bound_p0;
wire f2_exp_h_gt_udf_bound = f2_exp_inc ? f2_exp_h_gt_udf_bound_p1 : f2_exp_h_gt_udf_bound_p0;
wire f2_unbounded_uf_hp = (f2_sp2hp_subnorm & f2_round_adder_result[11] & f2_subnorm_set_uf) & fp_sp_support | (f2_dp2hp_subnorm & f2_round_adder_result[11] & f2_subnorm_set_uf) & fp_dp_support;
wire f2_unbounded_uf_sp = (f2_dp2sp_subnorm & f2_round_adder_result[24] & f2_subnorm_set_uf) & fp_dp_support;
wire f2_hp_of_exception = f2_exp_h_gt_ovf_bound;
wire f2_hp_subnorm = ~f2_exp_h_gt_sub_bound & (f2_exp_h_gt_udf_bound | (f2_round_mode == ROUND_RUP));
wire f2_hp_uf_exception = f2_unbounded_uf_hp | ~f2_exp_h_gt_udf_bound | (f2_hp_subnorm & (f2_round_bit | f2_sticky));
wire f2_sp_of_exception = fp_sp_support & f2_exp_s_gt_ovf_bound;
wire f2_bp_of_exception = f2_sp_of_exception;
wire f2_sp_subnorm = fp_sp_support & ~f2_exp_s_gt_sub_bound & (f2_exp_s_gt_udf_bound | (f2_round_mode == ROUND_RUP));
wire f2_bp_subnorm = f2_sp_subnorm;
wire f2_sp_uf_exception = fp_sp_support & (~f2_exp_s_gt_udf_bound | (f2_sp_subnorm & (f2_round_bit | f2_sticky)) | f2_unbounded_uf_sp);
wire f2_bp_uf_exception = f2_sp_uf_exception;
assign f2_fp_subnorm = f2_frd_hp & f2_hp_subnorm | f2_frd_sp & f2_sp_subnorm | f2_frd_bp & f2_bp_subnorm;
wire f2_frd_is_special = f2_frd_is_inf | f2_frd_is_qnan | f2_frd_is_zero;
wire f2_of_exception = (f2_frd_sp & f2_sp_of_exception | f2_frd_bp & f2_bp_of_exception | f2_frd_hp & f2_hp_of_exception) & ~f2_frd_is_special;
wire f2_uf_exception = ((f2_frd_sp & f2_sp_uf_exception | f2_frd_bp & f2_bp_uf_exception | f2_frd_hp & f2_hp_uf_exception) & ~(f2_frd_is_special | (f2_fraction_all_zero & ~f2_round_bit & ~f2_sticky)));
wire f2_frd_result_zero = ~f2_frd_is_qnan & ~f2_frd_is_inf & (f2_frd_is_zero | f2_fraction_all_zero | (f2_uf_exception & ~f2_fp_subnorm & ~f2_unbounded_uf_hp & ~f2_unbounded_uf_sp & ((f2_round_mode == ROUND_RNE) | (f2_round_mode == ROUND_RMM) | (f2_round_mode == ROUND_RTZ) | ((f2_round_mode == ROUND_RUP) & f2_arith_sign) | ((f2_round_mode == ROUND_RDN) & ~f2_arith_sign))));
wire f2_frd_result_smallest = f2_uf_exception & ~f2_unbounded_uf_hp & ~f2_unbounded_uf_sp & (((f2_round_mode == ROUND_ROD)) | ((f2_round_mode == ROUND_RUP) & ~f2_arith_sign) | ((f2_round_mode == ROUND_RDN) & f2_arith_sign));
wire f2_frd_result_inf = ~f2_frd_is_qnan & (f2_frd_is_inf | (f2_of_exception & (((f2_round_mode == ROUND_RNE)) | ((f2_round_mode == ROUND_RMM)) | ((f2_round_mode == ROUND_RDN) & f2_arith_sign) | ((f2_round_mode == ROUND_RUP) & ~f2_arith_sign))));
wire f2_frd_result_largest = f2_of_exception & (((f2_round_mode == ROUND_RTZ)) | ((f2_round_mode == ROUND_ROD)) | ((f2_round_mode == ROUND_RUP) & f2_arith_sign) | ((f2_round_mode == ROUND_RDN) & ~f2_arith_sign));
wire f2_int2fp_conv_except = f2_frd_result_inf | f2_frd_result_zero | f2_frd_is_qnan | f2_frd_result_largest | (f2_frd_result_smallest & ~f2_fp_subnorm);
wire f2_frd_is_qnan_bp = f2_frd_bp & f2_frd_is_qnan;
wire f2_frd_is_qnan_hp = f2_frd_hp & f2_frd_is_qnan;
wire f2_frd_is_qnan_sp = f2_frd_sp & f2_frd_is_qnan;
wire f2_frd_is_qnan_dp = f2_frd_dp & f2_frd_is_qnan;
wire f2_frd_result_inf_bp = f2_frd_bp & f2_frd_result_inf;
wire f2_frd_result_inf_hp = f2_frd_hp & f2_frd_result_inf;
wire f2_frd_result_inf_sp = f2_frd_sp & f2_frd_result_inf;
wire f2_frd_result_inf_dp = f2_frd_dp & f2_frd_result_inf;
wire f2_frd_result_zero_bp = f2_frd_bp & f2_frd_result_zero;
wire f2_frd_result_zero_hp = f2_frd_hp & f2_frd_result_zero;
wire f2_frd_result_zero_sp = f2_frd_sp & f2_frd_result_zero;
wire f2_frd_result_zero_dp = f2_frd_dp & f2_frd_result_zero;
wire f2_frd_result_largest_hp = f2_frd_hp & f2_frd_result_largest;
wire f2_frd_result_largest_sp = f2_frd_sp & f2_frd_result_largest;
wire f2_frd_result_largest_dp = f2_frd_dp & f2_frd_result_largest;
wire f2_frd_result_smallest_hp = f2_frd_hp & f2_frd_result_smallest;
wire f2_frd_result_smallest_sp = f2_frd_sp & f2_frd_result_smallest;
wire f2_frd_result_smallest_dp = f2_frd_dp & f2_frd_result_smallest;
wire f2_zero_sign = (f2_fraction_all_zero & ~f2_round_bit & ~f2_sticky & ~f2_frd_is_zero) ? (f2_round_mode == ROUND_RDN) : f2_arith_sign;
assign f2_int2fp_special_value = ({64{f2_frd_is_qnan_hp}} & {48'hffffffffffff,1'b0,5'h1f,10'h200}) | ({64{f2_frd_is_qnan_bp}} & {48'hffffffffffff,1'b0,8'hff,7'h40}) | ({64{f2_frd_is_qnan_sp}} & {32'hffffffff,1'b0,8'hff,23'h400000}) | ({64{f2_frd_is_qnan_dp}} & {1'b0,11'h7ff,52'h8000000000000}) | ({64{f2_frd_result_inf_hp}} & {48'hffffffffffff,f2_arith_sign,5'h1f,10'h0}) | ({64{f2_frd_result_inf_bp}} & {48'hffffffffffff,f2_arith_sign,8'hff,7'h0}) | ({64{f2_frd_result_inf_sp}} & {32'hffffffff,f2_arith_sign,8'hff,23'h0}) | ({64{f2_frd_result_inf_dp}} & {f2_arith_sign,11'h7ff,52'h0}) | ({64{f2_frd_result_zero_hp}} & {48'hffffffffffff,f2_zero_sign,5'h00,10'h0}) | ({64{f2_frd_result_zero_bp}} & {48'hffffffffffff,f2_zero_sign,8'h00,7'h0}) | ({64{f2_frd_result_zero_sp}} & {32'hffffffff,f2_zero_sign,8'h00,23'h0}) | ({64{f2_frd_result_zero_dp}} & {f2_zero_sign,11'h000,52'h0}) | ({64{f2_frd_result_largest_hp}} & {48'hffffffffffff,f2_arith_sign,5'h1e,10'h3ff}) | ({64{f2_frd_result_largest_sp}} & {32'hffffffff,f2_arith_sign,8'hfe,23'h7fffff}) | ({64{f2_frd_result_largest_dp}} & {f2_arith_sign,11'h7fe,52'hfffffffffffff}) | ({64{f2_frd_result_smallest_hp}} & {48'hffffffffffff,f2_arith_sign,5'h00,10'h1}) | ({64{f2_frd_result_smallest_sp}} & {32'hffffffff,f2_arith_sign,8'h00,23'h1}) | ({64{f2_frd_result_smallest_dp}} & {f2_arith_sign,11'h000,52'h1});
wire f2_fp2l_zero_ui = ~f2_sign & f2_arith_sign & ~f2_frd_is_qnan & (~f2_fraction_all_zero | (~f2_exp[11] & (|f2_exp[10:6])));
wire f2_fp2l_min_si = f2_sign & f2_arith_sign & ~f2_frd_is_qnan & ~f2_exp[11] & (|f2_exp[10:6]) | f2_sign & f2_arith_sign & ~f2_frd_is_qnan & ~f2_exp[11] & ~f2_fp2l_result[63] & ~f2_fraction_all_zero | (f2_sign & f2_arith_sign & f2_frd_is_inf);
wire f2_fp2l_max_ui = ~f2_sign & ((~f2_arith_sign & ((~f2_exp[11] & (|f2_exp[10:6])) | f2_frd_is_inf)) | f2_frd_is_qnan);
wire f2_fp2l_max_si = f2_sign & ~f2_arith_sign & ~f2_exp[11] & (|f2_exp[10:6]) | f2_sign & ~f2_arith_sign & ~f2_exp[11] & f2_fp2l_result[63] | f2_sign & ((~f2_arith_sign & f2_frd_is_inf) | f2_frd_is_qnan);
wire f2_fp2w_zero_ui = ~f2_sign & f2_arith_sign & ~f2_frd_is_qnan & (~f2_fraction_all_zero | (~f2_exp[11] & (|f2_exp[10:5])));
wire f2_fp2w_max_si = f2_sign & ~f2_arith_sign & ~f2_exp[11] & (|f2_exp[10:5]) | f2_sign & ~f2_arith_sign & ~f2_exp[11] & (f2_fp2w_result[31] | f2_round_adder_result[33]) | f2_sign & ((~f2_arith_sign & f2_frd_is_inf) | f2_frd_is_qnan);
wire f2_fp2w_max_ui = ~f2_sign & ((~f2_arith_sign & ((~f2_exp[11] & (|f2_exp[10:5])) | f2_frd_is_inf)) | f2_frd_is_qnan) | ~f2_sign & ~f2_arith_sign & ~f2_exp[11] & f2_round_adder_result[33];
wire f2_fp2w_min_si = f2_sign & f2_arith_sign & ~f2_frd_is_qnan & ~f2_exp[11] & (|f2_exp[10:5]) | f2_sign & f2_arith_sign & ~f2_frd_is_qnan & ~f2_exp[11] & ~f2_fp2w_result[31] & ~f2_fraction_all_zero | f2_sign & f2_arith_sign & f2_frd_is_inf;
wire f2_fp2h_zero_ui = ~f2_sign & f2_arith_sign & ~f2_frd_is_qnan & (~f2_fraction_all_zero | (~f2_exp[11] & (|f2_exp[10:4])));
wire f2_fp2h_max_si = f2_sign & ~f2_arith_sign & ~f2_exp[11] & (|f2_exp[10:4]) | f2_sign & ~f2_arith_sign & ~f2_exp[11] & (f2_fp2w_result[15] | f2_round_adder_result[17]) | f2_sign & ((~f2_arith_sign & f2_frd_is_inf) | f2_frd_is_qnan);
wire f2_fp2h_max_ui = ~f2_sign & ((~f2_arith_sign & ((~f2_exp[11] & (|f2_exp[10:4])) | f2_frd_is_inf)) | f2_frd_is_qnan) | ~f2_sign & ~f2_arith_sign & ~f2_exp[11] & f2_round_adder_result[17];
wire f2_fp2h_min_si = f2_sign & f2_arith_sign & ~f2_frd_is_qnan & ~f2_exp[11] & (|f2_exp[10:4]) | f2_sign & f2_arith_sign & ~f2_frd_is_qnan & ~f2_exp[11] & ~f2_fp2w_result[15] & ~f2_fraction_all_zero | f2_sign & f2_arith_sign & f2_frd_is_inf;
wire f2_fp2b_zero_ui = ~f2_sign & f2_arith_sign & ~f2_frd_is_qnan & (~f2_fraction_all_zero | (~f2_exp[11] & (f2_exp > 13'd7)));
wire f2_fp2b_max_si = f2_sign & ~f2_arith_sign & ~f2_exp[11] & (|f2_exp[10:3]) | f2_sign & ~f2_arith_sign & ~f2_exp[11] & (f2_fp2w_result[7] | f2_round_adder_result[9]) | f2_sign & ((~f2_arith_sign & f2_frd_is_inf) | f2_frd_is_qnan);
wire f2_fp2b_max_ui = ~f2_sign & ((~f2_arith_sign & ((~f2_exp[11] & (|f2_exp[10:3])) | f2_frd_is_inf)) | f2_frd_is_qnan) | ~f2_sign & ~f2_arith_sign & ~f2_exp[11] & f2_round_adder_result[9];
wire f2_fp2b_min_si = f2_sign & f2_arith_sign & ~f2_frd_is_qnan & ~f2_exp[11] & (|f2_exp[10:3]) | f2_sign & f2_arith_sign & ~f2_frd_is_qnan & ~f2_exp[11] & ~f2_fp2w_result[7] & ~f2_fraction_all_zero | f2_sign & f2_arith_sign & f2_frd_is_inf;
wire f2_fp2int_zero_ui = (f2_desti_byte & f2_fp2b_zero_ui) | (f2_desti_half & f2_fp2h_zero_ui) | (f2_desti_word & f2_fp2w_zero_ui) | (f2_desti_long & f2_fp2l_zero_ui);
wire f2_fp2int_max_ui = f2_desti_word & f2_fp2w_max_ui | f2_desti_half & f2_fp2h_max_ui | f2_desti_byte & f2_fp2b_max_ui | f2_desti_long & f2_fp2l_max_ui;
wire f2_fp2int_zero_ui_narr = (f2_desti_byte & f2_fp2b_zero_ui) | (f2_desti_half & f2_fp2h_zero_ui) | (f2_desti_word & f2_fp2w_zero_ui);
wire f2_fp2int_max_ui_narr = f2_desti_half & f2_fp2h_max_ui | f2_desti_byte & f2_fp2b_max_ui | f2_desti_word & f2_fp2w_max_ui;
wire f2_fp2int_max_sw = f2_desti_word & f2_fp2w_max_si;
wire f2_fp2int_min_sw = f2_desti_word & f2_fp2w_min_si;
wire f2_fp2int_max_sh = f2_desti_half & f2_fp2h_max_si;
wire f2_fp2int_min_sh = f2_desti_half & f2_fp2h_min_si;
wire f2_fp2int_max_sb = f2_desti_byte & f2_fp2b_max_si;
wire f2_fp2int_min_sb = f2_desti_byte & f2_fp2b_min_si;
wire f2_fp2int_max_sl = f2_desti_long & f2_fp2l_max_si;
wire f2_fp2int_min_sl = f2_desti_long & f2_fp2l_min_si;
assign f2_fp2int_special_value = ({64{f2_fp2int_zero_ui}} & 64'h0000_0000_0000_0000) | ({64{f2_fp2int_max_ui}} & 64'hffff_ffff_ffff_ffff) | ({64{f2_fp2int_max_sh}} & 64'h0000_0000_0000_7fff) | ({64{f2_fp2int_min_sh}} & 64'hffff_ffff_ffff_8000) | ({64{f2_fp2int_max_sb}} & 64'h0000_0000_0000_007f) | ({64{f2_fp2int_min_sb}} & 64'hffff_ffff_ffff_ff80) | ({64{f2_fp2int_max_sw}} & 64'h0000_0000_7fff_ffff) | ({64{f2_fp2int_min_sw}} & 64'hffff_ffff_8000_0000) | ({64{f2_fp2int_max_sl}} & 64'h7fff_ffff_ffff_ffff) | ({64{f2_fp2int_min_sl}} & 64'h8000_0000_0000_0000);
assign f2_fp2int_special_value_narr = ({64{f2_fp2int_zero_ui_narr}} & 64'h0000_0000_0000_0000) | ({64{f2_fp2int_max_ui_narr}} & 64'hffff_ffff_ffff_ffff) | ({64{f2_fp2int_max_sh}} & 64'h0000_0000_0000_7fff) | ({64{f2_fp2int_min_sh}} & 64'hffff_ffff_ffff_8000) | ({64{f2_fp2int_max_sb}} & 64'h0000_0000_0000_007f) | ({64{f2_fp2int_min_sb}} & 64'hffff_ffff_ffff_ff80) | ({64{f2_fp2int_max_sw}} & 64'h0000_0000_7fff_ffff) | ({64{f2_fp2int_min_sw}} & 64'hffff_ffff_8000_0000);
assign f2_fp2int_conv_except = (f2_desti_long & (f2_fp2l_zero_ui | f2_fp2l_max_ui | f2_fp2l_max_si | f2_fp2l_min_si)) | (f2_desti_word & (f2_fp2w_zero_ui | f2_fp2w_max_ui | f2_fp2w_max_si | f2_fp2w_min_si)) | (f2_desti_half & (f2_fp2h_zero_ui | f2_fp2h_max_ui | f2_fp2h_max_si | f2_fp2h_min_si)) | (f2_desti_byte & (f2_fp2b_zero_ui | f2_fp2b_max_ui | f2_fp2b_max_si | f2_fp2b_min_si));
assign f2_fp2int_result = f2_fp2int_conv_except ? f2_fp2int_special_value : f2_fp2int_arith_result;
assign f2_int2fp_result = f2_int2fp_conv_except ? f2_int2fp_special_value : f2_arith_result;
assign f2_cmp_result = f2_noncvt_result[0];
assign f2_wdata = {64{f2_non_conv_instr}} & f2_noncvt_result | {64{f2_fp2int_instr}} & f2_fp2int_result | {64{f2_int2fp_instr}} & f2_int2fp_result | {64{f2_fp2fp_instr}} & f2_int2fp_result;
assign f2_fp2int_result_narr = f2_fp2int_conv_except_narr ? f2_fp2int_special_value_narr : f2_fp2int_arith_result_narr;
assign f2_narr_wdata = {64{f2_fp2int_instr}} & f2_fp2int_result_narr | {64{f2_int2fp_instr | f2_fp2fp_instr}} & f2_int2fp_result;
assign f2_result_type = f2_frd_bp ? TYPE_16_BIT : f2_frd_type[1:0];
wire f2_nx_exception = ~(f2_fp2fp_instr & (f2_frd_is_qnan | f2_frd_is_zero)) & (((f2_round_bit | f2_sticky) & ~f2_frd_is_inf) | f2_of_exception | f2_uf_exception);
wire f2_fp2int_nx = f2_nx_exception & ~f2_fp2int_conv_except & f2_fp2int_round_need & ~f2_sp2long_no_round_need;
wire f2_fp2int_nv_except = f2_fp2int_conv_except | f2_nv_exception;
assign f2_int2fp_fcsr_wdata = {1'b0,1'b0,f2_of_exception,f2_uf_exception,f2_nx_exception};
assign f2_fp2fp_fcsr_wdata = {f2_nv_exception,1'b0,f2_of_exception,f2_uf_exception,f2_nx_exception};
assign f2_fp2int_fcsr_wdata = {f2_fp2int_nv_except,1'b0,1'b0,1'b0,f2_fp2int_nx};
assign f2_non_conv_fcsr_wdata = {f2_nv_exception,4'b0};
assign f2_flag_set = {5{f2_wdata_en}} & ({5{f2_non_conv_instr}} & f2_non_conv_fcsr_wdata | {5{f2_int2fp_instr}} & f2_int2fp_fcsr_wdata | {5{f2_fp2fp_instr}} & f2_fp2fp_fcsr_wdata | {5{f2_fp2int_instr}} & f2_fp2int_fcsr_wdata);
generate
    if ((FLEN == 32) | (FLEN == 64)) begin:gen_sp_dp_result
        wire f1_frs_dp_for_nbs_ff;
        wire f1_frs_sp_for_nbs_ff;
        wire [62:0] f1_op1_2s_comple_63b;
        wire [63:0] f1_op1_neg_2_pos;
        wire [1:0] f2_round_digit_ha;
        wire [54:0] f2_round_adder_src2;
        wire [63:0] op1_int2fp_short_part;
        assign f1_op1_2s_comple_63b = ~f1_op1_data[62:0] + 63'b1;
        assign f1_op1_neg_2_pos = {&(~f1_op1_data[62:0]),f1_op1_2s_comple_63b[62:1],f1_op1_data[0]};
        assign f1_op1_int_pos = {64{f1_op1_int_neg}} & f1_op1_neg_2_pos | {64{~f1_op1_int_neg}} & f1_op1_data;
        assign f1_frs_dp_for_nbs_ff = ((f1_sew_32_bit & f1_narrow & ~f1_fmis_scalar_valid) | (f1_fcvtsd_instr | f1_fcvthd_instr)) & fp_dp_support;
        assign f1_frs_sp_for_nbs_ff = ((((f1_sew_32_bit & f1_widen) | (f1_sew_16_bit & f1_narrow)) & ~f1_fmis_scalar_valid) | (f1_fcvths_instr | f1_fcvtds_instr | f1_fcvtbs_instr));
        assign op1_int2fp_short_part = {64{~f1_fp2fp_instr & f1_conv_source_64bit}} & {f1_op1_data[63:0]} | {64{~f1_fp2fp_instr & f1_conv_source_32bit}} & {f1_op1_data[31:0],32'b0} | {64{~f1_fp2fp_instr & f1_conv_source_16bit}} & {f1_op1_data[15:0],48'b0} | {64{f1_fp2fp_instr & f1_frs_dp_for_nbs_ff}} & {f1_op1_hidden_bit_dp,f1_op1_fraction_dp,11'b0} | {64{f1_fp2fp_instr & f1_frs_sp_for_nbs_ff}} & {f1_op1_hidden_bit_sp,f1_op1_fraction_sp,29'b0,11'b0} | {64{f1_fp2fp_instr & f1_frs_hp}} & {f1_op1_hidden_bit_hp,f1_op1_fraction_hp,42'b0,11'b0};
        assign f1_op1_int2fp_nbs = {64{f1_fp2fp_instr | ~f1_op1_int_neg}} & op1_int2fp_short_part | {64{~f1_fp2fp_instr & f1_conv_source_64bit & f1_op1_int_neg}} & {f1_op1_neg_2_pos[63:0]} | {64{~f1_fp2fp_instr & f1_conv_source_32bit & f1_op1_int_neg}} & {f1_op1_neg_2_pos[31:0],32'b0} | {64{~f1_fp2fp_instr & f1_conv_source_16bit & f1_op1_int_neg}} & {f1_op1_neg_2_pos[15:0],48'b0};
        assign f1_nbs_l0 = f1_lz_num[5] ? {f1_nbs_lsh[CVT_NBS_MSB - 32:CVT_NBS_LSB],32'b0} : f1_nbs_lsh;
        assign f1_nbs_l1 = f1_lz_num[4] ? {f1_nbs_l0[CVT_NBS_MSB - 16:CVT_NBS_LSB],16'b0} : f1_nbs_l0;
        assign f2_noncvt_result = {f2_bs_result[CVT_BS_MSB:CVT_BS_LSB]};
        wire f2_lsb = f2_bs_result[CVT_BS_RND + 1];
        wire f2_fp2int_neg_complement = (~f2_round_bit & (f2_round_digit != 2'b11)) | (f2_round_bit & (f2_round_digit == 2'b00)) | (f2_round_bit & (f2_tie_clr_lsb & ~f2_lsb));
        assign f2_round_digit_ha = {1'b0,f2_round_digit[1]} + {1'b0,f2_round_digit[0]};
        assign f2_round_adder_src2 = f2_fp2int_neg ? {53'b0,f2_fp2int_neg_complement,1'b0} : {53'b0,f2_round_digit_ha};
        assign f2_round_adder_result = ({55{f2_fp2int_neg}} ^ {1'b0,f2_round_adder_src1}) + f2_round_adder_src2;
        assign f2_fp2w_result = f2_fraction[32:1];
        assign f2_fp2hw_result_narr = f2_fraction[16:1];
        wire f2_round_bit_subnorm = f2_bs_result[9];
        wire f2_subnorm_uf_cond1 = f2_frd_hp & (f2_round_adder_src1[CVT_BS_RND + 10:CVT_BS_RND] == 11'h7ff) | f2_frd_sp & (f2_round_adder_src1[CVT_BS_RND + 23:CVT_BS_RND] == 24'hffffff);
        wire f2_subnorm_uf_cond2 = f2_frd_hp & (f2_round_adder_src1[CVT_BS_RND + 10:CVT_BS_RND] == 11'h7fe) | f2_frd_sp & (f2_round_adder_src1[CVT_BS_RND + 23:CVT_BS_RND] == 24'hfffffe);
        wire f2_subnorm_set_uf_cond1 = f2_subnorm_uf_cond1 & ~(f2_round_digit_ha[1] | (f2_round_digit_ha[0] & f2_round_bit_subnorm));
        wire f2_subnorm_set_uf_cond2 = f2_subnorm_uf_cond2 & (f2_sticky | f2_round_bit_subnorm) & (f2_ri & ~f2_rn);
        assign f2_subnorm_set_uf = f2_subnorm_set_uf_cond1 | f2_subnorm_set_uf_cond2;
    end
    else begin:gen_hp_result
        assign f1_op1_int_pos = f1_op1_int_neg ? {48'b0,((f1_conv_source_16bit ? ~f1_op1_data[15:0] : {8'b0,~f1_op1_data[7:0]}) + 16'b1)} : f1_op1_data[63:0];
        assign f1_op1_int2fp_nbs = f1_conv_source_16bit ? {f1_op1_int_pos[15:0]} : {f1_op1_int_pos[7:0],8'b0};
        assign f1_nbs_l0 = f1_nbs_lsh;
        assign f1_nbs_l1 = f1_nbs_l0;
        assign f1_nbs_sticky = |f1_nbs_l5[(CVT_NBS_RND - 1):CVT_NBS_LSB];
        assign f2_noncvt_result = {{48{f2_bs_result[CVT_BS_LSB + 16]}},f2_bs_result[(CVT_BS_LSB + 15):CVT_BS_LSB]};
        assign f2_round_adder_result = {37'b0,({1'b0,f2_round_adder_src1} + {17'b0,f2_round_digit[1]} + {17'b0,f2_round_digit[0]})};
        assign f2_fp2w_result = f2_arith_sign ? (~f2_fraction[32:1] + 32'b1) : f2_fraction[32:1];
        assign f2_fp2hw_result_narr = f2_arith_sign ? (~f2_fraction[16:1] + 16'b1) : f2_fraction[16:1];
        assign f2_fp2int_unround = 64'b0;
        assign f2_subnorm_set_uf = 1'b0;
    end
endgenerate
generate
    if (FLEN == 64) begin:gen_dp_nbs
        wire [52:0] f2_fp2l_round;
        wire [63:0] f2_fp2int_unround_2scomp;
        assign f1_nbs_lsh = ({(CVT_NBS_MSB - CVT_NBS_LSB + 1){f1_frd_dp}} & {f1_op1_int2fp_nbs,42'b0}) | ({(CVT_NBS_MSB - CVT_NBS_LSB + 1){f1_frd_sp}} & {29'b0,f1_op1_int2fp_nbs,13'b0}) | ({(CVT_NBS_MSB - CVT_NBS_LSB + 1){f1_frd_hp}} & {42'b0,f1_op1_int2fp_nbs});
        wire f2_widen_nx = f1_widen | f1_scalar_fp_widen_instr;
        assign f2_bs_result_nx = f1_non_conv_instr ? f1_rd_result[63:0] : (f1_int2fp_instr | (f1_fp2fp_instr & f2_widen_nx)) ? {f2_nbs_result_nx[CVT_NBS_MSB:CVT_NBS_RND],10'b0} : {f2_abs_result_nx[CVT_ABS_MSB:CVT_ABS_LSB]};
        assign f2_fp2int_arith_result_narr = {{32{f2_fp2w_result[31]}},f2_fp2w_result};
        assign f2_fp2int_conv_except_narr = (f2_desti_word & (f2_fp2w_zero_ui | f2_fp2w_max_ui | f2_fp2w_max_si | f2_fp2w_min_si)) | (f2_desti_half & (f2_fp2h_zero_ui | f2_fp2h_max_ui | f2_fp2h_max_si | f2_fp2h_min_si)) | (f2_desti_byte & (f2_fp2b_zero_ui | f2_fp2b_max_ui | f2_fp2b_max_si | f2_fp2b_min_si));
        assign f1_sp2long_no_round_need = 1'b0;
        assign f1_fp2int_round_need = (f1_frs_dp & (f1_op1_exp_dp < 11'd1075)) | (f1_frs_sp & (f1_op1_exp_sp < 8'd179)) | f1_frs_hp;
        assign f1_fp2int_diff = (f1_fp2int_round_need ? 13'd52 : 13'd63) - f1_exp_op1_no_bias;
        assign f2_fp2int_unround = {f2_bs_result[CVT_BS_MSB:CVT_BS_LSB]};
        assign f2_fp2l_round = f2_fraction[53:1];
        assign f2_fp2int_unround_2scomp = f2_arith_sign ? (~f2_fp2int_unround + 64'b1) : f2_fp2int_unround;
        assign f2_fp2l_result = f2_fp2int_round_need ? {{11{f2_arith_sign & ~f2_fraction_all_zero}},f2_fp2l_round} : f2_fp2int_unround_2scomp;
    end
    else if (FLEN == 32) begin:gen_sp_nbs
        wire [63:0] f2_fp2int_unround_2scomp;
        assign f1_nbs_lsh = ({(CVT_NBS_MSB - CVT_NBS_LSB + 1){f1_frd_sp}} & {f1_op1_int2fp_nbs,13'b0}) | ({(CVT_NBS_MSB - CVT_NBS_LSB + 1){f1_frd_hp}} & {13'b0,f1_op1_int2fp_nbs});
        wire f2_widen_nx = f1_widen | f1_scalar_fp_widen_instr;
        assign f2_bs_result_nx = f1_non_conv_instr ? f1_rd_result[63:0] : (f1_int2fp_instr | (f1_fp2fp_instr & f2_widen_nx)) ? {29'b0,f2_nbs_result_nx[CVT_NBS_MSB:CVT_NBS_RND],10'b0} : {f2_abs_result_nx[CVT_ABS_MSB:CVT_ABS_LSB]};
        assign f2_fp2int_arith_result_narr = {{48{f2_fp2hw_result_narr[15]}},f2_fp2hw_result_narr};
        assign f2_fp2int_conv_except_narr = (f2_desti_half & (f2_fp2h_zero_ui | f2_fp2h_max_ui | f2_fp2h_max_si | f2_fp2h_min_si)) | (f2_desti_byte & (f2_fp2b_zero_ui | f2_fp2b_max_ui | f2_fp2b_max_si | f2_fp2b_min_si));
        assign f1_sp2long_no_round_need = (f1_frs_sp & (f1_op1_exp_sp > 8'd151) & f1_desti_long);
        assign f1_fp2int_round_need = (f1_frs_sp & (f1_op1_exp_sp < 8'd179)) | f1_frs_hp;
        assign f1_fp2int_diff = (f1_sp2long_no_round_need ? 13'd63 : f1_fp2int_round_need ? 13'd52 : 13'd63) - f1_exp_op1_no_bias;
        assign f2_fp2int_unround = {f2_bs_result[CVT_BS_MSB:CVT_BS_LSB]};
        assign f2_fp2int_unround_2scomp = f2_arith_sign ? (~f2_fp2int_unround + 64'b1) : f2_fp2int_unround;
        assign f2_fp2l_result = f2_sp2long_no_round_need ? f2_fp2int_unround_2scomp : {{32{f2_arith_sign & ~f2_fraction_all_zero}},f2_fp2w_result};
    end
    else begin:gen_hp_nbs
        assign f1_nbs_lsh = f1_op1_int2fp_nbs;
        assign f2_bs_result_nx = f1_non_conv_instr ? {f1_rd_result[16:0]} : f1_int2fp_instr ? {5'b0,f2_nbs_result_nx[63:52]} : {f2_abs_result_nx[26:10]};
        assign f2_fp2int_arith_result_narr = {{48{f2_fp2hw_result_narr[15]}},f2_fp2hw_result_narr};
        assign f2_fp2int_conv_except_narr = (f2_desti_byte & (f2_fp2b_zero_ui | f2_fp2b_max_ui | f2_fp2b_max_si | f2_fp2b_min_si));
        assign f1_sp2long_no_round_need = 1'b0;
        assign f1_fp2int_round_need = 1'b1;
        assign f1_fp2int_diff = 13'd52 - f1_exp_op1_no_bias;
        assign f2_fp2l_result = 64'b0;
    end
endgenerate
generate
    if ((FLEN == 32) | (FLEN == 64)) begin:gen_lz_num_sp
        reg f1_s_nbs_sticky;
        wire [63:0] f1_lz_count_64;
        wire [31:0] f1_lz_count_32;
        wire [15:0] f1_lz_count_16;
        wire [7:0] f1_lz_count_8;
        wire [3:0] f1_lz_count_4;
        wire [1:0] f1_lz_count_2;
        wire f1_s_lz_num_5_mux;
        wire [1:0] f1_s_lz_num_4_mux;
        wire [1:0] f1_s_lz_num_3_mux;
        wire [1:0] f1_s_lz_num_2_mux;
        wire [1:0] f1_s_lz_num_1_mux;
        wire [5:0] f1_s_lz_num;
        assign f1_lz_num = f1_s_lz_num;
        assign f1_nbs_sticky = f1_s_nbs_sticky;
        assign f1_lz_count_64 = f1_op1_int2fp_nbs[63:0];
        assign f1_s_lz_num_5_mux = ~|f1_lz_count_64[63:32];
        assign f1_s_lz_num_4_mux[1] = ~|f1_lz_count_64[31:16];
        assign f1_s_lz_num_4_mux[0] = ~|f1_lz_count_64[63:48];
        assign f1_s_lz_num_3_mux[1] = f1_s_lz_num[5] ? ~|f1_lz_count_64[15:8] : ~|f1_lz_count_64[47:40];
        assign f1_s_lz_num_3_mux[0] = f1_s_lz_num[5] ? ~|f1_lz_count_64[31:24] : ~|f1_lz_count_64[63:56];
        assign f1_s_lz_num_2_mux[1] = ((f1_s_lz_num[5:4] == 2'b11) & (~|f1_lz_count_64[7:4])) | ((f1_s_lz_num[5:4] == 2'b10) & (~|f1_lz_count_64[23:20])) | ((f1_s_lz_num[5:4] == 2'b01) & (~|f1_lz_count_64[39:36])) | ((f1_s_lz_num[5:4] == 2'b00) & (~|f1_lz_count_64[55:52]));
        assign f1_s_lz_num_2_mux[0] = ((f1_s_lz_num[5:4] == 2'b11) & (~|f1_lz_count_64[15:12])) | ((f1_s_lz_num[5:4] == 2'b10) & (~|f1_lz_count_64[31:28])) | ((f1_s_lz_num[5:4] == 2'b01) & (~|f1_lz_count_64[47:44])) | ((f1_s_lz_num[5:4] == 2'b00) & (~|f1_lz_count_64[63:60]));
        assign f1_s_lz_num_1_mux[1] = ((f1_s_lz_num[5:3] == 3'b111) & (~|f1_lz_count_64[3:2])) | ((f1_s_lz_num[5:3] == 3'b110) & (~|f1_lz_count_64[11:10])) | ((f1_s_lz_num[5:3] == 3'b101) & (~|f1_lz_count_64[19:18])) | ((f1_s_lz_num[5:3] == 3'b100) & (~|f1_lz_count_64[27:26])) | ((f1_s_lz_num[5:3] == 3'b011) & (~|f1_lz_count_64[35:34])) | ((f1_s_lz_num[5:3] == 3'b010) & (~|f1_lz_count_64[43:42])) | ((f1_s_lz_num[5:3] == 3'b001) & (~|f1_lz_count_64[51:50])) | ((f1_s_lz_num[5:3] == 3'b000) & (~|f1_lz_count_64[59:58]));
        assign f1_s_lz_num_1_mux[0] = ((f1_s_lz_num[5:3] == 3'b111) & (~|f1_lz_count_64[7:6])) | ((f1_s_lz_num[5:3] == 3'b110) & (~|f1_lz_count_64[15:14])) | ((f1_s_lz_num[5:3] == 3'b101) & (~|f1_lz_count_64[23:22])) | ((f1_s_lz_num[5:3] == 3'b100) & (~|f1_lz_count_64[31:30])) | ((f1_s_lz_num[5:3] == 3'b011) & (~|f1_lz_count_64[39:38])) | ((f1_s_lz_num[5:3] == 3'b010) & (~|f1_lz_count_64[47:46])) | ((f1_s_lz_num[5:3] == 3'b001) & (~|f1_lz_count_64[55:54])) | ((f1_s_lz_num[5:3] == 3'b000) & (~|f1_lz_count_64[63:62]));
        assign f1_s_lz_num[5] = f1_s_lz_num_5_mux;
        assign f1_s_lz_num[4] = f1_s_lz_num[5] ? f1_s_lz_num_4_mux[1] : f1_s_lz_num_4_mux[0];
        assign f1_s_lz_num[3] = f1_s_lz_num[4] ? f1_s_lz_num_3_mux[1] : f1_s_lz_num_3_mux[0];
        assign f1_s_lz_num[2] = f1_s_lz_num[3] ? f1_s_lz_num_2_mux[1] : f1_s_lz_num_2_mux[0];
        assign f1_s_lz_num[1] = f1_s_lz_num[2] ? f1_s_lz_num_1_mux[1] : f1_s_lz_num_1_mux[0];
        assign f1_s_lz_num[0] = ~f1_lz_count_2[1];
        assign f1_lz_count_32 = f1_s_lz_num[5] ? f1_lz_count_64[31:0] : f1_lz_count_64[63:32];
        assign f1_lz_count_16 = f1_s_lz_num[4] ? f1_lz_count_32[15:0] : f1_lz_count_32[31:16];
        assign f1_lz_count_8 = f1_s_lz_num[3] ? f1_lz_count_16[7:0] : f1_lz_count_16[15:8];
        assign f1_lz_count_4 = f1_s_lz_num[2] ? f1_lz_count_8[3:0] : f1_lz_count_8[7:4];
        assign f1_lz_count_2 = f1_s_lz_num[1] ? f1_lz_count_4[1:0] : f1_lz_count_4[3:2];
        always @* begin
            case (f1_s_lz_num[5:0])
                6'd51: f1_s_nbs_sticky = |f1_nbs_lsh[0];
                6'd50: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 50):0];
                6'd49: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 49):0];
                6'd48: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 48):0];
                6'd47: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 47):0];
                6'd46: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 46):0];
                6'd45: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 45):0];
                6'd44: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 44):0];
                6'd43: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 43):0];
                6'd42: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 42):0];
                6'd41: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 41):0];
                6'd40: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 40):0];
                6'd39: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 39):0];
                6'd38: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 38):0];
                6'd37: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 37):0];
                6'd36: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 36):0];
                6'd35: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 35):0];
                6'd34: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 34):0];
                6'd33: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 33):0];
                6'd32: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 32):0];
                6'd31: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 31):0];
                6'd30: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 30):0];
                6'd29: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 29):0];
                6'd28: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 28):0];
                6'd27: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 27):0];
                6'd26: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 26):0];
                6'd25: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 25):0];
                6'd24: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 24):0];
                6'd23: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 23):0];
                6'd22: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 22):0];
                6'd21: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 21):0];
                6'd20: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 20):0];
                6'd19: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 19):0];
                6'd18: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 18):0];
                6'd17: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 17):0];
                6'd16: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 16):0];
                6'd15: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 15):0];
                6'd14: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 14):0];
                6'd13: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 13):0];
                6'd12: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 12):0];
                6'd11: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 11):0];
                6'd10: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 10):0];
                6'd9: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 9):0];
                6'd8: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 8):0];
                6'd7: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 7):0];
                6'd6: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 6):0];
                6'd5: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 5):0];
                6'd4: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 4):0];
                6'd3: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 3):0];
                6'd2: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 2):0];
                6'd1: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 1):0];
                6'd0: f1_s_nbs_sticky = |f1_nbs_lsh[(51 - 0):0];
                default: f1_s_nbs_sticky = 1'b0;
            endcase
        end

    end
    else begin:gen_lz_num_hp
        wire [15:0] f1_lz_count_16;
        wire [7:0] f1_lz_count_8;
        wire [3:0] f1_lz_count_4;
        wire [1:0] f1_lz_count_2;
        wire f1_h_lz_num_3_mux;
        wire [1:0] f1_h_lz_num_2_mux;
        wire [1:0] f1_h_lz_num_1_mux;
        wire [3:0] f1_h_lz_num;
        assign f1_lz_num = {2'b0,f1_h_lz_num};
        assign f1_lz_count_16 = f1_op1_int2fp_nbs[15:0];
        assign f1_h_lz_num_3_mux = ~|f1_lz_count_16[15:8];
        assign f1_h_lz_num_2_mux[1] = ~|f1_lz_count_16[7:4];
        assign f1_h_lz_num_2_mux[0] = ~|f1_lz_count_16[15:12];
        assign f1_h_lz_num_1_mux[1] = f1_h_lz_num[3] ? ~|f1_lz_count_16[3:2] : ~|f1_lz_count_16[11:10];
        assign f1_h_lz_num_1_mux[0] = f1_h_lz_num[3] ? ~|f1_lz_count_16[7:6] : ~|f1_lz_count_16[15:14];
        assign f1_h_lz_num[3] = f1_h_lz_num_3_mux;
        assign f1_h_lz_num[2] = f1_h_lz_num[3] ? f1_h_lz_num_2_mux[1] : f1_h_lz_num_2_mux[0];
        assign f1_h_lz_num[1] = f1_h_lz_num[2] ? f1_h_lz_num_1_mux[1] : f1_h_lz_num_1_mux[0];
        assign f1_h_lz_num[0] = ~f1_lz_count_2[1];
        assign f1_lz_count_8 = f1_h_lz_num[3] ? f1_lz_count_16[7:0] : f1_lz_count_16[15:8];
        assign f1_lz_count_4 = f1_h_lz_num[2] ? f1_lz_count_8[3:0] : f1_lz_count_8[7:4];
        assign f1_lz_count_2 = f1_h_lz_num[1] ? f1_lz_count_4[1:0] : f1_lz_count_4[3:2];
    end
endgenerate
endmodule

