 [直观理解SRT除法，从不恢复余数除法开始！ - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/353010136)
[基4 SRT除法器_qds表pd图-CSDN博客](https://blog.csdn.net/zhouxuanyuye/article/details/119514007)
[一种基于SRT－8算法的SIMD浮点除法器的设计与实现＊_参考网 (fx361.com)](https://m.fx361.com/news/2014/0323/21598588.html)
[Index of /digital_arithmetic/files (ucla.edu)](https://web.cs.ucla.edu/digital_arithmetic/files/)
[我校计算机学院（软件学院）周建涛教授课题组在国际顶级期刊发表研究成果-内蒙古大学新闻网 (imu.edu.cn)](https://news.imu.edu.cn/info/1153/41081.htm)
[Low-Power Radix-4 Combined Division and Square Root (dtu.dk)](https://www.imm.dtu.dk/~alna/pubs/nl99p02/nl99p02.html)

此爲用於floating point的DSU, 所以會以floating point的特性去設計
# floating_point_concept
通常除法器的處理會先將divisor和dividend轉成正數處理
1. 根據radix4_srt_div_algirthm,第一筆pr必爲S00.1XXXX,且S為0,所以第一個rq必爲正數
2. 因爲divisor和dividend為正數所以remainder也必爲正數,如果remainder負數則quotient要減1
# redundant_conversion
[[(RQ)on_the_fly_redundant_conversion.pdf#page=9&selection=8,0,8,11|(RQ)on_the_fly_redundant_conversion, page 9]]

```C++
Q[j+1] = Q[j] + q(j+1)*r**(-(j+1)) when q(j+1) >= 0
Q[j+1] = Q[j] -r**(-(j)) + (r - abs(q(j+1)))*r**(-(j+1)) when q(j+1) < 0

Example: radix-4, r = 4
Ex1: 0.-2 = 0 - 2/4 = -1/2
Q[1] = 0 -1/4**(0) + (1/4-abs(-2))*r**(-1) = -1/2

Ex2: 0.-1 = 0 - 1/4 = -1/4
Q[1] = 0 -1/4**(0) + (1/4-abs(-1))*r**(-1) = -1/4

Ex3: 0.0 = 0
Q[1] = 0 + 0*(4)**(-1) = 0

Ex4: 0.1 = 0 + 1/4 = 1/4
Q[1] = 0 + 1*(4)**(-1) = 1/4

Ex5: 0.2 = 0 + 2/4 = 1/2
Q[1] = 0 + 2*(4)**(-1) = 1/2
```
# f16dsu_radix4_srt_div
## sign
[Signed zero - Wikipedia](https://en.wikipedia.org/wiki/Signed_zero)
[[de/fpu/ref_f16mac/code_old_kv/VFPU/FP_design_spec_Larry/FDIV/Study/computer-arithmetic-algorithms-2nd-edition-Behrooz-Parhami.pdf#page=289&selection=338,0,346,0|computer-arithmetic-algorithms-2nd-edition-Behrooz-Parhami, page 289]]
![[Pasted image 20240402171635.png]]

## uarch

> [!PDF|yellow] [[Low Power Division and Square.pdf#page=49&selection=9,13,36,19&color=yellow|Low Power Division and Square, p.49]]
> > Both d and x are normalized in [0.5, 1) and x < d for division, while x is normalized in [0.25, 1) for square root.
> 
> 

![[f16dsu_radix4_srt_div.svg]]
![[f16dsu_radix4_srt_div_uarch.svg]]
## algorithm

radix4_srt_div_algorithm

1. [[(DIV)Digit Selection for SRT Division and Square Root.pdf#page=1&selection=0,0,1,28|(DIV)Digit Selection for SRT Division and Square Root, page 1]]
2. [[(SQR)Radix-4 Square Root Without Initial PLA.pdf#page=1|(SQR)Radix-4 Square Root Without Initial PLA, p.1016]]
3. [[radix4_srt_div.xlsx]]
## format

PR bitwidth = sign bit + PR integral + PR fraction + extra bit

original PR bitwidth: 16 (嚴格正確)
4. sign bit: 1
5. PR integral: 2
6. PR fraction: 11 + 1 (Rounding)
7. extra bit: 1 (可能是給square root??)

revised PR bitwidth: 14 (最佳正確)
8. sign bit: 1
9. PR integral: 2
10. PR fraction: 11
11. extra bit: 0
	1. 滿足PR bitwidth == RQST bitwidth + 1,不滿足則要將PR補0直到滿足這個條件


![[(SRT)INCORPORATING MULTIPLICATION INTO DIGIT- RECURRENCE DIVISION AND THE SQUARE ROOT.pdf#page=116&rect=98,352,533,563|(SRT)INCORPORATING MULTIPLICATION INTO DIGIT- RECURRENCE DIVISION AND THE SQUARE ROOT, p.101]]

## truncate_deviation

ref: https://www.righto.com/2024/12/this-die-photo-of-pentium-shows.html

borrow_in可以有效減少truncate所造成的誤差

![[(SRT)INCORPORATING MULTIPLICATION INTO DIGIT- RECURRENCE DIVISION AND THE SQUARE ROOT.pdf#page=86&rect=186,276,454,493|(SRT)INCORPORATING MULTIPLICATION INTO DIGIT- RECURRENCE DIVISION AND THE SQUARE ROOT, p.71]]

![[truncate_deviation.svg]]
## valid_pd_diagrm

合法的PD圖是兩條綫之間至少要有一個點

![[valid_pd_diagram.svg]]

## pd_diagram
![[Pasted image 20240326214207.png]]
![[Pasted image 20240326214342.png]]
![[Pasted image 20240326214426.png]]
![[Pasted image 20240326214614.png]]

# radix4_srt_sqr_algorithm
[[Low Power Division and Square.pdf#page=48&selection=105,0,108,5|Low Power Division and Square, page 48]]


## algorithm

## pd_diagram

# archive
## radix2_srt
[【HDL系列】除法器(3)——基2 SRT算法-CSDN博客](https://blog.csdn.net/zhouxuanyuye/article/details/109436358)
## pentium_division_flaw
[The Pentium Divison Flaw - Chapter 3 (daviddeley.com)](https://daviddeley.com/pentbug/pentbug3.htm)
![[Pasted image 20240320191739.png]]
