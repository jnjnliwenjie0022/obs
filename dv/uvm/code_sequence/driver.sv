class driver extends uvm_driver#(seq_item);
  `uvm_component_utils(driver)

  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase (uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      void'(req.randomize());
      `uvm_info(get_type_name(), "Driving logic", UVM_LOW);
      #50; // Driving delay. Assuming time taken to drive RTL signals
      seq_item_port.item_done();
    end
  endtask
endclass
