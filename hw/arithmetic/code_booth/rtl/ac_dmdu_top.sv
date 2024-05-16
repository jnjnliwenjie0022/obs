`include "uvm_macros.svh"
import uvm_pkg::*;

module top_tb;

    logic clk;
    logic req_en;
    logic req_sign;
    logic req_16b;
    logic [15:0] req_op0;
    logic [15:0] req_op1;
    logic [31:0] resp_result;

    always #10 clk = ~clk;
    initial begin
        clk <= 0;
    end
    initial begin
        #190;
        $finish;
    end

    initial begin
        req_en <= 'd0;
        @(posedge clk);
            req_en <=  1;
            req_16b <= 1;
            req_sign <= 1;
            req_op0 <= 16'd1;
            req_op1 <= 16'd1;
        @(posedge clk);
            req_en <=  1;
            req_16b <= 1;
            req_sign <= 1;
            req_op0 <= -16'd1;
            req_op1 <= 16'd1;
        @(posedge clk);
            req_en <=  1;
            req_16b <= 1;
            req_sign <= 1;
            req_op0 <= 16'd1;
            req_op1 <= -16'd1;
        @(posedge clk);
            req_en <=  1;
            req_16b <= 1;
            req_sign <= 1;
            req_op0 <= -16'd1;
            req_op1 <= -16'd1;
        @(posedge clk);
            req_en <=  1;
            req_16b <=  1;
            req_sign <= 0;
            req_op0 <= -16'd1;
            req_op1 <=  16'd1;
        @(posedge clk);
            req_en <=  1;
            req_16b <=  1;
            req_sign <= 0;
            req_op0 <=  16'hFFFF;
            req_op1 <=  16'hFFFF;
        @(posedge clk);
            req_en <=  1;
            req_16b <=  0;
            req_sign <= 1;
            req_op0 <=  16'hFFFF;
            req_op1 <=  16'hFFFF;
        @(posedge clk);
            req_en <=  1;
            req_16b <=  0;
            req_sign <= 0;
            req_op0 <=  16'habab;
            req_op1 <=  16'habab;
        @(posedge clk);
    end

    initial begin
        forever begin
        @(posedge clk iff req_en);
        $display("+++++++");
        $display("op0: %d, op1: %d", req_op0[15], req_op1[15]);
        $display("16b: %d", req_16b);
        $display("sign: %d", req_sign);
        $display("in0: %h", req_op0);
        $display("in1: %h", req_op1);
        $display("out: %h", resp_result);
        end
    end

    
    ac_dmdu u_ac_dmdu_0(
        .req_en       (req_en      )
        ,.req_sign    (req_sign    )
        ,.req_16b     (req_16b     )
        ,.req_op0     (req_op0     )
        ,.req_op1     (req_op1     )
        ,.resp_result (resp_result )
    );
endmodule
