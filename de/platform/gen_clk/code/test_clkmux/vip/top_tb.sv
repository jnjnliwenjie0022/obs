`include "uvm_macros.svh"
import uvm_pkg::*;

module top_tb;
    logic reset0_n;
    logic reset1_n;
    logic clk_in0;
    logic clk_in1;
    logic select;
    logic test_mode;
    logic clk_out;

    always #10 clk_in0 = ~clk_in0;
    initial begin
        clk_in0 = 0;
        reset0_n = 1;
        repeat(5) @(posedge clk_in0);
        reset0_n = 0;
        repeat(6) @(posedge clk_in0);
        reset0_n = 1;
    end

    always #15 clk_in1 = ~clk_in1;
    initial begin 
        clk_in1 = 0;
        reset1_n = 1;
        repeat(5) @(posedge clk_in1);
        reset1_n = 0;
        repeat(6) @(posedge clk_in1);
        reset1_n = 1;
    end

    initial begin
        test_mode <= 0;
        select <= 0;
        @(posedge reset0_n);
        @(posedge reset1_n);
        #88;
        select <= 1;
        #122;
        select <= 0;
        #144;
        select <= 1;
        #166;
        select <= 1;
        #188;
        $finish;
    end


async_clkmux u_async_clkmux (
     .reset0_n  (reset0_n  )
    ,.reset1_n  (reset1_n  )
    ,.clk_in0   (clk_in0   )
    ,.clk_in1   (clk_in1   )
    ,.select    (select    )
    ,.test_mode (test_mode )
    ,.clk_out   (clk_out   )
);

endmodule
