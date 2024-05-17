```systemverilog
Harness example

module acc_cdma_harness(

     input aclk

    ,input aresetn

);

    initial begin

      `uvm_info("harness", " ============ acc_cdma_harness ============ ", UVM_NONE);

    end

    tlul_intf#(cfg_tlul_if) tlul_slv_if (

         .aclk      (aclk        )

        ,.aresetn   (aresetn     )

    );

    initial begin

        force tlul_slv_if.a_valid   = acc_dma_engine.a_valid   ;  

        force tlul_slv_if.a_data    = acc_dma_engine.a_data    ;  

        force acc_dma_engine.a_ready   = tlul_slv_if.a_ready   ;  

        force tlul_slv_if.d_ready   = 1'b1   ;  

    end

    function void connect_vifs(string env_path);

        uvm_config_db#(virtual tlul_intf#(cfg_tlul_if))::set(null, {env_path, $sformatf(".tlul_slv_agt_gp[%3d]*", axi4cdma_ds)}, "vif", tlul_slv_if);

        uvm_config_db#(bit)::set(null, {env_path, $sformatf(".tlul_slv_agt_gp[%3d]", axi4cdma_ds)}, "agt_active", UVM_ACTIVE);

    endfunction

endmodule

bind acc_dma_engine acc_cdma_harness u_harness (

     .aclk    (aclk    )

    ,.aresetn (aresetn )

);
```