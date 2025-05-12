`include "uvm_macros.svh"
import uvm_pkg::*;

module top_tb;

localparam D_BITWIDTH = 11;
localparam D_MSB = 0;
localparam D_LSB = 1 - D_BITWIDTH;
localparam X_BITWIDTH = 11;
localparam Q_MSB = 1;
localparam Q_LSB = -((X_BITWIDTH + 1) + (X_BITWIDTH + 1)%2);
localparam Q_BITWIDTH = Q_MSB - Q_LSB + 1;
localparam R_MSB = 3; // remainder
localparam R_LSB = Q_LSB;
localparam R_BITWIDTH = R_MSB - R_LSB + 1;

logic clk;
logic resetn;
logic dsu_resp_valid;
logic dsu_resp_ready;
logic dsu_resp_is_div;
logic dsu_resp_is_exp_odd;
logic [X_BITWIDTH-1:0] dsu_resp_x;
logic [D_BITWIDTH-1:0] dsu_resp_d;
logic dsu_req_ready;
logic dsu_req_r_done;
logic dsu_req_q_done;
logic [R_BITWIDTH-1:0] dsu_req_d0;
logic [R_BITWIDTH-1:0] dsu_req_d1;

acc_dsu u_acc_dsu (
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

initial begin
    clk = 0;
    forever begin
        #10;
        clk = ~clk;
    end
end

initial begin
    resetn = 1;
    repeat(4) @(posedge clk);
    resetn = 0;
    repeat(4) @(posedge clk);
    resetn = 1;
end

logic [R_BITWIDTH-1:0] r;
logic [R_BITWIDTH-1:0] q;
logic [R_BITWIDTH*2-1:0] golden_r;
logic [R_BITWIDTH*2-1:0] golden_q;
logic [R_BITWIDTH*2-1:0] golden2_q;
logic [R_BITWIDTH*2-1:0] golden2_r;
logic sel_q1;

initial begin
    @(negedge resetn);
    dsu_resp_valid <= 1'b0;
    dsu_req_ready <= 1'b0;
    @(posedge resetn);
    dsu_resp_x <= 11'b10000000000;
    dsu_resp_d <= 11'b11000000000;
    forever begin
        @(posedge clk)
        dsu_resp_valid <= 1'b1;
        dsu_req_ready <= 1'b1;
        dsu_resp_is_div <= 1'b1;
        //dsu_resp_is_div <= 1'b0;
        dsu_resp_is_exp_odd <= 1'b0;
        //dsu_resp_is_exp_odd <= 1'b1;
        @(posedge clk)
        dsu_resp_valid <= 1'b0;
        @(posedge clk iff dsu_req_r_done)
        if (dsu_resp_is_div) begin
            golden_q = (dsu_resp_x << (Q_BITWIDTH-2)) / dsu_resp_d;
            golden_r = (dsu_resp_x << (Q_BITWIDTH-2)) % dsu_resp_d;
            golden_r = {golden_r,2'd0};
            r = dsu_req_d0 + dsu_req_d1;
            sel_q1 = r[R_BITWIDTH-1];
            r = sel_q1 ? r + {dsu_resp_d,2'd0} : r;
            @(posedge clk iff dsu_req_q_done)
            q = sel_q1 ? dsu_req_d1 : dsu_req_d0;
            $display("x       : %b", dsu_resp_x);
            $display("d       : %b", dsu_resp_d);
            $display("golden_q: %b", golden_q[0 +:R_BITWIDTH]);
            $display("q       : %b", q);
            $display("golden_r: %b", golden_r[0 +:R_BITWIDTH]);
            $display("r       : %b", r);
            $display("-------------------------------");
            if (dsu_resp_x == 11'b11111111111) begin
                dsu_resp_d <= dsu_resp_d + 1;
                dsu_resp_x <= 11'b10000000000;
            end
            else begin
                dsu_resp_x <= dsu_resp_x + 1;
            end

            dsu_resp_valid <= 1'b1;
            if(q != golden_q) begin
                $error();
                $finish;
            end
            if(r != golden_r) begin
                $error();
                $finish;
            end
        end
        else begin

            if(dsu_resp_is_exp_odd == 1) begin
                golden2_q = $floor($sqrt({dsu_resp_x,1'd0,12'd0}));
                golden2_r = {dsu_resp_x,13'd0} - golden2_q*golden2_q;

                r = dsu_req_d0 + dsu_req_d1;
                sel_q1 = r[R_BITWIDTH-1];
                @(posedge clk iff dsu_req_q_done)
                q = dsu_req_d0;
                r = sel_q1 ? ~r + 1 : r;
                golden_q = sel_q1 ? q*q - r : q*q + r;
                $display("x        : %b", dsu_resp_x);
                $display("golden_q : %b", golden_q);
                $display("q        : %b", q);
                $display("r        : %b", r);
                q = sel_q1 ? dsu_req_d1 : dsu_req_d0;
                r = {dsu_resp_x,13'd0} - q*q;
                $display("golden2_q: %b", golden2_q);
                $display("q        : %b", q);
                $display("golden2_r: %b", golden2_r);
                $display("r        : %b", r);
                $display("-------------------------------");
                dsu_resp_x <= dsu_resp_x + 1;
            end
            else begin
                golden2_q = $floor($sqrt({1'd0,dsu_resp_x,12'd0}));
                golden2_r = {dsu_resp_x,13'd0} - golden2_q*golden2_q;

                r = dsu_req_d0 + dsu_req_d1;
                sel_q1 = r[R_BITWIDTH-1];
                @(posedge clk iff dsu_req_q_done)
                q = dsu_req_d0;
                r = sel_q1 ? ~r + 1 : r;
                golden_q = sel_q1 ? q*q - r : q*q + r;
                $display("x        : %b", dsu_resp_x);
                $display("golden_q : %b", golden_q);
                $display("q        : %b", q);
                $display("r        : %b", r);
                q = sel_q1 ? dsu_req_d1 : dsu_req_d0;
                r = {dsu_resp_x,13'd0} - q*q;
                $display("golden2_q: %b", golden2_q);
                $display("q        : %b", q);
                $display("golden2_r: %b", golden2_r);
                $display("r        : %b", r);
                $display("-------------------------------");
                dsu_resp_x <= dsu_resp_x + 1;

            end

            if(dsu_resp_x == 0 || dsu_resp_d == 0) begin
                $display("PASS");
                $finish;
            end

            if(dsu_resp_is_exp_odd == 1) begin
                if(dsu_resp_x != golden_q[13 +:X_BITWIDTH]) begin
                    $error();
                    $finish;
                end
                if(q != golden2_q[0 +:R_BITWIDTH]) begin
                    $error();
                    $finish;
                end

                if(r != golden2_r[0 +:R_BITWIDTH]) begin
                    $error();
                    $finish;
                end

            end
            else begin
                if(dsu_resp_x != golden_q[12 +:X_BITWIDTH]) begin
                    $error();
                    $finish;
                end
                if(q != golden2_q[0 +:R_BITWIDTH]) begin
                    $error();
                    $finish;
                end

                if(r != golden2_r[0 +:R_BITWIDTH]) begin
                    $error();
                    $finish;
                end
            end
        end

        dsu_resp_valid <= 1'b1;

        if(dsu_resp_x == 0 || dsu_resp_d == 0) begin
            $display("PASS");
            $finish;
        end
    end
    $finish;
end

//initial begin
//    core_reset_n =  1;
//    div_enable <= 0;
//    @(posedge core_clk);
//    core_reset_n =  0;
//    @(posedge core_clk);
//    core_reset_n =  1;
//    x <= 11'b10000000000;
//    y <= 11'b10000000000;
//    div_enable <= 1;
//    @(posedge core_clk iff div_enable);
//    y_tmp = y;
//    x_tmp = x;
//    div_enable <= 0;
//    @(posedge core_clk iff ds_gen_sticky);
//    forever begin
//        if(x == 11'b11111111111) begin
//            x <= 11'b10000000000;
//            y <= y + 1;
//        end else begin
//            x <= x + 1;
//        end
//        div_enable <= 1;
//        @(posedge core_clk iff div_enable);
//        y_tmp = y;
//        x_tmp = x;
//        div_enable <= 0;
//        @(posedge core_clk iff ds_gen_sticky);
//
//        if(x == 11'b11111111111 && y == 11'b11111111111) begin
//            @(posedge core_clk);
//            $finish;
//        end
//    end
//end



//// #{{{
//parameter FLEN = 16;
//localparam DS_COUNT_WIDTH = (FLEN == 64) ? 5 : (FLEN == 32) ? 4 : 3;
//localparam FRACTION_WIDTH = (FLEN == 64) ? 53 : (FLEN == 32) ? 24 : 11;
//localparam DS_COUNT_MSB = DS_COUNT_WIDTH - 1;
//localparam DS_DIN_WIDTH = FRACTION_WIDTH + 1;
//localparam DS_DIN_MSB = DS_DIN_WIDTH - 1;
//localparam DS_DOUT_WIDTH = FRACTION_WIDTH + 5;
//localparam DS_DOUT_MSB = DS_DOUT_WIDTH - 1;
//localparam DS_QR_WIDTH = FRACTION_WIDTH + 2;
//localparam DS_QR_MSB = DS_QR_WIDTH - 1;
//localparam DS_SQRT_OP_WIDTH = FRACTION_WIDTH + 3;
//localparam DS_SQRT_OP_MSB = DS_SQRT_OP_WIDTH - 1;
//logic [DS_DOUT_MSB:0] ds_result0;
//logic [DS_DOUT_MSB:0] ds_result1;
//logic ds_busy;
//logic ds_gen_sticky;
//logic ds_calc_done;
//
//logic [DS_DIN_MSB:0] ds_din0;
//logic [DS_DIN_MSB:1] ds_din1;
//logic ds_invalidate;
//logic [1:0] ds_type;
//logic div_enable;
//logic sqrt_enable;
//logic f3_stall;
//logic core_clk;
//logic core_reset_n;
//
//localparam FP16_FRAC_BITWIDTH = 10;
//localparam FRAC_MSB = FP16_FRAC_BITWIDTH;
//localparam PR_MSB = FRAC_MSB + 3; // partical remainder
//localparam PR_LSB = 0;
//localparam PR_BITWIDTH = PR_MSB - PR_LSB + 1;
//localparam Y_MSB = FRAC_MSB;
//localparam Y_LSB = 0;
//localparam RQST_PR_BITWIDTH = 7; // RQST = redundant quotient selection table
//localparam RQST_Y_BITWIDTH = 3;
//localparam RQ_BITWIDTH = 3; // D = {-2,-1,0,1,2}
//localparam ITER = PR_BITWIDTH/2 - 1;
//localparam ITER_BITWIDTH = 3;
//
//
////input                  clk;
////input                  resetn;
////input                  dsu_i_valid;
////output                 dsu_i_ready;
////input                  dsu_i_ctrl;
////input  [PR_MSB:PR_LSB] dsu_i_pr0;
////input  [Y_MSB:Y_LSB]   dsu_i_y;
////input                  dsu_o_ready;
//logic [PR_MSB:PR_LSB] dsu_o_d0;
//logic [PR_MSB:PR_LSB] dsu_o_d1;
//
//logic [10:0] x;
//logic [10:0] y;
//
//initial begin
//    //ds_din0 = 12'b100000000000;
//    //ds_din1 = 11'b11111111111;
//
////    ds_din0 = 12'b111111111110;
////    ds_din1 = 11'b10000000000;
//    ds_invalidate = 0;
//    ds_type = 2'b10;
//    sqrt_enable = 0;
//    f3_stall  = 0;
//end
//
//
//kv_fpu_dsu # (
//    .FLEN(FLEN)
//) u_kv_fpu_dsu(
//     .ds_result0    (ds_result0    )
//    ,.ds_result1    (ds_result1    )
//    ,.ds_busy       (ds_busy       )
//    ,.ds_gen_sticky (ds_gen_sticky )
//    ,.ds_calc_done  (ds_calc_done  )
//    ,.ds_din0       ({x,1'd0}      )
//    ,.ds_din1       (y             )
//    ,.ds_invalidate (ds_invalidate )
//    ,.ds_type       (ds_type       )
//    ,.div_enable    (div_enable    )
//    ,.sqrt_enable   (sqrt_enable   )
//    ,.f3_stall      (f3_stall      )
//    ,.core_clk      (core_clk      )
//    ,.core_reset_n  (core_reset_n  )
//);
//
//f16dsu u_f16dsu (
//     .clk          (core_clk     )
//    ,.resetn       (core_reset_n )
//    ,.dsu_i_valid  (div_enable   )
//    ,.dsu_i_ready  (             )
//    ,.dsu_i_ctrl   (1'd1         )
//    ,.dsu_i_pr0    ({3'd0,x}     )
//    ,.dsu_i_y      (y            )
//    ,.dsu_o_ready  (1'd1         )
//    ,.dsu_o_r_done (             )
//    ,.dsu_o_q_done (             )
//    ,.dsu_o_d0     (dsu_o_d0     )
//    ,.dsu_o_d1     (dsu_o_d1     )
//);
//
//always #10 core_clk = ~core_clk;
//
//logic [Y_MSB:Y_LSB] y_tmp;
//logic [PR_MSB:PR_LSB] x_tmp;
//
//initial begin
//    core_clk = 0;
//    core_reset_n =  1;
//    div_enable <= 0;
//    @(posedge core_clk);
//    core_reset_n =  0;
//    @(posedge core_clk);
//    core_reset_n =  1;
//    x <= 11'b10000000000;
//    y <= 11'b10000000000;
//    div_enable <= 1;
//    @(posedge core_clk iff div_enable);
//    y_tmp = y;
//    x_tmp = x;
//    div_enable <= 0;
//    @(posedge core_clk iff ds_gen_sticky);
//    forever begin
//        if(x == 11'b11111111111) begin
//            x <= 11'b10000000000;
//            y <= y + 1;
//        end else begin
//            x <= x + 1;
//        end
//        div_enable <= 1;
//        @(posedge core_clk iff div_enable);
//        y_tmp = y;
//        x_tmp = x;
//        div_enable <= 0;
//        @(posedge core_clk iff ds_gen_sticky);
//
//        if(x == 11'b11111111111 && y == 11'b11111111111) begin
//            @(posedge core_clk);
//            $finish;
//        end
//    end
//end
//logic [PR_MSB:PR_LSB] d;
//logic [DS_DOUT_MSB:0] result;
//logic [PR_MSB:PR_LSB] d_check;
//logic [DS_DOUT_MSB:0] result_check;
//logic [PR_MSB:PR_LSB] q0;
//
//wire [24:0] ans_q = ((x_tmp << 12) / y_tmp);
//wire [24:0] ans_r = ((x_tmp << 12) % y_tmp);
//
//initial begin
//    forever begin
//        @(posedge core_clk iff ds_calc_done);
//        d = dsu_o_d0 + dsu_o_d1;
//        d_check = (d[PR_MSB] == 1) ? d + y_tmp : d;
//        result = ds_result0 + ds_result1;
//        result_check = (result[DS_DOUT_MSB] == 1) ? result + {y_tmp,2'b0} : result;
//        if({d_check,2'd0} != result_check) begin
//            $display("r_error");
//            $display("r        :%b",d_check);
//            $display("r_golden :%b",result_check);
//            $finish;
//        end
//        @(posedge core_clk iff ds_gen_sticky);
//        q0 = dsu_o_d0 -d[PR_MSB];
//        $display("x         :%b",x_tmp);
//        $display("y         :%b",y_tmp);
//        $display("q0        :%b",q0);
//        $display("r         :%b",d_check);
//        $display("result_r  :%b",result_check);
//        $display("ans_q     :%b",ans_q);
//        $display("ans_r     :%b",ans_r);
//        if(q0 != ans_q) begin
//            $finish;
//        end
//        if(d_check != ans_r) begin
//            $finish;
//        end
//        if((dsu_o_d0 -d[PR_MSB]) != (ds_result0[DS_DOUT_MSB:1] -result[DS_DOUT_MSB])) begin
//            $display("q_error");
//            $display("q0        :%b",dsu_o_d0);
//            $display("q0_golden :%b",ds_result0);
//            $finish;
//        end
//    end
//
//end
//// #}}}
endmodule
