///// consumer.sv /////
import uvm_pkg::*;
`include "uvm_macros.svh"
 
class consumer #(type T=int) extends uvm_component;
 
   uvm_tlm_b_target_socket #(consumer #(T), T) in;
 
   int num_pkts;
 
   `uvm_component_param_utils(consumer #(T))
 
   function new(string name, uvm_component parent=null);
      super.new(name,parent);
      in = new("in", this);
      num_pkts = 10;
   endfunction : new
 
   virtual task b_transport (T t, uvm_tlm_time delay);
     `uvm_info("CONSUMER/PKT/RECV", $sformatf("SV consumer response:\n   %s", t.convert2string()), UVM_MEDIUM)
     #(delay.get_realtime(1ns,1e-9));
   endtask
 
endclass
