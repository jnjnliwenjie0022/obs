`include "uvm_macros.svh"
import uvm_pkg::*;

class harness_sequence extends uvm_sequence;

    function new(string name = "harness_sequence");
        super.new(name);
    endfunction

    // {{{1 pre_body
    virtual task pre_body();
        int count;

        if(starting_phase != null) starting_phase.raise_objection(this,get_type_name());

        if(!uvm_config_db#(int)::get(null,get_full_name(),"count",count)) `uvm_fatal("body","fail");
        `uvm_info(get_full_name(), $sformatf("count: %d", count), UVM_LOW);
    endtask
    // }}}1
    // {{{1 post_body
    virtual task post_body();
        if(starting_phase != null) starting_phase.drop_objection(this,get_type_name());
    endtask
    // }}}1

    virtual task body();
        repeat(10) begin
            `uvm_info(get_full_name(), "Hi !!", UVM_LOW);
            #100;
        end
    endtask

    `uvm_object_utils(harness_sequence)
endclass

class harness_env extends uvm_env;
    function new(string name = "harness_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(int)::set(null,"h_seq","count",9);
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

reg resetn;
reg clk;

initial begin
    resetn = 1'b0;
    repeat(3) @(posedge clk);
    resetn = 1'b1;
end

initial begin
    clk = 0;
    forever begin
        #100
        clk = ~clk;
    end
end

//top u_top (
//     .clk     (clk     )
//    ,.resetn  (resetn  )
//    ,.i_data  (i_data  )
//    ,.o_data0 (o_data0 )
//    ,.o_data1 (o_data1 )
//    ,.o_data2 (o_data2 )
//    ,.o_data3 (o_data3 )
//);

initial begin
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0, tb);
end

initial begin
    run_test("harness_env");
end

endmodule

