# prerequisite

[[f16dsu]]

# block_diagram
## rough

![[f16div_uarch_rough.svg]]
- p0
	- d becomes 2>d>1 by using lzc and left barrel shift
		- d_arith_exp
	- x becomes 2>x>1 by using lzc and left barrel shift
		- x_arith_exp
- p1_rdone
	- dsu generates r_s and r_c
	- sqrt_arith_exp = (x_arith_exp + 2) >> 1
	- div_arith_exp = x_arith_exp - d_arith_exp
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
## dz_exception
[[de/fpu/spec/IEEE754-2019.pdf#page=54&selection=4,0,7,1|IEEE754-2019, page 54]]
![[Pasted image 20240408233252.png]]


## arith_exp
![[f16div_exp.svg]]
## frd_rne_correction
### standard_rounding_algorithm
![[f16div_frd_rne_correction_standard_rouding_algorithm.svg]]
### yz_algorithm

1. rounding前如果【R】有其他計算，則需要yz_algorithm
2. rounding前如果就有ovf，則需要yz_algorithm

![[f16div_frd_rne_correction_yz_algorithm.svg]]