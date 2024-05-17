// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fpu (
    core_clk,
    core_reset_n,
    fpu_ipipe_standby_ready,
    fpu_ipipe_fdiv_standby_ready,
    fpu_i0_ctrl,
    fpu_i0_valid,
    fpu_i0_frs1,
    fpu_i0_frs2,
    fpu_i0_frs3,
    fpu_i1_ctrl,
    fpu_i1_valid,
    fpu_i1_frs1,
    fpu_i1_frs2,
    fpu_i1_frs3,
    fpu_lx_stall,
    fpu_fmis_result,
    fmis_flag_set,
    fpu_fmv_result,
    fpu_fmac32_result,
    fpu_fmac64_result,
    fmac_flag_set,
    fdiv_req_ready,
    fdiv_resp_tag,
    fdiv_resp_result,
    fdiv_resp_valid,
    fdiv_resp_ready,
    fdiv_resp_flag_set,
    fdiv_kill
);
parameter FLEN = 32;
parameter XLEN = 64;
input core_clk;
input core_reset_n;
input [22 - 1:0] fpu_i0_ctrl;
input fpu_i0_valid;
input [63:0] fpu_i0_frs1;
input [FLEN - 1:0] fpu_i0_frs2;
input [FLEN - 1:0] fpu_i0_frs3;
input [22 - 1:0] fpu_i1_ctrl;
input fpu_i1_valid;
input [63:0] fpu_i1_frs1;
input [FLEN - 1:0] fpu_i1_frs2;
input [FLEN - 1:0] fpu_i1_frs3;
input fpu_lx_stall;
output fpu_ipipe_standby_ready;
output fpu_ipipe_fdiv_standby_ready;
output [63:0] fpu_fmis_result;
output [4:0] fmis_flag_set;
output [63:0] fpu_fmv_result;
output [FLEN - 1:0] fpu_fmac32_result;
output [FLEN - 1:0] fpu_fmac64_result;
output [4:0] fmac_flag_set;
output fdiv_req_ready;
output [FLEN - 1:0] fdiv_resp_result;
output [4:0] fdiv_resp_tag;
output fdiv_resp_valid;
input fdiv_resp_ready;
output [4:0] fdiv_resp_flag_set;
input fdiv_kill;


wire [FLEN - 1:0] f0_fmac_frs1;
wire [FLEN - 1:0] f0_fmac_frs2;
wire [FLEN - 1:0] f0_fmac_frs3;
wire f0_fmac_valid;
wire [22 - 1:0] f0_fmac_ctrl;
wire [10:0] f0_fmac_align_amount_adjustment;
wire [63:0] f0_fdiv_frs1;
wire [FLEN - 1:0] f0_fdiv_frs2;
wire f0_fdiv_valid;
wire [22 - 1:0] f0_fdiv_ctrl;
wire [63:0] f0_fmis_frs1;
wire [FLEN - 1:0] f0_fmis_frs2;
wire f0_fmis_valid;
wire [22 - 1:0] f0_fmis_ctrl;
wire [63:0] f0_fmv_frs1;
wire [FLEN - 1:0] f0_fmv_frs2;
wire f0_fmv_valid;
wire [22 - 1:0] f0_fmv_ctrl;
reg [FLEN - 1:0] f1_fmac_frs1;
reg [FLEN - 1:0] f1_fmac_frs2;
reg [FLEN - 1:0] f1_fmac_frs3;
reg f1_fmac_valid;
reg [22 - 1:0] f1_fmac_ctrl;
reg [10:0] f1_fmac_align_amount_adjustment;
reg [63:0] f1_fdiv_frs1;
reg [FLEN - 1:0] f1_fdiv_frs2;
reg f1_fdiv_valid;
reg [22 - 1:0] f1_fdiv_ctrl;
reg [63:0] f1_fmis_frs1;
reg [FLEN - 1:0] f1_fmis_frs2;
reg f1_fmis_valid;
reg [22 - 1:0] f1_fmis_ctrl;
reg [63:0] f1_fmv_frs1;
reg [FLEN - 1:0] f1_fmv_frs2;
reg f1_fmv_valid;
reg [22 - 1:0] f1_fmv_ctrl;
wire [1:0] nds_unused_result_type_fdiv;
wire [1:0] nds_unused_result_type_fmac;
wire nds_unused_wdata_en_fmac;
wire nds_unused_cmp_result;
wire [63:0] nds_unused_fmis_narr_wdata64;
wire [1:0] nds_unused_result_type_fmis;
wire nds_unused_wdata_en_fmis;
wire [4:0] fdiv_flag_set;
wire [4:0] fmac_flag_set;
wire [4:0] fmis_flag_set;
wire nds_unused_all = (|nds_unused_result_type_fdiv) | (|nds_unused_result_type_fmac) | nds_unused_wdata_en_fmac | nds_unused_cmp_result | (|nds_unused_fmis_narr_wdata64) | (|nds_unused_result_type_fmis) | nds_unused_wdata_en_fmis;
wire fmac_standby_ready;
wire fdiv_standby_ready;
wire fmis_standby_ready;
wire fmv_standby_ready;
assign fpu_ipipe_standby_ready = fmac_standby_ready & fdiv_standby_ready & fmis_standby_ready & fmv_standby_ready;
assign fpu_ipipe_fdiv_standby_ready = fdiv_standby_ready;
wire [2:0] f0_fmac_sew;
assign f0_fmac_sew = f0_fmac_ctrl[18 +:3];
assign f0_fmac_valid = fpu_i0_valid & fpu_i0_ctrl[12] | fpu_i1_valid & fpu_i1_ctrl[12];
assign f0_fdiv_valid = fpu_i0_valid & fpu_i0_ctrl[6] | fpu_i1_valid & fpu_i1_ctrl[6];
assign f0_fmis_valid = fpu_i0_valid & fpu_i0_ctrl[13] | fpu_i1_valid & fpu_i1_ctrl[13];
assign f0_fmv_valid = fpu_i0_valid & fpu_i0_ctrl[14] | fpu_i1_valid & fpu_i1_ctrl[14];
assign f0_fmac_frs1 = (fpu_i0_valid & fpu_i0_ctrl[12]) ? fpu_i0_frs1[FLEN - 1:0] : fpu_i1_frs1[FLEN - 1:0];
assign f0_fmac_frs2 = (fpu_i0_valid & fpu_i0_ctrl[12]) ? fpu_i0_frs2[FLEN - 1:0] : fpu_i1_frs2[FLEN - 1:0];
assign f0_fmac_frs3 = (fpu_i0_valid & fpu_i0_ctrl[12]) ? fpu_i0_frs3[FLEN - 1:0] : fpu_i1_frs3[FLEN - 1:0];
assign f0_fmac_ctrl = (fpu_i0_valid & fpu_i0_ctrl[12]) ? fpu_i0_ctrl : fpu_i1_ctrl;
assign f0_fmac_align_amount_adjustment = ({11{f0_fmac_sew[2]}} & 11'h43a) | ({11{f0_fmac_sew[1]}} & 11'h79d) | ({11{f0_fmac_sew[0]}} & 11'h000);
assign f0_fdiv_frs1 = (fpu_i0_valid & fpu_i0_ctrl[6]) ? fpu_i0_frs1[63:0] : fpu_i1_frs1[63:0];
assign f0_fdiv_frs2 = (fpu_i0_valid & fpu_i0_ctrl[6]) ? fpu_i0_frs2[FLEN - 1:0] : fpu_i1_frs2[FLEN - 1:0];
assign f0_fdiv_ctrl = (fpu_i0_valid & fpu_i0_ctrl[6]) ? fpu_i0_ctrl : fpu_i1_ctrl;
assign f0_fmis_frs1 = (fpu_i0_valid & fpu_i0_ctrl[13]) ? fpu_i0_frs1 : fpu_i1_frs1;
assign f0_fmis_frs2 = (fpu_i0_valid & fpu_i0_ctrl[13]) ? fpu_i0_frs2[FLEN - 1:0] : fpu_i1_frs2[FLEN - 1:0];
assign f0_fmis_ctrl = (fpu_i0_valid & fpu_i0_ctrl[13]) ? fpu_i0_ctrl : fpu_i1_ctrl;
assign f0_fmv_frs1 = (fpu_i0_valid & fpu_i0_ctrl[14]) ? fpu_i0_frs1 : fpu_i1_frs1;
assign f0_fmv_frs2 = (fpu_i0_valid & fpu_i0_ctrl[14]) ? fpu_i0_frs2 : fpu_i1_frs2;
assign f0_fmv_ctrl = (fpu_i0_valid & fpu_i0_ctrl[14]) ? fpu_i0_ctrl : fpu_i1_ctrl;
wire [2:0] f0_fmis_sew = f0_fmis_ctrl[18 +:3];
wire f0_fmis_sew_16_bit = f0_fmis_sew[0];
wire f0_fmis_sew_32_bit = f0_fmis_sew[1];
wire f0_fmis_sew_64_bit = f0_fmis_sew[2];
wire f0_fmis_sp_support = (FLEN == 32) | (FLEN == 64);
wire f0_fmis_dp_support = (FLEN == 64);
wire f0_fmis_fcvtwh = (f0_fmis_ctrl[4:0] == 5'b11100) & f0_fmis_sew_16_bit;
wire f0_fmis_fcvtws = (f0_fmis_ctrl[4:0] == 5'b11100) & f0_fmis_sew_32_bit & f0_fmis_sp_support;
wire f0_fmis_fcvtwd = (f0_fmis_ctrl[4:0] == 5'b11100) & f0_fmis_sew_64_bit & f0_fmis_dp_support;
wire f0_fmis_fcvtlh = (f0_fmis_ctrl[4:0] == 5'b11101) & f0_fmis_sew_16_bit;
wire f0_fmis_fcvtls = (f0_fmis_ctrl[4:0] == 5'b11101) & f0_fmis_sew_32_bit & f0_fmis_sp_support;
wire f0_fmis_fcvtld = (f0_fmis_ctrl[4:0] == 5'b11101) & f0_fmis_sew_64_bit & f0_fmis_dp_support;
wire f0_fmis_fcvthw = (f0_fmis_ctrl[4:0] == 5'b11010) & f0_fmis_sew_32_bit;
wire f0_fmis_fcvthl = (f0_fmis_ctrl[4:0] == 5'b11010) & f0_fmis_sew_64_bit;
wire f0_fmis_fcvtsw = (f0_fmis_ctrl[4:0] == 5'b11000) & f0_fmis_sew_32_bit & f0_fmis_sp_support;
wire f0_fmis_fcvtsl = (f0_fmis_ctrl[4:0] == 5'b11000) & f0_fmis_sew_64_bit & f0_fmis_sp_support;
wire f0_fmis_fcvtdw = (f0_fmis_ctrl[4:0] == 5'b11001) & f0_fmis_sew_32_bit & f0_fmis_dp_support;
wire f0_fmis_fcvtdl = (f0_fmis_ctrl[4:0] == 5'b11001) & f0_fmis_sew_64_bit & f0_fmis_dp_support;
wire f0_fmis_fcvths = (f0_fmis_ctrl[4:0] == 5'b10010) & f0_fmis_sew_32_bit & f0_fmis_sp_support;
wire f0_fmis_fcvthd = (f0_fmis_ctrl[4:0] == 5'b10010) & f0_fmis_sew_64_bit & f0_fmis_dp_support;
wire f0_fmis_fcvtsh = (f0_fmis_ctrl[4:0] == 5'b10000) & f0_fmis_sew_16_bit & f0_fmis_sp_support;
wire f0_fmis_fcvtsd = (f0_fmis_ctrl[4:0] == 5'b10000) & f0_fmis_sew_64_bit & f0_fmis_dp_support;
wire f0_fmis_fcvtdh = (f0_fmis_ctrl[4:0] == 5'b10001) & f0_fmis_sew_16_bit & f0_fmis_dp_support;
wire f0_fmis_fcvtds = (f0_fmis_ctrl[4:0] == 5'b10001) & f0_fmis_sew_32_bit & f0_fmis_dp_support;
wire f0_fmis_fcvtbs = (f0_fmis_ctrl[4:0] == 5'b10101) & f0_fmis_sp_support;
wire f0_fmis_fcvtsb = (f0_fmis_ctrl[4:0] == 5'b10100) & f0_fmis_sp_support;
wire f0_fmis_fmin = (f0_fmis_ctrl[4:0] == 5'b00101);
wire f0_fmis_fmax = (f0_fmis_ctrl[4:0] == 5'b00100);
wire f0_fmis_feq = (f0_fmis_ctrl[4:0] == 5'b01010);
wire f0_fmis_fle = (f0_fmis_ctrl[4:0] == 5'b01000);
wire f0_fmis_flt = (f0_fmis_ctrl[4:0] == 5'b01001);
wire f0_fmis_fclass = (f0_fmis_ctrl[4:0] == 5'b01101);
reg f1_fmis_fcvtwh;
reg f1_fmis_fcvtws;
reg f1_fmis_fcvtwd;
reg f1_fmis_fcvtlh;
reg f1_fmis_fcvtls;
reg f1_fmis_fcvtld;
reg f1_fmis_fcvthw;
reg f1_fmis_fcvthl;
reg f1_fmis_fcvtsw;
reg f1_fmis_fcvtsl;
reg f1_fmis_fcvtdw;
reg f1_fmis_fcvtdl;
reg f1_fmis_fcvths;
reg f1_fmis_fcvthd;
reg f1_fmis_fcvtsh;
reg f1_fmis_fcvtsd;
reg f1_fmis_fcvtdh;
reg f1_fmis_fcvtds;
reg f1_fmis_fcvtbs;
reg f1_fmis_fcvtsb;
reg f1_fmis_fmin;
reg f1_fmis_fmax;
reg f1_fmis_feq;
reg f1_fmis_fle;
reg f1_fmis_flt;
reg f1_fmis_fclass;
wire f1_valid_en;
assign f1_valid_en = (f1_fmac_valid | f1_fdiv_valid | f1_fmis_valid | f1_fmv_valid | fpu_i0_valid | fpu_i1_valid) & ~fpu_lx_stall;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f1_fmac_valid <= 1'b0;
        f1_fdiv_valid <= 1'b0;
        f1_fmis_valid <= 1'b0;
        f1_fmv_valid <= 1'b0;
    end
    else if (f1_valid_en) begin
        f1_fmac_valid <= f0_fmac_valid;
        f1_fdiv_valid <= f0_fdiv_valid;
        f1_fmis_valid <= f0_fmis_valid;
        f1_fmv_valid <= f0_fmv_valid;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f1_fmac_frs1 <= {FLEN{1'b0}};
        f1_fmac_frs2 <= {FLEN{1'b0}};
        f1_fmac_frs3 <= {FLEN{1'b0}};
        f1_fmac_align_amount_adjustment <= 11'b0;
        f1_fmac_ctrl <= {22{1'b0}};
    end
    else if (f0_fmac_valid & ~fpu_lx_stall) begin
        f1_fmac_frs1 <= f0_fmac_frs1;
        f1_fmac_frs2 <= f0_fmac_frs2;
        f1_fmac_frs3 <= f0_fmac_frs3;
        f1_fmac_align_amount_adjustment <= f0_fmac_align_amount_adjustment;
        f1_fmac_ctrl <= f0_fmac_ctrl;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f1_fdiv_frs1 <= 64'b0;
        f1_fdiv_frs2 <= {FLEN{1'b0}};
        f1_fdiv_ctrl <= {22{1'b0}};
    end
    else if (f0_fdiv_valid & ~fpu_lx_stall) begin
        f1_fdiv_frs1 <= f0_fdiv_frs1;
        f1_fdiv_frs2 <= f0_fdiv_frs2;
        f1_fdiv_ctrl <= f0_fdiv_ctrl;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f1_fmis_frs1 <= 64'b0;
        f1_fmis_frs2 <= {FLEN{1'b0}};
        f1_fmis_ctrl <= {22{1'b0}};
        f1_fmis_fcvtwh <= 1'b0;
        f1_fmis_fcvtws <= 1'b0;
        f1_fmis_fcvtwd <= 1'b0;
        f1_fmis_fcvtlh <= 1'b0;
        f1_fmis_fcvtls <= 1'b0;
        f1_fmis_fcvtld <= 1'b0;
        f1_fmis_fcvthw <= 1'b0;
        f1_fmis_fcvthl <= 1'b0;
        f1_fmis_fcvtsw <= 1'b0;
        f1_fmis_fcvtsl <= 1'b0;
        f1_fmis_fcvtdw <= 1'b0;
        f1_fmis_fcvtdl <= 1'b0;
        f1_fmis_fcvths <= 1'b0;
        f1_fmis_fcvthd <= 1'b0;
        f1_fmis_fcvtsh <= 1'b0;
        f1_fmis_fcvtsd <= 1'b0;
        f1_fmis_fcvtdh <= 1'b0;
        f1_fmis_fcvtds <= 1'b0;
        f1_fmis_fcvtbs <= 1'b0;
        f1_fmis_fcvtsb <= 1'b0;
        f1_fmis_fmin <= 1'b0;
        f1_fmis_fmax <= 1'b0;
        f1_fmis_feq <= 1'b0;
        f1_fmis_fle <= 1'b0;
        f1_fmis_flt <= 1'b0;
        f1_fmis_fclass <= 1'b0;
    end
    else if (f0_fmis_valid & ~fpu_lx_stall) begin
        f1_fmis_frs1 <= f0_fmis_frs1;
        f1_fmis_frs2 <= f0_fmis_frs2;
        f1_fmis_ctrl <= f0_fmis_ctrl;
        f1_fmis_fcvtwh <= f0_fmis_fcvtwh;
        f1_fmis_fcvtws <= f0_fmis_fcvtws;
        f1_fmis_fcvtwd <= f0_fmis_fcvtwd;
        f1_fmis_fcvtlh <= f0_fmis_fcvtlh;
        f1_fmis_fcvtls <= f0_fmis_fcvtls;
        f1_fmis_fcvtld <= f0_fmis_fcvtld;
        f1_fmis_fcvthw <= f0_fmis_fcvthw;
        f1_fmis_fcvthl <= f0_fmis_fcvthl;
        f1_fmis_fcvtsw <= f0_fmis_fcvtsw;
        f1_fmis_fcvtsl <= f0_fmis_fcvtsl;
        f1_fmis_fcvtdw <= f0_fmis_fcvtdw;
        f1_fmis_fcvtdl <= f0_fmis_fcvtdl;
        f1_fmis_fcvths <= f0_fmis_fcvths;
        f1_fmis_fcvthd <= f0_fmis_fcvthd;
        f1_fmis_fcvtsh <= f0_fmis_fcvtsh;
        f1_fmis_fcvtsd <= f0_fmis_fcvtsd;
        f1_fmis_fcvtdh <= f0_fmis_fcvtdh;
        f1_fmis_fcvtds <= f0_fmis_fcvtds;
        f1_fmis_fcvtbs <= f0_fmis_fcvtbs;
        f1_fmis_fcvtsb <= f0_fmis_fcvtsb;
        f1_fmis_fmin <= f0_fmis_fmin;
        f1_fmis_fmax <= f0_fmis_fmax;
        f1_fmis_feq <= f0_fmis_feq;
        f1_fmis_fle <= f0_fmis_fle;
        f1_fmis_flt <= f0_fmis_flt;
        f1_fmis_fclass <= f0_fmis_fclass;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f1_fmv_frs1 <= 64'b0;
        f1_fmv_frs2 <= {FLEN{1'b0}};
        f1_fmv_ctrl <= {22{1'b0}};
    end
    else if (f0_fmv_valid & ~fpu_lx_stall) begin
        f1_fmv_frs1 <= f0_fmv_frs1;
        f1_fmv_frs2 <= f0_fmv_frs2;
        f1_fmv_ctrl <= f0_fmv_ctrl;
    end
end

wire [2:0] f1_fmv_sew = f1_fmv_ctrl[18 +:3];
wire [63:0] f1_fmv_op1 = f1_fmv_frs1;
wire [63:0] f1_fmv_op2;
kv_one_ext #(
    .OW(64),
    .IW(FLEN)
) u_f1_fmv_op2_1ext (
    .out(f1_fmv_op2),
    .in(f1_fmv_frs2)
);
kv_fpu_fmv #(
    .FLEN(FLEN)
) u_fpu_fmv (
    .fmv_standby_ready(fmv_standby_ready),
    .f1_wdata(fpu_fmv_result),
    .f1_op1_data(f1_fmv_op1),
    .f1_op2_data(f1_fmv_op2),
    .f1_valid(f1_fmv_valid),
    .f1_sew(f1_fmv_sew),
    .f1_ex_ctrl(f1_fmv_ctrl[0 +:6])
);
wire [2:0] f1_fmis_sew = f1_fmis_ctrl[18 +:3];
wire [63:0] f1_fmis_op1 = f1_fmis_frs1;
wire [63:0] f1_fmis_op2;
kv_one_ext #(
    .OW(64),
    .IW(FLEN)
) u_f1_fmis_op2_1ext (
    .out(f1_fmis_op2),
    .in(f1_fmis_frs2)
);
kv_fpu_fmis #(
    .FLEN(FLEN),
    .XLEN(XLEN)
) u_fpu_fmis (
    .fmis_standby_ready(fmis_standby_ready),
    .f2_cmp_result(nds_unused_cmp_result),
    .f2_narr_wdata(nds_unused_fmis_narr_wdata64),
    .f2_wdata(fpu_fmis_result),
    .f2_wdata_en(nds_unused_wdata_en_fmis),
    .f2_flag_set(fmis_flag_set),
    .f2_result_type(nds_unused_result_type_fmis),
    .f2_stall(fpu_lx_stall),
    .f1_op1_data(f1_fmis_op1),
    .f1_op2_data(f1_fmis_op2),
    .f1_valid(f1_fmis_valid),
    .f1_round_mode(f1_fmis_ctrl[15 +:3]),
    .f1_sew(f1_fmis_sew),
    .f1_ediv(2'b0),
    .f1_ex_ctrl(f1_fmis_ctrl[0 +:6]),
    .f1_vmask(1'b1),
    .f1_sign(f1_fmis_ctrl[21]),
    .f1_fmis_scalar_valid(1'b1),
    .f1_op1_invalid(1'b0),
    .f1_op2_invalid(1'b0),
    .f1_widen(1'b0),
    .f1_narrow(1'b0),
    .f1_fcvtwh_instr(f1_fmis_fcvtwh),
    .f1_fcvtws_instr(f1_fmis_fcvtws),
    .f1_fcvtwd_instr(f1_fmis_fcvtwd),
    .f1_fcvtlh_instr(f1_fmis_fcvtlh),
    .f1_fcvtls_instr(f1_fmis_fcvtls),
    .f1_fcvtld_instr(f1_fmis_fcvtld),
    .f1_fcvthw_instr(f1_fmis_fcvthw),
    .f1_fcvthl_instr(f1_fmis_fcvthl),
    .f1_fcvtsw_instr(f1_fmis_fcvtsw),
    .f1_fcvtsl_instr(f1_fmis_fcvtsl),
    .f1_fcvtdw_instr(f1_fmis_fcvtdw),
    .f1_fcvtdl_instr(f1_fmis_fcvtdl),
    .f1_fcvths_instr(f1_fmis_fcvths),
    .f1_fcvthd_instr(f1_fmis_fcvthd),
    .f1_fcvtsh_instr(f1_fmis_fcvtsh),
    .f1_fcvtsd_instr(f1_fmis_fcvtsd),
    .f1_fcvtdh_instr(f1_fmis_fcvtdh),
    .f1_fcvtds_instr(f1_fmis_fcvtds),
    .f1_fcvtbs_instr(f1_fmis_fcvtbs),
    .f1_fcvtsb_instr(f1_fmis_fcvtsb),
    .f1_fmin_instr(f1_fmis_fmin),
    .f1_fmax_instr(f1_fmis_fmax),
    .f1_feq_instr(f1_fmis_feq),
    .f1_fle_instr(f1_fmis_fle),
    .f1_flt_instr(f1_fmis_flt),
    .f1_fclass_instr(f1_fmis_fclass),
    .core_clk(core_clk),
    .lane_pipe_id_0(1'b1),
    .core_reset_n(core_reset_n)
);
wire [2:0] f1_fdiv_sew;
wire [63:0] f1_fdiv_op1;
wire [63:0] f1_fdiv_op2;
wire f4_fdiv_frf_stall;
wire [63:0] fdiv_resp_result64;
assign fdiv_resp_result = fdiv_resp_result64[FLEN - 1:0];
assign fdiv_resp_flag_set = fdiv_flag_set;
assign f1_fdiv_sew = f1_fdiv_ctrl[18 +:3];
assign f1_fdiv_op1 = f1_fdiv_frs1;
kv_one_ext #(
    .OW(64),
    .IW(FLEN)
) u_f1_fdiv_op2_1ext (
    .out(f1_fdiv_op2),
    .in(f1_fdiv_frs2)
);
assign f4_fdiv_frf_stall = ~fdiv_resp_ready;
kv_fpu_fdiv #(
    .FLEN(FLEN)
) u_fpu_div (
    .fdiv_standby_ready(fdiv_standby_ready),
    .f4_wdata(fdiv_resp_result64),
    .f4_wdata_en(fdiv_resp_valid),
    .f4_tag(fdiv_resp_tag),
    .f4_flag_set(fdiv_flag_set),
    .f4_result_type(nds_unused_result_type_fdiv),
    .f4_frf_stall(f4_fdiv_frf_stall),
    .req_ready(fdiv_req_ready),
    .f1_op1_data(f1_fdiv_op1),
    .f1_op2_data(f1_fdiv_op2),
    .f1_valid(f1_fdiv_valid),
    .f1_round_mode(f1_fdiv_ctrl[15 +:3]),
    .f1_sew(f1_fdiv_sew),
    .f1_ediv(2'b0),
    .f1_ex_ctrl(f1_fdiv_ctrl[0 +:6]),
    .f1_tag(f1_fdiv_ctrl[7 +:5]),
    .kill(fdiv_kill),
    .f3_main_pipe_stall(fpu_lx_stall),
    .core_clk(core_clk),
    .core_reset_n(core_reset_n)
);
wire [2:0] f1_fmac_sew = f1_fmac_ctrl[18 +:3];
generate
    if (FLEN == 32) begin:gen_sp_fmac
        wire [63:0] fpu_fmac32_result64;
        wire f1_frs_hp;
        assign f1_frs_hp = f1_fmac_sew[0];
        wire nds_unused = |f1_fmac_align_amount_adjustment;
        kv_fpu_fmac32 #(
            .FLEN(FLEN)
        ) u_fpu_fmac32 (
            .fmac_standby_ready(fmac_standby_ready),
            .f3_wdata(fpu_fmac32_result64),
            .f3_wdata_en(nds_unused_wdata_en_fmac),
            .f3_flag_set(fmac_flag_set),
            .f3_result_type(nds_unused_result_type_fmac),
            .lane_pipe_id0(1'b1),
            .f1_op1_data(f1_fmac_frs1[31:0]),
            .f1_op2_data(f1_fmac_frs2[31:0]),
            .f1_op3_data(f1_fmac_frs3[31:0]),
            .f1_valid(f1_fmac_valid),
            .f1_round_mode(f1_fmac_ctrl[15 +:3]),
            .f1_sew(f1_fmac_sew),
            .f1_ediv(2'b0),
            .f1_ex_ctrl(f1_fmac_ctrl[0 +:6]),
            .f1_op_wide(1'b0),
            .f1_op_mask(1'b1),
            .f1_op1_hp(f1_frs_hp),
            .f1_op3_hp(f1_frs_hp),
            .f3_stall(fpu_lx_stall),
            .core_clk(core_clk),
            .core_reset_n(core_reset_n)
        );
        assign fpu_fmac32_result = fpu_fmac32_result64[FLEN - 1:0];
        assign fpu_fmac64_result = {FLEN{1'b0}};
    end
    else begin:gen_dp_fmac
        wire f1_frs_hp;
        wire f1_frs_sp;
        wire f1_frs_dp;
        assign f1_frs_hp = f1_fmac_sew[0];
        assign f1_frs_sp = f1_fmac_sew[1];
        assign f1_frs_dp = f1_fmac_sew[2];
        kv_fpu_fmac64 #(
            .FLEN(FLEN)
        ) u_fpu_fmac64 (
            .fmac_standby_ready(fmac_standby_ready),
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .lane_pipe_id0(1'b1),
            .f3_stall(fpu_lx_stall),
            .f1_op1_data(f1_fmac_frs1),
            .f1_op2_data(f1_fmac_frs2),
            .f1_op3_data(f1_fmac_frs3),
            .f1_valid(f1_fmac_valid),
            .f1_round_mode(f1_fmac_ctrl[15 +:3]),
            .f1_sew(f1_fmac_sew),
            .f1_ediv(2'b0),
            .f1_ex_ctrl(f1_fmac_ctrl[0 +:6]),
            .f1_op_wide(1'b0),
            .f1_op_mask(1'b1),
            .f1_op1_dp(f1_frs_dp),
            .f1_op3_dp(f1_frs_dp),
            .f1_op1_sp(f1_frs_sp),
            .f1_op3_sp(f1_frs_sp),
            .f1_op1_hp(f1_frs_hp),
            .f1_op3_hp(f1_frs_hp),
            .f1_align_amount_adjustment(f1_fmac_align_amount_adjustment),
            .f4_wdata(fpu_fmac64_result),
            .f4_wdata_en(nds_unused_wdata_en_fmac),
            .f4_flag_set(fmac_flag_set),
            .f4_result_type(nds_unused_result_type_fmac)
        );
        assign fpu_fmac32_result = {FLEN{1'b0}};
    end
endgenerate
endmodule

