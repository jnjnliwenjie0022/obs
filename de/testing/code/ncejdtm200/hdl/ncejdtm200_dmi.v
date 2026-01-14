module ncejdtm200_dmi (
// VPERL: &PORTLIST;
// VPERL_GENERATED_BEGIN
	  dmi_hresetn,
	  dmi_tap_hrdata,
	  dmi_tap_ack,
	  tap_dmi_req,
	  tap_dmi_data,
	  dmi_hclk, 
	  dmi_hresp,
	  dmi_hready,
	  dmi_hrdata,
	  dmi_haddr,
	  dmi_htrans,
	  dmi_hwrite,
	  dmi_hsize,
	  dmi_hburst,
	  dmi_hprot,
	  dmi_hwdata,
	  dmi_hsel  
// VPERL_GENERATED_END
);

parameter   DMI_ADDR_BITS  = 7;
// DMI_ACCESS
localparam  DMI_DATA_BITS  = 32;
localparam  DMI_OP_BITS    = 2;

// Define of AHB-Lite bus transactions codes.
localparam   HTRANS_IDLE         = 2'b00;
localparam   HTRANS_BUSY         = 2'b01;
localparam   HTRANS_NONSEQ       = 2'b10;
localparam   HTRANS_SEQ          = 2'b11;

// Define of AHB-Lite bus response codes.
localparam   HRESP_OK            = 1'b0;
localparam   HRESP_ERROR         = 1'b1;

// Define of DMI operator
localparam   DMI_OP_NOP          = 2'b00;
localparam   DMI_OP_READ         = 2'b01;
localparam   DMI_OP_WRITE        = 2'b10;
localparam   DMI_OP_RSV          = 2'b11;

localparam DMI_REG_BITS = DMI_DATA_BITS + DMI_ADDR_BITS + DMI_OP_BITS;

// IO for Debug transport hardware
input		dmi_hresetn;

// IO for tap
output	[31:0]			dmi_tap_hrdata;
output				dmi_tap_ack;
input				tap_dmi_req;
input	[DMI_REG_BITS-1:0]	tap_dmi_data;

// IO for debug module
input		dmi_hclk;
input		dmi_hresp;
input		dmi_hready;
input	[31:0]	dmi_hrdata;
output	[31:0]	dmi_haddr;
output	[1:0]	dmi_htrans;
output		dmi_hwrite;
output	[2:0]	dmi_hsize;
output	[2:0]	dmi_hburst;
output	[3:0]	dmi_hprot;
output	[31:0]	dmi_hwdata;
output		dmi_hsel;

// AHB-Lite signals declaration
wire	transfer_req;

// DMI data register
reg	[DMI_REG_BITS-1:0]	dmi_data;

// dmi_htrans register
reg	[1:0]	dmi_htrans;
wire	[1:0]	htrans_nx;

// Read data phase control
reg	[31:0]	dmi_tap_hrdata;
reg		hrdata_phase;

// Data ack control
wire	dmi_tap_ack_set;
wire	dmi_tap_ack_clr;
reg	dmi_tap_ack;


// AHB-Lite interfaces control
// --------------------
wire	[DMI_ADDR_BITS-1:0]	addr;

assign	transfer_req = dmi_hready & tap_dmi_req & ~dmi_tap_ack & ~dmi_tap_ack_set & (dmi_htrans == HTRANS_IDLE);
assign	addr	     = dmi_data[DMI_REG_BITS-1:(DMI_DATA_BITS+DMI_OP_BITS)];

assign	dmi_haddr        = {{(30-DMI_ADDR_BITS){1'b0}}, addr, 2'b0};
assign	dmi_hwrite       = (dmi_data[DMI_OP_BITS-1:0] == DMI_OP_WRITE);
assign	dmi_hsize        = 3'b010;		// word size
assign	dmi_hburst       = 3'b000;		// only support SINGLE transfer
assign	dmi_hprot        = 4'b0001;		// data access
assign	dmi_hwdata       = dmi_data[(DMI_DATA_BITS+DMI_OP_BITS)-1:DMI_OP_BITS];
assign	dmi_hsel         = 1'b1;

assign	htrans_nx = transfer_req ? HTRANS_NONSEQ : HTRANS_IDLE;
always @(posedge dmi_hclk or negedge dmi_hresetn) begin
	if (!dmi_hresetn) begin
		dmi_htrans <= 2'b0;
	end
	else begin
		dmi_htrans <= htrans_nx;
	end
end

// ----------------
// DMI data reg
// ----------------
wire	dmi_data_wen;

assign	dmi_data_wen = transfer_req;
always @(posedge dmi_hclk or negedge dmi_hresetn) begin
	if (!dmi_hresetn) begin
		dmi_data <= {(DMI_REG_BITS){1'b0}};
	end
	else if (dmi_data_wen) begin
		dmi_data <= tap_dmi_data;
	end
end

// --------------------
// Read data phase control
// --------------------
wire	hrdata_phase_set;
wire	hrdata_phase_clr;
wire	dmi_tap_hrdata_wen;

assign	hrdata_phase_set = (dmi_htrans == HTRANS_NONSEQ);
assign	hrdata_phase_clr = (hrdata_phase & dmi_hready) | ~tap_dmi_req;
always @(posedge dmi_hclk or negedge dmi_hresetn) begin
	if (!dmi_hresetn) begin
		hrdata_phase <= 1'b0;
	end
	else if (hrdata_phase_clr) begin
		hrdata_phase <= 1'b0;
	end
	else if (hrdata_phase_set) begin
		hrdata_phase <= 1'b1;
	end
end

assign	dmi_tap_hrdata_wen = dmi_tap_ack_set & ~dmi_hwrite & (dmi_hresp == HRESP_OK);
always @(posedge dmi_hclk or negedge dmi_hresetn) begin
	if (!dmi_hresetn) begin
		dmi_tap_hrdata <= 32'd0;
	end
	else if (dmi_tap_hrdata_wen) begin
		dmi_tap_hrdata <= dmi_hrdata;
	end
end

// --------------------
// data ack control
// --------------------
assign	dmi_tap_ack_set = hrdata_phase & dmi_hready;
assign	dmi_tap_ack_clr = ~tap_dmi_req;
always @(posedge dmi_hclk or negedge dmi_hresetn) begin
	if (!dmi_hresetn) begin
		dmi_tap_ack <= 1'b0;
	end
	else if (dmi_tap_ack_clr) begin
		dmi_tap_ack <= 1'b0;
	end
	else if (dmi_tap_ack_set) begin
		dmi_tap_ack <= 1'b1;
	end

end

endmodule
