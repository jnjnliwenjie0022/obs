module f16dsu (
     clk
    ,resetn
    ,dsu_i_valid
    ,dsu_i_ready
    ,dsu_i_ctrl
    ,dsu_i_pr0
    ,dsu_i_y
    ,dsu_o_ready
    ,dsu_o_r_done
    ,dsu_o_q_done
    ,dsu_o_d0
    ,dsu_o_d1
);
//                 [13][12][11].[10][9][8][7][6][5][4][3][2][1][0]
// pr0:            [S ][2'b0  ].[1 ][                            ]
// rqst_pr:        [                        ]
// y:                          .[1 ][                            ]
// rqst_y:                          [       ]
// q0:             [0 ][0 ][0 ] [                                ]
// q1:             [0 ][0 ][0 ] [                                ]
// r_c:            [                                             ]
// r_s:            [                                             ]
localparam FP16_FRAC_BITWIDTH = 10;
localparam FRAC_MSB = FP16_FRAC_BITWIDTH;
localparam PR_MSB = FRAC_MSB + 3; // partical remainder
localparam PR_LSB = 0;
localparam PR_BITWIDTH = PR_MSB - PR_LSB + 1;
localparam Y_MSB = FRAC_MSB;
localparam Y_LSB = 0;
localparam RQST_PR_BITWIDTH = 7; // RQST = redundant quotient selection table
localparam RQST_Y_BITWIDTH = 3;
localparam RQ_BITWIDTH = 3; // D = {-2,-1,0,1,2}
localparam ITER = PR_BITWIDTH/2 - 1;
localparam ITER_BITWIDTH = 3;

input                  clk;
input                  resetn;
input                  dsu_i_valid;
output                 dsu_i_ready;
input                  dsu_i_ctrl;
input  [PR_MSB:PR_LSB] dsu_i_pr0;
input  [Y_MSB:Y_LSB]   dsu_i_y;
input                  dsu_o_ready;
output                 dsu_o_r_done;
output                 dsu_o_q_done;
output [PR_MSB:PR_LSB] dsu_o_d0;
output [PR_MSB:PR_LSB] dsu_o_d1;

localparam ST_IDLE = 2'd0;
localparam ST_ITER = 2'd1;
localparam ST_DONE = 2'd2;

reg [1:0] cs;
reg [1:0] ns;
reg [PR_MSB:PR_LSB] pr_sum;
reg [PR_MSB:PR_LSB+1] pr_carry;
reg [Y_MSB:Y_LSB] y;
reg [ITER_BITWIDTH-1:0] iter;
reg [PR_MSB:PR_LSB] q0;
reg [PR_MSB:PR_LSB] q1;
reg [RQ_BITWIDTH-1:0] rq;
reg [PR_MSB:PR_LSB] y_mul_rq_1comp;
reg [1:0] q0_rq_ge_0;
reg [1:0] q0_rq_lt_0;
reg [1:0] q1_rq_gt_0;
reg [1:0] q1_rq_le_0;
wire [PR_MSB:PR_LSB] csa_sum;
wire [PR_MSB:PR_LSB+1] csa_carry;

wire o_ready = dsu_o_ready;
wire i_valid = dsu_i_valid;
wire ctrl = dsu_i_ctrl;
wire [PR_MSB:PR_LSB] pr0 = dsu_i_pr0;

wire is_last_iter = iter == ITER[ITER_BITWIDTH-1:0];
wire is_st_idle = cs == ST_IDLE;
wire is_st_iter = cs == ST_ITER;
wire is_st_done = cs == ST_DONE;

// iter
wire iter_en = ~is_last_iter | o_ready;
wire [ITER_BITWIDTH-1:0] iter_nx = is_st_iter ? iter + {{(ITER_BITWIDTH){1'd0}},1'd1} : {(ITER_BITWIDTH){1'd0}};

// y
wire y_en = is_st_idle | is_st_done;
wire [Y_MSB:Y_LSB] y_nx = dsu_i_y;

// pr
wire pr_en = is_st_idle | (is_st_iter & iter_en) | is_st_done;
wire pr_sum_sel_pr0 = is_st_idle | is_st_done;
wire pr_sum_sel_sum = is_st_iter;
wire pr_carry_sel_carry = is_st_iter;

wire [PR_MSB:PR_LSB+1]csa_carry_l = {csa_carry[PR_MSB-2:PR_LSB+1],2'd0};
wire [PR_MSB:PR_LSB]csa_sum_l = {csa_sum[PR_MSB-2:PR_LSB],2'd0};
wire [PR_MSB:PR_LSB+1] pr_carry_nx = pr_carry_sel_carry ? csa_carry_l : {(PR_BITWIDTH-1){1'd0}};
wire [PR_MSB:PR_LSB] pr_sum_nx = ({(PR_BITWIDTH){pr_sum_sel_pr0}} & pr0)
                               | ({(PR_BITWIDTH){pr_sum_sel_sum}} & csa_sum_l);
// rqst
wire [RQST_PR_BITWIDTH-1:0] rqst_pr = pr_sum[PR_MSB -:RQST_PR_BITWIDTH] + pr_carry[PR_MSB -:RQST_PR_BITWIDTH] + (pr_sum[PR_MSB-RQST_PR_BITWIDTH] & pr_carry[PR_MSB-RQST_PR_BITWIDTH]);
wire [RQST_Y_BITWIDTH-1:0] rqst_y = y[(Y_MSB-1) -:RQST_Y_BITWIDTH];


//always @* begin
//    case (rqst_pr)
//        7'b0000_000: begin
//            rq = 3'b000;
//        end
//        7'b0000_001: begin
//            rq = 3'b000;
//        end
//        7'b0000_010: begin
//            rq = 3'b000;
//        end
//        7'b0000_011: begin
//            rq = 3'b000;
//        end
//        7'b0000_100: begin
//            case (rqst_y)
//                3'b000: rq = 3'b001;
//                3'b001: rq = 3'b001;
//                3'b010: rq = 3'b001;
//                3'b011: rq = 3'b001;
//                default: begin
//                    rq = 3'b000;
//                end
//            endcase
//        end
//        7'b0000_101: begin
//            case (rqst_y)
//                3'b000: rq = 3'b001;
//                3'b001: rq = 3'b001;
//                3'b010: rq = 3'b001;
//                3'b011: rq = 3'b001;
//                default: begin
//                    rq = 3'b000;
//                end
//            endcase
//        end
//        7'b0000_110: begin
//            rq = 3'b001;
//        end
//        7'b0000_111: begin
//            rq = 3'b001;
//        end
//        7'b0001_000: begin
//            rq = 3'b001;
//        end
//        7'b0001_001: begin
//            rq = 3'b001;
//        end
//        7'b0001_010: begin
//            rq = 3'b001;
//        end
//        7'b0001_011: begin
//            rq = 3'b001;
//        end
//        7'b0001_100: begin
//            case (rqst_y)
//                3'b000: rq = 3'b010;
//                default: rq = 3'b001;
//            endcase
//        end
//        7'b0001_101: begin
//            case (rqst_y)
//                3'b000: rq = 3'b010;
//                default: rq = 3'b001;
//            endcase
//        end
//        7'b0001_110: begin
//            case (rqst_y)
//                3'b000: rq = 3'b010;
//                3'b001: rq = 3'b010;
//                default: rq = 3'b001;
//            endcase
//        end
//        7'b0001_111: begin
//            case (rqst_y)
//                3'b000: rq = 3'b010;
//                3'b001: rq = 3'b010;
//                default: rq = 3'b001;
//            endcase
//        end
//        7'b0010_000: begin
//            case (rqst_y)
//                3'b000: rq = 3'b010;
//                3'b001: rq = 3'b010;
//                3'b010: rq = 3'b010;
//                3'b011: rq = 3'b010;
//                default: rq = 3'b001;
//            endcase
//        end
//        7'b0010_001: begin
//            case (rqst_y)
//                3'b000: rq = 3'b010;
//                3'b001: rq = 3'b010;
//                3'b010: rq = 3'b010;
//                3'b011: rq = 3'b010;
//                default: rq = 3'b001;
//            endcase
//        end
//        7'b0010_010: begin
//            case (rqst_y)
//                3'b000: rq = 3'b010;
//                3'b001: rq = 3'b010;
//                3'b010: rq = 3'b010;
//                3'b011: rq = 3'b010;
//                default: rq = 3'b001;
//            endcase
//        end
//        7'b0010_011: begin
//            case (rqst_y)
//                3'b000: rq = 3'b010;
//                3'b001: rq = 3'b010;
//                3'b010: rq = 3'b010;
//                3'b011: rq = 3'b010;
//                3'b100: rq = 3'b010;
//                default: rq = 3'b001;
//            endcase
//        end
//        7'b0010_100: begin
//            case (rqst_y)
//                3'b110: rq = 3'b001;
//                3'b111: rq = 3'b001;
//                default: rq = 3'b010;
//            endcase
//        end
//        7'b0010_101: begin
//            case (rqst_y)
//                3'b110: rq = 3'b001;
//                3'b111: rq = 3'b001;
//                default: rq = 3'b010;
//            endcase
//        end
//        7'b1111_111: begin
//            rq = 3'b000;
//        end
//        7'b1111_110: begin
//            rq = 3'b000;
//        end
//        7'b1111_101: begin
//            rq = 3'b000;
//        end
//        7'b1111_100: begin
//            rq = 3'b000;
//        end
//        7'b1111_011: begin
//            case (rqst_y)
//                3'b000: rq = 3'b111;
//                3'b001: rq = 3'b111;
//                default: rq = 3'b000;
//            endcase
//        end
//        7'b1111_010: begin
//            case (rqst_y)
//                3'b000: rq = 3'b111;
//                3'b001: rq = 3'b111;
//                default: rq = 3'b000;
//            endcase
//        end
//        7'b1111_001: begin
//            rq = 3'b111;
//        end
//        7'b1111_000: begin
//            rq = 3'b111;
//        end
//        7'b1110_111: begin
//            rq = 3'b111;
//        end
//        7'b1110_110: begin
//            rq = 3'b111;
//        end
//        7'b1110_101: begin
//            rq = 3'b111;
//        end
//        7'b1110_100: begin
//            rq = 3'b111;
//        end
//        7'b1110_011: begin
//            rq = 3'b111;
//        end
//        7'b1110_010: begin
//            case (rqst_y)
//                3'b000: rq = 3'b110;
//                default: rq = 3'b111;
//            endcase
//        end
//        7'b1110_001: begin
//            case (rqst_y)
//                3'b000: rq = 3'b110;
//                3'b001: rq = 3'b110;
//                default: rq = 3'b111;
//            endcase
//        end
//        7'b1110_000: begin
//            case (rqst_y)
//                3'b000: rq = 3'b110;
//                3'b001: rq = 3'b110;
//                default: rq = 3'b111;
//            endcase
//        end
//        7'b1101_111: begin
//            case (rqst_y)
//                3'b000: rq = 3'b110;
//                3'b001: rq = 3'b110;
//                3'b010: rq = 3'b110;
//                default: rq = 3'b111;
//            endcase
//        end
//        7'b1101_110: begin
//            case (rqst_y)
//                3'b000: rq = 3'b110;
//                3'b001: rq = 3'b110;
//                3'b010: rq = 3'b110;
//                3'b011: rq = 3'b110;
//                default: rq = 3'b111;
//            endcase
//        end
//        7'b1101_101: begin
//            case (rqst_y)
//                3'b000: rq = 3'b110;
//                3'b001: rq = 3'b110;
//                3'b010: rq = 3'b110;
//                3'b011: rq = 3'b110;
//                default: rq = 3'b111;
//            endcase
//        end
//        7'b1101_100: begin
//            case (rqst_y)
//                3'b000: rq = 3'b110;
//                3'b001: rq = 3'b110;
//                3'b010: rq = 3'b110;
//                3'b011: rq = 3'b110;
//                default: rq = 3'b111;
//            endcase
//        end
//        7'b1101_011: begin
//            case (rqst_y)
//                3'b110: rq = 3'b111;
//                3'b111: rq = 3'b111;
//                default: rq = 3'b110;
//            endcase
//        end
//        7'b1101_010: begin
//            case (rqst_y)
//                3'b110: rq = 3'b111;
//                3'b111: rq = 3'b111;
//                default: rq = 3'b110;
//            endcase
//        end
//        default: begin
//            rq = {rqst_pr[6],2'b10};
//        end
//    endcase
//end
always @* begin
    case(rqst_pr)
        // pos
        7'd0,
        7'd1,
        7'd2,
        7'd3:  rq = 3'd0;
        7'd4:  rq = (rqst_y > 3'd0) ? 3'd0 : 3'd1;
        7'd5:  rq = (rqst_y > 3'd3) ? 3'd0 : 3'd1;
        7'd6:  rq = (rqst_y > 3'd5) ? 3'd0 : 3'd1;
        7'd7,
        7'd8,
        7'd9,
        7'd10,
        7'd11: rq = 3'd1;
        7'd12,
        7'd13: rq = (rqst_y > 3'd0) ? 3'd1 : 3'd2;
        7'd14: rq = (rqst_y > 3'd1) ? 3'd1 : 3'd2;
        7'd15: rq = (rqst_y > 3'd2) ? 3'd1 : 3'd2;
        7'd16,
        7'd17: rq = (rqst_y > 3'd3) ? 3'd1 : 3'd2;
        7'd18,
        7'd19: rq = (rqst_y > 3'd4) ? 3'd1 : 3'd2;
        7'd20: rq = (rqst_y > 3'd5) ? 3'd1 : 3'd2;
        7'd21,
        7'd22: rq = (rqst_y > 3'd6) ? 3'd1 : 3'd2;
        // neg
        -7'd1,
        -7'd2,
        -7'd3,
        -7'd4,
        -7'd5: rq = 3'd0;
        -7'd6: rq = (rqst_y > 3'd2) ? 3'd0 : -3'd1;
        -7'd7: rq = (rqst_y > 3'd5) ? 3'd0 : -3'd1;
        -7'd8,
        -7'd9,
        -7'd10,
        -7'd11,
        -7'd12,
        -7'd13: rq = -3'd1;
        -7'd14: rq = (rqst_y > 3'd0) ? -3'd1 : -3'd2;
        -7'd15: rq = (rqst_y > 3'd1) ? -3'd1 : -3'd2;
        -7'd16,
        -7'd17: rq = (rqst_y > 3'd2) ? -3'd1 : -3'd2;
        -7'd18: rq = (rqst_y > 3'd3) ? -3'd1 : -3'd2;
        -7'd19: rq = (rqst_y > 3'd4) ? -3'd1 : -3'd2;
        -7'd20,
        -7'd21: rq = (rqst_y > 3'd5) ? -3'd1 : -3'd2;
        -7'd22: rq = (rqst_y > 3'd6) ? -3'd1 : -3'd2;
        default: rq = rqst_pr[RQST_PR_BITWIDTH-1] ? -3'd2 : 3'd2;
    endcase
end

always @* begin
    case(rq)
         3'd0: y_mul_rq_1comp = {PR_BITWIDTH{1'b0}};
        -3'd1: y_mul_rq_1comp = {3'd0,y}; // 1y
        -3'd2: y_mul_rq_1comp = {2'd0,y,1'd0}; // 2y
         3'd1: y_mul_rq_1comp = ~{3'd0,y}; // -1y -1
         3'd2: y_mul_rq_1comp = ~{2'd0,y,1'd0}; // -2y -1
        default: y_mul_rq_1comp ={PR_BITWIDTH{1'bx}};
    endcase
end

wire rq_gt_0 = ~rq[2] & (|rq[1:0]);
wire rq_ge_0 = ~rq[2];

wire [PR_MSB:PR_LSB] csa_in0 = pr_sum;
wire [PR_MSB:PR_LSB] csa_in1 = {pr_carry,rq_gt_0}; // rq_gt_0: y_mul_rq 2's complement
wire [PR_MSB:PR_LSB] csa_cin = y_mul_rq_1comp;

// q0/q1
wire q_en = is_st_iter & (~is_last_iter | o_ready);
// q0_rq_ge_0 = rq          , rq >= 0
// q1_rq_gt_0 = rq - 1      , rq > 0
// q0_rq_lt_0 = 4 - abs(rq) , rq < 0
// q1_rq_le_0 = 3 - abs(rq) , rq <= 0

always @* begin
    case(rq)
        3'd0: begin
            q0_rq_ge_0 = 2'd0;
            q1_rq_le_0 = 2'd3;
        end
        3'd1: begin
            q0_rq_ge_0 = 2'd1;
            q1_rq_gt_0 = 2'd0;
        end
        3'd2: begin
            q0_rq_ge_0 = 2'd2;
            q1_rq_gt_0 = 2'd1;
        end
        -3'd1: begin
            q0_rq_lt_0 = 2'd3;
            q1_rq_le_0 = 2'd2;
        end
        -3'd2: begin
            q0_rq_lt_0 = 2'd2;
            q1_rq_le_0 = 2'd1;
        end
        default:begin
            q0_rq_ge_0 = 2'dx;
            q0_rq_lt_0 = 2'dx;
            q1_rq_gt_0 = 2'dx;
            q1_rq_le_0 = 2'dx;
        end
    endcase
end

wire [PR_MSB:PR_LSB] q0_nx;
wire [PR_MSB:PR_LSB] q1_nx;
assign q0_nx[PR_MSB:PR_LSB+2] = rq_ge_0 ? q0[PR_MSB-2:PR_LSB] : q1[PR_MSB-2:PR_LSB];
assign q0_nx[PR_LSB+1:PR_LSB] = rq_ge_0 ? q0_rq_ge_0 : q0_rq_lt_0;
assign q1_nx[PR_MSB:PR_LSB+2] = rq_gt_0 ? q0[PR_MSB-2:PR_LSB] : q1[PR_MSB-2:PR_LSB];
assign q1_nx[PR_LSB+1:PR_LSB] = rq_gt_0 ? q1_rq_gt_0 : q1_rq_le_0;

// cs
wire is_st_idle2iter = i_valid;
wire is_st_iter2done = is_last_iter & o_ready;
wire is_st_done2idle = o_ready;
wire is_st_done2iter = o_ready & i_valid;

always @* begin
    ns = ST_IDLE;
    case (cs)
        ST_IDLE:begin
            ns = is_st_idle2iter ? ST_ITER : ST_IDLE;
        end
        ST_ITER:begin
            ns = is_st_iter2done ? ST_DONE : ST_ITER;
        end
        ST_DONE:begin
            ns = is_st_done2idle ? ST_IDLE :
                 is_st_done2iter ? ST_ITER :
                                   ST_DONE;
        end
    endcase
end

always @ (posedge clk or negedge resetn) begin
    if (pr_en)
        pr_sum <= pr_sum_nx;
        pr_carry <= pr_carry_nx;
end

always @ (posedge clk or negedge resetn) begin
    if (y_en)
        y <= y_nx;
end

always @ (posedge clk or negedge resetn) begin
    if (iter_en)
        iter <= iter_nx;
end

always @ (posedge clk or negedge resetn) begin
    if (!resetn)
        cs <= 'd0;
    else
        cs <= ns;
end

always @ (posedge clk or negedge resetn) begin
    if (q_en) begin
        q0 <= q0_nx;
        q1 <= q1_nx;
    end
end

wire unused1;
kv_csa3_2 # (
    .CSA_WIDTH (PR_BITWIDTH )
) u_kv_csa3_2 (
     .in0  (csa_in0             )
    ,.in1  (csa_in1             )
    ,.cin  (csa_cin             )
    ,.sum  (csa_sum             )
    ,.cout ({unused1,csa_carry} )
);

wire [PR_MSB:PR_LSB] r_s = csa_sum;
wire [PR_MSB:PR_LSB] r_c = {csa_carry,1'd0};
assign dsu_o_d0 = is_st_iter ? r_s : q0;
assign dsu_o_d1 = is_st_iter ? r_c : q1;
assign dsu_o_r_done = is_last_iter;
assign dsu_o_q_done = is_st_done;

wire [26:0] unused_q = ((pr0 << 13) / y);
wire [26:0] unused_r = ((pr0 << 13) % y);

endmodule