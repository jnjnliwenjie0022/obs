

`include "uvm_macros.svh"
import uvm_pkg::*;
import uvmc_pkg::*;

/*
Example to check consistency of pack/unpack on both the SV/UVM side and SystemC side.
In this example there are two connections made via UVMC.
1) SV to SystemC
2) SystemC to SV

Packets send on these two ports are of the same type.
Idea here is to check that after packing and unpacking we do not loose any information.

~producer_loop_back~ component initiates the transfers, while the ~consumer_loop_back~ component
returns the same transaction it received. At the end of the test, all the packets that are sent
are compared against the packets that are received from SystemC.
*/


/*
Class: req_packet
Simple transaction classes for testing tlm1 blocking transport port
*/
class req_packet extends uvm_sequence_item;

    rand bit rnw;
    rand bit [32-1:0] addr;
    rand logic [32-1:0] wdata;
    // for debug only
    bit [32-1:0] rdata;

    `uvm_object_utils_begin(req_packet)
        `uvm_field_int (rnw, UVM_ALL_ON)
        `uvm_field_int (addr, UVM_ALL_ON)
        `uvm_field_int (wdata, UVM_ALL_ON)
        `uvm_field_int (rdata, UVM_ALL_ON)
    `uvm_object_utils_end

    function new (string name = "req_packet");
        super.new(name);
    endfunction : new
endclass : req_packet

`ifndef DEBUG_UVMC_TRANSPORT_PORT_SAME_REQ_RSP
class rsp_packet extends uvm_sequence_item;

    rand bit [32-1:0] addr; // this is there for debug only
    rand bit [32-1:0] rdata;

    `uvm_object_utils_begin(rsp_packet)
        `uvm_field_int (addr, UVM_ALL_ON)
        `uvm_field_int (rdata, UVM_ALL_ON)
    `uvm_object_utils_end

    function new (string name = "rsp_packet");
        super.new(name);
    endfunction : new
endclass : rsp_packet
`else //
typedef req_packet rsp_packet;
`endif // DEBUG_UVMC_TRANSPORT_PORT_SAME_REQ_RSP

function bit compare_req_rp_packet(req_packet req, rsp_packet rsp);
    if ( (req.addr == rsp.addr) && (req.wdata == rsp.rdata) ) begin
        return 1;
    end else begin
        return 0;
    end
endfunction



module sv_main;

    /*
    Class: producer_with_transport_port
    */
    class producer_with_transport_port extends uvm_component;
        `uvm_component_utils(producer_with_transport_port)

        function new(string name, uvm_component parent=null);
            super.new(name,parent);
        endfunction

        uvm_blocking_transport_port #(req_packet, rsp_packet) out;


        req_packet out_q[$];
        rsp_packet in_q[$];
        bit compare_status;

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            out = new("out", this);
        endfunction

        virtual function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            uvmc_tlm1 #(req_packet, rsp_packet)::connect(out, "transport_port_sv_out");
        endfunction

        virtual task send_packet_out(int unsigned num=100);
            for (int unsigned num_i = 0; num_i < num; num_i ++) begin
                req_packet tx = new ($psprintf("req_seq_item_%1d", num_i));
                rsp_packet tx_rsp;
                void'(tx.randomize());
                `uvm_info(get_type_name(), $psprintf("sending item '%1d': \n%s", num_i, tx.sprint()), UVM_LOW)
                out_q.push_back(tx);
                out.transport(tx, tx_rsp);
                in_q.push_back(tx_rsp);
            end
        endtask

        virtual task run_phase(uvm_phase phase);
            phase.raise_objection(this);
            repeat(4) begin
                send_packet_out(10);
                # 20;
            end
            phase.drop_objection(this);
        endtask

        virtual function void do_check();
            int unsigned min_size;
            `uvm_info(get_type_name(), $psprintf("out_q size: %1d, in_q size: %1d", out_q.size(), in_q.size()), UVM_LOW)
            if (out_q.size() == in_q.size()) begin
                compare_status = 1;
            end else begin
                compare_status = 0;
            end
            min_size = in_q.size();
            if (min_size > out_q.size()) begin
                min_size = out_q.size();
            end
            for (int unsigned i_ = 0; i_ < min_size; i_++) begin
                bit compare_status_l;
                req_packet out_tx;
                rsp_packet in_tx;
                out_tx = out_q[i_];
                in_tx = in_q[i_];
                compare_status_l = compare_req_rp_packet(out_tx, in_tx);
                compare_status &= compare_status_l;
                if (compare_status_l == 0) begin
                    `uvm_warning(get_type_name(), $psprintf("index '%1d' does not match", i_))
                end
            end
        endfunction

        virtual function void do_report();
            if (compare_status == 0) begin
                `uvm_error(get_type_name(), $psprintf("In and out queues do not match"))
            end else begin
                `uvm_info(get_type_name(), $psprintf("In and out queues match"), UVM_LOW)
            end
        endfunction

        virtual function void check_phase(uvm_phase phase);
            super.check_phase(phase);
            do_check();
        endfunction

        virtual function void report_phase(uvm_phase phase);
            super.report_phase(phase);
            do_report();
        endfunction

        virtual function void pre_abort();
            super.pre_abort();
            do_check();
            do_report();
        endfunction
    endclass

    producer_with_transport_port prod = new("prod");

    initial begin
        run_test();
    end

endmodule
