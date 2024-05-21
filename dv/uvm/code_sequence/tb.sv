`include "uvm_macros.svh"
import uvm_pkg::*;

`include "seq_item.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "agent.sv"
`include "env.sv"

typedef class child_seq;
class base_seq extends uvm_sequence #(seq_item);
  seq_item req;
  child_seq cseq;
  `uvm_object_utils(base_seq)

  function new (string name = "base_seq");
    super.new(name);
  endfunction

  task pre_start();
    `uvm_info(get_type_name(), "Base seq: Inside pre_start", UVM_LOW);
  endtask

  task pre_body();
    `uvm_info(get_type_name(), "Base seq: Inside pre_body", UVM_LOW);
  endtask

  virtual task pre_do(bit is_item);
    `uvm_info(get_type_name(), "Base seq: Inside pre_do", UVM_LOW);
  endtask

  virtual function void mid_do(uvm_sequence_item this_item);
    `uvm_info(get_type_name(), "Base seq: Inside mid_do", UVM_LOW);
  endfunction

  task body();

    `uvm_info(get_type_name(), "Base seq: Inside Body", UVM_LOW);
    `uvm_do(req); // Calls all pre_do, mid_do and post_do methos.

    cseq = child_seq::type_id::create("cseq");
    cseq.start(null,this);

    //req = seq_item::type_id::create("req");
    //wait_for_grant();
    //assert(req.randomize());
    //send_request(req);
    //wait_for_item_done();

    //req = seq_item::type_id::create("req");
	//start_item(req);
	//assert(req.randomize());
	//finish_item(req);
  endtask

  virtual function void post_do(uvm_sequence_item this_item);
    `uvm_info(get_type_name(), "Base seq: Inside post_do", UVM_LOW);
  endfunction

  task post_body();
    `uvm_info(get_type_name(), "Base seq: Inside post_body", UVM_LOW);
  endtask
endclass

class child_seq extends base_seq;
  `uvm_object_utils(child_seq)

  function new (string name = "child_seq");
    super.new(name);
  endfunction

  task pre_start();
    `uvm_info(get_type_name(), "Child seq: Inside pre_start", UVM_LOW);
  endtask

  task pre_body();
    `uvm_info(get_type_name(), "Child seq: Inside pre_body", UVM_LOW);
  endtask

  task pre_do(bit is_item);
    `uvm_info(get_type_name(), "Child seq: Inside pre_do", UVM_LOW);
  endtask

  function void mid_do(uvm_sequence_item this_item);
    `uvm_info(get_type_name(), "Child seq: Inside mid_do", UVM_LOW);
  endfunction

  task body();
    `uvm_info(get_type_name(), "Child seq: Inside Body", UVM_LOW);
     //`uvm_do(req); // Calls all pre_do, mid_do and post_do methos.

  endtask

  function void post_do(uvm_sequence_item this_item);
    `uvm_info(get_type_name(), "Child seq: Inside post_do", UVM_LOW);
  endfunction

  task post_body();
    `uvm_info(get_type_name(), "Child seq: Inside post_body", UVM_LOW);
  endtask
endclass

class base_test extends uvm_test;
  env env_o;
  sequencer seqr;
  base_seq bseq;
  child_seq cseq;
  `uvm_component_utils(base_test)

  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = env::type_id::create("env_o", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    bseq = base_seq::type_id::create("bseq");
    cseq = child_seq::type_id::create("cseq");

    bseq.start(env_o.agt.seqr);
    $display("-----------------------------------------------------------------------------------");
    cseq.start(env_o.agt.seqr);
    $display("-----------------------------------------------------------------------------------");
    cseq.start(env_o.agt.seqr, bseq);

    phase.drop_objection(this);
  endtask
endclass


module tb;

    initial begin
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, tb);
    end

    initial begin
        run_test("base_test");
    end
endmodule
