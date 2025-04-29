# prerequisite
[[f16dsu]]

# block_diagram
## rough

![[f16div_uarch_rough.svg]]

## detail

![[f16div_uarch_detail.svg]]

## dz_exception
[[de/fpu/spec/IEEE754-2019.pdf#page=54&selection=4,0,7,1|IEEE754-2019, page 54]]
![[Pasted image 20240408233252.png]]
## P2_ST
### P2_S0
1. dsu generate r0 and r1
2. generate exp

### P2_S1
1. dsu generate q0 and q1
2. generate r
3. generate r_sign
4. generate sticky from r

### P2_S2
1. generate q by r_sign
2. generate arith_exp by  
3. generate sticky from q

## arith_exp_subnorm_detect
![[f16div_exp.svg]]
![[f16div_frd_rne_correction.svg]]