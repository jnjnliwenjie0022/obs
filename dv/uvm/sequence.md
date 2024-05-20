# sequence_start

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
# \`uvm_do
[uvm_do系列](https://www.cnblogs.com/htaozy/p/8051849.html)
[uvm_do marco分析](https://blog.csdn.net/lbt_dvshare/article/details/86700415)
![[uvm_do_on_pri_with.canvas|uvm_do_on_pri_with]]
如果是ITEM，則
1. start_item (SEQ_OR_ITEM, PRIORITY)
2. randomize
3. finish_item (SEQ_OR_ITEM, PRIORITY)
如果是SEQ，則
1. start（SEQR，this，PRIORITY， 0）
---
For a sequence item, the following are called, in order
1. [start_item()]\`uvm_create(item)
2. [start_item()]sequencer.wait_for_grant(prior) (task)
3. this.pre_do(1) (task)
4. item.randomize()
5. this.mid_do(item) (func)
6. [finish_item()]sequencer.send_request(item) (func)
7. [finish_item()]sequencer.wait_for_item_done() (task)
8. [finish_item()]this.post_do(item) (func)
---
For a sequence, the following are called, in order
根據**`start`**的執行順序去執行
1. \`uvm_create(sub_seq)
2. sub_seq.randomize()
3. [start()]sub_seq.pre_start() (task)
4. [start()]this.pre_do(0) (task)
5. [start()]this.mid_do(sub_seq) (func)
6. [start()]sub_seq.body() (task)
7. [start()]this.post_do(sub_seq) (func)
8. [start()]sub_seq.post_start() (task)
![[Pasted image 20240521012610.png|1000]]
# seq.start()




https://verificationacademy.com/forums/t/sequence-not-getting-config-object-from-config-db/41958/8
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




