# prerequisite
[[f16dsu]]

# block_diagram
## rough
- p1_rdone
	- dsu generates r_s and r_c
	- r = r_s + r_c
- p1_qdone
	- dsu generates q0 and q0_minus
	- sticky from r
	- sticky from q_r
### P2_S1
1. dsu generate q0 and q1
2. generate r
3. generate r_sign
4. generate sticky from r

### P2_S2
1. generate q by r_sign
2. generate arith_exp by  
3. generate sticky from q

![[f16div_uarch_rough.svg]]

## detail

![[f16div_uarch_detail.svg]]

## dz_exception
[[de/fpu/spec/IEEE754-2019.pdf#page=54&selection=4,0,7,1|IEEE754-2019, page 54]]
![[Pasted image 20240408233252.png]]


## arith_exp
![[f16div_exp.svg]]
## frd_rne_correction
### standard_rounding_algorithm
![[f16div_frd_rne_correction_standard_rouding_algorithm.svg]]
### yz_algorithm

1. rounding前如果計算太過複雜，則需要yz_algorithm
2. rounding前如果就有ovf，則需要yz_algorithm

![[f16div_frd_rne_correction_yz_algorithm.svg]]