parameter CVT_ABS_MSB = 63;
parameter CVT_ABS_LSB = -2;
parameter CVT_ABS_RND = -1;
parameter CVT_ABS_STM = -2;
wire [CVT_ABS_MSB:CVT_ABS_LSB]f1_abs_in;

assign f1_abs_l0                =  f1_abs_amount[5] ?  {32'b0, f1_abs_in[CVT_ABS_MSB   :CVT_ABS_LSB+ 32]} : f1_abs_in;
assign f1_abs_l1                =  f1_abs_amount[4] ?  {16'b0, f1_abs_l0[CVT_ABS_MSB   :CVT_ABS_LSB+ 16]} : f1_abs_l0;
assign f1_abs_l2                =  f1_abs_amount[3] ?  { 8'b0, f1_abs_l1[CVT_ABS_MSB   :CVT_ABS_LSB+  8]} : f1_abs_l1;
assign f1_abs_l3                =  f1_abs_amount[2] ?  { 4'b0, f1_abs_l2[CVT_ABS_MSB   :CVT_ABS_LSB+  4]} : f1_abs_l2;
assign f1_abs_l4                =  f1_abs_amount[1] ?  { 2'b0, f1_abs_l3[CVT_ABS_MSB   :CVT_ABS_LSB+  2]} : f1_abs_l3;
assign f1_abs_l5                =  f1_abs_amount[0] ?  { 1'b0, f1_abs_l4[CVT_ABS_MSB   :CVT_ABS_LSB+  1]} : f1_abs_l4;

assign f1_abs_amount_64         = (f1_abs_amount == 'd64);
assign f1_abs_amount_65         = (f1_abs_amount == 'd65);
assign f1_abs_amount_hi_part    = (|f1_abs_amount[12:7]) | (f1_abs_amount[6] & |f1_abs_amount[5:1]); // gt65
assign f1_abs_sticky_l0         = (f1_abs_amount[5] &  (      |f1_abs_in[CVT_ABS_LSB+31:CVT_ABS_LSB    ])) ;
assign f1_abs_sticky_l1         = (f1_abs_amount[4] &  (      |f1_abs_l0[CVT_ABS_LSB+15:CVT_ABS_LSB    ])) | f1_abs_sticky_l0;
assign f1_abs_sticky_l2         = (f1_abs_amount[3] &  (      |f1_abs_l1[CVT_ABS_LSB+ 7:CVT_ABS_LSB    ])) | f1_abs_sticky_l1;
assign f1_abs_sticky_l3         = (f1_abs_amount[2] &  (      |f1_abs_l2[CVT_ABS_LSB+ 3:CVT_ABS_LSB    ])) | f1_abs_sticky_l2;
assign f1_abs_sticky_l4         = (f1_abs_amount[1] &  (      |f1_abs_l3[CVT_ABS_LSB+ 1:CVT_ABS_LSB    ])) | f1_abs_sticky_l3;
assign f1_abs_sticky_l5         = (f1_abs_amount[0] &  (       f1_abs_l4[CVT_ABS_LSB                   ])) | f1_abs_sticky_l4;
assign f1_abs_sticky            =  f1_abs_amount_hi_part | f1_abs_sticky_msb | f1_abs_sticky_l5;

assign f1_abs_round_bit         =  f1_abs_l5[CVT_ABS_RND];
assign f1_abs_sticky_msb        =  f1_abs_l5[CVT_ABS_STM];



