module acc_dsu (
     clk
    ,resetn
    ,dsu_resp_valid
    ,dsu_resp_ready
    ,dsu_resp_is_div
    ,dsu_resp_is_exp_odd
    ,dsu_resp_x
    ,dsu_resp_d
    ,dsu_req_ready
    ,dsu_req_r_done
    ,dsu_req_q_done
    ,dsu_req_d0
    ,dsu_req_d1
);
// #{{{ declare
//======================================================================================================
// DIV
//                                        [3][2][1][0].[-1][-2][-3][-4][-5][-6][-7][-8][-9][-10][-11][-12]
// x:(2 > x >= 1)                                  [1].[                                       ]
// 4*r0:(2 > x = 4*r0 >= 1)               [S][2'd0][x                                          ][2'd0    ]
// d:                                              [1].[                                       ]
// rqst_pr_l2:                            [7b                     ]
// rqst_pd:                                           .[3b        ]
// r_c:                                   [                                                              ]
// r_s:                                   [                                                              ]
// r init = r_s init                      4*r0 = {3'b000,x,2'b00} = x
// r_c init                               0
// cnt init                               0
//                                                  |------q start point
// q0 init                                      [0][0].[0][0][                                           ]
// q1 init                                      [0][0].[0][0][                                           ]
//======================================================================================================
// SQRT
//                                        [3][2][1][0].[-1][-2][-3][-4][-5][-6][-7][-8][-9][-10][-11][-12]
// x:(2 > x >= 1)                                  [1].[                                       ]
// 4*r0:(1 > r0 >= 0.5, x_exp is odd )    [S][3'b0   ].[x                                           ][0  ]
// 4*r0:(0.5 > r0 >= 0.25, x_exp is even) [S][3'b0   ].[0 ][x                                            ]
// r1:(4*r0-1)
// 4*r1:(x_exp is even)                   [1][1][x                                             ][0  ][0  ]
// 4*r1:(x_exp is odd )                   [1][1][0][x                                               ][0  ]
// rqst_pr_l2:                            [7b                      ]
// rqst_pd:                                           .    [3b        ]
// r_c:                                   [                                                              ]
// r_s:                                   [                                                              ]
// r init = r_s init:(x_exp is odd )      4*r1 = {2'b11,x,3'b000}
// r init = r_s init:(x_exp is even)      4*r1 = {3'b110,x,2'b00}
// r_c init                               0
// cnt init                               1
//                                                          |------q start point
// q0 init                                      [0][1].[0 ][0 ]                                          ]
// q1 init                                      [0][0].[0 ][0 ]                                          ]
// q0_concat_rq                                 [cnt1].[cnt2  ][cnt3  ][cnt4  ][cnt5  ][cnt6   ][rq           ]
//=======================================================================================================
parameter X_BITWIDTH = 11;
parameter D_BITWIDTH = 11;
localparam D_MSB = 0;
localparam D_LSB = 1 - D_BITWIDTH;
localparam Q_MSB = 1;
localparam Q_LSB = -((X_BITWIDTH + 1) + (X_BITWIDTH + 1)%2);
localparam Q_BITWIDTH = Q_MSB - Q_LSB + 1;
localparam R_MSB = 3; // remainder
localparam R_LSB = Q_LSB;
localparam R_BITWIDTH = R_MSB - R_LSB + 1;
// RQST: redundant quotient selection table
localparam RQST_PR_BITWIDTH = 7;
localparam RQST_PD_BITWIDTH = 3;
localparam RQ_BITWIDTH = 3; // D = {-2,-1,0,1,2}
localparam Q_CONCAT_RQ_BITWIDTH = Q_BITWIDTH - 2 + RQ_BITWIDTH;
localparam Q_CONCAT_RQ_MSB = 1;
localparam Q_CONCAT_RQ_LSB = 2-Q_CONCAT_RQ_BITWIDTH;
localparam CNT_R_MINUS1 = Q_BITWIDTH/2 - 2;
localparam CNT_Q_MINUS1 = Q_BITWIDTH/2 - 1;
localparam CNT_BITWIDTH = $clog2(Q_BITWIDTH) + 1;
localparam ST_IDLE  = 2'd0;
localparam ST_RUN   = 2'd1;
localparam ST_RDONE = 2'd2;
localparam ST_QDONE = 2'd3;
localparam CONST_X = 32'dx;
localparam CONST_0 = 32'd0;
localparam CONST_1 = 32'd1;
localparam CONST_2 = 32'd2;
localparam CONST_3 = 32'd3;
localparam CONST_4 = 32'd4;
localparam CONST_5 = 32'd5;
localparam CONST_6 = 32'd6;

input clk;
input resetn;
input dsu_resp_valid;
output dsu_resp_ready;
input dsu_resp_is_div;
input dsu_resp_is_exp_odd;
input [X_BITWIDTH-1:0] dsu_resp_x;
input [D_BITWIDTH-1:0] dsu_resp_d;
input dsu_req_ready;
output dsu_req_r_done;
output dsu_req_q_done;
output [R_BITWIDTH-1:0] dsu_req_d0;
output [R_BITWIDTH-1:0] dsu_req_d1;

reg [1:0] cs;
reg [1:0] ns;
reg [1:R_LSB] q0;
reg [1:R_LSB] q1;
reg [3:R_LSB] r_s_l2;
reg [3:R_LSB] r_c_l2;
reg [0:D_LSB] d;
reg [CNT_BITWIDTH-1:0] cnt;

wire resp_valid = dsu_resp_valid;
wire resp_is_div = dsu_resp_is_div;
wire resp_is_exp_odd = dsu_resp_is_exp_odd;
wire [X_BITWIDTH-1:0] resp_x = dsu_resp_x;
wire [D_BITWIDTH-1:0] resp_d = dsu_resp_d;
wire req_ready = dsu_req_ready;
wire is_div = resp_is_div;
wire is_sqrt = ~resp_is_div;
wire is_exp1 = dsu_resp_is_exp_odd;
wire is_exp0 = ~dsu_resp_is_exp_odd;
// #}}}
// #{{{ single stage
// #{{{ cs
wire is_st_idle = cs == ST_IDLE;
wire is_st_run =  cs == ST_RUN;
wire is_st_rdone = cs == ST_RDONE;
wire is_st_qdone =  cs == ST_QDONE;
wire is_st_idle2run = resp_valid;
wire is_st_run2rdone = cnt == CNT_R_MINUS1[CNT_BITWIDTH-1:0];
wire is_st_rdone2qdone = req_ready;
wire is_st_qdone2run = resp_valid & req_ready;
wire is_st_qdone2idle = req_ready;
always @* begin
    ns = ST_IDLE;
    case(cs)
        ST_IDLE:  ns = is_st_idle2run ? ST_RUN : ST_IDLE;
        ST_RUN:   ns = is_st_run2rdone ? ST_RDONE : ST_RUN;
        ST_RDONE: ns = is_st_rdone2qdone ? ST_QDONE : ST_RDONE;
        ST_QDONE: ns = is_st_qdone2run ? ST_RUN :
                       is_st_qdone2idle ? ST_IDLE : ST_QDONE;
        default:  ns = {2{1'dx}};
    endcase
end
// #}}}
// #{{{ rqst_pr_l2 (rqst partial 4*remainder)
// data comes from r_l2
wire borrowin = r_s_l2[-4] & r_c_l2[-4];
wire [3:-3] pr_s_l2 = r_s_l2[3:-3];
wire [3:-3] pr_c_l2 = r_c_l2[3:-3];
wire [3:-3] rqst_pr_l2 = pr_s_l2 + pr_c_l2 + {6'd0,borrowin};
// #}}}
// #{{{ rqst_pd (rqst partial divisor)
// data comes from d and q
wire is_cnt_gt_1 = cnt > CONST_1[CNT_BITWIDTH-1:0];
wire is_cnt_eq_1 = cnt == CONST_1[CNT_BITWIDTH-1:0];
wire is_q_eq_1 = q0[1:0] == 2'd1 && ~(|q0[-1:R_LSB]);
wire is_q_ne_1 = ~is_q_eq_1;
wire is_sqrt_cnt_eq_1 = is_sqrt & is_cnt_eq_1;
wire is_sqrt_cnt_gt_1_q_eq_1 = is_sqrt & is_cnt_gt_1 & is_q_eq_1;
wire is_sqrt_cnt_gt_1_q_ne_1 = is_sqrt & is_cnt_gt_1 & is_q_ne_1;
wire [2:0] rqst_pd = ({3{is_div}} & d[-1 -:3])
                   | ({3{is_sqrt_cnt_eq_1}} & 3'b101)
                   | ({3{is_sqrt_cnt_gt_1_q_eq_1}} & 3'b111)
                   | ({3{is_sqrt_cnt_gt_1_q_ne_1}} & q0[-2 -:3]);
// #}}}
// #{{{ rqst_rq (redundant quotient)
reg [2:0] rq;
//always @* begin
//    case(rqst_pr_l2)
//        // pos
//        7'd0,
//        7'd1,
//        7'd2,
//        7'd3:  rq = 3'd0;
//        7'd4:  rq = (rqst_pd > 3'd0) ? 3'd0 : 3'd1;
//        7'd5:  rq = (rqst_pd > 3'd3) ? 3'd0 : 3'd1;
//        7'd6:  rq = (rqst_pd > 3'd5) ? 3'd0 : 3'd1;
//        7'd7,
//        7'd8,
//        7'd9,
//        7'd10,
//        7'd11: rq = 3'd1;
//        7'd12,
//        7'd13: rq = (rqst_pd > 3'd0) ? 3'd1 : 3'd2;
//        7'd14: rq = (rqst_pd > 3'd1) ? 3'd1 : 3'd2;
//        7'd15: rq = (rqst_pd > 3'd2) ? 3'd1 : 3'd2;
//        7'd16,
//        7'd17: rq = (rqst_pd > 3'd3) ? 3'd1 : 3'd2;
//        7'd18,
//        7'd19: rq = (rqst_pd > 3'd4) ? 3'd1 : 3'd2;
//        7'd20: rq = (rqst_pd > 3'd5) ? 3'd1 : 3'd2;
//        7'd21,
//        7'd22: rq = (rqst_pd > 3'd6) ? 3'd1 : 3'd2;
//        // neg
//        -7'd1,
//        -7'd2,
//        -7'd3,
//        -7'd4,
//        -7'd5: rq = 3'd0;
//        -7'd6: rq = (rqst_pd > 3'd2) ? 3'd0 : -3'd1;
//        -7'd7: rq = (rqst_pd > 3'd5) ? 3'd0 : -3'd1;
//        -7'd8,
//        -7'd9,
//        -7'd10,
//        -7'd11,
//        -7'd12,
//        -7'd13: rq = -3'd1;
//        -7'd14: rq = (rqst_pd > 3'd0) ? -3'd1 : -3'd2;
//        -7'd15: rq = (rqst_pd > 3'd1) ? -3'd1 : -3'd2;
//        -7'd16,
//        -7'd17: rq = (rqst_pd > 3'd2) ? -3'd1 : -3'd2;
//        -7'd18: rq = (rqst_pd > 3'd3) ? -3'd1 : -3'd2;
//        -7'd19: rq = (rqst_pd > 3'd4) ? -3'd1 : -3'd2;
//        -7'd20,
//        -7'd21: rq = (rqst_pd > 3'd5) ? -3'd1 : -3'd2;
//        -7'd22: rq = (rqst_pd > 3'd6) ? -3'd1 : -3'd2;
//        default: rq = rqst_pr_l2[3] ? -3'd2 : 3'd2;
//    endcase
//end
always @* begin
    case(rqst_pr_l2)
        // pos
        7'd0,
        7'd1,
        7'd2,
        7'd3:  rq = 3'd0;
        7'd4,
        7'd5:  rq = (rqst_pd > 3'd1) ? 3'd0 : 3'd1;
        7'd6,
        7'd7:  rq = (rqst_pd > 3'd4) ? 3'd0 : 3'd1;
        7'd8,
        7'd9,
        7'd10,
        7'd11: rq = 3'd1;
        7'd12,
        7'd13: rq = (rqst_pd > 3'd0) ? 3'd1 : 3'd2;
        7'd14,
        7'd15: rq = (rqst_pd > 3'd1) ? 3'd1 : 3'd2;
        7'd16: rq = (rqst_pd > 3'd2) ? 3'd1 : 3'd2;
        7'd17: rq = (rqst_pd > 3'd3) ? 3'd1 : 3'd2;
        7'd18,
        7'd19: rq = (rqst_pd > 3'd4) ? 3'd1 : 3'd2;
        7'd20,
        7'd21: rq = (rqst_pd > 3'd5) ? 3'd1 : 3'd2;
        7'd22: rq = (rqst_pd > 3'd6) ? 3'd1 : 3'd2;
        // neg
        -7'd1,
        -7'd2,
        -7'd3,
        -7'd4: rq = 3'd0;
        -7'd5,
        -7'd6: rq = (rqst_pd > 3'd1) ? 3'd0 : -3'd1;
        -7'd7,
        -7'd8: rq = (rqst_pd > 3'd4) ? 3'd0 : -3'd1;
        -7'd9,
        -7'd10,
        -7'd11,
        -7'd12,
        -7'd13: rq = -3'd1;
        -7'd14: rq = (rqst_pd > 3'd0) ? -3'd1 : -3'd2;
        -7'd15,
        -7'd16: rq = (rqst_pd > 3'd1) ? -3'd1 : -3'd2;
        -7'd17: rq = (rqst_pd > 3'd2) ? -3'd1 : -3'd2;
        -7'd18: rq = (rqst_pd > 3'd3) ? -3'd1 : -3'd2;
        -7'd19,
        -7'd20: rq = (rqst_pd > 3'd4) ? -3'd1 : -3'd2;
        -7'd21,
        -7'd22: rq = (rqst_pd > 3'd5) ? -3'd1 : -3'd2;
        -7'd23: rq = (rqst_pd > 3'd6) ? -3'd1 : -3'd2;
        default: rq = rqst_pr_l2[3] ? -3'd2 : 3'd2;
    endcase
end

wire rq_gt_0 = ~rq[2] & (|rq[1:0]);
wire rq_ge_0 = ~rq[2];
// #}}}
// #{{{ complement
wire complement = rq_gt_0;
// #}}}
// #{{{ div_dq_1comp
reg [3:R_LSB] div_dq_1comp;
always @* begin
    case(rq)
         3'd0: div_dq_1comp =  {R_BITWIDTH{1'b0}};
        -3'd1: div_dq_1comp =  {3'd0,d,2'd0}; // 1d
        -3'd2: div_dq_1comp =  {2'd0,d,3'd0}; // 2d
         3'd1: div_dq_1comp = ~{3'd0,d,2'd0}; // -1d -1
         3'd2: div_dq_1comp = ~{2'd0,d,3'd0}; // -2d -1
        default:
               div_dq_1comp =  {R_BITWIDTH{1'bx}};
    endcase
end
// #}}}
// #{{{ q_on_the_fly_conversion
reg [1:0] q0_2b;
reg [1:0] q1_2b;
reg [1:R_LSB] q0_a1;
reg [1:R_LSB] q1_a1;
// q0_rq_ge_0 = rq          , rq >= 0
// q1_rq_gt_0 = rq - 1      , rq > 0
// q0_rq_lt_0 = 4 - abs(rq) , rq < 0
// q1_rq_le_0 = 3 - abs(rq) , rq <= 0

always @* begin
    case(rq)
        3'd0: begin // 000
            q0_2b = 2'd0; // q0_rq_ge_0 = 2'd0;
            q1_2b = 2'd3; // q1_rq_le_0 = 2'd3;
        end
        3'd1: begin // 001
            q0_2b = 2'd1; // q0_rq_ge_0 = 2'd1;
            q1_2b = 2'd0; // q1_rq_gt_0 = 2'd0;
        end
        3'd2: begin // 010
            q0_2b = 2'd2; // q0_rq_ge_0 = 2'd2;
            q1_2b = 2'd1; // q1_rq_gt_0 = 2'd1;
        end
        -3'd1: begin // 111
            q0_2b = 2'd3; // q0_rq_lt_0 = 2'd3;
            q1_2b = 2'd2; // q1_rq_le_0 = 2'd2;
        end
        -3'd2: begin // 110
            q0_2b = 2'd2; // q0_rq_lt_0 = 2'd2;
            q1_2b = 2'd1; // q1_rq_le_0 = 2'd1;
        end
        default:begin
            q0_2b = 2'dx; // q0_rq_ge_0 = 2'dx;
            q1_2b = 2'dx; // q0_rq_lt_0 = 2'dx;
                          // q1_rq_gt_0 = 2'dx;
                          // q1_rq_le_0 = 2'dx;
        end
    endcase
end

always @* begin
    case (cnt)
        CONST_0[0 +:CNT_BITWIDTH]: begin
            q0_a1 = {q0_2b, {(Q_BITWIDTH-(1)*2){1'd0}}};
            q1_a1 = {q1_2b, {(Q_BITWIDTH-(1)*2){1'd0}}};
        end
        CONST_1[0 +:CNT_BITWIDTH]: begin
            q0_a1 = rq_ge_0 ? {q0[1 -:(1)*2],q0_2b,{(Q_BITWIDTH-(2)*2){1'd0}}} : {q1[1 -:(1)*2],q0_2b, {(Q_BITWIDTH-(2)*2){1'd0}}};
            q1_a1 = rq_gt_0 ? {q0[1 -:(1)*2],q1_2b,{(Q_BITWIDTH-(2)*2){1'd0}}} : {q1[1 -:(1)*2],q1_2b, {(Q_BITWIDTH-(2)*2){1'd0}}};
        end
        CONST_2[0 +:CNT_BITWIDTH]: begin
            q0_a1 = rq_ge_0 ? {q0[1 -:(2)*2],q0_2b,{(Q_BITWIDTH-(3)*2){1'd0}}} : {q1[1 -:(2)*2],q0_2b, {(Q_BITWIDTH-(3)*2){1'd0}}};
            q1_a1 = rq_gt_0 ? {q0[1 -:(2)*2],q1_2b,{(Q_BITWIDTH-(3)*2){1'd0}}} : {q1[1 -:(2)*2],q1_2b, {(Q_BITWIDTH-(3)*2){1'd0}}};
        end
        CONST_3[0 +:CNT_BITWIDTH]: begin
            q0_a1 = rq_ge_0 ? {q0[1 -:(3)*2],q0_2b,{(Q_BITWIDTH-(4)*2){1'd0}}} : {q1[1 -:(3)*2],q0_2b, {(Q_BITWIDTH-(4)*2){1'd0}}};
            q1_a1 = rq_gt_0 ? {q0[1 -:(3)*2],q1_2b,{(Q_BITWIDTH-(4)*2){1'd0}}} : {q1[1 -:(3)*2],q1_2b, {(Q_BITWIDTH-(4)*2){1'd0}}};
        end
        CONST_4[0 +:CNT_BITWIDTH]: begin
            q0_a1 = rq_ge_0 ? {q0[1 -:(4)*2],q0_2b,{(Q_BITWIDTH-(5)*2){1'd0}}} : {q1[1 -:(4)*2],q0_2b, {(Q_BITWIDTH-(5)*2){1'd0}}};
            q1_a1 = rq_gt_0 ? {q0[1 -:(4)*2],q1_2b,{(Q_BITWIDTH-(5)*2){1'd0}}} : {q1[1 -:(4)*2],q1_2b, {(Q_BITWIDTH-(5)*2){1'd0}}};
        end
        CONST_5[0 +:CNT_BITWIDTH]: begin
            q0_a1 = rq_ge_0 ? {q0[1 -:(5)*2],q0_2b,{(Q_BITWIDTH-(6)*2){1'd0}}} : {q1[1 -:(5)*2],q0_2b, {(Q_BITWIDTH-(6)*2){1'd0}}};
            q1_a1 = rq_gt_0 ? {q0[1 -:(5)*2],q1_2b,{(Q_BITWIDTH-(6)*2){1'd0}}} : {q1[1 -:(5)*2],q1_2b, {(Q_BITWIDTH-(6)*2){1'd0}}};
        end
        CONST_6[0 +:CNT_BITWIDTH]: begin
            q0_a1 = rq_ge_0 ? {q0[1 -:(6)*2],q0_2b} : {q1[1 -:(6)*2],q0_2b};
            q1_a1 = rq_gt_0 ? {q0[1 -:(6)*2],q1_2b} : {q1[1 -:(6)*2],q1_2b};
        end
        default: begin
            q0_a1 = {Q_BITWIDTH{1'dx}};
            q1_a1 = {Q_BITWIDTH{1'dx}};
        end
    endcase
end

wire [1:R_LSB] q0_nx = is_st_run | is_st_rdone ? q0_a1 : {1'd0,is_sqrt,{(Q_BITWIDTH-2){1'd0}}};
wire [1:R_LSB] q1_nx = is_st_run | is_st_rdone ? q1_a1 : {Q_BITWIDTH{1'd0}};
// #}}}
// #{{{ q_concat_rq
reg [1:Q_CONCAT_RQ_LSB] q0_concat_rq;
reg [1:Q_CONCAT_RQ_LSB] q1_concat_rq;
always @* begin
    case (cnt)
        CONST_1[0 +:CNT_BITWIDTH]: begin
            q0_concat_rq = {q0[1 -:(1)*2],rq,{(Q_CONCAT_RQ_BITWIDTH-3-(1)*2){1'd0}}};
            q1_concat_rq = {q1[1 -:(1)*2],rq,{(Q_CONCAT_RQ_BITWIDTH-3-(1)*2){1'd0}}};
        end
        CONST_2[0 +:CNT_BITWIDTH]: begin
            q0_concat_rq = {q0[1 -:(2)*2],rq,{(Q_CONCAT_RQ_BITWIDTH-3-(2)*2){1'd0}}};
            q1_concat_rq = {q1[1 -:(2)*2],rq,{(Q_CONCAT_RQ_BITWIDTH-3-(2)*2){1'd0}}};
        end
        CONST_3[0 +:CNT_BITWIDTH]: begin
            q0_concat_rq = {q0[1 -:(3)*2],rq,{(Q_CONCAT_RQ_BITWIDTH-3-(3)*2){1'd0}}};
            q1_concat_rq = {q1[1 -:(3)*2],rq,{(Q_CONCAT_RQ_BITWIDTH-3-(3)*2){1'd0}}};
        end
        CONST_4[0 +:CNT_BITWIDTH]: begin
            q0_concat_rq = {q0[1 -:(4)*2],rq,{(Q_CONCAT_RQ_BITWIDTH-3-(4)*2){1'd0}}};
            q1_concat_rq = {q1[1 -:(4)*2],rq,{(Q_CONCAT_RQ_BITWIDTH-3-(4)*2){1'd0}}};
        end
        CONST_5[0 +:CNT_BITWIDTH]: begin
            q0_concat_rq = {q0[1 -:(5)*2],rq,{(Q_CONCAT_RQ_BITWIDTH-3-(5)*2){1'd0}}};
            q1_concat_rq = {q1[1 -:(5)*2],rq,{(Q_CONCAT_RQ_BITWIDTH-3-(5)*2){1'd0}}};
        end
        CONST_6[0 +:CNT_BITWIDTH]: begin
            q0_concat_rq = {q0[1 -:(6)*2],rq};
            q1_concat_rq = {q1[1 -:(6)*2],rq};
        end
        default: begin
            q0_concat_rq = {(Q_CONCAT_RQ_BITWIDTH){1'dx}};
            q1_concat_rq = {(Q_CONCAT_RQ_BITWIDTH){1'dx}};
        end
    endcase
end

// #}}}
// #{{{ sqrt_dq_1comp
reg [3:R_LSB] sqrt_dq_1comp;
always @* begin
    case(rq)
         3'd0: sqrt_dq_1comp =  {R_BITWIDTH{1'd0}};
        -3'd1: sqrt_dq_1comp =  {1'd0,q1_concat_rq}; //  2*q1_concat_rq
        -3'd2: sqrt_dq_1comp =  {q1_concat_rq,1'd0}; //  4*q1_concat_rq
         3'd1: sqrt_dq_1comp = ~{1'd0,q0_concat_rq}; // -2*q0_concat_rq -1
         3'd2: sqrt_dq_1comp = ~{q0_concat_rq,1'd0}; // -4*q0_concat_rq -1
        default:
               sqrt_dq_1comp =  {R_BITWIDTH{1'dx}};
    endcase
end
// #}}}
// #{{{ csa3to2
///////////////////////////////////////////////////////////////////////////////////////////////////
wire [R_BITWIDTH-1:0] csa3to2_in0;
wire [R_BITWIDTH-1:0] csa3to2_in1;
wire [R_BITWIDTH-1:0] csa3to2_cin;
wire [R_BITWIDTH-1:0] csa3to2_sum;
wire [R_BITWIDTH-1:0] csa3to2_cout;

assign csa3to2_in0 = r_s_l2[3:R_LSB];
assign csa3to2_in1 = {r_c_l2[3:R_LSB+1],complement}; // r_c_l2_lsb is always "0"
assign csa3to2_cin = is_div ? div_dq_1comp : sqrt_dq_1comp;

acc_csa3to2 # (
    .CSA_WIDTH (R_BITWIDTH )
) u_acc_csa3to2 (
     .in0  (csa3to2_in0  )
    ,.in1  (csa3to2_in1  )
    ,.cin  (csa3to2_cin  )
    ,.sum  (csa3to2_sum  )
    ,.cout (csa3to2_cout )
);

wire [3:R_LSB] csa_s = csa3to2_sum[R_BITWIDTH-1:0];
wire [3:R_LSB] csa_c = {csa3to2_cout[R_BITWIDTH-2:0],1'd0};
///////////////////////////////////////////////////////////////////////////////////////////////////
// #}}}
// #{{{ r_l2
// data comes from init and csa
wire sel_div_r0_l2 = (is_st_idle | is_st_qdone) & is_div;
wire sel_r_s_l2_a1 = is_st_run | is_st_rdone;
wire sel_r_c_l2_a1 = is_st_run | is_st_rdone;
wire sel_exp0_sqrt_r1_l2 = (is_st_idle | is_st_qdone) & is_sqrt & is_exp0;
wire sel_exp1_sqrt_r1_l2 = (is_st_idle | is_st_qdone) & is_sqrt & is_exp1;
wire [3:R_LSB] r_s = csa_s; // current remainder_s
wire [3:R_LSB] r_c = csa_c; // current remainder_c
wire [3:R_LSB] r_s_l2_a1 = {csa_s[1:R_LSB],2'b0}; // ahead 1T remainder_s << 2
wire [3:R_LSB] r_c_l2_a1 = {csa_c[1:R_LSB],2'b0}; // ahead 1T remainder_c << 2
wire [3:R_LSB] div_r0_l2 = {3'b000,resp_x,2'b00};
wire [3:R_LSB] exp0_sqrt_r1_l2 = {3'b110,resp_x,2'b00};
wire [3:R_LSB] exp1_sqrt_r1_l2 = {2'b11,resp_x,3'b000};
wire [3:R_LSB] r_s_l2_nx = ({R_BITWIDTH{sel_div_r0_l2}} & div_r0_l2)
                             | ({R_BITWIDTH{sel_exp0_sqrt_r1_l2}} & exp0_sqrt_r1_l2)
                             | ({R_BITWIDTH{sel_exp1_sqrt_r1_l2}} & exp1_sqrt_r1_l2)
                             | ({R_BITWIDTH{sel_r_s_l2_a1}} & r_s_l2_a1);
wire [3:R_LSB] r_c_l2_nx = sel_r_c_l2_a1 ? r_c_l2_a1 : {R_BITWIDTH{1'd0}};
// #}}}
// #{{{ d
// data comes from init
wire [0:D_LSB] d_nx = resp_d;
// #}}}
// #{{{ cnt
wire sel_cnt_0 = (is_st_idle | is_st_qdone) & is_div;
wire sel_cnt_1 = (is_st_idle | is_st_qdone) & is_sqrt;
wire sel_cnt_plus1 = is_st_run | is_st_rdone;
wire [CNT_BITWIDTH-1:0] cnt_plus1 = cnt + CONST_1[0 +:CNT_BITWIDTH];
wire [CNT_BITWIDTH-1:0] cnt_nx = ({CNT_BITWIDTH{sel_cnt_0}} & CONST_0[0 +:CNT_BITWIDTH])
                               | ({CNT_BITWIDTH{sel_cnt_1}} & CONST_1[0 +:CNT_BITWIDTH])
                               | ({CNT_BITWIDTH{sel_cnt_plus1}} & cnt_plus1);
// #}}}
wire en = (is_st_idle & resp_valid) | is_st_run | (is_st_rdone | req_ready) | (is_st_qdone & req_ready);
wire d_en = is_st_idle | (is_st_qdone & req_ready);

always @ (posedge clk or negedge resetn) begin
    if (!resetn)
        cnt <= {CNT_BITWIDTH{1'd0}};
    else if (en)
        cnt <= cnt_nx;
end

always @ (posedge clk) begin
    if (en) begin
        q0 <= q0_nx;
        q1 <= q1_nx;
        r_s_l2 <= r_s_l2_nx;
        r_c_l2 <= r_c_l2_nx;
    end
end

always @ (posedge clk)
    if (d_en)
        d <= d_nx;

always @ (posedge clk or negedge resetn)
    if (!resetn)
        cs <= 2'd0;
    else
        cs <= ns;

assign dsu_resp_ready = is_st_idle | (is_st_qdone & req_ready);
assign dsu_req_r_done = is_st_rdone;
assign dsu_req_q_done = is_st_qdone;
assign dsu_req_d0 = is_st_qdone ? {2'd0,q0} : r_s;
assign dsu_req_d1 = is_st_qdone ? {2'd0,q1} : r_c;

wire [3:R_LSB] unused_r = r_s + r_c;

endmodule
// #}}}
