//{{{ include
import uvm_pkg::*; 
import uvmc_pkg::*;

import uvm_pkg::*; 
`include "uvm_macros.svh"
//}}}
//{{{ sv2systemc
class sv2systemc extends uvm_component;
    `uvm_component_utils(sv2systemc)

    uvm_tlm_b_target_socket #(sv2systemc) tar_socket;
    uvm_tlm_analysis_fifo #(uvm_tlm_gp) a_fifo; 

    function new(string name = "sv2systemc", uvm_component parent = null);
        super.new(name,parent);
        tar_socket = new("tar_socket", this);
        a_fifo = new("a_fifo", this);
    endfunction

    virtual task b_transport (uvm_tlm_gp t, uvm_tlm_time delay);
        begin 
            uvm_tlm_gp gp;
            a_fifo.get(gp);
            t.m_address = gp.m_address;
            t.m_length = gp.m_length;
            t.m_data = gp.m_data;
        end
        #(delay.get_realtime(1ns,1e-9));
        delay.reset();
    endtask
endclass
//}}}
//{{{ sc2systemv
class sc2systemv extends uvm_component;
    `uvm_component_utils(sc2systemv)

    uvm_analysis_port #(uvm_tlm_gp) a_port;
    uvm_tlm_b_target_socket #(sc2systemv) tar_socket;

    function new(string name = "sc2systemv", uvm_component parent=null);
        super.new(name,parent);
        tar_socket = new("tar_socket", this);
        a_port = new("a_port", this);
    endfunction

    virtual task b_transport (uvm_tlm_gp t, uvm_tlm_time delay);
        a_port.write(t);
        #(delay.get_realtime(1ns,1e-9));
        delay.reset();
    endtask
endclass
//}}}
//{{{ sv2sc_component
class sv2sc_component extends uvm_component;
    `uvm_component_utils(sv2sc_component)

    uvm_analysis_port #(uvm_tlm_gp) a_port;

    function new(string name = "sv2sc_component", uvm_component parent = null);
        super.new(name, parent);
        a_port = new("a_port", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        uvm_tlm_gp t;

        phase.raise_objection(this);
        t = new;
        assert(t.randomize() with { t.m_byte_enable_length == 0;
                                         t.m_length inside {[1:8]};
                                         t.m_data.size() == m_length; } );
        a_port.write(t);
        `uvm_info("sv2systemc/SEND",{"\n",t.sprint()},UVM_MEDIUM)
        phase.drop_objection(this);
        endtask
endclass
//}}}
//{{{ sc2sv_component
class sc2sv_component extends uvm_component;
    `uvm_component_utils(sc2sv_component)

    uvm_tlm_analysis_fifo #(uvm_tlm_gp) a_fifo; 

    function new(string name = "sc2sv_component", uvm_component parent = null);
        super.new(name, parent);
        a_fifo = new("a_fifo", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            begin
                uvm_tlm_gp t;
                a_fifo.get(t);
        `       uvm_info("sv2systemc/GET",{"\n",t.sprint()},UVM_MEDIUM)
            end
        end
    endtask
endclass
//}}}
//{{{ user_enviroment
class user_enviroment extends uvm_env;
    `uvm_component_utils(user_enviroment)
 
    function new(string name = "user_enviroment", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    sc2systemv sc2sv;
    sv2systemc sv2sc;
    sv2sc_component sv2sc_comp;
    sc2sv_component sc2sv_comp;

    function void build_phase(uvm_phase phase);
        sc2sv = sc2systemv::type_id::create("sc2sv", this);
        sv2sc = sv2systemc::type_id::create("sv2sc", this);
        sv2sc_comp = sv2sc_component::type_id::create("sv2sc_comp", this);
        sc2sv_comp = sc2sv_component::type_id::create("sc2sv_comp", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        uvmc_tlm #()::connect(sv2sc.tar_socket, "sv2sc");
        uvmc_tlm #()::connect(sc2sv.tar_socket, "sc2sv");
        sv2sc_comp.a_port.connect(sv2sc.a_fifo.analysis_export);
        sc2sv.a_port.connect(sc2sv_comp.a_fifo.analysis_export);
    endfunction
endclass
//}}}
//{{{ sv_main
module sv_main;
    initial begin
        run_test("user_enviroment");
    end
endmodule
//}}}
