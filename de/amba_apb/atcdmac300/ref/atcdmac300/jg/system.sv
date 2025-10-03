`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module system (
	  aclk,
	  aresetn,
	  dma_req,    // (atcdmac300_chmux) <= ()
	  m0_arready, // (atcdmac300_aximst_0) <= ()
	  m0_awready, // (atcdmac300_aximst_0) <= ()
	  m0_bid,     // (atcdmac300_aximst_0) <= ()
	  m0_bresp,   // (atcdmac300_aximst_0) <= ()
	  m0_bvalid,  // (atcdmac300_aximst_0) <= ()
	  m0_rdata,   // (atcdmac300_aximst_0) <= ()
	  m0_rid,     // (atcdmac300_aximst_0) <= ()
	  m0_rlast,   // (atcdmac300_aximst_0) <= ()
	  m0_rresp,   // (atcdmac300_aximst_0) <= ()
	  m0_rvalid,  // (atcdmac300_aximst_0) <= ()
	  m0_wready,  // (atcdmac300_aximst_0) <= ()
	  paddr,      // (atcdmac300_apbslv) <= ()
	  pclk,       // (atcdmac300_apbslv,atcdmac300_register) <= ()
	  penable,    // (atcdmac300_apbslv) <= ()
	  presetn,    // (atcdmac300_apbslv,atcdmac300_register) <= ()
	  psel,       // (atcdmac300_apbslv) <= ()
	  pwdata,     // (atcdmac300_apbslv) <= ()
	  pwrite,     // (atcdmac300_apbslv) <= ()
	  dma_ack,    // (atcdmac300_chmux) => ()
	  dma_int,    // (atcdmac300_register) => ()
	  m0_araddr,  // (atcdmac300_aximst_0) => ()
	  m0_arburst, // (atcdmac300_aximst_0) => ()
	  m0_arcache, // (atcdmac300_aximst_0) => ()
	  m0_arid,    // (atcdmac300_aximst_0) => ()
	  m0_arlen,   // (atcdmac300_aximst_0) => ()
	  m0_arlock,  // (atcdmac300_aximst_0) => ()
	  m0_arprot,  // (atcdmac300_aximst_0) => ()
	  m0_arsize,  // (atcdmac300_aximst_0) => ()
	  m0_arvalid, // (atcdmac300_aximst_0) => ()
	  m0_awaddr,  // (atcdmac300_aximst_0) => ()
	  m0_awburst, // (atcdmac300_aximst_0) => ()
	  m0_awcache, // (atcdmac300_aximst_0) => ()
	  m0_awid,    // (atcdmac300_aximst_0) => ()
	  m0_awlen,   // (atcdmac300_aximst_0) => ()
	  m0_awlock,  // (atcdmac300_aximst_0) => ()
	  m0_awprot,  // (atcdmac300_aximst_0) => ()
	  m0_awsize,  // (atcdmac300_aximst_0) => ()
	  m0_awvalid, // (atcdmac300_aximst_0) => ()
	  m0_bready,  // (atcdmac300_aximst_0) => ()
	  m0_rready,  // (atcdmac300_aximst_0) => ()
	  m0_wdata,   // (atcdmac300_aximst_0) => ()
	  m0_wlast,   // (atcdmac300_aximst_0) => ()
	  m0_wstrb,   // (atcdmac300_aximst_0) => ()
	  m0_wvalid,  // (atcdmac300_aximst_0) => ()
	  prdata,     // (atcdmac300_apbslv) => ()
	  pready,     // (atcdmac300_apbslv) => ()
	  pslverr     // (atcdmac300_apbslv) => ()
);
input                                       aclk;
input                                       aresetn;
input       [(`ATCDMAC300_REQ_ACK_NUM-1):0] dma_req;
input                                       m0_arready;
input                                       m0_awready;
input                                 [2:0] m0_bid;
input                                 [1:0] m0_bresp;
input                                       m0_bvalid;
input               [(`DMA_DATA_WIDTH-1):0] m0_rdata;
input                                 [2:0] m0_rid;
input                                       m0_rlast;
input                                 [1:0] m0_rresp;
input                                       m0_rvalid;
input                                       m0_wready;
input                                [31:0] paddr;
input                                       pclk;
input                                       penable;
input                                       presetn;
input                                       psel;
input                                [31:0] pwdata;
input                                       pwrite;
output      [(`ATCDMAC300_REQ_ACK_NUM-1):0] dma_ack;
output                                      dma_int;
output       [(`ATCDMAC300_ADDR_WIDTH-1):0] m0_araddr;
output                                [1:0] m0_arburst;
output                                [3:0] m0_arcache;
output                                [2:0] m0_arid;
output                                [7:0] m0_arlen;
output                                      m0_arlock;
output                                [2:0] m0_arprot;
output                                [2:0] m0_arsize;
output                                      m0_arvalid;
output       [(`ATCDMAC300_ADDR_WIDTH-1):0] m0_awaddr;
output                                [1:0] m0_awburst;
output                                [3:0] m0_awcache;
output                                [2:0] m0_awid;
output                                [7:0] m0_awlen;
output                                      m0_awlock;
output                                [2:0] m0_awprot;
output                                [2:0] m0_awsize;
output                                      m0_awvalid;
output                                      m0_bready;
output                                      m0_rready;
output              [(`DMA_DATA_WIDTH-1):0] m0_wdata;
output                                      m0_wlast;
output             [(`DMA_WSTRB_WIDTH-1):0] m0_wstrb;
output                                      m0_wvalid;
output                               [31:0] prdata;
output                                      pready;
output                                      pslverr;

atcdmac300 atcdmac300(.*);

jasper_amba_apb_sv
  #(
    .VERIFY_BLK           (1),		// 0: MASTER/APB BRIDGE: PK provides assertions for master/APB bridge outputs and assumptions for master/APB bridge inputs coming from the slave
                              		// 1: SLAVE: PK provides assertions for slave outputs and assumptions for slave inputs coming from master/APB bridge
    .CONFIG_APB2_0        (1),          // Follow the APB 2.0 spec or not (vs. APB 1.0)
    .CONFIG_LP            (1),          // 0: Disable LP properties
    .CONFIG_RCMND         (1),          // 0: Disable recommended properties; 1: Enable recommended properties
    .CONFIG_PERMIT_RD_X   (0),          // 0: X's are not valid on PRDATA in the absence of reported errors
                                        // 1: X's are valid on PRDATA in the absence of reported errors
                                        // (See property M_PRDATA_X for details)
    .CONFIG_XPROP         (1),          // 0: Disable X propagation props
    .CONFIG_CSR_INTERFACE (0),          // Config PK to act as CSR PA
    .PSEL_N               (1),          // Number of slaves
    .ADDR_WDTH            (32),         // Address PADDR width
    .DATA_WDTH            (32),         // Read/write data PRDATA/PWDATA width
    .CONFIG_LIVENESS      (0),          // 0: no liveness properties generated
                                        // 1: liveness properties generated
    .STRB_WDTH            (4)		// Write strobe width
  ) dmac300_apb_slave
  (
    .PRESETn  	(presetn),  
    .PCLK     	(pclk),    
    .PSELx  	(psel),      
    .PENABLE	(penable),
    .PADDR    	(paddr),
    .PWRITE   	(pwrite),     
    .PPROT    	(),     
    .PWDATA   	(pwdata),   
    .PRDATA   	(prdata),  
    .PREADY   	(pready),
    .PSTRB	(),
    .PSLVERR	(pslverr)
  );

jasper_amba_axi4_sv
  #( .AXI4_LITE                 (0),  // 1: Enable PK to work as AXI4-Lite checker
     .VERIFY_BLK                (0),  // 0: MASTER:    PK provides assertions for master outputs, and assumptions for master inputs coming from the slave
                                      // 1: SLAVE:     PK provides assertions for slave outputs and assumptions for slave inputs coming from the master
                                      // 2: MONITOR:   PK provides assertions for master and slave outputs
                                      // 3: CONSTRAIN: PK provides assumptions for master and slave outputs
     .VERIFY_PK                 (1),  // 1: Enable Verifying PK correctness assertions
     .CONFIG_XPROP              (1),  // 0: Disable X propagation props
     .CONFIG_RDATA_masked       (0),  // 0: RDATA X-propagation and stability properties apply to full RDATA
     				      // 1: Properties apply to valid byte lanes only
     .CONFIG_DEAD               (0),  // 0: Disable potential deadlock checking
     .CONFIG_EXCL               (0),  // Config Props for Exclusive Access
     				      // 0: Exclusive Accesses disabled; no exclusive access checks included
     				      // 1: Exclusive Accesses enabled;  exclusive access checks included
     				      // 2: Exclusive Accesses enabled;  lightweight subset of exclusive access checks included
     .CONFIG_EXCL_RCMND         (0),  // 0: Disable ARM recommendations for Exclusive (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_EXCL_RCMND_RRARAW  (0),  // 0: Disable ARM recommendation - No excl AR between RR and matching AW (must be 0 if CONFIG_EXCL == 0)
     .CONFIG_WSTRB_CHK          (1),  // 0: Disable WSTRB value checking
     .CONFIG_STABLE_CHK         (1),  // 0: Disable VALID & ~READY _stable properties; 1: enable
     .CONFIG_RESET_CHK          (1),  // 0: Disable VALID signal reset value properties; 1: enable
     .CONFIG_SIMULATION         (0),  // 1: Enable PK to be used with simulation; 0: normal, formal mode
     .CONFIG_RD_ONLY            (0),  // 1: Exclude all properties that are not for read accesses
     				      // If CONFIG_EXCL != 0 then CONFIG_RD_ONLY must be 0
     .CONFIG_WR_ONLY            (0),  // 1: Exclude all properties that are not for write accesses
     				      // If CONFIG_EXCL != 0 then CONFIG_WR_ONLY must be 0
     .CONFIG_RD_FULL_STRB       (0),  // 0: (default) Full read strobe not required
     				      // 1: Full read strobes only
     .CONFIG_WR_FULL_STRB       (0),  // 0: (default) Full write strobe not required
     				      // 1: Full write strobes only
     .CONFIG_CSR_INTERFACE      (1),  // 1: Proof kit instantiated with CSR Proof Accelerator
     .CONFIG_CSR_MODE           (0),  // must be 0 if CONFIG_CSR_INTERFACE is 0
     				      // 0: CSR properties enabled with AXI properties (both constraints & assertions)
     				      // 1: CSR properties enabled with AXI constraints only
     				      // 2: Only CSR properties enabled.
     .CONFIG_CSR_FEED_EARLY_W   (0),  // Tune internal CSR logic behavior
     				      // 0: (default) Feed write data from buffer to CSR checker queue on B transaction
     				      // 1:           Feed write data from buffer to CSR checker queue on W transaction
     .MAX_LATENCY               (8),  // VALID -> READY within 8 cycles
     .DATA_WDTH                 (32), // Data bus width
     .ADDR_WDTH                 (32), // Address bus width
     .ID_WDTH                   (4),  // ID width; NOTE: if you need separate read and write ID widths, use ID_WDTH_rd and ID_WDTH_wr
     .AWUSER_WDTH               (0),  // Width of the user AW sideband field
     .WUSER_WDTH                (0),  // Width of the user W  sideband field
     .BUSER_WDTH                (0),  // Width of the user B  sideband field
     .ARUSER_WDTH               (0),  // Width of the user AR sideband field
     .RUSER_WDTH                (0),  // Width of the user R  sideband field
     .WMAXBURSTS                (2),  // Number of write transactions to be monitored
     .RMAXBURSTS                (2),  // Number of read  transactions to be monitored, RMAXBURSTS must be larger than 0
     .EXCL_DPTH                 (0),  // Number of exclusive accesses to be monitored
     .RMAXLEN                   (16), // Max number of data beats in a burst; place a max value on ARLEN
     .WMAXLEN                   (16), // Max number of data beats in a burst; place a max value on AWLEN
     .CAUSALITY                 (0),  // 1: Constraint relative order of traffic on Write Address and Write Data Channels
     				      //    i.e. You cannot see the W transaction before the AW transaction.
     .RD_OUTOFORDER             (0),  // 0: Inhibit out of order for read data
     .WP_OUTOFORDER             (0),  // 0: Inhibit out of order for write response
     .RID_INTERLEAVE            (0)   // 0: Disable read interleaving

  ) axi4_vip
  (
    .ACLK(aclk),                           // Master clock
    .ARESETn(aresetn),                        // Reset, active low

    // Write address channel

    .AWID(    m0_awid),		 // Write address ID; if (AXI4_LITE == 1) leave unconnected; PK will assume 0
    .AWADDR(  m0_awaddr),	 // Write address
    .AWREGION(4'b0000),		 // Write Region; if (AXI4_LITE == 1) leave unconnected; PK will assume 4'b0000
    .AWLEN(   m0_awlen),	 // Increased Burst Length; if (AXI4_LITE == 1) leave unconnected; PK will assume 8'h00
    .AWSIZE(  m0_awsize),	 // Burst size; if (AXI4_LITE == 1) leave unconnected; PK will assume data bus width
    .AWBURST( m0_awburst),	 // Burst type; if (AXI4_LITE == 1) leave unconnected; PK will assume 2'b00
    .AWLOCK(  m0_awlock),	 // Lock type; if (AXI4_LITE == 1) leave unconnected; PK will assume 1'b0
    .AWCACHE( m0_awcache),	 // Cache type; if (AXI4_LITE == 1) leave unconnected; PK will assume 4'b0000
    .AWPROT(  m0_awprot),	 // Protection type
    .AWQOS(   4'b0000),		 // QoS value; if (AXI4_LITE == 1) leave unconnected; PK will assume 4'b0000
    .AWVALID( m0_awvalid),	 // Write address valid
    .AWREADY( m0_awready),	 // Write address ready
    .AWUSER(  2'b0),      	 // User sideband signal; if (AXI4_LITE == 1) leave unconnected

    // Write data channel
    // The AXI4/ACE spec (C3.1.4, Table C3-9) lists the supported AXI4 data bus widths in bits as: 32, 64, 128, 256, 512, 1024.
    //  So max WDATA and RDATA width is 1024 and max WSTRB width is 1024/8 = 128

    .WDATA(   m0_wdata),	 // Write data
    .WSTRB(   m0_wstrb),	 // Write strobes
    .WLAST(   m0_wlast),	 // Write last; if (AXI4_LITE == 1) leave unconnected; PK will assume 1'b1
    .WVALID(  m0_wvalid),	 // Write valid
    .WREADY(  m0_wready),	 // Write ready
    .WUSER(   2'b0),		 // User sideband signal; if (AXI4_LITE == 1) leave unconnected

    // Write response channel

    .BID(     m0_bid),	 	 // Response ID; if (AXI4_LITE == 1) leave unconnected; PK will assume 0
    .BRESP(   m0_bresp),	 // Write response
    .BVALID(  m0_bvalid),	 // Write response valid
    .BREADY(  m0_bready),	 // Response ready
    .BUSER(   2'b0),		 // User sideband signal; if (AXI4_LITE == 1) leave unconnected

    // Read address channel

    .ARID(    m0_arid),		 // Read address ID; if (AXI4_LITE == 1) leave unconnected; PK will assume 0
    .ARADDR(  m0_araddr),	 // Read address
    .ARREGION(4'b0000),		 // Read Region; if (AXI4_LITE == 1) leave unconnected; PK will assume 4'b0000
    .ARLEN(   m0_arlen),	 // Increased Burst Read Length; if (AXI4_LITE == 1) leave unconnected; PK will assume 8'h00
    .ARSIZE(  m0_arsize),	 // Burst size; if (AXI4_LITE == 1) leave unconnected; PK will assume data bus width
    .ARBURST( m0_arburst),	 // Burst type; if (AXI4_LITE == 1) leave unconnected; PK will assume 2'b00
    .ARCACHE( m0_arcache),	 // Cache type; if (AXI4_LITE == 1) leave unconnected; PK will assume 4'b0000
    .ARPROT(  m0_arprot),	 // Protection type
    .ARQOS(   4'b0000),		 // QoS value; if (AXI4_LITE == 1) leave unconnected; PK will assume 4'b0000
    .ARLOCK(  m0_arlock),	 // Lock type; if (AXI4_LITE == 1) leave unconnected; PK will assume 1'b0
    .ARVALID( m0_arvalid),	 // Read address valid
    .ARREADY( m0_arready),	 // Read address ready
    .ARUSER(  2'b0),		 // User sideband signal; if (AXI4_LITE == 1) leave unconnected

    // Read data channel

    .RUSER(   2'b0),		 // User sideband signal; if (AXI4_LITE == 1) leave unconnected
    .RID(    m0_rid),	 	 // Read ID tag; if (AXI4_LITE == 1) leave unconnected; PK will assume 0
    .RDATA(  m0_rdata),		 // Read data
    .RRESP(  m0_rresp),		 // Read response
    .RLAST(  m0_rlast),		 // Read last; if (AXI4_LITE == 1) leave unconnected; PK will assume 1'b1
    .RVALID( m0_rvalid),	 // Read valid
    .RREADY( m0_rready),	 // Read ready

    // Low Power interface

    .CSYSREQ(1'b1),	 // Low power request; if (AXI4_LITE == 1) leave unconnected; PK will assume 1'b1
    .CSYSACK(1'b1),	 // Low power acknowledgement; if (AXI4_LITE == 1) leave unconnected; PK will assume 1'b1
    .CACTIVE(1'b1)	 // Clock required (1) or not (0); if (AXI4_LITE == 1) leave unconnected; PK will assume 1'b1
  );

endmodule

