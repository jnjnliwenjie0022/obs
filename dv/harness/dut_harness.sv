
`ifndef MY_IF__SV
`define MY_IF__SV

interface dut_interface (
    input bit clk
);


logic clk;
logic resetn;

clocking cb @ (posedge clk);
    input i_data;
    output o_data;
endclocking
endinterface

module dut_harness ();

initial begin
    `uvm_info("dut_harness", "declare harness", UVM_LOW);
end

dut_interface dut_if ();

function void connect (string path);
    force dut.i_data = dut_if.i_data;
    force dut_if.o_data = dut.o_data;
    `uvm_info("dut_harness", "dut interface connect with harness interface", UVM_LOW);
    uvm_config_db#(virtual dut_interface)::set(null, env_path, "if", dut_if);
    `uvm_info("dut_harness", "harness interface set to uvm", UVM_LOW);
endfunction

endmodule

bind dut dut_harness u_dut_harness ();

`endif
