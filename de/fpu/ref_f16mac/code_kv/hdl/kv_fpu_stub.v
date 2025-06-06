`include "global.inc"
`include "local.inc"

module kv_fpu_stub(
        // VPERL: &PORTLIST;
        // VPERL_GENERATED_BEGIN
        	  core_clk, 
        	  core_reset_n,
        	  fpu_i0_ctrl,
        	  fpu_i0_valid,
        	  fpu_i0_stall,
        	  fpu_i0_frs1,
        	  fpu_i0_frs2,
        	  fpu_i0_frs3,
        	  fpu_i1_ctrl,
        	  fpu_i1_valid,
        	  fpu_i1_stall,
        	  fpu_i1_frs1,
        	  fpu_i1_frs2,
        	  fpu_i1_frs3,
        	  fpu_lx_stall,
        	  fdiv_kill,
        	  fpu_ipipe_standby_ready,
        	  fpu_ipipe_fdiv_standby_ready,
        	  fpu_fmis_result,
        	  fpu_fmv_result,
        	  fpu_fmac32_result,
        	  fpu_fmac64_result,
        	  fmis_flag_set,
        	  fmac_flag_set,
        	  fdiv_resp_result,
        	  fdiv_resp_valid,
        	  fdiv_resp_ready,
        	  fdiv_resp_tag,
        	  fdiv_resp_flag_set,
        	  fdiv_req_ready 
        // VPERL_GENERATED_END
);
parameter  FLEN          = 32; // DP=64, SP=32, none=0
parameter  XLEN          = 32; 
parameter  RAR_SUPPORT   = 1;

input			    core_clk;
input			    core_reset_n;

input  [`FPU_CTRL_BITS-1:0] fpu_i0_ctrl;
input                       fpu_i0_valid;
input                       fpu_i0_stall;
input 		     [63:0] fpu_i0_frs1;
input     	 [FLEN-1:0] fpu_i0_frs2;
input     	 [FLEN-1:0] fpu_i0_frs3;
input  [`FPU_CTRL_BITS-1:0] fpu_i1_ctrl;
input                       fpu_i1_valid;
input                       fpu_i1_stall;
input                [63:0] fpu_i1_frs1;
input            [FLEN-1:0] fpu_i1_frs2;
input            [FLEN-1:0] fpu_i1_frs3;
input 			    fpu_lx_stall;
input			    fdiv_kill;

output			    fpu_ipipe_standby_ready;	    
output			    fpu_ipipe_fdiv_standby_ready;

output		     [63:0] fpu_fmis_result;
output		     [63:0] fpu_fmv_result;
output		 [FLEN-1:0] fpu_fmac32_result;
output		 [FLEN-1:0] fpu_fmac64_result;

output		      [4:0]  fmis_flag_set;
output		      [4:0]  fmac_flag_set;

output		  [FLEN-1:0] fdiv_resp_result;
output		             fdiv_resp_valid;
input		             fdiv_resp_ready;
output		       [4:0] fdiv_resp_tag;
output		       [4:0] fdiv_resp_flag_set;
output			     fdiv_req_ready;

wire	nds_unused = (|fpu_i0_ctrl) | fpu_i0_valid | fpu_i0_stall | (|fpu_i0_frs1) | (|fpu_i0_frs2) | (|fpu_i0_frs3)
		   | (|fpu_i1_ctrl) | fpu_i1_valid | fpu_i1_stall | (|fpu_i1_frs1) | (|fpu_i1_frs2) | (|fpu_i1_frs3) 
		   | fpu_lx_stall | fdiv_kill
		   | fdiv_resp_ready
		   | core_clk
		   | core_reset_n
		   ;

assign fpu_ipipe_standby_ready = 1'b1;
assign fpu_ipipe_fdiv_standby_ready = 1'b1;
assign fpu_fmis_result = 64'b0;
assign fpu_fmv_result = 64'b0;
assign fpu_fmac32_result = {FLEN{1'b0}};
assign fpu_fmac64_result = {FLEN{1'b0}};
assign fmac_flag_set = 5'b0;
assign fmis_flag_set = 5'b0;

assign fdiv_resp_result = {FLEN{1'b0}};
assign fdiv_resp_valid  = 1'b0;
assign fdiv_resp_tag    = 5'b0;
assign fdiv_resp_flag_set = 5'b0;
assign fdiv_req_ready   = 1'b0;



endmodule
