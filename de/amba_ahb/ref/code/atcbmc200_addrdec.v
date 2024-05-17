`include "atcbmc200_config.vh"
`include "atcbmc200_const.vh"

module atcbmc200_addrdec( // VPERL: &PORTLIST;
                          // VPERL_GENERATED_BEGIN
                          	  base,     
                          	  addr,     
                          	  size,     
                          	  dec_en,   
                          	  sel       
                          // VPERL_GENERATED_END
);

parameter ADDR_WIDTH = `ATCBMC200_ADDR_MSB + 1;
parameter BASE_ADDR_LSB = (ADDR_WIDTH == 24) ? 10 : 20;

localparam ADDR_MSB = ADDR_WIDTH - 1;

input [ADDR_MSB:BASE_ADDR_LSB]    base;
input [ADDR_MSB:0]                addr;
input [3:0]                       size;
input                             dec_en;

output                            sel;

generate
if (ADDR_WIDTH == 24) begin : gen_addr_width_24
/* 24-bit address mapping mode */
reg [14:0] mask;

always @* begin
    case(size)
    4'h0: mask = 15'b0_00_0000_0000_0000;
    4'h1: mask = 15'b1_00_0000_0000_0000;
    4'h2: mask = 15'b1_00_0000_0000_0001;
    4'h3: mask = 15'b1_00_0000_0000_0011;
    4'h4: mask = 15'b1_00_0000_0000_0111;
    4'h5: mask = 15'b1_00_0000_0000_1111;
    4'h6: mask = 15'b1_00_0000_0001_1111;
    4'h7: mask = 15'b1_00_0000_0011_1111;
    4'h8: mask = 15'b1_00_0000_0111_1111;
    4'h9: mask = 15'b1_00_0000_1111_1111;
    4'hA: mask = 15'b1_00_0001_1111_1111;
    4'hB: mask = 15'b1_00_0011_1111_1111;
    4'hC: mask = 15'b1_00_0111_1111_1111;
    4'hD: mask = 15'b1_00_1111_1111_1111;
    4'hE: mask = 15'b1_01_1111_1111_1111;
    4'hF: mask = 15'b1_11_1111_1111_1111;
    endcase
end

assign sel = dec_en & mask[14] & ((addr[23] == base[23]) | mask[13]) &
                                 ((addr[22] == base[22]) | mask[12]) & 
                                 ((addr[21] == base[21]) | mask[11]) & 
                                 ((addr[20] == base[20]) | mask[10]) & 
                                 ((addr[19] == base[19]) | mask[9])  & 
                                 ((addr[18] == base[18]) | mask[8])  & 
                                 ((addr[17] == base[17]) | mask[7])  & 
                                 ((addr[16] == base[16]) | mask[6])  & 
                                 ((addr[15] == base[15]) | mask[5])  & 
                                 ((addr[14] == base[14]) | mask[4])  & 
                                 ((addr[13] == base[13]) | mask[3])  & 
                                 ((addr[12] == base[12]) | mask[2])  & 
                                 ((addr[11] == base[11]) | mask[1])  & 
                                 ((addr[10] == base[10]) | mask[0]);

end else begin : gen_addr_width_other
/* 32-bit address mapping mode */
reg [12:0] mask;

always @* begin
    case(size)
    4'h0:    mask = 13'b0_0000_0000_0000;
    4'h1:    mask = 13'b1_0000_0000_0000;
    4'h2:    mask = 13'b1_0000_0000_0001;
    4'h3:    mask = 13'b1_0000_0000_0011;
    4'h4:    mask = 13'b1_0000_0000_0111;
    4'h5:    mask = 13'b1_0000_0000_1111;
    4'h6:    mask = 13'b1_0000_0001_1111;
    4'h7:    mask = 13'b1_0000_0011_1111;
    4'h8:    mask = 13'b1_0000_0111_1111;
    4'h9:    mask = 13'b1_0000_1111_1111;
    4'hA:    mask = 13'b1_0001_1111_1111;
    4'hB:    mask = 13'b1_0011_1111_1111;
    4'hC:    mask = 13'b1_0111_1111_1111;
`ifdef ATCBMC200_PRIORITY_DECODE
    4'hD:    mask = 13'b1_1111_1111_1111;
`endif
    default: mask = 13'b0_0000_0000_0000;
    endcase
end

assign sel = dec_en & mask[12] & ((addr[31] == base[31]) | mask[11]) &
                                 ((addr[30] == base[30]) | mask[10]) & 
                                 ((addr[29] == base[29]) | mask[9])  & 
                                 ((addr[28] == base[28]) | mask[8])  & 
                                 ((addr[27] == base[27]) | mask[7])  & 
                                 ((addr[26] == base[26]) | mask[6])  & 
                                 ((addr[25] == base[25]) | mask[5])  & 
                                 ((addr[24] == base[24]) | mask[4])  & 
                                 ((addr[23] == base[23]) | mask[3])  & 
                                 ((addr[22] == base[22]) | mask[2])  & 
                                 ((addr[21] == base[21]) | mask[1])  & 
                                 ((addr[20] == base[20]) | mask[0]);

end
endgenerate

endmodule

