interface dut_harness ();
    my_if rx0_if (.clk(dut.clk), .rst_n(dut.rst_n), .data(dut.rxd), .valid(dut.rx_dv));
    my_if rx1_if (.clk(dut.clk), .rst_n(dut.rst_n), .data(dut.rxd), .valid(dut.rx_dv));
    my_if tx0_if (.clk(dut.clk), .rst_n(dut.rst_n), .data(dut.txd), .valid(dut.tx_en));
    function void set_vifs(string path);
        uvm_config_db#(virtual my_if)::set(null, {path,"*i_agt.drv"}, "vif", rx0_if);
        uvm_config_db#(virtual my_if)::set(null, {path,"*i_agt.mon"}, "vif", rx1_if);
        uvm_config_db#(virtual my_if)::set(null, {path,"*o_agt.mon"}, "vif", tx0_if);
    endfunction
endinterface

