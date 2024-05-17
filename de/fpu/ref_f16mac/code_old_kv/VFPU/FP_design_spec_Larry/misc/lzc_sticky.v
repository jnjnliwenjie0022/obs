//==============================================================================================================
// Revision v0.1.0
// 
l5_sticky = 1’b0
l4_sticky = (f1_s_lz_num[4] == 1’b0) ? l5_sticky | (|bit[15:0])	:
									   l5_sticky				;
									   
l3_sticky = (f1_s_lz_num[4:3] == 2’b00) ? l4_sticky | (|bit[23:16])	: 
            (f1_s_lz_num[4:3] == 2’b01) ? l4_sticky					:
			(f1_s_lz_num[4:3] == 2’b10) ? l4_sticky | (|bit[7:0])	:
										  l4_sticky					;
										  
l2_sticky = (f1_s_lz_num[4:2] == 2’b000) ? l3_sticky | (|bit[27:24])	:
            (f1_s_lz_num[4:2] == 2’b001) ? l3_sticky					:
			(f1_s_lz_num[4:2] == 2’b010) ? l3_sticky | (|bit[19:16])	:
			(f1_s_lz_num[4:2] == 2’b011) ? l3_sticky					:
			(f1_s_lz_num[4:2] == 2’b100) ? l3_sticky | (|bit[11:8])		:
			(f1_s_lz_num[4:2] == 2’b101) ? l3_sticky 					:
			(f1_s_lz_num[4:2] == 2’b110) ? l3_sticky | (|bit[3:0]) 		: 
										   l3_sticky;

n_lzc0 = ~f1_s_lz_num[0];
l0_sticky_mask = {n_lzc0,1'b1};

l1_sticky = (f1_s_lz_num[4:1] == 2’b0000) ? l2_sticky | (|bit[29:28]) | (|(l0_sticky_mask & bit[31:30])) :
			(f1_s_lz_num[4:1] == 2’b0001) ? l2_sticky                 | (|(l0_sticky_mask & bit[29:28])) :
            (f1_s_lz_num[4:1] == 2’b0010) ? l2_sticky | (|bit[25:24]) | (|(l0_sticky_mask & bit[27:26])) :
			(f1_s_lz_num[4:1] == 2’b0011) ? l2_sticky                 | (|(l0_sticky_mask & bit[25:24])) :
			(f1_s_lz_num[4:1] == 2’b0100) ? l2_sticky | (|bit[21:20]) | (|(l0_sticky_mask & bit[23:22])) :
			(f1_s_lz_num[4:1] == 2’b0101) ? l2_sticky                 | (|(l0_sticky_mask & bit[21:20])) :
			(f1_s_lz_num[4:1] == 2’b0110) ? l2_sticky | (|bit[17:16]) | (|(l0_sticky_mask & bit[19:18])) :
			(f1_s_lz_num[4:1] == 2’b0111) ? l2_sticky                 | (|(l0_sticky_mask & bit[17:16])) :
			(f1_s_lz_num[4:1] == 2’b1000) ? l2_sticky | (|bit[13:12]) | (|(l0_sticky_mask & bit[15:14])) :
			(f1_s_lz_num[4:1] == 2’b1001) ? l2_sticky                 | (|(l0_sticky_mask & bit[13:12])) :
			(f1_s_lz_num[4:1] == 2’b1010) ? l2_sticky | (|bit[ 9: 8]) | (|(l0_sticky_mask & bit[11:10])) :
			(f1_s_lz_num[4:1] == 2’b1011) ? l2_sticky                 | (|(l0_sticky_mask & bit[ 9: 8])) :
			(f1_s_lz_num[4:1] == 2’b1100) ? l2_sticky | (|bit[ 5: 4]) | (|(l0_sticky_mask & bit[ 7: 6])) :
			(f1_s_lz_num[4:1] == 2’b1101) ? l2_sticky                 | (|(l0_sticky_mask & bit[ 5: 4])) :
			(f1_s_lz_num[4:1] == 2’b1111) ? l2_sticky | (|bit[ 1: 0]) | (|(l0_sticky_mask & bit[ 3: 2])) :
										    l2_sticky                 | (|(l0_sticky_mask & bit[ 1: 0])) ;


//==============================================================================================================
// Revision v0.1.1
//

l5_sticky     = 1’b0
l4_sticky     = l5_sticky |                  l5_mux_sticky;
l3_sticky     = l4_sticky |                  l4_mux_sticky;
l2_sticky     = l3_sticky |                  l3_mux_sticky;
l1_sticky     = l2_sticky |                  l2_mux_sticky;
l0_sticky     = l1_sticky | (|(l1_mux_mask & l1_mux_sticky));

l5_mux_mask   = ~f1_s_lz_num[4];
l4_mux_mask   = ~f1_s_lz_num[3];
l3_mux_mask   = ~f1_s_lz_num[2];
l2_mux_mask   = ~f1_s_lz_num[1];
l1_mux_mask   = {~f1_s_lz_num[0], 1'b1};

l5_mux_sticky = |(l5_mux_mask & bit[15:0]);
l4_mux_sticky = (f1_s_lz_num[4] == 1'b0) ? l4_mux_mask & (|bit[23:16]) :
										   l4_mux_mask & (|bit[ 7: 0]) ;
										   
l3_mux_sticky = (f1_s_lz_num[4:3] == 2'b00) ? l3_mux_mask & (|bit[27:24]) :
				(f1_s_lz_num[4:3] == 2'b01) ? l3_mux_mask & (|bit[19:16]) :
				(f1_s_lz_num[4:3] == 2'b10) ? l3_mux_mask & (|bit[11: 8]) :
											  l3_mux_mask & (|bit[ 3: 0]) ; 

l2_mux_sticky = (f1_s_lz_num[4:2] == 3'b000) ? l2_mux_mask & (|bit[29:28]) :
				(f1_s_lz_num[4:2] == 3'b001) ? l2_mux_mask & (|bit[25:24]) :
				(f1_s_lz_num[4:2] == 3'b010) ? l2_mux_mask & (|bit[21:20]) :
				(f1_s_lz_num[4:2] == 3'b011) ? l2_mux_mask & (|bit[17:16]) :
				(f1_s_lz_num[4:2] == 3'b100) ? l2_mux_mask & (|bit[13:12]) :
				(f1_s_lz_num[4:2] == 3'b101) ? l2_mux_mask & (|bit[ 9: 8]) :
				(f1_s_lz_num[4:2] == 3'b110) ? l2_mux_mask & (|bit[ 5: 4]) :
											   l2_mux_mask & (|bit[ 1: 0]) ;


l1_mux_sticky = (f1_s_lz_num[4:1] == 3'b0000) ? bit[31:30] :
				(f1_s_lz_num[4:1] == 3'b0001) ? bit[29:28] :
				(f1_s_lz_num[4:1] == 3'b0010) ? bit[27:26] :
				(f1_s_lz_num[4:1] == 3'b0011) ? bit[25:24] :
				(f1_s_lz_num[4:1] == 3'b0100) ? bit[23:22] :
				(f1_s_lz_num[4:1] == 3'b0101) ? bit[21:20] :
				(f1_s_lz_num[4:1] == 3'b0110) ? bit[19:18] :
				(f1_s_lz_num[4:1] == 3'b0111) ? bit[17:16] :
				(f1_s_lz_num[4:1] == 3'b1000) ? bit[15:14] :
				(f1_s_lz_num[4:1] == 3'b1001) ? bit[13:12] :
				(f1_s_lz_num[4:1] == 3'b1010) ? bit[11:10] :
				(f1_s_lz_num[4:1] == 3'b1011) ? bit[ 9: 8] :
				(f1_s_lz_num[4:1] == 3'b1100) ? bit[ 7: 6] :
				(f1_s_lz_num[4:1] == 3'b1101) ? bit[ 5: 4] :
				(f1_s_lz_num[4:1] == 3'b1110) ? bit[ 3: 2] :
											    bit[ 1: 0] ;

//==============================================================================================================
// Revision v0.1.2
//

l5_sticky     = 1’b0
l4_sticky     = l5_sticky |   (l5_mux_mask & l5_mux_sticky);
l3_sticky     = l4_sticky |   (l4_mux_mask & l4_mux_sticky);
l2_sticky     = l3_sticky |   (l3_mux_mask & l3_mux_sticky);
l1_sticky     = l2_sticky |   (l2_mux_mask & l2_mux_sticky);
l0_sticky     = l1_sticky | (|(l1_mux_mask & l1_mux_sticky));

l5_mux_mask   = ~f1_s_lz_num[4];
l4_mux_mask   = ~f1_s_lz_num[3];
l3_mux_mask   = ~f1_s_lz_num[2];
l2_mux_mask   = ~f1_s_lz_num[1];
l1_mux_mask   = {~f1_s_lz_num[0], 1'b1};

l5_mux_sticky = |bit[15:0];
l4_mux_sticky = (f1_s_lz_num[4] == 1'b0) ? |bit[23:16] :
										   |bit[ 7: 0] ;
										   
l3_mux_sticky = (f1_s_lz_num[4:3] == 2'b00) ? |bit[27:24] :
				(f1_s_lz_num[4:3] == 2'b01) ? |bit[19:16] :
				(f1_s_lz_num[4:3] == 2'b10) ? |bit[11: 8] :
											  |bit[ 3: 0] ; 

l2_mux_sticky = (f1_s_lz_num[4:2] == 3'b000) ? |bit[29:28] :
				(f1_s_lz_num[4:2] == 3'b001) ? |bit[25:24] :
				(f1_s_lz_num[4:2] == 3'b010) ? |bit[21:20] :
				(f1_s_lz_num[4:2] == 3'b011) ? |bit[17:16] :
				(f1_s_lz_num[4:2] == 3'b100) ? |bit[13:12] :
				(f1_s_lz_num[4:2] == 3'b101) ? |bit[ 9: 8] :
				(f1_s_lz_num[4:2] == 3'b110) ? |bit[ 5: 4] :
											   |bit[ 1: 0] ;


l1_mux_sticky = (f1_s_lz_num[4:1] == 3'b0000) ? bit[31:30] :
				(f1_s_lz_num[4:1] == 3'b0001) ? bit[29:28] :
				(f1_s_lz_num[4:1] == 3'b0010) ? bit[27:26] :
				(f1_s_lz_num[4:1] == 3'b0011) ? bit[25:24] :
				(f1_s_lz_num[4:1] == 3'b0100) ? bit[23:22] :
				(f1_s_lz_num[4:1] == 3'b0101) ? bit[21:20] :
				(f1_s_lz_num[4:1] == 3'b0110) ? bit[19:18] :
				(f1_s_lz_num[4:1] == 3'b0111) ? bit[17:16] :
				(f1_s_lz_num[4:1] == 3'b1000) ? bit[15:14] :
				(f1_s_lz_num[4:1] == 3'b1001) ? bit[13:12] :
				(f1_s_lz_num[4:1] == 3'b1010) ? bit[11:10] :
				(f1_s_lz_num[4:1] == 3'b1011) ? bit[ 9: 8] :
				(f1_s_lz_num[4:1] == 3'b1100) ? bit[ 7: 6] :
				(f1_s_lz_num[4:1] == 3'b1101) ? bit[ 5: 4] :
				(f1_s_lz_num[4:1] == 3'b1110) ? bit[ 3: 2] :
											    bit[ 1: 0] ;

//==============================================================================================================
// Revision v0.1.3
//

l5_sticky     = 1’b0
l4_sticky     = l5_sticky |   (l5_mux_mask & l5_mux_sticky);
l3_sticky     = l4_sticky |   (l4_mux_mask & l4_mux_sticky);
l2_sticky     = l3_sticky |   (l3_mux_mask & l3_mux_sticky);
l1_sticky     = l2_sticky | (|(l2_mux_mask & l2_mux_sticky));
//l0_sticky     = l1_sticky | (|(l1_mux_mask & l1_mux_sticky));

l5_mux_mask   = ~f1_s_lz_num[4];
l4_mux_mask   = ~f1_s_lz_num[3];
l3_mux_mask   = ~f1_s_lz_num[2];
l2_mux_mask   = {~f1_s_lz_num[1] & ~f1_s_lz_num[0], ~f1_s_lz_num[1], ~(&f1_s_lz_num[1:0]), 1'b1};
//l1_mux_mask   = {~f1_s_lz_num[0], 1'b1};

l5_mux_sticky = |(bit[15:0]);
l4_mux_sticky = (f1_s_lz_num[4] == 1'b0) ? |bit[23:16] :
										   |bit[ 7: 0] ;
										   
l3_mux_sticky = (f1_s_lz_num[4:3] == 2'b00) ? |bit[27:24] :
				(f1_s_lz_num[4:3] == 2'b01) ? |bit[19:16] :
				(f1_s_lz_num[4:3] == 2'b10) ? |bit[11: 8] :
											  |bit[ 3: 0] ; 

l2_mux_sticky = (f1_s_lz_num[4:2] == 3'b000) ? bit[31:28] :
				(f1_s_lz_num[4:2] == 3'b001) ? bit[27:24] :
				(f1_s_lz_num[4:2] == 3'b010) ? bit[23:20] :
				(f1_s_lz_num[4:2] == 3'b011) ? bit[19:16] :
				(f1_s_lz_num[4:2] == 3'b100) ? bit[15:12] :
				(f1_s_lz_num[4:2] == 3'b101) ? bit[11: 8] :
				(f1_s_lz_num[4:2] == 3'b110) ? bit[ 7: 4] :
											   bit[ 3: 0] ;

											   
//==============================================================================================================
// Revision v0.1.2.1
//

l5_sticky     = 1’b0
l4_sticky     = l5_sticky |   (l5_mux_mask & l5_mux_sticky);
l3_sticky     = l4_sticky |   (l4_mux_mask & l4_mux_sticky);
l2_sticky     = l3_sticky |   (l3_mux_mask & l3_mux_sticky);
l1_sticky     = l2_sticky |   (l2_mux_mask & l2_mux_sticky);
l0_sticky     = l1_sticky | (|(l1_mux_mask & l1_mux_sticky));

l5_mux_mask   = ~f1_s_lz_num[4];
l4_mux_mask   = ~f1_s_lz_num[3];
l3_mux_mask   = ~f1_s_lz_num[2];
l2_mux_mask   = ~f1_s_lz_num[1];
l1_mux_mask   = {~f1_s_lz_num[0], 1'b1};

l5_mux_sticky_0 = |bit[15:0]; //15

l4_mux_sticky_0 = |bit[23:16]; // 8
l4_mux_sticky_1 = |bit[ 7: 0];

l3_mux_sticky_0 = (f1_s_lz_num[4:4] == 1'b0) ? |bit[27:24] : |bit[11: 8] ; // 4
l3_mux_sticky_1 = (f1_s_lz_num[4:4] == 1'b0) ? |bit[19:16] : |bit[ 3: 0] ; 


l2_mux_sticky_0 = (f1_s_lz_num[4:3] == 2'b00) ? |bit[29:28] : // 2
				  (f1_s_lz_num[4:3] == 2'b01) ? |bit[21:20] :
				  (f1_s_lz_num[4:3] == 2'b10) ? |bit[13:12] :
												|bit[ 5: 4] ;

l2_mux_sticky_1 = (f1_s_lz_num[4:3] == 2'b00) ? |bit[25:24] :
				  (f1_s_lz_num[4:3] == 2'b01) ? |bit[17:16] :
				  (f1_s_lz_num[4:3] == 2'b10) ? |bit[ 9: 8] :
												|bit[ 1: 0] ;

l1_mux_sticky_0 = (f1_s_lz_num[4:2] == 3'b000) ? bit[31:30] : 
				  (f1_s_lz_num[4:2] == 3'b001) ? bit[27:26] :
				  (f1_s_lz_num[4:2] == 3'b010) ? bit[23:22] :
				  (f1_s_lz_num[4:2] == 3'b011) ? bit[19:18] :
				  (f1_s_lz_num[4:2] == 3'b100) ? bit[15:14] :
				  (f1_s_lz_num[4:2] == 3'b101) ? bit[11:10] :
				  (f1_s_lz_num[4:2] == 3'b110) ? bit[ 7: 6] :
												 bit[ 3: 2] ;

l1_mux_sticky_1 = (f1_s_lz_num[4:2] == 3'b000) ? bit[29:28] :
				  (f1_s_lz_num[4:2] == 3'b001) ? bit[25:24] :
				  (f1_s_lz_num[4:2] == 3'b010) ? bit[21:20] :
				  (f1_s_lz_num[4:2] == 3'b011) ? bit[17:16] :
				  (f1_s_lz_num[4:2] == 3'b100) ? bit[13:12] :
				  (f1_s_lz_num[4:2] == 3'b101) ? bit[ 9: 8] :
				  (f1_s_lz_num[4:2] == 3'b110) ? bit[ 5: 4] :
											     bit[ 1: 0] ;

l5_mux_sticky = l5_mux_sticky_0;
l4_mux_sticky = f1_s_lz_num[4] ? l4_mux_sticky_1 : l4_mux_sticky_0;
l3_mux_sticky = f1_s_lz_num[3] ? l3_mux_sticky_1 : l3_mux_sticky_0;
l2_mux_sticky = f1_s_lz_num[2] ? l2_mux_sticky_1 : l2_mux_sticky_0;
l1_mux_sticky = f1_s_lz_num[1] ? l1_mux_sticky_1 : l1_mux_sticky_0;
//==============================================================================================================