# terminology

- byte: 8bits
- half word: 16 bits
- single word: 32 bits
- double word: 64 bits
- quad word: 128 bits
# nan

- qnan
	- exp_all1 & signal_bit
- snan
	- exp_all1 & ~signal_bit & ~frac_all0
- nan
	- exp_all1 & ~frac_all0
	- qnan | snan

# exception

- ref: [[de/fpu/spec/IEEE754-2019.pdf#page=52&selection=4,0,8,2&color=important|7. Exceptions and default exception handling 7.]]

| exception | remark                     |
| --------- | -------------------------- |
| nv        | iNValid exception          |
| dz        | Division by Zero exception |
| ovf       | OVerFlow exception         |
| udf       | UnDerFlow exception        |
| nx        | iNeXact exception          |

# cvt_arch
- ref: [[de/fpu/ref_f16mis/FMIS_design_spec_v0.5.pptx|FMIS_design_spec_v0.5]]

![[fmis_uarch.svg|1400]]

# rounding_step

| convert                        | rounding step       | method                                                            |
| ------------------------------ | ------------------- | ----------------------------------------------------------------- |
| negative float to negative int | rounding then 2comp | **2comp_rounding_algorithm** based on standard rounding algorithm |
| positive float to positive int | rounding            | standard rounding algorithm                                       |
| positive int to positive float | rounding            | standard rounding algorithm                                       |
| negative int to negative float | 2comp then rounding | 2comp then standard rounding algorithm                            |

## 2comp_rounding_algorithm

2comp_rounding_algorithm: fast_negf2negi_rounding_algorithm

必須配合[[f32mis#rounding_inc_algorithm|rounding_inc_algorithm]]

- ref: [[2comp_rounding.xlsx]]

![[Pasted image 20250524204004.png]]

## rounding

rounding的負數處理方式: 都要先轉換成正數再去判斷是否要rouding_inc

| Sign | L   | R   | S   | RNE | RTZ | RDN | RUP | RMM | ROD |
| ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0    | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1   |
| 0    | 0   | 0   | 1   | 0   | 0   | 0   | 1   | 0   | 1   |
| 0    | 0   | 1   | 0   | 0   | 0   | 0   | 1   | 1   | 1   |
| 0    | 0   | 1   | 1   | 1   | 0   | 0   | 1   | 1   | 1   |
| 0    | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   |
| 0    | 1   | 0   | 1   | 0   | 0   | 0   | 1   | 0   | 0   |
| 0    | 1   | 1   | 0   | 1   | 0   | 0   | 1   | 1   | 0   |
| 0    | 1   | 1   | 1   | 1   | 0   | 0   | 1   | 1   | 0   |
| 1    | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 1   |
| 1    | 0   | 0   | 1   | 0   | 0   | 1   | 0   | 0   | 1   |
| 1    | 0   | 1   | 0   | 0   | 0   | 1   | 0   | 1   | 1   |
| 1    | 0   | 1   | 1   | 1   | 0   | 1   | 0   | 1   | 1   |
| 1    | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   |
| 1    | 1   | 0   | 1   | 0   | 0   | 1   | 0   | 0   | 0   |
| 1    | 1   | 1   | 0   | 1   | 0   | 1   | 0   | 1   | 0   |
| 1    | 1   | 1   | 1   | 1   | 0   | 1   | 0   | 1   | 0   |

 ![[Pasted image 20250515000243.png|800]]

## rounding_rne

![[Pasted image 20250625161903.png]]

## rounding_algorithm

rounding的負數處理方式: 都要先轉換成正數再去判斷是否要rouding_inc

| rounding mode                                 | rounding inc     |
| --------------------------------------------- | ---------------- |
| RNE (Round to Nearest, ties to Even)          | R & (L \| S)     |
| RDN (Round DowN)                              | Sign & (R \| S)  |
| RUP (Round UP)                                | ~Sign & (R \| S) |
| RMM (Round to nearest, ties to Max Magnitude) | R                |
| RTZ (Round Towards Zero)                      | 0                |
| ROD (Round towards ODd)                       | ~L & (R \| S)    |

| udf/ovf/zero special case |                                      |
| ------------------------- | ------------------------------------ |
| rn                        | RNE \| RMM                           |
| ri                        | (~Sign & RUP) \| (Sign & RDN)        |
| rz                        | RTZ \| (~Sign & RDN) \| (Sign & RUP) |

## rounding_inc_algorithm

![[f16div_frd_rne_correction_rounding_inc_algorithm.svg]]

# IEEE754_2019

P.S: IEEE754中如果只有提到NaN但沒有提到是否為SNaN還是QNaN就表示為宇集合

- CMP snan
![[de/fpu/spec/IEEE754-2019.pdf#page=44&rect=88,500,527,553|IEEE754-2019, p.43]]![[de/fpu/spec/IEEE754-2019.pdf#page=44&rect=85,238,524,435|IEEE754-2019, p.43]]
- CMP ne
![[de/fpu/spec/IEEE754-2019.pdf#page=44&rect=306,353,517,378|IEEE754-2019, p.43]]
- CMP unordered
![[de/fpu/spec/IEEE754-2019.pdf#page=44&rect=86,612,530,667|IEEE754-2019, p.43]]
- MAX_MIN
![[de/fpu/spec/IEEE754-2019.pdf#page=70&rect=126,302,526,334|IEEE754-2019, p.69]]
- CLASS
![[de/fpu/spec/IEEE754-2019.pdf#page=39&rect=90,525,523,701|IEEE754-2019, p.38]]


## nv_for_p2i

- There is the invalid exception for floating-point to integer

![[de/fpu/spec/IEEE754-2019.pdf#page=53&rect=123,219,526,252|IEEE754-2019, p.52]]

# lzc_optimization

![[lzc_optimization.svg | 1000]]