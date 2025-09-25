module atctlc2axi500_sink_id_ent(    
    // VPERL: &PORTLIST;
    // VPERL_GENERATED_BEGIN
    	  clk,      
    	  resetn,   
    	  enq_valid,
    	  rsp_valid,
    	  deq_valid,
    	  valid     
    // VPERL_GENERATED_END
);

parameter RAR_SUPPORT = 0;

input                   clk;
input                   resetn;
input                   enq_valid;
input                   rsp_valid;
input                   deq_valid;

output                  valid;

reg                 responded;
wire                responded_nx;
wire                responded_en;

reg                 acked;
wire                acked_nx;
wire                acked_en;

reg                 valid;
wire                valid_nx;
wire                valid_en;
wire                valid_set;
wire                valid_clr;

assign valid_en  = valid_set | valid_clr;
assign valid_set = enq_valid;
assign valid_clr = rsp_valid & valid & acked
                 | deq_valid & valid & responded
                 | rsp_valid & deq_valid
                 ;
assign valid_nx = (valid | valid_set) & ~valid_clr;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        valid <= 1'b0;
    end
    else if (valid_en) begin
        valid <= valid_nx;
    end
end

assign acked_en = enq_valid | deq_valid;
assign acked_nx = (acked & ~enq_valid) | deq_valid;
generate
if (RAR_SUPPORT) begin : gen_acked_reset
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            acked <= {1{1'b0}};
        end
        else if (acked_en) begin
            acked <= acked_nx;
        end
    end
end
else begin : gen_acked
    always @(posedge clk) begin
        if (acked_en) begin
            acked <= acked_nx;
        end
    end
end
endgenerate

assign responded_en = enq_valid | rsp_valid;
assign responded_nx = (responded & ~enq_valid) | rsp_valid;
generate
if (RAR_SUPPORT) begin : gen_responded_reset
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            responded <= {1{1'b0}};
        end
        else if (responded_en) begin
            responded <= responded_nx;
        end
    end
end
else begin : gen_responded
    always @(posedge clk) begin
        if (responded_en) begin
            responded <= responded_nx;
        end
    end
end
endgenerate

endmodule

