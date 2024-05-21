class seq_item extends uvm_sequence_item;
  rand int a;
  `uvm_object_utils(seq_item)

  function new(string name = "seq_item");
    super.new(name);
  endfunction

endclass
