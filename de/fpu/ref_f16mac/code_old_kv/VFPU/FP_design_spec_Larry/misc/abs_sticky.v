//==============================================================================================================
// Revision v0.1.0
//
assign l4_mux_sticky 	= |bit[16:31];

assign l3_mux_sticky 	= (LZC[4] == 1’b0) & (|bit[24:31])
						| (LZC[4] == 1’b1) & (|bit[ 8:15]);

assign l2_mux_sticky 	= (LZC[4:3] == 2’b00) & (|bit[28:31])
						| (LZC[4:3] == 2’b01) & (|bit[20:23])
						| (LZC[4:3] == 2’b10) & (|bit[12:15])
						| (LZC[4:3] == 2’b11) & (|bit[ 4: 7])
						| (LZC[4:3] == 2’b00) & (|bit[28:31])
						| (LZC[4:3] == 2’b01) & (|bit[20:23])
						| (LZC[4:3] == 2’b10) & (|bit[12:15])
						| (LZC[4:3] == 2’b11) & (|bit[ 4: 7]);

assign l1_mux_sticky 	= (LZC[4:2] == 3’b000) & (|bit[30:31])
						| (LZC[4:2] == 3’b001) & (|bit[26:27])
						| (LZC[4:2] == 3’b010) & (|bit[22:23])
						| (LZC[4:2] == 3’b011) & (|bit[18:19])
						| (LZC[4:2] == 3’b100) & (|bit[14:15])
						| (LZC[4:2] == 3’b101) & (|bit[10:11])
						| (LZC[4:2] == 3’b110) & (|bit[ 6: 7])
						| (LZC[4:2] == 3’b111) & (|bit[ 2: 3]);

assign l0_mux_sticky 	= (LZC[4:1] == 4’b0000) & bit[31]
						| (LZC[4:1] == 4’b0001) & bit[29]
						| (LZC[4:1] == 4’b0010) & bit[27]
						| (LZC[4:1] == 4’b0011) & bit[25]
						| (LZC[4:1] == 4’b0100) & bit[23]
						| (LZC[4:1] == 4’b0101) & bit[21]
						| (LZC[4:1] == 4’b0110) & bit[19]
						| (LZC[4:1] == 4’b0111) & bit[17]
						| (LZC[4:1] == 4’b1000) & bit[15]
						| (LZC[4:1] == 4’b1001) & bit[13]
						| (LZC[4:1] == 4’b1010) & bit[11]
						| (LZC[4:1] == 4’b1011) & bit[ 9]
						| (LZC[4:1] == 4’b1100) & bit[ 7]
						| (LZC[4:1] == 4’b1101) & bit[ 5]
						| (LZC[4:1] == 4’b1110) & bit[ 3]
						| (LZC[4:1] == 4’b1111) & bit[ 1];

assign l4_sticky = LZC[4] & l4_mux_sticky;
assign l3_sticky = LZC[3] & l3_mux_sticky | l4_sticky;
assign l2_sticky = LZC[2] & l2_mux_sticky | l3_sticky;
assign l1_sticky = LZC[1] & l1_mux_sticky | l2_sticky;
assign l0_sticky = LZC[0] & l0_mux_sticky | l1_sticky;

assign sticky = l0_sticky;						
//==============================================================================================================
// Revision v0.1.1
//

assign l4_mux_sticky 	= |bit[16:31];

assign l3_mux_sticky 	= (LZC[4] == 1’b0) & (|bit[24:31])
						| (LZC[4] == 1’b1) & (|bit[ 8:15]);

assign l2_mux_sticky 	= (LZC[4:3] == 2’b00) & (|bit[28:31])
						| (LZC[4:3] == 2’b01) & (|bit[20:23])
						| (LZC[4:3] == 2’b10) & (|bit[12:15])
						| (LZC[4:3] == 2’b11) & (|bit[ 4: 7]);

assign l1_mux_sticky 	= (LZC[4:2] == 3’b000) & (|bit[30:31])
						| (LZC[4:2] == 3’b001) & (|bit[26:27])
						| (LZC[4:2] == 3’b010) & (|bit[22:23])
						| (LZC[4:2] == 3’b011) & (|bit[18:19])
						| (LZC[4:2] == 3’b100) & (|bit[14:15])
						| (LZC[4:2] == 3’b101) & (|bit[10:11])
						| (LZC[4:2] == 3’b110) & (|bit[ 6: 7])
						| (LZC[4:2] == 3’b111) & (|bit[ 2: 3]);

assign l0_mux_sticky 	= (LZC[4:1] == 4’b0000) & bit[31]
						| (LZC[4:1] == 4’b0001) & bit[29]
						| (LZC[4:1] == 4’b0010) & bit[27]
						| (LZC[4:1] == 4’b0011) & bit[25]
						| (LZC[4:1] == 4’b0100) & bit[23]
						| (LZC[4:1] == 4’b0101) & bit[21]
						| (LZC[4:1] == 4’b0110) & bit[19]
						| (LZC[4:1] == 4’b0111) & bit[17]
						| (LZC[4:1] == 4’b1000) & bit[15]
						| (LZC[4:1] == 4’b1001) & bit[13]
						| (LZC[4:1] == 4’b1010) & bit[11]
						| (LZC[4:1] == 4’b1011) & bit[ 9]
						| (LZC[4:1] == 4’b1100) & bit[ 7]
						| (LZC[4:1] == 4’b1101) & bit[ 5]
						| (LZC[4:1] == 4’b1110) & bit[ 3]
						| (LZC[4:1] == 4’b1111) & bit[ 1];

assign l4_mux_mask = LZC[4];
assign l3_mux_mask = LZC[3];
assign l2_mux_mask = LZC[2];
assign l1_mux_mask = LZC[1];
assign l0_mux_mask = LZC[0];

assign l4_sticky = l4_mux_mask & l4_mux_sticky;
assign l3_sticky = l3_mux_mask & l3_mux_sticky;
assign l2_sticky = l2_mux_mask & l2_mux_sticky;
assign l1_sticky = l1_mux_mask & l1_mux_sticky;
assign l0_sticky = l0_mux_mask & l0_mux_sticky;

assign sticky	= l4_sticky | l3_sticky | l2_sticky | l1_sticky | l0_sticky;