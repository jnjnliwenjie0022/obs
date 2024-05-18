`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_if.sv"
`include "dut_harness.sv"
`include "my_transaction.sv"
`include "my_sequencer.sv"
`include "my_driver.sv"
`include "my_monitor.sv"
`include "my_agent.sv"
`include "my_model.sv"
`include "my_scoreboard.sv"
`include "my_env.sv"
`include "base_test.sv"
`include "my_case0.sv"
`include "my_case1.sv"

module tb;

reg clk;
reg rst_n;

dut u_dut(
    .clk   (clk             ),
    .rst_n (rst_n           ),
    .rxd   (),
    .rx_dv (),
    .txd   (),
    .tx_en ()
);


initial begin
   clk = 0;
   forever begin
      #100 clk = ~clk;
   end
end

initial begin
   rst_n = 1'b0;
   #1000;
   rst_n = 1'b1;
end

initial begin
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0, tb);
end
initial begin
    run_test();
end

initial begin
    u_dut.harness.set_vifs("*.env.*");
end
endmodule
