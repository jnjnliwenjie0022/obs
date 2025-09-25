//         ___                    
//        |   |                   
//      __|b_ |_   |    ___       
//     |  |   | |__|   |   |      
// ___\|  |___|    |__ |p_ |___\  
//    /|___________|   |   |   /  
//                 |   |___|      
//                 |              
//                                
module atctlc2axi500_elastic_buffer_o (
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

wire             p_i_valid;
wire             p_i_ready;
wire    [DW-1:0] p_din;
wire             p_o_valid;
wire             p_o_ready;
wire    [DW-1:0] p_dout;
reg     [DW-1:0] p_data;
wire             p_data_en;
wire    [DW-1:0] p_data_nx;
reg              p_full;
wire             p_full_nx;
wire             p_full_set;
wire             p_full_clr;

wire             b_i_valid;
wire             b_i_ready;
wire    [DW-1:0] b_din;
wire             b_o_valid;
wire             b_o_ready;
wire    [DW-1:0] b_dout;
reg     [DW-1:0] b_data;
wire             b_data_en;
wire    [DW-1:0] b_data_nx;
reg              b_full;
wire             b_full_nx;

assign p_o_valid = p_full;
assign p_i_ready = (~p_full | p_o_ready);
assign p_dout    = p_data;

assign p_full_set = clk_en & p_i_valid;
assign p_full_clr = clk_en & p_o_ready;
assign p_full_nx = (p_full & ~p_full_clr) | p_full_set;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        p_full <= 1'b0;
    end
    else begin
        p_full <= p_full_nx;
    end
end

assign p_data_en = p_i_valid & p_i_ready & clk_en;
assign p_data_nx = p_din;
generate
if (RAR_SUPPORT) begin : gen_p_data_reset
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            p_data <= {DW{1'b0}};
        end
        else if (p_data_en) begin
            p_data <= p_data_nx;
        end
    end
end
else begin : gen_p_data
    always @(posedge clk) begin
        if (p_data_en) begin
            p_data <= p_data_nx;
        end
    end
end
endgenerate

assign b_o_valid = b_full | b_i_valid;
assign b_i_ready = ~b_full;
assign b_dout    = b_full ? b_data : b_din;

assign b_full_nx = (b_full | b_i_valid) & ~b_o_ready;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        b_full <= 1'b0;
    end
    else begin
        b_full <= b_full_nx;
    end
end

assign b_data_en = b_i_valid & b_i_ready & ~b_o_ready;
assign b_data_nx = b_dout;
generate
if (RAR_SUPPORT) begin : gen_b_data_reset
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            b_data <= {DW{1'b0}};
        end
        else if (b_data_en) begin
            b_data <= b_data_nx;
        end
    end
end
else begin : gen_b_data
    always @(posedge clk) begin
        if (b_data_en) begin
            b_data <= b_data_nx;
        end
    end
end
endgenerate

assign b_i_valid = i_valid;
assign i_ready = b_i_ready;
assign b_din = din;

assign p_i_valid = b_o_valid;
assign b_o_ready = p_i_ready & clk_en;
assign p_din = b_dout;

assign o_valid = p_o_valid;
assign p_o_ready = o_ready;
assign dout = p_dout;

//------------------------------------
//assertions
//------------------------------------
`ifdef OVL_ASSERT_ON
// pragma coverage off
wire enq = i_valid & i_ready;
wire deq = o_valid & o_ready & clk_en;
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

