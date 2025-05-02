# pipeline
![[pipeline.svg]]
```verilog
// uarch 0: set > clr (standard)
always @ (posedge aclk or negedge aresetn) begin
	if (aresetn) begin
		p1_valid <= 'd0;
	end else begin
		p1_valid <= p1_valid_nx;
	end
end

wire p0_ready = ~p1_valid | p1_ready;
wire p0_taken = p1_valid & p1_ready;
wire p1_valid_set = p1_taken;
wire p1_valid_clr = p1_ready;
wire p1_valid_nx = p1_valid_set | (p1_valid & ~p1_valid_clr);

// uarch 1: self clear
wire p1_valid_clr = p1_valid;

// uarch 2: clr > set (only flag control)
always @ (posedge aclk or negedge aresetn) begin
	if (aresetn) begin
		p1_flag <= 'd0;
	end else begin
		p1_flag <= p1_flag_nx;
	end
end

wire p1_flag_set = ...
wire p1_flag_clr = ...
wire p1_flag_nx = ~p1_flag_clr & (p1_flag_set | p1_flag);
```
# pipeline_reset

```
```
# pending_buffer
![[pending_buffer.svg]]
```verilog
`include "andla.vh"

module flow_controller
(
//{{{ Ports
//---Global---
aclk
,aresetn
//---request---
,req_vld
,req_rdy
,req_data
//---response---
,rsp_vld
,rsp_rdy
,rsp_data
//}}}
);
//{{{param
parameter DATA_BITWIDTH = 1;
parameter PENDING_BUFFER_ENABLE = 0;
parameter PIPELINE_ENABLE       = 0;
//}}}
//{{{ interfaces
input                          aclk;
input                          aresetn;
//---request---
input                          req_vld;
output                         req_rdy;
input  [DATA_BITWIDTH-1:0]     req_data;
//---response---
output                         rsp_vld;
input                          rsp_rdy;
output [DATA_BITWIDTH-1:0]     rsp_data;
//}}}

wire                     pending_pipeline_vld;
wire                     pipeline_pending_rdy;
wire [DATA_BITWIDTH-1:0] pending_pipeline_data;

generate if (PENDING_BUFFER_ENABLE==1) begin: pending_buffer
//{{{ ready pending buffer
    //control path
    //valid
    wire req_taken             = req_vld & req_rdy;
    wire pending_vld_reg_set   = req_taken & ~pipeline_pending_rdy;
    wire pending_vld_reg_clr   = pipeline_pending_rdy;
    reg  pending_vld_reg;
    wire pending_vld_reg_nx    = pending_vld_reg_set | (pending_vld_reg & ~pending_vld_reg_clr);
    always@(posedge aclk or negedge aresetn) begin
        if(!aresetn) begin
            pending_vld_reg   <= 1'b0;
        end else begin
            pending_vld_reg   <= pending_vld_reg_nx;
        end
    end
    assign pending_pipeline_vld  = req_vld | pending_vld_reg;
    //ready
    wire pending_rdy_reg_nx    = ~pending_vld_reg_nx;
    reg  pending_rdy_reg;
    always@(posedge aclk or negedge aresetn) begin
        if(!aresetn) begin
            pending_rdy_reg   <= 1'b1;
        end else begin
            pending_rdy_reg   <= pending_rdy_reg_nx;
        end
    end
    assign  req_rdy            = pending_rdy_reg;
    //data path
    reg  [(DATA_BITWIDTH-1):0] pending_data_reg;
    wire [(DATA_BITWIDTH-1):0] pending_data_reg_nx  = pending_vld_reg_set ? req_data : pending_data_reg;

    always@(posedge aclk or negedge aresetn) begin
        if(!aresetn) begin
            pending_data_reg      <= { (DATA_BITWIDTH){1'b0} };
        end else begin
            pending_data_reg      <= pending_data_reg_nx;
        end
    end

    assign pending_pipeline_data   = pending_vld_reg ? pending_data_reg : req_data;
//}}}
end else begin: no_pending_buffer
    assign pending_pipeline_vld  = req_vld;
    assign req_rdy               = pipeline_pending_rdy;
    assign pending_pipeline_data = req_data;
end
endgenerate

generate if (PIPELINE_ENABLE==1) begin: pipeline
//{{{ valid pipeline
    //control path
    //valid
    wire pipeline_vld_reg_set      = pending_pipeline_vld & pipeline_pending_rdy;
    wire pipeline_vld_reg_clr      = rsp_rdy;
    reg  pipeline_vld_reg;
    wire pipeline_vld_reg_nx       = pipeline_vld_reg_set | (pipeline_vld_reg & ~pipeline_vld_reg_clr);

    always@(posedge aclk or negedge aresetn) begin
        if(!aresetn) begin
            pipeline_vld_reg      <= 1'b0;
        end else begin
            pipeline_vld_reg      <= pipeline_vld_reg_nx;
        end
    end
    assign rsp_vld                 = pipeline_vld_reg;
    //ready
    assign pipeline_pending_rdy    = ~pipeline_vld_reg | rsp_rdy;

    //data path
    reg  [(DATA_BITWIDTH-1):0] pipeline_data_reg;
    wire [(DATA_BITWIDTH-1):0] pipeline_data_reg_nx = pipeline_vld_reg_set ? pending_pipeline_data : pipeline_data_reg;

    always@(posedge aclk) begin
        pipeline_data_reg <= pipeline_data_reg_nx;
    end
    assign rsp_data        = pipeline_data_reg;
//}}}
end else begin: no_pipeline
    assign rsp_vld              = pending_pipeline_vld;
    assign pipeline_pending_rdy = rsp_rdy;
    assign rsp_data             = pending_pipeline_data;
end
endgenerate

endmodule

```

# credit_fctrl
![[credit_fctrl.svg]]
credit-based flow controller 的基本觀念:
1.  忽視long-term path
2.  receiver
    1. non-outstanding transaction/outstanding transaction: 視為Tail
        1. 條件: receiver transaction write必須是資料確實從receiver輸出，將訊息傳給credit
3.  sender
    1. non-outstanding transaction: 視為Head2
        1. 條件: sender transaction write必須是資料確實從sender輸出，將訊息傳給credit
    2. outstanding transaction: 視為Head1
        1. 條件: sender transaction read必須是在最開始的時候，將訊息傳給credit
