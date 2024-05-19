`ifndef MY_SEQUENCE__SV
`define MY_SEQUENCE__SV

class my_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function new(string name= "my_sequence");
        super.new(name);
    endfunction

    virtual task body();
        //{{{
        if(starting_phase != null) 
            starting_phase.raise_objection(this);
        //}}}
        repeat (10) begin
            `uvm_info("my_sequence", "body is called", UVM_LOW);
            //`uvm_do(m_trans)
            req = my_transaction::type_id::create("req"); 
            wait_for_grant();                            //wait for grant
            assert(req.randomize());                     //randomize the req                   
            send_request(req);                           //send req to driver
            wait_for_item_done();                        //wait for item done from driver
      end
      #1000;
        //{{{
        if(starting_phase != null) 
            starting_phase.drop_objection(this);
        //}}}
    endtask

    `uvm_object_utils(my_sequence)
endclass
`endif
