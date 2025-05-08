# prerequisite

[[f16dsu]]

# block_diagram
## rough

![[f16div_uarch_rough.svg]]

- p0
	- x
- p1_rdone
	- dsu generates r_s and r_c
	- sqrt_arith_exp
	- div_arith_exp
- p1_qdone
	- dsu generates q0 and q0_minus
	- r = r_s + r_c
	- remainder sign bit to select q0 or q0_minus
	- remainder sticky
	- adjust arith_exp (minus 1)
	- adjust quotient (left shift 1b)
	- subnorm detect
	- quotient right shift
	- quotient right shift sticky
- p2
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