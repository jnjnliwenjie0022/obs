`include "global.inc"
`include "local.inc"

module kv_fpu_dsu (
    // VPERL: &PORTLIST
    // VPERL_GENERATED_BEGIN
    	  ds_result0, // calculation result
    	  ds_result1, // ds_result0 - 1
    	  ds_busy,   // Indicate DSU is busy
    	  ds_gen_sticky, // In generate sticky state
    	  ds_calc_done,
    	  ds_din0,   // Dividend or Radicand
    	  ds_din1,   // Divisor
    	  ds_invalidate, // invalidate current operation
    	  ds_type,   // operation type: 0/1/2 => DP/SP/HP
    	  div_enable,
    	  sqrt_enable,
    	  f3_stall, 
    	  core_clk, 
    	  core_reset_n 
    // VPERL_GENERATED_END
);

parameter  FLEN 		= 32;

localparam DS_COUNT_WIDTH	= (FLEN == 64 ) ? 5 :
				  (FLEN == 32)  ? 4 : 3;
localparam FRACTION_WIDTH	= (FLEN == 64) ? 53 :
				  (FLEN == 32) ? 24 : 11;

localparam DS_COUNT_MSB		= DS_COUNT_WIDTH-1;
localparam DS_DIN_WIDTH  	= FRACTION_WIDTH +1;
localparam DS_DIN_MSB    	= DS_DIN_WIDTH   -1;
localparam DS_DOUT_WIDTH 	= FRACTION_WIDTH +5;
localparam DS_DOUT_MSB   	= DS_DOUT_WIDTH  -1;
localparam DS_QR_WIDTH		= FRACTION_WIDTH +2;
localparam DS_QR_MSB		= DS_QR_WIDTH -1;
localparam DS_SQRT_OP_WIDTH	= FRACTION_WIDTH +3;
localparam DS_SQRT_OP_MSB	= DS_SQRT_OP_WIDTH -1;


output  [DS_DOUT_MSB:0]	ds_result0;     // calculation result
output  [DS_DOUT_MSB:0] ds_result1;     // ds_result0 - 1
output          	ds_busy;        // Indicate DSU is busy
output          	ds_gen_sticky;  // In generate sticky state
//output          	ds_extra_sb;    // extra bit for DIV sticky calculation
output			ds_calc_done;

input   [DS_DIN_MSB:0] 	ds_din0;        // Dividend or Radicand
input   [DS_DIN_MSB:1]  ds_din1;        // Divisor

input           	ds_invalidate;  // invalidate current operation
input            [1:0]  ds_type;        // operation type: 0/1/2 => DP/SP/HP
input           	div_enable;
input           	sqrt_enable;
input           	f3_stall;

input           	core_clk;
input           	core_reset_n;

reg     [DS_DIN_MSB:1]  divisor;
wire    [53:1]          divisor_54b;
reg     [DS_QR_MSB:0]  	current_qr0;      // current quotient/root
reg     [DS_QR_MSB:0]   current_qr1;      // current_qr0 - 1

wire    [54:0]  	current_qr0_55b;  // current quotient/root double precision
wire    [54:0]   	current_qr1_55b;  // current_qr0 - 1 double precision

reg     [1:0]   	new_2bits_qr0;
reg     [1:0]   	new_2bits_qr1;
reg     [54:0]   	new_qr0_55b;
reg     [54:0]   	new_qr1_55b;

wire            	update_divisor;
wire            	update_current_qr;
wire    [DS_QR_MSB:0]  	current_qr0_nx;     // next of current_qr0
wire    [DS_QR_MSB:0]  	current_qr1_nx;     // next of current_qr1
wire            	new_q_ge_0;         // indicate qrst_out >= 0
wire            	new_q_gt_0;         // indicate qrst_out > 0

// Quotient/Root Selection Table
reg     [2:0]   	div_qst_out;        // DIV quotient selection table out
reg     [2:0]   	sqrt_rst_out;       // SQRT root selection table out

wire    [2:0]   	rst_index_x;        // index for root selection 
wire    [2:0]   	qrst_out;           // quotient/selection table out
wire    [2:0]   	qrst_index_x;
wire    [6:0]   	qrst_index_y;

wire            	qrst_index_y_c;
wire    [6:0]   	qrst_index_y_in0;
wire    [6:0]   	qrst_index_y_in1;

// Partail remainder related signals
reg     [DS_DOUT_MSB:1] shifted_pr_sum;     // Shifte left 2-bit
reg     [DS_DOUT_MSB:3] shifted_pr_cout;    // Shifte left 1-bit (aligned with sum)
wire    [57:1] 		shifted_pr_sum_58b;     // Shifte left 2-bit
wire    [57:3] 		shifted_pr_cout_58b;    // Shifte left 1-bit (aligned with sum)
reg     [55:0]  	sqrt_subtrahend_56b;
reg     [55:0]  	sqrt_addend_56b;
wire    [DS_SQRT_OP_MSB:0] sqrt_subtrahend;
wire    [DS_SQRT_OP_MSB:0] sqrt_addend;
reg     [DS_DOUT_MSB:0] selected_sqrt_opnd;
reg     [DS_DOUT_MSB:0] selected_divisor;
//reg             	ds_extra_sb;

wire            	update_shifted_pr;
wire    [DS_DOUT_MSB:1]	shifted_pr_sum_nx;
wire    [DS_DOUT_MSB:3] shifted_pr_cout_nx;

wire    [DS_DOUT_MSB:0] dsu_csa_in0;
wire    [DS_DOUT_MSB:0] dsu_csa_in1;
wire    [DS_DOUT_MSB:0] dsu_csa_cin;
wire    [DS_DOUT_MSB:0] dsu_csa_sum;
wire    [DS_DOUT_MSB:0] dsu_csa_cout;

// DSU State Machine related signals
reg     [1:0]   	ds_ctr_cs;
reg     [1:0]   	ds_ctr_ns;
reg             	ds_busy;
reg             	ds_op;          // 0: divide, 1: square-root
reg     [1:0]        	ds_op_type;     // 0: DP, 1: SP, 2: HP, 3:BF
reg     [DS_COUNT_MSB:0] ds_count;
wire	[4:0]		ds_count_5b;

wire            	ds_busy_nx;
wire            	idle_state;
wire            	calc_state;
wire            	nds_unused_init_state;
wire            	done_state;
wire            	ds_start;
wire            	ds_init;
wire            	update_ds_op;
wire    [DS_COUNT_MSB:0] ds_count_nx;
wire            	update_ds_count;
wire            	calc_done;
wire            	last_loop;
wire            	sqrt_1sr_loop;

parameter       DS_ST_IDLE = 2'b00;   // Idle
parameter       DS_ST_INIT = 2'b01;   // Init square-root
parameter       DS_ST_CALC = 2'b10;   // Calculation
parameter       DS_ST_DONE = 2'b11;   // Generate sticky bit

// DSU controller
assign ds_start = div_enable | sqrt_enable;
wire	ds_ctr_cs_en = (ds_ctr_cs != DS_ST_IDLE) | ds_start | ds_invalidate;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n)
        ds_ctr_cs <= DS_ST_IDLE;
    else if (ds_ctr_cs_en)
        ds_ctr_cs <= ds_ctr_ns;
end

always @* begin
    case (ds_ctr_cs)
        DS_ST_INIT: begin // Init Square-Root
            if (ds_invalidate)
                ds_ctr_ns = DS_ST_IDLE;
            else
                ds_ctr_ns = DS_ST_CALC;
        end
        DS_ST_CALC: begin // Calculation
            if (ds_invalidate)
                ds_ctr_ns = DS_ST_IDLE;
            else if (last_loop & !f3_stall)
                ds_ctr_ns = DS_ST_DONE;
            else
                ds_ctr_ns = DS_ST_CALC;
        end
        DS_ST_DONE: begin // Generate sticky bit
            if (ds_invalidate)		// 4. Due to 1, 2 and 3 below, this condition can be ignore because next state always be DS_ST_IDLE state
                ds_ctr_ns = DS_ST_IDLE;
//            else if (f3_stall)		// 1. Due to Vicuna pipeline, only one stall druing DSU running and DSU will stalled at DS_ST_CALC state
//                ds_ctr_ns = DS_ST_DONE;
//            else if (div_enable)		// 2. Due to Vicuna pipeline, only one DSU instruction in FPU pipeline, others are stalled in II stage
//                ds_ctr_ns = DS_ST_CALC;
//            else if (sqrt_enable)		// 3. Due to Vicuna pipeline, only one DSU instruction in FPU pipeline, others are stalled in II stage	
//                ds_ctr_ns = DS_ST_INIT;
            else
                ds_ctr_ns = DS_ST_IDLE;
        end
        DS_ST_IDLE: begin // IDLE state
            if (ds_invalidate)
                ds_ctr_ns = DS_ST_IDLE;
            else if (div_enable)
                ds_ctr_ns = DS_ST_CALC;
            else if (sqrt_enable)
                //ds_ctr_ns = DS_ST_INIT;
                ds_ctr_ns = DS_ST_CALC;
            else
                ds_ctr_ns = DS_ST_IDLE;
        end 
        `ifdef WITH_COV
        // pragma coverage off
        `endif	// WITH_COV
	default: ds_ctr_ns = 2'bx;
        `ifdef WITH_COV
        // pragma coverage on
        `endif	// WITH_COV
    endcase
end

assign idle_state = (ds_ctr_cs == DS_ST_IDLE);
assign nds_unused_init_state = (ds_ctr_cs == DS_ST_INIT);
assign calc_state = (ds_ctr_cs == DS_ST_CALC);
assign done_state = (ds_ctr_cs == DS_ST_DONE);

// ----------------------------
// Initialization
// ----------------------------

assign ds_init = ds_start & (idle_state | done_state);

// Divisor: the format is divisor[53].divisor[52:1].
// If DN is not support, the divisor[53] is always 1.
assign update_divisor = div_enable & (idle_state | done_state);

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        divisor <= {(DS_DIN_WIDTH-1){1'b0}};
    end
    else if (update_divisor) begin
        divisor <= ds_din1[DS_DIN_MSB:1];
    end
end

// Operation
assign update_ds_op = ds_init;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ds_op      <= 1'b0;
        ds_op_type <= 2'b0;
    end
    else if (update_ds_op) begin
        ds_op      <= sqrt_enable;
        ds_op_type <= ds_type;
    end
end

// Determine the # of calculation loops
assign calc_done = last_loop & calc_state;
assign last_loop = (ds_op_type == 2'b10)  ? (ds_count_5b == 5'd06) : //HP frantion:10
		   (ds_op_type == 2'b11)  ? (ds_count_5b == 5'd06) : //BF frantion:7
		   (ds_op_type == 2'b01)  ? (ds_count_5b == 5'd13) : //SP fraction:23
		   			    (ds_count_5b == 5'd27);  //DP fraction:
//assign last_loop = (ds_op_type == 2'b10) ? (ds_count_5b ==  5'd6) :
//		   (ds_op_type == 2'b11) ? (ds_count_5b ==  5'd6) :
//		   (ds_op_type == 2'b01) ? (ds_count_5b == 5'd13) : 
//		   			   (ds_count_5b == 5'd27) ;

assign update_ds_count = ds_init /*|init_state*/ | (!last_loop & calc_state);

//assign ds_count_nx = (init_state | calc_state) ? ds_count + {{DS_COUNT_MSB{1'b0}},1'b1} : 
assign ds_count_nx = calc_state ? ds_count + {{DS_COUNT_MSB{1'b0}},1'b1} : 
			        {{(DS_COUNT_WIDTH-1){1'b0}}, sqrt_enable};

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n)
        ds_count <= {DS_COUNT_WIDTH{1'b0}};
    else if (update_ds_count)
        ds_count <= ds_count_nx;
end

//`ifdef NDS_FPU_SP_SUPPORT
//assign	ds_count_5b = {1'b0, ds_count};
//`else
//assign	ds_count_5b = ds_count;
//`endif

// -------------------------------
// Quotient/Root Selection Table
// -------------------------------

//`ifdef NDS_FPU_SP_SUPPORT
//assign	shifted_pr_sum_58b  = {shifted_pr_sum[28:1], 29'b0};
//assign	shifted_pr_cout_58b = {shifted_pr_cout[28:3], 29'b0};
//assign	divisor_54b	    = {divisor[24:1], 29'b0};
//`else
//assign	shifted_pr_sum_58b  = shifted_pr_sum[57:1];
//assign	shifted_pr_cout_58b = shifted_pr_cout[57:3];
//assign	divisor_54b	    = divisor[53:1];
//`endif

assign qrst_index_y_in0 = shifted_pr_sum_58b[57:51];
assign qrst_index_y_in1 = shifted_pr_cout_58b[57:51];
assign qrst_index_y_c   = shifted_pr_sum_58b[50] & shifted_pr_cout_58b[50];
wire	[6:0]	qrst_index_y_add_op3;	
assign qrst_index_y_add_op3 = {6'd0, qrst_index_y_c};
kv_novf_adder_op3 #(.EW(7)) u_qrst_index_y (.sum(qrst_index_y), .op1(qrst_index_y_in0), .op2(qrst_index_y_in1), .op3(qrst_index_y_add_op3));

assign sqrt_1sr_loop = (ds_count_5b == 5'd1);
assign rst_index_x = sqrt_1sr_loop       ? 3'b101 :
                     current_qr0_55b[54] ? 3'b111 : current_qr0_55b[52:50];

assign qrst_index_x = ds_op ? rst_index_x : divisor_54b[52:50];

// Divide QST
always @* begin
    case (qrst_index_y)
        // Positive paritail remainder
        7'b0000_000: begin
            div_qst_out = 3'b000;
        end
        7'b0000_001: begin
            div_qst_out = 3'b000;
        end
        7'b0000_010: begin
            div_qst_out = 3'b000;
        end
        7'b0000_011: begin
            div_qst_out = 3'b000;
        end
        7'b0000_100: begin
            case (qrst_index_x)
                3'b000: div_qst_out = 3'b001;
                3'b001: div_qst_out = 3'b001;
                3'b010: div_qst_out = 3'b001;
                3'b011: div_qst_out = 3'b001;
                default: begin
                    div_qst_out = 3'b000;
                end
            endcase
        end
        7'b0000_101: begin
            case (qrst_index_x)
                3'b000: div_qst_out = 3'b001;
                3'b001: div_qst_out = 3'b001;
                3'b010: div_qst_out = 3'b001;
                3'b011: div_qst_out = 3'b001;
                default: begin
                    div_qst_out = 3'b000;
                end
            endcase
        end
        7'b0000_110: begin
            div_qst_out = 3'b001;
        end
        7'b0000_111: begin
            div_qst_out = 3'b001;
        end
        7'b0001_000: begin
            div_qst_out = 3'b001;
        end
        7'b0001_001: begin
            div_qst_out = 3'b001;
        end
        7'b0001_010: begin
            div_qst_out = 3'b001;
        end
        7'b0001_011: begin
            div_qst_out = 3'b001;
        end
        7'b0001_100: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b010;
                default: div_qst_out = 3'b001;
            endcase
        end
        7'b0001_101: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b010;
                default: div_qst_out = 3'b001;
            endcase
        end
        7'b0001_110: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b010;
                3'b001:  div_qst_out = 3'b010;
                default: div_qst_out = 3'b001;
            endcase
        end
        7'b0001_111: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b010;
                3'b001:  div_qst_out = 3'b010;
                default: div_qst_out = 3'b001;
            endcase
        end
        7'b0010_000: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b010;
                3'b001:  div_qst_out = 3'b010;
                3'b010:  div_qst_out = 3'b010;
                3'b011:  div_qst_out = 3'b010;
                default: div_qst_out = 3'b001;
            endcase
        end
        7'b0010_001: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b010;
                3'b001:  div_qst_out = 3'b010;
                3'b010:  div_qst_out = 3'b010;
                3'b011:  div_qst_out = 3'b010;
                default: div_qst_out = 3'b001;
            endcase
        end
        7'b0010_010: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b010;
                3'b001:  div_qst_out = 3'b010;
                3'b010:  div_qst_out = 3'b010;
                3'b011:  div_qst_out = 3'b010;
                default: div_qst_out = 3'b001;
            endcase
        end
        7'b0010_011: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b010;
                3'b001:  div_qst_out = 3'b010;
                3'b010:  div_qst_out = 3'b010;
                3'b011:  div_qst_out = 3'b010;
                3'b100:  div_qst_out = 3'b010;
                default: div_qst_out = 3'b001;
            endcase
        end
        7'b0010_100: begin
            case (qrst_index_x)
                3'b110:  div_qst_out = 3'b001;
                3'b111:  div_qst_out = 3'b001;
                default: div_qst_out = 3'b010;
            endcase
        end
        7'b0010_101: begin
            case (qrst_index_x)
                3'b110:  div_qst_out = 3'b001;
                3'b111:  div_qst_out = 3'b001;
                default: div_qst_out = 3'b010;
            endcase
        end
        // Negative partial remainder
        7'b1111_111: begin
            div_qst_out = 3'b000;
        end
        7'b1111_110: begin
            div_qst_out = 3'b000;
        end
        7'b1111_101: begin
            div_qst_out = 3'b000;
        end
        7'b1111_100: begin
            div_qst_out = 3'b000;
        end
        7'b1111_011: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b111;
                3'b001:  div_qst_out = 3'b111;
                default: div_qst_out = 3'b000;
            endcase
        end
        7'b1111_010: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b111;
                3'b001:  div_qst_out = 3'b111;
                default: div_qst_out = 3'b000;
            endcase
        end
        7'b1111_001: begin
            div_qst_out = 3'b111;
        end
        7'b1111_000: begin
            div_qst_out = 3'b111;
        end
        7'b1110_111: begin
            div_qst_out = 3'b111;
        end
        7'b1110_110: begin
            div_qst_out = 3'b111;
        end
        7'b1110_101: begin
            div_qst_out = 3'b111;
        end
        7'b1110_100: begin
            div_qst_out = 3'b111;
        end
        7'b1110_011: begin
            div_qst_out = 3'b111;
            //case (qrst_index_x)
            //    3'b000:  div_qst_out = 3'b110;
            //    default: div_qst_out = 3'b111;
            //endcase
        end
        7'b1110_010: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b110;
                default: div_qst_out = 3'b111;
            endcase
        end
        7'b1110_001: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b110;
                3'b001:  div_qst_out = 3'b110;
                default: div_qst_out = 3'b111;
            endcase
        end
        7'b1110_000: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b110;
                3'b001:  div_qst_out = 3'b110;
                default: div_qst_out = 3'b111;
            endcase
        end
        7'b1101_111: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b110;
                3'b001:  div_qst_out = 3'b110;
                3'b010:  div_qst_out = 3'b110;
            //    3'b011:  div_qst_out = 3'b110;
                default: div_qst_out = 3'b111;
            endcase
        end
        7'b1101_110: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b110;
                3'b001:  div_qst_out = 3'b110;
                3'b010:  div_qst_out = 3'b110;
                3'b011:  div_qst_out = 3'b110;
                default: div_qst_out = 3'b111;
            endcase
        end
        7'b1101_101: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b110;
                3'b001:  div_qst_out = 3'b110;
                3'b010:  div_qst_out = 3'b110;
                3'b011:  div_qst_out = 3'b110;
                default: div_qst_out = 3'b111;
            endcase
        end
        7'b1101_100: begin
            case (qrst_index_x)
                3'b000:  div_qst_out = 3'b110;
                3'b001:  div_qst_out = 3'b110;
                3'b010:  div_qst_out = 3'b110;
                3'b011:  div_qst_out = 3'b110;
                default: div_qst_out = 3'b111;
            endcase
        end
        7'b1101_011: begin
            case (qrst_index_x)
                3'b110:  div_qst_out = 3'b111;
                3'b111:  div_qst_out = 3'b111;
                default: div_qst_out = 3'b110;
            endcase
        end
        7'b1101_010: begin
            case (qrst_index_x)
                3'b110:  div_qst_out = 3'b111;
                3'b111:  div_qst_out = 3'b111;
                default: div_qst_out = 3'b110;
            endcase
        end
        // The partial Q of all qrst_index_x is equal to 2'b10
        default: begin
            div_qst_out = {qrst_index_y[6], 2'b10};
        end
    endcase
end

// Square-Root RST

always @* begin
    //case ({qrst_index_y[6:3], qrst_index_y[2:1]})
    case ({qrst_index_y})
        // Positive
        7'b0000_000: begin
            sqrt_rst_out = 3'b000;
        end
        7'b0000_001: begin
            sqrt_rst_out = 3'b000;
        end
        7'b0000_010: begin
            sqrt_rst_out = 3'b000;
        end
        7'b0000_011: begin
            sqrt_rst_out = 3'b000;
        end
        7'b0000_100: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b001;
                3'b001: sqrt_rst_out = 3'b001;
                3'b010: sqrt_rst_out = 3'b001;
                3'b011: sqrt_rst_out = 3'b001;
                default: sqrt_rst_out = 3'b000;
            endcase
        end
        7'b0000_101: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b001;
                3'b001: sqrt_rst_out = 3'b001;
                3'b010: sqrt_rst_out = 3'b001;
                3'b011: sqrt_rst_out = 3'b001;
                default: sqrt_rst_out = 3'b000;
            endcase
        end
        7'b0000_110: begin
            case (qrst_index_x)
                3'b110: sqrt_rst_out = 3'b000;
                3'b111: sqrt_rst_out = 3'b000;
                default: sqrt_rst_out = 3'b001;
            endcase
        end
        7'b0000_111: begin
            case (qrst_index_x)
                3'b110: sqrt_rst_out = 3'b000;
                3'b111: sqrt_rst_out = 3'b000;
                default: sqrt_rst_out = 3'b001;
            endcase
        end
        7'b0001_000: begin
            sqrt_rst_out = 3'b001;
        end
        7'b0001_001: begin
            sqrt_rst_out = 3'b001;
        end
        7'b0001_010: begin
            sqrt_rst_out = 3'b001;
        end
        7'b0001_011: begin
            sqrt_rst_out = 3'b001;
        end
        7'b0001_100: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b010;
                default: sqrt_rst_out = 3'b001;
            endcase
        end
        7'b0001_101: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b010;
                default: sqrt_rst_out = 3'b001;
            endcase
        end
        7'b0001_110: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b010;
                3'b001: sqrt_rst_out = 3'b010;
                default: sqrt_rst_out = 3'b001;
            endcase
        end
        7'b0001_111: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b010;
                3'b001: sqrt_rst_out = 3'b010;
                default: sqrt_rst_out = 3'b001;
            endcase
        end
        7'b0010_000: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b010;
                3'b001: sqrt_rst_out = 3'b010;
                3'b010: sqrt_rst_out = 3'b010;
                3'b011: sqrt_rst_out = 3'b010;  // new
                default: sqrt_rst_out = 3'b001;
            endcase
        end
        7'b0010_001: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b010;
                3'b001: sqrt_rst_out = 3'b010;
                3'b010: sqrt_rst_out = 3'b010;
                3'b011: sqrt_rst_out = 3'b010;  // new
                default: sqrt_rst_out = 3'b001;
            endcase
        end
        7'b0010_010: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b010;
                3'b001: sqrt_rst_out = 3'b010;
                3'b010: sqrt_rst_out = 3'b010;
                3'b011: sqrt_rst_out = 3'b010;
                3'b100: sqrt_rst_out = 3'b010;
                default: sqrt_rst_out = 3'b001;
            endcase
        end
        7'b0010_011: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b010;
                3'b001: sqrt_rst_out = 3'b010;
                3'b010: sqrt_rst_out = 3'b010;
                3'b011: sqrt_rst_out = 3'b010;
                3'b100: sqrt_rst_out = 3'b010;
                default: sqrt_rst_out = 3'b001;
            endcase
        end
        7'b0010_100: begin
            case (qrst_index_x)
                3'b111: sqrt_rst_out = 3'b001;
                default: sqrt_rst_out = 3'b010;
            endcase
        end
        7'b0010_101: begin
            case (qrst_index_x)
                3'b111: sqrt_rst_out = 3'b001;
                default: sqrt_rst_out = 3'b010;
            endcase
        end
        7'b0010_110: begin
            sqrt_rst_out = 3'b010;
            //case (qrst_index_x)
            //    3'b111: sqrt_rst_out = 3'b001;
            //    default: sqrt_rst_out = 3'b010;
            //endcase
        end
        7'b0010_111: begin
            sqrt_rst_out = 3'b010;
        end
        7'b0011_000: begin
            sqrt_rst_out = 3'b010;
        end
        7'b0011_001: begin
            sqrt_rst_out = 3'b010;
        end
        7'b0011_010: begin
            sqrt_rst_out = 3'b010;
        end
        7'b0011_011: begin
            sqrt_rst_out = 3'b010;
        end
        7'b0011_100: begin
            sqrt_rst_out = 3'b010;
        end
        7'b0011_101: begin
            sqrt_rst_out = 3'b010;
        end
        7'b0011_110: begin
            sqrt_rst_out = 3'b010;
        end
        7'b0011_111: begin
            sqrt_rst_out = 3'b010;
        end

        // Negative
        7'b1100_000: begin
            sqrt_rst_out = 3'b110;
        end
        7'b1100_001: begin
            sqrt_rst_out = 3'b110;
        end
        7'b1100_010: begin
            sqrt_rst_out = 3'b110;
        end
        7'b1100_011: begin
            sqrt_rst_out = 3'b110;
        end
        7'b1100_100: begin
            sqrt_rst_out = 3'b110;
        end
        7'b1100_101: begin
            sqrt_rst_out = 3'b110;
        end
        7'b1100_110: begin
            sqrt_rst_out = 3'b110;
        end
        7'b1100_111: begin
            sqrt_rst_out = 3'b110;
        end
        7'b1101_000: begin
            sqrt_rst_out = 3'b110;
            //case (qrst_index_x)
            //    3'b111: sqrt_rst_out = 3'b111;
            //    default: sqrt_rst_out = 3'b110;
            //endcase
        end
        7'b1101_001: begin // -23/8
            case (qrst_index_x)
                3'b111: sqrt_rst_out = 3'b111;
                default: sqrt_rst_out = 3'b110;
            endcase
        end
        7'b1101_010: begin // -22/8
            case (qrst_index_x)
                3'b110: sqrt_rst_out = 3'b111;
                3'b111: sqrt_rst_out = 3'b111;
                default: sqrt_rst_out = 3'b110;
            endcase
        end
        7'b1101_011: begin // -21/8
            case (qrst_index_x)
                3'b110: sqrt_rst_out = 3'b111;
                3'b111: sqrt_rst_out = 3'b111;
                default: sqrt_rst_out = 3'b110;
            endcase
        end
        7'b1101_100: begin  // -5/2
            case (qrst_index_x)
                3'b101: sqrt_rst_out = 3'b111;
                3'b110: sqrt_rst_out = 3'b111;
                3'b111: sqrt_rst_out = 3'b111;
                default: sqrt_rst_out = 3'b110;
            endcase
        end
        7'b1101_101: begin // -19/8
            case (qrst_index_x)
                3'b101: sqrt_rst_out = 3'b111;
                3'b110: sqrt_rst_out = 3'b111;
                3'b111: sqrt_rst_out = 3'b111;
                default: sqrt_rst_out = 3'b110;
            endcase
        end
        7'b1101_110: begin // -18/8
            case (qrst_index_x)
                3'b100: sqrt_rst_out = 3'b111;
                3'b101: sqrt_rst_out = 3'b111;
                3'b110: sqrt_rst_out = 3'b111;
                3'b111: sqrt_rst_out = 3'b111;
                default: sqrt_rst_out = 3'b110;
            endcase
        end
        7'b1101_111: begin // -17/8
            case (qrst_index_x)
                3'b011: sqrt_rst_out = 3'b111;
                3'b100: sqrt_rst_out = 3'b111;
                3'b101: sqrt_rst_out = 3'b111;
                3'b110: sqrt_rst_out = 3'b111;
                3'b111: sqrt_rst_out = 3'b111;
                default: sqrt_rst_out = 3'b110;
            endcase
        end
        7'b1110_000: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b110;
                3'b001: sqrt_rst_out = 3'b110;
                default: sqrt_rst_out = 3'b111;
            endcase
        end
        7'b1110_001: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b110;
                3'b001: sqrt_rst_out = 3'b110;
                default: sqrt_rst_out = 3'b111;
            endcase
        end
        7'b1110_010: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b110;
                default: sqrt_rst_out = 3'b111;
            endcase
        end
        7'b1110_011: begin
            sqrt_rst_out = 3'b111;
        end
        7'b1110_100: begin
            sqrt_rst_out = 3'b111;
        end
        7'b1110_101: begin
            sqrt_rst_out = 3'b111;
        end
        7'b1110_110: begin
            sqrt_rst_out = 3'b111;
        end
        7'b1110_111: begin
            sqrt_rst_out = 3'b111;
        end
        7'b1111_000: begin
            case (qrst_index_x)
                3'b101: sqrt_rst_out = 3'b000;
                3'b110: sqrt_rst_out = 3'b000;
                3'b111: sqrt_rst_out = 3'b000;
                default: sqrt_rst_out = 3'b111;
            endcase
        end
        7'b1111_001: begin
            case (qrst_index_x)
                3'b101: sqrt_rst_out = 3'b000;
                3'b110: sqrt_rst_out = 3'b000;
                3'b111: sqrt_rst_out = 3'b000;
                default: sqrt_rst_out = 3'b111;
            endcase
        end
        7'b1111_010: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b111;
                3'b001: sqrt_rst_out = 3'b111;
                default: sqrt_rst_out = 3'b000;
            endcase
        end
        7'b1111_011: begin
            case (qrst_index_x)
                3'b000: sqrt_rst_out = 3'b111;
                default: sqrt_rst_out = 3'b000;
            endcase
        end
        7'b1111_100: begin
            sqrt_rst_out = 3'b000;
        end
        7'b1111_101: begin
            sqrt_rst_out = 3'b000;
        end
        7'b1111_110: begin
            sqrt_rst_out = 3'b000;
        end
        7'b1111_111: begin
            sqrt_rst_out = 3'b000;
        end
        default: sqrt_rst_out = {qrst_index_y[6], 2'b10};
    endcase
end

assign qrst_out = ds_op ? sqrt_rst_out : div_qst_out;

// Determine new 2 bits of quotient/root
always @* begin
    case (qrst_out)
        3'b001: begin   // 1
            new_2bits_qr0 = 2'b01;
            new_2bits_qr1 = 2'b00;
        end
        3'b010: begin   // 2
            new_2bits_qr0 = 2'b10;
            new_2bits_qr1 = 2'b01;
        end
        3'b110: begin // -2
            new_2bits_qr0 = 2'b10;
            new_2bits_qr1 = 2'b01;
        end
        3'b111: begin // -1
            new_2bits_qr0 = 2'b11;
            new_2bits_qr1 = 2'b10;
        end
        default: begin   // 0, 3, -3, -4
            new_2bits_qr0 = 2'b00;
            new_2bits_qr1 = 2'b11;
        end
    endcase
end

assign new_q_ge_0 = !qrst_out[2];
assign new_q_gt_0 = !qrst_out[2] & |qrst_out[1:0];

// Generate next quotient/root during calculation
always @* begin
    case (ds_count_5b)
        5'd0: begin
            new_qr0_55b = {new_2bits_qr0[0], 54'd0};
            new_qr1_55b = {new_2bits_qr1[0], 54'd0};
        end
        5'd1: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54], new_2bits_qr0, 52'd0} :
                                       {current_qr1_55b[54], new_2bits_qr0, 52'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54], new_2bits_qr1, 52'd0} :
                                       {current_qr1_55b[54], new_2bits_qr1, 52'd0};
        end
        5'd2: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:52], new_2bits_qr0, 50'd0} :
                                       {current_qr1_55b[54:52], new_2bits_qr0, 50'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:52], new_2bits_qr1, 50'd0} :
                                       {current_qr1_55b[54:52], new_2bits_qr1, 50'd0};
        end
        5'd3: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:50], new_2bits_qr0, 48'd0} :
                                       {current_qr1_55b[54:50], new_2bits_qr0, 48'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:50], new_2bits_qr1, 48'd0} :
                                       {current_qr1_55b[54:50], new_2bits_qr1, 48'd0};
        end
        5'd4: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:48], new_2bits_qr0, 46'd0} :
                                       {current_qr1_55b[54:48], new_2bits_qr0, 46'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:48], new_2bits_qr1, 46'd0} :
                                       {current_qr1_55b[54:48], new_2bits_qr1, 46'd0};
        end
        5'd5: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:46], new_2bits_qr0, 44'd0} :
                                       {current_qr1_55b[54:46], new_2bits_qr0, 44'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:46], new_2bits_qr1, 44'd0} :
                                       {current_qr1_55b[54:46], new_2bits_qr1, 44'd0};
        end
        5'd6: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:44], new_2bits_qr0, 42'd0} :
                                       {current_qr1_55b[54:44], new_2bits_qr0, 42'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:44], new_2bits_qr1, 42'd0} :
                                       {current_qr1_55b[54:44], new_2bits_qr1, 42'd0};
        end
        5'd7: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:42], new_2bits_qr0, 40'd0} :
                                       {current_qr1_55b[54:42], new_2bits_qr0, 40'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:42], new_2bits_qr1, 40'd0} :
                                       {current_qr1_55b[54:42], new_2bits_qr1, 40'd0};
        end
        5'd8: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:40], new_2bits_qr0, 38'd0} :
                                       {current_qr1_55b[54:40], new_2bits_qr0, 38'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:40], new_2bits_qr1, 38'd0} :
                                       {current_qr1_55b[54:40], new_2bits_qr1, 38'd0};
        end
        5'd9: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:38], new_2bits_qr0, 36'd0} :
                                       {current_qr1_55b[54:38], new_2bits_qr0, 36'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:38], new_2bits_qr1, 36'd0} :
                                       {current_qr1_55b[54:38], new_2bits_qr1, 36'd0};
        end
        5'd10: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:36], new_2bits_qr0, 34'd0} :
                                       {current_qr1_55b[54:36], new_2bits_qr0, 34'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:36], new_2bits_qr1, 34'd0} :
                                       {current_qr1_55b[54:36], new_2bits_qr1, 34'd0};
        end
        5'd11: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:34], new_2bits_qr0, 32'd0} :
                                       {current_qr1_55b[54:34], new_2bits_qr0, 32'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:34], new_2bits_qr1, 32'd0} :
                                       {current_qr1_55b[54:34], new_2bits_qr1, 32'd0};
        end
        5'd12: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:32], new_2bits_qr0, 30'd0} :
                                       {current_qr1_55b[54:32], new_2bits_qr0, 30'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:32], new_2bits_qr1, 30'd0} :
                                       {current_qr1_55b[54:32], new_2bits_qr1, 30'd0};
        end
        5'd13: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:30], new_2bits_qr0, 28'd0} :
                                       {current_qr1_55b[54:30], new_2bits_qr0, 28'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:30], new_2bits_qr1, 28'd0} :
                                       {current_qr1_55b[54:30], new_2bits_qr1, 28'd0};
        end
        5'd14: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:28], new_2bits_qr0, 26'd0} :
                                       {current_qr1_55b[54:28], new_2bits_qr0, 26'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:28], new_2bits_qr1, 26'd0} :
                                       {current_qr1_55b[54:28], new_2bits_qr1, 26'd0};
        end
        5'd15: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:26], new_2bits_qr0, 24'd0} :
                                       {current_qr1_55b[54:26], new_2bits_qr0, 24'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:26], new_2bits_qr1, 24'd0} :
                                       {current_qr1_55b[54:26], new_2bits_qr1, 24'd0};
        end
        5'd16: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:24], new_2bits_qr0, 22'd0} :
                                       {current_qr1_55b[54:24], new_2bits_qr0, 22'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:24], new_2bits_qr1, 22'd0} :
                                       {current_qr1_55b[54:24], new_2bits_qr1, 22'd0};
        end
        5'd17: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:22], new_2bits_qr0, 20'd0} :
                                       {current_qr1_55b[54:22], new_2bits_qr0, 20'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:22], new_2bits_qr1, 20'd0} :
                                       {current_qr1_55b[54:22], new_2bits_qr1, 20'd0};
        end
        5'd18: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:20], new_2bits_qr0, 18'd0} :
                                       {current_qr1_55b[54:20], new_2bits_qr0, 18'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:20], new_2bits_qr1, 18'd0} :
                                       {current_qr1_55b[54:20], new_2bits_qr1, 18'd0};
        end
        5'd19: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:18], new_2bits_qr0, 16'd0} :
                                       {current_qr1_55b[54:18], new_2bits_qr0, 16'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:18], new_2bits_qr1, 16'd0} :
                                       {current_qr1_55b[54:18], new_2bits_qr1, 16'd0};
        end
        5'd20: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:16], new_2bits_qr0, 14'd0} :
                                       {current_qr1_55b[54:16], new_2bits_qr0, 14'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:16], new_2bits_qr1, 14'd0} :
                                       {current_qr1_55b[54:16], new_2bits_qr1, 14'd0};
        end
        5'd21: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:14], new_2bits_qr0, 12'd0} :
                                       {current_qr1_55b[54:14], new_2bits_qr0, 12'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:14], new_2bits_qr1, 12'd0} :
                                       {current_qr1_55b[54:14], new_2bits_qr1, 12'd0};
        end
        5'd22: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:12], new_2bits_qr0, 10'd0} :
                                       {current_qr1_55b[54:12], new_2bits_qr0, 10'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:12], new_2bits_qr1, 10'd0} :
                                       {current_qr1_55b[54:12], new_2bits_qr1, 10'd0};
        end
        5'd23: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:10], new_2bits_qr0, 8'd0} :
                                       {current_qr1_55b[54:10], new_2bits_qr0, 8'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:10], new_2bits_qr1, 8'd0} :
                                       {current_qr1_55b[54:10], new_2bits_qr1, 8'd0};
        end
        5'd24: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:8], new_2bits_qr0, 6'd0} :
                                       {current_qr1_55b[54:8], new_2bits_qr0, 6'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:8], new_2bits_qr1, 6'd0} :
                                       {current_qr1_55b[54:8], new_2bits_qr1, 6'd0};
        end
        5'd25: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:6],  new_2bits_qr0, 4'd0} :
                                       {current_qr1_55b[54:6],  new_2bits_qr0, 4'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:6],  new_2bits_qr1, 4'd0} :
                                       {current_qr1_55b[54:6],  new_2bits_qr1, 4'd0};
        end
        5'd26: begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:4],  new_2bits_qr0, 2'd0} :
                                       {current_qr1_55b[54:4],  new_2bits_qr0, 2'd0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:4],  new_2bits_qr1, 2'd0} :
                                       {current_qr1_55b[54:4],  new_2bits_qr1, 2'd0};
        end
        default begin
            new_qr0_55b = new_q_ge_0 ? {current_qr0_55b[54:2],  new_2bits_qr0} :
                                       {current_qr1_55b[54:2],  new_2bits_qr0};
            new_qr1_55b = new_q_gt_0 ? {current_qr0_55b[54:2],  new_2bits_qr1} :
                                       {current_qr1_55b[54:2],  new_2bits_qr1};
        end
    endcase
end

// Quotient register format:
//  - current_qr[54].current_qr[53:0]
//  - The last 2 bits are guard bits

assign current_qr0_nx = //init_state ? {1'b1, {(DS_QR_WIDTH-1){1'b0}}} :
                        calc_state ? new_qr0_55b[54:54-DS_QR_MSB]    :
                                     {sqrt_enable, {(DS_QR_WIDTH-1){1'b0}}};

assign update_current_qr = ds_init /*| init_state*/ | calc_state & (!last_loop | !f3_stall);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n)
        current_qr0 <= {DS_QR_WIDTH{1'b0}};
    else if (update_current_qr)
        current_qr0 <= current_qr0_nx;
end

assign current_qr1_nx = //init_state ? {1'b0, {(DS_QR_WIDTH-1){1'b0}}} :
                        calc_state ? new_qr1_55b[54:54-DS_QR_MSB]    :
                                     {DS_QR_WIDTH{1'b0}};

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n)
        current_qr1 <= {DS_QR_WIDTH{1'b0}};
    else if (update_current_qr)
        current_qr1 <= current_qr1_nx;
end

// Generate muniend for SQRT calculation

//`ifdef NDS_FPU_SP_SUPPORT
//assign	current_qr0_55b = {current_qr0, 29'b0};
//assign	current_qr1_55b = {current_qr1, 29'b0};
//`else
//assign	current_qr0_55b = current_qr0;
//assign	current_qr1_55b = current_qr1;
//`endif

always @* begin
    case(ds_count_5b)
        //5'd0: begin
        //    sqrt_subtrahend_56b = {1'b0, 55'd0};
        //    sqrt_addend_56b     = {1'b0, 55'd0};
        //end
        5'd1: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54], sqrt_rst_out, 52'd0};
            sqrt_addend_56b     = {current_qr1_55b[54], sqrt_rst_out, 52'd0};
        end
        5'd2: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:52], sqrt_rst_out, 50'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:52], sqrt_rst_out, 50'd0};
        end
        5'd3: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:50], sqrt_rst_out, 48'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:50], sqrt_rst_out, 48'd0};
        end
        5'd4: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:48], sqrt_rst_out, 46'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:48], sqrt_rst_out, 46'd0};
        end
        5'd5: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:46], sqrt_rst_out, 44'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:46], sqrt_rst_out, 44'd0};
        end
        5'd6: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:44], sqrt_rst_out, 42'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:44], sqrt_rst_out, 42'd0};
        end
        5'd7: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:42], sqrt_rst_out, 40'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:42], sqrt_rst_out, 40'd0};
        end
        5'd8: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:40], sqrt_rst_out, 38'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:40], sqrt_rst_out, 38'd0};
        end
        5'd9: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:38], sqrt_rst_out, 36'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:38], sqrt_rst_out, 36'd0};
        end
        5'd10: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:36], sqrt_rst_out, 34'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:36], sqrt_rst_out, 34'd0};
        end
        5'd11: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:34], sqrt_rst_out, 32'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:34], sqrt_rst_out, 32'd0};
        end
        5'd12: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:32], sqrt_rst_out, 30'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:32], sqrt_rst_out, 30'd0};
        end
        5'd13: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:30], sqrt_rst_out, 28'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:30], sqrt_rst_out, 28'd0};
        end
        5'd14: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:28], sqrt_rst_out, 26'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:28], sqrt_rst_out, 26'd0};
        end
        5'd15: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:26], sqrt_rst_out, 24'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:26], sqrt_rst_out, 24'd0};
        end
        5'd16: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:24], sqrt_rst_out, 22'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:24], sqrt_rst_out, 22'd0};
        end
        5'd17: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:22], sqrt_rst_out, 20'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:22], sqrt_rst_out, 20'd0};
        end
        5'd18: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:20], sqrt_rst_out, 18'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:20], sqrt_rst_out, 18'd0};
        end
        5'd19: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:18], sqrt_rst_out, 16'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:18], sqrt_rst_out, 16'd0};
        end
        5'd20: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:16], sqrt_rst_out, 14'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:16], sqrt_rst_out, 14'd0};
        end
        5'd21: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:14], sqrt_rst_out, 12'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:14], sqrt_rst_out, 12'd0};
        end
        5'd22: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:12], sqrt_rst_out, 10'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:12], sqrt_rst_out, 10'd0};
        end
        5'd23: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:10], sqrt_rst_out, 8'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:10], sqrt_rst_out, 8'd0};
        end
        5'd24: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:8],  sqrt_rst_out, 6'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:8],  sqrt_rst_out, 6'd0};
        end
        5'd25: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:6],  sqrt_rst_out, 4'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:6],  sqrt_rst_out, 4'd0};
        end
        5'd26: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:4],  sqrt_rst_out, 2'd0};
            sqrt_addend_56b     = {current_qr1_55b[54:4],  sqrt_rst_out, 2'd0};
        end
        5'd27: begin
            sqrt_subtrahend_56b = {current_qr0_55b[54:2],  sqrt_rst_out};
            sqrt_addend_56b     = {current_qr1_55b[54:2],  sqrt_rst_out};
        end
        default: begin
            sqrt_subtrahend_56b = 56'd0;
            sqrt_addend_56b     = 56'd0;
        end
    endcase
end

//`ifdef NDS_FPU_SP_SUPPORT
//assign sqrt_subtrahend = sqrt_subtrahend_56b[55:29];
//assign sqrt_addend     = sqrt_addend_56b[55:29];
//`else
//assign sqrt_subtrahend = sqrt_subtrahend_56b;
//assign sqrt_addend     = sqrt_addend_56b;
//`endif

always @* begin
    case (sqrt_rst_out)
        3'b000: selected_sqrt_opnd =  {DS_DOUT_WIDTH{1'b0}};    // 0
        3'b001: selected_sqrt_opnd = ~{2'd0, sqrt_subtrahend};  // 1
        3'b010: selected_sqrt_opnd = ~{1'd0, sqrt_subtrahend, 1'b0}; // 2
        3'b110: selected_sqrt_opnd =  {1'd0, sqrt_addend, 1'b0}; // -2
        3'b111: selected_sqrt_opnd =  {2'd0, sqrt_addend};  // -1
        default: selected_sqrt_opnd =  {DS_DOUT_WIDTH{1'b0}};
    endcase
end

// Determine the addition or subtraction & how many multiple of divisor
always @* begin
    case (div_qst_out)
        3'b000: selected_divisor =   {DS_DOUT_WIDTH{1'b0}}; // 0
        3'b001: selected_divisor = ~{3'd0, divisor, 2'd0}; // (-1x)-1
        3'b010: selected_divisor = ~{2'd0, divisor, 3'd0}; // (-2x)-1
        3'b110: selected_divisor =  {2'd0, divisor, 3'd0}; // 2x
        3'b111: selected_divisor =  {3'd0, divisor, 2'd0}; // 1x
        default: selected_divisor =  {DS_DOUT_WIDTH{1'b0}}; // 3, -3, and -4
    endcase
end

// Shifted partial remainder in carry saved form.
// The format of shifted_pr_sum and shifted_pr_cout is
//  - Integer:  bit 57 - 54
//  - Fraction: bit 53 - 1

assign update_shifted_pr = ds_init /*| init_state*/ | calc_state & !last_loop;

assign shifted_pr_sum_nx[DS_DOUT_MSB:1] = {DS_DOUT_MSB{sqrt_enable}} & {2'b11, ds_din0[DS_DIN_MSB:0], 1'b0} 
				        | {DS_DOUT_MSB{div_enable}}  & {3'd0, ds_din0[DS_DIN_MSB:0]}
					| {DS_DOUT_MSB{calc_state}}  & {dsu_csa_sum[DS_DOUT_MSB-2:0], 1'b0}
					;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n)
        shifted_pr_sum[DS_DOUT_MSB:1] <= {(DS_DOUT_WIDTH-1){1'b0}};
    else if (update_shifted_pr)
        shifted_pr_sum[DS_DOUT_MSB:1] <= shifted_pr_sum_nx[DS_DOUT_MSB:1];
end

assign shifted_pr_cout_nx[DS_DOUT_MSB:3] = calc_state ? dsu_csa_cout[DS_DOUT_MSB-3:0] : {(DS_DOUT_WIDTH-3){1'b0}};

always @(posedge core_clk or negedge core_reset_n) begin
     if (!core_reset_n)
	shifted_pr_cout[DS_DOUT_MSB:3] <= {(DS_DOUT_WIDTH-3){1'b0}};
     else if (update_shifted_pr)
        shifted_pr_cout[DS_DOUT_MSB:3] <= shifted_pr_cout_nx[DS_DOUT_MSB:3];
end

assign dsu_csa_in0 = {shifted_pr_sum[DS_DOUT_MSB:1], 1'b0};
assign dsu_csa_in1 =  ds_op ? selected_sqrt_opnd: selected_divisor;
assign dsu_csa_cin = {shifted_pr_cout[DS_DOUT_MSB:3], 2'd0, new_q_gt_0};

kv_csa3_2 #(.CSA_WIDTH(DS_DOUT_WIDTH)) u_dsu_csa (
    .in0 (dsu_csa_in0),
    .in1 (dsu_csa_in1),
    .cin (dsu_csa_cin),
    .sum (dsu_csa_sum),
    .cout(dsu_csa_cout)
    );

// Unused in Vicuna FPU
//always @(posedge core_clk or negedge core_reset_n) begin
//    if (!core_reset_n)
//        ds_extra_sb <= 1'b0;
//    else if (done_state)
//        ds_extra_sb <= ds_op_type & current_qr0_55b[29];
//end

// The format of ds_result is ds_result[57:55].ds_result[54:0]

//assign ds_result0 = calc_done ? dsu_csa_sum[DS_DOUT_MSB:0]              :
//                  !done_state ? {DS_DOUT_WIDTH{1'b0}}                   :
//`ifdef NDS_FPU_SP_SUPPORT
//                   ds_op_type ? {2'd0, current_qr0_55b[54:29], 1'b0}   :
//                                {      current_qr0_55b[27:0],  1'b0}   ;
//`else
//                   ds_op_type ? {31'd0, current_qr0_55b[54:29], 1'b0}   :
//                                { 2'd0, current_qr0_55b[54:0],  1'b0}   ;
//`endif

//assign ds_result1 = calc_done ? {dsu_csa_cout[(DS_DOUT_MSB-1):0], 1'b0} :
//                  !done_state ? {DS_DOUT_WIDTH{1'b0}}                   :
//`ifdef NDS_FPU_SP_SUPPORT
//                   ds_op_type ? {2'd0, current_qr1_55b[54:29], 1'b0}   :
//                                {      current_qr1_55b[27:0],  1'b0}   ;
//`else
//                   ds_op_type ? {31'd0, current_qr1_55b[54:29], 1'b0}   :
//                                { 2'd0, current_qr1_55b[54:0],  1'b0}   ;
//`endif

assign ds_gen_sticky = done_state;
assign ds_calc_done  = calc_done;

assign ds_busy_nx = (ds_ctr_ns == DS_ST_INIT) | (ds_ctr_ns == DS_ST_CALC);

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n)
        ds_busy <= 1'b0;
    else
        ds_busy <= ds_busy_nx;
end

wire nds_unused_partially_used_wires = |(divisor_54b) | (|shifted_pr_sum_58b) | (|shifted_pr_cout_58b) | (|dsu_csa_cout);

generate
if (FLEN == 16) begin : gen_fpu_dsu_hp
	assign	ds_count_5b = {2'b0, ds_count};

	assign	shifted_pr_sum_58b  = {shifted_pr_sum[15:1], 42'b0};
	assign	shifted_pr_cout_58b = {shifted_pr_cout[15:3], 42'b0};
	assign	divisor_54b	    = {divisor[11:1], 42'b0};

	assign	current_qr0_55b = {current_qr0, 42'b0};
	assign	current_qr1_55b = {current_qr1, 42'b0};

	assign sqrt_subtrahend = sqrt_subtrahend_56b[55:42];
	assign sqrt_addend     = sqrt_addend_56b[55:42];


	assign ds_result0 = calc_done           ? dsu_csa_sum[DS_DOUT_MSB:0]              :
			  !done_state           ? {DS_DOUT_WIDTH{1'b0}}                   :
			  (ds_op_type == 2'b11) ? {5'd0, current_qr0_55b[54:45], 1'b0}   ://BF:7+3
			  			  {2'd0, current_qr0_55b[54:42], 1'b0}   ;//HP:10+3

	assign ds_result1 = calc_done           ? {dsu_csa_cout[(DS_DOUT_MSB-1):0], 1'b0} :
			  !done_state           ? {DS_DOUT_WIDTH{1'b0}}                   :
			  (ds_op_type == 2'b11) ? {5'd0, current_qr1_55b[54:45], 1'b0}   ://BF:7+3
			  			  {2'd0, current_qr1_55b[54:42], 1'b0}   ;//HP:10+3
end
else if (FLEN == 32) begin : gen_fpu_dsu_sp
	assign	ds_count_5b = {1'b0, ds_count};

	assign	shifted_pr_sum_58b  = {shifted_pr_sum[28:1], 29'b0};
	assign	shifted_pr_cout_58b = {shifted_pr_cout[28:3], 29'b0};
	assign	divisor_54b	    = {divisor[24:1], 29'b0};

	assign	current_qr0_55b = {current_qr0, 29'b0};
	assign	current_qr1_55b = {current_qr1, 29'b0};

	assign sqrt_subtrahend = sqrt_subtrahend_56b[55:29];
	assign sqrt_addend     = sqrt_addend_56b[55:29];


	assign ds_result0 = calc_done           ? dsu_csa_sum[DS_DOUT_MSB:0]              :
			  !done_state           ? {DS_DOUT_WIDTH{1'b0}}                   :
			  (ds_op_type == 2'b11) ? {18'd0, current_qr0_55b[54:45], 1'b0}   ://BF:7+3
			  (ds_op_type == 2'b10) ? {15'd0, current_qr0_55b[54:42], 1'b0}   ://HP:10+3
			                          {02'd0, current_qr0_55b[54:29], 1'b0}   ;//SP:23+3

	assign ds_result1 = calc_done           ? {dsu_csa_cout[(DS_DOUT_MSB-1):0], 1'b0} :
			  !done_state           ? {DS_DOUT_WIDTH{1'b0}}                   :
			  (ds_op_type == 2'b11) ? {18'd0, current_qr1_55b[54:45], 1'b0}   ://BF:7+3
			  (ds_op_type == 2'b10) ? {15'd0, current_qr1_55b[54:42], 1'b0}   ://HP:10+3
			                          {02'd0, current_qr1_55b[54:29], 1'b0}   ;//SP:23+3
end
else begin : gen_fpu_dsu_dp

	assign	ds_count_5b = ds_count;
	assign	shifted_pr_sum_58b  = shifted_pr_sum[57:1];
	assign	shifted_pr_cout_58b = shifted_pr_cout[57:3];
	assign	divisor_54b	    = divisor[53:1];

	assign	current_qr0_55b = current_qr0;
	assign	current_qr1_55b = current_qr1;

	assign sqrt_subtrahend = sqrt_subtrahend_56b;
	assign sqrt_addend     = sqrt_addend_56b;


	assign ds_result0 = calc_done            ? dsu_csa_sum[DS_DOUT_MSB:0]              :
			  !done_state            ? {DS_DOUT_WIDTH{1'b0}}                   :
			   (ds_op_type == 2'b11) ? {47'd0, current_qr0_55b[54:45], 1'b0}   ://BF:7+3
			   (ds_op_type == 2'b10) ? {44'd0, current_qr0_55b[54:42], 1'b0}   ://HP:10+3
			   (ds_op_type == 2'b01) ? {31'd0, current_qr0_55b[54:29], 1'b0}   ://SP:23+3
					           { 2'd0, current_qr0_55b[54:0],  1'b0}   ;//DP:52+3

	assign ds_result1 = calc_done ?            {dsu_csa_cout[(DS_DOUT_MSB-1):0], 1'b0} :
			  !done_state ?            {DS_DOUT_WIDTH{1'b0}}                   :
			   (ds_op_type == 2'b11) ? {47'd0, current_qr1_55b[54:45], 1'b0}   ://BF:7+3
			   (ds_op_type == 2'b10) ? {44'd0, current_qr1_55b[54:42], 1'b0}   ://HP:10+3
			   (ds_op_type == 2'b01) ? {31'd0, current_qr1_55b[54:29], 1'b0}   ://SP:23+3
						   { 2'd0, current_qr1_55b[54:0],  1'b0}   ;//DP:52+3
end
endgenerate


endmodule
