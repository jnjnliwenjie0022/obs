module atctlc2axi500_bypass_elastic_buffer (
    // VPERL: &PORTLIST;
    // VPERL_GENERATED_BEGIN
    	  clk,      
    	  resetn,   
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
input            i_valid;
output           i_ready;
input   [DW-1:0] din;
output           o_valid;
input            o_ready;
output  [DW-1:0] dout;

reg     [DW-1:0] data_r;
wire             data_r_en;
wire    [DW-1:0] data_r_nx;

reg              full;
wire             full_nx;

assign o_valid = full | i_valid;
assign i_ready = ~full;
assign dout    = full ? data_r : din;

assign full_nx = (full | i_valid) & ~o_ready;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        full <= 1'b0;
    end
    else begin
        full <= full_nx;
    end
end

assign data_r_en = i_valid & i_ready & ~o_ready;
assign data_r_nx = din;
generate
if (RAR_SUPPORT) begin : gen_data_r_reset
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            data_r <= {DW{1'b0}};
        end
        else if (data_r_en) begin
            data_r <= data_r_nx;
        end
    end
end
else begin : gen_data_r
    always @(posedge clk) begin
        if (data_r_en) begin
            data_r <= data_r_nx;
        end
    end
end
endgenerate

endmodule

