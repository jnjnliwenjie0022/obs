module acc_fdiv(
     clk
    ,resetn
    ,fdiv_resp_ready
    ,fdiv_resp_valid
    ,fdiv_resp_op1
    ,fdiv_resp_op2
    ,fdiv_resp_ctrl
    ,fdiv_resp_round_mode
    ,fdiv_req_valid
    ,fdiv_req_ready
    ,fdiv_req_flag
    ,fdiv_req_frd
);
// #{{{ declare
//   |->R_MSB                                                                    |->R_LSB
//---------------------------------------------------------------------------------------------------------------------
// [003][002][001][000].[-01][-02][-03][-04][-05][-06][-07][-08][-09][-10][-11][-12]
//           [   ][                                                      ][   ][   ]
//           [mslice = y                                       ][cslice       ][ls ] : ls (lslice)
//---------------------------------------------------------------------------------------------------------------------
// novf                                                    [ C ][   ][ L ][ R ]
//---------------------------------------------------------------------------------------------------------------------
// ovf                                                     [ C ][ L ][ R ][   ]
//---------------------------------------------------------------------------------------------------------------------
localparam FLEN = 16;
localparam FP16_FRAC_BITWIDTH = 10;
localparam FP16_EXP_BITWIDTH = 5;
localparam FRAC_MSB = FP16_FRAC_BITWIDTH;
// op1_no_bias_exp(6b) + op2_no_bias_exp(6b) => FP16_EXP_BITWIDTH + 2
localparam EXP_MSB = FP16_EXP_BITWIDTH+2-1;
localparam X_BITWIDTH = FP16_FRAC_BITWIDTH + 1;
localparam Q_MSB = 1;
localparam Q_LSB = -((X_BITWIDTH + 1) + (X_BITWIDTH + 1)%2);
localparam Q_BITWIDTH = Q_MSB - Q_LSB + 1;
localparam R_MSB = 3;
localparam R_LSB = Q_LSB;
localparam R_BITWIDTH = R_MSB - R_LSB + 1;
localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;
localparam CONST_X = 32'dx;
localparam CONST_0 = 32'd0;
localparam CONST_1 = 32'd1;
localparam CONST_2 = 32'd2;
localparam CONST_3 = 32'd3;
localparam CONST_4 = 32'd4;
localparam CONST_5 = 32'd5;
localparam CONST_6 = 32'd6;
localparam CONST_7 = 32'd7;
localparam CONST_8 = 32'd8;
localparam CONST_9 = 32'd9;
localparam CONST_10 = 32'd10;
localparam CONST_13 = 32'd13;
localparam CONST_14 = 32'd14;
localparam CONST_15 = 32'd15;
localparam CONST_24 = 32'd24;
localparam CONST_25 = 32'd25;
localparam CONST_MINUS14 = -32'd14;

input             clk;
input             resetn;
output            fdiv_resp_ready;
input             fdiv_resp_valid;
input  [FLEN-1:0] fdiv_resp_op1;
input  [FLEN-1:0] fdiv_resp_op2;
input  [4:0]      fdiv_resp_ctrl;
input  [2:0]      fdiv_resp_round_mode;
output            fdiv_req_valid;
input             fdiv_req_ready;
output [4:0]      fdiv_req_flag;
output [FLEN-1:0] fdiv_req_frd;

reg p1_is_dz;
reg p1_is_frd_zero;
reg p1_is_frd_inf ;
reg p1_is_frd_snan;
reg p1_is_frd_qnan;
reg p1_div_instr;
reg [2:0] p1_round_mode;
reg p1_arith_sign;
reg [EXP_MSB:0] p1_op1_arith_exp;
reg [EXP_MSB:0] p1_op2_arith_exp;
reg p2_is_dz;
reg p2_is_frd_zero;
reg p2_is_frd_inf ;
reg p2_is_frd_snan;
reg p2_is_frd_qnan;
reg p2_arith_sign;
reg [2:0] p2_round_mode;
reg p2_ri;
reg p2_rn;
reg p2_rz;
reg [EXP_MSB:0] p2_arith_exp;
reg [EXP_MSB:0] p2_arith_exp_minus1;
reg [3:R_LSB] p2_d0;
reg [3:R_LSB] p2_d1;
reg p2_sticky;
reg p2_valid;

wire p0_ready;
wire p1_ready;
wire p2_ready;
// #}}}
// #{{{ p0 stage
wire p0_valid = fdiv_resp_valid;
assign fdiv_resp_ready = p0_ready;
wire p0_fdiv_instr = fdiv_resp_ctrl[4:0] == 5'b0000;
wire p0_fsqrt_instr = fdiv_resp_ctrl[4:0] == 5'b0001;
wire p0_div_instr = p0_fdiv_instr;
wire p0_sqrt_instr = p0_fsqrt_instr;
wire [2:0] p0_round_mode = fdiv_resp_round_mode;
wire p0_op1_sign = fdiv_resp_op1[FP16_FRAC_BITWIDTH+FP16_EXP_BITWIDTH];
wire p0_op2_sign = fdiv_resp_op2[FP16_FRAC_BITWIDTH+FP16_EXP_BITWIDTH];
wire p0_op1_signal_bit = fdiv_resp_op1[FP16_FRAC_BITWIDTH-1];
wire p0_op2_signal_bit = fdiv_resp_op2[FP16_FRAC_BITWIDTH-1];
wire p0_is_op1_subnorm = fdiv_resp_op1[FP16_FRAC_BITWIDTH +:FP16_EXP_BITWIDTH] == {(FP16_FRAC_BITWIDTH){1'd0}};
wire p0_is_op2_subnorm = fdiv_resp_op2[FP16_FRAC_BITWIDTH +:FP16_EXP_BITWIDTH] == {(FP16_FRAC_BITWIDTH){1'd0}};
wire [EXP_MSB:0] p0_op1_exp = p0_is_op1_subnorm ? {{(EXP_MSB){1'd0}},1'd1} : {2'd0,fdiv_resp_op1[FP16_FRAC_BITWIDTH +:FP16_EXP_BITWIDTH]};
wire [EXP_MSB:0] p0_op2_exp = p0_is_op2_subnorm ? {{(EXP_MSB){1'd0}},1'd1} : {2'd0,fdiv_resp_op2[FP16_FRAC_BITWIDTH +:FP16_EXP_BITWIDTH]};
wire [FRAC_MSB:0] p0_op1_frac = p0_is_op1_subnorm ? {1'd0,fdiv_resp_op1[0 +:FP16_FRAC_BITWIDTH]} : {1'd1,fdiv_resp_op1[0 +:FP16_FRAC_BITWIDTH]};
wire [FRAC_MSB:0] p0_op2_frac = p0_is_op2_subnorm ? {1'd0,fdiv_resp_op2[0 +:FP16_FRAC_BITWIDTH]} : {1'd1,fdiv_resp_op2[0 +:FP16_FRAC_BITWIDTH]};
wire p0_op1_exp_all1 = &fdiv_resp_op1[FP16_FRAC_BITWIDTH +:FP16_EXP_BITWIDTH];
wire p0_op2_exp_all1 = &fdiv_resp_op2[FP16_FRAC_BITWIDTH +:FP16_EXP_BITWIDTH];
wire p0_op1_exp_all0 = ~(|fdiv_resp_op1[FP16_FRAC_BITWIDTH +:FP16_EXP_BITWIDTH]);
wire p0_op2_exp_all0 = ~(|fdiv_resp_op2[FP16_FRAC_BITWIDTH +:FP16_EXP_BITWIDTH]);
wire p0_op1_frac_all0 = ~(|fdiv_resp_op1[0 +:FP16_FRAC_BITWIDTH]);
wire p0_op2_frac_all0 = ~(|fdiv_resp_op2[0 +:FP16_FRAC_BITWIDTH]);
wire p0_is_op1_inf = p0_op1_exp_all1 & p0_op1_frac_all0;
wire p0_is_op2_inf = p0_op2_exp_all1 & p0_op2_frac_all0;
wire p0_is_op1_zero = p0_op1_exp_all0 & p0_op1_frac_all0;
wire p0_is_op2_zero = p0_op2_exp_all0 & p0_op2_frac_all0;
wire p0_is_op1_nan = p0_op1_exp_all1 & ~p0_op1_frac_all0;
wire p0_is_op2_nan = p0_op2_exp_all1 & ~p0_op2_frac_all0;
wire p0_is_op1_snan = p0_is_op1_nan & ~p0_op1_signal_bit;
wire p0_is_op2_snan = p0_is_op2_nan & ~p0_op2_signal_bit;
wire p0_is_frd_zero = (p0_sqrt_instr & p0_is_op1_zero)
                    | (p0_div_instr & (p0_is_op1_zero & ~(p0_is_op2_nan | p0_is_op2_zero)))
                    | (p0_div_instr & (p0_is_op2_inf  & ~(p0_is_op1_nan | p0_is_op1_inf)));
wire p0_is_frd_inf = (p0_sqrt_instr & p0_is_op1_inf)
                   | (p0_div_instr & (p0_is_op1_inf  & ~(p0_is_op2_nan | p0_is_op2_inf)))
                   | (p0_div_instr & (p0_is_op2_zero & ~(p0_is_op1_nan | p0_is_op1_zero)));
wire p0_is_frd_qnan = (p0_sqrt_instr & (p0_is_op1_nan | (p0_op1_sign & ~p0_is_op1_zero))) // sqrt(-0) = -0 which is valid
                    | (p0_div_instr & ((p0_is_op1_nan | p0_is_op2_nan) | (p0_is_op1_zero & p0_is_op2_zero) | (p0_is_op1_inf & p0_is_op2_inf)));
wire p0_is_frd_snan = (p0_sqrt_instr & (p0_is_op1_snan | (p0_op1_sign & ~p0_is_op1_zero & ~p0_is_op1_nan)))
                    | (p0_div_instr & ((p0_is_op1_snan | p0_is_op2_snan) | (p0_is_op1_zero & p0_is_op2_zero) | (p0_is_op1_inf & p0_is_op2_inf)));
//  x  /  y  =  q  ...  r
// (+) / (+) = (+) ... (+)
// (+) / (-) = (-) ... (+)
// (-) / (+) = (-) ... (-)
// (-) / (-) = (+) ... (-)
wire p0_q_arith_sign = p0_op1_sign ^ p0_op2_sign;
// sqrt(-0) = -0
wire p0_frd_zero_arith_sign = (p0_sqrt_instr & p0_op1_sign) | (p0_div_instr & p0_q_arith_sign);
wire p0_is_dz = p0_div_instr & p0_is_op2_zero & ~p0_is_op1_zero & ~p0_is_op1_nan & ~p0_is_op1_inf;
wire p0_airth_sign = p0_is_frd_zero ? p0_frd_zero_arith_sign :
                     p0_sqrt_instr ? 1'b0 :
                     p0_q_arith_sign;

wire p0_is_op1_lzc_0 = p0_op1_frac[FRAC_MSB];
wire p0_is_op1_lzc_1 = ~|p0_op1_frac[FRAC_MSB-:1] & p0_op1_frac[FRAC_MSB-1];
wire p0_is_op1_lzc_2 = ~|p0_op1_frac[FRAC_MSB-:2] & p0_op1_frac[FRAC_MSB-2];
wire p0_is_op1_lzc_3 = ~|p0_op1_frac[FRAC_MSB-:3] & p0_op1_frac[FRAC_MSB-3];
wire p0_is_op1_lzc_4 = ~|p0_op1_frac[FRAC_MSB-:4] & p0_op1_frac[FRAC_MSB-4];
wire p0_is_op1_lzc_5 = ~|p0_op1_frac[FRAC_MSB-:5] & p0_op1_frac[FRAC_MSB-5];
wire p0_is_op1_lzc_6 = ~|p0_op1_frac[FRAC_MSB-:6] & p0_op1_frac[FRAC_MSB-6];
wire p0_is_op1_lzc_7 = ~|p0_op1_frac[FRAC_MSB-:7] & p0_op1_frac[FRAC_MSB-7];
wire p0_is_op1_lzc_8 = ~|p0_op1_frac[FRAC_MSB-:8] & p0_op1_frac[FRAC_MSB-8];
wire p0_is_op1_lzc_9 = ~|p0_op1_frac[FRAC_MSB-:9] & p0_op1_frac[FRAC_MSB-9];
wire p0_is_op1_lzc_10 = ~|p0_op1_frac[FRAC_MSB-:10] & p0_op1_frac[FRAC_MSB-10];

wire p0_is_op2_lzc_0 = p0_op2_frac[FRAC_MSB];
wire p0_is_op2_lzc_1 = ~|p0_op2_frac[FRAC_MSB-:1] & p0_op2_frac[FRAC_MSB-1];
wire p0_is_op2_lzc_2 = ~|p0_op2_frac[FRAC_MSB-:2] & p0_op2_frac[FRAC_MSB-2];
wire p0_is_op2_lzc_3 = ~|p0_op2_frac[FRAC_MSB-:3] & p0_op2_frac[FRAC_MSB-3];
wire p0_is_op2_lzc_4 = ~|p0_op2_frac[FRAC_MSB-:4] & p0_op2_frac[FRAC_MSB-4];
wire p0_is_op2_lzc_5 = ~|p0_op2_frac[FRAC_MSB-:5] & p0_op2_frac[FRAC_MSB-5];
wire p0_is_op2_lzc_6 = ~|p0_op2_frac[FRAC_MSB-:6] & p0_op2_frac[FRAC_MSB-6];
wire p0_is_op2_lzc_7 = ~|p0_op2_frac[FRAC_MSB-:7] & p0_op2_frac[FRAC_MSB-7];
wire p0_is_op2_lzc_8 = ~|p0_op2_frac[FRAC_MSB-:8] & p0_op2_frac[FRAC_MSB-8];
wire p0_is_op2_lzc_9 = ~|p0_op2_frac[FRAC_MSB-:9] & p0_op2_frac[FRAC_MSB-9];
wire p0_is_op2_lzc_10 = ~|p0_op2_frac[FRAC_MSB-:10] & p0_op2_frac[FRAC_MSB-10];

localparam LZC_BITWIDTH = 4;

wire [LZC_BITWIDTH-1:0] p0_op1_lzc
    = ({LZC_BITWIDTH{p0_is_op1_lzc_0}} & CONST_0[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op1_lzc_1}} & CONST_1[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op1_lzc_2}} & CONST_2[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op1_lzc_3}} & CONST_3[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op1_lzc_4}} & CONST_4[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op1_lzc_5}} & CONST_5[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op1_lzc_6}} & CONST_6[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op1_lzc_7}} & CONST_7[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op1_lzc_8}} & CONST_8[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op1_lzc_9}} & CONST_9[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op1_lzc_10}} & CONST_10[LZC_BITWIDTH-1:0]);

wire [LZC_BITWIDTH-1:0] p0_op2_lzc
    = ({LZC_BITWIDTH{p0_is_op2_lzc_0}} & CONST_0[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op2_lzc_1}} & CONST_1[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op2_lzc_2}} & CONST_2[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op2_lzc_3}} & CONST_3[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op2_lzc_4}} & CONST_4[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op2_lzc_5}} & CONST_5[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op2_lzc_6}} & CONST_6[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op2_lzc_7}} & CONST_7[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op2_lzc_8}} & CONST_8[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op2_lzc_9}} & CONST_9[LZC_BITWIDTH-1:0])
    | ({LZC_BITWIDTH{p0_is_op2_lzc_10}} & CONST_10[LZC_BITWIDTH-1:0]);

wire [FRAC_MSB:0] p0_op1_frac_l0 = p0_op1_frac;
wire [FRAC_MSB:0] p0_op1_frac_l1 = p0_op1_lzc[3] ? {p0_op1_frac_l0[(FRAC_MSB - (8 >> 0)):0],{(8 >> 0){1'd0}}} : p0_op1_frac_l0;
wire [FRAC_MSB:0] p0_op1_frac_l2 = p0_op1_lzc[2] ? {p0_op1_frac_l1[(FRAC_MSB - (8 >> 1)):0],{(8 >> 1){1'd0}}} : p0_op1_frac_l1;
wire [FRAC_MSB:0] p0_op1_frac_l3 = p0_op1_lzc[1] ? {p0_op1_frac_l2[(FRAC_MSB - (8 >> 2)):0],{(8 >> 2){1'd0}}} : p0_op1_frac_l2;
wire [FRAC_MSB:0] p0_op1_frac_l4 = p0_op1_lzc[0] ? {p0_op1_frac_l3[(FRAC_MSB - (8 >> 3)):0],{(8 >> 3){1'd0}}} : p0_op1_frac_l3;
wire [FRAC_MSB:0] p0_op1_frac_l = p0_op1_frac_l4;

wire [FRAC_MSB:0] p0_op2_frac_l0 = p0_op2_frac;
wire [FRAC_MSB:0] p0_op2_frac_l1 = p0_op2_lzc[3] ? {p0_op2_frac_l0[(FRAC_MSB - (8 >> 0)):0],{(8 >> 0){1'd0}}} : p0_op2_frac_l0;
wire [FRAC_MSB:0] p0_op2_frac_l2 = p0_op2_lzc[2] ? {p0_op2_frac_l1[(FRAC_MSB - (8 >> 1)):0],{(8 >> 1){1'd0}}} : p0_op2_frac_l1;
wire [FRAC_MSB:0] p0_op2_frac_l3 = p0_op2_lzc[1] ? {p0_op2_frac_l2[(FRAC_MSB - (8 >> 2)):0],{(8 >> 2){1'd0}}} : p0_op2_frac_l2;
wire [FRAC_MSB:0] p0_op2_frac_l4 = p0_op2_lzc[0] ? {p0_op2_frac_l3[(FRAC_MSB - (8 >> 3)):0],{(8 >> 3){1'd0}}} : p0_op2_frac_l3;
wire [FRAC_MSB:0] p0_op2_frac_l = p0_op2_frac_l4;

wire [EXP_MSB:0] p0_op1_arith_exp = p0_op1_exp - CONST_15[EXP_MSB:0] - p0_op1_lzc;
wire [EXP_MSB:0] p0_op2_arith_exp = p0_op2_exp - CONST_15[EXP_MSB:0] - p0_op2_lzc;
// acc_dsu
// ------------------------------------------------------------------------------------------------
// [003][002][001][000].[-01][-02][-03][-04][-05][-06][-07][-08][-09][-10][-11][-12]
// DIV            [ 1 ].[                                                ] for dsu
// SQRT           [ 1 ].[                                                ] for dsu
// ------------------------------------------------------------------------------------------------
wire dsu_resp_valid;
wire dsu_resp_ready;
wire dsu_resp_is_div;
wire dsu_resp_is_exp_odd;
wire [X_BITWIDTH-1:0] dsu_resp_x;
wire [X_BITWIDTH-1:0] dsu_resp_d;
wire dsu_req_ready;
wire dsu_req_r_done;
wire dsu_req_q_done;
wire [R_BITWIDTH-1:0] dsu_req_d0;
wire [R_BITWIDTH-1:0] dsu_req_d1;

assign p0_ready = dsu_resp_ready;
assign dsu_resp_valid = p0_valid;
assign dsu_resp_x = p0_op1_frac_l;
assign dsu_resp_d = p0_op2_frac_l;
assign dsu_resp_is_div = p0_fdiv_instr;
assign dsu_resp_is_exp_odd = p0_op1_arith_exp[0];

acc_dsu #(
     .X_BITWIDTH(X_BITWIDTH)
    ,.D_BITWIDTH(X_BITWIDTH)
) u_acc_dsu (
     .clk                 (clk                 )
    ,.resetn              (resetn              )
    ,.dsu_resp_valid      (dsu_resp_valid      )
    ,.dsu_resp_ready      (dsu_resp_ready      )
    ,.dsu_resp_is_div     (dsu_resp_is_div     )
    ,.dsu_resp_is_exp_odd (dsu_resp_is_exp_odd )
    ,.dsu_resp_x          (dsu_resp_x          )
    ,.dsu_resp_d          (dsu_resp_d          )
    ,.dsu_req_ready       (dsu_req_ready       )
    ,.dsu_req_r_done      (dsu_req_r_done      )
    ,.dsu_req_q_done      (dsu_req_q_done      )
    ,.dsu_req_d0          (dsu_req_d0          )
    ,.dsu_req_d1          (dsu_req_d1          )
);
assign dsu_req_ready = p1_ready;
// ------------------------------------------------------------------------------------------------
wire p1_en = p0_valid & p0_ready;
always @ (posedge clk) begin
    if (p1_en) begin
        p1_is_dz <= p0_is_dz;
        p1_is_frd_zero <= p0_is_frd_zero;
        p1_is_frd_inf  <= p0_is_frd_inf;
        p1_is_frd_snan <= p0_is_frd_snan;
        p1_is_frd_qnan <= p0_is_frd_qnan;
        p1_div_instr <= p0_div_instr;
        p1_round_mode <= p0_round_mode;
        p1_arith_sign <= p0_airth_sign;
        p1_op1_arith_exp <= p0_op1_arith_exp;
        p1_op2_arith_exp <= p0_op2_arith_exp;
    end
end
// #}}}
// #{{{ p1_rdone rounding mode
wire p1_cs_rdone_arith_sign = p1_arith_sign;
wire p1_cs_rdone_round_rne = (p1_round_mode == ROUND_RNE);
wire p1_cs_rdone_round_rtz = (p1_round_mode == ROUND_RTZ);
wire p1_cs_rdone_round_rdn = (p1_round_mode == ROUND_RDN);
wire p1_cs_rdone_round_rup = (p1_round_mode == ROUND_RUP);
wire p1_cs_rdone_round_rmm = (p1_round_mode == ROUND_RMM);
wire p1_cs_rdone_rn = p1_cs_rdone_round_rne | p1_cs_rdone_round_rmm;
wire p1_cs_rdone_ri = (~p1_cs_rdone_arith_sign & p1_cs_rdone_round_rup) | (p1_cs_rdone_arith_sign & p1_cs_rdone_round_rdn);
wire p1_cs_rdone_rz = p1_cs_rdone_round_rtz | (~p1_cs_rdone_arith_sign & p1_cs_rdone_round_rdn) | (p1_cs_rdone_arith_sign & p1_cs_rdone_round_rup);
// #}}}
// #{{{ p1_rdone remainder s and c
wire p1_is_rdone = dsu_req_r_done;
wire [R_MSB:R_LSB] p1_cs_rdone_r_s = dsu_req_d0;
wire [R_MSB:R_LSB] p1_cs_rdone_r_c = dsu_req_d1;
// #}}}
// #{{{ p1_rdone arith_exp
// In SQRT mode, if op1_airth_exp is odd
//      x will shift 1 right bit in dsu
//      arith_exp = (op1_airth_exp + 1)/2
// In SQRT mode, if op1_airth_exp is even
//      arith_exp = op1_airth_exp/2
wire [EXP_MSB:0] p1_cs_rdone_div_instr = p1_div_instr;
wire [EXP_MSB:0] p1_cs_rdone_div_exp = p1_op1_arith_exp - p1_op2_arith_exp;
wire [EXP_MSB:0] p1_cs_rdone_op1_airth_exp_plus2 = p1_op1_arith_exp + CONST_2[EXP_MSB:0];
wire [EXP_MSB:0] p1_cs_rdone_sqrt_exp = {p1_cs_rdone_op1_airth_exp_plus2[EXP_MSB],p1_cs_rdone_op1_airth_exp_plus2[EXP_MSB:1]};
wire [EXP_MSB:0] p1_cs_rdone_arith_exp = p1_cs_rdone_div_instr ? p1_cs_rdone_div_exp : p1_cs_rdone_sqrt_exp;
wire [EXP_MSB:0] p1_cs_rdone_arith_exp_minus1 = p1_cs_rdone_arith_exp - CONST_1[EXP_MSB:0];
// #}}}
// #{{{ p1_qdone remainder fast comparator with csa
wire p1_is_qdone = dsu_req_q_done;
wire [R_MSB:R_LSB] p1_cs_qdone_r_s = p2_d0;
wire [R_MSB:R_LSB] p1_cs_qdone_r_c = p2_d1;
// csa3to2
///////////////////////////////////////////////////////////////////////////////////////////////////
wire [R_BITWIDTH-1:0] p1_csa3to2_in0;
wire [R_BITWIDTH-1:0] p1_csa3to2_in1;
wire [R_BITWIDTH-1:0] p1_csa3to2_cin;
wire [R_BITWIDTH-1:0] p1_csa3to2_sum;
wire [R_BITWIDTH-1:0] p1_csa3to2_cout;

assign p1_csa3to2_in0 = p1_cs_qdone_r_s;
assign p1_csa3to2_in1 = p1_cs_qdone_r_c;
assign p1_csa3to2_cin = {(R_BITWIDTH){1'd1}};

acc_csa3to2 # (
    .CSA_WIDTH (R_BITWIDTH )
) u_p1_qdone_csa3to2 (
     .in0  (p1_csa3to2_in0  )
    ,.in1  (p1_csa3to2_in1  )
    ,.cin  (p1_csa3to2_cin  )
    ,.sum  (p1_csa3to2_sum  )
    ,.cout (p1_csa3to2_cout )
);

wire [R_BITWIDTH-1:0] p1_qdone_csa_s = p1_csa3to2_sum[R_BITWIDTH-1:0];
wire [R_BITWIDTH-1:0] p1_qdone_csa_c = {p1_csa3to2_cout[R_BITWIDTH-2:0],1'd0};
///////////////////////////////////////////////////////////////////////////////////////////////////
// #}}}
// #{{{ p1_qdone remainder sign
//wire p1_cs_qdone_r_sign = {p1_qdone_csa_c[R_BITWIDTH-2:0],1'd0} < ~p1_qdone_csa_s;
//wire p1_cs_qdone_r_sign = p1_csa3to2_in0 < ~p1_csa3to2_in1;
wire [3:R_LSB] p1 = p1_csa3to2_in0 + p1_csa3to2_in1;
wire p1_cs_qdone_r_sign = p1[3];
// #}}}
// #{{{ p1_qdone remainder sticky
//wire p1_cs_qdone_r_eq_0 = {p1_qdone_csa_c[R_BITWIDTH-2:0],1'd0} == ~p1_qdone_csa_s;
//wire p1_cs_qdone_r_eq_0 = p1_csa3to2_in0 == ~p1_csa3to2_in1;
wire p1_cs_qdone_r_eq_0 = p1 == 'd0;
wire p1_cs_qdone_sticky_r = ~p1_cs_qdone_r_eq_0;
// #}}}
// #{{{ p1_qdone quotient select
wire [3:R_LSB] p1_cs_qdone_q0 = dsu_req_d0;
wire [3:R_LSB] p1_cs_qdone_q0_minus1 = dsu_req_d1;
wire [3:R_LSB] p1_cs_qdone_q = p1_cs_qdone_r_sign ? p1_cs_qdone_q0_minus1 : p1_cs_qdone_q0;
// #}}}
// #{{{ p1_qdone adjust arith_exp (minus 1)
wire p1_cs_qdone_is_q_lt_0 = ~p1_cs_qdone_q[0];
wire [EXP_MSB:0] p1_cs_qdone_arith_exp = p1_cs_qdone_is_q_lt_0 ? p2_arith_exp_minus1 : p2_arith_exp;
// #}}}
// #{{{ p1_qdone adjust quotient (left shift 1b)
wire [3:R_LSB] p1_cs_qdone_q_l = p1_cs_qdone_is_q_lt_0 ? {p1_cs_qdone_q[2:R_LSB],1'd0} : p1_cs_qdone_q;
// #}}}
// #{{{ p1_qdone subnorm detect
// float point 16 minimal exp is -14
//---------------------------------------------------------------------
// condition                      |  q_r_amount                       |
//---------------------------------------------------------------------
// airth_exp >= -14 (normal)      |  0                                |
// airth_exp < -14  (subnormal)   |  -14 - airth_exp                  |
//---------------------------------------------------------------------
// airth_exp < -14
// airth_exp[MSB] is "1", arith_exp < -14
// airth_exp[MSB] is "1", -arith_exp > 14
// airth_exp[MSB] is "1", ~arith_exp + 1 > 14
// airth_exp[MSB] is "1", ~arith_exp > 13
// airth_exp[MSB] is "1", ~arith_exp > 13
// airth_exp[MSB] is "1", ~arith_exp[MSB-1:0] > 13
wire p1_cs_qdone_is_arith_exp_subnorm = p1_cs_qdone_arith_exp[EXP_MSB] & (~p1_cs_qdone_arith_exp[EXP_MSB-1:0] > CONST_13[EXP_MSB-1:0]);
wire unused_p1_cs_qdone_is_ovf_bit_zero = p1_cs_qdone_is_arith_exp_subnorm;
wire [EXP_MSB:0] p1_cs_qdone_q_r_amount_norm = {(EXP_MSB+1){1'd0}};
wire [EXP_MSB:0] p1_cs_qdone_q_r_amount_subnorm = CONST_MINUS14[EXP_MSB:0] - p1_cs_qdone_arith_exp;
wire [EXP_MSB:0] p1_cs_qdone_q_r_amount = p1_cs_qdone_is_arith_exp_subnorm ? p1_cs_qdone_q_r_amount_subnorm : p1_cs_qdone_q_r_amount_norm;
// #}}}
// #{{{ p1_qdone quotient right shift
wire [R_MSB:R_LSB] p1_cs_qdone_q_r0 = p1_cs_qdone_q_l;
//wire [PR_MSB:PR_LSB] p1_cs_qdone_q_r1 = p1_cs_qdone_q_r_amount[4] ? {{(16 >> 0){1'd0}},p1_cs_qdone_q_r0[PR_MSB:PR_LSB + (16 >> 0)]} : p1_cs_qdone_q_r0;
wire [R_MSB:R_LSB] p1_cs_qdone_q_r1 = p1_cs_qdone_q_r_amount[4] ? {(R_BITWIDTH){1'd0}}: p1_cs_qdone_q_r0;
wire [R_MSB:R_LSB] p1_cs_qdone_q_r2 = p1_cs_qdone_q_r_amount[3] ? {{(16 >> 1){1'd0}},p1_cs_qdone_q_r1[R_MSB:R_LSB + (16 >> 1)]} : p1_cs_qdone_q_r1;
wire [R_MSB:R_LSB] p1_cs_qdone_q_r3 = p1_cs_qdone_q_r_amount[2] ? {{(16 >> 2){1'd0}},p1_cs_qdone_q_r2[R_MSB:R_LSB + (16 >> 2)]} : p1_cs_qdone_q_r2;
wire [R_MSB:R_LSB] p1_cs_qdone_q_r4 = p1_cs_qdone_q_r_amount[1] ? {{(16 >> 3){1'd0}},p1_cs_qdone_q_r3[R_MSB:R_LSB + (16 >> 3)]} : p1_cs_qdone_q_r3;
wire [R_MSB:R_LSB] p1_cs_qdone_q_r5 = p1_cs_qdone_q_r_amount[0] ? {{(16 >> 4){1'd0}},p1_cs_qdone_q_r4[R_MSB:R_LSB + (16 >> 4)]} : p1_cs_qdone_q_r4;
wire [R_MSB:R_LSB] p1_cs_qdone_q_r = p1_cs_qdone_q_r5;
// #}}}
// #{{{ p1_qdone quotient right shift sticky
wire [4:0] p1_cs_qdone_sticky_q_r_array;
//assign p1_cs_qdone_sticky_q_r_array[0] = p1_cs_qdone_q_r_amount[4] & (|p1_cs_qdone_q_r0[PR_LSB +:(16 >> 0)]);
assign p1_cs_qdone_sticky_q_r_array[0] = p1_cs_qdone_q_r_amount[4] & (|p1_cs_qdone_q_r0);
assign p1_cs_qdone_sticky_q_r_array[1] = p1_cs_qdone_q_r_amount[3] & (|p1_cs_qdone_q_r1[R_LSB +:(16 >> 1)]);
assign p1_cs_qdone_sticky_q_r_array[2] = p1_cs_qdone_q_r_amount[2] & (|p1_cs_qdone_q_r2[R_LSB +:(16 >> 2)]);
assign p1_cs_qdone_sticky_q_r_array[3] = p1_cs_qdone_q_r_amount[1] & (|p1_cs_qdone_q_r3[R_LSB +:(16 >> 3)]);
assign p1_cs_qdone_sticky_q_r_array[4] = p1_cs_qdone_q_r_amount[0] & (|p1_cs_qdone_q_r4[R_LSB +:(16 >> 4)]);
// #}}}
// #{{{ p1_qdone sticky
//---------------------------------------------------------------------------------------------------------------------
// [003][002][001][000].[-01][-02][-03][-04][-05][-06][-07][-08][-09][-10][-11][-12]
//                [11b                                                   ][ R ][LSB][ S ]
// S contains remainder and quotient right shift
//---------------------------------------------------------------------------------------------------------------------
wire p1_cs_qdone_sticky_q_r = |p1_cs_qdone_sticky_q_r_array;
wire p1_cs_qdone_sticky = p1_cs_qdone_sticky_r | p1_cs_qdone_sticky_q_r;
// #}}}
// #{{{ p2 stage reg
wire p2_rdone_en = p1_is_rdone & p1_ready;
    wire p2_rn_nx = p1_cs_rdone_rn;
    wire p2_ri_nx = p1_cs_rdone_ri;
    wire p2_rz_nx = p1_cs_rdone_rz;
    wire [EXP_MSB:0] p2_arith_exp_minus1_nx = p1_cs_rdone_arith_exp_minus1;
    wire [R_MSB:R_LSB] p2_d1_nx = p1_cs_rdone_r_c;
always @ (posedge clk) begin
    if (p2_rdone_en) begin
        p2_is_dz <= p1_is_dz;
        p2_is_frd_zero <= p1_is_frd_zero;
        p2_is_frd_inf  <= p1_is_frd_inf;
        p2_is_frd_snan <= p1_is_frd_snan;
        p2_is_frd_qnan <= p1_is_frd_qnan;
        p2_arith_sign <= p1_arith_sign;
        p2_round_mode <= p1_round_mode;
        p2_ri <= p2_ri_nx;
        p2_rn <= p2_rn_nx;
        p2_rz <= p2_rz_nx;
        p2_arith_exp_minus1 <= p2_arith_exp_minus1_nx;
        p2_d1 <= p2_d1_nx;
    end
end

wire p2_qdone_en = p1_is_qdone & p1_ready;
    wire p2_sticky_nx = p1_cs_qdone_sticky;
always @ (posedge clk)
    if (p2_qdone_en)
        p2_sticky <= p2_sticky_nx;

wire p2_en = (p1_is_qdone | p1_is_rdone) & p1_ready;
    wire [R_MSB:R_LSB] p2_d0_nx
        = ({R_BITWIDTH{p1_is_rdone}} & p1_cs_rdone_r_s)
        | ({R_BITWIDTH{p1_is_qdone}} & p1_cs_qdone_q_r);
    wire [EXP_MSB:0] p2_arith_exp_nx
        = ({(EXP_MSB+1){p1_is_rdone}} & p1_cs_rdone_arith_exp)
        | ({(EXP_MSB+1){p1_is_qdone}} & p1_cs_qdone_arith_exp);
always @ (posedge clk) begin
    if (p2_en) begin
        p2_d0 <= p2_d0_nx;
        p2_arith_exp <= p2_arith_exp_nx;
    end
end

assign p1_ready = ~p2_valid | p2_ready;
wire p2_valid_set = p1_is_qdone;
wire p2_valid_clr = p2_ready;
wire p2_valid_nx = p2_valid_set | (p2_valid & ~p2_valid_clr);
always @ (posedge clk or negedge resetn) begin 
    if (!resetn)
        p2_valid <= 1'b0;
    else
        p2_valid <= p2_valid_nx;
end
// #}}}
// #{{{ p2 stage xy algorithm without 1 error bit
// [003][002][001][000].[-01][-02][-03][-04][-05][-06][-07][-08][-09][-10][-11][-12]
//                [11b                                                   ][ R ][LSB]
//                                                                             [ S  ... ...    ]
//           [mslice = y                                       ][cslice       ][ls ] : ls(lslice)
//---------------------------------------------------------------------------------------------------------------------
// novf                                                    [ C ][   ][ L ][ R ]
//                                                         [z                 ]
//---------------------------------------------------------------------------------------------------------------------
// ovf condition if p2_y0 + P2_z_novf[MSB] == (&p2_y0) & p2_z_novf[-8] ==
//           [ 1 ][ 0 ].[ 0 ][ 0 ][ 0 ][ 0 ][ 0 ][ 0 ][ 0 ][ 0 ]
// then final result must be
// p2_frd         [ 1 ].[ 0 ][ 0 ][ 0 ][ 0 ][ 0 ][ 0 ][ 0 ][ 0 ][ 0 ][ 0 ]
//---------------------------------------------------------------------------------------------------------------------
wire [3:R_LSB] p2_q_r = p2_d0;
wire [1:-8] p2_mslice = p2_q_r[1:-8];
wire [-9:-11] p2_cslice = p2_q_r[-9:-11];
wire [-12:R_LSB] p2_lslice = p2_q_r[-12:R_LSB];

wire [1:-8] p2_y0 = p2_mslice;
wire [1:-8] p2_y1 = p2_mslice + CONST_1[11:0];

wire p2_sticky_novf = (|p2_lslice) | p2_sticky;

wire [-8:-10] p2_z_novf = {1'b0,p2_cslice[-9:-10]} + {2'b0,(p2_ri & (p2_sticky_novf | p2_cslice[-11]) | (p2_rn & p2_cslice[-11]))};
//wire [-8:-11] p2_z_novf = {1'd0,p2_cslice} + {3'd0,(p2_rn | p2_ri)} + {3'd0,(p2_ri & p2_sticky_novf)};
wire p2_z_novf_carry = p2_z_novf[-8];
wire [1:-8] p2_y = p2_z_novf_carry ? p2_y1 : p2_y0;

wire unused_p2_is_ovf = p2_y1[1] & p2_z_novf[-8];
wire p2_is_ovf = (&p2_y0[0:-8]) & p2_z_novf[-8];
wire [0:-10] p2_frd_novf = {p2_y[0:-8],p2_z_novf[-9:-10]};
wire [0:-10] p2_frd = p2_is_ovf ? {1'd1, {(10){1'd0}}} : p2_frd_novf;
// #}}}
// #{{{ p2 stage frd rne correction
wire [0:-10] p2_frd_rne_correction;
wire p2_before_rounding_r_bit_novf = p2_cslice[-11];
wire p2_before_rounding_r_bit = p2_before_rounding_r_bit_novf;
wire p2_before_rounding_s_bit = p2_sticky_novf;
assign p2_frd_rne_correction[0:-9] = p2_frd[0:-9];
assign p2_frd_rne_correction[-10] = p2_frd[-10] & ~((p2_before_rounding_r_bit & ~p2_before_rounding_s_bit) & (p2_round_mode == ROUND_RNE));
// #}}}
// #{{{ p2 stage airth_exp region
localparam ARITH_EXP_P0_GT_OVF_BOUND = CONST_15;
localparam ARITH_EXP_P0_GT_SUB_BOUND = CONST_14;
localparam ARITH_EXP_P0_GT_UDF_BOUND = CONST_24;
localparam ARITH_EXP_P1_GT_OVF_BOUND = CONST_14;
localparam ARITH_EXP_P1_GT_SUB_BOUND = CONST_15;
localparam ARITH_EXP_P1_GT_UDF_BOUND = CONST_25;
wire p2_is_arith_exp_p0_gt_ovf_bound = ~p2_arith_exp[EXP_MSB] & ( p2_arith_exp[EXP_MSB-1:0] > ARITH_EXP_P0_GT_OVF_BOUND[EXP_MSB-1:0]);
wire p2_is_arith_exp_p0_gt_sub_bound = ~p2_arith_exp[EXP_MSB] | (~p2_arith_exp[EXP_MSB-1:0] < ARITH_EXP_P0_GT_SUB_BOUND[EXP_MSB-1:0]);
wire p2_is_arith_exp_p0_gt_udf_bound = ~p2_arith_exp[EXP_MSB] | (~p2_arith_exp[EXP_MSB-1:0] < ARITH_EXP_P0_GT_UDF_BOUND[EXP_MSB-1:0]);
wire p2_is_arith_exp_p1_gt_ovf_bound = ~p2_arith_exp[EXP_MSB] & ( p2_arith_exp[EXP_MSB-1:0] > ARITH_EXP_P1_GT_OVF_BOUND[EXP_MSB-1:0]);
wire p2_is_arith_exp_p1_gt_sub_bound = ~p2_arith_exp[EXP_MSB] | (~p2_arith_exp[EXP_MSB-1:0] < ARITH_EXP_P1_GT_SUB_BOUND[EXP_MSB-1:0]);
wire p2_is_arith_exp_p1_gt_udf_bound = ~p2_arith_exp[EXP_MSB] | (~p2_arith_exp[EXP_MSB-1:0] < ARITH_EXP_P1_GT_UDF_BOUND[EXP_MSB-1:0]);
wire p2_is_arith_exp_gt_ovf_bound = p2_is_ovf ? p2_is_arith_exp_p1_gt_ovf_bound : p2_is_arith_exp_p0_gt_ovf_bound;
wire p2_is_arith_exp_gt_sub_bound = p2_is_ovf ? p2_is_arith_exp_p1_gt_sub_bound : p2_is_arith_exp_p0_gt_sub_bound;
wire p2_is_arith_exp_gt_udf_bound = p2_is_ovf ? p2_is_arith_exp_p1_gt_udf_bound : p2_is_arith_exp_p0_gt_udf_bound;
wire p2_is_arith_exp_udf = ~p2_is_arith_exp_gt_udf_bound;
wire p2_is_arith_exp_ovf =  p2_is_arith_exp_gt_ovf_bound;
wire p2_is_arith_exp_sub = ~p2_is_arith_exp_gt_sub_bound & p2_is_arith_exp_gt_udf_bound;
// #}}}
// #{{{ p2 stage tininess after rounding
// [003][002][001][000].[-01][-02][-03][-04][-05][-06][-07][-08][-09][-10][-11][-12]
//                                                                             [ S  ... ...    ]
// [mslice = y                                                 ][cslice       ][ls ] : ls(lslice)
//---------------------------------------------------------------------------------------------------------------------
//           [2'd0    ].[ 1 ][ 1 ][ 1 ][ 1 ][ 1 ][ 1 ][ 1 ][ 1 ][ 1 ]
//                                                              [ C ][   ][ L ][ R ]
// z_tininess                                                   [             ]
//---------------------------------------------------------------------------------------------------------------------
wire [-9:-11] p2_z_tininess = {1'b0,p2_cslice[-10:-11]} + {2'b0,(p2_ri & p2_sticky_novf) | (p2_rn & p2_lslice[-12])};
wire p2_is_tininess = ({p2_y0[1:-8],p2_cslice[-9]} == 11'b00111111111) & ~p2_z_tininess[-9];
// #}}}
// #{{{ p2 stage frd_rne_correction region detect
wire p2_is_udf_to_sub = |p2_frd_rne_correction[-9:-10];
wire p2_is_frd_rne_correction_ovf = ~p2_is_frd_inf & ~p2_is_frd_qnan & ~p2_is_frd_zero & ~p2_is_dz
                                  & p2_is_arith_exp_ovf;
wire p2_is_frd_rne_correction_sub = ~p2_is_frd_inf & ~p2_is_frd_qnan & ~p2_is_frd_zero & ~p2_is_dz
                                  & (p2_is_arith_exp_sub | (p2_is_arith_exp_udf & p2_is_udf_to_sub));
wire p2_is_frd_rne_correction_udf = ~p2_is_frd_inf & ~p2_is_frd_qnan & ~p2_is_frd_zero & ~p2_is_dz
                                  & (p2_is_arith_exp_udf & ~p2_is_udf_to_sub);
wire p2_is_frd_rne_correction_zero = ~p2_is_frd_inf & ~p2_is_frd_qnan & ~p2_is_dz
                                   & (p2_is_frd_zero | ~(|p2_frd_rne_correction));
// #}}}
// #{{{ p2 stage arith_op
wire [EXP_MSB:0] p2_arith_op_exp = p2_is_frd_rne_correction_sub ? {{(EXP_MSB){1'b0}},p2_frd_rne_correction[0]} : (p2_arith_exp + CONST_15[EXP_MSB:0] + {{(EXP_MSB){1'b0}},p2_is_ovf});
wire [FLEN-1:0] p2_arith_op = {p2_arith_sign,p2_arith_op_exp[4:0],p2_frd_rne_correction[-1:-10]};
// #}}}
// #{{{ p2 stage exception
wire p2_is_sub_to_norm = p2_frd_rne_correction[0];
wire p2_is_dz_exception = p2_is_dz;
wire p2_is_rs_exception = ~p2_is_frd_qnan & ~p2_is_frd_zero & ~p2_is_frd_inf & ~p2_is_dz & (p2_before_rounding_r_bit | p2_before_rounding_s_bit);
wire p2_is_udf_exception = (p2_is_frd_rne_correction_sub & (p2_before_rounding_r_bit | p2_before_rounding_s_bit) & (~p2_is_sub_to_norm | p2_is_tininess)) |
                              (p2_is_frd_rne_correction_udf & (p2_before_rounding_r_bit | p2_before_rounding_s_bit));
wire p2_is_ovf_exception = p2_is_frd_rne_correction_ovf;
wire unused_p2_is_nx_exception = p2_is_ovf_exception | p2_is_udf_exception | p2_is_rs_exception;
wire p2_is_nx_exception = p2_is_ovf_exception | p2_is_rs_exception; // more easier to acknowledge
// #}}}
// #{{{ p2 stage zero_sign
wire p2_zero_sign = ~p2_is_frd_zero & p2_is_frd_rne_correction_zero & ~p2_before_rounding_r_bit & ~p2_before_rounding_s_bit ? (p2_round_mode == ROUND_RDN) : p2_arith_sign;
// #}}}
// #{{{ p2 stage non_arith_op
wire p2_is_non_arith_op_largest = p2_is_frd_rne_correction_ovf & p2_rz;
wire p2_is_non_arith_op_inf = p2_is_frd_inf | (p2_is_frd_rne_correction_ovf & (p2_rn | p2_ri));
wire p2_is_non_arith_op_smallest = (p2_is_frd_rne_correction_udf & (p2_before_rounding_r_bit | p2_before_rounding_s_bit)) & p2_ri;
wire p2_is_non_arith_op_zero = p2_is_frd_rne_correction_zero | ((p2_is_frd_rne_correction_udf & (p2_before_rounding_r_bit | p2_before_rounding_s_bit)) & (p2_rn | p2_rz));
wire [FLEN-1:0] p2_non_arith_op = ({16{p2_is_frd_qnan}}              & {1'b0,5'h1f,10'h200})
                                | ({16{p2_is_non_arith_op_inf}}      & {p2_arith_sign,5'h1f,10'h0})
                                | ({16{p2_is_non_arith_op_zero}}     & {p2_zero_sign,5'h00,10'h0})
                                | ({16{p2_is_non_arith_op_largest}}  & {p2_arith_sign,5'h1e,10'h3ff})
                                | ({16{p2_is_non_arith_op_smallest}} & {p2_arith_sign,5'h00,10'h1});
wire p2_is_non_arith_op = p2_is_frd_qnan
                        | p2_is_non_arith_op_inf
                        | p2_is_non_arith_op_zero
                        | p2_is_non_arith_op_largest
                        | p2_is_non_arith_op_smallest;

wire [FLEN-1:0] p2_frac = p2_is_non_arith_op ? p2_non_arith_op : p2_arith_op;
wire [4:0] p2_flag = {5{p2_valid}} & {p2_is_frd_snan,p2_is_dz_exception,p2_is_ovf_exception,p2_is_udf_exception,p2_is_nx_exception};

assign p2_ready = fdiv_req_ready;
assign fdiv_req_valid = p2_valid;
assign fdiv_req_frd = p2_frac;
assign fdiv_req_flag = p2_flag;
// #}}}
endmodule
