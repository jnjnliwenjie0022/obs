`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

//--------------------------
// Dummy ATCBMC300 Register File
//--------------------------
module ae350_ahb_config( 
                           	  hrdata,   
                           	  hready,   
                           	  hresp,    
                           	  hclk,     
                           	  hresetn,  
                           	  hready_in,
                           	  haddr,    
                           	  hsel,     
                           	  hsize,    
                           	  htrans,   
                           	  hwdata,   
                           	  hwrite    
);

parameter	DATA_WIDTH = 32;
localparam	DW_RATIO = DATA_WIDTH/32;

// AHB slave interface
input                     hclk;
input                     hresetn;
output [(DATA_WIDTH-1):0] hrdata;
output                    hready;
output              [1:0] hresp;
input                     hready_in;
input              [31:0] haddr;
input                     hsel;
input               [2:0] hsize;
input               [1:0] htrans;
input  [(DATA_WIDTH-1):0] hwdata;
input                     hwrite;

reg                       read_af_write;
reg                       priority_wen;
reg                [11:2] haddr_d1;
reg    [(DATA_WIDTH-1):0] hrdata;
wire   [(DATA_WIDTH-1):0] hrdata_match_data_width;
wire                [31:0] hrdata_32_array[0:127];

wire                  ren;
wire                  wen;

// VPERL_BEGIN
//  for($i=0;$i<32;$i++) {
// :`ifdef ATCBMC300_SLV${i}_SUPPORT
// :    localparam        SLV${i}_SIZE = `ATCBMC300_SLV${i}_SIZE;
// :	wire	[64:0]	slv${i}_addr_mask;
// :	wire	[64:0]	slv${i}_masked_base_addr;
// :	wire	[63:20]	slv${i}_base_addr;
// :    assign slv${i}_addr_mask = {{(65-(SLV${i}_SIZE+19)){1'b1}},{(SLV${i}_SIZE+19){1'b0}}} &  
// :                               {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
// :    assign slv${i}_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV${i}_BASE_ADDR} & slv${i}_addr_mask;
// :    assign slv${i}_base_addr[63:20] = slv${i}_masked_base_addr[63:20];
// :`endif
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC300_SLV0_SUPPORT
   localparam        SLV0_SIZE = `ATCBMC300_SLV0_SIZE;
	wire	[64:0]	slv0_addr_mask;
	wire	[64:0]	slv0_masked_base_addr;
	wire	[63:20]	slv0_base_addr;
   assign slv0_addr_mask = {{(65-(SLV0_SIZE+19)){1'b1}},{(SLV0_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv0_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV0_BASE_ADDR} & slv0_addr_mask;
   assign slv0_base_addr[63:20] = slv0_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
   localparam        SLV1_SIZE = `ATCBMC300_SLV1_SIZE;
	wire	[64:0]	slv1_addr_mask;
	wire	[64:0]	slv1_masked_base_addr;
	wire	[63:20]	slv1_base_addr;
   assign slv1_addr_mask = {{(65-(SLV1_SIZE+19)){1'b1}},{(SLV1_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv1_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV1_BASE_ADDR} & slv1_addr_mask;
   assign slv1_base_addr[63:20] = slv1_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
   localparam        SLV2_SIZE = `ATCBMC300_SLV2_SIZE;
	wire	[64:0]	slv2_addr_mask;
	wire	[64:0]	slv2_masked_base_addr;
	wire	[63:20]	slv2_base_addr;
   assign slv2_addr_mask = {{(65-(SLV2_SIZE+19)){1'b1}},{(SLV2_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv2_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV2_BASE_ADDR} & slv2_addr_mask;
   assign slv2_base_addr[63:20] = slv2_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
   localparam        SLV3_SIZE = `ATCBMC300_SLV3_SIZE;
	wire	[64:0]	slv3_addr_mask;
	wire	[64:0]	slv3_masked_base_addr;
	wire	[63:20]	slv3_base_addr;
   assign slv3_addr_mask = {{(65-(SLV3_SIZE+19)){1'b1}},{(SLV3_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv3_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV3_BASE_ADDR} & slv3_addr_mask;
   assign slv3_base_addr[63:20] = slv3_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
   localparam        SLV4_SIZE = `ATCBMC300_SLV4_SIZE;
	wire	[64:0]	slv4_addr_mask;
	wire	[64:0]	slv4_masked_base_addr;
	wire	[63:20]	slv4_base_addr;
   assign slv4_addr_mask = {{(65-(SLV4_SIZE+19)){1'b1}},{(SLV4_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv4_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV4_BASE_ADDR} & slv4_addr_mask;
   assign slv4_base_addr[63:20] = slv4_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
   localparam        SLV5_SIZE = `ATCBMC300_SLV5_SIZE;
	wire	[64:0]	slv5_addr_mask;
	wire	[64:0]	slv5_masked_base_addr;
	wire	[63:20]	slv5_base_addr;
   assign slv5_addr_mask = {{(65-(SLV5_SIZE+19)){1'b1}},{(SLV5_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv5_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV5_BASE_ADDR} & slv5_addr_mask;
   assign slv5_base_addr[63:20] = slv5_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
   localparam        SLV6_SIZE = `ATCBMC300_SLV6_SIZE;
	wire	[64:0]	slv6_addr_mask;
	wire	[64:0]	slv6_masked_base_addr;
	wire	[63:20]	slv6_base_addr;
   assign slv6_addr_mask = {{(65-(SLV6_SIZE+19)){1'b1}},{(SLV6_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv6_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV6_BASE_ADDR} & slv6_addr_mask;
   assign slv6_base_addr[63:20] = slv6_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
   localparam        SLV7_SIZE = `ATCBMC300_SLV7_SIZE;
	wire	[64:0]	slv7_addr_mask;
	wire	[64:0]	slv7_masked_base_addr;
	wire	[63:20]	slv7_base_addr;
   assign slv7_addr_mask = {{(65-(SLV7_SIZE+19)){1'b1}},{(SLV7_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv7_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV7_BASE_ADDR} & slv7_addr_mask;
   assign slv7_base_addr[63:20] = slv7_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
   localparam        SLV8_SIZE = `ATCBMC300_SLV8_SIZE;
	wire	[64:0]	slv8_addr_mask;
	wire	[64:0]	slv8_masked_base_addr;
	wire	[63:20]	slv8_base_addr;
   assign slv8_addr_mask = {{(65-(SLV8_SIZE+19)){1'b1}},{(SLV8_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv8_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV8_BASE_ADDR} & slv8_addr_mask;
   assign slv8_base_addr[63:20] = slv8_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
   localparam        SLV9_SIZE = `ATCBMC300_SLV9_SIZE;
	wire	[64:0]	slv9_addr_mask;
	wire	[64:0]	slv9_masked_base_addr;
	wire	[63:20]	slv9_base_addr;
   assign slv9_addr_mask = {{(65-(SLV9_SIZE+19)){1'b1}},{(SLV9_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv9_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV9_BASE_ADDR} & slv9_addr_mask;
   assign slv9_base_addr[63:20] = slv9_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
   localparam        SLV10_SIZE = `ATCBMC300_SLV10_SIZE;
	wire	[64:0]	slv10_addr_mask;
	wire	[64:0]	slv10_masked_base_addr;
	wire	[63:20]	slv10_base_addr;
   assign slv10_addr_mask = {{(65-(SLV10_SIZE+19)){1'b1}},{(SLV10_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv10_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV10_BASE_ADDR} & slv10_addr_mask;
   assign slv10_base_addr[63:20] = slv10_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
   localparam        SLV11_SIZE = `ATCBMC300_SLV11_SIZE;
	wire	[64:0]	slv11_addr_mask;
	wire	[64:0]	slv11_masked_base_addr;
	wire	[63:20]	slv11_base_addr;
   assign slv11_addr_mask = {{(65-(SLV11_SIZE+19)){1'b1}},{(SLV11_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv11_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV11_BASE_ADDR} & slv11_addr_mask;
   assign slv11_base_addr[63:20] = slv11_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
   localparam        SLV12_SIZE = `ATCBMC300_SLV12_SIZE;
	wire	[64:0]	slv12_addr_mask;
	wire	[64:0]	slv12_masked_base_addr;
	wire	[63:20]	slv12_base_addr;
   assign slv12_addr_mask = {{(65-(SLV12_SIZE+19)){1'b1}},{(SLV12_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv12_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV12_BASE_ADDR} & slv12_addr_mask;
   assign slv12_base_addr[63:20] = slv12_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
   localparam        SLV13_SIZE = `ATCBMC300_SLV13_SIZE;
	wire	[64:0]	slv13_addr_mask;
	wire	[64:0]	slv13_masked_base_addr;
	wire	[63:20]	slv13_base_addr;
   assign slv13_addr_mask = {{(65-(SLV13_SIZE+19)){1'b1}},{(SLV13_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv13_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV13_BASE_ADDR} & slv13_addr_mask;
   assign slv13_base_addr[63:20] = slv13_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
   localparam        SLV14_SIZE = `ATCBMC300_SLV14_SIZE;
	wire	[64:0]	slv14_addr_mask;
	wire	[64:0]	slv14_masked_base_addr;
	wire	[63:20]	slv14_base_addr;
   assign slv14_addr_mask = {{(65-(SLV14_SIZE+19)){1'b1}},{(SLV14_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv14_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV14_BASE_ADDR} & slv14_addr_mask;
   assign slv14_base_addr[63:20] = slv14_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
   localparam        SLV15_SIZE = `ATCBMC300_SLV15_SIZE;
	wire	[64:0]	slv15_addr_mask;
	wire	[64:0]	slv15_masked_base_addr;
	wire	[63:20]	slv15_base_addr;
   assign slv15_addr_mask = {{(65-(SLV15_SIZE+19)){1'b1}},{(SLV15_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv15_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV15_BASE_ADDR} & slv15_addr_mask;
   assign slv15_base_addr[63:20] = slv15_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
   localparam        SLV16_SIZE = `ATCBMC300_SLV16_SIZE;
	wire	[64:0]	slv16_addr_mask;
	wire	[64:0]	slv16_masked_base_addr;
	wire	[63:20]	slv16_base_addr;
   assign slv16_addr_mask = {{(65-(SLV16_SIZE+19)){1'b1}},{(SLV16_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv16_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV16_BASE_ADDR} & slv16_addr_mask;
   assign slv16_base_addr[63:20] = slv16_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
   localparam        SLV17_SIZE = `ATCBMC300_SLV17_SIZE;
	wire	[64:0]	slv17_addr_mask;
	wire	[64:0]	slv17_masked_base_addr;
	wire	[63:20]	slv17_base_addr;
   assign slv17_addr_mask = {{(65-(SLV17_SIZE+19)){1'b1}},{(SLV17_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv17_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV17_BASE_ADDR} & slv17_addr_mask;
   assign slv17_base_addr[63:20] = slv17_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
   localparam        SLV18_SIZE = `ATCBMC300_SLV18_SIZE;
	wire	[64:0]	slv18_addr_mask;
	wire	[64:0]	slv18_masked_base_addr;
	wire	[63:20]	slv18_base_addr;
   assign slv18_addr_mask = {{(65-(SLV18_SIZE+19)){1'b1}},{(SLV18_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv18_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV18_BASE_ADDR} & slv18_addr_mask;
   assign slv18_base_addr[63:20] = slv18_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
   localparam        SLV19_SIZE = `ATCBMC300_SLV19_SIZE;
	wire	[64:0]	slv19_addr_mask;
	wire	[64:0]	slv19_masked_base_addr;
	wire	[63:20]	slv19_base_addr;
   assign slv19_addr_mask = {{(65-(SLV19_SIZE+19)){1'b1}},{(SLV19_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv19_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV19_BASE_ADDR} & slv19_addr_mask;
   assign slv19_base_addr[63:20] = slv19_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
   localparam        SLV20_SIZE = `ATCBMC300_SLV20_SIZE;
	wire	[64:0]	slv20_addr_mask;
	wire	[64:0]	slv20_masked_base_addr;
	wire	[63:20]	slv20_base_addr;
   assign slv20_addr_mask = {{(65-(SLV20_SIZE+19)){1'b1}},{(SLV20_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv20_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV20_BASE_ADDR} & slv20_addr_mask;
   assign slv20_base_addr[63:20] = slv20_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
   localparam        SLV21_SIZE = `ATCBMC300_SLV21_SIZE;
	wire	[64:0]	slv21_addr_mask;
	wire	[64:0]	slv21_masked_base_addr;
	wire	[63:20]	slv21_base_addr;
   assign slv21_addr_mask = {{(65-(SLV21_SIZE+19)){1'b1}},{(SLV21_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv21_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV21_BASE_ADDR} & slv21_addr_mask;
   assign slv21_base_addr[63:20] = slv21_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
   localparam        SLV22_SIZE = `ATCBMC300_SLV22_SIZE;
	wire	[64:0]	slv22_addr_mask;
	wire	[64:0]	slv22_masked_base_addr;
	wire	[63:20]	slv22_base_addr;
   assign slv22_addr_mask = {{(65-(SLV22_SIZE+19)){1'b1}},{(SLV22_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv22_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV22_BASE_ADDR} & slv22_addr_mask;
   assign slv22_base_addr[63:20] = slv22_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
   localparam        SLV23_SIZE = `ATCBMC300_SLV23_SIZE;
	wire	[64:0]	slv23_addr_mask;
	wire	[64:0]	slv23_masked_base_addr;
	wire	[63:20]	slv23_base_addr;
   assign slv23_addr_mask = {{(65-(SLV23_SIZE+19)){1'b1}},{(SLV23_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv23_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV23_BASE_ADDR} & slv23_addr_mask;
   assign slv23_base_addr[63:20] = slv23_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
   localparam        SLV24_SIZE = `ATCBMC300_SLV24_SIZE;
	wire	[64:0]	slv24_addr_mask;
	wire	[64:0]	slv24_masked_base_addr;
	wire	[63:20]	slv24_base_addr;
   assign slv24_addr_mask = {{(65-(SLV24_SIZE+19)){1'b1}},{(SLV24_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv24_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV24_BASE_ADDR} & slv24_addr_mask;
   assign slv24_base_addr[63:20] = slv24_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
   localparam        SLV25_SIZE = `ATCBMC300_SLV25_SIZE;
	wire	[64:0]	slv25_addr_mask;
	wire	[64:0]	slv25_masked_base_addr;
	wire	[63:20]	slv25_base_addr;
   assign slv25_addr_mask = {{(65-(SLV25_SIZE+19)){1'b1}},{(SLV25_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv25_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV25_BASE_ADDR} & slv25_addr_mask;
   assign slv25_base_addr[63:20] = slv25_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
   localparam        SLV26_SIZE = `ATCBMC300_SLV26_SIZE;
	wire	[64:0]	slv26_addr_mask;
	wire	[64:0]	slv26_masked_base_addr;
	wire	[63:20]	slv26_base_addr;
   assign slv26_addr_mask = {{(65-(SLV26_SIZE+19)){1'b1}},{(SLV26_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv26_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV26_BASE_ADDR} & slv26_addr_mask;
   assign slv26_base_addr[63:20] = slv26_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
   localparam        SLV27_SIZE = `ATCBMC300_SLV27_SIZE;
	wire	[64:0]	slv27_addr_mask;
	wire	[64:0]	slv27_masked_base_addr;
	wire	[63:20]	slv27_base_addr;
   assign slv27_addr_mask = {{(65-(SLV27_SIZE+19)){1'b1}},{(SLV27_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv27_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV27_BASE_ADDR} & slv27_addr_mask;
   assign slv27_base_addr[63:20] = slv27_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
   localparam        SLV28_SIZE = `ATCBMC300_SLV28_SIZE;
	wire	[64:0]	slv28_addr_mask;
	wire	[64:0]	slv28_masked_base_addr;
	wire	[63:20]	slv28_base_addr;
   assign slv28_addr_mask = {{(65-(SLV28_SIZE+19)){1'b1}},{(SLV28_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv28_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV28_BASE_ADDR} & slv28_addr_mask;
   assign slv28_base_addr[63:20] = slv28_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
   localparam        SLV29_SIZE = `ATCBMC300_SLV29_SIZE;
	wire	[64:0]	slv29_addr_mask;
	wire	[64:0]	slv29_masked_base_addr;
	wire	[63:20]	slv29_base_addr;
   assign slv29_addr_mask = {{(65-(SLV29_SIZE+19)){1'b1}},{(SLV29_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv29_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV29_BASE_ADDR} & slv29_addr_mask;
   assign slv29_base_addr[63:20] = slv29_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
   localparam        SLV30_SIZE = `ATCBMC300_SLV30_SIZE;
	wire	[64:0]	slv30_addr_mask;
	wire	[64:0]	slv30_masked_base_addr;
	wire	[63:20]	slv30_base_addr;
   assign slv30_addr_mask = {{(65-(SLV30_SIZE+19)){1'b1}},{(SLV30_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv30_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV30_BASE_ADDR} & slv30_addr_mask;
   assign slv30_base_addr[63:20] = slv30_masked_base_addr[63:20];
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
   localparam        SLV31_SIZE = `ATCBMC300_SLV31_SIZE;
	wire	[64:0]	slv31_addr_mask;
	wire	[64:0]	slv31_masked_base_addr;
	wire	[63:20]	slv31_base_addr;
   assign slv31_addr_mask = {{(65-(SLV31_SIZE+19)){1'b1}},{(SLV31_SIZE+19){1'b0}}} &
                              {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},{`ATCBMC300_ADDR_WIDTH{1'b1}}};
   assign slv31_masked_base_addr = {{(65-`ATCBMC300_ADDR_WIDTH){1'b0}},`ATCBMC300_SLV31_BASE_ADDR} & slv31_addr_mask;
   assign slv31_base_addr[63:20] = slv31_masked_base_addr[63:20];
`endif
// VPERL_GENERATED_END

// hready is low at read writable register after write the register continuously
assign hready = (~read_af_write);

always @ (posedge hclk or negedge hresetn) begin
    if(!hresetn) begin
	read_af_write <= 1'b0;
	haddr_d1      <= 10'h0;
    end
    else begin
	read_af_write <= (ren & (
    			(priority_wen & (haddr[11:2]==10'h004)) )) ;
	haddr_d1      <= haddr[11:2];
    end
end

assign hresp  = 2'b00;// `HRESP_OK; 


assign wen = hsel & hready_in & hwrite & htrans[1];
// write enable
always @ (posedge hclk or negedge hresetn) begin
    if(!hresetn) begin
        priority_wen <= 1'b0;
    end
    else begin
        priority_wen <= wen & (haddr[11:2]==10'h4);
    end
end

// read enable
assign ren = hsel & hready_in & ~hwrite & htrans[1];

// VPERL_BEGIN
// :assign	hrdata_32_array[0] = `ATCBMC300_PRODUCT_ID;
// for ($i = 64; $i < 128; $i=$i+2) {
// :`ifdef ATCBMC300_SLV%d_SUPPORT	:: $i - 64
// :assign	hrdata_32_array[%d] = {slv%d_base_addr[31:20], 12'h0, SLV%d_SIZE[7:0]};	:: $i, ($i/2) - 32, ($i/2) - 32
// :assign	hrdata_32_array[%d] =  slv%d_base_addr[63:32];	:: $i + 1, ($i/2) - 32, ($i/2) - 32
// :`else
// :assign	hrdata_32_array[%d] = 32'h0;	:: $i
// :assign	hrdata_32_array[%d] = 32'h0;	:: $i + 1
// :`endif // ATCBMC300_SLV%d_SUPPORT	:: $i - 64
// }
// for $i (1 .. 63) {
// :assign	hrdata_32_array[%d] = 32'h0; // unused	:: $i
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
assign	hrdata_32_array[0] = `ATCBMC300_PRODUCT_ID;
`ifdef ATCBMC300_SLV0_SUPPORT
assign	hrdata_32_array[64] = {slv0_base_addr[31:20], 12'h0, SLV0_SIZE[7:0]};
assign	hrdata_32_array[65] =  slv0_base_addr[63:32];
`else
assign	hrdata_32_array[64] = 32'h0;
assign	hrdata_32_array[65] = 32'h0;
`endif // ATCBMC300_SLV0_SUPPORT
`ifdef ATCBMC300_SLV2_SUPPORT
assign	hrdata_32_array[66] = {slv1_base_addr[31:20], 12'h0, SLV1_SIZE[7:0]};
assign	hrdata_32_array[67] =  slv1_base_addr[63:32];
`else
assign	hrdata_32_array[66] = 32'h0;
assign	hrdata_32_array[67] = 32'h0;
`endif // ATCBMC300_SLV2_SUPPORT
`ifdef ATCBMC300_SLV4_SUPPORT
assign	hrdata_32_array[68] = {slv2_base_addr[31:20], 12'h0, SLV2_SIZE[7:0]};
assign	hrdata_32_array[69] =  slv2_base_addr[63:32];
`else
assign	hrdata_32_array[68] = 32'h0;
assign	hrdata_32_array[69] = 32'h0;
`endif // ATCBMC300_SLV4_SUPPORT
`ifdef ATCBMC300_SLV6_SUPPORT
assign	hrdata_32_array[70] = {slv3_base_addr[31:20], 12'h0, SLV3_SIZE[7:0]};
assign	hrdata_32_array[71] =  slv3_base_addr[63:32];
`else
assign	hrdata_32_array[70] = 32'h0;
assign	hrdata_32_array[71] = 32'h0;
`endif // ATCBMC300_SLV6_SUPPORT
`ifdef ATCBMC300_SLV8_SUPPORT
assign	hrdata_32_array[72] = {slv4_base_addr[31:20], 12'h0, SLV4_SIZE[7:0]};
assign	hrdata_32_array[73] =  slv4_base_addr[63:32];
`else
assign	hrdata_32_array[72] = 32'h0;
assign	hrdata_32_array[73] = 32'h0;
`endif // ATCBMC300_SLV8_SUPPORT
`ifdef ATCBMC300_SLV10_SUPPORT
assign	hrdata_32_array[74] = {slv5_base_addr[31:20], 12'h0, SLV5_SIZE[7:0]};
assign	hrdata_32_array[75] =  slv5_base_addr[63:32];
`else
assign	hrdata_32_array[74] = 32'h0;
assign	hrdata_32_array[75] = 32'h0;
`endif // ATCBMC300_SLV10_SUPPORT
`ifdef ATCBMC300_SLV12_SUPPORT
assign	hrdata_32_array[76] = {slv6_base_addr[31:20], 12'h0, SLV6_SIZE[7:0]};
assign	hrdata_32_array[77] =  slv6_base_addr[63:32];
`else
assign	hrdata_32_array[76] = 32'h0;
assign	hrdata_32_array[77] = 32'h0;
`endif // ATCBMC300_SLV12_SUPPORT
`ifdef ATCBMC300_SLV14_SUPPORT
assign	hrdata_32_array[78] = {slv7_base_addr[31:20], 12'h0, SLV7_SIZE[7:0]};
assign	hrdata_32_array[79] =  slv7_base_addr[63:32];
`else
assign	hrdata_32_array[78] = 32'h0;
assign	hrdata_32_array[79] = 32'h0;
`endif // ATCBMC300_SLV14_SUPPORT
`ifdef ATCBMC300_SLV16_SUPPORT
assign	hrdata_32_array[80] = {slv8_base_addr[31:20], 12'h0, SLV8_SIZE[7:0]};
assign	hrdata_32_array[81] =  slv8_base_addr[63:32];
`else
assign	hrdata_32_array[80] = 32'h0;
assign	hrdata_32_array[81] = 32'h0;
`endif // ATCBMC300_SLV16_SUPPORT
`ifdef ATCBMC300_SLV18_SUPPORT
assign	hrdata_32_array[82] = {slv9_base_addr[31:20], 12'h0, SLV9_SIZE[7:0]};
assign	hrdata_32_array[83] =  slv9_base_addr[63:32];
`else
assign	hrdata_32_array[82] = 32'h0;
assign	hrdata_32_array[83] = 32'h0;
`endif // ATCBMC300_SLV18_SUPPORT
`ifdef ATCBMC300_SLV20_SUPPORT
assign	hrdata_32_array[84] = {slv10_base_addr[31:20], 12'h0, SLV10_SIZE[7:0]};
assign	hrdata_32_array[85] =  slv10_base_addr[63:32];
`else
assign	hrdata_32_array[84] = 32'h0;
assign	hrdata_32_array[85] = 32'h0;
`endif // ATCBMC300_SLV20_SUPPORT
`ifdef ATCBMC300_SLV22_SUPPORT
assign	hrdata_32_array[86] = {slv11_base_addr[31:20], 12'h0, SLV11_SIZE[7:0]};
assign	hrdata_32_array[87] =  slv11_base_addr[63:32];
`else
assign	hrdata_32_array[86] = 32'h0;
assign	hrdata_32_array[87] = 32'h0;
`endif // ATCBMC300_SLV22_SUPPORT
`ifdef ATCBMC300_SLV24_SUPPORT
assign	hrdata_32_array[88] = {slv12_base_addr[31:20], 12'h0, SLV12_SIZE[7:0]};
assign	hrdata_32_array[89] =  slv12_base_addr[63:32];
`else
assign	hrdata_32_array[88] = 32'h0;
assign	hrdata_32_array[89] = 32'h0;
`endif // ATCBMC300_SLV24_SUPPORT
`ifdef ATCBMC300_SLV26_SUPPORT
assign	hrdata_32_array[90] = {slv13_base_addr[31:20], 12'h0, SLV13_SIZE[7:0]};
assign	hrdata_32_array[91] =  slv13_base_addr[63:32];
`else
assign	hrdata_32_array[90] = 32'h0;
assign	hrdata_32_array[91] = 32'h0;
`endif // ATCBMC300_SLV26_SUPPORT
`ifdef ATCBMC300_SLV28_SUPPORT
assign	hrdata_32_array[92] = {slv14_base_addr[31:20], 12'h0, SLV14_SIZE[7:0]};
assign	hrdata_32_array[93] =  slv14_base_addr[63:32];
`else
assign	hrdata_32_array[92] = 32'h0;
assign	hrdata_32_array[93] = 32'h0;
`endif // ATCBMC300_SLV28_SUPPORT
`ifdef ATCBMC300_SLV30_SUPPORT
assign	hrdata_32_array[94] = {slv15_base_addr[31:20], 12'h0, SLV15_SIZE[7:0]};
assign	hrdata_32_array[95] =  slv15_base_addr[63:32];
`else
assign	hrdata_32_array[94] = 32'h0;
assign	hrdata_32_array[95] = 32'h0;
`endif // ATCBMC300_SLV30_SUPPORT
`ifdef ATCBMC300_SLV32_SUPPORT
assign	hrdata_32_array[96] = {slv16_base_addr[31:20], 12'h0, SLV16_SIZE[7:0]};
assign	hrdata_32_array[97] =  slv16_base_addr[63:32];
`else
assign	hrdata_32_array[96] = 32'h0;
assign	hrdata_32_array[97] = 32'h0;
`endif // ATCBMC300_SLV32_SUPPORT
`ifdef ATCBMC300_SLV34_SUPPORT
assign	hrdata_32_array[98] = {slv17_base_addr[31:20], 12'h0, SLV17_SIZE[7:0]};
assign	hrdata_32_array[99] =  slv17_base_addr[63:32];
`else
assign	hrdata_32_array[98] = 32'h0;
assign	hrdata_32_array[99] = 32'h0;
`endif // ATCBMC300_SLV34_SUPPORT
`ifdef ATCBMC300_SLV36_SUPPORT
assign	hrdata_32_array[100] = {slv18_base_addr[31:20], 12'h0, SLV18_SIZE[7:0]};
assign	hrdata_32_array[101] =  slv18_base_addr[63:32];
`else
assign	hrdata_32_array[100] = 32'h0;
assign	hrdata_32_array[101] = 32'h0;
`endif // ATCBMC300_SLV36_SUPPORT
`ifdef ATCBMC300_SLV38_SUPPORT
assign	hrdata_32_array[102] = {slv19_base_addr[31:20], 12'h0, SLV19_SIZE[7:0]};
assign	hrdata_32_array[103] =  slv19_base_addr[63:32];
`else
assign	hrdata_32_array[102] = 32'h0;
assign	hrdata_32_array[103] = 32'h0;
`endif // ATCBMC300_SLV38_SUPPORT
`ifdef ATCBMC300_SLV40_SUPPORT
assign	hrdata_32_array[104] = {slv20_base_addr[31:20], 12'h0, SLV20_SIZE[7:0]};
assign	hrdata_32_array[105] =  slv20_base_addr[63:32];
`else
assign	hrdata_32_array[104] = 32'h0;
assign	hrdata_32_array[105] = 32'h0;
`endif // ATCBMC300_SLV40_SUPPORT
`ifdef ATCBMC300_SLV42_SUPPORT
assign	hrdata_32_array[106] = {slv21_base_addr[31:20], 12'h0, SLV21_SIZE[7:0]};
assign	hrdata_32_array[107] =  slv21_base_addr[63:32];
`else
assign	hrdata_32_array[106] = 32'h0;
assign	hrdata_32_array[107] = 32'h0;
`endif // ATCBMC300_SLV42_SUPPORT
`ifdef ATCBMC300_SLV44_SUPPORT
assign	hrdata_32_array[108] = {slv22_base_addr[31:20], 12'h0, SLV22_SIZE[7:0]};
assign	hrdata_32_array[109] =  slv22_base_addr[63:32];
`else
assign	hrdata_32_array[108] = 32'h0;
assign	hrdata_32_array[109] = 32'h0;
`endif // ATCBMC300_SLV44_SUPPORT
`ifdef ATCBMC300_SLV46_SUPPORT
assign	hrdata_32_array[110] = {slv23_base_addr[31:20], 12'h0, SLV23_SIZE[7:0]};
assign	hrdata_32_array[111] =  slv23_base_addr[63:32];
`else
assign	hrdata_32_array[110] = 32'h0;
assign	hrdata_32_array[111] = 32'h0;
`endif // ATCBMC300_SLV46_SUPPORT
`ifdef ATCBMC300_SLV48_SUPPORT
assign	hrdata_32_array[112] = {slv24_base_addr[31:20], 12'h0, SLV24_SIZE[7:0]};
assign	hrdata_32_array[113] =  slv24_base_addr[63:32];
`else
assign	hrdata_32_array[112] = 32'h0;
assign	hrdata_32_array[113] = 32'h0;
`endif // ATCBMC300_SLV48_SUPPORT
`ifdef ATCBMC300_SLV50_SUPPORT
assign	hrdata_32_array[114] = {slv25_base_addr[31:20], 12'h0, SLV25_SIZE[7:0]};
assign	hrdata_32_array[115] =  slv25_base_addr[63:32];
`else
assign	hrdata_32_array[114] = 32'h0;
assign	hrdata_32_array[115] = 32'h0;
`endif // ATCBMC300_SLV50_SUPPORT
`ifdef ATCBMC300_SLV52_SUPPORT
assign	hrdata_32_array[116] = {slv26_base_addr[31:20], 12'h0, SLV26_SIZE[7:0]};
assign	hrdata_32_array[117] =  slv26_base_addr[63:32];
`else
assign	hrdata_32_array[116] = 32'h0;
assign	hrdata_32_array[117] = 32'h0;
`endif // ATCBMC300_SLV52_SUPPORT
`ifdef ATCBMC300_SLV54_SUPPORT
assign	hrdata_32_array[118] = {slv27_base_addr[31:20], 12'h0, SLV27_SIZE[7:0]};
assign	hrdata_32_array[119] =  slv27_base_addr[63:32];
`else
assign	hrdata_32_array[118] = 32'h0;
assign	hrdata_32_array[119] = 32'h0;
`endif // ATCBMC300_SLV54_SUPPORT
`ifdef ATCBMC300_SLV56_SUPPORT
assign	hrdata_32_array[120] = {slv28_base_addr[31:20], 12'h0, SLV28_SIZE[7:0]};
assign	hrdata_32_array[121] =  slv28_base_addr[63:32];
`else
assign	hrdata_32_array[120] = 32'h0;
assign	hrdata_32_array[121] = 32'h0;
`endif // ATCBMC300_SLV56_SUPPORT
`ifdef ATCBMC300_SLV58_SUPPORT
assign	hrdata_32_array[122] = {slv29_base_addr[31:20], 12'h0, SLV29_SIZE[7:0]};
assign	hrdata_32_array[123] =  slv29_base_addr[63:32];
`else
assign	hrdata_32_array[122] = 32'h0;
assign	hrdata_32_array[123] = 32'h0;
`endif // ATCBMC300_SLV58_SUPPORT
`ifdef ATCBMC300_SLV60_SUPPORT
assign	hrdata_32_array[124] = {slv30_base_addr[31:20], 12'h0, SLV30_SIZE[7:0]};
assign	hrdata_32_array[125] =  slv30_base_addr[63:32];
`else
assign	hrdata_32_array[124] = 32'h0;
assign	hrdata_32_array[125] = 32'h0;
`endif // ATCBMC300_SLV60_SUPPORT
`ifdef ATCBMC300_SLV62_SUPPORT
assign	hrdata_32_array[126] = {slv31_base_addr[31:20], 12'h0, SLV31_SIZE[7:0]};
assign	hrdata_32_array[127] =  slv31_base_addr[63:32];
`else
assign	hrdata_32_array[126] = 32'h0;
assign	hrdata_32_array[127] = 32'h0;
`endif // ATCBMC300_SLV62_SUPPORT
assign	hrdata_32_array[1] = 32'h0; // unused
assign	hrdata_32_array[2] = 32'h0; // unused
assign	hrdata_32_array[3] = 32'h0; // unused
assign	hrdata_32_array[4] = 32'h0; // unused
assign	hrdata_32_array[5] = 32'h0; // unused
assign	hrdata_32_array[6] = 32'h0; // unused
assign	hrdata_32_array[7] = 32'h0; // unused
assign	hrdata_32_array[8] = 32'h0; // unused
assign	hrdata_32_array[9] = 32'h0; // unused
assign	hrdata_32_array[10] = 32'h0; // unused
assign	hrdata_32_array[11] = 32'h0; // unused
assign	hrdata_32_array[12] = 32'h0; // unused
assign	hrdata_32_array[13] = 32'h0; // unused
assign	hrdata_32_array[14] = 32'h0; // unused
assign	hrdata_32_array[15] = 32'h0; // unused
assign	hrdata_32_array[16] = 32'h0; // unused
assign	hrdata_32_array[17] = 32'h0; // unused
assign	hrdata_32_array[18] = 32'h0; // unused
assign	hrdata_32_array[19] = 32'h0; // unused
assign	hrdata_32_array[20] = 32'h0; // unused
assign	hrdata_32_array[21] = 32'h0; // unused
assign	hrdata_32_array[22] = 32'h0; // unused
assign	hrdata_32_array[23] = 32'h0; // unused
assign	hrdata_32_array[24] = 32'h0; // unused
assign	hrdata_32_array[25] = 32'h0; // unused
assign	hrdata_32_array[26] = 32'h0; // unused
assign	hrdata_32_array[27] = 32'h0; // unused
assign	hrdata_32_array[28] = 32'h0; // unused
assign	hrdata_32_array[29] = 32'h0; // unused
assign	hrdata_32_array[30] = 32'h0; // unused
assign	hrdata_32_array[31] = 32'h0; // unused
assign	hrdata_32_array[32] = 32'h0; // unused
assign	hrdata_32_array[33] = 32'h0; // unused
assign	hrdata_32_array[34] = 32'h0; // unused
assign	hrdata_32_array[35] = 32'h0; // unused
assign	hrdata_32_array[36] = 32'h0; // unused
assign	hrdata_32_array[37] = 32'h0; // unused
assign	hrdata_32_array[38] = 32'h0; // unused
assign	hrdata_32_array[39] = 32'h0; // unused
assign	hrdata_32_array[40] = 32'h0; // unused
assign	hrdata_32_array[41] = 32'h0; // unused
assign	hrdata_32_array[42] = 32'h0; // unused
assign	hrdata_32_array[43] = 32'h0; // unused
assign	hrdata_32_array[44] = 32'h0; // unused
assign	hrdata_32_array[45] = 32'h0; // unused
assign	hrdata_32_array[46] = 32'h0; // unused
assign	hrdata_32_array[47] = 32'h0; // unused
assign	hrdata_32_array[48] = 32'h0; // unused
assign	hrdata_32_array[49] = 32'h0; // unused
assign	hrdata_32_array[50] = 32'h0; // unused
assign	hrdata_32_array[51] = 32'h0; // unused
assign	hrdata_32_array[52] = 32'h0; // unused
assign	hrdata_32_array[53] = 32'h0; // unused
assign	hrdata_32_array[54] = 32'h0; // unused
assign	hrdata_32_array[55] = 32'h0; // unused
assign	hrdata_32_array[56] = 32'h0; // unused
assign	hrdata_32_array[57] = 32'h0; // unused
assign	hrdata_32_array[58] = 32'h0; // unused
assign	hrdata_32_array[59] = 32'h0; // unused
assign	hrdata_32_array[60] = 32'h0; // unused
assign	hrdata_32_array[61] = 32'h0; // unused
assign	hrdata_32_array[62] = 32'h0; // unused
assign	hrdata_32_array[63] = 32'h0; // unused
// VPERL_GENERATED_END

wire	[11:2] hrdata_32_array_addr = read_af_write ? haddr_d1[11:2] : haddr[11:2];

// VPERL_BEGIN
// $max_dw = 1024; 
// $max_dw_log2 = log($max_dw/32)/log(2);
//: generate
// for ($i = 0; $i <= $max_dw_log2; $i++) {
// 	my $k = 2 ** ($i + 5) ;
//: if (DATA_WIDTH == %d ) begin: gen_data_width_%d	:: $k, $k
//:     assign	hrdata_match_data_width	=	\{
//	for ($j = (2**$i)-1; $j >=0; $j--) {
//		if ($i == 0) {
//:					hrdata_32_array[hrdata_32_array_addr[8:%d]]%s :: 2, ($j == 0 ) ? "" : ","
//		} else {
//:					hrdata_32_array[{hrdata_32_array_addr%s,${i}'d${j}}]%s :: ($i+2 == 8) ? ("[" . ($i + 2) . "]") : ("[8:" . ($i + 2) . "]"), ($j == 0) ? "" : ","
//		}
//	}
//:					\};
//: end // gen_data_width_%d	:: $k
// }
//: endgenerate
// VPERL_END

// VPERL_GENERATED_BEGIN
generate
if (DATA_WIDTH == 32 ) begin: gen_data_width_32
    assign	hrdata_match_data_width	=	{
					hrdata_32_array[hrdata_32_array_addr[8:2]]
					};
end // gen_data_width_32
if (DATA_WIDTH == 64 ) begin: gen_data_width_64
    assign	hrdata_match_data_width	=	{
					hrdata_32_array[{hrdata_32_array_addr[8:3],1'd1}],
					hrdata_32_array[{hrdata_32_array_addr[8:3],1'd0}]
					};
end // gen_data_width_64
if (DATA_WIDTH == 128 ) begin: gen_data_width_128
    assign	hrdata_match_data_width	=	{
					hrdata_32_array[{hrdata_32_array_addr[8:4],2'd3}],
					hrdata_32_array[{hrdata_32_array_addr[8:4],2'd2}],
					hrdata_32_array[{hrdata_32_array_addr[8:4],2'd1}],
					hrdata_32_array[{hrdata_32_array_addr[8:4],2'd0}]
					};
end // gen_data_width_128
if (DATA_WIDTH == 256 ) begin: gen_data_width_256
    assign	hrdata_match_data_width	=	{
					hrdata_32_array[{hrdata_32_array_addr[8:5],3'd7}],
					hrdata_32_array[{hrdata_32_array_addr[8:5],3'd6}],
					hrdata_32_array[{hrdata_32_array_addr[8:5],3'd5}],
					hrdata_32_array[{hrdata_32_array_addr[8:5],3'd4}],
					hrdata_32_array[{hrdata_32_array_addr[8:5],3'd3}],
					hrdata_32_array[{hrdata_32_array_addr[8:5],3'd2}],
					hrdata_32_array[{hrdata_32_array_addr[8:5],3'd1}],
					hrdata_32_array[{hrdata_32_array_addr[8:5],3'd0}]
					};
end // gen_data_width_256
if (DATA_WIDTH == 512 ) begin: gen_data_width_512
    assign	hrdata_match_data_width	=	{
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd15}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd14}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd13}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd12}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd11}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd10}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd9}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd8}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd7}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd6}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd5}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd4}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd3}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd2}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd1}],
					hrdata_32_array[{hrdata_32_array_addr[8:6],4'd0}]
					};
end // gen_data_width_512
if (DATA_WIDTH == 1024 ) begin: gen_data_width_1024
    assign	hrdata_match_data_width	=	{
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd31}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd30}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd29}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd28}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd27}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd26}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd25}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd24}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd23}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd22}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd21}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd20}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd19}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd18}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd17}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd16}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd15}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd14}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd13}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd12}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd11}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd10}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd9}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd8}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd7}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd6}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd5}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd4}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd3}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd2}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd1}],
					hrdata_32_array[{hrdata_32_array_addr[8:7],5'd0}]
					};
end // gen_data_width_1024
endgenerate
// VPERL_GENERATED_END

always @ (posedge hclk) begin
	if((ren | read_af_write)) begin
		case(hrdata_32_array_addr[11:9])
        		3'b000: hrdata <= hrdata_match_data_width;
        		default: hrdata <= {DATA_WIDTH{1'b0}};
		endcase
	end
end

endmodule

