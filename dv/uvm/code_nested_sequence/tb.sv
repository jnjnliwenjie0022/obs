//`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
//{{{ typedef
typedef enum bit [31:0] {READ, WRITE} item_type_t;
typedef struct packed{
    integer riu_addr_bitwidth;
    integer riu_data_bitwidth;
} cfg_riu_if_t;

parameter cfg_riu_if_t cfg_riu_if = '{
    riu_addr_bitwidth: 32
   ,riu_data_bitwidth: 64
};
//}}}
//{{{ interface
interface riu_if #(parameter cfg_riu_if_t cfg_if = 0)(clk, rst_n);
    input clk;
    input rst_n;

    logic riu_wr;
    logic riu_en;
    logic [cfg_if.riu_addr_bitwidth-1:0] riu_addr;
    logic [cfg_if.riu_data_bitwidth-1:0] riu_wdata;
    logic [cfg_if.riu_data_bitwidth-1:0] riu_rdata;
    logic riu_ready;

    AST_wr_unknown:
        assert property (@(posedge clk) (riu_en & riu_wr) |-> !$isunknown({riu_addr, riu_wdata, riu_ready}))
        else $error("wr is unknown");
    AST_rd_unknown:
        assert property (@(posedge clk) (riu_en & ~riu_wr) |-> !$isunknown({riu_rdata, riu_ready}))
        else $error("rd is unknown");

endinterface
//}}}
//{{{ riu_item
class riu_item#(parameter cfg_riu_if_t cfg_if = 0)extends uvm_sequence_item;
    function new(string name = "riu_item");
        super.new(name);
    endfunction

    item_type_t item_type;
    rand bit wr;
    rand bit [31:0] addr;
    rand bit [31:0] data;
    rand bit [2:0] delay;

    `uvm_object_param_utils_begin(riu_item#(cfg_if))
        `uvm_field_enum(item_type_t, item_type, UVM_ALL_ON)
        `uvm_field_int(wr, UVM_ALL_ON)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(delay, UVM_ALL_ON)
        `uvm_field_int(data, UVM_ALL_ON)
    `uvm_object_utils_end

    constraint c_delay_cycle{
        delay dist {0:=95, [1:128]:/5};
    }

endclass
//}}}
typedef class riu_sqr;
typedef class riu_cdma_sequence;
typedef class riu_sequence;
//{{{ user_sequence
class user_sequence#(parameter cfg_riu_if_t cfg_if = 0)extends uvm_sequence;
    `uvm_object_param_utils(user_sequence#(cfg_if))
    `uvm_declare_p_sequencer(riu_sqr#(cfg_if))

    function new(string name = "user_sequence");
        super.new(name);
    endfunction

    task pre_body();
        if(starting_phase != null) starting_phase.raise_objection(this,get_type_name());
    endtask

    task post_body();
        if(starting_phase != null) starting_phase.drop_objection(this,get_type_name());
    endtask

    virtual task body();
        riu_cdma_sequence#(cfg_if) riu_cdma_seq;
        riu_cdma_seq = riu_cdma_sequence#(cfg_if)::type_id::create("seq");
        riu_cdma_seq.starting_phase = starting_phase;
        riu_cdma_seq.start(p_sequencer,this);
    endtask
endclass
//}}}
//{{{ riu_cdma_sequence
class riu_cdma_sequence#(parameter cfg_riu_if_t cfg_if = 0)extends uvm_sequence;
    `uvm_object_param_utils(riu_cdma_sequence#(cfg_if))
    `uvm_declare_p_sequencer(riu_sqr#(cfg_if))

    function new(string name = "riu_cdma_sequence");
        super.new(name);
    endfunction

    rand bit wr;
    rand bit [22-1:0] cdma_sfence;
    rand bit [22-1:0] cdma_direction;
    rand bit [22-1:0] cdma_exram_addr_22lsb;
    rand bit [22-1:0] cdma_exram_addr_10msb;
    rand bit [22-1:0] cdma_exram_c;

    static bit [22-1:0] cdma_direction_reg = 0;
    static bit [22-1:0] cdma_exram_addr_22lsb_reg = 0;
    static bit [22-1:0] cdma_exram_addr_10msb_reg = 0;
    static bit [22-1:0] cdma_exram_c_reg = 0;

    task pre_body();
        if(starting_phase != null) starting_phase.raise_objection(this,get_type_name());
    endtask

    task post_body();
        if(starting_phase != null) starting_phase.drop_objection(this,get_type_name());
    endtask

    virtual task body();
        riu_sequence#(cfg_if) seq;
        seq = riu_sequence#(cfg_if)::type_id::create("seq");

        seq.wr = this.wr;
        repeat(1)begin
            //seq.addr = this.
            seq.data = this.cdma_direction;
            if(this.cdma_direction != this.cdma_direction_reg)
                seq.start(p_sequencer,this);
            cdma_direction_reg = cdma_direction;

            //seq.addr = this.
            seq.data = this.cdma_exram_addr_22lsb;
            if(this.cdma_exram_addr_22lsb != cdma_exram_addr_22lsb_reg)
                seq.start(p_sequencer,this);
            cdma_exram_addr_22lsb_reg = cdma_exram_addr_22lsb;

            //seq.addr = this.
            seq.data = this.cdma_exram_addr_10msb;
            if(this.cdma_exram_addr_10msb != cdma_exram_addr_10msb_reg)
                seq.start(p_sequencer,this);
            cdma_exram_addr_10msb_reg = cdma_exram_addr_10msb;

            //seq.addr = this.
            seq.data = this.cdma_exram_c;
            if(this.cdma_exram_c != cdma_exram_c_reg)
                seq.start(p_sequencer,this);
            cdma_exram_c_reg = cdma_exram_c;

            //seq.addr = this.
            seq.data = this.cdma_sfence;
            seq.start(p_sequencer,this);
        end
    endtask
endclass
//}}}
//{{{ riu_ldma_sequence
//}}}
//{{{ riu_sdma_sequence
//}}}
//{{{ riu_gemm_sequence
//}}}
//{{{ riu_edp_sequence
//}}}
//{{{ riu_sequence
class riu_sequence#(parameter cfg_riu_if_t cfg_if = 0)extends uvm_sequence #(riu_item#(cfg_if));
    `uvm_object_param_utils(riu_sequence#(cfg_if))

    function new(string name = "riu_sequence");
        super.new(name);
    endfunction

    rand bit wr;
    rand bit [31:0] addr;
    rand bit [31:0] data;

    extern virtual task drive_item();

    task pre_body();
        if(starting_phase != null) starting_phase.raise_objection(this,get_type_name());
    endtask

    task post_body();
        if(starting_phase != null) starting_phase.drop_objection(this,get_type_name());
    endtask

    virtual task body();
        drive_item();
    endtask
endclass

task riu_sequence::drive_item();
    riu_item#(cfg_if) item;

    repeat(1) begin
        req = riu_item#(cfg_if)::type_id::create("req");
        wait_for_grant();
        assert(req.randomize(delay)) else `uvm_fatal(get_full_name(),"randomize error");
        req.wr = this.wr;
        req.addr = this.addr;
        req.data = this.data;
        send_request(req);
        wait_for_item_done();
        get_response(rsp);
    end
endtask
//}}}
//{{{ riu_sqr OK
class riu_sqr#(parameter cfg_riu_if_t cfg_if = 0)extends uvm_sequencer#(riu_item#(cfg_if));
    `uvm_component_param_utils(riu_sqr#(cfg_if))
    function new(string name = "riu_sqr", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass
//}}}
//{{{ riu_drv OK
class riu_drv#(parameter cfg_riu_if_t cfg_if = 0)extends uvm_driver #(riu_item#(cfg_if));
    `uvm_component_param_utils(riu_drv#(cfg_if))
    function new(string name = "riu_drv", uvm_component parent);
        super.new(name, parent);
    endfunction

    mailbox #(riu_item#(cfg_if)) item_mbox;
    virtual interface riu_if#(cfg_if) vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual interface riu_if#(cfg_if))::get(this, "", "vif", vif))
            `uvm_fatal(get_full_name(), "virtual interface must be set");
        item_mbox = new("item_mbox");
    endfunction


    extern virtual task reset_signals();
    extern virtual task get_item();
    extern virtual task drive_item();

    virtual task run_phase(uvm_phase phase);
        reset_signals();
        fork
            get_item();
            drive_item();
        join
    endtask
endclass

task riu_drv::reset_signals();
    vif.riu_en <= 'bx;
    wait(!vif.rst_n);
    vif.riu_en <= 'b0;
    @(posedge vif.rst_n);
endtask

task riu_drv::get_item();
    forever begin
        seq_item_port.get_next_item(req);
        item_mbox.put(req);
        $cast(rsp, req.clone());
        rsp.set_id_info(req);
        seq_item_port.item_done();
    end
endtask

task riu_drv::drive_item();
    riu_item#(cfg_if) item;

    forever begin
        item_mbox.get(item);
        repeat (item.delay) @(posedge vif.clk);
        vif.riu_wr    <= item.item_type;
        vif.riu_addr  <= item.addr;
        vif.riu_wdata <= item.data;
        vif.riu_en    <= 1;
        @(posedge vif.clk iff(vif.riu_en & vif.riu_ready));
        seq_item_port.put_response(rsp);
        vif.riu_en    <= 0;
        vif.riu_wr    <= 'dx;
        vif.riu_addr  <= 'dx ;
        vif.riu_wdata <= 'dx;
    end
endtask
//}}}
//{{{ riu_mon OK
class riu_mon#(parameter cfg_riu_if_t cfg_if = 0)extends uvm_monitor;
    `uvm_component_param_utils(riu_mon#(cfg_if))

    uvm_analysis_port #(riu_item#(cfg_if)) item_port;

    function new(string name = "riu_mon", uvm_component parent);
        super.new(name, parent);
        item_port = new("item_port", this);
    endfunction

    virtual interface riu_if#(cfg_if) vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual interface riu_if#(cfg_if))::get(this, "", "vif", vif))
            `uvm_fatal(get_full_name(), "virtual interface must be set")
    endfunction

    extern virtual task monitor();

    virtual task run_phase(uvm_phase phase);
        fork
            monitor();
        join
    endtask
endclass

task riu_mon::monitor();
    riu_item#(cfg_if) item;

    @(posedge vif.rst_n);
    forever begin
        @(posedge vif.clk iff(vif.riu_en & vif.riu_ready))
        item = riu_item#(cfg_if)::type_id::create("item");

        item_port.write(item);

        accept_tr(item, $time);
        void'(this.begin_tr(item, "item"));
        @(negedge vif.clk);
        this.end_tr(item);
    end
endtask
//}}}
//{{{ riu_agt OK
class riu_agt#(parameter cfg_riu_if_t cfg_if = 0)extends uvm_agent;
    `uvm_component_param_utils(riu_agt#(cfg_if))

    uvm_tlm_analysis_fifo #(riu_item#(cfg_if)) fifo_mon_sqr_item;

    function new(string name = "riu_agt", uvm_component parent);
        super.new(name, parent);
        fifo_mon_sqr_item = new("fifo_mon_sqr_item", this);
    endfunction

    riu_sqr#(cfg_if) sqr;
    riu_drv#(cfg_if) drv;
    riu_mon#(cfg_if) mon;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sqr = riu_sqr#(cfg_if)::type_id::create("sqr", this);
        drv = riu_drv#(cfg_if)::type_id::create("drv", this);
        mon = riu_mon#(cfg_if)::type_id::create("mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        mon.item_port.connect(fifo_mon_sqr_item.analysis_export);
    endfunction
endclass
//}}}
//{{{ based_env OK
class based_env#(parameter cfg_riu_if_t cfg_if=0) extends uvm_env;
    `uvm_component_param_utils(based_env#(cfg_if))

    function new(string name = "env", uvm_component parent);
        super.new(name, parent);
    endfunction

    riu_agt#(cfg_if) agt;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = riu_agt#(cfg_if)::type_id::create("agt", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction
endclass
//}}}
//{{{ based_test OK
class based_test extends uvm_test;
   `uvm_component_utils(based_test)

    function new(string name = "based_test", uvm_component parent);
        super.new(name,parent);
    endfunction

    based_env#(cfg_riu_if) env;
    user_sequence#(cfg_riu_if) user_seq;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //uvm_config_db#(int)::set(null, "*", "recording_detail", UVM_FULL);
        env = based_env#(cfg_riu_if)::type_id::create("env", this);
        user_seq = user_sequence#(cfg_riu_if)::type_id::create("seq");
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        user_seq.starting_phase = phase;
        user_seq.start(env.agt.sqr,null);

        phase.drop_objection(this);
    endtask
endclass

//}}}
//{{{ tb OK
module tb;
    reg clk, rst_n;

    riu_if#(cfg_riu_if)_if(clk, rst_n);

    riu#(
        .RIU_ADDR_BITWIDTH  (cfg_riu_if.riu_addr_bitwidth )
        ,.RIU_DATA_BITWIDTH (cfg_riu_if.riu_data_bitwidth )
    )u_riu_0(
        .clk        (clk           )
        ,.rst_n     (rst_n         )
        ,.riu_wr    (_if.riu_wr    )
        ,.riu_en    (_if.riu_en    )
        ,.riu_addr  (_if.riu_addr  )
        ,.riu_wdata (_if.riu_wdata )
        ,.riu_rdata (_if.riu_rdata )
        ,.riu_ready (_if.riu_ready )
    );

    always #10 clk = ~clk;
    initial begin
        {clk,rst_n} <= 0;
        #105 rst_n <= 1;
    end

    initial begin
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, tb);
    end

    initial begin
        run_test();
    end
    initial begin
       uvm_config_db#(virtual riu_if#(cfg_riu_if))::set(null, "uvm_test_top.env.agt.drv", "vif", _if);
       uvm_config_db#(virtual riu_if#(cfg_riu_if))::set(null, "uvm_test_top.env.agt.mon", "vif", _if);
    end
endmodule
//}}}
