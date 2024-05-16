module wenjieli_fp16(
     clk
    ,resetn
    ,fp16_i_ready
    ,fp16_i_valid
    ,fp16_i_op1
    ,fp16_i_op2
    ,fp16_i_op3
    ,fp16_i_ctrl
    ,fp16_i_round_mode
    ,fp16_o_valid
    ,fp16_o_ready
    ,fp16_o_flag
    ,fp16_o_frd
);
//  |->LZA_MSB(sign)                                                                                                                             |->LZA_LSB
//  |->MAC_MSB(ovf)                                          |->MUL_MSB                                                         MUL_LSB<-|       |->MAC_LSB
//  |                                                        |                                                                           |       |
// [35][34].[33][32][31][30][29][28][27][26][25][24][23][22][21][20].[19][18][17][16][15][14][13][12][11][10][9][8][7][6][5][4][3][2][1][0][-1][-2]
// [  ][11b                                        ][  ][  ][22b                                                                          ][  ][  ]
// [  ][   .                                       ][  ][  ][       .                                                                     ][  ][  ]
//         [14b                                                     ]
//
localparam FLEN = 16;
localparam FP16_FRAC_BITWIDTH = 10;
localparam FP16_EXP_BITWIDTH = 5;
localparam FRAC_MSB = FP16_FRAC_BITWIDTH;
// op1_exp + op2_exp + op3_exp + const => FP16_EXP_BITWIDTH + 2
localparam EXP_MSB = FP16_EXP_BITWIDTH+2-1;
localparam MAC_MSB = 3*(FP16_FRAC_BITWIDTH+1)+2;
localparam MAC_LSB = -2;
localparam MUL_MSB = 2*(FP16_FRAC_BITWIDTH+1)-1;

localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;

input             clk;
input             resetn;
input             fp16_i_valid;
output            fp16_i_ready;
input  [FLEN-1:0] fp16_i_op1;
input  [FLEN-1:0] fp16_i_op2;
input  [FLEN-1:0] fp16_i_op3;
input  [5:0]      fp16_i_ctrl;
input  [2:0]      fp16_i_round_mode;
output            fp16_o_valid;
input             fp16_o_ready;
output [4:0]      fp16_o_flag;
output [FLEN-1:0] fp16_o_frd;
wire f0_ready;

wire f0_valid = fp16_i_valid;
assign fp16_i_ready = f0_ready;
// {{{ IEEE-754 format decoding
wire [5:0] f0_round_mode = fp16_i_round_mode;
wire f0_fadd_instr   = (fp16_i_ctrl[4:0] == 5'b01100); // op1 * op2 + op3
wire f0_fsub_instr   = (fp16_i_ctrl[4:0] == 5'b01101); // op1 * op2 - op3
wire f0_fmadd_instr  = (fp16_i_ctrl[4:0] == 5'b01000); // op1 * op2 + op3
wire f0_fmsub_instr  = (fp16_i_ctrl[4:0] == 5'b01010); // op1 * op2 - op3
wire f0_fnmadd_instr = (fp16_i_ctrl[4:0] == 5'b01001); // -(op1 * op2) + op3
wire f0_fnmsub_instr = (fp16_i_ctrl[4:0] == 5'b01011); // -(op1 * op2) - op3
wire f0_fmul_instr   = (fp16_i_ctrl[4:0] == 5'b01110); // op1 * op2 + op3
wire f0_add_instr = f0_fadd_instr;
wire f0_sub_instr = f0_fsub_instr;
wire f0_mul_instr = f0_fmul_instr;
wire f0_madd_instr = f0_fmadd_instr | f0_add_instr | f0_mul_instr;
wire f0_msub_instr = f0_fmsub_instr | f0_sub_instr;
wire f0_nmadd_instr = f0_fnmadd_instr;
wire f0_nmsub_instr = f0_fnmsub_instr;
wire [FP16_FRAC_BITWIDTH-1:0] fp16_i_op1_frac = fp16_i_op1[0 +:FP16_FRAC_BITWIDTH];
wire [FP16_FRAC_BITWIDTH-1:0] fp16_i_op2_frac = fp16_i_op2[0 +:FP16_FRAC_BITWIDTH];
wire [FP16_FRAC_BITWIDTH-1:0] fp16_i_op3_frac = fp16_i_op3[0 +:FP16_FRAC_BITWIDTH];
wire [FP16_EXP_BITWIDTH-1:0] fp16_i_op1_exp = fp16_i_op1[FP16_FRAC_BITWIDTH +:FP16_EXP_BITWIDTH];
wire [FP16_EXP_BITWIDTH-1:0] fp16_i_op2_exp = fp16_i_op2[FP16_FRAC_BITWIDTH +:FP16_EXP_BITWIDTH];
wire [FP16_EXP_BITWIDTH-1:0] fp16_i_op3_exp = fp16_i_op3[FP16_FRAC_BITWIDTH +:FP16_EXP_BITWIDTH];
wire f0_op1_sign = fp16_i_op1[FP16_FRAC_BITWIDTH+FP16_EXP_BITWIDTH];
wire f0_op2_sign = fp16_i_op2[FP16_FRAC_BITWIDTH+FP16_EXP_BITWIDTH];
wire f0_op3_sign = fp16_i_op3[FP16_FRAC_BITWIDTH+FP16_EXP_BITWIDTH];
wire f0_op1_signal_bit = fp16_i_op1[FP16_FRAC_BITWIDTH-1];
wire f0_op2_signal_bit = fp16_i_op2[FP16_FRAC_BITWIDTH-1];
wire f0_op3_signal_bit = fp16_i_op3[FP16_FRAC_BITWIDTH-1];
wire f0_is_op1_subnorm = fp16_i_op1_exp == {(FP16_FRAC_BITWIDTH){1'd0}};
wire f0_is_op2_subnorm = fp16_i_op2_exp == {(FP16_FRAC_BITWIDTH){1'd0}};
wire f0_is_op3_subnorm = fp16_i_op3_exp == {(FP16_FRAC_BITWIDTH){1'd0}};
wire [EXP_MSB:0] f0_op1_exp = f0_is_op1_subnorm ? {{(EXP_MSB){1'd0}},1'd1} : {2'd0,fp16_i_op1_exp};
wire [EXP_MSB:0] f0_op2_exp = f0_is_op2_subnorm ? {{(EXP_MSB){1'd0}},1'd1} : {2'd0,fp16_i_op2_exp};
wire [EXP_MSB:0] f0_op3_exp = f0_is_op3_subnorm ? {{(EXP_MSB){1'd0}},1'd1} : {2'd0,fp16_i_op3_exp};
wire [FRAC_MSB:0] f0_op1_frac = f0_is_op1_subnorm ? {1'd0,fp16_i_op1_frac} : {1'd1,fp16_i_op1_frac};
wire [FRAC_MSB:0] f0_op2_frac = f0_is_op2_subnorm ? {1'd0,fp16_i_op2_frac} : {1'd1,fp16_i_op2_frac};
wire [FRAC_MSB:0] f0_op3_frac = f0_is_op3_subnorm ? {1'd0,fp16_i_op3_frac} : {1'd1,fp16_i_op3_frac};
wire [MUL_MSB:0] f0_mul = {{(MUL_MSB+1-(FRAC_MSB+1)){1'd0}},f0_op1_frac} * {{(MUL_MSB+1-(FRAC_MSB+1)){1'd0}},f0_op2_frac};
// }}}
// {{{ fp16_op inf/zero/nan decoding
//-------------------------------------------------------------------------------------------------
// IEEE-754
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
//-------------------------------------------------------------------------------------------------
// RISC-V
// zero or subnormal
//
// [x][00000][0000000000]
// subnormal
// [x][00000][xxxxxxxxxx]
//            :at least one of these x bits must be 1
// nan
// [x][11111][xxxxxxxxxx]
//            snan
//            [x][11111][0xxxxxxxxx]
//                  Signaling NaN: signaling bit = 0
//                  input at least one of these x bits must be 1
//                  output sum we constraint with [x][11111][1000000000]
//                  must trigger nan exception
//            [x][11111][1xxxxxxxxx]
//                  Quiet     NaN: signaling bit = 1
//                  input at least one of these x bits must be 1
//                  output sum we constraint with [x][11111][1000000000]
// inf
// [x][11111][0000000000]
//-------------------------------------------------------------------------------------------------
wire f0_op1_exp_all1 = &fp16_i_op1_exp;
wire f0_op2_exp_all1 = &fp16_i_op2_exp;
wire f0_op3_exp_all1 = &fp16_i_op3_exp;
wire f0_op1_exp_all0 = ~(|fp16_i_op1_exp);
wire f0_op2_exp_all0 = ~(|fp16_i_op2_exp);
wire f0_op3_exp_all0 = ~(|fp16_i_op3_exp);
wire f0_op1_frac_all0 = ~(|fp16_i_op1_frac);
wire f0_op2_frac_all0 = ~(|fp16_i_op2_frac);
wire f0_op3_frac_all0 = ~(|fp16_i_op3_frac);
wire f0_is_op1_inf = f0_op1_exp_all1 & f0_op1_frac_all0;
wire f0_is_op2_inf = f0_op2_exp_all1 & f0_op2_frac_all0;
wire f0_is_op3_inf = f0_op3_exp_all1 & f0_op3_frac_all0;
wire f0_is_op1_zero = f0_op1_exp_all0 & f0_op1_frac_all0;
wire f0_is_op2_zero = f0_op2_exp_all0 & f0_op2_frac_all0;
wire f0_is_op3_zero = f0_op3_exp_all0 & f0_op3_frac_all0;
wire f0_is_op1_nan = f0_op1_exp_all1 & ~f0_op1_frac_all0;
wire f0_is_op2_nan = f0_op2_exp_all1 & ~f0_op2_frac_all0;
wire f0_is_op3_nan = f0_op3_exp_all1 & ~f0_op3_frac_all0;
wire f0_is_op1_snan = f0_is_op1_nan & ~f0_op1_signal_bit;
wire f0_is_op2_snan = f0_is_op2_nan & ~f0_op2_signal_bit;
wire f0_is_op3_snan = f0_is_op3_nan & ~f0_op3_signal_bit;
// }}}
// {{{ 1st_frd inf/zero/nan/sign decoding
//-------------------------------------------------------------------------------------------------
// RISC-V
// multiply sign bit
//      section 6.3 "when neither the input or result are nan, the sign of a product
//                   ... is the xor of the operands' sign
// last_frd nan detect
//      detect in 1st stage
//          1. nan = one of the operation is a nan
//          2. nan = (+-inf) + (-+inf)
//          3. nan = (+-inf) * (+-0)
// last_frd inf detect
//      detect in 1st stage
//          1. inf = (+-inf) * (wihtout +-0)
// last_frd zero detect
//      detect in 1st stage
//          1. (+0) = (+0) + (+0)
//          2. (-0) = (-0) + (-0)
//          3. (+-0) + (-+0)
//              1. RDN: (-0)
//              2. others: (+0)
//      detect in last stage
//          if (the result is exacutly zero (frd_rne_corrected == 0 & R=0 & S=0 & 1st_frd != 0) )
//              1. RDN: (-0)
//              2. others: (+0)
//-------------------------------------------------------------------------------------------------
wire f0_is_mul_to_nan = (f0_is_op1_nan | f0_is_op2_nan) |
                        (f0_is_op1_inf & f0_is_op2_zero) |
                        (f0_is_op2_inf & f0_is_op1_zero);
wire f0_is_mul_to_inf = (f0_is_op1_inf & ~(f0_is_op2_nan | f0_is_op2_zero)) |
                         (f0_is_op2_inf & ~(f0_is_op1_nan | f0_is_op1_zero));
wire f0_is_mul_to_zero = (f0_is_op1_zero & ~(f0_is_op2_nan | f0_is_op2_inf)) |
                         (f0_is_op2_zero & ~(f0_is_op1_nan | f0_is_op1_inf));

wire f0_mul_arith_sign = f0_op1_sign ^ f0_op2_sign ^ (f0_nmadd_instr | f0_nmsub_instr);
wire f0_eff_sub = f0_mul_arith_sign ^ f0_op3_sign ^ (f0_msub_instr | f0_nmadd_instr);

wire f0_is_frd_zero = f0_is_mul_to_zero & f0_is_op3_zero;
wire f0_is_frd_inf = (f0_is_mul_to_inf & ~(f0_is_op3_nan | (f0_is_op3_inf & f0_eff_sub))) |
                     (f0_is_op3_inf & ~(f0_is_mul_to_nan | (f0_is_mul_to_inf & f0_eff_sub)));
wire f0_is_frd_nan = (f0_is_mul_to_nan | f0_is_op3_nan) |
                     (f0_is_mul_to_inf & f0_is_op3_inf & f0_eff_sub);
// trigger nan exception
wire f0_is_mul_to_exception_nan = (f0_is_op1_snan | f0_is_op2_snan) |
                                  (f0_is_op1_inf & f0_is_op2_zero) |
                                  (f0_is_op2_inf & f0_is_op1_zero);
wire f0_is_frd_exception_nan = (f0_is_mul_to_exception_nan | f0_is_op3_snan) |
                               (f0_is_mul_to_inf & f0_is_op3_inf & f0_eff_sub);
// special sign information
wire f0_frd_zero_arith_sign = (f0_mul_instr & f0_mul_arith_sign) |
                              (f0_madd_instr & f0_mul_arith_sign & f0_op3_sign) |
                              (f0_nmadd_instr & f0_mul_arith_sign & ~f0_op3_sign) |
                              (f0_msub_instr & f0_mul_arith_sign & ~f0_op3_sign) |
                              (f0_nmsub_instr & f0_mul_arith_sign & f0_op3_sign) |
                              (f0_eff_sub & (f0_round_mode == ROUND_RDN));
wire f0_frd_inf_arith_sign = (f0_madd_instr & (f0_is_op3_inf ? f0_op3_sign : f0_mul_arith_sign)) |
                             (f0_nmadd_instr & (f0_is_op3_inf ? ~f0_op3_sign : f0_mul_arith_sign)) |
                             (f0_msub_instr & (f0_is_op3_inf ? ~f0_op3_sign : f0_mul_arith_sign)) |
                             (f0_nmsub_instr & (f0_is_op3_inf ? f0_op3_sign : f0_mul_arith_sign));
// }}}
// {{{ mac_exp / op3_r
//--------------------------------------------------------------------------------------------------------------------------------------
wire [EXP_MSB:0] unused_f0_op1_no_bias_exp = f0_is_op1_zero ? {(EXP_MSB){1'd0}} : f0_op1_exp - {{(EXP_MSB+1-4){1'd0}},4'd15};
wire [EXP_MSB:0] unused_f0_op2_no_bias_exp = f0_is_op2_zero ? {(EXP_MSB){1'd0}} : f0_op2_exp - {{(EXP_MSB+1-4){1'd0}},4'd15};
wire [EXP_MSB:0] unused_f0_op3_no_bias_exp = f0_is_op3_zero ? {(EXP_MSB){1'd0}} : f0_op3_exp - {{(EXP_MSB+1-4){1'd0}},4'd15};
//---------------------------------------------------------------------------------------------------------------------
//         [14b                                                     ]
// [35][34].[33][32][31][30][29][28][27][26][25][24][23][22][21][20].[19][18][17][16][15][14][13][12][11][10][9][8][7][6][5][4][3][2][1][0][-1][-2]
// [  ][11b                                        ][  ][  ][22b                                                                          ][  ][  ]
//     [op3_exp region                                         ][mul_exp region                                                                   ]
//--------------------------------------------------------------------------------------------------------------------------------------
// condition                                   |  mac_exp                                          |  op3_r_amount                     |
//--------------------------------------------------------------------------------------------------------------------------------------
// is_op3_zero                                 |  op1_exp + op2_exp -16                            |  0                                |
// is_op1_zero | is_op2_zero                   |  op3_exp -15                                      |  0                                |
//      op1_exp + op2_exp -op3_exp - 1 <  0    |  op3_exp -15                                      |  0                                |
// 0 <= op1_exp + op2_exp -op3_exp - 1 <= 14   |  op1_exp + op2_exp -16                            |  op1_exp + op2_exp -op3_exp - 1   |
//      op1_exp + op2_exp -op3_exp - 1 > 14    |  op1_exp + op2_exp -16                            |  op1_exp + op2_exp -op3_exp - 1   |
//--------------------------------------------------------------------------------------------------------------------------------------
// using cas4_2
// (op1_exp -15) + (op2_exp -15) - (op3_exp -15) + 14
// => op1_exp + op2_exp - op3_exp - 1
// => op1_exp + op2_exp + (~op3_exp)
localparam PARAM_RIGHT_SHIFT_AMOUNT_ADJUSTMENT = 0;
wire [EXP_MSB:0] f0_op3_right_shift_amount_adjustment = PARAM_RIGHT_SHIFT_AMOUNT_ADJUSTMENT[EXP_MSB:0];
wire [EXP_MSB+1:0] f0_op3_right_shift_amount_s;
wire [EXP_MSB:0] f0_op3_right_shift_amount_c;
acc_csa4to2 # (
    .CSA_WIDTH(EXP_MSB+1) // effective bitwidth is decided by the sum=in1+in2+in3+in4
) u_acc_csa4to2 (
     .in1   (f0_op1_exp                           )
    ,.in2   (f0_op2_exp                           )
    ,.in3   (~f0_op3_exp                          )
    ,.in4   (f0_op3_right_shift_amount_adjustment )
    ,.sum   (f0_op3_right_shift_amount_s          )
    ,.carry (f0_op3_right_shift_amount_c          )
);
wire [EXP_MSB:0] f0_op3_right_shift_amount = f0_op3_right_shift_amount_s[EXP_MSB:0] + {f0_op3_right_shift_amount_c[EXP_MSB-1:0] , 1'd0};
wire [EXP_MSB:0] f0_op3_no_bias_exp = f0_op3_exp - 'd15;
wire [EXP_MSB:0] f0_op3_no_bias_exp_add_right_shift_amount = f0_op1_exp + f0_op2_exp - 'd16;
// mac_exp
//---------------------------------------------------------------------------------------------------------------------
wire f0_sel_op3_no_bias_exp = f0_is_op1_zero | f0_is_op2_zero | (~f0_is_op3_zero & f0_op3_right_shift_amount[EXP_MSB]);
wire [EXP_MSB:0] f0_mac_exp = f0_sel_op3_no_bias_exp ? f0_op3_no_bias_exp : f0_op3_no_bias_exp_add_right_shift_amount;
// op3_r_amount
//---------------------------------------------------------------------------------------------------------------------
wire f0_is_op3_r_amount_zero = f0_is_op1_zero | f0_is_op2_zero | f0_is_op3_zero | f0_op3_right_shift_amount[EXP_MSB];
wire [EXP_MSB:0] f0_op3_r_amount = f0_is_op3_r_amount_zero ? {(EXP_MSB+1){1'd0}} : f0_op3_right_shift_amount;
// op3_r
//---------------------------------------------------------------------------------------------------------------------
wire [MAC_MSB:MAC_LSB] f0_op3_r0 = {1'd0,f0_op3_frac,{((MAC_MSB-MAC_LSB+1)-1-(FRAC_MSB+1)){1'd0}} } ^ {(MAC_MSB-MAC_LSB+1){f0_eff_sub}}; // op3 1's complement for f0_eff_sub
wire [MAC_MSB:MAC_LSB] f0_op3_r1 = f0_op3_r_amount[5] ? {{(32 >> 0){f0_eff_sub}},f0_op3_r0[MAC_MSB:MAC_LSB + (32 >> 0)]} : f0_op3_r0;
wire [MAC_MSB:MAC_LSB] f0_op3_r2 = f0_op3_r_amount[4] ? {{(32 >> 1){f0_eff_sub}},f0_op3_r1[MAC_MSB:MAC_LSB + (32 >> 1)]} : f0_op3_r1;
wire [MAC_MSB:MAC_LSB] f0_op3_r3 = f0_op3_r_amount[3] ? {{(32 >> 2){f0_eff_sub}},f0_op3_r2[MAC_MSB:MAC_LSB + (32 >> 2)]} : f0_op3_r2;
wire [MAC_MSB:MAC_LSB] f0_op3_r4 = f0_op3_r_amount[2] ? {{(32 >> 3){f0_eff_sub}},f0_op3_r3[MAC_MSB:MAC_LSB + (32 >> 3)]} : f0_op3_r3;
wire [MAC_MSB:MAC_LSB] f0_op3_r5 = f0_op3_r_amount[1] ? {{(32 >> 4){f0_eff_sub}},f0_op3_r4[MAC_MSB:MAC_LSB + (32 >> 4)]} : f0_op3_r4;
wire [MAC_MSB:MAC_LSB] f0_op3_r6 = f0_op3_r_amount[0] ? {{(32 >> 5){f0_eff_sub}},f0_op3_r5[MAC_MSB:MAC_LSB + (32 >> 5)]} : f0_op3_r5;
wire [MAC_MSB:MAC_LSB] f0_op3_r = f0_op3_r6;
// op3_sticky
//---------------------------------------------------------------------------------------------------------------------
wire [5:0] f0_op3_sticky_array;
// retreieve op3_frac to acquire op3_sticky
// f0_eff_sub ^ op3_r0
// => f0_eff_sub ^ (op3_frac ^ f0_eff_sub)
// => op3_frac
assign f0_op3_sticky_array[0] = f0_op3_r_amount[5] & (|({(32 >> 0){f0_eff_sub}} ^ f0_op3_r0[MAC_LSB +:(32 >> 0)]));
assign f0_op3_sticky_array[1] = f0_op3_r_amount[4] & (|({(32 >> 1){f0_eff_sub}} ^ f0_op3_r1[MAC_LSB +:(32 >> 1)]));
assign f0_op3_sticky_array[2] = f0_op3_r_amount[3] & (|({(32 >> 2){f0_eff_sub}} ^ f0_op3_r2[MAC_LSB +:(32 >> 2)]));
assign f0_op3_sticky_array[3] = f0_op3_r_amount[2] & (|({(32 >> 3){f0_eff_sub}} ^ f0_op3_r3[MAC_LSB +:(32 >> 3)]));
assign f0_op3_sticky_array[4] = f0_op3_r_amount[1] & (|({(32 >> 4){f0_eff_sub}} ^ f0_op3_r4[MAC_LSB +:(32 >> 4)]));
assign f0_op3_sticky_array[5] = f0_op3_r_amount[0] & (|({(32 >> 5){f0_eff_sub}} ^ f0_op3_r5[MAC_LSB +:(32 >> 5)]));
wire f0_op3_sticky = |f0_op3_sticky_array;
// }}}
reg f1_valid;
reg f1_is_frd_zero;
reg f1_is_frd_inf;
reg f1_is_frd_nan;
reg f1_is_frd_exception_nan;
reg [5:0] f1_round_mode;
reg f1_frd_zero_arith_sign;
reg f1_frd_inf_arith_sign;
reg f1_mul_arith_sign;
reg f1_eff_sub;
reg [EXP_MSB:0] f1_mac_exp;
reg f1_op3_sticky;
reg [MAC_MSB:MAC_LSB] f1_op3_r;
reg [MUL_MSB:0] f1_mul;
wire f1_ready;

wire f1_valid_set = f0_valid;
wire f1_valid_clr = f0_ready;
wire f1_valid_nx = f1_valid_set | (f1_valid & ~f1_valid_clr);
assign f0_ready = ~f1_valid | f1_ready;

always @ (posedge clk or negedge resetn) begin
    if (!resetn)
        f1_valid <= 1'd0;
    else
        f1_valid <= f1_valid_nx;
end

wire f1_en = f0_valid & f0_ready;
always @ (posedge clk) begin
    if (f1_en) begin
        f1_is_frd_zero <= f0_is_frd_zero;
        f1_is_frd_inf <= f0_is_frd_inf;
        f1_is_frd_nan <= f0_is_frd_nan;
        f1_is_frd_exception_nan <= f0_is_frd_exception_nan;
        f1_round_mode <= f0_round_mode;
        f1_frd_zero_arith_sign <= f0_frd_zero_arith_sign;
        f1_frd_inf_arith_sign <= f0_frd_inf_arith_sign;
        f1_mul_arith_sign <= f0_mul_arith_sign;
        f1_eff_sub <= f0_eff_sub;
        f1_mac_exp <= f0_mac_exp;
        f1_op3_sticky <= f0_op3_sticky;
        f1_op3_r <= f0_op3_r;
        f1_mul <= f0_mul;
    end
end
wire f1_eff_sub_and_sticky_all0 = f1_eff_sub & ~f1_op3_sticky;
wire [MAC_MSB:MAC_LSB] f1_mac_add_mul = {{((MAC_MSB-MAC_LSB+1)-(MUL_MSB+1)-2){1'd0}},f1_mul,2'd0};
wire [MAC_MSB:MAC_LSB] f1_mac_add_op3 = f1_op3_r;
// {{{ complement
// f1_complement is effective for futher "mac_sum" or "arith_sign" computation when only if (f1_is_frd_inf == 0 & f1_is_frd_zero == 0)
//---------------------------------------------------------------------------------------------------------------------
// A + (B + b) + sticky < 0; 0 <= sticky < 1; b == 0 or 1
// => A + (B + b) < 0
// Let f1_eff_sub = 1;
// => A(mul) is positive
// => B(op3) is negative
// => -B is positve
// case 1: b is 0
// => A + B < 0
// => A < ~B + 1
// case 2: b is 1
// => A + B + 1 < 0
// => A < -B -1
// => A < ~B
//
// case 1: b is 0
// => mul + op3 < 0
// => mul < ~op3 + 1
// case 2: b is 1
// => mul + op3 + 1 < 0
// => mul < -op3 -1
// => mul < ~op3
wire f1_complement = f1_eff_sub &
                    ((f1_mac_add_mul < ~f1_mac_add_op3) | ((f1_mac_add_mul == f1_mac_add_op3) & ~f1_eff_sub_and_sticky_all0));
// }}}
// {{{ lza / lzc
//---------------------------------------------------------------------------------------------------------------------
// lza(A + B + b), b is 1 bit variable
wire [MAC_MSB:MAC_LSB] f1_ha_s = f1_mac_add_mul ^ f1_mac_add_op3;
wire [MAC_MSB:MAC_LSB] f1_ha_c = {f1_mac_add_mul[MAC_MSB-1:MAC_LSB] & f1_mac_add_op3[MAC_MSB-1:MAC_LSB], f1_eff_sub_and_sticky_all0};
wire [MAC_MSB:MAC_LSB] f1_ha_cinv = {~f1_mac_add_mul[MAC_MSB:MAC_LSB] & ~f1_mac_add_op3[MAC_MSB:MAC_LSB],1'd1};
// ap algorithm for positive mac_sum
// ap_lza({A,b} + B) condition: {A,b} + B >= 0
//---------------------------------------------------------------------------------------------------------------------
wire [MAC_MSB:MAC_LSB] f1_a_str_pos = f1_ha_s |  f1_ha_c;
wire [MAC_MSB:MAC_LSB] f1_p_str_pos = f1_ha_s ~^ f1_ha_c;
wire [MAC_MSB:MAC_LSB] f1_lza_str_pos = {f1_p_str_pos[MAC_MSB:MAC_LSB+1] & f1_a_str_pos[MAC_MSB-1:MAC_LSB],1'd1};
// ap algorithm for negative mac_sum
// ap_lza({A,b} + B) condition: {A,b} + B < 0
//---------------------------------------------------------------------------------------------------------------------
// A + B + b = sum (sum is neg)
// (~A) + (~B) + 2 -b = sum' (sum' is pos)
// S + {Cinv,1'b1} +1 -b = sum'
// if b = 0
// S + {Cinv,1'b1} +1 = sum'
// if b = 1
// S + {Cinv,1'b1} = sum'
//
// conclusion: sum' will be 1 more than S + {Cinv,1'b1}
//--------------------------------------------------------------------------------------------------------------------------------------
// scenario |     sum'     | S + {Cinv,1'b1} |   lza(S + {Cinv,1'b1})  | assume lza worse case   | assume yx algirhtm worse case (+3)  |
//--------------------------------------------------------------------------------------------------------------------------------------
// zero     |   0000000    |     1111111     | failure                 | failure                 | failure                             |
// min      |   0000001    |     0000000     | must 1b ovf             | ovf  sum'_l = 10.00000  | 10.00011 (conform lza (no overflow) |
//          |   0000010    |     0000001     | must 1b ovf             | ovf  sum'_l = 10.00000  | 10.00011 (conform lza (no overflow) |
//          |   0000100    |     0000011     | must 1b ovf             | ovf  sum'_l = 10.00000  | 10.00011 (conform lza (no overflow) |
//          |   0001000    |     0000111     | must 1b ovf             | ovf  sum'_l = 10.00000  | 10.00011 (conform lza (no overflow) |
//          |   0010000    |     0001111     | must 1b ovf             | ovf  sum'_l = 10.00000  | 10.00011 (conform lza (no overflow) |
//          |   0100000    |     0011111     | must 1b ovf             | ovf  sum'_l = 10.00000  | 10.00011 (conform lza (no overflow) |
//          |   0000011    |     0000010     | may  1b ovf             | ovf  sum'_l = 11.00000  | 11.00011 (conform lza (no overflow) |
//          |   0000110    |     0000101     | may  1b ovf             | ovf  sum'_l = 11.00000  | 11.00011 (conform lza (no overflow) |
//          |   0001100    |     0001011     | may  1b ovf             | ovf  sum'_l = 11.00000  | 11.00011 (conform lza (no overflow) |
//          |   0011000    |     0010111     | may  1b ovf             | ovf  sum'_l = 11.00000  | 11.00011 (conform lza (no overflow) |
//          |   0110000    |     0101111     | may  1b ovf             | ovf  sum'_l = 11.00000  | 11.00011 (conform lza (no overflow) |
//          |   0000111    |     0000110     | must novf(must correct) | novf sum'_l = 01.11000  | 01.11011 (conform lza (no overflow) |
//          |   0001110    |     0001101     | must novf(must correct) | novf sum'_l = 01.11000  | 01.11011 (conform lza (no overflow) |
//          |   0011100    |     0011011     | must novf(must correct) | novf sum'_l = 01.11000  | 01.11011 (conform lza (no overflow) |
//          |   0111000    |     0110111     | must novf(must correct) | novf sum'_l = 01.11000  | 01.11011 (conform lza (no overflow) |
//          |   0111100    |     0111011     | must novf(must correct) | novf sum'_l = 01.11100  | 01.11111 (conform lza (no overflow) |
//          |   0111110    |     0111101     | must novf(must correct) | novf sum'_l = 01.11110  | 10.00001 (conform lza (no overflow) |
// max      |   0111111    |     0111110     | must novf(must correct) | novf sum'_l = 01.11111  | 10.00010 (conform lza (no overflow) |
//--------------------------------------------------------------------------------------------------------------------------------------
wire [MAC_MSB:MAC_LSB] f1_a_str_neg = f1_ha_s |  f1_ha_cinv;
wire [MAC_MSB:MAC_LSB] f1_p_str_neg = f1_ha_s ~^ f1_ha_cinv;
wire [MAC_MSB:MAC_LSB] f1_lza_str_neg = {f1_p_str_neg[MAC_MSB:MAC_LSB+1] & f1_a_str_neg[MAC_MSB-1:MAC_LSB],1'd1};
// lzc algorithm
//---------------------------------------------------------------------------------------------------------------------
wire [5:0] f1_lzc_pos;
wire [5:0] f1_lzc_neg;
wire [63:0] f1_lza_str_ext_pos = {f1_lza_str_pos,{(64-(MAC_MSB-MAC_LSB+1)){1'd0}} };
wire [63:0] f1_lza_str_ext_neg = {f1_lza_str_neg,{(64-(MAC_MSB-MAC_LSB+1)){1'd0}} };
kv_lzc_encode #(
     .WIDTH(64)
) u_kv_lzc_encode_pos (
     .lza_str (f1_lza_str_ext_pos )
    ,.lzc     (f1_lzc_pos         )
);
kv_lzc_encode #(
     .WIDTH(64)
) u_kv_lzc_encode_neg (
     .lza_str (f1_lza_str_ext_neg )
    ,.lzc     (f1_lzc_neg         )
);
wire [5:0] f1_lzc = f1_complement ? f1_lzc_neg : f1_lzc_pos;
//// ap algorithm
//// ap_lza({A,b} + B) condition: {A,b} + B >= 0
////---------------------------------------------------------------------------------------------------------------------
//wire [MAC_MSB:MAC_LSB] f1_eff_add_a_str = f1_ha_s |  f1_ha_c;
//wire [MAC_MSB:MAC_LSB] f1_eff_add_p_str = f1_ha_s ~^ f1_ha_c;
//wire [MAC_MSB:MAC_LSB] f1_eff_add_lza_str = {f1_eff_add_p_str[MAC_MSB:MAC_LSB+1] & f1_eff_add_a_str[MAC_MSB-1:MAC_LSB],1'd1};
//// egs algorithm
//// egs_lza({A,b} + B) condition: {A,b} is positive and B is negative
////---------------------------------------------------------------------------------------------------------------------
//wire [MAC_MSB:MAC_LSB] f1_eff_sub_e_str =  f1_ha_s ^  f1_ha_c;
//wire [MAC_MSB:MAC_LSB] f1_eff_sub_g_str = ~f1_ha_s & ~f1_ha_c;
//wire [MAC_MSB:MAC_LSB] f1_eff_sub_s_str =  f1_ha_s &  f1_ha_c;
//wire [MAC_MSB:MAC_LSB] f1_eff_sub_pos_str = ({1'd1,f1_eff_sub_e_str[MAC_MSB:MAC_LSB+1]} & f1_eff_sub_g_str[MAC_MSB:MAC_LSB] & {~f1_eff_sub_s_str[MAC_MSB-1:MAC_LSB],1'd1}) | ({1'd0,~f1_eff_sub_e_str[MAC_MSB:MAC_LSB+1]} & f1_eff_sub_s_str[MAC_MSB:MAC_LSB] & {~f1_eff_sub_s_str[MAC_MSB-1:MAC_LSB],1'd1});
//wire [MAC_MSB:MAC_LSB] f1_eff_sub_neg_str = ({1'd1,f1_eff_sub_e_str[MAC_MSB:MAC_LSB+1]} & f1_eff_sub_s_str[MAC_MSB:MAC_LSB] & {~f1_eff_sub_g_str[MAC_MSB-1:MAC_LSB],1'd1}) | ({1'd0,~f1_eff_sub_e_str[MAC_MSB:MAC_LSB+1]} & f1_eff_sub_g_str[MAC_MSB:MAC_LSB] & {~f1_eff_sub_g_str[MAC_MSB-1:MAC_LSB],1'd1});
//wire [MAC_MSB:MAC_LSB] f1_eff_sub_lza_str = f1_eff_sub_pos_str | f1_eff_sub_neg_str;
////---------------------------------------------------------------------------------------------------------------------
//wire [MAC_MSB:MAC_LSB] f1_lza_str = f1_eff_sub ? f1_eff_sub_lza_str : f1_eff_add_lza_str;
//// lzc algorithm
////---------------------------------------------------------------------------------------------------------------------
//wire [5:0] f1_lzc;
//wire [63:0] f1_lza_str_ext = {f1_lza_str,{ (64-(MAC_MSB-MAC_LSB+1)){1'd0} }};
//kv_lzc_encode #(
//     .WIDTH(64)
//) u_kv_lzc_encode (
//     .lza_str (f1_lza_str_ext )
//    ,.lzc     (f1_lzc         )
//);
//// }}}
// {{{ airth_sign
//--------------------------------------------------------------------------------------------------------------------------------------
// arithmetic sign is referred to mul arith sign
// if (f1_complement == 1) means arithmetic sign need to inverted
// if (f1_is_frd_inf == 1 | f1_is_frd_zero == 1) arithmetic sign compuation ignore f1_complement and compute arithmetic sign in special case
wire f1_arith_sign = f1_is_frd_zero ? f1_frd_zero_arith_sign :
                     f1_is_frd_inf  ? f1_frd_inf_arith_sign :
                                      f1_mul_arith_sign ^ f1_complement;
// }}}
// {{{ rz / rn / ri
//--------------------------------------------------------------------------------------------------------------------------------------
wire f1_round_rne = (f1_round_mode == ROUND_RNE);
wire f1_round_rtz = (f1_round_mode == ROUND_RTZ);
wire f1_round_rdn = (f1_round_mode == ROUND_RDN);
wire f1_round_rup = (f1_round_mode == ROUND_RUP);
wire f1_round_rmm = (f1_round_mode == ROUND_RMM);
wire f1_rn = f1_round_rne | f1_round_rmm;
wire f1_ri = (~f1_arith_sign & f1_round_rup) | (f1_arith_sign & f1_round_rdn);
wire f1_rz = f1_round_rtz | (~f1_arith_sign & f1_round_rdn) | (f1_arith_sign & f1_round_rup);
// }}}
// {{{ mac_sum
wire [MAC_MSB:MAC_LSB] f1_mac_sum_pos = f1_ha_s + f1_ha_c;
wire [MAC_MSB:MAC_LSB] f1_mac_sum_neg = f1_ha_s + f1_ha_cinv;
wire [MAC_MSB:MAC_LSB] f1_mac_sum = f1_complement ? f1_mac_sum_neg : f1_mac_sum_pos;
// }}}
// {{{ arith_exp / subnorm detect
//--------------------------------------------------------------------------------------------------------------------------------------
// condition                                   |  arith_exp                                        |  mac_sum_l_amount                 |
//--------------------------------------------------------------------------------------------------------------------------------------
// mac_exp - lzc >= -14 (normal)               |  mac_exp - lzc                                    |  lzc                              |
// mac_exp - lzc < -14  (subnormal)            |  mac_exp - lzc                                    |  mac_exp + 14                     |
//--------------------------------------------------------------------------------------------------------------------------------------
wire [EXP_MSB:0] f1_arith_exp = f1_mac_exp - {1'b0,f1_lzc};
// float point 16 minimal exp is -14
// mac_exp - lzc < -14
// => lzc > mac_exp + 14
//
// case: normal
//      mac_sum_l_amount = lzc
// case: subnormal
//      mac_exp - mac_sum_l_amount = -14
//      => mac_sum_l_amount = mac_exp + 14
localparam ABS_FP16_EXP_MIN = 14;

wire [EXP_MSB:0] f1_mac_exp_sub_min_fp_exp = f1_mac_exp + ABS_FP16_EXP_MIN[EXP_MSB:0];
wire f1_sel_mac_sum_l_amount_subnormal = {1'b0,f1_lzc} > f1_mac_exp_sub_min_fp_exp;

wire [5:0] f1_mac_sum_l_amount_subnormal = f1_mac_exp_sub_min_fp_exp;
wire [5:0] f1_mac_sum_l_amount_normal = f1_lzc;
wire [5:0] f1_mac_sum_l_amount = f1_sel_mac_sum_l_amount_subnormal ? f1_mac_sum_l_amount_subnormal : f1_mac_sum_l_amount_normal;
// }}}
// {{{ mac_sum_l
//--------------------------------------------------------------------------------------------------------------------------------------
wire [MAC_MSB:MAC_LSB] f1_mac_sum_l0 = f1_mac_sum;
wire [MAC_MSB:MAC_LSB] f1_mac_sum_l1 = f1_mac_sum_l_amount[5] ? {f1_mac_sum_l0[(MAC_MSB - (32 >> 0)):MAC_LSB],{(32 >> 0){1'd0}} } : f1_mac_sum_l0;
wire [MAC_MSB:MAC_LSB] f1_mac_sum_l2 = f1_mac_sum_l_amount[4] ? {f1_mac_sum_l1[(MAC_MSB - (32 >> 1)):MAC_LSB],{(32 >> 1){1'd0}} } : f1_mac_sum_l1;
wire [MAC_MSB:MAC_LSB] f1_mac_sum_l3 = f1_mac_sum_l_amount[3] ? {f1_mac_sum_l2[(MAC_MSB - (32 >> 2)):MAC_LSB],{(32 >> 2){1'd0}} } : f1_mac_sum_l2;
wire [MAC_MSB:MAC_LSB] f1_mac_sum_l4 = f1_mac_sum_l_amount[2] ? {f1_mac_sum_l3[(MAC_MSB - (32 >> 3)):MAC_LSB],{(32 >> 3){1'd0}} } : f1_mac_sum_l3;
wire [MAC_MSB:MAC_LSB] f1_mac_sum_l5 = f1_mac_sum_l_amount[1] ? {f1_mac_sum_l4[(MAC_MSB - (32 >> 4)):MAC_LSB],{(32 >> 4){1'd0}} } : f1_mac_sum_l4;
wire [MAC_MSB:MAC_LSB] f1_mac_sum_l6 = f1_mac_sum_l_amount[0] ? {f1_mac_sum_l5[(MAC_MSB - (32 >> 5)):MAC_LSB],{(32 >> 5){1'd0}} } : f1_mac_sum_l5;
wire [MAC_MSB:MAC_LSB] f1_mac_sum_l = f1_mac_sum_l6;
// }}}
reg f2_valid;
reg f2_is_frd_zero;
reg f2_is_frd_inf;
reg f2_is_frd_nan;
reg f2_is_frd_exception_nan;
reg [5:0] f2_round_mode;
reg f2_op3_stikcy;
reg f2_arith_sign;
reg f2_ri;
reg f2_rn;
reg f2_rz;
reg [EXP_MSB:0] f2_arith_exp;
reg [MAC_MSB:MAC_LSB] f2_mac_sum_l;
wire f2_ready;

wire f2_valid_set = f1_valid;
wire f2_valid_clr = f1_ready;
wire f2_valid_nx = f2_valid_set | (f2_valid & ~f2_valid_clr);
assign f1_ready = ~f2_valid | f2_ready;
always @ (posedge clk or negedge resetn) begin
    if (!resetn)
        f2_valid <= 1'd0;
    else
        f2_valid <= f2_valid_nx;
end

wire f2_en = f1_valid & f1_ready;
always @ (posedge clk) begin
    if(f2_en) begin
        f2_is_frd_zero <= f1_is_frd_zero;
        f2_is_frd_inf <= f1_is_frd_inf;
        f2_is_frd_nan <= f1_is_frd_nan;
        f2_is_frd_exception_nan <= f1_is_frd_exception_nan;
        f2_round_mode <= f1_round_mode;
        f2_op3_stikcy <= f1_op3_sticky;
        f2_arith_sign <= f1_arith_sign;
        f2_ri <= f1_ri;
        f2_rn <= f1_rn;
        f2_rz <= f1_rz;
        f2_arith_exp <= f1_arith_exp;
        f2_mac_sum_l <= f1_mac_sum_l;
    end
end
// {{{ yz algorithm
//---------------------------------------------------------------------------------------------------------------------
// [35][34].[33][32][31][30][29][28][27][26][25][24][23][22][21][20].[19][18][17][16][15][14][13][12][11][10][9][8][7][6][5][4][3][2][1][0][-1][-2]
// [  ][                                           ][  ][  ][                                                                             ][  ][  ]
// [mslice = y                             ][cslice    ][lslice                                                                                   ]
//---------------------------------------------------------------------------------------------------------------------
// when normal detected can be novf or ovf
// ovf                                  [C ][L ][R ][  ]
// novf                                 [C ][  ][L ][R ]
//                                      [z             ]
//---------------------------------------------------------------------------------------------------------------------
// when subnormal detected only can be novf
// novf                                 [C ][  ][L ][R ]
//                                      [z             ]
//---------------------------------------------------------------------------------------------------------------------
wire [MAC_MSB:26] f2_mslice = f2_mac_sum_l[MAC_MSB:26];
wire [25:23]      f2_cslice = f2_mac_sum_l[25:23];
wire [22:MAC_LSB] f2_lslice = f2_mac_sum_l[22:MAC_LSB];

wire [MAC_MSB:26] f2_y0 = f2_mslice;
wire [MAC_MSB:26] f2_y1 = f2_mslice + {{(MAC_MSB-26+1){1'd0}},1'd1};

wire unused_f2_sticky_novf = (|f2_mac_sum_l[22:MAC_LSB]) | f2_op3_stikcy;
wire unused_f2_sticky_ovf  = (|f2_mac_sum_l[23:MAC_LSB]) | f2_op3_stikcy;

wire f2_lslice_carry = 0;
wire f2_sticky_novf =                                     (|f2_lslice) | f2_op3_stikcy;
wire f2_sticky_ovf  = (f2_cslice[23] ^ f2_lslice_carry) | (|f2_lslice) | f2_op3_stikcy;

wire [26:23] f2_z_novf = f2_cslice +
                         {3'd0,f2_lslice_carry} +
                         {3'd0,(f2_rn | f2_ri)} +
                         {3'd0,(f2_ri & f2_sticky_novf)};

wire unused_f2_is_ovf = (f2_y0[MAC_MSB] | ((&f2_y0) & f2_z_novf[26]));
// (&f2_y0) & f2_z_novf[3]
// => f2_y1[MAC_MSB] & f2_z_novf[3]
wire f2_is_ovf = (f2_y0[MAC_MSB] | (f2_y1[MAC_MSB] & f2_z_novf[26]));

wire [26:23] f2_z_ovf  = f2_cslice +
                         {3'd0,f2_lslice_carry} +
                         {2'd0,(f2_rn | f2_ri),1'd0} +
                         {2'd0,(f2_ri & f2_sticky_ovf),1'd0};

wire [26:23] f2_z = f2_is_ovf ? f2_z_ovf : f2_z_novf;

wire f2_z_carry_to_y0 = f2_z[26];
wire [MAC_MSB:26] f2_y = f2_z_carry_to_y0 ? f2_y1 : f2_y0;

wire [MAC_MSB:24+1] f2_frd_ovf  = {f2_y[MAC_MSB:26],f2_z[25]};
wire [MAC_MSB-1:24] f2_frd_novf = {f2_y[MAC_MSB-1:26],f2_z[25:24]};
wire [MAC_MSB-1:24] f2_frd = f2_is_ovf ? f2_frd_ovf : f2_frd_novf;

wire unused_f2_before_rounding_r_bit = f2_is_ovf ? f2_cslice[24] : f2_cslice[23];
wire f2_before_rounding_r_bit_novf = f2_cslice[23] ^ f2_lslice_carry;
wire f2_before_rounding_r_bit_ovf = f2_cslice[24] ^ (f2_cslice[23] & f2_lslice_carry);
wire f2_before_rounding_r_bit = f2_is_ovf ? f2_before_rounding_r_bit_ovf : f2_before_rounding_r_bit_novf;
wire f2_before_rounding_s_bit = f2_is_ovf ? f2_sticky_ovf : f2_sticky_novf;

wire [MAC_MSB-1:24] frd_rne_correction;
assign frd_rne_correction[MAC_MSB-1:25] = f2_frd[MAC_MSB-1:25];
// frd_rne_correction
assign frd_rne_correction[24] = f2_frd[24] & ~((f2_before_rounding_r_bit & ~f2_before_rounding_s_bit) & (f2_round_mode == ROUND_RNE));
// }}}
// {{{ airth_exp region
// concern "is_novf"
// must be overflow
//      arith_exp > 15
//      => must be overflow
//---------------------------------------------------------------------------------------------------------------------
// must be norm or overflow
//      arith_exp > -15
//      => must be norm or overflow
//      => -arith_exp < 15
//      => ~arith_exp + 1 < 15
//      => ~arith_exp < 14
//
//      arith_exp == -15
//      => can be norm or subnorm, and need to check !!
//      => check 1: subnorm to norm (subnorm ovf mac[MAC_MSB-1])
//      => check 2: subnorm to norm but tininess which need to trigger underflow
//---------------------------------------------------------------------------------------------------------------------
// must be subnorm or norm or overflow
//      arith_exp > -25
//      => -arith_exp < 25
//      => ~arith_exp + 1 < 25
//      => ~arith_exp < 24
//      => must be subnorm or norm or overflow
//
//      ~(arith_exp <= -25)
//      => can be subnorm or underflow, and need to check !!
//      => check 1: |frd_rne_correction[25:24]
//---------------------------------------------------------------------------------------------------------------------
// concern "is_ovf"
// must be overflow
//      arith_exp > (15 - 1)
//---------------------------------------------------------------------------------------------------------------------
// must be norm or overflow
//      arith_exp > (-15 + 1)
//---------------------------------------------------------------------------------------------------------------------
// must be subnorm or norm or overflow
//      arith_exp > (-25 + 1)
//---------------------------------------------------------------------------------------------------------------------
localparam ARITH_EXP_P0_GT_OVF_BOUND = 15;
localparam ARITH_EXP_P0_GT_SUB_BOUND = 14;
localparam ARITH_EXP_P0_GT_UDF_BOUND = 24;
localparam ARITH_EXP_P1_GT_OVF_BOUND = 14;
localparam ARITH_EXP_P1_GT_SUB_BOUND = 15;
localparam ARITH_EXP_P1_GT_UDF_BOUND = 25;
wire f2_is_arith_exp_p0_gt_ovf_bound = ~f2_arith_exp[EXP_MSB] & ( f2_arith_exp[EXP_MSB-1:0] > ARITH_EXP_P0_GT_OVF_BOUND[EXP_MSB-1:0]);
wire f2_is_arith_exp_p0_gt_sub_bound = ~f2_arith_exp[EXP_MSB] | (~f2_arith_exp[EXP_MSB-1:0] < ARITH_EXP_P0_GT_SUB_BOUND[EXP_MSB-1:0]);
wire f2_is_arith_exp_p0_gt_udf_bound = ~f2_arith_exp[EXP_MSB] | (~f2_arith_exp[EXP_MSB-1:0] < ARITH_EXP_P0_GT_UDF_BOUND[EXP_MSB-1:0]);
wire f2_is_arith_exp_p1_gt_ovf_bound = ~f2_arith_exp[EXP_MSB] & ( f2_arith_exp[EXP_MSB-1:0] > ARITH_EXP_P1_GT_OVF_BOUND[EXP_MSB-1:0]);
wire f2_is_arith_exp_p1_gt_sub_bound = ~f2_arith_exp[EXP_MSB] | (~f2_arith_exp[EXP_MSB-1:0] < ARITH_EXP_P1_GT_SUB_BOUND[EXP_MSB-1:0]);
wire f2_is_arith_exp_p1_gt_udf_bound = ~f2_arith_exp[EXP_MSB] | (~f2_arith_exp[EXP_MSB-1:0] < ARITH_EXP_P1_GT_UDF_BOUND[EXP_MSB-1:0]);
wire f2_is_arith_exp_gt_ovf_bound = f2_is_ovf ? f2_is_arith_exp_p1_gt_ovf_bound : f2_is_arith_exp_p0_gt_ovf_bound;
wire f2_is_arith_exp_gt_sub_bound = f2_is_ovf ? f2_is_arith_exp_p1_gt_sub_bound : f2_is_arith_exp_p0_gt_sub_bound;
wire f2_is_arith_exp_gt_udf_bound = f2_is_ovf ? f2_is_arith_exp_p1_gt_udf_bound : f2_is_arith_exp_p0_gt_udf_bound;
wire f2_is_arith_exp_udf = ~f2_is_arith_exp_gt_udf_bound;
wire f2_is_arith_exp_ovf =  f2_is_arith_exp_gt_ovf_bound;
wire f2_is_arith_exp_sub = ~f2_is_arith_exp_gt_sub_bound & f2_is_arith_exp_gt_udf_bound;
// }}}
// {{{ tininess after rounding
// 1. when subnormal detected only can be novf (if is_sub(arith_exp < -14) is "1", is_ovf is always "0")
// 2. when sum is consecutive "1", lza output willn't have 1 bit lza error
//---------------------------------------------------------------------------------------------------------------------
// [35][34].[33][32][31][30][29][28][27][26][25][24][23][22][21][20].[19][18][17][16][15][14][13][12][11][10][9][8][7][6][5][4][3][2][1][0][-1][-2]
// [  ][                                           ][  ][  ][                                                                             ][  ][  ]
// [mslice = y                             ][cslice    ][lslice                                                                                   ]
// [2'd0  ].[                                      ][L ][R ]
// [2'd0  ].[1 ][1 ][1 ][1 ][1 ][1 ][1 ][1 ][1 ]
//                                          [C ][  ][L ][R ]
//                                          [z_tininess]
//---------------------------------------------------------------------------------------------------------------------
wire [25:23] f2_z_tininess = {1'b0,f2_cslice[24:23]} + {2'b0,f2_lslice_carry} + {2'b0,(f2_ri & f2_sticky_novf) | (f2_rn & f2_lslice[22])};
wire f2_is_tininess = ({f2_y0[MAC_MSB:26],f2_cslice[25]} == 11'b00111111111) & ~f2_z_tininess[25];
// }}}
// {{{ frd_rne_correction region detect
wire f2_is_udf_to_sub = |frd_rne_correction[25:24];
wire f2_is_frd_rne_correction_ovf = ~f2_is_frd_inf & ~f2_is_frd_nan & ~f2_is_frd_zero
                                  & f2_is_arith_exp_ovf;
wire f2_is_frd_rne_correction_sub = ~f2_is_frd_inf & ~f2_is_frd_nan & ~f2_is_frd_zero
                                  & (f2_is_arith_exp_sub | (f2_is_arith_exp_udf & f2_is_udf_to_sub));
wire f2_is_frd_rne_correction_udf = ~f2_is_frd_inf & ~f2_is_frd_nan & ~f2_is_frd_zero
                                  & (f2_is_arith_exp_udf & ~f2_is_udf_to_sub);
wire f2_is_frd_rne_correction_zero = ~f2_is_frd_inf & ~f2_is_frd_nan
                                   & (f2_is_frd_zero | ~(|frd_rne_correction));
/// }}}
// {{{ arith_op
wire [EXP_MSB:0] f2_arith_op_exp = f2_is_frd_rne_correction_sub ? {{(EXP_MSB){1'b0}},frd_rne_correction[MAC_MSB-1]} : (f2_arith_exp + 'd15 + {{(EXP_MSB){1'b0}},f2_is_ovf});
wire [FLEN-1:0] f2_arith_op = {f2_arith_sign,f2_arith_op_exp[4:0],frd_rne_correction[MAC_MSB-2:24]};
// }}}
// {{{ exception
wire f2_is_sub_to_norm = frd_rne_correction[MAC_MSB-1];
wire f2_is_rs_exception = ~f2_is_frd_nan & ~f2_is_frd_zero & ~f2_is_frd_inf & (f2_before_rounding_r_bit | f2_before_rounding_s_bit);
wire f2_is_udf_exception = (f2_is_frd_rne_correction_sub & (f2_before_rounding_r_bit | f2_before_rounding_s_bit) & (~f2_is_sub_to_norm | f2_is_tininess)) |
                           (f2_is_frd_rne_correction_udf & (f2_before_rounding_r_bit | f2_before_rounding_s_bit));
wire f2_is_ovf_exception = f2_is_frd_rne_correction_ovf;
wire f2_is_nx_exception = f2_is_ovf_exception | f2_is_udf_exception | f2_is_rs_exception;
// }}}
// {{{ zero_sign
wire f2_zero_sign = ~f2_is_frd_zero & f2_is_frd_rne_correction_zero & ~f2_before_rounding_r_bit & ~f2_before_rounding_s_bit ? (f2_round_mode == ROUND_RDN) : f2_arith_sign;
// }}}
// {{{ non_arith_op
wire f2_is_non_arith_op_largest = f2_is_frd_rne_correction_ovf & f2_rz;
wire f2_is_non_arith_op_inf = f2_is_frd_inf | (f2_is_frd_rne_correction_ovf & (f2_rn | f2_ri));
wire f2_is_non_arith_op_smallest = (f2_is_frd_rne_correction_udf & (f2_before_rounding_r_bit | f2_before_rounding_s_bit)) & f2_ri;
wire f2_is_non_arith_op_zero = f2_is_frd_rne_correction_zero | ((f2_is_frd_rne_correction_udf & (f2_before_rounding_r_bit | f2_before_rounding_s_bit)) & (f2_rn | f2_rz));
wire [FLEN-1:0] f2_non_arith_op = ({16{f2_is_frd_nan}}               & {1'b0,5'h1f,10'h200})
                                | ({16{f2_is_non_arith_op_inf}}      & {f2_arith_sign,5'h1f,10'h0})
                                | ({16{f2_is_non_arith_op_zero}}     & {f2_zero_sign,5'h00,10'h0})
                                | ({16{f2_is_non_arith_op_largest}}  & {f2_arith_sign,5'h1e,10'h3ff})
                                | ({16{f2_is_non_arith_op_smallest}} & {f2_arith_sign,5'h00,10'h1});
wire f2_is_non_arith_op = f2_is_frd_nan
                        | f2_is_non_arith_op_inf
                        | f2_is_non_arith_op_zero
                        | f2_is_non_arith_op_largest
                        | f2_is_non_arith_op_smallest;
// }}}
assign fp16_o_flag = {(5){f2_valid}} & {f2_is_frd_exception_nan,1'b0,f2_is_ovf_exception,f2_is_udf_exception,f2_is_nx_exception};
assign fp16_o_frd = f2_is_non_arith_op ? f2_non_arith_op : f2_arith_op;
assign fp16_o_valid = f2_valid;
assign f2_ready = fp16_o_ready;
endmodule
