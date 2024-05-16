package user_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import uvmc_pkg::*;

    class packet extends uvm_sequence_item;

        typedef enum { WRITE, READ, NOOP } cmd_t;

        rand cmd_t cmd;
        rand int   addr;
        rand byte  data[$];

        function new(string name = "packet");
            super.new(name);
        endfunction

        constraint c_data_size { data.size() inside { [1:10] }; }

        `uvm_object_utils_begin(packet)
            `uvm_field_enum(cmd_t,cmd,UVM_ALL_ON)
            `uvm_field_int(addr,UVM_ALL_ON)
            `uvm_field_queue_int(data,UVM_ALL_ON)
        `uvm_object_utils_end
    endclass

    class sv2systemc #(type T = int) extends uvm_component;
        `uvm_component_param_utils(sv2systemc #(T))
    
        uvm_tlm_b_initiator_socket #(T) isocket; 
        uvm_tlm_b_target_socket #(sv2systemc #(T), T) tsocket; 
        uvm_tlm_analysis_fifo #(T) a_fifo;
        uvm_analysis_port #(T) a_port;
        
        function new(string name, uvm_component parent=null);
            super.new(name,parent);
            isocket = new("isocket", this);
            tsocket = new("tsocket", this);
            a_fifo = new("a_fifo", this);
            a_port = new("a_port", this);
        endfunction
        
        task run_phase (uvm_phase phase);
            uvm_tlm_time delay = new("delay",1.0e-12);

            forever begin
                T pkt;
                a_fifo.get(pkt);
                delay.set_abstime(1,1e-9);
                isocket.b_transport(pkt,delay);
            end
        endtask

        virtual task b_transport (T t, uvm_tlm_time delay);
            a_port.write(t);
        endtask
    endclass

    class user_component extends uvm_component;
        `uvm_component_utils(user_component)

        uvm_tlm_analysis_fifo #(packet) a_fifo;
        uvm_analysis_port #(packet) a_port;
        function new(string name = "user_component", uvm_component parent = null);
            super.new(name, parent);
            a_fifo = new("a_fifo", this);
            a_port = new("a_port", this);
        endfunction

        extern virtual task tx(uvm_phase phase);
        extern virtual task rx();

        virtual task run_phase(uvm_phase phase);
            fork
                tx(phase);
                rx();
            join
        endtask
    endclass 

    task user_component::tx(uvm_phase phase);
        packet req;
        phase.raise_objection(this);
        repeat(20) begin
            req = packet::type_id::create("req");
            assert(req.randomize());
            a_port.write(req);
            #1000;
        end
        phase.drop_objection(this);
    endtask

    task user_component::rx();
        packet req;
        forever begin
            a_fifo.get(req);
            req.print();
        end
    endtask
endpackage : user_pkg

module sv_main;
`include "uvm_macros.svh"
import uvm_pkg::*;
import uvmc_pkg::*;
import user_pkg::*;

class sv_env extends uvm_env;
    `uvm_component_utils(sv_env)
 
    function new(string name = "sv_env", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    sv2systemc#(packet) sv2sc;
    user_component user_comp;

    function void build_phase(uvm_phase phase);
        sv2sc = sv2systemc#(packet)::type_id::create("sv2sc",this);
        user_comp = user_component::type_id::create("user_comp", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        uvmc_tlm #(packet)::connect(sv2sc.isocket, "sv2sc_connect");
        uvmc_tlm #(packet)::connect(sv2sc.tsocket, "sc2sv_connect");
        user_comp.a_port.connect(sv2sc.a_fifo.analysis_export);
        sv2sc.a_port.connect(user_comp.a_fifo.analysis_export);
    endfunction
endclass

sv_env env;

initial begin
    env = new("env");
    run_test();
end

endmodule
