# start_sequence
1. 透過start()

# sequence
https://verificationacademy.com/forums/t/sequence-not-getting-config-object-from-config-db/41958/8
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
