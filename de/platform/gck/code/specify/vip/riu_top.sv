//`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

module top_tb;

    reg clk;
    reg [2:0] d;
    reg [2:0] q;
    reg [2:0] q_reg;
    reg [2:0] d_reg;
    reg [2:0] d_t;

    initial begin
        clk = 0;
        #150
        forever begin
            clk = ~clk;
            #10;
        end
    end

    initial begin
        repeat(10) @(posedge clk);
        $finish;
    end


    initial begin
        d = 0;
        @(posedge clk); // 150
        @(posedge clk); // 170
        d = 1; // active region
        repeat(1) @(posedge clk);
        d = 2;
        repeat(1) @(posedge clk);
        d = 3;
    end

    // This is the better coding style than the previous
    //initial begin
    //    d <= 0;
    //    @(posedge clk); // 150
    //    @(posedge clk); // 170
    //    d <= 1; // active region
    //    repeat(1) @(posedge clk);
    //    d <= 2;
    //    repeat(1) @(posedge clk);
    //    d <= 3;
    //end

    always @(posedge clk) begin
        q_reg <= q;
    end

    always @(posedge clk) begin // another processing 
        d_reg <= d;
        // RHS for NBA is active region
        // (RHS for NBA) and (d = 1) are simultaneously push into event queue
        // at 170: (RHS for NBA d) may be 0(old value) or 1(new value), which depend on EDA, the most EDA tool report 0(old value)
        // LHS for NBA is NBA region
        // Bed coding style
    end

    dut u_dut(
        .clk(clk)
        ,.q(q)
        ,.d(d)
    );


endmodule


module dut (clk, q, d);
input clk;
output [2:0] q;
input [2:0] d;

reg [2:0] q;

always @* begin
    q = d;
end

specify
    (d => q) = (20); // inactive
endspecify

endmodule

