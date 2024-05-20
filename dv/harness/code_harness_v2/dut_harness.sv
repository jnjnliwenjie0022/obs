
`ifndef MY_IF__SV
`define MY_IF__SV

interface dut_interface (
     clk
    ,resetn
    ,i_data
    ,o_data
);

input clk;
input resetn;
input [7:0] i_data;
output [7:0] o_data;

endinterface

module dut_harness ();

initial begin
    `uvm_info("dut_harness", "declare harness", UVM_LOW);
end

dut_interface dut_if ();

function void connect (string path, string vif);
    force dut_if.clk = dut.clk;
    force dut.i_data = dut_if.i_data;
    force dut_if.o_data = dut.o_data;
    `uvm_info("dut_harness", "dut interface connect with harness interface", UVM_LOW);
    uvm_config_db#(virtual dut_interface)::set(null, path, vif, dut_if);
    `uvm_info("dut_harness", "harness interface set to uvm", UVM_LOW);
endfunction

endmodule

bind dut dut_harness u_harness ();
`endif
