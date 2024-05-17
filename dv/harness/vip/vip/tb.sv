`include "uvm_macros.svh"
import uvm_pkg::*;

`include "harness_if.sv"

class harness_monitor extends uvm_monitor;

    `uvm_component_utils(harness_monitor)
endclass

class harness_sequence extends uvm_sequence;
    function new(string name = "harness_sequence");
        super.new(name);
    endfunction

    virtual task pre_body();
        if(starting_phase != null) starting_phase.raise_objection(this,get_type_name());
    endtask

    virtual task post_body();
        if(starting_phase != null) starting_phase.drop_objection(this,get_type_name());
    endtask

    virtual task body();
        #100;
    endtask

    `uvm_object_utils(harness_sequence)
endclass

class harness_env extends uvm_env;
    function new(string name = "harness_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    task main_phase (uvm_phase phase);
        harness_sequence h_seq;
        phase.raise_objection(this);
        h_seq = harness_sequence::type_id::create("h_seq");
        h_seq.starting_phase = phase;
        h_seq.start(null);
        phase.drop_objection(this);
    endtask

    `uvm_component_utils(harness_env)
endclass

module tb;

initial begin
    run_test("harness_env");
end

endmodule
