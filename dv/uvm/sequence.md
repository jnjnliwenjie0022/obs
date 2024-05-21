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

# seq.start()
[(VLSI Verify)How to start a sequence?](https://vlsiverify.com/uvm/start-a-sequence/)
[(CV)How to execute sequence via start?](https://www.chipverify.com/uvm/how-to-execute-sequences-via-start-method)
![[Pasted image 20240521012610.png|1000]]
```verilog
bseq = base_seq::type_id::create("bseq");
bseq.start(env_o.agt.seqr);
```
UVM_INFO testbench.sv(21) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_start
UVM_INFO testbench.sv(25) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_body
UVM_INFO testbench.sv(38) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside Body
UVM_INFO testbench.sv(56) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_body

```verilog
bseq = base_seq::type_id::create("bseq");
bseq.start(env_o.agt.seqr);

`uvm_do(req)
```
UVM_INFO testbench.sv(21) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_start
UVM_INFO testbench.sv(25) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_body
UVM_INFO testbench.sv(38) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside Body
UVM_INFO testbench.sv(29) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_do
UVM_INFO testbench.sv(33) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside mid_do
UVM_INFO driver.sv(16) @ 0: uvm_test_top.env_o.agt.drv [driver] Driving logic
UVM_INFO testbench.sv(52) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_do
UVM_INFO testbench.sv(56) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_body
```verilog
bseq = base_seq::type_id::create("bseq");
bseq.start(env_o.agt.seqr);

req = seq_item::type_id::create("req");
wait_for_grant();
assert(req.randomize());
send_request(req);
wait_for_item_done();
```
UVM_INFO [testbench.sv](http://testbench.sv)(21) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_start
UVM_INFO [testbench.sv](http://testbench.sv)(25) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_body
UVM_INFO [testbench.sv](http://testbench.sv)(38) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside Body
UVM_INFO [driver.sv](http://driver.sv)(16) @ 0: uvm_test_top.env_o.agt.drv [driver] Driving logic
UVM_INFO [testbench.sv](http://testbench.sv)(56) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_body
```verilog
bseq = base_seq::type_id::create("bseq");
bseq.start(env_o.agt.seqr);

req = seq_item::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
```
UVM_INFO [testbench.sv](http://testbench.sv)(21) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_start
UVM_INFO [testbench.sv](http://testbench.sv)(25) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_body
UVM_INFO [testbench.sv](http://testbench.sv)(38) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside Body
UVM_INFO [testbench.sv](http://testbench.sv)(29) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_do
UVM_INFO [testbench.sv](http://testbench.sv)(33) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside mid_do
UVM_INFO [driver.sv](http://driver.sv)(16) @ 0: uvm_test_top.env_o.agt.drv [driver] Driving logic
UVM_INFO [testbench.sv](http://testbench.sv)(57) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_do
UVM_INFO [testbench.sv](http://testbench.sv)(61) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_body
```verilog
bseq = base_seq::type_id::create("bseq");
bseq.start(env_o.agt.seqr);

cseq = child_seq::type_id::create("cseq");
cseq.start(null);
```
UVM_INFO [testbench.sv](http://testbench.sv)(21) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_start
UVM_INFO [testbench.sv](http://testbench.sv)(25) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_body
UVM_INFO [testbench.sv](http://testbench.sv)(38) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside Body
UVM_INFO [testbench.sv](http://testbench.sv)(73) @ 0: reporter@@cseq [child_seq] Child seq: Inside pre_start
UVM_INFO [testbench.sv](http://testbench.sv)(77) @ 0: reporter@@cseq [child_seq] Child seq: Inside pre_body
UVM_INFO [testbench.sv](http://testbench.sv)(89) @ 0: reporter@@cseq [child_seq] Child seq: Inside Body
UVM_INFO [testbench.sv](http://testbench.sv)(99) @ 0: reporter@@cseq [child_seq] Child seq: Inside post_body
UVM_INFO [testbench.sv](http://testbench.sv)(61) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_body
```verilog
bseq = base_seq::type_id::create("bseq");
bseq.start(env_o.agt.seqr);

`uvm_do(req); // Calls all pre_do, mid_do and post_do methos.
cseq = child_seq::type_id::create("cseq");
cseq.start(null);
```
UVM_INFO [testbench.sv](http://testbench.sv)(21) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_start
UVM_INFO [testbench.sv](http://testbench.sv)(25) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_body
UVM_INFO [testbench.sv](http://testbench.sv)(38) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside Body
UVM_INFO [testbench.sv](http://testbench.sv)(29) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_do
UVM_INFO [testbench.sv](http://testbench.sv)(33) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside mid_do
UVM_INFO [driver.sv](http://driver.sv)(16) @ 0: uvm_test_top.env_o.agt.drv [driver] Driving logic
UVM_INFO [testbench.sv](http://testbench.sv)(57) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_do
UVM_INFO [testbench.sv](http://testbench.sv)(73) @ 50: reporter@@cseq [child_seq] Child seq: Inside pre_start
UVM_INFO [testbench.sv](http://testbench.sv)(77) @ 50: reporter@@cseq [child_seq] Child seq: Inside pre_body
UVM_INFO [testbench.sv](http://testbench.sv)(89) @ 50: reporter@@cseq [child_seq] Child seq: Inside Body
UVM_INFO [testbench.sv](http://testbench.sv)(99) @ 50: reporter@@cseq [child_seq] Child seq: Inside post_body
UVM_INFO [testbench.sv](http://testbench.sv)(61) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_body

https://verificationacademy.com/forums/t/sequence-not-getting-config-object-from-config-db/41958/8
```verilog
reg_seq.start(.sequencer(<handle of your sequencer>), .parent_sequence(null) );
```

```verilog
bseq = base_seq::type_id::create("bseq");
bseq.start(env_o.agt.seqr);

cseq = child_seq::type_id::create("cseq");
cseq.start(null,this);
```
UVM_INFO testbench.sv(21) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_start
UVM_INFO testbench.sv(25) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_body
UVM_INFO testbench.sv(38) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside Body
UVM_INFO testbench.sv(73) @ 0: uvm_test_top.env_o.agt.seqr@@bseq.cseq [child_seq] Child seq: Inside pre_start
UVM_INFO testbench.sv(77) @ 0: uvm_test_top.env_o.agt.seqr@@bseq.cseq [child_seq] Child seq: Inside pre_body
UVM_INFO testbench.sv(29) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_do
UVM_INFO testbench.sv(33) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside mid_do
UVM_INFO testbench.sv(89) @ 0: uvm_test_top.env_o.agt.seqr@@bseq.cseq [child_seq] Child seq: Inside Body
UVM_INFO testbench.sv(57) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_do
UVM_INFO testbench.sv(99) @ 0: uvm_test_top.env_o.agt.seqr@@bseq.cseq [child_seq] Child seq: Inside post_body
UVM_INFO testbench.sv(61) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_body
```verilog
bseq = base_seq::type_id::create("bseq");
bseq.start(env_o.agt.seqr);

`uvm_do(req); // Calls all pre_do, mid_do and post_do methos.
cseq = child_seq::type_id::create("cseq");
cseq.start(null,this);
```
UVM_INFO testbench.sv(21) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_start
UVM_INFO testbench.sv(25) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_body
UVM_INFO testbench.sv(38) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside Body
UVM_INFO testbench.sv(29) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_do
UVM_INFO testbench.sv(33) @ 0: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside mid_do
UVM_INFO driver.sv(16) @ 0: uvm_test_top.env_o.agt.drv [driver] Driving logic
UVM_INFO testbench.sv(57) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_do
UVM_INFO testbench.sv(73) @ 50: uvm_test_top.env_o.agt.seqr@@bseq.cseq [child_seq] Child seq: Inside pre_start
UVM_INFO testbench.sv(77) @ 50: uvm_test_top.env_o.agt.seqr@@bseq.cseq [child_seq] Child seq: Inside pre_body
UVM_INFO testbench.sv(29) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside pre_do
UVM_INFO testbench.sv(33) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside mid_do
UVM_INFO testbench.sv(89) @ 50: uvm_test_top.env_o.agt.seqr@@bseq.cseq [child_seq] Child seq: Inside Body
UVM_INFO testbench.sv(57) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_do
UVM_INFO testbench.sv(99) @ 50: uvm_test_top.env_o.agt.seqr@@bseq.cseq [child_seq] Child seq: Inside post_body
UVM_INFO testbench.sv(61) @ 50: uvm_test_top.env_o.agt.seqr@@bseq [base_seq] Base seq: Inside post_body
# nested_sequence
![[nested_sequence.svg]]
第一個seq
1. 必定有start
2. 必定為null
第二個seq
1. 必定有start
2. 可為null or this
3. 必定有uvm_declare_p_sequencer
最後一個seq
1. 必定沒有start
2. 可以有uvm_declare_p_sequencer
3. 必定有send_request
4. 必定有uvm_sequence # (item(cfg_if))
# reative_arch
[[649575fcbf99287ba25f20e8_litterick_uvm_slaves2_paper.pdf]]

# p_sequencer
[m_sequencer and p_sequencer](https://blog.csdn.net/u011177284/article/details/106274611)
```verilog
`uvm_declare_p_sequencer(user_defined_sequencer)
```
equivalent with
```verilog
uvm_sequencer_base m_sequencer;
user_defined_sequencer p_sequencer;
!$cast(p_sequencer, m_sequencer)
```

sqr會在seq.start(sqr)的時候記錄在seq內，以m_sequencer的變數儲存

m_sequencer和p_sequencer是一樣的東西，只差在型態不同

1. m_sequencer的型態: uvm_sequencer_base
2. p_sequencer的型態: user_defined_sequencer
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




