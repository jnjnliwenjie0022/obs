// Copyright (C) 2019, Andes Technology Corp. Confidential Proprietary


`include "config.inc"
`include "global.inc"

module ieu_mdu_mul (
		  mul_out,
	`ifdef NDS_MAC_MUL_BOOTH
		  mdu_signed_ex,
		  mul_en,
		  mul_en_32b,
	`endif
		  mul_in0,
		  mul_in1
);

output	[63:0]	mul_out;

`ifdef	NDS_MAC_MUL_BOOTH
input		mdu_signed_ex;
input           mul_en;
input           mul_en_32b;
`endif
input	[31:0]	mul_in0;
input	[31:0]	mul_in1;

`ifdef	NDS_MAC_MUL_BOOTH
wire		ci0, ci2, ci4, ci6, ci8, ci10, ci12;
wire		ci14, ci16, ci18, ci20, ci22, ci24, ci26, ci28, ci30;
wire	[33:0]	pp_x0;
wire	[33:0]	pp_x2;
wire	[33:0]	pp_x4;
wire	[33:0]	pp_x6;
wire	[33:0]	pp_x8;
wire	[33:0]	pp_x10;
wire	[33:0]	pp_x12;
wire	[33:0]	pp_x14;
wire	[33:0]	pp_x16;
wire	[33:0]	pp_x18;
wire	[33:0]	pp_x20;
wire	[33:0]	pp_x22;
wire	[33:0]	pp_x24;
wire	[33:0]	pp_x26;
wire	[33:0]	pp_x28;
wire	[33:0]	pp_x30;

assign	pp_x0  = recode_pp_l(mul_en, mul_en_32b, {mul_in1[1:0],1'b0}, mdu_signed_ex, mul_in0);
assign	pp_x2  = recode_pp_l(mul_en, mul_en_32b, mul_in1[3:1],        mdu_signed_ex, mul_in0);
assign	pp_x4  = recode_pp_l(mul_en, mul_en_32b, mul_in1[5:3],        mdu_signed_ex, mul_in0);
assign	pp_x6  = recode_pp_l(mul_en, mul_en_32b, mul_in1[7:5],        mdu_signed_ex, mul_in0);
assign	pp_x8  = recode_pp_l(mul_en, mul_en_32b, mul_in1[9:7],        mdu_signed_ex, mul_in0);
assign	pp_x10 = recode_pp_l(mul_en, mul_en_32b, mul_in1[11:9],       mdu_signed_ex, mul_in0);
assign	pp_x12 = recode_pp_l(mul_en, mul_en_32b, mul_in1[13:11],      mdu_signed_ex, mul_in0);
assign	pp_x14 = recode_pp_l(mul_en, mul_en_32b, mul_in1[15:13],      mdu_signed_ex, mul_in0);
assign	pp_x16 = recode_pp_h(mul_en, mul_en_32b, {mul_in1[17:16], mul_en_32b & mul_in1[15]},     mdu_signed_ex, mul_in0);
assign	pp_x18 = recode_pp_h(mul_en, mul_en_32b, mul_in1[19:17],     mdu_signed_ex, mul_in0);
assign	pp_x20 = recode_pp_h(mul_en, mul_en_32b, mul_in1[21:19],     mdu_signed_ex, mul_in0);
assign	pp_x22 = recode_pp_h(mul_en, mul_en_32b, mul_in1[23:21],     mdu_signed_ex, mul_in0);
assign	pp_x24 = recode_pp_h(mul_en, mul_en_32b, mul_in1[25:23],     mdu_signed_ex, mul_in0);
assign	pp_x26 = recode_pp_h(mul_en, mul_en_32b, mul_in1[27:25],     mdu_signed_ex, mul_in0);
assign	pp_x28 = recode_pp_h(mul_en, mul_en_32b, mul_in1[29:27],     mdu_signed_ex, mul_in0);
assign	pp_x30 = recode_pp_h(mul_en, mul_en_32b, mul_in1[31:29],     mdu_signed_ex, mul_in0);

assign	ci0 = recode_cin(mul_en, {mul_in1[1:0],1'b0});
assign	ci2 = recode_cin(mul_en,  mul_in1[3:1]);
assign	ci4 = recode_cin(mul_en,  mul_in1[5:3]);
assign	ci6 = recode_cin(mul_en,  mul_in1[7:5]);
assign	ci8 = recode_cin(mul_en,  mul_in1[9:7]);
assign	ci10 = recode_cin(mul_en, mul_in1[11:9]);
assign	ci12 = recode_cin(mul_en, mul_in1[13:11]);
assign	ci14 = recode_cin(mul_en, mul_in1[15:13]);
assign	ci16 = recode_cin(mul_en, {mul_in1[17:16], mul_en_32b & mul_in1[15]});
assign	ci18 = recode_cin(mul_en, mul_in1[19:17]);
assign	ci20 = recode_cin(mul_en, mul_in1[21:19]);
assign	ci22 = recode_cin(mul_en, mul_in1[23:21]);
assign	ci24 = recode_cin(mul_en, mul_in1[25:23]);
assign	ci26 = recode_cin(mul_en, mul_in1[27:25]);
assign	ci28 = recode_cin(mul_en, mul_in1[29:27]);
assign	ci30 = recode_cin(mul_en, mul_in1[31:29]);


wire [31:0] pp_x32 = {32{~mdu_signed_ex & mul_in1[31] & mul_en}} & (mul_en_32b? mul_in0 : {mul_in0[31:16],16'b0});
wire [31:0] co_x1616 = mul_en_32b? 32'b0 : 32'b0;
wire [31:0] pp_x1616 = {32{~mdu_signed_ex & mul_in1[15] & mul_en}} & (mul_en_32b? 32'b0 : {16'b0, mul_in0[15:0]});

wire [31:0] mul32_sgn_ext = {
	1'b0,       1'b1, 1'b0,       1'b1,        1'b0,       1'b1,        1'b0,       1'b1,
	1'b0,       1'b1, 1'b0,       1'b1,        1'b0,       1'b1, ~mul_en_32b, mul_en_32b,
	1'b0, mul_en_32b, 1'b0, mul_en_32b,        1'b0, mul_en_32b,        1'b0, mul_en_32b,
	1'b0, mul_en_32b, 1'b0, mul_en_32b,        1'b0, mul_en_32b,  mul_en_32b,       1'b0
	};
wire [15:0] mul16l_sgn_ext = {
	1'b0, ~mul_en_32b, 1'b0, ~mul_en_32b,        1'b0, ~mul_en_32b,         1'b0, ~mul_en_32b,
	1'b0, ~mul_en_32b, 1'b0, ~mul_en_32b,        1'b0, ~mul_en_32b,  ~mul_en_32b,        1'b0
	};

wire [63:0] csa_l1a_0;
wire [63:0] csa_l1b_0;
wire [63:0] csa_l1c_0;
wire [63:0] csa_l1d_0;
wire [63:0] csa_l1e_0;
wire [63:0] csa_l1f_0;
wire [63:0] csa_l1a_1;
wire [63:0] csa_l1b_1;
wire [63:0] csa_l1c_1;
wire [63:0] csa_l1d_1;
wire [63:0] csa_l1e_1;
wire [63:0] csa_l1f_1;

assign {csa_l1a_1, csa_l1a_0} = csa64(
		{16'b0,
		  1'b0, ci30&~mul_en_32b, 1'b0, ci28&~mul_en_32b, 1'b0, ci26&~mul_en_32b, 1'b0, ci24&~mul_en_32b,
		  1'b0, ci22&~mul_en_32b, 1'b0, ci20&~mul_en_32b, 1'b0, ci18&~mul_en_32b, mul32_sgn_ext[1], ci16&~mul_en_32b|mul32_sgn_ext[0],
		  1'b0, ci30&mul_en_32b, 1'b0, ci28&mul_en_32b, 1'b0, ci26&mul_en_32b, 1'b0, ci24&mul_en_32b,
		  1'b0, ci22&mul_en_32b, 1'b0, ci20&mul_en_32b, 1'b0, ci18&mul_en_32b, 1'b0, ci16&mul_en_32b,
		  1'b0, ci14, 1'b0, ci12, 1'b0, ci10, 1'b0, ci8,
		  1'b0, ci6, 1'b0, ci4, 1'b0, ci2, 1'b0, ci0},
		{28'b0, mul32_sgn_ext[3:2], pp_x0},
		{26'b0, mul32_sgn_ext[5:4], pp_x2, 2'b00});
assign {csa_l1b_1, csa_l1b_0} = csa64(
	{24'b0, mul32_sgn_ext[7:6],   pp_x4, 4'b00},
	{22'b0, mul32_sgn_ext[9:8],   pp_x6, 6'b00},
	{20'b0, mul32_sgn_ext[11:10], pp_x8, 8'b00});
assign {csa_l1c_1, csa_l1c_0} = csa64(
	{18'b0, mul32_sgn_ext[13:12], pp_x10, 10'b00},
	{16'b0, mul32_sgn_ext[15:14], pp_x12, 12'b00},
	{14'b0, mul32_sgn_ext[17:16], pp_x14, 14'b00});
assign {csa_l1d_1, csa_l1d_0} = csa64(
	{12'b0, mul32_sgn_ext[19:18], pp_x16, 16'b00},
	{10'b0, mul32_sgn_ext[21:20], pp_x18, mul16l_sgn_ext[1:0], 16'b00},
	{ 8'b0, mul32_sgn_ext[23:22], pp_x20, mul16l_sgn_ext[3:2], 18'b00});
assign {csa_l1e_1, csa_l1e_0} = csa64(
	{ 6'b0, mul32_sgn_ext[25:24], pp_x22, mul16l_sgn_ext[5:4], 20'b00},
	{ 4'b0, mul32_sgn_ext[27:26], pp_x24, mul16l_sgn_ext[7:6], 22'b00},
	{ 2'b0, mul32_sgn_ext[29:28], pp_x26, mul16l_sgn_ext[9:8], 24'b00});
assign {csa_l1f_1, csa_l1f_0} = csa64(
	{       mul32_sgn_ext[31:30], pp_x28, mul16l_sgn_ext[11:10], 26'b00},
	{              pp_x30, mul16l_sgn_ext[13:12], 28'b00},
	{pp_x32[31:0],         mul16l_sgn_ext[15:14], 30'b00});
wire [63:0] csa_l2a_0;
wire [63:0] csa_l2a_1;
wire [63:0] csa_l2b_0;
wire [63:0] csa_l2b_1;
wire [63:0] csa_l2c_0;
wire [63:0] csa_l2c_1;
wire [63:0] csa_l2d_0;
wire [63:0] csa_l2d_1;

assign {csa_l2a_1, csa_l2a_0} = csa64(
	csa_l1a_0,
	csa_l1b_0,
	csa_l1c_0);
assign {csa_l2b_1, csa_l2b_0} = csa64(
	{csa_l1a_1[62:32], csa_l1a_1[31] & mul_en_32b, csa_l1a_1[30:0], 1'b0},
	{csa_l1b_1[62:32], csa_l1b_1[31] & mul_en_32b, csa_l1b_1[30:0], 1'b0},
	{csa_l1c_1[62:32], csa_l1c_1[31] & mul_en_32b, csa_l1c_1[30:0], 1'b0});
assign {csa_l2c_1, csa_l2c_0} = csa64(
	csa_l1d_0,
	csa_l1e_0,
	csa_l1f_0);
assign {csa_l2d_1, csa_l2d_0} = csa64(
	{csa_l1d_1[62:0],1'b0},
	{csa_l1e_1[62:0],1'b0},
	{csa_l1f_1[62:0],1'b0});


wire [63:0] csa_l3a_0;
wire [63:0] csa_l3a_1;
wire [63:0] csa_l3b_0;
wire [63:0] csa_l3b_1;
wire [63:0] csa_l3c_0;
wire [63:0] csa_l3c_1;
assign {csa_l3a_1, csa_l3a_0} = csa64(
	csa_l2a_0,
	csa_l2c_0,
	{16'b00, pp_x1616[31:0],16'b0});
assign {csa_l3b_1, csa_l3b_0} = csa64(
	csa_l2b_0,
	{csa_l2a_1[62:32],csa_l2a_1[31]&mul_en_32b,csa_l2a_1[30:0],1'b0},
	{csa_l2b_1[62:32],csa_l2b_1[31]&mul_en_32b,csa_l2b_1[30:0],1'b0});
assign {csa_l3c_1, csa_l3c_0} = csa64(
	{csa_l2c_1[62:0],1'b0},
	csa_l2d_0,
	{csa_l2d_1[62:0],1'b0});

wire [63:0] csa_l4a_0;
wire [63:0] csa_l4a_1;
wire [63:0] csa_l4b_0;
wire [63:0] csa_l4b_1;

assign {csa_l4a_1, csa_l4a_0} = csa64(
	csa_l3a_0,
	{csa_l3a_1[62:32],csa_l3a_1[31]&mul_en_32b,csa_l3a_1[30:0],1'b0},
	{csa_l3b_1[62:32],csa_l3b_1[31]&mul_en_32b,csa_l3b_1[30:0],1'b0});
assign {csa_l4b_1, csa_l4b_0} = csa64(
	csa_l3b_0,
	csa_l3c_0,
	{csa_l3c_1[62:0],1'b0});

wire [63:0] csa_l5a_0;
wire [63:0] csa_l5a_1;
assign {csa_l5a_1, csa_l5a_0} = csa64(
	csa_l4a_0,
	{csa_l4a_1[62:32],csa_l4a_1[31]&mul_en_32b,csa_l4a_1[30:0],1'b0},
	csa_l4b_0);

wire [63:0] csa_l6a_0;
wire [63:0] csa_l6a_1;
assign {csa_l6a_1, csa_l6a_0} = csa64(
	csa_l5a_0,
	{csa_l5a_1[62:32],csa_l5a_1[31]&mul_en_32b,csa_l5a_1[30:0],1'b0},
	{csa_l4b_1[62:32],csa_l4b_1[31]&mul_en_32b,csa_l4b_1[30:0],1'b0});

wire [64:0] csa_l7a_0 =
	{csa_l6a_0[63:32],                           mul_en_32b, csa_l6a_0[31:0]} +
	{csa_l6a_1[62:32], csa_l6a_1[31]&mul_en_32b,       1'b0, csa_l6a_1[30:0],1'b0};

assign mul_out = {csa_l7a_0[64:33],csa_l7a_0[31:0]};

wire unused_wire = csa_l1a_1[63] ^ csa_l1b_1[63] ^ csa_l1c_1[63] ^ csa_l1d_1[63] ^ csa_l1e_1[63] ^ csa_l1f_1[63] ^ csa_l2a_1[63] ^ csa_l2b_1[63] ^ csa_l2c_1[63] ^ csa_l2d_1[63] ^ csa_l3a_1[63] ^ csa_l3b_1[63] ^ csa_l3c_1[63] ^ csa_l4a_1[63] ^ csa_l5a_1[63] ^ csa_l4b_1[63] ^ csa_l6a_1[63] ^ csa_l7a_0[32];

`ifdef DEBUG
always @(mul_out) begin
	#1;
	$display("signed:%b mul_en:%b mul_en32:%b mul_in0:%08x mul_in1:%08x", mdu_signed_ex, mul_en, mul_en_32b, mul_in0, mul_in1);
	$display("%b %b pp_x0   %s",   {30'b0, pp_x0[33:32]},  {pp_x0[31:0]},         booth({mul_in1[1:0],1'b0}));
	$display("%b %b pp_x2   %s",   {28'b0, pp_x2[33:30]},  {pp_x2[29:0], 2'b00},  booth(mul_in1[3:1]));
	$display("%b %b pp_x4   %s",   {26'b0, pp_x4[33:28]},  {pp_x4[27:0], 4'b00},  booth(mul_in1[5:3]));
	$display("%b %b pp_x6   %s",   {24'b0, pp_x6[33:26]},  {pp_x6[25:0], 6'b00},  booth(mul_in1[7:5]));
	$display("%b %b pp_x8   %s",   {22'b0, pp_x8[33:24]},  {pp_x8[23:0], 8'b00},  booth(mul_in1[9:7]));
	$display("%b %b pp_x10  %s",  {20'b0, pp_x10[33:22]},  {pp_x10[21:0], 10'b00},booth(mul_in1[11:9]));
	$display("%b %b pp_x12  %s",  {18'b0, pp_x12[33:20]},  {pp_x12[19:0], 12'b00},booth(mul_in1[13:11]));
	$display("%b %b pp_x14  %s",  {16'b0, pp_x14[33:18]},  {pp_x14[17:0], 14'b00},booth(mul_in1[15:13]));
	$display("%b %b pp_x16. %s",  {14'b0, pp_x16[33:16]},  {pp_x16[15:0], 16'b00},booth({mul_in1[17:16], mul_en_32b&mul_in1[15]}));
	$display("%b %b pp_x18  %s",  {12'b0, pp_x18[33:14]},  {pp_x18[13:0], 18'b00},booth(mul_in1[19:17]));
	$display("%b %b pp_x20  %s",  {10'b0, pp_x20[33:12]},  {pp_x20[11:0], 20'b00},booth(mul_in1[21:19]));
	$display("%b %b pp_x22  %s",  { 8'b0, pp_x22[33:10]},  {pp_x22[9:0], 22'b00}, booth(mul_in1[23:21]));
	$display("%b %b pp_x24  %s",  { 6'b0, pp_x24[33:8]},   {pp_x24[7:0], 24'b00}, booth(mul_in1[25:23]));
	$display("%b %b pp_x26  %s",  { 4'b0, pp_x26[33:6]},   {pp_x26[5:0], 26'b00}, booth(mul_in1[27:25]));
	$display("%b %b pp_x28  %s",  { 2'b0, pp_x28[33:4]},   {pp_x28[3:0], 28'b00}, booth(mul_in1[29:27]));
	$display("%b %b pp_x30  %s",  { pp_x30[33:2]},         {pp_x30[1:0], 30'b00}, booth(mul_in1[31:29]));
	$display("");
	$display("%b %b pp_x32",  pp_x32[31:0], 32'b00);
	if (!mul_en_32b) begin
	$display("%b %b pp_x1616", {16'b0,pp_x1616[31:16]},       {pp_x1616[15:0], 16'b0});
	end
	$display("");

	if (mul_en_32b) begin
	$display("%b %b cixx",   mul32_sgn_ext, {1'b0, ci30, 1'b0, ci28, 1'b0, ci26, 1'b0, ci24, 1'b0, ci22, 1'b0, ci20, 1'b0, ci18, 1'b0, ci16, 1'b0, ci14, 1'b0, ci12, 1'b0, ci10, 1'b0, ci8, 1'b0, ci6, 1'b0, ci4, 1'b0, ci2, 1'b0, ci0});
	end
	else begin
	$display("%b %b cixx",   mul32_sgn_ext, {16'b0, 1'b0, ci14, 1'b0, ci12, 1'b0, ci10, 1'b0, ci8, 1'b0, ci6, 1'b0, ci4, 1'b0, ci2, 1'b0, ci0});
	$display("%b %b cixx_h",   {16'b0, 1'b0, ci30, 1'b0, ci28, 1'b0, ci26, 1'b0, ci24, 1'b0, ci22, 1'b0, ci20, 1'b0, ci18, 1'b0, ci16}, {mul16l_sgn_ext, 16'b0});

	end
	$display("");
	$display("%b %b mul_out", mul_out[63:32], mul_out[31:0]);
if (0) begin
	$display("");
	$display("%b %b csa_l1a_0\n", csa_l1a_0[63:32],  csa_l1a_0[31:0]);
	$display("%b %b csa_l1b_0\n", csa_l1b_0[63:32],  csa_l1b_0[31:0]);
	$display("%b %b csa_l1c_0\n", csa_l1c_0[63:32],  csa_l1c_0[31:0]);
	$display("%b %b csa_l1d_0\n", csa_l1d_0[63:32],  csa_l1d_0[31:0]);
	$display("%b %b csa_l1e_0\n", csa_l1e_0[63:32],  csa_l1e_0[31:0]);
	$display("%b %b csa_l1f_0\n", csa_l1f_0[63:32],  csa_l1f_0[31:0]);
	$display("%b %b csa_l1a_1\n", csa_l1a_1[62:31], {csa_l1a_1[30:0],1'b0});
	$display("%b %b csa_l1b_1\n", csa_l1b_1[62:31], {csa_l1b_1[30:0],1'b0});
	$display("%b %b csa_l1c_1\n", csa_l1c_1[62:31], {csa_l1c_1[30:0],1'b0});
	$display("%b %b csa_l1d_1\n", csa_l1d_1[62:31], {csa_l1d_1[30:0],1'b0});
	$display("%b %b csa_l1e_1\n", csa_l1e_1[62:31], {csa_l1e_1[30:0],1'b0});
	$display("%b %b csa_l1f_1\n", csa_l1f_1[62:31], {csa_l1f_1[30:0],1'b0});
	$display("");
	$display("%b %b csa_l2a_0\n", csa_l2a_0[63:32],  csa_l2a_0[31:0]);
	$display("%b %b csa_l2b_0\n", csa_l2b_0[63:32],  csa_l2b_0[31:0]);
	$display("%b %b csa_l2c_0\n", csa_l2c_0[63:32],  csa_l2c_0[31:0]);
	$display("%b %b csa_l2d_0\n", csa_l2d_0[63:32],  csa_l2d_0[31:0]);
	$display("%b %b csa_l2a_1\n", csa_l2a_1[62:31], {csa_l2a_1[30:0],1'b0});
	$display("%b %b csa_l2b_1\n", csa_l2b_1[62:31], {csa_l2b_1[30:0],1'b0});
	$display("%b %b csa_l2c_1\n", csa_l2c_1[62:31], {csa_l2c_1[30:0],1'b0});
	$display("%b %b csa_l2d_1\n", csa_l2d_1[62:31], {csa_l2d_1[30:0],1'b0});
	$display("");
	$display("%b %b csa_l3a_0\n", csa_l3a_0[63:32], csa_l3a_0[31:0]);
	$display("%b %b csa_l3b_0\n", csa_l3b_0[63:32], csa_l3b_0[31:0]);
	$display("%b %b csa_l3c_0\n", csa_l3c_0[63:32], csa_l3c_0[31:0]);
	$display("%b %b csa_l3a_1\n", csa_l3a_1[62:31], {csa_l3a_1[30:0],1'b0});
	$display("%b %b csa_l3b_1\n", csa_l3b_1[62:31], {csa_l3b_1[30:0],1'b0});
	$display("%b %b csa_l3c_1\n", csa_l3c_1[62:31], {csa_l3c_1[30:0],1'b0});
	$display("");
	$display("%b %b csa_l4a_0\n", csa_l4a_0[63:32], csa_l4a_0[31:0]);
	$display("%b %b csa_l4b_0\n", csa_l4b_0[63:32], csa_l4b_0[31:0]);
	$display("%b %b csa_l4b_1\n", csa_l4b_1[62:31], {csa_l4b_1[30:0],1'b0});
	$display("");
	$display("%b %b csa_l5a_0\n", csa_l5a_0[63:32], csa_l5a_0[31:0]);
	$display("%b %b csa_l5a_1\n", csa_l5a_1[62:31], {csa_l5a_1[30:0],1'b0});
	$display("%b %b csa_l6a_0\n", csa_l6a_0[63:32], csa_l6a_0[31:0]);
	$display("%b %b csa_l6a_1\n", csa_l6a_1[62:31], {csa_l6a_1[30:0],1'b0});
	$display("%b %b csa_l7a_0\n", csa_l7a_0[64:33], csa_l7a_0[31:0]);
end

end
function [3*8-1:0] booth;
input [2:0] partial_y;
begin
		case (partial_y)
		3'b000: booth = "0";
		3'b001: booth = "x";
		3'b010: booth = "x";
		3'b011: booth = "2x";
		3'b100: booth = "-2x";
		3'b101: booth = "-x";
		3'b110: booth = "-x";
		3'b111: booth = "0";
		endcase
end
endfunction
`endif


function [33:0] recode_pp_l;
input		mul_en;
input		mul_en_32b;
input	[2:0]	partial_y;
input		mdu_signed_ex;
input	[31:0]	mul_in0;

reg		signed_ext32;
reg		signed_ext16;
reg [33:0]	recode_pp;

begin
	recode_pp_l = 34'b0;
	recode_pp   = 34'b0;

	signed_ext32 = mdu_signed_ex & mul_in0[31];
	signed_ext16 = mdu_signed_ex & mul_in0[15];

	if (mul_en) begin
		case (partial_y)
		3'b000:	recode_pp = {                       2'b10,            14'b0, (mul_en_32b ?  2'b00          :   2'b10                      ),  16'b0};
		3'b001:	recode_pp = {~signed_ext32,  signed_ext32,   mul_in0[31:18], (mul_en_32b ?  mul_in0[17:16] : {~signed_ext16, signed_ext16}),  mul_in0[15:0]};
		3'b010:	recode_pp = {~signed_ext32,  signed_ext32,   mul_in0[31:18], (mul_en_32b ?  mul_in0[17:16] : {~signed_ext16, signed_ext16}),  mul_in0[15:0]};
		3'b011:	recode_pp = {~signed_ext32,   mul_in0[31],   mul_in0[30:17], (mul_en_32b ?  mul_in0[16]    :  ~signed_ext16               ),  mul_in0[15:0], 1'b0};
		3'b100:	recode_pp = { signed_ext32,  ~mul_in0[31],  ~mul_in0[30:17], (mul_en_32b ? ~mul_in0[16]    :   signed_ext16               ), ~mul_in0[15:0], 1'b1};
		3'b101:	recode_pp = { signed_ext32, ~signed_ext32,  ~mul_in0[31:18], (mul_en_32b ? ~mul_in0[17:16] : { signed_ext16,~signed_ext16}), ~mul_in0[15:0]};
		3'b110:	recode_pp = { signed_ext32, ~signed_ext32,  ~mul_in0[31:18], (mul_en_32b ? ~mul_in0[17:16] : { signed_ext16,~signed_ext16}), ~mul_in0[15:0]};
		3'b111:	recode_pp = {                       2'b10,            14'b0, (mul_en_32b ?  2'b00          :   2'b10                      ),  16'b0};
		endcase
		recode_pp_l = recode_pp & {{16{mul_en_32b}}, ~18'b0};
	end
	else begin
		recode_pp_l = 34'b0;
	end
end
endfunction

function [33:0] recode_pp_h;
input		mul_en;
input		mul_en_32b;
input	[2:0]	partial_y;
input		mdu_signed_ex;
input	[31:0]	mul_in0;

reg		signed_ext;
reg	[15:0]	in0_l;
reg	[15:0]	in0_l_n;

begin
	recode_pp_h = 34'b0;

	signed_ext = mdu_signed_ex & mul_in0[31];
	in0_l = mul_en_32b ? mul_in0[15:0] : 16'b0;
	in0_l_n = mul_en_32b ? ~mul_in0[15:0] : 16'b0;

	if (mul_en) begin
		case (partial_y)
		3'b000:	recode_pp_h = {1'b1, 33'b0};
		3'b001:	recode_pp_h = {~signed_ext, signed_ext, mul_in0[31:16], in0_l};
		3'b010:	recode_pp_h = {~signed_ext, signed_ext, mul_in0[31:16], in0_l};
		3'b011:	recode_pp_h = {~signed_ext,  mul_in0[31:16], in0_l, 1'b0};
		3'b100:	recode_pp_h = {signed_ext,  ~mul_in0[31:16], ~mul_in0[15]|~mul_en_32b, in0_l_n[14:0], mul_en_32b};
		3'b101:	recode_pp_h = {signed_ext,  ~signed_ext, ~mul_in0[31:16], in0_l_n};
		3'b110:	recode_pp_h = {signed_ext,  ~signed_ext, ~mul_in0[31:16], in0_l_n};
		3'b111:	recode_pp_h = {1'b1, 33'b0};
		endcase
	end
	else begin
		recode_pp_h = 34'b0;
	end
end
endfunction


function recode_cin;
input		mul_en;
input	[2:0]	partial_y;

begin
	recode_cin = mul_en & (partial_y == 3'b100 || partial_y == 3'b101 || partial_y == 3'b110);
end
endfunction

function [127:0] csa64;
input	[63:0] in0;
input	[63:0] in1;
input	[63:0] in2;
reg	[63:0] sum;
reg	[63:0] carry;
begin
	sum = in0 ^ in1 ^ in2;
	carry = in0 & in1 | in1 & in2 | in0 & in2;
	csa64 = {carry, sum};
end
endfunction

`else
assign	mul_out[63:0] = mul_in0[31:0] * mul_in1[31:0];
`endif

endmodule

