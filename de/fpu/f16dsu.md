 [直观理解SRT除法，从不恢复余数除法开始！ - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/353010136)
[基4 SRT除法器_qds表pd图-CSDN博客](https://blog.csdn.net/zhouxuanyuye/article/details/119514007)
[一种基于SRT－8算法的SIMD浮点除法器的设计与实现＊_参考网 (fx361.com)](https://m.fx361.com/news/2014/0323/21598588.html)
[Index of /digital_arithmetic/files (ucla.edu)](https://web.cs.ucla.edu/digital_arithmetic/files/)
[我校计算机学院（软件学院）周建涛教授课题组在国际顶级期刊发表研究成果-内蒙古大学新闻网 (imu.edu.cn)](https://news.imu.edu.cn/info/1153/41081.htm)
[Low-Power Radix-4 Combined Division and Square Root (dtu.dk)](https://www.imm.dtu.dk/~alna/pubs/nl99p02/nl99p02.html)

此爲用於floating point的DSU, 所以會以floating point的特性去設計
# floating_point_concept
通常除法器的處理會先將divisor和dividend轉成正數處理
1. 根據radix4_srt_div_algirthm,第一筆pr必爲S001.XXX,且S為0,所以第一個rq必爲正數
2. 因爲divisor和dividend為正數所以remainder也必爲正數,如果remainder負數則quotient要減1
# on_the_fly_redundant_conversion
[[(RQ)on_the_fly_redundant_conversion.pdf#page=9&selection=8,0,8,11|(RQ)on_the_fly_redundant_conversion, page 9]]

$qm(j)=q(j)-4^{-j}$
- 可以發現qm小於q(j)，永遠差1
- $qm=q-1$

![[(RQ)on_the_fly_redundant_conversion.pdf#page=10&rect=32,101,271,354|(RQ)on_the_fly_redundant_conversion, p.10|500]]

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
# dsu
## sign

[Signed zero - Wikipedia](https://en.wikipedia.org/wiki/Signed_zero)

![[de/fpu/ref_f16mac/code_old_kv/VFPU/FP_design_spec_Larry/FDIV/Study/computer-arithmetic-algorithms-2nd-edition-Behrooz-Parhami.pdf#page=289&rect=116,274,478,361|computer-arithmetic-algorithms-2nd-edition-Behrooz-Parhami, p.289]]
注意:
- sign(q) = sign(z) ^ sign(d)
- 找到一組其實就足夠知道其他種組合了，所以集中目標找
	- sign(abs(z)) = sign(abs(d)) = 0
實作: 只找q不找s
- 因爲sign(q) = sign(z) ^ sign(d)
- 預設sign(z) = sign(d)
- 所以sign(s) 必爲 0
- 如果sign(s) 經過處理之後是 1，則q - 1, 用SRT則爲qm
- 如果sign(s) 經過處理之後是 0，則q, 用SRT則爲q
## bitwidth
![[f16dsu_radix4_srt_bitwidth.svg]]

針對radix4而言

- q_bitwidth = 2 + f(din + 1), f(din + 1)要2的倍數，如果沒有則要補
- q_bitwidth = 2 + (din + 1) + (din + 1) % 2
- r_bitwidth = 1 + 3 + (din + 1) + (din + 1) % 2
- cnt = q_bitwidth/2 - 1
	- DIV cnt range: 0 to  q_bitwidth/2 - 1
	- SQRT cnt range: 1 to  q_bitwidth/2 - 1
	- ex:
		- din(f16): 11 (1+10)
			- DIV cnt=\[0:6\]
			- SQRT cnt=\[1:6\]
		- din(f32): 24 (1+23)
			- DIV cnt=\[0:13\]
			- SQRT cnt=\[1:13\]
		- din(f64): 53 (1+52)
			- DIV cnt=\[0:27\]
			- SQRT cnt=\[1:27\]

![[(SRT)INCORPORATING MULTIPLICATION INTO DIGIT- RECURRENCE DIVISION AND THE SQUARE ROOT.pdf#page=116&rect=98,352,533,563|(SRT)INCORPORATING MULTIPLICATION INTO DIGIT- RECURRENCE DIVISION AND THE SQUARE ROOT, p.101|500]]
![[(DSU)Low Latency Floating-Point Division and Square.pdf#page=5&rect=44,530,294,646|(DSU)Low Latency Floating-Point Division and Square, p.5|500]]

## uarch

注意：用SRT不建議找餘數，餘數在SRT中不好找

ref: [[(DSU)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root.pdf#page=2&selection=2,0,8,37|(SQRT)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root, p.2]]
ref: https://www.youtube.com/watch?v=51nnhi3Mcfk

 $remainder\ recurrence:r(j)=radix*r(j-1)+f(j)$
- $r:remainder$
- $r(j):partial\ remainder\ at\ j'th\ iteratrion$
- $j=1,2,3$
- $f(j)隨著DIV和SQRT改變$
### div_uarch

$q = x / d + remainder$
- $q: quotient$
	- $q_{1}.q_{2}q_{3}$
- $x: dividend$
- $d: divisor$
- $residual\ recurrence:r(j)=radix*r(j-1)-q_{j}*d$
- $residual\ recurrence\ with\ radix\ 4:r(j)=4*r(j-1)-q_{j}*d$
	- $digit\ set\ (q_{j})\ is \ [-2,-1,0,1,2]$
	- $initialize$
		- $2>d>=1$
		- $2>x>=1$
		- $2>q>0.5$
		- $2d/3>4*r(j-1)>=-2d/3$
		- $x=4*r(0)$
		- $cnt\ init=0$
		- $q\ init=0$
		- $qm\ init=0$
	- $rqst\_pd$
		- $rqst\_pd\ is\ part\ of\ d\ which\ is\ 1.ddd$
		- $ddd$
	- $rqst\_pr$
		-  $rqst\_pr\ is\ part\ of\ 4*r(j-1)\ which\ is\ Srrr.rrr$
		- $Srrr.rrr$
	- $implementation$
		![[(DSU)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root.pdf#page=3&rect=329,522,498,594|(DSU)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root, p.3|500]]
		![[(DSU)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root.pdf#page=5&rect=58,142,217,273|(DSU)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root, p.5|500]]

![[f16dsu_radix4_srt_div.svg]]

![[f16dsu_radix4_srt_div_uarch.svg]]

#### truncate_but_borrowin

borrowin可以有效減少truncate所造成的誤差
![[(SRT)INCORPORATING MULTIPLICATION INTO DIGIT- RECURRENCE DIVISION AND THE SQUARE ROOT.pdf#page=86&rect=186,276,454,493|(SRT)INCORPORATING MULTIPLICATION INTO DIGIT- RECURRENCE DIVISION AND THE SQUARE ROOT, p.71|500]]

![[truncate_deviation.svg]]

#### pd_chart

合法的PD圖是兩條綫之間至少要有一個點

![[valid_pd_diagram.svg]]

### sqrt_uarch

$q = x^{1/2}$
- $x: radicand$
- $q: root$
	- $q_{0}.q_{1}q_{2}q_{3}$
	- $q_{0}=1$
- $residual\ recurrence:r(j)=radix*r(j-1)-q_{j}(2*q(j-1)+radix^{-j}*q_{j})$
- $residual\ recurrence\ with\ radix\ 4:r(j)=4*r(j-1)-q_{j}(2*q(j-1)+4^{-j}*q_{j})$
	- $digit\ set\ (q_{j})\ is \ [-2,-1,0,1,2]$
	- $initialize$
		- $exp\ has\ to\ be\ even$
		- $1>x>=0.25$
			- $if\ exp\ is\ even:\ 1>x>=0.5$
			- $if\ exp\ is\ odd:\ 1>x>=0.25$
			![[(DSU)Low Latency Floating-Point Division and Square.pdf#page=4&rect=308,400,574,734|(DSU)Low Latency Floating-Point Division and Square, p.4|500]]
		- $1>d>=0.5$
			- $2>2*d=(2*q(j-1)+4^{-j}*q_{j}):=2*q(j-1)>=1$
			- $1>d=(q(j-1)+4^{-j}*q_{j}/2):=q(j-1)>=0.5$
		- $1>q>=0.5$
		- $4q/3>4*r(j-1)>=-4q/3$
		- $r(0)=x$
		- $4*r(1)=4*(r(0)-1)$
		- $cnt\ init=1$
		- $q\ init=1$
		- $qm\ init=0$
	- $rqst\_pd$
		- $rqst\_pd\ is\ part\ of\ q(j-1)\ which\ is\ 0.1ddd$
		- $rqst\_pd\ is\ part\ of\ 2*q(j-1)\ which\ is\ 1.ddd$
		- $ddd$
		![[(DSU)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root.pdf#page=8&rect=312,620,567,674|(SQRT)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root, p.8|500]]
		- $if\ j=1$
			- $ddd=101$
		- $if\ j>1\ and\ q(j-1)==1.0$
			- $ddd=111$
	- $rqst\_pr$
		- $rqst\_r\ is\ part\ of\ 4*r(j-1)\ which\ is\ Srrr.rrr$
		- $Srrr.rrr$
	- $implementation$
		![[(DSU)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root.pdf#page=4&rect=330,320,506,400|(DSU)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root, p.4|500]]
		![[(DSU)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root.pdf#page=5&rect=49,139,223,316|(DSU)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root, p.5|500]]
- $residual\ recurrence\ with\ radix\ 4\ by\ using\ on\ the\ fly\ conversion\ into\ conventional\ representation$
	- $r(j)=4*r(j-1)-q_{j}(2*q(j-1)+4^{-j}*q_{j})$
	- $r(j)=4*r(j-1)-X$
		- 帶入on-the-fly redundant conversion的公式
			- $qm(j)=q(j)-4^{-j}$

| $q_{j}$ | $OP$  | $X\ (form\ 1)$        | $X\ (form\ 2\ with\ j=1)$              | $X\ (form\ 2)$        |
| ------- | ----- | --------------------- | -------------------------------------- | --------------------- |
| $2$     | $sub$ | $4*q(j-1)+2^{-2*j+2}$ | $4*(q(0)+2^{-2})=4\{q(0),3'b010\}$     | $4\{q(j-1),3'b010\}$  |
| $1$     | $sub$ | $2*q(j-1)+2^{-2*j}$   | $2*(q(0)+2^{-3})=2\{q(0),3'b001\}$     | $2\{q(j-1),3'b001\}$  |
| $0$     | $n.a$ | $0$                   | $0$                                    | $0$                   |
| $-1$    | $add$ | $2*q(j-1)-2^{-2*j}$   | $2*(qm(0)+1-2^{-3})=2\{qm(0),3'b111\}$ | $2\{qm(j-1),3'b111\}$ |
| $-2$    | $add$ | $4*q(j-1)-2^{-2*j+2}$ | $4*(qm(0)+1+2^{-2})=4\{qm(0),3'b110\}$ | $4\{qm(j-1),3'b110\}$ |

- $q(j)=\sum_{j=0}^{j=n}q_{j}*radix^{-j}$
	- 當滿足以上的條件下可以使用這個公式（on-the-fly reductant conversion）
		![[(RQ)on_the_fly_redundant_conversion.pdf#page=10&rect=27,512,429,613|(RQ)on_the_fly_redundant_conversion, p.10|500]]
		![[(RQ)on_the_fly_redundant_conversion.pdf#page=9&rect=33,312,329,344|(RQ)on_the_fly_redundant_conversion, p.9|500]]
		![[(RQ)on_the_fly_redundant_conversion.pdf#page=9&rect=186,54,468,148|(RQ)on_the_fly_redundant_conversion, p.9|500]]
![[f16dsu_radix4_srt_sqrt.svg]]
![[f16dsu_radix4_srt_sqrt_uarch.svg]]

```verilog
module tb;
integer x;
real f;
    initial begin
        $display("r: %f", $sqrt(3));
        $display("r: %d", $sqrt(3));
        $display("r: %d", $floor($sqrt(3)));
        $finish;
    end
endmodule
```

```
r: 1.732051
r: 2
r: 1
```
### dsu_rqst

- main ref: [[(DSU)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root.pdf#page=2&selection=2,0,8,37|(SQRT)Unified_Digit_Selection_for_Radix-4_Recurrence_Division_and_Square_Root, p.2]]
- ref: [[Low Power Division and Square.pdf#page=48&selection=105,0,108,5|Low Power Division and Square, page 48]]
- ref: [[(SQR)Radix-4 Square Root Without Initial PLA.pdf#page=1|(SQR)Radix-4 Square Root Without Initial PLA, p.1016]]

![[Pasted image 20250416121717.png]]
![[Pasted image 20250416121743.png]]
## algorithm

radix4_srt_div_algorithm

1. [[(DIV)Digit Selection for SRT Division and Square Root.pdf#page=1&selection=0,0,1,28|(DIV)Digit Selection for SRT Division and Square Root, page 1]]
2. [[radix4_srt_div.xlsx]]

# pentium

- [The Pentium Divison Flaw - Chapter 3 (daviddeley.com)](https://daviddeley.com/pentbug/pentbug3.htm)
- https://www.righto.com/2024/12/this-die-photo-of-pentium-shows.html
# others

- https://projectf.io/posts/square-root-in-verilog/
- https://zhuanlan.zhihu.com/p/271133530

![[Pasted image 20250424141100.png]]