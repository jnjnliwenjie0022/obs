//      ___                   
//     |   |           |      
// ___\|f0 |___________|      
//    /|   |  |  ___   |___\  
//     |___|  | |   |  |   /  
//            |_|f1 |__|      
//              |   |  |      
//              |___|         
//                            
module atctlc2axi500_elastic_buffer_i (
    // VPERL: &PORTLIST;
    // VPERL_GENERATED_BEGIN
    	  clk,      
    	  resetn,   
    	  clk_en,   
    	  i_valid,  
    	  i_ready,  
    	  din,      
    	  o_valid,  
    	  o_ready,  
    	  dout      
    // VPERL_GENERATED_END
);

parameter DW = 32;
parameter RAR_SUPPORT = 0;

input            clk;
input            resetn;
input            clk_en;
input            i_valid;
output           i_ready;
input   [DW-1:0] din;
output           o_valid;
input            o_ready;
output  [DW-1:0] dout;

reg     [DW-1:0] f0;
wire    [DW-1:0] f0_nx;
wire             f0_en;

reg              f0_valid;
wire             f0_valid_nx;
wire             f0_valid_set;
wire             f0_valid_clr;

reg              f0_ready;
wire             f0_ready_nx;

reg     [DW-1:0] f1;
wire    [DW-1:0] f1_nx;
wire             f1_en;

reg              f1_valid;
wire             f1_valid_nx;
wire             f1_valid_set;
wire             f1_valid_clr;

assign f0_valid_set = i_valid & i_ready & clk_en;
assign f0_valid_clr = ~f1_valid | o_ready;
assign f0_valid_nx = (f0_valid & ~f0_valid_clr) | f0_valid_set;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        f0_valid <= 1'b0;
    end
    else begin
        f0_valid <= f0_valid_nx;
    end
end

assign f0_ready_nx = clk_en ? (~f0_valid_nx | ~f1_valid_nx) : f0_ready;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        f0_ready <= 1'b1;
    end
    else begin
        f0_ready <= f0_ready_nx;
    end
end

assign f0_en = i_valid & i_ready & clk_en;
assign f0_nx = din;
generate
if (RAR_SUPPORT) begin : gen_f0_reset
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f0 <= {DW{1'b0}};
        end
        else if (f0_en) begin
            f0 <= f0_nx;
        end
    end
end
else begin : gen_f0
    always @(posedge clk) begin
        if (f0_en) begin
            f0 <= f0_nx;
        end
    end
end
endgenerate

assign f1_valid_set = f0_valid;
assign f1_valid_clr = (f0_valid ^ f1_valid) & o_ready;
assign f1_valid_nx = (f1_valid | f1_valid_set) & ~f1_valid_clr;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        f1_valid <= 1'b0;
    end
    else begin
        f1_valid <= f1_valid_nx;
    end
end

assign f1_en = f0_valid & ~f1_valid & ~o_ready 
             | f0_valid &  f1_valid &  o_ready
             ;
assign f1_nx = f0;
generate
if (RAR_SUPPORT) begin : gen_f1_reset
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f1 <= {DW{1'b0}};
        end
        else if (f1_en) begin
            f1 <= f1_nx;
        end
    end
end
else begin : gen_f1
    always @(posedge clk) begin
        if (f1_en) begin
            f1 <= f1_nx;
        end
    end
end
endgenerate

assign o_valid = f1_valid | f0_valid;
assign i_ready = f0_ready;
assign dout = f1_valid ? f1 : f0;

//------------------------------------
//assertions
//------------------------------------
`ifdef OVL_ASSERT_ON
// pragma coverage off
wire enq = i_valid & i_ready & clk_en;
wire deq = o_valid & o_ready;
ovl_multiport_fifo #(
    .severity_level (`OVL_FATAL ),
    .msg            (`__FILE__  ),
    .width          (DW         ),
    .depth          (2          ),
    .enq_count      (1          ),
    .deq_count      (1          ),
    .pass_thru      (0          ),
    .registered     (0          ),
    .full_check     (0          ),
    .empty_check    (0          ),
    .value_check    (0          )
) u_fifo_check (
    .clock(clk),
    .reset(resetn),
    .enable(1'b1),
    .enq(enq),
    .full(/*NC*/),
    .deq(deq),
    .empty(/*NC*/),
    .enq_data(din),
    .deq_data(dout),
    .fire(/*NC*/),
    .preload(1'b0)
);

// pragma coverage on
`endif // OVL_ASSERT_ON

endmodule

