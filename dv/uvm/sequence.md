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
# sequence_macro
[uvm_do系列](https://www.cnblogs.com/htaozy/p/8051849.html)
[uvm_do marco分析](https://blog.csdn.net/lbt_dvshare/article/details/86700415)
![[uvm_do_on_pri_with.canvas|uvm_do_on_pri_with]]
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
在seq中使用get_full_name(),得到需要的絕對路徑文字



https://verificationacademy.com/forums/t/sequence-not-getting-config-object-from-config-db/41958/8
