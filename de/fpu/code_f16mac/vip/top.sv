`include "uvm_macros.svh"
import uvm_pkg::*;

module top_tb;

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
logic core_clk;
logic core_reset_n;
logic andes_lane_pipe_id0;
logic [31:0] andes_f1_op1_data;
logic [31:0] andes_f1_op2_data;
logic [31:0] andes_f1_op3_data;
logic andes_f1_valid;
logic [2:0] andes_f1_round_mode;
logic [2:0] andes_f1_sew;
logic [1:0] andes_f1_ediv;
logic [5:0] andes_f1_ex_ctrl;
logic andes_f1_op_wide;
logic andes_f1_op_mask;
logic andes_f1_op1_hp;
logic andes_f1_op3_hp;
logic andes_f3_stall;
logic  [63:0] andes_f3_wdata;
logic  andes_f3_wdata_en;
logic  [4:0] andes_f3_flag_set;
logic  [1:0] andes_f3_result_type;
logic  andes_fmac_standby_ready;


logic [31:0]    tmp_f1_op1_data;
logic [31:0]    tmp_f1_op2_data;
logic [31:0]    tmp_f1_op3_data;

    always #10 core_clk = ~core_clk;
    initial begin
        core_clk <= 0;
    end
    //initial begin
    //    #190;
    //    $finish;
    //end

    //initial begin
    //    core_reset_n <= 0;

    //    andes_lane_pipe_id0 <= 1;
    //    //andes_f1_op1_data <= 'hFFFF3E00;
    //    //andes_f1_op2_data <= 'hFFFF3E00;
    //    //andes_f1_op3_data <= 'hFFFF3FFF;

    //    //andes_f1_op1_data <= 'hFFFF3C00;
    //    //andes_f1_op2_data <= 'hFFFF3C00;
    //    //andes_f1_op3_data <= 'hFFFF0000;
    //    //andes_f1_op1_data <= 'hFFFF7BFF;
    //    //andes_f1_op2_data <= 'hFFFF3C00;
    //    //andes_f1_op3_data <= 'hFFFF3C00;

    //    //andes_f1_op1_data <= 'hFFFF7BFF;
    //    //andes_f1_op2_data <= 'hFFFF3C00;
    //    //andes_f1_op3_data <= 'hFFFF7BFF;

    //    //andes_f1_op1_data <= 'hFFFF03FF;
    //    //andes_f1_op2_data <= 'hFFFF3800;
    //    //andes_f1_op3_data <= 'hFFFF0200;

    //    //andes_f1_op1_data <= 'hFFFF3C00;
    //    //andes_f1_op2_data <= 'hFFFF0400;
    //    //andes_f1_op3_data <= 'hFFFF8001;

    //    andes_f1_op1_data <= 'hFFFF0001;
    //    andes_f1_op2_data <= 'hFFFF3C00;
    //    andes_f1_op3_data <= 'hFFFF8002;

    //    //andes_f1_op1_data <= 'hFFFF03FF;
    //    //andes_f1_op2_data <= 'hFFFF3800;
    //    //andes_f1_op3_data <= 'hFFFF0000;

    //    andes_f1_valid <= 1;
    //    andes_f1_round_mode <= ROUND_RNE;
    //    //andes_f1_round_mode <= ROUND_RTZ;
    //    //andes_f1_round_mode <= ROUND_RDN;
    //    //andes_f1_round_mode <= ROUND_RUP;
    //    andes_f1_sew <= 2'b01;
    //    andes_f1_ex_ctrl <= 5'b01000;
    //    andes_f1_op_wide <= 0;
    //    andes_f1_op_mask <= 0;
    //    andes_f1_op1_hp <= 1;
    //    andes_f1_op3_hp <= 1;
    //    andes_f3_stall <= 0;
    //    @(posedge core_clk);
    //    @(posedge core_clk);
    //    core_reset_n <= 1;
    //    @(posedge core_clk);
    //    @(posedge core_clk);
    //    @(posedge core_clk);
    //    @(posedge core_clk);
    //    @(posedge core_clk);
    //end

    //initial begin
    //    forever begin
    //    @(posedge core_clk);
    //    $display("+++++++");
    //    $display("andes_f3_wdata: %h", andes_f3_wdata);
    //    $display("andes_f3_flag_set: %b", andes_f3_flag_set);
    //    end
    //end


fma16 fma16(
     .core_clk           (core_clk           )
    ,.core_reset_n       (core_reset_n       )
    ,.lane_pipe_id0      (andes_lane_pipe_id0      )
    ,.fmac_standby_ready (andes_fmac_standby_ready )
    ,.f1_op1_data        (andes_f1_op1_data        )
    ,.f1_op2_data        (andes_f1_op2_data        )
    ,.f1_op3_data        (andes_f1_op3_data        )
    ,.f1_valid           (andes_f1_valid           )
    ,.f1_round_mode      (andes_f1_round_mode      )
    ,.f1_sew             (andes_f1_sew             )
    ,.f1_ediv            (andes_f1_ediv            )
    ,.f1_ex_ctrl         (andes_f1_ex_ctrl         )
    ,.f1_op_wide         (andes_f1_op_wide         )
    ,.f1_op_mask         (andes_f1_op_mask         )
    ,.f1_op1_hp          (andes_f1_op1_hp          )
    ,.f1_op3_hp          (andes_f1_op3_hp          )
    ,.f3_stall           (andes_f3_stall           )
    ,.f3_wdata           (andes_f3_wdata           )
    ,.f3_wdata_en        (andes_f3_wdata_en        )
    ,.f3_flag_set        (andes_f3_flag_set        )
    ,.f3_result_type     (andes_f3_result_type     )
);

logic lane_pipe_id0;
logic [15:0] f1_op1_data;
logic [15:0] f1_op2_data;
logic [15:0] f1_op3_data;
logic f1_valid;
logic [2:0] f1_round_mode;
logic [2:0] f1_sew;
logic [1:0] f1_ediv;
logic [5:0] f1_ex_ctrl;
logic f1_op_wide;
logic f1_op_mask;
logic f1_op1_hp;
logic f1_op3_hp;
logic f3_stall;
logic  [15:0] f3_wdata;
logic  f3_wdata_en;
logic  [4:0] f3_flag_set;
logic  [1:0] f3_result_type;
logic  fmac_standby_ready;

acc_f16mac u_acc_f16mac (
    .clk                (core_clk      )
    ,.resetn            (core_reset_n  )
    ,.fp16_i_ready      (              )
    ,.fp16_i_valid      (f1_valid      )
    ,.fp16_i_op1        (f1_op1_data   )
    ,.fp16_i_op2        (f1_op2_data   )
    ,.fp16_i_op3        (f1_op3_data   )
    ,.fp16_i_ctrl       (f1_ex_ctrl    )
    ,.fp16_i_round_mode (f1_round_mode )
    ,.fp16_o_valid      (f3_wdata_en   )
    ,.fp16_o_ready      (1'd1          )
    ,.fp16_o_flag       (f3_flag_set   )
    ,.fp16_o_frd        (f3_wdata      )
);

//fmafp16 fmafp16(
//     .aclk               (core_clk           )
//    ,.aresetn            (core_reset_n       )
//    ,.fmac_standby_ready (fmac_standby_ready )
//    ,.f1_op1_data        (f1_op1_data        )
//    ,.f1_op2_data        (f1_op2_data        )
//    ,.f1_op3_data        (f1_op3_data        )
//    ,.f1_valid           (f1_valid           )
//    ,.f1_round_mode      (f1_round_mode      )
//    ,.f1_sew             (f1_sew             )
//    ,.f1_ediv            (f1_ediv            )
//    ,.f1_ex_ctrl         (f1_ex_ctrl         )
//    ,.f1_op_wide         (f1_op_wide         )
//    ,.f1_op_mask         (f1_op_mask         )
//    ,.f1_op1_hp          (f1_op1_hp          )
//    ,.f1_op3_hp          (f1_op3_hp          )
//    ,.f3_stall           (f3_stall           )
//    ,.f3_wdata           (f3_wdata           )
//    ,.f3_wdata_en        (f3_wdata_en        )
//    ,.f3_flag_set        (f3_flag_set        )
//    ,.f3_result_type     (f3_result_type     )
//);

            logic [15:0] rand16;
            logic [9:0] rand10;

//{{{
initial begin
    f1_valid            <= 0;
    f1_sew              <= 2'b01;
    f1_ex_ctrl          <= 5'b01000;
    f1_op_wide          <= 0;
    f1_op_mask          <= 0;
    f1_op1_hp           <= 1;
    f1_op3_hp           <= 1;
    f3_stall            <= 0;
    andes_f1_valid      <= 0;
    andes_f1_sew        <= 2'b01;
    andes_f1_ex_ctrl    <= 5'b01000;
    andes_f1_op_wide    <= 0;
    andes_f1_op_mask    <= 0;
    andes_f1_op1_hp     <= 1;
    andes_f1_op3_hp     <= 1;
    andes_f3_stall      <= 0;

    //andes_f1_round_mode <= ROUND_RTZ;
    //f1_round_mode       <= ROUND_RTZ;
    //andes_f1_valid <= 1;
    //f1_valid       <= 1;
    //f1_op1_data       <= 'hFFFF0001;
    //f1_op2_data       <= 'hFFFF3C00;
    //f1_op3_data       <= 'hFFFFB001;
    //andes_f1_op1_data <= 'hFFFF3C00;
    //andes_f1_op2_data <= 'hFFFF3C00;
    //andes_f1_op3_data <= 'hFFFFB001;
    //@(posedge core_clk);
    //@(posedge core_clk);
    //@(posedge core_clk);
    //@(posedge core_clk);
    //@(posedge core_clk);
    //@(posedge core_clk);
    //$finish;



    tmp_f1_op1_data   = 'hFFFF0000;
    tmp_f1_op2_data   = 'hFFFF0000;
    tmp_f1_op3_data   = 'hFFFF0000;
    core_reset_n <= 0;
    @(posedge core_clk)
    core_reset_n <= 1;

    f1_op1_data       <= tmp_f1_op1_data;
    f1_op2_data       <= tmp_f1_op2_data;
    f1_op3_data       <= tmp_f1_op3_data;
    andes_f1_op1_data <= tmp_f1_op1_data;
    andes_f1_op2_data <= tmp_f1_op2_data;
    andes_f1_op3_data <= tmp_f1_op3_data;

    andes_f1_round_mode <= ROUND_RUP;
    f1_round_mode       <= ROUND_RUP;
    andes_f1_valid <= 1;
    f1_valid       <= 1;
    @(posedge core_clk);
    forever begin
        //if (tmp_f1_op1_data == 'hFFFFFFFF &&
        //    tmp_f1_op2_data == 'hFFFFFFFF &&
        //    tmp_f1_op3_data == 'hFFFFFFFF) begin
        //    f1_valid       <= 0;
        //    andes_f1_valid       <= 0;
        //    repeat(20) @(posedge core_clk);
        //    $finish;
        //end
        if (tmp_f1_op1_data == 'hFFFFFFFF &&
                 tmp_f1_op2_data == 'hFFFFFFFF) begin
            tmp_f1_op1_data = 'hFFFF0000;
            tmp_f1_op2_data = 'hFFFF0000;
            repeat(3) @(posedge core_clk);
            $display("finish");
            break;

        end
        else if (tmp_f1_op1_data == 'hFFFFFFFF) begin
            tmp_f1_op1_data = 'hFFFF0000;
            tmp_f1_op2_data = tmp_f1_op2_data + 1;
        end
        else begin
            tmp_f1_op1_data = tmp_f1_op1_data + 1;
        end
            rand16 = $random;
            tmp_f1_op3_data = {16'hFFFF,rand16};
        @(posedge core_clk);
        $display("ROUND_RNE; op1: %h; op2: %h; op3: %h",tmp_f1_op1_data, tmp_f1_op2_data, tmp_f1_op3_data);

        //$display("ROUND_RNE");
        //$display("op1: %h", tmp_f1_op1_data);
        //$display("op2: %h", tmp_f1_op2_data);
        //$display("op3: %h", tmp_f1_op3_data);
        f1_op1_data       <= tmp_f1_op1_data;
        f1_op2_data       <= tmp_f1_op2_data;
        f1_op3_data       <= tmp_f1_op3_data;
        andes_f1_op1_data <= tmp_f1_op1_data;
        andes_f1_op2_data <= tmp_f1_op2_data;
        andes_f1_op3_data <= tmp_f1_op3_data;
    end

    andes_f1_round_mode <= ROUND_RNE;
    f1_round_mode       <= ROUND_RNE;
    andes_f1_valid <= 1;
    f1_valid       <= 1;
    @(posedge core_clk);
    forever begin
        //if (tmp_f1_op1_data == 'hFFFFFFFF &&
        //    tmp_f1_op2_data == 'hFFFFFFFF &&
        //    tmp_f1_op3_data == 'hFFFFFFFF) begin
        //    f1_valid       <= 0;
        //    andes_f1_valid       <= 0;
        //    repeat(20) @(posedge core_clk);
        //    $finish;
        //end
        if (tmp_f1_op1_data == 'hFFFFFFFF &&
                 tmp_f1_op2_data == 'hFFFFFFFF) begin
            tmp_f1_op1_data = 'hFFFF0000;
            tmp_f1_op2_data = 'hFFFF0000;
            repeat(3) @(posedge core_clk);
            $display("finish");
            break;

        end
        else if (tmp_f1_op1_data == 'hFFFFFFFF) begin
            tmp_f1_op1_data = 'hFFFF0000;
            tmp_f1_op2_data = tmp_f1_op2_data + 1;
        end
        else begin
            tmp_f1_op1_data = tmp_f1_op1_data + 1;
        end
            rand16 = $random;
            tmp_f1_op3_data = {16'hFFFF,rand16};
        @(posedge core_clk);
        $display("ROUND_RNE; op1: %h; op2: %h; op3: %h",tmp_f1_op1_data, tmp_f1_op2_data, tmp_f1_op3_data);

        //$display("ROUND_RNE");
        //$display("op1: %h", tmp_f1_op1_data);
        //$display("op2: %h", tmp_f1_op2_data);
        //$display("op3: %h", tmp_f1_op3_data);
        f1_op1_data       <= tmp_f1_op1_data;
        f1_op2_data       <= tmp_f1_op2_data;
        f1_op3_data       <= tmp_f1_op3_data;
        andes_f1_op1_data <= tmp_f1_op1_data;
        andes_f1_op2_data <= tmp_f1_op2_data;
        andes_f1_op3_data <= tmp_f1_op3_data;
    end

    f1_round_mode       <= ROUND_RTZ;
    andes_f1_round_mode <= ROUND_RTZ;
    @(posedge core_clk);
    forever begin
        //if (tmp_f1_op1_data == 'hFFFFFFFF &&
        //    tmp_f1_op2_data == 'hFFFFFFFF &&
        //    tmp_f1_op3_data == 'hFFFFFFFF) begin
        //    f1_valid       <= 0;
        //    andes_f1_valid       <= 0;
        //    repeat(20) @(posedge core_clk);
        //    $finish;
        //end
        if (tmp_f1_op1_data == 'hFFFFFFFF &&
                 tmp_f1_op2_data == 'hFFFFFFFF) begin
            tmp_f1_op1_data = 'hFFFF0000;
            tmp_f1_op2_data = 'hFFFF0000;
            repeat(3) @(posedge core_clk);
            $display("finish");
            break;
        end
        else if (tmp_f1_op1_data == 'hFFFFFFFF) begin
            tmp_f1_op1_data = 'hFFFF0000;
            tmp_f1_op2_data = tmp_f1_op2_data+ 1;
        end
        else begin
            tmp_f1_op1_data = tmp_f1_op1_data + 1;
        end
            rand16 = $random;
            tmp_f1_op3_data = {16'hFFFF,rand16};
        @(posedge core_clk);
        $display("ROUND_RTZ");
        $display("op1: %h", tmp_f1_op1_data);
        $display("op2: %h", tmp_f1_op2_data);
        $display("op3: %h", tmp_f1_op3_data);
        f1_op1_data       <= tmp_f1_op1_data;
        f1_op2_data       <= tmp_f1_op2_data;
        f1_op3_data       <= tmp_f1_op3_data;
        andes_f1_op1_data <= tmp_f1_op1_data;
        andes_f1_op2_data <= tmp_f1_op2_data;
        andes_f1_op3_data <= tmp_f1_op3_data;
    end

    f1_round_mode       <= ROUND_RDN;
    andes_f1_round_mode <= ROUND_RDN;
    @(posedge core_clk);
    forever begin
        //if (tmp_f1_op1_data == 'hFFFFFFFF &&
        //    tmp_f1_op2_data == 'hFFFFFFFF &&
        //    tmp_f1_op3_data == 'hFFFFFFFF) begin
        //    f1_valid       <= 0;
        //    andes_f1_valid       <= 0;
        //    repeat(20) @(posedge core_clk);
        //    $finish;
        //end
        if (tmp_f1_op1_data == 'hFFFFFFFF &&
                 tmp_f1_op2_data == 'hFFFFFFFF) begin
            tmp_f1_op1_data = 'hFFFF0000;
            tmp_f1_op2_data = 'hFFFF0000;
            repeat(3) @(posedge core_clk);
            $display("finish");
            break;
        end
        else if (tmp_f1_op1_data == 'hFFFFFFFF) begin
            tmp_f1_op1_data = 'hFFFF0000;
            tmp_f1_op2_data = tmp_f1_op2_data+ 1;
        end
        else begin
            tmp_f1_op1_data = tmp_f1_op1_data + 1;
        end
            rand16 = $random;
            tmp_f1_op3_data = {16'hFFFF,rand16};
        @(posedge core_clk);
        $display("ROUND_RDN");
        $display("op1: %h", tmp_f1_op1_data);
        $display("op2: %h", tmp_f1_op2_data);
        $display("op3: %h", tmp_f1_op3_data);
        f1_op1_data       <= tmp_f1_op1_data;
        f1_op2_data       <= tmp_f1_op2_data;
        f1_op3_data       <= tmp_f1_op3_data;
        andes_f1_op1_data <= tmp_f1_op1_data;
        andes_f1_op2_data <= tmp_f1_op2_data;
        andes_f1_op3_data <= tmp_f1_op3_data;
    end

    f1_round_mode       <= ROUND_RUP;
    andes_f1_round_mode <= ROUND_RUP;
    @(posedge core_clk);
    forever begin
        //if (tmp_f1_op1_data == 'hFFFFFFFF &&
        //    tmp_f1_op2_data == 'hFFFFFFFF &&
        //    tmp_f1_op3_data == 'hFFFFFFFF) begin
        //    f1_valid       <= 0;
        //    andes_f1_valid       <= 0;
        //    repeat(20) @(posedge core_clk);
        //    $finish;
        //end
        if (tmp_f1_op1_data == 'hFFFFFFFF &&
                 tmp_f1_op2_data == 'hFFFFFFFF) begin
            tmp_f1_op1_data = 'hFFFF0000;
            tmp_f1_op2_data = 'hFFFF0000;
            repeat(3) @(posedge core_clk);
            $display("finish");
            $finish;
        end
        else if (tmp_f1_op1_data == 'hFFFFFFFF) begin
            tmp_f1_op1_data = 'hFFFF0000;
            tmp_f1_op2_data = tmp_f1_op2_data+ 1;
        end
        else begin
            tmp_f1_op1_data = tmp_f1_op1_data + 1;
        end
            rand16 = $random;
            tmp_f1_op3_data = {16'hFFFF,rand16};
        @(posedge core_clk);
        $display("ROUND_RUP");
        $display("op1: %h", tmp_f1_op1_data);
        $display("op2: %h", tmp_f1_op2_data);
        $display("op3: %h", tmp_f1_op3_data);
        f1_op1_data       <= tmp_f1_op1_data;
        f1_op2_data       <= tmp_f1_op2_data;
        f1_op3_data       <= tmp_f1_op3_data;
        andes_f1_op1_data <= tmp_f1_op1_data;
        andes_f1_op2_data <= tmp_f1_op2_data;
        andes_f1_op3_data <= tmp_f1_op3_data;
    end
end
//}}}


//
////{{{
//initial begin
//    f1_valid            <= 0;
//    f1_sew              <= 2'b01;
//    f1_ex_ctrl          <= 5'b01000;
//    f1_op_wide          <= 0;
//    f1_op_mask          <= 0;
//    f1_op1_hp           <= 1;
//    f1_op3_hp           <= 1;
//    f3_stall            <= 0;
//    andes_f1_valid      <= 0;
//    andes_f1_sew        <= 2'b01;
//    andes_f1_ex_ctrl    <= 5'b01000;
//    andes_f1_op_wide    <= 0;
//    andes_f1_op_mask    <= 0;
//    andes_f1_op1_hp     <= 1;
//    andes_f1_op3_hp     <= 1;
//    andes_f3_stall      <= 0;
//
//    tmp_f1_op1_data   = 'hFFFF0000;
//    tmp_f1_op2_data   = 'hFFFF0000;
//    tmp_f1_op3_data   = 'hFFFF0000;
//    core_reset_n <= 0;
//    @(posedge core_clk)
//    core_reset_n <= 1;
//
//    f1_op1_data       <= tmp_f1_op1_data;
//    f1_op2_data       <= tmp_f1_op2_data;
//    f1_op3_data       <= tmp_f1_op3_data;
//    andes_f1_op1_data <= tmp_f1_op1_data;
//    andes_f1_op2_data <= tmp_f1_op2_data;
//    andes_f1_op3_data <= tmp_f1_op3_data;
//
//    andes_f1_round_mode <= ROUND_RNE;
//    f1_round_mode       <= ROUND_RNE;
//    andes_f1_valid <= 1;
//    f1_valid       <= 1;
//    @(posedge core_clk);
//    forever begin
//        //if (tmp_f1_op1_data == 'hFFFFFFFF &&
//        //    tmp_f1_op2_data == 'hFFFFFFFF &&
//        //    tmp_f1_op3_data == 'hFFFFFFFF) begin
//        //    f1_valid       <= 0;
//        //    andes_f1_valid       <= 0;
//        //    repeat(20) @(posedge core_clk);
//        //    $finish;
//        //end
//        if (tmp_f1_op1_data == 'hFFFFFFFF &&
//                 tmp_f1_op2_data[15:10] == 6'b111111) begin
//            tmp_f1_op1_data = 'hFFFF0000;
//            tmp_f1_op2_data = 'hFFFF0000;
//            repeat(3) @(posedge core_clk);
//            $display("finish");
//            break;
//
//        end
//        else if (tmp_f1_op1_data == 'hFFFFFFFF) begin
//            tmp_f1_op1_data = 'hFFFF0000;
//            tmp_f1_op2_data[15:10] = tmp_f1_op2_data[15:10]+ 1;
//        end
//        else begin
//            tmp_f1_op1_data = tmp_f1_op1_data + 1;
//        end
//            rand16 = $random;
//            rand10 = $random;
//            tmp_f1_op2_data[9:0] = rand10;
//            tmp_f1_op3_data = {16'hFFFF,rand16};
//        @(posedge core_clk);
//        $display("op1: %h", tmp_f1_op1_data);
//        $display("op2: %h", tmp_f1_op2_data);
//        $display("op3: %h", tmp_f1_op3_data);
//        f1_op1_data       <= tmp_f1_op1_data;
//        f1_op2_data       <= tmp_f1_op2_data;
//        f1_op3_data       <= tmp_f1_op3_data;
//        andes_f1_op1_data <= tmp_f1_op1_data;
//        andes_f1_op2_data <= tmp_f1_op2_data;
//        andes_f1_op3_data <= tmp_f1_op3_data;
//    end
//
//    f1_round_mode       <= ROUND_RTZ;
//    andes_f1_round_mode <= ROUND_RTZ;
//    @(posedge core_clk);
//    forever begin
//        //if (tmp_f1_op1_data == 'hFFFFFFFF &&
//        //    tmp_f1_op2_data == 'hFFFFFFFF &&
//        //    tmp_f1_op3_data == 'hFFFFFFFF) begin
//        //    f1_valid       <= 0;
//        //    andes_f1_valid       <= 0;
//        //    repeat(20) @(posedge core_clk);
//        //    $finish;
//        //end
//        if (tmp_f1_op1_data == 'hFFFFFFFF &&
//                 tmp_f1_op2_data[15:10] == 6'b111111) begin
//            tmp_f1_op1_data = 'hFFFF0000;
//            tmp_f1_op2_data = 'hFFFF0000;
//            repeat(3) @(posedge core_clk);
//            $display("finish");
//            break;
//        end
//        else if (tmp_f1_op1_data == 'hFFFFFFFF) begin
//            tmp_f1_op1_data = 'hFFFF0000;
//            tmp_f1_op2_data[15:10] = tmp_f1_op2_data[15:10]+ 1;
//        end
//        else begin
//            tmp_f1_op1_data = tmp_f1_op1_data + 1;
//        end
//            rand16 = $random;
//            rand10 = $random;
//            tmp_f1_op2_data[9:0] = rand10;
//            tmp_f1_op3_data = {16'hFFFF,rand16};
//        @(posedge core_clk);
//        $display("op1: %h", tmp_f1_op1_data);
//        $display("op2: %h", tmp_f1_op2_data);
//        $display("op3: %h", tmp_f1_op3_data);
//        f1_op1_data       <= tmp_f1_op1_data;
//        f1_op2_data       <= tmp_f1_op2_data;
//        f1_op3_data       <= tmp_f1_op3_data;
//        andes_f1_op1_data <= tmp_f1_op1_data;
//        andes_f1_op2_data <= tmp_f1_op2_data;
//        andes_f1_op3_data <= tmp_f1_op3_data;
//    end
//
//    f1_round_mode       <= ROUND_RDN;
//    andes_f1_round_mode <= ROUND_RDN;
//    @(posedge core_clk);
//    forever begin
//        //if (tmp_f1_op1_data == 'hFFFFFFFF &&
//        //    tmp_f1_op2_data == 'hFFFFFFFF &&
//        //    tmp_f1_op3_data == 'hFFFFFFFF) begin
//        //    f1_valid       <= 0;
//        //    andes_f1_valid       <= 0;
//        //    repeat(20) @(posedge core_clk);
//        //    $finish;
//        //end
//        if (tmp_f1_op1_data == 'hFFFFFFFF &&
//                 tmp_f1_op2_data[15:10] == 6'b111111) begin
//            tmp_f1_op1_data = 'hFFFF0000;
//            tmp_f1_op2_data = 'hFFFF0000;
//            repeat(3) @(posedge core_clk);
//            $display("finish");
//            break;
//        end
//        else if (tmp_f1_op1_data == 'hFFFFFFFF) begin
//            tmp_f1_op1_data = 'hFFFF0000;
//            tmp_f1_op2_data[15:10] = tmp_f1_op2_data[15:10]+ 1;
//        end
//        else begin
//            tmp_f1_op1_data = tmp_f1_op1_data + 1;
//        end
//            rand16 = $random;
//            rand10 = $random;
//            tmp_f1_op2_data[9:0] = rand10;
//            tmp_f1_op3_data = {16'hFFFF,rand16};
//        @(posedge core_clk);
//        $display("op1: %h", tmp_f1_op1_data);
//        $display("op2: %h", tmp_f1_op2_data);
//        $display("op3: %h", tmp_f1_op3_data);
//        f1_op1_data       <= tmp_f1_op1_data;
//        f1_op2_data       <= tmp_f1_op2_data;
//        f1_op3_data       <= tmp_f1_op3_data;
//        andes_f1_op1_data <= tmp_f1_op1_data;
//        andes_f1_op2_data <= tmp_f1_op2_data;
//        andes_f1_op3_data <= tmp_f1_op3_data;
//    end
//
//    f1_round_mode       <= ROUND_RUP;
//    andes_f1_round_mode <= ROUND_RUP;
//    @(posedge core_clk);
//    forever begin
//        //if (tmp_f1_op1_data == 'hFFFFFFFF &&
//        //    tmp_f1_op2_data == 'hFFFFFFFF &&
//        //    tmp_f1_op3_data == 'hFFFFFFFF) begin
//        //    f1_valid       <= 0;
//        //    andes_f1_valid       <= 0;
//        //    repeat(20) @(posedge core_clk);
//        //    $finish;
//        //end
//        if (tmp_f1_op1_data == 'hFFFFFFFF &&
//                 tmp_f1_op2_data[15:10] == 6'b111111) begin
//            tmp_f1_op1_data = 'hFFFF0000;
//            tmp_f1_op2_data = 'hFFFF0000;
//            repeat(3) @(posedge core_clk);
//            $display("finish");
//            $finish;
//        end
//        else if (tmp_f1_op1_data == 'hFFFFFFFF) begin
//            tmp_f1_op1_data = 'hFFFF0000;
//            tmp_f1_op2_data[15:10] = tmp_f1_op2_data[15:10]+ 1;
//        end
//        else begin
//            tmp_f1_op1_data = tmp_f1_op1_data + 1;
//        end
//            rand16 = $random;
//            rand10 = $random;
//            tmp_f1_op2_data[9:0] = rand10;
//            tmp_f1_op3_data = {16'hFFFF,rand16};
//        @(posedge core_clk);
//        $display("op1: %h", tmp_f1_op1_data);
//        $display("op2: %h", tmp_f1_op2_data);
//        $display("op3: %h", tmp_f1_op3_data);
//        f1_op1_data       <= tmp_f1_op1_data;
//        f1_op2_data       <= tmp_f1_op2_data;
//        f1_op3_data       <= tmp_f1_op3_data;
//        andes_f1_op1_data <= tmp_f1_op1_data;
//        andes_f1_op2_data <= tmp_f1_op2_data;
//        andes_f1_op3_data <= tmp_f1_op3_data;
//    end
//end
////}}}
//

//
////{{{
//initial begin
//    f1_valid            <= 0;
//    f1_sew              <= 2'b01;
//    f1_ex_ctrl          <= 5'b01000;
//    f1_op_wide          <= 0;
//    f1_op_mask          <= 0;
//    f1_op1_hp           <= 1;
//    f1_op3_hp           <= 1;
//    f3_stall            <= 0;
//    andes_f1_valid      <= 0;
//    andes_f1_sew        <= 2'b01;
//    andes_f1_ex_ctrl    <= 5'b01000;
//    andes_f1_op_wide    <= 0;
//    andes_f1_op_mask    <= 0;
//    andes_f1_op1_hp     <= 1;
//    andes_f1_op3_hp     <= 1;
//    andes_f3_stall      <= 0;
//
//    tmp_f1_op1_data   = 'hFFFFb6a8;
//    tmp_f1_op2_data   = 'hFFFF04d4;
//    tmp_f1_op3_data   = 'hFFFF0201;
//    core_reset_n <= 0;
//    @(posedge core_clk)
//    core_reset_n <= 1;
//
//    f1_op1_data       <= tmp_f1_op1_data;
//    f1_op2_data       <= tmp_f1_op2_data;
//    f1_op3_data       <= tmp_f1_op3_data;
//    andes_f1_op1_data <= tmp_f1_op1_data;
//    andes_f1_op2_data <= tmp_f1_op2_data;
//    andes_f1_op3_data <= tmp_f1_op3_data;
//
//    andes_f1_round_mode <= ROUND_RDN;
//    f1_round_mode       <= ROUND_RDN;
//    andes_f1_valid <= 1;
//    f1_valid       <= 1;
//    @(posedge core_clk);
//
//    repeat(10) @(posedge core_clk);
//    $display("finish");
//    $finish;
//
//end
////}}}
//
initial begin
    forever begin
        @(posedge core_clk iff(f3_wdata_en & andes_f3_wdata_en));
        if (f3_wdata[15:0] != andes_f3_wdata[15:0] || f3_flag_set != andes_f3_flag_set)begin
            $display("andes wdata: %h", andes_f3_wdata);
            $display("andes flag:  %h", andes_f3_flag_set);
            $display("jason wdata: %h", f3_wdata);
            $display("jason flag:  %h", f3_flag_set);
            $display("error");
            $finish;
        end else begin
            //$display("andes wdata: %h", andes_f3_wdata);
            //$display("andes flag:  %h", andes_f3_flag_set);
            //$display("jason wdata: %h", f3_wdata);
            //$display("jason flag:  %h", f3_flag_set);
        end
    end
end

endmodule
