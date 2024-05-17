module vc_mdu(
	// VPERL: &PORTLIST;
	// VPERL_GENERATED_BEGIN
		  core_clk, 
		  core_reset_n,
		  mdu_req_valid,
		  mdu_req_index,
		  mdu_req_func,
		  mdu_req_op0,
		  mdu_req_op1,
		  mdu_req_ready,
		  mdu_kill, 
		  mdu_resp_valid,
		  mdu_resp_index,
		  mdu_resp_result,
		  mdu_resp_ready 
	// VPERL_GENERATED_END
);
parameter 			XLEN 		= 64;
parameter			MULTIPLIER      = "radix2";

localparam			MUL_DIGIT 	= (MULTIPLIER == "fast"   ) ? 1 :
						  (MULTIPLIER == "radix2" ) ? 1 :
                                                  (MULTIPLIER == "radix4" ) ? 2 :
                                                  (MULTIPLIER == "radix16") ? 4 : 8;
localparam 			CNT_BIT 	= (XLEN/32)+5;
localparam			MUL_PIPE	= (MUL_DIGIT > 4) | (XLEN == 64 && MUL_DIGIT > 2);
localparam 			MUL_END_CNT 	= (XLEN/MUL_DIGIT)-1;
localparam 			DIV_END_CNT 	= XLEN;
localparam 			ADDER_BIT 	= XLEN+MUL_DIGIT;



localparam	[2:0]		IDLE 		= 3'b000;
localparam	[2:0]		PRE 		= 3'b001;
localparam	[2:0]		EXE 		= 3'b010;
localparam	[2:0]		POST 		= 3'b011;
localparam	[2:0]		DONE 		= 3'b100;
localparam	[2:0]		DIV_SHIFT 	= 3'b101;
localparam	[2:0]		MUL_OPERAND 	= 3'b110;



localparam 			MDUOP_MUL	= 4'b0000;
localparam 			MDUOP_MULH	= 4'b0001;
localparam 			MDUOP_MULHSU	= 4'b0010;
localparam 			MDUOP_MULHU	= 4'b0011;
localparam 			MDUOP_DIV	= 4'b0100;
localparam 			MDUOP_DIVU	= 4'b0101;
localparam 			MDUOP_REM	= 4'b0110;
localparam 			MDUOP_REMU	= 4'b0111;

localparam 			MDUOP_MULW	= 4'b1000;
localparam 			MDUOP_DIVW	= 4'b1100;
localparam 			MDUOP_DIVUW	= 4'b1101;
localparam 			MDUOP_REMW	= 4'b1110;
localparam 			MDUOP_REMUW	= 4'b1111;
//in & out port
input           		core_clk;
input           		core_reset_n;

input           		mdu_req_valid;
input     [4:0] 		mdu_req_index;
input     [3:0] 		mdu_req_func;
input     [XLEN-1:0] 		mdu_req_op0;
input     [XLEN-1:0] 		mdu_req_op1;
output          		mdu_req_ready;
input				mdu_kill;

output          		mdu_resp_valid;
output    [4:0] 		mdu_resp_index;
output    [XLEN-1:0] 		mdu_resp_result;
input  				mdu_resp_ready;

reg	[2:0] 		state;
reg	[2:0] 		state_nx;
reg	[XLEN*2:0]	reg0;
wire    [XLEN*2:0]	reg0_nx;
wire                    reg0_en;
reg	[XLEN-1:0]	reg1;
wire	[XLEN-1:0]	reg1_nx;
wire                    reg1_en;
reg	[4:0]		index_reg;
reg	[3:0]		func_reg;
wire			overflow_nx;
reg			divide_by_zero;
reg			overflow;
reg	[CNT_BIT-1:0]	cnt;
wire			less;
reg 	[CNT_BIT-1:0]	div_shift_number;
wire	[CNT_BIT-1:0]	div_shift_number_nx;
wire	[ADDER_BIT-1:0]	adder_rs0;
wire	[ADDER_BIT-1:0]	adder_rs1;
wire	[ADDER_BIT-1:0]	adder_sum;
reg			neg_result;
reg			op0_signed;
reg			op0_msb;
reg			op1_signed;
reg			valid_d1;
reg	[ADDER_BIT-1:0]	rs1_mul;
wire			op1_eq_zero_nx;
wire	[XLEN*2:0]	reg0_req_nx;
wire	[XLEN-1:0]	reg1_req_nx;
wire			op0_need_2c_trans; 
wire			op1_need_2c_trans;

wire			mdu_req_in	= mdu_req_valid & mdu_req_ready & ~mdu_kill;
assign			mdu_resp_valid	= state == POST | state == DONE;
assign			mdu_req_ready	= state == IDLE;
assign			mdu_resp_index	= index_reg;
wire			mul_op		= ~func_reg[2];
wire			w_op		= func_reg[3];
wire			op0_signed_nx	= (mdu_req_func[2] & ~mdu_req_func[0])		//div 
					  | (mdu_req_func == MDUOP_MUL) | (mdu_req_func == MDUOP_MULH) | (mdu_req_func == MDUOP_MULHSU);
wire			op1_signed_nx	= (mdu_req_func[2] & ~mdu_req_func[0]) 		//div
					  | (mdu_req_func  == MDUOP_MUL) | (mdu_req_func == MDUOP_MULH) ;
wire			hi_result	= (func_reg[2] & func_reg[1]) 		//rem
					  | (func_reg == MDUOP_MULH) | (func_reg == MDUOP_MULHSU) | (func_reg == MDUOP_MULHU);
wire 			state_en = ~((state == IDLE) & ~mdu_req_in);
//wire			op0_need_2c_trans = op0_signed_nx & ((XLEN == 32 & mdu_req_op0[31]) | (XLEN == 64 & (mdu_req_op0[63] & ~mdu_req_func[3] | mdu_req_op0[31] & mdu_req_func[3])));
//wire			op1_need_2c_trans = op1_signed_nx & ((XLEN == 32 & mdu_req_op1[31]) | (XLEN == 64 & (mdu_req_op1[63] & ~mdu_req_func[3] | mdu_req_op1[31] & mdu_req_func[3])));
generate 
if (XLEN == 64) begin : gen_xlen64_div_special
	assign			overflow_nx	= ~mul_op & op0_signed & (reg0[63:0] == 64'h8000_0000_0000_0000) & (reg1[63:0] == 64'hFFFF_FFFF_FFFF_FFFF);
	assign 			op1_eq_zero_nx 	= ~mul_op & reg1[63:0] == 64'b0;
end
else begin : gen_xlen32_div_special
	assign			overflow_nx	= ~mul_op & op0_signed & (reg0[31:0] == 32'h8000_0000) & (reg1[31:0] == 32'hFFFF_FFFF);
	assign 			op1_eq_zero_nx 	= ~mul_op & reg1[31:0] == 32'b0;
end
endgenerate
generate
if (XLEN == 64) begin : gen_xlen64_req_nx
	assign	reg0_req_nx = mdu_req_func[3] ? {97'b0, mdu_req_op0[31:0]} : {65'b0,mdu_req_op0};
	assign	reg1_req_nx = mdu_req_func[3] ? {32'b0, mdu_req_op1[31:0]} : mdu_req_op1;
	assign	op0_need_2c_trans = op0_signed_nx & (mdu_req_op0[63] & ~mdu_req_func[3] | mdu_req_op0[31] & mdu_req_func[3]);
	assign	op1_need_2c_trans = op1_signed_nx & (mdu_req_op1[63] & ~mdu_req_func[3] | mdu_req_op1[31] & mdu_req_func[3]);
end //end gen_xlen64_req_nx
else begin: gen_xlen32_req_nx
	assign	reg0_req_nx = {33'b0,mdu_req_op0};
	assign	reg1_req_nx = mdu_req_op1;
	assign	op0_need_2c_trans = op0_signed_nx & mdu_req_op0[31];
	assign	op1_need_2c_trans = op1_signed_nx & mdu_req_op1[31];
end // end gen_xlen32_req_nx
endgenerate

//assign			mdu_resp_result	= reg0[XLEN-1:0];
//pre stage
wire	[XLEN*2-1:0]	reg0_neg;
wire	[XLEN-1:0]	reg1_neg;
wire	[XLEN*2:0]	reg0_pre_wop;
wire	[XLEN*2:0]	reg0_pre_nx;
wire	[XLEN-1:0]	reg1_pre_wop;
wire	[XLEN-1:0]	reg1_pre_nx;
wire			neg_rem;
wire			neg_mul;
wire			neg_quo;

generate 
if (XLEN == 64) begin :gen_xlen64_pre
	assign reg0_neg		= ~reg0[XLEN*2-1:0] + {{(XLEN*2-1){1'b0}},1'b1};
	assign reg1_neg		= ~reg1[63:0] + 64'b1;
	assign reg0_pre_wop	= reg0[31] ? {97'b0,reg0_neg[31:0]} : {97'b0,reg0[31:0]};
	assign reg0_pre_nx	= w_op  	? reg0_pre_wop :
			  	  reg0[63]	? {65'b0,reg0_neg[63:0]} : reg0[128:0];
	assign reg1_pre_wop	= reg1[31] ? {32'b0,reg1_neg[31:0]} : {32'b0,reg1[31:0]};
	assign reg1_pre_nx	= w_op		? reg1_pre_wop :
			  	  reg1[63]	? reg1_neg : reg1;
	assign neg_rem		= hi_result & ~mul_op & (w_op ? reg0[31] : reg0[63]);
	assign neg_mul		= mul_op & ((func_reg == MDUOP_MULHSU) ? reg0[63] : reg0[63] ^ reg1[63]);
	assign neg_quo		= ~hi_result & ~mul_op & (w_op ? reg0[31] ^ reg1[31] : reg0[63] ^ reg1[63]);
end
else begin : gen_xlen32_pre
	assign reg0_neg		= ~reg0[XLEN*2-1:0] + {{(XLEN*2-1){1'b0}},1'b1};
	assign reg1_neg		= ~reg1[31:0] + 32'b1;
	assign reg0_pre_wop	= 65'b0;
	assign reg1_pre_wop	= 32'b0;
	assign reg0_pre_nx	= reg0[31]	? {33'b0,reg0_neg[31:0]} : reg0[64:0];
	assign reg1_pre_nx	= reg1[31]	? reg1_neg : reg1;
	assign neg_rem		= hi_result & ~mul_op & reg0[31];
	assign neg_mul		= mul_op & ((func_reg == MDUOP_MULHSU) ? reg0[31] : reg0[31] ^ reg1[31]);
	assign neg_quo		= ~hi_result & ~mul_op & (reg0[31] ^ reg1[31]);
end
endgenerate

wire			neg_result_nx	= neg_rem | neg_mul | neg_quo;
//end pre stage
//div_shift stage
//op0/op1 leading zero detection 
wire [1:0] 	op0_lead_zero_detect_4_p[0:15];
wire 	 	op0_lead_zero_detect_4_v[0:15];
wire [1:0] 	op1_lead_zero_detect_4_p[0:15];
wire 	 	op1_lead_zero_detect_4_v[0:15];
wire [2:0] 	op0_lead_zero_detect_8_p[0:7];
wire 	 	op0_lead_zero_detect_8_v[0:7];
wire [2:0] 	op1_lead_zero_detect_8_p[0:7];
wire 	 	op1_lead_zero_detect_8_v[0:7];
wire [3:0] 	op0_lead_zero_detect_16_p[0:3];
wire 	 	op0_lead_zero_detect_16_v[0:3];
wire [3:0] 	op1_lead_zero_detect_16_p[0:3];
wire 	 	op1_lead_zero_detect_16_v[0:3];
wire [4:0] 	op0_lead_zero_detect_32_p[0:1];
wire 	 	op0_lead_zero_detect_32_v[0:1];
wire [4:0] 	op1_lead_zero_detect_32_p[0:1];
wire 	 	op1_lead_zero_detect_32_v[0:1];
wire [5:0] 	op0_lead_zero_detect_64_p;
wire 	 	op0_lead_zero_detect_64_v;
wire [5:0] 	op1_lead_zero_detect_64_p;
wire 	 	op1_lead_zero_detect_64_v;
wire [CNT_BIT-1:0] 	op0_leading_zero;
wire [CNT_BIT-1:0] 	op1_leading_zero;
generate 
genvar i;
genvar i_lzd4;
genvar i_lzd8;
genvar i_lzd16;
genvar i_lzd32;
for (i_lzd4 = 0; i_lzd4 < 16; i_lzd4 = i_lzd4+1) begin : gen_lzd4
	if ((XLEN == 32) & (i_lzd4 > 7)) begin : gen_gen_lzd4_block1
  		assign	op0_lead_zero_detect_4_p[i_lzd4][1] 	= 1'b0; 
		assign	op0_lead_zero_detect_4_p[i_lzd4][0] 	= 1'b0; 
		assign	op0_lead_zero_detect_4_v[i_lzd4] 	= 1'b0; 
		assign	op1_lead_zero_detect_4_p[i_lzd4][1] 	= 1'b0; 
		assign	op1_lead_zero_detect_4_p[i_lzd4][0] 	= 1'b0; 
		assign	op1_lead_zero_detect_4_v[i_lzd4] 	= 1'b0; 
	end
	else begin : gen_gen_lzd4_block2
  		assign	op0_lead_zero_detect_4_p[i_lzd4][1] 	=  ~reg0[i_lzd4*4+3] & ~reg0[i_lzd4*4+2];
		assign	op0_lead_zero_detect_4_p[i_lzd4][0] 	= (~reg0[i_lzd4*4+3] & ~reg0[i_lzd4*4+1]) | (~reg0[i_lzd4*4+3] & reg0[i_lzd4*4+2]);
		assign	op0_lead_zero_detect_4_v[i_lzd4] 	= |(reg0[i_lzd4*4+3:i_lzd4*4]);
		assign	op1_lead_zero_detect_4_p[i_lzd4][1] 	=  ~reg1[i_lzd4*4+3] & ~reg1[i_lzd4*4+2];
		assign	op1_lead_zero_detect_4_p[i_lzd4][0] 	= (~reg1[i_lzd4*4+3] & ~reg1[i_lzd4*4+1]) | (~reg1[i_lzd4*4+3] & reg1[i_lzd4*4+2]);
		assign	op1_lead_zero_detect_4_v[i_lzd4] 	= |(reg1[i_lzd4*4+3:i_lzd4*4]);
	end
end
endgenerate

generate
for (i_lzd8 = 0; i_lzd8 < 8; i_lzd8 = i_lzd8+1) begin : gen_lzd8
		assign	op0_lead_zero_detect_8_p[i_lzd8] 	= op0_lead_zero_detect_4_v[i_lzd8*2+1] ? {1'b0,op0_lead_zero_detect_4_p[i_lzd8*2+1]} : {1'b1,op0_lead_zero_detect_4_p[i_lzd8*2]};
		assign	op0_lead_zero_detect_8_v[i_lzd8] 	= op0_lead_zero_detect_4_v[i_lzd8*2+1] |  op0_lead_zero_detect_4_v[i_lzd8*2]; 
		assign	op1_lead_zero_detect_8_p[i_lzd8] 	= op1_lead_zero_detect_4_v[i_lzd8*2+1] ? {1'b0,op1_lead_zero_detect_4_p[i_lzd8*2+1]} : {1'b1,op1_lead_zero_detect_4_p[i_lzd8*2]};
		assign	op1_lead_zero_detect_8_v[i_lzd8] 	= op1_lead_zero_detect_4_v[i_lzd8*2+1] |  op1_lead_zero_detect_4_v[i_lzd8*2];
end
endgenerate

generate 
for (i_lzd16 = 0; i_lzd16 < 4; i_lzd16 = i_lzd16+1) begin : gen_lzd16
		assign	op0_lead_zero_detect_16_p[i_lzd16] 	= op0_lead_zero_detect_8_v[i_lzd16*2+1] ? {1'b0,op0_lead_zero_detect_8_p[i_lzd16*2+1]} : {1'b1,op0_lead_zero_detect_8_p[i_lzd16*2]};
		assign	op0_lead_zero_detect_16_v[i_lzd16] 	= op0_lead_zero_detect_8_v[i_lzd16*2+1] |  op0_lead_zero_detect_8_v[i_lzd16*2]; 
		assign	op1_lead_zero_detect_16_p[i_lzd16] 	= op1_lead_zero_detect_8_v[i_lzd16*2+1] ? {1'b0,op1_lead_zero_detect_8_p[i_lzd16*2+1]} : {1'b1,op1_lead_zero_detect_8_p[i_lzd16*2]};
		assign	op1_lead_zero_detect_16_v[i_lzd16] 	= op1_lead_zero_detect_8_v[i_lzd16*2+1] |  op1_lead_zero_detect_8_v[i_lzd16*2];
end
endgenerate

generate
for (i_lzd32 = 0; i_lzd32 < 2; i_lzd32 = i_lzd32+1) begin : gen_lzd32
		assign	op0_lead_zero_detect_32_p[i_lzd32] 	= op0_lead_zero_detect_16_v[i_lzd32*2+1] ? {1'b0,op0_lead_zero_detect_16_p[i_lzd32*2+1]} : {1'b1,op0_lead_zero_detect_16_p[i_lzd32*2]};
		assign	op0_lead_zero_detect_32_v[i_lzd32] 	= op0_lead_zero_detect_16_v[i_lzd32*2+1] |  op0_lead_zero_detect_16_v[i_lzd32*2]; 
		assign	op1_lead_zero_detect_32_p[i_lzd32] 	= op1_lead_zero_detect_16_v[i_lzd32*2+1] ? {1'b0,op1_lead_zero_detect_16_p[i_lzd32*2+1]} : {1'b1,op1_lead_zero_detect_16_p[i_lzd32*2]};
		assign	op1_lead_zero_detect_32_v[i_lzd32] 	= op1_lead_zero_detect_16_v[i_lzd32*2+1] |  op1_lead_zero_detect_16_v[i_lzd32*2];
end
endgenerate

assign	op0_lead_zero_detect_64_p 		= op0_lead_zero_detect_32_v[1] ? {1'b0,op0_lead_zero_detect_32_p[1]} : {1'b1,op0_lead_zero_detect_32_p[0]};
assign	op0_lead_zero_detect_64_v 		= op0_lead_zero_detect_32_v[1] |  op0_lead_zero_detect_32_v[0]; 
assign	op1_lead_zero_detect_64_p 		= op1_lead_zero_detect_32_v[1] ? {1'b0,op1_lead_zero_detect_32_p[1]} : {1'b1,op1_lead_zero_detect_32_p[0]};
assign	op1_lead_zero_detect_64_v 		= op1_lead_zero_detect_32_v[1] |  op1_lead_zero_detect_32_v[0];



generate
if (XLEN == 64) begin : gen_xlen64_lead_zero_detect
	assign op0_leading_zero = op0_lead_zero_detect_64_v ? {1'b0,op0_lead_zero_detect_64_p} : 7'd64;
	assign op1_leading_zero = op1_lead_zero_detect_64_v ? {1'b0,op1_lead_zero_detect_64_p} : 7'd64;
	assign div_shift_number_nx = (op0_leading_zero > op1_leading_zero) ? 7'd64 : 7'd64 - op1_leading_zero + op0_leading_zero;
end
else begin : gen_xlen32_lead_zero_detect
	assign op0_leading_zero = op0_lead_zero_detect_32_v[0] ? {1'b0,op0_lead_zero_detect_32_p[0]} : 6'd32;
	assign op1_leading_zero = op1_lead_zero_detect_32_v[0] ? {1'b0,op1_lead_zero_detect_32_p[0]} : 6'd32;
	assign div_shift_number_nx = (op0_leading_zero > op1_leading_zero) ? 6'd32 : 6'd32 - op1_leading_zero + op0_leading_zero;
end 	
endgenerate

//end of op0/op1 lead_zero_detect_
wire	[XLEN-1:0]	reg1_dshift_nx = reg1_neg; 
//end div_shift stage
//mul_operand stage
wire	[ADDER_BIT-1:0]	rs1_mul_multiplier_in;	
generate
if (MUL_DIGIT == 1) begin : gen_mul_operand_digit_1
	reg	rs1_mul_multiplier;
	always @(posedge core_clk or negedge core_reset_n) begin
		if (!core_reset_n)
			rs1_mul_multiplier <= 1'b0;
		else if (mdu_req_in)
			rs1_mul_multiplier <= mdu_req_op0[0];
		else if (state == PRE)
			rs1_mul_multiplier <= reg0_pre_nx[0];
		else if (state == MUL_OPERAND )
			rs1_mul_multiplier <= reg0[1];
		else if (state == EXE )
			rs1_mul_multiplier <= reg0[2];
	end
	assign	rs1_mul_multiplier_in = {{(ADDER_BIT-MUL_DIGIT){1'b0}},rs1_mul_multiplier};	
	assign	adder_rs0 = reg0[XLEN*2:XLEN];
end
else begin : gen_mul_operand_digit_2_4_8
	reg	[MUL_DIGIT-1:0]	rs1_mul_multiplier;
	always @(posedge core_clk or negedge core_reset_n) begin
		if (!core_reset_n)
			rs1_mul_multiplier <= {(MUL_DIGIT){1'b0}};
		else if (mdu_req_in)
			rs1_mul_multiplier <= mdu_req_op0[MUL_DIGIT-1:0];
		else if (state == PRE)
			rs1_mul_multiplier <= reg0_pre_nx[MUL_DIGIT-1:0];
		else if (state == MUL_OPERAND )
			rs1_mul_multiplier <= reg0[MUL_DIGIT*2-1:MUL_DIGIT];
		else if (state == EXE )
			rs1_mul_multiplier <= reg0[MUL_DIGIT*3-1:MUL_DIGIT*2];
	end
	assign	rs1_mul_multiplier_in = {{(ADDER_BIT-MUL_DIGIT){1'b0}},rs1_mul_multiplier};	
	assign	adder_rs0 = {{(MUL_DIGIT-1){1'b0}},reg0[XLEN*2:XLEN]};
end
endgenerate
wire	[ADDER_BIT-1:0]	rs1_mul_nx = rs1_mul_multiplier_in * reg1[XLEN-1:0];
//end mul_operand stage
//exe stage
	//adder
wire	[ADDER_BIT-1:0]	rs1_div = {{(MUL_DIGIT){1'b1}},reg1};	
assign	adder_rs1 = mul_op ? rs1_mul : rs1_div;
assign	adder_sum = adder_rs0 + adder_rs1;
assign	less	  = adder_sum[ADDER_BIT-1];
	//end adder
wire	[XLEN-1:0]	reg0_exe_div_dbz;
wire	[XLEN-1:0]	reg0_exe_div_overf;
wire	[XLEN*2:0]	reg0_exe_special;

generate
if (XLEN == 64) begin : gen_xlen64_exe
	assign	reg0_exe_div_dbz	= hi_result ? 
					(w_op & op0_signed & op0_msb) 		? {{32{reg0_neg[31]}},reg0_neg[31:0]} :
					(w_op)					? {{32{reg0[31]}},reg0[31:0]} :
					(op0_signed & op0_msb) 		? reg0_neg[XLEN-1:0] : reg0[63:0] : {(XLEN){1'b1}};
	assign	reg0_exe_div_overf	= hi_result ? 64'b0 : {1'b1,63'b0}; //rem = 0, q = -2**(XLEN-1)
	assign	reg0_exe_special 	= divide_by_zero ? {65'b0, reg0_exe_div_dbz} : {65'b0,reg0_exe_div_overf};
end
else begin : gen_xlen32_exe
	assign	reg0_exe_div_dbz	= hi_result ? 
					(op0_signed & op0_msb) ? reg0_neg[31:0] : reg0[31:0] : {(XLEN){1'b1}};
	assign	reg0_exe_div_overf	= hi_result ? 32'b0 : {1'b1,31'b0}; //rem = 0, q = -2**(XLEN-1)
	assign	reg0_exe_special 	= divide_by_zero ? {33'b0, reg0_exe_div_dbz} : {33'b0, reg0_exe_div_overf};
end
endgenerate
wire	[XLEN*2:0]		reg0_shift	= reg0 << div_shift_number;
wire	[XLEN*2:0]		reg0_exe_nx	= (divide_by_zero | overflow)	? reg0_exe_special :
					  	( ~mul_op && cnt == {(CNT_BIT){1'b0}}) 	? reg0_shift :
					  	(mul_op) 		    	? {1'b0,adder_sum[ADDER_BIT-1:0],reg0[XLEN-1:MUL_DIGIT]} :
					  	less				? {reg0[XLEN*2-1:0],~less} : {adder_sum[XLEN-1:0],reg0[XLEN-1:0],~less};
//end exe stage
//post stage
wire	[XLEN*2-1:0]	reg0_post_neg;
wire	[XLEN-1:0]	reg0_post_rem_w;
wire	[XLEN-1:0]	reg0_post_quo_w;
wire	[XLEN-1:0]	reg0_post_quo_neg;
wire	[XLEN-1:0]	reg0_post_rem_neg;
wire	[XLEN-1:0]	reg0_post_product;
wire	[XLEN-1:0]	reg0_post_div;
wire	[XLEN-1:0]	reg0_post_swap;
wire	[XLEN*2:0]	reg0_post_nx;

generate
if (XLEN == 64) begin : gen_xlen64_post
	assign	reg0_post_neg		= reg0_neg;
	assign	reg0_post_quo_neg 	= reg0_neg[63:0];
	assign	reg0_post_rem_neg 	= ~reg0[128:65] + 64'b1;
	assign  reg0_post_rem_w		= neg_result ? {{32{reg0_post_rem_neg[31]}},reg0_post_rem_neg[31:0]} : {{32{reg0[96]}}, reg0[96:65]};
	assign  reg0_post_quo_w		= neg_result ? {{32{reg0_neg[31]}},reg0_neg[31:0]} : {{32{reg0[31]}}, reg0[31:0]};
	assign	reg0_post_product 	= hi_result 	? 
			    		neg_result 	? reg0_post_neg[127:64] : reg0[127:64] :
	    				w_op		? {{32{reg0[31]}}, reg0[31:0]} :
	    				neg_result 	? reg0_neg[63:0]	: reg0[63:0];
	assign	reg0_post_div		= hi_result 	? 
					w_op ? reg0_post_rem_w : neg_result ? reg0_post_rem_neg : reg0[128:65] :
		    			w_op ? reg0_post_quo_w : neg_result ? reg0_post_quo_neg : reg0[63:0];
	assign	reg0_post_swap		= mul_op ? reg0_post_product : reg0_post_div;
	assign	reg0_post_nx		= {reg0[128:64],reg0_post_swap};
end
else begin : gen_xlen32_post
	assign	reg0_post_neg		= reg0_neg;
	assign	reg0_post_quo_neg 	= reg0_neg[31:0];
	assign	reg0_post_rem_neg 	= ~reg0[64:33] + 32'b1;
	assign	reg0_post_product 	= hi_result 	? 
			    		neg_result 	? reg0_post_neg[63:32] : reg0[63:32] :
	    				neg_result 	? reg0_neg[31:0]	: reg0[31:0];
	assign	reg0_post_div		= hi_result ? 
				    	neg_result ? reg0_post_rem_neg : reg0[64:33] :
		    			neg_result ? reg0_post_quo_neg : reg0[31:0];
	assign	reg0_post_swap		= mul_op ? reg0_post_product : reg0_post_div;
	assign	reg0_post_nx		= {reg0[64:32],reg0_post_swap};
	assign  reg0_post_rem_w		= 32'b0;
	assign  reg0_post_quo_w		= 32'b0;
	wire    nds_unused_wire_xlen32  = w_op | (|reg0_pre_wop) | (|reg1_pre_wop) | (|op1_lead_zero_detect_64_p) | op1_lead_zero_detect_64_v 
					| (|reg0_post_rem_w) | (|reg0_post_quo_w) | (|op0_lead_zero_detect_64_p) | op0_lead_zero_detect_64_v; 
end
endgenerate
//end post stage
assign			mdu_resp_result	= (state == DONE) ? reg0[XLEN-1:0] : reg0_post_nx[XLEN-1:0];



always @* begin
	if(mdu_kill)
		state_nx = IDLE;
	else begin
		case (state)
		PRE: begin
				state_nx = mul_op ?  MUL_OPERAND : DIV_SHIFT;
		end
		MUL_OPERAND: begin
				state_nx = EXE;
		end
		DIV_SHIFT: begin
				state_nx = EXE;
		end
		EXE: begin
			if (divide_by_zero || overflow)
				state_nx = DONE;
			else if (mul_op && (cnt == MUL_END_CNT[(CNT_BIT-1):0]))
				state_nx = POST;
			else if (cnt == DIV_END_CNT[(CNT_BIT-1):0])
				state_nx = POST;
			else
				state_nx = EXE;
		end
		POST: begin
			if (mdu_resp_ready)
				state_nx = IDLE;
			else
				state_nx = DONE;
		end
		DONE: begin
			if (mdu_resp_ready)
				state_nx = IDLE;
			else
				state_nx = DONE;
		end
		IDLE: begin
			if (mdu_req_in)
				state_nx = (op0_need_2c_trans | op1_need_2c_trans)	? PRE : 
					   ~mdu_req_func[2] 	     		? MUL_OPERAND : DIV_SHIFT;
			else 
				state_nx = IDLE;
		end
		`ifdef WITH_COV
		// pragma coverage off
		`endif	// WITH_COV
		default: state_nx = 3'bx;
		`ifdef WITH_COV
		// pragma coverage on
		`endif	// WITH_COV
		endcase
	end
end

always @(posedge core_clk or negedge core_reset_n) begin
	if (!core_reset_n)
		state <= IDLE;
	else if (state_en)
		state <= state_nx;
end
always @(posedge core_clk or negedge core_reset_n) begin
	if (!core_reset_n) begin
		index_reg <= 5'b0;
		func_reg  <= 4'b0;
	end
	else if (mdu_req_valid & mdu_req_ready) begin
		index_reg <= mdu_req_index;
		func_reg  <= mdu_req_func;
	end
end

always @(posedge core_clk) begin
	if (reg0_en)
		reg0 <= reg0_nx;
end

assign reg0_en = (state == PRE )
               | (state == EXE )
	       | (state == POST)
	       | (mdu_req_valid & mdu_req_ready)
	       ;

assign reg0_nx = ({(2*XLEN+1){(state == PRE )}} & reg0_pre_nx )
               | ({(2*XLEN+1){(state == EXE )}} & reg0_exe_nx )
               | ({(2*XLEN+1){(state == POST)}} & reg0_post_nx)
               | ({(2*XLEN+1){(state == IDLE)}} & reg0_req_nx )
	       ;

always @(posedge core_clk) begin
	if (reg1_en)
		reg1 <= reg1_nx;
end

assign reg1_nx = ({XLEN{(state == PRE      )}} & reg1_pre_nx )
               | ({XLEN{(state == DIV_SHIFT)}} & reg1_dshift_nx)
               | ({XLEN{(state == IDLE     )}} & reg1_req_nx )
	       ;
assign reg1_en = ((state == PRE      ) & op1_signed)
               |  (state == DIV_SHIFT)
	       | (mdu_req_valid & mdu_req_ready)
	       ;

always @(posedge core_clk or negedge core_reset_n) begin
	if (!core_reset_n)
		divide_by_zero <= 1'b0;
	else if (valid_d1)
		divide_by_zero <= op1_eq_zero_nx; 
end
always @(posedge core_clk or negedge core_reset_n) begin
	if (!core_reset_n)
		overflow <= 1'b0;
	else if (valid_d1)
		overflow <= overflow_nx; 
end

always @(posedge core_clk or negedge core_reset_n) begin
	if (!core_reset_n)
		div_shift_number <= {(CNT_BIT){1'b0}};
	else if (state == DIV_SHIFT )
		div_shift_number <= div_shift_number_nx;
end
always @(posedge core_clk or negedge core_reset_n) begin
	if (!core_reset_n)
		cnt <= {(CNT_BIT){1'b0}};
	else if (mdu_req_in)
		cnt <= {(CNT_BIT){1'b0}};
	else if (state == EXE && ~mul_op && cnt == {(CNT_BIT){1'b0}})
		cnt <= div_shift_number;
	else if (state == EXE)
		cnt <= cnt + {{(CNT_BIT-1){1'b0}},1'b1};
end
always @(posedge core_clk or negedge core_reset_n) begin
	if (!core_reset_n)
		neg_result <= 1'b0;
	else if (mdu_req_in)
		neg_result <= 1'b0;
	else if (state == PRE)
		neg_result <= neg_result_nx;
end
always @(posedge core_clk or negedge core_reset_n) begin
	if (!core_reset_n) begin
		op0_signed <= 1'b0;
		op1_signed <= 1'b0;
	end
	else if (mdu_req_in) begin
		op0_signed <= op0_signed_nx;
		op1_signed <= op1_signed_nx;
	end
end
always @(posedge core_clk or negedge core_reset_n) begin
	if (!core_reset_n)
		valid_d1 <= 1'b0;
	else if (mdu_req_in)
		valid_d1 <= 1'b1;
	else
		valid_d1 <= 1'b0;
end
always @(posedge core_clk) begin
	if (state == MUL_OPERAND || state == EXE)
		rs1_mul <= rs1_mul_nx;
end

generate
if (XLEN == 64) begin : gen_xlen64_msb
	always @(posedge core_clk or negedge core_reset_n) begin
		if (!core_reset_n)
			op0_msb <= 1'b0;
		else if (mdu_req_in)
			op0_msb <= mdu_req_func[3] ? mdu_req_op0[31] : mdu_req_op0[63];
		else 
			op0_msb <= op0_msb;
	end
end
else begin : gen_xlen32_msb
	always @(posedge core_clk or negedge core_reset_n) begin
		if (!core_reset_n)
			op0_msb <= 1'b0;
		else if (mdu_req_in)
			op0_msb <= mdu_req_op0[31];
		else 
			op0_msb <= op0_msb;
	end
end
endgenerate
endmodule
