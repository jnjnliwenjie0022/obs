`include "uvm_macros.svh"
`define FPU_FDIV_5B  6'b000000
`define FPU_FSQRT_5B 6'b000001

import uvm_pkg::*;
module top_tb;

localparam FLEN = 16;

localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;

logic            clk;
logic            resetn;
logic            fdiv_resp_ready;
logic            fdiv_resp_valid;
logic [FLEN-1:0] fdiv_resp_op1;
logic [FLEN-1:0] fdiv_resp_op2;
logic [4:0]      fdiv_resp_ctrl;
logic [2:0]      fdiv_resp_round_mode;
logic            fdiv_req_valid;
logic            fdiv_req_ready;
logic [4:0]      fdiv_req_flag;
logic [FLEN-1:0] fdiv_req_frd;

logic            core_clk;
logic            core_reset_n;
logic            fdiv_standby_ready;
logic [63:0]     f4_wdata;
logic            f4_wdata_en;
logic [4:0]      f4_flag_set;
logic [4:0]      f4_tag;
logic [1:0]      f4_result_type;
logic [63:0]     f1_op1_data;
logic [63:0]     f1_op2_data;
logic            f1_valid;
logic            req_ready;
logic            f4_frf_stall;
logic [5:0]      f1_ex_ctrl;
logic [1:0]      f1_ediv;
logic [2:0]      f1_round_mode;
logic [2:0]      f1_sew;
logic [4:0]      f1_tag;
logic            fp_mode;
logic            f3_main_pipe_stall;
logic            kill;

assign core_clk = clk;
assign core_reset_n = resetn;

initial begin
    clk = 0;
    forever begin
        #10;
        clk = ~clk;
    end
end

initial begin
    fdiv_req_ready <= 1;
    kill <= 0;
    f4_frf_stall <= 0;
    f1_ediv <= 0;
    f1_tag  <= 0;
    f1_sew <= 1;
    fp_mode <= 0;
    f3_main_pipe_stall <= 0;

//localparam ROUND_RNE = 3'b000;
//localparam ROUND_RTZ = 3'b001;
//localparam ROUND_RDN = 3'b010;
//localparam ROUND_RUP = 3'b011;
//localparam ROUND_RMM = 3'b100;

    f1_round_mode <= ROUND_RDN;
    fdiv_resp_round_mode <= ROUND_RDN;
    fdiv_resp_ctrl <= 0;
    f1_ex_ctrl <= 0;

    resetn = 'd1;
    repeat(4) @(posedge clk);
    resetn = 'd0;
    repeat(4) @(posedge clk);
    resetn = 'd1;

end

logic [15:0] fdiv_op1_q [$];
logic [15:0] fdiv_op2_q [$];
logic [20:0] fdiv_frac_q [$];
logic [15:0] kv_fdiv_op1_q [$];
logic [15:0] kv_fdiv_op2_q [$];
logic [20:0] kv_fdiv_frac_q [$];
logic [15:0] op1;
logic [15:0] op2;

logic [15:0] rand16;
initial begin
    //op1 = 16'h4c0d;
    //op1 = 16'h0000;
    //op1 = 16'b0111_11111_0000_0000;
    op1 = 16'h1000;
    op2 = 16'h1FFF;
    @(posedge resetn)
    forever begin
        wait(fdiv_op1_q.size() <= 10 && fdiv_op2_q.size() <= 10 && kv_fdiv_op1_q.size() <= 10 && kv_fdiv_op2_q.size() <= 10);
    
        if(fdiv_resp_ctrl  == 1) op1 = op2;
       
        fdiv_op1_q.push_front(op1);
        kv_fdiv_op1_q.push_front(op1);
        fdiv_op2_q.push_front(op2);
        kv_fdiv_op2_q.push_front(op2);

        if (op2 == 16'b1111111111111111) begin
            //op2 = 0;
            op2 = 16'h8FFF;
            op1 = op1 + 1;
        end
        else begin
            op2 = op2 + 1;
            //op1 = $random;
        end


        $display("op1:%h",op1);
        $display("op2:%h",op2);

        //if(op1 == 'd0 && op2 == 'd0) $finish;
        if(op1 == 'd0) $finish;
    end
end

initial begin
    fdiv_resp_valid <= 0;
    @(posedge resetn);
    forever begin
        wait(fdiv_op1_q.size() != 0 && fdiv_op2_q.size() != 0);
        fdiv_resp_valid <= 1;
        fdiv_resp_op1 <= fdiv_op1_q.pop_back();
        fdiv_resp_op2 <= fdiv_op2_q.pop_back();
        @(posedge clk iff (fdiv_resp_ready & fdiv_resp_valid));
        fdiv_resp_valid <= 0;
        fdiv_resp_op1 <= 'dx;
        fdiv_resp_op2 <= 'dx;
    end
end

initial begin
    f1_valid <= 0;
    @(posedge resetn);
    forever begin
        wait(kv_fdiv_op1_q.size() != 0 && kv_fdiv_op2_q.size() != 0);
        f1_valid <= 1;
        f1_op1_data[15:0] <= kv_fdiv_op1_q.pop_back();
        f1_op2_data[15:0] <= kv_fdiv_op2_q.pop_back();
        @(posedge clk iff (f1_valid));
        f1_valid <= 'd0;
        f1_op1_data <= 'dx;
        f1_op2_data <= 'dx;
        @(posedge clk iff (f4_wdata_en));
        f1_valid <= 0;
        f1_op1_data <= 'dx;
        f1_op2_data <= 'dx;
    end
end



// mon
initial begin
    @(posedge resetn);
    forever begin
        @(posedge clk iff (fdiv_req_valid & fdiv_req_ready));
        fdiv_frac_q.push_front({fdiv_req_flag,fdiv_req_frd});
    end
end

initial begin
    forever begin
        @(posedge clk iff f4_wdata_en);
        kv_fdiv_frac_q.push_front({f4_flag_set,f4_wdata[15:0]});
    end
end

logic [15:0] kv_frac;
logic [15:0] frac;
logic [4:0] kv_flag;
logic [4:0] flag;
logic [20:0] tmp;

// scb
initial begin
    @(posedge resetn);
    forever begin
        wait(fdiv_frac_q.size() != 0 && kv_fdiv_frac_q.size() != 0);
        tmp = fdiv_frac_q.pop_back();
        frac = tmp[15:0];
        flag = tmp[20:16];
        tmp = kv_fdiv_frac_q.pop_back();
        kv_frac = tmp[15:0];
        kv_flag = tmp[20:16];

        //$display("frac       :%h",frac);
        //$display("flag       :%b",flag);
        //$display("golden_frac:%h",kv_frac);
        //$display("golden_flag:%b",kv_flag);

        if (frac != kv_frac || flag != kv_flag) begin
            $display("frac       :%h",frac);
            $display("flag       :%b",flag);
            $display("golden_frac:%h",kv_frac);
            $display("golden_flag:%b",kv_flag);
            $display("ERROR");
            $finish;
        end
    end
end

acc_fdiv u_acc_fdiv(
     .clk                  (clk                  )
    ,.resetn               (resetn               )
    ,.fdiv_resp_ready      (fdiv_resp_ready      )
    ,.fdiv_resp_valid      (fdiv_resp_valid      )
    ,.fdiv_resp_op1        (fdiv_resp_op1        )
    ,.fdiv_resp_op2        (fdiv_resp_op2        )
    ,.fdiv_resp_ctrl       (fdiv_resp_ctrl       )
    ,.fdiv_resp_round_mode (fdiv_resp_round_mode )
    ,.fdiv_req_valid       (fdiv_req_valid       )
    ,.fdiv_req_ready       (fdiv_req_ready       )
    ,.fdiv_req_flag        (fdiv_req_flag        )
    ,.fdiv_req_frd         (fdiv_req_frd         )
);

kv_fpu_fdiv # (
     .FLEN(FLEN)
) u_kv_fpu_fdiv(
     .fdiv_standby_ready (fdiv_standby_ready  )
    ,.fp_mode            (fp_mode             )
    ,.f4_wdata           (f4_wdata            )
    ,.f4_wdata_en        (f4_wdata_en         )
    ,.f4_flag_set        (f4_flag_set         )
    ,.f4_tag             (f4_tag              )
    ,.f4_result_type     (f4_result_type      )
    ,.f4_frf_stall       (f4_frf_stall        )
    ,.f1_op1_data        (f1_op1_data         )
    ,.f1_op2_data        (f1_op2_data         )
    ,.f1_valid           (f1_valid            )
    ,.f1_tag             (f1_tag              )
    ,.f1_round_mode      (f1_round_mode       )
    ,.f1_sew             (f1_sew              )
    ,.f1_ediv            (f1_ediv             )
    ,.f1_ex_ctrl         (f1_ex_ctrl          )
    ,.core_clk           (core_clk            )
    ,.core_reset_n       (core_reset_n        )
    ,.kill               (kill                )
    ,.f3_main_pipe_stall (f3_main_pipe_stall  )
    ,.req_ready          (req_ready           )
);

endmodule
