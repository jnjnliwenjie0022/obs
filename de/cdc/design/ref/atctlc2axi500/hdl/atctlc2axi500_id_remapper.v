module atctlc2axi500_id_remapper (
    // VPERL: &PORTLIST;
    // VPERL_GENERATED_BEGIN
    	  clk,      
    	  resetn,   
    	  us_grant, 
    	  us_id,    
    	  ds_grant, 
    	  ds_id,    
    	  ds2us_id, 
    	  next_id,  
    	  busy      
    // VPERL_GENERATED_END
);

parameter US_IDW = 4;
parameter DS_IDW = 4;
localparam DS_IDLEN = 1 << DS_IDW;

input                     clk;
input                     resetn;
input                     us_grant;
input        [US_IDW-1:0] us_id;
input                     ds_grant;
input        [DS_IDW-1:0] ds_id;
output       [US_IDW-1:0] ds2us_id; 
output       [DS_IDW-1:0] next_id;
output                    busy;

reg          [DS_IDW-1:0] cnt;
wire         [DS_IDW-1:0] cnt_inc;

reg        [DS_IDLEN-1:0] inflight;
wire       [DS_IDLEN-1:0] inflight_nx;
wire       [DS_IDLEN-1:0] inflight_set;
wire       [DS_IDLEN-1:0] inflight_clr;

wire       [DS_IDLEN-1:0] next_id_onehot;
wire       [DS_IDLEN-1:0] ds_id_onehot;

reg [DS_IDLEN*US_IDW-1:0] ent_source;

atctlc2axi500_bin2onehot #(.N(DS_IDLEN)) u_next_id_onehot(.out(next_id_onehot), .in(next_id));
atctlc2axi500_bin2onehot #(.N(DS_IDLEN)) u_ds_id_onehot  (.out(ds_id_onehot  ), .in(ds_id  ));

assign next_id = cnt;
assign busy = inflight[next_id];
assign ds2us_id = ent_source[ds_id*US_IDW+:US_IDW];

assign cnt_inc = cnt + {{(DS_IDW-1){1'b0}}, 1'b1};
always @(posedge clk or negedge resetn) begin
    if(!resetn)begin
        cnt <= {DS_IDW{1'b0}};
    end
    else if(us_grant)begin
        cnt <= cnt_inc;
    end
end

assign inflight_nx  = ~inflight_clr & (inflight | inflight_set);
assign inflight_set = {DS_IDLEN{us_grant}} & next_id_onehot;
assign inflight_clr = {DS_IDLEN{ds_grant}} & ds_id_onehot;
generate
genvar i;
for (i=0; i<DS_IDLEN; i=i+1) begin : gen_ent
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            inflight[i] <= 1'b0;
        end
        else begin
            inflight[i] <= inflight_nx[i];
        end
    end
    always @(posedge clk) begin
        if (inflight_set[i]) begin
            ent_source[i*US_IDW+:US_IDW] <= us_id;
        end
    end
end
endgenerate

endmodule

