module atctlc2axi500_sync_l2l ( 
    // VPERL: &PORTLIST;
    // VPERL_GENERATED_BEGIN
    	  resetn,   
    	  clk,      
    	  d,        
    	  q         
    // VPERL_GENERATED_END
);

parameter SYNC_STAGE = 2;
parameter RESET_VALUE = 1'b0;

input  resetn; 
input  clk;
input  d;
output q;

reg [SYNC_STAGE-1:0] d_r;

assign q = d_r[SYNC_STAGE-1];
always @(posedge clk or negedge resetn)begin
    if(!resetn)begin
        d_r <= {SYNC_STAGE{RESET_VALUE}};
    end
    else begin
        d_r <= {d_r[SYNC_STAGE-2:0], d};
    end
end

endmodule

