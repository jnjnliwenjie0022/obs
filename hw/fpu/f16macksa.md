# uarch

## optimization
![[floating_point_64_optimization_concept.svg]]
## block_diagram
![[fma_uarch_with_ksa.svg]]

## mac_sum_neg
![[mac_sum_neg_64b.svg]]
## lza_error_detect
因爲有沒有將完整的mac_sum計算出來,在經過yz algorithm的時候,會發生錯誤,需要is_ovf_bit_zero修正
1. prefix_adder會產生cslice_carry,會使mslice原正確數值0...0變成1...1,這個結果回事判斷ovf產生錯誤行爲
2. 0...0小數值發生在arith_exp_subnom_detect的時候被確定
## frd_rne_correction
![[frd_rne_correction_with_ksa.svg]]

# fast_adder
carry look ahead 
1. area大
2. delay中
3. power小
=> 將carry look ahead做整理之後得到kogge-stone adder
kogge-stone adder因爲共用電路關係所以很小,速度也比較快
1. area比carry look ahead小
2. delay比carry look ahead小
3. power比carry look ahead小
## carry_look_ahead
```verilog
根據carry look ahead的特性我們知道，S才是我們要求的目標數值C只是中間數值
S(0) = A(0) ^ B(0) ^ C(-1)
C(0) = (A(0) & B(0)) | (((A(0) ^ B(0)) & C(-1))
=> S(i) = A(i) ^ B(i) ^ Cin(i-1)
=> C(i) = (A(i) & B(i)) | (((A(i) ^ B(i)) & C(i-1))
Let:
P = A ^ B
G = A & B
P(i) = A(i) ^ B(i)
G(i) = A(i) & B(i)
=> S(i) = P(i) ^ C(i-1)
=> C(i) = G(i) | (P(i) & C(i-1))

S(i)展開, 目標是求出S(i)
S(0) = P(0) ^ C(-1)
S(1) = P(1) ^ C(0)
S(2) = P(2) ^ C(1)
S(3) = P(3) ^ C(2)
Cout = C(3) (用不到)

C(i)展開
C(0) = G(0) | (P(0) & C(-1))
C(1) = G(1) | (P(1) & C(0))
     = G(1) | (P(1) & (G(0) | (P(0) & C(-1))))
	 = G(1) | (P(1) & G(0) | (P(1) & P(0) & C(-1)))
	 = G(1) | (P(1) & G(0)) | (P(1) & P(0) & C(-1))
C(2) = G(2) | (P(2) & G(1)) | (P(2) & P(1) & G(0)) | (P(2) & P(1) & P(0) & C(-1))
C(3) = G(3) | (P(3) & G(2)) | (P(3) & P(2) & G(1)) | (P(3) & P(2) & P(1) & G(0)) | (P(3) & P(2) & P(1) & P(0) & C(-1))

// CLA
=> C(0) = G(0) | (P(0) & C(-1))
=> C(1) = G(1) | (P(1) & G(0)) | (P(1) & P(0) & C(-1))
=> C(2) = G(2) | (P(2) & G(1)) | (P(2) & P(1) & G(0)) | (P(2) & P(1) & P(0) & C(-1))
=> C(3) = G(3) | (P(3) & G(2)) | (P(3) & P(2) & G(1)) | (P(3) & P(2) & P(1) & G(0)) | (P(3) & P(2) & P(1) & P(0) & C(-1))
```
ref:
[Advanced VLSI Design: Arithmetic Circuits: Part-1 (youtube.com)](https://www.youtube.com/watch?v=ivry9K_7HzM&t=4453s)
## kogge_stone
![[kogge_stone.svg]]
formula:
[[【HDL系列】Kogge-Stone加法器原理与设计_kogge stone-CSDN博客.pdf]]
$i = 0,1,...,n$
$c_{-1} = c_{in}$
$s_{i}=a_{i} \oplus b_{i} \oplus c_{i-1}$
$c_{i}=(a_{i} \land b_{i}) \lor ((a_{i} \oplus b_{i}) \land c_{i-1})$

$Let: p_{i} = a_{i} \oplus b_{i}$
$Let: g_{i} = a_{i} \land b_{i}$
$i = 0,1,...,n$
$s_{i} = p_{i} \oplus c_{i-1}$
$c_{i}= g_{i} \lor (p_{i} \land c_{i-1})$

修改運算子
$c_{i}= g_{i} + p_{i}c_{i-1}$

廣義化

$C_{m:n}= G_{m:n} = G_{m:k}+P_{m:k}C_{k-1:n}$
$P_{m:n} = P_{m:k}P_{k-1:n}$
$G_{m:0} = C_{m:0} = C_{m}$
$G_{m:m} = G_{m} = a_{i} \land b_{i}$
$P_{m:m} = P_{m} = a_{i} \oplus b_{i}$
$S_{m} = P_{m} \oplus C_{m-1} = P_{m} \oplus C_{m-1:0} = P_{m} \oplus G_{m-1:0}$

```verilog
if P(m:n) == 1 then G(m:n) == 0;

=> if P(m:n) == 1 then P(m:m)P(m-1:m-1)...P(n:n) == 1 then P(m:m) == 1;
=> if P(m:m) == 1 then (a = 1, b = 0) or (a = 0, b = 1) then G(m:m) = 0;
=> if P(m-1:m-1) == 1 then (a = 1, b = 0) or (a = 0, b = 1) then G(m-1:m-1) = 0;
=> if P(n:n) == 1 then (a = 1, b = 0) or (a = 0, b = 1) then G(n:n) = 0;
G(m:n) = G(m:m) + P(m:m)G(m-1:n);
=> G(m:n) = (0) + (1)G(m-1:n);
=> G(m:n) = G(m-1:n);
G(m-1:n) = G(m-1:m-1) + P(m-1:m-1)G(m-2:n)
=> G(m-1:n) = (0) + (1)G(m-2:n);
=> G(m-1:n) = G(m-2:n);
=> G(m:n) = G(m-1:n) = G(m-2:n) = G(n:n) = 0;

#QED
```

標準的kogge_stone是針對$C_{in} = 0$來處理, 如果$C_{in} \neq 0$則要另外處理
$C_{in} = 0$的kogge_stone
![[Pasted image 20240216000041.png]]
## kogge_stone_cin
一般而言kogge_stone_prefix_adder不會實作cin, cin要另外處理

$C_{in} \neq 0$的kogge_stone
$G_{m:m} = G_{m} = a_{i} \land b_{i}$
$P_{m:m} = P_{m} = a_{i} \oplus b_{i}$

![[kogge_stone_cin.svg]]
[[(Adder)Fast Parallel-Prefix Modulo 2n add 1 Adders.pdf#page=2&selection=1144,0,1144,48|Fast Parallel-Prefix Modulo 2n add 1 Adders, page 2]]
![[Pasted image 20240220154613.png]]
## kogge_stone_truncate
![[kogge_stone_truncate.svg]]
## kogge_stone_cin_truncate
![[kogge_stone_cin_truncate.svg]]

## prefix_adder_based_faster_comparator (unfinished)
[[(Adder)Evaluation of A+B = K Conditions Without Carry Propagation.pdf]]
![[Pasted image 20240223022622.png]]
![[Pasted image 20240223022638.png]]
```verilog
assign f3_lslice_v = ({f3_lslice_p0[105:MAC_LSB],1'b0} | {f3_lslice_g2[105:MAC_LSB],1'b0} | {(106 - MAC_LSB + 1){f3_complement}}) ~^ {f3_lslice_p0};
assign f3_sticky = f3_align_sticky | ~(&f3_lslice_v);
```
# lza_with_csa_negative_detect (unfinished)
在經過csa3_2之前, 如果為有效加法則結果必為正, 沒有判斷正負的必要性
在經過csa3_2之前, 如果為有效減法則結果必為負, 有判斷正負的必要性
```verilog
in0 + in1 + cin + b
P.S: b is 2'complementation for cin and b is 1 bit
Let: {CSA_C,1'b0} + CSA_S = in0 + in1 + cin
=> {CSA_C,1'b0} + CSA_S < 0
=> {CSA_C, b} + CSA_S < 0
=> -{CSA_C, b} - CSA_S > 0
=> -{CSA_C, b} > CSA_S
=> {~CSA_C, ~b} + 1'b1 > CSA_S
case1: 
~CSA_C > CSA_S[MSB:LSB+1]
case2:
~CSA_C == CSA_S[MSB:LSB+1]
~b + 1'b1 > CSA_S[LSB]
```

| ~b | CSA_S[LSB] | ~b + 1'b1 > CSA_S[LSB] | ~b | ~CSA_S[LSB] |
| ---- | ---- | ---- | ---- | ---- |
| 0 | 0 | 1 | 0 | 1 |
| 0 | 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 | 1 |
| 1 | 1 | 1 | 1 | 0 |

```verilog
assign f2_carry[MAC_LSB] = f2_eff_sub & ~f2_align_sticky;
// Sign detection
// note: without subnormal case, qualify [105:0] and gt2 is enough
assign f2_complement = f2_eff_sub & ((~f2_carry[MAC_MSB:MAC_LSB+1] > f2_sum[MAC_MSB:MAC_LSB+1]));

assign f2_complement = f2_eff_sub & ((~f2_carry[MAC_MSB:MAC_LSB+1] > f2_sum[MAC_MSB:MAC_LSB+1]) | ((~f2_carry[MAC_MSB:MAC_LSB+1] == f2_sum[MAC_MSB:MAC_LSB+1]) & ~f2_carry[MAC_LSB] & ~f2_sum[MAC_LSB]));
```

