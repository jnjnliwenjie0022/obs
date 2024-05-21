`include "uvm_macros.svh"
import uvm_pkg::*;
`include "dut_harness.sv"

class harness_sequence extends uvm_sequence;
    virtual dut_interface vif0;
    virtual dut_interface vif1;

    function new(string name = "harness_sequence");
        super.new(name);
    endfunction

    // {{{1 pre_body
    virtual task pre_body();
        int count0;
        int count1;

        if(starting_phase != null)
            starting_phase.raise_objection(this,get_type_name());

        if(!uvm_config_db#(int)::get(null,get_full_name(),"count0",count0))
            `uvm_fatal("count0","fail");
        `uvm_info(get_full_name(), $sformatf("count0: %d", count0), UVM_LOW);

        if(!uvm_config_db#(int)::get(null,get_full_name(),"count1",count1))
            `uvm_fatal("count1","fail");
        `uvm_info(get_full_name(), $sformatf("count1: %d", count1), UVM_LOW);

        if(!uvm_config_db#(virtual dut_interface)::get(null,get_full_name(),"vif0",vif0))
            `uvm_fatal("vif0","fail");

        if(!uvm_config_db#(virtual dut_interface)::get(null,get_full_name(),"vif1",vif1))
            `uvm_fatal("vif1","fail");
    endtask
    // }}}1
    // {{{1 post_body
    virtual task post_body();
        if(starting_phase != null)
            starting_phase.drop_objection(this,get_type_name());
    endtask
    // }}}1

        logic [7:0] cnt;
    virtual task body();
        `uvm_info(get_full_name(), "in body", UVM_LOW);
        cnt = 0;
        repeat(10) begin
            @(posedge vif0.clk);
            cnt = cnt + 1;
            vif0.i_data <= cnt;
            vif1.i_data <= cnt + 10;
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
        uvm_config_db#(int)::set(null,"h_seq","count1",10);
        tb.u_top.u_dut0.u_harness.connect("h_seq", "vif0");
        tb.u_top.u_dut1.u_harness.connect("h_seq", "vif1");
    endfunction

    task main_phase (uvm_phase phase);
        harness_sequence h_seq;
        `uvm_info(get_full_name(), "in main_phase", UVM_LOW);
        phase.raise_objection(this);
        h_seq = harness_sequence::type_id::create("h_seq");
        h_seq.starting_phase = phase;
        h_seq.start(null);
        phase.drop_objection(this);
    endtask

    `uvm_component_utils(harness_env)
endclass

module tb;

logic resetn;
logic clk;
logic [7:0] i_data;
logic [7:0] o_data0;
logic [7:0] o_data1;
logic [7:0] o_data2;
logic [7:0] o_data3;

initial begin
    i_data = 1'b1;
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

top u_top (
     .clk     (clk     )
    ,.resetn  (resetn  )
    ,.i_data  (i_data  )
    ,.o_data0 (o_data0 )
    ,.o_data1 (o_data1 )
    ,.o_data2 (o_data2 )
    ,.o_data3 (o_data3 )
);

initial begin
    forever begin
        @(posedge clk)
        $display("data0: %d",o_data0);
        $display("data1: %d",o_data1);
        $display("data2: %d",o_data2);
        $display("data3: %d",o_data3);
    end
end

initial begin
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0, tb);
end

initial begin
    uvm_config_db#(int)::set(null,"h_seq","count0",9);
    //tb.u_top.u_dut0.u_harness.connect("h_seq");
    run_test("harness_env");
end

endmodule

