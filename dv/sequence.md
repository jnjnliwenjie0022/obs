# start_sequence

1. 透過start()
	```verilog
	// start task要傳入sequencer pointer，如果不指定pointer，則sequence不知道要將產生的trasacntion交給哪個sequencer
	task my_env::main_phase(uvm_phase phase)
	    my_sequence seq;
	    phase.raise_objection(this);

	    seq = my_sequence::type_id::create("seq");
	    seq.starting_phase = phase;
	    seq.start(i_agt.sqr);

	    phase.drop_objection(this);
	endtask
	```
2. 透過default_sequence
	[UVM——phase objection](https://east1203.github.io/2019/08/24/Verification/UVM/UVM%E2%80%94%E2%80%94phase%20objection/)
	```verilog
	// seq必須是作為sqr的某個phase的defualt_sequence
	// seqr在啟動sequence的時候會默認如下操作
	// task sequencer::run_phase(uvm_phase phase):
	//	...
	//	seq.starting_phase=phase;
	//	seq.start(this);
	//	...
	uvm_config_db#(uvm_object_wrapper)::set(this,
	        "seqr.run_phase",
	        "default_sequence",
	        `nds_axi_slave_memory_seq::type_id::get());
	```
3. 透過`uvm_do (不推薦)
	只能實作在sequence中

# uvm_config_db

in sequence
```verilog
if(!uvm_config_db#(int)::get(null,get_full_name(),"count1",count1))
	`uvm_fatal("int","fail");
```
out sequence
```verilog
uvm_config_db#(int)::set(null,"<get_full_name()>","count1",10);
```
在seq中使用get_full_name(),得到需要的絕對路徑

# order_of_starting_sequence
[uvm_do系列](https://www.cnblogs.com/htaozy/p/8051849.html)
```verilog
`define uvm_do_on_pri_with(SEQ_OR_ITEM, SEQR, PRIORITY, CONSTRAINTS) \
  begin \
  uvm_sequence_base __seq; \
  `uvm_create_on(SEQ_OR_ITEM, SEQR) \
  if (!$cast(__seq,SEQ_OR_ITEM)) start_item(SEQ_OR_ITEM, PRIORITY);\
  if ((__seq == null || !__seq.do_not_randomize) && !SEQ_OR_ITEM.randomize() with CONSTRAINTS ) begin \
    `uvm_warning("RNDFLD", "Randomization failed in uvm_do_with action") \
  end\
  if (!$cast(__seq,SEQ_OR_ITEM)) finish_item(SEQ_OR_ITEM, PRIORITY); \
  else __seq.start(SEQR, this, PRIORITY, 0); \
  end
```
![[Pasted image 20240520213839.png]] 
```verilog
`define uvm_create_on(SEQ_OR_ITEM, SEQR) \
  begin \
  uvm_object_wrapper w_; \
  w_ = SEQ_OR_ITEM.get_type(); \
  $cast(SEQ_OR_ITEM , create_item(w_, SEQR, `"SEQ_OR_ITEM`"));\
  end
```
```verilog
// Function: create_item
  //
  // Create_item will create and initialize a sequence_item or sequence
  // using the factory.  The sequence_item or sequence will be initialized
  // to communicate with the specified sequencer.

  protected function uvm_sequence_item create_item(uvm_object_wrapper type_var, 
                                                   uvm_sequencer_base l_sequencer, string name);

    uvm_coreservice_t cs = uvm_coreservice_t::get();                                                     
    uvm_factory factory=cs.get_factory();
    $cast(create_item,  factory.create_object_by_type( type_var, this.get_full_name(), name ));

    create_item.set_item_context(this, l_sequencer);
  endfunction
```








https://verificationacademy.com/forums/t/sequence-not-getting-config-object-from-config-db/41958/8
