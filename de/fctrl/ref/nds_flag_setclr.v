//
// This module is to unify and simply the flag set/clr desgin
// parameter SET_OVER_CLR
//       0 (Default): clr higher than set
//       1          : set higher than clr
//
// Example usage:
//
// wire ii_fpu_vpu_instr_stall;
// generate
// if (RVV_SUPPORT == "yes") begin : gen_rvv
//      wire ii_fpu_vpu_instr_stall_set = lsu_ipipe_wb_fpu_stall_ii_after_replay;
//      wire ii_fpu_vpu_instr_stall_clr = lsu_ipipe_sb_empty | (ii_valid & ~instr_fpu_load);
//      nds_flag_setclr #(.SET_OVER_CLR(1))  ii_fpu_vpu_instr_stall_flag  (.clk(core_clk), .rstn(core_reset_n), .en(1'b1),
//                                     .set (ii_fpu_vpu_instr_stall_set),
//                                     .clr (ii_fpu_vpu_instr_stall_clr),
//                                     .flag(ii_fpu_vpu_instr_stall    ));
// else begin: gen_rvv_none
//      assign ii_fpu_vpu_instr_stall = 1'b0;
// end
// endgenerate
//

module nds_flag_setclr (
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  clk,      
        	  reset_n,  
        	  en,        // enable contition: update flag only when enable. Tie to 1'b1 if not used.
        	  set,       // set condition
        	  clr,       // clr contition
        	  flag       // flag register
        // VPERL_GENERATED_END
);
parameter SET_OVER_CLR = 0; // 0: clr higher than set
                            // 1: set higher than clr
parameter RESET_VALUE = 1'b0; // the default/reset value
parameter USE_EN_PIN = 1'b0; // 0: "en" input pin has no function
                             // 1: "en" input pin could control the FF(flag) enable

input  clk;
input  reset_n;
input  en;              // enable contition: update flag only when enable. Tie to 1'b1 if not used.
input  set;             //    set condition
input  clr;             //    clr contition
output flag;            //    flag register

reg  flag;
wire flag_nx = ((SET_OVER_CLR == 0) & ((set | flag) & ~clr )) | // clr take priority
               ((SET_OVER_CLR != 0) & ( set | (flag & ~clr))) ; // set take priority
generate
if (USE_EN_PIN) begin : gen_with_ff_en
        always @(posedge clk or negedge reset_n) begin
        	if (!reset_n) begin
        		flag <= RESET_VALUE;
                end
        	else if (en) begin
        		flag <= flag_nx;
                end
        end
end
else begin : gen_without_ff_en
        always @(posedge clk or negedge reset_n) begin
        	if (!reset_n) begin
        		flag <= RESET_VALUE;
                end
        	else begin
        		flag <= flag_nx;
                end
        end
        wire nds_unused_wire = en;
end
endgenerate

endmodule
