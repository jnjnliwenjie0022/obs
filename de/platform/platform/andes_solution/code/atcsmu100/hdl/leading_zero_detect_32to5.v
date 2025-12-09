//leading zero detection 
module leading_zero_detect_32to5 (
input		reverse,
input	[31:0]	data_in,
output	[4:0]	leading_zero_vector
);
genvar i;
genvar i_lzd4;
genvar i_lzd8;
genvar i_lzd16;
wire	[1:0]	lead_zero_detect_4_p[0:7];
wire		lead_zero_detect_4_v[0:7];
wire	[2:0]	lead_zero_detect_8_p[0:3];
wire		lead_zero_detect_8_v[0:3];
wire	[3:0]	lead_zero_detect_16_p[0:1];
wire		lead_zero_detect_16_v[0:1];
wire	[4:0]	lead_zero_detect_32_p;
wire	[31:0]	data;

for (i = 0 ; i < 32 ; i = i + 1) begin : gen_blk_data_reverse
	assign data[i] = reverse ? data_in[31-i] : data_in[i];
end 

generate 
for (i_lzd4 = 0; i_lzd4 < 8; i_lzd4 = i_lzd4 + 1) begin : gen_lzd4
	assign lead_zero_detect_4_p[i_lzd4][1] =  ~data[i_lzd4*4+3] & ~data[i_lzd4*4+2];
	assign lead_zero_detect_4_p[i_lzd4][0] = (~data[i_lzd4*4+3] & ~data[i_lzd4*4+1]) | (~data[i_lzd4*4+3] & data[i_lzd4*4+2]);
	assign lead_zero_detect_4_v[i_lzd4] = |(data[i_lzd4*4+3:i_lzd4*4]);
end
endgenerate

generate
for (i_lzd8 = 0; i_lzd8 < 4; i_lzd8 = i_lzd8 + 1) begin : gen_lzd8
	assign lead_zero_detect_8_p[i_lzd8] = lead_zero_detect_4_v[i_lzd8*2+1] ? {1'b0,lead_zero_detect_4_p[i_lzd8*2+1]} : {1'b1,lead_zero_detect_4_p[i_lzd8*2]};
	assign lead_zero_detect_8_v[i_lzd8] = lead_zero_detect_4_v[i_lzd8*2+1] | lead_zero_detect_4_v[i_lzd8*2]; 
end
endgenerate

generate
for (i_lzd16 = 0; i_lzd16 < 2; i_lzd16 = i_lzd16 + 1) begin : gen_lzd16
	assign lead_zero_detect_16_p[i_lzd16] = lead_zero_detect_8_v[i_lzd16*2+1] ? {1'b0,lead_zero_detect_8_p[i_lzd16*2+1]} : {1'b1,lead_zero_detect_8_p[i_lzd16*2]};
	assign lead_zero_detect_16_v[i_lzd16] = lead_zero_detect_8_v[i_lzd16*2+1] | lead_zero_detect_8_v[i_lzd16*2]; 
end
endgenerate

//assign lead_zero_detect_32_p = lead_zero_detect_16_v[i_lzd32*2+1] ? {1'b0,lead_zero_detect_16_p[i_lzd32*2+1]} : {1'b1,lead_zero_detect_16_p[i_lzd32*2]};
assign lead_zero_detect_32_p = lead_zero_detect_16_v[1] ? {1'b0,lead_zero_detect_16_p[1]} : {1'b1,lead_zero_detect_16_p[0]};
assign leading_zero_vector = lead_zero_detect_32_p;

endmodule
