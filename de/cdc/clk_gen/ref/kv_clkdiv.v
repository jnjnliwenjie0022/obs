module kv_clkdiv (
    // VPERL: &PORTLIST;
    // VPERL_GENERATED_BEGIN
    	  clk_in,   
    	  resetn,   
    	  clk_en,   
    	  clk_out   
    // VPERL_GENERATED_END
);

parameter RATIO = 2;

input  clk_in;
input  resetn;
output clk_en;
output clk_out;

reg  [RATIO-1:0] clk_r;
wire [RATIO-1:0] clk_r_nx;
reg  [RATIO-1:0] clk_en_r;
wire [RATIO-1:0] clk_en_r_nx;

assign clk_r_nx = {clk_r[RATIO-2:0], clk_r[RATIO-1]};
always @(posedge clk_in or negedge resetn) begin
    if (!resetn) begin
        clk_r = {{RATIO-(RATIO/2){1'b1}}, {(RATIO/2){1'b0}}};
    end
    else begin
        clk_r = clk_r_nx;
    end
end

assign clk_en_r_nx = {clk_en_r[RATIO-2:0], clk_en_r[RATIO-1]};
always @(posedge clk_in or negedge resetn) begin
    if (!resetn) begin
        clk_en_r <= {{(RATIO-1){1'b0}}, 1'b1};
    end
    else begin
        clk_en_r <= clk_en_r_nx;
    end
end

assign clk_en = clk_en_r[0];

`ifdef NDS_FPGA 
    BUFGCE  CLK_MUX_INST (
        .I  (clk_r[0]               ),
        .CE (1'b1                   ),
        .O  (clk_out                )
    );
`else
    assign clk_out = clk_r[0];
`endif

`ifdef OVL_ASSERT_ON
// pragma coverage off

reg qA;
reg qB;

always @(posedge clk_in or negedge resetn) begin
    if (!resetn) begin
        qA <= 1'b1;
    end
    else if(clk_en) begin
        qA <= qB;
    end
end

always @(posedge clk_out or negedge resetn) begin
    if (!resetn) begin
        qB <= 1'b0;
    end
    else begin
        qB <= qA;
    end
end

ovl_never #(
    .severity_level (`OVL_FATAL     ),
    .msg            (`__FILE__      )
) u_race_check (
    .clock          (clk_in         ),
    .reset          (resetn         ),
    .enable         (1'b1           ),
    .test_expr      (qA == qB       ),
    .fire           (               )
) ;

// pragma coverage on
`endif // OVL_ASSERT_ON

endmodule

