module fmafp16 (
    aclk,
    aresetn,
    fmac_standby_ready,
    f1_op1_data,
    f1_op2_data,
    f1_op3_data,
    f1_valid,
    f1_round_mode,
    f1_sew,
    f1_ediv,
    f1_ex_ctrl,
    f1_op_wide,
    f1_op_mask,
    f1_op1_hp,
    f1_op3_hp,
    f3_stall,
    f3_wdata,
    f3_wdata_en,
    f3_flag_set,
    f3_result_type
);
parameter FLEN = 16;
localparam HP_FRAC_BW = 10;
localparam SP_FRAC_BW = 23;
localparam DP_FRAC_BW = 52;
localparam EXP_MSB = 9;
localparam MAC_MSB = (FLEN == 64) ? 161 : (FLEN == 32) ? 132 : 119;
localparam MAC_LSB = ((FLEN == 64) ? 0 : (FLEN == 32) ? 58 : 84) - 2;
localparam MAC_WIDTH = MAC_MSB - MAC_LSB + 1;
localparam MUL_MSB = DP_FRAC_BW;
localparam MUL_LSB = (FLEN == 64) ? MUL_MSB - DP_FRAC_BW : (FLEN == 32) ? MUL_MSB - SP_FRAC_BW : MUL_MSB - HP_FRAC_BW;
localparam LZA_MSB = MAC_MSB;
localparam LZA_LSB = MAC_LSB + 1;
localparam LZA_WIDTH = LZA_MSB - LZA_LSB + 1;
localparam HP_LZA_MSB = 161 - (DP_FRAC_BW - HP_FRAC_BW);
localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;
input aclk;
input aresetn;
input [31:0] f1_op1_data;
input [31:0] f1_op2_data;
input [31:0] f1_op3_data;
input f1_valid;
input [2:0] f1_round_mode;
input [2:0] f1_sew;
input [1:0] f1_ediv;
input [5:0] f1_ex_ctrl;
input f1_op_wide;
input f1_op_mask;
input f1_op1_hp;
input f1_op3_hp;
input f3_stall;
output [63:0] f3_wdata;
output f3_wdata_en;
output [4:0] f3_flag_set;
output [1:0] f3_result_type;
output fmac_standby_ready;

wire f1_op2_hp = f1_op1_hp | (FLEN == 16);
wire f1_op1_sp = ~f1_op1_hp & (FLEN >= 32);
wire f1_op2_sp = ~f1_op2_hp & (FLEN >= 32);
wire f1_op3_sp = ~f1_op3_hp & (FLEN >= 32);
wire [2:0] f1_round_mode;
wire f1_frd_hp;
wire f1_frd_sp;
reg f2_valid;
reg f2_nv_exception;
reg f2_frd_inf;
reg f2_frd_zero;
reg f2_frd_nan;
reg f2_arith_sign;
reg f2_eff_sub;
reg [EXP_MSB:0] f2_mac_exp_op2;
reg [EXP_MSB:0] f2_mac_exp_op1;
reg [MAC_MSB:MAC_LSB] f2_abs;
reg f2_frd_scalar_fp;
wire f2_frd_hp;
wire f2_frd_sp;
wire f2_pipe_en;
reg f3_valid;
reg f3_nv_exception;
reg f3_frd_inf;
reg f3_frd_zero;
reg f3_frd_nan;
reg f3_arith_sign;
reg f3_abs_sticky;
reg [EXP_MSB:0] f3_mac_exp;
reg [1:0] f3_lzc_after_subnorm_pred;
reg f3_ovf_check_disable;
reg [2:0] f3_round_mode;
reg [MAC_MSB:MAC_LSB] f3_nbs_sum_l5;
reg f3_round_rne;
reg f3_round_rdn;
reg f3_ri;
reg f3_rn;
reg f3_rz;
reg f3_frd_scalar_fp;
wire f3_frd_hp;
wire f3_frd_sp;
wire f3_pipe_en;
wire f3_subnorm_set_uf;
wire f3_redosum_masked;
wire [31:0] f3_redosum_scalar;
assign fmac_standby_ready = ~f1_valid & ~f2_valid & ~f3_valid;
wire f1_sew16 = f1_sew[0] | (FLEN == 16);
wire f1_sew32 = f1_sew[1] & (FLEN >= 32);
assign f1_frd_hp = f1_sew16 & (~f1_op_wide | (FLEN == 16));
assign f1_frd_sp = f1_sew32 | (f1_sew16 & f1_op_wide & (FLEN >= 32));
wire f1_fadd_instr = (f1_ex_ctrl[4:0] == 5'b01100);
wire f1_fsub_instr = (f1_ex_ctrl[4:0] == 5'b01101);
wire f1_fmadd_instr = (f1_ex_ctrl[4:0] == 5'b01000);
wire f1_fmsub_instr = (f1_ex_ctrl[4:0] == 5'b01010);
wire f1_fnmadd_instr = (f1_ex_ctrl[4:0] == 5'b01001);
wire f1_fnmsub_instr = (f1_ex_ctrl[4:0] == 5'b01011);
wire f1_fmul_instr = (f1_ex_ctrl[4:0] == 5'b01110);
wire f1_add_instr = f1_fadd_instr;
wire f1_sub_instr = f1_fsub_instr;
wire f1_mul_instr = f1_fmul_instr;
wire f1_madd_instr = f1_fmadd_instr | f1_add_instr | f1_mul_instr;
wire f1_msub_instr = f1_fmsub_instr | f1_sub_instr;
wire f1_nmadd_instr = f1_fnmadd_instr;
wire f1_nmsub_instr = f1_fnmsub_instr;
// zero or subnormal
//
// [x][00000][0000000000]
// subnormal
// [x][00000][xxxxxxxxxx]
//            :at least one of these x bits must be 1
// nan
// [x][11111][xxxxxxxxxx]
//            :at least one of these x bits must be 1
// snan
// [x][11111][0xxxxxxxxx]
//            :at least one of these x bits must be 1
// qnan
// [x][11111][1xxxxxxxxx]
//            :at least one of these x bits can be 1 or 0 because fp[9] is areadly being 1
// inf
// [x][11111][0000000000]
//
// a * b
//                                       [a]
//
//                      [snan] [qnan] [inf] [zero] [subnorm] [norm]
//           [snan]     2_1   2_1     2_1   2_1    2_1       2_1
//           [qnan]     2_1   2_1     2_1   2_1    2_1       2_1
//   [b]     [inf]      2_1   2_1     n_1   n_1    n_1       n_1
//           [zero]     2_1   2_1     n_1   n_1    n_1       n_1
//           [subnorm]  2_1   2_1     n_1   n_1    n_2       n_4
//           [norm]     2_1   2_1     n_1   n_1    n_4       n_3
//
// multiply nan
//      section 2_1 "most operations propagate qnan without signaling exception
//                   and signal the invalid operation exception when given a snan operand"
// note n_1
//      multiply inf
//      inf x inf = inf
//      inf x subnorm = inf
//      inf x norm = inf
//      inf x zero = qnan
//
wire f1_op1_nanbox_check = f1_frd_scalar_fp;
wire f1_op2_nanbox_check = f1_frd_scalar_fp & ~(f1_add_instr | f1_sub_instr);
wire f1_op3_nanbox_check = f1_frd_scalar_fp & ~(f1_mul_instr);
wire f1_op1_nanbox_fail = f1_op1_nanbox_check & (~(&f1_op1_data[31:16]));
wire f1_op2_nanbox_fail = f1_op2_nanbox_check & (~(&f1_op2_data[31:16]));
wire f1_op3_nanbox_fail = f1_op3_nanbox_check & (~(&f1_op3_data[31:16]));
wire f1_op1_exp_all1 = &f1_op1_h_exp;
wire f1_op2_exp_all1 = &f1_op2_h_exp;
wire f1_op3_exp_all1 = &f1_op3_h_exp;
wire f1_op1_exp_all0 =  ~(|f1_op1_h_exp);
wire f1_op2_exp_all0 =  ~(|f1_op2_h_exp);
wire f1_op3_exp_all0 =  ~(|f1_op3_h_exp);
wire f1_op1_frac_all0 = ~(|f1_op1_h_frac);
wire f1_op2_frac_all0 = ~(|f1_op2_h_frac);
wire f1_op3_frac_all0 = ~(|f1_op3_h_frac);
wire f1_op1_signaling_bit = f1_op1_data[9];
wire f1_op2_signaling_bit = f1_op2_data[9];
wire f1_op3_signaling_bit = f1_op3_data[9];
wire f1_op1_is_inf = f1_op1_exp_all1 & f1_op1_frac_all0 & ~f1_op1_nanbox_fail;
wire f1_op2_is_inf = f1_op2_exp_all1 & f1_op2_frac_all0 & ~f1_op2_nanbox_fail;
wire f1_op3_is_inf = f1_op3_exp_all1 & f1_op3_frac_all0 & ~f1_op3_nanbox_fail;
wire f1_op1_is_nan = (f1_op1_exp_all1 & ~f1_op1_frac_all0) | f1_op1_nanbox_fail;
wire f1_op2_is_nan = (f1_op2_exp_all1 & ~f1_op2_frac_all0) | f1_op2_nanbox_fail;
wire f1_op3_is_nan = (f1_op3_exp_all1 & ~f1_op3_frac_all0) | f1_op3_nanbox_fail;
wire f1_op1_is_snan = f1_op1_is_nan & ~f1_op1_signaling_bit & ~f1_op1_nanbox_fail;
wire f1_op2_is_snan = f1_op2_is_nan & ~f1_op2_signaling_bit & ~f1_op2_nanbox_fail;
wire f1_op3_is_snan = f1_op3_is_nan & ~f1_op3_signaling_bit & ~f1_op3_nanbox_fail;
wire f1_op1_is_zero = f1_op1_exp_all0 & f1_op1_frac_all0 & ~f1_op1_nanbox_fail;
wire f1_op2_is_zero = f1_op2_exp_all0 & f1_op2_frac_all0 & ~f1_op2_nanbox_fail;
wire f1_op3_is_zero = f1_op3_exp_all0 & f1_op3_frac_all0 & ~f1_op3_nanbox_fail;
//{{{ multiply sign bit
//      section 6.3 "when neither the input or result are nan, the sign of a product
//                   ... is the xor of the operands' sign
wire f1_mul_sign = f1_op1_sign ^ f1_op2_sign ^ (f1_nmadd_instr | f1_nmsub_instr);
wire f1_eff_sub = (f1_mul_sign ^ f1_op3_sign ^ (f1_msub_instr | f1_nmadd_instr));
//}}}
wire f1_mul_to_inf = f1_op1_is_inf & ~(f1_op2_is_zero | f1_op2_is_nan) | f1_op2_is_inf & ~(f1_op1_is_zero | f1_op1_is_nan);
wire f1_mul_to_zero = f1_op1_is_zero & ~(f1_op2_is_inf | f1_op2_is_nan) | f1_op2_is_zero & ~(f1_op1_is_inf | f1_op1_is_nan);
wire f1_mul_to_nan = (f1_op1_is_nan | f1_op2_is_nan) | (f1_op1_is_inf & f1_op2_is_zero) | (f1_op2_is_inf & f1_op1_is_zero);
wire f1_mul_to_nv_exc = (f1_op1_is_snan | f1_op2_is_snan) | (f1_op1_is_inf & f1_op2_is_zero) | (f1_op2_is_inf & f1_op1_is_zero);
wire f1_frd_zero = f1_mul_to_zero & f1_op3_is_zero;
wire f1_frd_inf = (f1_mul_to_inf & ~f1_op3_is_nan & ~(f1_op3_is_inf & f1_eff_sub)) | (f1_op3_is_inf & ~f1_mul_to_nan & ~(f1_mul_to_inf & f1_eff_sub));
wire f1_frd_nan = (f1_mul_to_nan | f1_op3_is_nan) | (f1_mul_to_inf & f1_op3_is_inf & f1_eff_sub);
wire f1_nv_exception = (f1_mul_to_nv_exc | f1_op3_is_snan) | (f1_mul_to_inf & f1_op3_is_inf & f1_eff_sub);
wire f1_frd_zero_sign = (f1_mul_instr & f1_mul_sign) | (f1_madd_instr & f1_mul_sign & f1_op3_sign) | (f1_nmadd_instr & f1_mul_sign & ~f1_op3_sign) | (f1_msub_instr & f1_mul_sign & ~f1_op3_sign) | (f1_nmsub_instr & f1_mul_sign & f1_op3_sign) | (f1_eff_sub & (f1_round_mode == ROUND_RDN));
wire f1_frd_inf_sign = (f1_madd_instr & (f1_op3_is_inf ? f1_op3_sign : f1_mul_sign)) | (f1_nmadd_instr & (f1_op3_is_inf ? ~f1_op3_sign : f1_mul_sign)) | (f1_msub_instr & (f1_op3_is_inf ? ~f1_op3_sign : f1_mul_sign)) | (f1_nmsub_instr & (f1_op3_is_inf ? f1_op3_sign : f1_mul_sign));
wire f1_op1_subnorm_hp = ((f1_op1_data[14:10] == 5'b0));
wire f1_op2_subnorm_hp = ((f1_op2_data[14:10] == 5'b0));
wire f1_op3_subnorm_hp = ((f1_op3_data[14:10] == 5'b0));
wire [EXP_MSB:0] f1_op1_exp = {5'b0,f1_op1_data[14:11],f1_op1_data[10] | (f1_op1_subnorm_hp)};
wire [EXP_MSB:0] f1_op2_exp = {5'b0,f1_op2_data[14:11],f1_op2_data[10] | (f1_op2_subnorm_hp)};
wire [EXP_MSB:0] f1_op3_exp = {5'b0,f1_op3_data[14:11],f1_op3_data[10] | (f1_op3_subnorm_hp)};
wire [52:0] f1_op1_frac = {~f1_op1_subnorm_hp,f1_op1_data[9:0],42'b0};
wire [52:0] f1_op2_frac = {~f1_op2_subnorm_hp,f1_op2_data[9:0],42'b0};
wire [52:0] f1_op3_frac = {~f1_op3_subnorm_hp,f1_op3_data[9:0],42'b0};
wire [105:MAC_LSB + 2] f1_mul_result = {{(MUL_MSB - MUL_LSB + 1){1'b0}},f1_op1_frac[MUL_MSB:MUL_LSB]} * {{(MUL_MSB - MUL_LSB + 1){1'b0}},f1_op2_frac[MUL_MSB:MUL_LSB]};
reg  [105:MAC_LSB + 2] f2_mul_result;
wire [105:MAC_LSB + 2] f2_mul_result_nx = f1_mul_result;
wire unused3;
wire unused4;
wire [EXP_MSB:0] f1_abs_csa_sum;
wire [EXP_MSB:0] f1_abs_csa_cout;
kv_csa3_2 #(
    .CSA_WIDTH(EXP_MSB + 2)
) f1_abs_csa (
    .in0({f1_op3_exp[EXP_MSB],f1_op3_exp}),
    .in1(~{f1_op1_exp[EXP_MSB],f1_op1_exp}),
    .cin(~{f1_op2_exp[EXP_MSB],f1_op2_exp}),
    .sum({unused3,f1_abs_csa_sum[EXP_MSB:0]}),
    .cout({unused4,f1_abs_csa_cout[EXP_MSB:0]})
);
wire [EXP_MSB:0] f1_op1_exp_no_bias = f1_op1_exp - (10'd15 & {10{~f1_op1_is_zero}});
wire [EXP_MSB:0] f1_op2_exp_no_bias = f1_op2_exp - (10'd15 & {10{~f1_op2_is_zero}});
wire [EXP_MSB:0] f1_op3_exp_no_bias = f1_op3_exp - (10'd15 & {10{~f1_op3_is_zero}});
wire [EXP_MSB:0] f1_mul_exp_no_bias = f1_op1_exp_no_bias + f1_op2_exp_no_bias;
wire f1_mul_is_zero = f1_op1_is_zero | f1_op2_is_zero;
// f1_mac_align_diff needs add 2'd2 because ~f1_op1_exp and ~f1_op2_exp are 1's complement
// add 2'd2 to become 2's complement
// f1_align_diff needs add 10'd15 because f1_op1_exp, f2_op2_exp and f3_op_exp are based on bias but the diff need to compute wihtout bias
//   (f1_op3_exp             ) - (f1_op1_exp             ) - (f1_op2_exp             )
// = (f1_op3_exp_no_bias + 15) - (f1_op1_exp_no_bias + 15) - (f1_op2_exp_no_bias + 15)
// = f1_op3_exp_no_bias - f1_op1_exp_no_bias - f1_op2_exp_no_bias - 15
// => f3_op_exp - f1_op1_exp - f1_op2_exp = f1_op3_exp_no_bias - f1_op1_exp_no_bias - f1_op2_exp_no_bias - 15
// => f3_op_exp - f1_op1_exp - f1_op2_exp + 15 = f1_op3_exp_no_bias - f1_op1_exp_no_bias - f1_op2_exp_no_bias
wire [EXP_MSB:0] f1_mac_align_diff = {f1_abs_csa_cout[EXP_MSB - 1:0],1'b1} + f1_abs_csa_sum[EXP_MSB:0] + 10'd1; // if both op12 and op3 is not zero, alignment shift amount need to be compute
wire [EXP_MSB:0] f1_align_diff = (f1_mul_is_zero | f1_op3_is_zero) ? 10'b0 : // if op12 or op3 is zero, alignment shift amount can be stall
                                                                     f1_mac_align_diff + 10'd15;
wire [EXP_MSB:0] f1_abs_amount = 10'd14 - f1_align_diff; // convert from exp_with_no_bias differnce to mac format
wire f1_abs_no_right_shift = f1_abs_amount[EXP_MSB]; // for mac format
wire f1_mul_exp_bigger = f1_align_diff[9]; // for exp_with_no_bias difference
// if op3 is zero: mac_exp = f1_mul_exp_no_bias + 14
// if op12_exp_no_bias gt op3_exp_no_bias and op12 is not zero: mac_exp = f1_mul_exp_no_bias + 14
// if op12 is zero: mac_exp = f1_op3_exp_no_bias + f1_abs_amount
// if op3_exp_no_bias gt op12_exp_no_bias: mac_exp = f1_op3_exp_no_bias + f1_abs_amount
// if f1_abs_amount = "negative", f1_abs_amount = 0 (P.S: f1_abs_amount must be >=0 because op3 can only right shift)
wire f1_mac_exp_sel_mul = (f1_mul_exp_bigger & ~f1_mul_is_zero) | f1_op3_is_zero;
//wire f1_mac_exp_sel_mul = f1_mul_exp_bigger ? ~f1_mul_is_zero : f1_op3_is_zero;
wire [EXP_MSB:0] f2_mac_exp_op1_nx = f1_mac_exp_sel_mul ? f1_mul_exp_no_bias : f1_op3_exp_no_bias;
wire [EXP_MSB:0] f2_mac_exp_op2_nx = f1_mac_exp_sel_mul ? 10'd14 : (f1_abs_amount & {10{~f1_abs_no_right_shift}});
//{{{ op3 operand right shift alignment and op3 sticky right shift alignment
// op3 operand only shift right
// if op3 operand has left and it means that op3 became the "reference point" and the reference point means to be stall
wire [MAC_MSB:MAC_LSB] f1_pre_lsh_frac = {1'b0,f1_op3_frac[52:42],26'b0} ^ {MAC_WIDTH{f1_eff_sub}}; // op3 1's complement
wire [MAC_MSB:MAC_LSB] f1_abs_l0 = f1_pre_lsh_frac;
wire [MAC_MSB:MAC_LSB] f1_abs_l1 = (~f1_abs_no_right_shift & f1_abs_amount[5]) ? {{32{f1_eff_sub}},f1_abs_l0[MAC_MSB:(MAC_LSB + 32)]} : f1_abs_l0;
wire [MAC_MSB:MAC_LSB] f1_abs_l2 = (~f1_abs_no_right_shift & f1_abs_amount[4]) ? {{16{f1_eff_sub}},f1_abs_l1[MAC_MSB:(MAC_LSB + 16)]} : f1_abs_l1;
wire [MAC_MSB:MAC_LSB] f1_abs_l3 = (~f1_abs_no_right_shift & f1_abs_amount[3]) ? {{8{f1_eff_sub}},f1_abs_l2[MAC_MSB:(MAC_LSB + 8)]} : f1_abs_l2;
wire [MAC_MSB:MAC_LSB] f1_abs_l4 = (~f1_abs_no_right_shift & f1_abs_amount[2]) ? {{4{f1_eff_sub}},f1_abs_l3[MAC_MSB:(MAC_LSB + 4)]} : f1_abs_l3;
wire [MAC_MSB:MAC_LSB] f1_abs_l5 = (~f1_abs_no_right_shift & f1_abs_amount[1]) ? {{2{f1_eff_sub}},f1_abs_l4[MAC_MSB:(MAC_LSB + 2)]} : f1_abs_l4;
wire [MAC_MSB:MAC_LSB] f1_abs_l6 = (~f1_abs_no_right_shift & f1_abs_amount[0]) ? {{f1_eff_sub},f1_abs_l5[MAC_MSB:(MAC_LSB + 1)]} : f1_abs_l5;
wire [MAC_MSB:MAC_LSB] f2_abs_nx = f1_abs_l6;
wire f1_abs_sticky_l1 = ~f1_abs_no_right_shift & f1_abs_amount[5] & (|({32{f1_eff_sub}} ^ f1_abs_l0[(MAC_LSB + 31):MAC_LSB]));
wire f1_abs_sticky_l2 = ~f1_abs_no_right_shift & f1_abs_amount[4] & (|({16{f1_eff_sub}} ^ f1_abs_l1[(MAC_LSB + 15):MAC_LSB]));
wire f1_abs_sticky_l3 = ~f1_abs_no_right_shift & f1_abs_amount[3] & (|({8{f1_eff_sub}}  ^ f1_abs_l2[(MAC_LSB + 7):MAC_LSB]));
wire f1_abs_sticky_l4 = ~f1_abs_no_right_shift & f1_abs_amount[2] & (|({4{f1_eff_sub}}  ^ f1_abs_l3[(MAC_LSB + 3):MAC_LSB]));
wire f1_abs_sticky_l5 = ~f1_abs_no_right_shift & f1_abs_amount[1] & (|({2{f1_eff_sub}}  ^ f1_abs_l4[(MAC_LSB + 1):MAC_LSB]));
wire f1_abs_sticky_l6 = ~f1_abs_no_right_shift & f1_abs_amount[0] & ((f1_eff_sub        ^ f1_abs_l5[MAC_LSB]));
reg  [6:0] f2_abs_sticky_array;
wire [6:0] f2_abs_sticky_array_nx = {f1_abs_sticky_l1,
                                     f1_abs_sticky_l2,
                                     f1_abs_sticky_l3,
                                     f1_abs_sticky_l4,
                                     f1_abs_sticky_l5,
                                     f1_abs_sticky_l6};
//}}}
//{{{ LZA algirithm
wire f2_abs_sticky = |f2_abs_sticky_array;
wire f2_sub_and_no_sticky = ~f2_abs_sticky & f2_eff_sub;
wire [MAC_MSB:MAC_LSB] f2_mac_add_op1 = f2_abs;
wire [MAC_MSB:MAC_LSB] f2_mac_add_op2 = {{(((106 - MAC_LSB) / 2) + 2){1'b0}},f2_mul_result,2'b0};
wire [MAC_MSB:MAC_LSB] f2_ha_cout = (f2_mac_add_op2 & f2_mac_add_op1);
wire [MAC_MSB:MAC_LSB] f2_ha_cout_inv = ~(f2_mac_add_op2 | f2_mac_add_op1);
wire [MAC_MSB:MAC_LSB] f2_ha_sum = (f2_mac_add_op2 ^ f2_mac_add_op1);
wire [MAC_MSB:MAC_LSB] f2_pos_lza_result0 = {f2_ha_sum[MAC_MSB:MAC_LSB]};
wire [MAC_MSB:MAC_LSB] f2_pos_lza_result1 = {f2_ha_cout[MAC_MSB - 1:MAC_LSB],f2_sub_and_no_sticky};
wire [MAC_MSB:MAC_LSB] f2_neg_lza_result0 = {f2_ha_sum[MAC_MSB:MAC_LSB]};
wire [MAC_MSB:MAC_LSB] f2_neg_lza_result1 = {f2_ha_cout_inv[MAC_MSB - 1:MAC_LSB],1'b1};
wire [MAC_MSB:MAC_LSB] f2_pos_a_string = f2_pos_lza_result1 | f2_pos_lza_result0;
wire [MAC_MSB:MAC_LSB] f2_pos_p_string = f2_pos_lza_result1 ~^ f2_pos_lza_result0;
wire [MAC_MSB:MAC_LSB] f2_neg_a_string = f2_neg_lza_result1 | f2_neg_lza_result0;
wire [MAC_MSB:MAC_LSB] f2_neg_p_string = f2_neg_lza_result1 ~^ f2_neg_lza_result0;
// [1'b][37'b]
// [1'b][37'b]
//-------------
//      [37'b]
// ignore the MSB which in LZA AP algorithm means sign bit
// sign bit has to involve LZA AP algorithm but the result dose not encompass
wire [MAC_MSB-1:MAC_LSB] f2_pos_e_string = f2_pos_p_string[MAC_MSB:(MAC_LSB + 1)] & f2_pos_a_string[(MAC_MSB - 1):MAC_LSB];
wire [MAC_MSB-1:MAC_LSB] f2_neg_e_string = f2_neg_p_string[MAC_MSB:(MAC_LSB + 1)] & f2_neg_a_string[(MAC_MSB - 1):MAC_LSB];
// for FMA implementation with LZA AP algorithm
// the LSB result of LZA must be 1'b1 because the rounding may carry out when the sum is all zeor so we need to fix the exp in advance
wire [MAC_MSB-1:MAC_LSB] f2_pos_lza_string = {f2_pos_e_string[MAC_MSB-1:(MAC_LSB + 1)],1'b1};
wire [MAC_MSB-1:MAC_LSB] f2_neg_lza_string = {f2_neg_e_string[MAC_MSB-1:(MAC_LSB + 1)],1'b1};
wire [7:0] f2_pos_lzc;
wire [7:0] f2_neg_lzc;
assign f2_pos_lzc[7:6] = 2'b0;
assign f2_neg_lzc[7:6] = 2'b0;
kv_lzc_encode #(
    .WIDTH(64)
) lzc_encode_pos (
    .lza_str({f2_pos_lza_string,{ (64 - LZA_WIDTH){1'b0} }}),
    .lzc(f2_pos_lzc[5:0])
);
kv_lzc_encode #(
    .WIDTH(64)
) lzc_encode_neg (
    .lza_str({f2_neg_lza_string,{ (64 - LZA_WIDTH){1'b0} }}),
    .lzc(f2_neg_lzc[5:0])
);
// A + (B + b) < 0
// A < -B -b
// -B -b > A
// (~B) +1 -b > A
// (~B) + (~b) > A
// case1:
// (~B) > A
// case2:
// ((~B) == A) & (~b)
wire f2_complement = f2_eff_sub & ((~f2_mac_add_op1 > f2_mac_add_op2) | ((f2_mac_add_op1 == f2_mac_add_op2) & ~f2_abs_sticky));

wire [7:0] f2_lzc = f2_complement ? f2_neg_lzc : f2_pos_lzc;
wire [MAC_MSB:MAC_LSB] f2_mac_added_pos = f2_mac_add_op2 + f2_mac_add_op1 + {{(MAC_WIDTH - 1){1'b0}},f2_sub_and_no_sticky};
//wire [MAC_MSB:MAC_LSB] f2_mac_added_neg = f2_ha_sum + {f2_ha_cout_inv[MAC_MSB - 1:MAC_LSB],1'b1};
wire [MAC_MSB:MAC_LSB] f2_mac_added_neg = f2_ha_sum + {f2_ha_cout_inv[MAC_MSB - 1:MAC_LSB],1'b0} - f2_sub_and_no_sticky + 'd2;
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l0 = f2_complement ? f2_mac_added_neg : f2_mac_added_pos;
//}}}
//(WHY? f1_frd_inf)
wire f2_eff_sub_nx = f1_eff_sub & ~f1_frd_inf;
// f2_arth_sign_nx is f(op1 and op2) sign
wire f2_arith_sign_nx = f1_frd_zero ? f1_frd_zero_sign : f1_frd_inf ? f1_frd_inf_sign : f1_mul_sign;
//{{{ subnormal exp detect and adjust the left shift on normalization in subnormal condition
wire [EXP_MSB:0] f2_mac_exp = f2_mac_exp_op1 + f2_mac_exp_op2;
// if mac_exp -lzc < -14, it's subnormal
// mac_exp - lzc < -14
// lzc > macp_exp + 14
wire [EXP_MSB:0] f2_subnorm_bound = 10'd14;
wire [EXP_MSB:0] f2_lzc_subnorm_pred = f2_mac_exp + f2_subnorm_bound;
wire f2_lzc_sel_subnorm = {2'b0,f2_lzc} > f2_lzc_subnorm_pred;
wire f2_ovf_check_disable = f2_lzc_sel_subnorm;
// when it's subnormal, need to adjust the left shift on normalization in subnormal condition
// A' * 2 ** mac_exp transform to  A * 2 ** -15
// => mac_exp - left_shift = -15
// => left_shift = mac_exp + 15
// => A = A' << left_shift
// => A = A' << mac_exp + 14
// but the subnorm exp reference is changed
// => A = A' << mac_exp + 15 - 1
// => A = A' << mac_exp + 14
wire [7:0] f2_lzc_after_subnorm_pred = f2_lzc_sel_subnorm ? f2_lzc_subnorm_pred : f2_lzc;
//}}}
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l1 = f2_nbs_sum_l0;
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l2 = f2_lzc_after_subnorm_pred[5] ? {f2_nbs_sum_l1[(MAC_MSB - 32):MAC_LSB],32'b0} : f2_nbs_sum_l1;
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l3 = f2_lzc_after_subnorm_pred[4] ? {f2_nbs_sum_l2[(MAC_MSB - 16):MAC_LSB],16'b0} : f2_nbs_sum_l2;
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l4 = f2_lzc_after_subnorm_pred[3] ? {f2_nbs_sum_l3[(MAC_MSB - 8):MAC_LSB],8'b0} : f2_nbs_sum_l3;
wire [MAC_MSB:MAC_LSB] f2_nbs_sum_l5 = f2_lzc_after_subnorm_pred[2] ? {f2_nbs_sum_l4[(MAC_MSB - 4):MAC_LSB],4'b0} : f2_nbs_sum_l4;
wire [MAC_MSB:MAC_LSB] f3_nbs_sum_l6 = f3_lzc_after_subnorm_pred[1] ? {f3_nbs_sum_l5[(MAC_MSB - 2):MAC_LSB],2'b0} : f3_nbs_sum_l5;
wire [MAC_MSB:MAC_LSB] f3_nbs_sum_l7 = f3_lzc_after_subnorm_pred[0] ? {f3_nbs_sum_l6[(MAC_MSB - 1):MAC_LSB],1'b0} : f3_nbs_sum_l6;
// f3_arth_sign_nx is real result sign
wire f3_arith_sign_nx = f2_arith_sign ^ f2_complement;
wire [EXP_MSB:0] f3_mac_exp_nx = f2_mac_exp - {2'b0,f2_lzc};
reg [2:0] f2_round_mode;
wire f2_round_rne = (f2_round_mode == ROUND_RNE);
wire f2_round_rtz = (f2_round_mode == ROUND_RTZ);
wire f2_round_rdn = (f2_round_mode == ROUND_RDN);
wire f2_round_rup = (f2_round_mode == ROUND_RUP);
wire f2_round_rmm = (f2_round_mode == ROUND_RMM);
wire f2_rn = f2_round_rne | f2_round_rmm;
// to +inf: S==0 & round up; to -inf: S==1 & round down
wire f2_ri = (~f3_arith_sign_nx & f2_round_rup) | (f3_arith_sign_nx & f2_round_rdn);
// keep away +inf: S==0 & roudn down; keep away -inf: S==1 & round up; keep away +inf and -inf: round to zero
wire f2_rz = f2_round_rtz | (~f3_arith_sign_nx & f2_round_rdn) | (f3_arith_sign_nx & f2_round_rup);
//{{{ YZ algorithm
wire [MAC_MSB:111] f3_y0 = f3_nbs_sum_l7[MAC_MSB:111];
wire [MAC_MSB:111] f3_y1 = f3_nbs_sum_l7[MAC_MSB:111] + {{(MAC_MSB - 111){1'b0}},1'b1};
wire f3_carry = 1'b0;
wire f3_sticky     = f3_abs_sticky | (|f3_nbs_sum_l7[106:MAC_LSB]);
wire f3_sticky_ovf = f3_abs_sticky | (|f3_nbs_sum_l7[106:MAC_LSB]) | (f3_nbs_sum_l7[107] ^ f3_carry);
//=> wire f3_sticky_ovf = f3_abs_sticky | |f3_nbs_sum_l7[107:MAC_LSB];
wire [4:0] f3_round     = {1'b0, 3'b0, (f3_rn | f3_ri)}
                        + {1'b0, 3'b0, (f3_sticky & f3_ri)};
wire [4:0] f3_round_ovf = {1'b0, 2'b0, (f3_rn | f3_ri), 1'b0}
                        + {1'b0, 2'b0, (f3_sticky_ovf & f3_ri), 1'b0};
wire [4:0] f3_low_part = {1'b0,f3_nbs_sum_l7[110:107]};
wire [4:0] f3_low_part_round = {4'b0,f3_carry} + f3_low_part[4:0] + f3_round[4:0];
wire [4:0] f3_low_part_round_ovf = {4'b0,f3_carry} + f3_low_part[4:0] + f3_round_ovf[4:0];
// lze_error occur
// 1. Y[MSB] == 1
// 2. Y + rouding = Y_add_rounding
//    Y_add_rounding[MSB] == 1
wire f3_lza_error = (f3_y0[119] | (f3_low_part_round[4] & f3_y1[119])) & ~f3_ovf_check_disable;
wire [111:107] f3_z = f3_lza_error ? f3_low_part_round_ovf : f3_low_part_round;
wire f3_low_part_carry_to_y0 = f3_z[111]; // Z[MSB] has to carry to Y
wire [MAC_MSB:111] f3_y = f3_low_part_carry_to_y0 ? f3_y1 : f3_y0;
wire f3_tie_round_bit = f3_lza_error ? f3_low_part[1] : f3_low_part[0];
wire f3_tie_sticky_bit = f3_lza_error ? f3_sticky_ovf : f3_sticky;
wire f3_tie = f3_tie_round_bit & ~f3_tie_sticky_bit;
wire [(MAC_MSB - 1):108] f3_frac = f3_lza_error ? {f3_y[(MAC_MSB):111],f3_z[110:109]} : {f3_y[(MAC_MSB - 1):111],f3_z[110:108]};
wire [(MAC_MSB - 1):108] f3_frac_corrected;
assign f3_frac_corrected[108] = f3_frac[108] & ~(f3_tie & (f3_round_mode == ROUND_RNE));
assign f3_frac_corrected[(MAC_MSB - 1):109] = f3_frac[(MAC_MSB - 1):109];
//}}}
// mac_exp > 15 (over 16 is overflow)
// mac_exp > -15 (over -14 is normal)
//=> -mac_exp < 15
//=> ~mac_exp + 1 < 15
//=> ~mac_exp < 14
// mac_exp > -25 (over -24 is subnorm)
//=> -mac_exp < 25
//=> ~mac_exp + 1 < 25
//=> ~mac_exp < 24
wire f3_exp_p0_h_gt_ovf_bound = ~f3_mac_exp[9] & (f3_mac_exp[8:0] > 9'd15);
wire f3_exp_p0_h_gt_sub_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd14);
wire f3_exp_p0_h_gt_udf_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd24);
wire f3_exp_p1_h_gt_ovf_bound = ~f3_mac_exp[9] & (f3_mac_exp[8:0] > 9'd14);
wire f3_exp_p1_h_gt_sub_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd15);
wire f3_exp_p1_h_gt_udf_bound = ~f3_mac_exp[9] | (~f3_mac_exp[8:0] < 9'd25);
wire f3_exp_h_gt_ovf_bound = f3_lza_error ? f3_exp_p1_h_gt_ovf_bound : f3_exp_p0_h_gt_ovf_bound;
wire f3_exp_h_gt_sub_bound = f3_lza_error ? f3_exp_p1_h_gt_sub_bound : f3_exp_p0_h_gt_sub_bound;
wire f3_exp_h_gt_udf_bound = f3_lza_error ? f3_exp_p1_h_gt_udf_bound : f3_exp_p0_h_gt_udf_bound;
wire f3_exp_p0_sub_ubound = (f3_mac_exp == -10'd15);
wire f3_exp_p1_sub_ubound = (f3_mac_exp == -10'd14);
wire f3_exp_sub_ubound = f3_lza_error ? f3_exp_p1_sub_ubound : f3_exp_p0_sub_ubound;
// overflow predict detect
wire f3_hp_uf_exception = ~f3_exp_h_gt_udf_bound;
wire f3_hp_of_exception = f3_exp_h_gt_ovf_bound;
wire f3_of_exception = ~f3_frd_inf & ~f3_frd_nan & ~f3_frd_zero & f3_hp_of_exception;
// subnorm predict detect
// 1. detect regular subnorm
// 2. detect fake overflow
wire f3_hp_subnorm = ~f3_exp_h_gt_sub_bound & (f3_exp_h_gt_udf_bound | (|f3_frac_corrected[108 +:2]));
wire f3_subnorm = ~f3_frd_inf & ~f3_frd_zero & ~f3_frd_nan & f3_hp_subnorm;
// underflow predict detect
// 1. in subnormal
//      1.(O) or tie_round
//      2.(O) or tie_sitcky
//      3.(O) or tininess after rounding detect
//      4.(X) no subnormal to normal detect
// 2. in underflow
//      1.(O) or tie_round
//      2.(O) or tie_sticky
// tininess after rounding
wire [2:0] f3_round_bits_as_normal = {1'b0,f3_nbs_sum_l7[108:107]} + {2'b0,f3_carry} + {2'b0,(f3_ri & f3_sticky) | (f3_rn & f3_nbs_sum_l7[106])};
wire f3_subnorm_to_norm_uf = (f3_nbs_sum_l7[117:109] == 9'b111111111) & f3_exp_sub_ubound & ~f3_round_bits_as_normal[2];
wire f3_subnorm_to_normal = f3_frac_corrected[(MAC_MSB - 1)];
wire f3_frac_all_zero = ~(|f3_frac_corrected);
wire f3_uf_exception = ~f3_frd_inf & ~f3_frd_zero & ~f3_frd_nan &
                        // if mac_exp is subnorm, detect underflow condition
                       ((f3_hp_subnorm & (f3_tie_round_bit | f3_tie_sticky_bit) & (~f3_subnorm_to_normal | f3_subnorm_to_norm_uf)) |
                        // if mac_exp is underflow, detect underflow condition
                        (f3_hp_uf_exception & (f3_tie_round_bit | f3_tie_sticky_bit)));
//////////////////////////////////////////////////////
// uf_exception and subnorm may simultaneously rise
// it indicates that the underflow excecption is fake
//////////////////////////////////////////////////////
// zero
// 1.(X) no fp input operand nan
// 2.(X) no fp input operand inf
// 3.(O) or fp input operand zero
// 4.(O) or result zero
// 5.(O) or result underflow with RN/RZ but subnorm
wire f3_frd_result_zero = ~f3_frd_nan & ~f3_frd_inf & (f3_frd_zero | f3_frac_all_zero | (f3_uf_exception & ~f3_subnorm & (f3_rn | f3_rz)));
// smallest
// 1.(O) result underflow with RI but subnorm
wire f3_frd_result_smallest = f3_uf_exception & ~f3_subnorm & f3_ri;
// largest
// 1.(X) no fp input operand nan
// 2.(X) no fp input operand inf
// 3.(X) no fp input operand zero
// 4.(O) or result overflow with RZ
wire f3_frd_result_largest = f3_of_exception & f3_rz;
// inf
// 1.(X) no fp input operand nan
// 2.(X) no fp input operand zero
// 3.(O) or fp input operand inf
// 4.(O) or result overflow with RN/RI
wire f3_frd_result_inf = ~f3_frd_nan & ~f3_frd_zero & (f3_frd_inf | (f3_of_exception & (f3_rn | f3_ri)));
// nx
// 1.(X) no fp input operand nan
// 2.(X) no fp input operand zero
// 3.(X) no fp input operand inf
// 4.(O) or result overflow
// 5.(O) or result underflow
// 6.(O) or result tie_sticky
// 7.(O) or resutl tie_round
wire f3_nx_exception = ~f3_frd_nan & ~f3_frd_zero & ~f3_frd_inf & (f3_tie_round_bit | f3_tie_sticky_bit | f3_of_exception | f3_uf_exception);
// (WHY?)
wire f3_zero_sign = (f3_frac_all_zero & ~f3_tie_round_bit & ~f3_tie_sticky_bit & ~f3_frd_zero) ? (f3_round_mode == ROUND_RDN) : f3_arith_sign;
//{{{ output
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// if subnorm is "1", lza_error is always "0" (disable lza_error detect)
wire [EXP_MSB:0] f3_adjust_exp = f3_lza_error ? f3_mac_exp + 10'b1 : f3_mac_exp;
wire [EXP_MSB:0] f3_adjust_exp_bias = f3_subnorm ? {9'b0,f3_frac_corrected[(MAC_MSB - 1)]} : (f3_mac_exp + 10'd15 + {9'b0,f3_lza_error});
wire [31:0] f3_arith_wdata = {16'hffff,f3_arith_sign,f3_adjust_exp_bias[4:0],f3_frac_corrected[117:108]};
wire [31:0] f3_non_arith_wdata = ({32{f3_frd_nan}} & {16'hffff,1'b0,5'h1f,10'h200}) |
                                 ({32{f3_frd_result_inf}} & {16'hffff,f3_arith_sign,5'h1f,10'h0}) |
                                 ({32{f3_frd_result_zero}} & {16'hffff,f3_zero_sign,5'h00,10'h0}) |
                                 ({32{f3_frd_result_largest}} & {16'hffff,f3_arith_sign,5'h1e,10'h3ff}) |
                                 ({32{f3_frd_result_smallest}} & {16'hffff,f3_arith_sign,5'h00,10'h1});
wire f3_non_arith_wdata_en = f3_frd_result_inf |
                             f3_frd_result_zero |
                             f3_frd_nan |
                             f3_frd_result_largest |
                             f3_frd_result_smallest;
assign f3_flag_set = {(5){f3_valid}} & {f3_nv_exception,1'b0,f3_of_exception,f3_uf_exception,f3_nx_exception};
assign f3_wdata = f3_non_arith_wdata_en ? {32'hffffffff,f3_non_arith_wdata} : {32'hffffffff,f3_arith_wdata};
assign f3_wdata_en = f3_valid;
assign f3_result_type = f3_frd_scalar_fp ? 2'b11 : f3_frd_hp ? 2'b01 : 2'b10;
//}}}
always @(posedge aclk or negedge aresetn) begin
    if (!aresetn) begin
        f2_valid <= 1'b0;
        f3_valid <= 1'b0;
    end
    else if (~f3_stall) begin
        f2_valid <= f1_valid;
        f3_valid <= f2_valid;
    end
end

assign f2_pipe_en = f1_valid & ~f3_stall;
generate
    if (FLEN >= 32) begin:gen_frd_type_F32
        reg f2_frd_hp_r;
        reg f3_frd_hp_r;
        always @(posedge aclk or negedge aresetn) begin
            if (!aresetn) begin
                f2_frd_hp_r <= 1'b0;
            end
            else if (f2_pipe_en) begin
                f2_frd_hp_r <= f1_frd_hp;
            end
        end

        always @(posedge aclk or negedge aresetn) begin
            if (!aresetn) begin
                f3_frd_hp_r <= 1'b0;
            end
            else if (f3_pipe_en) begin
                f3_frd_hp_r <= f2_frd_hp;
            end
        end

        assign f2_frd_hp = f2_frd_hp_r;
        assign f2_frd_sp = ~f2_frd_hp_r;
        assign f3_frd_hp = f3_frd_hp_r;
        assign f3_frd_sp = ~f3_frd_hp_r;
    end
    else begin:gen_frd_type_F16
        assign f2_frd_hp = 1'b1;
        assign f2_frd_sp = 1'b0;
        assign f3_frd_hp = 1'b1;
        assign f3_frd_sp = 1'b0;
    end
endgenerate
always @(posedge aclk or negedge aresetn) begin
    if (!aresetn) begin
        f2_frd_scalar_fp <= 1'b0;
    end
    else if (f2_pipe_en) begin
        f2_frd_scalar_fp <= f1_frd_scalar_fp;
    end
end

always @(posedge aclk) begin
    if (f2_pipe_en) begin
        f2_frd_inf <= f1_frd_inf;
        f2_frd_zero <= f1_frd_zero;
        f2_frd_nan <= f1_frd_nan;
        f2_eff_sub <= f2_eff_sub_nx;
        f2_arith_sign <= f2_arith_sign_nx;
        f2_mac_exp_op1 <= f2_mac_exp_op1_nx;
        f2_mac_exp_op2 <= f2_mac_exp_op2_nx;
        f2_round_mode <= f1_round_mode;
        f2_nv_exception <= f1_nv_exception;
        f2_abs_sticky_array <= f2_abs_sticky_array_nx;
        f2_abs <= f2_abs_nx;
        f2_mul_result <= f2_mul_result_nx;
    end
end

assign f3_pipe_en = f2_valid & ~f3_stall;
always @(posedge aclk or negedge aresetn) begin
    if (!aresetn) begin
        f3_frd_scalar_fp <= 1'b0;
    end
    else if (f3_pipe_en) begin
        f3_frd_scalar_fp <= f2_frd_scalar_fp;
    end
end

always @(posedge aclk or negedge aresetn) begin
    if (!aresetn) begin
        f3_frd_inf <= 1'b0;
        f3_frd_zero <= 1'b0;
        f3_frd_nan <= 1'b0;
        f3_abs_sticky <= 1'b0;
        f3_arith_sign <= 1'b0;
        f3_mac_exp <= 10'b0;
        f3_round_mode <= 3'b0;
        f3_nv_exception <= 1'b0;
        f3_nbs_sum_l5 <= {MAC_WIDTH{1'b0}};
        f3_ovf_check_disable <= 1'b0;
        f3_lzc_after_subnorm_pred <= 2'b0;
        f3_round_rne <= 1'b0;
        f3_round_rdn <= 1'b0;
        f3_ri <= 1'b0;
        f3_rn <= 1'b0;
        f3_rz <= 1'b0;
    end
    else if (f3_pipe_en) begin
        f3_lzc_after_subnorm_pred <= f2_lzc_after_subnorm_pred[1:0];
        f3_frd_inf <= f2_frd_inf;
        f3_frd_zero <= f2_frd_zero;
        f3_frd_nan <= f2_frd_nan;
        f3_abs_sticky <= f2_abs_sticky;
        f3_arith_sign <= f3_arith_sign_nx;
        f3_mac_exp <= f3_mac_exp_nx;
        f3_round_mode <= f2_round_mode;
        f3_nv_exception <= f2_nv_exception;
        f3_nbs_sum_l5 <= f2_nbs_sum_l5;
        f3_ovf_check_disable <= f2_ovf_check_disable;
        f3_round_rne <= f2_round_rne;
        f3_round_rdn <= f2_round_rdn;
        f3_ri <= f2_ri;
        f3_rn <= f2_rn;
        f3_rz <= f2_rz;
    end
end

assign f3_redosum_masked = 1'b0;
assign f3_redosum_scalar = 32'b0;
endmodule
