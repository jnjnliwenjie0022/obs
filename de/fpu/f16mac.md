# uarch
## ref
- ref: [ucb-bar/berkeley-softfloat-3: SoftFloat release 3 (github.com)](https://github.com/ucb-bar/berkeley-softfloat-3/tree/master)
- ref: [Building an FPU In Verilog, Introduction](https://www.youtube.com/watch?v=rYkVdJnVJFQ&list=PLlO9sSrh8HrwcDHAtwec1ycV-m50nfUVs&index=2&ab_channel=ChrisLarsen)
- ref: [IEEE-754 Floating Point Converter (h-schmidt.net)](https://www.h-schmidt.net/FloatConverter/IEEE754.html)
- ref: [IEEE 754 Calculator](http://weitz.de/ieee/)
- ref: [What Every Computer Scientist Should Know About Floating-Point Arithmetic](https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html)
- ref: [Lecture notes - Floating Point Appreciation (wisc.edu)](https://pages.cs.wisc.edu/~markhill/cs354/Fall2008/notes/flpt.apprec.html)
## block_diagram
![[fma_uarch.svg]]

## format_mac
要多2個extra bit[[de/fpu/ref_f16mac/(FMA)Comparison of Single- and Dual-Pass Multiply-Add Fused Floating-Point Units.pdf#page=4&selection=27,14,31,59|12.713312, page 4]]
![[fma_format.svg]]
## op3_r
![[Pasted image 20240228182634.png]]

| scenario              | value      | exp        | airth_exp  |
| --------------------- | ---------- | ---------- | ---------- |
| largest normal number | $2^{15}*X$ | 11110 (30) | 15 (30-15) |
| 1                     | $2^{0}$    | 01111 (15) | 0 (15-15)  |

op1_exp_no_bias = is_op1_zero ? 0 : op1_exp - 15
op2_exp_no_bias = is_op2_zero ? 0 : op2_exp - 15
op3_exp_no_bias = is_op3_zero ? 0 : op3_exp - 15

![[op3_r.svg]]
```verilog
using cas4to2
(op1_exp -15) + (op2_exp -15) - (op3_exp -15) + 14 
=> op1_exp + op2_exp - op3_exp - 1
=> op1_exp + op2_exp + (~op3_exp)
Let: {CSA_C,1'b0}+CSA_S = op1_exp + op2_exp + (~op3_exp)
=> {CSA_C,1'b0} + CSA_S
```
## complement
```verilog
if (eff_sub == 1)
{AH,AL} < {BH,BL}
=> {AH,AL} - {BH,BL} < 0
=> {AH,0...0} + {~BH,~BL} + {0..0,0..1} < 0

if BL is all 0
=> AH + ~BH + 1 < 0
=> AH + CH + 1 < 0
=> AH < ~CH
=> if BL is 0 then AH < ~CH

if BL is not all 0
=> AH + ~BH + sticky < 0
=> AH + CH + sticky < 0
=> AH < ~CH + 1 -sticky
=> AH < ~CH + 0.1xxxxx
=> if BL is not all 0 then AH < ~CH
=> if BL is not all 0 then AH == ~CH
```
## mac_sum_neg
![[Pasted image 20240311163136.png]]
```verilog
if (eff_sub == 1)
{AH,AL}-{BH,BL}
if (mac_sum_neg)
-{AH,AL}+{BH,BL}
=> -{AH,0...0} + {BH,BL}
=> {~AH,1...0} + {0...0,0...1} + {BH,BL}
=> {~AH+1,0...0} + {BH,BL}
=> {~AH+1+BH,BL}
=> (~AH)+1+BH
=> (~AH)+1+(~(~BH))
=> (~AH)+1+(~CH)
Let: {CSA_Cinv,1'b0}+CSA_S = (~AH)+(~CH);
=> {CSA_Cinv,1'b1}+CSA_S
```


![[mac_sum_neg_16b.svg]]
## arith_exp_subnorm_detect
![[arith_exp_subnorm_detect.svg]]

## frd_rne_correction
![[frd_rne_correction.svg]]
## non_airth_op
[NaN - Wikipedia](https://en.wikipedia.org/wiki/NaN#Operations_generating_NaN)
[FP Exceptions (The GNU C Library)](https://www.gnu.org/software/libc/manual/html_node/FP-Exceptions.html)
[Exceptions and Exception Handling (oracle.com)](https://docs.oracle.com/cd/E19957-01/806-3568/ncg_handle.html)
## tininess
RISCV is compatilbe with **`tininess after rounding`**
Detecting tininess after rounding is usually slightly better because it results in fewer spurious underflow signals
The reason is that detecting tininess "before rounding" is simpler to implement. Another reason is that "after rounding" (i.e. the alternative tininess detection) is more difficult to understand. In 2006, David Hough said in the stds-754 list: "the definition of tininess after rounding depends on a hypothetical rounding to a hypothetical intermediate format that has confused everybody who has ever tried to implement underflow." He also said: "Tininess before rounding keeps underflow independent of rounding mode." (But note that overflow depends on the rounding mode, and this does not seem to be an issue.)
The reason is **not** because some implementations did it before IEEE 754 specified that detail. On the opposite, "after rounding" was for some time proposed to be the standard, and on this subject, Dan Zuras said in the stds-754 list in 2006: "The reason underflow after rounding was selected for section N is because Intel did it that way & it has become a de-facto standard." (Section N probably corresponded to [Annex U mentioned on Wikipedia](https://en.wikipedia.org/wiki/IEEE_754-2008_revision#Discussed_but_not_included).) Note that there were other reasons for "after rounding", such as symmetry with overflow (which is always after rounding) and avoiding some rare useless underflow exceptions.
![[Pasted image 20240315142306.png]]
## zero_sign
[Signed zero](https://en.wikipedia.org/wiki/Signed_zero)
# rounding
ref:
[CS 301 Lecture (uaf.edu)](https://www.cs.uaf.edu/2011/fall/cs301/lecture/11_09_weird_floats.html)
[FPU验证那些事 – Wenhui's Rotten Pen](https://www.wenhui.space/docs/07-ic-verify/verify-notes/fpu-verify/)
## concept
RISC-V Spec
1. RNE (Round to Nearest, ties to Even)
2. RMM (Round to Nearest, ties to Max Magnitude)
3. RDN (Round down / towards negative infinity)
4. RTZ (Round towards Zero)
5. RUP (Round up / towards positive infinity)

IEEE Spec
[Numerical behavior of NVIDIA tensor cores [PeerJ]](https://peerj.com/articles/cs-330/)
[IEEE 754 - Wikipedia](https://en.wikipedia.org/wiki/IEEE_754)
1. RE(rounds to nearest, ties to even): rounding toward even
2. RA(rounds to nearest, ties away from zero): 四捨五入
	=RMM(round to nearest, ties to max magnitude)
4. RD(rounds down): rounding toward -**∞**
5. RZ(rounds to zero): truncate
6. RU(rounds up): rounding toward +**∞**
![[fma_rounding.svg]]
## yz_algorithm
### original_yz_algorithm
![[fma_yz_original.svg]]
### simple_yz_algorithm
![[fma_yz.svg]]

## rne_correction
從這張圖可以看到RE跟RA幾乎一樣, 不同的地方只有
1. 在0.5(R=1,S=0)的時候, RE的LSB永遠為0, RE的其餘的資料都與RA一樣
因此只要用RA算完之後再判斷是否為0.5(R=1,S=0), 並强制將RA的LSB設爲0,即是RE
![[fma_rounding.svg]]
# fast_comparator
## csa_based_faster_comparator
```verilog
Let A, B, K without sign bit
// fast comparator method 1
A+B < K
=> A+B-K < 0
=> A+B+(~K)+1 < 0
Let: {CSA_C,1'b0}+CSA_S = A+B+(~K)
=> {CSA_C,1'b0}+CSA_S+1 < 0
=> {CSA_C,1'b0}-(-CSA_S)+1 < 0
=> {CSA_C,1'b0}-(~CSA_S+1)+1 < 0
=> {CSA_C,1'b0}-(~CSA_S)-1+1 < 0
=> {CSA_C,1'b0}-(~CSA_S) < 0
=> {CSA_C,1'b0} < ~CSA_S

// fast comparator method 2
(A+B)[m:n] < K[m:n]z
Let: {AH,AL} = {A[m:n], A[n-1:0]}
Let: {BH,BL} = {B[m:n], B[n-1:0]}
Let: {KH,KL} = {K[m:n], K[n-1:0]}
Let: {C,S} = AL+BL
=> AH+BH+C < KH
=> AH+BH+C-KH < 0
=> AH+BH+C+(~KH+1) < 0
=> AH+BH+(~KH)+C+1 < 0
Let: {CSA_C,1'b0}+CSA_S = AH+BH+(~KH)
=> {CSA_C,1'b0}+CSA_S+C+1 < 0
=> {CSA_C,1'b0}-(-CSA_S)+C+1 < 0
=> {CSA_C,1'b0}-(~CSA_S+1)+C+1 < 0
=> {CSA_C,1'b0}-(~CSA_S)-1+C+1 < 0
=> {CSA_C,1'b0}-(~CSA_S)+C < 0
=> {CSA_C,C}-(~CSA_S) < 0
=> {CSA_C,C} < ~CSA_S
```

# csa
[[csa_analysis.xlsx]]
## csa_compare_adder_tree
![[csa_compare_adder_tree.svg]]
## csa3to2

```verilog
module kv_csa3_2 (
    in0,
    in1,
    cin,
    sum,
    cout
);

parameter CSA_WIDTH = 32;
input [CSA_WIDTH - 1:0] in0;
input [CSA_WIDTH - 1:0] in1;
input [CSA_WIDTH - 1:0] cin;
output [CSA_WIDTH - 1:0] sum;
output [CSA_WIDTH - 1:0] cout;

integer i;
reg [CSA_WIDTH - 1:0] sum;
reg [CSA_WIDTH - 1:0] cout;
always @(in0 or in1 or cin) begin
    for (i = 0; i < CSA_WIDTH; i = i + 1) begin
        {cout[i],sum[i]} = {1'b0,in0[i]} + {1'b0,in1[i]} + {1'b0,cin[i]};
    end
end

endmodule
```
## csa4to2
csa4to2 is more useful than csa3to2:
(4;2) compressor tree has a more regular structure than an ordinary CSA tree made of (3,2) counters because the partial products are added up in the form of a binary tree.
![[csa4to2.svg]]
```verilog
module csa4_2 (
    in1,
    in2,
    in3,
    in4,
    sum,
    carry
);
parameter CSA_WIDTH = 32;
input [CSA_WIDTH - 1:0] in1;
input [CSA_WIDTH - 1:0] in2;
input [CSA_WIDTH - 1:0] in3;
input [CSA_WIDTH - 1:0] in4;
output [CSA_WIDTH:0] sum;
output [CSA_WIDTH - 1:0] carry;


wire [CSA_WIDTH - 1:0] carry_tmp;
assign carry_tmp = (in1 & in2) | (in1 & in3) | (in2 & in3);
assign sum = {carry_tmp[CSA_WIDTH - 1],in1 ^ in2 ^ in3 ^ in4 ^ {carry_tmp[CSA_WIDTH - 2:0],1'b0}};
assign carry = ((in1 ^ in2 ^ in3) & in4) | ((in1 ^ in2 ^ in3) & {carry_tmp[CSA_WIDTH - 2:0],1'b0}) | (in4 & {carry_tmp[CSA_WIDTH - 2:0],1'b0});
endmodule
```

## inverted_csa
![[Pasted image 20240205180117.png]]
```verilog
-(A+B)
=> (~A)+(~B)+2
Let: {CSA_Cinv,1'b0}+CSA_S = (~A)+(~B)
CSA_Cinv = ~(A[MSB:LSB] | B[MSB:LSB]);
CSA_S = A[MSB:LSB] ^ B[MSB:LSB];
=> {CSA_Cinv[MSB-1:LSB],1'b0} + CSA_S + 2;
```

```verilog
// compound_addr with left shifter method 3
suppose A,B is pos
Before execute A, A involve left shifter
=> -(A<<r+(B))
Let: K = A<<r
=> -(A<<R+(B)) = B+K
=> B+K = (~B)+1+(~K)+1
Let: {CSA_Cinv,1'b0}+CSA_S = (~K)+(~Q)
=> {CSA_Cinv,1'b0}+CSA_S+2
```
## compound_addr
```verilog
// compound_addr method 1
suppose A,B is pos
=> -(A-B) = -(A+(~B)+1)
=> B-A = -(A+(~B))-1
=>     = ~(A+(~B))+1-1
=>     = ~(A+(~B))
```
```verilog
// compound_addr mehtod 2
suppose A,B is pos
=> -(A-B) = -(A+(~B)+1)
Let: ~B = K
=> B-A = -(A+K+1)
=> (-A)+(-K)+(-1)
=> (~A)+1+(~K)+1+(-1)
=> (~A)+(~K)+1
Let: {CSA_Cinv,1'b0}+CSA_S = (~A)+(~K)
=> {CSA_Cinv,1'b0}+CSA_S+1
=> {CSA_Cinv,1'b1}+CSA_S
```

# barrel_shift
[[barrel_shift_analysis.xlsx]]
```verilog
assign complement = A0[0];
assign Z_l0 = A0;
assign Z_l1 = B0[6] ? {Z_l0[(64 - 64):0],{64{complement}}} : Z_l0;
assign Z_l2 = B0[5] ? {Z_l1[(64 - 32):0],{32{complement}}} : Z_l1;
assign Z_l3 = B0[4] ? {Z_l2[(64 - 16):0],{16{complement}}} : Z_l2;
assign Z_l4 = B0[3] ? {Z_l3[(64 - 8) :0],{8{complement}}}  : Z_l3;
assign Z_l5 = B0[2] ? {Z_l4[(64 - 4) :0],{4{complement}}}  : Z_l4;
assign Z_l6 = B0[1] ? {Z_l5[(64 - 2) :0],{2{complement}}}  : Z_l5;
assign Z_l7 = B0[0] ? {Z_l6[(64 - 1) :0],{1{complement}}}  : Z_l6;
```
# signed_compare

```verilog
A is sign
K is sign

1. K is sign constent and is positive
A > K
=> ~A[MSB] & (A[MSB-1:0] > K)

2. K is sign constent and is negative
A > K
	1. if A is positive (A[MSB] == 0) then A > K is alwasy correct
	2. if A is negative (A[MSB] == 1) then need to compare
		Let change A to positive
		Let change K to positive
		A[MSB-1:0] > K
		=> -A[MSB-1:0] < -K
		=> (~A[MSB-1:0]) + 1 < (~K) + 1
		=> (~A[MSB-1:0]) < (~K)
=> ~A[MSB] | ((~A[MSB-1:0]) < (~K))

```
# lzc
![[lzc.svg]]
```verilog
module kv_lzc_encode (
    lza_str,
    lzc
);

parameter WIDTH = 128;
localparam ENCODE_WIDTH = $clog2(WIDTH);
input [WIDTH - 1:0] lza_str;
output [ENCODE_WIDTH - 1:0] lzc;

generate
    if (WIDTH == 32) begin:gen_lzc_encode32
        wire [1:0] lzc_or_l1;
        wire [1:0] lzc_or_l2;
        wire [1:0] lzc_or_l3;
        wire [31:0] lza_str_l0;
        wire [15:0] lza_str_l1;
        wire [7:0] lza_str_l2;
        wire [3:0] lza_str_l3;
        wire [1:0] lza_str_l4;
        assign lzc_or_l1[0] = ~|lza_str[31 -:8];
        assign lzc_or_l1[1] = ~|lza_str[31 - 16 -:8];
        assign lzc_or_l2[0] = ~lzc[4] ? ~|lza_str[31 -:4] : ~|lza_str[31 - 16 -:4];
        assign lzc_or_l2[1] = ~lzc[4] ? ~|lza_str[31 - 8 -:4] : ~|lza_str[31 - 24 -:4];
        assign lzc_or_l3[0] = ~lzc[4] ? (~lzc[3] ? ~|lza_str[31 -:2] : ~|lza_str[31 - 8 -:2]) : (~lzc[3] ? ~|lza_str[31 - 16 -:2] : ~|lza_str[31 - 24 -:2]);
        assign lzc_or_l3[1] = ~lzc[4] ? (~lzc[3] ? ~|lza_str[31 - 4 -:2] : ~|lza_str[31 - 12 -:2]) : (~lzc[3] ? ~|lza_str[31 - 20 -:2] : ~|lza_str[31 - 28 -:2]);
        assign lzc[4] = ~|lza_str[31 -:16];
        assign lzc[3] = ~lzc[4] ? lzc_or_l1[0] : lzc_or_l1[1];
        assign lzc[2] = ~lzc[3] ? lzc_or_l2[0] : lzc_or_l2[1];
        assign lzc[1] = ~lzc[2] ? lzc_or_l3[0] : lzc_or_l3[1];
        assign lza_str_l0 = lza_str;
        assign lza_str_l1 = ~lzc[4] ? lza_str_l0[31 -:16] : lza_str_l0[15 -:16];
        assign lza_str_l2 = ~lzc[3] ? lza_str_l1[15 -:8] : lza_str_l1[7 -:8];
        assign lza_str_l3 = ~lzc[2] ? lza_str_l2[7 -:4] : lza_str_l2[3 -:4];
        assign lza_str_l4 = ~lzc[1] ? lza_str_l3[3 -:2] : lza_str_l3[1 -:2];
        assign lzc[0] = ~lza_str_l4[1];
    end
endgenerate
generate
    if (WIDTH == 8) begin:gen_lzc_encode8
        wire [1:0] lzc_or_l1;
        wire [7:0] lza_str_l0;
        wire [3:0] lza_str_l1;
        wire [1:0] lza_str_l2;
        assign lzc_or_l1[0] = ~|lza_str[(7) -:2];
        assign lzc_or_l1[1] = ~|lza_str[(7 - 4) -:2];
        assign lzc[2] = ~|lza_str[7 -:4];
        assign lzc[1] = ~lzc[2] ? lzc_or_l1[0] : lzc_or_l1[1];
        assign lzc[0] = ~lza_str_l2[1];
        assign lza_str_l0 = lza_str;
        assign lza_str_l1 = ~lzc[2] ? lza_str_l0[7 -:4] : lza_str_l0[3 -:4];
        assign lza_str_l2 = ~lzc[1] ? lza_str_l1[3 -:2] : lza_str_l1[1 -:2];
    end
endgenerate
generate
    if (WIDTH == 64) begin:gen_lzc_encode64
        wire [1:0] lzc_or_l1;
        wire [1:0] lzc_or_l2;
        wire [1:0] lzc_or_l3;
        wire [1:0] lzc_or_l4;
        wire [31:0] lza_str_l1;
        wire [15:0] lza_str_l2;
        wire [7:0] lza_str_l3;
        wire [3:0] lza_str_l4;
        wire [1:0] lza_str_l5;
        assign lzc_or_l1[0] = ~|lza_str[63 -:16];
        assign lzc_or_l1[1] = ~|lza_str[63 - 32 -:16];
        assign lzc_or_l2[0] = ~lzc[5] ? ~|lza_str[63 -:8] : ~|lza_str[63 - 32 -:8];
        assign lzc_or_l2[1] = ~lzc[5] ? ~|lza_str[63 - 16 -:8] : ~|lza_str[63 - 48 -:8];
        assign lzc_or_l3[0] = ~lzc[5] ? (~lzc[4] ? ~|lza_str[63 -:4] : ~|lza_str[63 - 16 -:4]) : (~lzc[4] ? ~|lza_str[63 - 32 -:4] : ~|lza_str[63 - 48 -:4]);
        assign lzc_or_l3[1] = ~lzc[5] ? (~lzc[4] ? ~|lza_str[63 - 8 -:4] : ~|lza_str[63 - 24 -:4]) : (~lzc[4] ? ~|lza_str[63 - 40 -:4] : ~|lza_str[63 - 56 -:4]);
        assign lzc_or_l4[0] = ~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[63 -:2] : ~|lza_str[63 - 8 -:2]) : (~lzc[3] ? ~|lza_str[63 - 16 -:2] : ~|lza_str[63 - 24 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[63 - 32 -:2] : ~|lza_str[63 - 40 -:2]) : (~lzc[3] ? ~|lza_str[63 - 48 -:2] : ~|lza_str[63 - 56 -:2]));
        assign lzc_or_l4[1] = ~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[63 - 4 -:2] : ~|lza_str[63 - 12 -:2]) : (~lzc[3] ? ~|lza_str[63 - 20 -:2] : ~|lza_str[63 - 28 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[63 - 36 -:2] : ~|lza_str[63 - 44 -:2]) : (~lzc[3] ? ~|lza_str[63 - 52 -:2] : ~|lza_str[63 - 60 -:2]));
        assign lzc[5] = ~|lza_str[63 -:32];
        assign lzc[4] = ~lzc[5] ? lzc_or_l1[0] : lzc_or_l1[1];
        assign lzc[3] = ~lzc[4] ? lzc_or_l2[0] : lzc_or_l2[1];
        assign lzc[2] = ~lzc[3] ? lzc_or_l3[0] : lzc_or_l3[1];
        assign lzc[1] = ~lzc[2] ? lzc_or_l4[0] : lzc_or_l4[1];
        assign lza_str_l1 = ~lzc[5] ? lza_str[63 -:32] : lza_str[31 -:32];
        assign lza_str_l2 = ~lzc[4] ? lza_str_l1[31 -:16] : lza_str_l1[15 -:16];
        assign lza_str_l3 = ~lzc[3] ? lza_str_l2[15 -:8] : lza_str_l2[7 -:8];
        assign lza_str_l4 = ~lzc[2] ? lza_str_l3[7 -:4] : lza_str_l3[3 -:4];
        assign lza_str_l5 = ~lzc[1] ? lza_str_l4[3 -:2] : lza_str_l4[1 -:2];
        assign lzc[0] = ~lza_str_l5[1];
    end
endgenerate
generate
    if (WIDTH == 128) begin:gen_lzc_encode128
        wire [1:0] lzc_or_l1;
        wire [1:0] lzc_or_l2;
        wire [1:0] lzc_or_l3;
        wire [1:0] lzc_or_l4;
        wire [1:0] lzc_or_l5;
        wire [63:0] lza_str_l1;
        wire [31:0] lza_str_l2;
        wire [15:0] lza_str_l3;
        wire [7:0] lza_str_l4;
        wire [3:0] lza_str_l5;
        wire [1:0] lza_str_l6;
        assign lzc_or_l1[0] = ~|lza_str[127 -:32];
        assign lzc_or_l1[1] = 1'b0;
        assign lzc_or_l2[0] = ~lzc[6] ? ~|lza_str[127 -:16] : ~|lza_str[127 - 64 -:16];
        assign lzc_or_l2[1] = ~lzc[6] ? ~|lza_str[127 - 32 -:16] : 1'b0;
        assign lzc_or_l3[0] = ~lzc[6] ? (~lzc[5] ? ~|lza_str[127 -:8] : ~|lza_str[127 - 32 -:8]) : (~lzc[5] ? ~|lza_str[127 - 64 -:8] : ~|lza_str[127 - 96 -:8]);
        assign lzc_or_l3[1] = ~lzc[6] ? (~lzc[5] ? ~|lza_str[127 - 16 -:8] : ~|lza_str[127 - 48 -:8]) : (~lzc[5] ? ~|lza_str[127 - 80 -:8] : 1'b0);
        assign lzc_or_l4[0] = ~lzc[6] ? (~lzc[5] ? (~lzc[4] ? ~|lza_str[127 -:4] : ~|lza_str[127 - 16 -:4]) : (~lzc[4] ? ~|lza_str[127 - 32 -:4] : ~|lza_str[127 - 48 -:4])) : (~lzc[5] ? (~lzc[4] ? ~|lza_str[127 - 64 -:4] : ~|lza_str[127 - 80 -:4]) : (~lzc[4] ? ~|lza_str[127 - 96 -:4] : ~|lza_str[127 - 112 -:4]));
        assign lzc_or_l4[1] = ~lzc[6] ? (~lzc[5] ? (~lzc[4] ? ~|lza_str[127 - 8 -:4] : ~|lza_str[127 - 24 -:4]) : (~lzc[4] ? ~|lza_str[127 - 40 -:4] : ~|lza_str[127 - 56 -:4])) : (~lzc[5] ? (~lzc[4] ? ~|lza_str[127 - 72 -:4] : ~|lza_str[127 - 88 -:4]) : (~lzc[4] ? ~|lza_str[127 - 104 -:4] : ~|lza_str[127 - 120 -:4]));
        assign lzc_or_l5[0] = ~lzc[6] ? (~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 -:2] : ~|lza_str[127 - 8 -:2]) : (~lzc[3] ? ~|lza_str[127 - 16 -:2] : ~|lza_str[127 - 24 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 32 -:2] : ~|lza_str[127 - 40 -:2]) : (~lzc[3] ? ~|lza_str[127 - 48 -:2] : ~|lza_str[127 - 56 -:2]))) : (~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 64 -:2] : ~|lza_str[127 - 72 -:2]) : (~lzc[3] ? ~|lza_str[127 - 80 -:2] : ~|lza_str[127 - 88 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 96 -:2] : ~|lza_str[127 - 104 -:2]) : (~lzc[3] ? ~|lza_str[127 - 112 -:2] : ~|lza_str[127 - 120 -:2])));
        assign lzc_or_l5[1] = ~lzc[6] ? (~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 4 -:2] : ~|lza_str[127 - 12 -:2]) : (~lzc[3] ? ~|lza_str[127 - 20 -:2] : ~|lza_str[127 - 28 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 36 -:2] : ~|lza_str[127 - 44 -:2]) : (~lzc[3] ? ~|lza_str[127 - 52 -:2] : ~|lza_str[127 - 60 -:2]))) : (~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 68 -:2] : ~|lza_str[127 - 76 -:2]) : (~lzc[3] ? ~|lza_str[127 - 84 -:2] : ~|lza_str[127 - 92 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 100 -:2] : ~|lza_str[127 - 108 -:2]) : (~lzc[3] ? ~|lza_str[127 - 116 -:2] : ~|lza_str[127 - 124 -:2])));
        assign lzc[6] = ~|lza_str[127 -:64];
        assign lzc[5] = ~lzc[6] ? lzc_or_l1[0] : lzc_or_l1[1];
        assign lzc[4] = ~lzc[5] ? lzc_or_l2[0] : lzc_or_l2[1];
        assign lzc[3] = ~lzc[4] ? lzc_or_l3[0] : lzc_or_l3[1];
        assign lzc[2] = ~lzc[3] ? lzc_or_l4[0] : lzc_or_l4[1];
        assign lzc[1] = ~lzc[2] ? lzc_or_l5[0] : lzc_or_l5[1];
        assign lza_str_l1 = ~lzc[6] ? lza_str[127 -:64] : lza_str[63 -:64];
        assign lza_str_l2 = ~lzc[5] ? lza_str_l1[63 -:32] : lza_str_l1[31 -:32];
        assign lza_str_l3 = ~lzc[4] ? lza_str_l2[31 -:16] : lza_str_l2[15 -:16];
        assign lza_str_l4 = ~lzc[3] ? lza_str_l3[15 -:8] : lza_str_l3[7 -:8];
        assign lza_str_l5 = ~lzc[2] ? lza_str_l4[7 -:4] : lza_str_l4[3 -:4];
        assign lza_str_l6 = ~lzc[1] ? lza_str_l5[3 -:2] : lza_str_l5[1 -:2];
        assign lzc[0] = ~lza_str_l6[1];
    end
endgenerate
endmodule
```
# lza
## algorithm
## egs_algorithm (A + B) (unfinished !!)

1. Sign(A) ^ Sign(B) = 1
2. . (A+B) 不可以overflow或是underflow
3. 有sign的概念且sign要參予運算
4. 適用"**減法**”處理
5. **可以同時偵測0或是1** [[(lza)Leading Zero Anticipation and Detection -- A Comparison of Methods.pdf#page=2&selection=132,1,156,3|Leading Zero Anticipation and Detection -- A Comparison of Methods, page 2]]
	1. sum = A+B
6. 1b誤差
7. 特定情況不會有1b誤差(有待調查)

## ap_algorithm (A + B)

結論：這個演算法就非常夠用了！！！

ref: [[(lza)Leading-Zero Anticipatory Logic for High-Speed Floating Point Addition.pdf]]
 1. 要求 (A+B) >= 0
	 1. P.S: 可以處理減法，但減法後的sum要求為正數
2. (A+B)不可以overflow或是underflow
	 1. EX: (0)1111 + (0)1000 (不合法)
	 2. EX: (0)0111 + (0)0100 (合法)
3. 有sign的概念且sign要參予運算
4. 適用”**加法**”和”減法”處理，但不建議減法處理
    1. 因為AP algorithm要求A+B，所以當A-B時，要變成A-B=A+(~B+1)才行
    2. “減法”處理需要額外電路做|A-B|的處理
    3. ~~delay比EGA algorihtm大，在fp64無法使用!!!~~
    4. delay好像沒有差別，因爲真正的critical path不在lza上，是在lzc上
5. 1b誤差
6. 特定情況不會有1b誤差(imperative)
	1. 條件是：
		1. 要先經過ha或是csa電路讓輸出是sum和carry的形式
		2. A + B = sum為特定情況
	2. 優點：
		1. 當arith_exp為norm的時候：可以解決is_ovf的情況下,進過rounding之後產生2次overflow的情況,永遠不會產生2次overflow情況(Y0[MAC_MSB+1],Y1[MAC_MSB+1],mac_sum_l[MAC_MSB+1],mslice[MAC_MSB+1]為永遠為0)
		2. 當arith_exp為subnorm的ubound的時候：因爲不會產生2次overflow情況，所以is_ovf永遠為“0”(Y0[MAC_MSB],Y1[MAC_MSB],mac_sum_l[MAC_MSB],mslice[MAC_MSB]為永遠為0)
		3. 當arith_exp為subnorm的時候：tininess 的數值必不會有lza 1b誤差，位置絕對正確
	3. 需要額外處理：
		1. 當arith_exp為underflow的是時候：會有2次的overflow要處理(即使lza沒有誤差,不是lza的問題是YZ algorithm的關係)，會使undrerflow的判定轉變成subnorm
	4. example:
	
![[example_ap_algorithm.svg]]

結論:
1. 加法:使用AP algorithm
2. 減法:使用EGS algorithm
3. 不論AP/EGS algorithm都會有1bit的誤差(LZA的結果會小於正解1個bit)
    1. EX: 正解: 1000; LZA: 0100
4. 不論AP/EGA algorithm正解為全1的時候不會有誤差

![[lza.svg]]

