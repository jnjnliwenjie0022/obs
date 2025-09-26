`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

`define MAX_LATENCY 4
`define RMAXLEN     8
`define WMAXLEN     8

// VPERL_BEGIN
// my $max_master_num = 31;
//:
// for (my $i=0; $i<=$max_master_num; $i++){
//:`ifdef ATCBMC300_MST${i}_SUPPORT
//: bind atcbmc300 jasper_amba_axi4_sv
//:   #(
//:      .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
//:      .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
//:                                        // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
//:                                        // 2: MONITOR:   PK provides assertions for master and slave outputs
//:                                        // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
//:      .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
//:      .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
//:      .CONFIG_LP                  (0),  // 1: Enable LP props
//:      .CONFIG_XPROP               (1),  // 0: Disable X propagation props
//:      .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
//:                                        // 1: Properties apply to valid byte lanes only
//:      .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
//:      .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
//:                                        // 0: Exclusive Accesses disabled; no exclusive access checks included
//:                                        // 1: Exclusive Accesses enabled;  exclusive access checks included
//:                                        // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
//:      .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
//:      .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
//:      .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
//:      .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
//:      .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
//:      .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
//:      .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
//:                                        // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
//:      .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
//:                                        // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
//:      .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
//:                                        // 1: Full read strobes only
//:      .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
//:                                        // 1: Full write strobes only
//:      .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
//:      .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
//:                                        // 0: CSR properties enabled with AXI properties (both constraints & assertions)
//:                                        // 1: CSR properties enabled with AXI constraints only
//:                                        // 2: Only CSR properties enabled.
//:      .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
//:                                        // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
//:                                        // 1:           Feed write data from buffer to CSR checker queue on W transaction
//:      .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
//:                                                           // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
//:      .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
//:                                                           // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
//:      .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
//:      .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
//:      .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
//:       // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
//:       // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
//:      .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
//:      .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
//:      .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
//:      .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
//:      .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
//:      .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
//:      .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
//:      .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
//:                                                           // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
//:      .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
//:                                                           // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
//:      .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
//:      .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
//:      .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
//:      .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
//:                                                           //    i.e. You cannot see the W transaction before the AW transaction.
//:      .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
//:      .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
//:      .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
//:   ) upstream${i}
//:   (
//:     .ACLK  	(aclk),  
//:     .ARESETn    (aresetn),    
//: 	.CSYSREQ    (1'b0),
//: 	.CSYSACK    (1'b0),
//: 	.CACTIVE    (1'b0),
//: 
//:     .AWID  	(us${i}_awid),      
//:     .AWADDR	(us${i}_awaddr),
//:     .AWREGION   (),
//:     .AWLEN   	(us${i}_awlen), 
//:     .AWSIZE    	(us${i}_awsize),       
//:     .AWBURST   	(us${i}_awburst), 
//:     .AWLOCK   	(us${i}_awlock), 
//:     .AWCACHE   	(us${i}_awcache),  
//:     .AWPROT   	(us${i}_awprot),
//:     .AWQOS	(4'b0),  
//:     .AWVALID	(us${i}_awvalid),
//:     .AWREADY	(us${i}_awready),
//:     .AWUSER	(32'b0),
//: 
//:     .WDATA	(us${i}_wdata),
//:     .WSTRB	(us${i}_wstrb),
//:     .WLAST	(us${i}_wlast),
//:     .WVALID	(us${i}_wvalid),
//:     .WREADY	(us${i}_wready),
//:     .WUSER	(32'b0),
//: 
//:     .BID	(us${i}_bid),
//:     .BRESP	(us${i}_bresp),
//:     .BVALID	(us${i}_bvalid),
//:     .BREADY	(us${i}_bready),
//:     .BUSER	(32'b0),
//: 
//:     .ARID	(us${i}_arid),
//:     .ARADDR	(us${i}_araddr),
//:     .ARREGION  (),
//:     .ARLEN	(us${i}_arlen),
//:     .ARSIZE	(us${i}_arsize),
//:     .ARBURST(us${i}_arburst),
//:     .ARLOCK	(us${i}_arlock),
//:     .ARCACHE(us${i}_arcache),
//:     .ARPROT	(us${i}_arprot),
//:     .ARQOS	(4'b0),
//:     .ARVALID	(us${i}_arvalid),
//:     .ARREADY	(us${i}_arready),
//:     .ARUSER	(32'b0),
//: 
//:     .RID	(us${i}_rid),
//:     .RDATA	(us${i}_rdata),
//:     .RRESP	(us${i}_rresp),
//:     .RLAST	(us${i}_rlast),
//:     .RVALID	(us${i}_rvalid),
//:     .RREADY	(us${i}_rready),
//:     .RUSER	(32'b0)
//:   );
//:`endif
// }
// my $max_j = 31;
//:
// for (my $j=1; $j<=$max_j; $j++){
//:`ifdef ATCBMC300_SLV${j}_SUPPORT
//:bind atcbmc300 jasper_amba_axi4_sv
//:  #(
//:     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
//:     .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
//:                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
//:                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
//:                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
//:     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
//:     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
//:     .CONFIG_LP                  (0),  // 1: Enable LP props
//:     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
//:     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
//:                                       // 1: Properties apply to valid byte lanes only
//:     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
//:     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
//:                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
//:                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
//:                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
//:     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
//:     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
//:     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
//:     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
//:     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
//:     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
//:     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
//:                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
//:     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
//:                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
//:     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
//:                                       // 1: Full read strobes only
//:     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
//:                                       // 1: Full write strobes only
//:     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
//:     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
//:                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
//:                                       // 1: CSR properties enabled with AXI constraints only
//:                                       // 2: Only CSR properties enabled.
//:     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
//:                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
//:                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
//:     .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
//:                                                           // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
//:     .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
//:                                                           // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
//:      .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
//:      .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
//:      .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
//:       // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
//:       // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
//:      .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
//:      .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
//:     .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
//:     .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
//:     .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
//:     .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
//:     .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
//:     .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
//:                                                           // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
//:     .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
//:                                                           // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
//:     .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
//:     .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
//:     .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
//:     .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
//:                                                           //    i.e. You cannot see the W transaction before the AW transaction.
//:     .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
//:     .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
//:     .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
//:  ) downstream${j}
//:  (
//:    .ACLK  	(aclk),  
//:    .ARESETn    (aresetn),    
//: 	.CSYSREQ    (1'b0),
//: 	.CSYSACK    (1'b0),
//: 	.CACTIVE    (1'b0),
//:
//:    .AWREGION   (4'b0),
//:    .AWID  		(ds${j}_awid),      
//:    .AWADDR		(ds${j}_awaddr),
//:    .AWLEN   	(ds${j}_awlen), 
//:    .AWSIZE    	(ds${j}_awsize),       
//:    .AWBURST   	(ds${j}_awburst), 
//:    .AWLOCK   	(ds${j}_awlock), 
//:    .AWCACHE   	(ds${j}_awcache),  
//:    .AWPROT   	(ds${j}_awprot),
//:    .AWQOS	(4'b0),  
//:    .AWVALID	(ds${j}_awvalid),
//:    .AWREADY	(ds${j}_awready),
//:    .AWUSER	(32'b0),
//:
//:    .WDATA	(ds${j}_wdata),
//:    .WSTRB	(ds${j}_wstrb),
//:    .WLAST	(ds${j}_wlast),
//:    .WVALID	(ds${j}_wvalid),
//:    .WREADY	(ds${j}_wready),
//:    .WUSER	(32'b0),
//:
//:    .BID	(ds${j}_bid),
//:    .BRESP	(ds${j}_bresp),
//:    .BVALID	(ds${j}_bvalid),
//:    .BREADY	(ds${j}_bready),
//:    .BUSER	(32'b0),
//:
//:    .ARREGION	(4'b0),
//:    .ARID	(ds${j}_arid),
//:    .ARADDR	(ds${j}_araddr),
//:    .ARLEN	(ds${j}_arlen),
//:    .ARSIZE	(ds${j}_arsize),
//:    .ARBURST	(ds${j}_arburst),
//:    .ARLOCK	(ds${j}_arlock),
//:    .ARCACHE	(ds${j}_arcache),
//:    .ARPROT	(ds${j}_arprot),
//:    .ARQOS	(4'b0),
//:    .ARVALID	(ds${j}_arvalid),
//:    .ARREADY	(ds${j}_arready),
//:    .ARUSER	(32'b0),
//:
//:    .RID	(ds${j}_rid),
//:    .RDATA	(ds${j}_rdata),
//:    .RRESP	(ds${j}_rresp),
//:    .RLAST	(ds${j}_rlast),
//:    .RVALID	(ds${j}_rvalid),
//:    .RREADY	(ds${j}_rready),
//:    .RUSER	(32'b0)
//:  );
//:`endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN

`ifdef ATCBMC300_MST0_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream0
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us0_awid),
    .AWADDR	(us0_awaddr),
    .AWREGION   (),
    .AWLEN   	(us0_awlen),
    .AWSIZE    	(us0_awsize),
    .AWBURST   	(us0_awburst),
    .AWLOCK   	(us0_awlock),
    .AWCACHE   	(us0_awcache),
    .AWPROT   	(us0_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us0_awvalid),
    .AWREADY	(us0_awready),
    .AWUSER	(32'b0),

    .WDATA	(us0_wdata),
    .WSTRB	(us0_wstrb),
    .WLAST	(us0_wlast),
    .WVALID	(us0_wvalid),
    .WREADY	(us0_wready),
    .WUSER	(32'b0),

    .BID	(us0_bid),
    .BRESP	(us0_bresp),
    .BVALID	(us0_bvalid),
    .BREADY	(us0_bready),
    .BUSER	(32'b0),

    .ARID	(us0_arid),
    .ARADDR	(us0_araddr),
    .ARREGION  (),
    .ARLEN	(us0_arlen),
    .ARSIZE	(us0_arsize),
    .ARBURST(us0_arburst),
    .ARLOCK	(us0_arlock),
    .ARCACHE(us0_arcache),
    .ARPROT	(us0_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us0_arvalid),
    .ARREADY	(us0_arready),
    .ARUSER	(32'b0),

    .RID	(us0_rid),
    .RDATA	(us0_rdata),
    .RRESP	(us0_rresp),
    .RLAST	(us0_rlast),
    .RVALID	(us0_rvalid),
    .RREADY	(us0_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST1_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream1
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us1_awid),
    .AWADDR	(us1_awaddr),
    .AWREGION   (),
    .AWLEN   	(us1_awlen),
    .AWSIZE    	(us1_awsize),
    .AWBURST   	(us1_awburst),
    .AWLOCK   	(us1_awlock),
    .AWCACHE   	(us1_awcache),
    .AWPROT   	(us1_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us1_awvalid),
    .AWREADY	(us1_awready),
    .AWUSER	(32'b0),

    .WDATA	(us1_wdata),
    .WSTRB	(us1_wstrb),
    .WLAST	(us1_wlast),
    .WVALID	(us1_wvalid),
    .WREADY	(us1_wready),
    .WUSER	(32'b0),

    .BID	(us1_bid),
    .BRESP	(us1_bresp),
    .BVALID	(us1_bvalid),
    .BREADY	(us1_bready),
    .BUSER	(32'b0),

    .ARID	(us1_arid),
    .ARADDR	(us1_araddr),
    .ARREGION  (),
    .ARLEN	(us1_arlen),
    .ARSIZE	(us1_arsize),
    .ARBURST(us1_arburst),
    .ARLOCK	(us1_arlock),
    .ARCACHE(us1_arcache),
    .ARPROT	(us1_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us1_arvalid),
    .ARREADY	(us1_arready),
    .ARUSER	(32'b0),

    .RID	(us1_rid),
    .RDATA	(us1_rdata),
    .RRESP	(us1_rresp),
    .RLAST	(us1_rlast),
    .RVALID	(us1_rvalid),
    .RREADY	(us1_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST2_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream2
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us2_awid),
    .AWADDR	(us2_awaddr),
    .AWREGION   (),
    .AWLEN   	(us2_awlen),
    .AWSIZE    	(us2_awsize),
    .AWBURST   	(us2_awburst),
    .AWLOCK   	(us2_awlock),
    .AWCACHE   	(us2_awcache),
    .AWPROT   	(us2_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us2_awvalid),
    .AWREADY	(us2_awready),
    .AWUSER	(32'b0),

    .WDATA	(us2_wdata),
    .WSTRB	(us2_wstrb),
    .WLAST	(us2_wlast),
    .WVALID	(us2_wvalid),
    .WREADY	(us2_wready),
    .WUSER	(32'b0),

    .BID	(us2_bid),
    .BRESP	(us2_bresp),
    .BVALID	(us2_bvalid),
    .BREADY	(us2_bready),
    .BUSER	(32'b0),

    .ARID	(us2_arid),
    .ARADDR	(us2_araddr),
    .ARREGION  (),
    .ARLEN	(us2_arlen),
    .ARSIZE	(us2_arsize),
    .ARBURST(us2_arburst),
    .ARLOCK	(us2_arlock),
    .ARCACHE(us2_arcache),
    .ARPROT	(us2_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us2_arvalid),
    .ARREADY	(us2_arready),
    .ARUSER	(32'b0),

    .RID	(us2_rid),
    .RDATA	(us2_rdata),
    .RRESP	(us2_rresp),
    .RLAST	(us2_rlast),
    .RVALID	(us2_rvalid),
    .RREADY	(us2_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST3_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream3
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us3_awid),
    .AWADDR	(us3_awaddr),
    .AWREGION   (),
    .AWLEN   	(us3_awlen),
    .AWSIZE    	(us3_awsize),
    .AWBURST   	(us3_awburst),
    .AWLOCK   	(us3_awlock),
    .AWCACHE   	(us3_awcache),
    .AWPROT   	(us3_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us3_awvalid),
    .AWREADY	(us3_awready),
    .AWUSER	(32'b0),

    .WDATA	(us3_wdata),
    .WSTRB	(us3_wstrb),
    .WLAST	(us3_wlast),
    .WVALID	(us3_wvalid),
    .WREADY	(us3_wready),
    .WUSER	(32'b0),

    .BID	(us3_bid),
    .BRESP	(us3_bresp),
    .BVALID	(us3_bvalid),
    .BREADY	(us3_bready),
    .BUSER	(32'b0),

    .ARID	(us3_arid),
    .ARADDR	(us3_araddr),
    .ARREGION  (),
    .ARLEN	(us3_arlen),
    .ARSIZE	(us3_arsize),
    .ARBURST(us3_arburst),
    .ARLOCK	(us3_arlock),
    .ARCACHE(us3_arcache),
    .ARPROT	(us3_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us3_arvalid),
    .ARREADY	(us3_arready),
    .ARUSER	(32'b0),

    .RID	(us3_rid),
    .RDATA	(us3_rdata),
    .RRESP	(us3_rresp),
    .RLAST	(us3_rlast),
    .RVALID	(us3_rvalid),
    .RREADY	(us3_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST4_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream4
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us4_awid),
    .AWADDR	(us4_awaddr),
    .AWREGION   (),
    .AWLEN   	(us4_awlen),
    .AWSIZE    	(us4_awsize),
    .AWBURST   	(us4_awburst),
    .AWLOCK   	(us4_awlock),
    .AWCACHE   	(us4_awcache),
    .AWPROT   	(us4_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us4_awvalid),
    .AWREADY	(us4_awready),
    .AWUSER	(32'b0),

    .WDATA	(us4_wdata),
    .WSTRB	(us4_wstrb),
    .WLAST	(us4_wlast),
    .WVALID	(us4_wvalid),
    .WREADY	(us4_wready),
    .WUSER	(32'b0),

    .BID	(us4_bid),
    .BRESP	(us4_bresp),
    .BVALID	(us4_bvalid),
    .BREADY	(us4_bready),
    .BUSER	(32'b0),

    .ARID	(us4_arid),
    .ARADDR	(us4_araddr),
    .ARREGION  (),
    .ARLEN	(us4_arlen),
    .ARSIZE	(us4_arsize),
    .ARBURST(us4_arburst),
    .ARLOCK	(us4_arlock),
    .ARCACHE(us4_arcache),
    .ARPROT	(us4_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us4_arvalid),
    .ARREADY	(us4_arready),
    .ARUSER	(32'b0),

    .RID	(us4_rid),
    .RDATA	(us4_rdata),
    .RRESP	(us4_rresp),
    .RLAST	(us4_rlast),
    .RVALID	(us4_rvalid),
    .RREADY	(us4_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST5_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream5
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us5_awid),
    .AWADDR	(us5_awaddr),
    .AWREGION   (),
    .AWLEN   	(us5_awlen),
    .AWSIZE    	(us5_awsize),
    .AWBURST   	(us5_awburst),
    .AWLOCK   	(us5_awlock),
    .AWCACHE   	(us5_awcache),
    .AWPROT   	(us5_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us5_awvalid),
    .AWREADY	(us5_awready),
    .AWUSER	(32'b0),

    .WDATA	(us5_wdata),
    .WSTRB	(us5_wstrb),
    .WLAST	(us5_wlast),
    .WVALID	(us5_wvalid),
    .WREADY	(us5_wready),
    .WUSER	(32'b0),

    .BID	(us5_bid),
    .BRESP	(us5_bresp),
    .BVALID	(us5_bvalid),
    .BREADY	(us5_bready),
    .BUSER	(32'b0),

    .ARID	(us5_arid),
    .ARADDR	(us5_araddr),
    .ARREGION  (),
    .ARLEN	(us5_arlen),
    .ARSIZE	(us5_arsize),
    .ARBURST(us5_arburst),
    .ARLOCK	(us5_arlock),
    .ARCACHE(us5_arcache),
    .ARPROT	(us5_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us5_arvalid),
    .ARREADY	(us5_arready),
    .ARUSER	(32'b0),

    .RID	(us5_rid),
    .RDATA	(us5_rdata),
    .RRESP	(us5_rresp),
    .RLAST	(us5_rlast),
    .RVALID	(us5_rvalid),
    .RREADY	(us5_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST6_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream6
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us6_awid),
    .AWADDR	(us6_awaddr),
    .AWREGION   (),
    .AWLEN   	(us6_awlen),
    .AWSIZE    	(us6_awsize),
    .AWBURST   	(us6_awburst),
    .AWLOCK   	(us6_awlock),
    .AWCACHE   	(us6_awcache),
    .AWPROT   	(us6_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us6_awvalid),
    .AWREADY	(us6_awready),
    .AWUSER	(32'b0),

    .WDATA	(us6_wdata),
    .WSTRB	(us6_wstrb),
    .WLAST	(us6_wlast),
    .WVALID	(us6_wvalid),
    .WREADY	(us6_wready),
    .WUSER	(32'b0),

    .BID	(us6_bid),
    .BRESP	(us6_bresp),
    .BVALID	(us6_bvalid),
    .BREADY	(us6_bready),
    .BUSER	(32'b0),

    .ARID	(us6_arid),
    .ARADDR	(us6_araddr),
    .ARREGION  (),
    .ARLEN	(us6_arlen),
    .ARSIZE	(us6_arsize),
    .ARBURST(us6_arburst),
    .ARLOCK	(us6_arlock),
    .ARCACHE(us6_arcache),
    .ARPROT	(us6_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us6_arvalid),
    .ARREADY	(us6_arready),
    .ARUSER	(32'b0),

    .RID	(us6_rid),
    .RDATA	(us6_rdata),
    .RRESP	(us6_rresp),
    .RLAST	(us6_rlast),
    .RVALID	(us6_rvalid),
    .RREADY	(us6_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST7_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream7
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us7_awid),
    .AWADDR	(us7_awaddr),
    .AWREGION   (),
    .AWLEN   	(us7_awlen),
    .AWSIZE    	(us7_awsize),
    .AWBURST   	(us7_awburst),
    .AWLOCK   	(us7_awlock),
    .AWCACHE   	(us7_awcache),
    .AWPROT   	(us7_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us7_awvalid),
    .AWREADY	(us7_awready),
    .AWUSER	(32'b0),

    .WDATA	(us7_wdata),
    .WSTRB	(us7_wstrb),
    .WLAST	(us7_wlast),
    .WVALID	(us7_wvalid),
    .WREADY	(us7_wready),
    .WUSER	(32'b0),

    .BID	(us7_bid),
    .BRESP	(us7_bresp),
    .BVALID	(us7_bvalid),
    .BREADY	(us7_bready),
    .BUSER	(32'b0),

    .ARID	(us7_arid),
    .ARADDR	(us7_araddr),
    .ARREGION  (),
    .ARLEN	(us7_arlen),
    .ARSIZE	(us7_arsize),
    .ARBURST(us7_arburst),
    .ARLOCK	(us7_arlock),
    .ARCACHE(us7_arcache),
    .ARPROT	(us7_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us7_arvalid),
    .ARREADY	(us7_arready),
    .ARUSER	(32'b0),

    .RID	(us7_rid),
    .RDATA	(us7_rdata),
    .RRESP	(us7_rresp),
    .RLAST	(us7_rlast),
    .RVALID	(us7_rvalid),
    .RREADY	(us7_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST8_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream8
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us8_awid),
    .AWADDR	(us8_awaddr),
    .AWREGION   (),
    .AWLEN   	(us8_awlen),
    .AWSIZE    	(us8_awsize),
    .AWBURST   	(us8_awburst),
    .AWLOCK   	(us8_awlock),
    .AWCACHE   	(us8_awcache),
    .AWPROT   	(us8_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us8_awvalid),
    .AWREADY	(us8_awready),
    .AWUSER	(32'b0),

    .WDATA	(us8_wdata),
    .WSTRB	(us8_wstrb),
    .WLAST	(us8_wlast),
    .WVALID	(us8_wvalid),
    .WREADY	(us8_wready),
    .WUSER	(32'b0),

    .BID	(us8_bid),
    .BRESP	(us8_bresp),
    .BVALID	(us8_bvalid),
    .BREADY	(us8_bready),
    .BUSER	(32'b0),

    .ARID	(us8_arid),
    .ARADDR	(us8_araddr),
    .ARREGION  (),
    .ARLEN	(us8_arlen),
    .ARSIZE	(us8_arsize),
    .ARBURST(us8_arburst),
    .ARLOCK	(us8_arlock),
    .ARCACHE(us8_arcache),
    .ARPROT	(us8_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us8_arvalid),
    .ARREADY	(us8_arready),
    .ARUSER	(32'b0),

    .RID	(us8_rid),
    .RDATA	(us8_rdata),
    .RRESP	(us8_rresp),
    .RLAST	(us8_rlast),
    .RVALID	(us8_rvalid),
    .RREADY	(us8_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST9_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream9
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us9_awid),
    .AWADDR	(us9_awaddr),
    .AWREGION   (),
    .AWLEN   	(us9_awlen),
    .AWSIZE    	(us9_awsize),
    .AWBURST   	(us9_awburst),
    .AWLOCK   	(us9_awlock),
    .AWCACHE   	(us9_awcache),
    .AWPROT   	(us9_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us9_awvalid),
    .AWREADY	(us9_awready),
    .AWUSER	(32'b0),

    .WDATA	(us9_wdata),
    .WSTRB	(us9_wstrb),
    .WLAST	(us9_wlast),
    .WVALID	(us9_wvalid),
    .WREADY	(us9_wready),
    .WUSER	(32'b0),

    .BID	(us9_bid),
    .BRESP	(us9_bresp),
    .BVALID	(us9_bvalid),
    .BREADY	(us9_bready),
    .BUSER	(32'b0),

    .ARID	(us9_arid),
    .ARADDR	(us9_araddr),
    .ARREGION  (),
    .ARLEN	(us9_arlen),
    .ARSIZE	(us9_arsize),
    .ARBURST(us9_arburst),
    .ARLOCK	(us9_arlock),
    .ARCACHE(us9_arcache),
    .ARPROT	(us9_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us9_arvalid),
    .ARREADY	(us9_arready),
    .ARUSER	(32'b0),

    .RID	(us9_rid),
    .RDATA	(us9_rdata),
    .RRESP	(us9_rresp),
    .RLAST	(us9_rlast),
    .RVALID	(us9_rvalid),
    .RREADY	(us9_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST10_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream10
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us10_awid),
    .AWADDR	(us10_awaddr),
    .AWREGION   (),
    .AWLEN   	(us10_awlen),
    .AWSIZE    	(us10_awsize),
    .AWBURST   	(us10_awburst),
    .AWLOCK   	(us10_awlock),
    .AWCACHE   	(us10_awcache),
    .AWPROT   	(us10_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us10_awvalid),
    .AWREADY	(us10_awready),
    .AWUSER	(32'b0),

    .WDATA	(us10_wdata),
    .WSTRB	(us10_wstrb),
    .WLAST	(us10_wlast),
    .WVALID	(us10_wvalid),
    .WREADY	(us10_wready),
    .WUSER	(32'b0),

    .BID	(us10_bid),
    .BRESP	(us10_bresp),
    .BVALID	(us10_bvalid),
    .BREADY	(us10_bready),
    .BUSER	(32'b0),

    .ARID	(us10_arid),
    .ARADDR	(us10_araddr),
    .ARREGION  (),
    .ARLEN	(us10_arlen),
    .ARSIZE	(us10_arsize),
    .ARBURST(us10_arburst),
    .ARLOCK	(us10_arlock),
    .ARCACHE(us10_arcache),
    .ARPROT	(us10_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us10_arvalid),
    .ARREADY	(us10_arready),
    .ARUSER	(32'b0),

    .RID	(us10_rid),
    .RDATA	(us10_rdata),
    .RRESP	(us10_rresp),
    .RLAST	(us10_rlast),
    .RVALID	(us10_rvalid),
    .RREADY	(us10_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST11_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream11
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us11_awid),
    .AWADDR	(us11_awaddr),
    .AWREGION   (),
    .AWLEN   	(us11_awlen),
    .AWSIZE    	(us11_awsize),
    .AWBURST   	(us11_awburst),
    .AWLOCK   	(us11_awlock),
    .AWCACHE   	(us11_awcache),
    .AWPROT   	(us11_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us11_awvalid),
    .AWREADY	(us11_awready),
    .AWUSER	(32'b0),

    .WDATA	(us11_wdata),
    .WSTRB	(us11_wstrb),
    .WLAST	(us11_wlast),
    .WVALID	(us11_wvalid),
    .WREADY	(us11_wready),
    .WUSER	(32'b0),

    .BID	(us11_bid),
    .BRESP	(us11_bresp),
    .BVALID	(us11_bvalid),
    .BREADY	(us11_bready),
    .BUSER	(32'b0),

    .ARID	(us11_arid),
    .ARADDR	(us11_araddr),
    .ARREGION  (),
    .ARLEN	(us11_arlen),
    .ARSIZE	(us11_arsize),
    .ARBURST(us11_arburst),
    .ARLOCK	(us11_arlock),
    .ARCACHE(us11_arcache),
    .ARPROT	(us11_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us11_arvalid),
    .ARREADY	(us11_arready),
    .ARUSER	(32'b0),

    .RID	(us11_rid),
    .RDATA	(us11_rdata),
    .RRESP	(us11_rresp),
    .RLAST	(us11_rlast),
    .RVALID	(us11_rvalid),
    .RREADY	(us11_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST12_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream12
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us12_awid),
    .AWADDR	(us12_awaddr),
    .AWREGION   (),
    .AWLEN   	(us12_awlen),
    .AWSIZE    	(us12_awsize),
    .AWBURST   	(us12_awburst),
    .AWLOCK   	(us12_awlock),
    .AWCACHE   	(us12_awcache),
    .AWPROT   	(us12_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us12_awvalid),
    .AWREADY	(us12_awready),
    .AWUSER	(32'b0),

    .WDATA	(us12_wdata),
    .WSTRB	(us12_wstrb),
    .WLAST	(us12_wlast),
    .WVALID	(us12_wvalid),
    .WREADY	(us12_wready),
    .WUSER	(32'b0),

    .BID	(us12_bid),
    .BRESP	(us12_bresp),
    .BVALID	(us12_bvalid),
    .BREADY	(us12_bready),
    .BUSER	(32'b0),

    .ARID	(us12_arid),
    .ARADDR	(us12_araddr),
    .ARREGION  (),
    .ARLEN	(us12_arlen),
    .ARSIZE	(us12_arsize),
    .ARBURST(us12_arburst),
    .ARLOCK	(us12_arlock),
    .ARCACHE(us12_arcache),
    .ARPROT	(us12_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us12_arvalid),
    .ARREADY	(us12_arready),
    .ARUSER	(32'b0),

    .RID	(us12_rid),
    .RDATA	(us12_rdata),
    .RRESP	(us12_rresp),
    .RLAST	(us12_rlast),
    .RVALID	(us12_rvalid),
    .RREADY	(us12_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST13_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream13
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us13_awid),
    .AWADDR	(us13_awaddr),
    .AWREGION   (),
    .AWLEN   	(us13_awlen),
    .AWSIZE    	(us13_awsize),
    .AWBURST   	(us13_awburst),
    .AWLOCK   	(us13_awlock),
    .AWCACHE   	(us13_awcache),
    .AWPROT   	(us13_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us13_awvalid),
    .AWREADY	(us13_awready),
    .AWUSER	(32'b0),

    .WDATA	(us13_wdata),
    .WSTRB	(us13_wstrb),
    .WLAST	(us13_wlast),
    .WVALID	(us13_wvalid),
    .WREADY	(us13_wready),
    .WUSER	(32'b0),

    .BID	(us13_bid),
    .BRESP	(us13_bresp),
    .BVALID	(us13_bvalid),
    .BREADY	(us13_bready),
    .BUSER	(32'b0),

    .ARID	(us13_arid),
    .ARADDR	(us13_araddr),
    .ARREGION  (),
    .ARLEN	(us13_arlen),
    .ARSIZE	(us13_arsize),
    .ARBURST(us13_arburst),
    .ARLOCK	(us13_arlock),
    .ARCACHE(us13_arcache),
    .ARPROT	(us13_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us13_arvalid),
    .ARREADY	(us13_arready),
    .ARUSER	(32'b0),

    .RID	(us13_rid),
    .RDATA	(us13_rdata),
    .RRESP	(us13_rresp),
    .RLAST	(us13_rlast),
    .RVALID	(us13_rvalid),
    .RREADY	(us13_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST14_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream14
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us14_awid),
    .AWADDR	(us14_awaddr),
    .AWREGION   (),
    .AWLEN   	(us14_awlen),
    .AWSIZE    	(us14_awsize),
    .AWBURST   	(us14_awburst),
    .AWLOCK   	(us14_awlock),
    .AWCACHE   	(us14_awcache),
    .AWPROT   	(us14_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us14_awvalid),
    .AWREADY	(us14_awready),
    .AWUSER	(32'b0),

    .WDATA	(us14_wdata),
    .WSTRB	(us14_wstrb),
    .WLAST	(us14_wlast),
    .WVALID	(us14_wvalid),
    .WREADY	(us14_wready),
    .WUSER	(32'b0),

    .BID	(us14_bid),
    .BRESP	(us14_bresp),
    .BVALID	(us14_bvalid),
    .BREADY	(us14_bready),
    .BUSER	(32'b0),

    .ARID	(us14_arid),
    .ARADDR	(us14_araddr),
    .ARREGION  (),
    .ARLEN	(us14_arlen),
    .ARSIZE	(us14_arsize),
    .ARBURST(us14_arburst),
    .ARLOCK	(us14_arlock),
    .ARCACHE(us14_arcache),
    .ARPROT	(us14_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us14_arvalid),
    .ARREADY	(us14_arready),
    .ARUSER	(32'b0),

    .RID	(us14_rid),
    .RDATA	(us14_rdata),
    .RRESP	(us14_rresp),
    .RLAST	(us14_rlast),
    .RVALID	(us14_rvalid),
    .RREADY	(us14_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST15_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream15
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us15_awid),
    .AWADDR	(us15_awaddr),
    .AWREGION   (),
    .AWLEN   	(us15_awlen),
    .AWSIZE    	(us15_awsize),
    .AWBURST   	(us15_awburst),
    .AWLOCK   	(us15_awlock),
    .AWCACHE   	(us15_awcache),
    .AWPROT   	(us15_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us15_awvalid),
    .AWREADY	(us15_awready),
    .AWUSER	(32'b0),

    .WDATA	(us15_wdata),
    .WSTRB	(us15_wstrb),
    .WLAST	(us15_wlast),
    .WVALID	(us15_wvalid),
    .WREADY	(us15_wready),
    .WUSER	(32'b0),

    .BID	(us15_bid),
    .BRESP	(us15_bresp),
    .BVALID	(us15_bvalid),
    .BREADY	(us15_bready),
    .BUSER	(32'b0),

    .ARID	(us15_arid),
    .ARADDR	(us15_araddr),
    .ARREGION  (),
    .ARLEN	(us15_arlen),
    .ARSIZE	(us15_arsize),
    .ARBURST(us15_arburst),
    .ARLOCK	(us15_arlock),
    .ARCACHE(us15_arcache),
    .ARPROT	(us15_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us15_arvalid),
    .ARREADY	(us15_arready),
    .ARUSER	(32'b0),

    .RID	(us15_rid),
    .RDATA	(us15_rdata),
    .RRESP	(us15_rresp),
    .RLAST	(us15_rlast),
    .RVALID	(us15_rvalid),
    .RREADY	(us15_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST16_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream16
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us16_awid),
    .AWADDR	(us16_awaddr),
    .AWREGION   (),
    .AWLEN   	(us16_awlen),
    .AWSIZE    	(us16_awsize),
    .AWBURST   	(us16_awburst),
    .AWLOCK   	(us16_awlock),
    .AWCACHE   	(us16_awcache),
    .AWPROT   	(us16_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us16_awvalid),
    .AWREADY	(us16_awready),
    .AWUSER	(32'b0),

    .WDATA	(us16_wdata),
    .WSTRB	(us16_wstrb),
    .WLAST	(us16_wlast),
    .WVALID	(us16_wvalid),
    .WREADY	(us16_wready),
    .WUSER	(32'b0),

    .BID	(us16_bid),
    .BRESP	(us16_bresp),
    .BVALID	(us16_bvalid),
    .BREADY	(us16_bready),
    .BUSER	(32'b0),

    .ARID	(us16_arid),
    .ARADDR	(us16_araddr),
    .ARREGION  (),
    .ARLEN	(us16_arlen),
    .ARSIZE	(us16_arsize),
    .ARBURST(us16_arburst),
    .ARLOCK	(us16_arlock),
    .ARCACHE(us16_arcache),
    .ARPROT	(us16_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us16_arvalid),
    .ARREADY	(us16_arready),
    .ARUSER	(32'b0),

    .RID	(us16_rid),
    .RDATA	(us16_rdata),
    .RRESP	(us16_rresp),
    .RLAST	(us16_rlast),
    .RVALID	(us16_rvalid),
    .RREADY	(us16_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST17_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream17
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us17_awid),
    .AWADDR	(us17_awaddr),
    .AWREGION   (),
    .AWLEN   	(us17_awlen),
    .AWSIZE    	(us17_awsize),
    .AWBURST   	(us17_awburst),
    .AWLOCK   	(us17_awlock),
    .AWCACHE   	(us17_awcache),
    .AWPROT   	(us17_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us17_awvalid),
    .AWREADY	(us17_awready),
    .AWUSER	(32'b0),

    .WDATA	(us17_wdata),
    .WSTRB	(us17_wstrb),
    .WLAST	(us17_wlast),
    .WVALID	(us17_wvalid),
    .WREADY	(us17_wready),
    .WUSER	(32'b0),

    .BID	(us17_bid),
    .BRESP	(us17_bresp),
    .BVALID	(us17_bvalid),
    .BREADY	(us17_bready),
    .BUSER	(32'b0),

    .ARID	(us17_arid),
    .ARADDR	(us17_araddr),
    .ARREGION  (),
    .ARLEN	(us17_arlen),
    .ARSIZE	(us17_arsize),
    .ARBURST(us17_arburst),
    .ARLOCK	(us17_arlock),
    .ARCACHE(us17_arcache),
    .ARPROT	(us17_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us17_arvalid),
    .ARREADY	(us17_arready),
    .ARUSER	(32'b0),

    .RID	(us17_rid),
    .RDATA	(us17_rdata),
    .RRESP	(us17_rresp),
    .RLAST	(us17_rlast),
    .RVALID	(us17_rvalid),
    .RREADY	(us17_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST18_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream18
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us18_awid),
    .AWADDR	(us18_awaddr),
    .AWREGION   (),
    .AWLEN   	(us18_awlen),
    .AWSIZE    	(us18_awsize),
    .AWBURST   	(us18_awburst),
    .AWLOCK   	(us18_awlock),
    .AWCACHE   	(us18_awcache),
    .AWPROT   	(us18_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us18_awvalid),
    .AWREADY	(us18_awready),
    .AWUSER	(32'b0),

    .WDATA	(us18_wdata),
    .WSTRB	(us18_wstrb),
    .WLAST	(us18_wlast),
    .WVALID	(us18_wvalid),
    .WREADY	(us18_wready),
    .WUSER	(32'b0),

    .BID	(us18_bid),
    .BRESP	(us18_bresp),
    .BVALID	(us18_bvalid),
    .BREADY	(us18_bready),
    .BUSER	(32'b0),

    .ARID	(us18_arid),
    .ARADDR	(us18_araddr),
    .ARREGION  (),
    .ARLEN	(us18_arlen),
    .ARSIZE	(us18_arsize),
    .ARBURST(us18_arburst),
    .ARLOCK	(us18_arlock),
    .ARCACHE(us18_arcache),
    .ARPROT	(us18_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us18_arvalid),
    .ARREADY	(us18_arready),
    .ARUSER	(32'b0),

    .RID	(us18_rid),
    .RDATA	(us18_rdata),
    .RRESP	(us18_rresp),
    .RLAST	(us18_rlast),
    .RVALID	(us18_rvalid),
    .RREADY	(us18_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST19_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream19
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us19_awid),
    .AWADDR	(us19_awaddr),
    .AWREGION   (),
    .AWLEN   	(us19_awlen),
    .AWSIZE    	(us19_awsize),
    .AWBURST   	(us19_awburst),
    .AWLOCK   	(us19_awlock),
    .AWCACHE   	(us19_awcache),
    .AWPROT   	(us19_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us19_awvalid),
    .AWREADY	(us19_awready),
    .AWUSER	(32'b0),

    .WDATA	(us19_wdata),
    .WSTRB	(us19_wstrb),
    .WLAST	(us19_wlast),
    .WVALID	(us19_wvalid),
    .WREADY	(us19_wready),
    .WUSER	(32'b0),

    .BID	(us19_bid),
    .BRESP	(us19_bresp),
    .BVALID	(us19_bvalid),
    .BREADY	(us19_bready),
    .BUSER	(32'b0),

    .ARID	(us19_arid),
    .ARADDR	(us19_araddr),
    .ARREGION  (),
    .ARLEN	(us19_arlen),
    .ARSIZE	(us19_arsize),
    .ARBURST(us19_arburst),
    .ARLOCK	(us19_arlock),
    .ARCACHE(us19_arcache),
    .ARPROT	(us19_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us19_arvalid),
    .ARREADY	(us19_arready),
    .ARUSER	(32'b0),

    .RID	(us19_rid),
    .RDATA	(us19_rdata),
    .RRESP	(us19_rresp),
    .RLAST	(us19_rlast),
    .RVALID	(us19_rvalid),
    .RREADY	(us19_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST20_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream20
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us20_awid),
    .AWADDR	(us20_awaddr),
    .AWREGION   (),
    .AWLEN   	(us20_awlen),
    .AWSIZE    	(us20_awsize),
    .AWBURST   	(us20_awburst),
    .AWLOCK   	(us20_awlock),
    .AWCACHE   	(us20_awcache),
    .AWPROT   	(us20_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us20_awvalid),
    .AWREADY	(us20_awready),
    .AWUSER	(32'b0),

    .WDATA	(us20_wdata),
    .WSTRB	(us20_wstrb),
    .WLAST	(us20_wlast),
    .WVALID	(us20_wvalid),
    .WREADY	(us20_wready),
    .WUSER	(32'b0),

    .BID	(us20_bid),
    .BRESP	(us20_bresp),
    .BVALID	(us20_bvalid),
    .BREADY	(us20_bready),
    .BUSER	(32'b0),

    .ARID	(us20_arid),
    .ARADDR	(us20_araddr),
    .ARREGION  (),
    .ARLEN	(us20_arlen),
    .ARSIZE	(us20_arsize),
    .ARBURST(us20_arburst),
    .ARLOCK	(us20_arlock),
    .ARCACHE(us20_arcache),
    .ARPROT	(us20_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us20_arvalid),
    .ARREADY	(us20_arready),
    .ARUSER	(32'b0),

    .RID	(us20_rid),
    .RDATA	(us20_rdata),
    .RRESP	(us20_rresp),
    .RLAST	(us20_rlast),
    .RVALID	(us20_rvalid),
    .RREADY	(us20_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST21_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream21
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us21_awid),
    .AWADDR	(us21_awaddr),
    .AWREGION   (),
    .AWLEN   	(us21_awlen),
    .AWSIZE    	(us21_awsize),
    .AWBURST   	(us21_awburst),
    .AWLOCK   	(us21_awlock),
    .AWCACHE   	(us21_awcache),
    .AWPROT   	(us21_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us21_awvalid),
    .AWREADY	(us21_awready),
    .AWUSER	(32'b0),

    .WDATA	(us21_wdata),
    .WSTRB	(us21_wstrb),
    .WLAST	(us21_wlast),
    .WVALID	(us21_wvalid),
    .WREADY	(us21_wready),
    .WUSER	(32'b0),

    .BID	(us21_bid),
    .BRESP	(us21_bresp),
    .BVALID	(us21_bvalid),
    .BREADY	(us21_bready),
    .BUSER	(32'b0),

    .ARID	(us21_arid),
    .ARADDR	(us21_araddr),
    .ARREGION  (),
    .ARLEN	(us21_arlen),
    .ARSIZE	(us21_arsize),
    .ARBURST(us21_arburst),
    .ARLOCK	(us21_arlock),
    .ARCACHE(us21_arcache),
    .ARPROT	(us21_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us21_arvalid),
    .ARREADY	(us21_arready),
    .ARUSER	(32'b0),

    .RID	(us21_rid),
    .RDATA	(us21_rdata),
    .RRESP	(us21_rresp),
    .RLAST	(us21_rlast),
    .RVALID	(us21_rvalid),
    .RREADY	(us21_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST22_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream22
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us22_awid),
    .AWADDR	(us22_awaddr),
    .AWREGION   (),
    .AWLEN   	(us22_awlen),
    .AWSIZE    	(us22_awsize),
    .AWBURST   	(us22_awburst),
    .AWLOCK   	(us22_awlock),
    .AWCACHE   	(us22_awcache),
    .AWPROT   	(us22_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us22_awvalid),
    .AWREADY	(us22_awready),
    .AWUSER	(32'b0),

    .WDATA	(us22_wdata),
    .WSTRB	(us22_wstrb),
    .WLAST	(us22_wlast),
    .WVALID	(us22_wvalid),
    .WREADY	(us22_wready),
    .WUSER	(32'b0),

    .BID	(us22_bid),
    .BRESP	(us22_bresp),
    .BVALID	(us22_bvalid),
    .BREADY	(us22_bready),
    .BUSER	(32'b0),

    .ARID	(us22_arid),
    .ARADDR	(us22_araddr),
    .ARREGION  (),
    .ARLEN	(us22_arlen),
    .ARSIZE	(us22_arsize),
    .ARBURST(us22_arburst),
    .ARLOCK	(us22_arlock),
    .ARCACHE(us22_arcache),
    .ARPROT	(us22_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us22_arvalid),
    .ARREADY	(us22_arready),
    .ARUSER	(32'b0),

    .RID	(us22_rid),
    .RDATA	(us22_rdata),
    .RRESP	(us22_rresp),
    .RLAST	(us22_rlast),
    .RVALID	(us22_rvalid),
    .RREADY	(us22_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST23_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream23
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us23_awid),
    .AWADDR	(us23_awaddr),
    .AWREGION   (),
    .AWLEN   	(us23_awlen),
    .AWSIZE    	(us23_awsize),
    .AWBURST   	(us23_awburst),
    .AWLOCK   	(us23_awlock),
    .AWCACHE   	(us23_awcache),
    .AWPROT   	(us23_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us23_awvalid),
    .AWREADY	(us23_awready),
    .AWUSER	(32'b0),

    .WDATA	(us23_wdata),
    .WSTRB	(us23_wstrb),
    .WLAST	(us23_wlast),
    .WVALID	(us23_wvalid),
    .WREADY	(us23_wready),
    .WUSER	(32'b0),

    .BID	(us23_bid),
    .BRESP	(us23_bresp),
    .BVALID	(us23_bvalid),
    .BREADY	(us23_bready),
    .BUSER	(32'b0),

    .ARID	(us23_arid),
    .ARADDR	(us23_araddr),
    .ARREGION  (),
    .ARLEN	(us23_arlen),
    .ARSIZE	(us23_arsize),
    .ARBURST(us23_arburst),
    .ARLOCK	(us23_arlock),
    .ARCACHE(us23_arcache),
    .ARPROT	(us23_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us23_arvalid),
    .ARREADY	(us23_arready),
    .ARUSER	(32'b0),

    .RID	(us23_rid),
    .RDATA	(us23_rdata),
    .RRESP	(us23_rresp),
    .RLAST	(us23_rlast),
    .RVALID	(us23_rvalid),
    .RREADY	(us23_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST24_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream24
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us24_awid),
    .AWADDR	(us24_awaddr),
    .AWREGION   (),
    .AWLEN   	(us24_awlen),
    .AWSIZE    	(us24_awsize),
    .AWBURST   	(us24_awburst),
    .AWLOCK   	(us24_awlock),
    .AWCACHE   	(us24_awcache),
    .AWPROT   	(us24_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us24_awvalid),
    .AWREADY	(us24_awready),
    .AWUSER	(32'b0),

    .WDATA	(us24_wdata),
    .WSTRB	(us24_wstrb),
    .WLAST	(us24_wlast),
    .WVALID	(us24_wvalid),
    .WREADY	(us24_wready),
    .WUSER	(32'b0),

    .BID	(us24_bid),
    .BRESP	(us24_bresp),
    .BVALID	(us24_bvalid),
    .BREADY	(us24_bready),
    .BUSER	(32'b0),

    .ARID	(us24_arid),
    .ARADDR	(us24_araddr),
    .ARREGION  (),
    .ARLEN	(us24_arlen),
    .ARSIZE	(us24_arsize),
    .ARBURST(us24_arburst),
    .ARLOCK	(us24_arlock),
    .ARCACHE(us24_arcache),
    .ARPROT	(us24_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us24_arvalid),
    .ARREADY	(us24_arready),
    .ARUSER	(32'b0),

    .RID	(us24_rid),
    .RDATA	(us24_rdata),
    .RRESP	(us24_rresp),
    .RLAST	(us24_rlast),
    .RVALID	(us24_rvalid),
    .RREADY	(us24_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST25_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream25
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us25_awid),
    .AWADDR	(us25_awaddr),
    .AWREGION   (),
    .AWLEN   	(us25_awlen),
    .AWSIZE    	(us25_awsize),
    .AWBURST   	(us25_awburst),
    .AWLOCK   	(us25_awlock),
    .AWCACHE   	(us25_awcache),
    .AWPROT   	(us25_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us25_awvalid),
    .AWREADY	(us25_awready),
    .AWUSER	(32'b0),

    .WDATA	(us25_wdata),
    .WSTRB	(us25_wstrb),
    .WLAST	(us25_wlast),
    .WVALID	(us25_wvalid),
    .WREADY	(us25_wready),
    .WUSER	(32'b0),

    .BID	(us25_bid),
    .BRESP	(us25_bresp),
    .BVALID	(us25_bvalid),
    .BREADY	(us25_bready),
    .BUSER	(32'b0),

    .ARID	(us25_arid),
    .ARADDR	(us25_araddr),
    .ARREGION  (),
    .ARLEN	(us25_arlen),
    .ARSIZE	(us25_arsize),
    .ARBURST(us25_arburst),
    .ARLOCK	(us25_arlock),
    .ARCACHE(us25_arcache),
    .ARPROT	(us25_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us25_arvalid),
    .ARREADY	(us25_arready),
    .ARUSER	(32'b0),

    .RID	(us25_rid),
    .RDATA	(us25_rdata),
    .RRESP	(us25_rresp),
    .RLAST	(us25_rlast),
    .RVALID	(us25_rvalid),
    .RREADY	(us25_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST26_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream26
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us26_awid),
    .AWADDR	(us26_awaddr),
    .AWREGION   (),
    .AWLEN   	(us26_awlen),
    .AWSIZE    	(us26_awsize),
    .AWBURST   	(us26_awburst),
    .AWLOCK   	(us26_awlock),
    .AWCACHE   	(us26_awcache),
    .AWPROT   	(us26_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us26_awvalid),
    .AWREADY	(us26_awready),
    .AWUSER	(32'b0),

    .WDATA	(us26_wdata),
    .WSTRB	(us26_wstrb),
    .WLAST	(us26_wlast),
    .WVALID	(us26_wvalid),
    .WREADY	(us26_wready),
    .WUSER	(32'b0),

    .BID	(us26_bid),
    .BRESP	(us26_bresp),
    .BVALID	(us26_bvalid),
    .BREADY	(us26_bready),
    .BUSER	(32'b0),

    .ARID	(us26_arid),
    .ARADDR	(us26_araddr),
    .ARREGION  (),
    .ARLEN	(us26_arlen),
    .ARSIZE	(us26_arsize),
    .ARBURST(us26_arburst),
    .ARLOCK	(us26_arlock),
    .ARCACHE(us26_arcache),
    .ARPROT	(us26_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us26_arvalid),
    .ARREADY	(us26_arready),
    .ARUSER	(32'b0),

    .RID	(us26_rid),
    .RDATA	(us26_rdata),
    .RRESP	(us26_rresp),
    .RLAST	(us26_rlast),
    .RVALID	(us26_rvalid),
    .RREADY	(us26_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST27_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream27
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us27_awid),
    .AWADDR	(us27_awaddr),
    .AWREGION   (),
    .AWLEN   	(us27_awlen),
    .AWSIZE    	(us27_awsize),
    .AWBURST   	(us27_awburst),
    .AWLOCK   	(us27_awlock),
    .AWCACHE   	(us27_awcache),
    .AWPROT   	(us27_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us27_awvalid),
    .AWREADY	(us27_awready),
    .AWUSER	(32'b0),

    .WDATA	(us27_wdata),
    .WSTRB	(us27_wstrb),
    .WLAST	(us27_wlast),
    .WVALID	(us27_wvalid),
    .WREADY	(us27_wready),
    .WUSER	(32'b0),

    .BID	(us27_bid),
    .BRESP	(us27_bresp),
    .BVALID	(us27_bvalid),
    .BREADY	(us27_bready),
    .BUSER	(32'b0),

    .ARID	(us27_arid),
    .ARADDR	(us27_araddr),
    .ARREGION  (),
    .ARLEN	(us27_arlen),
    .ARSIZE	(us27_arsize),
    .ARBURST(us27_arburst),
    .ARLOCK	(us27_arlock),
    .ARCACHE(us27_arcache),
    .ARPROT	(us27_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us27_arvalid),
    .ARREADY	(us27_arready),
    .ARUSER	(32'b0),

    .RID	(us27_rid),
    .RDATA	(us27_rdata),
    .RRESP	(us27_rresp),
    .RLAST	(us27_rlast),
    .RVALID	(us27_rvalid),
    .RREADY	(us27_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST28_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream28
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us28_awid),
    .AWADDR	(us28_awaddr),
    .AWREGION   (),
    .AWLEN   	(us28_awlen),
    .AWSIZE    	(us28_awsize),
    .AWBURST   	(us28_awburst),
    .AWLOCK   	(us28_awlock),
    .AWCACHE   	(us28_awcache),
    .AWPROT   	(us28_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us28_awvalid),
    .AWREADY	(us28_awready),
    .AWUSER	(32'b0),

    .WDATA	(us28_wdata),
    .WSTRB	(us28_wstrb),
    .WLAST	(us28_wlast),
    .WVALID	(us28_wvalid),
    .WREADY	(us28_wready),
    .WUSER	(32'b0),

    .BID	(us28_bid),
    .BRESP	(us28_bresp),
    .BVALID	(us28_bvalid),
    .BREADY	(us28_bready),
    .BUSER	(32'b0),

    .ARID	(us28_arid),
    .ARADDR	(us28_araddr),
    .ARREGION  (),
    .ARLEN	(us28_arlen),
    .ARSIZE	(us28_arsize),
    .ARBURST(us28_arburst),
    .ARLOCK	(us28_arlock),
    .ARCACHE(us28_arcache),
    .ARPROT	(us28_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us28_arvalid),
    .ARREADY	(us28_arready),
    .ARUSER	(32'b0),

    .RID	(us28_rid),
    .RDATA	(us28_rdata),
    .RRESP	(us28_rresp),
    .RLAST	(us28_rlast),
    .RVALID	(us28_rvalid),
    .RREADY	(us28_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST29_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream29
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us29_awid),
    .AWADDR	(us29_awaddr),
    .AWREGION   (),
    .AWLEN   	(us29_awlen),
    .AWSIZE    	(us29_awsize),
    .AWBURST   	(us29_awburst),
    .AWLOCK   	(us29_awlock),
    .AWCACHE   	(us29_awcache),
    .AWPROT   	(us29_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us29_awvalid),
    .AWREADY	(us29_awready),
    .AWUSER	(32'b0),

    .WDATA	(us29_wdata),
    .WSTRB	(us29_wstrb),
    .WLAST	(us29_wlast),
    .WVALID	(us29_wvalid),
    .WREADY	(us29_wready),
    .WUSER	(32'b0),

    .BID	(us29_bid),
    .BRESP	(us29_bresp),
    .BVALID	(us29_bvalid),
    .BREADY	(us29_bready),
    .BUSER	(32'b0),

    .ARID	(us29_arid),
    .ARADDR	(us29_araddr),
    .ARREGION  (),
    .ARLEN	(us29_arlen),
    .ARSIZE	(us29_arsize),
    .ARBURST(us29_arburst),
    .ARLOCK	(us29_arlock),
    .ARCACHE(us29_arcache),
    .ARPROT	(us29_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us29_arvalid),
    .ARREADY	(us29_arready),
    .ARUSER	(32'b0),

    .RID	(us29_rid),
    .RDATA	(us29_rdata),
    .RRESP	(us29_rresp),
    .RLAST	(us29_rlast),
    .RVALID	(us29_rvalid),
    .RREADY	(us29_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST30_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream30
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us30_awid),
    .AWADDR	(us30_awaddr),
    .AWREGION   (),
    .AWLEN   	(us30_awlen),
    .AWSIZE    	(us30_awsize),
    .AWBURST   	(us30_awburst),
    .AWLOCK   	(us30_awlock),
    .AWCACHE   	(us30_awcache),
    .AWPROT   	(us30_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us30_awvalid),
    .AWREADY	(us30_awready),
    .AWUSER	(32'b0),

    .WDATA	(us30_wdata),
    .WSTRB	(us30_wstrb),
    .WLAST	(us30_wlast),
    .WVALID	(us30_wvalid),
    .WREADY	(us30_wready),
    .WUSER	(32'b0),

    .BID	(us30_bid),
    .BRESP	(us30_bresp),
    .BVALID	(us30_bvalid),
    .BREADY	(us30_bready),
    .BUSER	(32'b0),

    .ARID	(us30_arid),
    .ARADDR	(us30_araddr),
    .ARREGION  (),
    .ARLEN	(us30_arlen),
    .ARSIZE	(us30_arsize),
    .ARBURST(us30_arburst),
    .ARLOCK	(us30_arlock),
    .ARCACHE(us30_arcache),
    .ARPROT	(us30_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us30_arvalid),
    .ARREADY	(us30_arready),
    .ARUSER	(32'b0),

    .RID	(us30_rid),
    .RDATA	(us30_rdata),
    .RRESP	(us30_rresp),
    .RLAST	(us30_rlast),
    .RVALID	(us30_rvalid),
    .RREADY	(us30_rready),
    .RUSER	(32'b0)
  );
`endif
`ifdef ATCBMC300_MST31_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
  #(
     .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                 (1),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                       // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                       // 2: MONITOR:   PK provides assertions for master and slave outputs
                                       // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
     .CONFIG_LP                  (0),  // 1: Enable LP props
     .CONFIG_XPROP               (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                       // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                       // 0: Exclusive Accesses disabled; no exclusive access checks included
                                       // 1: Exclusive Accesses enabled;  exclusive access checks included
                                       // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                       // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                       // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                       // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                       // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                       // 1: CSR properties enabled with AXI constraints only
                                       // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                       // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                       // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY                (`MAX_LATENCY),          // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
     .DYNAMIC_DATA_WDTH_EN       (0),                     // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                  (`ATCBMC300_DATA_WIDTH), // Data bus width
     .ADDR_WDTH                  (`ATCBMC300_ADDR_WIDTH), // Address bus width
     .ID_WDTH                    (`ATCBMC300_ID_WIDTH),   // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                 (`ATCBMC300_ID_WIDTH),   // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                 (`ATCBMC300_ID_WIDTH),   // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .AWUSER_WDTH                (1),                     // Width of the user AW sideband field
     .WUSER_WDTH                 (1),                     // Width of the user W  sideband field
     .BUSER_WDTH                 (1),                     // Width of the user B  sideband field
     .ARUSER_WDTH                (1),                     // Width of the user AR sideband field
     .RUSER_WDTH                 (1),                     // Width of the user R  sideband field
     .WMAXBURSTS                 (3),                     // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
     .RMAXBURSTS                 (3),                     // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
     .EXCL_DPTH                  (1),                     // Number of exclusive accesses to be monitored
     .RMAXLEN                    (`RMAXLEN),              // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
     .WMAXLEN                    (`WMAXLEN),              // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
     .CAUSALITY                  (1),                     // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER              (0),                     // 0: Inhibit out of order for read data
     .WP_OUTOFORDER              (0),                     // 0: Inhibit out of order for write response
     .RID_INTERLEAVE             (0)                      // 0: Disable read interleaving
  ) upstream31
  (
    .ACLK  	(aclk),
    .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

    .AWID  	(us31_awid),
    .AWADDR	(us31_awaddr),
    .AWREGION   (),
    .AWLEN   	(us31_awlen),
    .AWSIZE    	(us31_awsize),
    .AWBURST   	(us31_awburst),
    .AWLOCK   	(us31_awlock),
    .AWCACHE   	(us31_awcache),
    .AWPROT   	(us31_awprot),
    .AWQOS	(4'b0),
    .AWVALID	(us31_awvalid),
    .AWREADY	(us31_awready),
    .AWUSER	(32'b0),

    .WDATA	(us31_wdata),
    .WSTRB	(us31_wstrb),
    .WLAST	(us31_wlast),
    .WVALID	(us31_wvalid),
    .WREADY	(us31_wready),
    .WUSER	(32'b0),

    .BID	(us31_bid),
    .BRESP	(us31_bresp),
    .BVALID	(us31_bvalid),
    .BREADY	(us31_bready),
    .BUSER	(32'b0),

    .ARID	(us31_arid),
    .ARADDR	(us31_araddr),
    .ARREGION  (),
    .ARLEN	(us31_arlen),
    .ARSIZE	(us31_arsize),
    .ARBURST(us31_arburst),
    .ARLOCK	(us31_arlock),
    .ARCACHE(us31_arcache),
    .ARPROT	(us31_arprot),
    .ARQOS	(4'b0),
    .ARVALID	(us31_arvalid),
    .ARREADY	(us31_arready),
    .ARUSER	(32'b0),

    .RID	(us31_rid),
    .RDATA	(us31_rdata),
    .RRESP	(us31_rresp),
    .RLAST	(us31_rlast),
    .RVALID	(us31_rvalid),
    .RREADY	(us31_rready),
    .RUSER	(32'b0)
  );
`endif

`ifdef ATCBMC300_SLV1_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream1
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds1_awid),
   .AWADDR		(ds1_awaddr),
   .AWLEN   	(ds1_awlen),
   .AWSIZE    	(ds1_awsize),
   .AWBURST   	(ds1_awburst),
   .AWLOCK   	(ds1_awlock),
   .AWCACHE   	(ds1_awcache),
   .AWPROT   	(ds1_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds1_awvalid),
   .AWREADY	(ds1_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds1_wdata),
   .WSTRB	(ds1_wstrb),
   .WLAST	(ds1_wlast),
   .WVALID	(ds1_wvalid),
   .WREADY	(ds1_wready),
   .WUSER	(32'b0),

   .BID	(ds1_bid),
   .BRESP	(ds1_bresp),
   .BVALID	(ds1_bvalid),
   .BREADY	(ds1_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds1_arid),
   .ARADDR	(ds1_araddr),
   .ARLEN	(ds1_arlen),
   .ARSIZE	(ds1_arsize),
   .ARBURST	(ds1_arburst),
   .ARLOCK	(ds1_arlock),
   .ARCACHE	(ds1_arcache),
   .ARPROT	(ds1_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds1_arvalid),
   .ARREADY	(ds1_arready),
   .ARUSER	(32'b0),

   .RID	(ds1_rid),
   .RDATA	(ds1_rdata),
   .RRESP	(ds1_rresp),
   .RLAST	(ds1_rlast),
   .RVALID	(ds1_rvalid),
   .RREADY	(ds1_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream2
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds2_awid),
   .AWADDR		(ds2_awaddr),
   .AWLEN   	(ds2_awlen),
   .AWSIZE    	(ds2_awsize),
   .AWBURST   	(ds2_awburst),
   .AWLOCK   	(ds2_awlock),
   .AWCACHE   	(ds2_awcache),
   .AWPROT   	(ds2_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds2_awvalid),
   .AWREADY	(ds2_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds2_wdata),
   .WSTRB	(ds2_wstrb),
   .WLAST	(ds2_wlast),
   .WVALID	(ds2_wvalid),
   .WREADY	(ds2_wready),
   .WUSER	(32'b0),

   .BID	(ds2_bid),
   .BRESP	(ds2_bresp),
   .BVALID	(ds2_bvalid),
   .BREADY	(ds2_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds2_arid),
   .ARADDR	(ds2_araddr),
   .ARLEN	(ds2_arlen),
   .ARSIZE	(ds2_arsize),
   .ARBURST	(ds2_arburst),
   .ARLOCK	(ds2_arlock),
   .ARCACHE	(ds2_arcache),
   .ARPROT	(ds2_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds2_arvalid),
   .ARREADY	(ds2_arready),
   .ARUSER	(32'b0),

   .RID	(ds2_rid),
   .RDATA	(ds2_rdata),
   .RRESP	(ds2_rresp),
   .RLAST	(ds2_rlast),
   .RVALID	(ds2_rvalid),
   .RREADY	(ds2_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream3
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds3_awid),
   .AWADDR		(ds3_awaddr),
   .AWLEN   	(ds3_awlen),
   .AWSIZE    	(ds3_awsize),
   .AWBURST   	(ds3_awburst),
   .AWLOCK   	(ds3_awlock),
   .AWCACHE   	(ds3_awcache),
   .AWPROT   	(ds3_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds3_awvalid),
   .AWREADY	(ds3_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds3_wdata),
   .WSTRB	(ds3_wstrb),
   .WLAST	(ds3_wlast),
   .WVALID	(ds3_wvalid),
   .WREADY	(ds3_wready),
   .WUSER	(32'b0),

   .BID	(ds3_bid),
   .BRESP	(ds3_bresp),
   .BVALID	(ds3_bvalid),
   .BREADY	(ds3_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds3_arid),
   .ARADDR	(ds3_araddr),
   .ARLEN	(ds3_arlen),
   .ARSIZE	(ds3_arsize),
   .ARBURST	(ds3_arburst),
   .ARLOCK	(ds3_arlock),
   .ARCACHE	(ds3_arcache),
   .ARPROT	(ds3_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds3_arvalid),
   .ARREADY	(ds3_arready),
   .ARUSER	(32'b0),

   .RID	(ds3_rid),
   .RDATA	(ds3_rdata),
   .RRESP	(ds3_rresp),
   .RLAST	(ds3_rlast),
   .RVALID	(ds3_rvalid),
   .RREADY	(ds3_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream4
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds4_awid),
   .AWADDR		(ds4_awaddr),
   .AWLEN   	(ds4_awlen),
   .AWSIZE    	(ds4_awsize),
   .AWBURST   	(ds4_awburst),
   .AWLOCK   	(ds4_awlock),
   .AWCACHE   	(ds4_awcache),
   .AWPROT   	(ds4_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds4_awvalid),
   .AWREADY	(ds4_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds4_wdata),
   .WSTRB	(ds4_wstrb),
   .WLAST	(ds4_wlast),
   .WVALID	(ds4_wvalid),
   .WREADY	(ds4_wready),
   .WUSER	(32'b0),

   .BID	(ds4_bid),
   .BRESP	(ds4_bresp),
   .BVALID	(ds4_bvalid),
   .BREADY	(ds4_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds4_arid),
   .ARADDR	(ds4_araddr),
   .ARLEN	(ds4_arlen),
   .ARSIZE	(ds4_arsize),
   .ARBURST	(ds4_arburst),
   .ARLOCK	(ds4_arlock),
   .ARCACHE	(ds4_arcache),
   .ARPROT	(ds4_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds4_arvalid),
   .ARREADY	(ds4_arready),
   .ARUSER	(32'b0),

   .RID	(ds4_rid),
   .RDATA	(ds4_rdata),
   .RRESP	(ds4_rresp),
   .RLAST	(ds4_rlast),
   .RVALID	(ds4_rvalid),
   .RREADY	(ds4_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream5
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds5_awid),
   .AWADDR		(ds5_awaddr),
   .AWLEN   	(ds5_awlen),
   .AWSIZE    	(ds5_awsize),
   .AWBURST   	(ds5_awburst),
   .AWLOCK   	(ds5_awlock),
   .AWCACHE   	(ds5_awcache),
   .AWPROT   	(ds5_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds5_awvalid),
   .AWREADY	(ds5_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds5_wdata),
   .WSTRB	(ds5_wstrb),
   .WLAST	(ds5_wlast),
   .WVALID	(ds5_wvalid),
   .WREADY	(ds5_wready),
   .WUSER	(32'b0),

   .BID	(ds5_bid),
   .BRESP	(ds5_bresp),
   .BVALID	(ds5_bvalid),
   .BREADY	(ds5_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds5_arid),
   .ARADDR	(ds5_araddr),
   .ARLEN	(ds5_arlen),
   .ARSIZE	(ds5_arsize),
   .ARBURST	(ds5_arburst),
   .ARLOCK	(ds5_arlock),
   .ARCACHE	(ds5_arcache),
   .ARPROT	(ds5_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds5_arvalid),
   .ARREADY	(ds5_arready),
   .ARUSER	(32'b0),

   .RID	(ds5_rid),
   .RDATA	(ds5_rdata),
   .RRESP	(ds5_rresp),
   .RLAST	(ds5_rlast),
   .RVALID	(ds5_rvalid),
   .RREADY	(ds5_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream6
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds6_awid),
   .AWADDR		(ds6_awaddr),
   .AWLEN   	(ds6_awlen),
   .AWSIZE    	(ds6_awsize),
   .AWBURST   	(ds6_awburst),
   .AWLOCK   	(ds6_awlock),
   .AWCACHE   	(ds6_awcache),
   .AWPROT   	(ds6_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds6_awvalid),
   .AWREADY	(ds6_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds6_wdata),
   .WSTRB	(ds6_wstrb),
   .WLAST	(ds6_wlast),
   .WVALID	(ds6_wvalid),
   .WREADY	(ds6_wready),
   .WUSER	(32'b0),

   .BID	(ds6_bid),
   .BRESP	(ds6_bresp),
   .BVALID	(ds6_bvalid),
   .BREADY	(ds6_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds6_arid),
   .ARADDR	(ds6_araddr),
   .ARLEN	(ds6_arlen),
   .ARSIZE	(ds6_arsize),
   .ARBURST	(ds6_arburst),
   .ARLOCK	(ds6_arlock),
   .ARCACHE	(ds6_arcache),
   .ARPROT	(ds6_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds6_arvalid),
   .ARREADY	(ds6_arready),
   .ARUSER	(32'b0),

   .RID	(ds6_rid),
   .RDATA	(ds6_rdata),
   .RRESP	(ds6_rresp),
   .RLAST	(ds6_rlast),
   .RVALID	(ds6_rvalid),
   .RREADY	(ds6_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream7
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds7_awid),
   .AWADDR		(ds7_awaddr),
   .AWLEN   	(ds7_awlen),
   .AWSIZE    	(ds7_awsize),
   .AWBURST   	(ds7_awburst),
   .AWLOCK   	(ds7_awlock),
   .AWCACHE   	(ds7_awcache),
   .AWPROT   	(ds7_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds7_awvalid),
   .AWREADY	(ds7_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds7_wdata),
   .WSTRB	(ds7_wstrb),
   .WLAST	(ds7_wlast),
   .WVALID	(ds7_wvalid),
   .WREADY	(ds7_wready),
   .WUSER	(32'b0),

   .BID	(ds7_bid),
   .BRESP	(ds7_bresp),
   .BVALID	(ds7_bvalid),
   .BREADY	(ds7_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds7_arid),
   .ARADDR	(ds7_araddr),
   .ARLEN	(ds7_arlen),
   .ARSIZE	(ds7_arsize),
   .ARBURST	(ds7_arburst),
   .ARLOCK	(ds7_arlock),
   .ARCACHE	(ds7_arcache),
   .ARPROT	(ds7_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds7_arvalid),
   .ARREADY	(ds7_arready),
   .ARUSER	(32'b0),

   .RID	(ds7_rid),
   .RDATA	(ds7_rdata),
   .RRESP	(ds7_rresp),
   .RLAST	(ds7_rlast),
   .RVALID	(ds7_rvalid),
   .RREADY	(ds7_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream8
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds8_awid),
   .AWADDR		(ds8_awaddr),
   .AWLEN   	(ds8_awlen),
   .AWSIZE    	(ds8_awsize),
   .AWBURST   	(ds8_awburst),
   .AWLOCK   	(ds8_awlock),
   .AWCACHE   	(ds8_awcache),
   .AWPROT   	(ds8_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds8_awvalid),
   .AWREADY	(ds8_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds8_wdata),
   .WSTRB	(ds8_wstrb),
   .WLAST	(ds8_wlast),
   .WVALID	(ds8_wvalid),
   .WREADY	(ds8_wready),
   .WUSER	(32'b0),

   .BID	(ds8_bid),
   .BRESP	(ds8_bresp),
   .BVALID	(ds8_bvalid),
   .BREADY	(ds8_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds8_arid),
   .ARADDR	(ds8_araddr),
   .ARLEN	(ds8_arlen),
   .ARSIZE	(ds8_arsize),
   .ARBURST	(ds8_arburst),
   .ARLOCK	(ds8_arlock),
   .ARCACHE	(ds8_arcache),
   .ARPROT	(ds8_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds8_arvalid),
   .ARREADY	(ds8_arready),
   .ARUSER	(32'b0),

   .RID	(ds8_rid),
   .RDATA	(ds8_rdata),
   .RRESP	(ds8_rresp),
   .RLAST	(ds8_rlast),
   .RVALID	(ds8_rvalid),
   .RREADY	(ds8_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream9
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds9_awid),
   .AWADDR		(ds9_awaddr),
   .AWLEN   	(ds9_awlen),
   .AWSIZE    	(ds9_awsize),
   .AWBURST   	(ds9_awburst),
   .AWLOCK   	(ds9_awlock),
   .AWCACHE   	(ds9_awcache),
   .AWPROT   	(ds9_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds9_awvalid),
   .AWREADY	(ds9_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds9_wdata),
   .WSTRB	(ds9_wstrb),
   .WLAST	(ds9_wlast),
   .WVALID	(ds9_wvalid),
   .WREADY	(ds9_wready),
   .WUSER	(32'b0),

   .BID	(ds9_bid),
   .BRESP	(ds9_bresp),
   .BVALID	(ds9_bvalid),
   .BREADY	(ds9_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds9_arid),
   .ARADDR	(ds9_araddr),
   .ARLEN	(ds9_arlen),
   .ARSIZE	(ds9_arsize),
   .ARBURST	(ds9_arburst),
   .ARLOCK	(ds9_arlock),
   .ARCACHE	(ds9_arcache),
   .ARPROT	(ds9_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds9_arvalid),
   .ARREADY	(ds9_arready),
   .ARUSER	(32'b0),

   .RID	(ds9_rid),
   .RDATA	(ds9_rdata),
   .RRESP	(ds9_rresp),
   .RLAST	(ds9_rlast),
   .RVALID	(ds9_rvalid),
   .RREADY	(ds9_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream10
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds10_awid),
   .AWADDR		(ds10_awaddr),
   .AWLEN   	(ds10_awlen),
   .AWSIZE    	(ds10_awsize),
   .AWBURST   	(ds10_awburst),
   .AWLOCK   	(ds10_awlock),
   .AWCACHE   	(ds10_awcache),
   .AWPROT   	(ds10_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds10_awvalid),
   .AWREADY	(ds10_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds10_wdata),
   .WSTRB	(ds10_wstrb),
   .WLAST	(ds10_wlast),
   .WVALID	(ds10_wvalid),
   .WREADY	(ds10_wready),
   .WUSER	(32'b0),

   .BID	(ds10_bid),
   .BRESP	(ds10_bresp),
   .BVALID	(ds10_bvalid),
   .BREADY	(ds10_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds10_arid),
   .ARADDR	(ds10_araddr),
   .ARLEN	(ds10_arlen),
   .ARSIZE	(ds10_arsize),
   .ARBURST	(ds10_arburst),
   .ARLOCK	(ds10_arlock),
   .ARCACHE	(ds10_arcache),
   .ARPROT	(ds10_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds10_arvalid),
   .ARREADY	(ds10_arready),
   .ARUSER	(32'b0),

   .RID	(ds10_rid),
   .RDATA	(ds10_rdata),
   .RRESP	(ds10_rresp),
   .RLAST	(ds10_rlast),
   .RVALID	(ds10_rvalid),
   .RREADY	(ds10_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream11
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds11_awid),
   .AWADDR		(ds11_awaddr),
   .AWLEN   	(ds11_awlen),
   .AWSIZE    	(ds11_awsize),
   .AWBURST   	(ds11_awburst),
   .AWLOCK   	(ds11_awlock),
   .AWCACHE   	(ds11_awcache),
   .AWPROT   	(ds11_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds11_awvalid),
   .AWREADY	(ds11_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds11_wdata),
   .WSTRB	(ds11_wstrb),
   .WLAST	(ds11_wlast),
   .WVALID	(ds11_wvalid),
   .WREADY	(ds11_wready),
   .WUSER	(32'b0),

   .BID	(ds11_bid),
   .BRESP	(ds11_bresp),
   .BVALID	(ds11_bvalid),
   .BREADY	(ds11_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds11_arid),
   .ARADDR	(ds11_araddr),
   .ARLEN	(ds11_arlen),
   .ARSIZE	(ds11_arsize),
   .ARBURST	(ds11_arburst),
   .ARLOCK	(ds11_arlock),
   .ARCACHE	(ds11_arcache),
   .ARPROT	(ds11_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds11_arvalid),
   .ARREADY	(ds11_arready),
   .ARUSER	(32'b0),

   .RID	(ds11_rid),
   .RDATA	(ds11_rdata),
   .RRESP	(ds11_rresp),
   .RLAST	(ds11_rlast),
   .RVALID	(ds11_rvalid),
   .RREADY	(ds11_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream12
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds12_awid),
   .AWADDR		(ds12_awaddr),
   .AWLEN   	(ds12_awlen),
   .AWSIZE    	(ds12_awsize),
   .AWBURST   	(ds12_awburst),
   .AWLOCK   	(ds12_awlock),
   .AWCACHE   	(ds12_awcache),
   .AWPROT   	(ds12_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds12_awvalid),
   .AWREADY	(ds12_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds12_wdata),
   .WSTRB	(ds12_wstrb),
   .WLAST	(ds12_wlast),
   .WVALID	(ds12_wvalid),
   .WREADY	(ds12_wready),
   .WUSER	(32'b0),

   .BID	(ds12_bid),
   .BRESP	(ds12_bresp),
   .BVALID	(ds12_bvalid),
   .BREADY	(ds12_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds12_arid),
   .ARADDR	(ds12_araddr),
   .ARLEN	(ds12_arlen),
   .ARSIZE	(ds12_arsize),
   .ARBURST	(ds12_arburst),
   .ARLOCK	(ds12_arlock),
   .ARCACHE	(ds12_arcache),
   .ARPROT	(ds12_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds12_arvalid),
   .ARREADY	(ds12_arready),
   .ARUSER	(32'b0),

   .RID	(ds12_rid),
   .RDATA	(ds12_rdata),
   .RRESP	(ds12_rresp),
   .RLAST	(ds12_rlast),
   .RVALID	(ds12_rvalid),
   .RREADY	(ds12_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream13
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds13_awid),
   .AWADDR		(ds13_awaddr),
   .AWLEN   	(ds13_awlen),
   .AWSIZE    	(ds13_awsize),
   .AWBURST   	(ds13_awburst),
   .AWLOCK   	(ds13_awlock),
   .AWCACHE   	(ds13_awcache),
   .AWPROT   	(ds13_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds13_awvalid),
   .AWREADY	(ds13_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds13_wdata),
   .WSTRB	(ds13_wstrb),
   .WLAST	(ds13_wlast),
   .WVALID	(ds13_wvalid),
   .WREADY	(ds13_wready),
   .WUSER	(32'b0),

   .BID	(ds13_bid),
   .BRESP	(ds13_bresp),
   .BVALID	(ds13_bvalid),
   .BREADY	(ds13_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds13_arid),
   .ARADDR	(ds13_araddr),
   .ARLEN	(ds13_arlen),
   .ARSIZE	(ds13_arsize),
   .ARBURST	(ds13_arburst),
   .ARLOCK	(ds13_arlock),
   .ARCACHE	(ds13_arcache),
   .ARPROT	(ds13_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds13_arvalid),
   .ARREADY	(ds13_arready),
   .ARUSER	(32'b0),

   .RID	(ds13_rid),
   .RDATA	(ds13_rdata),
   .RRESP	(ds13_rresp),
   .RLAST	(ds13_rlast),
   .RVALID	(ds13_rvalid),
   .RREADY	(ds13_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream14
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds14_awid),
   .AWADDR		(ds14_awaddr),
   .AWLEN   	(ds14_awlen),
   .AWSIZE    	(ds14_awsize),
   .AWBURST   	(ds14_awburst),
   .AWLOCK   	(ds14_awlock),
   .AWCACHE   	(ds14_awcache),
   .AWPROT   	(ds14_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds14_awvalid),
   .AWREADY	(ds14_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds14_wdata),
   .WSTRB	(ds14_wstrb),
   .WLAST	(ds14_wlast),
   .WVALID	(ds14_wvalid),
   .WREADY	(ds14_wready),
   .WUSER	(32'b0),

   .BID	(ds14_bid),
   .BRESP	(ds14_bresp),
   .BVALID	(ds14_bvalid),
   .BREADY	(ds14_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds14_arid),
   .ARADDR	(ds14_araddr),
   .ARLEN	(ds14_arlen),
   .ARSIZE	(ds14_arsize),
   .ARBURST	(ds14_arburst),
   .ARLOCK	(ds14_arlock),
   .ARCACHE	(ds14_arcache),
   .ARPROT	(ds14_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds14_arvalid),
   .ARREADY	(ds14_arready),
   .ARUSER	(32'b0),

   .RID	(ds14_rid),
   .RDATA	(ds14_rdata),
   .RRESP	(ds14_rresp),
   .RLAST	(ds14_rlast),
   .RVALID	(ds14_rvalid),
   .RREADY	(ds14_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream15
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds15_awid),
   .AWADDR		(ds15_awaddr),
   .AWLEN   	(ds15_awlen),
   .AWSIZE    	(ds15_awsize),
   .AWBURST   	(ds15_awburst),
   .AWLOCK   	(ds15_awlock),
   .AWCACHE   	(ds15_awcache),
   .AWPROT   	(ds15_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds15_awvalid),
   .AWREADY	(ds15_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds15_wdata),
   .WSTRB	(ds15_wstrb),
   .WLAST	(ds15_wlast),
   .WVALID	(ds15_wvalid),
   .WREADY	(ds15_wready),
   .WUSER	(32'b0),

   .BID	(ds15_bid),
   .BRESP	(ds15_bresp),
   .BVALID	(ds15_bvalid),
   .BREADY	(ds15_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds15_arid),
   .ARADDR	(ds15_araddr),
   .ARLEN	(ds15_arlen),
   .ARSIZE	(ds15_arsize),
   .ARBURST	(ds15_arburst),
   .ARLOCK	(ds15_arlock),
   .ARCACHE	(ds15_arcache),
   .ARPROT	(ds15_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds15_arvalid),
   .ARREADY	(ds15_arready),
   .ARUSER	(32'b0),

   .RID	(ds15_rid),
   .RDATA	(ds15_rdata),
   .RRESP	(ds15_rresp),
   .RLAST	(ds15_rlast),
   .RVALID	(ds15_rvalid),
   .RREADY	(ds15_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream16
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds16_awid),
   .AWADDR		(ds16_awaddr),
   .AWLEN   	(ds16_awlen),
   .AWSIZE    	(ds16_awsize),
   .AWBURST   	(ds16_awburst),
   .AWLOCK   	(ds16_awlock),
   .AWCACHE   	(ds16_awcache),
   .AWPROT   	(ds16_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds16_awvalid),
   .AWREADY	(ds16_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds16_wdata),
   .WSTRB	(ds16_wstrb),
   .WLAST	(ds16_wlast),
   .WVALID	(ds16_wvalid),
   .WREADY	(ds16_wready),
   .WUSER	(32'b0),

   .BID	(ds16_bid),
   .BRESP	(ds16_bresp),
   .BVALID	(ds16_bvalid),
   .BREADY	(ds16_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds16_arid),
   .ARADDR	(ds16_araddr),
   .ARLEN	(ds16_arlen),
   .ARSIZE	(ds16_arsize),
   .ARBURST	(ds16_arburst),
   .ARLOCK	(ds16_arlock),
   .ARCACHE	(ds16_arcache),
   .ARPROT	(ds16_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds16_arvalid),
   .ARREADY	(ds16_arready),
   .ARUSER	(32'b0),

   .RID	(ds16_rid),
   .RDATA	(ds16_rdata),
   .RRESP	(ds16_rresp),
   .RLAST	(ds16_rlast),
   .RVALID	(ds16_rvalid),
   .RREADY	(ds16_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream17
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds17_awid),
   .AWADDR		(ds17_awaddr),
   .AWLEN   	(ds17_awlen),
   .AWSIZE    	(ds17_awsize),
   .AWBURST   	(ds17_awburst),
   .AWLOCK   	(ds17_awlock),
   .AWCACHE   	(ds17_awcache),
   .AWPROT   	(ds17_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds17_awvalid),
   .AWREADY	(ds17_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds17_wdata),
   .WSTRB	(ds17_wstrb),
   .WLAST	(ds17_wlast),
   .WVALID	(ds17_wvalid),
   .WREADY	(ds17_wready),
   .WUSER	(32'b0),

   .BID	(ds17_bid),
   .BRESP	(ds17_bresp),
   .BVALID	(ds17_bvalid),
   .BREADY	(ds17_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds17_arid),
   .ARADDR	(ds17_araddr),
   .ARLEN	(ds17_arlen),
   .ARSIZE	(ds17_arsize),
   .ARBURST	(ds17_arburst),
   .ARLOCK	(ds17_arlock),
   .ARCACHE	(ds17_arcache),
   .ARPROT	(ds17_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds17_arvalid),
   .ARREADY	(ds17_arready),
   .ARUSER	(32'b0),

   .RID	(ds17_rid),
   .RDATA	(ds17_rdata),
   .RRESP	(ds17_rresp),
   .RLAST	(ds17_rlast),
   .RVALID	(ds17_rvalid),
   .RREADY	(ds17_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream18
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds18_awid),
   .AWADDR		(ds18_awaddr),
   .AWLEN   	(ds18_awlen),
   .AWSIZE    	(ds18_awsize),
   .AWBURST   	(ds18_awburst),
   .AWLOCK   	(ds18_awlock),
   .AWCACHE   	(ds18_awcache),
   .AWPROT   	(ds18_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds18_awvalid),
   .AWREADY	(ds18_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds18_wdata),
   .WSTRB	(ds18_wstrb),
   .WLAST	(ds18_wlast),
   .WVALID	(ds18_wvalid),
   .WREADY	(ds18_wready),
   .WUSER	(32'b0),

   .BID	(ds18_bid),
   .BRESP	(ds18_bresp),
   .BVALID	(ds18_bvalid),
   .BREADY	(ds18_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds18_arid),
   .ARADDR	(ds18_araddr),
   .ARLEN	(ds18_arlen),
   .ARSIZE	(ds18_arsize),
   .ARBURST	(ds18_arburst),
   .ARLOCK	(ds18_arlock),
   .ARCACHE	(ds18_arcache),
   .ARPROT	(ds18_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds18_arvalid),
   .ARREADY	(ds18_arready),
   .ARUSER	(32'b0),

   .RID	(ds18_rid),
   .RDATA	(ds18_rdata),
   .RRESP	(ds18_rresp),
   .RLAST	(ds18_rlast),
   .RVALID	(ds18_rvalid),
   .RREADY	(ds18_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream19
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds19_awid),
   .AWADDR		(ds19_awaddr),
   .AWLEN   	(ds19_awlen),
   .AWSIZE    	(ds19_awsize),
   .AWBURST   	(ds19_awburst),
   .AWLOCK   	(ds19_awlock),
   .AWCACHE   	(ds19_awcache),
   .AWPROT   	(ds19_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds19_awvalid),
   .AWREADY	(ds19_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds19_wdata),
   .WSTRB	(ds19_wstrb),
   .WLAST	(ds19_wlast),
   .WVALID	(ds19_wvalid),
   .WREADY	(ds19_wready),
   .WUSER	(32'b0),

   .BID	(ds19_bid),
   .BRESP	(ds19_bresp),
   .BVALID	(ds19_bvalid),
   .BREADY	(ds19_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds19_arid),
   .ARADDR	(ds19_araddr),
   .ARLEN	(ds19_arlen),
   .ARSIZE	(ds19_arsize),
   .ARBURST	(ds19_arburst),
   .ARLOCK	(ds19_arlock),
   .ARCACHE	(ds19_arcache),
   .ARPROT	(ds19_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds19_arvalid),
   .ARREADY	(ds19_arready),
   .ARUSER	(32'b0),

   .RID	(ds19_rid),
   .RDATA	(ds19_rdata),
   .RRESP	(ds19_rresp),
   .RLAST	(ds19_rlast),
   .RVALID	(ds19_rvalid),
   .RREADY	(ds19_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream20
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds20_awid),
   .AWADDR		(ds20_awaddr),
   .AWLEN   	(ds20_awlen),
   .AWSIZE    	(ds20_awsize),
   .AWBURST   	(ds20_awburst),
   .AWLOCK   	(ds20_awlock),
   .AWCACHE   	(ds20_awcache),
   .AWPROT   	(ds20_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds20_awvalid),
   .AWREADY	(ds20_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds20_wdata),
   .WSTRB	(ds20_wstrb),
   .WLAST	(ds20_wlast),
   .WVALID	(ds20_wvalid),
   .WREADY	(ds20_wready),
   .WUSER	(32'b0),

   .BID	(ds20_bid),
   .BRESP	(ds20_bresp),
   .BVALID	(ds20_bvalid),
   .BREADY	(ds20_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds20_arid),
   .ARADDR	(ds20_araddr),
   .ARLEN	(ds20_arlen),
   .ARSIZE	(ds20_arsize),
   .ARBURST	(ds20_arburst),
   .ARLOCK	(ds20_arlock),
   .ARCACHE	(ds20_arcache),
   .ARPROT	(ds20_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds20_arvalid),
   .ARREADY	(ds20_arready),
   .ARUSER	(32'b0),

   .RID	(ds20_rid),
   .RDATA	(ds20_rdata),
   .RRESP	(ds20_rresp),
   .RLAST	(ds20_rlast),
   .RVALID	(ds20_rvalid),
   .RREADY	(ds20_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream21
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds21_awid),
   .AWADDR		(ds21_awaddr),
   .AWLEN   	(ds21_awlen),
   .AWSIZE    	(ds21_awsize),
   .AWBURST   	(ds21_awburst),
   .AWLOCK   	(ds21_awlock),
   .AWCACHE   	(ds21_awcache),
   .AWPROT   	(ds21_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds21_awvalid),
   .AWREADY	(ds21_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds21_wdata),
   .WSTRB	(ds21_wstrb),
   .WLAST	(ds21_wlast),
   .WVALID	(ds21_wvalid),
   .WREADY	(ds21_wready),
   .WUSER	(32'b0),

   .BID	(ds21_bid),
   .BRESP	(ds21_bresp),
   .BVALID	(ds21_bvalid),
   .BREADY	(ds21_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds21_arid),
   .ARADDR	(ds21_araddr),
   .ARLEN	(ds21_arlen),
   .ARSIZE	(ds21_arsize),
   .ARBURST	(ds21_arburst),
   .ARLOCK	(ds21_arlock),
   .ARCACHE	(ds21_arcache),
   .ARPROT	(ds21_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds21_arvalid),
   .ARREADY	(ds21_arready),
   .ARUSER	(32'b0),

   .RID	(ds21_rid),
   .RDATA	(ds21_rdata),
   .RRESP	(ds21_rresp),
   .RLAST	(ds21_rlast),
   .RVALID	(ds21_rvalid),
   .RREADY	(ds21_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream22
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds22_awid),
   .AWADDR		(ds22_awaddr),
   .AWLEN   	(ds22_awlen),
   .AWSIZE    	(ds22_awsize),
   .AWBURST   	(ds22_awburst),
   .AWLOCK   	(ds22_awlock),
   .AWCACHE   	(ds22_awcache),
   .AWPROT   	(ds22_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds22_awvalid),
   .AWREADY	(ds22_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds22_wdata),
   .WSTRB	(ds22_wstrb),
   .WLAST	(ds22_wlast),
   .WVALID	(ds22_wvalid),
   .WREADY	(ds22_wready),
   .WUSER	(32'b0),

   .BID	(ds22_bid),
   .BRESP	(ds22_bresp),
   .BVALID	(ds22_bvalid),
   .BREADY	(ds22_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds22_arid),
   .ARADDR	(ds22_araddr),
   .ARLEN	(ds22_arlen),
   .ARSIZE	(ds22_arsize),
   .ARBURST	(ds22_arburst),
   .ARLOCK	(ds22_arlock),
   .ARCACHE	(ds22_arcache),
   .ARPROT	(ds22_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds22_arvalid),
   .ARREADY	(ds22_arready),
   .ARUSER	(32'b0),

   .RID	(ds22_rid),
   .RDATA	(ds22_rdata),
   .RRESP	(ds22_rresp),
   .RLAST	(ds22_rlast),
   .RVALID	(ds22_rvalid),
   .RREADY	(ds22_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream23
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds23_awid),
   .AWADDR		(ds23_awaddr),
   .AWLEN   	(ds23_awlen),
   .AWSIZE    	(ds23_awsize),
   .AWBURST   	(ds23_awburst),
   .AWLOCK   	(ds23_awlock),
   .AWCACHE   	(ds23_awcache),
   .AWPROT   	(ds23_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds23_awvalid),
   .AWREADY	(ds23_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds23_wdata),
   .WSTRB	(ds23_wstrb),
   .WLAST	(ds23_wlast),
   .WVALID	(ds23_wvalid),
   .WREADY	(ds23_wready),
   .WUSER	(32'b0),

   .BID	(ds23_bid),
   .BRESP	(ds23_bresp),
   .BVALID	(ds23_bvalid),
   .BREADY	(ds23_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds23_arid),
   .ARADDR	(ds23_araddr),
   .ARLEN	(ds23_arlen),
   .ARSIZE	(ds23_arsize),
   .ARBURST	(ds23_arburst),
   .ARLOCK	(ds23_arlock),
   .ARCACHE	(ds23_arcache),
   .ARPROT	(ds23_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds23_arvalid),
   .ARREADY	(ds23_arready),
   .ARUSER	(32'b0),

   .RID	(ds23_rid),
   .RDATA	(ds23_rdata),
   .RRESP	(ds23_rresp),
   .RLAST	(ds23_rlast),
   .RVALID	(ds23_rvalid),
   .RREADY	(ds23_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream24
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds24_awid),
   .AWADDR		(ds24_awaddr),
   .AWLEN   	(ds24_awlen),
   .AWSIZE    	(ds24_awsize),
   .AWBURST   	(ds24_awburst),
   .AWLOCK   	(ds24_awlock),
   .AWCACHE   	(ds24_awcache),
   .AWPROT   	(ds24_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds24_awvalid),
   .AWREADY	(ds24_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds24_wdata),
   .WSTRB	(ds24_wstrb),
   .WLAST	(ds24_wlast),
   .WVALID	(ds24_wvalid),
   .WREADY	(ds24_wready),
   .WUSER	(32'b0),

   .BID	(ds24_bid),
   .BRESP	(ds24_bresp),
   .BVALID	(ds24_bvalid),
   .BREADY	(ds24_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds24_arid),
   .ARADDR	(ds24_araddr),
   .ARLEN	(ds24_arlen),
   .ARSIZE	(ds24_arsize),
   .ARBURST	(ds24_arburst),
   .ARLOCK	(ds24_arlock),
   .ARCACHE	(ds24_arcache),
   .ARPROT	(ds24_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds24_arvalid),
   .ARREADY	(ds24_arready),
   .ARUSER	(32'b0),

   .RID	(ds24_rid),
   .RDATA	(ds24_rdata),
   .RRESP	(ds24_rresp),
   .RLAST	(ds24_rlast),
   .RVALID	(ds24_rvalid),
   .RREADY	(ds24_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream25
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds25_awid),
   .AWADDR		(ds25_awaddr),
   .AWLEN   	(ds25_awlen),
   .AWSIZE    	(ds25_awsize),
   .AWBURST   	(ds25_awburst),
   .AWLOCK   	(ds25_awlock),
   .AWCACHE   	(ds25_awcache),
   .AWPROT   	(ds25_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds25_awvalid),
   .AWREADY	(ds25_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds25_wdata),
   .WSTRB	(ds25_wstrb),
   .WLAST	(ds25_wlast),
   .WVALID	(ds25_wvalid),
   .WREADY	(ds25_wready),
   .WUSER	(32'b0),

   .BID	(ds25_bid),
   .BRESP	(ds25_bresp),
   .BVALID	(ds25_bvalid),
   .BREADY	(ds25_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds25_arid),
   .ARADDR	(ds25_araddr),
   .ARLEN	(ds25_arlen),
   .ARSIZE	(ds25_arsize),
   .ARBURST	(ds25_arburst),
   .ARLOCK	(ds25_arlock),
   .ARCACHE	(ds25_arcache),
   .ARPROT	(ds25_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds25_arvalid),
   .ARREADY	(ds25_arready),
   .ARUSER	(32'b0),

   .RID	(ds25_rid),
   .RDATA	(ds25_rdata),
   .RRESP	(ds25_rresp),
   .RLAST	(ds25_rlast),
   .RVALID	(ds25_rvalid),
   .RREADY	(ds25_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream26
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds26_awid),
   .AWADDR		(ds26_awaddr),
   .AWLEN   	(ds26_awlen),
   .AWSIZE    	(ds26_awsize),
   .AWBURST   	(ds26_awburst),
   .AWLOCK   	(ds26_awlock),
   .AWCACHE   	(ds26_awcache),
   .AWPROT   	(ds26_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds26_awvalid),
   .AWREADY	(ds26_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds26_wdata),
   .WSTRB	(ds26_wstrb),
   .WLAST	(ds26_wlast),
   .WVALID	(ds26_wvalid),
   .WREADY	(ds26_wready),
   .WUSER	(32'b0),

   .BID	(ds26_bid),
   .BRESP	(ds26_bresp),
   .BVALID	(ds26_bvalid),
   .BREADY	(ds26_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds26_arid),
   .ARADDR	(ds26_araddr),
   .ARLEN	(ds26_arlen),
   .ARSIZE	(ds26_arsize),
   .ARBURST	(ds26_arburst),
   .ARLOCK	(ds26_arlock),
   .ARCACHE	(ds26_arcache),
   .ARPROT	(ds26_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds26_arvalid),
   .ARREADY	(ds26_arready),
   .ARUSER	(32'b0),

   .RID	(ds26_rid),
   .RDATA	(ds26_rdata),
   .RRESP	(ds26_rresp),
   .RLAST	(ds26_rlast),
   .RVALID	(ds26_rvalid),
   .RREADY	(ds26_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream27
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds27_awid),
   .AWADDR		(ds27_awaddr),
   .AWLEN   	(ds27_awlen),
   .AWSIZE    	(ds27_awsize),
   .AWBURST   	(ds27_awburst),
   .AWLOCK   	(ds27_awlock),
   .AWCACHE   	(ds27_awcache),
   .AWPROT   	(ds27_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds27_awvalid),
   .AWREADY	(ds27_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds27_wdata),
   .WSTRB	(ds27_wstrb),
   .WLAST	(ds27_wlast),
   .WVALID	(ds27_wvalid),
   .WREADY	(ds27_wready),
   .WUSER	(32'b0),

   .BID	(ds27_bid),
   .BRESP	(ds27_bresp),
   .BVALID	(ds27_bvalid),
   .BREADY	(ds27_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds27_arid),
   .ARADDR	(ds27_araddr),
   .ARLEN	(ds27_arlen),
   .ARSIZE	(ds27_arsize),
   .ARBURST	(ds27_arburst),
   .ARLOCK	(ds27_arlock),
   .ARCACHE	(ds27_arcache),
   .ARPROT	(ds27_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds27_arvalid),
   .ARREADY	(ds27_arready),
   .ARUSER	(32'b0),

   .RID	(ds27_rid),
   .RDATA	(ds27_rdata),
   .RRESP	(ds27_rresp),
   .RLAST	(ds27_rlast),
   .RVALID	(ds27_rvalid),
   .RREADY	(ds27_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream28
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds28_awid),
   .AWADDR		(ds28_awaddr),
   .AWLEN   	(ds28_awlen),
   .AWSIZE    	(ds28_awsize),
   .AWBURST   	(ds28_awburst),
   .AWLOCK   	(ds28_awlock),
   .AWCACHE   	(ds28_awcache),
   .AWPROT   	(ds28_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds28_awvalid),
   .AWREADY	(ds28_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds28_wdata),
   .WSTRB	(ds28_wstrb),
   .WLAST	(ds28_wlast),
   .WVALID	(ds28_wvalid),
   .WREADY	(ds28_wready),
   .WUSER	(32'b0),

   .BID	(ds28_bid),
   .BRESP	(ds28_bresp),
   .BVALID	(ds28_bvalid),
   .BREADY	(ds28_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds28_arid),
   .ARADDR	(ds28_araddr),
   .ARLEN	(ds28_arlen),
   .ARSIZE	(ds28_arsize),
   .ARBURST	(ds28_arburst),
   .ARLOCK	(ds28_arlock),
   .ARCACHE	(ds28_arcache),
   .ARPROT	(ds28_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds28_arvalid),
   .ARREADY	(ds28_arready),
   .ARUSER	(32'b0),

   .RID	(ds28_rid),
   .RDATA	(ds28_rdata),
   .RRESP	(ds28_rresp),
   .RLAST	(ds28_rlast),
   .RVALID	(ds28_rvalid),
   .RREADY	(ds28_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream29
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds29_awid),
   .AWADDR		(ds29_awaddr),
   .AWLEN   	(ds29_awlen),
   .AWSIZE    	(ds29_awsize),
   .AWBURST   	(ds29_awburst),
   .AWLOCK   	(ds29_awlock),
   .AWCACHE   	(ds29_awcache),
   .AWPROT   	(ds29_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds29_awvalid),
   .AWREADY	(ds29_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds29_wdata),
   .WSTRB	(ds29_wstrb),
   .WLAST	(ds29_wlast),
   .WVALID	(ds29_wvalid),
   .WREADY	(ds29_wready),
   .WUSER	(32'b0),

   .BID	(ds29_bid),
   .BRESP	(ds29_bresp),
   .BVALID	(ds29_bvalid),
   .BREADY	(ds29_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds29_arid),
   .ARADDR	(ds29_araddr),
   .ARLEN	(ds29_arlen),
   .ARSIZE	(ds29_arsize),
   .ARBURST	(ds29_arburst),
   .ARLOCK	(ds29_arlock),
   .ARCACHE	(ds29_arcache),
   .ARPROT	(ds29_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds29_arvalid),
   .ARREADY	(ds29_arready),
   .ARUSER	(32'b0),

   .RID	(ds29_rid),
   .RDATA	(ds29_rdata),
   .RRESP	(ds29_rresp),
   .RLAST	(ds29_rlast),
   .RVALID	(ds29_rvalid),
   .RREADY	(ds29_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream30
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds30_awid),
   .AWADDR		(ds30_awaddr),
   .AWLEN   	(ds30_awlen),
   .AWSIZE    	(ds30_awsize),
   .AWBURST   	(ds30_awburst),
   .AWLOCK   	(ds30_awlock),
   .AWCACHE   	(ds30_awcache),
   .AWPROT   	(ds30_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds30_awvalid),
   .AWREADY	(ds30_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds30_wdata),
   .WSTRB	(ds30_wstrb),
   .WLAST	(ds30_wlast),
   .WVALID	(ds30_wvalid),
   .WREADY	(ds30_wready),
   .WUSER	(32'b0),

   .BID	(ds30_bid),
   .BRESP	(ds30_bresp),
   .BVALID	(ds30_bvalid),
   .BREADY	(ds30_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds30_arid),
   .ARADDR	(ds30_araddr),
   .ARLEN	(ds30_arlen),
   .ARSIZE	(ds30_arsize),
   .ARBURST	(ds30_arburst),
   .ARLOCK	(ds30_arlock),
   .ARCACHE	(ds30_arcache),
   .ARPROT	(ds30_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds30_arvalid),
   .ARREADY	(ds30_arready),
   .ARUSER	(32'b0),

   .RID	(ds30_rid),
   .RDATA	(ds30_rdata),
   .RRESP	(ds30_rresp),
   .RLAST	(ds30_rlast),
   .RVALID	(ds30_rvalid),
   .RREADY	(ds30_rready),
   .RUSER	(32'b0)
 );
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
bind atcbmc300 jasper_amba_axi4_sv
 #(
    .AXI4_LITE                  (0),  // 1: Enable PK to work as AXI4-Lite checker
    .VERIFY_BLK                 (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
    .VERIFY_PK                  (0),  // 1: Enable Verifying PK correctness assertions
    .CONFIG_PARAMS              (1),  // 0: Disable PK parameter checks
    .CONFIG_LP                  (0),  // 1: Enable LP props
    .CONFIG_XPROP               (1),  // 0: Disable X propagation props
    .CONFIG_RDATA_masked        (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
                                      // 1: Properties apply to valid byte lanes only
    .CONFIG_DEAD                (1),  // 0: Disable potential deadlock checking
    .CONFIG_EXCL                (2),  // Config Props for Exclusive Access
                                      // 0: Exclusive Accesses disabled; no exclusive access checks included
                                      // 1: Exclusive Accesses enabled;  exclusive access checks included
                                      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
    .CONFIG_EXCL_RCMND          (1),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_EXCL_RCMND_RRARAW   (1),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
    .CONFIG_WSTRB_CHK           (1),  // 0: Disable WSTRB value checking
    .CONFIG_STABLE_CHK          (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
    .CONFIG_RESET_CHK           (1),  // 0: Disable VALID signal reset value properties; 1: enable
    .CONFIG_SIMULATION          (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
    .CONFIG_RD_ONLY             (0),  // 1: Exclude all properties that are not for read accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
    .CONFIG_WR_ONLY             (0),  // 1: Exclude all properties that are not for write accesses
                                      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
    .CONFIG_RD_FULL_STRB        (0),  // 0: (default) Full read strobe not required
                                      // 1: Full read strobes only
    .CONFIG_WR_FULL_STRB        (0),  // 0: (default) Full write strobe not required
                                      // 1: Full write strobes only
    .CONFIG_CSR_INTERFACE       (0),  // 1: Proof kit instantiated with CSR Proof Accelerator
    .CONFIG_CSR_MODE            (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
                                      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
                                      // 1: CSR properties enabled with AXI constraints only
                                      // 2: Only CSR properties enabled.
    .CONFIG_CSR_FEED_EARLY_W    (0),  // Tune internal CSR logic behavior
                                      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
                                      // 1:           Feed write data from buffer to CSR checker queue on W transaction
    .MAX_LATENCY                (`MAX_LATENCY),           // maximum latency (cycles) from (VALID & !READY) to READY; minumum value: 1;
                                                          // to get the effect of MAX_LATENCY=0, set CONFIG_DEAD=0 (which removes the associated properties)
    .DYNAMIC_DATA_WDTH_EN       (0),                      // Allow data widths to change dynamically; effectively, setting this parameter enables the associated inputs.
                                                          // NOTE: this parameter is only active when (CONFIG_SIMULATION == 1)
     .DATA_WDTH                 (`ATCBMC300_DATA_WIDTH),  // Data bus width
     .ADDR_WDTH                 (`ATCBMC300_ADDR_WIDTH),  // Address bus width
     .ID_WDTH                   (`ATCBMC300_ID_WIDTH+4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
      // NOTE: If (ID_WDTH_rd == ID_WDTH_wr), those values will be IGNORED and ID_WDTH will be used
      // NOTE: If (ID_WDTH_rd != ID_WDTH_wr), those values will be used and ID_WDTH will be IGNORED
     .ID_WDTH_rd                (`ATCBMC300_ID_WIDTH+4),  // Read ID width;  NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
     .ID_WDTH_wr                (`ATCBMC300_ID_WIDTH+4),  // Write ID width; NOTE: an ID used for an exclusive sequence must fit in BOTH read and write ID
    .AWUSER_WDTH                (1),                      // Width of the user AW sideband field
    .WUSER_WDTH                 (1),                      // Width of the user W  sideband field
    .BUSER_WDTH                 (1),                      // Width of the user B  sideband field
    .ARUSER_WDTH                (1),                      // Width of the user AR sideband field
    .RUSER_WDTH                 (1),                      // Width of the user R  sideband field
    .WMAXBURSTS                 (2),                      // Number of write transactions to be monitored; minumum value: 1;
                                                          // to get the effect of WMAXBURSTS=0, set CONFIG_RD_ONLY=1
    .RMAXBURSTS                 (2),                      // Number of read  transactions to be monitored; minumum value: 1;
                                                          // to get the effect of RMAXBURSTS=0, set CONFIG_WR_ONLY=1
    .EXCL_DPTH                  (1),                      // Number of exclusive accesses to be monitored
    .RMAXLEN                    (`RMAXLEN),               // Max number of data beats in a burst; places a max value on ARLEN; minimum value: 1
    .WMAXLEN                    (`WMAXLEN),               // Max number of data beats in a burst; places a max value on AWLEN; minimum value: 1
    .CAUSALITY                  (1),                      // 1: Constraint relative order of traffic on Write Address and Write Data Channels
                                                          //    i.e. You cannot see the W transaction before the AW transaction.
    .RD_OUTOFORDER              (0),                      // 0: Inhibit out of order for read data
    .WP_OUTOFORDER              (0),                      // 0: Inhibit out of order for write response
    .RID_INTERLEAVE             (0)                       // 0: Disable read interleaving
 ) downstream31
 (
   .ACLK  	(aclk),
   .ARESETn    (aresetn),
	.CSYSREQ    (1'b0),
	.CSYSACK    (1'b0),
	.CACTIVE    (1'b0),

   .AWREGION   (4'b0),
   .AWID  		(ds31_awid),
   .AWADDR		(ds31_awaddr),
   .AWLEN   	(ds31_awlen),
   .AWSIZE    	(ds31_awsize),
   .AWBURST   	(ds31_awburst),
   .AWLOCK   	(ds31_awlock),
   .AWCACHE   	(ds31_awcache),
   .AWPROT   	(ds31_awprot),
   .AWQOS	(4'b0),
   .AWVALID	(ds31_awvalid),
   .AWREADY	(ds31_awready),
   .AWUSER	(32'b0),

   .WDATA	(ds31_wdata),
   .WSTRB	(ds31_wstrb),
   .WLAST	(ds31_wlast),
   .WVALID	(ds31_wvalid),
   .WREADY	(ds31_wready),
   .WUSER	(32'b0),

   .BID	(ds31_bid),
   .BRESP	(ds31_bresp),
   .BVALID	(ds31_bvalid),
   .BREADY	(ds31_bready),
   .BUSER	(32'b0),

   .ARREGION	(4'b0),
   .ARID	(ds31_arid),
   .ARADDR	(ds31_araddr),
   .ARLEN	(ds31_arlen),
   .ARSIZE	(ds31_arsize),
   .ARBURST	(ds31_arburst),
   .ARLOCK	(ds31_arlock),
   .ARCACHE	(ds31_arcache),
   .ARPROT	(ds31_arprot),
   .ARQOS	(4'b0),
   .ARVALID	(ds31_arvalid),
   .ARREADY	(ds31_arready),
   .ARUSER	(32'b0),

   .RID	(ds31_rid),
   .RDATA	(ds31_rdata),
   .RRESP	(ds31_rresp),
   .RLAST	(ds31_rlast),
   .RVALID	(ds31_rvalid),
   .RREADY	(ds31_rready),
   .RUSER	(32'b0)
 );
`endif
// VPERL_GENERATED_END
