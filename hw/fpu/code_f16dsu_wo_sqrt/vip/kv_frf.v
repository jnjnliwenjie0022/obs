
module kv_frf(
	// VPERL: &PORTLIST;
	// VPERL_GENERATED_BEGIN
		  core_clk, 
		  core_reset_n,
		  rf_init,  
		  frf_raddr1,
		  frf_rdata1,
		  frf_raddr2,
		  frf_rdata2,
		  frf_raddr3,
		  frf_rdata3,
		  frf_raddr4,
		  frf_rdata4,
		  frf_we1,  
		  frf_waddr1,
		  frf_wdata1,
		  frf_wstatus1,
		  frf_we2,  
		  frf_waddr2,
		  frf_wdata2,
		  frf_wstatus2,
		  frf_we3,  
		  frf_waddr3,
		  frf_wdata3,
		  frf_wstatus3 
	// VPERL_GENERATED_END
);
parameter         FLEN = 64;
parameter         GPRNUM = 32;
// Inputs
input              core_clk;
input              core_reset_n;
input              rf_init;
//
input        [4:0] frf_raddr1;
output  [FLEN-1:0] frf_rdata1;
//
input        [4:0] frf_raddr2;
output  [FLEN-1:0] frf_rdata2;
//
input        [4:0] frf_raddr3;
output  [FLEN-1:0] frf_rdata3;
//
input        [4:0] frf_raddr4;
output  [FLEN-1:0] frf_rdata4;
//
input              frf_we1;
input        [4:0] frf_waddr1;
input   [FLEN-1:0] frf_wdata1;
input              frf_wstatus1;

input              frf_we2;
input        [4:0] frf_waddr2;
input   [FLEN-1:0] frf_wdata2;
input              frf_wstatus2;

input              frf_we3;
input        [4:0] frf_waddr3;
input   [FLEN-1:0] frf_wdata3;
input              frf_wstatus3;

//wire        [31:1] status = 31'd0;

wire	  [GPRNUM-1:0] frf_we_onehot;

wire  [GPRNUM-1:0] frf_we1_onehot;
wire  [GPRNUM-1:0] frf_we2_onehot;
wire  [GPRNUM-1:0] frf_we3_onehot;

//VPERL_BEGIN
//for (my $i=0; $i<32; $i++) {
//:reg       [FLEN-1:0] f%d;		::	$i
//}
//VPERL_END

// VPERL_GENERATED_BEGIN
reg       [FLEN-1:0] f0;
reg       [FLEN-1:0] f1;
reg       [FLEN-1:0] f2;
reg       [FLEN-1:0] f3;
reg       [FLEN-1:0] f4;
reg       [FLEN-1:0] f5;
reg       [FLEN-1:0] f6;
reg       [FLEN-1:0] f7;
reg       [FLEN-1:0] f8;
reg       [FLEN-1:0] f9;
reg       [FLEN-1:0] f10;
reg       [FLEN-1:0] f11;
reg       [FLEN-1:0] f12;
reg       [FLEN-1:0] f13;
reg       [FLEN-1:0] f14;
reg       [FLEN-1:0] f15;
reg       [FLEN-1:0] f16;
reg       [FLEN-1:0] f17;
reg       [FLEN-1:0] f18;
reg       [FLEN-1:0] f19;
reg       [FLEN-1:0] f20;
reg       [FLEN-1:0] f21;
reg       [FLEN-1:0] f22;
reg       [FLEN-1:0] f23;
reg       [FLEN-1:0] f24;
reg       [FLEN-1:0] f25;
reg       [FLEN-1:0] f26;
reg       [FLEN-1:0] f27;
reg       [FLEN-1:0] f28;
reg       [FLEN-1:0] f29;
reg       [FLEN-1:0] f30;
reg       [FLEN-1:0] f31;
// VPERL_GENERATED_END

wire    [FLEN-1:0] frf_f0_ft0 = f0;
wire    [FLEN-1:0] frf_f1_ft1 = f1;
wire    [FLEN-1:0] frf_f2_ft2 = f2;
wire    [FLEN-1:0] frf_f3_ft3 = f3;
wire    [FLEN-1:0] frf_f4_ft4 = f4;
wire    [FLEN-1:0] frf_f5_ft5 = f5;
wire    [FLEN-1:0] frf_f6_ft6 = f6;
wire    [FLEN-1:0] frf_f7_ft7 = f7;
wire    [FLEN-1:0] frf_f8_fs0 = f8;
wire    [FLEN-1:0] frf_f9_fs1 = f9;
wire    [FLEN-1:0] frf_f10_fa0 = f10;
wire    [FLEN-1:0] frf_f11_fa1 = f11;
wire    [FLEN-1:0] frf_f12_fa2 = f12;
wire    [FLEN-1:0] frf_f13_fa3 = f13;
wire    [FLEN-1:0] frf_f14_fa4 = f14;
wire    [FLEN-1:0] frf_f15_fa5 = f15;
wire    [FLEN-1:0] frf_f16_fa6 = f16;
wire    [FLEN-1:0] frf_f17_fa7 = f17;
wire    [FLEN-1:0] frf_f18_fs2 = f18;
wire    [FLEN-1:0] frf_f19_fs3 = f19;
wire    [FLEN-1:0] frf_f20_fs4 = f20;
wire    [FLEN-1:0] frf_f21_fs5 = f21;
wire    [FLEN-1:0] frf_f22_fs6 = f22;
wire    [FLEN-1:0] frf_f23_fs7 = f23;
wire    [FLEN-1:0] frf_f24_fs8 = f24;
wire    [FLEN-1:0] frf_f25_fs9 = f25;
wire    [FLEN-1:0] frf_f26_fs10 = f26;
wire    [FLEN-1:0] frf_f27_fs11 = f27;
wire    [FLEN-1:0] frf_f28_ft8  = f28;
wire    [FLEN-1:0] frf_f29_ft9  = f29;
wire    [FLEN-1:0] frf_f30_ft10 = f30;
wire    [FLEN-1:0] frf_f31_ft11 = f31;

wire	nds_unused_debug_signals = (|frf_f0_ft0)
                                 | (|frf_f1_ft1)
                                 | (|frf_f2_ft2)
                                 | (|frf_f3_ft3)
                                 | (|frf_f4_ft4)
                                 | (|frf_f5_ft5)
                                 | (|frf_f6_ft6)
                                 | (|frf_f7_ft7)
                                 | (|frf_f8_fs0)
                                 | (|frf_f9_fs1)
                                 | (|frf_f10_fa0)
                                 | (|frf_f11_fa1)
                                 | (|frf_f12_fa2)
                                 | (|frf_f13_fa3)
                                 | (|frf_f14_fa4)
                                 | (|frf_f15_fa5)
                                 | (|frf_f16_fa6)
                                 | (|frf_f17_fa7)
                                 | (|frf_f18_fs2)
                                 | (|frf_f19_fs3)
                                 | (|frf_f20_fs4)
                                 | (|frf_f21_fs5)
                                 | (|frf_f22_fs6)
                                 | (|frf_f23_fs7)
                                 | (|frf_f24_fs8)
                                 | (|frf_f25_fs9)
                                 | (|frf_f26_fs10)
                                 | (|frf_f27_fs11)
                                 | (|frf_f28_ft8)
                                 | (|frf_f29_ft9)
                                 | (|frf_f30_ft10)
                                 | (|frf_f31_ft11)
				 ;

// VPERL_BEGIN
//for ($i=0; $i<32; $i++) {
//:assign frf_we1_onehot[%d] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd%d);	:: $i, $i
//:assign frf_we2_onehot[%d] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd%d);	:: $i, $i
//:assign frf_we3_onehot[%d] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd%d);	:: $i, $i
//
//}
// VPERL_END

// VPERL_GENERATED_BEGIN
assign frf_we1_onehot[0] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd0);
assign frf_we2_onehot[0] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd0);
assign frf_we3_onehot[0] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd0);
assign frf_we1_onehot[1] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd1);
assign frf_we2_onehot[1] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd1);
assign frf_we3_onehot[1] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd1);
assign frf_we1_onehot[2] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd2);
assign frf_we2_onehot[2] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd2);
assign frf_we3_onehot[2] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd2);
assign frf_we1_onehot[3] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd3);
assign frf_we2_onehot[3] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd3);
assign frf_we3_onehot[3] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd3);
assign frf_we1_onehot[4] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd4);
assign frf_we2_onehot[4] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd4);
assign frf_we3_onehot[4] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd4);
assign frf_we1_onehot[5] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd5);
assign frf_we2_onehot[5] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd5);
assign frf_we3_onehot[5] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd5);
assign frf_we1_onehot[6] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd6);
assign frf_we2_onehot[6] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd6);
assign frf_we3_onehot[6] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd6);
assign frf_we1_onehot[7] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd7);
assign frf_we2_onehot[7] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd7);
assign frf_we3_onehot[7] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd7);
assign frf_we1_onehot[8] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd8);
assign frf_we2_onehot[8] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd8);
assign frf_we3_onehot[8] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd8);
assign frf_we1_onehot[9] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd9);
assign frf_we2_onehot[9] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd9);
assign frf_we3_onehot[9] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd9);
assign frf_we1_onehot[10] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd10);
assign frf_we2_onehot[10] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd10);
assign frf_we3_onehot[10] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd10);
assign frf_we1_onehot[11] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd11);
assign frf_we2_onehot[11] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd11);
assign frf_we3_onehot[11] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd11);
assign frf_we1_onehot[12] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd12);
assign frf_we2_onehot[12] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd12);
assign frf_we3_onehot[12] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd12);
assign frf_we1_onehot[13] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd13);
assign frf_we2_onehot[13] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd13);
assign frf_we3_onehot[13] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd13);
assign frf_we1_onehot[14] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd14);
assign frf_we2_onehot[14] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd14);
assign frf_we3_onehot[14] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd14);
assign frf_we1_onehot[15] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd15);
assign frf_we2_onehot[15] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd15);
assign frf_we3_onehot[15] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd15);
assign frf_we1_onehot[16] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd16);
assign frf_we2_onehot[16] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd16);
assign frf_we3_onehot[16] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd16);
assign frf_we1_onehot[17] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd17);
assign frf_we2_onehot[17] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd17);
assign frf_we3_onehot[17] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd17);
assign frf_we1_onehot[18] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd18);
assign frf_we2_onehot[18] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd18);
assign frf_we3_onehot[18] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd18);
assign frf_we1_onehot[19] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd19);
assign frf_we2_onehot[19] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd19);
assign frf_we3_onehot[19] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd19);
assign frf_we1_onehot[20] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd20);
assign frf_we2_onehot[20] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd20);
assign frf_we3_onehot[20] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd20);
assign frf_we1_onehot[21] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd21);
assign frf_we2_onehot[21] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd21);
assign frf_we3_onehot[21] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd21);
assign frf_we1_onehot[22] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd22);
assign frf_we2_onehot[22] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd22);
assign frf_we3_onehot[22] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd22);
assign frf_we1_onehot[23] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd23);
assign frf_we2_onehot[23] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd23);
assign frf_we3_onehot[23] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd23);
assign frf_we1_onehot[24] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd24);
assign frf_we2_onehot[24] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd24);
assign frf_we3_onehot[24] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd24);
assign frf_we1_onehot[25] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd25);
assign frf_we2_onehot[25] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd25);
assign frf_we3_onehot[25] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd25);
assign frf_we1_onehot[26] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd26);
assign frf_we2_onehot[26] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd26);
assign frf_we3_onehot[26] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd26);
assign frf_we1_onehot[27] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd27);
assign frf_we2_onehot[27] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd27);
assign frf_we3_onehot[27] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd27);
assign frf_we1_onehot[28] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd28);
assign frf_we2_onehot[28] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd28);
assign frf_we3_onehot[28] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd28);
assign frf_we1_onehot[29] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd29);
assign frf_we2_onehot[29] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd29);
assign frf_we3_onehot[29] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd29);
assign frf_we1_onehot[30] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd30);
assign frf_we2_onehot[30] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd30);
assign frf_we3_onehot[30] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd30);
assign frf_we1_onehot[31] =  frf_we1 & ~frf_wstatus1 & (frf_waddr1 == 5'd31);
assign frf_we2_onehot[31] =  frf_we2 & ~frf_wstatus2 & (frf_waddr2 == 5'd31);
assign frf_we3_onehot[31] =  frf_we3 & ~frf_wstatus3 & (frf_waddr3 == 5'd31);
// VPERL_GENERATED_END
//VPERL_BEGIN
//:
//for ($i=0; $i<32; $i++) {
//:\/\/ gen f%d ()	:: $i
//:wire [FLEN-1:0] f%d_nx = ({FLEN{frf_we1_onehot[%d]}} & frf_wdata1 )	:: $i, $i
//:                       | ({FLEN{frf_we2_onehot[%d]}} & frf_wdata2 ) :: $i, $i
//:                       | ({FLEN{frf_we3_onehot[%d]}} & frf_wdata3 ) :: $i, $i
//:                       ;
//
//:always @(posedge core_clk) begin
//:	if (frf_we_onehot[$i]) begin
//:		f%d <= f%d_nx;	:: $i, $i
//:	end
//:end
//:
//}
//:
//:reg [FLEN-1:0] frf_rdata1;
//:reg [FLEN-1:0] frf_rdata2;
//:reg [FLEN-1:0] frf_rdata3;
//:reg [FLEN-1:0] frf_rdata4;
//
//for (my $port=1; $port<=4; $port++) {
//:always @* begin
//:     case (frf_raddr$port\)
//for ($i=0; $i<32; $i++) {
//:	5'd%d:	frf_rdata$port = f%d;	::	$i, $i
//}
//:	`ifdef WITH_COV
//:	// pragma coverage off
//:	`endif	// WITH_COV
//:	default: frf_rdata$port = {FLEN{1'bx}};
//:	`ifdef WITH_COV
//:	// pragma coverage on
//:	`endif	// WITH_COV
//:	endcase
//:end
//}
//:

//VPERL_END

// VPERL_GENERATED_BEGIN

// gen f0 ()
wire [FLEN-1:0] f0_nx = ({FLEN{frf_we1_onehot[0]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[0]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[0]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[0]) begin
		f0 <= f0_nx;
	end
end

// gen f1 ()
wire [FLEN-1:0] f1_nx = ({FLEN{frf_we1_onehot[1]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[1]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[1]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[1]) begin
		f1 <= f1_nx;
	end
end

// gen f2 ()
wire [FLEN-1:0] f2_nx = ({FLEN{frf_we1_onehot[2]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[2]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[2]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[2]) begin
		f2 <= f2_nx;
	end
end

// gen f3 ()
wire [FLEN-1:0] f3_nx = ({FLEN{frf_we1_onehot[3]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[3]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[3]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[3]) begin
		f3 <= f3_nx;
	end
end

// gen f4 ()
wire [FLEN-1:0] f4_nx = ({FLEN{frf_we1_onehot[4]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[4]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[4]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[4]) begin
		f4 <= f4_nx;
	end
end

// gen f5 ()
wire [FLEN-1:0] f5_nx = ({FLEN{frf_we1_onehot[5]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[5]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[5]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[5]) begin
		f5 <= f5_nx;
	end
end

// gen f6 ()
wire [FLEN-1:0] f6_nx = ({FLEN{frf_we1_onehot[6]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[6]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[6]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[6]) begin
		f6 <= f6_nx;
	end
end

// gen f7 ()
wire [FLEN-1:0] f7_nx = ({FLEN{frf_we1_onehot[7]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[7]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[7]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[7]) begin
		f7 <= f7_nx;
	end
end

// gen f8 ()
wire [FLEN-1:0] f8_nx = ({FLEN{frf_we1_onehot[8]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[8]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[8]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[8]) begin
		f8 <= f8_nx;
	end
end

// gen f9 ()
wire [FLEN-1:0] f9_nx = ({FLEN{frf_we1_onehot[9]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[9]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[9]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[9]) begin
		f9 <= f9_nx;
	end
end

// gen f10 ()
wire [FLEN-1:0] f10_nx = ({FLEN{frf_we1_onehot[10]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[10]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[10]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[10]) begin
		f10 <= f10_nx;
	end
end

// gen f11 ()
wire [FLEN-1:0] f11_nx = ({FLEN{frf_we1_onehot[11]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[11]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[11]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[11]) begin
		f11 <= f11_nx;
	end
end

// gen f12 ()
wire [FLEN-1:0] f12_nx = ({FLEN{frf_we1_onehot[12]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[12]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[12]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[12]) begin
		f12 <= f12_nx;
	end
end

// gen f13 ()
wire [FLEN-1:0] f13_nx = ({FLEN{frf_we1_onehot[13]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[13]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[13]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[13]) begin
		f13 <= f13_nx;
	end
end

// gen f14 ()
wire [FLEN-1:0] f14_nx = ({FLEN{frf_we1_onehot[14]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[14]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[14]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[14]) begin
		f14 <= f14_nx;
	end
end

// gen f15 ()
wire [FLEN-1:0] f15_nx = ({FLEN{frf_we1_onehot[15]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[15]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[15]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[15]) begin
		f15 <= f15_nx;
	end
end

// gen f16 ()
wire [FLEN-1:0] f16_nx = ({FLEN{frf_we1_onehot[16]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[16]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[16]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[16]) begin
		f16 <= f16_nx;
	end
end

// gen f17 ()
wire [FLEN-1:0] f17_nx = ({FLEN{frf_we1_onehot[17]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[17]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[17]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[17]) begin
		f17 <= f17_nx;
	end
end

// gen f18 ()
wire [FLEN-1:0] f18_nx = ({FLEN{frf_we1_onehot[18]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[18]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[18]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[18]) begin
		f18 <= f18_nx;
	end
end

// gen f19 ()
wire [FLEN-1:0] f19_nx = ({FLEN{frf_we1_onehot[19]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[19]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[19]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[19]) begin
		f19 <= f19_nx;
	end
end

// gen f20 ()
wire [FLEN-1:0] f20_nx = ({FLEN{frf_we1_onehot[20]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[20]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[20]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[20]) begin
		f20 <= f20_nx;
	end
end

// gen f21 ()
wire [FLEN-1:0] f21_nx = ({FLEN{frf_we1_onehot[21]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[21]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[21]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[21]) begin
		f21 <= f21_nx;
	end
end

// gen f22 ()
wire [FLEN-1:0] f22_nx = ({FLEN{frf_we1_onehot[22]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[22]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[22]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[22]) begin
		f22 <= f22_nx;
	end
end

// gen f23 ()
wire [FLEN-1:0] f23_nx = ({FLEN{frf_we1_onehot[23]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[23]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[23]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[23]) begin
		f23 <= f23_nx;
	end
end

// gen f24 ()
wire [FLEN-1:0] f24_nx = ({FLEN{frf_we1_onehot[24]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[24]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[24]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[24]) begin
		f24 <= f24_nx;
	end
end

// gen f25 ()
wire [FLEN-1:0] f25_nx = ({FLEN{frf_we1_onehot[25]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[25]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[25]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[25]) begin
		f25 <= f25_nx;
	end
end

// gen f26 ()
wire [FLEN-1:0] f26_nx = ({FLEN{frf_we1_onehot[26]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[26]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[26]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[26]) begin
		f26 <= f26_nx;
	end
end

// gen f27 ()
wire [FLEN-1:0] f27_nx = ({FLEN{frf_we1_onehot[27]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[27]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[27]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[27]) begin
		f27 <= f27_nx;
	end
end

// gen f28 ()
wire [FLEN-1:0] f28_nx = ({FLEN{frf_we1_onehot[28]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[28]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[28]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[28]) begin
		f28 <= f28_nx;
	end
end

// gen f29 ()
wire [FLEN-1:0] f29_nx = ({FLEN{frf_we1_onehot[29]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[29]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[29]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[29]) begin
		f29 <= f29_nx;
	end
end

// gen f30 ()
wire [FLEN-1:0] f30_nx = ({FLEN{frf_we1_onehot[30]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[30]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[30]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[30]) begin
		f30 <= f30_nx;
	end
end

// gen f31 ()
wire [FLEN-1:0] f31_nx = ({FLEN{frf_we1_onehot[31]}} & frf_wdata1 )
                      | ({FLEN{frf_we2_onehot[31]}} & frf_wdata2 )
                      | ({FLEN{frf_we3_onehot[31]}} & frf_wdata3 )
                      ;
always @(posedge core_clk) begin
	if (frf_we_onehot[31]) begin
		f31 <= f31_nx;
	end
end


reg [FLEN-1:0] frf_rdata1;
reg [FLEN-1:0] frf_rdata2;
reg [FLEN-1:0] frf_rdata3;
reg [FLEN-1:0] frf_rdata4;
always @* begin
    case (frf_raddr1)
	5'd0:	frf_rdata1 = f0;
	5'd1:	frf_rdata1 = f1;
	5'd2:	frf_rdata1 = f2;
	5'd3:	frf_rdata1 = f3;
	5'd4:	frf_rdata1 = f4;
	5'd5:	frf_rdata1 = f5;
	5'd6:	frf_rdata1 = f6;
	5'd7:	frf_rdata1 = f7;
	5'd8:	frf_rdata1 = f8;
	5'd9:	frf_rdata1 = f9;
	5'd10:	frf_rdata1 = f10;
	5'd11:	frf_rdata1 = f11;
	5'd12:	frf_rdata1 = f12;
	5'd13:	frf_rdata1 = f13;
	5'd14:	frf_rdata1 = f14;
	5'd15:	frf_rdata1 = f15;
	5'd16:	frf_rdata1 = f16;
	5'd17:	frf_rdata1 = f17;
	5'd18:	frf_rdata1 = f18;
	5'd19:	frf_rdata1 = f19;
	5'd20:	frf_rdata1 = f20;
	5'd21:	frf_rdata1 = f21;
	5'd22:	frf_rdata1 = f22;
	5'd23:	frf_rdata1 = f23;
	5'd24:	frf_rdata1 = f24;
	5'd25:	frf_rdata1 = f25;
	5'd26:	frf_rdata1 = f26;
	5'd27:	frf_rdata1 = f27;
	5'd28:	frf_rdata1 = f28;
	5'd29:	frf_rdata1 = f29;
	5'd30:	frf_rdata1 = f30;
	5'd31:	frf_rdata1 = f31;
	`ifdef WITH_COV
	// pragma coverage off
	`endif	// WITH_COV
	default: frf_rdata1 = {FLEN{1'bx}};
	`ifdef WITH_COV
	// pragma coverage on
	`endif	// WITH_COV
	endcase
end
always @* begin
    case (frf_raddr2)
	5'd0:	frf_rdata2 = f0;
	5'd1:	frf_rdata2 = f1;
	5'd2:	frf_rdata2 = f2;
	5'd3:	frf_rdata2 = f3;
	5'd4:	frf_rdata2 = f4;
	5'd5:	frf_rdata2 = f5;
	5'd6:	frf_rdata2 = f6;
	5'd7:	frf_rdata2 = f7;
	5'd8:	frf_rdata2 = f8;
	5'd9:	frf_rdata2 = f9;
	5'd10:	frf_rdata2 = f10;
	5'd11:	frf_rdata2 = f11;
	5'd12:	frf_rdata2 = f12;
	5'd13:	frf_rdata2 = f13;
	5'd14:	frf_rdata2 = f14;
	5'd15:	frf_rdata2 = f15;
	5'd16:	frf_rdata2 = f16;
	5'd17:	frf_rdata2 = f17;
	5'd18:	frf_rdata2 = f18;
	5'd19:	frf_rdata2 = f19;
	5'd20:	frf_rdata2 = f20;
	5'd21:	frf_rdata2 = f21;
	5'd22:	frf_rdata2 = f22;
	5'd23:	frf_rdata2 = f23;
	5'd24:	frf_rdata2 = f24;
	5'd25:	frf_rdata2 = f25;
	5'd26:	frf_rdata2 = f26;
	5'd27:	frf_rdata2 = f27;
	5'd28:	frf_rdata2 = f28;
	5'd29:	frf_rdata2 = f29;
	5'd30:	frf_rdata2 = f30;
	5'd31:	frf_rdata2 = f31;
	`ifdef WITH_COV
	// pragma coverage off
	`endif	// WITH_COV
	default: frf_rdata2 = {FLEN{1'bx}};
	`ifdef WITH_COV
	// pragma coverage on
	`endif	// WITH_COV
	endcase
end
always @* begin
    case (frf_raddr3)
	5'd0:	frf_rdata3 = f0;
	5'd1:	frf_rdata3 = f1;
	5'd2:	frf_rdata3 = f2;
	5'd3:	frf_rdata3 = f3;
	5'd4:	frf_rdata3 = f4;
	5'd5:	frf_rdata3 = f5;
	5'd6:	frf_rdata3 = f6;
	5'd7:	frf_rdata3 = f7;
	5'd8:	frf_rdata3 = f8;
	5'd9:	frf_rdata3 = f9;
	5'd10:	frf_rdata3 = f10;
	5'd11:	frf_rdata3 = f11;
	5'd12:	frf_rdata3 = f12;
	5'd13:	frf_rdata3 = f13;
	5'd14:	frf_rdata3 = f14;
	5'd15:	frf_rdata3 = f15;
	5'd16:	frf_rdata3 = f16;
	5'd17:	frf_rdata3 = f17;
	5'd18:	frf_rdata3 = f18;
	5'd19:	frf_rdata3 = f19;
	5'd20:	frf_rdata3 = f20;
	5'd21:	frf_rdata3 = f21;
	5'd22:	frf_rdata3 = f22;
	5'd23:	frf_rdata3 = f23;
	5'd24:	frf_rdata3 = f24;
	5'd25:	frf_rdata3 = f25;
	5'd26:	frf_rdata3 = f26;
	5'd27:	frf_rdata3 = f27;
	5'd28:	frf_rdata3 = f28;
	5'd29:	frf_rdata3 = f29;
	5'd30:	frf_rdata3 = f30;
	5'd31:	frf_rdata3 = f31;
	`ifdef WITH_COV
	// pragma coverage off
	`endif	// WITH_COV
	default: frf_rdata3 = {FLEN{1'bx}};
	`ifdef WITH_COV
	// pragma coverage on
	`endif	// WITH_COV
	endcase
end
always @* begin
    case (frf_raddr4)
	5'd0:	frf_rdata4 = f0;
	5'd1:	frf_rdata4 = f1;
	5'd2:	frf_rdata4 = f2;
	5'd3:	frf_rdata4 = f3;
	5'd4:	frf_rdata4 = f4;
	5'd5:	frf_rdata4 = f5;
	5'd6:	frf_rdata4 = f6;
	5'd7:	frf_rdata4 = f7;
	5'd8:	frf_rdata4 = f8;
	5'd9:	frf_rdata4 = f9;
	5'd10:	frf_rdata4 = f10;
	5'd11:	frf_rdata4 = f11;
	5'd12:	frf_rdata4 = f12;
	5'd13:	frf_rdata4 = f13;
	5'd14:	frf_rdata4 = f14;
	5'd15:	frf_rdata4 = f15;
	5'd16:	frf_rdata4 = f16;
	5'd17:	frf_rdata4 = f17;
	5'd18:	frf_rdata4 = f18;
	5'd19:	frf_rdata4 = f19;
	5'd20:	frf_rdata4 = f20;
	5'd21:	frf_rdata4 = f21;
	5'd22:	frf_rdata4 = f22;
	5'd23:	frf_rdata4 = f23;
	5'd24:	frf_rdata4 = f24;
	5'd25:	frf_rdata4 = f25;
	5'd26:	frf_rdata4 = f26;
	5'd27:	frf_rdata4 = f27;
	5'd28:	frf_rdata4 = f28;
	5'd29:	frf_rdata4 = f29;
	5'd30:	frf_rdata4 = f30;
	5'd31:	frf_rdata4 = f31;
	`ifdef WITH_COV
	// pragma coverage off
	`endif	// WITH_COV
	default: frf_rdata4 = {FLEN{1'bx}};
	`ifdef WITH_COV
	// pragma coverage on
	`endif	// WITH_COV
	endcase
end

// VPERL_GENERATED_END

assign frf_we_onehot = frf_we1_onehot
                    | frf_we2_onehot
		    | frf_we3_onehot
                    | {(GPRNUM){rf_init}};	// synchronous reset for reducing ff area

`ifdef OVL_ASSERT_ON
// pragma coverage off
ovl_zero_one_hot #(
    .width  (3              ),
    .msg    (`__FILE__      )
) zu_ovl_tag_arb_grant1 (
    .clock          (core_clk       ),
    .reset          (core_reset_n   ),
    .enable         (1'b1           ),
    .test_expr      ({frf_we1_onehot[5], frf_we2_onehot[5], frf_we3_onehot[5]}),
    .fire           (               )
);
ovl_zero_one_hot #(
    .width  (3              ),
    .msg    (`__FILE__      )
) zu_ovl_tag_arb_grant2 (
    .clock          (core_clk       ),
    .reset          (core_reset_n   ),
    .enable         (1'b1           ),
    .test_expr      ({frf_we1_onehot[6], frf_we2_onehot[6], frf_we3_onehot[6]}),
    .fire           (               )
);
ovl_zero_one_hot #(
    .width  (3              ),
    .msg    (`__FILE__      )
) zu_ovl_tag_arb_grant3 (
    .clock          (core_clk       ),
    .reset          (core_reset_n   ),
    .enable         (1'b1           ),
    .test_expr      ({frf_we1_onehot[7], frf_we2_onehot[7], frf_we3_onehot[7]}),
    .fire           (               )
);
ovl_zero_one_hot #(
    .width  (3              ),
    .msg    (`__FILE__      )
) zu_ovl_tag_arb_grant4 (
    .clock          (core_clk       ),
    .reset          (core_reset_n   ),
    .enable         (1'b1           ),
    .test_expr      ({frf_we1_onehot[8], frf_we2_onehot[8], frf_we3_onehot[8]}),
    .fire           (               )
);
// pragma coverage on
`endif // OVL_ASSERT_ON
endmodule

