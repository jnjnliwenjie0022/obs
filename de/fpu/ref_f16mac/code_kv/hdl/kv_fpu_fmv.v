`include "global.inc"
`include "local.inc"

module kv_fpu_fmv(
       // VPERL: &PORTLIST;
       // VPERL_GENERATED_BEGIN
          fmv_standby_ready,
	  fp_mode,
       	  f1_wdata, 
       	  f1_op1_data,
       	  f1_op2_data,
       	  f1_valid, 
       	  f1_sew,   
	  f1_ex_ctrl 
       // VPERL_GENERATED_END
);

parameter          FLEN = 64;

output		   fmv_standby_ready;
input		   fp_mode;
output      [63:0] f1_wdata;
input       [63:0] f1_op1_data;
input       [63:0] f1_op2_data;
input	           f1_valid;
input	     [2:0] f1_sew;
input	     [5:0] f1_ex_ctrl;


wire f1_sew_64_bit =  f1_sew[2];
wire f1_sew_32_bit =  f1_sew[1];
wire f1_sew_16_bit =  f1_sew[0];
wire nds_unused_f1_sew_8_bit  =  1'b0;
wire fp_dp_support = (FLEN == 64);
wire fp_sp_support = (FLEN == 32) | fp_dp_support;

wire f1_fmvf_instr   = (f1_ex_ctrl[4:0] == `FPU_FMVI2F_5B);
wire f1_fmvx_instr   = (f1_ex_ctrl[4:0] == `FPU_FMVF2I_5B);
wire f1_fsgnj_instr  = (f1_ex_ctrl[4:0] == `FPU_FSGNJ_5B);
wire f1_fsgnjn_instr = (f1_ex_ctrl[4:0] == `FPU_FSGNJN_5B);
wire f1_fsgnjx_instr = (f1_ex_ctrl[4:0] == `FPU_FSGNJX_5B);

wire f1_sgnj_sew16_instr  = f1_fsgnj_instr  & f1_sew_16_bit;
wire f1_sgnjn_sew16_instr = f1_fsgnjn_instr & f1_sew_16_bit;
wire f1_sgnjx_sew16_instr = f1_fsgnjx_instr & f1_sew_16_bit;
wire f1_sgnjb_instr  = f1_sgnj_sew16_instr  &  fp_mode;
wire f1_sgnjnb_instr = f1_sgnjn_sew16_instr &  fp_mode;
wire f1_sgnjxb_instr = f1_sgnjx_sew16_instr &  fp_mode;
wire f1_sgnjh_instr  = f1_sgnj_sew16_instr  & ~fp_mode;
wire f1_sgnjnh_instr = f1_sgnjn_sew16_instr & ~fp_mode;
wire f1_sgnjxh_instr = f1_sgnjx_sew16_instr & ~fp_mode;
wire f1_sgnj_instr   = f1_fsgnj_instr  & f1_sew_32_bit & fp_sp_support;
wire f1_sgnjn_instr  = f1_fsgnjn_instr & f1_sew_32_bit & fp_sp_support;
wire f1_sgnjx_instr  = f1_fsgnjx_instr & f1_sew_32_bit & fp_sp_support;
wire f1_sgnjd_instr  = f1_fsgnj_instr  & f1_sew_64_bit & fp_dp_support;
wire f1_sgnjnd_instr = f1_fsgnjn_instr & f1_sew_64_bit & fp_dp_support;
wire f1_sgnjxd_instr = f1_fsgnjx_instr & f1_sew_64_bit & fp_dp_support;

wire f1_op1_sp_nanb = (f1_sew_32_bit & (FLEN == 64) & (&f1_op1_data[63:32])) | (FLEN != 64);
wire f1_op2_sp_nanb = (f1_sew_32_bit & (FLEN == 64) & (&f1_op2_data[63:32])) | (FLEN != 64);
wire f1_op1_sew16_nanb = (f1_sew_16_bit & (FLEN == 64) & (&f1_op1_data[63:16]))
                       | (f1_sew_16_bit & (FLEN == 32) & (&f1_op1_data[31:16]))
		       ;
wire f1_op2_sew16_nanb = (f1_sew_16_bit & (FLEN == 64) & (&f1_op2_data[63:16]))
                    | (f1_sew_16_bit & (FLEN == 32) & (&f1_op2_data[31:16]))
		    ;
wire f1_op2_sign_sp = f1_op2_data[31] & f1_op2_sp_nanb;
wire f1_op2_sign_sew16 = f1_op2_data[15] & f1_op2_sew16_nanb;
			


assign f1_wdata	= {64{f1_sew_64_bit & (f1_fmvf_instr | f1_fmvx_instr)}} & {                                       f1_op1_data[63:0]} 
		| {64{f1_sew_32_bit & (f1_fmvf_instr | f1_fmvx_instr)}} & {{32{f1_fmvf_instr | f1_op1_data[31]}}, f1_op1_data[31:0]} 
		| {64{f1_sew_16_bit & (f1_fmvf_instr | f1_fmvx_instr)}} & {{48{f1_fmvf_instr | f1_op1_data[15]}}, f1_op1_data[15:0]} 
		| {64{f1_sgnjd_instr}}  & { f1_op2_data[63]                 , f1_op1_data[62:0]}
		| {64{f1_sgnjnd_instr}} & {~f1_op2_data[63]                 , f1_op1_data[62:0]}
		| {64{f1_sgnjxd_instr}} & {f1_op1_data[63] ^ f1_op2_data[63], f1_op1_data[62:0]}
		| {64{f1_sgnj_instr  &  f1_op1_sp_nanb}}  & {32'hffffffff,                    f1_op2_sign_sp, f1_op1_data[30:0]}
		| {64{f1_sgnjn_instr &  f1_op1_sp_nanb}}  & {32'hffffffff,                   ~f1_op2_sign_sp, f1_op1_data[30:0]}
		| {64{f1_sgnjx_instr &  f1_op1_sp_nanb}}  & {32'hffffffff,  f1_op1_data[31] ^ f1_op2_sign_sp, f1_op1_data[30:0]}
		| {64{f1_sgnj_instr  & ~f1_op1_sp_nanb}}  & {32'hffffffff,                    f1_op2_sign_sp, 31'h7fc00000}
		| {64{f1_sgnjn_instr & ~f1_op1_sp_nanb}}  & {32'hffffffff,                   ~f1_op2_sign_sp, 31'h7fc00000}
		| {64{f1_sgnjx_instr & ~f1_op1_sp_nanb}}  & {32'hffffffff,                    f1_op2_sign_sp, 31'h7fc00000}
		| {64{f1_sgnj_sew16_instr  &  f1_op1_sew16_nanb}} & {48'hffffffffffff,                    f1_op2_sign_sew16, f1_op1_data[14:0]}
		| {64{f1_sgnjn_sew16_instr &  f1_op1_sew16_nanb}} & {48'hffffffffffff,                   ~f1_op2_sign_sew16, f1_op1_data[14:0]}
		| {64{f1_sgnjx_sew16_instr &  f1_op1_sew16_nanb}} & {48'hffffffffffff,  f1_op1_data[15] ^ f1_op2_sign_sew16, f1_op1_data[14:0]}
		| {64{f1_sgnjh_instr  & ~f1_op1_sew16_nanb}} & {48'hffffffffffff,                    f1_op2_sign_sew16, 15'h7e00}
		| {64{f1_sgnjnh_instr & ~f1_op1_sew16_nanb}} & {48'hffffffffffff,                   ~f1_op2_sign_sew16, 15'h7e00}
		| {64{f1_sgnjxh_instr & ~f1_op1_sew16_nanb}} & {48'hffffffffffff,                    f1_op2_sign_sew16, 15'h7e00}
		| {64{f1_sgnjb_instr  & ~f1_op1_sew16_nanb}} & {48'hffffffffffff,                    f1_op2_sign_sew16, 15'h7fc0}
		| {64{f1_sgnjnb_instr & ~f1_op1_sew16_nanb}} & {48'hffffffffffff,                   ~f1_op2_sign_sew16, 15'h7fc0}
		| {64{f1_sgnjxb_instr & ~f1_op1_sew16_nanb}} & {48'hffffffffffff,                    f1_op2_sign_sew16, 15'h7fc0}
		;

assign fmv_standby_ready = ~f1_valid;

`ifdef OVL_ASSERT_ON
// pragma coverage off
// pragma coverage on
`endif // OVL_ASSERT_ON

endmodule
