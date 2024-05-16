![[Pasted image 20240323023006.png]]

![[Pasted image 20240323023031.png]]

![[Pasted image 20240323023112.png]]

![[Pasted image 20240323023144.png]]

![[Pasted image 20240323023206.png]]

# code

```verilog
module andla_ubmc_ds_a(
     aclk
    ,aresetn
    ,ds_a_valid
    ,ds_a_opcode
    ,ds_a_mask
    ,ds_a_address
    ,ds_a_data
    ,ds_a_ready
    ,slv_a_mid
    ,slv_a_rdy
    ,outstanding_vld
    ,outstanding_data
    ,outstanding_rdy
// mst0
    ,mst0_a_vld
    ,mst0_a_opcode
    ,mst0_a_mask
    ,mst0_a_address
    ,mst0_a_data
// mst1
    ,mst1_a_vld
    ,mst1_a_opcode
    ,mst1_a_mask
    ,mst1_a_address
    ,mst1_a_data
// mst2
    ,mst2_a_vld
    ,mst2_a_opcode
    ,mst2_a_mask
    ,mst2_a_address
    ,mst2_a_data
// mst3
    ,mst3_a_vld
    ,mst3_a_opcode
    ,mst3_a_mask
    ,mst3_a_address
    ,mst3_a_data
// mst4
    ,mst4_a_vld
    ,mst4_a_opcode
    ,mst4_a_mask
    ,mst4_a_address
    ,mst4_a_data
);

parameter  MASK_BITWIDTH=1;
parameter  ADDR_BITWIDTH=1;
parameter  DATA_BITWIDTH=1;
parameter  SLV_ID_WIDTH=1;
parameter  MST_ID_WIDTH=1;
parameter  PIPELINE_ENABLE=0;

input                      aclk;
input                      aresetn;
output                     ds_a_valid;
output                     ds_a_opcode;
output [MASK_BITWIDTH-1:0] ds_a_mask;
output [ADDR_BITWIDTH-1:0] ds_a_address;
output [DATA_BITWIDTH-1:0] ds_a_data;
input                      ds_a_ready;
output [MST_ID_WIDTH-1:0]  slv_a_mid;
output                     slv_a_rdy;
output                     outstanding_vld;
output [MST_ID_WIDTH-1:0]  outstanding_data;
input                      outstanding_rdy;
// mst0
input                      mst0_a_vld;
input                      mst0_a_opcode;
input  [MASK_BITWIDTH-1:0] mst0_a_mask;
input  [ADDR_BITWIDTH-1:0] mst0_a_address;
input  [DATA_BITWIDTH-1:0] mst0_a_data;
// mst1
input                      mst1_a_vld;
input                      mst1_a_opcode;
input  [MASK_BITWIDTH-1:0] mst1_a_mask;
input  [ADDR_BITWIDTH-1:0] mst1_a_address;
input  [DATA_BITWIDTH-1:0] mst1_a_data;
// mst2
input                      mst2_a_vld;
input                      mst2_a_opcode;
input  [MASK_BITWIDTH-1:0] mst2_a_mask;
input  [ADDR_BITWIDTH-1:0] mst2_a_address;
input  [DATA_BITWIDTH-1:0] mst2_a_data;
// mst3
input                      mst3_a_vld;
input                      mst3_a_opcode;
input  [MASK_BITWIDTH-1:0] mst3_a_mask;
input  [ADDR_BITWIDTH-1:0] mst3_a_address;
input  [DATA_BITWIDTH-1:0] mst3_a_data;
// mst4
input                      mst4_a_vld;
input                      mst4_a_opcode;
input  [MASK_BITWIDTH-1:0] mst4_a_mask;
input  [ADDR_BITWIDTH-1:0] mst4_a_address;
input  [DATA_BITWIDTH-1:0] mst4_a_data;

wire [MST_ID_WIDTH-1:0]   arb_mid;
wire [5-1:0] mst_a_vld;
wire                      mst_a_opcode  [5-1:0];
wire [MASK_BITWIDTH-1:0]  mst_a_mask    [5-1:0];
wire [ADDR_BITWIDTH-1:0]  mst_a_address [5-1:0];
wire [DATA_BITWIDTH-1:0]  mst_a_data    [5-1:0];



assign slv_a_mid   = arb_mid;

wire [5-1:0] mst_grant;
wire [5-1:0] mst_request;
// mst0
assign mst_grant[0] = mst_request[0];
// mst1
assign mst_grant[1] = ~|mst_grant[0:0] & mst_request[1];
// mst2
assign mst_grant[2] = ~|mst_grant[1:0] & mst_request[2];
// mst3
assign mst_grant[3] = ~|mst_grant[2:0] & mst_request[3];
// mst4
assign mst_grant[4] = ~|mst_grant[3:0] & mst_request[4];


assign arb_mid = (({MST_ID_WIDTH{mst_grant[0]}} & 3'd0)
               |  ({MST_ID_WIDTH{mst_grant[1]}} & 3'd1)
               |  ({MST_ID_WIDTH{mst_grant[2]}} & 3'd2)
               |  ({MST_ID_WIDTH{mst_grant[3]}} & 3'd3)
               |  ({MST_ID_WIDTH{mst_grant[4]}} & 3'd4)
               );

wire no_serve;
wire [5-1:0] serve_nx;
reg [5-1:0] serve;

assign no_serve = ~(|serve);  // TODO

// mst0
assign mst_request[0] = mst0_a_vld & (no_serve | serve[0]);
assign serve_nx[0] = ~mst_grant[0] & mst_request[0];
// mst1
assign mst_request[1] = mst1_a_vld & (no_serve | serve[1]);
assign serve_nx[1] = ~mst_grant[1] & mst_request[1];
// mst2
assign mst_request[2] = mst2_a_vld & (no_serve | serve[2]);
assign serve_nx[2] = ~mst_grant[2] & mst_request[2];
// mst3
assign mst_request[3] = mst3_a_vld & (no_serve | serve[3]);
assign serve_nx[3] = ~mst_grant[3] & mst_request[3];
// mst4
assign mst_request[4] = mst4_a_vld & (no_serve | serve[4]);
assign serve_nx[4] = ~mst_grant[4] & mst_request[4];


always @ (posedge aclk or negedge aresetn) begin
    if (!aresetn) begin
        serve <= 5'd0; // linting
    end
    else begin
        serve <= serve_nx;
    end
end

wire fctrl_req_rdy;
assign outstanding_data = arb_mid;
assign outstanding_vld = fctrl_req_rdy & |mst_request; // FIX

//wire arb_vld = (no_serve & |mst_a_vld) | (~no_serve & |(serve & mst_a_vld));

// mst0
assign mst_a_vld[0]     = mst0_a_vld;
assign mst_a_opcode[0]  = mst0_a_opcode;
assign mst_a_mask[0]    = mst0_a_mask;
assign mst_a_address[0] = mst0_a_address;
assign mst_a_data[0]    = mst0_a_data;
// mst1
assign mst_a_vld[1]     = mst1_a_vld;
assign mst_a_opcode[1]  = mst1_a_opcode;
assign mst_a_mask[1]    = mst1_a_mask;
assign mst_a_address[1] = mst1_a_address;
assign mst_a_data[1]    = mst1_a_data;
// mst2
assign mst_a_vld[2]     = mst2_a_vld;
assign mst_a_opcode[2]  = mst2_a_opcode;
assign mst_a_mask[2]    = mst2_a_mask;
assign mst_a_address[2] = mst2_a_address;
assign mst_a_data[2]    = mst2_a_data;
// mst3
assign mst_a_vld[3]     = mst3_a_vld;
assign mst_a_opcode[3]  = mst3_a_opcode;
assign mst_a_mask[3]    = mst3_a_mask;
assign mst_a_address[3] = mst3_a_address;
assign mst_a_data[3]    = mst3_a_data;
// mst4
assign mst_a_vld[4]     = mst4_a_vld;
assign mst_a_opcode[4]  = mst4_a_opcode;
assign mst_a_mask[4]    = mst4_a_mask;
assign mst_a_address[4] = mst4_a_address;
assign mst_a_data[4]    = mst4_a_data;

wire [(DATA_BITWIDTH+MASK_BITWIDTH+ADDR_BITWIDTH+1)-1:0] fctrl_req_data;

assign fctrl_req_data = {mst_a_data[arb_mid], mst_a_mask[arb_mid], mst_a_address[arb_mid], mst_a_opcode[arb_mid]};

wire fctrl_req_vld;


assign fctrl_req_vld = outstanding_rdy & |mst_request; // FIX
assign slv_a_rdy = outstanding_rdy & fctrl_req_rdy & |mst_request; // FIX

wire [(DATA_BITWIDTH+MASK_BITWIDTH+ADDR_BITWIDTH+1)-1:0] fctrl_rsp_data;

assign ds_a_data = fctrl_rsp_data[1+ADDR_BITWIDTH+MASK_BITWIDTH +: DATA_BITWIDTH];
assign ds_a_mask = fctrl_rsp_data[1+ADDR_BITWIDTH +: MASK_BITWIDTH];
assign ds_a_address = fctrl_rsp_data[1 +: ADDR_BITWIDTH];
assign ds_a_opcode = fctrl_rsp_data[0];

wire fctrl_rsp_vld;
wire fctrl_rsp_rdy;

assign ds_a_valid = fctrl_rsp_vld;
assign fctrl_rsp_rdy = ds_a_ready;

flow_controller #(
     .DATA_BITWIDTH         (DATA_BITWIDTH + MASK_BITWIDTH + ADDR_BITWIDTH + 1 )
    ,.PENDING_BUFFER_ENABLE ('d0                                               )
    ,.PIPELINE_ENABLE       (PIPELINE_ENABLE                                   )
) fctrl (
     .aclk     (aclk           )
    ,.aresetn  (aresetn        )
    ,.req_vld  (fctrl_req_vld  )
    ,.req_rdy  (fctrl_req_rdy  )
    ,.req_data (fctrl_req_data )
    ,.rsp_vld  (fctrl_rsp_vld  )
    ,.rsp_rdy  (fctrl_rsp_rdy  )
    ,.rsp_data (fctrl_rsp_data )
);

endmodule

```