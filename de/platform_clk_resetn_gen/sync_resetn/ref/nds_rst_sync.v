module nds_rst_sync (
	// VPERL: &PORTLIST;
	// VPERL_GENERATED_BEGIN
		  test_mode,
		  test_resetn_in,
		  resetn_in, 
		  clk,      
		  resetn_out 
	// VPERL_GENERATED_END
);

localparam RESET_VALUE      = 1'b0;
parameter  RESET_SYNC_STAGE = 2;        // The RESET_SYNC_STAGE should be >= 2

input   test_mode;
input   test_resetn_in;
input   resetn_in;
input   clk;

output  resetn_out;

wire    resetn_out;
wire    resetn_sync;
wire    resetn_in_t;

reg [RESET_SYNC_STAGE-1:0]    resetn_sync_array;

assign resetn_in_t = test_mode ? test_resetn_in : resetn_in;

always @(posedge clk or negedge resetn_in_t) begin
	if (!resetn_in_t) begin
                resetn_sync_array <= {RESET_SYNC_STAGE{RESET_VALUE}};
        end
        else begin
                resetn_sync_array <= {resetn_sync_array[RESET_SYNC_STAGE-2:0], 1'b1};
        end
end

assign resetn_sync  = resetn_sync_array[RESET_SYNC_STAGE-1];

assign resetn_out = test_mode ? test_resetn_in : resetn_sync;

endmodule
