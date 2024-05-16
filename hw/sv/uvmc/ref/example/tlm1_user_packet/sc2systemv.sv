package user_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import uvmc_pkg::*;

    class packet extends uvm_sequence_item;

        typedef enum { WRITE, READ, NOOP } cmd_t;

        rand cmd_t cmd;
        rand int   addr;
        rand byte  data[$];
        rand int   jasonli;

        function new(string name = "packet");
            super.new(name);
        endfunction

        constraint c_data_size { data.size() inside { [1:10] }; }

        `uvm_object_utils_begin(packet)
            `uvm_field_enum(cmd_t,cmd,UVM_ALL_ON)
            `uvm_field_int(addr,UVM_ALL_ON)
            `uvm_field_queue_int(data,UVM_ALL_ON)
            `uvm_field_int(jasonli,UVM_ALL_ON)
        `uvm_object_utils_end
    endclass

    class sv2sc_component #(type T = int) extends uvm_component;
        `uvm_component_param_utils(sv2sc_component #(T))

        uvm_blocking_put_port #(T) a_port;
        function new(string name = "sv2sc_component", uvm_component parent = null);
            super.new(name, parent);
            a_port = new("a_port", this);
        endfunction

        virtual task run_phase(uvm_phase phase);
            packet req;
            phase.raise_objection(this);

            req = packet::type_id::create("req");
            assert(req.randomize());
            req.print();
            a_port.put(req);

            phase.drop_objection(this);
        endtask
    endclass

    class sc2sv_component #(type T = int) extends uvm_component;
        `uvm_component_param_utils(sc2sv_component #(T))

        uvm_blocking_get_port #(T) a_port;
        function new(string name = "sc2sv_component", uvm_component parent = null);
            super.new(name, parent);
            a_port = new("a_port", this);
        endfunction

        virtual task run_phase(uvm_phase phase);
            packet req;
            phase.raise_objection(this);

            for(int i = 0; i < 1; i ++)begin
                a_port.get(req);
                req.print();
            end
            phase.drop_objection(this);
        endtask
    endclass

endpackage : user_pkg

module sv_main;
`include "uvm_macros.svh"
import uvm_pkg::*;
import uvmc_pkg::*;
import user_pkg::*;

class sv_env extends uvm_env;
    `uvm_component_utils(sv_env)

    uvm_tlm_analysis_fifo #(packet) sv2sc_a_fifo;
    uvm_tlm_analysis_fifo #(packet) sc2sv_a_fifo;
    function new(string name = "sv_env", uvm_component parent = null);
        super.new(name,parent);
        sv2sc_a_fifo = new("sv2sc_a_fifo");
        sc2sv_a_fifo = new("sc2sv_a_fifo");
    endfunction

    sv2sc_component #(packet) sv2sc_comp;
    sc2sv_component #(packet) sc2sv_comp;
    function void build_phase(uvm_phase phase);
        sv2sc_comp = sv2sc_component#(packet)::type_id::create("sv2sc_comp", this);
        sc2sv_comp = sc2sv_component#(packet)::type_id::create("sc2sv_comp", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        uvmc_tlm1 #(packet)::connect(sv2sc_a_fifo.get_export, "sv2sc_connect");
        uvmc_tlm1 #(packet)::connect(sc2sv_a_fifo.put_export, "sc2sv_connect");
        sv2sc_comp.a_port.connect(sv2sc_a_fifo.put_export);
        sc2sv_comp.a_port.connect(sc2sv_a_fifo.get_export);
    endfunction
endclass

sv_env env;

initial begin
    env = new("env");
    run_test();
end

endmodule
