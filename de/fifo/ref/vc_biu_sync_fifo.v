

module vc_biu_sync_fifo(
    core_reset_n,
    core_clk,
    rd_en,
    wr_en,
    wr,
    wr_data,
    rd,
    rd_data,
    valid_n,
    empty,
    full
);

parameter DATA_WIDTH = 32;
parameter FIFO_DEPTH = 2;

input					core_reset_n;
input					core_clk; 
input					rd_en;
input					wr_en;
input					wr; // write
input  [DATA_WIDTH-1:0]			wr_data; // write data
input					rd; // read 
output [DATA_WIDTH-1:0]			rd_data; // read data
output					valid_n;
output					full;
output                                  empty;

reg     [DATA_WIDTH-1:0]                rd_data;
wire    [DATA_WIDTH-1:0]                rd_data_nx;
reg                                     valid_n;
wire                                    full;


localparam FIFO_ENTRY_NUMBER = FIFO_DEPTH - 1;
localparam POINTER_INDEX_WIDTH = $clog2(FIFO_ENTRY_NUMBER) + 1; 

genvar j;

generate
if (FIFO_DEPTH == 1) begin : gen_fifo_depth_1

	wire					rdata_write;
	wire					rdata_read;
	reg					wr_ptr;
	wire					wr_ptr_nx;
	reg					rd_ptr;
	wire					rd_ptr_nx;
	
	wire					empty_nx;
	wire					full_nx;
	reg					full_reg;
	
	
	assign rdata_write = wr_en & wr;
	assign rdata_read  = rd & rd_en;
	assign rd_data_nx = wr_data;
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			rd_data <= {(DATA_WIDTH){1'b0}};
		else if (rdata_write)
			rd_data <= rd_data_nx;
	end
	
	assign wr_ptr_nx = rdata_write ? ~wr_ptr : wr_ptr;
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			wr_ptr <= 1'b0;
		else
			wr_ptr <= wr_ptr_nx;
	end
	
	assign rd_ptr_nx = rdata_read ? ~rd_ptr : rd_ptr;
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			rd_ptr <= 1'b0;
		else
			rd_ptr <= rd_ptr_nx;
	end
	
	assign empty_nx = rd_ptr_nx == wr_ptr_nx;
	
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			valid_n <= 1'b1;
		else if (rd_en)
			valid_n <= empty_nx;
	end
	
	assign full_nx = (rd_ptr_nx != wr_ptr_nx); 
	
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			full_reg <= 1'b0;	
		else if (wr_en)
			full_reg <= full_nx;
	end
	assign full = full_reg | ~rd_en; 
	assign empty = valid_n;
end // gen_fifo_depth_1
else if (FIFO_ENTRY_NUMBER == 1) begin : gen_internal_fifo_1_entry
	reg	[DATA_WIDTH-1:0]		mem[0:FIFO_ENTRY_NUMBER-1];  
	reg					full_reg;
	
	wire					empty_nx;
	wire					full_nx;
	reg					fifo_empty; // internal FIFO valid_n
	wire					fifo_empty_nx; 
	
	reg				        wr_ptr;
	wire    			        wr_ptr_nx;
	reg     			        rd_ptr;
	wire    			        rd_ptr_nx;
	
	wire					fifo_wr; // internal FIFO read
	wire					fifo_rd; // internal FIFO write
	wire					bypass_fifo_write; // write rdata directly
	wire                                    rd_data_wr;
	
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			for (i=0; i< FIFO_DEPTH-1; i = i + 1)
				mem[i] <= {(DATA_WIDTH){1'b0}};
		else if (fifo_wr)
				mem[0] <= wr_data;
	end
	
	assign bypass_fifo_write = rd_en & fifo_empty & wr & wr_en & (rd | valid_n);
	assign rd_data_wr = rd_en & (rd | valid_n) & ( wr & wr_en | !fifo_empty);
	assign rd_data_nx = {(DATA_WIDTH){bypass_fifo_write}} & wr_data | {(DATA_WIDTH){fifo_rd}} & mem[0];
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			rd_data <= {(DATA_WIDTH){1'b0}};
		else if (rd_data_wr)
				rd_data <= rd_data_nx; 
	end
	assign wr_ptr_nx = fifo_wr ? ~wr_ptr : wr_ptr;
	assign rd_ptr_nx = fifo_rd ? ~rd_ptr : rd_ptr;
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			wr_ptr <= 1'b0;
		else  
			wr_ptr <= wr_ptr_nx;
	end
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			rd_ptr <= 1'b0;
		else  
			rd_ptr <= rd_ptr_nx;
	end
	assign  fifo_wr = wr & wr_en & (!rd_en | (!fifo_empty | ~(rd | valid_n)));
	assign  full_nx  = wr_ptr_nx != rd_ptr_nx;
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			full_reg <= 1'b0;
		else if (wr_en) 
			full_reg <= full_nx;
	end
	
	assign full = full_reg;
	
	assign  fifo_rd = rd_en & (!fifo_empty) & (rd | valid_n);
	assign fifo_empty_nx = wr_ptr_nx == rd_ptr_nx;
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			fifo_empty <= 1'b1;
		else 
			fifo_empty <= fifo_empty_nx;
	end
	
	assign empty_nx = (!bypass_fifo_write) & fifo_empty & (rd | valid_n);
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			valid_n <= 1'b1; // valid_n after reset
		else if (rd_en)
			valid_n <= empty_nx;
	end

	assign empty = valid_n & fifo_empty;
end // gen_internal_fifo_1_entry
else begin : gen_fifo_depth_not_1 
	wire	[POINTER_INDEX_WIDTH-2:0]	max_entry_number;
	
	assign  max_entry_number[POINTER_INDEX_WIDTH-2] = ~(FIFO_ENTRY_NUMBER==1);
	
	for (j= 0 ; j <= POINTER_INDEX_WIDTH-3 ;j=j+1) begin : gen_max_entry_number
		assign max_entry_number[j] =  ((FIFO_ENTRY_NUMBER-1) >> j) % 2;
	end
	
	reg	[DATA_WIDTH-1:0]		mem[0:FIFO_ENTRY_NUMBER-1];  
	reg					full_reg;
	
	wire					empty_nx;
	wire					full_nx;
	reg					fifo_empty; // internal FIFO valid_n
	wire					fifo_empty_nx; 
	
	reg	[POINTER_INDEX_WIDTH-1:0]	wr_ptr;
	wire	[POINTER_INDEX_WIDTH-1:0]	wr_ptr_nx;
	reg	[POINTER_INDEX_WIDTH-1:0]	rd_ptr;
	wire	[POINTER_INDEX_WIDTH-1:0]	rd_ptr_nx;
	
	wire	[POINTER_INDEX_WIDTH-2:0]	index;
	wire	[POINTER_INDEX_WIDTH-2:0]	fifo_rd_addr; // internal FIFO read addr
	wire					fifo_wr; // internal FIFO read
	wire					fifo_rd; // internal FIFO write
	wire					bypass_fifo_write; // write rdata directly
	wire                                    rd_data_wr;
	
	assign index = wr_ptr[POINTER_INDEX_WIDTH-2:0];
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			for (i=0; i< FIFO_DEPTH-1; i = i + 1)
				mem[i] <= {(DATA_WIDTH){1'b0}};
		else if (fifo_wr)
				mem[index] <= wr_data;
	end
	
	assign fifo_rd_addr = rd_ptr[POINTER_INDEX_WIDTH-2:0];
	assign bypass_fifo_write = rd_en & fifo_empty & wr & wr_en & (rd | valid_n);
	assign rd_data_wr = rd_en & (rd | valid_n) & ( wr & wr_en | !fifo_empty);
	assign rd_data_nx = {(DATA_WIDTH){bypass_fifo_write}} & wr_data | {(DATA_WIDTH){fifo_rd}} & mem[fifo_rd_addr];
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			rd_data <= {(DATA_WIDTH){1'b0}};
		else if (rd_data_wr)
				rd_data <= rd_data_nx;
	end
	
	assign  fifo_wr = wr & wr_en & (!rd_en | (!fifo_empty | ~(rd | valid_n)));
	assign  wr_ptr_nx = fifo_wr ? (wr_ptr[POINTER_INDEX_WIDTH-2:0]!= max_entry_number) ? 
	                              (wr_ptr + {{(POINTER_INDEX_WIDTH-1){1'b0}},1'b1}) : 
				      {(~wr_ptr[POINTER_INDEX_WIDTH-1]),{(POINTER_INDEX_WIDTH-1){1'b0}}} :
				      wr_ptr;
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			wr_ptr <= {(POINTER_INDEX_WIDTH){1'b0}}; 
		else  
			wr_ptr <= wr_ptr_nx;
	end
	
	assign  full_nx  = (wr_ptr_nx[POINTER_INDEX_WIDTH-2:0] == rd_ptr_nx[POINTER_INDEX_WIDTH-2:0]) & 
	                   (wr_ptr_nx[POINTER_INDEX_WIDTH-1]   != rd_ptr_nx[POINTER_INDEX_WIDTH-1]);
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			full_reg <= 1'b0;
		else if (wr_en) 
			full_reg <= full_nx;
	end
	
	assign full = full_reg;
	
	assign  fifo_rd = rd_en & (!fifo_empty) & (rd | valid_n);
	assign  rd_ptr_nx = fifo_rd ? (rd_ptr[POINTER_INDEX_WIDTH-2:0]!= max_entry_number) ? 
	                              (rd_ptr + {{(POINTER_INDEX_WIDTH-1){1'b0}},1'b1}) :
	                              {(~rd_ptr[POINTER_INDEX_WIDTH-1]),{(POINTER_INDEX_WIDTH-1){1'b0}}} :
	                              rd_ptr;
	
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			rd_ptr <= {(POINTER_INDEX_WIDTH){1'b0}};
		else  
			rd_ptr <= rd_ptr_nx;
	end
	
	assign fifo_empty_nx = (rd_ptr_nx == wr_ptr_nx);
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			fifo_empty <= 1'b1;
		else 
			fifo_empty <= fifo_empty_nx;
	end
	
	assign empty_nx = (!bypass_fifo_write) & fifo_empty & (rd | valid_n);
	always @(negedge core_reset_n or posedge core_clk) begin
		if (!core_reset_n)
			valid_n <= 1'b1; // valid_n after reset
		else if (rd_en)
			valid_n <= empty_nx;
	end

	assign empty = valid_n & fifo_empty;
end // gen_fifo_depth_not_1
endgenerate
endmodule
