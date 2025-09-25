module kv_ilm_ram (
	// VPERL: &PORTLIST;
	// VPERL_GENERATED_BEGIN
		  clk,      
		  ilm_cs,   
		  ilm_we,   
		  ilm_byte_we,
		  ilm_addr, 
		  ilm_wdata,
		  ilm_rdata 
	// VPERL_GENERATED_END
);
parameter ILM_RAM_AW = 10;
parameter ILM_RAM_DW = 64;
parameter ILM_RAM_BWEW = 8;

localparam ILM_DW           = ILM_RAM_BWEW*8;
localparam ILM_DATA_MSB     = ILM_DW-1; 
localparam ILM_DATA_LSB     = 0;

input                       clk;
input                       ilm_cs;
input                       ilm_we;
input    [ILM_RAM_BWEW-1:0] ilm_byte_we;
input      [ILM_RAM_AW-1:0] ilm_addr;
input      [ILM_RAM_DW-1:0] ilm_wdata;
output     [ILM_RAM_DW-1:0] ilm_rdata;

wire                        ilm_word_we = ilm_we;
wire       [ILM_RAM_DW-1:0] ilm_bit_we;


generate
if (ILM_RAM_DW == 32) begin : gen_ilm_bit_we_32
	assign ilm_bit_we = {{8{ilm_byte_we[3]}}, {8{ilm_byte_we[2]}}, {8{ilm_byte_we[1]}}, {8{ilm_byte_we[0]}}};
end
endgenerate

generate
if (ILM_RAM_DW == 64) begin : gen_ilm_bit_we_64
	assign ilm_bit_we = {{8{ilm_byte_we[7]}}, {8{ilm_byte_we[6]}}, {8{ilm_byte_we[5]}}, {8{ilm_byte_we[4]}},
	                     {8{ilm_byte_we[3]}}, {8{ilm_byte_we[2]}}, {8{ilm_byte_we[1]}}, {8{ilm_byte_we[0]}}};
end
endgenerate


//VPERL_BEGIN
//for ($aw=8; $aw<=11; $aw++) {
//my $depth = 1<<$aw;
//my $mux = ($depth <= 256) ? 4 : 8;
//
//foreach $dw (32, 64) {
//
//my $use_two_32 = ($dw == 64) && (($depth == 2048) || ($depth == 1024));
//
//:generate
//:if ((ILM_RAM_AW==%d) && (ILM_RAM_DW==${dw})) begin : gen_ram_%dx%d :: $aw, 1<<$aw, $dw
//
//if ($use_two_32) {
//
//:	tsmc22ullhvt${depth}x32 ram_inst0 (
//:	     .CLK    (clk			),
//:	.ME	(ilm_cs			),
//:	.WE	(ilm_word_we		),
//:	.WEM	(ilm_bit_we[31:0]		),
//:	.ADR	(ilm_addr			),
//:	     .D      (ilm_wdata[31:0]		),
//:	     .Q      (ilm_rdata[31:0]		),
//:	.LS	(1'b0),
//:	.RME	(1'b1),
//:	.RM	(4'b0010),
//:		.TEST1	(1'b0),
//:		.WA	(3'b110),
//:		.WPULSE	(3'b000),
//:		.DS	(1'b0),
//:		.SD	(1'b0)
//:	);
//:	tsmc22ullhvt${depth}x32 ram_inst1 (
//:	     .CLK    (clk			),
//:	.ME	(ilm_cs			),
//:	.WE	(ilm_word_we		),
//:	.WEM	(ilm_bit_we[63:32]	),
//:	.ADR	(ilm_addr			),
//:	     .D      (ilm_wdata[63:32]		),
//:	     .Q      (ilm_rdata[63:32]		),
//:	.LS	(1'b0),
//:	.RME	(1'b1),
//:	.RM	(4'b0010),
//:		.TEST1	(1'b0),
//:		.WA	(3'b110),
//:		.WPULSE	(3'b000),
//:		.DS	(1'b0),
//:		.SD	(1'b0)
//:	);
//
//}
//else {
//
//:	tsmc22ullhvt${depth}x${dw} ram_inst (
//:	     .CLK    (clk			),
//:	.ME	(ilm_cs			),
//:	.WE	(ilm_word_we		),
//:	.WEM	(ilm_bit_we[%d:0]		),	::	${dw}-1
//:	.ADR	(ilm_addr			),
//:	     .D      (ilm_wdata[%d:0]		),	::	${dw}-1
//:	     .Q      (ilm_rdata[%d:0]		),	::	${dw}-1
//:	.LS	(1'b0),
//:	.RME	(1'b1),
//:	.RM	(4'b0010),
//:		.TEST1	(1'b0),
//:		.WA	(3'b110),
//:		.WPULSE	(3'b000),
//:		.DS	(1'b0),
//:		.SD	(1'b0)
//:	);
//
//}
//
//:end
//:endgenerate
//:
//}
//}
//VPERL_END

// VPERL_GENERATED_BEGIN
generate
if ((ILM_RAM_AW==8) && (ILM_RAM_DW==32)) begin : gen_ram_256x32
	tsmc22ullhvt256x32 ram_inst (
	     .CLK    (clk			),
	.ME	(ilm_cs			),
	.WE	(ilm_word_we		),
	.WEM	(ilm_bit_we[31:0]		),
	.ADR	(ilm_addr			),
	     .D      (ilm_wdata[31:0]		),
	     .Q      (ilm_rdata[31:0]		),
	.LS	(1'b0),
	.RME	(1'b1),
	.RM	(4'b0010),
		.TEST1	(1'b0),
		.WA	(3'b110),
		.WPULSE	(3'b000),
		.DS	(1'b0),
		.SD	(1'b0)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==8) && (ILM_RAM_DW==64)) begin : gen_ram_256x64
	tsmc22ullhvt256x64 ram_inst (
	     .CLK    (clk			),
	.ME	(ilm_cs			),
	.WE	(ilm_word_we		),
	.WEM	(ilm_bit_we[63:0]		),
	.ADR	(ilm_addr			),
	     .D      (ilm_wdata[63:0]		),
	     .Q      (ilm_rdata[63:0]		),
	.LS	(1'b0),
	.RME	(1'b1),
	.RM	(4'b0010),
		.TEST1	(1'b0),
		.WA	(3'b110),
		.WPULSE	(3'b000),
		.DS	(1'b0),
		.SD	(1'b0)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==9) && (ILM_RAM_DW==32)) begin : gen_ram_512x32
	tsmc22ullhvt512x32 ram_inst (
	     .CLK    (clk			),
	.ME	(ilm_cs			),
	.WE	(ilm_word_we		),
	.WEM	(ilm_bit_we[31:0]		),
	.ADR	(ilm_addr			),
	     .D      (ilm_wdata[31:0]		),
	     .Q      (ilm_rdata[31:0]		),
	.LS	(1'b0),
	.RME	(1'b1),
	.RM	(4'b0010),
		.TEST1	(1'b0),
		.WA	(3'b110),
		.WPULSE	(3'b000),
		.DS	(1'b0),
		.SD	(1'b0)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==9) && (ILM_RAM_DW==64)) begin : gen_ram_512x64
	tsmc22ullhvt512x64 ram_inst (
	     .CLK    (clk			),
	.ME	(ilm_cs			),
	.WE	(ilm_word_we		),
	.WEM	(ilm_bit_we[63:0]		),
	.ADR	(ilm_addr			),
	     .D      (ilm_wdata[63:0]		),
	     .Q      (ilm_rdata[63:0]		),
	.LS	(1'b0),
	.RME	(1'b1),
	.RM	(4'b0010),
		.TEST1	(1'b0),
		.WA	(3'b110),
		.WPULSE	(3'b000),
		.DS	(1'b0),
		.SD	(1'b0)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==10) && (ILM_RAM_DW==32)) begin : gen_ram_1024x32
	tsmc22ullhvt1024x32 ram_inst (
	     .CLK    (clk			),
	.ME	(ilm_cs			),
	.WE	(ilm_word_we		),
	.WEM	(ilm_bit_we[31:0]		),
	.ADR	(ilm_addr			),
	     .D      (ilm_wdata[31:0]		),
	     .Q      (ilm_rdata[31:0]		),
	.LS	(1'b0),
	.RME	(1'b1),
	.RM	(4'b0010),
		.TEST1	(1'b0),
		.WA	(3'b110),
		.WPULSE	(3'b000),
		.DS	(1'b0),
		.SD	(1'b0)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==10) && (ILM_RAM_DW==64)) begin : gen_ram_1024x64
	tsmc22ullhvt1024x32 ram_inst0 (
	     .CLK    (clk			),
	.ME	(ilm_cs			),
	.WE	(ilm_word_we		),
	.WEM	(ilm_bit_we[31:0]		),
	.ADR	(ilm_addr			),
	     .D      (ilm_wdata[31:0]		),
	     .Q      (ilm_rdata[31:0]		),
	.LS	(1'b0),
	.RME	(1'b1),
	.RM	(4'b0010),
		.TEST1	(1'b0),
		.WA	(3'b110),
		.WPULSE	(3'b000),
		.DS	(1'b0),
		.SD	(1'b0)
	);
	tsmc22ullhvt1024x32 ram_inst1 (
	     .CLK    (clk			),
	.ME	(ilm_cs			),
	.WE	(ilm_word_we		),
	.WEM	(ilm_bit_we[63:32]	),
	.ADR	(ilm_addr			),
	     .D      (ilm_wdata[63:32]		),
	     .Q      (ilm_rdata[63:32]		),
	.LS	(1'b0),
	.RME	(1'b1),
	.RM	(4'b0010),
		.TEST1	(1'b0),
		.WA	(3'b110),
		.WPULSE	(3'b000),
		.DS	(1'b0),
		.SD	(1'b0)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==11) && (ILM_RAM_DW==32)) begin : gen_ram_2048x32
	tsmc22ullhvt2048x32 ram_inst (
	     .CLK    (clk			),
	.ME	(ilm_cs			),
	.WE	(ilm_word_we		),
	.WEM	(ilm_bit_we[31:0]		),
	.ADR	(ilm_addr			),
	     .D      (ilm_wdata[31:0]		),
	     .Q      (ilm_rdata[31:0]		),
	.LS	(1'b0),
	.RME	(1'b1),
	.RM	(4'b0010),
		.TEST1	(1'b0),
		.WA	(3'b110),
		.WPULSE	(3'b000),
		.DS	(1'b0),
		.SD	(1'b0)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==11) && (ILM_RAM_DW==64)) begin : gen_ram_2048x64
	tsmc22ullhvt2048x32 ram_inst0 (
	     .CLK    (clk			),
	.ME	(ilm_cs			),
	.WE	(ilm_word_we		),
	.WEM	(ilm_bit_we[31:0]		),
	.ADR	(ilm_addr			),
	     .D      (ilm_wdata[31:0]		),
	     .Q      (ilm_rdata[31:0]		),
	.LS	(1'b0),
	.RME	(1'b1),
	.RM	(4'b0010),
		.TEST1	(1'b0),
		.WA	(3'b110),
		.WPULSE	(3'b000),
		.DS	(1'b0),
		.SD	(1'b0)
	);
	tsmc22ullhvt2048x32 ram_inst1 (
	     .CLK    (clk			),
	.ME	(ilm_cs			),
	.WE	(ilm_word_we		),
	.WEM	(ilm_bit_we[63:32]	),
	.ADR	(ilm_addr			),
	     .D      (ilm_wdata[63:32]		),
	     .Q      (ilm_rdata[63:32]		),
	.LS	(1'b0),
	.RME	(1'b1),
	.RM	(4'b0010),
		.TEST1	(1'b0),
		.WA	(3'b110),
		.WPULSE	(3'b000),
		.DS	(1'b0),
		.SD	(1'b0)
	);
end
endgenerate

// VPERL_GENERATED_END
//
//VPERL_BEGIN
//
//for ($aw=12; $aw<=22; $aw++) {
//my $depth = 1<<$aw;
//my $log2_insts = ($aw == 12) ? 1 : 
//                 ($aw == 13) ? 2 :
//                 ($aw == 14) ? 3 :
//                 ($aw == 15) ? 4 :
//                 ($aw == 16) ? 5 :
//                 ($aw == 17) ? 6 :
//                 ($aw == 18) ? 1 :
//                 ($aw == 19) ? 2 :
//                 ($aw == 20) ? 3 :
//                 ($aw == 21) ? 4 : 5;
//my $insts = 1 << $log2_insts;
//:generate
//:if (ILM_RAM_AW==%d) begin : gen_ram_%d :: $aw, 1<<$aw
//:	wire                      [%d:0] ent_ilm_cs;	:: $insts-1
//:	wire       [(ILM_RAM_DW*%d)-1:0] ent_ilm_rdata;	:: $insts
//:	wire                      [%d:0] a_sel;		:: $insts-1
//:	reg                       [%d:0] d_sel;		:: $insts-1
//
//	for (my $i=0; $i<$insts; $i++) {
//
//:	kv_ilm_ram \# (
//:		.ILM_RAM_AW	(ILM_RAM_AW-%d	),		:: $log2_insts;
//:		.ILM_RAM_DW	(ILM_RAM_DW	),
//:		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
//:	) ram_inst${i} (
//:		  .clk		(clk					),      
//:		  .ilm_cs	(ent_ilm_cs[${i}]			),	:: $i
//:		  .ilm_we	(ilm_we					),   
//:		  .ilm_byte_we	(ilm_byte_we				),
//:		  .ilm_addr	(ilm_addr[%d:0]				),	:: $aw-$log2_insts-1
//:		  .ilm_wdata	(ilm_wdata				),
//:		  .ilm_rdata	(ent_ilm_rdata[%d*ILM_RAM_DW+:ILM_RAM_DW])	:: $i
//:	);
//:
//
//	}
//:
//:	always @(posedge clk) begin
//:		if (ilm_cs)
//:			d_sel <= a_sel;
//:	end
//:
//:	kv_bin2onehot #(.N(%d))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[%d:%d]));	:: $insts, $aw-1, $aw-$log2_insts
//:
//:	assign ent_ilm_cs = {%d{ilm_cs}} & a_sel;	:: $insts
//:
//:	kv_mux_onehot #(.N(%d), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));	:: $insts, $aw-1
//:
//:
//:end
//:endgenerate
//:
//}
//VPERL_END

// VPERL_GENERATED_BEGIN
generate
if (ILM_RAM_AW==12) begin : gen_ram_4096
	wire                      [1:0] ent_ilm_cs;
	wire       [(ILM_RAM_DW*2)-1:0] ent_ilm_rdata;
	wire                      [1:0] a_sel;
	reg                       [1:0] d_sel;
	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-1	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst0 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[0]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[0*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-1	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst1 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[1]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[1*ILM_RAM_DW+:ILM_RAM_DW])
	);


	always @(posedge clk) begin
		if (ilm_cs)
			d_sel <= a_sel;
	end

	kv_bin2onehot #(.N(2))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[11:11]));

	assign ent_ilm_cs = {2{ilm_cs}} & a_sel;

	kv_mux_onehot #(.N(2), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));


end
endgenerate

generate
if (ILM_RAM_AW==13) begin : gen_ram_8192
	wire                      [3:0] ent_ilm_cs;
	wire       [(ILM_RAM_DW*4)-1:0] ent_ilm_rdata;
	wire                      [3:0] a_sel;
	reg                       [3:0] d_sel;
	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-2	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst0 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[0]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[0*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-2	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst1 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[1]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[1*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-2	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst2 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[2]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[2*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-2	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst3 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[3]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[3*ILM_RAM_DW+:ILM_RAM_DW])
	);


	always @(posedge clk) begin
		if (ilm_cs)
			d_sel <= a_sel;
	end

	kv_bin2onehot #(.N(4))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[12:11]));

	assign ent_ilm_cs = {4{ilm_cs}} & a_sel;

	kv_mux_onehot #(.N(4), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));


end
endgenerate

generate
if (ILM_RAM_AW==14) begin : gen_ram_16384
	wire                      [7:0] ent_ilm_cs;
	wire       [(ILM_RAM_DW*8)-1:0] ent_ilm_rdata;
	wire                      [7:0] a_sel;
	reg                       [7:0] d_sel;
	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst0 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[0]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[0*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst1 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[1]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[1*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst2 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[2]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[2*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst3 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[3]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[3*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst4 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[4]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[4*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst5 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[5]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[5*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst6 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[6]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[6*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst7 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[7]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[7*ILM_RAM_DW+:ILM_RAM_DW])
	);


	always @(posedge clk) begin
		if (ilm_cs)
			d_sel <= a_sel;
	end

	kv_bin2onehot #(.N(8))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[13:11]));

	assign ent_ilm_cs = {8{ilm_cs}} & a_sel;

	kv_mux_onehot #(.N(8), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));


end
endgenerate

generate
if (ILM_RAM_AW==15) begin : gen_ram_32768
	wire                      [15:0] ent_ilm_cs;
	wire       [(ILM_RAM_DW*16)-1:0] ent_ilm_rdata;
	wire                      [15:0] a_sel;
	reg                       [15:0] d_sel;
	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst0 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[0]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[0*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst1 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[1]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[1*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst2 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[2]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[2*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst3 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[3]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[3*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst4 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[4]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[4*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst5 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[5]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[5*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst6 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[6]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[6*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst7 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[7]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[7*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst8 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[8]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[8*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst9 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[9]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[9*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst10 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[10]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[10*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst11 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[11]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[11*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst12 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[12]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[12*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst13 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[13]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[13*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst14 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[14]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[14*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst15 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[15]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[15*ILM_RAM_DW+:ILM_RAM_DW])
	);


	always @(posedge clk) begin
		if (ilm_cs)
			d_sel <= a_sel;
	end

	kv_bin2onehot #(.N(16))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[14:11]));

	assign ent_ilm_cs = {16{ilm_cs}} & a_sel;

	kv_mux_onehot #(.N(16), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));


end
endgenerate

generate
if (ILM_RAM_AW==16) begin : gen_ram_65536
	wire                      [31:0] ent_ilm_cs;
	wire       [(ILM_RAM_DW*32)-1:0] ent_ilm_rdata;
	wire                      [31:0] a_sel;
	reg                       [31:0] d_sel;
	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst0 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[0]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[0*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst1 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[1]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[1*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst2 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[2]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[2*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst3 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[3]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[3*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst4 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[4]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[4*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst5 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[5]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[5*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst6 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[6]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[6*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst7 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[7]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[7*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst8 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[8]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[8*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst9 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[9]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[9*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst10 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[10]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[10*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst11 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[11]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[11*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst12 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[12]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[12*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst13 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[13]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[13*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst14 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[14]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[14*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst15 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[15]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[15*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst16 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[16]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[16*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst17 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[17]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[17*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst18 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[18]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[18*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst19 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[19]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[19*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst20 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[20]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[20*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst21 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[21]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[21*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst22 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[22]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[22*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst23 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[23]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[23*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst24 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[24]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[24*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst25 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[25]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[25*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst26 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[26]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[26*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst27 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[27]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[27*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst28 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[28]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[28*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst29 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[29]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[29*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst30 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[30]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[30*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst31 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[31]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[31*ILM_RAM_DW+:ILM_RAM_DW])
	);


	always @(posedge clk) begin
		if (ilm_cs)
			d_sel <= a_sel;
	end

	kv_bin2onehot #(.N(32))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[15:11]));

	assign ent_ilm_cs = {32{ilm_cs}} & a_sel;

	kv_mux_onehot #(.N(32), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));


end
endgenerate

generate
if (ILM_RAM_AW==17) begin : gen_ram_131072
	wire                      [63:0] ent_ilm_cs;
	wire       [(ILM_RAM_DW*64)-1:0] ent_ilm_rdata;
	wire                      [63:0] a_sel;
	reg                       [63:0] d_sel;
	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst0 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[0]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[0*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst1 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[1]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[1*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst2 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[2]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[2*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst3 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[3]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[3*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst4 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[4]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[4*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst5 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[5]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[5*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst6 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[6]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[6*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst7 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[7]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[7*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst8 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[8]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[8*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst9 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[9]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[9*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst10 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[10]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[10*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst11 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[11]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[11*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst12 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[12]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[12*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst13 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[13]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[13*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst14 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[14]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[14*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst15 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[15]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[15*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst16 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[16]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[16*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst17 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[17]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[17*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst18 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[18]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[18*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst19 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[19]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[19*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst20 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[20]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[20*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst21 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[21]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[21*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst22 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[22]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[22*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst23 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[23]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[23*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst24 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[24]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[24*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst25 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[25]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[25*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst26 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[26]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[26*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst27 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[27]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[27*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst28 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[28]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[28*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst29 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[29]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[29*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst30 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[30]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[30*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst31 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[31]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[31*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst32 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[32]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[32*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst33 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[33]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[33*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst34 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[34]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[34*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst35 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[35]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[35*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst36 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[36]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[36*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst37 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[37]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[37*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst38 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[38]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[38*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst39 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[39]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[39*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst40 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[40]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[40*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst41 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[41]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[41*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst42 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[42]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[42*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst43 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[43]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[43*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst44 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[44]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[44*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst45 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[45]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[45*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst46 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[46]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[46*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst47 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[47]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[47*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst48 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[48]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[48*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst49 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[49]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[49*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst50 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[50]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[50*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst51 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[51]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[51*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst52 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[52]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[52*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst53 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[53]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[53*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst54 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[54]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[54*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst55 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[55]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[55*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst56 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[56]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[56*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst57 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[57]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[57*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst58 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[58]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[58*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst59 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[59]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[59*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst60 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[60]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[60*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst61 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[61]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[61*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst62 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[62]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[62*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-6	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst63 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[63]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[10:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[63*ILM_RAM_DW+:ILM_RAM_DW])
	);


	always @(posedge clk) begin
		if (ilm_cs)
			d_sel <= a_sel;
	end

	kv_bin2onehot #(.N(64))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[16:11]));

	assign ent_ilm_cs = {64{ilm_cs}} & a_sel;

	kv_mux_onehot #(.N(64), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));


end
endgenerate

generate
if (ILM_RAM_AW==18) begin : gen_ram_262144
	wire                      [1:0] ent_ilm_cs;
	wire       [(ILM_RAM_DW*2)-1:0] ent_ilm_rdata;
	wire                      [1:0] a_sel;
	reg                       [1:0] d_sel;
	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-1	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst0 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[0]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[0*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-1	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst1 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[1]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[1*ILM_RAM_DW+:ILM_RAM_DW])
	);


	always @(posedge clk) begin
		if (ilm_cs)
			d_sel <= a_sel;
	end

	kv_bin2onehot #(.N(2))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[17:17]));

	assign ent_ilm_cs = {2{ilm_cs}} & a_sel;

	kv_mux_onehot #(.N(2), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));


end
endgenerate

generate
if (ILM_RAM_AW==19) begin : gen_ram_524288
	wire                      [3:0] ent_ilm_cs;
	wire       [(ILM_RAM_DW*4)-1:0] ent_ilm_rdata;
	wire                      [3:0] a_sel;
	reg                       [3:0] d_sel;
	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-2	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst0 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[0]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[0*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-2	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst1 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[1]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[1*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-2	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst2 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[2]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[2*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-2	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst3 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[3]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[3*ILM_RAM_DW+:ILM_RAM_DW])
	);


	always @(posedge clk) begin
		if (ilm_cs)
			d_sel <= a_sel;
	end

	kv_bin2onehot #(.N(4))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[18:17]));

	assign ent_ilm_cs = {4{ilm_cs}} & a_sel;

	kv_mux_onehot #(.N(4), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));


end
endgenerate

generate
if (ILM_RAM_AW==20) begin : gen_ram_1048576
	wire                      [7:0] ent_ilm_cs;
	wire       [(ILM_RAM_DW*8)-1:0] ent_ilm_rdata;
	wire                      [7:0] a_sel;
	reg                       [7:0] d_sel;
	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst0 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[0]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[0*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst1 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[1]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[1*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst2 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[2]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[2*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst3 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[3]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[3*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst4 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[4]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[4*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst5 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[5]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[5*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst6 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[6]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[6*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-3	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst7 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[7]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[7*ILM_RAM_DW+:ILM_RAM_DW])
	);


	always @(posedge clk) begin
		if (ilm_cs)
			d_sel <= a_sel;
	end

	kv_bin2onehot #(.N(8))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[19:17]));

	assign ent_ilm_cs = {8{ilm_cs}} & a_sel;

	kv_mux_onehot #(.N(8), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));


end
endgenerate

generate
if (ILM_RAM_AW==21) begin : gen_ram_2097152
	wire                      [15:0] ent_ilm_cs;
	wire       [(ILM_RAM_DW*16)-1:0] ent_ilm_rdata;
	wire                      [15:0] a_sel;
	reg                       [15:0] d_sel;
	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst0 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[0]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[0*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst1 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[1]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[1*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst2 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[2]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[2*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst3 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[3]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[3*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst4 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[4]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[4*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst5 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[5]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[5*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst6 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[6]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[6*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst7 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[7]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[7*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst8 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[8]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[8*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst9 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[9]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[9*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst10 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[10]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[10*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst11 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[11]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[11*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst12 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[12]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[12*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst13 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[13]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[13*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst14 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[14]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[14*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-4	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst15 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[15]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[15*ILM_RAM_DW+:ILM_RAM_DW])
	);


	always @(posedge clk) begin
		if (ilm_cs)
			d_sel <= a_sel;
	end

	kv_bin2onehot #(.N(16))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[20:17]));

	assign ent_ilm_cs = {16{ilm_cs}} & a_sel;

	kv_mux_onehot #(.N(16), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));


end
endgenerate

generate
if (ILM_RAM_AW==22) begin : gen_ram_4194304
	wire                      [31:0] ent_ilm_cs;
	wire       [(ILM_RAM_DW*32)-1:0] ent_ilm_rdata;
	wire                      [31:0] a_sel;
	reg                       [31:0] d_sel;
	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst0 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[0]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[0*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst1 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[1]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[1*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst2 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[2]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[2*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst3 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[3]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[3*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst4 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[4]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[4*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst5 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[5]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[5*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst6 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[6]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[6*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst7 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[7]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[7*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst8 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[8]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[8*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst9 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[9]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[9*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst10 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[10]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[10*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst11 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[11]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[11*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst12 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[12]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[12*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst13 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[13]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[13*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst14 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[14]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[14*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst15 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[15]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[15*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst16 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[16]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[16*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst17 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[17]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[17*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst18 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[18]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[18*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst19 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[19]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[19*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst20 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[20]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[20*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst21 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[21]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[21*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst22 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[22]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[22*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst23 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[23]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[23*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst24 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[24]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[24*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst25 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[25]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[25*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst26 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[26]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[26*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst27 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[27]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[27*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst28 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[28]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[28*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst29 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[29]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[29*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst30 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[30]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[30*ILM_RAM_DW+:ILM_RAM_DW])
	);

	kv_ilm_ram # (
		.ILM_RAM_AW	(ILM_RAM_AW-5	),
		.ILM_RAM_DW	(ILM_RAM_DW	),
		.ILM_RAM_BWEW	(ILM_RAM_BWEW	)
	) ram_inst31 (
		  .clk		(clk					),
		  .ilm_cs	(ent_ilm_cs[31]			),
		  .ilm_we	(ilm_we					),
		  .ilm_byte_we	(ilm_byte_we				),
		  .ilm_addr	(ilm_addr[16:0]				),
		  .ilm_wdata	(ilm_wdata				),
		  .ilm_rdata	(ent_ilm_rdata[31*ILM_RAM_DW+:ILM_RAM_DW])
	);


	always @(posedge clk) begin
		if (ilm_cs)
			d_sel <= a_sel;
	end

	kv_bin2onehot #(.N(32))                 u_a_sel    (.out(a_sel),  .in(ilm_addr[21:17]));

	assign ent_ilm_cs = {32{ilm_cs}} & a_sel;

	kv_mux_onehot #(.N(32), .W(ILM_RAM_DW)) u_ilm_rdata(.out(ilm_rdata), .sel(d_sel), .in(ent_ilm_rdata));


end
endgenerate

// VPERL_GENERATED_END
endmodule
