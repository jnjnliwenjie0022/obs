
`include "atcapbbrg100_config.vh"
`include "atcapbbrg100_const.vh"

module atcapbbrg100(
// VPERL: &PORTLIST;
// VPERL_GENERATED_BEGIN
`ifdef ATCAPBBRG100_SLV_1
	  ps1_psel, 
	  ps1_prdata,
	  ps1_pready,
	  ps1_pslverr,
`endif // ATCAPBBRG100_SLV_1
`ifdef ATCAPBBRG100_SLV_2
	  ps2_psel, 
	  ps2_prdata,
	  ps2_pready,
	  ps2_pslverr,
`endif // ATCAPBBRG100_SLV_2
`ifdef ATCAPBBRG100_SLV_3
	  ps3_psel, 
	  ps3_prdata,
	  ps3_pready,
	  ps3_pslverr,
`endif // ATCAPBBRG100_SLV_3
`ifdef ATCAPBBRG100_SLV_4
	  ps4_psel, 
	  ps4_prdata,
	  ps4_pready,
	  ps4_pslverr,
`endif // ATCAPBBRG100_SLV_4
`ifdef ATCAPBBRG100_SLV_5
	  ps5_psel, 
	  ps5_prdata,
	  ps5_pready,
	  ps5_pslverr,
`endif // ATCAPBBRG100_SLV_5
`ifdef ATCAPBBRG100_SLV_6
	  ps6_psel, 
	  ps6_prdata,
	  ps6_pready,
	  ps6_pslverr,
`endif // ATCAPBBRG100_SLV_6
`ifdef ATCAPBBRG100_SLV_7
	  ps7_psel, 
	  ps7_prdata,
	  ps7_pready,
	  ps7_pslverr,
`endif // ATCAPBBRG100_SLV_7
`ifdef ATCAPBBRG100_SLV_8
	  ps8_psel, 
	  ps8_prdata,
	  ps8_pready,
	  ps8_pslverr,
`endif // ATCAPBBRG100_SLV_8
`ifdef ATCAPBBRG100_SLV_9
	  ps9_psel, 
	  ps9_prdata,
	  ps9_pready,
	  ps9_pslverr,
`endif // ATCAPBBRG100_SLV_9
`ifdef ATCAPBBRG100_SLV_10
	  ps10_psel,
	  ps10_prdata,
	  ps10_pready,
	  ps10_pslverr,
`endif // ATCAPBBRG100_SLV_10
`ifdef ATCAPBBRG100_SLV_11
	  ps11_psel,
	  ps11_prdata,
	  ps11_pready,
	  ps11_pslverr,
`endif // ATCAPBBRG100_SLV_11
`ifdef ATCAPBBRG100_SLV_12
	  ps12_psel,
	  ps12_prdata,
	  ps12_pready,
	  ps12_pslverr,
`endif // ATCAPBBRG100_SLV_12
`ifdef ATCAPBBRG100_SLV_13
	  ps13_psel,
	  ps13_prdata,
	  ps13_pready,
	  ps13_pslverr,
`endif // ATCAPBBRG100_SLV_13
`ifdef ATCAPBBRG100_SLV_14
	  ps14_psel,
	  ps14_prdata,
	  ps14_pready,
	  ps14_pslverr,
`endif // ATCAPBBRG100_SLV_14
`ifdef ATCAPBBRG100_SLV_15
	  ps15_psel,
	  ps15_prdata,
	  ps15_pready,
	  ps15_pslverr,
`endif // ATCAPBBRG100_SLV_15
`ifdef ATCAPBBRG100_SLV_16
	  ps16_psel,
	  ps16_prdata,
	  ps16_pready,
	  ps16_pslverr,
`endif // ATCAPBBRG100_SLV_16
`ifdef ATCAPBBRG100_SLV_17
	  ps17_psel,
	  ps17_prdata,
	  ps17_pready,
	  ps17_pslverr,
`endif // ATCAPBBRG100_SLV_17
`ifdef ATCAPBBRG100_SLV_18
	  ps18_psel,
	  ps18_prdata,
	  ps18_pready,
	  ps18_pslverr,
`endif // ATCAPBBRG100_SLV_18
`ifdef ATCAPBBRG100_SLV_19
	  ps19_psel,
	  ps19_prdata,
	  ps19_pready,
	  ps19_pslverr,
`endif // ATCAPBBRG100_SLV_19
`ifdef ATCAPBBRG100_SLV_20
	  ps20_psel,
	  ps20_prdata,
	  ps20_pready,
	  ps20_pslverr,
`endif // ATCAPBBRG100_SLV_20
`ifdef ATCAPBBRG100_SLV_21
	  ps21_psel,
	  ps21_prdata,
	  ps21_pready,
	  ps21_pslverr,
`endif // ATCAPBBRG100_SLV_21
`ifdef ATCAPBBRG100_SLV_22
	  ps22_psel,
	  ps22_prdata,
	  ps22_pready,
	  ps22_pslverr,
`endif // ATCAPBBRG100_SLV_22
`ifdef ATCAPBBRG100_SLV_23
	  ps23_psel,
	  ps23_prdata,
	  ps23_pready,
	  ps23_pslverr,
`endif // ATCAPBBRG100_SLV_23
`ifdef ATCAPBBRG100_SLV_24
	  ps24_psel,
	  ps24_prdata,
	  ps24_pready,
	  ps24_pslverr,
`endif // ATCAPBBRG100_SLV_24
`ifdef ATCAPBBRG100_SLV_25
	  ps25_psel,
	  ps25_prdata,
	  ps25_pready,
	  ps25_pslverr,
`endif // ATCAPBBRG100_SLV_25
`ifdef ATCAPBBRG100_SLV_26
	  ps26_psel,
	  ps26_prdata,
	  ps26_pready,
	  ps26_pslverr,
`endif // ATCAPBBRG100_SLV_26
`ifdef ATCAPBBRG100_SLV_27
	  ps27_psel,
	  ps27_prdata,
	  ps27_pready,
	  ps27_pslverr,
`endif // ATCAPBBRG100_SLV_27
`ifdef ATCAPBBRG100_SLV_28
	  ps28_psel,
	  ps28_prdata,
	  ps28_pready,
	  ps28_pslverr,
`endif // ATCAPBBRG100_SLV_28
`ifdef ATCAPBBRG100_SLV_29
	  ps29_psel,
	  ps29_prdata,
	  ps29_pready,
	  ps29_pslverr,
`endif // ATCAPBBRG100_SLV_29
`ifdef ATCAPBBRG100_SLV_30
	  ps30_psel,
	  ps30_prdata,
	  ps30_pready,
	  ps30_pslverr,
`endif // ATCAPBBRG100_SLV_30
`ifdef ATCAPBBRG100_SLV_31
	  ps31_psel,
	  ps31_prdata,
	  ps31_pready,
	  ps31_pslverr,
`endif // ATCAPBBRG100_SLV_31
	  hclk,     
	  hresetn,  
	  hsel,     
	  hready_in,
	  htrans,   
	  haddr,    
	  hsize,    
	  hprot,    
	  hwrite,   
	  hwdata,   
	  apb2ahb_clken,
	  hrdata,   
	  hready,   
	  hresp,    
	  pclk,     
	  presetn,  
	  pprot,    
	  pstrb,    
	  paddr,    
	  penable,  
	  pwrite,   
	  pwdata    
// VPERL_GENERATED_END
);

parameter ST_AHB_IDLE		= 3'd0;
parameter ST_AHB_READ   	= 3'd1;
parameter ST_AHB_WRITE  	= 3'd2;
parameter ST_AHB_NONBUF 	= 3'd3;  // non-bufferable write
parameter ST_AHB_ERROR_1  	= 3'd4;
parameter ST_AHB_ERROR_2  	= 3'd5;

parameter HTRANS_IDLE		= 2'd0;
parameter HTRANS_BUSY		= 2'd1;
parameter HRESP_OKAY		= 2'd0;
parameter HRESP_ERROR		= 2'd1;
parameter HRESP_RETRY		= 2'd2;
parameter HRESP_SPLIT		= 2'd3;

parameter ST_P_IDLE         = 2'd0;
parameter ST_P_SETUP        = 2'd1;
parameter ST_P_ACCESS       = 2'd2;
// #VPERL_BEGIN
// #for my $i (1 .. 31) {
// #     printf("
// #     `ifdef ATCAPBBRG100_SLV_${i}
// #     output\t\t\tps${i}_psel;
// #     input [31:0]\t\tps${i}_prdata;
// #     input\t\t\tps${i}_pready;
// #     input\t\t\tps${i}_pslverr;
// #     `endif");
// #}
// #VPERL_END

`ifdef ATCAPBBRG100_SLV_1
output			ps1_psel;
input [31:0]		ps1_prdata;
input			ps1_pready;
input			ps1_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_2
output			ps2_psel;
input [31:0]		ps2_prdata;
input			ps2_pready;
input			ps2_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_3
output			ps3_psel;
input [31:0]		ps3_prdata;
input			ps3_pready;
input			ps3_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_4
output			ps4_psel;
input [31:0]		ps4_prdata;
input			ps4_pready;
input			ps4_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_5
output			ps5_psel;
input [31:0]		ps5_prdata;
input			ps5_pready;
input			ps5_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_6
output			ps6_psel;
input [31:0]		ps6_prdata;
input			ps6_pready;
input			ps6_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_7
output			ps7_psel;
input [31:0]		ps7_prdata;
input			ps7_pready;
input			ps7_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_8
output			ps8_psel;
input [31:0]		ps8_prdata;
input			ps8_pready;
input			ps8_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_9
output			ps9_psel;
input [31:0]		ps9_prdata;
input			ps9_pready;
input			ps9_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_10
output			ps10_psel;
input [31:0]		ps10_prdata;
input			ps10_pready;
input			ps10_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_11
output			ps11_psel;
input [31:0]		ps11_prdata;
input			ps11_pready;
input			ps11_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_12
output			ps12_psel;
input [31:0]		ps12_prdata;
input			ps12_pready;
input			ps12_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_13
output			ps13_psel;
input [31:0]		ps13_prdata;
input			ps13_pready;
input			ps13_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_14
output			ps14_psel;
input [31:0]		ps14_prdata;
input			ps14_pready;
input			ps14_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_15
output			ps15_psel;
input [31:0]		ps15_prdata;
input			ps15_pready;
input			ps15_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_16
output			ps16_psel;
input [31:0]		ps16_prdata;
input			ps16_pready;
input			ps16_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_17
output			ps17_psel;
input [31:0]		ps17_prdata;
input			ps17_pready;
input			ps17_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_18
output			ps18_psel;
input [31:0]		ps18_prdata;
input			ps18_pready;
input			ps18_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_19
output			ps19_psel;
input [31:0]		ps19_prdata;
input			ps19_pready;
input			ps19_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_20
output			ps20_psel;
input [31:0]		ps20_prdata;
input			ps20_pready;
input			ps20_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_21
output			ps21_psel;
input [31:0]		ps21_prdata;
input			ps21_pready;
input			ps21_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_22
output			ps22_psel;
input [31:0]		ps22_prdata;
input			ps22_pready;
input			ps22_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_23
output			ps23_psel;
input [31:0]		ps23_prdata;
input			ps23_pready;
input			ps23_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_24
output			ps24_psel;
input [31:0]		ps24_prdata;
input			ps24_pready;
input			ps24_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_25
output			ps25_psel;
input [31:0]		ps25_prdata;
input			ps25_pready;
input			ps25_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_26
output			ps26_psel;
input [31:0]		ps26_prdata;
input			ps26_pready;
input			ps26_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_27
output			ps27_psel;
input [31:0]		ps27_prdata;
input			ps27_pready;
input			ps27_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_28
output			ps28_psel;
input [31:0]		ps28_prdata;
input			ps28_pready;
input			ps28_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_29
output			ps29_psel;
input [31:0]		ps29_prdata;
input			ps29_pready;
input			ps29_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_30
output			ps30_psel;
input [31:0]		ps30_prdata;
input			ps30_pready;
input			ps30_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_31
output			ps31_psel;
input [31:0]		ps31_prdata;
input			ps31_pready;
input			ps31_pslverr;
`endif

input				hclk;
input				hresetn;
input				hsel;
input				hready_in;
input	[1:0]			htrans;
input	[`ATCAPBBRG100_ADDR_MSB:0] haddr;
input	[2:0]			hsize;
input	[3:0]			hprot;
input				hwrite;
input	[31:0]			hwdata;
input				apb2ahb_clken;
output	[31:0]			hrdata;
output				hready;
output	[1:0]			hresp;

input				pclk;
input				presetn;
output  [2:0]			pprot;
output  [3:0]			pstrb;
output	[`ATCAPBBRG100_ADDR_MSB:0] paddr;
output				penable;
output				pwrite;
output	[31:0]			pwdata;
reg	[2:0]			hctrl_cs;
reg    	[2:0]			hctrl_ns;
reg				hwrite_d1;
reg				penable;                                         
reg				wbuf_en;
reg				paddr_miss;
reg				rd_cmd_entering_fifo;
reg				wr_data_entering_fifo;

wire				apb_cmd_wr;
wire				apb_cmd_buff_wr;
wire	[`ATCAPBBRG100_ADDR_MSB:0] apb_cmd_addr;
wire				ahb_cmd_valid;
wire				cmd_fifo_full;
wire				cmd_fifo_empty;
wire				pdata_phase_end;
wire	[31:0]			prdata;
wire				pslverr;
wire				psel_union;
wire				pready;
wire				wdata_fifo_empty;
wire	[31:0]			wdata_fifo_wdata;
wire	[31:0]			wdata_fifo_rdata;
wire				wdata_fifo_wr;
wire				wdata_fifo_rd;
wire				nonbuf;
wire				error_condition;
wire	[32:0]			ps0_prdata;
wire				ps0_pready;
wire				ps0_pslverr;
wire				ps0_psel;
wire				cmd_fifo_rd;
wire				cmd_fifo_wr;
wire				dec_en;
wire				buff_wr_cmd;
wire	[3:0]			apb_cmd_wr_strb;
wire				apb_cmd_acc_mode;
wire				apb_cmd_acc_type;
wire				acc_mode;
wire				acc_type;
reg	[3:0]			wr_strb;
wire	[5:0]			wr_strb_sel;
wire	[`ATCAPBBRG100_ADDR_MSB+8:0] cmd_fifo_wdata;
wire	[`ATCAPBBRG100_ADDR_MSB+8:0] cmd_fifo_rdata;
`ifdef ATCAPBBRG100_FLOP_OUT
reg     [`ATCAPBBRG100_ADDR_MSB+8:0] cmd_fifo_rdata_d1;
reg [1:0]                           p_st_cs, p_st_ns;
`endif

// ---------------------------------------
// AHB interface
// ---------------------------------------
assign	hready 		= ~cmd_fifo_full & (
			(hctrl_cs == ST_AHB_IDLE) 
			| ((hctrl_cs == ST_AHB_READ) & pdata_phase_end) 
			| ((hctrl_cs == ST_AHB_NONBUF) & pdata_phase_end)
			| (hctrl_cs == ST_AHB_WRITE) 
			| (hctrl_cs == ST_AHB_ERROR_2));
assign	hresp		= ((hctrl_cs == ST_AHB_ERROR_1) | (hctrl_cs == ST_AHB_ERROR_2)) ? HRESP_ERROR : HRESP_OKAY;
assign	hrdata		= prdata;

assign	error_condition = ((pready & penable & pslverr) | paddr_miss) & (~apb_cmd_buff_wr);
assign	nonbuf		= ~(|hprot[3:2]); // hprot[3:2]==2'b00
assign	ahb_cmd_valid	= hsel & hready_in & htrans[1];
assign	pdata_phase_end	= penable & pready & ~pslverr & apb2ahb_clken;
assign	buff_wr_cmd     = hwrite & (wbuf_en | hprot[3] | hprot[2]);

assign  acc_type        = ~hprot[0]; // pprot[2]: data/instruction access
assign  acc_mode        =  hprot[1]; // pprot[0]: normal/priviledge access

assign  wr_strb_sel     = {hwrite, hsize, haddr[1:0]};
always @(*)begin
	case (wr_strb_sel)
	6'b101000: wr_strb = 4'b1111;
	6'b100100: wr_strb = 4'b0011;
	6'b100110: wr_strb = 4'b1100;
	6'b100000: wr_strb = 4'b0001;
	6'b100001: wr_strb = 4'b0010;
	6'b100010: wr_strb = 4'b0100;
	6'b100011: wr_strb = 4'b1000;
	default:   wr_strb = 4'b0000;
	endcase
end 

always @(posedge hclk or negedge hresetn) begin
	if(~hresetn) begin
		hwrite_d1		<= 1'b0;
	end
	else begin
		hwrite_d1		<= ahb_cmd_valid & hwrite;
	end
end

// FSM Controller
always @(posedge hclk or negedge hresetn) begin
	if(~hresetn)
		hctrl_cs	<= ST_AHB_IDLE;
	else
		hctrl_cs	<= hctrl_ns;
end

always @(*) begin
	case(hctrl_cs)
		ST_AHB_READ:
			if (error_condition & apb2ahb_clken)
				hctrl_ns = ST_AHB_ERROR_1;
			else if (hready_in & ((htrans == HTRANS_IDLE) | (htrans == HTRANS_BUSY)))
				hctrl_ns = ST_AHB_IDLE;
			else if (ahb_cmd_valid & hwrite)
				hctrl_ns = (nonbuf & ~wbuf_en) ? ST_AHB_NONBUF : ST_AHB_WRITE; 
			else 
				hctrl_ns = ST_AHB_READ;
		ST_AHB_WRITE:
			if (hready_in & ((htrans == HTRANS_IDLE) | (htrans == HTRANS_BUSY)))
				hctrl_ns = ST_AHB_IDLE;
			else if (ahb_cmd_valid & hwrite)
				hctrl_ns = (nonbuf & ~wbuf_en) ? ST_AHB_NONBUF : ST_AHB_WRITE; 
			else if (ahb_cmd_valid & ~hwrite)
				hctrl_ns = ST_AHB_READ;
			else 
				hctrl_ns = ST_AHB_WRITE;
		ST_AHB_NONBUF:
			if (error_condition & apb2ahb_clken)
				hctrl_ns = ST_AHB_ERROR_1;
			else if (hready_in & ((htrans == HTRANS_IDLE)| (htrans == HTRANS_BUSY)))
				hctrl_ns = ST_AHB_IDLE;
			else if (ahb_cmd_valid & hwrite)
				hctrl_ns = (nonbuf & ~wbuf_en) ? ST_AHB_NONBUF : ST_AHB_WRITE; 
			else if (ahb_cmd_valid)
				hctrl_ns = ST_AHB_READ;
			else
				hctrl_ns = ST_AHB_NONBUF;
		ST_AHB_ERROR_1:
			hctrl_ns = ST_AHB_ERROR_2;
		ST_AHB_ERROR_2:
			if (ahb_cmd_valid & hwrite)
				hctrl_ns = (nonbuf & ~wbuf_en) ? ST_AHB_NONBUF : ST_AHB_WRITE; 
			else if (ahb_cmd_valid & ~hwrite)
				hctrl_ns = ST_AHB_READ;
			else if (hready_in)
				hctrl_ns = ST_AHB_IDLE;
			else
				hctrl_ns = ST_AHB_ERROR_2;
		default: // ST_AHB_IDLE
			if (ahb_cmd_valid & hwrite)
				hctrl_ns = (nonbuf & ~wbuf_en) ? ST_AHB_NONBUF : ST_AHB_WRITE; 
			else if (ahb_cmd_valid)
				hctrl_ns = ST_AHB_READ;
			else
				hctrl_ns = ST_AHB_IDLE;
	endcase
end

// ------------------------------------------------
// Synchronous FIFO between AHB and APB interfaces
// ------------------------------------------------
assign	cmd_fifo_wr	= ahb_cmd_valid;
assign	cmd_fifo_wdata	= {wr_strb, acc_mode, acc_type, buff_wr_cmd, hwrite, haddr[`ATCAPBBRG100_ADDR_MSB:2], 2'b00};
assign	cmd_fifo_rd	= (penable & pready) | (paddr_miss & ~cmd_fifo_empty);

nds_sync_fifo_data #(
        .DATA_WIDTH (`ATCAPBBRG100_ADDR_MSB+9),
        .POINTER_INDEX_WIDTH (2),
        .FIFO_DEPTH (2)
) u_cmd_fifo (
	.w_reset_n  (hresetn         ), // (u_apbbrg_ahctrl,u_cmd_fifo,u_wdata_fifo) <= ()
	.r_reset_n  (presetn         ), // (u_apbbrg_apctrl,u_cmd_fifo,u_wdata_fifo) <= ()
	.w_clk      (hclk            ), // (u_apbbrg_ahctrl,u_cmd_fifo,u_wdata_fifo) <= ()
	.r_clk      (pclk            ), // (u_apbbrg_apctrl,u_cmd_fifo,u_wdata_fifo) <= ()
	.wr         (cmd_fifo_wr     ), // (u_cmd_fifo) <= (u_apbbrg_ahctrl)
	.wr_data    (cmd_fifo_wdata  ), // (u_cmd_fifo) <= (u_apbbrg_ahctrl)
	.rd         (cmd_fifo_rd     ), // (u_cmd_fifo) <= (u_apbbrg_apctrl)
	.rd_data    (cmd_fifo_rdata  ), // (u_cmd_fifo) => (u_apbbrg_apctrl)
	.w_clk_empty(                ), // (u_cmd_fifo,u_wdata_fifo) => ()
	.empty      (cmd_fifo_empty  ), // (u_cmd_fifo) => (u_apbbrg_apctrl)
	.full       (cmd_fifo_full   )  // (u_cmd_fifo) => (u_apbbrg_ahctrl)
); // end of u_cmd_fifo

`ifdef ATCAPBBRG100_FLOP_OUT
always @(*) begin
    case (p_st_cs)
        ST_P_SETUP:
            p_st_ns = ST_P_ACCESS;
        ST_P_ACCESS:
            p_st_ns = paddr_miss? ST_P_IDLE : pready? ST_P_IDLE : ST_P_ACCESS;
        default: //ST_P_IDLE
            p_st_ns = (~cmd_fifo_empty & (~apb_cmd_wr | (apb_cmd_wr & ~wdata_fifo_empty)))? ST_P_SETUP : ST_P_IDLE ; 
    endcase
end
always @(posedge pclk or negedge presetn) begin
	if (~presetn)
        p_st_cs <= 2'b0;
    else
        p_st_cs <= p_st_ns;
end

always @(posedge pclk) begin
    cmd_fifo_rdata_d1 <= cmd_fifo_rdata;
end
`endif

assign	wdata_fifo_wr	= hwrite_d1;
assign	wdata_fifo_wdata = hwdata;
assign	wdata_fifo_rd	= (penable & pready & apb_cmd_wr) | (paddr_miss & ~wdata_fifo_empty);

nds_sync_fifo_data #(
        .DATA_WIDTH (32),
        .POINTER_INDEX_WIDTH (2),
        .FIFO_DEPTH (2)
) u_wdata_fifo (
	.w_reset_n  (hresetn           ), // (u_apbbrg_ahctrl,u_cmd_fifo,u_wdata_fifo) <= ()
	.r_reset_n  (presetn           ), // (u_apbbrg_apctrl,u_cmd_fifo,u_wdata_fifo) <= ()
	.w_clk      (hclk              ), // (u_apbbrg_ahctrl,u_cmd_fifo,u_wdata_fifo) <= ()
	.r_clk      (pclk              ), // (u_apbbrg_apctrl,u_cmd_fifo,u_wdata_fifo) <= ()
	.wr         (wdata_fifo_wr     ), // (u_wdata_fifo) <= (u_apbbrg_ahctrl)
	.wr_data    (wdata_fifo_wdata  ), // (u_wdata_fifo) <= (u_apbbrg_ahctrl)
	.rd         (wdata_fifo_rd     ), // (u_wdata_fifo) <= (u_apbbrg_apctrl)
	.rd_data    (wdata_fifo_rdata  ), // (u_wdata_fifo) => (u_apbbrg_apctrl)
	.w_clk_empty(                  ), // (u_cmd_fifo,u_wdata_fifo) => ()
	.empty      (wdata_fifo_empty  ), // (u_wdata_fifo) => (u_apbbrg_ahctrl,u_apbbrg_apctrl)
	.full       (                  )  // (u_cmd_fifo,u_wdata_fifo) => ()
); // end of u_wdata_fifo

// ---------------------------------------
// APB interface
// ---------------------------------------
assign	paddr		= apb_cmd_addr;
`ifdef ATCAPBBRG100_FLOP_OUT
assign	pwrite		= dec_en & apb_cmd_wr;
assign  pstrb       = {4{~cmd_fifo_empty }} & apb_cmd_wr_strb;
`else
assign	pwrite		= ~cmd_fifo_empty & apb_cmd_wr;
assign  pstrb       = {4{~cmd_fifo_empty}} & apb_cmd_wr_strb;
`endif
assign	pwdata		= wdata_fifo_rdata;
assign  pprot       = {apb_cmd_acc_type, 1'b0, apb_cmd_acc_mode}; 


// Exclude the cycle of the command FIFO empty and
// the cycle that write data is not ready for a write transaction
`ifdef ATCAPBBRG100_FLOP_OUT
assign dec_en = (p_st_cs == ST_P_IDLE)? 1'b0 : 1'b1;
`else
assign	dec_en		= cmd_fifo_empty ? rd_cmd_entering_fifo : 
			  (~apb_cmd_wr | (apb_cmd_wr & (~wdata_fifo_empty | wr_data_entering_fifo)));
`endif

// Sample AHB commands at PCLK posedge to take
// read/write just one HCLK cycle before the PCLK posedge
always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		rd_cmd_entering_fifo	<= 1'b0;
	else
		rd_cmd_entering_fifo	<= (ahb_cmd_valid & ~hwrite);
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		wr_data_entering_fifo <= 1'b0;
	else
		wr_data_entering_fifo <= hwrite_d1;
end

// VPERL_BEGIN
// printf("assign	prdata		= ({32{ps0_psel}} & ps0_prdata[31:0]) ");
// for my $i (1 .. 31) {
//      printf("
//      `ifdef ATCAPBBRG100_SLV_${i}
//	\t\t	| ({32{ps${i}_psel}} & ps${i}_prdata)
//      `endif");
// }
// printf("\n;\n");
// printf("assign	pready		= (ps0_psel & ps0_pready)");
// for my $i (1 .. 31) {
//      printf("
//      `ifdef ATCAPBBRG100_SLV_${i}
//	\t\t	| (ps${i}_psel & ps${i}_pready)
//      `endif");
// }
// printf("\n;\n");
// printf("assign	pslverr		= (ps0_psel & ps0_pslverr)");
// for my $i (1 .. 31) {
//      printf("
//      `ifdef ATCAPBBRG100_SLV_${i}
//	\t\t	| (ps${i}_psel & ps${i}_pslverr)
//      `endif");
// }
// printf("\n;\n");
// printf("assign	psel_union	= ps0_psel ");
// for my $i (1 .. 31) {
//      printf("
//      `ifdef ATCAPBBRG100_SLV_${i}
//	\t\t	| ps${i}_psel
//      `endif");
// }
// printf("\n;\n");
// VPERL_END

// VPERL_GENERATED_BEGIN
assign	prdata		= ({32{ps0_psel}} & ps0_prdata[31:0]) 
`ifdef ATCAPBBRG100_SLV_1
			| ({32{ps1_psel}} & ps1_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_2
			| ({32{ps2_psel}} & ps2_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_3
			| ({32{ps3_psel}} & ps3_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_4
			| ({32{ps4_psel}} & ps4_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_5
			| ({32{ps5_psel}} & ps5_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_6
			| ({32{ps6_psel}} & ps6_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_7
			| ({32{ps7_psel}} & ps7_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_8
			| ({32{ps8_psel}} & ps8_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_9
			| ({32{ps9_psel}} & ps9_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_10
			| ({32{ps10_psel}} & ps10_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_11
			| ({32{ps11_psel}} & ps11_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_12
			| ({32{ps12_psel}} & ps12_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_13
			| ({32{ps13_psel}} & ps13_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_14
			| ({32{ps14_psel}} & ps14_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_15
			| ({32{ps15_psel}} & ps15_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_16
			| ({32{ps16_psel}} & ps16_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_17
			| ({32{ps17_psel}} & ps17_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_18
			| ({32{ps18_psel}} & ps18_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_19
			| ({32{ps19_psel}} & ps19_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_20
			| ({32{ps20_psel}} & ps20_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_21
			| ({32{ps21_psel}} & ps21_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_22
			| ({32{ps22_psel}} & ps22_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_23
			| ({32{ps23_psel}} & ps23_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_24
			| ({32{ps24_psel}} & ps24_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_25
			| ({32{ps25_psel}} & ps25_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_26
			| ({32{ps26_psel}} & ps26_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_27
			| ({32{ps27_psel}} & ps27_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_28
			| ({32{ps28_psel}} & ps28_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_29
			| ({32{ps29_psel}} & ps29_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_30
			| ({32{ps30_psel}} & ps30_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_31
			| ({32{ps31_psel}} & ps31_prdata)
`endif
;
assign	pready		= (ps0_psel & ps0_pready)
`ifdef ATCAPBBRG100_SLV_1
			| (ps1_psel & ps1_pready)
`endif
`ifdef ATCAPBBRG100_SLV_2
			| (ps2_psel & ps2_pready)
`endif
`ifdef ATCAPBBRG100_SLV_3
			| (ps3_psel & ps3_pready)
`endif
`ifdef ATCAPBBRG100_SLV_4
			| (ps4_psel & ps4_pready)
`endif
`ifdef ATCAPBBRG100_SLV_5
			| (ps5_psel & ps5_pready)
`endif
`ifdef ATCAPBBRG100_SLV_6
			| (ps6_psel & ps6_pready)
`endif
`ifdef ATCAPBBRG100_SLV_7
			| (ps7_psel & ps7_pready)
`endif
`ifdef ATCAPBBRG100_SLV_8
			| (ps8_psel & ps8_pready)
`endif
`ifdef ATCAPBBRG100_SLV_9
			| (ps9_psel & ps9_pready)
`endif
`ifdef ATCAPBBRG100_SLV_10
			| (ps10_psel & ps10_pready)
`endif
`ifdef ATCAPBBRG100_SLV_11
			| (ps11_psel & ps11_pready)
`endif
`ifdef ATCAPBBRG100_SLV_12
			| (ps12_psel & ps12_pready)
`endif
`ifdef ATCAPBBRG100_SLV_13
			| (ps13_psel & ps13_pready)
`endif
`ifdef ATCAPBBRG100_SLV_14
			| (ps14_psel & ps14_pready)
`endif
`ifdef ATCAPBBRG100_SLV_15
			| (ps15_psel & ps15_pready)
`endif
`ifdef ATCAPBBRG100_SLV_16
			| (ps16_psel & ps16_pready)
`endif
`ifdef ATCAPBBRG100_SLV_17
			| (ps17_psel & ps17_pready)
`endif
`ifdef ATCAPBBRG100_SLV_18
			| (ps18_psel & ps18_pready)
`endif
`ifdef ATCAPBBRG100_SLV_19
			| (ps19_psel & ps19_pready)
`endif
`ifdef ATCAPBBRG100_SLV_20
			| (ps20_psel & ps20_pready)
`endif
`ifdef ATCAPBBRG100_SLV_21
			| (ps21_psel & ps21_pready)
`endif
`ifdef ATCAPBBRG100_SLV_22
			| (ps22_psel & ps22_pready)
`endif
`ifdef ATCAPBBRG100_SLV_23
			| (ps23_psel & ps23_pready)
`endif
`ifdef ATCAPBBRG100_SLV_24
			| (ps24_psel & ps24_pready)
`endif
`ifdef ATCAPBBRG100_SLV_25
			| (ps25_psel & ps25_pready)
`endif
`ifdef ATCAPBBRG100_SLV_26
			| (ps26_psel & ps26_pready)
`endif
`ifdef ATCAPBBRG100_SLV_27
			| (ps27_psel & ps27_pready)
`endif
`ifdef ATCAPBBRG100_SLV_28
			| (ps28_psel & ps28_pready)
`endif
`ifdef ATCAPBBRG100_SLV_29
			| (ps29_psel & ps29_pready)
`endif
`ifdef ATCAPBBRG100_SLV_30
			| (ps30_psel & ps30_pready)
`endif
`ifdef ATCAPBBRG100_SLV_31
			| (ps31_psel & ps31_pready)
`endif
;
assign	pslverr		= (ps0_psel & ps0_pslverr)
`ifdef ATCAPBBRG100_SLV_1
			| (ps1_psel & ps1_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_2
			| (ps2_psel & ps2_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_3
			| (ps3_psel & ps3_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_4
			| (ps4_psel & ps4_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_5
			| (ps5_psel & ps5_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_6
			| (ps6_psel & ps6_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_7
			| (ps7_psel & ps7_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_8
			| (ps8_psel & ps8_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_9
			| (ps9_psel & ps9_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_10
			| (ps10_psel & ps10_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_11
			| (ps11_psel & ps11_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_12
			| (ps12_psel & ps12_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_13
			| (ps13_psel & ps13_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_14
			| (ps14_psel & ps14_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_15
			| (ps15_psel & ps15_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_16
			| (ps16_psel & ps16_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_17
			| (ps17_psel & ps17_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_18
			| (ps18_psel & ps18_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_19
			| (ps19_psel & ps19_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_20
			| (ps20_psel & ps20_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_21
			| (ps21_psel & ps21_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_22
			| (ps22_psel & ps22_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_23
			| (ps23_psel & ps23_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_24
			| (ps24_psel & ps24_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_25
			| (ps25_psel & ps25_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_26
			| (ps26_psel & ps26_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_27
			| (ps27_psel & ps27_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_28
			| (ps28_psel & ps28_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_29
			| (ps29_psel & ps29_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_30
			| (ps30_psel & ps30_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_31
			| (ps31_psel & ps31_pslverr)
`endif
;
assign	psel_union	= ps0_psel 
`ifdef ATCAPBBRG100_SLV_1
			| ps1_psel
`endif
`ifdef ATCAPBBRG100_SLV_2
			| ps2_psel
`endif
`ifdef ATCAPBBRG100_SLV_3
			| ps3_psel
`endif
`ifdef ATCAPBBRG100_SLV_4
			| ps4_psel
`endif
`ifdef ATCAPBBRG100_SLV_5
			| ps5_psel
`endif
`ifdef ATCAPBBRG100_SLV_6
			| ps6_psel
`endif
`ifdef ATCAPBBRG100_SLV_7
			| ps7_psel
`endif
`ifdef ATCAPBBRG100_SLV_8
			| ps8_psel
`endif
`ifdef ATCAPBBRG100_SLV_9
			| ps9_psel
`endif
`ifdef ATCAPBBRG100_SLV_10
			| ps10_psel
`endif
`ifdef ATCAPBBRG100_SLV_11
			| ps11_psel
`endif
`ifdef ATCAPBBRG100_SLV_12
			| ps12_psel
`endif
`ifdef ATCAPBBRG100_SLV_13
			| ps13_psel
`endif
`ifdef ATCAPBBRG100_SLV_14
			| ps14_psel
`endif
`ifdef ATCAPBBRG100_SLV_15
			| ps15_psel
`endif
`ifdef ATCAPBBRG100_SLV_16
			| ps16_psel
`endif
`ifdef ATCAPBBRG100_SLV_17
			| ps17_psel
`endif
`ifdef ATCAPBBRG100_SLV_18
			| ps18_psel
`endif
`ifdef ATCAPBBRG100_SLV_19
			| ps19_psel
`endif
`ifdef ATCAPBBRG100_SLV_20
			| ps20_psel
`endif
`ifdef ATCAPBBRG100_SLV_21
			| ps21_psel
`endif
`ifdef ATCAPBBRG100_SLV_22
			| ps22_psel
`endif
`ifdef ATCAPBBRG100_SLV_23
			| ps23_psel
`endif
`ifdef ATCAPBBRG100_SLV_24
			| ps24_psel
`endif
`ifdef ATCAPBBRG100_SLV_25
			| ps25_psel
`endif
`ifdef ATCAPBBRG100_SLV_26
			| ps26_psel
`endif
`ifdef ATCAPBBRG100_SLV_27
			| ps27_psel
`endif
`ifdef ATCAPBBRG100_SLV_28
			| ps28_psel
`endif
`ifdef ATCAPBBRG100_SLV_29
			| ps29_psel
`endif
`ifdef ATCAPBBRG100_SLV_30
			| ps30_psel
`endif
`ifdef ATCAPBBRG100_SLV_31
			| ps31_psel
`endif
;
// VPERL_GENERATED_END
`ifdef ATCAPBBRG100_FLOP_OUT
assign apb_cmd_wr_strb  = cmd_fifo_rdata_d1[`ATCAPBBRG100_ADDR_MSB+8:`ATCAPBBRG100_ADDR_MSB+5];
assign apb_cmd_acc_mode = cmd_fifo_rdata_d1[`ATCAPBBRG100_ADDR_MSB+4];
assign apb_cmd_acc_type = cmd_fifo_rdata_d1[`ATCAPBBRG100_ADDR_MSB+3];
assign apb_cmd_buff_wr  = cmd_fifo_rdata_d1[`ATCAPBBRG100_ADDR_MSB+2]; 
assign apb_cmd_wr       = cmd_fifo_rdata_d1[`ATCAPBBRG100_ADDR_MSB+1]; 
assign apb_cmd_addr     = cmd_fifo_rdata_d1[`ATCAPBBRG100_ADDR_MSB:0]; 
`else
assign apb_cmd_wr_strb  = cmd_fifo_rdata[`ATCAPBBRG100_ADDR_MSB+8:`ATCAPBBRG100_ADDR_MSB+5];
assign apb_cmd_acc_mode = cmd_fifo_rdata[`ATCAPBBRG100_ADDR_MSB+4];
assign apb_cmd_acc_type = cmd_fifo_rdata[`ATCAPBBRG100_ADDR_MSB+3];
assign apb_cmd_buff_wr  = cmd_fifo_rdata[`ATCAPBBRG100_ADDR_MSB+2]; 
assign apb_cmd_wr       = cmd_fifo_rdata[`ATCAPBBRG100_ADDR_MSB+1]; 
assign apb_cmd_addr     = cmd_fifo_rdata[`ATCAPBBRG100_ADDR_MSB:0]; 
`endif

// Command status
//   0: IDLE or APB SETUP
//   1: APB ENABLE
`ifdef ATCAPBBRG100_FLOP_OUT
always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		penable <= 1'b0;
    else
        penable <= (p_st_ns == ST_P_ACCESS)? 1'b1 : 1'b0;
end


always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		paddr_miss <= 1'b0;
	else if (paddr_miss)
		paddr_miss <= 1'b0;
	else if (dec_en & ~psel_union)
		paddr_miss <= 1'b1;
end

`else
always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		penable <= 1'b0;
	else if (~penable & dec_en & psel_union)
		penable <= 1'b1;
	else if (pready)
		penable <= 1'b0;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		paddr_miss <= 1'b0;
	else if (paddr_miss)
		paddr_miss <= 1'b0;
	else if (dec_en & ~psel_union)
		paddr_miss <= 1'b1;
end
`endif
// ---------------------------------------
// APB decoding
// ---------------------------------------
// VPERL_BEGIN
// for my $i (0 .. 31) {
//	printf("
//	`ifdef ATCAPBBRG100_SLV_${i}
//	assign	ps${i}_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV${i}_OFFSET_LSB], {`ATCAPBBRG100_SLV${i}_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV${i}_OFFSET);
//	`endif");
// }
// VPERL_END

// VPERL_GENERATED_BEGIN

`ifdef ATCAPBBRG100_SLV_0
assign	ps0_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV0_OFFSET_LSB], {`ATCAPBBRG100_SLV0_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV0_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_1
assign	ps1_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV1_OFFSET_LSB], {`ATCAPBBRG100_SLV1_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV1_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_2
assign	ps2_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV2_OFFSET_LSB], {`ATCAPBBRG100_SLV2_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV2_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_3
assign	ps3_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV3_OFFSET_LSB], {`ATCAPBBRG100_SLV3_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV3_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_4
assign	ps4_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV4_OFFSET_LSB], {`ATCAPBBRG100_SLV4_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV4_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_5
assign	ps5_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV5_OFFSET_LSB], {`ATCAPBBRG100_SLV5_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV5_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_6
assign	ps6_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV6_OFFSET_LSB], {`ATCAPBBRG100_SLV6_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV6_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_7
assign	ps7_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV7_OFFSET_LSB], {`ATCAPBBRG100_SLV7_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV7_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_8
assign	ps8_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV8_OFFSET_LSB], {`ATCAPBBRG100_SLV8_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV8_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_9
assign	ps9_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV9_OFFSET_LSB], {`ATCAPBBRG100_SLV9_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV9_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_10
assign	ps10_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV10_OFFSET_LSB], {`ATCAPBBRG100_SLV10_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV10_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_11
assign	ps11_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV11_OFFSET_LSB], {`ATCAPBBRG100_SLV11_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV11_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_12
assign	ps12_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV12_OFFSET_LSB], {`ATCAPBBRG100_SLV12_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV12_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_13
assign	ps13_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV13_OFFSET_LSB], {`ATCAPBBRG100_SLV13_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV13_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_14
assign	ps14_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV14_OFFSET_LSB], {`ATCAPBBRG100_SLV14_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV14_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_15
assign	ps15_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV15_OFFSET_LSB], {`ATCAPBBRG100_SLV15_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV15_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_16
assign	ps16_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV16_OFFSET_LSB], {`ATCAPBBRG100_SLV16_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV16_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_17
assign	ps17_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV17_OFFSET_LSB], {`ATCAPBBRG100_SLV17_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV17_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_18
assign	ps18_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV18_OFFSET_LSB], {`ATCAPBBRG100_SLV18_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV18_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_19
assign	ps19_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV19_OFFSET_LSB], {`ATCAPBBRG100_SLV19_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV19_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_20
assign	ps20_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV20_OFFSET_LSB], {`ATCAPBBRG100_SLV20_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV20_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_21
assign	ps21_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV21_OFFSET_LSB], {`ATCAPBBRG100_SLV21_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV21_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_22
assign	ps22_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV22_OFFSET_LSB], {`ATCAPBBRG100_SLV22_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV22_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_23
assign	ps23_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV23_OFFSET_LSB], {`ATCAPBBRG100_SLV23_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV23_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_24
assign	ps24_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV24_OFFSET_LSB], {`ATCAPBBRG100_SLV24_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV24_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_25
assign	ps25_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV25_OFFSET_LSB], {`ATCAPBBRG100_SLV25_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV25_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_26
assign	ps26_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV26_OFFSET_LSB], {`ATCAPBBRG100_SLV26_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV26_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_27
assign	ps27_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV27_OFFSET_LSB], {`ATCAPBBRG100_SLV27_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV27_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_28
assign	ps28_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV28_OFFSET_LSB], {`ATCAPBBRG100_SLV28_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV28_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_29
assign	ps29_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV29_OFFSET_LSB], {`ATCAPBBRG100_SLV29_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV29_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_30
assign	ps30_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV30_OFFSET_LSB], {`ATCAPBBRG100_SLV30_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV30_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_31
assign	ps31_psel	= dec_en & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV31_OFFSET_LSB], {`ATCAPBBRG100_SLV31_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV31_OFFSET);
`endif
// VPERL_GENERATED_END
// The decoder register file is slave 0
assign	ps0_pready	= 1'b1;
assign	ps0_pslverr	= 1'b0;

// VPERL_BEGIN
// printf("
// assign	ps0_prdata	= ~ps0_psel ? 33'h0 :
//	\t(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h0) ? {1'b0,`ATCAPBBRG100_PRODUCT_ID} :
//	\t(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h5) ? {32'h0, wbuf_en} :
// ");
// for my $i (1..31) {
// printf("
//`ifdef ATCAPBBRG100_SLV_${i}
//	\t(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h%x) ? `ATCAPBBRG100_SLV${i}_CFG_REG :
//`endif
// ", $i+7);
// }
// printf("\t33'h0;\n");
// VPERL_END

// VPERL_GENERATED_BEGIN

assign	ps0_prdata	= ~ps0_psel ? 33'h0 :
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h0) ? {1'b0,`ATCAPBBRG100_PRODUCT_ID} :
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h5) ? {32'h0, wbuf_en} :

`ifdef ATCAPBBRG100_SLV_1
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h8) ? `ATCAPBBRG100_SLV1_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_2
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h9) ? `ATCAPBBRG100_SLV2_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_3
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'ha) ? `ATCAPBBRG100_SLV3_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_4
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'hb) ? `ATCAPBBRG100_SLV4_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_5
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'hc) ? `ATCAPBBRG100_SLV5_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_6
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'hd) ? `ATCAPBBRG100_SLV6_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_7
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'he) ? `ATCAPBBRG100_SLV7_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_8
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'hf) ? `ATCAPBBRG100_SLV8_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_9
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h10) ? `ATCAPBBRG100_SLV9_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_10
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h11) ? `ATCAPBBRG100_SLV10_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_11
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h12) ? `ATCAPBBRG100_SLV11_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_12
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h13) ? `ATCAPBBRG100_SLV12_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_13
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h14) ? `ATCAPBBRG100_SLV13_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_14
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h15) ? `ATCAPBBRG100_SLV14_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_15
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h16) ? `ATCAPBBRG100_SLV15_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_16
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h17) ? `ATCAPBBRG100_SLV16_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_17
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h18) ? `ATCAPBBRG100_SLV17_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_18
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h19) ? `ATCAPBBRG100_SLV18_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_19
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1a) ? `ATCAPBBRG100_SLV19_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_20
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1b) ? `ATCAPBBRG100_SLV20_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_21
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1c) ? `ATCAPBBRG100_SLV21_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_22
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1d) ? `ATCAPBBRG100_SLV22_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_23
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1e) ? `ATCAPBBRG100_SLV23_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_24
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1f) ? `ATCAPBBRG100_SLV24_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_25
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h20) ? `ATCAPBBRG100_SLV25_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_26
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h21) ? `ATCAPBBRG100_SLV26_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_27
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h22) ? `ATCAPBBRG100_SLV27_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_28
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h23) ? `ATCAPBBRG100_SLV28_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_29
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h24) ? `ATCAPBBRG100_SLV29_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_30
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h25) ? `ATCAPBBRG100_SLV30_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_31
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h26) ? `ATCAPBBRG100_SLV31_CFG_REG :
`endif
	33'h0;
// VPERL_GENERATED_END

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		wbuf_en		<= 1'b0;
	else if (ps0_psel & ps0_pready & pwrite & penable & 
		 (paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h5))
		wbuf_en		<= pwdata[0];
end

endmodule
